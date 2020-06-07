/*
 Navicat Premium Data Transfer

 Source Server         : local
 Source Server Type    : MySQL
 Source Server Version : 50726
 Source Host           : localhost:3306
 Source Schema         : jeecg-boot

 Target Server Type    : MySQL
 Target Server Version : 50726
 File Encoding         : 65001

 Date: 04/06/2020 16:16:19
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for bas_bank_account
-- ----------------------------
DROP TABLE IF EXISTS `bas_bank_account`;
CREATE TABLE `bas_bank_account`  (
  `id` varchar(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT 'ID',
  `account_no` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '账号',
  `name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '账户名称',
  `currency` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '币种',
  `init_bal` decimal(18, 2) NOT NULL COMMENT '初始余额',
  `bank_no` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '行号',
  `bank_address` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '银行地址',
  `manager` varchar(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '账户管理员',
  `note` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '备注',
  `attachment` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '附件',
  `is_enabled` int(3) NOT NULL COMMENT '是否启用',
  `create_by` varchar(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '创建人',
  `create_time` datetime(0) NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '修改人',
  `update_time` datetime(0) NULL DEFAULT NULL COMMENT '修改时间',
  `version` int(11) NULL DEFAULT NULL COMMENT '版本',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `uk_bank_account_code`(`account_no`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '银行账户' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of bas_bank_account
-- ----------------------------
INSERT INTO `bas_bank_account` VALUES ('1250246233599578114', '11050169520000000***', ' 北京*****科技有限公司', 'CNY', 0.00, '105100007065', NULL, 'admin', NULL, NULL, 1, 'admin', '2020-04-15 00:00:00', 'admin', '2020-05-30 17:14:56', NULL);

-- ----------------------------
-- Table structure for bas_biz_period
-- ----------------------------
DROP TABLE IF EXISTS `bas_biz_period`;
CREATE TABLE `bas_biz_period`  (
  `id` varchar(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT 'ID',
  `begin_year` smallint(6) NOT NULL COMMENT '启用年度',
  `begin_month` tinyint(4) NOT NULL COMMENT '启用月度',
  `year` smallint(6) NOT NULL COMMENT '当前年度',
  `month` tinyint(4) NOT NULL COMMENT '当前月度',
  `version` int(11) NULL DEFAULT NULL COMMENT '版本',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '业务期间' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of bas_biz_period
-- ----------------------------
INSERT INTO `bas_biz_period` VALUES ('ba43143c9fc711eab66f18dbf2568723', 2020, 4, 2020, 5, NULL);

-- ----------------------------
-- Table structure for bas_currency
-- ----------------------------
DROP TABLE IF EXISTS `bas_currency`;
CREATE TABLE `bas_currency`  (
  `id` varchar(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT 'ID',
  `code` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '代码',
  `name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '名称',
  `is_functional` int(3) NOT NULL COMMENT '是否本币',
  `exchange_rate` decimal(18, 10) NULL DEFAULT NULL COMMENT '汇率',
  `is_enabled` int(3) NOT NULL COMMENT '是否启用',
  `create_by` varchar(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '创建人',
  `create_time` datetime(0) NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '修改人',
  `update_time` datetime(0) NULL DEFAULT NULL COMMENT '修改时间',
  `version` int(11) NULL DEFAULT NULL COMMENT '版本',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `uk_currency`(`code`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '币种' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of bas_currency
-- ----------------------------
INSERT INTO `bas_currency` VALUES ('1250238352892432385', 'USD', '美元', 0, 0.0000000000, 1, 'admin', '2020-04-15 00:00:00', 'admin', '2020-04-15 11:28:19', NULL);
INSERT INTO `bas_currency` VALUES ('1250238470324555777', 'JPY', '日元', 0, NULL, 1, 'admin', '2020-04-15 09:44:14', NULL, NULL, NULL);
INSERT INTO `bas_currency` VALUES ('1250264330398093314', 'CNY', '人民币', 1, 1.0000000000, 1, 'admin', '2020-04-15 00:00:00', 'admin', '2020-04-15 11:28:08', NULL);

-- ----------------------------
-- Table structure for bas_customer
-- ----------------------------
DROP TABLE IF EXISTS `bas_customer`;
CREATE TABLE `bas_customer`  (
  `id` varchar(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT 'ID',
  `code` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '编码',
  `name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '名称',
  `short_name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '简称',
  `customer_level_id` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '等级',
  `tax_scale` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '纳税规模',
  `arrears_limit` decimal(18, 2) NULL DEFAULT NULL COMMENT '欠款额度',
  `customer_category` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '客户分类',
  `headquarters` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '所属总公司',
  `area` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '所属地区',
  `biz_area` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '业务区域',
  `website` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '客户网站',
  `corporate` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '法人代表',
  `corporate_phone` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '法人电话',
  `address` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '客户地址',
  `contacts_financial` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '财务信息联系人',
  `phone_financial` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '财务信息联系电话',
  `unit_invoice` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '开票信息单位名称',
  `bank_invoice` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '开票信息开户行',
  `bankid_invoice` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '开票信息行号',
  `tax_invoice` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '开票信息税号',
  `phone_invoice` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '开票信息联系电话',
  `account_invoice` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '开票信息账号',
  `address_invoice` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '开票地址',
  `unit_payment` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '办款资料单位名称',
  `bank_payment` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '办款资料开户行',
  `bankid_payment` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '办款资料行号',
  `account_payment` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '办款资料账号',
  `account_receipt` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '收件信息地址',
  `postcode_receipt` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '收件信息邮编',
  `address_receipt` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '收件信息收件人',
  `phone_receipt` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '收件信息联系电话',
  `fax_receipt` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '收件信息传真',
  `attachment` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '附件',
  `remark` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '备注',
  `is_enabled` int(3) NULL DEFAULT NULL COMMENT '是否启用',
  `create_by` varchar(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '创建人',
  `create_time` datetime(0) NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '修改人',
  `update_time` datetime(0) NULL DEFAULT NULL COMMENT '修改时间',
  `version` int(11) NULL DEFAULT NULL COMMENT '版本',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `uk_customer_code`(`code`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '客户' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of bas_customer
-- ----------------------------
INSERT INTO `bas_customer` VALUES ('40288183712beaa901712c3b1e6f0009', 'CUS001', '客户1  ', NULL, '1', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1, 'admin', '2020-03-31 00:00:00', 'admin', '2020-05-29 00:04:29', NULL);

-- ----------------------------
-- Table structure for bas_material
-- ----------------------------
DROP TABLE IF EXISTS `bas_material`;
CREATE TABLE `bas_material`  (
  `id` varchar(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT 'ID',
  `category_id` varchar(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '分类',
  `code` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '编码',
  `name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '名称',
  `is_enabled` int(3) NOT NULL DEFAULT 1 COMMENT '是否启用',
  `model` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '规格型号',
  `unit_id` varchar(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '计量单位',
  `sale_price` decimal(18, 2) NULL DEFAULT NULL COMMENT '销售价格',
  `tax_code` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '税控编码',
  `remark` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '备注',
  `create_by` varchar(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '创建人',
  `create_time` datetime(0) NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '修改人',
  `update_time` datetime(0) NULL DEFAULT NULL COMMENT '修改时间',
  `version` int(11) NULL DEFAULT NULL COMMENT '版本',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `uk_material_code`(`code`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '物料' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of bas_material
-- ----------------------------
INSERT INTO `bas_material` VALUES ('15853854026861', '4028818370f308e90170f35bca450009', 'A0101.002', '名称A0101.002', 1, '', '40288101710a4c6201710a65913d0002', 1.00, '', '', 'admin', '2020-03-29 22:34:10', NULL, NULL, NULL);
INSERT INTO `bas_material` VALUES ('15854924194022', '4028818370f308e90170f35bca450009', 'A0101.003', '名称A0101.003', 1, '', '40288101710a4c6201710a65913d0002', NULL, '', '', 'admin', '2020-03-29 22:34:10', NULL, NULL, NULL);
INSERT INTO `bas_material` VALUES ('4028818370f308e90170f354f3820008', '4028818370f308e90170f34678640007', 'A01.001', '甲醇01.001', 1, '规格型号', '40288101710a4c6201710a65913d0002', 1.00, 'SK001', '', 'admin', '2020-04-13 00:00:00', 'admin', '2020-05-30 10:02:14', NULL);
INSERT INTO `bas_material` VALUES ('4028818370f308e90170f367e435000c', '4028818370f308e90170f35bca450009', 'A0101.001', '名称A01002', 1, 'a', '40288101710a4c6201710a6618cc0003', 1.00, 'a', '', 'admin', '2020-03-29 22:34:10', NULL, NULL, NULL);

-- ----------------------------
-- Table structure for bas_material_category
-- ----------------------------
DROP TABLE IF EXISTS `bas_material_category`;
CREATE TABLE `bas_material_category`  (
  `id` varchar(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT 'ID',
  `pid` varchar(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '父节点',
  `has_child` varchar(3) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '是否有子节点',
  `code` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '编码',
  `name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '名称',
  `fullname` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '全名',
  `is_enabled` int(3) NOT NULL DEFAULT 1 COMMENT '是否启用',
  `create_by` varchar(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '创建人',
  `create_time` datetime(0) NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '修改人',
  `update_time` datetime(0) NULL DEFAULT NULL COMMENT '修改时间',
  `version` int(11) NULL DEFAULT NULL COMMENT '版本',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `uk_material_category_code`(`code`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '物料分类' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of bas_material_category
-- ----------------------------
INSERT INTO `bas_material_category` VALUES ('4028818370f308e90170f34330b40006', '0', '1', 'A', '甲醇', NULL, 1, 'admin', '2020-03-19 22:47:11', NULL, NULL, NULL);
INSERT INTO `bas_material_category` VALUES ('4028818370f308e90170f34678640007', '4028818370f308e90170f34330b40006', '1', 'A01', '甲醇01', NULL, 1, 'admin', '2020-03-19 00:00:00', 'admin', '2020-04-13 10:22:55', NULL);
INSERT INTO `bas_material_category` VALUES ('4028818370f308e90170f35bca450009', '4028818370f308e90170f34678640007', '0', 'A0101', '甲醇0101', '甲醇0101（全名）', 1, 'admin', '2020-03-19 00:00:00', 'admin', '2020-03-29 22:34:10', NULL);

-- ----------------------------
-- Table structure for bas_measure_unit
-- ----------------------------
DROP TABLE IF EXISTS `bas_measure_unit`;
CREATE TABLE `bas_measure_unit`  (
  `id` varchar(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT 'ID',
  `name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '名称',
  `symbol` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '符号',
  `has_child` varchar(3) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '是否基准',
  `pid` varchar(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '0' COMMENT '基准单位',
  `factor` decimal(18, 6) NOT NULL DEFAULT 1.000000 COMMENT '换算系数',
  `is_enabled` int(3) NOT NULL DEFAULT 1 COMMENT '是否启用',
  `create_by` varchar(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '创建人',
  `create_time` datetime(0) NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '修改人',
  `update_time` datetime(0) NULL DEFAULT NULL COMMENT '修改时间',
  `version` int(11) NULL DEFAULT NULL COMMENT '版本',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '计量单位' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of bas_measure_unit
-- ----------------------------
INSERT INTO `bas_measure_unit` VALUES ('1242301004380692481', '米', 'm', '1', '0', 1.000000, 1, 'admin', '2020-03-24 12:03:35', NULL, NULL, NULL);
INSERT INTO `bas_measure_unit` VALUES ('1242301191434067970', '厘米', 'cm', '0', '1242301004380692481', 0.010000, 1, 'admin', '2020-03-24 12:04:20', NULL, NULL, NULL);
INSERT INTO `bas_measure_unit` VALUES ('1242647149539823618', '千米', 'km', '0', '1242301004380692481', 1000.000000, 1, 'admin', '2020-03-25 10:59:02', 'admin', '2020-03-25 14:37:14', NULL);
INSERT INTO `bas_measure_unit` VALUES ('40288101710a4c6201710a65913d0002', '千克', 'kg', '1', '0', 1.000000, 1, 'admin', '2020-03-23 00:00:00', 'admin', '2020-03-24 11:47:16', NULL);
INSERT INTO `bas_measure_unit` VALUES ('40288101710a4c6201710a6618cc0003', '吨', 't', '0', '40288101710a4c6201710a65913d0002', 1000.000000, 1, 'admin', '2020-03-24 10:36:35', 'admin', '2020-03-24 10:37:04', NULL);

-- ----------------------------
-- Table structure for bas_sequence
-- ----------------------------
DROP TABLE IF EXISTS `bas_sequence`;
CREATE TABLE `bas_sequence`  (
  `k` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT 'k',
  `v` int(11) NOT NULL DEFAULT 1 COMMENT 'v',
  PRIMARY KEY (`k`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of bas_sequence
-- ----------------------------
INSERT INTO `bas_sequence` VALUES ('CHK-20200417-', 4);
INSERT INTO `bas_sequence` VALUES ('CHK-20200418-', 5);
INSERT INTO `bas_sequence` VALUES ('CHK-20200419-', 10);
INSERT INTO `bas_sequence` VALUES ('CHK-20200420-', 9);
INSERT INTO `bas_sequence` VALUES ('CHK-20200421-', 1);
INSERT INTO `bas_sequence` VALUES ('CHK-20200422-', 13);
INSERT INTO `bas_sequence` VALUES ('CHK-20200423-', 10);
INSERT INTO `bas_sequence` VALUES ('CHK-20200427-', 10);
INSERT INTO `bas_sequence` VALUES ('CHK-20200428-', 4);
INSERT INTO `bas_sequence` VALUES ('CHK-20200504-', 1);
INSERT INTO `bas_sequence` VALUES ('CHK-20200510-', 7);
INSERT INTO `bas_sequence` VALUES ('CHK-20200511-', 1);
INSERT INTO `bas_sequence` VALUES ('CHK-20200512-', 2);
INSERT INTO `bas_sequence` VALUES ('CHK-20200513-', 1);
INSERT INTO `bas_sequence` VALUES ('CHK-20200514-', 2);
INSERT INTO `bas_sequence` VALUES ('CHK-20200516-', 1);
INSERT INTO `bas_sequence` VALUES ('CHK-20200518-', 1);
INSERT INTO `bas_sequence` VALUES ('CHK-20200524-', 1);
INSERT INTO `bas_sequence` VALUES ('PAB-20200413-', 4);
INSERT INTO `bas_sequence` VALUES ('PAB-20200513-', 13);
INSERT INTO `bas_sequence` VALUES ('PAB-20200515-', 1);
INSERT INTO `bas_sequence` VALUES ('PAB-20200516-', 8);
INSERT INTO `bas_sequence` VALUES ('PAB-20200517-', 7);
INSERT INTO `bas_sequence` VALUES ('PAB-20200522-', 1);
INSERT INTO `bas_sequence` VALUES ('PAB-20200602-', 1);
INSERT INTO `bas_sequence` VALUES ('PAB-20200603-', 1);
INSERT INTO `bas_sequence` VALUES ('PAY-20200414-', 2);
INSERT INTO `bas_sequence` VALUES ('PAY-20200415-', 31);
INSERT INTO `bas_sequence` VALUES ('PAY-20200416-', 1);
INSERT INTO `bas_sequence` VALUES ('PAY-20200417-', 4);
INSERT INTO `bas_sequence` VALUES ('PAY-20200427-', 6);
INSERT INTO `bas_sequence` VALUES ('PAY-20200430-', 1);
INSERT INTO `bas_sequence` VALUES ('PAY-20200501-', 4);
INSERT INTO `bas_sequence` VALUES ('PAY-20200511-', 5);
INSERT INTO `bas_sequence` VALUES ('PAY-20200512-', 6);
INSERT INTO `bas_sequence` VALUES ('PAY-20200516-', 6);
INSERT INTO `bas_sequence` VALUES ('PAY-20200517-', 13);
INSERT INTO `bas_sequence` VALUES ('PAY-20200520-', 1);
INSERT INTO `bas_sequence` VALUES ('PAY-20200602-', 1);
INSERT INTO `bas_sequence` VALUES ('PAY-20200603-', 1);
INSERT INTO `bas_sequence` VALUES ('PBC-20200528-', 2);
INSERT INTO `bas_sequence` VALUES ('PUI-20200521-', 8);
INSERT INTO `bas_sequence` VALUES ('PUI-20200522-', 11);
INSERT INTO `bas_sequence` VALUES ('PUI-20200524-', 22);
INSERT INTO `bas_sequence` VALUES ('PUI-20200603-', 3);
INSERT INTO `bas_sequence` VALUES ('RAB-20200430-', 1);
INSERT INTO `bas_sequence` VALUES ('RAB-20200511-', 2);
INSERT INTO `bas_sequence` VALUES ('RBC-20200528-', 1);
INSERT INTO `bas_sequence` VALUES ('REC-20200430-', 1);
INSERT INTO `bas_sequence` VALUES ('REC-20200501-', 11);
INSERT INTO `bas_sequence` VALUES ('REC-20200504-', 2);
INSERT INTO `bas_sequence` VALUES ('REC-20200511-', 2);
INSERT INTO `bas_sequence` VALUES ('REC-20200512-', 20);
INSERT INTO `bas_sequence` VALUES ('REC-20200513-', 3);
INSERT INTO `bas_sequence` VALUES ('REC-20200516-', 2);
INSERT INTO `bas_sequence` VALUES ('REC-20200602-', 1);
INSERT INTO `bas_sequence` VALUES ('REC-20200603-', 3);
INSERT INTO `bas_sequence` VALUES ('SAI-20200524-', 4);
INSERT INTO `bas_sequence` VALUES ('SAI-20200531-', 2);
INSERT INTO `bas_sequence` VALUES ('SAI-20200603-', 3);
INSERT INTO `bas_sequence` VALUES ('STC-20200519-', 65);
INSERT INTO `bas_sequence` VALUES ('STC-20200520-', 1);
INSERT INTO `bas_sequence` VALUES ('STC-20200602-', 1);
INSERT INTO `bas_sequence` VALUES ('STC-20200603-', 29);
INSERT INTO `bas_sequence` VALUES ('STK-20200321-', 3);
INSERT INTO `bas_sequence` VALUES ('STK-20200324-', 6);
INSERT INTO `bas_sequence` VALUES ('STK-20200328-', 1);
INSERT INTO `bas_sequence` VALUES ('STK-20200330-', 2);
INSERT INTO `bas_sequence` VALUES ('STK-20200331-', 29);
INSERT INTO `bas_sequence` VALUES ('STK-20200401-', 4);
INSERT INTO `bas_sequence` VALUES ('STK-20200402-', 1);
INSERT INTO `bas_sequence` VALUES ('STK-20200404-', 2);
INSERT INTO `bas_sequence` VALUES ('STK-20200407-', 3);
INSERT INTO `bas_sequence` VALUES ('STK-20200408-', 2);
INSERT INTO `bas_sequence` VALUES ('STK-20200427-', 1);
INSERT INTO `bas_sequence` VALUES ('STK-20200428-', 1);
INSERT INTO `bas_sequence` VALUES ('STK-20200429-', 5);
INSERT INTO `bas_sequence` VALUES ('STK-20200430-', 2);
INSERT INTO `bas_sequence` VALUES ('STK-20200504-', 5);
INSERT INTO `bas_sequence` VALUES ('STK-20200507-', 1);
INSERT INTO `bas_sequence` VALUES ('STK-20200509-', 17);
INSERT INTO `bas_sequence` VALUES ('STK-20200511-', 4);
INSERT INTO `bas_sequence` VALUES ('STK-20200512-', 5);
INSERT INTO `bas_sequence` VALUES ('STK-20200513-', 42);
INSERT INTO `bas_sequence` VALUES ('STK-20200514-', 60);
INSERT INTO `bas_sequence` VALUES ('STK-20200515-', 21);
INSERT INTO `bas_sequence` VALUES ('STK-20200516-', 2);
INSERT INTO `bas_sequence` VALUES ('STK-20200517-', 2);
INSERT INTO `bas_sequence` VALUES ('STK-20200518-', 3);
INSERT INTO `bas_sequence` VALUES ('STK-20200519-', 3);
INSERT INTO `bas_sequence` VALUES ('STK-20200520-', 7);
INSERT INTO `bas_sequence` VALUES ('STK-20200521-', 10);
INSERT INTO `bas_sequence` VALUES ('STK-20200522-', 4);
INSERT INTO `bas_sequence` VALUES ('STK-20200523-', 5);
INSERT INTO `bas_sequence` VALUES ('STK-20200524-', 3);
INSERT INTO `bas_sequence` VALUES ('STK-20200531-', 5);
INSERT INTO `bas_sequence` VALUES ('STK-20200601-', 1);
INSERT INTO `bas_sequence` VALUES ('STK-20200602-', 5);
INSERT INTO `bas_sequence` VALUES ('STK-20200603-', 3);

-- ----------------------------
-- Table structure for bas_supplier
-- ----------------------------
DROP TABLE IF EXISTS `bas_supplier`;
CREATE TABLE `bas_supplier`  (
  `id` varchar(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT 'ID',
  `code` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '编码',
  `name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '名称',
  `short_name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '简称',
  `supplier_level` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '等级',
  `tax_scale` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '纳税规模',
  `supplier_category` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '供应商分类',
  `headquarters` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '所属总公司',
  `area` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '所属地区',
  `biz_area` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '业务地域',
  `alter_supplier` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '备选供应商',
  `website` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '网站',
  `corporate` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '法人代表',
  `corporate_phone` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '法人电话',
  `address` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '供应商地址',
  `contacts_financial` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '财务信息联系人',
  `phone_financial` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '财务信息联系电话',
  `unit_invoice` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '开票信息单位名称',
  `bank_invoice` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '开票信息开户行',
  `bankid_invoice` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '开票信息行号',
  `tax_invoice` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '开票信息税号',
  `phone_invoice` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '开票信息联系电话',
  `account_invoice` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '开票信息账号',
  `address_invoice` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '开票地址',
  `unit_payment` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '办款资料单位名称',
  `bank_payment` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '办款资料开户行',
  `bankid_payment` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '办款资料行号',
  `account_payment` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '办款资料账号',
  `account_receipt` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '收件信息地址',
  `postcode_receipt` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '收件信息邮编',
  `address_receipt` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '收件信息收件人',
  `phone_receipt` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '收件信息联系电话',
  `fax_receipt` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '收件信息传真',
  `attachment` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '附件',
  `remark` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '备注',
  `is_enabled` int(3) NULL DEFAULT NULL COMMENT '是否启用',
  `create_by` varchar(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '创建人',
  `create_time` datetime(0) NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '修改人',
  `update_time` datetime(0) NULL DEFAULT NULL COMMENT '修改时间',
  `version` int(11) NULL DEFAULT NULL COMMENT '版本',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `uk_supplier_code`(`code`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '供应商' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of bas_supplier
-- ----------------------------
INSERT INTO `bas_supplier` VALUES ('2', 'SUP002', '供应商2', '供2', '1', '1', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `bas_supplier` VALUES ('40288183712beaa901712c2243390008', 'SUP001', '供应商1', '供1', '1', '1', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'admin', '2020-03-30 00:00:00', 'admin', '2020-04-01 09:32:36', NULL);

-- ----------------------------
-- Table structure for bas_warehouse
-- ----------------------------
DROP TABLE IF EXISTS `bas_warehouse`;
CREATE TABLE `bas_warehouse`  (
  `id` varchar(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT 'ID',
  `pid` varchar(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '父级',
  `has_child` varchar(3) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '是否有子节点',
  `code` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '编码',
  `name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '名称',
  `phone` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '电话',
  `is_enabled` int(3) NULL DEFAULT NULL COMMENT '是否启用',
  `remark` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '备注',
  `create_by` varchar(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '创建人',
  `create_time` datetime(0) NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '修改人',
  `update_time` datetime(0) NULL DEFAULT NULL COMMENT '修改时间',
  `version` int(11) NULL DEFAULT NULL COMMENT '版本',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `uk_warehouse_code`(`code`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '仓库' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of bas_warehouse
-- ----------------------------
INSERT INTO `bas_warehouse` VALUES ('1266005613237133314', '40288183712beaa901712c1935d10006', NULL, '01.02', '0102仓库', NULL, 1, NULL, 'admin', '2020-05-28 21:57:14', NULL, NULL, NULL);
INSERT INTO `bas_warehouse` VALUES ('40288183712beaa901712c1935d10006', '0', '1', '01', '一号仓库', '010-', 1, NULL, 'admin', '2020-03-30 23:39:41', 'admin', '2020-03-31 09:29:21', NULL);
INSERT INTO `bas_warehouse` VALUES ('40288183712beaa901712c19f6da0007', '40288183712beaa901712c1935d10006', '0', '01.01', '一号仓库1号库位', NULL, 1, NULL, 'admin', '2020-03-30 23:40:31', NULL, NULL, NULL);

-- ----------------------------
-- Table structure for demo
-- ----------------------------
DROP TABLE IF EXISTS `demo`;
CREATE TABLE `demo`  (
  `id` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '主键ID',
  `name` varchar(30) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '姓名',
  `key_word` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '关键词',
  `punch_time` datetime(0) NULL DEFAULT NULL COMMENT '打卡时间',
  `salary_money` decimal(10, 3) NULL DEFAULT NULL COMMENT '工资',
  `bonus_money` double(10, 2) NULL DEFAULT NULL COMMENT '奖金',
  `sex` varchar(2) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '性别 {男:1,女:2}',
  `age` int(11) NULL DEFAULT NULL COMMENT '年龄',
  `birthday` date NULL DEFAULT NULL COMMENT '生日',
  `email` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '邮箱',
  `content` varchar(1000) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '个人简介',
  `create_by` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '创建人',
  `create_time` datetime(0) NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '修改人',
  `update_time` datetime(0) NULL DEFAULT NULL COMMENT '修改时间',
  `sys_org_code` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '所属部门编码',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of demo
-- ----------------------------
INSERT INTO `demo` VALUES ('08375a2dff80e821d5a158dd98302b23', '导入小虎', NULL, NULL, NULL, NULL, '2', 28, NULL, NULL, NULL, 'jeecg-boot', '2019-04-10 11:42:57', NULL, NULL, NULL);
INSERT INTO `demo` VALUES ('1c2ba51b29a42d9de02bbd708ea8121a', '777777', '777', '2018-12-07 19:43:17', NULL, NULL, NULL, 7, '2018-12-07', NULL, NULL, NULL, NULL, 'admin', '2019-02-21 18:26:04', NULL);
INSERT INTO `demo` VALUES ('1dc29e80be14d1400f165b5c6b30c707', 'zhang daihao', NULL, NULL, NULL, NULL, '2', NULL, NULL, 'zhangdaiscott@163.com', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `demo` VALUES ('304e651dc769d5c9b6e08fb30457a602', '小白兔', NULL, NULL, NULL, NULL, '2', 28, NULL, NULL, NULL, 'scott', '2019-01-19 13:12:53', 'qinfeng', '2019-01-19 13:13:12', NULL);
INSERT INTO `demo` VALUES ('4', 'Sandy', '开源，很好', '2018-12-15 00:00:00', NULL, NULL, '2', 21, '2018-12-15', 'test4@baomidou.com', '聪明00', NULL, NULL, 'admin', '2019-02-25 16:29:27', NULL);
INSERT INTO `demo` VALUES ('42c08b1a2e5b2a96ffa4cc88383d4b11', '秦50090', NULL, '2019-01-05 20:33:31', NULL, NULL, NULL, 28, '2019-01-05', NULL, NULL, 'admin', '2019-01-19 20:33:54', 'admin', '2019-01-19 20:34:29', NULL);
INSERT INTO `demo` VALUES ('4436302a0de50bb83025286bc414d6a9', 'zhang daihao', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'zhangdaiscott@163.com', NULL, 'admin', '2019-01-19 15:39:04', NULL, NULL, NULL);
INSERT INTO `demo` VALUES ('4981637bf71b0c1ed1365241dfcfa0ea', '小虎', NULL, NULL, NULL, NULL, '2', 28, NULL, NULL, NULL, 'scott', '2019-01-19 13:12:53', 'qinfeng', '2019-01-19 13:13:12', NULL);
INSERT INTO `demo` VALUES ('5c16e6a5c31296bcd3f1053d5d118815', '导入zhangdaiscott', NULL, NULL, NULL, NULL, '1', NULL, '2019-01-03', NULL, NULL, 'jeecg-boot', '2019-04-10 11:42:57', 'admin', '2019-05-19 18:35:51', NULL);
INSERT INTO `demo` VALUES ('7', 'zhangdaiscott', NULL, NULL, NULL, NULL, '1', NULL, '2019-01-03', NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `demo` VALUES ('73bc58611012617ca446d8999379e4ac', '郭靖11a', '777', '2018-12-07 00:00:00', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'jeecg-boot', '2019-03-28 18:16:39', NULL, NULL, NULL);
INSERT INTO `demo` VALUES ('917e240eaa0b1b2d198ae869b64a81c3', 'zhang daihao', NULL, NULL, NULL, NULL, '2', 0, '2018-11-29', 'zhangdaiscott@163.com', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `demo` VALUES ('94420c5d8fc4420dde1e7196154b3a24', '秦111', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'scott', '2019-01-19 12:54:58', 'qinfeng', '2019-01-19 13:12:10', NULL);
INSERT INTO `demo` VALUES ('95740656751c5f22e5932ab0ae33b1e4', '杨康22a', '奸臣', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'jeecg-boot', '2019-03-28 18:16:39', NULL, NULL, NULL);
INSERT INTO `demo` VALUES ('b86897900c770503771c7bb88e5d1e9b', 'scott1', '开源、很好、hello', NULL, NULL, NULL, '1', NULL, NULL, 'zhangdaiscott@163.com', NULL, 'scott', '2019-01-19 12:22:34', NULL, NULL, NULL);
INSERT INTO `demo` VALUES ('c0b7c3de7c62a295ab715943de8a315d', '秦风555', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'admin', '2019-01-19 13:18:30', 'admin', '2019-01-19 13:18:50', NULL);
INSERT INTO `demo` VALUES ('c28fa8391ef81d6fabd8bd894a7615aa', '小麦', NULL, NULL, NULL, NULL, '2', NULL, NULL, 'zhangdaiscott@163.com', NULL, 'jeecg-boot', '2019-04-04 17:18:09', NULL, NULL, NULL);
INSERT INTO `demo` VALUES ('c2c0d49e3c01913067cf8d1fb3c971d2', 'zhang daihao', NULL, NULL, NULL, NULL, '2', NULL, NULL, 'zhangdaiscott@163.com', NULL, 'admin', '2019-01-19 23:37:18', 'admin', '2019-01-21 16:49:06', NULL);
INSERT INTO `demo` VALUES ('c96279c666b4b82e3ef1e4e2978701ce', '报名时间', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'jeecg-boot', '2019-03-28 18:00:52', NULL, NULL, NULL);
INSERT INTO `demo` VALUES ('d24668721446e8478eeeafe4db66dcff', 'zhang daihao999', NULL, NULL, NULL, NULL, '1', NULL, NULL, 'zhangdaiscott@163.com', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `demo` VALUES ('eaa6c1116b41dc10a94eae34cf990133', 'zhang daihao', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'zhangdaiscott@163.com', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `demo` VALUES ('ffa9da1ad40632dfcabac51d766865bd', '秦999', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'admin', '2019-01-19 23:36:34', 'admin', '2019-02-14 17:30:43', NULL);

-- ----------------------------
-- Table structure for demo_field_def_val_main
-- ----------------------------
DROP TABLE IF EXISTS `demo_field_def_val_main`;
CREATE TABLE `demo_field_def_val_main`  (
  `id` varchar(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `code` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '编码',
  `name` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '姓名',
  `sex` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '性别',
  `address` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '地址',
  `address_param` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '地址（传参）',
  `create_by` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '创建人',
  `create_time` datetime(0) NULL DEFAULT NULL COMMENT '创建日期',
  `update_by` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '更新人',
  `update_time` datetime(0) NULL DEFAULT NULL COMMENT '更新日期',
  `sys_org_code` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '所属部门',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for demo_field_def_val_sub
-- ----------------------------
DROP TABLE IF EXISTS `demo_field_def_val_sub`;
CREATE TABLE `demo_field_def_val_sub`  (
  `id` varchar(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `code` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '编码',
  `name` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '名称',
  `date` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '日期',
  `main_id` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '主表ID',
  `create_by` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '创建人',
  `create_time` datetime(0) NULL DEFAULT NULL COMMENT '创建日期',
  `update_by` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '更新人',
  `update_time` datetime(0) NULL DEFAULT NULL COMMENT '更新日期',
  `sys_org_code` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '所属部门',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for fin_payable
-- ----------------------------
DROP TABLE IF EXISTS `fin_payable`;
CREATE TABLE `fin_payable`  (
  `id` varchar(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT 'ID',
  `bill_no` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '单据编号',
  `bill_date` datetime(0) NOT NULL COMMENT '单据日期',
  `payable_type` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '应付类型',
  `is_rubric` int(3) NOT NULL DEFAULT 0 COMMENT '是否红字',
  `is_auto` int(3) NOT NULL COMMENT '是否自动生成',
  `source_type` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '源单类型',
  `source_id` varchar(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '源单id',
  `source_no` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '源单号',
  `supplier_id` varchar(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '供应商',
  `amt` decimal(18, 2) NOT NULL COMMENT '金额',
  `checked_amt` decimal(18, 2) NOT NULL DEFAULT 0.00 COMMENT '已核销金额',
  `attachment` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '附件',
  `remark` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '备注',
  `bill_proc_status` varchar(4) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '11' COMMENT '处理状态',
  `is_approved` int(3) NOT NULL DEFAULT 0 COMMENT '是否通过',
  `is_closed` int(3) NOT NULL DEFAULT 0 COMMENT '是否关闭',
  `is_voided` int(3) NOT NULL DEFAULT 0 COMMENT '是否作废',
  `approver_id` varchar(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '审核人',
  `flow_id` varchar(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '流程id',
  `effective_time` datetime(0) NULL DEFAULT NULL COMMENT '生效时间',
  `sys_org_code` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '创建部门',
  `create_by` varchar(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '创建人',
  `create_time` datetime(0) NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '修改人',
  `update_time` datetime(0) NULL DEFAULT NULL COMMENT '修改时间',
  `version` int(11) NULL DEFAULT NULL COMMENT '版本',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `uk_ar_bill_bill`(`bill_no`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '应付单' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of fin_payable
-- ----------------------------
INSERT INTO `fin_payable` VALUES ('1', '1', '2020-04-13 14:44:45', '202', 0, 1, NULL, NULL, NULL, '40288183712beaa901712c2243390008', 100.00, 0.00, NULL, NULL, '23', 1, 0, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `fin_payable` VALUES ('1249616193937477634', 'PAB-20200413-000001', '2020-04-13 16:31:32', '202', 0, 1, 'stk_io_bill..101', '1245562990572982273', 'STK-20200402-000001', '40288183712beaa901712c2243390008', 1.00, 0.00, NULL, NULL, '23', 1, 0, 0, 'admin', NULL, '2020-04-13 16:31:32', 'A01', 'admin', '2020-04-13 16:31:32', NULL, NULL, NULL);
INSERT INTO `fin_payable` VALUES ('1249618087091113986', 'PAB-20200413-000002', '2020-04-13 16:39:03', '202', 0, 1, 'stk_io_bill..101', '1245562990572982273', 'STK-20200402-000001', '40288183712beaa901712c2243390008', 1.00, 0.00, NULL, NULL, '23', 1, 0, 0, 'admin', NULL, '2020-04-13 16:39:03', 'A01', 'admin', '2020-04-13 16:39:03', NULL, NULL, NULL);
INSERT INTO `fin_payable` VALUES ('1249620928153280514', 'PAB-20200413-000003', '2020-04-13 16:50:21', '202', 0, 1, 'stk_io_bill..101', '1245562990572982273', 'STK-20200402-000001', '40288183712beaa901712c2243390008', 100.00, 0.00, NULL, NULL, '23', 1, 0, 0, 'admin', NULL, '2020-04-13 16:50:21', 'A01', 'admin', '2020-04-13 16:50:21', NULL, NULL, NULL);
INSERT INTO `fin_payable` VALUES ('1249716139872100353', 'PAB-20200413-000004', '2020-04-13 23:08:41', '202', 0, 1, 'stk_io_bill..101', '1245562990572982273', 'STK-20200402-000001', '40288183712beaa901712c2243390008', 100.00, 20.00, NULL, NULL, '23', 1, 0, 0, 'admin', NULL, '2020-04-13 23:08:41', 'A01', 'admin', '2020-04-13 23:08:41', 'admin', '2020-04-27 23:26:47', NULL);
INSERT INTO `fin_payable` VALUES ('1260252701542211585', 'PAB-20200513-000004', '2020-05-13 00:00:00', '299', 0, 0, NULL, NULL, NULL, '40288183712beaa901712c2243390008', 1000.00, 0.00, NULL, NULL, '23', 1, 0, 0, 'admin', NULL, '2020-05-13 01:15:47', 'A01', 'admin', '2020-05-13 00:57:13', 'admin', '2020-05-13 01:15:47', NULL);
INSERT INTO `fin_payable` VALUES ('1261211821947826178', 'PAB-20200515-000001', '2020-05-15 16:28:25', '202', 0, 1, NULL, '1261095414874583041', 'STK-20200515-000001', '40288183712beaa901712c2243390008', -100.00, 0.00, NULL, NULL, '23', 1, 0, 0, 'admin', NULL, '2020-05-15 16:28:25', 'A01', 'admin', '2020-05-15 16:28:25', NULL, NULL, NULL);
INSERT INTO `fin_payable` VALUES ('1263719902036373505', 'PAB-20200522-000001', '2020-05-22 14:34:38', '202', 0, 1, 'stk_io_bill..101', '1244985551059550210', 'STK-20200331-000027', '40288183712beaa901712c2243390008', 22.00, 0.00, NULL, NULL, '23', 1, 0, 0, 'admin', NULL, '2020-05-22 14:34:38', 'A01', 'admin', '2020-05-22 14:34:38', NULL, NULL, NULL);
INSERT INTO `fin_payable` VALUES ('2', '2', '2020-04-24 17:43:58', '202', 0, 1, NULL, NULL, NULL, '40288183712beaa901712c2243390008', 1.00, 0.00, NULL, NULL, '23', 1, 0, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);

-- ----------------------------
-- Table structure for fin_payable_bal
-- ----------------------------
DROP TABLE IF EXISTS `fin_payable_bal`;
CREATE TABLE `fin_payable_bal`  (
  `id` varchar(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT 'ID',
  `year` smallint(6) NOT NULL COMMENT '业务年度',
  `month` tinyint(4) NOT NULL COMMENT '业务月度',
  `supplier_id` varchar(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '供应商',
  `begin_credit_bal` decimal(18, 2) NOT NULL DEFAULT 0.00 COMMENT '期初贷方余额',
  `debit_amt` decimal(18, 2) NOT NULL DEFAULT 0.00 COMMENT '借方金额',
  `credit_amt` decimal(18, 2) NOT NULL DEFAULT 0.00 COMMENT '贷方金额',
  `is_init` tinyint(1) NOT NULL DEFAULT 0 COMMENT '是否初始数据',
  `version` int(11) NULL DEFAULT NULL COMMENT '版本',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `AK_uk_fin_payable_bal`(`year`, `month`, `supplier_id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '应付余额' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of fin_payable_bal
-- ----------------------------
INSERT INTO `fin_payable_bal` VALUES ('02041e667b209d5e644ab9e2c1098e61', 2020, 5, NULL, 0.00, 0.00, 922.00, 0, NULL);
INSERT INTO `fin_payable_bal` VALUES ('2dee894857fa95f3c78e50021fa37974', 2020, 5, '40288183712beaa901712c2243390008', 0.00, 0.00, 922.00, 0, NULL);
INSERT INTO `fin_payable_bal` VALUES ('bb30fea0b8577d27e4a4a6aee00e95ff', 2020, 6, NULL, 922.00, 0.00, 0.00, 0, NULL);
INSERT INTO `fin_payable_bal` VALUES ('e4eee5a6661202ccd2f70a7b31c775fd', 2020, 6, '40288183712beaa901712c2243390008', 922.00, 0.00, 0.00, 0, NULL);

-- ----------------------------
-- Table structure for fin_payable_check
-- ----------------------------
DROP TABLE IF EXISTS `fin_payable_check`;
CREATE TABLE `fin_payable_check`  (
  `id` varchar(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT 'ID',
  `bill_no` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '单据编号',
  `bill_date` date NOT NULL COMMENT '单据日期',
  `payable_check_type` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '核销类型',
  `supplier_id` varchar(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '供应商',
  `remark` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '备注',
  `bill_proc_status` varchar(4) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '11' COMMENT '处理状态',
  `is_approved` tinyint(1) NOT NULL DEFAULT 0 COMMENT '是否通过',
  `is_closed` tinyint(1) NOT NULL DEFAULT 0 COMMENT '是否关闭',
  `is_voided` tinyint(1) NOT NULL DEFAULT 0 COMMENT '是否作废',
  `effective_time` datetime(0) NULL DEFAULT NULL COMMENT '生效时间',
  `approver_id` varchar(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '审核人',
  `flow_id` char(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '流程id',
  `create_time` datetime(0) NULL DEFAULT NULL COMMENT '创建时间',
  `create_by` varchar(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '创建人',
  `sys_org_code` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '创建部门',
  `update_time` datetime(0) NULL DEFAULT NULL COMMENT '修改时间',
  `update_by` varchar(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '修改人',
  `version` int(11) NULL DEFAULT NULL COMMENT '版本',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `uk_arp_check_bill`(`bill_no`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '应付核销单' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of fin_payable_check
-- ----------------------------
INSERT INTO `fin_payable_check` VALUES ('1265850015163121665', 'PBC-20200528-000002', '2020-05-28', '201', '40288183712beaa901712c2243390008', NULL, '12', 0, 0, 0, NULL, NULL, NULL, '2020-05-28 00:00:00', 'admin', 'A01', '2020-05-28 15:06:08', 'admin', NULL);

-- ----------------------------
-- Table structure for fin_payable_check_entry
-- ----------------------------
DROP TABLE IF EXISTS `fin_payable_check_entry`;
CREATE TABLE `fin_payable_check_entry`  (
  `id` varchar(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT 'ID',
  `mid` varchar(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '主表',
  `bill_no` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '单据编号',
  `entry_no` int(11) NOT NULL COMMENT '分录号',
  `check_side` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '核销方向',
  `source_type` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '源单类型',
  `source_id` varchar(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '源单id',
  `source_no` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '源单号',
  `amt` decimal(18, 2) NOT NULL COMMENT '核销金额',
  `remark` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '备注',
  `version` int(11) NULL DEFAULT NULL COMMENT '版本',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `uk_fin_payable_check_entry`(`bill_no`, `entry_no`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '应付核销明细' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of fin_payable_check_entry
-- ----------------------------
INSERT INTO `fin_payable_check_entry` VALUES ('1265899820937678850', '1265850015163121665', 'PBC-20200528-000002', 101, '1', 'fin_payable', '1263719902036373505', 'PAB-20200522-000001', 10.00, NULL, NULL);
INSERT INTO `fin_payable_check_entry` VALUES ('1265902156359700482', '1265850015163121665', 'PBC-20200528-000002', 102, '1', 'fin_payable', '1260252701542211585', 'PAB-20200513-000004', 1000.00, NULL, NULL);

-- ----------------------------
-- Table structure for fin_payment
-- ----------------------------
DROP TABLE IF EXISTS `fin_payment`;
CREATE TABLE `fin_payment`  (
  `id` varchar(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT 'ID',
  `bill_no` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '单据编号',
  `bill_date` date NOT NULL COMMENT '单据日期',
  `payment_type` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '付款类型',
  `is_rubric` int(3) NOT NULL DEFAULT 0 COMMENT '是否红字',
  `supplier_id` char(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '供应商',
  `amt` decimal(18, 2) NOT NULL COMMENT '金额',
  `checked_amt` decimal(18, 2) NOT NULL DEFAULT 0.00 COMMENT '已核销金额',
  `deducted_amt` decimal(18, 2) NOT NULL DEFAULT 0.00 COMMENT '已抵扣预付金额',
  `attachment` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '附件',
  `remark` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '备注',
  `bill_proc_status` varchar(4) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '11' COMMENT '处理状态',
  `is_approved` tinyint(1) NOT NULL DEFAULT 0 COMMENT '是否通过',
  `is_closed` tinyint(1) NOT NULL DEFAULT 0 COMMENT '是否关闭',
  `is_voided` tinyint(1) NOT NULL DEFAULT 0 COMMENT '是否作废',
  `effective_time` datetime(0) NULL DEFAULT NULL COMMENT '生效时间',
  `approver_id` varchar(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '审核人',
  `flow_id` char(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '流程',
  `create_time` datetime(0) NULL DEFAULT NULL COMMENT '创建时间',
  `create_by` varchar(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '创建人',
  `sys_org_code` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '创建部门',
  `update_time` datetime(0) NULL DEFAULT NULL COMMENT '修改时间',
  `update_by` varchar(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '修改人',
  `version` int(11) NULL DEFAULT NULL COMMENT '版本',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `uk_ap_payment_bill`(`bill_no`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '付款单' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of fin_payment
-- ----------------------------
INSERT INTO `fin_payment` VALUES ('1256210183951376386', 'PAY-20200501-000003', '2020-05-01', '202', 0, '40288183712beaa901712c2243390008', 1000.00, 0.00, 0.00, NULL, NULL, '13', 0, 0, 0, NULL, NULL, NULL, '2020-05-01 00:00:00', 'admin', 'A01', '2020-05-13 10:22:24', 'admin', NULL);
INSERT INTO `fin_payment` VALUES ('1261645136478527490', 'PAY-20200516-000001', '2020-05-16', '299', 0, '2', 100.00, 0.00, 0.00, NULL, NULL, '12', 0, 0, 0, NULL, NULL, NULL, '2020-05-16 00:00:00', 'admin', 'A01', '2020-06-02 23:48:12', 'admin', NULL);
INSERT INTO `fin_payment` VALUES ('1261667937637818369', 'PAY-20200516-000002', '2020-05-16', '202', 0, '2', 100.00, 0.00, 0.00, NULL, NULL, '12', 0, 0, 0, NULL, NULL, NULL, '2020-05-16 22:40:52', 'admin', 'A01', NULL, NULL, NULL);
INSERT INTO `fin_payment` VALUES ('1261669707185315842', 'PAY-20200516-000003', '2020-05-16', '201', 0, '2', 1.00, 0.00, 0.00, NULL, NULL, '12', 0, 0, 0, NULL, NULL, NULL, '2020-05-16 22:47:54', 'admin', 'A01', NULL, NULL, NULL);
INSERT INTO `fin_payment` VALUES ('1261859093155864577', 'PAY-20200517-000012', '2020-05-17', '202', 1, '2', 1.00, 0.00, 0.00, NULL, NULL, '13', 0, 0, 0, NULL, NULL, NULL, '2020-05-17 00:00:00', 'admin', 'A01', '2020-05-17 11:41:15', 'admin', NULL);

-- ----------------------------
-- Table structure for fin_payment_entry
-- ----------------------------
DROP TABLE IF EXISTS `fin_payment_entry`;
CREATE TABLE `fin_payment_entry`  (
  `id` varchar(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT 'ID',
  `mid` varchar(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '主表',
  `bill_no` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '单据编号',
  `entry_no` int(11) NOT NULL COMMENT '分录号',
  `source_type` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '源单类型',
  `source_entry_no` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '源单分录号',
  `source_entry_id` varchar(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '源单分录id',
  `settle_method` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '结算方式',
  `bank_account_id` char(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '资金账户',
  `amt` decimal(18, 2) NOT NULL COMMENT '金额',
  `remark` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '备注',
  `remark2` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '备注2',
  `remark3` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '备注3',
  `version` int(11) NULL DEFAULT NULL COMMENT '版本',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `uk_ap_payment_entry`(`mid`, `entry_no`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '付款单明细' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of fin_payment_entry
-- ----------------------------
INSERT INTO `fin_payment_entry` VALUES ('15883387912810', '1256210183951376386', 'PAY-20200501-000003', 10, NULL, '', NULL, '21', NULL, 1000.00, '', '', '', NULL);
INSERT INTO `fin_payment_entry` VALUES ('15896345964660465024', '1261645136478527490', 'PAY-20200516-000001', 10, NULL, '', NULL, '11', NULL, 100.00, '', '', '', NULL);
INSERT INTO `fin_payment_entry` VALUES ('15896400306150342060', '1261667937637818369', 'PAY-20200516-000002', 10, NULL, '', NULL, '11', NULL, 100.00, '', '', '', NULL);
INSERT INTO `fin_payment_entry` VALUES ('15896404428900258129', '1261669707185315842', 'PAY-20200516-000003', 10, NULL, '', NULL, '11', NULL, 1.00, '', '', '', NULL);
INSERT INTO `fin_payment_entry` VALUES ('15896856083730308985', '1261859093155864577', 'PAY-20200517-000012', 10, NULL, '', NULL, '11', NULL, 1.00, '', '', '', NULL);

-- ----------------------------
-- Table structure for fin_pur_invoice
-- ----------------------------
DROP TABLE IF EXISTS `fin_pur_invoice`;
CREATE TABLE `fin_pur_invoice`  (
  `id` varchar(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT 'ID',
  `bill_no` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '单据编号',
  `bill_date` date NOT NULL COMMENT '单据日期',
  `is_auto` int(3) NOT NULL DEFAULT 0 COMMENT '是否自动生成',
  `invoice_type` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '发票类型',
  `is_rubric` int(3) NOT NULL COMMENT '是否红字',
  `source_type` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '源单类型',
  `source_id` varchar(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '源单id',
  `source_no` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '源单号',
  `clerk_id` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '业务员',
  `supplier_id` varchar(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '供应商',
  `attachment` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '附件',
  `remark` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '备注',
  `bill_proc_status` varchar(4) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '11' COMMENT '处理状态',
  `approver_id` varchar(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '审核人',
  `flow_id` varchar(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '流程id',
  `is_approved` int(3) NOT NULL DEFAULT 0 COMMENT '是否通过',
  `effective_time` datetime(0) NULL DEFAULT NULL COMMENT '生效时间',
  `is_voided` int(3) NOT NULL DEFAULT 0 COMMENT '是否作废',
  `is_closed` int(3) NOT NULL DEFAULT 0 COMMENT '是否关闭',
  `sys_org_code` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '创建部门',
  `create_by` varchar(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '创建人',
  `create_time` datetime(0) NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '修改人',
  `update_time` datetime(0) NULL DEFAULT NULL COMMENT '修改时间',
  `version` int(11) NULL DEFAULT NULL COMMENT '版本',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `uk_iinvoice`(`bill_no`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '采购发票登记' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of fin_pur_invoice
-- ----------------------------
INSERT INTO `fin_pur_invoice` VALUES ('1263506230591504386', 'PUI-20200522-000007', '2020-05-22', 0, NULL, 0, NULL, NULL, NULL, NULL, '40288183712beaa901712c2243390008', NULL, NULL, '23', 'admin', NULL, 1, '2020-05-22 16:37:42', 0, 0, 'A01', 'admin', '2020-05-22 00:00:00', 'admin', '2020-05-22 16:37:42', NULL);
INSERT INTO `fin_pur_invoice` VALUES ('1263752608841465858', 'PUI-20200522-000011', '2020-05-22', 0, '11', 0, NULL, NULL, NULL, NULL, '40288183712beaa901712c2243390008', 'temp/logo-J_1590137066976.png', 'aaaa', '23', 'admin', NULL, 1, '2020-05-23 11:27:13', 0, 0, 'A01', 'admin', '2020-05-22 00:00:00', 'admin', '2020-05-23 11:27:13', NULL);
INSERT INTO `fin_pur_invoice` VALUES ('1264408029913583618', 'PUI-20200524-000014', '2020-05-24', 0, NULL, 1, 'fin_pur_invoice', '1263506230591504386', 'PUI-20200522-000007', NULL, '40288183712beaa901712c2243390008', NULL, NULL, '23', 'admin', NULL, 1, '2020-05-24 15:02:57', 0, 0, 'A01', 'admin', '2020-05-24 00:00:00', 'admin', '2020-05-24 15:02:57', NULL);
INSERT INTO `fin_pur_invoice` VALUES ('1264411139406991362', 'PUI-20200524-000017', '2020-05-24', 0, NULL, 1, 'fin_pur_invoice', '1263506230591504386', 'PUI-20200522-000007', NULL, '40288183712beaa901712c2243390008', NULL, NULL, '12', NULL, NULL, 0, NULL, 0, 0, 'A01', 'admin', '2020-05-24 12:21:22', NULL, NULL, NULL);

-- ----------------------------
-- Table structure for fin_pur_invoice_entry
-- ----------------------------
DROP TABLE IF EXISTS `fin_pur_invoice_entry`;
CREATE TABLE `fin_pur_invoice_entry`  (
  `id` varchar(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT 'ID',
  `mid` varchar(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '主表',
  `bill_no` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '单据编号',
  `entry_no` int(11) NOT NULL COMMENT '分录号',
  `source_type` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '源单类型',
  `source_entry_id` varchar(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '入库分录ID',
  `source_entry_no` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '入库分录号',
  `tax_rate` decimal(10, 4) NULL DEFAULT NULL COMMENT '税率',
  `invoice_no` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '发票号',
  `invoice_date` date NULL DEFAULT NULL COMMENT '开票日期',
  `invoice_qty` decimal(18, 6) NOT NULL COMMENT '发票数量',
  `invoice_amt` decimal(18, 2) NOT NULL COMMENT '开票金额',
  `remark` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '备注',
  `remark2` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '备注2',
  `remark3` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '备注3',
  `version` int(11) NULL DEFAULT NULL COMMENT '版本',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `AK_uk_pur_invoice_entry`(`bill_no`, `entry_no`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '采购发票登记明细' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of fin_pur_invoice_entry
-- ----------------------------
INSERT INTO `fin_pur_invoice_entry` VALUES ('15901292951520394747', '1263506230591504386', 'PUI-20200522-000007', 10, 'stk_io_bill.stk_io_bill_entry', '15860895260730', 'STK-20200402-000001.10', NULL, '1', '2020-05-22', 1.000000, 100.00, '', '', '', NULL);
INSERT INTO `fin_pur_invoice_entry` VALUES ('15901293012811934215', '1263506230591504386', 'PUI-20200522-000007', 20, 'stk_io_bill.stk_io_bill_entry', '15856698893890', 'STK-20200331-000027.10', NULL, '1', '2020-05-22', 1.000000, 100.00, '', '', '', NULL);
INSERT INTO `fin_pur_invoice_entry` VALUES ('15901293012852605293', '1263506230591504386', 'PUI-20200522-000007', 30, 'stk_io_bill.stk_io_bill_entry', '15858319083191', 'STK-20200331-000027.20', NULL, '12', NULL, 1.000000, 100.00, '', '', '', NULL);
INSERT INTO `fin_pur_invoice_entry` VALUES ('15901369967401144503', '1263752608841465858', 'PUI-20200522-000011', 20, 'stk_io_bill.stk_io_bill_entry', '15860895260730', 'STK-20200402-000001.10', NULL, '11', NULL, 1.000000, 0.00, '', '', '', NULL);
INSERT INTO `fin_pur_invoice_entry` VALUES ('15902933171430840576', '1264408029913583618', 'PUI-20200524-000014', 10, 'fin_pur_invoice.fin_pur_invoice_entry', '15901292951520394747', 'undefined.10', NULL, '11', '2020-05-23', -1.000000, -100.00, '', '', '', NULL);
INSERT INTO `fin_pur_invoice_entry` VALUES ('15902940642070638435', '1264411139406991362', 'PUI-20200524-000017', 10, 'fin_pur_invoice.fin_pur_invoice_entry', '15901292951520394747', 'undefined.10', NULL, '1', '2020-05-22', -1.000000, -100.00, '', '', '', NULL);

-- ----------------------------
-- Table structure for fin_receipt
-- ----------------------------
DROP TABLE IF EXISTS `fin_receipt`;
CREATE TABLE `fin_receipt`  (
  `id` varchar(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT 'ID',
  `bill_no` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '单据编号',
  `bill_date` datetime(0) NOT NULL COMMENT '单据日期',
  `receipt_type` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '收款类型',
  `is_rubric` int(3) NOT NULL DEFAULT 0 COMMENT '是否红字',
  `customer_id` varchar(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '客户',
  `amt` decimal(18, 2) NOT NULL COMMENT '金额',
  `checked_amt` decimal(18, 2) NOT NULL COMMENT '已核销金额',
  `deducted_amt` decimal(18, 2) NOT NULL COMMENT '已抵扣预收金额',
  `attachment_id` varchar(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '附件',
  `remark` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '备注',
  `bill_proc_status` varchar(4) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '处理状态',
  `is_approved` int(3) NULL DEFAULT NULL COMMENT '是否通过',
  `is_closed` int(3) NULL DEFAULT NULL COMMENT '是否关闭',
  `is_voided` int(3) NULL DEFAULT NULL COMMENT '是否作废',
  `effective_time` datetime(0) NULL DEFAULT NULL COMMENT '生效时间',
  `approver_id` varchar(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '审核人',
  `flow_id` varchar(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '流程',
  `create_time` datetime(0) NULL DEFAULT NULL COMMENT '创建时间',
  `create_by` varchar(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '创建人',
  `update_by` varchar(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '修改人',
  `version` int(11) NULL DEFAULT NULL COMMENT '版本',
  `update_time` datetime(0) NULL DEFAULT NULL COMMENT '修改时间',
  `sys_org_code` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '创建部门',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `uk_ar_receive_bill`(`bill_no`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '收款单' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of fin_receipt
-- ----------------------------
INSERT INTO `fin_receipt` VALUES ('1256234334313390081', 'REC-20200501-000011', '2020-05-01 00:00:00', '102', 1, '40288183712beaa901712c3b1e6f0009', -100.00, 0.00, 0.00, NULL, NULL, '12', NULL, NULL, NULL, NULL, NULL, NULL, '2020-05-01 00:00:00', 'admin', 'admin', NULL, '2020-05-17 12:02:20', 'A01');
INSERT INTO `fin_receipt` VALUES ('1260049990512340994', 'REC-20200512-000017', '2020-05-27 00:00:00', '101', 0, '40288183712beaa901712c3b1e6f0009', 3000.10, 0.00, 0.00, NULL, NULL, '12', NULL, NULL, NULL, NULL, NULL, NULL, '2020-05-12 00:00:00', 'admin', 'admin', NULL, '2020-05-27 23:59:17', 'A01');
INSERT INTO `fin_receipt` VALUES ('1260393862853648386', 'REC-20200513-000002', '2020-05-13 00:00:00', '199', 1, '40288183712beaa901712c3b1e6f0009', -1000.00, 0.00, 0.00, NULL, NULL, '12', NULL, NULL, NULL, NULL, NULL, NULL, '2020-05-13 00:00:00', 'admin', 'admin', NULL, '2020-06-02 23:58:54', 'A01');

-- ----------------------------
-- Table structure for fin_receipt_entry
-- ----------------------------
DROP TABLE IF EXISTS `fin_receipt_entry`;
CREATE TABLE `fin_receipt_entry`  (
  `id` varchar(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT 'ID',
  `mid` varchar(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '主表',
  `bill_no` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '单据编号',
  `entry_no` int(11) NOT NULL COMMENT '分录号',
  `source_type` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '源单类型',
  `source_entry_id` varchar(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '源单分录id',
  `source_entry_no` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '源单分录号',
  `settle_method` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '结算方式',
  `bank_account_id` varchar(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '资金账户',
  `amt` decimal(18, 2) NULL DEFAULT NULL COMMENT '金额',
  `remark` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '备注',
  `remark2` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '备注2',
  `remark3` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '备注3',
  `version` int(11) NULL DEFAULT NULL COMMENT '版本',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `AK_uk_fin_receipt_entry_no`(`mid`, `entry_no`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '收款单明细' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of fin_receipt_entry
-- ----------------------------
INSERT INTO `fin_receipt_entry` VALUES ('15883445540220', '1256234334313390081', 'REC-20200501-000011', 10, NULL, NULL, '', '21', NULL, -100.00, '', '', '', NULL);
INSERT INTO `fin_receipt_entry` VALUES ('15892542597250253702', '1260049990512340994', 'REC-20200512-000017', 10, NULL, NULL, '', '11', NULL, 1000.10, '', '', '', NULL);
INSERT INTO `fin_receipt_entry` VALUES ('15892542874941815916', '1260049990512340994', 'REC-20200512-000017', 20, NULL, NULL, '', '11', NULL, 2000.00, '', '', '', NULL);
INSERT INTO `fin_receipt_entry` VALUES ('15893362664860203580', '1260393862853648386', 'REC-20200513-000002', 10, NULL, NULL, NULL, '11', NULL, -1000.00, '', '', '', NULL);

-- ----------------------------
-- Table structure for fin_receivable
-- ----------------------------
DROP TABLE IF EXISTS `fin_receivable`;
CREATE TABLE `fin_receivable`  (
  `id` varchar(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT 'ID',
  `bill_no` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '单据编号',
  `bill_date` datetime(0) NOT NULL COMMENT '单据日期',
  `receivable_type` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '应收类型',
  `is_rubric` int(3) NOT NULL DEFAULT 0 COMMENT '是否红字',
  `is_auto` int(3) NOT NULL COMMENT '是否自动生成',
  `source_type` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '源单类型',
  `source_no` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '源单号',
  `source_id` varchar(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '源单id',
  `customer_id` varchar(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '客户',
  `amt` decimal(18, 2) NOT NULL COMMENT '金额',
  `checked_amt` decimal(18, 2) NOT NULL COMMENT '已核销金额',
  `attachment` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '附件',
  `remark` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '备注',
  `bill_proc_status` varchar(4) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '处理状态',
  `is_approved` int(3) NULL DEFAULT NULL COMMENT '是否通过',
  `is_closed` int(3) NULL DEFAULT NULL COMMENT '是否关闭',
  `is_voided` int(3) NULL DEFAULT NULL COMMENT '是否作废',
  `approver_id` varchar(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '审核人',
  `flow_id` varchar(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '流程id',
  `effective_time` datetime(0) NULL DEFAULT NULL COMMENT '生效时间',
  `sys_org_code` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '创建部门',
  `create_by` varchar(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '创建人',
  `create_time` datetime(0) NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '修改人',
  `update_time` datetime(0) NULL DEFAULT NULL COMMENT '修改时间',
  `version` int(11) NULL DEFAULT NULL COMMENT '版本',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `uk_ar_bill_bill`(`bill_no`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '应收单' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of fin_receivable
-- ----------------------------
INSERT INTO `fin_receivable` VALUES ('1', '1', '2020-04-30 21:47:57', '102', 0, 1, NULL, NULL, NULL, '40288183712beaa901712c3b1e6f0009', 1.00, 0.00, NULL, NULL, '12', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `fin_receivable` VALUES ('1259781996149100546', 'RAB-20200511-000001', '2020-05-11 17:46:48', '102', 0, 1, 'stk_io_bill..201', 'STK-20200430-000002', '1255762477564067841', '40288183712beaa901712c3b1e6f0009', 5.00, 0.00, NULL, NULL, '23', 1, 0, 0, 'admin', NULL, '2020-05-11 17:46:48', 'A01', 'admin', '2020-05-11 17:46:48', NULL, NULL, NULL);
INSERT INTO `fin_receivable` VALUES ('1259782157130682370', 'RAB-20200511-000002', '2020-05-11 17:47:27', '102', 0, 1, 'stk_io_bill..201', 'STK-20200430-000002', '1255762477564067841', '40288183712beaa901712c3b1e6f0009', 5.00, 0.00, NULL, NULL, '23', 1, 0, 0, 'admin', NULL, '2020-05-11 17:47:27', 'A01', 'admin', '2020-05-11 17:47:27', NULL, NULL, NULL);
INSERT INTO `fin_receivable` VALUES ('1260387969235701762', 'PAB-20200513-000013', '2020-05-13 00:00:00', '199', 0, 0, NULL, NULL, NULL, '40288183712beaa901712c3b1e6f0009', 10000.00, 0.00, NULL, NULL, '23', 1, NULL, NULL, 'admin', NULL, '2020-05-13 10:09:47', 'A01', 'admin', '2020-05-13 00:00:00', 'admin', '2020-05-13 10:09:47', NULL);
INSERT INTO `fin_receivable` VALUES ('1261871978842087426', 'PAB-20200517-000005', '2020-05-17 00:00:00', '199', 0, 0, NULL, NULL, NULL, '40288183712beaa901712c3b1e6f0009', -1.10, 0.00, NULL, NULL, '12', NULL, NULL, NULL, NULL, NULL, NULL, 'A01', 'admin', '2020-05-17 12:11:39', NULL, NULL, NULL);

-- ----------------------------
-- Table structure for fin_receivable_bal
-- ----------------------------
DROP TABLE IF EXISTS `fin_receivable_bal`;
CREATE TABLE `fin_receivable_bal`  (
  `id` varchar(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT 'ID',
  `year` smallint(6) NOT NULL COMMENT '业务年度',
  `month` tinyint(4) NOT NULL COMMENT '业务月度',
  `customer_id` varchar(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '客户',
  `begin_debit_bal` decimal(18, 2) NOT NULL DEFAULT 0.00 COMMENT '期初借方余额',
  `debit_amt` decimal(18, 2) NOT NULL DEFAULT 0.00 COMMENT '借方金额',
  `credit_amt` decimal(18, 2) NOT NULL DEFAULT 0.00 COMMENT '贷方金额',
  `is_init` tinyint(1) NOT NULL DEFAULT 0 COMMENT '是否初始数据',
  `version` int(11) NULL DEFAULT NULL COMMENT '版本',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `AK_uk_fin_receivable_bal`(`year`, `month`, `customer_id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of fin_receivable_bal
-- ----------------------------
INSERT INTO `fin_receivable_bal` VALUES ('6020fa97544076bcd07dc40ccbfbf50d', 2020, 6, NULL, 10.00, 0.00, 0.00, 0, NULL);
INSERT INTO `fin_receivable_bal` VALUES ('8c91f3290f95fb76aed14f5a0502595b', 2020, 5, NULL, 0.00, 10.00, 0.00, 0, NULL);
INSERT INTO `fin_receivable_bal` VALUES ('8ca6e725fabf31e59d5570d61456b4ca', 2020, 5, '40288183712beaa901712c3b1e6f0009', 0.00, 10.00, 0.00, 0, NULL);
INSERT INTO `fin_receivable_bal` VALUES ('cc4a5db9ce20655d460b72e706bd0325', 2020, 6, '40288183712beaa901712c3b1e6f0009', 10.00, 0.00, 0.00, 0, NULL);

-- ----------------------------
-- Table structure for fin_receivable_check
-- ----------------------------
DROP TABLE IF EXISTS `fin_receivable_check`;
CREATE TABLE `fin_receivable_check`  (
  `id` varchar(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT 'ID',
  `bill_no` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '单据编号',
  `bill_date` date NOT NULL COMMENT '单据日期',
  `receivable_check_type` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '核销类型',
  `customer_id` varchar(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '客户',
  `remark` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '备注',
  `bill_proc_status` varchar(4) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '11' COMMENT '处理状态',
  `is_approved` tinyint(1) NOT NULL DEFAULT 0 COMMENT '是否通过',
  `is_closed` tinyint(1) NOT NULL DEFAULT 0 COMMENT '是否关闭',
  `is_voided` tinyint(1) NOT NULL DEFAULT 0 COMMENT '是否作废',
  `effective_time` datetime(0) NULL DEFAULT NULL COMMENT '生效时间',
  `approver_id` varchar(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '审核人',
  `flow_id` char(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '流程id',
  `create_time` datetime(0) NULL DEFAULT NULL COMMENT '创建时间',
  `create_by` varchar(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '创建人',
  `sys_org_code` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '创建部门',
  `update_time` datetime(0) NULL DEFAULT NULL COMMENT '修改时间',
  `update_by` varchar(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '修改人',
  `version` int(11) NULL DEFAULT NULL COMMENT '版本',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `uk_arp_check_bill`(`bill_no`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '应收核销单' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of fin_receivable_check
-- ----------------------------
INSERT INTO `fin_receivable_check` VALUES ('1265854047193694209', 'RBC-20200528-000001', '2020-05-28', '101', '40288183712beaa901712c3b1e6f0009', NULL, '12', 0, 0, 0, NULL, NULL, NULL, '2020-05-28 00:00:00', 'admin', 'A01', '2020-05-28 15:07:13', 'admin', NULL);

-- ----------------------------
-- Table structure for fin_receivable_check_entry
-- ----------------------------
DROP TABLE IF EXISTS `fin_receivable_check_entry`;
CREATE TABLE `fin_receivable_check_entry`  (
  `id` varchar(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT 'ID',
  `mid` varchar(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '主表',
  `bill_no` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '单据编号',
  `entry_no` int(11) NOT NULL COMMENT '分录号',
  `check_side` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '核销方向',
  `source_type` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '源单类型',
  `source_id` varchar(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '源单id',
  `source_no` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '源单号',
  `amt` decimal(18, 2) NOT NULL COMMENT '核销金额',
  `remark` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '备注',
  `version` int(11) NULL DEFAULT NULL COMMENT '版本',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `uk_arp_check_bill`(`mid`, `entry_no`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '应收核销明细' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of fin_receivable_check_entry
-- ----------------------------
INSERT INTO `fin_receivable_check_entry` VALUES ('1265892142337261570', '1265854047193694209', 'RBC-20200528-000001', 101, '1', 'fin_receivable', '1259782157130682370', 'RAB-20200511-000002', 4.00, NULL, NULL);
INSERT INTO `fin_receivable_check_entry` VALUES ('1265902428209319938', '1265854047193694209', 'RBC-20200528-000001', 102, '1', 'fin_receivable', '1259781996149100546', 'RAB-20200511-000001', 5.00, NULL, NULL);

-- ----------------------------
-- Table structure for fin_rp_check
-- ----------------------------
DROP TABLE IF EXISTS `fin_rp_check`;
CREATE TABLE `fin_rp_check`  (
  `id` varchar(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT 'ID',
  `bill_no` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '单据编号',
  `bill_date` datetime(0) NOT NULL COMMENT '单据日期',
  `rp_check_type` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '核销类型',
  `customer_id` varchar(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '客户',
  `supplier_id` varchar(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '供应商',
  `remark` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '备注',
  `bill_proc_status` varchar(4) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '11' COMMENT '处理状态',
  `is_approved` int(3) NOT NULL DEFAULT 0 COMMENT '是否通过',
  `is_closed` int(3) NOT NULL DEFAULT 0 COMMENT '是否关闭',
  `is_voided` int(3) NOT NULL DEFAULT 0 COMMENT '是否作废',
  `effective_time` datetime(0) NULL DEFAULT NULL COMMENT '生效时间',
  `approver_id` varchar(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '审核人',
  `flow_id` varchar(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '流程id',
  `create_time` datetime(0) NULL DEFAULT NULL COMMENT '创建时间',
  `create_by` varchar(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '创建人',
  `sys_org_code` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '创建部门',
  `update_time` datetime(0) NULL DEFAULT NULL COMMENT '修改时间',
  `update_by` varchar(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '修改人',
  `version` int(11) NULL DEFAULT NULL COMMENT '版本',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `uk_arp_check_bill`(`bill_no`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '往来核销单' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of fin_rp_check
-- ----------------------------
INSERT INTO `fin_rp_check` VALUES ('1', 'CHK-20200419-000001', '2020-04-20 00:00:00', '201', NULL, '40288183712beaa901712c2243390008', 'aaabbbb', '23', 1, 0, 0, '2020-04-27 23:26:47', 'admin', NULL, NULL, NULL, NULL, '2020-04-27 23:26:47', 'admin', NULL);
INSERT INTO `fin_rp_check` VALUES ('1254685070550544385', 'CHK-20200427-000009', '2020-04-27 00:00:00', '201', NULL, '40288183712beaa901712c2243390008', 'bb', '12', 0, 0, 0, NULL, NULL, NULL, '2020-04-27 00:00:00', 'admin', 'A01', '2020-04-29 23:11:11', 'admin', NULL);

-- ----------------------------
-- Table structure for fin_rp_check_entry
-- ----------------------------
DROP TABLE IF EXISTS `fin_rp_check_entry`;
CREATE TABLE `fin_rp_check_entry`  (
  `id` varchar(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT 'ID',
  `mid` varchar(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '主表',
  `bill_no` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '单据号',
  `entry_no` int(11) NOT NULL COMMENT '分录号',
  `rp_check_side` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '核销方向',
  `source_type` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '源单类型',
  `source_id` varchar(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '源单id',
  `source_no` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '源单号',
  `amt` decimal(18, 2) NOT NULL COMMENT '核销金额',
  `remark` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '备注',
  `version` int(11) NULL DEFAULT NULL COMMENT '版本',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `uk_fin_rp_check_entry`(`mid`, `entry_no`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '往来核销明细' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of fin_rp_check_entry
-- ----------------------------
INSERT INTO `fin_rp_check_entry` VALUES ('1255514973873307649', '1254685070550544385', 'CHK-20200427-000009', 101, '1', 'fin_payable', '1249716139872100353', 'PAB-20200413-000004', 80.00, NULL, NULL);
INSERT INTO `fin_rp_check_entry` VALUES ('1255514973890084865', '1254685070550544385', 'CHK-20200427-000009', 102, '1', 'fin_payable', '1249620928153280514', 'PAB-20200413-000003', 100.00, NULL, NULL);
INSERT INTO `fin_rp_check_entry` VALUES ('2', '1', NULL, 102, '1', '1', '1249716139872100353', 'PAB-20200413-000004', 20.00, NULL, NULL);
INSERT INTO `fin_rp_check_entry` VALUES ('3', '1', NULL, 201, '2', '1', '1250440057629110274', 'PAY-20200415-000029', 20.00, NULL, NULL);

-- ----------------------------
-- Table structure for fin_sal_invoice
-- ----------------------------
DROP TABLE IF EXISTS `fin_sal_invoice`;
CREATE TABLE `fin_sal_invoice`  (
  `id` varchar(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT 'ID',
  `bill_no` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '单据编号',
  `bill_date` date NOT NULL COMMENT '单据日期',
  `is_auto` tinyint(1) NOT NULL DEFAULT 0 COMMENT '是否自动生成',
  `invoice_type` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '发票类型',
  `is_rubric` tinyint(1) NOT NULL DEFAULT 0 COMMENT '是否红字',
  `source_type` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '源单类型',
  `source_id` varchar(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '源单id',
  `source_no` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '源单号',
  `clerk_id` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '业务员',
  `customer_id` varchar(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '客户',
  `attachment` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '附件',
  `remark` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '备注',
  `bill_proc_status` varchar(4) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '11' COMMENT '处理状态',
  `approver_id` varchar(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '审核人',
  `flow_id` varchar(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '流程id',
  `is_approved` tinyint(1) NULL DEFAULT 0 COMMENT '是否通过',
  `effective_time` datetime(0) NULL DEFAULT NULL COMMENT '生效时间',
  `is_voided` tinyint(1) NOT NULL DEFAULT 0 COMMENT '是否作废',
  `is_closed` tinyint(1) NOT NULL DEFAULT 0 COMMENT '是否关闭',
  `sys_org_code` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '创建部门',
  `create_by` varchar(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '创建人',
  `create_time` datetime(0) NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '修改人',
  `update_time` datetime(0) NULL DEFAULT NULL COMMENT '修改时间',
  `version` int(11) NULL DEFAULT NULL COMMENT '版本',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `uk_iinvoice`(`bill_no`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '销售发票登记' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of fin_sal_invoice
-- ----------------------------
INSERT INTO `fin_sal_invoice` VALUES ('1264478805966639106', 'SAI-20200524-000003', '2020-05-24', 0, '11', 0, NULL, NULL, NULL, NULL, '40288183712beaa901712c3b1e6f0009', NULL, NULL, '23', 'admin', NULL, 1, '2020-05-24 16:50:35', 0, 0, 'A01', 'admin', '2020-05-24 00:00:00', 'admin', '2020-05-24 16:50:35', NULL);
INSERT INTO `fin_sal_invoice` VALUES ('1264484454146428929', 'SAI-20200524-000004', '2020-05-24', 0, NULL, 1, 'fin_sal_invoice', '1264478805966639106', 'SAI-20200524-000003', NULL, '40288183712beaa901712c3b1e6f0009', NULL, NULL, '23', 'admin', NULL, 1, '2020-05-24 17:13:04', 0, 0, 'A01', 'admin', '2020-05-24 17:12:42', 'admin', '2020-05-24 17:13:04', NULL);

-- ----------------------------
-- Table structure for fin_sal_invoice_entry
-- ----------------------------
DROP TABLE IF EXISTS `fin_sal_invoice_entry`;
CREATE TABLE `fin_sal_invoice_entry`  (
  `id` varchar(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT 'ID',
  `mid` varchar(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '主表',
  `bill_no` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '单据编号',
  `entry_no` int(11) NOT NULL COMMENT '分录号',
  `source_type` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '源单类型',
  `source_entry_id` varchar(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '源单分录id',
  `source_entry_no` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '源单分录号',
  `tax_rate` decimal(10, 4) NULL DEFAULT NULL COMMENT '税率',
  `invoice_no` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '发票号',
  `invoice_date` date NULL DEFAULT NULL COMMENT '开票日期',
  `invoice_qty` decimal(18, 6) NOT NULL COMMENT '发票数量',
  `invoice_amt` decimal(18, 2) NOT NULL COMMENT '开票金额',
  `remark` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '备注',
  `remark2` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '备注2',
  `remark3` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '备注3',
  `version` int(11) NULL DEFAULT NULL COMMENT '版本',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `AK_uk_sal_invoice_entry`(`bill_no`, `entry_no`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '销售发票登记明细' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of fin_sal_invoice_entry
-- ----------------------------
INSERT INTO `fin_sal_invoice_entry` VALUES ('15903101779810534815', '1264478805966639106', 'SAI-20200524-000003', 10, 'stk_io_bill.stk_io_bill_entry', '15889121955981144830', 'STK-20200430-000002.20', NULL, '1', '2020-05-24', 1.000000, 0.50, '', '', '', NULL);
INSERT INTO `fin_sal_invoice_entry` VALUES ('15903115436460250611', '1264484454146428929', 'SAI-20200524-000004', 10, 'fin_sal_invoice.fin_sal_invoice_entry', '15903101779810534815', 'SAI-20200524-000003.10', NULL, '12', NULL, -1.000000, -0.50, '', '', '', NULL);

-- ----------------------------
-- Table structure for jeecg_monthly_growth_analysis
-- ----------------------------
DROP TABLE IF EXISTS `jeecg_monthly_growth_analysis`;
CREATE TABLE `jeecg_monthly_growth_analysis`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `year` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `month` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '月份',
  `main_income` decimal(18, 2) NULL DEFAULT 0.00 COMMENT '佣金/主营收入',
  `other_income` decimal(18, 2) NULL DEFAULT 0.00 COMMENT '其他收入',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 25 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of jeecg_monthly_growth_analysis
-- ----------------------------
INSERT INTO `jeecg_monthly_growth_analysis` VALUES (1, '2018', '1月', 114758.90, 4426054.19);
INSERT INTO `jeecg_monthly_growth_analysis` VALUES (2, '2018', '2月', 8970734.12, 1230188.67);
INSERT INTO `jeecg_monthly_growth_analysis` VALUES (3, '2018', '3月', 26755421.23, 2048836.84);
INSERT INTO `jeecg_monthly_growth_analysis` VALUES (4, '2018', '4月', 2404990.63, 374171.44);
INSERT INTO `jeecg_monthly_growth_analysis` VALUES (5, '2018', '5月', 5450793.02, 502306.10);
INSERT INTO `jeecg_monthly_growth_analysis` VALUES (6, '2018', '6月', 17186212.11, 1375154.97);
INSERT INTO `jeecg_monthly_growth_analysis` VALUES (7, '2018', '7月', 579975.67, 461483.99);
INSERT INTO `jeecg_monthly_growth_analysis` VALUES (8, '2018', '8月', 1393590.06, 330403.76);
INSERT INTO `jeecg_monthly_growth_analysis` VALUES (9, '2018', '9月', 735761.21, 1647474.92);
INSERT INTO `jeecg_monthly_growth_analysis` VALUES (10, '2018', '10月', 1670442.44, 3423368.33);
INSERT INTO `jeecg_monthly_growth_analysis` VALUES (11, '2018', '11月', 2993130.34, 3552024.00);
INSERT INTO `jeecg_monthly_growth_analysis` VALUES (12, '2018', '12月', 4206227.26, 3645614.92);
INSERT INTO `jeecg_monthly_growth_analysis` VALUES (13, '2019', '1月', 483834.66, 418046.77);
INSERT INTO `jeecg_monthly_growth_analysis` VALUES (14, '2019', '2月', 11666578.65, 731352.20);
INSERT INTO `jeecg_monthly_growth_analysis` VALUES (15, '2019', '3月', 27080982.08, 1878538.81);
INSERT INTO `jeecg_monthly_growth_analysis` VALUES (16, '2019', '4月', 0.00, 0.00);
INSERT INTO `jeecg_monthly_growth_analysis` VALUES (17, '2019', '5月', 0.00, 0.00);
INSERT INTO `jeecg_monthly_growth_analysis` VALUES (18, '2019', '6月', 0.00, 0.00);
INSERT INTO `jeecg_monthly_growth_analysis` VALUES (19, '2019', '7月', 0.00, 0.00);
INSERT INTO `jeecg_monthly_growth_analysis` VALUES (20, '2019', '8月', 0.00, 0.00);
INSERT INTO `jeecg_monthly_growth_analysis` VALUES (21, '2019', '9月', 0.00, 0.00);
INSERT INTO `jeecg_monthly_growth_analysis` VALUES (22, '2019', '10月', 0.00, 0.00);
INSERT INTO `jeecg_monthly_growth_analysis` VALUES (23, '2019', '11月', 0.00, 0.00);
INSERT INTO `jeecg_monthly_growth_analysis` VALUES (24, '2019', '12月', 0.00, 0.00);

-- ----------------------------
-- Table structure for jeecg_order_customer
-- ----------------------------
DROP TABLE IF EXISTS `jeecg_order_customer`;
CREATE TABLE `jeecg_order_customer`  (
  `id` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '主键',
  `name` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '客户名',
  `sex` varchar(4) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '性别',
  `idcard` varchar(18) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '身份证号码',
  `idcard_pic` varchar(500) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '身份证扫描件',
  `telphone` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '电话1',
  `order_id` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '外键',
  `create_by` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '创建人',
  `create_time` datetime(0) NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '修改人',
  `update_time` datetime(0) NULL DEFAULT NULL COMMENT '修改时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of jeecg_order_customer
-- ----------------------------
INSERT INTO `jeecg_order_customer` VALUES ('15538561502720', '3333', '1', '', NULL, '', '0d4a2e67b538ee1bc881e5ed34f670f0', 'jeecg-boot', '2019-03-29 18:42:55', NULL, NULL);
INSERT INTO `jeecg_order_customer` VALUES ('15538561512681', '3332333', '2', '', NULL, '', '0d4a2e67b538ee1bc881e5ed34f670f0', 'jeecg-boot', '2019-03-29 18:42:55', 'admin', '2019-03-29 18:43:12');
INSERT INTO `jeecg_order_customer` VALUES ('15538561550142', '4442', '2', '', NULL, '', '0d4a2e67b538ee1bc881e5ed34f670f0', 'jeecg-boot', '2019-03-29 18:42:55', NULL, NULL);
INSERT INTO `jeecg_order_customer` VALUES ('15541168497342', '444', '', '', '', '', 'f71f7f8930b5b6b1703d9948d189982b', 'admin', '2019-04-01 19:08:45', NULL, NULL);
INSERT INTO `jeecg_order_customer` VALUES ('15541168499553', '5555', '', '', '', '', 'f71f7f8930b5b6b1703d9948d189982b', 'admin', '2019-04-01 19:08:45', NULL, NULL);
INSERT INTO `jeecg_order_customer` VALUES ('15541169272690', '小王1', '1', '', '', '18611788525', 'f618a85b17e2c4dd58d268220c8dd9a1', 'admin', '2019-04-01 19:10:07', NULL, NULL);
INSERT INTO `jeecg_order_customer` VALUES ('15541169288141', '效力1', '1', '', '', '18611788525', 'f618a85b17e2c4dd58d268220c8dd9a1', 'admin', '2019-04-01 19:10:07', NULL, NULL);
INSERT INTO `jeecg_order_customer` VALUES ('15541169441372', '小红1', '1', '', '', '18611788525', 'f618a85b17e2c4dd58d268220c8dd9a1', 'admin', '2019-04-01 19:10:07', NULL, NULL);
INSERT INTO `jeecg_order_customer` VALUES ('15543695362380', '1111', '', '', '', '', '5d6e2b9e44037526270b6206196f6689', 'admin', '2019-04-04 17:19:40', NULL, NULL);
INSERT INTO `jeecg_order_customer` VALUES ('15543695397221', '222', '', '', '', '', '5d6e2b9e44037526270b6206196f6689', 'admin', '2019-04-04 17:19:40', NULL, NULL);
INSERT INTO `jeecg_order_customer` VALUES ('15543695398992', '333', '', '', '', '', '5d6e2b9e44037526270b6206196f6689', 'admin', '2019-04-04 17:19:40', NULL, NULL);
INSERT INTO `jeecg_order_customer` VALUES ('18dc5eb1068ccdfe90e358951ca1a3d6', 'dr2', '', '', '', '', '8ab1186410a65118c4d746eb085d3bed', 'admin', '2019-04-04 17:25:33', NULL, NULL);
INSERT INTO `jeecg_order_customer` VALUES ('195d280490fe88ca1475512ddcaf2af9', '12', NULL, NULL, NULL, NULL, '54e739bef5b67569c963c38da52581ec', 'admin', '2019-03-15 16:50:15', NULL, NULL);
INSERT INTO `jeecg_order_customer` VALUES ('217a2bf83709775d2cd85bf598392327', '2', NULL, NULL, NULL, NULL, '54e739bef5b67569c963c38da52581ec', 'admin', '2019-03-15 16:50:15', NULL, NULL);
INSERT INTO `jeecg_order_customer` VALUES ('22bc052ae53ed09913b946abba93fa89', '1', NULL, NULL, NULL, NULL, '54e739bef5b67569c963c38da52581ec', 'admin', '2019-03-15 16:50:15', NULL, NULL);
INSERT INTO `jeecg_order_customer` VALUES ('23bafeae88126c3bf3322a29a04f0d5e', 'x秦风', NULL, NULL, NULL, NULL, '163e2efcbc6d7d54eb3f8a137da8a75a', 'jeecg-boot', '2019-03-29 18:43:59', NULL, NULL);
INSERT INTO `jeecg_order_customer` VALUES ('25c4a552c6843f36fad6303bfa99a382', '1', NULL, NULL, NULL, NULL, '54e739bef5b67569c963c38da52581ec', 'admin', '2019-03-15 16:50:15', NULL, NULL);
INSERT INTO `jeecg_order_customer` VALUES ('2d32144e2bee63264f3f16215c258381', '33333', '2', NULL, NULL, NULL, 'd908bfee3377e946e59220c4a4eb414a', 'admin', '2019-04-01 16:27:03', NULL, NULL);
INSERT INTO `jeecg_order_customer` VALUES ('2d43170d6327f941bd1a017999495e25', '1', NULL, NULL, NULL, NULL, '54e739bef5b67569c963c38da52581ec', 'admin', '2019-03-15 16:50:15', NULL, NULL);
INSERT INTO `jeecg_order_customer` VALUES ('2e5f62a8b6e0a0ce19b52a6feae23d48', '3', NULL, NULL, NULL, NULL, '54e739bef5b67569c963c38da52581ec', 'admin', '2019-03-15 16:50:15', NULL, NULL);
INSERT INTO `jeecg_order_customer` VALUES ('313abf99558ac5f13ecca3b87e562ad1', 'scott', '2', NULL, NULL, NULL, 'b190737bd04cca8360e6f87c9ef9ec4e', 'admin', '2019-02-25 16:29:48', NULL, NULL);
INSERT INTO `jeecg_order_customer` VALUES ('34a1c5cf6cee360ed610ed0bed70e0f9', '导入秦风', NULL, NULL, NULL, NULL, 'a2cce75872cc8fcc47f78de9ffd378c2', 'jeecg-boot', '2019-03-29 18:43:59', NULL, NULL);
INSERT INTO `jeecg_order_customer` VALUES ('3c87400f8109b4cf43c5598f0d40e34d', '2', NULL, NULL, NULL, NULL, '54e739bef5b67569c963c38da52581ec', 'admin', '2019-03-15 16:50:15', NULL, NULL);
INSERT INTO `jeecg_order_customer` VALUES ('40964bcbbecb38e5ac15e6d08cf3cd43', '233', NULL, NULL, NULL, NULL, '54e739bef5b67569c963c38da52581ec', 'admin', '2019-03-15 16:50:15', NULL, NULL);
INSERT INTO `jeecg_order_customer` VALUES ('41e3dee0b0b6e6530eccb7fbb22fd7a3', '4555', '1', '370285198602058823', NULL, '18611788674', '54e739bef5b67569c963c38da52581ec', 'admin', '2019-03-15 16:50:15', NULL, NULL);
INSERT INTO `jeecg_order_customer` VALUES ('4808ae8344c7679a4a2f461db5dc3a70', '44', '1', '370285198602058823', NULL, '18611788674', '54e739bef5b67569c963c38da52581ec', 'admin', '2019-03-15 16:50:15', NULL, NULL);
INSERT INTO `jeecg_order_customer` VALUES ('4b6cef12f195fad94d57279b2241770d', 'dr12', '', '', '', '', '8ab1186410a65118c4d746eb085d3bed', 'admin', '2019-04-04 17:25:33', NULL, NULL);
INSERT INTO `jeecg_order_customer` VALUES ('524e695283f8e8c256cc24f39d6d8542', '小王', '2', '370285198604033222', NULL, '18611788674', 'eb13ab35d2946a2b0cfe3452bca1e73f', 'admin', '2019-02-25 16:29:41', NULL, NULL);
INSERT INTO `jeecg_order_customer` VALUES ('57c2a8367db34016114cbc9fa368dba0', '2', NULL, NULL, NULL, NULL, '54e739bef5b67569c963c38da52581ec', 'admin', '2019-03-15 16:50:15', NULL, NULL);
INSERT INTO `jeecg_order_customer` VALUES ('5df36a1608b8c7ac99ad9bc408fe54bf', '4', NULL, NULL, NULL, NULL, '54e739bef5b67569c963c38da52581ec', 'admin', '2019-03-15 16:50:15', NULL, NULL);
INSERT INTO `jeecg_order_customer` VALUES ('6b694e9ba54bb289ae9cc499e40031e7', 'x秦风', '1', NULL, NULL, NULL, 'b190737bd04cca8360e6f87c9ef9ec4e', 'admin', '2019-02-25 16:29:48', NULL, NULL);
INSERT INTO `jeecg_order_customer` VALUES ('6c6fd2716c2dcd044ed03c2c95d261f8', '李四', '2', '370285198602058833', '', '18611788676', 'f71f7f8930b5b6b1703d9948d189982b', 'admin', '2019-04-01 19:08:45', NULL, NULL);
INSERT INTO `jeecg_order_customer` VALUES ('742d008214dee0afff2145555692973e', '秦风', '1', '370285198602058822', NULL, '18611788676', '54e739bef5b67569c963c38da52581ec', 'admin', '2019-03-15 16:50:15', NULL, NULL);
INSERT INTO `jeecg_order_customer` VALUES ('7469c3e5d371767ff90a739d297689b5', '导入秦风', '2', NULL, NULL, NULL, '3a867ebf2cebce9bae3f79676d8d86f3', 'jeecg-boot', '2019-03-29 18:43:59', 'admin', '2019-04-08 17:35:02');
INSERT INTO `jeecg_order_customer` VALUES ('7a96e2c7b24847d4a29940dbc0eda6e5', 'drscott', NULL, NULL, NULL, NULL, 'e73434dad84ebdce2d4e0c2a2f06d8ea', 'jeecg-boot', '2019-03-29 18:43:59', NULL, NULL);
INSERT INTO `jeecg_order_customer` VALUES ('7f5a40818e225ee18bda6da7932ac5f9', '2', NULL, NULL, NULL, NULL, '54e739bef5b67569c963c38da52581ec', 'admin', '2019-03-15 16:50:15', NULL, NULL);
INSERT INTO `jeecg_order_customer` VALUES ('8011575abfd7c8085e71ff66df1124b9', '1', NULL, NULL, NULL, NULL, '54e739bef5b67569c963c38da52581ec', 'admin', '2019-03-15 16:50:15', NULL, NULL);
INSERT INTO `jeecg_order_customer` VALUES ('8404f31d7196221a573c9bd6c8f15003', '小张', '1', '370285198602058211', NULL, '18611788676', 'eb13ab35d2946a2b0cfe3452bca1e73f', 'admin', '2019-02-25 16:29:41', NULL, NULL);
INSERT INTO `jeecg_order_customer` VALUES ('859020e10a2f721f201cdbff78cf7b9f', 'scott', NULL, NULL, NULL, NULL, '163e2efcbc6d7d54eb3f8a137da8a75a', 'jeecg-boot', '2019-03-29 18:43:59', NULL, NULL);
INSERT INTO `jeecg_order_customer` VALUES ('8cc3c4d26e3060975df3a2adb781eeb4', 'dr33', NULL, NULL, NULL, NULL, 'b2feb454e43c46b2038768899061e464', 'jeecg-boot', '2019-04-04 17:23:09', NULL, NULL);
INSERT INTO `jeecg_order_customer` VALUES ('8d1725c23a6a50685ff0dedfd437030d', '4', NULL, NULL, NULL, NULL, '54e739bef5b67569c963c38da52581ec', 'admin', '2019-03-15 16:50:15', NULL, NULL);
INSERT INTO `jeecg_order_customer` VALUES ('933cae3a79f60a93922d59aace5346ce', '小王', NULL, '370285198604033222', NULL, '18611788674', '6a719071a29927a14f19482f8693d69a', 'jeecg-boot', '2019-03-29 18:43:59', NULL, NULL);
INSERT INTO `jeecg_order_customer` VALUES ('9bdb5400b709ba4eaf3444de475880d7', 'dr22', NULL, NULL, NULL, NULL, '22c17790dcd04b296c4a2a089f71895f', 'jeecg-boot', '2019-04-04 17:23:09', NULL, NULL);
INSERT INTO `jeecg_order_customer` VALUES ('9f87677f70e5f864679314389443a3eb', '33', '2', '370285198602058823', NULL, '18611788674', '54e739bef5b67569c963c38da52581ec', 'admin', '2019-03-15 16:50:15', NULL, NULL);
INSERT INTO `jeecg_order_customer` VALUES ('a2c2b7101f75c02deb328ba777137897', '44', '2', '370285198602058823', NULL, '18611788674', '54e739bef5b67569c963c38da52581ec', 'admin', '2019-03-15 16:50:15', NULL, NULL);
INSERT INTO `jeecg_order_customer` VALUES ('ab4d002dc552c326147e318c87d3bed4', 'ddddd', '1', '370285198604033222', NULL, '18611755848', '9a57c850e4f68cf94ef7d8585dbaf7e6', 'admin', '2019-04-04 17:30:47', 'admin', '2019-04-04 17:31:17');
INSERT INTO `jeecg_order_customer` VALUES ('ad116f722a438e5f23095a0b5fcc8e89', 'dr秦风', NULL, NULL, NULL, NULL, 'e73434dad84ebdce2d4e0c2a2f06d8ea', 'jeecg-boot', '2019-03-29 18:43:59', NULL, NULL);
INSERT INTO `jeecg_order_customer` VALUES ('b1ba147b75f5eaa48212586097fc3fd1', '2', NULL, NULL, NULL, NULL, '54e739bef5b67569c963c38da52581ec', 'admin', '2019-03-15 16:50:15', NULL, NULL);
INSERT INTO `jeecg_order_customer` VALUES ('b43bf432c251f0e6b206e403b8ec29bc', 'lisi', NULL, NULL, NULL, NULL, 'f8889aaef6d1bccffd98d2889c0aafb5', 'jeecg-boot', '2019-03-29 18:43:59', NULL, NULL);
INSERT INTO `jeecg_order_customer` VALUES ('bcdd300a7d44c45a66bdaac14903c801', '33', NULL, NULL, NULL, NULL, '54e739bef5b67569c963c38da52581ec', 'admin', '2019-03-15 16:50:15', NULL, NULL);
INSERT INTO `jeecg_order_customer` VALUES ('beb983293e47e2dc1a9b3d649aa3eb34', 'ddd3', NULL, NULL, NULL, NULL, 'd908bfee3377e946e59220c4a4eb414a', 'admin', '2019-04-01 16:27:03', NULL, NULL);
INSERT INTO `jeecg_order_customer` VALUES ('c219808196406f1b8c7f1062589de4b5', '44', '1', '370285198602058823', NULL, '18611788674', '54e739bef5b67569c963c38da52581ec', 'admin', '2019-03-15 16:50:15', NULL, NULL);
INSERT INTO `jeecg_order_customer` VALUES ('c8ed061d4b27c0c7a64e100f2b1c8ab5', '张经理', '2', '370285198602058823', NULL, '18611788674', '54e739bef5b67569c963c38da52581ec', 'admin', '2019-03-15 16:50:15', NULL, NULL);
INSERT INTO `jeecg_order_customer` VALUES ('cc5de4af7f06cd6d250965ebe92a0395', '1', NULL, NULL, NULL, NULL, '54e739bef5b67569c963c38da52581ec', 'admin', '2019-03-15 16:50:15', NULL, NULL);
INSERT INTO `jeecg_order_customer` VALUES ('cf8817bd703bf7c7c77a2118edc26cc7', '1', NULL, NULL, NULL, NULL, '54e739bef5b67569c963c38da52581ec', 'admin', '2019-03-15 16:50:15', NULL, NULL);
INSERT INTO `jeecg_order_customer` VALUES ('d72b26fae42e71270fce2097a88da58a', '导入scott', NULL, 'www', NULL, NULL, '3a867ebf2cebce9bae3f79676d8d86f3', 'jeecg-boot', '2019-03-29 18:43:59', 'admin', '2019-04-08 17:35:05');
INSERT INTO `jeecg_order_customer` VALUES ('dbdc60a6ac1a8c43f24afee384039b68', 'xiaowang', NULL, NULL, NULL, NULL, 'f8889aaef6d1bccffd98d2889c0aafb5', 'jeecg-boot', '2019-03-29 18:43:59', NULL, NULL);
INSERT INTO `jeecg_order_customer` VALUES ('dc5883b50466de94d900919ed96d97af', '33', '1', '370285198602058823', NULL, '18611788674', '54e739bef5b67569c963c38da52581ec', 'admin', '2019-03-15 16:50:15', NULL, NULL);
INSERT INTO `jeecg_order_customer` VALUES ('deeb73e553ad8dc0a0b3cfd5a338de8e', '3333', NULL, NULL, NULL, NULL, '54e739bef5b67569c963c38da52581ec', 'admin', '2019-03-15 16:50:15', NULL, NULL);
INSERT INTO `jeecg_order_customer` VALUES ('e2570278bf189ac05df3673231326f47', '1', NULL, NULL, NULL, NULL, '54e739bef5b67569c963c38da52581ec', 'admin', '2019-03-15 16:50:15', NULL, NULL);
INSERT INTO `jeecg_order_customer` VALUES ('e39cb23bb950b2bdedfc284686c6128a', '1', NULL, NULL, NULL, NULL, '54e739bef5b67569c963c38da52581ec', 'admin', '2019-03-15 16:50:15', NULL, NULL);
INSERT INTO `jeecg_order_customer` VALUES ('e46fe9111a9100844af582a18a2aa402', '1', NULL, NULL, NULL, NULL, '54e739bef5b67569c963c38da52581ec', 'admin', '2019-03-15 16:50:15', NULL, NULL);
INSERT INTO `jeecg_order_customer` VALUES ('ee7af0acb9beb9bf8d8b3819a8a7fdc3', '2', NULL, NULL, NULL, NULL, '54e739bef5b67569c963c38da52581ec', 'admin', '2019-03-15 16:50:15', NULL, NULL);
INSERT INTO `jeecg_order_customer` VALUES ('f5d2605e844192d9e548f9bd240ac908', '小张', NULL, '370285198602058211', NULL, '18611788676', '6a719071a29927a14f19482f8693d69a', 'jeecg-boot', '2019-03-29 18:43:59', NULL, NULL);
INSERT INTO `jeecg_order_customer` VALUES ('f6db6547382126613a3e46e7cd58a5f2', '导入scott', NULL, NULL, NULL, NULL, 'a2cce75872cc8fcc47f78de9ffd378c2', 'jeecg-boot', '2019-03-29 18:43:59', NULL, NULL);

-- ----------------------------
-- Table structure for jeecg_order_main
-- ----------------------------
DROP TABLE IF EXISTS `jeecg_order_main`;
CREATE TABLE `jeecg_order_main`  (
  `id` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '主键',
  `order_code` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '订单号',
  `ctype` varchar(500) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '订单类型',
  `order_date` datetime(0) NULL DEFAULT NULL COMMENT '订单日期',
  `order_money` double(10, 3) NULL DEFAULT NULL COMMENT '订单金额',
  `content` varchar(500) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '订单备注',
  `create_by` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '创建人',
  `create_time` datetime(0) NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '修改人',
  `update_time` datetime(0) NULL DEFAULT NULL COMMENT '修改时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of jeecg_order_main
-- ----------------------------
INSERT INTO `jeecg_order_main` VALUES ('163e2efcbc6d7d54eb3f8a137da8a75a', 'B100', NULL, NULL, 3000.000, NULL, 'jeecg-boot', '2019-03-29 18:43:59', NULL, NULL);
INSERT INTO `jeecg_order_main` VALUES ('3a867ebf2cebce9bae3f79676d8d86f3', '导入B100', '2222', NULL, 3000.000, NULL, 'jeecg-boot', '2019-03-29 18:43:59', 'admin', '2019-04-08 17:35:13');
INSERT INTO `jeecg_order_main` VALUES ('4bca3ea6881d39dbf67ef1e42c649766', '1212', NULL, NULL, NULL, NULL, 'admin', '2019-04-03 10:55:43', NULL, NULL);
INSERT INTO `jeecg_order_main` VALUES ('4cba137333127e8e31df7ad168cc3732', '青岛订单A0001', '2', '2019-04-03 10:56:07', NULL, NULL, 'admin', '2019-04-03 10:56:11', NULL, NULL);
INSERT INTO `jeecg_order_main` VALUES ('54e739bef5b67569c963c38da52581ec', 'NC911', '1', '2019-02-18 09:58:51', 40.000, NULL, 'admin', '2019-02-18 09:58:47', 'admin', '2019-02-18 09:58:59');
INSERT INTO `jeecg_order_main` VALUES ('5d6e2b9e44037526270b6206196f6689', 'N333', NULL, '2019-04-04 17:19:11', NULL, '聪明00', 'admin', '2019-04-04 17:19:40', NULL, NULL);
INSERT INTO `jeecg_order_main` VALUES ('6a719071a29927a14f19482f8693d69a', 'c100', NULL, NULL, 5000.000, NULL, 'jeecg-boot', '2019-03-29 18:43:59', NULL, NULL);
INSERT INTO `jeecg_order_main` VALUES ('8ab1186410a65118c4d746eb085d3bed', '导入400', '1', '2019-02-18 09:58:51', 40.000, NULL, 'admin', '2019-02-18 09:58:47', 'admin', '2019-02-18 09:58:59');
INSERT INTO `jeecg_order_main` VALUES ('9a57c850e4f68cf94ef7d8585dbaf7e6', 'halou100dd', NULL, '2019-04-04 17:30:32', NULL, NULL, 'admin', '2019-04-04 17:30:41', 'admin', '2019-04-04 17:31:08');
INSERT INTO `jeecg_order_main` VALUES ('a2cce75872cc8fcc47f78de9ffd378c2', '导入B100', NULL, NULL, 3000.000, NULL, 'jeecg-boot', '2019-03-29 18:43:59', NULL, NULL);
INSERT INTO `jeecg_order_main` VALUES ('b190737bd04cca8360e6f87c9ef9ec4e', 'B0018888', '1', NULL, NULL, NULL, 'admin', '2019-02-15 18:39:29', 'admin', '2019-02-15 18:39:37');
INSERT INTO `jeecg_order_main` VALUES ('d908bfee3377e946e59220c4a4eb414a', 'SSSS001', NULL, NULL, 599.000, NULL, 'admin', '2019-04-01 15:43:03', 'admin', '2019-04-01 16:26:52');
INSERT INTO `jeecg_order_main` VALUES ('e73434dad84ebdce2d4e0c2a2f06d8ea', '导入200', NULL, NULL, 3000.000, NULL, 'jeecg-boot', '2019-03-29 18:43:59', NULL, NULL);
INSERT INTO `jeecg_order_main` VALUES ('eb13ab35d2946a2b0cfe3452bca1e73f', 'BJ9980', '1', NULL, 90.000, NULL, 'admin', '2019-02-16 17:36:42', 'admin', '2019-02-16 17:46:16');
INSERT INTO `jeecg_order_main` VALUES ('f618a85b17e2c4dd58d268220c8dd9a1', 'N001', NULL, '2019-04-01 19:09:02', 2222.000, NULL, 'admin', '2019-04-01 19:09:47', 'admin', '2019-04-01 19:10:00');
INSERT INTO `jeecg_order_main` VALUES ('f71f7f8930b5b6b1703d9948d189982b', 'BY911', NULL, '2019-04-06 19:08:39', NULL, NULL, 'admin', '2019-04-01 16:36:02', 'admin', '2019-04-01 16:36:08');
INSERT INTO `jeecg_order_main` VALUES ('f8889aaef6d1bccffd98d2889c0aafb5', 'A100', NULL, '2018-10-10 00:00:00', 6000.000, NULL, 'jeecg-boot', '2019-03-29 18:43:59', NULL, NULL);
INSERT INTO `jeecg_order_main` VALUES ('fe81ee5d19bbf9eef2066d4f29dfbe0f', 'uuuu', NULL, NULL, NULL, NULL, 'jeecg-boot', '2019-04-03 11:00:39', NULL, NULL);

-- ----------------------------
-- Table structure for jeecg_order_ticket
-- ----------------------------
DROP TABLE IF EXISTS `jeecg_order_ticket`;
CREATE TABLE `jeecg_order_ticket`  (
  `id` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '主键',
  `ticket_code` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '航班号',
  `tickect_date` datetime(0) NULL DEFAULT NULL COMMENT '航班时间',
  `order_id` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '外键',
  `create_by` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '创建人',
  `create_time` datetime(0) NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '修改人',
  `update_time` datetime(0) NULL DEFAULT NULL COMMENT '修改时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of jeecg_order_ticket
-- ----------------------------
INSERT INTO `jeecg_order_ticket` VALUES ('0f0e3a40a215958f807eea08a6e1ac0a', '88', NULL, '54e739bef5b67569c963c38da52581ec', 'admin', '2019-03-15 16:50:15', NULL, NULL);
INSERT INTO `jeecg_order_ticket` VALUES ('0fa3bd0bbcf53650c0bb3c0cac6d8cb7', 'ffff', '2019-02-21 00:00:00', 'eb13ab35d2946a2b0cfe3452bca1e73f', 'admin', '2019-02-25 16:29:41', NULL, NULL);
INSERT INTO `jeecg_order_ticket` VALUES ('14221afb4f5f749c1deef26ac56fdac3', '33', '2019-03-09 00:00:00', '54e739bef5b67569c963c38da52581ec', 'admin', '2019-03-15 16:50:15', NULL, NULL);
INSERT INTO `jeecg_order_ticket` VALUES ('15538561502730', '222', NULL, '0d4a2e67b538ee1bc881e5ed34f670f0', 'jeecg-boot', '2019-03-29 18:42:55', NULL, NULL);
INSERT INTO `jeecg_order_ticket` VALUES ('15538561526461', '2244', '2019-03-29 00:00:00', '0d4a2e67b538ee1bc881e5ed34f670f0', 'jeecg-boot', '2019-03-29 18:42:55', 'admin', '2019-03-29 18:43:26');
INSERT INTO `jeecg_order_ticket` VALUES ('15541168478913', 'hhhhh', NULL, 'f71f7f8930b5b6b1703d9948d189982b', 'admin', '2019-04-01 19:08:45', NULL, NULL);
INSERT INTO `jeecg_order_ticket` VALUES ('15541169272810', '22211', '2019-04-01 19:09:40', 'f618a85b17e2c4dd58d268220c8dd9a1', 'admin', '2019-04-01 19:10:07', NULL, NULL);
INSERT INTO `jeecg_order_ticket` VALUES ('15541169302331', '333311', '2019-04-01 19:09:40', 'f618a85b17e2c4dd58d268220c8dd9a1', 'admin', '2019-04-01 19:10:07', NULL, NULL);
INSERT INTO `jeecg_order_ticket` VALUES ('15541169713092', '333311', '2019-04-01 19:09:47', 'f618a85b17e2c4dd58d268220c8dd9a1', 'admin', '2019-04-01 19:10:07', NULL, NULL);
INSERT INTO `jeecg_order_ticket` VALUES ('15542604293170', 'c', NULL, 'fe81ee5d19bbf9eef2066d4f29dfbe0f', 'jeecg-boot', '2019-04-03 11:00:39', NULL, NULL);
INSERT INTO `jeecg_order_ticket` VALUES ('15542604374431', 'd', NULL, 'fe81ee5d19bbf9eef2066d4f29dfbe0f', 'jeecg-boot', '2019-04-03 11:00:39', NULL, NULL);
INSERT INTO `jeecg_order_ticket` VALUES ('15543695362380', 'ccc2', NULL, '5d6e2b9e44037526270b6206196f6689', 'admin', '2019-04-04 17:19:40', NULL, NULL);
INSERT INTO `jeecg_order_ticket` VALUES ('15543695381291', 'cccc1', NULL, '5d6e2b9e44037526270b6206196f6689', 'admin', '2019-04-04 17:19:40', NULL, NULL);
INSERT INTO `jeecg_order_ticket` VALUES ('15543695740352', 'dddd', NULL, '5d6e2b9e44037526270b6206196f6689', 'admin', '2019-04-04 17:19:40', NULL, NULL);
INSERT INTO `jeecg_order_ticket` VALUES ('18905bc89ee3851805aab38ed3b505ec', '44', NULL, '54e739bef5b67569c963c38da52581ec', 'admin', '2019-03-15 16:50:15', NULL, NULL);
INSERT INTO `jeecg_order_ticket` VALUES ('1f809cbd26f4e574697e1c10de575d72', 'A100', NULL, 'e73434dad84ebdce2d4e0c2a2f06d8ea', 'jeecg-boot', '2019-03-29 18:43:59', NULL, NULL);
INSERT INTO `jeecg_order_ticket` VALUES ('21051adb51529bdaa8798b5a3dd7f7f7', 'C10029', '2019-02-20 00:00:00', '54e739bef5b67569c963c38da52581ec', 'admin', '2019-03-15 16:50:15', NULL, NULL);
INSERT INTO `jeecg_order_ticket` VALUES ('269576e766b917f8b6509a2bb0c4d4bd', 'A100', NULL, '163e2efcbc6d7d54eb3f8a137da8a75a', 'jeecg-boot', '2019-03-29 18:43:59', NULL, NULL);
INSERT INTO `jeecg_order_ticket` VALUES ('2d473ffc79e5b38a17919e15f8b7078e', '66', '2019-03-29 00:00:00', '54e739bef5b67569c963c38da52581ec', 'admin', '2019-03-15 16:50:15', NULL, NULL);
INSERT INTO `jeecg_order_ticket` VALUES ('3655b66fca5fef9c6aac6d70182ffda2', 'AA123', '2019-04-01 00:00:00', 'd908bfee3377e946e59220c4a4eb414a', 'admin', '2019-04-01 16:27:03', NULL, NULL);
INSERT INTO `jeecg_order_ticket` VALUES ('365d5919155473ade45840fd626c51a9', 'dddd', '2019-04-04 17:25:29', '8ab1186410a65118c4d746eb085d3bed', 'admin', '2019-04-04 17:25:33', NULL, NULL);
INSERT INTO `jeecg_order_ticket` VALUES ('4889a782e78706ab4306a925cfb163a5', 'C34', '2019-04-01 00:00:00', 'd908bfee3377e946e59220c4a4eb414a', 'admin', '2019-04-01 16:35:00', 'admin', '2019-04-01 16:35:07');
INSERT INTO `jeecg_order_ticket` VALUES ('48d385796382cf87fa4bdf13b42d9a28', '导入A100', NULL, '3a867ebf2cebce9bae3f79676d8d86f3', 'jeecg-boot', '2019-03-29 18:43:59', NULL, NULL);
INSERT INTO `jeecg_order_ticket` VALUES ('541faed56efbeb4be9df581bd8264d3a', '88', NULL, '54e739bef5b67569c963c38da52581ec', 'admin', '2019-03-15 16:50:15', NULL, NULL);
INSERT INTO `jeecg_order_ticket` VALUES ('57a27a7dfd6a48e7d981f300c181b355', '6', '2019-03-30 00:00:00', '54e739bef5b67569c963c38da52581ec', 'admin', '2019-03-15 16:50:15', NULL, NULL);
INSERT INTO `jeecg_order_ticket` VALUES ('5ce4dc439c874266e42e6c0ff8dc8b5c', '导入A100', NULL, 'a2cce75872cc8fcc47f78de9ffd378c2', 'jeecg-boot', '2019-03-29 18:43:59', NULL, NULL);
INSERT INTO `jeecg_order_ticket` VALUES ('5f16e6a64ab22a161bd94cc205f2c662', '222', '2019-02-23 00:00:00', 'b190737bd04cca8360e6f87c9ef9ec4e', 'admin', '2019-02-25 16:29:48', NULL, NULL);
INSERT INTO `jeecg_order_ticket` VALUES ('645a06152998a576c051474157625c41', '88', '2019-04-04 17:25:31', '8ab1186410a65118c4d746eb085d3bed', 'admin', '2019-04-04 17:25:33', NULL, NULL);
INSERT INTO `jeecg_order_ticket` VALUES ('6e3562f2571ea9e96b2d24497b5f5eec', '55', '2019-03-23 00:00:00', '54e739bef5b67569c963c38da52581ec', 'admin', '2019-03-15 16:50:15', NULL, NULL);
INSERT INTO `jeecg_order_ticket` VALUES ('8fd2b389151568738b1cc4d8e27a6110', '导入A100', NULL, 'a2cce75872cc8fcc47f78de9ffd378c2', 'jeecg-boot', '2019-03-29 18:43:59', NULL, NULL);
INSERT INTO `jeecg_order_ticket` VALUES ('93f1a84053e546f59137432ff5564cac', '55', NULL, '54e739bef5b67569c963c38da52581ec', 'admin', '2019-03-15 16:50:15', NULL, NULL);
INSERT INTO `jeecg_order_ticket` VALUES ('969ddc5d2e198d50903686917f996470', 'A10029', '2019-04-01 00:00:00', 'f71f7f8930b5b6b1703d9948d189982b', 'admin', '2019-04-01 19:08:45', NULL, NULL);
INSERT INTO `jeecg_order_ticket` VALUES ('96e7303a8d22a5c384e08d7bcf7ac2bf', 'A100', NULL, 'e73434dad84ebdce2d4e0c2a2f06d8ea', 'jeecg-boot', '2019-03-29 18:43:59', NULL, NULL);
INSERT INTO `jeecg_order_ticket` VALUES ('9e8a3336f6c63f558f2b68ce2e1e666e', 'dddd', NULL, '9a57c850e4f68cf94ef7d8585dbaf7e6', 'admin', '2019-04-04 17:30:55', NULL, NULL);
INSERT INTO `jeecg_order_ticket` VALUES ('a28db02c810c65660015095cb81ed434', 'A100', NULL, 'f8889aaef6d1bccffd98d2889c0aafb5', 'jeecg-boot', '2019-03-29 18:43:59', NULL, NULL);
INSERT INTO `jeecg_order_ticket` VALUES ('b217bb0e4ec6a45b6cbf6db880060c0f', 'A100', NULL, '6a719071a29927a14f19482f8693d69a', 'jeecg-boot', '2019-03-29 18:43:59', NULL, NULL);
INSERT INTO `jeecg_order_ticket` VALUES ('ba708df70bb2652ed1051a394cfa0bb3', '333', NULL, '54e739bef5b67569c963c38da52581ec', 'admin', '2019-03-15 16:50:15', NULL, NULL);
INSERT INTO `jeecg_order_ticket` VALUES ('beabbfcb195d39bedeeafe8318794562', 'A1345', '2019-04-01 00:00:00', 'd908bfee3377e946e59220c4a4eb414a', 'admin', '2019-04-01 16:27:04', NULL, NULL);
INSERT INTO `jeecg_order_ticket` VALUES ('bf450223cb505f89078a311ef7b6ed16', '777', '2019-03-30 00:00:00', '54e739bef5b67569c963c38da52581ec', 'admin', '2019-03-15 16:50:15', NULL, NULL);
INSERT INTO `jeecg_order_ticket` VALUES ('c06165b6603e3e1335db187b3c841eef', 'fff', NULL, '9a57c850e4f68cf94ef7d8585dbaf7e6', 'admin', '2019-04-04 17:30:58', NULL, NULL);
INSERT INTO `jeecg_order_ticket` VALUES ('c113136abc26ace3a6da4e41d7dc1c7e', '44', '2019-03-15 00:00:00', '54e739bef5b67569c963c38da52581ec', 'admin', '2019-03-15 16:50:15', NULL, NULL);
INSERT INTO `jeecg_order_ticket` VALUES ('c1abdc2e30aeb25de13ad6ee3488ac24', '77', '2019-03-22 00:00:00', '54e739bef5b67569c963c38da52581ec', 'admin', '2019-03-15 16:50:15', NULL, NULL);
INSERT INTO `jeecg_order_ticket` VALUES ('c23751a7deb44f553ce50a94948c042a', '33', '2019-03-09 00:00:00', '8ab1186410a65118c4d746eb085d3bed', 'admin', '2019-04-04 17:25:33', NULL, NULL);
INSERT INTO `jeecg_order_ticket` VALUES ('c64547666b634b3d6a0feedcf05f25ce', 'C10019', '2019-04-01 00:00:00', 'f71f7f8930b5b6b1703d9948d189982b', 'admin', '2019-04-01 19:08:45', NULL, NULL);
INSERT INTO `jeecg_order_ticket` VALUES ('c8b8d3217f37da78dddf711a1f7da485', 'A100', NULL, '163e2efcbc6d7d54eb3f8a137da8a75a', 'jeecg-boot', '2019-03-29 18:43:59', NULL, NULL);
INSERT INTO `jeecg_order_ticket` VALUES ('cab691c1c1ff7a6dfd7248421917fd3c', 'A100', NULL, 'f8889aaef6d1bccffd98d2889c0aafb5', 'jeecg-boot', '2019-03-29 18:43:59', NULL, NULL);
INSERT INTO `jeecg_order_ticket` VALUES ('cca10a9a850b456d9b72be87da7b0883', '77', NULL, '54e739bef5b67569c963c38da52581ec', 'admin', '2019-03-15 16:50:15', NULL, NULL);
INSERT INTO `jeecg_order_ticket` VALUES ('d2fbba11f4814d9b1d3cb1a3f342234a', 'C10019', '2019-02-18 00:00:00', '54e739bef5b67569c963c38da52581ec', 'admin', '2019-03-15 16:50:15', NULL, NULL);
INSERT INTO `jeecg_order_ticket` VALUES ('d746c1ed956a562e97eef9c6faf94efa', '111', '2019-02-01 00:00:00', 'b190737bd04cca8360e6f87c9ef9ec4e', 'admin', '2019-02-25 16:29:48', NULL, NULL);
INSERT INTO `jeecg_order_ticket` VALUES ('dbdb07a16826808e4276e84b2aa4731a', '导入A100', NULL, '3a867ebf2cebce9bae3f79676d8d86f3', 'jeecg-boot', '2019-03-29 18:43:59', NULL, NULL);
INSERT INTO `jeecg_order_ticket` VALUES ('e7075639c37513afc0bbc4bf7b5d98b9', '88', NULL, '54e739bef5b67569c963c38da52581ec', 'admin', '2019-03-15 16:50:15', NULL, NULL);
INSERT INTO `jeecg_order_ticket` VALUES ('fa759dc104d0371f8aa28665b323dab6', '888', NULL, '54e739bef5b67569c963c38da52581ec', 'admin', '2019-03-15 16:50:15', NULL, NULL);
INSERT INTO `jeecg_order_ticket` VALUES ('ff197da84a9a3af53878eddc91afbb2e', '33', NULL, '54e739bef5b67569c963c38da52581ec', 'admin', '2019-03-15 16:50:15', NULL, NULL);

-- ----------------------------
-- Table structure for jeecg_project_nature_income
-- ----------------------------
DROP TABLE IF EXISTS `jeecg_project_nature_income`;
CREATE TABLE `jeecg_project_nature_income`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `nature` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '项目性质',
  `insurance_fee` decimal(18, 2) NULL DEFAULT 0.00 COMMENT '保险经纪佣金费',
  `risk_consulting_fee` decimal(18, 2) NULL DEFAULT 0.00 COMMENT '风险咨询费',
  `evaluation_fee` decimal(18, 2) NULL DEFAULT 0.00 COMMENT '承保公估评估费',
  `insurance_evaluation_fee` decimal(18, 2) NULL DEFAULT 0.00 COMMENT '保险公估费',
  `bidding_consulting_fee` decimal(18, 2) NULL DEFAULT 0.00 COMMENT '投标咨询费',
  `interol_consulting_fee` decimal(18, 2) NULL DEFAULT 0.00 COMMENT '内控咨询费',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 9 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of jeecg_project_nature_income
-- ----------------------------
INSERT INTO `jeecg_project_nature_income` VALUES (1, '市场化-电商业务', 4865.41, 0.00, 0.00, 0.00, 0.00, 0.00);
INSERT INTO `jeecg_project_nature_income` VALUES (2, '统筹型', 35767081.88, 0.00, 0.00, 0.00, 0.00, 0.00);
INSERT INTO `jeecg_project_nature_income` VALUES (3, '市场化-非股东', 1487045.35, 0.00, 0.00, 0.00, 0.00, 0.00);
INSERT INTO `jeecg_project_nature_income` VALUES (4, '市场化-参控股', 382690.56, 0.00, 0.00, 0.00, 0.00, 0.00);
INSERT INTO `jeecg_project_nature_income` VALUES (5, '市场化-员工福利', 256684.91, 0.00, 0.00, 0.00, 0.00, 0.00);
INSERT INTO `jeecg_project_nature_income` VALUES (6, '市场化-再保险', 563451.03, 0.00, 0.00, 0.00, 0.00, 0.00);
INSERT INTO `jeecg_project_nature_income` VALUES (7, '市场化-海外业务', 760576.25, 770458.75, 0.00, 0.00, 0.00, 0.00);
INSERT INTO `jeecg_project_nature_income` VALUES (8, '市场化-风险咨询', 910183.93, 0.00, 0.00, 0.00, 0.00, 226415.09);

-- ----------------------------
-- Table structure for joa_demo
-- ----------------------------
DROP TABLE IF EXISTS `joa_demo`;
CREATE TABLE `joa_demo`  (
  `id` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT 'ID',
  `name` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '请假人',
  `days` int(11) NULL DEFAULT NULL COMMENT '请假天数',
  `begin_date` datetime(0) NULL DEFAULT NULL COMMENT '开始时间',
  `end_date` datetime(0) NULL DEFAULT NULL COMMENT '请假结束时间',
  `reason` varchar(500) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '请假原因',
  `bpm_status` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '1' COMMENT '流程状态',
  `create_by` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '创建人id',
  `create_time` datetime(0) NULL DEFAULT NULL COMMENT '创建时间',
  `update_time` datetime(0) NULL DEFAULT NULL COMMENT '修改时间',
  `update_by` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '修改人id'
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '流程测试' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for onl_cgform_button
-- ----------------------------
DROP TABLE IF EXISTS `onl_cgform_button`;
CREATE TABLE `onl_cgform_button`  (
  `ID` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '主键ID',
  `BUTTON_CODE` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '按钮编码',
  `BUTTON_ICON` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '按钮图标',
  `BUTTON_NAME` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '按钮名称',
  `BUTTON_STATUS` varchar(2) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '按钮状态',
  `BUTTON_STYLE` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '按钮样式',
  `EXP` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '表达式',
  `CGFORM_HEAD_ID` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '表单ID',
  `OPT_TYPE` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '按钮类型',
  `ORDER_NUM` int(11) NULL DEFAULT NULL COMMENT '排序',
  `OPT_POSITION` varchar(3) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '按钮位置1侧面 2底部',
  PRIMARY KEY (`ID`) USING BTREE,
  INDEX `index_formid`(`CGFORM_HEAD_ID`) USING BTREE,
  INDEX `index_button_code`(`BUTTON_CODE`) USING BTREE,
  INDEX `index_button_status`(`BUTTON_STATUS`) USING BTREE,
  INDEX `index_button_order`(`ORDER_NUM`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of onl_cgform_button
-- ----------------------------
INSERT INTO `onl_cgform_button` VALUES ('8e3c420a80066cccc08aa69873aa50ab', 'hidename', 'icon-edit', '隐藏', '1', 'form', NULL, '4028818370f308e90170f330ff050003', 'js', NULL, '2');
INSERT INTO `onl_cgform_button` VALUES ('a45bc1c6fba96be6b0c91ffcdd6b54aa', 'genereate_person_config', 'icon-edit', '生成配置', '1', 'link', NULL, 'e2faf977fdaf4b25a524f58c2441a51c', 'js', NULL, '2');

-- ----------------------------
-- Table structure for onl_cgform_enhance_java
-- ----------------------------
DROP TABLE IF EXISTS `onl_cgform_enhance_java`;
CREATE TABLE `onl_cgform_enhance_java`  (
  `ID` varchar(36) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `BUTTON_CODE` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '按钮编码',
  `CG_JAVA_TYPE` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '类型',
  `CG_JAVA_VALUE` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '数值',
  `CGFORM_HEAD_ID` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '表单ID',
  `ACTIVE_STATUS` varchar(2) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '1' COMMENT '生效状态',
  `EVENT` varchar(10) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT 'end' COMMENT '事件状态(end:结束，start:开始)',
  PRIMARY KEY (`ID`) USING BTREE,
  INDEX `index_fmid`(`CGFORM_HEAD_ID`) USING BTREE,
  INDEX `index_buttoncode`(`BUTTON_CODE`) USING BTREE,
  INDEX `index_status`(`ACTIVE_STATUS`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for onl_cgform_enhance_js
-- ----------------------------
DROP TABLE IF EXISTS `onl_cgform_enhance_js`;
CREATE TABLE `onl_cgform_enhance_js`  (
  `ID` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '主键ID',
  `CG_JS` longtext CHARACTER SET utf8 COLLATE utf8_general_ci NULL COMMENT 'JS增强内容',
  `CG_JS_TYPE` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '类型',
  `CONTENT` varchar(1000) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '备注',
  `CGFORM_HEAD_ID` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '表单ID',
  PRIMARY KEY (`ID`) USING BTREE,
  INDEX `index_fmid`(`CGFORM_HEAD_ID`) USING BTREE,
  INDEX `index_jstype`(`CG_JS_TYPE`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of onl_cgform_enhance_js
-- ----------------------------
INSERT INTO `onl_cgform_enhance_js` VALUES ('10058a2951e005773b708af98735aa45', '', 'list', NULL, '4028818370f308e90170f330ff050003');
INSERT INTO `onl_cgform_enhance_js` VALUES ('109fc068817aada2c7d6c88ffb379010', 'hidename(){\n  that.sh.name = false;\n}', 'form', NULL, '4028818370f308e90170f330ff050003');
INSERT INTO `onl_cgform_enhance_js` VALUES ('274b5d741a0262d3411958f0c465c5f0', 'genereate_person_config(row){\nconsole.log(\'选择\',row)\nalert(row.name + \'，个人积分配置生成成功！\');\n}', 'list', NULL, 'e2faf977fdaf4b25a524f58c2441a51c');
INSERT INTO `onl_cgform_enhance_js` VALUES ('2cbaf25f1edb620bea2d8de07f8233a1', 'air_china_post_materiel_item_onlChange(){\n    return {\n        wl_name(){\n           \n            let id = event.row.id\n            let cnum = event.row.num\n            let value = event.value\n            let targrt = event.target\n            let columnKey = event.column.key\n           let nval = 200*cnum\n           console.log(\'row\',event.row);\n           console.log(\'cnum\',cnum);\n           let otherValues = {\'jifen\': nval}\n              \n                that.triggleChangeValues(targrt,id,otherValues)\n\n        }\n    }\n}', 'form', NULL, 'e67d26b610dd414c884c4dbb24e71ce3');
INSERT INTO `onl_cgform_enhance_js` VALUES ('35d4ef464e5e8c87c9aa82ea89215fc1', '', 'list', NULL, 'e67d26b610dd414c884c4dbb24e71ce3');
INSERT INTO `onl_cgform_enhance_js` VALUES ('44cad4eec436328ed3cc134855f8d1d5', ' onlChange(){\n   return {\n    name(that, event) {\n      that.executeMainFillRule()\n    }\n  }\n }', 'form', NULL, '4adec929a6594108bef5b35ee9966e9f');
INSERT INTO `onl_cgform_enhance_js` VALUES ('53b58bff5e4f7d99c5c3ffab79783584', '// 获取所有 form data\nvar formData = api.getFormData() || {}\n// 请求后台的填值规则接口地址\nvar url = \'/sys/fillRule/executeRuleByCode/\'\nvar ruleCode = \'stock_io_bill_no\'\napi.get(url + ruleCode, formData).then(res => {\n  // 执行成功，获取返回的值，并赋到页面上\n  if (res.success) {\n    var value = res.result\n    api.setFormData(\'billNo\', value)\n  }\n})', 'form', NULL, '40288183712beaa901712beaa9a00000');
INSERT INTO `onl_cgform_enhance_js` VALUES ('55d37886563b57a40cb5db8db78b7043', '', 'form', NULL, '4028818370f308e90170f308eabf0001');
INSERT INTO `onl_cgform_enhance_js` VALUES ('90394fbc3d48978cc0937bc56f2d5370', '', 'list', NULL, 'deea5a8ec619460c9245ba85dbc59e80');
INSERT INTO `onl_cgform_enhance_js` VALUES ('9ebb26e19e0d9b8fb01d65147c0e12b8', 'onlChange(){\n   return {\n     \n     materialId(){\n        let value = event.value\n        alert(\'触发控件\',value)\n        \n        if(value!=null && value!=\"\"){\n          let currDate = new Date(value.replace(/-/g, \"\\/\")); \n          let d = new Date(); \n          let ru_year_num = d.getFullYear()-currDate.getFullYear()    \n          let values = {\'ru_year_num\':ru_year_num + 1}\n          that.triggleChangeValues(values)\n        }\n      }\n     \n    }\n }\n', 'form', NULL, '402881ea71684fa00171684fa0680000');

-- ----------------------------
-- Table structure for onl_cgform_enhance_sql
-- ----------------------------
DROP TABLE IF EXISTS `onl_cgform_enhance_sql`;
CREATE TABLE `onl_cgform_enhance_sql`  (
  `ID` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '主键ID',
  `BUTTON_CODE` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '按钮编码',
  `CGB_SQL` longtext CHARACTER SET utf8 COLLATE utf8_general_ci NULL COMMENT 'SQL内容',
  `CGB_SQL_NAME` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT 'Sql名称',
  `CONTENT` varchar(1000) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '备注',
  `CGFORM_HEAD_ID` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '表单ID',
  PRIMARY KEY (`ID`) USING BTREE,
  INDEX `index_formid`(`CGFORM_HEAD_ID`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for onl_cgform_field
-- ----------------------------
DROP TABLE IF EXISTS `onl_cgform_field`;
CREATE TABLE `onl_cgform_field`  (
  `id` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '主键ID',
  `cgform_head_id` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '表ID',
  `db_field_name` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '字段名字',
  `db_field_txt` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '字段备注',
  `db_field_name_old` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '原字段名',
  `db_is_key` tinyint(1) NULL DEFAULT NULL COMMENT '是否主键 0否 1是',
  `db_is_null` tinyint(1) NULL DEFAULT NULL COMMENT '是否允许为空0否 1是',
  `db_type` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '数据库字段类型',
  `db_length` int(11) NOT NULL COMMENT '数据库字段长度',
  `db_point_length` int(11) NULL DEFAULT NULL COMMENT '小数点',
  `db_default_val` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '表字段默认值',
  `dict_field` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '字典code',
  `dict_table` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '字典表',
  `dict_text` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '字典Text',
  `field_show_type` varchar(10) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '表单控件类型',
  `field_href` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '跳转URL',
  `field_length` int(11) NULL DEFAULT NULL COMMENT '表单控件长度',
  `field_valid_type` varchar(300) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '表单字段校验规则',
  `field_must_input` varchar(2) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '字段是否必填',
  `field_extend_json` varchar(500) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '扩展参数JSON',
  `field_default_value` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '控件默认值，不同的表达式展示不同的结果。\r\n1. 纯字符串直接赋给默认值；\r\n2. #{普通变量}；\r\n3. {{ 动态JS表达式 }}；\r\n4. ${填值规则编码}；\r\n填值规则表达式只允许存在一个，且不能和其他规则混用。',
  `is_query` tinyint(1) NULL DEFAULT NULL COMMENT '是否查询条件0否 1是',
  `is_show_form` tinyint(1) NULL DEFAULT NULL COMMENT '表单是否显示0否 1是',
  `is_show_list` tinyint(1) NULL DEFAULT NULL COMMENT '列表是否显示0否 1是',
  `is_read_only` tinyint(1) NULL DEFAULT 0 COMMENT '是否是只读（1是 0否）',
  `query_mode` varchar(10) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '查询模式',
  `main_table` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '外键主表名',
  `main_field` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '外键主键字段',
  `order_num` int(11) NULL DEFAULT NULL COMMENT '排序',
  `update_by` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '修改人',
  `update_time` datetime(0) NULL DEFAULT NULL COMMENT '修改时间',
  `create_time` datetime(0) NULL DEFAULT NULL COMMENT '创建时间',
  `create_by` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '创建人',
  `converter` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '自定义值转换器',
  `query_def_val` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '查询默认值',
  `query_dict_text` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '查询配置字典text',
  `query_dict_field` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '查询配置字典code',
  `query_dict_table` varchar(500) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '查询配置字典table',
  `query_show_type` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '查询显示控件',
  `query_config_flag` varchar(3) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '是否启用查询配置1是0否',
  `query_valid_type` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '查询字段校验类型',
  `query_must_input` varchar(3) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '查询字段是否必填1是0否',
  `sort_flag` varchar(3) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '是否支持排序1是0否',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `inex_table_id`(`cgform_head_id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of onl_cgform_field
-- ----------------------------
INSERT INTO `onl_cgform_field` VALUES ('0021c969dc23a9150d6f70a13b52e73e', '402860816aa5921f016aa5921f480000', 'begin_date', '开始时间', 'begin_date', 0, 1, 'Date', 0, 0, '', '', '', '', 'date', '', 120, NULL, '0', '', '', 0, 1, 1, 0, 'group', '', '', 4, 'admin', '2019-05-11 15:31:54', '2019-05-11 14:26:19', 'admin', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `onl_cgform_field` VALUES ('003451e883a951a8372f52eda72c2b9a', '40288183712beaa901712c0eb77c0002', 'headquarters', '所属总公司', 'headquarters', 0, 1, 'string', 100, 0, '', '', '', '', 'text', '', 120, NULL, '0', '', '', 0, 1, 0, 0, 'group', '', '', 9, 'admin', '2020-03-31 00:15:25', '2020-03-30 23:28:15', 'admin', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `onl_cgform_field` VALUES ('006b6c1609b101ce69a14bea7d206b75', '40288101710a4c6201710a60ad5e0001', 'has_child', '是否基准', 'has_child', 0, 1, 'string', 3, 0, '0', 'yn', '', '', 'list', '', 50, NULL, '0', '', '', 0, 0, 0, 0, 'group', '', '', 4, 'admin', '2020-03-28 09:52:10', '2020-03-24 10:30:41', 'admin', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `onl_cgform_field` VALUES ('01dcd3364aad4e31f67c4f3603ef720f', '40288183712beaa901712c0ebcb10003', 'postcode_receipt', '收件信息邮编', 'postcode_receipt', 0, 1, 'string', 20, 0, '', '', '', '', 'text', '', 120, NULL, '0', '', '', 0, 1, 0, 0, 'group', '', '', 30, 'admin', '2020-03-31 00:04:14', '2020-03-30 23:28:16', 'admin', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `onl_cgform_field` VALUES ('020c1622c3df0aef30185f57874f6959', '79091e8277c744158530321513119c68', 'bpm_status', '流程状态', NULL, 0, 1, 'String', 32, 0, '1', 'bpm_status', '', '', 'text', '', 120, NULL, '0', '', '', 0, 0, 1, 0, 'single', '', '', 8, 'admin', '2019-05-11 15:29:47', '2019-05-11 15:29:26', 'admin', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `onl_cgform_field` VALUES ('02261bb6e92b4a14de43389ddf19d1ba', '402881fe71c8c4fd0171c8c4fdae0000', 'receipt_type', '收款类型', 'receipt_type', 0, 1, 'string', 10, 0, '', 'x_receipt_type', '', '', 'list', '', 120, NULL, '0', '', '', 0, 0, 0, 0, 'group', '', '', 4, 'admin', '2020-04-30 10:23:44', '2020-04-30 09:48:06', 'admin', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `onl_cgform_field` VALUES ('027c37f453067b9d183f1de05319635b', '40288183712beaa901712c0ebcb10003', 'tax_scale', '纳税规模', 'tax_scale', 0, 1, 'string', 10, 0, '', 'x_tax_scale', '', '', 'list', '', 120, NULL, '0', '', '', 0, 1, 1, 0, 'group', '', '', 6, 'admin', '2020-03-31 00:04:14', '2020-03-30 23:28:16', 'admin', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `onl_cgform_field` VALUES ('02b20e692456403e2fed1a89a06833b4', '402860816bff91c0016bff91d2810005', 'phone', '联系方式', 'phone', 0, 1, 'string', 20, 0, '', '', '', '', 'text', '', 120, NULL, '0', '', '', 0, 1, 1, 0, 'group', '', '', 8, 'admin', '2019-07-19 18:05:55', '2019-07-17 18:54:35', 'admin', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `onl_cgform_field` VALUES ('02f79b89d22bcbfd50dcc905206d02d7', '40288101717185240171718524d60000', 'update_time', '修改时间', 'update_time', 0, 1, 'Date', 0, 0, '', '', '', '', 'date', '', 120, NULL, '0', '', '', 0, 1, 1, 0, 'group', '', '', 21, 'admin', '2020-04-13 14:00:54', '2020-04-13 11:11:24', 'admin', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `onl_cgform_field` VALUES ('030055510f228068e9f1f6d5c9ac8563', '4028818370e8d46b0170e8d46d350001', 'material_id', '物料', 'material_id', 0, 0, 'string', 36, 0, '', '', '', '', 'text', '', 120, NULL, '0', '', '', 0, 1, 1, 0, 'group', '', '', 5, 'admin', '2020-03-17 22:14:27', '2020-03-17 22:10:01', 'admin', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `onl_cgform_field` VALUES ('033d5bb5a606bd1570a3a3f43d7c10a8', '4028818370f5f37d0170f865a9e40003', 'k', 'k', 'k', 0, 0, 'string', 100, 0, NULL, NULL, NULL, NULL, 'text', NULL, 120, NULL, '0', NULL, NULL, 0, 1, 1, 0, 'group', NULL, NULL, 1, NULL, NULL, '2020-03-20 22:42:58', 'admin', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `onl_cgform_field` VALUES ('03668009f0ad92b20abb1a377197ee47', 'deea5a8ec619460c9245ba85dbc59e80', 'order_fk_id', '订单外键ID', NULL, 0, 0, 'String', 32, 0, '', '', '', '', 'text', '', 120, NULL, '0', '', '', 0, 0, 0, 0, 'single', 'test_order_main', 'id', 10, 'admin', '2020-03-15 17:37:15', '2019-04-20 11:42:53', 'admin', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `onl_cgform_field` VALUES ('03709092184fdf4a66b0cdb4dd10a159', '402860816bff91c0016bffa220a9000b', 'bpm_status', '流程状态', NULL, 0, 1, 'String', 32, 0, '1', '', '', '', 'text', '', 120, NULL, '0', '', '', 0, 1, 1, 0, 'single', '', '', 46, 'admin', '2019-07-22 16:15:32', '2019-07-19 15:34:44', 'admin', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `onl_cgform_field` VALUES ('039cccb141a1fb9224d5fea5f019b153', '402881fe71c8c4fd0171c8c4fdae0000', 'id', 'ID', 'id', 1, 0, 'string', 36, 0, '', '', '', '', 'text', '', 120, NULL, '0', '', '', 0, 0, 0, 0, 'group', '', '', 1, 'admin', '2020-04-30 10:23:44', '2020-04-30 09:48:06', 'admin', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `onl_cgform_field` VALUES ('03c105d2706c8286416833684de67406', '79091e8277c744158530321513119c68', 'create_by', '创建人', NULL, 0, 1, 'string', 50, 0, '', '', '', '', 'text', '', 120, NULL, '0', '', '', 0, 0, 0, 0, 'single', '', '', 2, 'admin', '2019-05-11 15:29:47', '2019-05-11 15:27:17', 'admin', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `onl_cgform_field` VALUES ('03ec815775dc332d7fc0a69137adab99', '40288183712beaa901712beaad3c0001', 'id', 'ID', 'id', 1, 0, 'string', 36, 0, '', '', '', '', 'text', '', 120, NULL, '0', '', '', 0, 0, 0, 0, 'group', '', '', 1, 'admin', '2020-05-04 21:41:29', '2020-03-30 22:48:53', 'admin', '', '', '', '', '', NULL, '0', NULL, NULL, '0');
INSERT INTO `onl_cgform_field` VALUES ('03face7897f5b1d0b57ff15fccfe21bd', '40288101717185240171718524d60000', 'is_voided', '是否作废', 'is_voided', 0, 0, 'int', 3, 0, '', 'yn', '', '', 'list', '', 120, NULL, '0', '', '', 0, 1, 1, 0, 'group', '', '', 15, 'admin', '2020-04-13 14:00:53', '2020-04-13 11:11:24', 'admin', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `onl_cgform_field` VALUES ('03fd5ab69f331ff760c3f7d86b4a93f8', '4028318169e81b970169e81b97650000', 'log_content', '日志内容', 'log_content', 0, 1, 'string', 1000, 0, NULL, NULL, NULL, NULL, 'text', NULL, 120, NULL, '0', NULL, NULL, 0, 1, 1, 0, 'group', NULL, NULL, 3, NULL, NULL, '2019-04-04 19:28:36', 'admin', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `onl_cgform_field` VALUES ('045eb432c418b2b103b1e1b8e8a8a75d', 'fb7125a344a649b990c12949945cb6c1', 'age', '年龄', NULL, 0, 1, 'int', 32, 0, '', '', '', '', 'text', '', 120, '', '0', '', '', 0, 1, 1, 0, 'single', '', '', NULL, NULL, NULL, '2019-03-26 19:24:11', 'admin', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `onl_cgform_field` VALUES ('04e4185a503e6aaaa31c243829ff4ac7', 'd35109c3632c4952a19ecc094943dd71', 'birthday', '生日', NULL, 0, 1, 'Date', 32, 0, '', '', '', '', 'date', '', 120, '', '0', '', '', 0, 1, 1, 0, 'single', '', '', 9, 'admin', '2020-02-23 18:11:41', '2019-03-15 14:24:35', 'admin', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `onl_cgform_field` VALUES ('04ff134cb4aae845059e10b3b85f1451', '7ea60a25fa27470e9080d6a921aabbd1', 'update_time', '更新日期', NULL, 0, 1, 'Date', 20, 0, '', '', '', '', 'datetime', '', 120, NULL, '0', '', '', 0, 0, 0, 0, 'single', '', '', 5, NULL, NULL, '2019-04-17 00:22:21', 'admin', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `onl_cgform_field` VALUES ('051132bc58145210497bde3b3b60492e', '40288101710a4c6201710a4c62b50000', 'update_time', '修改时间', 'update_time', 0, 1, 'Date', 0, 0, '', '', '', '', 'date', '', 120, NULL, '0', '', '', 0, 1, 0, 1, 'group', '', '', 11, 'admin', '2020-03-24 10:18:35', '2020-03-24 10:08:31', 'admin', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `onl_cgform_field` VALUES ('051dd70c504c97a028daab2af261ea35', '1acb6f81a1d9439da6cc4e868617b565', 'update_time', '更新日期', NULL, 0, 1, 'Date', 20, 0, '', '', '', '', 'datetime', '', 120, NULL, '0', '', '', 0, 0, 0, 0, 'single', '', '', 5, 'admin', '2019-06-10 14:47:14', '2019-04-23 22:58:19', 'admin', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `onl_cgform_field` VALUES ('052dcc6f34976b66754fd99415bd22ce', '79091e8277c744158530321513119c68', 'update_time', '更新日期', NULL, 0, 1, 'Date', 20, 0, '', '', '', '', 'datetime', '', 120, NULL, '0', '', '', 0, 0, 0, 0, 'single', '', '', 5, 'admin', '2019-05-11 15:29:47', '2019-05-11 15:27:17', 'admin', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `onl_cgform_field` VALUES ('054a3a036889a9e68636da3844f5d324', '402881fe72362af70172362afadf0001', 'tax_rate', '税率', 'tax_rate', 0, 1, 'BigDecimal', 10, 4, '', '', '', '', 'text', '', 120, NULL, '0', '', '', 0, 1, 1, 0, 'single', '', '', 6, 'admin', '2020-05-21 20:23:41', '2020-05-21 15:38:06', 'admin', '', '', '', '', '', NULL, '0', NULL, NULL, '0');
INSERT INTO `onl_cgform_field` VALUES ('054db05394e83b318f097a60bc044134', '402860816bff91c0016bffa220a9000b', 'residence_address', '户籍地址', 'residence_address', 0, 1, 'string', 200, 0, '', '', '', '', 'text', '', 120, NULL, '0', '', '', 0, 1, 1, 0, 'group', '', '', 28, 'admin', '2019-07-22 16:15:32', '2019-07-17 19:12:24', 'admin', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `onl_cgform_field` VALUES ('055b0c756e8c4fa0461dc355646d9f8e', '402881ea71684fa00171684fa0680000', 'material_id', '物料', 'material_id', 0, 0, 'string', 36, 0, '', 'id', 'bas_material', 'name', 'sel_search', '', 120, NULL, '0', '', '', 1, 1, 1, 1, 'single', '', '', 3, 'admin', '2020-04-11 16:28:45', '2020-04-11 16:16:22', 'admin', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `onl_cgform_field` VALUES ('057a476a97c54e9b84c13299b17ac48d', '402881fe71c8c4fd0171c8c503230002', 'is_auto', '是否自动生成', 'is_auto', 0, 0, 'int', 3, 0, '', 'yn', '', '', 'list', '', 120, NULL, '0', '', '', 0, 1, 1, 1, 'group', '', '', 4, 'admin', '2020-04-30 10:30:53', '2020-04-30 09:48:07', 'admin', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `onl_cgform_field` VALUES ('05c46f4928f1867120e07faa815afc0b', '40288183712beaa901712beaad3c0001', 'settle_price', '含税单价', 'settle_price', 0, 1, 'BigDecimal', 18, 6, '', '', '', '', 'text', '', 120, NULL, '0', '', '', 0, 1, 1, 0, 'group', '', '', 15, 'admin', '2020-05-04 21:41:29', '2020-03-30 22:48:53', 'admin', '', '', '', '', '', NULL, '0', NULL, NULL, '0');
INSERT INTO `onl_cgform_field` VALUES ('05d06005d7bfe004a56c59ab4dfedd61', '402881fe71c8c4fd0171c8c503230002', 'checked_amt', '已核销金额', 'checked_amt', 0, 0, 'BigDecimal', 18, 2, '', '', '', '', 'text', '', 120, NULL, '0', '', '', 0, 1, 1, 1, 'group', '', '', 10, 'admin', '2020-04-30 10:30:53', '2020-04-30 09:48:07', 'admin', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `onl_cgform_field` VALUES ('05fc8a789574597902c7ddeaa7913841', '402881fe72362af70172362af7150000', 'source_id', '源单id', 'source_id', 0, 1, 'string', 36, 0, '', '', '', '', 'text', '', 120, NULL, '0', '', '', 0, 1, 1, 0, 'single', '', '', 8, 'admin', '2020-05-21 20:19:56', '2020-05-21 15:38:06', 'admin', '', '', '', '', '', NULL, '0', NULL, NULL, '0');
INSERT INTO `onl_cgform_field` VALUES ('0604945c206e867644e9a44b4c9b20c6', 'fb19fb067cd841f9ae93d4eb3b883dc0', '2', '4', NULL, 0, 1, 'string', 32, 0, '', '', '', '', 'text', '', 120, '', '0', '', '', 0, 1, 1, 0, 'single', '', '', 5, NULL, NULL, '2019-03-23 11:39:48', 'admin', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `onl_cgform_field` VALUES ('0617de6d735b37a3f80f2f35ad5d1511', '4028839a6de2ebd3016de2ebd3870000', 'size_type', '尺码类型', 'size_type', 0, 1, 'string', 2, 0, NULL, NULL, NULL, NULL, 'text', NULL, 120, NULL, '0', NULL, NULL, 0, 1, 1, 0, 'group', NULL, NULL, 13, NULL, NULL, '2019-10-19 15:29:30', 'admin', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `onl_cgform_field` VALUES ('068f05e16bed8abd902dd0cba13428be', '402881e970dd8d520170dd90f7c30002', 'purchase_cost', 'purchaseCost', 'purchase_cost', 0, 1, 'BigDecimal', 18, 6, '', '', '', '', 'text', '', 120, NULL, '0', '', '', 0, 1, 1, 0, 'group', '', '', 10, 'admin', '2020-03-15 21:40:40', '2020-03-15 17:40:31', 'admin', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `onl_cgform_field` VALUES ('06a1badae6119abf4ec48858a3e94e1c', '402860816bff91c0016bffa220a9000b', 'sys_org_code', '组织机构编码', 'sys_org_code', 0, 1, 'string', 50, 0, '', '', '', '', 'text', '', 120, NULL, '0', '', '', 0, 1, 1, 0, 'group', '', '', 43, 'admin', '2019-07-22 16:15:32', '2019-07-17 19:12:24', 'admin', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `onl_cgform_field` VALUES ('06c2a5388956badb44fee22b542bf411', '40288183712beaa901712beaad3c0001', 'is_incl_tax', '成本是否含税', 'is_incl_tax', 0, 1, 'int', 3, 0, '', 'yn', '', '', 'checkbox', '', 120, NULL, '0', '', '', 0, 1, 1, 0, 'group', '', '', 13, 'admin', '2020-05-04 21:41:29', '2020-03-30 22:48:53', 'admin', '', '', '', '', '', NULL, '0', NULL, NULL, '0');
INSERT INTO `onl_cgform_field` VALUES ('06d4944bf3fc7a28951892bbe340e671', '40288183712beaa901712c0eb77c0002', 'customer_category', '客户分类', 'customer_category', 0, 1, 'string', 10, 0, '', '', '', '', 'text', '', 120, NULL, '0', '', '', 0, 0, 0, 0, 'group', '', '', 8, 'admin', '2020-03-31 00:15:25', '2020-03-30 23:28:15', 'admin', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `onl_cgform_field` VALUES ('06f1cfff58395ff62526b894f6182641', 'e67d26b610dd414c884c4dbb24e71ce3', 'create_by', '创建人', NULL, 0, 1, 'string', 50, 0, '', '', '', '', 'text', '', 120, NULL, '0', '', '', 0, 0, 0, 0, 'single', '', '', 2, 'admin', '2019-04-24 11:03:32', '2019-04-24 11:02:57', 'admin', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `onl_cgform_field` VALUES ('07a307972076a392ffc61b11437f89dd', '402860816bff91c0016bff91c0cb0000', 'create_time', '创建时间', 'create_time', 0, 1, 'Date', 0, 0, '', '', '', '', 'date', '', 120, NULL, '0', '', '', 0, 1, 1, 0, 'group', '', '', 13, 'admin', '2019-07-19 18:09:01', '2019-07-17 18:54:32', 'admin', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `onl_cgform_field` VALUES ('07f4776fd641389a8c98a85713990dce', '402860816bff91c0016bff91c0cb0000', 'update_by', '更新人', 'update_by', 0, 1, 'string', 100, 0, '', '', '', '', 'text', '', 120, NULL, '0', '', '', 0, 1, 1, 0, 'group', '', '', 14, 'admin', '2019-07-19 18:09:01', '2019-07-17 18:54:32', 'admin', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `onl_cgform_field` VALUES ('0862538b69e92446ff8428ca84bbed65', '40288183712beaa901712beaa9a00000', 'bill_no', '单据编号', 'bill_no', 0, 0, 'string', 50, 0, '', '', '', '', 'text', '', 120, NULL, '0', '', '${stock_io_bill_no}', 1, 1, 1, 1, 'single', '', '', 3, 'admin', '2020-04-17 12:01:33', '2020-03-30 22:48:52', 'admin', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `onl_cgform_field` VALUES ('08a65a1bce762f6b518eac82b5649a93', '40288183712beaa901712c0eb77c0002', 'id', 'ID', 'id', 1, 0, 'string', 36, 0, '', '', '', '', 'text', '', 120, NULL, '0', '', '', 0, 0, 0, 0, 'group', '', '', 1, 'admin', '2020-03-31 00:15:25', '2020-03-30 23:28:15', 'admin', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `onl_cgform_field` VALUES ('08c98fa2d36929e9d2f201849aaa3a2b', '40288183712beaa901712beaad3c0001', 'mid', '主表', 'mid', 0, 0, 'string', 36, 0, '', '', '', '', 'text', '', 120, NULL, '0', '', '', 0, 0, 0, 0, 'group', 'stk_io_bill', 'id', 2, 'admin', '2020-05-04 21:41:29', '2020-03-30 22:48:53', 'admin', '', '', '', '', '', NULL, '0', NULL, NULL, '0');
INSERT INTO `onl_cgform_field` VALUES ('08cac4b2363efe07e9a3a1a96e082722', '40288101710a4c6201710a4c62b50000', 'version', '版本', 'version', 0, 1, 'int', 10, 0, '', '', '', '', 'text', '', 120, NULL, '0', '', '', 0, 0, 0, 0, 'group', '', '', 12, 'admin', '2020-03-24 10:18:35', '2020-03-24 10:08:31', 'admin', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `onl_cgform_field` VALUES ('09450359eb90b40d224ec43588a62f9e', '402860816bff91c0016bff91c0cb0000', 'user_id', '用户ID', 'user_id', 0, 1, 'string', 32, 0, '', '', '', '', 'text', '', 120, NULL, '0', '', '', 0, 1, 1, 0, 'group', '', '', 3, 'admin', '2019-07-19 18:09:01', '2019-07-17 18:54:32', 'admin', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `onl_cgform_field` VALUES ('09d199cd09218fcb1466308289c06af4', '402881fe71c8c4fd0171c8c500d30001', 'bank_account_id', '资金账户', 'bank_account_id', 0, 1, 'string', 36, 0, '', 'id', 'bas_bank_account', 'account_no', 'list', '', 120, NULL, '0', '', '', 0, 1, 1, 0, 'group', '', '', 9, 'admin', '2020-04-30 10:30:11', '2020-04-30 09:48:07', 'admin', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `onl_cgform_field` VALUES ('0a453a63e33654aa1b9ee2affa854a6d', '4fb8e12a697f4d5bbe9b9fb1e9009486', 'create_by', '创建人', NULL, 0, 1, 'string', 50, 0, '', '', '', '', 'text', '', 120, NULL, '0', '', '', 0, 0, 0, 0, 'single', '', '', 6, 'admin', '2020-04-10 19:51:27', '2020-04-10 19:47:01', 'admin', '', '', '', '', '', NULL, '0', NULL, NULL, '0');
INSERT INTO `onl_cgform_field` VALUES ('0a4cdcb7e54f614ab952024f6c72bb6d', 'beee191324fd40c1afec4fda18bd9d47', 'update_time', '更新日期', NULL, 0, 1, 'Date', 20, 0, '', '', '', '', 'datetime', '', 120, NULL, '0', '', '', 0, 0, 0, 0, 'single', '', '', 5, 'admin', '2019-04-13 13:41:13', '2019-04-13 13:40:56', 'admin', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `onl_cgform_field` VALUES ('0adc06d9b497684bcbb5a781e044517c', '1acb6f81a1d9439da6cc4e868617b565', 'supplier', '供应商', NULL, 0, 1, 'String', 32, 0, '', 'air_china_ supplier', '', '', 'list', '', 120, NULL, '0', '', '', 0, 1, 1, 0, 'single', '', '', 15, 'admin', '2019-06-10 14:47:14', '2019-04-24 16:52:00', 'admin', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `onl_cgform_field` VALUES ('0b3e833ac4aae3a13ec2f8ae460708f8', '4028839a6de2ebd3016de2ebd3870000', 'no', '预算表序号', 'no', 0, 1, 'string', 50, 0, NULL, NULL, NULL, NULL, 'text', NULL, 120, NULL, '0', NULL, NULL, 0, 1, 1, 0, 'group', NULL, NULL, 8, NULL, NULL, '2019-10-19 15:29:30', 'admin', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `onl_cgform_field` VALUES ('0ba1bf74e2a6a94a7a63010ec7230706', '402860816bff91c0016bffa220a9000b', 'update_time', '更新时间', 'update_time', 0, 1, 'Date', 0, 0, '', '', '', '', 'date', '', 120, NULL, '0', '', '', 0, 1, 1, 0, 'group', '', '', 42, 'admin', '2019-07-22 16:15:32', '2019-07-17 19:12:24', 'admin', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `onl_cgform_field` VALUES ('0c6adc5d3a1941f31c464c6757b0e7b1', '4028818370e8d46b0170e8d46b4b0000', 'version', '版本', 'version', 0, 1, 'int', 10, 0, '', '', '', '', 'text', '', 120, NULL, '0', '', '', 0, 0, 0, 0, 'group', '', '', 24, 'admin', '2020-03-19 10:25:32', '2020-03-17 22:10:01', 'admin', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `onl_cgform_field` VALUES ('0c90430d7a77591284d5b1939e136613', '4028818370e8d46b0170e8d46b4b0000', 'attachment_id', '？附件id', 'attachment_id', 0, 1, 'string', 36, 0, '', '', '', '', 'text', '', 120, NULL, '0', '', '', 0, 1, 1, 0, 'group', '', '', 12, 'admin', '2020-03-19 10:25:32', '2020-03-17 22:10:01', 'admin', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `onl_cgform_field` VALUES ('0cba94f0497d4d3d829fc573f58eff9f', '402860816bff91c0016bffa220a9000b', 'graduation_time', '毕业时间', 'graduation_time', 0, 1, 'Date', 0, 0, '', '', '', '', 'date', '', 120, NULL, '0', '', '', 0, 1, 1, 0, 'group', '', '', 16, 'admin', '2019-07-22 16:15:32', '2019-07-17 19:12:24', 'admin', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `onl_cgform_field` VALUES ('0cc947ff6e6e956898e5569f17ecbb59', '402881fe71c8c4fd0171c8c4fdae0000', 'amt', '金额', 'amt', 0, 1, 'BigDecimal', 18, 2, '', '', '', '', 'text', '', 120, NULL, '0', '', '', 0, 1, 1, 0, 'group', '', '', 6, 'admin', '2020-04-30 10:23:44', '2020-04-30 09:48:06', 'admin', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `onl_cgform_field` VALUES ('0d00c51a4ddad2598a587fadc968a8b2', '402860816bff91c0016bff91cfea0004', 'sys_org_code', '组织机构编码', 'sys_org_code', 0, 1, 'string', 50, 0, '', '', '', '', 'text', '', 120, NULL, '0', '', '', 0, 1, 1, 0, 'group', '', '', 13, 'admin', '2019-07-19 18:05:13', '2019-07-17 18:54:35', 'admin', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `onl_cgform_field` VALUES ('0d151721c347cd28d595f674e7ad803a', '7a584d85821b482c9a93757cf101fbe6', 'create_time', '创建日期', NULL, 0, 1, 'Date', 20, 0, '', '', '', '', 'datetime', '', 120, NULL, '0', '', '', 0, 0, 0, 0, 'single', '', '', 3, 'admin', '2020-02-23 18:18:33', '2020-02-23 17:41:10', 'admin', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `onl_cgform_field` VALUES ('0d1af03d9fb86b828e01450f8598bf86', '7a584d85821b482c9a93757cf101fbe6', 'f1', '字段1', NULL, 0, 1, 'String', 32, 0, '', '', '', '', 'text', '', 120, NULL, '0', '', '', 0, 1, 1, 0, 'single', '', '', 7, 'admin', '2020-02-23 18:18:33', '2020-02-23 17:41:10', 'admin', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `onl_cgform_field` VALUES ('0d61adcbccabe48672596eab44defe3f', '4028818370f308e90170f308e9080000', 'code', '编码', 'code', 0, 0, 'string', 50, 0, '', '', '', '', 'text', '', 120, NULL, '0', '', '', 1, 1, 1, 0, 'single', '', '', 2, 'admin', '2020-05-30 11:58:17', '2020-03-19 21:43:33', 'admin', '', '', '', '', '', NULL, '0', NULL, NULL, '1');
INSERT INTO `onl_cgform_field` VALUES ('0dccc5771d36d34e20375d38482b47c2', '4028818370e8d46b0170e8d46d350001', 'settle_qty', '结算数量', 'settle_qty', 0, 1, 'BigDecimal', 18, 6, '', '', '', '', 'text', '', 120, NULL, '0', '', '', 0, 1, 1, 0, 'group', '', '', 13, 'admin', '2020-03-17 22:14:27', '2020-03-17 22:10:01', 'admin', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `onl_cgform_field` VALUES ('0ddd0c0afc967a9ab6050401ca62a4be', 'e67d26b610dd414c884c4dbb24e71ce3', 'create_time', '创建日期', NULL, 0, 1, 'Date', 20, 0, '', '', '', '', 'datetime', '', 120, NULL, '0', '', '', 0, 0, 0, 0, 'single', '', '', 3, 'admin', '2019-04-24 11:03:32', '2019-04-24 11:02:57', 'admin', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `onl_cgform_field` VALUES ('0ef0220fae99805d954033c2077451d7', '402881fe72362af70172362afadf0001', 'mid', '主表', 'mid', 0, 0, 'string', 36, 0, '', '', '', '', 'text', '', 120, NULL, '0', '', '', 0, 0, 0, 0, 'single', 'fin_pur_invoice', 'id', 2, 'admin', '2020-05-21 20:23:41', '2020-05-21 15:38:06', 'admin', '', '', '', '', '', NULL, '0', NULL, NULL, '0');
INSERT INTO `onl_cgform_field` VALUES ('0f2bdbf5bf2ca495b21a3a5bdd10a73a', '40288183712beaa901712c0ebe7e0004', 'update_by', '修改人', 'update_by', 0, 1, 'string', 36, 0, '', '', '', '', 'text', '', 120, NULL, '0', '', '', 0, 1, 1, 1, 'group', '', '', 11, 'admin', '2020-03-30 23:41:18', '2020-03-30 23:28:16', 'admin', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `onl_cgform_field` VALUES ('0f7d72b22a3170611f3200207ed7860b', '402881ea71684fa00171684fa0680000', 'qty', '数量', 'qty', 0, 0, 'BigDecimal', 18, 6, '', '', '', '', 'text', '', 120, NULL, '0', '', '', 0, 1, 1, 1, 'group', '', '', 6, 'admin', '2020-04-11 16:28:45', '2020-04-11 16:16:22', 'admin', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `onl_cgform_field` VALUES ('0fb6fa76c5c78a1e957dbb411e110738', '402860816bff91c0016bff91d8830007', 'politically_status', '政治面貌', 'politically_status', 0, 1, 'string', 100, 0, '', '', '', '', 'text', '', 120, NULL, '0', '', '', 0, 1, 1, 0, 'group', '', '', 7, 'admin', '2019-07-19 18:04:41', '2019-07-17 18:54:37', 'admin', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `onl_cgform_field` VALUES ('101a73df0aa5199ac05c4ce92a4f0e3e', '4adec929a6594108bef5b35ee9966e9f', 'name', '姓名', NULL, 0, 1, 'String', 200, 0, '', '', '', '', 'text', '', 120, NULL, '0', '', '#{sysUserCode}', 0, 1, 1, 0, 'single', '', '', 3, 'admin', '2020-04-10 19:43:38', '2020-04-10 19:35:58', 'admin', '', '', '', '', '', NULL, '0', NULL, NULL, '0');
INSERT INTO `onl_cgform_field` VALUES ('105c8e44ad13026b641f0363601f30f3', 'e5464aa8fa7b47c580e91593cf9b46dc', 'num', '循环数量', NULL, 0, 1, 'int', 32, 0, '', '', '', '', 'text', '', 120, NULL, '0', '', '', 0, 1, 1, 0, 'single', '', '', 9, 'admin', '2019-04-24 17:09:49', '2019-04-24 11:05:10', 'admin', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `onl_cgform_field` VALUES ('109b10da01b5ae81659992a9a385647e', '402881fe724af1fc01724af1fc0c0000', 'version', '版本', 'version', 0, 1, 'int', 10, 0, '', '', '', '', 'text', '', 120, NULL, '0', '', '', 0, 0, 0, 0, 'single', '', '', 6, 'admin', '2020-05-25 16:39:51', '2020-05-25 16:27:53', 'admin', '', '', '', '', '', NULL, '0', NULL, NULL, '0');
INSERT INTO `onl_cgform_field` VALUES ('1130f1e252533529bb1167b896dffe32', 'deea5a8ec619460c9245ba85dbc59e80', 'update_time', '更新日期', NULL, 0, 1, 'Date', 20, 0, '', '', '', '', 'datetime', '', 120, NULL, '0', '', '', 0, 0, 0, 0, 'single', '', '', 5, 'admin', '2020-03-15 17:37:15', '2019-04-20 11:41:19', 'admin', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `onl_cgform_field` VALUES ('117fc4ba649d6690a3ac482ad5e4ad38', '56870166aba54ebfacb20ba6c770bd73', 'create_time', '创建日期', NULL, 0, 1, 'Date', 20, 0, '', '', '', '', 'datetime', '', 120, NULL, '0', '', '', 0, 0, 0, 0, 'single', '', '', 3, 'admin', '2019-11-21 17:58:27', '2019-04-20 11:38:39', 'admin', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `onl_cgform_field` VALUES ('118e3b324c27f78c235c1d8ebeaf8bfd', '402881e970dd8d520170dd90f7c30002', 'note3', 'note3', 'note3', 0, 1, 'string', 200, 0, '', '', '', '', 'text', '', 120, NULL, '0', '', '', 0, 1, 1, 0, 'group', '', '', 24, 'admin', '2020-03-15 21:40:40', '2020-03-15 17:40:31', 'admin', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `onl_cgform_field` VALUES ('130cde54be221b042f96d3da936619b9', '40288183712beaa901712c0ebcb10003', 'address_receipt', '收件信息收件人', 'address_receipt', 0, 1, 'string', 50, 0, '', '', '', '', 'text', '', 120, NULL, '0', '', '', 0, 1, 0, 0, 'group', '', '', 31, 'admin', '2020-03-31 00:04:14', '2020-03-30 23:28:16', 'admin', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `onl_cgform_field` VALUES ('13246645b7650491b70205d99703ca06', '402860816aa5921f016aa5dedcb90009', 'bpm_status', '流程状态', 'bpm_status', 0, 1, 'string', 32, 0, '1', 'bpm_status', '', '', 'text', '', 120, NULL, '0', '', '', 0, 0, 1, 0, 'group', '', '', 8, 'admin', '2019-05-11 15:56:47', '2019-05-11 15:50:08', 'admin', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `onl_cgform_field` VALUES ('1345983315581cf83569bc83e6c369eb', '40288183712a997c01712a997c580000', 'is_closed', '是否关闭', 'is_closed', 0, 1, 'int', 3, 0, '', '', '', '', 'text', '', 120, NULL, '0', '', '', 0, 1, 1, 0, 'group', '', '', 18, 'admin', '2020-03-30 16:48:20', '2020-03-30 16:40:35', 'admin', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `onl_cgform_field` VALUES ('135dd0ee50712722db65b8762bd487ea', '8994f2817b5a45d9890aa04497a317c5', 'update_time', '更新日期', NULL, 0, 1, 'date', 20, 0, '', '', '', '', 'text', '', 120, '', '0', '', '', 0, 1, 1, 0, 'single', '', '', 4, NULL, NULL, '2019-03-23 11:39:16', 'admin', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `onl_cgform_field` VALUES ('13dd6e19458a9b88fec1b6c7a20a3954', '402881fe724af1fc01724af1feaf0001', 'credit_amt', '贷方金额', 'credit_amt', 0, 1, 'BigDecimal', 18, 2, '', '', '', '', 'text', '', 120, NULL, '0', '', '', 0, 1, 1, 0, 'single', '', '', 9, 'admin', '2020-05-25 16:38:12', '2020-05-25 16:27:53', 'admin', '', '', '', '', '', NULL, '0', NULL, NULL, '0');
INSERT INTO `onl_cgform_field` VALUES ('141ee97d831ee779bd07e5528939c45e', '4028818370f308e90170f330ff050003', 'is_basic', '是否基准单位', 'is_basic', 0, 1, 'int', 3, 0, '', 'yn', '', '', 'list', '', 120, NULL, '0', '', '', 0, 1, 1, 0, 'group', '', '', 5, 'admin', '2020-03-19 22:35:29', '2020-03-19 22:27:20', 'admin', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `onl_cgform_field` VALUES ('142adadc902df5ded15d97e7f03fe8f6', '4028818371790b3f0171795b80ed0002', 'version', '版本', 'version', 0, 1, 'int', 10, 0, '', '', '', '', 'text', '', 120, NULL, '0', '', '', 0, 0, 0, 0, 'group', '', '', 11, 'admin', '2020-04-14 23:49:05', '2020-04-14 23:42:53', 'admin', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `onl_cgform_field` VALUES ('149bcf581023d9626f62b7194f60f7ea', '40288183712beaa901712beaa9a00000', 'attachment_id', '附件id', 'attachment_id', 0, 1, 'string', 36, 0, '', '', '', '', 'text', '', 120, NULL, '0', '', '', 0, 1, 1, 0, 'group', '', '', 13, 'admin', '2020-04-17 12:01:33', '2020-03-30 22:48:52', 'admin', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `onl_cgform_field` VALUES ('14ec4c83c29966ab42b6b718c5a3e774', '7ea60a25fa27470e9080d6a921aabbd1', 'create_by', '创建人', NULL, 0, 1, 'string', 50, 0, '', '', '', '', 'text', '', 120, NULL, '0', '', '', 0, 0, 0, 0, 'single', '', '', 2, NULL, NULL, '2019-04-17 00:22:21', 'admin', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `onl_cgform_field` VALUES ('150dfa44c734bea5027ff4ef75a258dd', '40288183712beaa901712c0ebcb10003', 'phone_invoice', '开票信息联系电话', 'phone_invoice', 0, 1, 'string', 50, 0, '', '', '', '', 'text', '', 120, NULL, '0', '', '', 0, 1, 0, 0, 'group', '', '', 22, 'admin', '2020-03-31 00:04:14', '2020-03-30 23:28:16', 'admin', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `onl_cgform_field` VALUES ('158125ca3cdf365075b1c897b40411db', '40288183712beaa901712c0eb77c0002', 'phone_financial', '财务信息联系电话', 'phone_financial', 0, 1, 'string', 50, 0, '', '', '', '', 'text', '', 120, NULL, '0', '', '', 0, 1, 0, 0, 'group', '', '', 17, 'admin', '2020-03-31 00:15:25', '2020-03-30 23:28:15', 'admin', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `onl_cgform_field` VALUES ('15e4da7c5ecbb8599a9815700af2c38a', '4028818370e8d46b0170e8d46d350001', 'qty', '数量', 'qty', 0, 1, 'BigDecimal', 18, 6, '', '', '', '', 'text', '', 120, NULL, '0', '', '', 0, 1, 1, 0, 'group', '', '', 7, 'admin', '2020-03-17 22:14:27', '2020-03-17 22:10:01', 'admin', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `onl_cgform_field` VALUES ('16363d0bc125125e395772278d0cf22e', '4b556f0168f64976a3d20bfb932bc798', 'update_time', '更新日期', NULL, 0, 1, 'Date', 20, 0, '', '', '', '', 'datetime', '', 120, NULL, '0', '', '', 0, 0, 0, 0, 'single', '', '', 5, NULL, NULL, '2019-04-12 23:38:28', 'admin', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `onl_cgform_field` VALUES ('169acbe19922395e1dac1aa3e3a33e35', '402881fe72362af70172362af7150000', 'bill_date', '单据日期', 'bill_date', 0, 0, 'Date', 0, 0, '', '', '', '', 'date', '', 120, NULL, '0', '', '', 0, 1, 1, 0, 'group', '', '', 3, 'admin', '2020-05-21 20:19:56', '2020-05-21 15:38:06', 'admin', '', '', '', '', '', NULL, '0', NULL, NULL, '0');
INSERT INTO `onl_cgform_field` VALUES ('1744db63c3601e52efd858c7b30e2fe4', '40288183712beaa901712c0ebcb10003', 'unit_invoice', '开票信息单位名称', 'unit_invoice', 0, 1, 'string', 200, 0, '', '', '', '', 'text', '', 120, NULL, '0', '', '', 0, 1, 0, 0, 'group', '', '', 18, 'admin', '2020-03-31 00:04:14', '2020-03-30 23:28:16', 'admin', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `onl_cgform_field` VALUES ('1756f238456372d3c9b572a05d096017', '40288183712a997c01712a997c580000', 'bill_date', '单据日期', 'bill_date', 0, 1, 'Date', 0, 0, '', '', '', '', 'date', '', 120, NULL, '0', '', '', 0, 1, 1, 0, 'group', '', '', 3, 'admin', '2020-03-30 16:48:20', '2020-03-30 16:40:35', 'admin', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `onl_cgform_field` VALUES ('1791eb71b1dc6125110b2c84d8800cf5', 'c20b114d92ed45eab356431a624dd12b', 'create_by', '创建人', NULL, 0, 1, 'string', 50, 0, '', '', '', '', 'text', '', 120, NULL, '0', '', '', 0, 0, 0, 0, 'single', '', '', 2, 'admin', '2020-03-20 11:41:31', '2020-03-20 11:29:28', 'admin', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `onl_cgform_field` VALUES ('179c290e383009810fb738f07bd5af8d', '402860816bff91c0016bff91d2810005', 'id', 'id', 'id', 1, 1, 'string', 32, 0, '', '', '', '', 'text', '', 120, NULL, '0', '', '', 0, 0, 0, 0, 'group', '', '', 1, 'admin', '2019-07-19 18:05:55', '2019-07-17 18:54:35', 'admin', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `onl_cgform_field` VALUES ('17cbda69da9dd3632625a0647c259070', '73162c3b8161413e8ecdca7eb288d0c9', 'wl_name', '物料名字', NULL, 0, 1, 'String', 200, 0, '', '', '', '', 'text', '', 120, NULL, '1', '', '', 0, 1, 1, 0, 'single', '', '', 7, 'admin', '2019-07-01 14:23:32', '2019-06-10 15:18:34', 'admin', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `onl_cgform_field` VALUES ('17d80c0daeabb89479c06cb6cb4cfb98', '40288101710a4c6201710a4c62b50000', 'id', 'ID', 'id', 1, 0, 'string', 36, 0, '', '', '', '', 'text', '', 120, NULL, '0', '', '', 0, 0, 0, 0, 'group', '', '', 1, 'admin', '2020-03-24 10:18:35', '2020-03-24 10:08:31', 'admin', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `onl_cgform_field` VALUES ('183a6197065e7639be3d13b44dde8743', '40288183712beaa901712c0ebcb10003', 'update_time', '修改时间', 'update_time', 0, 1, 'Date', 0, 0, '', '', '', '', 'date', '', 120, NULL, '0', '', '', 0, 1, 0, 1, 'group', '', '', 40, 'admin', '2020-03-31 00:04:14', '2020-03-30 23:28:16', 'admin', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `onl_cgform_field` VALUES ('1840170d7369b94faa61dfe6239cd124', '4028818371790b3f0171790b43ac0001', 'version', '版本', 'version', 0, 1, 'int', 10, 0, '', '', '', '', 'text', '', 120, NULL, '0', '', '', 0, 0, 0, 0, 'group', '', '', 12, 'admin', '2020-04-14 23:25:38', '2020-04-14 22:15:14', 'admin', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `onl_cgform_field` VALUES ('185d3e06502852ebd09d6c69b8fb1116', '402881e970dd8d520170dd90f7c30002', 'entry_no', '分录号', 'entry_no', 0, 0, 'int', 10, 0, '', '', '', '', 'text', '', 120, NULL, '0', '', '', 0, 1, 1, 0, 'group', '', '', 4, 'admin', '2020-03-15 21:40:40', '2020-03-15 17:40:31', 'admin', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `onl_cgform_field` VALUES ('18d80eb25c5ecf58ba90e5840654c5d6', '4028818370e8d46b0170e8d46b4b0000', 'voided', '是否作废', 'voided', 0, 1, 'int', 3, 0, '', '', '', '', 'text', '', 120, NULL, '0', '', '', 0, 1, 1, 0, 'group', '', '', 22, 'admin', '2020-03-19 10:25:32', '2020-03-17 22:10:01', 'admin', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `onl_cgform_field` VALUES ('18fefb2257901f05508f8ec13ada78a3', 'e5464aa8fa7b47c580e91593cf9b46dc', 'id', '主键', NULL, 1, 0, 'string', 36, 0, '', '', '', '', 'text', '', 120, NULL, '0', '', '', 0, 0, 0, 0, 'single', '', '', 1, 'admin', '2019-04-24 17:09:48', '2019-04-24 11:05:10', 'admin', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `onl_cgform_field` VALUES ('190cae2b65b03816e81936f2309f5a35', '4028818370f308e90170f308eabf0001', 'is_enabled', '是否启用', 'is_enabled', 0, 0, 'int', 3, 0, '1', 'yn', '', '', 'list', '', 120, NULL, '0', '', '', 0, 1, 1, 0, 'group', '', '', 7, 'admin', '2020-05-29 20:32:59', '2020-03-19 21:43:33', 'admin', '', '', '', '', '', NULL, '0', NULL, NULL, '0');
INSERT INTO `onl_cgform_field` VALUES ('19221be9e74dca6725f84d5548c31107', '40288101717185240171718524d60000', 'remark', '备注', 'remark', 0, 1, 'string', 200, 0, '', '', '', '', 'text', '', 120, NULL, '0', '', '', 0, 1, 1, 0, 'group', '', '', 9, 'admin', '2020-04-13 14:00:53', '2020-04-13 11:11:24', 'admin', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `onl_cgform_field` VALUES ('192fbb85ac6a8c7160ae7a4b352db389', '40288101717185240171718524d60000', 'update_by', '修改人', 'update_by', 0, 1, 'string', 36, 0, '', 'username', 'sys_user', 'realname', 'list', '', 120, NULL, '0', '', '', 0, 1, 1, 0, 'group', '', '', 20, 'admin', '2020-04-13 14:00:54', '2020-04-13 11:11:24', 'admin', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `onl_cgform_field` VALUES ('1973ef1d3728fbff2db6a352e001f5f7', 'fb7125a344a649b990c12949945cb6c1', 'name', '用户名', NULL, 0, 1, 'string', 32, 0, '', '', '', '', 'text', '', 120, '', '0', '', '', 0, 1, 1, 0, 'single', '', '', 5, 'admin', '2019-03-26 19:24:11', '2019-03-26 19:01:52', 'admin', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `onl_cgform_field` VALUES ('1ab5be1f937f393b3e5cc214ef1b855c', '7ea60a25fa27470e9080d6a921aabbd1', 'update_by', '更新人', NULL, 0, 1, 'string', 50, 0, '', '', '', '', 'text', '', 120, NULL, '0', '', '', 0, 0, 0, 0, 'single', '', '', 4, NULL, NULL, '2019-04-17 00:22:21', 'admin', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `onl_cgform_field` VALUES ('1aeaecc53246f60c4255ed125418ca62', '4028818370e8d46b0170e8d46d350001', 'entry_no', '分录号', 'entry_no', 0, 0, 'int', 10, 0, '', '', '', '', 'text', '', 120, NULL, '0', '', '', 0, 1, 1, 0, 'group', '', '', 4, 'admin', '2020-03-17 22:14:27', '2020-03-17 22:10:01', 'admin', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `onl_cgform_field` VALUES ('1b16530f10c24095f65f9ed8892f269a', '402881e970dd8d520170ddb3a6490004', 'remark3', 'remark3', 'remark3', 0, 1, 'string', 50, 0, '', '', '', '', 'text', '', 120, NULL, '0', '', '', 0, 1, 1, 0, 'group', '', '', 15, 'admin', '2020-03-16 22:39:53', '2020-03-15 18:18:23', 'admin', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `onl_cgform_field` VALUES ('1b3dd504f2e96dd2c93d401d0c66b1d4', '402881e970dd8d520170ddb3a6490004', 'id', 'id', 'id', 1, 0, 'string', 36, 0, '', '', '', '', 'text', '', 120, NULL, '0', '', '', 0, 0, 0, 0, 'group', '', '', 1, 'admin', '2020-03-16 22:39:53', '2020-03-15 18:18:23', 'admin', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `onl_cgform_field` VALUES ('1b4d44ceb3f8a2da39b9f51ed727b6e8', '40288183712beaa901712c0eb77c0002', 'unit_invoice', '开票信息单位名称', 'unit_invoice', 0, 1, 'string', 200, 0, '', '', '', '', 'text', '', 120, NULL, '0', '', '', 0, 1, 0, 0, 'group', '', '', 18, 'admin', '2020-03-31 00:15:25', '2020-03-30 23:28:15', 'admin', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `onl_cgform_field` VALUES ('1b6c7b95028bed9ff656d65557dd2bdf', '402860816bff91c0016bffa220a9000b', 'user_id', '用户id', 'user_id', 0, 1, 'string', 32, 0, '', '', '', '', 'text', '', 120, NULL, '0', '', '', 0, 1, 1, 0, 'group', '', '', 3, 'admin', '2019-07-22 16:15:32', '2019-07-17 19:12:24', 'admin', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `onl_cgform_field` VALUES ('1c2f307e315bac77a6d3f02e88387a43', 'deea5a8ec619460c9245ba85dbc59e80', 'id', '主键', NULL, 1, 0, 'string', 36, 0, '', '', '', '', 'text', '', 120, NULL, '0', '', '', 0, 0, 0, 0, 'single', '', '', 1, 'admin', '2020-03-15 17:37:15', '2019-04-20 11:41:19', 'admin', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `onl_cgform_field` VALUES ('1c3b2ad0a52ecb47fa7fd53f25875beb', 'deea5a8ec619460c9245ba85dbc59e80', 'price', '价格', NULL, 0, 1, 'double', 32, 0, '', '', '', '', 'text', '', 120, 'n', '0', '', '', 0, 1, 1, 0, 'single', '', '', 7, 'admin', '2020-03-15 17:37:15', '2019-04-20 11:41:19', 'admin', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `onl_cgform_field` VALUES ('1c4d25a12388c80d397bb4f4664fe4e6', '4b556f0168f64976a3d20bfb932bc798', 'update_by', '更新人', NULL, 0, 1, 'string', 50, 0, '', '', '', '', 'text', '', 120, NULL, '0', '', '', 0, 0, 0, 0, 'single', '', '', 4, NULL, NULL, '2019-04-12 23:38:28', 'admin', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `onl_cgform_field` VALUES ('1c562f53856b641504e70b2623bd479b', '402881fe71c8c4fd0171c8c4fdae0000', 'is_approved', '是否通过', 'is_approved', 0, 1, 'int', 3, 0, '', 'yn', '', '', 'list', '', 120, NULL, '0', '', '', 1, 1, 1, 1, 'single', '', '', 12, 'admin', '2020-04-30 10:23:44', '2020-04-30 09:48:06', 'admin', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `onl_cgform_field` VALUES ('1ca0f35fa8d925edc1bde7fc48b2088b', '40288183712beaa901712beaad3c0001', 'source_type', '源单类型', 'source_type', 0, 1, 'string', 20, 0, '', '', '', '', 'text', '', 120, NULL, '0', '', '', 0, 0, 0, 0, 'group', '', '', 4, 'admin', '2020-05-04 21:41:29', '2020-03-30 22:48:53', 'admin', '', '', '', '', '', NULL, '0', NULL, NULL, '0');
INSERT INTO `onl_cgform_field` VALUES ('1ca16ccbcf198ad0fa1d4ec2ffd36ff6', '402881fe724af1fc01724af1fc0c0000', 'begin_month', '启用月度', 'begin_month', 0, 0, 'int', 3, 0, '', '', '', '', 'text', '', 120, NULL, '0', '', '', 0, 1, 1, 0, 'single', '', '', 3, 'admin', '2020-05-25 16:39:51', '2020-05-25 16:27:53', 'admin', '', '', '', '', '', NULL, '0', NULL, NULL, '0');
INSERT INTO `onl_cgform_field` VALUES ('1cb7bf00f4afa6bb99609c88e5393462', '402881fe724af1fc01724af1feaf0001', 'month', '业务月度', 'month', 0, 0, 'int', 3, 0, '', '', '', '', 'text', '', 120, NULL, '0', '', '', 1, 1, 1, 0, 'single', '', '', 3, 'admin', '2020-05-25 16:38:12', '2020-05-25 16:27:53', 'admin', '', '', '', '', '', NULL, '0', NULL, NULL, '0');
INSERT INTO `onl_cgform_field` VALUES ('1cfe967bb457cbaa6e041e45d019b583', '402860816bff91c0016bff91c7010001', 'update_time', '更新时间', 'update_time', 0, 1, 'Date', 0, 0, '', '', '', '', 'date', '', 120, NULL, '0', '', '', 0, 1, 1, 0, 'group', '', '', 10, 'admin', '2019-07-19 18:07:47', '2019-07-17 18:54:32', 'admin', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `onl_cgform_field` VALUES ('1d95bdf1120c5a1776df022d0a571f21', '4fb8e12a697f4d5bbe9b9fb1e9009486', 'create_time', '创建日期', NULL, 0, 1, 'Date', 20, 0, '', '', '', '', 'datetime', '', 120, NULL, '0', '', '', 0, 0, 0, 0, 'single', '', '', 7, 'admin', '2020-04-10 19:51:27', '2020-04-10 19:47:01', 'admin', '', '', '', '', '', 'text', '0', NULL, NULL, '0');
INSERT INTO `onl_cgform_field` VALUES ('1e3d8cfbf12155559666a23ee2c6c5ca', 'e5464aa8fa7b47c580e91593cf9b46dc', 'update_time', '更新日期', NULL, 0, 1, 'Date', 20, 0, '', '', '', '', 'datetime', '', 120, NULL, '0', '', '', 0, 0, 0, 0, 'single', '', '', 5, 'admin', '2019-04-24 17:09:49', '2019-04-24 11:05:10', 'admin', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `onl_cgform_field` VALUES ('1e6b5b4e5de6dda4a0742eaef335de81', '402881fe72268ef10172268ef1370000', 'remark', '备注', 'remark', 0, 1, 'string', 200, 0, '', '', '', '', 'text', '', 120, NULL, '0', '', '', 0, 1, 1, 0, 'single', '', '', 8, 'admin', '2020-05-18 15:50:07', '2020-05-18 14:53:22', 'admin', '', '', '', '', '', NULL, '0', NULL, NULL, '0');
INSERT INTO `onl_cgform_field` VALUES ('1ed46fdeb289bd7805c9b83332ccd3b4', '402860816bff91c0016bff91d2810005', 'relation', '关系', 'relation', 0, 1, 'string', 20, 0, '', '', '', '', 'text', '', 120, NULL, '0', '', '', 0, 1, 1, 0, 'group', '', '', 4, 'admin', '2019-07-19 18:05:55', '2019-07-17 18:54:35', 'admin', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `onl_cgform_field` VALUES ('1ee42b8ae433b6514e14f4ae2a1976c4', '40288183712beaa901712c0eb77c0002', 'fax_receipt', '收件信息传真', 'fax_receipt', 0, 1, 'string', 50, 0, '', '', '', '', 'text', '', 120, NULL, '0', '', '', 0, 1, 0, 0, 'group', '', '', 33, 'admin', '2020-03-31 00:15:25', '2020-03-30 23:28:15', 'admin', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `onl_cgform_field` VALUES ('1eea231dd07cd283dec07259e215489f', '40288183712a997c01712a99809e0001', 'batch_no', '批次号', 'batch_no', 0, 1, 'string', 100, 0, NULL, NULL, NULL, NULL, 'text', NULL, 120, NULL, '0', NULL, NULL, 0, 1, 1, 0, 'group', NULL, NULL, 9, NULL, NULL, '2020-03-30 16:40:36', 'admin', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `onl_cgform_field` VALUES ('1ef37268388f6a2eb56e96b33b28b940', '402881fe72362af70172362afadf0001', 'note3', '备注3', 'note3', 0, 1, 'string', 50, 0, '', '', '', '', 'text', '', 120, NULL, '0', '', '', 0, 1, 1, 0, 'single', '', '', 13, 'admin', '2020-05-21 20:23:41', '2020-05-21 15:38:06', 'admin', '', '', '', '', '', NULL, '0', NULL, NULL, '0');
INSERT INTO `onl_cgform_field` VALUES ('1f0c6d33b79713fe79fb30373c81f6f7', '758334cb1e7445e2822b60e807aec4a3', 'update_time', '更新日期', NULL, 0, 1, 'Date', 20, 0, '', '', '', '', 'datetime', '', 120, NULL, '0', '', '', 0, 0, 0, 0, 'single', '', '', 5, NULL, NULL, '2019-10-18 18:02:09', 'admin', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `onl_cgform_field` VALUES ('1f23a0ea68a843fc343b1581e8c946e5', '402881fe72362af70172362af7150000', 'create_time', '创建时间', 'create_time', 0, 1, 'Date', 0, 0, '', '', '', '', 'date', '', 120, NULL, '0', '', '', 0, 1, 1, 0, 'single', '', '', 23, 'admin', '2020-05-21 20:19:56', '2020-05-21 15:38:06', 'admin', '', '', '', '', '', NULL, '0', NULL, NULL, '0');
INSERT INTO `onl_cgform_field` VALUES ('1f54b0d6992b4c722acac391f3a0b241', '402881fe71c8c4fd0171c8c503230002', 'id', 'ID', 'id', 1, 0, 'string', 36, 0, '', '', '', '', 'text', '', 120, NULL, '0', '', '', 0, 0, 0, 0, 'group', '', '', 1, 'admin', '2020-04-30 10:30:53', '2020-04-30 09:48:07', 'admin', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `onl_cgform_field` VALUES ('1f66d9181f79a79f260c9b0c85f36d36', '40288183712beaa901712c0eb77c0002', 'postcode_receipt', '收件信息邮编', 'postcode_receipt', 0, 1, 'string', 20, 0, '', '', '', '', 'text', '', 120, NULL, '0', '', '', 0, 1, 0, 0, 'group', '', '', 30, 'admin', '2020-03-31 00:15:25', '2020-03-30 23:28:15', 'admin', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `onl_cgform_field` VALUES ('1f9647e61522400cc5108e0812f21377', '4028818370f308e90170f308e9080000', 'id', 'ID', 'id', 1, 0, 'string', 36, 0, '', '', '', '', 'text', '', 120, NULL, '0', '', '', 0, 0, 0, 0, 'group', '', '', 1, 'admin', '2020-05-30 11:58:17', '2020-03-19 21:43:33', 'admin', '', '', '', '', '', NULL, '0', NULL, NULL, '0');
INSERT INTO `onl_cgform_field` VALUES ('1fa5f07b3e70d4925b69b2bf51309421', '56870166aba54ebfacb20ba6c770bd73', 'update_time', '更新日期', NULL, 0, 1, 'Date', 20, 0, '', '', '', '', 'datetime', '', 120, NULL, '0', '', '', 0, 0, 0, 0, 'single', '', '', 5, 'admin', '2019-11-21 17:58:27', '2019-04-20 11:38:39', 'admin', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `onl_cgform_field` VALUES ('1fa65e31205795966c4832ae81ba169a', '402881ea71684fa00171684fa0680000', 'cost', '成本', 'cost', 0, 0, 'BigDecimal', 18, 2, '', '', '', '', 'text', '', 120, NULL, '0', '', '', 0, 1, 1, 1, 'group', '', '', 7, 'admin', '2020-04-11 16:28:45', '2020-04-11 16:16:22', 'admin', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `onl_cgform_field` VALUES ('1fedd620f910f41848120883c391ddc5', '402881fe71c8c4fd0171c8c503230002', 'source_id', '源单id', 'source_id', 0, 1, 'string', 36, 0, '', '', '', '', 'text', '', 120, NULL, '0', '', '', 0, 1, 1, 1, 'group', '', '', 7, 'admin', '2020-04-30 10:30:53', '2020-04-30 09:48:07', 'admin', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `onl_cgform_field` VALUES ('20759eec452b24dc2ea83bd7858b04ad', '402881fe72362af70172362af7150000', 'bill_proc_status', '处理状态', 'bill_proc_status', 0, 1, 'string', 4, 0, '', 'x_bill_proc_status', '', '', 'list', '', 120, NULL, '0', '', '', 0, 1, 1, 0, 'single', '', '', 14, 'admin', '2020-05-21 20:19:56', '2020-05-21 15:38:06', 'admin', '', '', '', '', '', NULL, '0', NULL, NULL, '0');
INSERT INTO `onl_cgform_field` VALUES ('209ddb923d8dab9f454d56d82c0cc725', '3d447fa919b64f6883a834036c14aa67', 'create_by', '创建人', NULL, 0, 1, 'string', 50, 0, '', '', '', '', 'text', '', 120, NULL, '0', '', '', 0, 0, 0, 0, 'single', '', '', 6, 'admin', '2020-02-21 17:58:46', '2020-02-20 16:19:00', 'admin', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `onl_cgform_field` VALUES ('20ff34fb0466089cb633d73d5a6f08d6', 'd35109c3632c4952a19ecc094943dd71', 'update_time', '更新日期', NULL, 0, 1, 'date', 20, 0, '', '', '', '', 'text', '', 120, '', '0', '', '', 0, 0, 0, 0, 'single', '', '', 4, 'admin', '2020-02-23 18:11:41', '2019-03-15 14:24:35', 'admin', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `onl_cgform_field` VALUES ('2113a4ec7b88b4820dcbbdf96e46bbb7', 'fbc35f067da94a70adb622ddba259352', 'create_time', '创建日期', NULL, 0, 1, 'Date', 20, 0, '', '', '', '', 'datetime', '', 120, NULL, '0', '', '', 0, 0, 0, 0, 'single', '', '', 3, NULL, NULL, '2019-07-03 19:44:23', 'admin', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `onl_cgform_field` VALUES ('2150e48b2cb6072d2d8ecd79a7daf7cc', '402860816bff91c0016bff91ca7e0002', 'create_time', '创建时间', 'create_time', 0, 1, 'Date', 0, 0, '', '', '', '', 'date', '', 120, NULL, '0', '', '', 0, 1, 1, 0, 'group', '', '', 10, 'admin', '2019-07-19 18:07:13', '2019-07-17 18:54:33', 'admin', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `onl_cgform_field` VALUES ('218d2c0dab3bc9a9f97e566ac4a6feb1', '4028818371790b3f0171795b80ed0002', 'update_time', '修改时间', 'update_time', 0, 1, 'Date', 0, 0, '', '', '', '', 'date', '', 120, NULL, '0', '', '', 0, 1, 1, 0, 'group', '', '', 10, 'admin', '2020-04-14 23:49:05', '2020-04-14 23:42:53', 'admin', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `onl_cgform_field` VALUES ('220b03d0f8ad1a4a62b68e7a341a3c72', '40288101717185240171718524d60000', 'id', 'ID', 'id', 1, 0, 'string', 36, 0, '', '', '', '', 'text', '', 120, NULL, '0', '', '', 0, 0, 0, 0, 'group', '', '', 1, 'admin', '2020-04-13 14:00:53', '2020-04-13 11:11:24', 'admin', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `onl_cgform_field` VALUES ('22c83b02133b30fe3d531c21bcb13d59', '402881fe71c8c4fd0171c8c4fdae0000', 'sys_org_code', '创建部门', 'sys_org_code', 0, 1, 'string', 50, 0, '', 'org_code', 'sys_depart', 'depart_name', 'list', '', 120, NULL, '0', '', '', 0, 1, 1, 1, 'group', '', '', 20, 'admin', '2020-04-30 10:23:44', '2020-04-30 09:48:06', 'admin', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `onl_cgform_field` VALUES ('2323239efb5a40b73034411868dfc41d', 'fb19fb067cd841f9ae93d4eb3b883dc0', 'update_by', '更新人登录名称', NULL, 0, 1, 'string', 50, 0, '', '', '', '', 'text', '', 120, '', '0', '', '', 0, 1, 1, 0, 'single', '', '', 3, NULL, NULL, '2019-03-23 11:39:48', 'admin', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `onl_cgform_field` VALUES ('232d576d56125f4b3c3f835b306f7e2c', '4028818371790b3f0171790b3f780000', 'flow_id', '流程', 'flow_id', 0, 1, 'string', 36, 0, '', '', '', '', 'text', '', 120, NULL, '0', '', '', 0, 1, 1, 1, 'group', '', '', 17, 'admin', '2020-04-14 23:41:28', '2020-04-14 22:15:13', 'admin', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `onl_cgform_field` VALUES ('234680bb4f1db86a36fc26ce94f380c9', '40288183712beaa901712beaad3c0001', 'purchase_cost', '购进成本', 'purchase_cost', 0, 1, 'BigDecimal', 18, 6, '', '', '', '', 'text', '', 120, NULL, '0', '', '', 0, 1, 1, 0, 'group', '', '', 11, 'admin', '2020-05-04 21:41:29', '2020-03-30 22:48:53', 'admin', '', '', '', '', '', NULL, '0', NULL, NULL, '0');
INSERT INTO `onl_cgform_field` VALUES ('236786601cf9b0f5b5ce20d4a1bc89b5', '4028818371790b3f0171795b83bd0003', 'is_enabled', '是否启用', 'is_enabled', 0, 0, 'int', 3, 0, '', 'yn', '', '', 'list', '', 120, NULL, '0', '', '', 0, 1, 1, 0, 'group', '', '', 11, 'admin', '2020-04-14 23:46:44', '2020-04-14 23:42:53', 'admin', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `onl_cgform_field` VALUES ('23cbda19e86dd6334e5e5e37833086b6', '402881fe72268ef10172268ef1370000', 'material_category_id', '物料分类', 'material_category_id', 0, 1, 'string', 36, 0, '', 'id', 'bas_material_category', 'name', 'list', '', 120, NULL, '0', '', '', 1, 1, 1, 0, 'single', '', '', 5, 'admin', '2020-05-18 15:50:07', '2020-05-18 14:53:22', 'admin', '', '', '', '', '', NULL, '0', NULL, NULL, '0');
INSERT INTO `onl_cgform_field` VALUES ('23d6b28102b5b93f755f97e3e371860a', '40288183712beaa901712beaad3c0001', 'entry_no', '分录号', 'entry_no', 0, 0, 'int', 10, 0, '', '', '', '', 'text', '', 120, NULL, '0', '', '', 0, 1, 1, 0, 'group', '', '', 3, 'admin', '2020-05-04 21:41:29', '2020-03-30 22:48:53', 'admin', '', '', '', '', '', NULL, '0', NULL, NULL, '0');
INSERT INTO `onl_cgform_field` VALUES ('23e026863807104e1d59248f50430b8f', '4028818371790b3f0171790b3f780000', 'bill_no', '单据编号', 'bill_no', 0, 0, 'string', 50, 0, '', '', '', '', 'text', '', 120, NULL, '0', '', '${payment_bill_no}', 1, 1, 1, 0, 'single', '', '', 2, 'admin', '2020-04-14 23:41:28', '2020-04-14 22:15:13', 'admin', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `onl_cgform_field` VALUES ('23f42061ed218bdbc1262913c071e1cd', 'e5464aa8fa7b47c580e91593cf9b46dc', 'iz_valid', '启动状态', NULL, 0, 1, 'int', 2, 0, '', 'air_china_valid', '', '', 'list', '', 120, NULL, '0', '', '', 0, 1, 1, 0, 'single', '', '', 12, 'admin', '2019-04-24 17:09:49', '2019-04-24 14:09:06', 'admin', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `onl_cgform_field` VALUES ('242cc59b23965a92161eca69ffdbf018', 'd35109c3632c4952a19ecc094943dd71', 'age', '年龄', NULL, 0, 1, 'int', 32, 0, '', '', '', '', 'text', '', 120, '', '0', '', '', 0, 1, 1, 0, 'single', '', '', 7, 'admin', '2020-02-23 18:11:41', '2019-03-15 14:24:35', 'admin', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `onl_cgform_field` VALUES ('24634d4ec2c13e222f754bd4a42b5da5', '4028818371790b3f0171795b83bd0003', 'version', '版本', 'version', 0, 1, 'int', 10, 0, '', '', '', '', 'text', '', 120, NULL, '0', '', '', 0, 0, 0, 0, 'group', '', '', 16, 'admin', '2020-04-14 23:46:44', '2020-04-14 23:42:53', 'admin', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `onl_cgform_field` VALUES ('24fed40f5f56646d3170807dad664727', '40288183712beaa901712c0ebcb10003', 'contacts_financial', '财务信息联系人', 'contacts_financial', 0, 1, 'string', 50, 0, '', '', '', '', 'text', '', 120, NULL, '0', '', '', 0, 1, 0, 0, 'group', '', '', 16, 'admin', '2020-03-31 00:04:14', '2020-03-30 23:28:16', 'admin', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `onl_cgform_field` VALUES ('253080b2ed5f4add61eb0eb91d022372', '4028818370e8d46b0170e8d46b4b0000', 'customer_id', '客户', 'customer_id', 0, 1, 'string', 36, 0, '', '', '', '', 'text', '', 120, NULL, '0', '', '', 0, 1, 1, 0, 'group', '', '', 10, 'admin', '2020-03-19 10:25:32', '2020-03-17 22:10:01', 'admin', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `onl_cgform_field` VALUES ('2578726fef39b3efdfc442a0760cd190', '402881fe72362af70172362af7150000', 'bill_no', '单据编号', 'bill_no', 0, 0, 'string', 50, 0, '', '', '', '', 'text', '', 120, NULL, '0', '', '', 0, 1, 1, 1, 'single', '', '', 2, 'admin', '2020-05-21 20:19:56', '2020-05-21 15:38:06', 'admin', '', '', '', '', '', NULL, '0', NULL, NULL, '1');
INSERT INTO `onl_cgform_field` VALUES ('25ad602d625010265862f1f2b8b4fc83', '40288183712beaa901712beaa9a00000', 'flow_id', '流程id', 'flow_id', 0, 1, 'string', 36, 0, '', '', '', '', 'text', '', 120, NULL, '0', '', '', 0, 1, 1, 1, 'group', '', '', 17, 'admin', '2020-04-17 12:01:33', '2020-03-30 22:48:52', 'admin', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `onl_cgform_field` VALUES ('25cb1585a60299c4575900b032265236', '402881017185937c017185937c100000', 'bill_no', '单据编号', 'bill_no', 0, 0, 'string', 50, 0, '', '', '', '', 'text', '', 120, NULL, '0', '', '${rp_check_bill_no}', 1, 1, 1, 1, 'single', '', '', 2, 'admin', '2020-04-17 11:31:14', '2020-04-17 08:39:28', 'admin', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `onl_cgform_field` VALUES ('265702edb8872e322fe72d3640e34ac5', '402860816bff91c0016bff91cfea0004', 'from_time', '开始日期', 'from_time', 0, 1, 'Date', 0, 0, '', '', '', '', 'date', '', 120, NULL, '0', '', '', 0, 1, 1, 0, 'group', '', '', 3, 'admin', '2019-07-19 18:05:13', '2019-07-17 18:54:35', 'admin', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `onl_cgform_field` VALUES ('26764e38efd983e2fae913a96949254c', '40288101717185240171718524d60000', 'bill_proc_status', '处理状态', NULL, 0, 1, 'String', 4, 0, '', 'x_bill_proc_status', '', '', 'list', '', 120, NULL, '0', '', '', 0, 1, 1, 0, 'single', '', '', 11, NULL, NULL, '2020-04-13 14:00:54', 'admin', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `onl_cgform_field` VALUES ('26e55191ebbae5123d2e1344ef37b814', '40288183712beaa901712beaa9a00000', 'clerk_id', '业务员', NULL, 0, 1, 'String', 36, 0, '', 'username', 'sys_user', 'realname', 'sel_user', '', 120, NULL, '0', '', '', 1, 1, 1, 0, 'single', '', '', 7, 'admin', '2020-04-17 12:01:33', '2020-03-30 23:09:46', 'admin', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `onl_cgform_field` VALUES ('270bc82ddf1419fb2d4d81b2e1ee7749', '40288183712beaa901712beaa9a00000', 'stock_io_type', '出入库类型', 'stock_io_type', 0, 1, 'string', 10, 0, '', 'x_stock_io_type', '', '', 'list', '', 120, NULL, '0', '', '', 0, 1, 1, 1, 'group', '', '', 2, 'admin', '2020-04-17 12:01:33', '2020-03-30 22:48:52', 'admin', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `onl_cgform_field` VALUES ('2739ab1ece4d6053ba931bb6572f4ed8', '4028839a6de2ebd3016de2ebd3870000', 'iz_valid', '启用状态', 'iz_valid', 0, 1, 'string', 2, 0, NULL, NULL, NULL, NULL, 'text', NULL, 120, NULL, '0', NULL, NULL, 0, 1, 1, 0, 'group', NULL, NULL, 9, NULL, NULL, '2019-10-19 15:29:30', 'admin', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `onl_cgform_field` VALUES ('27712d9bd11c126e6665c07894f447fb', '402881fe72268ef10172268ef3ec0001', 'book_qty', '账存数量', 'book_qty', 0, 1, 'BigDecimal', 18, 6, '', '', '', '', 'text', '', 120, NULL, '0', '', '', 0, 1, 1, 0, 'single', '', '', 11, 'admin', '2020-05-18 15:55:16', '2020-05-18 14:53:23', 'admin', '', '', '', '', '', NULL, '0', NULL, NULL, '0');
INSERT INTO `onl_cgform_field` VALUES ('27887f84ba794e2cb69473bcd1a270a9', '40288183712a997c01712a99809e0001', 'id', 'ID', 'id', 1, 0, 'string', 36, 0, NULL, NULL, NULL, NULL, 'text', NULL, 120, NULL, '0', NULL, NULL, 0, 0, 0, 0, 'group', NULL, NULL, 1, NULL, NULL, '2020-03-30 16:40:36', 'admin', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `onl_cgform_field` VALUES ('27b81c6afecdc9cefcd6e17c5fced970', '40288183712beaa901712beaad3c0001', 'remark2', '备注2', 'remark2', 0, 1, 'string', 50, 0, '', '', '', '', 'text', '', 120, NULL, '0', '', '', 0, 1, 1, 0, 'group', '', '', 24, 'admin', '2020-05-04 21:41:29', '2020-03-30 22:48:53', 'admin', '', '', '', '', '', NULL, '0', NULL, NULL, '0');
INSERT INTO `onl_cgform_field` VALUES ('27bbd7d532726fef4bd9e49c1c753dd4', '40288101710a4c6201710a4c62b50000', 'basic_id', '基准单位', 'basic_id', 0, 1, 'string', 36, 0, '', 'id', 'bas_measure_unit', 'name', 'text', '', 120, NULL, '0', '', '', 0, 1, 1, 0, 'group', '', '', 6, 'admin', '2020-03-24 10:18:35', '2020-03-24 10:08:31', 'admin', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `onl_cgform_field` VALUES ('283f42283b9d0bf3b95ba3384ab2d255', '758334cb1e7445e2822b60e807aec4a3', 'update_by', '更新人', NULL, 0, 1, 'string', 50, 0, '', '', '', '', 'text', '', 120, NULL, '0', '', '', 0, 0, 0, 0, 'single', '', '', 4, NULL, NULL, '2019-10-18 18:02:09', 'admin', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `onl_cgform_field` VALUES ('284864d99fddfdcb00e188e3a512cb28', '1acb6f81a1d9439da6cc4e868617b565', 'no', '预算表序号', NULL, 0, 1, 'string', 50, 0, '', '', '', '', 'text', '', 120, NULL, '0', '', '', 0, 1, 1, 0, 'single', '', '', 10, 'admin', '2019-06-10 14:47:14', '2019-04-23 22:58:19', 'admin', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `onl_cgform_field` VALUES ('2887278482ca7b1fb9b56c224a6b7cf3', '4028818371790b3f0171790b43ac0001', 'mid', '主表', 'mid', 0, 0, 'string', 36, 0, '', '', '', '', 'text', '', 120, NULL, '0', '', '', 0, 0, 0, 0, 'group', 'fin_payment', 'id', 2, 'admin', '2020-04-14 23:25:38', '2020-04-14 22:15:14', 'admin', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `onl_cgform_field` VALUES ('2889d3cef706f91e092d76a56b8055be', '402860816bff91c0016bff91cda80003', 'order_no', '序号', 'order_no', 0, 1, 'int', 10, 0, '', '', '', '', 'text', '', 120, NULL, '0', '', '', 0, 1, 1, 0, 'group', '', '', 8, 'admin', '2019-07-19 18:06:36', '2019-07-17 18:54:34', 'admin', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `onl_cgform_field` VALUES ('28f861b4a8c3649c402b42013b7d7266', '40288183712beaa901712c0ebcb10003', 'supplier_level', '等级', 'supplier_level', 0, 1, 'string', 10, 0, '', 'x_supplier_level', '', '', 'list', '', 120, NULL, '0', '', '', 0, 1, 1, 0, 'group', '', '', 5, 'admin', '2020-03-31 00:04:14', '2020-03-30 23:28:16', 'admin', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `onl_cgform_field` VALUES ('2960787ab8bbf4baa5b9fcc9121a47c2', '402881017185937c017185937c100000', 'sys_org_code', '创建部门', 'sys_org_code', 0, 1, 'string', 50, 0, '', '', '', '', 'text', '', 120, NULL, '0', '', '', 0, 1, 1, 1, 'group', '', '', 17, 'admin', '2020-04-17 11:31:14', '2020-04-17 08:39:28', 'admin', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `onl_cgform_field` VALUES ('29709aa8e888e718931bfe8e744f000b', '402881fe72362af70172362afadf0001', 'invoice_amount', '开票金额', 'invoice_amount', 0, 0, 'BigDecimal', 18, 2, '', '', '', '', 'text', '', 120, NULL, '0', '', '', 0, 1, 1, 0, 'single', '', '', 10, 'admin', '2020-05-21 20:23:41', '2020-05-21 15:38:06', 'admin', '', '', '', '', '', NULL, '0', NULL, NULL, '0');
INSERT INTO `onl_cgform_field` VALUES ('298905c82163d08c57cfe8ff684270a9', '402881fe72268ef10172268ef1370000', 'flow_id', '流程id', 'flow_id', 0, 1, 'string', 36, 0, '', '', '', '', 'text', '', 120, NULL, '0', '', '', 0, 1, 1, 0, 'single', '', '', 11, 'admin', '2020-05-18 15:50:07', '2020-05-18 14:53:22', 'admin', '', '', '', '', '', NULL, '0', NULL, NULL, '0');
INSERT INTO `onl_cgform_field` VALUES ('29aca2ab662e44708419f4a483419d07', '40288183712beaa901712c0ebcb10003', 'corporate', '法人代表', 'corporate', 0, 1, 'string', 50, 0, '', '', '', '', 'text', '', 120, NULL, '0', '', '', 0, 1, 0, 0, 'group', '', '', 13, 'admin', '2020-03-31 00:04:14', '2020-03-30 23:28:16', 'admin', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `onl_cgform_field` VALUES ('29e4abea55d9fa7dbbd0c8dbbb2b3756', '402860816bff91c0016bff91cda80003', 'update_time', '更新时间', 'update_time', 0, 1, 'Date', 0, 0, '', '', '', '', 'date', '', 120, NULL, '0', '', '', 0, 1, 1, 0, 'group', '', '', 12, 'admin', '2019-07-19 18:06:36', '2019-07-17 18:54:34', 'admin', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `onl_cgform_field` VALUES ('2a71fde697b032329c30c01b586ef7f2', '4028818370f308e90170f308e9080000', 'version', '版本', 'version', 0, 1, 'int', 10, 0, '', '', '', '', 'text', '', 120, NULL, '0', '', '', 0, 0, 0, 0, 'group', '', '', 15, 'admin', '2020-05-30 11:58:17', '2020-03-19 21:43:33', 'admin', '', '', '', '', '', NULL, '0', NULL, NULL, '0');
INSERT INTO `onl_cgform_field` VALUES ('2ae2da29548e46bb938b7ca4191022c3', '402881fe72362af70172362afadf0001', 'entry_no', '分录号', 'entry_no', 0, 0, 'int', 10, 0, '', '', '', '', 'text', '', 120, NULL, '0', '', '', 0, 1, 1, 0, 'single', '', '', 4, 'admin', '2020-05-21 20:23:41', '2020-05-21 15:38:06', 'admin', '', '', '', '', '', NULL, '0', NULL, NULL, '0');
INSERT INTO `onl_cgform_field` VALUES ('2b119552cad713cd7ce3c58e05ea8ad5', '402881017185937c017185937c100000', 'supplier_id', '供应商', 'supplier_id', 0, 1, 'string', 36, 0, '', 'id', 'bas_supplier', 'name', 'list', '', 120, NULL, '0', '', '', 1, 1, 1, 0, 'single', '', '', 6, 'admin', '2020-04-17 11:31:14', '2020-04-17 08:39:28', 'admin', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `onl_cgform_field` VALUES ('2b2e2ff1f7a929ab876d898bb8553791', '4028818371790b3f0171790b3f780000', 'prepay_bal', '预付余额', 'prepay_bal', 0, 0, 'BigDecimal', 18, 2, '', '', '', '', 'text', '', 120, NULL, '0', '', '', 0, 1, 1, 1, 'group', '', '', 7, 'admin', '2020-04-14 23:41:28', '2020-04-14 22:15:13', 'admin', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `onl_cgform_field` VALUES ('2b7c83dbc443321e275aa18ac4a7ed91', '4028818370f308e90170f330ff050003', 'basic_id', '基准单位', 'basic_id', 0, 1, 'string', 36, 0, '', 'id', 'bas_measure_unit', 'name', 'list', '', 120, NULL, '0', '', '', 0, 1, 1, 0, 'group', '', '', 6, 'admin', '2020-03-19 22:35:29', '2020-03-19 22:27:20', 'admin', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `onl_cgform_field` VALUES ('2bf5e63965039ffe19c1fce3f353abbf', '4028818370f308e90170f308e9080000', 'update_time', '修改时间', 'update_time', 0, 1, 'Date', 0, 0, '', '', '', '', 'date', '', 120, NULL, '0', '', '', 0, 1, 1, 1, 'group', '', '', 14, 'admin', '2020-05-30 11:58:17', '2020-03-19 21:43:33', 'admin', '', '', '', '', '', NULL, '0', NULL, NULL, '0');
INSERT INTO `onl_cgform_field` VALUES ('2bfac34ec16824de377df232c0e1ebde', '402881017185937c0171859381700002', 'version', '版本', 'version', 0, 1, 'int', 10, 0, '', '', '', '', 'text', '', 120, NULL, '0', '', '', 0, 0, 0, 0, 'group', '', '', 8, 'admin', '2020-04-18 17:11:30', '2020-04-17 08:39:29', 'admin', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `onl_cgform_field` VALUES ('2c0df5bc877e26e560174b5324eb9bed', '40288101710a4c6201710a4c62b50000', 'is_basic', '是否基准单位', 'is_basic', 0, 1, 'int', 3, 0, '', 'yn', '', '', 'list', '', 120, NULL, '0', '', '', 0, 1, 1, 0, 'group', '', '', 5, 'admin', '2020-03-24 10:18:35', '2020-03-24 10:08:31', 'admin', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `onl_cgform_field` VALUES ('2cd0e82a38dd1a36fda53c0276d86901', '40288183712beaa901712c0ebe7e0004', 'update_time', '修改时间', 'update_time', 0, 1, 'Date', 0, 0, '', '', '', '', 'date', '', 120, NULL, '0', '', '', 0, 1, 1, 1, 'group', '', '', 12, 'admin', '2020-03-30 23:41:18', '2020-03-30 23:28:16', 'admin', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `onl_cgform_field` VALUES ('2cd5d0f68627cffd7562c56849263ea0', '402881fe71c8c4fd0171c8c503230002', 'amt', '金额', 'amt', 0, 0, 'BigDecimal', 18, 2, '', '', '', '', 'text', '', 120, NULL, '0', '', '', 0, 1, 1, 0, 'group', '', '', 9, 'admin', '2020-04-30 10:30:53', '2020-04-30 09:48:07', 'admin', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `onl_cgform_field` VALUES ('2d53a66f0b72d820b86ff445e2181d76', 'beee191324fd40c1afec4fda18bd9d47', 'id', '主键', NULL, 1, 0, 'string', 36, 0, '', '', '', '', 'text', '', 120, NULL, '0', '', '', 0, 0, 0, 0, 'single', '', '', 1, 'admin', '2019-04-13 13:41:13', '2019-04-13 13:40:56', 'admin', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `onl_cgform_field` VALUES ('2dfc4c81926f678c5f8d5ffd27858201', 'e2faf977fdaf4b25a524f58c2441a51c', 'account', '用户编码', NULL, 0, 1, 'String', 32, 0, '', '', '', '', 'text', '', 120, NULL, '0', '', '', 0, 1, 1, 0, 'single', '', '', 7, 'admin', '2019-06-10 17:27:00', '2019-04-24 17:12:11', 'admin', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `onl_cgform_field` VALUES ('2e5275b6407e1b4265af8519077fa4a5', 'd3ae1c692b9640e0a091f8c46e17bb01', 'sys_org_code', '所属部门', NULL, 0, 1, 'string', 64, 0, '', '', '', '', 'text', '', 120, NULL, '0', '', '', 0, 0, 0, 0, 'single', '', '', 6, NULL, NULL, '2019-07-24 14:47:30', 'admin', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `onl_cgform_field` VALUES ('2e66b9db37648389e0846e2204111732', '73162c3b8161413e8ecdca7eb288d0c9', 'has_child', '是否有子节点', NULL, 0, 1, 'string', 3, 0, '', 'valid_status', '', '', 'list', '', 120, NULL, '0', '', '', 0, 0, 0, 0, 'single', '', '', 10, 'admin', '2019-07-01 14:23:32', '2019-06-10 15:18:34', 'admin', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `onl_cgform_field` VALUES ('2e6f741fa96a49a0adccc7b4682c1cef', '4fb8e12a697f4d5bbe9b9fb1e9009486', 'name', '名称', NULL, 0, 1, 'String', 200, 0, '', '', '', '', 'text', '', 120, NULL, '0', '', '#{sysUserName}', 0, 1, 1, 0, 'single', '', '', 3, 'admin', '2020-04-10 19:51:27', '2020-04-10 19:47:01', 'admin', '', '', '', '', '', NULL, '0', NULL, NULL, '0');
INSERT INTO `onl_cgform_field` VALUES ('2e773450c0ef6cd11a36212259dcf3ac', '402881017185937c017185937c100000', 'update_time', '修改时间', 'update_time', 0, 1, 'Date', 0, 0, '', '', '', '', 'date', '', 120, NULL, '0', '', '', 0, 1, 1, 1, 'group', '', '', 18, 'admin', '2020-04-17 11:31:14', '2020-04-17 08:39:28', 'admin', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `onl_cgform_field` VALUES ('2ead9b715e3bab2e4f1691500e23e2e5', '402881fe71c8c4fd0171c8c503230002', 'remark', '备注', 'remark', 0, 1, 'string', 200, 0, '', '', '', '', 'text', '', 120, NULL, '0', '', '', 0, 1, 1, 0, 'group', '', '', 11, 'admin', '2020-04-30 10:30:53', '2020-04-30 09:48:07', 'admin', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `onl_cgform_field` VALUES ('2ee58d8e4844dfe1fa6b1b841ae0b312', '402860816bff91c0016bff91d2810005', 'politically_status', '政治面貌', 'politically_status', 0, 1, 'string', 100, 0, '', '', '', '', 'text', '', 120, NULL, '0', '', '', 0, 1, 1, 0, 'group', '', '', 7, 'admin', '2019-07-19 18:05:55', '2019-07-17 18:54:35', 'admin', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `onl_cgform_field` VALUES ('2f111722eb3a994450e67e3211fd69a8', '402860816bff91c0016bff91ca7e0002', 'id', 'id', 'id', 1, 1, 'string', 32, 0, '', '', '', '', 'text', '', 120, NULL, '0', '', '', 0, 0, 0, 0, 'group', '', '', 1, 'admin', '2019-07-19 18:07:13', '2019-07-17 18:54:33', 'admin', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `onl_cgform_field` VALUES ('2f469a6ad4ccc06f5f7db528fe836ca3', '4028818371790b3f0171795b80ed0002', 'is_enabled', '是否启用', 'is_enabled', 0, 0, 'int', 3, 0, '', 'yn', '', '', 'list', '', 120, NULL, '0', '', '', 0, 1, 1, 0, 'group', '', '', 6, 'admin', '2020-04-14 23:49:04', '2020-04-14 23:42:53', 'admin', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `onl_cgform_field` VALUES ('2f5f18f22099ab161e8a5cfe4d52882d', '402881e970dd8d520170ddb3a6490004', 'create_by', 'createBy', 'create_by', 0, 1, 'string', 36, 0, '', '', '', '', 'text', '', 120, NULL, '0', '', '', 0, 1, 1, 0, 'group', '', '', 20, 'admin', '2020-03-16 22:39:53', '2020-03-15 18:18:23', 'admin', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `onl_cgform_field` VALUES ('3009d267edff3a07eef4cf5efc1c9a1f', '402881fe71c8c4fd0171c8c500d30001', 'amt', '金额', 'amt', 0, 1, 'BigDecimal', 18, 2, '', '', '', '', 'text', '', 120, NULL, '0', '', '', 0, 1, 1, 0, 'group', '', '', 10, 'admin', '2020-04-30 10:30:11', '2020-04-30 09:48:07', 'admin', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `onl_cgform_field` VALUES ('30143cc3de69c413828f9fba20662026', '402860816bff91c0016bffa220a9000b', 'healthy', '健康状况', 'healthy', 0, 1, 'string', 100, 0, '', '', '', '', 'text', '', 120, NULL, '0', '', '', 0, 1, 1, 0, 'group', '', '', 12, 'admin', '2019-07-22 16:15:32', '2019-07-17 19:12:24', 'admin', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `onl_cgform_field` VALUES ('3050d3ebaa3c0bc8052242e8b7a0b2d8', '4028818371790b3f0171790b3f780000', 'is_approved', '是否通过', 'is_approved', 0, 0, 'int', 3, 0, '0', 'yn', '', '', 'list', '', 120, NULL, '0', '', '', 1, 1, 1, 1, 'single', '', '', 12, 'admin', '2020-04-14 23:41:28', '2020-04-14 22:15:13', 'admin', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `onl_cgform_field` VALUES ('309606efa92a6f1a84072d4721959cec', '402881fe72362af70172362afadf0001', 'invoice_no', '发票号', 'invoice_no', 0, 0, 'string', 100, 0, '', '', '', '', 'text', '', 120, NULL, '0', '', '', 0, 1, 1, 0, 'single', '', '', 7, 'admin', '2020-05-21 20:23:41', '2020-05-21 15:38:06', 'admin', '', '', '', '', '', NULL, '0', NULL, NULL, '0');
INSERT INTO `onl_cgform_field` VALUES ('30c7cb16a09265c4fc7391b41be67166', '4028818370f308e90170f308eabf0001', 'name', '名称', 'name', 0, 0, 'string', 50, 0, '', '', '', '', 'text', '', 120, NULL, '0', '', '', 1, 1, 1, 0, 'single', '', '', 4, 'admin', '2020-05-29 20:32:59', '2020-03-19 21:43:33', 'admin', '', '', '', '', '', NULL, '0', NULL, NULL, '0');
INSERT INTO `onl_cgform_field` VALUES ('31035453a6e20443ddc86f651c4ebd19', '402881fe71c8c4fd0171c8c503230002', 'approver_id', '审核人', 'approver_id', 0, 1, 'string', 36, 0, '', 'username', 'sys_user', 'realname', 'list', '', 120, NULL, '0', '', '', 0, 1, 1, 1, 'group', '', '', 16, 'admin', '2020-04-30 10:30:53', '2020-04-30 09:48:07', 'admin', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `onl_cgform_field` VALUES ('31d047039204405b8ff156a50ae3563b', '402881e970dd8d520170dd90f7c30002', 'id', 'id', 'id', 1, 0, 'string', 36, 0, '', '', '', '', 'text', '', 120, NULL, '0', '', '', 0, 0, 0, 0, 'group', '', '', 1, 'admin', '2020-03-15 21:40:40', '2020-03-15 17:40:31', 'admin', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `onl_cgform_field` VALUES ('31eeee364531628e9f17521c3415c3a2', '402881fe71c8c4fd0171c8c503230002', 'bill_no', '单据编号', 'bill_no', 0, 0, 'string', 50, 0, '', '', '', '', 'text', '', 120, NULL, '0', '', '${receivable_bill_no}', 1, 1, 1, 1, 'single', '', '', 2, 'admin', '2020-04-30 10:30:53', '2020-04-30 09:48:07', 'admin', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `onl_cgform_field` VALUES ('31fd90306c3942f09cb79deabbf2f541', '402860816bff91c0016bff91d2810005', 'employee_id', '员工ID', 'employee_id', 0, 1, 'string', 32, 0, '', '', '', '', 'text', '', 120, NULL, '0', '', '', 0, 1, 1, 0, 'group', 'oa_employee_info', 'id', 2, 'admin', '2019-07-19 18:05:55', '2019-07-17 18:54:35', 'admin', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `onl_cgform_field` VALUES ('3212a06a9f94b7063b07a749caacd7d9', '40288183712a997c01712a99809e0001', 'invocied_qty', '已开票数量', 'invocied_qty', 0, 1, 'BigDecimal', 18, 6, NULL, NULL, NULL, NULL, 'text', NULL, 120, NULL, '0', NULL, NULL, 0, 1, 1, 0, 'group', NULL, NULL, 20, NULL, NULL, '2020-03-30 16:40:36', 'admin', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `onl_cgform_field` VALUES ('321c5f3c9b4087afaf1781fbd469ae8a', '4028818371790b3f0171790b3f780000', 'sys_org_code', '创建部门', 'sys_org_code', 0, 1, 'string', 50, 0, '', 'org_code', 'sys_depart', 'depart_name', 'list', '', 120, NULL, '0', '', '', 0, 1, 1, 1, 'group', '', '', 20, 'admin', '2020-04-14 23:41:28', '2020-04-14 22:15:13', 'admin', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `onl_cgform_field` VALUES ('325e0045fd3dbb917b9657313cb9d69c', '402881fe71c8c4fd0171c8c500d30001', 'id', 'ID', 'id', 1, 0, 'string', 36, 0, '', '', '', '', 'text', '', 120, NULL, '0', '', '', 0, 0, 0, 0, 'group', '', '', 1, 'admin', '2020-04-30 10:30:11', '2020-04-30 09:48:07', 'admin', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `onl_cgform_field` VALUES ('32826a36e3d081b61ada130f355d9b6a', '4028818370f308e90170f308eabf0001', 'has_child', '是否有子节点', 'is_leaf', 0, 1, 'string', 3, 0, '', 'yn', '', '', 'list', '', 120, NULL, '0', '', '', 0, 1, 0, 0, 'group', '', '', 3, 'admin', '2020-05-29 20:32:59', '2020-03-19 21:43:33', 'admin', '', '', '', '', '', NULL, '0', NULL, NULL, '0');
INSERT INTO `onl_cgform_field` VALUES ('3285260c98cb40c406075a1046801119', '402881e970dd8d520170dd90f7c30002', 'invocied_qty', 'invociedQty', 'invocied_qty', 0, 1, 'BigDecimal', 18, 6, '', '', '', '', 'text', '', 120, NULL, '0', '', '', 0, 1, 1, 0, 'group', '', '', 20, 'admin', '2020-03-15 21:40:40', '2020-03-15 17:40:31', 'admin', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `onl_cgform_field` VALUES ('333789373640bc419df578202645b3de', '40288183712beaa901712c0eb77c0002', 'tax_invoice', '开票信息税号', 'tax_invoice', 0, 1, 'string', 50, 0, '', '', '', '', 'text', '', 120, NULL, '0', '', '', 0, 1, 0, 0, 'group', '', '', 21, 'admin', '2020-03-31 00:15:25', '2020-03-30 23:28:15', 'admin', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `onl_cgform_field` VALUES ('336495117e3a31351fed6963b950dddb', '402860816bff91c0016bffa220a9000b', 'inside_transfer', '内部工作调动情况', 'inside_transfer', 0, 1, 'string', 255, 0, '', '', '', '', 'text', '', 120, NULL, '0', '', '', 0, 1, 1, 0, 'group', '', '', 37, 'admin', '2019-07-22 16:15:32', '2019-07-17 19:12:24', 'admin', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `onl_cgform_field` VALUES ('336d7b68d279af48fdb5412d0bddba91', '40288183712beaa901712c0eb77c0002', 'remark', '备注', 'remark', 0, 1, 'string', 200, 0, '', '', '', '', 'text', '', 120, NULL, '0', '', '', 0, 1, 0, 0, 'group', '', '', 35, 'admin', '2020-03-31 00:15:25', '2020-03-30 23:28:15', 'admin', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `onl_cgform_field` VALUES ('345c8b48e1e128e77c4c6e2b36512804', '402860816aa5921f016aa5dedcb90009', 'create_by', '创建人', 'create_by', 0, 1, 'string', 50, 0, '', '', '', '', 'text', '', 120, NULL, '0', '', '', 0, 0, 0, 0, 'group', '', '', 2, 'admin', '2019-05-11 15:56:47', '2019-05-11 15:50:08', 'admin', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `onl_cgform_field` VALUES ('3472c527c37deb8527f3ea7af3304c29', '40288183712beaa901712c0ebe7e0004', 'create_by', '创建人', 'create_by', 0, 1, 'string', 36, 0, '', '', '', '', 'text', '', 120, NULL, '0', '', '', 0, 1, 1, 1, 'group', '', '', 9, 'admin', '2020-03-30 23:41:18', '2020-03-30 23:28:16', 'admin', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `onl_cgform_field` VALUES ('3519dbdeaee9fc0895324535fd3ef6f3', '402881fe71c8c4fd0171c8c4fdae0000', 'create_by', '创建人', 'create_by', 0, 1, 'string', 36, 0, '', 'username', 'sys_user', 'realname', 'list', '', 120, NULL, '0', '', '', 0, 1, 1, 1, 'group', '', '', 19, 'admin', '2020-04-30 10:23:44', '2020-04-30 09:48:06', 'admin', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `onl_cgform_field` VALUES ('351faaeb2dd8105e9c66f678211c9d4f', 'dbf4675875e14676a3f9a8b2b8941140', 'update_time', '更新日期', NULL, 0, 1, 'Date', 20, 0, '', '', '', '', 'datetime', '', 120, NULL, '0', '', '', 0, 0, 0, 0, 'single', '', '', 5, NULL, NULL, '2019-05-27 18:02:07', 'admin', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `onl_cgform_field` VALUES ('354b2ce39c5e8ec3f0bbb01bf8ff0fb7', '32f75e4043ef4070919dbd4337186a3d', 'content', '描述', NULL, 0, 1, 'String', 300, 0, '', '', '', '', 'textarea', '', 120, NULL, '0', '', '', 0, 1, 1, 0, 'single', '', '', 9, 'admin', '2019-04-11 10:15:31', '2019-03-28 15:24:24', 'admin', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `onl_cgform_field` VALUES ('35ba051772c5cec4eb63b7babfc1b32a', '40288183712a997c01712a99809e0001', 'tax', '税额', 'tax', 0, 1, 'BigDecimal', 18, 2, NULL, NULL, NULL, NULL, 'text', NULL, 120, NULL, '0', NULL, NULL, 0, 1, 1, 0, 'group', NULL, NULL, 16, NULL, NULL, '2020-03-30 16:40:36', 'admin', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `onl_cgform_field` VALUES ('35ca1c8aa1501bc8a79c880928841f18', '402860816aa5921f016aa5921f480000', 'update_by', '修改人id', 'update_by', 0, 1, 'string', 32, 0, '', '', '', '', 'text', '', 120, NULL, '0', '', '', 0, 0, 0, 0, 'group', '', '', 11, 'admin', '2019-05-11 15:31:55', '2019-05-11 14:26:19', 'admin', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `onl_cgform_field` VALUES ('3635793767371c6db9f76b4b79f9d321', '402860816bff91c0016bff91d8830007', 'create_time', '创建时间', 'create_time', 0, 1, 'Date', 0, 0, '', '', '', '', 'date', '', 120, NULL, '0', '', '', 0, 1, 1, 0, 'group', '', '', 11, 'admin', '2019-07-19 18:04:41', '2019-07-17 18:54:37', 'admin', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `onl_cgform_field` VALUES ('3693887b606190e9de15a00285b337fc', '40288183712a997c01712a997c580000', 'attachment_id', '附件id', 'attachment_id', 0, 1, 'string', 36, 0, '', '', '', '', 'text', '', 120, NULL, '0', '', '', 0, 1, 1, 0, 'group', '', '', 10, 'admin', '2020-03-30 16:48:20', '2020-03-30 16:40:35', 'admin', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `onl_cgform_field` VALUES ('370a6eebc2d732eaf121fe0830d853a6', 'e5464aa8fa7b47c580e91593cf9b46dc', 'wl_code', '物料编码', NULL, 0, 1, 'String', 100, 0, '', '', '', '', 'text', '', 120, NULL, '0', '', '', 0, 0, 0, 0, 'single', '', '', 7, 'admin', '2019-04-24 17:09:49', '2019-04-24 11:05:10', 'admin', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `onl_cgform_field` VALUES ('37462a4d78968d0e432d746423603b81', '3d447fa919b64f6883a834036c14aa67', 'province', '省份', NULL, 0, 1, 'String', 100, 0, '', '', '{table:\'sys_category\',txt:\'name\',key:\'id\',linkField:\'city,area\',idField:\'id\',pidField:\'pid\', condition:\" pid = \'1230769196661510146\' \"         }', '', 'link_down', '', 120, NULL, '0', '', '', 0, 1, 1, 0, 'single', '', '', 2, 'admin', '2020-02-21 17:58:46', '2020-02-20 16:19:00', 'admin', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `onl_cgform_field` VALUES ('37add368b1a8fb52a359efa2780aa701', '402881fe724af1fc01724af1fc0c0000', 'cur_year', '当前年度', 'cur_year', 0, 0, 'int', 5, 0, '', '', '', '', 'text', '', 120, NULL, '0', '', '', 0, 1, 1, 0, 'single', '', '', 4, 'admin', '2020-05-25 16:39:51', '2020-05-25 16:27:53', 'admin', '', '', '', '', '', NULL, '0', NULL, NULL, '0');
INSERT INTO `onl_cgform_field` VALUES ('37d3d18deae867857b5a9bb81079ea30', '4028818371790b3f0171795b83bd0003', 'note', '备注', 'note', 0, 1, 'string', 100, 0, '', '', '', '', 'text', '', 120, NULL, '0', '', '', 0, 1, 1, 0, 'group', '', '', 9, 'admin', '2020-04-14 23:46:44', '2020-04-14 23:42:53', 'admin', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `onl_cgform_field` VALUES ('37e2548874f09ef7d08642a30bc918fa', 'fbc35f067da94a70adb622ddba259352', 'group_name', '小组名', NULL, 0, 1, 'String', 32, 0, '', '', '', '', 'text', '', 120, NULL, '0', '', '', 0, 1, 1, 0, 'single', '', '', 7, NULL, NULL, '2019-07-03 19:44:23', 'admin', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `onl_cgform_field` VALUES ('385d0b205ebbf7ebb807758df5240ac2', '402881fe72362af70172362af7150000', 'version', '版本', 'version', 0, 1, 'int', 10, 0, '', '', '', '', 'text', '', 120, NULL, '0', '', '', 0, 0, 0, 0, 'single', '', '', 26, 'admin', '2020-05-21 20:19:56', '2020-05-21 15:38:06', 'admin', '', '', '', '', '', NULL, '0', NULL, NULL, '0');
INSERT INTO `onl_cgform_field` VALUES ('38c42e2fb2951a6ede69a7ec40f37544', '402881fe72362af70172362af7150000', 'clerk_id', '业务员', 'clerk_id', 0, 1, 'string', 50, 0, '', 'username', 'sys_user', 'realname', 'list', '', 120, NULL, '0', '', '', 0, 1, 1, 0, 'single', '', '', 10, 'admin', '2020-05-21 20:19:56', '2020-05-21 15:38:06', 'admin', '', '', '', '', '', NULL, '0', NULL, NULL, '0');
INSERT INTO `onl_cgform_field` VALUES ('3915ccf7c51d6233080d954ccf92220e', '40288183712beaa901712beaa9a00000', 'update_by', '修改人', 'update_by', 0, 1, 'string', 36, 0, '', 'username', 'sys_user', 'realname', 'list', '', 120, NULL, '0', '', '', 0, 1, 1, 1, 'group', '', '', 25, 'admin', '2020-04-17 12:01:33', '2020-03-30 22:48:52', 'admin', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `onl_cgform_field` VALUES ('391e7cbd9f29743b11bb555c50547b1f', '32f75e4043ef4070919dbd4337186a3d', 'update_time', '更新日期', NULL, 0, 1, 'Date', 20, 0, '', '', '', '', 'datetime', '', 120, NULL, '0', '', '', 0, 0, 0, 0, 'single', '', '', 4, 'admin', '2019-04-11 10:15:32', '2019-03-27 15:54:49', 'admin', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `onl_cgform_field` VALUES ('39367c155ebb003c5140e7a42ad590c1', '40288183712beaa901712c0ebcb10003', 'version', '版本', 'version', 0, 1, 'int', 10, 0, '', '', '', '', 'text', '', 120, NULL, '0', '', '', 0, 0, 0, 0, 'group', '', '', 41, 'admin', '2020-03-31 00:04:14', '2020-03-30 23:28:16', 'admin', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `onl_cgform_field` VALUES ('3940677ee98a08cd564e5340d75a4345', '40288183712beaa901712c0ebcb10003', 'account_payment', '办款资料账号', 'account_payment', 0, 1, 'string', 100, 0, '', '', '', '', 'text', '', 120, NULL, '0', '', '', 0, 1, 0, 0, 'group', '', '', 28, 'admin', '2020-03-31 00:04:14', '2020-03-30 23:28:16', 'admin', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `onl_cgform_field` VALUES ('3984c004a71597238e29a83ba339bb8f', '40288183712beaa901712c0ebcb10003', 'id', 'ID', 'id', 1, 0, 'string', 36, 0, '', '', '', '', 'text', '', 120, NULL, '0', '', '', 0, 0, 0, 0, 'group', '', '', 1, 'admin', '2020-03-31 00:04:14', '2020-03-30 23:28:16', 'admin', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `onl_cgform_field` VALUES ('39fa7c7c97e38f1f99be8252e44778e3', '402881017185937c017185937c100000', 'create_time', '创建时间', 'create_time', 0, 1, 'Date', 0, 0, '', '', '', '', 'date', '', 120, NULL, '0', '', '', 0, 1, 1, 1, 'group', '', '', 15, 'admin', '2020-04-17 11:31:14', '2020-04-17 08:39:28', 'admin', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `onl_cgform_field` VALUES ('3a9a9f22594119e105af8473950fd93e', '402881fe71c8c4fd0171c8c4fdae0000', 'version', '版本', 'version', 0, 1, 'int', 10, 0, '', '', '', '', 'text', '', 120, NULL, '0', '', '', 0, 0, 0, 0, 'group', '', '', 23, 'admin', '2020-04-30 10:23:44', '2020-04-30 09:48:06', 'admin', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `onl_cgform_field` VALUES ('3aef027c9adb9255cd50b8dadceb8136', '4028818370e8d46b0170e8d46b4b0000', 'type', '出入库类型', 'type', 0, 1, 'string', 10, 0, '', '', '', '', 'text', '', 120, NULL, '0', '', '', 0, 1, 1, 0, 'group', '', '', 6, 'admin', '2020-03-19 10:25:32', '2020-03-17 22:10:00', 'admin', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `onl_cgform_field` VALUES ('3b3f0f70cc5c334d95c0d571780fddea', '40288183712beaa901712c0eb77c0002', 'account_invoice', '开票信息账号', 'account_invoice', 0, 1, 'string', 100, 0, '', '', '', '', 'text', '', 120, NULL, '0', '', '', 0, 1, 0, 0, 'group', '', '', 23, 'admin', '2020-03-31 00:15:25', '2020-03-30 23:28:15', 'admin', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `onl_cgform_field` VALUES ('3b439859f98e30e34d25e983eb22e408', '402860816bff91c0016bff91c7010001', 'award_time', '获奖时间', 'award_time', 0, 1, 'Date', 0, 0, '', '', '', '', 'date', '', 120, NULL, '0', '', '', 0, 1, 1, 0, 'group', '', '', 3, 'admin', '2019-07-19 18:07:47', '2019-07-17 18:54:32', 'admin', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `onl_cgform_field` VALUES ('3ba8ab5c286a015ee9ec18674f91935f', '4028818371790b3f0171795b83bd0003', 'bank_address', '开户地址', 'bank_address', 0, 1, 'string', 200, 0, '', '', '', '', 'text', '', 120, NULL, '0', '', '', 0, 1, 1, 0, 'group', '', '', 7, 'admin', '2020-04-14 23:46:44', '2020-04-14 23:42:53', 'admin', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `onl_cgform_field` VALUES ('3bf44e68de518f3ddf72b87671d0ff90', '8994f2817b5a45d9890aa04497a317c5', 'update_by', '更新人登录名称', NULL, 0, 1, 'string', 50, 0, '', '', '', '', 'text', '', 120, '', '0', '', '', 0, 1, 1, 0, 'single', '', '', 3, NULL, NULL, '2019-03-23 11:39:16', 'admin', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `onl_cgform_field` VALUES ('3bf5015d55ff0638c541176eb9cc9bad', '40288183712beaa901712beaa9a00000', 'handler_id', '出入库经办', 'handler_id', 0, 1, 'string', 36, 0, '', 'username', 'sys_user', 'realname', 'sel_user', '', 120, NULL, '0', '', '', 0, 1, 1, 0, 'group', '', '', 8, 'admin', '2020-04-17 12:01:33', '2020-03-30 22:48:52', 'admin', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `onl_cgform_field` VALUES ('3c24a1d3803f3760f780649db6be4317', '4028818370f308e90170f308e9080000', 'name', '名称', 'name', 0, 0, 'string', 50, 0, '', '', '', '', 'text', '', 120, NULL, '0', '', '', 1, 1, 1, 0, 'single', '', '', 3, 'admin', '2020-05-30 11:58:17', '2020-03-19 21:43:33', 'admin', '', '', '', '', '', NULL, '0', NULL, NULL, '0');
INSERT INTO `onl_cgform_field` VALUES ('3cd2061ea15ce9eeb4b7cf2e544ccb6b', 'd35109c3632c4952a19ecc094943dd71', 'file_kk', '附件', NULL, 0, 1, 'String', 500, 0, '', '', '', '', 'file', '', 120, NULL, '0', '', '', 0, 1, 1, 0, 'single', '', '', 12, 'admin', '2020-02-23 18:11:41', '2019-06-10 20:06:57', 'admin', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `onl_cgform_field` VALUES ('3ce1b5056235b9c80e7bc1170e00ba9e', '4028818370f308e90170f330ff050003', 'symbol', '符号', 'symbol', 0, 1, 'string', 20, 0, '', '', '', '', 'text', '', 120, NULL, '0', '', '', 0, 1, 1, 0, 'group', '', '', 3, 'admin', '2020-03-19 22:35:29', '2020-03-19 22:27:20', 'admin', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `onl_cgform_field` VALUES ('3cfd28b0e823ce64087089b0dc9f749a', '402881017185937c017185937c100000', 'customer_id', '客户', 'customer_id', 0, 1, 'string', 36, 0, '', 'id', 'bas_customer', 'name', 'list', '', 120, NULL, '0', '', '', 1, 1, 1, 0, 'single', '', '', 5, 'admin', '2020-04-17 11:31:14', '2020-04-17 08:39:28', 'admin', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `onl_cgform_field` VALUES ('3cfd4d60c7d8409ae716a579bcb0910d', '402860816bff91c0016bff91c0cb0000', 'sys_org_code', '组织机构编码', 'sys_org_code', 0, 1, 'string', 50, 0, '', '', '', '', 'text', '', 120, NULL, '0', '', '', 0, 1, 1, 0, 'group', '', '', 16, 'admin', '2019-07-19 18:09:01', '2019-07-17 18:54:32', 'admin', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `onl_cgform_field` VALUES ('3d0e714496046dc68721495bfe52375e', '402881fe72362af70172362af7150000', 'attachment', '附件', 'attachment', 0, 1, 'string', 500, 0, '', '', '', '', 'file', '', 120, NULL, '0', '', '', 0, 1, 1, 0, 'single', '', '', 12, 'admin', '2020-05-21 20:19:56', '2020-05-21 15:38:06', 'admin', '', '', '', '', '', NULL, '0', NULL, NULL, '0');
INSERT INTO `onl_cgform_field` VALUES ('3d1c3c5901761a5ea844cf710ec9111b', '402881fe72362af70172362af7150000', 'create_by', '创建人', 'create_by', 0, 1, 'string', 36, 0, '', 'username', 'sys_user', 'realname', 'list', '', 120, NULL, '0', '', '', 0, 1, 1, 0, 'single', '', '', 22, 'admin', '2020-05-21 20:19:56', '2020-05-21 15:38:06', 'admin', '', '', '', '', '', NULL, '0', NULL, NULL, '0');
INSERT INTO `onl_cgform_field` VALUES ('3d44345d5d3aa05ebc3522ac67e319c9', '402881fe72268ef10172268ef3ec0001', 'remark', '备注', 'remark', 0, 1, 'string', 50, 0, '', '', '', '', 'text', '', 120, NULL, '0', '', '', 0, 1, 1, 0, 'single', '', '', 13, 'admin', '2020-05-18 15:55:16', '2020-05-18 14:53:23', 'admin', '', '', '', '', '', NULL, '0', NULL, NULL, '0');
INSERT INTO `onl_cgform_field` VALUES ('3d57d09ab5697bd0e9af227194b7b8eb', '40288183712beaa901712c0eb77c0002', 'bank_invoice', '开票信息开户行', 'bank_invoice', 0, 1, 'string', 200, 0, '', '', '', '', 'text', '', 120, NULL, '0', '', '', 0, 1, 0, 0, 'group', '', '', 19, 'admin', '2020-03-31 00:15:25', '2020-03-30 23:28:15', 'admin', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `onl_cgform_field` VALUES ('3d7e86870f08aec604b459aee1d4ffe8', '402881e970dd8d520170ddb3a6490004', 'closed', 'closed', 'closed', 0, 1, 'int', 3, 0, '', '', '', '', 'text', '', 120, NULL, '0', '', '', 0, 1, 1, 0, 'group', '', '', 25, 'admin', '2020-03-16 22:39:53', '2020-03-15 18:18:23', 'admin', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `onl_cgform_field` VALUES ('3dd5605bbea2b9360e1040ba9f09f88c', '40288183712beaa901712beaad3c0001', 'warehouse_id', '仓库', 'warehouse_id', 0, 1, 'string', 36, 0, '', 'id', 'bas_warehouse', 'name', 'list', '', 120, NULL, '0', '', '', 0, 1, 1, 0, 'group', '', '', 9, 'admin', '2020-05-04 21:41:29', '2020-03-30 22:48:53', 'admin', '', '', '', '', '', NULL, '0', NULL, NULL, '0');
INSERT INTO `onl_cgform_field` VALUES ('3df10229cd77d33aae6ecd94cb32b05e', '7a584d85821b482c9a93757cf101fbe6', 'update_by', '更新人', NULL, 0, 1, 'string', 50, 0, '', '', '', '', 'text', '', 120, NULL, '0', '', '', 0, 0, 0, 0, 'single', '', '', 4, 'admin', '2020-02-23 18:18:33', '2020-02-23 17:41:10', 'admin', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `onl_cgform_field` VALUES ('3e0f2fd12549913d012107154bcb4931', '4028818370e8d46b0170e8d46b4b0000', 'supplier_id', '供应商', 'supplier_id', 0, 1, 'string', 36, 0, '', '', '', '', 'text', '', 120, NULL, '0', '', '', 0, 1, 1, 0, 'group', '', '', 9, 'admin', '2020-03-19 10:25:32', '2020-03-17 22:10:01', 'admin', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `onl_cgform_field` VALUES ('3e32f6c30c9028872388f70743c5d6a5', '402860816bff91c0016bff91c0cb0000', 'reason', '申请理由', 'reason', 0, 1, 'string', 200, 0, '', '', '', '', 'text', '', 120, NULL, '0', '', '', 0, 1, 1, 0, 'group', '', '', 9, 'admin', '2019-07-19 18:09:01', '2019-07-17 18:54:32', 'admin', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `onl_cgform_field` VALUES ('3e378dd88090f252c7c01d7db6971fb4', '40288183712beaa901712c0eb77c0002', 'arrears_limit', '欠款额度', 'arrears_limit', 0, 1, 'BigDecimal', 18, 2, '', '', '', '', 'text', '', 120, NULL, '0', '', '', 0, 1, 1, 0, 'group', '', '', 7, 'admin', '2020-03-31 00:15:25', '2020-03-30 23:28:15', 'admin', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `onl_cgform_field` VALUES ('3e70d1c516c3533c6698300665c669e1', '402860816bff91c0016bff91c0cb0000', 'id', 'id', 'id', 1, 1, 'string', 32, 0, '', '', '', '', 'text', '', 120, NULL, '0', '', '', 0, 0, 0, 0, 'group', '', '', 1, 'admin', '2019-07-19 18:09:01', '2019-07-17 18:54:31', 'admin', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `onl_cgform_field` VALUES ('3e8a6d8c7f390f4dbe2ded10d1fd9ec7', '402881fe71c8c4fd0171c8c4fdae0000', 'customer_id', '客户', 'customer_id', 0, 1, 'string', 36, 0, '', 'id', 'bas_customer', 'name', 'list', '', 120, NULL, '0', '', '', 1, 1, 1, 0, 'single', '', '', 5, 'admin', '2020-04-30 10:23:44', '2020-04-30 09:48:06', 'admin', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `onl_cgform_field` VALUES ('3eab83f6547e2b1f9a62b0e473a3be87', '402881fe72268ef10172268ef3ec0001', 'material_id', '物料', 'material_id', 0, 0, 'string', 36, 0, '', 'id', 'bas_material', 'name', 'list', '', 120, NULL, '0', '', '', 0, 1, 1, 0, 'single', '', '', 6, 'admin', '2020-05-18 15:55:16', '2020-05-18 14:53:23', 'admin', '', '', '', '', '', NULL, '0', NULL, NULL, '0');
INSERT INTO `onl_cgform_field` VALUES ('3efe416fa077f1fdbf4b7bac939e2a81', '402881ea71684fa00171684fa0680000', 'batch_no', '批号', 'batch_no', 0, 0, 'string', 100, 0, '', '', '', '', 'text', '', 120, NULL, '0', '', '', 1, 1, 1, 1, 'group', '', '', 4, 'admin', '2020-04-11 16:28:45', '2020-04-11 16:16:22', 'admin', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `onl_cgform_field` VALUES ('3f2ace8f968a0e5b91d1340ee2957cda', '402860816bff91c0016bff91d8830007', 'real_name', '姓名', 'real_name', 0, 1, 'string', 100, 0, '', '', '', '', 'text', '', 120, NULL, '0', '', '', 0, 1, 1, 0, 'group', '', '', 3, 'admin', '2019-07-19 18:04:41', '2019-07-17 18:54:37', 'admin', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `onl_cgform_field` VALUES ('3f5e049aeb5991d2faec242556876add', '4028818371790b3f0171790b3f780000', 'approver_id', '审核人', 'approver_id', 0, 1, 'string', 36, 0, '', 'username', 'sys_user', 'realname', 'list', '', 120, NULL, '0', '', '', 0, 1, 1, 1, 'group', '', '', 16, 'admin', '2020-04-14 23:41:28', '2020-04-14 22:15:13', 'admin', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `onl_cgform_field` VALUES ('3f7a8a7fc6e44c57ad347d620da88d9f', '40288183712beaa901712c0ebe7e0004', 'version', '版本', 'version', 0, 1, 'int', 10, 0, '', '', '', '', 'text', '', 120, NULL, '0', '', '', 0, 0, 0, 0, 'group', '', '', 13, 'admin', '2020-03-30 23:41:18', '2020-03-30 23:28:16', 'admin', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `onl_cgform_field` VALUES ('3fc815e768c6059f88f3f5dec8c8426c', '4028818370e8d46b0170e8d46b4b0000', 'remark', '备注', 'remark', 0, 1, 'string', 200, 0, '', '', '', '', 'text', '', 120, NULL, '0', '', '', 0, 1, 1, 0, 'group', '', '', 13, 'admin', '2020-03-19 10:25:32', '2020-03-17 22:10:01', 'admin', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `onl_cgform_field` VALUES ('4014a09b42791a206098eda854fffc11', '402881e970dd8d520170dd90f7c30002', 'tax_rate', 'taxRate', 'tax_rate', 0, 1, 'BigDecimal', 10, 6, '', '', '', '', 'text', '', 120, NULL, '0', '', '', 0, 1, 1, 0, 'group', '', '', 15, 'admin', '2020-03-15 21:40:40', '2020-03-15 17:40:31', 'admin', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `onl_cgform_field` VALUES ('402a09610e01c7f7115d7218d4f3b0a5', '4028818371790b3f0171795b83bd0003', 'create_time', '创建时间', 'create_time', 0, 1, 'Date', 0, 0, '', '', '', '', 'date', '', 120, NULL, '0', '', '', 0, 1, 1, 0, 'group', '', '', 13, 'admin', '2020-04-14 23:46:44', '2020-04-14 23:42:53', 'admin', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `onl_cgform_field` VALUES ('40471eb4560bf0bbd2ffef17d48a269d', 'dbf4675875e14676a3f9a8b2b8941140', 'update_by', '更新人', NULL, 0, 1, 'string', 50, 0, '', '', '', '', 'text', '', 120, NULL, '0', '', '', 0, 0, 0, 0, 'single', '', '', 4, NULL, NULL, '2019-05-27 18:02:07', 'admin', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `onl_cgform_field` VALUES ('404b516d4f2229f292783db595b02ba1', '402860816bff91c0016bff91d8830007', 'update_time', '更新时间', 'update_time', 0, 1, 'Date', 0, 0, '', '', '', '', 'date', '', 120, NULL, '0', '', '', 0, 1, 1, 0, 'group', '', '', 13, 'admin', '2019-07-19 18:04:41', '2019-07-17 18:54:37', 'admin', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `onl_cgform_field` VALUES ('405de5ea82e54138a0613dd41b006dfb', '56870166aba54ebfacb20ba6c770bd73', 'update_by', '更新人', NULL, 0, 1, 'string', 50, 0, '', '', '', '', 'text', '', 120, NULL, '0', '', '', 0, 0, 0, 0, 'single', '', '', 4, 'admin', '2019-11-21 17:58:27', '2019-04-20 11:38:39', 'admin', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `onl_cgform_field` VALUES ('40f4f2e72fb626e3c12522829eae1dba', '402881fe72268ef10172268ef3ec0001', 'is_one_supplier', '同一供应商', 'is_one_supplier', 0, 0, 'int', 3, 0, '', 'yn', '', '', 'list', '', 120, NULL, '0', '', '', 0, 1, 1, 0, 'single', '', '', 8, 'admin', '2020-05-18 15:55:16', '2020-05-18 14:53:23', 'admin', '', '', '', '', '', NULL, '0', NULL, NULL, '0');
INSERT INTO `onl_cgform_field` VALUES ('4102f78e65dcf650fcdd9921dc0bbd1f', '40288101710a4c6201710a60ad5e0001', 'id', 'ID', 'id', 1, 0, 'string', 36, 0, '', '', '', '', 'text', '', 120, NULL, '0', '', '', 0, 0, 0, 0, 'group', '', '', 1, 'admin', '2020-03-28 09:52:10', '2020-03-24 10:30:41', 'admin', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `onl_cgform_field` VALUES ('4164314d6a51d100169a29872b7504d8', '402860816bff91c0016bff91ca7e0002', 'cert_time', '发证时间', 'cert_time', 0, 1, 'Date', 0, 0, '', '', '', '', 'date', '', 120, NULL, '0', '', '', 0, 1, 1, 0, 'group', '', '', 3, 'admin', '2019-07-19 18:07:13', '2019-07-17 18:54:33', 'admin', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `onl_cgform_field` VALUES ('41d4215c01b0d26871f2cb83d3e532ae', '402860816bff91c0016bff91c0cb0000', 'bpm_status', '流程状态', NULL, 0, 1, 'String', 32, 0, '1', '', '', '', 'text', '', 120, NULL, '0', '', '', 0, 1, 1, 0, 'single', '', '', 17, 'admin', '2019-07-19 18:09:01', '2019-07-19 15:35:23', 'admin', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `onl_cgform_field` VALUES ('41f48336b5a05dd6d208c47a04155a8c', '4028818371790b3f0171795b83bd0003', 'name', '账户名称', 'name', 0, 1, 'string', 100, 0, '', '', '', '', 'text', '', 120, NULL, '0', '', '', 0, 1, 1, 0, 'group', '', '', 3, 'admin', '2020-04-14 23:46:44', '2020-04-14 23:42:53', 'admin', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `onl_cgform_field` VALUES ('422a44a15fa39fd57c3c23eb601f7c03', '56870166aba54ebfacb20ba6c770bd73', 'descc', '描述', NULL, 0, 1, 'String', 100, 0, '', '', '', '', 'text', '', 120, NULL, '0', '', '', 0, 1, 1, 0, 'single', '', '', 8, 'admin', '2019-11-21 17:58:28', '2019-04-20 11:38:39', 'admin', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `onl_cgform_field` VALUES ('42b8c8e8e6315d2c3ba5859a1d833cc8', '4028818371790b3f0171790b43ac0001', 'remark', '备注', 'remark', 0, 1, 'string', 50, 0, '', '', '', '', 'text', '', 120, NULL, '0', '', '', 0, 1, 1, 0, 'group', '', '', 9, 'admin', '2020-04-14 23:25:38', '2020-04-14 22:15:14', 'admin', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `onl_cgform_field` VALUES ('42cccfa014c9e131a0a1b23f563d3688', '402860816bff91c0016bffa220a9000b', 'sex', '性别', 'sex', 0, 1, 'string', 20, 0, '', '', '', '', 'text', '', 120, NULL, '0', '', '', 0, 1, 1, 0, 'group', '', '', 6, 'admin', '2019-07-22 16:15:32', '2019-07-17 19:12:24', 'admin', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `onl_cgform_field` VALUES ('42e88ac4a4da04764a2f6a5199bd9aca', '402881fe72268ef10172268ef3ec0001', 'id', 'ID', 'id', 1, 0, 'string', 36, 0, '', '', '', '', 'text', '', 120, NULL, '0', '', '', 0, 0, 0, 1, 'single', '', '', 1, 'admin', '2020-05-18 15:55:15', '2020-05-18 14:53:23', 'admin', '', '', '', '', '', NULL, '0', NULL, NULL, '0');
INSERT INTO `onl_cgform_field` VALUES ('4312f618c83e07db82e468b81a1eaa45', '402860816bff91c0016bffa220a9000b', 'photo', '照片', 'photo', 0, 1, 'string', 255, 0, '', '', '', '', 'text', '', 120, NULL, '0', '', '', 0, 1, 1, 0, 'group', '', '', 20, 'admin', '2019-07-22 16:15:32', '2019-07-17 19:12:24', 'admin', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `onl_cgform_field` VALUES ('435b57180fc995e3c4ec42516963bca3', '4028839a6de2ebd3016de2ebd3870000', 'wl_code', '物料编码', 'wl_code', 0, 1, 'string', 60, 0, NULL, NULL, NULL, NULL, 'text', NULL, 120, NULL, '0', NULL, NULL, 0, 1, 1, 0, 'group', NULL, NULL, 6, NULL, NULL, '2019-10-19 15:29:30', 'admin', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `onl_cgform_field` VALUES ('43aacc4e66c5faf9562d8a0cddcdbd10', '402881ea71684fa00171684fa0680000', 'warehouse_id', '仓库', 'warehouse_id', 0, 0, 'string', 36, 0, '', 'id', 'bas_warehouse', 'name', 'list', '', 120, NULL, '0', '', '', 1, 1, 1, 1, 'single', '', '', 2, 'admin', '2020-04-11 16:28:45', '2020-04-11 16:16:22', 'admin', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `onl_cgform_field` VALUES ('445dcf1c7b9a3a32ef8d73f4d3ce02cd', '40288101710a4c6201710a60ad5e0001', 'symbol', '符号', 'symbol', 0, 0, 'string', 50, 0, '', '', '', '', 'text', '', 100, NULL, '0', '', '', 0, 1, 1, 0, 'group', '', '', 3, 'admin', '2020-03-28 09:52:10', '2020-03-24 10:30:41', 'admin', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `onl_cgform_field` VALUES ('447ea2b3d15a4ec29884c7e1445ce0ab', '40288183712beaa901712c0eb77c0002', 'create_by', '创建人', 'create_by', 0, 1, 'string', 36, 0, '', '', '', '', 'text', '', 120, NULL, '0', '', '', 0, 1, 0, 1, 'group', '', '', 37, 'admin', '2020-03-31 00:15:25', '2020-03-30 23:28:15', 'admin', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `onl_cgform_field` VALUES ('44bdc595f1e565fc053e01134b92bb47', 'd3ae1c692b9640e0a091f8c46e17bb01', 'update_by', '更新人', NULL, 0, 1, 'string', 50, 0, '', '', '', '', 'text', '', 120, NULL, '0', '', '', 0, 0, 0, 0, 'single', '', '', 4, NULL, NULL, '2019-07-24 14:47:30', 'admin', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `onl_cgform_field` VALUES ('44e81e24d2384b0f187e8f69eda55390', '402860816bff91c0016bff91cda80003', 'create_time', '创建时间', 'create_time', 0, 1, 'Date', 0, 0, '', '', '', '', 'date', '', 120, NULL, '0', '', '', 0, 1, 1, 0, 'group', '', '', 10, 'admin', '2019-07-19 18:06:36', '2019-07-17 18:54:34', 'admin', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `onl_cgform_field` VALUES ('4507b0b0c93b18df1b1e8a8990f152ea', '4028818370f308e90170f308eabf0001', 'version', '版本', 'version', 0, 1, 'int', 10, 0, '', '', '', '', 'text', '', 120, NULL, '0', '', '', 0, 0, 0, 0, 'group', '', '', 12, 'admin', '2020-05-29 20:32:59', '2020-03-19 21:43:33', 'admin', '', '', '', '', '', NULL, '0', NULL, NULL, '0');
INSERT INTO `onl_cgform_field` VALUES ('45c0a1a89a1e2a72533b9af894be1011', '27fc5f91274344afa7673a732b279939', 'create_time', '创建日期', NULL, 0, 1, 'Date', 20, 0, '', '', '', '', 'datetime', '', 120, NULL, '0', '', '', 0, 0, 0, 0, 'single', '', '', 3, 'admin', '2019-07-01 16:28:20', '2019-07-01 16:26:42', 'admin', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `onl_cgform_field` VALUES ('45c5bb6288916d82a495675f03d772dd', '4028818371790b3f0171795b80ed0002', 'create_by', '创建人', 'create_by', 0, 1, 'string', 36, 0, '', 'username', 'sys_user', 'realname', 'list', '', 120, NULL, '0', '', '', 0, 1, 1, 0, 'group', '', '', 7, 'admin', '2020-04-14 23:49:04', '2020-04-14 23:42:53', 'admin', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `onl_cgform_field` VALUES ('45d59eb647257fcbcb9d143ff1ba2080', 'deea5a8ec619460c9245ba85dbc59e80', 'pro_type', '产品类型', NULL, 0, 1, 'String', 32, 0, '', 'sex', '', '', 'radio', '', 120, NULL, '0', '', '', 0, 1, 1, 0, 'single', '', '', 9, 'admin', '2020-03-15 17:37:15', '2019-04-23 20:54:08', 'admin', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `onl_cgform_field` VALUES ('469b250595f15dfebe69991d72e4bfb2', 'e9faf717024b4aae95cff224ae9b6d97', 'name', '员工姓名', NULL, 0, 1, 'String', 32, 0, '', '', '', '', 'text', '', 120, NULL, '0', '', '', 0, 1, 1, 0, 'single', '', '', 6, 'admin', '2019-07-03 18:23:49', '2019-07-03 18:22:35', 'admin', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `onl_cgform_field` VALUES ('46be01bef342519e268902d0d36a7473', 'deea5a8ec619460c9245ba85dbc59e80', 'desc_', '描述', NULL, 0, 1, 'String', 32, 0, '', '', '', '', 'text', '', 120, NULL, '0', '', '', 0, 1, 1, 0, 'single', '', '', 11, 'admin', '2020-03-15 17:37:15', '2019-04-20 11:41:19', 'admin', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `onl_cgform_field` VALUES ('46f1a875f86a4f48d0540ad0d5e667d7', '56870166aba54ebfacb20ba6c770bd73', 'order_date', '下单时间', NULL, 0, 1, 'Date', 32, 0, '', '', '', '', 'date', '', 120, NULL, '0', '', '', 0, 1, 1, 0, 'single', '', '', 7, 'admin', '2019-11-21 17:58:28', '2019-04-20 11:38:39', 'admin', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `onl_cgform_field` VALUES ('474bcf5ca5b3d7e575ad6787560dd92e', '402881fe71c8c4fd0171c8c4fdae0000', 'bill_no', '单据编号', 'bill_no', 0, 0, 'string', 50, 0, '', '', '', '', 'text', '', 120, NULL, '0', '', '${receipt_bill_no}', 1, 1, 1, 0, 'single', '', '', 2, 'admin', '2020-04-30 10:23:44', '2020-04-30 09:48:06', 'admin', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `onl_cgform_field` VALUES ('478a7ff8a767f5b9c5f2dc445f70869d', '40288183712a997c01712a99809e0001', 'version', '版本', 'version', 0, 0, 'int', 10, 0, NULL, NULL, NULL, NULL, 'text', NULL, 120, NULL, '0', NULL, NULL, 0, 1, 1, 0, 'group', NULL, NULL, 25, NULL, NULL, '2020-03-30 16:40:36', 'admin', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `onl_cgform_field` VALUES ('479c462df05eb7f9dcb714db4702f1f7', '40288183712a997c01712a99809e0001', 'warehouse_id', '仓库', 'warehouse_id', 0, 1, 'string', 36, 0, NULL, NULL, NULL, NULL, 'text', NULL, 120, NULL, '0', NULL, NULL, 0, 1, 1, 0, 'group', NULL, NULL, 8, NULL, NULL, '2020-03-30 16:40:36', 'admin', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `onl_cgform_field` VALUES ('47c21a6b45e59a6b70bb9c0cc4510a68', '1acb6f81a1d9439da6cc4e868617b565', 'integral_val', '积分值', NULL, 0, 1, 'int', 32, 0, '', '', '', '', 'text', '', 120, NULL, '0', '', '', 0, 1, 1, 0, 'single', '', '', 13, 'admin', '2019-06-10 14:47:14', '2019-04-23 22:58:19', 'admin', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `onl_cgform_field` VALUES ('47c74fdff36375f6458cd2aaa14011c6', '402881017185937c0171859381700002', 'bill_type', '单据类型', 'bill_type', 0, 0, 'string', 20, 0, '', 'x_bill_type', '', '', 'list', '', 120, NULL, '0', '', '', 0, 1, 1, 1, 'group', '', '', 4, 'admin', '2020-04-18 17:11:30', '2020-04-17 08:39:29', 'admin', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `onl_cgform_field` VALUES ('47fa05530f3537a1be8f9e7a9e98be82', 'd35109c3632c4952a19ecc094943dd71', 'sex', '性别', NULL, 0, 1, 'string', 32, 0, '', 'sex', '', '', 'list', '', 120, '', '0', '', '', 0, 1, 1, 0, 'single', '', '', 6, 'admin', '2020-02-23 18:11:41', '2019-03-15 14:24:35', 'admin', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `onl_cgform_field` VALUES ('4851697fdf63709d2bc7451b7415f4af', '32f75e4043ef4070919dbd4337186a3d', 'sex', '性别', NULL, 0, 1, 'String', 32, 0, '1', 'sex', '', '', 'list', '', 120, NULL, '0', '', '', 1, 1, 1, 0, 'single', '', '', 6, 'admin', '2019-04-11 10:15:32', '2019-03-27 15:54:49', 'admin', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `onl_cgform_field` VALUES ('485a8ddce2c033f88af674ec98b68e32', '402860816bff91c0016bffa220a9000b', 'create_time', '创建时间', 'create_time', 0, 1, 'Date', 0, 0, '', '', '', '', 'date', '', 120, NULL, '0', '', '', 0, 1, 1, 0, 'group', '', '', 40, 'admin', '2019-07-22 16:15:32', '2019-07-17 19:12:24', 'admin', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `onl_cgform_field` VALUES ('487747a9ca8e0dfed029beb4a71e5706', '402881fe72362af70172362af7150000', 'source_no', '源单号', 'source_no', 0, 1, 'string', 50, 0, '', '', '', '', 'text', '', 120, NULL, '0', '', '', 0, 1, 1, 0, 'single', '', '', 9, 'admin', '2020-05-21 20:19:56', '2020-05-21 15:38:06', 'admin', '', '', '', '', '', NULL, '0', NULL, NULL, '0');
INSERT INTO `onl_cgform_field` VALUES ('489f0f4abb675868320fff3f2fa345de', '4028818371790b3f0171790b43ac0001', 'unchecked_amt', '待核销金额', 'unchecked_amt', 0, 0, 'BigDecimal', 18, 2, '', '', '', '', 'text', '', 120, NULL, '0', '', '', 0, 1, 1, 1, 'group', '', '', 8, 'admin', '2020-04-14 23:25:38', '2020-04-14 22:15:14', 'admin', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `onl_cgform_field` VALUES ('492a462b212fc34b0ee70e872684ed7e', '7ea60a25fa27470e9080d6a921aabbd1', 'name', '用户名', NULL, 0, 1, 'String', 32, 0, '', '', '', '', 'text', '', 120, NULL, '0', '', '', 0, 1, 1, 0, 'single', '', '', 6, NULL, NULL, '2019-04-17 00:22:21', 'admin', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `onl_cgform_field` VALUES ('49460d38b38881652486fc51b03da2d5', '40288101717185240171718524d60000', 'bill_date', '单据日期', 'bill_date', 0, 0, 'Date', 0, 0, '', '', '', '', 'date', '', 120, NULL, '0', '', '', 1, 1, 1, 0, 'group', '', '', 5, 'admin', '2020-04-13 14:00:53', '2020-04-13 11:11:24', 'admin', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `onl_cgform_field` VALUES ('499a5dac033a01ce58009e4c5b786697', 'e9faf717024b4aae95cff224ae9b6d97', 'age', '员工年龄', NULL, 0, 1, 'int', 32, 0, '', '', '', '', 'text', '', 120, NULL, '0', '', '', 0, 1, 1, 0, 'single', '', '', 7, 'admin', '2019-07-03 18:23:49', '2019-07-03 18:22:35', 'admin', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `onl_cgform_field` VALUES ('49bb6b058b8c148c3d16d33c0973b5d0', '402881fe71c8c4fd0171c8c4fdae0000', 'attachment_id', '附件', 'attachment_id', 0, 1, 'string', 36, 0, '', '', '', '', 'text', '', 120, NULL, '0', '', '', 0, 1, 1, 0, 'group', '', '', 9, 'admin', '2020-04-30 10:23:44', '2020-04-30 09:48:06', 'admin', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `onl_cgform_field` VALUES ('49cd3dbd4f7f7cf0d19b1ee1045cfa69', 'e67d26b610dd414c884c4dbb24e71ce3', 'post_code', '岗位编码', NULL, 0, 1, 'String', 32, 0, '', '', '', '', 'text', '', 120, NULL, '0', '', '', 0, 1, 1, 0, 'single', '', '', 6, 'admin', '2019-04-24 11:03:32', '2019-04-24 11:02:57', 'admin', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `onl_cgform_field` VALUES ('49e9469da3bfaaf1a41fe2c0e1aa3e74', '871c2df1185c4c8e80377d3c319c9a1e', 'create_by', '创建人', NULL, 0, 1, 'string', 50, 0, '', '', '', '', 'text', '', 120, NULL, '0', '', '', 0, 0, 0, 0, 'single', '', '', 2, NULL, NULL, '2020-03-20 11:42:58', 'admin', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `onl_cgform_field` VALUES ('4aefea7add728b37771a086763c48fef', '40288101710a4c6201710a60ad5e0001', 'update_by', '修改人', 'update_by', 0, 1, 'string', 36, 0, '', '', '', '', 'text', '', 120, NULL, '0', '', '', 0, 1, 1, 1, 'group', '', '', 10, 'admin', '2020-03-28 09:52:10', '2020-03-24 10:30:41', 'admin', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `onl_cgform_field` VALUES ('4b0f3088e725ca193ea62b377bc213fa', '40288183712a997c01712a997c580000', 'create_time', '创建时间', 'create_time', 0, 1, 'Date', 0, 0, '', '', '', '', 'date', '', 120, NULL, '0', '', '', 0, 1, 1, 0, 'group', '', '', 20, 'admin', '2020-03-30 16:48:20', '2020-03-30 16:40:35', 'admin', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `onl_cgform_field` VALUES ('4b294048b82efbe128aa8313c1b7d6b5', '402881fe72268ef10172268ef1370000', 'id', 'ID', 'id', 1, 0, 'string', 36, 0, '', '', '', '', 'text', '', 120, NULL, '0', '', '', 0, 0, 0, 1, 'single', '', '', 1, 'admin', '2020-05-18 15:50:07', '2020-05-18 14:53:22', 'admin', '', '', '', '', '', NULL, '0', NULL, NULL, '0');
INSERT INTO `onl_cgform_field` VALUES ('4ba7c553ca4babcec75273c531cd65e1', '402860816bff91c0016bff91cfea0004', 'workplace', '工作单位', 'workplace', 0, 1, 'string', 100, 0, '', '', '', '', 'text', '', 120, NULL, '0', '', '', 0, 1, 1, 0, 'group', '', '', 5, 'admin', '2019-07-19 18:05:13', '2019-07-17 18:54:35', 'admin', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `onl_cgform_field` VALUES ('4ba86d39d3c79d6de1acacf8aaef8c67', '40288183712beaa901712beaad3c0001', 'remark3', '备注3', 'remark3', 0, 1, 'string', 50, 0, '', '', '', '', 'text', '', 120, NULL, '0', '', '', 0, 1, 1, 0, 'group', '', '', 25, 'admin', '2020-05-04 21:41:29', '2020-03-30 22:48:53', 'admin', '', '', '', '', '', NULL, '0', NULL, NULL, '0');
INSERT INTO `onl_cgform_field` VALUES ('4bc8939768b94ae539a629b90939809a', '40288101717185240171718524d60000', 'is_closed', '是否关闭', 'is_closed', 0, 0, 'int', 3, 0, '', 'yn', '', '', 'text', '', 120, NULL, '0', '', '', 1, 1, 1, 0, 'single', '', '', 16, 'admin', '2020-04-13 14:00:53', '2020-04-13 11:11:24', 'admin', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `onl_cgform_field` VALUES ('4bed466e20a0694096f1d813fb53d436', '402881fe72268ef10172268ef3ec0001', 'remark2', '备注2', 'remark2', 0, 1, 'string', 50, 0, '', '', '', '', 'text', '', 120, NULL, '0', '', '', 0, 1, 1, 0, 'single', '', '', 14, 'admin', '2020-05-18 15:55:16', '2020-05-18 14:53:23', 'admin', '', '', '', '', '', NULL, '0', NULL, NULL, '0');
INSERT INTO `onl_cgform_field` VALUES ('4c2cba9fc950333421c4193576b8384d', '32f75e4043ef4070919dbd4337186a3d', 'salary', '工资', NULL, 0, 1, 'double', 32, 0, '', '', '', '', 'text', '', 120, NULL, '0', '', '', 0, 1, 1, 0, 'single', '', '', 10, 'admin', '2019-04-11 10:15:32', '2019-03-28 15:24:24', 'admin', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `onl_cgform_field` VALUES ('4c4f4067fa31737f3ff9e088130ef793', '4adec929a6594108bef5b35ee9966e9f', 'sex', '性别', NULL, 0, 1, 'String', 200, 0, '', 'sex', '', '', 'list', '', 120, NULL, '0', '', '{{ 2 }}', 0, 1, 1, 0, 'single', '', '', 4, 'admin', '2020-04-10 19:43:38', '2020-04-10 19:35:58', 'admin', '', '', '', '', '', NULL, '0', NULL, NULL, '0');
INSERT INTO `onl_cgform_field` VALUES ('4c570c5cf05590348e12621ca62773cf', '402860816aa5921f016aa5921f480000', 'name', '请假人', 'name', 0, 1, 'string', 100, 0, '', '', '', '', 'text', '', 120, NULL, '0', '', '', 0, 1, 1, 0, 'group', '', '', 2, 'admin', '2019-05-11 15:31:54', '2019-05-11 14:26:19', 'admin', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `onl_cgform_field` VALUES ('4c784f4febf02cdf99ed76e0af72c06b', '402881e970dd8d520170ddb3a6490004', 'flow_id', '流程', 'flow_id', 0, 1, 'string', 36, 0, '', '', '', '', 'text', '', 120, NULL, '0', '', '', 0, 1, 1, 0, 'group', '', '', 17, 'admin', '2020-03-16 22:39:53', '2020-03-15 18:18:23', 'admin', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `onl_cgform_field` VALUES ('4c7e78ef29f200fdbe8aa44d1a5758dd', '40288183712beaa901712c0ebcb10003', 'website', '网站', 'website', 0, 1, 'string', 50, 0, '', '', '', '', 'text', '', 120, NULL, '0', '', '', 0, 1, 0, 0, 'group', '', '', 12, 'admin', '2020-03-31 00:04:14', '2020-03-30 23:28:16', 'admin', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `onl_cgform_field` VALUES ('4cacfa054e96791ab938b5c8f8e02cd1', '27fc5f91274344afa7673a732b279939', 'bpm_status', '流程状态', NULL, 0, 1, 'String', 2, 0, '', 'bpm_status', '', '', 'list', '', 120, NULL, '0', '', '', 0, 1, 1, 0, 'single', '', '', 9, NULL, NULL, '2019-07-01 16:28:20', 'admin', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `onl_cgform_field` VALUES ('4cca909d17db48b4b3ea3c9eb8151542', '402881e970dd8d520170dd90f7c30002', 'source_entry_id', 'sourceEntryId', 'source_entry_id', 0, 1, 'string', 36, 0, '', '', '', '', 'text', '', 120, NULL, '0', '', '', 0, 1, 1, 0, 'group', '', '', 3, 'admin', '2020-03-15 21:40:40', '2020-03-15 17:40:31', 'admin', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `onl_cgform_field` VALUES ('4ccad4df8796c82f3a0ad81a78c077ae', '402881017185937c017185937f430001', 'remark', '备注', 'remark', 0, 1, 'string', 50, 0, '', '', '', '', 'text', '', 120, NULL, '0', '', '', 0, 1, 1, 0, 'group', '', '', 7, 'admin', '2020-04-18 17:08:51', '2020-04-17 08:39:29', 'admin', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `onl_cgform_field` VALUES ('4ce823134dc031ee4a3a9de5c12341b0', '402881fe72268ef10172268ef1370000', 'approver_id', '审核人', 'approver_id', 0, 1, 'string', 36, 0, '', 'username', 'sys_user', 'realname', 'list', '', 120, NULL, '0', '', '', 0, 1, 1, 0, 'single', '', '', 10, 'admin', '2020-05-18 15:50:07', '2020-05-18 14:53:22', 'admin', '', '', '', '', '', NULL, '0', NULL, NULL, '0');
INSERT INTO `onl_cgform_field` VALUES ('4cf215f0584773ef413a14e1d2e1e18a', '40288183712beaa901712c0eb77c0002', 'bankid_payment', '办款资料行号', 'bankid_payment', 0, 1, 'string', 100, 0, '', '', '', '', 'text', '', 120, NULL, '0', '', '', 0, 1, 0, 0, 'group', '', '', 27, 'admin', '2020-03-31 00:15:25', '2020-03-30 23:28:15', 'admin', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `onl_cgform_field` VALUES ('4d65ddf658802f395642d7fb07fa4c91', '402881e970dd8d520170ddb3a6490004', 'bill_date', 'billDate', 'bill_date', 0, 1, 'Date', 0, 0, '', '', '', '', 'date', '', 120, NULL, '0', '', '', 0, 1, 1, 0, 'group', '', '', 4, 'admin', '2020-03-16 22:39:53', '2020-03-15 18:18:23', 'admin', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `onl_cgform_field` VALUES ('4ddc00cd06f09ce9d3ef77ffa360bec7', '402881e970dd8d520170ddb3a6490004', 'biller_id', '制单人', 'biller_id', 0, 1, 'string', 36, 0, '', '', '', '', 'text', '', 120, NULL, '0', '', '', 0, 1, 1, 0, 'group', '', '', 3, 'admin', '2020-03-16 22:39:53', '2020-03-15 18:18:23', 'admin', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `onl_cgform_field` VALUES ('4e827fbd32e6c201e210d6d23ae64e64', 'c20b114d92ed45eab356431a624dd12b', 'update_time', '更新日期', NULL, 0, 1, 'Date', 20, 0, '', '', '', '', 'datetime', '', 120, NULL, '0', '', '', 0, 0, 0, 0, 'single', '', '', 5, 'admin', '2020-03-20 11:41:31', '2020-03-20 11:29:28', 'admin', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `onl_cgform_field` VALUES ('4e8a241166dc30c1fd182188326b5abb', '402881e970dd8d520170dd90f7c30002', 'invocied_amt', 'invociedAmt', 'invocied_amt', 0, 1, 'BigDecimal', 18, 2, '', '', '', '', 'text', '', 120, NULL, '0', '', '', 0, 1, 1, 0, 'group', '', '', 21, 'admin', '2020-03-15 21:40:40', '2020-03-15 17:40:31', 'admin', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `onl_cgform_field` VALUES ('4f2272ee750aacf785781c23c4966421', '40288183712beaa901712c0ebe7e0004', 'has_child', '是否有子节点', 'has_child', 0, 1, 'string', 3, 0, '', '', '', '', 'text', '', 120, NULL, '0', '', '', 0, 0, 0, 0, 'group', '', '', 3, 'admin', '2020-03-30 23:41:18', '2020-03-30 23:28:16', 'admin', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `onl_cgform_field` VALUES ('4f6032bc4d89c4648e79b28a5bb325c3', '402881fe72362af70172362af7150000', 'approver_id', '审核人', 'approver_id', 0, 1, 'string', 36, 0, '', 'username', 'sys_user', 'realname', 'list', '', 120, NULL, '0', '', '', 0, 1, 1, 0, 'single', '', '', 15, 'admin', '2020-05-21 20:19:56', '2020-05-21 15:38:06', 'admin', '', '', '', '', '', NULL, '0', NULL, NULL, '0');
INSERT INTO `onl_cgform_field` VALUES ('4f718d95ad9de33eac18fd0663e4c1f1', '32f75e4043ef4070919dbd4337186a3d', 'birthday', '生日', NULL, 0, 1, 'Date', 32, 0, '', '', '', '', 'date', '', 120, NULL, '0', '', '', 1, 1, 1, 0, 'single', '', '', 8, 'admin', '2019-04-11 10:15:32', '2019-03-27 15:54:49', 'admin', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `onl_cgform_field` VALUES ('4f7adfad45b469a21152f27dcc63568b', '402881e970dd8d520170dd90f7c30002', 'note2', 'note2', 'note2', 0, 1, 'string', 200, 0, '', '', '', '', 'text', '', 120, NULL, '0', '', '', 0, 1, 1, 0, 'group', '', '', 23, 'admin', '2020-03-15 21:40:40', '2020-03-15 17:40:31', 'admin', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `onl_cgform_field` VALUES ('4f7cba71de7afe6efbd024f5f9935521', '402860816bff91c0016bff91cda80003', 'to_time', '截止时间', 'to_time', 0, 1, 'Date', 0, 0, '', '', '', '', 'date', '', 120, NULL, '0', '', '', 0, 1, 1, 0, 'group', '', '', 4, 'admin', '2019-07-19 18:06:36', '2019-07-17 18:54:34', 'admin', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `onl_cgform_field` VALUES ('4f7de31c5d4de71cf4d700ab0d386415', '40288183712beaa901712c0ebcb10003', 'remark', '备注', 'remark', 0, 1, 'string', 200, 0, '', '', '', '', 'text', '', 120, NULL, '0', '', '', 0, 1, 0, 0, 'group', '', '', 35, 'admin', '2020-03-31 00:04:14', '2020-03-30 23:28:16', 'admin', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `onl_cgform_field` VALUES ('4fa1d9afb5a81a2077361264a7185d00', '40288183712beaa901712beaa9a00000', 'version', '版本', 'version', 0, 1, 'int', 10, 0, '', '', '', '', 'text', '', 120, NULL, '0', '', '', 0, 0, 0, 0, 'group', '', '', 27, 'admin', '2020-04-17 12:01:33', '2020-03-30 22:48:52', 'admin', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `onl_cgform_field` VALUES ('4faeb0c31c9364637a1e3e60dea9e537', '40288101717185240171718524d60000', 'unchecked_amt', '待核销金额', NULL, 0, 0, 'BigDecimal', 18, 2, '', '', '', '', 'text', '', 120, NULL, '0', '', '', 0, 1, 1, 0, 'single', '', '', 8, 'admin', '2020-04-13 14:00:53', '2020-04-13 11:33:26', 'admin', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `onl_cgform_field` VALUES ('4fd3419c8ae7c6a8831ec22a827383d7', '4028818370e8d46b0170e8d46d350001', 'id', 'ID', 'id', 1, 0, 'string', 36, 0, '', '', '', '', 'text', '', 120, NULL, '0', '', '', 0, 0, 0, 0, 'group', '', '', 1, 'admin', '2020-03-17 22:14:27', '2020-03-17 22:10:01', 'admin', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `onl_cgform_field` VALUES ('506c9b0b2331a24e5c284274d28fe569', '27fc5f91274344afa7673a732b279939', 'kkk', '描述', NULL, 0, 1, 'String', 32, 0, '', '', '', '', 'text', '', 120, NULL, '0', '', '', 0, 1, 1, 0, 'single', '', '', 8, 'admin', '2019-07-01 16:28:20', '2019-07-01 16:26:42', 'admin', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `onl_cgform_field` VALUES ('508eb28e1409a2a9501cdf6fd7eb24c7', 'dbf4675875e14676a3f9a8b2b8941140', 'create_by', '创建人', NULL, 0, 1, 'string', 50, 0, '', '', '', '', 'text', '', 120, NULL, '0', '', '', 0, 0, 0, 0, 'single', '', '', 2, NULL, NULL, '2019-05-27 18:02:07', 'admin', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `onl_cgform_field` VALUES ('509a4f63f02e784bc04499a6a9be8528', 'd35109c3632c4952a19ecc094943dd71', 'update_by', '更新人登录名称', NULL, 0, 1, 'string', 50, 0, '', '', '', '', 'text', '', 120, '', '0', '', '', 0, 0, 0, 0, 'single', '', '', 3, 'admin', '2020-02-23 18:11:41', '2019-03-15 14:24:35', 'admin', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `onl_cgform_field` VALUES ('50a25510cf24e0878fe389a2cb2bf9ec', '40288183712a997c01712a99809e0001', 'remark', '备注', 'remark', 0, 1, 'string', 50, 0, NULL, NULL, NULL, NULL, 'text', NULL, 120, NULL, '0', NULL, NULL, 0, 1, 1, 0, 'group', NULL, NULL, 22, NULL, NULL, '2020-03-30 16:40:36', 'admin', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `onl_cgform_field` VALUES ('50ddebd335ccd66748bc04656463309b', '40288183712beaa901712c0ebcb10003', 'short_name', '简称', 'short_name', 0, 1, 'string', 50, 0, '', '', '', '', 'text', '', 120, NULL, '0', '', '', 0, 1, 1, 0, 'group', '', '', 4, 'admin', '2020-03-31 00:04:14', '2020-03-30 23:28:16', 'admin', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `onl_cgform_field` VALUES ('519f68557b953fc2d38400182b187366', '402860816bff91c0016bffa220a9000b', 'residence_type', '户籍类别', 'residence_type', 0, 1, 'string', 100, 0, '', '', '', '', 'text', '', 120, NULL, '0', '', '', 0, 1, 1, 0, 'group', '', '', 13, 'admin', '2019-07-22 16:15:32', '2019-07-17 19:12:24', 'admin', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `onl_cgform_field` VALUES ('51b7f932060c9ad09cc8026e1369b4fe', '40288183712beaa901712c0ebcb10003', 'bankid_invoice', '开票信息行号', 'bankid_invoice', 0, 1, 'string', 100, 0, '', '', '', '', 'text', '', 120, NULL, '0', '', '', 0, 1, 0, 0, 'group', '', '', 20, 'admin', '2020-03-31 00:04:14', '2020-03-30 23:28:16', 'admin', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `onl_cgform_field` VALUES ('522571b0378fae67ee8cdc58862450f5', '40288183712beaa901712c0ebcb10003', 'account_receipt', '收件信息地址', 'account_receipt', 0, 1, 'string', 200, 0, '', '', '', '', 'text', '', 120, NULL, '0', '', '', 0, 1, 0, 0, 'group', '', '', 29, 'admin', '2020-03-31 00:04:14', '2020-03-30 23:28:16', 'admin', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `onl_cgform_field` VALUES ('52bec81efed82f8b842faa8666eaf0b5', '40288183712a997c01712a997c580000', 'handler_id', '经办人', 'handler_id', 0, 1, 'string', 36, 0, '', '', '', '', 'text', '', 120, NULL, '0', '', '', 0, 1, 1, 0, 'group', '', '', 4, 'admin', '2020-03-30 16:48:20', '2020-03-30 16:40:35', 'admin', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `onl_cgform_field` VALUES ('52c60e86d79bdc32650a65429b0f974e', '4028818370e8d46b0170e8d46d350001', 'unit_id', '计量单位', 'unit_id', 0, 1, 'string', 36, 0, '', '', '', '', 'text', '', 120, NULL, '0', '', '', 0, 1, 1, 0, 'group', '', '', 6, 'admin', '2020-03-17 22:14:27', '2020-03-17 22:10:01', 'admin', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `onl_cgform_field` VALUES ('52db7c926eec41f72ea3e49ed2bb2095', '402881fe724af1fc01724af1feaf0001', 'id', 'ID', 'id', 1, 0, 'string', 36, 0, '', '', '', '', 'text', '', 120, NULL, '0', '', '', 0, 0, 0, 1, 'single', '', '', 1, 'admin', '2020-05-25 16:38:12', '2020-05-25 16:27:53', 'admin', '', '', '', '', '', NULL, '0', NULL, NULL, '0');
INSERT INTO `onl_cgform_field` VALUES ('52ee861bc1b62cd8e4f10632b3d9d1b2', '79091e8277c744158530321513119c68', 'name', '顺序会签标题', NULL, 0, 1, 'String', 32, 0, '', '', '', '', 'text', '', 120, NULL, '0', '', '', 0, 1, 1, 0, 'single', '', '', 6, 'admin', '2019-05-11 15:29:47', '2019-05-11 15:27:17', 'admin', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `onl_cgform_field` VALUES ('53566397d2b58c4248e151ae12bed711', '402881fe72362af70172362af7150000', 'id', 'ID', 'id', 1, 0, 'string', 36, 0, '', '', '', '', 'text', '', 120, NULL, '0', '', '', 0, 0, 0, 1, 'single', '', '', 1, 'admin', '2020-05-21 20:19:56', '2020-05-21 15:38:06', 'admin', '', '', '', '', '', NULL, '0', NULL, NULL, '0');
INSERT INTO `onl_cgform_field` VALUES ('53a449b64f3532bebb4a5171dfbc5b03', '40288183712a997c01712a997c580000', 'effective_time', '生效时间', 'effective_time', 0, 1, 'Date', 0, 0, '', '', '', '', 'date', '', 120, NULL, '0', '', '', 0, 1, 1, 0, 'group', '', '', 16, 'admin', '2020-03-30 16:48:20', '2020-03-30 16:40:35', 'admin', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `onl_cgform_field` VALUES ('53a9f4250d447dae603f9b3c5aecec6f', '402881017185937c017185937c100000', 'effective_time', '生效时间', 'effective_time', 0, 1, 'Date', 0, 0, '', '', '', '', 'date', '', 120, NULL, '0', '', '', 0, 1, 1, 1, 'group', '', '', 12, 'admin', '2020-04-17 11:31:14', '2020-04-17 08:39:28', 'admin', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `onl_cgform_field` VALUES ('540317bff414e68b0cce27d969908a3e', '40288183712beaa901712beaa9a00000', 'is_approved', '是否通过', 'is_approved', 0, 1, 'int', 3, 0, '0', 'yn', '', '', 'list', '', 120, NULL, '0', '', '', 0, 1, 1, 1, 'group', '', '', 18, 'admin', '2020-04-17 12:01:33', '2020-03-30 22:48:52', 'admin', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `onl_cgform_field` VALUES ('55467d92a9100c33277d7df02836ff6f', '40288183712beaa901712c0eb77c0002', 'unit_payment', '办款资料单位名称', 'unit_payment', 0, 1, 'string', 200, 0, '', '', '', '', 'text', '', 120, NULL, '0', '', '', 0, 1, 0, 0, 'group', '', '', 25, 'admin', '2020-03-31 00:15:25', '2020-03-30 23:28:15', 'admin', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `onl_cgform_field` VALUES ('558d8f37be7cc51dcea5029472249425', '40288183712beaa901712c0ebe7e0004', 'code', '编码', 'code', 0, 0, 'string', 50, 0, '', '', '', '', 'text', '', 120, NULL, '0', '', '', 0, 1, 1, 0, 'group', '', '', 4, 'admin', '2020-03-30 23:41:18', '2020-03-30 23:28:16', 'admin', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `onl_cgform_field` VALUES ('561277e5c7469c614788bb3fb506e0f1', '402881fe724af1fc01724af1feaf0001', 'version', '版本', 'version', 0, 1, 'int', 10, 0, '', '', '', '', 'text', '', 120, NULL, '0', '', '', 0, 0, 0, 0, 'single', '', '', 13, 'admin', '2020-05-25 16:38:12', '2020-05-25 16:27:53', 'admin', '', '', '', '', '', NULL, '0', NULL, NULL, '0');
INSERT INTO `onl_cgform_field` VALUES ('56741f95a2eef88dca0907629d56b72c', '40288183712beaa901712c0ebcb10003', 'phone_financial', '财务信息联系电话', 'phone_financial', 0, 1, 'string', 50, 0, '', '', '', '', 'text', '', 120, NULL, '0', '', '', 0, 1, 0, 0, 'group', '', '', 17, 'admin', '2020-03-31 00:04:14', '2020-03-30 23:28:16', 'admin', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `onl_cgform_field` VALUES ('56a7800e4e476812c74217c2aad781aa', '32feeb502544416c9bf41329c10a88f4', 'update_time', '更新日期', NULL, 0, 1, 'Date', 20, 0, '', '', '', '', 'datetime', '', 120, NULL, '0', '', '', 0, 0, 0, 0, 'single', '', '', 5, 'admin', '2019-08-23 20:03:40', '2019-07-02 18:23:23', 'admin', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `onl_cgform_field` VALUES ('56cd0a76f922bf76d982b24a509e4782', '4028839a6de2ebd3016de2ebd3870000', 'create_time', '创建日期', 'create_time', 0, 1, 'Date', 0, 0, NULL, NULL, NULL, NULL, 'date', NULL, 120, NULL, '0', NULL, NULL, 0, 1, 1, 0, 'group', NULL, NULL, 3, NULL, NULL, '2019-10-19 15:29:30', 'admin', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `onl_cgform_field` VALUES ('56d243a317c1b6cde4eff522b0c45770', '402881fe71c8c4fd0171c8c4fdae0000', 'bill_date', '单据日期', 'bill_date', 0, 1, 'Date', 0, 0, '', '', '', '', 'date', '', 120, NULL, '0', '', '', 1, 1, 1, 0, 'group', '', '', 3, 'admin', '2020-04-30 10:23:44', '2020-04-30 09:48:06', 'admin', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `onl_cgform_field` VALUES ('56e247f12d62b49cd9bd537e3efecf16', '402860816bff91c0016bff91c0cb0000', 'create_by', '创建人', 'create_by', 0, 1, 'string', 100, 0, '', '', '', '', 'text', '', 120, NULL, '0', '', '', 0, 1, 1, 0, 'group', '', '', 12, 'admin', '2019-07-19 18:09:01', '2019-07-17 18:54:32', 'admin', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `onl_cgform_field` VALUES ('573d35767986a6c6b0738e3d7b9ad16f', '402881fe724af1fc01724af1feaf0001', 'is_init', '是否初始数据', 'is_init', 0, 0, 'int', 3, 0, '', 'yn', '', '', 'list', '', 120, NULL, '0', '', '', 0, 1, 1, 0, 'single', '', '', 12, 'admin', '2020-05-25 16:38:12', '2020-05-25 16:27:53', 'admin', '', '', '', '', '', NULL, '0', NULL, NULL, '0');
INSERT INTO `onl_cgform_field` VALUES ('574d5a48b65810628f7be2d74af55010', '402881fe71c8c4fd0171c8c500d30001', 'remark2', '备注2', 'remark2', 0, 1, 'string', 50, 0, '', '', '', '', 'text', '', 120, NULL, '0', '', '', 0, 1, 1, 0, 'group', '', '', 12, 'admin', '2020-04-30 10:30:12', '2020-04-30 09:48:07', 'admin', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `onl_cgform_field` VALUES ('585eb46631d172b39297d7b30921f1c3', '402881fe724af1fc01724af1feaf0001', 'begin_bal', '期初余额', 'begin_bal', 0, 1, 'BigDecimal', 18, 2, '', '', '', '', 'text', '', 120, NULL, '0', '', '', 0, 1, 1, 0, 'single', '', '', 7, 'admin', '2020-05-25 16:38:12', '2020-05-25 16:27:53', 'admin', '', '', '', '', '', NULL, '0', NULL, NULL, '0');
INSERT INTO `onl_cgform_field` VALUES ('588400f6ebcdd0bc9bb560dd36636af9', 'e2faf977fdaf4b25a524f58c2441a51c', 'update_by', '更新人', NULL, 0, 1, 'string', 50, 0, '', '', '', '', 'text', '', 120, NULL, '0', '', '', 0, 0, 0, 0, 'single', '', '', 4, 'admin', '2019-06-10 17:27:00', '2019-04-24 17:12:11', 'admin', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `onl_cgform_field` VALUES ('58a96f945912d33b64ebf5dee98156dc', '402860816bff91c0016bffa220a9000b', 'mobile', '手机号', 'mobile', 0, 1, 'string', 20, 0, '', '', '', '', 'text', '', 120, NULL, '0', '', '', 0, 1, 1, 0, 'group', '', '', 19, 'admin', '2019-07-22 16:15:32', '2019-07-17 19:12:24', 'admin', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `onl_cgform_field` VALUES ('58c3b02ce1605e489edea4461d7312e9', '402881fe71c8c4fd0171c8c4fdae0000', 'flow_id', '流程', 'flow_id', 0, 1, 'string', 36, 0, '', '', '', '', 'text', '', 120, NULL, '0', '', '', 0, 1, 1, 1, 'group', '', '', 17, 'admin', '2020-04-30 10:23:44', '2020-04-30 09:48:06', 'admin', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `onl_cgform_field` VALUES ('58eea85add4788b83c893092434bc413', 'fb19fb067cd841f9ae93d4eb3b883dc0', 'update_time', '更新日期', NULL, 0, 1, 'date', 20, 0, '', '', '', '', 'text', '', 120, '', '0', '', '', 0, 1, 1, 0, 'single', '', '', 4, NULL, NULL, '2019-03-23 11:39:48', 'admin', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `onl_cgform_field` VALUES ('59ae1e853668c676e85329aa029c68a6', '402860816bff91c0016bff91c0cb0000', 'status', '状态（1：申请中 2：通过）', 'status', 0, 1, 'string', 2, 0, '', '', '', '', 'text', '', 120, NULL, '0', '', '', 0, 1, 1, 0, 'group', '', '', 11, 'admin', '2019-07-19 18:09:01', '2019-07-17 18:54:32', 'admin', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `onl_cgform_field` VALUES ('59edbccaa1da2d69d641aa3b48c94f2a', '40288183712a997c01712a99809e0001', 'settle_qty', '结算数量', 'settle_qty', 0, 1, 'BigDecimal', 18, 6, NULL, NULL, NULL, NULL, 'text', NULL, 120, NULL, '0', NULL, NULL, 0, 1, 1, 0, 'group', NULL, NULL, 13, NULL, NULL, '2020-03-30 16:40:36', 'admin', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `onl_cgform_field` VALUES ('5a0d6dbb07965859bbcf90789dc7a73b', '4028818371790b3f0171795b83bd0003', 'update_time', '修改时间', 'update_time', 0, 1, 'Date', 0, 0, '', '', '', '', 'date', '', 120, NULL, '0', '', '', 0, 1, 1, 0, 'group', '', '', 15, 'admin', '2020-04-14 23:46:44', '2020-04-14 23:42:53', 'admin', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `onl_cgform_field` VALUES ('5a1ab458d88bb766f92c3d791495cdcd', '402860816bff91c0016bff91d2810005', 'age', '年龄', 'age', 0, 1, 'int', 10, 0, '', '', '', '', 'text', '', 120, NULL, '0', '', '', 0, 1, 1, 0, 'group', '', '', 5, 'admin', '2019-07-19 18:05:55', '2019-07-17 18:54:35', 'admin', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `onl_cgform_field` VALUES ('5a2b3b20751c03a228f796c5d9b874d3', '402881e970dd8d520170dd90f7c30002', 'tax', 'tax', 'tax', 0, 1, 'BigDecimal', 18, 2, '', '', '', '', 'text', '', 120, NULL, '0', '', '', 0, 1, 1, 0, 'group', '', '', 16, 'admin', '2020-03-15 21:40:40', '2020-03-15 17:40:31', 'admin', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `onl_cgform_field` VALUES ('5a4ef083dd572114aeb581b6828de545', '402860816bff91c0016bff91c7010001', 'award_name', '获奖名称', 'award_name', 0, 1, 'string', 255, 0, '', '', '', '', 'text', '', 120, NULL, '0', '', '', 0, 1, 1, 0, 'group', '', '', 5, 'admin', '2019-07-19 18:07:47', '2019-07-17 18:54:32', 'admin', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `onl_cgform_field` VALUES ('5a621f27aa443fe9eccc73717e4fa172', '4028318169e81b970169e81b97650000', 'method', '请求java方法', 'method', 0, 1, 'string', 500, 0, NULL, NULL, NULL, NULL, 'text', NULL, 120, NULL, '0', NULL, NULL, 0, 1, 1, 0, 'group', NULL, NULL, 8, NULL, NULL, '2019-04-04 19:28:36', 'admin', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `onl_cgform_field` VALUES ('5a655b208d6318ed02f236f15a319b5f', 'fbc35f067da94a70adb622ddba259352', 'update_time', '更新日期', NULL, 0, 1, 'Date', 20, 0, '', '', '', '', 'datetime', '', 120, NULL, '0', '', '', 0, 0, 0, 0, 'single', '', '', 5, NULL, NULL, '2019-07-03 19:44:23', 'admin', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `onl_cgform_field` VALUES ('5a6f88710c49bbe8e2e0ca58e149abad', '402860816bff91c0016bff91cda80003', 'create_by', '创建人', 'create_by', 0, 1, 'string', 100, 0, '', '', '', '', 'text', '', 120, NULL, '0', '', '', 0, 1, 1, 0, 'group', '', '', 9, 'admin', '2019-07-19 18:06:36', '2019-07-17 18:54:34', 'admin', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `onl_cgform_field` VALUES ('5aaa3f8e6eb7d08e380225be9280d754', '402881fe71c8c4fd0171c8c500d30001', 'version', '版本', 'version', 0, 1, 'int', 10, 0, '', '', '', '', 'text', '', 120, NULL, '0', '', '', 0, 0, 1, 0, 'group', '', '', 14, 'admin', '2020-04-30 10:30:12', '2020-04-30 09:48:07', 'admin', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `onl_cgform_field` VALUES ('5b17ba693745c258f6b66380ac851e5f', 'd35109c3632c4952a19ecc094943dd71', 'id', '主键', NULL, 1, 0, 'string', 36, 0, '', '', '', '', 'text', '', 120, '', '0', '', '', 0, 1, 1, 0, 'single', '', '', 0, 'admin', '2020-02-23 18:11:41', '2019-03-15 14:24:35', 'admin', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `onl_cgform_field` VALUES ('5b28bce9f88ddf905acf4eddcf3e659e', '4028818370f5f37d0170f5f37dcf0000', 'create_by', '创建人', 'create_by', 0, 1, 'string', 36, 0, '', '', '', '', 'text', '', 120, NULL, '0', '', '', 0, 1, 1, 0, 'group', '', '', 9, 'admin', '2020-03-20 12:02:35', '2020-03-20 11:19:01', 'admin', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `onl_cgform_field` VALUES ('5ba27bd3b3a92b07c4305f9f79b5c62f', '40288183712a997c01712a997c580000', 'type', '出入库类型', 'type', 0, 1, 'string', 10, 0, '', '', '', '', 'text', '', 120, NULL, '0', '', '', 0, 1, 1, 0, 'group', '', '', 5, 'admin', '2020-03-30 16:48:20', '2020-03-30 16:40:35', 'admin', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `onl_cgform_field` VALUES ('5bac86df8146cd82c49b4efc981968c4', '871c2df1185c4c8e80377d3c319c9a1e', 'id', '主键', NULL, 1, 0, 'string', 36, 0, '', '', '', '', 'text', '', 120, NULL, '0', '', '', 0, 0, 0, 1, 'single', '', '', 1, NULL, NULL, '2020-03-20 11:42:58', 'admin', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `onl_cgform_field` VALUES ('5bfc44b0d62d423d74de2ce3c8bd0e1b', '40288183712a997c01712a99809e0001', 'settle_amt', '结算金额', 'settle_amt', 0, 1, 'BigDecimal', 18, 2, NULL, NULL, NULL, NULL, 'text', NULL, 120, NULL, '0', NULL, NULL, 0, 1, 1, 0, 'group', NULL, NULL, 19, NULL, NULL, '2020-03-30 16:40:36', 'admin', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `onl_cgform_field` VALUES ('5c76f5ecc774d7339eb0c2199c0052bc', '402860816bff91c0016bff91c0cb0000', 'biz_no', '编号', 'biz_no', 0, 1, 'string', 64, 0, '', '', '', '', 'text', '', 120, NULL, '0', '', '', 0, 1, 1, 0, 'group', '', '', 2, 'admin', '2019-07-19 18:09:01', '2019-07-17 18:54:32', 'admin', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `onl_cgform_field` VALUES ('5c7d5ee0497f096e2db422013d3b3392', '402881017185937c017185937c100000', 'approver_id', '审核人', 'approver_id', 0, 1, 'string', 36, 0, '', 'username', 'sys_user', 'realname', 'list', '', 120, NULL, '0', '', '', 0, 1, 1, 1, 'group', '', '', 13, 'admin', '2020-04-17 11:31:14', '2020-04-17 08:39:28', 'admin', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `onl_cgform_field` VALUES ('5c8c8d573e01e4f40b5a7c451515e1d2', '32feeb502544416c9bf41329c10a88f4', 'create_time', '创建日期', NULL, 0, 1, 'Date', 20, 0, '', '', '', '', 'datetime', '', 120, NULL, '0', '', '', 0, 0, 0, 0, 'single', '', '', 3, 'admin', '2019-08-23 20:03:40', '2019-07-02 18:23:23', 'admin', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `onl_cgform_field` VALUES ('5c9990802f424e7b9333f126314fab29', '402881fe72268ef10172268ef1370000', 'is_voided', '是否作废', 'is_voided', 0, 0, 'int', 3, 0, '', 'yn', '', '', 'list', '', 120, NULL, '0', '', '', 0, 1, 1, 0, 'single', '', '', 14, 'admin', '2020-05-18 15:50:07', '2020-05-18 14:53:22', 'admin', '', '', '', '', '', NULL, '0', NULL, NULL, '0');
INSERT INTO `onl_cgform_field` VALUES ('5ca156da250ce16fe02da7914c55009a', '40288183712beaa901712c0eb77c0002', 'is_enabled', '是否启用', 'is_enabled', 0, 1, 'int', 3, 0, '', 'yn', '', '', 'list', '', 120, NULL, '0', '', '', 0, 1, 1, 0, 'group', '', '', 36, 'admin', '2020-03-31 00:15:25', '2020-03-30 23:28:15', 'admin', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `onl_cgform_field` VALUES ('5cdab91ece0a5bf6e3324f0ff1bc3be8', '4028818371790b3f0171790b3f780000', 'create_by', '创建人', 'create_by', 0, 1, 'string', 36, 0, '', 'username', 'sys_user', 'realname', 'list', '', 120, NULL, '0', '', '', 0, 1, 1, 1, 'group', '', '', 19, 'admin', '2020-04-14 23:41:28', '2020-04-14 22:15:13', 'admin', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `onl_cgform_field` VALUES ('5cff022ffcbabc0eabcaa6c64bafaa24', '402881fe71c8c4fd0171c8c503230002', 'update_time', '修改时间', 'update_time', 0, 1, 'Date', 0, 0, '', '', '', '', 'date', '', 120, NULL, '0', '', '', 0, 1, 1, 1, 'group', '', '', 23, 'admin', '2020-04-30 10:30:53', '2020-04-30 09:48:07', 'admin', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `onl_cgform_field` VALUES ('5d51c6df4fd748c1dfa36be41eb0319b', '402881e970dd8d520170ddb3a6490004', 'update_by', 'updateBy', 'update_by', 0, 1, 'string', 36, 0, '', '', '', '', 'text', '', 120, NULL, '0', '', '', 0, 1, 1, 0, 'group', '', '', 22, 'admin', '2020-03-16 22:39:53', '2020-03-15 18:18:23', 'admin', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `onl_cgform_field` VALUES ('5d8131c207db5cab49ce9f78fa0d43c9', '40288183712beaa901712c0eb77c0002', 'address', '客户地址', 'address', 0, 1, 'string', 200, 0, '', '', '', '', 'text', '', 120, NULL, '0', '', '', 0, 1, 0, 0, 'group', '', '', 15, 'admin', '2020-03-31 00:15:25', '2020-03-30 23:28:15', 'admin', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `onl_cgform_field` VALUES ('5dbc21a75482a1ba87a220967f8d2bf4', '40288183712beaa901712c0ebcb10003', 'phone_receipt', '收件信息联系电话', 'phone_receipt', 0, 1, 'string', 50, 0, '', '', '', '', 'text', '', 120, NULL, '0', '', '', 0, 1, 0, 0, 'group', '', '', 32, 'admin', '2020-03-31 00:04:14', '2020-03-30 23:28:16', 'admin', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `onl_cgform_field` VALUES ('5dd713792f8cce95d929eafb73789a85', '402881fe72268ef10172268ef3ec0001', 'qty', '实存数量', 'qty', 0, 1, 'BigDecimal', 18, 6, '', '', '', '', 'text', '', 120, NULL, '0', '', '', 0, 1, 1, 0, 'single', '', '', 12, 'admin', '2020-05-18 15:55:16', '2020-05-18 14:53:23', 'admin', '', '', '', '', '', NULL, '0', NULL, NULL, '0');
INSERT INTO `onl_cgform_field` VALUES ('5dfbea516ee2390d712eace5405c5219', '402860816bff91c0016bff91ca7e0002', 'create_by', '创建人', 'create_by', 0, 1, 'string', 100, 0, '', '', '', '', 'text', '', 120, NULL, '0', '', '', 0, 1, 1, 0, 'group', '', '', 9, 'admin', '2019-07-19 18:07:13', '2019-07-17 18:54:33', 'admin', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `onl_cgform_field` VALUES ('5e4484b7348dc3e59a0c58bdc3828cc0', '27fc5f91274344afa7673a732b279939', 'update_by', '更新人', NULL, 0, 1, 'string', 50, 0, '', '', '', '', 'text', '', 120, NULL, '0', '', '', 0, 0, 0, 0, 'single', '', '', 4, 'admin', '2019-07-01 16:28:20', '2019-07-01 16:26:42', 'admin', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `onl_cgform_field` VALUES ('5e4ac29ac2007ceabf93368330290a42', '402860816bff91c0016bff91d8830007', 'order_no', '序号', 'order_no', 0, 1, 'int', 10, 0, '', '', '', '', 'text', '', 120, NULL, '0', '', '', 0, 1, 1, 0, 'group', '', '', 9, 'admin', '2019-07-19 18:04:41', '2019-07-17 18:54:37', 'admin', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `onl_cgform_field` VALUES ('5f5ac4d37fd1a3a09e2b19f0d4d99c0f', '4adec929a6594108bef5b35ee9966e9f', 'code', '编码', NULL, 0, 1, 'String', 200, 0, '', '', '', '', 'text', '', 120, NULL, '0', '', '${order_num_rule_param}', 0, 1, 1, 0, 'single', '', '', 2, 'admin', '2020-04-10 19:43:38', '2020-04-10 19:35:58', 'admin', '', '', '', '', '', NULL, '0', NULL, NULL, '0');
INSERT INTO `onl_cgform_field` VALUES ('5fd7808fbba90f18c50a59279f0b4aa6', '402881fe72362af70172362af7150000', 'flow_id', '流程id', 'flow_id', 0, 1, 'string', 36, 0, '', '', '', '', 'text', '', 120, NULL, '0', '', '', 0, 1, 1, 0, 'single', '', '', 16, 'admin', '2020-05-21 20:19:56', '2020-05-21 15:38:06', 'admin', '', '', '', '', '', NULL, '0', NULL, NULL, '0');
INSERT INTO `onl_cgform_field` VALUES ('5ffd3f5a180e64e7ba378ad108f3b01c', '40288183712beaa901712beaa9a00000', 'source_type', '源单类型', 'source_type', 0, 1, 'string', 20, 0, '', 'x_bill_type', '', '', 'list', '', 120, NULL, '0', '', '', 0, 1, 1, 0, 'group', '', '', 5, 'admin', '2020-04-17 12:01:33', '2020-03-30 22:48:52', 'admin', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `onl_cgform_field` VALUES ('5fff09630430cf305e4c228949ce5556', '402881fe724af1fc01724af1feaf0001', 'customer_id', '客户', 'customer_id', 0, 1, 'string', 36, 0, '', 'id', 'bas_customer', 'name', 'list', '', 120, NULL, '0', '', '', 1, 1, 1, 0, 'single', '', '', 5, 'admin', '2020-05-25 16:38:12', '2020-05-25 16:27:53', 'admin', '', '', '', '', '', NULL, '0', NULL, NULL, '0');
INSERT INTO `onl_cgform_field` VALUES ('6033b1eea04905a8be272d372e018a8d', '40288183712beaa901712beaa9a00000', 'has_rp', '是否有往来', 'has_rp', 0, 1, 'int', 3, 0, '', 'yn', '', '', 'list', '', 120, NULL, '0', '', '', 0, 1, 1, 0, 'group', '', '', 9, 'admin', '2020-04-17 12:01:33', '2020-03-30 22:48:52', 'admin', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `onl_cgform_field` VALUES ('607611c4cd1a02f37e74959f4d5ec749', '402881fe72362af70172362af7150000', 'invoice_type', '发票类型', 'invoice_type', 0, 1, 'string', 10, 0, '', 'x_invoice_type', '', '', 'list', '', 120, NULL, '0', '', '', 0, 1, 1, 0, 'single', '', '', 5, 'admin', '2020-05-21 20:19:56', '2020-05-21 15:38:06', 'admin', '', '', '', '', '', NULL, '0', NULL, NULL, '0');
INSERT INTO `onl_cgform_field` VALUES ('6093036515316331db7f052e0348997c', '402881e970dd8d520170ddb3a6490004', 'remark2', 'remark2', 'remark2', 0, 1, 'string', 50, 0, '', '', '', '', 'text', '', 120, NULL, '0', '', '', 0, 1, 1, 0, 'group', '', '', 14, 'admin', '2020-03-16 22:39:53', '2020-03-15 18:18:23', 'admin', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `onl_cgform_field` VALUES ('60eea0e7d32dee05f71dd6ac031fde55', '40288183712a997c01712a997c580000', 'update_time', '修改时间', 'update_time', 0, 1, 'Date', 0, 0, '', '', '', '', 'date', '', 120, NULL, '0', '', '', 0, 1, 1, 0, 'group', '', '', 22, 'admin', '2020-03-30 16:48:20', '2020-03-30 16:40:35', 'admin', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `onl_cgform_field` VALUES ('61117e3170dde4f0428744d9a9dc2d32', '40288183712beaa901712beaa9a00000', 'id', 'ID', 'id', 1, 0, 'string', 36, 0, '', '', '', '', 'text', '', 120, NULL, '0', '', '', 0, 0, 0, 0, 'group', '', '', 1, 'admin', '2020-04-17 12:01:33', '2020-03-30 22:48:52', 'admin', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `onl_cgform_field` VALUES ('617349b18dab429009ccd304fd7d459c', '4028839a6de2ebd3016de2ebd3870000', 'update_by', '更新人', 'update_by', 0, 1, 'string', 50, 0, NULL, NULL, NULL, NULL, 'text', NULL, 120, NULL, '0', NULL, NULL, 0, 1, 1, 0, 'group', NULL, NULL, 4, NULL, NULL, '2019-10-19 15:29:30', 'admin', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `onl_cgform_field` VALUES ('61c7a0058c264dd746eb35e6f50fc15b', '402860816aa5921f016aa5dedcb90009', 'update_time', '更新日期', 'update_time', 0, 1, 'Date', 0, 0, '', '', '', '', 'date', '', 120, NULL, '0', '', '', 0, 0, 0, 0, 'group', '', '', 5, 'admin', '2019-05-11 15:56:47', '2019-05-11 15:50:08', 'admin', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `onl_cgform_field` VALUES ('6213c5410133ad50d2798f20f17205f9', '402881fe724af1fc01724af1feaf0001', 'ytd_debit_amt', '本年累计借方金额', 'ytd_debit_amt', 0, 1, 'BigDecimal', 18, 2, '', '', '', '', 'text', '', 120, NULL, '0', '', '', 0, 1, 1, 0, 'single', '', '', 10, 'admin', '2020-05-25 16:38:12', '2020-05-25 16:27:53', 'admin', '', '', '', '', '', NULL, '0', NULL, NULL, '0');
INSERT INTO `onl_cgform_field` VALUES ('622d7d15ebeb92bd1a8326514046e039', '40288183712beaa901712beaa9a00000', 'bill_date', '单据日期', 'bill_date', 0, 1, 'Date', 0, 0, '', '', '', '', 'date', '', 120, NULL, '0', '', '', 1, 1, 1, 0, 'group', '', '', 4, 'admin', '2020-04-17 12:01:33', '2020-03-30 22:48:52', 'admin', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `onl_cgform_field` VALUES ('6232ade7e2a0c1e97e2c0945b32e61b6', '402860816bff91c0016bffa220a9000b', 'paying_social_insurance', '是否上社保', 'paying_social_insurance', 0, 1, 'string', 20, 0, '', '', '', '', 'text', '', 120, NULL, '0', '', '', 0, 1, 1, 0, 'group', '', '', 32, 'admin', '2019-07-22 16:15:32', '2019-07-17 19:12:24', 'admin', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `onl_cgform_field` VALUES ('62d1eecee8a2c5d86c74906573d949d9', '402881017185937c017185937c100000', 'is_closed', '是否关闭', 'is_closed', 0, 0, 'int', 3, 0, '', 'yn', '', '', 'list', '', 120, NULL, '0', '', '', 0, 1, 1, 1, 'group', '', '', 10, 'admin', '2020-04-17 11:31:14', '2020-04-17 08:39:28', 'admin', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `onl_cgform_field` VALUES ('63f9d160c54a1aae9f8a26d11c490c96', '40288101710a4c6201710a4c62b50000', 'create_time', '创建时间', 'create_time', 0, 1, 'Date', 0, 0, '', '', '', '', 'date', '', 120, NULL, '0', '', '', 0, 1, 0, 1, 'group', '', '', 9, 'admin', '2020-03-24 10:18:35', '2020-03-24 10:08:31', 'admin', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `onl_cgform_field` VALUES ('646a4ec23889e2618a606c34ece0fe44', '402881fe71c8c4fd0171c8c500d30001', 'mid', '主表', 'mid', 0, 0, 'string', 36, 0, '', '', '', '', 'text', '', 120, NULL, '0', '', '', 0, 0, 0, 0, 'group', 'fin_receipt', 'id', 2, 'admin', '2020-04-30 10:30:11', '2020-04-30 09:48:07', 'admin', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `onl_cgform_field` VALUES ('6490a98dccb6df218feaeb4ce11bc03b', '402860816aa5921f016aa5921f480000', 'update_time', '修改时间', 'update_time', 0, 1, 'Date', 0, 0, '', '', '', '', 'date', '', 120, NULL, '0', '', '', 0, 0, 0, 0, 'group', '', '', 10, 'admin', '2019-05-11 15:31:54', '2019-05-11 14:26:19', 'admin', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `onl_cgform_field` VALUES ('654362725195829005036b3db47ec826', '402860816bff91c0016bffa220a9000b', 'post', '职务', 'post', 0, 1, 'string', 100, 0, '', '', '', '', 'text', '', 120, NULL, '0', '', '', 0, 1, 1, 0, 'group', '', '', 4, 'admin', '2019-07-22 16:15:32', '2019-07-17 19:12:24', 'admin', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `onl_cgform_field` VALUES ('65560032a06e38f3e2873ed96a37ee53', '40288101710a4c6201710a4c62b50000', 'symbol', '符号', 'symbol', 0, 1, 'string', 50, 0, '', '', '', '', 'text', '', 120, NULL, '0', '', '', 0, 1, 1, 0, 'group', '', '', 3, 'admin', '2020-03-24 10:18:35', '2020-03-24 10:08:31', 'admin', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `onl_cgform_field` VALUES ('658522ab1082facccfd882851b3ac563', '40288183712a997c01712a997c580000', 'is_voided', '是否作废', 'is_voided', 0, 1, 'int', 3, 0, '', '', '', '', 'text', '', 120, NULL, '0', '', '', 0, 1, 1, 0, 'group', '', '', 17, 'admin', '2020-03-30 16:48:20', '2020-03-30 16:40:35', 'admin', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `onl_cgform_field` VALUES ('664624eae27e3cce509198c23152510c', '4028818371790b3f0171790b3f780000', 'is_voided', '是否作废', 'is_voided', 0, 0, 'int', 3, 0, '', 'yn', '', '', 'list', '', 120, NULL, '0', '', '', 0, 1, 1, 1, 'group', '', '', 14, 'admin', '2020-04-14 23:41:28', '2020-04-14 22:15:13', 'admin', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `onl_cgform_field` VALUES ('664731d9acc46e9d105f0f3104092334', '4028818370e8d46b0170e8d46b4b0000', 'approved', '是否通过', 'approved', 0, 1, 'int', 3, 0, '', '', '', '', 'text', '', 120, NULL, '0', '', '', 0, 1, 1, 0, 'group', '', '', 16, 'admin', '2020-03-19 10:25:32', '2020-03-17 22:10:01', 'admin', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `onl_cgform_field` VALUES ('669ef44ce2c09c10f37045a3d2c29170', '402881fe72362af70172362afadf0001', 'note', '备注', 'note', 0, 1, 'string', 50, 0, '', '', '', '', 'text', '', 120, NULL, '0', '', '', 0, 1, 1, 0, 'single', '', '', 11, 'admin', '2020-05-21 20:23:41', '2020-05-21 15:38:06', 'admin', '', '', '', '', '', NULL, '0', NULL, NULL, '0');
INSERT INTO `onl_cgform_field` VALUES ('66a7ef842bc34e105a90186e48167ef2', 'dbf4675875e14676a3f9a8b2b8941140', 'create_time', '创建日期', NULL, 0, 1, 'Date', 20, 0, '', '', '', '', 'datetime', '', 120, NULL, '0', '', '', 0, 0, 0, 0, 'single', '', '', 3, NULL, NULL, '2019-05-27 18:02:07', 'admin', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `onl_cgform_field` VALUES ('671a97b309a67864a6b7b0df7ec929b2', '402881e970dd8d520170ddb3a6490004', 'effective_time', 'effectiveTime', 'effective_time', 0, 1, 'Date', 0, 0, '', '', '', '', 'date', '', 120, NULL, '0', '', '', 0, 1, 1, 0, 'group', '', '', 19, 'admin', '2020-03-16 22:39:53', '2020-03-15 18:18:23', 'admin', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `onl_cgform_field` VALUES ('67ae7d757e74374f3e953e7bfaa16fb2', '40288101710a4c6201710a60ad5e0001', 'pid', '基准单位', 'pid', 0, 1, 'string', 36, 0, '0', '0', 'bas_measure_unit', 'id,pid,name,has_child', 'sel_tree', '', 120, NULL, '0', '', '', 0, 1, 0, 0, 'group', '', '', 5, 'admin', '2020-03-28 09:52:10', '2020-03-24 10:30:41', 'admin', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `onl_cgform_field` VALUES ('67fdfb239d8f0363b89ad6d630be7747', '402881fe71c8c4fd0171c8c4fdae0000', 'update_time', '修改时间', 'update_time', 0, 1, 'Date', 0, 0, '', '', '', '', 'date', '', 120, NULL, '0', '', '', 0, 1, 1, 1, 'group', '', '', 21, 'admin', '2020-04-30 10:23:44', '2020-04-30 09:48:06', 'admin', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `onl_cgform_field` VALUES ('680f928dffa8d709445434c3f20c4b95', '402881e970dd8d520170ddb3a6490004', 'entry_count', 'entryCount', 'entry_count', 0, 1, 'int', 5, 0, '', '', '', '', 'text', '', 120, NULL, '0', '', '', 0, 1, 1, 0, 'group', '', '', 11, 'admin', '2020-03-16 22:39:53', '2020-03-15 18:18:23', 'admin', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `onl_cgform_field` VALUES ('68769fa7e4696e3a28f4cecf63076b7b', '402860816bff91c0016bff91ca7e0002', 'order_no', '序号', 'order_no', 0, 1, 'int', 10, 0, '', '', '', '', 'text', '', 120, NULL, '0', '', '', 0, 1, 1, 0, 'group', '', '', 8, 'admin', '2019-07-19 18:07:13', '2019-07-17 18:54:33', 'admin', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `onl_cgform_field` VALUES ('687d78d70762591cb6392c448efb8465', '402881e970dd8d520170dd90f7c30002', 'discount_rate', 'discountRate', 'discount_rate', 0, 1, 'BigDecimal', 10, 6, '', '', '', '', 'text', '', 120, NULL, '0', '', '', 0, 1, 1, 0, 'group', '', '', 17, 'admin', '2020-03-15 21:40:40', '2020-03-15 17:40:31', 'admin', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `onl_cgform_field` VALUES ('68a0b0e9131dd7a600eb104207baa8ae', '4028818371790b3f0171790b43ac0001', 'remark2', '备注2', 'remark2', 0, 1, 'string', 50, 0, '', '', '', '', 'text', '', 120, NULL, '0', '', '', 0, 1, 1, 0, 'group', '', '', 10, 'admin', '2020-04-14 23:25:38', '2020-04-14 22:15:14', 'admin', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `onl_cgform_field` VALUES ('69666f21896136af16a6303aff440156', '402860816bff91c0016bffa220a9000b', 'nation', '民族', 'nation', 0, 1, 'string', 100, 0, '', '', '', '', 'text', '', 120, NULL, '0', '', '', 0, 1, 1, 0, 'group', '', '', 11, 'admin', '2019-07-22 16:15:32', '2019-07-17 19:12:24', 'admin', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `onl_cgform_field` VALUES ('69d11490788fecfc9fb7d74bf449ba86', '32f75e4043ef4070919dbd4337186a3d', 'create_time', '创建日期', NULL, 0, 1, 'Date', 20, 0, '', '', '', '', 'datetime', '', 120, NULL, '0', '', '', 0, 0, 0, 0, 'single', '', '', 2, 'admin', '2019-04-11 10:15:32', '2019-03-27 15:54:49', 'admin', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `onl_cgform_field` VALUES ('69db9453edb2beed9599a79274a79d6b', '40288183712beaa901712beaa9a00000', 'create_time', '创建时间', 'create_time', 0, 1, 'Date', 0, 0, '', '', '', '', 'date', '', 120, NULL, '0', '', '', 0, 1, 1, 1, 'group', '', '', 24, 'admin', '2020-04-17 12:01:33', '2020-03-30 22:48:52', 'admin', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `onl_cgform_field` VALUES ('6a0082c8ffbae092e99689520f1c83f7', '4fb8e12a697f4d5bbe9b9fb1e9009486', 'update_time', '更新日期', NULL, 0, 1, 'Date', 20, 0, '', '', '', '', 'datetime', '', 120, NULL, '0', '', '', 0, 0, 0, 0, 'single', '', '', 9, 'admin', '2020-04-10 19:51:27', '2020-04-10 19:47:01', 'admin', '', '', '', '', '', 'text', '0', NULL, NULL, '0');
INSERT INTO `onl_cgform_field` VALUES ('6a30c2e6f01ddd24349da55a37025cc0', 'd35109c3632c4952a19ecc094943dd71', 'top_pic', '头像', NULL, 0, 1, 'String', 500, 0, '', '', '', '', 'image', '', 120, NULL, '0', '', '', 0, 1, 1, 0, 'single', '', '', 11, 'admin', '2020-02-23 18:11:41', '2019-06-10 20:06:56', 'admin', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `onl_cgform_field` VALUES ('6a9072fec215fbd4ae0b2650626d83fc', '4028818371790b3f0171790b43ac0001', 'id', 'ID', 'id', 1, 0, 'string', 36, 0, '', '', '', '', 'text', '', 120, NULL, '0', '', '', 0, 0, 0, 0, 'group', '', '', 1, 'admin', '2020-04-14 23:25:38', '2020-04-14 22:15:14', 'admin', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `onl_cgform_field` VALUES ('6b11a8fa7ffe5dbba24131e222253551', '402881fe72268ef10172268ef3ec0001', 'remark3', '备注3', 'remark3', 0, 1, 'string', 50, 0, '', '', '', '', 'text', '', 120, NULL, '0', '', '', 0, 1, 1, 0, 'single', '', '', 15, 'admin', '2020-05-18 15:55:16', '2020-05-18 14:53:23', 'admin', '', '', '', '', '', NULL, '0', NULL, NULL, '0');
INSERT INTO `onl_cgform_field` VALUES ('6b379369b50936e8f362612cdb02d85c', '40288183712beaa901712beaa9a00000', 'approver_id', '审核人', 'approver_id', 0, 1, 'string', 36, 0, '', 'username', 'sys_user', 'realname', 'list', '', 120, NULL, '0', '', '', 0, 1, 1, 0, 'group', '', '', 16, 'admin', '2020-04-17 12:01:33', '2020-03-30 22:48:52', 'admin', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `onl_cgform_field` VALUES ('6b545aa004c74b6babbc9286b22b0e28', '4028818371790b3f0171790b3f780000', 'create_time', '创建时间', 'create_time', 0, 1, 'Date', 0, 0, '', '', '', '', 'date', '', 120, NULL, '0', '', '', 0, 1, 1, 1, 'group', '', '', 18, 'admin', '2020-04-14 23:41:28', '2020-04-14 22:15:13', 'admin', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `onl_cgform_field` VALUES ('6b6f3aa00b8e73fb785154e795189739', '402860816aa5921f016aa5dedcb90009', 'start_time', '会签发起时间', 'start_time', 0, 1, 'Date', 0, 0, '', '', '', '', 'date', '', 120, NULL, '0', '', '', 0, 1, 1, 0, 'group', '', '', 7, 'admin', '2019-05-11 15:56:47', '2019-05-11 15:50:08', 'admin', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `onl_cgform_field` VALUES ('6c302634737bac8bd255e266036dd4de', '40288183712a997c01712a997c580000', 'remark', '备注', 'remark', 0, 1, 'string', 200, 0, '', '', '', '', 'text', '', 120, NULL, '0', '', '', 0, 1, 1, 0, 'group', '', '', 11, 'admin', '2020-03-30 16:48:20', '2020-03-30 16:40:35', 'admin', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `onl_cgform_field` VALUES ('6cb49ff0cfaf81bf90967040443f6b13', '40288183712a997c01712a997c580000', 'has_rp', '是否有往来', 'has_rp', 0, 1, 'int', 3, 0, '', '', '', '', 'text', '', 120, NULL, '0', '', '', 0, 1, 1, 0, 'group', '', '', 6, 'admin', '2020-03-30 16:48:20', '2020-03-30 16:40:35', 'admin', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `onl_cgform_field` VALUES ('6ccd355bd26bbe583afa19f4ac71f2d5', '40288183712beaa901712c0eb77c0002', 'corporate', '法人代表', 'corporate', 0, 1, 'string', 50, 0, '', '', '', '', 'text', '', 120, NULL, '0', '', '', 0, 1, 0, 0, 'group', '', '', 13, 'admin', '2020-03-31 00:15:25', '2020-03-30 23:28:15', 'admin', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `onl_cgform_field` VALUES ('6cfb5acbbb69782bf0c7043b53f595b2', '402860816bff91c0016bff91cda80003', 'update_by', '更新人', 'update_by', 0, 1, 'string', 100, 0, '', '', '', '', 'text', '', 120, NULL, '0', '', '', 0, 1, 1, 0, 'group', '', '', 11, 'admin', '2019-07-19 18:06:36', '2019-07-17 18:54:34', 'admin', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `onl_cgform_field` VALUES ('6d6f2a34af8fa435ff725cdedf8ca893', '402881fe71c8c4fd0171c8c503230002', 'source_no', '源单号', 'source_no', 0, 1, 'string', 50, 0, '', '', '', '', 'text', '', 120, NULL, '0', '', '', 0, 1, 1, 0, 'group', '', '', 6, 'admin', '2020-04-30 10:30:53', '2020-04-30 09:48:07', 'admin', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `onl_cgform_field` VALUES ('6d7c6a8aecbb8811c04c71070dd40334', '402881fe71c8c4fd0171c8c503230002', 'is_approved', '是否通过', 'is_approved', 0, 1, 'int', 3, 0, '', 'yn', '', '', 'list', '', 120, NULL, '0', '', '', 1, 1, 1, 1, 'single', '', '', 13, 'admin', '2020-04-30 10:30:53', '2020-04-30 09:48:07', 'admin', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `onl_cgform_field` VALUES ('6da9723967dc8d99c42d60c63453f21d', '402881fe71c8c4fd0171c8c503230002', 'flow_id', '流程id', 'flow_id', 0, 1, 'string', 36, 0, '', '', '', '', 'text', '', 120, NULL, '0', '', '', 0, 1, 1, 1, 'group', '', '', 17, 'admin', '2020-04-30 10:30:53', '2020-04-30 09:48:07', 'admin', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `onl_cgform_field` VALUES ('6e4164ac0615f3b2a47561127a6d7fcd', '40288183712beaa901712beaa9a00000', 'supplier_id', '供应商', 'supplier_id', 0, 1, 'string', 36, 0, '', 'id', 'bas_supplier', 'name', 'list', '', 120, NULL, '0', '', '', 1, 1, 1, 0, 'group', '', '', 11, 'admin', '2020-04-17 12:01:33', '2020-03-30 22:48:52', 'admin', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `onl_cgform_field` VALUES ('6e4c47a7956f0a0ee335e28c14b3ca3b', '4028818370f308e90170f308e9080000', 'create_time', '创建时间', 'create_time', 0, 1, 'Date', 0, 0, '', '', '', '', 'date', '', 120, NULL, '0', '', '', 0, 1, 1, 1, 'group', '', '', 12, 'admin', '2020-05-30 11:58:17', '2020-03-19 21:43:33', 'admin', '', '', '', '', '', NULL, '0', NULL, NULL, '0');
INSERT INTO `onl_cgform_field` VALUES ('6e5c9d8e8b7eb6980ec246cb813b180b', '4fb8e12a697f4d5bbe9b9fb1e9009486', 'sys_org_code', '所属部门', NULL, 0, 1, 'string', 64, 0, '', '', '', '', 'text', '', 120, NULL, '0', '', '', 0, 0, 0, 0, 'single', '', '', 10, 'admin', '2020-04-10 19:51:27', '2020-04-10 19:47:01', 'admin', '', '', '', '', '', 'text', '0', NULL, NULL, '0');
INSERT INTO `onl_cgform_field` VALUES ('6e64f353691a332c23c1d3f07a07f7d5', '4028818371790b3f0171795b83bd0003', 'currency_id', '币别', 'currency_id', 0, 0, 'string', 36, 0, '', 'code', 'bas_currency', 'name', 'list', '', 120, NULL, '0', '', '', 0, 1, 1, 0, 'group', '', '', 4, 'admin', '2020-04-14 23:46:44', '2020-04-14 23:42:53', 'admin', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `onl_cgform_field` VALUES ('6e6bd12b13df525e4e9d97ba08e1ad4b', '4028818370e8d46b0170e8d46b4b0000', 'flow_id', '流程id', 'flow_id', 0, 1, 'string', 36, 0, '', '', '', '', 'text', '', 120, NULL, '0', '', '', 0, 1, 1, 0, 'group', '', '', 15, 'admin', '2020-03-19 10:25:32', '2020-03-17 22:10:01', 'admin', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `onl_cgform_field` VALUES ('6f11ca52e399f46042d3cd6ec597372e', '40288183712beaa901712c0ebcb10003', 'is_enabled', '是否启用', 'is_enabled', 0, 1, 'int', 3, 0, '', '', '', '', 'text', '', 120, NULL, '0', '', '', 0, 1, 1, 0, 'group', '', '', 36, 'admin', '2020-03-31 00:04:14', '2020-03-30 23:28:16', 'admin', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `onl_cgform_field` VALUES ('6f1ef548136c66b9864de0ad7d0e14b1', '402881fe72268ef10172268ef3ec0001', 'mid', '主表', 'mid', 0, 0, 'string', 36, 0, '', '', '', '', 'text', '', 120, NULL, '0', '', '', 0, 1, 1, 0, 'single', 'stk_check_bill', 'id', 2, 'admin', '2020-05-18 15:55:15', '2020-05-18 14:53:23', 'admin', '', '', '', '', '', NULL, '0', NULL, NULL, '0');
INSERT INTO `onl_cgform_field` VALUES ('6f68980d67253e8109b2a4a60a626ea2', '402881fe71c8c4fd0171c8c4fdae0000', 'is_voided', '是否作废', 'is_voided', 0, 1, 'int', 3, 0, '', 'yn', '', '', 'list', '', 120, NULL, '0', '', '', 1, 1, 1, 1, 'single', '', '', 14, 'admin', '2020-04-30 10:23:44', '2020-04-30 09:48:06', 'admin', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `onl_cgform_field` VALUES ('6f73e96a659c200c083006b6fce1f043', '402860816bff91c0016bff91ca7e0002', 'cert_name', '证书名称', 'cert_name', 0, 1, 'string', 100, 0, '', '', '', '', 'text', '', 120, NULL, '0', '', '', 0, 1, 1, 0, 'group', '', '', 4, 'admin', '2019-07-19 18:07:13', '2019-07-17 18:54:33', 'admin', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `onl_cgform_field` VALUES ('6f8d4b17ff58d2243e1049f38b155885', '4028818371790b3f0171795b83bd0003', 'update_by', '修改人', 'update_by', 0, 1, 'string', 36, 0, '', 'username', 'sys_user', 'realname', 'list', '', 120, NULL, '0', '', '', 0, 1, 1, 0, 'group', '', '', 14, 'admin', '2020-04-14 23:46:44', '2020-04-14 23:42:53', 'admin', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `onl_cgform_field` VALUES ('701c59da141f3f8206b6de3ca303e80a', '40288183712beaa901712c0ebe7e0004', 'remark', '备注', 'remark', 0, 1, 'string', 200, 0, '', '', '', '', 'text', '', 120, NULL, '0', '', '', 0, 1, 1, 0, 'group', '', '', 8, 'admin', '2020-03-30 23:41:18', '2020-03-30 23:28:16', 'admin', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `onl_cgform_field` VALUES ('70593e44e4a9d550656e258c51dd7005', '4028818370e8d46b0170e8d46b4b0000', 'id', 'ID', 'id', 1, 0, 'string', 36, 0, '', '', '', '', 'text', '', 120, NULL, '0', '', '', 0, 0, 0, 0, 'group', '', '', 1, 'admin', '2020-03-19 10:25:32', '2020-03-17 22:10:00', 'admin', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `onl_cgform_field` VALUES ('706b743a73e9e92f77278d79dfb4bc85', '402881fe72362af70172362afadf0001', 'version', '版本', 'version', 0, 1, 'int', 10, 0, '', '', '', '', 'text', '', 120, NULL, '0', '', '', 0, 0, 0, 0, 'single', '', '', 14, 'admin', '2020-05-21 20:23:41', '2020-05-21 15:38:06', 'admin', '', '', '', '', '', NULL, '0', NULL, NULL, '0');
INSERT INTO `onl_cgform_field` VALUES ('7075c7e52588dad7166f12e333e73a5e', '40288183712beaa901712beaad3c0001', 'settle_amt', '结算金额', 'settle_amt', 0, 1, 'BigDecimal', 18, 2, '', '', '', '', 'text', '', 120, NULL, '0', '', '', 0, 1, 1, 0, 'group', '', '', 20, 'admin', '2020-05-04 21:41:29', '2020-03-30 22:48:53', 'admin', '', '', '', '', '', NULL, '0', NULL, NULL, '0');
INSERT INTO `onl_cgform_field` VALUES ('70788ec96ec3b8d407a585be331f01ca', '40288183712beaa901712c0eb77c0002', 'phone_invoice', '开票信息联系电话', 'phone_invoice', 0, 1, 'string', 50, 0, '', '', '', '', 'text', '', 120, NULL, '0', '', '', 0, 1, 0, 0, 'group', '', '', 22, 'admin', '2020-03-31 00:15:25', '2020-03-30 23:28:15', 'admin', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `onl_cgform_field` VALUES ('70e1a498e92b9824ef632648cf9121be', '40288183712beaa901712c0ebcb10003', 'unit_payment', '办款资料单位名称', 'unit_payment', 0, 1, 'string', 200, 0, '', '', '', '', 'text', '', 120, NULL, '0', '', '', 0, 1, 0, 0, 'group', '', '', 25, 'admin', '2020-03-31 00:04:14', '2020-03-30 23:28:16', 'admin', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `onl_cgform_field` VALUES ('71118d1432ce967a90060177510cf2fc', '402881fe72268ef10172268ef1370000', 'warehouse_id', '仓库', 'warehouse_id', 0, 1, 'string', 36, 0, '', 'id', 'bas_warehouse', 'name', 'list', '', 120, NULL, '0', '', '', 1, 1, 1, 0, 'single', '', '', 4, 'admin', '2020-05-18 15:50:07', '2020-05-18 14:53:22', 'admin', '', '', '', '', '', NULL, '0', NULL, NULL, '0');
INSERT INTO `onl_cgform_field` VALUES ('7137c7ca4a81b873761e58f3fd5d94b6', '402881fe72362af70172362afadf0001', 'bill_no', '单据编号', 'bill_no', 0, 0, 'string', 50, 0, '', '', '', '', 'text', '', 120, NULL, '0', '', '', 0, 1, 1, 0, 'single', '', '', 3, 'admin', '2020-05-21 20:23:41', '2020-05-21 15:38:06', 'admin', '', '', '', '', '', NULL, '0', NULL, NULL, '0');
INSERT INTO `onl_cgform_field` VALUES ('7154c75d754a5f88bef2b68829baf576', '4028318169e81b970169e81b97650000', 'operate_type', '操作类型', 'operate_type', 0, 1, 'string', 10, 0, NULL, NULL, NULL, NULL, 'text', NULL, 120, NULL, '0', NULL, NULL, 0, 1, 1, 0, 'group', NULL, NULL, 4, NULL, NULL, '2019-04-04 19:28:36', 'admin', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `onl_cgform_field` VALUES ('7188d8c8c1a2152349fa0cf55e17af4d', '40288183712a997c01712a997c580000', 'update_by', '修改人', 'update_by', 0, 1, 'string', 36, 0, '', '', '', '', 'text', '', 120, NULL, '0', '', '', 0, 1, 1, 0, 'group', '', '', 21, 'admin', '2020-03-30 16:48:20', '2020-03-30 16:40:35', 'admin', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `onl_cgform_field` VALUES ('71afb00a1971125ecfa13b4dfa49665e', '402860816bff91c0016bff91cfea0004', 'order_no', '序号', 'order_no', 0, 1, 'int', 10, 0, '', '', '', '', 'text', '', 120, NULL, '0', '', '', 0, 1, 1, 0, 'group', '', '', 8, 'admin', '2019-07-19 18:05:13', '2019-07-17 18:54:35', 'admin', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `onl_cgform_field` VALUES ('71d5b0675df5aba71688c9d7d75cccee', '4028318169e81b970169e81b97650000', 'log_type', '日志类型（1登录日志，2操作日志）', 'log_type', 0, 1, 'string', 10, 0, NULL, NULL, NULL, NULL, 'text', NULL, 120, NULL, '0', NULL, NULL, 0, 1, 1, 0, 'group', NULL, NULL, 2, NULL, NULL, '2019-04-04 19:28:36', 'admin', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `onl_cgform_field` VALUES ('71e9ab74dae687837365e50eed090591', '1acb6f81a1d9439da6cc4e868617b565', 'id', '主键', NULL, 1, 0, 'string', 36, 0, '', '', '', '', 'text', '', 120, NULL, '0', '', '', 0, 0, 0, 0, 'single', '', '', 1, 'admin', '2019-06-10 14:47:14', '2019-04-23 22:58:19', 'admin', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `onl_cgform_field` VALUES ('72026450d065f38153c83f8314369f8f', '871c2df1185c4c8e80377d3c319c9a1e', 'create_time', '创建日期', NULL, 0, 1, 'Date', 20, 0, '', '', '', '', 'datetime', '', 120, NULL, '0', '', '', 0, 0, 0, 0, 'single', '', '', 3, NULL, NULL, '2020-03-20 11:42:58', 'admin', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `onl_cgform_field` VALUES ('7280c56a210e6a47794fda855d0c6abb', 'fbc35f067da94a70adb622ddba259352', 'update_by', '更新人', NULL, 0, 1, 'string', 50, 0, '', '', '', '', 'text', '', 120, NULL, '0', '', '', 0, 0, 0, 0, 'single', '', '', 4, NULL, NULL, '2019-07-03 19:44:23', 'admin', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `onl_cgform_field` VALUES ('72e784af5c47bbbc0534b29bf656bd61', '4028839a6de2ebd3016de2ebd3870000', 'id', '主键', 'id', 1, 0, 'string', 36, 0, NULL, NULL, NULL, NULL, 'text', NULL, 120, NULL, '0', NULL, NULL, 0, 0, 0, 0, 'group', NULL, NULL, 1, NULL, NULL, '2019-10-19 15:29:30', 'admin', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `onl_cgform_field` VALUES ('7365f05f551092716223d5d449efd8c7', 'beee191324fd40c1afec4fda18bd9d47', 'name', 'ss', NULL, 0, 1, 'String', 32, 0, '', '', '', '', 'text', '', 120, NULL, '0', '', '', 0, 1, 1, 0, 'single', '', '', 6, 'admin', '2019-04-13 13:41:13', '2019-04-13 13:40:56', 'admin', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `onl_cgform_field` VALUES ('73c6107dccf5977235f382f655790023', '402881fe72268ef10172268ef1370000', 'checker_id', '盘点人', 'checker_id', 0, 1, 'string', 36, 0, '', 'username', 'sys_user', 'realname', 'list', '', 120, NULL, '0', '', '', 1, 1, 1, 0, 'single', '', '', 6, 'admin', '2020-05-18 15:50:07', '2020-05-18 14:53:22', 'admin', '', '', '', '', '', NULL, '0', NULL, NULL, '0');
INSERT INTO `onl_cgform_field` VALUES ('742329ccdb185cf5d3e0b5b0c05dcffa', '402860816bff91c0016bffa220a9000b', 'interest', '兴趣爱好', 'interest', 0, 1, 'string', 255, 0, '', '', '', '', 'text', '', 120, NULL, '0', '', '', 0, 1, 1, 0, 'group', '', '', 34, 'admin', '2019-07-22 16:15:32', '2019-07-17 19:12:24', 'admin', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `onl_cgform_field` VALUES ('744444a7ada3bbb05c6b114b5ba0d477', '402860816aa5921f016aa5dedcb90009', 'id', 'id', 'id', 1, 0, 'string', 36, 0, '', '', '', '', 'text', '', 120, NULL, '0', '', '', 0, 0, 0, 0, 'group', '', '', 1, 'admin', '2019-05-11 15:56:47', '2019-05-11 15:50:08', 'admin', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `onl_cgform_field` VALUES ('74af99545de724a4abd2022581a36026', 'fb7125a344a649b990c12949945cb6c1', 'create_time', '创建日期', NULL, 0, 1, 'Date', 20, 0, '', '', '', '', 'text', '', 120, '', '0', '', '', 0, 0, 0, 0, 'single', '', '', 2, 'admin', '2019-03-26 19:24:11', '2019-03-26 19:01:52', 'admin', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `onl_cgform_field` VALUES ('74afb2cb9e36ab6a6c3a4dafe76654b9', '4028818370e8d46b0170e8d46b4b0000', 'effective_time', '生效时间', 'effective_time', 0, 1, 'Date', 0, 0, '', '', '', '', 'date', '', 120, NULL, '0', '', '', 0, 1, 1, 0, 'group', '', '', 17, 'admin', '2020-03-19 10:25:32', '2020-03-17 22:10:01', 'admin', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `onl_cgform_field` VALUES ('74c0248f929160b2964472590ce130a8', '4028818370f308e90170f330ff050003', 'id', 'ID', 'id', 1, 0, 'string', 36, 0, '', '', '', '', 'text', '', 120, NULL, '0', '', '', 0, 0, 0, 0, 'group', '', '', 1, 'admin', '2020-03-19 22:35:29', '2020-03-19 22:27:20', 'admin', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `onl_cgform_field` VALUES ('75251cfdec1e8f9bcd19c3931a2e1d5e', '40288101717185240171718524d60000', 'supplier_id', '供应商', 'supplier_id', 0, 0, 'string', 36, 0, '', 'id', 'bas_supplier', 'name', 'list', '', 120, NULL, '0', '', '', 0, 1, 1, 0, 'group', '', '', 6, 'admin', '2020-04-13 14:00:53', '2020-04-13 11:11:24', 'admin', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `onl_cgform_field` VALUES ('756b07656386dbd91245f7ffda32ae61', '402860816bff91c0016bff91d8830007', 'id', 'id', 'id', 1, 1, 'string', 32, 0, '', '', '', '', 'text', '', 120, NULL, '0', '', '', 0, 0, 0, 0, 'group', '', '', 1, 'admin', '2019-07-19 18:04:41', '2019-07-17 18:54:37', 'admin', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `onl_cgform_field` VALUES ('75841fa7c75ebdc94655bd5e44fbc9f6', '402860816bff91c0016bffa220a9000b', 'native_place', '籍贯', 'native_place', 0, 1, 'string', 100, 0, '', '', '', '', 'text', '', 120, NULL, '0', '', '', 0, 1, 1, 0, 'group', '', '', 10, 'admin', '2019-07-22 16:15:32', '2019-07-17 19:12:24', 'admin', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `onl_cgform_field` VALUES ('75ba781c67711bed71bba1c3e3c68e11', '8994f2817b5a45d9890aa04497a317c5', 'id', '主键', NULL, 1, 0, 'string', 36, 0, '', '', '', '', 'text', '', 120, '', '0', '', '', 0, 1, 1, 0, 'single', '', '', 0, NULL, NULL, '2019-03-23 11:39:16', 'admin', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `onl_cgform_field` VALUES ('75defd0d54b86acb612dbd3d630fdcfa', '40288183712beaa901712c0ebcb10003', 'attachment_id', '附件', 'attachment_id', 0, 1, 'string', 36, 0, '', '', '', '', 'text', '', 120, NULL, '0', '', '', 0, 1, 0, 0, 'group', '', '', 34, 'admin', '2020-03-31 00:04:14', '2020-03-30 23:28:16', 'admin', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `onl_cgform_field` VALUES ('75e82f151e8cc12455f7f0d25bf4dac0', '4028839a6de2ebd3016de2ebd3870000', 'wl_name', '物料名称', 'wl_name', 0, 1, 'string', 100, 0, NULL, NULL, NULL, NULL, 'text', NULL, 120, NULL, '0', NULL, NULL, 0, 1, 1, 0, 'group', NULL, NULL, 7, NULL, NULL, '2019-10-19 15:29:30', 'admin', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `onl_cgform_field` VALUES ('7639c1bc4327f1f674ffeab2ca261134', '32f75e4043ef4070919dbd4337186a3d', 'update_by', '更新人登录名称', NULL, 0, 1, 'string', 50, 0, '', '', '', '', 'text', '', 120, NULL, '0', '', '', 0, 0, 0, 0, 'single', '', '', 3, 'admin', '2019-04-11 10:15:32', '2019-03-27 15:54:49', 'admin', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `onl_cgform_field` VALUES ('766ca866b72d118f5d8883de46a8c043', '4028839a6de2ebd3016de2ebd3870000', 'supplier', '供应商', 'supplier', 0, 1, 'string', 32, 0, NULL, NULL, NULL, NULL, 'text', NULL, 120, NULL, '0', NULL, NULL, 0, 1, 1, 0, 'group', NULL, NULL, 15, NULL, NULL, '2019-10-19 15:29:30', 'admin', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `onl_cgform_field` VALUES ('767aa31c604c49e6a8e420087d7cd766', '4028818371790b3f0171795b83bd0003', 'id', 'ID', 'id', 1, 0, 'string', 36, 0, '', '', '', '', 'text', '', 120, NULL, '0', '', '', 0, 0, 0, 0, 'group', '', '', 1, 'admin', '2020-04-14 23:46:44', '2020-04-14 23:42:53', 'admin', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `onl_cgform_field` VALUES ('76c59e45141ef5af9a0143c543cb9641', '402881017185937c017185937c100000', 'bill_date', '单据日期', 'bill_date', 0, 0, 'Date', 0, 0, '', '', '', '', 'date', '', 120, NULL, '0', '', '', 1, 1, 1, 0, 'group', '', '', 3, 'admin', '2020-04-17 11:31:14', '2020-04-17 08:39:28', 'admin', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `onl_cgform_field` VALUES ('76ff1632fa2e33de9a5bcfc53791aa2d', '4028818370e8d46b0170e8d46b4b0000', 'create_by', '创建人', 'create_by', 0, 1, 'string', 36, 0, '', '', '', '', 'text', '', 120, NULL, '0', '', '', 0, 1, 1, 0, 'group', '', '', 18, 'admin', '2020-03-19 10:25:32', '2020-03-17 22:10:01', 'admin', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `onl_cgform_field` VALUES ('772fb113414b0caed1224491beff0be9', '4028818370f308e90170f308e9080000', 'model', '规格型号', 'model', 0, 1, 'string', 100, 0, '', '', '', '', 'text', '', 120, NULL, '0', '', '', 0, 1, 1, 0, 'group', '', '', 6, 'admin', '2020-05-30 11:58:17', '2020-03-19 21:43:33', 'admin', '', '', '', '', '', NULL, '0', NULL, NULL, '0');
INSERT INTO `onl_cgform_field` VALUES ('776174746d61b9f5df18434a0938fdf2', '40288183712a997c01712a99809e0001', 'remark3', '备注3', 'remark3', 0, 1, 'string', 50, 0, NULL, NULL, NULL, NULL, 'text', NULL, 120, NULL, '0', NULL, NULL, 0, 1, 1, 0, 'group', NULL, NULL, 24, NULL, NULL, '2020-03-30 16:40:36', 'admin', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `onl_cgform_field` VALUES ('776b0ba0c9f2c00f9a9c142194c0a508', '402881fe724af1fc01724af1fc0c0000', 'begin_year', '启用年度', 'begin_year', 0, 0, 'int', 5, 0, '', '', '', '', 'text', '', 120, NULL, '0', '', '', 0, 1, 1, 0, 'single', '', '', 2, 'admin', '2020-05-25 16:39:51', '2020-05-25 16:27:53', 'admin', '', '', '', '', '', NULL, '0', NULL, NULL, '0');
INSERT INTO `onl_cgform_field` VALUES ('77fd16607d26fce4d66d655146a20d75', 'c20b114d92ed45eab356431a624dd12b', 'id', '主键', NULL, 1, 0, 'string', 36, 0, '', '', '', '', 'text', '', 120, NULL, '0', '', '', 0, 0, 0, 1, 'single', '', '', 1, 'admin', '2020-03-20 11:41:31', '2020-03-20 11:29:28', 'admin', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `onl_cgform_field` VALUES ('77fed3c15ae242b9e3498c70d59e0178', '402881e970dd8d520170dd90f7c30002', 'discount_amt', 'discountAmt', 'discount_amt', 0, 1, 'BigDecimal', 18, 2, '', '', '', '', 'text', '', 120, NULL, '0', '', '', 0, 1, 1, 0, 'group', '', '', 18, 'admin', '2020-03-15 21:40:40', '2020-03-15 17:40:31', 'admin', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `onl_cgform_field` VALUES ('780bc43a7f22de6c95953894f037dd15', '402881fe72268ef10172268ef3ec0001', 'batch_no', '批号', 'batch_no', 0, 0, 'string', 100, 0, '', '', '', '', 'text', '', 120, NULL, '0', '', '', 0, 1, 1, 0, 'single', '', '', 7, 'admin', '2020-05-18 15:55:16', '2020-05-18 14:53:23', 'admin', '', '', '', '', '', NULL, '0', NULL, NULL, '0');
INSERT INTO `onl_cgform_field` VALUES ('78a40344207c791b8d7ac7de721ce1c4', '79091e8277c744158530321513119c68', 'create_time', '创建日期', NULL, 0, 1, 'Date', 20, 0, '', '', '', '', 'datetime', '', 120, NULL, '0', '', '', 0, 0, 0, 0, 'single', '', '', 3, 'admin', '2019-05-11 15:29:47', '2019-05-11 15:27:17', 'admin', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `onl_cgform_field` VALUES ('78c97a514b7f6b2b3e81d6dcf8a5131f', '40288183712a997c01712a997c580000', 'supplier_id', '供应商', 'supplier_id', 0, 1, 'string', 36, 0, '', '', '', '', 'text', '', 120, NULL, '0', '', '', 0, 1, 1, 0, 'group', '', '', 8, 'admin', '2020-03-30 16:48:20', '2020-03-30 16:40:35', 'admin', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `onl_cgform_field` VALUES ('78eb7e3b77cd49f9acb9b024cfe834e1', '402860816aa5921f016aa5dedcb90009', 'create_time', '创建日期', 'create_time', 0, 1, 'Date', 0, 0, '', '', '', '', 'date', '', 120, NULL, '0', '', '', 0, 0, 0, 0, 'group', '', '', 3, 'admin', '2019-05-11 15:56:47', '2019-05-11 15:50:08', 'admin', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `onl_cgform_field` VALUES ('78fd804d93dc716fd8c2ccc45f788565', 'fb7125a344a649b990c12949945cb6c1', 'create_by', '创建人', NULL, 0, 1, 'string', 50, 0, '', '', '', '', 'text', '', 120, '', '0', '', '', 0, 0, 0, 0, 'single', '', '', 1, 'admin', '2019-03-26 19:24:11', '2019-03-26 19:01:52', 'admin', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `onl_cgform_field` VALUES ('790c9f3dba773ed9a6ea3ad627393f57', '402860816bff91c0016bffa220a9000b', 'archives_location', '档案所在地', 'archives_location', 0, 1, 'string', 255, 0, '', '', '', '', 'text', '', 120, NULL, '0', '', '', 0, 1, 1, 0, 'group', '', '', 36, 'admin', '2019-07-22 16:15:32', '2019-07-17 19:12:24', 'admin', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `onl_cgform_field` VALUES ('798625d440d4f5b28a337ef7e16b1ccf', '402881e970dd8d520170ddb3a6490004', 'approved', '核准', 'approved', 0, 1, 'int', 3, 0, '', '', '', '', 'text', '', 120, NULL, '0', '', '', 0, 1, 1, 0, 'group', '', '', 18, 'admin', '2020-03-16 22:39:53', '2020-03-15 18:18:23', 'admin', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `onl_cgform_field` VALUES ('79e6d0ae6cff8942eabdad2ff25ad194', '402881017185937c017185937f430001', 'bill_no', '单据', 'bill_no', 0, 0, 'string', 50, 0, '', '', '', '', 'text', '', 120, NULL, '0', '', '', 0, 1, 1, 1, 'group', '', '', 5, 'admin', '2020-04-18 17:08:51', '2020-04-17 08:39:29', 'admin', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `onl_cgform_field` VALUES ('7a5a33f628ea1ae34a6696dcec0efdbb', '4028818371790b3f0171795b80ed0002', 'code', '代码', 'code', 0, 0, 'string', 20, 0, '', '', '', '', 'text', '', 120, NULL, '0', '', '', 0, 1, 1, 0, 'group', '', '', 2, 'admin', '2020-04-14 23:49:04', '2020-04-14 23:42:53', 'admin', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `onl_cgform_field` VALUES ('7a665ed90ef64b4d65632c941e5795b2', '4b556f0168f64976a3d20bfb932bc798', 'sex', '性别', NULL, 0, 1, 'String', 32, 0, '', '', '', '', 'text', '', 120, NULL, '0', '', '', 0, 1, 1, 0, 'single', '', '', 7, NULL, NULL, '2019-04-12 23:38:29', 'admin', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `onl_cgform_field` VALUES ('7ad23369fd7bff1e26a17b70bdf2204d', '40288183712beaa901712c0eb77c0002', 'corporate_phone', '法人电话', 'corporate_phone', 0, 1, 'string', 50, 0, '', '', '', '', 'text', '', 120, NULL, '0', '', '', 0, 1, 1, 0, 'group', '', '', 14, 'admin', '2020-03-31 00:15:25', '2020-03-30 23:28:15', 'admin', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `onl_cgform_field` VALUES ('7b0db822656451940167d27e9f446b92', '4028818371790b3f0171795b80ed0002', 'create_time', '创建时间', 'create_time', 0, 1, 'Date', 0, 0, '', '', '', '', 'date', '', 120, NULL, '0', '', '', 0, 1, 1, 0, 'group', '', '', 8, 'admin', '2020-04-14 23:49:04', '2020-04-14 23:42:53', 'admin', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `onl_cgform_field` VALUES ('7b4c181e4ebd76022f75535ed6fd9de3', '4adec929a6594108bef5b35ee9966e9f', 'update_time', '更新日期', NULL, 0, 1, 'Date', 20, 0, '', '', '', '', 'datetime', '', 120, NULL, '0', '', '', 0, 0, 0, 0, 'single', '', '', 10, 'admin', '2020-04-10 19:43:38', '2020-04-10 19:35:58', 'admin', '', '', '', '', '', 'text', '0', NULL, NULL, '0');
INSERT INTO `onl_cgform_field` VALUES ('7b5fdb06fbe50c7004703dd41cf1d1e8', '4028818370e8d46b0170e8d46d350001', 'remark3', '备注3', 'remark3', 0, 1, 'string', 50, 0, '', '', '', '', 'text', '', 120, NULL, '0', '', '', 0, 1, 1, 0, 'group', '', '', 24, 'admin', '2020-03-17 22:14:27', '2020-03-17 22:10:01', 'admin', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `onl_cgform_field` VALUES ('7b642d983ac06bfef91edde2c932dbe7', '1acb6f81a1d9439da6cc4e868617b565', 'xg_shangxian', '选购上限', NULL, 0, 1, 'int', 32, 0, '', '', '', '', 'text', '', 120, NULL, '0', '', '', 0, 1, 1, 0, 'single', '', '', 14, 'admin', '2019-06-10 14:47:14', '2019-04-23 22:58:19', 'admin', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `onl_cgform_field` VALUES ('7b849e57debfb889caea5e0fef09062b', 'beee191324fd40c1afec4fda18bd9d47', 'sex2', 'dd', NULL, 0, 1, 'String', 32, 0, '', '', '', '', 'text', '', 120, NULL, '0', '', '', 0, 1, 1, 0, 'single', '', '', 7, 'admin', '2019-04-13 13:41:13', '2019-04-13 13:40:56', 'admin', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `onl_cgform_field` VALUES ('7beb639aa9ffda07edb5ce1e49c2287f', '402860816bff91c0016bff91d2810005', 'update_time', '更新时间', 'update_time', 0, 1, 'Date', 0, 0, '', '', '', '', 'date', '', 120, NULL, '0', '', '', 0, 1, 1, 0, 'group', '', '', 13, 'admin', '2019-07-19 18:05:55', '2019-07-17 18:54:35', 'admin', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `onl_cgform_field` VALUES ('7bf091da401b74d55b107fe9f930ea54', '4028839a6de2ebd3016de2ebd3870000', 'create_by', '创建人', 'create_by', 0, 1, 'string', 50, 0, NULL, NULL, NULL, NULL, 'text', NULL, 120, NULL, '0', NULL, NULL, 0, 1, 1, 0, 'group', NULL, NULL, 2, NULL, NULL, '2019-10-19 15:29:30', 'admin', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `onl_cgform_field` VALUES ('7bfa83f7b395bdc4ff85da41bb5e5257', '402881017185937c0171859381700002', 'bill_no', '单据', 'bill_no', 0, 0, 'string', 50, 0, '', '', '', '', 'text', '', 120, NULL, '0', '', '', 0, 1, 1, 1, 'group', '', '', 5, 'admin', '2020-04-18 17:11:30', '2020-04-17 08:39:29', 'admin', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `onl_cgform_field` VALUES ('7c042e454f676e4e52c1d938376eb4a9', '402881fe724af1fc01724af1feaf0001', 'ytd_credit_amt', '本年累计贷方金额', 'ytd_credit_amt', 0, 1, 'BigDecimal', 18, 2, '', '', '', '', 'text', '', 120, NULL, '0', '', '', 0, 1, 1, 0, 'single', '', '', 11, 'admin', '2020-05-25 16:38:12', '2020-05-25 16:27:53', 'admin', '', '', '', '', '', NULL, '0', NULL, NULL, '0');
INSERT INTO `onl_cgform_field` VALUES ('7c0ed45f3b25c652c4b986d7f75fd3a2', '402881fe71c8c4fd0171c8c4fdae0000', 'rematk', '备注', 'rematk', 0, 1, 'string', 200, 0, '', '', '', '', 'text', '', 120, NULL, '0', '', '', 0, 1, 1, 0, 'group', '', '', 10, 'admin', '2020-04-30 10:23:44', '2020-04-30 09:48:06', 'admin', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `onl_cgform_field` VALUES ('7c6aecc377816c69147f1193b17dfcc5', 'e9faf717024b4aae95cff224ae9b6d97', 'sex', '员工性别', NULL, 0, 1, 'string', 32, 0, '', '', '', '', 'text', '', 120, NULL, '0', '', '', 0, 1, 1, 0, 'single', '', '', 8, 'admin', '2019-07-03 18:23:49', '2019-07-03 18:22:35', 'admin', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `onl_cgform_field` VALUES ('7ca25f854a093401339d484cf46e6b14', '40288183712beaa901712c0eb77c0002', 'customer_level_id', '等级', 'customer_level_id', 0, 1, 'string', 10, 0, '', 'x_customer_level', '', '', 'list', '', 120, NULL, '0', '', '', 0, 1, 1, 0, 'group', '', '', 5, 'admin', '2020-03-31 00:15:25', '2020-03-30 23:28:15', 'admin', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `onl_cgform_field` VALUES ('7cadf4e0be0b173bb5b8d39613e25190', '402860816bff91c0016bffa220a9000b', 'residence_postcode', '户籍邮编', 'residence_postcode', 0, 1, 'string', 10, 0, '', '', '', '', 'text', '', 120, NULL, '0', '', '', 0, 1, 1, 0, 'group', '', '', 29, 'admin', '2019-07-22 16:15:32', '2019-07-17 19:12:24', 'admin', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `onl_cgform_field` VALUES ('7cdbe0d563e15f3fb1fb32d996fe4ba7', '3d447fa919b64f6883a834036c14aa67', 'area', '区', NULL, 0, 1, 'String', 100, 0, '', '', '', '', 'text', '', 120, NULL, '0', '', '', 0, 1, 1, 0, 'single', '', '', 4, 'admin', '2020-02-21 17:58:46', '2020-02-20 16:19:00', 'admin', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `onl_cgform_field` VALUES ('7ce7d6d519a1e435027e7f14bc5939b0', '40288183712a997c01712a997c580000', 'create_by', '创建人', 'create_by', 0, 1, 'string', 36, 0, '', '', '', '', 'text', '', 120, NULL, '0', '', '', 0, 1, 1, 0, 'group', '', '', 19, 'admin', '2020-03-30 16:48:20', '2020-03-30 16:40:35', 'admin', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `onl_cgform_field` VALUES ('7ce9f8e9e67067480bcbbb5aceb3ee73', '40288183712a997c01712a997c580000', 'is_rubric', '是否红字', 'is_rubric', 0, 1, 'int', 3, 0, '', '', '', '', 'text', '', 120, NULL, '0', '', '', 0, 1, 1, 0, 'group', '', '', 7, 'admin', '2020-03-30 16:48:20', '2020-03-30 16:40:35', 'admin', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `onl_cgform_field` VALUES ('7d107728408c21ece332406a21f2d692', '402860816bff91c0016bff91cfea0004', 'update_by', '更新人', 'update_by', 0, 1, 'string', 100, 0, '', '', '', '', 'text', '', 120, NULL, '0', '', '', 0, 1, 1, 0, 'group', '', '', 11, 'admin', '2019-07-19 18:05:13', '2019-07-17 18:54:35', 'admin', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `onl_cgform_field` VALUES ('7d153f345a30778e912dc3151c301f97', '40288183712beaa901712c0eb77c0002', 'update_time', '修改时间', 'update_time', 0, 1, 'Date', 0, 0, '', '', '', '', 'date', '', 120, NULL, '0', '', '', 0, 1, 0, 1, 'group', '', '', 40, 'admin', '2020-03-31 00:15:25', '2020-03-30 23:28:15', 'admin', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `onl_cgform_field` VALUES ('7d486fdbb2a11b525bf8614189570907', '40288183712beaa901712beaa9a00000', 'is_rubric', '是否红字', 'is_rubric', 0, 1, 'int', 3, 0, '', 'yn', '', '', 'list', '', 120, NULL, '0', '', '', 0, 1, 1, 0, 'group', '', '', 10, 'admin', '2020-04-17 12:01:33', '2020-03-30 22:48:52', 'admin', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `onl_cgform_field` VALUES ('7d88d6bfed402e56d04ae5fb123288eb', '40288183712beaa901712beaad3c0001', 'qty', '数量', 'qty', 0, 1, 'BigDecimal', 18, 6, '', '', '', '', 'text', '', 120, NULL, '0', '', '', 0, 1, 1, 0, 'group', '', '', 8, 'admin', '2020-05-04 21:41:29', '2020-03-30 22:48:53', 'admin', '', '', '', '', '', NULL, '0', NULL, NULL, '0');
INSERT INTO `onl_cgform_field` VALUES ('7db825765f7e1358339782f1188c423b', '40288183712beaa901712c0eb77c0002', 'address_invoice', '开票地址', 'address_invoice', 0, 1, 'string', 200, 0, '', '', '', '', 'text', '', 120, NULL, '0', '', '', 0, 1, 0, 0, 'group', '', '', 24, 'admin', '2020-03-31 00:15:25', '2020-03-30 23:28:15', 'admin', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `onl_cgform_field` VALUES ('7df32622dbe39fe26210a2045d34798e', '40288183712beaa901712c0ebcb10003', 'create_time', '创建时间', 'create_time', 0, 1, 'Date', 0, 0, '', '', '', '', 'date', '', 120, NULL, '0', '', '', 0, 1, 0, 1, 'group', '', '', 38, 'admin', '2020-03-31 00:04:14', '2020-03-30 23:28:16', 'admin', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `onl_cgform_field` VALUES ('7dff62d1bc38e68ea568d5175dffd4c5', '40288101710a4c6201710a4c62b50000', 'create_by', '创建人', 'create_by', 0, 1, 'string', 36, 0, '', '', '', '', 'text', '', 120, NULL, '0', '', '', 0, 1, 0, 1, 'group', '', '', 8, 'admin', '2020-03-24 10:18:35', '2020-03-24 10:08:31', 'admin', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `onl_cgform_field` VALUES ('7e066f60680158d47b328ef519d80e49', 'beee191324fd40c1afec4fda18bd9d47', 'create_time', '创建日期', NULL, 0, 1, 'Date', 20, 0, '', '', '', '', 'datetime', '', 120, NULL, '0', '', '', 0, 0, 0, 0, 'single', '', '', 3, 'admin', '2019-04-13 13:41:13', '2019-04-13 13:40:56', 'admin', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `onl_cgform_field` VALUES ('7e1a67d20e31277821103ab6959d398a', '40288101710a4c6201710a60ad5e0001', 'update_time', '修改时间', 'update_time', 0, 1, 'Date', 0, 0, '', '', '', '', 'date', '', 120, NULL, '0', '', '', 0, 1, 1, 1, 'group', '', '', 11, 'admin', '2020-03-28 09:52:10', '2020-03-24 10:30:41', 'admin', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `onl_cgform_field` VALUES ('7eb89d124c447d2784c294f4c1241867', '402881e970dd8d520170ddb3a6490004', 'voided', '0未作废，1作废', 'voided', 0, 1, 'int', 3, 0, '', '', '', '', 'text', '', 120, NULL, '0', '', '', 0, 1, 1, 0, 'group', '', '', 24, 'admin', '2020-03-16 22:39:53', '2020-03-15 18:18:23', 'admin', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `onl_cgform_field` VALUES ('7ed1330266dd4f9e438bbeddb6aaab7d', '40288101710a4c6201710a4c62b50000', 'update_by', '修改人', 'update_by', 0, 1, 'string', 36, 0, '', '', '', '', 'text', '', 120, NULL, '0', '', '', 0, 1, 0, 1, 'group', '', '', 10, 'admin', '2020-03-24 10:18:35', '2020-03-24 10:08:31', 'admin', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `onl_cgform_field` VALUES ('7f10901c6ade3aa9d9ff46ed7039c70f', '1acb6f81a1d9439da6cc4e868617b565', 'create_time', '创建日期', NULL, 0, 1, 'Date', 20, 0, '', '', '', '', 'datetime', '', 120, NULL, '0', '', '', 0, 0, 0, 0, 'single', '', '', 3, 'admin', '2019-06-10 14:47:14', '2019-04-23 22:58:19', 'admin', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `onl_cgform_field` VALUES ('7fc0bcf20daa46e9e7e9a2042f9f2ad6', '402881fe72268ef10172268ef1370000', 'bill_date', '单据日期', 'bill_date', 0, 0, 'Date', 0, 0, '', '', '', '', 'date', '', 120, NULL, '1', '', '', 1, 1, 1, 0, 'group', '', '', 3, 'admin', '2020-05-18 15:50:07', '2020-05-18 14:53:22', 'admin', '', '', '', '', '', NULL, '0', NULL, NULL, '0');
INSERT INTO `onl_cgform_field` VALUES ('7fdacb00d16a5422bf23c03bdaac4d1d', '4028818371790b3f0171790b3f780000', 'effective_time', '生效时间', 'effective_time', 0, 1, 'Date', 0, 0, '', '', '', '', 'date', '', 120, NULL, '0', '', '', 0, 1, 1, 1, 'group', '', '', 15, 'admin', '2020-04-14 23:41:28', '2020-04-14 22:15:13', 'admin', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `onl_cgform_field` VALUES ('80010afef772c5e6f92f21ae38bdf593', '40288101717185240171718524d60000', 'amt', '金额', NULL, 0, 0, 'BigDecimal', 18, 2, '', '', '', '', 'text', '', 120, NULL, '0', '', '', 0, 1, 1, 0, 'single', '', '', 7, 'admin', '2020-04-13 14:00:53', '2020-04-13 11:33:26', 'admin', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `onl_cgform_field` VALUES ('8011fbc84a9bce6618a7b23195770d17', '4028818370f308e90170f308eabf0001', 'pid', '父节点', 'pid', 0, 1, 'string', 36, 0, '', '0', 'bas_material_category', 'id,pid,name,has_child', 'sel_tree', '', 120, NULL, '0', '', '', 0, 1, 0, 0, 'group', '', '', 2, 'admin', '2020-05-29 20:32:59', '2020-03-19 21:43:33', 'admin', '', '', '', '', '', NULL, '0', NULL, NULL, '0');
INSERT INTO `onl_cgform_field` VALUES ('807240074baf0386862916608dde3cbd', '402881fe72362af70172362af7150000', 'is_approved', '是否通过', 'is_approved', 0, 1, 'int', 3, 0, '', 'yn', '', '', 'text', '', 120, NULL, '0', '', '', 1, 1, 1, 0, 'single', '', '', 17, 'admin', '2020-05-21 20:19:56', '2020-05-21 15:38:06', 'admin', '', '', '', '', '', NULL, '0', NULL, NULL, '0');
INSERT INTO `onl_cgform_field` VALUES ('80b8aff1ab58ae5bf7d7bf814c87dce0', '40288183712beaa901712beaad3c0001', 'tax', '税额', 'tax', 0, 1, 'BigDecimal', 18, 2, '', '', '', '', 'text', '', 120, NULL, '0', '', '', 0, 1, 1, 0, 'group', '', '', 17, 'admin', '2020-05-04 21:41:29', '2020-03-30 22:48:53', 'admin', '', '', '', '', '', NULL, '0', NULL, NULL, '0');
INSERT INTO `onl_cgform_field` VALUES ('81ed9556c9fda1bbb46d94a53a6c90c7', '402860816bff91c0016bff91c0cb0000', 'depart_name', '部门名称', 'depart', 0, 1, 'string', 100, 0, '', '', '', '', 'text', '', 120, NULL, '0', '', '', 0, 1, 1, 0, 'group', '', '', 7, 'admin', '2019-07-19 18:09:01', '2019-07-17 18:54:32', 'admin', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `onl_cgform_field` VALUES ('82431d5c0f260f66519b25909b19eafc', '402881fe71c8c4fd0171c8c503230002', 'is_voided', '是否作废', 'is_voided', 0, 1, 'int', 3, 0, '', 'yn', '', '', 'list', '', 120, NULL, '0', '', '', 1, 1, 1, 1, 'single', '', '', 15, 'admin', '2020-04-30 10:30:53', '2020-04-30 09:48:07', 'admin', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `onl_cgform_field` VALUES ('82f3a2b75cb587efeb3973c82ab56754', '402881e970dd8d520170dd90f7c30002', 'material_id', 'materialId', 'material_id', 0, 0, 'string', 36, 0, '', '', '', '', 'text', '', 120, NULL, '0', '', '', 0, 1, 1, 0, 'group', '', '', 5, 'admin', '2020-03-15 21:40:40', '2020-03-15 17:40:31', 'admin', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `onl_cgform_field` VALUES ('8376e1617bcbf52546e6be7e56a1ae39', '4028818370f5f37d0170f865a9e40003', 'v', 'v', 'v', 0, 0, 'int', 10, 0, NULL, NULL, NULL, NULL, 'text', NULL, 120, NULL, '0', NULL, NULL, 0, 1, 1, 0, 'group', NULL, NULL, 2, NULL, NULL, '2020-03-20 22:42:58', 'admin', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `onl_cgform_field` VALUES ('83c645417939f4cdec426a6233c11807', '402881fe71c8c4fd0171c8c503230002', 'is_closed', '是否关闭', 'is_closed', 0, 1, 'int', 3, 0, '', 'yn', '', '', 'list', '', 120, NULL, '0', '', '', 1, 1, 1, 1, 'single', '', '', 14, 'admin', '2020-04-30 10:30:53', '2020-04-30 09:48:07', 'admin', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `onl_cgform_field` VALUES ('8401cd1a09c1bf8371e7828bb85372bc', '40288183712a997c01712a99809e0001', 'unit_id', '计量单位', 'unit_id', 0, 1, 'string', 36, 0, NULL, NULL, NULL, NULL, 'text', NULL, 120, NULL, '0', NULL, NULL, 0, 1, 1, 0, 'group', NULL, NULL, 6, NULL, NULL, '2020-03-30 16:40:36', 'admin', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `onl_cgform_field` VALUES ('8422485e1cbf4455f9ded7d0af59379c', '402860816bff91c0016bff91cfea0004', 'to_time', '截止时间', 'to_time', 0, 1, 'Date', 0, 0, '', '', '', '', 'date', '', 120, NULL, '0', '', '', 0, 1, 1, 0, 'group', '', '', 4, 'admin', '2019-07-19 18:05:13', '2019-07-17 18:54:35', 'admin', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `onl_cgform_field` VALUES ('845c70568d44a074f067d6d277950525', '402860816bff91c0016bffa220a9000b', 'entrytime', '入职时间', 'entrytime', 0, 1, 'Date', 0, 0, '', '', '', '', 'date', '', 120, NULL, '0', '', '', 0, 1, 1, 0, 'group', '', '', 23, 'admin', '2019-07-22 16:15:32', '2019-07-17 19:12:24', 'admin', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `onl_cgform_field` VALUES ('846a496fa852638506b865b57f685cdd', '4028818370e8d46b0170e8d46b4b0000', 'create_time', '创建时间', 'create_time', 0, 1, 'Date', 0, 0, '', '', '', '', 'date', '', 120, NULL, '0', '', '', 0, 1, 1, 0, 'group', '', '', 19, 'admin', '2020-03-19 10:25:32', '2020-03-17 22:10:01', 'admin', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `onl_cgform_field` VALUES ('84a42258a5d31bef29df6c06758077cc', '40288183712beaa901712beaad3c0001', 'remark', '备注', 'remark', 0, 1, 'string', 50, 0, '', '', '', '', 'text', '', 120, NULL, '0', '', '', 0, 1, 1, 0, 'group', '', '', 23, 'admin', '2020-05-04 21:41:29', '2020-03-30 22:48:53', 'admin', '', '', '', '', '', NULL, '0', NULL, NULL, '0');
INSERT INTO `onl_cgform_field` VALUES ('8529ddaed8d5f3d9084e873203d55cac', '402860816bff91c0016bffa220a9000b', 'marital_status', '婚姻状况', 'marital_status', 0, 1, 'string', 20, 0, '', '', '', '', 'text', '', 120, NULL, '0', '', '', 0, 1, 1, 0, 'group', '', '', 24, 'admin', '2019-07-22 16:15:32', '2019-07-17 19:12:24', 'admin', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `onl_cgform_field` VALUES ('857a0daa9cd8a058f2f15fc7c5fb3571', '402860816bff91c0016bffa220a9000b', 'email', '邮箱', 'email', 0, 1, 'string', 255, 0, '', '', '', '', 'text', '', 120, NULL, '0', '', '', 0, 1, 1, 0, 'group', '', '', 17, 'admin', '2019-07-22 16:15:32', '2019-07-17 19:12:24', 'admin', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `onl_cgform_field` VALUES ('857a29a36def8d0ac2e4bcff5c0f6ccd', '402881fe72362af70172362af7150000', 'supplier_id', '供应商', 'supplier_id', 0, 0, 'string', 36, 0, '', 'id', 'bas_supplier', 'name', 'list', '', 120, NULL, '0', '', '', 1, 1, 1, 0, 'single', '', '', 11, 'admin', '2020-05-21 20:19:56', '2020-05-21 15:38:06', 'admin', '', '', '', '', '', NULL, '0', NULL, NULL, '0');
INSERT INTO `onl_cgform_field` VALUES ('85c0558bae080806cac826f7fb17d16b', '402881fe72268ef10172268ef1370000', 'bill_no', '单据编号', 'bill_no', 0, 0, 'string', 50, 0, '', '', '', '', 'text', '', 120, NULL, '1', '', '', 1, 1, 1, 0, 'single', '', '', 2, 'admin', '2020-05-18 15:50:07', '2020-05-18 14:53:22', 'admin', '', '', '', '', '', NULL, '0', NULL, NULL, '0');
INSERT INTO `onl_cgform_field` VALUES ('8652ca69a947fd4c961a3ac7c0fa252a', 'fb19fb067cd841f9ae93d4eb3b883dc0', 'create_by', '创建人登录名称', NULL, 0, 1, 'string', 50, 0, '', '', '', '', 'text', '', 120, '', '0', '', '', 0, 1, 1, 0, 'single', '', '', 1, NULL, NULL, '2019-03-23 11:39:48', 'admin', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `onl_cgform_field` VALUES ('86bbafef5683674a736cf7241c458d44', '27fc5f91274344afa7673a732b279939', 'create_by', '创建人', NULL, 0, 1, 'string', 50, 0, '', '', '', '', 'text', '', 120, NULL, '0', '', '', 0, 0, 0, 0, 'single', '', '', 2, 'admin', '2019-07-01 16:28:20', '2019-07-01 16:26:42', 'admin', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `onl_cgform_field` VALUES ('86e0f3a8f31c60698157f139ed993954', '402860816bff91c0016bffa220a9000b', 'having_reserve_funds', '是否有公积金', 'having_reserve_funds', 0, 1, 'string', 20, 0, '', '', '', '', 'text', '', 120, NULL, '0', '', '', 0, 1, 1, 0, 'group', '', '', 33, 'admin', '2019-07-22 16:15:32', '2019-07-17 19:12:24', 'admin', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `onl_cgform_field` VALUES ('86f1108e5de68114a485751b0e459a55', '4028818371790b3f0171795b80ed0002', 'exchange_rate', '汇率', 'exchange_rate', 0, 1, 'BigDecimal', 18, 10, '', '', '', '', 'text', '', 120, NULL, '0', '', '', 0, 1, 1, 0, 'group', '', '', 5, 'admin', '2020-04-14 23:49:04', '2020-04-14 23:42:53', 'admin', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `onl_cgform_field` VALUES ('8725734b51bc07da7bd1e78b20982504', '402881fe71c8c4fd0171c8c4fdae0000', 'effective_time', '生效时间', 'effective_time', 0, 1, 'Date', 0, 0, '', '', '', '', 'date', '', 120, NULL, '0', '', '', 0, 1, 1, 1, 'group', '', '', 15, 'admin', '2020-04-30 10:23:44', '2020-04-30 09:48:06', 'admin', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `onl_cgform_field` VALUES ('873c8976732520f9e6b1cb8547a7c172', '4028818371790b3f0171790b3f780000', 'update_time', '修改时间', 'update_time', 0, 1, 'Date', 0, 0, '', '', '', '', 'date', '', 120, NULL, '0', '', '', 0, 1, 1, 1, 'group', '', '', 21, 'admin', '2020-04-14 23:41:28', '2020-04-14 22:15:13', 'admin', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `onl_cgform_field` VALUES ('873e2bb041b17bff77d3aca72900ea1b', '56870166aba54ebfacb20ba6c770bd73', 'order_code', '订单编码', NULL, 0, 1, 'String', 32, 0, '', '', '', '', 'text', '', 120, NULL, '0', '', '', 0, 1, 1, 0, 'single', '', '', 6, 'admin', '2019-11-21 17:58:28', '2019-04-20 11:38:39', 'admin', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `onl_cgform_field` VALUES ('877391ae770a4ce2c95181ef410982ce', '4028318169e81b970169e81b97650000', 'request_param', '请求参数', 'request_param', 0, 1, 'string', 255, 0, NULL, NULL, NULL, NULL, 'text', NULL, 120, NULL, '0', NULL, NULL, 0, 1, 1, 0, 'group', NULL, NULL, 10, NULL, NULL, '2019-04-04 19:28:36', 'admin', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `onl_cgform_field` VALUES ('87a664ef73f0d13460d46f1c79dab8ec', '402881017185937c017185937c100000', 'bill_proc_status', '处理状态', 'bill_proc_status', 0, 0, 'string', 4, 0, '', 'x_bill_proc_status', '', '', 'list', '', 120, NULL, '0', '', '', 0, 1, 1, 1, 'group', '', '', 8, 'admin', '2020-04-17 11:31:14', '2020-04-17 08:39:28', 'admin', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `onl_cgform_field` VALUES ('87e82e3c723a6abb020122babdac6bd1', '8994f2817b5a45d9890aa04497a317c5', 'create_by', '创建人登录名称', NULL, 0, 1, 'string', 50, 0, '', '', '', '', 'text', '', 120, '', '0', '', '', 0, 1, 1, 0, 'single', '', '', 1, NULL, NULL, '2019-03-23 11:39:16', 'admin', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `onl_cgform_field` VALUES ('87f7a2703c5850f0b063dd866d0e2917', '402860816bff91c0016bffa220a9000b', 'birthday', '出生日期', 'birthday', 0, 1, 'Date', 0, 0, '', '', '', '', 'date', '', 120, NULL, '0', '', '', 0, 1, 1, 0, 'group', '', '', 7, 'admin', '2019-07-22 16:15:32', '2019-07-17 19:12:24', 'admin', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `onl_cgform_field` VALUES ('87fafe1a4a8a626e3875697574c19f15', '402860816bff91c0016bff91d2810005', 'sys_org_code', '组织机构编码', 'sys_org_code', 0, 1, 'string', 50, 0, '', '', '', '', 'text', '', 120, NULL, '0', '', '', 0, 1, 1, 0, 'group', '', '', 14, 'admin', '2019-07-19 18:05:55', '2019-07-17 18:54:35', 'admin', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `onl_cgform_field` VALUES ('889f4f9138612c9513c3be90879945c1', 'c20b114d92ed45eab356431a624dd12b', 'code', '编码', NULL, 0, 1, 'String', 20, 0, '', '', '', '', 'text', '', 120, NULL, '0', '', '', 0, 1, 1, 0, 'single', '', '', 9, 'admin', '2020-03-20 11:41:31', '2020-03-20 11:29:28', 'admin', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `onl_cgform_field` VALUES ('88a12570e14c9f6f442e731ae5ad0eb1', 'beee191324fd40c1afec4fda18bd9d47', 'update_by', '更新人', NULL, 0, 1, 'string', 50, 0, '', '', '', '', 'text', '', 120, NULL, '0', '', '', 0, 0, 0, 0, 'single', '', '', 4, 'admin', '2019-04-13 13:41:13', '2019-04-13 13:40:56', 'admin', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `onl_cgform_field` VALUES ('88c145165c626c8bc4f051877459d741', '40288183712a997c01712a99809e0001', 'other_cost', '其他成本', 'other_cost', 0, 1, 'BigDecimal', 18, 2, NULL, NULL, NULL, NULL, 'text', NULL, 120, NULL, '0', NULL, NULL, 0, 1, 1, 0, 'group', NULL, NULL, 11, NULL, NULL, '2020-03-30 16:40:36', 'admin', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `onl_cgform_field` VALUES ('88d6abe50becf2fd730037d551b766c3', '40288183712a997c01712a997c580000', 'bill_no', '单据编号', 'bill_no', 0, 0, 'string', 50, 0, '', '', '', '', 'text', '', 120, NULL, '0', '', '', 0, 1, 1, 1, 'group', '', '', 2, 'admin', '2020-03-30 16:48:20', '2020-03-30 16:40:35', 'admin', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `onl_cgform_field` VALUES ('8907e57170d44871fc7e205ae7bdf3bc', '40288183712a997c01712a997c580000', 'customer_id', '客户', 'customer_id', 0, 1, 'string', 36, 0, '', '', '', '', 'text', '', 120, NULL, '0', '', '', 0, 1, 1, 0, 'group', '', '', 9, 'admin', '2020-03-30 16:48:20', '2020-03-30 16:40:35', 'admin', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `onl_cgform_field` VALUES ('89452877ad2df1a19a9056b172154398', '4028818370f308e90170f308eabf0001', 'update_by', '修改人', 'update_by', 0, 1, 'string', 36, 0, '', 'username', 'sys_user', 'realname', 'text', '', 120, NULL, '0', '', '', 0, 1, 1, 0, 'group', '', '', 10, 'admin', '2020-05-29 20:32:59', '2020-03-19 21:43:33', 'admin', '', '', '', '', '', NULL, '0', NULL, NULL, '0');
INSERT INTO `onl_cgform_field` VALUES ('89604a071ecf2f7c18b085ff8ab59c55', '402881fe71c8c4fd0171c8c4fdae0000', 'update_by', '修改人', 'update_by', 0, 1, 'string', 36, 0, '', 'username', 'sys_user', 'realname', 'list', '', 120, NULL, '0', '', '', 0, 1, 1, 1, 'group', '', '', 22, 'admin', '2020-04-30 10:23:44', '2020-04-30 09:48:06', 'admin', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `onl_cgform_field` VALUES ('89a74f3c0b5c5bd7c46ff012b86e63f2', '402881017185937c017185937f430001', 'entry_no', '分录号', 'entry_no', 0, 0, 'int', 10, 0, '', '', '', '', 'text', '', 120, NULL, '0', '', '', 0, 1, 1, 0, 'group', '', '', 3, 'admin', '2020-04-18 17:08:51', '2020-04-17 08:39:29', 'admin', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `onl_cgform_field` VALUES ('89ab9eedbac6141e7a0df6d37a3655d0', 'e67d26b610dd414c884c4dbb24e71ce3', 'update_by', '更新人', NULL, 0, 1, 'string', 50, 0, '', '', '', '', 'text', '', 120, NULL, '0', '', '', 0, 0, 0, 0, 'single', '', '', 4, 'admin', '2019-04-24 11:03:32', '2019-04-24 11:02:57', 'admin', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `onl_cgform_field` VALUES ('89d5af95d7d0f4e939ad210ed44553f4', '402881017185937c017185937c100000', 'version', '版本', 'version', 0, 1, 'int', 10, 0, '', '', '', '', 'text', '', 120, NULL, '0', '', '', 0, 0, 0, 0, 'group', '', '', 20, 'admin', '2020-04-17 11:31:14', '2020-04-17 08:39:28', 'admin', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `onl_cgform_field` VALUES ('89ebea3eda572308fa12f2afbe419365', '40288183712a997c01712a99809e0001', 'mid', '主表', 'mid', 0, 0, 'string', 36, 0, NULL, NULL, NULL, NULL, 'text', NULL, 120, NULL, '0', NULL, NULL, 0, 1, 1, 0, 'group', NULL, NULL, 2, NULL, NULL, '2020-03-30 16:40:36', 'admin', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `onl_cgform_field` VALUES ('8a24fb45e2af120c253c8b61c0085f7a', '402860816bff91c0016bff91cda80003', 'sys_org_code', '组织机构编码', 'sys_org_code', 0, 1, 'string', 50, 0, '', '', '', '', 'text', '', 120, NULL, '0', '', '', 0, 1, 1, 0, 'group', '', '', 13, 'admin', '2019-07-19 18:06:36', '2019-07-17 18:54:34', 'admin', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `onl_cgform_field` VALUES ('8a5917ebe12b2aae762c03703c2f60b0', '402881e970dd8d520170dd90f7c30002', 'master_id', 'masterId', 'master_id', 0, 0, 'string', 36, 0, '', '', '', '', 'text', '', 120, NULL, '0', '', '', 0, 1, 1, 0, 'group', 'stk_io_bill', 'id', 2, 'admin', '2020-03-15 21:40:40', '2020-03-15 17:40:31', 'admin', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `onl_cgform_field` VALUES ('8ac8a0c0087469a4e7579229ff17f273', 'e5464aa8fa7b47c580e91593cf9b46dc', 'jifen', '合计积分', NULL, 0, 1, 'int', 32, 0, '', '', '', '', 'text', '', 120, NULL, '0', '', '', 0, 1, 1, 0, 'single', '', '', 10, 'admin', '2019-04-24 17:09:49', '2019-04-24 11:05:10', 'admin', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `onl_cgform_field` VALUES ('8b015b667fa17b264c1460b8144b251a', '402881e970dd8d520170ddb3a6490004', 'handler_id', 'handlerId', 'handler_id', 0, 1, 'string', 36, 0, '', '', '', '', 'text', '', 120, NULL, '0', '', '', 0, 1, 1, 0, 'group', '', '', 5, 'admin', '2020-03-16 22:39:53', '2020-03-15 18:18:23', 'admin', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `onl_cgform_field` VALUES ('8bd4deadc9e96c1a6d7abd77033105f6', 'e67d26b610dd414c884c4dbb24e71ce3', 'update_time', '更新日期', NULL, 0, 1, 'Date', 20, 0, '', '', '', '', 'datetime', '', 120, NULL, '0', '', '', 0, 0, 0, 0, 'single', '', '', 5, 'admin', '2019-04-24 11:03:32', '2019-04-24 11:02:57', 'admin', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `onl_cgform_field` VALUES ('8c33fe7bda7ca7fd32fcefc672080fa7', '4028818371790b3f0171790b3f780000', 'remark', '备注', 'remark', 0, 1, 'string', 200, 0, '', '', '', '', 'text', '', 120, NULL, '0', '', '', 0, 1, 1, 0, 'group', '', '', 10, 'admin', '2020-04-14 23:41:28', '2020-04-14 22:15:13', 'admin', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `onl_cgform_field` VALUES ('8c6518fec11fc4769ba4eb770c9e00f7', '4028839a6de2ebd3016de2ebd3870000', 'integral_val', '积分值', 'integral_val', 0, 1, 'int', 10, 0, NULL, NULL, NULL, NULL, 'text', NULL, 120, NULL, '0', NULL, NULL, 0, 1, 1, 0, 'group', NULL, NULL, 11, NULL, NULL, '2019-10-19 15:29:30', 'admin', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `onl_cgform_field` VALUES ('8ca56210938fbe649f840e505eb9fd41', '56870166aba54ebfacb20ba6c770bd73', 'create_by', '创建人', NULL, 0, 1, 'string', 50, 0, '', '', '', '', 'text', '', 120, NULL, '0', '', '', 0, 0, 0, 0, 'single', '', '', 2, 'admin', '2019-11-21 17:58:27', '2019-04-20 11:38:39', 'admin', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `onl_cgform_field` VALUES ('8cb7df35b60b8c5e0923e2558575b7ae', '40288183712beaa901712c0eb77c0002', 'phone_receipt', '收件信息联系电话', 'phone_receipt', 0, 1, 'string', 50, 0, '', '', '', '', 'text', '', 120, NULL, '0', '', '', 0, 1, 0, 0, 'group', '', '', 32, 'admin', '2020-03-31 00:15:25', '2020-03-30 23:28:15', 'admin', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `onl_cgform_field` VALUES ('8e080f4ded1e3b2a1daa5b11eca4a0ff', '4adec929a6594108bef5b35ee9966e9f', 'create_by', '创建人', NULL, 0, 1, 'string', 50, 0, '', '', '', '', 'text', '', 120, NULL, '0', '', '', 0, 0, 0, 0, 'single', '', '', 7, 'admin', '2020-04-10 19:43:38', '2020-04-10 19:35:58', 'admin', '', '', '', '', '', 'text', '0', NULL, NULL, '0');
INSERT INTO `onl_cgform_field` VALUES ('8e6908b8ee333122439cd01993da10ad', '40288183712beaa901712c0ebcb10003', 'area', '所属地区', 'area', 0, 1, 'string', 20, 0, '', '', '', '', 'text', '', 120, NULL, '0', '', '', 0, 1, 1, 0, 'group', '', '', 9, 'admin', '2020-03-31 00:04:14', '2020-03-30 23:28:16', 'admin', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `onl_cgform_field` VALUES ('8ea43fd1e4ce82becee61b2f1e2e843f', '32feeb502544416c9bf41329c10a88f4', 'sex', '性别', NULL, 0, 1, 'String', 32, 0, '', 'sex', '', '', 'list', '', 120, NULL, '0', '', '', 0, 1, 1, 0, 'single', '', '', 8, 'admin', '2019-08-23 20:03:40', '2019-07-02 18:23:23', 'admin', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `onl_cgform_field` VALUES ('8ee470fe9e00c42f8cf04722924fac89', '402881fe71c8c4fd0171c8c4fdae0000', 'is_closed', '是否关闭', 'is_closed', 0, 1, 'int', 3, 0, '', 'yn', '', '', 'list', '', 120, NULL, '0', '', '', 1, 1, 1, 1, 'single', '', '', 13, 'admin', '2020-04-30 10:23:44', '2020-04-30 09:48:06', 'admin', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `onl_cgform_field` VALUES ('8f1d302868640b72cef52171a023a203', 'e9faf717024b4aae95cff224ae9b6d97', 'update_by', '更新人', NULL, 0, 1, 'string', 50, 0, '', '', '', '', 'text', '', 120, NULL, '0', '', '', 0, 0, 0, 0, 'single', '', '', 4, 'admin', '2019-07-03 18:23:49', '2019-07-03 18:22:35', 'admin', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `onl_cgform_field` VALUES ('8f3e6fb68179c690f748f3c541fb50f1', '7ea60a25fa27470e9080d6a921aabbd1', 'create_time', '创建日期', NULL, 0, 1, 'Date', 20, 0, '', '', '', '', 'datetime', '', 120, NULL, '0', '', '', 0, 0, 0, 0, 'single', '', '', 3, NULL, NULL, '2019-04-17 00:22:21', 'admin', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `onl_cgform_field` VALUES ('8f693f582293f717b53cafaeb5430c36', '4028818371790b3f0171795b83bd0003', 'create_by', '创建人', 'create_by', 0, 1, 'string', 36, 0, '', 'username', 'sys_user', 'realname', 'list', '', 120, NULL, '0', '', '', 0, 1, 1, 0, 'group', '', '', 12, 'admin', '2020-04-14 23:46:44', '2020-04-14 23:42:53', 'admin', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `onl_cgform_field` VALUES ('8fb6f344a7aa0475abb4311653c387ce', '402881fe724af1fc01724af1fc0c0000', 'id', 'ID', 'id', 1, 0, 'string', 36, 0, '', '', '', '', 'text', '', 120, NULL, '0', '', '', 0, 0, 0, 1, 'single', '', '', 1, 'admin', '2020-05-25 16:39:51', '2020-05-25 16:27:53', 'admin', '', '', '', '', '', NULL, '0', NULL, NULL, '0');
INSERT INTO `onl_cgform_field` VALUES ('8fc0be84bed1216635c69af918e097ff', '402860816aa5921f016aa5dedcb90009', 'name', '并行会签标题', 'name', 0, 1, 'string', 32, 0, '', '', '', '', 'text', '', 120, NULL, '0', '', '', 0, 1, 1, 0, 'group', '', '', 6, 'admin', '2019-05-11 15:56:47', '2019-05-11 15:50:08', 'admin', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `onl_cgform_field` VALUES ('8fe34f9e6692d33ef72f5faea4c19f9d', '402881fe72362af70172362af7150000', 'effective_time', '生效时间', 'effective_time', 0, 1, 'Date', 0, 0, '', '', '', '', 'date', '', 120, NULL, '0', '', '', 0, 1, 1, 0, 'single', '', '', 18, 'admin', '2020-05-21 20:19:56', '2020-05-21 15:38:06', 'admin', '', '', '', '', '', NULL, '0', NULL, NULL, '0');
INSERT INTO `onl_cgform_field` VALUES ('8fed926d805aaf606ee583f1c6e741af', '4028818370e8d46b0170e8d46d350001', 'master_id', '主表', 'master_id', 0, 0, 'string', 36, 0, '', '', '', '', 'text', '', 120, NULL, '0', '', '', 0, 0, 0, 0, 'group', 'stk_io_bill', 'id', 2, 'admin', '2020-03-17 22:14:27', '2020-03-17 22:10:01', 'admin', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `onl_cgform_field` VALUES ('90267640b898bbe0cef70fb61589ce08', '40288183712beaa901712c0eb77c0002', 'bank_payment', '办款资料开户行', 'bank_payment', 0, 1, 'string', 100, 0, '', '', '', '', 'text', '', 120, NULL, '0', '', '', 0, 1, 0, 0, 'group', '', '', 26, 'admin', '2020-03-31 00:15:25', '2020-03-30 23:28:15', 'admin', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `onl_cgform_field` VALUES ('90a822b8a63bbbc1e9575c9f4e21e021', 'd35109c3632c4952a19ecc094943dd71', 'desc2', '描述', NULL, 0, 1, 'string', 500, 0, '', '', '', '', 'textarea', '', 120, '', '0', '', '', 0, 1, 1, 0, 'single', '', '', 8, 'admin', '2020-02-23 18:11:41', '2019-03-15 14:24:35', 'admin', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `onl_cgform_field` VALUES ('90d41858fab98223b61583e2f92e0d3e', '40288101717185240171718524d60000', 'version', '版本', 'version', 0, 1, 'int', 10, 0, '', '', '', '', 'text', '', 120, NULL, '0', '', '', 0, 1, 1, 0, 'group', '', '', 22, 'admin', '2020-04-13 14:00:54', '2020-04-13 11:11:24', 'admin', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `onl_cgform_field` VALUES ('90f39a6e29dae2e1fbb59d7d605f7c09', '1acb6f81a1d9439da6cc4e868617b565', 'iz_valid', '启用状态', NULL, 0, 1, 'String', 2, 0, '', 'air_china_valid', '', '', 'list', '', 120, NULL, '0', '', '', 0, 1, 1, 0, 'single', '', '', 11, 'admin', '2019-06-10 14:47:14', '2019-04-23 22:58:19', 'admin', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `onl_cgform_field` VALUES ('912d55a91d8e0488ba23c2700d7c9b44', '402881fe72268ef10172268ef1370000', 'version', '版本', 'version', 0, 1, 'int', 10, 0, '', '', '', '', 'text', '', 120, NULL, '0', '', '', 0, 0, 0, 0, 'single', '', '', 21, 'admin', '2020-05-18 15:50:07', '2020-05-18 14:53:22', 'admin', '', '', '', '', '', NULL, '0', NULL, NULL, '0');
INSERT INTO `onl_cgform_field` VALUES ('91397936c8f8efb4948c85a8f8a59a97', '402881e970dd8d520170ddb3a6490004', 'has_arp', 'hasArp', 'has_arp', 0, 1, 'int', 3, 0, '', '', '', '', 'radio', '', 120, NULL, '0', '', '', 0, 1, 1, 0, 'group', '', '', 7, 'admin', '2020-03-16 22:39:53', '2020-03-15 18:18:23', 'admin', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `onl_cgform_field` VALUES ('9151baef1ef2fe49f85a0dc387fcc2cb', '402881fe71c8c4fd0171c8c4fdae0000', 'approver_id', '审核人', 'approver_id', 0, 1, 'string', 36, 0, '', 'username', 'sys_user', 'realname', 'list', '', 120, NULL, '0', '', '', 0, 1, 1, 1, 'group', '', '', 16, 'admin', '2020-04-30 10:23:44', '2020-04-30 09:48:06', 'admin', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `onl_cgform_field` VALUES ('91c445ec7a9af8be2065d3f955f0cda0', '40288183712beaa901712c0ebcb10003', 'fax_receipt', '收件信息传真', 'fax_receipt', 0, 1, 'string', 50, 0, '', '', '', '', 'text', '', 120, NULL, '0', '', '', 0, 1, 0, 0, 'group', '', '', 33, 'admin', '2020-03-31 00:04:14', '2020-03-30 23:28:16', 'admin', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `onl_cgform_field` VALUES ('91f7cd9b59c0da033363f8a09b02ec96', '3d447fa919b64f6883a834036c14aa67', 'create_time', '创建日期', NULL, 0, 1, 'Date', 20, 0, '', '', '', '', 'datetime', '', 120, NULL, '0', '', '', 0, 0, 0, 0, 'single', '', '', 5, 'admin', '2020-02-21 17:58:46', '2020-02-20 16:19:00', 'admin', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `onl_cgform_field` VALUES ('92e2f5f4cb0e08e881ef718078cd2c07', '402881fe72362af70172362afadf0001', 'stock_in_entry_id', '入库分录ID', 'stock_in_entry_id', 0, 0, 'string', 36, 0, '', '', '', '', 'text', '', 120, NULL, '0', '', '', 0, 0, 0, 0, 'single', '', '', 5, 'admin', '2020-05-21 20:23:41', '2020-05-21 15:38:06', 'admin', '', '', '', '', '', NULL, '0', NULL, NULL, '0');
INSERT INTO `onl_cgform_field` VALUES ('92ee5b8490cfc063b30c582e033a6c8d', '402881017185937c017185937f430001', 'mid', '主表', 'mid', 0, 0, 'string', 36, 0, '', '', '', '', 'text', '', 120, NULL, '0', '', '', 0, 0, 0, 0, 'group', 'fin_rp_check_target', 'id', 2, 'admin', '2020-04-18 17:08:51', '2020-04-17 08:39:29', 'admin', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `onl_cgform_field` VALUES ('93253f1850b8d0772949dbce53408422', '4028818370e8d46b0170e8d46d350001', 'discount_rate', '折扣率', 'discount_rate', 0, 1, 'BigDecimal', 10, 6, '', '', '', '', 'text', '', 120, NULL, '0', '', '', 0, 1, 1, 0, 'group', '', '', 17, 'admin', '2020-03-17 22:14:27', '2020-03-17 22:10:01', 'admin', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `onl_cgform_field` VALUES ('9341a3b2a734d8c73455c136e1cac8ad', '4fb8e12a697f4d5bbe9b9fb1e9009486', 'update_by', '更新人', NULL, 0, 1, 'string', 50, 0, '', '', '', '', 'text', '', 120, NULL, '0', '', '', 0, 0, 0, 0, 'single', '', '', 8, 'admin', '2020-04-10 19:51:27', '2020-04-10 19:47:01', 'admin', '', '', '', '', '', 'text', '0', NULL, NULL, '0');
INSERT INTO `onl_cgform_field` VALUES ('9370c9304af30b8d29defe0a5ada6e5b', '62e29cdb81ac44d1a2d8ff89851b853d', 'DC_DDSA', 'DD', NULL, 0, 1, 'String', 32, 0, '', '', '', '', 'text', '', 120, NULL, '0', '', '', 0, 1, 1, 0, 'single', '', '', 6, NULL, NULL, '2019-05-11 14:01:14', 'admin', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `onl_cgform_field` VALUES ('9371f61d39c5d57ddb0a2db96b2e2412', '402860816bff91c0016bffa220a9000b', 'speciality', '专业', 'speciality', 0, 1, 'string', 100, 0, '', '', '', '', 'text', '', 120, NULL, '0', '', '', 0, 1, 1, 0, 'group', '', '', 15, 'admin', '2019-07-22 16:15:32', '2019-07-17 19:12:24', 'admin', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `onl_cgform_field` VALUES ('941b28c8698bccf349619f25f0228efe', '4028818371790b3f0171795b83bd0003', 'attachment', '附件', 'attachment', 0, 1, 'string', 500, 0, '', '', '', '', 'file', '', 120, NULL, '0', '', '', 0, 1, 1, 0, 'group', '', '', 10, 'admin', '2020-04-14 23:46:44', '2020-04-14 23:42:53', 'admin', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `onl_cgform_field` VALUES ('94465e55dd8e1ed0c600d478d7f0c05c', '402881fe71c8c4fd0171c8c500d30001', 'bill_no', '单据编号', 'bill_no', 0, 0, 'string', 50, 0, '', '', '', '', 'text', '', 120, NULL, '0', '', '', 0, 1, 1, 1, 'group', '', '', 3, 'admin', '2020-04-30 10:30:11', '2020-04-30 09:48:07', 'admin', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `onl_cgform_field` VALUES ('944d601959d7fbefe25c1c18795a974e', '402881fe71c8c4fd0171c8c503230002', 'create_by', '创建人', 'create_by', 0, 1, 'string', 36, 0, '', 'username', 'sys_user', 'realname', 'list', '', 120, NULL, '0', '', '', 0, 1, 1, 1, 'group', '', '', 20, 'admin', '2020-04-30 10:30:53', '2020-04-30 09:48:07', 'admin', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `onl_cgform_field` VALUES ('947174892512ea97fafde899d427ea7e', '402860816bff91c0016bff91c0cb0000', 'real_name', '姓名', 'real_name', 0, 1, 'string', 100, 0, '', '', '', '', 'text', '', 120, NULL, '0', '', '', 0, 1, 1, 0, 'group', '', '', 4, 'admin', '2019-07-19 18:09:01', '2019-07-17 18:54:32', 'admin', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `onl_cgform_field` VALUES ('94b8bf435175cc545366e11992280757', '32f75e4043ef4070919dbd4337186a3d', 'age', '年龄', NULL, 0, 1, 'int', 32, 0, '', '', '', '', 'text', '', 120, NULL, '0', '', '', 1, 1, 1, 0, 'group', '', '', 7, 'admin', '2019-04-11 10:15:32', '2019-03-27 15:54:49', 'admin', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `onl_cgform_field` VALUES ('94e682cb802777fe4205536888f69353', '402860816bff91c0016bff91d2810005', 'create_by', '创建人', 'create_by', 0, 1, 'string', 100, 0, '', '', '', '', 'text', '', 120, NULL, '0', '', '', 0, 1, 1, 0, 'group', '', '', 10, 'admin', '2019-07-19 18:05:55', '2019-07-17 18:54:35', 'admin', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `onl_cgform_field` VALUES ('94ec65156538a84221aae16972efcaaa', '402881fe724af1fc01724af1fc0c0000', 'cur_month', '当前月度', 'cur_month', 0, 0, 'int', 3, 0, '', '', '', '', 'text', '', 120, NULL, '0', '', '', 0, 1, 1, 0, 'single', '', '', 5, 'admin', '2020-05-25 16:39:51', '2020-05-25 16:27:53', 'admin', '', '', '', '', '', NULL, '0', NULL, NULL, '0');
INSERT INTO `onl_cgform_field` VALUES ('94f29fa59069846629fcc2b9d52865b2', '402881fe71c8c4fd0171c8c503230002', 'create_time', '创建时间', 'create_time', 0, 1, 'Date', 0, 0, '', '', '', '', 'date', '', 120, NULL, '0', '', '', 0, 1, 1, 1, 'group', '', '', 21, 'admin', '2020-04-30 10:30:53', '2020-04-30 09:48:07', 'admin', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `onl_cgform_field` VALUES ('951c51699d728072d88196d30f7aad10', '4adec929a6594108bef5b35ee9966e9f', 'address', '地址', NULL, 0, 1, 'String', 200, 0, '', '', '', '', 'text', '', 120, NULL, '0', '', '{{ demoFieldDefVal_getAddress() }}', 0, 1, 1, 0, 'single', '', '', 5, 'admin', '2020-04-10 19:43:38', '2020-04-10 19:35:58', 'admin', '', '', '', '', '', NULL, '0', NULL, NULL, '0');
INSERT INTO `onl_cgform_field` VALUES ('95310d8f179c195fb831f6a030c652a0', '4028818370e8d46b0170e8d46b4b0000', 'has_rp', '是否产生往来', 'has_rp', 0, 1, 'int', 3, 0, '', '', '', '', 'text', '', 120, NULL, '0', '', '', 0, 0, 0, 0, 'group', '', '', 7, 'admin', '2020-03-19 10:25:32', '2020-03-17 22:10:01', 'admin', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `onl_cgform_field` VALUES ('955eee4d0c39e1e10dfb61abade7139a', '40288183712beaa901712beaa9a00000', 'remark', '备注', 'remark', 0, 1, 'string', 200, 0, '', '', '', '', 'text', '', 120, NULL, '0', '', '', 0, 1, 1, 0, 'group', '', '', 14, 'admin', '2020-04-17 12:01:33', '2020-03-30 22:48:52', 'admin', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `onl_cgform_field` VALUES ('957386b500be42a200d6a56d54345392', 'deea5a8ec619460c9245ba85dbc59e80', 'num', '数量', NULL, 0, 1, 'int', 32, 0, '', '', '', '', 'text', '', 120, 'n', '0', '', '', 0, 1, 1, 0, 'single', '', '', 8, 'admin', '2020-03-15 17:37:15', '2019-04-20 11:41:19', 'admin', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `onl_cgform_field` VALUES ('95cbe7183b1c9fa76931b5abed11dffb', '4028818370e8d46b0170e8d46d350001', 'tax_rate', '税率', 'tax_rate', 0, 1, 'BigDecimal', 6, 4, '', '', '', '', 'text', '', 120, NULL, '0', '', '', 0, 1, 1, 0, 'group', '', '', 15, 'admin', '2020-03-17 22:14:27', '2020-03-17 22:10:01', 'admin', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `onl_cgform_field` VALUES ('960d2847922b61dadeb3518ef55fb0c1', '1acb6f81a1d9439da6cc4e868617b565', 'wl_name', '物料名称', NULL, 0, 1, 'String', 100, 0, '', '', '', '', 'text', '', 120, NULL, '0', '', '', 0, 1, 1, 0, 'single', '', '', 7, 'admin', '2019-06-10 14:47:14', '2019-04-23 22:58:19', 'admin', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `onl_cgform_field` VALUES ('963cb1c092b904bd55a9b15581efa3fa', '4028818370f308e90170f308e9080000', 'create_by', '创建人', 'create_by', 0, 1, 'string', 36, 0, '', 'username', 'sys_user', 'realname', 'text', '', 120, NULL, '0', '', '', 0, 1, 1, 1, 'group', '', '', 11, 'admin', '2020-05-30 11:58:17', '2020-03-19 21:43:33', 'admin', '', '', '', '', '', NULL, '0', NULL, NULL, '0');
INSERT INTO `onl_cgform_field` VALUES ('964dcf90a8a2534f2fde6293249fcc26', '40288183712beaa901712c0ebcb10003', 'update_by', '修改人', 'update_by', 0, 1, 'string', 36, 0, '', '', '', '', 'text', '', 120, NULL, '0', '', '', 0, 1, 0, 1, 'group', '', '', 39, 'admin', '2020-03-31 00:04:14', '2020-03-30 23:28:16', 'admin', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `onl_cgform_field` VALUES ('9665f02764774fdd77c19923d3ff3c3e', '4028318169e81b970169e81b97650000', 'cost_time', '耗时', 'cost_time', 0, 1, 'string', 19, 0, NULL, NULL, NULL, NULL, 'text', NULL, 120, NULL, '0', NULL, NULL, 0, 1, 1, 0, 'group', NULL, NULL, 12, NULL, NULL, '2019-04-04 19:28:36', 'admin', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `onl_cgform_field` VALUES ('966a4988298d5cb0be47848735ce8cb7', '4028839a6de2ebd3016de2ebd3870000', 'xg_shangxian', '选购上限', 'xg_shangxian', 0, 1, 'int', 10, 0, NULL, NULL, NULL, NULL, 'text', NULL, 120, NULL, '0', NULL, NULL, 0, 1, 1, 0, 'group', NULL, NULL, 12, NULL, NULL, '2019-10-19 15:29:30', 'admin', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `onl_cgform_field` VALUES ('96c585a4f71e5c38ed25b9741366365b', '402860816bff91c0016bff91c7010001', 'sys_org_code', '组织机构编码', 'sys_org_code', 0, 1, 'string', 50, 0, '', '', '', '', 'text', '', 120, NULL, '0', '', '', 0, 1, 1, 0, 'group', '', '', 11, 'admin', '2019-07-19 18:07:47', '2019-07-17 18:54:32', 'admin', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `onl_cgform_field` VALUES ('96eae93276db56c99f236b46a56e917f', '4028818371790b3f0171790b3f780000', 'attachment', '附件', 'attachment', 0, 1, 'string', 500, 0, '', '', '', '', 'file', '', 120, NULL, '0', '', '', 0, 1, 1, 1, 'group', '', '', 9, 'admin', '2020-04-14 23:41:28', '2020-04-14 22:15:13', 'admin', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `onl_cgform_field` VALUES ('9765efa2cafde6d0ede2215848c9e80b', '32f75e4043ef4070919dbd4337186a3d', 'id', '主键', NULL, 1, 0, 'string', 36, 0, '', '', '', '', 'text', '', 120, NULL, '0', '', '', 0, 1, 1, 0, 'single', '', '', 0, 'admin', '2019-04-11 10:15:32', '2019-03-27 15:54:49', 'admin', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `onl_cgform_field` VALUES ('97b8efee9268fd7d81e5a9f90e76aade', '402881fe72268ef10172268ef3ec0001', 'bill_no', '单据编号', 'bill_no', 0, 1, 'string', 50, 0, '', '', '', '', 'text', '', 120, NULL, '0', '', '', 0, 0, 0, 0, 'single', '', '', 3, 'admin', '2020-05-18 15:55:15', '2020-05-18 14:53:23', 'admin', '', '', '', '', '', NULL, '0', NULL, NULL, '0');
INSERT INTO `onl_cgform_field` VALUES ('97d36898178ab2dade413b11829beddb', '40288183712beaa901712beaa9a00000', 'update_time', '修改时间', 'update_time', 0, 1, 'Date', 0, 0, '', '', '', '', 'date', '', 120, NULL, '0', '', '', 0, 1, 1, 1, 'group', '', '', 26, 'admin', '2020-04-17 12:01:33', '2020-03-30 22:48:52', 'admin', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `onl_cgform_field` VALUES ('97fd67b1e3f8d900633660f0cc83c31b', '40288183712beaa901712c0eb77c0002', 'short_name', '简称', 'short_name', 0, 1, 'string', 50, 0, '', '', '', '', 'text', '', 120, NULL, '0', '', '', 0, 1, 1, 0, 'group', '', '', 4, 'admin', '2020-03-31 00:15:25', '2020-03-30 23:28:15', 'admin', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `onl_cgform_field` VALUES ('98e82cb1595609a3b42fa75c60ac1229', '402860816bff91c0016bff91d2810005', 'update_by', '更新人', 'update_by', 0, 1, 'string', 100, 0, '', '', '', '', 'text', '', 120, NULL, '0', '', '', 0, 1, 1, 0, 'group', '', '', 12, 'admin', '2019-07-19 18:05:55', '2019-07-17 18:54:35', 'admin', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `onl_cgform_field` VALUES ('98fb4459d92c9ad0680e2dc99987a228', '40288101710a4c6201710a4c62b50000', 'is_enabled', '是否启用', 'is_enabled', 0, 0, 'int', 3, 0, '', 'yn', '', '', 'list', '', 120, NULL, '0', '', '', 0, 1, 1, 0, 'group', '', '', 7, 'admin', '2020-03-24 10:18:35', '2020-03-24 10:08:31', 'admin', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `onl_cgform_field` VALUES ('9914a0c84805e72c4b6075e36edb13f9', '402860816aa5921f016aa5921f480000', 'create_time', '创建时间', 'create_time', 0, 1, 'Date', 0, 0, '', '', '', '', 'date', '', 120, NULL, '0', '', '', 0, 0, 0, 0, 'group', '', '', 9, 'admin', '2019-05-11 15:31:54', '2019-05-11 14:26:19', 'admin', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `onl_cgform_field` VALUES ('9920bba4c4c837456bca71334c8b9117', '4028818370e8d46b0170e8d46b4b0000', 'entry_count', '分录数量', 'entry_count', 0, 1, 'int', 5, 0, '', '', '', '', 'text', '', 120, NULL, '0', '', '', 0, 1, 1, 0, 'group', '', '', 11, 'admin', '2020-03-19 10:25:32', '2020-03-17 22:10:01', 'admin', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `onl_cgform_field` VALUES ('9920ecec9c9109fc6b93e86f8fdfa03b', '402860816bff91c0016bffa220a9000b', 'depart_name', '所在部门', 'depart_name', 0, 1, 'string', 100, 0, '', '', '', '', 'text', '', 120, NULL, '0', '', '', 1, 1, 1, 0, 'group', '', '', 2, 'admin', '2019-07-22 16:15:32', '2019-07-17 19:12:24', 'admin', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `onl_cgform_field` VALUES ('996617e8b865ccf518cd812d16321c18', '40288183712a997c01712a99809e0001', 'remark2', '备注2', 'remark2', 0, 1, 'string', 50, 0, NULL, NULL, NULL, NULL, 'text', NULL, 120, NULL, '0', NULL, NULL, 0, 1, 1, 0, 'group', NULL, NULL, 23, NULL, NULL, '2020-03-30 16:40:36', 'admin', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `onl_cgform_field` VALUES ('99a1109a62cf5a345bcba12be728d009', '4028818370e8d46b0170e8d46d350001', 'invocied_qty', '已开票数量', 'invocied_qty', 0, 1, 'BigDecimal', 18, 6, '', '', '', '', 'text', '', 120, NULL, '0', '', '', 0, 1, 1, 0, 'group', '', '', 20, 'admin', '2020-03-17 22:14:27', '2020-03-17 22:10:01', 'admin', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `onl_cgform_field` VALUES ('99a210835e77579aa3f47fc7b1b27909', '40288183712beaa901712c0eb77c0002', 'version', '版本', 'version', 0, 1, 'int', 10, 0, '', '', '', '', 'text', '', 120, NULL, '0', '', '', 0, 0, 0, 0, 'group', '', '', 41, 'admin', '2020-03-31 00:15:25', '2020-03-30 23:28:15', 'admin', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `onl_cgform_field` VALUES ('99b43bbb23237815ebb74b12b4d7ea2f', '62e29cdb81ac44d1a2d8ff89851b853d', 'id', '主键', NULL, 1, 0, 'string', 36, 0, '', '', '', '', 'text', '', 120, NULL, '0', '', '', 0, 0, 0, 0, 'single', '', '', 1, NULL, NULL, '2019-05-11 14:01:14', 'admin', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `onl_cgform_field` VALUES ('9a090446c03af15a66dd4e4e7d0e6a5d', '402881fe72362af70172362af7150000', 'is_auto', '是否自动生成', 'is_auto', 0, 0, 'int', 3, 0, '', 'yn', '', '', 'list', '', 120, NULL, '0', '', '', 0, 1, 1, 0, 'single', '', '', 4, 'admin', '2020-05-21 20:19:56', '2020-05-21 15:38:06', 'admin', '', '', '', '', '', NULL, '0', NULL, NULL, '0');
INSERT INTO `onl_cgform_field` VALUES ('9a4341ce1a7a169c6e2b297e2928524c', '40288183712beaa901712beaad3c0001', 'invocied_amt', '已开票金额', 'invocied_amt', 0, 1, 'BigDecimal', 18, 2, '', '', '', '', 'text', '', 120, NULL, '0', '', '', 0, 1, 1, 1, 'group', '', '', 22, 'admin', '2020-05-04 21:41:29', '2020-03-30 22:48:53', 'admin', '', '', '', '', '', NULL, '0', NULL, NULL, '0');
INSERT INTO `onl_cgform_field` VALUES ('9a579c506f75f75baf88352a5eb2c249', '1acb6f81a1d9439da6cc4e868617b565', 'bpm_status', '流程状态', NULL, 0, 1, 'String', 2, 0, '1', 'bpm_status', '', '', 'list', '', 120, NULL, '0', '', '', 0, 0, 1, 0, 'single', '', '', 16, 'admin', '2019-06-10 14:47:14', '2019-05-07 16:54:43', 'admin', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `onl_cgform_field` VALUES ('9b0abede7a90bf6a57f09a873398ac96', '4028818370e8d46b0170e8d46d350001', 'remark2', '备注2', 'remark2', 0, 1, 'string', 50, 0, '', '', '', '', 'text', '', 120, NULL, '0', '', '', 0, 1, 1, 0, 'group', '', '', 23, 'admin', '2020-03-17 22:14:27', '2020-03-17 22:10:01', 'admin', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `onl_cgform_field` VALUES ('9b213797d54102f23fbc87a1bbe178e4', '4028818370f308e90170f330ff050003', 'factor', '系数', 'factor', 0, 1, 'BigDecimal', 18, 6, '', '', '', '', 'text', '', 120, NULL, '0', '', '', 0, 1, 1, 0, 'group', '', '', 4, 'admin', '2020-03-19 22:35:29', '2020-03-19 22:27:20', 'admin', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `onl_cgform_field` VALUES ('9b8b741f29c5a0cf73418488f47f2d7c', '402881017185937c017185937c100000', 'id', 'ID', 'id', 1, 0, 'string', 36, 0, '', '', '', '', 'text', '', 120, NULL, '0', '', '', 0, 0, 0, 0, 'group', '', '', 1, 'admin', '2020-04-17 11:31:14', '2020-04-17 08:39:28', 'admin', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `onl_cgform_field` VALUES ('9bb53b4eaa08785c038d8c20648e61ff', '402881fe724af1fc01724af1feaf0001', 'supplier_id', '供应商', 'supplier_id', 0, 1, 'string', 36, 0, '', 'id', 'bas_supplier', 'name', 'list', '', 120, NULL, '0', '', '', 1, 1, 1, 0, 'single', '', '', 6, 'admin', '2020-05-25 16:38:12', '2020-05-25 16:27:53', 'admin', '', '', '', '', '', NULL, '0', NULL, NULL, '0');
INSERT INTO `onl_cgform_field` VALUES ('9bd056786694d67666f6924cc225b1a0', '3d447fa919b64f6883a834036c14aa67', 'id', '主键', NULL, 1, 0, 'string', 36, 0, '', '', '', '', 'text', '', 120, NULL, '0', '', '', 0, 0, 0, 0, 'single', '', '', 1, 'admin', '2020-02-21 17:58:46', '2020-02-20 16:19:00', 'admin', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `onl_cgform_field` VALUES ('9c2340f82711f8a38ec74386e0afb1c3', '40288101710a4c6201710a4c62b50000', 'factor', '系数', 'factor', 0, 1, 'BigDecimal', 18, 6, '', '', '', '', 'text', '', 120, NULL, '0', '', '', 0, 1, 1, 0, 'group', '', '', 4, 'admin', '2020-03-24 10:18:35', '2020-03-24 10:08:31', 'admin', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `onl_cgform_field` VALUES ('9c24028a2c0a17c59d06421ddfe853e0', '402881fe71c8c4fd0171c8c500d30001', 'settle_method', '结算方式', 'settle_method', 0, 1, 'string', 10, 0, '', 'x_settle_method', '', '', 'list', '', 120, NULL, '0', '', '', 0, 1, 1, 0, 'group', '', '', 8, 'admin', '2020-04-30 10:30:11', '2020-04-30 09:48:07', 'admin', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `onl_cgform_field` VALUES ('9c40fb4db8afed3c682c6b8a732fd69d', 'e2faf977fdaf4b25a524f58c2441a51c', 'post', '用户岗位', NULL, 0, 1, 'String', 32, 0, '', 'post_code', 'air_china_post_materiel_main', 'post_name', 'sel_search', '', 120, NULL, '0', '', '', 0, 1, 1, 0, 'single', '', '', 8, 'admin', '2019-06-10 17:27:00', '2019-04-24 17:12:11', 'admin', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `onl_cgform_field` VALUES ('9c69ddd25fa0c28799f6306b3c3d4304', '40288183712a997c01712a99809e0001', 'discount_rate', '折扣率', 'discount_rate', 0, 1, 'BigDecimal', 10, 6, NULL, NULL, NULL, NULL, 'text', NULL, 120, NULL, '0', NULL, NULL, 0, 1, 1, 0, 'group', NULL, NULL, 17, NULL, NULL, '2020-03-30 16:40:36', 'admin', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `onl_cgform_field` VALUES ('9c886ef8c468dee330414f6a29458a00', '40288183712beaa901712c0ebe7e0004', 'pid', '父级', 'pid', 0, 1, 'string', 36, 0, '', '0', 'bas_warehouse', 'id,pid,name,has_child', 'sel_tree', '', 120, NULL, '0', '', '', 0, 1, 0, 0, 'group', '', '', 2, 'admin', '2020-03-30 23:41:18', '2020-03-30 23:28:16', 'admin', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `onl_cgform_field` VALUES ('9ceff249ef81ca6fa145456667c89051', '4adec929a6594108bef5b35ee9966e9f', 'create_time', '创建日期', NULL, 0, 1, 'Date', 20, 0, '', '', '', '', 'datetime', '', 120, NULL, '0', '', '', 0, 0, 0, 0, 'single', '', '', 8, 'admin', '2020-04-10 19:43:38', '2020-04-10 19:35:58', 'admin', '', '', '', '', '', 'text', '0', NULL, NULL, '0');
INSERT INTO `onl_cgform_field` VALUES ('9d0d3cea84d4ab078b673732b8d1358e', '402881ea71684fa00171684fa0680000', 'unit_id', '计量单位', 'unit_id', 0, 1, 'string', 36, 0, '', 'id', 'bas_measure_unit', 'name', 'list', '', 120, NULL, '0', '', '', 0, 1, 1, 1, 'group', '', '', 5, 'admin', '2020-04-11 16:28:45', '2020-04-11 16:16:22', 'admin', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `onl_cgform_field` VALUES ('9d28891f10327f5efaeea84fee583240', '4028818370f5f37d0170f5f37dcf0000', 'create_time', '创建时间', 'create_time', 0, 1, 'Date', 0, 0, '', '', '', '', 'date', '', 120, NULL, '0', '', '', 0, 1, 1, 0, 'group', '', '', 10, 'admin', '2020-03-20 12:02:35', '2020-03-20 11:19:01', 'admin', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `onl_cgform_field` VALUES ('9d85bafa399f28a40e1de1eeef747223', '4028318169e81b970169e81b97650000', 'ip', 'IP', 'ip', 0, 1, 'string', 100, 0, NULL, NULL, NULL, NULL, 'text', NULL, 120, NULL, '0', NULL, NULL, 0, 1, 1, 0, 'group', NULL, NULL, 7, NULL, NULL, '2019-04-04 19:28:36', 'admin', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `onl_cgform_field` VALUES ('9d89ff1a019f41d80307652041490944', '32feeb502544416c9bf41329c10a88f4', 'name', '请假人', NULL, 0, 1, 'String', 32, 0, '', '', '', '', 'text', '', 120, NULL, '0', '', '', 0, 1, 1, 0, 'single', '', '', 7, 'admin', '2019-08-23 20:03:40', '2019-07-02 18:23:23', 'admin', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `onl_cgform_field` VALUES ('9da39ca81ed139ac2457bfde72bdbc0f', '40288183712beaa901712beaa9a00000', 'bill_status', '单据状态', 'bill_status', 0, 1, 'string', 4, 0, '', 'x_bill_status', '', '', 'list', '', 120, NULL, '0', '', '', 0, 1, 1, 1, 'group', '', '', 15, 'admin', '2020-04-17 12:01:33', '2020-03-30 22:48:52', 'admin', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `onl_cgform_field` VALUES ('9e0210a838b2afd3a3049b66fe071222', '402881fe724af1fc01724af1feaf0001', 'debit_amt', '借方金额', 'debit_amt', 0, 1, 'BigDecimal', 18, 2, '', '', '', '', 'text', '', 120, NULL, '0', '', '', 0, 1, 1, 0, 'single', '', '', 8, 'admin', '2020-05-25 16:38:12', '2020-05-25 16:27:53', 'admin', '', '', '', '', '', NULL, '0', NULL, NULL, '0');
INSERT INTO `onl_cgform_field` VALUES ('9e50680eb4e79b3af352a5933d239dff', 'dbf4675875e14676a3f9a8b2b8941140', 'id', '主键', NULL, 1, 0, 'string', 36, 0, '', '', '', '', 'text', '', 120, NULL, '0', '', '', 0, 0, 0, 0, 'single', '', '', 1, NULL, NULL, '2019-05-27 18:02:07', 'admin', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `onl_cgform_field` VALUES ('9e5397f13f9706956f3102f5a975377b', '40288101717185240171718524d60000', 'create_time', '创建时间', 'create_time', 0, 1, 'Date', 0, 0, '', '', '', '', 'date', '', 120, NULL, '0', '', '', 0, 1, 1, 0, 'group', '', '', 19, 'admin', '2020-04-13 14:00:53', '2020-04-13 11:11:24', 'admin', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `onl_cgform_field` VALUES ('9e8e7bf3958b04fc9ce3407a7ce96b1a', '4028818371790b3f0171790b3f780000', 'unchecked_amt', '待核销金额', 'unchecked_amt', 0, 0, 'BigDecimal', 18, 2, '', '', '', '', 'text', '', 120, NULL, '0', '', '', 0, 1, 1, 1, 'group', '', '', 8, 'admin', '2020-04-14 23:41:28', '2020-04-14 22:15:13', 'admin', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `onl_cgform_field` VALUES ('9eab19b59401ff85bff4c9169553b299', '4028818370e8d46b0170e8d46b4b0000', 'handler_id', '经办人', 'handler_id', 0, 1, 'string', 36, 0, '', '', '', '', 'sel_user', '', 120, NULL, '0', '', '', 0, 1, 1, 0, 'group', '', '', 5, 'admin', '2020-03-19 10:25:32', '2020-03-17 22:10:00', 'admin', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `onl_cgform_field` VALUES ('9f24eac81e82792c1ab15cc87502e41d', '402881e970dd8d520170ddb3a6490004', 'remark', 'remark', 'remark', 0, 1, 'string', 200, 0, '', '', '', '', 'text', '', 120, NULL, '0', '', '', 0, 1, 1, 0, 'group', '', '', 13, 'admin', '2020-03-16 22:39:53', '2020-03-15 18:18:23', 'admin', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `onl_cgform_field` VALUES ('9f29b0f1205d7a74e85f5969a48aee98', '4028818370e8d46b0170e8d46d350001', 'batch_no', '批次号', 'batch_no', 0, 1, 'string', 100, 0, '', '', '', '', 'text', '', 120, NULL, '0', '', '', 0, 1, 1, 0, 'group', '', '', 9, 'admin', '2020-03-17 22:14:27', '2020-03-17 22:10:01', 'admin', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `onl_cgform_field` VALUES ('9f2e30b040fd711308de5e44ec3845b4', '4028818370e8d46b0170e8d46d350001', 'other_cost', '其他成本', 'other_cost', 0, 1, 'BigDecimal', 18, 2, '', '', '', '', 'text', '', 120, NULL, '0', '', '', 0, 1, 1, 0, 'group', '', '', 11, 'admin', '2020-03-17 22:14:27', '2020-03-17 22:10:01', 'admin', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `onl_cgform_field` VALUES ('9f407b5332257e00156f37e1b86652d5', '402881017185937c0171859381700002', 'mid', '主表', 'mid', 0, 0, 'string', 36, 0, '', '', '', '', 'text', '', 120, NULL, '0', '', '', 0, 0, 0, 0, 'group', '', '', 2, 'admin', '2020-04-18 17:11:30', '2020-04-17 08:39:29', 'admin', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `onl_cgform_field` VALUES ('9fade53cfd1bcf2c6a01c9586d096587', '40288183712beaa901712c0ebcb10003', 'headquarters', '所属总公司', 'headquarters', 0, 1, 'string', 100, 0, '', '', '', '', 'text', '', 120, NULL, '0', '', '', 0, 1, 1, 0, 'group', '', '', 8, 'admin', '2020-03-31 00:04:14', '2020-03-30 23:28:16', 'admin', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `onl_cgform_field` VALUES ('a01a7fe5660206e6f407ed98b6c732d6', '402860816bff91c0016bff91cfea0004', 'phone', '联系方式', 'phone', 0, 1, 'string', 20, 0, '', '', '', '', 'text', '', 120, NULL, '0', '', '', 0, 1, 1, 0, 'group', '', '', 7, 'admin', '2019-07-19 18:05:13', '2019-07-17 18:54:35', 'admin', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `onl_cgform_field` VALUES ('a04ef9b2f5b18b77510dee967fc5e373', '4028818370f308e90170f308e9080000', 'update_by', '修改人', 'update_by', 0, 1, 'string', 36, 0, '', 'username', 'sys_user', 'realname', 'text', '', 120, NULL, '0', '', '', 0, 1, 1, 1, 'group', '', '', 13, 'admin', '2020-05-30 11:58:17', '2020-03-19 21:43:33', 'admin', '', '', '', '', '', NULL, '0', NULL, NULL, '0');
INSERT INTO `onl_cgform_field` VALUES ('a072d3e1853831f213d82d96707f269f', '4028818370e8d46b0170e8d46d350001', 'tax_inclusive', '成本是否含税', 'tax_inclusive', 0, 1, 'int', 3, 0, '', '', '', '', 'text', '', 120, NULL, '0', '', '', 0, 1, 1, 0, 'group', '', '', 12, 'admin', '2020-03-17 22:14:27', '2020-03-17 22:10:01', 'admin', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `onl_cgform_field` VALUES ('a07e1269c37d804a097dc185164457c2', '402881fe72362af70172362af7150000', 'is_voided', '是否作废', 'is_voided', 0, 0, 'int', 3, 0, '', 'yn', '', '', 'list', '', 120, NULL, '0', '', '', 0, 1, 1, 0, 'single', '', '', 19, 'admin', '2020-05-21 20:19:56', '2020-05-21 15:38:06', 'admin', '', '', '', '', '', NULL, '0', NULL, NULL, '0');
INSERT INTO `onl_cgform_field` VALUES ('a0c7f3087ce45511d22b84513a1c8f7f', '40288183712beaa901712c0ebcb10003', 'bank_payment', '办款资料开户行', 'bank_payment', 0, 1, 'string', 100, 0, '', '', '', '', 'text', '', 120, NULL, '0', '', '', 0, 1, 0, 0, 'group', '', '', 26, 'admin', '2020-03-31 00:04:14', '2020-03-30 23:28:16', 'admin', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `onl_cgform_field` VALUES ('a0cd44511441a068dfe9f17941e86853', '40288183712beaa901712c0eb77c0002', 'create_time', '创建时间', 'create_time', 0, 1, 'Date', 0, 0, '', '', '', '', 'date', '', 120, NULL, '0', '', '', 0, 1, 0, 1, 'group', '', '', 38, 'admin', '2020-03-31 00:15:25', '2020-03-30 23:28:15', 'admin', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `onl_cgform_field` VALUES ('a10b8c2d2bdee83aa322cc9ac0403860', 'c20b114d92ed45eab356431a624dd12b', 'sys_org_code', '所属部门', NULL, 0, 1, 'string', 64, 0, '', '', '', '', 'text', '', 120, NULL, '0', '', '', 0, 0, 0, 0, 'single', '', '', 6, 'admin', '2020-03-20 11:41:31', '2020-03-20 11:29:28', 'admin', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `onl_cgform_field` VALUES ('a1d96a14c49440ec494e0cc8402b77ea', '40288183712beaa901712c0eb77c0002', 'area', '所属地区', 'area', 0, 1, 'string', 20, 0, '', '', '', '', 'text', '', 120, NULL, '0', '', '', 0, 1, 0, 0, 'group', '', '', 10, 'admin', '2020-03-31 00:15:25', '2020-03-30 23:28:15', 'admin', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `onl_cgform_field` VALUES ('a1dc77312e57d59bfe9506ae3e83711d', '40288183712beaa901712c0ebcb10003', 'supplier_category', '供应商分类', 'supplier_category', 0, 1, 'string', 10, 0, '', '', '', '', 'text', '', 120, NULL, '0', '', '', 0, 0, 0, 0, 'group', '', '', 7, 'admin', '2020-03-31 00:04:14', '2020-03-30 23:28:16', 'admin', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `onl_cgform_field` VALUES ('a1f5daba36f536e7acf6a939826183b0', 'fb19fb067cd841f9ae93d4eb3b883dc0', 'id', '主键', NULL, 1, 0, 'string', 36, 0, '', '', '', '', 'text', '', 120, '', '0', '', '', 0, 1, 1, 0, 'single', '', '', 0, NULL, NULL, '2019-03-23 11:39:48', 'admin', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `onl_cgform_field` VALUES ('a20831509a1394729a5bceb28bea1d16', '402881fe72362af70172362afadf0001', 'invoice_qty', '发票数量', 'invoice_qty', 0, 0, 'BigDecimal', 18, 6, '', '', '', '', 'text', '', 120, NULL, '0', '', '', 0, 1, 1, 0, 'single', '', '', 9, 'admin', '2020-05-21 20:23:41', '2020-05-21 15:38:06', 'admin', '', '', '', '', '', NULL, '0', NULL, NULL, '0');
INSERT INTO `onl_cgform_field` VALUES ('a23de02f0103f678219889f70c344321', '402881e970dd8d520170dd90f7c30002', 'settle_price', 'settlePrice', 'settle_price', 0, 1, 'BigDecimal', 18, 6, '', '', '', '', 'text', '', 120, NULL, '0', '', '', 0, 1, 1, 0, 'group', '', '', 14, 'admin', '2020-03-15 21:40:40', '2020-03-15 17:40:31', 'admin', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `onl_cgform_field` VALUES ('a33327606b84247f4899da8067edb86b', '402881e970dd8d520170ddb3a6490004', 'create_time', 'createTime', 'create_time', 0, 1, 'Date', 0, 0, '', '', '', '', 'date', '', 120, NULL, '0', '', '', 0, 1, 1, 0, 'group', '', '', 21, 'admin', '2020-03-16 22:39:53', '2020-03-15 18:18:23', 'admin', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `onl_cgform_field` VALUES ('a34135b23e227fb3913b441951f95b12', '40288101717185240171718524d60000', 'approver_id', '审核人', 'approver_id', 0, 1, 'string', 36, 0, '', 'username', 'sys_user', 'realname', 'list', '', 120, NULL, '0', '', '', 0, 1, 1, 0, 'group', '', '', 10, 'admin', '2020-04-13 14:00:53', '2020-04-13 11:11:24', 'admin', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `onl_cgform_field` VALUES ('a356f1e5ff62c199d88041f0b52fa057', '402881fe72362af70172362af7150000', 'remark', '备注', 'remark', 0, 1, 'string', 200, 0, '', '', '', '', 'text', '', 120, NULL, '0', '', '', 0, 1, 1, 0, 'single', '', '', 13, 'admin', '2020-05-21 20:19:56', '2020-05-21 15:38:06', 'admin', '', '', '', '', '', NULL, '0', NULL, NULL, '0');
INSERT INTO `onl_cgform_field` VALUES ('a35cab3bb2010d09b24b22a250445f1f', '402881fe72362af70172362afadf0001', 'id', 'ID', 'id', 1, 0, 'string', 36, 0, '', '', '', '', 'text', '', 120, NULL, '0', '', '', 0, 0, 0, 1, 'single', '', '', 1, 'admin', '2020-05-21 20:23:41', '2020-05-21 15:38:06', 'admin', '', '', '', '', '', NULL, '0', NULL, NULL, '0');
INSERT INTO `onl_cgform_field` VALUES ('a3cbb728487732ab9f34e7e780e17f29', '402881fe71c8c4fd0171c8c503230002', 'effective_time', '生效时间', 'effective_time', 0, 1, 'Date', 0, 0, '', '', '', '', 'date', '', 120, NULL, '0', '', '', 0, 1, 1, 1, 'group', '', '', 18, 'admin', '2020-04-30 10:30:53', '2020-04-30 09:48:07', 'admin', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `onl_cgform_field` VALUES ('a4111e791f1a92a2ead0226218d54e99', '402881017185937c017185937c100000', 'rp_check_type', '核销类型', 'rp_check_type', 0, 0, 'string', 10, 0, '', 'x_rp_check_type', '', '', 'list', '', 120, NULL, '0', '', '', 0, 1, 1, 1, 'group', '', '', 4, 'admin', '2020-04-17 11:31:14', '2020-04-17 08:39:28', 'admin', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `onl_cgform_field` VALUES ('a45eba33810c485b9d8e6f70818a1dfa', '402860816aa5921f016aa5921f480000', 'bpm_status', '流程状态', 'bpm_status', 0, 1, 'string', 50, 0, '1', 'bpm_status', '', '', 'text', '', 120, NULL, '0', '', '', 0, 0, 1, 0, 'group', '', '', 7, 'admin', '2019-05-11 15:31:54', '2019-05-11 14:26:19', 'admin', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `onl_cgform_field` VALUES ('a491de880de63c42b9ea1d2e2598f7b0', '402881fe72362af70172362afadf0001', 'invoice_date', '开票日期', 'invoice_date', 0, 1, 'Date', 0, 0, '', '', '', '', 'date', '', 120, NULL, '0', '', '', 0, 1, 1, 0, 'single', '', '', 8, 'admin', '2020-05-21 20:23:41', '2020-05-21 15:38:06', 'admin', '', '', '', '', '', NULL, '0', NULL, NULL, '0');
INSERT INTO `onl_cgform_field` VALUES ('a5a584e0d1af2f7419d3684dbb420b06', '40288183712a997c01712a99809e0001', 'entry_no', '分录号', 'entry_no', 0, 0, 'int', 10, 0, NULL, NULL, NULL, NULL, 'text', NULL, 120, NULL, '0', NULL, NULL, 0, 1, 1, 0, 'group', NULL, NULL, 4, NULL, NULL, '2020-03-30 16:40:36', 'admin', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `onl_cgform_field` VALUES ('a61c2d5cfd14162463f1f16b5caf27d6', '40288101710a4c6201710a60ad5e0001', 'is_enabled', '是否启用', 'is_enabled', 0, 0, 'int', 3, 0, '1', 'yn', '', '', 'list', '', 50, NULL, '0', '', '', 0, 1, 1, 0, 'group', '', '', 7, 'admin', '2020-03-28 09:52:10', '2020-03-24 10:30:41', 'admin', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `onl_cgform_field` VALUES ('a6471d4fb3dbffef01dab1f7d452bb30', '27fc5f91274344afa7673a732b279939', 'update_time', '更新日期', NULL, 0, 1, 'Date', 20, 0, '', '', '', '', 'datetime', '', 120, NULL, '0', '', '', 0, 0, 0, 0, 'single', '', '', 5, 'admin', '2019-07-01 16:28:20', '2019-07-01 16:26:42', 'admin', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `onl_cgform_field` VALUES ('a6722b498602d7d7b5177b16789d8cc1', 'e5464aa8fa7b47c580e91593cf9b46dc', 'create_by', '创建人', NULL, 0, 1, 'string', 50, 0, '', '', '', '', 'text', '', 120, NULL, '0', '', '', 0, 0, 0, 0, 'single', '', '', 2, 'admin', '2019-04-24 17:09:48', '2019-04-24 11:05:10', 'admin', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `onl_cgform_field` VALUES ('a67cf7543e573f2ebd0a42d7f0636f64', '402881fe72362af70172362af7150000', 'update_time', '修改时间', 'update_time', 0, 1, 'Date', 0, 0, '', '', '', '', 'date', '', 120, NULL, '0', '', '', 0, 1, 1, 0, 'single', '', '', 25, 'admin', '2020-05-21 20:19:56', '2020-05-21 15:38:06', 'admin', '', '', '', '', '', NULL, '0', NULL, NULL, '0');
INSERT INTO `onl_cgform_field` VALUES ('a6ba306ddb830b7f7db79c8a754ce0cc', '402881fe71c8c4fd0171c8c503230002', 'bill_proc_status', '处理状态', 'bill_proc_status', 0, 0, 'string', 4, 0, '', 'x_bill_proc_status', '', '', 'list', '', 120, NULL, '0', '', '', 0, 1, 1, 1, 'group', '', '', 12, 'admin', '2020-04-30 10:30:53', '2020-04-30 09:48:07', 'admin', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `onl_cgform_field` VALUES ('a76f561057ac9e43a8ca09e478a1eab8', '402860816bff91c0016bff91ca7e0002', 'update_time', '更新时间', 'update_time', 0, 1, 'Date', 0, 0, '', '', '', '', 'date', '', 120, NULL, '0', '', '', 0, 1, 1, 0, 'group', '', '', 12, 'admin', '2019-07-19 18:07:13', '2019-07-17 18:54:33', 'admin', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `onl_cgform_field` VALUES ('a7822f6e4cffb37fc0729cbd4cfd8655', '32f75e4043ef4070919dbd4337186a3d', 'name', '用户名', NULL, 0, 1, 'String', 32, 0, '', '', '', '', 'text', '', 120, NULL, '0', '', '', 1, 1, 1, 0, 'single', '', '', 5, 'admin', '2019-04-11 10:15:32', '2019-03-27 15:54:49', 'admin', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `onl_cgform_field` VALUES ('a7ea367880322814c10067470d8c16b5', '402881fe72268ef10172268ef1370000', 'is_closed', '是否关闭', 'is_closed', 0, 0, 'int', 3, 0, '', 'yn', '', '', 'list', '', 120, NULL, '0', '', '', 0, 1, 1, 0, 'single', '', '', 15, 'admin', '2020-05-18 15:50:07', '2020-05-18 14:53:22', 'admin', '', '', '', '', '', NULL, '0', NULL, NULL, '0');
INSERT INTO `onl_cgform_field` VALUES ('a801b165e4f8473a623569838566e052', '402881fe72268ef10172268ef1370000', 'create_by', '创建人', 'create_by', 0, 1, 'string', 36, 0, '', 'username', 'sys_user', 'realname', 'list', '', 120, NULL, '0', '', '', 0, 1, 1, 0, 'single', '', '', 17, 'admin', '2020-05-18 15:50:07', '2020-05-18 14:53:22', 'admin', '', '', '', '', '', NULL, '0', NULL, NULL, '0');
INSERT INTO `onl_cgform_field` VALUES ('a81346afe2904de21a94e58b67346ccc', '4028818371790b3f0171790b43ac0001', 'entry_no', '分录号', 'entry_no', 0, 0, 'int', 10, 0, '', '', '', '', 'text', '', 120, NULL, '0', '', '', 0, 1, 1, 0, 'group', '', '', 4, 'admin', '2020-04-14 23:25:38', '2020-04-14 22:15:14', 'admin', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `onl_cgform_field` VALUES ('a821faeca96e1e8160190be42708d73d', '4028818370e8d46b0170e8d46d350001', 'discount_amt', '折让金额', 'discount_amt', 0, 1, 'BigDecimal', 18, 2, '', '', '', '', 'text', '', 120, NULL, '0', '', '', 0, 1, 1, 0, 'group', '', '', 18, 'admin', '2020-03-17 22:14:27', '2020-03-17 22:10:01', 'admin', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `onl_cgform_field` VALUES ('a82ca42a76e9d2b8dae6d57dbb5edb54', 'deea5a8ec619460c9245ba85dbc59e80', 'update_by', '更新人2', NULL, 0, 1, 'string', 50, 0, '', '', '', '', 'text', '', 120, NULL, '0', '', '', 0, 0, 0, 0, 'single', '', '', 4, 'admin', '2020-03-15 17:37:15', '2019-04-20 11:41:19', 'admin', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `onl_cgform_field` VALUES ('a83d0da7f9bc7461273d7fdc192c0d24', '40288183712a997c01712a997c580000', 'version', '版本', 'version', 0, 1, 'int', 10, 0, '', '', '', '', 'text', '', 120, NULL, '0', '', '', 0, 1, 1, 0, 'group', '', '', 23, 'admin', '2020-03-30 16:48:20', '2020-03-30 16:40:35', 'admin', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `onl_cgform_field` VALUES ('a866618058dfa8e56b7a6c740fb6d3af', '4028818371790b3f0171795b80ed0002', 'update_by', '修改人', 'update_by', 0, 1, 'string', 36, 0, '', 'username', 'sys_user', 'realname', 'list', '', 120, NULL, '0', '', '', 0, 1, 1, 0, 'group', '', '', 9, 'admin', '2020-04-14 23:49:05', '2020-04-14 23:42:53', 'admin', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `onl_cgform_field` VALUES ('a8b9c22e6d26cb3a2fc045feb4ee45be', '4028818370e8d46b0170e8d46b4b0000', 'update_by', '修改人', 'update_by', 0, 1, 'string', 36, 0, '', '', '', '', 'text', '', 120, NULL, '0', '', '', 0, 1, 1, 0, 'group', '', '', 20, 'admin', '2020-03-19 10:25:32', '2020-03-17 22:10:01', 'admin', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `onl_cgform_field` VALUES ('a8d46131c6d597ae287bd0a1f27bf389', '4028818370f308e90170f308e9080000', 'is_enabled', '是否启用', 'is_enabled', 0, 0, 'int', 3, 0, '1', 'yn', '', '', 'list', '', 120, NULL, '0', '', '', 0, 1, 1, 0, 'group', '', '', 5, 'admin', '2020-05-30 11:58:17', '2020-03-19 21:43:33', 'admin', '', '', '', '', '', NULL, '0', NULL, NULL, '0');
INSERT INTO `onl_cgform_field` VALUES ('a93b4d48a310372f1722093197c68363', '40288101717185240171718524d60000', 'create_by', '创建人', 'create_by', 0, 1, 'string', 36, 0, '', 'username', 'sys_user', 'realname', 'list', '', 120, NULL, '0', '', '', 0, 1, 1, 0, 'group', '', '', 18, 'admin', '2020-04-13 14:00:53', '2020-04-13 11:11:24', 'admin', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `onl_cgform_field` VALUES ('a940adc4585fa3b5bd2114ea9abe8491', '402860816bff91c0016bff91ca7e0002', 'cert_level', '证书级别', 'cert_level', 0, 1, 'string', 100, 0, '', '', '', '', 'text', '', 120, NULL, '0', '', '', 0, 1, 1, 0, 'group', '', '', 5, 'admin', '2019-07-19 18:07:13', '2019-07-17 18:54:33', 'admin', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `onl_cgform_field` VALUES ('a94f1d7da64f3aa35c32155ea00ccb2f', '402860816bff91c0016bffa220a9000b', 'id', 'id', 'id', 1, 1, 'string', 32, 0, '', '', '', '', 'text', '', 120, NULL, '0', '', '', 0, 0, 0, 0, 'group', '', '', 1, 'admin', '2019-07-22 16:15:32', '2019-07-17 19:12:24', 'admin', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `onl_cgform_field` VALUES ('a96f5d45ac1cd75ca54173bddb7d8757', '402881fe72268ef10172268ef3ec0001', 'entry_no', '分录号', 'entry_no', 0, 0, 'int', 10, 0, '', '', '', '', 'text', '', 120, NULL, '0', '', '', 0, 1, 1, 0, 'single', '', '', 4, 'admin', '2020-05-18 15:55:16', '2020-05-18 14:53:23', 'admin', '', '', '', '', '', NULL, '0', NULL, NULL, '0');
INSERT INTO `onl_cgform_field` VALUES ('a9780eace237a15f26931dd6a9ec02e9', '758334cb1e7445e2822b60e807aec4a3', 'create_time', '创建日期', NULL, 0, 1, 'Date', 20, 0, '', '', '', '', 'datetime', '', 120, NULL, '0', '', '', 0, 0, 0, 0, 'single', '', '', 3, NULL, NULL, '2019-10-18 18:02:09', 'admin', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `onl_cgform_field` VALUES ('a9c5385f5995cb0caa4694b42627871f', '40288183712beaa901712c0ebcb10003', 'alter_supplier', '备选供应商', 'alter_supplier', 0, 1, 'string', 200, 0, '', '', '', '', 'text', '', 120, NULL, '0', '', '', 0, 1, 0, 0, 'group', '', '', 11, 'admin', '2020-03-31 00:04:14', '2020-03-30 23:28:16', 'admin', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `onl_cgform_field` VALUES ('aa07931514727913413880b7a2b76dcb', 'd3ae1c692b9640e0a091f8c46e17bb01', 'create_time', '创建日期', NULL, 0, 1, 'Date', 20, 0, '', '', '', '', 'datetime', '', 120, NULL, '0', '', '', 0, 0, 0, 0, 'single', '', '', 3, NULL, NULL, '2019-07-24 14:47:30', 'admin', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `onl_cgform_field` VALUES ('aa14a619481e7a270d486a95e22612a7', '40288183712beaa901712beaa9a00000', 'is_closed', '是否关闭', 'is_closed', 0, 1, 'int', 3, 0, '0', 'yn', '', '', 'list', '', 120, NULL, '0', '', '', 0, 1, 1, 1, 'group', '', '', 21, 'admin', '2020-04-17 12:01:33', '2020-03-30 22:48:52', 'admin', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `onl_cgform_field` VALUES ('aa4780601419c21dabb6c42fc511e71c', '402860816bff91c0016bffa220a9000b', 'have_children', '有无子女', 'have_children', 0, 1, 'string', 20, 0, '', '', '', '', 'text', '', 120, NULL, '0', '', '', 0, 1, 1, 0, 'group', '', '', 25, 'admin', '2019-07-22 16:15:32', '2019-07-17 19:12:24', 'admin', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `onl_cgform_field` VALUES ('aa9d2d597634faabc33007a5da11dbd4', '4028818371790b3f0171790b3f780000', 'supplier_id', '供应商', 'supplier_id', 0, 0, 'string', 36, 0, '', 'id', 'bas_supplier', 'name', 'list', '', 120, NULL, '0', '', '', 0, 1, 1, 0, 'group', '', '', 5, 'admin', '2020-04-14 23:41:28', '2020-04-14 22:15:13', 'admin', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `onl_cgform_field` VALUES ('aaab0a1bd77bdea9c9dc3fc98bcea21c', '4028818370f308e90170f308eabf0001', 'create_by', '创建人', 'create_by', 0, 1, 'string', 36, 0, '', 'username', 'sys_user', 'realname', 'text', '', 120, NULL, '0', '', '', 0, 1, 1, 0, 'group', '', '', 8, 'admin', '2020-05-29 20:32:59', '2020-03-19 21:43:33', 'admin', '', '', '', '', '', NULL, '0', NULL, NULL, '0');
INSERT INTO `onl_cgform_field` VALUES ('aad6796844261373ed96c61577f68f2f', '40288183712beaa901712c0ebe7e0004', 'id', 'ID', 'id', 1, 0, 'string', 36, 0, '', '', '', '', 'text', '', 120, NULL, '0', '', '', 0, 0, 0, 0, 'group', '', '', 1, 'admin', '2020-03-30 23:41:18', '2020-03-30 23:28:16', 'admin', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `onl_cgform_field` VALUES ('ab10e0aa029ded2f4420a33420de225d', '1acb6f81a1d9439da6cc4e868617b565', 'wl_code', '物料编码', NULL, 0, 1, 'String', 60, 0, '', '', '', '', 'text', '', 120, NULL, '0', '', '', 0, 1, 1, 0, 'single', '', '', 6, 'admin', '2019-06-10 14:47:14', '2019-04-23 22:58:19', 'admin', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `onl_cgform_field` VALUES ('ab1f880ba593f3757dac70e003945aa2', '402860816bff91c0016bff91c0cb0000', 'depart_id', '部门ID', NULL, 0, 1, 'String', 32, 0, '', '', '', '', 'text', '', 120, NULL, '0', '', '', 0, 1, 1, 0, 'single', '', '', 6, 'admin', '2019-07-19 18:09:01', '2019-07-17 19:38:45', 'admin', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `onl_cgform_field` VALUES ('ab58f43f853fd1f65f83c22966883afb', 'beee191324fd40c1afec4fda18bd9d47', 'create_by', '创建人', NULL, 0, 1, 'string', 50, 0, '', '', '', '', 'text', '', 120, NULL, '0', '', '', 0, 0, 0, 0, 'single', '', '', 2, 'admin', '2019-04-13 13:41:13', '2019-04-13 13:40:56', 'admin', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `onl_cgform_field` VALUES ('ab8e6f1cca421c5ce395a2c1fdfd2100', '32feeb502544416c9bf41329c10a88f4', 'sys_org_code', '所属部门', NULL, 0, 1, 'string', 64, 0, '', '', '', '', 'text', '', 120, NULL, '0', '', '', 0, 0, 0, 0, 'single', '', '', 6, 'admin', '2019-08-23 20:03:40', '2019-07-02 18:23:23', 'admin', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `onl_cgform_field` VALUES ('abe61a8ddf966a979457b763329a537b', 'e5464aa8fa7b47c580e91593cf9b46dc', 'create_time', '创建日期', NULL, 0, 1, 'Date', 20, 0, '', '', '', '', 'datetime', '', 120, NULL, '0', '', '', 0, 0, 0, 0, 'single', '', '', 3, 'admin', '2019-04-24 17:09:49', '2019-04-24 11:05:10', 'admin', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `onl_cgform_field` VALUES ('ac05036c608194165a762918250fbdd4', '40288183712a997c01712a99809e0001', 'tax_rate', '税率', 'tax_rate', 0, 1, 'BigDecimal', 6, 4, NULL, NULL, NULL, NULL, 'text', NULL, 120, NULL, '0', NULL, NULL, 0, 1, 1, 0, 'group', NULL, NULL, 15, NULL, NULL, '2020-03-30 16:40:36', 'admin', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `onl_cgform_field` VALUES ('ac82bed3e045f744bc7f407d3b909fec', '402881017185937c0171859381700002', 'amt', '核销金额', 'amt', 0, 0, 'BigDecimal', 18, 2, '', '', '', '', 'text', '', 120, NULL, '0', '', '', 0, 1, 1, 0, 'group', '', '', 6, 'admin', '2020-04-18 17:11:30', '2020-04-17 08:39:29', 'admin', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `onl_cgform_field` VALUES ('ac91565da5fb8fe43a4da3dec660b25f', '402860816bff91c0016bff91c7010001', 'award_place', '获奖地点', 'award_place', 0, 1, 'string', 255, 0, '', '', '', '', 'text', '', 120, NULL, '0', '', '', 0, 1, 1, 0, 'group', '', '', 4, 'admin', '2019-07-19 18:07:47', '2019-07-17 18:54:32', 'admin', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `onl_cgform_field` VALUES ('acff5c8aef3b6288b87fd91215012206', 'e5464aa8fa7b47c580e91593cf9b46dc', 'update_by', '更新人', NULL, 0, 1, 'string', 50, 0, '', '', '', '', 'text', '', 120, NULL, '0', '', '', 0, 0, 0, 0, 'single', '', '', 4, 'admin', '2019-04-24 17:09:49', '2019-04-24 11:05:10', 'admin', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `onl_cgform_field` VALUES ('ad061417d5b53c67975eb83657505218', '73162c3b8161413e8ecdca7eb288d0c9', 'update_by', '更新人', NULL, 0, 1, 'string', 50, 0, '', '', '', '', 'text', '', 120, NULL, '0', '', '', 0, 0, 0, 0, 'single', '', '', 4, 'admin', '2019-07-01 14:23:32', '2019-06-10 15:18:34', 'admin', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `onl_cgform_field` VALUES ('ad6dfa7a5e8add8e0daf0fec066b52fc', '871c2df1185c4c8e80377d3c319c9a1e', 'sys_org_code', '所属部门', NULL, 0, 1, 'string', 64, 0, '', '', '', '', 'text', '', 120, NULL, '0', '', '', 0, 0, 0, 0, 'single', '', '', 6, NULL, NULL, '2020-03-20 11:42:58', 'admin', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `onl_cgform_field` VALUES ('ad93762c6c4a1dd8331e5fa11215b568', 'e2faf977fdaf4b25a524f58c2441a51c', 'id', '主键', NULL, 1, 0, 'string', 36, 0, '', '', '', '', 'text', '', 120, NULL, '0', '', '', 0, 0, 0, 0, 'single', '', '', 1, 'admin', '2019-06-10 17:27:00', '2019-04-24 17:12:11', 'admin', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `onl_cgform_field` VALUES ('ada11aeed49bdb8df2106d30b75cdf23', '4028818370e8d46b0170e8d46b4b0000', 'biller_id', '制单人', 'biller_id', 0, 1, 'string', 36, 0, '', '', '', '', 'text', '', 120, NULL, '0', '', '', 0, 1, 1, 0, 'group', '', '', 3, 'admin', '2020-03-19 10:25:32', '2020-03-17 22:10:00', 'admin', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `onl_cgform_field` VALUES ('ae170d2df19676c75eb80ea02495c0be', '871c2df1185c4c8e80377d3c319c9a1e', 'code', '编码', NULL, 0, 1, 'String', 32, 0, '', '', '', '', 'text', '', 120, NULL, '0', '', '', 0, 1, 1, 0, 'single', '', '', 7, NULL, NULL, '2020-03-20 11:42:58', 'admin', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `onl_cgform_field` VALUES ('ae31da96f38fc2941cb93d1bb1ab9431', 'deea5a8ec619460c9245ba85dbc59e80', 'product_name', '产品名字', NULL, 0, 1, 'String', 32, 0, '', '', '', '', 'text', '', 120, NULL, '0', '', '', 0, 1, 1, 0, 'single', '', '', 6, 'admin', '2020-03-15 17:37:15', '2019-04-20 11:41:19', 'admin', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `onl_cgform_field` VALUES ('ae77bb317366622698c8ab9bf2325833', 'deea5a8ec619460c9245ba85dbc59e80', 'create_by', '创建人', NULL, 0, 1, 'string', 50, 0, '', '', '', '', 'text', '', 120, NULL, '0', '', '', 0, 0, 0, 0, 'single', '', '', 2, 'admin', '2020-03-15 17:37:15', '2019-04-20 11:41:19', 'admin', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `onl_cgform_field` VALUES ('af0fe0df8b626129de62e22212732517', '402860816bff91c0016bff91cda80003', 'speciality', '专业', 'speciality', 0, 1, 'string', 100, 0, '', '', '', '', 'text', '', 120, NULL, '0', '', '', 0, 1, 1, 0, 'group', '', '', 6, 'admin', '2019-07-19 18:06:36', '2019-07-17 18:54:34', 'admin', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `onl_cgform_field` VALUES ('af6c582b902e2f2bf9930eba61ae7938', '73162c3b8161413e8ecdca7eb288d0c9', 'update_time', '更新日期', NULL, 0, 1, 'Date', 20, 0, '', '', '', '', 'datetime', '', 120, NULL, '0', '', '', 0, 0, 0, 0, 'single', '', '', 5, 'admin', '2019-07-01 14:23:32', '2019-06-10 15:18:34', 'admin', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `onl_cgform_field` VALUES ('af831ed66779e115c157549dce89388b', '402881fe71c8c4fd0171c8c503230002', 'source_type', '源单类型', 'source_type', 0, 1, 'string', 50, 0, '', 'x_bill_type', '', '', 'list', '', 120, NULL, '0', '', '', 0, 1, 1, 0, 'group', '', '', 5, 'admin', '2020-04-30 10:30:53', '2020-04-30 09:48:07', 'admin', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `onl_cgform_field` VALUES ('af867a2bf71d9be111fd0617da475f15', '4028818370e8d46b0170e8d46b4b0000', 'closed', '是否关闭', 'closed', 0, 1, 'int', 3, 0, '', '', '', '', 'text', '', 120, NULL, '0', '', '', 0, 1, 1, 0, 'group', '', '', 23, 'admin', '2020-03-19 10:25:32', '2020-03-17 22:10:01', 'admin', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `onl_cgform_field` VALUES ('afbab990feab09d2307e691cd4cbdbb3', '402881fe72268ef10172268ef1370000', 'update_by', '修改人', 'update_by', 0, 1, 'string', 36, 0, '', 'username', 'sys_user', 'realname', 'list', '', 120, NULL, '0', '', '', 0, 1, 1, 0, 'single', '', '', 19, 'admin', '2020-05-18 15:50:07', '2020-05-18 14:53:22', 'admin', '', '', '', '', '', NULL, '0', NULL, NULL, '0');
INSERT INTO `onl_cgform_field` VALUES ('afd3ef1d494a9b69d2c7a3cdde937f6f', '402860816bff91c0016bffa220a9000b', 'create_by', '创建人', 'create_by', 0, 1, 'string', 100, 0, '', '', '', '', 'text', '', 120, NULL, '0', '', '', 0, 1, 1, 0, 'group', '', '', 39, 'admin', '2019-07-22 16:15:32', '2019-07-17 19:12:24', 'admin', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `onl_cgform_field` VALUES ('afd408705fb846142accae91dfa0ec4f', '40288183712a997c01712a99809e0001', 'qty', '数量', 'qty', 0, 1, 'BigDecimal', 18, 6, NULL, NULL, NULL, NULL, 'text', NULL, 120, NULL, '0', NULL, NULL, 0, 1, 1, 0, 'group', NULL, NULL, 7, NULL, NULL, '2020-03-30 16:40:36', 'admin', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `onl_cgform_field` VALUES ('afe377cc3294d2c8adc81a519b26f85e', '40288183712beaa901712c0ebcb10003', 'create_by', '创建人', 'create_by', 0, 1, 'string', 36, 0, '', '', '', '', 'text', '', 120, NULL, '0', '', '', 0, 1, 0, 1, 'group', '', '', 37, 'admin', '2020-03-31 00:04:14', '2020-03-30 23:28:16', 'admin', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `onl_cgform_field` VALUES ('aff528f5e2648c76f56c0c6b44f621dd', '40288183712beaa901712beaa9a00000', 'effective_time', '生效时间', 'effective_time', 0, 1, 'Date', 0, 0, '', '', '', '', 'date', '', 120, NULL, '0', '', '', 0, 1, 1, 1, 'group', '', '', 19, 'admin', '2020-04-17 12:01:33', '2020-03-30 22:48:52', 'admin', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `onl_cgform_field` VALUES ('affa9f4a37c1b7dfaff57116f8e1acb9', '40288183712beaa901712c0eb77c0002', 'name', '名称', 'name', 0, 1, 'string', 100, 0, '', '', '', '', 'text', '', 120, NULL, '0', '', '', 1, 1, 1, 0, 'single', '', '', 3, 'admin', '2020-03-31 00:15:25', '2020-03-30 23:28:15', 'admin', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `onl_cgform_field` VALUES ('b01304904babd7479de2acfe8a77157f', '402860816aa5921f016aa5921f480000', 'id', 'ID', 'id', 1, 1, 'string', 32, 0, '', '', '', '', 'text', '', 120, NULL, '0', '', '', 0, 0, 0, 0, 'group', '', '', 1, 'admin', '2019-05-11 15:31:54', '2019-05-11 14:26:19', 'admin', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `onl_cgform_field` VALUES ('b02b3d0a1f5e9e7ea267c7d0b8e6fcc3', '40288183712beaa901712beaad3c0001', 'invocied_qty', '已开票数量', 'invocied_qty', 0, 1, 'BigDecimal', 18, 6, '', '', '', '', 'text', '', 120, NULL, '0', '', '', 0, 1, 1, 1, 'group', '', '', 21, 'admin', '2020-05-04 21:41:29', '2020-03-30 22:48:53', 'admin', '', '', '', '', '', NULL, '0', NULL, NULL, '0');
INSERT INTO `onl_cgform_field` VALUES ('b05b4cbb74f389a7376f51ed9fd97030', '402860816bff91c0016bff91d8830007', 'create_by', '创建人', 'create_by', 0, 1, 'string', 100, 0, '', '', '', '', 'text', '', 120, NULL, '0', '', '', 0, 1, 1, 0, 'group', '', '', 10, 'admin', '2019-07-19 18:04:41', '2019-07-17 18:54:37', 'admin', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `onl_cgform_field` VALUES ('b05d669d7c327b361af107f8944a5673', '40288183712beaa901712c0eb77c0002', 'account_payment', '办款资料账号', 'account_payment', 0, 1, 'string', 100, 0, '', '', '', '', 'text', '', 120, NULL, '0', '', '', 0, 1, 0, 0, 'group', '', '', 28, 'admin', '2020-03-31 00:15:25', '2020-03-30 23:28:15', 'admin', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `onl_cgform_field` VALUES ('b0a06bdbefd304d81a1838d8d94deda9', '4b556f0168f64976a3d20bfb932bc798', 'name', '用户名', NULL, 0, 1, 'String', 32, 0, '', '', '', '', 'text', '', 120, NULL, '0', '', '', 0, 1, 1, 0, 'single', '', '', 6, NULL, NULL, '2019-04-12 23:38:28', 'admin', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `onl_cgform_field` VALUES ('b0b1cf271dd6b221a902da2d2f8f889a', 'e9faf717024b4aae95cff224ae9b6d97', 'update_time', '更新日期', NULL, 0, 1, 'Date', 20, 0, '', '', '', '', 'datetime', '', 120, NULL, '0', '', '', 0, 0, 0, 0, 'single', '', '', 5, 'admin', '2019-07-03 18:23:49', '2019-07-03 18:22:35', 'admin', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `onl_cgform_field` VALUES ('b0b36368ce8e8c6c067f5681e234e0f7', '402881fe724af1fc01724af1feaf0001', 'year', '业务年度', 'year', 0, 0, 'int', 5, 0, '', '', '', '', 'text', '', 120, NULL, '0', '', '', 1, 1, 1, 0, 'single', '', '', 2, 'admin', '2020-05-25 16:38:12', '2020-05-25 16:27:53', 'admin', '', '', '', '', '', NULL, '0', NULL, NULL, '0');
INSERT INTO `onl_cgform_field` VALUES ('b1ac9b6149f19d6a6b0e93a9ad75b918', '402881017185937c017185937f430001', 'amt', '核销金额', 'amt', 0, 0, 'BigDecimal', 18, 2, '', '', '', '', 'text', '', 120, NULL, '0', '', '', 0, 1, 1, 0, 'group', '', '', 6, 'admin', '2020-04-18 17:08:51', '2020-04-17 08:39:29', 'admin', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `onl_cgform_field` VALUES ('b1df8b5042d3059ffd0f5838ca4458be', 'c20b114d92ed45eab356431a624dd12b', 'create_time', '创建日期', NULL, 0, 1, 'Date', 20, 0, '', '', '', '', 'datetime', '', 120, NULL, '0', '', '', 0, 0, 0, 0, 'single', '', '', 3, 'admin', '2020-03-20 11:41:31', '2020-03-20 11:29:28', 'admin', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `onl_cgform_field` VALUES ('b1fc6e2ca671b19e57b08a4f57fc2454', 'fb7125a344a649b990c12949945cb6c1', 'update_time', '更新日期', NULL, 0, 1, 'date', 20, 0, '', '', '', '', 'text', '', 120, '', '0', '', '', 0, 0, 0, 0, 'single', '', '', 4, 'admin', '2019-03-26 19:24:11', '2019-03-26 19:01:52', 'admin', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `onl_cgform_field` VALUES ('b22694cf34ffb967b8717647816ad5df', 'e5464aa8fa7b47c580e91593cf9b46dc', 'fk_id', '外键', NULL, 0, 1, 'String', 32, 0, '', '', '', '', 'text', '', 120, NULL, '0', '', '', 0, 0, 0, 0, 'single', 'air_china_post_materiel_main', 'id', 15, 'admin', '2019-04-24 17:09:49', '2019-04-24 11:05:10', 'admin', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `onl_cgform_field` VALUES ('b24b5699578d4c6814f00f1f4ae00b48', '4028818371790b3f0171790b3f780000', 'id', 'ID', 'id', 1, 0, 'string', 36, 0, '', '', '', '', 'text', '', 120, NULL, '0', '', '', 0, 0, 0, 0, 'group', '', '', 1, 'admin', '2020-04-14 23:41:28', '2020-04-14 22:15:13', 'admin', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `onl_cgform_field` VALUES ('b276facab025f9750b0aff391693cc4b', '402860816bff91c0016bff91c7010001', 'id', 'id', 'id', 1, 1, 'string', 32, 0, '', '', '', '', 'text', '', 120, NULL, '0', '', '', 0, 0, 0, 0, 'group', '', '', 1, 'admin', '2019-07-19 18:07:47', '2019-07-17 18:54:32', 'admin', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `onl_cgform_field` VALUES ('b28dbc9162156c31a6bd43667bfd9060', '402881e970dd8d520170ddb3a6490004', 'supplier_id', 'supplierId', 'supplier_id', 0, 1, 'string', 36, 0, '', '', '', '', 'text', '', 120, NULL, '0', '', '', 0, 1, 1, 0, 'group', '', '', 9, 'admin', '2020-03-16 22:39:53', '2020-03-15 18:18:23', 'admin', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `onl_cgform_field` VALUES ('b29952f8e35e91345ab7a0895941029d', '871c2df1185c4c8e80377d3c319c9a1e', 'name', '名称', NULL, 0, 1, 'String', 32, 0, '', '', '', '', 'text', '', 120, NULL, '0', '', '', 0, 1, 1, 0, 'single', '', '', 8, NULL, NULL, '2020-03-20 11:42:58', 'admin', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `onl_cgform_field` VALUES ('b2b0cb30159639bb1190e150322b7541', '4028839a6de2ebd3016de2ebd3870000', 'wl_unit', '计量单位', 'wl_unit', 0, 1, 'string', 100, 0, NULL, NULL, NULL, NULL, 'text', NULL, 120, NULL, '0', NULL, NULL, 0, 1, 1, 0, 'group', NULL, NULL, 14, NULL, NULL, '2019-10-19 15:29:30', 'admin', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `onl_cgform_field` VALUES ('b3542d3e7908ed885ecc4ba9e7300705', '4b556f0168f64976a3d20bfb932bc798', 'create_by', '创建人', NULL, 0, 1, 'string', 50, 0, '', '', '', '', 'text', '', 120, NULL, '0', '', '', 0, 0, 0, 0, 'single', '', '', 2, NULL, NULL, '2019-04-12 23:38:28', 'admin', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `onl_cgform_field` VALUES ('b3b383a245e873759cdc2e48f4e8a772', '4028818370e8d46b0170e8d46d350001', 'settle_amt', '结算金额', 'settle_amt', 0, 1, 'BigDecimal', 18, 2, '', '', '', '', 'text', '', 120, NULL, '0', '', '', 0, 1, 1, 0, 'group', '', '', 19, 'admin', '2020-03-17 22:14:27', '2020-03-17 22:10:01', 'admin', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `onl_cgform_field` VALUES ('b42ca7ef5bfe6530156c9afd5ad9510b', '402881fe72268ef10172268ef1370000', 'is_approved', '是否通过', 'is_approved', 0, 1, 'int', 3, 0, '', 'yn', '', '', 'list', '', 120, NULL, '0', '', '', 0, 1, 1, 0, 'single', '', '', 12, 'admin', '2020-05-18 15:50:07', '2020-05-18 14:53:22', 'admin', '', '', '', '', '', NULL, '0', NULL, NULL, '0');
INSERT INTO `onl_cgform_field` VALUES ('b46c4cddd9a02c58c097e4e8ec7f6826', '4028818371790b3f0171795b83bd0003', 'bank_no', '行号', 'bank_no', 0, 1, 'string', 50, 0, '', '', '', '', 'text', '', 120, NULL, '0', '', '', 0, 1, 1, 0, 'group', '', '', 6, 'admin', '2020-04-14 23:46:44', '2020-04-14 23:42:53', 'admin', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `onl_cgform_field` VALUES ('b47af4d937e55c6208939bac5378bfad', '62e29cdb81ac44d1a2d8ff89851b853d', 'update_time', '更新日期', NULL, 0, 1, 'Date', 20, 0, '', '', '', '', 'datetime', '', 120, NULL, '0', '', '', 0, 0, 0, 0, 'single', '', '', 5, NULL, NULL, '2019-05-11 14:01:14', 'admin', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `onl_cgform_field` VALUES ('b52ac5bdcad5b15ed35741a44dd06758', '40288183712a997c01712a99809e0001', 'invocied_amt', '已开票金额', 'invocied_amt', 0, 1, 'BigDecimal', 18, 2, NULL, NULL, NULL, NULL, 'text', NULL, 120, NULL, '0', NULL, NULL, 0, 1, 1, 0, 'group', NULL, NULL, 21, NULL, NULL, '2020-03-30 16:40:36', 'admin', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `onl_cgform_field` VALUES ('b52dc69202b8ba44b698acd650d80b98', 'c20b114d92ed45eab356431a624dd12b', 'update_by', '更新人', NULL, 0, 1, 'string', 50, 0, '', '', '', '', 'text', '', 120, NULL, '0', '', '', 0, 0, 0, 0, 'single', '', '', 4, 'admin', '2020-03-20 11:41:31', '2020-03-20 11:29:28', 'admin', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `onl_cgform_field` VALUES ('b53203fc52d067bb4730dbcb7e496bd3', '56870166aba54ebfacb20ba6c770bd73', 'id', '主键', NULL, 1, 0, 'string', 36, 0, '', '', '', '', 'text', '', 120, NULL, '0', '', '', 0, 0, 0, 0, 'single', '', '', 1, 'admin', '2019-11-21 17:58:27', '2019-04-20 11:38:39', 'admin', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `onl_cgform_field` VALUES ('b54b767757c27901a43501f526f0266a', '402881fe72362af70172362afadf0001', 'note2', '备注2', 'note2', 0, 1, 'string', 50, 0, '', '', '', '', 'text', '', 120, NULL, '0', '', '', 0, 1, 1, 0, 'single', '', '', 12, 'admin', '2020-05-21 20:23:41', '2020-05-21 15:38:06', 'admin', '', '', '', '', '', NULL, '0', NULL, NULL, '0');
INSERT INTO `onl_cgform_field` VALUES ('b57bd5ecf195731ed5271f5315246c34', '4028818370e8d46b0170e8d46b4b0000', 'update_time', '修改时间', 'update_time', 0, 1, 'Date', 0, 0, '', '', '', '', 'date', '', 120, NULL, '0', '', '', 0, 1, 1, 0, 'group', '', '', 21, 'admin', '2020-03-19 10:25:32', '2020-03-17 22:10:01', 'admin', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `onl_cgform_field` VALUES ('b5cfd3c9691a884430f3d9cd5ecb211f', 'e2faf977fdaf4b25a524f58c2441a51c', 'create_by', '创建人', NULL, 0, 1, 'string', 50, 0, '', '', '', '', 'text', '', 120, NULL, '0', '', '', 0, 0, 0, 0, 'single', '', '', 2, 'admin', '2019-06-10 17:27:00', '2019-04-24 17:12:11', 'admin', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `onl_cgform_field` VALUES ('b5fdc89f7623eb957b3c27716f332087', '402881017185937c0171859381700002', 'remark', '备注', 'remark', 0, 1, 'string', 50, 0, '', '', '', '', 'text', '', 120, NULL, '0', '', '', 0, 1, 1, 0, 'group', '', '', 7, 'admin', '2020-04-18 17:11:30', '2020-04-17 08:39:29', 'admin', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `onl_cgform_field` VALUES ('b5fef8fed807e9f71c77c079ed23c81f', '40288183712beaa901712c0eb77c0002', 'website', '客户网站', 'website', 0, 1, 'string', 100, 0, '', '', '', '', 'text', '', 120, NULL, '0', '', '', 0, 1, 1, 0, 'group', '', '', 12, 'admin', '2020-03-31 00:15:25', '2020-03-30 23:28:15', 'admin', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `onl_cgform_field` VALUES ('b6650301448f5965ae304894d428c109', '4028818370e8d46b0170e8d46d350001', 'purchase_cost', '购进成本', 'purchase_cost', 0, 1, 'BigDecimal', 18, 6, '', '', '', '', 'text', '', 120, NULL, '0', '', '', 0, 1, 1, 0, 'group', '', '', 10, 'admin', '2020-03-17 22:14:27', '2020-03-17 22:10:01', 'admin', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `onl_cgform_field` VALUES ('b672e27d6f675299615220364677833c', '40288183712beaa901712c0ebcb10003', 'name', '名称', 'name', 0, 1, 'string', 100, 0, '', '', '', '', 'text', '', 120, NULL, '0', '', '', 1, 1, 1, 0, 'single', '', '', 3, 'admin', '2020-03-31 00:04:14', '2020-03-30 23:28:16', 'admin', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `onl_cgform_field` VALUES ('b6874a05734cad8bd96ffd2f31f1ebca', '402860816bff91c0016bff91c7010001', 'create_by', '创建人', 'create_by', 0, 1, 'string', 100, 0, '', '', '', '', 'text', '', 120, NULL, '0', '', '', 0, 1, 1, 0, 'group', '', '', 7, 'admin', '2019-07-19 18:07:47', '2019-07-17 18:54:32', 'admin', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `onl_cgform_field` VALUES ('b6a8cb57bb910edea0bcf63ced87b965', '402881017185937c017185937c100000', 'flow_id', '流程id', 'flow_id', 0, 1, 'string', 36, 0, '', '', '', '', 'text', '', 120, NULL, '0', '', '', 0, 1, 1, 1, 'group', '', '', 14, 'admin', '2020-04-17 11:31:14', '2020-04-17 08:39:28', 'admin', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `onl_cgform_field` VALUES ('b6b6ce428e253d97ab0e37d8c299eeef', '40288183712beaa901712c0eb77c0002', 'biz_area', '业务区域', 'biz_area', 0, 1, 'string', 20, 0, '', '', '', '', 'text', '', 120, NULL, '0', '', '', 0, 1, 0, 0, 'group', '', '', 11, 'admin', '2020-03-31 00:15:25', '2020-03-30 23:28:15', 'admin', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `onl_cgform_field` VALUES ('b733fa73519603b22d401fabbf9e9781', '402860816bff91c0016bff91c0cb0000', 'hiredate', '入职时间', 'hiredate', 0, 1, 'Date', 0, 0, '', '', '', '', 'date', '', 120, NULL, '0', '', '', 0, 1, 1, 0, 'group', '', '', 5, 'admin', '2019-07-19 18:09:01', '2019-07-17 18:54:32', 'admin', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `onl_cgform_field` VALUES ('b7355dcb2693478edf7a3370405859bd', '40288183712a997c01712a997c580000', 'bill_status', '单据状态', 'bill_status', 0, 1, 'string', 4, 0, '', '', '', '', 'text', '', 120, NULL, '0', '', '', 0, 1, 1, 0, 'group', '', '', 12, 'admin', '2020-03-30 16:48:20', '2020-03-30 16:40:35', 'admin', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `onl_cgform_field` VALUES ('b7938e4518f9062ce62702cf45986e06', 'e2faf977fdaf4b25a524f58c2441a51c', 'create_time', '创建日期', NULL, 0, 1, 'Date', 20, 0, '', '', '', '', 'datetime', '', 120, NULL, '0', '', '', 0, 0, 0, 0, 'single', '', '', 3, 'admin', '2019-06-10 17:27:00', '2019-04-24 17:12:11', 'admin', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `onl_cgform_field` VALUES ('b7a1243aaa712e2c152c0c7a46f88683', '402860816bff91c0016bff91d8830007', 'age', '年龄', 'age', 0, 1, 'int', 10, 0, '', '', '', '', 'text', '', 120, NULL, '0', '', '', 0, 1, 1, 0, 'group', '', '', 5, 'admin', '2019-07-19 18:04:41', '2019-07-17 18:54:37', 'admin', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `onl_cgform_field` VALUES ('b8f576e97777fb4011228e8c6b3f293d', '402881fe71c8c4fd0171c8c503230002', 'customer_id', '客户', 'customer_id', 0, 0, 'string', 36, 0, '', 'id', 'bas_customer', 'name', 'list', '', 120, NULL, '0', '', '', 1, 1, 1, 1, 'single', '', '', 8, 'admin', '2020-04-30 10:30:53', '2020-04-30 09:48:07', 'admin', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `onl_cgform_field` VALUES ('b8ffea2d4ed5d63e4360237805441771', '40288183712beaa901712beaad3c0001', 'material_id', '物料', 'material_id', 0, 0, 'string', 36, 0, '', 'id', 'bas_material', 'name', 'sel_search', '', 120, NULL, '0', '', '', 0, 1, 1, 0, 'group', '', '', 6, 'admin', '2020-05-04 21:41:29', '2020-03-30 22:48:53', 'admin', '', '', '', '', '', NULL, '0', NULL, NULL, '0');
INSERT INTO `onl_cgform_field` VALUES ('b91258e3dc15b28c2e3f0d934e6e27e8', 'fb7125a344a649b990c12949945cb6c1', 'id', '主键', NULL, 1, 0, 'string', 36, 0, '', '', '', '', 'text', '', 120, '', '0', '', '', 0, 1, 1, 0, 'single', '', '', 0, NULL, NULL, '2019-03-26 19:01:52', 'admin', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `onl_cgform_field` VALUES ('b92572ae142f8dd5f2ac02fb45e6b2c1', 'e2faf977fdaf4b25a524f58c2441a51c', 'name', '用户名', NULL, 0, 1, 'String', 32, 0, '', 'realname,username', 'report_user', 'name,account', 'sel_search', '', 120, NULL, '0', '', '', 0, 1, 1, 0, 'single', '', '', 6, 'admin', '2019-06-10 17:27:00', '2019-04-24 17:12:11', 'admin', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `onl_cgform_field` VALUES ('b9a02d76757e82df07237be009f7a31e', '402881017185937c017185937c100000', 'update_by', '修改人', 'update_by', 0, 1, 'string', 36, 0, '', 'username', 'sys_user', 'realname', 'list', '', 120, NULL, '0', '', '', 0, 1, 1, 1, 'group', '', '', 19, 'admin', '2020-04-17 11:31:14', '2020-04-17 08:39:28', 'admin', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `onl_cgform_field` VALUES ('b9c158c2c3acbb830fab770b2c010e10', '402881e970dd8d520170dd90f7c30002', 'settle_qty', '结算数量', 'settle_qty', 0, 1, 'BigDecimal', 18, 6, '', '', '', '', 'text', '', 120, NULL, '0', '', '', 0, 1, 1, 0, 'group', '', '', 13, 'admin', '2020-03-15 21:40:40', '2020-03-15 17:40:31', 'admin', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `onl_cgform_field` VALUES ('b9fbace24688c9c9a8c9be72c1d014e7', '402860816bff91c0016bffa220a9000b', 'phone', '电话', 'phone', 0, 1, 'string', 20, 0, '', '', '', '', 'text', '', 120, NULL, '0', '', '', 0, 1, 1, 0, 'group', '', '', 18, 'admin', '2019-07-22 16:15:32', '2019-07-17 19:12:24', 'admin', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `onl_cgform_field` VALUES ('ba13e4583b860e465dadc520ca5bc405', '40288183712a997c01712a997c580000', 'approver_id', '审核人', 'approver_id', 0, 1, 'string', 36, 0, '', '', '', '', 'text', '', 120, NULL, '0', '', '', 0, 1, 1, 0, 'group', '', '', 13, 'admin', '2020-03-30 16:48:20', '2020-03-30 16:40:35', 'admin', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `onl_cgform_field` VALUES ('ba348a2b49a2042e9cd5787294221aa2', '402881fe72268ef10172268ef3ec0001', 'version', '版本号', 'version', 0, 1, 'int', 10, 0, '', '', '', '', 'text', '', 120, NULL, '0', '', '', 0, 1, 1, 0, 'single', '', '', 16, 'admin', '2020-05-18 15:55:16', '2020-05-18 14:53:23', 'admin', '', '', '', '', '', NULL, '0', NULL, NULL, '0');
INSERT INTO `onl_cgform_field` VALUES ('ba4f6f1e68e461404e0aaa85024910a2', '4028818370f308e90170f308eabf0001', 'id', 'ID', 'id', 1, 0, 'string', 36, 0, '', '', '', '', 'text', '', 120, NULL, '0', '', '', 0, 0, 0, 0, 'group', '', '', 1, 'admin', '2020-05-29 20:32:59', '2020-03-19 21:43:33', 'admin', '', '', '', '', '', NULL, '0', NULL, NULL, '0');
INSERT INTO `onl_cgform_field` VALUES ('ba5f4b2affa94f36eda7f6f133db7ae3', '402860816bff91c0016bff91d2810005', 'workplace', '工作单位', 'workplace', 0, 1, 'string', 255, 0, '', '', '', '', 'text', '', 120, NULL, '0', '', '', 0, 1, 1, 0, 'group', '', '', 6, 'admin', '2019-07-19 18:05:55', '2019-07-17 18:54:35', 'admin', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `onl_cgform_field` VALUES ('ba78edddd1eefa2eefa00b69f8c6d4f0', '402881fe72268ef10172268ef3ec0001', 'warehouse_id', '仓库', 'warehouse_id', 0, 0, 'string', 36, 0, '', 'id', 'bas_warehouse', 'name', 'list', '', 120, NULL, '0', '', '', 0, 1, 1, 0, 'single', '', '', 5, 'admin', '2020-05-18 15:55:16', '2020-05-18 14:53:23', 'admin', '', '', '', '', '', NULL, '0', NULL, NULL, '0');
INSERT INTO `onl_cgform_field` VALUES ('bac7a16b3d050a356a448e5947db286a', '40288183712a997c01712a99809e0001', 'purchase_cost', '购进成本', 'purchase_cost', 0, 1, 'BigDecimal', 18, 6, NULL, NULL, NULL, NULL, 'text', NULL, 120, NULL, '0', NULL, NULL, 0, 1, 1, 0, 'group', NULL, NULL, 10, NULL, NULL, '2020-03-30 16:40:36', 'admin', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `onl_cgform_field` VALUES ('bad02e68ea37bf387337516af84a1ddb', '73162c3b8161413e8ecdca7eb288d0c9', 'id', '主键', NULL, 1, 0, 'string', 36, 0, '', '', '', '', 'text', '', 120, NULL, '0', '', '', 0, 0, 0, 0, 'single', '', '', 1, 'admin', '2019-07-01 14:23:32', '2019-06-10 15:18:34', 'admin', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `onl_cgform_field` VALUES ('bb01927f5acbc15b40e018cfcf3d269c', '402881fe71c8c4fd0171c8c500d30001', 'source_entry_id', '源单分录id', 'source_entry_id', 0, 1, 'string', 36, 0, '', '', '', '', 'text', '', 120, NULL, '0', '', '', 0, 0, 0, 0, 'group', '', '', 6, 'admin', '2020-04-30 10:30:11', '2020-04-30 09:48:07', 'admin', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `onl_cgform_field` VALUES ('bb44475e1d1738a19745bf9f3ebf9e40', '402860816bff91c0016bff91cfea0004', 'update_time', '更新时间', 'update_time', 0, 1, 'Date', 0, 0, '', '', '', '', 'date', '', 120, NULL, '0', '', '', 0, 1, 1, 0, 'group', '', '', 12, 'admin', '2019-07-19 18:05:13', '2019-07-17 18:54:35', 'admin', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `onl_cgform_field` VALUES ('bbb9c7623a1d500ef116051507f7b09c', '40288183712beaa901712c0ebcb10003', 'biz_area', '业务地域', 'biz_area', 0, 1, 'string', 20, 0, '', '', '', '', 'text', '', 120, NULL, '0', '', '', 0, 1, 1, 0, 'group', '', '', 10, 'admin', '2020-03-31 00:04:14', '2020-03-30 23:28:16', 'admin', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `onl_cgform_field` VALUES ('bbbb38347b1a5340a1d293e455c632ce', 'fb19fb067cd841f9ae93d4eb3b883dc0', '3', '4', NULL, 0, 1, 'string', 32, 0, '', '', '', '', 'text', '', 120, '', '0', '', '', 0, 1, 1, 0, 'single', '', '', 6, NULL, NULL, '2019-03-23 11:39:48', 'admin', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `onl_cgform_field` VALUES ('bbbd50923f25cae67644740172547a04', '402881fe71c8c4fd0171c8c4fdae0000', 'bill_proc_status', '处理状态', 'bill_proc_status', 0, 0, 'string', 4, 0, '', 'x_bill_proc_status', '', '', 'list', '', 120, NULL, '0', '', '', 0, 1, 1, 1, 'group', '', '', 11, 'admin', '2020-04-30 10:23:44', '2020-04-30 09:48:06', 'admin', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `onl_cgform_field` VALUES ('bbe651d92a3a96790105dc6dde56f219', '402881fe72268ef10172268ef1370000', 'effective_time', '生效时间', 'effective_time', 0, 1, 'Date', 0, 0, '', '', '', '', 'date', '', 120, NULL, '0', '', '', 0, 1, 1, 0, 'single', '', '', 13, 'admin', '2020-05-18 15:50:07', '2020-05-18 14:53:22', 'admin', '', '', '', '', '', NULL, '0', NULL, NULL, '0');
INSERT INTO `onl_cgform_field` VALUES ('bc2a589eaa5c3c21341a2e02398eb9e3', '4028818371790b3f0171790b43ac0001', 'settle_method', '结算方式', 'settle_method', 0, 1, 'string', 10, 0, '', 'x_payment_settle_method', '', '', 'list', '', 120, NULL, '0', '', '', 0, 1, 1, 0, 'group', '', '', 5, 'admin', '2020-04-14 23:25:38', '2020-04-14 22:15:14', 'admin', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `onl_cgform_field` VALUES ('bc5bcd4148e036d3ed1b68a67b5828da', '402881e970dd8d520170dd90f7c30002', 'tax_inclusive', 'taxInclusive', 'tax_inclusive', 0, 1, 'int', 3, 0, '', '', '', '', 'text', '', 120, NULL, '0', '', '', 0, 1, 1, 0, 'group', '', '', 12, 'admin', '2020-03-15 21:40:40', '2020-03-15 17:40:31', 'admin', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `onl_cgform_field` VALUES ('bc648624ad14c826bbc6e9b23a2b9858', '402860816bff91c0016bff91ca7e0002', 'employee_id', '员工ID', 'employee_id', 0, 1, 'string', 32, 0, '', '', '', '', 'text', '', 120, NULL, '0', '', '', 0, 1, 1, 0, 'group', 'oa_employee_info', 'id', 2, 'admin', '2019-07-19 18:07:13', '2019-07-17 18:54:33', 'admin', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `onl_cgform_field` VALUES ('bc793fdbef9f6474425456c4eb9d197a', '402860816bff91c0016bff91cfea0004', 'witness', '证明人', 'references', 0, 1, 'string', 100, 0, '', '', '', '', 'text', '', 120, NULL, '0', '', '', 0, 1, 1, 0, 'group', '', '', 6, 'admin', '2019-07-19 18:05:13', '2019-07-17 18:54:35', 'admin', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `onl_cgform_field` VALUES ('bc7df6f3cf49f670c36a3de25e25e715', '402860816bff91c0016bff91d2810005', 'order_no', '序号', 'order_no', 0, 1, 'int', 10, 0, '', '', '', '', 'text', '', 120, NULL, '0', '', '', 0, 1, 1, 0, 'group', '', '', 9, 'admin', '2019-07-19 18:05:55', '2019-07-17 18:54:35', 'admin', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `onl_cgform_field` VALUES ('bca8c274467de4c4a4426d12e136d45e', '4028818371790b3f0171795b80ed0002', 'id', 'ID', 'id', 1, 0, 'string', 36, 0, '', '', '', '', 'text', '', 120, NULL, '0', '', '', 0, 0, 0, 0, 'group', '', '', 1, 'admin', '2020-04-14 23:49:04', '2020-04-14 23:42:53', 'admin', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `onl_cgform_field` VALUES ('bcdaee70b73cb60b1c91761f30700192', '402881017185937c017185937c100000', 'remark', '备注', 'remark', 0, 1, 'string', 200, 0, '', '', '', '', 'text', '', 120, NULL, '0', '', '', 0, 1, 1, 0, 'group', '', '', 7, 'admin', '2020-04-17 11:31:14', '2020-04-17 08:39:28', 'admin', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `onl_cgform_field` VALUES ('bd23bcb431b41a19ed64ad82f283275e', '4028818370e8d46b0170e8d46d350001', 'version', '版本', 'version', 0, 0, 'int', 10, 0, '', '', '', '', 'text', '', 120, NULL, '0', '', '', 0, 1, 1, 0, 'group', '', '', 25, 'admin', '2020-03-17 22:14:27', '2020-03-17 22:10:01', 'admin', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `onl_cgform_field` VALUES ('bd39cb237049ac60218b3f4dd844f30c', '402860816bff91c0016bffa220a9000b', 'current_address', '现居住地', 'current_address', 0, 1, 'string', 200, 0, '', '', '', '', 'text', '', 120, NULL, '0', '', '', 0, 1, 1, 0, 'group', '', '', 30, 'admin', '2019-07-22 16:15:32', '2019-07-17 19:12:24', 'admin', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `onl_cgform_field` VALUES ('bd8d7ce8e41051dc0759a5ba745d9606', '402881fe72362af70172362af7150000', 'is_closed', '是否关闭', 'is_closed', 0, 0, 'int', 3, 0, '', 'yn', '', '', 'list', '', 120, NULL, '0', '', '', 0, 1, 1, 0, 'single', '', '', 20, 'admin', '2020-05-21 20:19:56', '2020-05-21 15:38:06', 'admin', '', '', '', '', '', NULL, '0', NULL, NULL, '0');
INSERT INTO `onl_cgform_field` VALUES ('bde81809057b1a4c974fa0f090501fdd', '402860816aa5921f016aa5dedcb90009', 'update_by', '更新人', 'update_by', 0, 1, 'string', 50, 0, '', '', '', '', 'text', '', 120, NULL, '0', '', '', 0, 0, 0, 0, 'group', '', '', 4, 'admin', '2019-05-11 15:56:47', '2019-05-11 15:50:08', 'admin', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `onl_cgform_field` VALUES ('be3f8c157d8a1b40e6f7b836552a8095', '8994f2817b5a45d9890aa04497a317c5', 'create_time', '创建日期', NULL, 0, 1, 'Date', 20, 0, '', '', '', '', 'text', '', 120, '', '0', '', '', 0, 1, 1, 0, 'single', '', '', 2, NULL, NULL, '2019-03-23 11:39:16', 'admin', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `onl_cgform_field` VALUES ('be5eeda7d51dace73d3818bd8467b53b', '402860816bff91c0016bff91c0cb0000', 'update_time', '更新时间', 'update_time', 0, 1, 'Date', 0, 0, '', '', '', '', 'date', '', 120, NULL, '0', '', '', 0, 1, 1, 0, 'group', '', '', 15, 'admin', '2019-07-19 18:09:01', '2019-07-17 18:54:32', 'admin', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `onl_cgform_field` VALUES ('be868eed386da3cfcf49ea9afcdadf11', 'd35109c3632c4952a19ecc094943dd71', 'create_time', '创建日期', NULL, 0, 1, 'Date', 20, 0, '', '', '', '', 'text', '', 120, '', '0', '', '', 0, 0, 0, 0, 'single', '', '', 2, 'admin', '2020-02-23 18:11:41', '2019-03-15 14:24:35', 'admin', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `onl_cgform_field` VALUES ('bec3082fc5f0f194be5cd72cc2866ff4', 'e5464aa8fa7b47c580e91593cf9b46dc', 'wl_name', '物料名字', NULL, 0, 1, 'String', 200, 0, '', 'wl_code', 'air_china_materiel', 'wl_name', 'list', '', 120, NULL, '0', '', '', 0, 1, 1, 0, 'single', '', '', 6, 'admin', '2019-04-24 17:09:49', '2019-04-24 11:05:10', 'admin', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `onl_cgform_field` VALUES ('bed0bc67f570613eaa6a1bd8bcaaddcc', '4b556f0168f64976a3d20bfb932bc798', 'create_time', '创建日期', NULL, 0, 1, 'Date', 20, 0, '', '', '', '', 'datetime', '', 120, NULL, '0', '', '', 0, 0, 0, 0, 'single', '', '', 3, NULL, NULL, '2019-04-12 23:38:28', 'admin', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `onl_cgform_field` VALUES ('bef85fd2846dd7ffc42d747095557d14', '4fb8e12a697f4d5bbe9b9fb1e9009486', 'date', '日期', NULL, 0, 1, 'string', 200, 0, '', '', '', '', 'text', '', 120, NULL, '0', '', '#{date}', 0, 1, 1, 0, 'single', '', '', 4, 'admin', '2020-04-10 19:51:27', '2020-04-10 19:47:01', 'admin', '', '', '', '', '', NULL, '0', NULL, NULL, '0');
INSERT INTO `onl_cgform_field` VALUES ('bf51aec600167d9d555a76855d669a61', '402881fe71c8c4fd0171c8c4fdae0000', 'create_time', '创建时间', 'create_time', 0, 1, 'Date', 0, 0, '', '', '', '', 'date', '', 120, NULL, '0', '', '', 0, 1, 1, 1, 'group', '', '', 18, 'admin', '2020-04-30 10:23:44', '2020-04-30 09:48:06', 'admin', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `onl_cgform_field` VALUES ('bf61aa04c5ca77ad54c764f8f8b2bdec', '402860816bff91c0016bff91d8830007', 'update_by', '更新人', 'update_by', 0, 1, 'string', 100, 0, '', '', '', '', 'text', '', 120, NULL, '0', '', '', 0, 1, 1, 0, 'group', '', '', 12, 'admin', '2019-07-19 18:04:41', '2019-07-17 18:54:37', 'admin', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `onl_cgform_field` VALUES ('bf997b1b5248832c27920ca827c9c053', '4028818371790b3f0171790b43ac0001', 'amt', '金额', 'amt', 0, 0, 'BigDecimal', 18, 2, '', '', '', '', 'text', '', 120, NULL, '0', '', '', 0, 1, 1, 0, 'group', '', '', 7, 'admin', '2020-04-14 23:25:38', '2020-04-14 22:15:14', 'admin', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `onl_cgform_field` VALUES ('bfc2f19fae367f885adb8bd82a344391', '4028318169e81b970169e81b97650000', 'userid', '操作用户账号', 'userid', 0, 1, 'string', 32, 0, NULL, NULL, NULL, NULL, 'text', NULL, 120, NULL, '0', NULL, NULL, 0, 1, 1, 0, 'group', NULL, NULL, 5, NULL, NULL, '2019-04-04 19:28:36', 'admin', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `onl_cgform_field` VALUES ('bfed4cc0b6d2bd948d93ff1398c8efec', '40288101710a4c6201710a60ad5e0001', 'version', '版本', 'version', 0, 1, 'int', 10, 0, '', '', '', '', 'text', '', 120, NULL, '0', '', '', 0, 0, 0, 1, 'group', '', '', 12, 'admin', '2020-03-28 09:52:10', '2020-03-24 10:30:41', 'admin', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `onl_cgform_field` VALUES ('c0934f4a1945abc1450750b3cab6d944', '4028818370f308e90170f308eabf0001', 'create_time', '创建时间', 'create_time', 0, 1, 'Date', 0, 0, '', '', '', '', 'date', '', 120, NULL, '0', '', '', 0, 1, 1, 0, 'group', '', '', 9, 'admin', '2020-05-29 20:32:59', '2020-03-19 21:43:33', 'admin', '', '', '', '', '', NULL, '0', NULL, NULL, '0');
INSERT INTO `onl_cgform_field` VALUES ('c0972d8e0b05b4c938d85bdbc0eca9b9', '40288183712beaa901712beaad3c0001', 'other_cost', '其他成本', 'other_cost', 0, 1, 'BigDecimal', 18, 2, '', '', '', '', 'text', '', 120, NULL, '0', '', '', 0, 1, 1, 0, 'group', '', '', 12, 'admin', '2020-05-04 21:41:29', '2020-03-30 22:48:53', 'admin', '', '', '', '', '', NULL, '0', NULL, NULL, '0');
INSERT INTO `onl_cgform_field` VALUES ('c0c80f370e1d400fe670d8702c3b84da', '4adec929a6594108bef5b35ee9966e9f', 'address_param', '地址（传参）', NULL, 0, 1, 'String', 32, 0, '', '', '', '', 'text', '', 120, NULL, '0', '', '{{ demoFieldDefVal_getAddress(\"昌平区\") }}', 0, 1, 1, 0, 'single', '', '', 6, 'admin', '2020-04-10 19:43:38', '2020-04-10 19:40:53', 'admin', '', '', '', '', '', NULL, '0', NULL, NULL, '0');
INSERT INTO `onl_cgform_field` VALUES ('c0cf74c72c28f1f6d43803d32f278038', '402881fe72268ef10172268ef1370000', 'update_time', '修改时间', 'update_time', 0, 1, 'Date', 0, 0, '', '', '', '', 'date', '', 120, NULL, '0', '', '', 0, 1, 1, 0, 'single', '', '', 20, 'admin', '2020-05-18 15:50:07', '2020-05-18 14:53:22', 'admin', '', '', '', '', '', NULL, '0', NULL, NULL, '0');
INSERT INTO `onl_cgform_field` VALUES ('c0d66c95773774e7ac1f2a88df307e7a', '402860816aa5921f016aa5921f480000', 'reason', '请假原因', 'reason', 0, 1, 'string', 500, 0, '', '', '', '', 'text', '', 120, NULL, '0', '', '', 0, 1, 1, 0, 'group', '', '', 6, 'admin', '2019-05-11 15:31:54', '2019-05-11 14:26:19', 'admin', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `onl_cgform_field` VALUES ('c129f2aa1c80b482fef793c14c579eb1', '4028818370e8d46b0170e8d46d350001', 'settle_price', '含税单价', 'settle_price', 0, 1, 'BigDecimal', 18, 6, '', '', '', '', 'text', '', 120, NULL, '0', '', '', 0, 1, 1, 0, 'group', '', '', 14, 'admin', '2020-03-17 22:14:27', '2020-03-17 22:10:01', 'admin', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `onl_cgform_field` VALUES ('c1303d77ecfce6025698b29fdd2d1adb', '40288183712beaa901712c0eb77c0002', 'tax_scale', '纳税规模', 'tax_scale', 0, 1, 'string', 10, 0, '', '', '', '', 'text', '', 120, NULL, '0', '', '', 0, 1, 1, 0, 'group', '', '', 6, 'admin', '2020-03-31 00:15:25', '2020-03-30 23:28:15', 'admin', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `onl_cgform_field` VALUES ('c146f17b1d6d92d265bce0582d982622', '4028818371790b3f0171795b83bd0003', 'init_bal', '初始余额', 'init_bal', 0, 0, 'BigDecimal', 18, 2, '', '', '', '', 'text', '', 120, NULL, '0', '', '', 0, 1, 1, 0, 'group', '', '', 5, 'admin', '2020-04-14 23:46:44', '2020-04-14 23:42:53', 'admin', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `onl_cgform_field` VALUES ('c186dbf0661a8f05435528ac49c8ffed', '402881e970dd8d520170ddb3a6490004', 'approver_id', 'approverId', 'approver_id', 0, 1, 'string', 36, 0, '', '', '', '', 'text', '', 120, NULL, '0', '', '', 0, 1, 1, 0, 'group', '', '', 16, 'admin', '2020-03-16 22:39:53', '2020-03-15 18:18:23', 'admin', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `onl_cgform_field` VALUES ('c19bd4605c7f032fad9becc9210cd253', '402881e970dd8d520170dd90f7c30002', 'qty', 'qty', 'qty', 0, 1, 'BigDecimal', 18, 6, '', '', '', '', 'text', '', 120, NULL, '0', '', '', 0, 1, 1, 0, 'group', '', '', 7, 'admin', '2020-03-15 21:40:40', '2020-03-15 17:40:31', 'admin', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `onl_cgform_field` VALUES ('c19f71ae05f686600fe7ef3c669a901f', '40288183712beaa901712beaad3c0001', 'source_entry_id', '源单分录', 'source_entry_id', 0, 1, 'string', 36, 0, '', '', '', '', 'text', '', 120, NULL, '0', '', '', 0, 0, 0, 0, 'group', '', '', 5, 'admin', '2020-05-04 21:41:29', '2020-03-30 22:48:53', 'admin', '', '', '', '', '', NULL, '0', NULL, NULL, '0');
INSERT INTO `onl_cgform_field` VALUES ('c1d2a1ae52ea573b351a0f4a8b621bfe', '4028818371790b3f0171795b80ed0002', 'is_functional', '是否本币', 'is_functional', 0, 0, 'int', 3, 0, '', 'yn', '', '', 'list', '', 120, NULL, '0', '', '', 0, 1, 1, 0, 'group', '', '', 4, 'admin', '2020-04-14 23:49:04', '2020-04-14 23:42:53', 'admin', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `onl_cgform_field` VALUES ('c1f711ce48c8ad8967f2067828344ce2', '40288183712beaa901712c0eb77c0002', 'contacts_financial', '财务信息联系人', 'contacts_financial', 0, 1, 'string', 50, 0, '', '', '', '', 'text', '', 120, NULL, '0', '', '', 0, 1, 0, 0, 'group', '', '', 16, 'admin', '2020-03-31 00:15:25', '2020-03-30 23:28:15', 'admin', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `onl_cgform_field` VALUES ('c29216d975fee50af175bca8c664a475', 'e67d26b610dd414c884c4dbb24e71ce3', 'id', '主键', NULL, 1, 0, 'string', 36, 0, '', '', '', '', 'text', '', 120, NULL, '0', '', '', 0, 0, 0, 0, 'single', '', '', 1, 'admin', '2019-04-24 11:03:32', '2019-04-24 11:02:56', 'admin', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `onl_cgform_field` VALUES ('c2b9eae184afe56d59ea7940d77cfced', '4adec929a6594108bef5b35ee9966e9f', 'id', '主键', NULL, 1, 0, 'string', 36, 0, '', '', '', '', 'text', '', 120, NULL, '0', '', '', 0, 0, 0, 1, 'single', '', '', 1, 'admin', '2020-04-10 19:43:38', '2020-04-10 19:35:57', 'admin', '', '', '', '', '', NULL, '0', NULL, NULL, '0');
INSERT INTO `onl_cgform_field` VALUES ('c3160e67096e9e70742078bfb435ec86', '4028818370f308e90170f308e9080000', 'category_id', '分类', 'category_id', 0, 0, 'string', 36, 0, '', '0', 'bas_material_category', 'id,pid,name,has_child', 'sel_tree', '', 120, NULL, '0', '', '', 1, 1, 1, 0, 'single', 'bas_material_category', 'id', 4, 'admin', '2020-05-30 11:58:17', '2020-03-19 21:43:33', 'admin', '', '', '', '', '', NULL, '0', NULL, NULL, '0');
INSERT INTO `onl_cgform_field` VALUES ('c382877700a9987f4bcc2deea9ee9daf', '4fb8e12a697f4d5bbe9b9fb1e9009486', 'id', '主键', NULL, 1, 0, 'string', 36, 0, '', '', '', '', 'text', '', 120, NULL, '0', '', '', 0, 0, 0, 1, 'single', '', '', 1, 'admin', '2020-04-10 19:51:27', '2020-04-10 19:47:01', 'admin', '', '', '', '', '', NULL, '0', NULL, NULL, '0');
INSERT INTO `onl_cgform_field` VALUES ('c3d15e08198475c0372efe47db8822d5', '4028818371790b3f0171790b3f780000', 'bill_proc_status', '处理状态', 'bill_proc_status', 0, 0, 'string', 4, 0, '11', 'x_bill_proc_status', '', '', 'list', '', 120, NULL, '0', '', '', 1, 1, 1, 1, 'single', '', '', 11, 'admin', '2020-04-14 23:41:28', '2020-04-14 22:15:13', 'admin', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `onl_cgform_field` VALUES ('c435c620505505b275cf532090fdc499', '4028818371790b3f0171795b80ed0002', 'name', '名称', 'name', 0, 0, 'string', 100, 0, '', '', '', '', 'text', '', 120, NULL, '0', '', '', 0, 1, 1, 0, 'group', '', '', 3, 'admin', '2020-04-14 23:49:04', '2020-04-14 23:42:53', 'admin', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `onl_cgform_field` VALUES ('c43d87b6340c29c0c354aa9c579f387f', '32feeb502544416c9bf41329c10a88f4', 'create_by', '创建人', NULL, 0, 1, 'string', 50, 0, '', '', '', '', 'text', '', 120, NULL, '0', '', '', 0, 0, 0, 0, 'single', '', '', 2, 'admin', '2019-08-23 20:03:40', '2019-07-02 18:23:23', 'admin', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `onl_cgform_field` VALUES ('c4409234fae44365cff4c35421493a0c', '402881e970dd8d520170ddb3a6490004', 'bill_no', '单据号', 'bill_no', 0, 0, 'string', 100, 0, '', '', '', '', 'text', '', 120, NULL, '0', '', '', 0, 1, 1, 0, 'group', '', '', 2, 'admin', '2020-03-16 22:39:53', '2020-03-15 18:18:23', 'admin', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `onl_cgform_field` VALUES ('c5be16ce747b21ababcaf80564f23ceb', '402881fe72268ef10172268ef3ec0001', 'unit_id', '计量单位', 'unit_id', 0, 0, 'string', 36, 0, '', 'id', 'bas_measure_unit', 'name', 'text', '', 120, NULL, '0', '', '', 0, 1, 1, 0, 'single', '', '', 10, 'admin', '2020-05-18 15:55:16', '2020-05-18 14:53:23', 'admin', '', '', '', '', '', NULL, '0', NULL, NULL, '0');
INSERT INTO `onl_cgform_field` VALUES ('c5dd2fc34ae825ebfced2ec74948654c', '402860816aa5921f016aa5921f480000', 'end_date', '请假结束时间', 'end_date', 0, 1, 'Date', 0, 0, '', '', '', '', 'date', '', 120, NULL, '0', '', '', 0, 1, 1, 0, 'group', '', '', 5, 'admin', '2019-05-11 15:31:54', '2019-05-11 14:26:19', 'admin', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `onl_cgform_field` VALUES ('c5eaebc530cd923c9f41e8eda5ef1e70', '402881fe72268ef10172268ef1370000', 'sys_org_code', '创建部门', 'sys_org_code', 0, 1, 'string', 50, 0, '', 'org_code', 'sys_depart', 'depart_name', 'list', '', 120, NULL, '0', '', '', 0, 1, 1, 0, 'single', '', '', 16, 'admin', '2020-05-18 15:50:07', '2020-05-18 14:53:22', 'admin', '', '', '', '', '', NULL, '0', NULL, NULL, '0');
INSERT INTO `onl_cgform_field` VALUES ('c5f6ea01a6523a60df153cc61dc92f4d', 'fbc35f067da94a70adb622ddba259352', 'create_by', '创建人', NULL, 0, 1, 'string', 50, 0, '', '', '', '', 'text', '', 120, NULL, '0', '', '', 0, 0, 0, 0, 'single', '', '', 2, NULL, NULL, '2019-07-03 19:44:23', 'admin', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `onl_cgform_field` VALUES ('c5fb6d6effded57172b880b86576812d', '40288183712beaa901712c0ebe7e0004', 'is_enabled', '是否启用', 'is_enabled', 0, 1, 'int', 3, 0, '', 'yn', '', '', 'list', '', 120, NULL, '0', '', '', 0, 1, 1, 0, 'group', '', '', 7, 'admin', '2020-03-30 23:41:18', '2020-03-30 23:28:16', 'admin', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `onl_cgform_field` VALUES ('c6227e52dbca293d6dfdf2750283d801', '40288183712beaa901712beaad3c0001', 'tax_rate', '税率', 'tax_rate', 0, 1, 'BigDecimal', 6, 4, '', '', '', '', 'text', '', 120, NULL, '0', '', '', 0, 1, 1, 0, 'group', '', '', 16, 'admin', '2020-05-04 21:41:29', '2020-03-30 22:48:53', 'admin', '', '', '', '', '', NULL, '0', NULL, NULL, '0');
INSERT INTO `onl_cgform_field` VALUES ('c64646f548c05b5be9182059c8912a72', '4028818371790b3f0171790b43ac0001', 'bank_account_id', '资金账户', 'bank_account_id', 0, 1, 'string', 36, 0, '', 'id', 'bas_bank_account', 'account_no', 'list', '', 120, NULL, '0', '', '', 0, 1, 1, 0, 'group', '', '', 6, 'admin', '2020-04-14 23:25:38', '2020-04-14 22:15:14', 'admin', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `onl_cgform_field` VALUES ('c6730e00df5efd77fedf181df29102de', '402860816bff91c0016bff91c7010001', 'update_by', '更新人', 'update_by', 0, 1, 'string', 100, 0, '', '', '', '', 'text', '', 120, NULL, '0', '', '', 0, 1, 1, 0, 'group', '', '', 9, 'admin', '2019-07-19 18:07:47', '2019-07-17 18:54:32', 'admin', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `onl_cgform_field` VALUES ('c729d5f86cd19e04f1f896801392b649', '402881fe72268ef10172268ef3ec0001', 'supplier_id', '供应商', 'supplier_id', 0, 1, 'string', 36, 0, '', 'id', 'bas_supplier', 'name', 'list', '', 120, NULL, '0', '', '', 0, 1, 1, 0, 'single', '', '', 9, 'admin', '2020-05-18 15:55:16', '2020-05-18 14:53:23', 'admin', '', '', '', '', '', NULL, '0', NULL, NULL, '0');
INSERT INTO `onl_cgform_field` VALUES ('c75a7cb0a21958aa7ca5442f66019669', 'e9faf717024b4aae95cff224ae9b6d97', 'depart', '所属部门', NULL, 0, 1, 'String', 32, 0, '', '', '', '', 'text', '', 120, NULL, '0', '', '', 0, 1, 1, 0, 'single', '', '', 9, 'admin', '2019-07-03 18:23:49', '2019-07-03 18:22:35', 'admin', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `onl_cgform_field` VALUES ('c772ed9cbe2d1dc69e9ffa73d3487021', '4b556f0168f64976a3d20bfb932bc798', 'id', '主键', NULL, 1, 0, 'string', 36, 0, '', '', '', '', 'text', '', 120, NULL, '0', '', '', 0, 0, 0, 0, 'single', '', '', 1, NULL, NULL, '2019-04-12 23:38:28', 'admin', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `onl_cgform_field` VALUES ('c7f2cf01e2bdd5b82deccb603c3cc41d', '402881e970dd8d520170ddb3a6490004', 'io_type', 'ioType', 'io_type', 0, 1, 'int', 3, 0, '', '', '', '', 'sel_search', '', 120, NULL, '0', '', '', 0, 1, 1, 0, 'group', '', '', 6, 'admin', '2020-03-16 22:39:53', '2020-03-15 18:18:23', 'admin', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `onl_cgform_field` VALUES ('c91b697b1bcd2be943fc746e2660bc9e', '402860816bff91c0016bff91d2810005', 'real_name', '姓名', 'real_name', 0, 1, 'string', 100, 0, '', '', '', '', 'text', '', 120, NULL, '0', '', '', 0, 1, 1, 0, 'group', '', '', 3, 'admin', '2019-07-19 18:05:55', '2019-07-17 18:54:35', 'admin', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `onl_cgform_field` VALUES ('c93a377c292f92b62bb0da608a7c4f5b', '4028818371790b3f0171790b3f780000', 'payment_type', '业务类型', 'payment_type', 0, 0, 'string', 10, 0, '', 'payment_type', '', '', 'list', '', 120, NULL, '0', '', '', 1, 1, 1, 0, 'group', '', '', 4, 'admin', '2020-04-14 23:41:28', '2020-04-14 22:15:13', 'admin', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `onl_cgform_field` VALUES ('c96341bcb05f2949a421d1dff17d6e0f', '402881fe72268ef10172268ef1370000', 'create_time', '创建时间', 'create_time', 0, 1, 'Date', 0, 0, '', '', '', '', 'date', '', 120, NULL, '0', '', '', 0, 1, 1, 0, 'single', '', '', 18, 'admin', '2020-05-18 15:50:07', '2020-05-18 14:53:22', 'admin', '', '', '', '', '', NULL, '0', NULL, NULL, '0');
INSERT INTO `onl_cgform_field` VALUES ('c988bd2b6125c01ceb3579a207dd8784', '3d447fa919b64f6883a834036c14aa67', 'city', '市', NULL, 0, 1, 'String', 100, 0, '', '', '', '', 'text', '', 120, NULL, '0', '', '', 0, 1, 1, 0, 'single', '', '', 3, 'admin', '2020-02-21 17:58:46', '2020-02-20 16:19:00', 'admin', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `onl_cgform_field` VALUES ('c9914973ae44f0bd79a00cd018c482d0', '40288101717185240171718524d60000', 'is_auto', '是否自动生成', 'is_auto', 0, 0, 'int', 3, 0, '', 'yn', '', '', 'list', '', 120, NULL, '0', '', '', 0, 1, 1, 0, 'group', '', '', 3, 'admin', '2020-04-13 14:00:53', '2020-04-13 11:11:24', 'admin', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `onl_cgform_field` VALUES ('c99c2329d0fa1e28bdf46bc40d63b58a', '402881fe72362af70172362af7150000', 'source_type', '源单类型', 'source_type', 0, 1, 'string', 50, 0, '', 'x_bill_type', '', '', 'list', '', 120, NULL, '0', '', '', 0, 1, 1, 0, 'single', '', '', 7, 'admin', '2020-05-21 20:19:56', '2020-05-21 15:38:06', 'admin', '', '', '', '', '', NULL, '0', NULL, NULL, '0');
INSERT INTO `onl_cgform_field` VALUES ('c9a31a0f586a0a05fbd477eb1483e789', '4028818370f5f37d0170f5f37dcf0000', 'parent_id', '父级节点', NULL, 0, 1, 'string', 32, 0, '', '', '', '', 'text', '', 120, NULL, '0', '', '', 0, 1, 0, 0, 'single', '', '', 7, 'admin', '2020-03-20 12:02:35', '2020-03-20 11:50:57', 'admin', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `onl_cgform_field` VALUES ('c9b698d3f75aa780ee1eb67ef090b15b', '73162c3b8161413e8ecdca7eb288d0c9', 'wl_code', '物料编码', NULL, 0, 1, 'String', 200, 0, '', '', '', '', 'text', '', 120, NULL, '0', '', '', 0, 1, 1, 0, 'single', '', '', 8, 'admin', '2019-07-01 14:23:32', '2019-06-10 15:18:34', 'admin', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `onl_cgform_field` VALUES ('caaf2eed4b0f23706212459506b9308a', '40288183712beaa901712c0eb77c0002', 'account_receipt', '收件信息地址', 'account_receipt', 0, 1, 'string', 200, 0, '', '', '', '', 'text', '', 120, NULL, '0', '', '', 0, 1, 0, 0, 'group', '', '', 29, 'admin', '2020-03-31 00:15:25', '2020-03-30 23:28:15', 'admin', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `onl_cgform_field` VALUES ('cad4aa749afb8493b9ec28222fbe5ae7', '4028818370e8d46b0170e8d46b4b0000', 'bill_date', '单据日期', 'bill_date', 0, 1, 'Date', 0, 0, '', '', '', '', 'date', '', 120, NULL, '0', '', '', 1, 1, 1, 0, 'group', '', '', 4, 'admin', '2020-03-19 10:25:32', '2020-03-17 22:10:00', 'admin', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `onl_cgform_field` VALUES ('cae53b2ef5fe973ba1e4a0ab6b41a0eb', '4028818371790b3f0171790b3f780000', 'amt', '金额', 'amt', 0, 0, 'BigDecimal', 18, 2, '', '', '', '', 'text', '', 120, NULL, '0', '', '', 0, 1, 1, 0, 'group', '', '', 6, 'admin', '2020-04-14 23:41:28', '2020-04-14 22:15:13', 'admin', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `onl_cgform_field` VALUES ('caf5a071f2299c0f9ff2f3038d6d0fc6', '402860816bff91c0016bff91ca7e0002', 'update_by', '更新人', 'update_by', 0, 1, 'string', 100, 0, '', '', '', '', 'text', '', 120, NULL, '0', '', '', 0, 1, 1, 0, 'group', '', '', 11, 'admin', '2019-07-19 18:07:13', '2019-07-17 18:54:33', 'admin', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `onl_cgform_field` VALUES ('cb135c1020f1762e9f7ec5cc49cabf89', '40288183712a997c01712a997c580000', 'flow_id', '流程id', 'flow_id', 0, 1, 'string', 36, 0, '', '', '', '', 'text', '', 120, NULL, '0', '', '', 0, 1, 1, 0, 'group', '', '', 14, 'admin', '2020-03-30 16:48:20', '2020-03-30 16:40:35', 'admin', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `onl_cgform_field` VALUES ('cb33a708b95e19085f8c9001d2d5c64c', 'e9faf717024b4aae95cff224ae9b6d97', 'create_by', '创建人', NULL, 0, 1, 'string', 50, 0, '', '', '', '', 'text', '', 120, NULL, '0', '', '', 0, 0, 0, 0, 'single', '', '', 2, 'admin', '2019-07-03 18:23:49', '2019-07-03 18:22:35', 'admin', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `onl_cgform_field` VALUES ('cb7da49a981a1b0acc5f7e8a0130bdcd', 'd35109c3632c4952a19ecc094943dd71', 'user_code', '用户编码', NULL, 0, 1, 'String', 32, 0, '', '', '', '', 'text', '', 120, NULL, '0', '', '', 0, 1, 0, 0, 'single', '', '', 10, 'admin', '2020-02-23 18:11:41', '2019-05-11 16:26:37', 'admin', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `onl_cgform_field` VALUES ('cb871284e845e26e88242a96fac9c576', '402860816bff91c0016bff91c7010001', 'order_no', '序号', 'order_no', 0, 1, 'int', 10, 0, '', '', '', '', 'text', '', 120, NULL, '0', '', '', 0, 1, 1, 0, 'group', '', '', 6, 'admin', '2019-07-19 18:07:47', '2019-07-17 18:54:32', 'admin', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `onl_cgform_field` VALUES ('cc1ddc1304d3eb5d9a189da0a509ccd0', '32f75e4043ef4070919dbd4337186a3d', 'create_by', '创建人登录名称', NULL, 0, 1, 'string', 50, 0, '', '', '', '', 'text', '', 120, NULL, '0', '', '', 0, 0, 0, 0, 'single', '', '', 1, 'admin', '2019-04-11 10:15:32', '2019-03-27 15:54:49', 'admin', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `onl_cgform_field` VALUES ('ccf2f331af46ddc411b8039dd187621b', '4028839a6de2ebd3016de2ebd3870000', 'price', '单价', 'price', 0, 1, 'double', 10, 2, NULL, NULL, NULL, NULL, 'text', NULL, 120, NULL, '0', NULL, NULL, 0, 1, 1, 0, 'group', NULL, NULL, 10, NULL, NULL, '2019-10-19 15:29:30', 'admin', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `onl_cgform_field` VALUES ('cd33c805fe5d979bbd6da61c2c0a60e5', '402881e970dd8d520170ddb3a6490004', 'customer_id', 'customerId', 'customer_id', 0, 1, 'string', 36, 0, '', '', '', '', 'text', '', 120, NULL, '0', '', '', 0, 1, 1, 0, 'group', '', '', 10, 'admin', '2020-03-16 22:39:53', '2020-03-15 18:18:23', 'admin', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `onl_cgform_field` VALUES ('cd473e56aa24fb74ede9e007329a40e3', '40288183712beaa901712c0ebcb10003', 'code', '编码', 'code', 0, 0, 'string', 50, 0, '', '', '', '', 'text', '', 120, NULL, '0', '', '', 1, 1, 1, 0, 'single', '', '', 2, 'admin', '2020-03-31 00:04:14', '2020-03-30 23:28:16', 'admin', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `onl_cgform_field` VALUES ('cd4a44aa6bbc4bbbeb1596999039e3b3', '402881fe71c8c4fd0171c8c500d30001', 'source_type', '源单类型', 'source_type', 0, 1, 'string', 50, 0, '', 'x_bill_type', '', '', 'list', '', 120, NULL, '0', '', '', 0, 1, 1, 0, 'group', '', '', 5, 'admin', '2020-04-30 10:30:11', '2020-04-30 09:48:07', 'admin', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `onl_cgform_field` VALUES ('cd8f4f37fb2a2101b7f94acdd1fcc2a9', '7a584d85821b482c9a93757cf101fbe6', 'id', '主键', NULL, 1, 0, 'string', 36, 0, '', '', '', '', 'text', '', 120, NULL, '0', '', '', 0, 0, 0, 0, 'single', '', '', 1, 'admin', '2020-02-23 18:18:33', '2020-02-23 17:41:10', 'admin', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `onl_cgform_field` VALUES ('cdf10cbecc945445c470f9bf77eddff1', '40288183712a997c01712a99809e0001', 'discount_amt', '折让金额', 'discount_amt', 0, 1, 'BigDecimal', 18, 2, NULL, NULL, NULL, NULL, 'text', NULL, 120, NULL, '0', NULL, NULL, 0, 1, 1, 0, 'group', NULL, NULL, 18, NULL, NULL, '2020-03-30 16:40:36', 'admin', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `onl_cgform_field` VALUES ('ce04f4655400397d269f761d89d9d9d6', '40288183712beaa901712beaa9a00000', 'create_by', '创建人', 'create_by', 0, 1, 'string', 36, 0, '', 'username', 'sys_user', 'realname', 'list', '', 120, NULL, '0', '', '', 0, 1, 1, 1, 'group', '', '', 23, 'admin', '2020-04-17 12:01:33', '2020-03-30 22:48:52', 'admin', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `onl_cgform_field` VALUES ('ce0f1d91d0a3afec5b48d602c3d6bc19', 'c20b114d92ed45eab356431a624dd12b', 'name', '名称', NULL, 0, 1, 'String', 20, 0, '', '', '', '', 'text', '', 120, NULL, '0', '', '', 0, 1, 1, 0, 'single', '', '', 10, 'admin', '2020-03-20 11:41:31', '2020-03-20 11:29:28', 'admin', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `onl_cgform_field` VALUES ('ce0f2261cfec1339dd5f30aa227f9cb2', '4028818370e8d46b0170e8d46d350001', 'remark', '备注', 'remark', 0, 1, 'string', 50, 0, '', '', '', '', 'text', '', 120, NULL, '0', '', '', 0, 1, 1, 0, 'group', '', '', 22, 'admin', '2020-03-17 22:14:27', '2020-03-17 22:10:01', 'admin', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `onl_cgform_field` VALUES ('ce322b6d5cf6fe26abe9251048c0004b', '402881fe71c8c4fd0171c8c500d30001', 'source_entry_no', '源单分录号', 'source_entry_no', 0, 1, 'string', 50, 0, '', '', '', '', 'text', '', 120, NULL, '0', '', '', 0, 1, 1, 0, 'group', '', '', 7, 'admin', '2020-04-30 10:30:11', '2020-04-30 09:48:07', 'admin', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `onl_cgform_field` VALUES ('cee3c1dbf67b4a7d9626b8032897a4c7', '402860816bff91c0016bff91d8830007', 'employee_id', '员工ID', 'employee_id', 0, 1, 'string', 32, 0, '', '', '', '', 'text', '', 120, NULL, '0', '', '', 0, 1, 1, 0, 'group', 'oa_employee_info', 'id', 2, 'admin', '2019-07-19 18:04:41', '2019-07-17 18:54:37', 'admin', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `onl_cgform_field` VALUES ('cf0b146d3389c4b701fe9567e9daa5e0', '4028818370f5f37d0170f5f37dcf0000', 'version', '版本', 'version', 0, 1, 'int', 10, 0, '', '', '', '', 'text', '', 120, NULL, '0', '', '', 0, 1, 1, 0, 'group', '', '', 13, 'admin', '2020-03-20 12:02:35', '2020-03-20 11:19:01', 'admin', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `onl_cgform_field` VALUES ('cf4c5a4c06ae6bac701edfeedfcd16aa', 'd3ae1c692b9640e0a091f8c46e17bb01', 'id', '主键', NULL, 1, 0, 'string', 36, 0, '', '', '', '', 'text', '', 120, NULL, '0', '', '', 0, 0, 0, 0, 'single', '', '', 1, NULL, NULL, '2019-07-24 14:47:30', 'admin', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `onl_cgform_field` VALUES ('cfeb6491427aec2b4db9694af867da23', 'e9faf717024b4aae95cff224ae9b6d97', 'create_time', '创建日期', NULL, 0, 1, 'Date', 20, 0, '', '', '', '', 'datetime', '', 120, NULL, '0', '', '', 0, 0, 0, 0, 'single', '', '', 3, 'admin', '2019-07-03 18:23:49', '2019-07-03 18:22:35', 'admin', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `onl_cgform_field` VALUES ('d0059b0dff8001973e8d8ea521c9fdfe', '4028818370f5f37d0170f5f37dcf0000', 'update_time', '修改时间', 'update_time', 0, 1, 'Date', 0, 0, '', '', '', '', 'date', '', 120, NULL, '0', '', '', 0, 1, 1, 0, 'group', '', '', 12, 'admin', '2020-03-20 12:02:35', '2020-03-20 11:19:01', 'admin', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `onl_cgform_field` VALUES ('d04240d9bd3efe15b9b23ac85f4d3324', '4028818370e8d46b0170e8d46d350001', 'tax', '税额', 'tax', 0, 1, 'BigDecimal', 18, 2, '', '', '', '', 'text', '', 120, NULL, '0', '', '', 0, 1, 1, 0, 'group', '', '', 16, 'admin', '2020-03-17 22:14:27', '2020-03-17 22:10:01', 'admin', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `onl_cgform_field` VALUES ('d0934075ef2f2d5dff3771e47d38bd82', '7a584d85821b482c9a93757cf101fbe6', 'update_time', '更新日期', NULL, 0, 1, 'Date', 20, 0, '', '', '', '', 'datetime', '', 120, NULL, '0', '', '', 0, 0, 0, 0, 'single', '', '', 5, 'admin', '2020-02-23 18:18:33', '2020-02-23 17:41:10', 'admin', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `onl_cgform_field` VALUES ('d0bbeeac40e360a0787e4b7464ae0fff', '402881017185937c0171859381700002', 'entry_no', '分录号', 'entry_no', 0, 0, 'int', 10, 0, '', '', '', '', 'text', '', 120, NULL, '0', '', '', 0, 1, 1, 0, 'group', '', '', 3, 'admin', '2020-04-18 17:11:30', '2020-04-17 08:39:29', 'admin', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `onl_cgform_field` VALUES ('d15a22a55d61955cecef384269089f84', '40288101717185240171718524d60000', 'flow_id', '流程id', 'flow_id', 0, 1, 'string', 36, 0, '', '', '', '', 'text', '', 120, NULL, '0', '', '', 0, 1, 1, 0, 'group', '', '', 12, 'admin', '2020-04-13 14:00:53', '2020-04-13 11:11:24', 'admin', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `onl_cgform_field` VALUES ('d1f84bbd67715c178a5793f3aa3ab497', '40288183712beaa901712beaad3c0001', 'unit_id', '计量单位', 'unit_id', 0, 1, 'string', 36, 0, '', 'id', 'bas_measure_unit', 'name', 'list', '', 120, NULL, '0', '', '', 0, 1, 1, 0, 'group', '', '', 7, 'admin', '2020-05-04 21:41:29', '2020-03-30 22:48:53', 'admin', '', '', '', '', '', NULL, '0', NULL, NULL, '0');
INSERT INTO `onl_cgform_field` VALUES ('d2551b70dc96a45a73b304bf755a996f', '402860816bff91c0016bff91d8830007', 'workplace', '工作单位', 'workplace', 0, 1, 'string', 255, 0, '', '', '', '', 'text', '', 120, NULL, '0', '', '', 0, 1, 1, 0, 'group', '', '', 6, 'admin', '2019-07-19 18:04:41', '2019-07-17 18:54:37', 'admin', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `onl_cgform_field` VALUES ('d2713220e66804d4301f4bced4956a25', '4028818370f308e90170f308eabf0001', 'fullname', '全名', 'fullname', 0, 1, 'string', 100, 0, '', '', '', '', 'text', '', 120, NULL, '0', '', '', 0, 1, 1, 0, 'group', '', '', 6, 'admin', '2020-05-29 20:32:59', '2020-03-19 21:43:33', 'admin', '', '', '', '', '', NULL, '0', NULL, NULL, '0');
INSERT INTO `onl_cgform_field` VALUES ('d29dcdba14ea61808391fff2d927efea', '402860816bff91c0016bff91c0cb0000', 'work_summary', '工作总结', 'work_summary', 0, 1, 'Text', 65535, 0, '', '', '', '', 'textarea', '', 120, NULL, '0', '', '', 0, 1, 1, 0, 'group', '', '', 10, 'admin', '2019-07-19 18:09:01', '2019-07-17 18:54:32', 'admin', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `onl_cgform_field` VALUES ('d2bfefcb4cf240976a68029fc4e87c5a', '402881fe72362af70172362af7150000', 'is_rubric', '是否红字', 'is_rubric', 0, 0, 'int', 3, 0, '', 'yn', '', '', 'list', '', 120, NULL, '0', '', '', 0, 1, 1, 0, 'single', '', '', 6, 'admin', '2020-05-21 20:19:56', '2020-05-21 15:38:06', 'admin', '', '', '', '', '', NULL, '0', NULL, NULL, '0');
INSERT INTO `onl_cgform_field` VALUES ('d3380db92b3aaa5f7accbabc7f1d0f05', '402881017185937c017185937c100000', 'create_by', '创建人', 'create_by', 0, 1, 'string', 36, 0, '', 'username', 'sys_user', 'realname', 'text', '', 120, NULL, '0', '', '', 0, 1, 1, 1, 'group', '', '', 16, 'admin', '2020-04-17 11:31:14', '2020-04-17 08:39:28', 'admin', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `onl_cgform_field` VALUES ('d339915c21a31c3322abf82c5ce254d8', '4028818370e8d46b0170e8d46d350001', 'invocied_amt', '已开票金额', 'invocied_amt', 0, 1, 'BigDecimal', 18, 2, '', '', '', '', 'text', '', 120, NULL, '0', '', '', 0, 1, 1, 0, 'group', '', '', 21, 'admin', '2020-03-17 22:14:27', '2020-03-17 22:10:01', 'admin', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `onl_cgform_field` VALUES ('d34e738e850b2517555905bc0130c1f1', '4028818371790b3f0171790b43ac0001', 'source_entry_id', '源单分录', 'source_entry_id', 0, 1, 'string', 36, 0, '', '', '', '', 'text', '', 120, NULL, '0', '', '', 0, 1, 1, 0, 'group', '', '', 3, 'admin', '2020-04-14 23:25:38', '2020-04-14 22:15:14', 'admin', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `onl_cgform_field` VALUES ('d365e11a3b53b54f8c01e83003837b7f', '402881e970dd8d520170dd90f7c30002', 'settle_amt', 'settleAmt', 'settle_amt', 0, 1, 'BigDecimal', 18, 2, '', '', '', '', 'text', '', 120, NULL, '0', '', '', 0, 1, 1, 0, 'group', '', '', 19, 'admin', '2020-03-15 21:40:40', '2020-03-15 17:40:31', 'admin', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `onl_cgform_field` VALUES ('d374a9735bad55e8f486113815fa361b', '40288101710a4c6201710a60ad5e0001', 'create_time', '创建时间', 'create_time', 0, 1, 'Date', 0, 0, '', '', '', '', 'date', '', 120, NULL, '0', '', '', 0, 1, 1, 1, 'group', '', '', 9, 'admin', '2020-03-28 09:52:10', '2020-03-24 10:30:41', 'admin', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `onl_cgform_field` VALUES ('d3a701472d27ca8435d6a781a597038d', 'deea5a8ec619460c9245ba85dbc59e80', 'create_time', '创建日期', NULL, 0, 1, 'Date', 20, 0, '', '', '', '', 'datetime', '', 120, NULL, '0', '', '', 0, 0, 0, 0, 'single', '', '', 3, 'admin', '2020-03-15 17:37:15', '2019-04-20 11:41:19', 'admin', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `onl_cgform_field` VALUES ('d3d5bd00f9853f4d9073e220c6ed4f07', '4028818370f308e90170f308e9080000', 'sale_price', '销售价格', 'sale_price', 0, 1, 'BigDecimal', 18, 2, '', '', '', '', 'text', '', 120, 'money', '0', '', '', 0, 1, 1, 0, 'group', '', '', 8, 'admin', '2020-05-30 11:58:17', '2020-03-19 21:43:33', 'admin', '', '', '', '', '', NULL, '0', NULL, NULL, '0');
INSERT INTO `onl_cgform_field` VALUES ('d400dbb67926400e9782ec6292678951', '402881e970dd8d520170dd90f7c30002', 'unit_id', 'unitId', 'unit_id', 0, 1, 'string', 36, 0, '', '', '', '', 'text', '', 120, NULL, '0', '', '', 0, 1, 1, 0, 'group', '', '', 6, 'admin', '2020-03-15 21:40:40', '2020-03-15 17:40:31', 'admin', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `onl_cgform_field` VALUES ('d44b89cc5f1828f7ceb9be196d549665', '4fb8e12a697f4d5bbe9b9fb1e9009486', 'code', '编码', NULL, 0, 1, 'String', 200, 0, '', '', '', '', 'text', '', 120, NULL, '0', '', '${order_num_rule_param}', 0, 1, 1, 0, 'single', '', '', 2, 'admin', '2020-04-10 19:51:27', '2020-04-10 19:47:01', 'admin', '', '', '', '', '', NULL, '0', NULL, NULL, '0');
INSERT INTO `onl_cgform_field` VALUES ('d480c2f581b73ed68e6c8fe5525331bf', '871c2df1185c4c8e80377d3c319c9a1e', 'update_time', '更新日期', NULL, 0, 1, 'Date', 20, 0, '', '', '', '', 'datetime', '', 120, NULL, '0', '', '', 0, 0, 0, 0, 'single', '', '', 5, NULL, NULL, '2020-03-20 11:42:58', 'admin', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `onl_cgform_field` VALUES ('d48bfd2a840f9b1d00bd3b5599dca0f0', '402860816bff91c0016bff91cda80003', 'post', '职务', 'post', 0, 1, 'string', 100, 0, '', '', '', '', 'text', '', 120, NULL, '0', '', '', 0, 1, 1, 0, 'group', '', '', 7, 'admin', '2019-07-19 18:06:36', '2019-07-17 18:54:34', 'admin', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `onl_cgform_field` VALUES ('d4d8cae3cd9ea93e378fc14303eee105', 'd35109c3632c4952a19ecc094943dd71', 'create_by', '创建人登录名称', NULL, 0, 1, 'string', 50, 0, '', '', '', '', 'text', '', 120, '', '0', '', '', 0, 0, 0, 0, 'single', '', '', 1, 'admin', '2020-02-23 18:11:41', '2019-03-15 14:24:35', 'admin', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `onl_cgform_field` VALUES ('d4dea775487aef5a7aea41791d3a65db', 'e5464aa8fa7b47c580e91593cf9b46dc', 'cycle_time', '发放周期(年)', NULL, 0, 1, 'String', 32, 0, '', '', '', '', 'text', '', 120, NULL, '0', '', '', 0, 1, 1, 0, 'single', '', '', 11, 'admin', '2019-04-24 17:09:49', '2019-04-24 14:09:06', 'admin', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `onl_cgform_field` VALUES ('d4efab4f8c364c9f35c693d4f1661e1e', '402881017185937c017185937f430001', 'version', '版本', 'version', 0, 1, 'int', 10, 0, '', '', '', '', 'text', '', 120, NULL, '0', '', '', 0, 0, 0, 0, 'group', '', '', 8, 'admin', '2020-04-18 17:08:51', '2020-04-17 08:39:29', 'admin', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `onl_cgform_field` VALUES ('d51a86ccac2e2cc713bfcac13ac53b7b', '402881fe71c8c4fd0171c8c500d30001', 'remark', '备注', 'remark', 0, 1, 'string', 50, 0, '', '', '', '', 'text', '', 120, NULL, '0', '', '', 0, 1, 1, 0, 'group', '', '', 11, 'admin', '2020-04-30 10:30:12', '2020-04-30 09:48:07', 'admin', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `onl_cgform_field` VALUES ('d52c79620e21128fb69b4e8628cf25cc', 'dbf4675875e14676a3f9a8b2b8941140', 'sys_org_code', '所属部门', NULL, 0, 1, 'string', 64, 0, '', '', '', '', 'text', '', 120, NULL, '0', '', '', 0, 0, 0, 0, 'single', '', '', 6, NULL, NULL, '2019-05-27 18:02:07', 'admin', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `onl_cgform_field` VALUES ('d530ab1bc3c51e8249a506a25d1003c7', '79091e8277c744158530321513119c68', 'start_time', '会签发起时间', NULL, 0, 1, 'Date', 32, 0, '', '', '', '', 'date', '', 120, NULL, '0', '', '', 0, 1, 1, 0, 'single', '', '', 7, 'admin', '2019-05-11 15:29:47', '2019-05-11 15:27:17', 'admin', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `onl_cgform_field` VALUES ('d53e70411c206efecb8dcd00174e907c', '62e29cdb81ac44d1a2d8ff89851b853d', 'create_time', '创建日期', NULL, 0, 1, 'Date', 20, 0, '', '', '', '', 'datetime', '', 120, NULL, '0', '', '', 0, 0, 0, 0, 'single', '', '', 3, NULL, NULL, '2019-05-11 14:01:14', 'admin', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `onl_cgform_field` VALUES ('d5ccc7c306e523f96ca32ef0f88cb9fc', '7a584d85821b482c9a93757cf101fbe6', 'create_by', '创建人', NULL, 0, 1, 'string', 50, 0, '', '', '', '', 'text', '', 120, NULL, '0', '', '', 0, 0, 0, 0, 'single', '', '', 2, 'admin', '2020-02-23 18:18:33', '2020-02-23 17:41:10', 'admin', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `onl_cgform_field` VALUES ('d5d8acda9ec57a4e0ea4955daba3916b', '4028818370f5f37d0170f5f37dcf0000', 'id', 'ID', 'id', 1, 0, 'string', 36, 0, '', '', '', '', 'text', '', 120, NULL, '0', '', '', 0, 0, 0, 0, 'group', '', '', 1, 'admin', '2020-03-20 12:02:35', '2020-03-20 11:19:01', 'admin', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `onl_cgform_field` VALUES ('d5dd343a7cc9899e69a8312ec82f8531', '402881fe71c8c4fd0171c8c500d30001', 'remark3', '备注3', 'remark3', 0, 1, 'string', 50, 0, '', '', '', '', 'text', '', 120, NULL, '0', '', '', 0, 1, 1, 0, 'group', '', '', 13, 'admin', '2020-04-30 10:30:12', '2020-04-30 09:48:07', 'admin', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `onl_cgform_field` VALUES ('d5df0a35352ee960053686e959e9084b', '1acb6f81a1d9439da6cc4e868617b565', 'wl_unit', '计量单位', NULL, 0, 1, 'String', 100, 0, '', 'air_china_unit', '', '', 'list_multi', '', 120, NULL, '0', '', '', 0, 1, 1, 0, 'single', '', '', 8, 'admin', '2019-06-10 14:47:14', '2019-04-23 22:58:19', 'admin', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `onl_cgform_field` VALUES ('d62c18ac5b6fbe5abf0e1a591049057d', '4028818370f308e90170f330ff050003', 'name', '名称', 'name', 0, 1, 'string', 20, 0, '', '', '', '', 'text', '', 120, NULL, '0', '', '', 0, 1, 1, 0, 'group', '', '', 2, 'admin', '2020-03-19 22:35:29', '2020-03-19 22:27:20', 'admin', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `onl_cgform_field` VALUES ('d67bbd0b5ca6e438a7f4a5a847550c6d', '402881017185937c017185937c100000', 'is_voided', '是否作废', 'is_voided', 0, 0, 'int', 3, 0, '', 'yn', '', '', 'list', '', 120, NULL, '0', '', '', 0, 1, 1, 1, 'group', '', '', 11, 'admin', '2020-04-17 11:31:14', '2020-04-17 08:39:28', 'admin', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `onl_cgform_field` VALUES ('d6acba2954051a4dce31ed952d4c2fc3', '402881fe71c8c4fd0171c8c4fdae0000', 'deducted_amt', '已抵扣预收金额', 'deducted_amt', 0, 0, 'BigDecimal', 18, 2, '', '', '', '', 'text', '', 120, NULL, '0', '', '', 0, 1, 1, 0, 'group', '', '', 8, 'admin', '2020-04-30 10:23:44', '2020-04-30 09:48:06', 'admin', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `onl_cgform_field` VALUES ('d6fad89f4f26d733291863c2dfbc5945', '27fc5f91274344afa7673a732b279939', 'id', '主键', NULL, 1, 0, 'string', 36, 0, '', '', '', '', 'text', '', 120, NULL, '0', '', '', 0, 0, 0, 0, 'single', '', '', 1, 'admin', '2019-07-01 16:28:20', '2019-07-01 16:26:42', 'admin', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `onl_cgform_field` VALUES ('d72cfe5b984cfad31c0a28b5c816590c', '402881fe71c8c4fd0171c8c503230002', 'update_by', '修改人', 'update_by', 0, 1, 'string', 36, 0, '', 'username', 'sys_user', 'realname', 'list', '', 120, NULL, '0', '', '', 0, 1, 1, 1, 'group', '', '', 22, 'admin', '2020-04-30 10:30:53', '2020-04-30 09:48:07', 'admin', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `onl_cgform_field` VALUES ('d742dc4b1662e14cfd70d3465d7533eb', '402881e970dd8d520170ddb3a6490004', 'version', 'version', 'version', 0, 1, 'int', 10, 0, '', '', '', '', 'text', '', 120, NULL, '0', '', '', 0, 1, 1, 0, 'group', '', '', 26, 'admin', '2020-03-16 22:39:53', '2020-03-15 18:18:23', 'admin', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `onl_cgform_field` VALUES ('d74fb18d990129473bb55413968fe662', '402881e970dd8d520170dd90f7c30002', 'batch_no', 'batchNo', 'batch_no', 0, 1, 'string', 100, 0, '', '', '', '', 'text', '', 120, NULL, '0', '', '', 0, 1, 1, 0, 'group', '', '', 9, 'admin', '2020-03-15 21:40:40', '2020-03-15 17:40:31', 'admin', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `onl_cgform_field` VALUES ('d766ea5809e2ec9ff2cdbcb18f610ab3', '7ea60a25fa27470e9080d6a921aabbd1', 'id', '主键', NULL, 1, 0, 'string', 36, 0, '', '', '', '', 'text', '', 120, NULL, '0', '', '', 0, 0, 0, 0, 'single', '', '', 1, NULL, NULL, '2019-04-17 00:22:21', 'admin', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `onl_cgform_field` VALUES ('d7c3b107f004cbc99dfe1fe6c79894d8', '402860816bff91c0016bffa220a9000b', 'social_insurance_type', '参加社保类型', 'social_insurance_type', 0, 1, 'string', 255, 0, '', '', '', '', 'text', '', 120, NULL, '0', '', '', 0, 1, 1, 0, 'group', '', '', 35, 'admin', '2019-07-22 16:15:32', '2019-07-17 19:12:24', 'admin', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `onl_cgform_field` VALUES ('d7cd618fe7fc3b278c600f4734475978', '40288183712beaa901712beaad3c0001', 'discount_amt', '折让金额', 'discount_amt', 0, 1, 'BigDecimal', 18, 2, '', '', '', '', 'text', '', 120, NULL, '0', '', '', 0, 1, 1, 0, 'group', '', '', 19, 'admin', '2020-05-04 21:41:29', '2020-03-30 22:48:53', 'admin', '', '', '', '', '', NULL, '0', NULL, NULL, '0');
INSERT INTO `onl_cgform_field` VALUES ('d81db163a29e6311f20edae32f6d5a7b', '40288101717185240171718524d60000', 'effective_time', '生效时间', 'effective_time', 0, 1, 'Date', 0, 0, '', '', '', '', 'date', '', 120, NULL, '0', '', '', 0, 1, 1, 0, 'group', '', '', 14, 'admin', '2020-04-13 14:00:53', '2020-04-13 11:11:24', 'admin', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `onl_cgform_field` VALUES ('d8234b56acea1a752271a6c911dd91a0', '7ea60a25fa27470e9080d6a921aabbd1', 'age', '年龄', NULL, 0, 1, 'String', 32, 0, '', '', '', '', 'text', '', 120, NULL, '0', '', '', 0, 1, 1, 0, 'single', '', '', 7, NULL, NULL, '2019-04-17 00:22:21', 'admin', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `onl_cgform_field` VALUES ('d86909d794b01ad7fbb5e61d28b6603b', '73162c3b8161413e8ecdca7eb288d0c9', 'sys_org_code', '所属部门', NULL, 0, 1, 'string', 64, 0, '', '', '', '', 'text', '', 120, NULL, '0', '', '', 0, 0, 0, 0, 'single', '', '', 6, 'admin', '2019-07-01 14:23:32', '2019-06-10 15:18:34', 'admin', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `onl_cgform_field` VALUES ('d8f48403a0ee057ef12b5d7de387293d', '40288183712beaa901712c0eb77c0002', 'code', '编码', 'code', 0, 0, 'string', 50, 0, '', '', '', '', 'text', '', 120, NULL, '0', '', '', 1, 1, 1, 0, 'single', '', '', 2, 'admin', '2020-03-31 00:15:25', '2020-03-30 23:28:15', 'admin', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `onl_cgform_field` VALUES ('d949d9157831c2fb7ba9f175081fe036', '402860816bff91c0016bff91cda80003', 'school', '学校', 'school', 0, 1, 'string', 100, 0, '', '', '', '', 'text', '', 120, NULL, '0', '', '', 0, 1, 1, 0, 'group', '', '', 5, 'admin', '2019-07-19 18:06:36', '2019-07-17 18:54:34', 'admin', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `onl_cgform_field` VALUES ('d9d308feb95968dbb322c9bff0c18452', '32feeb502544416c9bf41329c10a88f4', 'update_by', '更新人', NULL, 0, 1, 'string', 50, 0, '', '', '', '', 'text', '', 120, NULL, '0', '', '', 0, 0, 0, 0, 'single', '', '', 4, 'admin', '2019-08-23 20:03:40', '2019-07-02 18:23:23', 'admin', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `onl_cgform_field` VALUES ('d9dde2f59bb148c6b7e95256acad8972', 'e67d26b610dd414c884c4dbb24e71ce3', 'post_name', '岗位名字', NULL, 0, 1, 'String', 32, 0, '', '', '', '', 'text', '', 120, NULL, '0', '', '', 0, 1, 1, 0, 'single', '', '', 7, 'admin', '2019-04-24 11:03:32', '2019-04-24 11:02:57', 'admin', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `onl_cgform_field` VALUES ('d9f9ae6986cb85019a3a4030f62f4d1a', '402860816bff91c0016bff91cfea0004', 'employee_id', '员工ID', 'employee_id', 0, 1, 'string', 32, 0, '', '', '', '', 'text', '', 120, NULL, '0', '', '', 0, 1, 1, 0, 'group', 'oa_employee_info', 'id', 2, 'admin', '2019-07-19 18:05:13', '2019-07-17 18:54:35', 'admin', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `onl_cgform_field` VALUES ('da2791ac3d8adfad1e00ab353841fe3d', '4028818370e8d46b0170e8d46d350001', 'warehouse_id', '仓库', 'warehouse_id', 0, 1, 'string', 36, 0, '', '', '', '', 'text', '', 120, NULL, '0', '', '', 0, 1, 1, 0, 'group', '', '', 8, 'admin', '2020-03-17 22:14:27', '2020-03-17 22:10:01', 'admin', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `onl_cgform_field` VALUES ('da5c495643148594efb8aeb9b2953b49', '4028818370f5f37d0170f5f37dcf0000', 'update_by', '修改人', 'update_by', 0, 1, 'string', 36, 0, '', '', '', '', 'text', '', 120, NULL, '0', '', '', 0, 1, 1, 0, 'group', '', '', 11, 'admin', '2020-03-20 12:02:35', '2020-03-20 11:19:01', 'admin', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `onl_cgform_field` VALUES ('db076899c65c769bdbc6e6205dd342f0', '402881ea71684fa00171684fa0680000', 'is_closed', '是否关闭', 'is_closed', 0, 0, 'int', 3, 0, '', 'yn', '', '', 'list', '', 80, NULL, '0', '', '', 1, 1, 1, 0, 'single', '', '', 9, 'admin', '2020-04-11 16:28:45', '2020-04-11 16:16:22', 'admin', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `onl_cgform_field` VALUES ('db1fb3e12385cb967b63420cfe97cde6', '402860816bff91c0016bff91cda80003', 'employee_id', '员工ID', 'employee_id', 0, 1, 'string', 32, 0, '', '', '', '', 'text', '', 120, NULL, '0', '', '', 0, 1, 1, 0, 'group', 'oa_employee_info', 'id', 2, 'admin', '2019-07-19 18:06:36', '2019-07-17 18:54:34', 'admin', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `onl_cgform_field` VALUES ('db3edf4adfa1a7b09dddfd560bd20484', '402881fe72268ef10172268ef1370000', 'bill_proc_status', '处理状态', 'bill_proc_status', 0, 1, 'string', 4, 0, '', 'x_bill_proc_status', '', '', 'list', '', 120, NULL, '0', '', '', 0, 1, 1, 0, 'single', '', '', 9, 'admin', '2020-05-18 15:50:07', '2020-05-18 14:53:22', 'admin', '', '', '', '', '', NULL, '0', NULL, NULL, '0');
INSERT INTO `onl_cgform_field` VALUES ('dc2bec862a4f0d600751c632d246f0ed', '4028839a6de2ebd3016de2ebd3870000', 'update_time', '更新日期', 'update_time', 0, 1, 'Date', 0, 0, NULL, NULL, NULL, NULL, 'date', NULL, 120, NULL, '0', NULL, NULL, 0, 1, 1, 0, 'group', NULL, NULL, 5, NULL, NULL, '2019-10-19 15:29:30', 'admin', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `onl_cgform_field` VALUES ('dd3e1e13d7429807b83a00a090e060b7', '402860816bff91c0016bffa220a9000b', 'join_party_info', '入党（团）时间地点', 'join_party_info', 0, 1, 'string', 255, 0, '', '', '', '', 'text', '', 120, NULL, '0', '', '', 0, 1, 1, 0, 'group', '', '', 26, 'admin', '2019-07-22 16:15:32', '2019-07-17 19:12:24', 'admin', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `onl_cgform_field` VALUES ('dd666656e78590a97870f7092caa96a5', '4028818370f5f37d0170f5f37dcf0000', 'code', '编码', 'code', 0, 0, 'string', 50, 0, '', '', '', '', 'text', '', 120, NULL, '0', '', '', 0, 1, 1, 0, 'group', '', '', 5, 'admin', '2020-03-20 12:02:35', '2020-03-20 11:19:01', 'admin', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `onl_cgform_field` VALUES ('ddc302f84c75a5f056855c664b82202a', '402860816aa5921f016aa5921f480000', 'days', '请假天数', 'days', 0, 1, 'int', 10, 0, '', '', '', '', 'text', '', 120, NULL, '0', '', '', 0, 1, 1, 0, 'group', '', '', 3, 'admin', '2019-05-11 15:31:54', '2019-05-11 14:26:19', 'admin', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `onl_cgform_field` VALUES ('ddcc14a2105588982b4ae657f2893d81', '32feeb502544416c9bf41329c10a88f4', 'id', '主键', NULL, 1, 0, 'string', 36, 0, '', '', '', '', 'text', '', 120, NULL, '0', '', '', 0, 0, 0, 0, 'single', '', '', 1, 'admin', '2019-08-23 20:03:40', '2019-07-02 18:23:23', 'admin', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `onl_cgform_field` VALUES ('de40b787125621d80389b8e1b77cbf47', '40288183712a997c01712a99809e0001', 'material_id', '物料', 'material_id', 0, 0, 'string', 36, 0, NULL, NULL, NULL, NULL, 'text', NULL, 120, NULL, '0', NULL, NULL, 0, 1, 1, 0, 'group', NULL, NULL, 5, NULL, NULL, '2020-03-30 16:40:36', 'admin', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `onl_cgform_field` VALUES ('de731001ecc515f9e88d116eeaa425e1', '4028818370f5f37d0170f5f37dcf0000', 'name', '名称', 'name', 0, 0, 'string', 50, 0, '', '', '', '', 'text', '', 120, NULL, '0', '', '', 0, 1, 1, 0, 'group', '', '', 6, 'admin', '2020-03-20 12:02:35', '2020-03-20 11:19:01', 'admin', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `onl_cgform_field` VALUES ('de740416c5320ca05730eed5aafb94d6', '4028818370e8d46b0170e8d46b4b0000', 'approver_id', '审核人', 'approver_id', 0, 1, 'string', 36, 0, '', '', '', '', 'text', '', 120, NULL, '0', '', '', 0, 1, 1, 0, 'group', '', '', 14, 'admin', '2020-03-19 10:25:32', '2020-03-17 22:10:01', 'admin', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `onl_cgform_field` VALUES ('dedb920a5e876e27eb144464209ebe1e', '27fc5f91274344afa7673a732b279939', 'sys_org_code', '所属部门', NULL, 0, 1, 'string', 64, 0, '', '', '', '', 'text', '', 120, NULL, '0', '', '', 0, 0, 0, 0, 'single', '', '', 6, 'admin', '2019-07-01 16:28:20', '2019-07-01 16:26:42', 'admin', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `onl_cgform_field` VALUES ('deedd7d1b56e03a6030f3329fb1c5e43', '40288101717185240171718524d60000', 'is_approved', '是否通过', 'is_approved', 0, 0, 'int', 3, 0, '', 'yn', '', '', 'list', '', 120, NULL, '0', '', '', 1, 1, 1, 0, 'single', '', '', 13, 'admin', '2020-04-13 14:00:53', '2020-04-13 11:11:24', 'admin', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `onl_cgform_field` VALUES ('df489194c6008f3bd21b2c1c11fde337', 'fb19fb067cd841f9ae93d4eb3b883dc0', 'create_time', '创建日期', NULL, 0, 1, 'Date', 20, 0, '', '', '', '', 'text', '', 120, '', '0', '', '', 0, 1, 1, 0, 'single', '', '', 2, NULL, NULL, '2019-03-23 11:39:48', 'admin', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `onl_cgform_field` VALUES ('df58a7b1c3ed8f58a1994c0c0855db16', '4adec929a6594108bef5b35ee9966e9f', 'sys_org_code', '所属部门', NULL, 0, 1, 'string', 64, 0, '', '', '', '', 'text', '', 120, NULL, '0', '', '', 0, 0, 0, 0, 'single', '', '', 11, 'admin', '2020-04-10 19:43:38', '2020-04-10 19:35:58', 'admin', '', '', '', '', '', 'text', '0', NULL, NULL, '0');
INSERT INTO `onl_cgform_field` VALUES ('dfe572dda00334a7b233544c75b956cb', '40288183712beaa901712beaad3c0001', 'settle_qty', '结算数量', 'settle_qty', 0, 1, 'BigDecimal', 18, 6, '', '', '', '', 'text', '', 120, NULL, '0', '', '', 0, 1, 1, 0, 'group', '', '', 14, 'admin', '2020-05-04 21:41:29', '2020-03-30 22:48:53', 'admin', '', '', '', '', '', NULL, '0', NULL, NULL, '0');
INSERT INTO `onl_cgform_field` VALUES ('dff30e46194932f778577b4fc6e4ee76', '402881e970dd8d520170dd90f7c30002', 'other_cost', '其他成本', 'other_cost', 0, 1, 'BigDecimal', 18, 2, '', '', '', '', 'text', '', 120, NULL, '0', '', '', 0, 1, 1, 0, 'group', '', '', 11, 'admin', '2020-03-15 21:40:40', '2020-03-15 17:40:31', 'admin', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `onl_cgform_field` VALUES ('e0b144fbb65371896e98a092636a4a59', '402881fe724af1fc01724af1feaf0001', 'rp_type', '往来类型', 'type', 0, 0, 'string', 4, 0, '', 'x_rp_type', '', '', 'list', '', 120, NULL, '0', '', '', 1, 1, 1, 0, 'single', '', '', 4, 'admin', '2020-05-25 16:38:12', '2020-05-25 16:27:53', 'admin', '', '', '', '', '', NULL, '0', NULL, NULL, '0');
INSERT INTO `onl_cgform_field` VALUES ('e0c5d6e483897d5c4e7894dc66dd1aff', '32feeb502544416c9bf41329c10a88f4', 'bpm_status', '流程状态', NULL, 0, 1, 'String', 2, 0, '', 'bpm_status', '', '', 'list', '', 120, NULL, '0', '', '', 0, 1, 1, 0, 'single', '', '', 9, 'admin', '2019-08-23 20:03:40', '2019-07-02 18:23:58', 'admin', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `onl_cgform_field` VALUES ('e14225f34412a624c2d1dfcfd320072d', '40288183712a997c01712a99809e0001', 'source_entry_id', '源单分录', 'source_entry_id', 0, 1, 'string', 36, 0, NULL, NULL, NULL, NULL, 'text', NULL, 120, NULL, '0', NULL, NULL, 0, 1, 1, 0, 'group', NULL, NULL, 3, NULL, NULL, '2020-03-30 16:40:36', 'admin', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `onl_cgform_field` VALUES ('e1a4126d67dfaebda4e970629d01cbee', '402881017185937c017185937c100000', 'is_approved', '是否通过', 'is_approved', 0, 0, 'int', 3, 0, '', 'yn', '', '', 'list', '', 120, NULL, '0', '', '', 0, 1, 1, 1, 'group', '', '', 9, 'admin', '2020-04-17 11:31:14', '2020-04-17 08:39:28', 'admin', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `onl_cgform_field` VALUES ('e1d04d1d55aad1266d9132dea7580fa2', '40288183712beaa901712c0ebcb10003', 'bank_invoice', '开票信息开户行', 'bank_invoice', 0, 1, 'string', 200, 0, '', '', '', '', 'text', '', 120, NULL, '0', '', '', 0, 1, 0, 0, 'group', '', '', 19, 'admin', '2020-03-31 00:04:14', '2020-03-30 23:28:16', 'admin', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `onl_cgform_field` VALUES ('e21c9637b3c55191959e4a7cd80d9b93', '402881017185937c017185937f430001', 'bill_type', '单据类型', 'bill_type', 0, 0, 'string', 20, 0, '', 'x_bill_type', '', '', 'list', '', 120, NULL, '0', '', '', 0, 1, 1, 1, 'group', '', '', 4, 'admin', '2020-04-18 17:08:51', '2020-04-17 08:39:29', 'admin', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `onl_cgform_field` VALUES ('e24de426223dc0271a55eccc1d5457d0', '73162c3b8161413e8ecdca7eb288d0c9', 'create_by', '创建人', NULL, 0, 1, 'string', 50, 0, '', '', '', '', 'text', '', 120, NULL, '0', '', '', 0, 0, 0, 0, 'single', '', '', 2, 'admin', '2019-07-01 14:23:32', '2019-06-10 15:18:34', 'admin', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `onl_cgform_field` VALUES ('e2a3cfba400912add7407f4d3f02511c', '40288183712a997c01712a99809e0001', 'is_incl_tax', '成本是否含税', 'is_incl_tax', 0, 1, 'int', 3, 0, NULL, NULL, NULL, NULL, 'text', NULL, 120, NULL, '0', NULL, NULL, 0, 1, 1, 0, 'group', NULL, NULL, 12, NULL, NULL, '2020-03-30 16:40:36', 'admin', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `onl_cgform_field` VALUES ('e2d73ccda7f10f5a1ccce3c48b1e699e', '402860816bff91c0016bffa220a9000b', 'residence_street', '户口所在街道', 'residence_street', 0, 1, 'string', 100, 0, '', '', '', '', 'text', '', 120, NULL, '0', '', '', 0, 1, 1, 0, 'group', '', '', 27, 'admin', '2019-07-22 16:15:32', '2019-07-17 19:12:24', 'admin', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `onl_cgform_field` VALUES ('e2da51d1ca995242e6fb5f566db381d4', '4028818370f308e90170f308eabf0001', 'update_time', '修改时间', 'update_time', 0, 1, 'Date', 0, 0, '', '', '', '', 'date', '', 120, NULL, '0', '', '', 0, 1, 1, 0, 'group', '', '', 11, 'admin', '2020-05-29 20:32:59', '2020-03-19 21:43:33', 'admin', '', '', '', '', '', NULL, '0', NULL, NULL, '0');
INSERT INTO `onl_cgform_field` VALUES ('e34fdeced9e6e5950a7c3b3f8e4d47d6', '40288183712beaa901712c0ebe7e0004', 'phone', '电话', 'phone', 0, 1, 'string', 50, 0, '', '', '', '', 'text', '', 120, NULL, '0', '', '', 0, 1, 1, 0, 'group', '', '', 6, 'admin', '2020-03-30 23:41:18', '2020-03-30 23:28:16', 'admin', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `onl_cgform_field` VALUES ('e38e9645b7e5d73cb21d142b70008d42', '402881e970dd8d520170ddb3a6490004', 'rubric', 'rubric', 'rubric', 0, 1, 'int', 3, 0, '', '', '', '', 'text', '', 120, NULL, '0', '', '', 0, 1, 1, 0, 'group', '', '', 8, 'admin', '2020-03-16 22:39:53', '2020-03-15 18:18:23', 'admin', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `onl_cgform_field` VALUES ('e41b976df5a1a18af7d42e07381cc267', '402881017185937c017185937f430001', 'id', 'ID', 'id', 1, 0, 'string', 36, 0, '', '', '', '', 'text', '', 120, NULL, '0', '', '', 0, 0, 0, 0, 'group', '', '', 1, 'admin', '2020-04-18 17:08:51', '2020-04-17 08:39:29', 'admin', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `onl_cgform_field` VALUES ('e4914fdff68ac72486ada105e6e9fa36', 'e9faf717024b4aae95cff224ae9b6d97', 'id', '主键', NULL, 1, 0, 'string', 36, 0, '', '', '', '', 'text', '', 120, NULL, '0', '', '', 0, 0, 0, 0, 'single', '', '', 1, 'admin', '2019-07-03 18:23:49', '2019-07-03 18:22:35', 'admin', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `onl_cgform_field` VALUES ('e4a26b220abf043b34d9e8309dc0e903', '40288183712beaa901712c0ebcb10003', 'tax_invoice', '开票信息税号', 'tax_invoice', 0, 1, 'string', 50, 0, '', '', '', '', 'text', '', 120, NULL, '0', '', '', 0, 1, 0, 0, 'group', '', '', 21, 'admin', '2020-03-31 00:04:14', '2020-03-30 23:28:16', 'admin', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `onl_cgform_field` VALUES ('e4a4c1d50b7b46678bc14fd5b90ee082', '73162c3b8161413e8ecdca7eb288d0c9', 'create_time', '创建日期', NULL, 0, 1, 'Date', 20, 0, '', '', '', '', 'datetime', '', 120, NULL, '0', '', '', 0, 0, 0, 0, 'single', '', '', 3, 'admin', '2019-07-01 14:23:32', '2019-06-10 15:18:34', 'admin', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `onl_cgform_field` VALUES ('e4cdaa228d32b12d93567a871916dd81', '40288183712beaa901712c0ebcb10003', 'address_invoice', '开票地址', 'address_invoice', 0, 1, 'string', 200, 0, '', '', '', '', 'text', '', 120, NULL, '0', '', '', 0, 1, 0, 0, 'group', '', '', 24, 'admin', '2020-03-31 00:04:14', '2020-03-30 23:28:16', 'admin', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `onl_cgform_field` VALUES ('e50b4398731e06572c247993a0dcc38d', 'd35109c3632c4952a19ecc094943dd71', 'name', '用户名', NULL, 0, 1, 'string', 200, 0, '', '', '', '', 'text', '', 120, '*', '0', '', '', 0, 1, 1, 0, 'single', '', '', 5, 'admin', '2020-02-23 18:11:41', '2019-03-15 14:24:35', 'admin', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `onl_cgform_field` VALUES ('e519c7a7ddebfe297622ea52b3bd788e', '40288183712beaa901712c0ebe7e0004', 'create_time', '创建时间', 'create_time', 0, 1, 'Date', 0, 0, '', '', '', '', 'date', '', 120, NULL, '0', '', '', 0, 1, 1, 1, 'group', '', '', 10, 'admin', '2020-03-30 23:41:18', '2020-03-30 23:28:16', 'admin', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `onl_cgform_field` VALUES ('e53f53766d1f7718b3ee5eabe105b969', '402860816bff91c0016bffa220a9000b', 'social_insurance_time', '五险一金日期', 'social_insurance_time', 0, 1, 'Date', 0, 0, '', '', '', '', 'date', '', 120, NULL, '0', '', '', 0, 1, 1, 0, 'group', '', '', 38, 'admin', '2019-07-22 16:15:32', '2019-07-17 19:12:24', 'admin', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `onl_cgform_field` VALUES ('e5779e790f8bae5efa0ea1c0a0ea186c', '40288183712beaa901712c0ebcb10003', 'corporate_phone', '法人电话', 'corporate_phone', 0, 1, 'string', 50, 0, '', '', '', '', 'text', '', 120, NULL, '0', '', '', 0, 1, 0, 0, 'group', '', '', 14, 'admin', '2020-03-31 00:04:14', '2020-03-30 23:28:16', 'admin', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `onl_cgform_field` VALUES ('e5cf0b40f7f3f443f1f9cc4324708a7b', '402881017185937c0171859381700002', 'id', 'ID', 'id', 1, 0, 'string', 36, 0, '', '', '', '', 'text', '', 120, NULL, '0', '', '', 0, 0, 0, 0, 'group', '', '', 1, 'admin', '2020-04-18 17:11:30', '2020-04-17 08:39:29', 'admin', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `onl_cgform_field` VALUES ('e5e0f9567eb0a9e95b8d0e7c00440c80', '402881fe72362af70172362af7150000', 'sys_org_code', '创建部门', 'sys_org_code', 0, 1, 'string', 50, 0, '', 'org_code', 'sys_depart', 'depart_name', 'text', '', 120, NULL, '0', '', '', 0, 1, 1, 0, 'single', '', '', 21, 'admin', '2020-05-21 20:19:56', '2020-05-21 15:38:06', 'admin', '', '', '', '', '', NULL, '0', NULL, NULL, '0');
INSERT INTO `onl_cgform_field` VALUES ('e6050753763c226e9ece67065debf65e', '40288101717185240171718524d60000', 'source_id', '源单', 'source_id', 0, 1, 'string', 36, 0, '', '', '', '', 'text', '', 120, NULL, '0', '', '', 0, 1, 1, 0, 'group', '', '', 2, 'admin', '2020-04-13 14:00:53', '2020-04-13 11:11:24', 'admin', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `onl_cgform_field` VALUES ('e672d5974a06d5c37b3b4c94a6f29f96', '4028318169e81b970169e81b97650000', 'request_url', '请求路径', 'request_url', 0, 1, 'string', 255, 0, NULL, NULL, NULL, NULL, 'text', NULL, 120, NULL, '0', NULL, NULL, 0, 1, 1, 0, 'group', NULL, NULL, 9, NULL, NULL, '2019-04-04 19:28:36', 'admin', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `onl_cgform_field` VALUES ('e67d623c7e5c9c7566bd04c7c275c925', '4028818370e8d46b0170e8d46b4b0000', 'rubric', '是否红字', 'rubric', 0, 1, 'int', 3, 0, '', 'code', 'sys_category', 'name', 'list', '', 120, NULL, '0', '', '', 1, 1, 1, 0, 'single', '', '', 8, 'admin', '2020-03-19 10:25:32', '2020-03-17 22:10:01', 'admin', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `onl_cgform_field` VALUES ('e69b00ae65e7e31c4b93e0b106cf29f4', '402881fe71c8c4fd0171c8c503230002', 'bill_date', '单据日期', 'bill_date', 0, 0, 'Date', 0, 0, '', '', '', '', 'date', '', 120, NULL, '0', '', '', 1, 1, 1, 0, 'group', '', '', 3, 'admin', '2020-04-30 10:30:53', '2020-04-30 09:48:07', 'admin', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `onl_cgform_field` VALUES ('e6e8ce8dff8976e4956b4a8934a5cedd', '4028818371790b3f0171795b83bd0003', 'account_no', '账号', 'account_no', 0, 0, 'string', 50, 0, '', '', '', '', 'text', '', 120, NULL, '0', '', '', 0, 1, 1, 0, 'group', '', '', 2, 'admin', '2020-04-14 23:46:44', '2020-04-14 23:42:53', 'admin', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `onl_cgform_field` VALUES ('e6fb55e2e7efd2565df0f3633491323c', '4028818370f308e90170f308eabf0001', 'code', '编码', 'code', 0, 0, 'string', 50, 0, '', '', '', '', 'text', '', 120, NULL, '0', '', '', 1, 1, 1, 0, 'single', '', '', 5, 'admin', '2020-05-29 20:32:59', '2020-03-19 21:43:33', 'admin', '', '', '', '', '', NULL, '0', NULL, NULL, '1');
INSERT INTO `onl_cgform_field` VALUES ('e7aade12ca722b59c1ec681d14247ff8', '402860816bff91c0016bff91d8830007', 'sys_org_code', '组织机构编码', 'sys_org_code', 0, 1, 'string', 50, 0, '', '', '', '', 'text', '', 120, NULL, '0', '', '', 0, 1, 1, 0, 'group', '', '', 14, 'admin', '2019-07-19 18:04:41', '2019-07-17 18:54:37', 'admin', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `onl_cgform_field` VALUES ('e843c8e9209bc62f7708385ce4040ea7', '4028818371790b3f0171790b43ac0001', 'remark3', '备注3', 'remark3', 0, 1, 'string', 50, 0, '', '', '', '', 'text', '', 120, NULL, '0', '', '', 0, 1, 1, 0, 'group', '', '', 11, 'admin', '2020-04-14 23:25:38', '2020-04-14 22:15:14', 'admin', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `onl_cgform_field` VALUES ('e845925368919482df6dac58e6ed708d', '402860816bff91c0016bff91d8830007', 'phone', '联系方式', 'phone', 0, 1, 'string', 20, 0, '', '', '', '', 'text', '', 120, NULL, '0', '', '', 0, 1, 1, 0, 'group', '', '', 8, 'admin', '2019-07-19 18:04:41', '2019-07-17 18:54:37', 'admin', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `onl_cgform_field` VALUES ('e88d328af34dd8a17f51437c52b68a2d', '402860816bff91c0016bff91cfea0004', 'create_by', '创建人', 'create_by', 0, 1, 'string', 100, 0, '', '', '', '', 'text', '', 120, NULL, '0', '', '', 0, 1, 1, 0, 'group', '', '', 9, 'admin', '2019-07-19 18:05:13', '2019-07-17 18:54:35', 'admin', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `onl_cgform_field` VALUES ('e8e3dc0ad760b9ba88bd40b0b22f8399', '40288183712beaa901712beaad3c0001', 'discount_rate', '折扣率', 'discount_rate', 0, 1, 'BigDecimal', 10, 6, '', '', '', '', 'text', '', 120, NULL, '0', '', '', 0, 1, 1, 0, 'group', '', '', 18, 'admin', '2020-05-04 21:41:29', '2020-03-30 22:48:53', 'admin', '', '', '', '', '', NULL, '0', NULL, NULL, '0');
INSERT INTO `onl_cgform_field` VALUES ('e937238562ad636ccb00cc287aa08e74', '40288183712beaa901712c0eb77c0002', 'update_by', '修改人', 'update_by', 0, 1, 'string', 36, 0, '', '', '', '', 'text', '', 120, NULL, '0', '', '', 0, 1, 0, 1, 'group', '', '', 39, 'admin', '2020-03-31 00:15:25', '2020-03-30 23:28:15', 'admin', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `onl_cgform_field` VALUES ('e99cc08f4d88dd8f788399db8d448ee8', '62e29cdb81ac44d1a2d8ff89851b853d', 'create_by', '创建人', NULL, 0, 1, 'string', 50, 0, '', '', '', '', 'text', '', 120, NULL, '0', '', '', 0, 0, 0, 0, 'single', '', '', 2, NULL, NULL, '2019-05-11 14:01:14', 'admin', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `onl_cgform_field` VALUES ('e9fbe1534629f80cd2365a1818c70214', '40288183712beaa901712c0ebe7e0004', 'name', '名称', 'name', 0, 1, 'string', 100, 0, '', '', '', '', 'text', '', 120, NULL, '0', '', '', 0, 1, 1, 0, 'group', '', '', 5, 'admin', '2020-03-30 23:41:18', '2020-03-30 23:28:16', 'admin', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `onl_cgform_field` VALUES ('ea4673dc55fd26cf561eba3dfedbfd45', '4028818370f308e90170f308e9080000', 'remark', '备注', 'remark', 0, 1, 'string', 200, 0, '', '', '', '', 'text', '', 120, NULL, '0', '', '', 0, 1, 1, 0, 'group', '', '', 10, 'admin', '2020-05-30 11:58:17', '2020-03-19 21:43:33', 'admin', '', '', '', '', '', NULL, '0', NULL, NULL, '0');
INSERT INTO `onl_cgform_field` VALUES ('ea644c4c208739640933ba6e568045c1', 'e2faf977fdaf4b25a524f58c2441a51c', 'ruz_date', '入职时间', NULL, 0, 1, 'Date', 32, 0, '', '', '', '', 'date', '', 120, NULL, '0', '', '', 0, 1, 1, 0, 'single', '', '', 9, 'admin', '2019-06-10 17:27:00', '2019-04-24 17:12:11', 'admin', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `onl_cgform_field` VALUES ('ea96d1c33f0f0d7245045e70a5793257', '402860816bff91c0016bffa220a9000b', 'current_postcode', '现居住地邮编', 'current_postcode', 0, 1, 'string', 10, 0, '', '', '', '', 'text', '', 120, NULL, '0', '', '', 0, 1, 1, 0, 'group', '', '', 31, 'admin', '2019-07-22 16:15:32', '2019-07-17 19:12:24', 'admin', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `onl_cgform_field` VALUES ('eab55fadbb5ba33e06366c128eea8e71', '402881fe72362af70172362af7150000', 'update_by', '修改人', 'update_by', 0, 1, 'string', 36, 0, '', 'username', 'sys_user', 'realname', 'list', '', 120, NULL, '0', '', '', 0, 1, 1, 0, 'single', '', '', 24, 'admin', '2020-05-21 20:19:56', '2020-05-21 15:38:06', 'admin', '', '', '', '', '', NULL, '0', NULL, NULL, '0');
INSERT INTO `onl_cgform_field` VALUES ('ebb72b091196b37b33e1efbe71cd2726', '40288183712beaa901712beaa9a00000', 'source_id', '源单', 'source_id', 0, 1, 'string', 36, 0, '', '', '', '', 'text', '', 120, NULL, '0', '', '', 0, 1, 1, 0, 'group', '', '', 6, 'admin', '2020-04-17 12:01:33', '2020-03-30 22:48:52', 'admin', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `onl_cgform_field` VALUES ('ebc41362681919cc680fcc58bf87fdcb', '1acb6f81a1d9439da6cc4e868617b565', 'price', '单价', NULL, 0, 1, 'double', 10, 2, '', '', '', '', 'text', '', 120, NULL, '0', '', '', 0, 1, 1, 0, 'single', '', '', 12, 'admin', '2019-06-10 14:47:14', '2019-04-23 22:58:19', 'admin', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `onl_cgform_field` VALUES ('ec20e66d5eb9b8b7f58de9edc0f7630b', '1acb6f81a1d9439da6cc4e868617b565', 'create_by', '创建人', NULL, 0, 1, 'string', 50, 0, '', '', '', '', 'text', '', 120, NULL, '0', '', '', 0, 0, 0, 0, 'single', '', '', 2, 'admin', '2019-06-10 14:47:14', '2019-04-23 22:58:19', 'admin', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `onl_cgform_field` VALUES ('ec5e9cb5809b2f8ce1446df4a27693f0', '27fc5f91274344afa7673a732b279939', 'name', '用户名', NULL, 0, 1, 'String', 32, 0, '', '', '', '', 'text', '', 120, NULL, '0', '', '', 0, 1, 1, 0, 'single', '', '', 7, 'admin', '2019-07-01 16:28:20', '2019-07-01 16:26:42', 'admin', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `onl_cgform_field` VALUES ('ec888180f3b56d3bb330917b1dc32dc8', '40288183712beaa901712beaad3c0001', 'version', '版本', 'version', 0, 1, 'int', 10, 0, '', '', '', '', 'text', '', 120, NULL, '0', '', '', 0, 0, 0, 0, 'group', '', '', 26, 'admin', '2020-05-04 21:41:29', '2020-03-30 22:48:53', 'admin', '', '', '', '', '', NULL, '0', NULL, NULL, '0');
INSERT INTO `onl_cgform_field` VALUES ('ec93105d5950ea7b1fa16a863ed885f3', '402881fe71c8c4fd0171c8c503230002', 'sys_org_code', '创建部门', 'sys_org_code', 0, 1, 'string', 50, 0, '', 'org_code', 'sys_depart', 'depart_name', 'text', '', 120, NULL, '0', '', '', 0, 1, 1, 1, 'group', '', '', 19, 'admin', '2020-04-30 10:30:53', '2020-04-30 09:48:07', 'admin', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `onl_cgform_field` VALUES ('ed0030994f062dfbf4937e0daee58911', '4028818371790b3f0171790b3f780000', 'update_by', '修改人', 'update_by', 0, 1, 'string', 36, 0, '', 'username', 'sys_user', 'realname', 'list', '', 120, NULL, '0', '', '', 0, 1, 1, 1, 'group', '', '', 22, 'admin', '2020-04-14 23:41:28', '2020-04-14 22:15:13', 'admin', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `onl_cgform_field` VALUES ('ed16f23d08e7bcda11a1383fda68057e', '402860816bff91c0016bff91c7010001', 'employee_id', '员工ID', 'employee_id', 0, 1, 'string', 32, 0, '', '', '', '', 'text', '', 120, NULL, '0', '', '', 0, 1, 1, 0, 'group', 'oa_employee_info', 'id', 2, 'admin', '2019-07-19 18:07:47', '2019-07-17 18:54:32', 'admin', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `onl_cgform_field` VALUES ('ed171ed881e00a1c4637d2c407c3badb', '40288183712beaa901712beaa9a00000', 'sys_org_code', '创建部门', 'sys_org_code', 0, 1, 'string', 50, 0, '', 'org_code', 'sys_depart', 'depart_name', 'list', '', 120, NULL, '0', '', '', 0, 1, 1, 1, 'group', '', '', 22, 'admin', '2020-04-17 12:01:33', '2020-03-30 22:48:52', 'admin', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `onl_cgform_field` VALUES ('edcb0036f4f6d705d4a59643e64aecbd', '40288101710a4c6201710a60ad5e0001', 'name', '名称', 'name', 0, 0, 'string', 50, 0, '', '', '', '', 'text', '', 200, NULL, '0', '', '', 0, 1, 1, 0, 'group', '', '', 2, 'admin', '2020-03-28 09:52:10', '2020-03-24 10:30:41', 'admin', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `onl_cgform_field` VALUES ('edda30c64e1dccee510d40b77a8ca094', 'fb7125a344a649b990c12949945cb6c1', 'update_by', '更新人', NULL, 0, 1, 'string', 50, 0, '', '', '', '', 'text', '', 120, '', '0', '', '', 0, 0, 0, 0, 'single', '', '', 3, 'admin', '2019-03-26 19:24:11', '2019-03-26 19:01:52', 'admin', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `onl_cgform_field` VALUES ('ee09e0e21fa350b9346b70292dcfca00', '79091e8277c744158530321513119c68', 'id', '主键', NULL, 1, 0, 'string', 36, 0, '', '', '', '', 'text', '', 120, NULL, '0', '', '', 0, 0, 0, 0, 'single', '', '', 1, 'admin', '2019-05-11 15:29:47', '2019-05-11 15:27:17', 'admin', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `onl_cgform_field` VALUES ('ee4ffe04a25fcf556e78183f1f521546', '402860816aa5921f016aa5921f480000', 'create_by', '创建人id', 'create_by', 0, 1, 'string', 32, 0, '', '', '', '', 'text', '', 120, NULL, '0', '', '', 0, 0, 0, 0, 'group', '', '', 8, 'admin', '2019-05-11 15:31:54', '2019-05-11 14:26:19', 'admin', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `onl_cgform_field` VALUES ('ee5803611f63643059b6375166d71567', '402860816bff91c0016bff91c7010001', 'create_time', '创建时间', 'create_time', 0, 1, 'Date', 0, 0, '', '', '', '', 'date', '', 120, NULL, '0', '', '', 0, 1, 1, 0, 'group', '', '', 8, 'admin', '2019-07-19 18:07:47', '2019-07-17 18:54:32', 'admin', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `onl_cgform_field` VALUES ('eed119f8ca0b7e426e290759b0dc12b5', '402881e970dd8d520170dd90f7c30002', 'note', 'note', 'note', 0, 1, 'string', 200, 0, '', '', '', '', 'text', '', 120, NULL, '0', '', '', 0, 1, 1, 0, 'group', '', '', 22, 'admin', '2020-03-15 21:40:40', '2020-03-15 17:40:31', 'admin', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `onl_cgform_field` VALUES ('eeff5ff18c22434f3feadfe8c0f1df8d', '40288101717185240171718524d60000', 'bill_no', '单据编号', 'bill_no', 0, 0, 'string', 50, 0, '', '', '', '', 'text', '', 120, NULL, '0', '', '', 1, 1, 1, 0, 'single', '', '', 4, 'admin', '2020-04-13 14:00:53', '2020-04-13 11:11:24', 'admin', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `onl_cgform_field` VALUES ('ef81373c5fd7130d7e23859d90c9eb3e', '402860816bff91c0016bff91cda80003', 'from_time', '开始日期', 'from_time', 0, 1, 'Date', 0, 0, '', '', '', '', 'date', '', 120, NULL, '0', '', '', 0, 1, 1, 0, 'group', '', '', 3, 'admin', '2019-07-19 18:06:36', '2019-07-17 18:54:34', 'admin', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `onl_cgform_field` VALUES ('efcb8de5a9fcbfe551d4644792488f51', '40288183712beaa901712c0ebcb10003', 'address', '供应商地址', 'address', 0, 1, 'string', 200, 0, '', '', '', '', 'text', '', 120, NULL, '0', '', '', 0, 1, 0, 0, 'group', '', '', 15, 'admin', '2020-03-31 00:04:14', '2020-03-30 23:28:16', 'admin', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `onl_cgform_field` VALUES ('efd1b955a75b5046e9857e00fe94ae2c', 'fbc35f067da94a70adb622ddba259352', 'id', '主键', NULL, 1, 0, 'string', 36, 0, '', '', '', '', 'text', '', 120, NULL, '0', '', '', 0, 0, 0, 0, 'single', '', '', 1, NULL, NULL, '2019-07-03 19:44:23', 'admin', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `onl_cgform_field` VALUES ('efec04fe4dffcedad275b21df53c8aa4', '40288183712beaa901712beaa9a00000', 'customer_id', '客户', 'customer_id', 0, 1, 'string', 36, 0, '', 'id', 'bas_customer', 'name', 'list', '', 120, NULL, '0', '', '', 0, 1, 1, 0, 'group', '', '', 12, 'admin', '2020-04-17 12:01:33', '2020-03-30 22:48:52', 'admin', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `onl_cgform_field` VALUES ('f015cc2ffdcc2c4be1e9b3622eb69b52', 'fbc35f067da94a70adb622ddba259352', 'sys_org_code', '所属部门', NULL, 0, 1, 'string', 64, 0, '', '', '', '', 'text', '', 120, NULL, '0', '', '', 0, 0, 0, 0, 'single', '', '', 6, NULL, NULL, '2019-07-03 19:44:23', 'admin', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `onl_cgform_field` VALUES ('f01fe6be3cfdcb25d53b1c05050b27d0', '402881ea71684fa00171684fa0680000', 'id', 'ID', 'id', 1, 0, 'string', 36, 0, '', '', '', '', 'text', '', 120, NULL, '0', '', '', 0, 0, 0, 0, 'group', '', '', 1, 'admin', '2020-04-11 16:28:45', '2020-04-11 16:16:22', 'admin', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `onl_cgform_field` VALUES ('f0591aa620db344bd2e5a8a24c7db570', '4028818370f5f37d0170f5f37dcf0000', 'has_child', '是否有子节点', NULL, 0, 1, 'int', 3, 0, '', 'yn', '', '', 'list', '', 120, NULL, '0', '', '', 0, 0, 0, 0, 'single', '', '', 8, 'admin', '2020-03-20 12:02:35', '2020-03-20 11:50:57', 'admin', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `onl_cgform_field` VALUES ('f06b2bb01ea1fae487b7e3c3eb521d5b', 'd3ae1c692b9640e0a091f8c46e17bb01', 'create_by', '创建人', NULL, 0, 1, 'string', 50, 0, '', '', '', '', 'text', '', 120, NULL, '0', '', '', 0, 0, 0, 0, 'single', '', '', 2, NULL, NULL, '2019-07-24 14:47:30', 'admin', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `onl_cgform_field` VALUES ('f0967fd139b440f79f21248bf4e4a209', 'd3ae1c692b9640e0a091f8c46e17bb01', 'update_time', '更新日期', NULL, 0, 1, 'Date', 20, 0, '', '', '', '', 'datetime', '', 120, NULL, '0', '', '', 0, 0, 0, 0, 'single', '', '', 5, NULL, NULL, '2019-07-24 14:47:30', 'admin', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `onl_cgform_field` VALUES ('f0a453930aa16ca32f2e3be860bfe542', '402860816bff91c0016bffa220a9000b', 'education', '学历', 'education', 0, 1, 'string', 100, 0, '', '', '', '', 'text', '', 120, NULL, '0', '', '', 0, 1, 1, 0, 'group', '', '', 14, 'admin', '2019-07-22 16:15:32', '2019-07-17 19:12:24', 'admin', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `onl_cgform_field` VALUES ('f0edcb946119c067eac52cd0b6af400f', '40288101710a4c6201710a60ad5e0001', 'factor', '换算系数', 'factor', 0, 0, 'BigDecimal', 18, 6, '1', '', '', '', 'text', '', 100, 'n', '0', '', '', 0, 1, 1, 0, 'group', '', '', 6, 'admin', '2020-03-28 09:52:10', '2020-03-24 10:30:41', 'admin', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `onl_cgform_field` VALUES ('f12753b4a3815697a72017a7436fe733', 'e2faf977fdaf4b25a524f58c2441a51c', 'update_time', '更新日期', NULL, 0, 1, 'Date', 20, 0, '', '', '', '', 'datetime', '', 120, NULL, '0', '', '', 0, 0, 0, 0, 'single', '', '', 5, 'admin', '2019-06-10 17:27:00', '2019-04-24 17:12:11', 'admin', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `onl_cgform_field` VALUES ('f1ab7d3b55ade57eeac6c55b32ce813a', '1acb6f81a1d9439da6cc4e868617b565', 'update_by', '更新人', NULL, 0, 1, 'string', 50, 0, '', '', '', '', 'text', '', 120, NULL, '0', '', '', 0, 0, 0, 0, 'single', '', '', 4, 'admin', '2019-06-10 14:47:14', '2019-04-23 22:58:19', 'admin', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `onl_cgform_field` VALUES ('f1c7fde21f26c7ed64a0ef1095900c52', '4028318169e81b970169e81b97650000', 'request_type', '请求类型', 'request_type', 0, 1, 'string', 10, 0, NULL, NULL, NULL, NULL, 'text', NULL, 120, NULL, '0', NULL, NULL, 0, 1, 1, 0, 'group', NULL, NULL, 11, NULL, NULL, '2019-04-04 19:28:36', 'admin', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `onl_cgform_field` VALUES ('f20df611b91999b0867c8f3e84b3a18e', '4028818370e8d46b0170e8d46d350001', 'source_entry_id', '源单分录', 'source_entry_id', 0, 1, 'string', 36, 0, '', '', '', '', 'text', '', 120, NULL, '0', '', '', 0, 1, 1, 0, 'group', '', '', 3, 'admin', '2020-03-17 22:14:27', '2020-03-17 22:10:01', 'admin', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `onl_cgform_field` VALUES ('f246bf92d8304d8999cb91e864044053', '40288183712beaa901712c0eb77c0002', 'bankid_invoice', '开票信息行号', 'bankid_invoice', 0, 1, 'string', 100, 0, '', '', '', '', 'text', '', 120, NULL, '0', '', '', 0, 1, 0, 0, 'group', '', '', 20, 'admin', '2020-03-31 00:15:25', '2020-03-30 23:28:15', 'admin', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `onl_cgform_field` VALUES ('f2953eb07ea89933713ac97a28867b6e', '402881fe71c8c4fd0171c8c503230002', 'version', '版本', 'version', 0, 1, 'int', 10, 0, '', '', '', '', 'text', '', 120, NULL, '0', '', '', 0, 0, 0, 0, 'group', '', '', 24, 'admin', '2020-04-30 10:30:53', '2020-04-30 09:48:07', 'admin', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `onl_cgform_field` VALUES ('f2edd39f14e674b198f3d844728fb195', '4028818371790b3f0171790b3f780000', 'is_closed', '是否关闭', 'is_closed', 0, 0, 'int', 3, 0, '0', 'yn', '', '', 'list', '', 120, NULL, '0', '', '', 1, 1, 1, 1, 'single', '', '', 13, 'admin', '2020-04-14 23:41:28', '2020-04-14 22:15:13', 'admin', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `onl_cgform_field` VALUES ('f34f9b260ec3b75a35803ce1aa7bafe3', '40288101710a4c6201710a60ad5e0001', 'create_by', '创建人', 'create_by', 0, 1, 'string', 36, 0, '', '', '', '', 'text', '', 120, NULL, '0', '', '', 0, 1, 1, 1, 'group', '', '', 8, 'admin', '2020-03-28 09:52:10', '2020-03-24 10:30:41', 'admin', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `onl_cgform_field` VALUES ('f39dd36191a26c6db37c9deebfb41c70', '4028818371790b3f0171790b3f780000', 'version', '版本', 'version', 0, 1, 'int', 10, 0, '', '', '', '', 'text', '', 120, NULL, '0', '', '', 0, 0, 0, 0, 'group', '', '', 23, 'admin', '2020-04-14 23:41:28', '2020-04-14 22:15:13', 'admin', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `onl_cgform_field` VALUES ('f456e2123b0934c771105eb4b511952a', '4028818370f308e90170f308e9080000', 'tax_coce', '税控编码', 'tax_coce', 0, 1, 'string', 50, 0, '', '', '', '', 'text', '', 120, NULL, '0', '', '', 1, 1, 1, 0, 'single', '', '', 9, 'admin', '2020-05-30 11:58:17', '2020-03-19 21:43:33', 'admin', '', '', '', '', '', NULL, '0', NULL, NULL, '0');
INSERT INTO `onl_cgform_field` VALUES ('f45d5a4d8888d0352b838f6088d5b655', '40288183712a997c01712a997c580000', 'id', 'ID', 'id', 1, 0, 'string', 36, 0, '', '', '', '', 'text', '', 120, NULL, '0', '', '', 0, 0, 0, 0, 'group', '', '', 1, 'admin', '2020-03-30 16:48:20', '2020-03-30 16:40:35', 'admin', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `onl_cgform_field` VALUES ('f4647a91a4ac5d6d32bb0692b800bffe', '402860816bff91c0016bff91c0cb0000', 'probation_post', '试用期职位', 'probation_post', 0, 1, 'string', 100, 0, '', '', '', '', 'text', '', 120, NULL, '0', '', '', 0, 1, 1, 0, 'group', '', '', 8, 'admin', '2019-07-19 18:09:01', '2019-07-17 18:54:32', 'admin', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `onl_cgform_field` VALUES ('f4b0bc7f3d6562e28d7c5e2d56510ecd', 'e5464aa8fa7b47c580e91593cf9b46dc', 'first_num', '首次数量', NULL, 0, 1, 'String', 32, 0, '', '', '', '', 'text', '', 120, NULL, '0', '', '', 0, 1, 1, 0, 'single', '', '', 8, 'admin', '2019-04-24 17:09:49', '2019-04-24 14:31:31', 'admin', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `onl_cgform_field` VALUES ('f4c1d8983aedb2290f917494e1b2ed82', '402881fe71c8c4fd0171c8c500d30001', 'entry_no', '分录号', 'entry_no', 0, 0, 'int', 10, 0, '', '', '', '', 'text', '', 120, NULL, '0', '', '', 0, 1, 1, 0, 'group', '', '', 4, 'admin', '2020-04-30 10:30:11', '2020-04-30 09:48:07', 'admin', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `onl_cgform_field` VALUES ('f4c3b16636f3e91b9b459aba9baea679', '40288183712beaa901712c0ebcb10003', 'bankid_payment', '办款资料行号', 'bankid_payment', 0, 1, 'string', 100, 0, '', '', '', '', 'text', '', 120, NULL, '0', '', '', 0, 1, 0, 0, 'group', '', '', 27, 'admin', '2020-03-31 00:04:14', '2020-03-30 23:28:16', 'admin', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `onl_cgform_field` VALUES ('f51e72b2bafb068139396332789d0c20', '402881fe72268ef10172268ef1370000', 'attachment', '附件', 'attachment', 0, 1, 'string', 500, 0, '', '', '', '', 'text', '', 120, NULL, '0', '', '', 0, 1, 1, 0, 'single', '', '', 7, 'admin', '2020-05-18 15:50:07', '2020-05-18 14:53:22', 'admin', '', '', '', '', '', NULL, '0', NULL, NULL, '0');
INSERT INTO `onl_cgform_field` VALUES ('f558359b06aea79a992c102ce3563a4d', '4028318169e81b970169e81b97650000', 'username', '操作用户名称', 'username', 0, 1, 'string', 100, 0, NULL, NULL, NULL, NULL, 'text', NULL, 120, NULL, '0', NULL, NULL, 0, 1, 1, 0, 'group', NULL, NULL, 6, NULL, NULL, '2019-04-04 19:28:36', 'admin', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `onl_cgform_field` VALUES ('f5703286990bc6aa5d02a5c1b2beddd0', '402881e970dd8d520170ddb3a6490004', 'update_time', 'updateTime', 'update_time', 0, 1, 'Date', 0, 0, '', '', '', '', 'date', '', 120, NULL, '0', '', '', 0, 1, 1, 0, 'group', '', '', 23, 'admin', '2020-03-16 22:39:53', '2020-03-15 18:18:23', 'admin', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `onl_cgform_field` VALUES ('f668b21d15fe5df0f5e137aaa94d1714', '871c2df1185c4c8e80377d3c319c9a1e', 'update_by', '更新人', NULL, 0, 1, 'string', 50, 0, '', '', '', '', 'text', '', 120, NULL, '0', '', '', 0, 0, 0, 0, 'single', '', '', 4, NULL, NULL, '2020-03-20 11:42:58', 'admin', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `onl_cgform_field` VALUES ('f6afcb7d8ea81879593ff737b55ddcc0', '402860816bff91c0016bff91cda80003', 'id', 'id', 'id', 1, 1, 'string', 32, 0, '', '', '', '', 'text', '', 120, NULL, '0', '', '', 0, 0, 0, 0, 'group', '', '', 1, 'admin', '2019-07-19 18:06:36', '2019-07-17 18:54:34', 'admin', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `onl_cgform_field` VALUES ('f6b9874bb03e384e99b26a94ad66a6ec', '4028818370f308e90170f308e9080000', 'unit_id', '计量单位', 'unit_id', 0, 1, 'string', 36, 0, '', 'id', 'bas_measure_unit', 'name', 'list', '', 120, NULL, '0', '', '', 0, 1, 1, 0, 'group', '', '', 7, 'admin', '2020-05-30 11:58:17', '2020-03-19 21:43:33', 'admin', '', '', '', '', '', NULL, '0', NULL, NULL, '0');
INSERT INTO `onl_cgform_field` VALUES ('f6bb84e4f69602d1b8f2262f2035ed10', '40288183712beaa901712c0eb77c0002', 'attachment_id', '附件', 'attachment_id', 0, 1, 'string', 36, 0, '', '', '', '', 'text', '', 120, NULL, '0', '', '', 0, 1, 0, 0, 'group', '', '', 34, 'admin', '2020-03-31 00:15:25', '2020-03-30 23:28:15', 'admin', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `onl_cgform_field` VALUES ('f6f8aed87ec73994f6a12abbc079dbb1', '402860816bff91c0016bffa220a9000b', 'update_by', '更新人', 'update_by', 0, 1, 'string', 100, 0, '', '', '', '', 'text', '', 120, NULL, '0', '', '', 0, 1, 1, 0, 'group', '', '', 41, 'admin', '2019-07-22 16:15:32', '2019-07-17 19:12:24', 'admin', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `onl_cgform_field` VALUES ('f7332af7586c83c87f7b9ea144a5292d', '62e29cdb81ac44d1a2d8ff89851b853d', 'update_by', '更新人', NULL, 0, 1, 'string', 50, 0, '', '', '', '', 'text', '', 120, NULL, '0', '', '', 0, 0, 0, 0, 'single', '', '', 4, NULL, NULL, '2019-05-11 14:01:14', 'admin', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `onl_cgform_field` VALUES ('f76719783433487f4710232e2ae0e521', '402860816bff91c0016bff91cfea0004', 'id', 'id', 'id', 1, 1, 'string', 32, 0, '', '', '', '', 'text', '', 120, NULL, '0', '', '', 0, 0, 0, 0, 'group', '', '', 1, 'admin', '2019-07-19 18:05:13', '2019-07-17 18:54:35', 'admin', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `onl_cgform_field` VALUES ('f7e7eb84ddc34d7e09d10af213ac6667', '402860816bff91c0016bff91d2810005', 'create_time', '创建时间', 'create_time', 0, 1, 'Date', 0, 0, '', '', '', '', 'date', '', 120, NULL, '0', '', '', 0, 1, 1, 0, 'group', '', '', 11, 'admin', '2019-07-19 18:05:55', '2019-07-17 18:54:35', 'admin', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `onl_cgform_field` VALUES ('f7fb153ec680cb398dd53077d35a173a', '40288183712beaa901712beaa9a00000', 'is_voided', '是否作废', 'is_voided', 0, 1, 'int', 3, 0, '0', 'yn', '', '', 'list', '', 120, NULL, '0', '', '', 0, 1, 1, 1, 'group', '', '', 20, 'admin', '2020-04-17 12:01:33', '2020-03-30 22:48:52', 'admin', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `onl_cgform_field` VALUES ('f800d9d568ee7b78118c80518e0fa324', '40288101710a4c6201710a4c62b50000', 'name', '名称', 'name', 0, 1, 'string', 50, 0, '', '', '', '', 'text', '', 120, NULL, '0', '', '', 0, 1, 1, 0, 'group', '', '', 2, 'admin', '2020-03-24 10:18:35', '2020-03-24 10:08:31', 'admin', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `onl_cgform_field` VALUES ('f80a1b90ab137843a96e9c190ef69d67', '7a584d85821b482c9a93757cf101fbe6', 'sys_org_code', '所属部门', NULL, 0, 1, 'string', 64, 0, '', '', '', '', 'text', '', 120, NULL, '0', '', '', 0, 0, 0, 0, 'single', '', '', 6, 'admin', '2020-02-23 18:18:33', '2020-02-23 17:41:10', 'admin', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `onl_cgform_field` VALUES ('f81d7103c0c857e5c744cda2bc4c000a', '402860816bff91c0016bff91ca7e0002', 'cert_organizations', '发证机关', 'cert_organizations', 0, 1, 'string', 255, 0, '', '', '', '', 'text', '', 120, NULL, '0', '', '', 0, 1, 1, 0, 'group', '', '', 6, 'admin', '2019-07-19 18:07:13', '2019-07-17 18:54:33', 'admin', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `onl_cgform_field` VALUES ('f82db8edef5babf741914b0fa221329b', '4028839a6de2ebd3016de2ebd3870000', 'bpm_status', '流程状态', 'bpm_status', 0, 1, 'string', 2, 0, NULL, NULL, NULL, NULL, 'text', NULL, 120, NULL, '0', NULL, NULL, 0, 1, 1, 0, 'group', NULL, NULL, 16, NULL, NULL, '2019-10-19 15:29:30', 'admin', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `onl_cgform_field` VALUES ('f86767ed5492f7ee8c9ec76982347a45', '4028818371790b3f0171790b3f780000', 'bill_date', '单据日期', 'bill_date', 0, 0, 'Date', 0, 0, '', '', '', '', 'date', '', 120, NULL, '0', '', '', 1, 1, 1, 0, 'group', '', '', 3, 'admin', '2020-04-14 23:41:28', '2020-04-14 22:15:13', 'admin', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `onl_cgform_field` VALUES ('f8a0fd20a1173270afdfed1129d5c669', '402860816bff91c0016bffa220a9000b', 'depart_id', '所在部门id', NULL, 0, 1, 'String', 32, 0, '', '', '', '', 'text', '', 120, NULL, '0', '', '', 0, 1, 1, 0, 'single', '', '', 44, 'admin', '2019-07-22 16:15:32', '2019-07-19 15:33:44', 'admin', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `onl_cgform_field` VALUES ('f8cc6be747fec10802eb625ac529c16f', '402860816bff91c0016bff91cfea0004', 'create_time', '创建时间', 'create_time', 0, 1, 'Date', 0, 0, '', '', '', '', 'date', '', 120, NULL, '0', '', '', 0, 1, 1, 0, 'group', '', '', 10, 'admin', '2019-07-19 18:05:13', '2019-07-17 18:54:35', 'admin', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `onl_cgform_field` VALUES ('f90bcb38fb89988bd40d1618aa75cea0', '758334cb1e7445e2822b60e807aec4a3', 'id', '主键', NULL, 1, 0, 'string', 36, 0, '', '', '', '', 'text', '', 120, NULL, '0', '', '', 0, 0, 0, 0, 'single', '', '', 1, NULL, NULL, '2019-10-18 18:02:09', 'admin', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `onl_cgform_field` VALUES ('f9170cec8b9dc311745bbad8b8774156', '402881ea71684fa00171684fa0680000', 'supplier_id', '供应商', 'supplier_id', 0, 1, 'string', 36, 0, '', 'id', 'bas_supplier', 'name', 'list', '', 120, NULL, '0', '', '', 1, 1, 1, 1, 'single', '', '', 8, 'admin', '2020-04-11 16:28:45', '2020-04-11 16:16:22', 'admin', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `onl_cgform_field` VALUES ('f94db83e41c69f407d3c9a81c5892269', '402860816bff91c0016bffa220a9000b', 'first_job_time', '首次工作时间', 'first_job_time', 0, 1, 'Date', 0, 0, '', '', '', '', 'date', '', 120, NULL, '0', '', '', 0, 1, 1, 0, 'group', '', '', 22, 'admin', '2019-07-22 16:15:32', '2019-07-17 19:12:24', 'admin', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `onl_cgform_field` VALUES ('f95d2cbefd25444909c83aaf8c4f72fb', '402860816bff91c0016bff91ca7e0002', 'memo', '备注', 'memo', 0, 1, 'string', 255, 0, '', '', '', '', 'text', '', 120, NULL, '0', '', '', 0, 1, 1, 0, 'group', '', '', 7, 'admin', '2019-07-19 18:07:13', '2019-07-17 18:54:33', 'admin', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `onl_cgform_field` VALUES ('f95f129652926c3765d4c999573e4bae', '4028818371790b3f0171795b83bd0003', 'manager', '账户管理员', 'manager', 0, 1, 'string', 36, 0, '', 'username', 'sys_user', 'realname', 'list', '', 120, NULL, '0', '', '', 0, 1, 1, 0, 'group', '', '', 8, 'admin', '2020-04-14 23:46:44', '2020-04-14 23:42:53', 'admin', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `onl_cgform_field` VALUES ('f9b1de04255490f60f004d99d902bdcb', '40288101717185240171718524d60000', 'sys_org_code', '创建部门', 'sys_org_code', 0, 1, 'string', 50, 0, '', 'org_code', 'sys_depart', 'depart_name', 'list', '', 120, NULL, '0', '', '', 0, 1, 1, 0, 'group', '', '', 17, 'admin', '2020-04-13 14:00:53', '2020-04-13 11:11:24', 'admin', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `onl_cgform_field` VALUES ('fa3a12d7abf72b23afe425f8dbd57f86', '1acb6f81a1d9439da6cc4e868617b565', 'size_type', '尺码类型', NULL, 0, 1, 'String', 2, 0, '', 'air_china_size', '', '', 'list', '', 120, NULL, '0', '', '', 0, 1, 1, 0, 'single', '', '', 9, 'admin', '2019-06-10 14:47:14', '2019-04-23 22:58:19', 'admin', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `onl_cgform_field` VALUES ('fa8586f016cfea93338635aae82e9e81', '40288183712a997c01712a99809e0001', 'settle_price', '含税单价', 'settle_price', 0, 1, 'BigDecimal', 18, 6, NULL, NULL, NULL, NULL, 'text', NULL, 120, NULL, '0', NULL, NULL, 0, 1, 1, 0, 'group', NULL, NULL, 14, NULL, NULL, '2020-03-30 16:40:36', 'admin', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `onl_cgform_field` VALUES ('fa873d90119048b7dda3e02df61b7c9f', '402881e970dd8d520170dd90f7c30002', 'warehouse_id', '仓库', 'warehouse_id', 0, 1, 'string', 36, 0, '', '', '', '', 'text', '', 120, NULL, '0', '', '', 0, 1, 1, 0, 'group', '', '', 8, 'admin', '2020-03-15 21:40:40', '2020-03-15 17:40:31', 'admin', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `onl_cgform_field` VALUES ('fa8f5a0ba673e0208934567462844eab', '402860816bff91c0016bff91ca7e0002', 'sys_org_code', '组织机构编码', 'sys_org_code', 0, 1, 'string', 50, 0, '', '', '', '', 'text', '', 120, NULL, '0', '', '', 0, 1, 1, 0, 'group', '', '', 13, 'admin', '2019-07-19 18:07:13', '2019-07-17 18:54:33', 'admin', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `onl_cgform_field` VALUES ('faaaca21b7b2b16089c885f3224e4dc5', '4fb8e12a697f4d5bbe9b9fb1e9009486', 'main_id', '主表ID', NULL, 0, 1, 'String', 200, 0, '', '', '', '', 'text', '', 120, NULL, '0', '', '', 0, 0, 0, 0, 'single', 'demo_field_def_val_main', 'id', 5, 'admin', '2020-04-10 19:51:27', '2020-04-10 19:47:55', 'admin', '', '', '', '', '', NULL, '0', NULL, NULL, '0');
INSERT INTO `onl_cgform_field` VALUES ('fafb32cf7e63bca93bbd70b0a0ea11fc', '758334cb1e7445e2822b60e807aec4a3', 'sys_org_code', '所属部门', NULL, 0, 1, 'string', 64, 0, '', '', '', '', 'text', '', 120, NULL, '0', '', '', 0, 0, 0, 0, 'single', '', '', 6, NULL, NULL, '2019-10-18 18:02:09', 'admin', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `onl_cgform_field` VALUES ('fb381c0f1253c520ce03959ea819491d', '402881fe71c8c4fd0171c8c4fdae0000', 'checked_amt', '已核销金额', 'checked_amt', 0, 0, 'BigDecimal', 18, 2, '', '', '', '', 'text', '', 120, NULL, '0', '', '', 0, 1, 1, 0, 'group', '', '', 7, 'admin', '2020-04-30 10:23:44', '2020-04-30 09:48:06', 'admin', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `onl_cgform_field` VALUES ('fb91bbfd4d02e285098e69bb1076256a', '402881e970dd8d520170dd90f7c30002', 'version', 'version', 'version', 0, 0, 'int', 10, 0, '', '', '', '', 'text', '', 120, NULL, '0', '', '', 0, 1, 1, 0, 'group', '', '', 25, 'admin', '2020-03-15 21:40:40', '2020-03-15 17:40:31', 'admin', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `onl_cgform_field` VALUES ('fc55d467102c2c782286f546d7820c3d', '73162c3b8161413e8ecdca7eb288d0c9', 'pid', '父物料', NULL, 0, 1, 'String', 36, 0, '', '', '', '', 'text', '', 120, NULL, '0', '', '', 0, 1, 1, 0, 'single', '', '', 9, 'admin', '2019-07-01 14:23:32', '2019-06-10 15:18:34', 'admin', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `onl_cgform_field` VALUES ('fc76a3832d232829852cae6c66e44f67', '402860816bff91c0016bffa220a9000b', 'identity_no', '身份证号', 'identity_no', 0, 1, 'string', 20, 0, '', '', '', '', 'text', '', 120, NULL, '0', '', '', 0, 1, 1, 0, 'group', '', '', 21, 'admin', '2019-07-22 16:15:32', '2019-07-17 19:12:24', 'admin', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `onl_cgform_field` VALUES ('fcd519058d68fa4dab192335602b5d24', '402860816bff91c0016bffa220a9000b', 'real_name', '姓名', 'real_name', 0, 1, 'string', 100, 0, '', '', '', '', 'text', '', 120, NULL, '0', '', '', 0, 1, 1, 0, 'group', '', '', 5, 'admin', '2019-07-22 16:15:32', '2019-07-17 19:12:24', 'admin', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `onl_cgform_field` VALUES ('fcf8cb37922eca51e605f8bf6126f4cd', '40288183712beaa901712beaad3c0001', 'batch_no', '批次号', 'batch_no', 0, 1, 'string', 100, 0, '', 'material_id,warehouse_id,batch_no', 'stk_inventory_batch', 'materialId,warehouseId,batchNo', 'popup', '', 120, NULL, '0', '', '', 0, 1, 1, 0, 'group', '', '', 10, 'admin', '2020-05-04 21:41:29', '2020-03-30 22:48:53', 'admin', '', '', '', '', '', NULL, '0', NULL, NULL, '0');
INSERT INTO `onl_cgform_field` VALUES ('fd0586cae06685959415d9017b2bdf49', '758334cb1e7445e2822b60e807aec4a3', 'create_by', '创建人', NULL, 0, 1, 'string', 50, 0, '', '', '', '', 'text', '', 120, NULL, '0', '', '', 0, 0, 0, 0, 'single', '', '', 2, NULL, NULL, '2019-10-18 18:02:09', 'admin', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `onl_cgform_field` VALUES ('fd6460f63103f5fe21b50a7dd94d6fad', '40288183712beaa901712c0ebcb10003', 'account_invoice', '开票信息账号', 'account_invoice', 0, 1, 'string', 100, 0, '', '', '', '', 'text', '', 120, NULL, '0', '', '', 0, 1, 0, 0, 'group', '', '', 23, 'admin', '2020-03-31 00:04:14', '2020-03-30 23:28:16', 'admin', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `onl_cgform_field` VALUES ('fd90cdadedf10110294e3c7833c087fb', '40288183712a997c01712a997c580000', 'is_approved', '是否通过', 'is_approved', 0, 1, 'int', 3, 0, '', '', '', '', 'text', '', 120, NULL, '0', '', '', 0, 1, 1, 0, 'group', '', '', 15, 'admin', '2020-03-30 16:48:20', '2020-03-30 16:40:35', 'admin', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `onl_cgform_field` VALUES ('fde00160a5d664effaa4b5552e814e74', 'fb7125a344a649b990c12949945cb6c1', 'sex', '性别', NULL, 0, 1, 'string', 32, 0, '', '', '', '', 'text', '', 120, '', '0', '', '', 0, 1, 1, 0, 'single', '', '', 6, 'admin', '2019-03-26 19:24:11', '2019-03-26 19:01:52', 'admin', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `onl_cgform_field` VALUES ('fe8d41c4d6c9661062f1ab853fdc9985', '402881e970dd8d520170ddb3a6490004', 'attachment_id', 'attachmentId', 'attachment_id', 0, 1, 'string', 36, 0, '', '', '', '', 'text', '', 120, NULL, '0', '', '', 0, 1, 1, 0, 'group', '', '', 12, 'admin', '2020-03-16 22:39:53', '2020-03-15 18:18:23', 'admin', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `onl_cgform_field` VALUES ('fed133a00f57245d4cfb02dd3c3ce7c1', '4adec929a6594108bef5b35ee9966e9f', 'update_by', '更新人', NULL, 0, 1, 'string', 50, 0, '', '', '', '', 'text', '', 120, NULL, '0', '', '', 0, 0, 0, 0, 'single', '', '', 9, 'admin', '2020-04-10 19:43:38', '2020-04-10 19:35:58', 'admin', '', '', '', '', '', 'text', '0', NULL, NULL, '0');
INSERT INTO `onl_cgform_field` VALUES ('ff35e83af25e150f60def77dc8bce2a2', '40288183712beaa901712c0eb77c0002', 'address_receipt', '收件信息收件人', 'address_receipt', 0, 1, 'string', 50, 0, '', '', '', '', 'text', '', 120, NULL, '0', '', '', 0, 1, 0, 0, 'group', '', '', 31, 'admin', '2020-03-31 00:15:25', '2020-03-30 23:28:15', 'admin', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `onl_cgform_field` VALUES ('ff49b468e54e137032f7e4d976b83b5a', '402860816bff91c0016bffa220a9000b', 'politically_status', '政治面貌', 'politically_status', 0, 1, 'string', 20, 0, '', '', '', '', 'text', '', 120, NULL, '0', '', '', 0, 1, 1, 0, 'group', '', '', 8, 'admin', '2019-07-22 16:15:32', '2019-07-17 19:12:24', 'admin', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `onl_cgform_field` VALUES ('ff601f75d0e7ced226748eb8fba2c896', '402860816bff91c0016bff91d8830007', 'relation', '关系', 'relation', 0, 1, 'string', 100, 0, '', '', '', '', 'text', '', 120, NULL, '0', '', '', 0, 1, 1, 0, 'group', '', '', 4, 'admin', '2019-07-19 18:04:41', '2019-07-17 18:54:37', 'admin', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `onl_cgform_field` VALUES ('ffacafee9fa46eb297ca3252f95acef9', '402860816bff91c0016bffa220a9000b', 'school', '毕业学校', 'school', 0, 1, 'string', 100, 0, '', '', '', '', 'text', '', 120, NULL, '0', '', '', 0, 1, 1, 0, 'group', '', '', 9, 'admin', '2019-07-22 16:15:32', '2019-07-17 19:12:24', 'admin', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `onl_cgform_field` VALUES ('ffaff04d19ed1e3656871ab3891093ea', '4028818370e8d46b0170e8d46b4b0000', 'bill_no', '单据编号', 'bill_no', 0, 0, 'string', 100, 0, '', '', '', '', 'text', '', 120, NULL, '0', '', '', 1, 1, 1, 0, 'single', '', '', 2, 'admin', '2020-03-19 10:25:32', '2020-03-17 22:10:00', 'admin', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `onl_cgform_field` VALUES ('ffcbf379fffabbd13aa2c22ce565ec12', '79091e8277c744158530321513119c68', 'update_by', '更新人', NULL, 0, 1, 'string', 50, 0, '', '', '', '', 'text', '', 120, NULL, '0', '', '', 0, 0, 0, 0, 'single', '', '', 4, 'admin', '2019-05-11 15:29:47', '2019-05-11 15:27:17', 'admin', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);

-- ----------------------------
-- Table structure for onl_cgform_head
-- ----------------------------
DROP TABLE IF EXISTS `onl_cgform_head`;
CREATE TABLE `onl_cgform_head`  (
  `id` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '主键ID',
  `table_name` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '表名',
  `table_type` int(11) NOT NULL COMMENT '表类型: 0单表、1主表、2附表',
  `table_version` int(11) NULL DEFAULT 1 COMMENT '表版本',
  `table_txt` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '表说明',
  `is_checkbox` varchar(5) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '是否带checkbox',
  `is_db_synch` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT 'N' COMMENT '同步数据库状态',
  `is_page` varchar(5) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '是否分页',
  `is_tree` varchar(5) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '是否是树',
  `id_sequence` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '主键生成序列',
  `id_type` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '主键类型',
  `query_mode` varchar(10) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '查询模式',
  `relation_type` int(11) NULL DEFAULT NULL COMMENT '映射关系 0一对多  1一对一',
  `sub_table_str` varchar(1000) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '子表',
  `tab_order_num` int(11) NULL DEFAULT NULL COMMENT '附表排序序号',
  `tree_parent_id_field` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '树形表单父id',
  `tree_id_field` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '树表主键字段',
  `tree_fieldname` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '树开表单列字段',
  `form_category` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT 'bdfl_ptbd' COMMENT '表单分类',
  `form_template` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT 'PC表单模板',
  `form_template_mobile` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '表单模板样式(移动端)',
  `scroll` int(3) NULL DEFAULT 0 COMMENT '是否有横向滚动条',
  `copy_version` int(11) NULL DEFAULT NULL COMMENT '复制版本号',
  `copy_type` int(3) NULL DEFAULT 0 COMMENT '复制表类型1为复制表 0为原始表',
  `physic_id` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '原始表ID',
  `update_by` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '修改人',
  `update_time` datetime(0) NULL DEFAULT NULL COMMENT '修改时间',
  `create_by` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '创建人',
  `create_time` datetime(0) NULL DEFAULT NULL COMMENT '创建时间',
  `theme_template` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '主题模板',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `index_onlineform_table_name`(`table_name`) USING BTREE,
  INDEX `index_form_templdate`(`form_template`) USING BTREE,
  INDEX `index_templdate_mobile`(`form_template_mobile`) USING BTREE,
  INDEX `index_onlineform_table_version`(`table_version`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of onl_cgform_head
-- ----------------------------
INSERT INTO `onl_cgform_head` VALUES ('3d447fa919b64f6883a834036c14aa67', 'test_enhance_select', 1, 5, 'js增强实现下拉联动效果', 'N', 'Y', 'Y', 'N', NULL, 'UUID', 'single', NULL, NULL, NULL, NULL, NULL, NULL, 'bdfl_include', '1', NULL, 0, NULL, 0, NULL, 'admin', '2020-02-21 17:58:46', 'admin', '2020-02-20 16:19:00', 'normal');
INSERT INTO `onl_cgform_head` VALUES ('40288101710a4c6201710a60ad5e0001', 'bas_measure_unit', 1, 28, '计量单位', 'Y', 'Y', 'Y', 'Y', NULL, 'UUID', 'group', NULL, NULL, NULL, 'pid', 'has_child', 'name', 'bdfl_include', '1', NULL, 0, NULL, 0, NULL, 'admin', '2020-03-28 09:52:21', 'admin', '2020-03-24 10:30:41', NULL);
INSERT INTO `onl_cgform_head` VALUES ('40288101717185240171718524d60000', 'fin_payable', 1, 8, '应付单', 'Y', 'Y', 'Y', 'N', NULL, 'UUID', 'group', NULL, NULL, NULL, NULL, NULL, NULL, 'bdfl_include', '1', NULL, 0, NULL, 0, NULL, 'admin', '2020-04-13 14:01:00', 'admin', '2020-04-13 11:11:24', NULL);
INSERT INTO `onl_cgform_head` VALUES ('402881017185937c017185937c100000', 'fin_rp_check', 2, 3, '往来核销单', 'Y', 'Y', 'Y', 'N', NULL, 'UUID', 'group', NULL, '', NULL, NULL, NULL, NULL, 'bdfl_include', '3', NULL, 0, NULL, 0, NULL, 'admin', '2020-04-18 17:06:34', 'admin', '2020-04-17 08:39:28', NULL);
INSERT INTO `onl_cgform_head` VALUES ('402881017185937c017185937f430001', 'fin_rp_check_entry', 3, 5, 'fin_rp_check_entry', 'Y', 'Y', 'Y', 'N', NULL, 'UUID', 'group', 0, NULL, 1, NULL, NULL, NULL, 'bdfl_include', '1', NULL, 0, NULL, 0, NULL, 'admin', '2020-04-18 17:08:51', 'admin', '2020-04-17 08:39:29', NULL);
INSERT INTO `onl_cgform_head` VALUES ('402881017185937c0171859381700002', 'fin_rp_check_target', 2, 5, '往来核销对象', 'Y', 'Y', 'Y', 'N', NULL, 'UUID', 'group', 0, 'fin_rp_check_entry', 1, NULL, NULL, NULL, 'bdfl_include', '1', NULL, 0, NULL, 0, NULL, 'admin', '2020-04-18 17:11:30', 'admin', '2020-04-17 08:39:29', NULL);
INSERT INTO `onl_cgform_head` VALUES ('4028818370f308e90170f308e9080000', 'bas_material', 1, 21, '物料', 'Y', 'Y', 'Y', 'N', NULL, 'UUID', 'single', 0, NULL, 1, NULL, NULL, NULL, 'bdfl_include', '1', NULL, 0, NULL, 0, NULL, 'admin', '2020-05-30 11:58:17', 'admin', '2020-03-19 21:43:33', 'normal');
INSERT INTO `onl_cgform_head` VALUES ('4028818370f308e90170f308eabf0001', 'bas_material_category', 1, 50, '物料分类', 'Y', 'Y', 'Y', 'Y', NULL, 'UUID', 'single', NULL, '', NULL, 'pid', 'has_child', 'name', 'bdfl_include', '1', NULL, 0, NULL, 0, NULL, 'admin', '2020-05-29 20:32:59', 'admin', '2020-03-19 21:43:33', 'normal');
INSERT INTO `onl_cgform_head` VALUES ('40288183712beaa901712beaa9a00000', 'stk_io_bill', 2, 14, '出入库单', 'Y', 'Y', 'Y', 'N', NULL, 'UUID', 'group', NULL, 'stk_io_bill_entry', NULL, NULL, NULL, NULL, 'bdfl_include', '3', NULL, 0, NULL, 0, NULL, 'admin', '2020-05-04 21:41:29', 'admin', '2020-03-30 22:48:52', NULL);
INSERT INTO `onl_cgform_head` VALUES ('40288183712beaa901712beaad3c0001', 'stk_io_bill_entry', 3, 9, '明细', 'Y', 'Y', 'Y', 'N', NULL, 'UUID', 'group', 0, NULL, 1, NULL, NULL, NULL, 'bdfl_include', '3', NULL, 0, NULL, 0, NULL, 'admin', '2020-05-04 21:41:29', 'admin', '2020-03-30 22:48:53', NULL);
INSERT INTO `onl_cgform_head` VALUES ('40288183712beaa901712c0eb77c0002', 'bas_customer', 1, 4, '客户', 'Y', 'Y', 'Y', 'N', NULL, 'UUID', 'group', NULL, NULL, NULL, NULL, NULL, NULL, 'bdfl_include', '1', NULL, 0, NULL, 0, NULL, 'admin', '2020-03-31 00:15:25', 'admin', '2020-03-30 23:28:15', NULL);
INSERT INTO `onl_cgform_head` VALUES ('40288183712beaa901712c0ebcb10003', 'bas_supplier', 1, 5, '供应商', 'Y', 'Y', 'Y', 'N', NULL, 'UUID', 'group', NULL, NULL, NULL, NULL, NULL, NULL, 'bdfl_include', '1', NULL, 0, NULL, 0, NULL, 'admin', '2020-03-31 00:11:07', 'admin', '2020-03-30 23:28:16', NULL);
INSERT INTO `onl_cgform_head` VALUES ('40288183712beaa901712c0ebe7e0004', 'bas_warehouse', 1, 5, '仓库', 'Y', 'Y', 'Y', 'Y', NULL, 'UUID', 'group', NULL, NULL, NULL, 'pid', 'has_child', 'name', 'bdfl_include', '1', NULL, 0, NULL, 0, NULL, 'admin', '2020-03-30 23:41:18', 'admin', '2020-03-30 23:28:16', NULL);
INSERT INTO `onl_cgform_head` VALUES ('4028818371790b3f0171790b3f780000', 'fin_payment', 2, 7, '付款单', 'Y', 'Y', 'Y', 'N', NULL, 'UUID', 'group', NULL, 'fin_payment_entry', NULL, NULL, NULL, NULL, 'bdfl_include', '1', NULL, 0, NULL, 0, NULL, 'admin', '2020-04-14 23:41:57', 'admin', '2020-04-14 22:15:13', NULL);
INSERT INTO `onl_cgform_head` VALUES ('4028818371790b3f0171790b43ac0001', 'fin_payment_entry', 3, 5, '付款明细', 'Y', 'Y', 'Y', 'N', NULL, 'UUID', 'group', 0, NULL, 1, NULL, NULL, NULL, 'bdfl_include', '1', NULL, 0, NULL, 0, NULL, 'admin', '2020-04-14 23:26:15', 'admin', '2020-04-14 22:15:14', NULL);
INSERT INTO `onl_cgform_head` VALUES ('4028818371790b3f0171795b80ed0002', 'bas_currency', 1, 2, '币种', 'Y', 'Y', 'Y', 'N', NULL, 'UUID', 'group', NULL, NULL, NULL, NULL, NULL, NULL, 'bdfl_include', '1', NULL, 0, NULL, 0, NULL, 'admin', '2020-04-14 23:49:15', 'admin', '2020-04-14 23:42:53', NULL);
INSERT INTO `onl_cgform_head` VALUES ('4028818371790b3f0171795b83bd0003', 'bas_bank_account', 1, 2, '银行账户', 'Y', 'Y', 'Y', 'N', NULL, 'UUID', 'group', NULL, NULL, NULL, NULL, NULL, NULL, 'bdfl_include', '1', NULL, 0, NULL, 0, NULL, 'admin', '2020-04-14 23:46:52', 'admin', '2020-04-14 23:42:53', NULL);
INSERT INTO `onl_cgform_head` VALUES ('402881ea71684fa00171684fa0680000', 'stk_inventory', 1, 3, '库存', 'Y', 'Y', 'Y', 'N', NULL, 'UUID', 'group', NULL, NULL, NULL, NULL, NULL, NULL, 'bdfl_include', '1', NULL, 0, NULL, 0, NULL, 'admin', '2020-04-11 16:28:45', 'admin', '2020-04-11 16:16:22', NULL);
INSERT INTO `onl_cgform_head` VALUES ('402881fe71c8c4fd0171c8c4fdae0000', 'fin_receipt', 2, 3, '收款单', 'Y', 'Y', 'Y', 'N', NULL, 'UUID', 'group', NULL, 'fin_receipt_entry', NULL, NULL, NULL, NULL, 'bdfl_include', '3', NULL, 0, NULL, 0, NULL, 'admin', '2020-04-30 10:31:13', 'admin', '2020-04-30 09:48:06', NULL);
INSERT INTO `onl_cgform_head` VALUES ('402881fe71c8c4fd0171c8c500d30001', 'fin_receipt_entry', 3, 2, '收款明细', 'Y', 'Y', 'Y', 'N', NULL, 'UUID', 'group', 0, NULL, 1, NULL, NULL, NULL, 'bdfl_include', '1', NULL, 0, NULL, 0, NULL, 'admin', '2020-04-30 10:31:18', 'admin', '2020-04-30 09:48:07', NULL);
INSERT INTO `onl_cgform_head` VALUES ('402881fe71c8c4fd0171c8c503230002', 'fin_receivable', 1, 5, '应收单', 'Y', 'Y', 'Y', 'N', NULL, 'UUID', 'group', NULL, NULL, NULL, NULL, NULL, NULL, 'bdfl_include', '1', NULL, 0, NULL, 0, NULL, 'admin', '2020-04-30 10:30:53', 'admin', '2020-04-30 09:48:07', NULL);
INSERT INTO `onl_cgform_head` VALUES ('402881fe72268ef10172268ef1370000', 'stk_check_bill', 2, 8, '盘点卡', 'Y', 'Y', 'Y', 'N', NULL, 'UUID', 'group', NULL, 'stk_check_bill_entry', NULL, NULL, NULL, NULL, 'bdfl_include', '1', NULL, 1, NULL, 0, NULL, 'admin', '2020-05-18 15:55:37', 'admin', '2020-05-18 14:53:22', 'normal');
INSERT INTO `onl_cgform_head` VALUES ('402881fe72268ef10172268ef3ec0001', 'stk_check_bill_entry', 3, 2, '明细', 'Y', 'Y', 'Y', 'N', NULL, 'UUID', 'group', 0, NULL, 1, NULL, NULL, NULL, 'bdfl_include', '1', NULL, 1, NULL, 0, NULL, 'admin', '2020-05-18 15:55:44', 'admin', '2020-05-18 14:53:23', 'normal');
INSERT INTO `onl_cgform_head` VALUES ('402881fe72362af70172362af7150000', 'fin_pur_invoice', 2, 2, '采购发票登记', 'Y', 'Y', 'Y', 'N', NULL, 'UUID', 'group', NULL, 'fin_pur_invoice_entry', NULL, NULL, NULL, NULL, 'bdfl_include', '3', NULL, 1, NULL, 0, NULL, 'admin', '2020-05-21 20:23:51', 'admin', '2020-05-21 15:38:06', 'normal');
INSERT INTO `onl_cgform_head` VALUES ('402881fe72362af70172362afadf0001', 'fin_pur_invoice_entry', 3, 2, '采购发票登记明细', 'Y', 'Y', 'Y', 'N', NULL, 'UUID', 'group', 0, NULL, 1, NULL, NULL, NULL, 'bdfl_include', '1', NULL, 1, NULL, 0, NULL, 'admin', '2020-05-21 20:23:56', 'admin', '2020-05-21 15:38:06', 'normal');
INSERT INTO `onl_cgform_head` VALUES ('402881fe724af1fc01724af1fc0c0000', 'bas_biz_period', 1, 2, 'bas_biz_period', 'Y', 'Y', 'Y', 'N', NULL, 'UUID', 'group', NULL, NULL, NULL, NULL, NULL, NULL, 'bdfl_include', '1', NULL, 1, NULL, 0, NULL, 'admin', '2020-05-25 16:39:51', 'admin', '2020-05-25 16:27:53', 'normal');
INSERT INTO `onl_cgform_head` VALUES ('402881fe724af1fc01724af1feaf0001', 'fin_rp_bal', 1, 3, 'fin_rp_bal', 'Y', 'Y', 'Y', 'N', NULL, 'UUID', 'group', NULL, NULL, NULL, NULL, NULL, NULL, 'bdfl_include', '1', NULL, 1, NULL, 0, NULL, 'admin', '2020-05-25 16:38:23', 'admin', '2020-05-25 16:27:53', 'normal');
INSERT INTO `onl_cgform_head` VALUES ('4adec929a6594108bef5b35ee9966e9f', 'demo_field_def_val_main', 2, 1, '示例：控件默认值（主表）', 'Y', 'Y', 'Y', 'N', NULL, 'UUID', 'single', NULL, 'demo_field_def_val_sub', NULL, NULL, NULL, NULL, 'demo', '1', NULL, 1, NULL, 0, NULL, 'admin', '2020-05-04 21:32:40', 'admin', '2020-04-10 19:35:57', 'normal');
INSERT INTO `onl_cgform_head` VALUES ('4fb8e12a697f4d5bbe9b9fb1e9009486', 'demo_field_def_val_sub', 3, 1, '示例：控件默认值（子表）', 'Y', 'Y', 'Y', 'N', NULL, 'UUID', 'single', 0, NULL, 1, NULL, NULL, NULL, 'demo', '1', NULL, 1, NULL, 0, NULL, 'admin', '2020-05-04 21:32:46', 'admin', '2020-04-10 19:47:01', 'normal');
INSERT INTO `onl_cgform_head` VALUES ('56870166aba54ebfacb20ba6c770bd73', 'test_order_main', 2, 5, '测试订单主表', 'N', 'Y', 'Y', 'N', NULL, 'UUID', 'single', NULL, 'test_order_product', NULL, NULL, NULL, NULL, 'bdfl_include', '2', NULL, 0, NULL, 0, NULL, 'admin', '2020-03-20 11:41:31', 'admin', '2019-04-20 11:38:39', 'normal');
INSERT INTO `onl_cgform_head` VALUES ('d35109c3632c4952a19ecc094943dd71', 'test_demo', 1, 15, '测试用户表', 'N', 'Y', 'Y', 'N', NULL, 'UUID', 'single', NULL, NULL, NULL, NULL, NULL, NULL, 'bdfl_include', '1', NULL, 0, NULL, 0, NULL, 'admin', '2020-02-23 18:12:08', 'admin', '2019-03-15 14:24:35', 'normal');
INSERT INTO `onl_cgform_head` VALUES ('deea5a8ec619460c9245ba85dbc59e80', 'test_order_product', 3, 9, '订单产品明细', 'N', 'Y', 'Y', 'N', NULL, 'UUID', 'single', 0, NULL, NULL, NULL, NULL, NULL, 'bdfl_include', '1', NULL, 0, NULL, 0, NULL, 'admin', '2020-03-15 17:37:24', 'admin', '2019-04-20 11:41:19', 'normal');

-- ----------------------------
-- Table structure for onl_cgform_index
-- ----------------------------
DROP TABLE IF EXISTS `onl_cgform_index`;
CREATE TABLE `onl_cgform_index`  (
  `id` varchar(36) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '主键',
  `cgform_head_id` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '主表id',
  `index_name` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '索引名称',
  `index_field` varchar(500) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '索引栏位',
  `index_type` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '索引类型',
  `create_by` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '创建人登录名称',
  `create_time` datetime(0) NULL DEFAULT NULL COMMENT '创建日期',
  `update_by` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '更新人登录名称',
  `update_time` datetime(0) NULL DEFAULT NULL COMMENT '更新日期',
  `is_db_synch` varchar(2) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT 'N' COMMENT '是否同步数据库 N未同步 Y已同步',
  `del_flag` int(1) NULL DEFAULT 0 COMMENT '是否删除 0未删除 1删除',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `index_table_id`(`cgform_head_id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for onl_cgreport_head
-- ----------------------------
DROP TABLE IF EXISTS `onl_cgreport_head`;
CREATE TABLE `onl_cgreport_head`  (
  `id` varchar(36) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `code` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '报表编码',
  `name` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '报表名字',
  `cgr_sql` varchar(1000) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '报表SQL',
  `return_val_field` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '返回值字段',
  `return_txt_field` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '返回文本字段',
  `return_type` varchar(2) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '1' COMMENT '返回类型，单选或多选',
  `db_source` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '动态数据源',
  `content` varchar(1000) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '描述',
  `update_time` datetime(0) NULL DEFAULT NULL COMMENT '修改时间',
  `update_by` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '修改人id',
  `create_time` datetime(0) NULL DEFAULT NULL COMMENT '创建时间',
  `create_by` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '创建人id',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `index_onlinereport_code`(`code`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of onl_cgreport_head
-- ----------------------------
INSERT INTO `onl_cgreport_head` VALUES ('1259783869488844801', 'gross-profit-by-out-bill', '商品毛利（出库单）', 'SELECT CAST(b.bill_date AS DATE) AS bill_date, b.bill_no, b.customer_id, c.`name` AS customer_name, \n			 b.clerk_id, u.realname AS clerk_name, e.material_id, m.`name` AS material_name, \n			 e.warehouse_id, w.`name` AS warehouse_name, e.batch_no, e.unit_id, mu.`name` AS unit_name,\n			 e.qty, e.cost, e.settle_qty, e.settle_price, e.settle_amt,\n			 e.settle_amt - e.cost AS profit,\n			 e.remark, e.remark2, e.remark3\n  FROM stk_io_bill b\n  JOIN stk_io_bill_entry e ON b.id = e.mid\n	JOIN bas_customer c ON b.customer_id = c.id\n	LEFT JOIN sys_user u ON b.clerk_id = u.username\n	LEFT JOIN bas_material m ON e.material_id = m.id\n	LEFT JOIN bas_warehouse w ON e.warehouse_id = w.id\n	LEFT JOIN bas_measure_unit mu ON e.unit_id = mu.id\n WHERE b.is_approved = 1\n   AND b.is_voided = 0', NULL, NULL, '1', NULL, NULL, '2020-05-11 22:25:56', 'admin', '2020-05-11 17:54:15', 'admin');
INSERT INTO `onl_cgreport_head` VALUES ('1260569956423487489', 'stk-pur-in-bill', '采购入库单', 'SELECT b.id, b.bill_no, b.bill_date, b.supplier_id, s.name supplier_name, b.clerk_id, u.realname clerk_name\n  FROM stk_io_bill b\n	JOIN bas_supplier s ON b.supplier_id = s.id\n	LEFT JOIN sys_user u ON b.clerk_id = u.username\n WHERE b.is_approved = 1 AND b.is_voided = 0 \n   AND b.stock_io_type = \'101\'', NULL, NULL, '1', NULL, NULL, '2020-05-23 16:43:02', 'admin', '2020-05-13 21:57:53', 'admin');
INSERT INTO `onl_cgreport_head` VALUES ('1261479821635354626', 'stk-sal-out-bill', '销售出库单', 'SELECT b.id, b.bill_no, b.bill_date, b.customer_id, s.name customer_name, b.clerk_id, u.realname clerk_name\n	FROM stk_io_bill b\n	JOIN bas_customer s ON b.customer_id = s.id\n	LEFT JOIN sys_user u ON b.clerk_id = u.username\n WHERE b.is_approved = 1 AND b.is_voided = 0 \n	 AND b.stock_io_type = \'201\'', NULL, NULL, '1', NULL, NULL, '2020-05-23 16:42:34', 'admin', '2020-05-16 10:13:21', 'admin');
INSERT INTO `onl_cgreport_head` VALUES ('1264115611825766401', 'fin-pur-invoice', '采购发票', 'SELECT b.id, b.bill_no, b.bill_date, b.supplier_id, s.name supplier_name, b.clerk_id, u.realname clerk_name\n	FROM fin_pur_invoice b\n	JOIN bas_supplier s ON b.supplier_id = s.id\n	LEFT JOIN sys_user u ON b.clerk_id = u.username\n WHERE b.is_approved = 1 AND b.is_voided = 0 \n	 AND b.is_rubric = 0', NULL, NULL, '1', NULL, NULL, NULL, NULL, '2020-05-23 16:47:03', 'admin');
INSERT INTO `onl_cgreport_head` VALUES ('1264480038387372034', 'fin-sal-invoice', '销售发票', 'SELECT b.id, b.bill_no, b.bill_date, b.customer_id, c.name customer_name, b.clerk_id, u.realname clerk_name\n	FROM fin_sal_invoice b\n	JOIN bas_customer c ON b.customer_id = c.id\n	LEFT JOIN sys_user u ON b.clerk_id = u.username\n WHERE b.is_approved = 1 AND b.is_voided = 0 \n	 AND b.is_rubric = 0', NULL, NULL, '1', NULL, NULL, NULL, NULL, '2020-05-24 16:55:09', 'admin');
INSERT INTO `onl_cgreport_head` VALUES ('49d9b3c81f5647dea5b4d1f431613920', 'stk_inventory_batch', '库存批次', 'SELECT i.id AS id, i.batch_no AS batch_no, i.qty AS qty, i.cost as cost,\n			 i.material_id AS material_id, m.name material_name, \n			 i.warehouse_id AS warehouse_id, w.name AS warehouse_name, \n       i.unit_id AS unit_id, u.name AS unit_name,\n       i.supplier_id AS supplier_id, s.name AS supplier_name\n  FROM stk_inventory i \n INNER JOIN bas_material m \n INNER JOIN bas_warehouse w\n INNER JOIN bas_measure_unit u\n INNER JOIN bas_supplier s\n    ON i.material_id = m.id\n   AND i.warehouse_id = w.id\n   AND i.unit_id = u.id\n   AND i.supplier_id = s.id\n WHERE i.is_closed = 0\n', NULL, NULL, '1', NULL, NULL, '2020-05-08 15:28:47', 'admin', '2020-05-02 11:44:34', 'admin');
INSERT INTO `onl_cgreport_head` VALUES ('6c7f59741c814347905a938f06ee003c', 'report_user', '统计在线用户', 'select * from sys_user', NULL, NULL, '1', NULL, NULL, '2019-11-22 16:34:31', 'admin', '2019-03-25 11:20:45', 'admin');
INSERT INTO `onl_cgreport_head` VALUES ('87b55a515d3441b6b98e48e5b35474a6', 'demo', 'Report Demo', 'select * from demo', NULL, NULL, '1', NULL, NULL, '2019-03-15 18:18:17', 'admin', '2019-03-12 11:25:16', 'admin');

-- ----------------------------
-- Table structure for onl_cgreport_item
-- ----------------------------
DROP TABLE IF EXISTS `onl_cgreport_item`;
CREATE TABLE `onl_cgreport_item`  (
  `id` varchar(36) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `cgrhead_id` varchar(36) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '报表ID',
  `field_name` varchar(36) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '字段名字',
  `field_txt` varchar(300) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '字段文本',
  `field_width` int(3) NULL DEFAULT NULL,
  `field_type` varchar(10) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '字段类型',
  `search_mode` varchar(10) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '查询模式',
  `is_order` int(2) NULL DEFAULT 0 COMMENT '是否排序  0否,1是',
  `is_search` int(2) NULL DEFAULT 0 COMMENT '是否查询  0否,1是',
  `dict_code` varchar(500) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '字典CODE',
  `field_href` varchar(120) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '字段跳转URL',
  `is_show` int(2) NULL DEFAULT 1 COMMENT '是否显示  0否,1显示',
  `order_num` int(11) NULL DEFAULT NULL COMMENT '排序',
  `replace_val` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '取值表达式',
  `create_by` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '创建人',
  `create_time` datetime(0) NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '修改人',
  `update_time` datetime(0) NULL DEFAULT NULL COMMENT '修改时间',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `index_CGRHEAD_ID`(`cgrhead_id`) USING BTREE,
  INDEX `index_isshow`(`is_show`) USING BTREE,
  INDEX `index_order_num`(`order_num`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of onl_cgreport_item
-- ----------------------------
INSERT INTO `onl_cgreport_item` VALUES ('0aefd78fefd75f7df928d67cfb3460c9', '49d9b3c81f5647dea5b4d1f431613920', 'material_id', '物料ID', NULL, 'String', 'single', 0, 1, '', '', 0, 9, '', 'admin', '2020-05-08 15:28:47', NULL, NULL);
INSERT INTO `onl_cgreport_item` VALUES ('1258057428510388225', '49d9b3c81f5647dea5b4d1f431613920', 'id', 'id', NULL, 'String', NULL, 0, 0, '', '', 0, 8, '', 'admin', '2020-05-08 15:28:47', NULL, NULL);
INSERT INTO `onl_cgreport_item` VALUES ('1258396229569032197', '49d9b3c81f5647dea5b4d1f431613920', 'warehouse_name', '仓库', NULL, 'String', NULL, 0, 0, '', '', 1, 2, '', 'admin', '2020-05-08 15:28:47', NULL, NULL);
INSERT INTO `onl_cgreport_item` VALUES ('1258591076045197316', '49d9b3c81f5647dea5b4d1f431613920', 'qty', '库存数量', NULL, 'Number', NULL, 0, 0, '', '', 1, 5, '', 'admin', '2020-05-08 15:28:47', NULL, NULL);
INSERT INTO `onl_cgreport_item` VALUES ('1258591076045197321', '49d9b3c81f5647dea5b4d1f431613920', 'unit_id', 'unit_id', NULL, 'String', NULL, 0, 0, '', '', 0, 11, '', 'admin', '2020-05-08 15:28:47', NULL, NULL);
INSERT INTO `onl_cgreport_item` VALUES ('1258591076045197322', '49d9b3c81f5647dea5b4d1f431613920', 'unit_name', '计量单位', NULL, 'String', NULL, 0, 0, '', '', 1, 4, '', 'admin', '2020-05-08 15:28:47', NULL, NULL);
INSERT INTO `onl_cgreport_item` VALUES ('1258591076045197323', '49d9b3c81f5647dea5b4d1f431613920', 'supplier_id', 'supplier_id', NULL, 'String', NULL, 0, 0, '', '', 0, 10, '', 'admin', '2020-05-08 15:28:47', NULL, NULL);
INSERT INTO `onl_cgreport_item` VALUES ('1258591076045197324', '49d9b3c81f5647dea5b4d1f431613920', 'supplier_name', '供应商', NULL, 'String', NULL, 0, 0, '', '', 1, 7, '', 'admin', '2020-05-08 15:28:47', NULL, NULL);
INSERT INTO `onl_cgreport_item` VALUES ('1258660079409205253', '49d9b3c81f5647dea5b4d1f431613920', 'cost', '成本', NULL, 'String', NULL, 0, 0, '', '', 1, 6, '', 'admin', '2020-05-08 15:28:47', NULL, NULL);
INSERT INTO `onl_cgreport_item` VALUES ('1259783870029910017', '1259783869488844801', 'bill_date', '出库日期', NULL, 'Date', 'group', 0, 1, '', '', 1, 1, '', 'admin', '2020-05-11 22:25:56', NULL, NULL);
INSERT INTO `onl_cgreport_item` VALUES ('1259783870046687234', '1259783869488844801', 'bill_no', '出库单', NULL, 'String', NULL, 0, 0, '', '', 1, 2, '', 'admin', '2020-05-11 22:25:56', NULL, NULL);
INSERT INTO `onl_cgreport_item` VALUES ('1259783870059270145', '1259783869488844801', 'customer_id', 'customer_id', NULL, 'String', NULL, 0, 0, '', '', 0, 3, '', 'admin', '2020-05-11 22:25:56', NULL, NULL);
INSERT INTO `onl_cgreport_item` VALUES ('1259783870059270146', '1259783869488844801', 'customer_name', '客户', NULL, 'String', NULL, 0, 0, '', '', 1, 4, '', 'admin', '2020-05-11 22:25:56', NULL, NULL);
INSERT INTO `onl_cgreport_item` VALUES ('1259783870071853058', '1259783869488844801', 'clerk_id', 'clerk_id', NULL, 'String', NULL, 0, 0, '', '', 0, 5, '', 'admin', '2020-05-11 22:25:56', NULL, NULL);
INSERT INTO `onl_cgreport_item` VALUES ('1259783870071853059', '1259783869488844801', 'clerk_name', '业务员', NULL, 'String', NULL, 0, 0, '', '', 1, 6, '', 'admin', '2020-05-11 22:25:56', NULL, NULL);
INSERT INTO `onl_cgreport_item` VALUES ('1259783870071853060', '1259783869488844801', 'material_id', 'material_id', NULL, 'String', NULL, 0, 0, '', '', 0, 7, '', 'admin', '2020-05-11 22:25:56', NULL, NULL);
INSERT INTO `onl_cgreport_item` VALUES ('1259783870076047362', '1259783869488844801', 'material_name', '物料', NULL, 'String', NULL, 0, 0, '', '', 1, 8, '', 'admin', '2020-05-11 22:25:56', NULL, NULL);
INSERT INTO `onl_cgreport_item` VALUES ('1259783870076047363', '1259783869488844801', 'warehouse_id', 'warehouse_id', NULL, 'String', NULL, 0, 0, '', '', 0, 9, '', 'admin', '2020-05-11 22:25:56', NULL, NULL);
INSERT INTO `onl_cgreport_item` VALUES ('1259783870076047364', '1259783869488844801', 'warehouse_name', '仓库', NULL, 'String', NULL, 0, 0, '', '', 1, 10, '', 'admin', '2020-05-11 22:25:56', NULL, NULL);
INSERT INTO `onl_cgreport_item` VALUES ('1259783870076047365', '1259783869488844801', 'batch_no', '批次', NULL, 'String', NULL, 0, 0, '', '', 1, 11, '', 'admin', '2020-05-11 22:25:56', NULL, NULL);
INSERT INTO `onl_cgreport_item` VALUES ('1259783870080241665', '1259783869488844801', 'unit_id', 'unit_id', NULL, 'String', NULL, 0, 0, '', '', 0, 12, '', 'admin', '2020-05-11 22:25:56', NULL, NULL);
INSERT INTO `onl_cgreport_item` VALUES ('1259783870080241666', '1259783869488844801', 'unit_name', '单位', NULL, 'String', NULL, 0, 0, '', '', 1, 13, '', 'admin', '2020-05-11 22:25:56', NULL, NULL);
INSERT INTO `onl_cgreport_item` VALUES ('1259783870080241667', '1259783869488844801', 'qty', '出库数量', NULL, 'String', NULL, 0, 0, '', '', 1, 14, '', 'admin', '2020-05-11 22:25:56', NULL, NULL);
INSERT INTO `onl_cgreport_item` VALUES ('1259783870084435969', '1259783869488844801', 'cost', '出库成本', NULL, 'String', NULL, 0, 0, '', '', 1, 15, '', 'admin', '2020-05-11 22:25:56', NULL, NULL);
INSERT INTO `onl_cgreport_item` VALUES ('1259783870084435970', '1259783869488844801', 'settle_qty', '结算数量', NULL, 'String', NULL, 0, 0, '', '', 1, 16, '', 'admin', '2020-05-11 22:25:56', NULL, NULL);
INSERT INTO `onl_cgreport_item` VALUES ('1259783870101213185', '1259783869488844801', 'settle_price', '销售价格', NULL, 'String', NULL, 0, 0, '', '', 1, 17, '', 'admin', '2020-05-11 22:25:56', NULL, NULL);
INSERT INTO `onl_cgreport_item` VALUES ('1259783870101213186', '1259783869488844801', 'settle_amt', '结算金额', NULL, 'String', NULL, 0, 0, '', '', 1, 18, '', 'admin', '2020-05-11 22:25:56', NULL, NULL);
INSERT INTO `onl_cgreport_item` VALUES ('1259783870109601794', '1259783869488844801', 'profit', '毛利', NULL, 'String', NULL, 0, 0, '', '', 1, 19, '', 'admin', '2020-05-11 22:25:56', NULL, NULL);
INSERT INTO `onl_cgreport_item` VALUES ('1259783870109601795', '1259783869488844801', 'remark', '备注', NULL, 'String', NULL, 0, 0, '', '', 1, 20, '', 'admin', '2020-05-11 22:25:56', NULL, NULL);
INSERT INTO `onl_cgreport_item` VALUES ('1259783870113796098', '1259783869488844801', 'remark2', '备注2', NULL, 'String', NULL, 0, 0, '', '', 1, 21, '', 'admin', '2020-05-11 22:25:56', NULL, NULL);
INSERT INTO `onl_cgreport_item` VALUES ('1259783870113796099', '1259783869488844801', 'remark3', '备注3', NULL, 'String', NULL, 0, 0, '', '', 1, 22, '', 'admin', '2020-05-11 22:25:56', NULL, NULL);
INSERT INTO `onl_cgreport_item` VALUES ('1260569958680023041', '1260569956423487489', 'id', 'id', NULL, 'String', NULL, 0, 0, '', '', 0, 1, '', 'admin', '2020-05-23 16:43:02', NULL, NULL);
INSERT INTO `onl_cgreport_item` VALUES ('1260569958717771778', '1260569956423487489', 'bill_no', '单据编号', NULL, 'String', 'single', 0, 1, '', '', 1, 2, '', 'admin', '2020-05-23 16:43:02', NULL, NULL);
INSERT INTO `onl_cgreport_item` VALUES ('1260569958747131905', '1260569956423487489', 'bill_date', '单据日期', NULL, 'Date', 'group', 0, 1, '', '', 1, 3, '', 'admin', '2020-05-23 16:43:02', NULL, NULL);
INSERT INTO `onl_cgreport_item` VALUES ('1260569958755520513', '1260569956423487489', 'supplier_id', '供应商id', NULL, 'String', 'single', 0, 1, '', '', 0, 4, '', 'admin', '2020-05-23 16:43:02', NULL, NULL);
INSERT INTO `onl_cgreport_item` VALUES ('1260569958763909121', '1260569956423487489', 'supplier_name', '供应商', NULL, 'String', NULL, 0, 0, '', '', 1, 5, '', 'admin', '2020-05-23 16:43:02', NULL, NULL);
INSERT INTO `onl_cgreport_item` VALUES ('1260569958780686337', '1260569956423487489', 'clerk_id', '业务员id', NULL, 'String', 'single', 0, 0, '', '', 0, 6, '', 'admin', '2020-05-23 16:43:02', NULL, NULL);
INSERT INTO `onl_cgreport_item` VALUES ('1260569958810046465', '1260569956423487489', 'clerk_name', '业务员', NULL, 'String', NULL, 0, 0, '', '', 1, 7, '', 'admin', '2020-05-23 16:43:02', NULL, NULL);
INSERT INTO `onl_cgreport_item` VALUES ('1261479821916372994', '1261479821635354626', 'id', 'id', NULL, 'String', NULL, 0, 0, '', '', 0, 1, '', 'admin', '2020-05-23 16:42:34', NULL, NULL);
INSERT INTO `onl_cgreport_item` VALUES ('1261479821928955906', '1261479821635354626', 'bill_no', '单据编号', NULL, 'String', 'single', 0, 1, '', '', 1, 2, '', 'admin', '2020-05-23 16:42:34', NULL, NULL);
INSERT INTO `onl_cgreport_item` VALUES ('1261479821945733121', '1261479821635354626', 'bill_date', '单据日期', NULL, 'String', 'group', 0, 1, '', '', 1, 3, '', 'admin', '2020-05-23 16:42:34', NULL, NULL);
INSERT INTO `onl_cgreport_item` VALUES ('1261479821962510338', '1261479821635354626', 'customer_id', '客户id', NULL, 'String', 'single', 0, 1, '', '', 0, 4, '', 'admin', '2020-05-23 16:42:34', NULL, NULL);
INSERT INTO `onl_cgreport_item` VALUES ('1261479821962510339', '1261479821635354626', 'customer_name', '客户', NULL, 'String', NULL, 0, 0, '', '', 1, 5, '', 'admin', '2020-05-23 16:42:34', NULL, NULL);
INSERT INTO `onl_cgreport_item` VALUES ('1261479821970898945', '1261479821635354626', 'clerk_id', '业务员id', NULL, 'String', NULL, 0, 0, '', '', 0, 6, '', 'admin', '2020-05-23 16:42:34', NULL, NULL);
INSERT INTO `onl_cgreport_item` VALUES ('1261479821970898946', '1261479821635354626', 'clerk_name', '业务员', NULL, 'String', NULL, 0, 0, '', '', 1, 7, '', 'admin', '2020-05-23 16:42:34', NULL, NULL);
INSERT INTO `onl_cgreport_item` VALUES ('1264115612941451265', '1264115611825766401', 'id', 'id', NULL, 'String', NULL, 0, 0, '', '', 0, 1, '', 'admin', '2020-05-23 16:47:03', NULL, NULL);
INSERT INTO `onl_cgreport_item` VALUES ('1264115612949839873', '1264115611825766401', 'bill_no', '单据编号', NULL, 'String', NULL, 0, 1, '', '', 1, 2, '', 'admin', '2020-05-23 16:47:03', NULL, NULL);
INSERT INTO `onl_cgreport_item` VALUES ('1264115612949839874', '1264115611825766401', 'bill_date', '单据日期', NULL, 'String', NULL, 0, 1, '', '', 1, 3, '', 'admin', '2020-05-23 16:47:03', NULL, NULL);
INSERT INTO `onl_cgreport_item` VALUES ('1264115612958228482', '1264115611825766401', 'supplier_id', '供应商id', NULL, 'String', NULL, 0, 1, '', '', 1, 4, '', 'admin', '2020-05-23 16:47:03', NULL, NULL);
INSERT INTO `onl_cgreport_item` VALUES ('1264115612958228483', '1264115611825766401', 'supplier_name', '供应商', NULL, 'String', NULL, 0, 0, '', '', 1, 5, '', 'admin', '2020-05-23 16:47:03', NULL, NULL);
INSERT INTO `onl_cgreport_item` VALUES ('1264115612962422785', '1264115611825766401', 'clerk_id', '业务员id', NULL, 'String', NULL, 0, 0, '', '', 0, 6, '', 'admin', '2020-05-23 16:47:03', NULL, NULL);
INSERT INTO `onl_cgreport_item` VALUES ('1264115612962422786', '1264115611825766401', 'clerk_name', '业务员', NULL, 'String', NULL, 0, 0, '', '', 1, 7, '', 'admin', '2020-05-23 16:47:03', NULL, NULL);
INSERT INTO `onl_cgreport_item` VALUES ('1264480041679900673', '1264480038387372034', 'id', 'id', NULL, 'String', NULL, 0, 0, '', '', 0, 1, '', 'admin', '2020-05-24 16:55:09', NULL, NULL);
INSERT INTO `onl_cgreport_item` VALUES ('1264480041700872193', '1264480038387372034', 'bill_no', '单据编号', NULL, 'String', 'single', 0, 1, '', '', 1, 2, '', 'admin', '2020-05-24 16:55:10', NULL, NULL);
INSERT INTO `onl_cgreport_item` VALUES ('1264480041717649409', '1264480038387372034', 'bill_date', '单据日期', NULL, 'Date', 'group', 0, 1, '', '', 1, 3, '', 'admin', '2020-05-24 16:55:10', NULL, NULL);
INSERT INTO `onl_cgreport_item` VALUES ('1264480041759592450', '1264480038387372034', 'customer_id', 'customer_id', NULL, 'String', 'single', 0, 1, '', '', 0, 4, '', 'admin', '2020-05-24 16:55:10', NULL, NULL);
INSERT INTO `onl_cgreport_item` VALUES ('1264480041784758274', '1264480038387372034', 'customer_name', '客户', NULL, 'String', NULL, 0, 0, '', '', 1, 5, '', 'admin', '2020-05-24 16:55:10', NULL, NULL);
INSERT INTO `onl_cgreport_item` VALUES ('1264480041797341186', '1264480038387372034', 'clerk_id', 'clerk_id', NULL, 'String', NULL, 0, 0, '', '', 0, 6, '', 'admin', '2020-05-24 16:55:10', NULL, NULL);
INSERT INTO `onl_cgreport_item` VALUES ('1264480041801535489', '1264480038387372034', 'clerk_name', '业务员', NULL, 'String', NULL, 0, 0, '', '', 1, 7, '', 'admin', '2020-05-24 16:55:10', NULL, NULL);
INSERT INTO `onl_cgreport_item` VALUES ('1740bb02519db90c44cb2cba8b755136', '6c7f59741c814347905a938f06ee003c', 'realname', '用户名称', NULL, 'String', NULL, 0, 0, '', '', 1, 3, '', 'admin', '2019-11-22 16:34:31', NULL, NULL);
INSERT INTO `onl_cgreport_item` VALUES ('1b181e6d2813bcb263adc39737f9df46', '87b55a515d3441b6b98e48e5b35474a6', 'name', '用户名', NULL, 'String', 'single', 0, 1, '', '', 1, 4, '', 'admin', '2019-03-20 19:26:39', 'admin', '2019-03-27 18:05:04');
INSERT INTO `onl_cgreport_item` VALUES ('2_1588431681022', '49d9b3c81f5647dea5b4d1f431613920', 'material_name', '物料', NULL, 'String', 'single', 0, 0, '', '', 1, 1, '', 'admin', '2020-05-08 15:28:47', NULL, NULL);
INSERT INTO `onl_cgreport_item` VALUES ('61ef5b323134938fdd07ad5e3ea16cd3', '87b55a515d3441b6b98e48e5b35474a6', 'key_word', '关键词', NULL, 'String', 'single', 0, 1, '', '', 1, 5, '', 'admin', '2019-03-20 19:26:39', 'admin', '2019-03-27 18:05:04');
INSERT INTO `onl_cgreport_item` VALUES ('627768efd9ba2c41e905579048f21000', '6c7f59741c814347905a938f06ee003c', 'username', '用户账号', NULL, 'String', 'single', 0, 1, '', '', 1, 2, '', 'admin', '2019-11-22 16:34:31', NULL, NULL);
INSERT INTO `onl_cgreport_item` VALUES ('8bb087a9aa2000bcae17a1b3f5768435', '6c7f59741c814347905a938f06ee003c', 'sex', '性别', NULL, 'Integer', 'single', 0, 1, 'sex', '', 1, 5, '', 'admin', '2019-11-22 16:34:31', NULL, NULL);
INSERT INTO `onl_cgreport_item` VALUES ('90d4fa57d301801abb26a9b86b6b94c4', '6c7f59741c814347905a938f06ee003c', 'birthday', '生日', NULL, 'Date', 'single', 0, 0, '', '', 1, 4, '', 'admin', '2019-11-22 16:34:31', NULL, NULL);
INSERT INTO `onl_cgreport_item` VALUES ('a0ea31c603b440451c0f711d73ce8746', '49d9b3c81f5647dea5b4d1f431613920', 'warehouse_id', '仓库ID', NULL, 'String', 'single', 0, 1, '', '', 0, 10, '', 'admin', '2020-05-08 15:28:47', NULL, NULL);
INSERT INTO `onl_cgreport_item` VALUES ('a4ac355f07a05218854e5f23e2930163', '6c7f59741c814347905a938f06ee003c', 'avatar', '头像', NULL, 'String', NULL, 0, 0, '', '', 0, 6, '', 'admin', '2019-11-22 16:34:31', NULL, NULL);
INSERT INTO `onl_cgreport_item` VALUES ('ae4d621e391a1392779175cf5a65134c', '87b55a515d3441b6b98e48e5b35474a6', 'update_by', '修改人', NULL, 'String', NULL, 0, 0, '', '', 1, 7, '', 'admin', '2019-03-20 19:26:39', 'admin', '2019-03-27 18:05:04');
INSERT INTO `onl_cgreport_item` VALUES ('b27bea35b1264003c79d38cb86d6929e', '6c7f59741c814347905a938f06ee003c', 'id', 'id', NULL, 'String', NULL, 0, 0, '', '', 0, 1, '', 'admin', '2019-11-22 16:34:31', NULL, NULL);
INSERT INTO `onl_cgreport_item` VALUES ('ce5168755a734ea09dd190e28bf8d9f4', '87b55a515d3441b6b98e48e5b35474a6', 'update_time', '修改时间', NULL, 'String', NULL, 0, 0, '', '', 1, 2, '', 'admin', '2019-03-20 19:26:39', 'admin', '2019-03-27 18:05:04');
INSERT INTO `onl_cgreport_item` VALUES ('d6e86b5ffd096ddcc445c0f320a45004', '6c7f59741c814347905a938f06ee003c', 'phone', '手机号', NULL, 'String', NULL, 0, 0, '', '', 1, 11, '', 'admin', '2019-11-22 16:34:31', NULL, NULL);
INSERT INTO `onl_cgreport_item` VALUES ('df365cd357699eea96c29763d1dd7f9d', '6c7f59741c814347905a938f06ee003c', 'email', '邮箱', NULL, 'String', NULL, 0, 0, '', '', 1, 14, '', 'admin', '2019-11-22 16:34:31', NULL, NULL);
INSERT INTO `onl_cgreport_item` VALUES ('eb3b94253d4b82300c5854a2e0ac772b', '49d9b3c81f5647dea5b4d1f431613920', 'batch_no', '批次号', NULL, 'String', 'single', 0, 1, '', '', 1, 3, '', 'admin', '2020-05-08 15:28:47', NULL, NULL);
INSERT INTO `onl_cgreport_item` VALUES ('edf9932912b81ad01dd557d3d593a559', '87b55a515d3441b6b98e48e5b35474a6', 'age', '年龄', NULL, 'String', NULL, 0, 0, '', '', 1, 8, '', 'admin', '2019-03-20 19:26:39', 'admin', '2019-03-27 18:05:04');
INSERT INTO `onl_cgreport_item` VALUES ('f985883e509a6faaaf62ca07fd24a73c', '87b55a515d3441b6b98e48e5b35474a6', 'birthday', '生日', NULL, 'Date', 'single', 0, 1, '', '', 1, 1, '', 'admin', '2019-03-20 19:26:39', 'admin', '2019-03-27 18:05:04');
INSERT INTO `onl_cgreport_item` VALUES ('fce83e4258de3e2f114ab3116397670c', '87b55a515d3441b6b98e48e5b35474a6', 'punch_time', '发布时间', NULL, 'String', NULL, 0, 0, '', '', 1, 3, '', 'admin', '2019-03-20 19:26:39', 'admin', '2019-03-27 18:05:04');

-- ----------------------------
-- Table structure for onl_cgreport_param
-- ----------------------------
DROP TABLE IF EXISTS `onl_cgreport_param`;
CREATE TABLE `onl_cgreport_param`  (
  `id` varchar(36) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `cgrhead_id` varchar(36) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '动态报表ID',
  `param_name` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '参数字段',
  `param_txt` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '参数文本',
  `param_value` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '参数默认值',
  `order_num` int(11) NULL DEFAULT NULL COMMENT '排序',
  `create_by` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '创建人登录名称',
  `create_time` datetime(0) NULL DEFAULT NULL COMMENT '创建日期',
  `update_by` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '更新人登录名称',
  `update_time` datetime(0) NULL DEFAULT NULL COMMENT '更新日期',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `idx_cgrheadid`(`cgrhead_id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for oss_file
-- ----------------------------
DROP TABLE IF EXISTS `oss_file`;
CREATE TABLE `oss_file`  (
  `id` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '主键id',
  `file_name` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '文件名称',
  `url` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '文件地址',
  `create_by` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '创建人登录名称',
  `create_time` datetime(0) NULL DEFAULT NULL COMMENT '创建日期',
  `update_by` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '更新人登录名称',
  `update_time` datetime(0) NULL DEFAULT NULL COMMENT '更新日期',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = 'Oss File' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for qrtz_blob_triggers
-- ----------------------------
DROP TABLE IF EXISTS `qrtz_blob_triggers`;
CREATE TABLE `qrtz_blob_triggers`  (
  `SCHED_NAME` varchar(120) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `TRIGGER_NAME` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `TRIGGER_GROUP` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `BLOB_DATA` blob NULL,
  PRIMARY KEY (`SCHED_NAME`, `TRIGGER_NAME`, `TRIGGER_GROUP`) USING BTREE,
  CONSTRAINT `qrtz_blob_triggers_ibfk_1` FOREIGN KEY (`SCHED_NAME`, `TRIGGER_NAME`, `TRIGGER_GROUP`) REFERENCES `qrtz_triggers` (`SCHED_NAME`, `TRIGGER_NAME`, `TRIGGER_GROUP`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = 'InnoDB free: 504832 kB; (`SCHED_NAME` `TRIGGER_NAME` `TRIGGE' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for qrtz_calendars
-- ----------------------------
DROP TABLE IF EXISTS `qrtz_calendars`;
CREATE TABLE `qrtz_calendars`  (
  `SCHED_NAME` varchar(120) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `CALENDAR_NAME` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `CALENDAR` blob NOT NULL,
  PRIMARY KEY (`SCHED_NAME`, `CALENDAR_NAME`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for qrtz_cron_triggers
-- ----------------------------
DROP TABLE IF EXISTS `qrtz_cron_triggers`;
CREATE TABLE `qrtz_cron_triggers`  (
  `SCHED_NAME` varchar(120) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `TRIGGER_NAME` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `TRIGGER_GROUP` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `CRON_EXPRESSION` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `TIME_ZONE_ID` varchar(80) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  PRIMARY KEY (`SCHED_NAME`, `TRIGGER_NAME`, `TRIGGER_GROUP`) USING BTREE,
  CONSTRAINT `qrtz_cron_triggers_ibfk_1` FOREIGN KEY (`SCHED_NAME`, `TRIGGER_NAME`, `TRIGGER_GROUP`) REFERENCES `qrtz_triggers` (`SCHED_NAME`, `TRIGGER_NAME`, `TRIGGER_GROUP`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = 'InnoDB free: 504832 kB; (`SCHED_NAME` `TRIGGER_NAME` `TRIGGE' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for qrtz_fired_triggers
-- ----------------------------
DROP TABLE IF EXISTS `qrtz_fired_triggers`;
CREATE TABLE `qrtz_fired_triggers`  (
  `SCHED_NAME` varchar(120) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `ENTRY_ID` varchar(95) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `TRIGGER_NAME` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `TRIGGER_GROUP` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `INSTANCE_NAME` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `FIRED_TIME` bigint(13) NOT NULL,
  `SCHED_TIME` bigint(13) NOT NULL,
  `PRIORITY` int(11) NOT NULL,
  `STATE` varchar(16) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `JOB_NAME` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `JOB_GROUP` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `IS_NONCONCURRENT` varchar(1) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `REQUESTS_RECOVERY` varchar(1) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  PRIMARY KEY (`SCHED_NAME`, `ENTRY_ID`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for qrtz_job_details
-- ----------------------------
DROP TABLE IF EXISTS `qrtz_job_details`;
CREATE TABLE `qrtz_job_details`  (
  `SCHED_NAME` varchar(120) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `JOB_NAME` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `JOB_GROUP` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `DESCRIPTION` varchar(250) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `JOB_CLASS_NAME` varchar(250) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `IS_DURABLE` varchar(1) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `IS_NONCONCURRENT` varchar(1) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `IS_UPDATE_DATA` varchar(1) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `REQUESTS_RECOVERY` varchar(1) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `JOB_DATA` blob NULL,
  PRIMARY KEY (`SCHED_NAME`, `JOB_NAME`, `JOB_GROUP`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for qrtz_locks
-- ----------------------------
DROP TABLE IF EXISTS `qrtz_locks`;
CREATE TABLE `qrtz_locks`  (
  `SCHED_NAME` varchar(120) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `LOCK_NAME` varchar(40) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  PRIMARY KEY (`SCHED_NAME`, `LOCK_NAME`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of qrtz_locks
-- ----------------------------
INSERT INTO `qrtz_locks` VALUES ('MyScheduler', 'STATE_ACCESS');
INSERT INTO `qrtz_locks` VALUES ('MyScheduler', 'TRIGGER_ACCESS');
INSERT INTO `qrtz_locks` VALUES ('quartzScheduler', 'TRIGGER_ACCESS');

-- ----------------------------
-- Table structure for qrtz_paused_trigger_grps
-- ----------------------------
DROP TABLE IF EXISTS `qrtz_paused_trigger_grps`;
CREATE TABLE `qrtz_paused_trigger_grps`  (
  `SCHED_NAME` varchar(120) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `TRIGGER_GROUP` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  PRIMARY KEY (`SCHED_NAME`, `TRIGGER_GROUP`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for qrtz_scheduler_state
-- ----------------------------
DROP TABLE IF EXISTS `qrtz_scheduler_state`;
CREATE TABLE `qrtz_scheduler_state`  (
  `SCHED_NAME` varchar(120) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `INSTANCE_NAME` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `LAST_CHECKIN_TIME` bigint(13) NOT NULL,
  `CHECKIN_INTERVAL` bigint(13) NOT NULL,
  PRIMARY KEY (`SCHED_NAME`, `INSTANCE_NAME`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of qrtz_scheduler_state
-- ----------------------------
INSERT INTO `qrtz_scheduler_state` VALUES ('MyScheduler', 'DESKTOP-K92IK2K1591253375516', 1591258384921, 10000);

-- ----------------------------
-- Table structure for qrtz_simple_triggers
-- ----------------------------
DROP TABLE IF EXISTS `qrtz_simple_triggers`;
CREATE TABLE `qrtz_simple_triggers`  (
  `SCHED_NAME` varchar(120) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `TRIGGER_NAME` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `TRIGGER_GROUP` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `REPEAT_COUNT` bigint(7) NOT NULL,
  `REPEAT_INTERVAL` bigint(12) NOT NULL,
  `TIMES_TRIGGERED` bigint(10) NOT NULL,
  PRIMARY KEY (`SCHED_NAME`, `TRIGGER_NAME`, `TRIGGER_GROUP`) USING BTREE,
  CONSTRAINT `qrtz_simple_triggers_ibfk_1` FOREIGN KEY (`SCHED_NAME`, `TRIGGER_NAME`, `TRIGGER_GROUP`) REFERENCES `qrtz_triggers` (`SCHED_NAME`, `TRIGGER_NAME`, `TRIGGER_GROUP`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = 'InnoDB free: 504832 kB; (`SCHED_NAME` `TRIGGER_NAME` `TRIGGE' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for qrtz_simprop_triggers
-- ----------------------------
DROP TABLE IF EXISTS `qrtz_simprop_triggers`;
CREATE TABLE `qrtz_simprop_triggers`  (
  `SCHED_NAME` varchar(120) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `TRIGGER_NAME` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `TRIGGER_GROUP` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `STR_PROP_1` varchar(512) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `STR_PROP_2` varchar(512) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `STR_PROP_3` varchar(512) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `INT_PROP_1` int(11) NULL DEFAULT NULL,
  `INT_PROP_2` int(11) NULL DEFAULT NULL,
  `LONG_PROP_1` bigint(20) NULL DEFAULT NULL,
  `LONG_PROP_2` bigint(20) NULL DEFAULT NULL,
  `DEC_PROP_1` decimal(13, 4) NULL DEFAULT NULL,
  `DEC_PROP_2` decimal(13, 4) NULL DEFAULT NULL,
  `BOOL_PROP_1` varchar(1) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `BOOL_PROP_2` varchar(1) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  PRIMARY KEY (`SCHED_NAME`, `TRIGGER_NAME`, `TRIGGER_GROUP`) USING BTREE,
  CONSTRAINT `qrtz_simprop_triggers_ibfk_1` FOREIGN KEY (`SCHED_NAME`, `TRIGGER_NAME`, `TRIGGER_GROUP`) REFERENCES `qrtz_triggers` (`SCHED_NAME`, `TRIGGER_NAME`, `TRIGGER_GROUP`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = 'InnoDB free: 504832 kB; (`SCHED_NAME` `TRIGGER_NAME` `TRIGGE' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for qrtz_triggers
-- ----------------------------
DROP TABLE IF EXISTS `qrtz_triggers`;
CREATE TABLE `qrtz_triggers`  (
  `SCHED_NAME` varchar(120) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `TRIGGER_NAME` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `TRIGGER_GROUP` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `JOB_NAME` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `JOB_GROUP` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `DESCRIPTION` varchar(250) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `NEXT_FIRE_TIME` bigint(13) NULL DEFAULT NULL,
  `PREV_FIRE_TIME` bigint(13) NULL DEFAULT NULL,
  `PRIORITY` int(11) NULL DEFAULT NULL,
  `TRIGGER_STATE` varchar(16) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `TRIGGER_TYPE` varchar(8) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `START_TIME` bigint(13) NOT NULL,
  `END_TIME` bigint(13) NULL DEFAULT NULL,
  `CALENDAR_NAME` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `MISFIRE_INSTR` smallint(2) NULL DEFAULT NULL,
  `JOB_DATA` blob NULL,
  PRIMARY KEY (`SCHED_NAME`, `TRIGGER_NAME`, `TRIGGER_GROUP`) USING BTREE,
  INDEX `SCHED_NAME`(`SCHED_NAME`, `JOB_NAME`, `JOB_GROUP`) USING BTREE,
  CONSTRAINT `qrtz_triggers_ibfk_1` FOREIGN KEY (`SCHED_NAME`, `JOB_NAME`, `JOB_GROUP`) REFERENCES `qrtz_job_details` (`SCHED_NAME`, `JOB_NAME`, `JOB_GROUP`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = 'InnoDB free: 504832 kB; (`SCHED_NAME` `JOB_NAME` `JOB_GROUP`' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for stk_check_bill
-- ----------------------------
DROP TABLE IF EXISTS `stk_check_bill`;
CREATE TABLE `stk_check_bill`  (
  `id` varchar(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT 'ID',
  `bill_no` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '单据编号',
  `bill_date` date NOT NULL COMMENT '单据日期',
  `warehouse_id` varchar(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '仓库',
  `material_category_id` varchar(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '物料分类',
  `checker_id` varchar(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '盘点人',
  `attachment` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '附件',
  `remark` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '备注',
  `bill_proc_status` varchar(4) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '处理状态',
  `approver_id` varchar(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '审核人',
  `flow_id` varchar(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '流程id',
  `is_approved` int(3) NOT NULL DEFAULT 0 COMMENT '是否通过',
  `effective_time` datetime(0) NULL DEFAULT NULL COMMENT '生效时间',
  `is_voided` int(3) NOT NULL DEFAULT 0 COMMENT '是否作废',
  `is_closed` int(3) NOT NULL DEFAULT 0 COMMENT '是否关闭',
  `sys_org_code` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '创建部门',
  `create_by` varchar(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '创建人',
  `create_time` datetime(0) NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '修改人',
  `update_time` datetime(0) NULL DEFAULT NULL COMMENT '修改时间',
  `version` int(11) NULL DEFAULT NULL COMMENT '版本',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `uk_stockcount`(`bill_no`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '盘点单' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of stk_check_bill
-- ----------------------------
INSERT INTO `stk_check_bill` VALUES ('1262735188071731201', 'STC-20200519-000060', '2020-05-19', '40288183712beaa901712c1935d10006', NULL, NULL, NULL, NULL, '23', 'admin', NULL, 1, '2020-05-20 23:15:29', 0, 0, 'A01', 'admin', '2020-05-19 00:00:00', 'admin', '2020-05-20 23:15:29', NULL);
INSERT INTO `stk_check_bill` VALUES ('1267993977747451905', 'STC-20200603-000018', '2020-06-03', '40288183712beaa901712c19f6da0007', NULL, NULL, NULL, NULL, '12', NULL, NULL, 0, NULL, 0, 0, 'A01', 'admin', '2020-06-03 09:38:17', NULL, NULL, NULL);
INSERT INTO `stk_check_bill` VALUES ('1267996140477370369', 'STC-20200603-000019', '2020-06-03', '40288183712beaa901712c19f6da0007', NULL, NULL, NULL, NULL, '12', NULL, NULL, 0, NULL, 0, 0, 'A01', 'admin', '2020-06-03 09:46:53', NULL, NULL, NULL);
INSERT INTO `stk_check_bill` VALUES ('1268000517917265921', 'STC-20200603-000026', '2020-06-03', '40288183712beaa901712c19f6da0007', NULL, NULL, NULL, NULL, '12', NULL, NULL, 0, NULL, 0, 0, 'A01', 'admin', '2020-06-03 10:04:16', NULL, NULL, NULL);

-- ----------------------------
-- Table structure for stk_check_bill_entry
-- ----------------------------
DROP TABLE IF EXISTS `stk_check_bill_entry`;
CREATE TABLE `stk_check_bill_entry`  (
  `id` varchar(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT 'ID',
  `mid` varchar(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '主表',
  `bill_no` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '单据编号',
  `entry_no` int(11) NOT NULL DEFAULT 0 COMMENT '分录号',
  `is_new_batch` int(3) NOT NULL COMMENT '是否新批次',
  `warehouse_id` varchar(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '仓库',
  `material_id` varchar(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '物料',
  `batch_no` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '批号',
  `supplier_id` varchar(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '供应商',
  `unit_id` varchar(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '计量单位',
  `book_qty` decimal(18, 6) NOT NULL DEFAULT 0.000000 COMMENT '账存数量',
  `qty` decimal(18, 6) NULL DEFAULT NULL COMMENT '实存数量',
  `remark` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '备注',
  `remark2` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '备注2',
  `remark3` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '备注3',
  `version` int(11) NULL DEFAULT NULL COMMENT '版本号',
  PRIMARY KEY (`material_id`, `warehouse_id`, `batch_no`, `id`) USING BTREE,
  INDEX `uk_stockcount_entry`(`mid`, `entry_no`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '盘点单明细' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of stk_check_bill_entry
-- ----------------------------
INSERT INTO `stk_check_bill_entry` VALUES ('15898944759861750865', '1262735188071731201', 'STC-20200519-000060', 2, 0, '40288183712beaa901712c1935d10006', '15853854026861', '1', '40288183712beaa901712c2243390008', '40288101710a4c6201710a65913d0002', 0.000000, 1.100000, '', '', '', NULL);
INSERT INTO `stk_check_bill_entry` VALUES ('15898944759862688912', '1262735188071731201', 'STC-20200519-000060', 3, 0, '40288183712beaa901712c1935d10006', '15853854026861', '2', '40288183712beaa901712c2243390008', '40288101710a4c6201710a65913d0002', 0.000000, 1.000000, '', '', '', NULL);
INSERT INTO `stk_check_bill_entry` VALUES ('15899446900930985049', '1262735188071731201', 'STC-20200519-000060', 101, 1, '40288183712beaa901712c1935d10006', '15853854026861', 'STC-20200519-000060-101', NULL, '40288101710a4c6201710a6618cc0003', 0.000000, 1.000000, '', '', '', NULL);
INSERT INTO `stk_check_bill_entry` VALUES ('15898944759863927357', '1262735188071731201', 'STC-20200519-000060', 4, 0, '40288183712beaa901712c1935d10006', '15853854026861', 'STK-20200509-000007-10', NULL, '40288101710a4c6201710a65913d0002', 1100.000000, 1000.000000, '', '', '', NULL);
INSERT INTO `stk_check_bill_entry` VALUES ('15898944759850111783', '1262735188071731201', 'STC-20200519-000060', 1, 0, '40288183712beaa901712c1935d10006', '4028818370f308e90170f354f3820008', 'STK-20200402-000001-10', '40288183712beaa901712c2243390008', '40288101710a4c6201710a65913d0002', 883.000000, 880.000000, '', '', '', NULL);
INSERT INTO `stk_check_bill_entry` VALUES ('15911482923661491973', '1267993977747451905', 'STC-20200603-000018', 2, 0, '40288183712beaa901712c19f6da0007', '4028818370f308e90170f354f3820008', '1', '40288183712beaa901712c2243390008', '40288101710a4c6201710a65913d0002', 1000.000000, NULL, '', '', '', NULL);
INSERT INTO `stk_check_bill_entry` VALUES ('15911488110831748835', '1267996140477370369', 'STC-20200603-000019', 2, 0, '40288183712beaa901712c19f6da0007', '4028818370f308e90170f354f3820008', '1', '40288183712beaa901712c2243390008', '40288101710a4c6201710a65913d0002', 1000.000000, NULL, '', '', '', NULL);
INSERT INTO `stk_check_bill_entry` VALUES ('15911498550401467983', '1268000517917265921', 'STC-20200603-000026', 2, 0, '40288183712beaa901712c19f6da0007', '4028818370f308e90170f354f3820008', '1', '40288183712beaa901712c2243390008', '40288101710a4c6201710a65913d0002', 1000.000000, NULL, '', '', '', NULL);
INSERT INTO `stk_check_bill_entry` VALUES ('15898944759864551251', '1262735188071731201', 'STC-20200519-000060', 5, 0, '40288183712beaa901712c19f6da0007', '4028818370f308e90170f354f3820008', 'STK-20200402-000001-10', NULL, '40288101710a4c6201710a65913d0002', 100.000000, 110.000000, '', '', '', NULL);
INSERT INTO `stk_check_bill_entry` VALUES ('15911482923650899356', '1267993977747451905', 'STC-20200603-000018', 1, 0, '40288183712beaa901712c19f6da0007', '4028818370f308e90170f354f3820008', 'STK-20200402-000001-10', NULL, '40288101710a4c6201710a65913d0002', 130.000000, NULL, '', '', '', NULL);
INSERT INTO `stk_check_bill_entry` VALUES ('15911488110830730241', '1267996140477370369', 'STC-20200603-000019', 1, 0, '40288183712beaa901712c19f6da0007', '4028818370f308e90170f354f3820008', 'STK-20200402-000001-10', NULL, '40288101710a4c6201710a65913d0002', 130.000000, NULL, '', '', '', NULL);
INSERT INTO `stk_check_bill_entry` VALUES ('15911498550390582223', '1268000517917265921', 'STC-20200603-000026', 1, 0, '40288183712beaa901712c19f6da0007', '4028818370f308e90170f354f3820008', 'STK-20200402-000001-10', NULL, '40288101710a4c6201710a65913d0002', 130.000000, NULL, '', '', '', NULL);
INSERT INTO `stk_check_bill_entry` VALUES ('15911482923662101021', '1267993977747451905', 'STC-20200603-000018', 3, 0, '40288183712beaa901712c19f6da0007', '4028818370f308e90170f367e435000c', '1', '40288183712beaa901712c2243390008', '40288101710a4c6201710a6618cc0003', 22.000000, NULL, '', '', '', NULL);
INSERT INTO `stk_check_bill_entry` VALUES ('15911488110832642444', '1267996140477370369', 'STC-20200603-000019', 3, 0, '40288183712beaa901712c19f6da0007', '4028818370f308e90170f367e435000c', '1', '40288183712beaa901712c2243390008', '40288101710a4c6201710a6618cc0003', 22.000000, NULL, '', '', '', NULL);
INSERT INTO `stk_check_bill_entry` VALUES ('15911498550402361838', '1268000517917265921', 'STC-20200603-000026', 3, 0, '40288183712beaa901712c19f6da0007', '4028818370f308e90170f367e435000c', '1', '40288183712beaa901712c2243390008', '40288101710a4c6201710a6618cc0003', 22.000000, NULL, '', '', '', NULL);

-- ----------------------------
-- Table structure for stk_inventory
-- ----------------------------
DROP TABLE IF EXISTS `stk_inventory`;
CREATE TABLE `stk_inventory`  (
  `id` varchar(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT 'ID',
  `warehouse_id` varchar(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '仓库',
  `material_id` varchar(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '物料',
  `batch_no` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '0' COMMENT '批号',
  `unit_id` varchar(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '计量单位',
  `qty` decimal(18, 6) NOT NULL COMMENT '数量',
  `cost` decimal(18, 2) NOT NULL COMMENT '成本',
  `is_single_supplier` int(3) NOT NULL DEFAULT 1 COMMENT '单供应商',
  `supplier_id` varchar(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '供应商',
  `is_closed` int(3) NOT NULL DEFAULT 0 COMMENT '是否关闭',
  `sys_org_code` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '创建部门',
  `create_by` varchar(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '创建人',
  `create_time` datetime(0) NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '修改人',
  `update_time` datetime(0) NULL DEFAULT NULL COMMENT '修改时间',
  `version` int(11) NULL DEFAULT 0 COMMENT '版本',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `UK_inventory`(`material_id`, `warehouse_id`, `batch_no`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '库存' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of stk_inventory
-- ----------------------------
INSERT INTO `stk_inventory` VALUES ('1249531420539957250', '40288183712beaa901712c1935d10006', '4028818370f308e90170f354f3820008', 'STK-20200402-000001-10', '40288101710a4c6201710a65913d0002', 875.000000, 357.00, 1, '40288183712beaa901712c2243390008', 0, 'A01', 'admin', '2020-04-13 10:54:40', 'admin', '2020-05-21 11:25:59', 0);
INSERT INTO `stk_inventory` VALUES ('1249978558649380866', '40288183712beaa901712c1935d10006', '15853854026861', '1', '40288101710a4c6201710a65913d0002', 3.300000, 3.00, 1, '40288183712beaa901712c2243390008', 0, 'A01', 'admin', '2020-04-14 16:31:27', 'admin', '2020-05-21 11:25:59', 0);
INSERT INTO `stk_inventory` VALUES ('1249990339165859841', '40288183712beaa901712c1935d10006', '15853854026861', '2', '40288101710a4c6201710a65913d0002', 3.000000, 0.00, 1, '40288183712beaa901712c2243390008', 0, 'A01', 'admin', '2020-04-14 17:18:15', 'admin', '2020-05-20 23:15:29', 0);
INSERT INTO `stk_inventory` VALUES ('1259827525348380674', '40288183712beaa901712c1935d10006', '15853854026861', 'STK-20200509-000007-10', '40288101710a4c6201710a65913d0002', 800.000000, 10.00, 0, NULL, 0, 'A01', 'admin', '2020-05-11 20:47:43', 'admin', '2020-05-20 23:15:29', 0);
INSERT INTO `stk_inventory` VALUES ('1262028867336814594', '40288183712beaa901712c19f6da0007', '4028818370f308e90170f354f3820008', 'STK-20200402-000001-10', '40288101710a4c6201710a65913d0002', 130.000000, 40.44, 0, NULL, 0, 'A01', 'admin', '2020-05-17 22:35:04', 'admin', '2020-05-20 23:15:29', 0);
INSERT INTO `stk_inventory` VALUES ('1263126201579798530', '40288183712beaa901712c1935d10006', '15853854026861', 'STC-20200519-000060-101', '40288101710a4c6201710a65913d0002', 1000.000000, 0.00, 0, NULL, 0, 'A01', 'admin', '2020-05-20 23:15:29', NULL, NULL, 0);
INSERT INTO `stk_inventory` VALUES ('1263719901780520961', '40288183712beaa901712c19f6da0007', '4028818370f308e90170f354f3820008', '1', '40288101710a4c6201710a65913d0002', 1000.000000, 10.00, 1, '40288183712beaa901712c2243390008', 0, 'A01', 'admin', '2020-05-22 14:34:38', NULL, NULL, 0);
INSERT INTO `stk_inventory` VALUES ('1263719901809881090', '40288183712beaa901712c19f6da0007', '4028818370f308e90170f367e435000c', '1', '40288101710a4c6201710a6618cc0003', 22.000000, 11.00, 1, '40288183712beaa901712c2243390008', 0, 'A01', 'admin', '2020-05-22 14:34:38', NULL, NULL, 0);
INSERT INTO `stk_inventory` VALUES ('1263719901851824130', '40288183712beaa901712c1935d10006', '4028818370f308e90170f354f3820008', 'STK-20200331-000027-30', '40288101710a4c6201710a65913d0002', 11000.000000, 1.00, 1, '40288183712beaa901712c2243390008', 0, 'A01', 'admin', '2020-05-22 14:34:38', NULL, NULL, 0);

-- ----------------------------
-- Table structure for stk_io_bill
-- ----------------------------
DROP TABLE IF EXISTS `stk_io_bill`;
CREATE TABLE `stk_io_bill`  (
  `id` varchar(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT 'ID',
  `bill_no` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '单据编号',
  `stock_io_type` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '出入库类型',
  `is_auto` int(3) NOT NULL DEFAULT 0 COMMENT '是否自动生成',
  `is_rubric` int(3) NOT NULL DEFAULT 0 COMMENT '是否红字',
  `bill_date` datetime(0) NOT NULL COMMENT '单据日期',
  `source_type` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '源单类型',
  `source_id` varchar(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '源单id',
  `source_no` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '源单号',
  `clerk_id` varchar(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '业务员',
  `handler_id` varchar(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '出入库经办',
  `has_rp` int(3) NULL DEFAULT NULL COMMENT '是否有往来',
  `is_same_settle` int(3) NOT NULL DEFAULT 0 COMMENT '结算是否相同',
  `supplier_id` varchar(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '供应商',
  `customer_id` varchar(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '客户',
  `attachment` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '附件',
  `remark` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '备注',
  `bill_proc_status` varchar(4) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '单据处理状态',
  `approver_id` varchar(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '审核人',
  `flow_id` varchar(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '流程id',
  `is_approved` int(3) NULL DEFAULT 0 COMMENT '是否通过',
  `effective_time` datetime(0) NULL DEFAULT NULL COMMENT '生效时间',
  `is_voided` int(3) NULL DEFAULT 0 COMMENT '是否作废',
  `is_closed` int(3) NULL DEFAULT 0 COMMENT '是否关闭',
  `sys_org_code` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '创建部门',
  `create_by` varchar(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '创建人',
  `create_time` datetime(0) NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '修改人',
  `update_time` datetime(0) NULL DEFAULT NULL COMMENT '修改时间',
  `version` int(11) NULL DEFAULT NULL COMMENT '版本',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `uk_stk_io_bill_no`(`bill_no`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '出入库单' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of stk_io_bill
-- ----------------------------
INSERT INTO `stk_io_bill` VALUES ('1244985551059550210', 'STK-20200331-000027', '101', 0, 0, '2020-03-31 00:00:00', NULL, NULL, NULL, 'admin', 'admin', 1, 1, '40288183712beaa901712c2243390008', NULL, NULL, 'testaabbb', '23', 'admin', NULL, 1, '2020-05-22 14:34:38', 0, 0, 'A01', 'test22', '2020-03-31 00:00:00', 'admin', '2020-05-22 14:34:38', NULL);
INSERT INTO `stk_io_bill` VALUES ('1245562990572982273', 'STK-20200402-000001', '101', 0, 0, '2020-04-02 00:00:00', NULL, NULL, NULL, 'zhagnxiao', 'admin', 1, 0, '40288183712beaa901712c2243390008', NULL, '', NULL, '23', 'admin', NULL, 1, '2020-04-13 23:08:41', 0, 0, 'A01', 'admin', '2020-04-02 00:00:00', 'admin', '2020-04-13 23:08:41', NULL);
INSERT INTO `stk_io_bill` VALUES ('1255762477564067841', 'STK-20200430-000002', '201', 0, 0, '2020-04-30 00:00:00', NULL, NULL, NULL, 'admin', NULL, 1, 1, '40288183712beaa901712c3b1e6f0009', '40288183712beaa901712c3b1e6f0009', NULL, NULL, '23', 'admin', NULL, 1, '2020-05-11 17:47:27', 0, 0, 'A01', 'admin', '2020-04-30 00:00:00', 'admin', '2020-05-11 17:47:27', NULL);
INSERT INTO `stk_io_bill` VALUES ('1259081476413485058', 'STK-20200509-000006', '299', 0, 0, '2020-05-09 00:00:00', NULL, NULL, NULL, NULL, NULL, 0, 0, NULL, NULL, NULL, NULL, '12', NULL, NULL, 0, NULL, 0, 0, 'A01', 'admin', '2020-05-09 00:00:00', 'admin', '2020-05-15 15:21:26', NULL);
INSERT INTO `stk_io_bill` VALUES ('1259081674695012354', 'STK-20200509-000007', '199', 0, 0, '2020-05-09 00:00:00', NULL, NULL, NULL, NULL, NULL, 0, 0, NULL, NULL, NULL, NULL, '23', 'admin', NULL, 1, '2020-05-11 20:47:43', 0, 0, 'A01', 'admin', '2020-05-09 00:00:00', 'admin', '2020-05-11 20:47:43', NULL);
INSERT INTO `stk_io_bill` VALUES ('1261095414874583041', 'STK-20200515-000001', '101', 0, 1, '2020-05-15 00:00:00', 'stk_io_bill..101', '1245562990572982273', 'STK-20200402-000001', NULL, NULL, 1, 0, '40288183712beaa901712c2243390008', NULL, NULL, NULL, '23', 'admin', NULL, 1, '2020-05-15 16:28:25', 0, 0, 'A01', 'admin', '2020-05-15 00:00:00', 'admin', '2020-05-15 16:28:25', NULL);
INSERT INTO `stk_io_bill` VALUES ('1261481089024000001', 'STK-20200516-000002', '201', 0, 1, '2020-05-16 00:00:00', 'stk_io_bill..201', '1255762477564067841', 'STK-20200430-000002', NULL, NULL, 1, 0, NULL, '40288183712beaa901712c3b1e6f0009', NULL, NULL, '12', NULL, NULL, 0, NULL, 0, 0, 'A01', 'admin', '2020-05-16 00:00:00', 'admin', '2020-06-02 22:31:04', NULL);
INSERT INTO `stk_io_bill` VALUES ('1262022664166719489', 'STK-20200517-000002', '301', 0, 0, '2020-05-17 00:00:00', NULL, NULL, NULL, NULL, NULL, 0, 0, NULL, NULL, NULL, NULL, '23', 'admin', NULL, 1, '2020-05-17 22:35:04', 0, 0, 'A01', 'admin', '2020-05-17 00:00:00', 'admin', '2020-05-17 22:35:04', NULL);
INSERT INTO `stk_io_bill` VALUES ('1262759374135672834', 'STK-20200519-000003', '301', 0, 0, '2020-05-19 00:00:00', NULL, NULL, NULL, NULL, NULL, 0, 0, NULL, NULL, NULL, NULL, '13', NULL, NULL, 0, NULL, 0, 0, 'A01', 'admin', '2020-05-19 22:57:50', NULL, NULL, NULL);
INSERT INTO `stk_io_bill` VALUES ('1263118874919190530', 'STK-20200520-000001', '102', 1, 0, '2020-05-20 22:46:22', 'stk_check_bill', '1262735188071731201', 'STC-20200519-000060', NULL, NULL, 0, 0, NULL, NULL, NULL, NULL, '23', 'admin', NULL, 1, '2020-05-20 22:46:22', 0, 0, 'A01', 'admin', '2020-05-20 22:46:22', NULL, NULL, NULL);
INSERT INTO `stk_io_bill` VALUES ('1263118875141488642', 'STK-20200520-000002', '202', 1, 0, '2020-05-20 22:46:22', 'stk_check_bill', '1262735188071731201', 'STC-20200519-000060', NULL, NULL, 0, 0, NULL, NULL, NULL, NULL, '23', 'admin', NULL, 1, '2020-05-20 22:46:22', 0, 0, 'A01', 'admin', '2020-05-20 22:46:22', NULL, NULL, NULL);
INSERT INTO `stk_io_bill` VALUES ('1263125881155944450', 'STK-20200520-000003', '102', 1, 0, '2020-05-20 23:14:12', 'stk_check_bill', '1262735188071731201', 'STC-20200519-000060', NULL, NULL, 0, 0, NULL, NULL, NULL, NULL, '23', 'admin', NULL, 1, '2020-05-20 23:14:12', 0, 0, 'A01', 'admin', '2020-05-20 23:14:12', NULL, NULL, NULL);
INSERT INTO `stk_io_bill` VALUES ('1263125881575374849', 'STK-20200520-000004', '202', 1, 0, '2020-05-20 23:14:13', 'stk_check_bill', '1262735188071731201', 'STC-20200519-000060', NULL, NULL, 0, 0, NULL, NULL, NULL, NULL, '23', 'admin', NULL, 1, '2020-05-20 23:14:13', 0, 0, 'A01', 'admin', '2020-05-20 23:14:13', NULL, NULL, NULL);
INSERT INTO `stk_io_bill` VALUES ('1263126201168756737', 'STK-20200520-000005', '102', 1, 0, '2020-05-20 23:15:29', 'stk_check_bill', '1262735188071731201', 'STC-20200519-000060', NULL, NULL, 0, 0, NULL, NULL, NULL, NULL, '23', 'admin', NULL, 1, '2020-05-20 23:15:29', 0, 0, 'A01', 'admin', '2020-05-20 23:15:29', NULL, NULL, NULL);
INSERT INTO `stk_io_bill` VALUES ('1263126201659490306', 'STK-20200520-000006', '202', 1, 0, '2020-05-20 23:15:29', 'stk_check_bill', '1262735188071731201', 'STC-20200519-000060', NULL, NULL, 0, 0, NULL, NULL, NULL, NULL, '23', 'admin', NULL, 1, '2020-05-20 23:15:29', 0, 0, 'A01', 'admin', '2020-05-20 23:15:29', NULL, NULL, NULL);
INSERT INTO `stk_io_bill` VALUES ('1263135699904167938', 'STK-20200520-000007', '102', 0, 0, '2020-05-20 00:00:00', NULL, NULL, NULL, NULL, NULL, 0, 0, NULL, NULL, NULL, NULL, '12', NULL, NULL, 0, NULL, 0, 0, 'A01', 'admin', '2020-05-20 23:53:13', NULL, NULL, NULL);
INSERT INTO `stk_io_bill` VALUES ('1263141910896640002', 'STK-20200521-000001', '202', 0, 0, '2020-05-21 00:00:00', NULL, NULL, NULL, NULL, NULL, 0, 0, NULL, NULL, NULL, NULL, '12', NULL, NULL, 0, NULL, 0, 0, 'A01', 'admin', '2020-05-21 00:17:54', NULL, NULL, NULL);
INSERT INTO `stk_io_bill` VALUES ('1263284569570373633', 'STK-20200521-000003', '191', 0, 0, '2020-05-21 00:00:00', NULL, NULL, NULL, NULL, NULL, 0, 0, NULL, NULL, NULL, NULL, '23', 'admin', NULL, 1, '2020-05-21 10:02:21', 0, 0, 'A01', 'admin', '2020-05-21 00:00:00', 'admin', '2020-05-21 10:02:21', NULL);
INSERT INTO `stk_io_bill` VALUES ('1263298532798459905', 'STK-20200521-000006', '191', 0, 0, '2020-05-21 00:00:00', NULL, NULL, NULL, 'admin', NULL, 0, 0, NULL, NULL, NULL, NULL, '12', NULL, NULL, 0, NULL, 0, 0, 'A01', 'admin', '2020-05-21 10:40:16', NULL, NULL, NULL);
INSERT INTO `stk_io_bill` VALUES ('1263309798296309762', 'STK-20200521-000008', '801', 0, 0, '2020-05-21 00:00:00', NULL, NULL, NULL, NULL, NULL, 0, 0, NULL, NULL, NULL, NULL, '23', 'admin', NULL, 1, '2020-05-21 11:25:59', 0, 0, 'A01', 'admin', '2020-05-21 00:00:00', 'admin', '2020-05-21 11:25:59', NULL);
INSERT INTO `stk_io_bill` VALUES ('1263510387176128513', 'STK-20200522-000002', '101', 0, 0, '2020-05-27 00:00:00', NULL, NULL, NULL, NULL, NULL, 1, 1, NULL, NULL, NULL, NULL, '12', NULL, NULL, 0, NULL, 0, 0, 'A01', 'admin', '2020-05-22 00:00:00', 'admin', '2020-06-01 23:24:22', NULL);

-- ----------------------------
-- Table structure for stk_io_bill_entry
-- ----------------------------
DROP TABLE IF EXISTS `stk_io_bill_entry`;
CREATE TABLE `stk_io_bill_entry`  (
  `id` varchar(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '0' COMMENT 'ID',
  `mid` varchar(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '主表',
  `bill_no` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '单据号',
  `entry_no` int(11) NOT NULL COMMENT '分录号',
  `source_type` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '源单类型',
  `source_entry_id` varchar(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '源单分录id',
  `source_entry_no` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '源单分录号',
  `material_id` varchar(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '物料',
  `unit_id` varchar(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '计量单位',
  `qty` decimal(18, 6) NOT NULL DEFAULT 0.000000 COMMENT '数量',
  `cost` decimal(18, 6) NOT NULL DEFAULT 0.000000 COMMENT '购进成本',
  `is_incl_tax` int(3) NULL DEFAULT NULL COMMENT '成本是否含税',
  `batch_no` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '批次号',
  `warehouse_id` varchar(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '仓库',
  `in_warehouse_id` varchar(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '调入仓库',
  `supplier_id` varchar(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `settle_qty` decimal(18, 6) NOT NULL DEFAULT 0.000000 COMMENT '结算数量',
  `settle_price` decimal(18, 6) NULL DEFAULT NULL COMMENT '含税单价',
  `settle_amt` decimal(18, 2) NOT NULL DEFAULT 0.00 COMMENT '结算金额',
  `tax_rate` decimal(6, 4) NULL DEFAULT NULL COMMENT '税率',
  `tax` decimal(18, 2) NOT NULL DEFAULT 0.00 COMMENT '税额',
  `discount_rate` decimal(10, 6) NULL DEFAULT 0.000000 COMMENT '折扣率',
  `discount_amt` decimal(18, 2) NOT NULL DEFAULT 0.00 COMMENT '折让金额',
  `discount_tax` decimal(18, 2) NOT NULL DEFAULT 0.00 COMMENT '折让税额',
  `invoiced_qty` decimal(18, 6) NOT NULL DEFAULT 0.000000 COMMENT '已开票数量',
  `invoiced_amt` decimal(18, 2) NOT NULL DEFAULT 0.00 COMMENT '已开票金额',
  `remark` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '备注',
  `remark2` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '备注2',
  `remark3` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '备注3',
  `version` int(10) NULL DEFAULT NULL COMMENT '版本',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `uk_stk_stockbill_entry`(`mid`, `entry_no`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '出入库单明细' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of stk_io_bill_entry
-- ----------------------------
INSERT INTO `stk_io_bill_entry` VALUES ('1263118874927579138', '1263118874919190530', 'STK-20200520-000001', 1, NULL, NULL, NULL, '15853854026861', '40288101710a4c6201710a65913d0002', 1.100000, 0.000000, NULL, '1', '40288183712beaa901712c1935d10006', NULL, '40288183712beaa901712c2243390008', 0.000000, NULL, 0.00, NULL, 0.00, 0.000000, 0.00, 0.00, 0.000000, 0.00, NULL, NULL, NULL, NULL);
INSERT INTO `stk_io_bill_entry` VALUES ('1263118874944356354', '1263118874919190530', 'STK-20200520-000001', 2, NULL, NULL, NULL, '15853854026861', '40288101710a4c6201710a65913d0002', 1.000000, 0.000000, NULL, '2', '40288183712beaa901712c1935d10006', NULL, '40288183712beaa901712c2243390008', 0.000000, NULL, 0.00, NULL, 0.00, 0.000000, 0.00, 0.00, 0.000000, 0.00, NULL, NULL, NULL, NULL);
INSERT INTO `stk_io_bill_entry` VALUES ('1263118874952744961', '1263118874919190530', 'STK-20200520-000001', 3, NULL, NULL, NULL, '15853854026861', '40288101710a4c6201710a6618cc0003', 1.000000, 0.000000, NULL, 'STC-20200519-000060-101', '40288183712beaa901712c1935d10006', NULL, NULL, 0.000000, NULL, 0.00, NULL, 0.00, 0.000000, 0.00, 0.00, 0.000000, 0.00, NULL, NULL, NULL, NULL);
INSERT INTO `stk_io_bill_entry` VALUES ('1263118874973716481', '1263118874919190530', 'STK-20200520-000001', 4, NULL, NULL, NULL, '4028818370f308e90170f354f3820008', '40288101710a4c6201710a65913d0002', 10.000000, 0.000000, NULL, 'STK-20200402-000001-10', '40288183712beaa901712c19f6da0007', NULL, NULL, 0.000000, NULL, 0.00, NULL, 0.00, 0.000000, 0.00, 0.00, 0.000000, 0.00, NULL, NULL, NULL, NULL);
INSERT INTO `stk_io_bill_entry` VALUES ('1263118875149877250', '1263118875141488642', 'STK-20200520-000002', 1, NULL, NULL, NULL, '15853854026861', '40288101710a4c6201710a65913d0002', 100.000000, 0.000000, NULL, 'STK-20200509-000007-10', '40288183712beaa901712c1935d10006', NULL, NULL, 0.000000, NULL, 0.00, NULL, 0.00, 0.000000, 0.00, 0.00, 0.000000, 0.00, NULL, NULL, NULL, NULL);
INSERT INTO `stk_io_bill_entry` VALUES ('1263118875158265857', '1263118875141488642', 'STK-20200520-000002', 2, NULL, NULL, NULL, '4028818370f308e90170f354f3820008', '40288101710a4c6201710a65913d0002', 3.000000, 0.000000, NULL, 'STK-20200402-000001-10', '40288183712beaa901712c1935d10006', NULL, '40288183712beaa901712c2243390008', 0.000000, NULL, 0.00, NULL, 0.00, 0.000000, 0.00, 0.00, 0.000000, 0.00, NULL, NULL, NULL, NULL);
INSERT INTO `stk_io_bill_entry` VALUES ('1263125881189498881', '1263125881155944450', 'STK-20200520-000003', 1, 'stk_check_bill.stk_check_bill_entry', '15898944759861750865', 'STC-20200519-000060.2', '15853854026861', '40288101710a4c6201710a65913d0002', 1.100000, 0.000000, NULL, '1', '40288183712beaa901712c1935d10006', NULL, '40288183712beaa901712c2243390008', 0.000000, NULL, 0.00, NULL, 0.00, 0.000000, 0.00, 0.00, 0.000000, 0.00, NULL, NULL, NULL, NULL);
INSERT INTO `stk_io_bill_entry` VALUES ('1263125881218859009', '1263125881155944450', 'STK-20200520-000003', 2, 'stk_check_bill.stk_check_bill_entry', '15898944759862688912', 'STC-20200519-000060.3', '15853854026861', '40288101710a4c6201710a65913d0002', 1.000000, 0.000000, NULL, '2', '40288183712beaa901712c1935d10006', NULL, '40288183712beaa901712c2243390008', 0.000000, NULL, 0.00, NULL, 0.00, 0.000000, 0.00, 0.00, 0.000000, 0.00, NULL, NULL, NULL, NULL);
INSERT INTO `stk_io_bill_entry` VALUES ('1263125881235636225', '1263125881155944450', 'STK-20200520-000003', 3, 'stk_check_bill.stk_check_bill_entry', '15899446900930985049', 'STC-20200519-000060.101', '15853854026861', '40288101710a4c6201710a6618cc0003', 1.000000, 0.000000, NULL, 'STC-20200519-000060-101', '40288183712beaa901712c1935d10006', NULL, NULL, 0.000000, NULL, 0.00, NULL, 0.00, 0.000000, 0.00, 0.00, 0.000000, 0.00, NULL, NULL, NULL, NULL);
INSERT INTO `stk_io_bill_entry` VALUES ('1263125881248219138', '1263125881155944450', 'STK-20200520-000003', 4, 'stk_check_bill.stk_check_bill_entry', '15898944759864551251', 'STC-20200519-000060.5', '4028818370f308e90170f354f3820008', '40288101710a4c6201710a65913d0002', 10.000000, 0.000000, NULL, 'STK-20200402-000001-10', '40288183712beaa901712c19f6da0007', NULL, NULL, 0.000000, NULL, 0.00, NULL, 0.00, 0.000000, 0.00, 0.00, 0.000000, 0.00, NULL, NULL, NULL, NULL);
INSERT INTO `stk_io_bill_entry` VALUES ('1263125881592152066', '1263125881575374849', 'STK-20200520-000004', 1, 'stk_check_bill.stk_check_bill_entry', '15898944759863927357', 'STC-20200519-000060.4', '15853854026861', '40288101710a4c6201710a65913d0002', 100.000000, 0.000000, NULL, 'STK-20200509-000007-10', '40288183712beaa901712c1935d10006', NULL, NULL, 0.000000, NULL, 0.00, NULL, 0.00, 0.000000, 0.00, 0.00, 0.000000, 0.00, NULL, NULL, NULL, NULL);
INSERT INTO `stk_io_bill_entry` VALUES ('1263125881608929282', '1263125881575374849', 'STK-20200520-000004', 2, 'stk_check_bill.stk_check_bill_entry', '15898944759850111783', 'STC-20200519-000060.1', '4028818370f308e90170f354f3820008', '40288101710a4c6201710a65913d0002', 3.000000, 0.000000, NULL, 'STK-20200402-000001-10', '40288183712beaa901712c1935d10006', NULL, '40288183712beaa901712c2243390008', 0.000000, NULL, 0.00, NULL, 0.00, 0.000000, 0.00, 0.00, 0.000000, 0.00, NULL, NULL, NULL, NULL);
INSERT INTO `stk_io_bill_entry` VALUES ('1263126201185533954', '1263126201168756737', 'STK-20200520-000005', 1, 'stk_check_bill.stk_check_bill_entry', '15898944759861750865', 'STC-20200519-000060.2', '15853854026861', '40288101710a4c6201710a65913d0002', 1.100000, 0.000000, NULL, '1', '40288183712beaa901712c1935d10006', NULL, '40288183712beaa901712c2243390008', 0.000000, NULL, 0.00, NULL, 0.00, 0.000000, 0.00, 0.00, 0.000000, 0.00, NULL, NULL, NULL, NULL);
INSERT INTO `stk_io_bill_entry` VALUES ('1263126201437192194', '1263126201168756737', 'STK-20200520-000005', 2, 'stk_check_bill.stk_check_bill_entry', '15898944759862688912', 'STC-20200519-000060.3', '15853854026861', '40288101710a4c6201710a65913d0002', 1.000000, 0.000000, NULL, '2', '40288183712beaa901712c1935d10006', NULL, '40288183712beaa901712c2243390008', 0.000000, NULL, 0.00, NULL, 0.00, 0.000000, 0.00, 0.00, 0.000000, 0.00, NULL, NULL, NULL, NULL);
INSERT INTO `stk_io_bill_entry` VALUES ('1263126201458163714', '1263126201168756737', 'STK-20200520-000005', 3, 'stk_check_bill.stk_check_bill_entry', '15899446900930985049', 'STC-20200519-000060.101', '15853854026861', '40288101710a4c6201710a6618cc0003', 1.000000, 0.000000, NULL, 'STC-20200519-000060-101', '40288183712beaa901712c1935d10006', NULL, NULL, 0.000000, NULL, 0.00, NULL, 0.00, 0.000000, 0.00, 0.00, 0.000000, 0.00, NULL, NULL, NULL, NULL);
INSERT INTO `stk_io_bill_entry` VALUES ('1263126201466552322', '1263126201168756737', 'STK-20200520-000005', 4, 'stk_check_bill.stk_check_bill_entry', '15898944759864551251', 'STC-20200519-000060.5', '4028818370f308e90170f354f3820008', '40288101710a4c6201710a65913d0002', 10.000000, 0.000000, NULL, 'STK-20200402-000001-10', '40288183712beaa901712c19f6da0007', NULL, NULL, 0.000000, NULL, 0.00, NULL, 0.00, 0.000000, 0.00, 0.00, 0.000000, 0.00, NULL, NULL, NULL, NULL);
INSERT INTO `stk_io_bill_entry` VALUES ('1263126201667878913', '1263126201659490306', 'STK-20200520-000006', 1, 'stk_check_bill.stk_check_bill_entry', '15898944759863927357', 'STC-20200519-000060.4', '15853854026861', '40288101710a4c6201710a65913d0002', 100.000000, 0.000000, NULL, 'STK-20200509-000007-10', '40288183712beaa901712c1935d10006', NULL, NULL, 0.000000, NULL, 0.00, NULL, 0.00, 0.000000, 0.00, 0.00, 0.000000, 0.00, NULL, NULL, NULL, NULL);
INSERT INTO `stk_io_bill_entry` VALUES ('1263126201667878914', '1263126201659490306', 'STK-20200520-000006', 2, 'stk_check_bill.stk_check_bill_entry', '15898944759850111783', 'STC-20200519-000060.1', '4028818370f308e90170f354f3820008', '40288101710a4c6201710a65913d0002', 3.000000, 0.000000, NULL, 'STK-20200402-000001-10', '40288183712beaa901712c1935d10006', NULL, '40288183712beaa901712c2243390008', 0.000000, NULL, 0.00, NULL, 0.00, 0.000000, 0.00, 0.00, 0.000000, 0.00, NULL, NULL, NULL, NULL);
INSERT INTO `stk_io_bill_entry` VALUES ('15856698893890', '1244985551059550210', 'STK-20200331-000027', 10, NULL, NULL, '', '4028818370f308e90170f354f3820008', '40288101710a4c6201710a6618cc0003', 1.000000, 10.000000, 1, '1', '40288183712beaa901712c19f6da0007', NULL, '40288183712beaa901712c2243390008', 1.000000, NULL, 10.00, NULL, 0.00, 0.000000, 0.00, 0.00, 1.000000, 100.00, '', '', '', NULL);
INSERT INTO `stk_io_bill_entry` VALUES ('15858319083191', '1244985551059550210', 'STK-20200331-000027', 20, NULL, NULL, '', '4028818370f308e90170f367e435000c', '40288101710a4c6201710a6618cc0003', 22.000000, 11.000000, 1, '1', '40288183712beaa901712c19f6da0007', NULL, '40288183712beaa901712c2243390008', 22.000000, NULL, 11.00, NULL, 0.00, 0.000000, 0.00, 0.00, 1.000000, 100.00, '', '', '', NULL);
INSERT INTO `stk_io_bill_entry` VALUES ('15860895260730', '1245562990572982273', 'STK-20200402-000001', 10, NULL, NULL, NULL, '4028818370f308e90170f354f3820008', '40288101710a4c6201710a6618cc0003', 1.000000, 100.000000, 1, 'STK-20200402-000001-10', '40288183712beaa901712c1935d10006', NULL, NULL, 10.000000, NULL, 100.00, NULL, 0.00, 0.000000, 0.00, 0.00, 1.000000, 0.00, '', '', '', NULL);
INSERT INTO `stk_io_bill_entry` VALUES ('15880015556352', '1244985551059550210', 'STK-20200331-000027', 30, NULL, NULL, '', '4028818370f308e90170f354f3820008', '40288101710a4c6201710a6618cc0003', 11.000000, 1.000000, 1, 'STK-20200331-000027-30', '40288183712beaa901712c1935d10006', NULL, '40288183712beaa901712c2243390008', 11.000000, NULL, 1.00, NULL, 0.00, 0.000000, 0.00, 0.00, 0.000000, 0.00, '', '', '', NULL);
INSERT INTO `stk_io_bill_entry` VALUES ('15889121955981144830', '1255762477564067841', 'STK-20200430-000002', 20, NULL, NULL, '', '4028818370f308e90170f354f3820008', '40288101710a4c6201710a65913d0002', 10.000000, 1.250000, NULL, 'STK-20200402-000001-10', '40288183712beaa901712c1935d10006', NULL, NULL, 10.000000, 0.500000, 5.00, NULL, 0.00, 0.000000, 0.00, 0.00, 0.000000, 0.00, '', '', '', NULL);
INSERT INTO `stk_io_bill_entry` VALUES ('15890233463810547180', '1259081476413485058', 'STK-20200509-000006', 10, NULL, NULL, '', '4028818370f308e90170f354f3820008', '40288101710a4c6201710a65913d0002', 1.000000, 0.250000, NULL, 'STK-20200402-000001-10', '40288183712beaa901712c1935d10006', NULL, NULL, 0.000000, NULL, 0.00, NULL, 0.00, 0.000000, 0.00, 0.00, 0.000000, 0.00, '', '', '', NULL);
INSERT INTO `stk_io_bill_entry` VALUES ('15892011766950711977', '1259081674695012354', 'STK-20200509-000007', 10, NULL, NULL, '', '15853854026861', '40288101710a4c6201710a6618cc0003', 1.100000, 10.000000, 1, 'STK-20200509-000007-10', '40288183712beaa901712c1935d10006', NULL, NULL, 0.000000, NULL, 0.00, NULL, 0.00, 0.000000, 0.00, 0.00, 0.000000, 0.00, '', '', '', NULL);
INSERT INTO `stk_io_bill_entry` VALUES ('15895035670000253502', '1261095414874583041', 'STK-20200515-000001', 10, 'stk_io_bill.stk_io_bill_entry.101', '15860895260730', '10', '4028818370f308e90170f354f3820008', '40288101710a4c6201710a6618cc0003', -1.000000, -100.000000, 1, 'STK-20200402-000001-10', '40288183712beaa901712c1935d10006', NULL, NULL, -1.000000, NULL, -100.00, NULL, 0.00, 0.000000, 0.00, 0.00, 0.000000, 0.00, '', '', '', NULL);
INSERT INTO `stk_io_bill_entry` VALUES ('15895270156571513969', '1259081476413485058', 'STK-20200509-000006', 20, NULL, NULL, '', '4028818370f308e90170f354f3820008', '40288101710a4c6201710a65913d0002', 1.000000, 5.020000, NULL, 'STK-20200402-000001-10', '40288183712beaa901712c1935d10006', NULL, NULL, 0.000000, NULL, 0.00, NULL, 0.00, 0.000000, 0.00, 0.00, 0.000000, 0.00, '', '', '', NULL);
INSERT INTO `stk_io_bill_entry` VALUES ('15895954984570463137', '1261481089024000001', 'STK-20200516-000002', 20, 'stk_io_bill.stk_io_bill_entry.201', '15889121955981144830', '20', '4028818370f308e90170f354f3820008', '40288101710a4c6201710a65913d0002', -10.000000, -1.250000, NULL, 'STK-20200402-000001-10', '40288183712beaa901712c1935d10006', NULL, NULL, -10.000000, 0.500000, -5.00, NULL, 0.00, 0.000000, 0.00, 0.00, 0.000000, 0.00, '', '', '', NULL);
INSERT INTO `stk_io_bill_entry` VALUES ('15897245163950245001', '1262022664166719489', 'STK-20200517-000002', 10, NULL, NULL, '', '4028818370f308e90170f354f3820008', '40288101710a4c6201710a65913d0002', 100.000000, 40.440000, NULL, 'STK-20200402-000001-10', '40288183712beaa901712c1935d10006', '40288183712beaa901712c19f6da0007', NULL, 0.000000, NULL, 0.00, NULL, 0.00, 0.000000, 0.00, 0.00, 0.000000, 0.00, '', '', '', NULL);
INSERT INTO `stk_io_bill_entry` VALUES ('15899002305310126998', '1262759374135672834', 'STK-20200519-000003', 10, NULL, NULL, '', '4028818370f308e90170f354f3820008', '40288101710a4c6201710a65913d0002', 1.000000, 0.400000, NULL, 'STK-20200402-000001-10', '40288183712beaa901712c1935d10006', '40288183712beaa901712c19f6da0007', NULL, 0.000000, NULL, 0.00, NULL, 0.00, 0.000000, 0.00, 0.00, 0.000000, 0.00, '', '', '', NULL);
INSERT INTO `stk_io_bill_entry` VALUES ('15899899337210979193', '1263135699904167938', 'STK-20200520-000007', 10, NULL, NULL, '', '4028818370f308e90170f354f3820008', '40288101710a4c6201710a6618cc0003', 1.000000, 2.000000, 1, 'STK-20200520-000007-10', '40288183712beaa901712c1935d10006', NULL, '40288183712beaa901712c2243390008', 0.000000, NULL, 0.00, NULL, 0.00, 0.000000, 0.00, 0.00, 0.000000, 0.00, '', '', '', NULL);
INSERT INTO `stk_io_bill_entry` VALUES ('15899913929640192232', '1263141910896640002', 'STK-20200521-000001', 10, NULL, NULL, '', '4028818370f308e90170f354f3820008', '40288101710a4c6201710a65913d0002', 1.000000, 0.410000, NULL, 'STK-20200402-000001-10', '40288183712beaa901712c1935d10006', NULL, NULL, 0.000000, NULL, 0.00, NULL, 0.00, 0.000000, 0.00, 0.00, 0.000000, 0.00, '', '', '', NULL);
INSERT INTO `stk_io_bill_entry` VALUES ('15900264960570329099', '1263284569570373633', 'STK-20200521-000003', 10, NULL, NULL, '', '4028818370f308e90170f354f3820008', '40288101710a4c6201710a65913d0002', 1.000000, 0.000000, NULL, 'STK-20200402-000001-10', '40288183712beaa901712c1935d10006', NULL, '40288183712beaa901712c2243390008', 0.000000, NULL, 0.00, NULL, 0.00, 0.000000, 0.00, 0.00, 0.000000, 0.00, '', '', '', NULL);
INSERT INTO `stk_io_bill_entry` VALUES ('15900314768480112580', '1263309798296309762', 'STK-20200521-000008', 10, NULL, NULL, '', '4028818370f308e90170f354f3820008', '0', 0.000000, -0.060000, NULL, 'STK-20200402-000001-10', '40288183712beaa901712c1935d10006', NULL, '40288183712beaa901712c2243390008', 0.000000, NULL, 0.00, NULL, 0.00, 0.000000, 0.00, 0.00, 0.000000, 0.00, '', '', '', NULL);
INSERT INTO `stk_io_bill_entry` VALUES ('15900315118931481788', '1263309798296309762', 'STK-20200521-000008', 20, NULL, NULL, '', '15853854026861', '0', 0.000000, 3.000000, NULL, '1', '40288183712beaa901712c1935d10006', NULL, '40288183712beaa901712c2243390008', 0.000000, NULL, 0.00, NULL, 0.00, 0.000000, 0.00, 0.00, 0.000000, 0.00, '', '', '', NULL);
INSERT INTO `stk_io_bill_entry` VALUES ('15900793408750231333', '1263510387176128513', 'STK-20200522-000002', 10, NULL, NULL, '', '4028818370f308e90170f367e435000c', '40288101710a4c6201710a6618cc0003', -1.120000, 1.000000, 1, 'STK-20200522-000002-10', '40288183712beaa901712c1935d10006', NULL, NULL, -1.120000, NULL, 1.00, NULL, 0.00, 0.000000, 0.00, 0.00, 0.000000, 0.00, '', '', '', NULL);

-- ----------------------------
-- Table structure for sys_announcement
-- ----------------------------
DROP TABLE IF EXISTS `sys_announcement`;
CREATE TABLE `sys_announcement`  (
  `id` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `titile` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '标题',
  `msg_content` text CHARACTER SET utf8 COLLATE utf8_general_ci NULL COMMENT '内容',
  `start_time` datetime(0) NULL DEFAULT NULL COMMENT '开始时间',
  `end_time` datetime(0) NULL DEFAULT NULL COMMENT '结束时间',
  `sender` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '发布人',
  `priority` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '优先级（L低，M中，H高）',
  `msg_category` varchar(10) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '2' COMMENT '消息类型1:通知公告2:系统消息',
  `msg_type` varchar(10) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '通告对象类型（USER:指定用户，ALL:全体用户）',
  `send_status` varchar(10) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '发布状态（0未发布，1已发布，2已撤销）',
  `send_time` datetime(0) NULL DEFAULT NULL COMMENT '发布时间',
  `cancel_time` datetime(0) NULL DEFAULT NULL COMMENT '撤销时间',
  `del_flag` varchar(1) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '删除状态（0，正常，1已删除）',
  `bus_type` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '业务类型(email:邮件 bpm:流程)',
  `bus_id` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '业务id',
  `open_type` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '打开方式(组件：component 路由：url)',
  `open_page` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '组件/路由 地址',
  `create_by` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '创建人',
  `create_time` datetime(0) NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '更新人',
  `update_time` datetime(0) NULL DEFAULT NULL COMMENT '更新时间',
  `user_ids` text CHARACTER SET utf8 COLLATE utf8_general_ci NULL COMMENT '指定用户',
  `msg_abstract` text CHARACTER SET utf8 COLLATE utf8_general_ci NULL COMMENT '摘要',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '系统通告表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_announcement
-- ----------------------------
INSERT INTO `sys_announcement` VALUES ('1b714f8ebc3cc33f8b4f906103b6a18d', '5467567', NULL, NULL, NULL, 'admin', NULL, '2', NULL, '1', '2019-03-30 12:40:38', NULL, '0', NULL, NULL, NULL, NULL, 'admin', '2019-02-26 17:23:26', 'admin', '2019-02-26 17:35:10', NULL, NULL);
INSERT INTO `sys_announcement` VALUES ('3d11237ccdf62450d20bb8abdb331178', '111222', NULL, NULL, NULL, NULL, NULL, '2', NULL, '0', NULL, NULL, '1', NULL, NULL, NULL, NULL, 'admin', '2019-03-29 17:19:47', 'admin', '2019-03-29 17:19:50', NULL, NULL);
INSERT INTO `sys_announcement` VALUES ('7ef04e95f8de030b1d5f7a9144090dc6', '111', NULL, '2019-02-06 17:28:10', '2019-03-08 17:28:11', NULL, NULL, '2', NULL, '0', NULL, NULL, '1', NULL, NULL, NULL, NULL, 'admin', '2019-02-26 17:28:17', 'admin', '2019-03-26 19:59:49', NULL, NULL);
INSERT INTO `sys_announcement` VALUES ('93a9060a1c20e4bf98b3f768a02c2ff9', '111', '111', '2019-02-06 17:20:17', '2019-02-21 17:20:20', 'admin', 'M', '2', 'ALL', '1', '2019-02-26 17:24:29', NULL, '0', NULL, NULL, NULL, NULL, 'admin', '2019-02-26 17:16:26', 'admin', '2019-02-26 17:19:35', NULL, NULL);
INSERT INTO `sys_announcement` VALUES ('de1dc57f31037079e1e55c8347fe6ef7', '222', '2222', '2019-02-06 17:28:26', '2019-02-23 17:28:28', 'admin', 'M', '2', 'ALL', '1', '2019-03-29 17:19:56', NULL, '1', NULL, NULL, NULL, NULL, 'admin', '2019-02-26 17:28:36', 'admin', '2019-02-26 17:28:40', NULL, NULL);
INSERT INTO `sys_announcement` VALUES ('e52f3eb6215f139cb2224c52517af3bd', '334', '334', NULL, NULL, NULL, NULL, '2', NULL, '0', NULL, NULL, '1', NULL, NULL, NULL, NULL, 'admin', '2019-03-30 12:40:28', 'admin', '2019-03-30 12:40:32', NULL, NULL);

-- ----------------------------
-- Table structure for sys_announcement_send
-- ----------------------------
DROP TABLE IF EXISTS `sys_announcement_send`;
CREATE TABLE `sys_announcement_send`  (
  `id` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `annt_id` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '通告ID',
  `user_id` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '用户id',
  `read_flag` varchar(10) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '阅读状态（0未读，1已读）',
  `read_time` datetime(0) NULL DEFAULT NULL COMMENT '阅读时间',
  `create_by` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '创建人',
  `create_time` datetime(0) NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '更新人',
  `update_time` datetime(0) NULL DEFAULT NULL COMMENT '更新时间'
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '用户通告阅读标记表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_announcement_send
-- ----------------------------
INSERT INTO `sys_announcement_send` VALUES ('646c0c405ec643d4dc4160db2446f8ff', '93a9060a1c20e4bf98b3f768a02c2ff9', 'e9ca23d68d884d4ebb19d07889727dae', '1', '2020-04-07 16:27:42', 'admin', '2019-05-17 11:50:56', 'admin', '2020-04-07 16:27:42');
INSERT INTO `sys_announcement_send` VALUES ('1197434450981543938', '93a9060a1c20e4bf98b3f768a02c2ff9', 'a75d45a015c44384a04449ee80dc3503', '0', NULL, 'jeecg', '2019-11-21 16:39:55', NULL, NULL);

-- ----------------------------
-- Table structure for sys_category
-- ----------------------------
DROP TABLE IF EXISTS `sys_category`;
CREATE TABLE `sys_category`  (
  `id` varchar(36) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `pid` varchar(36) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '父级节点',
  `name` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '类型名称',
  `code` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '类型编码',
  `create_by` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '创建人',
  `create_time` datetime(0) NULL DEFAULT NULL COMMENT '创建日期',
  `update_by` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '更新人',
  `update_time` datetime(0) NULL DEFAULT NULL COMMENT '更新日期',
  `sys_org_code` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '所属部门',
  `has_child` varchar(3) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '是否有子节点',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `index_code`(`code`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_category
-- ----------------------------
INSERT INTO `sys_category` VALUES ('1183693424827564034', '0', '物料树', 'B02', 'admin', '2019-10-14 18:37:59', 'admin', '2019-10-14 18:38:15', 'A01', '1');
INSERT INTO `sys_category` VALUES ('1183693491043041282', '1183693424827564034', '上衣', 'B02A01', 'admin', '2019-10-14 18:38:15', 'admin', '2019-10-14 18:38:43', 'A01', '1');
INSERT INTO `sys_category` VALUES ('1183693534173069314', '1183693424827564034', '裤子', 'B02A02', 'admin', '2019-10-14 18:38:25', NULL, NULL, 'A01', NULL);
INSERT INTO `sys_category` VALUES ('1183693610534567937', '1183693491043041282', '秋衣', 'B02A01A01', 'admin', '2019-10-14 18:38:43', NULL, NULL, 'A01', NULL);
INSERT INTO `sys_category` VALUES ('1183693700254924802', '1183693491043041282', '兵装', 'B02A01A02', 'admin', '2019-10-14 18:39:05', NULL, NULL, 'A01', NULL);
INSERT INTO `sys_category` VALUES ('1183693773974011906', '1183693491043041282', '女装', 'B02A01A03', 'admin', '2019-10-14 18:39:22', NULL, NULL, 'A01', NULL);
INSERT INTO `sys_category` VALUES ('1185039122143719425', '0', '电脑产品', 'A01', 'admin', '2019-10-18 11:45:18', 'admin', '2019-10-18 11:45:31', 'A01', '1');
INSERT INTO `sys_category` VALUES ('1185039176799694850', '1185039122143719425', 'thinkpad', 'A01A01', 'admin', '2019-10-18 11:45:31', NULL, NULL, 'A01', NULL);
INSERT INTO `sys_category` VALUES ('1185039255115739138', '1185039122143719425', 'mackbook', 'A01A02', 'admin', '2019-10-18 11:45:50', NULL, NULL, 'A01', NULL);
INSERT INTO `sys_category` VALUES ('1185039299051073537', '1185039122143719425', '华为电脑', 'A01A03', 'admin', '2019-10-18 11:46:01', NULL, NULL, 'A01', NULL);
INSERT INTO `sys_category` VALUES ('1230769196661510146', '0', '省', NULL, 'admin', '2020-02-21 16:20:16', 'admin', '2020-02-21 16:20:31', 'A01A03', '1');
INSERT INTO `sys_category` VALUES ('1230769253267836929', '1230769196661510146', '安徽省', NULL, 'admin', '2020-02-21 16:20:31', 'admin', '2020-02-21 16:20:53', 'A01A03', '1');
INSERT INTO `sys_category` VALUES ('1230769290609725441', '1230769196661510146', '山东省', NULL, 'admin', '2020-02-21 16:20:40', 'admin', '2020-02-21 16:21:23', 'A01A03', '1');
INSERT INTO `sys_category` VALUES ('1230769347157331969', '1230769253267836929', '合肥市', NULL, 'admin', '2020-02-21 16:20:53', 'admin', '2020-02-21 16:21:08', 'A01A03', '1');
INSERT INTO `sys_category` VALUES ('1230769407907631106', '1230769347157331969', '包河区', NULL, 'admin', '2020-02-21 16:21:08', NULL, NULL, 'A01A03', NULL);
INSERT INTO `sys_category` VALUES ('1230769470889299970', '1230769290609725441', '济南市', NULL, 'admin', '2020-02-21 16:21:23', 'admin', '2020-02-21 16:21:41', 'A01A03', '1');
INSERT INTO `sys_category` VALUES ('1230769547519234050', '1230769470889299970', 'A区', NULL, 'admin', '2020-02-21 16:21:41', NULL, NULL, 'A01A03', NULL);
INSERT INTO `sys_category` VALUES ('1230769620021972993', '1230769470889299970', 'B区', NULL, 'admin', '2020-02-21 16:21:58', NULL, NULL, 'A01A03', NULL);
INSERT INTO `sys_category` VALUES ('1230769769930592257', '1230769253267836929', '淮南市', NULL, 'admin', '2020-02-21 16:22:34', 'admin', '2020-02-21 16:22:54', 'A01A03', '1');
INSERT INTO `sys_category` VALUES ('1230769855347593217', '1230769769930592257', 'C区', NULL, 'admin', '2020-02-21 16:22:54', NULL, NULL, 'A01A03', NULL);
INSERT INTO `sys_category` VALUES ('22a50b413c5e1ef661fb8aea9469cf52', 'e9ded10fd33e5753face506f4f1564b5', 'MacBook', 'B01-2-1', 'admin', '2019-06-10 15:43:13', NULL, NULL, 'A01', NULL);
INSERT INTO `sys_category` VALUES ('5c8f68845e57f68ab93a2c8d82d26ae1', '0', '笔记本', 'B01', 'admin', '2019-06-10 15:34:11', 'admin', '2019-06-10 15:34:24', 'A01', '1');
INSERT INTO `sys_category` VALUES ('937fd2e9aa13b8bab1da1ca36d3fd344', 'e9ded10fd33e5753face506f4f1564b5', '台式机', 'B02-2-2', 'admin', '2019-06-10 15:43:32', 'admin', '2019-08-21 12:01:59', 'A01', NULL);
INSERT INTO `sys_category` VALUES ('e9ded10fd33e5753face506f4f1564b5', '5c8f68845e57f68ab93a2c8d82d26ae1', '苹果电脑', 'B01-2', 'admin', '2019-06-10 15:41:14', 'admin', '2019-06-10 15:43:13', 'A01', '1');
INSERT INTO `sys_category` VALUES ('f39a06bf9f390ba4a53d11bc4e0018d7', '5c8f68845e57f68ab93a2c8d82d26ae1', '华为', 'B01-1', 'admin', '2019-06-10 15:34:24', 'admin', '2019-08-21 12:01:56', 'A01', NULL);

-- ----------------------------
-- Table structure for sys_check_rule
-- ----------------------------
DROP TABLE IF EXISTS `sys_check_rule`;
CREATE TABLE `sys_check_rule`  (
  `id` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '主键id',
  `rule_name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '规则名称',
  `rule_code` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '规则Code',
  `rule_json` varchar(1024) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '规则JSON',
  `rule_description` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '规则描述',
  `update_by` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '更新人',
  `update_time` datetime(0) NULL DEFAULT NULL COMMENT '更新时间',
  `create_by` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '创建人',
  `create_time` datetime(0) NULL DEFAULT NULL COMMENT '创建时间',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `uni_sys_check_rule_code`(`rule_code`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_check_rule
-- ----------------------------
INSERT INTO `sys_check_rule` VALUES ('1224980593992388610', '通用编码规则', 'common', '[{\"digits\":\"1\",\"pattern\":\"^[a-z|A-Z]$\",\"message\":\"第一位只能是字母\"},{\"digits\":\"*\",\"pattern\":\"^[0-9|a-z|A-Z|_]{0,}$\",\"message\":\"只能填写数字、大小写字母、下划线\"},{\"digits\":\"*\",\"pattern\":\"^.{3,}$\",\"message\":\"最少输入3位数\"},{\"digits\":\"*\",\"pattern\":\"^.{3,12}$\",\"message\":\"最多输入12位数\"}]', '规则：1、首位只能是字母；2、只能填写数字、大小写字母、下划线；3、最少3位数，最多12位数。', 'admin', '2020-02-07 11:25:48', 'admin', '2020-02-05 16:58:27');
INSERT INTO `sys_check_rule` VALUES ('1225001845524004866', '负责的功能测试', 'test', '[{\"digits\":\"*\",\"pattern\":\"^.{3,12}$\",\"message\":\"只能输入3-12位字符\"},{\"digits\":\"3\",\"pattern\":\"^\\\\d{3}$\",\"message\":\"前3位必须是数字\"},{\"digits\":\"*\",\"pattern\":\"^[^pP]*$\",\"message\":\"不能输入P\"},{\"digits\":\"4\",\"pattern\":\"^@{4}$\",\"message\":\"第4-7位必须都为 @\"},{\"digits\":\"2\",\"pattern\":\"^#=$\",\"message\":\"第8-9位必须是 #=\"},{\"digits\":\"1\",\"pattern\":\"^O$\",\"message\":\"第10位必须为大写的O\"},{\"digits\":\"*\",\"pattern\":\"^.*。$\",\"message\":\"必须以。结尾\"}]', '包含长度校验、特殊字符校验等', 'admin', '2020-02-07 11:57:31', 'admin', '2020-02-05 18:22:54');

-- ----------------------------
-- Table structure for sys_data_log
-- ----------------------------
DROP TABLE IF EXISTS `sys_data_log`;
CREATE TABLE `sys_data_log`  (
  `id` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT 'id',
  `create_by` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '创建人登录名称',
  `create_time` datetime(0) NULL DEFAULT NULL COMMENT '创建日期',
  `update_by` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '更新人登录名称',
  `update_time` datetime(0) NULL DEFAULT NULL COMMENT '更新日期',
  `data_table` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '表名',
  `data_id` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '数据ID',
  `data_content` text CHARACTER SET utf8 COLLATE utf8_general_ci NULL COMMENT '数据内容',
  `data_version` int(11) NULL DEFAULT NULL COMMENT '版本号',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `sindex`(`data_table`, `data_id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_data_log
-- ----------------------------
INSERT INTO `sys_data_log` VALUES ('402880f05ab0d198015ab12274bf0006', 'admin', '2017-03-09 11:35:09', NULL, NULL, 'jeecg_demo', '4028ef81550c1a7901550c1cd6e70001', '{\"mobilePhone\":\"\",\"officePhone\":\"\",\"email\":\"\",\"createDate\":\"Jun 23, 2016 12:00:00 PM\",\"sex\":\"1\",\"depId\":\"402880e447e99cf10147e9a03b320003\",\"userName\":\"9001\",\"status\":\"1\",\"content\":\"111\",\"id\":\"4028ef81550c1a7901550c1cd6e70001\"}', 3);
INSERT INTO `sys_data_log` VALUES ('402880f05ab6d12b015ab700bead0009', 'admin', '2017-03-10 14:56:03', NULL, NULL, 'jeecg_demo', '402880f05ab6d12b015ab700be8d0008', '{\"mobilePhone\":\"\",\"officePhone\":\"\",\"email\":\"\",\"createDate\":\"Mar 10, 2017 2:56:03 PM\",\"sex\":\"0\",\"depId\":\"402880e447e99cf10147e9a03b320003\",\"userName\":\"111\",\"status\":\"0\",\"id\":\"402880f05ab6d12b015ab700be8d0008\"}', 1);
INSERT INTO `sys_data_log` VALUES ('402880f05ab6d12b015ab705a23f000d', 'admin', '2017-03-10 15:01:24', NULL, NULL, 'jeecg_demo', '402880f05ab6d12b015ab705a233000c', '{\"mobilePhone\":\"\",\"officePhone\":\"11\",\"email\":\"\",\"createDate\":\"Mar 10, 2017 3:01:24 PM\",\"sex\":\"0\",\"depId\":\"402880e447e99cf10147e9a03b320003\",\"userName\":\"11\",\"status\":\"0\",\"id\":\"402880f05ab6d12b015ab705a233000c\"}', 1);
INSERT INTO `sys_data_log` VALUES ('402880f05ab6d12b015ab712a6420013', 'admin', '2017-03-10 15:15:37', NULL, NULL, 'jeecg_demo', '402880f05ab6d12b015ab712a6360012', '{\"mobilePhone\":\"\",\"officePhone\":\"\",\"email\":\"\",\"createDate\":\"Mar 10, 2017 3:15:37 PM\",\"sex\":\"0\",\"depId\":\"402880e447e99cf10147e9a03b320003\",\"userName\":\"小王\",\"status\":\"0\",\"id\":\"402880f05ab6d12b015ab712a6360012\"}', 1);
INSERT INTO `sys_data_log` VALUES ('402880f05ab6d12b015ab712d0510015', 'admin', '2017-03-10 15:15:47', NULL, NULL, 'jeecg_demo', '402880f05ab6d12b015ab712a6360012', '{\"mobilePhone\":\"18611788525\",\"officePhone\":\"\",\"email\":\"\",\"createDate\":\"Mar 10, 2017 3:15:37 AM\",\"sex\":\"0\",\"depId\":\"402880e447e99cf10147e9a03b320003\",\"userName\":\"小王\",\"status\":\"0\",\"id\":\"402880f05ab6d12b015ab712a6360012\"}', 2);
INSERT INTO `sys_data_log` VALUES ('402880f05ab6d12b015ab71308240018', 'admin', '2017-03-10 15:16:02', NULL, NULL, 'jeecg_demo', '8a8ab0b246dc81120146dc81860f016f', '{\"mobilePhone\":\"13111111111\",\"officePhone\":\"66666666\",\"email\":\"demo@jeecg.com\",\"age\":12,\"salary\":10.00,\"birthday\":\"Feb 14, 2014 12:00:00 AM\",\"sex\":\"1\",\"depId\":\"402880e447e99cf10147e9a03b320003\",\"userName\":\"小明\",\"status\":\"\",\"content\":\"\",\"id\":\"8a8ab0b246dc81120146dc81860f016f\"}', 1);
INSERT INTO `sys_data_log` VALUES ('402880f05ab6d12b015ab72806c3001b', 'admin', '2017-03-10 15:38:58', NULL, NULL, 'jeecg_demo', '8a8ab0b246dc81120146dc81860f016f', '{\"mobilePhone\":\"18611788888\",\"officePhone\":\"66666666\",\"email\":\"demo@jeecg.com\",\"age\":12,\"salary\":10.00,\"birthday\":\"Feb 14, 2014 12:00:00 AM\",\"sex\":\"1\",\"depId\":\"402880e447e99cf10147e9a03b320003\",\"userName\":\"小明\",\"status\":\"\",\"content\":\"\",\"id\":\"8a8ab0b246dc81120146dc81860f016f\"}', 2);
INSERT INTO `sys_data_log` VALUES ('4028ef815318148a0153181567690001', 'admin', '2016-02-25 18:59:29', NULL, NULL, 'jeecg_demo', '4028ef815318148a0153181566270000', '{\"mobilePhone\":\"13423423423\",\"officePhone\":\"1\",\"email\":\"\",\"age\":1,\"salary\":1,\"birthday\":\"Feb 25, 2016 12:00:00 AM\",\"createDate\":\"Feb 25, 2016 6:59:24 PM\",\"depId\":\"402880e447e9a9570147e9b6a3be0005\",\"userName\":\"1\",\"status\":\"0\",\"id\":\"4028ef815318148a0153181566270000\"}', 1);
INSERT INTO `sys_data_log` VALUES ('4028ef815318148a01531815ec5c0003', 'admin', '2016-02-25 19:00:03', NULL, NULL, 'jeecg_demo', '4028ef815318148a0153181566270000', '{\"mobilePhone\":\"13426498659\",\"officePhone\":\"1\",\"email\":\"\",\"age\":1,\"salary\":1.00,\"birthday\":\"Feb 25, 2016 12:00:00 AM\",\"createDate\":\"Feb 25, 2016 6:59:24 AM\",\"depId\":\"402880e447e9a9570147e9b6a3be0005\",\"userName\":\"1\",\"status\":\"0\",\"id\":\"4028ef815318148a0153181566270000\"}', 2);
INSERT INTO `sys_data_log` VALUES ('4028ef8153c028db0153c0502e6b0003', 'admin', '2016-03-29 10:59:53', NULL, NULL, 'jeecg_demo', '4028ef8153c028db0153c0502d420002', '{\"mobilePhone\":\"18455477548\",\"officePhone\":\"123\",\"email\":\"\",\"createDate\":\"Mar 29, 2016 10:59:53 AM\",\"depId\":\"402880e447e99cf10147e9a03b320003\",\"userName\":\"123\",\"status\":\"0\",\"id\":\"4028ef8153c028db0153c0502d420002\"}', 1);
INSERT INTO `sys_data_log` VALUES ('4028ef8153c028db0153c0509aa40006', 'admin', '2016-03-29 11:00:21', NULL, NULL, 'jeecg_demo', '4028ef8153c028db0153c0509a3e0005', '{\"mobilePhone\":\"13565486458\",\"officePhone\":\"\",\"email\":\"\",\"createDate\":\"Mar 29, 2016 11:00:21 AM\",\"depId\":\"402880e447e99cf10147e9a03b320003\",\"userName\":\"22\",\"status\":\"0\",\"id\":\"4028ef8153c028db0153c0509a3e0005\"}', 1);
INSERT INTO `sys_data_log` VALUES ('4028ef8153c028db0153c051c4a70008', 'admin', '2016-03-29 11:01:37', NULL, NULL, 'jeecg_demo', '4028ef8153c028db0153c0509a3e0005', '{\"mobilePhone\":\"13565486458\",\"officePhone\":\"\",\"email\":\"\",\"createDate\":\"Mar 29, 2016 11:00:21 AM\",\"depId\":\"402880e447e99cf10147e9a03b320003\",\"userName\":\"22\",\"status\":\"0\",\"id\":\"4028ef8153c028db0153c0509a3e0005\"}', 2);
INSERT INTO `sys_data_log` VALUES ('4028ef8153c028db0153c051d4b5000a', 'admin', '2016-03-29 11:01:41', NULL, NULL, 'jeecg_demo', '4028ef8153c028db0153c0502d420002', '{\"mobilePhone\":\"13565486458\",\"officePhone\":\"123\",\"email\":\"\",\"createDate\":\"Mar 29, 2016 10:59:53 AM\",\"depId\":\"402880e447e99cf10147e9a03b320003\",\"userName\":\"123\",\"status\":\"0\",\"id\":\"4028ef8153c028db0153c0502d420002\"}', 2);
INSERT INTO `sys_data_log` VALUES ('4028ef8153c028db0153c07033d8000d', 'admin', '2016-03-29 11:34:52', NULL, NULL, 'jeecg_demo', '4028ef8153c028db0153c0502d420002', '{\"mobilePhone\":\"13565486458\",\"officePhone\":\"123\",\"email\":\"\",\"age\":23,\"createDate\":\"Mar 29, 2016 10:59:53 AM\",\"depId\":\"402880e447e99cf10147e9a03b320003\",\"userName\":\"123\",\"status\":\"0\",\"id\":\"4028ef8153c028db0153c0502d420002\"}', 3);
INSERT INTO `sys_data_log` VALUES ('4028ef8153c028db0153c070492e000f', 'admin', '2016-03-29 11:34:57', NULL, NULL, 'jeecg_demo', '4028ef8153c028db0153c0509a3e0005', '{\"mobilePhone\":\"13565486458\",\"officePhone\":\"\",\"email\":\"\",\"age\":22,\"createDate\":\"Mar 29, 2016 11:00:21 AM\",\"depId\":\"402880e447e99cf10147e9a03b320003\",\"userName\":\"22\",\"status\":\"0\",\"id\":\"4028ef8153c028db0153c0509a3e0005\"}', 3);
INSERT INTO `sys_data_log` VALUES ('4028ef81550c1a7901550c1cd7850002', 'admin', '2016-06-01 21:17:44', NULL, NULL, 'jeecg_demo', '4028ef81550c1a7901550c1cd6e70001', '{\"mobilePhone\":\"\",\"officePhone\":\"\",\"email\":\"\",\"createDate\":\"Jun 1, 2016 9:17:44 PM\",\"sex\":\"1\",\"depId\":\"402880e447e99cf10147e9a03b320003\",\"userName\":\"121221\",\"status\":\"0\",\"id\":\"4028ef81550c1a7901550c1cd6e70001\"}', 1);
INSERT INTO `sys_data_log` VALUES ('4028ef81568c31ec01568c3307080004', 'admin', '2016-08-15 11:16:09', NULL, NULL, 'jeecg_demo', '4028ef81550c1a7901550c1cd6e70001', '{\"mobilePhone\":\"\",\"officePhone\":\"\",\"email\":\"\",\"createDate\":\"Jun 23, 2016 12:00:00 PM\",\"sex\":\"1\",\"depId\":\"402880e447e99cf10147e9a03b320003\",\"userName\":\"9001\",\"status\":\"1\",\"content\":\"111\",\"id\":\"4028ef81550c1a7901550c1cd6e70001\"}', 2);

-- ----------------------------
-- Table structure for sys_data_source
-- ----------------------------
DROP TABLE IF EXISTS `sys_data_source`;
CREATE TABLE `sys_data_source`  (
  `id` varchar(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `code` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '数据源编码',
  `name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '数据源名称',
  `remark` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '备注',
  `db_type` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '数据库类型',
  `db_driver` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '驱动类',
  `db_url` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '数据源地址',
  `db_name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '数据库名称',
  `db_username` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '用户名',
  `db_password` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '密码',
  `create_by` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '创建人',
  `create_time` datetime(0) NULL DEFAULT NULL COMMENT '创建日期',
  `update_by` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '更新人',
  `update_time` datetime(0) NULL DEFAULT NULL COMMENT '更新日期',
  `sys_org_code` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '所属部门',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `sys_data_source_code_uni`(`code`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_data_source
-- ----------------------------
INSERT INTO `sys_data_source` VALUES ('1209779538310004737', NULL, 'MySQL5.7', '本地数据库MySQL5.7', '1', 'com.mysql.jdbc.Driver', 'jdbc:mysql://127.0.0.1:3306/jeecg-boot?characterEncoding=UTF-8&useUnicode=true&useSSL=false', 'jeecg-boot', 'root', 'root', 'admin', '2019-12-25 18:14:53', NULL, NULL, 'A01');

-- ----------------------------
-- Table structure for sys_depart
-- ----------------------------
DROP TABLE IF EXISTS `sys_depart`;
CREATE TABLE `sys_depart`  (
  `id` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT 'ID',
  `parent_id` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '父机构ID',
  `depart_name` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '机构/部门名称',
  `depart_name_en` varchar(500) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '英文名',
  `depart_name_abbr` varchar(500) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '缩写',
  `depart_order` int(11) NULL DEFAULT 0 COMMENT '排序',
  `description` varchar(500) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '描述',
  `org_category` varchar(10) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '1' COMMENT '机构类别 1组织机构，2岗位',
  `org_type` varchar(10) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '机构类型 1一级部门 2子部门',
  `org_code` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '机构编码',
  `mobile` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '手机号',
  `fax` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '传真',
  `address` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '地址',
  `memo` varchar(500) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '备注',
  `status` varchar(1) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '状态（1启用，0不启用）',
  `del_flag` varchar(1) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '删除状态（0，正常，1已删除）',
  `create_by` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '创建人',
  `create_time` datetime(0) NULL DEFAULT NULL COMMENT '创建日期',
  `update_by` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '更新人',
  `update_time` datetime(0) NULL DEFAULT NULL COMMENT '更新日期',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `uniq_depart_org_code`(`org_code`) USING BTREE,
  INDEX `index_depart_parent_id`(`parent_id`) USING BTREE,
  INDEX `index_depart_depart_order`(`depart_order`) USING BTREE,
  INDEX `index_depart_org_code`(`org_code`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '组织机构表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_depart
-- ----------------------------
INSERT INTO `sys_depart` VALUES ('4f1765520d6346f9bd9c79e2479e5b12', 'c6d7cb4deeac411cb3384b1b31278596', '市场部', NULL, NULL, 0, NULL, '1', '2', 'A01A03', NULL, NULL, NULL, NULL, NULL, '0', 'admin', '2019-02-20 17:15:34', 'admin', '2019-02-26 16:36:18');
INSERT INTO `sys_depart` VALUES ('5159cde220114246b045e574adceafe9', '6d35e179cd814e3299bd588ea7daed3f', '研发部', NULL, NULL, 0, NULL, '1', '2', 'A02A02', NULL, NULL, NULL, NULL, NULL, '0', 'admin', '2019-02-26 16:44:38', 'admin', '2019-03-07 09:36:53');
INSERT INTO `sys_depart` VALUES ('57197590443c44f083d42ae24ef26a2c', 'c6d7cb4deeac411cb3384b1b31278596', '研发部', NULL, NULL, 0, NULL, '1', '2', 'A01A05', NULL, NULL, NULL, NULL, NULL, '0', 'admin', '2019-02-21 16:14:41', 'admin', '2019-03-27 19:05:49');
INSERT INTO `sys_depart` VALUES ('67fc001af12a4f9b8458005d3f19934a', 'c6d7cb4deeac411cb3384b1b31278596', '财务部', NULL, NULL, 0, NULL, '1', '2', 'A01A04', NULL, NULL, NULL, NULL, NULL, '0', 'admin', '2019-02-21 16:14:35', 'admin', '2019-02-25 12:49:41');
INSERT INTO `sys_depart` VALUES ('6d35e179cd814e3299bd588ea7daed3f', '', '卓尔互动公司', NULL, NULL, 0, NULL, '1', '1', 'A02', NULL, NULL, NULL, NULL, NULL, '0', 'admin', '2019-02-26 16:36:39', 'admin', '2019-03-22 16:47:25');
INSERT INTO `sys_depart` VALUES ('743ba9dbdc114af8953a11022ef3096a', 'f28c6f53abd841ac87ead43afc483433', '财务部', NULL, NULL, 0, NULL, '1', '2', 'A03A01', NULL, NULL, NULL, NULL, NULL, '0', 'admin', '2019-03-22 16:45:43', NULL, NULL);
INSERT INTO `sys_depart` VALUES ('a7d7e77e06c84325a40932163adcdaa6', '6d35e179cd814e3299bd588ea7daed3f', '财务部', NULL, NULL, 0, NULL, '1', '2', 'A02A01', NULL, NULL, NULL, NULL, NULL, '0', 'admin', '2019-02-26 16:36:47', 'admin', '2019-02-26 16:37:25');
INSERT INTO `sys_depart` VALUES ('c6d7cb4deeac411cb3384b1b31278596', '', '北京国炬公司', NULL, NULL, 0, NULL, '1', '1', 'A01', NULL, NULL, NULL, NULL, NULL, '0', 'admin', '2019-02-11 14:21:51', 'admin', '2019-03-22 16:47:19');

-- ----------------------------
-- Table structure for sys_depart_permission
-- ----------------------------
DROP TABLE IF EXISTS `sys_depart_permission`;
CREATE TABLE `sys_depart_permission`  (
  `id` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `depart_id` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '部门id',
  `permission_id` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '权限id',
  `data_rule_ids` varchar(1000) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '数据规则id',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '部门权限表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for sys_depart_role
-- ----------------------------
DROP TABLE IF EXISTS `sys_depart_role`;
CREATE TABLE `sys_depart_role`  (
  `id` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `depart_id` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '部门id',
  `role_name` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '部门角色名称',
  `role_code` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '部门角色编码',
  `description` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '描述',
  `create_by` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '创建人',
  `create_time` datetime(0) NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '更新人',
  `update_time` datetime(0) NULL DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '部门角色表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for sys_depart_role_permission
-- ----------------------------
DROP TABLE IF EXISTS `sys_depart_role_permission`;
CREATE TABLE `sys_depart_role_permission`  (
  `id` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `depart_id` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '部门id',
  `role_id` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '角色id',
  `permission_id` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '权限id',
  `data_rule_ids` varchar(1000) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `index_group_role_per_id`(`role_id`, `permission_id`) USING BTREE,
  INDEX `index_group_role_id`(`role_id`) USING BTREE,
  INDEX `index_group_per_id`(`permission_id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '部门角色权限表' ROW_FORMAT = Compact;

-- ----------------------------
-- Table structure for sys_depart_role_user
-- ----------------------------
DROP TABLE IF EXISTS `sys_depart_role_user`;
CREATE TABLE `sys_depart_role_user`  (
  `id` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '主键id',
  `user_id` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '用户id',
  `drole_id` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '角色id',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '部门角色用户表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for sys_dict
-- ----------------------------
DROP TABLE IF EXISTS `sys_dict`;
CREATE TABLE `sys_dict`  (
  `id` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `dict_name` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '字典名称',
  `dict_code` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '字典编码',
  `description` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '描述',
  `del_flag` int(1) NULL DEFAULT NULL COMMENT '删除状态',
  `create_by` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '创建人',
  `create_time` datetime(0) NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '更新人',
  `update_time` datetime(0) NULL DEFAULT NULL COMMENT '更新时间',
  `type` int(1) UNSIGNED ZEROFILL NULL DEFAULT 0 COMMENT '字典类型0为string,1为number',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `indextable_dict_code`(`dict_code`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_dict
-- ----------------------------
INSERT INTO `sys_dict` VALUES ('0b5d19e1fce4b2e6647e6b4a17760c14', '通告类型', 'msg_category', '消息类型1:通知公告2:系统消息', 0, 'admin', '2019-04-22 18:01:35', NULL, NULL, 0);
INSERT INTO `sys_dict` VALUES ('1174509082208395266', '职务职级', 'position_rank', '职务表职级字典', 0, 'admin', '2019-09-19 10:22:41', NULL, NULL, 0);
INSERT INTO `sys_dict` VALUES ('1174511106530525185', '机构类型', 'org_category', '机构类型 1公司，2部门 3岗位', 0, 'admin', '2019-09-19 10:30:43', NULL, NULL, 0);
INSERT INTO `sys_dict` VALUES ('1178295274528845826', '表单权限策略', 'form_perms_type', '', 0, 'admin', '2019-09-29 21:07:39', 'admin', '2019-09-29 21:08:26', NULL);
INSERT INTO `sys_dict` VALUES ('1199517671259906049', '紧急程度', 'urgent_level', '日程计划紧急程度', 0, 'admin', '2019-11-27 10:37:53', NULL, NULL, 0);
INSERT INTO `sys_dict` VALUES ('1199518099888414722', '日程计划类型', 'eoa_plan_type', '', 0, 'admin', '2019-11-27 10:39:36', NULL, NULL, 0);
INSERT INTO `sys_dict` VALUES ('1199520177767587841', '分类栏目类型', 'eoa_cms_menu_type', '', 0, 'admin', '2019-11-27 10:47:51', 'admin', '2019-11-27 10:49:35', 0);
INSERT INTO `sys_dict` VALUES ('1199525215290306561', '日程计划状态', 'eoa_plan_status', '', 0, 'admin', '2019-11-27 11:07:52', 'admin', '2019-11-27 11:10:11', 0);
INSERT INTO `sys_dict` VALUES ('1209733563293962241', '数据库类型', 'database_type', '', 0, 'admin', '2019-12-25 15:12:12', NULL, NULL, 0);
INSERT INTO `sys_dict` VALUES ('1232913193820581889', 'Online表单业务分类', 'ol_form_biz_type', '', 0, 'admin', '2020-02-27 14:19:46', 'admin', '2020-02-27 14:20:23', 0);
INSERT INTO `sys_dict` VALUES ('1240560989760811010', '单据处理状态', 'x_bill_proc_status', '', 0, 'admin', '2020-03-19 16:49:23', NULL, NULL, 0);
INSERT INTO `sys_dict` VALUES ('1240561198460989442', '出入库类型', 'x_stock_io_type', '', 0, 'admin', '2020-03-19 16:50:13', 'admin', '2020-03-31 09:16:05', 0);
INSERT INTO `sys_dict` VALUES ('1240562521008926722', '收款类型', 'x_receipt_type', '', 0, 'admin', '2020-03-19 16:55:28', 'admin', '2020-03-19 17:08:55', 0);
INSERT INTO `sys_dict` VALUES ('1240562625690365954', '收款结算方式', 'x_receipt_settle_method', '', 1, 'admin', '2020-03-19 16:55:53', 'admin', '2020-03-19 17:10:46', 0);
INSERT INTO `sys_dict` VALUES ('1240562777272512514', '往来核销类型', 'x_rp_check_type', '', 0, 'admin', '2020-03-19 16:56:29', NULL, NULL, 0);
INSERT INTO `sys_dict` VALUES ('1240563037726208001', '单据类型', 'x_bill_type', '', 0, 'admin', '2020-03-19 16:57:31', NULL, NULL, 0);
INSERT INTO `sys_dict` VALUES ('1240566173593399297', '付款类型', 'x_payment_type', '', 0, 'admin', '2020-03-19 17:09:59', NULL, NULL, 0);
INSERT INTO `sys_dict` VALUES ('1240566504419127298', '结算方式', 'x_settle_method', '', 0, 'admin', '2020-03-19 17:11:18', 'admin', '2020-04-16 11:34:01', 0);
INSERT INTO `sys_dict` VALUES ('1244548537323536386', '客户等级', 'x_customer_level', '', 0, 'admin', '2020-03-30 16:54:29', NULL, NULL, 0);
INSERT INTO `sys_dict` VALUES ('1244548790885990401', '供应商等级', 'x_supplier_level', '', 0, 'admin', '2020-03-30 16:55:29', NULL, NULL, 0);
INSERT INTO `sys_dict` VALUES ('1244550922871685121', '客户分类', 'customer_category', '', 0, 'admin', '2020-03-30 17:03:57', NULL, NULL, 0);
INSERT INTO `sys_dict` VALUES ('1244551045613797377', '供应商分类', 'supplier_category', '', 0, 'admin', '2020-03-30 17:04:27', NULL, NULL, 0);
INSERT INTO `sys_dict` VALUES ('1244558606777892865', '纳税规模', 'tax_scale', '', 0, 'admin', '2020-03-30 17:34:29', NULL, NULL, 0);
INSERT INTO `sys_dict` VALUES ('1244653717570326530', '纳税规模', 'x_tax_scale', '', 0, 'admin', '2020-03-30 23:52:25', NULL, NULL, 0);
INSERT INTO `sys_dict` VALUES ('1250687930947620866', '定时任务状态', 'quartz_status', '', 0, 'admin', '2020-04-16 15:30:14', '', NULL, NULL);
INSERT INTO `sys_dict` VALUES ('1260097934330490882', '应收类型', 'x_receivable_type', '', 0, 'admin', '2020-05-12 14:42:14', NULL, NULL, 0);
INSERT INTO `sys_dict` VALUES ('1260098880586444801', '应付类型', 'x_payable_type', '', 0, 'admin', '2020-05-12 14:45:59', NULL, NULL, 0);
INSERT INTO `sys_dict` VALUES ('1263374147459272705', '发票类型', 'x_invoice_type', '', 0, 'admin', '2020-05-21 15:40:44', NULL, NULL, 0);
INSERT INTO `sys_dict` VALUES ('1264836316952580097', '往来类型', 'x_rp_type', '', 0, 'admin', '2020-05-25 16:30:52', NULL, NULL, 0);
INSERT INTO `sys_dict` VALUES ('1265837267708600321', '应收核销类型', 'x_receivable_check_type', '', 0, 'admin', '2020-05-28 10:48:17', NULL, NULL, 0);
INSERT INTO `sys_dict` VALUES ('1265837654624755713', '应付核销类型', 'x_payable_check_type', '', 0, 'admin', '2020-05-28 10:49:50', NULL, NULL, 0);
INSERT INTO `sys_dict` VALUES ('236e8a4baff0db8c62c00dd95632834f', '同步工作流引擎', 'activiti_sync', '同步工作流引擎', 0, 'admin', '2019-05-15 15:27:33', NULL, NULL, 0);
INSERT INTO `sys_dict` VALUES ('2e02df51611a4b9632828ab7e5338f00', '权限策略', 'perms_type', '权限策略', 0, 'admin', '2019-04-26 18:26:55', NULL, NULL, 0);
INSERT INTO `sys_dict` VALUES ('2f0320997ade5dd147c90130f7218c3e', '推送类别', 'msg_type', '', 0, 'admin', '2019-03-17 21:21:32', 'admin', '2019-03-26 19:57:45', 0);
INSERT INTO `sys_dict` VALUES ('3486f32803bb953e7155dab3513dc68b', '删除状态', 'del_flag', NULL, 0, 'admin', '2019-01-18 21:46:26', 'admin', '2019-03-30 11:17:11', 0);
INSERT INTO `sys_dict` VALUES ('3d9a351be3436fbefb1307d4cfb49bf2', '性别', 'sex', NULL, 0, NULL, '2019-01-04 14:56:32', 'admin', '2019-03-30 11:28:27', 1);
INSERT INTO `sys_dict` VALUES ('404a04a15f371566c658ee9ef9fc392a', 'cehis2', '22', NULL, 1, 'admin', '2019-01-30 11:17:21', 'admin', '2019-03-30 11:18:12', 0);
INSERT INTO `sys_dict` VALUES ('4274efc2292239b6f000b153f50823ff', '全局权限策略', 'global_perms_type', '全局权限策略', 0, 'admin', '2019-05-10 17:54:05', NULL, NULL, 0);
INSERT INTO `sys_dict` VALUES ('4c03fca6bf1f0299c381213961566349', 'Online图表展示模板', 'online_graph_display_template', 'Online图表展示模板', 0, 'admin', '2019-04-12 17:28:50', NULL, NULL, 0);
INSERT INTO `sys_dict` VALUES ('4c753b5293304e7a445fd2741b46529d', '字典状态', 'dict_item_status', NULL, 0, 'admin', '2020-06-18 23:18:42', 'admin', '2019-03-30 19:33:52', 1);
INSERT INTO `sys_dict` VALUES ('4d7fec1a7799a436d26d02325eff295e', '优先级', 'priority', '优先级', 0, 'admin', '2019-03-16 17:03:34', 'admin', '2019-04-16 17:39:23', 0);
INSERT INTO `sys_dict` VALUES ('4e4602b3e3686f0911384e188dc7efb4', '条件规则', 'rule_conditions', '', 0, 'admin', '2019-04-01 10:15:03', 'admin', '2019-04-01 10:30:47', 0);
INSERT INTO `sys_dict` VALUES ('4f69be5f507accea8d5df5f11346181a', '发送消息类型', 'msgType', NULL, 0, 'admin', '2019-04-11 14:27:09', NULL, NULL, 0);
INSERT INTO `sys_dict` VALUES ('68168534ff5065a152bfab275c2136f8', '有效无效状态', 'valid_status', '有效无效状态', 0, 'admin', '2020-09-26 19:21:14', 'admin', '2019-04-26 19:21:23', 0);
INSERT INTO `sys_dict` VALUES ('6b78e3f59faec1a4750acff08030a79b', '用户类型', 'user_type', NULL, 1, NULL, '2019-01-04 14:59:01', 'admin', '2019-03-18 23:28:18', 0);
INSERT INTO `sys_dict` VALUES ('72cce0989df68887546746d8f09811aa', 'Online表单类型', 'cgform_table_type', '', 0, 'admin', '2019-01-27 10:13:02', 'admin', '2019-03-30 11:37:36', 0);
INSERT INTO `sys_dict` VALUES ('78bda155fe380b1b3f175f1e88c284c6', '流程状态', 'bpm_status', '流程状态', 0, 'admin', '2019-05-09 16:31:52', NULL, NULL, 0);
INSERT INTO `sys_dict` VALUES ('83bfb33147013cc81640d5fd9eda030c', '日志类型', 'log_type', NULL, 0, 'admin', '2019-03-18 23:22:19', NULL, NULL, 1);
INSERT INTO `sys_dict` VALUES ('845da5006c97754728bf48b6a10f79cc', '状态', 'status', NULL, 1, 'admin', '2019-03-18 21:45:25', 'admin', '2019-03-18 21:58:25', 0);
INSERT INTO `sys_dict` VALUES ('880a895c98afeca9d9ac39f29e67c13e', '操作类型', 'operate_type', '操作类型', 0, 'admin', '2019-07-22 10:54:29', NULL, NULL, 0);
INSERT INTO `sys_dict` VALUES ('8dfe32e2d29ea9430a988b3b558bf233', '发布状态', 'send_status', '发布状态', 0, 'admin', '2019-04-16 17:40:42', NULL, NULL, 0);
INSERT INTO `sys_dict` VALUES ('a7adbcd86c37f7dbc9b66945c82ef9e6', '1是0否', 'yn', '', 1, 'admin', '2019-05-22 19:29:29', NULL, NULL, 0);
INSERT INTO `sys_dict` VALUES ('a9d9942bd0eccb6e89de92d130ec4c4a', '消息发送状态', 'msgSendStatus', NULL, 0, 'admin', '2019-04-12 18:18:17', NULL, NULL, 0);
INSERT INTO `sys_dict` VALUES ('ac2f7c0c5c5775fcea7e2387bcb22f01', '菜单类型', 'menu_type', NULL, 0, 'admin', '2020-12-18 23:24:32', 'admin', '2019-04-01 15:27:06', 1);
INSERT INTO `sys_dict` VALUES ('ad7c65ba97c20a6805d5dcdf13cdaf36', 'onlineT类型', 'ceshi_online', NULL, 1, 'admin', '2019-03-22 16:31:49', 'admin', '2019-03-22 16:34:16', 0);
INSERT INTO `sys_dict` VALUES ('bd1b8bc28e65d6feefefb6f3c79f42fd', 'Online图表数据类型', 'online_graph_data_type', 'Online图表数据类型', 0, 'admin', '2019-04-12 17:24:24', 'admin', '2019-04-12 17:24:57', 0);
INSERT INTO `sys_dict` VALUES ('c36169beb12de8a71c8683ee7c28a503', '部门状态', 'depart_status', NULL, 0, 'admin', '2019-03-18 21:59:51', NULL, NULL, 0);
INSERT INTO `sys_dict` VALUES ('c5a14c75172783d72cbee6ee7f5df5d1', 'Online图表类型', 'online_graph_type', 'Online图表类型', 0, 'admin', '2019-04-12 17:04:06', NULL, NULL, 0);
INSERT INTO `sys_dict` VALUES ('d6e1152968b02d69ff358c75b48a6ee1', '流程类型', 'bpm_process_type', NULL, 0, 'admin', '2021-02-22 19:26:54', 'admin', '2019-03-30 18:14:44', 0);
INSERT INTO `sys_dict` VALUES ('fc6cd58fde2e8481db10d3a1e68ce70c', '用户状态', 'user_status', NULL, 0, 'admin', '2019-03-18 21:57:25', 'admin', '2019-03-18 23:11:58', 1);

-- ----------------------------
-- Table structure for sys_dict_item
-- ----------------------------
DROP TABLE IF EXISTS `sys_dict_item`;
CREATE TABLE `sys_dict_item`  (
  `id` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `dict_id` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '字典id',
  `item_text` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '字典项文本',
  `item_value` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '字典项值',
  `description` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '描述',
  `sort_order` int(10) NULL DEFAULT NULL COMMENT '排序',
  `status` int(11) NULL DEFAULT NULL COMMENT '状态（1启用 0不启用）',
  `create_by` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `create_time` datetime(0) NULL DEFAULT NULL,
  `update_by` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `update_time` datetime(0) NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `index_table_dict_id`(`dict_id`) USING BTREE,
  INDEX `index_table_sort_order`(`sort_order`) USING BTREE,
  INDEX `index_table_dict_status`(`status`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_dict_item
-- ----------------------------
INSERT INTO `sys_dict_item` VALUES ('0072d115e07c875d76c9b022e2179128', '4d7fec1a7799a436d26d02325eff295e', '低', 'L', '低', 3, 1, 'admin', '2019-04-16 17:04:59', NULL, NULL);
INSERT INTO `sys_dict_item` VALUES ('05a2e732ce7b00aa52141ecc3e330b4e', '3486f32803bb953e7155dab3513dc68b', '已删除', '1', NULL, NULL, 1, 'admin', '2025-10-18 21:46:56', 'admin', '2019-03-28 22:23:20');
INSERT INTO `sys_dict_item` VALUES ('096c2e758d823def3855f6376bc736fb', 'bd1b8bc28e65d6feefefb6f3c79f42fd', 'SQL', 'sql', NULL, 1, 1, 'admin', '2019-04-12 17:26:26', NULL, NULL);
INSERT INTO `sys_dict_item` VALUES ('0c9532916f5cd722017b46bc4d953e41', '2f0320997ade5dd147c90130f7218c3e', '指定用户', 'USER', NULL, NULL, 1, 'admin', '2019-03-17 21:22:19', 'admin', '2019-03-17 21:22:28');
INSERT INTO `sys_dict_item` VALUES ('0ca4beba9efc4f9dd54af0911a946d5c', '72cce0989df68887546746d8f09811aa', '附表', '3', NULL, 3, 1, 'admin', '2019-03-27 10:13:43', NULL, NULL);
INSERT INTO `sys_dict_item` VALUES ('1030a2652608f5eac3b49d70458b8532', '2e02df51611a4b9632828ab7e5338f00', '禁用', '2', '禁用', 2, 1, 'admin', '2021-03-26 18:27:28', 'admin', '2019-04-26 18:39:11');
INSERT INTO `sys_dict_item` VALUES ('1174509082208395266', '1174511106530525185', '岗位', '3', '岗位', 1, 1, 'admin', '2019-09-19 10:31:16', '', NULL);
INSERT INTO `sys_dict_item` VALUES ('1174509601047994369', '1174509082208395266', '员级', '1', '', 1, 1, 'admin', '2019-09-19 10:24:45', 'admin', '2019-09-23 11:46:39');
INSERT INTO `sys_dict_item` VALUES ('1174509667297026049', '1174509082208395266', '助级', '2', '', 2, 1, 'admin', '2019-09-19 10:25:01', 'admin', '2019-09-23 11:46:47');
INSERT INTO `sys_dict_item` VALUES ('1174509713568587777', '1174509082208395266', '中级', '3', '', 3, 1, 'admin', '2019-09-19 10:25:12', 'admin', '2019-09-23 11:46:56');
INSERT INTO `sys_dict_item` VALUES ('1174509788361416705', '1174509082208395266', '副高级', '4', '', 4, 1, 'admin', '2019-09-19 10:25:30', 'admin', '2019-09-23 11:47:06');
INSERT INTO `sys_dict_item` VALUES ('1174509835803189250', '1174509082208395266', '正高级', '5', '', 5, 1, 'admin', '2019-09-19 10:25:41', 'admin', '2019-09-23 11:47:12');
INSERT INTO `sys_dict_item` VALUES ('1174511197735665665', '1174511106530525185', '公司', '1', '公司', 1, 1, 'admin', '2019-09-19 10:31:05', NULL, NULL);
INSERT INTO `sys_dict_item` VALUES ('1174511244036587521', '1174511106530525185', '部门', '2', '部门', 1, 1, 'admin', '2019-09-19 10:31:16', NULL, NULL);
INSERT INTO `sys_dict_item` VALUES ('1178295553450061826', '1178295274528845826', '可编辑(未授权禁用)', '2', '', 2, 1, 'admin', '2019-09-29 21:08:46', 'admin', '2019-09-29 21:09:18');
INSERT INTO `sys_dict_item` VALUES ('1178295639554928641', '1178295274528845826', '可见(未授权不可见)', '1', '', 1, 1, 'admin', '2019-09-29 21:09:06', 'admin', '2019-09-29 21:09:24');
INSERT INTO `sys_dict_item` VALUES ('1199517884758368257', '1199517671259906049', '一般', '1', '', 1, 1, 'admin', '2019-11-27 10:38:44', NULL, NULL);
INSERT INTO `sys_dict_item` VALUES ('1199517914017832962', '1199517671259906049', '重要', '2', '', 1, 1, 'admin', '2019-11-27 10:38:51', NULL, NULL);
INSERT INTO `sys_dict_item` VALUES ('1199517941339529217', '1199517671259906049', '紧急', '3', '', 1, 1, 'admin', '2019-11-27 10:38:58', NULL, NULL);
INSERT INTO `sys_dict_item` VALUES ('1199518186144276482', '1199518099888414722', '日常记录', '1', '', 1, 1, 'admin', '2019-11-27 10:39:56', NULL, NULL);
INSERT INTO `sys_dict_item` VALUES ('1199518214858481666', '1199518099888414722', '本周工作', '2', '', 1, 1, 'admin', '2019-11-27 10:40:03', NULL, NULL);
INSERT INTO `sys_dict_item` VALUES ('1199518235943247874', '1199518099888414722', '下周计划', '3', '', 1, 1, 'admin', '2019-11-27 10:40:08', NULL, NULL);
INSERT INTO `sys_dict_item` VALUES ('1199520817285701634', '1199520177767587841', '列表', '1', '', 1, 1, 'admin', '2019-11-27 10:50:24', NULL, NULL);
INSERT INTO `sys_dict_item` VALUES ('1199520835035996161', '1199520177767587841', '链接', '2', '', 1, 1, 'admin', '2019-11-27 10:50:28', NULL, NULL);
INSERT INTO `sys_dict_item` VALUES ('1199525468672405505', '1199525215290306561', '未开始', '0', '', 1, 1, 'admin', '2019-11-27 11:08:52', NULL, NULL);
INSERT INTO `sys_dict_item` VALUES ('1199525490575060993', '1199525215290306561', '进行中', '1', '', 1, 1, 'admin', '2019-11-27 11:08:58', NULL, NULL);
INSERT INTO `sys_dict_item` VALUES ('1199525506429530114', '1199525215290306561', '已完成', '2', '', 1, 1, 'admin', '2019-11-27 11:09:02', 'admin', '2019-11-27 11:10:02');
INSERT INTO `sys_dict_item` VALUES ('1199607547704647681', '4f69be5f507accea8d5df5f11346181a', '系统', '4', '', 1, 1, 'admin', '2019-11-27 16:35:02', 'admin', '2019-11-27 19:37:46');
INSERT INTO `sys_dict_item` VALUES ('1209733775114702850', '1209733563293962241', 'MySQL', '1', '', 1, 1, 'admin', '2019-12-25 15:13:02', NULL, NULL);
INSERT INTO `sys_dict_item` VALUES ('1209733839933476865', '1209733563293962241', 'Oracle', '2', '', 1, 1, 'admin', '2019-12-25 15:13:18', NULL, NULL);
INSERT INTO `sys_dict_item` VALUES ('1209733903020003330', '1209733563293962241', 'SQLServer', '3', '', 1, 1, 'admin', '2019-12-25 15:13:33', NULL, NULL);
INSERT INTO `sys_dict_item` VALUES ('1232913424813486081', '1232913193820581889', '官方示例', 'demo', '', 1, 1, 'admin', '2020-02-27 14:20:42', 'admin', '2020-02-27 14:21:37');
INSERT INTO `sys_dict_item` VALUES ('1232913493717512194', '1232913193820581889', '流程表单', 'bpm', '', 2, 1, 'admin', '2020-02-27 14:20:58', 'admin', '2020-02-27 14:22:20');
INSERT INTO `sys_dict_item` VALUES ('1232913605382467585', '1232913193820581889', '测试表单', 'temp', '', 4, 1, 'admin', '2020-02-27 14:21:25', 'admin', '2020-02-27 14:22:16');
INSERT INTO `sys_dict_item` VALUES ('1232914232372195330', '1232913193820581889', '导入表单', 'bdfl_include', '', 5, 1, 'admin', '2020-02-27 14:23:54', NULL, NULL);
INSERT INTO `sys_dict_item` VALUES ('1234371726545010689', '4e4602b3e3686f0911384e188dc7efb4', '左模糊', 'LEFT_LIKE', '左模糊', 7, 1, 'admin', '2020-03-02 14:55:27', NULL, NULL);
INSERT INTO `sys_dict_item` VALUES ('1234371809495760898', '4e4602b3e3686f0911384e188dc7efb4', '右模糊', 'RIGHT_LIKE', '右模糊', 7, 1, 'admin', '2020-03-02 14:55:47', NULL, NULL);
INSERT INTO `sys_dict_item` VALUES ('1240563554644815873', '1240562777272512514', '收款核应收', '101', '', 1, 1, 'admin', '2020-03-19 16:59:35', 'admin', '2020-04-23 11:17:05');
INSERT INTO `sys_dict_item` VALUES ('1240563743870840833', '1240562777272512514', '付款核应付', '201', '', 1, 1, 'admin', '2020-03-19 17:00:20', 'admin', '2020-04-23 11:16:56');
INSERT INTO `sys_dict_item` VALUES ('1240566924545781761', '1240566173593399297', '采购预付款', '201', '', 1, 1, 'admin', '2020-03-19 17:12:58', 'admin', '2020-03-19 17:25:56');
INSERT INTO `sys_dict_item` VALUES ('1240566994196393985', '1240566173593399297', '采购付款', '202', '', 2, 1, 'admin', '2020-03-19 17:13:15', 'admin', '2020-03-19 17:26:19');
INSERT INTO `sys_dict_item` VALUES ('1240567178112430082', '1240566173593399297', '其他付款', '299', '', 99, 1, 'admin', '2020-03-19 17:13:59', 'admin', '2020-03-19 17:28:27');
INSERT INTO `sys_dict_item` VALUES ('1240568331646693378', '1240566504419127298', '现金', '11', '', 11, 1, 'admin', '2020-03-19 17:18:34', 'admin', '2020-05-12 09:39:47');
INSERT INTO `sys_dict_item` VALUES ('1240568832517894146', '1240566504419127298', '银行汇款', '21', '', 21, 1, 'admin', '2020-03-19 17:20:33', 'admin', '2020-05-12 09:13:06');
INSERT INTO `sys_dict_item` VALUES ('1240569696041201665', '1240562625690365954', '现金', '301', '', 1, 1, 'admin', '2020-03-19 17:23:59', NULL, NULL);
INSERT INTO `sys_dict_item` VALUES ('1240569756019748865', '1240562625690365954', '银行汇款', '302', '', 2, 1, 'admin', '2020-03-19 17:24:13', NULL, NULL);
INSERT INTO `sys_dict_item` VALUES ('1240569844771221506', '1240562625690365954', '预收款抵扣', '101', '', 9, 1, 'admin', '2020-03-19 17:24:34', NULL, NULL);
INSERT INTO `sys_dict_item` VALUES ('1240570565226819585', '1240562521008926722', '销售预收款', '101', '', 1, 1, 'admin', '2020-03-19 17:27:26', 'admin', '2020-03-19 17:27:35');
INSERT INTO `sys_dict_item` VALUES ('1240570682893824001', '1240562521008926722', '销售收款', '102', '', 2, 1, 'admin', '2020-03-19 17:27:54', NULL, NULL);
INSERT INTO `sys_dict_item` VALUES ('1240570756713574401', '1240562521008926722', '其他收款', '199', '', 99, 1, 'admin', '2020-03-19 17:28:12', NULL, NULL);
INSERT INTO `sys_dict_item` VALUES ('1240571206351351809', '1240561198460989442', '采购入库', '101', '', 1010, 1, 'admin', '2020-03-19 17:29:59', 'admin', '2020-05-13 14:33:47');
INSERT INTO `sys_dict_item` VALUES ('1240571270721335297', '1240561198460989442', '其他入库', '199', '', 1990, 1, 'admin', '2020-03-19 17:30:14', 'admin', '2020-05-13 14:34:13');
INSERT INTO `sys_dict_item` VALUES ('1240571448685654017', '1240561198460989442', '销售出库', '201', '', 2010, 1, 'admin', '2020-03-19 17:30:57', 'admin', '2020-05-13 14:33:53');
INSERT INTO `sys_dict_item` VALUES ('1240571626708692994', '1240561198460989442', '其他出库', '299', '', 2990, 1, 'admin', '2020-03-19 17:31:39', 'admin', '2020-05-13 14:34:20');
INSERT INTO `sys_dict_item` VALUES ('1240573080844529665', '1240560989760811010', '编制', '1', '', 10, 1, 'admin', '2020-03-19 17:37:26', 'admin', '2020-04-05 23:12:22');
INSERT INTO `sys_dict_item` VALUES ('1240573381785841666', '1240560989760811010', '审核完成', '23', '审核完成，如果未通过，则可修改并进入“”编制中“”状态', 23, 1, 'admin', '2020-03-19 17:38:38', 'admin', '2020-04-05 23:14:25');
INSERT INTO `sys_dict_item` VALUES ('1240574879701823489', '1240560989760811010', '编制完成', '13', '', 13, 1, 'admin', '2020-03-19 17:44:35', 'admin', '2020-04-05 23:12:45');
INSERT INTO `sys_dict_item` VALUES ('1240575444510994434', '1240560989760811010', '审核', '2', '如果审核不是多级审核，则无“审核中”状态，一审核就会由“编制完成”变为“审核完成”', 20, 1, 'admin', '2020-03-19 17:46:49', 'admin', '2020-04-05 23:12:58');
INSERT INTO `sys_dict_item` VALUES ('1240577748408627202', '1240560989760811010', '执行', '3', '', 30, 1, 'admin', '2020-03-19 17:55:59', 'admin', '2020-04-05 23:14:49');
INSERT INTO `sys_dict_item` VALUES ('1240577821125275650', '1240560989760811010', '执行完成', '33', '', 33, 1, 'admin', '2020-03-19 17:56:16', 'admin', '2020-04-05 23:15:09');
INSERT INTO `sys_dict_item` VALUES ('1244548996104896514', '1244548790885990401', '一级', '1', '', 1, 1, 'admin', '2020-03-30 16:56:18', NULL, NULL);
INSERT INTO `sys_dict_item` VALUES ('1244549081643532290', '1244548790885990401', '二级', '2', '', 1, 1, 'admin', '2020-03-30 16:56:38', NULL, NULL);
INSERT INTO `sys_dict_item` VALUES ('1244549174551560194', '1244548537323536386', '一级', '1', '', 1, 1, 'admin', '2020-03-30 16:57:00', NULL, NULL);
INSERT INTO `sys_dict_item` VALUES ('1244549216003866626', '1244548537323536386', '二级', '2', '', 1, 1, 'admin', '2020-03-30 16:57:10', NULL, NULL);
INSERT INTO `sys_dict_item` VALUES ('1244653877796933633', '1244653717570326530', '一般纳税人', '1', '', 1, 1, 'admin', '2020-03-30 23:53:04', NULL, NULL);
INSERT INTO `sys_dict_item` VALUES ('1246817882196135938', '1240560989760811010', '编制中', '12', '', 12, 1, 'admin', '2020-04-05 23:12:03', 'admin', '2020-04-05 23:12:31');
INSERT INTO `sys_dict_item` VALUES ('1246818259020795906', '1240560989760811010', '审核中', '22', '', 22, 1, 'admin', '2020-04-05 23:13:32', NULL, NULL);
INSERT INTO `sys_dict_item` VALUES ('1246818747715932161', '1240560989760811010', '执行中', '32', '', 32, 1, 'admin', '2020-04-05 23:15:29', NULL, NULL);
INSERT INTO `sys_dict_item` VALUES ('1246820365727420417', '1240560989760811010', '审核开始', '21', '可以对应这种情况：审核人查看后，虽未进行审核，可转为“审核开始”，以锁定避免被编辑。', 21, 1, 'admin', '2020-04-05 23:21:55', 'admin', '2020-04-05 23:22:36');
INSERT INTO `sys_dict_item` VALUES ('1250688147579228161', '1250687930947620866', '正常', '0', '', 1, 1, 'admin', '2020-04-16 15:31:05', '', NULL);
INSERT INTO `sys_dict_item` VALUES ('1250688201064992770', '1250687930947620866', '停止', '-1', '', 1, 1, 'admin', '2020-04-16 15:31:18', '', NULL);
INSERT INTO `sys_dict_item` VALUES ('1255343915896684546', '1240563037726208001', '采购付款单', 'fin_payment..202', '', 4, 1, 'admin', '2020-04-29 11:51:27', 'admin', '2020-04-29 11:55:51');
INSERT INTO `sys_dict_item` VALUES ('1255344267752652801', '1240563037726208001', '采购预付单', 'fin_payment..201', '', 3, 1, 'admin', '2020-04-29 11:52:51', 'admin', '2020-06-02 23:08:10');
INSERT INTO `sys_dict_item` VALUES ('1255344589665484801', '1240563037726208001', '应付单', 'fin_payable', '', 2, 1, 'admin', '2020-04-29 11:54:08', 'admin', '2020-04-29 11:55:32');
INSERT INTO `sys_dict_item` VALUES ('1255344900245307393', '1240563037726208001', '采购入库单', 'stk_io_bill..101', '', 1, 1, 'admin', '2020-04-29 11:55:22', NULL, NULL);
INSERT INTO `sys_dict_item` VALUES ('1260098270998884354', '1260097934330490882', '销售应收', '102', '', 102, 1, 'admin', '2020-05-12 14:43:34', 'admin', '2020-05-12 14:44:57');
INSERT INTO `sys_dict_item` VALUES ('1260098586909667329', '1260097934330490882', '其他应收', '199', '', 199, 1, 'admin', '2020-05-12 14:44:49', 'admin', '2020-05-12 15:15:10');
INSERT INTO `sys_dict_item` VALUES ('1260098992507252737', '1260098880586444801', '采购应付', '202', '', 202, 1, 'admin', '2020-05-12 14:46:26', 'admin', '2020-05-12 14:47:07');
INSERT INTO `sys_dict_item` VALUES ('1260099074837245954', '1260098880586444801', '其他应付', '299', '', 299, 1, 'admin', '2020-05-12 14:46:46', 'admin', '2020-05-12 15:14:50');
INSERT INTO `sys_dict_item` VALUES ('1260458169758998529', '1240561198460989442', '采购入库-红字', '1011', '', 1011, 1, 'admin', '2020-05-13 14:33:40', NULL, NULL);
INSERT INTO `sys_dict_item` VALUES ('1260458623607857153', '1240561198460989442', '销售出库-红字', '2011', '', 2011, 1, 'admin', '2020-05-13 14:35:29', NULL, NULL);
INSERT INTO `sys_dict_item` VALUES ('1261480891421949954', '1240563037726208001', '销售出库单', 'stk_io_bill..201', '', 1, 1, 'admin', '2020-05-16 10:17:36', NULL, NULL);
INSERT INTO `sys_dict_item` VALUES ('1261943893250203649', '1240561198460989442', '仓库调拨', '301', '', 3010, 1, 'admin', '2020-05-17 16:57:25', 'admin', '2020-05-17 16:57:47');
INSERT INTO `sys_dict_item` VALUES ('1263003146196119554', '1240561198460989442', '盘盈入库', '102', '', 1020, 1, 'admin', '2020-05-20 15:06:30', NULL, NULL);
INSERT INTO `sys_dict_item` VALUES ('1263003307358056450', '1240561198460989442', '盘亏出库', '202', '', 2020, 1, 'admin', '2020-05-20 15:07:09', NULL, NULL);
INSERT INTO `sys_dict_item` VALUES ('1263273069065629698', '1240561198460989442', '涨库入库', '191', '', 1910, 1, 'admin', '2020-05-21 08:59:05', 'admin', '2020-05-21 09:03:32');
INSERT INTO `sys_dict_item` VALUES ('1263273200909381633', '1240561198460989442', '成本调整', '801', '', 8010, 1, 'admin', '2020-05-21 08:59:36', NULL, NULL);
INSERT INTO `sys_dict_item` VALUES ('1263481284356096001', '1263374147459272705', '普通发票', '11', '', 11, 1, 'admin', '2020-05-21 22:46:27', 'admin', '2020-05-21 22:48:30');
INSERT INTO `sys_dict_item` VALUES ('1263481374277779458', '1263374147459272705', '专用发票', '12', '', 12, 1, 'admin', '2020-05-21 22:46:49', 'admin', '2020-05-21 22:48:38');
INSERT INTO `sys_dict_item` VALUES ('1263481462391717889', '1263374147459272705', '专用增值税发票', '13', '', 13, 1, 'admin', '2020-05-21 22:47:10', 'admin', '2020-05-21 22:48:46');
INSERT INTO `sys_dict_item` VALUES ('1263481770165551106', '1263374147459272705', '收据', '21', '', 21, 1, 'admin', '2020-05-21 22:48:23', NULL, NULL);
INSERT INTO `sys_dict_item` VALUES ('1263481997916258306', '1263374147459272705', '其他', '99', '', 99, 1, 'admin', '2020-05-21 22:49:17', NULL, NULL);
INSERT INTO `sys_dict_item` VALUES ('1264836396262674433', '1264836316952580097', '应收', '1', '', 1, 1, 'admin', '2020-05-25 16:31:11', NULL, NULL);
INSERT INTO `sys_dict_item` VALUES ('1264836464642412545', '1264836316952580097', '应付', '2', '', 2, 1, 'admin', '2020-05-25 16:31:27', NULL, NULL);
INSERT INTO `sys_dict_item` VALUES ('1265837497761980417', '1265837267708600321', '收款核应收', '101', '', 101, 1, 'admin', '2020-05-28 10:49:12', NULL, NULL);
INSERT INTO `sys_dict_item` VALUES ('1265837764825899010', '1265837654624755713', '付款核应付', '201', '', 201, 1, 'admin', '2020-05-28 10:50:16', NULL, NULL);
INSERT INTO `sys_dict_item` VALUES ('147c48ff4b51545032a9119d13f3222a', 'd6e1152968b02d69ff358c75b48a6ee1', '测试流程', 'test', NULL, 1, 1, 'admin', '2019-03-22 19:27:05', NULL, NULL);
INSERT INTO `sys_dict_item` VALUES ('1543fe7e5e26fb97cdafe4981bedc0c8', '4c03fca6bf1f0299c381213961566349', '单排布局', 'single', NULL, 2, 1, 'admin', '2022-07-12 17:43:39', 'admin', '2019-04-12 17:43:57');
INSERT INTO `sys_dict_item` VALUES ('1b8a6341163062dad8cb2fddd34e0c3b', '404a04a15f371566c658ee9ef9fc392a', '22', '222', NULL, 1, 1, 'admin', '2019-03-30 11:17:48', NULL, NULL);
INSERT INTO `sys_dict_item` VALUES ('1ce390c52453891f93514c1bd2795d44', 'ad7c65ba97c20a6805d5dcdf13cdaf36', '000', '00', NULL, 1, 1, 'admin', '2019-03-22 16:34:34', NULL, NULL);
INSERT INTO `sys_dict_item` VALUES ('1db531bcff19649fa82a644c8a939dc4', '4c03fca6bf1f0299c381213961566349', '组合布局', 'combination', '', 4, 1, 'admin', '2019-05-11 16:07:08', NULL, NULL);
INSERT INTO `sys_dict_item` VALUES ('222705e11ef0264d4214affff1fb4ff9', '4f69be5f507accea8d5df5f11346181a', '短信', '1', '', 1, 1, 'admin', '2023-02-28 10:50:36', 'admin', '2019-04-28 10:58:11');
INSERT INTO `sys_dict_item` VALUES ('23a5bb76004ed0e39414e928c4cde155', '4e4602b3e3686f0911384e188dc7efb4', '不等于', '!=', '不等于', 3, 1, 'admin', '2019-04-01 16:46:15', 'admin', '2019-04-01 17:48:40');
INSERT INTO `sys_dict_item` VALUES ('25847e9cb661a7c711f9998452dc09e6', '4e4602b3e3686f0911384e188dc7efb4', '小于等于', '<=', '小于等于', 6, 1, 'admin', '2019-04-01 16:44:34', 'admin', '2019-04-01 17:49:10');
INSERT INTO `sys_dict_item` VALUES ('2d51376643f220afdeb6d216a8ac2c01', '68168534ff5065a152bfab275c2136f8', '有效', '1', '有效', 2, 1, 'admin', '2019-04-26 19:22:01', NULL, NULL);
INSERT INTO `sys_dict_item` VALUES ('308c8aadf0c37ecdde188b97ca9833f5', '8dfe32e2d29ea9430a988b3b558bf233', '已发布', '1', '已发布', 2, 1, 'admin', '2019-04-16 17:41:24', NULL, NULL);
INSERT INTO `sys_dict_item` VALUES ('333e6b2196e01ef9a5f76d74e86a6e33', '8dfe32e2d29ea9430a988b3b558bf233', '未发布', '0', '未发布', 1, 1, 'admin', '2019-04-16 17:41:12', NULL, NULL);
INSERT INTO `sys_dict_item` VALUES ('337ea1e401bda7233f6258c284ce4f50', 'bd1b8bc28e65d6feefefb6f3c79f42fd', 'JSON', 'json', NULL, 1, 1, 'admin', '2019-04-12 17:26:33', NULL, NULL);
INSERT INTO `sys_dict_item` VALUES ('33bc9d9f753cf7dc40e70461e50fdc54', 'a9d9942bd0eccb6e89de92d130ec4c4a', '发送失败', '2', NULL, 3, 1, 'admin', '2019-04-12 18:20:02', NULL, NULL);
INSERT INTO `sys_dict_item` VALUES ('3fbc03d6c994ae06d083751248037c0e', '78bda155fe380b1b3f175f1e88c284c6', '已完成', '3', '已完成', 3, 1, 'admin', '2019-05-09 16:33:25', NULL, NULL);
INSERT INTO `sys_dict_item` VALUES ('41d7aaa40c9b61756ffb1f28da5ead8e', '0b5d19e1fce4b2e6647e6b4a17760c14', '通知公告', '1', NULL, 1, 1, 'admin', '2019-04-22 18:01:57', NULL, NULL);
INSERT INTO `sys_dict_item` VALUES ('41fa1e9571505d643aea87aeb83d4d76', '4e4602b3e3686f0911384e188dc7efb4', '等于', '=', '等于', 4, 1, 'admin', '2019-04-01 16:45:24', 'admin', '2019-04-01 17:49:00');
INSERT INTO `sys_dict_item` VALUES ('43d2295b8610adce9510ff196a49c6e9', '845da5006c97754728bf48b6a10f79cc', '正常', '1', NULL, NULL, 1, 'admin', '2019-03-18 21:45:51', NULL, NULL);
INSERT INTO `sys_dict_item` VALUES ('4f05fb5376f4c61502c5105f52e4dd2b', '83bfb33147013cc81640d5fd9eda030c', '操作日志', '2', NULL, NULL, 1, 'admin', '2019-03-18 23:22:49', NULL, NULL);
INSERT INTO `sys_dict_item` VALUES ('50223341bfb5ba30bf6319789d8d17fe', 'd6e1152968b02d69ff358c75b48a6ee1', '业务办理', 'business', NULL, 3, 1, 'admin', '2023-04-22 19:28:05', 'admin', '2019-03-22 23:24:39');
INSERT INTO `sys_dict_item` VALUES ('51222413e5906cdaf160bb5c86fb827c', 'a7adbcd86c37f7dbc9b66945c82ef9e6', '是', '1', '', 1, 1, 'admin', '2019-05-22 19:29:45', NULL, NULL);
INSERT INTO `sys_dict_item` VALUES ('538fca35afe004972c5f3947c039e766', '2e02df51611a4b9632828ab7e5338f00', '显示', '1', '显示', 1, 1, 'admin', '2025-03-26 18:27:13', 'admin', '2019-04-26 18:39:07');
INSERT INTO `sys_dict_item` VALUES ('5584c21993bde231bbde2b966f2633ac', '4e4602b3e3686f0911384e188dc7efb4', '自定义SQL表达式', 'USE_SQL_RULES', '自定义SQL表达式', 9, 1, 'admin', '2019-04-01 10:45:24', 'admin', '2019-04-01 17:49:27');
INSERT INTO `sys_dict_item` VALUES ('58b73b344305c99b9d8db0fc056bbc0a', '72cce0989df68887546746d8f09811aa', '主表', '2', NULL, 2, 1, 'admin', '2019-03-27 10:13:36', NULL, NULL);
INSERT INTO `sys_dict_item` VALUES ('5b65a88f076b32e8e69d19bbaadb52d5', '2f0320997ade5dd147c90130f7218c3e', '全体用户', 'ALL', NULL, NULL, 1, 'admin', '2020-10-17 21:22:43', 'admin', '2019-03-28 22:17:09');
INSERT INTO `sys_dict_item` VALUES ('5d833f69296f691843ccdd0c91212b6b', '880a895c98afeca9d9ac39f29e67c13e', '修改', '3', '', 3, 1, 'admin', '2019-07-22 10:55:07', 'admin', '2019-07-22 10:55:41');
INSERT INTO `sys_dict_item` VALUES ('5d84a8634c8fdfe96275385075b105c9', '3d9a351be3436fbefb1307d4cfb49bf2', '女', '2', NULL, 2, 1, NULL, '2019-01-04 14:56:56', NULL, '2019-01-04 17:38:12');
INSERT INTO `sys_dict_item` VALUES ('66c952ae2c3701a993e7db58f3baf55e', '4e4602b3e3686f0911384e188dc7efb4', '大于', '>', '大于', 1, 1, 'admin', '2019-04-01 10:45:46', 'admin', '2019-04-01 17:48:29');
INSERT INTO `sys_dict_item` VALUES ('6937c5dde8f92e9a00d4e2ded9198694', 'ad7c65ba97c20a6805d5dcdf13cdaf36', 'easyui', '3', NULL, 1, 1, 'admin', '2019-03-22 16:32:15', NULL, NULL);
INSERT INTO `sys_dict_item` VALUES ('69cacf64e244100289ddd4aa9fa3b915', 'a9d9942bd0eccb6e89de92d130ec4c4a', '未发送', '0', NULL, 1, 1, 'admin', '2019-04-12 18:19:23', NULL, NULL);
INSERT INTO `sys_dict_item` VALUES ('6a7a9e1403a7943aba69e54ebeff9762', '4f69be5f507accea8d5df5f11346181a', '邮件', '2', '', 2, 1, 'admin', '2031-02-28 10:50:44', 'admin', '2019-04-28 10:59:03');
INSERT INTO `sys_dict_item` VALUES ('6c682d78ddf1715baf79a1d52d2aa8c2', '72cce0989df68887546746d8f09811aa', '单表', '1', NULL, 1, 1, 'admin', '2019-03-27 10:13:29', NULL, NULL);
INSERT INTO `sys_dict_item` VALUES ('6d404fd2d82311fbc87722cd302a28bc', '4e4602b3e3686f0911384e188dc7efb4', '模糊', 'LIKE', '模糊', 7, 1, 'admin', '2019-04-01 16:46:02', 'admin', '2019-04-01 17:49:20');
INSERT INTO `sys_dict_item` VALUES ('6d4e26e78e1a09699182e08516c49fc4', '4d7fec1a7799a436d26d02325eff295e', '高', 'H', '高', 1, 1, 'admin', '2019-04-16 17:04:24', NULL, NULL);
INSERT INTO `sys_dict_item` VALUES ('700e9f030654f3f90e9ba76ab0713551', '6b78e3f59faec1a4750acff08030a79b', '333', '333', NULL, NULL, 1, 'admin', '2019-02-21 19:59:47', NULL, NULL);
INSERT INTO `sys_dict_item` VALUES ('7050c1522702bac3be40e3b7d2e1dfd8', 'c5a14c75172783d72cbee6ee7f5df5d1', '柱状图', 'bar', NULL, 1, 1, 'admin', '2019-04-12 17:05:17', NULL, NULL);
INSERT INTO `sys_dict_item` VALUES ('71b924faa93805c5c1579f12e001c809', 'd6e1152968b02d69ff358c75b48a6ee1', 'OA办公', 'oa', NULL, 2, 1, 'admin', '2021-03-22 19:27:17', 'admin', '2019-03-22 23:24:36');
INSERT INTO `sys_dict_item` VALUES ('75b260d7db45a39fc7f21badeabdb0ed', 'c36169beb12de8a71c8683ee7c28a503', '不启用', '0', NULL, NULL, 1, 'admin', '2019-03-18 23:29:41', 'admin', '2019-03-18 23:29:54');
INSERT INTO `sys_dict_item` VALUES ('7688469db4a3eba61e6e35578dc7c2e5', 'c36169beb12de8a71c8683ee7c28a503', '启用', '1', NULL, NULL, 1, 'admin', '2019-03-18 23:29:28', NULL, NULL);
INSERT INTO `sys_dict_item` VALUES ('78ea6cadac457967a4b1c4eb7aaa418c', 'fc6cd58fde2e8481db10d3a1e68ce70c', '正常', '1', NULL, NULL, 1, 'admin', '2019-03-18 23:30:28', NULL, NULL);
INSERT INTO `sys_dict_item` VALUES ('7ccf7b80c70ee002eceb3116854b75cb', 'ac2f7c0c5c5775fcea7e2387bcb22f01', '按钮权限', '2', NULL, NULL, 1, 'admin', '2019-03-18 23:25:40', NULL, NULL);
INSERT INTO `sys_dict_item` VALUES ('81fb2bb0e838dc68b43f96cc309f8257', 'fc6cd58fde2e8481db10d3a1e68ce70c', '冻结', '2', NULL, NULL, 1, 'admin', '2019-03-18 23:30:37', NULL, NULL);
INSERT INTO `sys_dict_item` VALUES ('83250269359855501ec4e9c0b7e21596', '4274efc2292239b6f000b153f50823ff', '可见/可访问(授权后可见/可访问)', '1', '', 1, 1, 'admin', '2019-05-10 17:54:51', NULL, NULL);
INSERT INTO `sys_dict_item` VALUES ('84778d7e928bc843ad4756db1322301f', '4e4602b3e3686f0911384e188dc7efb4', '大于等于', '>=', '大于等于', 5, 1, 'admin', '2019-04-01 10:46:02', 'admin', '2019-04-01 17:49:05');
INSERT INTO `sys_dict_item` VALUES ('848d4da35ebd93782029c57b103e5b36', 'c5a14c75172783d72cbee6ee7f5df5d1', '饼图', 'pie', NULL, 3, 1, 'admin', '2019-04-12 17:05:49', NULL, NULL);
INSERT INTO `sys_dict_item` VALUES ('84dfc178dd61b95a72900fcdd624c471', '78bda155fe380b1b3f175f1e88c284c6', '处理中', '2', '处理中', 2, 1, 'admin', '2019-05-09 16:33:01', NULL, NULL);
INSERT INTO `sys_dict_item` VALUES ('86f19c7e0a73a0bae451021ac05b99dd', 'ac2f7c0c5c5775fcea7e2387bcb22f01', '子菜单', '1', NULL, NULL, 1, 'admin', '2019-03-18 23:25:27', NULL, NULL);
INSERT INTO `sys_dict_item` VALUES ('8bccb963e1cd9e8d42482c54cc609ca2', '4f69be5f507accea8d5df5f11346181a', '微信', '3', NULL, 3, 1, 'admin', '2021-05-11 14:29:12', 'admin', '2019-04-11 14:29:31');
INSERT INTO `sys_dict_item` VALUES ('8c618902365ca681ebbbe1e28f11a548', '4c753b5293304e7a445fd2741b46529d', '启用', '1', '', 0, 1, 'admin', '2020-07-18 23:19:27', 'admin', '2019-05-17 14:51:18');
INSERT INTO `sys_dict_item` VALUES ('8cdf08045056671efd10677b8456c999', '4274efc2292239b6f000b153f50823ff', '可编辑(未授权时禁用)', '2', '', 2, 1, 'admin', '2019-05-10 17:55:38', NULL, NULL);
INSERT INTO `sys_dict_item` VALUES ('8ff48e657a7c5090d4f2a59b37d1b878', '4d7fec1a7799a436d26d02325eff295e', '中', 'M', '中', 2, 1, 'admin', '2019-04-16 17:04:40', NULL, NULL);
INSERT INTO `sys_dict_item` VALUES ('948923658baa330319e59b2213cda97c', '880a895c98afeca9d9ac39f29e67c13e', '添加', '2', '', 2, 1, 'admin', '2019-07-22 10:54:59', 'admin', '2019-07-22 10:55:36');
INSERT INTO `sys_dict_item` VALUES ('9a96c4a4e4c5c9b4e4d0cbf6eb3243cc', '4c753b5293304e7a445fd2741b46529d', '不启用', '0', NULL, 1, 1, 'admin', '2019-03-18 23:19:53', NULL, NULL);
INSERT INTO `sys_dict_item` VALUES ('a1e7d1ca507cff4a480c8caba7c1339e', '880a895c98afeca9d9ac39f29e67c13e', '导出', '6', '', 6, 1, 'admin', '2019-07-22 12:06:50', NULL, NULL);
INSERT INTO `sys_dict_item` VALUES ('a2321496db6febc956a6c70fab94cb0c', '404a04a15f371566c658ee9ef9fc392a', '3', '3', NULL, 1, 1, 'admin', '2019-03-30 11:18:18', NULL, NULL);
INSERT INTO `sys_dict_item` VALUES ('a2be752dd4ec980afaec1efd1fb589af', '8dfe32e2d29ea9430a988b3b558bf233', '已撤销', '2', '已撤销', 3, 1, 'admin', '2019-04-16 17:41:39', NULL, NULL);
INSERT INTO `sys_dict_item` VALUES ('aa0d8a8042a18715a17f0a888d360aa4', 'ac2f7c0c5c5775fcea7e2387bcb22f01', '一级菜单', '0', NULL, NULL, 1, 'admin', '2019-03-18 23:24:52', NULL, NULL);
INSERT INTO `sys_dict_item` VALUES ('adcf2a1fe93bb99a84833043f475fe0b', '4e4602b3e3686f0911384e188dc7efb4', '包含', 'IN', '包含', 8, 1, 'admin', '2019-04-01 16:45:47', 'admin', '2019-04-01 17:49:24');
INSERT INTO `sys_dict_item` VALUES ('b029a41a851465332ee4ee69dcf0a4c2', '0b5d19e1fce4b2e6647e6b4a17760c14', '系统消息', '2', NULL, 1, 1, 'admin', '2019-02-22 18:02:08', 'admin', '2019-04-22 18:02:13');
INSERT INTO `sys_dict_item` VALUES ('b2a8b4bb2c8e66c2c4b1bb086337f393', '3486f32803bb953e7155dab3513dc68b', '正常', '0', NULL, NULL, 1, 'admin', '2022-10-18 21:46:48', 'admin', '2019-03-28 22:22:20');
INSERT INTO `sys_dict_item` VALUES ('b57f98b88363188daf38d42f25991956', '6b78e3f59faec1a4750acff08030a79b', '22', '222', NULL, NULL, 0, 'admin', '2019-02-21 19:59:43', 'admin', '2019-03-11 21:23:27');
INSERT INTO `sys_dict_item` VALUES ('b5f3bd5f66bb9a83fecd89228c0d93d1', '68168534ff5065a152bfab275c2136f8', '无效', '0', '无效', 1, 1, 'admin', '2019-04-26 19:21:49', NULL, NULL);
INSERT INTO `sys_dict_item` VALUES ('b9fbe2a3602d4a27b45c100ac5328484', '78bda155fe380b1b3f175f1e88c284c6', '待提交', '1', '待提交', 1, 1, 'admin', '2019-05-09 16:32:35', NULL, NULL);
INSERT INTO `sys_dict_item` VALUES ('ba27737829c6e0e582e334832703d75e', '236e8a4baff0db8c62c00dd95632834f', '同步', '1', '同步', 1, 1, 'admin', '2019-05-15 15:28:15', NULL, NULL);
INSERT INTO `sys_dict_item` VALUES ('bcec04526b04307e24a005d6dcd27fd6', '880a895c98afeca9d9ac39f29e67c13e', '导入', '5', '', 5, 1, 'admin', '2019-07-22 12:06:41', NULL, NULL);
INSERT INTO `sys_dict_item` VALUES ('c53da022b9912e0aed691bbec3c78473', '880a895c98afeca9d9ac39f29e67c13e', '查询', '1', '', 1, 1, 'admin', '2019-07-22 10:54:51', NULL, NULL);
INSERT INTO `sys_dict_item` VALUES ('c5700a71ad08994d18ad1dacc37a71a9', 'a7adbcd86c37f7dbc9b66945c82ef9e6', '否', '0', '', 1, 1, 'admin', '2019-05-22 19:29:55', NULL, NULL);
INSERT INTO `sys_dict_item` VALUES ('cbfcc5b88fc3a90975df23ffc8cbe29c', 'c5a14c75172783d72cbee6ee7f5df5d1', '曲线图', 'line', NULL, 2, 1, 'admin', '2019-05-12 17:05:30', 'admin', '2019-04-12 17:06:06');
INSERT INTO `sys_dict_item` VALUES ('d217592908ea3e00ff986ce97f24fb98', 'c5a14c75172783d72cbee6ee7f5df5d1', '数据列表', 'table', NULL, 4, 1, 'admin', '2019-04-12 17:05:56', NULL, NULL);
INSERT INTO `sys_dict_item` VALUES ('df168368dcef46cade2aadd80100d8aa', '3d9a351be3436fbefb1307d4cfb49bf2', '男', '1', NULL, 1, 1, NULL, '2027-08-04 14:56:49', 'admin', '2019-03-23 22:44:44');
INSERT INTO `sys_dict_item` VALUES ('e6329e3a66a003819e2eb830b0ca2ea0', '4e4602b3e3686f0911384e188dc7efb4', '小于', '<', '小于', 2, 1, 'admin', '2019-04-01 16:44:15', 'admin', '2019-04-01 17:48:34');
INSERT INTO `sys_dict_item` VALUES ('e94eb7af89f1dbfa0d823580a7a6e66a', '236e8a4baff0db8c62c00dd95632834f', '不同步', '0', '不同步', 2, 1, 'admin', '2019-05-15 15:28:28', NULL, NULL);
INSERT INTO `sys_dict_item` VALUES ('f0162f4cc572c9273f3e26b2b4d8c082', 'ad7c65ba97c20a6805d5dcdf13cdaf36', 'booostrap', '1', NULL, 1, 1, 'admin', '2021-08-22 16:32:04', 'admin', '2019-03-22 16:33:57');
INSERT INTO `sys_dict_item` VALUES ('f16c5706f3ae05c57a53850c64ce7c45', 'a9d9942bd0eccb6e89de92d130ec4c4a', '发送成功', '1', NULL, 2, 1, 'admin', '2019-04-12 18:19:43', NULL, NULL);
INSERT INTO `sys_dict_item` VALUES ('f2a7920421f3335afdf6ad2b342f6b5d', '845da5006c97754728bf48b6a10f79cc', '冻结', '2', NULL, NULL, 1, 'admin', '2019-03-18 21:46:02', NULL, NULL);
INSERT INTO `sys_dict_item` VALUES ('f37f90c496ec9841c4c326b065e00bb2', '83bfb33147013cc81640d5fd9eda030c', '登录日志', '1', NULL, NULL, 1, 'admin', '2019-03-18 23:22:37', NULL, NULL);
INSERT INTO `sys_dict_item` VALUES ('f753aff60ff3931c0ecb4812d8b5e643', '4c03fca6bf1f0299c381213961566349', '双排布局', 'double', NULL, 3, 1, 'admin', '2019-04-12 17:43:51', NULL, NULL);
INSERT INTO `sys_dict_item` VALUES ('f80a8f6838215753b05e1a5ba3346d22', '880a895c98afeca9d9ac39f29e67c13e', '删除', '4', '', 4, 1, 'admin', '2019-07-22 10:55:14', 'admin', '2019-07-22 10:55:30');
INSERT INTO `sys_dict_item` VALUES ('fcec03570f68a175e1964808dc3f1c91', '4c03fca6bf1f0299c381213961566349', 'Tab风格', 'tab', NULL, 1, 1, 'admin', '2019-04-12 17:43:31', NULL, NULL);
INSERT INTO `sys_dict_item` VALUES ('fe50b23ae5e68434def76f67cef35d2d', '78bda155fe380b1b3f175f1e88c284c6', '已作废', '4', '已作废', 4, 1, 'admin', '2021-09-09 16:33:43', 'admin', '2019-05-09 16:34:40');

-- ----------------------------
-- Table structure for sys_fill_rule
-- ----------------------------
DROP TABLE IF EXISTS `sys_fill_rule`;
CREATE TABLE `sys_fill_rule`  (
  `id` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '主键ID',
  `rule_name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '规则名称',
  `rule_code` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '规则Code',
  `rule_class` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '规则实现类',
  `rule_params` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '规则参数',
  `update_by` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '修改人',
  `update_time` datetime(0) NULL DEFAULT NULL COMMENT '修改时间',
  `create_by` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '创建人',
  `create_time` datetime(0) NULL DEFAULT NULL COMMENT '创建时间',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `uni_sys_fill_rule_code`(`rule_code`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_fill_rule
-- ----------------------------
INSERT INTO `sys_fill_rule` VALUES ('1202551334738382850', '机构编码生成', 'org_num_role', 'org.jeecg.modules.system.rule.OrgCodeRule', '{\"parentId\":\"c6d7cb4deeac411cb3384b1b31278596\"}', 'admin', '2019-12-09 10:37:06', 'admin', '2019-12-05 19:32:35');
INSERT INTO `sys_fill_rule` VALUES ('1202787623203065858', '分类字典编码生成', 'category_code_rule', 'org.jeecg.modules.system.rule.CategoryCodeRule', '{\"pid\":\"\"}', 'admin', '2019-12-09 10:36:54', 'admin', '2019-12-06 11:11:31');
INSERT INTO `sys_fill_rule` VALUES ('1241291132531798017', '出入库单据编号', 'stock_io_bill_no', 'io.finer.erp.jeecg.bas.rule.BillNoRule', '{\"prefix\":\"STK-\", \"period\":\"yyyyMMdd-\", \"seqLen\":6}', 'admin', '2020-04-16 16:09:54', 'admin', '2020-03-21 17:10:43');
INSERT INTO `sys_fill_rule` VALUES ('1249597408551698433', '应付单编号', 'payable_bill_no', 'io.finer.erp.jeecg.bas.rule.BillNoRule', '{\"prefix\":\"PAB-\", \"period\":\"yyyyMMdd-\", \"seqLen\":6}', 'admin', '2020-04-13 15:18:59', 'admin', '2020-04-13 15:16:53');
INSERT INTO `sys_fill_rule` VALUES ('1250070984978247682', '付款单编号', 'payment_bill_no', 'io.finer.erp.jeecg.bas.rule.BillNoRule', '{\"prefix\":\"PAY-\", \"period\":\"yyyyMMdd-\", \"seqLen\":6}', 'admin', '2020-04-14 22:39:15', 'admin', '2020-04-14 22:38:43');
INSERT INTO `sys_fill_rule` VALUES ('1255672398623555586', '应收单号', 'receivable_bill_no', 'io.finer.erp.jeecg.bas.rule.BillNoRule', '{\"prefix\":\"RAB-\", \"period\":\"yyyyMMdd-\", \"seqLen\":6}', 'admin', '2020-04-30 09:38:00', 'admin', '2020-04-30 09:36:44');
INSERT INTO `sys_fill_rule` VALUES ('1255673458616451074', '收款单号', 'receipt_bill_no', 'io.finer.erp.jeecg.bas.rule.BillNoRule', '{\"prefix\":\"REC-\", \"period\":\"yyyyMMdd-\", \"seqLen\":6}', 'admin', '2020-04-30 09:42:33', 'admin', '2020-04-30 09:40:56');
INSERT INTO `sys_fill_rule` VALUES ('1262288013773836290', '盘点卡单据编号', 'stock_check_bill_no', 'io.finer.erp.jeecg.bas.rule.BillNoRule', '{\"prefix\":\"STC-\", \"period\":\"yyyyMMdd-\", \"seqLen\":6}', 'admin', '2020-05-18 15:45:52', 'admin', '2020-05-18 15:44:49');
INSERT INTO `sys_fill_rule` VALUES ('1263493459715964929', '采购发票登记单号', 'pur_invoice_bill_no', 'io.finer.erp.jeecg.bas.rule.BillNoRule', '{\"prefix\":\"PUI-\", \"period\":\"yyyyMMdd-\", \"seqLen\":6}', 'admin', '2020-05-21 23:36:58', 'admin', '2020-05-21 23:34:50');
INSERT INTO `sys_fill_rule` VALUES ('1264461661400862721', '销售发票登记单号', 'sal_invoice_bill_no', 'io.finer.erp.jeecg.bas.rule.BillNoRule', '{\"prefix\":\"SAI-\", \"period\":\"yyyyMMdd-\", \"seqLen\":6}', 'admin', '2020-05-24 15:42:58', 'admin', '2020-05-24 15:42:07');
INSERT INTO `sys_fill_rule` VALUES ('1265847452414017537', '应付核销单号', 'payable_check_bill_no', 'io.finer.erp.jeecg.bas.rule.BillNoRule', '{\"prefix\":\"PBC-\", \"period\":\"yyyyMMdd-\", \"seqLen\":6}', 'admin', '2020-05-28 11:30:13', 'admin', '2020-05-28 11:28:46');
INSERT INTO `sys_fill_rule` VALUES ('1265848071908524033', '应收核销单号', 'receivable_check_bill_no', 'io.finer.erp.jeecg.bas.rule.BillNoRule', '{\"prefix\":\"RBC-\", \"period\":\"yyyyMMdd-\", \"seqLen\":6}', 'admin', '2020-05-28 11:31:36', 'admin', '2020-05-28 11:31:13');

-- ----------------------------
-- Table structure for sys_log
-- ----------------------------
DROP TABLE IF EXISTS `sys_log`;
CREATE TABLE `sys_log`  (
  `id` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `log_type` int(2) NULL DEFAULT NULL COMMENT '日志类型（1登录日志，2操作日志）',
  `log_content` varchar(1000) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '日志内容',
  `operate_type` int(2) NULL DEFAULT NULL COMMENT '操作类型',
  `userid` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '操作用户账号',
  `username` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '操作用户名称',
  `ip` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT 'IP',
  `method` varchar(500) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '请求java方法',
  `request_url` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '请求路径',
  `request_param` longtext CHARACTER SET utf8 COLLATE utf8_general_ci NULL COMMENT '请求参数',
  `request_type` varchar(10) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '请求类型',
  `cost_time` bigint(20) NULL DEFAULT NULL COMMENT '耗时',
  `create_by` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '创建人',
  `create_time` datetime(0) NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '更新人',
  `update_time` datetime(0) NULL DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `index_table_userid`(`userid`) USING BTREE,
  INDEX `index_logt_ype`(`log_type`) USING BTREE,
  INDEX `index_operate_type`(`operate_type`) USING BTREE,
  INDEX `index_log_type`(`log_type`) USING BTREE
) ENGINE = MyISAM CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '系统日志表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for sys_permission
-- ----------------------------
DROP TABLE IF EXISTS `sys_permission`;
CREATE TABLE `sys_permission`  (
  `id` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '主键id',
  `parent_id` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '父id',
  `name` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '菜单标题',
  `url` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '路径',
  `component` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '组件',
  `component_name` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '组件名字',
  `redirect` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '一级菜单跳转地址',
  `menu_type` int(11) NULL DEFAULT NULL COMMENT '菜单类型(0:一级菜单; 1:子菜单:2:按钮权限)',
  `perms` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '菜单权限编码',
  `perms_type` varchar(10) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '0' COMMENT '权限策略1显示2禁用',
  `sort_no` double(8, 2) NULL DEFAULT NULL COMMENT '菜单排序',
  `always_show` tinyint(1) NULL DEFAULT NULL COMMENT '聚合子路由: 1是0否',
  `icon` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '菜单图标',
  `is_route` tinyint(1) NULL DEFAULT 1 COMMENT '是否路由菜单: 0:不是  1:是（默认值1）',
  `is_leaf` tinyint(1) NULL DEFAULT NULL COMMENT '是否叶子节点:    1:是   0:不是',
  `keep_alive` tinyint(1) NULL DEFAULT NULL COMMENT '是否缓存该页面:    1:是   0:不是',
  `hidden` int(2) NULL DEFAULT 0 COMMENT '是否隐藏路由: 0否,1是',
  `description` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '描述',
  `create_by` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '创建人',
  `create_time` datetime(0) NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '更新人',
  `update_time` datetime(0) NULL DEFAULT NULL COMMENT '更新时间',
  `del_flag` int(1) NULL DEFAULT 0 COMMENT '删除状态 0正常 1已删除',
  `rule_flag` int(3) NULL DEFAULT 0 COMMENT '是否添加数据权限1是0否',
  `status` varchar(2) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '按钮权限状态(0无效1有效)',
  `internal_or_external` tinyint(1) NULL DEFAULT NULL COMMENT '外链菜单打开方式 0/内部打开 1/外部打开',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `index_prem_pid`(`parent_id`) USING BTREE,
  INDEX `index_prem_is_route`(`is_route`) USING BTREE,
  INDEX `index_prem_is_leaf`(`is_leaf`) USING BTREE,
  INDEX `index_prem_sort_no`(`sort_no`) USING BTREE,
  INDEX `index_prem_del_flag`(`del_flag`) USING BTREE,
  INDEX `index_menu_type`(`menu_type`) USING BTREE,
  INDEX `index_menu_hidden`(`hidden`) USING BTREE,
  INDEX `index_menu_status`(`status`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '菜单权限表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_permission
-- ----------------------------
INSERT INTO `sys_permission` VALUES ('00a2a0ae65cdca5e93209cdbde97cbe6', '2e42e3835c2b44ec9f7bc26c146ee531', '成功', '/result/success', 'result/Success', NULL, NULL, 1, NULL, NULL, 1.00, NULL, NULL, 1, 1, NULL, NULL, NULL, NULL, '2018-12-25 20:34:38', NULL, NULL, 0, 0, NULL, NULL);
INSERT INTO `sys_permission` VALUES ('020b06793e4de2eee0007f603000c769', 'f0675b52d89100ee88472b6800754a08', 'ViserChartDemo', '/report/ViserChartDemo', 'jeecg/report/ViserChartDemo', NULL, NULL, 1, NULL, NULL, 3.00, 0, NULL, 1, 1, NULL, 0, NULL, 'admin', '2019-04-03 19:08:53', 'admin', '2019-04-03 19:08:53', 0, 0, NULL, NULL);
INSERT INTO `sys_permission` VALUES ('024f1fd1283dc632458976463d8984e1', '700b7f95165c46cc7a78bf227aa8fed3', 'Tomcat信息', '/monitor/TomcatInfo', 'modules/monitor/TomcatInfo', NULL, NULL, 1, NULL, NULL, 4.00, 0, NULL, 1, 1, NULL, 0, NULL, 'admin', '2019-04-02 09:44:29', 'admin', '2019-05-07 15:19:10', 0, 0, NULL, NULL);
INSERT INTO `sys_permission` VALUES ('043780fa095ff1b2bec4dc406d76f023', '2a470fc0c3954d9dbb61de6d80846549', '表格合计', '/jeecg/tableTotal', 'jeecg/TableTotal', NULL, NULL, 1, NULL, '1', 3.00, 0, NULL, 1, 1, 0, 0, NULL, 'admin', '2019-08-14 10:28:46', NULL, NULL, 0, 0, '1', NULL);
INSERT INTO `sys_permission` VALUES ('05b3c82ddb2536a4a5ee1a4c46b5abef', '540a2936940846cb98114ffb0d145cb8', '用户列表', '/list/user-list', 'list/UserList', NULL, NULL, 1, NULL, NULL, 3.00, NULL, NULL, 1, 1, NULL, NULL, NULL, NULL, '2018-12-25 20:34:38', NULL, NULL, 0, 0, NULL, NULL);
INSERT INTO `sys_permission` VALUES ('0620e402857b8c5b605e1ad9f4b89350', '2a470fc0c3954d9dbb61de6d80846549', '异步树列表Demo', '/jeecg/JeecgTreeTable', 'jeecg/JeecgTreeTable', NULL, NULL, 1, NULL, '0', 3.00, 0, NULL, 1, 1, NULL, 0, NULL, 'admin', '2019-05-13 17:30:30', 'admin', '2019-05-13 17:32:17', 0, 0, '1', NULL);
INSERT INTO `sys_permission` VALUES ('078f9558cdeab239aecb2bda1a8ed0d1', 'fb07ca05a3e13674dbf6d3245956da2e', '搜索列表（文章）', '/list/search/article', 'list/TableList', NULL, NULL, 1, NULL, NULL, 1.00, 0, NULL, 1, 1, NULL, 0, NULL, 'admin', '2019-02-12 14:00:34', 'admin', '2019-02-12 14:17:54', 0, 0, NULL, NULL);
INSERT INTO `sys_permission` VALUES ('08e6b9dc3c04489c8e1ff2ce6f105aa4', '', '系统监控', '/dashboard3', 'layouts/RouteView', NULL, NULL, 0, NULL, NULL, 52.00, 0, 'dashboard', 1, 0, 0, 0, NULL, NULL, '2018-12-25 20:34:38', 'admin', '2020-03-25 10:22:43', 0, 0, NULL, 0);
INSERT INTO `sys_permission` VALUES ('0ac2ad938963b6c6d1af25477d5b8b51', '8d4683aacaa997ab86b966b464360338', '代码生成按钮', NULL, NULL, NULL, NULL, 2, 'online:goGenerateCode', '1', 1.00, 0, NULL, 1, 1, NULL, 0, NULL, 'admin', '2019-06-11 14:20:09', NULL, NULL, 0, 0, '1', NULL);
INSERT INTO `sys_permission` VALUES ('109c78a583d4693ce2f16551b7786786', 'e41b69c57a941a3bbcce45032fe57605', 'Online报表配置', '/online/cgreport', 'modules/online/cgreport/OnlCgreportHeadList', NULL, NULL, 1, NULL, NULL, 2.00, 0, NULL, 1, 1, NULL, 0, NULL, 'admin', '2019-03-08 10:51:07', 'admin', '2019-03-30 19:04:28', 0, 0, NULL, NULL);
INSERT INTO `sys_permission` VALUES ('1166535831146504193', '2a470fc0c3954d9dbb61de6d80846549', '对象存储', '/oss/file', 'modules/oss/OSSFileList', NULL, NULL, 1, NULL, '1', 1.00, 0, '', 1, 1, 0, 0, NULL, 'admin', '2019-08-28 02:19:50', 'admin', '2019-08-28 02:20:57', 0, 0, '1', NULL);
INSERT INTO `sys_permission` VALUES ('1170592628746878978', 'd7d6e2e4e2934f2c9385a623fd98c6f3', '菜单管理2', '/isystem/newPermissionList', 'system/NewPermissionList', NULL, NULL, 1, NULL, '1', 100.00, 0, NULL, 1, 1, 0, 0, NULL, 'admin', '2019-09-08 15:00:05', 'admin', '2019-12-25 09:58:18', 0, 0, '1', 0);
INSERT INTO `sys_permission` VALUES ('1174506953255182338', 'd7d6e2e4e2934f2c9385a623fd98c6f3', '职务管理', '/isystem/position', 'system/SysPositionList', NULL, NULL, 1, NULL, '1', 2.00, 0, NULL, 1, 1, 0, 0, NULL, 'admin', '2019-09-19 10:14:13', 'admin', '2019-09-19 10:15:22', 0, 0, '1', 0);
INSERT INTO `sys_permission` VALUES ('1174590283938041857', 'd7d6e2e4e2934f2c9385a623fd98c6f3', '通讯录', '/isystem/addressList', 'system/AddressList', NULL, NULL, 1, NULL, '1', 3.00, 0, NULL, 1, 1, 0, 0, NULL, 'admin', '2019-09-19 15:45:21', NULL, NULL, 0, 0, '1', 0);
INSERT INTO `sys_permission` VALUES ('1192318987661234177', 'e41b69c57a941a3bbcce45032fe57605', '系统编码规则', '/isystem/fillRule', 'system/SysFillRuleList', NULL, NULL, 1, NULL, '1', 3.00, 0, NULL, 1, 1, 0, 0, NULL, 'admin', '2019-11-07 13:52:53', 'admin', '2019-12-25 09:53:40', 0, 0, '1', 0);
INSERT INTO `sys_permission` VALUES ('1205097455226462210', '1240582498747314177', '大屏设计', '/big/screen', 'layouts/RouteView', NULL, NULL, 1, NULL, '1', 1.00, 0, 'area-chart', 1, 0, 0, 0, NULL, 'admin', '2019-12-12 20:09:58', 'admin', '2020-03-19 18:16:06', 0, 0, '1', 0);
INSERT INTO `sys_permission` VALUES ('1205098241075453953', '1205097455226462210', '生产销售监控', '{{ window._CONFIG[\'domianURL\'] }}/big/screen/templat/index1', 'layouts/IframePageView', NULL, NULL, 1, NULL, '1', 1.00, 0, NULL, 1, 1, 0, 0, NULL, 'admin', '2019-12-12 20:13:05', 'admin', '2019-12-12 20:15:27', 0, 0, '1', 1);
INSERT INTO `sys_permission` VALUES ('1205306106780364802', '1205097455226462210', '智慧物流监控', '{{ window._CONFIG[\'domianURL\'] }}/big/screen/templat/index2', 'layouts/IframePageView', NULL, NULL, 1, NULL, '1', 2.00, 0, NULL, 1, 1, 0, 0, NULL, 'admin', '2019-12-13 09:59:04', 'admin', '2019-12-25 09:28:03', 0, 0, '1', 0);
INSERT INTO `sys_permission` VALUES ('1209731624921534465', 'd7d6e2e4e2934f2c9385a623fd98c6f3', '多数据源管理', '/isystem/dataSource', 'system/SysDataSourceList', NULL, NULL, 1, NULL, '1', 3.00, 0, NULL, 1, 1, 0, 0, NULL, 'admin', '2019-12-25 15:04:30', NULL, NULL, 0, 0, '1', 0);
INSERT INTO `sys_permission` VALUES ('1224641973866467330', 'd7d6e2e4e2934f2c9385a623fd98c6f3', '编码校验规则', '/isystem/checkRule', 'system/SysCheckRuleList', NULL, NULL, 1, NULL, '1', 2.00, 0, NULL, 1, 1, 0, 0, NULL, 'admin', '2019-11-07 13:52:53', NULL, NULL, 0, 0, '1', 0);
INSERT INTO `sys_permission` VALUES ('1229674163694841857', 'e41b69c57a941a3bbcce45032fe57605', 'AUTO在线表单ERP', '/online/cgformErpList/:code', 'modules/online/cgform/auto/erp/OnlCgformErpList', NULL, NULL, 1, NULL, '1', 5.00, 0, NULL, 1, 1, 0, 1, NULL, 'admin', '2020-02-18 15:49:00', 'admin', '2020-02-18 15:52:25', 0, 0, '1', 0);
INSERT INTO `sys_permission` VALUES ('1235823781053313025', 'e41b69c57a941a3bbcce45032fe57605', 'AUTO在线内嵌子表', '/online/cgformInnerTableList/:code', 'modules/online/cgform/auto/innerTable/OnlCgformInnerTableList', NULL, NULL, 1, NULL, '1', 999.00, 0, NULL, 1, 1, 0, 1, NULL, 'admin', '2020-03-06 15:05:24', 'admin', '2020-03-06 15:07:42', 0, 0, '1', 0);
INSERT INTO `sys_permission` VALUES ('1240582498747314177', 'e41b69c57a941a3bbcce45032fe57605', 'DEMO', '/demo', 'layouts/RouteView', NULL, NULL, 1, NULL, '1', 99.00, 0, 'layout', 1, 0, 0, 0, NULL, 'admin', '2020-03-19 18:14:51', 'admin', '2020-03-20 15:17:31', 0, 0, '1', 0);
INSERT INTO `sys_permission` VALUES ('1242262642546475010', '1242263502445903874', '计量单位', '/erp/bas/measureUnit', 'erp/bas/BasMeasureUnitList', NULL, NULL, 1, NULL, '1', 30.00, 0, NULL, 1, 1, 0, 0, NULL, 'admin', '2020-03-24 09:31:09', 'admin', '2020-05-29 23:10:42', 0, 0, '1', 0);
INSERT INTO `sys_permission` VALUES ('1242263502445903874', '', '基础数据', '/erp/bas', 'layouts/RouteView', NULL, NULL, 0, NULL, '1', 9.00, 0, 'table', 1, 0, 0, 0, NULL, 'admin', '2020-03-24 09:34:34', 'admin', '2020-03-25 10:34:42', 0, 0, '1', 0);
INSERT INTO `sys_permission` VALUES ('1244271300749729794', '1242263502445903874', '物料分类', '/erp/bas/materialCategory', 'erp/bas/BasMaterialCategoryList', NULL, NULL, 1, NULL, '1', 19.00, 0, NULL, 1, 1, 0, 0, NULL, 'admin', '2020-03-29 22:32:50', 'admin', '2020-04-01 08:59:01', 0, 0, '1', 0);
INSERT INTO `sys_permission` VALUES ('1244876622988214274', '', '库存管理', '/erp/stock', 'layouts/RouteView', NULL, NULL, 0, NULL, '1', 1.00, 0, 'hdd', 1, 0, 0, 0, NULL, 'admin', '2020-03-31 14:38:10', 'admin', '2020-03-31 14:47:54', 0, 0, '1', 0);
INSERT INTO `sys_permission` VALUES ('1244877762060517378', '1261213213500452866', '采购入库', '/erp/stock/purIn', 'erp/stock/PurInBillList', NULL, NULL, 1, NULL, '1', 1010.00, 0, NULL, 1, 1, 0, 0, NULL, 'admin', '2020-03-31 14:42:42', 'admin', '2020-05-15 16:35:31', 0, 0, '1', 0);
INSERT INTO `sys_permission` VALUES ('1245154050731200514', '1242263502445903874', '仓库', '/erp/bas/warehouse', 'erp/bas/BasWarehouseList', NULL, NULL, 1, NULL, '1', 17.00, 0, NULL, 1, 1, 0, 0, NULL, 'admin', '2020-04-01 09:00:34', 'admin', '2020-04-01 09:02:58', 0, 0, '1', 0);
INSERT INTO `sys_permission` VALUES ('1245154570166390786', '1242263502445903874', '客户', '/erp/bas/customer', 'erp/bas/BasCustomerList', NULL, NULL, 1, NULL, '1', 1.00, 0, NULL, 1, 1, 0, 0, NULL, 'admin', '2020-04-01 09:02:38', 'admin', '2020-04-01 09:04:48', 0, 0, '1', 0);
INSERT INTO `sys_permission` VALUES ('1245154914959151105', '1242263502445903874', '供应商', '/erp/bas/supplier', 'erp/bas/BasSupplierList', NULL, NULL, 1, NULL, '1', 2.00, 0, NULL, 1, 1, 0, 0, NULL, 'admin', '2020-04-01 09:04:00', 'admin', '2020-04-01 09:20:18', 0, 0, '1', 0);
INSERT INTO `sys_permission` VALUES ('1248893062452006914', '1244876622988214274', '实时库存', '/erp/stock/inventory', 'erp/stock/StkInventoryList', NULL, NULL, 1, NULL, '1', 9.00, 0, NULL, 1, 1, 0, 0, NULL, 'admin', '2020-04-11 16:38:04', 'admin', '2020-05-21 10:33:15', 0, 0, '1', 0);
INSERT INTO `sys_permission` VALUES ('1249544156015607810', '', '往来管理', '/erp/finance', 'layouts/RouteView', NULL, NULL, 0, NULL, '1', 8.00, 0, 'money-collect', 1, 0, 0, 0, NULL, 'admin', '2020-04-13 11:45:17', 'admin', '2020-05-30 17:02:02', 0, 0, '1', 0);
INSERT INTO `sys_permission` VALUES ('1249544661932556290', '1259846940940980225', '采购应付', '/erp/finance/purPayable', 'erp/finance/PurPayableList', NULL, NULL, 1, NULL, '1', 202.00, 0, NULL, 1, 1, 0, 0, NULL, 'admin', '2020-04-13 11:47:17', 'admin', '2020-05-12 16:10:01', 0, 0, '1', 0);
INSERT INTO `sys_permission` VALUES ('1250093240089485313', '1259846469224386562', '采购付款', '/erp/finance/purPayment', 'erp/finance/PurPaymentList', NULL, NULL, 1, NULL, '1', 2.00, 0, NULL, 1, 1, 0, 0, NULL, 'admin', '2020-04-15 00:07:08', 'admin', '2020-05-11 22:12:23', 0, 0, '1', 0);
INSERT INTO `sys_permission` VALUES ('1250093691350458369', '1242263502445903874', '币种', '/erp/bas/currency', 'erp/bas/BasCurrencyList', NULL, NULL, 1, NULL, '1', 31.00, 0, NULL, 1, 1, 0, 0, NULL, 'admin', '2020-04-15 00:08:56', 'admin', '2020-04-15 00:10:51', 0, 0, '1', 0);
INSERT INTO `sys_permission` VALUES ('1250094027880439809', '1242263502445903874', '银行账户', '/erp/bas/bankAccount', 'erp/bas/BasBankAccountList', NULL, NULL, 1, NULL, '1', 32.00, 0, NULL, 1, 1, 0, 0, NULL, 'admin', '2020-04-15 00:10:17', 'admin', '2020-05-29 23:10:25', 0, 0, '1', 0);
INSERT INTO `sys_permission` VALUES ('1251026399728828418', '1259846940940980225', '付款核应付', '/erp/finance/payableCheck', 'erp/finance/PayableCheckList', NULL, NULL, 1, NULL, '1', 401.00, 0, NULL, 1, 1, 0, 0, NULL, 'admin', '2020-04-17 13:55:11', 'admin', '2020-05-12 16:10:11', 0, 0, '1', 0);
INSERT INTO `sys_permission` VALUES ('1255530775234150402', '1261213485316517889', '销售出库', '/erp/stock/SalOut', 'erp/stock/SalOutBillList', NULL, NULL, 1, NULL, '1', 2010.00, 0, NULL, 1, 1, 0, 0, NULL, 'admin', '2020-04-30 00:13:58', 'admin', '2020-05-15 16:36:36', 0, 0, '1', 0);
INSERT INTO `sys_permission` VALUES ('1255770241849917442', '1259846724485533697', '销售应收', '/erp/finance/salReceivable', 'erp/finance/SalReceivableList', NULL, NULL, 1, NULL, '1', 102.00, 0, NULL, 1, 1, 0, 0, NULL, 'admin', '2020-04-30 16:05:31', 'admin', '2020-05-12 16:07:40', 0, 0, '1', 0);
INSERT INTO `sys_permission` VALUES ('1255862470869155841', '1259846003342069761', '销售收款', '/erp/finance/salReceipt', 'erp/finance/SalReceiptList', NULL, NULL, 1, NULL, '1', 2.00, 0, NULL, 1, 1, 0, 0, NULL, 'admin', '2020-04-30 22:12:01', 'admin', '2020-05-11 22:05:19', 0, 0, '1', 0);
INSERT INTO `sys_permission` VALUES ('1257326494815248386', '1261213213500452866', '其他入库', '/erp/stock/otherIn', 'erp/stock/OtherInBillList', NULL, NULL, 1, NULL, '1', 1990.00, 0, NULL, 1, 1, 0, 0, NULL, 'admin', '2020-05-04 23:09:31', 'admin', '2020-05-15 16:36:18', 0, 0, '1', 0);
INSERT INTO `sys_permission` VALUES ('1259078064502370305', '1261213485316517889', '其他出库', '/erp/stock/otherOut', 'erp/stock/OtherOutBillList', NULL, NULL, 1, NULL, '1', 2990.00, 0, NULL, 1, 1, 0, 0, NULL, 'admin', '2020-05-09 19:09:38', 'admin', '2020-05-15 16:36:46', 0, 0, '1', 0);
INSERT INTO `sys_permission` VALUES ('1259481545591656449', '1259846724485533697', '收款核应收', '/erp/finance/receivableCheck', 'erp/finance/ReceivableCheckList', NULL, NULL, 1, NULL, '1', 301.00, 0, NULL, 1, 1, 0, 0, NULL, 'admin', '2020-05-10 21:52:55', 'admin', '2020-05-12 16:07:58', 0, 0, '1', 0);
INSERT INTO `sys_permission` VALUES ('1259684566669889538', '1259846003342069761', '其他收款', '/erp/finance/otherReceipt', 'erp/finance/OtherReceiptList', NULL, NULL, 1, NULL, '1', 9.00, 0, NULL, 1, 1, 0, 0, NULL, 'admin', '2020-05-11 11:19:39', 'admin', '2020-05-11 22:12:42', 0, 0, '1', 0);
INSERT INTO `sys_permission` VALUES ('1259684954311659522', '1259846469224386562', '其他付款', '/erp/finance/otherPayment', 'erp/finance/OtherPaymentList', NULL, NULL, 1, NULL, '1', 9.00, 0, NULL, 1, 1, 0, 0, NULL, 'admin', '2020-05-11 11:21:12', 'admin', '2020-05-11 22:13:02', 0, 0, '1', 0);
INSERT INTO `sys_permission` VALUES ('1259752781957730306', '1249544156015607810', '财务统计', '/erp/finance/statistics', 'layouts/RouteView', NULL, NULL, 1, NULL, '1', 800.00, 0, NULL, 1, 0, 0, 0, NULL, 'admin', '2020-05-11 15:50:43', 'admin', '2020-05-27 09:58:24', 0, 0, '1', 0);
INSERT INTO `sys_permission` VALUES ('1259755488869257217', '1259752781957730306', '商品毛利（出库单）', '/online/cgreport/1259783869488844801', 'modules/online/cgreport/auto/OnlCgreportAutoList', NULL, NULL, 1, NULL, '1', 1.00, 0, NULL, 0, 1, 0, 0, NULL, 'admin', '2020-05-11 16:01:28', 'admin', '2020-05-11 18:04:50', 0, 0, '1', 0);
INSERT INTO `sys_permission` VALUES ('1259846003342069761', '1249544156015607810', '收款管理', '/erp/finance/receipt', 'layouts/RouteView', NULL, NULL, 1, NULL, '1', 1.00, 0, NULL, 1, 0, 0, 0, NULL, 'admin', '2020-05-11 22:01:09', 'admin', '2020-05-11 22:01:56', 0, 0, '1', 0);
INSERT INTO `sys_permission` VALUES ('1259846469224386562', '1249544156015607810', '付款管理', '/erp/finance/payment', 'layouts/RouteView', NULL, NULL, 1, NULL, '1', 2.00, 0, NULL, 1, 0, 0, 0, NULL, 'admin', '2020-05-11 22:03:00', 'admin', '2020-05-11 22:05:46', 0, 0, '1', 0);
INSERT INTO `sys_permission` VALUES ('1259846724485533697', '1249544156015607810', '应收管理', '/erp/finance/receivable', 'layouts/RouteView', NULL, NULL, 1, NULL, '1', 3.00, 0, NULL, 1, 0, 0, 0, NULL, 'admin', '2020-05-11 22:04:01', NULL, NULL, 0, 0, '1', 0);
INSERT INTO `sys_permission` VALUES ('1259846940940980225', '1249544156015607810', '应付管理', '/erp/finance/payable', 'layouts/RouteView', NULL, NULL, 1, NULL, '1', 4.00, 0, NULL, 1, 0, 0, 0, NULL, 'admin', '2020-05-11 22:04:52', NULL, NULL, 0, 0, '1', 0);
INSERT INTO `sys_permission` VALUES ('1260049265086492674', '1259846003342069761', '销售预收', '/erp/finance/salPreeceipt', 'erp/finance/SalPrereceiptList', NULL, NULL, 1, NULL, '1', 1.00, 0, NULL, 1, 1, 0, 0, NULL, 'admin', '2020-05-12 11:28:50', NULL, NULL, 0, 0, '1', 0);
INSERT INTO `sys_permission` VALUES ('1260053768900767745', '1259846469224386562', '采购预付', '/erp/finance/purPrepayment', 'erp/finance/PurPrepaymentList', NULL, NULL, 1, NULL, '1', 1.00, 0, NULL, 1, 1, 0, 0, NULL, 'admin', '2020-05-12 11:46:44', NULL, NULL, 0, 0, '1', 0);
INSERT INTO `sys_permission` VALUES ('1260119762952282114', '1259846724485533697', '其他应收', '/erp/finance/otherReceivable', 'erp/finance/OtherReceivableList', NULL, NULL, 1, NULL, '1', 199.00, 0, NULL, 1, 1, 0, 0, NULL, 'admin', '2020-05-12 16:08:58', NULL, NULL, 0, 0, '1', 0);
INSERT INTO `sys_permission` VALUES ('1260120272916733954', '1259846940940980225', '其他应付', '/erp/finance/otherPayabl', 'erp/finance/OtherPayableList', NULL, NULL, 1, NULL, '1', 299.00, 0, NULL, 1, 1, 0, 0, NULL, 'admin', '2020-05-12 16:11:00', NULL, NULL, 0, 0, '1', 0);
INSERT INTO `sys_permission` VALUES ('1260464092879609857', '1261213213500452866', '采购退货出库', '/erp/stock/rubricPurIn', 'erp/stock/RubricPurInBillList', NULL, NULL, 1, NULL, '1', 1011.00, 0, NULL, 1, 1, 0, 0, NULL, 'admin', '2020-05-13 14:57:13', 'admin', '2020-05-15 16:35:45', 0, 0, '1', 0);
INSERT INTO `sys_permission` VALUES ('1261213213500452866', '1244876622988214274', '入库管理', '/erp/stock/in', 'layouts/RouteView', NULL, NULL, 1, NULL, '1', 1.00, 0, NULL, 1, 0, 0, 0, NULL, 'admin', '2020-05-15 16:33:57', NULL, NULL, 0, 0, '1', 0);
INSERT INTO `sys_permission` VALUES ('1261213485316517889', '1244876622988214274', '出库管理', '/erp/stock/out', 'layouts/RouteView', NULL, NULL, 1, NULL, '1', 2.00, 0, NULL, 1, 0, 0, 0, NULL, 'admin', '2020-05-15 16:35:02', NULL, NULL, 0, 0, '1', 0);
INSERT INTO `sys_permission` VALUES ('1261473105690624001', '1261213485316517889', '销售退货入库', '/erp/stock/rubricSalOut', 'erp/stock/RubricSalOutBillList', NULL, NULL, 1, NULL, '1', 2011.00, 0, NULL, 1, 1, 0, 0, NULL, 'admin', '2020-05-16 09:46:40', 'admin', '2020-05-16 09:46:58', 0, 0, '1', 0);
INSERT INTO `sys_permission` VALUES ('1261951277691453442', '1244876622988214274', '库存调拨', '/erp/stock/Move', 'erp/stock/MoveBillList', NULL, NULL, 1, NULL, '1', 3.00, 0, NULL, 1, 1, 0, 0, NULL, 'admin', '2020-05-17 17:26:45', 'admin', '2020-05-17 21:53:33', 0, 0, '1', 0);
INSERT INTO `sys_permission` VALUES ('1262299859608154114', '1244876622988214274', '库存盘点', '/erp/stock/Check', 'erp/stock/CheckBillList', NULL, NULL, 1, NULL, '1', 5.00, 0, NULL, 1, 1, 0, 0, NULL, 'admin', '2020-05-18 16:31:53', 'admin', '2020-05-21 10:34:28', 0, 0, '1', 0);
INSERT INTO `sys_permission` VALUES ('1263131054251114497', '1261213213500452866', '盘盈入库', '/erp/stock/checkIn', 'erp/stock/CheckInBillList', NULL, NULL, 1, NULL, '1', 1020.00, 0, NULL, 1, 1, 0, 0, NULL, 'admin', '2020-05-20 23:34:46', 'admin', '2020-05-20 23:35:41', 0, 0, '1', 0);
INSERT INTO `sys_permission` VALUES ('1263137799941849090', '1261213485316517889', '盘亏出库', '/erp/stock/checkOut', 'erp/stock/CheckOutBillList', NULL, NULL, 1, NULL, '1', 2020.00, 0, NULL, 1, 1, 0, 0, NULL, 'admin', '2020-05-21 00:01:34', NULL, NULL, 0, 0, '1', 0);
INSERT INTO `sys_permission` VALUES ('1263272675325341697', '1261213213500452866', '涨库入库', '/erp/stock/swellIn', 'erp/stock/SwellInBillList', NULL, NULL, 1, NULL, '1', 1910.00, 0, NULL, 1, 1, 0, 0, NULL, 'admin', '2020-05-21 08:57:31', 'admin', '2020-06-02 23:11:40', 0, 0, '1', 0);
INSERT INTO `sys_permission` VALUES ('1263296696360202241', '1244876622988214274', '成本调整', '/erp/stock/changeCost', 'erp/stock/ChangeCostBillList', NULL, NULL, 1, NULL, '1', 4.00, 0, NULL, 1, 1, 0, 0, NULL, 'admin', '2020-05-21 10:32:58', 'admin', '2020-05-21 10:34:39', 0, 0, '1', 0);
INSERT INTO `sys_permission` VALUES ('1263456573379211265', '1249544156015607810', '发票登记', '/erp/finance/invoice', 'layouts/RouteView', NULL, NULL, 1, NULL, '1', 5.00, 0, NULL, 1, 0, 0, 0, NULL, 'admin', '2020-05-21 21:08:16', NULL, NULL, 0, 0, '1', 0);
INSERT INTO `sys_permission` VALUES ('1263457033024598017', '1263456573379211265', '采购发票', '/erp/finance/purInvoice', 'erp/finance/PurInvoiceList', NULL, NULL, 1, NULL, '1', 21.00, 0, NULL, 1, 1, 0, 0, NULL, 'admin', '2020-05-21 21:10:05', 'admin', '2020-05-24 16:33:10', 0, 0, '1', 0);
INSERT INTO `sys_permission` VALUES ('1264105015952703490', '1263456573379211265', '采购发票（红字）', '/erp/finance/rubricPurInvoice', 'erp/finance/RubricPurInvoiceList', NULL, NULL, 1, NULL, '1', 22.00, 0, NULL, 1, 1, 0, 0, NULL, 'admin', '2020-05-23 16:04:56', 'admin', '2020-05-24 16:33:56', 0, 0, '1', 0);
INSERT INTO `sys_permission` VALUES ('1264475682141294594', '1263456573379211265', '销售发票', '/erp/finance/salInvoice', 'erp/finance/SalInvoiceList', NULL, NULL, 1, NULL, '1', 11.00, 0, NULL, 1, 1, 0, 0, NULL, 'admin', '2020-05-24 16:37:50', NULL, NULL, 0, 0, '1', 0);
INSERT INTO `sys_permission` VALUES ('1264476085746585602', '1263456573379211265', '销售发票（红字）', '/erp/finance/rubricSalInvoice', 'erp/finance/RubricSalInvoiceList', NULL, NULL, 1, NULL, '1', 12.00, 0, NULL, 1, 1, 0, 0, NULL, 'admin', '2020-05-24 16:39:26', NULL, NULL, 0, 0, '1', 0);
INSERT INTO `sys_permission` VALUES ('1265462136117207042', '1249544156015607810', '月末结转', '/finer/erp/bas/monthCarryForward', 'erp/bas/BasMonthCarryForward', NULL, NULL, 1, NULL, '1', 100.00, 0, NULL, 1, 1, 0, 0, NULL, 'admin', '2020-05-27 09:57:39', 'admin', '2020-05-27 10:08:04', 0, 0, '1', 1);
INSERT INTO `sys_permission` VALUES ('1266386162661343233', '1242263502445903874', '物料', '/erp/bas/material', 'erp/bas/BasMaterialList', NULL, NULL, 1, NULL, '1', 20.00, 0, NULL, 1, 1, 0, 0, NULL, 'admin', '2020-05-29 23:09:24', 'admin', '2020-05-29 23:09:45', 0, 0, '1', 0);
INSERT INTO `sys_permission` VALUES ('13212d3416eb690c2e1d5033166ff47a', '2e42e3835c2b44ec9f7bc26c146ee531', '失败', '/result/fail', 'result/Error', NULL, NULL, 1, NULL, NULL, 2.00, NULL, NULL, 1, 1, NULL, NULL, NULL, NULL, '2018-12-25 20:34:38', NULL, NULL, 0, 0, NULL, NULL);
INSERT INTO `sys_permission` VALUES ('1367a93f2c410b169faa7abcbad2f77c', '6e73eb3c26099c191bf03852ee1310a1', '基本设置', '/account/settings/BaseSetting', 'account/settings/BaseSetting', 'account-settings-base', NULL, 1, 'BaseSettings', NULL, 1.00, 0, NULL, 1, 1, 0, 1, NULL, NULL, '2018-12-26 18:58:35', 'admin', '2020-05-12 16:41:09', 0, 0, NULL, 0);
INSERT INTO `sys_permission` VALUES ('190c2b43bec6a5f7a4194a85db67d96a', 'd7d6e2e4e2934f2c9385a623fd98c6f3', '角色用户', '/isystem/roleUserList', 'system/RoleUserList', NULL, NULL, 1, NULL, NULL, 2.00, 0, NULL, 1, 1, 0, 0, NULL, 'admin', '2019-04-17 15:13:56', 'admin', '2020-06-03 14:33:10', 0, 0, NULL, 0);
INSERT INTO `sys_permission` VALUES ('1a0811914300741f4e11838ff37a1d3a', '3f915b2769fc80648e92d04e84ca059d', '手机号禁用', NULL, NULL, NULL, NULL, 2, 'user:form:phone', '2', 1.00, 0, NULL, 0, 1, NULL, 0, NULL, 'admin', '2019-05-11 17:19:30', 'admin', '2019-05-11 18:00:22', 0, 0, '1', NULL);
INSERT INTO `sys_permission` VALUES ('200006f0edf145a2b50eacca07585451', 'fb07ca05a3e13674dbf6d3245956da2e', '搜索列表（应用）', '/list/search/application', 'list/TableList', NULL, NULL, 1, NULL, NULL, 1.00, 0, NULL, 1, 1, NULL, 0, NULL, 'admin', '2019-02-12 14:02:51', 'admin', '2019-02-12 14:14:01', 0, 0, NULL, NULL);
INSERT INTO `sys_permission` VALUES ('22d6a3d39a59dd7ea9a30acfa6bfb0a5', 'e41b69c57a941a3bbcce45032fe57605', 'AUTO动态表单', '/online/df/:table/:id', 'modules/online/cgform/auto/OnlineDynamicForm', NULL, NULL, 1, NULL, NULL, 9.00, 0, NULL, 0, 1, NULL, 1, NULL, 'admin', '2019-04-22 15:15:43', 'admin', '2019-04-30 18:18:26', 0, 0, NULL, NULL);
INSERT INTO `sys_permission` VALUES ('265de841c58907954b8877fb85212622', '2a470fc0c3954d9dbb61de6d80846549', '图片拖拽排序', '/jeecg/imgDragSort', 'jeecg/ImgDragSort', NULL, NULL, 1, NULL, NULL, 4.00, 0, NULL, 1, 1, NULL, 0, NULL, 'admin', '2019-04-25 10:43:08', 'admin', '2019-04-25 10:46:26', 0, 0, NULL, NULL);
INSERT INTO `sys_permission` VALUES ('277bfabef7d76e89b33062b16a9a5020', 'e3c13679c73a4f829bcff2aba8fd68b1', '基础表单', '/form/base-form', 'form/BasicForm', NULL, NULL, 1, NULL, NULL, 1.00, 0, NULL, 1, 0, NULL, 0, NULL, NULL, '2018-12-25 20:34:38', 'admin', '2019-02-26 17:02:08', 0, 0, NULL, NULL);
INSERT INTO `sys_permission` VALUES ('2a470fc0c3954d9dbb61de6d80846549', '1240582498747314177', '常见案例', '/jeecg', 'layouts/RouteView', NULL, NULL, 1, NULL, NULL, 7.00, 0, 'qrcode', 1, 0, 0, 0, NULL, NULL, '2018-12-25 20:34:38', 'admin', '2020-03-19 18:19:01', 0, 0, NULL, 0);
INSERT INTO `sys_permission` VALUES ('2aeddae571695cd6380f6d6d334d6e7d', 'f0675b52d89100ee88472b6800754a08', '布局统计报表', '/report/ArchivesStatisticst', 'jeecg/report/ArchivesStatisticst', NULL, NULL, 1, NULL, NULL, 1.00, 0, NULL, 1, 1, NULL, 0, NULL, 'admin', '2019-04-03 18:32:48', NULL, NULL, 0, 0, NULL, NULL);
INSERT INTO `sys_permission` VALUES ('2dbbafa22cda07fa5d169d741b81fe12', '08e6b9dc3c04489c8e1ff2ce6f105aa4', '在线文档', '{{ window._CONFIG[\'domianURL\'] }}/doc.html', 'layouts/IframePageView', NULL, NULL, 1, NULL, NULL, 3.00, 0, NULL, 1, 1, NULL, 0, NULL, 'admin', '2019-01-30 10:00:01', 'admin', '2019-03-23 19:44:43', 0, 0, NULL, NULL);
INSERT INTO `sys_permission` VALUES ('2e42e3835c2b44ec9f7bc26c146ee531', '1240582498747314177', '结果页', '/result', 'layouts/PageView', NULL, NULL, 1, NULL, NULL, 8.00, 0, 'check-circle-o', 1, 0, 0, 0, NULL, NULL, '2018-12-25 20:34:38', 'admin', '2020-03-19 18:19:20', 0, 0, NULL, 0);
INSERT INTO `sys_permission` VALUES ('339329ed54cf255e1f9392e84f136901', '2a470fc0c3954d9dbb61de6d80846549', 'helloworld', '/jeecg/helloworld', 'jeecg/helloworld', NULL, NULL, 1, NULL, NULL, 4.00, 0, NULL, 1, 1, NULL, 0, NULL, NULL, '2018-12-25 20:34:38', 'admin', '2019-02-15 16:24:56', 0, 0, NULL, NULL);
INSERT INTO `sys_permission` VALUES ('3f915b2769fc80648e92d04e84ca059d', 'd7d6e2e4e2934f2c9385a623fd98c6f3', '用户管理', '/isystem/user', 'system/UserList', NULL, NULL, 1, NULL, NULL, 1.10, 0, NULL, 1, 0, 0, 0, NULL, NULL, '2018-12-25 20:34:38', 'admin', '2019-12-25 09:36:24', 0, 0, NULL, 0);
INSERT INTO `sys_permission` VALUES ('3fac0d3c9cd40fa53ab70d4c583821f8', '2a470fc0c3954d9dbb61de6d80846549', '分屏', '/jeecg/splitPanel', 'jeecg/SplitPanel', NULL, NULL, 1, NULL, NULL, 6.00, 0, NULL, 1, 1, NULL, 0, NULL, 'admin', '2019-04-25 16:27:06', NULL, NULL, 0, 0, NULL, NULL);
INSERT INTO `sys_permission` VALUES ('4148ec82b6acd69f470bea75fe41c357', '2a470fc0c3954d9dbb61de6d80846549', '单表模型示例', '/jeecg/jeecgDemoList', 'jeecg/JeecgDemoList', 'DemoList', NULL, 1, NULL, NULL, 1.00, 0, NULL, 1, 1, NULL, 0, NULL, NULL, '2018-12-28 15:57:30', 'admin', '2019-02-15 16:24:37', 0, 0, NULL, NULL);
INSERT INTO `sys_permission` VALUES ('418964ba087b90a84897b62474496b93', '540a2936940846cb98114ffb0d145cb8', '查询表格', '/list/query-list', 'list/TableList', NULL, NULL, 1, NULL, NULL, 1.00, NULL, NULL, 1, 1, NULL, NULL, NULL, NULL, '2018-12-25 20:34:38', NULL, NULL, 0, 0, NULL, NULL);
INSERT INTO `sys_permission` VALUES ('4356a1a67b564f0988a484f5531fd4d9', '2a470fc0c3954d9dbb61de6d80846549', '内嵌Table', '/jeecg/TableExpandeSub', 'jeecg/TableExpandeSub', NULL, NULL, 1, NULL, NULL, 1.00, 0, NULL, 1, 1, NULL, 0, NULL, 'admin', '2019-04-04 22:48:13', NULL, NULL, 0, 0, NULL, NULL);
INSERT INTO `sys_permission` VALUES ('45c966826eeff4c99b8f8ebfe74511fc', 'd7d6e2e4e2934f2c9385a623fd98c6f3', '部门管理', '/isystem/depart', 'system/DepartList', NULL, NULL, 1, NULL, NULL, 1.40, 0, NULL, 1, 1, 0, 0, NULL, 'admin', '2019-01-29 18:47:40', 'admin', '2019-12-25 09:36:47', 0, 0, NULL, 0);
INSERT INTO `sys_permission` VALUES ('4875ebe289344e14844d8e3ea1edd73f', '1240582498747314177', '详情页', '/profile', 'layouts/RouteView', NULL, NULL, 1, NULL, NULL, 8.00, 0, 'profile', 1, 0, 0, 0, NULL, NULL, '2018-12-25 20:34:38', 'admin', '2020-03-19 18:19:38', 0, 0, NULL, 0);
INSERT INTO `sys_permission` VALUES ('4f66409ef3bbd69c1d80469d6e2a885e', '6e73eb3c26099c191bf03852ee1310a1', '账户绑定', '/account/settings/binding', 'account/settings/Binding', NULL, NULL, 1, 'BindingSettings', NULL, NULL, NULL, NULL, 1, 1, NULL, NULL, NULL, NULL, '2018-12-26 19:01:20', NULL, NULL, 0, 0, NULL, NULL);
INSERT INTO `sys_permission` VALUES ('4f84f9400e5e92c95f05b554724c2b58', '540a2936940846cb98114ffb0d145cb8', '角色列表', '/list/role-list', 'list/RoleList', NULL, NULL, 1, NULL, NULL, 4.00, NULL, NULL, 1, 1, NULL, NULL, NULL, NULL, '2018-12-25 20:34:38', NULL, NULL, 0, 0, NULL, NULL);
INSERT INTO `sys_permission` VALUES ('53a9230444d33de28aa11cc108fb1dba', '5c8042bd6c601270b2bbd9b20bccc68b', '我的消息', '/isps/userAnnouncement', 'system/UserAnnouncementList', NULL, NULL, 1, NULL, NULL, 3.00, 0, NULL, 1, 1, 0, 1, NULL, 'admin', '2019-04-19 10:16:00', 'admin', '2020-06-03 14:23:00', 0, 0, NULL, 0);
INSERT INTO `sys_permission` VALUES ('54097c6a3cf50fad0793a34beff1efdf', 'e41b69c57a941a3bbcce45032fe57605', 'AUTO在线表单', '/online/cgformList/:code', 'modules/online/cgform/auto/OnlCgformAutoList', NULL, NULL, 1, NULL, NULL, 9.00, 0, NULL, 1, 1, NULL, 1, NULL, 'admin', '2019-03-19 16:03:06', 'admin', '2019-04-30 18:19:03', 0, 0, NULL, NULL);
INSERT INTO `sys_permission` VALUES ('540a2936940846cb98114ffb0d145cb8', '1240582498747314177', '列表页', '/list', 'layouts/PageView', NULL, '/list/query-list', 1, NULL, NULL, 9.00, 0, 'table', 1, 0, 0, 0, NULL, NULL, '2018-12-25 20:34:38', 'admin', '2020-03-19 18:20:13', 0, 0, NULL, 0);
INSERT INTO `sys_permission` VALUES ('54dd5457a3190740005c1bfec55b1c34', 'd7d6e2e4e2934f2c9385a623fd98c6f3', '菜单管理', '/isystem/permission', 'system/PermissionList', NULL, NULL, 1, NULL, NULL, 1.30, 0, NULL, 1, 1, 0, 0, NULL, NULL, '2018-12-25 20:34:38', 'admin', '2019-12-25 09:36:39', 0, 0, NULL, 0);
INSERT INTO `sys_permission` VALUES ('58857ff846e61794c69208e9d3a85466', '08e6b9dc3c04489c8e1ff2ce6f105aa4', '日志管理', '/isystem/log', 'system/LogList', NULL, NULL, 1, NULL, NULL, 1.00, 0, '', 1, 1, NULL, 0, NULL, NULL, '2018-12-26 10:11:18', 'admin', '2019-04-02 11:38:17', 0, 0, NULL, NULL);
INSERT INTO `sys_permission` VALUES ('58b9204feaf07e47284ddb36cd2d8468', '2a470fc0c3954d9dbb61de6d80846549', '图片翻页', '/jeecg/imgTurnPage', 'jeecg/ImgTurnPage', NULL, NULL, 1, NULL, NULL, 4.00, 0, NULL, 1, 1, NULL, 0, NULL, 'admin', '2019-04-25 11:36:42', NULL, NULL, 0, 0, NULL, NULL);
INSERT INTO `sys_permission` VALUES ('5c2f42277948043026b7a14692456828', 'd7d6e2e4e2934f2c9385a623fd98c6f3', '我的部门', '/isystem/departUserList', 'system/DepartUserList', NULL, NULL, 1, NULL, NULL, 2.00, 0, NULL, 1, 1, 0, 0, NULL, 'admin', '2019-04-17 15:12:24', 'admin', '2019-12-25 09:35:26', 0, 0, NULL, 0);
INSERT INTO `sys_permission` VALUES ('5c8042bd6c601270b2bbd9b20bccc68b', '', '消息中心', '/message', 'layouts/RouteView', NULL, NULL, 0, NULL, NULL, 56.00, 0, 'message', 1, 0, 0, 0, NULL, 'admin', '2019-04-09 11:05:04', 'admin', '2020-03-25 10:23:07', 0, 0, NULL, 0);
INSERT INTO `sys_permission` VALUES ('6531cf3421b1265aeeeabaab5e176e6d', 'e3c13679c73a4f829bcff2aba8fd68b1', '分步表单', '/form/step-form', 'form/stepForm/StepForm', NULL, NULL, 1, NULL, NULL, 2.00, NULL, NULL, 1, 1, NULL, NULL, NULL, NULL, '2018-12-25 20:34:38', NULL, NULL, 0, 0, NULL, NULL);
INSERT INTO `sys_permission` VALUES ('655563cd64b75dcf52ef7bcdd4836953', '2a470fc0c3954d9dbb61de6d80846549', '图片预览', '/jeecg/ImagPreview', 'jeecg/ImagPreview', NULL, NULL, 1, NULL, NULL, 1.00, 0, NULL, 1, 1, NULL, 0, NULL, 'admin', '2019-04-17 11:18:45', NULL, NULL, 0, 0, NULL, NULL);
INSERT INTO `sys_permission` VALUES ('65a8f489f25a345836b7f44b1181197a', 'c65321e57b7949b7a975313220de0422', '403', '/exception/403', 'exception/403', NULL, NULL, 1, NULL, NULL, 1.00, NULL, NULL, 1, 1, NULL, NULL, NULL, NULL, '2018-12-25 20:34:38', NULL, NULL, 0, 0, NULL, NULL);
INSERT INTO `sys_permission` VALUES ('6ad53fd1b220989a8b71ff482d683a5a', '2a470fc0c3954d9dbb61de6d80846549', '一对多Tab示例', '/jeecg/tablist/JeecgOrderDMainList', 'jeecg/tablist/JeecgOrderDMainList', NULL, NULL, 1, NULL, NULL, 2.00, 0, NULL, 1, 1, NULL, 0, NULL, 'admin', '2019-02-20 14:45:09', 'admin', '2019-02-21 16:26:21', 0, 0, NULL, NULL);
INSERT INTO `sys_permission` VALUES ('6e73eb3c26099c191bf03852ee1310a1', '717f6bee46f44a3897eca9abd6e2ec44', '个人设置', '/account/settings/Index', 'account/settings/Index', NULL, NULL, 1, NULL, NULL, 2.00, 1, NULL, 1, 0, NULL, 0, NULL, NULL, '2018-12-25 20:34:38', 'admin', '2019-04-19 09:41:05', 0, 0, NULL, NULL);
INSERT INTO `sys_permission` VALUES ('700b7f95165c46cc7a78bf227aa8fed3', '08e6b9dc3c04489c8e1ff2ce6f105aa4', '性能监控', '/monitor', 'layouts/RouteView', NULL, NULL, 1, NULL, NULL, 0.00, 0, NULL, 1, 0, NULL, 0, NULL, 'admin', '2019-04-02 11:34:34', 'admin', '2019-05-05 17:49:47', 0, 0, NULL, NULL);
INSERT INTO `sys_permission` VALUES ('717f6bee46f44a3897eca9abd6e2ec44', '', '个人页', '/account', 'layouts/RouteView', NULL, NULL, 0, NULL, NULL, 59.00, 0, 'user', 1, 0, 0, 1, NULL, NULL, '2018-12-25 20:34:38', 'admin', '2020-06-03 14:07:09', 0, 0, NULL, 0);
INSERT INTO `sys_permission` VALUES ('73678f9daa45ed17a3674131b03432fb', '540a2936940846cb98114ffb0d145cb8', '权限列表', '/list/permission-list', 'list/PermissionList', NULL, NULL, 1, NULL, NULL, 5.00, NULL, NULL, 1, 1, NULL, NULL, NULL, NULL, '2018-12-25 20:34:38', NULL, NULL, 0, 0, NULL, NULL);
INSERT INTO `sys_permission` VALUES ('7593c9e3523a17bca83b8d7fe8a34e58', '3f915b2769fc80648e92d04e84ca059d', '添加用户按钮', '', NULL, NULL, NULL, 2, 'user:add', '1', 1.00, 0, NULL, 1, 1, NULL, 0, NULL, 'admin', '2019-03-16 11:20:33', 'admin', '2019-05-17 18:31:25', 0, 0, '1', NULL);
INSERT INTO `sys_permission` VALUES ('7960961b0063228937da5fa8dd73d371', '2a470fc0c3954d9dbb61de6d80846549', 'JEditableTable示例', '/jeecg/JEditableTable', 'jeecg/JeecgEditableTableExample', NULL, NULL, 1, NULL, NULL, 2.10, 0, NULL, 1, 1, 0, 0, NULL, 'admin', '2019-03-22 15:22:18', 'admin', '2019-12-25 09:48:16', 0, 0, NULL, 0);
INSERT INTO `sys_permission` VALUES ('7ac9eb9ccbde2f7a033cd4944272bf1e', '540a2936940846cb98114ffb0d145cb8', '卡片列表', '/list/card', 'list/CardList', NULL, NULL, 1, NULL, NULL, 7.00, NULL, NULL, 1, 1, NULL, NULL, NULL, NULL, '2018-12-25 20:34:38', NULL, NULL, 0, 0, NULL, NULL);
INSERT INTO `sys_permission` VALUES ('841057b8a1bef8f6b4b20f9a618a7fa6', '08e6b9dc3c04489c8e1ff2ce6f105aa4', '数据日志', '/sys/dataLog-list', 'system/DataLogList', NULL, NULL, 1, NULL, NULL, 1.00, 0, NULL, 1, 1, NULL, 0, NULL, 'admin', '2019-03-11 19:26:49', 'admin', '2019-03-12 11:40:47', 0, 0, NULL, NULL);
INSERT INTO `sys_permission` VALUES ('882a73768cfd7f78f3a37584f7299656', '6e73eb3c26099c191bf03852ee1310a1', '个性化设置', '/account/settings/custom', 'account/settings/Custom', NULL, NULL, 1, 'CustomSettings', NULL, NULL, NULL, NULL, 1, 1, NULL, NULL, NULL, NULL, '2018-12-26 19:00:46', NULL, '2018-12-26 21:13:25', 0, 0, NULL, NULL);
INSERT INTO `sys_permission` VALUES ('8b3bff2eee6f1939147f5c68292a1642', '700b7f95165c46cc7a78bf227aa8fed3', '服务器信息', '/monitor/SystemInfo', 'modules/monitor/SystemInfo', NULL, NULL, 1, NULL, NULL, 4.00, 0, NULL, 1, 1, NULL, 0, NULL, 'admin', '2019-04-02 11:39:19', 'admin', '2019-04-02 15:40:02', 0, 0, NULL, NULL);
INSERT INTO `sys_permission` VALUES ('8d1ebd663688965f1fd86a2f0ead3416', '700b7f95165c46cc7a78bf227aa8fed3', 'Redis监控', '/monitor/redis/info', 'modules/monitor/RedisInfo', NULL, NULL, 1, NULL, NULL, 1.00, 0, NULL, 1, 1, NULL, 0, NULL, 'admin', '2019-04-02 13:11:33', 'admin', '2019-05-07 15:18:54', 0, 0, NULL, NULL);
INSERT INTO `sys_permission` VALUES ('8d4683aacaa997ab86b966b464360338', 'e41b69c57a941a3bbcce45032fe57605', 'Online表单开发', '/online/cgform', 'modules/online/cgform/OnlCgformHeadList', NULL, NULL, 1, NULL, NULL, 1.00, 0, NULL, 1, 0, NULL, 0, NULL, 'admin', '2019-03-12 15:48:14', 'admin', '2019-06-11 14:19:17', 0, 0, NULL, NULL);
INSERT INTO `sys_permission` VALUES ('8fb8172747a78756c11916216b8b8066', '717f6bee46f44a3897eca9abd6e2ec44', '工作台', '/dashboard/workplace', 'dashboard/Workplace', NULL, NULL, 1, NULL, NULL, 3.00, 0, NULL, 1, 1, NULL, 0, NULL, NULL, '2018-12-25 20:34:38', 'admin', '2019-04-02 11:45:02', 0, 0, NULL, NULL);
INSERT INTO `sys_permission` VALUES ('944abf0a8fc22fe1f1154a389a574154', '5c8042bd6c601270b2bbd9b20bccc68b', '消息管理', '/modules/message/sysMessageList', 'modules/message/SysMessageList', NULL, NULL, 1, NULL, NULL, 1.00, 0, NULL, 1, 1, NULL, 0, NULL, 'admin', '2019-04-09 11:27:53', 'admin', '2019-04-09 19:31:23', 0, 0, NULL, NULL);
INSERT INTO `sys_permission` VALUES ('9502685863ab87f0ad1134142788a385', '', '首页', '/dashboard/analysis', 'dashboard/Analysis', NULL, NULL, 0, NULL, NULL, 0.00, 0, 'home', 1, 1, 0, 0, NULL, NULL, '2018-12-25 20:34:38', 'admin', '2020-06-03 11:57:27', 0, 0, NULL, 0);
INSERT INTO `sys_permission` VALUES ('97c8629abc7848eccdb6d77c24bb3ebb', '700b7f95165c46cc7a78bf227aa8fed3', '磁盘监控', '/monitor/Disk', 'modules/monitor/DiskMonitoring', NULL, NULL, 1, NULL, NULL, 6.00, 0, NULL, 1, 1, NULL, 0, NULL, 'admin', '2019-04-25 14:30:06', 'admin', '2019-05-05 14:37:14', 0, 0, NULL, NULL);
INSERT INTO `sys_permission` VALUES ('9a90363f216a6a08f32eecb3f0bf12a3', '2a470fc0c3954d9dbb61de6d80846549', '自定义组件', '/jeecg/SelectDemo', 'jeecg/SelectDemo', NULL, NULL, 1, NULL, NULL, 0.00, 0, NULL, 1, 1, 0, 0, NULL, 'admin', '2019-03-19 11:19:05', 'admin', '2019-12-25 09:47:04', 0, 0, NULL, 0);
INSERT INTO `sys_permission` VALUES ('9cb91b8851db0cf7b19d7ecc2a8193dd', '1939e035e803a99ceecb6f5563570fb2', '我的任务表单', '/modules/bpm/task/form/FormModule', 'modules/bpm/task/form/FormModule', NULL, NULL, 1, NULL, NULL, 1.00, 0, NULL, 1, 1, NULL, 0, NULL, 'admin', '2019-03-08 16:49:05', 'admin', '2019-03-08 18:37:56', 0, 0, NULL, NULL);
INSERT INTO `sys_permission` VALUES ('9fe26464838de2ea5e90f2367e35efa0', 'e41b69c57a941a3bbcce45032fe57605', 'AUTO在线报表', '/online/cgreport/:code', 'modules/online/cgreport/auto/OnlCgreportAutoList', 'onlineAutoList', NULL, 1, NULL, NULL, 9.00, 0, NULL, 1, 1, 0, 1, NULL, 'admin', '2019-03-12 11:06:48', 'admin', '2020-03-19 11:34:09', 0, 0, NULL, 0);
INSERT INTO `sys_permission` VALUES ('a400e4f4d54f79bf5ce160ae432231af', '2a470fc0c3954d9dbb61de6d80846549', '百度', 'http://www.baidu.com', 'layouts/IframePageView', NULL, NULL, 1, NULL, NULL, 4.00, 0, NULL, 1, 1, NULL, 0, NULL, 'admin', '2019-01-29 19:44:06', 'admin', '2019-02-15 16:25:02', 0, 0, NULL, NULL);
INSERT INTO `sys_permission` VALUES ('ae4fed059f67086fd52a73d913cf473d', '540a2936940846cb98114ffb0d145cb8', '内联编辑表格', '/list/edit-table', 'list/TableInnerEditList', NULL, NULL, 1, NULL, NULL, 2.00, NULL, NULL, 1, 1, NULL, NULL, NULL, NULL, '2018-12-25 20:34:38', NULL, NULL, 0, 0, NULL, NULL);
INSERT INTO `sys_permission` VALUES ('aedbf679b5773c1f25e9f7b10111da73', '08e6b9dc3c04489c8e1ff2ce6f105aa4', 'SQL监控', '{{ window._CONFIG[\'domianURL\'] }}/druid/', 'layouts/IframePageView', NULL, NULL, 1, NULL, NULL, 1.00, 0, NULL, 1, 1, NULL, 0, NULL, 'admin', '2019-01-30 09:43:22', 'admin', '2019-03-23 19:00:46', 0, 0, NULL, NULL);
INSERT INTO `sys_permission` VALUES ('b1cb0a3fedf7ed0e4653cb5a229837ee', '08e6b9dc3c04489c8e1ff2ce6f105aa4', '定时任务', '/isystem/QuartzJobList', 'system/QuartzJobList', NULL, NULL, 1, NULL, NULL, 3.00, 0, NULL, 1, 1, NULL, 0, NULL, NULL, '2019-01-03 09:38:52', 'admin', '2019-04-02 10:24:13', 0, 0, NULL, NULL);
INSERT INTO `sys_permission` VALUES ('b3c824fc22bd953e2eb16ae6914ac8f9', '4875ebe289344e14844d8e3ea1edd73f', '高级详情页', '/profile/advanced', 'profile/advanced/Advanced', NULL, NULL, 1, NULL, NULL, 2.00, NULL, NULL, 1, 1, NULL, NULL, NULL, NULL, '2018-12-25 20:34:38', NULL, NULL, 0, 0, NULL, NULL);
INSERT INTO `sys_permission` VALUES ('b4dfc7d5dd9e8d5b6dd6d4579b1aa559', 'c65321e57b7949b7a975313220de0422', '500', '/exception/500', 'exception/500', NULL, NULL, 1, NULL, NULL, 3.00, NULL, NULL, 1, 1, NULL, NULL, NULL, NULL, '2018-12-25 20:34:38', NULL, NULL, 0, 0, NULL, NULL);
INSERT INTO `sys_permission` VALUES ('b6bcee2ccc854052d3cc3e9c96d90197', '71102b3b87fb07e5527bbd2c530dd90a', '加班申请', '/modules/extbpm/joa/JoaOvertimeList', 'modules/extbpm/joa/JoaOvertimeList', NULL, NULL, 1, NULL, NULL, 1.00, 0, NULL, 1, 1, NULL, 0, NULL, 'admin', '2019-04-03 15:33:10', 'admin', '2019-04-03 15:34:48', 0, 0, NULL, NULL);
INSERT INTO `sys_permission` VALUES ('c431130c0bc0ec71b0a5be37747bb36a', '2a470fc0c3954d9dbb61de6d80846549', '一对多JEditable', '/jeecg/JeecgOrderMainListForJEditableTable', 'jeecg/JeecgOrderMainListForJEditableTable', NULL, NULL, 1, NULL, NULL, 3.00, 0, NULL, 1, 1, NULL, 0, NULL, 'admin', '2019-03-29 10:51:59', 'admin', '2019-04-04 20:09:39', 0, 0, NULL, NULL);
INSERT INTO `sys_permission` VALUES ('c65321e57b7949b7a975313220de0422', '1240582498747314177', '异常页', '/exception', 'layouts/RouteView', NULL, NULL, 1, NULL, NULL, 8.00, 0, 'warning', 1, 0, 0, 0, NULL, NULL, '2018-12-25 20:34:38', 'admin', '2020-03-19 18:19:56', 0, 0, NULL, 0);
INSERT INTO `sys_permission` VALUES ('c6cf95444d80435eb37b2f9db3971ae6', '2a470fc0c3954d9dbb61de6d80846549', '数据回执模拟', '/jeecg/InterfaceTest', 'jeecg/InterfaceTest', NULL, NULL, 1, NULL, NULL, 6.00, 0, NULL, 1, 1, NULL, 0, NULL, 'admin', '2019-02-19 16:02:23', 'admin', '2019-02-21 16:25:45', 0, 0, NULL, NULL);
INSERT INTO `sys_permission` VALUES ('cc50656cf9ca528e6f2150eba4714ad2', '4875ebe289344e14844d8e3ea1edd73f', '基础详情页', '/profile/basic', 'profile/basic/Index', NULL, NULL, 1, NULL, NULL, 1.00, NULL, NULL, 1, 1, NULL, NULL, NULL, NULL, '2018-12-25 20:34:38', NULL, NULL, 0, 0, NULL, NULL);
INSERT INTO `sys_permission` VALUES ('d07a2c87a451434c99ab06296727ec4f', '700b7f95165c46cc7a78bf227aa8fed3', 'JVM信息', '/monitor/JvmInfo', 'modules/monitor/JvmInfo', NULL, NULL, 1, NULL, NULL, 4.00, 0, NULL, 1, 1, NULL, 0, NULL, 'admin', '2019-04-01 23:07:48', 'admin', '2019-04-02 11:37:16', 0, 0, NULL, NULL);
INSERT INTO `sys_permission` VALUES ('d2bbf9ebca5a8fa2e227af97d2da7548', 'c65321e57b7949b7a975313220de0422', '404', '/exception/404', 'exception/404', NULL, NULL, 1, NULL, NULL, 2.00, NULL, NULL, 1, 1, NULL, NULL, NULL, NULL, '2018-12-25 20:34:38', NULL, NULL, 0, 0, NULL, NULL);
INSERT INTO `sys_permission` VALUES ('d7d6e2e4e2934f2c9385a623fd98c6f3', '', '系统管理', '/isystem', 'layouts/RouteView', NULL, NULL, 0, NULL, NULL, 54.00, 0, 'setting', 1, 0, 0, 0, NULL, NULL, '2018-12-25 20:34:38', 'admin', '2020-03-25 10:23:16', 0, 0, NULL, 0);
INSERT INTO `sys_permission` VALUES ('d86f58e7ab516d3bc6bfb1fe10585f97', '717f6bee46f44a3897eca9abd6e2ec44', '个人中心', '/account/center', 'account/center/Index', NULL, NULL, 1, NULL, NULL, 1.00, NULL, NULL, 1, 1, NULL, NULL, NULL, NULL, '2018-12-25 20:34:38', NULL, NULL, 0, 0, NULL, NULL);
INSERT INTO `sys_permission` VALUES ('de13e0f6328c069748de7399fcc1dbbd', 'fb07ca05a3e13674dbf6d3245956da2e', '搜索列表（项目）', '/list/search/project', 'list/TableList', NULL, NULL, 1, NULL, NULL, 1.00, 0, NULL, 1, 1, NULL, 0, NULL, 'admin', '2019-02-12 14:01:40', 'admin', '2019-02-12 14:14:18', 0, 0, NULL, NULL);
INSERT INTO `sys_permission` VALUES ('e08cb190ef230d5d4f03824198773950', 'd7d6e2e4e2934f2c9385a623fd98c6f3', '系统通告', '/isystem/annountCement', 'system/SysAnnouncementList', NULL, NULL, 1, 'annountCement', NULL, 6.00, NULL, '', 1, 1, NULL, NULL, NULL, NULL, '2019-01-02 17:23:01', NULL, '2019-01-02 17:31:23', 0, 0, NULL, NULL);
INSERT INTO `sys_permission` VALUES ('e1979bb53e9ea51cecc74d86fd9d2f64', '2a470fc0c3954d9dbb61de6d80846549', 'PDF预览', '/jeecg/jeecgPdfView', 'jeecg/JeecgPdfView', NULL, NULL, 1, NULL, NULL, 3.00, 0, NULL, 1, 1, NULL, 0, NULL, 'admin', '2019-04-25 10:39:35', NULL, NULL, 0, 0, NULL, NULL);
INSERT INTO `sys_permission` VALUES ('e3c13679c73a4f829bcff2aba8fd68b1', '1240582498747314177', '表单页', '/form', 'layouts/PageView', NULL, NULL, 1, NULL, NULL, 9.00, 0, 'form', 1, 0, 0, 0, NULL, NULL, '2018-12-25 20:34:38', 'admin', '2020-03-19 18:20:40', 0, 0, NULL, 0);
INSERT INTO `sys_permission` VALUES ('e41b69c57a941a3bbcce45032fe57605', '', '在线开发', '/online', 'layouts/RouteView', NULL, NULL, 0, NULL, NULL, 99.00, 0, 'cloud', 1, 0, 0, 0, NULL, 'admin', '2019-03-08 10:43:10', 'admin', '2020-03-20 15:18:15', 0, 0, NULL, 0);
INSERT INTO `sys_permission` VALUES ('e5973686ed495c379d829ea8b2881fc6', 'e3c13679c73a4f829bcff2aba8fd68b1', '高级表单', '/form/advanced-form', 'form/advancedForm/AdvancedForm', NULL, NULL, 1, NULL, NULL, 3.00, NULL, NULL, 1, 1, NULL, NULL, NULL, NULL, '2018-12-25 20:34:38', NULL, NULL, 0, 0, NULL, NULL);
INSERT INTO `sys_permission` VALUES ('e6bfd1fcabfd7942fdd05f076d1dad38', '2a470fc0c3954d9dbb61de6d80846549', '打印测试', '/jeecg/PrintDemo', 'jeecg/PrintDemo', NULL, NULL, 1, NULL, NULL, 3.00, 0, NULL, 1, 1, NULL, 0, NULL, 'admin', '2019-02-19 15:58:48', 'admin', '2019-05-07 20:14:39', 0, 0, NULL, NULL);
INSERT INTO `sys_permission` VALUES ('e8af452d8948ea49d37c934f5100ae6a', 'd7d6e2e4e2934f2c9385a623fd98c6f3', '角色管理', '/isystem/role', 'system/RoleList', NULL, NULL, 1, NULL, NULL, 1.20, 0, NULL, 1, 1, 0, 0, NULL, NULL, '2018-12-25 20:34:38', 'admin', '2020-06-03 14:29:12', 0, 0, NULL, 0);
INSERT INTO `sys_permission` VALUES ('ebb9d82ea16ad864071158e0c449d186', 'd7d6e2e4e2934f2c9385a623fd98c6f3', '分类字典', '/isys/category', 'system/SysCategoryList', NULL, NULL, 1, NULL, '1', 5.00, 0, NULL, 1, 1, NULL, 0, NULL, 'admin', '2019-05-29 18:48:07', 'admin', '2019-05-29 18:48:27', 0, 0, '1', NULL);
INSERT INTO `sys_permission` VALUES ('ec8d607d0156e198b11853760319c646', '6e73eb3c26099c191bf03852ee1310a1', '安全设置', '/account/settings/security', 'account/settings/Security', NULL, NULL, 1, 'SecuritySettings', NULL, NULL, NULL, NULL, 1, 1, NULL, NULL, NULL, NULL, '2018-12-26 18:59:52', NULL, NULL, 0, 0, NULL, NULL);
INSERT INTO `sys_permission` VALUES ('f0675b52d89100ee88472b6800754a08', '1240582498747314177', '统计报表', '/report', 'layouts/RouteView', NULL, NULL, 1, NULL, NULL, 1.00, 0, 'bar-chart', 1, 0, 0, 0, NULL, 'admin', '2019-04-03 18:32:02', 'admin', '2020-03-19 18:18:09', 0, 0, NULL, 0);
INSERT INTO `sys_permission` VALUES ('f1cb187abf927c88b89470d08615f5ac', 'd7d6e2e4e2934f2c9385a623fd98c6f3', '数据字典', '/isystem/dict', 'system/DictList', NULL, NULL, 1, NULL, NULL, 2.00, 0, NULL, 1, 1, 0, 0, NULL, NULL, '2018-12-28 13:54:43', 'admin', '2019-12-25 09:35:44', 0, 0, NULL, 0);
INSERT INTO `sys_permission` VALUES ('f23d9bfff4d9aa6b68569ba2cff38415', '540a2936940846cb98114ffb0d145cb8', '标准列表', '/list/basic-list', 'list/StandardList', NULL, NULL, 1, NULL, NULL, 6.00, NULL, NULL, 1, 1, NULL, NULL, NULL, NULL, '2018-12-25 20:34:38', NULL, NULL, 0, 0, NULL, NULL);
INSERT INTO `sys_permission` VALUES ('f2849d3814fc97993bfc519ae6bbf049', 'e41b69c57a941a3bbcce45032fe57605', 'AUTO复制表单', '/online/copyform/:code', 'modules/online/cgform/OnlCgformCopyList', NULL, NULL, 1, NULL, '1', 1.00, 0, NULL, 1, 1, 0, 1, NULL, 'admin', '2019-08-29 16:05:37', NULL, NULL, 0, 0, '1', NULL);
INSERT INTO `sys_permission` VALUES ('f780d0d3083d849ccbdb1b1baee4911d', '5c8042bd6c601270b2bbd9b20bccc68b', '模板管理', '/modules/message/sysMessageTemplateList', 'modules/message/SysMessageTemplateList', NULL, NULL, 1, NULL, NULL, 1.00, 0, NULL, 1, 1, NULL, 0, NULL, 'admin', '2019-04-09 11:50:31', 'admin', '2019-04-12 10:16:34', 0, 0, NULL, NULL);
INSERT INTO `sys_permission` VALUES ('fb07ca05a3e13674dbf6d3245956da2e', '540a2936940846cb98114ffb0d145cb8', '搜索列表', '/list/search', 'list/search/SearchLayout', NULL, '/list/search/article', 1, NULL, NULL, 8.00, 0, NULL, 1, 0, NULL, 0, NULL, NULL, '2018-12-25 20:34:38', 'admin', '2019-02-12 15:09:13', 0, 0, NULL, NULL);
INSERT INTO `sys_permission` VALUES ('fb367426764077dcf94640c843733985', '2a470fc0c3954d9dbb61de6d80846549', '一对多示例', '/jeecg/JeecgOrderMainList', 'jeecg/JeecgOrderMainList', NULL, NULL, 1, NULL, NULL, 2.00, 0, NULL, 1, 1, NULL, 0, NULL, 'admin', '2019-02-15 16:24:11', 'admin', '2019-02-18 10:50:14', 0, 0, NULL, NULL);
INSERT INTO `sys_permission` VALUES ('fba41089766888023411a978d13c0aa4', 'e41b69c57a941a3bbcce45032fe57605', 'AUTO树表单列表', '/online/cgformTreeList/:code', 'modules/online/cgform/auto/OnlCgformTreeList', NULL, NULL, 1, NULL, '1', 9.00, 0, NULL, 1, 1, NULL, 1, NULL, 'admin', '2019-05-21 14:46:50', 'admin', '2019-06-11 13:52:52', 0, 0, '1', NULL);
INSERT INTO `sys_permission` VALUES ('fc810a2267dd183e4ef7c71cc60f4670', '700b7f95165c46cc7a78bf227aa8fed3', '请求追踪', '/monitor/HttpTrace', 'modules/monitor/HttpTrace', NULL, NULL, 1, NULL, NULL, 4.00, 0, NULL, 1, 1, NULL, 0, NULL, 'admin', '2019-04-02 09:46:19', 'admin', '2019-04-02 11:37:27', 0, 0, NULL, NULL);
INSERT INTO `sys_permission` VALUES ('fedfbf4420536cacc0218557d263dfea', '6e73eb3c26099c191bf03852ee1310a1', '新消息通知', '/account/settings/notification', 'account/settings/Notification', NULL, NULL, 1, 'NotificationSettings', NULL, NULL, NULL, '', 1, 1, NULL, NULL, NULL, NULL, '2018-12-26 19:02:05', NULL, NULL, 0, 0, NULL, NULL);

-- ----------------------------
-- Table structure for sys_permission_data_rule
-- ----------------------------
DROP TABLE IF EXISTS `sys_permission_data_rule`;
CREATE TABLE `sys_permission_data_rule`  (
  `id` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT 'ID',
  `permission_id` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '菜单ID',
  `rule_name` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '规则名称',
  `rule_column` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '字段',
  `rule_conditions` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '条件',
  `rule_value` varchar(300) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '规则值',
  `status` varchar(3) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '权限有效状态1有0否',
  `create_time` datetime(0) NULL DEFAULT NULL COMMENT '创建时间',
  `create_by` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `update_time` datetime(0) NULL DEFAULT NULL COMMENT '修改时间',
  `update_by` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '修改人',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `index_fucntionid`(`permission_id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_permission_data_rule
-- ----------------------------
INSERT INTO `sys_permission_data_rule` VALUES ('32b62cb04d6c788d9d92e3ff5e66854e', '8d4683aacaa997ab86b966b464360338', '000', '00', '!=', '00', '1', '2019-04-02 18:36:08', 'admin', NULL, NULL);
INSERT INTO `sys_permission_data_rule` VALUES ('40283181614231d401614234fe670003', '40283181614231d401614232cd1c0001', 'createBy', 'createBy', '=', '#{sys_user_code}', '1', '2018-01-29 21:57:04', 'admin', NULL, NULL);
INSERT INTO `sys_permission_data_rule` VALUES ('4028318161424e730161424fca6f0004', '4028318161424e730161424f61510002', 'createBy', 'createBy', '=', '#{sys_user_code}', '1', '2018-01-29 22:26:20', 'admin', NULL, NULL);
INSERT INTO `sys_permission_data_rule` VALUES ('402880e6487e661a01487e732c020005', '402889fb486e848101486e93a7c80014', 'SYS_ORG_CODE', 'SYS_ORG_CODE', 'LIKE', '010201%', '1', '2014-09-16 20:32:30', 'admin', NULL, NULL);
INSERT INTO `sys_permission_data_rule` VALUES ('402880e6487e661a01487e8153ee0007', '402889fb486e848101486e93a7c80014', 'create_by', 'create_by', '', '#{SYS_USER_CODE}', '1', '2014-09-16 20:47:57', 'admin', NULL, NULL);
INSERT INTO `sys_permission_data_rule` VALUES ('402880ec5ddec439015ddf9225060038', '40288088481d019401481d2fcebf000d', '复杂关系', '', 'USE_SQL_RULES', 'name like \'%张%\' or age > 10', '1', NULL, NULL, '2017-08-14 15:10:25', 'demo');
INSERT INTO `sys_permission_data_rule` VALUES ('402880ec5ddfdd26015ddfe3e0570011', '4028ab775dca0d1b015dca3fccb60016', '复杂sql配置', '', 'USE_SQL_RULES', 'table_name like \'%test%\' or is_tree = \'Y\'', '1', NULL, NULL, '2017-08-14 16:38:55', 'demo');
INSERT INTO `sys_permission_data_rule` VALUES ('402880f25b1e2ac7015b1e5fdebc0012', '402880f25b1e2ac7015b1e5cdc340010', '只能看自己数据', 'create_by', '=', '#{sys_user_code}', '1', '2017-03-30 16:40:51', 'admin', NULL, NULL);
INSERT INTO `sys_permission_data_rule` VALUES ('402881875b19f141015b19f8125e0014', '40288088481d019401481d2fcebf000d', '可看下属业务数据', 'sys_org_code', 'LIKE', '#{sys_org_code}', '1', NULL, NULL, '2017-08-14 15:04:32', 'demo');
INSERT INTO `sys_permission_data_rule` VALUES ('402881e45394d66901539500a4450001', '402881e54df73c73014df75ab670000f', 'sysCompanyCode', 'sysCompanyCode', '=', '#{SYS_COMPANY_CODE}', '1', '2016-03-21 01:09:21', 'admin', NULL, NULL);
INSERT INTO `sys_permission_data_rule` VALUES ('402881e45394d6690153950177cb0003', '402881e54df73c73014df75ab670000f', 'sysOrgCode', 'sysOrgCode', '=', '#{SYS_ORG_CODE}', '1', '2016-03-21 01:10:15', 'admin', NULL, NULL);
INSERT INTO `sys_permission_data_rule` VALUES ('402881e56266f43101626727aff60067', '402881e56266f43101626724eb730065', '销售自己看自己的数据', 'createBy', '=', '#{sys_user_code}', '1', '2018-03-27 19:11:16', 'admin', NULL, NULL);
INSERT INTO `sys_permission_data_rule` VALUES ('402881e56266f4310162672fb1a70082', '402881e56266f43101626724eb730065', '销售经理看所有下级数据', 'sysOrgCode', 'LIKE', '#{sys_org_code}', '1', '2018-03-27 19:20:01', 'admin', NULL, NULL);
INSERT INTO `sys_permission_data_rule` VALUES ('402881e56266f431016267387c9f0088', '402881e56266f43101626724eb730065', '只看金额大于1000的数据', 'money', '>=', '1000', '1', '2018-03-27 19:29:37', 'admin', NULL, NULL);
INSERT INTO `sys_permission_data_rule` VALUES ('402881f3650de25101650dfb5a3a0010', '402881e56266f4310162671d62050044', '22', '', 'USE_SQL_RULES', '22', '1', '2018-08-06 14:45:01', 'admin', NULL, NULL);
INSERT INTO `sys_permission_data_rule` VALUES ('402889fb486e848101486e913cd6000b', '402889fb486e848101486e8e2e8b0007', 'userName', 'userName', '=', 'admin', '1', '2014-09-13 18:31:25', 'admin', NULL, NULL);
INSERT INTO `sys_permission_data_rule` VALUES ('402889fb486e848101486e98d20d0016', '402889fb486e848101486e93a7c80014', 'title', 'title', '=', '12', '1', NULL, NULL, '2014-09-13 22:18:22', 'scott');
INSERT INTO `sys_permission_data_rule` VALUES ('402889fe47fcb29c0147fcb6b6220001', '8a8ab0b246dc81120146dc8180fe002b', '12', '12', '>', '12', '1', '2014-08-22 15:55:38', '8a8ab0b246dc81120146dc8181950052', NULL, NULL);
INSERT INTO `sys_permission_data_rule` VALUES ('4028ab775dca0d1b015dca4183530018', '4028ab775dca0d1b015dca3fccb60016', '表名限制', 'isDbSynch', '=', 'Y', '1', NULL, NULL, '2017-08-14 16:43:45', 'demo');
INSERT INTO `sys_permission_data_rule` VALUES ('4028ef815595a881015595b0ccb60001', '40288088481d019401481d2fcebf000d', '限只能看自己', 'create_by', '=', '#{sys_user_code}', '1', NULL, NULL, '2017-08-14 15:03:56', 'demo');
INSERT INTO `sys_permission_data_rule` VALUES ('4028ef81574ae99701574aed26530005', '4028ef81574ae99701574aeb97bd0003', '用户名', 'userName', '!=', 'admin', '1', '2016-09-21 12:07:18', 'admin', NULL, NULL);
INSERT INTO `sys_permission_data_rule` VALUES ('53609e1854f4a87eb23ed23a18a1042c', '4148ec82b6acd69f470bea75fe41c357', '只看当前部门数据', 'sysOrgCode', '=', '#{sys_org_code}', '1', '2019-05-11 19:40:39', 'admin', '2019-05-11 19:40:50', 'admin');
INSERT INTO `sys_permission_data_rule` VALUES ('a7d661ef5ac168b2b162420c6804dac5', '4148ec82b6acd69f470bea75fe41c357', '只看自己的数据', 'createBy', '=', '#{sys_user_code}', '1', '2019-05-11 19:19:05', 'admin', '2019-05-11 19:24:58', 'admin');
INSERT INTO `sys_permission_data_rule` VALUES ('f852d85d47f224990147f2284c0c0005', NULL, '小于', 'test', '<=', '11', '1', '2014-08-20 14:43:52', '8a8ab0b246dc81120146dc8181950052', NULL, NULL);

-- ----------------------------
-- Table structure for sys_position
-- ----------------------------
DROP TABLE IF EXISTS `sys_position`;
CREATE TABLE `sys_position`  (
  `id` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `code` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '职务编码',
  `name` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '职务名称',
  `post_rank` varchar(2) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '职级',
  `company_id` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '公司id',
  `create_by` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '创建人',
  `create_time` datetime(0) NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '修改人',
  `update_time` datetime(0) NULL DEFAULT NULL COMMENT '修改时间',
  `sys_org_code` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '组织机构编码',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `uniq_code`(`code`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_position
-- ----------------------------
INSERT INTO `sys_position` VALUES ('1185040064792571906', 'devleader', '研发部经理', '2', NULL, 'admin', '2019-10-18 11:49:03', 'admin', '2019-11-21 16:29:45', 'A01');

-- ----------------------------
-- Table structure for sys_quartz_job
-- ----------------------------
DROP TABLE IF EXISTS `sys_quartz_job`;
CREATE TABLE `sys_quartz_job`  (
  `id` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `create_by` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '创建人',
  `create_time` datetime(0) NULL DEFAULT NULL COMMENT '创建时间',
  `del_flag` int(1) NULL DEFAULT NULL COMMENT '删除状态',
  `update_by` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '修改人',
  `update_time` datetime(0) NULL DEFAULT NULL COMMENT '修改时间',
  `job_class_name` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '任务类名',
  `cron_expression` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT 'cron表达式',
  `parameter` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '参数',
  `description` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '描述',
  `status` int(1) NULL DEFAULT NULL COMMENT '状态 0正常 -1停止',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `uniq_job_class_name`(`job_class_name`) USING BTREE
) ENGINE = MyISAM CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_quartz_job
-- ----------------------------
INSERT INTO `sys_quartz_job` VALUES ('df26ecacf0f75d219d746750fe84bbee', NULL, NULL, 0, 'admin', '2019-01-19 15:09:41', 'org.jeecg.modules.quartz.job.SampleParamJob', '0/1 * * * * ?', 'scott', '带参测试 后台将每隔1秒执行输出日志', -1);
INSERT INTO `sys_quartz_job` VALUES ('a253cdfc811d69fa0efc70d052bc8128', 'admin', '2019-03-30 12:44:48', 0, 'admin', '2019-03-30 12:44:52', 'org.jeecg.modules.quartz.job.SampleJob', '0/1 * * * * ?', NULL, NULL, -1);
INSERT INTO `sys_quartz_job` VALUES ('5b3d2c087ad41aa755fc4f89697b01e7', 'admin', '2019-04-11 19:04:21', 0, 'admin', '2019-04-11 19:49:49', 'org.jeecg.modules.message.job.SendMsgJob', '0/60 * * * * ?', NULL, NULL, -1);

-- ----------------------------
-- Table structure for sys_role
-- ----------------------------
DROP TABLE IF EXISTS `sys_role`;
CREATE TABLE `sys_role`  (
  `id` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '主键id',
  `role_name` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '角色名称',
  `role_code` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '角色编码',
  `description` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '描述',
  `create_by` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '创建人',
  `create_time` datetime(0) NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '更新人',
  `update_time` datetime(0) NULL DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `uniq_sys_role_role_code`(`role_code`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '角色表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_role
-- ----------------------------
INSERT INTO `sys_role` VALUES ('1169504891467464705', '第三方登录角色', 'third_role', '第三方登录角色', 'admin', '2019-09-05 14:57:49', 'admin', '2019-09-05 14:57:56');
INSERT INTO `sys_role` VALUES ('e51758fa916c881624b046d26bd09230', '人力资源部', 'hr', NULL, 'admin', '2019-01-21 18:07:24', 'admin', '2019-10-18 11:39:43');
INSERT INTO `sys_role` VALUES ('ee8626f80f7c2619917b6236f3a7f02b', '临时角色', 'test', '这是新建的临时角色123', NULL, '2018-12-20 10:59:04', 'admin', '2019-02-19 15:08:37');
INSERT INTO `sys_role` VALUES ('f6817f48af4fb3af11b9e8bf182f618b', '管理员', 'admin', '管理员', NULL, '2018-12-21 18:03:39', 'admin', '2019-05-20 11:40:26');

-- ----------------------------
-- Table structure for sys_role_permission
-- ----------------------------
DROP TABLE IF EXISTS `sys_role_permission`;
CREATE TABLE `sys_role_permission`  (
  `id` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `role_id` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '角色id',
  `permission_id` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '权限id',
  `data_rule_ids` varchar(1000) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `index_group_role_per_id`(`role_id`, `permission_id`) USING BTREE,
  INDEX `index_group_role_id`(`role_id`) USING BTREE,
  INDEX `index_group_per_id`(`permission_id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '角色权限表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_role_permission
-- ----------------------------
INSERT INTO `sys_role_permission` VALUES ('00b0748f04d3ea52c8cfa179c1c9d384', '52b0cf022ac4187b2a70dfa4f8b2d940', 'd7d6e2e4e2934f2c9385a623fd98c6f3', NULL);
INSERT INTO `sys_role_permission` VALUES ('00b82058779cca5106fbb84783534c9b', 'f6817f48af4fb3af11b9e8bf182f618b', '4148ec82b6acd69f470bea75fe41c357', NULL);
INSERT INTO `sys_role_permission` VALUES ('0254c0b25694ad5479e6d6935bbc176e', 'f6817f48af4fb3af11b9e8bf182f618b', '944abf0a8fc22fe1f1154a389a574154', NULL);
INSERT INTO `sys_role_permission` VALUES ('09bd4fc30ffe88c4a44ed3868f442719', 'f6817f48af4fb3af11b9e8bf182f618b', 'e6bfd1fcabfd7942fdd05f076d1dad38', NULL);
INSERT INTO `sys_role_permission` VALUES ('0c2d2db76ee3aa81a4fe0925b0f31365', 'f6817f48af4fb3af11b9e8bf182f618b', '024f1fd1283dc632458976463d8984e1', NULL);
INSERT INTO `sys_role_permission` VALUES ('0c6b8facbb1cc874964c87a8cf01e4b1', 'f6817f48af4fb3af11b9e8bf182f618b', '841057b8a1bef8f6b4b20f9a618a7fa6', NULL);
INSERT INTO `sys_role_permission` VALUES ('0c6e1075e422972083c3e854d9af7851', 'f6817f48af4fb3af11b9e8bf182f618b', '08e6b9dc3c04489c8e1ff2ce6f105aa4', NULL);
INSERT INTO `sys_role_permission` VALUES ('0d9d14bc66e9d5e99b0280095fdc8587', 'ee8626f80f7c2619917b6236f3a7f02b', '277bfabef7d76e89b33062b16a9a5020', NULL);
INSERT INTO `sys_role_permission` VALUES ('0dec36b68c234767cd35466efef3b941', 'ee8626f80f7c2619917b6236f3a7f02b', '54dd5457a3190740005c1bfec55b1c34', NULL);
INSERT INTO `sys_role_permission` VALUES ('0e1469997af2d3b97fff56a59ee29eeb', 'f6817f48af4fb3af11b9e8bf182f618b', 'e41b69c57a941a3bbcce45032fe57605', NULL);
INSERT INTO `sys_role_permission` VALUES ('0f861cb988fdc639bb1ab943471f3a72', 'f6817f48af4fb3af11b9e8bf182f618b', '97c8629abc7848eccdb6d77c24bb3ebb', NULL);
INSERT INTO `sys_role_permission` VALUES ('105c2ac10741e56a618a82cd58c461d7', 'e51758fa916c881624b046d26bd09230', '1663f3faba244d16c94552f849627d84', NULL);
INSERT INTO `sys_role_permission` VALUES ('115a6673ae6c0816d3f60de221520274', '21c5a3187763729408b40afb0d0fdfa8', '63b551e81c5956d5c861593d366d8c57', NULL);
INSERT INTO `sys_role_permission` VALUES ('1185039870491439105', 'f6817f48af4fb3af11b9e8bf182f618b', '1174506953255182338', NULL);
INSERT INTO `sys_role_permission` VALUES ('1185039870529187841', 'f6817f48af4fb3af11b9e8bf182f618b', '1174590283938041857', NULL);
INSERT INTO `sys_role_permission` VALUES ('1185039870537576450', 'f6817f48af4fb3af11b9e8bf182f618b', '1166535831146504193', NULL);
INSERT INTO `sys_role_permission` VALUES ('1197431682208206850', 'f6817f48af4fb3af11b9e8bf182f618b', '1192318987661234177', NULL);
INSERT INTO `sys_role_permission` VALUES ('1197795315916271617', 'f6817f48af4fb3af11b9e8bf182f618b', '109c78a583d4693ce2f16551b7786786', NULL);
INSERT INTO `sys_role_permission` VALUES ('1197795316268593154', 'f6817f48af4fb3af11b9e8bf182f618b', '9fe26464838de2ea5e90f2367e35efa0', NULL);
INSERT INTO `sys_role_permission` VALUES ('1209423530518761473', 'f6817f48af4fb3af11b9e8bf182f618b', '1205097455226462210', NULL);
INSERT INTO `sys_role_permission` VALUES ('1209423530594258945', 'f6817f48af4fb3af11b9e8bf182f618b', '1205098241075453953', NULL);
INSERT INTO `sys_role_permission` VALUES ('1209423530606841858', 'f6817f48af4fb3af11b9e8bf182f618b', '1205306106780364802', NULL);
INSERT INTO `sys_role_permission` VALUES ('1209423580355481602', 'f6817f48af4fb3af11b9e8bf182f618b', '190c2b43bec6a5f7a4194a85db67d96a', NULL);
INSERT INTO `sys_role_permission` VALUES ('1209654501558046722', 'f6817f48af4fb3af11b9e8bf182f618b', 'f2849d3814fc97993bfc519ae6bbf049', NULL);
INSERT INTO `sys_role_permission` VALUES ('1240275523958341634', 'f6817f48af4fb3af11b9e8bf182f618b', '7593c9e3523a17bca83b8d7fe8a34e58', NULL);
INSERT INTO `sys_role_permission` VALUES ('1240480882778075138', 'f6817f48af4fb3af11b9e8bf182f618b', '1224641973866467330', NULL);
INSERT INTO `sys_role_permission` VALUES ('1240480882794852354', 'f6817f48af4fb3af11b9e8bf182f618b', '1209731624921534465', NULL);
INSERT INTO `sys_role_permission` VALUES ('1240480882799046657', 'f6817f48af4fb3af11b9e8bf182f618b', '277bfabef7d76e89b33062b16a9a5020', NULL);
INSERT INTO `sys_role_permission` VALUES ('1240583012776046593', 'f6817f48af4fb3af11b9e8bf182f618b', '1240582498747314177', NULL);
INSERT INTO `sys_role_permission` VALUES ('1242262957467402241', 'ee8626f80f7c2619917b6236f3a7f02b', '1239192676086464514', NULL);
INSERT INTO `sys_role_permission` VALUES ('1242262957484179457', 'ee8626f80f7c2619917b6236f3a7f02b', '1239194065856512002', NULL);
INSERT INTO `sys_role_permission` VALUES ('1242262957484179458', 'ee8626f80f7c2619917b6236f3a7f02b', '1242262642546475010', NULL);
INSERT INTO `sys_role_permission` VALUES ('1242262957492568066', 'ee8626f80f7c2619917b6236f3a7f02b', '1239193313754890241', NULL);
INSERT INTO `sys_role_permission` VALUES ('1242263634197381122', 'ee8626f80f7c2619917b6236f3a7f02b', '1242263502445903874', NULL);
INSERT INTO `sys_role_permission` VALUES ('1244271421528907778', 'ee8626f80f7c2619917b6236f3a7f02b', '1244271300749729794', NULL);
INSERT INTO `sys_role_permission` VALUES ('1244878529777532929', 'ee8626f80f7c2619917b6236f3a7f02b', '1244876622988214274', NULL);
INSERT INTO `sys_role_permission` VALUES ('1244878529790115842', 'ee8626f80f7c2619917b6236f3a7f02b', '1244877762060517378', NULL);
INSERT INTO `sys_role_permission` VALUES ('1245154976237932545', 'ee8626f80f7c2619917b6236f3a7f02b', '1245154914959151105', NULL);
INSERT INTO `sys_role_permission` VALUES ('1245154976263098369', 'ee8626f80f7c2619917b6236f3a7f02b', '1245154570166390786', NULL);
INSERT INTO `sys_role_permission` VALUES ('1245154976275681282', 'ee8626f80f7c2619917b6236f3a7f02b', '1245154050731200514', NULL);
INSERT INTO `sys_role_permission` VALUES ('1248893414970675202', 'ee8626f80f7c2619917b6236f3a7f02b', '1248893062452006914', NULL);
INSERT INTO `sys_role_permission` VALUES ('1249544719772008450', 'ee8626f80f7c2619917b6236f3a7f02b', '1249544156015607810', NULL);
INSERT INTO `sys_role_permission` VALUES ('1249544719780397058', 'ee8626f80f7c2619917b6236f3a7f02b', '1249544661932556290', NULL);
INSERT INTO `sys_role_permission` VALUES ('1250094441321373698', 'ee8626f80f7c2619917b6236f3a7f02b', '1250093240089485313', NULL);
INSERT INTO `sys_role_permission` VALUES ('1250094441350733825', 'ee8626f80f7c2619917b6236f3a7f02b', '1250093691350458369', NULL);
INSERT INTO `sys_role_permission` VALUES ('1250094441359122433', 'ee8626f80f7c2619917b6236f3a7f02b', '1250094027880439809', NULL);
INSERT INTO `sys_role_permission` VALUES ('1251026486009856001', 'ee8626f80f7c2619917b6236f3a7f02b', '1251026399728828418', NULL);
INSERT INTO `sys_role_permission` VALUES ('1255531132563685378', 'ee8626f80f7c2619917b6236f3a7f02b', '1255530775234150402', NULL);
INSERT INTO `sys_role_permission` VALUES ('1255770444996837378', 'ee8626f80f7c2619917b6236f3a7f02b', '1255770241849917442', NULL);
INSERT INTO `sys_role_permission` VALUES ('1255862762150985730', 'ee8626f80f7c2619917b6236f3a7f02b', '1255862470869155841', NULL);
INSERT INTO `sys_role_permission` VALUES ('1257329941543256065', 'ee8626f80f7c2619917b6236f3a7f02b', '1257326494815248386', NULL);
INSERT INTO `sys_role_permission` VALUES ('1259078194144112642', 'ee8626f80f7c2619917b6236f3a7f02b', '1259078064502370305', NULL);
INSERT INTO `sys_role_permission` VALUES ('1259481613514215426', 'ee8626f80f7c2619917b6236f3a7f02b', '1259481545591656449', NULL);
INSERT INTO `sys_role_permission` VALUES ('1259685078962180098', 'ee8626f80f7c2619917b6236f3a7f02b', '1259684566669889538', NULL);
INSERT INTO `sys_role_permission` VALUES ('1259685078970568706', 'ee8626f80f7c2619917b6236f3a7f02b', '1259684954311659522', NULL);
INSERT INTO `sys_role_permission` VALUES ('1259786878411231233', 'ee8626f80f7c2619917b6236f3a7f02b', '1259752781957730306', NULL);
INSERT INTO `sys_role_permission` VALUES ('1259786878419619841', 'ee8626f80f7c2619917b6236f3a7f02b', '1259755488869257217', NULL);
INSERT INTO `sys_role_permission` VALUES ('1259849767176261634', 'ee8626f80f7c2619917b6236f3a7f02b', '1259846003342069761', NULL);
INSERT INTO `sys_role_permission` VALUES ('1259849767197233154', 'ee8626f80f7c2619917b6236f3a7f02b', '1259846469224386562', NULL);
INSERT INTO `sys_role_permission` VALUES ('1259849767205621761', 'ee8626f80f7c2619917b6236f3a7f02b', '1259846724485533697', NULL);
INSERT INTO `sys_role_permission` VALUES ('1259849767218204673', 'ee8626f80f7c2619917b6236f3a7f02b', '1259846940940980225', NULL);
INSERT INTO `sys_role_permission` VALUES ('1260049352407707650', 'ee8626f80f7c2619917b6236f3a7f02b', '1260049265086492674', NULL);
INSERT INTO `sys_role_permission` VALUES ('1260053822009044993', 'ee8626f80f7c2619917b6236f3a7f02b', '1260053768900767745', NULL);
INSERT INTO `sys_role_permission` VALUES ('1260120344458977282', 'ee8626f80f7c2619917b6236f3a7f02b', '1260119762952282114', NULL);
INSERT INTO `sys_role_permission` VALUES ('1260120344484143106', 'ee8626f80f7c2619917b6236f3a7f02b', '1260120272916733954', NULL);
INSERT INTO `sys_role_permission` VALUES ('1260464202522910722', 'ee8626f80f7c2619917b6236f3a7f02b', '1260464092879609857', NULL);
INSERT INTO `sys_role_permission` VALUES ('1261214036880076801', 'ee8626f80f7c2619917b6236f3a7f02b', '1261213485316517889', NULL);
INSERT INTO `sys_role_permission` VALUES ('1261214036989128706', 'ee8626f80f7c2619917b6236f3a7f02b', '1261213213500452866', NULL);
INSERT INTO `sys_role_permission` VALUES ('1261473263950102529', 'ee8626f80f7c2619917b6236f3a7f02b', '1261473105690624001', NULL);
INSERT INTO `sys_role_permission` VALUES ('1261951329507885057', 'ee8626f80f7c2619917b6236f3a7f02b', '1261951277691453442', NULL);
INSERT INTO `sys_role_permission` VALUES ('1262299906932486145', 'ee8626f80f7c2619917b6236f3a7f02b', '1262299859608154114', NULL);
INSERT INTO `sys_role_permission` VALUES ('1263131137151533058', 'ee8626f80f7c2619917b6236f3a7f02b', '1263131054251114497', NULL);
INSERT INTO `sys_role_permission` VALUES ('1263137877687468033', 'ee8626f80f7c2619917b6236f3a7f02b', '1263137799941849090', NULL);
INSERT INTO `sys_role_permission` VALUES ('1263273367951732737', 'ee8626f80f7c2619917b6236f3a7f02b', '1263272675325341697', NULL);
INSERT INTO `sys_role_permission` VALUES ('1263297204911173633', 'ee8626f80f7c2619917b6236f3a7f02b', '1263296696360202241', NULL);
INSERT INTO `sys_role_permission` VALUES ('1263457133759197186', 'ee8626f80f7c2619917b6236f3a7f02b', '1263456573379211265', NULL);
INSERT INTO `sys_role_permission` VALUES ('1263457133784363009', 'ee8626f80f7c2619917b6236f3a7f02b', '1263457033024598017', NULL);
INSERT INTO `sys_role_permission` VALUES ('1264105151537774593', 'ee8626f80f7c2619917b6236f3a7f02b', '1264105015952703490', NULL);
INSERT INTO `sys_role_permission` VALUES ('1264476188578336769', 'ee8626f80f7c2619917b6236f3a7f02b', '1264475682141294594', NULL);
INSERT INTO `sys_role_permission` VALUES ('1264476188607696897', 'ee8626f80f7c2619917b6236f3a7f02b', '1264476085746585602', NULL);
INSERT INTO `sys_role_permission` VALUES ('1265462507782873089', 'ee8626f80f7c2619917b6236f3a7f02b', '1265462136117207042', NULL);
INSERT INTO `sys_role_permission` VALUES ('1266386684969631746', 'ee8626f80f7c2619917b6236f3a7f02b', '1266386162661343233', NULL);
INSERT INTO `sys_role_permission` VALUES ('126ea9faebeec2b914d6d9bef957afb6', 'f6817f48af4fb3af11b9e8bf182f618b', 'f1cb187abf927c88b89470d08615f5ac', NULL);
INSERT INTO `sys_role_permission` VALUES ('145eac8dd88eddbd4ce0a800ab40a92c', 'e51758fa916c881624b046d26bd09230', '08e6b9dc3c04489c8e1ff2ce6f105aa4', NULL);
INSERT INTO `sys_role_permission` VALUES ('154edd0599bd1dc2c7de220b489cd1e2', 'f6817f48af4fb3af11b9e8bf182f618b', '7ac9eb9ccbde2f7a033cd4944272bf1e', NULL);
INSERT INTO `sys_role_permission` VALUES ('165acd6046a0eaf975099f46a3c898ea', 'f6817f48af4fb3af11b9e8bf182f618b', '4f66409ef3bbd69c1d80469d6e2a885e', NULL);
INSERT INTO `sys_role_permission` VALUES ('1664b92dff13e1575e3a929caa2fa14d', 'f6817f48af4fb3af11b9e8bf182f618b', 'd2bbf9ebca5a8fa2e227af97d2da7548', NULL);
INSERT INTO `sys_role_permission` VALUES ('16ef8ed3865ccc6f6306200760896c50', 'ee8626f80f7c2619917b6236f3a7f02b', 'e8af452d8948ea49d37c934f5100ae6a', NULL);
INSERT INTO `sys_role_permission` VALUES ('17ead5b7d97ed365398ab20009a69ea3', '52b0cf022ac4187b2a70dfa4f8b2d940', 'e08cb190ef230d5d4f03824198773950', NULL);
INSERT INTO `sys_role_permission` VALUES ('1ac1688ef8456f384091a03d88a89ab1', '52b0cf022ac4187b2a70dfa4f8b2d940', '693ce69af3432bd00be13c3971a57961', NULL);
INSERT INTO `sys_role_permission` VALUES ('1af4babaa4227c3cbb830bc5eb513abb', 'ee8626f80f7c2619917b6236f3a7f02b', 'e08cb190ef230d5d4f03824198773950', NULL);
INSERT INTO `sys_role_permission` VALUES ('1ba162bbc2076c25561f8622f610d5bf', 'ee8626f80f7c2619917b6236f3a7f02b', 'aedbf679b5773c1f25e9f7b10111da73', NULL);
INSERT INTO `sys_role_permission` VALUES ('1c1dbba68ef1817e7fb19c822d2854e8', 'f6817f48af4fb3af11b9e8bf182f618b', 'fb367426764077dcf94640c843733985', NULL);
INSERT INTO `sys_role_permission` VALUES ('1c55c4ced20765b8ebab383caa60f0b6', 'e51758fa916c881624b046d26bd09230', 'fb367426764077dcf94640c843733985', NULL);
INSERT INTO `sys_role_permission` VALUES ('1e099baeae01b747d67aca06bdfc34d1', 'e51758fa916c881624b046d26bd09230', '6ad53fd1b220989a8b71ff482d683a5a', NULL);
INSERT INTO `sys_role_permission` VALUES ('1e47db875601fd97723254046b5bba90', 'f6817f48af4fb3af11b9e8bf182f618b', 'baf16b7174bd821b6bab23fa9abb200d', NULL);
INSERT INTO `sys_role_permission` VALUES ('1fe4d408b85f19618c15bcb768f0ec22', '1750a8fb3e6d90cb7957c02de1dc8e59', '9502685863ab87f0ad1134142788a385', NULL);
INSERT INTO `sys_role_permission` VALUES ('20e53c87a785688bdc0a5bb6de394ef1', 'f6817f48af4fb3af11b9e8bf182f618b', '540a2936940846cb98114ffb0d145cb8', NULL);
INSERT INTO `sys_role_permission` VALUES ('248d288586c6ff3bd14381565df84163', '52b0cf022ac4187b2a70dfa4f8b2d940', '3f915b2769fc80648e92d04e84ca059d', NULL);
INSERT INTO `sys_role_permission` VALUES ('25491ecbd5a9b34f09c8bc447a10ede1', 'f6817f48af4fb3af11b9e8bf182f618b', 'd07a2c87a451434c99ab06296727ec4f', NULL);
INSERT INTO `sys_role_permission` VALUES ('25f5443f19c34d99718a016d5f54112e', 'ee8626f80f7c2619917b6236f3a7f02b', '6e73eb3c26099c191bf03852ee1310a1', NULL);
INSERT INTO `sys_role_permission` VALUES ('27489816708b18859768dfed5945c405', 'a799c3b1b12dd3ed4bd046bfaef5fe6e', '9502685863ab87f0ad1134142788a385', NULL);
INSERT INTO `sys_role_permission` VALUES ('2779cdea8367fff37db26a42c1a1f531', 'f6817f48af4fb3af11b9e8bf182f618b', 'fef097f3903caf3a3c3a6efa8de43fbb', NULL);
INSERT INTO `sys_role_permission` VALUES ('296f9c75ca0e172ae5ce4c1022c996df', '646c628b2b8295fbdab2d34044de0354', '732d48f8e0abe99fe6a23d18a3171cd1', NULL);
INSERT INTO `sys_role_permission` VALUES ('29fb4d37aa29b9fa400f389237cf9fe7', 'ee8626f80f7c2619917b6236f3a7f02b', '05b3c82ddb2536a4a5ee1a4c46b5abef', NULL);
INSERT INTO `sys_role_permission` VALUES ('29fb6b0ad59a7e911c8d27e0bdc42d23', 'f6817f48af4fb3af11b9e8bf182f618b', '9a90363f216a6a08f32eecb3f0bf12a3', NULL);
INSERT INTO `sys_role_permission` VALUES ('2ad37346c1b83ddeebc008f6987b2227', 'f6817f48af4fb3af11b9e8bf182f618b', '8d1ebd663688965f1fd86a2f0ead3416', NULL);
INSERT INTO `sys_role_permission` VALUES ('2c462293cbb0eab7e8ae0a3600361b5f', '52b0cf022ac4187b2a70dfa4f8b2d940', '9502685863ab87f0ad1134142788a385', NULL);
INSERT INTO `sys_role_permission` VALUES ('2dc1a0eb5e39aaa131ddd0082a492d76', 'ee8626f80f7c2619917b6236f3a7f02b', '08e6b9dc3c04489c8e1ff2ce6f105aa4', NULL);
INSERT INTO `sys_role_permission` VALUES ('2ea2382af618ba7d1e80491a0185fb8a', 'ee8626f80f7c2619917b6236f3a7f02b', 'f23d9bfff4d9aa6b68569ba2cff38415', NULL);
INSERT INTO `sys_role_permission` VALUES ('2fcfa2ac3dcfadc7c67107dae9a0de6d', 'ee8626f80f7c2619917b6236f3a7f02b', '73678f9daa45ed17a3674131b03432fb', NULL);
INSERT INTO `sys_role_permission` VALUES ('2fdaed22dfa4c8d4629e44ef81688c6a', '52b0cf022ac4187b2a70dfa4f8b2d940', 'aedbf679b5773c1f25e9f7b10111da73', NULL);
INSERT INTO `sys_role_permission` VALUES ('300c462b7fec09e2ff32574ef8b3f0bd', '52b0cf022ac4187b2a70dfa4f8b2d940', '2a470fc0c3954d9dbb61de6d80846549', NULL);
INSERT INTO `sys_role_permission` VALUES ('326181da3248a62a05e872119a462be1', 'ee8626f80f7c2619917b6236f3a7f02b', '3f915b2769fc80648e92d04e84ca059d', NULL);
INSERT INTO `sys_role_permission` VALUES ('3369650f5072b330543f8caa556b1b33', 'e51758fa916c881624b046d26bd09230', 'a400e4f4d54f79bf5ce160ae432231af', NULL);
INSERT INTO `sys_role_permission` VALUES ('35a7e156c20e93aa7e825fe514bf9787', 'e51758fa916c881624b046d26bd09230', 'c6cf95444d80435eb37b2f9db3971ae6', NULL);
INSERT INTO `sys_role_permission` VALUES ('35ac7cae648de39eb56213ca1b649713', '52b0cf022ac4187b2a70dfa4f8b2d940', 'b1cb0a3fedf7ed0e4653cb5a229837ee', NULL);
INSERT INTO `sys_role_permission` VALUES ('37112f4d372541e105473f18da3dc50d', 'ee8626f80f7c2619917b6236f3a7f02b', 'a400e4f4d54f79bf5ce160ae432231af', NULL);
INSERT INTO `sys_role_permission` VALUES ('37789f70cd8bd802c4a69e9e1f633eaa', 'ee8626f80f7c2619917b6236f3a7f02b', 'ae4fed059f67086fd52a73d913cf473d', NULL);
INSERT INTO `sys_role_permission` VALUES ('381504a717cb3ce77dcd4070c9689a7e', 'ee8626f80f7c2619917b6236f3a7f02b', '4f84f9400e5e92c95f05b554724c2b58', NULL);
INSERT INTO `sys_role_permission` VALUES ('38a2e55db0960262800576e34b3af44c', 'f6817f48af4fb3af11b9e8bf182f618b', '5c2f42277948043026b7a14692456828', NULL);
INSERT INTO `sys_role_permission` VALUES ('38dd7a19711e7ffe864232954c06fae9', 'e51758fa916c881624b046d26bd09230', 'd2bbf9ebca5a8fa2e227af97d2da7548', NULL);
INSERT INTO `sys_role_permission` VALUES ('3b1886f727ac503c93fecdd06dcb9622', 'f6817f48af4fb3af11b9e8bf182f618b', 'c431130c0bc0ec71b0a5be37747bb36a', NULL);
INSERT INTO `sys_role_permission` VALUES ('3de2a60c7e42a521fecf6fcc5cb54978', 'f6817f48af4fb3af11b9e8bf182f618b', '2d83d62bd2544b8994c8f38cf17b0ddf', NULL);
INSERT INTO `sys_role_permission` VALUES ('3e4e38f748b8d87178dd62082e5b7b60', 'f6817f48af4fb3af11b9e8bf182f618b', '7960961b0063228937da5fa8dd73d371', NULL);
INSERT INTO `sys_role_permission` VALUES ('3e563751942b0879c88ca4de19757b50', '1750a8fb3e6d90cb7957c02de1dc8e59', '58857ff846e61794c69208e9d3a85466', NULL);
INSERT INTO `sys_role_permission` VALUES ('3f1d04075e3c3254666a4138106a4e51', 'f6817f48af4fb3af11b9e8bf182f618b', '3fac0d3c9cd40fa53ab70d4c583821f8', NULL);
INSERT INTO `sys_role_permission` VALUES ('412e2de37a35b3442d68db8dd2f3c190', '52b0cf022ac4187b2a70dfa4f8b2d940', 'f1cb187abf927c88b89470d08615f5ac', NULL);
INSERT INTO `sys_role_permission` VALUES ('4204f91fb61911ba8ce40afa7c02369f', 'f6817f48af4fb3af11b9e8bf182f618b', '3f915b2769fc80648e92d04e84ca059d', NULL);
INSERT INTO `sys_role_permission` VALUES ('444126230885d5d38b8fa6072c9f43f8', 'f6817f48af4fb3af11b9e8bf182f618b', 'f780d0d3083d849ccbdb1b1baee4911d', NULL);
INSERT INTO `sys_role_permission` VALUES ('445656dd187bd8a71605f4bbab1938a3', 'f6817f48af4fb3af11b9e8bf182f618b', '020b06793e4de2eee0007f603000c769', NULL);
INSERT INTO `sys_role_permission` VALUES ('44b5a73541bcb854dd5d38c6d1fb93a1', 'ee8626f80f7c2619917b6236f3a7f02b', '418964ba087b90a84897b62474496b93', NULL);
INSERT INTO `sys_role_permission` VALUES ('455cdb482457f529b79b479a2ff74427', 'f6817f48af4fb3af11b9e8bf182f618b', 'e1979bb53e9ea51cecc74d86fd9d2f64', NULL);
INSERT INTO `sys_role_permission` VALUES ('459aa2e7021b435b4d65414cfbc71c66', 'e51758fa916c881624b046d26bd09230', '4148ec82b6acd69f470bea75fe41c357', NULL);
INSERT INTO `sys_role_permission` VALUES ('45a358bb738782d1a0edbf7485e81459', 'f6817f48af4fb3af11b9e8bf182f618b', '0ac2ad938963b6c6d1af25477d5b8b51', NULL);
INSERT INTO `sys_role_permission` VALUES ('4c0940badae3ef9231ee9d042338f2a4', 'e51758fa916c881624b046d26bd09230', '2a470fc0c3954d9dbb61de6d80846549', NULL);
INSERT INTO `sys_role_permission` VALUES ('4d56ce2f67c94b74a1d3abdbea340e42', 'ee8626f80f7c2619917b6236f3a7f02b', 'd86f58e7ab516d3bc6bfb1fe10585f97', NULL);
INSERT INTO `sys_role_permission` VALUES ('4dab5a06acc8ef3297889872caa74747', 'f6817f48af4fb3af11b9e8bf182f618b', 'ffb423d25cc59dcd0532213c4a518261', NULL);
INSERT INTO `sys_role_permission` VALUES ('4e0a37ed49524df5f08fc6593aee875c', 'f6817f48af4fb3af11b9e8bf182f618b', 'f23d9bfff4d9aa6b68569ba2cff38415', NULL);
INSERT INTO `sys_role_permission` VALUES ('4ea403fc1d19feb871c8bdd9f94a4ecc', 'f6817f48af4fb3af11b9e8bf182f618b', '2e42e3835c2b44ec9f7bc26c146ee531', NULL);
INSERT INTO `sys_role_permission` VALUES ('4f254549d9498f06f4cc9b23f3e2c070', 'f6817f48af4fb3af11b9e8bf182f618b', '93d5cfb4448f11e9916698e7f462b4b6', NULL);
INSERT INTO `sys_role_permission` VALUES ('4f2fd4a190db856e21476de2704bbd99', 'f6817f48af4fb3af11b9e8bf182f618b', '1a0811914300741f4e11838ff37a1d3a', NULL);
INSERT INTO `sys_role_permission` VALUES ('4faad8ff93cb2b5607cd3d07c1b624ee', 'a799c3b1b12dd3ed4bd046bfaef5fe6e', '70b8f33da5f39de1981bf89cf6c99792', NULL);
INSERT INTO `sys_role_permission` VALUES ('504e326de3f03562cdd186748b48a8c7', 'f6817f48af4fb3af11b9e8bf182f618b', '027aee69baee98a0ed2e01806e89c891', NULL);
INSERT INTO `sys_role_permission` VALUES ('520b5989e6fe4a302a573d4fee12a40a', 'f6817f48af4fb3af11b9e8bf182f618b', '6531cf3421b1265aeeeabaab5e176e6d', NULL);
INSERT INTO `sys_role_permission` VALUES ('54fdf85e52807bdb32ce450814abc256', 'f6817f48af4fb3af11b9e8bf182f618b', 'cc50656cf9ca528e6f2150eba4714ad2', NULL);
INSERT INTO `sys_role_permission` VALUES ('57c0b3a547b815ea3ec8e509b08948b3', '1750a8fb3e6d90cb7957c02de1dc8e59', '3f915b2769fc80648e92d04e84ca059d', NULL);
INSERT INTO `sys_role_permission` VALUES ('593ee05c4fe4645c7826b7d5e14f23ec', '52b0cf022ac4187b2a70dfa4f8b2d940', '8fb8172747a78756c11916216b8b8066', NULL);
INSERT INTO `sys_role_permission` VALUES ('5affc85021fcba07d81c09a6fdfa8dc6', 'ee8626f80f7c2619917b6236f3a7f02b', '078f9558cdeab239aecb2bda1a8ed0d1', NULL);
INSERT INTO `sys_role_permission` VALUES ('5d230e6cd2935c4117f6cb9a7a749e39', 'f6817f48af4fb3af11b9e8bf182f618b', 'fc810a2267dd183e4ef7c71cc60f4670', NULL);
INSERT INTO `sys_role_permission` VALUES ('5de6871fadb4fe1cdd28989da0126b07', 'f6817f48af4fb3af11b9e8bf182f618b', 'a400e4f4d54f79bf5ce160a3432231af', NULL);
INSERT INTO `sys_role_permission` VALUES ('5e4015a9a641cbf3fb5d28d9f885d81a', 'f6817f48af4fb3af11b9e8bf182f618b', '2dbbafa22cda07fa5d169d741b81fe12', NULL);
INSERT INTO `sys_role_permission` VALUES ('5e634a89f75b7a421c02aecfd520325f', 'e51758fa916c881624b046d26bd09230', '339329ed54cf255e1f9392e84f136901', NULL);
INSERT INTO `sys_role_permission` VALUES ('5e74637c4bec048d1880ad0bd1b00552', 'e51758fa916c881624b046d26bd09230', 'a400e4f4d54f79bf5ce160a3432231af', NULL);
INSERT INTO `sys_role_permission` VALUES ('5fc194b709336d354640fe29fefd65a3', 'a799c3b1b12dd3ed4bd046bfaef5fe6e', '9ba60e626bf2882c31c488aba62b89f0', NULL);
INSERT INTO `sys_role_permission` VALUES ('60eda4b4db138bdb47edbe8e10e71675', 'f6817f48af4fb3af11b9e8bf182f618b', 'fb07ca05a3e13674dbf6d3245956da2e', NULL);
INSERT INTO `sys_role_permission` VALUES ('61835e48f3e675f7d3f5c9dd3a10dcf3', 'f6817f48af4fb3af11b9e8bf182f618b', 'f0675b52d89100ee88472b6800754a08', NULL);
INSERT INTO `sys_role_permission` VALUES ('6451dac67ba4acafb570fd6a03f47460', 'ee8626f80f7c2619917b6236f3a7f02b', 'e3c13679c73a4f829bcff2aba8fd68b1', NULL);
INSERT INTO `sys_role_permission` VALUES ('660fbc40bcb1044738f7cabdf1708c28', 'f6817f48af4fb3af11b9e8bf182f618b', 'b3c824fc22bd953e2eb16ae6914ac8f9', NULL);
INSERT INTO `sys_role_permission` VALUES ('66b202f8f84fe766176b3f51071836ef', 'f6817f48af4fb3af11b9e8bf182f618b', '1367a93f2c410b169faa7abcbad2f77c', NULL);
INSERT INTO `sys_role_permission` VALUES ('6b605c261ffbc8ac8a98ae33579c8c78', 'f6817f48af4fb3af11b9e8bf182f618b', 'fba41089766888023411a978d13c0aa4', NULL);
INSERT INTO `sys_role_permission` VALUES ('6c43fd3f10fdaf2a0646434ae68709b5', 'ee8626f80f7c2619917b6236f3a7f02b', '540a2936940846cb98114ffb0d145cb8', NULL);
INSERT INTO `sys_role_permission` VALUES ('6c74518eb6bb9a353f6a6c459c77e64b', 'f6817f48af4fb3af11b9e8bf182f618b', 'b4dfc7d5dd9e8d5b6dd6d4579b1aa559', NULL);
INSERT INTO `sys_role_permission` VALUES ('6daddafacd7eccb91309530c17c5855d', 'f6817f48af4fb3af11b9e8bf182f618b', 'edfa74d66e8ea63ea432c2910837b150', NULL);
INSERT INTO `sys_role_permission` VALUES ('6fb4c2142498dd6d5b6c014ef985cb66', 'f6817f48af4fb3af11b9e8bf182f618b', '6e73eb3c26099c191bf03852ee1310a1', NULL);
INSERT INTO `sys_role_permission` VALUES ('71a5f54a90aa8c7a250a38b7dba39f6f', 'ee8626f80f7c2619917b6236f3a7f02b', '8fb8172747a78756c11916216b8b8066', NULL);
INSERT INTO `sys_role_permission` VALUES ('737d35f582036cd18bfd4c8e5748eaa4', 'e51758fa916c881624b046d26bd09230', '693ce69af3432bd00be13c3971a57961', NULL);
INSERT INTO `sys_role_permission` VALUES ('7413acf23b56c906aedb5a36fb75bd3a', 'f6817f48af4fb3af11b9e8bf182f618b', 'a4fc7b64b01a224da066bb16230f9c5a', NULL);
INSERT INTO `sys_role_permission` VALUES ('75002588591820806', '16457350655250432', '5129710648430592', NULL);
INSERT INTO `sys_role_permission` VALUES ('75002588604403712', '16457350655250432', '5129710648430593', NULL);
INSERT INTO `sys_role_permission` VALUES ('75002588612792320', '16457350655250432', '40238597734928384', NULL);
INSERT INTO `sys_role_permission` VALUES ('75002588625375232', '16457350655250432', '57009744761589760', NULL);
INSERT INTO `sys_role_permission` VALUES ('75002588633763840', '16457350655250432', '16392452747300864', NULL);
INSERT INTO `sys_role_permission` VALUES ('75002588637958144', '16457350655250432', '16392767785668608', NULL);
INSERT INTO `sys_role_permission` VALUES ('75002588650541056', '16457350655250432', '16439068543946752', NULL);
INSERT INTO `sys_role_permission` VALUES ('76a54a8cc609754360bf9f57e7dbb2db', 'f6817f48af4fb3af11b9e8bf182f618b', 'c65321e57b7949b7a975313220de0422', NULL);
INSERT INTO `sys_role_permission` VALUES ('77277779875336192', '496138616573952', '5129710648430592', NULL);
INSERT INTO `sys_role_permission` VALUES ('77277780043108352', '496138616573952', '5129710648430593', NULL);
INSERT INTO `sys_role_permission` VALUES ('77277780055691264', '496138616573952', '15701400130424832', NULL);
INSERT INTO `sys_role_permission` VALUES ('77277780064079872', '496138616573952', '16678126574637056', NULL);
INSERT INTO `sys_role_permission` VALUES ('77277780072468480', '496138616573952', '15701915807518720', NULL);
INSERT INTO `sys_role_permission` VALUES ('77277780076662784', '496138616573952', '15708892205944832', NULL);
INSERT INTO `sys_role_permission` VALUES ('77277780085051392', '496138616573952', '16678447719911424', NULL);
INSERT INTO `sys_role_permission` VALUES ('77277780089245696', '496138616573952', '25014528525733888', NULL);
INSERT INTO `sys_role_permission` VALUES ('77277780097634304', '496138616573952', '56898976661639168', NULL);
INSERT INTO `sys_role_permission` VALUES ('77277780135383040', '496138616573952', '40238597734928384', NULL);
INSERT INTO `sys_role_permission` VALUES ('77277780139577344', '496138616573952', '45235621697949696', NULL);
INSERT INTO `sys_role_permission` VALUES ('77277780147965952', '496138616573952', '45235787867885568', NULL);
INSERT INTO `sys_role_permission` VALUES ('77277780156354560', '496138616573952', '45235939278065664', NULL);
INSERT INTO `sys_role_permission` VALUES ('77277780164743168', '496138616573952', '43117268627886080', NULL);
INSERT INTO `sys_role_permission` VALUES ('77277780168937472', '496138616573952', '45236734832676864', NULL);
INSERT INTO `sys_role_permission` VALUES ('77277780181520384', '496138616573952', '45237010692050944', NULL);
INSERT INTO `sys_role_permission` VALUES ('77277780189908992', '496138616573952', '45237170029465600', NULL);
INSERT INTO `sys_role_permission` VALUES ('77277780198297600', '496138616573952', '57009544286441472', NULL);
INSERT INTO `sys_role_permission` VALUES ('77277780206686208', '496138616573952', '57009744761589760', NULL);
INSERT INTO `sys_role_permission` VALUES ('77277780215074816', '496138616573952', '57009981228060672', NULL);
INSERT INTO `sys_role_permission` VALUES ('77277780219269120', '496138616573952', '56309618086776832', NULL);
INSERT INTO `sys_role_permission` VALUES ('77277780227657728', '496138616573952', '57212882168844288', NULL);
INSERT INTO `sys_role_permission` VALUES ('77277780236046336', '496138616573952', '61560041605435392', NULL);
INSERT INTO `sys_role_permission` VALUES ('77277780244434944', '496138616573952', '61560275261722624', NULL);
INSERT INTO `sys_role_permission` VALUES ('77277780257017856', '496138616573952', '61560480518377472', NULL);
INSERT INTO `sys_role_permission` VALUES ('77277780265406464', '496138616573952', '44986029924421632', NULL);
INSERT INTO `sys_role_permission` VALUES ('77277780324126720', '496138616573952', '45235228800716800', NULL);
INSERT INTO `sys_role_permission` VALUES ('77277780332515328', '496138616573952', '45069342940860416', NULL);
INSERT INTO `sys_role_permission` VALUES ('77277780340903937', '496138616573952', '5129710648430594', NULL);
INSERT INTO `sys_role_permission` VALUES ('77277780349292544', '496138616573952', '16687383932047360', NULL);
INSERT INTO `sys_role_permission` VALUES ('77277780357681152', '496138616573952', '16689632049631232', NULL);
INSERT INTO `sys_role_permission` VALUES ('77277780366069760', '496138616573952', '16689745006432256', NULL);
INSERT INTO `sys_role_permission` VALUES ('77277780370264064', '496138616573952', '16689883993083904', NULL);
INSERT INTO `sys_role_permission` VALUES ('77277780374458369', '496138616573952', '16690313745666048', NULL);
INSERT INTO `sys_role_permission` VALUES ('77277780387041280', '496138616573952', '5129710648430595', NULL);
INSERT INTO `sys_role_permission` VALUES ('77277780395429888', '496138616573952', '16694861252005888', NULL);
INSERT INTO `sys_role_permission` VALUES ('77277780403818496', '496138616573952', '16695107491205120', NULL);
INSERT INTO `sys_role_permission` VALUES ('77277780412207104', '496138616573952', '16695243126607872', NULL);
INSERT INTO `sys_role_permission` VALUES ('77277780420595712', '496138616573952', '75002207560273920', NULL);
INSERT INTO `sys_role_permission` VALUES ('77277780428984320', '496138616573952', '76215889006956544', NULL);
INSERT INTO `sys_role_permission` VALUES ('77277780433178624', '496138616573952', '76216071333351424', NULL);
INSERT INTO `sys_role_permission` VALUES ('77277780441567232', '496138616573952', '76216264070008832', NULL);
INSERT INTO `sys_role_permission` VALUES ('77277780449955840', '496138616573952', '76216459709124608', NULL);
INSERT INTO `sys_role_permission` VALUES ('77277780458344448', '496138616573952', '76216594207870976', NULL);
INSERT INTO `sys_role_permission` VALUES ('77277780466733056', '496138616573952', '76216702639017984', NULL);
INSERT INTO `sys_role_permission` VALUES ('77277780475121664', '496138616573952', '58480609315524608', NULL);
INSERT INTO `sys_role_permission` VALUES ('77277780483510272', '496138616573952', '61394706252173312', NULL);
INSERT INTO `sys_role_permission` VALUES ('77277780491898880', '496138616573952', '61417744146370560', NULL);
INSERT INTO `sys_role_permission` VALUES ('77277780496093184', '496138616573952', '76606430504816640', NULL);
INSERT INTO `sys_role_permission` VALUES ('77277780504481792', '496138616573952', '76914082455752704', NULL);
INSERT INTO `sys_role_permission` VALUES ('77277780508676097', '496138616573952', '76607201262702592', NULL);
INSERT INTO `sys_role_permission` VALUES ('77277780517064704', '496138616573952', '39915540965232640', NULL);
INSERT INTO `sys_role_permission` VALUES ('77277780525453312', '496138616573952', '41370251991977984', NULL);
INSERT INTO `sys_role_permission` VALUES ('77277780538036224', '496138616573952', '45264987354042368', NULL);
INSERT INTO `sys_role_permission` VALUES ('77277780546424832', '496138616573952', '45265487029866496', NULL);
INSERT INTO `sys_role_permission` VALUES ('77277780554813440', '496138616573952', '45265762415284224', NULL);
INSERT INTO `sys_role_permission` VALUES ('77277780559007744', '496138616573952', '45265886315024384', NULL);
INSERT INTO `sys_role_permission` VALUES ('77277780567396352', '496138616573952', '45266070000373760', NULL);
INSERT INTO `sys_role_permission` VALUES ('77277780571590656', '496138616573952', '41363147411427328', NULL);
INSERT INTO `sys_role_permission` VALUES ('77277780579979264', '496138616573952', '41363537456533504', NULL);
INSERT INTO `sys_role_permission` VALUES ('77277780588367872', '496138616573952', '41364927394353152', NULL);
INSERT INTO `sys_role_permission` VALUES ('77277780596756480', '496138616573952', '41371711400054784', NULL);
INSERT INTO `sys_role_permission` VALUES ('77277780605145088', '496138616573952', '41469219249852416', NULL);
INSERT INTO `sys_role_permission` VALUES ('77277780613533696', '496138616573952', '39916171171991552', NULL);
INSERT INTO `sys_role_permission` VALUES ('77277780621922304', '496138616573952', '39918482854252544', NULL);
INSERT INTO `sys_role_permission` VALUES ('77277780630310912', '496138616573952', '41373430515240960', NULL);
INSERT INTO `sys_role_permission` VALUES ('77277780718391296', '496138616573952', '41375330996326400', NULL);
INSERT INTO `sys_role_permission` VALUES ('77277780722585600', '496138616573952', '63741744973352960', NULL);
INSERT INTO `sys_role_permission` VALUES ('77277780730974208', '496138616573952', '42082442672082944', NULL);
INSERT INTO `sys_role_permission` VALUES ('77277780739362816', '496138616573952', '41376192166629376', NULL);
INSERT INTO `sys_role_permission` VALUES ('77277780747751424', '496138616573952', '41377034236071936', NULL);
INSERT INTO `sys_role_permission` VALUES ('77277780756140032', '496138616573952', '56911328312299520', NULL);
INSERT INTO `sys_role_permission` VALUES ('77277780764528640', '496138616573952', '41378916912336896', NULL);
INSERT INTO `sys_role_permission` VALUES ('77277780768722944', '496138616573952', '63482475359244288', NULL);
INSERT INTO `sys_role_permission` VALUES ('77277780772917249', '496138616573952', '64290663792906240', NULL);
INSERT INTO `sys_role_permission` VALUES ('77277780785500160', '496138616573952', '66790433014943744', NULL);
INSERT INTO `sys_role_permission` VALUES ('77277780789694464', '496138616573952', '42087054753927168', NULL);
INSERT INTO `sys_role_permission` VALUES ('77277780798083072', '496138616573952', '67027338952445952', NULL);
INSERT INTO `sys_role_permission` VALUES ('77277780806471680', '496138616573952', '67027909637836800', NULL);
INSERT INTO `sys_role_permission` VALUES ('77277780810665985', '496138616573952', '67042515441684480', NULL);
INSERT INTO `sys_role_permission` VALUES ('77277780823248896', '496138616573952', '67082402312228864', NULL);
INSERT INTO `sys_role_permission` VALUES ('77277780827443200', '496138616573952', '16392452747300864', NULL);
INSERT INTO `sys_role_permission` VALUES ('77277780835831808', '496138616573952', '16392767785668608', NULL);
INSERT INTO `sys_role_permission` VALUES ('77277780840026112', '496138616573952', '16438800255291392', NULL);
INSERT INTO `sys_role_permission` VALUES ('77277780844220417', '496138616573952', '16438962738434048', NULL);
INSERT INTO `sys_role_permission` VALUES ('77277780852609024', '496138616573952', '16439068543946752', NULL);
INSERT INTO `sys_role_permission` VALUES ('77277860062040064', '496138616573953', '5129710648430592', NULL);
INSERT INTO `sys_role_permission` VALUES ('77277860070428672', '496138616573953', '5129710648430593', NULL);
INSERT INTO `sys_role_permission` VALUES ('77277860078817280', '496138616573953', '40238597734928384', NULL);
INSERT INTO `sys_role_permission` VALUES ('77277860091400192', '496138616573953', '43117268627886080', NULL);
INSERT INTO `sys_role_permission` VALUES ('77277860099788800', '496138616573953', '57009744761589760', NULL);
INSERT INTO `sys_role_permission` VALUES ('77277860112371712', '496138616573953', '56309618086776832', NULL);
INSERT INTO `sys_role_permission` VALUES ('77277860120760320', '496138616573953', '44986029924421632', NULL);
INSERT INTO `sys_role_permission` VALUES ('77277860129148928', '496138616573953', '5129710648430594', NULL);
INSERT INTO `sys_role_permission` VALUES ('77277860141731840', '496138616573953', '5129710648430595', NULL);
INSERT INTO `sys_role_permission` VALUES ('77277860150120448', '496138616573953', '75002207560273920', NULL);
INSERT INTO `sys_role_permission` VALUES ('77277860158509056', '496138616573953', '58480609315524608', NULL);
INSERT INTO `sys_role_permission` VALUES ('77277860162703360', '496138616573953', '76606430504816640', NULL);
INSERT INTO `sys_role_permission` VALUES ('77277860171091968', '496138616573953', '76914082455752704', NULL);
INSERT INTO `sys_role_permission` VALUES ('77277860179480576', '496138616573953', '76607201262702592', NULL);
INSERT INTO `sys_role_permission` VALUES ('77277860187869184', '496138616573953', '39915540965232640', NULL);
INSERT INTO `sys_role_permission` VALUES ('77277860196257792', '496138616573953', '41370251991977984', NULL);
INSERT INTO `sys_role_permission` VALUES ('77277860204646400', '496138616573953', '41363147411427328', NULL);
INSERT INTO `sys_role_permission` VALUES ('77277860208840704', '496138616573953', '41371711400054784', NULL);
INSERT INTO `sys_role_permission` VALUES ('77277860213035009', '496138616573953', '39916171171991552', NULL);
INSERT INTO `sys_role_permission` VALUES ('77277860221423616', '496138616573953', '39918482854252544', NULL);
INSERT INTO `sys_role_permission` VALUES ('77277860225617920', '496138616573953', '41373430515240960', NULL);
INSERT INTO `sys_role_permission` VALUES ('77277860234006528', '496138616573953', '41375330996326400', NULL);
INSERT INTO `sys_role_permission` VALUES ('77277860242395136', '496138616573953', '63741744973352960', NULL);
INSERT INTO `sys_role_permission` VALUES ('77277860250783744', '496138616573953', '42082442672082944', NULL);
INSERT INTO `sys_role_permission` VALUES ('77277860254978048', '496138616573953', '41376192166629376', NULL);
INSERT INTO `sys_role_permission` VALUES ('77277860263366656', '496138616573953', '41377034236071936', NULL);
INSERT INTO `sys_role_permission` VALUES ('77277860271755264', '496138616573953', '56911328312299520', NULL);
INSERT INTO `sys_role_permission` VALUES ('77277860313698304', '496138616573953', '41378916912336896', NULL);
INSERT INTO `sys_role_permission` VALUES ('77277860322086912', '496138616573953', '63482475359244288', NULL);
INSERT INTO `sys_role_permission` VALUES ('77277860326281216', '496138616573953', '64290663792906240', NULL);
INSERT INTO `sys_role_permission` VALUES ('77277860334669824', '496138616573953', '66790433014943744', NULL);
INSERT INTO `sys_role_permission` VALUES ('77277860343058432', '496138616573953', '42087054753927168', NULL);
INSERT INTO `sys_role_permission` VALUES ('77277860347252736', '496138616573953', '67027338952445952', NULL);
INSERT INTO `sys_role_permission` VALUES ('77277860351447041', '496138616573953', '67027909637836800', NULL);
INSERT INTO `sys_role_permission` VALUES ('77277860359835648', '496138616573953', '67042515441684480', NULL);
INSERT INTO `sys_role_permission` VALUES ('77277860364029952', '496138616573953', '67082402312228864', NULL);
INSERT INTO `sys_role_permission` VALUES ('77277860368224256', '496138616573953', '16392452747300864', NULL);
INSERT INTO `sys_role_permission` VALUES ('77277860372418560', '496138616573953', '16392767785668608', NULL);
INSERT INTO `sys_role_permission` VALUES ('77277860376612865', '496138616573953', '16438800255291392', NULL);
INSERT INTO `sys_role_permission` VALUES ('77277860385001472', '496138616573953', '16438962738434048', NULL);
INSERT INTO `sys_role_permission` VALUES ('77277860389195776', '496138616573953', '16439068543946752', NULL);
INSERT INTO `sys_role_permission` VALUES ('7750f9be48ee09cd561fce718219a3e2', 'ee8626f80f7c2619917b6236f3a7f02b', '882a73768cfd7f78f3a37584f7299656', NULL);
INSERT INTO `sys_role_permission` VALUES ('7a5d31ba48fe3fb1266bf186dc5f7ba7', '52b0cf022ac4187b2a70dfa4f8b2d940', '58857ff846e61794c69208e9d3a85466', NULL);
INSERT INTO `sys_role_permission` VALUES ('7a6bca9276c128309c80d21e795c66c6', 'f6817f48af4fb3af11b9e8bf182f618b', '54097c6a3cf50fad0793a34beff1efdf', NULL);
INSERT INTO `sys_role_permission` VALUES ('7ca833caa5eac837b7200d8b6de8b2e3', 'f6817f48af4fb3af11b9e8bf182f618b', 'fedfbf4420536cacc0218557d263dfea', NULL);
INSERT INTO `sys_role_permission` VALUES ('7d2ea745950be3357747ec7750c31c57', 'ee8626f80f7c2619917b6236f3a7f02b', '2a470fc0c3954d9dbb61de6d80846549', NULL);
INSERT INTO `sys_role_permission` VALUES ('7de42bdc0b8c5446b7d428c66a7abc12', '52b0cf022ac4187b2a70dfa4f8b2d940', '54dd5457a3190740005c1bfec55b1c34', NULL);
INSERT INTO `sys_role_permission` VALUES ('7e19d90cec0dd87aaef351b9ff8f4902', '646c628b2b8295fbdab2d34044de0354', 'f9d3f4f27653a71c52faa9fb8070fbe7', NULL);
INSERT INTO `sys_role_permission` VALUES ('7f862c47003eb20e8bad05f506371f92', 'ee8626f80f7c2619917b6236f3a7f02b', 'd7d6e2e4e2934f2c9385a623fd98c6f3', NULL);
INSERT INTO `sys_role_permission` VALUES ('812ed54661b1a24b81b58974691a73f5', 'e51758fa916c881624b046d26bd09230', 'e6bfd1fcabfd7942fdd05f076d1dad38', NULL);
INSERT INTO `sys_role_permission` VALUES ('83f704524b21b6a3ae324b8736c65333', 'ee8626f80f7c2619917b6236f3a7f02b', '7ac9eb9ccbde2f7a033cd4944272bf1e', NULL);
INSERT INTO `sys_role_permission` VALUES ('84d32474316a43b01256d6644e6e7751', 'ee8626f80f7c2619917b6236f3a7f02b', 'ec8d607d0156e198b11853760319c646', NULL);
INSERT INTO `sys_role_permission` VALUES ('84eac2f113c23737128fb099d1d1da89', 'f6817f48af4fb3af11b9e8bf182f618b', '03dc3d93261dda19fc86dd7ca486c6cf', NULL);
INSERT INTO `sys_role_permission` VALUES ('85755a6c0bdff78b3860b52d35310c7f', 'e51758fa916c881624b046d26bd09230', 'c65321e57b7949b7a975313220de0422', NULL);
INSERT INTO `sys_role_permission` VALUES ('86060e2867a5049d8a80d9fe5d8bc28b', 'f6817f48af4fb3af11b9e8bf182f618b', '765dd244f37b804e3d00f475fd56149b', NULL);
INSERT INTO `sys_role_permission` VALUES ('8703a2410cddb713c33232ce16ec04b9', 'ee8626f80f7c2619917b6236f3a7f02b', '1367a93f2c410b169faa7abcbad2f77c', NULL);
INSERT INTO `sys_role_permission` VALUES ('884f147c20e003cc80ed5b7efa598cbe', 'f6817f48af4fb3af11b9e8bf182f618b', 'e5973686ed495c379d829ea8b2881fc6', NULL);
INSERT INTO `sys_role_permission` VALUES ('885c1a827383e5b2c6c4f8ca72a7b493', 'ee8626f80f7c2619917b6236f3a7f02b', '4148ec82b6acd69f470bea75fe41c357', NULL);
INSERT INTO `sys_role_permission` VALUES ('8a60df8d8b4c9ee5fa63f48aeee3ec00', '1750a8fb3e6d90cb7957c02de1dc8e59', 'd7d6e2e4e2934f2c9385a623fd98c6f3', NULL);
INSERT INTO `sys_role_permission` VALUES ('8b09925bdc194ab7f3559cd3a7ea0507', 'f6817f48af4fb3af11b9e8bf182f618b', 'ebb9d82ea16ad864071158e0c449d186', NULL);
INSERT INTO `sys_role_permission` VALUES ('8b1e326791375f325d3e6b797753b65e', 'ee8626f80f7c2619917b6236f3a7f02b', '2dbbafa22cda07fa5d169d741b81fe12', NULL);
INSERT INTO `sys_role_permission` VALUES ('8ce1022dac4e558ff9694600515cf510', '1750a8fb3e6d90cb7957c02de1dc8e59', '08e6b9dc3c04489c8e1ff2ce6f105aa4', NULL);
INSERT INTO `sys_role_permission` VALUES ('8d154c2382a8ae5c8d1b84bd38df2a93', 'f6817f48af4fb3af11b9e8bf182f618b', 'd86f58e7ab516d3bc6bfb1fe10585f97', NULL);
INSERT INTO `sys_role_permission` VALUES ('8d848ca7feec5b7ebb3ecb32b2c8857a', '52b0cf022ac4187b2a70dfa4f8b2d940', '4148ec82b6acd69f470bea75fe41c357', NULL);
INSERT INTO `sys_role_permission` VALUES ('8dd64f65a1014196078d0882f767cd85', 'f6817f48af4fb3af11b9e8bf182f618b', 'e3c13679c73a4f829bcff2aba8fd68b1', NULL);
INSERT INTO `sys_role_permission` VALUES ('8e3dc1671abad4f3c83883b194d2e05a', 'f6817f48af4fb3af11b9e8bf182f618b', 'b1cb0a3fedf7ed0e4653cb5a229837ee', NULL);
INSERT INTO `sys_role_permission` VALUES ('8eec2c510f1ac9c5eee26c041b1f00ca', 'ee8626f80f7c2619917b6236f3a7f02b', '58857ff846e61794c69208e9d3a85466', NULL);
INSERT INTO `sys_role_permission` VALUES ('8f762ff80253f634b08cf59a77742ba4', 'ee8626f80f7c2619917b6236f3a7f02b', '9502685863ab87f0ad1134142788a385', NULL);
INSERT INTO `sys_role_permission` VALUES ('903b790e6090414343502c6dc393b7c9', 'ee8626f80f7c2619917b6236f3a7f02b', 'de13e0f6328c069748de7399fcc1dbbd', NULL);
INSERT INTO `sys_role_permission` VALUES ('905bf419332ebcb83863603b3ebe30f0', 'f6817f48af4fb3af11b9e8bf182f618b', '8fb8172747a78756c11916216b8b8066', NULL);
INSERT INTO `sys_role_permission` VALUES ('90996d56357730e173e636b99fc48bea', 'ee8626f80f7c2619917b6236f3a7f02b', 'fb07ca05a3e13674dbf6d3245956da2e', NULL);
INSERT INTO `sys_role_permission` VALUES ('90e1c607a0631364eec310f3cc4acebd', 'ee8626f80f7c2619917b6236f3a7f02b', '4f66409ef3bbd69c1d80469d6e2a885e', NULL);
INSERT INTO `sys_role_permission` VALUES ('9264104cee9b10c96241d527b2d0346d', '1750a8fb3e6d90cb7957c02de1dc8e59', '54dd5457a3190740005c1bfec55b1c34', NULL);
INSERT INTO `sys_role_permission` VALUES ('9380121ca9cfee4b372194630fce150e', 'f6817f48af4fb3af11b9e8bf182f618b', '65a8f489f25a345836b7f44b1181197a', NULL);
INSERT INTO `sys_role_permission` VALUES ('94911fef73a590f6824105ebf9b6cab3', 'f6817f48af4fb3af11b9e8bf182f618b', '8b3bff2eee6f1939147f5c68292a1642', NULL);
INSERT INTO `sys_role_permission` VALUES ('9700d20dbc1ae3cbf7de1c810b521fe6', 'f6817f48af4fb3af11b9e8bf182f618b', 'ec8d607d0156e198b11853760319c646', NULL);
INSERT INTO `sys_role_permission` VALUES ('980171fda43adfe24840959b1d048d4d', 'f6817f48af4fb3af11b9e8bf182f618b', 'd7d6e2e4e2934f2c9385a623fd98c6f3', NULL);
INSERT INTO `sys_role_permission` VALUES ('987c23b70873bd1d6dca52f30aafd8c2', 'f6817f48af4fb3af11b9e8bf182f618b', '00a2a0ae65cdca5e93209cdbde97cbe6', NULL);
INSERT INTO `sys_role_permission` VALUES ('98f02353f91dd569e3c6b8fd6b4f4034', 'ee8626f80f7c2619917b6236f3a7f02b', '6531cf3421b1265aeeeabaab5e176e6d', NULL);
INSERT INTO `sys_role_permission` VALUES ('9b2ad767f9861e64a20b097538feafd3', 'f6817f48af4fb3af11b9e8bf182f618b', '73678f9daa45ed17a3674131b03432fb', NULL);
INSERT INTO `sys_role_permission` VALUES ('9d8772c310b675ae43eacdbc6c7fa04a', 'a799c3b1b12dd3ed4bd046bfaef5fe6e', '1663f3faba244d16c94552f849627d84', NULL);
INSERT INTO `sys_role_permission` VALUES ('9d980ec0489040e631a9c24a6af42934', 'f6817f48af4fb3af11b9e8bf182f618b', '05b3c82ddb2536a4a5ee1a4c46b5abef', NULL);
INSERT INTO `sys_role_permission` VALUES ('9f8311ecccd44e079723098cf2ffe1cc', '1750a8fb3e6d90cb7957c02de1dc8e59', '693ce69af3432bd00be13c3971a57961', NULL);
INSERT INTO `sys_role_permission` VALUES ('a034ed7c38c996b880d3e78f586fe0ae', 'f6817f48af4fb3af11b9e8bf182f618b', 'c89018ea6286e852b424466fd92a2ffc', NULL);
INSERT INTO `sys_role_permission` VALUES ('a098e2acc3f90316f161f6648d085640', 'ee8626f80f7c2619917b6236f3a7f02b', 'e6bfd1fcabfd7942fdd05f076d1dad38', NULL);
INSERT INTO `sys_role_permission` VALUES ('a307a9349ad64a2eff8ab69582fa9be4', 'f6817f48af4fb3af11b9e8bf182f618b', '0620e402857b8c5b605e1ad9f4b89350', NULL);
INSERT INTO `sys_role_permission` VALUES ('a5d25fdb3c62904a8474182706ce11a0', 'f6817f48af4fb3af11b9e8bf182f618b', '418964ba087b90a84897b62474496b93', NULL);
INSERT INTO `sys_role_permission` VALUES ('a66feaaf128417ad762e946abccf27ec', 'ee8626f80f7c2619917b6236f3a7f02b', 'c6cf95444d80435eb37b2f9db3971ae6', NULL);
INSERT INTO `sys_role_permission` VALUES ('a72c31a3913c736d4eca11d13be99183', 'e51758fa916c881624b046d26bd09230', 'a44c30db536349e91106223957e684eb', NULL);
INSERT INTO `sys_role_permission` VALUES ('a7ab87eac0f8fafa2efa4b1f9351923f', 'ee8626f80f7c2619917b6236f3a7f02b', 'fedfbf4420536cacc0218557d263dfea', NULL);
INSERT INTO `sys_role_permission` VALUES ('abdc324a2df9f13ee6e73d44c6e62bc8', 'ee8626f80f7c2619917b6236f3a7f02b', 'f1cb187abf927c88b89470d08615f5ac', NULL);
INSERT INTO `sys_role_permission` VALUES ('acacce4417e5d7f96a9c3be2ded5b4be', 'f6817f48af4fb3af11b9e8bf182f618b', 'f9d3f4f27653a71c52faa9fb8070fbe7', NULL);
INSERT INTO `sys_role_permission` VALUES ('ae1852fb349d8513eb3fdc173da3ee56', 'f6817f48af4fb3af11b9e8bf182f618b', '8d4683aacaa997ab86b966b464360338', NULL);
INSERT INTO `sys_role_permission` VALUES ('aefc8c22e061171806e59cd222f6b7e1', '52b0cf022ac4187b2a70dfa4f8b2d940', 'e8af452d8948ea49d37c934f5100ae6a', NULL);
INSERT INTO `sys_role_permission` VALUES ('af60ac8fafd807ed6b6b354613b9ccbc', 'f6817f48af4fb3af11b9e8bf182f618b', '58857ff846e61794c69208e9d3a85466', NULL);
INSERT INTO `sys_role_permission` VALUES ('b0c8a20800b8bf1ebdd7be473bceb44f', 'f6817f48af4fb3af11b9e8bf182f618b', '58b9204feaf07e47284ddb36cd2d8468', NULL);
INSERT INTO `sys_role_permission` VALUES ('b128ebe78fa5abb54a3a82c6689bdca3', 'f6817f48af4fb3af11b9e8bf182f618b', 'aedbf679b5773c1f25e9f7b10111da73', NULL);
INSERT INTO `sys_role_permission` VALUES ('b131ebeafcfd059f3c7e542606ea9ff5', 'ee8626f80f7c2619917b6236f3a7f02b', 'e5973686ed495c379d829ea8b2881fc6', NULL);
INSERT INTO `sys_role_permission` VALUES ('b21b07951bb547b09cc85624a841aea0', 'f6817f48af4fb3af11b9e8bf182f618b', '4356a1a67b564f0988a484f5531fd4d9', NULL);
INSERT INTO `sys_role_permission` VALUES ('b2b2dcfff6986d3d7f890ea62d474651', 'ee8626f80f7c2619917b6236f3a7f02b', '200006f0edf145a2b50eacca07585451', NULL);
INSERT INTO `sys_role_permission` VALUES ('b495a46fa0e0d4637abe0db7fd12fe1a', 'ee8626f80f7c2619917b6236f3a7f02b', '717f6bee46f44a3897eca9abd6e2ec44', NULL);
INSERT INTO `sys_role_permission` VALUES ('b64c4ab9cd9a2ea8ac1e9db5fb7cf522', 'f6817f48af4fb3af11b9e8bf182f618b', '2aeddae571695cd6380f6d6d334d6e7d', NULL);
INSERT INTO `sys_role_permission` VALUES ('bbec16ad016efec9ea2def38f4d3d9dc', 'f6817f48af4fb3af11b9e8bf182f618b', '13212d3416eb690c2e1d5033166ff47a', NULL);
INSERT INTO `sys_role_permission` VALUES ('bd30561f141f07827b836878137fddd8', 'e51758fa916c881624b046d26bd09230', '65a8f489f25a345836b7f44b1181197a', NULL);
INSERT INTO `sys_role_permission` VALUES ('be8e5a9080569e59863f20c4c57a8e22', 'f6817f48af4fb3af11b9e8bf182f618b', '22d6a3d39a59dd7ea9a30acfa6bfb0a5', NULL);
INSERT INTO `sys_role_permission` VALUES ('bea2986432079d89203da888d99b3f16', 'f6817f48af4fb3af11b9e8bf182f618b', '54dd5457a3190740005c1bfec55b1c34', NULL);
INSERT INTO `sys_role_permission` VALUES ('c09373ebfc73fb5740db5ff02cba4f91', 'f6817f48af4fb3af11b9e8bf182f618b', '339329ed54cf255e1f9392e84f136901', NULL);
INSERT INTO `sys_role_permission` VALUES ('c56fb1658ee5f7476380786bf5905399', 'f6817f48af4fb3af11b9e8bf182f618b', 'de13e0f6328c069748de7399fcc1dbbd', NULL);
INSERT INTO `sys_role_permission` VALUES ('c689539d20a445b0896270290c58d01f', 'e51758fa916c881624b046d26bd09230', '13212d3416eb690c2e1d5033166ff47a', NULL);
INSERT INTO `sys_role_permission` VALUES ('c6fee38d293b9d0596436a0cbd205070', 'f6817f48af4fb3af11b9e8bf182f618b', '4f84f9400e5e92c95f05b554724c2b58', NULL);
INSERT INTO `sys_role_permission` VALUES ('c8571839e6b14796e661f3e2843b80b6', 'ee8626f80f7c2619917b6236f3a7f02b', '45c966826eeff4c99b8f8ebfe74511fc', NULL);
INSERT INTO `sys_role_permission` VALUES ('c90b0b01c7ca454d2a1cb7408563e696', 'f6817f48af4fb3af11b9e8bf182f618b', '882a73768cfd7f78f3a37584f7299656', NULL);
INSERT INTO `sys_role_permission` VALUES ('c9d35261cccd67ab2932107a0967a7d7', 'e51758fa916c881624b046d26bd09230', 'b4dfc7d5dd9e8d5b6dd6d4579b1aa559', NULL);
INSERT INTO `sys_role_permission` VALUES ('ced80e43584ce15e97bb07298e93020d', 'e51758fa916c881624b046d26bd09230', '45c966826eeff4c99b8f8ebfe74511fc', NULL);
INSERT INTO `sys_role_permission` VALUES ('cf1feb1bf69eafc982295ad6c9c8d698', 'f6817f48af4fb3af11b9e8bf182f618b', 'a2b11669e98c5fe54a53c3e3c4f35d14', NULL);
INSERT INTO `sys_role_permission` VALUES ('cf2ef620217673e4042f695743294f01', 'f6817f48af4fb3af11b9e8bf182f618b', '717f6bee46f44a3897eca9abd6e2ec44', NULL);
INSERT INTO `sys_role_permission` VALUES ('cf43895aef7fc684669483ab00ef2257', 'f6817f48af4fb3af11b9e8bf182f618b', '700b7f95165c46cc7a78bf227aa8fed3', NULL);
INSERT INTO `sys_role_permission` VALUES ('d03d792b0f312e7b490afc5cec3dd6c5', 'e51758fa916c881624b046d26bd09230', '8fb8172747a78756c11916216b8b8066', NULL);
INSERT INTO `sys_role_permission` VALUES ('d281a95b8f293d0fa2a136f46c4e0b10', 'f6817f48af4fb3af11b9e8bf182f618b', '5c8042bd6c601270b2bbd9b20bccc68b', NULL);
INSERT INTO `sys_role_permission` VALUES ('d37ad568e26f46ed0feca227aa9c2ffa', 'f6817f48af4fb3af11b9e8bf182f618b', '9502685863ab87f0ad1134142788a385', NULL);
INSERT INTO `sys_role_permission` VALUES ('d3ddcacee1acdfaa0810618b74e38ef2', 'f6817f48af4fb3af11b9e8bf182f618b', 'c6cf95444d80435eb37b2f9db3971ae6', NULL);
INSERT INTO `sys_role_permission` VALUES ('d3fe195d59811531c05d31d8436f5c8b', '1750a8fb3e6d90cb7957c02de1dc8e59', 'e8af452d8948ea49d37c934f5100ae6a', NULL);
INSERT INTO `sys_role_permission` VALUES ('d5267597a4450f06d49d2fb63859641a', 'e51758fa916c881624b046d26bd09230', '2dbbafa22cda07fa5d169d741b81fe12', NULL);
INSERT INTO `sys_role_permission` VALUES ('d83282192a69514cfe6161b3087ff962', 'f6817f48af4fb3af11b9e8bf182f618b', '53a9230444d33de28aa11cc108fb1dba', NULL);
INSERT INTO `sys_role_permission` VALUES ('d8a5c9079df12090e108e21be94b4fd7', 'f6817f48af4fb3af11b9e8bf182f618b', '078f9558cdeab239aecb2bda1a8ed0d1', NULL);
INSERT INTO `sys_role_permission` VALUES ('dbc5dd836d45c5bc7bc94b22596ab956', 'f6817f48af4fb3af11b9e8bf182f618b', '1939e035e803a99ceecb6f5563570fb2', NULL);
INSERT INTO `sys_role_permission` VALUES ('dc83bb13c0e8c930e79d28b2db26f01f', 'f6817f48af4fb3af11b9e8bf182f618b', '63b551e81c5956d5c861593d366d8c57', NULL);
INSERT INTO `sys_role_permission` VALUES ('dc8fd3f79bd85bd832608b42167a1c71', 'f6817f48af4fb3af11b9e8bf182f618b', '91c23960fab49335831cf43d820b0a61', NULL);
INSERT INTO `sys_role_permission` VALUES ('de82e89b8b60a3ea99be5348f565c240', 'f6817f48af4fb3af11b9e8bf182f618b', '56ca78fe0f22d815fabc793461af67b8', NULL);
INSERT INTO `sys_role_permission` VALUES ('de8f43229e351d34af3c95b1b9f0a15d', 'f6817f48af4fb3af11b9e8bf182f618b', 'a400e4f4d54f79bf5ce160ae432231af', NULL);
INSERT INTO `sys_role_permission` VALUES ('e258ca8bf7ee168b93bfee739668eb15', 'ee8626f80f7c2619917b6236f3a7f02b', 'fb367426764077dcf94640c843733985', NULL);
INSERT INTO `sys_role_permission` VALUES ('e339f7db7418a4fd2bd2c113f1182186', 'ee8626f80f7c2619917b6236f3a7f02b', 'b1cb0a3fedf7ed0e4653cb5a229837ee', NULL);
INSERT INTO `sys_role_permission` VALUES ('e3e922673f4289b18366bb51b6200f17', '52b0cf022ac4187b2a70dfa4f8b2d940', '45c966826eeff4c99b8f8ebfe74511fc', NULL);
INSERT INTO `sys_role_permission` VALUES ('e7467726ee72235baaeb47df04a35e73', 'f6817f48af4fb3af11b9e8bf182f618b', 'e08cb190ef230d5d4f03824198773950', NULL);
INSERT INTO `sys_role_permission` VALUES ('eaef4486f1c9b0408580bbfa2037eb66', 'f6817f48af4fb3af11b9e8bf182f618b', '2a470fc0c3954d9dbb61de6d80846549', NULL);
INSERT INTO `sys_role_permission` VALUES ('ec4bc97829ab56afd83f428b6dc37ff6', 'f6817f48af4fb3af11b9e8bf182f618b', '200006f0edf145a2b50eacca07585451', NULL);
INSERT INTO `sys_role_permission` VALUES ('ec846a3f85fdb6813e515be71f11b331', 'f6817f48af4fb3af11b9e8bf182f618b', '732d48f8e0abe99fe6a23d18a3171cd1', NULL);
INSERT INTO `sys_role_permission` VALUES ('ec93bb06f5be4c1f19522ca78180e2ef', 'f6817f48af4fb3af11b9e8bf182f618b', '265de841c58907954b8877fb85212622', NULL);
INSERT INTO `sys_role_permission` VALUES ('ecdd72fe694e6bba9c1d9fc925ee79de', 'f6817f48af4fb3af11b9e8bf182f618b', '45c966826eeff4c99b8f8ebfe74511fc', NULL);
INSERT INTO `sys_role_permission` VALUES ('edefd8d468f5727db465cf1b860af474', 'f6817f48af4fb3af11b9e8bf182f618b', '6ad53fd1b220989a8b71ff482d683a5a', NULL);
INSERT INTO `sys_role_permission` VALUES ('ef8bdd20d29447681ec91d3603e80c7b', 'f6817f48af4fb3af11b9e8bf182f618b', 'ae4fed059f67086fd52a73d913cf473d', NULL);
INSERT INTO `sys_role_permission` VALUES ('f12b6c90e8913183d7ca547c66600891', 'e51758fa916c881624b046d26bd09230', 'aedbf679b5773c1f25e9f7b10111da73', NULL);
INSERT INTO `sys_role_permission` VALUES ('f177acac0276329dc66af0c9ad30558a', 'f6817f48af4fb3af11b9e8bf182f618b', 'c2c356bf4ddd29975347a7047a062440', NULL);
INSERT INTO `sys_role_permission` VALUES ('f17ab8ad1e71341140857ef4914ef297', '21c5a3187763729408b40afb0d0fdfa8', '732d48f8e0abe99fe6a23d18a3171cd1', NULL);
INSERT INTO `sys_role_permission` VALUES ('f99f99cc3bc27220cdd4f5aced33b7d7', 'f6817f48af4fb3af11b9e8bf182f618b', '655563cd64b75dcf52ef7bcdd4836953', NULL);
INSERT INTO `sys_role_permission` VALUES ('fafe73c4448b977fe42880a6750c3ee8', 'f6817f48af4fb3af11b9e8bf182f618b', '9cb91b8851db0cf7b19d7ecc2a8193dd', NULL);
INSERT INTO `sys_role_permission` VALUES ('fced905c7598973b970d42d833f73474', 'f6817f48af4fb3af11b9e8bf182f618b', '4875ebe289344e14844d8e3ea1edd73f', NULL);
INSERT INTO `sys_role_permission` VALUES ('fd86f6b08eb683720ba499f9d9421726', 'ee8626f80f7c2619917b6236f3a7f02b', '693ce69af3432bd00be13c3971a57961', NULL);
INSERT INTO `sys_role_permission` VALUES ('fd97963dc5f144d3aecfc7045a883427', 'f6817f48af4fb3af11b9e8bf182f618b', '043780fa095ff1b2bec4dc406d76f023', NULL);
INSERT INTO `sys_role_permission` VALUES ('fed41a4671285efb266cd404f24dd378', '52b0cf022ac4187b2a70dfa4f8b2d940', '00a2a0ae65cdca5e93209cdbde97cbe6', NULL);

-- ----------------------------
-- Table structure for sys_sms
-- ----------------------------
DROP TABLE IF EXISTS `sys_sms`;
CREATE TABLE `sys_sms`  (
  `id` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT 'ID',
  `es_title` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '消息标题',
  `es_type` varchar(1) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '发送方式：1短信 2邮件 3微信',
  `es_receiver` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '接收人',
  `es_param` varchar(1000) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '发送所需参数Json格式',
  `es_content` longtext CHARACTER SET utf8 COLLATE utf8_general_ci NULL COMMENT '推送内容',
  `es_send_time` datetime(0) NULL DEFAULT NULL COMMENT '推送时间',
  `es_send_status` varchar(1) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '推送状态 0未推送 1推送成功 2推送失败 -1失败不再发送',
  `es_send_num` int(11) NULL DEFAULT NULL COMMENT '发送次数 超过5次不再发送',
  `es_result` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '推送失败原因',
  `remark` varchar(500) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '备注',
  `create_by` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '创建人登录名称',
  `create_time` datetime(0) NULL DEFAULT NULL COMMENT '创建日期',
  `update_by` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '更新人登录名称',
  `update_time` datetime(0) NULL DEFAULT NULL COMMENT '更新日期',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `index_type`(`es_type`) USING BTREE,
  INDEX `index_receiver`(`es_receiver`) USING BTREE,
  INDEX `index_sendtime`(`es_send_time`) USING BTREE,
  INDEX `index_status`(`es_send_status`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_sms
-- ----------------------------
INSERT INTO `sys_sms` VALUES ('402880e74dc2f361014dc2f8411e0001', '消息推送测试333', '2', '411944058@qq.com', NULL, '张三你好，你的订单4028d881436d514601436d521ae80165已付款!', '2015-06-05 17:06:01', '3', NULL, NULL, '认证失败错误的用户名或者密码', 'admin', '2015-06-05 17:05:59', 'admin', '2015-11-19 22:30:39');
INSERT INTO `sys_sms` VALUES ('402880ea533647b00153364e74770001', '发个问候', '3', 'admin', NULL, '你好', '2016-03-02 00:00:00', '2', NULL, NULL, NULL, 'admin', '2016-03-02 15:50:24', 'admin', '2018-07-05 19:53:01');
INSERT INTO `sys_sms` VALUES ('402880ee5a17e711015a17f3188e013f', '消息推送测试333', '2', '411944058@qq.com', NULL, '张三你好，你的订单4028d881436d514601436d521ae80165已付款!', NULL, '2', NULL, NULL, NULL, 'admin', '2017-02-07 17:41:31', 'admin', '2017-03-10 11:37:05');
INSERT INTO `sys_sms` VALUES ('402880f05ab649b4015ab64b9cd80012', '消息推送测试333', '2', '411944058@qq.com', NULL, '张三你好，你的订单4028d881436d514601436d521ae80165已付款!', '2017-11-16 15:58:15', '3', NULL, NULL, NULL, 'admin', '2017-03-10 11:38:13', 'admin', '2017-07-31 17:24:54');
INSERT INTO `sys_sms` VALUES ('402880f05ab7b035015ab7c4462c0004', '消息推送测试333', '2', '411944058@qq.com', NULL, '张三你好，你的订单4028d881436d514601436d521ae80165已付款!', '2017-11-16 15:58:15', '3', NULL, NULL, NULL, 'admin', '2017-03-10 18:29:37', NULL, NULL);
INSERT INTO `sys_sms` VALUES ('402881f3646a472b01646a4a5af00001', '催办：HR审批', '3', 'admin', NULL, 'admin，您好！\r\n请前待办任务办理事项！HR审批\r\n\r\n\r\n===========================\r\n此消息由系统发出', '2018-07-05 19:53:35', '2', NULL, NULL, NULL, 'admin', '2018-07-05 19:53:35', 'admin', '2018-07-07 13:45:24');
INSERT INTO `sys_sms` VALUES ('402881f3647da06c01647da43a940014', '催办：HR审批', '3', 'admin', NULL, 'admin，您好！\r\n请前待办任务办理事项！HR审批\r\n\r\n\r\n===========================\r\n此消息由系统发出', '2018-07-09 14:04:32', '2', NULL, NULL, NULL, 'admin', '2018-07-09 14:04:32', 'admin', '2018-07-09 18:51:30');

-- ----------------------------
-- Table structure for sys_sms_template
-- ----------------------------
DROP TABLE IF EXISTS `sys_sms_template`;
CREATE TABLE `sys_sms_template`  (
  `id` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '主键',
  `template_name` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '模板标题',
  `template_code` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '模板CODE',
  `template_type` varchar(1) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '模板类型：1短信 2邮件 3微信',
  `template_content` varchar(1000) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '模板内容',
  `template_test_json` varchar(1000) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '模板测试json',
  `create_time` datetime(0) NULL DEFAULT NULL COMMENT '创建日期',
  `create_by` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '创建人登录名称',
  `update_time` datetime(0) NULL DEFAULT NULL COMMENT '更新日期',
  `update_by` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '更新人登录名称',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `uniq_templatecode`(`template_code`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_sms_template
-- ----------------------------
INSERT INTO `sys_sms_template` VALUES ('1199606397416775681', '系统消息通知', 'sys_ts_note', '4', '<h1>&nbsp; &nbsp; 系统通知</h1>\n<ul>\n<li>通知时间：&nbsp; ${ts_date}</li>\n<li>通知内容：&nbsp; ${ts_content}</li>\n</ul>', NULL, '2019-11-27 16:30:27', 'admin', '2019-11-27 19:36:50', 'admin');
INSERT INTO `sys_sms_template` VALUES ('1199615897335095298', '流程催办', 'bpm_cuiban', '4', '<h1>&nbsp; &nbsp;流程催办提醒</h1>\n<ul>\n<li>流程名称：&nbsp; ${bpm_name}</li>\n<li>催办任务：&nbsp; ${bpm_task}</li>\n<li>催办时间 :&nbsp; &nbsp; ${datetime}</li>\n<li>催办内容 :&nbsp; &nbsp; ${remark}</li>\n</ul>', NULL, '2019-11-27 17:08:12', 'admin', '2019-11-27 19:36:45', 'admin');
INSERT INTO `sys_sms_template` VALUES ('1199648914107625473', '流程办理超时提醒', 'bpm_chaoshi_tip', '4', '<h1>&nbsp; &nbsp;流程办理超时提醒</h1>\n<ul>\n<li>&nbsp; &nbsp;超时提醒信息：&nbsp; &nbsp; 您有待处理的超时任务，请尽快处理！</li>\n<li>&nbsp; &nbsp;超时任务标题：&nbsp; &nbsp; ${title}</li>\n<li>&nbsp; &nbsp;超时任务节点：&nbsp; &nbsp; ${task}</li>\n<li>&nbsp; &nbsp;任务处理人：&nbsp; &nbsp; &nbsp; &nbsp;${user}</li>\n<li>&nbsp; &nbsp;任务开始时间：&nbsp; &nbsp; ${time}</li>\n</ul>', NULL, '2019-11-27 19:19:24', 'admin', '2019-11-27 19:36:37', 'admin');
INSERT INTO `sys_sms_template` VALUES ('4028608164691b000164693108140003', '催办：${taskName}', 'SYS001', '3', '${userName}，您好！\r\n请前待办任务办理事项！${taskName}\r\n\r\n\r\n===========================\r\n此消息由系统发出', '{\r\n\"taskName\":\"HR审批\",\r\n\"userName\":\"admin\"\r\n}', '2018-07-05 14:46:18', 'admin', '2018-07-05 18:31:34', 'admin');

-- ----------------------------
-- Table structure for sys_user
-- ----------------------------
DROP TABLE IF EXISTS `sys_user`;
CREATE TABLE `sys_user`  (
  `id` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '主键id',
  `username` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '登录账号',
  `realname` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '真实姓名',
  `password` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '密码',
  `salt` varchar(45) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT 'md5密码盐',
  `avatar` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '头像',
  `birthday` datetime(0) NULL DEFAULT NULL COMMENT '生日',
  `sex` tinyint(1) NULL DEFAULT NULL COMMENT '性别(0-默认未知,1-男,2-女)',
  `email` varchar(45) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '电子邮件',
  `phone` varchar(45) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '电话',
  `org_code` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '机构编码',
  `status` tinyint(1) NULL DEFAULT NULL COMMENT '性别(1-正常,2-冻结)',
  `del_flag` tinyint(1) NULL DEFAULT NULL COMMENT '删除状态(0-正常,1-已删除)',
  `third_id` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '第三方登录的唯一标识',
  `third_type` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '第三方类型',
  `activiti_sync` tinyint(1) NULL DEFAULT NULL COMMENT '同步工作流引擎(1-同步,0-不同步)',
  `work_no` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '工号，唯一键',
  `post` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '职务，关联职务表',
  `telephone` varchar(45) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '座机号',
  `create_by` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '创建人',
  `create_time` datetime(0) NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '更新人',
  `update_time` datetime(0) NULL DEFAULT NULL COMMENT '更新时间',
  `user_identity` tinyint(1) NULL DEFAULT NULL COMMENT '身份（1普通成员 2上级）',
  `depart_ids` longtext CHARACTER SET utf8 COLLATE utf8_general_ci NULL COMMENT '负责部门',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `index_user_name`(`username`) USING BTREE,
  UNIQUE INDEX `uniq_sys_user_work_no`(`work_no`) USING BTREE,
  UNIQUE INDEX `uniq_sys_user_username`(`username`) USING BTREE,
  UNIQUE INDEX `uniq_sys_user_phone`(`phone`) USING BTREE,
  UNIQUE INDEX `uniq_sys_user_email`(`email`) USING BTREE,
  INDEX `index_user_status`(`status`) USING BTREE,
  INDEX `index_user_del_flag`(`del_flag`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '用户表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_user
-- ----------------------------
INSERT INTO `sys_user` VALUES ('42d153bffeea74f72a9c1697874fa4a7', 'test22', '23232', 'ac52e15671a377cf', '5FMD48RM', 'user/20190314/ly-plate-e_1552531617500.png', '2019-02-09 00:00:00', 1, 'zhangdaiscott@163.com', '18611782222', NULL, 1, 0, NULL, NULL, 1, NULL, NULL, NULL, 'admin', '2019-01-26 18:01:10', 'admin', '2019-03-23 15:05:50', NULL, NULL);
INSERT INTO `sys_user` VALUES ('a75d45a015c44384a04449ee80dc3503', 'jeecg', 'jeecg', '3dd8371f3cf8240e', 'vDDkDzrK', 'user/20190220/e1fe9925bc315c60addea1b98eb1cb1349547719_1550656892940.jpg', NULL, 2, NULL, NULL, 'A02A01', 1, 0, NULL, NULL, 1, NULL, NULL, NULL, 'admin', '2019-02-13 16:02:36', 'admin', '2019-04-09 15:47:36', NULL, NULL);
INSERT INTO `sys_user` VALUES ('e9ca23d68d884d4ebb19d07889727dae', 'admin', '管理员', 'cb362cfeefbf3d8d', 'RCGTeGiH', 'temp/f2-1_1591257744991.png', '2018-12-05 00:00:00', 1, '11@qq.com', '18566666661', 'A01', 1, 0, NULL, NULL, 1, '111', '', NULL, NULL, '2038-06-21 17:54:10', 'admin', '2020-06-04 16:02:28', 1, '');
INSERT INTO `sys_user` VALUES ('f0019fdebedb443c98dcb17d88222c38', 'zhagnxiao', '张小红', 'f898134e5e52ae11a2ffb2c3b57a4e90', 'go3jJ4zX', 'user/20190401/20180607175028Fn1Lq7zw_1554118444672.png', '2019-04-01 00:00:00', NULL, NULL, NULL, NULL, 1, 0, NULL, NULL, 1, NULL, NULL, NULL, 'admin', '2023-10-01 19:34:10', 'admin', '2019-04-10 22:00:22', NULL, NULL);

-- ----------------------------
-- Table structure for sys_user_agent
-- ----------------------------
DROP TABLE IF EXISTS `sys_user_agent`;
CREATE TABLE `sys_user_agent`  (
  `id` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '序号',
  `user_name` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '用户名',
  `agent_user_name` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '代理人用户名',
  `start_time` datetime(0) NULL DEFAULT NULL COMMENT '代理开始时间',
  `end_time` datetime(0) NULL DEFAULT NULL COMMENT '代理结束时间',
  `status` varchar(2) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '状态0无效1有效',
  `create_name` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '创建人名称',
  `create_by` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '创建人登录名称',
  `create_time` datetime(0) NULL DEFAULT NULL COMMENT '创建日期',
  `update_name` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '更新人名称',
  `update_by` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '更新人登录名称',
  `update_time` datetime(0) NULL DEFAULT NULL COMMENT '更新日期',
  `sys_org_code` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '所属部门',
  `sys_company_code` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '所属公司',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `uniq_username`(`user_name`) USING BTREE,
  INDEX `statux_index`(`status`) USING BTREE,
  INDEX `begintime_index`(`start_time`) USING BTREE,
  INDEX `endtime_index`(`end_time`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '用户代理人设置' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for sys_user_depart
-- ----------------------------
DROP TABLE IF EXISTS `sys_user_depart`;
CREATE TABLE `sys_user_depart`  (
  `ID` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT 'id',
  `user_id` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '用户id',
  `dep_id` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '部门id',
  PRIMARY KEY (`ID`) USING BTREE,
  INDEX `index_depart_groupk_userid`(`user_id`) USING BTREE,
  INDEX `index_depart_groupkorgid`(`dep_id`) USING BTREE,
  INDEX `index_depart_groupk_uidanddid`(`user_id`, `dep_id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_user_depart
-- ----------------------------
INSERT INTO `sys_user_depart` VALUES ('0c42ba309c2c4cad35836ec2336676fa', '42d153bffeea74f72a9c1697874fa4a7', '6d35e179cd814e3299bd588ea7daed3f');
INSERT INTO `sys_user_depart` VALUES ('2835834d133f9118ee87a666e0f5501e', 'a75d45a015c44384a04449ee80dc3503', 'a7d7e77e06c84325a40932163adcdaa6');
INSERT INTO `sys_user_depart` VALUES ('1f3a0267811327b9eca86b0cc2b956f3', 'bcbe1290783a469a83ae3bd8effe15d4', '5159cde220114246b045e574adceafe9');
INSERT INTO `sys_user_depart` VALUES ('1268453046966874114', 'e9ca23d68d884d4ebb19d07889727dae', 'c6d7cb4deeac411cb3384b1b31278596');
INSERT INTO `sys_user_depart` VALUES ('ac52f23ae625eb6560c9227170b88166', 'f0019fdebedb443c98dcb17d88222c38', '57197590443c44f083d42ae24ef26a2c');
INSERT INTO `sys_user_depart` VALUES ('179660a8b9a122f66b73603799a10924', 'f0019fdebedb443c98dcb17d88222c38', '67fc001af12a4f9b8458005d3f19934a');

-- ----------------------------
-- Table structure for sys_user_role
-- ----------------------------
DROP TABLE IF EXISTS `sys_user_role`;
CREATE TABLE `sys_user_role`  (
  `id` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '主键id',
  `user_id` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '用户id',
  `role_id` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '角色id',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `index2_groupuu_user_id`(`user_id`) USING BTREE,
  INDEX `index2_groupuu_ole_id`(`role_id`) USING BTREE,
  INDEX `index2_groupuu_useridandroleid`(`user_id`, `role_id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '用户角色表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_user_role
-- ----------------------------
INSERT INTO `sys_user_role` VALUES ('b3ffd9311a1ca296c44e2409b547384f', '01b802058ea94b978a2c96f4807f6b48', '1');
INSERT INTO `sys_user_role` VALUES ('0ede6d23d53bc7dc990346ff14faabee', '3db4cf42353f4e868b7ccfeef90505d2', 'ee8626f80f7c2619917b6236f3a7f02b');
INSERT INTO `sys_user_role` VALUES ('e78d210d24aaff48e0a736e2ddff4cdc', '3e177fede453430387a8279ced685679', 'ee8626f80f7c2619917b6236f3a7f02b');
INSERT INTO `sys_user_role` VALUES ('f2de3ae7b5efd8345581aa802a6675d6', '41b1be8d4c52023b0798f51164ca682d', 'e51758fa916c881624b046d26bd09230');
INSERT INTO `sys_user_role` VALUES ('6f9da7310489bac1e5f95e0efe92b4ce', '42d153bffeea74f72a9c1697874fa4a7', 'e51758fa916c881624b046d26bd09230');
INSERT INTO `sys_user_role` VALUES ('f2922a38ba24fb53749e45a0c459adb3', '439ae3e9bcf7418583fcd429cadb1d72', '1');
INSERT INTO `sys_user_role` VALUES ('f72c6190b0722e798147e73c776c6ac9', '439ae3e9bcf7418583fcd429cadb1d72', 'ee8626f80f7c2619917b6236f3a7f02b');
INSERT INTO `sys_user_role` VALUES ('ee45d0343ecec894b6886effc92cb0b7', '4d8fef4667574b24a9ccfedaf257810c', 'f6817f48af4fb3af11b9e8bf182f618b');
INSERT INTO `sys_user_role` VALUES ('be2639167ede09379937daca7fc3bb73', '526f300ab35e44faaed54a9fb0742845', 'ee8626f80f7c2619917b6236f3a7f02b');
INSERT INTO `sys_user_role` VALUES ('31af310584bd5795f76b1fe8c38294a0', '70f5dcf03f36471dabba81381919291f', 'e51758fa916c881624b046d26bd09230');
INSERT INTO `sys_user_role` VALUES ('8d7846ec783e157174e4ce2949231a65', '7ee6630e89d17afbf6d12150197b578d', 'e51758fa916c881624b046d26bd09230');
INSERT INTO `sys_user_role` VALUES ('79d66ef7aa137cfa9957081a1483009d', '9a668858c4c74cf5a2b25ad9608ba095', 'ee8626f80f7c2619917b6236f3a7f02b');
INSERT INTO `sys_user_role` VALUES ('f3a4ca33848daba3e43490707ae859e7', 'a75d45a015c44384a04449ee80dc3503', 'e51758fa916c881624b046d26bd09230');
INSERT INTO `sys_user_role` VALUES ('fe38580871c5061ba59d5c03a0840b0e', 'a75d45a015c44384a04449ee80dc3503', 'ee8626f80f7c2619917b6236f3a7f02b');
INSERT INTO `sys_user_role` VALUES ('1268453046069293057', 'e9ca23d68d884d4ebb19d07889727dae', 'ee8626f80f7c2619917b6236f3a7f02b');
INSERT INTO `sys_user_role` VALUES ('1268453046086070273', 'e9ca23d68d884d4ebb19d07889727dae', 'f6817f48af4fb3af11b9e8bf182f618b');
INSERT INTO `sys_user_role` VALUES ('d2233e5be091d39da5abb0073c766224', 'f0019fdebedb443c98dcb17d88222c38', 'ee8626f80f7c2619917b6236f3a7f02b');

-- ----------------------------
-- Table structure for test_demo
-- ----------------------------
DROP TABLE IF EXISTS `test_demo`;
CREATE TABLE `test_demo`  (
  `id` varchar(36) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '主键',
  `create_by` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '创建人登录名称',
  `create_time` datetime(0) NULL DEFAULT NULL COMMENT '创建日期',
  `update_by` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '更新人登录名称',
  `update_time` datetime(0) NULL DEFAULT NULL COMMENT '更新日期',
  `name` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '用户名',
  `sex` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '性别',
  `age` int(32) NULL DEFAULT NULL COMMENT '年龄',
  `birthday` datetime(0) NULL DEFAULT NULL COMMENT '生日',
  `user_code` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '用户编码',
  `file_kk` varchar(500) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '附件',
  `top_pic` varchar(500) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '头像',
  `desc2` varchar(500) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '描述',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of test_demo
-- ----------------------------
INSERT INTO `test_demo` VALUES ('4028810c6aed99e1016aed9b31b40002', NULL, NULL, 'admin', '2019-10-19 15:37:27', 'jeecg', '2', 55, '2019-05-15 00:00:00', NULL, '', '', NULL);
INSERT INTO `test_demo` VALUES ('4028810c6b02cba2016b02cba21f0000', 'admin', '2019-05-29 16:53:48', 'admin', '2019-08-23 23:45:21', '张小红', '1', 8222, '2019-04-01 00:00:00', NULL, '', '', NULL);
INSERT INTO `test_demo` VALUES ('4028810c6b40244b016b4030a0e40001', 'admin', '2019-06-10 15:00:57', 'admin', '2019-08-23 23:42:49', '小芳', '2', 0, '2019-04-01 00:00:00', NULL, '', '', NULL);
INSERT INTO `test_demo` VALUES ('fa1d1c249461498d90f405b94f60aae0', '', NULL, 'admin', '2019-05-15 12:30:28', '战三', '2', 222, NULL, NULL, NULL, NULL, NULL);

-- ----------------------------
-- Table structure for test_enhance_select
-- ----------------------------
DROP TABLE IF EXISTS `test_enhance_select`;
CREATE TABLE `test_enhance_select`  (
  `id` varchar(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `province` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '省份',
  `city` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '市',
  `area` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '区',
  `create_time` datetime(0) NULL DEFAULT NULL COMMENT '创建日期',
  `create_by` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '创建人',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of test_enhance_select
-- ----------------------------
INSERT INTO `test_enhance_select` VALUES ('1256614575282958338', '1230769290609725441', '1230769470889299970', '1230769620021972993', '2020-05-03 00:00:36', 'admin');
INSERT INTO `test_enhance_select` VALUES ('402880e570801ffe01708053743c002e', '1230769253267836929', '1230769769930592257', '1230769855347593217', '2020-02-26 15:08:37', 'admin');
INSERT INTO `test_enhance_select` VALUES ('402880e570801ffe017080538b24002f', '1230769290609725441', '1230769470889299970', '1230769620021972993', '2020-02-26 15:08:43', 'admin');
INSERT INTO `test_enhance_select` VALUES ('402880e570801ffe01708053b2b10030', '1230769253267836929', '1230769347157331969', '1230769407907631106', '2020-02-26 15:08:53', 'admin');

-- ----------------------------
-- Table structure for test_order_main
-- ----------------------------
DROP TABLE IF EXISTS `test_order_main`;
CREATE TABLE `test_order_main`  (
  `id` varchar(36) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `create_by` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '创建人',
  `create_time` datetime(0) NULL DEFAULT NULL COMMENT '创建日期',
  `update_by` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '更新人',
  `update_time` datetime(0) NULL DEFAULT NULL COMMENT '更新日期',
  `order_code` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '订单编码',
  `order_date` datetime(0) NULL DEFAULT NULL COMMENT '下单时间',
  `descc` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '描述',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of test_order_main
-- ----------------------------
INSERT INTO `test_order_main` VALUES ('402831816a38e7fd016a38e825c90003', 'admin', '2019-04-20 12:01:39', 'admin', '2019-08-23 23:43:17', '111333', '2019-04-20 00:00:00', '11');
INSERT INTO `test_order_main` VALUES ('4028810c6b40244b016b40686dfb0003', 'admin', '2019-06-10 16:01:54', 'admin', '2019-06-10 16:06:51', '1231', '2019-06-10 00:00:00', '123');
INSERT INTO `test_order_main` VALUES ('4028810c6b40244b016b4068ef890006', 'admin', '2019-06-10 16:02:27', 'admin', '2019-08-23 23:43:08', 'A001', '2019-06-10 00:00:00', '购买产品BOOT');

-- ----------------------------
-- Table structure for test_order_product
-- ----------------------------
DROP TABLE IF EXISTS `test_order_product`;
CREATE TABLE `test_order_product`  (
  `id` varchar(36) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '主键',
  `create_by` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '创建人',
  `create_time` datetime(0) NULL DEFAULT NULL COMMENT '创建日期',
  `update_by` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '更新人2',
  `update_time` datetime(0) NULL DEFAULT NULL COMMENT '更新日期',
  `product_name` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '产品名字',
  `price` double(32, 0) NULL DEFAULT NULL COMMENT '价格',
  `num` int(32) NULL DEFAULT NULL COMMENT '数量',
  `order_fk_id` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '订单外键ID',
  `pro_type` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '产品类型',
  `desc_` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '描述',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of test_order_product
-- ----------------------------
INSERT INTO `test_order_product` VALUES ('15665749852471', 'admin', '2019-08-23 23:43:08', NULL, NULL, '222', 222, 22, '4028810c6b40244b016b4068ef890006', '2', NULL);
INSERT INTO `test_order_product` VALUES ('15665749948861', 'admin', '2019-08-23 23:43:17', NULL, NULL, '333', 33, NULL, '402831816a38e7fd016a38e825c90003', '', NULL);
INSERT INTO `test_order_product` VALUES ('402831816a38e7fd016a38e7fdeb0001', 'admin', '2019-04-20 12:01:29', NULL, NULL, '笔记本', 100, 10, '402831816a38e7fd016a38e7fddf0000', NULL, NULL);
INSERT INTO `test_order_product` VALUES ('402831816a38e7fd016a38e7fdf10002', 'admin', '2019-04-20 12:01:29', NULL, NULL, '显示器', 300, 1, '402831816a38e7fd016a38e7fddf0000', NULL, NULL);
INSERT INTO `test_order_product` VALUES ('4028810c6b40244b016b40686e050004', 'admin', '2019-06-10 16:06:51', NULL, NULL, '123', 222, 123, '4028810c6b40244b016b40686dfb0003', NULL, NULL);
INSERT INTO `test_order_product` VALUES ('4028810c6b40244b016b406884080005', 'admin', '2019-08-23 23:43:17', NULL, NULL, '333', NULL, 33, '402831816a38e7fd016a38e825c90003', '', NULL);
INSERT INTO `test_order_product` VALUES ('4028810c6b40244b016b4068ef8f0007', 'admin', '2019-08-23 23:43:08', NULL, NULL, 'JEECG-BOOT开发平台', 10000, 1, '4028810c6b40244b016b4068ef890006', '1', NULL);

-- ----------------------------
-- Table structure for test_person
-- ----------------------------
DROP TABLE IF EXISTS `test_person`;
CREATE TABLE `test_person`  (
  `id` varchar(36) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `create_by` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '创建人',
  `create_time` datetime(0) NULL DEFAULT NULL COMMENT '创建日期',
  `update_by` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '更新人',
  `update_time` datetime(0) NULL DEFAULT NULL COMMENT '更新日期',
  `sex` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '性别',
  `name` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '用户名',
  `content` longtext CHARACTER SET utf8 COLLATE utf8_general_ci NULL COMMENT '请假原因',
  `be_date` datetime(0) NULL DEFAULT NULL COMMENT '请假时间',
  `qj_days` int(11) NULL DEFAULT NULL COMMENT '请假天数',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of test_person
-- ----------------------------
INSERT INTO `test_person` VALUES ('8ca668defdae47df8649a5477ae08b05', 'admin', '2019-04-12 09:51:37', NULL, NULL, '1', 'zhangdaiscott', 'dsdsd', '2019-04-12 00:00:00', 2);

-- ----------------------------
-- Table structure for test_shoptype_tree
-- ----------------------------
DROP TABLE IF EXISTS `test_shoptype_tree`;
CREATE TABLE `test_shoptype_tree`  (
  `id` varchar(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '主键',
  `create_by` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '创建人',
  `create_time` datetime(0) NULL DEFAULT NULL COMMENT '创建日期',
  `update_by` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '更新人',
  `update_time` datetime(0) NULL DEFAULT NULL COMMENT '更新日期',
  `sys_org_code` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '所属部门',
  `type_name` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '商品分类',
  `pic` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '分类图片',
  `pid` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '父级节点',
  `has_child` varchar(3) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '是否有子节点',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of test_shoptype_tree
-- ----------------------------
INSERT INTO `test_shoptype_tree` VALUES ('1256628820489908225', 'admin', '2020-05-03 00:57:12', NULL, NULL, 'A01', '衣服', NULL, '0', '0');
INSERT INTO `test_shoptype_tree` VALUES ('1256628843097206786', 'admin', '2020-05-03 00:57:17', NULL, NULL, 'A01', '电子产品', NULL, '0', '0');
INSERT INTO `test_shoptype_tree` VALUES ('1256629035921944577', 'admin', '2020-05-03 00:58:03', NULL, NULL, 'A01', '三星显示器', 'gh_f28e66390fc9_344 (shop)_1588438682583.jpg', '1256628864848867329', '0');
INSERT INTO `test_shoptype_tree` VALUES ('1256629093740425218', 'admin', '2020-05-03 00:58:17', NULL, NULL, 'A01', '手机', '', '0', '1');
INSERT INTO `test_shoptype_tree` VALUES ('1256629139206680578', 'admin', '2020-05-03 00:58:28', NULL, NULL, 'A01', 'iPhone', 'e1fe9925bc315c60addea1b98eb1cb1349547719_1588438707727.jpg', '1256629093740425218', '0');
INSERT INTO `test_shoptype_tree` VALUES ('1256629188993069058', 'admin', '2020-05-03 00:58:40', 'admin', '2020-05-03 00:58:55', 'A01', '华为手机', 'jeewxshop测试号_1588438719823.jpg', '1256629093740425218', '0');

-- ----------------------------
-- Procedure structure for sp_fin_payable_bal_month_carry_forward
-- ----------------------------
DROP PROCEDURE IF EXISTS `sp_fin_payable_bal_month_carry_forward`;
delimiter ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_fin_payable_bal_month_carry_forward`(IN `p_year` smallint,IN `p_month` tinyint)
BEGIN
	DECLARE n_year SMALLINT;
	DECLARE n_month TINYINT;

	DROP TABLE IF EXISTS `tmp`;
	CREATE TEMPORARY TABLE tmp(
		supplier_id VARCHAR(36),
		amt DECIMAL(18,2) DEFAULT 0
	);
	
	#初始金额
	UPDATE fin_payable_bal b 
		 SET b.debit_amt = 0,
			   b.credit_amt = 0
	 WHERE b.`year` = p_year
	   AND b.`month` = p_month;
	
	#贷方金额
	INSERT INTO tmp(supplier_id, amt)
		SELECT p.supplier_id, SUM(p.amt) amt
			FROM fin_payable p
		 WHERE p.is_approved = 1 
			 AND p.is_voided = 0
			 AND YEAR(p.bill_date) = p_year
			 AND MONTH(p.bill_date) = p_month
		 GROUP BY p.supplier_id;

	UPDATE fin_payable_bal b
	 INNER JOIN tmp a
			ON b.supplier_id = a.supplier_id
		 AND b.`year` = p_year
		 AND b.`month` = p_month
		 SET b.credit_amt = a.amt;

	INSERT INTO fin_payable_bal(id, `year`, `month`, supplier_id, begin_credit_bal, debit_amt, credit_amt)
		SELECT MD5(UUID()), p_year, p_month, a.supplier_id, 0, 0, a.amt
			FROM tmp a
			LEFT JOIN fin_payable_bal b
				ON a.supplier_id = b.supplier_id
			 AND b.`year` = p_year
			 AND b.`month` = p_month
		 WHERE b.supplier_id IS NULL;

	SELECT IFNULL(SUM(amt), 0) INTO @credit_amt FROM tmp;

	DELETE FROM tmp;
	
	#借方金额
	INSERT INTO tmp(supplier_id, amt)
		SELECT p.supplier_id, SUM(p.amt) amt
			FROM fin_payment p
		 WHERE p.is_approved = 1 
			 AND p.is_voided = 0
			 AND YEAR(p.bill_date) = p_year
			 AND MONTH(p.bill_date) = p_month
		 GROUP BY p.supplier_id;

	UPDATE fin_payable_bal b
	 INNER JOIN tmp a
			ON b.supplier_id = a.supplier_id
		 AND b.`year` = p_year
		 AND b.`month` = p_month
		 SET b.debit_amt = a.amt;

	INSERT INTO fin_payable_bal(id, `year`, `month`, supplier_id, begin_credit_bal, debit_amt, credit_amt)
		SELECT MD5(UUID()), p_year, p_month, a.supplier_id, 0, a.amt, 0
			FROM tmp a
			LEFT JOIN fin_payable_bal b
				ON a.supplier_id = b.supplier_id
			 AND b.`year` = p_year
			 AND b.`month` = p_month
		 WHERE b.supplier_id IS NULL;	

	SELECT IFNULL(SUM(amt), 0) INTO @debit_amt FROM tmp;


	#科目合计
	SELECT COUNT(b.id) 
		INTO @num
		FROM fin_payable_bal b
	 WHERE b.`year` = p_year
		 AND b.`month` = p_month
		 AND b.supplier_id IS NULL;

	IF @num = 0 THEN
		INSERT INTO fin_payable_bal(id, `year`, `month`, supplier_id, begin_credit_bal, debit_amt, credit_amt)
			SELECT MD5(UUID()), p_year, p_month, NULL, SUM(b.begin_credit_bal), SUM(b.debit_amt), SUM(b.credit_amt)
				FROM fin_payable_bal b
			 WHERE b.`year` = p_year
				 AND b.`month` = p_month
				 AND b.supplier_id IS NOT NULL;
	ELSE
		UPDATE fin_payable_bal b 
			 SET b.debit_amt = @debit_amt,
					 b.credit_amt = @credit_amt
		 WHERE b.`year` = p_year
			 AND b.`month` = p_month
			 AND b.supplier_id IS NULL;
	END IF;

	#结转下月
	IF p_month < 12 THEN
		SET @n_year = p_year;
		SET @n_month = p_month + 1;
	ELSE
		SET @n_year = p_year + 1;
		SET @n_month = 1;
	END IF;

	DELETE FROM fin_payable_bal
	 WHERE `year` = @n_year
		 AND `month` = @n_month;

	INSERT INTO fin_payable_bal(id, `year`, `month`, supplier_id, begin_credit_bal, debit_amt, credit_amt)
		SELECT MD5(UUID()), @n_year, @n_month, IFNULL(b.supplier_id, c.id), 
					 IFNULL(b.begin_credit_bal,0) - IFNULL(b.debit_amt,0) + IFNULL(b.credit_amt, 0), 0, 0
			FROM fin_payable_bal b
			LEFT JOIN bas_supplier c
				ON b.supplier_id = c.id
			 AND b.`year` = p_year
			 AND b.`month` = p_month
		 WHERE IFNULL(b.begin_credit_bal,0) - IFNULL(b.debit_amt,0) + IFNULL(b.credit_amt, 0) != 0
			  OR c.is_enabled = 1;	
END
;;
delimiter ;

-- ----------------------------
-- Procedure structure for sp_fin_receivable_bal_month_carry_forward
-- ----------------------------
DROP PROCEDURE IF EXISTS `sp_fin_receivable_bal_month_carry_forward`;
delimiter ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_fin_receivable_bal_month_carry_forward`(IN `p_year` smallint,IN `p_month` tinyint)
BEGIN
	DECLARE n_year SMALLINT;
	DECLARE n_month TINYINT;

	DROP TABLE IF EXISTS `tmp`;
	CREATE TEMPORARY TABLE tmp(
		customer_id VARCHAR(36),
		amt DECIMAL(18,2) DEFAULT 0
	);
	
	#初始金额
	UPDATE fin_receivable_bal b 
		 SET b.debit_amt = 0,
			   b.credit_amt = 0
	 WHERE b.`year` = p_year
	   AND b.`month` = p_month;

	#借方金额
	INSERT INTO tmp(customer_id, amt)
		SELECT r.customer_id, SUM(r.amt) amt
			FROM fin_receivable r
		 WHERE r.is_approved = 1 
			 AND r.is_voided = 0
			 AND YEAR(r.bill_date) = p_year
			 AND MONTH(r.bill_date) = p_month
		 GROUP BY r.customer_id;

	UPDATE fin_receivable_bal b
	 INNER JOIN tmp a
			ON b.customer_id = a.customer_id
		 AND b.`year` = p_year
		 AND b.`month` = p_month
		 SET b.debit_amt = a.amt;

	INSERT INTO fin_receivable_bal(id, `year`, `month`, customer_id, begin_debit_bal, debit_amt, credit_amt)
		SELECT MD5(UUID()), p_year, p_month, a.customer_id, 0, a.amt, 0
			FROM tmp a
			LEFT JOIN fin_receivable_bal b
				ON a.customer_id = b.customer_id
			 AND b.`year` = p_year
			 AND b.`month` = p_month
		 WHERE b.customer_id IS NULL;

	SELECT IFNULL(SUM(amt), 0) INTO @debit_amt FROM tmp;

	DELETE FROM tmp;
	
	#贷方金额
	INSERT INTO tmp(customer_id, amt)
		SELECT r.customer_id, SUM(r.amt) amt
			FROM fin_receipt r
		 WHERE r.is_approved = 1 
			 AND r.is_voided = 0
			 AND YEAR(r.bill_date) = p_year
			 AND MONTH(r.bill_date) = p_month
		 GROUP BY r.customer_id;

	UPDATE fin_receivable_bal b
	 INNER JOIN tmp a
			ON b.customer_id = a.customer_id
		 AND b.`year` = p_year
		 AND b.`month` = p_month
		 SET b.credit_amt = a.amt;

	INSERT INTO fin_receivable_bal(id, `year`, `month`, customer_id, begin_debit_bal, debit_amt, credit_amt)
		SELECT MD5(UUID()), p_year, p_month, a.customer_id, 0, 0, a.amt
			FROM tmp a
			LEFT JOIN fin_receivable_bal b
				ON a.customer_id = b.customer_id
			 AND b.`year` = p_year
			 AND b.`month` = p_month
		 WHERE b.customer_id IS NULL;	

	SELECT IFNULL(SUM(amt), 0) INTO @credit_amt FROM tmp;


	#科目合计
	SELECT COUNT(b.id) 
		INTO @num
		FROM fin_receivable_bal b
	 WHERE b.`year` = p_year
		 AND b.`month` = p_month
		 AND b.customer_id IS NULL;

	IF @num = 0 THEN
		INSERT INTO fin_receivable_bal(id, `year`, `month`, customer_id, begin_debit_bal, debit_amt, credit_amt)
			SELECT MD5(UUID()), p_year, p_month, NULL, SUM(b.begin_debit_bal), SUM(b.debit_amt), SUM(b.credit_amt)
				FROM fin_receivable_bal b
			 WHERE b.`year` = p_year
				 AND b.`month` = p_month
				 AND b.customer_id IS NOT NULL;
	ELSE
		UPDATE fin_receivable_bal b 
			 SET b.debit_amt = @debit_amt,
					 b.credit_amt = @credit_amt
		 WHERE b.`year` = p_year
			 AND b.`month` = p_month
			 AND b.customer_id IS NULL;
	END IF;

	#结转下月
	IF p_month < 12 THEN
		SET @n_year = p_year;
		SET @n_month = p_month + 1;
	ELSE
		SET @n_year = p_year + 1;
		SET @n_month = 1;
	END IF;

	DELETE FROM fin_receivable_bal
	 WHERE `year` = @n_year
		 AND `month` = @n_month;

	INSERT INTO fin_receivable_bal(id, `year`, `month`, customer_id, begin_debit_bal, debit_amt, credit_amt)
		SELECT MD5(UUID()), @n_year, @n_month, IFNULL(b.customer_id, c.id), 
					 IFNULL(b.begin_debit_bal,0) + IFNULL(b.debit_amt,0) - IFNULL(b.credit_amt, 0), 0, 0
			FROM fin_receivable_bal b
			LEFT JOIN bas_customer c
				ON b.customer_id = c.id
			 AND b.`year` = p_year
			 AND b.`month` = p_month
		 WHERE IFNULL(b.begin_debit_bal,0) + IFNULL(b.debit_amt,0) - IFNULL(b.credit_amt, 0) != 0
			  OR c.is_enabled = 1;	
END
;;
delimiter ;

SET FOREIGN_KEY_CHECKS = 1;
