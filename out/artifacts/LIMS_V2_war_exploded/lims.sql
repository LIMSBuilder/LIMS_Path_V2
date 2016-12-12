/*
 Navicat Premium Data Transfer

 Source Server         : localhost
 Source Server Type    : MySQL
 Source Server Version : 50710
 Source Host           : localhost
 Source Database       : lims

 Target Server Type    : MySQL
 Target Server Version : 50710
 File Encoding         : utf-8

 Date: 12/12/2016 18:31:24 PM
*/

SET NAMES utf8;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
--  Table structure for `db_contract`
-- ----------------------------
DROP TABLE IF EXISTS `db_contract`;
CREATE TABLE `db_contract` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `identify` varchar(255) NOT NULL,
  `client_unit` varchar(255) DEFAULT NULL,
  `client_code` varchar(255) DEFAULT NULL,
  `client_address` varchar(255) DEFAULT NULL,
  `client_tel` varchar(255) DEFAULT NULL,
  `client` varchar(255) DEFAULT NULL,
  `client_fax` varchar(255) DEFAULT NULL,
  `trustee_unit` varchar(255) DEFAULT NULL,
  `trustee_code` varchar(255) DEFAULT NULL,
  `trustee_address` varchar(255) DEFAULT NULL,
  `trustee_tel` varchar(255) DEFAULT NULL,
  `trustee` int(11) DEFAULT NULL,
  `trustee_fax` varchar(255) DEFAULT NULL,
  `project_name` varchar(255) DEFAULT NULL,
  `monitor_aim` varchar(2000) DEFAULT NULL,
  `monitor_type` varchar(255) DEFAULT NULL,
  `monitor_way` int(11) DEFAULT NULL,
  `monitor_way_desp` varchar(255) DEFAULT NULL,
  `subpackage` varchar(255) DEFAULT NULL,
  `subpackage_project` varchar(255) DEFAULT NULL,
  `payment_way` int(11) DEFAULT NULL,
  `payment_count` float DEFAULT NULL,
  `in_room` int(11) DEFAULT NULL,
  `keep_secret` int(11) DEFAULT NULL,
  `other` varchar(2000) DEFAULT NULL,
  `finish_date` varchar(255) DEFAULT NULL,
  `state` int(11) NOT NULL,
  `create_time` date DEFAULT NULL,
  `reject_count` int(11) DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `trustee` (`trustee`),
  CONSTRAINT `db_contract_ibfk_1` FOREIGN KEY (`trustee`) REFERENCES `db_user` (`id`) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=46 DEFAULT CHARSET=utf8;

-- ----------------------------
--  Records of `db_contract`
-- ----------------------------
BEGIN;
INSERT INTO `db_contract` VALUES ('19', '2016-005', '常州市环保局', '212000', '江苏省常州市新北区通江中路', '17714817535', '张三', '0519-83276724', '江苏省常州市邦达城科技1', '2120001', '江苏省常州市新北区环保园12', '0519-123456712', '2', '0519-3628123412', '江苏省常州市新北区环保一路水质检测报告', '江苏省常州市新北区环保一路水质检测情况统计', '执法监测', '1', '客户指定的监测方法', '常州市环保局', '噪声项目', '1', '1230', '1', '0', '无其他约定', '2016-10-20', '2', '2016-06-21', '0'), ('20', '2016-006', '常州市环保局', '212000', '江苏省常州市新北区通江中路', '17714817535', '张三', '0519-83276724', '江苏省常州市邦达城科技1', '2120001', '江苏省常州市新北区环保园12', '0519-123456712', '2', '0519-3628123412', '江苏省常州市新北区环保一路水质检测报告', '江苏省常州市新北区环保一路水质检测情况统计', '执法监测', '1', '客户指定的监测方法', '常州市环保局', '噪声项目', '1', '1230', '0', '1', '无其他约定', '2016-10-21', '-4', '2016-06-22', '2'), ('21', '2016-007', '常州市环保局', '212000', '江苏省常州市新北区通江中路', '17714817535', '张三', '0519-83276724', '江苏省常州市邦达城科技1', '2120001', '江苏省常州市新北区环保园12', '0519-123456712', '2', '0519-3628123412', '江苏省常州市新北区环保一路水质检测报告', '江苏省常州市新北区环保一路水质检测情况统计', '执法监测', '1', '客户指定的监测方法', '常州市环保局', '噪声项目', '1', '1230', '1', '1', '无其他约定', '2016-10-22', '1', '2016-06-23', '0'), ('22', '000000', '常州市建设局1', '212000', '江苏省常州市钟楼区', '17714817535', '李四', '323二位', '江苏省常州市邦达城科技1', '2120001', '江苏省常州市新北区环保园12', '0519-123456712', '1', '0519-3628123412', '项目1名称为xxxx', '监测目的为xxxx', '委托监测', '1', '客户指定的方法为xxxx', '12', '32', '2', '123434', '0', '1', '其他约定', '2016-10-23', '-1', '2016-06-24', '0'), ('25', '2016-011', '常州市建设局', '212000', '江苏省常州市钟楼区', '17714817535', '李四', '323二位', '江苏省常州市邦达城科技1', '2120001', '江苏省常州市新北区环保园12', '0519-123456712', '1', '0519-3628123412', '项目2名称为xxxx', '监测目的为xxxx', '执法监测', '1', '客户指定的方法为xxxx', '12', '32', '1', '123434', '0', '0', '其他约定', '2016-10-24', '1', '2016-06-25', '0'), ('26', '000000', '常州市建设局3', '212000', '江苏省常州市钟楼区', '17714817535', '李四', '323二位', '江苏省常州市邦达城科技1', '2120001', '江苏省常州市新北区环保园12', '0519-123456712', '2', '0519-3628123412', '项目3名称为xxxx', '监测目的为xxxx', '执法监测', '1', '客户指定的方法为xxxx', '12', '32', '1', '123434', '1', '0', '其他约定', '2016-10-25', '-1', '2016-06-26', '0'), ('30', '2016-014', '常州市建设局1', '212000', '江苏省常州市钟楼区', '17714817535', '李四', '323二位', '江苏省常州市邦达城科技1', '2120001', '江苏省常州市新北区环保园12', '0519-123456712', '2', '0519-3628123412', '项目1名称为xxxx', '监测目的为xxxx', '执法监测', '1', '客户指定的方法为xxxx', '12', '32', '0', '123434', '1', '0', '其他约定', '2016-10-26', '-2', '2016-10-31', '0'), ('31', '2016-015', '常州市建设局1', '212000', '江苏省常州市钟楼区', '17714817535', '李四', '323二位', '江苏省常州市邦达城科技1', '2120001', '江苏省常州市新北区环保园12', '0519-123456712', '2', '0519-3628123412', '项目1名称为xxxx', '监测目的为xxxx', '委托监测', '1', '客户指定的方法为xxxx', '12', '32', '2', '123434', '1', '0', '其他约定', '2016-10-27', '-2', '2016-10-31', '0'), ('32', '000000', '常州市建设局1', '212000', '江苏省常州市钟楼区', '17714817535', '李四', '323二位', '江苏省常州市邦达城科技1', '2120001', '江苏省常州市新北区环保园12', '0519-123456712', '2', '0519-3628123412', '项目1名称为xxxx', '监测目的为xxxx', '委托监测', '1', '客户指定的方法为xxxx', '12', '32', '2', '123434', '1', '0', '其他约定', '2016-10-28', '-1', '2016-10-31', '0'), ('33', '2016-016', '常州市建设局1', '212000', '江苏省常州市钟楼区', '17714817535', '李四', '323二位', '江苏省常州市邦达城科技1', '2120001', '江苏省常州市新北区环保园12', '0519-123456712', '1', '0519-3628123412', '项目1名称为xxxx', '监测目的为xxxx', '委托监测', '1', '客户指定的方法为xxxx', '12', '32', '2', '123434', '1', '0', '其他约定', '2016-10-29', '-2', '2016-10-31', '0'), ('34', '2016-017', '常州市建设局1', '212000', '江苏省常州市钟楼区', '17714817535', '李四', '323二位', '江苏省常州市邦达城科技1', '2120001', '江苏省常州市新北区环保园12', '0519-123456712', '2', '0519-3628123412', '项目1名称为xxxx', '监测目的为xxxx', '委托监测', '1', '客户指定的方法为xxxx', '12', '32', '2', '123434', '1', '0', '其他约定', '2016-10-30', '-2', '2016-10-31', '0'), ('35', '2016-018', '常州市建设局1', '212000', '江苏省常州市钟楼区', '17714817535', '李四', '323二位', '江苏省常州市邦达城科技1', '2120001', '江苏省常州市新北区环保园12', '0519-123456712', '2', '0519-3628123412', '项目1名称为xxxx', '监测目的为xxxx', '委托监测', '1', '客户指定的方法为xxxx', '12', '32', '2', '123434', '1', '0', '其他约定', '2016-10-31', '-2', '2016-10-31', '0'), ('36', '2016-019', '常州市建设局1', '212000', '江苏省常州市钟楼区', '17714817535', '李四', '323二位', '江苏省常州市邦达城科技1', '2120001', '江苏省常州市新北区环保园12', '0519-123456712', '1', '0519-3628123412', '项目1名称为xxxx', '监测目的为xxxx', '委托监测', '1', '客户指定的方法为xxxx', '12', '32', '2', '123434', '1', '0', '其他约定', '2016-10-22', '2', '2016-10-31', '0'), ('37', '2016-020', '常州市建设局1', '212000', '江苏省常州市钟楼区', '17714817535', '李四', '323二位', '江苏省常州市邦达城科技1', '2120001', '江苏省常州市新北区环保园12', '0519-123456712', '2', '0519-3628123412', '项目1名称为xxxx', '监测目的为xxxx', '委托监测', '1', '客户指定的方法为xxxx', '12', '32', '2', '123434', '1', '0', '其他约定', '2016-10-22', '-2', '2016-10-31', '0'), ('38', '2016-021', '常州市建设局1', '212000', '江苏省常州市钟楼区', '17714817535', '李四', '323二位', '江苏省常州市邦达城科技1', '2120001', '江苏省常州市新北区环保园12', '0519-123456712', '1', '0519-3628123412', '项目1名称为xxxx', '监测目的为xxxx', '委托监测', '1', '客户指定的方法为xxxx', '12', '32', '2', '123434', '1', '0', '其他约定', '2016-10-22', '-2', '2016-10-31', '1'), ('39', '2016-022', '常州市建设局', '212000', '江苏省常州市钟楼区', '17714817535', '李四', '323二位', '12', 'wq', '32', '32', '6', '12', '123', '23', '执法监测', '1', '212', 'wq', '12', '0', '123', '1', '0', '212', '2016-11-07', '-2', '2016-10-31', '0'), ('40', '2016-023', '常州市建设局1', '212000', '江苏省常州市钟楼区', '17714817535', '李四', '323二位', '江苏省常州市邦达城科技1', '2120001', '江苏省常州市新北区环保园12', '0519-123456712', '1', '0519-3628123412', '项目1名称为xxxx', '监测目的为xxxx', '委托监测', '1', '客户指定的方法为xxxx', '12', '32', '2', '123434', '0', '1', '其他约定', '2016-10-23', '-2', '2016-11-03', '0'), ('41', '2016-040', '常州市建设局', '212000', '江苏省常州市钟楼区', '17714817535', '李四', '323二位', '江苏省常州市邦达城科技1', '2120001', '江苏省常州市新北区环保园12', '0519-123456712', '2', '0519-3628123412', '项目名称为xxxx项目名称为xxxx项目名称为xxxx项目名称为xxxx项目名称为xxxx项目名称为xxxx', '监测目的为监测目的为监测目的为监测目的为监测目的为监测目的为监测目的为监测目的为监测目的为监测目的为监测目的为监测目的为监测目的为监测目的为监测目的为监测目的为监测目的为监测目的为监测目的为监测目的为监测目的为监测目的为监测目的为监测目的为监测目的为监测目的为监测目的为监测目的为监测目的为监测目的为监测目的为监测目的为监测目的为监测目的为监测目的为监测目的为监测目的为监测目的为监测目的为监测目的为监测目的为监测目的为监测目的为监测目的为监测目的为', '执法监测', '1', '客户指定的方法为xxxxx', '分包单位为xxxx', '项目为xxxx', '0', '210323', '1', '1', '无其他约定', '2016-12-07', '0', '2016-11-14', '0'), ('42', '2016-041', '常州市建设局3', '212000', '江苏省常州市钟楼区', '17714817535', '李四', '323二位', '江苏省常州市邦达城科技1', '2120001', '江苏省常州市新北区环保园12', '0519-123456712', '2', '0519-3628123412', '项目3名称为xxxx', '监测目的为xxxx', '执法监测', '1', '客户指定的方法为xxxx', '12', '32', '1', '123434', '1', '0', '其他约定', '2016-10-25', '0', '2016-11-14', '0'), ('43', '000000', '常州市建设局1', '212000', '江苏省常州市钟楼区', '17714817535', '李四', '323二位', '江苏省常州市邦达城科技1', '2120001', '江苏省常州市新北区环保园12', '0519-123456712', '1', '0519-3628123412', '合同模板啊啊啊啊啊啊啊', '监测目的为xxxx', '委托监测', '1', '客户指定的方法为xxxx', '12', '32', '2', '123434', '0', '1', '其他约定', '2016-10-23', '-1', '2016-11-15', '0'), ('44', '2016-042', '常州市建设局1', '212000', '江苏省常州市钟楼区', '17714817535', '李四', '323二位', '江苏省常州市邦达城科技1', '2120001', '江苏省常州市新北区环保园12', '0519-123456712', '1', '0519-3628123412', '测试合同审核不在服务器', '监测目的为xxxx', '委托监测', '1', '客户指定的方法为xxxx', '12', '32', '2', '123434', '0', '1', '其他约定', '2016-10-23', '0', '2016-11-15', '0'), ('45', '2016-046', '常州市建设局1', '212000', '江苏省常州市钟楼区', '17714817535', '李四', '323二位', '江苏省常州市邦达城科技1', '2120001', '江苏省常州市新北区环保园12', '0519-123456712', '1', '0519-3628123412', '合同模板啊啊啊啊啊啊啊', '监测目的为xxxx', '委托监测', '1', '客户指定的方法为xxxx', '12', '32', '2', '123434', '0', '1', '其他约定', '2016-10-23', '2', '2016-11-16', '0');
COMMIT;

-- ----------------------------
--  Table structure for `db_customer`
-- ----------------------------
DROP TABLE IF EXISTS `db_customer`;
CREATE TABLE `db_customer` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `client_unit` varchar(255) DEFAULT NULL,
  `client_code` varchar(255) DEFAULT NULL,
  `client_address` varchar(255) DEFAULT NULL,
  `client_tel` varchar(255) DEFAULT NULL,
  `client` varchar(255) DEFAULT NULL,
  `client_fax` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=23 DEFAULT CHARSET=utf8;

-- ----------------------------
--  Records of `db_customer`
-- ----------------------------
BEGIN;
INSERT INTO `db_customer` VALUES ('1', '常州市建设局', '212000', '江苏省常州市钟楼区', '17714817535', '李四', '323二位'), ('2', '常州市环保局', '212000', '江苏省常州市新北区通江中路', '17714817535', '张三', '0519-83276724'), ('3', '常州市政', 'wd', 'sc', 'csx', 'zxcs', 'as'), ('9', 'sdas', 'wfdqw', 'wqwd', 'xasxz', 'wdq', '21'), ('10', 'dwq', 'sca', 'xs', 'aswq', 'wq', '12'), ('11', 'cds', 'sa', 'wq', 're', '212', 'sa'), ('12', 'csa', 'sas', 'ds', 'wew', 'qw', '21'), ('13', 'csd', 'dsd', 'qw', 'sac', 'xc', 'zx'), ('14', 'wq', 'sa', 'cx', ' x', 'zx', 'x '), ('15', 'cds', 'sa', 'wq', 're', '212', 'sa'), ('16', 'csa', 'sas', 'ds', 'wew', 'qw', '21'), ('17', 'csd', 'dsd', 'qw', 'sac', 'xc', 'zx'), ('18', 'wq', 'sa', 'cx', ' x', 'zx', 'x '), ('19', 'cds', 'sa', 'wq', 're', '212', 'sa'), ('20', 'csa', 'sas', 'ds', 'wew', 'qw', '21'), ('21', 'csd', 'dsd', 'qw', 'sac', 'xc', 'zx'), ('22', 'wq', 'sa', 'cx', ' x', 'zx', 'x ');
COMMIT;

-- ----------------------------
--  Table structure for `db_default`
-- ----------------------------
DROP TABLE IF EXISTS `db_default`;
CREATE TABLE `db_default` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `trustee_unit` varchar(255) DEFAULT NULL,
  `trustee_code` varchar(255) DEFAULT NULL,
  `trustee_address` varchar(255) DEFAULT NULL,
  `trustee_tel` varchar(255) DEFAULT NULL,
  `trustee_fax` varchar(255) DEFAULT NULL,
  `trustee` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `trustee` (`trustee`),
  CONSTRAINT `default_user` FOREIGN KEY (`trustee`) REFERENCES `db_user` (`id`) ON DELETE SET NULL ON UPDATE SET NULL
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;

-- ----------------------------
--  Records of `db_default`
-- ----------------------------
BEGIN;
INSERT INTO `db_default` VALUES ('1', '江苏省常州市邦达城科技', '212000', '江苏省常州市新北区环保园', '0519-1234567', '0519-36281234', '4');
COMMIT;

-- ----------------------------
--  Table structure for `db_delivery`
-- ----------------------------
DROP TABLE IF EXISTS `db_delivery`;
CREATE TABLE `db_delivery` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `task_id` int(11) DEFAULT NULL,
  `project_id` int(11) DEFAULT NULL,
  `character` varchar(1000) DEFAULT NULL,
  `storage` varchar(255) DEFAULT NULL,
  `analyst` int(11) DEFAULT NULL,
  `assessor` int(11) DEFAULT NULL,
  `checker` int(11) DEFAULT NULL,
  `analyst_time` date DEFAULT NULL,
  `assessor_time` date DEFAULT NULL,
  `checker_time` date DEFAULT NULL,
  `state` int(11) DEFAULT '0',
  `inspection_path` varchar(2000) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `task_id` (`task_id`),
  KEY `project_id` (`project_id`),
  KEY `analyst` (`analyst`),
  KEY `assessor` (`assessor`),
  KEY `checker` (`checker`),
  CONSTRAINT `db_delivery_ibfk_1` FOREIGN KEY (`task_id`) REFERENCES `db_task` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `db_delivery_ibfk_2` FOREIGN KEY (`project_id`) REFERENCES `db_monitorproject` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `db_delivery_ibfk_3` FOREIGN KEY (`analyst`) REFERENCES `db_user` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `db_delivery_ibfk_4` FOREIGN KEY (`assessor`) REFERENCES `db_user` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `db_delivery_ibfk_5` FOREIGN KEY (`checker`) REFERENCES `db_user` (`id`) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=utf8;

-- ----------------------------
--  Records of `db_delivery`
-- ----------------------------
BEGIN;
INSERT INTO `db_delivery` VALUES ('5', '18', '20', '形状1', '常温', '1', '1', '1', '2016-12-12', '2016-12-03', '2016-12-08', '2', '/Users/qulongjun/project/LIMS_V2/out/artifacts/LIMS_V2_war_exploded/upload\\图3-24.docx'), ('6', '18', '21', '性状2', '低温', '1', '1', '1', '2016-12-12', '2016-12-03', '2016-12-08', '2', '/Users/qulongjun/project/LIMS_V2/out/artifacts/LIMS_V2_war_exploded/upload\\图3-1(2).docx'), ('7', '18', '17', '形状3', '常温', '1', '1', '1', '2016-12-12', null, '2016-12-08', '2', '3'), ('8', '18', '16', '形状4', '低温', '1', '1', '1', '2016-12-12', '2016-12-03', '2016-12-08', '2', '4'), ('11', '26', '19', '固体1', '常温', '1', '1', '1', '2016-12-12', '2016-12-11', '2016-12-11', '2', '/Users/qulongjun/project/LIMS_V2/out/artifacts/LIMS_V2_war_exploded/upload\\jfinal-2.2-manual.pdf'), ('12', '26', '15', '废水3', '低温', '1', '1', '1', '2016-12-12', '2016-12-11', '2016-12-11', '2', '/Users/qulongjun/project/LIMS_V2/out/artifacts/LIMS_V2_war_exploded/upload\\图3-28.docx'), ('13', '26', '13', '废水1', '常温', '1', '1', '1', '2016-12-12', '2016-12-11', '2016-12-11', '2', '7'), ('14', '20', '15', '形状是啥', '低温', '1', '1', '1', '2016-11-28', null, null, '0', '/Users/qulongjun/project/LIMS_V2/out/artifacts/LIMS_V2_war_exploded/upload\\云南七日游计划.numbers');
COMMIT;

-- ----------------------------
--  Table structure for `db_deliveryAssessReject`
-- ----------------------------
DROP TABLE IF EXISTS `db_deliveryAssessReject`;
CREATE TABLE `db_deliveryAssessReject` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `assessor` int(11) DEFAULT NULL,
  `assessor_time` varchar(255) DEFAULT NULL,
  `delivery_id` int(11) DEFAULT NULL,
  `reason` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `assessor` (`assessor`),
  KEY `delivery_id` (`delivery_id`),
  CONSTRAINT `db_deliveryassessreject_ibfk_1` FOREIGN KEY (`assessor`) REFERENCES `db_user` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `db_deliveryassessreject_ibfk_2` FOREIGN KEY (`delivery_id`) REFERENCES `db_delivery` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=utf8;

-- ----------------------------
--  Records of `db_deliveryAssessReject`
-- ----------------------------
BEGIN;
INSERT INTO `db_deliveryAssessReject` VALUES ('7', '1', '2016-11-28 14:09:03', '5', null), ('8', '1', '2016-11-28 14:09:03', '6', null), ('9', '1', '2016-11-28 19:43:14', '6', null), ('10', '1', '2016-11-28 19:45:05', '6', null), ('11', '1', '2016-11-28 19:48:17', '5', null), ('12', '1', '2016-11-28 19:48:17', '6', null), ('13', '1', '2016-11-28 19:58:41', '6', null), ('14', '1', '2016-11-28 20:10:17', '6', null);
COMMIT;

-- ----------------------------
--  Table structure for `db_deliveryCheckReject`
-- ----------------------------
DROP TABLE IF EXISTS `db_deliveryCheckReject`;
CREATE TABLE `db_deliveryCheckReject` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `checker` int(11) DEFAULT NULL,
  `checker_time` varchar(255) DEFAULT NULL,
  `delivery_id` int(11) DEFAULT NULL,
  `reason` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `assessor` (`checker`),
  KEY `delivery_id` (`delivery_id`),
  CONSTRAINT `db_deliverycheckreject_ibfk_1` FOREIGN KEY (`checker`) REFERENCES `db_user` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `db_deliverycheckreject_ibfk_2` FOREIGN KEY (`delivery_id`) REFERENCES `db_delivery` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=18 DEFAULT CHARSET=utf8;

-- ----------------------------
--  Records of `db_deliveryCheckReject`
-- ----------------------------
BEGIN;
INSERT INTO `db_deliveryCheckReject` VALUES ('7', '1', '2016-11-28 14:09:03', '5', null), ('8', '1', '2016-11-28 14:09:03', '6', null), ('9', '1', '2016-11-28 19:43:14', '6', null), ('10', '1', '2016-11-28 19:45:05', '6', null), ('11', '1', '2016-11-28 19:48:17', '5', null), ('12', '1', '2016-11-28 19:48:17', '6', null), ('13', '1', '2016-11-28 19:58:41', '6', null), ('14', '1', '2016-11-28 20:10:17', '6', null), ('15', '1', '2016-12-08 20:47:22', '11', null), ('16', '1', '2016-12-08 20:47:22', '12', null), ('17', '1', '2016-12-08 20:48:56', '11', null);
COMMIT;

-- ----------------------------
--  Table structure for `db_deliveryoriginrecord`
-- ----------------------------
DROP TABLE IF EXISTS `db_deliveryoriginrecord`;
CREATE TABLE `db_deliveryoriginrecord` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `delivery_id` int(11) DEFAULT NULL,
  `originRecord_path` varchar(2000) DEFAULT NULL,
  `name` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `delivery_id` (`delivery_id`),
  CONSTRAINT `db_deliveryoriginrecord_ibfk_1` FOREIGN KEY (`delivery_id`) REFERENCES `db_delivery` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=44 DEFAULT CHARSET=utf8;

-- ----------------------------
--  Records of `db_deliveryoriginrecord`
-- ----------------------------
BEGIN;
INSERT INTO `db_deliveryoriginrecord` VALUES ('23', '14', '/Users/qulongjun/project/LIMS_V2/out/artifacts/LIMS_V2_war_exploded/upload\\云南七日游计划1.xlsx', '原始记录1'), ('24', '14', '/Users/qulongjun/project/LIMS_V2/out/artifacts/LIMS_V2_war_exploded/upload\\云南七日游计划2.xlsx', '原始记录2'), ('36', '5', '/Users/qulongjun/project/LIMS_V2/out/artifacts/LIMS_V2_war_exploded/upload\\图3-25.docx', 'ewew'), ('37', '5', '/Users/qulongjun/project/LIMS_V2/out/artifacts/LIMS_V2_war_exploded/upload\\图3-26.docx', 'dew'), ('38', '6', '/Users/qulongjun/project/LIMS_V2/out/artifacts/LIMS_V2_war_exploded/upload\\图3-1(1).docx', 'dfd'), ('39', '8', '/Users/qulongjun/project/LIMS_V2/out/artifacts/LIMS_V2_war_exploded/upload\\图3-1(2)1.docx', 'few'), ('41', '5', '/Users/qulongjun/project/LIMS_V2/out/artifacts/LIMS_V2_war_exploded/upload\\图3-27.docx', 'fe'), ('42', '8', '/Users/qulongjun/project/LIMS_V2/out/artifacts/LIMS_V2_war_exploded/upload\\图3-1(2)2.docx', 'wew'), ('43', '7', '/Users/qulongjun/project/LIMS_V2/out/artifacts/LIMS_V2_war_exploded/upload\\图3-1(2)3.docx', 'ew');
COMMIT;

-- ----------------------------
--  Table structure for `db_department`
-- ----------------------------
DROP TABLE IF EXISTS `db_department`;
CREATE TABLE `db_department` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `state` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=34 DEFAULT CHARSET=utf8;

-- ----------------------------
--  Records of `db_department`
-- ----------------------------
BEGIN;
INSERT INTO `db_department` VALUES ('1', '综合办公室', '0'), ('2', '实验室', '0'), ('3', '主任办公室', '0'), ('4', '实验分析室', '0'), ('5', '质量控制室', '0'), ('6', '张三wqx21', '0'), ('7', '张三', '1'), ('8', '张三', '1'), ('9', '张三', '0'), ('10', '张三d前端', '2'), ('11', '张三', '0'), ('12', '张三', '0'), ('13', '张三', '1'), ('14', '张三2', '1'), ('15', '张三dsdv', '0'), ('16', '张三sasq', '0'), ('17', 'wq张三', '0'), ('18', '12wqw', '1'), ('19', '12完全爱上查', '1'), ('20', '', '0'), ('21', '12wq', '0'), ('22', '2ew', '0'), ('23', '1', '0'), ('24', 'a', '0'), ('25', '12', '0'), ('26', '123', '0'), ('27', '4123', '0'), ('28', '4123asc', '0'), ('29', '23wq', '0'), ('30', 'daijigu', '0'), ('31', 'daijigud', '0'), ('32', 'daijigud的', '0'), ('33', 'sdasdsc', '0');
COMMIT;

-- ----------------------------
--  Table structure for `db_experience_first`
-- ----------------------------
DROP TABLE IF EXISTS `db_experience_first`;
CREATE TABLE `db_experience_first` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `firstResult1` int(11) DEFAULT NULL,
  `firstResult2` int(11) DEFAULT NULL,
  `firstResult3` int(11) DEFAULT NULL,
  `firstResult4` int(11) DEFAULT NULL,
  `firstResult5` int(11) DEFAULT NULL,
  `firstResult6` int(11) DEFAULT NULL,
  `other` varchar(2000) DEFAULT NULL,
  `result_user` int(11) DEFAULT NULL,
  `result_time` varchar(255) DEFAULT NULL,
  `task_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `result_user` (`result_user`),
  KEY `task_id` (`task_id`),
  CONSTRAINT `db_experience_first_ibfk_1` FOREIGN KEY (`result_user`) REFERENCES `db_user` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `db_experience_first_ibfk_2` FOREIGN KEY (`task_id`) REFERENCES `db_task` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8;

-- ----------------------------
--  Records of `db_experience_first`
-- ----------------------------
BEGIN;
INSERT INTO `db_experience_first` VALUES ('1', '0', '1', '2', '0', '1', '2', '其他备注信息', '1', '2016-12-10 10:58:38', '18'), ('2', '0', '1', '2', '0', '1', '2', '其他', '1', '2016-12-10 11:01:47', '18'), ('3', '0', '1', '2', '0', '1', '2', '123', '1', '2016-12-10 11:02:46', '18'), ('4', '0', '1', '2', '0', '1', '2', '1234', '1', '2016-12-10 12:44:34', '18'), ('5', '1', '1', '0', '1', '1', '0', '这是其他信息这是其他信息这是其他信息这是其他信息这是其他信息这是其他信息', '1', '2016-12-10 13:21:14', '18'), ('6', '0', '0', '0', '0', '0', '0', '123', '1', '2016-12-10 15:16:29', '26'), ('7', '0', '1', '0', '0', '0', '1', '123456', '1', '2016-12-10 15:37:03', '26'), ('8', '0', '1', '0', '2', '0', '1', '测试', '1', '2016-12-10 15:43:51', '26'), ('9', '1', '0', '2', '0', '2', '1', '反弹也发一份', '1', '2016-12-10 21:03:12', '26'), ('10', '0', '1', '2', '0', '1', '0', '无其他信息', '1', '2016-12-11 10:57:55', '26'), ('11', '0', '1', '1', '0', '1', '2', '123', '1', '2016-12-11 11:01:39', '26');
COMMIT;

-- ----------------------------
--  Table structure for `db_experience_second`
-- ----------------------------
DROP TABLE IF EXISTS `db_experience_second`;
CREATE TABLE `db_experience_second` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `secondResult1` int(11) DEFAULT NULL,
  `secondResult2` int(11) DEFAULT NULL,
  `secondResult3` int(11) DEFAULT NULL,
  `secondResult4` int(11) DEFAULT NULL,
  `secondResult5` int(11) DEFAULT NULL,
  `secondResult6` int(11) DEFAULT NULL,
  `other` varchar(2000) DEFAULT NULL,
  `result_user` int(11) DEFAULT NULL,
  `result_time` varchar(255) DEFAULT NULL,
  `task_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `result_user` (`result_user`),
  KEY `task_id` (`task_id`),
  CONSTRAINT `db_experience_second_ibfk_1` FOREIGN KEY (`result_user`) REFERENCES `db_user` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `db_experience_second_ibfk_2` FOREIGN KEY (`task_id`) REFERENCES `db_task` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8;

-- ----------------------------
--  Records of `db_experience_second`
-- ----------------------------
BEGIN;
INSERT INTO `db_experience_second` VALUES ('10', '1', '2', '0', '1', '2', '2', '其他信息呢2', '1', '2016-12-11 10:44:27', '18'), ('11', '0', '1', '0', '1', '0', '1', '测试二审', '1', '2016-12-11 10:56:53', '26'), ('12', '0', '1', '2', '0', '1', '0', '456', '1', '2016-12-11 11:01:58', '26');
COMMIT;

-- ----------------------------
--  Table structure for `db_feedback`
-- ----------------------------
DROP TABLE IF EXISTS `db_feedback`;
CREATE TABLE `db_feedback` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `type` varchar(255) DEFAULT NULL,
  `content` varchar(2000) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;

-- ----------------------------
--  Records of `db_feedback`
-- ----------------------------
BEGIN;
INSERT INTO `db_feedback` VALUES ('1', '系统缺陷(bug)', '测试反馈内容'), ('2', '功能缺失', '再反馈一个事实');
COMMIT;

-- ----------------------------
--  Table structure for `db_identify`
-- ----------------------------
DROP TABLE IF EXISTS `db_identify`;
CREATE TABLE `db_identify` (
  `id` int(11) NOT NULL,
  `contract_id` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
--  Records of `db_identify`
-- ----------------------------
BEGIN;
INSERT INTO `db_identify` VALUES ('1', '47');
COMMIT;

-- ----------------------------
--  Table structure for `db_inspectiontemplate`
-- ----------------------------
DROP TABLE IF EXISTS `db_inspectiontemplate`;
CREATE TABLE `db_inspectiontemplate` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL,
  `path` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8;

-- ----------------------------
--  Records of `db_inspectiontemplate`
-- ----------------------------
BEGIN;
INSERT INTO `db_inspectiontemplate` VALUES ('8', '废气样品送检单', 'G:\\LIMS_V2\\out\\artifacts\\LIMS_V2_war_exploded\\upload\\5、BEM-QPBS2907环境空气和无组织废气样品送检单.docx'), ('9', '土壤、底质送检单', 'G:\\LIMS_V2\\out\\artifacts\\LIMS_V2_war_exploded\\upload\\5、BEM-QPBS2904土壤、底质样品送检单.doc'), ('10', '噪声送检单', 'G:\\LIMS_V2\\out\\artifacts\\LIMS_V2_war_exploded\\upload\\5、BEM-QPBS2905固定污染源有组织废气样品送检单.docx');
COMMIT;

-- ----------------------------
--  Table structure for `db_item_project`
-- ----------------------------
DROP TABLE IF EXISTS `db_item_project`;
CREATE TABLE `db_item_project` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `item_id` int(11) NOT NULL,
  `project_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `item_id` (`item_id`),
  KEY `project_id` (`project_id`),
  CONSTRAINT `db_item_project_ibfk_1` FOREIGN KEY (`item_id`) REFERENCES `db_monitoritem` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `db_item_project_ibfk_2` FOREIGN KEY (`project_id`) REFERENCES `db_monitorproject` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=89 DEFAULT CHARSET=utf8;

-- ----------------------------
--  Records of `db_item_project`
-- ----------------------------
BEGIN;
INSERT INTO `db_item_project` VALUES ('4', '20', '13'), ('5', '20', '14'), ('6', '20', '15'), ('7', '21', '16'), ('8', '21', '17'), ('9', '21', '18'), ('10', '22', '13'), ('11', '22', '14'), ('12', '22', '15'), ('13', '23', '16'), ('14', '23', '17'), ('15', '23', '18'), ('16', '24', '13'), ('17', '24', '14'), ('18', '24', '15'), ('19', '25', '16'), ('20', '25', '17'), ('21', '25', '18'), ('22', '26', '14'), ('25', '29', '14'), ('26', '30', '14'), ('51', '39', '10'), ('52', '39', '11'), ('53', '39', '12'), ('54', '40', '16'), ('55', '40', '17'), ('56', '40', '18'), ('63', '43', '16'), ('64', '43', '17'), ('65', '44', '20'), ('66', '44', '21'), ('67', '45', '16'), ('68', '45', '17'), ('69', '46', '19'), ('70', '46', '20'), ('71', '47', '13'), ('72', '47', '14'), ('73', '47', '15'), ('74', '48', '19'), ('75', '48', '20'), ('76', '49', '10'), ('77', '49', '11'), ('78', '49', '12'), ('79', '50', '16'), ('80', '50', '17'), ('81', '50', '18'), ('82', '51', '9'), ('83', '51', '10'), ('84', '51', '11'), ('85', '52', '17'), ('86', '53', '9'), ('87', '54', '10'), ('88', '55', '17');
COMMIT;

-- ----------------------------
--  Table structure for `db_mail`
-- ----------------------------
DROP TABLE IF EXISTS `db_mail`;
CREATE TABLE `db_mail` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `title` varchar(2000) DEFAULT NULL,
  `content` varchar(10000) DEFAULT NULL,
  `sender` int(11) DEFAULT NULL,
  `send_time` date DEFAULT NULL,
  `state` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `sender` (`sender`),
  CONSTRAINT `db_mail_ibfk_1` FOREIGN KEY (`sender`) REFERENCES `db_user` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8;

-- ----------------------------
--  Records of `db_mail`
-- ----------------------------
BEGIN;
INSERT INTO `db_mail` VALUES ('4', '邮件主题是sxxxxxxx邮件主题是sxxxxxxx邮件主题是sxxxxxxx', '<h1><ul><li><u><i><b><span class=\"wysiwyg-color-red\">这是一段正文的c测试内容，来判断正文sh否z横渠d s</span></b></i></u></li></ul></h1>', '1', '2016-11-22', '0'), ('5', '写一份信关于测试邮件的', '<blockquote><blockquote><blockquote><blockquote><blockquote><blockquote><blockquote><blockquote><blockquote><h1>这是一个标题</h1></blockquote></blockquote></blockquote></blockquote></blockquote></blockquote></blockquote></blockquote></blockquote>这是一段问题，用来都表示的冯绍峰这是一段问题，用来都表示的冯绍峰这是一段问题，用来都表示的冯绍峰这是一段问题，用来都表示的冯绍峰这是一段问题，用来都表示的冯绍峰这是一段问题，用来都表示的冯绍峰这是一段问题，用来都表示的冯绍峰这是一段问题，用来都表示的冯绍峰这是一段问题，用来都表示的冯绍峰这是一段问题，用来都表示的冯绍峰这是一段问题，用来都表示的冯绍峰这是一段问题，用来都表示的冯绍峰这是一段问题，用来都表示的冯绍峰这是一段问题，用来都表示的冯绍峰这是一段问题，用来都表示的冯绍峰这是一段问题，用来都表示的冯绍峰这是一段问题，用来都表示的冯绍峰这是一段问题，用来都表示的冯绍峰这是一段问题，用来都表示的冯绍峰这是一段问题，用来都表示的冯绍峰这是一段问题，用来都表示的冯绍峰这是一段问题，用来都表示的冯绍峰<span>这是一段问题，用来都表示的冯绍峰</span><br>', '1', '2016-11-22', '0'), ('6', '测试已删除', '<blockquote><blockquote><blockquote><blockquote><blockquote><blockquote><blockquote><blockquote><blockquote><h1>这是一个删除的标题</h1></blockquote></blockquote></blockquote></blockquote></blockquote></blockquote></blockquote></blockquote></blockquote>这是一段问题，用来都表示的冯绍峰这是一段问题，用来都表示的冯绍峰这是一段问题，用来都表示的冯绍峰这是一段问题，用来都表示的冯绍峰这是一段问题，用来都表示的冯绍峰这是一段问题，用来都表示的冯绍峰这是一段问题，用来都表示的冯绍峰这是一段问题，用来都表示的冯绍峰这是一段问题，用来都表示的冯绍峰这是一段问题，用来都表示的冯绍峰这是一段问题，用来都表示的冯绍峰这是一段问题，用来都表示的冯绍峰这是一段问题，用来都表示的冯绍峰这是一段问题，用来都表示的冯绍峰这是一段问题，用来都表示的冯绍峰这是一段问题，用来都表示的冯绍峰这是一段问题，用来都表示的冯绍峰这是一段问题，用来都表示的冯绍峰这是一段问题，用来都表示的冯绍峰这是一段问题，用来都表示的冯绍峰这是一段问题，用来都表示的冯绍峰这是一段问题，用来都表示的冯绍峰<span>这是一段问题，用来都表示的冯绍峰</span><br>', '1', '2016-11-22', '0'), ('7', '测试星标邮件箱', '<blockquote><blockquote><blockquote><blockquote><blockquote><blockquote><blockquote><blockquote><blockquote><h1>这是一个星标的标题</h1></blockquote></blockquote></blockquote></blockquote></blockquote></blockquote></blockquote></blockquote></blockquote>这是一段问题，用来都表示的冯绍峰这是一段问题，用来都表示的冯绍峰这是一段问题，用来都表示的冯绍峰这是一段问题，用来都表示的冯绍峰这是一段问题，用来都表示的冯绍峰这是一段问题，用来都表示的冯绍峰这是一段问题，用来都表示的冯绍峰这是一段问题，用来都表示的冯绍峰这是一段问题，用来都表示的冯绍峰这是一段问题，用来都表示的冯绍峰这是一段问题，用来都表示的冯绍峰这是一段问题，用来都表示的冯绍峰这是一段问题，用来都表示的冯绍峰这是一段问题，用来都表示的冯绍峰这是一段问题，用来都表示的冯绍峰这是一段问题，用来都表示的冯绍峰这是一段问题，用来都表示的冯绍峰这是一段问题，用来都表示的冯绍峰这是一段问题，用来都表示的冯绍峰这是一段问题，用来都表示的冯绍峰这是一段问题，用来都表示的冯绍峰这是一段问题，用来都表示的冯绍峰<span>这是一段问题，用来都表示的冯绍峰</span><br>', '1', '2016-11-22', '0');
COMMIT;

-- ----------------------------
--  Table structure for `db_mailreceiver`
-- ----------------------------
DROP TABLE IF EXISTS `db_mailreceiver`;
CREATE TABLE `db_mailreceiver` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `mail_id` int(11) DEFAULT NULL,
  `user_id` int(11) DEFAULT NULL,
  `state` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `mail_id` (`mail_id`),
  KEY `user_id` (`user_id`),
  CONSTRAINT `db_mailreceiver_ibfk_1` FOREIGN KEY (`mail_id`) REFERENCES `db_mail` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `db_mailreceiver_ibfk_2` FOREIGN KEY (`user_id`) REFERENCES `db_user` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8;

-- ----------------------------
--  Records of `db_mailreceiver`
-- ----------------------------
BEGIN;
INSERT INTO `db_mailreceiver` VALUES ('1', '4', '1', '1'), ('2', '4', '2', '-1'), ('3', '4', '7', '0'), ('4', '4', '9', '0'), ('5', '5', '1', '-1'), ('6', '6', '1', '1'), ('7', '7', '1', '-2');
COMMIT;

-- ----------------------------
--  Table structure for `db_monitorcategory`
-- ----------------------------
DROP TABLE IF EXISTS `db_monitorcategory`;
CREATE TABLE `db_monitorcategory` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `state` int(11) NOT NULL,
  `inspection_template` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `inspection_template` (`inspection_template`),
  CONSTRAINT `db_monitorcategory_ibfk_1` FOREIGN KEY (`inspection_template`) REFERENCES `db_inspectiontemplate` (`id`) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8;

-- ----------------------------
--  Records of `db_monitorcategory`
-- ----------------------------
BEGIN;
INSERT INTO `db_monitorcategory` VALUES ('6', '废气', '0', '8'), ('7', '废水', '0', null), ('8', '噪声', '0', '10'), ('9', '固体污染物', '0', '9'), ('10', '流体2', '1', null), ('11', '流体3', '1', null);
COMMIT;

-- ----------------------------
--  Table structure for `db_monitorfrequency`
-- ----------------------------
DROP TABLE IF EXISTS `db_monitorfrequency`;
CREATE TABLE `db_monitorfrequency` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8;

-- ----------------------------
--  Records of `db_monitorfrequency`
-- ----------------------------
BEGIN;
INSERT INTO `db_monitorfrequency` VALUES ('7', '一天/次'), ('8', '一周/次'), ('9', '一月/次2'), ('10', '一年/2次'), ('11', 'cesh'), ('12', 'ces2');
COMMIT;

-- ----------------------------
--  Table structure for `db_monitoritem`
-- ----------------------------
DROP TABLE IF EXISTS `db_monitoritem`;
CREATE TABLE `db_monitoritem` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `contract_id` int(11) DEFAULT NULL,
  `task_id` int(11) DEFAULT NULL,
  `category_id` int(11) DEFAULT NULL,
  `frequency` varchar(255) DEFAULT NULL,
  `monitor_point` varchar(255) DEFAULT NULL,
  `other` varchar(2000) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `contract_id` (`contract_id`),
  KEY `category_id` (`category_id`),
  KEY `category_id_2` (`category_id`),
  KEY `category_id_3` (`category_id`),
  KEY `task_id` (`task_id`),
  CONSTRAINT `db_monitoritem_ibfk_2` FOREIGN KEY (`category_id`) REFERENCES `db_monitorcategory` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `db_monitoritem_ibfk_3` FOREIGN KEY (`contract_id`) REFERENCES `db_contract` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `db_monitoritem_ibfk_4` FOREIGN KEY (`task_id`) REFERENCES `db_task` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=56 DEFAULT CHARSET=utf8;

-- ----------------------------
--  Records of `db_monitoritem`
-- ----------------------------
BEGIN;
INSERT INTO `db_monitoritem` VALUES ('20', '19', null, '7', '一周/次', '监测点1;监测点2;监测点3;监测点4;监测点5', '无备注信息'), ('21', '19', null, '8', '一周/次', '监测点6;监测点7;监测点8', '无备注信息'), ('22', '20', null, '7', '一周/次', '监测点1;监测点2;监测点3;监测点4;监测点5', '无备注信息'), ('23', '20', null, '8', '一周/次', '监测点6;监测点7;监测点8', '无备注信息'), ('24', '21', null, '7', '一周/次', '监测点1;监测点2;监测点3;监测点4;监测点5', '无备注信息'), ('25', '21', null, '8', '一周/次', '监测点6;监测点7;监测点8', '无备注信息'), ('26', '22', null, '7', '一月/次', '监测点1;监测点2;监测点3;监测点4', '无备注'), ('29', '25', null, '7', '一月/次', '监测点1;监测点2;监测点3;监测点4', '无备注'), ('30', '26', null, '7', '一月/次', '监测点1;监测点2;监测点3;监测点4', '无备注'), ('39', null, '11', '6', '一周/次', '监测点1;监测点2;监测点3;监测点4', '备注信息为xxxx'), ('40', null, '11', '8', '一月/次', '监测点1;监测点2;监测5;监测6', '啦啦啦啦'), ('43', null, '18', '8', '一月/次', '增加1;检测2;检测3', '无备注'), ('44', null, '18', '9', '一月/次', '增加4;检测5;检测6', '无备足'), ('45', null, '19', '8', '一周/次', '监测点1;监测点2;监测点3', ''), ('46', null, '19', '9', '一周/次', '监测点4;监测点5;监测点6', ''), ('47', null, '26', '7', '一周/次', '废水1;废水2;废水3;废水4;废水5', ''), ('48', null, '26', '9', '一月/次', '固定污染物1;固定污染物2;固定污染物3;固定污染物4;固定污染物5', ''), ('49', '41', null, '6', '一周/次', '废气1;废气2;废气4;废气3;废气5', '无备注信息'), ('50', '41', null, '8', '一月/次', '监测点1;检测2', '无备注信息'), ('51', '44', null, '6', '一月/次', '废气1;废气2;废气3;废气4;废气5', ''), ('52', '44', null, '8', '一月/次', '监测点6;减肥的6', ''), ('53', '45', null, '6', '一周/次', '1;2;3;4', ''), ('54', null, '29', '6', 'cesh', '1', '23'), ('55', null, '29', '8', 'cesh', '123', '123');
COMMIT;

-- ----------------------------
--  Table structure for `db_monitorproject`
-- ----------------------------
DROP TABLE IF EXISTS `db_monitorproject`;
CREATE TABLE `db_monitorproject` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `desp` varchar(255) DEFAULT NULL,
  `state` int(11) NOT NULL,
  `category_id` int(11) NOT NULL,
  `chargeDepart` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `category_id` (`category_id`),
  KEY `chargeDepart` (`chargeDepart`),
  CONSTRAINT `db_monitorproject_ibfk_1` FOREIGN KEY (`chargeDepart`) REFERENCES `db_department` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `project_category` FOREIGN KEY (`category_id`) REFERENCES `db_monitorcategory` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=29 DEFAULT CHARSET=utf8;

-- ----------------------------
--  Records of `db_monitorproject`
-- ----------------------------
BEGIN;
INSERT INTO `db_monitorproject` VALUES ('9', '废气一', '关于废气的监测项目', '0', '6', '4'), ('10', '废气二', '关于废气的监测项目', '0', '6', '4'), ('11', '废气三', '关于废气的监测项目', '0', '6', '4'), ('12', '废气四', '关于废气的监测项目', '0', '6', '4'), ('13', '废水一', '关于废水的监测项目', '0', '7', '4'), ('14', '废水二', '关于废水的监测项目', '0', '7', '4'), ('15', '废水三', '关于废水的监测项目', '0', '7', '4'), ('16', '噪声一', '关于噪声的监测项目', '0', '8', '4'), ('17', '噪声二', '关于噪声的监测项目', '0', '8', '4'), ('18', '噪声三', '关于噪声的监测项目', '0', '8', '4'), ('19', '固体一', '关于固体的监测项目', '0', '9', '4'), ('20', '固体二', '关于固体的监测项目', '0', '9', '4'), ('21', '固体三', '关于固体的监测项目', '0', '9', '4'), ('27', '固体四', '固体四', '0', '9', '4'), ('28', '固体五2', '测试2', '1', '9', '2');
COMMIT;

-- ----------------------------
--  Table structure for `db_originrecordtemplate`
-- ----------------------------
DROP TABLE IF EXISTS `db_originrecordtemplate`;
CREATE TABLE `db_originrecordtemplate` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(1000) DEFAULT NULL,
  `path` varchar(2000) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8;

-- ----------------------------
--  Records of `db_originrecordtemplate`
-- ----------------------------
BEGIN;
INSERT INTO `db_originrecordtemplate` VALUES ('7', '功能区环境噪声测量记录表', 'G:\\LIMS_V2\\out\\artifacts\\LIMS_V2_war_exploded\\upload\\01 功能区环境噪声测量记录表.docx'), ('8', '交通道路声环境监测记录表', 'G:\\LIMS_V2\\out\\artifacts\\LIMS_V2_war_exploded\\upload\\02 交通道路声环境监测记录表.docx'), ('9', '颗粒物、流速、温度CEMS准确度检测记录表', 'G:\\LIMS_V2\\out\\artifacts\\LIMS_V2_war_exploded\\upload\\03颗粒物、流速、温度CEMS准确度检测记录表.doc');
COMMIT;

-- ----------------------------
--  Table structure for `db_properties`
-- ----------------------------
DROP TABLE IF EXISTS `db_properties`;
CREATE TABLE `db_properties` (
  `id` int(11) NOT NULL,
  `sample_receive_self` int(11) DEFAULT '0',
  `sample_receive_scene` int(11) DEFAULT '0',
  `sample_receive_self_role` int(11) DEFAULT '0',
  `sample_receive_scene_role` int(11) DEFAULT '0',
  `sample_self_middle` varchar(255) DEFAULT NULL,
  `sample_scene_middle` varchar(255) DEFAULT NULL,
  `sample_self_serial` int(11) DEFAULT NULL,
  `sample_scene_serial` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
--  Records of `db_properties`
-- ----------------------------
BEGIN;
INSERT INTO `db_properties` VALUES ('1', '1', '2', '2', '4', 'Z', 'A', '34', '7');
COMMIT;

-- ----------------------------
--  Table structure for `db_qualitycontroller`
-- ----------------------------
DROP TABLE IF EXISTS `db_qualitycontroller`;
CREATE TABLE `db_qualitycontroller` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `task_id` int(11) DEFAULT NULL,
  `project_id` int(11) DEFAULT NULL,
  `blind` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `task_id` (`task_id`),
  KEY `project_id` (`project_id`),
  CONSTRAINT `db_qualitycontroller_ibfk_1` FOREIGN KEY (`task_id`) REFERENCES `db_task` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `db_qualitycontroller_ibfk_2` FOREIGN KEY (`project_id`) REFERENCES `db_monitorproject` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=utf8;

-- ----------------------------
--  Records of `db_qualitycontroller`
-- ----------------------------
BEGIN;
INSERT INTO `db_qualitycontroller` VALUES ('1', '26', '15', '15'), ('2', '26', '15', '15'), ('7', '18', '21', '2'), ('8', '18', '20', '123'), ('9', '18', '17', '5'), ('10', '18', '16', '2'), ('11', '20', '15', '12'), ('12', '20', '15', '12'), ('13', '20', '15', '12');
COMMIT;

-- ----------------------------
--  Table structure for `db_qualitylab`
-- ----------------------------
DROP TABLE IF EXISTS `db_qualitylab`;
CREATE TABLE `db_qualitylab` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `quality_id` int(11) DEFAULT NULL,
  `sample_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `quality_id` (`quality_id`),
  KEY `sample_id` (`sample_id`),
  CONSTRAINT `db_qualitylab_ibfk_1` FOREIGN KEY (`quality_id`) REFERENCES `db_qualitycontroller` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `db_qualitylab_ibfk_2` FOREIGN KEY (`sample_id`) REFERENCES `db_sample` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=utf8;

-- ----------------------------
--  Records of `db_qualitylab`
-- ----------------------------
BEGIN;
INSERT INTO `db_qualitylab` VALUES ('1', '1', '50'), ('2', '1', '51'), ('3', '2', '48'), ('4', '2', '49'), ('8', '8', '54'), ('9', '9', '53'), ('10', '10', '54'), ('11', '11', '47'), ('12', '12', '47'), ('13', '13', '47');
COMMIT;

-- ----------------------------
--  Table structure for `db_qualitymark`
-- ----------------------------
DROP TABLE IF EXISTS `db_qualitymark`;
CREATE TABLE `db_qualitymark` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `quality_id` int(11) DEFAULT NULL,
  `sample_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `quality_id` (`quality_id`),
  KEY `sample_id` (`sample_id`),
  CONSTRAINT `db_qualitymark_ibfk_1` FOREIGN KEY (`quality_id`) REFERENCES `db_qualitycontroller` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `db_qualitymark_ibfk_2` FOREIGN KEY (`sample_id`) REFERENCES `db_sample` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=17 DEFAULT CHARSET=utf8;

-- ----------------------------
--  Records of `db_qualitymark`
-- ----------------------------
BEGIN;
INSERT INTO `db_qualitymark` VALUES ('1', '1', '49'), ('2', '1', '48'), ('3', '2', '50'), ('4', '2', '51'), ('10', '7', '52'), ('11', '8', '53'), ('12', '9', '54'), ('13', '10', '54'), ('14', '11', '47'), ('15', '12', '47'), ('16', '13', '47');
COMMIT;

-- ----------------------------
--  Table structure for `db_qualityscene`
-- ----------------------------
DROP TABLE IF EXISTS `db_qualityscene`;
CREATE TABLE `db_qualityscene` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `quality_id` int(11) DEFAULT NULL,
  `sample_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `quality_id` (`quality_id`),
  KEY `sample_id` (`sample_id`),
  CONSTRAINT `db_qualityscene_ibfk_1` FOREIGN KEY (`quality_id`) REFERENCES `db_qualitycontroller` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `db_qualityscene_ibfk_2` FOREIGN KEY (`sample_id`) REFERENCES `db_sample` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=17 DEFAULT CHARSET=utf8;

-- ----------------------------
--  Records of `db_qualityscene`
-- ----------------------------
BEGIN;
INSERT INTO `db_qualityscene` VALUES ('1', '1', '48'), ('2', '1', '49'), ('3', '1', '50'), ('4', '2', '50'), ('5', '2', '51'), ('6', '2', '49'), ('10', '7', '52'), ('11', '8', '53'), ('12', '8', '54'), ('13', '9', '54'), ('14', '11', '47'), ('15', '12', '47'), ('16', '13', '47');
COMMIT;

-- ----------------------------
--  Table structure for `db_role`
-- ----------------------------
DROP TABLE IF EXISTS `db_role`;
CREATE TABLE `db_role` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `department_id` int(11) NOT NULL,
  `state` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `department_id` (`department_id`),
  CONSTRAINT `fk_role_department` FOREIGN KEY (`department_id`) REFERENCES `db_department` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8;

-- ----------------------------
--  Records of `db_role`
-- ----------------------------
BEGIN;
INSERT INTO `db_role` VALUES ('1', '部门主管1', '3', '0'), ('2', '科室主任s', '1', '0'), ('3', '部门主管', '3', '0'), ('4', '二位2', '2', '0'), ('5', '12211', '2', '1'), ('6', '所产生的', '3', '0'), ('7', 'dqw', '2', '0'), ('8', '122的', '3', '0'), ('9', '成都市', '3', '0'), ('10', '23', '2', '0');
COMMIT;

-- ----------------------------
--  Table structure for `db_sample`
-- ----------------------------
DROP TABLE IF EXISTS `db_sample`;
CREATE TABLE `db_sample` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `identify` varchar(255) DEFAULT NULL,
  `name` varchar(255) DEFAULT NULL,
  `feature` varchar(255) DEFAULT NULL,
  `condition` varchar(255) DEFAULT NULL,
  `color` varchar(255) DEFAULT NULL,
  `state` int(11) DEFAULT '0',
  `task_id` int(11) DEFAULT NULL,
  `receive` int(10) unsigned zerofill DEFAULT '0000000000',
  PRIMARY KEY (`id`),
  KEY `task_id` (`task_id`),
  CONSTRAINT `db_sample_ibfk_1` FOREIGN KEY (`task_id`) REFERENCES `db_task` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=66 DEFAULT CHARSET=utf8;

-- ----------------------------
--  Records of `db_sample`
-- ----------------------------
BEGIN;
INSERT INTO `db_sample` VALUES ('46', 'LXZ0027', '样品1', 'G', '+', '红色', '0', '11', '0'), ('47', 'ZFZ0028', '撒', 'G', '+', '红色', '0', '20', '1'), ('48', 'LXA0004', '样品1', 'G', '+', '红色', '0', '26', '1'), ('49', 'LXA0005', '样品2', 'S', '+', '绿色', '0', '26', '1'), ('50', 'LXA0006', '样品3', 'S', '-', '白色', '0', '26', '1'), ('51', 'LXA0007', '样品4', 'L', '+', '棕色', '0', '26', '1'), ('52', 'LXZ0029', '样品1', 'G', '+', '红色', '0', '18', '1'), ('53', 'LXZ0030', '样品2', 'L', '-', '白色', '0', '18', '1'), ('54', 'LXZ0031', '样品3', 'S', '+', '绿色', '0', '18', '1'), ('63', 'WTZ0032', '1', 'G', '+', '23', '0', '28', '1'), ('64', 'WTZ0033', '2', 'L', '+', '32', '0', '28', '0'), ('65', 'WTZ0034', '3', 'G', '-', '12', '0', '28', '0');
COMMIT;

-- ----------------------------
--  Table structure for `db_sampleproject`
-- ----------------------------
DROP TABLE IF EXISTS `db_sampleproject`;
CREATE TABLE `db_sampleproject` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `sample_id` int(11) DEFAULT NULL,
  `project_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `sample_id` (`sample_id`),
  KEY `project_id` (`project_id`),
  CONSTRAINT `db_sampleproject_ibfk_1` FOREIGN KEY (`sample_id`) REFERENCES `db_sample` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `db_sampleproject_ibfk_2` FOREIGN KEY (`project_id`) REFERENCES `db_monitorproject` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=86 DEFAULT CHARSET=utf8;

-- ----------------------------
--  Records of `db_sampleproject`
-- ----------------------------
BEGIN;
INSERT INTO `db_sampleproject` VALUES ('63', '46', '13'), ('64', '47', '15'), ('65', '48', '13'), ('66', '48', '15'), ('67', '48', '14'), ('68', '49', '13'), ('69', '49', '15'), ('70', '49', '14'), ('71', '50', '15'), ('72', '50', '14'), ('73', '50', '19'), ('74', '51', '15'), ('75', '51', '20'), ('76', '51', '19'), ('77', '52', '21'), ('78', '53', '17'), ('79', '53', '20'), ('80', '54', '17'), ('81', '54', '16'), ('82', '54', '20'), ('83', '63', '9'), ('84', '64', '9'), ('85', '65', '9');
COMMIT;

-- ----------------------------
--  Table structure for `db_task`
-- ----------------------------
DROP TABLE IF EXISTS `db_task`;
CREATE TABLE `db_task` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `identify` varchar(255) DEFAULT NULL,
  `contract_id` int(11) DEFAULT NULL,
  `client_unit` varchar(255) DEFAULT NULL,
  `client_address` varchar(255) DEFAULT NULL,
  `client_code` varchar(255) DEFAULT NULL,
  `client_tel` varchar(255) DEFAULT NULL,
  `client` varchar(255) DEFAULT NULL,
  `project_name` varchar(255) DEFAULT NULL,
  `monitor_aim` varchar(2000) DEFAULT NULL,
  `monitor_way` int(11) DEFAULT NULL,
  `monitor_way_desp` varchar(255) DEFAULT NULL,
  `receive_deparment` int(11) DEFAULT NULL,
  `other` varchar(2000) DEFAULT NULL,
  `state` int(10) NOT NULL DEFAULT '0',
  `create_time` date DEFAULT NULL,
  `create_user` int(11) DEFAULT NULL,
  `sample_type` int(11) DEFAULT NULL,
  `sample_time` date DEFAULT NULL,
  `sample_user` int(11) DEFAULT NULL,
  `monitor_type` varchar(255) DEFAULT NULL,
  `quality_user` int(11) DEFAULT NULL,
  `quality_time` date DEFAULT NULL,
  `receive_user` int(11) DEFAULT NULL,
  `receive_time` date DEFAULT NULL,
  `charge_user` int(11) DEFAULT NULL,
  `distribute_time` date DEFAULT NULL,
  `experience_firstReview_record` int(11) DEFAULT NULL,
  `experience_secondReview_record` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `contract_id` (`contract_id`),
  KEY `receive_deparment` (`receive_deparment`),
  KEY `create_user` (`create_user`),
  KEY `sampe_user` (`sample_user`),
  KEY `quality_user` (`quality_user`),
  KEY `receive_user` (`receive_user`),
  KEY `charge_user` (`charge_user`),
  KEY `experience_firstReview_record` (`experience_firstReview_record`),
  KEY `experience_secondReview_record` (`experience_secondReview_record`),
  CONSTRAINT `db_task_ibfk_1` FOREIGN KEY (`receive_deparment`) REFERENCES `db_department` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `db_task_ibfk_2` FOREIGN KEY (`contract_id`) REFERENCES `db_contract` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `db_task_ibfk_3` FOREIGN KEY (`create_user`) REFERENCES `db_user` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `db_task_ibfk_4` FOREIGN KEY (`sample_user`) REFERENCES `db_user` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `db_task_ibfk_5` FOREIGN KEY (`quality_user`) REFERENCES `db_user` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `db_task_ibfk_6` FOREIGN KEY (`receive_user`) REFERENCES `db_user` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `db_task_ibfk_7` FOREIGN KEY (`charge_user`) REFERENCES `db_user` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `db_task_ibfk_8` FOREIGN KEY (`experience_firstReview_record`) REFERENCES `db_experience_first` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `db_task_ibfk_9` FOREIGN KEY (`experience_secondReview_record`) REFERENCES `db_experience_second` (`id`) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=30 DEFAULT CHARSET=utf8;

-- ----------------------------
--  Records of `db_task`
-- ----------------------------
BEGIN;
INSERT INTO `db_task` VALUES ('11', '2016-034', '21', '常州市环保局', '江苏省常州市新北区通江中路', '212000', '17714817535', '张三', '这是一个自建项目的DEMO', '监测目的为验证自测项目是否能成功', '0', '', '1', '无', '-2', '2016-11-04', '1', '0', '2016-11-12', '1', '例行监测', '1', '2016-11-16', '1', '2016-11-16', '1', '2016-11-16', null, null), ('18', '2016-036', null, '常州市建设局', '江苏省常州市钟楼区', '212000', '17714817535', '李四', '测试自定义项目名称', '检测目的为xxx', '0', '', '1', '', '5', '2016-11-08', '1', '0', '2016-11-12', '1', '例行监测', '1', '2016-11-12', '1', '2016-11-13', '1', '2016-12-12', '5', '10'), ('19', '2016-037', null, '常州市建设局', '江苏省常州市钟楼区', '212000', '17714817535', '李四', '自定义项目', '无检测目的', '0', '', '1', '', '-2', '2016-11-08', '1', '0', null, null, '例行监测', '1', '2016-11-16', '1', '2016-11-16', '1', '2016-11-16', null, null), ('20', '2016-005', '19', '常州市环保局', '江苏省常州市新北区通江中路', '212000', '17714817535', '张三', '江苏省常州市新北区环保一路水质检测报告', '江苏省常州市新北区环保一路水质检测情况统计', '1', '客户指定的监测方法', '1', '无其他约定', '5', '2016-11-08', '1', '0', '2016-11-08', '1', '执法监测', '1', '2016-11-16', '1', '2016-11-16', '1', '2016-12-12', null, null), ('24', '2016-014', '30', '常州市建设局1', '江苏省常州市钟楼区', '212000', '17714817535', '李四', '项目1名称为xxxx', '监测目的为xxxx', '1', '客户指定的方法为xxxx', '1', '', '-2', '2016-11-10', '1', '0', null, null, '执法监测', null, null, null, null, null, null, null, null), ('25', '2016-038', null, '测试自定义生成', '测试自定义生成', '测试自定义生成', '测试自定义生成', '测试自定义生成', '测试自定义生成', '测试自定义生成', '0', '', '1', '', '-2', '2016-11-10', '1', '0', null, null, '执法监测', null, null, null, null, null, null, null, null), ('26', '2016-039', null, '常州市建设局', '江苏省常州市钟楼区', '212000', '17714817535', '李四', '这是一个自定义的任务书Demo', '监测目的为测试是否可以自定义样品信息', '0', '', '2', '', '5', '2016-11-11', '1', '1', '2016-11-11', '1', '例行监测', '1', '2016-11-12', '1', '2016-11-12', '1', '2016-12-12', '11', '12'), ('27', '2016-022', '39', '常州市建设局', '江苏省常州市钟楼区', '212000', '17714817535', '李四', '123', '23', '1', '212', '1', '212', '-2', '2016-11-15', '1', '0', null, null, '执法监测', null, null, null, null, null, null, null, null), ('28', '2016-046', '45', '常州市建设局1', '江苏省常州市钟楼区', '212000', '17714817535', '李四', '合同模板啊啊啊啊啊啊啊', '监测目的为xxxx', '1', '客户指定的方法为xxxx', '1', '其他约定', '1', '2016-11-16', '1', '0', '2016-11-16', '1', '委托监测', null, null, null, null, null, null, null, null), ('29', '2016-047', null, '常州市建设局', '江苏省常州市钟楼区', '212000', '17714817535', '李四', '12', '123', '0', '', '1', '', '0', '2016-11-16', '1', '0', null, null, '监督监测', null, null, null, null, null, null, null, null);
COMMIT;

-- ----------------------------
--  Table structure for `db_taskdeliveryreceive`
-- ----------------------------
DROP TABLE IF EXISTS `db_taskdeliveryreceive`;
CREATE TABLE `db_taskdeliveryreceive` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `task_id` int(11) DEFAULT NULL,
  `package` varchar(255) DEFAULT NULL,
  `sampleFlag` varchar(255) DEFAULT NULL,
  `additive` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `task_id` (`task_id`),
  CONSTRAINT `db_taskdeliveryreceive_ibfk_1` FOREIGN KEY (`task_id`) REFERENCES `db_task` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8;

-- ----------------------------
--  Records of `db_taskdeliveryreceive`
-- ----------------------------
BEGIN;
INSERT INTO `db_taskdeliveryreceive` VALUES ('1', '26', '破损', 'FG4', 'DSDFS'), ('2', '18', '破损', 'SF', '无固体添加剂'), ('3', '20', '完好', 'FG', '无固定添加剂'), ('4', '19', '玷污', 'FG3', '无固定听到'), ('5', '11', '玷污', 'dsdv', '无固定添加剂');
COMMIT;

-- ----------------------------
--  Table structure for `db_user`
-- ----------------------------
DROP TABLE IF EXISTS `db_user`;
CREATE TABLE `db_user` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `username` varchar(50) NOT NULL,
  `password` varchar(255) NOT NULL,
  `name` varchar(255) NOT NULL,
  `gender` int(11) DEFAULT NULL,
  `idCard` varchar(20) NOT NULL,
  `tel` varchar(20) DEFAULT NULL,
  `role_id` int(11) NOT NULL,
  `state` int(11) NOT NULL,
  `last_login` date DEFAULT NULL,
  `line` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `role_id` (`role_id`),
  CONSTRAINT `user_role` FOREIGN KEY (`role_id`) REFERENCES `db_role` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8;

-- ----------------------------
--  Records of `db_user`
-- ----------------------------
BEGIN;
INSERT INTO `db_user` VALUES ('1', 'admin', 'E00CF25AD42683B3DF678C61F42C6BDA', '超级管理员', '0', '320404199202214414', '17714817535', '2', '0', '2016-12-12', '1'), ('2', 'admin1', '10A5EF176D5EEAAA3781288A70D0A6E5', '张三', '1', '320404199202214413', '17714817535', '4', '0', null, null), ('3', 'qulongjun1', 'F162EFC69D2DB5532C74B6FEF7E992D2', '张三', '0', '320404199202214411', '17714817432', '7', '0', '2016-11-14', '1'), ('4', 'qulongjun12', '10A5EF176D5EEAAA3781288A70D0A6E5', '张三', '0', '320404199202214410', '17714817432', '7', '0', null, null), ('5', 'qulongjun1221', '10A5EF176D5EEAAA3781288A70D0A6E5', '张三', '0', '3204041992022144102', '17714817432', '7', '0', null, null), ('6', 'qulongjun121sa', '10A5EF176D5EEAAA3781288A70D0A6E5', 'qulongjun', '0', '12324', '1212', '4', '0', null, null), ('7', 'qulongjun112', '10A5EF176D5EEAAA3781288A70D0A6E5', 'sdsd', '1', '32040419920221441412', '17714817535', '4', '0', null, null), ('8', 'zhagnsan', '670B14728AD9902AECBA32E22FA4F6BD', '张三', '0', '320404199202214412', '17714983233', '2', '0', null, null), ('9', 'zhagnsan2', '670B14728AD9902AECBA32E22FA4F6BD', '张三2', '0', '32040419920221441', '17714983233', '2', '0', null, null), ('10', '12213', 'E00CF25AD42683B3DF678C61F42C6BDA', 'dfsf', '0', 'w12', '21', '6', '0', null, null);
COMMIT;

SET FOREIGN_KEY_CHECKS = 1;
