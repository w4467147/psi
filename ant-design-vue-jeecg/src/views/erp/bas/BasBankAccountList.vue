<template>
  <a-card :bordered="false">
    <!-- 操作按钮区域 -->
    <div class="table-operator">
      <a-button type="link" @click="myHandleAdd"  icon="plus">新增</a-button>
      <a-button type="link" icon="download" @click="handleExportXls('银行账户')">导出</a-button>
      <a-upload name="file" :showUploadList="false" :multiple="false" :headers="tokenHeader" :action="importExcelUrl" @change="handleImportExcel">
        <a-button type="link" icon="import">导入</a-button>
      </a-upload>
    </div>

    <!-- table区域-begin -->
    <div>
      <a-table
        ref="table"
        size="middle"
        bordered
        rowKey="id"
        :scroll="{ x: 1500}"
        class="j-table-force-nowrap"
        :columns="columns"
        :dataSource="dataSource"
        :pagination="ipagination"
        :loading="loading"
        @change="handleTableChange">

        <a slot="accountNo" @click="myHandleDetail(record)" slot-scope="text, record">{{text}}</a>

        <span slot="action" slot-scope="text, record">
          <a @click="myHandleEdit(record)">编辑</a>
          <a-divider type="vertical" />
          <a-dropdown>
            <a class="ant-dropdown-link">更多 <a-icon type="down" /></a>
            <a-menu slot="overlay">
              <a-menu-item>
                <a-popconfirm title="确定删除吗?" @confirm="() => handleDelete(record.id)">删除</a-popconfirm>
              </a-menu-item>
            </a-menu>
          </a-dropdown>
        </span>

      </a-table>
    </div>

    <basBankAccount-modal ref="modalForm" @ok="modalFormOk"></basBankAccount-modal>
  </a-card>
</template>

<script>

  import { JeecgListMixin } from '@/mixins/JeecgListMixin'
  import BasBankAccountModal from './modules/BasBankAccountModal'
  import {filterMultiDictText} from '@/components/dict/JDictSelectUtil'

  export default {
    name: "BasBankAccountList",
    mixins:[JeecgListMixin],
    components: {
      BasBankAccountModal
    },
    data () {
      return {
        description: '银行账户管理',
        // 表头
        columns: [
          {
            title: '#',
            dataIndex: '',
            key:'rowIndex',
            fixed:"left",
            width:40,
            align:"center",
            customRender:function (t,r,index) {
              return parseInt(index)+1;
            }
          },
          {
            title:'账号',
            fixed:"left",
            width:220,
            align:"center",
            dataIndex: 'accountNo',
            scopedSlots: { customRender: 'accountNo' }
          },
          {
            title:'账户名称',
            align:"left",
            dataIndex: 'name'
          },
          {
            title:'币种',
            width:100,
            align:"center",
            dataIndex: 'currency_dictText'
          },
          {
            title:'初始余额',
            width:120,
            align:"right",
            dataIndex: 'initBal'
          },
          {
            title:'行号',
            width:150,
            align:"center",
            dataIndex: 'bankNo'
          },
          {
            title:'银行地址',
            align:"left",
            dataIndex: 'bankAddress'
          },
          {
            title:'账户管理员',
            width:100,
            align:"center",
            dataIndex: 'manager_dictText'
          },
          {
            title:'是否启用',
            width:80,
            align:"center",
            dataIndex: 'isEnabled_dictText'
          },
          {
            title:'备注',
            align:"left",
            dataIndex: 'note'
          },
          {
            title: '操作',
            dataIndex: 'action',
            fixed:"right",
            width:120,
            align:"center",
            scopedSlots: { customRender: 'action' }
          }
        ],
        url: {
          list: "/bas/basBankAccount/list",
          delete: "/bas/basBankAccount/delete",
          deleteBatch: "/bas/basBankAccount/deleteBatch",
          exportXlsUrl: "/bas/basBankAccount/exportXls",
          importExcelUrl: "bas/basBankAccount/importExcel",
        },
        dictOptions:{},
      }
    },
    computed: {
      importExcelUrl: function(){
        return `${window._CONFIG['domianURL']}/${this.url.importExcelUrl}`;
      }
    },
    methods: {
      initDictConfig(){
      },
      myHandleAdd(){
        this.$refs.modalForm.action = "add";
        this.handleAdd();
      },
      myHandleEdit(record){
        record.billProcStatus = '12';
        this.$refs.modalForm.action = "edit";
        this.handleEdit(record);
      },
      myHandleDetail(record){
        this.$refs.modalForm.action = "detail";
        this.handleDetail(record);
      },

    }
  }
</script>

<style lang="less" scoped>
  @import '~@assets/less/common.less';

  .table-page-search-wrapper {
    margin-bottom: 8px;
  }

  .table-page-search-wrapper .ant-form-item,
  .table-page-search-wrapper .table-page-search-submitButtons {
    margin-top: 12px;
    margin-bottom: 12px;
  }
</style>
