<template>
  <j-modal
    :title="'库存盘点卡 - ' + title"
    :width="width"
    :visible="visible"
    :confirmLoading="confirmLoading"
    :maskClosable="false"
    :keyboard="false"
    :forceRender="true"
    switchFullscreen
    @ok="handleOk"
    @cancel="handleCancel">

    <template slot="footer">
      <a-button v-if="action!=='detail'" key="cancel" @click="handleCancel">取消</a-button>
      <a-button v-if="action==='add'" key="ok"  @click="handleOk" type="primary" :loading="confirmLoading">确定</a-button>
      <a-button v-if="action==='edit'" key="save"   @click="handleSave" type="primary" :loading="confirmLoading">保存</a-button>
      <a-button v-if="action==='edit'" key="submit" @click="handleSubmit" type="primary" :loading="confirmLoading">提交</a-button>
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
            <a @click="()=> moreStatus = !moreStatus" style="float: right; margin-top: 10px">
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
            <a-form-item label="盘点人" :labelCol="labelCol" :wrapperCol="wrapperCol">
              <j-dict-select-tag type="list" v-decorator="['checkerId']" :trigger-change="true" dictCode="sys_user,realname,username" placeholder="请选择盘点人"/>
            </a-form-item>
          </a-col>
          <a-col :span="16">
            <a-form-item label="备注" :labelCol="spans.labelCol1_5" :wrapperCol="spans.wrapperCol1_5">
              <a-textarea :readOnly="readOnly" v-decorator="[ 'remark', validatorRules.remark]"  rows="1" autoSize></a-textarea>
            </a-form-item>
          </a-col>
          <a-col :span="24">
            <a-form-item label="附件" :labelCol="spans.labelCol1" :wrapperCol="spans.wrapperCol1">
              <j-upload :disabled="readOnly" v-decorator="['attachment', validatorRules.attachment]" :trigger-change="true"></j-upload>
            </a-form-item>
          </a-col>
        </a-row>
        <a-divider orientation="left" style="font-size: 14px; color: #bfbfbf;">盘点范围</a-divider>
        <a-row>
          <a-col :span="8">
            <a-form-item label="仓库" :labelCol="labelCol" :wrapperCol="wrapperCol">
              <j-dict-select-tag :disabled="action!=='add'" type="list" v-decorator="['warehouseId', validatorRules.warehouseId]" :trigger-change="true"
                                 @change="(val) => this.checkRange.warehouseId = val||''" dictCode="bas_warehouse,name,id" placeholder="请选择仓库"/>
            </a-form-item>
          </a-col>
          <a-col :span="8">
            <a-form-item label="物料分类" :labelCol="labelCol" :wrapperCol="wrapperCol">
              <j-dict-select-tag :disabled="action!=='add'"  type="list" v-decorator="['materialCategoryId']" :trigger-change="true"
                                 @change="(val) => this.checkRange.materialCategoryId = val||''" dictCode="bas_material_category,name,id" placeholder="请选择物料分类"/>
            </a-form-item>
          </a-col>
          <a-col :span="8">
            <div v-if="action==='add'">
              <a-button @click="handleCheckRangeOk" :disabled="!isCheckRangeChange" type="primary" style="margin: 5px 0 0 36px">确定</a-button>
            </div>
          </a-col>
        </a-row>
      </a-form>

      <!-- 子表单区域 -->
      <a-tabs v-model="activeKey" @change="handleChangeTabs">
        <a-tab-pane tab="明细" :key="refKeys[0]" :forceRender="true">
          <j-editable-table
            v-show="!isCheckRangeChange"
            :disabled="readOnly"
            :ref="refKeys[0]"
            :loading="stkCheckBillEntryTable.loading"
            :columns="stkCheckBillEntryTable.columns"
            :dataSource="stkCheckBillEntryTable.dataSource"
            :maxHeight="300"
            :rowNumber="false"
            :rowSelection="false"
            :actionButton="false"
            @valueChange="onValueChange"
          />
        </a-tab-pane>

        <a-tab-pane :tab="action==='add' ? '':'新批次'" :key="refKeys[1]" :forceRender="true">
          <j-editable-table
            :disabled="readOnly"
            :ref="refKeys[1]"
            :loading="stkCheckBillEntryTable.loading"
            :columns="stkCheckBillEntryTable.columnsNew"
            :dataSource="stkCheckBillEntryTable.dataSourceNew"
            :maxHeight="300"
            :rowNumber="false"
            :rowSelection="true"
            :actionButton="!readOnly"
            @valueChange="onValueChange"
            @added="onInEntryAdded"
          />
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

  export default {
    name: 'CheckBillModal',
    mixins: [JEditableTableMixin, billModalMixin],
    components: {
      JDate,
      JUpload,
      JDictSelectTag
    },

    data() {
      return {
        width: '1200px',
        moreStatus: false,
        entryNoStep: 1, //分录号自动编号步长

        //盘点范围
        checkRange: {},
        lastCheckRange: {},

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
          warehouseId: {
            rules: [
              { required: true, message: '请选择仓库!'},
            ]
          },
        },
        refKeys: ['stkCheckBillEntry', 'stkCheckBillEntryNew',],
        tableKeys:['stkCheckBillEntry', 'stkCheckBillEntryNew',],
        activeKey: 'stkCheckBillEntry',
        // 明细
        stkCheckBillEntryTable: {
          loading: false,
          dataSource: [],
          columns: [
            {
              title: '序号',
              key: 'entryNo',
              type: FormTypes.input,
              width:"70px",
              placeholder: '请输入${title}',
              defaultValue: '',
              disabled:true,
            },
            {
              title: '是否新批次',
              key: 'isNewBatch',
              type: FormTypes.hidden,
              width:"1px",
              defaultValue: '0',
              disabled:true,
            },
            {
              title: '仓库',
              key: 'warehouseId',
              type: FormTypes.select,
              dictCode:"bas_warehouse,name,id",
              width:"150px",
              defaultValue: '',
              options:[],
              disabled:true,
            },
            {
              title: '物料',
              key: 'materialId',
              type: FormTypes.select,
              dictCode:"bas_material,name,id",
              width:"150px",
              defaultValue: '',
              options:[],
              disabled:true,
            },
            {
              title: '批号',
              key: 'batchNo',
              type: FormTypes.input,
              width:"220px",
              defaultValue: '',
              disabled:true,
           },
            {
              title: '供应商',
              key: 'supplierId',
              type: FormTypes.select,
              dictCode:"bas_supplier,name,id",
              width:"150px",
              defaultValue: '',
              disabled:true,
            },
            {
              title: '计量单位',
              key: 'unitId',
              type: FormTypes.select,
              dictCode:"bas_measure_unit,name,id",
              width:"100px",
              defaultValue: '',
              options:[],
              disabled:true,
            },
            {
              title: '账存数量',
              key: 'bookQty',
              type: FormTypes.input,
              width:"100px",
              placeholder: '请输入${title}',
              defaultValue: '0',
              disabled:true,
            },
            {
              title: '实存数量',
              key: 'qty',
              type: FormTypes.inputNumber,
              width:"100px",
              placeholder: '请输入${title}',
              defaultValue: '',
            },
            {
              title: '盈亏',
              key: 'profitQty',
              type: FormTypes.inputNumber,
              width:"100px",
              placeholder: '请输入${title}',
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
          dataSourceNew: [],
          columnsNew: []
        },
        url: {
          add: "/stock/stkCheckBill/add",
          edit: "/stock/stkCheckBill/edit",
          approve: "/stock/stkCheckBill/approve",
          stkCheckBillEntry: {
            list: '/stock/stkCheckBill/queryStkCheckBillEntryByMainId',
            listByRange: '/stock/stkCheckBill/queryStkCheckBillEntryByRange'
          },
        }
      }
    },

    computed: {
      isCheckRangeChange: function () {
        return this.checkRange.warehouseId !== this.lastCheckRange.warehouseId ||
          this.checkRange.materialCategoryId !== this.lastCheckRange.materialCategoryId;
      }
    },

    created() {
      for(let col of this.stkCheckBillEntryTable.columns){
        let col2 = Object.assign({}, col);
        if (!['entryNo', 'isNewBatch', 'bookQty', 'profitQty'].includes(col2.key)) col2.disabled = false;
        if (col2.key==='isNewBatch') col2.defaultValue = '1';
        if (col2.key==='bookQty') col2.defaultValue = '0';
        this.stkCheckBillEntryTable.columnsNew.push(col2);
       }
    },

    methods: {
      getAllTable() {
        let values = this.tableKeys.map(key => getRefPromise(this, key))
        return Promise.all(values)
      },

      addInit() {
        this.checkRange = { warehouseId: '',  materialCategoryId:''}
        this.lastCheckRange = Object.assign({}, this.checkRange);

        //处理状态：编辑中
        this.model.billProcStatus = '12'

        // 请求后台的填值规则接口地址
        const url = '/sys/fillRule/executeRuleByCode/'
        const ruleCode = 'stock_check_bill_no'
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
        let columns = this.stkCheckBillEntryTable.columns.filter(col => col.key === 'qty');
        if (this.action === 'add') {
          this.addInit();
          columns[0].validateRules = [{}];
        } else if (this.action === 'edit') {
          columns[0].validateRules = [{ required: true, message: '${title}不能为空' }];
        }

        let fieldval = pick(this.model,'billNo','billDate','warehouseId','materialCategoryId','checkerId','attachment','remark','billProcStatus','approverId','flowId','isApproved','effectiveTime','isVoided','isClosed','sysOrgCode','createBy','createTime','updateBy','updateTime')
        this.$nextTick(() => {
          this.form.setFieldsValue(fieldval)
        })
        // 加载子表数据
        if (this.model.id) {
          const that = this;
          let params = { id: this.model.id }
          this.requestSubTableData(this.url.stkCheckBillEntry.list, params, this.stkCheckBillEntryTable, splitData)

          function splitData(){
            let dataSource = [], dataSourceNew = [];
            for(let row of that.stkCheckBillEntryTable.dataSource) {
              if (row.isNewBatch===0) {
                dataSource.push(row);
              } else {
                dataSourceNew.push(row);
              }
            }
            dataSource.sort((a, b) => a.entryNo - b.entryNo);
            that.stkCheckBillEntryTable.dataSource = dataSource;
            dataSourceNew.sort((a, b) => a.entryNo - b.entryNo);
            that.stkCheckBillEntryTable.dataSourceNew = dataSourceNew;
          }
        }
      },

      /** 整理成formData */
      classifyIntoFormData(allValues) {
        let main = Object.assign(this.model, allValues.formValue)
        return {
          ...main, // 展开
          stkCheckBillEntryList: allValues.tablesValue[0].values.concat(allValues.tablesValue[1].values),
        }
      },

      validateError(msg){
        this.$message.error(msg)
      },

      popupCallback(row){
        this.form.setFieldsValue(pick(row,'billNo','billDate','warehouseId','materialCategoryId','checkerId','attachment','remark','billProcStatus','approverId','flowId','isApproved','effectiveTime','isVoided','isClosed','sysOrgCode','createBy','createTime','updateBy','updateTime'))
      },

      handleCheckRangeOk(){
        this.requestSubTableData(this.url.stkCheckBillEntry.listByRange, this.checkRange, this.stkCheckBillEntryTable);
        this.lastCheckRange = Object.assign({}, this.checkRange);
      },

      onInEntryAdded(event){
        this.onEntryAdded(event);

        const { row, target } = event
        let { values } = target.getValuesSync({ validate: false, rowIds: [row.id] });
        let batchNo =  this.model.billNo + "-" + values[0].entryNo;
        target.setValues([{rowKey: row.id, values: {batchNo: batchNo, flag: "1"}}]);
     },

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

        //qty 实存数量 --> profitQty 盈亏数量
        if (column.key === 'qty') {
          let qty = Number(value);
          let bookQty = Number(row.bookQty);
          if (!isNaN(qty) && !isNaN(bookQty)){
            target.setValues([{rowKey: row.id, values: {profitQty:  qty - bookQty}}]);
          }
        }
      },

    }
  }
</script>

<style lang="less" scoped>
  .ant-row.ant-form-item {
    margin-bottom: 12px;
  }
</style>
