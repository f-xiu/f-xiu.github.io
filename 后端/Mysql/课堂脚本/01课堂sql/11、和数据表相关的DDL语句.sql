#演示和数据表相关的DDL语句
#为了方便接下来的演示，最好在前面确定针对哪个数据库的表格演示
#使用数据库
use atguigu;

#查看当前登录用户在本库下能够看到的所有表格
show tables;

#如果前面没有use语句，或者在当前use语句下，要查看另一个数据库的表格。
show tables from 数据库名;

#例如：查看当前数据库的表格
show tables;
#例如：在当前use atguigu;下面，查看mysql库的表格
show tables from mysql;

#创建表格
create table 表名称(
	字段名1 数据类型1,
	字段名2 数据类型2  #如果后面没有其他字段或约束的定义，后面就不用加,
);

#例如：创建一个teacher表
/*
包含编号、姓名、性别、出生日期、薪资、电话号码
*/
create table teacher(
	id int,
	name varchar(20),
	gender enum('男','女'),
	birthday date,
	salary double,
	tel varchar(11)
);

#查看表结构
desc 表名称;
describe 表名称;

#例如：查看teacher表的结构
desc teacher;
describe teacher;

mysql> describe teacher;
+----------+-----------------+------+-----+---------+-------+
| Field    | Type            | Null | Key | Default | Extra |
+----------+-----------------+------+-----+---------+-------+
| id       | int             | YES  |     | NULL    |       |
| name     | varchar(20)     | YES  |     | NULL    |       |
| gender   | enum('男','女') | YES  |     | NULL    |       |
| birthday | date            | YES  |     | NULL    |       |
| salary   | double          | YES  |     | NULL    |       |
| tel      | varchar(11)     | YES  |     | NULL    |       |
+----------+-----------------+------+-----+---------+-------+
6 rows in set (0.00 sec)

#查看表格的详细定义
show create table 表名称;

#例如：查看teacher表的定义语句
show create table teacher;

mysql> show create table teacher\G
*************************** 1. row ***************************
       Table: teacher
Create Table: CREATE TABLE `teacher` (
  `id` int DEFAULT NULL,
  `name` varchar(20) DEFAULT NULL,
  `gender` enum('男','女') DEFAULT NULL,
  `birthday` date DEFAULT NULL,
  `salary` double DEFAULT NULL,
  `tel` varchar(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci
1 row in set (0.00 sec)

#修改表结构
#增加一个字段
alter table 表名称 add column 字段名 数据类型;
#column表示列，字段，可以省略

#例如：给teacher表增加一个address varchar(100)字段
alter table teacher add column address varchar(100);

mysql> desc teacher;
+----------+-----------------+------+-----+---------+-------+
| Field    | Type            | Null | Key | Default | Extra |
+----------+-----------------+------+-----+---------+-------+
| id       | int             | YES  |     | NULL    |       |
| name     | varchar(20)     | YES  |     | NULL    |       |
| gender   | enum('男','女') | YES  |     | NULL    |       |
| birthday | date            | YES  |     | NULL    |       |
| salary   | double          | YES  |     | NULL    |       |
| tel      | varchar(11)     | YES  |     | NULL    |       |
| address  | varchar(100)    | YES  |     | NULL    |       |
+----------+-----------------+------+-----+---------+-------+
7 rows in set (0.00 sec)


#在某个字段后面增加一个字段
alter table 表名称 add column 字段名 数据类型 after 另一个字段;
#column表示列，字段，可以省略

#例如：给teacher表增加一个cardid char(18)字段，增加到name后面
alter table teacher add column cardid char(18) after name;

mysql> desc teacher;
+----------+-----------------+------+-----+---------+-------+
| Field    | Type            | Null | Key | Default | Extra |
+----------+-----------------+------+-----+---------+-------+
| id       | int             | YES  |     | NULL    |       |
| name     | varchar(20)     | YES  |     | NULL    |       |
| cardid   | char(18)        | YES  |     | NULL    |       |
| gender   | enum('男','女') | YES  |     | NULL    |       |
| birthday | date            | YES  |     | NULL    |       |
| salary   | double          | YES  |     | NULL    |       |
| tel      | varchar(11)     | YES  |     | NULL    |       |
| address  | varchar(100)    | YES  |     | NULL    |       |
+----------+-----------------+------+-----+---------+-------+
8 rows in set (0.00 sec)

#增加一个字段，称为第一个字段
alter table 表名称 add column 字段名 数据类型 first;
#column表示列，字段，可以省略

#例如：给teacher表增加一个age int字段，增加到id前面
alter table teacher add column age int first;

mysql> desc teacher;
+----------+-----------------+------+-----+---------+-------+
| Field    | Type            | Null | Key | Default | Extra |
+----------+-----------------+------+-----+---------+-------+
| age      | int             | YES  |     | NULL    |       |
| id       | int             | YES  |     | NULL    |       |
| name     | varchar(20)     | YES  |     | NULL    |       |
| cardid   | char(18)        | YES  |     | NULL    |       |
| gender   | enum('男','女') | YES  |     | NULL    |       |
| birthday | date            | YES  |     | NULL    |       |
| salary   | double          | YES  |     | NULL    |       |
| tel      | varchar(11)     | YES  |     | NULL    |       |
| address  | varchar(100)    | YES  |     | NULL    |       |
+----------+-----------------+------+-----+---------+-------+
9 rows in set (0.01 sec)


#删除字段
alter table 表名称 drop column 字段名;
#column可以省略

#例如：删除teacher表的age字段
alter table teacher drop column age;

mysql> desc teacher;
+----------+-----------------+------+-----+---------+-------+
| Field    | Type            | Null | Key | Default | Extra |
+----------+-----------------+------+-----+---------+-------+
| id       | int             | YES  |     | NULL    |       |
| name     | varchar(20)     | YES  |     | NULL    |       |
| cardid   | char(18)        | YES  |     | NULL    |       |
| gender   | enum('男','女') | YES  |     | NULL    |       |
| birthday | date            | YES  |     | NULL    |       |
| salary   | double          | YES  |     | NULL    |       |
| tel      | varchar(11)     | YES  |     | NULL    |       |
| address  | varchar(100)    | YES  |     | NULL    |       |
+----------+-----------------+------+-----+---------+-------+
8 rows in set (0.00 sec)

#修改字段的数据类型
alter table 表名称 modify column 字段名 新的数据类型;

#例如：修改teacher表的salary字段，数据类型修改为double(10,2)
alter table teacher modify column salary double(10,2);

mysql> desc teacher;
+----------+-----------------+------+-----+---------+-------+
| Field    | Type            | Null | Key | Default | Extra |
+----------+-----------------+------+-----+---------+-------+
| id       | int             | YES  |     | NULL    |       |
| name     | varchar(20)     | YES  |     | NULL    |       |
| cardid   | char(18)        | YES  |     | NULL    |       |
| gender   | enum('男','女') | YES  |     | NULL    |       |
| birthday | date            | YES  |     | NULL    |       |
| salary   | double(10,2)    | YES  |     | NULL    |       |
| tel      | varchar(11)     | YES  |     | NULL    |       |
| address  | varchar(100)    | YES  |     | NULL    |       |
+----------+-----------------+------+-----+---------+-------+
8 rows in set (0.00 sec)

#修改字段的名称
alter table 表名称 change column 旧字段名 新的字段名 数据类型;

#例如：修改teacher表的tel字段，字段名修改为telphone
alter table teacher change column tel telphone char(18);

mysql> desc teacher;
+----------+-----------------+------+-----+---------+-------+
| Field    | Type            | Null | Key | Default | Extra |
+----------+-----------------+------+-----+---------+-------+
| id       | int             | YES  |     | NULL    |       |
| name     | varchar(20)     | YES  |     | NULL    |       |
| cardid   | char(18)        | YES  |     | NULL    |       |
| gender   | enum('男','女') | YES  |     | NULL    |       |
| birthday | date            | YES  |     | NULL    |       |
| salary   | double(10,2)    | YES  |     | NULL    |       |
| telphone | char(18)        | YES  |     | NULL    |       |
| address  | varchar(100)    | YES  |     | NULL    |       |
+----------+-----------------+------+-----+---------+-------+
8 rows in set (0.01 sec)

#修改字段的顺序
alter table 表名称 modify column 字段名 数据类型 after 另一个字段;
alter table 表名称 modify column 字段名 数据类型 first;

#例如，把teacher表的salary调整到telphone后面
alter table teacher modify column salary double(10,2) after telphone;

mysql> desc teacher;
+----------+-----------------+------+-----+---------+-------+
| Field    | Type            | Null | Key | Default | Extra |
+----------+-----------------+------+-----+---------+-------+
| id       | int             | YES  |     | NULL    |       |
| name     | varchar(20)     | YES  |     | NULL    |       |
| cardid   | char(18)        | YES  |     | NULL    |       |
| gender   | enum('男','女') | YES  |     | NULL    |       |
| birthday | date            | YES  |     | NULL    |       |
| telphone | char(18)        | YES  |     | NULL    |       |
| salary   | double(10,2)    | YES  |     | NULL    |       |
| address  | varchar(100)    | YES  |     | NULL    |       |
+----------+-----------------+------+-----+---------+-------+
8 rows in set (0.00 sec)


#修改表名称
rename table 旧表名称 to 新表名称;
alter table 表名称 rename 新表名称;


#把teacher表重命名为jiaoshi
rename table teacher to jiaoshi;

#把jiaoshi表重命名为teacher
alter table jiaoshi rename teacher;


#删除表结构（数据一并删除）
drop table 表名称;

#删除teacher表格
drop table teacher;

create database tempdb;

show create database tempdb;

alter database tempdb CHARACTER SET Latin1 COLLATE Latin1_general_ci;

use tempdb;

create table teacher(
	id int,
	name varchar(20),
	gender enum('男','女'),
	birthday date,
	salary double,
	tel varchar(11)
);
ERROR 1291 (HY000): Column 'gender' has duplicated value '?' in ENUM

create table teacher(
	id int,
	name varchar(20),
	gender enum('m','f'),
	birthday date,
	salary double,
	tel varchar(11)
);

show create table teacher\G

mysql> show create table teacher\G
*************************** 1. row ***************************
       Table: teacher
Create Table: CREATE TABLE `teacher` (
  `id` int DEFAULT NULL,
  `name` varchar(20) COLLATE latin1_general_ci DEFAULT NULL,
  `gender` enum('m','f') COLLATE latin1_general_ci DEFAULT NULL,
  `birthday` date DEFAULT NULL,
  `salary` double DEFAULT NULL,
  `tel` varchar(11) COLLATE latin1_general_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_general_ci
1 row in set (0.01 sec)

alter database tempdb CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci;

#修改表的字符集和校对规则
alter table 表名称 CHARACTER SET 字符集名称 COLLATE 校对规则

#例如，修改teacher表的字符集和校对规则
alter table teacher CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci;

#修改字段字符集和校对规则
alter table 表名称 modify column 字段名 数据类型 
CHARACTER SET 字符集名称 COLLATE 校对规则;

#例如：修改teacher表的name字段字符集和校对规则
alter table teacher modify column name varchar(20)
 CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci;

alter table teacher modify column gender enum('m','f')
 CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci; 

alter table teacher modify column tel char(18)
 CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci; 

 