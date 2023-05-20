# SSM_Springboot_Parking_billing
SSM校内车辆停车计费收费系统可升级SpringBoot毕业源码案例设计

## 前台框架： Bootstrap(一个HTML5响应式框架)

管理员主要是提供查询功能，也能管理用户

普通用户就相当于是个收费员（一个普通用户对应一个校门），登陆后的页面上显示当前时间，如果是车辆进入是页面显示车牌号和进入校园的时间；车辆离开时显示车牌号，进入校园的时间和离开时间，下方显示是否需要收费，如果是教职工车辆则显示剩余停车天数

普通用户基本没什么功能，主要是给普通用户看车辆信息

## 实体ER属性如下：
用户: 用户名,登录密码,姓名,性别,出生日期,用户照片,联系电话,邮箱,家庭地址,注册时间

职工车辆: 记录id,教职工姓名,教职工车牌,车辆图片,剩余停车天数,车辆描述

车辆进出: 记录id,车牌号,进入时间,进入校门,离开时间,离开校门,停车时长,是否收费,收费金额,备注信息

校车车辆: 记录id,车牌号,校车图片,车辆型号,购买日期,最近一次维修时间,车辆详情

新闻公告: 公告id,标题,公告内容,发布时间

## 后台框架: SSM(SpringMVC + Spring + Mybatis)
## 开发环境：myEclipse/Eclipse/Idea + mysql数据库