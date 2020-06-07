package io.finer.erp.jeecg.bas.entity;

import java.io.Serializable;
import java.io.UnsupportedEncodingException;
import java.util.Date;
import java.math.BigDecimal;
import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;
import lombok.Data;
import com.fasterxml.jackson.annotation.JsonFormat;
import org.springframework.format.annotation.DateTimeFormat;
import org.jeecgframework.poi.excel.annotation.Excel;
import org.jeecg.common.aspect.annotation.Dict;
import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;
import lombok.EqualsAndHashCode;
import lombok.experimental.Accessors;

/**
 * @Description: bas_biz_period
 * @Author: jeecg-boot
 * @Date:   2020-05-25
 * @Version: V1.0
 */
@Data
@TableName("bas_biz_period")
@Accessors(chain = true)
@EqualsAndHashCode(callSuper = false)
@ApiModel(value="bas_biz_period对象", description="bas_biz_period")
public class BasBizPeriod implements Serializable {
    private static final long serialVersionUID = 1L;

	/**ID*/
	@TableId(type = IdType.ID_WORKER_STR)
    @ApiModelProperty(value = "ID")
    private java.lang.String id;
	/**启用年度*/
	@Excel(name = "启用年度", width = 15)
    @ApiModelProperty(value = "启用年度")
    private java.lang.Integer beginYear;
	/**启用月度*/
	@Excel(name = "启用月度", width = 15)
    @ApiModelProperty(value = "启用月度")
    private java.lang.Integer beginMonth;
	/**当前年度*/
	@Excel(name = "当前年度", width = 15)
    @ApiModelProperty(value = "当前年度")
    private java.lang.Integer year;
	/**当前月度*/
	@Excel(name = "当前月度", width = 15)
    @ApiModelProperty(value = "当前月度")
    private java.lang.Integer month;
	/**版本*/
    @ApiModelProperty(value = "版本")
    private java.lang.Integer version;
}
