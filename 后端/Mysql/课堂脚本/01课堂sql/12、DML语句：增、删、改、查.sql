#��ʾ�����ģ��򵥵�DML���
#����tempdb���ݿ���ʾ
create database tempdb;
use tempdb;

#����teacher��
create table teacher(
	id int,
	name varchar(20),
	gender enum('m','f'),
	birthday date,
	salary double,
	tel varchar(11)
);

#�鿴teacher��ṹ
mysql> desc teacher;
+----------+---------------+------+-----+---------+-------+
| Field    | Type          | Null | Key | Default | Extra |
+----------+---------------+------+-----+---------+-------+
| id       | int           | YES  |     | NULL    |       |
| name     | varchar(20)   | YES  |     | NULL    |       |
| gender   | enum('m','f') | YES  |     | NULL    |       |
| birthday | date          | YES  |     | NULL    |       |
| salary   | double        | YES  |     | NULL    |       |
| tel      | char(18)      | YES  |     | NULL    |       |
+----------+---------------+------+-----+---------+-------+
6 rows in set (0.01 sec)


#�������
#��1����һ��������������ֶθ�ֵ
insert into ������ values(ֵ�б�);  
#�������Ҫ��(ֵ�б�)��ÿһ��ֵ�����͡�˳�����ṹһһ��Ӧ
#�����м����ֶΣ�(ֵ�б�)�����м���ֵ�����ܶ�Ҳ������
#ֵ������ַ������������ͣ���Ҫ�ӵ�����

#���磺���һ����¼��teacher��
insert into teacher values
(1,'����','m','1998-7-8',15000.0,'18256953685');

#���磺���һ����¼��teacher��
insert into teacher values
(2,'����','f','1998-7-8',15000.0); #���˵绰����

mysql> insert into teacher values
    -> (2,'����','f','1998-7-8',15000.0);
ERROR 1136 (21S01): Column count doesn't match value count at row 1'
#(ֵ�б�)��ֵ�������ͱ�ṹ��column�е�������һ�¡�

#���磺���һ����¼��teacher��
insert into teacher values
(2,'����','f','�����긣Է',15000.0,'18256953685'); #������д��Ϊ��ַ

mysql> insert into teacher values
    -> (2,'����','f','�����긣Է',15000.0,'18256953685');
ERROR 1292 (22007): Incorrect date value: '�����긣Է' for column 'birthday' at row 1
#���ڸ�ʽ����

#��2���ڶ���������������ֶθ�ֵ
insert into ������ (�����ֶ��б�) values(ֵ�б�);
#��ʱ(ֵ�б�)�е�ֵ����������ʽ��˳����(�����ֶ��б�)��Ӧ����

#���磺���һ����¼��teacher��ֻ��id��name�ֶθ�ֵ
insert into teacher (id,name) values (2,'����'); 

mysql> select * from teacher;
+------+------+--------+------------+--------+-------------+
| id   | name | gender | birthday   | salary | tel         |
+------+------+--------+------------+--------+-------------+
|    1 | ���� | m      | 1998-07-08 |  15000 | 18256953685 |
|    2 | ���� | NULL   | NULL       |   NULL | NULL        | 
+------+------+--------+------------+--------+-------------+
2 rows in set (0.00 sec)
#û�и�ֵ���ֶζ���Ĭ��ֵ����ʱĬ��ֵ��NULL
#�����������ĳ���ֶ������ˡ��ǿ�NOT NULL��Լ������û����ǰָ����Ĭ��ֵ����
#��ô�����ʱû�и�ֵ�Ļ����ᱨ��������ʾ�ǿ�Լ����

#��3��һ����Ӷ�����¼
insert into ������  values(ֵ�б�1),(ֵ�б�2)...;
insert into ������ (�����ֶ��б�) values(ֵ�б�),(ֵ�б�2)...;
#����һ��insert����м���(ֵ�б�)�ͱ�ʾ��Ӽ��м�¼��
#ÿһ��ֵ�б�ֱ��ʹ�ö��ŷָ�

#��Ӷ�����¼��teacher��
insert into teacher (id,name) values
 (3,'����'),
 (4,'����'),
 (5,'��־��'),
 (6,'��ҵ��'),
 (7,'ţ����');
 
 #�鿴����
 mysql> select * from teacher;
+------+--------+--------+------------+--------+-------------+
| id   | name   | gender | birthday   | salary | tel         |
+------+--------+--------+------------+--------+-------------+
|    1 | ����   | m      | 1998-07-08 |  15000 | 18256953685 |
|    2 | ����   | NULL   | NULL       |   NULL | NULL        |
|    3 | ����   | NULL   | NULL       |   NULL | NULL        |
|    4 | ����   | NULL   | NULL       |   NULL | NULL        |
|    5 | ��־�� | NULL   | NULL       |   NULL | NULL        |
|    6 | ��ҵ�� | NULL   | NULL       |   NULL | NULL        |
|    7 | ţ���� | NULL   | NULL       |   NULL | NULL        |
+------+--------+--------+------------+--------+-------------+
7 rows in set (0.00 sec)

#��ѯ����
#��ѯ�������������������
select * from ������;

#���磺�鿴teacher������м�¼
select * from teacher;

mysql> select * from teacher;
+------+------+--------+------------+--------+-------------+
| id   | name | gender | birthday   | salary | tel         |
+------+------+--------+------------+--------+-------------+
|    1 | ���� | m      | 1998-07-08 |  15000 | 18256953685 |
+------+------+--------+------------+--------+-------------+
1 row in set (0.00 sec)

#��ѯ�����ֶ�
select �ֶ����б� from ������;

#���磺��ѯteacher�����м�¼��name��gender
select name,gender from teacher;

mysql> select name,gender from teacher;
+--------+--------+
| name   | gender |
+--------+--------+
| ����   | m      |
| ����   | NULL   |
| ����   | NULL   |
| ����   | NULL   |
| ��־�� | NULL   |
| ��ҵ�� | NULL   |
| ţ���� | NULL   |
+--------+--------+
7 rows in set (0.00 sec)

#��ѯ������
select * from ������ where ����;
select �ֶ��б� from ������ where ����;

#ֻ��ѯteacher���е绰���벻Ϊ�յļ�¼
select * from teacher where tel is not null;

mysql> select * from teacher where tel is not null;
+------+------+--------+------------+--------+-------------+
| id   | name | gender | birthday   | salary | tel         |
+------+------+--------+------------+--------+-------------+
|    1 | ���� | m      | 1998-07-08 |  15000 | 18256953685 |
+------+------+--------+------------+--------+-------------+
1 row in set (0.00 sec)

#ֻ��ѯteacher���е绰���벻Ϊ�յ�Ա�������͵绰����
select name,tel from teacher where tel is not null;

mysql> select name,tel from teacher where tel is not null;
+------+-------------+
| name | tel         |
+------+-------------+
| ���� | 18256953685 |
+------+-------------+
1 row in set (0.00 sec)

mysql> select name,tel from teacher where tel = null;#������û������ж�null������=
Empty set (0.00 sec)

mysql> select name,tel from teacher where tel == null;  #����mysql�бȽϲ���==
ERROR 1064 (42000): You have an error in your SQL syntax; 
check the manual that corresponds to your MySQL server version 
for the right syntax to use near '== null' at line 1


#��ѯ����ʱ�����Ը���ѯ������ֶ�ȡ����
select �ֶ��� as ����,�ֶ���as ���� from ������ where ����;

#��ѯteacher������ݣ���ʾnameΪ������telΪ�绰
select name as "����", tel as "�绰" from teacher;
#ȡ����ʱ������ʡ��as������ֶεı�����û�пո�����������ַ���
���߱�������ؼ��ֵȳ�ͻ������ʡ��""��

#ȥ�ظ�
select distinct �ֶ��б�  from ������ where ����;

#���һ���ظ���¼��teacher��
insert into teacher values
(1,'����','m','1998-7-8',15000.0,'18256953685');

#��ѯteacher������ݣ�ȥ�ظ�
select distinct * from teacher;

mysql> select distinct * from teacher;
+------+--------+--------+------------+--------+-------------+
| id   | name   | gender | birthday   | salary | tel         |
+------+--------+--------+------------+--------+-------------+
|    1 | ����   | m      | 1998-07-08 |  15000 | 18256953685 |
|    2 | ����   | NULL   | NULL       |   NULL | NULL        |
|    3 | ����   | NULL   | NULL       |   NULL | NULL        |
|    4 | ����   | NULL   | NULL       |   NULL | NULL        |
|    5 | ��־�� | NULL   | NULL       |   NULL | NULL        |
|    6 | ��ҵ�� | NULL   | NULL       |   NULL | NULL        |
|    7 | ţ���� | NULL   | NULL       |   NULL | NULL        |
+------+--------+--------+------------+--------+-------------+
7 rows in set (0.00 sec)

#��Ӽ�����¼
insert into teacher(id,name,gender) values
(8,'��','f'),
(9,'��','m'),
(10,'��','f');

#��ѯ��teacher�������е��Ա�ֵ
select gender from teacher;
mysql> select gender from teacher;
+--------+
| gender |
+--------+
| m      |
| NULL   |
| NULL   |
| NULL   |
| NULL   |
| NULL   |
| NULL   |
| m      |
| f      |
| m      |
| f      |
+--------+
11 rows in set (0.00 sec)

#��ѯ��teacher�������е��Ա�ֵ��ȥ���ظ�ֵ
select distinct gender from teacher;
mysql> select distinct gender from teacher;
+--------+
| gender |
+--------+
| m      |
| NULL   |
| f      |
+--------+
3 rows in set (0.00 sec)

#�޸�����
update ������ set �ֶ���1 = ��ֵ, �ֶ���1 = ��ֵ, ...;
#���˵��û�и�update����where��������ô���޸������е�ֵ��

update ������ set �ֶ���1 = ��ֵ, �ֶ���1 = ��ֵ, ... where ����;
#���˵������update����where��������ôֵ���޸������������е�ֵ��

#�޸�teacher���salary�ֶ�Ϊ10000
update teacher set salary = 10000;

mysql> select * from teacher;
+------+--------+--------+------------+--------+-------------+
| id   | name   | gender | birthday   | salary | tel         |
+------+--------+--------+------------+--------+-------------+
|    1 | ����   | m      | 1998-07-08 |  10000 | 18256953685 |
|    2 | ����   | NULL   | NULL       |  10000 | NULL        |
|    3 | ����   | NULL   | NULL       |  10000 | NULL        |
|    4 | ����   | NULL   | NULL       |  10000 | NULL        |
|    5 | ��־�� | NULL   | NULL       |  10000 | NULL        |
|    6 | ��ҵ�� | NULL   | NULL       |  10000 | NULL        |
|    7 | ţ���� | NULL   | NULL       |  10000 | NULL        |
|    1 | ����   | m      | 1998-07-08 |  10000 | 18256953685 |
|    8 | ��     | f      | NULL       |  10000 | NULL        |
|    9 | ��     | m      | NULL       |  10000 | NULL        |
|   10 | ��     | f      | NULL       |  10000 | NULL        |
+------+--------+--------+------------+--------+-------------+
11 rows in set (0.00 sec)

#�޸�teacher��������salary�ֶ�Ϊ20000
update teacher set salary = 20000 where name = '����'; #mysql�бȽ�ֵ�����=

mysql> select * from teacher;
+------+--------+--------+------------+--------+-------------+
| id   | name   | gender | birthday   | salary | tel         |
+------+--------+--------+------------+--------+-------------+
|    1 | ����   | m      | 1998-07-08 |  20000 | 18256953685 |
|    2 | ����   | NULL   | NULL       |  10000 | NULL        |
|    3 | ����   | NULL   | NULL       |  10000 | NULL        |
|    4 | ����   | NULL   | NULL       |  10000 | NULL        |
|    5 | ��־�� | NULL   | NULL       |  10000 | NULL        |
|    6 | ��ҵ�� | NULL   | NULL       |  10000 | NULL        |
|    7 | ţ���� | NULL   | NULL       |  10000 | NULL        |
|    1 | ����   | m      | 1998-07-08 |  20000 | 18256953685 |
|    8 | ��     | f      | NULL       |  10000 | NULL        |
|    9 | ��     | m      | NULL       |  10000 | NULL        |
|   10 | ��     | f      | NULL       |  10000 | NULL        |
+------+--------+--------+------------+--------+-------------+
11 rows in set (0.00 sec)


#ɾ��������
delete from ������;
#���˵��û�и�delete����where��������ô��ɾ�������С�

delete from ������ where ����;
#���˵����delete����where��������ôֻ��ɾ�������������С�

#ɾ��teacher���������¼
delete from teacher where name ='����';

mysql> select * from teacher;
+------+--------+--------+----------+--------+------+
| id   | name   | gender | birthday | salary | tel  |
+------+--------+--------+----------+--------+------+
|    2 | ����   | NULL   | NULL     |  10000 | NULL |
|    3 | ����   | NULL   | NULL     |  10000 | NULL |
|    4 | ����   | NULL   | NULL     |  10000 | NULL |
|    5 | ��־�� | NULL   | NULL     |  10000 | NULL |
|    6 | ��ҵ�� | NULL   | NULL     |  10000 | NULL |
|    7 | ţ���� | NULL   | NULL     |  10000 | NULL |
|    8 | ��     | f      | NULL     |  10000 | NULL |
|    9 | ��     | m      | NULL     |  10000 | NULL |
|   10 | ��     | f      | NULL     |  10000 | NULL |
+------+--------+--------+----------+--------+------+
9 rows in set (0.00 sec)

#ͬѧ�ʣ��Ƿ����ɾ��salary�ֶε�ֵ���ֶ����ţ�ֵɾ��
#����ʵ�֣����ǲ�����delete����update

#ͬѧ�ʣ��Ƿ����ɾ��salary�ֶΣ���ͬ�ֶκ�����ֶε����ݶ���ɾ��
#����ʵ�֣����ǲ�����delete����alter table ������ drop column �ֶ���;

#ͬѧ�ʣ�ֻɾ��ĳ����Ԫ���ֵ
#����ʵ�֣����ǲ�����delete����update

#ɾ��teacher�����м�¼
delete from teacher;

mysql> desc teacher; #��ṹ����
+----------+---------------+------+-----+---------+-------+
| Field    | Type          | Null | Key | Default | Extra |
+----------+---------------+------+-----+---------+-------+
| id       | int           | YES  |     | NULL    |       |
| name     | varchar(20)   | YES  |     | NULL    |       |
| gender   | enum('m','f') | YES  |     | NULL    |       |
| birthday | date          | YES  |     | NULL    |       |
| salary   | double        | YES  |     | NULL    |       |
| tel      | char(18)      | YES  |     | NULL    |       |
+----------+---------------+------+-----+---------+-------+
6 rows in set (0.01 sec)

mysql> select * from teacher; #���������
Empty set (0.00 sec)

#�ضϱ�����ʵ��ɾ�������������ݵ�Ч����
truncate ������;

#��Ӽ�����¼��teacher��
insert into teacher (id,name) values
 (3,'����'),
 (4,'����'),
 (5,'��־��'),
 (6,'��ҵ��'),
 (7,'ţ����');
 
 #�ض�teacher��
 truncate teacher;
 
 mysql> desc teacher;
+----------+---------------+------+-----+---------+-------+
| Field    | Type          | Null | Key | Default | Extra |
+----------+---------------+------+-----+---------+-------+
| id       | int           | YES  |     | NULL    |       |
| name     | varchar(20)   | YES  |     | NULL    |       |
| gender   | enum('m','f') | YES  |     | NULL    |       |
| birthday | date          | YES  |     | NULL    |       |
| salary   | double        | YES  |     | NULL    |       |
| tel      | char(18)      | YES  |     | NULL    |       |
+----------+---------------+------+-----+---------+-------+
6 rows in set (0.01 sec)

truncate�ضϱ��ǰѱ�drop�������½�һ��ȫ�µģ�Ч�ʹ������ǲ�֧������ع������ܺ�ڣ���
deleteɾ����¼��һ��һ��ɾ���ģ���������������в������ύ֮ǰ֧�ֻع���
