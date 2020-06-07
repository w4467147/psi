package io.finer.erp.jeecg.bas.service;

import io.finer.erp.jeecg.bas.entity.BasWarehouse;
import com.baomidou.mybatisplus.extension.service.IService;
import org.jeecg.common.exception.JeecgBootException;

/**
 * @Description: 仓库
 * @Author: jeecg-boot
 * @Date:   2020-04-01
 * @Version: V1.0
 */
public interface IBasWarehouseService extends IService<BasWarehouse> {

	/**根节点父ID的值*/
	public static final String ROOT_PID_VALUE = "0";
	
	/**树节点有子节点状态值*/
	public static final String HASCHILD = "1";
	
	/**树节点无子节点状态值*/
	public static final String NOCHILD = "0";

	/**新增节点*/
	void addBasWarehouse(BasWarehouse basWarehouse);
	
	/**修改节点*/
	void updateBasWarehouse(BasWarehouse basWarehouse) throws JeecgBootException;
	
	/**删除节点*/
	void deleteBasWarehouse(String id) throws JeecgBootException;

}
