#演示外键约束
/*
1、作用：
用来限定子表和父表的引用关系。
子表的外键字段值必须在父类被引用字段值的范围内。

2、外键约束一定是有两个表的角色。
其中一个作为子表（又称为从表），另一个作为父表（又称为主表）。

子表外键字段的值要从父表被引用字段的值中选择。

例如：员工表中记录员工信息，其中有一个字段是“部门编号”，表示这个员工所属的部门。
      部门的信息是记录在部门表中，
	  但是员工表的“部门编号”字段的值不能随意填写，需要参考/引用“部门表”的部门记录。
	  
	  员工表是子表，引用别人，受部门表的牵制/范围管辖。
	  部门表示父表，被别人引用。
	  
例如：商品表、用户表、订单表、订单明细表
		商品表里面记录了商品信息（商品名称、价格、库存量...）
		用户表里面记录了用户信息（用户名、密码、账户余额...）
		订单表里面记录了订单信息（订单编号、订单总价格、订单商品总数量、收获地址...）
		订单明细表记录了订单中每一个明细（商品编号、订单编号、价格、数量....）
		
		中午下了一个订单，买了“米粉”、“袜子”、“手机贴膜”、“高压锅”
		订单编号：112122123222222
		
		商品表：
		1    “米粉”    52.5	 ....
		2    “袜子”    23.0	 ....
		3    “手机贴膜”    15.0	 ....
		4    “高压锅”    125.0	 ....
		
		订单明细中：
		订单编号         商品编号  数量			价格	....
		112122123222222  1			2（盒米粉）  52.5	
		112122123222222  2			1（打）       23.0	
		112122123222222  3			1（张）       15.0		
		112122123222222  4			1（个）       125.0

		
		订单明细表是子表，商品表和订单表是父表。		

3、外键约束要求
（1）外键约束必须在子表中定义
（2）子表中要定义外键约束的字段的数据类型和逻辑意义，必须和父表中被引用字段的数据类型、逻辑意义一样。
例如：员工表中部门编号字段 引用  部门表中的部门编号字段
      订单明细表中的订单编号  引用  订单表中订单编号
      订单明细表中的商品编号  引用  商品表中商品编号
	
（3）子表中要定义外键约束的字段的名字和父表中被引用字段名称可以不同。
（4）父表中被引用的字段必须是键约束字段，一般都是主键或唯一键约束。
此时子表和父表的关系可以是一对一或一对多的关系。
父表是一，子表是一或多。

例如：父表（部门表）一条记录，对应子表（员工表）多条记录。
	  父表（订单表）一条记录，对应子表（订单明细表）一条或多条记录。
	  
（5）父表必须先存在，然后才能正确建立子表的外键约束
	  

4、关键字 foreign key 和 references  


5、外键约束约束了什么？
（1）建表的顺序，先建父表，再建子表
（2）删表的顺序，先删子表，再删父表，
或者先删掉外键约束，然后分别删除两个表（顺序就随意了）
（3）给子表添加数据、修改外键字段的数据，受影响，因为要从父表的被引用字段范围内选值。
（4）删除和修改父表的被引用字段的数据，受影响，因为要考虑这个值是否被子表引用了。
（5）是否建立外键，和查询无关。

比喻：孩子的消费行为要受约束，在爸爸的挣钱范围内。
      爸爸的行为也要受约束，被依赖，不是那么自由。
	  双方都会受影响。
*/

#建表时，指定外键约束
create table dept(
	did int primary key auto_increment,
	dname varchar(50) unique key not null
);

create table emp(
	id int primary key auto_increment,
	name varchar(20) not null,
	departmentid int,  #子表中外键约束的字段名和父表的被引用字段名不要求一致，但是数据类型和逻辑意义要一样
	#外键约束只能在字段列表下面单独定义，不能在字段后面直接定义
	foreign key (departmentid) references dept(did)
);

#查看表结构
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

#查看表的定义
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


#查看系统库的约束表
SELECT * FROM information_schema.table_constraints WHERE table_name = '表名称';

SELECT * FROM information_schema.table_constraints WHERE table_name = 'emp';

mysql> SELECT * FROM information_schema.table_constraints WHERE table_name = 'emp';
+--------------------+-------------------+-----------------+--------------+------------+-----------------+----------+
| CONSTRAINT_CATALOG | CONSTRAINT_SCHEMA | CONSTRAINT_NAME | TABLE_SCHEMA | TABLE_NAME | CONSTRAINT_TYPE | ENFORCED |
+--------------------+-------------------+-----------------+--------------+------------+-----------------+----------+
| def                | atguigu           | PRIMARY         | atguigu      | emp        | PRIMARY KEY     | YES      |
| def                | atguigu           | emp_ibfk_1      | atguigu      | emp        | FOREIGN KEY     | YES      |
+--------------------+-------------------+-----------------+--------------+------------+-----------------+----------+
2 rows in set (0.00 sec)

#添加记录
#添加父表信息，没有影响
insert into dept values(null,'财务'),(null,'教学'),(null,'咨询'),(null,'后勤');

mysql> select * from dept;
+-----+-------+
| did | dname |
+-----+-------+
|   4 | 后勤  |
|   3 | 咨询  |
|   2 | 教学  |
|   1 | 财务  |
+-----+-------+
4 rows in set (0.00 sec)

#添加子表信息，有影响，受到约束
insert into emp values(null,'张三',1);#成功
insert into emp values(null,'李四',1);#成功
insert into emp values(null,'王五',2);#成功
insert into emp values(null,'赵六',6); #失败
#因为departmentid=1或2，在父表dept中可以找到对应记录
#因为departmentid=6，在父表dept中找不到对应记录

mysql> insert into emp values(null,'赵六',6);
ERROR 1452 (23000): Cannot add（添加） or update（修改） a child(子表） row（记录/行）:
 a foreign key constraint fails 
 (`atguigu`.`emp`, CONSTRAINT `emp_ibfk_1` FOREIGN KEY (`departmentid`) REFERENCES `dept` (`did`))

mysql> select * from emp;
+----+------+--------------+
| id | name | departmentid |
+----+------+--------------+
|  1 | 张三 |            1 |
|  2 | 李四 |            1 |
|  3 | 王五 |            2 |
+----+------+--------------+
3 rows in set (0.00 sec)


#修改子表的外键字段的信息，有影响，受到约束
update emp set departmentid = 3 where id = 1;#成功
#因为departmentid = 3在父表dept中可以找到对应部门

update emp set departmentid = 6 where id = 3; #失败  
#因为departmentid = 6在父表dept中找不到对应部门

mysql> update emp set departmentid = 6 where id = 3;
ERROR 1452 (23000): Cannot add or update a child row: 
a foreign key constraint fails (`atguigu`.`emp`, CONSTRAINT `emp_ibfk_1` FOREIGN KEY (`departmentid`) REFERENCES `dept` (`did`))


mysql> select * from emp;
+----+------+--------------+
| id | name | departmentid |
+----+------+--------------+
|  1 | 张三 |            3 |
|  2 | 李四 |            1 |
|  3 | 王五 |            2 |
+----+------+--------------+
3 rows in set (0.00 sec)

mysql> select * from dept;
+-----+-------+
| did | dname |
+-----+-------+
|   4 | 后勤  |
|   3 | 咨询  |
|   2 | 教学  |
|   1 | 财务  |
+-----+-------+
4 rows in set (0.00 sec)


#修改父表的被引用字段的值，受约束
update dept set did = 6 where did = 1;#失败
#因为did=1的部门被子表引用
update dept set did = 6 where did = 4;#成功
#因为 did=4的部门没有被子表引用

mysql> update dept set did = 6 where did = 1;
ERROR 1451 (23000): Cannot delete（删除） or update（修改） a parent（父表） row（记录/行）:
 a foreign key constraint fails 
 (`atguigu`.`emp`, CONSTRAINT `emp_ibfk_1` FOREIGN KEY (`departmentid`) REFERENCES `dept` (`did`))


mysql> select * from dept;
+-----+-------+
| did | dname |
+-----+-------+
|   6 | 后勤  |
|   3 | 咨询  |
|   2 | 教学  |
|   1 | 财务  |
+-----+-------+
4 rows in set (0.00 sec)

#删除父表的记录，受约束
delete from dept where did = 6; #成功
#因为 did=6的部门没有被子表引用

mysql> select * from dept;
+-----+-------+
| did | dname |
+-----+-------+
|   3 | 咨询  |
|   2 | 教学  |
|   1 | 财务  |
+-----+-------+
3 rows in set (0.00 sec)

#删除父表的记录，受约束
delete from dept where did = 1; #失败
#因为 did=1的部门被子表引用

mysql> delete from dept where did = 1;
ERROR 1451 (23000): Cannot delete or update a parent row:
 a foreign key constraint fails (`atguigu`.`emp`, CONSTRAINT `emp_ibfk_1` FOREIGN KEY (`departmentid`) REFERENCES `dept` (`did`))

#删除子表的数据，不受约束
delete from emp where name ='王五'; #可以

mysql> select * from emp;
+----+------+--------------+
| id | name | departmentid |
+----+------+--------------+
|  1 | 张三 |            3 |
|  2 | 李四 |            1 |
+----+------+--------------+
2 rows in set (0.00 sec)


#删除父表，受约束
drop table dept; #失败

mysql> drop table dept; #失败
ERROR 3730 (HY000): Cannot drop table 'dept' referenced by a foreign key constraint 'emp_ibfk_1' on table 'emp'.

#删除子表，不受约束
drop table emp;

#能不能在建表后添加外键约束，如何可以，怎么写？
alter table 子表名 add foreign key(子表的外键字段名) references 父表名(被引用字段);


create table emp(
	id int primary key auto_increment,
	name varchar(20) not null,
	departmentid int
);

#给emp表（子表）增加外键约束
alter table emp add foreign key(departmentid) references dept(did);

#查看emp的约束信息
SELECT * FROM information_schema.table_constraints WHERE table_name = 'emp';
mysql> SELECT * FROM information_schema.table_constraints WHERE table_name = 'emp';
+--------------------+-------------------+-----------------+--------------+------------+-----------------+----------+
| CONSTRAINT_CATALOG | CONSTRAINT_SCHEMA | CONSTRAINT_NAME | TABLE_SCHEMA | TABLE_NAME | CONSTRAINT_TYPE | ENFORCED |
+--------------------+-------------------+-----------------+--------------+------------+-----------------+----------+
| def                | atguigu           | PRIMARY         | atguigu      | emp        | PRIMARY KEY     | YES      |
| def                | atguigu           | emp_ibfk_1      | atguigu      | emp        | FOREIGN KEY     | YES      |
+--------------------+-------------------+-----------------+--------------+------------+-----------------+----------+
2 rows in set (0.01 sec)

#只有是键约束（主键、唯一键、外键），都会自动创建索引。
#查看emp表的索引
show index from emp;

mysql> show index from emp;
+-------+------------+--------------+--------------+--------------+-----------+-------------+----------+--------+------+------------+---------+---------------+---------+------------+
| Table | Non_unique | Key_name     | Seq_in_index | Column_name  | Collation | Cardinality | Sub_part | Packed | Null | Index_type | Comment | Index_comment | Visible | Expression |
+-------+------------+--------------+--------------+--------------+-----------+-------------+----------+--------+------+------------+---------+---------------+---------+------------+
| emp   |          0 | PRIMARY      |            1 | id           | A         |           0 |     NULL |   NULL |      | BTREE      |         |               | YES     | NULL       |
| emp   |          1 | departmentid |            1 | departmentid | A         |           0 |     NULL |   NULL | YES  | BTREE      |         |               | YES     | NULL       |
+-------+------------+--------------+--------------+--------------+-----------+-------------+----------+--------+------+------------+---------+---------------+---------+------------+
2 rows in set (0.01 sec)
#主键字段索引名是PRIMARY，删除主键时，会自动删除对应索引
#唯一键字段索引名是字段名，删除唯一键时，就是通过删除对应的索引方式来删除唯一键约束
#外键字段索引名是字段名，删除外键时，

#删除外键约束
alter table 表名称 drop foreign key 外键约束名;

#删除emp表的departmentid字段的外键约束
alter table emp drop foreign key emp_ibfk_1;

mysql> show index from emp;
+-------+------------+--------------+--------------+--------------+-----------+-------------+----------+--------+------+------------+---------+---------------+---------+------------+
| Table | Non_unique | Key_name     | Seq_in_index | Column_name  | Collation | Cardinality | Sub_part | Packed | Null | Index_type | Comment | Index_comment | Visible | Expression |
+-------+------------+--------------+--------------+--------------+-----------+-------------+----------+--------+------+------------+---------+---------------+---------+------------+
| emp   |          0 | PRIMARY      |            1 | id           | A         |           0 |     NULL |   NULL |      | BTREE      |         |               | YES     | NULL       |
| emp   |          1 | departmentid |            1 | departmentid | A         |           0 |     NULL |   NULL | YES  | BTREE      |         |               | YES     | NULL       |
+-------+------------+--------------+--------------+--------------+-----------+-------------+----------+--------+------+------------+---------+---------------+---------+------------+
2 rows in set (0.00 sec)


#说明，删除外键约束时，不会自动删除外键字段的索引，因为它们的命名不一样，
#如果需要删除对应的索引，需要单独删 
alter table 表名称 drop index 索引名;

#删除emp表的departmentid字段的索引
alter table emp drop index departmentid;

mysql> show index from emp;
+-------+------------+----------+--------------+-------------+-----------+-------------+----------+--------+------+------------+---------+---------------+---------+------------+
| Table | Non_unique | Key_name | Seq_in_index | Column_name | Collation | Cardinality | Sub_part | Packed | Null | Index_type | Comment | Index_comment | Visible | Expression |
+-------+------------+----------+--------------+-------------+-----------+-------------+----------+--------+------+------------+---------+---------------+---------+------------+
| emp   |          0 | PRIMARY  |            1 | id          | A         |           0 |     NULL |   NULL |      | BTREE      |         |               | YES     | NULL       |
+-------+------------+----------+--------------+-------------+-----------+-------------+----------+--------+------+------------+---------+---------------+---------+------------+
1 row in set (0.00 sec)


/*
外键约束可以设置约束等级：
（1）No action方式：如果子表中有匹配的记录,则不允许对父表对应候选键进行update/delete操作  
（2）Restrict方式：同no action, 都是立即检查外键约束
（3）Set null方式：在父表上update/delete记录时，将子表上匹配记录的列设为null，但是要注意子表的外键列不能为not null  
（4）Cascade方式：在父表上update/delete记录时，同步update/delete掉子表的匹配记录 
（5）Set default方式（在可视化工具SQLyog中可能显示空白）：父表有变更时,子表将外键列设置成一个默认的值，但Innodb不能识别

on update No action | Restrict | Set null | Cascade 
on delete No action | Restrict | Set null | Cascade 
如果没有写on update 或on delete字句，表示选择了No action | Restrict。

*/
#父表
create table dept(
	did int primary key auto_increment,
	dname varchar(50) unique key not null
);

insert into dept values(null,'财务'),(null,'教学'),(null,'咨询'),(null,'后勤');

mysql> select * from dept;
+-----+-------+
| did | dname |
+-----+-------+
|   4 | 后勤  |
|   3 | 咨询  |
|   2 | 教学  |
|   1 | 财务  |
+-----+-------+
4 rows in set (0.00 sec)

#子表
create table emp(
	id int primary key auto_increment,
	name varchar(20) not null,
	departmentid int,
	foreign key (departmentid) references dept(did) on update cascade on delete set null
	#on delete set null要求departmentid字段没有not null约束
);

#添加子表时记录和  定义on update cascade on delete set null无关。还是要在主表能找到对应的记录。
insert into emp values(null,'张三',1);
insert into emp values(null,'李四',2);
insert into emp values(null,'王五',1);

mysql> select * from emp;
+----+------+--------------+
| id | name | departmentid |
+----+------+--------------+
|  1 | 张三 |            1 |
|  2 | 李四 |            2 |
|  3 | 王五 |            1 |
+----+------+--------------+
3 rows in set (0.00 sec)

#修改子表， 和  定义on update cascade on delete set null无关。还是要在主表能找到对应的记录。
update emp set departmentid = 6 where name = '王五';
#失败，因为departmentid = 6在父表dept中找不到对应部门

#修改父表被引用的did值， 和  定义on update cascade on delete set null有关。
update dept set did = 6 where did = 1; 
#此时did=1的记录被子表引用了，可以修改，并且会同时修改子表的departmentid=1的字段值为6，级联修改

mysql> select * from dept;
+-----+-------+
| did | dname |
+-----+-------+
|   4 | 后勤  |
|   3 | 咨询  |
|   2 | 教学  |
|   6 | 财务  |
+-----+-------+
4 rows in set (0.00 sec)

mysql> select * from emp;
+----+------+--------------+
| id | name | departmentid |
+----+------+--------------+
|  1 | 张三 |            6 |
|  2 | 李四 |            2 |
|  3 | 王五 |            6 |
+----+------+--------------+
3 rows in set (0.00 sec)

#删除父表dept被引用的did的记录， 和  定义on update cascade on delete set null有关。
delete from dept where did = 6; #did=6的部门在子表中有引用

mysql> select * from dept;
+-----+-------+
| did | dname |
+-----+-------+
|   4 | 后勤  |
|   3 | 咨询  |
|   2 | 教学  |
+-----+-------+
3 rows in set (0.00 sec)

mysql> select * from emp;
+----+------+--------------+
| id | name | departmentid |
+----+------+--------------+
|  1 | 张三 |         NULL |
|  2 | 李四 |            2 |
|  3 | 王五 |         NULL |
+----+------+--------------+
3 rows in set (0.00 sec)


