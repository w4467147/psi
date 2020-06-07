package io.finer.erp.jeecg.finance.service;

import com.baomidou.mybatisplus.extension.service.IService;
import io.finer.erp.jeecg.finance.entity.FinReceivableBal;

/**
 * @Description: fin_receivable_bal
 * @Author: jeecg-boot
 * @Date:   2020-05-25
 * @Version: V1.0
 */
public interface IFinReceivableBalService extends IService<FinReceivableBal> {
    void monthCarryForward(Integer year, Integer month);
}
