package io.finer.erp.jeecg.bas.service.impl;

import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import io.finer.erp.jeecg.bas.entity.BasBizPeriod;
import io.finer.erp.jeecg.bas.mapper.BasBizPeriodMapper;
import io.finer.erp.jeecg.bas.service.IBasBizPeriodService;
import io.finer.erp.jeecg.finance.service.*;
import io.finer.erp.jeecg.stock.service.IStkCheckBillService;
import io.finer.erp.jeecg.stock.service.IStkIoBillService;
import org.jeecg.common.exception.JeecgBootException;
import org.springframework.beans.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.Calendar;
import java.util.Date;


/**
 * @Description: bas_biz_period
 * @Author: jeecg-boot
 * @Date:   2020-05-25
 * @Version: V1.0
 */
@Service
public class BasBizPeriodServiceImpl extends ServiceImpl<BasBizPeriodMapper, BasBizPeriod> implements IBasBizPeriodService {
    @Autowired
    private BasBizPeriodMapper basBizPeriodMapper;
    @Autowired
    IStkCheckBillService stkCheckBillService;
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
    public BasBizPeriod getCurrent() {
        BasBizPeriod bizPeriod = basBizPeriodMapper.selectOne(null);
        if (bizPeriod == null) {
            throw new JeecgBootException("业务期间记录不存在！");
        }
        return bizPeriod;
    }

    @Override
    public BasBizPeriod getPrev(BasBizPeriod bizPeriod) {
        if (bizPeriod == null) {
            bizPeriod = getCurrent();
        }

        BasBizPeriod result = new BasBizPeriod();
        BeanUtils.copyProperties(bizPeriod, result, "id");
        Integer year = bizPeriod.getYear();
        Integer month = bizPeriod.getMonth();
        year = month == 1 ? year - 1 : year;
        month = month == 1 ? 12 : month - 1;

        result.setYear(year);
        result.setMonth(month);
        return result;
    }

    @Override
    public BasBizPeriod getNext(BasBizPeriod bizPeriod) {
        if (bizPeriod == null) {
            bizPeriod = getCurrent();
        }

        BasBizPeriod result = new BasBizPeriod();
        BeanUtils.copyProperties(bizPeriod, result, "id");
        Integer year = bizPeriod.getYear();
        Integer month = bizPeriod.getMonth();
        year = month == 12 ? year + 1 : year;
        month = month == 12 ? 1 : month + 1;

        result.setYear(year);
        result.setMonth(month);
        return result;
    }

    @Override
    public void validateBillDate(Date date) {
        BasBizPeriod curr = getCurrent();
        Calendar c = Calendar.getInstance();
        c.set(curr.getYear(), curr.getMonth() - 1, 1);
        if (date.compareTo(c.getTime()) < 0) {
            throw new JeecgBootException("单据日期不能早于当前业务月度！");
        }
    }

    @Override
    @Transactional
    public void monthCarryForward(Integer year, Integer month) {
        BasBizPeriod curr = getCurrent();
        if (year.compareTo(curr.getYear()) != 0 || month.compareTo(curr.getMonth()) != 0) {
            throw new JeecgBootException(String.format("%d年%d月不是当前月度，不能做结转！", year, month));
        }
        if (year.compareTo(curr.getBeginYear()) < 0 ||
                (year.compareTo(curr.getBeginYear()) == 0 && month.compareTo(curr.getBeginMonth()) < 0)) {
            throw new JeecgBootException(String.format("%d年%d月早于启用月度，不能做结转！", year, month));
        }

        if (!stkCheckBillService.isApproved(year, month)){
            throw new JeecgBootException("当前月度的库存盘点单未全部审核通过，不能做结转！");
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

        BasBizPeriod next = getNext(curr);
        curr.setYear(next.getYear());
        curr.setMonth(next.getMonth());
        basBizPeriodMapper.updateById(curr);
    }

}
