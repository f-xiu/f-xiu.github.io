#��ʾ�ı��ַ�������
#����һ�����
create table t_char(
	c1 char,   #�����ַ���������дchar��ʾֻ�ܴ�1���ַ�
	c2 varchar  #�������ַ���������дvarchar���������޶�����ܴ漸���ַ�
);
ERROR 1064 (42000): You have an error in your SQL syntax; 
check the manual that corresponds to your MySQL server version 
for the right syntax to use near ')' at line 4

create table t_char(
	c1 char,   #�����ַ���������дchar��ʾֻ�ܴ�1���ַ�
	c2 char(3), # �����ַ�����char(3)��ʾ���Դ洢3���ַ�������3���ײ���\u0000��ȫ
	c3 varchar(5)  #�������ַ�����varchar(M)��varchar(5)��ʾ����ܴ洢5���ַ�
);

#�鿴��ṹ
desc t_char;
mysql> desc t_char;
+-------+------------+------+-----+---------+-------+
| Field | Type       | Null | Key | Default | Extra |
+-------+------------+------+-----+---------+-------+
| c1    | char(1)    | YES  |     | NULL    |       |
| c2    | char(3)    | YES  |     | NULL    |       |
| c3    | varchar(5) | YES  |     | NULL    |       |
+-------+------------+------+-----+---------+-------+
3 rows in set (0.01 sec)

#�������
insert into t_char values('a','a','a');

#��ѯ����
select * from t_char;
mysql> select * from t_char;
+------+------+------+
| c1   | c2   | c3   |
+------+------+------+
| a    | a    | a    |
+------+------+------+
1 row in set (0.00 sec)


#�������
insert into t_char values('ab','ab','ab');
#MySQL���ַ���ֵ�����Ǽ����ַ�����ʹ�õ�����

mysql> insert into t_char values('ab','ab','ab');
ERROR 1406 (22001): Data too long for column 'c1' at row 1

#�������
insert into t_char values('��','ab','ab');

mysql> select * from t_char;
+------+------+------+
| c1   | c2   | c3   |
+------+------+------+
| a    | a    | a    |
| ��   | ab   | ab   |
+------+------+------+
2 rows in set (0.00 sec)


#�������
insert into t_char values('��','�й��','�й��');

mysql> select * from t_char;
+------+--------+--------+
| c1   | c2     | c3     |
+------+--------+--------+
| a    | a      | a      |
| ��   | ab     | ab     |
| ��   | �й�� | �й�� |
+------+--------+--------+
3 rows in set (0.00 sec)

#�������
insert into t_char values('��','�й�����','�й�����');

mysql> insert into t_char values('��','�й�����','�й�����');
ERROR 1406 (22001): Data too long for column 'c2' at row 1


#�������
insert into t_char values('��','�й��','�й�����');

mysql> select * from t_char;
+------+--------+------------+
| c1   | c2     | c3         |
+------+--------+------------+
| a    | a      | a          |
| ��   | ab     | ab         |
| ��   | �й�� | �й��     |
| ��   | �й�� | �й����� |
+------+--------+------------+
4 rows in set (0.00 sec)

#�������
insert into t_char values('��','�й��','�й����ĺܺ�');

mysql> insert into t_char values('��','�й��','�й����ĺܺ�');
ERROR 1406 (22001): Data too long for column 'c3' at row 1


insert into t_char values('��','��  ','�й��  ');

#��ѯһ������
select c1,concat('[',c2,']'),concat('[',c3,']') from t_char;
mysql> select c1,concat('[',c2,']'),concat('[',c3,']') from t_char;
+------+--------------------+--------------------+
| c1   | concat('[',c2,']') | concat('[',c3,']') |
+------+--------------------+--------------------+
| a    | [a]                | [a]                |
| ��   | [ab]               | [ab]               |
| ��   | [�й��]           | [�й��]           |
| ��   | [�й��]           | [�й�����]       |
| ��   | [��]               | [�й��  ]         |
+------+--------------------+--------------------+
5 rows in set (0.00 sec)


insert into t_char values('��','  ��','  �й��');

mysql> select c1,concat('[',c2,']'),concat('[',c3,']') from t_char;
+------+--------------------+--------------------+
| c1   | concat('[',c2,']') | concat('[',c3,']') |
+------+--------------------+--------------------+
| a    | [a]                | [a]                |
| ��   | [ab]               | [ab]               |
| ��   | [�й��]           | [�й��]           |
| ��   | [�й��]           | [�й�����]       |
| ��   | [��]               | [�й��  ]         |
| ��   | [  ��]             | [  �й��]         |
+------+--------------------+--------------------+
6 rows in set (0.00 sec)



