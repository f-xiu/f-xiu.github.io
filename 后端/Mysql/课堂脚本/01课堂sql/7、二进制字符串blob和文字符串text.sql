#��ʾblob��text
#blobϵ���Ǵ�Ķ�������������
#textϵ���Ǵ���ı��ַ�������
#�������
create table t_blob_text(
	b blob,
	t text
);

#�鿴��ṹ
desc t_blob_text;
mysql> desc t_blob_text;
+-------+------+------+-----+---------+-------+
| Field | Type | Null | Key | Default | Extra |
+-------+------+------+-----+---------+-------+
| b     | blob | YES  |     | NULL    |       |
| t     | text | YES  |     | NULL    |       |
+-------+------+------+-----+---------+-------+
2 rows in set (0.01 sec)

#�������
insert into t_blob_text
values('a','a');

insert into t_blob_text
values('�й��','�й��');

#�鿴����
select * from t_blob_text;

mysql> select * from t_blob_text;
+----------------+--------+
| b              | t      |
+----------------+--------+
| 0x61           | a      |
| 0xC9D0B9E8B9C8 | �й�� |
+----------------+--------+
2 rows in set (0.00 sec)



