/*
 * 用户表建表语句
 * 包含基础用户信息和常用扩展字段
 */
CREATE TABLE users (
    -- 主键ID，自增长
                       id INT PRIMARY KEY AUTO_INCREMENT COMMENT '用户唯一ID',

    -- 用户名，唯一且不能为空
                       username VARCHAR(50) NOT NULL UNIQUE COMMENT '登录用户名',

    -- 密码字段，存储加密后的密码
                       password VARCHAR(255) NOT NULL COMMENT '加密后的密码',

    -- 用户真实姓名
                       name VARCHAR(100) COMMENT '用户真实姓名',

    -- 用户年龄
                       age INT COMMENT '用户年龄',

    -- 用户电子邮箱
                       email VARCHAR(100) COMMENT '电子邮箱地址',

    -- 用户手机号
                       phone VARCHAR(20) COMMENT '联系电话',

    -- 用户性别：M-男，F-女，O-其他
                       gender CHAR(1) COMMENT '性别(M-男/F-女/O-其他)',

    -- 记录创建时间，默认当前时间
                       create_time DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT '账号创建时间',

    -- 记录更新时间，修改时自动更新为当前时间
                       update_time DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '最后更新时间',

    -- 账号状态：0-禁用，1-正常
                       status TINYINT DEFAULT 1 COMMENT '账号状态(0-禁用/1-正常)',

    -- 用户地址信息
                       address VARCHAR(255) COMMENT '详细地址',

    -- 用户头像URL
                       avatar VARCHAR(255) COMMENT '头像图片URL',

    -- 最后登录时间
                       last_login_time DATETIME COMMENT '最后登录时间',

    -- 用户角色：user-普通用户，admin-管理员，editor-编辑
                       role VARCHAR(20) DEFAULT 'user' COMMENT '用户角色(user/admin/editor)'
) COMMENT '系统用户表';

/*
 * 向users表插入50条中文用户数据
 * 密码字段使用MD5('123456')的结果(e10adc3949ba59abbe56e057f20f883e)
 * 实际生产环境应使用更安全的加密方式
 */

INSERT INTO users (
    username, password, name, age, email, phone, gender,
    address, avatar, last_login_time, role
) VALUES
-- 1-10
('zhangsan', 'e10adc3949ba59abbe56e057f20f883e', '张三', 25, 'zhangsan@example.com', '13800138001', 'M', '北京市朝阳区建国路88号', 'https://example.com/avatars/1.jpg', '2023-08-01 09:15:00', 'user'),
('lisi', 'e10adc3949ba59abbe56e057f20f883e', '李四', 30, 'lisi@example.com', '13800138002', 'M', '上海市浦东新区陆家嘴环路1000号', 'https://example.com/avatars/2.jpg', '2023-08-02 10:20:00', 'admin'),
('wangwu', 'e10adc3949ba59abbe56e057f20f883e', '王五', 28, 'wangwu@example.com', '13800138003', 'M', '广州市天河区体育西路189号', 'https://example.com/avatars/3.jpg', '2023-08-03 11:25:00', 'editor'),
('zhaoliu', 'e10adc3949ba59abbe56e057f20f883e', '赵六', 35, 'zhaoliu@example.com', '13800138004', 'M', '深圳市南山区科技园路1号', 'https://example.com/avatars/4.jpg', '2023-08-04 14:30:00', 'user'),
('sunqi', 'e10adc3949ba59abbe56e057f20f883e', '孙七', 22, 'sunqi@example.com', '13800138005', 'F', '成都市武侯区人民南路四段1号', 'https://example.com/avatars/5.jpg', '2023-08-05 15:35:00', 'user'),
('zhouba', 'e10adc3949ba59abbe56e057f20f883e', '周八', 40, 'zhouba@example.com', '13800138006', 'M', '杭州市西湖区文三路199号', 'https://example.com/avatars/6.jpg', '2023-08-06 16:40:00', 'admin'),
('wujiu', 'e10adc3949ba59abbe56e057f20f883e', '吴九', 27, 'wujiu@example.com', '13800138007', 'F', '武汉市洪山区珞喻路1037号', 'https://example.com/avatars/7.jpg', '2023-08-07 17:45:00', 'editor'),
('zhengshi', 'e10adc3949ba59abbe56e057f20f883e', '郑十', 33, 'zhengshi@example.com', '13800138008', 'M', '南京市鼓楼区中山路321号', 'https://example.com/avatars/8.jpg', '2023-08-08 18:50:00', 'user'),
('lihua', 'e10adc3949ba59abbe56e057f20f883e', '李华', 29, 'lihua@example.com', '13800138009', 'F', '西安市雁塔区长安南路123号', 'https://example.com/avatars/9.jpg', '2023-08-09 19:55:00', 'user'),
('wangfang', 'e10adc3949ba59abbe56e057f20f883e', '王芳', 26, 'wangfang@example.com', '13800138010', 'F', '重庆市渝中区解放碑1号', 'https://example.com/avatars/10.jpg', '2023-08-10 20:00:00', 'admin'),

-- 11-20
('zhangwei', 'e10adc3949ba59abbe56e057f20f883e', '张伟', 31, 'zhangwei@example.com', '13800138011', 'M', '天津市和平区南京路189号', 'https://example.com/avatars/11.jpg', '2023-08-11 08:05:00', 'editor'),
('liumei', 'e10adc3949ba59abbe56e057f20f883e', '刘梅', 24, 'liumei@example.com', '13800138012', 'F', '苏州市工业园区星湖街218号', 'https://example.com/avatars/12.jpg', '2023-08-12 09:10:00', 'user'),
('wangjun', 'e10adc3949ba59abbe56e057f20f883e', '王军', 36, 'wangjun@example.com', '13800138013', 'M', '长沙市岳麓区麓山南路1号', 'https://example.com/avatars/13.jpg', '2023-08-13 10:15:00', 'user'),
('zhaoyan', 'e10adc3949ba59abbe56e057f20f883e', '赵燕', 23, 'zhaoyan@example.com', '13800138014', 'F', '郑州市金水区花园路88号', 'https://example.com/avatars/14.jpg', '2023-08-14 11:20:00', 'admin'),
('sunbin', 'e10adc3949ba59abbe56e057f20f883e', '孙斌', 38, 'sunbin@example.com', '13800138015', 'M', '大连市中山区人民路1号', 'https://example.com/avatars/15.jpg', '2023-08-15 12:25:00', 'editor'),
('zhoumin', 'e10adc3949ba59abbe56e057f20f883e', '周敏', 25, 'zhoumin@example.com', '13800138016', 'F', '宁波市鄞州区钱湖北路188号', 'https://example.com/avatars/16.jpg', '2023-08-16 13:30:00', 'user'),
('wugang', 'e10adc3949ba59abbe56e057f20f883e', '吴刚', 32, 'wugang@example.com', '13800138017', 'M', '青岛市市南区香港中路76号', 'https://example.com/avatars/17.jpg', '2023-08-17 14:35:00', 'user'),
('zhengli', 'e10adc3949ba59abbe56e057f20f883e', '郑丽', 27, 'zhengli@example.com', '13800138018', 'F', '厦门市思明区湖滨南路1号', 'https://example.com/avatars/18.jpg', '2023-08-18 15:40:00', 'admin'),
('lixiang', 'e10adc3949ba59abbe56e057f20f883e', '李想', 34, 'lixiang@example.com', '13800138019', 'M', '无锡市滨湖区太湖新城1号', 'https://example.com/avatars/19.jpg', '2023-08-19 16:45:00', 'editor'),
('wangjing', 'e10adc3949ba59abbe56e057f20f883e', '王静', 21, 'wangjing@example.com', '13800138020', 'F', '福州市鼓楼区五四路1号', 'https://example.com/avatars/20.jpg', '2023-08-20 17:50:00', 'user'),

-- 21-30
('zhangli', 'e10adc3949ba59abbe56e057f20f883e', '张力', 29, 'zhangli@example.com', '13800138021', 'M', '昆明市五华区东风西路1号', 'https://example.com/avatars/21.jpg', '2023-08-21 18:55:00', 'user'),
('liuqiang', 'e10adc3949ba59abbe56e057f20f883e', '刘强', 37, 'liuqiang@example.com', '13800138022', 'M', '哈尔滨市道里区中央大街1号', 'https://example.com/avatars/22.jpg', '2023-08-22 19:00:00', 'admin'),
('wanglan', 'e10adc3949ba59abbe56e057f20f883e', '王兰', 26, 'wanglan@example.com', '13800138023', 'F', '长春市朝阳区人民大街1号', 'https://example.com/avatars/23.jpg', '2023-08-23 20:05:00', 'editor'),
('zhaogang', 'e10adc3949ba59abbe56e057f20f883e', '赵刚', 33, 'zhaogang@example.com', '13800138024', 'M', '沈阳市和平区中山路1号', 'https://example.com/avatars/24.jpg', '2023-08-24 21:10:00', 'user'),
('sunyan', 'e10adc3949ba59abbe56e057f20f883e', '孙艳', 24, 'sunyan@example.com', '13800138025', 'F', '济南市历下区泺源大街1号', 'https://example.com/avatars/25.jpg', '2023-08-25 22:15:00', 'user'),
('zhouwei', 'e10adc3949ba59abbe56e057f20f883e', '周伟', 39, 'zhouwei@example.com', '13800138026', 'M', '南昌市东湖区阳明路1号', 'https://example.com/avatars/26.jpg', '2023-08-26 23:20:00', 'admin'),
('wumei', 'e10adc3949ba59abbe56e057f20f883e', '吴梅', 28, 'wumei@example.com', '13800138027', 'F', '南宁市青秀区民族大道1号', 'https://example.com/avatars/27.jpg', '2023-08-27 00:25:00', 'editor'),
('zhengqiang', 'e10adc3949ba59abbe56e057f20f883e', '郑强', 35, 'zhengqiang@example.com', '13800138028', 'M', '太原市小店区长风街1号', 'https://example.com/avatars/28.jpg', '2023-08-28 01:30:00', 'user'),
('lixue', 'e10adc3949ba59abbe56e057f20f883e', '李雪', 22, 'lixue@example.com', '13800138029', 'F', '贵阳市云岩区中华北路1号', 'https://example.com/avatars/29.jpg', '2023-08-29 02:35:00', 'user'),
('wangdong', 'e10adc3949ba59abbe56e057f20f883e', '王东', 30, 'wangdong@example.com', '13800138030', 'M', '兰州市城关区庆阳路1号', 'https://example.com/avatars/30.jpg', '2023-08-30 03:40:00', 'admin'),

-- 31-40
('zhanghong', 'e10adc3949ba59abbe56e057f20f883e', '张红', 27, 'zhanghong@example.com', '13800138031', 'F', '海口市龙华区滨海大道1号', 'https://example.com/avatars/31.jpg', '2023-08-31 04:45:00', 'editor'),
('liujun', 'e10adc3949ba59abbe56e057f20f883e', '刘军', 36, 'liujun@example.com', '13800138032', 'M', '乌鲁木齐市天山区人民路1号', 'https://example.com/avatars/32.jpg', '2023-09-01 05:50:00', 'user'),
('wangli', 'e10adc3949ba59abbe56e057f20f883e', '王丽', 25, 'wangli@example.com', '13800138033', 'F', '银川市兴庆区解放西街1号', 'https://example.com/avatars/33.jpg', '2023-09-02 06:55:00', 'user'),
('zhaojun', 'e10adc3949ba59abbe56e057f20f883e', '赵军', 34, 'zhaojun@example.com', '13800138034', 'M', '拉萨市城关区北京中路1号', 'https://example.com/avatars/34.jpg', '2023-09-03 07:00:00', 'admin'),
('sunli', 'e10adc3949ba59abbe56e057f20f883e', '孙丽', 23, 'sunli@example.com', '13800138035', 'F', '呼和浩特市新城区新华大街1号', 'https://example.com/avatars/35.jpg', '2023-09-04 08:05:00', 'editor'),
('zhouhong', 'e10adc3949ba59abbe56e057f20f883e', '周红', 40, 'zhouhong@example.com', '13800138036', 'F', '西宁市城中区西大街1号', 'https://example.com/avatars/36.jpg', '2023-09-05 09:10:00', 'user'),
('wudong', 'e10adc3949ba59abbe56e057f20f883e', '吴东', 29, 'wudong@example.com', '13800138037', 'M', '石家庄市长安区中山东路1号', 'https://example.com/avatars/37.jpg', '2023-09-06 10:15:00', 'user'),
('zhengfang', 'e10adc3949ba59abbe56e057f20f883e', '郑芳', 26, 'zhengfang@example.com', '13800138038', 'F', '合肥市蜀山区长江西路1号', 'https://example.com/avatars/38.jpg', '2023-09-07 11:20:00', 'admin'),
('lilei', 'e10adc3949ba59abbe56e057f20f883e', '李雷', 37, 'lilei@example.com', '13800138039', 'M', '太原市迎泽区迎泽大街1号', 'https://example.com/avatars/39.jpg', '2023-09-08 12:25:00', 'editor'),
('wanghong', 'e10adc3949ba59abbe56e057f20f883e', '王红', 24, 'wanghong@example.com', '13800138040', 'F', '烟台市芝罘区南大街1号', 'https://example.com/avatars/40.jpg', '2023-09-09 13:30:00', 'user'),

-- 41-50
('zhangjun', 'e10adc3949ba59abbe56e057f20f883e', '张军', 32, 'zhangjun@example.com', '13800138041', 'M', '温州市鹿城区车站大道1号', 'https://example.com/avatars/41.jpg', '2023-09-10 14:35:00', 'user'),
('liuyan', 'e10adc3949ba59abbe56e057f20f883e', '刘燕', 25, 'liuyan@example.com', '13800138042', 'F', '珠海市香洲区情侣中路1号', 'https://example.com/avatars/42.jpg', '2023-09-11 15:40:00', 'admin'),
('wangwei', 'e10adc3949ba59abbe56e057f20f883e', '王伟', 38, 'wangwei@example.com', '13800138043', 'M', '中山市石岐区中山路1号', 'https://example.com/avatars/43.jpg', '2023-09-12 16:45:00', 'editor'),
('zhaoyu', 'e10adc3949ba59abbe56e057f20f883e', '赵宇', 27, 'zhaoyu@example.com', '13800138044', 'M', '泉州市丰泽区津淮街1号', 'https://example.com/avatars/44.jpg', '2023-09-13 17:50:00', 'user'),
('sunwei', 'e10adc3949ba59abbe56e057f20f883e', '孙伟', 31, 'sunwei@example.com', '13800138045', 'M', '佛山市禅城区季华路1号', 'https://example.com/avatars/45.jpg', '2023-09-14 18:55:00', 'user'),
('zhouli', 'e10adc3949ba59abbe56e057f20f883e', '周丽', 26, 'zhouli@example.com', '13800138046', 'F', '东莞市南城区鸿福路1号', 'https://example.com/avatars/46.jpg', '2023-09-15 19:00:00', 'admin'),
('wuyu', 'e10adc3949ba59abbe56e057f20f883e', '吴宇', 33, 'wuyu@example.com', '13800138047', 'M', '惠州市惠城区江北文昌一路1号', 'https://example.com/avatars/47.jpg', '2023-09-16 20:05:00', 'editor'),
('zhengjun', 'e10adc3949ba59abbe56e057f20f883e', '郑军', 28, 'zhengjun@example.com', '13800138048', 'M', '江门市蓬江区建设路1号', 'https://example.com/avatars/48.jpg', '2023-09-17 21:10:00', 'user'),
('lifang', 'e10adc3949ba59abbe56e057f20f883e', '李芳', 35, 'lifang@example.com', '13800138049', 'F', '肇庆市端州区天宁北路1号', 'https://example.com/avatars/49.jpg', '2023-09-18 22:15:00', 'user'),
('wangyu', 'e10adc3949ba59abbe56e057f20f883e', '王宇', 24, 'wangyu@example.com', '13800138050', 'M', '汕头市金平区金砂路1号', 'https://example.com/avatars/50.jpg', '2023-09-19 23:20:00', 'admin');


/*
 * 密码安全说明：
 * 示例中使用的是MD5哈希，这仅用于演示目的
 * 实际项目中应该使用更安全的密码哈希算法如：
 * - bcrypt
 * - Argon2
 * - PBKDF2
 * 这些算法包含盐值(salt)和多次哈希迭代，能有效防止彩虹表攻击
 */