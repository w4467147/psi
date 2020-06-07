<template>
  <j-modal
    :title="'其他入库 - ' + title"
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
            <a @click="() => moreStatus = !moreStatus" style="float: right; margin-top: 10px">
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
            <a-form-item label="源单类型" :labelCol="spans.labelCol3" :wrapperCol="spans.wrapperCol3">
              <j-dict-select-tag :disabled="readOnly" type="list" v-decorator="['sourceType', validatorRules.sourceType]" :trigger-change="true" dictCode="x_bill_type" placeholder="请选择源单类型"/>
            </a-form-item>
          </a-col>
          <a-col :span="8">
            <!--sourceType、sourceId、sourceNo应一起考虑-->
            <a-form-item label="源单号" :labelCol="spans.labelCol3" :wrapperCol="spans.wrapperCol3">
              <a-input :readOnly="readOnly" v-decorator="[ 'sourceNo', validatorRules.sourceNo]" placeholder="请输入源单号"></a-input>
            </a-form-item>
          </a-col>
          <a-col :span="8">
            <a-form-item label="业务员" :labelCol="spans.labelCol3" :wrapperCol="spans.wrapperCol3">
              <j-select-user-by-dep :disabled="readOnly" v-decorator="['clerkId', validatorRules.clerkId]" :trigger-change="true"/>
            </a-form-item>
          </a-col>
          <a-col :span="8">
            <a-form-item label="入库经办" :labelCol="spans.labelCol3" :wrapperCol="spans.wrapperCol3">
              <j-select-user-by-dep :disabled="readOnly" v-decorator="['handlerId', validatorRules.handlerId]" :trigger-change="true"/>
            </a-form-item>
          </a-col>
          <a-col :span="8">
            <a-form-item label="供应商" :labelCol="spans.labelCol3" :wrapperCol="spans.wrapperCol3">
              <j-dict-select-tag :disabled="readOnly" type="list" v-decorator="['supplierId', validatorRules.supplierId]" :trigger-change="true" dictCode="bas_supplier,name,id" placeholder="请选择供应商"/>
            </a-form-item>
          </a-col>
          <a-col :span="8" >
            <a-form-item label="结算数量和金额是否等于入库" :labelCol="{span:15}" :wrapperCol="{span:9}">
              <j-dict-select-tag  :disabled="true"
                                  @change=""
                                  type="list"
                                  v-decorator="['isSameSettle', validatorRules.isSameSettle]"
                                  :trigger-change="true" dictCode="yn" />
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
        <a-tab-pane tab="明细" :key="refKeys[0]" :forceRender="true">
          <j-editable-table
            :disabled="readOnly"
            :ref="refKeys[0]"
            :loading="stkIoBillEntryTable.loading"
            :columns="stkIoBillEntryTable.columns"
            :dataSource="stkIoBillEntryTable.dataSource"
            :maxHeight="300"
            :rowNumber="false"
            :rowSelection="true"
            :actionButton="!readOnly"
            @valueChange="onValueChange"
            @added="onInEntryAdded">
          </j-editable-table>
        </a-tab-pane>

        <template slot="tabBarExtraContent">
          <editable-table-columns-setter :columns="stkIoBillEntryTable.columns" tableName="stkIoBillEntryTable" />
        </template>
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
  import JSelectUserByDep from '@/components/jeecgbiz/JSelectUserByDep'
  import JDictSelectTag from "@/components/dict/JDictSelectTag"
  import { putAction } from '@api/manage'
  import { billModalMixin } from '../../mixins/billModalMixin'
  import OnlCgreportSelectModal from '../../components/OnlCgreportSelectModal'
  import EditableTableColumnsSetter from "../../components/EditableTableColumnsSetter";
  import { getFormatDate } from '../../utils/util'
  import { validateEntryNo } from '../../utils/editableTableValidate'

  export default {
    name: 'OtherInBillModal',
    mixins: [JEditableTableMixin, billModalMixin],
    components: {
      EditableTableColumnsSetter,
      OnlCgreportSelectModal,
      JDate,
      JUpload,
      JSelectUserByDep,
      JDictSelectTag,
    },

    data() {
      return {
        width: '1200px',
        moreStatus: false,

        // 新增时子表默认添加几行空数据
        addDefaultRowNum: 1,
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
          sourceId: {rules: [
          ]},
          sourceNo: {rules: [
          ]},
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
        refKeys: ['stkIoBillEntry', ],
        tableKeys:['stkIoBillEntry', ],
        activeKey: 'stkIoBillEntry',
        // 明细
        stkIoBillEntryTable: {
          loading: false,
          dataSource: [],
          columns: [
            {
              title: '分录号',
              key: 'entryNo',
              type: FormTypes.inputNumber,
              width:"60px",
              defaultValue: '',
              validateRules: [
                { required: true, message: '${title}不能为空' },
                { pattern: /^[1-9]\d*$/, message: '请输入零以上的正整数' },
                { handler: validateEntryNo}],
            },
            { //sourceType、sourceEntryId、sourceEntryNo应一起考虑
              title: '源单分录号',
              key: 'sourceEntryNo',
              type: FormTypes.input,
              width:"180px",
              defaultValue: '',
            },
            {
              title: '物料',
              key: 'materialId',
              type: FormTypes.sel_search,
              dictCode:"bas_material,name,id",
              width:"200px",
              placeholder: '请输入${title}',
              defaultValue: '',
              validateRules: [{ required: true, message: '${title}不能为空' }],
              options:[],
            },
            {
              title: '计量单位',
              key: 'unitId',
              type: FormTypes.select,
              dictCode:"bas_measure_unit,name,id",
              width:"100px",
              placeholder: '请输入${title}',
              defaultValue: '',
              validateRules: [{ required: true, message: '${title}不能为空' }],
              options:[],
            },
            {
              title: '入库数量',
              key: 'qty',
              type: FormTypes.inputNumber,
              statistics: "true",
              width:"100px",
              placeholder: '请输入${title}',
              defaultValue: '',
              validateRules: [{ required: true, message: '${title}不能为空' }],
            },
            {
              title: '入库成本',
              key: 'cost',
              type: FormTypes.inputNumber,
              statistics: "true",
              width:"100px",
              placeholder: '请输入${title}',
              defaultValue: '',
              validateRules: [{ required: true, message: '${title}不能为空' }],
            },
            {
              title: '成本含税',
              key: 'isInclTax',
              type: FormTypes.select,
              dictCode:"yn",
              width:"80px",
              placeholder: '请输入${title}',
              defaultValue: '',
              options:[],
              validateRules: [{ required: true, message: '${title}不能为空' }],
            },
            {
              title: '仓库',
              key: 'warehouseId',
              type: FormTypes.select,
              dictCode:"bas_warehouse,name,id",
              width:"150px",
              placeholder: '请输入${title}',
              defaultValue: '',
              options:[],
              validateRules: [{ required: true, message: '${title}不能为空' }],
            },
            {
              title: '批次号',
              key: 'batchNo',
              type: FormTypes.input,
              width:"200px",
              placeholder: '请输入${title}',
              defaultValue: '',
              validateRules: [{ required: true, message: '${title}不能为空' }],
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
              type: FormTypes.input,
              width:"1px",
              placeholder: '',
              defaultValue: '',
            },
          ],
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
        //其他入库
        this.model.stockIoType = '199'
        this.model.isRubric = 0
        //是否有往来
        this.model.hasRp = 0
        //结算是否同入库（或取自系统参数）
        this.model.isSameSettle = 0
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
            that.$nextTick(() => {
              that.form.setFieldsValue({'billNo':res.result, 'billDate':getFormatDate()});

              //初始空白行增加时，billNo可能还未生成！
              let { values } = this.$refs.stkIoBillEntry.getValuesSync({ validate: false});
              for (let v of values) {
                that.$refs.stkIoBillEntry.setValues([{rowKey: v.id, values: {batchNo: that.model.billNo +'-' + v.entryNo}}]);
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

        let fieldval = pick(this.model,'billNo','billDate','sourceType','sourceId','sourceNo','clerkId','handlerId','isRubric','isSameSettle','supplierId','customerId','attachment','remark','billProcStatus','approverId','flowId','isApproved','effectiveTime','isVoided','isClosed','sysOrgCode','createBy','createTime','updateBy','updateTime')
        this.$nextTick(() => {
          this.form.setFieldsValue(fieldval)
        })
        // 加载子表数据
        if (this.model.id) {
          let params = { id: this.model.id }
          this.requestSubTableData(this.url.stkIoBillEntry.list, params, this.stkIoBillEntryTable)
        }
      },
      /** 整理成formData */
      classifyIntoFormData(allValues) {
        let main = Object.assign(this.model, allValues.formValue)

        return {
          ...main, // 展开
          stkIoBillEntryList: allValues.tablesValue[0].values,
        }
      },
      validateError(msg){
        this.$message.error(msg)
      },
      popupCallback(row){
        this.form.setFieldsValue(pick(row,'billNo','billDate','sourceType','sourceId','sourceNo','clerkId','handlerId','isRubric','isSameSettle','supplierId','customerId','attachment','remark','billProcStatus','approverId','flowId','isApproved','effectiveTime','isVoided','isClosed','sysOrgCode','createBy','createTime','updateBy','updateTime'))
      },

       onInEntryAdded(event){
         this.onEntryAdded(event);

         const { row, target } = event
         let { values } = target.getValuesSync({ validate: false, rowIds: [row.id] });
         let batchNo =  this.model.billNo + "-" + values[0].entryNo;
         target.setValues([{rowKey: row.id, values: {batchNo: batchNo, flag: "1"}}]);
      },

      //单元值改变一个字符就触发一次
      onValueChange(event) {
        const { type, row, column, value, target } = event

        //flag: 是否自动设置的batchNo
        if (row.flag == null || row.flag === "") {
          target.setValues([{rowKey: row.id, values: {flag: "0"}}]);
        }
        if (column.key === "entryNo" && (row.flag === "1" || row.batchNo === "" || row.batchNo == null)) {
          target.setValues([{rowKey: row.id, values: {batchNo: this.model.billNo + "-" + value, flag: "1"}}]);
        }
        else if (column.key === "batchNo") {
          target.setValues([{rowKey: row.id, values: {flag: "0"}}]);
        }
      },

      validateEntryNoHandler(type, value, row, column, callback, target) {
        if (type !== 'blur') {
          callback();//无参或者null：不做操作
          return;
        }

        let { values } = target.getValuesSync({ validate: false });
        let count = 0;
        for (let val of values) {
          if (Number(val['entryNo']) === Number(value)) {
            if (++count >= 2) {
              callback(false, '${title}不能重复');
              return;
            }
          }
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
