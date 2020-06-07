package io.finer.erp.jeecg.bas.vo;

import java.util.List;
import io.finer.erp.jeecg.bas.entity.BasMaterialCategory;
import io.finer.erp.jeecg.bas.entity.BasMaterial;
import lombok.Data;
import org.jeecgframework.poi.excel.annotation.Excel;
import org.jeecgframework.poi.excel.annotation.ExcelEntity;
import org.jeecgframework.poi.excel.annotation.ExcelCollection;
import com.fasterxml.jackson.annotation.JsonFormat;
import org.springframework.format.annotation.DateTimeFormat;
import java.util.Date;
import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;

/**
 * @Description: 物料分类
 * @Author: jeecg-boot
 * @Date:   2020-03-29
 * @Version: V1.0
 */
@Data
@ApiModel(value="bas_material_categoryPage对象", description="物料分类")
public class BasMaterialCategoryPage {
	
	/**ID*/
	@ApiModelProperty(value = "ID")
	private java.lang.String id;
	/**父节点*/
	@Excel(name = "父节点", width = 15)
	@ApiModelProperty(value = "父节点")
	private java.lang.String pid;
	/**是否有子节点*/
	@Excel(name = "是否有子节点", width = 15)
	@ApiModelProperty(value = "是否有子节点")
	private java.lang.String hasChild;
	/**名称*/
	@Excel(name = "名称", width = 15)
	@ApiModelProperty(value = "名称")
	private java.lang.String name;
	/**编码*/
	@Excel(name = "编码", width = 15)
	@ApiModelProperty(value = "编码")
	private java.lang.String code;
	/**全名*/
	@Excel(name = "全名", width = 15)
	@ApiModelProperty(value = "全名")
	private java.lang.String fullname;
	/**是否启用*/
	@Excel(name = "是否启用", width = 15)
	@ApiModelProperty(value = "是否启用")
	private java.lang.Integer isEnabled;
	/**创建人*/
	@Excel(name = "创建人", width = 15)
	@ApiModelProperty(value = "创建人")
	private java.lang.String createBy;
	/**创建时间*/
	@Excel(name = "创建时间", width = 15, format = "yyyy-MM-dd")
	@JsonFormat(timezone = "GMT+8",pattern = "yyyy-MM-dd")
    @DateTimeFormat(pattern="yyyy-MM-dd")
	@ApiModelProperty(value = "创建时间")
	private java.util.Date createTime;
	/**修改人*/
	@Excel(name = "修改人", width = 15)
	@ApiModelProperty(value = "修改人")
	private java.lang.String updateBy;
	/**修改时间*/
	@Excel(name = "修改时间", width = 15, format = "yyyy-MM-dd")
	@JsonFormat(timezone = "GMT+8",pattern = "yyyy-MM-dd")
    @DateTimeFormat(pattern="yyyy-MM-dd")
	@ApiModelProperty(value = "修改时间")
	private java.util.Date updateTime;
	/**版本*/
	@Excel(name = "版本", width = 15)
	@ApiModelProperty(value = "版本")
	private java.lang.Integer version;
	
	@ExcelCollection(name="物料")
	@ApiModelProperty(value = "物料")
	private List<BasMaterial> basMaterialList;
	
}
