package io.finer.erp.jeecg.bas.service;

import io.finer.erp.jeecg.bas.entity.BasMaterialCategory;
import com.baomidou.mybatisplus.extension.service.IService;
import org.jeecg.common.exception.JeecgBootException;

import java.util.List;

/**
 * @Description: 物料分类
 * @Author: jeecg-boot
 * @Date:   2020-05-29
 * @Version: V1.0
 */
public interface IBasMaterialCategoryService extends IService<BasMaterialCategory> {

	/**根节点父ID的值*/
	public static final String ROOT_PID_VALUE = "0";
	
	/**树节点有子节点状态值*/
	public static final String HASCHILD = "1";
	
	/**树节点无子节点状态值*/
	public static final String NOCHILD = "0";

	/**新增节点*/
	void addBasMaterialCategory(BasMaterialCategory basMaterialCategory);
	
	/**修改节点*/
	void updateBasMaterialCategory(BasMaterialCategory basMaterialCategory) throws JeecgBootException;
	
	/**删除节点*/
	void deleteBasMaterialCategory(String id) throws JeecgBootException;

}
