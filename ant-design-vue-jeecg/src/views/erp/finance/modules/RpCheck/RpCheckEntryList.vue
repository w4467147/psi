<template>
  <a-card :bordered="false" :body-style="{ padding: 0}">
    <!--rowKey：使用应收应付单billNo（每个应收应付单在一个核销单只能一次，但两个核销单可能有相同的应收应付单sourceNo），
               不能使用id（因为新增记录无id） -->
    <a-table
      ref="table"
      size="small"
      rowKey="sourceNo"
      :scroll="{ x:800}"
      :columns="columns"
      :dataSource="dataSource"
      :pagination=false
      :loading="loading"
      :rowSelection="{
        selectedRowKeys: selectedRowKeys,
        columnWidth: 40,
        onChange: onMySelectChange
      }"
      @change="handleTableChange">

      <template slot="title" slot-scope="currentPageData">
        <h3>核销明细-{{title}}</h3>
      </template>

      <template v-for="(col, index) in columns"
                v-if="col.scopedSlots"
                :slot="col.dataIndex"
                slot-scope="text, record, index">
        <div :key="index">
          <a-input-number
            v-if="!readOnly && col.dataIndex==='amt'"
            style="margin: -5px 0"
            :value="text"
            :max="record.uncheckedAmt"
            @change="value => handleCellChange(value, record, col)"
          />
          <a-input-number
            v-else-if="!readOnly && col.type==='Number'"
            style="margin: -5px 0"
            :value="text"
            @change="value => handleCellChange(value, record, col)"
          />
          <a-input
            v-else-if="!readOnly"
            style="margin: -5px 0"
            :value="text"
            @change="e => handleCellChange(e.target.value, record, col)"
          />
          <template v-else>{{ text }}</template>
        </div>
      </template>
    </a-table>

    <div style="margin:8px">核销金额合计：{{totalAmt}}</div>
   </a-card>
</template>

<script>
  import { JeecgListMixin } from '@/mixins/JeecgListMixin'

  export default {
    name: "RpCheckEntryList",
    mixins:[JeecgListMixin],
    components: {  },
    props: {
      // 核销类型:
      checkType: {
        type: String,
        default: ""
      },
      // 核销方向: 1-应收应付， 2-收款付款
      checkSide: {
        type: String,
        default: ""
      },
      readOnly: {
        type: Boolean,
        default: true
      }
    },
    data () {
      return {
        disableMixinCreated:true,
        // 表头
        columns: [
          {
            title:'分录号',
            width:90,
            align:"center",
            dataIndex: 'entryNo',
            type: "Number",
            sorter: (a, b) => a.entryNo - b.entryNo,
            defaultSortOrder:'ascend'
          },
          {
            title:'单据号',
            width:180,
            align:"center",
            dataIndex: 'sourceNo'
          },
          {
            title:'未核销金额',
            width:120,
            align:"center",
            dataIndex: 'uncheckedAmt',
          },
          {
            title:'核销金额',
            width:120,
            align:"center",
            dataIndex: 'amt',
            type: "Number",
            scopedSlots: { customRender: 'amt' },
          },
          {
            title:'备注',
            align:"center",
            dataIndex: 'remark',
            scopedSlots: { customRender: 'remark' },
          },
        ],
        dictOptions:{
         billType:[],
        },
        totalAmt: 0,
      }
    },
    computed: {
      title: function() {
        if (this.checkType === "201")
          return this.checkSide==="1" ? "应付" : (this.checkSide==="2" ? "付款":"");
      }
    },

    watch:{
      dataSource: function () {
        this.calcTotalAmt();
        this.$emit("dataSourceChange");
      },
      totalAmt: function () {
        this.$emit("totalAmtChange", this.totalAmt);
      },

    },

    methods: {
      resetTable() {
        this.dataSource = [];
        this.selectedRowKeys = [];
        this.selectionRows = [];
      },

      onMySelectChange(selectedRowKeys, selectionRows) {
        this.onSelectChange(selectedRowKeys, selectionRows);
        this.$emit("selectChange");
      },

      calcTotalAmt() {
        let total = 0;
        for (let record of this.dataSource) {
          let amt = Number(record.amt)
          if (!isNaN(amt)) {
            total += amt;
          }
        }
        this.totalAmt = total;
      },

      handleCellChange(value, record, column) {
        record[column.dataIndex] = value;
        //触发dataSourceChange和刷新table
        this.dataSource = [...this.dataSource];
      },
    }
  }
</script>
<style lang="less" scoped>
  @import '~@assets/less/common.less';
</style>
