package io.finer.erp.jeecg.bas.entity;

import java.io.Serializable;
import java.util.Date;
import java.math.BigDecimal;
import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;
import io.swagger.annotations.ApiModelProperty;
import lombok.Data;
import com.fasterxml.jackson.annotation.JsonFormat;
import org.springframework.format.annotation.DateTimeFormat;
import org.jeecgframework.poi.excel.annotation.Excel;
import org.jeecg.common.aspect.annotation.Dict;

/**
 * @Description: 计量单位
 * @Author: jeecg-boot
 * @Date:   2020-03-27
 * @Version: V1.0
 */
@Data
@TableName("bas_measure_unit")
public class BasMeasureUnit implements Serializable {
    private static final long serialVersionUID = 1L;

	/**ID*/
	@TableId(type = IdType.ID_WORKER_STR)
	private java.lang.String id;
	/**名称*/
	@Excel(name = "名称", width = 15)
	private java.lang.String name;
	/**符号*/
	@Excel(name = "符号", width = 15)
	private java.lang.String symbol;
	/**是否基准*/
	@Excel(name = "是否基准", width = 15, dicCode = "yn")
	@Dict(dicCode = "yn")
	private java.lang.String hasChild;
	/**基准单位*/
	@Excel(name = "基准单位", width = 15)
	private java.lang.String pid;
	/**换算系数*/
	@Excel(name = "换算系数", width = 15)
	private java.math.BigDecimal factor;
	/**是否启用*/
	@Excel(name = "是否启用", width = 15, dicCode = "yn")
	@Dict(dicCode = "yn")
	private java.lang.Integer isEnabled;
	/**创建人*/
	@Dict(dictTable = "sys_user", dicText = "realname", dicCode = "username")
	@Excel(name = "创建人", width = 15)
	private java.lang.String createBy;
	/**创建时间*/
	@Excel(name = "创建时间", width = 15, format = "yyyy-MM-dd")
	@JsonFormat(timezone = "GMT+8",pattern = "yyyy-MM-dd")
    @DateTimeFormat(pattern="yyyy-MM-dd")
	private java.util.Date createTime;
	/**修改人*/
	@Dict(dictTable = "sys_user", dicText = "realname", dicCode = "username")
	@Excel(name = "修改人", width = 15)
	private java.lang.String updateBy;
	/**修改时间*/
	@Excel(name = "修改时间", width = 15, format = "yyyy-MM-dd")
	@JsonFormat(timezone = "GMT+8",pattern = "yyyy-MM-dd")
    @DateTimeFormat(pattern="yyyy-MM-dd")
	private java.util.Date updateTime;
	/**版本*/
	@ApiModelProperty(value = "版本")
	private java.lang.Integer version;
}
