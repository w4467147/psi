package io.finer.erp.jeecg.finance.service;

import io.finer.erp.jeecg.finance.entity.FinReceiptEntry;
import io.finer.erp.jeecg.finance.entity.FinReceipt;
import com.baomidou.mybatisplus.extension.service.IService;
import java.io.Serializable;
import java.math.BigDecimal;
import java.util.Collection;
import java.util.List;

/**
 * @Description: 收款单
 * @Author: jeecg-boot
 * @Date:   2020-04-30
 * @Version: V1.0
 */
public interface IFinReceiptService extends IService<FinReceipt> {

	/**
	 * 添加一对多
	 * 
	 */
	public void saveMain(FinReceipt finReceipt,List<FinReceiptEntry> finReceiptEntryList) ;
	
	/**
	 * 修改一对多
	 * 
	 */
	public void updateMain(FinReceipt finReceipt,List<FinReceiptEntry> finReceiptEntryList);
	
	/**
	 * 删除一对多
	 */
	public void delMain (String id);
	
	/**
	 * 批量删除一对多
	 */
	public void delBatchMain (Collection<? extends Serializable> idList);

	void approve(String id);
	boolean isApproved(Integer year, Integer month);
	BigDecimal getUncheckedAmt(String id);
	void checkAmt(String id, BigDecimal amt);
}
