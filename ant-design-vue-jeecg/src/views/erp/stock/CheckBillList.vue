<template>
  <a-card :bordered="false">
    <!-- 查询区域 -->
    <div class="table-page-search-wrapper">
      <a-form layout="inline" @keyup.enter.native="searchQuery">
        <a-row :gutter="24">
          <a-col :xl="6" :lg="7" :md="8" :sm="24">
            <a-form-item label="单据编号">
              <a-input placeholder="请输入单据编号" v-model="queryParam.billNo"></a-input>
            </a-form-item>
          </a-col>
          <a-col :xl="8" :lg="9" :md="10" :sm="24">
            <a-form-item label="单据日期">
              <j-date placeholder="请选择开始" class="query-group-cust" v-model="queryParam.billDate_begin"></j-date>
              <span class="query-group-split-cust"></span>
              <j-date placeholder="请选择结束" class="query-group-cust" v-model="queryParam.billDate_end"></j-date>
            </a-form-item>
          </a-col>
          <template v-if="toggleSearchStatus">
            <a-col :xl="6" :lg="7" :md="8" :sm="24">
              <a-form-item label="仓库">
                <j-dict-select-tag placeholder="请选择仓库" v-model="queryParam.warehouseId" dictCode="bas_warehouse,name,id"/>
              </a-form-item>
            </a-col>
            <a-col :xl="6" :lg="7" :md="8" :sm="24">
              <a-form-item label="物料分类">
                <j-dict-select-tag placeholder="请选择物料分类" v-model="queryParam.materialCategoryId" dictCode="bas_material_category,name,id"/>
              </a-form-item>
            </a-col>
            <a-col :xl="6" :lg="7" :md="8" :sm="24">
              <a-form-item label="盘点人">
                <j-dict-select-tag placeholder="请选择盘点人" v-model="queryParam.checkerId" dictCode="sys_user,realname,username"/>
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
      <a-button @click="myHandleAdd" type="link"  icon="plus">新增盘点卡</a-button>
      <a-button type="link"  icon="download" @click="handleExportXls('库存盘点卡')">导出</a-button>
      <a-upload name="file" :showUploadList="false" :multiple="false" :headers="tokenHeader" :action="importExcelUrl" @change="handleImportExcel">
        <a-button type="link"  icon="import">导入</a-button>
      </a-upload>

      <a-dropdown v-if="selectedRowKeys.length > 0">
        <a-menu slot="overlay">
          <a-menu-item :disabled="!isBatchDelEnabled" key="1" @click="batchDel"><a-icon type="delete"/>删除</a-menu-item>
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
        :scroll="{ x: 2200}"
        :columns="columns"
        :dataSource="dataSource"
        :pagination="ipagination"
        :loading="loading"
        :rowSelection="{selectedRowKeys: selectedRowKeys, columnWidth: 40, onChange: onSelectChange}"
        @change="handleTableChange">

        <a slot="billNo" @click="myHandleDetail(record)" slot-scope="text, record">{{text}}</a>

        <span slot="action" slot-scope="text, record">
          <a :disabled="!record.actionsEnabled.edit" @click="myHandleEdit(record)">录入实存数</a>
          <a-divider type="vertical" />
          <a-dropdown>
            <a class="ant-dropdown-link">更多 <a-icon type="down" /></a>
            <a-menu slot="overlay">
              <a-menu-item :disabled="!record.actionsEnabled.delete" key="1" >
                <a-popconfirm title="确定删除吗?" @confirm="() => handleDelete(record.id)">删除</a-popconfirm>
              </a-menu-item>
              <a-menu-item :disabled="!record.actionsEnabled.approve" key="2" @click="handleApprove(record)">审核</a-menu-item>
            </a-menu>
          </a-dropdown>
        </span>

      </a-table>
    </div>

    <check-bill-modal ref="modalForm" @ok="modalFormOk"></check-bill-modal>
  </a-card>
</template>

<script>

  import { JeecgListMixin } from '@/mixins/JeecgListMixin'
  import CheckBillModal from './modules/CheckBillModal'
  import JDictSelectTag from '@/components/dict/JDictSelectTag.vue'
  import JDate from '@/components/jeecg/JDate.vue'
  import ListColumnsSetter from '../components/ListColumnsSetter'
  import { billListMixin } from '../mixins/billListMixin'

  export default {
    name: "CheckBillList",
    mixins:[JeecgListMixin, billListMixin],
    components: {
      JDictSelectTag,
      JDate,
      ListColumnsSetter,
      CheckBillModal
    },

    data () {
      return {
        description: '库存盘点',
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
            title:'单据编号',
            fixed: 'left',
            width:180,
            align:"center",
            dataIndex: 'billNo',
            scopedSlots: { customRender: 'billNo' }
          },
          {
            title:'单据日期',
            width:90,
            align:"center",
            dataIndex: 'billDate',
            customRender:function (text) {
              return !text?"":(text.length>10?text.substr(0,10):text)
            }
          },
          {
            title:'仓库',
            align:"left",
            dataIndex: 'warehouseId_dictText'
          },
          {
            title:'物料分类',
            align:"left",
            dataIndex: 'materialCategoryId_dictText'
          },
          {
            title:'盘点人',
            width:75,
            align:"center",
            dataIndex: 'checkerId_dictText'
          },
          {
            title:'制单人',
            width:75,
            align:"center",
            dataIndex: 'createBy_dictText'
          },
          {
            title:'处理状态',
            width:75,
            align:"center",
            dataIndex: 'billProcStatus_dictText'
          },
          {
            title:'是否通过',
            width:75,
            align:"center",
            dataIndex: 'isApproved_dictText'
          },
          {
            title:'是否关闭',
            width:75,
            align:"center",
            dataIndex: 'isClosed_dictText'
          },
          {
            title:'是否作废',
            width:75,
            align:"center",
            dataIndex: 'isVoided_dictText'
          },
          {
            title:'备注',
            align:"left",
            dataIndex: 'remark'
          },
          {
            title:'生效时间',
            width:90,
            align:"center",
            dataIndex: 'effectiveTime',
            customRender:function (text) {
              return !text?"":(text.length>10?text.substr(0,10):text)
            }
          },
          {
            title:'审核人',
            width:75,
            align:"center",
            dataIndex: 'approverId_dictText'
          },
          {
            title:'流程',
            width:100,
            align:"center",
            dataIndex: 'flowId'
          },
          {
            title:'创建时间',
            width:90,
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
            title:'修改时间',
            width:90,
            align:"center",
            dataIndex: 'updateTime',
            customRender:function (text) {
              return !text?"":(text.length>10?text.substr(0,10):text)
            }
          },
          {
            title:'修改人',
            width:75,
            align:"center",
            dataIndex: 'updateBy_dictText'
          },
          {
            title: '操作',
            dataIndex: 'action',
            fixed:'right',
            width:160,
            align:"center",
            scopedSlots: {
              filterDropdown: 'filterDropdown',
              filterIcon: 'filterIcon',
              customRender: 'action'},
          }
        ],
        url: {
          list: "/stock/stkCheckBill/list",
          delete: "/stock/stkCheckBill/delete",
          deleteBatch: "/stock/stkCheckBill/deleteBatch",
          exportXlsUrl: "/stock/stkCheckBill/exportXls",
          importExcelUrl: "stock/stkCheckBill/importExcel",
        },
        dictOptions:{},
      }
    },

    methods: {
      initDictConfig() {}
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
