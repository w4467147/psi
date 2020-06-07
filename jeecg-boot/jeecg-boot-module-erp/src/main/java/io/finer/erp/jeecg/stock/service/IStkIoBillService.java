package io.finer.erp.jeecg.stock.service;

import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import io.finer.erp.jeecg.stock.entity.StkCheckBill;
import io.finer.erp.jeecg.stock.entity.StkCheckBillEntry;
import io.finer.erp.jeecg.stock.entity.StkIoBillEntry;
import io.finer.erp.jeecg.stock.entity.StkIoBill;
import com.baomidou.mybatisplus.extension.service.IService;
import org.apache.ibatis.annotations.Param;

import java.io.Serializable;
import java.util.Collection;
import java.util.List;

/**
 * @Description: 出入库单
 * @Author: jeecg-boot
 * @Date:   2020-03-31
 * @Version: V1.0
 */
public interface IStkIoBillService extends IService<StkIoBill> {

	/**
	 * 添加一对多
	 * 
	 */
	public void saveMain(StkIoBill stkIoBill,List<StkIoBillEntry> stkIoBillEntryList) ;
	
	/**
	 * 修改一对多
	 * 
	 */
	public void updateMain(StkIoBill stkIoBill,List<StkIoBillEntry> stkIoBillEntryList);
	
	/**
	 * 删除一对多
	 */
	public void delMain (String id);
	
	/**
	 * 批量删除一对多
	 */
	public void delBatchMain (Collection<? extends Serializable> idList);

	IPage<StkIoBill> selectByStockIoType(IPage<StkIoBill> page, String stockIoType);
	void approve(String id);
	boolean isApproved(Integer year, Integer month);
	void createInBill(StkCheckBill stkCheckBill, List<StkCheckBillEntry> stkCheckBillEntryList);
	void createOutBill(StkCheckBill stkCheckBill, List<StkCheckBillEntry> stkCheckBillEntryList);
}
