package io.finer.erp.jeecg.finance.vo;

import java.util.List;
import io.finer.erp.jeecg.finance.entity.FinPurInvoice;
import io.finer.erp.jeecg.finance.entity.FinPurInvoiceEntry;
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
 * @Description: 采购发票登记
 * @Author: jeecg-boot
 * @Date:   2020-05-21
 * @Version: V1.0
 */
@Data
@ApiModel(value="fin_pur_invoicePage对象", description="采购发票登记")
public class FinPurInvoicePage {

	/**ID*/
	@ApiModelProperty(value = "ID")
	private java.lang.String id;
	/**单据编号*/
	@Excel(name = "单据编号", width = 15)
	@ApiModelProperty(value = "单据编号")
	private java.lang.String billNo;
	/**单据日期*/
	@Excel(name = "单据日期", width = 15, format = "yyyy-MM-dd")
	@JsonFormat(timezone = "GMT+8",pattern = "yyyy-MM-dd")
    @DateTimeFormat(pattern="yyyy-MM-dd")
	@ApiModelProperty(value = "单据日期")
	private java.util.Date billDate;
	/**是否自动生成*/
	@Excel(name = "是否自动生成", width = 15)
	@ApiModelProperty(value = "是否自动生成")
	private java.lang.Integer isAuto;
	/**发票类型*/
	@Excel(name = "发票类型", width = 15)
	@ApiModelProperty(value = "发票类型")
	private java.lang.String invoiceType;
	/**是否红字*/
	@Excel(name = "是否红字", width = 15)
	@ApiModelProperty(value = "是否红字")
	private java.lang.Integer isRubric;
	/**源单类型*/
	@Excel(name = "源单类型", width = 15)
	@ApiModelProperty(value = "源单类型")
	private java.lang.String sourceType;
	/**源单id*/
	@Excel(name = "源单id", width = 15)
	@ApiModelProperty(value = "源单id")
	private java.lang.String sourceId;
	/**源单号*/
	@Excel(name = "源单号", width = 15)
	@ApiModelProperty(value = "源单号")
	private java.lang.String sourceNo;
	/**业务员*/
	@Excel(name = "业务员", width = 15)
	@ApiModelProperty(value = "业务员")
	private java.lang.String clerkId;
	/**供应商*/
	@Excel(name = "供应商", width = 15)
	@ApiModelProperty(value = "供应商")
	private java.lang.String supplierId;
	/**附件*/
	@Excel(name = "附件", width = 15)
	@ApiModelProperty(value = "附件")
	private java.lang.String attachment;
	/**备注*/
	@Excel(name = "备注", width = 15)
	@ApiModelProperty(value = "备注")
	private java.lang.String remark;
	/**处理状态*/
	@Excel(name = "处理状态", width = 15)
	@ApiModelProperty(value = "处理状态")
	private java.lang.String billProcStatus;
	/**审核人*/
	@Excel(name = "审核人", width = 15)
	@ApiModelProperty(value = "审核人")
	private java.lang.String approverId;
	/**流程id*/
	@Excel(name = "流程id", width = 15)
	@ApiModelProperty(value = "流程id")
	private java.lang.String flowId;
	/**是否通过*/
	@Excel(name = "是否通过", width = 15)
	@ApiModelProperty(value = "是否通过")
	private java.lang.Integer isApproved;
	/**生效时间*/
	@Excel(name = "生效时间", width = 15, format = "yyyy-MM-dd")
	@JsonFormat(timezone = "GMT+8",pattern = "yyyy-MM-dd")
    @DateTimeFormat(pattern="yyyy-MM-dd")
	@ApiModelProperty(value = "生效时间")
	private java.util.Date effectiveTime;
	/**是否作废*/
	@Excel(name = "是否作废", width = 15)
	@ApiModelProperty(value = "是否作废")
	private java.lang.Integer isVoided;
	/**是否关闭*/
	@Excel(name = "是否关闭", width = 15)
	@ApiModelProperty(value = "是否关闭")
	private java.lang.Integer isClosed;
	/**创建部门*/
	@ApiModelProperty(value = "创建部门")
	private java.lang.String sysOrgCode;
	/**创建人*/
	@ApiModelProperty(value = "创建人")
	private java.lang.String createBy;
	/**创建时间*/
	@JsonFormat(timezone = "GMT+8",pattern = "yyyy-MM-dd")
    @DateTimeFormat(pattern="yyyy-MM-dd")
	@ApiModelProperty(value = "创建时间")
	private java.util.Date createTime;
	/**修改人*/
	@ApiModelProperty(value = "修改人")
	private java.lang.String updateBy;
	/**修改时间*/
	@JsonFormat(timezone = "GMT+8",pattern = "yyyy-MM-dd")
    @DateTimeFormat(pattern="yyyy-MM-dd")
	@ApiModelProperty(value = "修改时间")
	private java.util.Date updateTime;
	/**版本*/
	@Excel(name = "版本", width = 15)
	@ApiModelProperty(value = "版本")
	private java.lang.Integer version;
	
	@ExcelCollection(name="明细")
	@ApiModelProperty(value = "明细")
	private List<FinPurInvoiceEntry> finPurInvoiceEntryList;
	
}
