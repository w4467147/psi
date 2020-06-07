package io.finer.erp.jeecg.finance.service.impl;

import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import io.finer.erp.jeecg.finance.entity.FinReceivableBal;
import io.finer.erp.jeecg.finance.mapper.FinReceivableBalMapper;
import io.finer.erp.jeecg.finance.service.IFinReceivableBalService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

/**
 * @Description: fin_receivable_bal
 * @Author: jeecg-boot
 * @Date:   2020-05-25
 * @Version: V1.0
 */
@Service
public class FinReceivableBalServiceImpl extends ServiceImpl<FinReceivableBalMapper, FinReceivableBal> implements IFinReceivableBalService {
    @Autowired
    FinReceivableBalMapper finReceivableBalMapper;

    @Override
    public void monthCarryForward(Integer year, Integer month) {
        finReceivableBalMapper.monthCarryForward(year, month);
    }
}
