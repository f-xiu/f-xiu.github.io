#演示分组查询
/*
分组查询需要配合分组函数使用
*/
#查询每一个部门的员工数量
SELECT did,COUNT(*) 
FROM t_employee
GROUP BY did;

#以下写法是错误的
SELECT ename,did,COUNT(*) 
FROM t_employee
GROUP BY did;
#使用group by进行分组查询时，不要在select后面写和分组无关的字段。
#ename此处和分组无关。写了语法上不报错，逻辑上有问题。
#did和count(*)和分组有关。

#查询每一个部门的员工数量，并显示部门编号和名称
SELECT t_department.did,dname,COUNT(eid)
FROM t_employee RIGHT JOIN t_department
ON t_employee.did = t_department.did
GROUP BY t_department.did

UNION

SELECT t_department.did,dname,COUNT(eid)
FROM t_employee LEFT JOIN t_department
ON t_employee.did = t_department.did
GROUP BY t_department.did;


#分组查询每一个部门的最高薪资，平均薪资，最低薪资
SELECT did, MAX(salary),AVG(salary),MIN(salary)
FROM t_employee
GROUP BY did;

#查询每一个部门的男员工的数量
SELECT did,COUNT(*) 
FROM t_employee
WHERE gender='男'
GROUP BY did;

#查询每一个部门的男员工数量，并显示部门编号和名称
SELECT t_department.did,dname,COUNT(eid)
FROM t_employee RIGHT JOIN t_department
ON t_employee.did = t_department.did
WHERE gender = '男'
GROUP BY t_department.did

UNION

SELECT t_department.did,dname,COUNT(eid)
FROM t_employee LEFT JOIN t_department
ON t_employee.did = t_department.did
WHERE gender = '男'
GROUP BY t_department.did;

#统计每一个部门的男和女员工各有多少人
SELECT t_department.did,dname,gender,COUNT(eid)
FROM t_employee RIGHT JOIN t_department
ON t_employee.did = t_department.did
GROUP BY t_department.did,gender

UNION

SELECT t_department.did,dname,gender,COUNT(eid)
FROM t_employee LEFT JOIN t_department
ON t_employee.did = t_department.did
GROUP BY t_department.did,gender;  #先按照部门分组，再按照性别分组

