CREATE TABLE `table`(
	id INT,
	name VARCHAR(20)
);

create table my tab(id int); #�����м��пո񣬱���
create table `my tab`(id int);

create database atguigu;
mysql> create database atguigu;
ERROR 1007 (HY000): Can't create database 'atguigu'; database exists'


create table temp(
	id int
;
ERROR 1064 (42000): You have an error in your SQL syntax; check the manual that corresponds to your MySQL server version for the right syntax to use n
ear '' at line 2

create table temp(
	y year
);

insert into temp values('2021);  
mysql> insert into temp values('2021);
    '>
    '>
    '>
    '>
    '>
    '>
    '> ';  ���벹ȫ���µĵ����ţ�Ȼ��������δ����SQL��
ERROR 1064 (42000): You have an error in your SQL syntax;
 check the manual that corresponds to your MySQL server
 version for the right syntax to use near '' at line 8


insert into temp values('2021');  
select * from temp;

select y as "���" from temp; 
#���ֶ�yȡ������ֻ�Ǳ���sql��Ч�����е��ֶ���Ȼ��y��

mysql> select y as "���" from temp;
+------+
| ��� |
+------+
| 2021 |
+------+
1 row in set (0.00 sec)

select y "���" from temp; #as����ʡ��

select y ��� from temp; #���������û�пո�""Ҳ����ȥ��

select y �� �� from temp;  #����������пո�""ȥ���ͻ����
ERROR 1064 (42000): You have an error in your SQL syntax; 
check the manual that corresponds to your MySQL server 
version for the right syntax to use near '�� from temp' at line 1

select y "���" from temp�� #�����ĵ�
mysql> select y "���" from temp��
    -> ;
ERROR 1146 (42S02): Table 'atguigu.temp��' doesn't exist'


#��ѯtemp�������
select * from temp;

-- ��ѯtemp�������
select * from temp;
 
--��ѯtemp�������   ע��--��ע��֮������пո񣬷��򱨴�
select * from temp;

/*
����ע��
��ѯtemp�������
*/
select * from temp;