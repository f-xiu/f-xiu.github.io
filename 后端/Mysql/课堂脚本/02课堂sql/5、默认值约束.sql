#��ʾĬ��ֵԼ��
/*
1������
�����insert�������ʱ��û�и�����ֶθ�ֵ������ѡ��Ĭ��ֵԼ��ָ��Ĭ��ֵ��
����ֶ�û�ж���Ĭ��ֵԼ������ôĬ�Ͼ���NULL��

2���ؼ��֣�default


�ǿպ�Ĭ��ֵԼ�����м�Լ����ֻӰ��ĳ���ֶΣ�ֻ����ǰ��Ԫ�񣬺��������޹ء�
Ψһ��Լ��������Լ���Ǳ�Լ�����ῴ���ֶ������е����ݣ�������һ�𿴡�
*/

#����ʱ���������ֶκ�����ֶ�ָ��Ĭ��ֵ
create table emp(
	eid int primary key,
	ename varchar(20) not null,
	gender enum('��','Ů') default '��' not null, #�ǿղ�����Ĭ��ֵ
	address varchar(100) default '����' #����ָ��Ϊnull
);

insert into emp values(1,'����');#����ֵ���������ֶε�������ƥ��

mysql> insert into emp values(1,'����');
ERROR 1136 (21S01): Column count doesn't match value count at row 1'

insert into emp(eid,ename) values(1,'����');
insert into emp values(2,'����',default,default);
insert into emp values(3,'����',default,null);

mysql> select * from emp;
+-----+-------+--------+---------+
| eid | ename | gender | address |
+-----+-------+--------+---------+
|   1 | ����  | ��     | ����    |
|   2 | ����  | ��     | ����    |
|   3 | ����  | ��     | NULL    |
+-----+-------+--------+---------+
3 rows in set (0.00 sec)


insert into emp values(4,'�仨','Ů','����');

mysql> select * from emp;
+-----+-------+--------+---------+
| eid | ename | gender | address |
+-----+-------+--------+---------+
|   1 | ����  | ��     | ����    |
|   2 | ����  | ��     | ����    |
|   3 | ����  | ��     | NULL    |
|   4 | �仨  | Ů     | ����    |
+-----+-------+--------+---------+
4 rows in set (0.00 sec)

#ɾ��Ĭ��ֵԼ��
alter table ������ modify ��column�� �ֶ��� ��������;

#�鿴��ṹ
desc emp;
mysql> desc emp;
+---------+-----------------+------+-----+---------+-------+
| Field   | Type            | Null | Key | Default | Extra |
+---------+-----------------+------+-----+---------+-------+
| eid     | int             | NO   | PRI | NULL    |       |
| ename   | varchar(20)     | NO   |     | NULL    |       |
| gender  | enum('��','Ů') | NO   |     | ��      |       |
| address | varchar(100)    | YES  |     | ����    |       |
+---------+-----------------+------+-----+---------+-------+
4 rows in set (0.01 sec)

#ɾ��emp���address��Ĭ��ֵԼ��
alter table emp modify column address varchar(100);


mysql> desc emp;
+---------+-----------------+------+-----+---------+-------+
| Field   | Type            | Null | Key | Default | Extra |
+---------+-----------------+------+-----+---------+-------+
| eid     | int             | NO   | PRI | NULL    |       |
| ename   | varchar(20)     | NO   |     | NULL    |       |
| gender  | enum('��','Ů') | NO   |     | ��      |       |
| address | varchar(100)    | YES  |     | NULL    |       |
+---------+-----------------+------+-----+---------+-------+
4 rows in set (0.01 sec)

#ɾ��emp���gender��Ĭ��ֵԼ��
alter table emp modify column gender enum('��','Ů'); #ͬʱɾ���˷ǿ�Լ����Ĭ��ֵԼ��


mysql> desc emp;
+---------+-----------------+------+-----+---------+-------+
| Field   | Type            | Null | Key | Default | Extra |
+---------+-----------------+------+-----+---------+-------+
| eid     | int             | NO   | PRI | NULL    |       |
| ename   | varchar(20)     | NO   |     | NULL    |       |
| gender  | enum('��','Ů') | YES  |     | NULL    |       |
| address | varchar(100)    | YES  |     | NULL    |       |
+---------+-----------------+------+-----+---------+-------+
4 rows in set (0.00 sec)

#���ۣ���ʹ��modify�޸��ֶεķǿ�Լ����Ĭ��ֵԼ�����������͵���Ϣʱ
#ע�⣬���Ҫ�����ģ���modify�����Ҫ���֡�
#���磺Ҫ�����ǿ�Լ������Ҫ��not null������ᶪ����


#������ֶ�����Ĭ��ֵԼ��
alter table ������ modify ��column�� �ֶ��� �������� default Ĭ��ֵ;

#��emp��address���ӡ����ꡱĬ��ֵ
alter table emp modify column address varchar(100) default '����';

#��emp��gender���ӡ��С�Ĭ��ֵ���Լ��ǿ�
alter table emp modify column gender enum('��','Ů') default '��' not null;

mysql> desc emp;
+---------+-----------------+------+-----+---------+-------+
| Field   | Type            | Null | Key | Default | Extra |
+---------+-----------------+------+-----+---------+-------+
| eid     | int             | NO   | PRI | NULL    |       |
| ename   | varchar(20)     | NO   |     | NULL    |       |
| gender  | enum('��','Ů') | NO   |     | ��      |       |
| address | varchar(100)    | YES  |     | ����    |       |
+---------+-----------------+------+-----+---------+-------+
4 rows in set (0.01 sec)