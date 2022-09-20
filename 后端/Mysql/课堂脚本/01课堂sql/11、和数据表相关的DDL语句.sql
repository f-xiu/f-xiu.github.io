#��ʾ�����ݱ���ص�DDL���
#Ϊ�˷������������ʾ�������ǰ��ȷ������ĸ����ݿ�ı����ʾ
#ʹ�����ݿ�
use atguigu;

#�鿴��ǰ��¼�û��ڱ������ܹ����������б��
show tables;

#���ǰ��û��use��䣬�����ڵ�ǰuse����£�Ҫ�鿴��һ�����ݿ�ı��
show tables from ���ݿ���;

#���磺�鿴��ǰ���ݿ�ı��
show tables;
#���磺�ڵ�ǰuse atguigu;���棬�鿴mysql��ı��
show tables from mysql;

#�������
create table ������(
	�ֶ���1 ��������1,
	�ֶ���2 ��������2  #�������û�������ֶλ�Լ���Ķ��壬����Ͳ��ü�,
);

#���磺����һ��teacher��
/*
������š��������Ա𡢳������ڡ�н�ʡ��绰����
*/
create table teacher(
	id int,
	name varchar(20),
	gender enum('��','Ů'),
	birthday date,
	salary double,
	tel varchar(11)
);

#�鿴��ṹ
desc ������;
describe ������;

#���磺�鿴teacher��Ľṹ
desc teacher;
describe teacher;

mysql> describe teacher;
+----------+-----------------+------+-----+---------+-------+
| Field    | Type            | Null | Key | Default | Extra |
+----------+-----------------+------+-----+---------+-------+
| id       | int             | YES  |     | NULL    |       |
| name     | varchar(20)     | YES  |     | NULL    |       |
| gender   | enum('��','Ů') | YES  |     | NULL    |       |
| birthday | date            | YES  |     | NULL    |       |
| salary   | double          | YES  |     | NULL    |       |
| tel      | varchar(11)     | YES  |     | NULL    |       |
+----------+-----------------+------+-----+---------+-------+
6 rows in set (0.00 sec)

#�鿴������ϸ����
show create table ������;

#���磺�鿴teacher��Ķ������
show create table teacher;

mysql> show create table teacher\G
*************************** 1. row ***************************
       Table: teacher
Create Table: CREATE TABLE `teacher` (
  `id` int DEFAULT NULL,
  `name` varchar(20) DEFAULT NULL,
  `gender` enum('��','Ů') DEFAULT NULL,
  `birthday` date DEFAULT NULL,
  `salary` double DEFAULT NULL,
  `tel` varchar(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci
1 row in set (0.00 sec)

#�޸ı�ṹ
#����һ���ֶ�
alter table ������ add column �ֶ��� ��������;
#column��ʾ�У��ֶΣ�����ʡ��

#���磺��teacher������һ��address varchar(100)�ֶ�
alter table teacher add column address varchar(100);

mysql> desc teacher;
+----------+-----------------+------+-----+---------+-------+
| Field    | Type            | Null | Key | Default | Extra |
+----------+-----------------+------+-----+---------+-------+
| id       | int             | YES  |     | NULL    |       |
| name     | varchar(20)     | YES  |     | NULL    |       |
| gender   | enum('��','Ů') | YES  |     | NULL    |       |
| birthday | date            | YES  |     | NULL    |       |
| salary   | double          | YES  |     | NULL    |       |
| tel      | varchar(11)     | YES  |     | NULL    |       |
| address  | varchar(100)    | YES  |     | NULL    |       |
+----------+-----------------+------+-----+---------+-------+
7 rows in set (0.00 sec)


#��ĳ���ֶκ�������һ���ֶ�
alter table ������ add column �ֶ��� �������� after ��һ���ֶ�;
#column��ʾ�У��ֶΣ�����ʡ��

#���磺��teacher������һ��cardid char(18)�ֶΣ����ӵ�name����
alter table teacher add column cardid char(18) after name;

mysql> desc teacher;
+----------+-----------------+------+-----+---------+-------+
| Field    | Type            | Null | Key | Default | Extra |
+----------+-----------------+------+-----+---------+-------+
| id       | int             | YES  |     | NULL    |       |
| name     | varchar(20)     | YES  |     | NULL    |       |
| cardid   | char(18)        | YES  |     | NULL    |       |
| gender   | enum('��','Ů') | YES  |     | NULL    |       |
| birthday | date            | YES  |     | NULL    |       |
| salary   | double          | YES  |     | NULL    |       |
| tel      | varchar(11)     | YES  |     | NULL    |       |
| address  | varchar(100)    | YES  |     | NULL    |       |
+----------+-----------------+------+-----+---------+-------+
8 rows in set (0.00 sec)

#����һ���ֶΣ���Ϊ��һ���ֶ�
alter table ������ add column �ֶ��� �������� first;
#column��ʾ�У��ֶΣ�����ʡ��

#���磺��teacher������һ��age int�ֶΣ����ӵ�idǰ��
alter table teacher add column age int first;

mysql> desc teacher;
+----------+-----------------+------+-----+---------+-------+
| Field    | Type            | Null | Key | Default | Extra |
+----------+-----------------+------+-----+---------+-------+
| age      | int             | YES  |     | NULL    |       |
| id       | int             | YES  |     | NULL    |       |
| name     | varchar(20)     | YES  |     | NULL    |       |
| cardid   | char(18)        | YES  |     | NULL    |       |
| gender   | enum('��','Ů') | YES  |     | NULL    |       |
| birthday | date            | YES  |     | NULL    |       |
| salary   | double          | YES  |     | NULL    |       |
| tel      | varchar(11)     | YES  |     | NULL    |       |
| address  | varchar(100)    | YES  |     | NULL    |       |
+----------+-----------------+------+-----+---------+-------+
9 rows in set (0.01 sec)


#ɾ���ֶ�
alter table ������ drop column �ֶ���;
#column����ʡ��

#���磺ɾ��teacher���age�ֶ�
alter table teacher drop column age;

mysql> desc teacher;
+----------+-----------------+------+-----+---------+-------+
| Field    | Type            | Null | Key | Default | Extra |
+----------+-----------------+------+-----+---------+-------+
| id       | int             | YES  |     | NULL    |       |
| name     | varchar(20)     | YES  |     | NULL    |       |
| cardid   | char(18)        | YES  |     | NULL    |       |
| gender   | enum('��','Ů') | YES  |     | NULL    |       |
| birthday | date            | YES  |     | NULL    |       |
| salary   | double          | YES  |     | NULL    |       |
| tel      | varchar(11)     | YES  |     | NULL    |       |
| address  | varchar(100)    | YES  |     | NULL    |       |
+----------+-----------------+------+-----+---------+-------+
8 rows in set (0.00 sec)

#�޸��ֶε���������
alter table ������ modify column �ֶ��� �µ���������;

#���磺�޸�teacher���salary�ֶΣ����������޸�Ϊdouble(10,2)
alter table teacher modify column salary double(10,2);

mysql> desc teacher;
+----------+-----------------+------+-----+---------+-------+
| Field    | Type            | Null | Key | Default | Extra |
+----------+-----------------+------+-----+---------+-------+
| id       | int             | YES  |     | NULL    |       |
| name     | varchar(20)     | YES  |     | NULL    |       |
| cardid   | char(18)        | YES  |     | NULL    |       |
| gender   | enum('��','Ů') | YES  |     | NULL    |       |
| birthday | date            | YES  |     | NULL    |       |
| salary   | double(10,2)    | YES  |     | NULL    |       |
| tel      | varchar(11)     | YES  |     | NULL    |       |
| address  | varchar(100)    | YES  |     | NULL    |       |
+----------+-----------------+------+-----+---------+-------+
8 rows in set (0.00 sec)

#�޸��ֶε�����
alter table ������ change column ���ֶ��� �µ��ֶ��� ��������;

#���磺�޸�teacher���tel�ֶΣ��ֶ����޸�Ϊtelphone
alter table teacher change column tel telphone char(18);

mysql> desc teacher;
+----------+-----------------+------+-----+---------+-------+
| Field    | Type            | Null | Key | Default | Extra |
+----------+-----------------+------+-----+---------+-------+
| id       | int             | YES  |     | NULL    |       |
| name     | varchar(20)     | YES  |     | NULL    |       |
| cardid   | char(18)        | YES  |     | NULL    |       |
| gender   | enum('��','Ů') | YES  |     | NULL    |       |
| birthday | date            | YES  |     | NULL    |       |
| salary   | double(10,2)    | YES  |     | NULL    |       |
| telphone | char(18)        | YES  |     | NULL    |       |
| address  | varchar(100)    | YES  |     | NULL    |       |
+----------+-----------------+------+-----+---------+-------+
8 rows in set (0.01 sec)

#�޸��ֶε�˳��
alter table ������ modify column �ֶ��� �������� after ��һ���ֶ�;
alter table ������ modify column �ֶ��� �������� first;

#���磬��teacher���salary������telphone����
alter table teacher modify column salary double(10,2) after telphone;

mysql> desc teacher;
+----------+-----------------+------+-----+---------+-------+
| Field    | Type            | Null | Key | Default | Extra |
+----------+-----------------+------+-----+---------+-------+
| id       | int             | YES  |     | NULL    |       |
| name     | varchar(20)     | YES  |     | NULL    |       |
| cardid   | char(18)        | YES  |     | NULL    |       |
| gender   | enum('��','Ů') | YES  |     | NULL    |       |
| birthday | date            | YES  |     | NULL    |       |
| telphone | char(18)        | YES  |     | NULL    |       |
| salary   | double(10,2)    | YES  |     | NULL    |       |
| address  | varchar(100)    | YES  |     | NULL    |       |
+----------+-----------------+------+-----+---------+-------+
8 rows in set (0.00 sec)


#�޸ı�����
rename table �ɱ����� to �±�����;
alter table ������ rename �±�����;


#��teacher��������Ϊjiaoshi
rename table teacher to jiaoshi;

#��jiaoshi��������Ϊteacher
alter table jiaoshi rename teacher;


#ɾ����ṹ������һ��ɾ����
drop table ������;

#ɾ��teacher���
drop table teacher;

create database tempdb;

show create database tempdb;

alter database tempdb CHARACTER SET Latin1 COLLATE Latin1_general_ci;

use tempdb;

create table teacher(
	id int,
	name varchar(20),
	gender enum('��','Ů'),
	birthday date,
	salary double,
	tel varchar(11)
);
ERROR 1291 (HY000): Column 'gender' has duplicated value '?' in ENUM

create table teacher(
	id int,
	name varchar(20),
	gender enum('m','f'),
	birthday date,
	salary double,
	tel varchar(11)
);

show create table teacher\G

mysql> show create table teacher\G
*************************** 1. row ***************************
       Table: teacher
Create Table: CREATE TABLE `teacher` (
  `id` int DEFAULT NULL,
  `name` varchar(20) COLLATE latin1_general_ci DEFAULT NULL,
  `gender` enum('m','f') COLLATE latin1_general_ci DEFAULT NULL,
  `birthday` date DEFAULT NULL,
  `salary` double DEFAULT NULL,
  `tel` varchar(11) COLLATE latin1_general_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_general_ci
1 row in set (0.01 sec)

alter database tempdb CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci;

#�޸ı���ַ�����У�Թ���
alter table ������ CHARACTER SET �ַ������� COLLATE У�Թ���

#���磬�޸�teacher����ַ�����У�Թ���
alter table teacher CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci;

#�޸��ֶ��ַ�����У�Թ���
alter table ������ modify column �ֶ��� �������� 
CHARACTER SET �ַ������� COLLATE У�Թ���;

#���磺�޸�teacher���name�ֶ��ַ�����У�Թ���
alter table teacher modify column name varchar(20)
 CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci;

alter table teacher modify column gender enum('m','f')
 CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci; 

alter table teacher modify column tel char(18)
 CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci; 

 