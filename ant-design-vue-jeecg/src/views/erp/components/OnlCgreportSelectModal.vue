<template>
  <j-modal
    :visible.sync="visible"
    :width="width"
    :title="title"
    :fullscreen.sync="fullscreen"
    :switchFullscreen="switchFullscreen"
    @ok="handleOk">
`
    <div class="table-page-search-wrapper">
      <a-form layout="inline">
        <a-row :gutter="24" v-if="queryFields && queryFields.length>0">
          <template v-for="(item,index) in queryFields">
            <template v-if="!item.readOnly">
              <a-col v-if="item.view.indexOf('Date')>=0" :md="12" :sm="16" :key=" 'query'+index " v-show="index<3 || toggleSearchStatus">
                <onl-cgreport-query-form-item :queryParam="queryParams" :item="item" :dictOptions="dictOptions"></onl-cgreport-query-form-item>
              </a-col>
              <a-col v-else  :md="6" :sm="8" :key=" 'query'+index " v-show="index<3 || toggleSearchStatus">
                <onl-cgreport-query-form-item :queryParam="queryParams" :item="item" :dictOptions="dictOptions"></onl-cgreport-query-form-item>
              </a-col>
            </template>
            <template v-else>
              <a-col :md="6" :sm="8" v-show="index<3 || toggleSearchStatus">
                <a-form-item :label="item.label">
                  <a-input disabled v-model="queryParams[item.field]"></a-input>
                </a-form-item>
              </a-col>
            </template>
          </template>

          <a-col :md="6" :sm="8">
            <span style="float: left;overflow: hidden;" class="table-page-search-submitButtons">
              <a-button type="primary" @click="searchByQuery" icon="search">查询</a-button>
              <a-button @click="searchReset" icon="reload" style="margin-left: 8px">重置</a-button>
              <a @click="handleToggleSearch" style="margin-left: 8px" v-if="queryFields.length>3">
                {{ toggleSearchStatus ? '收起' : '展开' }}
                <a-icon :type="toggleSearchStatus ? 'up' : 'down'"/>
              </a>
            </span>
          </a-col>
        </a-row>
      </a-form>
    </div>

    <a-table
      ref="table"
      size="small"
      bordered
      rowKey="id"
      :columns="table.columns"
      :dataSource="table.dataSource"
      :pagination="table.pagination"
      :loading="table.loading"
      :scroll="table.scroll"
      :rowSelection="{
        fixed: true,
        columnWidth: 40,
        type: multiSelectable ? 'checkbox':'radio',
        selectedRowKeys: table.selectedRowKeys,
        onChange: handleChangeInTableSelect}"
      @change="handleChangeInTable"
      style="min-height: 300px"
      class="j-table-force-nowrap">
    </a-table>

  </j-modal>
</template>

<script>
  import '@/assets/less/TableExpand.less'
  import { getAction } from '@/api/manage'
  import { filterMultiDictText } from '@/components/dict/JDictSelectUtil'
  import {filterObj} from '@/utils/util';

  export default {
    name: "OnlCgreportSelectModal",
    mixins: [],
    components: {
    },

    props: {
      title: {
        type: String,
        default: '选择'
      },
      reportId: {
        type: String,
        required: true
      },
      params: {//对应sqlParams
        type: Object,
        default:() => ({}) //函数体需带括号
        },
      multiSelectable: {
        type: Boolean,
        default: false
      },
      width: {
        type: Number,
        default: 1000
      },
      fullscreen: {
        type: Boolean,
        default: false
      },
      switchFullscreen: {
        type: Boolean,
        default: true
      },
    },

    data() {
      return {
        visible: false,
        //报表定义中的查询字段
        queryFields: [],
        //查询参数，多个页面的查询参数用 ReportId 作为键来区分
        queryParamsMap: {},
        //报表定义SQL中嵌入的参数
        sqlParams:{},
        sorter: {
          column: '',
          order: 'desc',
        },
        dictOptions: {},
        toggleSearchStatus: false, //搜索 展开/关闭
        description: '',
        url: {
          getColumnsAndData: '/online/cgreport/api/getColumnsAndData/',
          getqueryFields: '/online/cgreport/api/getQueryInfo/',
          getSqlParams:'/online/cgreport/api/getParamsInfo/'
        },
        table: {
          loading: true,
          // 表头
          columns: [],
          //数据集
          dataSource: [],
          // 选择器
          selectedRowKeys: [],
          selectionRows: [],
          scroll: { x: true },
          // 分页参数
          pagination: {
            current: 1,
            pageSize: 10,
            pageSizeOptions: ['10', '20', '30'],
            showTotal: (total, range) => {
              return range[0] + '-' + range[1] + ' 共' + total + '条'
            },
            showQuickJumper: true,
            showSizeChanger: true,
            total: 0
          }
        },
        cgreportHeadName:""
      }
    },

    mounted() {
      this.initSqlParams();
      this.initQueryFields();
    },

    computed: {
      queryParams: {
        get() {
          return this.queryParamsMap[this.reportId]
        },
        set(newVal) {
          this.$set(this.queryParamsMap, this.reportId, newVal)
        }
      }
    },
    methods: {
      //报表定义SQL中嵌入的参数
      initSqlParams(){
        this.sqlParams={}
        getAction(`${this.url.getSqlParams}${this.reportId}`).then((res) => {
          if (res.success) {
            if(res.result && res.result.length>0){
              for(let i of res.result){
                //参数来自引用本Modal时设置的属性
                this.sqlParams['self_'+i.paramName] = (!this.params[i.paramName]) ? "" : this.params[i.paramName];
              }
            }
          } else {
            this.$message.warning(res.message)
          }
          // this.loadData()
        })
      },

      //报表的动态查询参数
      initQueryFields() {
        getAction(`${this.url.getqueryFields}${this.reportId}`).then((res) => {
          if (res.success) {
            this.queryFields = res.result
          } else {
            this.$message.warning(res.message)
          }
          this.loadData()
        })
      },

      //显示本Modal前，调用本函数传递引用页面form或table值作为查询条件参数；
      //readonly为true，表示传入的有值参数不能修改。
      initQueryParams(queryParams, readOnly = true) {
        let queryFields = [];
        for(let item of this.queryFields) {
          item.readOnly = false;
          if (readOnly){
            for(let x in queryParams){
              if (item.field === x) {
                if (queryParams[x]) item.readOnly = queryParams[x]!=='';
                break;
              }
            }
          }
          queryFields.push(item);
        }
        this.queryFields = queryFields;
        this.queryParams = queryParams;
        this.loadData();
      },

      loadData(arg) {
        if (arg === 1) {
          this.table.pagination.current = 1
        }
        let params = this.getQueryParams();//查询条件
        this.table.loading = true

        getAction(`${this.url.getColumnsAndData}${this.reportId}`, params).then(res => {
          if (res.success) {
            let { data, columns, cgreportHeadName, dictOptions, fieldHrefSlots } = res.result

            this.dictOptions = dictOptions
            for(let a=0;a<columns.length;a++){
              if(columns[a].customRender){
                let field_name = columns[a].customRender;
                columns[a].customRender = (t => t ? filterMultiDictText(this.dictOptions[field_name], t + '') : t)
              }
            }
            this.table.columns = [...columns]
            this.cgreportHeadName = cgreportHeadName
            this.fieldHrefSlots = fieldHrefSlots
            if (data) {
              this.table.pagination.total = Number(data.total)
              this.table.dataSource = data.records
            } else {
              this.table.pagination.total = 0
              this.table.dataSource = []
            }

          }else{
            this.$message.warn('查询失败：'+res.message)
          }

        }).catch((e) => {
          console.error(e)
          this.$message.error('查询失败')
        }).finally(() => {
          this.table.loading = false
        })
      },
      getQueryParams() {
        let param = Object.assign({}, this.queryParams, this.sorter,this.sqlParams);
        param.pageNo = this.table.pagination.current;
        param.pageSize = this.table.pagination.pageSize;
        return filterObj(param);
      },
      searchByQuery() {
        this.loadData(1);
      },
      searchReset() {
        let queryParams = {};
        for(let item of this.queryFields) {
          if (item.readOnly)  queryParam[item.field] = this.queryParams[item.field];
        }
        this.queryParams = queryParams;
        this.loadData(1);
      },
      handleToggleSearch() {
        this.toggleSearchStatus = !this.toggleSearchStatus;
      },
      handleChangeInTableSelect(selectedRowKeys, selectionRows) {
        this.table.selectedRowKeys = selectedRowKeys
        this.table.selectionRows = selectionRows
      },
      handleChangeInTable(pagination, filters, sorter) {
        //分页、排序、筛选变化时触发
        if (Object.keys(sorter).length > 0) {
          this.sorter.column = sorter.field
          this.sorter.order = 'ascend' === sorter.order ? 'asc' : 'desc'
        } else {
          this.sorter.column = null
          this.sorter.order = null
        }
        this.table.pagination = pagination
        this.loadData()
      },

      handleOk(){
        this.$emit("callback", this.table.selectionRows);
      }
    }
  }
</script>

<style scoped>
  .div {
    display: flex;
    align-items: center;
    height: 500px
  }
</style>