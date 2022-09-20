#�ı������е�ö�ٺͼ���
#ö�٣��̶��ļ����ַ���ֵ������ѡ��һ��
#���ϣ��̶��ļ����ַ���ֵ������ѡ�����⼸��

create table t_enum_set(
	gender enum('��','Ů'),
	hobby set('��Ϸ','˯��','�����','�˶�')
);

#�鿴��ṹ
desc t_enum_set;

mysql> desc t_enum_set;
+--------+------------------------------------+------+-----+---------+-------+
| Field  | Type                               | Null | Key | Default | Extra |
+--------+------------------------------------+------+-----+---------+-------+
| gender | enum('��','Ů')                    | YES  |     | NULL    |       |
| hobby  | set('��Ϸ','˯��','�����','�˶�') | YES  |     | NULL    |       |
+--------+------------------------------------+------+-----+---------+-------+
2 rows in set (0.01 sec)


#�������
insert into t_enum_set
values('��','��Ϸ');

#�鿴����
select * from t_enum_set;

#�������
insert into t_enum_set
values('��,Ů','��Ϸ,˯��');

mysql> insert into t_enum_set
    -> values('��,Ů','��Ϸ,˯��');
ERROR 1265 (01000): Data truncated for column 'gender' at row 1

#�������
insert into t_enum_set
values('��','��Ϸ,˯��');

#�������
insert into t_enum_set
values('��','��Ϸ,˯��');
mysql> insert into t_enum_set
    -> values('��','��Ϸ,˯��');
ERROR 1265 (01000): Data truncated for column 'gender' at row 1

#�������
insert into t_enum_set
values('��','��Ϸ,˯��,����');
mysql> insert into t_enum_set
    -> values('��','��Ϸ,˯��,����');
ERROR 1265 (01000): Data truncated for column 'hobby' at row 1


insert into t_enum_set
values(2, 2);

mysql> select * from t_enum_set;
+--------+-----------+
| gender | hobby     |
+--------+-----------+
| ��     | ��Ϸ      |
| ��     | ��Ϸ,˯�� |
| Ů     | ˯��      |
+--------+-----------+
3 rows in set (0.00 sec)


insert into t_enum_set
values(2, 5);
#5 ���Կ��� 1��4����ϣ�00001 �� 0100��0101


insert into t_enum_set
values(2, 7);
mysql> select * from t_enum_set;
+--------+------------------+
| gender | hobby            |
+--------+------------------+
| ��     | ��Ϸ             |
| ��     | ��Ϸ,˯��        |
| Ů     | ˯��             |
| Ů     | ��Ϸ,�����      |
| Ů     | ��Ϸ,˯��,����� |
+--------+------------------+
5 rows in set (0.00 sec)

insert into t_enum_set
values(2, 15);
mysql> select * from t_enum_set;
+--------+-----------------------+
| gender | hobby                 |
+--------+-----------------------+
| ��     | ��Ϸ                  |
| ��     | ��Ϸ,˯��             |
| Ů     | ˯��                  |
| Ů     | ��Ϸ,�����           |
| Ů     | ��Ϸ,˯��,�����      |
| Ů     | ��Ϸ,˯��,�����,�˶� |
+--------+-----------------------+
6 rows in set (0.00 sec)


insert into t_enum_set
values(2, 25);
mysql> insert into t_enum_set
    -> values(2, 25);
ERROR 1265 (01000): Data truncated for column 'hobby' at row 1