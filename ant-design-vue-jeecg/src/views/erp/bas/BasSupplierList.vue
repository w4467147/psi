<template>
  <a-card :bordered="false">
    <!-- 查询区域 -->
    <div class="table-page-search-wrapper">
      <a-form layout="inline" @keyup.enter.native="searchQuery">
        <a-row :gutter="24">
          <a-col :xl="6" :lg="7" :md="8" :sm="24">
            <a-form-item label="编码">
              <a-input placeholder="请输入编码" v-model="queryParam.code"></a-input>
            </a-form-item>
          </a-col>
          <a-col :xl="6" :lg="7" :md="8" :sm="24">
            <a-form-item label="名称">
              <a-input placeholder="请输入名称" v-model="queryParam.name"></a-input>
            </a-form-item>
          </a-col>
          <a-col :xl="6" :lg="7" :md="8" :sm="24">
            <span style="float: left;overflow: hidden;" class="table-page-search-submitButtons">
              <a-button type="primary" @click="searchQuery" icon="search">查询</a-button>
              <a-button @click="searchReset" icon="reload" style="margin-left: 8px">重置</a-button>
              <a @click="handleToggleSearch" style="margin-left: 8px">
                {{ toggleSearchStatus ? '收起' : '展开' }}
                <a-icon :type="toggleSearchStatus ? 'up' : 'down'"/>
              </a>
            </span>
          </a-col>

        </a-row>
      </a-form>
    </div>
    <!-- 查询区域-END -->
    
    <!-- 操作按钮区域 -->
    <div class="table-operator">
      <a-button type="link" @click="myHandleAdd" icon="plus">新增</a-button>
      <a-button type="link" icon="download" @click="handleExportXls('客户')">导出</a-button>
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
                <a-popconfirm title="确定删除吗?" @confirm="() => handleDelete(record.id)">
                  <a>删除</a>
                </a-popconfirm>
              </a-menu-item>
            </a-menu>
          </a-dropdown>
        </span>

      </a-table>
    </div>

    <basSupplier-modal ref="modalForm" @ok="modalFormOk"></basSupplier-modal>
  </a-card>
</template>

<script>

  import { JeecgListMixin } from '@/mixins/JeecgListMixin'
  import BasSupplierModal from './modules/BasSupplierModal'
  import {filterMultiDictText} from '@/components/dict/JDictSelectUtil'

  export default {
    name: "BasSupplierList",
    mixins:[JeecgListMixin],
    components: {
      BasSupplierModal
    },
    data () {
      return {
        description: '供应商管理',
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
            title:'编码',
            width:160,
            align:"left",
            dataIndex: 'code',
            scopedSlots: { customRender: 'code' }
          },
          {
            title:'名称',
            align:"left",
            dataIndex: 'name'
          },
          {
            title:'简称',
            width:160,
            align:"left",
            dataIndex: 'shortName'
          },
          {
            title:'等级',
            width:75,
            align:"center",
            dataIndex: 'supplierLevel_dictText'
          },
          {
            title:'纳税规模',
            width:100,
            align:"center",
            dataIndex: 'taxScale_dictText'
          },
          {
            title:'所属地区',
            width:120,
            align:"left",
            dataIndex: 'area'
          },
          {
            title:'业务地域',
            width:120,
            align:"left",
            dataIndex: 'bizArea'
          },
          {
            title:'所属总公司',
            align:"center",
            dataIndex: 'headquarters'
          },
          {
            title:'是否启用',
            width:75,
            align:"center",
            dataIndex: 'isEnabled'
          },
          {
            title: '操作',
            width:120,
            dataIndex: 'action',
            align:"center",
            scopedSlots: { customRender: 'action' }
          }
        ],
        url: {
          list: "/bas/basSupplier/list",
          delete: "/bas/basSupplier/delete",
          deleteBatch: "/bas/basSupplier/deleteBatch",
          exportXlsUrl: "/bas/basSupplier/exportXls",
          importExcelUrl: "bas/basSupplier/importExcel",
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
    margin-bottom: 12px;
  }
</style>
