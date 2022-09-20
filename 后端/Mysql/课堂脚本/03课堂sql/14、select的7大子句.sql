/*
select语句是DML语句中使用最频繁的语句。
也是形式最复杂的语句。

select后面可以跟7个子句：
（1）from ：指定从哪个表中查询
（2）on：不能单独使用，必须配合join才能用
A表 inner join B表 on A表.关联字段 = B表.关联字段
A表 left  join B表 on A表.关联字段 = B表.关联字段
A表 right join B表 on A表.关联字段 = B表.关联字段
（3）where：编写从表中筛选记录的条件
（4）group by 子句：用什么字段进行分组查询
（5）having子句：在分组查询的基础上，having后面编写对对统计结果再次筛选的条件
（6）order by：按照什么进行排序
（7）limit：分页显示结果

7个子句不要求全部出现，只要出现了子句，必须按照（1）->（7）的顺序。
不管出现哪个写子句，顺序不能乱。
*/

#select 语句可以没有任何子句，只有表达式
SELECT 1+1;
SELECT NOW();

#select加from子句是为了指明数据的来源是哪个表。
SELECT * FROM t_employee;

SELECT * 
FROM t_employee ,t_department
ON t_employee.did = t_department.did; 
#错误，on没有join是错误

#如果不用join和on，两个表之间使用,逗号一起查询，
#在where中写关联条件，也能一起查询，实现的是inner join的效果。
SELECT * 
FROM t_employee ,t_department
WHERE t_employee.did = t_department.did; 


#查询薪资高于15000的男员工的记录
#此时筛选的条件  薪资和性别是原表中有的，用where筛选
SELECT * FROM t_employee 
WHERE salary>15000 AND gender ='男';

#查询薪资高于15000的男员工的编号、姓名、部门编号、部门名称
SELECT * 
FROM t_employee LEFT JOIN t_department
WHERE salary>15000 AND gender ='男'
ON t_employee.did = t_department.did; #错误，on子句不能写到where后面去

SELECT eid,ename,t_department.did,dname
FROM t_employee LEFT JOIN t_department
ON t_employee.did = t_department.did
WHERE salary>15000 AND gender ='男';

