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
            <a-form-item label="物料分类">
              <j-tree-select
                ref="treeSelect"
                placeholder="请选择分类"
                v-model="queryParam.categoryId"
                dict="bas_material_category,name,id"
                pidField="pid"
                pidValue="0"
                hasChildField="has_child">
              </j-tree-select>
            </a-form-item>
          </a-col>
          <template v-if="toggleSearchStatus">
            <a-col :xl="6" :lg="7" :md="8" :sm="24">
              <a-form-item label="税控编码">
                <a-input placeholder="请输入税控编码" v-model="queryParam.taxCode"></a-input>
              </a-form-item>
            </a-col>
          </template>
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
        :scroll="{ x: 1600}"
        class="j-table-force-nowrap"
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

    <basMaterial-modal ref="modalForm" @ok="modalFormOk"></basMaterial-modal>
  </a-card>
</template>

<script>

  import '@/assets/less/TableExpand.less'
  import { mixinDevice } from '@/utils/mixin'
  import { JeecgListMixin } from '@/mixins/JeecgListMixin'
  import BasMaterialModal from './modules/BasMaterialModal'
  import {filterMultiDictText} from '@/components/dict/JDictSelectUtil'
  import JTreeSelect from '@/components/jeecg/JTreeSelect'

  export default {
    name: "BasMaterialList",
    mixins:[JeecgListMixin, mixinDevice],
    components: {
      JTreeSelect,
      BasMaterialModal
    },
    data () {
      return {
        description: '物料管理',
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
            title:'编码',
            fixed:"left",
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
            title:'分类',
            align:"left",
            dataIndex: 'categoryId_dictText'
          },
          {
            title:'规格型号',
            align:"left",
            dataIndex: 'model'
          },
          {
            title:'计量单位',
            width:80,
            align:"center",
            dataIndex: 'unitId_dictText'
          },
          {
            title:'销售价格',
            width:100,
            align:"right",
            dataIndex: 'salePrice'
          },
          {
            title:'税控编码',
            width:160,
            align:"center",
            dataIndex: 'taxCode'
          },
          {
            title:'是否启用',
            width:75,
            align:"center",
            dataIndex: 'isEnabled_dictText'
          },
          {
            title:'备注',
            align:"left",
            dataIndex: 'remark'
          },
          {
            title: '操作',
            dataIndex: 'action',
            fixed: "right",
            width:120,
            align:"center",
            scopedSlots: { customRender: 'action' }
          }
        ],
        url: {
          list: "/bas/basMaterial/list",
          delete: "/bas/basMaterial/delete",
          deleteBatch: "/bas/basMaterial/deleteBatch",
          exportXlsUrl: "/bas/basMaterial/exportXls",
          importExcelUrl: "bas/basMaterial/importExcel",
        },
        dictOptions:{},
      }
    },
    computed: {
      importExcelUrl: function(){
        return `${window._CONFIG['domianURL']}/${this.url.importExcelUrl}`;
      },
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
