<template>
  <j-modal
    :title="'应收核销 - ' + title"
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
      <a-button v-if="!readOnly" :disabled="totalAmt1!==totalAmt2" key="submit" @click="handleSubmit" type="primary" :loading="confirmLoading">提交</a-button>
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
        </a-row>
        <a-row>
          <a-tooltip :title="!readOnly && entryCount1+entryCount2>0 ? '有核销项时不能改变客户！':''" placement="bottom">
            <a-col :span="8">
              <a-form-item label="客户" :labelCol="spans.labelCol3" :wrapperCol="spans.wrapperCol3">
                  <j-dict-select-tag :disabled="readOnly || entryCount1+entryCount2>0" type="list"  @change="onCustomerChange"
                                     v-decorator="['customerId', validatorRules.customerId]" :trigger-change="true" dictCode="bas_customer,name,id"/>
              </a-form-item>
            </a-col>
            </a-tooltip>
          <a-col :span="16">
            <a-form-item label="备注" :labelCol="spans.labelCol" :wrapperCol="spans.wrapperCol">
              <a-textarea :readOnly="readOnly" v-decorator="[ 'remark', validatorRules.remark]" :rows="1" autoSize></a-textarea>
            </a-form-item>
          </a-col>
        </a-row>
      </a-form>

      <!-- 子表区域 -->
      <a-divider style="margin:6px 0 6px 0;"></a-divider>
      <split-pane v-if="!readOnly" :min-percent='35' :default-percent='50' split="vertical"
                  :style="'width:100%; height:' + splitPaneHeight + 'px'">
        <template slot="paneL">
          <a-row>
            <a-col span="20">
              <br>
              <rpCheckReceivable-List ref="rpCheckReceivableList"
                                   @selectChange="onReceivableSelectChange"
                                   @dataSourceChange="onReceivableDataSourceChange"
                                   :style="'height:'+ReceivableHeight+'px'"/>
            </a-col>
            <a-col span="4">
              <br><br><br>
              <a-button :disabled="selectedReceivableCount===0" type="link" @click="handleEntryList1Add" icon="right">添加</a-button>
              <br><br>
              <a-button :disabled="selectedEntryCount1===0" type="link" @click="handleEntryList1Remove" icon="left">移除</a-button>
            </a-col>
          </a-row>
          <a-row>
            <a-col span="20">
              <br style="line-height: 50%">
              <rpCheckReceipt-list ref="rpCheckReceiptList"
                                   @selectChange="onReceiptSelectChange"
                                   @dataSourceChange="onReceiptDataSourceChange"/>
            </a-col>
            <a-col span="3">
              <br><br><br>
              <a-button :disabled="selectedReceiptCount===0" type="link" @click="handleEntryList2Add" icon="right">添加</a-button>
              <br><br>
              <a-button :disabled="selectedEntryCount2===0" type="link" @click="handleEntryList2Remove" icon="left">移除</a-button>
            </a-col>
          </a-row>
        </template>
        <template slot="paneR">
          <a-icon type="column-width" />
          <rpCheckEntry-list ref="rpCheckEntryList1"
                             checkType="101"
                             checkSide="1"
                             :readOnly="readOnly"
                             @totalAmtChange="totalAmt => { this.totalAmt1 = totalAmt; }"
                             @selectChange="onEntryList1SelectChange"
                             @dataSourceChange="onEntryList1DataSourceChange"
                             :style="'height:'+ReceivableHeight+'px'"/>
          <br style="line-height: 50%">
          <rpCheckEntry-list ref="rpCheckEntryList2"
                             checkType="101"
                             checkSide="2"
                             :readOnly="readOnly"
                             @totalAmtChange="totalAmt => { this.totalAmt2 = totalAmt; }"
                             @selectChange="onEntryList2SelectChange"
                             @dataSourceChange="onEntryList2DataSourceChange"/>
          <a-alert v-if="totalAmt1!==totalAmt2" message="双方核销金额合计不相等！" type="warning" banner />
        </template>
      </split-pane>
      <template v-else>
        <rpCheckEntry-list ref="rpCheckEntryList1"
                           checkType="101"
                           checkSide="1"
                           :readOnly="readOnly"
                           @totalAmtChange="totalAmt => { this.totalAmt1 = totalAmt; }"
                           @selectChange="onEntryList1SelectChange"
                           @dataSourceChange="onEntryList1DataSourceChange"/>
        <br style="line-height: 50%">
        <rpCheckEntry-list ref="rpCheckEntryList2"
                           checkType="101"
                           checkSide="2"
                           :readOnly="readOnly"
                           @totalAmtChange="totalAmt => { this.totalAmt2 = totalAmt; }"
                           @selectChange="onEntryList2SelectChange"
                           @dataSourceChange="onEntryList2DataSourceChange"/>
        <a-alert v-if="totalAmt1!==totalAmt2" message="双方核销金额合计不相等！" type="warning" banner />
      </template>
    </a-spin>
  </j-modal>
</template>

<script>
  import pick from 'lodash.pick'
  import JDate from '@/components/jeecg/JDate'
  import JDictSelectTag from "@/components/dict/JDictSelectTag"
  import { getAction, putAction, httpAction } from '@api/manage'
  import splitPane from 'vue-splitpane';
  import { getFormatDate } from "../../utils/util"
  import RpCheckEntryList from "./RpCheck/RpCheckEntryList";
  import RpCheckReceivableList from "./RpCheck/RpCheckReceivableList";
  import RpCheckReceiptList from "./RpCheck/RpCheckReceiptList";

  export default {
    name: 'ReceivableCheckModal',
    mixins: [],
    components: {
      JDate,
      JDictSelectTag,
      RpCheckReceivableList,
      RpCheckReceiptList,
      RpCheckEntryList,
      splitPane
    },

    data() {
      return {
        action: "",
        title: '操作',
        width: '1200px',
        visible: false,
        form: this.$form.createForm(this),
        confirmLoading: false,
        model: {},

        moreStatus: false,
        spans: {
          labelCol: { span: 3 },
          wrapperCol: { span: 21 },
          labelCol1: { span: 2 },
          wrapperCol1: { span: 22 },
          labelCol2: { span: 4 },
          wrapperCol2: { span: 20 },
          labelCol3: { span: 6 },
          wrapperCol3: { span: 18 },
          labelCol6: { span: 12 },
          wrapperCol6: { span: 12 }
        },

        validatorRules: {
          billNo: {rules: [{required: true, message: '请输入单据编号!'}]},
          billDate: {rules: [{required: true, message: '请输入单据日期!'}]},
          receivableCheckType: {rules: []},
          customerId: {rules: []},
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

        totalAmt1:0,
        entryCount1: 0,
        ReceivableCount: 0,
        selectedEntryCount1: 0,
        selectedReceivableCount: 0,
        totalAmt2:0,
        entryCount2: 0,
        paymentCount: 0,
        selectedEntryCount2: 0,
        selectedReceiptCount: 0,

        url: {
          add: "/finance/finReceivableCheck/add",
          edit: "/finance/finReceivableCheck/edit",
          approve: "/finance/finReceivableCheck/approve",
          finRpCheckEntry: {
            list: '/finance/finReceivableCheck/queryFinReceivableCheckEntryByMainId'
          },
        }
      }
    },

    computed: {
      readOnly: function() {
        return this.action !== "add" && this.action !== "edit"
      },
      /**
       * @return {number}
       */
      ReceivableHeight: function () {
        let a = this.ReceivableCount === 0 ? 4.5:this.ReceivableCount,
            b = this.entryCount1 === 0 ? 4.5:this.entryCount1;
        return (a > b ? a : b) * 38 + 150;
      },
      splitPaneHeight: function () {
        let a = this.paymentCount === 0 ? 4.5:this.paymentCount,
          b = this.entryCount2 === 0 ? 4.5:this.entryCount2;
        return this.ReceivableHeight + (a > b ? a : b) * 38 + 180;
      },
    },

    methods: {
      addInit() {
        this.model = {};
        //应收核销类型：收款核应收
        this.model.receivableCheckType = '101';
        //处理状态：编辑中
        this.model.billProcStatus = '12';

        // 请求后台的填值规则接口地址
        const url = '/sys/fillRule/executeRuleByCode/'
        const ruleCode = 'receivable_check_bill_no'
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

      /** 列表点击新增按钮时调用此方法 */
      add() {
        this.addInit();
        this.edit(this.model);
      },

      resetModal() {
        // reset modal
        this.entryCount1 = 0;
        this.selectedEntryCount1= 0;
        this.selectedReceivableCount = 0;
        this.entryCount2 = 0;
        this.selectedEntryCount2 = 0;
        this.selectedReceiptCount = 0;
        this.form.resetFields();
        this.$nextTick(() => {
          this.$refs.rpCheckEntryList1.resetTable();
          this.$refs.rpCheckEntryList2.resetTable();
          if (!this.readOnly) {
            this.$refs.rpCheckReceivableList.resetTable();
            this.$refs.rpCheckReceiptList.resetTable();
          }
        });
      },

      /** 列表点击了编辑（修改）按钮时调用此方法 */
      edit(record) {
        this.resetModal();

        this.model = Object.assign({}, record);
        this.visible = true;
        this.$nextTick(() => {
          this.form.setFieldsValue(pick(this.model,'billNo','billDate','customerId','remark','billProcStatus','isApproved','isClosed','isVoided','effectiveTime','approverId','flowId','createTime','createBy','sysOrgCode','updateTime','updateBy'))
        })

        // 加载子表数据
        this.$nextTick(() => {
          if (this.model.id) {
            queryCheckEntry(this);
            this.onCustomerChange(this.model.customerId);
          }
        });

        /** 查询数据 */
        function queryCheckEntry(that) {
          let url = that.url.finRpCheckEntry.list;
          let params = { id: that.model.id };
          that.$refs.rpCheckEntryList1.loading = true;
          that.$refs.rpCheckEntryList2.loading = true;
          getAction(url, params).then(res => {
            let rows1 = [], rows2 = [];
            for (let row of res.result || []) {
              if (row.checkSide === "1")
                rows1.push(row)
              else
                rows2.push(row);
            }
            that.$refs.rpCheckEntryList1.dataSource = rows1;
            that.$refs.rpCheckEntryList2.dataSource = rows2;
          }).finally(() => {
            that.$refs.rpCheckEntryList1.loading = false;
            that.$refs.rpCheckEntryList2.loading = false;
          });
        }
      },

      onCustomerChange(val){
        if (!this.readOnly && val) {
          let params = {customerId: val};
          this.$refs.rpCheckReceivableList.queryParam = params;
          this.$refs.rpCheckReceivableList.loadData(1);
          this.$refs.rpCheckReceiptList.queryParam = params;
          this.$refs.rpCheckReceiptList.loadData(1);
        }
      },

      onReceivableDataSourceChange() {
        this.ReceivableCount = this.$refs.rpCheckReceivableList.dataSource.length;
        this.makeAdded(this.$refs.rpCheckReceivableList, this.$refs.rpCheckEntryList1);
      },

      //注意：
      // rpCheckReceivableList与rpCheckReceiptList的loadData(),由于其中getAction是异步执行，
      // 所以如果在其后调用本函数将无效（此时rpCheckReceivableList.dataSource还是空的）。
      makeAdded(fromComponent, toComponent) {
        let rows = [];
        let change = false;
        for (let fromRecord of fromComponent.dataSource) {
          let added = false;
          for (let toRecord of toComponent.dataSource) {
            if (fromRecord.id === toRecord.sourceId) {
              added = true;
              if (fromRecord.added !== "是") {
                fromRecord.added = "是";
                change = true;
              }
              break;
            }
          }
          // 以前是added，但现在不是
          if (!added && fromRecord.added === "是") {
            fromRecord.added = "";
            change = true;
          }
          rows.push(fromRecord);
        }
        if (change) {
          //避免循环触发dataSourceChange
          fromComponent.disableDataSourceChange = true;
          fromComponent.dataSource = rows;
        }
      },

      onReceivableSelectChange(){
        let count = 0;
        for (let row of  this.$refs.rpCheckReceivableList.selectionRows) {
          if (row.added !== "是") count++;
        }
        this.selectedReceivableCount = count;
      },

      onEntryList1SelectChange() {
        this.selectedEntryCount1 = this.$refs.rpCheckEntryList1.selectedRowKeys.length;
      },

      onEntryList1DataSourceChange(){
        this.entryCount1 = this.$refs.rpCheckEntryList1.dataSource.length;
      },

      onReceiptDataSourceChange() {
        this.paymentCount = this.$refs.rpCheckReceiptList.dataSource.length;
        this.makeAdded(this.$refs.rpCheckReceiptList, this.$refs.rpCheckEntryList2);
      },

      onReceiptSelectChange(){
        let count = 0;
        for (let row of this.$refs.rpCheckReceiptList.selectionRows) {
          if (row.added !== "是") count++;
        }
        this.selectedReceiptCount = count;
      },

      onEntryList2SelectChange() {
        this.selectedEntryCount2 = this.$refs.rpCheckEntryList2.selectedRowKeys.length;
      },

      onEntryList2DataSourceChange(){
        this.entryCount2 = this.$refs.rpCheckEntryList2.dataSource.length;
      },

      handleEntryList1Add() {
        let maxEntryNo = 100;
        for(let row of this.$refs.rpCheckEntryList1.dataSource) {
          if (maxEntryNo < row.entryNo)  maxEntryNo = row.entryNo;
        }

        let rows = [];
        for (let row of this.$refs.rpCheckReceivableList.selectionRows) {
          if (row.added !== "是") {
            rows.push({
              entryNo: ++maxEntryNo,
              checkSide: "1",
              sourceType: "fin_receivable",
              sourceId: row.id,
              sourceNo: row.billNo,
              uncheckedAmt: row.uncheckedAmt,
              amt: row.uncheckedAmt
            });
          }
        }
        this.$refs.rpCheckEntryList1.dataSource.push(...rows);
        this.selectedReceivableCount = 0;
        this.$refs.rpCheckReceivableList.selectedRowKeys = [];
        this.$refs.rpCheckReceivableList.selectionRows = [];
        this.makeAdded(this.$refs.rpCheckReceivableList, this.$refs.rpCheckEntryList1);
      },

      handleEntryList1Remove() {
        if (this.$refs.rpCheckEntryList1.selectionRows === 0) return;

        let rows = [];
        for (let row of this.$refs.rpCheckEntryList1.dataSource) {
          let removedRow = {sourceId:""};
          for (removedRow of this.$refs.rpCheckEntryList1.selectionRows) {
            //移除的
            if (row.sourceId === removedRow.sourceId) break;
          }
          //不移除的
          if (row.sourceId !== removedRow.sourceId) rows.push(row);
        }
        this.$refs.rpCheckEntryList1.dataSource = rows;
        this.selectedEntryCount1 = 0;
        this.$refs.rpCheckEntryList1.selectedRowKeys = [];
        this.$refs.rpCheckEntryList1.selectionRows = [];
        this.makeAdded(this.$refs.rpCheckReceivableList, this.$refs.rpCheckEntryList1);
      },

      handleEntryList2Add() {
        let maxEntryNo = 200;
        for(let row of this.$refs.rpCheckEntryList2.dataSource) {
          if (maxEntryNo < row.entryNo)  maxEntryNo = row.entryNo;
        }

        let rows = [];
        for (let row of this.$refs.rpCheckReceiptList.selectionRows) {
          if (row.added !== "是") {
            rows.push({
              entryNo: ++maxEntryNo,
              checkSide: "2",
              sourceType: "fin_receipt..102",
              sourceId: row.id,
              sourceNo: row.billNo,
              uncheckedAmt: row.uncheckedAmt,
              amt: row.uncheckedAmt
            });
          }
        }
        this.$refs.rpCheckEntryList2.dataSource.push(...rows);
        this.selectedReceiptCount = 0;
        this.$refs.rpCheckReceiptList.selectedRowKeys = [];
        this.$refs.rpCheckReceiptList.selectionRows = [];
        this.makeAdded(this.$refs.rpCheckReceiptList, this.$refs.rpCheckEntryList2);
      },

      handleEntryList2Remove() {
        if (this.$refs.rpCheckEntryList2.selectionRows === 0) return;

        let rows = [];
        for (let row of this.$refs.rpCheckEntryList2.dataSource) {
          let removedRow = {sourceId:""};
          for (removedRow of this.$refs.rpCheckEntryList2.selectionRows) {
            //移除的
            if (row.sourceId === removedRow.sourceId) break;
          }
          //不移除的
          if (row.sourceId !== removedRow.sourceId) rows.push(row);
        }
        this.$refs.rpCheckEntryList2.dataSource = rows;
        this.selectedEntryCount2 = 0;
        this.$refs.rpCheckEntryList2.selectedRowKeys = [];
        this.$refs.rpCheckEntryList2.selectionRows = [];
        this.makeAdded(this.$refs.rpCheckReceiptList, this.$refs.rpCheckEntryList2);
      },

      /** 关闭弹窗，并将所有JEditableTable实例回归到初始状态 */
      close() {
        this.visible = false
        this.$emit('close')
      },

      handleOk () {
        // 触发表单验证
        this.form.validateFields((err, values) => {
          if (!err) {
            let formData = this.classifyIntoFormData(values);
            return this.request(formData, false)
          }
        })
      },

      /** 整理成formData */
      classifyIntoFormData(formValue) {
        let main = Object.assign(this.model, formValue)
        return {
          ...main, // 展开
          finReceivableCheckEntryList: this.$refs.rpCheckEntryList1.dataSource.concat(this.$refs.rpCheckEntryList2.dataSource),
        }
      },

      /** 发起请求，自动判断是执行新增还是修改操作 */
      request(formData, isSubmit) {
        let url = this.url.add, method = 'post'
        if (this.model.id) {
          url = this.url.edit
          method = 'put'
        }

        this.confirmLoading = true;
        httpAction(url, formData, method).then((res) => {
          if (res.success) {
            this.$message.success(res.message)
            this.$emit('ok')
            this.close()
          } else {
            this.$message.warning(res.message)
          }
        }).catch(e => {
           if (isSubmit)  this.form.setFieldsValue({billProcStatus:'12'});
        }).finally(() => {
          this.confirmLoading = false
        })
      },


      handleCancel () {
        this.close()
      },
      handleSave() {
        this.handleOk()
      },

      handleSubmit() {
        //处理状态=编辑完成
        this.form.setFieldsValue({billProcStatus:'13'})

        //出错时要恢复billProcStatus为"12"，所以下面未直接调用handleSave()！
        // 触发表单验证
        this.form.validateFields((err, values) => {
          if (!err) {
            let formData = this.classifyIntoFormData(values);
            return this.request(formData, true)
          }
        })
      },

      handleApproved() {
        const that = this;
        putAction(that.url.approve, {id: that.model.id}).then((res) => {
          if (res.success) {
            that.$message.success(res.message);
            that.$emit('ok')
            that.close()
          } else {
            that.$message.warning(res.message);
          }
        })
      },

      popupCallback(row){
        this.form.setFieldsValue(pick(row,'billNo','billDate','customerId','remark','billProcStatus','isApproved','isClosed','isVoided','effectiveTime','approverId','flowId','createTime','createBy','sysOrgCode','updateTime','updateBy'))
      },

    }
  }
</script>

<style lang="less" scoped>
  .ant-row.ant-form-item {
    margin-bottom: 12px;
  }

</style>
