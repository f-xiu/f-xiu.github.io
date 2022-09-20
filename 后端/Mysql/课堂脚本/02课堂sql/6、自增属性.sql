#��ʾ��������
/*
1�����ã���ĳ���ֶ��Զ���ֵ�����ֵ��һֱ�������ӣ�
���û��������ŵģ�ÿ������1.

2���ؼ��֣�auto_increment

3��Ҫ��
��1��һ����ֻ����һ�������ֶΣ���Ϊһ����ֻ��һ��AUTO_INCREMENT���Լ�¼�����ֶ�ֵ
��2�����������ֶ�ֻ����key�ֶΣ���������������Ψһ���ȼ�Լ�����ֶΡ�
һ�㶼�Ǹ�������Ψһ����������
��3�������ֶ�Ӧ������ֵ���ͣ�һ�㶼���������͡�
��4��AUTO_INCREMENT����ֵ ���� > ��ǰ�����ֶε����ֵ
*/

#������
create table emp(
	eid int auto_increment,
	ename varchar(20)
);

mysql> create table emp(
    ->  eid int auto_increment,
    ->  ename varchar(20)
    -> );
ERROR 1075 (42000): Incorrect table definition; 
there can be only one auto column and it must be defined as a key


create table emp(
	eid int primary key auto_increment,
	ename varchar(20)
);

#�������
insert into emp(ename) values('����');#���������ֶ�ָ��ֵ��Ҳ������
insert into emp values(null,'����'); #�������ֶθ�ֵNULL��Ҳ������

mysql> select * from emp;
+-----+-------+
| eid | ename |
+-----+-------+
|   1 | ����  |
|   2 | ����  |
+-----+-------+
2 rows in set (0.00 sec)

insert into emp values(0,'����'); #�������ֶθ�ֵ0��Ҳ������

mysql> select * from emp;
+-----+-------+
| eid | ename |
+-----+-------+
|   1 | ����  |
|   2 | ����  |
|   3 | ����  |
+-----+-------+
3 rows in set (0.00 sec)


insert into emp values(-5,'����'); #�������ֶθ�ֵ-5��<3)

mysql> select * from emp;
+-----+-------+
| eid | ename |
+-----+-------+
|  -5 | ����  |
|   1 | ����  |
|   2 | ����  |
|   3 | ����  |
+-----+-------+
4 rows in set (0.00 sec)

insert into emp values(null,'����');

mysql> select * from emp;
+-----+-------+
| eid | ename |
+-----+-------+
|  -5 | ����  |
|   1 | ����  |
|   2 | ����  |
|   3 | ����  |
|   4 | ����  |
+-----+-------+
5 rows in set (0.00 sec)

#�鿴����
show create table emp;

mysql> show create table emp\G
*************************** 1. row ***************************
       Table: emp
Create Table: CREATE TABLE `emp` (
  `eid` int NOT NULL AUTO_INCREMENT,
  `ename` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`eid`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci
1 row in set (0.00 sec)


insert into emp values(15, '��');#�������ֶθ�ֵ15��>5��

mysql> select * from emp;
+-----+-------+
| eid | ename |
+-----+-------+
|  -5 | ����  |
|   1 | ����  |
|   2 | ����  |
|   3 | ����  |
|   4 | ����  |
|  15 | ��    |
+-----+-------+
6 rows in set (0.00 sec)

mysql> show create table emp\G
*************************** 1. row ***************************
       Table: emp
Create Table: CREATE TABLE `emp` (
  `eid` int NOT NULL AUTO_INCREMENT,
  `ename` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`eid`)
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci
1 row in set (0.00 sec)

#���ۣ����ֶ��������ֶθ�ֵʱ��
#������ֵ���ڵ�ǰ��AUTO_INCREMENT�����Լ�¼������ֵʱ�����޸ġ�AUTO_INCREMENT������ֵ��
#�´ξʹ����ֵ����������



insert into emp values(7, '��');#�������ֶθ�ֵ7��<16��


mysql> select * from emp;
+-----+-------+
| eid | ename |
+-----+-------+
|  -5 | ����  |
|   1 | ����  |
|   2 | ����  |
|   3 | ����  |
|   4 | ����  |
|   7 | ��    |
|  15 | ��    |
+-----+-------+
7 rows in set (0.00 sec)


mysql> show create table emp\G
*************************** 1. row ***************************
       Table: emp
Create Table: CREATE TABLE `emp` (
  `eid` int NOT NULL AUTO_INCREMENT,
  `ename` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`eid`)
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci
1 row in set (0.00 sec)

#������ʵ�ʿ����У���Ҫ�����޸ġ�AUTO_INCREMENT����ֵ�������Զ�ά����


#�޸ġ�AUTO_INCREMENT����ֵ
alter table ������ AUTO_INCREMENT = ��ֵ;

#�޸�emp��AUTO_INCREMENTֵΪ18
alter table emp AUTO_INCREMENT = 18;


mysql> show create table emp\G
*************************** 1. row ***************************
       Table: emp
Create Table: CREATE TABLE `emp` (
  `eid` int NOT NULL AUTO_INCREMENT,
  `ename` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`eid`)
) ENGINE=InnoDB AUTO_INCREMENT=18 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci
1 row in set (0.00 sec)

#�޸�emp��AUTO_INCREMENTֵΪ8
alter table emp AUTO_INCREMENT = 8;

mysql> show create table emp\G
*************************** 1. row ***************************
       Table: emp
Create Table: CREATE TABLE `emp` (
  `eid` int NOT NULL AUTO_INCREMENT,
  `ename` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`eid`)
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci
1 row in set (0.00 sec)

#���ۣ�������insert��仹��alter��䣬AUTO_INCREMENTֵ�������޸�Ϊ<��ǰ�����ֶ�����ֵ��


#ɾ����������
alter table ������ modify ��column�� �ֶ��� ��������;

#�鿴��ṹ
desc emp;
mysql> desc emp;
+-------+-------------+------+-----+---------+----------------+
| Field | Type        | Null | Key | Default | Extra          |
+-------+-------------+------+-----+---------+----------------+
| eid   | int         | NO   | PRI | NULL    | auto_increment |
| ename | varchar(20) | YES  |     | NULL    |                |
+-------+-------------+------+-----+---------+----------------+
2 rows in set (0.01 sec)

#ɾ��eid�ֶε���������
alter table emp modify column eid int;

mysql> desc emp;
+-------+-------------+------+-----+---------+-------+
| Field | Type        | Null | Key | Default | Extra |
+-------+-------------+------+-----+---------+-------+
| eid   | int         | NO   | PRI | NULL    |       |
| ename | varchar(20) | YES  |     | NULL    |       |
+-------+-------------+------+-----+---------+-------+
2 rows in set (0.00 sec)

#modify��Ӱ���м�Լ����Ĭ��ֵ���ǿյ�Լ������Լ����������Ψһ��������Ӱ�졣

#����������������
alter table ������ modify ��column�� �ֶ��� �������� auto_increment;

#��eid�ֶε������������
alter table emp modify column eid int auto_increment;

mysql> desc emp;
+-------+-------------+------+-----+---------+----------------+
| Field | Type        | Null | Key | Default | Extra          |
+-------+-------------+------+-----+---------+----------------+
| eid   | int         | NO   | PRI | NULL    | auto_increment |
| ename | varchar(20) | YES  |     | NULL    |                |
+-------+-------------+------+-----+---------+----------------+
2 rows in set (0.00 sec)