/*演示唯一键约束
1、作用：限定某个字段的值不允许重复。
但是如果是NULL值可以重复。

2、关键字：unique key 其中key可以省略

3、特点
一个表可以有很多个唯一键约束，
每一个唯一键约束字段都会自动创建索引。
*/

#在建表时，可以指定唯一键约束
create table 表名称(
	字段名 数据类型 unique key,  #unique key可以直接加在字段后面
	字段名 数据类型 unique key,
	字段名 数据类型
);

create table 表名称(
	字段名 数据类型,
	字段名 数据类型,
	字段名 数据类型,
	unique key(字段名), #unique key也可以在字段列表下面单独定义
	unique key(字段名)
);

#创建一个表格，限定编号、身份证号码和手机号码唯一
create table emp(
	id int unique key,  #表示id字段值不能重复
	name varchar(20),
	cardid char(18),
	tel char(11),
	unique key(cardid),  #表示cardid字段值不能重复
	unique key(tel)  #表示tel字段值不能重复
);

#查看表结构
desc emp;
mysql> desc emp;
+--------+-------------+------+-----+---------+-------+
| Field  | Type        | Null | Key | Default | Extra |
+--------+-------------+------+-----+---------+-------+
| id     | int         | YES  | UNI | NULL    |       |
| name   | varchar(20) | YES  |     | NULL    |       |
| cardid | char(18)    | YES  | UNI | NULL    |       |
| tel    | char(11)    | YES  | UNI | NULL    |       |
+--------+-------------+------+-----+---------+-------+
4 rows in set (0.01 sec)

#查看表的定义语句
show create table emp;

mysql> show create table emp\G
*************************** 1. row ***************************
       Table: emp
Create Table: CREATE TABLE `emp` (
  `id` int DEFAULT NULL,
  `name` varchar(20) DEFAULT NULL,
  `cardid` char(18) DEFAULT NULL,
  `tel` char(11) DEFAULT NULL,
  UNIQUE KEY `id` (`id`),
  UNIQUE KEY `cardid` (`cardid`),
  UNIQUE KEY `tel` (`tel`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci
1 row in set (0.00 sec)

#添加数据
insert into emp values(1,'张三','25678544522222','13589587585');
insert into emp values(2,'张三','25678544522211','13589587596');

#查询数据
select * from emp;

insert into emp values(3,'李四','25678544522233','13589587596');
#手机号码重复，报错

mysql> insert into emp values(3,'李四','25678544522233','13589587596');
ERROR 1062 (23000): Duplicate（复制、重复） entry（输入） '13589587596' for key 'emp.tel'


insert into emp values
(3,'李四',null,null),
(4,'王五',null,null);

mysql> select * from emp;
+------+------+----------------+-------------+
| id   | name | cardid         | tel         |
+------+------+----------------+-------------+
|    1 | 张三 | 25678544522222 | 13589587585 |
|    2 | 张三 | 25678544522211 | 13589587596 |
|    3 | 李四 | NULL           | NULL        | #NULL可以重复
|    4 | 王五 | NULL           | NULL        |
+------+------+----------------+-------------+
4 rows in set (0.00 sec)


#如何查看一个表的索引
show index from 表名称;

#查看emp表的索引
show index from emp;

mysql> show index from emp;
+-------+------------+----------+--------------+-------------+-----------+-------------+----------+--------+------+------------+---------+---------------+---------+------------+
| Table | Non_unique | Key_name | Seq_in_index | Column_name | Collation | Cardinality | Sub_part | Packed | Null | Index_type | Comment | Index_comment | Visible | Expression |
+-------+------------+----------+--------------+-------------+-----------+-------------+----------+--------+------+------------+---------+---------------+---------+------------+
| emp   |          0 | id       |            1 | id          | A         |           4 |     NULL |   NULL | YES  | BTREE      |         |               | YES     | NULL       |
| emp   |          0 | cardid   |            1 | cardid      | A         |           3 |     NULL |   NULL | YES  | BTREE      |         |               | YES     | NULL       |
| emp   |          0 | tel      |            1 | tel         | A         |           3 |     NULL |   NULL | YES  | BTREE      |         |               | YES     | NULL       |
+-------+------------+----------+--------------+-------------+-----------+-------------+----------+--------+------+------------+---------+---------------+---------+------------+
3 rows in set (0.00 sec)

#删除唯一键约束
alter table 表名称 drop index 索引名;
#如果在指定唯一键约束时，没有手动定义名字，默认就是字段名;
#建议大家在删除时用show index语句查看一下索引名

#删除emp表的cardid的唯一键约束
alter table emp drop index cardid;

mysql> show index from emp;
+-------+------------+----------+--------------+-------------+-----------+-------------+----------+--------+------+------------+---------+---------------+---------+------------+
| Table | Non_unique | Key_name | Seq_in_index | Column_name | Collation | Cardinality | Sub_part | Packed | Null | Index_type | Comment | Index_comment | Visible | Expression |
+-------+------------+----------+--------------+-------------+-----------+-------------+----------+--------+------+------------+---------+---------------+---------+------------+
| emp   |          0 | id       |            1 | id          | A         |           4 |     NULL |   NULL | YES  | BTREE      |         |               | YES     | NULL       |
| emp   |          0 | tel      |            1 | tel         | A         |           3 |     NULL |   NULL | YES  | BTREE      |         |               | YES     | NULL       |
+-------+------------+----------+--------------+-------------+-----------+-------------+----------+--------+------+------------+---------+---------------+---------+------------+
2 rows in set (0.01 sec)

mysql> desc emp;
+--------+-------------+------+-----+---------+-------+
| Field  | Type        | Null | Key | Default | Extra |
+--------+-------------+------+-----+---------+-------+
| id     | int         | YES  | UNI | NULL    |       |
| name   | varchar(20) | YES  |     | NULL    |       |
| cardid | char(18)    | YES  |     | NULL    |       |
| tel    | char(11)    | YES  | UNI | NULL    |       |
+--------+-------------+------+-----+---------+-------+
4 rows in set (0.00 sec)

#如何在建表后添加唯一键约束
alter table 表名称 add unique 【key】(字段名);

#给emp表的cardid增加唯一键约束
alter table emp add unique key(cardid);

mysql> desc emp;
+--------+-------------+------+-----+---------+-------+
| Field  | Type        | Null | Key | Default | Extra |
+--------+-------------+------+-----+---------+-------+
| id     | int         | YES  | UNI | NULL    |       |
| name   | varchar(20) | YES  |     | NULL    |       |
| cardid | char(18)    | YES  | UNI | NULL    |       |
| tel    | char(11)    | YES  | UNI | NULL    |       |
+--------+-------------+------+-----+---------+-------+
4 rows in set (0.00 sec)

mysql> show index from emp;
+-------+------------+----------+--------------+-------------+-----------+-------------+----------+--------+------+------------+---------+---------------+---------+------------+
| Table | Non_unique | Key_name | Seq_in_index | Column_name | Collation | Cardinality | Sub_part | Packed | Null | Index_type | Comment | Index_comment | Visible | Expression |
+-------+------------+----------+--------------+-------------+-----------+-------------+----------+--------+------+------------+---------+---------------+---------+------------+
| emp   |          0 | id       |            1 | id          | A         |           4 |     NULL |   NULL | YES  | BTREE      |         |               | YES     | NULL       |
| emp   |          0 | tel      |            1 | tel         | A         |           3 |     NULL |   NULL | YES  | BTREE      |         |               | YES     | NULL       |
| emp   |          0 | cardid   |            1 | cardid      | A         |           3 |     NULL |   NULL | YES  | BTREE      |         |               | YES     | NULL       |
+-------+------------+----------+--------------+-------------+-----------+-------------+----------+--------+------+------------+---------+---------------+---------+------------+
3 rows in set (0.01 sec)

#有一种特殊的唯一键约束，复合唯一
#即表示两个或更多个字段值的组合唯一，单个字段看不唯一
create table 表名称(
	字段名1 数据类型,
	字段名2 数据类型,
	字段名3 数据类型,
	字段名4 数据类型,
	unique key(字段名1,字段名2),  #表示字段名1和字段名2组合不能重复
								  #字段1和字段2单独看是可以重复的
	unique key(字段名3),	#表示字段3单独不能重复
	unique key(字段名4)		#表示字段3单独不能重复
);



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

#选课表
create table xuanke(
	xid int  unique key, #表示xid不能重复
	sid int,
	cid int,
	score int,
	unique key(sid,cid) #这么写表示sic和cid的组合不能重复，
						#单独看sid和cid是可以重复的
);

#添加选课成绩信息
insert into xuanke values(1,1,1,89);
insert into xuanke values(2,1,2,96);
insert into xuanke values(3,2,1,75);
insert into xuanke values(4,2,2,96);

mysql> select * from xuanke;
+------+------+------+-------+
| xid  | sid  | cid  | score |
+------+------+------+-------+
|    1 |    1 |    1 |    89 |
|    2 |    1 |    2 |    96 |
|    3 |    2 |    1 |    75 |
|    4 |    2 |    2 |    96 |
+------+------+------+-------+
4 rows in set (0.00 sec)
#单独看sid是可以重复的
#单独看cid是可以重复的
#组合看sid和cid是不可以重复的

insert into xuanke values(5,1,1,100); #sid为1和cid为1组合重复
mysql> insert into xuanke values(5,1,1,100);
ERROR 1062 (23000): Duplicate entry '1-1' for key 'xuanke.sid'

mysql> desc xuanke;
+-------+------+------+-----+---------+-------+
| Field | Type | Null | Key | Default | Extra |
+-------+------+------+-----+---------+-------+
| xid   | int  | YES  | UNI | NULL    |       |
| sid   | int  | YES  | MUL | NULL    |       |
| cid   | int  | YES  |     | NULL    |       |
| score | int  | YES  |     | NULL    |       |
+-------+------+------+-----+---------+-------+
4 rows in set (0.01 sec)

mysql> show index from xuanke;
+--------+------------+----------+--------------+-------------+-----------+-------------+----------+--------+------+------------+---------+---------------+---------+------------+
| Table  | Non_unique | Key_name | Seq_in_index | Column_name | Collation | Cardinality | Sub_part | Packed | Null | Index_type | Comment | Index_comment | Visible | Expression |
+--------+------------+----------+--------------+-------------+-----------+-------------+----------+--------+------+------------+---------+---------------+---------+------------+
| xuanke |          0 | xid      |            1 | xid         | A         |           4 |     NULL |   NULL | YES  | BTREE      |         |               | YES     | NULL       |
| xuanke |          0 | sid      |            1 | sid         | A         |           2 |     NULL |   NULL | YES  | BTREE      |         |               | YES     | NULL       |
| xuanke |          0 | sid      |            2 | cid         | A         |           4 |     NULL |   NULL | YES  | BTREE      |         |               | YES     | NULL       |
+--------+------------+----------+--------------+-------------+-----------+-------------+----------+--------+------+------------+---------+---------------+---------+------------+
3 rows in set (0.01 sec)

#删除复合唯一键约束
alter table 表名称 drop index 索引名;

alter table xuanke drop index sid;

mysql> show index from xuanke;
+--------+------------+----------+--------------+-------------+-----------+-------------+----------+--------+------+------------+---------+---------------+---------+------------+
| Table  | Non_unique | Key_name | Seq_in_index | Column_name | Collation | Cardinality | Sub_part | Packed | Null | Index_type | Comment | Index_comment | Visible | Expression |
+--------+------------+----------+--------------+-------------+-----------+-------------+----------+--------+------+------------+---------+---------------+---------+------------+
| xuanke |          0 | xid      |            1 | xid         | A         |           4 |     NULL |   NULL | YES  | BTREE      |         |               | YES     | NULL       |
+--------+------------+----------+--------------+-------------+-----------+-------------+----------+--------+------+------------+---------+---------------+---------+------------+
1 row in set (0.00 sec)

mysql> desc xuanke;
+-------+------+------+-----+---------+-------+
| Field | Type | Null | Key | Default | Extra |
+-------+------+------+-----+---------+-------+
| xid   | int  | YES  | UNI | NULL    |       |
| sid   | int  | YES  |     | NULL    |       |
| cid   | int  | YES  |     | NULL    |       |
| score | int  | YES  |     | NULL    |       |
+-------+------+------+-----+---------+-------+
4 rows in set (0.00 sec)
