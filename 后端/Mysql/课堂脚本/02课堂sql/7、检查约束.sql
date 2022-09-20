#��ʾ���Լ��

/*
1�����ã�
�޶�ĳ���ֶ�ֵ�Ƿ�����ĳ��������

2���ؼ��֣�check 

3���ص㣺
��1��mysql8.0֮ǰ��mysql֧�ּ��Լ�����﷨�����ǲ������á�
��2��mysql8�м��Լ�����Զ������ֶκ��棬ͨ�����ֻ�޶������ֶε�ȡֵ��Χ��
                 Ҳ���Զ������ֶ����棬ͨ�����޶������ֶ�֮ǰ��ȡֵ������
��3�������Ƕ������ֶκ��棬��Ȼ��ʱ�������ֶ�û��ϵ��Ҳ�ǵ��ɱ�Լ������
��ϵͳinformation_schema.table_constraints���п��Կ���Լ����Ϣ��
*/

#��������޶�age>=18
create table emp(
	id int primary key auto_increment,
	name varchar(20) not null,
	age int check(age>=18)
);

#mysql5.7��������
insert into emp values(null,'����',8);

mysql> select * from emp;
+----+------+------+
| id | name | age  |
+----+------+------+
|  1 | ���� |    8 | #mysql5.7���Լ��û��������
+----+------+------+
1 row in set (0.00 sec)

#mysql8.0.26��������
mysql> insert into emp values(null,'����',8);
ERROR 3819 (HY000): Check constraint 'emp_chk_1' is violated.

#�ڽ���ʱ������ָ�����Լ��
create table ������(
	�ֶ���1 �������� check(����),  #���ֶκ���ֱ�ӼӼ��Լ��
	�ֶ���2 ��������,
	�ֶ���3 ��������,
	check (����)  #�����޶������ֶ�֮���ȡֵ����
);

create table emp(
	id int primary key auto_increment,
	name varchar(20) not null,
	age int check(age>=18), #�м�Լ��
	birthday date not null, #��������
	hiredate date not null, #��ְ����
	check( year(hiredate)-year(birthday)>=18)  #year(hiredate)��ʾȡ����ְ���ڵ����ֵ
);

#�������
insert into emp values(null,'����',23,'2000-1-1','2021-11-30');#��������

mysql> select * from emp;
+----+------+------+------------+------------+
| id | name | age  | birthday   | hiredate   |
+----+------+------+------------+------------+
|  1 | ���� |   23 | 2000-01-01 | 2021-11-30 |
+----+------+------+------------+------------+
1 row in set (0.00 sec)

#�������
insert into emp values(null,'����',8,'2013-1-1','2021-11-30');#����������

mysql> insert into emp values(null,'����',8,'2013-1-1','2021-11-30');
ERROR 3819 (HY000): Check constraint 'emp_chk_1' is violated.

insert into emp values(null,'����',28,'2013-1-1','2021-11-30');#����������
mysql> insert into emp values(null,'����',28,'2013-1-1','2021-11-30');#����������
ERROR 3819 (HY000): Check constraint 'emp_chk_2' is violated.


#�鿴��ṹ
desc emp;

#�鿴��Ķ���
show create table emp;

mysql> show create table emp\G
*************************** 1. row ***************************
       Table: emp
Create Table: CREATE TABLE `emp` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(20) NOT NULL,
  `age` int DEFAULT NULL,
  `birthday` date NOT NULL,
  `hiredate` date NOT NULL,
  PRIMARY KEY (`id`),
  CONSTRAINT `emp_chk_1` CHECK ((`age` >= 18)),
  CONSTRAINT `emp_chk_2` CHECK (((year(`hiredate`) - year(`birthday`)) >= 18))
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci
1 row in set (0.00 sec)

#��ѯϵͳ����Լ����鿴���Լ��
SELECT * FROM information_schema.table_constraints WHERE table_name = '������';

#�鿴emp���Լ��
SELECT * FROM information_schema.table_constraints WHERE table_name = 'emp';
#ֻ��������Ψһ������������Լ���������������п�����Ĭ��ֵ���ǿ������ǿ�������

mysql> SELECT * FROM information_schema.table_constraints WHERE table_name = 'emp';
+--------------------+-------------------+-----------------+--------------+------------+-----------------+----------+
| CONSTRAINT_CATALOG | CONSTRAINT_SCHEMA | CONSTRAINT_NAME | TABLE_SCHEMA | TABLE_NAME | CONSTRAINT_TYPE | ENFORCED |
+--------------------+-------------------+-----------------+--------------+------------+-----------------+----------+
| def                | atguigu           | PRIMARY         | atguigu      | emp        | PRIMARY KEY     | YES      |
| def                | atguigu           | emp_chk_1       | atguigu      | emp        | CHECK           | YES      |
| def                | atguigu           | emp_chk_2       | atguigu      | emp        | CHECK           | YES      |
+--------------------+-------------------+-----------------+--------------+------------+-----------------+----------+
3 rows in set (0.00 sec)

#���ɾ�����Լ��
alter table ������ drop check ���Լ����;

#ɾ��emp��� age�ֶεļ��Լ�� ��emp_chk_1 ��
#ɾ��emp��� hiredate��birthday�ֶεļ��Լ�� ��emp_chk_2��

alter table emp drop check emp_chk_1;
alter table emp drop check emp_chk_2;

mysql> SELECT * FROM information_schema.table_constraints WHERE table_name = 'emp';
+--------------------+-------------------+-----------------+--------------+------------+-----------------+----------+
| CONSTRAINT_CATALOG | CONSTRAINT_SCHEMA | CONSTRAINT_NAME | TABLE_SCHEMA | TABLE_NAME | CONSTRAINT_TYPE | ENFORCED |
+--------------------+-------------------+-----------------+--------------+------------+-----------------+----------+
| def                | atguigu           | PRIMARY         | atguigu      | emp        | PRIMARY KEY     | YES      |
+--------------------+-------------------+-----------------+--------------+------------+-----------------+----------+
1 row in set (0.01 sec)

mysql> show create table emp\G
*************************** 1. row ***************************
       Table: emp
Create Table: CREATE TABLE `emp` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(20) NOT NULL,
  `age` int DEFAULT NULL,
  `birthday` date NOT NULL,
  `hiredate` date NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci
1 row in set (0.00 sec)

#����ڽ������Ӽ��Լ��
#ʹ��modify����������
alter table ������ modify ��column�� �ֶ��� �������� check(����); #�м�Լ��
#��age�ֶ���Ӽ��Լ�� age>=18
alter table emp modify age int check(age>=18);#�����﷨��û���⣬����û������������
insert into emp values(null,'����',6,'1998-5-1','2021-1-2');#��ӳɹ���˵�����Լ��û��������

#����ڽ������Ӽ��Լ����ʹ��add check
alter table ������ add check(����);

#��age�ֶ���Ӽ��Լ�� age>=18
alter table emp add check(age>=18);

mysql> alter table emp add check(age>=18);
ERROR 3819 (HY000): Check constraint 'emp_chk_1' is violated.
#��Ϊ������Υ��  (age>=18)�����ݣ������ȴ���


mysql> select * from emp;
+----+------+------+------------+------------+
| id | name | age  | birthday   | hiredate   |
+----+------+------+------------+------------+
|  1 | ���� |   23 | 2000-01-01 | 2021-11-30 |
|  2 | ���� |    6 | 1998-05-01 | 2021-01-02 |
+----+------+------+------------+------------+
2 rows in set (0.00 sec)

update emp set age = 26 where id = 2;

#��age�ֶ���Ӽ��Լ�� age>=18
alter table emp add check(age>=18);
insert into emp values(null,'����',6,'1998-5-1','2021-1-2');



