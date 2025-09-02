/*
 Navicat Premium Dump SQL

 Source Server         : 本地
 Source Server Type    : MySQL
 Source Server Version : 80042 (8.0.42)
 Source Host           : localhost:3306
 Source Schema         : foodie_guide

 Target Server Type    : MySQL
 Target Server Version : 80042 (8.0.42)
 File Encoding         : 65001

 Date: 04/07/2025 11:39:28
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for foods
-- ----------------------------
DROP TABLE IF EXISTS `foods`;
CREATE TABLE `foods`  (
  `id` int NOT NULL AUTO_INCREMENT COMMENT '美食ID',
  `name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '美食名称',
  `description` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL COMMENT '美食简介',
  `category` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '标签（小吃、甜品、主食）',
  `region_name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '美食地区名称',
  `region_id` int NOT NULL COMMENT '所属地区ID（对应 regions.id）',
  `taste` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '口味描述，如辣、甜等',
  `ingredients` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL COMMENT '所需食材',
  `image_url` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL COMMENT '美食图片链接',
  `created_at` datetime NULL DEFAULT CURRENT_TIMESTAMP COMMENT '记录创建时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 60 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci COMMENT = '美食信息表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of foods
-- ----------------------------

-- ----------------------------
-- Table structure for ingredients
-- ----------------------------
DROP TABLE IF EXISTS `ingredients`;
CREATE TABLE `ingredients`  (
  `id` int NOT NULL AUTO_INCREMENT COMMENT '主键',
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '食材名称',
  `region_name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '所属地区名称',
  `region_id` int NOT NULL COMMENT '所属地区ID',
  `taste` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '味道描述',
  `attribute` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '食材属性（寒、凉、平、温、热）',
  `effect` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL COMMENT '食材功效描述',
  `image_url` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 33 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of ingredients
-- ----------------------------

-- ----------------------------
-- Table structure for questionnaire
-- ----------------------------
DROP TABLE IF EXISTS `questionnaire`;
CREATE TABLE `questionnaire`  (
  `id` int NOT NULL AUTO_INCREMENT COMMENT '试题ID',
  `title` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '题目',
  `answer` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '试题答案',
  `right_answer` varchar(2) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '正确答案',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 36 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of questionnaire
-- ----------------------------

-- ----------------------------
-- Table structure for region_food_relation
-- ----------------------------
DROP TABLE IF EXISTS `region_food_relation`;
CREATE TABLE `region_food_relation`  (
  `id` int NOT NULL AUTO_INCREMENT COMMENT '表id',
  `region_id` int NOT NULL COMMENT '地区id',
  `region_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `region_lng` double NOT NULL COMMENT '地区经度',
  `region_lat` double NOT NULL COMMENT '地区纬度',
  `food_ids` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL COMMENT '美食di列表',
  `ingredient_ids` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 968 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of region_food_relation
-- ----------------------------
INSERT INTO `region_food_relation` VALUES (486, 1, '北京市', 116.407387, 39.904179, '', '');
INSERT INTO `region_food_relation` VALUES (487, 2, '上海市', 121.473667, 31.230525, '', '');
INSERT INTO `region_food_relation` VALUES (488, 3, '天津市', 117.201509, 39.085318, '', '');
INSERT INTO `region_food_relation` VALUES (489, 4, '重庆市', 106.551787, 29.56268, '', '');
INSERT INTO `region_food_relation` VALUES (490, 5, '河北省', 114.530399, 38.037707, '', '');
INSERT INTO `region_food_relation` VALUES (491, 6, '山西省', 112.578781, 37.813948, '', '');
INSERT INTO `region_food_relation` VALUES (492, 7, '河南省', 113.753094, 34.767052, '', '');
INSERT INTO `region_food_relation` VALUES (493, 8, '辽宁省', 123.435093, 41.836743, '', '');
INSERT INTO `region_food_relation` VALUES (494, 9, '吉林省', 125.325802, 43.896942, '', '');
INSERT INTO `region_food_relation` VALUES (495, 10, '黑龙江省', 126.661998, 45.742253, '', '');
INSERT INTO `region_food_relation` VALUES (496, 11, '内蒙古自治区', 111.765226, 40.818233, '', '');
INSERT INTO `region_food_relation` VALUES (497, 12, '江苏省', 118.763563, 32.061377, '', '');
INSERT INTO `region_food_relation` VALUES (498, 13, '山东省', 117.020725, 36.670201, '', '');
INSERT INTO `region_food_relation` VALUES (499, 14, '安徽省', 117.330139, 31.734559, '', '');
INSERT INTO `region_food_relation` VALUES (500, 15, '浙江省', 120.152575, 30.266619, '', '');
INSERT INTO `region_food_relation` VALUES (501, 16, '福建省', 119.296194, 26.101082, '', '');
INSERT INTO `region_food_relation` VALUES (502, 17, '湖北省', 114.341552, 30.546222, '', '');
INSERT INTO `region_food_relation` VALUES (503, 18, '湖南省', 112.982951, 28.116007, '', '');
INSERT INTO `region_food_relation` VALUES (504, 19, '广东省', 113.266887, 23.133306, '', '');
INSERT INTO `region_food_relation` VALUES (505, 20, '广西壮族自治区', 108.327537, 22.816659, '', '');
INSERT INTO `region_food_relation` VALUES (506, 21, '江西省', 115.816587, 28.637234, '', '');
INSERT INTO `region_food_relation` VALUES (507, 22, '四川省', 104.076452, 30.651696, '', '');
INSERT INTO `region_food_relation` VALUES (508, 23, '海南省', 110.348781, 20.018639, '', '');
INSERT INTO `region_food_relation` VALUES (509, 24, '贵州省', 106.705251, 26.600328, '', '');
INSERT INTO `region_food_relation` VALUES (510, 25, '云南省', 102.709372, 25.046432, '', '');
INSERT INTO `region_food_relation` VALUES (511, 26, '西藏自治区', 91.117449, 29.648694, '', '');
INSERT INTO `region_food_relation` VALUES (512, 27, '陕西省', 108.953939, 34.266611, '', '');
INSERT INTO `region_food_relation` VALUES (513, 28, '甘肃省', 103.826777, 36.060634, '', '');
INSERT INTO `region_food_relation` VALUES (514, 29, '青海省', 101.780482, 36.622538, '', '');
INSERT INTO `region_food_relation` VALUES (515, 30, '宁夏回族自治区', 106.258889, 38.472273, '', '');
INSERT INTO `region_food_relation` VALUES (516, 31, '新疆维吾尔自治区', 87.628579, 43.793301, '', '');
INSERT INTO `region_food_relation` VALUES (517, 32, '台湾省', 121.509062, 25.044332, '', '');
INSERT INTO `region_food_relation` VALUES (518, 72, '朝阳区', 116.443136, 39.921444, '', '');
INSERT INTO `region_food_relation` VALUES (519, 78, '黄浦区', 121.48442, 31.231661, '', '');
INSERT INTO `region_food_relation` VALUES (520, 113, '万州区', 108.408591, 30.807621, '', '');
INSERT INTO `region_food_relation` VALUES (521, 114, '涪陵区', 107.246521, 29.752475, '', '');
INSERT INTO `region_food_relation` VALUES (522, 115, '梁平区', 107.769568, 30.654233, '', '');
INSERT INTO `region_food_relation` VALUES (523, 119, '南川区', 107.099147, 29.157879, '', '');
INSERT INTO `region_food_relation` VALUES (524, 123, '潼南区', 105.840487, 30.191077, '', '');
INSERT INTO `region_food_relation` VALUES (525, 126, '大足区', 105.721825, 29.707555, '', '');
INSERT INTO `region_food_relation` VALUES (526, 128, '黔江区', 108.770677, 29.533609, '', '');
INSERT INTO `region_food_relation` VALUES (527, 129, '武隆区', 107.759955, 29.325707, '', '');
INSERT INTO `region_food_relation` VALUES (528, 130, '丰都县', 107.731056, 29.863785, '', '');
INSERT INTO `region_food_relation` VALUES (529, 131, '奉节县', 109.401056, 31.018505, '', '');
INSERT INTO `region_food_relation` VALUES (530, 132, '开州区', 108.39336, 31.160416, '', '');
INSERT INTO `region_food_relation` VALUES (531, 133, '云阳县', 108.6975, 30.930628, '', '');
INSERT INTO `region_food_relation` VALUES (532, 134, '忠县', 108.038073, 30.299817, '', '');
INSERT INTO `region_food_relation` VALUES (533, 135, '巫溪县', 109.570038, 31.398619, '', '');
INSERT INTO `region_food_relation` VALUES (534, 136, '巫山县', 109.878995, 31.07478, '', '');
INSERT INTO `region_food_relation` VALUES (535, 137, '石柱土家族自治县', 108.114251, 29.999066, '', '');
INSERT INTO `region_food_relation` VALUES (536, 138, '彭水苗族土家族自治县', 108.165571, 29.293748, '', '');
INSERT INTO `region_food_relation` VALUES (537, 139, '垫江县', 107.332511, 30.327548, '', '');
INSERT INTO `region_food_relation` VALUES (538, 140, '酉阳土家族苗族自治县', 108.76726, 28.841409, '', '');
INSERT INTO `region_food_relation` VALUES (539, 141, '秀山土家族苗族自治县', 109.007096, 28.448248, '', '');
INSERT INTO `region_food_relation` VALUES (540, 142, '石家庄市', 114.514976, 38.042007, '', '');
INSERT INTO `region_food_relation` VALUES (541, 148, '邯郸市', 114.53915, 36.625849, '', '');
INSERT INTO `region_food_relation` VALUES (542, 164, '邢台市', 114.49742, 37.060227, '', '');
INSERT INTO `region_food_relation` VALUES (543, 199, '保定市', 115.464523, 38.874476, '', '');
INSERT INTO `region_food_relation` VALUES (544, 224, '张家口市', 114.885895, 40.768931, '', '');
INSERT INTO `region_food_relation` VALUES (545, 239, '承德市', 117.962749, 40.952942, '', '');
INSERT INTO `region_food_relation` VALUES (546, 248, '秦皇岛市', 119.52022, 39.888243, '', '');
INSERT INTO `region_food_relation` VALUES (547, 258, '唐山市', 118.180149, 39.63068, '', '');
INSERT INTO `region_food_relation` VALUES (548, 264, '沧州市', 116.838715, 38.304676, '', '');
INSERT INTO `region_food_relation` VALUES (549, 274, '廊坊市', 116.683546, 39.538304, '', '');
INSERT INTO `region_food_relation` VALUES (550, 275, '衡水市', 115.668987, 37.739367, '', '');
INSERT INTO `region_food_relation` VALUES (551, 303, '太原市', 112.549656, 37.870451, '', '');
INSERT INTO `region_food_relation` VALUES (552, 309, '大同市', 113.366749, 40.09711, '', '');
INSERT INTO `region_food_relation` VALUES (553, 318, '阳泉市', 113.580426, 37.857094, '', '');
INSERT INTO `region_food_relation` VALUES (554, 325, '晋城市', 112.852022, 35.491315, '', '');
INSERT INTO `region_food_relation` VALUES (555, 330, '朔州市', 112.432906, 39.331734, '', '');
INSERT INTO `region_food_relation` VALUES (556, 336, '晋中市', 112.752633, 37.688006, '', '');
INSERT INTO `region_food_relation` VALUES (557, 350, '忻州市', 112.734149, 38.415958, '', '');
INSERT INTO `region_food_relation` VALUES (558, 368, '吕梁市', 111.14454, 37.518996, '', '');
INSERT INTO `region_food_relation` VALUES (559, 379, '临汾市', 111.51931, 36.088581, '', '');
INSERT INTO `region_food_relation` VALUES (560, 398, '运城市', 111.007051, 35.02667, '', '');
INSERT INTO `region_food_relation` VALUES (561, 412, '郑州市', 113.625351, 34.746303, '', '');
INSERT INTO `region_food_relation` VALUES (562, 420, '开封市', 114.314278, 34.798083, '', '');
INSERT INTO `region_food_relation` VALUES (563, 427, '洛阳市', 112.453895, 34.619702, '', '');
INSERT INTO `region_food_relation` VALUES (564, 438, '平顶山市', 113.192595, 33.766554, '', '');
INSERT INTO `region_food_relation` VALUES (565, 446, '焦作市', 113.241902, 35.215726, '', '');
INSERT INTO `region_food_relation` VALUES (566, 454, '鹤壁市', 114.297305, 35.748329, '', '');
INSERT INTO `region_food_relation` VALUES (567, 458, '新乡市', 113.92679, 35.303589, '', '');
INSERT INTO `region_food_relation` VALUES (568, 468, '安阳市', 114.39248, 36.098779, '', '');
INSERT INTO `region_food_relation` VALUES (569, 475, '濮阳市', 115.029246, 35.762731, '', '');
INSERT INTO `region_food_relation` VALUES (570, 482, '许昌市', 113.852004, 34.03732, '', '');
INSERT INTO `region_food_relation` VALUES (571, 489, '漯河市', 114.0166, 33.58038, '', '');
INSERT INTO `region_food_relation` VALUES (572, 495, '三门峡市', 111.200482, 34.773196, '', '');
INSERT INTO `region_food_relation` VALUES (573, 502, '南阳市', 112.584753, 33.016102, '', '');
INSERT INTO `region_food_relation` VALUES (574, 517, '商丘市', 115.656358, 34.415165, '', '');
INSERT INTO `region_food_relation` VALUES (575, 527, '周口市', 114.701222, 33.634652, '', '');
INSERT INTO `region_food_relation` VALUES (576, 538, '驻马店市', 114.021988, 33.014038, '', '');
INSERT INTO `region_food_relation` VALUES (577, 549, '信阳市', 114.091058, 32.148624, '', '');
INSERT INTO `region_food_relation` VALUES (578, 560, '沈阳市', 123.464675, 41.677576, '', '');
INSERT INTO `region_food_relation` VALUES (579, 573, '大连市', 121.614786, 38.913962, '', '');
INSERT INTO `region_food_relation` VALUES (580, 579, '鞍山市', 122.994183, 41.108239, '', '');
INSERT INTO `region_food_relation` VALUES (581, 584, '抚顺市', 123.957053, 41.881311, '', '');
INSERT INTO `region_food_relation` VALUES (582, 589, '本溪市', 123.766669, 41.294123, '', '');
INSERT INTO `region_food_relation` VALUES (583, 593, '丹东市', 124.354419, 40.000646, '', '');
INSERT INTO `region_food_relation` VALUES (584, 598, '锦州市', 121.126859, 41.096114, '', '');
INSERT INTO `region_food_relation` VALUES (585, 604, '葫芦岛市', 120.836783, 40.710974, '', '');
INSERT INTO `region_food_relation` VALUES (586, 609, '营口市', 122.219148, 40.625027, '', '');
INSERT INTO `region_food_relation` VALUES (587, 613, '盘锦市', 122.170729, 40.71956, '', '');
INSERT INTO `region_food_relation` VALUES (588, 617, '阜新市', 121.670052, 42.022028, '', '');
INSERT INTO `region_food_relation` VALUES (589, 621, '辽阳市', 123.239669, 41.267396, '', '');
INSERT INTO `region_food_relation` VALUES (590, 632, '朝阳市', 120.488801, 41.601855, '', '');
INSERT INTO `region_food_relation` VALUES (591, 639, '长春市', 125.323643, 43.816996, '', '');
INSERT INTO `region_food_relation` VALUES (592, 644, '吉林市', 126.549719, 43.838132, '', '');
INSERT INTO `region_food_relation` VALUES (593, 651, '四平市', 124.350599, 43.166764, '', '');
INSERT INTO `region_food_relation` VALUES (594, 657, '通化市', 125.939721, 41.728312, '', '');
INSERT INTO `region_food_relation` VALUES (595, 664, '白山市', 126.414274, 41.944132, '', '');
INSERT INTO `region_food_relation` VALUES (596, 674, '松原市', 124.825321, 45.14191, '', '');
INSERT INTO `region_food_relation` VALUES (597, 681, '白城市', 122.838102, 45.620131, '', '');
INSERT INTO `region_food_relation` VALUES (598, 687, '延边朝鲜族自治州', 129.470605, 42.909426, '', '');
INSERT INTO `region_food_relation` VALUES (599, 698, '哈尔滨市', 126.53505, 45.802981, '', '');
INSERT INTO `region_food_relation` VALUES (600, 712, '齐齐哈尔市', 123.918193, 47.354892, '', '');
INSERT INTO `region_food_relation` VALUES (601, 727, '鹤岗市', 130.297687, 47.350659, '', '');
INSERT INTO `region_food_relation` VALUES (602, 731, '双鸭山市', 131.141563, 46.676157, '', '');
INSERT INTO `region_food_relation` VALUES (603, 737, '鸡西市', 130.969385, 45.295087, '', '');
INSERT INTO `region_food_relation` VALUES (604, 742, '大庆市', 125.104078, 46.589498, '', '');
INSERT INTO `region_food_relation` VALUES (605, 753, '伊春市', 128.840863, 47.728332, '', '');
INSERT INTO `region_food_relation` VALUES (606, 757, '牡丹江市', 129.632928, 44.551486, '', '');
INSERT INTO `region_food_relation` VALUES (607, 765, '佳木斯市', 130.318916, 46.800002, '', '');
INSERT INTO `region_food_relation` VALUES (608, 773, '七台河市', 131.003015, 45.771178, '', '');
INSERT INTO `region_food_relation` VALUES (609, 776, '黑河市', 127.528226, 50.244887, '', '');
INSERT INTO `region_food_relation` VALUES (610, 782, '绥化市', 126.968714, 46.654147, '', '');
INSERT INTO `region_food_relation` VALUES (611, 793, '大兴安岭地区', 124.11786, 50.41129, '', '');
INSERT INTO `region_food_relation` VALUES (612, 799, '呼和浩特市', 111.748814, 40.842127, '', '');
INSERT INTO `region_food_relation` VALUES (613, 805, '包头市', 109.95315, 40.621327, '', '');
INSERT INTO `region_food_relation` VALUES (614, 810, '乌海市', 106.79415, 39.655048, '', '');
INSERT INTO `region_food_relation` VALUES (615, 812, '赤峰市', 118.887613, 42.256876, '', '');
INSERT INTO `region_food_relation` VALUES (616, 823, '乌兰察布市', 113.132227, 40.994526, '', '');
INSERT INTO `region_food_relation` VALUES (617, 835, '锡林郭勒盟', 116.047387, 43.933212, '', '');
INSERT INTO `region_food_relation` VALUES (618, 848, '呼伦贝尔市', 119.77845, 49.166536, '', '');
INSERT INTO `region_food_relation` VALUES (619, 870, '鄂尔多斯市', 109.782473, 39.608744, '', '');
INSERT INTO `region_food_relation` VALUES (620, 880, '巴彦淖尔市', 107.387767, 40.742987, '', '');
INSERT INTO `region_food_relation` VALUES (621, 891, '阿拉善盟', 105.729135, 38.851554, '', '');
INSERT INTO `region_food_relation` VALUES (622, 895, '兴安盟', 122.037796, 46.082373, '', '');
INSERT INTO `region_food_relation` VALUES (623, 902, '通辽市', 122.243309, 43.653566, '', '');
INSERT INTO `region_food_relation` VALUES (624, 904, '南京市', 118.796624, 32.059344, '', '');
INSERT INTO `region_food_relation` VALUES (625, 911, '徐州市', 117.283752, 34.204224, '', '');
INSERT INTO `region_food_relation` VALUES (626, 919, '连云港市', 119.221487, 34.596639, '', '');
INSERT INTO `region_food_relation` VALUES (627, 925, '淮安市', 119.113166, 33.551495, '', '');
INSERT INTO `region_food_relation` VALUES (628, 933, '宿迁市', 118.275228, 33.963186, '', '');
INSERT INTO `region_food_relation` VALUES (629, 939, '盐城市', 120.16263, 33.348176, '', '');
INSERT INTO `region_food_relation` VALUES (630, 951, '扬州市', 119.412834, 32.394404, '', '');
INSERT INTO `region_food_relation` VALUES (631, 959, '泰州市', 119.922883, 32.456692, '', '');
INSERT INTO `region_food_relation` VALUES (632, 965, '南通市', 120.894522, 31.981269, '', '');
INSERT INTO `region_food_relation` VALUES (633, 972, '镇江市', 119.424441, 32.188141, '', '');
INSERT INTO `region_food_relation` VALUES (634, 978, '常州市', 119.974092, 31.811313, '', '');
INSERT INTO `region_food_relation` VALUES (635, 984, '无锡市', 120.311889, 31.491064, '', '');
INSERT INTO `region_food_relation` VALUES (636, 988, '苏州市', 120.585294, 31.299758, '', '');
INSERT INTO `region_food_relation` VALUES (637, 1000, '济南市', 117.120128, 36.652069, '', '');
INSERT INTO `region_food_relation` VALUES (638, 1007, '青岛市', 120.382665, 36.066938, '', '');
INSERT INTO `region_food_relation` VALUES (639, 1016, '淄博市', 118.054994, 36.813787, '', '');
INSERT INTO `region_food_relation` VALUES (640, 1022, '枣庄市', 117.323759, 34.810858, '', '');
INSERT INTO `region_food_relation` VALUES (641, 1025, '东营市', 118.674633, 37.433992, '', '');
INSERT INTO `region_food_relation` VALUES (642, 1032, '潍坊市', 119.161721, 36.707668, '', '');
INSERT INTO `region_food_relation` VALUES (643, 1042, '烟台市', 121.447755, 37.464551, '', '');
INSERT INTO `region_food_relation` VALUES (644, 1053, '威海市', 122.120519, 37.513315, '', '');
INSERT INTO `region_food_relation` VALUES (645, 1060, '德州市', 116.359244, 37.436492, '', '');
INSERT INTO `region_food_relation` VALUES (646, 1072, '临沂市', 118.356464, 35.103771, '', '');
INSERT INTO `region_food_relation` VALUES (647, 1081, '聊城市', 115.985238, 36.455857, '', '');
INSERT INTO `region_food_relation` VALUES (648, 1090, '滨州市', 117.970731, 37.382687, '', '');
INSERT INTO `region_food_relation` VALUES (649, 1099, '菏泽市', 115.479646, 35.234309, '', '');
INSERT INTO `region_food_relation` VALUES (650, 1108, '日照市', 119.52685, 35.416912, '', '');
INSERT INTO `region_food_relation` VALUES (651, 1112, '泰安市', 117.086963, 36.201784, '', '');
INSERT INTO `region_food_relation` VALUES (652, 1114, '铜陵市', 117.811298, 30.945214, '', '');
INSERT INTO `region_food_relation` VALUES (653, 1116, '合肥市', 117.227267, 31.820567, '', '');
INSERT INTO `region_food_relation` VALUES (654, 1121, '淮南市', 117.018603, 32.585384, '', '');
INSERT INTO `region_food_relation` VALUES (655, 1124, '淮北市', 116.798362, 33.956264, '', '');
INSERT INTO `region_food_relation` VALUES (656, 1127, '芜湖市', 118.433065, 31.352614, '', '');
INSERT INTO `region_food_relation` VALUES (657, 1132, '蚌埠市', 117.388566, 32.91682, '', '');
INSERT INTO `region_food_relation` VALUES (658, 1137, '马鞍山市', 118.50685, 31.668765, '', '');
INSERT INTO `region_food_relation` VALUES (659, 1140, '安庆市', 117.115349, 30.531828, '', '');
INSERT INTO `region_food_relation` VALUES (660, 1151, '黄山市', 118.337643, 29.714886, '', '');
INSERT INTO `region_food_relation` VALUES (661, 1158, '宁波市', 121.62454, 29.860258, '', '');
INSERT INTO `region_food_relation` VALUES (662, 1159, '滁州市', 118.333439, 32.255904, '', '');
INSERT INTO `region_food_relation` VALUES (663, 1167, '阜阳市', 115.814252, 32.891032, '', '');
INSERT INTO `region_food_relation` VALUES (664, 1174, '亳州市', 115.778588, 33.846285, '', '');
INSERT INTO `region_food_relation` VALUES (665, 1180, '宿州市', 116.96419, 33.647726, '', '');
INSERT INTO `region_food_relation` VALUES (666, 1201, '池州市', 117.495663, 30.674264, '', '');
INSERT INTO `region_food_relation` VALUES (667, 1206, '六安市', 116.519729, 31.735892, '', '');
INSERT INTO `region_food_relation` VALUES (668, 1213, '杭州市', 120.209903, 30.246566, '', '');
INSERT INTO `region_food_relation` VALUES (669, 1233, '温州市', 120.699279, 27.993849, '', '');
INSERT INTO `region_food_relation` VALUES (670, 1243, '嘉兴市', 120.755623, 30.746814, '', '');
INSERT INTO `region_food_relation` VALUES (671, 1250, '湖州市', 120.086881, 30.894178, '', '');
INSERT INTO `region_food_relation` VALUES (672, 1255, '绍兴市', 120.582886, 30.051549, '', '');
INSERT INTO `region_food_relation` VALUES (673, 1262, '金华市', 119.647265, 29.079195, '', '');
INSERT INTO `region_food_relation` VALUES (674, 1273, '衢州市', 118.859307, 28.970229, '', '');
INSERT INTO `region_food_relation` VALUES (675, 1280, '丽水市', 119.923249, 28.467694, '', '');
INSERT INTO `region_food_relation` VALUES (676, 1290, '台州市', 121.42079, 28.655716, '', '');
INSERT INTO `region_food_relation` VALUES (677, 1298, '舟山市', 122.207395, 29.985578, '', '');
INSERT INTO `region_food_relation` VALUES (678, 1303, '福州市', 119.296411, 26.074286, '', '');
INSERT INTO `region_food_relation` VALUES (679, 1315, '厦门市', 118.08891, 24.479627, '', '');
INSERT INTO `region_food_relation` VALUES (680, 1317, '三明市', 117.638919, 26.263455, '', '');
INSERT INTO `region_food_relation` VALUES (681, 1329, '莆田市', 119.007662, 25.454202, '', '');
INSERT INTO `region_food_relation` VALUES (682, 1332, '泉州市', 118.675724, 24.874452, '', '');
INSERT INTO `region_food_relation` VALUES (683, 1341, '漳州市', 117.647298, 24.515297, '', '');
INSERT INTO `region_food_relation` VALUES (684, 1352, '南平市', 118.081325, 27.382829, '', '');
INSERT INTO `region_food_relation` VALUES (685, 1362, '龙岩市', 117.017362, 25.075884, '', '');
INSERT INTO `region_food_relation` VALUES (686, 1370, '宁德市', 119.547729, 26.666222, '', '');
INSERT INTO `region_food_relation` VALUES (687, 1381, '武汉市', 114.304569, 30.593354, '', '');
INSERT INTO `region_food_relation` VALUES (688, 1387, '黄石市', 115.038999, 30.201082, '', '');
INSERT INTO `region_food_relation` VALUES (689, 1396, '襄阳市', 112.121743, 32.010161, '', '');
INSERT INTO `region_food_relation` VALUES (690, 1405, '十堰市', 110.798921, 32.629057, '', '');
INSERT INTO `region_food_relation` VALUES (691, 1413, '荆州市', 112.24143, 30.336282, '', '');
INSERT INTO `region_food_relation` VALUES (692, 1421, '宜昌市', 111.286962, 30.69217, '', '');
INSERT INTO `region_food_relation` VALUES (693, 1432, '孝感市', 113.956962, 30.918311, '', '');
INSERT INTO `region_food_relation` VALUES (694, 1441, '黄冈市', 114.872425, 30.453722, '', '');
INSERT INTO `region_food_relation` VALUES (695, 1458, '咸宁市', 114.322601, 29.84135, '', '');
INSERT INTO `region_food_relation` VALUES (696, 1466, '恩施土家族苗族自治州', 109.488076, 30.272104, '', '');
INSERT INTO `region_food_relation` VALUES (697, 1475, '鄂州市', 114.894909, 30.391461, '', '');
INSERT INTO `region_food_relation` VALUES (698, 1477, '荆门市', 112.199009, 31.035445, '', '');
INSERT INTO `region_food_relation` VALUES (699, 1479, '随州市', 113.382324, 31.690275, '', '');
INSERT INTO `region_food_relation` VALUES (700, 1482, '长沙市', 112.938882, 28.228304, '', '');
INSERT INTO `region_food_relation` VALUES (701, 1488, '株洲市', 113.132783, 27.828862, '', '');
INSERT INTO `region_food_relation` VALUES (702, 1495, '湘潭市', 112.945439, 27.83136, '', '');
INSERT INTO `region_food_relation` VALUES (703, 1501, '衡阳市', 112.572016, 26.894216, '', '');
INSERT INTO `region_food_relation` VALUES (704, 1511, '邵阳市', 111.467855, 27.239528, '', '');
INSERT INTO `region_food_relation` VALUES (705, 1522, '岳阳市', 113.128922, 29.35648, '', '');
INSERT INTO `region_food_relation` VALUES (706, 1530, '常德市', 111.69905, 29.031446, '', '');
INSERT INTO `region_food_relation` VALUES (707, 1540, '张家界市', 110.478887, 29.117343, '', '');
INSERT INTO `region_food_relation` VALUES (708, 1544, '郴州市', 113.015517, 25.770117, '', '');
INSERT INTO `region_food_relation` VALUES (709, 1555, '益阳市', 112.355994, 28.554853, '', '');
INSERT INTO `region_food_relation` VALUES (710, 1560, '永州市', 111.613482, 26.419861, '', '');
INSERT INTO `region_food_relation` VALUES (711, 1574, '怀化市', 110.001598, 27.569813, '', '');
INSERT INTO `region_food_relation` VALUES (712, 1586, '娄底市', 111.994468, 27.699838, '', '');
INSERT INTO `region_food_relation` VALUES (713, 1592, '湘西土家族苗族自治州', 109.673345, 28.215983, '', '');
INSERT INTO `region_food_relation` VALUES (714, 1601, '广州市', 113.264499, 23.130061, '', '');
INSERT INTO `region_food_relation` VALUES (715, 1607, '深圳市', 114.057939, 22.543527, '', '');
INSERT INTO `region_food_relation` VALUES (716, 1609, '珠海市', 113.576892, 22.271644, '', '');
INSERT INTO `region_food_relation` VALUES (717, 1611, '汕头市', 116.681956, 23.354152, '', '');
INSERT INTO `region_food_relation` VALUES (718, 1617, '韶关市', 113.597324, 24.810977, '', '');
INSERT INTO `region_food_relation` VALUES (719, 1627, '河源市', 114.700215, 23.744276, '', '');
INSERT INTO `region_food_relation` VALUES (720, 1634, '梅州市', 116.122046, 24.288832, '', '');
INSERT INTO `region_food_relation` VALUES (721, 1643, '惠州市', 114.415587, 23.112368, '', '');
INSERT INTO `region_food_relation` VALUES (722, 1650, '汕尾市', 115.375557, 22.787204, '', '');
INSERT INTO `region_food_relation` VALUES (723, 1655, '东莞市', 113.751884, 23.021016, '', '');
INSERT INTO `region_food_relation` VALUES (724, 1657, '中山市', 113.392517, 22.517024, '', '');
INSERT INTO `region_food_relation` VALUES (725, 1659, '江门市', 113.081548, 22.578948, '', '');
INSERT INTO `region_food_relation` VALUES (726, 1666, '佛山市', 113.121586, 23.021351, '', '');
INSERT INTO `region_food_relation` VALUES (727, 1672, '阳江市', 111.98343, 21.856853, '', '');
INSERT INTO `region_food_relation` VALUES (728, 1677, '湛江市', 110.357538, 21.270108, '', '');
INSERT INTO `region_food_relation` VALUES (729, 1684, '茂名市', 110.925533, 21.662728, '', '');
INSERT INTO `region_food_relation` VALUES (730, 1690, '肇庆市', 112.465245, 23.047747, '', '');
INSERT INTO `region_food_relation` VALUES (731, 1698, '云浮市', 112.044524, 22.915163, '', '');
INSERT INTO `region_food_relation` VALUES (732, 1704, '清远市', 113.056098, 23.682064, '', '');
INSERT INTO `region_food_relation` VALUES (733, 1705, '潮州市', 116.621901, 23.657662, '', '');
INSERT INTO `region_food_relation` VALUES (734, 1709, '揭阳市', 116.372732, 23.550968, '', '');
INSERT INTO `region_food_relation` VALUES (735, 1715, '南宁市', 108.366407, 22.8177, '', '');
INSERT INTO `region_food_relation` VALUES (736, 1720, '柳州市', 109.428071, 24.326442, '', '');
INSERT INTO `region_food_relation` VALUES (737, 1726, '桂林市', 110.179752, 25.235615, '', '');
INSERT INTO `region_food_relation` VALUES (738, 1740, '梧州市', 111.279022, 23.476733, '', '');
INSERT INTO `region_food_relation` VALUES (739, 1746, '北海市', 109.120248, 21.481305, '', '');
INSERT INTO `region_food_relation` VALUES (740, 1749, '防城港市', 108.35467, 21.686732, '', '');
INSERT INTO `region_food_relation` VALUES (741, 1753, '钦州市', 108.654355, 21.980894, '', '');
INSERT INTO `region_food_relation` VALUES (742, 1757, '贵港市', 109.598903, 23.11182, '', '');
INSERT INTO `region_food_relation` VALUES (743, 1761, '玉林市', 110.18097, 22.654001, '', '');
INSERT INTO `region_food_relation` VALUES (744, 1792, '贺州市', 111.567216, 24.404182, '', '');
INSERT INTO `region_food_relation` VALUES (745, 1806, '百色市', 106.61869, 23.90307, '', '');
INSERT INTO `region_food_relation` VALUES (746, 1818, '河池市', 108.63639, 24.48523, '', '');
INSERT INTO `region_food_relation` VALUES (747, 1827, '南昌市', 115.857972, 28.682976, '', '');
INSERT INTO `region_food_relation` VALUES (748, 1832, '景德镇市', 117.184892, 29.2744, '', '');
INSERT INTO `region_food_relation` VALUES (749, 1836, '萍乡市', 113.887147, 27.658721, '', '');
INSERT INTO `region_food_relation` VALUES (750, 1842, '新余市', 114.916665, 27.818553, '', '');
INSERT INTO `region_food_relation` VALUES (751, 1845, '九江市', 115.95356, 29.66116, '', '');
INSERT INTO `region_food_relation` VALUES (752, 1857, '鹰潭市', 117.039532, 28.272092, '', '');
INSERT INTO `region_food_relation` VALUES (753, 1861, '上饶市', 117.943064, 28.45513, '', '');
INSERT INTO `region_food_relation` VALUES (754, 1874, '宜春市', 114.416826, 27.816245, '', '');
INSERT INTO `region_food_relation` VALUES (755, 1885, '抚州市', 116.358054, 27.948979, '', '');
INSERT INTO `region_food_relation` VALUES (756, 1898, '吉安市', 114.96681, 27.091243, '', '');
INSERT INTO `region_food_relation` VALUES (757, 1911, '赣州市', 114.933494, 25.831139, '', '');
INSERT INTO `region_food_relation` VALUES (758, 1930, '成都市', 104.066301, 30.572961, '', '');
INSERT INTO `region_food_relation` VALUES (759, 1946, '自贡市', 104.779307, 29.33924, '', '');
INSERT INTO `region_food_relation` VALUES (760, 1950, '攀枝花市', 101.729116, 26.558645, '', '');
INSERT INTO `region_food_relation` VALUES (761, 1954, '泸州市', 105.441866, 28.87098, '', '');
INSERT INTO `region_food_relation` VALUES (762, 1960, '绵阳市', 104.679127, 31.467673, '', '');
INSERT INTO `region_food_relation` VALUES (763, 1962, '德阳市', 104.397795, 31.127449, '', '');
INSERT INTO `region_food_relation` VALUES (764, 1977, '广元市', 105.844004, 32.435774, '', '');
INSERT INTO `region_food_relation` VALUES (765, 1983, '遂宁市', 105.592602, 30.53268, '', '');
INSERT INTO `region_food_relation` VALUES (766, 1988, '内江市', 105.057992, 29.58021, '', '');
INSERT INTO `region_food_relation` VALUES (767, 1993, '乐山市', 103.766085, 29.552275, '', '');
INSERT INTO `region_food_relation` VALUES (768, 2005, '宜宾市', 104.642826, 28.752354, '', '');
INSERT INTO `region_food_relation` VALUES (769, 2016, '广安市', 106.632647, 30.456354, '', '');
INSERT INTO `region_food_relation` VALUES (770, 2022, '南充市', 106.110565, 30.837235, '', '');
INSERT INTO `region_food_relation` VALUES (771, 2033, '达州市', 107.46778, 31.209278, '', '');
INSERT INTO `region_food_relation` VALUES (772, 2042, '巴中市', 106.747548, 31.867853, '', '');
INSERT INTO `region_food_relation` VALUES (773, 2047, '雅安市', 103.041538, 30.009998, '', '');
INSERT INTO `region_food_relation` VALUES (774, 2058, '眉山市', 103.484557, 29.601189, '', '');
INSERT INTO `region_food_relation` VALUES (775, 2065, '资阳市', 104.627265, 30.129236, '', '');
INSERT INTO `region_food_relation` VALUES (776, 2070, '阿坝藏族羌族自治州', 102.224504, 31.899427, '', '');
INSERT INTO `region_food_relation` VALUES (777, 2084, '甘孜藏族自治州', 101.96231, 30.04952, '', '');
INSERT INTO `region_food_relation` VALUES (778, 2103, '凉山彝族自治州', 102.267713, 27.881396, '', '');
INSERT INTO `region_food_relation` VALUES (779, 2121, '海口市', 110.200162, 20.046316, '', '');
INSERT INTO `region_food_relation` VALUES (780, 2144, '贵阳市', 106.628201, 26.646694, '', '');
INSERT INTO `region_food_relation` VALUES (781, 2150, '六盘水市', 104.830357, 26.592538, '', '');
INSERT INTO `region_food_relation` VALUES (782, 2155, '遵义市', 107.031922, 27.721931, '', '');
INSERT INTO `region_food_relation` VALUES (783, 2169, '铜仁市', 109.189528, 27.731555, '', '');
INSERT INTO `region_food_relation` VALUES (784, 2180, '毕节市', 105.291544, 27.283615, '', '');
INSERT INTO `region_food_relation` VALUES (785, 2189, '安顺市', 105.9476, 26.253103, '', '');
INSERT INTO `region_food_relation` VALUES (786, 2196, '黔西南布依族苗族自治州', 104.906419, 25.087733, '', '');
INSERT INTO `region_food_relation` VALUES (787, 2205, '黔东南苗族侗族自治州', 107.982838, 26.583759, '', '');
INSERT INTO `region_food_relation` VALUES (788, 2222, '黔南布依族苗族自治州', 107.522303, 26.253136, '', '');
INSERT INTO `region_food_relation` VALUES (789, 2235, '昆明市', 102.833669, 24.88149, '', '');
INSERT INTO `region_food_relation` VALUES (790, 2247, '曲靖市', 103.796288, 25.490866, '', '');
INSERT INTO `region_food_relation` VALUES (791, 2258, '玉溪市', 102.526673, 24.346786, '', '');
INSERT INTO `region_food_relation` VALUES (792, 2270, '昭通市', 103.717078, 27.338185, '', '');
INSERT INTO `region_food_relation` VALUES (793, 2281, '普洱市', 100.966011, 22.825229, '', '');
INSERT INTO `region_food_relation` VALUES (794, 2291, '临沧市', 100.088837, 23.884175, '', '');
INSERT INTO `region_food_relation` VALUES (795, 2298, '保山市', 99.161489, 25.112018, '', '');
INSERT INTO `region_food_relation` VALUES (796, 2304, '丽江市', 100.225936, 26.855165, '', '');
INSERT INTO `region_food_relation` VALUES (797, 2309, '文山壮族苗族自治州', 104.21567, 23.400983, '', '');
INSERT INTO `region_food_relation` VALUES (798, 2318, '红河哈尼族彝族自治州', 103.374873, 23.363129, '', '');
INSERT INTO `region_food_relation` VALUES (799, 2332, '西双版纳傣族自治州', 100.797002, 22.009037, '', '');
INSERT INTO `region_food_relation` VALUES (800, 2336, '楚雄彝族自治州', 101.528304, 25.045678, '', '');
INSERT INTO `region_food_relation` VALUES (801, 2347, '大理白族自治州', 100.267608, 25.606548, '', '');
INSERT INTO `region_food_relation` VALUES (802, 2360, '德宏傣族景颇族自治州', 98.585621, 24.433146, '', '');
INSERT INTO `region_food_relation` VALUES (803, 2366, '怒江傈僳族自治州', 98.8566, 25.817555, '', '');
INSERT INTO `region_food_relation` VALUES (804, 2376, '西安市', 108.939645, 34.343207, '', '');
INSERT INTO `region_food_relation` VALUES (805, 2386, '铜川市', 108.945116, 34.897133, '', '');
INSERT INTO `region_food_relation` VALUES (806, 2390, '宝鸡市', 107.237682, 34.362862, '', '');
INSERT INTO `region_food_relation` VALUES (807, 2402, '咸阳市', 108.708837, 34.329896, '', '');
INSERT INTO `region_food_relation` VALUES (808, 2416, '渭南市', 109.470962, 34.520632, '', '');
INSERT INTO `region_food_relation` VALUES (809, 2428, '延安市', 109.49468, 36.650109, '', '');
INSERT INTO `region_food_relation` VALUES (810, 2442, '汉中市', 107.02319, 33.066373, '', '');
INSERT INTO `region_food_relation` VALUES (811, 2454, '榆林市', 109.734104, 38.28576, '', '');
INSERT INTO `region_food_relation` VALUES (812, 2468, '商洛市', 109.918646, 33.873358, '', '');
INSERT INTO `region_food_relation` VALUES (813, 2476, '安康市', 109.029017, 32.685435, '', '');
INSERT INTO `region_food_relation` VALUES (814, 2487, '兰州市', 103.834228, 36.060798, '', '');
INSERT INTO `region_food_relation` VALUES (815, 2492, '金昌市', 102.187972, 38.521468, '', '');
INSERT INTO `region_food_relation` VALUES (816, 2495, '白银市', 104.138872, 36.545123, '', '');
INSERT INTO `region_food_relation` VALUES (817, 2501, '天水市', 105.724828, 34.581514, '', '');
INSERT INTO `region_food_relation` VALUES (818, 2509, '嘉峪关市', 98.2882, 39.77325, '', '');
INSERT INTO `region_food_relation` VALUES (819, 2518, '平凉市', 106.664913, 35.542417, '', '');
INSERT INTO `region_food_relation` VALUES (820, 2525, '庆阳市', 107.643433, 35.709459, '', '');
INSERT INTO `region_food_relation` VALUES (821, 2534, '陇南市', 104.960296, 33.370174, '', '');
INSERT INTO `region_food_relation` VALUES (822, 2544, '武威市', 102.637821, 37.92898, '', '');
INSERT INTO `region_food_relation` VALUES (823, 2549, '张掖市', 100.449858, 38.924766, '', '');
INSERT INTO `region_food_relation` VALUES (824, 2556, '酒泉市', 98.49432, 39.733416, '', '');
INSERT INTO `region_food_relation` VALUES (825, 2564, '甘南藏族自治州', 102.911736, 34.983266, '', '');
INSERT INTO `region_food_relation` VALUES (826, 2573, '临夏回族自治州', 103.210386, 35.601792, '', '');
INSERT INTO `region_food_relation` VALUES (827, 2580, '西宁市', 101.777795, 36.616621, '', '');
INSERT INTO `region_food_relation` VALUES (828, 2585, '海东市', 102.41064, 36.473448, '', '');
INSERT INTO `region_food_relation` VALUES (829, 2592, '海北藏族自治州', 100.900944, 36.954612, '', '');
INSERT INTO `region_food_relation` VALUES (830, 2597, '黄南藏族自治州', 102.015397, 35.519317, '', '');
INSERT INTO `region_food_relation` VALUES (831, 2603, '海南藏族自治州', 100.622647, 36.296399, '', '');
INSERT INTO `region_food_relation` VALUES (832, 2605, '果洛藏族自治州', 100.245161, 34.472179, '', '');
INSERT INTO `region_food_relation` VALUES (833, 2612, '玉树藏族自治州', 97.006292, 33.006308, '', '');
INSERT INTO `region_food_relation` VALUES (834, 2620, '海西州', 98.89627, 36.545995, '', '');
INSERT INTO `region_food_relation` VALUES (835, 2628, '银川市', 106.230977, 38.487783, '', '');
INSERT INTO `region_food_relation` VALUES (836, 2632, '石嘴山市', 106.382792, 38.984632, '', '');
INSERT INTO `region_food_relation` VALUES (837, 2637, '吴忠市', 106.198613, 37.997755, '', '');
INSERT INTO `region_food_relation` VALUES (838, 2644, '固原市', 106.24267, 36.01628, '', '');
INSERT INTO `region_food_relation` VALUES (839, 2652, '乌鲁木齐市', 87.616824, 43.825377, '', '');
INSERT INTO `region_food_relation` VALUES (840, 2654, '克拉玛依市', 84.889239, 45.577712, '', '');
INSERT INTO `region_food_relation` VALUES (841, 2656, '石河子市', 86.080397, 44.305368, '', '');
INSERT INTO `region_food_relation` VALUES (842, 2658, '吐鲁番市', 89.250261, 42.972736, '', '');
INSERT INTO `region_food_relation` VALUES (843, 2662, '哈密市', 93.515053, 42.819346, '', '');
INSERT INTO `region_food_relation` VALUES (844, 2666, '和田地区', 79.921646, 37.114406, '', '');
INSERT INTO `region_food_relation` VALUES (845, 2675, '阿克苏地区', 80.265068, 41.170712, '', '');
INSERT INTO `region_food_relation` VALUES (846, 2686, '喀什地区', 75.990618, 39.470215, '', '');
INSERT INTO `region_food_relation` VALUES (847, 2699, '克孜勒苏柯尔克孜自治州', 76.168157, 39.716236, '', '');
INSERT INTO `region_food_relation` VALUES (848, 2704, '巴音郭楞蒙古自治州', 86.145298, 41.764115, '', '');
INSERT INTO `region_food_relation` VALUES (849, 2714, '昌吉回族自治州', 87.308995, 44.011044, '', '');
INSERT INTO `region_food_relation` VALUES (850, 2723, '博尔塔拉蒙古自治州', 82.066363, 44.906039, '', '');
INSERT INTO `region_food_relation` VALUES (851, 2727, '伊犁州', 81.268664, 43.859033, '', '');
INSERT INTO `region_food_relation` VALUES (852, 2736, '塔城地区', 82.980316, 46.745364, '', '');
INSERT INTO `region_food_relation` VALUES (853, 2744, '阿勒泰地区', 88.141253, 47.844924, '', '');
INSERT INTO `region_food_relation` VALUES (854, 2780, '济源市', 112.602347, 35.069057, '', '');
INSERT INTO `region_food_relation` VALUES (855, 2800, '海淀区', 116.2977, 39.959893, '', '');
INSERT INTO `region_food_relation` VALUES (856, 2801, '西城区', 116.36585, 39.9126, '', '');
INSERT INTO `region_food_relation` VALUES (857, 2802, '东城区', 116.416334, 39.928359, '', '');
INSERT INTO `region_food_relation` VALUES (858, 2805, '丰台区', 116.286726, 39.858538, '', '');
INSERT INTO `region_food_relation` VALUES (859, 2806, '石景山区', 116.223015, 39.906304, '', '');
INSERT INTO `region_food_relation` VALUES (860, 2807, '门头沟', 116.101668, 39.940842, '', '');
INSERT INTO `region_food_relation` VALUES (861, 2808, '房山区', 116.143426, 39.748889, '', '');
INSERT INTO `region_food_relation` VALUES (862, 2809, '通州区', 116.72923, 39.916403, '', '');
INSERT INTO `region_food_relation` VALUES (863, 2810, '大兴区', 116.341483, 39.726917, '', '');
INSERT INTO `region_food_relation` VALUES (864, 2812, '顺义区', 116.661474, 40.149891, '', '');
INSERT INTO `region_food_relation` VALUES (865, 2813, '徐汇区', 121.436307, 31.188334, '', '');
INSERT INTO `region_food_relation` VALUES (866, 2814, '怀柔区', 116.631974, 40.317003, '', '');
INSERT INTO `region_food_relation` VALUES (867, 2815, '长宁区', 121.424751, 31.220537, '', '');
INSERT INTO `region_food_relation` VALUES (868, 2816, '密云区', 116.843351, 40.377058, '', '');
INSERT INTO `region_food_relation` VALUES (869, 2817, '静安区', 121.447348, 31.227718, '', '');
INSERT INTO `region_food_relation` VALUES (870, 2822, '虹口区', 121.504994, 31.264917, '', '');
INSERT INTO `region_food_relation` VALUES (871, 2823, '杨浦区', 121.525409, 31.259588, '', '');
INSERT INTO `region_food_relation` VALUES (872, 2824, '宝山区', 119.288475, 42.039602, '', '');
INSERT INTO `region_food_relation` VALUES (873, 2825, '闵行区', 121.380857, 31.112834, '', '');
INSERT INTO `region_food_relation` VALUES (874, 2826, '嘉定区', 121.265276, 31.375566, '', '');
INSERT INTO `region_food_relation` VALUES (875, 2830, '浦东新区', 121.544346, 31.221461, '', '');
INSERT INTO `region_food_relation` VALUES (876, 2833, '青浦区', 121.124249, 31.15098, '', '');
INSERT INTO `region_food_relation` VALUES (877, 2834, '松江区', 121.227676, 31.03257, '', '');
INSERT INTO `region_food_relation` VALUES (878, 2835, '金山区', 121.341774, 30.742769, '', '');
INSERT INTO `region_food_relation` VALUES (879, 2837, '奉贤区', 121.473945, 30.918406, '', '');
INSERT INTO `region_food_relation` VALUES (880, 2841, '普陀区', 121.39547, 31.249618, '', '');
INSERT INTO `region_food_relation` VALUES (881, 2900, '济宁市', 116.587116, 35.415117, '', '');
INSERT INTO `region_food_relation` VALUES (882, 2901, '昌平区', 116.231034, 40.220952, '', '');
INSERT INTO `region_food_relation` VALUES (883, 2919, '崇明区', 121.397662, 31.623863, '', '');
INSERT INTO `region_food_relation` VALUES (884, 2922, '潜江市', 112.900279, 30.401954, '', '');
INSERT INTO `region_food_relation` VALUES (885, 2951, '拉萨市', 91.171924, 29.653491, '', '');
INSERT INTO `region_food_relation` VALUES (886, 2953, '平谷区', 117.121589, 40.140805, '', '');
INSERT INTO `region_food_relation` VALUES (887, 2971, '宣城市', 118.759127, 30.939278, '', '');
INSERT INTO `region_food_relation` VALUES (888, 2980, '天门市', 113.166545, 30.663706, '', '');
INSERT INTO `region_food_relation` VALUES (889, 2983, '仙桃市', 113.442973, 30.328407, '', '');
INSERT INTO `region_food_relation` VALUES (890, 2992, '辽源市', 125.144676, 42.887961, '', '');
INSERT INTO `region_food_relation` VALUES (891, 3034, '儋州市', 109.580812, 19.520948, '', '');
INSERT INTO `region_food_relation` VALUES (892, 3044, '来宾市', 109.221243, 23.750105, '', '');
INSERT INTO `region_food_relation` VALUES (893, 3065, '延庆区', 115.974609, 40.457033, '', '');
INSERT INTO `region_food_relation` VALUES (894, 3071, '中卫市', 105.19677, 37.500185, '', '');
INSERT INTO `region_food_relation` VALUES (895, 3074, '长治市', 113.117394, 36.195142, '', '');
INSERT INTO `region_food_relation` VALUES (896, 3080, '定西市', 104.592342, 35.607947, '', '');
INSERT INTO `region_food_relation` VALUES (897, 3107, '那曲市', 92.05151, 31.477905, '', '');
INSERT INTO `region_food_relation` VALUES (898, 3115, '琼海市', 110.474524, 19.259112, '', '');
INSERT INTO `region_food_relation` VALUES (899, 3129, '山南市', 91.771426, 29.237722, '', '');
INSERT INTO `region_food_relation` VALUES (900, 3137, '万宁市', 110.392605, 18.793697, '', '');
INSERT INTO `region_food_relation` VALUES (901, 3138, '昌都市', 97.170425, 31.142879, '', '');
INSERT INTO `region_food_relation` VALUES (902, 3144, '日喀则市', 88.880423, 29.266838, '', '');
INSERT INTO `region_food_relation` VALUES (903, 3154, '神农架林区', 110.675879, 31.745103, '', '');
INSERT INTO `region_food_relation` VALUES (904, 3168, '崇左市', 107.364973, 22.377139, '', '');
INSERT INTO `region_food_relation` VALUES (905, 3173, '东方市', 108.651829, 19.095187, '', '');
INSERT INTO `region_food_relation` VALUES (906, 3690, '三亚市', 109.511709, 18.252865, '', '');
INSERT INTO `region_food_relation` VALUES (907, 3698, '文昌市', 110.797473, 19.544234, '', '');
INSERT INTO `region_food_relation` VALUES (908, 3699, '五指山市', 109.516784, 18.774827, '', '');
INSERT INTO `region_food_relation` VALUES (909, 3701, '临高县', 109.690508, 19.912025, '', '');
INSERT INTO `region_food_relation` VALUES (910, 3702, '澄迈县', 110.007497, 19.738885, '', '');
INSERT INTO `region_food_relation` VALUES (911, 3703, '定安县', 110.358001, 19.681215, '', '');
INSERT INTO `region_food_relation` VALUES (912, 3704, '屯昌县', 110.101667, 19.351662, '', '');
INSERT INTO `region_food_relation` VALUES (913, 3705, '昌江黎族自治县', 109.055783, 19.298139, '', '');
INSERT INTO `region_food_relation` VALUES (914, 3706, '白沙黎族自治县', 109.4429, 19.221641, '', '');
INSERT INTO `region_food_relation` VALUES (915, 3707, '琼中黎族苗族自治县', 109.838423, 19.03327, '', '');
INSERT INTO `region_food_relation` VALUES (916, 3708, '陵水黎族自治县', 110.037553, 18.506045, '', '');
INSERT INTO `region_food_relation` VALUES (917, 3709, '保亭黎族苗族自治县', 109.700279, 18.640339, '', '');
INSERT INTO `region_food_relation` VALUES (918, 3710, '乐东黎族自治县', 109.173384, 18.750063, '', '');
INSERT INTO `region_food_relation` VALUES (919, 3711, '三沙市', 112.338649, 16.831004, '', '');
INSERT INTO `region_food_relation` VALUES (920, 3970, '阿里地区', 80.105786, 32.500987, '', '');
INSERT INTO `region_food_relation` VALUES (921, 3971, '林芝市', 94.361436, 29.64875, '', '');
INSERT INTO `region_food_relation` VALUES (922, 4108, '迪庆藏族自治州', 99.70211, 27.819149, '', '');
INSERT INTO `region_food_relation` VALUES (923, 4110, '五家渠市', 87.542852, 44.166489, '', '');
INSERT INTO `region_food_relation` VALUES (924, 4164, '城口县', 108.664349, 31.947319, '', '');
INSERT INTO `region_food_relation` VALUES (925, 6858, '铁岭市', 123.726008, 42.223709, '', '');
INSERT INTO `region_food_relation` VALUES (926, 15945, '阿拉尔市', 81.280532, 40.547205, '', '');
INSERT INTO `region_food_relation` VALUES (927, 15946, '图木舒克市', 79.074965, 39.867776, '', '');
INSERT INTO `region_food_relation` VALUES (928, 48131, '璧山区', 106.204885, 29.577455, '', '');
INSERT INTO `region_food_relation` VALUES (929, 48132, '荣昌区', 105.6118, 29.416892, '', '');
INSERT INTO `region_food_relation` VALUES (930, 48133, '铜梁区', 106.056265, 29.845248, '', '');
INSERT INTO `region_food_relation` VALUES (931, 48201, '合川区', 106.27617, 29.971968, '', '');
INSERT INTO `region_food_relation` VALUES (932, 48202, '巴南区', 106.540603, 29.402348, '', '');
INSERT INTO `region_food_relation` VALUES (933, 48203, '北碚区', 106.395593, 29.805197, '', '');
INSERT INTO `region_food_relation` VALUES (934, 48204, '江津区', 106.264435, 29.319984, '', '');
INSERT INTO `region_food_relation` VALUES (935, 48205, '渝北区', 106.631155, 29.718087, '', '');
INSERT INTO `region_food_relation` VALUES (936, 48206, '长寿区', 107.080945, 29.857916, '', '');
INSERT INTO `region_food_relation` VALUES (937, 48207, '永川区', 105.926951, 29.356384, '', '');
INSERT INTO `region_food_relation` VALUES (938, 50950, '江北区', 121.555067, 29.88673, '', '');
INSERT INTO `region_food_relation` VALUES (939, 50951, '南岸区', 106.644254, 29.50109, '', '');
INSERT INTO `region_food_relation` VALUES (940, 50952, '九龙坡区', 106.510515, 29.502325, '', '');
INSERT INTO `region_food_relation` VALUES (941, 50953, '沙坪坝区', 106.456939, 29.541017, '', '');
INSERT INTO `region_food_relation` VALUES (942, 50954, '大渡口区', 106.482299, 29.484464, '', '');
INSERT INTO `region_food_relation` VALUES (943, 50995, '綦江区', 106.651213, 29.028117, '', '');
INSERT INTO `region_food_relation` VALUES (944, 51026, '渝中区', 106.568955, 29.552642, '', '');
INSERT INTO `region_food_relation` VALUES (945, 51035, '东丽区', 117.313567, 39.086789, '', '');
INSERT INTO `region_food_relation` VALUES (946, 51036, '和平区', 117.214713, 39.116884, '', '');
INSERT INTO `region_food_relation` VALUES (947, 51037, '河北区', 117.196874, 39.148018, '', '');
INSERT INTO `region_food_relation` VALUES (948, 51038, '河东区', 117.251584, 39.128294, '', '');
INSERT INTO `region_food_relation` VALUES (949, 51039, '河西区', 117.223379, 39.109679, '', '');
INSERT INTO `region_food_relation` VALUES (950, 51040, '红桥区', 117.151566, 39.167349, '', '');
INSERT INTO `region_food_relation` VALUES (951, 51041, '蓟州区', 117.408432, 40.046544, '', '');
INSERT INTO `region_food_relation` VALUES (952, 51042, '静海区', 116.975474, 38.947772, '', '');
INSERT INTO `region_food_relation` VALUES (953, 51043, '南开区', 117.150638, 39.138551, '', '');
INSERT INTO `region_food_relation` VALUES (954, 51044, '滨海新区', 117.69641, 39.017809, '', '');
INSERT INTO `region_food_relation` VALUES (955, 51045, '西青区', 117.008994, 39.141811, '', '');
INSERT INTO `region_food_relation` VALUES (956, 51046, '武清区', 117.04456, 39.384108, '', '');
INSERT INTO `region_food_relation` VALUES (957, 51047, '津南区', 117.356683, 38.936971, '', '');
INSERT INTO `region_food_relation` VALUES (958, 51050, '北辰区', 117.135614, 39.224638, '', '');
INSERT INTO `region_food_relation` VALUES (959, 51051, '宝坻区', 117.309748, 39.717054, '', '');
INSERT INTO `region_food_relation` VALUES (960, 51052, '宁河区', 117.826674, 39.329749, '', '');
INSERT INTO `region_food_relation` VALUES (961, 52994, '香港特别行政区', 114.170714, 22.278354, '', '');
INSERT INTO `region_food_relation` VALUES (962, 52995, '澳门特别行政区', 113.543076, 22.186927, '', '');
INSERT INTO `region_food_relation` VALUES (963, 53090, '铁门关市', 85.670291, 41.862997, '', '');
INSERT INTO `region_food_relation` VALUES (964, 53668, '昆玉市', 79.270193, 37.215372, '', '');
INSERT INTO `region_food_relation` VALUES (965, 129142, '北屯市', 87.834419, 47.326733, '', '');
INSERT INTO `region_food_relation` VALUES (966, 145492, '可克达拉市', 80.994153, 43.940381, '', '');
INSERT INTO `region_food_relation` VALUES (967, 146206, '胡杨河市', 84.827592, 44.692894, '', '');

-- ----------------------------
-- Table structure for regions
-- ----------------------------
DROP TABLE IF EXISTS `regions`;
CREATE TABLE `regions`  (
  `id` int NOT NULL AUTO_INCREMENT COMMENT '地区ID',
  `name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '地区名称（市级或区县）',
  `province_id` int NOT NULL COMMENT '所属省份ID',
  `city_level` tinyint NOT NULL COMMENT '城市级别（1:省级直辖市，2:地级市，3:区县）',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 146207 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci COMMENT = '地区表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of regions
-- ----------------------------
INSERT INTO `regions` VALUES (1, '北京市', 0, 1);
INSERT INTO `regions` VALUES (2, '上海市', 0, 1);
INSERT INTO `regions` VALUES (3, '天津市', 0, 1);
INSERT INTO `regions` VALUES (4, '重庆市', 0, 1);
INSERT INTO `regions` VALUES (5, '河北省', 0, 1);
INSERT INTO `regions` VALUES (6, '山西省', 0, 1);
INSERT INTO `regions` VALUES (7, '河南省', 0, 1);
INSERT INTO `regions` VALUES (8, '辽宁省', 0, 1);
INSERT INTO `regions` VALUES (9, '吉林省', 0, 1);
INSERT INTO `regions` VALUES (10, '黑龙江省', 0, 1);
INSERT INTO `regions` VALUES (11, '内蒙古自治区', 0, 1);
INSERT INTO `regions` VALUES (12, '江苏省', 0, 1);
INSERT INTO `regions` VALUES (13, '山东省', 0, 1);
INSERT INTO `regions` VALUES (14, '安徽省', 0, 1);
INSERT INTO `regions` VALUES (15, '浙江省', 0, 1);
INSERT INTO `regions` VALUES (16, '福建省', 0, 1);
INSERT INTO `regions` VALUES (17, '湖北省', 0, 1);
INSERT INTO `regions` VALUES (18, '湖南省', 0, 1);
INSERT INTO `regions` VALUES (19, '广东省', 0, 1);
INSERT INTO `regions` VALUES (20, '广西壮族自治区', 0, 1);
INSERT INTO `regions` VALUES (21, '江西省', 0, 1);
INSERT INTO `regions` VALUES (22, '四川省', 0, 1);
INSERT INTO `regions` VALUES (23, '海南省', 0, 1);
INSERT INTO `regions` VALUES (24, '贵州省', 0, 1);
INSERT INTO `regions` VALUES (25, '云南省', 0, 1);
INSERT INTO `regions` VALUES (26, '西藏自治区', 0, 1);
INSERT INTO `regions` VALUES (27, '陕西省', 0, 1);
INSERT INTO `regions` VALUES (28, '甘肃省', 0, 1);
INSERT INTO `regions` VALUES (29, '青海省', 0, 1);
INSERT INTO `regions` VALUES (30, '宁夏回族自治区', 0, 1);
INSERT INTO `regions` VALUES (31, '新疆维吾尔自治区', 0, 1);
INSERT INTO `regions` VALUES (32, '台湾省', 0, 1);
INSERT INTO `regions` VALUES (72, '朝阳区', 1, 2);
INSERT INTO `regions` VALUES (78, '黄浦区', 2, 2);
INSERT INTO `regions` VALUES (113, '万州区', 4, 2);
INSERT INTO `regions` VALUES (114, '涪陵区', 4, 2);
INSERT INTO `regions` VALUES (115, '梁平区', 4, 2);
INSERT INTO `regions` VALUES (119, '南川区', 4, 2);
INSERT INTO `regions` VALUES (123, '潼南区', 4, 2);
INSERT INTO `regions` VALUES (126, '大足区', 4, 2);
INSERT INTO `regions` VALUES (128, '黔江区', 4, 2);
INSERT INTO `regions` VALUES (129, '武隆区', 4, 2);
INSERT INTO `regions` VALUES (130, '丰都县', 4, 2);
INSERT INTO `regions` VALUES (131, '奉节县', 4, 2);
INSERT INTO `regions` VALUES (132, '开州区', 4, 2);
INSERT INTO `regions` VALUES (133, '云阳县', 4, 2);
INSERT INTO `regions` VALUES (134, '忠县', 4, 2);
INSERT INTO `regions` VALUES (135, '巫溪县', 4, 2);
INSERT INTO `regions` VALUES (136, '巫山县', 4, 2);
INSERT INTO `regions` VALUES (137, '石柱土家族自治县', 4, 2);
INSERT INTO `regions` VALUES (138, '彭水苗族土家族自治县', 4, 2);
INSERT INTO `regions` VALUES (139, '垫江县', 4, 2);
INSERT INTO `regions` VALUES (140, '酉阳土家族苗族自治县', 4, 2);
INSERT INTO `regions` VALUES (141, '秀山土家族苗族自治县', 4, 2);
INSERT INTO `regions` VALUES (142, '石家庄市', 5, 2);
INSERT INTO `regions` VALUES (148, '邯郸市', 5, 2);
INSERT INTO `regions` VALUES (164, '邢台市', 5, 2);
INSERT INTO `regions` VALUES (199, '保定市', 5, 2);
INSERT INTO `regions` VALUES (224, '张家口市', 5, 2);
INSERT INTO `regions` VALUES (239, '承德市', 5, 2);
INSERT INTO `regions` VALUES (248, '秦皇岛市', 5, 2);
INSERT INTO `regions` VALUES (258, '唐山市', 5, 2);
INSERT INTO `regions` VALUES (264, '沧州市', 5, 2);
INSERT INTO `regions` VALUES (274, '廊坊市', 5, 2);
INSERT INTO `regions` VALUES (275, '衡水市', 5, 2);
INSERT INTO `regions` VALUES (303, '太原市', 6, 2);
INSERT INTO `regions` VALUES (309, '大同市', 6, 2);
INSERT INTO `regions` VALUES (318, '阳泉市', 6, 2);
INSERT INTO `regions` VALUES (325, '晋城市', 6, 2);
INSERT INTO `regions` VALUES (330, '朔州市', 6, 2);
INSERT INTO `regions` VALUES (336, '晋中市', 6, 2);
INSERT INTO `regions` VALUES (350, '忻州市', 6, 2);
INSERT INTO `regions` VALUES (368, '吕梁市', 6, 2);
INSERT INTO `regions` VALUES (379, '临汾市', 6, 2);
INSERT INTO `regions` VALUES (398, '运城市', 6, 2);
INSERT INTO `regions` VALUES (412, '郑州市', 7, 2);
INSERT INTO `regions` VALUES (420, '开封市', 7, 2);
INSERT INTO `regions` VALUES (427, '洛阳市', 7, 2);
INSERT INTO `regions` VALUES (438, '平顶山市', 7, 2);
INSERT INTO `regions` VALUES (446, '焦作市', 7, 2);
INSERT INTO `regions` VALUES (454, '鹤壁市', 7, 2);
INSERT INTO `regions` VALUES (458, '新乡市', 7, 2);
INSERT INTO `regions` VALUES (468, '安阳市', 7, 2);
INSERT INTO `regions` VALUES (475, '濮阳市', 7, 2);
INSERT INTO `regions` VALUES (482, '许昌市', 7, 2);
INSERT INTO `regions` VALUES (489, '漯河市', 7, 2);
INSERT INTO `regions` VALUES (495, '三门峡市', 7, 2);
INSERT INTO `regions` VALUES (502, '南阳市', 7, 2);
INSERT INTO `regions` VALUES (517, '商丘市', 7, 2);
INSERT INTO `regions` VALUES (527, '周口市', 7, 2);
INSERT INTO `regions` VALUES (538, '驻马店市', 7, 2);
INSERT INTO `regions` VALUES (549, '信阳市', 7, 2);
INSERT INTO `regions` VALUES (560, '沈阳市', 8, 2);
INSERT INTO `regions` VALUES (573, '大连市', 8, 2);
INSERT INTO `regions` VALUES (579, '鞍山市', 8, 2);
INSERT INTO `regions` VALUES (584, '抚顺市', 8, 2);
INSERT INTO `regions` VALUES (589, '本溪市', 8, 2);
INSERT INTO `regions` VALUES (593, '丹东市', 8, 2);
INSERT INTO `regions` VALUES (598, '锦州市', 8, 2);
INSERT INTO `regions` VALUES (604, '葫芦岛市', 8, 2);
INSERT INTO `regions` VALUES (609, '营口市', 8, 2);
INSERT INTO `regions` VALUES (613, '盘锦市', 8, 2);
INSERT INTO `regions` VALUES (617, '阜新市', 8, 2);
INSERT INTO `regions` VALUES (621, '辽阳市', 8, 2);
INSERT INTO `regions` VALUES (632, '朝阳市', 8, 2);
INSERT INTO `regions` VALUES (639, '长春市', 9, 2);
INSERT INTO `regions` VALUES (644, '吉林市', 9, 2);
INSERT INTO `regions` VALUES (651, '四平市', 9, 2);
INSERT INTO `regions` VALUES (657, '通化市', 9, 2);
INSERT INTO `regions` VALUES (664, '白山市', 9, 2);
INSERT INTO `regions` VALUES (674, '松原市', 9, 2);
INSERT INTO `regions` VALUES (681, '白城市', 9, 2);
INSERT INTO `regions` VALUES (687, '延边朝鲜族自治州', 9, 2);
INSERT INTO `regions` VALUES (698, '哈尔滨市', 10, 2);
INSERT INTO `regions` VALUES (712, '齐齐哈尔市', 10, 2);
INSERT INTO `regions` VALUES (727, '鹤岗市', 10, 2);
INSERT INTO `regions` VALUES (731, '双鸭山市', 10, 2);
INSERT INTO `regions` VALUES (737, '鸡西市', 10, 2);
INSERT INTO `regions` VALUES (742, '大庆市', 10, 2);
INSERT INTO `regions` VALUES (753, '伊春市', 10, 2);
INSERT INTO `regions` VALUES (757, '牡丹江市', 10, 2);
INSERT INTO `regions` VALUES (765, '佳木斯市', 10, 2);
INSERT INTO `regions` VALUES (773, '七台河市', 10, 2);
INSERT INTO `regions` VALUES (776, '黑河市', 10, 2);
INSERT INTO `regions` VALUES (782, '绥化市', 10, 2);
INSERT INTO `regions` VALUES (793, '大兴安岭地区', 10, 2);
INSERT INTO `regions` VALUES (799, '呼和浩特市', 11, 2);
INSERT INTO `regions` VALUES (805, '包头市', 11, 2);
INSERT INTO `regions` VALUES (810, '乌海市', 11, 2);
INSERT INTO `regions` VALUES (812, '赤峰市', 11, 2);
INSERT INTO `regions` VALUES (823, '乌兰察布市', 11, 2);
INSERT INTO `regions` VALUES (835, '锡林郭勒盟', 11, 2);
INSERT INTO `regions` VALUES (848, '呼伦贝尔市', 11, 2);
INSERT INTO `regions` VALUES (870, '鄂尔多斯市', 11, 2);
INSERT INTO `regions` VALUES (880, '巴彦淖尔市', 11, 2);
INSERT INTO `regions` VALUES (891, '阿拉善盟', 11, 2);
INSERT INTO `regions` VALUES (895, '兴安盟', 11, 2);
INSERT INTO `regions` VALUES (902, '通辽市', 11, 2);
INSERT INTO `regions` VALUES (904, '南京市', 12, 2);
INSERT INTO `regions` VALUES (911, '徐州市', 12, 2);
INSERT INTO `regions` VALUES (919, '连云港市', 12, 2);
INSERT INTO `regions` VALUES (925, '淮安市', 12, 2);
INSERT INTO `regions` VALUES (933, '宿迁市', 12, 2);
INSERT INTO `regions` VALUES (939, '盐城市', 12, 2);
INSERT INTO `regions` VALUES (951, '扬州市', 12, 2);
INSERT INTO `regions` VALUES (959, '泰州市', 12, 2);
INSERT INTO `regions` VALUES (965, '南通市', 12, 2);
INSERT INTO `regions` VALUES (972, '镇江市', 12, 2);
INSERT INTO `regions` VALUES (978, '常州市', 12, 2);
INSERT INTO `regions` VALUES (984, '无锡市', 12, 2);
INSERT INTO `regions` VALUES (988, '苏州市', 12, 2);
INSERT INTO `regions` VALUES (1000, '济南市', 13, 2);
INSERT INTO `regions` VALUES (1007, '青岛市', 13, 2);
INSERT INTO `regions` VALUES (1016, '淄博市', 13, 2);
INSERT INTO `regions` VALUES (1022, '枣庄市', 13, 2);
INSERT INTO `regions` VALUES (1025, '东营市', 13, 2);
INSERT INTO `regions` VALUES (1032, '潍坊市', 13, 2);
INSERT INTO `regions` VALUES (1042, '烟台市', 13, 2);
INSERT INTO `regions` VALUES (1053, '威海市', 13, 2);
INSERT INTO `regions` VALUES (1060, '德州市', 13, 2);
INSERT INTO `regions` VALUES (1072, '临沂市', 13, 2);
INSERT INTO `regions` VALUES (1081, '聊城市', 13, 2);
INSERT INTO `regions` VALUES (1090, '滨州市', 13, 2);
INSERT INTO `regions` VALUES (1099, '菏泽市', 13, 2);
INSERT INTO `regions` VALUES (1108, '日照市', 13, 2);
INSERT INTO `regions` VALUES (1112, '泰安市', 13, 2);
INSERT INTO `regions` VALUES (1114, '铜陵市', 14, 2);
INSERT INTO `regions` VALUES (1116, '合肥市', 14, 2);
INSERT INTO `regions` VALUES (1121, '淮南市', 14, 2);
INSERT INTO `regions` VALUES (1124, '淮北市', 14, 2);
INSERT INTO `regions` VALUES (1127, '芜湖市', 14, 2);
INSERT INTO `regions` VALUES (1132, '蚌埠市', 14, 2);
INSERT INTO `regions` VALUES (1137, '马鞍山市', 14, 2);
INSERT INTO `regions` VALUES (1140, '安庆市', 14, 2);
INSERT INTO `regions` VALUES (1151, '黄山市', 14, 2);
INSERT INTO `regions` VALUES (1158, '宁波市', 15, 2);
INSERT INTO `regions` VALUES (1159, '滁州市', 14, 2);
INSERT INTO `regions` VALUES (1167, '阜阳市', 14, 2);
INSERT INTO `regions` VALUES (1174, '亳州市', 14, 2);
INSERT INTO `regions` VALUES (1180, '宿州市', 14, 2);
INSERT INTO `regions` VALUES (1201, '池州市', 14, 2);
INSERT INTO `regions` VALUES (1206, '六安市', 14, 2);
INSERT INTO `regions` VALUES (1213, '杭州市', 15, 2);
INSERT INTO `regions` VALUES (1233, '温州市', 15, 2);
INSERT INTO `regions` VALUES (1243, '嘉兴市', 15, 2);
INSERT INTO `regions` VALUES (1250, '湖州市', 15, 2);
INSERT INTO `regions` VALUES (1255, '绍兴市', 15, 2);
INSERT INTO `regions` VALUES (1262, '金华市', 15, 2);
INSERT INTO `regions` VALUES (1273, '衢州市', 15, 2);
INSERT INTO `regions` VALUES (1280, '丽水市', 15, 2);
INSERT INTO `regions` VALUES (1290, '台州市', 15, 2);
INSERT INTO `regions` VALUES (1298, '舟山市', 15, 2);
INSERT INTO `regions` VALUES (1303, '福州市', 16, 2);
INSERT INTO `regions` VALUES (1315, '厦门市', 16, 2);
INSERT INTO `regions` VALUES (1317, '三明市', 16, 2);
INSERT INTO `regions` VALUES (1329, '莆田市', 16, 2);
INSERT INTO `regions` VALUES (1332, '泉州市', 16, 2);
INSERT INTO `regions` VALUES (1341, '漳州市', 16, 2);
INSERT INTO `regions` VALUES (1352, '南平市', 16, 2);
INSERT INTO `regions` VALUES (1362, '龙岩市', 16, 2);
INSERT INTO `regions` VALUES (1370, '宁德市', 16, 2);
INSERT INTO `regions` VALUES (1381, '武汉市', 17, 2);
INSERT INTO `regions` VALUES (1387, '黄石市', 17, 2);
INSERT INTO `regions` VALUES (1396, '襄阳市', 17, 2);
INSERT INTO `regions` VALUES (1405, '十堰市', 17, 2);
INSERT INTO `regions` VALUES (1413, '荆州市', 17, 2);
INSERT INTO `regions` VALUES (1421, '宜昌市', 17, 2);
INSERT INTO `regions` VALUES (1432, '孝感市', 17, 2);
INSERT INTO `regions` VALUES (1441, '黄冈市', 17, 2);
INSERT INTO `regions` VALUES (1458, '咸宁市', 17, 2);
INSERT INTO `regions` VALUES (1466, '恩施土家族苗族自治州', 17, 2);
INSERT INTO `regions` VALUES (1475, '鄂州市', 17, 2);
INSERT INTO `regions` VALUES (1477, '荆门市', 17, 2);
INSERT INTO `regions` VALUES (1479, '随州市', 17, 2);
INSERT INTO `regions` VALUES (1482, '长沙市', 18, 2);
INSERT INTO `regions` VALUES (1488, '株洲市', 18, 2);
INSERT INTO `regions` VALUES (1495, '湘潭市', 18, 2);
INSERT INTO `regions` VALUES (1501, '衡阳市', 18, 2);
INSERT INTO `regions` VALUES (1511, '邵阳市', 18, 2);
INSERT INTO `regions` VALUES (1522, '岳阳市', 18, 2);
INSERT INTO `regions` VALUES (1530, '常德市', 18, 2);
INSERT INTO `regions` VALUES (1540, '张家界市', 18, 2);
INSERT INTO `regions` VALUES (1544, '郴州市', 18, 2);
INSERT INTO `regions` VALUES (1555, '益阳市', 18, 2);
INSERT INTO `regions` VALUES (1560, '永州市', 18, 2);
INSERT INTO `regions` VALUES (1574, '怀化市', 18, 2);
INSERT INTO `regions` VALUES (1586, '娄底市', 18, 2);
INSERT INTO `regions` VALUES (1592, '湘西土家族苗族自治州', 18, 2);
INSERT INTO `regions` VALUES (1601, '广州市', 19, 2);
INSERT INTO `regions` VALUES (1607, '深圳市', 19, 2);
INSERT INTO `regions` VALUES (1609, '珠海市', 19, 2);
INSERT INTO `regions` VALUES (1611, '汕头市', 19, 2);
INSERT INTO `regions` VALUES (1617, '韶关市', 19, 2);
INSERT INTO `regions` VALUES (1627, '河源市', 19, 2);
INSERT INTO `regions` VALUES (1634, '梅州市', 19, 2);
INSERT INTO `regions` VALUES (1643, '惠州市', 19, 2);
INSERT INTO `regions` VALUES (1650, '汕尾市', 19, 2);
INSERT INTO `regions` VALUES (1655, '东莞市', 19, 2);
INSERT INTO `regions` VALUES (1657, '中山市', 19, 2);
INSERT INTO `regions` VALUES (1659, '江门市', 19, 2);
INSERT INTO `regions` VALUES (1666, '佛山市', 19, 2);
INSERT INTO `regions` VALUES (1672, '阳江市', 19, 2);
INSERT INTO `regions` VALUES (1677, '湛江市', 19, 2);
INSERT INTO `regions` VALUES (1684, '茂名市', 19, 2);
INSERT INTO `regions` VALUES (1690, '肇庆市', 19, 2);
INSERT INTO `regions` VALUES (1698, '云浮市', 19, 2);
INSERT INTO `regions` VALUES (1704, '清远市', 19, 2);
INSERT INTO `regions` VALUES (1705, '潮州市', 19, 2);
INSERT INTO `regions` VALUES (1709, '揭阳市', 19, 2);
INSERT INTO `regions` VALUES (1715, '南宁市', 20, 2);
INSERT INTO `regions` VALUES (1720, '柳州市', 20, 2);
INSERT INTO `regions` VALUES (1726, '桂林市', 20, 2);
INSERT INTO `regions` VALUES (1740, '梧州市', 20, 2);
INSERT INTO `regions` VALUES (1746, '北海市', 20, 2);
INSERT INTO `regions` VALUES (1749, '防城港市', 20, 2);
INSERT INTO `regions` VALUES (1753, '钦州市', 20, 2);
INSERT INTO `regions` VALUES (1757, '贵港市', 20, 2);
INSERT INTO `regions` VALUES (1761, '玉林市', 20, 2);
INSERT INTO `regions` VALUES (1792, '贺州市', 20, 2);
INSERT INTO `regions` VALUES (1806, '百色市', 20, 2);
INSERT INTO `regions` VALUES (1818, '河池市', 20, 2);
INSERT INTO `regions` VALUES (1827, '南昌市', 21, 2);
INSERT INTO `regions` VALUES (1832, '景德镇市', 21, 2);
INSERT INTO `regions` VALUES (1836, '萍乡市', 21, 2);
INSERT INTO `regions` VALUES (1842, '新余市', 21, 2);
INSERT INTO `regions` VALUES (1845, '九江市', 21, 2);
INSERT INTO `regions` VALUES (1857, '鹰潭市', 21, 2);
INSERT INTO `regions` VALUES (1861, '上饶市', 21, 2);
INSERT INTO `regions` VALUES (1874, '宜春市', 21, 2);
INSERT INTO `regions` VALUES (1885, '抚州市', 21, 2);
INSERT INTO `regions` VALUES (1898, '吉安市', 21, 2);
INSERT INTO `regions` VALUES (1911, '赣州市', 21, 2);
INSERT INTO `regions` VALUES (1930, '成都市', 22, 2);
INSERT INTO `regions` VALUES (1946, '自贡市', 22, 2);
INSERT INTO `regions` VALUES (1950, '攀枝花市', 22, 2);
INSERT INTO `regions` VALUES (1954, '泸州市', 22, 2);
INSERT INTO `regions` VALUES (1960, '绵阳市', 22, 2);
INSERT INTO `regions` VALUES (1962, '德阳市', 22, 2);
INSERT INTO `regions` VALUES (1977, '广元市', 22, 2);
INSERT INTO `regions` VALUES (1983, '遂宁市', 22, 2);
INSERT INTO `regions` VALUES (1988, '内江市', 22, 2);
INSERT INTO `regions` VALUES (1993, '乐山市', 22, 2);
INSERT INTO `regions` VALUES (2005, '宜宾市', 22, 2);
INSERT INTO `regions` VALUES (2016, '广安市', 22, 2);
INSERT INTO `regions` VALUES (2022, '南充市', 22, 2);
INSERT INTO `regions` VALUES (2033, '达州市', 22, 2);
INSERT INTO `regions` VALUES (2042, '巴中市', 22, 2);
INSERT INTO `regions` VALUES (2047, '雅安市', 22, 2);
INSERT INTO `regions` VALUES (2058, '眉山市', 22, 2);
INSERT INTO `regions` VALUES (2065, '资阳市', 22, 2);
INSERT INTO `regions` VALUES (2070, '阿坝藏族羌族自治州', 22, 2);
INSERT INTO `regions` VALUES (2084, '甘孜藏族自治州', 22, 2);
INSERT INTO `regions` VALUES (2103, '凉山彝族自治州', 22, 2);
INSERT INTO `regions` VALUES (2121, '海口市', 23, 2);
INSERT INTO `regions` VALUES (2144, '贵阳市', 24, 2);
INSERT INTO `regions` VALUES (2150, '六盘水市', 24, 2);
INSERT INTO `regions` VALUES (2155, '遵义市', 24, 2);
INSERT INTO `regions` VALUES (2169, '铜仁市', 24, 2);
INSERT INTO `regions` VALUES (2180, '毕节市', 24, 2);
INSERT INTO `regions` VALUES (2189, '安顺市', 24, 2);
INSERT INTO `regions` VALUES (2196, '黔西南布依族苗族自治州', 24, 2);
INSERT INTO `regions` VALUES (2205, '黔东南苗族侗族自治州', 24, 2);
INSERT INTO `regions` VALUES (2222, '黔南布依族苗族自治州', 24, 2);
INSERT INTO `regions` VALUES (2235, '昆明市', 25, 2);
INSERT INTO `regions` VALUES (2247, '曲靖市', 25, 2);
INSERT INTO `regions` VALUES (2258, '玉溪市', 25, 2);
INSERT INTO `regions` VALUES (2270, '昭通市', 25, 2);
INSERT INTO `regions` VALUES (2281, '普洱市', 25, 2);
INSERT INTO `regions` VALUES (2291, '临沧市', 25, 2);
INSERT INTO `regions` VALUES (2298, '保山市', 25, 2);
INSERT INTO `regions` VALUES (2304, '丽江市', 25, 2);
INSERT INTO `regions` VALUES (2309, '文山壮族苗族自治州', 25, 2);
INSERT INTO `regions` VALUES (2318, '红河哈尼族彝族自治州', 25, 2);
INSERT INTO `regions` VALUES (2332, '西双版纳傣族自治州', 25, 2);
INSERT INTO `regions` VALUES (2336, '楚雄彝族自治州', 25, 2);
INSERT INTO `regions` VALUES (2347, '大理白族自治州', 25, 2);
INSERT INTO `regions` VALUES (2360, '德宏傣族景颇族自治州', 25, 2);
INSERT INTO `regions` VALUES (2366, '怒江傈僳族自治州', 25, 2);
INSERT INTO `regions` VALUES (2376, '西安市', 27, 2);
INSERT INTO `regions` VALUES (2386, '铜川市', 27, 2);
INSERT INTO `regions` VALUES (2390, '宝鸡市', 27, 2);
INSERT INTO `regions` VALUES (2402, '咸阳市', 27, 2);
INSERT INTO `regions` VALUES (2416, '渭南市', 27, 2);
INSERT INTO `regions` VALUES (2428, '延安市', 27, 2);
INSERT INTO `regions` VALUES (2442, '汉中市', 27, 2);
INSERT INTO `regions` VALUES (2454, '榆林市', 27, 2);
INSERT INTO `regions` VALUES (2468, '商洛市', 27, 2);
INSERT INTO `regions` VALUES (2476, '安康市', 27, 2);
INSERT INTO `regions` VALUES (2487, '兰州市', 28, 2);
INSERT INTO `regions` VALUES (2492, '金昌市', 28, 2);
INSERT INTO `regions` VALUES (2495, '白银市', 28, 2);
INSERT INTO `regions` VALUES (2501, '天水市', 28, 2);
INSERT INTO `regions` VALUES (2509, '嘉峪关市', 28, 2);
INSERT INTO `regions` VALUES (2518, '平凉市', 28, 2);
INSERT INTO `regions` VALUES (2525, '庆阳市', 28, 2);
INSERT INTO `regions` VALUES (2534, '陇南市', 28, 2);
INSERT INTO `regions` VALUES (2544, '武威市', 28, 2);
INSERT INTO `regions` VALUES (2549, '张掖市', 28, 2);
INSERT INTO `regions` VALUES (2556, '酒泉市', 28, 2);
INSERT INTO `regions` VALUES (2564, '甘南藏族自治州', 28, 2);
INSERT INTO `regions` VALUES (2573, '临夏回族自治州', 28, 2);
INSERT INTO `regions` VALUES (2580, '西宁市', 29, 2);
INSERT INTO `regions` VALUES (2585, '海东市', 29, 2);
INSERT INTO `regions` VALUES (2592, '海北藏族自治州', 29, 2);
INSERT INTO `regions` VALUES (2597, '黄南藏族自治州', 29, 2);
INSERT INTO `regions` VALUES (2603, '海南藏族自治州', 29, 2);
INSERT INTO `regions` VALUES (2605, '果洛藏族自治州', 29, 2);
INSERT INTO `regions` VALUES (2612, '玉树藏族自治州', 29, 2);
INSERT INTO `regions` VALUES (2620, '海西州', 29, 2);
INSERT INTO `regions` VALUES (2628, '银川市', 30, 2);
INSERT INTO `regions` VALUES (2632, '石嘴山市', 30, 2);
INSERT INTO `regions` VALUES (2637, '吴忠市', 30, 2);
INSERT INTO `regions` VALUES (2644, '固原市', 30, 2);
INSERT INTO `regions` VALUES (2652, '乌鲁木齐市', 31, 2);
INSERT INTO `regions` VALUES (2654, '克拉玛依市', 31, 2);
INSERT INTO `regions` VALUES (2656, '石河子市', 31, 2);
INSERT INTO `regions` VALUES (2658, '吐鲁番市', 31, 2);
INSERT INTO `regions` VALUES (2662, '哈密市', 31, 2);
INSERT INTO `regions` VALUES (2666, '和田地区', 31, 2);
INSERT INTO `regions` VALUES (2675, '阿克苏地区', 31, 2);
INSERT INTO `regions` VALUES (2686, '喀什地区', 31, 2);
INSERT INTO `regions` VALUES (2699, '克孜勒苏柯尔克孜自治州', 31, 2);
INSERT INTO `regions` VALUES (2704, '巴音郭楞蒙古自治州', 31, 2);
INSERT INTO `regions` VALUES (2714, '昌吉回族自治州', 31, 2);
INSERT INTO `regions` VALUES (2723, '博尔塔拉蒙古自治州', 31, 2);
INSERT INTO `regions` VALUES (2727, '伊犁州', 31, 2);
INSERT INTO `regions` VALUES (2736, '塔城地区', 31, 2);
INSERT INTO `regions` VALUES (2744, '阿勒泰地区', 31, 2);
INSERT INTO `regions` VALUES (2780, '济源市', 7, 2);
INSERT INTO `regions` VALUES (2800, '海淀区', 1, 2);
INSERT INTO `regions` VALUES (2801, '西城区', 1, 2);
INSERT INTO `regions` VALUES (2802, '东城区', 1, 2);
INSERT INTO `regions` VALUES (2805, '丰台区', 1, 2);
INSERT INTO `regions` VALUES (2806, '石景山区', 1, 2);
INSERT INTO `regions` VALUES (2807, '门头沟', 1, 2);
INSERT INTO `regions` VALUES (2808, '房山区', 1, 2);
INSERT INTO `regions` VALUES (2809, '通州区', 1, 2);
INSERT INTO `regions` VALUES (2810, '大兴区', 1, 2);
INSERT INTO `regions` VALUES (2812, '顺义区', 1, 2);
INSERT INTO `regions` VALUES (2813, '徐汇区', 2, 2);
INSERT INTO `regions` VALUES (2814, '怀柔区', 1, 2);
INSERT INTO `regions` VALUES (2815, '长宁区', 2, 2);
INSERT INTO `regions` VALUES (2816, '密云区', 1, 2);
INSERT INTO `regions` VALUES (2817, '静安区', 2, 2);
INSERT INTO `regions` VALUES (2822, '虹口区', 2, 2);
INSERT INTO `regions` VALUES (2823, '杨浦区', 2, 2);
INSERT INTO `regions` VALUES (2824, '宝山区', 2, 2);
INSERT INTO `regions` VALUES (2825, '闵行区', 2, 2);
INSERT INTO `regions` VALUES (2826, '嘉定区', 2, 2);
INSERT INTO `regions` VALUES (2830, '浦东新区', 2, 2);
INSERT INTO `regions` VALUES (2833, '青浦区', 2, 2);
INSERT INTO `regions` VALUES (2834, '松江区', 2, 2);
INSERT INTO `regions` VALUES (2835, '金山区', 2, 2);
INSERT INTO `regions` VALUES (2837, '奉贤区', 2, 2);
INSERT INTO `regions` VALUES (2841, '普陀区', 2, 2);
INSERT INTO `regions` VALUES (2900, '济宁市', 13, 2);
INSERT INTO `regions` VALUES (2901, '昌平区', 1, 2);
INSERT INTO `regions` VALUES (2919, '崇明区', 2, 2);
INSERT INTO `regions` VALUES (2922, '潜江市', 17, 2);
INSERT INTO `regions` VALUES (2951, '拉萨市', 26, 2);
INSERT INTO `regions` VALUES (2953, '平谷区', 1, 2);
INSERT INTO `regions` VALUES (2971, '宣城市', 14, 2);
INSERT INTO `regions` VALUES (2980, '天门市', 17, 2);
INSERT INTO `regions` VALUES (2983, '仙桃市', 17, 2);
INSERT INTO `regions` VALUES (2992, '辽源市', 9, 2);
INSERT INTO `regions` VALUES (3034, '儋州市', 23, 2);
INSERT INTO `regions` VALUES (3044, '来宾市', 20, 2);
INSERT INTO `regions` VALUES (3065, '延庆区', 1, 2);
INSERT INTO `regions` VALUES (3071, '中卫市', 30, 2);
INSERT INTO `regions` VALUES (3074, '长治市', 6, 2);
INSERT INTO `regions` VALUES (3080, '定西市', 28, 2);
INSERT INTO `regions` VALUES (3107, '那曲市', 26, 2);
INSERT INTO `regions` VALUES (3115, '琼海市', 23, 2);
INSERT INTO `regions` VALUES (3129, '山南市', 26, 2);
INSERT INTO `regions` VALUES (3137, '万宁市', 23, 2);
INSERT INTO `regions` VALUES (3138, '昌都市', 26, 2);
INSERT INTO `regions` VALUES (3144, '日喀则市', 26, 2);
INSERT INTO `regions` VALUES (3154, '神农架林区', 17, 2);
INSERT INTO `regions` VALUES (3168, '崇左市', 20, 2);
INSERT INTO `regions` VALUES (3173, '东方市', 23, 2);
INSERT INTO `regions` VALUES (3690, '三亚市', 23, 2);
INSERT INTO `regions` VALUES (3698, '文昌市', 23, 2);
INSERT INTO `regions` VALUES (3699, '五指山市', 23, 2);
INSERT INTO `regions` VALUES (3701, '临高县', 23, 2);
INSERT INTO `regions` VALUES (3702, '澄迈县', 23, 2);
INSERT INTO `regions` VALUES (3703, '定安县', 23, 2);
INSERT INTO `regions` VALUES (3704, '屯昌县', 23, 2);
INSERT INTO `regions` VALUES (3705, '昌江黎族自治县', 23, 2);
INSERT INTO `regions` VALUES (3706, '白沙黎族自治县', 23, 2);
INSERT INTO `regions` VALUES (3707, '琼中黎族苗族自治县', 23, 2);
INSERT INTO `regions` VALUES (3708, '陵水黎族自治县', 23, 2);
INSERT INTO `regions` VALUES (3709, '保亭黎族苗族自治县', 23, 2);
INSERT INTO `regions` VALUES (3710, '乐东黎族自治县', 23, 2);
INSERT INTO `regions` VALUES (3711, '三沙市', 23, 2);
INSERT INTO `regions` VALUES (3970, '阿里地区', 26, 2);
INSERT INTO `regions` VALUES (3971, '林芝市', 26, 2);
INSERT INTO `regions` VALUES (4108, '迪庆藏族自治州', 25, 2);
INSERT INTO `regions` VALUES (4110, '五家渠市', 31, 2);
INSERT INTO `regions` VALUES (4164, '城口县', 4, 2);
INSERT INTO `regions` VALUES (6858, '铁岭市', 8, 2);
INSERT INTO `regions` VALUES (15945, '阿拉尔市', 31, 2);
INSERT INTO `regions` VALUES (15946, '图木舒克市', 31, 2);
INSERT INTO `regions` VALUES (48131, '璧山区', 4, 2);
INSERT INTO `regions` VALUES (48132, '荣昌区', 4, 2);
INSERT INTO `regions` VALUES (48133, '铜梁区', 4, 2);
INSERT INTO `regions` VALUES (48201, '合川区', 4, 2);
INSERT INTO `regions` VALUES (48202, '巴南区', 4, 2);
INSERT INTO `regions` VALUES (48203, '北碚区', 4, 2);
INSERT INTO `regions` VALUES (48204, '江津区', 4, 2);
INSERT INTO `regions` VALUES (48205, '渝北区', 4, 2);
INSERT INTO `regions` VALUES (48206, '长寿区', 4, 2);
INSERT INTO `regions` VALUES (48207, '永川区', 4, 2);
INSERT INTO `regions` VALUES (50950, '江北区', 4, 2);
INSERT INTO `regions` VALUES (50951, '南岸区', 4, 2);
INSERT INTO `regions` VALUES (50952, '九龙坡区', 4, 2);
INSERT INTO `regions` VALUES (50953, '沙坪坝区', 4, 2);
INSERT INTO `regions` VALUES (50954, '大渡口区', 4, 2);
INSERT INTO `regions` VALUES (50995, '綦江区', 4, 2);
INSERT INTO `regions` VALUES (51026, '渝中区', 4, 2);
INSERT INTO `regions` VALUES (51035, '东丽区', 3, 2);
INSERT INTO `regions` VALUES (51036, '和平区', 3, 2);
INSERT INTO `regions` VALUES (51037, '河北区', 3, 2);
INSERT INTO `regions` VALUES (51038, '河东区', 3, 2);
INSERT INTO `regions` VALUES (51039, '河西区', 3, 2);
INSERT INTO `regions` VALUES (51040, '红桥区', 3, 2);
INSERT INTO `regions` VALUES (51041, '蓟州区', 3, 2);
INSERT INTO `regions` VALUES (51042, '静海区', 3, 2);
INSERT INTO `regions` VALUES (51043, '南开区', 3, 2);
INSERT INTO `regions` VALUES (51044, '滨海新区', 3, 2);
INSERT INTO `regions` VALUES (51045, '西青区', 3, 2);
INSERT INTO `regions` VALUES (51046, '武清区', 3, 2);
INSERT INTO `regions` VALUES (51047, '津南区', 3, 2);
INSERT INTO `regions` VALUES (51050, '北辰区', 3, 2);
INSERT INTO `regions` VALUES (51051, '宝坻区', 3, 2);
INSERT INTO `regions` VALUES (51052, '宁河区', 3, 2);
INSERT INTO `regions` VALUES (52994, '香港特别行政区', 0, 1);
INSERT INTO `regions` VALUES (52995, '澳门特别行政区', 0, 1);
INSERT INTO `regions` VALUES (53090, '铁门关市', 31, 2);
INSERT INTO `regions` VALUES (53668, '昆玉市', 31, 2);
INSERT INTO `regions` VALUES (129142, '北屯市', 31, 2);
INSERT INTO `regions` VALUES (145492, '可克达拉市', 31, 2);
INSERT INTO `regions` VALUES (146206, '胡杨河市', 31, 2);

-- ----------------------------
-- Table structure for the_charts
-- ----------------------------
DROP TABLE IF EXISTS `the_charts`;
CREATE TABLE `the_charts`  (
  `id` int NOT NULL AUTO_INCREMENT COMMENT '表id',
  `food_id` int NOT NULL COMMENT '美食id',
  `user_collect_sum` bigint NOT NULL COMMENT '用户收藏数',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 25 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of the_charts
-- ----------------------------

-- ----------------------------
-- Table structure for user
-- ----------------------------
DROP TABLE IF EXISTS `user`;
CREATE TABLE `user`  (
  `id` int NOT NULL AUTO_INCREMENT COMMENT '用户ID',
  `username` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '用户名称',
  `password` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '用户密码（加密）',
  `email` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '邮箱',
  `phone_number` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '手机号',
  `description` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '用户简介',
  `constitution` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '体质（用于后续推荐食材->美食）',
  `role` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'user' COMMENT '用户角色',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 15 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of user
-- ----------------------------

-- ----------------------------
-- Table structure for user_collect_food
-- ----------------------------
DROP TABLE IF EXISTS `user_collect_food`;
CREATE TABLE `user_collect_food`  (
  `id` int NOT NULL AUTO_INCREMENT COMMENT '表id',
  `user_id` int NOT NULL COMMENT '用户id',
  `food_id` int NOT NULL COMMENT '美食id',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 51 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of user_collect_food
-- ----------------------------

SET FOREIGN_KEY_CHECKS = 1;
