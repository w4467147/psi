<template>
  <a-card :bordered="false">
    <!-- 查询区域 -->
    <div class="table-page-search-wrapper">
      <a-form layout="inline" @keyup.enter.native="searchQuery">
        <a-row :gutter="24">
          <a-col :xl="6" :lg="7" :md="8" :sm="24">
            <a-form-item label="仓库">
              <j-dict-select-tag placeholder="请选择仓库" v-model="queryParam.warehouseId" dictCode="bas_warehouse,name,id"/>
            </a-form-item>
          </a-col>
          <a-col :xl="6" :lg="7" :md="8" :sm="24">
            <a-form-item label="物料">
              <j-search-select-tag placeholder="请输入物料" v-model="queryParam.materialId"  dict="bas_material,name,id"/>
            </a-form-item>
          </a-col>
          <template v-if="toggleSearchStatus">
            <a-col :xl="10" :lg="11" :md="12" :sm="24">
              <a-form-item label="批号">
                <a-input placeholder="请输入最小值" class="query-group-cust" v-model="queryParam.batchNo_begin"></a-input>
                <span class="query-group-split-cust"></span>
                <a-input placeholder="请输入最大值" class="query-group-cust" v-model="queryParam.batchNo_end"></a-input>
              </a-form-item>
            </a-col>
            <a-col :xl="6" :lg="7" :md="8" :sm="24">
              <a-form-item label="供应商">
                <j-dict-select-tag placeholder="请选择供应商" v-model="queryParam.supplierId" dictCode="bas_supplier,name,id"/>
              </a-form-item>
            </a-col>
            <a-col :xl="4" :lg="6" :md="7" :sm="24">
              <a-form-item label="是否关闭">
                <j-dict-select-tag placeholder="请选择是否关闭" v-model="queryParam.isClosed" dictCode="yn"/>
              </a-form-item>
            </a-col>
          </template>
          <a-col :xl="4" :lg="6" :md="7" :sm="24">
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
      <a-button @click="myHandleAdd" type="link"  icon="plus">新增</a-button>
      <a-button type="link"  icon="download" @click="handleExportXls('库存')">导出</a-button>
      <a-upload name="file" :showUploadList="false" :multiple="false" :headers="tokenHeader" :action="importExcelUrl" @change="handleImportExcel">
        <a-button type="link" icon="import">导入</a-button>
      </a-upload>

      <a-dropdown v-if="selectedRowKeys.length > 0">
        <a-menu slot="overlay">
          <a-menu-item disabled="true" key="1" @click=""><a-icon type="close"/>关闭</a-menu-item>
        </a-menu>
        <a-button style="margin-left: 8px"> 批量操作 <a-icon type="down" /></a-button>
      </a-dropdown>
      <i class="anticon anticon-info-circle ant-alert-icon"></i> 已选择 <a style="font-weight: 600">{{ selectedRowKeys.length }}</a>项
      <a style="margin-left: 12px" @click="onClearSelected">清空</a>

      <list-columns-setter v-model="columns" :def-columns="columns" style="float: right;"/>
    </div>

    <!-- table区域-begin -->
    <div>
      <a-table
        ref="table"
        size="middle"
        bordered
        rowKey="id"
        :scroll="{ x: 1900}"
        :columns="columns"
        :dataSource="dataSource"
        :pagination="ipagination"
        :loading="loading"
        :rowSelection="{fixed:true,selectedRowKeys: selectedRowKeys, columnWidth: 40, onChange: onSelectChange}"
        @change="handleTableChange">

        <a slot="batchNo" @click="myHandleDetail(record)" slot-scope="text, record">{{text}}</a>

        <span slot="action" slot-scope="text, record">
          <a @click="myHandleEdit(record)">编辑</a>
          <a-divider type="vertical" />
          <a-dropdown>
            <a class="ant-dropdown-link">更多 <a-icon type="down" /></a>
            <a-menu slot="overlay">
              <a-menu-item disabled>
                <a-popconfirm title="确定关闭吗?" @confirm="() => handleClose(record.id)">关闭</a-popconfirm>
              </a-menu-item>
            </a-menu>
          </a-dropdown>
        </span>

      </a-table>
    </div>

    <stkInventory-modal ref="modalForm" @ok="modalFormOk"></stkInventory-modal>
  </a-card>
</template>

<script>

  import { JeecgListMixin } from '@/mixins/JeecgListMixin'
  import StkInventoryModal from './modules/StkInventoryModal'
  import JDictSelectTag from '@/components/dict/JDictSelectTag.vue'
  import JSearchSelectTag from '@/components/dict/JSearchSelectTag'
  import ListColumnsSetter from '../components/ListColumnsSetter'

  export default {
    name: "StkInventoryList",
    mixins:[JeecgListMixin],
    components: {
      JDictSelectTag,
      JSearchSelectTag,
      ListColumnsSetter,
      StkInventoryModal
    },

    data () {
      return {
        description: '实时库存',
        // 表头
        columns: [
          {
            title: '#',
            dataIndex: '',
            key:'rowIndex',
            fixed: 'left',
            width:40,
            align:"center",
            customRender:function (t,r,index) {
              return parseInt(index)+1;
            }
          },
          {
            title:'批号',
            width:200,
            fixed: 'left',
            align:"center",
            dataIndex: 'batchNo',
            scopedSlots: { customRender: 'batchNo' }
          },
          {
            title:'仓库',
            width:150,
            align:"left",
            dataIndex: 'warehouseId_dictText'
          },
          {
            title:'物料',
            align:"left",
            dataIndex: 'materialId_dictText'
          },
          {
            title:'计量单位',
            width:80,
            align:"center",
            dataIndex: 'unitId_dictText'
          },
          {
            title:'数量',
            width:120,
            align:"center",
            dataIndex: 'qty'
          },
          {
            title:'成本',
            width:120,
            align:"center",
            dataIndex: 'cost'
          },
          {
            title:'单供应商',
            width:80,
            align:"center",
            dataIndex: 'isSingleSupplier_dictText'
          },
          {
            title:'供应商',
            align:"center",
            dataIndex: 'supplierId_dictText'
          },
          {
            title:'是否关闭',
            width:80,
            align:"center",
            dataIndex: 'isClosed_dictText'
          },
          {
            title:'创建时间',
            width:100,
            align:"center",
            dataIndex: 'createTime',
            customRender:function (text) {
              return !text?"":(text.length>10?text.substr(0,10):text)
            }
          },
          {
            title:'创建部门',
            width:120,
            align:"center",
            dataIndex: 'sysOrgCode_dictText'
          },
          {
            title:'创建人',
            width:100,
            align:"center",
            dataIndex: 'createBy_dictText'
          },
          {
            title:'修改时间',
            width:100,
            align:"center",
            dataIndex: 'updateTime',
            customRender:function (text) {
              return !text?"":(text.length>10?text.substr(0,10):text)
            }
          },
          {
            title:'修改人',
            width:100,
            align:"center",
            dataIndex: 'updateBy_dictText'
          },
          {
            title:'操作',
            dataIndex:'action',
            fixed:'right',
            width: 120,
            align:"center",
            scopedSlots: { customRender: 'action' }
          }
        ],
        url: {
          list: "/stock/stkInventory/list",
          delete: "/stock/stkInventory/delete",
          deleteBatch: "/stock/stkInventory/deleteBatch",
          exportXlsUrl: "/stock/stkInventory/exportXls",
          importExcelUrl: "stock/stkInventory/importExcel",
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