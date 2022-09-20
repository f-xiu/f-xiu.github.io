#演示检查约束

/*
1、作用：
限定某个字段值是否满足某个条件。

2、关键字：check 

3、特点：
（1）mysql8.0之前，mysql支持检查约束的语法，但是不起作用。
（2）mysql8中检查约束可以定义在字段后面，通常这个只限定单个字段的取值范围，
                 也可以定义在字段下面，通常会限定两个字段之前的取值条件。
（3）就算是定义在字段后面，虽然此时和其他字段没关系，也是当成表级约束对象，
在系统information_schema.table_constraints表中可以看到约束信息。
*/

#创建表格，限定age>=18
create table emp(
	id int primary key auto_increment,
	name varchar(20) not null,
	age int check(age>=18)
);

#mysql5.7上面运行
insert into emp values(null,'张三',8);

mysql> select * from emp;
+----+------+------+
| id | name | age  |
+----+------+------+
|  1 | 张三 |    8 | #mysql5.7检查约束没有起作用
+----+------+------+
1 row in set (0.00 sec)

#mysql8.0.26上面运行
mysql> insert into emp values(null,'张三',8);
ERROR 3819 (HY000): Check constraint 'emp_chk_1' is violated.

#在建表时，可以指定检查约束
create table 表名称(
	字段名1 数据类型 check(条件),  #在字段后面直接加检查约束
	字段名2 数据类型,
	字段名3 数据类型,
	check (条件)  #可以限定两个字段之间的取值条件
);

create table emp(
	id int primary key auto_increment,
	name varchar(20) not null,
	age int check(age>=18), #列级约束
	birthday date not null, #出生日期
	hiredate date not null, #入职日期
	check( year(hiredate)-year(birthday)>=18)  #year(hiredate)表示取出入职日期的年份值
);

#添加数据
insert into emp values(null,'张三',23,'2000-1-1','2021-11-30');#满足条件

mysql> select * from emp;
+----+------+------+------------+------------+
| id | name | age  | birthday   | hiredate   |
+----+------+------+------------+------------+
|  1 | 张三 |   23 | 2000-01-01 | 2021-11-30 |
+----+------+------+------------+------------+
1 row in set (0.00 sec)

#添加数据
insert into emp values(null,'张三',8,'2013-1-1','2021-11-30');#不满足条件

mysql> insert into emp values(null,'张三',8,'2013-1-1','2021-11-30');
ERROR 3819 (HY000): Check constraint 'emp_chk_1' is violated.

insert into emp values(null,'张三',28,'2013-1-1','2021-11-30');#不满足条件
mysql> insert into emp values(null,'张三',28,'2013-1-1','2021-11-30');#不满足条件
ERROR 3819 (HY000): Check constraint 'emp_chk_2' is violated.


#查看表结构
desc emp;

#查看表的定义
show create table emp;

mysql> show create table emp\G
*************************** 1. row ***************************
       Table: emp
Create Table: CREATE TABLE `emp` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(20) NOT NULL,
  `age` int DEFAULT NULL,
  `birthday` date NOT NULL,
  `hiredate` date NOT NULL,
  PRIMARY KEY (`id`),
  CONSTRAINT `emp_chk_1` CHECK ((`age` >= 18)),
  CONSTRAINT `emp_chk_2` CHECK (((year(`hiredate`) - year(`birthday`)) >= 18))
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci
1 row in set (0.00 sec)

#查询系统库中约束表查看表的约束
SELECT * FROM information_schema.table_constraints WHERE table_name = '表名称';

#查看emp表的约束
SELECT * FROM information_schema.table_constraints WHERE table_name = 'emp';
#只有主键、唯一键、外键、检查约束才能这个这个表中看到，默认值、非空这里是看不到。

mysql> SELECT * FROM information_schema.table_constraints WHERE table_name = 'emp';
+--------------------+-------------------+-----------------+--------------+------------+-----------------+----------+
| CONSTRAINT_CATALOG | CONSTRAINT_SCHEMA | CONSTRAINT_NAME | TABLE_SCHEMA | TABLE_NAME | CONSTRAINT_TYPE | ENFORCED |
+--------------------+-------------------+-----------------+--------------+------------+-----------------+----------+
| def                | atguigu           | PRIMARY         | atguigu      | emp        | PRIMARY KEY     | YES      |
| def                | atguigu           | emp_chk_1       | atguigu      | emp        | CHECK           | YES      |
| def                | atguigu           | emp_chk_2       | atguigu      | emp        | CHECK           | YES      |
+--------------------+-------------------+-----------------+--------------+------------+-----------------+----------+
3 rows in set (0.00 sec)

#如何删除检查约束
alter table 表名称 drop check 检查约束名;

#删除emp表的 age字段的检查约束 ‘emp_chk_1 ’
#删除emp表的 hiredate和birthday字段的检查约束 ‘emp_chk_2’

alter table emp drop check emp_chk_1;
alter table emp drop check emp_chk_2;

mysql> SELECT * FROM information_schema.table_constraints WHERE table_name = 'emp';
+--------------------+-------------------+-----------------+--------------+------------+-----------------+----------+
| CONSTRAINT_CATALOG | CONSTRAINT_SCHEMA | CONSTRAINT_NAME | TABLE_SCHEMA | TABLE_NAME | CONSTRAINT_TYPE | ENFORCED |
+--------------------+-------------------+-----------------+--------------+------------+-----------------+----------+
| def                | atguigu           | PRIMARY         | atguigu      | emp        | PRIMARY KEY     | YES      |
+--------------------+-------------------+-----------------+--------------+------------+-----------------+----------+
1 row in set (0.01 sec)

mysql> show create table emp\G
*************************** 1. row ***************************
       Table: emp
Create Table: CREATE TABLE `emp` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(20) NOT NULL,
  `age` int DEFAULT NULL,
  `birthday` date NOT NULL,
  `hiredate` date NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci
1 row in set (0.00 sec)

#如何在建表后添加检查约束
#使用modify？不起作用
alter table 表名称 modify 【column】 字段名 数据类型 check(条件); #列级约束
#给age字段添加检查约束 age>=18
alter table emp modify age int check(age>=18);#这里语法上没问题，但是没有真正起作用
insert into emp values(null,'李四',6,'1998-5-1','2021-1-2');#添加成功，说明检查约束没有起作用

#如何在建表后添加检查约束，使用add check
alter table 表名称 add check(条件);

#给age字段添加检查约束 age>=18
alter table emp add check(age>=18);

mysql> alter table emp add check(age>=18);
ERROR 3819 (HY000): Check constraint 'emp_chk_1' is violated.
#因为表中有违反  (age>=18)的数据，必须先处理


mysql> select * from emp;
+----+------+------+------------+------------+
| id | name | age  | birthday   | hiredate   |
+----+------+------+------------+------------+
|  1 | 张三 |   23 | 2000-01-01 | 2021-11-30 |
|  2 | 李四 |    6 | 1998-05-01 | 2021-01-02 |
+----+------+------+------------+------------+
2 rows in set (0.00 sec)

update emp set age = 26 where id = 2;

#给age字段添加检查约束 age>=18
alter table emp add check(age>=18);
insert into emp values(null,'李四',6,'1998-5-1','2021-1-2');



