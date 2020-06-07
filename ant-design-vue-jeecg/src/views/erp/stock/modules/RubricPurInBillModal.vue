<template>
  <j-modal
    :title="'采购退货出库 - ' + title"
    :width="width"
    :visible="visible"
    :confirmLoading="confirmLoading"
    :maskClosable="false"
    :keyboard="false"
    :forceRender="true"
    switchFullscreen
    @cancel="handleCancel">

    <template slot="footer">
      <a-button v-if="action!=='detail'" key="cancel" @click="handleCancel">取消</a-button>
      <a-button v-if="!readOnly" key="save"   @click="handleSave" type="primary" :loading="confirmLoading">保存</a-button>
      <a-button v-if="!readOnly" key="submit" @click="handleSubmit" type="primary" :loading="confirmLoading">提交</a-button>
      <a-button v-if="action==='detail'"  key="close"  @click="handleCancel" type="primary">关闭</a-button>
      <a-button v-if="action==='approve'"  key="approved"  @click="handleApproved" type="primary">审核通过</a-button>
    </template>

    <a-spin :spinning="confirmLoading">
      <!-- 主表单区域 -->
      <a-form :form="form">
        <a-row>
          <a-col :span="8">
            <a-form-item label="处理状态" :labelCol="spans.labelCol3" :wrapperCol="spans.wrapperCol3">
              <j-dict-select-tag disabled type="list" v-decorator="['billProcStatus', validatorRules.billProcStatus]" :trigger-change="true" dictCode="x_bill_proc_status"/>
            </a-form-item>
          </a-col>
          <a-col :span="4">
            <a-form-item label="是否通过" :labelCol="spans.labelCol6" :wrapperCol="spans.wrapperCol6">
              <j-dict-select-tag disabled type="list" v-decorator="['isApproved', validatorRules.isApproved]" :trigger-change="true" dictCode="yn" />
            </a-form-item>
          </a-col>
          <a-col :span="4">
            <a-form-item label="是否关闭" :labelCol="spans.labelCol6" :wrapperCol="spans.wrapperCol6">
              <j-dict-select-tag disabled type="list" v-decorator="['isClosed', validatorRules.isClosed]" :trigger-change="true" dictCode="yn" />
            </a-form-item>
          </a-col>
          <a-col :span="4">
            <a-form-item label="是否作废" :labelCol="spans.labelCol6" :wrapperCol="spans.wrapperCol6">
              <j-dict-select-tag disabled type="list" v-decorator="['isVoided', validatorRules.isVoided]" :trigger-change="true" dictCode="yn"/>
            </a-form-item>
          </a-col>
          <a-col :span="4">
            <a @click="()=> this.moreStatus = !this.moreStatus" style="float: right; margin-top: 10px">
              {{ moreStatus ? '收起' : '展开' }}
              <a-icon :type="moreStatus ? 'up' : 'down'"/>
            </a>
          </a-col>
        </a-row>
        <a-row v-show="moreStatus">
          <a-col :span="8">
            <a-form-item label="创建时间" :labelCol="spans.labelCol3" :wrapperCol="spans.wrapperCol3">
              <j-date :readOnly="true" v-decorator="[ 'createTime', validatorRules.createTime]" :trigger-change="true" style="width: 100%"/>
            </a-form-item>
          </a-col>
          <a-col :span="8">
            <a-form-item label="创建人" :labelCol="spans.labelCol3" :wrapperCol="spans.wrapperCol3">
              <j-dict-select-tag disabled type="list" v-decorator="['createBy', validatorRules.createBy]" :trigger-change="true" dictCode="sys_user,realname,username" />
            </a-form-item>
          </a-col>
          <a-col :span="8">
            <a-form-item label="创建部门" :labelCol="spans.labelCol3" :wrapperCol="spans.wrapperCol3">
              <j-dict-select-tag disabled type="list" v-decorator="['sysOrgCode', validatorRules.sysOrgCode]" :trigger-change="true" dictCode="sys_depart,depart_name,org_code" />
            </a-form-item>
          </a-col>
          <a-col :span="8">
            <a-form-item label="生效时间" :labelCol="spans.labelCol3" :wrapperCol="spans.wrapperCol3">
              <j-date :readOnly="true" v-decorator="[ 'effectiveTime', validatorRules.effectiveTime]" :showTime="true" :trigger-change="true" style="width: 100%"/>
            </a-form-item>
          </a-col>
          <a-col :span="8">
            <a-form-item label="审核人" :labelCol="spans.labelCol3" :wrapperCol="spans.wrapperCol3">
              <j-dict-select-tag disabled type="list" v-decorator="['approverId', validatorRules.approverId]" :trigger-change="true" dictCode="sys_user,realname,username" />
            </a-form-item>
          </a-col>
          <a-col :span="8">
            <a-form-item label="流程" :labelCol="spans.labelCol3" :wrapperCol="spans.wrapperCol3">
              <a-input :readOnly="true" v-decorator="[ 'flowId', validatorRules.flowId]" ></a-input>
            </a-form-item>
          </a-col>
          <a-col :span="8">
            <a-form-item label="修改时间" :labelCol="spans.labelCol3" :wrapperCol="spans.wrapperCol3">
              <j-date :readOnly="true" v-decorator="[ 'updateTime', validatorRules.updateTime]" :trigger-change="true" style="width: 100%"/>
            </a-form-item>
          </a-col>
          <a-col :span="8">
            <a-form-item label="修改人" :labelCol="spans.labelCol3" :wrapperCol="spans.wrapperCol3">
              <j-dict-select-tag disabled type="list" v-decorator="['updateBy', validatorRules.updateBy]" :trigger-change="true" dictCode="sys_user,realname,username" />
            </a-form-item>
          </a-col>
          <a-col :span="8">
            <a-form-item label="是否红字" :labelCol="spans.labelCol3" :wrapperCol="spans.wrapperCol3">
              <j-dict-select-tag disabled type="list" v-decorator="['isRubric', validatorRules.isRubric]" :trigger-change="true" dictCode="yn" />
            </a-form-item>
          </a-col>
        </a-row>
        <a-row>
          <a-col :span="8">
            <a-form-item label="单据编号" :labelCol="spans.labelCol3" :wrapperCol="spans.wrapperCol3">
              <a-input :readOnly="true" v-decorator="[ 'billNo', validatorRules.billNo]" ></a-input>
            </a-form-item>
          </a-col>
          <a-col :span="8">
            <a-form-item label="单据日期" :labelCol="spans.labelCol3" :wrapperCol="spans.wrapperCol3">
              <j-date :readOnly="readOnly" placeholder="请选择单据日期" v-decorator="[ 'billDate', validatorRules.billDate]" :trigger-change="true" style="width: 100%"/>
            </a-form-item>
          </a-col>
          <a-col :span="8">
            <a-form-item  label="制单人" :labelCol="spans.labelCol3" :wrapperCol="spans.wrapperCol3">
              <j-dict-select-tag disabled  type="list" v-decorator="['createBy', validatorRules.createBy]" :trigger-change="true" dictCode="sys_user,realname,username" />
            </a-form-item>
          </a-col>
          <a-col :span="8">
            <a-form-item label="业务员" :labelCol="spans.labelCol3" :wrapperCol="spans.wrapperCol3">
              <j-select-user-by-dep :disabled="readOnly" v-decorator="['clerkId', validatorRules.clerkId]" :trigger-change="true"/>
            </a-form-item>
          </a-col>
          <a-col :span="8">
            <!--业务员有供应商分管范围，所以先输入业务员，再选择供应商-->
            <a-form-item label="供应商" :labelCol="spans.labelCol3" :wrapperCol="spans.wrapperCol3">
              <j-dict-select-tag :disabled="readOnly" type="list"
                                 v-decorator="['supplierId', validatorRules.supplierId]"  :trigger-change="true"
                                 dictCode="bas_supplier,name,id" placeholder="请选择供应商"/>
            </a-form-item>
          </a-col>
          <a-col :span="8">
            <a-form-item label="出库经办" :labelCol="spans.labelCol3" :wrapperCol="spans.wrapperCol3">
              <j-select-user-by-dep :disabled="readOnly" v-decorator="['handlerId', validatorRules.handlerId]" :trigger-change="true"/>
            </a-form-item>
          </a-col>
          <a-col v-show="false" :span="8">
            <a-form-item label="源单类型" :labelCol="spans.labelCol3" :wrapperCol="spans.wrapperCol3">
              <j-dict-select-tag disabled type="list" v-decorator="['sourceType', validatorRules.sourceType]" :trigger-change="true" dictCode="x_bill_type" placeholder="请选择源单类型"/>
            </a-form-item>
          </a-col>
          <a-col :span="8">
            <a-form-item label="采购入库单" :labelCol="spans.labelCol3" :wrapperCol="spans.wrapperCol3">
              <a-input :readOnly="true" v-decorator="[ 'sourceNo', validatorRules.sourceNo]" placeholder="请选择源单">
                <a-icon @click="handleSourceSelect" slot="addonAfter" type="ellipsis" />
              </a-input>
            </a-form-item>
          </a-col>
          <a-col :span="8">
            <a-form-item label="结算数量和金额是否等于入库" :labelCol="{span:15}" :wrapperCol="{span:9}">
              <j-dict-select-tag type="list" :disabled="readOnly" :trigger-change="true" dictCode="yn"
                                 @change="onIsSameSettleChange" v-decorator="['isSameSettle', validatorRules.isSameSettle]"/>
            </a-form-item>
          </a-col>
        </a-row>
        <a-row>
          <a-col :span="24">
            <a-form-item label="备注" :labelCol="spans.labelCol1" :wrapperCol="spans.wrapperCol1">
              <a-textarea :readOnly="readOnly" v-decorator="[ 'remark', validatorRules.remark]" placeholder="请输入备注" rows="1" autoSize></a-textarea>
            </a-form-item>
          </a-col>
          <a-col :span="24">
            <a-form-item label="附件" :labelCol="spans.labelCol1" :wrapperCol="spans.wrapperCol1">
              <j-upload :disabled="readOnly" v-decorator="['attachment', validatorRules.attachment]" :trigger-change="true"></j-upload>
            </a-form-item>
          </a-col>
        </a-row>
      </a-form>

      <!-- 子表单区域 -->
      <a-tabs v-model="activeKey" @change="handleChangeTabs">
        <a-tab-pane tab="原入库明细" :key="refKeys[1]" :forceRender="true">
          <div v-if="!readOnly" class="table-operator">
            <a-button :disabled="sourceStkIoBillEntryTable.selectedRowCount===0"
                      @click="handleAddEntry" type="primary" >添加<a-icon type="right" /></a-button>
          </div>
          <j-editable-table
            :disabled="true"
            :ref="refKeys[1]"
            :loading="sourceStkIoBillEntryTable.loading"
            :columns="stkIoBillEntryTable.columns"
            :dataSource="sourceStkIoBillEntryTable.dataSource"
            :disabledRows="sourceStkIoBillEntryTable.disabledRows"
            :maxHeight="300"
            :rowNumber="false"
            :rowSelection="!readOnly"
            :actionButton="false"
            @selectRowChange="(selectedRowIds)=>sourceStkIoBillEntryTable.selectedRowCount=selectedRowIds.length"
          />
        </a-tab-pane>

        <a-tab-pane tab="退货出库明细" :key="refKeys[0]" :forceRender="true">
          <div v-if="!readOnly" class="table-operator">
            <a-button :disabled="stkIoBillEntryTable.selectedRowCount===0"
                      @click="handleRemoveEntry" type="primary" icon="left">移除</a-button>
          </div>
          <j-editable-table
            :disabled="readOnly"
            :ref="refKeys[0]"
            :loading="stkIoBillEntryTable.loading"
            :columns="stkIoBillEntryTable.columns"
            :dataSource="stkIoBillEntryTable.dataSource"
            :maxHeight="300"
            :rowNumber="false"
            :rowSelection="!readOnly"
            :actionButton="false"
            @selectRowChange="(selectedRowIds)=>stkIoBillEntryTable.selectedRowCount=selectedRowIds.length"
            @valueChange="onValueChange"
          />
        </a-tab-pane>

        <template slot="tabBarExtraContent">
          <editable-table-columns-setter :columns="stkIoBillEntryTable.columns" tableName="stkIoBillEntryTable" />
        </template>
      </a-tabs>

      <onl-cgreport-select-modal
        ref="selectModal"
        title="选择采购入库单"
        reportId="1260569956423487489"
        :width="1100"
        :multiSelectable="false"
        @callback="handleSourceSelectCallback"
      />

    </a-spin>
  </j-modal>
</template>

<script>

  import pick from 'lodash.pick'
  import { FormTypes,getRefPromise,VALIDATE_NO_PASSED, validateFormAndTables } from '@/utils/JEditableTableUtil'
  import { JEditableTableMixin } from '@/mixins/JEditableTableMixin'
  import JDate from '@/components/jeecg/JDate'
  import JUpload from '@/components/jeecg/JUpload'
  import JSelectUserByDep from '@/components/jeecgbiz/JSelectUserByDep'
  import JDictSelectTag from "@/components/dict/JDictSelectTag"
  import { putAction } from '@api/manage'
  import { billModalMixin } from '../../mixins/billModalMixin'
  import OnlCgreportSelectModal from '../../components/OnlCgreportSelectModal'
  import EditableTableColumnsSetter from "../../components/EditableTableColumnsSetter";
  import { getFormatDate } from '../../utils/util'
  import { validateEntryNo } from '../../utils/editableTableValidate'

  export default {
    name: 'RubricPurInBillModal',
    mixins: [JEditableTableMixin, billModalMixin],
    components: {
      EditableTableColumnsSetter,
      JDate,
      JUpload,
      JSelectUserByDep,
      JDictSelectTag,
      OnlCgreportSelectModal
    },

    data() {
      return {
        width: '1200px',
        moreStatus: false,

        // 新增时子表默认添加几行空数据
        addDefaultRowNum: 0,
        refKeys: ['stkIoBillEntry', 'sourceStkIoBillEntry', ],
        tableKeys:['stkIoBillEntry', ],
        activeKey: 'stkIoBillEntry',

        // 采购退货出库明细
        stkIoBillEntryTable: {
          loading: false,
          dataSource: [],
          selectedRowCount: 0,
          settingColumns: [], //显示列设置
          columns: [
            {
              title: '分录号',
              key: 'entryNo',
              type: FormTypes.inputNumber,
              width:"60px",
              disabled: true,
            },
            {
              title: '源单类型',
              key: 'sourceType',
              type: FormTypes.hidden,
              width:"100px",
              disabled: true,
            },
            {
              title: '源单分录id',
              key: 'sourceEntryId',
              type: FormTypes.hidden,
              width:"180px",
              disabled: true,
            },
            {
              title: '源单分录号',
              key: 'sourceEntryNo',
              type: FormTypes.hidden,
              width:"180px",
              disabled: true,
            },
            {
              title: '物料',
              key: 'materialId',
              type: FormTypes.sel_search,
              dictCode:"bas_material,name,id",
              width:"200px",
              options:[],
              disabled: true,
            },
            {
              title: '计量单位',
              key: 'unitId',
              type: FormTypes.select,
              dictCode:"bas_measure_unit,name,id",
              width:"100px",
              options:[],
              disabled: true,
            },
            {
              title: '入库数量',
              key: 'qty',
              type: FormTypes.inputNumber,
              statistics: "true",
              width:"100px",
              placeholder: '请输入${title}',
              defaultValue: '',
              validateRules: [
                { required: true, message: '${title}不能为空' },
                { pattern: /^((-\d+(\.\d+)?)|(0+(\.0+)?))$/, message: '请输入0或负数!' },
                { handler: this.validateRubric},
              ],
            },
            {
              title: '入库成本',
              key: 'cost',
              type: FormTypes.inputNumber,
              statistics: "true",
              width:"100px",
              placeholder: '请输入${title}',
              defaultValue: '',
              validateRules: [
                { required: true, message: '${title}不能为空' },
                { pattern: /^((-\d+(\.\d+)?)|(0+(\.0+)?))$/, message: '请输入0或负数!' },
                { handler: this.validateRubric},
              ],
            },
            {
              title: '成本含税',
              key: 'isInclTax',
              type: FormTypes.select,
              dictCode:"yn",
              width:"80px",
              options:[],
              disabled: true,
            },
            {
              title: '仓库',
              key: 'warehouseId',
              type: FormTypes.select,
              dictCode:"bas_warehouse,name,id",
              width:"150px",
              options:[],
              disabled: true,
            },
            {
              title: '批次号',
              key: 'batchNo',
              type: FormTypes.input,
              width:"200px",
              disabled: true,
            },
            {
              title: '结算数量',
              key: 'settleQty',
              type: FormTypes.inputNumber,
              statistics: "true",
              width:"100px",
              placeholder: '请输入${title}',
              defaultValue: '',
              validateRules: [
                { required: true, message: '${title}不能为空' },
                { pattern: /^((-\d+(\.\d+)?)|(0+(\.0+)?))$/, message: '请输入0或负数!' },
                { handler: this.validateRubric},
              ],
            },
            {
              title: '含税单价',
              key: 'settlePrice',
              type: FormTypes.inputNumber,
              width:"100px",
              placeholder: '请输入${title}',
              defaultValue: '',
            },
            {
              title: '税率%',
              key: 'taxRate',
              type: FormTypes.inputNumber,
              width:"100px",
              placeholder: '请输入${title}',
              defaultValue: '',
            },
            {
              title: '税额',
              key: 'tax',
              type: FormTypes.inputNumber,
              statistics: "true",
              width:"100px",
              placeholder: '请输入${title}',
              defaultValue: '',
              validateRules: [
                { pattern: /^((-\d+(\.\d+)?)|(0+(\.0+)?))$/, message: '请输入0或负数!' },
                { handler: this.validateRubric},
              ],
            },
            {
              title: '折让金额',
              key: 'discountAmt',
              type: FormTypes.inputNumber,
              statistics: "true",
              width:"100px",
              placeholder: '请输入${title}',
              defaultValue: '',
              validateRules: [
                { pattern: /^((-\d+(\.\d+)?)|(0+(\.0+)?))$/, message: '请输入0或负数!' },
                { handler: this.validateRubric},
              ],
            },
            {
              title: '折让税额',
              key: 'discountTax',
              type: FormTypes.inputNumber,
              width:"100px",
              placeholder: '请输入${title}',
              defaultValue: '',
              validateRules: [
                { pattern: /^((-\d+(\.\d+)?)|(0+(\.0+)?))$/, message: '请输入0或负数!' },
                { handler: this.validateRubric},
              ],
            },
            {
              title: '结算金额',
              key: 'settleAmt',
              type: FormTypes.inputNumber,
              statistics: "true",
              width:"120px",
              placeholder: '请输入${title}',
              defaultValue: '',
              validateRules: [
                { required: true, message: '${title}不能为空' },
                { pattern: /^((-\d+(\.\d+)?)|(0+(\.0+)?))$/, message: '请输入0或负数!' },
                { handler: this.validateRubric},
              ],
            },
            {
              title: '已开票数量',
              key: 'invoicedQty',
              type: FormTypes.input,
              statistics: "true",
              width:"120px",
              defaultValue: '',
              disabled:true,
            },
            {
              title: '已开票金额',
              key: 'invoicedAmt',
              type: FormTypes.input,
              statistics: "true",
              width:"120px",
              defaultValue: '',
              disabled:true,
            },
            {
              title: '备注',
              key: 'remark',
              type: FormTypes.input,
              width:"200px",
              placeholder: '请输入${title}',
              defaultValue: '',
            },
            {
              title: '备注2',
              key: 'remark2',
              type: FormTypes.input,
              width:"200px",
              placeholder: '请输入${title}',
              defaultValue: '',
            },
            {
              title: '备注3',
              key: 'remark3',
              type: FormTypes.input,
              width:"200px",
              placeholder: '请输入${title}',
              defaultValue: '',
            },
            {
              title: '',
              key: 'flag',
              type: FormTypes.hidden,
              width:"1px",
              placeholder: '',
              defaultValue: '',
            },
          ],
        },

        //原采购入库单
        sourceStkIoBillEntryTable: {
          loading: false,
          dataSource: [],
          selectedRowCount: 0,
          disabledRows:{},
        },
        validatorRules: {
          stockIoType: {rules: [
            ]},
          billNo: {rules: [
              {required: true, message: '请输入单据编号!'},
            ]},
          billDate: {rules: [
              {required: true, message: '请输入单据日期!'},
            ]},
          sourceType: {rules: [
            ]},
          sourceNo: {rules: [
              {required: true, message: '请选择采购入库单!'},]},
          clerkId: {rules: [
            ]},
          handlerId: {rules: [
            ]},
          hasRp: {rules: [
            ]},
          isRubric: {rules: [
            ]},
          isSameSettle: {rules: [
            ]},
          supplierId: {rules: [
            ]},
          customerId: {rules: [
            ]},
          attachment: {rules: [
            ]},
          remark: {rules: [
            ]},
          billProcStatus: {rules: [
            ]},
          approverId: {rules: [
            ]},
          flowId: {rules: [
            ]},
          isApproved: {rules: [
            ]},
          effectiveTime: {rules: [
            ]},
          isVoided: {rules: [
            ]},
          isClosed: {rules: [
            ]},
          sysOrgCode: {rules: [
            ]},
          createBy: {rules: [
            ]},
          createTime: {rules: [
            ]},
          updateBy: {rules: [
            ]},
          updateTime: {rules: [
            ]},
        },

        url: {
          add: "/stock/stkIoBill/add",
          edit: "/stock/stkIoBill/edit",
          approve: "/stock/stkIoBill/approve",
          stkIoBillEntry: {
            list: '/stock/stkIoBill/queryEntryByMainId'
          },
        }
      }
    },

    methods: {
      getAllTable() {
        let values = this.tableKeys.map(key => getRefPromise(this, key))
        return Promise.all(values)
      },

      addInit() {
        //采购入库（红字）
        this.model.stockIoType = '1011'
        this.model.isRubric = 1
        //是否有往来
        this.model.hasRp = 1
        //结算是否同入库（或取自系统参数）
        this.model.isSameSettle = 0
        //源单类型：采购入库
        this.model.sourceType = 'stk_io_bill..101'
        //处理状态：编辑中
        this.model.billProcStatus = '12'


        // 请求后台的填值规则接口地址
        const url = '/sys/fillRule/executeRuleByCode/'
        const ruleCode = 'stock_io_bill_no'
        const that = this
        putAction(url + ruleCode, {}).then(res => {
          // 执行成功，获取返回的值，并赋到页面上
          if (res.success) {
            that.model.billNo = res.result;
            that.$nextTick( ()=>that.form.setFieldsValue({'billNo':res.result, 'billDate':getFormatDate()}) )
          }
        })
      },

      /** 调用完edit()方法之后会自动调用此方法 */
      editAfter() {
        const that = this;
        //sourceStkIoBillEntry未在tableKeys中
        this.$nextTick( ()=>that.$refs.sourceStkIoBillEntry.initialize() );

        if (this.action === 'add') {
          this.addInit();
          this.activeKey = 'sourceStkIoBillEntry';
        } else {
          this.activeKey = 'stkIoBillEntry';
        }

        let fieldval = pick(this.model,'billNo','billDate','sourceType','sourceNo','clerkId','handlerId',
          'isRubric','isSameSettle','supplierId','attachment','remark','billProcStatus','approverId','flowId',
          'isApproved','effectiveTime','isVoided','isClosed','sysOrgCode','createBy','createTime','updateBy','updateTime')
        this.$nextTick(() => {
          that.form.setFieldsValue(fieldval)
          that.onIsSameSettleChange(this.model.isSameSettle.toString())
        })
        // 加载子表数据
        if (this.model.id) {
          let params = { id: this.model.id }
          this.requestSubTableData(this.url.stkIoBillEntry.list, params, this.stkIoBillEntryTable, loadSecondSubTableData);
          function loadSecondSubTableData(){
            let params = { id: that.model.sourceId }
            that.requestSubTableData(that.url.stkIoBillEntry.list, params, that.sourceStkIoBillEntryTable, that.refreshDisabledRows);
          }
        }
      },

      /** 整理成formData */
      classifyIntoFormData(allValues) {
        let main = Object.assign(this.model, allValues.formValue)

        return {
          ...main, // 展开source.dataSource =
          stkIoBillEntryList: allValues.tablesValue[0].values,
        }
      },
      validateError(msg){
        this.$message.error(msg)
      },
      popupCallback(row){
        this.form.setFieldsValue(pick(row,'billNo','billDate','sourceType','sourceNo','clerkId','handlerId','isRubric','isSameSettle','supplierId','attachment','remark','billProcStatus','approverId','flowId','isApproved','effectiveTime','isVoided','isClosed','sysOrgCode','createBy','createTime','updateBy','updateTime'))
      },

      onIsSameSettleChange(val) {
        this.$refs.stkIoBillEntry.columns.forEach(function (item, i, array ) {
          if (item.key === "settleQty" || item.key === "settleAmt") {
            item.disabled = (val === '1');
          }
        });

        if (val === '1') {
          let { error, values } = this.$refs.stkIoBillEntry.getValuesSync({ validate: false})
          for (let v of values) {
            this.$refs.stkIoBillEntry.setValues([{rowKey: v.id, values: {settleQty: v.qty, settleAmt:v.cost}}]);
          }
        }
      },

      //单元值改变一个字符就触发一次
      onValueChange(event) {
        const { type, row, column, value, target } = event

        //联动
        //触发：入库数量, 联动列结算数量
        if (column.key === 'qty') {
          if (this.form.getFieldValue("isSameSettle") === '1') {
            target.setValues([{rowKey: row.id, values: {settleQty: value}}]);
          }
        }
        //触发：入库成本, 联动：结算金额
        else if (column.key === 'cost') {
          if (this.form.getFieldValue("isSameSettle") === '1') {
            target.setValues([{rowKey: row.id, values: {settleAmt: value}}]);
          }
        }
      },

      handleSourceSelect() {
        let queryParams = {};
        queryParams['supplier_id'] = this.form.getFieldValue('supplierId');
        this.$refs.selectModal.initQueryParams(queryParams);
        this.$refs.selectModal.visible = true;
      },
      handleSourceSelectCallback(selectedRows){
        if ( this.model.sourceId === selectedRows[0]['id']) return;

        this.model.sourceId = selectedRows[0]['id'];
        this.form.setFieldsValue({sourceNo: selectedRows[0]['bill_no'],
          supplierId: selectedRows[0]['supplier_id']});

        // 加载子表数据
        let params = { id: this.model.sourceId }
        this.requestSubTableData(this.url.stkIoBillEntry.list, params, this.sourceStkIoBillEntryTable, this.refreshDisabledRows);
      },

      handleAddEntry(){
        let source = this.$refs.sourceStkIoBillEntry,
            target = this.$refs.stkIoBillEntry;

        let { values } = source.getValuesSync({ validate: false, rowIds: source.selectedRowIds});
        for(let v of values) {
          let row = pick(v, 'entryNo','materialId','unitId','isInclTax','warehouseId','batchNo','settlePrice','taxRate');
          row.sourceType = 'stk_io_bill.stk_io_bill_entry.101';
          row.sourceEntryId = v.id;
          row.sourceEntryNo = this.form.getFieldValue("sourceNo") + '.' + v.entryNo;
          row.qty = -v.qty;
          row.cost = -v.cost;
          row.settleQty = -v.settleQty;
          row.tax = -v.tax;
          row.discountAmt = -v.discountAmt
          row.discountTax = -v.discountTax
          row.settleAmt = -v.settleAmt;
          target.add();
          let rowId = target.rows[target.rows.length - 1].id;
          target.setValues([{rowKey: rowId, values: row}]);
        }
        this.refreshDisabledRows();
      },

      handleRemoveEntry(){
        this.$refs.stkIoBillEntry.removeSelectedRows();
        this.refreshDisabledRows();
      },

      refreshDisabledRows(){
        let that = this;
        let entryNos = [];
        let { values } = that.$refs.stkIoBillEntry.getValuesSync({ validate: false});
        for(let v of values) {
          entryNos.push(Number(v.entryNo));
        }
        that.sourceStkIoBillEntryTable.disabledRows = entryNos.length===0 ? {} : {entryNo:entryNos};
        //disabledRowIds不初始会保留前面的数据，导致与disabledRows不一致！
        that.$refs.sourceStkIoBillEntry.disabledRowIds = [];
        //使新的disabledRows生效
        let dataSource = [...that.sourceStkIoBillEntryTable.dataSource];
        that.sourceStkIoBillEntryTable.dataSource = dataSource;
      },

      validateRubric(type, value, row, column, callback, target) {
        if (type !== 'blur') {
          callback();
          return;
        }

        let { values } = target.getValuesSync({ validate: false, rowIds: [row.id]});
        let rubric = Number(values[0][column.key]);
        if (isNaN(rubric)) {
          callback();
          return;
        }

        let sourceEntryId = values[0].sourceEntryId;
        let rows = this.sourceStkIoBillEntryTable.dataSource.filter(row => row.id === sourceEntryId);
        let blue = rows[0][column.key]
        if (isNaN(blue)) {
          callback();
          return;
        }

        if (-rubric > blue) {
          callback(false, '不能超出入库！');
          return;
        }

        callback(true); //true：通过验证
      },

    },

  }
</script>

<style lang="less" scoped>
  .ant-row.ant-form-item {
    margin-bottom: 12px;
  }
</style>
