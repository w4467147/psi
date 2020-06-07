package io.finer.erp.jeecg.finance.service;

import com.baomidou.mybatisplus.extension.service.IService;
import io.finer.erp.jeecg.finance.entity.FinReceivableCheckEntry;

import java.util.List;

/**
 * @Description: fin_receivable_check_entry
 * @Author: jeecg-boot
 * @Date:   2020-04-17
 * @Version: V1.0
 */
public interface IFinReceivableCheckEntryService extends IService<FinReceivableCheckEntry> {

    public List<FinReceivableCheckEntry> selectByMainId(String mainId);
}
