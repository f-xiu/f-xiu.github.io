#演示用union合并两个查询结果实现A∪B 和A∪B - A∩B
/*
union合并时要注意：
（1）两个表要查询的结果字段是一样的
（2）UNION ALL表示直接合并结果，如果有重复的记录一并显示
   ALL去掉表示合并结果时，如果有重复记录，去掉。
（3）要实现A∪B的结果，那么必须是合并 查询是A表结果和查询是B表结果的select语句。
同样要实现A∪B - A∩B的结果，那么必须是合并查询是A-A∩B结果和查询是B-A∩B的select语句。
*/

#查询所有员工和所有部门，包括没有指定部门的员工和没有分配员工的部门。
SELECT *
FROM t_employee LEFT JOIN t_department
ON t_employee.did = t_department.did

UNION 

SELECT *
FROM t_employee RIGHT JOIN t_department
ON t_employee.did = t_department.did;


#以下union会报错
SELECT * FROM t_employee
UNION
SELECT * FROM t_department;
/*
错误代码： 1222
The used SELECT statements have a different number of columns
两个Select语句的列数是不同的。

column：列，表中的字段。
columns：很多的字段，即字段列表
select 字段列表 from 表名称;
*/


#联合 查询结果是A表的select 和查询结果是A∩B的select语句，是得不到A∪B
SELECT *
FROM t_employee LEFT JOIN t_department
ON t_employee.did = t_department.did

UNION 

SELECT *
FROM t_employee INNER JOIN t_department
ON t_employee.did = t_department.did;

#查询那些没有分配部门的员工和没有指定员工的部门，即A表和B表在对方那里找不到对应记录的数据。
SELECT *
FROM t_employee LEFT JOIN t_department
ON t_employee.did = t_department.did
WHERE t_employee.did IS NULL

UNION 

SELECT *
FROM t_employee RIGHT JOIN t_department
ON t_employee.did = t_department.did
WHERE t_employee.did IS NULL;