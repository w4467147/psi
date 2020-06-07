package io.finer.erp.jeecg.finance.service.impl;

import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import io.finer.erp.jeecg.finance.entity.FinReceivableCheckEntry;
import io.finer.erp.jeecg.finance.mapper.FinReceivableCheckEntryMapper;
import io.finer.erp.jeecg.finance.service.IFinReceiptService;
import io.finer.erp.jeecg.finance.service.IFinReceivableCheckEntryService;
import io.finer.erp.jeecg.finance.service.IFinReceivableService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

/**
 * @Description: fin_receivable_check_entry
 * @Author: jeecg-boot
 * @Date:   2020-04-17
 * @Version: V1.0
 */
@Service
public class FinReceivableCheckEntryServiceImpl extends ServiceImpl<FinReceivableCheckEntryMapper, FinReceivableCheckEntry> implements IFinReceivableCheckEntryService {

    @Autowired
    private FinReceivableCheckEntryMapper finReceivableCheckEntryMapper;
    @Autowired
    private IFinReceivableService finReceivableService;
    @Autowired
    private IFinReceiptService finReceiptService;


    @Override
    public List<FinReceivableCheckEntry> selectByMainId(String mainId) {
        List<FinReceivableCheckEntry> finReceivableCheckEntryList = finReceivableCheckEntryMapper.selectByMainId(mainId);
        for(FinReceivableCheckEntry entry:finReceivableCheckEntryList) {
            //20200428 cfm: 待完善（不同源单类型）
            entry.setUncheckedAmt(entry.getCheckSide().equals("1") ?
                    finReceivableService.getUncheckedAmt(entry.getSourceId()) :
                    finReceiptService.getUncheckedAmt(entry.getSourceId()));
        }
        return finReceivableCheckEntryList;
    }
}
