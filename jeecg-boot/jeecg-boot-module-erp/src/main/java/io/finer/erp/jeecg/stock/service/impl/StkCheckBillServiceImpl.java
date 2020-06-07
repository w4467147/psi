package io.finer.erp.jeecg.stock.service.impl;

import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import io.finer.erp.jeecg.bas.service.IBasBizPeriodService;
import io.finer.erp.jeecg.finance.entity.FinPayment;
import io.finer.erp.jeecg.stock.entity.StkCheckBill;
import io.finer.erp.jeecg.stock.entity.StkCheckBillEntry;
import io.finer.erp.jeecg.stock.entity.StkIoBill;
import io.finer.erp.jeecg.stock.entity.StkIoBillEntry;
import io.finer.erp.jeecg.stock.mapper.StkCheckBillEntryMapper;
import io.finer.erp.jeecg.stock.mapper.StkCheckBillMapper;
import io.finer.erp.jeecg.stock.service.IStkCheckBillService;
import io.finer.erp.jeecg.stock.service.IStkIoBillService;
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
 * @Description: 盘点卡
 * @Author: jeecg-boot
 * @Date:   2020-05-18
 * @Version: V1.0
 */
@Service
public class StkCheckBillServiceImpl extends ServiceImpl<StkCheckBillMapper, StkCheckBill> implements IStkCheckBillService {

	@Autowired
	private StkCheckBillMapper stkCheckBillMapper;
	@Autowired
	private StkCheckBillEntryMapper stkCheckBillEntryMapper;
	@Autowired
	private IStkIoBillService stkIoBillService;
	@Autowired
	private IBasBizPeriodService basBizPeriodService;

	@Override
	@Transactional
	public void saveMain(StkCheckBill stkCheckBill, List<StkCheckBillEntry> stkCheckBillEntryList) {
		basBizPeriodService.validateBillDate(stkCheckBill.getBillDate());
		stkCheckBillMapper.insert(stkCheckBill);
		if(stkCheckBillEntryList!=null && stkCheckBillEntryList.size()>0) {
			for(StkCheckBillEntry entity:stkCheckBillEntryList) {
				//外键设置
				entity.setMid(stkCheckBill.getId());
				entity.setBillNo(stkCheckBill.getBillNo());
				stkCheckBillEntryMapper.insert(entity);
			}
		}
	}

	@Override
	@Transactional
	public void updateMain(StkCheckBill stkCheckBill,List<StkCheckBillEntry> stkCheckBillEntryList) {
		basBizPeriodService.validateBillDate(stkCheckBill.getBillDate());
		stkCheckBillMapper.updateById(stkCheckBill);
		
		//1.先删除子表数据
		stkCheckBillEntryMapper.deleteByMainId(stkCheckBill.getId());
		
		//2.子表数据重新插入
		if(stkCheckBillEntryList!=null && stkCheckBillEntryList.size()>0) {
			for(StkCheckBillEntry entity:stkCheckBillEntryList) {
				//外键设置
				entity.setMid(stkCheckBill.getId());
				entity.setBillNo(stkCheckBill.getBillNo());
				stkCheckBillEntryMapper.insert(entity);
			}
		}
	}

	@Override
	@Transactional
	public void delMain(String id) {
		stkCheckBillEntryMapper.deleteByMainId(id);
		stkCheckBillMapper.deleteById(id);
	}

	@Override
	@Transactional
	public void delBatchMain(Collection<? extends Serializable> idList) {
		for(Serializable id:idList) {
			stkCheckBillEntryMapper.deleteByMainId(id.toString());
			stkCheckBillMapper.deleteById(id);
		}
	}

	@Override
	@Transactional
	public void approve(String id) {
		StkCheckBill bill = stkCheckBillMapper.selectById(id);
		if (bill == null) {
			throw new JeecgBootException(String.format("【ID：%s】库存盘点单不存在！", id));
		}

		LoginUser sysUser = (LoginUser) SecurityUtils.getSubject().getPrincipal();
		bill.setApproverId(sysUser.getUsername());
		bill.setIsApproved(1);
		bill.setEffectiveTime(new Date());
		bill.setBillProcStatus("23");
		stkCheckBillMapper.updateById(bill);

		List<StkCheckBillEntry> entryList = stkCheckBillEntryMapper.selectByMainId(bill.getId());
		boolean hasProfit = false;
		boolean hasLoss = false;
		for(StkCheckBillEntry entry:entryList) {
			if (!hasProfit) {
				hasProfit = entry.getProfitQty().compareTo(BigDecimal.ZERO) > 0;
			}
			if (!hasLoss) {
				hasLoss = entry.getProfitQty().compareTo(BigDecimal.ZERO) < 0;
			}
			if (hasProfit && hasLoss) {
				break;
			}
		}

		if(hasProfit) {
			stkIoBillService.createInBill(bill, entryList);
		}
		if(hasLoss) {
			stkIoBillService.createOutBill(bill, entryList);
		}
	}

	@Override
	public boolean isApproved(Integer year, Integer month) {
		QueryWrapper<StkCheckBill> queryWrapper = new QueryWrapper<>();
		queryWrapper.apply("YEAR(bill_date) = {0} AND MONTH(bill_date) = {1}", year, month);
		queryWrapper.eq("is_closed", 0);
		queryWrapper.eq("is_voided", 0);
		queryWrapper.eq("is_approved", 0);
		return stkCheckBillMapper.selectCount(queryWrapper) == 0;
	}

}
