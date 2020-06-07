package io.finer.erp.jeecg.finance.service.impl;

import io.finer.erp.jeecg.finance.entity.FinReceiptEntry;
import io.finer.erp.jeecg.finance.mapper.FinReceiptEntryMapper;
import io.finer.erp.jeecg.finance.service.IFinReceiptEntryService;
import org.springframework.stereotype.Service;
import java.util.List;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import org.springframework.beans.factory.annotation.Autowired;

/**
 * @Description: 收款明细
 * @Author: jeecg-boot
 * @Date:   2020-04-30
 * @Version: V1.0
 */
@Service
public class FinReceiptEntryServiceImpl extends ServiceImpl<FinReceiptEntryMapper, FinReceiptEntry> implements IFinReceiptEntryService {
	
	@Autowired
	private FinReceiptEntryMapper finReceiptEntryMapper;
	
	@Override
	public List<FinReceiptEntry> selectByMainId(String mainId) {
		return finReceiptEntryMapper.selectByMainId(mainId);
	}
}
