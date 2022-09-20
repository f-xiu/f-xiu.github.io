#演示和数据库相关的DDL语句
#查看当前登录用户（有权限）查看的所有的数据库
show databases;

#如何创建数据库
create database 数据库名称;

#例如，创建数据库bookstore
create database bookstore;

#查看数据库的定义
show create database 数据库名;

#例如，查看bookstore数据库的定义信息
show create database bookstore;
show create database bookstore\G

*************************** 1. row ***************************
       Database: bookstore
Create Database: CREATE DATABASE `bookstore` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci */ /*!80016 DEFAULT ENCRYPTION='N' */
1 row in set (0.00 sec)

#修改数据库的编码字符集和校对规则
alter database 数据库名称 CHARACTER SET 字符集名称 COLLATE 校对规则

#修改bookstore数据库的字符集和校对规则
alter database bookstore CHARACTER SET Latin1 COLLATE Latin1_general_ci;

mysql> show create database bookstore;
+-----------+-----------------------------------------------------------------------------------------------------------------------------------+
| Database  | Create Database                                                                                                                   |
+-----------+-----------------------------------------------------------------------------------------------------------------------------------+
| bookstore | CREATE DATABASE `bookstore` /*!40100 DEFAULT CHARACTER SET latin1 COLLATE latin1_general_ci */ /*!80016 DEFAULT ENCRYPTION='N' */ |
+-----------+-----------------------------------------------------------------------------------------------------------------------------------+
1 row in set (0.00 sec)


#使用数据库
use 数据库名;

#例如：使用bookstore数据库
use bookstore;

#创建表格
create table temp(
	s char
);

#添加数据
insert into temp values('a');

#查询数据
mysql> select * from temp;
+------+
| s    |
+------+
| a    |
+------+
1 row in set (0.00 sec)

#添加数据
insert into temp values('尚');

mysql> insert into temp values('尚');
ERROR 1366 (HY000): Incorrect string value: '\xC9\xD0' for column 's' at row 1


#删除数据库
drop database 数据库名称;

#例如：删除bookstore数据库
drop database bookstore;



