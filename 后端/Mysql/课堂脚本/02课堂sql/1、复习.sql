#一、和数据库相关的DDL
#查看数据库
show databases;

#创建数据库
create database 数据库名;
create database 数据库名 character set 字符集名称 collate 校对规则;

#使用数据库
use 数据库名称;

#查看数据库的定义
show create database 数据库名称;

#修改数据库，不能修改数据库名，只能修改字符集和校对规则
create database 数据库名 character set 字符集名称 collate 校对规则;
/*
一旦库建完，里面已经创建了表格，
创建表格时没有指定字符集，使用数据库默认的字符集的话，
表格建完之后再修改数据库的字符集和校对规则，是比较麻烦的，
因为所有的表格、字段的字符集和校对规则需要单独修改。

建议大家在一开始就要确定好数据库的字符集和校对规则。
特别是MySQL8之前，mysql服务器默认的字符集是Latin1，
如果没有修改配置文件my.ini，就去创建数据库，数据库默认也是Latin1。
*/

#删除数据库
drop database 数据库名;


#二、和数据表相关的DDL
#查看所有表格
show tables; #前面有use语句
show tables from 数据库名;

#创建表格
create table 表名称(
	字段名 数据类型,
	字段名 数据类型
);

create table 表名称(
	字段名 数据类型,
	字段名 数据类型
) character set 字符集名称 collate 校对规则;

#查看表格的定义
show create table 表名称;

#查看表结构
desc 表名称;
describe 表名称;

#删除表格
drop table 表名称;

#修改表名称
rename table 旧表名 to 新表名;
alter table 旧表名 rename 【to】 新表名;

alter table `my tab` rename to mytab;
alter table `mytab` rename mytable;
rename table mytable to mytab;

#修改表字符集和校对规则
alter table 表名称 character set 字符集名称 collate 校对规则;

#增加字段
alter table 表名称 add 【column】 新字段名 数据类型;
alter table 表名称 add 【column】 新字段名 数据类型 first;
alter table 表名称 add 【column】 新字段名 数据类型 after 字段名;

#删除字段，连同该字段的所有数据一并删除，相当于把表格的某列的结构和数据一并删除
alter table 表名称 drop 【column】 字段名;

#修改字段的数据类型、位置
alter table 表名称 modify 【column】 字段名 数据类型;
alter table 表名称 modify 【column】 字段名 数据类型 first;
alter table 表名称 modify 【column】 字段名 数据类型 after 字段名;

#修改字段的名称
alter table 表名称 change 【column】旧字段名 新字段名 数据类型;

#修改字段的字符集和校对规则
alter table 表名称 modify 【column】 字段名 数据类型 character set 字符集名称 collate 校对规则;

#三、DML
#1、添加记录
#添加记录，不能在记录中间插入（相当于学习IO流的追加模式）
#如果想要按顺序看结果，需要在查询时按xx排序来呈现效果。
insert into 表名称 values(值列表); 
#要求(值列表)中值的数量、顺序、类型与表结构字段的数量、顺序、类型一一对应。
#这种方式，如果表结构中字段的顺序、数量有变化，那么这个insert脚本就要修改。

insert into 表名称(字段列表) values(值列表); #推荐使用它，相对稳定
#要求(值列表)中值的数量、顺序、类型与表名称后面(字段列表)的数量、顺序、类型一一对应。
#这种方式，如果表结构中字段的顺序、增加，那么这个insert脚本不用修改。
#这种方式，如果表结构中把(字段列表)字段的名称变了、删除字段，那么这个insert脚本需要修改。

insert into 表名称 values(值列表),(值列表),(值列表)....; 
insert into 表名称(字段列表) values(值列表),(值列表),(值列表)....; 

#2、修改记录
#修改所有行的字段1，字段2的值，。。。。
update 表名称 set 字段名1 = 值, 字段名2 = 值 ....;

#修改满足where条件的行的字段1，字段2的值，。。。。
update 表名称 set 字段名 = 值, 字段名 = 值 .... where 条件; 


#3、删除行记录（只要delete一定是删除整行）
#删除满足where条件的行
delete from 表名称 where 条件;

#删除整个表格的数据
delete from 表名称;
truncate 表名称;

truncate :快，不支持事务
delete：慢，支持事务