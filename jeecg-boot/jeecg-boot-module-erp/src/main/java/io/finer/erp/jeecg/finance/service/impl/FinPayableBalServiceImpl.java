package io.finer.erp.jeecg.finance.service.impl;

import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import io.finer.erp.jeecg.finance.entity.FinPayableBal;
import io.finer.erp.jeecg.finance.mapper.FinPayableBalMapper;
import io.finer.erp.jeecg.finance.service.IFinPayableBalService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

/**
 * @Description: fin_payable_bal
 * @Author: jeecg-boot
 * @Date:   2020-05-25
 * @Version: V1.0
 */
@Service
public class FinPayableBalServiceImpl extends ServiceImpl<FinPayableBalMapper, FinPayableBal> implements IFinPayableBalService {
    @Autowired
    FinPayableBalMapper finPayableBalMapper;

    @Override
    public void monthCarryForward(Integer year, Integer month) {
        finPayableBalMapper.monthCarryForward(year, month);
    }
}
