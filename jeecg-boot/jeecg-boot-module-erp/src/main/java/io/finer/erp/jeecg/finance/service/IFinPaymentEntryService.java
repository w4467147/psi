package io.finer.erp.jeecg.finance.service;

import io.finer.erp.jeecg.finance.entity.FinPaymentEntry;
import com.baomidou.mybatisplus.extension.service.IService;
import java.util.List;

/**
 * @Description: 付款明细
 * @Author: jeecg-boot
 * @Date:   2020-04-14
 * @Version: V1.0
 */
public interface IFinPaymentEntryService extends IService<FinPaymentEntry> {

	public List<FinPaymentEntry> selectByMainId(String mainId);
}
