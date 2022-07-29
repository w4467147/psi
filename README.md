Finers 进销存系统
===============

当前最新版本： 0.5.0（发布日期：2020-06-08）

[![AUR](https://img.shields.io/badge/license-Apache%20License%202.0-blue.svg)]()
[![](https://img.shields.io/badge/Author-FINERS团队-orange.svg)]()
[![](https://img.shields.io/badge/version-0.5.0-brightgreen.svg)]()


介绍
-----------------------------------

Finer进销存是一款面向中小企业的供销链管理系统，基于J2EE快速开发平台Jeecg-Boot开发，采用前后端分离架构：SpringBoot2.x，Ant Design&Vue，Mybatis-plus，Shiro，JWT。项目基于十多年的中小企业管理经验，由ERP领域的资深专家设计；产品分为基础版、标准版、企业版三个版本，可适应不同的管控流程；对于灵活多样的个性化的管理需求，在Jeecg-Boot支撑下，利用其强大的代码生成器，无需写任何代码就可以快速实现大多功能，也可手工加入复杂的业务逻辑！
 - 基础版：管结果，直接出入库，生成应收应付，进行收付款并核销
 - 标准版：管过程，业务从合同、申请、订单开始
 - 企业版：管协同，全过程跟踪管理，集成协同办公
 - 本发布为基础版


功能模块
-----------------------------------
```
┌─库存管理
│  ├─入库管理
│  │  ├─采购入库(自动生成采购应付)
│  │  ├─采购退货出库(自动生成红字采购应付)
│  │  ├─盘盈入库
│  │  ├─涨库入库
│  │  └─其他入库
│  ├─出库管理
│  │  ├─监销售出库(自动生成销售应收)
│  │  ├─销售退货入库(自动生成红字销售应收)
│  │  ├─盘亏出库
│  │  └─其他出库
│  ├─库存调拨
│  ├─成本调整
│  ├─库存盘点
│  ├─实时库存
│  └─库存报表（开发中）
├─往来管理: 
│  ├─收款管理
│  │  ├─销售预收
│  │  ├─销售收款
│  │  └─其他收款
│  ├─付款管理
│  │  ├─采购预付
│  │  ├─采购付款
│  │  └─其他付款
│  ├─应收管理
│  │  ├─销售应收
│  │  ├─其他应收
│  │  └─应收核销
│  ├─应付管理
│  │  ├─采购应付
│  │  ├─其他应付
│  │  └─应付核销
│  ├─发票登记
│  │  ├─销售发票
│  │  ├─销售发票(红字)
│  │  ├─采购发票
│  │  └─采购发票(红字)
│  ├─月末结转
│  └─财务统计
│     ├─商品毛利
│     └─（其他功能开发中）
├─基础资料 
│  ├─客户、供应商
│  ├─仓库、物料分类、物料、计量单位
│  └─银行账户、币种
├─系统管理（Jeecg-Boot功能）
│  ├─用户管理
│  ├─角色管理
│  ├─菜单管理
│  ├─权限设置（支持按钮权限、数据权限）
│  ├─表单权限（控制字段禁用、隐藏）
│  ├─部门管理
│  ├─字典管理
│  ├─系统公告
│  ├─我的组织机构
│  ├─职务管理
│  └─通讯录
├─消息中心（Jeecg-Boot）
│  ├─消息管理
│  └─模板管理
├─智能化开发支持（Jeecg-Boot）
│  ├─代码生成器功能（一键生成前后端代码，生成后无需修改直接用，绝对是后端开发福音）
│  ├─代码生成器模板（提供4套模板，分别支持单表和一对多模型，不同风格选择）
│  ├─代码生成器模板（生成代码，自带excel导入导出）
│  ├─查询过滤器（查询逻辑无需编码，系统根据页面配置自动生成）
│  ├─高级查询器（弹窗自动组合查询条件）
│  ├─Excel导入导出工具集成（支持单表，一对多 导入导出）
│  └─平台移动自适应支持
└─系统监控（Jeecg-Boot）
   ├─性能扫描监控
   │  ├─监控 Redis
   │  ├─Tomcat
   │  ├─jvm
   │  ├─服务器信息
   │  ├─请求追踪
   │  └─磁盘监控
   ├─定时任务
   ├─系统日志
   ├─消息中心（支持短信、邮件、微信推送等等）
   ├─数据日志（记录数据快照，可对比快照，查看数据变更情况）
   ├─系统通知
   ├─SQL监控
   └─swagger-ui(在线接口文档)
```
   

 
技术架构
-----------------------------------
#### 开发环境

- 语言：Java 8

- IDE(JAVA)： IDEA / Eclipse，安装lombok插件
 
- IDE(前端)：  IDEA / WebStorm

- 依赖管理：Maven

- 数据库：MySQL5.7+  &  Oracle 11g & SqlServer2017

- 缓存：Redis


#### 后端

- 基础框架：Spring Boot 2.1.3.RELEASE

- 持久层框架：Mybatis-plus_3.1.2

- 安全框架：Apache Shiro 1.4.0，Jwt_3.7.0

- 数据库连接池：阿里巴巴Druid 1.1.10

- 缓存框架：redis

- 日志打印：logback

- 其他：fastjson，poi，Swagger-ui，quartz, lombok（简化代码）等。


#### 前端
 
- [Vue 2.6.10](https://cn.vuejs.org/),[Vuex](https://vuex.vuejs.org/zh/),[Vue Router](https://router.vuejs.org/zh/)
- [Axios](https://github.com/axios/axios)
- [ant-design-vue](https://vuecomponent.github.io/ant-design-vue/docs/vue/introduce-cn/)
- [webpack](https://www.webpackjs.com/),[yarn](https://yarnpkg.com/zh-Hans/)
- [vue-cropper](https://github.com/xyxiao001/vue-cropper) - 头像裁剪组件
- [@antv/g2](https://antv.alipay.com/zh-cn/index.html) - Alipay AntV 数据可视化图表
- [Viser-vue](https://viserjs.github.io/docs.html#/viser/guide/installation)  - antv/g2 封装实现
- eslint，[@vue/cli 3.2.1](https://cli.vuejs.org/zh/guide)
- vue-print-nb - 打印




后台开发环境和依赖
----
- java
- maven
- jdk8
- mysql
- redis
- 数据库脚本：jeecg-boot\db\jeecgboot&psi_mysql5.7.sql
- 初始系统管理员： admin/123456


前端开发环境和依赖
----
- node
- yarn
- webpack
- eslint
- @vue/cli 3.2.1
- [ant-design-vue](https://github.com/vueComponent/ant-design-vue) - Ant Design Of Vue 实现
- [vue-cropper](https://github.com/xyxiao001/vue-cropper) - 头像裁剪组件
- [@antv/g2](https://antv.alipay.com/zh-cn/index.html) - Alipay AntV 数据可视化图表
- [Viser-vue](https://viserjs.github.io/docs.html#/viser/guide/installation)  - antv/g2 封装实现
- [jeecg-boot-angular 版本](https://gitee.com/dangzhenghui/jeecg-boot)


项目下载和运行
----

- 拉取项目代码
```bash
git clone https://gitee.com/FINERME/psi.git
cd  psi/ant-design-jeecg-vue
```

1. 安装node.js
2. 切换到ant-design-jeecg-vue文件夹下
```
# 安装yarn
npm install -g yarn

# 下载依赖
yarn install

# 启动
yarn run serve

# 编译项目
yarn run build

# Lints and fixes files
yarn run lint
```


系统效果
----
##### 系统登录
![系统登录](https://images.gitee.com/uploads/images/2020/0609/101836_d7a51979_1870948.png "登录.png")

##### 采购入库
![输入图片说明](https://images.gitee.com/uploads/images/2020/0609/102923_773c161b_1870948.png "采购入库.png")

##### 采购入库-单据新增
![输入图片说明](https://images.gitee.com/uploads/images/2020/0609/102947_1adcc0b5_1870948.png "采购入库-新增.png")

##### 采购入库-自定义显示列
![输入图片说明](https://images.gitee.com/uploads/images/2020/0609/103001_80cd5c33_1870948.png "采购入库-自定义列.png")

##### 应付核销-编制
![输入图片说明](https://images.gitee.com/uploads/images/2020/0609/103045_36ba1bca_1870948.png "应付核销-编辑.png")

##### 树结构数据
![输入图片说明](https://images.gitee.com/uploads/images/2020/0609/103132_6cd1a170_1870948.png "树结构数据.png")

##### 树结构数-编辑
![输入图片说明](https://images.gitee.com/uploads/images/2020/0609/103159_7558a1cf_1870948.png "树结构数据-编辑.png")

其他说明
----
jeecg-Boot技术官网： http://www.jeecg.com

jeecg-Boot开发文档： http://doc.jeecg.com


