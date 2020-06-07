<template>
  <j-modal
    :title="'采购发票（红字）登记 - ' + title"
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
              <j-dict-select-tag disabled type="list" v-decorator="['billProcStatus']" :trigger-change="true" dictCode="x_bill_proc_status"/>
            </a-form-item>
          </a-col>
          <a-col :span="4">
            <a-form-item label="是否通过" :labelCol="spans.labelCol6" :wrapperCol="spans.wrapperCol6">
              <j-dict-select-tag disabled type="list" v-decorator="['isApproved']" :trigger-change="true" dictCode="yn" />
            </a-form-item>
          </a-col>
          <a-col :span="4">
            <a-form-item label="是否关闭" :labelCol="spans.labelCol6" :wrapperCol="spans.wrapperCol6">
              <j-dict-select-tag disabled type="list" v-decorator="['isClosed']" :trigger-change="true" dictCode="yn" />
            </a-form-item>
          </a-col>
          <a-col :span="4">
            <a-form-item label="是否作废" :labelCol="spans.labelCol6" :wrapperCol="spans.wrapperCol6">
              <j-dict-select-tag disabled type="list" v-decorator="['isVoided']" :trigger-change="true" dictCode="yn"/>
            </a-form-item>
          </a-col>
          <a-col :span="4">
            <a @click="() => moreStatus = !moreStatus" style="float: right; margin-top: 10px">
              {{ moreStatus ? '收起' : '展开' }}
              <a-icon :type="moreStatus ? 'up' : 'down'"/>
            </a>
          </a-col>
        </a-row>
        <a-row v-show="moreStatus">
          <a-col :span="8">
            <a-form-item label="创建时间" :labelCol="spans.labelCol3" :wrapperCol="spans.wrapperCol3">
              <j-date :readOnly="true" v-decorator="[ 'createTime']" :trigger-change="true" style="width: 100%"/>
            </a-form-item>
          </a-col>
          <a-col :span="8">
            <a-form-item label="创建人" :labelCol="spans.labelCol3" :wrapperCol="spans.wrapperCol3">
              <j-dict-select-tag disabled type="list" v-decorator="['createBy']" :trigger-change="true" dictCode="sys_user,realname,username" />
            </a-form-item>
          </a-col>
          <a-col :span="8">
            <a-form-item label="创建部门" :labelCol="spans.labelCol3" :wrapperCol="spans.wrapperCol3">
              <j-dict-select-tag disabled type="list" v-decorator="['sysOrgCode']" :trigger-change="true" dictCode="sys_depart,depart_name,org_code" />
            </a-form-item>
          </a-col>
          <a-col :span="8">
            <a-form-item label="生效时间" :labelCol="spans.labelCol3" :wrapperCol="spans.wrapperCol3">
              <j-date :readOnly="true" v-decorator="[ 'effectiveTime']" :showTime="true" :trigger-change="true" style="width: 100%"/>
            </a-form-item>
          </a-col>
          <a-col :span="8">
            <a-form-item label="审核人" :labelCol="spans.labelCol3" :wrapperCol="spans.wrapperCol3">
              <j-dict-select-tag disabled type="list" v-decorator="['approverId']" :trigger-change="true" dictCode="sys_user,realname,username" />
            </a-form-item>
          </a-col>
          <a-col :span="8">
            <a-form-item label="流程" :labelCol="spans.labelCol3" :wrapperCol="spans.wrapperCol3">
              <a-input :readOnly="true" v-decorator="[ 'flowId']" ></a-input>
            </a-form-item>
          </a-col>
          <a-col :span="8">
            <a-form-item label="修改时间" :labelCol="spans.labelCol3" :wrapperCol="spans.wrapperCol3">
              <j-date :readOnly="true" v-decorator="[ 'updateTime']" :trigger-change="true" style="width: 100%"/>
            </a-form-item>
          </a-col>
          <a-col :span="8">
            <a-form-item label="修改人" :labelCol="spans.labelCol3" :wrapperCol="spans.wrapperCol3">
              <j-dict-select-tag disabled type="list" v-decorator="['updateBy']" :trigger-change="true" dictCode="sys_user,realname,username" />
            </a-form-item>
          </a-col>
          <a-col :span="8">
            <a-form-item label="是否红字" :labelCol="spans.labelCol3" :wrapperCol="spans.wrapperCol3">
              <j-dict-select-tag  disabled type="list" v-decorator="['isRubric']" :trigger-change="true" dictCode="yn" />
            </a-form-item>
          </a-col>
          <a-col :xs="24" :sm="8">
            <a-form-item label="自动生成"  :labelCol="spans.labelCol3" :wrapperCol="spans.wrapperCol3">
              <j-dict-select-tag disabled type="list" v-decorator="['isAuto']" :trigger-change="true" dictCode="yn" placeholder="请选择是否自动生成"/>
            </a-form-item>
          </a-col>
        </a-row>
        <a-row>
          <a-col :span="8">
            <a-form-item label="单据编号" :labelCol="spans.labelCol3" :wrapperCol="spans.wrapperCol3">
              <a-input :readOnly="true" v-decorator="[ 'billNo']" ></a-input>
            </a-form-item>
          </a-col>
          <a-col :span="8">
            <a-form-item label="单据日期" :labelCol="spans.labelCol3" :wrapperCol="spans.wrapperCol3">
              <j-date :readOnly="readOnly" placeholder="请选择单据日期" v-decorator="[ 'billDate', validatorRules.billDate]" :trigger-change="true" style="width: 100%"/>
            </a-form-item>
          </a-col>
          <a-col :span="8">
            <a-form-item  label="制单人" :labelCol="spans.labelCol3" :wrapperCol="spans.wrapperCol3">
              <j-dict-select-tag disabled type="list" v-decorator="['createBy']" :trigger-change="true" dictCode="sys_user,realname,username" />
            </a-form-item>
          </a-col>
          <a-col v-show="false" :span="8">
            <a-form-item label="业务员" :labelCol="spans.labelCol3" :wrapperCol="spans.wrapperCol3">
              <j-select-user-by-dep :disabled="readOnly" v-decorator="['clerkId']" :trigger-change="true"/>
            </a-form-item>
          </a-col>
          <a-col :span="8">
            <!--业务员有供应商分管范围，所以先输入业务员，再选择供应商-->
            <a-form-item label="供应商" :labelCol="spans.labelCol3" :wrapperCol="spans.wrapperCol3">
              <j-dict-select-tag :disabled="readOnly" type="list" v-decorator="['supplierId', validatorRules.supplierId]" :trigger-change="true" dictCode="bas_supplier,name,id" placeholder="请选择供应商"/>
            </a-form-item>
          </a-col>
          <a-col v-show="false" :span="8">
            <a-form-item label="发票类型" :labelCol="spans.labelCol3" :wrapperCol="spans.wrapperCol3">
              <j-dict-select-tag :disabled="readOnly" type="list" v-decorator="['invoiceType']" :trigger-change="true" dictCode="x_invoice_type" placeholder="请选择发票类型"/>
            </a-form-item>
          </a-col>
          <a-col v-show="false" :span="8">
            <a-form-item label="源单类型" :labelCol="spans.labelCol3" :wrapperCol="spans.wrapperCol3">
              <j-dict-select-tag disabled type="list" v-decorator="['sourceType']" :trigger-change="true" dictCode="x_bill_type" placeholder="请选择源单类型"/>
            </a-form-item>
          </a-col>
          <a-col :span="8">
            <a-form-item label="采购发票" :labelCol="spans.labelCol3" :wrapperCol="spans.wrapperCol3">
              <a-input :readOnly="true" v-decorator="[ 'sourceNo', validatorRules.sourceNo]" >
                <a-icon @click="handleSourceSelect" slot="addonAfter" type="ellipsis" />
              </a-input>
            </a-form-item>
          </a-col>

          <a-col :span="24">
            <!-- 子表单区域 -->
            <a-tabs v-model="activeKey" @change="handleChangeTabs">
              <a-tab-pane tab="蓝单明细" :key="refKeys[1]" :forceRender="true">
                <div v-if="!readOnly" class="table-operator">
                  <a-button :disabled="sourceFinPurInvoiceEntryTable.selectedRowCount===0"
                            @click="handleAddEntry" type="primary" >添加<a-icon type="right" /></a-button>
                </div>
                <j-editable-table
                  :disabled="true"
                  :ref="refKeys[1]"
                  :loading="sourceFinPurInvoiceEntryTable.loading"
                  :columns="finPurInvoiceEntryTable.columns"
                  :dataSource="sourceFinPurInvoiceEntryTable.dataSource"
                  :disabledRows="sourceFinPurInvoiceEntryTable.disabledRows"
                  :maxHeight="300"
                  :rowNumber="false"
                  :rowSelection="!readOnly"
                  :actionButton="false"
                  @selectRowChange="(selectedRowIds)=>sourceFinPurInvoiceEntryTable.selectedRowCount=selectedRowIds.length"
                />
              </a-tab-pane>

              <a-tab-pane tab="明细" :key="refKeys[0]" :forceRender="true">
                <div v-if="!readOnly" class="table-operator">
                  <a-button :disabled="finPurInvoiceEntryTable.selectedRowCount===0"
                            @click="handleRemoveEntry" type="primary" icon="left">移除</a-button>
                </div>

                <j-editable-table
                  :disabled="readOnly"
                  :ref="refKeys[0]"
                  :loading="finPurInvoiceEntryTable.loading"
                  :columns="finPurInvoiceEntryTable.columns"
                  :dataSource="finPurInvoiceEntryTable.dataSource"
                  :maxHeight="300"
                  :rowNumber="false"
                  :rowSelection="true"
                  :actionButton="false"
                  @selectRowChange="(selectedRowIds)=>finPurInvoiceEntryTable.selectedRowCount=selectedRowIds.length"
                />
              </a-tab-pane>

              <template slot="tabBarExtraContent">
                <editable-table-columns-setter :columns="finPurInvoiceEntryTable.columns" tableName="finPurInvoiceEntryTable" />
              </template>
            </a-tabs>

            <br>
          </a-col>

          <a-col :span="24">
            <a-form-item label="备注" :labelCol="spans.labelCol1" :wrapperCol="spans.wrapperCol1">
              <a-textarea :readOnly="readOnly" v-decorator="[ 'remark']" rows="1" autoSize></a-textarea>
            </a-form-item>
          </a-col>
          <a-col :span="24">
            <a-form-item label="附件" :labelCol="spans.labelCol1" :wrapperCol="spans.wrapperCol1">
              <j-upload :disabled="readOnly" v-decorator="['attachment']" :trigger-change="true"></j-upload>
            </a-form-item>
          </a-col>
        </a-row>
      </a-form>
    </a-spin>

    <onl-cgreport-select-modal
      ref="selectModal"
      title="选择采购发票"
      reportId="1264115611825766401"
      :width="1100"
      :multiSelectable="false"
      @callback="handleSourceSelectCallback"
    />

  </j-modal>
</template>

<script>

  import pick from 'lodash.pick'
  import { FormTypes, getRefPromise, VALIDATE_NO_PASSED, validateFormAndTables } from '@/utils/JEditableTableUtil'
  import { JEditableTableMixin } from '@/mixins/JEditableTableMixin'
  import JDate from '@/components/jeecg/JDate'
  import JUpload from '@/components/jeecg/JUpload'
  import JDictSelectTag from "@/components/dict/JDictSelectTag"
  import JSelectUserByDep from '@/components/jeecgbiz/JSelectUserByDep'
  import { putAction } from '@api/manage'
  import { billModalMixin } from '../../mixins/billModalMixin'
  import EditableTableColumnsSetter from "../../components/EditableTableColumnsSetter";
  import OnlCgreportSelectModal from '../../components/OnlCgreportSelectModal'
  import { getFormatDate } from '../../utils/util'

  export default {
    name: 'RubricPurInvoiceModal',
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
        validatorRules: {
          billDate: {
            rules: [
              { required: true, message: '请输入单据日期!'},
            ]
          },
          supplierId: {
            rules: [
              { required: true, message: '请输入供应商!'},
            ]
          },
          sourceNo: {
            rules: [
              { required: true, message: '请输入采购发票!'},
            ]
          },
        },
        refKeys: ['finPurInvoiceEntry', 'sourceFinPurInvoiceEntry',],
        tableKeys:['finPurInvoiceEntry', ],
        activeKey: 'finPurInvoiceEntry',

        // 红单明细
        finPurInvoiceEntryTable: {
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
              width:"1px",
              disabled: true,
            },
            {
              title: '源单分录ID',
              key: 'sourceEntryId',
              type: FormTypes.hidden,
              width:"1px",
              disabled: true,
            },
            {
              title: '源单分录号',
              key: 'sourceEntryNo',
              type: FormTypes.hidden,
              width:"1px",
              disabled: true,
            },
            {
              title: '物料',
              key: 'materialId',
              type: FormTypes.sel_search,
              dictCode:"bas_material,name,id",
              width:"160px",
              defaultValue: '',
              options:[],
              disabled: true,
            },
            {
              title: '仓库',
              key: 'warehouseId',
              type: FormTypes.select,
              dictCode:"bas_warehouse,name,id",
              width:"150px",
              defaultValue: '',
              options:[],
              disabled: true,
            },
            {
              title: '批次号',
              key: 'batchNo',
              type: FormTypes.input,
              width:"200px",
              defaultValue: '',
              disabled: true,
            },
            {
              title: '结算数量',
              key: 'settleQty',
              type: FormTypes.input,
              width:"100px",
              defaultValue: '',
              disabled: true,
            },
            {
              title: '结算金额',
              key: 'settleAmt',
              type: FormTypes.input,
              width:"100px",
              defaultValue: '',
              disabled: true,
            },
            {
              title: '税率',
              key: 'taxRate',
              type: FormTypes.input,
              width:"80px",
              defaultValue: '',
            },
            {
              title: '发票号',
              key: 'invoiceNo',
              type: FormTypes.input,
              width:"240px",
              placeholder: '请输入${title}',
              defaultValue: '',
              validateRules: [{ required: true, message: '${title}不能为空' }],
            },
            {
              title: '开票日期',
              key: 'invoiceDate',
              type: FormTypes.date,
              width:"120px",
              placeholder: '请输入${title}',
              defaultValue: '',
            },
            {
              title: '开票数量',
              key: 'invoiceQty',
              type: FormTypes.inputNumber,
              width:"100px",
              placeholder: '请输入${title}',
              defaultValue: '',
              validateRules: [
                { required: true, message: '${title}不能为空' },
                { pattern: /^((-\d+(\.\d+)?)|(0+(\.0+)?))$/, message: '请输入0或负数!' },
                { handler: this.validateRubric}
              ],
            },
            {
              title: '开票金额',
              key: 'invoiceAmt',
              type: FormTypes.inputNumber,
              width: "100px",
              placeholder: '请输入${title}',
              defaultValue: '',
              validateRules: [
                {required: true, message: '${title}不能为空'},
                { pattern: /^((-\d+(\.\d+)?)|(0+(\.0+)?))$/, message: '请输入0或负数!' },
                {handler: this.validateRubric},
              ],
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
          ]
        },

        //蓝字明细
        sourceFinPurInvoiceEntryTable: {
          loading: false,
          dataSource: [],
          selectedRowCount: 0,
          disabledRows:{},
        },

        url: {
          add: "/finance/finPurInvoice/add",
          edit: "/finance/finPurInvoice/edit",
          approve: "/finance/finPurInvoice/approve",
          finPurInvoiceEntry: {
            list: '/finance/finPurInvoice/queryFinPurInvoiceEntryByMainId'
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
        this.model.isAuto = 0
        this.model.isRubric = 1
        this.model.sourceType = 'fin_pur_invoice'
        //处理状态：编辑中
        this.model.billProcStatus = '12'

        // 请求后台的填值规则接口地址
        const url = '/sys/fillRule/executeRuleByCode/'
        const ruleCode = 'pur_invoice_bill_no'
        const that = this
        putAction(url + ruleCode, {}).then(res => {
          // 执行成功，获取返回的值，并赋到页面上
          if (res.success) {
            that.model.billNo = res.result;
            that.$nextTick(() => {
              that.form.setFieldsValue({'billNo':res.result, 'billDate':getFormatDate()});
            })
          }
        })
      },

      /** 调用完edit()方法之后会自动调用此方法 */
      editAfter() {
        const that = this;
        //sourceFinPurInvoiceEntry未在tableKeys中
        this.$nextTick( ()=>that.$refs.sourceFinPurInvoiceEntry.initialize() );

        if (this.action === 'add') {
          this.addInit();
          this.activeKey = 'sourceFinPurInvoiceEntry';
        } else {
          this.activeKey = 'finPurInvoiceEntry';
        }

        let fieldval = pick(this.model,'billNo','billDate','isAuto','invoiceType','isRubric',
          'sourceType','sourceNo','clerkId','supplierId','attachment','remark',
          'billProcStatus','approverId','flowId','isApproved','effectiveTime','isVoided','isClosed',
          'sysOrgCode','createBy','createTime','updateBy','updateTime')
        this.$nextTick(() => {
          this.form.setFieldsValue(fieldval)
        })
        // 加载子表数据
        if (this.model.id) {
          let params = { id: this.model.id }
          this.requestSubTableData(this.url.finPurInvoiceEntry.list, params, this.finPurInvoiceEntryTable,
            loadSecondSubTableData);

          function loadSecondSubTableData(){
            let params = { id: that.model.sourceId }
            that.requestSubTableData(that.url.finPurInvoiceEntry.list, params, that.sourceFinPurInvoiceEntryTable,
              that.refreshDisabledRows);
          }
        }
      },

      /** 整理成formData */
      classifyIntoFormData(allValues) {
        let main = Object.assign(this.model, allValues.formValue)
        return {
          ...main, // 展开
          finPurInvoiceEntryList: allValues.tablesValue[0].values,
        }
      },

      validateError(msg){
        this.$message.error(msg)
      },

      popupCallback(row){
        this.form.setFieldsValue(pick(row,'billNo','billDate','isAuto','invoiceType','isRubric',
          'sourceType','sourceNo','clerkId','supplierId','attachment','remark',
          'billProcStatus','approverId','flowId','isApproved','effectiveTime','isVoided','isClosed',
          'sysOrgCode','createBy','createTime','updateBy','updateTime'))
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
        this.requestSubTableData(this.url.finPurInvoiceEntry.list, params, this.sourceFinPurInvoiceEntryTable,
          this.refreshDisabledRows);
      },

      handleAddEntry(){
        let source = this.$refs.sourceFinPurInvoiceEntry,
            target = this.$refs.finPurInvoiceEntry;

        let { values } = source.getValuesSync({ validate: false, rowIds: source.selectedRowIds});
        for(let v of values) {
          let row = pick(v, 'entryNo','materialId','warehouseId','batchNo','settleQty','settleAmt','taxRate');
          row.sourceType = 'fin_pur_invoice.fin_pur_invoice_entry';
          row.sourceEntryId = v.id;
          row.sourceEntryNo = this.form.getFieldValue("sourceNo") + '.' + v.entryNo;
          row.invoiceQty = -v.invoiceQty;
          row.invoiceAmt = -v.invoiceAmt;
          target.add();
          let rowId = target.rows[target.rows.length - 1].id;
          target.setValues([{rowKey: rowId, values: row}]);
        }
        this.refreshDisabledRows();
      },

      handleRemoveEntry(){
        this.$refs.finPurInvoiceEntry.removeSelectedRows();
        this.refreshDisabledRows();
      },

      refreshDisabledRows(){
        let entryNos = [];
        let { values } = this.$refs.finPurInvoiceEntry.getValuesSync({ validate: false});
        for(let v of values) {
          entryNos.push(Number(v.entryNo));
        }
        this.sourceFinPurInvoiceEntryTable.disabledRows = entryNos.length===0 ? {} : {entryNo:entryNos};
        //disabledRowIds不初始会保留前面的数据，导致与disabledRows不一致！
        this.$refs.sourceFinPurInvoiceEntry.disabledRowIds = [];
        //使新的disabledRows生效
        let dataSource = [...this.sourceFinPurInvoiceEntryTable.dataSource];
        this.sourceFinPurInvoiceEntryTable.dataSource = dataSource;
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
        let rows = this.sourceFinPurInvoiceEntryTable.dataSource.filter(row => row.id === sourceEntryId);
        let blue = rows[0][column.key]
        if (isNaN(blue)) {
          callback();
          return;
        }

        if (-rubric > blue) {
          callback(false, '不能超出蓝单！');
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
