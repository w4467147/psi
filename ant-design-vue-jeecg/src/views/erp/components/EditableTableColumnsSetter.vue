<template>
  <a-popover title="自定义列" trigger="click" placement="topRight">
    <template slot="content">
      <a-checkbox-group @change="onColSettingsChange" v-model="settingColumns"
                        :defaultValue="settingColumns" style="width: 400px;">
        <a-row>
          <template v-for="(item,index) in columns">
            <template v-if="!ignoreColumns.includes(item.key)">
              <a-col :span="12">
                <a-checkbox :value="item.key">{{ item.title }}</a-checkbox>
              </a-col>
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
  import {FormTypes} from "@/utils/JEditableTableUtil";

  export default {
    name: "EditableTableColumnsSetter",
    props: {
      columns:{
        type:Array,
        required: true
      },
      ignoreColumns:{
        type: Array,
        default: () => ['rowIndex', 'action', 'flag']
      },
      tableName:{
        type:String,
        default: '',
      },
    },

    data() {
      return {
        settingColumns:[],
      }
    },

    computed: {
      ls_key() { return this.$route.name + '/' + this.tableName + ':colsettings'},
    },

    created() {
       this.initColumns();
    },

    methods: {
      initColumns(){
        //权限过滤（列权限控制时打开，修改第二个参数为授权码前缀）
        //this.defColumns = colAuthFilter(this.defColumns,'testdemo:');

        const that = this;
        let colSettings = Vue.ls.get(this.ls_key);
        if (colSettings == null) {
          that.columns.forEach(function (item,i,array ) {
            that.settingColumns.push(item.key);
          })
        }else{
          that.settingColumns = colSettings;
          that.columns.forEach(function (item,i,array ) {
            if(that.ignoreColumns.includes(item.key))  return;

            if (colSettings.includes(item.key)) {
              if (item.typeDef !== undefined && item.typeDef !== null
                && item.typeDef !== "" && item.typeDef !== FormTypes.hidden) {
                item.type = item.typeDef;
              }
            } else {
              item.typeDef = item.type;
              item.type = FormTypes.hidden;
            }
          });
        }
      },

      //列设置更改事件
      onColSettingsChange (checkedValues) {
        const that = this;
        Vue.ls.set(this.ls_key, checkedValues, 7*24*60*60*1000)
        that.settingColumns = checkedValues;
        that.columns.forEach(function (item, i, array) {
          if(that.ignoreColumns.includes(item.key))  return;

          if (checkedValues.includes(item.key)) {
            if (item.typeDef !== undefined && item.typeDef !== null
              && item.typeDef !== "" && item.typeDef !== FormTypes.hidden) {
              item.type = item.typeDef;
            }
          } else if (item.type !== FormTypes.hidden) {
            item.typeDef = item.type;
            item.type = FormTypes.hidden;
          }
        });
      }
    },

  }
</script>
