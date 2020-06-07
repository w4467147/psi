package io.finer.erp.jeecg.finance.service.impl;

import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import io.finer.erp.jeecg.finance.entity.FinReceivableCheck;
import io.finer.erp.jeecg.finance.entity.FinReceivableCheckEntry;
import io.finer.erp.jeecg.finance.mapper.FinReceivableCheckEntryMapper;
import io.finer.erp.jeecg.finance.mapper.FinReceivableCheckMapper;
import io.finer.erp.jeecg.finance.service.*;
import org.apache.shiro.SecurityUtils;
import org.jeecg.common.exception.JeecgBootException;
import org.jeecg.common.system.vo.LoginUser;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.io.Serializable;
import java.util.Collection;
import java.util.Date;
import java.util.List;

/**
 * @Description: 应收核销单
 * @Author: jeecg-boot
 * @Date:   2020-04-17
 * @Version: V1.0
 */
@Service
public class FinReceivableCheckServiceImpl extends ServiceImpl<FinReceivableCheckMapper, FinReceivableCheck> implements IFinReceivableCheckService {

	@Autowired
	private FinReceivableCheckMapper finReceivableCheckMapper;
	@Autowired
	private FinReceivableCheckEntryMapper finReceivableCheckEntryMapper;
	@Autowired
	private IFinReceivableService finReceivableService;
	@Autowired
	private IFinReceiptService finReceiptService;

	@Override
	@Transactional
	public void saveMain(FinReceivableCheck finReceivableCheck, List<FinReceivableCheckEntry> finReceivableCheckEntryList) {
		finReceivableCheckMapper.insert(finReceivableCheck);
		if(finReceivableCheckEntryList!=null && finReceivableCheckEntryList.size()>0) {
			for(FinReceivableCheckEntry entity:finReceivableCheckEntryList) {
				//外键设置
				entity.setMid(finReceivableCheck.getId());
				entity.setBillNo(finReceivableCheck.getBillNo());
				finReceivableCheckEntryMapper.insert(entity);
			}
		}
	}

	@Override
	@Transactional
	public void updateMain(FinReceivableCheck finReceivableCheck,List<FinReceivableCheckEntry> finReceivableCheckEntryList) {
		finReceivableCheckMapper.updateById(finReceivableCheck);
		
		//1.先删除子表数据
		finReceivableCheckEntryMapper.deleteByMainId(finReceivableCheck.getId());
		
		//2.子表数据重新插入
		if(finReceivableCheckEntryList!=null && finReceivableCheckEntryList.size()>0) {
			for(FinReceivableCheckEntry entity:finReceivableCheckEntryList) {
				//外键设置
				entity.setMid(finReceivableCheck.getId());
				entity.setBillNo(finReceivableCheck.getBillNo());
				finReceivableCheckEntryMapper.insert(entity);
			}
		}
	}

	@Override
	@Transactional
	public void delMain(String id) {
		finReceivableCheckEntryMapper.deleteByMainId(id);
		finReceivableCheckMapper.deleteById(id);
	}

	@Override
	@Transactional
	public void delBatchMain(Collection<? extends Serializable> idList) {
		for(Serializable id:idList) {
			finReceivableCheckEntryMapper.deleteByMainId(id.toString());
			finReceivableCheckMapper.deleteById(id);
		}
	}

	@Override
	@Transactional
	public void approve(String id) {
		FinReceivableCheck finReceivableCheck = finReceivableCheckMapper.selectById(id);
		if (finReceivableCheck == null) {
			throw new JeecgBootException(String.format("【ID：%s】应收核销单不存在！", id));
		}

		LoginUser sysUser = (LoginUser) SecurityUtils.getSubject().getPrincipal();
		finReceivableCheck.setApproverId(sysUser.getUsername());
		finReceivableCheck.setIsApproved(1);
		finReceivableCheck.setEffectiveTime(new Date());
		finReceivableCheck.setBillProcStatus("23");
		finReceivableCheckMapper.updateById(finReceivableCheck);

		List<FinReceivableCheckEntry> finReceivableCheckEntryList = finReceivableCheckEntryMapper.selectByMainId(finReceivableCheck.getId());
		for(FinReceivableCheckEntry entry:finReceivableCheckEntryList) {
			if (finReceivableCheck.getReceivableCheckType().equals("101") ) {
				if (entry.getCheckSide().equals("1")) {
					finReceivableService.checkAmt(entry.getSourceId(), entry.getAmt());
				} else {
					finReceiptService.checkAmt(entry.getSourceId(), entry.getAmt());
				}
			} else if (finReceivableCheck.getReceivableCheckType().equals("102") ) {
				//待扩充
			}
		}
	}

}
