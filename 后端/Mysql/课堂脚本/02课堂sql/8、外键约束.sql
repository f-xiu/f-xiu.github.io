#��ʾ���Լ��
/*
1�����ã�
�����޶��ӱ�͸�������ù�ϵ��
�ӱ������ֶ�ֵ�����ڸ��౻�����ֶ�ֵ�ķ�Χ�ڡ�

2�����Լ��һ������������Ľ�ɫ��
����һ����Ϊ�ӱ��ֳ�Ϊ�ӱ�����һ����Ϊ�����ֳ�Ϊ������

�ӱ�����ֶε�ֵҪ�Ӹ��������ֶε�ֵ��ѡ��

���磺Ա�����м�¼Ա����Ϣ��������һ���ֶ��ǡ����ű�š�����ʾ���Ա�������Ĳ��š�
      ���ŵ���Ϣ�Ǽ�¼�ڲ��ű��У�
	  ����Ա����ġ����ű�š��ֶε�ֵ����������д����Ҫ�ο�/���á����ű��Ĳ��ż�¼��
	  
	  Ա�������ӱ����ñ��ˣ��ܲ��ű��ǣ��/��Χ��Ͻ��
	  ���ű�ʾ�������������á�
	  
���磺��Ʒ���û���������������ϸ��
		��Ʒ�������¼����Ʒ��Ϣ����Ʒ���ơ��۸񡢿����...��
		�û��������¼���û���Ϣ���û��������롢�˻����...��
		�����������¼�˶�����Ϣ��������š������ܼ۸񡢶�����Ʒ���������ջ��ַ...��
		������ϸ���¼�˶�����ÿһ����ϸ����Ʒ��š�������š��۸�����....��
		
		��������һ�����������ˡ��׷ۡ��������ӡ������ֻ���Ĥ��������ѹ����
		������ţ�112122123222222
		
		��Ʒ��
		1    ���׷ۡ�    52.5	 ....
		2    �����ӡ�    23.0	 ....
		3    ���ֻ���Ĥ��    15.0	 ....
		4    ����ѹ����    125.0	 ....
		
		������ϸ�У�
		�������         ��Ʒ���  ����			�۸�	....
		112122123222222  1			2�����׷ۣ�  52.5	
		112122123222222  2			1����       23.0	
		112122123222222  3			1���ţ�       15.0		
		112122123222222  4			1������       125.0

		
		������ϸ�����ӱ���Ʒ��Ͷ������Ǹ���		

3�����Լ��Ҫ��
��1�����Լ���������ӱ��ж���
��2���ӱ���Ҫ�������Լ�����ֶε��������ͺ��߼����壬����͸����б������ֶε��������͡��߼�����һ����
���磺Ա�����в��ű���ֶ� ����  ���ű��еĲ��ű���ֶ�
      ������ϸ���еĶ������  ����  �������ж������
      ������ϸ���е���Ʒ���  ����  ��Ʒ������Ʒ���
	
��3���ӱ���Ҫ�������Լ�����ֶε����ֺ͸����б������ֶ����ƿ��Բ�ͬ��
��4�������б����õ��ֶα����Ǽ�Լ���ֶΣ�һ�㶼��������Ψһ��Լ����
��ʱ�ӱ�͸���Ĺ�ϵ������һ��һ��һ�Զ�Ĺ�ϵ��
������һ���ӱ���һ��ࡣ

���磺�������ű�һ����¼����Ӧ�ӱ�Ա����������¼��
	  ����������һ����¼����Ӧ�ӱ�������ϸ��һ���������¼��
	  
��5����������ȴ��ڣ�Ȼ�������ȷ�����ӱ�����Լ��
	  

4���ؼ��� foreign key �� references  


5�����Լ��Լ����ʲô��
��1�������˳���Ƚ������ٽ��ӱ�
��2��ɾ���˳����ɾ�ӱ���ɾ����
������ɾ�����Լ����Ȼ��ֱ�ɾ��������˳��������ˣ�
��3�����ӱ�������ݡ��޸�����ֶε����ݣ���Ӱ�죬��ΪҪ�Ӹ���ı������ֶη�Χ��ѡֵ��
��4��ɾ�����޸ĸ���ı������ֶε����ݣ���Ӱ�죬��ΪҪ�������ֵ�Ƿ��ӱ������ˡ�
��5���Ƿ���������Ͳ�ѯ�޹ء�

���������ӵ�������ΪҪ��Լ�����ڰְֵ���Ǯ��Χ�ڡ�
      �ְֵ���ΪҲҪ��Լ������������������ô���ɡ�
	  ˫��������Ӱ�졣
*/

#����ʱ��ָ�����Լ��
create table dept(
	did int primary key auto_increment,
	dname varchar(50) unique key not null
);

create table emp(
	id int primary key auto_increment,
	name varchar(20) not null,
	departmentid int,  #�ӱ������Լ�����ֶ����͸���ı������ֶ�����Ҫ��һ�£������������ͺ��߼�����Ҫһ��
	#���Լ��ֻ�����ֶ��б����浥�����壬�������ֶκ���ֱ�Ӷ���
	foreign key (departmentid) references dept(did)
);

#�鿴��ṹ
desc dept;
desc emp;

mysql> desc dept;
+-------+-------------+------+-----+---------+----------------+
| Field | Type        | Null | Key | Default | Extra          |
+-------+-------------+------+-----+---------+----------------+
| did   | int         | NO   | PRI | NULL    | auto_increment |
| dname | varchar(50) | NO   | UNI | NULL    |                |
+-------+-------------+------+-----+---------+----------------+
2 rows in set (0.01 sec)

mysql> desc emp;
+--------------+-------------+------+-----+---------+----------------+
| Field        | Type        | Null | Key | Default | Extra          |
+--------------+-------------+------+-----+---------+----------------+
| id           | int         | NO   | PRI | NULL    | auto_increment |
| name         | varchar(20) | NO   |     | NULL    |                |
| departmentid | int         | YES  | MUL | NULL    |                |
+--------------+-------------+------+-----+---------+----------------+
3 rows in set (0.00 sec)

#�鿴��Ķ���
show create table dept;
show create table emp;


mysql> show create table dept\G
*************************** 1. row ***************************
       Table: dept
Create Table: CREATE TABLE `dept` (
  `did` int NOT NULL AUTO_INCREMENT,
  `dname` varchar(50) NOT NULL,
  PRIMARY KEY (`did`),
  UNIQUE KEY `dname` (`dname`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci
1 row in set (0.00 sec)

mysql> show create table emp\G
*************************** 1. row ***************************
       Table: emp
Create Table: CREATE TABLE `emp` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(20) NOT NULL,
  `departmentid` int DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `departmentid` (`departmentid`),
  CONSTRAINT `emp_ibfk_1` FOREIGN KEY (`departmentid`) REFERENCES `dept` (`did`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci
1 row in set (0.00 sec)


#�鿴ϵͳ���Լ����
SELECT * FROM information_schema.table_constraints WHERE table_name = '������';

SELECT * FROM information_schema.table_constraints WHERE table_name = 'emp';

mysql> SELECT * FROM information_schema.table_constraints WHERE table_name = 'emp';
+--------------------+-------------------+-----------------+--------------+------------+-----------------+----------+
| CONSTRAINT_CATALOG | CONSTRAINT_SCHEMA | CONSTRAINT_NAME | TABLE_SCHEMA | TABLE_NAME | CONSTRAINT_TYPE | ENFORCED |
+--------------------+-------------------+-----------------+--------------+------------+-----------------+----------+
| def                | atguigu           | PRIMARY         | atguigu      | emp        | PRIMARY KEY     | YES      |
| def                | atguigu           | emp_ibfk_1      | atguigu      | emp        | FOREIGN KEY     | YES      |
+--------------------+-------------------+-----------------+--------------+------------+-----------------+----------+
2 rows in set (0.00 sec)

#��Ӽ�¼
#��Ӹ�����Ϣ��û��Ӱ��
insert into dept values(null,'����'),(null,'��ѧ'),(null,'��ѯ'),(null,'����');

mysql> select * from dept;
+-----+-------+
| did | dname |
+-----+-------+
|   4 | ����  |
|   3 | ��ѯ  |
|   2 | ��ѧ  |
|   1 | ����  |
+-----+-------+
4 rows in set (0.00 sec)

#����ӱ���Ϣ����Ӱ�죬�ܵ�Լ��
insert into emp values(null,'����',1);#�ɹ�
insert into emp values(null,'����',1);#�ɹ�
insert into emp values(null,'����',2);#�ɹ�
insert into emp values(null,'����',6); #ʧ��
#��Ϊdepartmentid=1��2���ڸ���dept�п����ҵ���Ӧ��¼
#��Ϊdepartmentid=6���ڸ���dept���Ҳ�����Ӧ��¼

mysql> insert into emp values(null,'����',6);
ERROR 1452 (23000): Cannot add����ӣ� or update���޸ģ� a child(�ӱ� row����¼/�У�:
 a foreign key constraint fails 
 (`atguigu`.`emp`, CONSTRAINT `emp_ibfk_1` FOREIGN KEY (`departmentid`) REFERENCES `dept` (`did`))

mysql> select * from emp;
+----+------+--------------+
| id | name | departmentid |
+----+------+--------------+
|  1 | ���� |            1 |
|  2 | ���� |            1 |
|  3 | ���� |            2 |
+----+------+--------------+
3 rows in set (0.00 sec)


#�޸��ӱ������ֶε���Ϣ����Ӱ�죬�ܵ�Լ��
update emp set departmentid = 3 where id = 1;#�ɹ�
#��Ϊdepartmentid = 3�ڸ���dept�п����ҵ���Ӧ����

update emp set departmentid = 6 where id = 3; #ʧ��  
#��Ϊdepartmentid = 6�ڸ���dept���Ҳ�����Ӧ����

mysql> update emp set departmentid = 6 where id = 3;
ERROR 1452 (23000): Cannot add or update a child row: 
a foreign key constraint fails (`atguigu`.`emp`, CONSTRAINT `emp_ibfk_1` FOREIGN KEY (`departmentid`) REFERENCES `dept` (`did`))


mysql> select * from emp;
+----+------+--------------+
| id | name | departmentid |
+----+------+--------------+
|  1 | ���� |            3 |
|  2 | ���� |            1 |
|  3 | ���� |            2 |
+----+------+--------------+
3 rows in set (0.00 sec)

mysql> select * from dept;
+-----+-------+
| did | dname |
+-----+-------+
|   4 | ����  |
|   3 | ��ѯ  |
|   2 | ��ѧ  |
|   1 | ����  |
+-----+-------+
4 rows in set (0.00 sec)


#�޸ĸ���ı������ֶε�ֵ����Լ��
update dept set did = 6 where did = 1;#ʧ��
#��Ϊdid=1�Ĳ��ű��ӱ�����
update dept set did = 6 where did = 4;#�ɹ�
#��Ϊ did=4�Ĳ���û�б��ӱ�����

mysql> update dept set did = 6 where did = 1;
ERROR 1451 (23000): Cannot delete��ɾ���� or update���޸ģ� a parent������ row����¼/�У�:
 a foreign key constraint fails 
 (`atguigu`.`emp`, CONSTRAINT `emp_ibfk_1` FOREIGN KEY (`departmentid`) REFERENCES `dept` (`did`))


mysql> select * from dept;
+-----+-------+
| did | dname |
+-----+-------+
|   6 | ����  |
|   3 | ��ѯ  |
|   2 | ��ѧ  |
|   1 | ����  |
+-----+-------+
4 rows in set (0.00 sec)

#ɾ������ļ�¼����Լ��
delete from dept where did = 6; #�ɹ�
#��Ϊ did=6�Ĳ���û�б��ӱ�����

mysql> select * from dept;
+-----+-------+
| did | dname |
+-----+-------+
|   3 | ��ѯ  |
|   2 | ��ѧ  |
|   1 | ����  |
+-----+-------+
3 rows in set (0.00 sec)

#ɾ������ļ�¼����Լ��
delete from dept where did = 1; #ʧ��
#��Ϊ did=1�Ĳ��ű��ӱ�����

mysql> delete from dept where did = 1;
ERROR 1451 (23000): Cannot delete or update a parent row:
 a foreign key constraint fails (`atguigu`.`emp`, CONSTRAINT `emp_ibfk_1` FOREIGN KEY (`departmentid`) REFERENCES `dept` (`did`))

#ɾ���ӱ�����ݣ�����Լ��
delete from emp where name ='����'; #����

mysql> select * from emp;
+----+------+--------------+
| id | name | departmentid |
+----+------+--------------+
|  1 | ���� |            3 |
|  2 | ���� |            1 |
+----+------+--------------+
2 rows in set (0.00 sec)


#ɾ��������Լ��
drop table dept; #ʧ��

mysql> drop table dept; #ʧ��
ERROR 3730 (HY000): Cannot drop table 'dept' referenced by a foreign key constraint 'emp_ibfk_1' on table 'emp'.

#ɾ���ӱ�����Լ��
drop table emp;

#�ܲ����ڽ����������Լ������ο��ԣ���ôд��
alter table �ӱ��� add foreign key(�ӱ������ֶ���) references ������(�������ֶ�);


create table emp(
	id int primary key auto_increment,
	name varchar(20) not null,
	departmentid int
);

#��emp���ӱ��������Լ��
alter table emp add foreign key(departmentid) references dept(did);

#�鿴emp��Լ����Ϣ
SELECT * FROM information_schema.table_constraints WHERE table_name = 'emp';
mysql> SELECT * FROM information_schema.table_constraints WHERE table_name = 'emp';
+--------------------+-------------------+-----------------+--------------+------------+-----------------+----------+
| CONSTRAINT_CATALOG | CONSTRAINT_SCHEMA | CONSTRAINT_NAME | TABLE_SCHEMA | TABLE_NAME | CONSTRAINT_TYPE | ENFORCED |
+--------------------+-------------------+-----------------+--------------+------------+-----------------+----------+
| def                | atguigu           | PRIMARY         | atguigu      | emp        | PRIMARY KEY     | YES      |
| def                | atguigu           | emp_ibfk_1      | atguigu      | emp        | FOREIGN KEY     | YES      |
+--------------------+-------------------+-----------------+--------------+------------+-----------------+----------+
2 rows in set (0.01 sec)

#ֻ���Ǽ�Լ����������Ψһ����������������Զ�����������
#�鿴emp�������
show index from emp;

mysql> show index from emp;
+-------+------------+--------------+--------------+--------------+-----------+-------------+----------+--------+------+------------+---------+---------------+---------+------------+
| Table | Non_unique | Key_name     | Seq_in_index | Column_name  | Collation | Cardinality | Sub_part | Packed | Null | Index_type | Comment | Index_comment | Visible | Expression |
+-------+------------+--------------+--------------+--------------+-----------+-------------+----------+--------+------+------------+---------+---------------+---------+------------+
| emp   |          0 | PRIMARY      |            1 | id           | A         |           0 |     NULL |   NULL |      | BTREE      |         |               | YES     | NULL       |
| emp   |          1 | departmentid |            1 | departmentid | A         |           0 |     NULL |   NULL | YES  | BTREE      |         |               | YES     | NULL       |
+-------+------------+--------------+--------------+--------------+-----------+-------------+----------+--------+------+------------+---------+---------------+---------+------------+
2 rows in set (0.01 sec)
#�����ֶ���������PRIMARY��ɾ������ʱ�����Զ�ɾ����Ӧ����
#Ψһ���ֶ����������ֶ�����ɾ��Ψһ��ʱ������ͨ��ɾ����Ӧ��������ʽ��ɾ��Ψһ��Լ��
#����ֶ����������ֶ�����ɾ�����ʱ��

#ɾ�����Լ��
alter table ������ drop foreign key ���Լ����;

#ɾ��emp���departmentid�ֶε����Լ��
alter table emp drop foreign key emp_ibfk_1;

mysql> show index from emp;
+-------+------------+--------------+--------------+--------------+-----------+-------------+----------+--------+------+------------+---------+---------------+---------+------------+
| Table | Non_unique | Key_name     | Seq_in_index | Column_name  | Collation | Cardinality | Sub_part | Packed | Null | Index_type | Comment | Index_comment | Visible | Expression |
+-------+------------+--------------+--------------+--------------+-----------+-------------+----------+--------+------+------------+---------+---------------+---------+------------+
| emp   |          0 | PRIMARY      |            1 | id           | A         |           0 |     NULL |   NULL |      | BTREE      |         |               | YES     | NULL       |
| emp   |          1 | departmentid |            1 | departmentid | A         |           0 |     NULL |   NULL | YES  | BTREE      |         |               | YES     | NULL       |
+-------+------------+--------------+--------------+--------------+-----------+-------------+----------+--------+------+------------+---------+---------------+---------+------------+
2 rows in set (0.00 sec)


#˵����ɾ�����Լ��ʱ�������Զ�ɾ������ֶε���������Ϊ���ǵ�������һ����
#�����Ҫɾ����Ӧ����������Ҫ����ɾ 
alter table ������ drop index ������;

#ɾ��emp���departmentid�ֶε�����
alter table emp drop index departmentid;

mysql> show index from emp;
+-------+------------+----------+--------------+-------------+-----------+-------------+----------+--------+------+------------+---------+---------------+---------+------------+
| Table | Non_unique | Key_name | Seq_in_index | Column_name | Collation | Cardinality | Sub_part | Packed | Null | Index_type | Comment | Index_comment | Visible | Expression |
+-------+------------+----------+--------------+-------------+-----------+-------------+----------+--------+------+------------+---------+---------------+---------+------------+
| emp   |          0 | PRIMARY  |            1 | id          | A         |           0 |     NULL |   NULL |      | BTREE      |         |               | YES     | NULL       |
+-------+------------+----------+--------------+-------------+-----------+-------------+----------+--------+------+------------+---------+---------------+---------+------------+
1 row in set (0.00 sec)


/*
���Լ����������Լ���ȼ���
��1��No action��ʽ������ӱ�����ƥ��ļ�¼,������Ը����Ӧ��ѡ������update/delete����  
��2��Restrict��ʽ��ͬno action, ��������������Լ��
��3��Set null��ʽ���ڸ�����update/delete��¼ʱ�����ӱ���ƥ���¼������Ϊnull������Ҫע���ӱ������в���Ϊnot null  
��4��Cascade��ʽ���ڸ�����update/delete��¼ʱ��ͬ��update/delete���ӱ��ƥ���¼ 
��5��Set default��ʽ���ڿ��ӻ�����SQLyog�п�����ʾ�հף��������б��ʱ,�ӱ���������ó�һ��Ĭ�ϵ�ֵ����Innodb����ʶ��

on update No action | Restrict | Set null | Cascade 
on delete No action | Restrict | Set null | Cascade 
���û��дon update ��on delete�־䣬��ʾѡ����No action | Restrict��

*/
#����
create table dept(
	did int primary key auto_increment,
	dname varchar(50) unique key not null
);

insert into dept values(null,'����'),(null,'��ѧ'),(null,'��ѯ'),(null,'����');

mysql> select * from dept;
+-----+-------+
| did | dname |
+-----+-------+
|   4 | ����  |
|   3 | ��ѯ  |
|   2 | ��ѧ  |
|   1 | ����  |
+-----+-------+
4 rows in set (0.00 sec)

#�ӱ�
create table emp(
	id int primary key auto_increment,
	name varchar(20) not null,
	departmentid int,
	foreign key (departmentid) references dept(did) on update cascade on delete set null
	#on delete set nullҪ��departmentid�ֶ�û��not nullԼ��
);

#����ӱ�ʱ��¼��  ����on update cascade on delete set null�޹ء�����Ҫ���������ҵ���Ӧ�ļ�¼��
insert into emp values(null,'����',1);
insert into emp values(null,'����',2);
insert into emp values(null,'����',1);

mysql> select * from emp;
+----+------+--------------+
| id | name | departmentid |
+----+------+--------------+
|  1 | ���� |            1 |
|  2 | ���� |            2 |
|  3 | ���� |            1 |
+----+------+--------------+
3 rows in set (0.00 sec)

#�޸��ӱ� ��  ����on update cascade on delete set null�޹ء�����Ҫ���������ҵ���Ӧ�ļ�¼��
update emp set departmentid = 6 where name = '����';
#ʧ�ܣ���Ϊdepartmentid = 6�ڸ���dept���Ҳ�����Ӧ����

#�޸ĸ������õ�didֵ�� ��  ����on update cascade on delete set null�йء�
update dept set did = 6 where did = 1; 
#��ʱdid=1�ļ�¼���ӱ������ˣ������޸ģ����һ�ͬʱ�޸��ӱ��departmentid=1���ֶ�ֵΪ6�������޸�

mysql> select * from dept;
+-----+-------+
| did | dname |
+-----+-------+
|   4 | ����  |
|   3 | ��ѯ  |
|   2 | ��ѧ  |
|   6 | ����  |
+-----+-------+
4 rows in set (0.00 sec)

mysql> select * from emp;
+----+------+--------------+
| id | name | departmentid |
+----+------+--------------+
|  1 | ���� |            6 |
|  2 | ���� |            2 |
|  3 | ���� |            6 |
+----+------+--------------+
3 rows in set (0.00 sec)

#ɾ������dept�����õ�did�ļ�¼�� ��  ����on update cascade on delete set null�йء�
delete from dept where did = 6; #did=6�Ĳ������ӱ���������

mysql> select * from dept;
+-----+-------+
| did | dname |
+-----+-------+
|   4 | ����  |
|   3 | ��ѯ  |
|   2 | ��ѧ  |
+-----+-------+
3 rows in set (0.00 sec)

mysql> select * from emp;
+----+------+--------------+
| id | name | departmentid |
+----+------+--------------+
|  1 | ���� |         NULL |
|  2 | ���� |            2 |
|  3 | ���� |         NULL |
+----+------+--------------+
3 rows in set (0.00 sec)


