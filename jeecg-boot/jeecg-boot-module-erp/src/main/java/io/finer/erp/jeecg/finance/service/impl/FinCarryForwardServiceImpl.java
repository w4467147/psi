package io.finer.erp.jeecg.finance.service.impl;

import io.finer.erp.jeecg.bas.entity.BasBizPeriod;
import io.finer.erp.jeecg.bas.service.IBasBizPeriodService;
import io.finer.erp.jeecg.finance.service.*;
import io.finer.erp.jeecg.stock.service.IStkIoBillService;
import org.jeecg.common.api.vo.Result;
import org.jeecg.common.exception.JeecgBootException;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class FinCarryForwardServiceImpl implements IFinCarryForwardService {
    @Autowired
    IBasBizPeriodService basBizPeriodService;
    @Autowired
    IStkIoBillService stkIoBillService;
    @Autowired
    IFinReceivableService finReceivableService;
    @Autowired
    IFinPayableService finPayableService;
    @Autowired
    IFinReceiptService finReceiptService;
    @Autowired
    IFinPaymentService finPaymentService;
    @Autowired
    IFinReceivableBalService finReceivableBalService;
    @Autowired
    IFinPayableBalService finPayableBalService;

    @Override
    public void monthCarryForward(Integer year, Integer month) {
        BasBizPeriod curr = basBizPeriodService.getCurrent();
        if (curr.getYear() != year || curr.getMonth() != month) {
            throw new JeecgBootException(String.format("%d年%d月不是当前月度，不能做结转！", year, month));
        }

        if (!stkIoBillService.isApproved(year, month)){
            throw new JeecgBootException("当前月度的出库单或入库单未全部审核通过，不能做结转！");
        }
        if (!finReceivableService.isApproved(year, month)){
            throw new JeecgBootException("当前月度的应收单未全部审核通过，不能做结转！");
        }
        if (!finPayableService.isApproved(year, month)){
            throw new JeecgBootException("当前月度的应付单未全部审核通过，不能做结转！");
        }
        if (!finReceiptService.isApproved(year, month)){
            throw new JeecgBootException("当前月度的收款单/预收单未全部审核通过，不能做结转！");
        }
        if (!finPaymentService.isApproved(year, month)){
            throw new JeecgBootException("当前月度的付款单/预付单未全部审核通过，不能做结转！");
        }

        finReceivableBalService.monthCarryForward(year, month);
        finPayableBalService.monthCarryForward(year, month);
    }
}
