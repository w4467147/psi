package io.finer.erp.jeecg.finance.service;

import io.finer.erp.jeecg.finance.entity.FinPaymentEntry;
import io.finer.erp.jeecg.finance.entity.FinPayment;
import com.baomidou.mybatisplus.extension.service.IService;
import java.io.Serializable;
import java.math.BigDecimal;
import java.util.Collection;
import java.util.List;

/**
 * @Description: 付款单
 * @Author: jeecg-boot
 * @Date:   2020-04-14
 * @Version: V1.0
 */
public interface IFinPaymentService extends IService<FinPayment> {

	/**
	 * 添加一对多
	 * 
	 */
	public void saveMain(FinPayment finPayment,List<FinPaymentEntry> finPaymentEntryList) ;
	
	/**
	 * 修改一对多
	 * 
	 */
	public void updateMain(FinPayment finPayment,List<FinPaymentEntry> finPaymentEntryList);
	
	/**
	 * 删除一对多
	 */
	public void delMain (String id);
	
	/**
	 * 批量删除一对多
	 */
	void delBatchMain(Collection<? extends Serializable> idList);

	void approve(String id);
	boolean isApproved(Integer year, Integer month);
	BigDecimal getUncheckedAmt(String id);
	void checkAmt(String id, BigDecimal amt);
}
