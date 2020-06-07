package io.finer.erp.jeecg.stock.entity;

import java.io.Serializable;
import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableField;
import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;
import lombok.Data;
import com.fasterxml.jackson.annotation.JsonFormat;
import org.jeecg.common.aspect.annotation.Dict;
import org.springframework.format.annotation.DateTimeFormat;
import org.jeecgframework.poi.excel.annotation.Excel;
import java.util.Date;
import java.util.Map;

import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;

/**
 * @Description: 明细
 * @Author: jeecg-boot
 * @Date:   2020-03-31
 * @Version: V1.0
 */
@ApiModel(value="stk_io_bill对象", description="出入库单")
@Data
@TableName("stk_io_bill_entry")
public class StkIoBillEntry implements Serializable {
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
	/**物料*/
	@Excel(name = "物料", width = 15, dictTable = "bas_material", dicText = "name", dicCode = "id")
	@Dict(dictTable = "bas_material", dicText = "name", dicCode = "id")
	@ApiModelProperty(value = "物料")
	private java.lang.String materialId;
	/**计量单位*/
	@Excel(name = "计量单位", width = 15, dictTable = "bas_measure_unit", dicText = "name", dicCode = "id")
	@Dict(dictTable = "bas_measure_unit", dicText = "name", dicCode = "id")
	@ApiModelProperty(value = "计量单位")
	private java.lang.String unitId;
	/**数量*/
	@Excel(name = "数量", width = 15)
	@ApiModelProperty(value = "数量")
	private java.math.BigDecimal qty;
	/**成本*/
	@Excel(name = "成本", width = 15)
	@ApiModelProperty(value = "成本")
	private java.math.BigDecimal cost;
	/**成本是否含税*/
	@Excel(name = "成本是否含税", width = 15, dicCode = "yn")
	@Dict(dicCode = "yn")
	@ApiModelProperty(value = "成本是否含税")
	private java.lang.Integer isInclTax;
	/**批次号*/
	@Excel(name = "批次号", width = 15)
	@ApiModelProperty(value = "批次号")
	private java.lang.String batchNo;
	/**仓库*/
	@Excel(name = "仓库", width = 15, dictTable = "bas_warehouse", dicText = "name", dicCode = "id")
	@Dict(dictTable = "bas_warehouse", dicText = "name", dicCode = "id")
	@ApiModelProperty(value = "仓库")
	private java.lang.String warehouseId;
	/**调入仓库*/
	@Excel(name = "调入仓库", width = 15, dictTable = "bas_warehouse", dicText = "name", dicCode = "id")
	@Dict(dictTable = "bas_warehouse", dicText = "name", dicCode = "id")
	@ApiModelProperty(value = "调入仓库")
	private java.lang.String inWarehouseId;
	/**供应商*/
	@Excel(name = "供应商", width = 15, dictTable = "bas_supplier", dicText = "name", dicCode = "id")
	@Dict(dictTable = "bas_supplier", dicText = "name", dicCode = "id")
	@ApiModelProperty(value = "供应商")
	private java.lang.String supplierId;
	/**结算数量*/
	@Excel(name = "结算数量", width = 15)
	@ApiModelProperty(value = "结算数量")
	private java.math.BigDecimal settleQty;
	/**含税单价*/
	@Excel(name = "含税单价", width = 15)
	@ApiModelProperty(value = "含税单价")
	private java.math.BigDecimal settlePrice;
	/**税率%*/
	@Excel(name = "税率%", width = 15)
	@ApiModelProperty(value = "税率%")
	private java.math.BigDecimal taxRate;
	/**税额*/
	@Excel(name = "税额", width = 15)
	@ApiModelProperty(value = "税额")
	private java.math.BigDecimal tax;
	/**折扣率%*/
	@Excel(name = "折扣率%", width = 15)
	@ApiModelProperty(value = "折扣率%")
	private java.math.BigDecimal discountRate;
	/**折扣金额*/
	@Excel(name = "折扣金额", width = 15)
	@ApiModelProperty(value = "折扣金额")
	private java.math.BigDecimal discountAmt;
	/**折扣税额*/
	@Excel(name = "折扣税额", width = 15)
	@ApiModelProperty(value = "折扣税额")
	private java.math.BigDecimal discountTax;
	/**结算金额*/
	@Excel(name = "结算金额", width = 15)
	@ApiModelProperty(value = "结算金额")
	private java.math.BigDecimal settleAmt;
	/**已开票数量*/
	@Excel(name = "已开票数量", width = 15)
	@ApiModelProperty(value = "已开票数量")
	private java.math.BigDecimal invoicedQty;
	/**已开票金额*/
	@Excel(name = "已开票金额", width = 15)
	@ApiModelProperty(value = "已开票金额")
	private java.math.BigDecimal invoicedAmt;
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

	/**实时库存计量单位*/
	@TableField(exist = false)
	private java.lang.String inventoryUnitId;
	/**实时库存数量*/
	@TableField(exist = false)
	private java.math.BigDecimal inventoryQty;
	/**实时库存成本*/
	@TableField(exist = false)
	private java.math.BigDecimal inventoryCost;
}
