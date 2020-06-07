export const billListMixin = {
  computed: {
    importExcelUrl: function(){
      return `${window._CONFIG['domianURL']}/${this.url.importExcelUrl}`;
    },

    isBatchDelEnabled: function () {
      for (let i = 0; i < this.selectedRowKeys.length; i++) {
        if (!this.selectionRows[i].actionsEnabled.delete) {
          return false;
        }
      }
      return true;
    }
  },

  methods: {
    myHandleAdd() {
      this.$refs.modalForm.action = "add";
      this.handleAdd();
    },
    myHandleEdit(record) {
      record.billProcStatus = '12';
      this.$refs.modalForm.action = "edit";
      this.handleEdit(record);
    },
    myHandleDetail(record) {
      this.$refs.modalForm.action = "detail";
      this.handleDetail(record);
    },
    handleApprove(record) {
      this.$refs.modalForm.action = "approve";
      this.$refs.modalForm.edit(record);
      this.$refs.modalForm.title = "审核";
    },
  }
}