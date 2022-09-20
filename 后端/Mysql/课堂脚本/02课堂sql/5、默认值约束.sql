#演示默认值约束
/*
1、作用
如果在insert添加数据时，没有给这个字段赋值，它会选择默认值约束指定默认值。
如果字段没有定义默认值约束，那么默认就是NULL。

2、关键字：default


非空和默认值约束是列级约束，只影响某个字段，只看当前单元格，和其他行无关。
唯一键约束和主键约束是表级约束，会看该字段所有行的数据，整个表一起看。
*/

#建表时，可以在字段后面给字段指定默认值
create table emp(
	eid int primary key,
	ename varchar(20) not null,
	gender enum('男','女') default '男' not null, #非空并且有默认值
	address varchar(100) default '不详' #可以指定为null
);

insert into emp values(1,'张三');#错误，值的数量和字段的数量不匹配

mysql> insert into emp values(1,'张三');
ERROR 1136 (21S01): Column count doesn't match value count at row 1'

insert into emp(eid,ename) values(1,'张三');
insert into emp values(2,'李四',default,default);
insert into emp values(3,'王五',default,null);

mysql> select * from emp;
+-----+-------+--------+---------+
| eid | ename | gender | address |
+-----+-------+--------+---------+
|   1 | 张三  | 男     | 不详    |
|   2 | 李四  | 男     | 不详    |
|   3 | 王五  | 男     | NULL    |
+-----+-------+--------+---------+
3 rows in set (0.00 sec)


insert into emp values(4,'翠花','女','北京');

mysql> select * from emp;
+-----+-------+--------+---------+
| eid | ename | gender | address |
+-----+-------+--------+---------+
|   1 | 张三  | 男     | 不详    |
|   2 | 李四  | 男     | 不详    |
|   3 | 王五  | 男     | NULL    |
|   4 | 翠花  | 女     | 北京    |
+-----+-------+--------+---------+
4 rows in set (0.00 sec)

#删除默认值约束
alter table 表名称 modify 【column】 字段名 数据类型;

#查看表结构
desc emp;
mysql> desc emp;
+---------+-----------------+------+-----+---------+-------+
| Field   | Type            | Null | Key | Default | Extra |
+---------+-----------------+------+-----+---------+-------+
| eid     | int             | NO   | PRI | NULL    |       |
| ename   | varchar(20)     | NO   |     | NULL    |       |
| gender  | enum('男','女') | NO   |     | 男      |       |
| address | varchar(100)    | YES  |     | 不详    |       |
+---------+-----------------+------+-----+---------+-------+
4 rows in set (0.01 sec)

#删除emp表的address的默认值约束
alter table emp modify column address varchar(100);


mysql> desc emp;
+---------+-----------------+------+-----+---------+-------+
| Field   | Type            | Null | Key | Default | Extra |
+---------+-----------------+------+-----+---------+-------+
| eid     | int             | NO   | PRI | NULL    |       |
| ename   | varchar(20)     | NO   |     | NULL    |       |
| gender  | enum('男','女') | NO   |     | 男      |       |
| address | varchar(100)    | YES  |     | NULL    |       |
+---------+-----------------+------+-----+---------+-------+
4 rows in set (0.01 sec)

#删除emp表的gender的默认值约束
alter table emp modify column gender enum('男','女'); #同时删掉了非空约束和默认值约束


mysql> desc emp;
+---------+-----------------+------+-----+---------+-------+
| Field   | Type            | Null | Key | Default | Extra |
+---------+-----------------+------+-----+---------+-------+
| eid     | int             | NO   | PRI | NULL    |       |
| ename   | varchar(20)     | NO   |     | NULL    |       |
| gender  | enum('男','女') | YES  |     | NULL    |       |
| address | varchar(100)    | YES  |     | NULL    |       |
+---------+-----------------+------+-----+---------+-------+
4 rows in set (0.00 sec)

#结论：当使用modify修改字段的非空约束、默认值约束、数据类型等信息时
#注意，如果要保留的，在modify语句中要体现。
#例如：要保留非空约束，就要加not null，否则会丢掉。


#建表给字段增加默认值约束
alter table 表名称 modify 【column】 字段名 数据类型 default 默认值;

#给emp表address增加“不详”默认值
alter table emp modify column address varchar(100) default '不详';

#给emp表gender增加“男”默认值，以及非空
alter table emp modify column gender enum('男','女') default '男' not null;

mysql> desc emp;
+---------+-----------------+------+-----+---------+-------+
| Field   | Type            | Null | Key | Default | Extra |
+---------+-----------------+------+-----+---------+-------+
| eid     | int             | NO   | PRI | NULL    |       |
| ename   | varchar(20)     | NO   |     | NULL    |       |
| gender  | enum('男','女') | NO   |     | 男      |       |
| address | varchar(100)    | YES  |     | 不详    |       |
+---------+-----------------+------+-----+---------+-------+
4 rows in set (0.01 sec)