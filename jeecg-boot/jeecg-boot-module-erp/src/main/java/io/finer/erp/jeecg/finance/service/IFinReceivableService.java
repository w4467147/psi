package io.finer.erp.jeecg.finance.service;

import io.finer.erp.jeecg.finance.entity.FinReceivable;
import com.baomidou.mybatisplus.extension.service.IService;
import io.finer.erp.jeecg.stock.entity.StkIoBill;
import io.finer.erp.jeecg.stock.entity.StkIoBillEntry;

import java.math.BigDecimal;
import java.util.List;

/**
 * @Description: 应收单
 * @Author: jeecg-boot
 * @Date:   2020-04-30
 * @Version: V1.0
 */
public interface IFinReceivableService extends IService<FinReceivable> {
    void createReceivable(StkIoBill stkIoBill, List<StkIoBillEntry> stkIoBillEntryList);
    void approve(String id);
    boolean isApproved(Integer year, Integer month);
    BigDecimal getUncheckedAmt(String id);
    void checkAmt(String id, BigDecimal amt);
}
