<template>
  <j-modal
    :title="title"
    :width="width"
    :visible="visible"
    :confirmLoading="confirmLoading"
    :destroyOnClose="true"
    @ok="handleOk"
    @cancel="handleCancel"
    cancelText="取消">
    <a-spin :spinning="confirmLoading">
      <a-form :form="form">

        <a-form-item label="启用年度" :labelCol="labelCol" :wrapperCol="wrapperCol">
          <a-input :readOnly="true" v-decorator="['beginYear']" style="width: 100%"/>
        </a-form-item>
        <a-form-item label="启用月度" :labelCol="labelCol" :wrapperCol="wrapperCol">
          <a-input :readOnly="true" v-decorator="['beginMonth']" style="width: 100%"/>
        </a-form-item>
        <a-form-item label="当前年度" :labelCol="labelCol" :wrapperCol="wrapperCol">
          <a-input :readOnly="true" v-decorator="['year']" style="width: 100%"/>
        </a-form-item>
        <a-form-item label="当前月度" :labelCol="labelCol" :wrapperCol="wrapperCol">
          <a-input :readOnly="true" v-decorator="['month']" style="width: 100%"/>
        </a-form-item>

      </a-form>
    </a-spin>
  </j-modal>
</template>

<script>

  import { getAction, postAction } from '@/api/manage'
  import pick from 'lodash.pick'


  export default {
    name: "BasMonthCarryForward",
    components: { 
    },
    data () {
      return {
        form: this.$form.createForm(this),
        title:"月末结转",
        width:600,
        visible: true,
        model: {},
        labelCol: {
          xs: { span: 24 },
          sm: { span: 5 },
        },
        wrapperCol: {
          xs: { span: 24 },
          sm: { span: 16 },
        },
        confirmLoading: false,
        url: {
          list: "/bas/basBizPeriod/list",
          carryForward: "/bas/basBizPeriod/monthCarryForward",
        }
      }
    },
    created () {
      this.loading = true;
      getAction(this.url.list, {}).then((res) => {
        if (res.success) {
          this.edit(res.result.records[0])
        }
        if(res.code===510){
          this.$message.warning(res.message)
        }
        this.loading = false;
      })
    },

    methods: {
      edit (record) {
        this.form.resetFields();
        this.model = Object.assign({}, record);
        this.$nextTick(() => {
          this.form.setFieldsValue(pick(this.model,'beginYear','beginMonth','year','month'))
        })
      },

      close () {
        this.$emit('close');
        this.visible = false;
      },

      handleOk () {
        const that = this;
        that.confirmLoading = true;
        let formData = {year: this.model.year, month: this.model.month};
        console.log(formData)
        postAction(this.url.carryForward, formData).then((res)=>{
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
      },

      handleCancel () {
        this.close()
      },

      popupCallback(row){
        this.form.setFieldsValue(pick(row,'beginYear','beginMonth','year','month'))
      },

    }
  }
</script>