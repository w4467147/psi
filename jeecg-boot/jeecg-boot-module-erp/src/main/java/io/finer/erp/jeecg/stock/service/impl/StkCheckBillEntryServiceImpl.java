package io.finer.erp.jeecg.stock.service.impl;

import io.finer.erp.jeecg.stock.entity.StkCheckBillEntry;
import io.finer.erp.jeecg.stock.mapper.StkCheckBillEntryMapper;
import io.finer.erp.jeecg.stock.service.IStkCheckBillEntryService;
import org.springframework.stereotype.Service;
import java.util.List;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import org.springframework.beans.factory.annotation.Autowired;

/**
 * @Description: 明细
 * @Author: jeecg-boot
 * @Date:   2020-05-18
 * @Version: V1.0
 */
@Service
public class StkCheckBillEntryServiceImpl extends ServiceImpl<StkCheckBillEntryMapper, StkCheckBillEntry> implements IStkCheckBillEntryService {
	
	@Autowired
	private StkCheckBillEntryMapper stkCheckBillEntryMapper;
	
	@Override
	public List<StkCheckBillEntry> selectByMainId(String mainId) {
		return stkCheckBillEntryMapper.selectByMainId(mainId);
	}
}
