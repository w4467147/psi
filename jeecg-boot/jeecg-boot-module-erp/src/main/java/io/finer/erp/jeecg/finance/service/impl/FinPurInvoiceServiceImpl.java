package io.finer.erp.jeecg.finance.service.impl;

import io.finer.erp.jeecg.finance.entity.FinPurInvoice;
import io.finer.erp.jeecg.finance.entity.FinPurInvoiceEntry;
import io.finer.erp.jeecg.finance.mapper.FinPurInvoiceEntryMapper;
import io.finer.erp.jeecg.finance.mapper.FinPurInvoiceMapper;
import io.finer.erp.jeecg.finance.service.IFinPurInvoiceService;
import io.finer.erp.jeecg.stock.entity.StkIoBill;
import io.finer.erp.jeecg.stock.entity.StkIoBillEntry;
import io.finer.erp.jeecg.stock.service.IStkIoBillEntryService;
import org.apache.shiro.SecurityUtils;
import org.jeecg.common.api.vo.Result;
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
 * @Description: 采购发票登记
 * @Author: jeecg-boot
 * @Date:   2020-05-21
 * @Version: V1.0
 */
@Service
public class FinPurInvoiceServiceImpl extends ServiceImpl<FinPurInvoiceMapper, FinPurInvoice> implements IFinPurInvoiceService {

	@Autowired
	private FinPurInvoiceMapper finPurInvoiceMapper;
	@Autowired
	private FinPurInvoiceEntryMapper finPurInvoiceEntryMapper;
	@Autowired
	private IStkIoBillEntryService stkIoBillEntryService;

	@Override
	@Transactional
	public void saveMain(FinPurInvoice finPurInvoice, List<FinPurInvoiceEntry> finPurInvoiceEntryList) {
		finPurInvoiceMapper.insert(finPurInvoice);
		if(finPurInvoiceEntryList!=null && finPurInvoiceEntryList.size()>0) {
			for(FinPurInvoiceEntry entity:finPurInvoiceEntryList) {
				//外键设置
				entity.setMid(finPurInvoice.getId());
				entity.setBillNo(finPurInvoice.getBillNo());
				finPurInvoiceEntryMapper.insert(entity);
			}
		}
	}

	@Override
	@Transactional
	public void updateMain(FinPurInvoice finPurInvoice,List<FinPurInvoiceEntry> finPurInvoiceEntryList) {
		finPurInvoiceMapper.updateById(finPurInvoice);
		
		//1.先删除子表数据
		finPurInvoiceEntryMapper.deleteByMainId(finPurInvoice.getId());
		
		//2.子表数据重新插入
		if(finPurInvoiceEntryList!=null && finPurInvoiceEntryList.size()>0) {
			for(FinPurInvoiceEntry entity:finPurInvoiceEntryList) {
				//外键设置
				entity.setMid(finPurInvoice.getId());
				entity.setBillNo(finPurInvoice.getBillNo());
				finPurInvoiceEntryMapper.insert(entity);
			}
		}
	}

	@Override
	@Transactional
	public void delMain(String id) {
		finPurInvoiceEntryMapper.deleteByMainId(id);
		finPurInvoiceMapper.deleteById(id);
	}

	@Override
	@Transactional
	public void delBatchMain(Collection<? extends Serializable> idList) {
		for(Serializable id:idList) {
			finPurInvoiceEntryMapper.deleteByMainId(id.toString());
			finPurInvoiceMapper.deleteById(id);
		}
	}

	@Override
	@Transactional
	public void approve(String id) {
		FinPurInvoice bill = finPurInvoiceMapper.selectById(id);
		if (bill == null) {
			throw new JeecgBootException(String.format("【ID：%s】采购发票登记单不存在！", id));
		}

		LoginUser sysUser = (LoginUser) SecurityUtils.getSubject().getPrincipal();
		bill.setApproverId(sysUser.getUsername());
		bill.setIsApproved(1);
		bill.setEffectiveTime(new Date());
		bill.setBillProcStatus("23");
		finPurInvoiceMapper.updateById(bill);

		List<FinPurInvoiceEntry> entryList = finPurInvoiceEntryMapper.selectByMainId(id);
		for(FinPurInvoiceEntry entry : entryList) {
			try {
				//蓝单source为stk_io_bill_entry, 红单的source为fin_pur_invoice_entry
				String sourceId = entry.getSourceEntryId();
				if (entry.getSourceType().startsWith("fin_pur_invoice.fin_pur_invoice_entry")) {//红单
					FinPurInvoiceEntry source = finPurInvoiceEntryMapper.selectById(sourceId);
					if (source == null) {
						throw new JeecgBootException("蓝单分录不存在！");
					}
					sourceId = source.getSourceEntryId();
				}
				stkIoBillEntryService.writebackInvoiced(sourceId, entry.getInvoiceQty(), entry.getInvoiceAmt());
			} catch (Exception e) {
				throw new JeecgBootException(String.format("【分录号：%s】%s", entry.getEntryNo(), e.getMessage()),
						e.getCause());
			}
		}
	}

}
