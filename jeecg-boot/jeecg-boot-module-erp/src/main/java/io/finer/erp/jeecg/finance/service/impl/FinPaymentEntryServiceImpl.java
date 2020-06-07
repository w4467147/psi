package io.finer.erp.jeecg.finance.service.impl;

import io.finer.erp.jeecg.finance.entity.FinPaymentEntry;
import io.finer.erp.jeecg.finance.mapper.FinPaymentEntryMapper;
import io.finer.erp.jeecg.finance.service.IFinPaymentEntryService;
import org.springframework.stereotype.Service;
import java.util.List;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import org.springframework.beans.factory.annotation.Autowired;

/**
 * @Description: 付款明细
 * @Author: jeecg-boot
 * @Date:   2020-04-14
 * @Version: V1.0
 */
@Service
public class FinPaymentEntryServiceImpl extends ServiceImpl<FinPaymentEntryMapper, FinPaymentEntry> implements IFinPaymentEntryService {
	
	@Autowired
	private FinPaymentEntryMapper finPaymentEntryMapper;
	
	@Override
	public List<FinPaymentEntry> selectByMainId(String mainId) {
		return finPaymentEntryMapper.selectByMainId(mainId);
	}
}
