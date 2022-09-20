#��ʾ�������ַ�������binary��varbinary
#�������
create table t_binary(
	b1 binary, #û��ָ��(M)��Ĭ����(1)
	b2 varbinary #û��ָ��(M)����������ָ��(M)
);
ERROR 1064 (42000): You have an error in your SQL syntax; 
check the manual that corresponds to your MySQL server 
version for the right syntax to use near ')' at line 4


create table t_binary(
	b1 binary, #Ĭ��(1)������ܴ洢һ���ֽ�
	b2 binary(6), #����ܴ洢6���ֽڣ�����6����\u0000��ȫ
	b3 varbinary(6) #(6)������ܴ洢6���ֽ�
);

#�鿴��ṹ
desc t_binary;

mysql> desc t_binary;
+-------+--------------+------+-----+---------+-------+
| Field | Type         | Null | Key | Default | Extra |
+-------+--------------+------+-----+---------+-------+
| b1    | binary(1)    | YES  |     | NULL    |       |
| b2    | binary(6)    | YES  |     | NULL    |       |
| b3    | varbinary(6) | YES  |     | NULL    |       |
+-------+--------------+------+-----+---------+-------+
3 rows in set (0.01 sec)


#�������
insert into t_binary
values('a','a','a');

#�鿴����
select * from t_binary;
#��ʾ16������ʽ��ֵ

mysql> select * from t_binary;
+------------+----------------+------------+
| b1         | b2             | b3         |
+------------+----------------+------------+
| 0x61       | 0x610000000000 | 0x61       |
+------------+----------------+------------+
1 row in set (0.00 sec)

#'a'�ı���ֵ��97��ʮ���ƣ�����Ӧʮ�����ƣ�61��
#0x610000000000 ����6���ֽ�

#�������
insert into t_binary
values('��','��','��');

mysql> insert into t_binary
    -> values('��','��','��');
ERROR 1406 (22001): Data too long for column 'b1' at row 1
#'��'������GBK����UTF8�����¶���������1���ֽ�


#�������
insert into t_binary
values('a','�й��','�й��');

mysql> select * from t_binary;
+------------+----------------+----------------+
| b1         | b2             | b3             |
+------------+----------------+----------------+
| 0x61       | 0x610000000000 | 0x61           |
| 0x61       | 0xC9D0B9E8B9C8 | 0xC9D0B9E8B9C8 |
+------------+----------------+----------------+
2 rows in set (0.00 sec)

#�������
insert into t_binary
values('a','�й�����','�й���й�����');

mysql> insert into t_binary
    -> values('a','�й�����','�й���й�����');
ERROR 1406 (22001): Data too long for column 'b2' at row 1


#�������
insert into t_binary
values('a','�й�','�й�');

mysql> select * from t_binary;
+------------+----------------+----------------+
| b1         | b2             | b3             |
+------------+----------------+----------------+
| 0x61       | 0x610000000000 | 0x61           |
| 0x61       | 0xC9D0B9E8B9C8 | 0xC9D0B9E8B9C8 |
| 0x61       | 0xE5B09AE7A185 | 0xE5B09AE7A185 |   #���ӻ���������ӵģ�����UTF8��
| 0x61       | 0xC9D0B9E80000 | 0xC9D0B9E8     |   #��������ӵģ�����GBK
+------------+----------------+----------------+
4 rows in set (0.00 sec)


#��ѯ����b1�ֶ�ֵΪ'a'�ļ�¼
select * from t_binary where b1 = 'a';

#��ѯ����b1�ֶ�ֵΪ'A'�ļ�¼
select * from t_binary where b1 = 'A';

mysql> select * from t_binary where b1 = 'a';
+------------+----------------+----------------+
| b1         | b2             | b3             |
+------------+----------------+----------------+
| 0x61       | 0x610000000000 | 0x61           |
| 0x61       | 0xC9D0B9E8B9C8 | 0xC9D0B9E8B9C8 |
| 0x61       | 0xE5B09AE7A185 | 0xE5B09AE7A185 |
| 0x61       | 0xC9D0B9E80000 | 0xC9D0B9E8     |
+------------+----------------+----------------+
4 rows in set (0.00 sec)

mysql> select * from t_binary where b1 = 'A';


#��char��varchar���͵ı���в�ѯ
#��ѯ����c1�ֶ�ֵΪ'a'�ļ�¼
select * from t_char where c1 = 'a';

#��ѯ����c1�ֶ�ֵΪ'A'�ļ�¼
select * from t_char where c1 = 'A';

mysql> select * from t_char where c1 = 'a';
+------+------+------+
| c1   | c2   | c3   |
+------+------+------+
| a    | a    | a    |
+------+------+------+
1 row in set (0.00 sec)

mysql> select * from t_char where c1 = 'A';
+------+------+------+
| c1   | c2   | c3   |
+------+------+------+
| a    | a    | a    |
+------+------+------+
1 row in set (0.00 sec)