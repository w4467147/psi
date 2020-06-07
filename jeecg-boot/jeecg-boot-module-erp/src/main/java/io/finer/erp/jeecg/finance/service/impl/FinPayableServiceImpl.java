package io.finer.erp.jeecg.finance.service.impl;

import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import io.finer.erp.jeecg.bas.service.IBasBizPeriodService;
import io.finer.erp.jeecg.finance.entity.FinPayable;
import io.finer.erp.jeecg.finance.entity.FinPayment;
import io.finer.erp.jeecg.finance.mapper.FinPayableMapper;
import io.finer.erp.jeecg.finance.service.IFinPayableService;
import io.finer.erp.jeecg.stock.entity.StkIoBill;
import io.finer.erp.jeecg.stock.entity.StkIoBillEntry;
import org.apache.shiro.SecurityUtils;
import org.jeecg.common.api.vo.Result;
import org.jeecg.common.exception.JeecgBootException;
import org.jeecg.common.system.vo.LoginUser;
import org.jeecg.common.util.FillRuleUtil;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.math.BigDecimal;
import java.util.Date;
import java.util.List;

/**
 * @Description: 应付单
 * @Author: jeecg-boot
 * @Date:   2020-04-13
 * @Version: V1.0
 */
@Service
public class FinPayableServiceImpl extends ServiceImpl<FinPayableMapper, FinPayable> implements IFinPayableService {
    @Autowired
    private FinPayableMapper finPayableMapper;
    @Autowired
    private IBasBizPeriodService basBizPeriodService;

    @Override
    public boolean save(FinPayable entity) {
        basBizPeriodService.validateBillDate(entity.getBillDate());
        return super.save(entity);
    }

    @Override
    public boolean updateById(FinPayable entity) {
        basBizPeriodService.validateBillDate(entity.getBillDate());
        return super.updateById(entity);
    }

    @Override
    @Transactional
    public void createPayable(StkIoBill stkIoBill, List<StkIoBillEntry> stkIoBillEntryList) {
        BigDecimal amt = new BigDecimal(0);
        for(StkIoBillEntry entry : stkIoBillEntryList) {
            amt = amt.add(entry.getSettleAmt());
        }

        FinPayable finPayable = new FinPayable();
        finPayable.setPayableType("202");//采购应付
        finPayable.setIsRubric(stkIoBill.getIsRubric());
        finPayable.setIsAuto(1);
        if (stkIoBill.getStockIoType().equals("101")) {
            //采购入库
            finPayable.setSourceType("stk_io_bill..101");
        }
        finPayable.setSourceId(stkIoBill.getId());
        finPayable.setSourceNo(stkIoBill.getBillNo());
        finPayable.setBillNo((String) FillRuleUtil.executeRule("payable_bill_no", null));
        finPayable.setBillDate(stkIoBill.getBillDate()); //注意：如果设为系统日期，有可能小于当前业务期间
        finPayable.setAmt(amt);
        finPayable.setCheckedAmt(new BigDecimal(0));
        finPayable.setSupplierId(stkIoBill.getSupplierId());

        LoginUser sysUser = (LoginUser) SecurityUtils.getSubject().getPrincipal();
        finPayable.setApproverId(sysUser.getUsername());
        finPayable.setIsApproved(1);
        finPayable.setEffectiveTime(new Date());
        finPayable.setBillProcStatus("23");
        finPayable.setIsClosed(0);
        finPayable.setIsVoided(0);
        finPayableMapper.insert(finPayable);
    }

    @Override
    @Transactional
    public void approve(String id) {
        FinPayable finPayable = getById(id);
        if(finPayable==null) {
            throw new JeecgBootException(String.format("【ID：%s】应付单不存在！", id));
        }

        LoginUser sysUser = (LoginUser) SecurityUtils.getSubject().getPrincipal();
        finPayable.setApproverId(sysUser.getUsername());
        finPayable.setIsApproved(1);
        finPayable.setEffectiveTime(new Date());
        finPayable.setBillProcStatus("23");
        finPayableMapper.updateById(finPayable);
    }

    @Override
    public boolean isApproved(Integer year, Integer month) {
        QueryWrapper<FinPayable> queryWrapper = new QueryWrapper<>();
        queryWrapper.apply("YEAR(bill_date) = {0} AND MONTH(bill_date) = {1}", year, month);
        queryWrapper.eq("is_closed", 0);
        queryWrapper.eq("is_voided", 0);
        queryWrapper.eq("is_approved", 0);
        return finPayableMapper.selectCount(queryWrapper) == 0;
    }

    @Override
    public BigDecimal getUncheckedAmt(String id) {
        FinPayable finPayable = finPayableMapper.selectById(id);
        return finPayable!= null ? finPayable.getUncheckedAmt() : null;
    }

    @Override
    @Transactional
    public void checkAmt(String id, BigDecimal amt) {
        FinPayable finPayable = finPayableMapper.selectById(id);
        if (finPayable == null) {
            throw new JeecgBootException(String.format("【ID：%s】应付单不存在！", id));
        }

        BigDecimal checkedAmt = finPayable.getCheckedAmt().add(amt);
        if (finPayable.getAmt().compareTo(checkedAmt) < 0 ) {
            throw new JeecgBootException(String.format("【单据号：%s】核销金额不能大于未核金额！",
                    finPayable.getBillNo() ));
        }
        finPayable.setCheckedAmt(checkedAmt);
        finPayableMapper.updateById(finPayable);
    }
}