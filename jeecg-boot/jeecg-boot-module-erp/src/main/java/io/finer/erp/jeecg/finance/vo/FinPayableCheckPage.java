package io.finer.erp.jeecg.finance.vo;

import com.fasterxml.jackson.annotation.JsonFormat;
import io.finer.erp.jeecg.finance.entity.FinPayableCheckEntry;
import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;
import lombok.Data;
import org.jeecgframework.poi.excel.annotation.Excel;
import org.jeecgframework.poi.excel.annotation.ExcelCollection;
import org.springframework.format.annotation.DateTimeFormat;

import java.util.List;

/**
 * @Description: 往来核销单
 * @Author: jeecg-boot
 * @Date:   2020-04-17
 * @Version: V1.0
 */
@Data
@ApiModel(value="fin_payable_checkPage对象", description="往来核销单")
public class FinPayableCheckPage {

	/**ID*/
	@ApiModelProperty(value = "ID")
	private String id;
	/**单据编号*/
	@Excel(name = "单据编号", width = 15)
	@ApiModelProperty(value = "单据编号")
	private String billNo;
	/**单据日期*/
	@Excel(name = "单据日期", width = 15, format = "yyyy-MM-dd")
	@JsonFormat(timezone = "GMT+8",pattern = "yyyy-MM-dd")
    @DateTimeFormat(pattern="yyyy-MM-dd")
	@ApiModelProperty(value = "单据日期")
	private java.util.Date billDate;
	/**核销类型*/
	@Excel(name = "核销类型", width = 15)
	@ApiModelProperty(value = "核销类型")
	private String payableCheckType;
	/**供应商*/
	@Excel(name = "供应商", width = 15)
	@ApiModelProperty(value = "供应商")
	private String supplierId;
	/**备注*/
	@Excel(name = "备注", width = 15)
	@ApiModelProperty(value = "备注")
	private String remark;
	/**处理状态*/
	@Excel(name = "处理状态", width = 15)
	@ApiModelProperty(value = "处理状态")
	private String billProcStatus;
	/**是否通过*/
	@Excel(name = "是否通过", width = 15)
	@ApiModelProperty(value = "是否通过")
	private Integer isApproved;
	/**是否关闭*/
	@Excel(name = "是否关闭", width = 15)
	@ApiModelProperty(value = "是否关闭")
	private Integer isClosed;
	/**是否作废*/
	@Excel(name = "是否作废", width = 15)
	@ApiModelProperty(value = "是否作废")
	private Integer isVoided;
	/**生效时间*/
	@Excel(name = "生效时间", width = 15, format = "yyyy-MM-dd")
	@JsonFormat(timezone = "GMT+8",pattern = "yyyy-MM-dd")
    @DateTimeFormat(pattern="yyyy-MM-dd")
	@ApiModelProperty(value = "生效时间")
	private java.util.Date effectiveTime;
	/**审核人*/
	@Excel(name = "审核人", width = 15)
	@ApiModelProperty(value = "审核人")
	private String approverId;
	/**流程id*/
	@Excel(name = "流程id", width = 15)
	@ApiModelProperty(value = "流程id")
	private String flowId;
	/**创建时间*/
	@Excel(name = "创建时间", width = 15, format = "yyyy-MM-dd")
	@JsonFormat(timezone = "GMT+8",pattern = "yyyy-MM-dd")
    @DateTimeFormat(pattern="yyyy-MM-dd")
	@ApiModelProperty(value = "创建时间")
	private java.util.Date createTime;
	/**创建人*/
	@Excel(name = "创建人", width = 15)
	@ApiModelProperty(value = "创建人")
	private String createBy;
	/**创建部门*/
	@Excel(name = "创建部门", width = 15)
	@ApiModelProperty(value = "创建部门")
	private String sysOrgCode;
	/**修改时间*/
	@Excel(name = "修改时间", width = 15, format = "yyyy-MM-dd")
	@JsonFormat(timezone = "GMT+8",pattern = "yyyy-MM-dd")
    @DateTimeFormat(pattern="yyyy-MM-dd")
	@ApiModelProperty(value = "修改时间")
	private java.util.Date updateTime;
	/**修改人*/
	@Excel(name = "修改人", width = 15)
	@ApiModelProperty(value = "修改人")
	private String updateBy;
	/**版本*/
	@Excel(name = "版本", width = 15)
	@ApiModelProperty(value = "版本")
	private Integer version;

	@ExcelCollection(name="往来核销明细")
	@ApiModelProperty(value = "往来核销明细")
	private List<FinPayableCheckEntry> finPayableCheckEntryList;
	
}
