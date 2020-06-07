<template>
  <a-drawer
    :title="title"
    :width="width"
    placement="right"
    :closable="readOnly"
    @close="close"
    :visible="visible"
    style="height: calc(100% - 55px);overflow: auto;padding-bottom: 53px;">

    <a-spin :spinning="confirmLoading">
      <a-form :form="form">
        <a-form-item label="批号" :labelCol="labelCol" :wrapperCol="wrapperCol">
          <a-input :readOnly="action!=='add'" v-decorator="[ 'batchNo', validatorRules.batchNo]" placeholder="请输入批号"></a-input>
        </a-form-item>
        <a-form-item label="仓库" :labelCol="labelCol" :wrapperCol="wrapperCol">
          <j-dict-select-tag :disabled="action!=='add'" type="list" v-decorator="['warehouseId', validatorRules.warehouseId]" :trigger-change="true" dictCode="bas_warehouse,name,id" placeholder="请选择仓库"/>
        </a-form-item>
        <a-form-item label="物料" :labelCol="labelCol" :wrapperCol="wrapperCol">
          <j-dict-select-tag :disabled="action!=='add'" @change="onMaterialIdChange" type="list" v-decorator="['materialId', validatorRules.materialId]" :trigger-change="true" dictCode="bas_material,name,id" placeholder="请选择物料"/>
        </a-form-item>
        <a-form-item label="计量单位" :labelCol="labelCol" :wrapperCol="wrapperCol">
          <j-dict-select-tag disabled type="list" v-decorator="['unitId', validatorRules.unitId]" :trigger-change="true" dictCode="bas_measure_unit,name,id" placeholder="请选择计量单位"/>
        </a-form-item>
        <a-form-item label="数量" :labelCol="labelCol" :wrapperCol="wrapperCol">
          <a-input-number disabled v-decorator="[ 'qty', validatorRules.qty]" placeholder="请输入数量" style="width: 100%"/>
        </a-form-item>
        <a-form-item label="成本" :labelCol="labelCol" :wrapperCol="wrapperCol">
          <a-input-number disabled  v-decorator="[ 'cost', validatorRules.cost]" placeholder="请输入成本" style="width: 100%"/>
        </a-form-item>
        <a-form-item label="单供应商" :labelCol="labelCol" :wrapperCol="wrapperCol">
          <j-dict-select-tag :disabled="readOnly" type="list" v-decorator="['isSingleSupplier', validatorRules.isSingleSupplier]" :trigger-change="true" dictCode="yn" placeholder="请选择是否单供应商"/>
        </a-form-item>
        <a-form-item label="供应商" :labelCol="labelCol" :wrapperCol="wrapperCol">
          <j-dict-select-tag :disabled="readOnly" type="list" v-decorator="['supplierId', validatorRules.supplierId]" :trigger-change="true" dictCode="bas_supplier,name,id" placeholder="请选择供应商"/>
        </a-form-item>
        <a-form-item label="是否关闭" :labelCol="labelCol" :wrapperCol="wrapperCol">
          <j-dict-select-tag disabled type="list" v-decorator="['isClosed', validatorRules.isClosed]" :trigger-change="true" dictCode="yn" placeholder="请选择是否关闭"/>
        </a-form-item>
        <a-form-item label="创建时间" :labelCol="labelCol" :wrapperCol="wrapperCol">
          <j-date disabled v-decorator="[ 'createTime', validatorRules.createTime]" :trigger-change="true" style="width: 100%"/>
        </a-form-item>
        <a-form-item label="创建部门" :labelCol="labelCol" :wrapperCol="wrapperCol">
          <j-dict-select-tag disabled type="list" v-decorator="['sysOrgCode', validatorRules.sysOrgCode]" :trigger-change="true" dictCode="sys_depart,depart_name,org_code" />
        </a-form-item>
        <a-form-item label="创建人" :labelCol="labelCol" :wrapperCol="wrapperCol">
          <a-input disabled v-decorator="[ 'createBy', validatorRules.createBy]" ></a-input>
        </a-form-item>
        <a-form-item label="修改时间" :labelCol="labelCol" :wrapperCol="wrapperCol">
          <j-date disabled v-decorator="[ 'updateTime', validatorRules.updateTime]" :trigger-change="true" style="width: 100%"/>
        </a-form-item>
        <a-form-item label="修改人" :labelCol="labelCol" :wrapperCol="wrapperCol">
          <a-input disabled v-decorator="[ 'updateBy', validatorRules.updateBy]"></a-input>
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

  import { getAction, httpAction } from '@/api/manage'
  import pick from 'lodash.pick'
  import { validateDuplicateValue } from '@/utils/util'
  import JDate from '@/components/jeecg/JDate'
  import JDictSelectTag from "@/components/dict/JDictSelectTag"

  export default {
    name: "StkInventoryModal",
    components: {
      JDate,
      JDictSelectTag,
    },
    data () {
      return {
        action: "",
        isSingleSupplier: false,

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
          batchNo: {rules: [
              {required: true, message: '请输入批号!'},
            ]},
          materialId: {rules: [
            {required: true, message: '请选择物料!'},
          ]},
          warehouseId: {rules: [
              {required: true, message: '请选择仓库!'},
            ]},
          unitId: {rules: [
              {required: true, message: '请选择计量单位!'},
          ]},
          qty: {rules: [
            {required: true, message: '请输入数量!'},
          ]},
          cost: {rules: [
            {required: true, message: '请输入成本!'},
          ]},
          isSingleSupplier: {rules: [
              {required: true, message: '请选择是否单供应商!'},
            ]},
          supplierId: {rules: [
          ]},
          isClosed: {rules: [
            {required: true, message: '请输入是否关闭!'},
          ]},
          sysOrgCode: {rules: []},
          createBy: {rules: []},
          createTime: {rules: []},
          updateBy: {rules: []},
          updateTime: {rules: []},
        },
        url: {
          add: "/stock/stkInventory/add",
          edit: "/stock/stkInventory/edit",
          getMaterial: "/bas/basMaterial/queryById"
        }
      }
    },

    computed: {
      readOnly: function() {
        return this.action !== "add" && this.action !== "edit"
      }
    },

    methods: {
      add () {
        this.edit({qty: 0, cost: 0, isClosed:0});
      },
      edit (record) {
        this.form.resetFields();

        this.model = Object.assign({}, record);
        this.visible = true;
        this.$nextTick(() => {
          this.form.setFieldsValue(pick(this.model,'batchNo','materialId','warehouseId','unitId','qty','cost', 'isSingleSupplier','supplierId','isClosed','sysOrgCode','createBy','createTime','updateBy','updateTime'))
        })
      },
      close () {
        this.$emit('close');
        this.visible = false;
      },
      handleOk () {
        const that = this;
        if (this.form.getFieldValue("isSingleSupplier") === "1" &&
          (this.form.getFieldValue("supplierId") === undefined ||
            this.form.getFieldValue("supplierId") === null ||
            this.form.getFieldValue("supplierId") === "")) {
          this.$message.warning("需指定供应商！");
          return;
        }
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
        this.form.setFieldsValue(pick(row,'batchNo','materialId','warehouseId','unitId','qty','cost', 'isSingleSupplier','supplierId','isClosed','sysOrgCode','createBy','createTime','updateBy','updateTime'))
      },

      onMaterialIdChange(v) {
        const that = this;
        if (v === undefined || v === null || v === "") {
          that.form.setFieldsValue({"unitId":""});
        }
        else {
          getAction(this.url.getMaterial, {id:v}).then(res => {
            if (res.success) {
              that.$nextTick(() => {
                var record = res.result;
                that.form.setFieldsValue({'unitId':record.unitId});
              })
            }
          })
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
