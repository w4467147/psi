<template>
  <a-card :bordered="false" :body-style="{ padding: 0}">
      <a-table
        ref="table"
        size="small"
        bordered
        rowKey="billNo"
        :scroll="{ x:800, y:200}"
        :columns="columns"
        :dataSource="dataSource"
        :pagination="ipagination"
        :loading="loading"
        :rowSelection="{
          selectedRowKeys: selectedRowKeys,
          columnWidth: 40,
          getCheckboxProps: getCheckboxProps,
          onChange: onMySelectChange
        }"
        @change="handleTableChange">
        <template slot="title" slot-scope="currentPageData">
          <h3>收款单</h3>
        </template>
      </a-table>
   </a-card>
</template>

<script>
  import { JeecgListMixin } from '@/mixins/JeecgListMixin'

  export default {
    name: "RpCheckReceiptList",
    mixins:[JeecgListMixin],
    components: {  },
    data () {
      return {
        disableMixinCreated: true,
        disableDataSourceChange: false,
        // 表头
        columns: [
          {
            title:'单据号',
            width:180,
            align:"center",
            dataIndex: 'billNo'
          },
          {
            title:'业务类型',
            width:100,
            align:"center",
            dataIndex: 'receiptType_dictText',
          },
          {
            title:'未核销金额',
            width:120,
            align:"center",
            dataIndex: 'uncheckedAmt'
          },
          {
            title:'备注',
            align:"center",
            dataIndex: 'remark'
          },
          {
            title: "已添加",
            width:75,
            align:"center",
            dataIndex: 'added'
          }
        ],

        url: {
          list: "/finance/finReceipt/checkableList",
        },

        dictOptions:{
         billType:[],
        },
      }

    },

    watch:{
      dataSource: function () {
        if (this.disableDataSourceChange){
          this.disableDataSourceChange = false;
        }
        else {
          this.$emit("dataSourceChange");
        }
      }
    },

    created() {
      this.ipagination.pageSize = 5;
      this.ipagination.pageSizeOptions.unshift('5');
    },

    methods: {
      resetTable() {
        this.dataSource = [];
        this.selectedRowKeys = [];
        this.selectionRows = [];
      },

      getCheckboxProps(record) {
        return {
          props: {
            disabled: record.added === "是",
            // defaultChecked: record.added === "是"
          }
        }
      },

      onMySelectChange(selectedRowKeys, selectionRows) {
        this.onSelectChange(selectedRowKeys, selectionRows);
        this.$emit("selectChange");
      },
    }
  }
</script>
<style scoped>
  @import '~@assets/less/common.less'
</style>
