package io.finer.erp.jeecg.finance.mapper;

import java.util.List;
import io.finer.erp.jeecg.finance.entity.FinReceiptEntry;
import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import org.apache.ibatis.annotations.Param;

/**
 * @Description: 收款明细
 * @Author: jeecg-boot
 * @Date:   2020-04-30
 * @Version: V1.0
 */
public interface FinReceiptEntryMapper extends BaseMapper<FinReceiptEntry> {

	public boolean deleteByMainId(@Param("mainId") String mainId);
    
	public List<FinReceiptEntry> selectByMainId(@Param("mainId") String mainId);
}
