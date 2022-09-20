/*
子查询：嵌套在另一个SQL语句中的查询。
SELECT语句可以嵌套在另一个SELECT中，UPDATE，DELETE，INSERT，CREATE语句等。

(1)SELECT的SELECT中嵌套子查询
*/

#（1）在“t_employee”表中查询每个人薪资和公司平均薪资的差值，
#并显示员工薪资和公司平均薪资相差5000元以上的记录。
SELECT ename AS "姓名",
	salary AS "薪资",
 ROUND((SELECT AVG(salary) FROM t_employee),2) AS "全公司平均薪资",
 ROUND(salary-(SELECT AVG(salary) FROM t_employee),2) AS "差值"
FROM t_employee
WHERE ABS(ROUND(salary-(SELECT AVG(salary) FROM t_employee),2))>5000;

#（2）在“t_employee”表中查询每个部门平均薪资和公司平均薪资的差值。
SELECT did,AVG(salary),
AVG(salary)-(SELECT AVG(salary) FROM t_employee)
FROM t_employee
GROUP BY did;


