/*
 Navicat Premium Data Transfer

 Source Server         : exam
 Source Server Type    : MySQL
 Source Server Version : 80011
 Source Host           : 127.0.0.1:3306
 Source Schema         : shiweite_20_blog_db

 Target Server Type    : MySQL
 Target Server Version : 80011
 File Encoding         : 65001

 Date: 16/10/2021 22:40:53
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for auth_group
-- ----------------------------
DROP TABLE IF EXISTS `auth_group`;
CREATE TABLE `auth_group`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(150) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `name`(`name`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for auth_group_permissions
-- ----------------------------
DROP TABLE IF EXISTS `auth_group_permissions`;
CREATE TABLE `auth_group_permissions`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `group_id` int(11) NOT NULL,
  `permission_id` int(11) NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `auth_group_permissions_group_id_permission_id_0cd325b0_uniq`(`group_id`, `permission_id`) USING BTREE,
  INDEX `auth_group_permissio_permission_id_84c5c92e_fk_auth_perm`(`permission_id`) USING BTREE,
  CONSTRAINT `auth_group_permissio_permission_id_84c5c92e_fk_auth_perm` FOREIGN KEY (`permission_id`) REFERENCES `auth_permission` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `auth_group_permissions_group_id_b120cbf9_fk_auth_group_id` FOREIGN KEY (`group_id`) REFERENCES `auth_group` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for auth_permission
-- ----------------------------
DROP TABLE IF EXISTS `auth_permission`;
CREATE TABLE `auth_permission`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `content_type_id` int(11) NOT NULL,
  `codename` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `auth_permission_content_type_id_codename_01ab375a_uniq`(`content_type_id`, `codename`) USING BTREE,
  CONSTRAINT `auth_permission_content_type_id_2f476e4b_fk_django_co` FOREIGN KEY (`content_type_id`) REFERENCES `django_content_type` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 44 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of auth_permission
-- ----------------------------
INSERT INTO `auth_permission` VALUES (1, 'Can add log entry', 1, 'add_logentry');
INSERT INTO `auth_permission` VALUES (2, 'Can change log entry', 1, 'change_logentry');
INSERT INTO `auth_permission` VALUES (3, 'Can delete log entry', 1, 'delete_logentry');
INSERT INTO `auth_permission` VALUES (4, 'Can view log entry', 1, 'view_logentry');
INSERT INTO `auth_permission` VALUES (5, 'Can add permission', 2, 'add_permission');
INSERT INTO `auth_permission` VALUES (6, 'Can change permission', 2, 'change_permission');
INSERT INTO `auth_permission` VALUES (7, 'Can delete permission', 2, 'delete_permission');
INSERT INTO `auth_permission` VALUES (8, 'Can view permission', 2, 'view_permission');
INSERT INTO `auth_permission` VALUES (9, 'Can add group', 3, 'add_group');
INSERT INTO `auth_permission` VALUES (10, 'Can change group', 3, 'change_group');
INSERT INTO `auth_permission` VALUES (11, 'Can delete group', 3, 'delete_group');
INSERT INTO `auth_permission` VALUES (12, 'Can view group', 3, 'view_group');
INSERT INTO `auth_permission` VALUES (13, 'Can add content type', 4, 'add_contenttype');
INSERT INTO `auth_permission` VALUES (14, 'Can change content type', 4, 'change_contenttype');
INSERT INTO `auth_permission` VALUES (15, 'Can delete content type', 4, 'delete_contenttype');
INSERT INTO `auth_permission` VALUES (16, 'Can view content type', 4, 'view_contenttype');
INSERT INTO `auth_permission` VALUES (17, 'Can add session', 5, 'add_session');
INSERT INTO `auth_permission` VALUES (18, 'Can change session', 5, 'change_session');
INSERT INTO `auth_permission` VALUES (19, 'Can delete session', 5, 'delete_session');
INSERT INTO `auth_permission` VALUES (20, 'Can view session', 5, 'view_session');
INSERT INTO `auth_permission` VALUES (21, 'Can add 用户管理', 6, 'add_user');
INSERT INTO `auth_permission` VALUES (22, 'Can change 用户管理', 6, 'change_user');
INSERT INTO `auth_permission` VALUES (23, 'Can delete 用户管理', 6, 'delete_user');
INSERT INTO `auth_permission` VALUES (24, 'Can view 用户管理', 6, 'view_user');
INSERT INTO `auth_permission` VALUES (25, 'Can add 类别管理', 7, 'add_articlecategory');
INSERT INTO `auth_permission` VALUES (26, 'Can change 类别管理', 7, 'change_articlecategory');
INSERT INTO `auth_permission` VALUES (27, 'Can delete 类别管理', 7, 'delete_articlecategory');
INSERT INTO `auth_permission` VALUES (28, 'Can view 类别管理', 7, 'view_articlecategory');
INSERT INTO `auth_permission` VALUES (29, 'Can add write blog view', 8, 'add_writeblogview');
INSERT INTO `auth_permission` VALUES (30, 'Can change write blog view', 8, 'change_writeblogview');
INSERT INTO `auth_permission` VALUES (31, 'Can delete write blog view', 8, 'delete_writeblogview');
INSERT INTO `auth_permission` VALUES (32, 'Can view write blog view', 8, 'view_writeblogview');
INSERT INTO `auth_permission` VALUES (33, 'Can add 文章管理', 9, 'add_article');
INSERT INTO `auth_permission` VALUES (34, 'Can change 文章管理', 9, 'change_article');
INSERT INTO `auth_permission` VALUES (35, 'Can delete 文章管理', 9, 'delete_article');
INSERT INTO `auth_permission` VALUES (36, 'Can view 文章管理', 9, 'view_article');
INSERT INTO `auth_permission` VALUES (37, 'Can add 评论管理', 10, 'add_comment');
INSERT INTO `auth_permission` VALUES (38, 'Can change 评论管理', 10, 'change_comment');
INSERT INTO `auth_permission` VALUES (39, 'Can delete 评论管理', 10, 'delete_comment');
INSERT INTO `auth_permission` VALUES (40, 'Can view 评论管理', 10, 'view_comment');
INSERT INTO `auth_permission` VALUES (41, 'Can add 广告管理', 11, 'add_advertising');
INSERT INTO `auth_permission` VALUES (42, 'Can change 广告管理', 11, 'change_advertising');
INSERT INTO `auth_permission` VALUES (43, 'Can delete 广告管理', 11, 'delete_advertising');
INSERT INTO `auth_permission` VALUES (44, 'Can view 广告管理', 11, 'view_advertising');

-- ----------------------------
-- Table structure for django_admin_log
-- ----------------------------
DROP TABLE IF EXISTS `django_admin_log`;
CREATE TABLE `django_admin_log`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `action_time` datetime(6) NOT NULL,
  `object_id` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL,
  `object_repr` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `action_flag` smallint(5) UNSIGNED NOT NULL,
  `change_message` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `content_type_id` int(11) NULL DEFAULT NULL,
  `user_id` int(11) NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `django_admin_log_content_type_id_c4bce8eb_fk_django_co`(`content_type_id`) USING BTREE,
  INDEX `django_admin_log_user_id_c564eba6_fk_tb_users_id`(`user_id`) USING BTREE,
  CONSTRAINT `django_admin_log_content_type_id_c4bce8eb_fk_django_co` FOREIGN KEY (`content_type_id`) REFERENCES `django_content_type` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `django_admin_log_user_id_c564eba6_fk_tb_users_id` FOREIGN KEY (`user_id`) REFERENCES `tb_users` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 10 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of django_admin_log
-- ----------------------------
INSERT INTO `django_admin_log` VALUES (1, '2021-09-30 07:32:10.976284', '1', '设计', 1, '[{\"added\": {}}]', 7, 6);
INSERT INTO `django_admin_log` VALUES (2, '2021-09-30 07:32:19.240229', '2', '程序员', 1, '[{\"added\": {}}]', 7, 6);
INSERT INTO `django_admin_log` VALUES (3, '2021-10-12 17:14:22.104339', '3', '然', 1, '[{\"added\": {}}]', 7, 6);
INSERT INTO `django_admin_log` VALUES (4, '2021-10-12 17:31:54.526466', '1', 'hr', 1, '[{\"added\": {}}]', 11, 6);
INSERT INTO `django_admin_log` VALUES (5, '2021-10-12 17:32:10.801976', '2', 'dd', 1, '[{\"added\": {}}]', 11, 6);
INSERT INTO `django_admin_log` VALUES (6, '2021-10-12 17:32:26.900450', '3', '1010', 1, '[{\"added\": {}}]', 11, 6);
INSERT INTO `django_admin_log` VALUES (7, '2021-10-12 17:47:05.457236', '4', '24', 1, '[{\"added\": {}}]', 11, 6);
INSERT INTO `django_admin_log` VALUES (8, '2021-10-13 11:32:51.004918', '4', '华晨宇', 1, '[{\"added\": {}}]', 7, 6);
INSERT INTO `django_admin_log` VALUES (9, '2021-10-13 11:46:19.232070', '5', '热门', 1, '[{\"added\": {}}]', 7, 6);
INSERT INTO `django_admin_log` VALUES (10, '2021-10-14 03:09:01.800909', '6', '技术交流', 1, '[{\"added\": {}}]', 7, 6);

-- ----------------------------
-- Table structure for django_content_type
-- ----------------------------
DROP TABLE IF EXISTS `django_content_type`;
CREATE TABLE `django_content_type`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `app_label` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `model` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `django_content_type_app_label_model_76bd3d3b_uniq`(`app_label`, `model`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 11 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of django_content_type
-- ----------------------------
INSERT INTO `django_content_type` VALUES (1, 'admin', 'logentry');
INSERT INTO `django_content_type` VALUES (3, 'auth', 'group');
INSERT INTO `django_content_type` VALUES (2, 'auth', 'permission');
INSERT INTO `django_content_type` VALUES (4, 'contenttypes', 'contenttype');
INSERT INTO `django_content_type` VALUES (11, 'home', 'advertising');
INSERT INTO `django_content_type` VALUES (9, 'home', 'article');
INSERT INTO `django_content_type` VALUES (7, 'home', 'articlecategory');
INSERT INTO `django_content_type` VALUES (10, 'home', 'comment');
INSERT INTO `django_content_type` VALUES (5, 'sessions', 'session');
INSERT INTO `django_content_type` VALUES (6, 'users', 'user');
INSERT INTO `django_content_type` VALUES (8, 'users', 'writeblogview');

-- ----------------------------
-- Table structure for django_migrations
-- ----------------------------
DROP TABLE IF EXISTS `django_migrations`;
CREATE TABLE `django_migrations`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `app` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `applied` datetime(6) NOT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 30 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of django_migrations
-- ----------------------------
INSERT INTO `django_migrations` VALUES (1, 'contenttypes', '0001_initial', '2021-09-26 09:26:12.316409');
INSERT INTO `django_migrations` VALUES (2, 'contenttypes', '0002_remove_content_type_name', '2021-09-26 09:26:12.582622');
INSERT INTO `django_migrations` VALUES (3, 'auth', '0001_initial', '2021-09-26 09:26:12.761691');
INSERT INTO `django_migrations` VALUES (4, 'auth', '0002_alter_permission_name_max_length', '2021-09-26 09:26:13.427955');
INSERT INTO `django_migrations` VALUES (5, 'auth', '0003_alter_user_email_max_length', '2021-09-26 09:26:13.450957');
INSERT INTO `django_migrations` VALUES (6, 'auth', '0004_alter_user_username_opts', '2021-09-26 09:26:13.477957');
INSERT INTO `django_migrations` VALUES (7, 'auth', '0005_alter_user_last_login_null', '2021-09-26 09:26:13.493956');
INSERT INTO `django_migrations` VALUES (8, 'auth', '0006_require_contenttypes_0002', '2021-09-26 09:26:13.504959');
INSERT INTO `django_migrations` VALUES (9, 'auth', '0007_alter_validators_add_error_messages', '2021-09-26 09:26:13.523959');
INSERT INTO `django_migrations` VALUES (10, 'auth', '0008_alter_user_username_max_length', '2021-09-26 09:26:13.542964');
INSERT INTO `django_migrations` VALUES (11, 'auth', '0009_alter_user_last_name_max_length', '2021-09-26 09:26:13.558966');
INSERT INTO `django_migrations` VALUES (12, 'auth', '0010_alter_group_name_max_length', '2021-09-26 09:26:13.608966');
INSERT INTO `django_migrations` VALUES (13, 'auth', '0011_update_proxy_permissions', '2021-09-26 09:26:13.636966');
INSERT INTO `django_migrations` VALUES (14, 'users', '0001_initial', '2021-09-26 09:26:13.862994');
INSERT INTO `django_migrations` VALUES (15, 'admin', '0001_initial', '2021-09-26 09:26:14.573743');
INSERT INTO `django_migrations` VALUES (16, 'admin', '0002_logentry_remove_auto_add', '2021-09-26 09:26:14.899319');
INSERT INTO `django_migrations` VALUES (17, 'admin', '0003_logentry_add_action_flag_choices', '2021-09-26 09:26:14.924317');
INSERT INTO `django_migrations` VALUES (18, 'sessions', '0001_initial', '2021-09-26 09:26:14.998323');
INSERT INTO `django_migrations` VALUES (21, 'home', '0001_initial', '2021-09-29 15:14:59.173533');
INSERT INTO `django_migrations` VALUES (22, 'home', '0002_article', '2021-09-30 08:19:02.539542');
INSERT INTO `django_migrations` VALUES (23, 'users', '0002_writeblogview', '2021-09-30 08:19:02.939543');
INSERT INTO `django_migrations` VALUES (24, 'home', '0003_auto_20210930_1715', '2021-09-30 09:15:44.573657');
INSERT INTO `django_migrations` VALUES (25, 'users', '0003_delete_writeblogview', '2021-09-30 09:15:44.690666');
INSERT INTO `django_migrations` VALUES (26, 'home', '0004_comment', '2021-09-30 16:18:59.845561');
INSERT INTO `django_migrations` VALUES (27, 'home', '0005_auto_20211013_0125', '2021-10-12 17:25:25.283262');
INSERT INTO `django_migrations` VALUES (28, 'home', '0006_auto_20211013_0126', '2021-10-12 17:26:46.943090');
INSERT INTO `django_migrations` VALUES (29, 'home', '0007_advertising', '2021-10-12 17:30:39.891644');

-- ----------------------------
-- Table structure for django_session
-- ----------------------------
DROP TABLE IF EXISTS `django_session`;
CREATE TABLE `django_session`  (
  `session_key` varchar(40) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `session_data` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `expire_date` datetime(6) NOT NULL,
  PRIMARY KEY (`session_key`) USING BTREE,
  INDEX `django_session_expire_date_a5c62663`(`expire_date`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for tb_advertising
-- ----------------------------
DROP TABLE IF EXISTS `tb_advertising`;
CREATE TABLE `tb_advertising`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `title` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `advertis` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `create_time` datetime(6) NOT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 5 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of tb_advertising
-- ----------------------------
INSERT INTO `tb_advertising` VALUES (1, 'hr', 'advertis/20211013/img-1629894692210e4288623887a6e4eed772aaaeaf17462.jpg', '2021-10-12 17:31:00.000000');
INSERT INTO `tb_advertising` VALUES (2, 'dd', 'advertis/20211013/img-1631836279377bbef88eb135ba5e9d4e0038a98011135.jpg', '2021-10-12 17:31:00.000000');
INSERT INTO `tb_advertising` VALUES (3, '1010', 'advertis/20211013/img-1628928568030ca4c118ebb26fcd49bd9c60b0df90e7e.jpg', '2021-10-12 17:32:00.000000');
INSERT INTO `tb_advertising` VALUES (4, '24', 'advertis/20211013/img-1625774963593db2c5108f49fed8865dcdfbccf5c61c5.jpg', '2021-10-12 17:46:00.000000');

-- ----------------------------
-- Table structure for tb_article
-- ----------------------------
DROP TABLE IF EXISTS `tb_article`;
CREATE TABLE `tb_article`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `avatar` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `title` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `tags` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `sumary` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `content` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `total_views` int(10) UNSIGNED NOT NULL,
  `comments_count` int(10) UNSIGNED NOT NULL,
  `create_time` datetime(6) NOT NULL,
  `update_time` datetime(6) NOT NULL,
  `author_id` int(11) NOT NULL,
  `category_id` int(11) NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `tb_article_author_id_dcf763a4_fk_tb_users_id`(`author_id`) USING BTREE,
  INDEX `tb_article_category_id_d66932e8_fk_tb_category_id`(`category_id`) USING BTREE,
  CONSTRAINT `tb_article_author_id_dcf763a4_fk_tb_users_id` FOREIGN KEY (`author_id`) REFERENCES `tb_users` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `tb_article_category_id_d66932e8_fk_tb_category_id` FOREIGN KEY (`category_id`) REFERENCES `tb_category` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 32 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of tb_article
-- ----------------------------
INSERT INTO `tb_article` VALUES (15, 'article/2021/10/13/001nH8D1ly1gvdi03s4wgj61hc0u0toq02.jpg', '2021火星演唱会', '预售', '票价仍然延续以往，连续8年不涨！', '<p>2021火星演唱会发布概念海报，宣布将于<strong>10月30日</strong>开启首周（11月26/27/28日）门票预售！此次演唱会将在模式、舞台、时长上全面颠覆式创新升级，舞台首次采用&ldquo;多面融合&rdquo;的全新舞台形式，演出时长也惊喜翻倍至240分钟，票价仍然延续以往，连续8年不涨！</p>\r\n', 11, 4, '2021-10-11 11:51:47.000000', '2021-10-14 09:35:09.179277', 6, 5);
INSERT INTO `tb_article` VALUES (16, 'article/2021/10/13/001LY0OXly1gvdmayfetpj64462bcx6t02.jpg', '今年改成全员站票', '预售', '全员站票', '<p>今年改成全员站票，这次我们可以从下午开始吃吃喝喝玩玩唱唱一直到晚上！哈哈哈～大家最近要早睡早起多锻炼身体哦，这样才有体力一起玩耍！<br />\r\n预售时间：10月30日预售首周三场<br />\r\n19：27 第一场（11月26日）<br />\r\n20：27 第二场（11月27日）<br />\r\n21：27 第三场（11月28日）</p>\r\n', 12, 1, '2021-10-07 12:07:35.000000', '2021-10-14 09:48:58.225634', 4, 5);
INSERT INTO `tb_article` VALUES (19, 'article/2021/10/13/bd0586ffly4gt00jzdvdpj20hs0hsq3l.jpg', '碧梨Billie Eilish新专辑口碑爆棚！', '欧美', '碧梨称“自我反省”是这张专辑最大的灵感来源。', '<p>终于等到！2021年7月30日，美国创作型歌手Billie Eilish发行了第二张录音室专辑&mdash;&mdash;《Happier Than Ever》。此专辑由Darkroom和Interscope唱片公司发行。碧梨称&ldquo;自我反省&rdquo;是这张专辑最大的灵感来源。</p>\r\n\r\n<p>碧梨为了宣传专辑，提前发行了五首单曲：《My Future》、《Therefore I Am》、《Your Power》、《Lost Cause》和《NDA》，这些单曲都进入了美国公告牌百强单曲榜的前40名。为了进一步宣传，迪士尼+纪录片音乐会电影《<strong>Happier Than Ever: A Love Letter to Los Angeles</strong>》将于2021年9月3日上映！另外，碧梨将开启2022年世界巡回演唱会！</p>\r\n\r\n<p>在专辑正式发行之前，《Happier Than Ever》成为Apple Music历史上预约次数最多的专辑。专辑发行后，这张专辑受到了音乐评论家的广泛好评，他们盛赞其风格化的制作和富有洞察力的歌词！</p>\r\n\r\n<h1>流媒成绩</h1>\r\n\r\n<p>《Happier Than Ever》一经发行，就迅速登顶美区/全球iTunes！</p>\r\n\r\n<p>另外，Billie Eilish新专辑还在八十个国家的Apple Music上登顶！此成绩在所有的女歌手之中，排名第二！</p>\r\n\r\n<p>新专辑发行之后，Billie Eilish成为数字平台最畅销的女歌手!不愧是人气最TOP的Z世代歌手之一！</p>\r\n\r\n<h1>乐评成绩</h1>\r\n\r\n<p>Billie Eilish《Happier Than Ever》开局综合乐评87分！目前，结合十家专业机构及用户评分后，综评上升到90分！这是碧梨乐评最好的专辑！也是今年评价最高的女歌手专辑！</p>\r\n\r\n<p><img src=\"https://wx4.sinaimg.cn/large/bd0586ffly4gt00jzgp18j20hs0hsabu.jpg\" alt=\"\"></p>\r\n', 7, 0, '2021-10-13 12:29:40.295366', '2021-10-14 09:36:44.157272', 4, 3);
INSERT INTO `tb_article` VALUES (20, 'article/2021/10/13/007JnQkaly4gv7yhkb8ywj60hs0m13zw02.jpg', '爱上霉霉，真是件让人放心的事……', '欧美', '​​她有精致而优美的面貌，她拥有才华横溢的音乐天赋，她同样在影视圈里混的风生水起', '<p>她有精致而优美的面貌，她拥有才华横溢的音乐天赋，她同样在影视圈里混的风生水起，而她又是一位百变造型和感情泛滥的女孩儿，她就是我们大名鼎鼎的&ldquo;霉霉&rdquo;泰勒&middot;斯威夫特。</p>\r\n\r\n<p>&nbsp;</p>\r\n\r\n<p>了解过她的人说，以后自己的小孩迷上她当偶像，那都是很放心的事情！。她16岁出道，今年32岁，是世界同龄女歌手里面，成就最出色的一位。</p>\r\n\r\n<p>首先说一下&ldquo;霉霉&rdquo;这个称呼的来历。因为泰勒&middot;斯威夫特年纪小，而长的又十分的漂亮，是一位标准的小美女，美国粉丝都亲切的叫她甜心。而&ldquo;霉&rdquo;还有一层意思那就是倒霉，每当泰勒&middot;艾莉森&middot;斯威夫特有强势的单曲冲击 Billboard Hot100榜单冠军时，都会遇到各种妖孽，各种的状况，非常倒霉的屈居亚军。而霉又和美同音，所以我们中国的粉丝就称呼她为&ldquo;霉霉&rdquo;（这是一个昵称并没有别的意思）。</p>\r\n\r\n<p>童年时期，泰勒&middot;斯威夫特住在美国宾夕法尼亚州怀俄明辛的一个11 英亩的圣诞树农场。10 岁时，她写了一篇长达三页的诗歌《我壁橱里的怪物》，获得了全美诗歌大赛奖项&nbsp;[19]&nbsp;。同年，开始在美国费城以及周边地区演出。11岁时，在NBA球队费城76人比赛前，登台演唱美国国歌&nbsp;[20]&nbsp;。</p>\r\n\r\n<p>&nbsp;</p>\r\n\r\n<p>在2006年是时候，Taylor Swift才开始发行第一张专辑，但到了2010年的时候，她就可以凭借第二张专辑《Fearless》拿到了格莱美大奖&mdash;&mdash;年度最佳专辑。也就是4年的时间，Taylor Swift就从初出茅庐转变到可以拿世界最高级别的音乐大奖的实力歌手。当时她才20岁，成为了该奖项有史以来最年轻的一个获奖者。</p>\r\n\r\n<p>此后的十年，Taylor Swift一发不可收拾，是史上最出色的表演艺术家之一：根据尼尔森数据，她累积卖出了3730万张专辑，Billboard Hot 100上有她的95个条目（包括5个第一），23个广告牌音乐大奖，12个乡村音乐协会奖，10座格莱美和5次世界巡回演出。做到这些的时候，她还没有年满30岁。</p>\r\n\r\n<p>除了才华过人、实力了得之外，她还有什么魅力值得大家喜欢和跟随吗？</p>\r\n\r\n<p>有的，那就是真实，绝对的真实。</p>\r\n\r\n<p>&nbsp;</p>\r\n\r\n<p>熟悉了解她的人，会说她是好女孩。</p>\r\n\r\n<p>&nbsp;</p>\r\n', 3, 0, '2021-10-13 12:35:16.443529', '2021-10-14 09:36:35.893118', 4, 3);
INSERT INTO `tb_article` VALUES (21, 'article/2021/10/13/img-1625105298807d1016838d3b932197d11e5c5c54c8036.jpg', '最好的我们！！！！', '耿耿余淮', '余淮白月光', '<p>最好的我们！！！！</p>\r\n\r\n<p>余淮简直就是白月光啊！</p>\r\n\r\n<p>印象最深的就是他那句&ldquo;敢碰小爷我的人，我看他是活腻了&rdquo;</p>\r\n\r\n<p>而且不得不说刘昊然演的还是蛮好的。</p>\r\n\r\n<p>代入感太强了&hellip;&hellip;以至于现在说余淮我脑子里浮现出的就是刘昊然那张脸（尽管我知道余淮是余淮，刘昊然是刘昊然）</p>\r\n\r\n<p>他眼里的星星还有身上散发出的少年感都让人印象深刻啊啊啊。</p>\r\n\r\n<p>还有后来都长大了，耿耿余淮再次相遇，耿耿强吻余淮之后，余淮内心知道自己配不上耿耿，不能让耿耿把时间浪费在他身上，亲完就是反派一样的眼神。</p>\r\n\r\n<p>刘昊然的切换真的老好了，那一刻真的会觉得余淮黑化了。</p>\r\n\r\n<p>还有最后那一句&ldquo;都耿耿于怀十多年了，也还有个结果了&rdquo;</p>\r\n', 1, 0, '2021-10-13 12:54:04.194941', '2021-10-14 07:49:04.379233', 4, 4);
INSERT INTO `tb_article` VALUES (22, 'article/2021/10/13/12pic001_26.jpg', '《琅琊榜之风起长林》', '长林二公子', '长林二公子是谁？萧平旌，萧平旌是谁？刘昊然。', '<p>《琅琊榜之风起长林》</p>\r\n\r\n<p>《琅琊榜》一上映的时候，我本来不想看，觉得古装剧也就那么回事，但是到哪都能看到，遭不住啊！看吧，于是就看了榜一，这次的观影体验为日后我看榜二提供了动机，于是还入了另一个坑&hellip;&hellip;</p>\r\n\r\n<p>榜二演的是什么？以长林王府为主线的家国情怀众生相，那么成林王府的主视角在谁？长林二公子，长林二公子是谁？萧平旌，萧平旌是谁？刘昊然。</p>\r\n\r\n<p>看过并深爱榜一的小伙伴都知道，阴诡谋士之前也是挽过劲弓降过烈马的，不同于梅长苏病不离身平静淡雅，那个林殊少帅是整个大梁最耀眼飞扬跳脱的少年，他到底什么样，我们谁也没见过。而这次的萧平旌却让我们看见了，那个战场上往来不败的少年将军从我们的脑海里、猜想中走了出来。</p>\r\n\r\n<p>刘昊然饰演的萧平旌在很大程度上满足了我个人对于林殊的猜想，所以爱屋及乌是我一开始喜欢刘昊然的动机。年少时飞扬跳脱逍遥山水间，经历变故后依旧不改本色，但成熟坚毅的样子他都有，甚至可以说：如果林殊当年在梅岭没经历那场灭顶之灾，他或许也会是萧平旌在老王爷辞世之后隐居琅琊阁的样子。</p>\r\n', 3, 0, '2021-10-13 12:57:37.515230', '2021-10-14 07:48:59.423751', 4, 4);
INSERT INTO `tb_article` VALUES (23, 'article/2021/10/13/3pic001_114.jpg', '刘昊然中国内地男演员', '中央戏剧学院', '刘昊然，1997年10月10日出生于河南省平顶山市，中国内地男演员，毕业于中央戏剧学院表演系本科。', '<p>刘昊然，1997年10月10日出生于河南省平顶山市，中国内地男演员，毕业于中央戏剧学院表演系本科</p>\r\n\r\n<p>2014年，主演电影《北京爱情故事》而正式出道，并凭借该片提名第21届北京大学生电影节最佳新人奖 。2015年5月，加盟国防教育特别节目《真正男子汉》；7月，以专业和文化双科第一名的成绩被中戏录取 。12月，主演悬疑喜剧电影《唐人街探案》 ，凭借该片获得第20届华鼎奖中国最佳新人奖、2016中国电影指数盛典最佳银幕新锐演员奖 &nbsp;，并提名第19届上海国际电影节亚洲新人奖最佳男演员 &nbsp;，该片中国内地票房达到8.23亿元 &nbsp;。<br />\r\n2017年，主演建军90周年献礼影片《建军大业》；12月，主演由陈凯歌执导的魔幻电影《妖猫传》。随后，主演古装权谋剧《琅琊榜之风起长林》 &nbsp;。<br />\r\n2018年，主演喜剧电影《唐人街探案2》，凭借该电影提名第34届大众电影百花奖最佳男主角 [15] &nbsp;，该片中国内地票房33.97亿元，刷新2D电影和喜剧电影票房纪录，总票房居中国影史前三 &nbsp;。<br />\r\n2019年，主演古装剧《九州缥缈录》和陈凯歌执导的献礼建国70周年电影《我和我的祖国》 [20-22] &nbsp;。2020年，担任2020年中国金鸡百花电影节形象大使并主演青春创业喜剧电影《一点就到家》 &nbsp;。<br />\r\n2021年，主演喜剧电影《唐人街探案3》</p>\r\n', 7, 0, '2021-10-13 14:10:59.913260', '2021-10-16 14:39:26.045806', 4, 4);
INSERT INTO `tb_article` VALUES (24, 'article/2021/10/13/006FdZHVly4gudnifpa1mj60rs0yq7b902.jpg', '国人气女团BLACKPINK成员Lisa', '专辑', '推出的首张Solo单曲专辑《LALISA》的同名主打歌《LALISA》', '<p>​​国人气女团BLACKPINK成员Lisa（Lalisa）昨日（10日）推出的首张Solo单曲专辑《LALISA》的同名主打歌《LALISA》，截至韩国时间11日12点，在65个国家与地区的iTunes歌曲榜获得冠军。</p>\r\n\r\n<p>《LALISA》在台湾、香港、泰国、法国、瑞典、波兰、纽西兰、葡萄牙、西班牙、巴西、蒙古、加拿大、葡萄牙、墨西哥、乌克兰、智利、奥地利、菲律宾、印尼、印度、越南、澳门、汶莱、马来西亚、秘鲁、哥伦比亚、沙乌地阿拉伯、阿根廷、柬埔寨、以色列、埃及等65个国家与地区的iTunes歌曲榜登上第一名。</p>\r\n\r\n<p>此外，《LALISA》的YouTube官方MV昨日（10日）韩国时间下午1点公开后，在24小时内达成7,050万次观看。《LALISA》不仅成为当天全球观看热度最高的MV，此成绩也远远超越了由BLACKPINK成员Ros&eacute;（朴彩英）以《On The Ground》创下的K-POP女子Solo歌手MV在24小时内的最高视听数（3,900万次观看）。</p>\r\n', 3, 0, '2021-10-13 14:20:37.999911', '2021-10-14 09:36:01.520097', 4, 3);
INSERT INTO `tb_article` VALUES (25, 'article/2021/10/13/img-1633527588492c49e8e44e77131250ef1395818c081ba.jpg', '华晨宇中国内地流行乐男歌手、作曲人', '专辑', '华晨宇，1990年2月7日生于湖北省十堰市，中国内地流行乐男歌手、作曲人，毕业于武汉音乐学院。', '<p>华晨宇，1990年2月7日生于湖北省十堰市，中国内地流行乐男歌手、作曲人，毕业于武汉音乐学院。<br />\r\n2013年参加湖南卫视《快乐男声》获年度总冠军出道 &nbsp; 。2014年1月首登央视春晚舞台；同年4月参加户外真人秀节目《花儿与少年第一季》；9月6日-7日在北京万事达中心连开两场&ldquo;火星&rdquo;演唱会 &nbsp; ，随后发行首张个人专辑《卡西莫多的礼物》 &nbsp; ，并凭此专辑获2015QQ音乐年度最佳内地男歌手等奖项。2015年7月31日-8月2日在上海大舞台连开三场个人演唱 &nbsp;；同年12月发行第二张专辑《异类》，获2016酷音乐亚洲盛典年度最佳专辑等奖项。<br />\r\n2016年9月27日，获得亚洲新歌榜2016年度盛典最佳男歌手奖；同年10月加盟东方卫视《天籁之战第一季》；同年12月2日，获得2016MAMA亚洲最佳艺人奖。2017年3月14日，发行专辑《H》；同年6月，参加旅行真人秀《旅途的花样》。2018年2月参加湖南卫视《歌手2018》，获得总决赛亚军 &nbsp;；同年9月8日-9日在鸟巢体育场连开两场2018火星演唱会 &nbsp; 。2019年2月担任浙江卫视《王牌对王牌第四季》固定MC &nbsp;；同年11月15日-17日在海口五源河体育场连开3场2019火星演唱会 &nbsp;。<br />\r\n2020年2月21日再次加盟综艺节目《王牌对王牌第五季》；4月24日成为《歌手&middot;当打之年》总冠军 ；同年4月8日，发行数字专辑《新世界NEW WORLD》 &nbsp;，5月11日发布实体版。</p>\r\n', 3, 0, '2021-10-13 14:32:57.319202', '2021-10-14 09:35:29.937251', 4, 5);
INSERT INTO `tb_article` VALUES (27, 'article/2021/10/14/0078xOudgy1gv32pb12bpj634022pe8102.jpg', '​​陈立农 他曾是台南的“夜市小王子”', 'NINE PERCENT', '​​他曾是台南的“夜市小王子”，九岁起就帮父母分担家计；', '<p>​​他曾是台南的&ldquo;夜市小王子&rdquo;，九岁起就帮父母分担家计；</p>\r\n\r\n<p>也曾随NINE PERCENT组合出道，有着一幅&ldquo;开口跪&rdquo;的低音炮好嗓子；</p>\r\n\r\n<p>千禧年出生的他，凭借电影《赤狐书生》里的&ldquo;书生王子进&rdquo;，荣获2020电影频道M榜&middot;年度最具潜力演员提名；</p>\r\n\r\n<p>现在，他是综艺《牛气满满的哥哥》中的&ldquo;小哥队队长&rdquo;，在微博拥有1900多万粉丝，多个品牌代言在手&hellip;&hellip;</p>\r\n\r\n<p>他曾说自己梦想成为一个全能艺人，演戏、唱歌、主持&hellip;&hellip;如今，他在各个领域表现越来越优异，成功地闯入了公众视线。</p>\r\n\r\n<p>从歌手到演员，再到多栖艺人，宝藏男孩陈立农一步一个脚印，坚定不移地朝着自己的梦想前进。</p>\r\n\r\n<p>有人说，《赤狐书生》里的呆萌书生王子进就是陈立农的本色出演，性情单纯、天真赤诚，永葆一颗努力、勇敢、向上的心，和现实中的陈立农颇为相似。</p>\r\n', 0, 0, '2021-10-14 13:55:10.388934', '2021-10-14 13:55:10.391526', 4, 1);
INSERT INTO `tb_article` VALUES (28, 'article/2021/10/14/001Ntt2Jly1gvek9hch0hj61jk2bckjl02.jpg', '倪妮 毕业于南京传媒学院语言传播系', '演员', '文艺片《金陵十三钗》在中国内地上映，该片在中国内地电影市场连续四周获得周票房冠军', '<p>倪妮，1988年8月8日出生于江苏省南京市，中国内地女演员，毕业于南京传媒学院语言传播系。</p>\r\n\r\n<p>倪妮，1988年8月8日出生于江苏省南京市，中国内地女演员，毕业于南京传媒学院语言传播系。2011年，因出演战争史诗电影《金陵十三钗》女主角赵玉墨一角而进入演艺圈，并凭借此片获得第六届亚洲电影大奖最佳新演员等多个奖项。2013年，主演爱情悬疑电影《杀戒》、爱情电影《我想和你好好的》及治愈系电影《等风来》。2014年，主演校园爱情电影《匆匆那年》；同年，成为第九届中国作家榜授予的首任&ldquo;阅读星大使&rdquo;。</p>\r\n\r\n<p>1988年8月8日出生于南京的倪妮，小学就读于南京市长江路小学，初中考入南京市第九中学，高中就读于南京市梅园中学，高三转到江苏省盱眙中学。2007年考入南京传媒学院，于2011年6月毕业。在校期间她是国家二级游泳运动员，还获得过江苏省国际标准舞冠军</p>\r\n\r\n<p>2009年11月，学习播音主持的倪妮参加《金陵十三钗》剧组演员选拔，在众多参选人中获张艺谋赏识担任片中女主角赵玉墨，并加以三年时间秘密演艺培训</p>\r\n\r\n<p>2011年12月15日，文艺片《金陵十三钗》在中国内地上映，该片在中国内地电影市场连续四周获得周票房冠军，同时也是2011年华语电影票房冠军，而倪妮凭借风尘女子玉墨一角获得第6届亚洲电影大奖最佳新演员、第12届华语电影传媒大奖观众票选最受瞩目女演员及第3届乐视影视盛典年度电影最受欢迎女演员奖等多个奖项</p>\r\n', 0, 0, '2021-10-14 14:00:31.499352', '2021-10-14 14:00:31.502354', 4, 1);
INSERT INTO `tb_article` VALUES (29, 'article/2021/10/14/004eDZdaly1gv6u0m33ioj60j60j6wi502.jpg', '范丞丞 中国内地男歌手、男子组合乐华七子NEXT', 'NINE PERCENT', '2018年4月6日，在偶像竞演养成类真人秀《偶像练习生》总决赛中获得第三名，作为男子团体NINE PERCENT成员正式出道  ', '<p>范丞丞，2000年6月16日出生于山东省青岛市，中国内地男歌手、男子组合乐华七子NEXT、前NINE PERCENT成员</p>\r\n\r\n<p>2018年4月6日，在偶像竞演养成类真人秀《偶像练习生》总决赛中获得第三名，作为男子团体NINE PERCENT成员正式出道 &nbsp;；11月22日，发布首支个人单曲《I&#39;m Here》；12月18日，获得第十届新京报&ldquo;中国时尚权力榜&rdquo;年度新势力艺人 &nbsp;。2019年5月4日，担任浙江卫视《青春环游记》常驻嘉宾 &nbsp; 。2020年7月31日，加盟《做家务的男人第二季》 &nbsp;；10月22日，加盟《潮流合伙人2》嘉宾阵容。 &nbsp;2021年3月3日，法国奢侈品牌纪梵希宣布歌手及演员范丞丞成为其品牌代言人&nbsp;<br />\r\n2018年至2020年，连续三年参加浙江卫视跨年演唱会 &nbsp; 。2019年10月17日，范丞丞入选2019福布斯中国30位30岁以下精英榜 &nbsp;。</p>\r\n', 1, 0, '2021-10-14 14:04:44.497462', '2021-10-15 05:48:01.475888', 4, 1);
INSERT INTO `tb_article` VALUES (30, 'article/2021/10/14/001t3Rijly3gvcnn15yivj616o1kw4qp02.jpg', '佟丽娅中国内地影视女演员、舞者', '演员', '2000年，佟丽娅成为了新疆歌舞团的舞蹈演员。2004年，进入中国歌舞团担任舞蹈演员', '<p>佟丽娅，1983年8月8日出生于新疆伊犁察布查尔，中国内地影视女演员、舞者。2000年，佟丽娅成为了新疆歌舞团的舞蹈演员。2004年，进入中国歌舞团担任舞蹈演员。2006年，因出演情感剧《新不了情》而踏入影视圈。2008年，凭借古装剧《母仪天下》在影视领域崭露头角。2011年开始，她因出演穿越剧《宫锁心玉》、爱情剧《北京爱情故事》获得更多关注；并义务出任锡伯族形象大使。</p>\r\n\r\n<p>2009年，佟丽娅先是出演了民国爱情伦理剧《娘妻》；随后，她又与赵文瑄、海陆、袁姗姗联袂主演了年代情仇剧《大屋下的丫鬟》，并在剧中饰演了为查出父母被害真相而忍辱负重的江南女孩苏文慧 ；同年，佟丽娅还在与陈键锋搭档主演的年代商战爱情剧《烟雨斜阳》中饰演了秀外慧中且温柔可人的女主角高宛宜；此外，她还领衔主演了民族剧情片《花腰女儿红》、都市爱情片《玫瑰余香》。</p>\r\n', 4, 0, '2021-10-14 14:08:08.146492', '2021-10-15 06:34:41.040350', 4, 1);

-- ----------------------------
-- Table structure for tb_category
-- ----------------------------
DROP TABLE IF EXISTS `tb_category`;
CREATE TABLE `tb_category`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `title` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `create_time` datetime(6) NOT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 7 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of tb_category
-- ----------------------------
INSERT INTO `tb_category` VALUES (1, '内地', '2021-09-30 07:32:00.000000');
INSERT INTO `tb_category` VALUES (3, '国外', '2021-10-12 17:14:00.000000');
INSERT INTO `tb_category` VALUES (4, '刘昊然', '2021-10-13 11:32:00.000000');
INSERT INTO `tb_category` VALUES (5, '华晨宇', '2021-10-13 11:46:00.000000');

-- ----------------------------
-- Table structure for tb_comment
-- ----------------------------
DROP TABLE IF EXISTS `tb_comment`;
CREATE TABLE `tb_comment`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `content` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `created_time` datetime(6) NOT NULL,
  `article_id` int(11) NULL DEFAULT NULL,
  `user_id` int(11) NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `tb_comment_article_id_d3d5d1ea_fk_tb_article_id`(`article_id`) USING BTREE,
  INDEX `tb_comment_user_id_905a9388_fk_tb_users_id`(`user_id`) USING BTREE,
  CONSTRAINT `tb_comment_article_id_d3d5d1ea_fk_tb_article_id` FOREIGN KEY (`article_id`) REFERENCES `tb_article` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `tb_comment_user_id_905a9388_fk_tb_users_id` FOREIGN KEY (`user_id`) REFERENCES `tb_users` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 20 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of tb_comment
-- ----------------------------
INSERT INTO `tb_comment` VALUES (16, '票價也太划算了吧！超長時長，新形式，在遊樂園，有吃有喝有玩，不漲價！', '2021-10-13 11:52:52.056961', 15, 4);
INSERT INTO `tb_comment` VALUES (17, '全员站票！期待啊[打call]', '2021-10-13 11:53:06.195957', 15, 4);
INSERT INTO `tb_comment` VALUES (18, '华晨宇演唱会8年未涨价，他真是对歌迷超好！', '2021-10-13 11:53:18.017699', 15, 4);
INSERT INTO `tb_comment` VALUES (19, '我来了我来了我来了我来了啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊', '2021-10-13 12:14:30.348142', 16, 4);

-- ----------------------------
-- Table structure for tb_users
-- ----------------------------
DROP TABLE IF EXISTS `tb_users`;
CREATE TABLE `tb_users`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `password` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `last_login` datetime(6) NULL DEFAULT NULL,
  `is_superuser` tinyint(1) NOT NULL,
  `username` varchar(150) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `first_name` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `last_name` varchar(150) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `email` varchar(254) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `is_staff` tinyint(1) NOT NULL,
  `is_active` tinyint(1) NOT NULL,
  `date_joined` datetime(6) NOT NULL,
  `mobile` varchar(11) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `avatar` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `user_desc` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `username`(`username`) USING BTREE,
  UNIQUE INDEX `mobile`(`mobile`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 7 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of tb_users
-- ----------------------------
INSERT INTO `tb_users` VALUES (4, 'pbkdf2_sha256$150000$xRpRkNhmCDDp$SvPyYIHLfu4Ct3rROTNUVRSaPMh4JJrod+F4t5DeF/4=', '2021-10-15 07:11:38.874900', 0, '刘源', '', '', '', 0, 1, '2021-09-27 12:35:09.339405', '17691149837', 'avatar/20211013/1_6.jpg', '');
INSERT INTO `tb_users` VALUES (5, 'pbkdf2_sha256$150000$hV6wePdhPxty$/968T4w6fHyQ7oAMuI2oXDNh6h0zUg4PV4uw00UtyeU=', '2021-10-01 11:49:34.899661', 0, '199999999', '', '', '', 0, 1, '2021-09-29 08:51:01.495998', '19999999999', '', 'hhhh');
INSERT INTO `tb_users` VALUES (6, 'pbkdf2_sha256$150000$sMVwDxv8s8Hc$UjRBKscoHo4GIPVOdU8z0idFtZ1fwHxT6cqL3G+iGdc=', '2021-10-14 03:08:35.414337', 1, 'admin', '', '', '2647387166@qq.com', 1, 1, '2021-09-29 15:22:19.121305', '1111', '', '');

-- ----------------------------
-- Table structure for tb_users_groups
-- ----------------------------
DROP TABLE IF EXISTS `tb_users_groups`;
CREATE TABLE `tb_users_groups`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL,
  `group_id` int(11) NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `tb_users_groups_user_id_group_id_5a177a84_uniq`(`user_id`, `group_id`) USING BTREE,
  INDEX `tb_users_groups_group_id_04d64563_fk_auth_group_id`(`group_id`) USING BTREE,
  CONSTRAINT `tb_users_groups_group_id_04d64563_fk_auth_group_id` FOREIGN KEY (`group_id`) REFERENCES `auth_group` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `tb_users_groups_user_id_5f9e3ed0_fk_tb_users_id` FOREIGN KEY (`user_id`) REFERENCES `tb_users` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for tb_users_user_permissions
-- ----------------------------
DROP TABLE IF EXISTS `tb_users_user_permissions`;
CREATE TABLE `tb_users_user_permissions`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL,
  `permission_id` int(11) NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `tb_users_user_permissions_user_id_permission_id_064c2ef6_uniq`(`user_id`, `permission_id`) USING BTREE,
  INDEX `tb_users_user_permis_permission_id_b9b3ac94_fk_auth_perm`(`permission_id`) USING BTREE,
  CONSTRAINT `tb_users_user_permis_permission_id_b9b3ac94_fk_auth_perm` FOREIGN KEY (`permission_id`) REFERENCES `auth_permission` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `tb_users_user_permissions_user_id_2726c819_fk_tb_users_id` FOREIGN KEY (`user_id`) REFERENCES `tb_users` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

SET FOREIGN_KEY_CHECKS = 1;
