package io.finer.erp.jeecg.finance.mapper;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import io.finer.erp.jeecg.finance.entity.FinSalInvoiceEntry;
import org.apache.ibatis.annotations.Param;

import java.util.List;

/**
 * @Description: 明细
 * @Author: jeecg-boot
 * @Date:   2020-05-21
 * @Version: V1.0
 */
public interface FinSalInvoiceEntryMapper extends BaseMapper<FinSalInvoiceEntry> {

	public boolean deleteByMainId(@Param("mainId") String mainId);
    
	public List<FinSalInvoiceEntry> selectByMainId(@Param("mainId") String mainId);
}
