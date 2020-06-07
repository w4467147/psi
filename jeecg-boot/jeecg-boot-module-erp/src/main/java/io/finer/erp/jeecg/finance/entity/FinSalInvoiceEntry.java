package io.finer.erp.jeecg.finance.entity;

import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableField;
import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;
import com.fasterxml.jackson.annotation.JsonFormat;
import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;
import lombok.Data;
import org.jeecg.common.aspect.annotation.Dict;
import org.jeecgframework.poi.excel.annotation.Excel;
import org.springframework.format.annotation.DateTimeFormat;

import java.io.Serializable;
import java.util.Date;

/**
 * @Description: 明细
 * @Author:
 * @Date:   2020-05-24
 * @Version: V1.0
 */
@ApiModel(value="fin_sal_invoice对象", description="销售发票登记")
@Data
@TableName("fin_sal_invoice_entry")
public class FinSalInvoiceEntry implements Serializable {
    private static final long serialVersionUID = 1L;

	/**ID*/
	@TableId(type = IdType.ID_WORKER_STR)
	@ApiModelProperty(value = "ID")
	private String id;
	/**主表*/
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
	/**源单类型*/
	@Excel(name = "源单类型", width = 15, dicCode = "x_bill_type")
	@Dict(dicCode = "x_bill_type")
	@ApiModelProperty(value = "源单类型")
	private String sourceType;
	/**源单分录ID*/
	@Excel(name = "源单分录ID", width = 15)
	@ApiModelProperty(value = "源单分录ID")
	private String sourceEntryId;
	/**源单分录号*/
	@Excel(name = "源单分录号", width = 15)
	@ApiModelProperty(value = "源单分录号")
	private String sourceEntryNo;
	/**税率*/
	@Excel(name = "税率", width = 15)
	@ApiModelProperty(value = "税率")
	private java.math.BigDecimal taxRate;
	/**发票号*/
	@Excel(name = "发票号", width = 15)
	@ApiModelProperty(value = "发票号")
	private String invoiceNo;
	/**开票日期*/
	@Excel(name = "开票日期", width = 15, format = "yyyy-MM-dd")
	@JsonFormat(timezone = "GMT+8",pattern = "yyyy-MM-dd")
    @DateTimeFormat(pattern="yyyy-MM-dd")
	@ApiModelProperty(value = "开票日期")
	private Date invoiceDate;
	/**发票数量*/
	@Excel(name = "发票数量", width = 15)
	@ApiModelProperty(value = "发票数量")
	private java.math.BigDecimal invoiceQty;
	/**开票金额*/
	@Excel(name = "开票金额", width = 15)
	@ApiModelProperty(value = "开票金额")
	private java.math.BigDecimal invoiceAmt;
	/**备注*/
	@Excel(name = "备注", width = 15)
	@ApiModelProperty(value = "备注")
	private String remark;
	/**备注2*/
	@Excel(name = "备注2", width = 15)
	@ApiModelProperty(value = "备注2")
	private String remark2;
	/**备注3*/
	@Excel(name = "备注3", width = 15)
	@ApiModelProperty(value = "备注3")
	private String remark3;
	/**版本*/
	@ApiModelProperty(value = "版本")
	private Integer version;

	/**物料ID*/
	@TableField(exist = false)
	private String materialId;
	/**仓库ID*/
	@TableField(exist = false)
	private String warehouseId;
	/**批次号*/
	@TableField(exist = false)
	private String batchNo;
	/**结算数量*/
	@TableField(exist = false)
	private java.math.BigDecimal settleQty;
	/**结算金额*/
	@TableField(exist = false)
	private java.math.BigDecimal settleAmt;
	/**已开票数量*/
	@TableField(exist = false)
	private java.math.BigDecimal invoicedQty;
	/**已开票金额*/
	@TableField(exist = false)
	private java.math.BigDecimal invoicedAmt;
	/**蓝单开票数量（用于红单）*/
	@TableField(exist = false)
	private java.math.BigDecimal blueInvoiceQty;
	/**蓝单开票金额（用于红单）*/
	@TableField(exist = false)
	private java.math.BigDecimal blueInvoiceAmt;
}
