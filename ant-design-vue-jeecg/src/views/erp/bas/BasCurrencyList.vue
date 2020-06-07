<template>
  <a-card :bordered="false">
    <!-- 操作按钮区域 -->
    <div class="table-operator">
      <a-button type="link" @click="myHandleAdd" icon="plus">新增</a-button>
      <a-button type="link" icon="download" @click="handleExportXls('币种')">导出</a-button>
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
        :columns="columns"
        :dataSource="dataSource"
        :pagination="ipagination"
        :loading="loading"
        @change="handleTableChange">

        <a slot="code" @click="myHandleDetail(record)" slot-scope="text, record">{{text}}</a>

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

    <basCurrency-modal ref="modalForm" @ok="modalFormOk"></basCurrency-modal>
  </a-card>
</template>

<script>

  import { JeecgListMixin } from '@/mixins/JeecgListMixin'
  import BasCurrencyModal from './modules/BasCurrencyModal'
  import {filterMultiDictText} from '@/components/dict/JDictSelectUtil'

  export default {
    name: "BasCurrencyList",
    mixins:[JeecgListMixin],
    components: {
      BasCurrencyModal
    },
    data () {
      return {
        description: '币种管理',
        // 表头
        columns: [
          {
            title: '#',
            dataIndex: '',
            key:'rowIndex',
            width:40,
            align:"center",
            customRender:function (t,r,index) {
              return parseInt(index)+1;
            }
          },
          {
            title:'代码',
            width:100,
            align:"center",
            dataIndex: 'code',
            scopedSlots: { customRender: 'code' }
          },
          {
            title:'名称',
            width:120,
            align:"center",
            dataIndex: 'name'
          },
          {
            title:'是否本币',
            width:80,
            align:"center",
            dataIndex: 'isFunctional_dictText'
          },
          {
            title:'是否启用',
            width:80,
            align:"center",
            dataIndex: 'isEnabled_dictText'
          },
          {
            title: '操作',
            dataIndex: 'action',
            align:"left",
            scopedSlots: { customRender: 'action' }
          }
        ],
        url: {
          list: "/bas/basCurrency/list",
          delete: "/bas/basCurrency/delete",
          deleteBatch: "/bas/basCurrency/deleteBatch",
          exportXlsUrl: "/bas/basCurrency/exportXls",
          importExcelUrl: "bas/basCurrency/importExcel",
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
    margin-bottom: 6px;
  }
</style>
