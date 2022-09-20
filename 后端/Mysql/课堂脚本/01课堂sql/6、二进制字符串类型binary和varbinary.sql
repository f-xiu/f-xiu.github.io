#演示二进制字符串类型binary和varbinary
#创建表格
create table t_binary(
	b1 binary, #没有指定(M)，默认是(1)
	b2 varbinary #没有指定(M)，报错，必须指定(M)
);
ERROR 1064 (42000): You have an error in your SQL syntax; 
check the manual that corresponds to your MySQL server 
version for the right syntax to use near ')' at line 4


create table t_binary(
	b1 binary, #默认(1)，最多能存储一个字节
	b2 binary(6), #最多能存储6个字节，不够6个用\u0000补全
	b3 varbinary(6) #(6)，最多能存储6个字节
);

#查看表结构
desc t_binary;

mysql> desc t_binary;
+-------+--------------+------+-----+---------+-------+
| Field | Type         | Null | Key | Default | Extra |
+-------+--------------+------+-----+---------+-------+
| b1    | binary(1)    | YES  |     | NULL    |       |
| b2    | binary(6)    | YES  |     | NULL    |       |
| b3    | varbinary(6) | YES  |     | NULL    |       |
+-------+--------------+------+-----+---------+-------+
3 rows in set (0.01 sec)


#添加数据
insert into t_binary
values('a','a','a');

#查看数据
select * from t_binary;
#显示16进制形式的值

mysql> select * from t_binary;
+------------+----------------+------------+
| b1         | b2             | b3         |
+------------+----------------+------------+
| 0x61       | 0x610000000000 | 0x61       |
+------------+----------------+------------+
1 row in set (0.00 sec)

#'a'的编码值是97（十进制），对应十六进制（61）
#0x610000000000 补够6个字节

#添加数据
insert into t_binary
values('尚','尚','尚');

mysql> insert into t_binary
    -> values('尚','尚','尚');
ERROR 1406 (22001): Data too long for column 'b1' at row 1
#'尚'无论在GBK还是UTF8编码下都不可能是1个字节


#添加数据
insert into t_binary
values('a','尚硅谷','尚硅谷');

mysql> select * from t_binary;
+------------+----------------+----------------+
| b1         | b2             | b3             |
+------------+----------------+----------------+
| 0x61       | 0x610000000000 | 0x61           |
| 0x61       | 0xC9D0B9E8B9C8 | 0xC9D0B9E8B9C8 |
+------------+----------------+----------------+
2 rows in set (0.00 sec)

#添加数据
insert into t_binary
values('a','尚硅谷真好','尚硅谷尚硅谷真好');

mysql> insert into t_binary
    -> values('a','尚硅谷真好','尚硅谷尚硅谷真好');
ERROR 1406 (22001): Data too long for column 'b2' at row 1


#添加数据
insert into t_binary
values('a','尚硅','尚硅');

mysql> select * from t_binary;
+------------+----------------+----------------+
| b1         | b2             | b3             |
+------------+----------------+----------------+
| 0x61       | 0x610000000000 | 0x61           |
| 0x61       | 0xC9D0B9E8B9C8 | 0xC9D0B9E8B9C8 |
| 0x61       | 0xE5B09AE7A185 | 0xE5B09AE7A185 |   #可视化工具中添加的，基于UTF8的
| 0x61       | 0xC9D0B9E80000 | 0xC9D0B9E8     |   #命令行添加的，基于GBK
+------------+----------------+----------------+
4 rows in set (0.00 sec)


#查询表中b1字段值为'a'的记录
select * from t_binary where b1 = 'a';

#查询表中b1字段值为'A'的记录
select * from t_binary where b1 = 'A';

mysql> select * from t_binary where b1 = 'a';
+------------+----------------+----------------+
| b1         | b2             | b3             |
+------------+----------------+----------------+
| 0x61       | 0x610000000000 | 0x61           |
| 0x61       | 0xC9D0B9E8B9C8 | 0xC9D0B9E8B9C8 |
| 0x61       | 0xE5B09AE7A185 | 0xE5B09AE7A185 |
| 0x61       | 0xC9D0B9E80000 | 0xC9D0B9E8     |
+------------+----------------+----------------+
4 rows in set (0.00 sec)

mysql> select * from t_binary where b1 = 'A';


#在char和varchar类型的表格中查询
#查询表中c1字段值为'a'的记录
select * from t_char where c1 = 'a';

#查询表中c1字段值为'A'的记录
select * from t_char where c1 = 'A';

mysql> select * from t_char where c1 = 'a';
+------+------+------+
| c1   | c2   | c3   |
+------+------+------+
| a    | a    | a    |
+------+------+------+
1 row in set (0.00 sec)

mysql> select * from t_char where c1 = 'A';
+------+------+------+
| c1   | c2   | c3   |
+------+------+------+
| a    | a    | a    |
+------+------+------+
1 row in set (0.00 sec)