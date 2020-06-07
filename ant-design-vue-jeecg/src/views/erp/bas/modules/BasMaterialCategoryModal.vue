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
        <a-form-item label="父节点" :labelCol="labelCol" :wrapperCol="wrapperCol">
          <j-tree-select
            :disabled="readOnly"
            ref="treeSelect"
            placeholder="请选择父节点"
            v-decorator="['pid']"
            dict="bas_material_category,name,id"
            pidField="pid"
            pidValue="0"
            hasChildField="has_child">
          </j-tree-select>
        </a-form-item>
        <a-form-item label="名称" :labelCol="labelCol" :wrapperCol="wrapperCol">
          <a-input :disabled="readOnly" v-decorator="['name', validatorRules.name]" placeholder="请输入名称"></a-input>
        </a-form-item>
        <a-form-item label="编码" :labelCol="labelCol" :wrapperCol="wrapperCol">
          <a-input :disabled="readOnly" v-decorator="['code', validatorRules.code]" placeholder="请输入编码"></a-input>
        </a-form-item>
        <a-form-item label="全名" :labelCol="labelCol" :wrapperCol="wrapperCol">
          <a-input :disabled="readOnly" v-decorator="['fullname']" ></a-input>
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
          <j-date disabled  v-decorator="[ 'updateTime']" :trigger-change="true" style="width: 100%"/>
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
  import JTreeSelect from '@/components/jeecg/JTreeSelect'
  
  export default {
    name: "BasMaterialCategoryModal",
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
          name: {
            rules: [
              { required: true, message: '请输入名称!'},
            ]
          },
          code: {
            rules: [
              { required: true, message: '请输入编码!'},
            ]
          },
          isEnabled: {
            rules: [
              { required: true, message: '请输入是否启用!'},
            ]
          },
        },
        url: {
          add: "/bas/basMaterialCategory/add",
          edit: "/bas/basMaterialCategory/edit",
        },
        expandedRowKeys:[],
        pidField:"pid"
     
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
      add (obj) {
        this.edit(obj);
      },
      edit (record) {
        this.form.resetFields();
        this.model = Object.assign({}, record);
        this.visible = true;
        this.$nextTick(() => {
          this.form.setFieldsValue(pick(this.model,'pid','name','code','fullname','isEnabled','createBy','createTime','updateBy','updateTime'))
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
            let old_pid = this.model[this.pidField]
            let formData = Object.assign(this.model, values);
            let new_pid = this.model[this.pidField]
            console.log("表单提交数据",formData)
            httpAction(httpurl,formData,method).then((res)=>{
              if(res.success){
                that.$message.success(res.message);
                that.submitSuccess(formData,old_pid==new_pid)
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
        this.form.setFieldsValue(pick(row,'pid','name','code','fullname','isEnabled','createBy','createTime','updateBy','updateTime'))
      },
      submitSuccess(formData,flag){
        if(!formData.id){
          let treeData = this.$refs.treeSelect.getCurrTreeData()
          this.expandedRowKeys=[]
          this.getExpandKeysByPid(formData[this.pidField],treeData,treeData)
          this.$emit('ok',formData,this.expandedRowKeys.reverse());
        }else{
          this.$emit('ok',formData,flag);
        }
      },
      getExpandKeysByPid(pid,arr,all){
        if(pid && arr && arr.length>0){
          for(let i=0;i<arr.length;i++){
            if(arr[i].key==pid){
              this.expandedRowKeys.push(arr[i].key)
              this.getExpandKeysByPid(arr[i]['parentId'],all,all)
            }else{
              this.getExpandKeysByPid(pid,arr[i].children,all)
            }
          }
        }
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
