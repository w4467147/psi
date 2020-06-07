package io.finer.erp.jeecg.finance.service;

import io.finer.erp.jeecg.finance.entity.FinReceiptEntry;
import com.baomidou.mybatisplus.extension.service.IService;
import java.util.List;

/**
 * @Description: 收款明细
 * @Author: jeecg-boot
 * @Date:   2020-04-30
 * @Version: V1.0
 */
public interface IFinReceiptEntryService extends IService<FinReceiptEntry> {

	public List<FinReceiptEntry> selectByMainId(String mainId);
}
