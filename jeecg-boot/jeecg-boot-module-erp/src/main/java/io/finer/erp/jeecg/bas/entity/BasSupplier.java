package io.finer.erp.jeecg.bas.entity;

import java.io.Serializable;
import java.io.UnsupportedEncodingException;
import java.util.Date;
import java.math.BigDecimal;
import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;
import lombok.Data;
import com.fasterxml.jackson.annotation.JsonFormat;
import org.springframework.format.annotation.DateTimeFormat;
import org.jeecgframework.poi.excel.annotation.Excel;
import org.jeecg.common.aspect.annotation.Dict;
import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;
import lombok.EqualsAndHashCode;
import lombok.experimental.Accessors;

/**
 * @Description: 供应商
 * @Author: jeecg-boot
 * @Date:   2020-04-01
 * @Version: V1.0
 */
@Data
@TableName("bas_supplier")
@Accessors(chain = true)
@EqualsAndHashCode(callSuper = false)
@ApiModel(value="bas_supplier对象", description="供应商")
public class BasSupplier implements Serializable {
    private static final long serialVersionUID = 1L;

	/**ID*/
	@TableId(type = IdType.ID_WORKER_STR)
    @ApiModelProperty(value = "ID")
    private java.lang.String id;
	/**编码*/
	@Excel(name = "编码", width = 15)
    @ApiModelProperty(value = "编码")
    private java.lang.String code;
	/**名称*/
	@Excel(name = "名称", width = 15)
    @ApiModelProperty(value = "名称")
    private java.lang.String name;
	/**简称*/
	@Excel(name = "简称", width = 15)
    @ApiModelProperty(value = "简称")
    private java.lang.String shortName;
	/**等级*/
	@Excel(name = "等级", width = 15, dicCode = "x_supplier_level")
	@Dict(dicCode = "x_supplier_level")
    @ApiModelProperty(value = "等级")
    private java.lang.String supplierLevel;
	/**纳税规模*/
	@Excel(name = "纳税规模", width = 15, dicCode = "x_tax_scale")
	@Dict(dicCode = "x_tax_scale")
    @ApiModelProperty(value = "纳税规模")
    private java.lang.String taxScale;
	/**供应商分类*/
	@Excel(name = "供应商分类", width = 15)
    @ApiModelProperty(value = "供应商分类")
    private java.lang.String supplierCategory;
	/**所属总公司*/
	@Excel(name = "所属总公司", width = 15)
    @ApiModelProperty(value = "所属总公司")
    private java.lang.String headquarters;
	/**所属地区*/
	@Excel(name = "所属地区", width = 15)
    @ApiModelProperty(value = "所属地区")
    private java.lang.String area;
	/**业务地域*/
	@Excel(name = "业务地域", width = 15)
    @ApiModelProperty(value = "业务地域")
    private java.lang.String bizArea;
	/**备选供应商*/
	@Excel(name = "备选供应商", width = 15)
    @ApiModelProperty(value = "备选供应商")
    private java.lang.String alterSupplier;
	/**网站*/
	@Excel(name = "网站", width = 15)
    @ApiModelProperty(value = "网站")
    private java.lang.String website;
	/**法人代表*/
	@Excel(name = "法人代表", width = 15)
    @ApiModelProperty(value = "法人代表")
    private java.lang.String corporate;
	/**法人电话*/
	@Excel(name = "法人电话", width = 15)
    @ApiModelProperty(value = "法人电话")
    private java.lang.String corporatePhone;
	/**供应商地址*/
	@Excel(name = "供应商地址", width = 15)
    @ApiModelProperty(value = "供应商地址")
    private java.lang.String address;
	/**财务信息联系人*/
	@Excel(name = "财务信息联系人", width = 15)
    @ApiModelProperty(value = "财务信息联系人")
    private java.lang.String contactsFinancial;
	/**财务信息联系电话*/
	@Excel(name = "财务信息联系电话", width = 15)
    @ApiModelProperty(value = "财务信息联系电话")
    private java.lang.String phoneFinancial;
	/**开票信息单位名称*/
	@Excel(name = "开票信息单位名称", width = 15)
    @ApiModelProperty(value = "开票信息单位名称")
    private java.lang.String unitInvoice;
	/**开票信息开户行*/
	@Excel(name = "开票信息开户行", width = 15)
    @ApiModelProperty(value = "开票信息开户行")
    private java.lang.String bankInvoice;
	/**开票信息行号*/
	@Excel(name = "开票信息行号", width = 15)
    @ApiModelProperty(value = "开票信息行号")
    private java.lang.String bankidInvoice;
	/**开票信息税号*/
	@Excel(name = "开票信息税号", width = 15)
    @ApiModelProperty(value = "开票信息税号")
    private java.lang.String taxInvoice;
	/**开票信息联系电话*/
	@Excel(name = "开票信息联系电话", width = 15)
    @ApiModelProperty(value = "开票信息联系电话")
    private java.lang.String phoneInvoice;
	/**开票信息账号*/
	@Excel(name = "开票信息账号", width = 15)
    @ApiModelProperty(value = "开票信息账号")
    private java.lang.String accountInvoice;
	/**开票地址*/
	@Excel(name = "开票地址", width = 15)
    @ApiModelProperty(value = "开票地址")
    private java.lang.String addressInvoice;
	/**办款资料单位名称*/
	@Excel(name = "办款资料单位名称", width = 15)
    @ApiModelProperty(value = "办款资料单位名称")
    private java.lang.String unitPayment;
	/**办款资料开户行*/
	@Excel(name = "办款资料开户行", width = 15)
    @ApiModelProperty(value = "办款资料开户行")
    private java.lang.String bankPayment;
	/**办款资料行号*/
	@Excel(name = "办款资料行号", width = 15)
    @ApiModelProperty(value = "办款资料行号")
    private java.lang.String bankidPayment;
	/**办款资料账号*/
	@Excel(name = "办款资料账号", width = 15)
    @ApiModelProperty(value = "办款资料账号")
    private java.lang.String accountPayment;
	/**收件信息地址*/
	@Excel(name = "收件信息地址", width = 15)
    @ApiModelProperty(value = "收件信息地址")
    private java.lang.String accountReceipt;
	/**收件信息邮编*/
	@Excel(name = "收件信息邮编", width = 15)
    @ApiModelProperty(value = "收件信息邮编")
    private java.lang.String postcodeReceipt;
	/**收件信息收件人*/
	@Excel(name = "收件信息收件人", width = 15)
    @ApiModelProperty(value = "收件信息收件人")
    private java.lang.String addressReceipt;
	/**收件信息联系电话*/
	@Excel(name = "收件信息联系电话", width = 15)
    @ApiModelProperty(value = "收件信息联系电话")
    private java.lang.String phoneReceipt;
	/**收件信息传真*/
	@Excel(name = "收件信息传真", width = 15)
    @ApiModelProperty(value = "收件信息传真")
    private java.lang.String faxReceipt;
	/**附件*/
	@Excel(name = "附件", width = 15)
    @ApiModelProperty(value = "附件")
    private java.lang.String attachment;
	/**备注*/
	@Excel(name = "备注", width = 15)
    @ApiModelProperty(value = "备注")
    private java.lang.String remark;
	/**是否启用*/
	@Excel(name = "是否启用", width = 15)
    @ApiModelProperty(value = "是否启用")
    private java.lang.Integer isEnabled;
	/**创建人*/
	@Excel(name = "创建人", width = 15)
    @ApiModelProperty(value = "创建人")
    private java.lang.String createBy;
	/**创建时间*/
	@Excel(name = "创建时间", width = 15, format = "yyyy-MM-dd")
	@JsonFormat(timezone = "GMT+8",pattern = "yyyy-MM-dd")
    @DateTimeFormat(pattern="yyyy-MM-dd")
    @ApiModelProperty(value = "创建时间")
    private java.util.Date createTime;
	/**修改人*/
	@Excel(name = "修改人", width = 15)
    @ApiModelProperty(value = "修改人")
    private java.lang.String updateBy;
	/**修改时间*/
	@Excel(name = "修改时间", width = 15, format = "yyyy-MM-dd")
	@JsonFormat(timezone = "GMT+8",pattern = "yyyy-MM-dd")
    @DateTimeFormat(pattern="yyyy-MM-dd")
    @ApiModelProperty(value = "修改时间")
    private java.util.Date updateTime;
	/**版本*/
	@Excel(name = "版本", width = 15)
    @ApiModelProperty(value = "版本")
    private java.lang.Integer version;
}
