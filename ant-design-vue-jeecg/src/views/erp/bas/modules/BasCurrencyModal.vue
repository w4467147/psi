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
        <a-form-item label="代码" :labelCol="labelCol" :wrapperCol="wrapperCol">
          <a-input :readOnly="action!=='add'" v-decorator="[ 'code', validatorRules.code]" placeholder="请输入代码"></a-input>
        </a-form-item>
        <a-form-item label="名称" :labelCol="labelCol" :wrapperCol="wrapperCol">
          <a-input :readOnly="readOnly" v-decorator="[ 'name', validatorRules.name]" placeholder="请输入名称"></a-input>
        </a-form-item>
        <a-form-item label="是否本币" :labelCol="labelCol" :wrapperCol="wrapperCol">
          <j-dict-select-tag :disabled="readOnly" type="list" v-decorator="['isFunctional', validatorRules.isFunctional]" :trigger-change="true" dictCode="yn" placeholder="请选择是否本币"/>
        </a-form-item>
        <a-form-item v-show="false" label="汇率" :labelCol="labelCol" :wrapperCol="wrapperCol">
          <a-input-number :disabled="readOnly" v-decorator="[ 'exchangeRate', validatorRules.exchangeRate]" style="width: 100%"/>
        </a-form-item>
        <a-form-item label="是否启用" :labelCol="labelCol" :wrapperCol="wrapperCol">
          <j-dict-select-tag :disabled="readOnly" type="list" v-decorator="['isEnabled', validatorRules.isEnabled]" :trigger-change="true" dictCode="yn" placeholder="请选择是否启用"/>
        </a-form-item>
        <a-form-item label="创建人" :labelCol="labelCol" :wrapperCol="wrapperCol">
          <j-dict-select-tag disabled type="list" v-decorator="['createBy']" :trigger-change="true" dictCode="sys_user,realname,username" />
        </a-form-item>
        <a-form-item label="创建时间" :labelCol="labelCol" :wrapperCol="wrapperCol">
          <j-date disabled v-decorator="[ 'createTime']" :trigger-change="true" style="width: 100%"/>
        </a-form-item>
        <a-form-item label="修改人" :labelCol="labelCol" :wrapperCol="wrapperCol">
          <j-dict-select-tag disabled type="list" v-decorator="['updateBy']" :trigger-change="true" dictCode="sys_user,realname,username" />
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
  import JDictSelectTag from "@/components/dict/JDictSelectTag"
  
  export default {
    name: "BasCurrencyModal",
    components: { 
      JDate,
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
          code: {rules: [
            {required: true, message: '请输入代码!'},
          ]},
          name: {rules: [
            {required: true, message: '请输入名称!'},
          ]},
          isFunctional: {rules: [
            {required: true, message: '请输入是否本币!'},
          ]},
          exchangeRate: {rules: [
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
          add: "/bas/basCurrency/add",
          edit: "/bas/basCurrency/edit",
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
          this.form.setFieldsValue(pick(this.model,'code','name','isFunctional','exchangeRate','isEnabled','createBy','createTime','updateBy','updateTime'))
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
        this.form.setFieldsValue(pick(row,'code','name','isFunctional','exchangeRate','isEnabled','createBy','createTime','updateBy','updateTime'))
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