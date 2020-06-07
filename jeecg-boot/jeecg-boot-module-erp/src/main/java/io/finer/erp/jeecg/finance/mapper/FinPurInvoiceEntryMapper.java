package io.finer.erp.jeecg.finance.mapper;

import java.util.List;
import io.finer.erp.jeecg.finance.entity.FinPurInvoiceEntry;
import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import org.apache.ibatis.annotations.Param;

/**
 * @Description: 明细
 * @Author: jeecg-boot
 * @Date:   2020-05-21
 * @Version: V1.0
 */
public interface FinPurInvoiceEntryMapper extends BaseMapper<FinPurInvoiceEntry> {

	public boolean deleteByMainId(@Param("mainId") String mainId);
    
	public List<FinPurInvoiceEntry> selectByMainId(@Param("mainId") String mainId);
}
