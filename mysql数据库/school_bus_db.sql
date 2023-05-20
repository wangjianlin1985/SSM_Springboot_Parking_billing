/*
Navicat MySQL Data Transfer

Source Server         : localhost_3306
Source Server Version : 50051
Source Host           : localhost:3306
Source Database       : school_bus_db

Target Server Type    : MYSQL
Target Server Version : 50051
File Encoding         : 65001

Date: 2019-03-21 23:27:08
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for `admin`
-- ----------------------------
DROP TABLE IF EXISTS `admin`;
CREATE TABLE `admin` (
  `username` varchar(20) NOT NULL default '',
  `password` varchar(32) default NULL,
  PRIMARY KEY  (`username`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of admin
-- ----------------------------
INSERT INTO `admin` VALUES ('a', 'a');

-- ----------------------------
-- Table structure for `t_notice`
-- ----------------------------
DROP TABLE IF EXISTS `t_notice`;
CREATE TABLE `t_notice` (
  `noticeId` int(11) NOT NULL auto_increment COMMENT '公告id',
  `title` varchar(80) NOT NULL COMMENT '标题',
  `content` varchar(5000) NOT NULL COMMENT '公告内容',
  `publishDate` varchar(20) default NULL COMMENT '发布时间',
  PRIMARY KEY  (`noticeId`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of t_notice
-- ----------------------------
INSERT INTO `t_notice` VALUES ('1', '校内车辆停车管理系统开通了', '<p>以后大家停车收费方便多了，职工可以免费停车哈！</p>', '2019-03-20 02:20:37');
INSERT INTO `t_notice` VALUES ('2', 'aaaaaa', '<p>bbbbbbbb</p>', '2019-03-21 23:00:59');

-- ----------------------------
-- Table structure for `t_schoolbus`
-- ----------------------------
DROP TABLE IF EXISTS `t_schoolbus`;
CREATE TABLE `t_schoolbus` (
  `busId` int(11) NOT NULL auto_increment COMMENT '记录id',
  `busNo` varchar(20) NOT NULL COMMENT '车牌号',
  `busPhoto` varchar(60) NOT NULL COMMENT '校车图片',
  `busModel` varchar(20) NOT NULL COMMENT '车辆型号',
  `buyDate` varchar(20) default NULL COMMENT '购买日期',
  `recentRepairTime` varchar(20) default NULL COMMENT '最近一次维修时间',
  `busDesc` varchar(8000) NOT NULL COMMENT '车辆详情',
  PRIMARY KEY  (`busId`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of t_schoolbus
-- ----------------------------
INSERT INTO `t_schoolbus` VALUES ('1', '川A-3240', 'upload/efa637b3-aa5b-4596-8141-3fbd66f42e36.jpg', '面包车', '2019-03-06', '2019-03-18', '<p>车辆性能稳定</p>');
INSERT INTO `t_schoolbus` VALUES ('2', '川A-3210', 'upload/dba58505-5b2d-4f57-8ec6-3836a7a9c71d.jpg', '大巴', '2019-03-08', '2019-03-19', '<p>可以容纳很多同学哦</p>');

-- ----------------------------
-- Table structure for `t_staffvehicle`
-- ----------------------------
DROP TABLE IF EXISTS `t_staffvehicle`;
CREATE TABLE `t_staffvehicle` (
  `carId` int(11) NOT NULL auto_increment COMMENT '记录id',
  `teacherName` varchar(20) NOT NULL COMMENT '教职工姓名',
  `carNo` varchar(20) NOT NULL COMMENT '教职工车牌',
  `vehiclePhoto` varchar(60) NOT NULL COMMENT '车辆图片',
  `leftDays` float NOT NULL COMMENT '剩余停车天数',
  `carDesc` varchar(8000) default NULL COMMENT '车辆描述',
  PRIMARY KEY  (`carId`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of t_staffvehicle
-- ----------------------------
INSERT INTO `t_staffvehicle` VALUES ('1', '王晓峰', '川A-3984', 'upload/bf5639f3-3035-438f-9975-4dfccbe843c5.jpg', '29', '<p>好车子，奥迪车</p>');
INSERT INTO `t_staffvehicle` VALUES ('2', '张大志', '川A-2393', 'upload/b265face-987f-4f06-b13e-366ea4bc0ba8.jpg', '20', '<p>此车很拉风</p>');

-- ----------------------------
-- Table structure for `t_userinfo`
-- ----------------------------
DROP TABLE IF EXISTS `t_userinfo`;
CREATE TABLE `t_userinfo` (
  `user_name` varchar(30) NOT NULL COMMENT 'user_name',
  `password` varchar(30) NOT NULL COMMENT '登录密码',
  `name` varchar(20) NOT NULL COMMENT '姓名',
  `gender` varchar(4) NOT NULL COMMENT '性别',
  `birthDate` varchar(20) default NULL COMMENT '出生日期',
  `userPhoto` varchar(60) NOT NULL COMMENT '用户照片',
  `telephone` varchar(20) NOT NULL COMMENT '联系电话',
  `email` varchar(50) NOT NULL COMMENT '邮箱',
  `address` varchar(80) default NULL COMMENT '家庭地址',
  `regTime` varchar(20) default NULL COMMENT '注册时间',
  PRIMARY KEY  (`user_name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of t_userinfo
-- ----------------------------
INSERT INTO `t_userinfo` VALUES ('user1', '123', '李明', '男', '2019-03-06', 'upload/81d39d29-b1ab-4150-81a7-c15afca3b864.jpg', '13958342342', 'dashen@163.com', '四川成都红星路13号', '2019-03-20 02:13:37');
INSERT INTO `t_userinfo` VALUES ('user2', '123', '张西西', '女', '2019-03-13', 'upload/a38fac45-87f6-4f7b-955b-60f9a3d64941.jpg', '13589834234', 'xixi@163.com', '四川南充滨江路', '2019-03-21 22:30:48');

-- ----------------------------
-- Table structure for `t_vehicleaccess`
-- ----------------------------
DROP TABLE IF EXISTS `t_vehicleaccess`;
CREATE TABLE `t_vehicleaccess` (
  `accessId` int(11) NOT NULL auto_increment COMMENT '记录id',
  `carNo` varchar(20) NOT NULL COMMENT '车牌号',
  `inTime` varchar(20) default NULL COMMENT '进入时间',
  `inDoor` varchar(20) NOT NULL COMMENT '进入校门',
  `outTime` varchar(20) default NULL COMMENT '离开时间',
  `outDoor` varchar(20) NOT NULL COMMENT '离开校门',
  `stopTime` varchar(20) NOT NULL COMMENT '停车时长',
  `costFlag` varchar(20) NOT NULL COMMENT '是否收费',
  `costMoney` float NOT NULL COMMENT '收费金额',
  `memo` varchar(800) default NULL COMMENT '备注信息',
  PRIMARY KEY  (`accessId`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of t_vehicleaccess
-- ----------------------------
INSERT INTO `t_vehicleaccess` VALUES ('1', '川A-4291', '2019-03-20 02:19:24', '南门', '2019-03-20 04:19:39', '北门', '2小时', '是', '20', '测试');
INSERT INTO `t_vehicleaccess` VALUES ('2', '川A-4291', '2019-03-21 21:17:29', '东校门', '2019-03-21 21:55:19', '西校门', '0.6小时', '是', '6', '11');
INSERT INTO `t_vehicleaccess` VALUES ('3', '川A-3984', '2019-03-21 21:19:44', '东校门', '--', '--', '--', '否', '0', '测试不收费');
INSERT INTO `t_vehicleaccess` VALUES ('4', '川A-2393', '2019-03-20 23:21:38', '东校门', '2019-03-21 23:25:27', '南校门', '24.1小时', '否', '0', '职工的不要钱');
INSERT INTO `t_vehicleaccess` VALUES ('5', '川A-2342', '2019-03-21 19:24:07', '西校门', '2019-03-21 23:24:54', '南校门', '4.0小时', '是', '40', '收费车辆');
