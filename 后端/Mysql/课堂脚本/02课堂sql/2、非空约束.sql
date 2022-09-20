/*演示非空约束
1、作用：限定某个字段的值不允许为NULL。

在Java中只有引用数据类型才能赋值为null，基本数据类型不允许为null。
但是MySQL中所有的数据类型都可以赋值为NULL，包括int等。

2、关键字：not null

3、一个表可以有很多个字段限定非空约束，
一个字段加not null，和其他字段无关，它是列级约束。
*/

#创建一个表格，演示NULL值
create table not_null_demo(
	id int,
	name varchar(20),
	birthday date
);

insert into not_null_demo values(null,null,null);
insert into not_null_demo(id) values(1);
select * from not_null_demo;
drop table not_null_demo;

#在创建表的时候，可以指定非空约束

create table 表名称(
	字段名 数据类型 not null,
	字段名 数据类型 not null,
	字段名 数据类型
);

create table not_null_demo(
	id int not null,
	name varchar(20) not null,
	birthday date  #没有加not null的，允许为NULL
);

#添加NULL值
insert into not_null_demo values(null,null,null);

mysql> insert into not_null_demo values(null,null,null);
ERROR 1048 (23000): Column 'id' cannot be null

#指定了id字段的值，但是没有指定name字段和birthday字段的值
insert into not_null_demo(id) values(1);

mysql> insert into not_null_demo(id) values(1);
ERROR 1364 (HY000): Field 'name' doesn't have a default value'
#此时name设定了NOT NULL，但又没有提前指定默认值，
#如果没赋值只能处理为NULL，就违反非空约束

#总结：在insert添加记录时，必须给所有没有提前指定默认值的非空约束字段赋值。

insert into not_null_demo(id,name) values(1,'张三');
insert into not_null_demo(id,name,birthday) values(2,'李四','2000-1-1');
insert into not_null_demo values(3,'王五','2000-2-1');
insert into not_null_demo values(4,'赵六',null);

insert into not_null_demo values(4,'赵六'); #错误，值列表数量与字段数量不匹配
mysql> insert into not_null_demo values(4,'赵六');
ERROR 1136 (21S01): Column count doesn't match value count at row 1'


#在创建表之后，可以给某个字段增加非空约束
#alter table 表名称 modify 【column】 字段名 数据类型 not null;

#例如：给not_null_demo表格的birthday字段加not null约束
alter table not_null_demo modify column birthday date not null;

mysql> alter table not_null_demo modify column birthday date not null;
ERROR 1138 (22004): Invalid use of NULL value
#失败的原因是因为not_null_demo表中birthday字段现在已经有NULL值。
#所以添加不上非空约束。
#如果要加，必须先将原来的NULL值修改掉

mysql> select * from not_null_demo;
+----+------+------------+
| id | name | birthday   |
+----+------+------------+
|  1 | 张三 | NULL       |
|  2 | 李四 | 2000-01-01 |
|  3 | 王五 | 2000-02-01 |
|  4 | 赵六 | NULL       |
+----+------+------------+
4 rows in set (0.01 sec)

update not_null_demo set birthday = '2000-5-1' where id=1 || id = 4;

mysql> select * from not_null_demo;
+----+------+------------+
| id | name | birthday   |
+----+------+------------+
|  1 | 张三 | 2000-05-01 |
|  2 | 李四 | 2000-01-01 |
|  3 | 王五 | 2000-02-01 |
|  4 | 赵六 | 2000-05-01 |
+----+------+------------+
4 rows in set (0.00 sec)

mysql> alter table not_null_demo modify column birthday date not null;
Query OK, 0 rows affected (0.06 sec)
Records: 0  Duplicates: 0  Warnings: 0

mysql> desc not_null_demo;
+----------+-------------+------+-----+---------+-------+
| Field    | Type        | Null | Key | Default | Extra |
+----------+-------------+------+-----+---------+-------+
| id       | int         | NO   |     | NULL    |       |
| name     | varchar(20) | NO   |     | NULL    |       |
| birthday | date        | NO   |     | NULL    |       |
+----------+-------------+------+-----+---------+-------+
3 rows in set (0.01 sec)

#删除某个字段的非空约束
alter table 表名称 modify 【column】 字段名 数据类型;

#例如：去掉birthday字段的非空约束
alter table not_null_demo modify column birthday date;

mysql> desc not_null_demo;
+----------+-------------+------+-----+---------+-------+
| Field    | Type        | Null | Key | Default | Extra |
+----------+-------------+------+-----+---------+-------+
| id       | int         | NO   |     | NULL    |       |
| name     | varchar(20) | NO   |     | NULL    |       |
| birthday | date        | YES  |     | NULL    |       |
+----------+-------------+------+-----+---------+-------+
3 rows in set (0.01 sec)


/*
说明：
如果某个字段有not null非空约束的话，
使用modify修改字段的数据类型、位置、字符集和校对规则时，
想要保留非空约束，必须把not null带上，
否则会在修改字段的数据类型、位置、字符集和校对规则时，
把非空约束给丢掉。
*/
#例如：修改name字段的数据类型为varchar(30)，本来想要保留not null非空约束的
alter table not_null_demo modify column name varchar(30);
#此时alter没有加not null，会把name字段的not null约束给丢掉。

mysql> desc not_null_demo;
+----------+-------------+------+-----+---------+-------+
| Field    | Type        | Null | Key | Default | Extra |
+----------+-------------+------+-----+---------+-------+
| id       | int         | NO   |     | NULL    |       |
| name     | varchar(30) | YES  |     | NULL    |       |
| birthday | date        | YES  |     | NULL    |       |
+----------+-------------+------+-----+---------+-------+
3 rows in set (0.01 sec)
