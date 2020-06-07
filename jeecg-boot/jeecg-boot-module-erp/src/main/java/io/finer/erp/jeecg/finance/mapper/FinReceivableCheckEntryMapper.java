package io.finer.erp.jeecg.finance.mapper;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import io.finer.erp.jeecg.finance.entity.FinReceivableCheckEntry;
import org.apache.ibatis.annotations.Param;

import java.util.List;

/**
 * @Description: fin_receivable_check_entry
 * @Author: jeecg-boot
 * @Date:   2020-04-17
 * @Version: V1.0
 */
public interface FinReceivableCheckEntryMapper extends BaseMapper<FinReceivableCheckEntry> {

    public boolean deleteByMainId(@Param("mainId") String mainId);

    public List<FinReceivableCheckEntry> selectByMainId(@Param("mainId") String mainId);
}
