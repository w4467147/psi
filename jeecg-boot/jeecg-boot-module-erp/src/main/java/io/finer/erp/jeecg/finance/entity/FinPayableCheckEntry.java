package io.finer.erp.jeecg.finance.entity;

import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableField;
import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;
import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;
import lombok.Data;
import lombok.EqualsAndHashCode;
import lombok.experimental.Accessors;
import org.jeecg.common.aspect.annotation.Dict;
import org.jeecgframework.poi.excel.annotation.Excel;

import java.io.Serializable;
import java.math.BigDecimal;

/**
 * @Description: fin_payable_check_entry
 * @Author: jeecg-boot
 * @Date:   2020-04-17
 * @Version: V1.0
 */
@Data
@TableName("fin_payable_check_entry")
@Accessors(chain = true)
@EqualsAndHashCode(callSuper = false)
@ApiModel(value="fin_payable_check_entry对象", description="fin_payable_check_entry")
public class FinPayableCheckEntry implements Serializable {
    private static final long serialVersionUID = 1L;

	/**ID*/
	@TableId(type = IdType.ID_WORKER_STR)
    @ApiModelProperty(value = "ID")
    private String id;
	/**主表*/
	@Excel(name = "主表", width = 15)
    @ApiModelProperty(value = "主表")
    private String mid;
    /**单据编号*/
    @Excel(name = "单据编号", width = 15)
    @ApiModelProperty(value = "单据编号")
    private String billNo;
	/**分录号*/
	@Excel(name = "分录号", width = 15)
    @ApiModelProperty(value = "分录号")
    private Integer entryNo;
    /**核销方向*/
    @Excel(name = "核销方向", width = 15, dicCode = "x_rp_check_side")
    @Dict(dicCode = "x_rp_check_side")
    @ApiModelProperty(value = "核销方向")
    private String checkSide;
    /**源单类型*/
    @Excel(name = "源单类型", width = 15, dicCode = "x_bill_type")
    @Dict(dicCode = "x_bill_type")
    @ApiModelProperty(value = "源单类型")
    private String sourceType;
    /**源单id*/
    @Excel(name = "源单id", width = 15)
    @ApiModelProperty(value = "源单id")
    private String sourceId;
    /**源单号*/
    @Excel(name = "源单号", width = 15)
    @ApiModelProperty(value = "源单号")
    private String sourceNo;
	/**核销金额*/
	@Excel(name = "核销金额", width = 15)
    @ApiModelProperty(value = "核销金额")
    private BigDecimal amt;
	/**备注*/
	@Excel(name = "备注", width = 15)
    @ApiModelProperty(value = "备注")
    private String remark;
	/**版本*/
    @ApiModelProperty(value = "版本")
    private Integer version;

    /**未核销金额*/
    @TableField(exist = false)
    @Excel(name = "未核销金额", width = 15)
    @ApiModelProperty(value = "未核销金额")
    private BigDecimal uncheckedAmt;
}
