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
 * @Description: fin_receivable_bal
 * @Author: jeecg-boot
 * @Date:   2020-05-25
 * @Version: V1.0
 */
@Data
@TableName("fin_receivable_bal")
@Accessors(chain = true)
@EqualsAndHashCode(callSuper = false)
@ApiModel(value="fin_receivable_bal对象", description="fin_receivable_bal")
public class FinReceivableBal implements Serializable {
    private static final long serialVersionUID = 1L;

	/**ID*/
	@TableId(type = IdType.ID_WORKER_STR)
    @ApiModelProperty(value = "ID")
    private String id;
	/**业务年度*/
	@Excel(name = "业务年度", width = 15)
    @ApiModelProperty(value = "业务年度")
    private Integer year;
	/**业务月度*/
	@Excel(name = "业务月度", width = 15)
    @ApiModelProperty(value = "业务月度")
    private Integer month;
	/**客户*/
	@Excel(name = "客户", width = 15, dictTable = "bas_customer", dicText = "name", dicCode = "id")
	@Dict(dictTable = "bas_customer", dicText = "name", dicCode = "id")
    @ApiModelProperty(value = "客户")
    private String customerId;
	/**期初余额*/
	@Excel(name = "期初余额", width = 15)
    @ApiModelProperty(value = "期初余额")
    private BigDecimal beginDebitBal;
	/**借方金额*/
	@Excel(name = "借方金额", width = 15)
    @ApiModelProperty(value = "借方金额")
    private BigDecimal debitAmt;
	/**贷方金额*/
	@Excel(name = "贷方金额", width = 15)
    @ApiModelProperty(value = "贷方金额")
    private BigDecimal creditAmt;
	/**是否初始数据*/
	@Excel(name = "是否初始数据", width = 15, dicCode = "yn")
	@Dict(dicCode = "yn")
    @ApiModelProperty(value = "是否初始数据")
    private Integer isInit;
	/**版本*/
    @ApiModelProperty(value = "版本")
    private Integer version;

	/**借方余额*/
	@TableField(exist = false)
	private BigDecimal debitBal;

	public BigDecimal getDebitBal() {
		//controller中，QueryWrapper也会创建entity, return null，是为了避免作为查询数据库参数。
		return id == null ? null : beginDebitBal.add(debitAmt).subtract(creditAmt);
	}

}
