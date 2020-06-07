package io.finer.erp.jeecg.finance.service;

import com.baomidou.mybatisplus.extension.service.IService;
import io.finer.erp.jeecg.finance.entity.FinPayableCheck;
import io.finer.erp.jeecg.finance.entity.FinPayableCheckEntry;

import java.io.Serializable;
import java.util.Collection;
import java.util.List;

/**
 * @Description: 往来核销单
 * @Author: jeecg-boot
 * @Date:   2020-04-17
 * @Version: V1.0
 */
public interface IFinPayableCheckService extends IService<FinPayableCheck> {

	/**
	 * 添加一对多
	 * 
	 */
	public void saveMain(FinPayableCheck finPayableCheck, List<FinPayableCheckEntry> finPayableCheckEntryList) ;
	
	/**
	 * 修改一对多
	 * 
	 */
	public void updateMain(FinPayableCheck finPayableCheck, List<FinPayableCheckEntry> finPayableCheckEntryList);
	
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
