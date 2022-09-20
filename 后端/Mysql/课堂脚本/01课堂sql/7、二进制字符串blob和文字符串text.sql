#演示blob和text
#blob系列是大的二进制数据类型
#text系列是大的文本字符串类型
#创建表格
create table t_blob_text(
	b blob,
	t text
);

#查看表结构
desc t_blob_text;
mysql> desc t_blob_text;
+-------+------+------+-----+---------+-------+
| Field | Type | Null | Key | Default | Extra |
+-------+------+------+-----+---------+-------+
| b     | blob | YES  |     | NULL    |       |
| t     | text | YES  |     | NULL    |       |
+-------+------+------+-----+---------+-------+
2 rows in set (0.01 sec)

#添加数据
insert into t_blob_text
values('a','a');

insert into t_blob_text
values('尚硅谷','尚硅谷');

#查看数据
select * from t_blob_text;

mysql> select * from t_blob_text;
+----------------+--------+
| b              | t      |
+----------------+--------+
| 0x61           | a      |
| 0xC9D0B9E8B9C8 | 尚硅谷 |
+----------------+--------+
2 rows in set (0.00 sec)



