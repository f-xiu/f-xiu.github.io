/*��ʾ�ǿ�Լ��
1�����ã��޶�ĳ���ֶε�ֵ������ΪNULL��

��Java��ֻ�������������Ͳ��ܸ�ֵΪnull�������������Ͳ�����Ϊnull��
����MySQL�����е��������Ͷ����Ը�ֵΪNULL������int�ȡ�

2���ؼ��֣�not null

3��һ��������кܶ���ֶ��޶��ǿ�Լ����
һ���ֶμ�not null���������ֶ��޹أ������м�Լ����
*/

#����һ�������ʾNULLֵ
create table not_null_demo(
	id int,
	name varchar(20),
	birthday date
);

insert into not_null_demo values(null,null,null);
insert into not_null_demo(id) values(1);
select * from not_null_demo;
drop table not_null_demo;

#�ڴ������ʱ�򣬿���ָ���ǿ�Լ��

create table ������(
	�ֶ��� �������� not null,
	�ֶ��� �������� not null,
	�ֶ��� ��������
);

create table not_null_demo(
	id int not null,
	name varchar(20) not null,
	birthday date  #û�м�not null�ģ�����ΪNULL
);

#���NULLֵ
insert into not_null_demo values(null,null,null);

mysql> insert into not_null_demo values(null,null,null);
ERROR 1048 (23000): Column 'id' cannot be null

#ָ����id�ֶε�ֵ������û��ָ��name�ֶκ�birthday�ֶε�ֵ
insert into not_null_demo(id) values(1);

mysql> insert into not_null_demo(id) values(1);
ERROR 1364 (HY000): Field 'name' doesn't have a default value'
#��ʱname�趨��NOT NULL������û����ǰָ��Ĭ��ֵ��
#���û��ֵֻ�ܴ���ΪNULL����Υ���ǿ�Լ��

#�ܽ᣺��insert��Ӽ�¼ʱ�����������û����ǰָ��Ĭ��ֵ�ķǿ�Լ���ֶθ�ֵ��

insert into not_null_demo(id,name) values(1,'����');
insert into not_null_demo(id,name,birthday) values(2,'����','2000-1-1');
insert into not_null_demo values(3,'����','2000-2-1');
insert into not_null_demo values(4,'����',null);

insert into not_null_demo values(4,'����'); #����ֵ�б��������ֶ�������ƥ��
mysql> insert into not_null_demo values(4,'����');
ERROR 1136 (21S01): Column count doesn't match value count at row 1'


#�ڴ�����֮�󣬿��Ը�ĳ���ֶ����ӷǿ�Լ��
#alter table ������ modify ��column�� �ֶ��� �������� not null;

#���磺��not_null_demo����birthday�ֶμ�not nullԼ��
alter table not_null_demo modify column birthday date not null;

mysql> alter table not_null_demo modify column birthday date not null;
ERROR 1138 (22004): Invalid use of NULL value
#ʧ�ܵ�ԭ������Ϊnot_null_demo����birthday�ֶ������Ѿ���NULLֵ��
#������Ӳ��Ϸǿ�Լ����
#���Ҫ�ӣ������Ƚ�ԭ����NULLֵ�޸ĵ�

mysql> select * from not_null_demo;
+----+------+------------+
| id | name | birthday   |
+----+------+------------+
|  1 | ���� | NULL       |
|  2 | ���� | 2000-01-01 |
|  3 | ���� | 2000-02-01 |
|  4 | ���� | NULL       |
+----+------+------------+
4 rows in set (0.01 sec)

update not_null_demo set birthday = '2000-5-1' where id=1 || id = 4;

mysql> select * from not_null_demo;
+----+------+------------+
| id | name | birthday   |
+----+------+------------+
|  1 | ���� | 2000-05-01 |
|  2 | ���� | 2000-01-01 |
|  3 | ���� | 2000-02-01 |
|  4 | ���� | 2000-05-01 |
+----+------+------------+
4 rows in set (0.00 sec)

mysql> alter table not_null_demo modify column birthday date not null;
Query OK, 0 rows affected (0.06 sec)
Records: 0  Duplicates: 0  Warnings: 0

mysql> desc not_null_demo;
+----------+-------------+------+-----+---------+-------+
| Field    | Type        | Null | Key | Default | Extra |
+----------+-------------+------+-----+---------+-------+
| id       | int         | NO   |     | NULL    |       |
| name     | varchar(20) | NO   |     | NULL    |       |
| birthday | date        | NO   |     | NULL    |       |
+----------+-------------+------+-----+---------+-------+
3 rows in set (0.01 sec)

#ɾ��ĳ���ֶεķǿ�Լ��
alter table ������ modify ��column�� �ֶ��� ��������;

#���磺ȥ��birthday�ֶεķǿ�Լ��
alter table not_null_demo modify column birthday date;

mysql> desc not_null_demo;
+----------+-------------+------+-----+---------+-------+
| Field    | Type        | Null | Key | Default | Extra |
+----------+-------------+------+-----+---------+-------+
| id       | int         | NO   |     | NULL    |       |
| name     | varchar(20) | NO   |     | NULL    |       |
| birthday | date        | YES  |     | NULL    |       |
+----------+-------------+------+-----+---------+-------+
3 rows in set (0.01 sec)


/*
˵����
���ĳ���ֶ���not null�ǿ�Լ���Ļ���
ʹ��modify�޸��ֶε��������͡�λ�á��ַ�����У�Թ���ʱ��
��Ҫ�����ǿ�Լ���������not null���ϣ�
��������޸��ֶε��������͡�λ�á��ַ�����У�Թ���ʱ��
�ѷǿ�Լ����������
*/
#���磺�޸�name�ֶε���������Ϊvarchar(30)��������Ҫ����not null�ǿ�Լ����
alter table not_null_demo modify column name varchar(30);
#��ʱalterû�м�not null�����name�ֶε�not nullԼ����������

mysql> desc not_null_demo;
+----------+-------------+------+-----+---------+-------+
| Field    | Type        | Null | Key | Default | Extra |
+----------+-------------+------+-----+---------+-------+
| id       | int         | NO   |     | NULL    |       |
| name     | varchar(30) | YES  |     | NULL    |       |
| birthday | date        | YES  |     | NULL    |       |
+----------+-------------+------+-----+---------+-------+
3 rows in set (0.01 sec)
