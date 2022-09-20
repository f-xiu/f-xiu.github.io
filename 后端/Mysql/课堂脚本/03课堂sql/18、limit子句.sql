#演示limit子句
/*
limit子句是用于分页显示结果。
limit m,n
n：表示最多该页显示几行
m：表示从第几行开始取记录，第一个行的索引是0
m = (page-1)*n  page表示第几页

每页最多显示5条，n=5
第1页，page=1，m = (1-1)*5 = 0;  limit 0,5
第2页，page=2，m = (2-1)*5 = 5;  limit 5,5
第3页，page=3，m = (3-1)*5 = 10;  limit 10,5
*/
#查询员工表的数据，分页显示，每页显示5条记录
#第1页
SELECT * FROM t_employee LIMIT 0,5;
#第2页
SELECT * FROM t_employee LIMIT 5,5;
#第3页
SELECT * FROM t_employee LIMIT 10,5;
#第4页
SELECT * FROM t_employee LIMIT 15,5;
#第5页
SELECT * FROM t_employee LIMIT 20,5;
#第6页
SELECT * FROM t_employee LIMIT 25,5;


#查询所有的男员工信息，分页显示，每页显示3条，第2页
#limit m,n  n=3,page=2,m=(page-1)*n=3
SELECT *
FROM t_employee
WHERE gender ='男'
LIMIT 3,3

#查询每一个编号为偶数的部门，显示部门编号，名称，员工数量，
#只显示员工数量>=2的结果，按照员工数量升序排列，
#每页显示2条，显示第1页
SELECT t_department.did,dname,COUNT(eid)
FROM t_employee RIGHT JOIN t_department
ON t_employee.did = t_department.did
WHERE t_department.did%2=0
GROUP BY t_department.did
HAVING COUNT(eid)>=2
ORDER BY COUNT(eid)
LIMIT 0,2;







