<template>
  <j-modal
    :title="'涨库入库 - ' + title"
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
              <j-dict-select-tag type="list" v-decorator="['isRubric', validatorRules.isRubric]" :trigger-change="true" dictCode="yn" />
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
          <a-col :span="24">
            <a-form-item label="备注" :labelCol="spans.labelCol1" :wrapperCol="spans.wrapperCol1">
              <a-textarea :readOnly="readOnly" v-decorator="[ 'remark', validatorRules.remark]"  rows="1" autoSize></a-textarea>
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
            @added="onEntryAdded">

            <template v-slot:batchNoSelectModal="props" style="padding-left: 0">
              <a-button @click="handleBatchNoSelect(props)" icon="ellipsis"></a-button>
              <onl-cgreport-select-modal
                ref="selectModal"
                title="选择库存批次"
                reportId="49d9b3c81f5647dea5b4d1f431613920"
                :width="1100"
                :multiSelectable="true"
                @callback="(selectedRows)=>handleBatchNoSelectCallback(props,selectedRows)"/>
            </template>

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
    name: 'SwellInBillModal',
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
              disabled: true,
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
              disabled: true,
            },
            {
              title: '',
              key: 'batchNoSelectModal',
              type: FormTypes.slot,
              slotName: 'batchNoSelectModal',
              orgFields: "material_id,warehouse_id,batch_no,unit_id,supplier_id,unit_id,qty,id",
              destFields: "materialId,warehouseId,batchNo,unitId,supplierId,inventoryUnitId,inventoryQty,inventoryId",
              width:"45px",
            },
            {
              title: '供应商',
              key: 'supplierId',
              type: FormTypes.select,
              dictCode:"bas_supplier,name,id",
              width:"180px",
              placeholder: '请输入${title}',
              defaultValue: '',
              options:[],
              disabled: true,
            },
            {
              title: '库存单位',
              key: 'inventoryUnitId',
              type: FormTypes.select,
              dictCode:"bas_measure_unit,name,id",
              width:"100px",
              disabled:true,
            },
            {
              title: '库存数量',
              key: 'inventoryQty',
              type: FormTypes.input,
              statistics: "true",
              width:"100px",
              disabled:true,
            },
            {
              title: '涨库单位',
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
              title: '涨库数量',
              key: 'qty',
              type: FormTypes.inputNumber,
              statistics: "true",
              width:"100px",
              placeholder: '请输入${title}',
              defaultValue: '',
              validateRules:[
                { required: true, message: '${title}不能为空' },
                { handler: this.validateQty}
              ]
            },
            {
              title: '库存批次id',
              key: 'inventoryId',
              type: FormTypes.hidden,
              width:"10px",
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
          ],
        },
        url: {
          add: "/stock/stkIoBill/add",
          edit: "/stock/stkIoBill/edit",
          approve: "/stock/stkIoBill/approve",
          stkIoBillEntry: {
            list: '/stock/stkIoBill/queryEntryByMainId',
            editingList: '/stock/stkIoBill/queryEditingEntryByMainId'
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
        //销售出库
        this.model.stockIoType = '191'
        this.model.isAuto = 0
        this.model.isRubric = 0
        //是否有往来
        this.model.hasRp = 0
        //结算是否同出库（或取自系统参数）
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

        let fieldval = pick(this.model,'billNo','billDate','sourceType','sourceId','sourceNo','clerkId','isRubric','attachment','remark','billProcStatus','approverId','flowId','isApproved','effectiveTime','isVoided','isClosed','sysOrgCode','createBy','createTime','updateBy','updateTime')
        this.$nextTick( ()=>this.form.setFieldsValue(fieldval) );
        // 加载子表数据
        if (this.model.id) {
          let params = { id: this.model.id }
          let url = this.readOnly ? this.url.stkIoBillEntry.list : this.url.stkIoBillEntry.editingList;
          this.requestSubTableData(url, params, this.stkIoBillEntryTable);
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
        this.form.setFieldsValue(pick(row,'billNo','billDate','sourceType','sourceId','sourceNo','clerkId','isRubric','attachment','remark','billProcStatus','approverId','flowId','isApproved','effectiveTime','isVoided','isClosed','sysOrgCode','createBy','createTime','updateBy','updateTime'))
      },

      //单元值改变一个字符就触发一次
      onValueChange(event) {
        const { type, row, column, value, target } = event

      },

      handleBatchNoSelect(props){
        let row = props.getValue();
        let orgFields = props.column.orgFields.split(',');
        let destFields = props.column.destFields.split(',');
        let queryParams = {};
        for(let i = 0; i < orgFields.length; i++) {
          queryParams[orgFields[i]] = row[destFields[i]];
        }
        this.$refs.selectModal.initQueryParams(queryParams);
        this.$refs.selectModal.visible = true;
      },

      handleBatchNoSelectCallback(props, selectedRows){
        let { rowId, target } = props;
        let orgFields = props.column.orgFields.split(',');
        let destFields = props.column.destFields.split(',');
        for(let i = 0; i < selectedRows.length; i++) {
          let values = {};
          for(let j = 0; j < orgFields.length; j++) {
            values[destFields[j]] = selectedRows[i][orgFields[j]];
          }

          if (i===0) {
            target.setValues([{rowKey: rowId, values: values}]);
          } else {
            target.add();
            let rowId2 = target.rows[target.rows.length - 1].id;
            target.setValues([{rowKey: rowId2, values: values}]);
          }
        }
      },

      validateQty(type, value, row, column, callback, target) {
        if (type !== 'blur') {
          callback();
          return;
        }

        let { values } = target.getValuesSync({ validate: false, rowIds: [row.id]});
        let inventoryQty = Number(values[0].inventoryQty);
        let qty = Number(value);
        if (isNaN(qty) || isNaN(inventoryQty)) {
          callback();
          return;
        }
        if (qty + inventoryQty < 0) {
          callback(false, '涨库后不能负库存数量！');
          return;
        }

        let inventoryId = values[0].inventoryId;
        if (!inventoryId) {
          callback();
          return;
        }
        let totalQty = 0;
        let obj = target.getValuesSync({ validate: false});
        values = obj.values;
        for(let v of values) {
          qty = Number(v.qty);
          if (!isNaN(qty)) totalQty += qty;
        }
        if (totalQty + inventoryQty < 0) {
          callback(false, '该库存批次在各分录涨库后不能负库存数量！');
        } else {
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
