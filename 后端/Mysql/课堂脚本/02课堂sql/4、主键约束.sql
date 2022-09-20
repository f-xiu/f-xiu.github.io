#演示主键约束
/*
1、作用：
主键约束是用来唯一的标识一行记录，
或者换句话说，表中不允许出现两条无法区分的记录。

问？唯一键约束不就可以实现吗？
答：唯一键约束因为没有限定非空，可能出现两个NULL。

学号  姓名  身份证号码（唯一键）
1	  张三  524265198235684255
2	  李四  524265198235684266
3	  王五  NULL
3	  王五  NULL

2、关键字：primary key
3、特点
（1）每一个表最多只能定义一个主键约束。
（2）主键约束，既要求唯一又要求非空
可以看成 主键约束 = 非空约束 + 唯一键约束
但不完全等价。

4、唯一键约束和主键约束的区别
（1）唯一键约束一个表可以有好几个，
但是主键约束只有一个
（2）唯一键约束本身不带非空限制，如果需要非空，需要单独定义。
主键约束不用再定义NOT NULL，自身就带非空限制。
*/

#建表时，指定主键约束
create table 表名称(
	字段名 数据类型 primary key,
	字段名 数据类型 not null,
	字段名 数据类型 not null unique key,
	字段名 数据类型 not null unique key,
	字段名 数据类型 unique key,
	字段名 数据类型 unique key
	字段名 数据类型
);

create table 表名称(
	字段名 数据类型 ,
	字段名 数据类型 not null,
	字段名 数据类型 not null unique key,
	字段名 数据类型 not null unique key,
	字段名 数据类型 unique key,
	字段名 数据类型 unique key
	字段名 数据类型,
	primary key(字段名),
	unique key(字段名)
);

mysql> drop database atguigu;
Query OK, 19 rows affected (0.17 sec)

mysql> create database atguigu;
Query OK, 1 row affected (0.01 sec)

mysql> use atguigu;
Database changed

#创建员工表
create table emp(
	id int primary key,
	ename varchar(20) not null,
	cardid char(18) unique key not null, #非空并且唯一
	tel char(11) unique key, #只是唯一，可以为空
	address varchar(100) #既可以为null，又可以重复
);

#查看表结构
desc emp;

mysql> desc emp;
+---------+--------------+------+-----+---------+-------+
| Field   | Type         | Null | Key | Default | Extra |
+---------+--------------+------+-----+---------+-------+
| id      | int          | NO   | PRI | NULL    |       |
| ename   | varchar(20)  | NO   |     | NULL    |       |
| cardid  | char(18)     | NO   | UNI | NULL    |       |
| tel     | char(11)     | YES  | UNI | NULL    |       |
| address | varchar(100) | YES  |     | NULL    |       |
+---------+--------------+------+-----+---------+-------+
5 rows in set (0.01 sec)

#添加数据
insert into emp 
values(1,'张三','524265198235684255','18536955456',null);

#添加数据
insert into emp 
values(2,'李四','524265198235685255',null,null);#tel可以为null

mysql> select * from emp;
+----+-------+--------------------+-------------+---------+
| id | ename | cardid             | tel         | address |
+----+-------+--------------------+-------------+---------+
|  1 | 张三  | 524265198235684255 | 18536955456 | NULL    |
|  2 | 李四  | 524265198235685255 | NULL        | NULL    |
+----+-------+--------------------+-------------+---------+
2 rows in set (0.00 sec)

#添加数据
insert into emp 
values(3,'李四','524265198235685895',null,null);

#添加数据
insert into emp 
values(3,'王五','524265198235675895',null,null);#主键重复

mysql> #添加数据
mysql> insert into emp
    -> values(3,'王五','524265198235675895',null,null);#主键重复
ERROR 1062 (23000): Duplicate entry '3' for key 'emp.PRIMARY'


#添加数据
insert into emp 
values(null,'王五','524265198235675775',null,null);#主键为null

mysql> insert into emp
    -> values(null,'王五','524265198235675775',null,null);#主键为null
ERROR 1048 (23000): Column 'id' cannot be null


#创建一个表，两个字段设置主键
create table xuanke(
	sid int primary key,
	cid int primary key,
	score int
);

mysql> create table xuanke(
    ->  sid int primary key,  #定义两个主键，不是复合主键的意思
    ->  cid int primary key,  #定义两个主键，不是复合主键的意思
    ->  score int
    ->
    -> );
ERROR 1068 (42000): Multiple primary key defined

#组合主键约束
#学生表
create table stu(
	id int,
	name varchar(20)
);

#添加学生信息
insert into stu values(1,'张三');
insert into stu values(2,'李四');

mysql> select * from stu;
+------+------+
| id   | name |
+------+------+
|    1 | 张三 |
|    2 | 李四 |
+------+------+
2 rows in set (0.00 sec)

#课程表
create table course(
	id int,
	title varchar(50)
);

#添加课程信息
insert into course values(1,'java');
insert into course values(2,'mysql');

mysql> select * from course;
+------+-------+
| id   | title |
+------+-------+
|    1 | java  |
|    2 | mysql |
+------+-------+
2 rows in set (0.00 sec)

#定义选课表
create table xuanke(
	sid int,
	cid int,
	score int,
	primary key(sid,cid)  #组合/复合主键
);

insert into xuanke values(1,1,96),(2,1,85),(1,2,75),(2,2,45);

#添加重复主键报错
insert into xuanke values(1,1,75);
mysql> insert into xuanke values(1,1,75);
ERROR 1062 (23000): Duplicate entry '1-1' for key 'xuanke.PRIMARY'


#查看一下表的定义
show create table emp;
show create table xuanke;

#查看emp表和xuanke表的索引
show index from emp;
show index from xuanke;

mysql> show index from emp;
+-------+------------+----------+--------------+-------------+-----------+-------------+----------+--------+------+------------+---------+---------------+---------+------------+
| Table | Non_unique | Key_name | Seq_in_index | Column_name | Collation | Cardinality | Sub_part | Packed | Null | Index_type | Comment | Index_comment | Visible | Expression |
+-------+------------+----------+--------------+-------------+-----------+-------------+----------+--------+------+------------+---------+---------------+---------+------------+
| emp   |          0 | PRIMARY  |            1 | id          | A         |           2 |     NULL |   NULL |      | BTREE      |         |               | YES     | NULL       |
| emp   |          0 | cardid   |            1 | cardid      | A         |           2 |     NULL |   NULL |      | BTREE      |         |               | YES     | NULL       |
| emp   |          0 | tel      |            1 | tel         | A         |           2 |     NULL |   NULL | YES  | BTREE      |         |               | YES     | NULL       |
+-------+------------+----------+--------------+-------------+-----------+-------------+----------+--------+------+------------+---------+---------------+---------+------------+
3 rows in set (0.01 sec)

mysql> show index from xuanke;
+--------+------------+----------+--------------+-------------+-----------+-------------+----------+--------+------+------------+---------+---------------+---------+------------+
| Table  | Non_unique | Key_name | Seq_in_index | Column_name | Collation | Cardinality | Sub_part | Packed | Null | Index_type | Comment | Index_comment | Visible | Expression |
+--------+------------+----------+--------------+-------------+-----------+-------------+----------+--------+------+------------+---------+---------------+---------+------------+
| xuanke |          0 | PRIMARY  |            1 | sid         | A         |           2 |     NULL |   NULL |      | BTREE      |         |               | YES     | NULL       |
| xuanke |          0 | PRIMARY  |            2 | cid         | A         |           4 |     NULL |   NULL |      | BTREE      |         |               | YES     | NULL       |
+--------+------------+----------+--------------+-------------+-----------+-------------+----------+--------+------+------------+---------+---------------+---------+------------+
2 rows in set (0.01 sec)

#是否可以删除主键约束
alter table 表名称 drop primary key;
#因为一个表只有一个唯一键约束，所以不用特意指定名字。

#删除xuanke表的主键约束
alter table xuanke drop primary key;

mysql> show index from xuanke;
Empty set (0.00 sec)

mysql> desc xuanke;
+-------+------+------+-----+---------+-------+
| Field | Type | Null | Key | Default | Extra |
+-------+------+------+-----+---------+-------+
| sid   | int  | NO   |     | NULL    |       |
| cid   | int  | NO   |     | NULL    |       |
| score | int  | YES  |     | NULL    |       |
+-------+------+------+-----+---------+-------+
3 rows in set (0.00 sec)

#删除主键约束时，对应的索引，键约束删除了，但是主键约束自带的非空约束没有删除。
#如果要去掉的话，需要用删除非空约束的方式，单独删除。

#建表后增加主键约束
alter table 表名称 add primary key(字段名); #表示给1个字段增加主键约束
alter table 表名称 add primary key(字段名1,字段名2); #表示增加的是复合主键

alter table xuanke add primary key(sid,cid);

mysql> desc xuanke;
+-------+------+------+-----+---------+-------+
| Field | Type | Null | Key | Default | Extra |
+-------+------+------+-----+---------+-------+
| sid   | int  | NO   | PRI | NULL    |       |
| cid   | int  | NO   | PRI | NULL    |       |
| score | int  | YES  |     | NULL    |       |
+-------+------+------+-----+---------+-------+
3 rows in set (0.01 sec)

#删除emp的主键约束
alter table emp drop primary key;

mysql> desc emp;
+---------+--------------+------+-----+---------+-------+
| Field   | Type         | Null | Key | Default | Extra |
+---------+--------------+------+-----+---------+-------+
| id      | int          | NO   |     | NULL    |       |
| ename   | varchar(20)  | NO   |     | NULL    |       |
| cardid  | char(18)     | NO   | PRI | NULL    |       | #自动把cardid识别为主键，因为cardid定义了唯一键+非空约束，但是不同于真正的主键
| tel     | char(11)     | YES  | UNI | NULL    |       |
| address | varchar(100) | YES  |     | NULL    |       |
+---------+--------------+------+-----+---------+-------+
5 rows in set (0.01 sec)

show index from emp;

mysql> show index from emp;
+-------+------------+----------+--------------+-------------+-----------+-------------+----------+--------+------+------------+---------+---------------+---------+------------+
| Table | Non_unique | Key_name | Seq_in_index | Column_name | Collation | Cardinality | Sub_part | Packed | Null | Index_type | Comment | Index_comment | Visible | Expression |
+-------+------------+----------+--------------+-------------+-----------+-------------+----------+--------+------+------------+---------+---------------+---------+------------+
| emp   |          0 | cardid   |            1 | cardid      | A         |           2 |     NULL |   NULL |      | BTREE      |         |               | YES     | NULL       |
| emp   |          0 | tel      |            1 | tel         | A         |           2 |     NULL |   NULL | YES  | BTREE      |         |               | YES     | NULL       |
+-------+------------+----------+--------------+-------------+-----------+-------------+----------+--------+------+------------+---------+---------------+---------+------------+
2 rows in set (0.00 sec)

#给emp表的id字段增加主键约束
alter table emp add primary key(id);

mysql> show index from emp;
+-------+------------+----------+--------------+-------------+-----------+-------------+----------+--------+------+------------+---------+---------------+---------+------------+
| Table | Non_unique | Key_name | Seq_in_index | Column_name | Collation | Cardinality | Sub_part | Packed | Null | Index_type | Comment | Index_comment | Visible | Expression |
+-------+------------+----------+--------------+-------------+-----------+-------------+----------+--------+------+------------+---------+---------------+---------+------------+
| emp   |          0 | PRIMARY  |            1 | id          | A         |           2 |     NULL |   NULL |      | BTREE      |         |               | YES     | NULL       |
| emp   |          0 | cardid   |            1 | cardid      | A         |           2 |     NULL |   NULL |      | BTREE      |         |               | YES     | NULL       |
| emp   |          0 | tel      |            1 | tel         | A         |           2 |     NULL |   NULL | YES  | BTREE      |         |               | YES     | NULL       |
+-------+------------+----------+--------------+-------------+-----------+-------------+----------+--------+------+------------+---------+---------------+---------+------------+
3 rows in set (0.00 sec)


#学生问，删除主键约束，可以重复吗？答：是的
alter table emp drop primary key;
mysql> select * from emp;
+----+-------+--------------------+-------------+---------+
| id | ename | cardid             | tel         | address |
+----+-------+--------------------+-------------+---------+
|  1 | 张三  | 524265198235684255 | 18536955456 | NULL    |
|  2 | 李四  | 524265198235685255 | NULL        | NULL    |
|  3 | 李四  | 524265198235685895 | NULL        | NULL    |
+----+-------+--------------------+-------------+---------+
3 rows in set (0.00 sec)

insert into emp values(3,'王五','524233198235685895',null,null);
mysql> select * from emp;
+----+-------+--------------------+-------------+---------+
| id | ename | cardid             | tel         | address |
+----+-------+--------------------+-------------+---------+
|  3 | 王五  | 524233198235685895 | NULL        | NULL    |
|  1 | 张三  | 524265198235684255 | 18536955456 | NULL    |
|  2 | 李四  | 524265198235685255 | NULL        | NULL    |
|  3 | 李四  | 524265198235685895 | NULL        | NULL    |
+----+-------+--------------------+-------------+---------+
4 rows in set (0.00 sec)
