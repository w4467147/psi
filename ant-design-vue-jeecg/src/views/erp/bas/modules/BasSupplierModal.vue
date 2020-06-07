<template>
  <j-modal
    :title="'供应商 - ' + title"
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
      <a-button v-if="!readOnly" key="save"   @click="handleOk" type="primary" :loading="confirmLoading">保存</a-button>
      <a-button v-if="action==='detail'"  key="close"  @click="handleCancel" type="primary">关闭</a-button>
    </template>

    <a-spin :spinning="confirmLoading">
      <a-form :form="form">
        <a-row>
          <a-col :span="12">
            <a-form-item label="编码" :labelCol="labelCol" :wrapperCol="wrapperCol">
              <a-input v-decorator="[ 'code', validatorRules.code]" placeholder="请输入编码"></a-input>
            </a-form-item>
          </a-col>
          <a-col :span="12">
            <a-form-item label="名称" :labelCol="labelCol" :wrapperCol="wrapperCol">
              <a-input v-decorator="[ 'name', validatorRules.name]" placeholder="请输入名称"></a-input>
            </a-form-item>
          </a-col>
          <a-col :span="12">
            <a-form-item label="简称" :labelCol="labelCol" :wrapperCol="wrapperCol">
              <a-input v-decorator="[ 'shortName', validatorRules.shortName]" placeholder="请输入简称"></a-input>
            </a-form-item>
          </a-col>
          <a-col :span="12">
            <a-form-item label="等级" :labelCol="labelCol" :wrapperCol="wrapperCol">
              <j-dict-select-tag type="list" v-decorator="['supplierLevel', validatorRules.supplierLevel]" :trigger-change="true" dictCode="x_supplier_level" placeholder="请选择等级"/>
            </a-form-item>
          </a-col>
          <a-col :span="12">
            <a-form-item label="纳税规模" :labelCol="labelCol" :wrapperCol="wrapperCol">
              <j-dict-select-tag type="list" v-decorator="['taxScale', validatorRules.taxScale]" :trigger-change="true" dictCode="x_tax_scale" placeholder="请选择纳税规模"/>
            </a-form-item>
          </a-col>
          <a-col :span="12">
            <a-form-item label="所属总公司" :labelCol="labelCol" :wrapperCol="wrapperCol">
              <a-input v-decorator="[ 'headquarters', validatorRules.headquarters]" placeholder="请输入所属总公司"></a-input>
            </a-form-item>
          </a-col>
          <a-col :span="12">
            <a-form-item label="所属地区" :labelCol="labelCol" :wrapperCol="wrapperCol">
              <a-input v-decorator="[ 'area', validatorRules.area]" placeholder="请输入所属地区"></a-input>
            </a-form-item>
          </a-col>
          <a-col :span="12">
            <a-form-item label="业务地域" :labelCol="labelCol" :wrapperCol="wrapperCol">
              <a-input v-decorator="[ 'bizArea', validatorRules.bizArea]" placeholder="请输入业务地域"></a-input>
            </a-form-item>
          </a-col>
          <a-col :span="12">
            <a-form-item label="备选供应商" :labelCol="labelCol" :wrapperCol="wrapperCol">
              <a-input v-decorator="[ 'alterSupplier', validatorRules.alterSupplier]" placeholder="请输入备选供应商"></a-input>
            </a-form-item>
          </a-col>
          <a-col :span="12">
            <a-form-item label="网站" :labelCol="labelCol" :wrapperCol="wrapperCol">
              <a-input v-decorator="[ 'website', validatorRules.website]" placeholder="请输入网站"></a-input>
            </a-form-item>
          </a-col>
          <a-col :span="12">
            <a-form-item label="法人代表" :labelCol="labelCol" :wrapperCol="wrapperCol">
              <a-input v-decorator="[ 'corporate', validatorRules.corporate]" placeholder="请输入法人代表"></a-input>
            </a-form-item>
          </a-col>
          <a-col :span="12">
            <a-form-item label="法人电话" :labelCol="labelCol" :wrapperCol="wrapperCol">
              <a-input v-decorator="[ 'corporatePhone', validatorRules.corporatePhone]" placeholder="请输入法人电话"></a-input>
            </a-form-item>
          </a-col>
          <a-col :span="12">
            <a-form-item label="供应商地址" :labelCol="labelCol" :wrapperCol="wrapperCol">
              <a-input v-decorator="[ 'address', validatorRules.address]" placeholder="请输入供应商地址"></a-input>
            </a-form-item>
          </a-col>
          <a-col :span="12">
            <a-form-item label="财务信息联系人" :labelCol="labelCol" :wrapperCol="wrapperCol">
              <a-input v-decorator="[ 'contactsFinancial', validatorRules.contactsFinancial]" placeholder="请输入财务信息联系人"></a-input>
            </a-form-item>
          </a-col>
          <a-col :span="12">
            <a-form-item label="财务信息联系电话" :labelCol="labelCol" :wrapperCol="wrapperCol">
              <a-input v-decorator="[ 'phoneFinancial', validatorRules.phoneFinancial]" placeholder="请输入财务信息联系电话"></a-input>
            </a-form-item>
          </a-col>
          <a-col :span="12">
            <a-form-item label="开票信息单位名称" :labelCol="labelCol" :wrapperCol="wrapperCol">
              <a-input v-decorator="[ 'unitInvoice', validatorRules.unitInvoice]" placeholder="请输入开票信息单位名称"></a-input>
            </a-form-item>
          </a-col>
          <a-col :span="12">
            <a-form-item label="开票信息开户行" :labelCol="labelCol" :wrapperCol="wrapperCol">
              <a-input v-decorator="[ 'bankInvoice', validatorRules.bankInvoice]" placeholder="请输入开票信息开户行"></a-input>
            </a-form-item>
          </a-col>
          <a-col :span="12">
            <a-form-item label="开票信息行号" :labelCol="labelCol" :wrapperCol="wrapperCol">
              <a-input v-decorator="[ 'bankidInvoice', validatorRules.bankidInvoice]" placeholder="请输入开票信息行号"></a-input>
            </a-form-item>
          </a-col>
          <a-col :span="12">
            <a-form-item label="开票信息税号" :labelCol="labelCol" :wrapperCol="wrapperCol">
              <a-input v-decorator="[ 'taxInvoice', validatorRules.taxInvoice]" placeholder="请输入开票信息税号"></a-input>
            </a-form-item>
          </a-col>
          <a-col :span="12">
            <a-form-item label="开票信息联系电话" :labelCol="labelCol" :wrapperCol="wrapperCol">
              <a-input v-decorator="[ 'phoneInvoice', validatorRules.phoneInvoice]" placeholder="请输入开票信息联系电话"></a-input>
            </a-form-item>
          </a-col>
          <a-col :span="12">
            <a-form-item label="开票信息账号" :labelCol="labelCol" :wrapperCol="wrapperCol">
              <a-input v-decorator="[ 'accountInvoice', validatorRules.accountInvoice]" placeholder="请输入开票信息账号"></a-input>
            </a-form-item>
          </a-col>
          <a-col :span="12">
            <a-form-item label="开票地址" :labelCol="labelCol" :wrapperCol="wrapperCol">
              <a-input v-decorator="[ 'addressInvoice', validatorRules.addressInvoice]" placeholder="请输入开票地址"></a-input>
            </a-form-item>
          </a-col>
          <a-col :span="12">
            <a-form-item label="办款资料单位名称" :labelCol="labelCol" :wrapperCol="wrapperCol">
              <a-input v-decorator="[ 'unitPayment', validatorRules.unitPayment]" placeholder="请输入办款资料单位名称"></a-input>
            </a-form-item>
          </a-col>
          <a-col :span="12">
            <a-form-item label="办款资料开户行" :labelCol="labelCol" :wrapperCol="wrapperCol">
              <a-input v-decorator="[ 'bankPayment', validatorRules.bankPayment]" placeholder="请输入办款资料开户行"></a-input>
            </a-form-item>
          </a-col>
          <a-col :span="12">
            <a-form-item label="办款资料行号" :labelCol="labelCol" :wrapperCol="wrapperCol">
              <a-input v-decorator="[ 'bankidPayment', validatorRules.bankidPayment]" placeholder="请输入办款资料行号"></a-input>
            </a-form-item>
          </a-col>
          <a-col :span="12">
            <a-form-item label="办款资料账号" :labelCol="labelCol" :wrapperCol="wrapperCol">
              <a-input v-decorator="[ 'accountPayment', validatorRules.accountPayment]" placeholder="请输入办款资料账号"></a-input>
            </a-form-item>
          </a-col>
          <a-col :span="12">
            <a-form-item label="收件信息地址" :labelCol="labelCol" :wrapperCol="wrapperCol">
              <a-input v-decorator="[ 'accountReceipt', validatorRules.accountReceipt]" placeholder="请输入收件信息地址"></a-input>
            </a-form-item>
          </a-col>
          <a-col :span="12">
            <a-form-item label="收件信息邮编" :labelCol="labelCol" :wrapperCol="wrapperCol">
              <a-input v-decorator="[ 'postcodeReceipt', validatorRules.postcodeReceipt]" placeholder="请输入收件信息邮编"></a-input>
            </a-form-item>
          </a-col>
          <a-col :span="12">
            <a-form-item label="收件信息收件人" :labelCol="labelCol" :wrapperCol="wrapperCol">
              <a-input v-decorator="[ 'addressReceipt', validatorRules.addressReceipt]" placeholder="请输入收件信息收件人"></a-input>
            </a-form-item>
          </a-col>
          <a-col :span="12">
            <a-form-item label="收件信息联系电话" :labelCol="labelCol" :wrapperCol="wrapperCol">
              <a-input v-decorator="[ 'phoneReceipt', validatorRules.phoneReceipt]" placeholder="请输入收件信息联系电话"></a-input>
            </a-form-item>
          </a-col>
          <a-col :span="12">
            <a-form-item label="收件信息传真" :labelCol="labelCol" :wrapperCol="wrapperCol">
              <a-input v-decorator="[ 'faxReceipt', validatorRules.faxReceipt]" placeholder="请输入收件信息传真"></a-input>
            </a-form-item>
          </a-col>
          <a-col :span="12">
            <a-form-item label="是否启用" :labelCol="labelCol" :wrapperCol="wrapperCol">
              <a-input-number v-decorator="[ 'isEnabled', validatorRules.isEnabled]" placeholder="请输入是否启用" style="width: 100%"/>
            </a-form-item>
          </a-col>
          <a-col :span="12">
            <a-form-item label="备注" :labelCol="labelCol" :wrapperCol="wrapperCol">
              <a-input v-decorator="[ 'remark', validatorRules.remark]" placeholder="请输入备注"></a-input>
            </a-form-item>
          </a-col>
          <a-col :span="12">
            <a-form-item label="附件" :labelCol="labelCol" :wrapperCol="wrapperCol">
              <j-upload  v-decorator="['attachment', validatorRules.attachment]" :trigger-change="true"></j-upload>
            </a-form-item>
          </a-col>
          <a-col :span="12">
            <a-form-item label="创建人" :labelCol="labelCol" :wrapperCol="wrapperCol">
              <a-input disabled v-decorator="[ 'createBy', validatorRules.createBy]" ></a-input>
            </a-form-item>
          </a-col>
          <a-col :span="12">
            <a-form-item label="创建时间" :labelCol="labelCol" :wrapperCol="wrapperCol">
              <j-date disabled  v-decorator="[ 'createTime', validatorRules.createTime]" :trigger-change="true" style="width: 100%"/>
            </a-form-item>
          </a-col>
          <a-col :span="12">
            <a-form-item label="修改人" :labelCol="labelCol" :wrapperCol="wrapperCol">
              <a-input disabled v-decorator="[ 'updateBy', validatorRules.updateBy]"></a-input>
            </a-form-item>
          </a-col>
          <a-col :span="12">
            <a-form-item label="修改时间" :labelCol="labelCol" :wrapperCol="wrapperCol">
              <j-date disabled v-decorator="[ 'updateTime', validatorRules.updateTime]" :trigger-change="true" style="width: 100%"/>
            </a-form-item>
          </a-col>
        </a-row>
      </a-form>
    </a-spin>
  </j-modal>
</template>

<script>

  import { httpAction } from '@/api/manage'
  import pick from 'lodash.pick'
  import { validateDuplicateValue } from '@/utils/util'
  import JDate from '@/components/jeecg/JDate'
  import JUpload from '@/components/jeecg/JUpload'
  import JDictSelectTag from "@/components/dict/JDictSelectTag"

  export default {
    name: "BasSupplierModal",
    components: { 
      JDate,
      JUpload,
      JDictSelectTag,
    },
    data () {
      return {
        action: '',
        form: this.$form.createForm(this),
        title:"操作",
        width:1100,
        visible: false,
        model: {},
        labelCol: {
          xs: { span: 24 },
          sm: { span: 7 },
        },
        wrapperCol: {
          xs: { span: 24 },
          sm: { span: 16 },
        },
        confirmLoading: false,
        validatorRules: {
          code: {rules: [
            {required: true, message: '请输入编码!'},
          ]},
          name: {rules: [
          ]},
          shortName: {rules: [
          ]},
          supplierLevel: {rules: [
          ]},
          taxScale: {rules: [
          ]},
          headquarters: {rules: [
          ]},
          area: {rules: [
          ]},
          bizArea: {rules: [
          ]},
          alterSupplier: {rules: [
          ]},
          website: {rules: [
          ]},
          corporate: {rules: [
          ]},
          corporatePhone: {rules: [
          ]},
          address: {rules: [
          ]},
          contactsFinancial: {rules: [
          ]},
          phoneFinancial: {rules: [
          ]},
          unitInvoice: {rules: [
          ]},
          bankInvoice: {rules: [
          ]},
          bankidInvoice: {rules: [
          ]},
          taxInvoice: {rules: [
          ]},
          phoneInvoice: {rules: [
          ]},
          accountInvoice: {rules: [
          ]},
          addressInvoice: {rules: [
          ]},
          unitPayment: {rules: [
          ]},
          bankPayment: {rules: [
          ]},
          bankidPayment: {rules: [
          ]},
          accountPayment: {rules: [
          ]},
          accountReceipt: {rules: [
          ]},
          postcodeReceipt: {rules: [
          ]},
          addressReceipt: {rules: [
          ]},
          phoneReceipt: {rules: [
          ]},
          faxReceipt: {rules: [
          ]},
          attachment: {rules: [
          ]},
          remark: {rules: [
          ]},
          isEnabled: {rules: [
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
          add: "/bas/basSupplier/add",
          edit: "/bas/basSupplier/edit",
        }
      }
    },

    computed: {
      readOnly: function() {
        return this.action !== "add" && this.action !== "edit";
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
          this.form.setFieldsValue(pick(this.model,'code','name','shortName','supplierLevel','taxScale','headquarters','area','bizArea','alterSupplier','website','corporate','corporatePhone','address','contactsFinancial','phoneFinancial','unitInvoice','bankInvoice','bankidInvoice','taxInvoice','phoneInvoice','accountInvoice','addressInvoice','unitPayment','bankPayment','bankidPayment','accountPayment','accountReceipt','postcodeReceipt','addressReceipt','phoneReceipt','faxReceipt','attachment','remark','isEnabled','createBy','createTime','updateBy','updateTime'))
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
        this.form.setFieldsValue(pick(row,'code','name','shortName','supplierLevel','taxScale','headquarters','area','bizArea','alterSupplier','website','corporate','corporatePhone','address','contactsFinancial','phoneFinancial','unitInvoice','bankInvoice','bankidInvoice','taxInvoice','phoneInvoice','accountInvoice','addressInvoice','unitPayment','bankPayment','bankidPayment','accountPayment','accountReceipt','postcodeReceipt','addressReceipt','phoneReceipt','faxReceipt','attachment','remark','isEnabled','createBy','createTime','updateBy','updateTime'))
      },

      
    }
  }
</script>

<style lang="less" scoped>
  .ant-row.ant-form-item {
    margin-bottom: 12px;
  }
</style>
