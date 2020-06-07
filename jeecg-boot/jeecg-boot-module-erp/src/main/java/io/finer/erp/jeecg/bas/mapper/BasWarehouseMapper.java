package io.finer.erp.jeecg.bas.mapper;

import org.apache.ibatis.annotations.Param;
import io.finer.erp.jeecg.bas.entity.BasWarehouse;
import com.baomidou.mybatisplus.core.mapper.BaseMapper;

/**
 * @Description: 仓库
 * @Author: jeecg-boot
 * @Date:   2020-04-01
 * @Version: V1.0
 */
public interface BasWarehouseMapper extends BaseMapper<BasWarehouse> {

	/**
	 * 编辑节点状态
	 * @param id
	 * @param status
	 */
	void updateTreeNodeStatus(@Param("id") String id,@Param("status") String status);

}
