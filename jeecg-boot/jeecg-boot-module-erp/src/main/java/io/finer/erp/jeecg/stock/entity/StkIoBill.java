package io.finer.erp.jeecg.stock.entity;

import com.alibaba.fastjson.JSONObject;
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
import java.util.HashMap;
import java.util.Map;

/**
 * @Description: 出入库单
 * @Author: jeecg-boot
 * @Date:   2020-04-02
 * @Version: V1.0
 */
@ApiModel(value="stk_io_bill对象", description="出入库单")
@Data
@TableName("stk_io_bill")
public class StkIoBill implements Serializable {
    private static final long serialVersionUID = 1L;

    /**ID*/
    @TableId(type = IdType.ID_WORKER_STR)
    @ApiModelProperty(value = "ID")
    private java.lang.String id;
    /**出入库类型*/
    @Excel(name = "出入库类型", width = 15, dicCode = "x_stock_io_type")
    @Dict(dicCode = "x_stock_io_type")
    @ApiModelProperty(value = "出入库类型")
    private java.lang.String stockIoType;
    /**是否自动生成*/
    @Excel(name = "是否自动生成", width = 15, dicCode = "yn")
    @Dict(dicCode = "yn")
    @ApiModelProperty(value = "是否自动生成")
    private java.lang.Integer isAuto;
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
    /**源单类型*/
    @Excel(name = "源单类型", width = 15, dicCode = "x_bill_type")
    @Dict(dicCode = "x_bill_type")
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
    @Excel(name = "业务员", width = 15, dictTable = "sys_user", dicText = "realname", dicCode = "username")
    @Dict(dictTable = "sys_user", dicText = "realname", dicCode = "username")
    @ApiModelProperty(value = "业务员")
    private java.lang.String clerkId;
    /**出入库经办*/
    @Excel(name = "出入库经办", width = 15, dictTable = "sys_user", dicText = "realname", dicCode = "username")
    @Dict(dictTable = "sys_user", dicText = "realname", dicCode = "username")
    @ApiModelProperty(value = "出入库经办")
    private java.lang.String handlerId;
    /**结算是否相同*/
    @Excel(name = "结算是否相同", width = 15, dicCode = "yn")
    @Dict(dicCode = "yn")
    @ApiModelProperty(value = "结算是否相同")
    private java.lang.Integer isSameSettle;
    /**是否有往来*/
    @Excel(name = "是否有往来", width = 15, dicCode = "yn")
    @Dict(dicCode = "yn")
    @ApiModelProperty(value = "是否有往来")
    private java.lang.Integer hasRp;
    /**是否红字*/
    @Excel(name = "是否红字", width = 15, dicCode = "yn")
    @Dict(dicCode = "yn")
    @ApiModelProperty(value = "是否红字")
    private java.lang.Integer isRubric;
    /**供应商*/
    @Excel(name = "供应商", width = 15, dictTable = "bas_supplier", dicText = "name", dicCode = "id")
    @Dict(dictTable = "bas_supplier", dicText = "name", dicCode = "id")
    @ApiModelProperty(value = "供应商")
    private java.lang.String supplierId;
    /**客户*/
    @Excel(name = "客户", width = 15, dictTable = "bas_customer", dicText = "name", dicCode = "id")
    @Dict(dictTable = "bas_customer", dicText = "name", dicCode = "id")
    @ApiModelProperty(value = "客户")
    private java.lang.String customerId;
    /**附件id*/
    @Excel(name = "附件id", width = 15)
    @ApiModelProperty(value = "附件")
    private java.lang.String attachment;
    /**备注*/
    @Excel(name = "备注", width = 15)
    @ApiModelProperty(value = "备注")
    private java.lang.String remark;
    /**处理状态*/
    @Excel(name = "处理状态", width = 15, dicCode = "x_bill_proc_status")
    @Dict(dicCode = "x_bill_proc_status")
    @ApiModelProperty(value = "处理状态")
    private java.lang.String billProcStatus;
    /**审核人*/
    @Excel(name = "审核人", width = 15, dictTable = "sys_user", dicText = "realname", dicCode = "username")
    @Dict(dictTable = "sys_user", dicText = "realname", dicCode = "username")
    @ApiModelProperty(value = "审核人")
    private java.lang.String approverId;
    /**流程id*/
    @Excel(name = "流程id", width = 15)
    @ApiModelProperty(value = "流程id")
    private java.lang.String flowId;
    /**是否通过*/
    @Excel(name = "是否通过", width = 15, dicCode = "yn")
    @Dict(dicCode = "yn")
    @ApiModelProperty(value = "是否通过")
    private java.lang.Integer isApproved;
    /**生效时间*/
    @Excel(name = "生效时间", width = 15, format = "yyyy-MM-dd")
    @JsonFormat(timezone = "GMT+8",pattern = "yyyy-MM-dd")
    @DateTimeFormat(pattern="yyyy-MM-dd")
    @ApiModelProperty(value = "生效时间")
    private java.util.Date effectiveTime;
    /**是否作废*/
    @Excel(name = "是否作废", width = 15, dicCode = "yn")
    @Dict(dicCode = "yn")
    @ApiModelProperty(value = "是否作废")
    private java.lang.Integer isVoided;
    /**是否关闭*/
    @Excel(name = "是否关闭", width = 15, dicCode = "yn")
    @Dict(dicCode = "yn")
    @ApiModelProperty(value = "是否关闭")
    private java.lang.Integer isClosed;
    /**创建部门*/
    @Excel(name = "创建部门", width = 15, dictTable = "sys_depart", dicText = "depart_name", dicCode = "org_code")
    @Dict(dictTable = "sys_depart", dicText = "depart_name", dicCode = "org_code")
    @ApiModelProperty(value = "创建部门")
    private java.lang.String sysOrgCode;
    /**创建人*/
    @Excel(name = "创建人", width = 15, dictTable = "sys_user", dicText = "realname", dicCode = "username")
    @Dict(dictTable = "sys_user", dicText = "realname", dicCode = "username")
    @ApiModelProperty(value = "创建人")
    private java.lang.String createBy;
    /**创建时间*/
    @Excel(name = "创建时间", width = 15, format = "yyyy-MM-dd")
    @JsonFormat(timezone = "GMT+8",pattern = "yyyy-MM-dd")
    @DateTimeFormat(pattern="yyyy-MM-dd")
    @ApiModelProperty(value = "创建时间")
    private java.util.Date createTime;
    /**修改人*/
    @Excel(name = "修改人", width = 15, dictTable = "sys_user", dicText = "realname", dicCode = "username")
    @Dict(dictTable = "sys_user", dicText = "realname", dicCode = "username")
    @ApiModelProperty(value = "修改人")
    private java.lang.String updateBy;
    /**修改时间*/
    @Excel(name = "修改时间", width = 15, format = "yyyy-MM-dd")
    @JsonFormat(timezone = "GMT+8",pattern = "yyyy-MM-dd")
    @DateTimeFormat(pattern="yyyy-MM-dd")
    @ApiModelProperty(value = "修改时间")
    private java.util.Date updateTime;
    /**版本*/
    @ApiModelProperty(value = "版本")
    private java.lang.Integer version;

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
