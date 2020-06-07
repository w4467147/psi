package io.finer.erp.jeecg.bas.service;

import io.finer.erp.jeecg.bas.entity.BasMeasureUnit;
import com.baomidou.mybatisplus.extension.service.IService;
import org.jeecg.common.exception.JeecgBootException;

import java.math.BigDecimal;

/**
 * @Description: 计量单位
 * @Author: jeecg-boot
 * @Date:   2020-03-27
 * @Version: V1.0
 */
public interface IBasMeasureUnitService extends IService<BasMeasureUnit> {

	/**根节点父ID的值*/
	public static final String ROOT_PID_VALUE = "0";
	
	/**树节点有子节点状态值*/
	public static final String HASCHILD = "1";
	
	/**树节点无子节点状态值*/
	public static final String NOCHILD = "0";

	/**新增节点*/
	void addBasMeasureUnit(BasMeasureUnit basMeasureUnit);
	
	/**修改节点*/
	void updateBasMeasureUnit(BasMeasureUnit basMeasureUnit) throws JeecgBootException;
	
	/**删除节点*/
	void deleteBasMeasureUnit(String id) throws JeecgBootException;

	BigDecimal getRate(String toId, String fromId);
}
