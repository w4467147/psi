<template>
  <j-modal
    :title="'其他付款 - ' + title"
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
        </a-row>
        <a-row>
          <a-col :span="8">
            <a-form-item label="单据编号" :labelCol="spans.labelCol3" :wrapperCol="spans.wrapperCol3">
              <a-input :readOnly="true" v-decorator="[ 'billNo', validatorRules.billNo]"></a-input>
            </a-form-item>
          </a-col>
          <a-col :span="8">
            <a-form-item label="单据日期" :labelCol="spans.labelCol3" :wrapperCol="spans.wrapperCol3">
              <j-date :readOnly="readOnly" v-decorator="[ 'billDate', validatorRules.billDate]" :trigger-change="true" style="width: 100%"/>
            </a-form-item>
          </a-col>
          <a-col :span="8">
            <a-form-item  label="制单人" :labelCol="spans.labelCol3" :wrapperCol="spans.wrapperCol3">
              <j-dict-select-tag disabled  type="list" v-decorator="['createBy', validatorRules.createBy]" :trigger-change="true" dictCode="sys_user,realname,username" />
            </a-form-item>
          </a-col>
          <a-col :span="8">
            <a-form-item label="供应商" :labelCol="spans.labelCol3" :wrapperCol="spans.wrapperCol3">
              <j-dict-select-tag :disabled="readOnly" type="list" v-decorator="['supplierId', validatorRules.supplierId]" :trigger-change="true" dictCode="bas_supplier,name,id"/>
            </a-form-item>
          </a-col>
          <a-col :span="8">
            <a-form-item label="是否红字" :labelCol="spans.labelCol3" :wrapperCol="spans.wrapperCol3">
              <j-dict-select-tag :disabled="readOnly" type="list" v-decorator="['isRubric', validatorRules.isRubric]" :trigger-change="true" dictCode="yn" />
            </a-form-item>
          </a-col>
          <a-col :span="8">
            <a-form-item label="金额" :labelCol="spans.labelCol3" :wrapperCol="spans.wrapperCol3">
              <a-input-number disabled v-decorator="['amt', validatorRules.amt]" style="width: 100%"/>
            </a-form-item>
          </a-col>
          <a-col :span="8" v-show="action==='detail' && model.paymentType === '201'">
            <a-form-item label="已抵扣预付" :labelCol="spans.labelCol3" :wrapperCol="spans.wrapperCol3">
              <a-input-number disabled v-decorator="['deductedAmt', validatorRules.deductedAmt]"  style="width: 100%"/>
            </a-form-item>
          </a-col>
          <a-col :span="8" v-show="action==='detail'">
            <a-form-item label="已核销金额" :labelCol="spans.labelCol3" :wrapperCol="spans.wrapperCol3">
              <a-input-number disabled v-decorator="['checkedAmt', validatorRules.checkedAmt]" style="width: 100%"/>
            </a-form-item>
          </a-col>
        </a-row>
        <a-row>
          <a-col :span="24">
            <a-form-item label="备注" :labelCol="spans.labelCol1" :wrapperCol="spans.wrapperCol1">
              <a-textarea :readOnly="readOnly" v-decorator="['remark', validatorRules.remark]" rows="1" autoSize></a-textarea>
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
        <a-tab-pane tab="付款明细" :key="refKeys[0]" :forceRender="true">
          <j-editable-table
            :disabled="readOnly"
            :ref="refKeys[0]"
            :loading="finPaymentEntryTable.loading"
            :columns="finPaymentEntryTable.columns"
            :dataSource="finPaymentEntryTable.dataSource"
            :maxHeight="300"
            :rowNumber="false"
            :rowSelection="true"
            :actionButton="!readOnly"
            @added="onEntryAdded"
            @deleted="onEntryDeleted"
            @valueChange="onValueChange">
          </j-editable-table>
        </a-tab-pane>
      </a-tabs>

    </a-spin>
  </j-modal>
</template>

<script>

  import pick from 'lodash.pick'
  import { FormTypes,getRefPromise,VALIDATE_NO_PASSED, validateFormAndTables } from '@/utils/JEditableTableUtil'
  import { JEditableTableMixin } from '@/mixins/JEditableTableMixin'
  import JDate from '@/components/jeecg/JDate'
  import JUpload from '@/components/jeecg/JUpload'
  import JDictSelectTag from "@/components/dict/JDictSelectTag"
  import { putAction } from '@api/manage'
  import { billModalMixin } from '../../mixins/billModalMixin'
  import { getFormatDate } from '../../utils/util'
  import { validateEntryNo, validateByIsRubric } from '../../utils/editableTableValidate'

  export default {
    name: 'OtherPaymentModal',
    mixins: [JEditableTableMixin, billModalMixin],
    components: {
      JDate,
      JUpload,
      JDictSelectTag,
    },

    data() {
      return {
        width: '1200px',
        moreStatus: false,

        // 新增时子表默认添加几行空数据
        addDefaultRowNum: 1,
        validatorRules: {
          billNo: {rules: [
            {required: true, message: '请输入单据编号!'},
          ]},
          billDate: {rules: [
            {required: true, message: '请输入单据日期!'},
          ]},
          supplierId: {rules: [
            {required: true, message: '请选择供应商!'},
          ]},
          amt: {rules: []},
          deductedAmt: {rules: []},
          checkedAmt: {rules: []},
          attachment: {rules: []},
          remark: {rules: []},
          billProcStatus: {rules: []},
          isApproved: {rules: []},
          isClosed: {rules: []},
          isVoided: {rules: []},
          effectiveTime: {rules: []},
          approverId: {rules: []},
          flowId: {rules: []},
          createTime: {rules: []},
          createBy: {rules: []},
          sysOrgCode: {rules: []},
          updateTime: {rules: []},
          updateBy: {rules: []},
        },
        refKeys: ['finPaymentEntry', ],
        tableKeys:['finPaymentEntry', ],
        activeKey: 'finPaymentEntry',
        // 付款明细
        finPaymentEntryTable: {
          loading: false,
          dataSource: [],
          columns: [
            {
              title: '分录号',
              key: 'entryNo',
              type: FormTypes.inputNumber,
              width:"60px",
              placeholder: '请输入${title}',
              defaultValue: '',
              validateRules: [
                { required: true, message: '${title}不能为空' },
                { pattern: /^[1-9]\d*$/, message: '请输入零以上的正整数' },
                { handler: validateEntryNo}
              ],
            },
            {//sourceType、sourceEntry、sourceEntryNo应一起考虑
              title: '源单分录号',
              key: 'sourceEntryNo',
              type: FormTypes.input,
              width:"180px",
              defaultValue: '',
            },
            {
              title: '结算方式',
              key: 'settleMethod',
              type: FormTypes.select,
              dictCode:"x_settle_method",
              width:"150px",
              defaultValue: '',
              options:[],
              validateRules: [{ required: true, message: '${title}不能为空' }],
           },
            {
              title: '资金账户',
              key: 'bankAccountId',
              type: FormTypes.select,
              dictCode:"bas_bank_account,account_no,id",
              width:"260px",
              defaultValue: '',
              options:[],
            },
            {
              title: '金额',
              key: 'amt',
              type: FormTypes.inputNumber,
              width:"120px",
              defaultValue: '',
              validateRules: [
                { required: true, message: '${title}不能为空' },
                { handler: validateByIsRubric}
              ],
            },
            {
              title: '备注',
              key: 'remark',
              type: FormTypes.input,
              width:"200px",
              defaultValue: '',
            },
            {
              title: '备注2',
              key: 'remark2',
              type: FormTypes.input,
              width:"200px",
              defaultValue: '',
            },
            {
              title: '备注3',
              key: 'remark3',
              type: FormTypes.input,
              width:"200px",
              defaultValue: '',
            },
          ]
        },
        url: {
          add: "/finance/finPayment/add",
          edit: "/finance/finPayment/edit",
          approve: "/finance/finPayment/approve",
          finPaymentEntry: {
            list: '/finance/finPayment/queryFinPaymentEntryByMainId'
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
        //其他付款
        this.model.paymentType = '299'
        this.model.isRubric = 0;
        //处理状态：编辑中
        this.model.billProcStatus = '12'
        this.model.amt = 0;
        this.model.deductedAmt = 0;
        this.model.checkedAmt = 0;

        // 请求后台的填值规则接口地址
        const url = '/sys/fillRule/executeRuleByCode/'
        const ruleCode = 'payment_bill_no'
        const that = this
        putAction(url + ruleCode, {}).then(res => {
          // 执行成功，获取返回的值，并赋到页面上
          if (res.success) {
            that.$nextTick(() => {
              that.form.setFieldsValue({'billNo':res.result, 'billDate':getFormatDate()})
            })
          }
        })
      },

      /** 调用完edit()方法之后会自动调用此方法 */
      editAfter() {
        if (this.action === 'add') {
          this.addInit()
        }

        let fieldval = pick(this.model,'billNo','billDate','supplierId','isRubric','amt','deductedAmt','checkedAmt','attachment','remark','billProcStatus','isApproved','isClosed','isVoided','effectiveTime','approverId','flowId','createTime','createBy','sysOrgCode','updateTime','updateBy')
        this.$nextTick(() => {
          this.form.setFieldsValue(fieldval)
        })
        // 加载子表数据
        if (this.model.id) {
          let params = { id: this.model.id }
          this.requestSubTableData(this.url.finPaymentEntry.list, params, this.finPaymentEntryTable)
        }
      },
      /** 整理成formData */
      classifyIntoFormData(allValues) {
        let main = Object.assign(this.model, allValues.formValue)

        return {
          ...main, // 展开
          finPaymentEntryList: allValues.tablesValue[0].values,
        }
      },
      validateError(msg){
        this.$message.error(msg)
      },
      popupCallback(row){
        this.form.setFieldsValue(pick(row,'billNo','billDate','supplierId','isRubric','amt','deductedAmt','checkedAmt','attachment','remark','billProcStatus','isApproved','isClosed','isVoided','effectiveTime','approverId','flowId','createTime','createBy','sysOrgCode','updateTime','updateBy'))
      },

      onEntryDeleted(deleteIds) {
        this.calcTotalAmt();
      },

      //单元值改变一个字符就触发一次
      onValueChange(event) {
        const { type, row, column, value, target } = event
        if (column.key === "amt") {
          this.calcTotalAmt();
        }
      },

      calcTotalAmt() {
        let { error, values } = this.$refs.finPaymentEntry.getValuesSync({ validate: false})
        let total = 0;
        for (let v of values) {
          let amt = Number(v['amt'])
          if (!isNaN(amt)) {
            total += amt;
          }
        }

        const that = this;
        that.$nextTick(() => {
          that.form.setFieldsValue({'amt':total})
        })
      },

    }

  }
</script>

<style lang="less" scoped>
  .ant-row.ant-form-item {
    margin-bottom: 12px;
  }
</style>
