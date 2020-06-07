package io.finer.erp.jeecg.finance.mapper;

import java.util.List;
import io.finer.erp.jeecg.finance.entity.FinPaymentEntry;
import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import org.apache.ibatis.annotations.Param;

/**
 * @Description: 付款明细
 * @Author: jeecg-boot
 * @Date:   2020-04-14
 * @Version: V1.0
 */
public interface FinPaymentEntryMapper extends BaseMapper<FinPaymentEntry> {

	public boolean deleteByMainId(@Param("mainId") String mainId);
    
	public List<FinPaymentEntry> selectByMainId(@Param("mainId") String mainId);
}
