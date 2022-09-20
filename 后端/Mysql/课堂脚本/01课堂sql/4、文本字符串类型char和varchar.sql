#演示文本字符串类型
#创建一个表格
create table t_char(
	c1 char,   #定长字符串，单独写char表示只能存1个字符
	c2 varchar  #不定长字符串，单独写varchar报错，必须限定最多能存几个字符
);
ERROR 1064 (42000): You have an error in your SQL syntax; 
check the manual that corresponds to your MySQL server version 
for the right syntax to use near ')' at line 4

create table t_char(
	c1 char,   #定长字符串，单独写char表示只能存1个字符
	c2 char(3), # 定长字符串，char(3)表示可以存储3个字符，不够3个底层用\u0000补全
	c3 varchar(5)  #不定长字符串，varchar(M)，varchar(5)表示最多能存储5个字符
);

#查看表结构
desc t_char;
mysql> desc t_char;
+-------+------------+------+-----+---------+-------+
| Field | Type       | Null | Key | Default | Extra |
+-------+------------+------+-----+---------+-------+
| c1    | char(1)    | YES  |     | NULL    |       |
| c2    | char(3)    | YES  |     | NULL    |       |
| c3    | varchar(5) | YES  |     | NULL    |       |
+-------+------------+------+-----+---------+-------+
3 rows in set (0.01 sec)

#添加数据
insert into t_char values('a','a','a');

#查询数据
select * from t_char;
mysql> select * from t_char;
+------+------+------+
| c1   | c2   | c3   |
+------+------+------+
| a    | a    | a    |
+------+------+------+
1 row in set (0.00 sec)


#添加数据
insert into t_char values('ab','ab','ab');
#MySQL中字符串值无论是几个字符都是使用单引号

mysql> insert into t_char values('ab','ab','ab');
ERROR 1406 (22001): Data too long for column 'c1' at row 1

#添加数据
insert into t_char values('尚','ab','ab');

mysql> select * from t_char;
+------+------+------+
| c1   | c2   | c3   |
+------+------+------+
| a    | a    | a    |
| 尚   | ab   | ab   |
+------+------+------+
2 rows in set (0.00 sec)


#添加数据
insert into t_char values('尚','尚硅谷','尚硅谷');

mysql> select * from t_char;
+------+--------+--------+
| c1   | c2     | c3     |
+------+--------+--------+
| a    | a      | a      |
| 尚   | ab     | ab     |
| 尚   | 尚硅谷 | 尚硅谷 |
+------+--------+--------+
3 rows in set (0.00 sec)

#添加数据
insert into t_char values('尚','尚硅谷真好','尚硅谷真好');

mysql> insert into t_char values('尚','尚硅谷真好','尚硅谷真好');
ERROR 1406 (22001): Data too long for column 'c2' at row 1


#添加数据
insert into t_char values('尚','尚硅谷','尚硅谷真好');

mysql> select * from t_char;
+------+--------+------------+
| c1   | c2     | c3         |
+------+--------+------------+
| a    | a      | a          |
| 尚   | ab     | ab         |
| 尚   | 尚硅谷 | 尚硅谷     |
| 尚   | 尚硅谷 | 尚硅谷真好 |
+------+--------+------------+
4 rows in set (0.00 sec)

#添加数据
insert into t_char values('尚','尚硅谷','尚硅谷真的很好');

mysql> insert into t_char values('尚','尚硅谷','尚硅谷真的很好');
ERROR 1406 (22001): Data too long for column 'c3' at row 1


insert into t_char values('尚','尚  ','尚硅谷  ');

#查询一下数据
select c1,concat('[',c2,']'),concat('[',c3,']') from t_char;
mysql> select c1,concat('[',c2,']'),concat('[',c3,']') from t_char;
+------+--------------------+--------------------+
| c1   | concat('[',c2,']') | concat('[',c3,']') |
+------+--------------------+--------------------+
| a    | [a]                | [a]                |
| 尚   | [ab]               | [ab]               |
| 尚   | [尚硅谷]           | [尚硅谷]           |
| 尚   | [尚硅谷]           | [尚硅谷真好]       |
| 尚   | [尚]               | [尚硅谷  ]         |
+------+--------------------+--------------------+
5 rows in set (0.00 sec)


insert into t_char values('尚','  尚','  尚硅谷');

mysql> select c1,concat('[',c2,']'),concat('[',c3,']') from t_char;
+------+--------------------+--------------------+
| c1   | concat('[',c2,']') | concat('[',c3,']') |
+------+--------------------+--------------------+
| a    | [a]                | [a]                |
| 尚   | [ab]               | [ab]               |
| 尚   | [尚硅谷]           | [尚硅谷]           |
| 尚   | [尚硅谷]           | [尚硅谷真好]       |
| 尚   | [尚]               | [尚硅谷  ]         |
| 尚   | [  尚]             | [  尚硅谷]         |
+------+--------------------+--------------------+
6 rows in set (0.00 sec)



