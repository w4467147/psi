<template>
  <a-card :bordered="false">
    <!-- 查询区域 -->
    <div class="table-page-search-wrapper">
      <a-form layout="inline" @keyup.enter.native="searchQuery">
        <a-row :gutter="24">
          <a-col :xl="6" :lg="7" :md="8" :sm="24">
            <a-form-item label="单据编号">
              <a-input placeholder="请输入单据编号" v-model="queryParam.billNo_begin"></a-input>
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
            <a-col :xl="4" :lg="6" :md="7" :sm="24">
              <a-form-item label="是否通过">
                <j-dict-select-tag v-model="queryParam.isApproved" dictCode="yn"/>
              </a-form-item>
            </a-col>
            <a-col :xl="4" :lg="6" :md="7" :sm="24">
              <a-form-item label="是否作废">
                <j-dict-select-tag v-model="queryParam.isVoided" dictCode="yn"/>
              </a-form-item>
            </a-col>
          </template>

          <span style="float: left;overflow: hidden;" class="table-page-search-submitButtons">
            <a-col :md="6" :sm="24">
              <a-button type="primary" @click="searchQuery" icon="search">查询</a-button>
              <a-button @click="searchReset" icon="reload" style="margin-left: 8px">重置</a-button>
              <a @click="handleToggleSearch" style="margin-left: 8px">
                {{ toggleSearchStatus ? '收起' : '展开' }}
                <a-icon :type="toggleSearchStatus ? 'up' : 'down'"/>
              </a>
            </a-col>
          </span>

        </a-row>
      </a-form>
    </div>
    <!-- 查询区域-END -->
    
    <!-- 操作按钮区域 -->
    <div class="table-operator">
      <a-button @click="myHandleAdd" type="link"  icon="plus">新增</a-button>
      <a-button type="link"  icon="download" @click="handleExportXls('销售出库单')">导出</a-button>
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
        :scroll="{ x: 2000}"
        :columns="columns"
        :dataSource="dataSource"
        :pagination="ipagination"
        :loading="loading"
        :rowSelection="{selectedRowKeys: selectedRowKeys, columnWidth: 40, onChange: onSelectChange}"
        @change="handleTableChange">

        <a slot="billNo" @click="myHandleDetail(record)" slot-scope="text, record">{{text}}</a>

        <span slot="action" slot-scope="text, record">
          <a :disabled="!record.actionsEnabled.edit" @click="myHandleEdit(record)">编辑</a>
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

    <move-bill-modal ref="modalForm" @ok="modalFormOk"></move-bill-modal>
  </a-card>
</template>

<script>

  import { JeecgListMixin } from '@/mixins/JeecgListMixin'
  import JSelectUserByDep from '@/components/jeecgbiz/JSelectUserByDep'
  import JDate from '@/components/jeecg/JDate.vue'
  import MoveBillModal from "./modules/MoveBillModal";
  import ListColumnsSetter from '../components/ListColumnsSetter'
  import { billListMixin } from '../mixins/billListMixin'


  export default {
    name: "MoveBillList",
    mixins:[JeecgListMixin, billListMixin],
    components: {
      JDate,
      JSelectUserByDep,
      ListColumnsSetter,
      MoveBillModal
    },

    data () {
      return {
        description: '库存调拨',
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
            title:'源单号',
            width:180,
            align:"center",
            dataIndex: 'sourceNo'
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
            width:120,
            align:"center",
            scopedSlots: {
              filterDropdown: 'filterDropdown',
              filterIcon: 'filterIcon',
              customRender: 'action'},
          }
        ],
        url: {
          list: "/stock/stkIoBill/list/301",
          delete: "/stock/stkIoBill/delete",
          deleteBatch: "/stock/stkIoBill/deleteBatch",
          exportXlsUrl: "/stock/stkIoBill/exportXls/301",
          importExcelUrl: "stock/stkIoBill/importExcel",
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
