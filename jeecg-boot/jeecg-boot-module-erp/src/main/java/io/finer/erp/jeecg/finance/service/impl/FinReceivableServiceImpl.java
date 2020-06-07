package io.finer.erp.jeecg.finance.service.impl;

import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import io.finer.erp.jeecg.bas.service.IBasBizPeriodService;
import io.finer.erp.jeecg.finance.entity.FinPayable;
import io.finer.erp.jeecg.finance.entity.FinReceipt;
import io.finer.erp.jeecg.finance.entity.FinReceivable;
import io.finer.erp.jeecg.finance.mapper.FinReceivableMapper;
import io.finer.erp.jeecg.finance.service.IFinReceivableService;
import io.finer.erp.jeecg.stock.entity.StkIoBill;
import io.finer.erp.jeecg.stock.entity.StkIoBillEntry;
import org.apache.shiro.SecurityUtils;
import org.jeecg.common.exception.JeecgBootException;
import org.jeecg.common.system.vo.LoginUser;
import org.jeecg.common.util.FillRuleUtil;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import org.springframework.transaction.annotation.Transactional;

import java.math.BigDecimal;
import java.util.Date;
import java.util.List;

/**
 * @Description: 应收单
 * @Author: jeecg-boot
 * @Date:   2020-04-30
 * @Version: V1.0
 */
@Service
public class FinReceivableServiceImpl extends ServiceImpl<FinReceivableMapper, FinReceivable> implements IFinReceivableService {
    @Autowired
    private FinReceivableMapper finReceivableMapper;
    @Autowired
    private IBasBizPeriodService basBizPeriodService;

    @Override
    public boolean save(FinReceivable entity) {
        basBizPeriodService.validateBillDate(entity.getBillDate());
        return super.save(entity);
    }

    @Override
    public boolean updateById(FinReceivable entity) {
        basBizPeriodService.validateBillDate(entity.getBillDate());
        return super.updateById(entity);
    }

    @Override
    @Transactional
    public void createReceivable(StkIoBill stkIoBill, List<StkIoBillEntry> stkIoBillEntryList) {
        BigDecimal amt = new BigDecimal(0);
        for(StkIoBillEntry entry : stkIoBillEntryList) {
            amt = amt.add(entry.getSettleAmt());
        }

        FinReceivable finReceivable = new FinReceivable();
        finReceivable.setReceivableType("102");//销售应收
        finReceivable.setIsRubric(stkIoBill.getIsRubric());
        finReceivable.setIsAuto(1);
        if (stkIoBill.getStockIoType().equals("201")) {
            //销售出库
            finReceivable.setSourceType("stk_io_bill..201");
        }
        finReceivable.setSourceId(stkIoBill.getId());
        finReceivable.setSourceNo(stkIoBill.getBillNo());
        finReceivable.setBillNo((String) FillRuleUtil.executeRule("receivable_bill_no", null));
        finReceivable.setBillDate(stkIoBill.getBillDate()); //注意：如果设为系统日期，有可能小于当前业务期间
        finReceivable.setAmt(amt);
        finReceivable.setCheckedAmt(new BigDecimal(0));
        finReceivable.setCustomerId(stkIoBill.getCustomerId());

        LoginUser sysUser = (LoginUser) SecurityUtils.getSubject().getPrincipal();
        finReceivable.setApproverId(sysUser.getUsername());
        finReceivable.setIsApproved(1);
        finReceivable.setEffectiveTime(new Date());
        finReceivable.setBillProcStatus("23");
        finReceivable.setIsClosed(0);
        finReceivable.setIsVoided(0);
        finReceivableMapper.insert(finReceivable);
    }

    @Override
    @Transactional
    public void approve(String id) {
        FinReceivable finReceivable = finReceivableMapper.selectById(id);
        if (finReceivable == null) {
            throw new JeecgBootException(String.format("【ID：%s】应收单不存在！", id));
        }

        LoginUser sysUser = (LoginUser) SecurityUtils.getSubject().getPrincipal();
        finReceivable.setApproverId(sysUser.getUsername());
        finReceivable.setIsApproved(1);
        finReceivable.setEffectiveTime(new Date());
        finReceivable.setBillProcStatus("23");
        finReceivableMapper.updateById(finReceivable);
    }

    @Override
    public boolean isApproved(Integer year, Integer month) {
        QueryWrapper<FinReceivable> queryWrapper = new QueryWrapper<>();
        queryWrapper.apply("YEAR(bill_date) = {0} AND MONTH(bill_date) = {1}", year, month);
        queryWrapper.eq("is_closed", 0);
        queryWrapper.eq("is_voided", 0);
        queryWrapper.eq("is_approved", 0);
        return finReceivableMapper.selectCount(queryWrapper) == 0;
    }

    @Override
    public BigDecimal getUncheckedAmt(String id) {
        FinReceivable finReceivable = finReceivableMapper.selectById(id);
        return finReceivable != null ? finReceivable.getUncheckedAmt() : null;
    }

    @Override
    @Transactional
    public void checkAmt(String id, BigDecimal amt) {
        FinReceivable finReceivable = finReceivableMapper.selectById(id);
        if (finReceivable == null) {
            throw new JeecgBootException(String.format("【ID：%s】应收单不存在！", id));
        }

        BigDecimal checkedAmt = finReceivable.getCheckedAmt().add(amt);
        if (finReceivable.getAmt().compareTo(checkedAmt) < 0 ) {
            throw new JeecgBootException(String.format("【单据号：%s】核销金额不能大于未核金额！",
                    finReceivable.getBillNo() ));
        }
        finReceivable.setCheckedAmt(checkedAmt);
        finReceivableMapper.updateById(finReceivable);
    }
}