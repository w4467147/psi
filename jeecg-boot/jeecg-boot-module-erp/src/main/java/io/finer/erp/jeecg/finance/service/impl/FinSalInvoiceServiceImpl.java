package io.finer.erp.jeecg.finance.service.impl;

import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import io.finer.erp.jeecg.finance.entity.FinSalInvoice;
import io.finer.erp.jeecg.finance.entity.FinSalInvoiceEntry;
import io.finer.erp.jeecg.finance.mapper.FinSalInvoiceEntryMapper;
import io.finer.erp.jeecg.finance.mapper.FinSalInvoiceMapper;
import io.finer.erp.jeecg.finance.service.IFinSalInvoiceService;
import io.finer.erp.jeecg.stock.service.IStkIoBillEntryService;
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
 * @Description: 销售发票登记
 * @Author
 * @Date:   2020-05-24
 * @Version: V1.0
 */
@Service
public class FinSalInvoiceServiceImpl extends ServiceImpl<FinSalInvoiceMapper, FinSalInvoice> implements IFinSalInvoiceService {

	@Autowired
	private FinSalInvoiceMapper finSalInvoiceMapper;
	@Autowired
	private FinSalInvoiceEntryMapper finSalInvoiceEntryMapper;
	@Autowired
	private IStkIoBillEntryService stkIoBillEntryService;

	@Override
	@Transactional
	public void saveMain(FinSalInvoice finSalInvoice, List<FinSalInvoiceEntry> finSalInvoiceEntryList) {
		finSalInvoiceMapper.insert(finSalInvoice);
		if(finSalInvoiceEntryList!=null && finSalInvoiceEntryList.size()>0) {
			for(FinSalInvoiceEntry entity:finSalInvoiceEntryList) {
				//外键设置
				entity.setMid(finSalInvoice.getId());
				entity.setBillNo(finSalInvoice.getBillNo());
				finSalInvoiceEntryMapper.insert(entity);
			}
		}
	}

	@Override
	@Transactional
	public void updateMain(FinSalInvoice finSalInvoice,List<FinSalInvoiceEntry> finSalInvoiceEntryList) {
		finSalInvoiceMapper.updateById(finSalInvoice);
		
		//1.先删除子表数据
		finSalInvoiceEntryMapper.deleteByMainId(finSalInvoice.getId());
		
		//2.子表数据重新插入
		if(finSalInvoiceEntryList!=null && finSalInvoiceEntryList.size()>0) {
			for(FinSalInvoiceEntry entity:finSalInvoiceEntryList) {
				//外键设置
				entity.setMid(finSalInvoice.getId());
				entity.setBillNo(finSalInvoice.getBillNo());
				finSalInvoiceEntryMapper.insert(entity);
			}
		}
	}

	@Override
	@Transactional
	public void delMain(String id) {
		finSalInvoiceEntryMapper.deleteByMainId(id);
		finSalInvoiceMapper.deleteById(id);
	}

	@Override
	@Transactional
	public void delBatchMain(Collection<? extends Serializable> idList) {
		for(Serializable id:idList) {
			finSalInvoiceEntryMapper.deleteByMainId(id.toString());
			finSalInvoiceMapper.deleteById(id);
		}
	}

	@Override
	@Transactional
	public void approve(String id) {
		FinSalInvoice bill = finSalInvoiceMapper.selectById(id);
		if (bill == null) {
			throw new JeecgBootException(String.format("【ID：%s】销售发票登记单不存在！", id));
		}

		LoginUser sysUser = (LoginUser) SecurityUtils.getSubject().getPrincipal();
		bill.setApproverId(sysUser.getUsername());
		bill.setIsApproved(1);
		bill.setEffectiveTime(new Date());
		bill.setBillProcStatus("23");
		finSalInvoiceMapper.updateById(bill);

		List<FinSalInvoiceEntry> entryList = finSalInvoiceEntryMapper.selectByMainId(id);
		for(FinSalInvoiceEntry entry : entryList) {
			try {
				//蓝单source为stk_io_bill_entry, 红单的source为fin_sal_invoice_entry
				String sourceId = entry.getSourceEntryId();
				if (entry.getSourceType().startsWith("fin_sal_invoice.fin_sal_invoice_entry")) {//红单
					FinSalInvoiceEntry source = finSalInvoiceEntryMapper.selectById(sourceId);
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
