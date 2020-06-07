package io.finer.erp.jeecg.stock.service.impl;

import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import io.finer.erp.jeecg.stock.entity.StkInventory;
import io.finer.erp.jeecg.stock.entity.StkIoBillEntry;
import io.finer.erp.jeecg.stock.mapper.StkIoBillEntryMapper;
import io.finer.erp.jeecg.stock.service.IStkInventoryService;
import io.finer.erp.jeecg.stock.service.IStkIoBillEntryService;
import org.jeecg.common.exception.JeecgBootException;
import org.springframework.stereotype.Service;

import java.math.BigDecimal;
import java.util.List;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.transaction.annotation.Transactional;

/**
 * @Description: 明细
 * @Author: jeecg-boot
 * @Date:   2020-03-31
 * @Version: V1.0
 */
@Service
public class StkIoBillEntryServiceImpl extends ServiceImpl<StkIoBillEntryMapper, StkIoBillEntry> implements IStkIoBillEntryService {
	
	@Autowired
	private StkIoBillEntryMapper stkIoBillEntryMapper;
	@Autowired
	private IStkInventoryService stkInventoryService;

	@Override
	public List<StkIoBillEntry> selectByMainId(String mainId) {
		return stkIoBillEntryMapper.selectByMainId(mainId);
	}

	@Override
	public List<StkIoBillEntry> selectEditingByMainId(String mainId) {
		List<StkIoBillEntry> list = selectByMainId(mainId);
		for(StkIoBillEntry entry : list) {
			StkInventory inv = stkInventoryService.getByBatchNoAndX(entry.getBatchNo(),
					entry.getMaterialId(), entry.getWarehouseId());
			if (inv != null) {
				entry.setInventoryUnitId(inv.getUnitId());
				entry.setInventoryQty(inv.getQty());
				entry.setInventoryCost(inv.getCost());
			}
		}
		return list;
	}

	@Override
	@Transactional
	public void writebackInvoiced(String id, BigDecimal qty, BigDecimal amt) {
		StkIoBillEntry entry = getById(id);
		if (entry == null){
			throw new JeecgBootException("出入库分录不存在！");
		}

		entry.setInvoicedQty(entry.getInvoicedQty().add(qty));
		entry.setInvoicedAmt(entry.getInvoicedAmt().add(amt));
		if (entry.getInvoicedQty().compareTo(entry.getSettleQty()) > 0){
			throw new JeecgBootException("开票数量不能大于未开票数量！");
		}
		if (entry.getInvoicedAmt().compareTo(entry.getSettleAmt()) > 0){
			throw new JeecgBootException("开票金额不能大于未开票金额！");
		}

		updateById(entry);
	}
}
