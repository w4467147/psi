package io.finer.erp.jeecg.stock.mapper;

import java.util.List;
import io.finer.erp.jeecg.stock.entity.StkCheckBillEntry;
import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import org.apache.ibatis.annotations.Param;

/**
 * @Description: 明细
 * @Author: jeecg-boot
 * @Date:   2020-05-18
 * @Version: V1.0
 */
public interface StkCheckBillEntryMapper extends BaseMapper<StkCheckBillEntry> {

	public boolean deleteByMainId(@Param("mainId") String mainId);
    
	public List<StkCheckBillEntry> selectByMainId(@Param("mainId") String mainId);
}
