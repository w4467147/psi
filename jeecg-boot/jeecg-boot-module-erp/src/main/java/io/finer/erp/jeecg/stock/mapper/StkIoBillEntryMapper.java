package io.finer.erp.jeecg.stock.mapper;

import java.util.List;
import io.finer.erp.jeecg.stock.entity.StkIoBillEntry;
import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import org.apache.ibatis.annotations.Param;

/**
 * @Description: 明细
 * @Author: jeecg-boot
 * @Date:   2020-03-31
 * @Version: V1.0
 */
public interface StkIoBillEntryMapper extends BaseMapper<StkIoBillEntry> {

	public boolean deleteByMainId(@Param("mainId") String mainId);
    
	public List<StkIoBillEntry> selectByMainId(@Param("mainId") String mainId);
}
