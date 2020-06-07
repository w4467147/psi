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
        <a-form-item label="编码" :labelCol="labelCol" :wrapperCol="wrapperCol">
          <a-input :readOnly="action!=='add'"  v-decorator="['code', validatorRules.code]" placeholder="请输入编码"></a-input>
        </a-form-item>
        <a-form-item label="名称" :labelCol="labelCol" :wrapperCol="wrapperCol">
          <a-input :readOnly="readOnly" v-decorator="['name', validatorRules.name]" placeholder="请输入名称"></a-input>
        </a-form-item>
        <a-form-item label="分类" :labelCol="labelCol" :wrapperCol="wrapperCol">
          <j-tree-select
            :disabled="readOnly"
            ref="treeSelect"
            placeholder="请选择物料分类"
            v-decorator="['categoryId', validatorRules.categoryId]"
            dict="bas_material_category,name,id"
            pidField="pid"
            pidValue="0"
            hasChildField="has_child">
          </j-tree-select>
        </a-form-item>
        <a-form-item label="规格型号" :labelCol="labelCol" :wrapperCol="wrapperCol">
          <a-input :readOnly="readOnly" v-decorator="['model']" placeholder="请输入规格型号"></a-input>
        </a-form-item>
        <a-form-item label="计量单位" :labelCol="labelCol" :wrapperCol="wrapperCol">
          <j-dict-select-tag :disabled="readOnly" type="list" v-decorator="['unitId', validatorRules.unitId]"
                             :trigger-change="true" dictCode="bas_measure_unit,name,id" placeholder="请选择计量单位"/>
        </a-form-item>
        <a-form-item label="销售价格" :labelCol="labelCol" :wrapperCol="wrapperCol">
          <a-input-number :disabled="readOnly" v-decorator="['salePrice', validatorRules.salePrice]" style="width: 100%"/>
        </a-form-item>
        <a-form-item label="税控编码" :labelCol="labelCol" :wrapperCol="wrapperCol">
          <a-input :readOnly="readOnly" v-decorator="['taxCode']" ></a-input>
        </a-form-item>
        <a-form-item label="是否启用" :labelCol="labelCol" :wrapperCol="wrapperCol">
          <j-dict-select-tag :disabled="readOnly" type="list" v-decorator="['isEnabled', validatorRules.isEnabled]"
                             :trigger-change="true" dictCode="yn" placeholder="请选择是否启用"/>
        </a-form-item>
        <a-form-item label="备注" :labelCol="labelCol" :wrapperCol="wrapperCol">
          <a-input :readOnly="readOnly" v-decorator="['remark']"></a-input>
        </a-form-item>
        <a-form-item label="创建人" :labelCol="labelCol" :wrapperCol="wrapperCol">
          <a-input disabled v-decorator="['createBy']" ></a-input>
        </a-form-item>
        <a-form-item label="创建时间" :labelCol="labelCol" :wrapperCol="wrapperCol">
          <j-date disabled v-decorator="['createTime']" :trigger-change="true" style="width: 100%"/>
        </a-form-item>
        <a-form-item label="修改人" :labelCol="labelCol" :wrapperCol="wrapperCol">
          <a-input disabled v-decorator="['updateBy']" ></a-input>
        </a-form-item>
        <a-form-item label="修改时间" :labelCol="labelCol" :wrapperCol="wrapperCol">
          <j-date disabled v-decorator="['updateTime']" :trigger-change="true" style="width: 100%"/>
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
  import JDate from '@/components/jeecg/JDate'
  import JDictSelectTag from "@/components/dict/JDictSelectTag"
  import JTreeSelect from '@/components/jeecg/JTreeSelect'

  export default {
    name: "BasMaterialModal",
    components: { 
      JDate,
      JDictSelectTag,
      JTreeSelect
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
          code: {
            rules: [
              { required: true, message: '请输入编码!'},
            ]
          },
          name: {
            rules: [
              { required: true, message: '请输入名称!'},
            ]
          },
          unitId: {
            rules: [
              { required: true, message: '请输入计量单位!'},
            ]
          },
          categoryId: {
            rules: [
              { required: true, message: '请输入分类!'},
            ]
          },
          isEnabled: {
            rules: [
              { required: true, message: '请输入是否启用!'},
            ]
          },
          salePrice: {
            rules: [
              { pattern: /^(([1-9][0-9]*)|([0]\.\d{0,2}|[1-9][0-9]*\.\d{0,2}))$/, message: '请输入正确的金额!'},
            ]
          },
        },
        url: {
          add: "/bas/basMaterial/add",
          edit: "/bas/basMaterial/edit",
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
          this.form.setFieldsValue(pick(this.model,'code','name','categoryId','isEnabled',
            'model','unitId','salePrice','taxCode','remark','createBy','createTime','updateBy','updateTime'))
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
        this.form.setFieldsValue(pick(row,'code','name','categoryId','isEnabled',
          'model','unitId','salePrice','taxCode','remark','createBy','createTime','updateBy','updateTime'))
      },

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
