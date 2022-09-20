#演示order by
/*
order by 字段：默认是升序
order by 字段 desc：表示降序
order by 字段 asc：表示升序
order by 字段1 [asc或省略|desc], 字段2[asc或省略|desc]：表示先按字段1排序，如果字段1值相同，再按照字段2排序
lorder by后面每一个字段的都可以单独指定是升序还是降序，如果没有写asc或desc表示升序。

*/
#查询员工信息，按照薪资从高到低
SELECT * FROM t_employee ORDER BY salary DESC;

#查询员工信息，按照薪资从高到低，如果薪资相同，按照年龄从小到大
SELECT * FROM t_employee 
ORDER BY salary DESC, birthday DESC;

#查询员工信息，按照薪资从低到高，如果薪资相同，按照年龄从小到大
SELECT * FROM t_employee 
ORDER BY salary , birthday DESC;

#查询每一个部门的平均薪资，并且按照平均薪资从高到低
SELECT did,AVG(salary)
FROM t_employee
GROUP BY did
ORDER BY AVG(salary) DESC;


#查询每一个部门的男员工的部门编号、部门名称、平均薪资，
#并且显示平均薪资超过10000，
#最后按照平均薪资升序排列。
SELECT t_department.did, dname,AVG(salary)
FROM t_employee RIGHT JOIN t_department
ON t_employee.did = t_department.did
WHERE gender = '男'
GROUP BY t_department.did
HAVING AVG(salary)>10000
ORDER BY AVG(salary);



