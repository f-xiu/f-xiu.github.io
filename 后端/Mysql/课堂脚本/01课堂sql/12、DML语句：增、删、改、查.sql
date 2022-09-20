#演示基本的，简单的DML语句
#基于tempdb数据库演示
create database tempdb;
use tempdb;

#创建teacher表
create table teacher(
	id int,
	name varchar(20),
	gender enum('m','f'),
	birthday date,
	salary double,
	tel varchar(11)
);

#查看teacher表结构
mysql> desc teacher;
+----------+---------------+------+-----+---------+-------+
| Field    | Type          | Null | Key | Default | Extra |
+----------+---------------+------+-----+---------+-------+
| id       | int           | YES  |     | NULL    |       |
| name     | varchar(20)   | YES  |     | NULL    |       |
| gender   | enum('m','f') | YES  |     | NULL    |       |
| birthday | date          | YES  |     | NULL    |       |
| salary   | double        | YES  |     | NULL    |       |
| tel      | char(18)      | YES  |     | NULL    |       |
+----------+---------------+------+-----+---------+-------+
6 rows in set (0.01 sec)


#添加数据
#（1）第一种情况，给所有字段赋值
insert into 表名称 values(值列表);  
#这种情况要求(值列表)的每一个值的类型、顺序与表结构一一对应
#表中有几个字段，(值列表)必须有几个值，不能多也不能少
#值如果是字符串或日期类型，需要加单引号

#例如：添加一条记录到teacher表
insert into teacher values
(1,'张三','m','1998-7-8',15000.0,'18256953685');

#例如：添加一条记录到teacher表
insert into teacher values
(2,'李四','f','1998-7-8',15000.0); #少了电话号码

mysql> insert into teacher values
    -> (2,'李四','f','1998-7-8',15000.0);
ERROR 1136 (21S01): Column count doesn't match value count at row 1'
#(值列表)中值的数量和表结构中column列的数量不一致。

#例如：添加一条记录到teacher表
insert into teacher values
(2,'李四','f','北京宏福苑',15000.0,'18256953685'); #把生日写称为地址

mysql> insert into teacher values
    -> (2,'李四','f','北京宏福苑',15000.0,'18256953685');
ERROR 1292 (22007): Incorrect date value: '北京宏福苑' for column 'birthday' at row 1
#日期格式不对

#（2）第二种情况，给部分字段赋值
insert into 表名称 (部分字段列表) values(值列表);
#此时(值列表)中的值的数量、格式、顺序与(部分字段列表)对应即可

#例如：添加一条记录到teacher表，只给id和name字段赋值
insert into teacher (id,name) values (2,'李四'); 

mysql> select * from teacher;
+------+------+--------+------------+--------+-------------+
| id   | name | gender | birthday   | salary | tel         |
+------+------+--------+------------+--------+-------------+
|    1 | 张三 | m      | 1998-07-08 |  15000 | 18256953685 |
|    2 | 李四 | NULL   | NULL       |   NULL | NULL        | 
+------+------+--------+------------+--------+-------------+
2 rows in set (0.00 sec)
#没有赋值的字段都是默认值，此时默认值是NULL
#这种情况，当某个字段设置了“非空NOT NULL”约束，又没有提前指定“默认值”，
#那么在添加时没有赋值的话，会报错。明天演示非空约束。

#（3）一次添加多条记录
insert into 表名称  values(值列表1),(值列表2)...;
insert into 表名称 (部分字段列表) values(值列表),(值列表2)...;
#上面一个insert语句有几个(值列表)就表示添加几行记录。
#每一个值列表直接使用逗号分隔

#添加多条记录到teacher表
insert into teacher (id,name) values
 (3,'王五'),
 (4,'宋鑫'),
 (5,'赵志浩'),
 (6,'杨业行'),
 (7,'牛钰琪');
 
 #查看数据
 mysql> select * from teacher;
+------+--------+--------+------------+--------+-------------+
| id   | name   | gender | birthday   | salary | tel         |
+------+--------+--------+------------+--------+-------------+
|    1 | 张三   | m      | 1998-07-08 |  15000 | 18256953685 |
|    2 | 李四   | NULL   | NULL       |   NULL | NULL        |
|    3 | 王五   | NULL   | NULL       |   NULL | NULL        |
|    4 | 宋鑫   | NULL   | NULL       |   NULL | NULL        |
|    5 | 赵志浩 | NULL   | NULL       |   NULL | NULL        |
|    6 | 杨业行 | NULL   | NULL       |   NULL | NULL        |
|    7 | 牛钰琪 | NULL   | NULL       |   NULL | NULL        |
+------+--------+--------+------------+--------+-------------+
7 rows in set (0.00 sec)

#查询数据
#查询整个表的所有行所有列
select * from 表名称;

#例如：查看teacher表的所有记录
select * from teacher;

mysql> select * from teacher;
+------+------+--------+------------+--------+-------------+
| id   | name | gender | birthday   | salary | tel         |
+------+------+--------+------------+--------+-------------+
|    1 | 张三 | m      | 1998-07-08 |  15000 | 18256953685 |
+------+------+--------+------------+--------+-------------+
1 row in set (0.00 sec)

#查询部分字段
select 字段名列表 from 表名称;

#例如：查询teacher表所有记录的name和gender
select name,gender from teacher;

mysql> select name,gender from teacher;
+--------+--------+
| name   | gender |
+--------+--------+
| 张三   | m      |
| 李四   | NULL   |
| 王五   | NULL   |
| 宋鑫   | NULL   |
| 赵志浩 | NULL   |
| 杨业行 | NULL   |
| 牛钰琪 | NULL   |
+--------+--------+
7 rows in set (0.00 sec)

#查询部分行
select * from 表名称 where 条件;
select 字段列表 from 表名称 where 条件;

#只查询teacher表中电话号码不为空的记录
select * from teacher where tel is not null;

mysql> select * from teacher where tel is not null;
+------+------+--------+------------+--------+-------------+
| id   | name | gender | birthday   | salary | tel         |
+------+------+--------+------------+--------+-------------+
|    1 | 张三 | m      | 1998-07-08 |  15000 | 18256953685 |
+------+------+--------+------------+--------+-------------+
1 row in set (0.00 sec)

#只查询teacher表中电话号码不为空的员工姓名和电话号码
select name,tel from teacher where tel is not null;

mysql> select name,tel from teacher where tel is not null;
+------+-------------+
| name | tel         |
+------+-------------+
| 张三 | 18256953685 |
+------+-------------+
1 row in set (0.00 sec)

mysql> select name,tel from teacher where tel = null;#不报错，没结果，判断null不能用=
Empty set (0.00 sec)

mysql> select name,tel from teacher where tel == null;  #错误mysql中比较不用==
ERROR 1064 (42000): You have an error in your SQL syntax; 
check the manual that corresponds to your MySQL server version 
for the right syntax to use near '== null' at line 1


#查询数据时，可以给查询结果的字段取别名
select 字段名 as 别名,字段名as 别名 from 表名称 where 条件;

#查询teacher表的数据，显示name为姓名，tel为电话
select name as "姓名", tel as "电话" from teacher;
#取别名时，可以省略as，如果字段的别名中没有空格等其他特殊字符，
或者别名不与关键字等冲突，可以省略""。

#去重复
select distinct 字段列表  from 表名称 where 条件;

#添加一条重复记录到teacher表
insert into teacher values
(1,'张三','m','1998-7-8',15000.0,'18256953685');

#查询teacher表的数据，去重复
select distinct * from teacher;

mysql> select distinct * from teacher;
+------+--------+--------+------------+--------+-------------+
| id   | name   | gender | birthday   | salary | tel         |
+------+--------+--------+------------+--------+-------------+
|    1 | 张三   | m      | 1998-07-08 |  15000 | 18256953685 |
|    2 | 李四   | NULL   | NULL       |   NULL | NULL        |
|    3 | 王五   | NULL   | NULL       |   NULL | NULL        |
|    4 | 宋鑫   | NULL   | NULL       |   NULL | NULL        |
|    5 | 赵志浩 | NULL   | NULL       |   NULL | NULL        |
|    6 | 杨业行 | NULL   | NULL       |   NULL | NULL        |
|    7 | 牛钰琪 | NULL   | NULL       |   NULL | NULL        |
+------+--------+--------+------------+--------+-------------+
7 rows in set (0.00 sec)

#添加几条记录
insert into teacher(id,name,gender) values
(8,'柴','f'),
(9,'宋','m'),
(10,'张','f');

#查询出teacher表中所有的性别值
select gender from teacher;
mysql> select gender from teacher;
+--------+
| gender |
+--------+
| m      |
| NULL   |
| NULL   |
| NULL   |
| NULL   |
| NULL   |
| NULL   |
| m      |
| f      |
| m      |
| f      |
+--------+
11 rows in set (0.00 sec)

#查询出teacher表中所有的性别值，去掉重复值
select distinct gender from teacher;
mysql> select distinct gender from teacher;
+--------+
| gender |
+--------+
| m      |
| NULL   |
| f      |
+--------+
3 rows in set (0.00 sec)

#修改数据
update 表名称 set 字段名1 = 新值, 字段名1 = 新值, ...;
#如果说，没有给update语句加where条件，那么会修改所有行的值。

update 表名称 set 字段名1 = 新值, 字段名1 = 新值, ... where 条件;
#如果说，给给update语句加where条件，那么值会修改满足条件的行的值。

#修改teacher表的salary字段为10000
update teacher set salary = 10000;

mysql> select * from teacher;
+------+--------+--------+------------+--------+-------------+
| id   | name   | gender | birthday   | salary | tel         |
+------+--------+--------+------------+--------+-------------+
|    1 | 张三   | m      | 1998-07-08 |  10000 | 18256953685 |
|    2 | 李四   | NULL   | NULL       |  10000 | NULL        |
|    3 | 王五   | NULL   | NULL       |  10000 | NULL        |
|    4 | 宋鑫   | NULL   | NULL       |  10000 | NULL        |
|    5 | 赵志浩 | NULL   | NULL       |  10000 | NULL        |
|    6 | 杨业行 | NULL   | NULL       |  10000 | NULL        |
|    7 | 牛钰琪 | NULL   | NULL       |  10000 | NULL        |
|    1 | 张三   | m      | 1998-07-08 |  10000 | 18256953685 |
|    8 | 柴     | f      | NULL       |  10000 | NULL        |
|    9 | 宋     | m      | NULL       |  10000 | NULL        |
|   10 | 张     | f      | NULL       |  10000 | NULL        |
+------+--------+--------+------------+--------+-------------+
11 rows in set (0.00 sec)

#修改teacher表张三的salary字段为20000
update teacher set salary = 20000 where name = '张三'; #mysql中比较值相等用=

mysql> select * from teacher;
+------+--------+--------+------------+--------+-------------+
| id   | name   | gender | birthday   | salary | tel         |
+------+--------+--------+------------+--------+-------------+
|    1 | 张三   | m      | 1998-07-08 |  20000 | 18256953685 |
|    2 | 李四   | NULL   | NULL       |  10000 | NULL        |
|    3 | 王五   | NULL   | NULL       |  10000 | NULL        |
|    4 | 宋鑫   | NULL   | NULL       |  10000 | NULL        |
|    5 | 赵志浩 | NULL   | NULL       |  10000 | NULL        |
|    6 | 杨业行 | NULL   | NULL       |  10000 | NULL        |
|    7 | 牛钰琪 | NULL   | NULL       |  10000 | NULL        |
|    1 | 张三   | m      | 1998-07-08 |  20000 | 18256953685 |
|    8 | 柴     | f      | NULL       |  10000 | NULL        |
|    9 | 宋     | m      | NULL       |  10000 | NULL        |
|   10 | 张     | f      | NULL       |  10000 | NULL        |
+------+--------+--------+------------+--------+-------------+
11 rows in set (0.00 sec)


#删除数据行
delete from 表名称;
#如果说，没有给delete语句加where条件，那么会删除所有行。

delete from 表名称 where 条件;
#如果说，给delete语句加where条件，那么只会删除满足条件的行。

#删除teacher表的张三记录
delete from teacher where name ='张三';

mysql> select * from teacher;
+------+--------+--------+----------+--------+------+
| id   | name   | gender | birthday | salary | tel  |
+------+--------+--------+----------+--------+------+
|    2 | 李四   | NULL   | NULL     |  10000 | NULL |
|    3 | 王五   | NULL   | NULL     |  10000 | NULL |
|    4 | 宋鑫   | NULL   | NULL     |  10000 | NULL |
|    5 | 赵志浩 | NULL   | NULL     |  10000 | NULL |
|    6 | 杨业行 | NULL   | NULL     |  10000 | NULL |
|    7 | 牛钰琪 | NULL   | NULL     |  10000 | NULL |
|    8 | 柴     | f      | NULL     |  10000 | NULL |
|    9 | 宋     | m      | NULL     |  10000 | NULL |
|   10 | 张     | f      | NULL     |  10000 | NULL |
+------+--------+--------+----------+--------+------+
9 rows in set (0.00 sec)

#同学问：是否可以删除salary字段的值，字段留着，值删掉
#可以实现，但是不是用delete，用update

#同学问：是否可以删除salary字段，连同字段和这个字段的数据都是删除
#可以实现，但是不是用delete，用alter table 表名称 drop column 字段名;

#同学问：只删除某个单元格的值
#可以实现，但是不是用delete，用update

#删除teacher表所有记录
delete from teacher;

mysql> desc teacher; #表结构还在
+----------+---------------+------+-----+---------+-------+
| Field    | Type          | Null | Key | Default | Extra |
+----------+---------------+------+-----+---------+-------+
| id       | int           | YES  |     | NULL    |       |
| name     | varchar(20)   | YES  |     | NULL    |       |
| gender   | enum('m','f') | YES  |     | NULL    |       |
| birthday | date          | YES  |     | NULL    |       |
| salary   | double        | YES  |     | NULL    |       |
| tel      | char(18)      | YES  |     | NULL    |       |
+----------+---------------+------+-----+---------+-------+
6 rows in set (0.01 sec)

mysql> select * from teacher; #数据清空了
Empty set (0.00 sec)

#截断表：可以实现删除表中所有数据的效果。
truncate 表名称;

#添加几条记录到teacher表
insert into teacher (id,name) values
 (3,'王五'),
 (4,'宋鑫'),
 (5,'赵志浩'),
 (6,'杨业行'),
 (7,'牛钰琪');
 
 #截断teacher表
 truncate teacher;
 
 mysql> desc teacher;
+----------+---------------+------+-----+---------+-------+
| Field    | Type          | Null | Key | Default | Extra |
+----------+---------------+------+-----+---------+-------+
| id       | int           | YES  |     | NULL    |       |
| name     | varchar(20)   | YES  |     | NULL    |       |
| gender   | enum('m','f') | YES  |     | NULL    |       |
| birthday | date          | YES  |     | NULL    |       |
| salary   | double        | YES  |     | NULL    |       |
| tel      | char(18)      | YES  |     | NULL    |       |
+----------+---------------+------+-----+---------+-------+
6 rows in set (0.01 sec)

truncate截断表是把表drop掉，重新建一张全新的，效率过，但是不支持事务回滚（不能后悔）。
delete删除记录是一条一条删除的，慢，如果在事务中操作，提交之前支持回滚。
