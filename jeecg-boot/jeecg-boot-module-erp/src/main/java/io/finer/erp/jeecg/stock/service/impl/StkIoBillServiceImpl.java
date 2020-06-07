package io.finer.erp.jeecg.stock.service.impl;

import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import io.finer.erp.jeecg.bas.service.IBasBizPeriodService;
import io.finer.erp.jeecg.finance.entity.FinPayable;
import io.finer.erp.jeecg.finance.service.IFinPayableService;
import io.finer.erp.jeecg.finance.service.IFinReceivableService;
import io.finer.erp.jeecg.stock.entity.StkCheckBill;
import io.finer.erp.jeecg.stock.entity.StkCheckBillEntry;
import io.finer.erp.jeecg.stock.entity.StkIoBill;
import io.finer.erp.jeecg.stock.entity.StkIoBillEntry;
import io.finer.erp.jeecg.stock.mapper.StkIoBillEntryMapper;
import io.finer.erp.jeecg.stock.mapper.StkIoBillMapper;
import io.finer.erp.jeecg.stock.service.IStkInventoryService;
import io.finer.erp.jeecg.stock.service.IStkIoBillService;
import org.apache.shiro.SecurityUtils;
import org.jeecg.common.exception.JeecgBootException;
import org.jeecg.common.system.vo.LoginUser;
import org.jeecg.common.util.FillRuleUtil;
import org.springframework.stereotype.Service;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.transaction.annotation.Transactional;
import java.io.Serializable;
import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.Collection;

/**
 * @Description: 出入库单
 * @Author: jeecg-boot
 * @Date:   2020-03-31
 * @Version: V1.0
 */
@Service
public class StkIoBillServiceImpl extends ServiceImpl<StkIoBillMapper, StkIoBill> implements IStkIoBillService {

	@Autowired
	private StkIoBillMapper stkIoBillMapper;
	@Autowired
	private StkIoBillEntryMapper stkIoBillEntryMapper;
	@Autowired
	private IStkInventoryService stkInventoryService;
	@Autowired
	private IFinPayableService finPayableService;
	@Autowired
	private IFinReceivableService finReceivableService;
	@Autowired
	private IBasBizPeriodService basBizPeriodService;

	@Override
	@Transactional
	public void saveMain(StkIoBill stkIoBill, List<StkIoBillEntry> stkIoBillEntryList) {
		basBizPeriodService.validateBillDate(stkIoBill.getBillDate());
		stkIoBillMapper.insert(stkIoBill);
		if(stkIoBillEntryList!=null && stkIoBillEntryList.size()>0) {
			for(StkIoBillEntry entity:stkIoBillEntryList) {
				//外键设置
				entity.setMid(stkIoBill.getId());
				entity.setBillNo(stkIoBill.getBillNo());

				String supplierId = stkIoBill.getSupplierId();
				if (supplierId!=null && !supplierId.isEmpty()) {
					entity.setSupplierId(supplierId);
				}
				stkIoBillEntryMapper.insert(entity);
			}
		}
	}

	@Override
	@Transactional
	public void updateMain(StkIoBill stkIoBill,List<StkIoBillEntry> stkIoBillEntryList) {
		basBizPeriodService.validateBillDate(stkIoBill.getBillDate());
		stkIoBillMapper.updateById(stkIoBill);
		
		//1.先删除子表数据
		stkIoBillEntryMapper.deleteByMainId(stkIoBill.getId());
		
		//2.子表数据重新插入
		if(stkIoBillEntryList!=null && stkIoBillEntryList.size()>0) {
			for(StkIoBillEntry entity:stkIoBillEntryList) {
				//外键设置
				entity.setMid(stkIoBill.getId());
				entity.setBillNo(stkIoBill.getBillNo());

				String supplierId = stkIoBill.getSupplierId();
				if (supplierId!=null && !supplierId.isEmpty()) {
					entity.setSupplierId(supplierId);
				}
				stkIoBillEntryMapper.insert(entity);
			}
		}
	}

	@Override
	@Transactional
	public void delMain(String id) {
		stkIoBillEntryMapper.deleteByMainId(id);
		stkIoBillMapper.deleteById(id);
	}

	@Override
	@Transactional
	public void delBatchMain(Collection<? extends Serializable> idList) {
		for(Serializable id:idList) {
			stkIoBillEntryMapper.deleteByMainId(id.toString());
			stkIoBillMapper.deleteById(id);
		}
	}

	@Override
	public IPage<StkIoBill> selectByStockIoType(IPage<StkIoBill> page, String stockIoType) {
		return stkIoBillMapper.selectByStockIoType(page, stockIoType);
	}

	@Override
	@Transactional
	public void approve(String id) {
		StkIoBill stkIoBill = stkIoBillMapper.selectById(id);
		if (stkIoBill == null) {
			throw new JeecgBootException(String.format("【ID：%s】出入库单不存在！", id));
		}

		LoginUser sysUser = (LoginUser) SecurityUtils.getSubject().getPrincipal();
		stkIoBill.setApproverId(sysUser.getUsername());
		stkIoBill.setIsApproved(1);
		stkIoBill.setEffectiveTime(new Date());
		stkIoBill.setBillProcStatus("23");
		stkIoBillMapper.updateById(stkIoBill);

		List<StkIoBillEntry> stkIoBillEntryList = stkIoBillEntryMapper.selectByMainId(stkIoBill.getId());
		//更新实时库存
		updateInventory(stkIoBill, stkIoBillEntryList);
		//生成应收应付
		if (stkIoBill.getHasRp() == 1) {
			if (stkIoBill.getStockIoType().startsWith("1") ) {
				finPayableService.createPayable(stkIoBill, stkIoBillEntryList);
			}
			else {
				finReceivableService.createReceivable(stkIoBill, stkIoBillEntryList);
			}
		}
	}

	@Override
	public boolean isApproved(Integer year, Integer month) {
		QueryWrapper<StkIoBill> queryWrapper = new QueryWrapper<>();
		queryWrapper.apply("YEAR(bill_date) = {0} AND MONTH(bill_date) = {1}", year, month);
		queryWrapper.eq("is_closed", 0);
		queryWrapper.eq("is_voided", 0);
		queryWrapper.eq("is_approved", 0);
		return stkIoBillMapper.selectCount(queryWrapper) == 0;
	}

	@Override
	@Transactional
	public void createInBill(StkCheckBill stkCheckBill, List<StkCheckBillEntry> stkCheckBillEntryList) {
		createIoBill("102", stkCheckBill, stkCheckBillEntryList);
	}

	@Override
	@Transactional
	public void createOutBill(StkCheckBill stkCheckBill, List<StkCheckBillEntry> stkCheckBillEntryList) {
		createIoBill("202", stkCheckBill, stkCheckBillEntryList);
	}

	private void createIoBill(String stockIoType, StkCheckBill stkCheckBill, List<StkCheckBillEntry> stkCheckBillEntryList) {
		StkIoBill stkIoBill = new StkIoBill();
		stkIoBill.setStockIoType(stockIoType);
		stkIoBill.setIsAuto(1);
		stkIoBill.setIsRubric(0);
		stkIoBill.setSourceType("stk_check_bill");
		stkIoBill.setSourceId(stkCheckBill.getId());
		stkIoBill.setSourceNo(stkCheckBill.getBillNo());
		stkIoBill.setBillNo((String) FillRuleUtil.executeRule("stock_io_bill_no", null));
		stkIoBill.setBillDate(stkCheckBill.getBillDate()); //注意：如果设为系统日期，有可能小于当前业务期间
		stkIoBill.setHandlerId(stkCheckBill.getCheckerId());
		stkIoBill.setHasRp(0);
		stkIoBill.setIsSameSettle(0);

		LoginUser sysUser = (LoginUser) SecurityUtils.getSubject().getPrincipal();
		stkIoBill.setApproverId(sysUser.getUsername());
		stkIoBill.setIsApproved(1);
		stkIoBill.setEffectiveTime(new Date());
		stkIoBill.setBillProcStatus("23");
		stkIoBill.setIsClosed(0);
		stkIoBill.setIsVoided(0);
		basBizPeriodService.validateBillDate(stkIoBill.getBillDate());
		stkIoBillMapper.insert(stkIoBill);

		List<StkIoBillEntry> stkIoBillEntryList = new ArrayList<>();
		int entryNo = 0;
		for(StkCheckBillEntry checkEntity:stkCheckBillEntryList) {
			BigDecimal qty = checkEntity.getProfitQty(); //profitQty: 盘盈为正，盘亏为负
			if (stockIoType=="202") {
				qty = qty.multiply(new BigDecimal(-1));
			}
			if (qty.compareTo(BigDecimal.ZERO) > 0) {
				StkIoBillEntry ioEntry = new StkIoBillEntry();
				//外键设置
				ioEntry.setMid(stkIoBill.getId());
				ioEntry.setBillNo(stkIoBill.getBillNo());
				ioEntry.setEntryNo(++entryNo);
				ioEntry.setSourceType("stk_check_bill.stk_check_bill_entry");
				ioEntry.setSourceEntryId(checkEntity.getId());
				ioEntry.setSourceEntryNo(String.format("%s.%d", checkEntity.getBillNo(), checkEntity.getEntryNo()));
				ioEntry.setWarehouseId(checkEntity.getWarehouseId());
				ioEntry.setMaterialId(checkEntity.getMaterialId());
				ioEntry.setBatchNo(checkEntity.getBatchNo());
				ioEntry.setUnitId(checkEntity.getUnitId());
				ioEntry.setQty(qty);
				ioEntry.setCost(BigDecimal.ZERO);
				ioEntry.setSupplierId(checkEntity.getSupplierId());
				stkIoBillEntryMapper.insert(ioEntry);
				stkIoBillEntryList.add(ioEntry);
			}
		}
		//更新实时库存
		updateInventory(stkIoBill, stkIoBillEntryList);
	}

	private void updateInventory(StkIoBill stkIoBill, List<StkIoBillEntry> stkIoBillEntryList){
		String stockIoType = stkIoBill.getStockIoType();
		for(StkIoBillEntry entry : stkIoBillEntryList) {
			if (stockIoType.startsWith("1")){ //入库
				stkInventoryService.increase(entry);
			}
			else if (stockIoType.startsWith("2")) { //出库
				stkInventoryService.decrease(entry);
			} else if (stockIoType.equals("301")) { //仓库调拨
				//先调出
				stkInventoryService.decrease(entry);
				//再调入
				entry.setWarehouseId(entry.getInWarehouseId());
				stkInventoryService.increase(entry);
			} else if (stockIoType.equals("801")) { //成本调整
				stkInventoryService.changeCost(entry);
			}
		}
	}

}
