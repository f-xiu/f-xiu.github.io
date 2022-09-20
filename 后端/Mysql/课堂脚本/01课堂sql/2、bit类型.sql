#��ʾbit���ͣ��洢�����ƣ�ֻ��0��1
#����һ�����
create table t_bit(
	b1 bit,  #û��ָ��(M)��Ĭ����1λ������
	b2 bit(4) #�ܹ��洢4λ������0000~1111
);

#�鿴��ṹ
desc t_bit;

mysql> desc t_bit;
+-------+--------+------+-----+---------+-------+
| Field | Type   | Null | Key | Default | Extra |
+-------+--------+------+-----+---------+-------+
| b1    | bit(1) | YES  |     | NULL    |       |
| b2    | bit(4) | YES  |     | NULL    |       |
+-------+--------+------+-----+---------+-------+
2 rows in set (0.01 sec)

#��Ӽ�¼
insert into t_bit values(1,1);

#�鿴����
select * from t_bit;

mysql> select * from t_bit;
+------------+------------+
| b1         | b2         |
+------------+------------+
| 0x01       | 0x01       |  #0x��ͷ��ʾʮ������
+------------+------------+
1 row in set (0.00 sec)

#��ʾ������ֵ����Ҫʹ��bin����
select bin(b1),bin(b2) from t_bit;

mysql> select bin(b1),bin(b2) from t_bit;
+---------+---------+
| bin(b1) | bin(b2) |
+---------+---------+
| 1       | 1       |
+---------+---------+
1 row in set (0.00 sec)

#��Ӽ�¼
insert into t_bit values(2,2);

mysql> insert into t_bit values(2,2); 
#values()����ʮ����ֵ����ҪתΪ�����ƴ洢��2��Ӧ10������1λ��b1�治��
ERROR 1406 (22001): Data too long for column 'b1' at row 1

#��Ӽ�¼
insert into t_bit values(1,8);

#�鿴����
select * from t_bit;

mysql> select * from t_bit;
+------------+------------+
| b1         | b2         |
+------------+------------+
| 0x01       | 0x01       |
| 0x01       | 0x08       |
+------------+------------+
2 rows in set (0.00 sec)


#��ʾ������ֵ����Ҫʹ��bin����
select bin(b1),bin(b2) from t_bit;

mysql> select bin(b1),bin(b2) from t_bit;
+---------+---------+
| bin(b1) | bin(b2) |
+---------+---------+
| 1       | 1       |
| 1       | 1000    |
+---------+---------+
2 rows in set (0.00 sec)

#��Ӽ�¼
insert into t_bit values(1,16); #16�Ķ�����10000
mysql> insert into t_bit values(1,16);
ERROR 1406 (22001): Data too long for column 'b2' at row 1