CREATE TABLE `table`(
	id INT,
	name VARCHAR(20)
);

create table my tab(id int); #表名中间有空格，报错
create table `my tab`(id int);

create database atguigu;
mysql> create database atguigu;
ERROR 1007 (HY000): Can't create database 'atguigu'; database exists'


create table temp(
	id int
;
ERROR 1064 (42000): You have an error in your SQL syntax; check the manual that corresponds to your MySQL server version for the right syntax to use n
ear '' at line 2

create table temp(
	y year
);

insert into temp values('2021);  
mysql> insert into temp values('2021);
    '>
    '>
    '>
    '>
    '>
    '>
    '> ';  必须补全落下的单引号，然后结束本次错误的SQL。
ERROR 1064 (42000): You have an error in your SQL syntax;
 check the manual that corresponds to your MySQL server
 version for the right syntax to use near '' at line 8


insert into temp values('2021');  
select * from temp;

select y as "年份" from temp; 
#给字段y取别名，只是本条sql有效，表中的字段仍然是y。

mysql> select y as "年份" from temp;
+------+
| 年份 |
+------+
| 2021 |
+------+
1 row in set (0.00 sec)

select y "年份" from temp; #as可以省略

select y 年份 from temp; #如果别名中没有空格，""也可以去掉

select y 年 份 from temp;  #如果别名中有空格，""去掉就会出错
ERROR 1064 (42000): You have an error in your SQL syntax; 
check the manual that corresponds to your MySQL server 
version for the right syntax to use near '份 from temp' at line 1

select y "年份" from temp； #；中文的
mysql> select y "年份" from temp；
    -> ;
ERROR 1146 (42S02): Table 'atguigu.temp；' doesn't exist'


#查询temp表的数据
select * from temp;

-- 查询temp表的数据
select * from temp;
 
--查询temp表的数据   注意--和注释之间必须有空格，否则报错
select * from temp;

/*
多行注释
查询temp表的数据
*/
select * from temp;