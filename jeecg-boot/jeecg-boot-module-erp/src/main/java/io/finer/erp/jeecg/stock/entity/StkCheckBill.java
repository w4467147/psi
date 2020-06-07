package io.finer.erp.jeecg.stock.entity;

import java.io.Serializable;
import java.util.Date;
import java.util.HashMap;
import java.util.Map;

import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableField;
import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;
import lombok.Data;
import com.fasterxml.jackson.annotation.JsonFormat;
import org.springframework.format.annotation.DateTimeFormat;
import org.jeecgframework.poi.excel.annotation.Excel;
import org.jeecg.common.aspect.annotation.Dict;
import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;

/**
 * @Description: 盘点卡
 * @Author: jeecg-boot
 * @Date:   2020-05-18
 * @Version: V1.0
 */
@ApiModel(value="stk_check_bill对象", description="盘点卡")
@Data
@TableName("stk_check_bill")
public class StkCheckBill implements Serializable {
    private static final long serialVersionUID = 1L;

	/**ID*/
	@TableId(type = IdType.ID_WORKER_STR)
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
	/**仓库*/
	@Excel(name = "仓库", width = 15, dictTable = "bas_warehouse", dicText = "name", dicCode = "id")
    @Dict(dictTable = "bas_warehouse", dicText = "name", dicCode = "id")
    @ApiModelProperty(value = "仓库")
    private java.lang.String warehouseId;
	/**物料分类*/
	@Excel(name = "物料分类", width = 15, dictTable = "bas_material_category", dicText = "name", dicCode = "id")
    @Dict(dictTable = "bas_material_category", dicText = "name", dicCode = "id")
    @ApiModelProperty(value = "物料分类")
    private java.lang.String materialCategoryId;
	/**盘点人*/
	@Excel(name = "盘点人", width = 15, dictTable = "sys_user", dicText = "realname", dicCode = "username")
    @Dict(dictTable = "sys_user", dicText = "realname", dicCode = "username")
    @ApiModelProperty(value = "盘点人")
    private java.lang.String checkerId;
	/**附件*/
	@Excel(name = "附件", width = 15)
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
    @Dict(dictTable = "sys_depart", dicText = "depart_name", dicCode = "org_code")
    @ApiModelProperty(value = "创建部门")
    private java.lang.String sysOrgCode;
	/**创建人*/
    @Dict(dictTable = "sys_user", dicText = "realname", dicCode = "username")
    @ApiModelProperty(value = "创建人")
    private java.lang.String createBy;
	/**创建时间*/
	@JsonFormat(timezone = "GMT+8",pattern = "yyyy-MM-dd")
    @DateTimeFormat(pattern="yyyy-MM-dd")
    @ApiModelProperty(value = "创建时间")
    private java.util.Date createTime;
	/**修改人*/
    @Dict(dictTable = "sys_user", dicText = "realname", dicCode = "username")
    @ApiModelProperty(value = "修改人")
    private java.lang.String updateBy;
	/**修改时间*/
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
