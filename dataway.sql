/*
 Navicat Premium Data Transfer

 Source Server         : 本地
 Source Server Type    : MySQL
 Source Server Version : 50712
 Source Host           : localhost:3306
 Source Schema         : dataway

 Target Server Type    : MySQL
 Target Server Version : 50712
 File Encoding         : 65001

 Date: 11/05/2020 15:16:27
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for interface_info
-- ----------------------------
DROP TABLE IF EXISTS `interface_info`;
CREATE TABLE `interface_info`  (
  `api_id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `api_method` varchar(12) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT 'HttpMethod：GET、PUT、POST',
  `api_path` varchar(512) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '拦截路径',
  `api_status` int(2) NOT NULL COMMENT '状态：0草稿，1发布，2有变更，3禁用',
  `api_comment` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '注释',
  `api_type` varchar(24) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '脚本类型：SQL、DataQL',
  `api_script` mediumtext CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '查询脚本：xxxxxxx',
  `api_schema` mediumtext CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL COMMENT '接口的请求/响应数据结构',
  `api_sample` mediumtext CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL COMMENT '请求/响应/请求头样本数据',
  `api_create_time` datetime(0) NULL DEFAULT CURRENT_TIMESTAMP(0) COMMENT '创建时间',
  `api_gmt_time` datetime(0) NULL DEFAULT CURRENT_TIMESTAMP(0) COMMENT '修改时间',
  PRIMARY KEY (`api_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 4 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = 'Dataway 中的API' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of interface_info
-- ----------------------------
INSERT INTO `interface_info` VALUES (1, 'POST', '/api/demos', 1, '', 'SQL', '-- a new Query.\nselect * from interface_info;', '{}', '{\"requestBody\":\"{\\\"message\\\":\\\"Hello DataQL.\\\"}\",\"headerData\":[]}', '2020-05-09 11:58:05', '2020-05-09 12:00:41');
INSERT INTO `interface_info` VALUES (2, 'GET', '/api/user', 1, '', 'SQL', '-- a new Query.\nselect * from user;', '{}', '{\"requestBody\":\"{\\\"message\\\":\\\"Hello DataQL.\\\"}\",\"headerData\":[]}', '2020-05-09 16:29:39', '2020-05-09 16:30:53');
INSERT INTO `interface_info` VALUES (3, 'GET', '/api/userById', 1, '根据ID获取用户信息', 'SQL', '\n    select * from user where id = #{id} ;\n', '{}', '{\"requestBody\":\"{\\\"id\\\":1}\",\"headerData\":[]}', '2020-05-09 17:04:48', '2020-05-09 17:24:38');

-- ----------------------------
-- Table structure for interface_release
-- ----------------------------
DROP TABLE IF EXISTS `interface_release`;
CREATE TABLE `interface_release`  (
  `pub_id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'Publish ID',
  `pub_api_id` int(11) NOT NULL COMMENT '所属API ID',
  `pub_method` varchar(12) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT 'HttpMethod：GET、PUT、POST',
  `pub_path` varchar(512) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '拦截路径',
  `pub_status` int(2) NOT NULL COMMENT '状态：0有效，1无效（可能被下线）',
  `pub_type` varchar(24) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '脚本类型：SQL、DataQL',
  `pub_script` mediumtext CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '查询脚本：xxxxxxx',
  `pub_script_ori` mediumtext CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '原始查询脚本，仅当类型为SQL时不同',
  `pub_schema` mediumtext CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL COMMENT '接口的请求/响应数据结构',
  `pub_sample` mediumtext CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL COMMENT '请求/响应/请求头样本数据',
  `pub_release_time` datetime(0) NULL DEFAULT CURRENT_TIMESTAMP(0) COMMENT '发布时间（下线不更新）',
  PRIMARY KEY (`pub_id`) USING BTREE,
  INDEX `idx_interface_release`(`pub_api_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 8 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = 'Dataway API 发布历史。' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of interface_release
-- ----------------------------
INSERT INTO `interface_release` VALUES (1, 1, 'POST', '/api/demos', 0, 'SQL', 'var tempCall = @@sql(`message`)<%-- a new Query.\nselect * from interface_info;%>;\nreturn tempCall(${message});', '-- a new Query.\nselect * from interface_info;', '{}', '{\"requestBody\":\"{\\\"message\\\":\\\"Hello DataQL.\\\"}\",\"headerData\":[]}', '2020-05-09 11:58:38');
INSERT INTO `interface_release` VALUES (2, 1, 'POST', '/api/demos', 0, 'SQL', 'var tempCall = @@sql(`message`)<%-- a new Query.\nselect * from interface_info;%>;\nreturn tempCall(${message});', '-- a new Query.\nselect * from interface_info;', '{}', '{\"requestBody\":\"{\\\"message\\\":\\\"Hello DataQL.\\\"}\",\"headerData\":[]}', '2020-05-09 12:00:41');
INSERT INTO `interface_release` VALUES (3, 2, 'GET', '/api/user', 0, 'SQL', 'var tempCall = @@sql(`message`)<%-- a new Query.\nselect * from user;%>;\nreturn tempCall(${message});', '-- a new Query.\nselect * from user;', '{}', '{\"requestBody\":\"{\\\"message\\\":\\\"Hello DataQL.\\\"}\",\"headerData\":[]}', '2020-05-09 16:30:53');
INSERT INTO `interface_release` VALUES (4, 3, 'GET', '/api/userById', 1, 'SQL', 'var tempCall = @@sql(`id`)<%\n    select * from user where id = #{id} ;\n%>;\nreturn tempCall(${id});', '\n    select * from user where id = #{id} ;\n', '{}', '{\"requestBody\":\"{\\\"id\\\":1}\",\"headerData\":[]}', '2020-05-09 17:05:04');
INSERT INTO `interface_release` VALUES (5, 3, 'GET', '/api/userById', 1, 'SQL', 'var tempCall = @@sql(`id`)<%\n    select * from user where id = #{id} ;\n%>;\nreturn tempCall(${id});', '\n    select * from user where id = #{id} ;\n', '{}', '{\"requestBody\":\"{\\\"id\\\":1}\",\"headerData\":[]}', '2020-05-09 17:06:37');
INSERT INTO `interface_release` VALUES (6, 3, 'GET', '/api/userById', 1, 'SQL', 'var tempCall = @@sql(`id`)<%-- a new Query.\nselect #{message};%>;\nreturn tempCall(${id});', '-- a new Query.\nselect #{message};', '{}', '{\"requestBody\":\"{\\\"id\\\":1}\",\"headerData\":[]}', '2020-05-09 17:23:23');
INSERT INTO `interface_release` VALUES (7, 3, 'GET', '/api/userById', 0, 'SQL', 'var tempCall = @@sql(`id`)<%\n    select * from user where id = #{id} ;\n%>;\nreturn tempCall(${id});', '\n    select * from user where id = #{id} ;\n', '{}', '{\"requestBody\":\"{\\\"id\\\":1}\",\"headerData\":[]}', '2020-05-09 17:24:38');

-- ----------------------------
-- Table structure for role
-- ----------------------------
DROP TABLE IF EXISTS `role`;
CREATE TABLE `role`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `userid` int(11) NOT NULL,
  `role` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 3 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of role
-- ----------------------------
INSERT INTO `role` VALUES (1, 1, '医生');
INSERT INTO `role` VALUES (2, 2, '护士');

-- ----------------------------
-- Table structure for user
-- ----------------------------
DROP TABLE IF EXISTS `user`;
CREATE TABLE `user`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 3 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of user
-- ----------------------------
INSERT INTO `user` VALUES (1, '张三');
INSERT INTO `user` VALUES (2, '李四');

SET FOREIGN_KEY_CHECKS = 1;
