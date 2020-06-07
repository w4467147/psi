<template>
  <j-modal
    :title="'销售发票登记 - ' + title"
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
              <j-dict-select-tag disabled type="list" v-decorator="['isClosed',validatorRules.isClosed]" :trigger-change="true" dictCode="yn" />
            </a-form-item>
          </a-col>
          <a-col :span="4">
            <a-form-item label="是否作废" :labelCol="spans.labelCol6" :wrapperCol="spans.wrapperCol6">
              <j-dict-select-tag disabled type="list" v-decorator="['isVoided',validatorRules.isVoided]" :trigger-change="true" dictCode="yn"/>
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
              <j-dict-select-tag  disabled type="list" v-decorator="['isRubric', validatorRules.isRubric]" :trigger-change="true" dictCode="yn" />
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
              <j-dict-select-tag disabled type="list" v-decorator="['createBy', validatorRules.createBy]" :trigger-change="true" dictCode="sys_user,realname,username" />
            </a-form-item>
          </a-col>
          <a-col v-show="false" :span="8">
            <a-form-item label="源单类型" :labelCol="spans.labelCol3" :wrapperCol="spans.wrapperCol3">
              <j-dict-select-tag :disabled="readOnly" type="list" v-decorator="['sourceType', validatorRules.sourceType]" :trigger-change="true" dictCode="x_bill_type" placeholder="请选择源单类型"/>
            </a-form-item>
          </a-col>
          <a-col v-show="false" :span="8">
            <!--sourceType、sourceId、sourceNo应一起考虑-->
            <a-form-item label="源单号" :labelCol="spans.labelCol3" :wrapperCol="spans.wrapperCol3">
              <a-input :readOnly="readOnly" v-decorator="[ 'sourceNo', validatorRules.sourceNo]" placeholder="请输入源单号"></a-input>
            </a-form-item>
          </a-col>
          <a-col v-show="false" :span="8">
            <a-form-item label="业务员" :labelCol="spans.labelCol3" :wrapperCol="spans.wrapperCol3">
              <j-select-user-by-dep :disabled="readOnly" v-decorator="['clerkId', validatorRules.clerkId]" :trigger-change="true"/>
            </a-form-item>
          </a-col>
          <a-col :span="8">
            <!--业务员有客户分管范围，所以先输入业务员，再选择客户-->
            <a-form-item label="客户" :labelCol="spans.labelCol3" :wrapperCol="spans.wrapperCol3">
              <j-dict-select-tag :disabled="readOnly" type="list" v-decorator="['customerId', validatorRules.customerId]" :trigger-change="true" dictCode="bas_customer,name,id" placeholder="请选择客户"/>
            </a-form-item>
          </a-col>
          <a-col :span="8">
            <a-form-item label="发票类型" :labelCol="spans.labelCol3" :wrapperCol="spans.wrapperCol3">
              <j-dict-select-tag :disabled="readOnly" type="list" v-decorator="['invoiceType']" :trigger-change="true" dictCode="x_invoice_type" placeholder="请选择发票类型"/>
            </a-form-item>
          </a-col>

          <a-col :span="24">
            <!-- 子表单区域 -->
            <a-tabs v-model="activeKey" @change="handleChangeTabs">
              <a-tab-pane tab="明细" :key="refKeys[0]" :forceRender="true">
                <div v-if="!readOnly" class="table-operator">
                  <a-button @click="handleSalOutSelect" type="primary" icon="plus">添加出库单</a-button>
                  <a-button v-if="finSalInvoiceEntryTable.selectedRowCount>0"
                            @click="()=>this.$refs.finSalInvoiceEntry.removeSelectedRows()"
                            type="primary" icon="minus">删除</a-button>
                </div>

                <j-editable-table
                  :disabled="readOnly"
                  :ref="refKeys[0]"
                  :loading="finSalInvoiceEntryTable.loading"
                  :columns="finSalInvoiceEntryTable.columns"
                  :dataSource="finSalInvoiceEntryTable.dataSource"
                  :maxHeight="300"
                  :rowNumber="false"
                  :rowSelection="true"
                  :actionButton="false"
                  @added="onEntryAdded"
                  @selectRowChange="(selectedRowIds)=>finSalInvoiceEntryTable.selectedRowCount=selectedRowIds.length"
                />
              </a-tab-pane>

              <template slot="tabBarExtraContent">
                <editable-table-columns-setter :columns="finSalInvoiceEntryTable.columns" tableName="finSalInvoiceEntryTable" />
                   </template>

            </a-tabs>

            <br>
          </a-col>

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
    </a-spin>

    <onl-cgreport-select-modal
      ref="selectModal"
      title="选择销售出库单"
      reportId="1261479821635354626"
      :width="1100"
      :multiSelectable="false"
      @callback="handleSalOutSelectCallback"
    />

  </j-modal>
</template>

<script>

  import pick from 'lodash.pick'
  import { FormTypes, getRefPromise, VALIDATE_NO_PASSED, validateFormAndTables } from '@/utils/JEditableTableUtil'
  import { JEditableTableMixin } from '@/mixins/JEditableTableMixin'
  import { validateDuplicateValue } from '@/utils/util'
  import JDate from '@/components/jeecg/JDate'  
  import JUpload from '@/components/jeecg/JUpload'
  import JDictSelectTag from "@/components/dict/JDictSelectTag"
  import JSelectUserByDep from '@/components/jeecgbiz/JSelectUserByDep'
  import { getAction, putAction } from '@api/manage'
  import { billModalMixin } from '../../mixins/billModalMixin'
  import EditableTableColumnsSetter from "../../components/EditableTableColumnsSetter";
  import OnlCgreportSelectModal from '../../components/OnlCgreportSelectModal'
  import { getFormatDate } from '../../utils/util'
  import { validateEntryNo } from '../../utils/editableTableValidate'

  export default {
    name: 'SalInvoiceModal',
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
          billNo: {
            rules: [
              { required: true, message: '请输入单据编号!'},
            ]
          },
          billDate: {
            rules: [
              { required: true, message: '请输入单据日期!'},
            ]
          },
          isRubric: {
            rules: [
              { required: true, message: '请输入是否红字!'},
            ]
          },
          customerId: {
            rules: [
              { required: true, message: '请输入客户!'},
            ]
          },
          isVoided: {rules: []},
          isClosed: {rules: []},
        },
        refKeys: ['finSalInvoiceEntry', ],
        tableKeys:['finSalInvoiceEntry', ],
        activeKey: 'finSalInvoiceEntry',
        // 明细
        finSalInvoiceEntryTable: {
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
              validateRules: [
                { required: true, message: '${title}不能为空' },
                { pattern: /^[1-9]\d*$/, message: '请输入零以上的正整数' },
                { handler: validateEntryNo}],
            },
            {
              title: '源单类型',
              key: 'sourceType',
              type: FormTypes.hidden,
              width:"1px",
              defaultValue: 'stk_io_bill.stk_io_bill_entry',
            },
            {
              title: '源单分录ID',
              key: 'sourceEntryId',
              type: FormTypes.hidden,
              width:"1px",
              defaultValue: '',
            },
            {
              title: '出库单分录',
              key: 'sourceEntryNo',
              type: FormTypes.input,
              width:"210px",
              defaultValue: '',
              validateRules: [{ required: true, message: '${title}不能为空' }],
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
              title: '已开票数量',
              key: 'invoicedQty',
              type: FormTypes.input,
              width:"100px",
              defaultValue: '',
              disabled: true,
            },
            {
              title: '已开票金额',
              key: 'invoicedAmt',
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
                { handler: this.validateInvoiceQty}
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
                {handler: this.validateInvoiceAmt},
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

        url: {
          add: "/finance/finSalInvoice/add",
          edit: "/finance/finSalInvoice/edit",
          approve: "/finance/finSalInvoice/approve",
          finSalInvoiceEntry: {
            list: '/finance/finSalInvoice/queryFinSalInvoiceEntryByMainId'
          },
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
        this.model.isAuto = 0
        this.model.isRubric = 0
        //处理状态：编辑中
        this.model.billProcStatus = '12'

        // 请求后台的填值规则接口地址
        const url = '/sys/fillRule/executeRuleByCode/'
        const ruleCode = 'sal_invoice_bill_no'
        const that = this
        putAction(url + ruleCode, {}).then(res => {
          // 执行成功，获取返回的值，并赋到页面上
          if (res.success) {
            that.model.billNo = res.result;
            that.$nextTick(() => {
              that.form.setFieldsValue({'billNo':res.result, 'billDate':getFormatDate()});

              //初始空白行增加时，billNo可能还未生成！
              let { values } = this.$refs.finSalInvoiceEntry.getValuesSync({ validate: false});
              for (let v of values) {
                that.$refs.finSalInvoiceEntry.setValues([{rowKey: v.id, values: {batchNo: that.model.billNo +'-' + v.entryNo}}]);
              }
            })
          }
        })
      },

      /** 调用完edit()方法之后会自动调用此方法 */
      editAfter() {
        if (this.action === 'add') {
          this.addInit()
        }

        let fieldval = pick(this.model,'billNo','billDate','isAuto','invoiceType','isRubric',
          'sourceType','sourceId','sourceNo','clerkId','customerId','attachment','remark',
          'billProcStatus','approverId','flowId','isApproved','effectiveTime','isVoided','isClosed',
          'sysOrgCode','createBy','createTime','updateBy','updateTime')
        this.$nextTick(() => {
          this.form.setFieldsValue(fieldval)
        })
        // 加载子表数据
        if (this.model.id) {
          let params = { id: this.model.id }
          this.requestSubTableData(this.url.finSalInvoiceEntry.list, params, this.finSalInvoiceEntryTable)
        }
      },
      /** 整理成formData */
      classifyIntoFormData(allValues) {
        let main = Object.assign(this.model, allValues.formValue)
        return {
          ...main, // 展开
          finSalInvoiceEntryList: allValues.tablesValue[0].values,
        }
      },
      validateError(msg){
        this.$message.error(msg)
      },
      popupCallback(row){
        this.form.setFieldsValue(pick(row,'billNo','billDate','isAuto','invoiceType','isRubric',
          'sourceType','sourceId','sourceNo','clerkId','customerId','attachment','remark',
          'billProcStatus','approverId','flowId','isApproved','effectiveTime','isVoided','isClosed',
          'sysOrgCode','createBy','createTime','updateBy','updateTime'))
      },

      handleSalOutSelect(){
        let queryParams = {};
        queryParams['customer_id'] = this.form.getFieldValue('customerId');
        this.$refs.selectModal.initQueryParams(queryParams);
        this.$refs.selectModal.visible = true;
      },

      handleSalOutSelectCallback(selectedRows){
        const that = this;
        let target = that.$refs.finSalInvoiceEntry;
        let url = that.url.stkIoBillEntry.list;
        let params = { id: selectedRows[0]['id'] };

        that.finSalInvoiceEntryTable.loading = true;
        getAction(url, params).then(res => {
          let { values } = target.getValuesSync({ validate: false });
          for (let rec of res.result || []) {
            if (values.filter(row => row.stockInEntryId === rec.id ).length ===0) {
              target.add();
              let rowId = target.rows[target.rows.length - 1].id;
              target.setValues([{
                rowKey: rowId,
                values: {
                  sourceEntryId: rec.id,
                  sourceEntryNo: rec.billNo + '.' + rec.entryNo,
                  ...pick(rec, 'materialId','warehouseId','batchNo','settleQty','settleAmt',
                    'invoicedQty','invoicedAmt','taxRate')
                }
              }]);
            }
          }
        }).finally(() => {
          that.finSalInvoiceEntryTable.loading = false;
        });
      },

      validateInvoiceQty(type, value, row, column, callback, target) {
        if (type !== 'blur') {
          callback();
          return;
        }

        let { values } = target.getValuesSync({ validate: false, rowIds: [row.id]});
        let settleQty = Number(values[0].settleQty);
        let invoicedQty = Number(values[0].invoicedQty);
        let invoiceQty = Number(value);
        if (isNaN(settleQty) || isNaN(invoicedQty) || isNaN(invoiceQty)) {
          callback();
          return;
        }
        if (invoiceQty + invoicedQty > settleQty) {
          callback(false, '开票数量不能大于未开票数量！');
        } else{
          callback(true);
        }
      },

      validateInvoiceAmt(type, value, row, column, callback, target) {
        if (type !== 'blur') {
          callback();
          return;
        }

        let { values } = target.getValuesSync({ validate: false, rowIds: [row.id]});
        let settleAmt = Number(values[0].settleAmt);
        let invoicedAmt = Number(values[0].invoicedAmt);
        let invoiceAmt = Number(value);
        if (isNaN(settleAmt) || isNaN(invoicedAmt) || isNaN(invoiceAmt)) {
          callback();
          return;
        }
        if (invoiceAmt + invoicedAmt > settleAmt) {
          callback(false, '开票金额不能大于未开票金额！');
        } else{
          callback(true);
        }
      },

    },

  }
</script>

<style lang="less" scoped>
  .ant-row.ant-form-item {
    margin-bottom: 12px;
  }
</style>
