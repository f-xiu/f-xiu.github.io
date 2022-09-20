#��ʾС������
#�������
create table t_double(
	d1 double,
	d2 double(5,2)  #-999.99~999.99
);

#�鿴��ṹ
desc t_double;

#�������
insert into t_double values(2.5,2.5);

#�鿴����
select * from t_double;
mysql> select * from t_double;
+------+------+
| d1   | d2   |
+------+------+
|  2.5 | 2.50 |#d2�ֶ�С����󲻹�2λ��0����
+------+------+
1 row in set (0.00 sec)

#�������
insert into t_double values(2.5526,2.5526);
insert into t_double values(2.5586,2.5586);

mysql> select * from t_double;
+--------+------+
| d1     | d2   |
+--------+------+
|    2.5 | 2.50 |
| 2.5526 | 2.55 |#С������нض����󣬲��һ���������
| 2.5586 | 2.56 |#С������нض����󣬲��һ���������
+--------+------+
3 rows in set (0.00 sec)


#�������
insert into t_double values(12852.5526,12852.5526);

#d2�ֶ��������ֳ���(5-2=3)λ�����ʧ��
mysql> insert into t_double values(12852.5526,12852.5526); 
ERROR 1264 (22003): Out of range value for column 'd2' at row 1


#�������
create table t_decimal(
	d1 decimal,  #û��ָ��(M,D)Ĭ����(10,0)
	d2 decimal(5,2)
);


#�鿴��ṹ
desc t_decimal;
mysql> desc t_decimal;
+-------+---------------+------+-----+---------+-------+
| Field | Type          | Null | Key | Default | Extra |
+-------+---------------+------+-----+---------+-------+
| d1    | decimal(10,0) | YES  |     | NULL    |       |
| d2    | decimal(5,2)  | YES  |     | NULL    |       |
+-------+---------------+------+-----+---------+-------+
2 rows in set (0.01 sec)

#�������
insert into t_decimal values(2.5,2.5);

#�鿴����
select * from t_decimal;
mysql> select * from t_decimal;
+------+------+
| d1   | d2   |
+------+------+
|    3 | 2.50 |  #d1�ֶ�С�����ض�
+------+------+
1 row in set (0.00 sec)

insert into t_decimal values(12852.5526,12852.5526);

��С����ֵ���������͵��ֶ�ʱ����ض�С�����֣�������������
insert into t_int2 values(1.5,1.5);