package io.finer.erp.jeecg.stock.service;

import io.finer.erp.jeecg.stock.entity.StkCheckBillEntry;
import io.finer.erp.jeecg.stock.entity.StkCheckBill;
import com.baomidou.mybatisplus.extension.service.IService;
import java.io.Serializable;
import java.util.Collection;
import java.util.List;

/**
 * @Description: 盘点卡
 * @Author: jeecg-boot
 * @Date:   2020-05-18
 * @Version: V1.0
 */
public interface IStkCheckBillService extends IService<StkCheckBill> {

	/**
	 * 添加一对多
	 * 
	 */
	public void saveMain(StkCheckBill stkCheckBill,List<StkCheckBillEntry> stkCheckBillEntryList) ;
	
	/**
	 * 修改一对多
	 * 
	 */
	public void updateMain(StkCheckBill stkCheckBill,List<StkCheckBillEntry> stkCheckBillEntryList);
	
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
}
