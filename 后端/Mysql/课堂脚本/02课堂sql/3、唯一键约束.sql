/*��ʾΨһ��Լ��
1�����ã��޶�ĳ���ֶε�ֵ�������ظ���
���������NULLֵ�����ظ���

2���ؼ��֣�unique key ����key����ʡ��

3���ص�
һ��������кܶ��Ψһ��Լ����
ÿһ��Ψһ��Լ���ֶζ����Զ�����������
*/

#�ڽ���ʱ������ָ��Ψһ��Լ��
create table ������(
	�ֶ��� �������� unique key,  #unique key����ֱ�Ӽ����ֶκ���
	�ֶ��� �������� unique key,
	�ֶ��� ��������
);

create table ������(
	�ֶ��� ��������,
	�ֶ��� ��������,
	�ֶ��� ��������,
	unique key(�ֶ���), #unique keyҲ�������ֶ��б����浥������
	unique key(�ֶ���)
);

#����һ������޶���š����֤������ֻ�����Ψһ
create table emp(
	id int unique key,  #��ʾid�ֶ�ֵ�����ظ�
	name varchar(20),
	cardid char(18),
	tel char(11),
	unique key(cardid),  #��ʾcardid�ֶ�ֵ�����ظ�
	unique key(tel)  #��ʾtel�ֶ�ֵ�����ظ�
);

#�鿴��ṹ
desc emp;
mysql> desc emp;
+--------+-------------+------+-----+---------+-------+
| Field  | Type        | Null | Key | Default | Extra |
+--------+-------------+------+-----+---------+-------+
| id     | int         | YES  | UNI | NULL    |       |
| name   | varchar(20) | YES  |     | NULL    |       |
| cardid | char(18)    | YES  | UNI | NULL    |       |
| tel    | char(11)    | YES  | UNI | NULL    |       |
+--------+-------------+------+-----+---------+-------+
4 rows in set (0.01 sec)

#�鿴��Ķ������
show create table emp;

mysql> show create table emp\G
*************************** 1. row ***************************
       Table: emp
Create Table: CREATE TABLE `emp` (
  `id` int DEFAULT NULL,
  `name` varchar(20) DEFAULT NULL,
  `cardid` char(18) DEFAULT NULL,
  `tel` char(11) DEFAULT NULL,
  UNIQUE KEY `id` (`id`),
  UNIQUE KEY `cardid` (`cardid`),
  UNIQUE KEY `tel` (`tel`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci
1 row in set (0.00 sec)

#�������
insert into emp values(1,'����','25678544522222','13589587585');
insert into emp values(2,'����','25678544522211','13589587596');

#��ѯ����
select * from emp;

insert into emp values(3,'����','25678544522233','13589587596');
#�ֻ������ظ�������

mysql> insert into emp values(3,'����','25678544522233','13589587596');
ERROR 1062 (23000): Duplicate�����ơ��ظ��� entry�����룩 '13589587596' for key 'emp.tel'


insert into emp values
(3,'����',null,null),
(4,'����',null,null);

mysql> select * from emp;
+------+------+----------------+-------------+
| id   | name | cardid         | tel         |
+------+------+----------------+-------------+
|    1 | ���� | 25678544522222 | 13589587585 |
|    2 | ���� | 25678544522211 | 13589587596 |
|    3 | ���� | NULL           | NULL        | #NULL�����ظ�
|    4 | ���� | NULL           | NULL        |
+------+------+----------------+-------------+
4 rows in set (0.00 sec)


#��β鿴һ���������
show index from ������;

#�鿴emp�������
show index from emp;

mysql> show index from emp;
+-------+------------+----------+--------------+-------------+-----------+-------------+----------+--------+------+------------+---------+---------------+---------+------------+
| Table | Non_unique | Key_name | Seq_in_index | Column_name | Collation | Cardinality | Sub_part | Packed | Null | Index_type | Comment | Index_comment | Visible | Expression |
+-------+------------+----------+--------------+-------------+-----------+-------------+----------+--------+------+------------+---------+---------------+---------+------------+
| emp   |          0 | id       |            1 | id          | A         |           4 |     NULL |   NULL | YES  | BTREE      |         |               | YES     | NULL       |
| emp   |          0 | cardid   |            1 | cardid      | A         |           3 |     NULL |   NULL | YES  | BTREE      |         |               | YES     | NULL       |
| emp   |          0 | tel      |            1 | tel         | A         |           3 |     NULL |   NULL | YES  | BTREE      |         |               | YES     | NULL       |
+-------+------------+----------+--------------+-------------+-----------+-------------+----------+--------+------+------------+---------+---------------+---------+------------+
3 rows in set (0.00 sec)

#ɾ��Ψһ��Լ��
alter table ������ drop index ������;
#�����ָ��Ψһ��Լ��ʱ��û���ֶ��������֣�Ĭ�Ͼ����ֶ���;
#��������ɾ��ʱ��show index���鿴һ��������

#ɾ��emp���cardid��Ψһ��Լ��
alter table emp drop index cardid;

mysql> show index from emp;
+-------+------------+----------+--------------+-------------+-----------+-------------+----------+--------+------+------------+---------+---------------+---------+------------+
| Table | Non_unique | Key_name | Seq_in_index | Column_name | Collation | Cardinality | Sub_part | Packed | Null | Index_type | Comment | Index_comment | Visible | Expression |
+-------+------------+----------+--------------+-------------+-----------+-------------+----------+--------+------+------------+---------+---------------+---------+------------+
| emp   |          0 | id       |            1 | id          | A         |           4 |     NULL |   NULL | YES  | BTREE      |         |               | YES     | NULL       |
| emp   |          0 | tel      |            1 | tel         | A         |           3 |     NULL |   NULL | YES  | BTREE      |         |               | YES     | NULL       |
+-------+------------+----------+--------------+-------------+-----------+-------------+----------+--------+------+------------+---------+---------------+---------+------------+
2 rows in set (0.01 sec)

mysql> desc emp;
+--------+-------------+------+-----+---------+-------+
| Field  | Type        | Null | Key | Default | Extra |
+--------+-------------+------+-----+---------+-------+
| id     | int         | YES  | UNI | NULL    |       |
| name   | varchar(20) | YES  |     | NULL    |       |
| cardid | char(18)    | YES  |     | NULL    |       |
| tel    | char(11)    | YES  | UNI | NULL    |       |
+--------+-------------+------+-----+---------+-------+
4 rows in set (0.00 sec)

#����ڽ�������Ψһ��Լ��
alter table ������ add unique ��key��(�ֶ���);

#��emp���cardid����Ψһ��Լ��
alter table emp add unique key(cardid);

mysql> desc emp;
+--------+-------------+------+-----+---------+-------+
| Field  | Type        | Null | Key | Default | Extra |
+--------+-------------+------+-----+---------+-------+
| id     | int         | YES  | UNI | NULL    |       |
| name   | varchar(20) | YES  |     | NULL    |       |
| cardid | char(18)    | YES  | UNI | NULL    |       |
| tel    | char(11)    | YES  | UNI | NULL    |       |
+--------+-------------+------+-----+---------+-------+
4 rows in set (0.00 sec)

mysql> show index from emp;
+-------+------------+----------+--------------+-------------+-----------+-------------+----------+--------+------+------------+---------+---------------+---------+------------+
| Table | Non_unique | Key_name | Seq_in_index | Column_name | Collation | Cardinality | Sub_part | Packed | Null | Index_type | Comment | Index_comment | Visible | Expression |
+-------+------------+----------+--------------+-------------+-----------+-------------+----------+--------+------+------------+---------+---------------+---------+------------+
| emp   |          0 | id       |            1 | id          | A         |           4 |     NULL |   NULL | YES  | BTREE      |         |               | YES     | NULL       |
| emp   |          0 | tel      |            1 | tel         | A         |           3 |     NULL |   NULL | YES  | BTREE      |         |               | YES     | NULL       |
| emp   |          0 | cardid   |            1 | cardid      | A         |           3 |     NULL |   NULL | YES  | BTREE      |         |               | YES     | NULL       |
+-------+------------+----------+--------------+-------------+-----------+-------------+----------+--------+------+------------+---------+---------------+---------+------------+
3 rows in set (0.01 sec)

#��һ�������Ψһ��Լ��������Ψһ
#����ʾ�����������ֶ�ֵ�����Ψһ�������ֶο���Ψһ
create table ������(
	�ֶ���1 ��������,
	�ֶ���2 ��������,
	�ֶ���3 ��������,
	�ֶ���4 ��������,
	unique key(�ֶ���1,�ֶ���2),  #��ʾ�ֶ���1���ֶ���2��ϲ����ظ�
								  #�ֶ�1���ֶ�2�������ǿ����ظ���
	unique key(�ֶ���3),	#��ʾ�ֶ�3���������ظ�
	unique key(�ֶ���4)		#��ʾ�ֶ�3���������ظ�
);



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

#ѡ�α�
create table xuanke(
	xid int  unique key, #��ʾxid�����ظ�
	sid int,
	cid int,
	score int,
	unique key(sid,cid) #��ôд��ʾsic��cid����ϲ����ظ���
						#������sid��cid�ǿ����ظ���
);

#���ѡ�γɼ���Ϣ
insert into xuanke values(1,1,1,89);
insert into xuanke values(2,1,2,96);
insert into xuanke values(3,2,1,75);
insert into xuanke values(4,2,2,96);

mysql> select * from xuanke;
+------+------+------+-------+
| xid  | sid  | cid  | score |
+------+------+------+-------+
|    1 |    1 |    1 |    89 |
|    2 |    1 |    2 |    96 |
|    3 |    2 |    1 |    75 |
|    4 |    2 |    2 |    96 |
+------+------+------+-------+
4 rows in set (0.00 sec)
#������sid�ǿ����ظ���
#������cid�ǿ����ظ���
#��Ͽ�sid��cid�ǲ������ظ���

insert into xuanke values(5,1,1,100); #sidΪ1��cidΪ1����ظ�
mysql> insert into xuanke values(5,1,1,100);
ERROR 1062 (23000): Duplicate entry '1-1' for key 'xuanke.sid'

mysql> desc xuanke;
+-------+------+------+-----+---------+-------+
| Field | Type | Null | Key | Default | Extra |
+-------+------+------+-----+---------+-------+
| xid   | int  | YES  | UNI | NULL    |       |
| sid   | int  | YES  | MUL | NULL    |       |
| cid   | int  | YES  |     | NULL    |       |
| score | int  | YES  |     | NULL    |       |
+-------+------+------+-----+---------+-------+
4 rows in set (0.01 sec)

mysql> show index from xuanke;
+--------+------------+----------+--------------+-------------+-----------+-------------+----------+--------+------+------------+---------+---------------+---------+------------+
| Table  | Non_unique | Key_name | Seq_in_index | Column_name | Collation | Cardinality | Sub_part | Packed | Null | Index_type | Comment | Index_comment | Visible | Expression |
+--------+------------+----------+--------------+-------------+-----------+-------------+----------+--------+------+------------+---------+---------------+---------+------------+
| xuanke |          0 | xid      |            1 | xid         | A         |           4 |     NULL |   NULL | YES  | BTREE      |         |               | YES     | NULL       |
| xuanke |          0 | sid      |            1 | sid         | A         |           2 |     NULL |   NULL | YES  | BTREE      |         |               | YES     | NULL       |
| xuanke |          0 | sid      |            2 | cid         | A         |           4 |     NULL |   NULL | YES  | BTREE      |         |               | YES     | NULL       |
+--------+------------+----------+--------------+-------------+-----------+-------------+----------+--------+------+------------+---------+---------------+---------+------------+
3 rows in set (0.01 sec)

#ɾ������Ψһ��Լ��
alter table ������ drop index ������;

alter table xuanke drop index sid;

mysql> show index from xuanke;
+--------+------------+----------+--------------+-------------+-----------+-------------+----------+--------+------+------------+---------+---------------+---------+------------+
| Table  | Non_unique | Key_name | Seq_in_index | Column_name | Collation | Cardinality | Sub_part | Packed | Null | Index_type | Comment | Index_comment | Visible | Expression |
+--------+------------+----------+--------------+-------------+-----------+-------------+----------+--------+------+------------+---------+---------------+---------+------------+
| xuanke |          0 | xid      |            1 | xid         | A         |           4 |     NULL |   NULL | YES  | BTREE      |         |               | YES     | NULL       |
+--------+------------+----------+--------------+-------------+-----------+-------------+----------+--------+------+------------+---------+---------------+---------+------------+
1 row in set (0.00 sec)

mysql> desc xuanke;
+-------+------+------+-----+---------+-------+
| Field | Type | Null | Key | Default | Extra |
+-------+------+------+-----+---------+-------+
| xid   | int  | YES  | UNI | NULL    |       |
| sid   | int  | YES  |     | NULL    |       |
| cid   | int  | YES  |     | NULL    |       |
| score | int  | YES  |     | NULL    |       |
+-------+------+------+-----+---------+-------+
4 rows in set (0.00 sec)
