package io.finer.erp.jeecg.finance.service.impl;

import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import io.finer.erp.jeecg.bas.service.IBasBizPeriodService;
import io.finer.erp.jeecg.bas.service.IBasMeasureUnitService;
import io.finer.erp.jeecg.finance.entity.FinPayable;
import io.finer.erp.jeecg.finance.entity.FinPayment;
import io.finer.erp.jeecg.finance.entity.FinPaymentEntry;
import io.finer.erp.jeecg.finance.mapper.FinPaymentEntryMapper;
import io.finer.erp.jeecg.finance.mapper.FinPaymentMapper;
import io.finer.erp.jeecg.finance.service.IFinPaymentService;
import io.finer.erp.jeecg.stock.entity.StkIoBill;
import io.finer.erp.jeecg.stock.entity.StkIoBillEntry;
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
 * @Description: 付款单
 * @Author: jeecg-boot
 * @Date:   2020-04-14
 * @Version: V1.0
 */
@Service
public class FinPaymentServiceImpl extends ServiceImpl<FinPaymentMapper, FinPayment> implements IFinPaymentService {

	@Autowired
	private FinPaymentMapper finPaymentMapper;
	@Autowired
	private FinPaymentEntryMapper finPaymentEntryMapper;
	@Autowired
	private IBasBizPeriodService basBizPeriodService;
	
	@Override
	@Transactional
	public void saveMain(FinPayment finPayment, List<FinPaymentEntry> finPaymentEntryList) {
		basBizPeriodService.validateBillDate(finPayment.getBillDate());
		finPaymentMapper.insert(finPayment);
		if(finPaymentEntryList!=null && finPaymentEntryList.size()>0) {
			for(FinPaymentEntry entity:finPaymentEntryList) {
				//外键设置
				entity.setMid(finPayment.getId());
				entity.setBillNo(finPayment.getBillNo());
				finPaymentEntryMapper.insert(entity);
			}
		}
	}

	@Override
	@Transactional
	public void updateMain(FinPayment finPayment,List<FinPaymentEntry> finPaymentEntryList) {
		basBizPeriodService.validateBillDate(finPayment.getBillDate());
		finPaymentMapper.updateById(finPayment);
		
		//1.先删除子表数据
		finPaymentEntryMapper.deleteByMainId(finPayment.getId());
		
		//2.子表数据重新插入
		if(finPaymentEntryList!=null && finPaymentEntryList.size()>0) {
			for(FinPaymentEntry entity:finPaymentEntryList) {
				//外键设置
				entity.setMid(finPayment.getId());
				entity.setBillNo(finPayment.getBillNo());
				finPaymentEntryMapper.insert(entity);
			}
		}
	}

	@Override
	@Transactional
	public void delMain(String id) {
		finPaymentEntryMapper.deleteByMainId(id);
		finPaymentMapper.deleteById(id);
	}

	@Override
	@Transactional
	public void delBatchMain(Collection<? extends Serializable> idList) {
		for(Serializable id:idList) {
			finPaymentEntryMapper.deleteByMainId(id.toString());
			finPaymentMapper.deleteById(id);
		}
	}

	@Override
	@Transactional
	public void approve(String id) {
		FinPayment finPayment = finPaymentMapper.selectById(id);
		if (finPayment == null) {
			throw new JeecgBootException(String.format("【ID：%s】付款单不存在！", id));
		}

		LoginUser sysUser = (LoginUser) SecurityUtils.getSubject().getPrincipal();
		finPayment.setApproverId(sysUser.getUsername());
		finPayment.setIsApproved(1);
		finPayment.setEffectiveTime(new Date());
		finPayment.setBillProcStatus("23");
		finPaymentMapper.updateById(finPayment);
	}

	@Override
	public boolean isApproved(Integer year, Integer month) {
		QueryWrapper<FinPayment> queryWrapper = new QueryWrapper<>();
		queryWrapper.apply("YEAR(bill_date) = {0} AND MONTH(bill_date) = {1}", year, month);
		queryWrapper.eq("is_closed", 0);
		queryWrapper.eq("is_voided", 0);
		queryWrapper.eq("is_approved", 0);
		return finPaymentMapper.selectCount(queryWrapper) == 0;
	}

	@Override
	public BigDecimal getUncheckedAmt(String id) {
		FinPayment finPayment = getById(id);
		return finPayment != null ? finPayment.getUncheckedAmt() : null;
	}

	@Override
	@Transactional
	public void checkAmt(String id, BigDecimal amt) {
		FinPayment finPayment = getById(id);
		if (finPayment == null) {
			throw new JeecgBootException(String.format("【ID：%s】付款单不存在！", id));
		}

		BigDecimal checkedAmt = finPayment.getCheckedAmt().add(amt);
		if (finPayment.getAmt().compareTo(checkedAmt) < 0 ) {
			throw new JeecgBootException(String.format("【单据号：%s】核销金额不能大于未核金额！",
					finPayment.getBillNo() ));
		}
		finPayment.setCheckedAmt(checkedAmt);
		updateById(finPayment);
	}

}
