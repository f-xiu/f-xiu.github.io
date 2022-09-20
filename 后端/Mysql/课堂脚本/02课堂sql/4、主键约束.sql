#��ʾ����Լ��
/*
1�����ã�
����Լ��������Ψһ�ı�ʶһ�м�¼��
���߻��仰˵�����в�������������޷����ֵļ�¼��

�ʣ�Ψһ��Լ�����Ϳ���ʵ����
��Ψһ��Լ����Ϊû���޶��ǿգ����ܳ�������NULL��

ѧ��  ����  ���֤���루Ψһ����
1	  ����  524265198235684255
2	  ����  524265198235684266
3	  ����  NULL
3	  ����  NULL

2���ؼ��֣�primary key
3���ص�
��1��ÿһ�������ֻ�ܶ���һ������Լ����
��2������Լ������Ҫ��Ψһ��Ҫ��ǿ�
���Կ��� ����Լ�� = �ǿ�Լ�� + Ψһ��Լ��
������ȫ�ȼۡ�

4��Ψһ��Լ��������Լ��������
��1��Ψһ��Լ��һ��������кü�����
��������Լ��ֻ��һ��
��2��Ψһ��Լ���������ǿ����ƣ������Ҫ�ǿգ���Ҫ�������塣
����Լ�������ٶ���NOT NULL������ʹ��ǿ����ơ�
*/

#����ʱ��ָ������Լ��
create table ������(
	�ֶ��� �������� primary key,
	�ֶ��� �������� not null,
	�ֶ��� �������� not null unique key,
	�ֶ��� �������� not null unique key,
	�ֶ��� �������� unique key,
	�ֶ��� �������� unique key
	�ֶ��� ��������
);

create table ������(
	�ֶ��� �������� ,
	�ֶ��� �������� not null,
	�ֶ��� �������� not null unique key,
	�ֶ��� �������� not null unique key,
	�ֶ��� �������� unique key,
	�ֶ��� �������� unique key
	�ֶ��� ��������,
	primary key(�ֶ���),
	unique key(�ֶ���)
);

mysql> drop database atguigu;
Query OK, 19 rows affected (0.17 sec)

mysql> create database atguigu;
Query OK, 1 row affected (0.01 sec)

mysql> use atguigu;
Database changed

#����Ա����
create table emp(
	id int primary key,
	ename varchar(20) not null,
	cardid char(18) unique key not null, #�ǿղ���Ψһ
	tel char(11) unique key, #ֻ��Ψһ������Ϊ��
	address varchar(100) #�ȿ���Ϊnull���ֿ����ظ�
);

#�鿴��ṹ
desc emp;

mysql> desc emp;
+---------+--------------+------+-----+---------+-------+
| Field   | Type         | Null | Key | Default | Extra |
+---------+--------------+------+-----+---------+-------+
| id      | int          | NO   | PRI | NULL    |       |
| ename   | varchar(20)  | NO   |     | NULL    |       |
| cardid  | char(18)     | NO   | UNI | NULL    |       |
| tel     | char(11)     | YES  | UNI | NULL    |       |
| address | varchar(100) | YES  |     | NULL    |       |
+---------+--------------+------+-----+---------+-------+
5 rows in set (0.01 sec)

#�������
insert into emp 
values(1,'����','524265198235684255','18536955456',null);

#�������
insert into emp 
values(2,'����','524265198235685255',null,null);#tel����Ϊnull

mysql> select * from emp;
+----+-------+--------------------+-------------+---------+
| id | ename | cardid             | tel         | address |
+----+-------+--------------------+-------------+---------+
|  1 | ����  | 524265198235684255 | 18536955456 | NULL    |
|  2 | ����  | 524265198235685255 | NULL        | NULL    |
+----+-------+--------------------+-------------+---------+
2 rows in set (0.00 sec)

#�������
insert into emp 
values(3,'����','524265198235685895',null,null);

#�������
insert into emp 
values(3,'����','524265198235675895',null,null);#�����ظ�

mysql> #�������
mysql> insert into emp
    -> values(3,'����','524265198235675895',null,null);#�����ظ�
ERROR 1062 (23000): Duplicate entry '3' for key 'emp.PRIMARY'


#�������
insert into emp 
values(null,'����','524265198235675775',null,null);#����Ϊnull

mysql> insert into emp
    -> values(null,'����','524265198235675775',null,null);#����Ϊnull
ERROR 1048 (23000): Column 'id' cannot be null


#����һ���������ֶ���������
create table xuanke(
	sid int primary key,
	cid int primary key,
	score int
);

mysql> create table xuanke(
    ->  sid int primary key,  #�����������������Ǹ�����������˼
    ->  cid int primary key,  #�����������������Ǹ�����������˼
    ->  score int
    ->
    -> );
ERROR 1068 (42000): Multiple primary key defined

#�������Լ��
#ѧ����
create table stu(
	id int,
	name varchar(20)
);

#���ѧ����Ϣ
insert into stu values(1,'����');
insert into stu values(2,'����');

mysql> select * from stu;
+------+------+
| id   | name |
+------+------+
|    1 | ���� |
|    2 | ���� |
+------+------+
2 rows in set (0.00 sec)

#�γ̱�
create table course(
	id int,
	title varchar(50)
);

#��ӿγ���Ϣ
insert into course values(1,'java');
insert into course values(2,'mysql');

mysql> select * from course;
+------+-------+
| id   | title |
+------+-------+
|    1 | java  |
|    2 | mysql |
+------+-------+
2 rows in set (0.00 sec)

#����ѡ�α�
create table xuanke(
	sid int,
	cid int,
	score int,
	primary key(sid,cid)  #���/��������
);

insert into xuanke values(1,1,96),(2,1,85),(1,2,75),(2,2,45);

#����ظ���������
insert into xuanke values(1,1,75);
mysql> insert into xuanke values(1,1,75);
ERROR 1062 (23000): Duplicate entry '1-1' for key 'xuanke.PRIMARY'


#�鿴һ�±�Ķ���
show create table emp;
show create table xuanke;

#�鿴emp���xuanke�������
show index from emp;
show index from xuanke;

mysql> show index from emp;
+-------+------------+----------+--------------+-------------+-----------+-------------+----------+--------+------+------------+---------+---------------+---------+------------+
| Table | Non_unique | Key_name | Seq_in_index | Column_name | Collation | Cardinality | Sub_part | Packed | Null | Index_type | Comment | Index_comment | Visible | Expression |
+-------+------------+----------+--------------+-------------+-----------+-------------+----------+--------+------+------------+---------+---------------+---------+------------+
| emp   |          0 | PRIMARY  |            1 | id          | A         |           2 |     NULL |   NULL |      | BTREE      |         |               | YES     | NULL       |
| emp   |          0 | cardid   |            1 | cardid      | A         |           2 |     NULL |   NULL |      | BTREE      |         |               | YES     | NULL       |
| emp   |          0 | tel      |            1 | tel         | A         |           2 |     NULL |   NULL | YES  | BTREE      |         |               | YES     | NULL       |
+-------+------------+----------+--------------+-------------+-----------+-------------+----------+--------+------+------------+---------+---------------+---------+------------+
3 rows in set (0.01 sec)

mysql> show index from xuanke;
+--------+------------+----------+--------------+-------------+-----------+-------------+----------+--------+------+------------+---------+---------------+---------+------------+
| Table  | Non_unique | Key_name | Seq_in_index | Column_name | Collation | Cardinality | Sub_part | Packed | Null | Index_type | Comment | Index_comment | Visible | Expression |
+--------+------------+----------+--------------+-------------+-----------+-------------+----------+--------+------+------------+---------+---------------+---------+------------+
| xuanke |          0 | PRIMARY  |            1 | sid         | A         |           2 |     NULL |   NULL |      | BTREE      |         |               | YES     | NULL       |
| xuanke |          0 | PRIMARY  |            2 | cid         | A         |           4 |     NULL |   NULL |      | BTREE      |         |               | YES     | NULL       |
+--------+------------+----------+--------------+-------------+-----------+-------------+----------+--------+------+------------+---------+---------------+---------+------------+
2 rows in set (0.01 sec)

#�Ƿ����ɾ������Լ��
alter table ������ drop primary key;
#��Ϊһ����ֻ��һ��Ψһ��Լ�������Բ�������ָ�����֡�

#ɾ��xuanke�������Լ��
alter table xuanke drop primary key;

mysql> show index from xuanke;
Empty set (0.00 sec)

mysql> desc xuanke;
+-------+------+------+-----+---------+-------+
| Field | Type | Null | Key | Default | Extra |
+-------+------+------+-----+---------+-------+
| sid   | int  | NO   |     | NULL    |       |
| cid   | int  | NO   |     | NULL    |       |
| score | int  | YES  |     | NULL    |       |
+-------+------+------+-----+---------+-------+
3 rows in set (0.00 sec)

#ɾ������Լ��ʱ����Ӧ����������Լ��ɾ���ˣ���������Լ���Դ��ķǿ�Լ��û��ɾ����
#���Ҫȥ���Ļ�����Ҫ��ɾ���ǿ�Լ���ķ�ʽ������ɾ����

#�������������Լ��
alter table ������ add primary key(�ֶ���); #��ʾ��1���ֶ���������Լ��
alter table ������ add primary key(�ֶ���1,�ֶ���2); #��ʾ���ӵ��Ǹ�������

alter table xuanke add primary key(sid,cid);

mysql> desc xuanke;
+-------+------+------+-----+---------+-------+
| Field | Type | Null | Key | Default | Extra |
+-------+------+------+-----+---------+-------+
| sid   | int  | NO   | PRI | NULL    |       |
| cid   | int  | NO   | PRI | NULL    |       |
| score | int  | YES  |     | NULL    |       |
+-------+------+------+-----+---------+-------+
3 rows in set (0.01 sec)

#ɾ��emp������Լ��
alter table emp drop primary key;

mysql> desc emp;
+---------+--------------+------+-----+---------+-------+
| Field   | Type         | Null | Key | Default | Extra |
+---------+--------------+------+-----+---------+-------+
| id      | int          | NO   |     | NULL    |       |
| ename   | varchar(20)  | NO   |     | NULL    |       |
| cardid  | char(18)     | NO   | PRI | NULL    |       | #�Զ���cardidʶ��Ϊ��������Ϊcardid������Ψһ��+�ǿ�Լ�������ǲ�ͬ������������
| tel     | char(11)     | YES  | UNI | NULL    |       |
| address | varchar(100) | YES  |     | NULL    |       |
+---------+--------------+------+-----+---------+-------+
5 rows in set (0.01 sec)

show index from emp;

mysql> show index from emp;
+-------+------------+----------+--------------+-------------+-----------+-------------+----------+--------+------+------------+---------+---------------+---------+------------+
| Table | Non_unique | Key_name | Seq_in_index | Column_name | Collation | Cardinality | Sub_part | Packed | Null | Index_type | Comment | Index_comment | Visible | Expression |
+-------+------------+----------+--------------+-------------+-----------+-------------+----------+--------+------+------------+---------+---------------+---------+------------+
| emp   |          0 | cardid   |            1 | cardid      | A         |           2 |     NULL |   NULL |      | BTREE      |         |               | YES     | NULL       |
| emp   |          0 | tel      |            1 | tel         | A         |           2 |     NULL |   NULL | YES  | BTREE      |         |               | YES     | NULL       |
+-------+------------+----------+--------------+-------------+-----------+-------------+----------+--------+------+------------+---------+---------------+---------+------------+
2 rows in set (0.00 sec)

#��emp���id�ֶ���������Լ��
alter table emp add primary key(id);

mysql> show index from emp;
+-------+------------+----------+--------------+-------------+-----------+-------------+----------+--------+------+------------+---------+---------------+---------+------------+
| Table | Non_unique | Key_name | Seq_in_index | Column_name | Collation | Cardinality | Sub_part | Packed | Null | Index_type | Comment | Index_comment | Visible | Expression |
+-------+------------+----------+--------------+-------------+-----------+-------------+----------+--------+------+------------+---------+---------------+---------+------------+
| emp   |          0 | PRIMARY  |            1 | id          | A         |           2 |     NULL |   NULL |      | BTREE      |         |               | YES     | NULL       |
| emp   |          0 | cardid   |            1 | cardid      | A         |           2 |     NULL |   NULL |      | BTREE      |         |               | YES     | NULL       |
| emp   |          0 | tel      |            1 | tel         | A         |           2 |     NULL |   NULL | YES  | BTREE      |         |               | YES     | NULL       |
+-------+------------+----------+--------------+-------------+-----------+-------------+----------+--------+------+------------+---------+---------------+---------+------------+
3 rows in set (0.00 sec)


#ѧ���ʣ�ɾ������Լ���������ظ��𣿴��ǵ�
alter table emp drop primary key;
mysql> select * from emp;
+----+-------+--------------------+-------------+---------+
| id | ename | cardid             | tel         | address |
+----+-------+--------------------+-------------+---------+
|  1 | ����  | 524265198235684255 | 18536955456 | NULL    |
|  2 | ����  | 524265198235685255 | NULL        | NULL    |
|  3 | ����  | 524265198235685895 | NULL        | NULL    |
+----+-------+--------------------+-------------+---------+
3 rows in set (0.00 sec)

insert into emp values(3,'����','524233198235685895',null,null);
mysql> select * from emp;
+----+-------+--------------------+-------------+---------+
| id | ename | cardid             | tel         | address |
+----+-------+--------------------+-------------+---------+
|  3 | ����  | 524233198235685895 | NULL        | NULL    |
|  1 | ����  | 524265198235684255 | 18536955456 | NULL    |
|  2 | ����  | 524265198235685255 | NULL        | NULL    |
|  3 | ����  | 524265198235685895 | NULL        | NULL    |
+----+-------+--------------------+-------------+---------+
4 rows in set (0.00 sec)
