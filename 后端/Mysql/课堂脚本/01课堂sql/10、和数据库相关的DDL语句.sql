#��ʾ�����ݿ���ص�DDL���
#�鿴��ǰ��¼�û�����Ȩ�ޣ��鿴�����е����ݿ�
show databases;

#��δ������ݿ�
create database ���ݿ�����;

#���磬�������ݿ�bookstore
create database bookstore;

#�鿴���ݿ�Ķ���
show create database ���ݿ���;

#���磬�鿴bookstore���ݿ�Ķ�����Ϣ
show create database bookstore;
show create database bookstore\G

*************************** 1. row ***************************
       Database: bookstore
Create Database: CREATE DATABASE `bookstore` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci */ /*!80016 DEFAULT ENCRYPTION='N' */
1 row in set (0.00 sec)

#�޸����ݿ�ı����ַ�����У�Թ���
alter database ���ݿ����� CHARACTER SET �ַ������� COLLATE У�Թ���

#�޸�bookstore���ݿ���ַ�����У�Թ���
alter database bookstore CHARACTER SET Latin1 COLLATE Latin1_general_ci;

mysql> show create database bookstore;
+-----------+-----------------------------------------------------------------------------------------------------------------------------------+
| Database  | Create Database                                                                                                                   |
+-----------+-----------------------------------------------------------------------------------------------------------------------------------+
| bookstore | CREATE DATABASE `bookstore` /*!40100 DEFAULT CHARACTER SET latin1 COLLATE latin1_general_ci */ /*!80016 DEFAULT ENCRYPTION='N' */ |
+-----------+-----------------------------------------------------------------------------------------------------------------------------------+
1 row in set (0.00 sec)


#ʹ�����ݿ�
use ���ݿ���;

#���磺ʹ��bookstore���ݿ�
use bookstore;

#�������
create table temp(
	s char
);

#�������
insert into temp values('a');

#��ѯ����
mysql> select * from temp;
+------+
| s    |
+------+
| a    |
+------+
1 row in set (0.00 sec)

#�������
insert into temp values('��');

mysql> insert into temp values('��');
ERROR 1366 (HY000): Incorrect string value: '\xC9\xD0' for column 's' at row 1


#ɾ�����ݿ�
drop database ���ݿ�����;

#���磺ɾ��bookstore���ݿ�
drop database bookstore;



