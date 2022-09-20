#演示bit类型，存储二进制，只有0和1
#创建一个表格
create table t_bit(
	b1 bit,  #没有指定(M)，默认是1位二进制
	b2 bit(4) #能够存储4位二进制0000~1111
);

#查看表结构
desc t_bit;

mysql> desc t_bit;
+-------+--------+------+-----+---------+-------+
| Field | Type   | Null | Key | Default | Extra |
+-------+--------+------+-----+---------+-------+
| b1    | bit(1) | YES  |     | NULL    |       |
| b2    | bit(4) | YES  |     | NULL    |       |
+-------+--------+------+-----+---------+-------+
2 rows in set (0.01 sec)

#添加记录
insert into t_bit values(1,1);

#查看数据
select * from t_bit;

mysql> select * from t_bit;
+------------+------------+
| b1         | b2         |
+------------+------------+
| 0x01       | 0x01       |  #0x开头表示十六进制
+------------+------------+
1 row in set (0.00 sec)

#显示二进制值，需要使用bin函数
select bin(b1),bin(b2) from t_bit;

mysql> select bin(b1),bin(b2) from t_bit;
+---------+---------+
| bin(b1) | bin(b2) |
+---------+---------+
| 1       | 1       |
+---------+---------+
1 row in set (0.00 sec)

#添加记录
insert into t_bit values(2,2);

mysql> insert into t_bit values(2,2); 
#values()中是十进制值，需要转为二进制存储，2对应10，超过1位，b1存不下
ERROR 1406 (22001): Data too long for column 'b1' at row 1

#添加记录
insert into t_bit values(1,8);

#查看数据
select * from t_bit;

mysql> select * from t_bit;
+------------+------------+
| b1         | b2         |
+------------+------------+
| 0x01       | 0x01       |
| 0x01       | 0x08       |
+------------+------------+
2 rows in set (0.00 sec)


#显示二进制值，需要使用bin函数
select bin(b1),bin(b2) from t_bit;

mysql> select bin(b1),bin(b2) from t_bit;
+---------+---------+
| bin(b1) | bin(b2) |
+---------+---------+
| 1       | 1       |
| 1       | 1000    |
+---------+---------+
2 rows in set (0.00 sec)

#添加记录
insert into t_bit values(1,16); #16的二进制10000
mysql> insert into t_bit values(1,16);
ERROR 1406 (22001): Data too long for column 'b2' at row 1