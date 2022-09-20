#演示自增属性
/*
1、作用：给某个字段自动赋值，这个值是一直往上增加，
如果没有特意干扰的，每次自增1.

2、关键字：auto_increment

3、要求
（1）一个表只能有一个自增字段，因为一个表只有一个AUTO_INCREMENT属性记录自增字段值
（2）并且自增字段只能是key字段，即定义了主键、唯一键等键约束的字段。
一般都是给主键和唯一键加自增。
（3）自增字段应该是数值类型，一般都是整数类型。
（4）AUTO_INCREMENT属性值 必须 > 当前自增字段的最大值
*/

#创建表
create table emp(
	eid int auto_increment,
	ename varchar(20)
);

mysql> create table emp(
    ->  eid int auto_increment,
    ->  ename varchar(20)
    -> );
ERROR 1075 (42000): Incorrect table definition; 
there can be only one auto column and it must be defined as a key


create table emp(
	eid int primary key auto_increment,
	ename varchar(20)
);

#添加数据
insert into emp(ename) values('李四');#不给自增字段指定值，也是自增
insert into emp values(null,'张三'); #给自增字段赋值NULL，也是自增

mysql> select * from emp;
+-----+-------+
| eid | ename |
+-----+-------+
|   1 | 李四  |
|   2 | 张三  |
+-----+-------+
2 rows in set (0.00 sec)

insert into emp values(0,'王五'); #给自增字段赋值0，也是自增

mysql> select * from emp;
+-----+-------+
| eid | ename |
+-----+-------+
|   1 | 李四  |
|   2 | 张三  |
|   3 | 王五  |
+-----+-------+
3 rows in set (0.00 sec)


insert into emp values(-5,'王五'); #给自增字段赋值-5（<3)

mysql> select * from emp;
+-----+-------+
| eid | ename |
+-----+-------+
|  -5 | 王五  |
|   1 | 李四  |
|   2 | 张三  |
|   3 | 王五  |
+-----+-------+
4 rows in set (0.00 sec)

insert into emp values(null,'赵六');

mysql> select * from emp;
+-----+-------+
| eid | ename |
+-----+-------+
|  -5 | 王五  |
|   1 | 李四  |
|   2 | 张三  |
|   3 | 王五  |
|   4 | 赵六  |
+-----+-------+
5 rows in set (0.00 sec)

#查看表定义
show create table emp;

mysql> show create table emp\G
*************************** 1. row ***************************
       Table: emp
Create Table: CREATE TABLE `emp` (
  `eid` int NOT NULL AUTO_INCREMENT,
  `ename` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`eid`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci
1 row in set (0.00 sec)


insert into emp values(15, '柴');#给自增字段赋值15（>5）

mysql> select * from emp;
+-----+-------+
| eid | ename |
+-----+-------+
|  -5 | 王五  |
|   1 | 李四  |
|   2 | 张三  |
|   3 | 王五  |
|   4 | 赵六  |
|  15 | 柴    |
+-----+-------+
6 rows in set (0.00 sec)

mysql> show create table emp\G
*************************** 1. row ***************************
       Table: emp
Create Table: CREATE TABLE `emp` (
  `eid` int NOT NULL AUTO_INCREMENT,
  `ename` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`eid`)
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci
1 row in set (0.00 sec)

#结论：当手动给自增字段赋值时，
#如果这个值大于当前“AUTO_INCREMENT”属性记录的自增值时，会修改“AUTO_INCREMENT”属性值，
#下次就从这个值基础上自增



insert into emp values(7, '宋');#给自增字段赋值7（<16）


mysql> select * from emp;
+-----+-------+
| eid | ename |
+-----+-------+
|  -5 | 王五  |
|   1 | 李四  |
|   2 | 张三  |
|   3 | 王五  |
|   4 | 赵六  |
|   7 | 宋    |
|  15 | 柴    |
+-----+-------+
7 rows in set (0.00 sec)


mysql> show create table emp\G
*************************** 1. row ***************************
       Table: emp
Create Table: CREATE TABLE `emp` (
  `eid` int NOT NULL AUTO_INCREMENT,
  `ename` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`eid`)
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci
1 row in set (0.00 sec)

#建议大家实际开发中，不要随意修改“AUTO_INCREMENT”的值，让他自动维护。


#修改“AUTO_INCREMENT”的值
alter table 表名称 AUTO_INCREMENT = 新值;

#修改emp表AUTO_INCREMENT值为18
alter table emp AUTO_INCREMENT = 18;


mysql> show create table emp\G
*************************** 1. row ***************************
       Table: emp
Create Table: CREATE TABLE `emp` (
  `eid` int NOT NULL AUTO_INCREMENT,
  `ename` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`eid`)
) ENGINE=InnoDB AUTO_INCREMENT=18 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci
1 row in set (0.00 sec)

#修改emp表AUTO_INCREMENT值为8
alter table emp AUTO_INCREMENT = 8;

mysql> show create table emp\G
*************************** 1. row ***************************
       Table: emp
Create Table: CREATE TABLE `emp` (
  `eid` int NOT NULL AUTO_INCREMENT,
  `ename` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`eid`)
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci
1 row in set (0.00 sec)

#结论，无论是insert语句还是alter语句，AUTO_INCREMENT值都不能修改为<当前自增字段最大的值。


#删除自增属性
alter table 表名称 modify 【column】 字段名 数据类型;

#查看表结构
desc emp;
mysql> desc emp;
+-------+-------------+------+-----+---------+----------------+
| Field | Type        | Null | Key | Default | Extra          |
+-------+-------------+------+-----+---------+----------------+
| eid   | int         | NO   | PRI | NULL    | auto_increment |
| ename | varchar(20) | YES  |     | NULL    |                |
+-------+-------------+------+-----+---------+----------------+
2 rows in set (0.01 sec)

#删除eid字段的自增属性
alter table emp modify column eid int;

mysql> desc emp;
+-------+-------------+------+-----+---------+-------+
| Field | Type        | Null | Key | Default | Extra |
+-------+-------------+------+-----+---------+-------+
| eid   | int         | NO   | PRI | NULL    |       |
| ename | varchar(20) | YES  |     | NULL    |       |
+-------+-------------+------+-----+---------+-------+
2 rows in set (0.00 sec)

#modify会影响列级约束，默认值、非空等约束，表级约束（主键、唯一键）不受影响。

#建表后添加自增属性
alter table 表名称 modify 【column】 字段名 数据类型 auto_increment;

#给eid字段的添加自增属性
alter table emp modify column eid int auto_increment;

mysql> desc emp;
+-------+-------------+------+-----+---------+----------------+
| Field | Type        | Null | Key | Default | Extra          |
+-------+-------------+------+-----+---------+----------------+
| eid   | int         | NO   | PRI | NULL    | auto_increment |
| ename | varchar(20) | YES  |     | NULL    |                |
+-------+-------------+------+-----+---------+----------------+
2 rows in set (0.00 sec)