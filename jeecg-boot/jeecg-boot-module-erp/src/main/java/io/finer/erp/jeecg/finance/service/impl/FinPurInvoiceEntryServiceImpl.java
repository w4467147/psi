package io.finer.erp.jeecg.finance.service.impl;

import io.finer.erp.jeecg.finance.entity.FinPurInvoiceEntry;
import io.finer.erp.jeecg.finance.mapper.FinPurInvoiceEntryMapper;
import io.finer.erp.jeecg.finance.service.IFinPurInvoiceEntryService;
import io.finer.erp.jeecg.stock.entity.StkIoBillEntry;
import io.finer.erp.jeecg.stock.service.IStkInventoryService;
import io.finer.erp.jeecg.stock.service.IStkIoBillEntryService;
import org.springframework.beans.BeanUtils;
import org.springframework.stereotype.Service;
import java.util.List;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import org.springframework.beans.factory.annotation.Autowired;

/**
 * @Description: 明细
 * @Author: jeecg-boot
 * @Date:   2020-05-21
 * @Version: V1.0
 */
@Service
public class FinPurInvoiceEntryServiceImpl extends ServiceImpl<FinPurInvoiceEntryMapper, FinPurInvoiceEntry> implements IFinPurInvoiceEntryService {
	
	@Autowired
	private FinPurInvoiceEntryMapper finPurInvoiceEntryMapper;
	@Autowired
	private IStkIoBillEntryService stkIoBillEntryService;

	@Override
	public List<FinPurInvoiceEntry> selectByMainId(String mainId) {
		List<FinPurInvoiceEntry> list = finPurInvoiceEntryMapper.selectByMainId(mainId);
		for(FinPurInvoiceEntry entry : list) {
			//蓝单source为stk_io_bill_entry, 红单的source为fin_pur_invoice_entry
			String sourceId = entry.getSourceEntryId();
			if (entry.getSourceType().startsWith("fin_pur_invoice.fin_pur_invoice_entry")) {//红单
				FinPurInvoiceEntry source = getById(sourceId);
				if (source != null) {
					entry.setBlueInvoiceQty(source.getInvoiceQty());
					entry.setBlueInvoiceAmt(source.getInvoiceAmt());
					sourceId = source.getSourceEntryId();
				}

			}

			StkIoBillEntry source = stkIoBillEntryService.getById(sourceId);
			if (source != null) {
				entry.setMaterialId(source.getMaterialId());
				entry.setWarehouseId(source.getWarehouseId());
				entry.setBatchNo(source.getBatchNo());
				entry.setSettleQty(source.getSettleQty());
				entry.setSettleAmt(source.getSettleAmt());
				entry.setInvoicedQty(source.getInvoicedQty());
				entry.setInvoicedAmt(source.getInvoicedAmt());
			}
		}
		return list;
	}

}
