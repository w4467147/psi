package io.finer.erp.jeecg.finance.service;

import com.baomidou.mybatisplus.extension.service.IService;
import io.finer.erp.jeecg.finance.entity.FinReceivableCheck;
import io.finer.erp.jeecg.finance.entity.FinReceivableCheckEntry;

import java.io.Serializable;
import java.util.Collection;
import java.util.List;

/**
 * @Description: 往来核销单
 * @Author: jeecg-boot
 * @Date:   2020-04-17
 * @Version: V1.0
 */
public interface IFinReceivableCheckService extends IService<FinReceivableCheck> {

	/**
	 * 添加一对多
	 * 
	 */
	public void saveMain(FinReceivableCheck finReceivableCheck, List<FinReceivableCheckEntry> finReceivableCheckEntryList) ;
	
	/**
	 * 修改一对多
	 * 
	 */
	public void updateMain(FinReceivableCheck finReceivableCheck, List<FinReceivableCheckEntry> finReceivableCheckEntryList);
	
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
