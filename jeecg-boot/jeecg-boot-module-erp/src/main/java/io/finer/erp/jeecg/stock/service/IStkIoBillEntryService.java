package io.finer.erp.jeecg.stock.service;

import io.finer.erp.jeecg.stock.entity.StkIoBillEntry;
import com.baomidou.mybatisplus.extension.service.IService;

import java.math.BigDecimal;
import java.util.List;

/**
 * @Description: 明细
 * @Author: jeecg-boot
 * @Date:   2020-03-31
 * @Version: V1.0
 */
public interface IStkIoBillEntryService extends IService<StkIoBillEntry> {

	List<StkIoBillEntry> selectByMainId(String mainId);
	List<StkIoBillEntry> selectEditingByMainId(String mainId);
	void writebackInvoiced(String id, BigDecimal qty, BigDecimal amt);
}
