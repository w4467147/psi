package io.finer.erp.jeecg.finance.entity;

import java.io.Serializable;
import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;
import lombok.Data;
import com.fasterxml.jackson.annotation.JsonFormat;
import org.jeecg.common.aspect.annotation.Dict;
import org.springframework.format.annotation.DateTimeFormat;
import org.jeecgframework.poi.excel.annotation.Excel;
import java.util.Date;
import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;

/**
 * @Description: 收款明细
 * @Author: jeecg-boot
 * @Date:   2020-04-30
 * @Version: V1.0
 */
@ApiModel(value="fin_receipt对象", description="收款单")
@Data
@TableName("fin_receipt_entry")
public class FinReceiptEntry implements Serializable {
    private static final long serialVersionUID = 1L;

	/**ID*/
	@TableId(type = IdType.ID_WORKER_STR)
	@ApiModelProperty(value = "ID")
	private java.lang.String id;
	/**主表*/
	@ApiModelProperty(value = "主表")
	private java.lang.String mid;
	/**单据编号*/
	@Excel(name = "单据编号", width = 15)
	@ApiModelProperty(value = "单据编号")
	private java.lang.String billNo;
	/**分录号*/
	@Excel(name = "分录号", width = 15)
	@ApiModelProperty(value = "分录号")
	private java.lang.Integer entryNo;
	/**源单类型*/
	@Excel(name = "源单类型", width = 15, dicCode = "x_bill_type")
	@Dict(dicCode = "x_bill_type")
	@ApiModelProperty(value = "源单类型")
	private java.lang.String sourceType;
	/**源单分录id*/
	@Excel(name = "源单分录id", width = 15)
	@ApiModelProperty(value = "源单分录id")
	private java.lang.String sourceEntryId;
	/**源单分录号*/
	@Excel(name = "源单分录号", width = 15)
	@ApiModelProperty(value = "源单分录号")
	private java.lang.String sourceEntryNo;
	/**结算方式*/
	@Excel(name = "结算方式", width = 15, dicCode = "x_settle_method")
	@Dict( dicCode = "x_settle_method")
	@ApiModelProperty(value = "结算方式")
	private java.lang.String settleMethod;
	/**资金账户*/
	@Excel(name = "资金账户", width = 15, dictTable = "bas_bank_account", dicText = "account_no", dicCode = "id")
	@Dict(dictTable = "bas_bank_account", dicText = "account_no", dicCode = "id")
	@ApiModelProperty(value = "资金账户")
	private java.lang.String bankAccountId;
	/**金额*/
	@Excel(name = "金额", width = 15)
	@ApiModelProperty(value = "金额")
	private java.math.BigDecimal amt;
	/**备注*/
	@Excel(name = "备注", width = 15)
	@ApiModelProperty(value = "备注")
	private java.lang.String remark;
	/**备注2*/
	@Excel(name = "备注2", width = 15)
	@ApiModelProperty(value = "备注2")
	private java.lang.String remark2;
	/**备注3*/
	@Excel(name = "备注3", width = 15)
	@ApiModelProperty(value = "备注3")
	private java.lang.String remark3;
	/**版本*/
	@ApiModelProperty(value = "版本")
	private java.lang.Integer version;
}
