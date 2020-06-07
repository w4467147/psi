package io.finer.erp.jeecg.stock.mapper;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.baomidou.mybatisplus.core.metadata.IPage;
import io.finer.erp.jeecg.stock.entity.StkIoBill;
import org.apache.ibatis.annotations.Param;

import java.util.List;

/**
 * @Description: 出入库单
 * @Author: jeecg-boot
 * @Date:   2020-03-31
 * @Version: V1.0
 */
public interface StkIoBillMapper extends BaseMapper<StkIoBill> {

    public IPage<StkIoBill> selectByStockIoType(IPage page, @Param("stockIoType") String stockIoType);
}
