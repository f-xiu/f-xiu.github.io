#��ʾ��������
#����һ����񣬱������ơ�t_int����
#���������ֶ�i1��i2���ֱ���int��int(2)����
#create table t_int(i1 int,i2 int(2));
create table t_int(
	i1 int,
	i2 int(2)  #û��unsigned zerofill��(2)û������
);

#�鿴��ǰ���ݿ�����б��
show tables;
show tables from ���ݿ���;

#�鿴��ṹ
desc ������;
desc t_int;

mysql> desc t_int;
+-------+------+------+-----+---------+-------+
| Field | Type | Null | Key | Default | Extra |
+-------+------+------+-----+---------+-------+
| i1    | int  | YES  |     | NULL    |       |
| i2    | int  | YES  |     | NULL    |       |
+-------+------+------+-----+---------+-------+
2 rows in set (0.01 sec)

#����һ����񣬱������ơ�t_int2����
#���������ֶ�i1��i2���ֱ���int��int(2)����
create table t_int2(
	i1 int,
	i2 int(2) unsigned zerofill
);

mysql> desc t_int2;
+-------+--------------------------+------+-----+---------+-------+
| Field | Type                     | Null | Key | Default | Extra |
+-------+--------------------------+------+-----+---------+-------+
| i1    | int                      | YES  |     | NULL    |       |
| i2    | int(2) unsigned zerofill | YES  |     | NULL    |       |
+-------+--------------------------+------+-----+---------+-------+
2 rows in set (0.01 sec)

#������ݵ������
insert into ������ values(ֵ�б�);
insert into t_int values(1234,1234);
insert into t_int2 values(1234,1234);

#��ѯ����
select * from ������;
select * from t_int;
select * from t_int2;

#������ݵ������
insert into ������ values(ֵ�б�);
insert into t_int values(1,1);
insert into t_int2 values(1,1);

insert into t_int values(12222228854225548778455,12222228854225548778455);
mysql> insert into t_int values(12222228854225548778455,12222228854225548778455);
ERROR 1264 (22003): Out of range value for column 'i1' at row 
