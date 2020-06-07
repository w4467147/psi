package io.finer.erp.jeecg.finance.service;

import io.finer.erp.jeecg.finance.entity.FinPurInvoiceEntry;
import io.finer.erp.jeecg.finance.entity.FinPurInvoice;
import com.baomidou.mybatisplus.extension.service.IService;
import java.io.Serializable;
import java.util.Collection;
import java.util.List;

/**
 * @Description: 采购发票登记
 * @Author: jeecg-boot
 * @Date:   2020-05-21
 * @Version: V1.0
 */
public interface IFinPurInvoiceService extends IService<FinPurInvoice> {

	/**
	 * 添加一对多
	 * 
	 */
	public void saveMain(FinPurInvoice finPurInvoice,List<FinPurInvoiceEntry> finPurInvoiceEntryList) ;
	
	/**
	 * 修改一对多
	 * 
	 */
	public void updateMain(FinPurInvoice finPurInvoice,List<FinPurInvoiceEntry> finPurInvoiceEntryList);
	
	/**
	 * 删除一对多
	 */
	public void delMain (String id);
	
	/**
	 * 批量删除一对多
	 */
	public void delBatchMain (Collection<? extends Serializable> idList);

	void approve(String id);
}
