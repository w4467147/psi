package io.finer.erp.jeecg.finance.vo;

import java.util.List;
import io.finer.erp.jeecg.finance.entity.FinReceipt;
import io.finer.erp.jeecg.finance.entity.FinReceiptEntry;
import lombok.Data;
import org.jeecg.common.aspect.annotation.Dict;
import org.jeecgframework.poi.excel.annotation.Excel;
import org.jeecgframework.poi.excel.annotation.ExcelEntity;
import org.jeecgframework.poi.excel.annotation.ExcelCollection;
import com.fasterxml.jackson.annotation.JsonFormat;
import org.springframework.format.annotation.DateTimeFormat;
import java.util.Date;
import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;

/**
 * @Description: 收款单
 * @Author: jeecg-boot
 * @Date:   2020-04-30
 * @Version: V1.0
 */
@Data
@ApiModel(value="fin_receiptPage对象", description="收款单")
public class FinReceiptPage {
	
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
	/**收款类型*/
	@Excel(name = "收款类型", width = 15)
	@ApiModelProperty(value = "收款类型")
	private java.lang.String receiptType;
	/**是否红字*/
	@Excel(name = "是否红字", width = 15, dicCode = "yn")
	@Dict(dicCode = "yn")
	@ApiModelProperty(value = "是否红字")
	private java.lang.Integer isRubric;
	/**客户*/
	@Excel(name = "客户", width = 15)
	@ApiModelProperty(value = "客户")
	private java.lang.String customerId;
	/**金额*/
	@Excel(name = "金额", width = 15)
	@ApiModelProperty(value = "金额")
	private java.math.BigDecimal amt;
	/**已核销金额*/
	@Excel(name = "已核销金额", width = 15)
	@ApiModelProperty(value = "已核销金额")
	private java.math.BigDecimal checkedAmt;
	/**已抵扣预收金额*/
	@Excel(name = "已抵扣预收金额", width = 15)
	@ApiModelProperty(value = "已抵扣预收金额")
	private java.math.BigDecimal deductedAmt;
	/**附件*/
	@Excel(name = "附件", width = 15)
	@ApiModelProperty(value = "附件")
	private java.lang.String attachmentId;
	/**备注*/
	@Excel(name = "备注", width = 15)
	@ApiModelProperty(value = "备注")
	private java.lang.String remark;
	/**处理状态*/
	@Excel(name = "处理状态", width = 15)
	@ApiModelProperty(value = "处理状态")
	private java.lang.String billProcStatus;
	/**是否通过*/
	@Excel(name = "是否通过", width = 15)
	@ApiModelProperty(value = "是否通过")
	private java.lang.Integer isApproved;
	/**是否关闭*/
	@Excel(name = "是否关闭", width = 15)
	@ApiModelProperty(value = "是否关闭")
	private java.lang.Integer isClosed;
	/**是否作废*/
	@Excel(name = "是否作废", width = 15)
	@ApiModelProperty(value = "是否作废")
	private java.lang.Integer isVoided;
	/**生效时间*/
	@Excel(name = "生效时间", width = 15, format = "yyyy-MM-dd")
	@JsonFormat(timezone = "GMT+8",pattern = "yyyy-MM-dd")
    @DateTimeFormat(pattern="yyyy-MM-dd")
	@ApiModelProperty(value = "生效时间")
	private java.util.Date effectiveTime;
	/**审核人*/
	@Excel(name = "审核人", width = 15)
	@ApiModelProperty(value = "审核人")
	private java.lang.String approverId;
	/**流程*/
	@Excel(name = "流程", width = 15)
	@ApiModelProperty(value = "流程")
	private java.lang.String flowId;
	/**创建时间*/
	@Excel(name = "创建时间", width = 15, format = "yyyy-MM-dd")
	@JsonFormat(timezone = "GMT+8",pattern = "yyyy-MM-dd")
    @DateTimeFormat(pattern="yyyy-MM-dd")
	@ApiModelProperty(value = "创建时间")
	private java.util.Date createTime;
	/**创建人*/
	@Excel(name = "创建人", width = 15)
	@ApiModelProperty(value = "创建人")
	private java.lang.String createBy;
	/**创建部门*/
	@Excel(name = "创建部门", width = 15)
	@ApiModelProperty(value = "创建部门")
	private java.lang.String sysOrgCode;
	/**修改时间*/
	@Excel(name = "修改时间", width = 15, format = "yyyy-MM-dd")
	@JsonFormat(timezone = "GMT+8",pattern = "yyyy-MM-dd")
    @DateTimeFormat(pattern="yyyy-MM-dd")
	@ApiModelProperty(value = "修改时间")
	private java.util.Date updateTime;
	/**修改人*/
	@Excel(name = "修改人", width = 15)
	@ApiModelProperty(value = "修改人")
	private java.lang.String updateBy;
	/**版本*/
	@Excel(name = "版本", width = 15)
	@ApiModelProperty(value = "版本")
	private java.lang.Integer version;
	
	@ExcelCollection(name="收款明细")
	@ApiModelProperty(value = "收款明细")
	private List<FinReceiptEntry> finReceiptEntryList;
	
}
