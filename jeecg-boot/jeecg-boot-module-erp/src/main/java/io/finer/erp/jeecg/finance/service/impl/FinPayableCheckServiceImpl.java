package io.finer.erp.jeecg.finance.service.impl;

import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import io.finer.erp.jeecg.finance.entity.FinPayableCheck;
import io.finer.erp.jeecg.finance.entity.FinPayableCheckEntry;
import io.finer.erp.jeecg.finance.mapper.FinPayableCheckEntryMapper;
import io.finer.erp.jeecg.finance.mapper.FinPayableCheckMapper;
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
 * @Description: 往来核销单
 * @Author: jeecg-boot
 * @Date:   2020-04-17
 * @Version: V1.0
 */
@Service
public class FinPayableCheckServiceImpl extends ServiceImpl<FinPayableCheckMapper, FinPayableCheck> implements IFinPayableCheckService {

	@Autowired
	private FinPayableCheckMapper finPayableCheckMapper;
	@Autowired
	private FinPayableCheckEntryMapper finPayableCheckEntryMapper;
	@Autowired
	private IFinPayableService finPayableService;
	@Autowired
	private IFinPaymentService finPaymentService;

	@Override
	@Transactional
	public void saveMain(FinPayableCheck finPayableCheck, List<FinPayableCheckEntry> finPayableCheckEntryList) {
		finPayableCheckMapper.insert(finPayableCheck);
		if(finPayableCheckEntryList!=null && finPayableCheckEntryList.size()>0) {
			for(FinPayableCheckEntry entity:finPayableCheckEntryList) {
				//外键设置
				entity.setMid(finPayableCheck.getId());
				entity.setBillNo(finPayableCheck.getBillNo());
				finPayableCheckEntryMapper.insert(entity);
			}
		}
	}

	@Override
	@Transactional
	public void updateMain(FinPayableCheck finPayableCheck,List<FinPayableCheckEntry> finPayableCheckEntryList) {
		finPayableCheckMapper.updateById(finPayableCheck);
		
		//1.先删除子表数据
		finPayableCheckEntryMapper.deleteByMainId(finPayableCheck.getId());
		
		//2.子表数据重新插入
		if(finPayableCheckEntryList!=null && finPayableCheckEntryList.size()>0) {
			for(FinPayableCheckEntry entity:finPayableCheckEntryList) {
				//外键设置
				entity.setMid(finPayableCheck.getId());
				entity.setBillNo(finPayableCheck.getBillNo());
				finPayableCheckEntryMapper.insert(entity);
			}
		}
	}

	@Override
	@Transactional
	public void delMain(String id) {
		finPayableCheckEntryMapper.deleteByMainId(id);
		finPayableCheckMapper.deleteById(id);
	}

	@Override
	@Transactional
	public void delBatchMain(Collection<? extends Serializable> idList) {
		for(Serializable id:idList) {
			finPayableCheckEntryMapper.deleteByMainId(id.toString());
			finPayableCheckMapper.deleteById(id);
		}
	}

	@Override
	@Transactional
	public void approve(String id) {
		FinPayableCheck finPayableCheck = finPayableCheckMapper.selectById(id);
		if (finPayableCheck == null) {
			throw new JeecgBootException(String.format("【ID：%s】应付核销单不存在！", id));
		}

		LoginUser sysUser = (LoginUser) SecurityUtils.getSubject().getPrincipal();
		finPayableCheck.setApproverId(sysUser.getUsername());
		finPayableCheck.setIsApproved(1);
		finPayableCheck.setEffectiveTime(new Date());
		finPayableCheck.setBillProcStatus("23");
		finPayableCheckMapper.updateById(finPayableCheck);

		List<FinPayableCheckEntry> finPayableCheckEntryList = finPayableCheckEntryMapper.selectByMainId(finPayableCheck.getId());
		for(FinPayableCheckEntry entry:finPayableCheckEntryList) {
			if (finPayableCheck.getPayableCheckType().equals("201") ) {
				if (entry.getCheckSide().equals("1")) {
					finPayableService.checkAmt(entry.getSourceId(), entry.getAmt());
				} else {
					finPaymentService.checkAmt(entry.getSourceId(), entry.getAmt());
				}
			} else if (finPayableCheck.getPayableCheckType().equals("202") ) {
				//待扩充
			}
		}
	}

}
