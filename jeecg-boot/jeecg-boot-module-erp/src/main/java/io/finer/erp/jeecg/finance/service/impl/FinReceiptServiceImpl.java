package io.finer.erp.jeecg.finance.service.impl;

import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import io.finer.erp.jeecg.bas.service.IBasBizPeriodService;
import io.finer.erp.jeecg.finance.entity.FinPayment;
import io.finer.erp.jeecg.finance.entity.FinReceipt;
import io.finer.erp.jeecg.finance.entity.FinReceiptEntry;
import io.finer.erp.jeecg.finance.mapper.FinReceiptEntryMapper;
import io.finer.erp.jeecg.finance.mapper.FinReceiptMapper;
import io.finer.erp.jeecg.finance.service.IFinReceiptService;
import org.apache.shiro.SecurityUtils;
import org.jeecg.common.exception.JeecgBootException;
import org.jeecg.common.system.vo.LoginUser;
import org.springframework.stereotype.Service;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.transaction.annotation.Transactional;
import java.io.Serializable;
import java.math.BigDecimal;
import java.util.Date;
import java.util.List;
import java.util.Collection;

/**
 * @Description: 收款单
 * @Author: jeecg-boot
 * @Date:   2020-04-30
 * @Version: V1.0
 */
@Service
public class FinReceiptServiceImpl extends ServiceImpl<FinReceiptMapper, FinReceipt> implements IFinReceiptService {

	@Autowired
	private FinReceiptMapper finReceiptMapper;
	@Autowired
	private FinReceiptEntryMapper finReceiptEntryMapper;
	@Autowired
	private IBasBizPeriodService basBizPeriodService;

	@Override
	@Transactional
	public void saveMain(FinReceipt finReceipt, List<FinReceiptEntry> finReceiptEntryList) {
		basBizPeriodService.validateBillDate(finReceipt.getBillDate());
		finReceiptMapper.insert(finReceipt);
		if(finReceiptEntryList!=null && finReceiptEntryList.size()>0) {
			for(FinReceiptEntry entity:finReceiptEntryList) {
				//外键设置
				entity.setMid(finReceipt.getId());
				entity.setBillNo(finReceipt.getBillNo());
				finReceiptEntryMapper.insert(entity);
			}
		}
	}

	@Override
	@Transactional
	public void updateMain(FinReceipt finReceipt,List<FinReceiptEntry> finReceiptEntryList) {
		basBizPeriodService.validateBillDate(finReceipt.getBillDate());
		finReceiptMapper.updateById(finReceipt);
		
		//1.先删除子表数据
		finReceiptEntryMapper.deleteByMainId(finReceipt.getId());
		
		//2.子表数据重新插入
		if(finReceiptEntryList!=null && finReceiptEntryList.size()>0) {
			for(FinReceiptEntry entity:finReceiptEntryList) {
				//外键设置
				entity.setMid(finReceipt.getId());
				entity.setBillNo(finReceipt.getBillNo());
				finReceiptEntryMapper.insert(entity);
			}
		}
	}

	@Override
	@Transactional
	public void delMain(String id) {
		finReceiptEntryMapper.deleteByMainId(id);
		finReceiptMapper.deleteById(id);
	}

	@Override
	@Transactional
	public void delBatchMain(Collection<? extends Serializable> idList) {
		for(Serializable id:idList) {
			finReceiptEntryMapper.deleteByMainId(id.toString());
			finReceiptMapper.deleteById(id);
		}
	}

	@Override
	@Transactional
	public void approve(String id) {
		FinReceipt finReceipt = finReceiptMapper.selectById(id);
		if (finReceipt == null) {
			throw new JeecgBootException(String.format("【ID：%s】收款单不存在！", id));
		}

		LoginUser sysUser = (LoginUser) SecurityUtils.getSubject().getPrincipal();
		finReceipt.setApproverId(sysUser.getUsername());
		finReceipt.setIsApproved(1);
		finReceipt.setEffectiveTime(new Date());
		finReceipt.setBillProcStatus("23");
		finReceiptMapper.updateById(finReceipt);
	}

	@Override
	public boolean isApproved(Integer year, Integer month) {
		QueryWrapper<FinReceipt> queryWrapper = new QueryWrapper<>();
		queryWrapper.apply("YEAR(bill_date) = {0} AND MONTH(bill_date) = {1}", year, month);
		queryWrapper.eq("is_closed", 0);
		queryWrapper.eq("is_voided", 0);
		queryWrapper.eq("is_approved", 0);
		return finReceiptMapper.selectCount(queryWrapper) == 0;
	}

	@Override
	public BigDecimal getUncheckedAmt(String id) {
		FinReceipt finReceipt = getById(id);
		return finReceipt != null ? finReceipt.getUncheckedAmt() : null;
	}

	@Override
	@Transactional
	public void checkAmt(String id, BigDecimal amt) {
		FinReceipt finReceipt = getById(id);
		if (finReceipt == null) {
			throw new JeecgBootException(String.format("【ID：%s】收款单不存在！", id));
		}

		BigDecimal checkedAmt = finReceipt.getCheckedAmt().add(amt);
		if (finReceipt.getAmt().compareTo(checkedAmt) < 0 ) {
			throw new JeecgBootException(String.format("【单据号：%s】核销金额不能大于未核金额！", finReceipt.getBillNo() ));
		}
		finReceipt.setCheckedAmt(checkedAmt);
		updateById(finReceipt);
	}
}
