#having子句的使用
/*
having子句是在group by分组统计的基础上再次筛选结果的子句。
having子句后面也是编写条件的。

having和where的区别：
（1）where后面是不能出现分组函数/聚合函数/多行函数（avg,min,max,count,sum等）
having后面可以接分组函数
（2）where是基于原表中的数据筛选，having基于分组统计结果的筛选。

on子句也是写条件，on后面是写联合查询的关联条件。
*/

#按照部门统计平均薪资，显示平均薪资高于10000的部门
#以下写法错误
SELECT did,AVG(salary)
FROM t_employee
WHERE AVG(salary)>10000 #Invalid use of group function
GROUP BY did;

SELECT did,AVG(salary)
FROM t_employee
GROUP BY did
HAVING AVG(salary)>10000;

#按照部门统计薪资高于10000的员工数量
#并且只显示员工数量>=2人
SELECT did,COUNT(*)
FROM t_employee
WHERE salary>10000
GROUP BY did
HAVING COUNT(*)>=2;


SELECT t_department.did,dname,COUNT(*)
FROM t_employee RIGHT JOIN t_department
ON t_employee.did = t_department.did
WHERE salary>10000
GROUP BY did
HAVING COUNT(*)>=2;

SELECT t_department.did,dname,COUNT(*) AS 人数
FROM t_employee RIGHT JOIN t_department
ON t_employee.did = t_department.did
WHERE salary>10000
GROUP BY did
HAVING 人数>=2;
