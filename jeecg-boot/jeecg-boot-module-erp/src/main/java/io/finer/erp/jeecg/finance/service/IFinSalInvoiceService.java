package io.finer.erp.jeecg.finance.service;

import com.baomidou.mybatisplus.extension.service.IService;
import io.finer.erp.jeecg.finance.entity.FinSalInvoice;
import io.finer.erp.jeecg.finance.entity.FinSalInvoiceEntry;

import java.io.Serializable;
import java.util.Collection;
import java.util.List;

/**
 * @Description: 销售发票登记
 * @Author:
 * @Date:   2020-05-24
 * @Version: V1.0
 */
public interface IFinSalInvoiceService extends IService<FinSalInvoice> {

	/**
	 * 添加一对多
	 *
	 */
	public void saveMain(FinSalInvoice finSalInvoice, List<FinSalInvoiceEntry> finSalInvoiceEntryList) ;

	/**
	 * 修改一对多
	 *
	 */
	public void updateMain(FinSalInvoice finSalInvoice, List<FinSalInvoiceEntry> finSalInvoiceEntryList);

	/**
	 * 删除一对多
	 */
	public void delMain(String id);

	/**
	 * 批量删除一对多
	 */
	public void delBatchMain(Collection<? extends Serializable> idList);

	void approve(String id);
}
