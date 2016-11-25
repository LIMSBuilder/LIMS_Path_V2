/*
Navicat MySQL Data Transfer

Source Server         : localhost
Source Server Version : 50096
Source Host           : localhost:3306
Source Database       : lims

Target Server Type    : MYSQL
Target Server Version : 50096
File Encoding         : 65001

Date: 2016-11-25 18:43:30
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for `db_contract`
-- ----------------------------
DROP TABLE IF EXISTS `db_contract`;
CREATE TABLE `db_contract` (
  `id` int(11) NOT NULL auto_increment,
  `identify` varchar(255) NOT NULL,
  `client_unit` varchar(255) default NULL,
  `client_code` varchar(255) default NULL,
  `client_address` varchar(255) default NULL,
  `client_tel` varchar(255) default NULL,
  `client` varchar(255) default NULL,
  `client_fax` varchar(255) default NULL,
  `trustee_unit` varchar(255) default NULL,
  `trustee_code` varchar(255) default NULL,
  `trustee_address` varchar(255) default NULL,
  `trustee_tel` varchar(255) default NULL,
  `trustee` int(11) default NULL,
  `trustee_fax` varchar(255) default NULL,
  `project_name` varchar(255) default NULL,
  `monitor_aim` varchar(2000) default NULL,
  `monitor_type` varchar(255) default NULL,
  `monitor_way` int(11) default NULL,
  `monitor_way_desp` varchar(255) default NULL,
  `subpackage` varchar(255) default NULL,
  `subpackage_project` varchar(255) default NULL,
  `payment_way` int(11) default NULL,
  `payment_count` float default NULL,
  `in_room` int(11) default NULL,
  `keep_secret` int(11) default NULL,
  `other` varchar(2000) default NULL,
  `finish_date` varchar(255) default NULL,
  `state` int(11) NOT NULL,
  `create_time` date default NULL,
  `reject_count` int(11) default '0',
  PRIMARY KEY  (`id`),
  KEY `trustee` (`trustee`),
  CONSTRAINT `db_contract_ibfk_1` FOREIGN KEY (`trustee`) REFERENCES `db_user` (`id`) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=46 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of db_contract
-- ----------------------------
INSERT INTO `db_contract` VALUES ('19', '2016-005', '常州市环保局', '212000', '江苏省常州市新北区通江中路', '17714817535', '张三', '0519-83276724', '江苏省常州市邦达城科技1', '2120001', '江苏省常州市新北区环保园12', '0519-123456712', '2', '0519-3628123412', '江苏省常州市新北区环保一路水质检测报告', '江苏省常州市新北区环保一路水质检测情况统计', '执法监测', '1', '客户指定的监测方法', '常州市环保局', '噪声项目', '1', '1230', '1', '0', '无其他约定', '2016-10-20', '2', '2016-06-21', '0');
INSERT INTO `db_contract` VALUES ('20', '2016-006', '常州市环保局', '212000', '江苏省常州市新北区通江中路', '17714817535', '张三', '0519-83276724', '江苏省常州市邦达城科技1', '2120001', '江苏省常州市新北区环保园12', '0519-123456712', '2', '0519-3628123412', '江苏省常州市新北区环保一路水质检测报告', '江苏省常州市新北区环保一路水质检测情况统计', '执法监测', '1', '客户指定的监测方法', '常州市环保局', '噪声项目', '1', '1230', '0', '1', '无其他约定', '2016-10-21', '-4', '2016-06-22', '2');
INSERT INTO `db_contract` VALUES ('21', '2016-007', '常州市环保局', '212000', '江苏省常州市新北区通江中路', '17714817535', '张三', '0519-83276724', '江苏省常州市邦达城科技1', '2120001', '江苏省常州市新北区环保园12', '0519-123456712', '2', '0519-3628123412', '江苏省常州市新北区环保一路水质检测报告', '江苏省常州市新北区环保一路水质检测情况统计', '执法监测', '1', '客户指定的监测方法', '常州市环保局', '噪声项目', '1', '1230', '1', '1', '无其他约定', '2016-10-22', '1', '2016-06-23', '0');
INSERT INTO `db_contract` VALUES ('22', '000000', '常州市建设局1', '212000', '江苏省常州市钟楼区', '17714817535', '李四', '323二位', '江苏省常州市邦达城科技1', '2120001', '江苏省常州市新北区环保园12', '0519-123456712', '1', '0519-3628123412', '项目1名称为xxxx', '监测目的为xxxx', '委托监测', '1', '客户指定的方法为xxxx', '12', '32', '2', '123434', '0', '1', '其他约定', '2016-10-23', '-1', '2016-06-24', '0');
INSERT INTO `db_contract` VALUES ('25', '2016-011', '常州市建设局', '212000', '江苏省常州市钟楼区', '17714817535', '李四', '323二位', '江苏省常州市邦达城科技1', '2120001', '江苏省常州市新北区环保园12', '0519-123456712', '1', '0519-3628123412', '项目2名称为xxxx', '监测目的为xxxx', '执法监测', '1', '客户指定的方法为xxxx', '12', '32', '1', '123434', '0', '0', '其他约定', '2016-10-24', '1', '2016-06-25', '0');
INSERT INTO `db_contract` VALUES ('26', '000000', '常州市建设局3', '212000', '江苏省常州市钟楼区', '17714817535', '李四', '323二位', '江苏省常州市邦达城科技1', '2120001', '江苏省常州市新北区环保园12', '0519-123456712', '2', '0519-3628123412', '项目3名称为xxxx', '监测目的为xxxx', '执法监测', '1', '客户指定的方法为xxxx', '12', '32', '1', '123434', '1', '0', '其他约定', '2016-10-25', '-1', '2016-06-26', '0');
INSERT INTO `db_contract` VALUES ('30', '2016-014', '常州市建设局1', '212000', '江苏省常州市钟楼区', '17714817535', '李四', '323二位', '江苏省常州市邦达城科技1', '2120001', '江苏省常州市新北区环保园12', '0519-123456712', '2', '0519-3628123412', '项目1名称为xxxx', '监测目的为xxxx', '执法监测', '1', '客户指定的方法为xxxx', '12', '32', '0', '123434', '1', '0', '其他约定', '2016-10-26', '-2', '2016-10-31', '0');
INSERT INTO `db_contract` VALUES ('31', '2016-015', '常州市建设局1', '212000', '江苏省常州市钟楼区', '17714817535', '李四', '323二位', '江苏省常州市邦达城科技1', '2120001', '江苏省常州市新北区环保园12', '0519-123456712', '2', '0519-3628123412', '项目1名称为xxxx', '监测目的为xxxx', '委托监测', '1', '客户指定的方法为xxxx', '12', '32', '2', '123434', '1', '0', '其他约定', '2016-10-27', '-2', '2016-10-31', '0');
INSERT INTO `db_contract` VALUES ('32', '000000', '常州市建设局1', '212000', '江苏省常州市钟楼区', '17714817535', '李四', '323二位', '江苏省常州市邦达城科技1', '2120001', '江苏省常州市新北区环保园12', '0519-123456712', '2', '0519-3628123412', '项目1名称为xxxx', '监测目的为xxxx', '委托监测', '1', '客户指定的方法为xxxx', '12', '32', '2', '123434', '1', '0', '其他约定', '2016-10-28', '-1', '2016-10-31', '0');
INSERT INTO `db_contract` VALUES ('33', '2016-016', '常州市建设局1', '212000', '江苏省常州市钟楼区', '17714817535', '李四', '323二位', '江苏省常州市邦达城科技1', '2120001', '江苏省常州市新北区环保园12', '0519-123456712', '1', '0519-3628123412', '项目1名称为xxxx', '监测目的为xxxx', '委托监测', '1', '客户指定的方法为xxxx', '12', '32', '2', '123434', '1', '0', '其他约定', '2016-10-29', '-2', '2016-10-31', '0');
INSERT INTO `db_contract` VALUES ('34', '2016-017', '常州市建设局1', '212000', '江苏省常州市钟楼区', '17714817535', '李四', '323二位', '江苏省常州市邦达城科技1', '2120001', '江苏省常州市新北区环保园12', '0519-123456712', '2', '0519-3628123412', '项目1名称为xxxx', '监测目的为xxxx', '委托监测', '1', '客户指定的方法为xxxx', '12', '32', '2', '123434', '1', '0', '其他约定', '2016-10-30', '-2', '2016-10-31', '0');
INSERT INTO `db_contract` VALUES ('35', '2016-018', '常州市建设局1', '212000', '江苏省常州市钟楼区', '17714817535', '李四', '323二位', '江苏省常州市邦达城科技1', '2120001', '江苏省常州市新北区环保园12', '0519-123456712', '2', '0519-3628123412', '项目1名称为xxxx', '监测目的为xxxx', '委托监测', '1', '客户指定的方法为xxxx', '12', '32', '2', '123434', '1', '0', '其他约定', '2016-10-31', '-2', '2016-10-31', '0');
INSERT INTO `db_contract` VALUES ('36', '2016-019', '常州市建设局1', '212000', '江苏省常州市钟楼区', '17714817535', '李四', '323二位', '江苏省常州市邦达城科技1', '2120001', '江苏省常州市新北区环保园12', '0519-123456712', '1', '0519-3628123412', '项目1名称为xxxx', '监测目的为xxxx', '委托监测', '1', '客户指定的方法为xxxx', '12', '32', '2', '123434', '1', '0', '其他约定', '2016-10-22', '2', '2016-10-31', '0');
INSERT INTO `db_contract` VALUES ('37', '2016-020', '常州市建设局1', '212000', '江苏省常州市钟楼区', '17714817535', '李四', '323二位', '江苏省常州市邦达城科技1', '2120001', '江苏省常州市新北区环保园12', '0519-123456712', '2', '0519-3628123412', '项目1名称为xxxx', '监测目的为xxxx', '委托监测', '1', '客户指定的方法为xxxx', '12', '32', '2', '123434', '1', '0', '其他约定', '2016-10-22', '-2', '2016-10-31', '0');
INSERT INTO `db_contract` VALUES ('38', '2016-021', '常州市建设局1', '212000', '江苏省常州市钟楼区', '17714817535', '李四', '323二位', '江苏省常州市邦达城科技1', '2120001', '江苏省常州市新北区环保园12', '0519-123456712', '1', '0519-3628123412', '项目1名称为xxxx', '监测目的为xxxx', '委托监测', '1', '客户指定的方法为xxxx', '12', '32', '2', '123434', '1', '0', '其他约定', '2016-10-22', '-2', '2016-10-31', '1');
INSERT INTO `db_contract` VALUES ('39', '2016-022', '常州市建设局', '212000', '江苏省常州市钟楼区', '17714817535', '李四', '323二位', '12', 'wq', '32', '32', '6', '12', '123', '23', '执法监测', '1', '212', 'wq', '12', '0', '123', '1', '0', '212', '2016-11-07', '-2', '2016-10-31', '0');
INSERT INTO `db_contract` VALUES ('40', '2016-023', '常州市建设局1', '212000', '江苏省常州市钟楼区', '17714817535', '李四', '323二位', '江苏省常州市邦达城科技1', '2120001', '江苏省常州市新北区环保园12', '0519-123456712', '1', '0519-3628123412', '项目1名称为xxxx', '监测目的为xxxx', '委托监测', '1', '客户指定的方法为xxxx', '12', '32', '2', '123434', '0', '1', '其他约定', '2016-10-23', '-2', '2016-11-03', '0');
INSERT INTO `db_contract` VALUES ('41', '2016-040', '常州市建设局', '212000', '江苏省常州市钟楼区', '17714817535', '李四', '323二位', '江苏省常州市邦达城科技1', '2120001', '江苏省常州市新北区环保园12', '0519-123456712', '2', '0519-3628123412', '项目名称为xxxx项目名称为xxxx项目名称为xxxx项目名称为xxxx项目名称为xxxx项目名称为xxxx', '监测目的为监测目的为监测目的为监测目的为监测目的为监测目的为监测目的为监测目的为监测目的为监测目的为监测目的为监测目的为监测目的为监测目的为监测目的为监测目的为监测目的为监测目的为监测目的为监测目的为监测目的为监测目的为监测目的为监测目的为监测目的为监测目的为监测目的为监测目的为监测目的为监测目的为监测目的为监测目的为监测目的为监测目的为监测目的为监测目的为监测目的为监测目的为监测目的为监测目的为监测目的为监测目的为监测目的为监测目的为监测目的为', '执法监测', '1', '客户指定的方法为xxxxx', '分包单位为xxxx', '项目为xxxx', '0', '210323', '1', '1', '无其他约定', '2016-12-07', '0', '2016-11-14', '0');
INSERT INTO `db_contract` VALUES ('42', '2016-041', '常州市建设局3', '212000', '江苏省常州市钟楼区', '17714817535', '李四', '323二位', '江苏省常州市邦达城科技1', '2120001', '江苏省常州市新北区环保园12', '0519-123456712', '2', '0519-3628123412', '项目3名称为xxxx', '监测目的为xxxx', '执法监测', '1', '客户指定的方法为xxxx', '12', '32', '1', '123434', '1', '0', '其他约定', '2016-10-25', '0', '2016-11-14', '0');
INSERT INTO `db_contract` VALUES ('43', '000000', '常州市建设局1', '212000', '江苏省常州市钟楼区', '17714817535', '李四', '323二位', '江苏省常州市邦达城科技1', '2120001', '江苏省常州市新北区环保园12', '0519-123456712', '1', '0519-3628123412', '合同模板啊啊啊啊啊啊啊', '监测目的为xxxx', '委托监测', '1', '客户指定的方法为xxxx', '12', '32', '2', '123434', '0', '1', '其他约定', '2016-10-23', '-1', '2016-11-15', '0');
INSERT INTO `db_contract` VALUES ('44', '2016-042', '常州市建设局1', '212000', '江苏省常州市钟楼区', '17714817535', '李四', '323二位', '江苏省常州市邦达城科技1', '2120001', '江苏省常州市新北区环保园12', '0519-123456712', '1', '0519-3628123412', '测试合同审核不在服务器', '监测目的为xxxx', '委托监测', '1', '客户指定的方法为xxxx', '12', '32', '2', '123434', '0', '1', '其他约定', '2016-10-23', '0', '2016-11-15', '0');
INSERT INTO `db_contract` VALUES ('45', '2016-046', '常州市建设局1', '212000', '江苏省常州市钟楼区', '17714817535', '李四', '323二位', '江苏省常州市邦达城科技1', '2120001', '江苏省常州市新北区环保园12', '0519-123456712', '1', '0519-3628123412', '合同模板啊啊啊啊啊啊啊', '监测目的为xxxx', '委托监测', '1', '客户指定的方法为xxxx', '12', '32', '2', '123434', '0', '1', '其他约定', '2016-10-23', '2', '2016-11-16', '0');

-- ----------------------------
-- Table structure for `db_customer`
-- ----------------------------
DROP TABLE IF EXISTS `db_customer`;
CREATE TABLE `db_customer` (
  `id` int(11) NOT NULL auto_increment,
  `client_unit` varchar(255) default NULL,
  `client_code` varchar(255) default NULL,
  `client_address` varchar(255) default NULL,
  `client_tel` varchar(255) default NULL,
  `client` varchar(255) default NULL,
  `client_fax` varchar(255) default NULL,
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=23 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of db_customer
-- ----------------------------
INSERT INTO `db_customer` VALUES ('1', '常州市建设局', '212000', '江苏省常州市钟楼区', '17714817535', '李四', '323二位');
INSERT INTO `db_customer` VALUES ('2', '常州市环保局', '212000', '江苏省常州市新北区通江中路', '17714817535', '张三', '0519-83276724');
INSERT INTO `db_customer` VALUES ('3', '常州市政', 'wd', 'sc', 'csx', 'zxcs', 'as');
INSERT INTO `db_customer` VALUES ('9', 'sdas', 'wfdqw', 'wqwd', 'xasxz', 'wdq', '21');
INSERT INTO `db_customer` VALUES ('10', 'dwq', 'sca', 'xs', 'aswq', 'wq', '12');
INSERT INTO `db_customer` VALUES ('11', 'cds', 'sa', 'wq', 're', '212', 'sa');
INSERT INTO `db_customer` VALUES ('12', 'csa', 'sas', 'ds', 'wew', 'qw', '21');
INSERT INTO `db_customer` VALUES ('13', 'csd', 'dsd', 'qw', 'sac', 'xc', 'zx');
INSERT INTO `db_customer` VALUES ('14', 'wq', 'sa', 'cx', ' x', 'zx', 'x ');
INSERT INTO `db_customer` VALUES ('15', 'cds', 'sa', 'wq', 're', '212', 'sa');
INSERT INTO `db_customer` VALUES ('16', 'csa', 'sas', 'ds', 'wew', 'qw', '21');
INSERT INTO `db_customer` VALUES ('17', 'csd', 'dsd', 'qw', 'sac', 'xc', 'zx');
INSERT INTO `db_customer` VALUES ('18', 'wq', 'sa', 'cx', ' x', 'zx', 'x ');
INSERT INTO `db_customer` VALUES ('19', 'cds', 'sa', 'wq', 're', '212', 'sa');
INSERT INTO `db_customer` VALUES ('20', 'csa', 'sas', 'ds', 'wew', 'qw', '21');
INSERT INTO `db_customer` VALUES ('21', 'csd', 'dsd', 'qw', 'sac', 'xc', 'zx');
INSERT INTO `db_customer` VALUES ('22', 'wq', 'sa', 'cx', ' x', 'zx', 'x ');

-- ----------------------------
-- Table structure for `db_default`
-- ----------------------------
DROP TABLE IF EXISTS `db_default`;
CREATE TABLE `db_default` (
  `id` int(11) NOT NULL auto_increment,
  `trustee_unit` varchar(255) default NULL,
  `trustee_code` varchar(255) default NULL,
  `trustee_address` varchar(255) default NULL,
  `trustee_tel` varchar(255) default NULL,
  `trustee_fax` varchar(255) default NULL,
  `trustee` int(11) default NULL,
  PRIMARY KEY  (`id`),
  KEY `trustee` (`trustee`),
  CONSTRAINT `default_user` FOREIGN KEY (`trustee`) REFERENCES `db_user` (`id`) ON DELETE SET NULL ON UPDATE SET NULL
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of db_default
-- ----------------------------
INSERT INTO `db_default` VALUES ('1', '江苏省常州市邦达城科技', '212000', '江苏省常州市新北区环保园', '0519-1234567', '0519-36281234', '4');

-- ----------------------------
-- Table structure for `db_delivery`
-- ----------------------------
DROP TABLE IF EXISTS `db_delivery`;
CREATE TABLE `db_delivery` (
  `id` int(11) NOT NULL auto_increment,
  `task_id` int(11) default NULL,
  `project_id` int(11) default NULL,
  `character` varchar(1000) default NULL,
  `storage` varchar(255) default NULL,
  `analyst` int(11) default NULL,
  `assessor` int(11) default NULL,
  `checker` int(11) default NULL,
  `analyst_time` date default NULL,
  `assessor_time` date default NULL,
  `checker_time` date default NULL,
  `state` int(11) default '0',
  `inspection_path` varchar(2000) default NULL,
  PRIMARY KEY  (`id`),
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
-- Records of db_delivery
-- ----------------------------
INSERT INTO `db_delivery` VALUES ('5', '18', '20', '形状1', '常温', '1', '8', '9', null, null, null, '0', null);
INSERT INTO `db_delivery` VALUES ('6', '18', '21', '性状2', '低温', '1', '8', '9', null, null, null, '0', null);
INSERT INTO `db_delivery` VALUES ('7', '18', '17', '形状3', '常温', '2', '8', '9', null, null, null, '0', null);
INSERT INTO `db_delivery` VALUES ('8', '18', '16', '形状4', '低温', '1', '8', '8', null, null, null, '0', null);
INSERT INTO `db_delivery` VALUES ('11', '26', '19', '固体1', '常温', '1', '8', '9', null, null, null, '0', null);
INSERT INTO `db_delivery` VALUES ('12', '26', '15', '废水3', '低温', '1', '8', '9', null, null, null, '0', null);
INSERT INTO `db_delivery` VALUES ('13', '26', '13', '废水1', '常温', '1', '8', '9', null, null, null, '0', null);
INSERT INTO `db_delivery` VALUES ('14', '20', '15', '形状是啥', '低温', '1', '8', '9', null, null, null, '0', null);

-- ----------------------------
-- Table structure for `db_deliveryoriginrecord`
-- ----------------------------
DROP TABLE IF EXISTS `db_deliveryoriginrecord`;
CREATE TABLE `db_deliveryoriginrecord` (
  `id` int(11) NOT NULL auto_increment,
  `delivery_id` int(11) default NULL,
  `originRecord_path` varchar(2000) default NULL,
  `name` varchar(255) default NULL,
  PRIMARY KEY  (`id`),
  KEY `delivery_id` (`delivery_id`),
  CONSTRAINT `db_deliveryoriginrecord_ibfk_1` FOREIGN KEY (`delivery_id`) REFERENCES `db_delivery` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=23 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of db_deliveryoriginrecord
-- ----------------------------
INSERT INTO `db_deliveryoriginrecord` VALUES ('10', '5', 'G:\\LIMS_V2\\out\\artifacts\\LIMS_V2_war_exploded\\attachment\\(2016-036)功能区环境噪声测量记录表.docx', '功能区环境噪声测量记录表');
INSERT INTO `db_deliveryoriginrecord` VALUES ('16', '5', 'G:\\LIMS_V2\\out\\artifacts\\LIMS_V2_war_exploded\\attachment\\(2016-036)功能区环境噪声测量记录表2.docx', '功能区环境噪声测量记录表2');
INSERT INTO `db_deliveryoriginrecord` VALUES ('17', '5', 'G:\\LIMS_V2\\out\\artifacts\\LIMS_V2_war_exploded\\attachment\\(2016-036)功能区环境噪声测量记录表3.docx', '功能区环境噪声测量记录表3');
INSERT INTO `db_deliveryoriginrecord` VALUES ('18', '5', 'G:\\LIMS_V2\\out\\artifacts\\LIMS_V2_war_exploded\\attachment\\(2016-036)功能区环境噪声测量记录表4.docx', '功能区环境噪声测量记录表4');
INSERT INTO `db_deliveryoriginrecord` VALUES ('19', '5', 'G:\\LIMS_V2\\out\\artifacts\\LIMS_V2_war_exploded\\attachment\\(2016-036)功能区环境噪声测量记录表5.docx', '功能区环境噪声测量记录表5');
INSERT INTO `db_deliveryoriginrecord` VALUES ('20', '5', 'G:\\LIMS_V2\\out\\artifacts\\LIMS_V2_war_exploded\\attachment\\(2016-036)交通道路声环境监测记录表.docx', '交通道路声环境监测记录表');

-- ----------------------------
-- Table structure for `db_department`
-- ----------------------------
DROP TABLE IF EXISTS `db_department`;
CREATE TABLE `db_department` (
  `id` int(11) NOT NULL auto_increment,
  `name` varchar(255) NOT NULL,
  `state` int(11) NOT NULL,
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=34 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of db_department
-- ----------------------------
INSERT INTO `db_department` VALUES ('1', '综合办公室', '0');
INSERT INTO `db_department` VALUES ('2', '实验室', '0');
INSERT INTO `db_department` VALUES ('3', '主任办公室', '0');
INSERT INTO `db_department` VALUES ('4', '实验分析室', '0');
INSERT INTO `db_department` VALUES ('5', '质量控制室', '0');
INSERT INTO `db_department` VALUES ('6', '张三wqx21', '0');
INSERT INTO `db_department` VALUES ('7', '张三', '1');
INSERT INTO `db_department` VALUES ('8', '张三', '1');
INSERT INTO `db_department` VALUES ('9', '张三', '0');
INSERT INTO `db_department` VALUES ('10', '张三d前端', '2');
INSERT INTO `db_department` VALUES ('11', '张三', '0');
INSERT INTO `db_department` VALUES ('12', '张三', '0');
INSERT INTO `db_department` VALUES ('13', '张三', '1');
INSERT INTO `db_department` VALUES ('14', '张三2', '1');
INSERT INTO `db_department` VALUES ('15', '张三dsdv', '0');
INSERT INTO `db_department` VALUES ('16', '张三sasq', '0');
INSERT INTO `db_department` VALUES ('17', 'wq张三', '0');
INSERT INTO `db_department` VALUES ('18', '12wqw', '1');
INSERT INTO `db_department` VALUES ('19', '12完全爱上查', '1');
INSERT INTO `db_department` VALUES ('20', '', '0');
INSERT INTO `db_department` VALUES ('21', '12wq', '0');
INSERT INTO `db_department` VALUES ('22', '2ew', '0');
INSERT INTO `db_department` VALUES ('23', '1', '0');
INSERT INTO `db_department` VALUES ('24', 'a', '0');
INSERT INTO `db_department` VALUES ('25', '12', '0');
INSERT INTO `db_department` VALUES ('26', '123', '0');
INSERT INTO `db_department` VALUES ('27', '4123', '0');
INSERT INTO `db_department` VALUES ('28', '4123asc', '0');
INSERT INTO `db_department` VALUES ('29', '23wq', '0');
INSERT INTO `db_department` VALUES ('30', 'daijigu', '0');
INSERT INTO `db_department` VALUES ('31', 'daijigud', '0');
INSERT INTO `db_department` VALUES ('32', 'daijigud的', '0');
INSERT INTO `db_department` VALUES ('33', 'sdasdsc', '0');

-- ----------------------------
-- Table structure for `db_feedback`
-- ----------------------------
DROP TABLE IF EXISTS `db_feedback`;
CREATE TABLE `db_feedback` (
  `id` int(11) NOT NULL auto_increment,
  `type` varchar(255) default NULL,
  `content` varchar(2000) default NULL,
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of db_feedback
-- ----------------------------
INSERT INTO `db_feedback` VALUES ('1', '系统缺陷(bug)', '测试反馈内容');
INSERT INTO `db_feedback` VALUES ('2', '功能缺失', '再反馈一个事实');

-- ----------------------------
-- Table structure for `db_identify`
-- ----------------------------
DROP TABLE IF EXISTS `db_identify`;
CREATE TABLE `db_identify` (
  `id` int(11) NOT NULL,
  `contract_id` int(11) NOT NULL,
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of db_identify
-- ----------------------------
INSERT INTO `db_identify` VALUES ('1', '47');

-- ----------------------------
-- Table structure for `db_inspectiontemplate`
-- ----------------------------
DROP TABLE IF EXISTS `db_inspectiontemplate`;
CREATE TABLE `db_inspectiontemplate` (
  `id` int(11) NOT NULL auto_increment,
  `name` varchar(255) default NULL,
  `path` varchar(255) default NULL,
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of db_inspectiontemplate
-- ----------------------------
INSERT INTO `db_inspectiontemplate` VALUES ('8', '废气样品送检单', 'G:\\LIMS_V2\\out\\artifacts\\LIMS_V2_war_exploded\\upload\\5、BEM-QPBS2907环境空气和无组织废气样品送检单.docx');
INSERT INTO `db_inspectiontemplate` VALUES ('9', '土壤、底质送检单', 'G:\\LIMS_V2\\out\\artifacts\\LIMS_V2_war_exploded\\upload\\5、BEM-QPBS2904土壤、底质样品送检单.doc');
INSERT INTO `db_inspectiontemplate` VALUES ('10', '噪声送检单', 'G:\\LIMS_V2\\out\\artifacts\\LIMS_V2_war_exploded\\upload\\5、BEM-QPBS2905固定污染源有组织废气样品送检单.docx');

-- ----------------------------
-- Table structure for `db_item_project`
-- ----------------------------
DROP TABLE IF EXISTS `db_item_project`;
CREATE TABLE `db_item_project` (
  `id` int(11) NOT NULL auto_increment,
  `item_id` int(11) NOT NULL,
  `project_id` int(11) NOT NULL,
  PRIMARY KEY  (`id`),
  KEY `item_id` (`item_id`),
  KEY `project_id` (`project_id`),
  CONSTRAINT `db_item_project_ibfk_1` FOREIGN KEY (`item_id`) REFERENCES `db_monitoritem` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `db_item_project_ibfk_2` FOREIGN KEY (`project_id`) REFERENCES `db_monitorproject` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=89 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of db_item_project
-- ----------------------------
INSERT INTO `db_item_project` VALUES ('4', '20', '13');
INSERT INTO `db_item_project` VALUES ('5', '20', '14');
INSERT INTO `db_item_project` VALUES ('6', '20', '15');
INSERT INTO `db_item_project` VALUES ('7', '21', '16');
INSERT INTO `db_item_project` VALUES ('8', '21', '17');
INSERT INTO `db_item_project` VALUES ('9', '21', '18');
INSERT INTO `db_item_project` VALUES ('10', '22', '13');
INSERT INTO `db_item_project` VALUES ('11', '22', '14');
INSERT INTO `db_item_project` VALUES ('12', '22', '15');
INSERT INTO `db_item_project` VALUES ('13', '23', '16');
INSERT INTO `db_item_project` VALUES ('14', '23', '17');
INSERT INTO `db_item_project` VALUES ('15', '23', '18');
INSERT INTO `db_item_project` VALUES ('16', '24', '13');
INSERT INTO `db_item_project` VALUES ('17', '24', '14');
INSERT INTO `db_item_project` VALUES ('18', '24', '15');
INSERT INTO `db_item_project` VALUES ('19', '25', '16');
INSERT INTO `db_item_project` VALUES ('20', '25', '17');
INSERT INTO `db_item_project` VALUES ('21', '25', '18');
INSERT INTO `db_item_project` VALUES ('22', '26', '14');
INSERT INTO `db_item_project` VALUES ('25', '29', '14');
INSERT INTO `db_item_project` VALUES ('26', '30', '14');
INSERT INTO `db_item_project` VALUES ('51', '39', '10');
INSERT INTO `db_item_project` VALUES ('52', '39', '11');
INSERT INTO `db_item_project` VALUES ('53', '39', '12');
INSERT INTO `db_item_project` VALUES ('54', '40', '16');
INSERT INTO `db_item_project` VALUES ('55', '40', '17');
INSERT INTO `db_item_project` VALUES ('56', '40', '18');
INSERT INTO `db_item_project` VALUES ('63', '43', '16');
INSERT INTO `db_item_project` VALUES ('64', '43', '17');
INSERT INTO `db_item_project` VALUES ('65', '44', '20');
INSERT INTO `db_item_project` VALUES ('66', '44', '21');
INSERT INTO `db_item_project` VALUES ('67', '45', '16');
INSERT INTO `db_item_project` VALUES ('68', '45', '17');
INSERT INTO `db_item_project` VALUES ('69', '46', '19');
INSERT INTO `db_item_project` VALUES ('70', '46', '20');
INSERT INTO `db_item_project` VALUES ('71', '47', '13');
INSERT INTO `db_item_project` VALUES ('72', '47', '14');
INSERT INTO `db_item_project` VALUES ('73', '47', '15');
INSERT INTO `db_item_project` VALUES ('74', '48', '19');
INSERT INTO `db_item_project` VALUES ('75', '48', '20');
INSERT INTO `db_item_project` VALUES ('76', '49', '10');
INSERT INTO `db_item_project` VALUES ('77', '49', '11');
INSERT INTO `db_item_project` VALUES ('78', '49', '12');
INSERT INTO `db_item_project` VALUES ('79', '50', '16');
INSERT INTO `db_item_project` VALUES ('80', '50', '17');
INSERT INTO `db_item_project` VALUES ('81', '50', '18');
INSERT INTO `db_item_project` VALUES ('82', '51', '9');
INSERT INTO `db_item_project` VALUES ('83', '51', '10');
INSERT INTO `db_item_project` VALUES ('84', '51', '11');
INSERT INTO `db_item_project` VALUES ('85', '52', '17');
INSERT INTO `db_item_project` VALUES ('86', '53', '9');
INSERT INTO `db_item_project` VALUES ('87', '54', '10');
INSERT INTO `db_item_project` VALUES ('88', '55', '17');

-- ----------------------------
-- Table structure for `db_mail`
-- ----------------------------
DROP TABLE IF EXISTS `db_mail`;
CREATE TABLE `db_mail` (
  `id` int(11) NOT NULL auto_increment,
  `title` varchar(2000) default NULL,
  `content` varchar(10000) default NULL,
  `sender` int(11) default NULL,
  `send_time` date default NULL,
  `state` int(11) default NULL,
  PRIMARY KEY  (`id`),
  KEY `sender` (`sender`),
  CONSTRAINT `db_mail_ibfk_1` FOREIGN KEY (`sender`) REFERENCES `db_user` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of db_mail
-- ----------------------------
INSERT INTO `db_mail` VALUES ('4', '邮件主题是sxxxxxxx邮件主题是sxxxxxxx邮件主题是sxxxxxxx', '<h1><ul><li><u><i><b><span class=\"wysiwyg-color-red\">这是一段正文的c测试内容，来判断正文sh否z横渠d s</span></b></i></u></li></ul></h1>', '1', '2016-11-22', '0');
INSERT INTO `db_mail` VALUES ('5', '写一份信关于测试邮件的', '<blockquote><blockquote><blockquote><blockquote><blockquote><blockquote><blockquote><blockquote><blockquote><h1>这是一个标题</h1></blockquote></blockquote></blockquote></blockquote></blockquote></blockquote></blockquote></blockquote></blockquote>这是一段问题，用来都表示的冯绍峰这是一段问题，用来都表示的冯绍峰这是一段问题，用来都表示的冯绍峰这是一段问题，用来都表示的冯绍峰这是一段问题，用来都表示的冯绍峰这是一段问题，用来都表示的冯绍峰这是一段问题，用来都表示的冯绍峰这是一段问题，用来都表示的冯绍峰这是一段问题，用来都表示的冯绍峰这是一段问题，用来都表示的冯绍峰这是一段问题，用来都表示的冯绍峰这是一段问题，用来都表示的冯绍峰这是一段问题，用来都表示的冯绍峰这是一段问题，用来都表示的冯绍峰这是一段问题，用来都表示的冯绍峰这是一段问题，用来都表示的冯绍峰这是一段问题，用来都表示的冯绍峰这是一段问题，用来都表示的冯绍峰这是一段问题，用来都表示的冯绍峰这是一段问题，用来都表示的冯绍峰这是一段问题，用来都表示的冯绍峰这是一段问题，用来都表示的冯绍峰<span>这是一段问题，用来都表示的冯绍峰</span><br>', '1', '2016-11-22', '0');
INSERT INTO `db_mail` VALUES ('6', '测试已删除', '<blockquote><blockquote><blockquote><blockquote><blockquote><blockquote><blockquote><blockquote><blockquote><h1>这是一个删除的标题</h1></blockquote></blockquote></blockquote></blockquote></blockquote></blockquote></blockquote></blockquote></blockquote>这是一段问题，用来都表示的冯绍峰这是一段问题，用来都表示的冯绍峰这是一段问题，用来都表示的冯绍峰这是一段问题，用来都表示的冯绍峰这是一段问题，用来都表示的冯绍峰这是一段问题，用来都表示的冯绍峰这是一段问题，用来都表示的冯绍峰这是一段问题，用来都表示的冯绍峰这是一段问题，用来都表示的冯绍峰这是一段问题，用来都表示的冯绍峰这是一段问题，用来都表示的冯绍峰这是一段问题，用来都表示的冯绍峰这是一段问题，用来都表示的冯绍峰这是一段问题，用来都表示的冯绍峰这是一段问题，用来都表示的冯绍峰这是一段问题，用来都表示的冯绍峰这是一段问题，用来都表示的冯绍峰这是一段问题，用来都表示的冯绍峰这是一段问题，用来都表示的冯绍峰这是一段问题，用来都表示的冯绍峰这是一段问题，用来都表示的冯绍峰这是一段问题，用来都表示的冯绍峰<span>这是一段问题，用来都表示的冯绍峰</span><br>', '1', '2016-11-22', '0');
INSERT INTO `db_mail` VALUES ('7', '测试星标邮件箱', '<blockquote><blockquote><blockquote><blockquote><blockquote><blockquote><blockquote><blockquote><blockquote><h1>这是一个星标的标题</h1></blockquote></blockquote></blockquote></blockquote></blockquote></blockquote></blockquote></blockquote></blockquote>这是一段问题，用来都表示的冯绍峰这是一段问题，用来都表示的冯绍峰这是一段问题，用来都表示的冯绍峰这是一段问题，用来都表示的冯绍峰这是一段问题，用来都表示的冯绍峰这是一段问题，用来都表示的冯绍峰这是一段问题，用来都表示的冯绍峰这是一段问题，用来都表示的冯绍峰这是一段问题，用来都表示的冯绍峰这是一段问题，用来都表示的冯绍峰这是一段问题，用来都表示的冯绍峰这是一段问题，用来都表示的冯绍峰这是一段问题，用来都表示的冯绍峰这是一段问题，用来都表示的冯绍峰这是一段问题，用来都表示的冯绍峰这是一段问题，用来都表示的冯绍峰这是一段问题，用来都表示的冯绍峰这是一段问题，用来都表示的冯绍峰这是一段问题，用来都表示的冯绍峰这是一段问题，用来都表示的冯绍峰这是一段问题，用来都表示的冯绍峰这是一段问题，用来都表示的冯绍峰<span>这是一段问题，用来都表示的冯绍峰</span><br>', '1', '2016-11-22', '0');

-- ----------------------------
-- Table structure for `db_mailreceiver`
-- ----------------------------
DROP TABLE IF EXISTS `db_mailreceiver`;
CREATE TABLE `db_mailreceiver` (
  `id` int(11) NOT NULL auto_increment,
  `mail_id` int(11) default NULL,
  `user_id` int(11) default NULL,
  `state` int(11) default NULL,
  PRIMARY KEY  (`id`),
  KEY `mail_id` (`mail_id`),
  KEY `user_id` (`user_id`),
  CONSTRAINT `db_mailreceiver_ibfk_1` FOREIGN KEY (`mail_id`) REFERENCES `db_mail` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `db_mailreceiver_ibfk_2` FOREIGN KEY (`user_id`) REFERENCES `db_user` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of db_mailreceiver
-- ----------------------------
INSERT INTO `db_mailreceiver` VALUES ('1', '4', '1', '1');
INSERT INTO `db_mailreceiver` VALUES ('2', '4', '2', '-1');
INSERT INTO `db_mailreceiver` VALUES ('3', '4', '7', '0');
INSERT INTO `db_mailreceiver` VALUES ('4', '4', '9', '0');
INSERT INTO `db_mailreceiver` VALUES ('5', '5', '1', '-1');
INSERT INTO `db_mailreceiver` VALUES ('6', '6', '1', '1');
INSERT INTO `db_mailreceiver` VALUES ('7', '7', '1', '-2');

-- ----------------------------
-- Table structure for `db_monitorcategory`
-- ----------------------------
DROP TABLE IF EXISTS `db_monitorcategory`;
CREATE TABLE `db_monitorcategory` (
  `id` int(11) NOT NULL auto_increment,
  `name` varchar(255) NOT NULL,
  `state` int(11) NOT NULL,
  `inspection_template` int(11) default NULL,
  PRIMARY KEY  (`id`),
  KEY `inspection_template` (`inspection_template`),
  CONSTRAINT `db_monitorcategory_ibfk_1` FOREIGN KEY (`inspection_template`) REFERENCES `db_inspectiontemplate` (`id`) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of db_monitorcategory
-- ----------------------------
INSERT INTO `db_monitorcategory` VALUES ('6', '废气', '0', '8');
INSERT INTO `db_monitorcategory` VALUES ('7', '废水', '0', null);
INSERT INTO `db_monitorcategory` VALUES ('8', '噪声', '0', '10');
INSERT INTO `db_monitorcategory` VALUES ('9', '固体污染物', '0', '9');
INSERT INTO `db_monitorcategory` VALUES ('10', '流体2', '1', null);
INSERT INTO `db_monitorcategory` VALUES ('11', '流体3', '1', null);

-- ----------------------------
-- Table structure for `db_monitorfrequency`
-- ----------------------------
DROP TABLE IF EXISTS `db_monitorfrequency`;
CREATE TABLE `db_monitorfrequency` (
  `id` int(11) NOT NULL auto_increment,
  `name` varchar(255) default NULL,
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of db_monitorfrequency
-- ----------------------------
INSERT INTO `db_monitorfrequency` VALUES ('7', '一天/次');
INSERT INTO `db_monitorfrequency` VALUES ('8', '一周/次');
INSERT INTO `db_monitorfrequency` VALUES ('9', '一月/次2');
INSERT INTO `db_monitorfrequency` VALUES ('10', '一年/2次');
INSERT INTO `db_monitorfrequency` VALUES ('11', 'cesh');
INSERT INTO `db_monitorfrequency` VALUES ('12', 'ces2');

-- ----------------------------
-- Table structure for `db_monitoritem`
-- ----------------------------
DROP TABLE IF EXISTS `db_monitoritem`;
CREATE TABLE `db_monitoritem` (
  `id` int(11) NOT NULL auto_increment,
  `contract_id` int(11) default NULL,
  `task_id` int(11) default NULL,
  `category_id` int(11) default NULL,
  `frequency` varchar(255) default NULL,
  `monitor_point` varchar(255) default NULL,
  `other` varchar(2000) default NULL,
  PRIMARY KEY  (`id`),
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
-- Records of db_monitoritem
-- ----------------------------
INSERT INTO `db_monitoritem` VALUES ('20', '19', null, '7', '一周/次', '监测点1;监测点2;监测点3;监测点4;监测点5', '无备注信息');
INSERT INTO `db_monitoritem` VALUES ('21', '19', null, '8', '一周/次', '监测点6;监测点7;监测点8', '无备注信息');
INSERT INTO `db_monitoritem` VALUES ('22', '20', null, '7', '一周/次', '监测点1;监测点2;监测点3;监测点4;监测点5', '无备注信息');
INSERT INTO `db_monitoritem` VALUES ('23', '20', null, '8', '一周/次', '监测点6;监测点7;监测点8', '无备注信息');
INSERT INTO `db_monitoritem` VALUES ('24', '21', null, '7', '一周/次', '监测点1;监测点2;监测点3;监测点4;监测点5', '无备注信息');
INSERT INTO `db_monitoritem` VALUES ('25', '21', null, '8', '一周/次', '监测点6;监测点7;监测点8', '无备注信息');
INSERT INTO `db_monitoritem` VALUES ('26', '22', null, '7', '一月/次', '监测点1;监测点2;监测点3;监测点4', '无备注');
INSERT INTO `db_monitoritem` VALUES ('29', '25', null, '7', '一月/次', '监测点1;监测点2;监测点3;监测点4', '无备注');
INSERT INTO `db_monitoritem` VALUES ('30', '26', null, '7', '一月/次', '监测点1;监测点2;监测点3;监测点4', '无备注');
INSERT INTO `db_monitoritem` VALUES ('39', null, '11', '6', '一周/次', '监测点1;监测点2;监测点3;监测点4', '备注信息为xxxx');
INSERT INTO `db_monitoritem` VALUES ('40', null, '11', '8', '一月/次', '监测点1;监测点2;监测5;监测6', '啦啦啦啦');
INSERT INTO `db_monitoritem` VALUES ('43', null, '18', '8', '一月/次', '增加1;检测2;检测3', '无备注');
INSERT INTO `db_monitoritem` VALUES ('44', null, '18', '9', '一月/次', '增加4;检测5;检测6', '无备足');
INSERT INTO `db_monitoritem` VALUES ('45', null, '19', '8', '一周/次', '监测点1;监测点2;监测点3', '');
INSERT INTO `db_monitoritem` VALUES ('46', null, '19', '9', '一周/次', '监测点4;监测点5;监测点6', '');
INSERT INTO `db_monitoritem` VALUES ('47', null, '26', '7', '一周/次', '废水1;废水2;废水3;废水4;废水5', '');
INSERT INTO `db_monitoritem` VALUES ('48', null, '26', '9', '一月/次', '固定污染物1;固定污染物2;固定污染物3;固定污染物4;固定污染物5', '');
INSERT INTO `db_monitoritem` VALUES ('49', '41', null, '6', '一周/次', '废气1;废气2;废气4;废气3;废气5', '无备注信息');
INSERT INTO `db_monitoritem` VALUES ('50', '41', null, '8', '一月/次', '监测点1;检测2', '无备注信息');
INSERT INTO `db_monitoritem` VALUES ('51', '44', null, '6', '一月/次', '废气1;废气2;废气3;废气4;废气5', '');
INSERT INTO `db_monitoritem` VALUES ('52', '44', null, '8', '一月/次', '监测点6;减肥的6', '');
INSERT INTO `db_monitoritem` VALUES ('53', '45', null, '6', '一周/次', '1;2;3;4', '');
INSERT INTO `db_monitoritem` VALUES ('54', null, '29', '6', 'cesh', '1', '23');
INSERT INTO `db_monitoritem` VALUES ('55', null, '29', '8', 'cesh', '123', '123');

-- ----------------------------
-- Table structure for `db_monitorproject`
-- ----------------------------
DROP TABLE IF EXISTS `db_monitorproject`;
CREATE TABLE `db_monitorproject` (
  `id` int(11) NOT NULL auto_increment,
  `name` varchar(255) NOT NULL,
  `desp` varchar(255) default NULL,
  `state` int(11) NOT NULL,
  `category_id` int(11) NOT NULL,
  `chargeDepart` int(11) default NULL,
  PRIMARY KEY  (`id`),
  KEY `category_id` (`category_id`),
  KEY `chargeDepart` (`chargeDepart`),
  CONSTRAINT `db_monitorproject_ibfk_1` FOREIGN KEY (`chargeDepart`) REFERENCES `db_department` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `project_category` FOREIGN KEY (`category_id`) REFERENCES `db_monitorcategory` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=29 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of db_monitorproject
-- ----------------------------
INSERT INTO `db_monitorproject` VALUES ('9', '废气一', '关于废气的监测项目', '0', '6', '4');
INSERT INTO `db_monitorproject` VALUES ('10', '废气二', '关于废气的监测项目', '0', '6', '4');
INSERT INTO `db_monitorproject` VALUES ('11', '废气三', '关于废气的监测项目', '0', '6', '4');
INSERT INTO `db_monitorproject` VALUES ('12', '废气四', '关于废气的监测项目', '0', '6', '4');
INSERT INTO `db_monitorproject` VALUES ('13', '废水一', '关于废水的监测项目', '0', '7', '4');
INSERT INTO `db_monitorproject` VALUES ('14', '废水二', '关于废水的监测项目', '0', '7', '4');
INSERT INTO `db_monitorproject` VALUES ('15', '废水三', '关于废水的监测项目', '0', '7', '4');
INSERT INTO `db_monitorproject` VALUES ('16', '噪声一', '关于噪声的监测项目', '0', '8', '4');
INSERT INTO `db_monitorproject` VALUES ('17', '噪声二', '关于噪声的监测项目', '0', '8', '4');
INSERT INTO `db_monitorproject` VALUES ('18', '噪声三', '关于噪声的监测项目', '0', '8', '4');
INSERT INTO `db_monitorproject` VALUES ('19', '固体一', '关于固体的监测项目', '0', '9', '4');
INSERT INTO `db_monitorproject` VALUES ('20', '固体二', '关于固体的监测项目', '0', '9', '4');
INSERT INTO `db_monitorproject` VALUES ('21', '固体三', '关于固体的监测项目', '0', '9', '4');
INSERT INTO `db_monitorproject` VALUES ('27', '固体四', '固体四', '0', '9', '4');
INSERT INTO `db_monitorproject` VALUES ('28', '固体五2', '测试2', '1', '9', '2');

-- ----------------------------
-- Table structure for `db_originrecordtemplate`
-- ----------------------------
DROP TABLE IF EXISTS `db_originrecordtemplate`;
CREATE TABLE `db_originrecordtemplate` (
  `id` int(11) NOT NULL auto_increment,
  `name` varchar(1000) default NULL,
  `path` varchar(2000) default NULL,
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of db_originrecordtemplate
-- ----------------------------
INSERT INTO `db_originrecordtemplate` VALUES ('7', '功能区环境噪声测量记录表', 'G:\\LIMS_V2\\out\\artifacts\\LIMS_V2_war_exploded\\upload\\01 功能区环境噪声测量记录表.docx');
INSERT INTO `db_originrecordtemplate` VALUES ('8', '交通道路声环境监测记录表', 'G:\\LIMS_V2\\out\\artifacts\\LIMS_V2_war_exploded\\upload\\02 交通道路声环境监测记录表.docx');
INSERT INTO `db_originrecordtemplate` VALUES ('9', '颗粒物、流速、温度CEMS准确度检测记录表', 'G:\\LIMS_V2\\out\\artifacts\\LIMS_V2_war_exploded\\upload\\03颗粒物、流速、温度CEMS准确度检测记录表.doc');

-- ----------------------------
-- Table structure for `db_properties`
-- ----------------------------
DROP TABLE IF EXISTS `db_properties`;
CREATE TABLE `db_properties` (
  `id` int(11) NOT NULL,
  `sample_receive_self` int(11) default '0',
  `sample_receive_scene` int(11) default '0',
  `sample_receive_self_role` int(11) default '0',
  `sample_receive_scene_role` int(11) default '0',
  `sample_self_middle` varchar(255) default NULL,
  `sample_scene_middle` varchar(255) default NULL,
  `sample_self_serial` int(11) default NULL,
  `sample_scene_serial` int(11) default NULL,
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of db_properties
-- ----------------------------
INSERT INTO `db_properties` VALUES ('1', '1', '2', '2', '4', 'Z', 'A', '34', '7');

-- ----------------------------
-- Table structure for `db_qualitycontroller`
-- ----------------------------
DROP TABLE IF EXISTS `db_qualitycontroller`;
CREATE TABLE `db_qualitycontroller` (
  `id` int(11) NOT NULL auto_increment,
  `task_id` int(11) default NULL,
  `project_id` int(11) default NULL,
  `blind` int(11) default NULL,
  PRIMARY KEY  (`id`),
  KEY `task_id` (`task_id`),
  KEY `project_id` (`project_id`),
  CONSTRAINT `db_qualitycontroller_ibfk_1` FOREIGN KEY (`task_id`) REFERENCES `db_task` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `db_qualitycontroller_ibfk_2` FOREIGN KEY (`project_id`) REFERENCES `db_monitorproject` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of db_qualitycontroller
-- ----------------------------
INSERT INTO `db_qualitycontroller` VALUES ('1', '26', '15', '15');
INSERT INTO `db_qualitycontroller` VALUES ('2', '26', '15', '15');
INSERT INTO `db_qualitycontroller` VALUES ('7', '18', '21', '2');
INSERT INTO `db_qualitycontroller` VALUES ('8', '18', '20', '123');
INSERT INTO `db_qualitycontroller` VALUES ('9', '18', '17', '5');
INSERT INTO `db_qualitycontroller` VALUES ('10', '18', '16', '2');
INSERT INTO `db_qualitycontroller` VALUES ('11', '20', '15', '12');
INSERT INTO `db_qualitycontroller` VALUES ('12', '20', '15', '12');
INSERT INTO `db_qualitycontroller` VALUES ('13', '20', '15', '12');

-- ----------------------------
-- Table structure for `db_qualitylab`
-- ----------------------------
DROP TABLE IF EXISTS `db_qualitylab`;
CREATE TABLE `db_qualitylab` (
  `id` int(11) NOT NULL auto_increment,
  `quality_id` int(11) default NULL,
  `sample_id` int(11) default NULL,
  PRIMARY KEY  (`id`),
  KEY `quality_id` (`quality_id`),
  KEY `sample_id` (`sample_id`),
  CONSTRAINT `db_qualitylab_ibfk_1` FOREIGN KEY (`quality_id`) REFERENCES `db_qualitycontroller` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `db_qualitylab_ibfk_2` FOREIGN KEY (`sample_id`) REFERENCES `db_sample` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of db_qualitylab
-- ----------------------------
INSERT INTO `db_qualitylab` VALUES ('1', '1', '50');
INSERT INTO `db_qualitylab` VALUES ('2', '1', '51');
INSERT INTO `db_qualitylab` VALUES ('3', '2', '48');
INSERT INTO `db_qualitylab` VALUES ('4', '2', '49');
INSERT INTO `db_qualitylab` VALUES ('8', '8', '54');
INSERT INTO `db_qualitylab` VALUES ('9', '9', '53');
INSERT INTO `db_qualitylab` VALUES ('10', '10', '54');
INSERT INTO `db_qualitylab` VALUES ('11', '11', '47');
INSERT INTO `db_qualitylab` VALUES ('12', '12', '47');
INSERT INTO `db_qualitylab` VALUES ('13', '13', '47');

-- ----------------------------
-- Table structure for `db_qualitymark`
-- ----------------------------
DROP TABLE IF EXISTS `db_qualitymark`;
CREATE TABLE `db_qualitymark` (
  `id` int(11) NOT NULL auto_increment,
  `quality_id` int(11) default NULL,
  `sample_id` int(11) default NULL,
  PRIMARY KEY  (`id`),
  KEY `quality_id` (`quality_id`),
  KEY `sample_id` (`sample_id`),
  CONSTRAINT `db_qualitymark_ibfk_1` FOREIGN KEY (`quality_id`) REFERENCES `db_qualitycontroller` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `db_qualitymark_ibfk_2` FOREIGN KEY (`sample_id`) REFERENCES `db_sample` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=17 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of db_qualitymark
-- ----------------------------
INSERT INTO `db_qualitymark` VALUES ('1', '1', '49');
INSERT INTO `db_qualitymark` VALUES ('2', '1', '48');
INSERT INTO `db_qualitymark` VALUES ('3', '2', '50');
INSERT INTO `db_qualitymark` VALUES ('4', '2', '51');
INSERT INTO `db_qualitymark` VALUES ('10', '7', '52');
INSERT INTO `db_qualitymark` VALUES ('11', '8', '53');
INSERT INTO `db_qualitymark` VALUES ('12', '9', '54');
INSERT INTO `db_qualitymark` VALUES ('13', '10', '54');
INSERT INTO `db_qualitymark` VALUES ('14', '11', '47');
INSERT INTO `db_qualitymark` VALUES ('15', '12', '47');
INSERT INTO `db_qualitymark` VALUES ('16', '13', '47');

-- ----------------------------
-- Table structure for `db_qualityscene`
-- ----------------------------
DROP TABLE IF EXISTS `db_qualityscene`;
CREATE TABLE `db_qualityscene` (
  `id` int(11) NOT NULL auto_increment,
  `quality_id` int(11) default NULL,
  `sample_id` int(11) default NULL,
  PRIMARY KEY  (`id`),
  KEY `quality_id` (`quality_id`),
  KEY `sample_id` (`sample_id`),
  CONSTRAINT `db_qualityscene_ibfk_1` FOREIGN KEY (`quality_id`) REFERENCES `db_qualitycontroller` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `db_qualityscene_ibfk_2` FOREIGN KEY (`sample_id`) REFERENCES `db_sample` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=17 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of db_qualityscene
-- ----------------------------
INSERT INTO `db_qualityscene` VALUES ('1', '1', '48');
INSERT INTO `db_qualityscene` VALUES ('2', '1', '49');
INSERT INTO `db_qualityscene` VALUES ('3', '1', '50');
INSERT INTO `db_qualityscene` VALUES ('4', '2', '50');
INSERT INTO `db_qualityscene` VALUES ('5', '2', '51');
INSERT INTO `db_qualityscene` VALUES ('6', '2', '49');
INSERT INTO `db_qualityscene` VALUES ('10', '7', '52');
INSERT INTO `db_qualityscene` VALUES ('11', '8', '53');
INSERT INTO `db_qualityscene` VALUES ('12', '8', '54');
INSERT INTO `db_qualityscene` VALUES ('13', '9', '54');
INSERT INTO `db_qualityscene` VALUES ('14', '11', '47');
INSERT INTO `db_qualityscene` VALUES ('15', '12', '47');
INSERT INTO `db_qualityscene` VALUES ('16', '13', '47');

-- ----------------------------
-- Table structure for `db_role`
-- ----------------------------
DROP TABLE IF EXISTS `db_role`;
CREATE TABLE `db_role` (
  `id` int(11) NOT NULL auto_increment,
  `name` varchar(255) NOT NULL,
  `department_id` int(11) NOT NULL,
  `state` int(11) NOT NULL default '0',
  PRIMARY KEY  (`id`),
  KEY `department_id` (`department_id`),
  CONSTRAINT `fk_role_department` FOREIGN KEY (`department_id`) REFERENCES `db_department` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of db_role
-- ----------------------------
INSERT INTO `db_role` VALUES ('1', '部门主管1', '3', '0');
INSERT INTO `db_role` VALUES ('2', '科室主任s', '1', '0');
INSERT INTO `db_role` VALUES ('3', '部门主管', '3', '0');
INSERT INTO `db_role` VALUES ('4', '二位2', '2', '0');
INSERT INTO `db_role` VALUES ('5', '12211', '2', '1');
INSERT INTO `db_role` VALUES ('6', '所产生的', '3', '0');
INSERT INTO `db_role` VALUES ('7', 'dqw', '2', '0');
INSERT INTO `db_role` VALUES ('8', '122的', '3', '0');
INSERT INTO `db_role` VALUES ('9', '成都市', '3', '0');
INSERT INTO `db_role` VALUES ('10', '23', '2', '0');

-- ----------------------------
-- Table structure for `db_sample`
-- ----------------------------
DROP TABLE IF EXISTS `db_sample`;
CREATE TABLE `db_sample` (
  `id` int(11) NOT NULL auto_increment,
  `identify` varchar(255) default NULL,
  `name` varchar(255) default NULL,
  `feature` varchar(255) default NULL,
  `condition` varchar(255) default NULL,
  `color` varchar(255) default NULL,
  `state` int(11) default '0',
  `task_id` int(11) default NULL,
  `receive` int(10) unsigned zerofill default '0000000000',
  PRIMARY KEY  (`id`),
  KEY `task_id` (`task_id`),
  CONSTRAINT `db_sample_ibfk_1` FOREIGN KEY (`task_id`) REFERENCES `db_task` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=66 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of db_sample
-- ----------------------------
INSERT INTO `db_sample` VALUES ('46', 'LXZ0027', '样品1', 'G', '+', '红色', '0', '11', '0000000000');
INSERT INTO `db_sample` VALUES ('47', 'ZFZ0028', '撒', 'G', '+', '红色', '0', '20', '0000000001');
INSERT INTO `db_sample` VALUES ('48', 'LXA0004', '样品1', 'G', '+', '红色', '0', '26', '0000000001');
INSERT INTO `db_sample` VALUES ('49', 'LXA0005', '样品2', 'S', '+', '绿色', '0', '26', '0000000001');
INSERT INTO `db_sample` VALUES ('50', 'LXA0006', '样品3', 'S', '-', '白色', '0', '26', '0000000001');
INSERT INTO `db_sample` VALUES ('51', 'LXA0007', '样品4', 'L', '+', '棕色', '0', '26', '0000000001');
INSERT INTO `db_sample` VALUES ('52', 'LXZ0029', '样品1', 'G', '+', '红色', '0', '18', '0000000001');
INSERT INTO `db_sample` VALUES ('53', 'LXZ0030', '样品2', 'L', '-', '白色', '0', '18', '0000000001');
INSERT INTO `db_sample` VALUES ('54', 'LXZ0031', '样品3', 'S', '+', '绿色', '0', '18', '0000000001');
INSERT INTO `db_sample` VALUES ('63', 'WTZ0032', '1', 'G', '+', '23', '0', '28', '0000000001');
INSERT INTO `db_sample` VALUES ('64', 'WTZ0033', '2', 'L', '+', '32', '0', '28', '0000000000');
INSERT INTO `db_sample` VALUES ('65', 'WTZ0034', '3', 'G', '-', '12', '0', '28', '0000000000');

-- ----------------------------
-- Table structure for `db_sampleproject`
-- ----------------------------
DROP TABLE IF EXISTS `db_sampleproject`;
CREATE TABLE `db_sampleproject` (
  `id` int(11) NOT NULL auto_increment,
  `sample_id` int(11) default NULL,
  `project_id` int(11) default NULL,
  PRIMARY KEY  (`id`),
  KEY `sample_id` (`sample_id`),
  KEY `project_id` (`project_id`),
  CONSTRAINT `db_sampleproject_ibfk_1` FOREIGN KEY (`sample_id`) REFERENCES `db_sample` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `db_sampleproject_ibfk_2` FOREIGN KEY (`project_id`) REFERENCES `db_monitorproject` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=86 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of db_sampleproject
-- ----------------------------
INSERT INTO `db_sampleproject` VALUES ('63', '46', '13');
INSERT INTO `db_sampleproject` VALUES ('64', '47', '15');
INSERT INTO `db_sampleproject` VALUES ('65', '48', '13');
INSERT INTO `db_sampleproject` VALUES ('66', '48', '15');
INSERT INTO `db_sampleproject` VALUES ('67', '48', '14');
INSERT INTO `db_sampleproject` VALUES ('68', '49', '13');
INSERT INTO `db_sampleproject` VALUES ('69', '49', '15');
INSERT INTO `db_sampleproject` VALUES ('70', '49', '14');
INSERT INTO `db_sampleproject` VALUES ('71', '50', '15');
INSERT INTO `db_sampleproject` VALUES ('72', '50', '14');
INSERT INTO `db_sampleproject` VALUES ('73', '50', '19');
INSERT INTO `db_sampleproject` VALUES ('74', '51', '15');
INSERT INTO `db_sampleproject` VALUES ('75', '51', '20');
INSERT INTO `db_sampleproject` VALUES ('76', '51', '19');
INSERT INTO `db_sampleproject` VALUES ('77', '52', '21');
INSERT INTO `db_sampleproject` VALUES ('78', '53', '17');
INSERT INTO `db_sampleproject` VALUES ('79', '53', '20');
INSERT INTO `db_sampleproject` VALUES ('80', '54', '17');
INSERT INTO `db_sampleproject` VALUES ('81', '54', '16');
INSERT INTO `db_sampleproject` VALUES ('82', '54', '20');
INSERT INTO `db_sampleproject` VALUES ('83', '63', '9');
INSERT INTO `db_sampleproject` VALUES ('84', '64', '9');
INSERT INTO `db_sampleproject` VALUES ('85', '65', '9');

-- ----------------------------
-- Table structure for `db_task`
-- ----------------------------
DROP TABLE IF EXISTS `db_task`;
CREATE TABLE `db_task` (
  `id` int(11) NOT NULL auto_increment,
  `identify` varchar(255) default NULL,
  `contract_id` int(11) default NULL,
  `client_unit` varchar(255) default NULL,
  `client_address` varchar(255) default NULL,
  `client_code` varchar(255) default NULL,
  `client_tel` varchar(255) default NULL,
  `client` varchar(255) default NULL,
  `project_name` varchar(255) default NULL,
  `monitor_aim` varchar(2000) default NULL,
  `monitor_way` int(11) default NULL,
  `monitor_way_desp` varchar(255) default NULL,
  `receive_deparment` int(11) default NULL,
  `other` varchar(2000) default NULL,
  `state` int(10) NOT NULL default '0',
  `create_time` date default NULL,
  `create_user` int(11) default NULL,
  `sample_type` int(11) default NULL,
  `sample_time` date default NULL,
  `sample_user` int(11) default NULL,
  `monitor_type` varchar(255) default NULL,
  `quality_user` int(11) default NULL,
  `quality_time` date default NULL,
  `receive_user` int(11) default NULL,
  `receive_time` date default NULL,
  `charge_user` int(11) default NULL,
  `distribute_time` date default NULL,
  PRIMARY KEY  (`id`),
  KEY `contract_id` (`contract_id`),
  KEY `receive_deparment` (`receive_deparment`),
  KEY `create_user` (`create_user`),
  KEY `sampe_user` (`sample_user`),
  KEY `quality_user` (`quality_user`),
  KEY `receive_user` (`receive_user`),
  KEY `charge_user` (`charge_user`),
  CONSTRAINT `db_task_ibfk_1` FOREIGN KEY (`receive_deparment`) REFERENCES `db_department` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `db_task_ibfk_2` FOREIGN KEY (`contract_id`) REFERENCES `db_contract` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `db_task_ibfk_3` FOREIGN KEY (`create_user`) REFERENCES `db_user` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `db_task_ibfk_4` FOREIGN KEY (`sample_user`) REFERENCES `db_user` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `db_task_ibfk_5` FOREIGN KEY (`quality_user`) REFERENCES `db_user` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `db_task_ibfk_6` FOREIGN KEY (`receive_user`) REFERENCES `db_user` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `db_task_ibfk_7` FOREIGN KEY (`charge_user`) REFERENCES `db_user` (`id`) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=30 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of db_task
-- ----------------------------
INSERT INTO `db_task` VALUES ('11', '2016-034', '21', '常州市环保局', '江苏省常州市新北区通江中路', '212000', '17714817535', '张三', '这是一个自建项目的DEMO', '监测目的为验证自测项目是否能成功', '0', '', '1', '无', '-2', '2016-11-04', '1', '0', '2016-11-12', '1', '例行监测', '1', '2016-11-16', '1', '2016-11-16', '1', '2016-11-16');
INSERT INTO `db_task` VALUES ('18', '2016-036', null, '常州市建设局', '江苏省常州市钟楼区', '212000', '17714817535', '李四', '测试自定义项目名称', '检测目的为xxx', '0', '', '1', '', '5', '2016-11-08', '1', '0', '2016-11-12', '1', '例行监测', '1', '2016-11-12', '1', '2016-11-13', '1', '2016-11-18');
INSERT INTO `db_task` VALUES ('19', '2016-037', null, '常州市建设局', '江苏省常州市钟楼区', '212000', '17714817535', '李四', '自定义项目', '无检测目的', '0', '', '1', '', '-2', '2016-11-08', '1', '0', null, null, '例行监测', '1', '2016-11-16', '1', '2016-11-16', '1', '2016-11-16');
INSERT INTO `db_task` VALUES ('20', '2016-005', '19', '常州市环保局', '江苏省常州市新北区通江中路', '212000', '17714817535', '张三', '江苏省常州市新北区环保一路水质检测报告', '江苏省常州市新北区环保一路水质检测情况统计', '1', '客户指定的监测方法', '1', '无其他约定', '5', '2016-11-08', '1', '0', '2016-11-08', '1', '执法监测', '1', '2016-11-16', '1', '2016-11-16', '1', '2016-11-18');
INSERT INTO `db_task` VALUES ('24', '2016-014', '30', '常州市建设局1', '江苏省常州市钟楼区', '212000', '17714817535', '李四', '项目1名称为xxxx', '监测目的为xxxx', '1', '客户指定的方法为xxxx', '1', '', '-2', '2016-11-10', '1', '0', null, null, '执法监测', null, null, null, null, null, null);
INSERT INTO `db_task` VALUES ('25', '2016-038', null, '测试自定义生成', '测试自定义生成', '测试自定义生成', '测试自定义生成', '测试自定义生成', '测试自定义生成', '测试自定义生成', '0', '', '1', '', '-2', '2016-11-10', '1', '0', null, null, '执法监测', null, null, null, null, null, null);
INSERT INTO `db_task` VALUES ('26', '2016-039', null, '常州市建设局', '江苏省常州市钟楼区', '212000', '17714817535', '李四', '这是一个自定义的任务书Demo', '监测目的为测试是否可以自定义样品信息', '0', '', '2', '', '4', '2016-11-11', '1', '1', '2016-11-11', '1', '例行监测', '1', '2016-11-12', '1', '2016-11-12', '1', '2016-11-16');
INSERT INTO `db_task` VALUES ('27', '2016-022', '39', '常州市建设局', '江苏省常州市钟楼区', '212000', '17714817535', '李四', '123', '23', '1', '212', '1', '212', '-2', '2016-11-15', '1', '0', null, null, '执法监测', null, null, null, null, null, null);
INSERT INTO `db_task` VALUES ('28', '2016-046', '45', '常州市建设局1', '江苏省常州市钟楼区', '212000', '17714817535', '李四', '合同模板啊啊啊啊啊啊啊', '监测目的为xxxx', '1', '客户指定的方法为xxxx', '1', '其他约定', '1', '2016-11-16', '1', '0', '2016-11-16', '1', '委托监测', null, null, null, null, null, null);
INSERT INTO `db_task` VALUES ('29', '2016-047', null, '常州市建设局', '江苏省常州市钟楼区', '212000', '17714817535', '李四', '12', '123', '0', '', '1', '', '0', '2016-11-16', '1', '0', null, null, '监督监测', null, null, null, null, null, null);

-- ----------------------------
-- Table structure for `db_taskdeliveryreceive`
-- ----------------------------
DROP TABLE IF EXISTS `db_taskdeliveryreceive`;
CREATE TABLE `db_taskdeliveryreceive` (
  `id` int(11) NOT NULL auto_increment,
  `task_id` int(11) default NULL,
  `package` varchar(255) default NULL,
  `sampleFlag` varchar(255) default NULL,
  `additive` varchar(255) default NULL,
  PRIMARY KEY  (`id`),
  KEY `task_id` (`task_id`),
  CONSTRAINT `db_taskdeliveryreceive_ibfk_1` FOREIGN KEY (`task_id`) REFERENCES `db_task` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of db_taskdeliveryreceive
-- ----------------------------
INSERT INTO `db_taskdeliveryreceive` VALUES ('1', '26', '破损', 'FG4', 'DSDFS');
INSERT INTO `db_taskdeliveryreceive` VALUES ('2', '18', '破损', 'SF', '无固体添加剂');
INSERT INTO `db_taskdeliveryreceive` VALUES ('3', '20', '完好', 'FG', '无固定添加剂');
INSERT INTO `db_taskdeliveryreceive` VALUES ('4', '19', '玷污', 'FG3', '无固定听到');
INSERT INTO `db_taskdeliveryreceive` VALUES ('5', '11', '玷污', 'dsdv', '无固定添加剂');

-- ----------------------------
-- Table structure for `db_user`
-- ----------------------------
DROP TABLE IF EXISTS `db_user`;
CREATE TABLE `db_user` (
  `id` int(11) NOT NULL auto_increment,
  `username` varchar(50) NOT NULL,
  `password` varchar(255) NOT NULL,
  `name` varchar(255) NOT NULL,
  `gender` int(11) default NULL,
  `idCard` varchar(20) NOT NULL,
  `tel` varchar(20) default NULL,
  `role_id` int(11) NOT NULL,
  `state` int(11) NOT NULL,
  `last_login` date default NULL,
  `line` int(11) default NULL,
  PRIMARY KEY  (`id`),
  KEY `role_id` (`role_id`),
  CONSTRAINT `user_role` FOREIGN KEY (`role_id`) REFERENCES `db_role` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of db_user
-- ----------------------------
INSERT INTO `db_user` VALUES ('1', 'admin', 'E00CF25AD42683B3DF678C61F42C6BDA', '超级管理员', '0', '320404199202214414', '17714817535', '2', '0', '2016-11-25', '1');
INSERT INTO `db_user` VALUES ('2', 'admin1', '10A5EF176D5EEAAA3781288A70D0A6E5', '张三', '1', '320404199202214413', '17714817535', '4', '0', null, null);
INSERT INTO `db_user` VALUES ('3', 'qulongjun1', 'F162EFC69D2DB5532C74B6FEF7E992D2', '张三', '0', '320404199202214411', '17714817432', '7', '0', '2016-11-14', '1');
INSERT INTO `db_user` VALUES ('4', 'qulongjun12', '10A5EF176D5EEAAA3781288A70D0A6E5', '张三', '0', '320404199202214410', '17714817432', '7', '0', null, null);
INSERT INTO `db_user` VALUES ('5', 'qulongjun1221', '10A5EF176D5EEAAA3781288A70D0A6E5', '张三', '0', '3204041992022144102', '17714817432', '7', '0', null, null);
INSERT INTO `db_user` VALUES ('6', 'qulongjun121sa', '10A5EF176D5EEAAA3781288A70D0A6E5', 'qulongjun', '0', '12324', '1212', '4', '0', null, null);
INSERT INTO `db_user` VALUES ('7', 'qulongjun112', '10A5EF176D5EEAAA3781288A70D0A6E5', 'sdsd', '1', '32040419920221441412', '17714817535', '4', '0', null, null);
INSERT INTO `db_user` VALUES ('8', 'zhagnsan', '670B14728AD9902AECBA32E22FA4F6BD', '张三', '0', '320404199202214412', '17714983233', '2', '0', null, null);
INSERT INTO `db_user` VALUES ('9', 'zhagnsan2', '670B14728AD9902AECBA32E22FA4F6BD', '张三2', '0', '32040419920221441', '17714983233', '2', '0', null, null);
INSERT INTO `db_user` VALUES ('10', '12213', 'E00CF25AD42683B3DF678C61F42C6BDA', 'dfsf', '0', 'w12', '21', '6', '0', null, null);
