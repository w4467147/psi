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
import java.util.HashMap;
import java.util.Map;

/**
 * @Description: 应收核销单
 * @Author: jeecg-boot
 * @Date:   2020-04-17
 * @Version: V1.0
 */
@ApiModel(value="fin_receivable_check对象", description="应收核销单")
@Data
@TableName("fin_receivable_check")
public class FinReceivableCheck implements Serializable {
    private static final long serialVersionUID = 1L;

	/**ID*/
	@TableId(type = IdType.ID_WORKER_STR)
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
    private Date billDate;
	/**核销类型*/
	@Excel(name = "核销类型", width = 15, dicCode = "x_receivable_check_type")
    @Dict(dicCode = "x_receivable_check_type")
    @ApiModelProperty(value = "核销类型")
    private String receivableCheckType;
	/**客户*/
	@Excel(name = "客户", width = 15, dictTable = "bas_customer", dicText = "name", dicCode = "id")
    @Dict(dictTable = "bas_customer", dicText = "name", dicCode = "id")
    @ApiModelProperty(value = "客户")
    private String customerId;
	/**备注*/
	@Excel(name = "备注", width = 15)
    @ApiModelProperty(value = "备注")
    private String remark;
	/**处理状态*/
	@Excel(name = "处理状态", width = 15, dicCode = "x_bill_proc_status")
    @Dict(dicCode = "x_bill_proc_status")
    @ApiModelProperty(value = "处理状态")
    private String billProcStatus;
	/**是否通过*/
	@Excel(name = "是否通过", width = 15, dicCode = "yn")
    @Dict(dicCode = "yn")
    @ApiModelProperty(value = "是否通过")
    private Integer isApproved;
	/**是否关闭*/
	@Excel(name = "是否关闭", width = 15, dicCode = "yn")
    @Dict(dicCode = "yn")
    @ApiModelProperty(value = "是否关闭")
    private Integer isClosed;
	/**是否作废*/
	@Excel(name = "是否作废", width = 15, dicCode = "yn")
    @Dict(dicCode = "yn")
    @ApiModelProperty(value = "是否作废")
    private Integer isVoided;
	/**生效时间*/
	@Excel(name = "生效时间", width = 15, format = "yyyy-MM-dd")
	@JsonFormat(timezone = "GMT+8",pattern = "yyyy-MM-dd")
    @DateTimeFormat(pattern="yyyy-MM-dd")
    @ApiModelProperty(value = "生效时间")
    private Date effectiveTime;
	/**审核人*/
	@Excel(name = "审核人", width = 15, dictTable = "sys_user", dicText = "realname", dicCode = "username")
    @Dict(dictTable = "sys_user", dicText = "realname", dicCode = "username")
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
    private Date createTime;
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
    private Date updateTime;
	/**修改人*/
	@Excel(name = "修改人", width = 15, dictTable = "sys_user", dicText = "realname", dicCode = "username")
    @Dict(dictTable = "sys_user", dicText = "realname", dicCode = "username")
    @ApiModelProperty(value = "修改人")
    private String updateBy;
	/**版本*/
    @ApiModelProperty(value = "版本")
    private Integer version;

    @TableField(exist = false)
    private Map actionsEnabled;

    public Map getActionsEnabled() {
        //controller中，QueryWrapper也会创建entity；
        //(actionsEnabled == null)，是为了避免作为查询数据库参数。
        if (id == null) {
            return null;
        }

        HashMap<String, Boolean> map = new HashMap<String, Boolean>();
        boolean b = billProcStatus != null && billProcStatus.startsWith("1")
                && (isApproved == null || isApproved == 0)
                && (isClosed == null || isClosed == 0)
                && (isVoided == null || isVoided == 0);
        map.put("edit", b);

        b = billProcStatus != null &&
                billProcStatus.startsWith("1") && !billProcStatus.equals("13")
                && (isApproved == null || isApproved == 0)
                && (isClosed == null || isClosed == 0)
                && (isVoided == null || isVoided == 0)
                &&  approverId == null;
        map.put("delete", b);

        b =  billProcStatus != null && billProcStatus.equals("13")
                && (isApproved == null || isApproved == 0)
                && (isClosed == null || isClosed == 0)
                && (isVoided == null || isVoided == 0);
        map.put("approve", b);

        b = billProcStatus != null &&
                (billProcStatus.equals("23") ||
                        billProcStatus.startsWith("3") && !billProcStatus.equals("33"))
                && isApproved != null && isApproved == 1
                && (isClosed == null || isClosed == 0)
                && (isVoided == null || isVoided == 0);
        map.put("execute", b);

        actionsEnabled = map;
        return map;
    }
}
