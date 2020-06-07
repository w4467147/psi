import { VALIDATE_NO_PASSED, validateFormAndTables } from '@/utils/JEditableTableUtil'
import { putAction } from '@/api/manage'

export const billModalMixin = {
  data() {
    return {
      action: '',
      spans: {
        labelCol1: {span: 2},
        wrapperCol1: {span: 22},
        //1_5: 分为1.5列（相当于占了2/3）
        labelCol1_5: { span: 3 },
        wrapperCol1_5: { span: 21 },
        labelCol2: {span: 4},
        wrapperCol2: {span: 20},
        labelCol3: {span: 6},
        wrapperCol3: {span: 18},
        labelCol6: {span: 12},
        wrapperCol6: {span: 12}
      },
    };
  },

  computed: {
    readOnly: function() {
      return this.action !== "add" && this.action !== "edit";
    }
  },

  methods: {
    onEntryAdded(event) {
      const {row, target} = event
      let {values} = target.getValuesSync({validate: false});
      let maxEntryNo = 0;
      for (let val of values) {
        let entryNo = Number(val['entryNo']);
        if (!isNaN(entryNo) && entryNo > maxEntryNo) maxEntryNo = entryNo;
      }

      maxEntryNo += this.entryNoStep || 10;
      target.setValues([{rowKey: row.id, values: {entryNo: maxEntryNo}}]);
    },


    handleSave() {
      this.handleOk()
    },

    handleSubmit() {
      //处理状态=编辑完成
      this.form.setFieldsValue({billProcStatus:'13'})

      //出错时要恢复billProcStatus为"12"，所以下面未直接调用handleSave()！

      /** 触发表单验证 */
      this.getAllTable().then(tables => {
        /** 一次性验证主表和所有的次表 */
        return validateFormAndTables(this.form, tables)
      }).then(allValues => {
        if (typeof this.classifyIntoFormData !== 'function') {
          throw this.throwNotFunction('classifyIntoFormData')
        }
        let formData = this.classifyIntoFormData(allValues)
        // 发起请求
        return this.request(formData)
      }).catch(e => {
        //处理状态=编辑中
        this.form.setFieldsValue({billProcStatus:'12'})

        if (e.error === VALIDATE_NO_PASSED) {
          // 如果有未通过表单验证的子表，就自动跳转到它所在的tab
          this.activeKey = e.index == null ? this.activeKey : this.refKeys[e.index]
        } else {
          console.error(e)
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

  }
}