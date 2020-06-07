<template>
  <j-modal
    :title="'采购应付 - ' + title"
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
      <a-button v-if="!readOnly" key="save"   @click="" type="primary" :loading="confirmLoading">保存</a-button>
      <a-button v-if="!readOnly" key="submit" @click="" type="primary" :loading="confirmLoading">提交</a-button>
      <a-button v-if="action==='detail'"  key="close"  @click="handleCancel" type="primary">关闭</a-button>
    </template>

    <a-spin :spinning="confirmLoading">
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
              <a-input-number  :disabled="readOnly" v-decorator="['amt', validatorRules.amt]" style="width: 100%"/>
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
    </a-spin>
  </j-modal>
</template>

<script>

  import pick from 'lodash.pick'
  import JDate from '@/components/jeecg/JDate'
  import JUpload from '@/components/jeecg/JUpload'
  import JDictSelectTag from "@/components/dict/JDictSelectTag"

  export default {
    name: "PurPayableModal",
    components: {
      JDate,
      JUpload,
      JDictSelectTag,
    },
    data () {
      return {
        action: "",
        title:"操作",
        width: '1200px',
        visible: false,
        moreStatus: false,
        form: this.$form.createForm(this),
        model: {},

        spans: {
          labelCol1: { span: 2 },
          wrapperCol1: { span: 22 },
          labelCol2: { span: 4 },
          wrapperCol2: { span: 20 },
          labelCol3: { span: 6 },
          wrapperCol3: { span: 18 },
          labelCol6: { span: 12 },
          wrapperCol6: { span: 12 }
        },

        confirmLoading: false,
        validatorRules: {
          sourceType: {rules: []},
          sourceId: {rules: []},
          sourceNo:  {rules: []},
          isAuto: {rules: []},
          billNo: {rules: [
              {required: true, message: '请输入单据编号!'},
            ]},
          billDate: {rules: [
              {required: true, message: '请输入单据日期!'},
            ]},
          supplierId: {rules: [
              {required: true, message: '请输入供应商!'},
            ]},
          isRubric: {rules: []},
          amt: {rules: [
              {required: true, message: '请输入金额!'},
            ]},
          checkedAmt:  {rules: []},
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
        url: {
          add: "/finance/finPayable/add",
          edit: "/finance/finPayable/edit",
          approve: "/finance/finPayable/approve",
        }
      }
    },

    computed: {
      readOnly: function() {
        return this.action !== "add" && this.action !== "edit"
      }
    },

    methods: {
      edit (record) {
        this.form.resetFields();
        this.model = Object.assign({}, record);
        this.visible = true;
        this.$nextTick(() => {
          this.form.setFieldsValue(pick(this.model,'sourceType','sourceNo','sourceId','billNo','billDate','supplierId','isRubric','amt','checkedAmt','attachment','remark','billProcStatus','approverId','flowId','isApproved','effectiveTime','isVoided','isClosed','sysOrgCode','createBy','createTime','updateBy','updateTime'))
        })
      },
      close () {
        this.$emit('close');
        this.visible = false;
      },
      popupCallback(row){
        this.form.setFieldsValue(pick(row,'sourceType','sourceNo','sourceId','billNo','billDate','supplierId','isRubric','amt','checkedAmt','attachment','remark','billProcStatus','approverId','flowId','isApproved','effectiveTime','isVoided','isClosed','sysOrgCode','createBy','createTime','updateBy','updateTime'))
      },

      handleCancel () {
        this.close()
      },

    }
  }
</script>

<style lang="less" scoped>
  .ant-row.ant-form-item {
    margin-bottom: 12px;
  }
</style>
