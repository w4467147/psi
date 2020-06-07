<template>
  <a-drawer
    :title="title"
    :width="width"
    placement="right"
    :closable="readOnly"
    @close="close"
    :visible="visible">
  
    <a-spin :spinning="confirmLoading">
      <a-form :form="form">

        <a-form-item label="账号" :labelCol="labelCol" :wrapperCol="wrapperCol">
          <a-input :readOnly="readOnly" v-decorator="[ 'accountNo', validatorRules.accountNo]" placeholder="请输入账号"></a-input>
        </a-form-item>
        <a-form-item label="账户名称" :labelCol="labelCol" :wrapperCol="wrapperCol">
          <a-input :readOnly="readOnly" v-decorator="[ 'name', validatorRules.name]" placeholder="请输入账户名称"></a-input>
        </a-form-item>
        <a-form-item label="币种" :labelCol="labelCol" :wrapperCol="wrapperCol">
          <j-dict-select-tag :disabled="readOnly" type="list" v-decorator="['currency', validatorRules.currency]" :trigger-change="true" dictCode="bas_currency,name,code" placeholder="请选择币种"/>
        </a-form-item>
        <a-form-item label="初始余额" :labelCol="labelCol" :wrapperCol="wrapperCol">
          <a-input-number :disabled="readOnly" v-decorator="[ 'initBal', validatorRules.initBal]" placeholder="请输入初始余额" style="width: 100%"/>
        </a-form-item>
        <a-form-item label="行号" :labelCol="labelCol" :wrapperCol="wrapperCol">
          <a-input :readOnly="readOnly" v-decorator="[ 'bankNo', validatorRules.bankNo]" placeholder="请输入行号"></a-input>
        </a-form-item>
        <a-form-item label="银行地址" :labelCol="labelCol" :wrapperCol="wrapperCol">
          <a-input :readOnly="readOnly" v-decorator="[ 'bankAddress', validatorRules.bankAddress]" placeholder="请输入银行地址"></a-input>
        </a-form-item>
        <a-form-item label="账户管理员" :labelCol="labelCol" :wrapperCol="wrapperCol">
          <j-dict-select-tag :disabled="readOnly" type="list" v-decorator="['manager', validatorRules.manager]" :trigger-change="true" dictCode="sys_user,realname,username" placeholder="请选择账户管理员"/>
        </a-form-item>
        <a-form-item label="备注" :labelCol="labelCol" :wrapperCol="wrapperCol">
          <a-input :disabled="readOnly" v-decorator="[ 'note']" ></a-input>
        </a-form-item>
        <a-form-item label="附件" :labelCol="labelCol" :wrapperCol="wrapperCol">
          <j-upload :disabled="readOnly" v-decorator="['attachment', validatorRules.attachment]" :trigger-change="true"></j-upload>
        </a-form-item>
        <a-form-item label="是否启用" :labelCol="labelCol" :wrapperCol="wrapperCol">
          <j-dict-select-tag :disabled="readOnly" type="list" v-decorator="['isEnabled', validatorRules.isEnabled]" :trigger-change="true" dictCode="yn" placeholder="请选择是否启用"/>
        </a-form-item>
        <a-form-item label="创建人" :labelCol="labelCol" :wrapperCol="wrapperCol">
          <j-dict-select-tag disabled type="list" v-decorator="['createBy']" :trigger-change="true" dictCode="sys_user,realname,username"/>
        </a-form-item>
        <a-form-item label="创建时间" :labelCol="labelCol" :wrapperCol="wrapperCol">
          <j-date disabled v-decorator="[ 'createTime']" :trigger-change="true" style="width: 100%"/>
        </a-form-item>
        <a-form-item label="修改人" :labelCol="labelCol" :wrapperCol="wrapperCol">
          <j-dict-select-tag disabled type="list" v-decorator="['updateBy']" :trigger-change="true" dictCode="sys_user,realname,username"/>
        </a-form-item>
        <a-form-item label="修改时间" :labelCol="labelCol" :wrapperCol="wrapperCol">
          <j-date disabled v-decorator="[ 'updateTime']" :trigger-change="true" style="width: 100%"/>
        </a-form-item>
        
      </a-form>
    </a-spin>

    <div v-if="!readOnly">
      <a-button type="primary" @click="handleOk">确定</a-button>
      <a-button @click="handleCancel">取消</a-button>
    </div>
  </a-drawer>
</template>

<script>

  import { httpAction } from '@/api/manage'
  import pick from 'lodash.pick'
  import { validateDuplicateValue } from '@/utils/util'
  import JDate from '@/components/jeecg/JDate'  
  import JUpload from '@/components/jeecg/JUpload'
  import JDictSelectTag from "@/components/dict/JDictSelectTag"
  
  export default {
    name: "BasBankAccountModal",
    components: { 
      JDate,
      JUpload,
      JDictSelectTag,
    },
    data () {
      return {
       action: "",
       form: this.$form.createForm(this),
        title:"操作",
        width:600,
        visible: false,
        model: {},
        labelCol: {
          xs: { span: 24 },
          sm: { span: 6 },
        },
        wrapperCol: {
          xs: { span: 24 },
          sm: { span: 17 },
        },
        confirmLoading: false,
        validatorRules: {
          accountNo: {rules: [
            {required: true, message: '请输入账号!'},
          ]},
          name: {rules: [
          ]},
          currency: {rules: [
            {required: true, message: '请输入币种!'},
          ]},
          initBal: {rules: [
            {required: true, message: '请输入初始余额!'},
          ]},
          bankNo: {rules: [
          ]},
          bankAddress: {rules: [
          ]},
          manager: {rules: [
          ]},
          note: {rules: [
          ]},
          attachment: {rules: [
          ]},
          isEnabled: {rules: [
            {required: true, message: '请输入是否启用!'},
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
          add: "/bas/basBankAccount/add",
          edit: "/bas/basBankAccount/edit",
        }
      }
    },

    computed: {
      readOnly: function() {
        return this.action !== "add" && this.action !== "edit"
      }
    },

    created () {
    },
    methods: {
      add () {
        this.edit({});
      },
      edit (record) {
        this.form.resetFields();
        this.model = Object.assign({}, record);
        this.visible = true;
        this.$nextTick(() => {
          this.form.setFieldsValue(pick(this.model,'accountNo','name','currency','initBal','bankNo','bankAddress','manager','note','attachment','isEnabled','createBy','createTime','updateBy','updateTime'))
        })
      },
      close () {
        this.$emit('close');
        this.visible = false;
      },
      handleOk () {
        const that = this;
        // 触发表单验证
        this.form.validateFields((err, values) => {
          if (!err) {
            that.confirmLoading = true;
            let httpurl = '';
            let method = '';
            if(!this.model.id){
              httpurl+=this.url.add;
              method = 'post';
            }else{
              httpurl+=this.url.edit;
               method = 'put';
            }
            let formData = Object.assign(this.model, values);
            console.log("表单提交数据",formData)
            httpAction(httpurl,formData,method).then((res)=>{
              if(res.success){
                that.$message.success(res.message);
                that.$emit('ok');
              }else{
                that.$message.warning(res.message);
              }
            }).finally(() => {
              that.confirmLoading = false;
              that.close();
            })
          }
         
        })
      },
      handleCancel () {
        this.close()
      },
      popupCallback(row){
        this.form.setFieldsValue(pick(row,'accountNo','name','currency','initBal','bankNo','bankAddress','manager','note','attachment','isEnabled','createBy','createTime','updateBy','updateTime'))
      }
      
    }
  }
</script>

<style lang="less" scoped>
/** Button按钮间距 */
  .ant-btn {
    margin-left: 30px;
    margin-bottom: 30px;
    float: right;
  }

.ant-row.ant-form-item {
  margin-bottom: 12px;
}
</style>