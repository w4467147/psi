<template>
  <a-popover title="自定义列" trigger="click" placement="leftBottom">
    <template slot="content">
      <a-checkbox-group @change="onColSettingsChange" v-model="settingColumns"
                        :defaultValue="settingColumns" style="width: 400px;">
        <a-row>
          <template v-for="(item,index) in defColumns_">
            <template v-if="!ignoreColumns.includes(item.key) && !ignoreColumns.includes(item.dataIndex)">
              <a-col :span="12"><a-checkbox :value="item.dataIndex">{{ item.title }}</a-checkbox></a-col>
            </template>
          </template>
        </a-row>
      </a-checkbox-group>
    </template>
    <a-button type="link" icon="setting">自定义列</a-button>
  </a-popover>
</template>

<script>
  import Vue from "vue";

  export default {
    name: "ListColumnsSetter",

    props: {
      columns:{
        type:Array,
        required: true
      },
      defColumns:{
        type:Array,
        required: true
      },
      ignoreColumns:{
        type: Array,
        default: () => ['rowIndex', 'action', 'flag']
      },
      listName:{
        type:String,
        default: '',
      }
    },

    model: {
      prop: 'columns',
      event: 'change'
    },

    data() {
      return {
        defColumns_: [],
        settingColumns:[]
      }
    },

    computed: {
      ls_key() { return this.$route.name + '/' + this.listName + ':colsettings'},
    },

    mounted() {
      this.defColumns_.push(...this.defColumns);
      this.initColumns();
    },

    methods: {
      initColumns(){
        //权限过滤（列权限控制时打开，修改第二个参数为授权码前缀）
        //this.defColumns_ = colAuthFilter(this.defColumns_,'testdemo:');

        let colSettings = Vue.ls.get(this.ls_key);
        let columns = [];
        if(colSettings===null||colSettings===undefined){
          let allSettingColumns = [];
          this.defColumns_.forEach(function (item,i,array ) {
            allSettingColumns.push(item.dataIndex);
          })
          this.settingColumns = allSettingColumns;
          columns = this.defColumns_;
        } else {
          this.settingColumns = colSettings;
          columns = this.defColumns_.filter(item => {
            if(this.ignoreColumns.includes(item.key) || this.ignoreColumns.includes(item.dataIndex)){
              return true;
            }
            if (colSettings.includes(item.dataIndex)) {
              return true;
            }
            return false;
          })
        }
        this.$emit('change', columns);
      },

      //列设置更改事件
      onColSettingsChange (checkedValues) {
        Vue.ls.set(this.ls_key, checkedValues, 7*24*60*60*1000)
        this.settingColumns = checkedValues;
        const columns = this.defColumns_.filter(item => {
          if(this.ignoreColumns.includes(item.key) || this.ignoreColumns.includes(item.dataIndex)){
            return true
          }
          if (this.settingColumns.includes(item.dataIndex)) {
            return true
          }
          return false
        })
        this.$emit('change', columns);
      },
    },

  }
</script>
