#演示分组函数，聚合函数，多行函数
#统计t_employee表的员工的数量
SELECT COUNT(*) FROM t_employee;
SELECT COUNT(1) FROM t_employee;
SELECT COUNT(eid) FROM t_employee;
SELECT COUNT(commission_pct) FROM t_employee;

/*
count(*)或count(常量值)：都是统计实际的行数。
count(字段/表达式)：只统计“字段/表达式”部分非NULL值的行数。
*/

#找出t_employee表中最高的薪资值
SELECT MAX(salary) FROM t_employee;

#找出t_employee表中最低的薪资值
SELECT MIN(salary) FROM t_employee;

#统计t_employee表中平均薪资值
SELECT AVG(salary) FROM t_employee;

#统计所有人的薪资总和，财务想看一下，一个月要准备多少钱发工资
SELECT SUM(salary) FROM t_employee; #没有考虑奖金
SELECT SUM(salary+salary*IFNULL(commission_pct,0)) FROM t_employee; 

#找出年龄最小、最大的员工的出生日期
SELECT MAX(birthday),MIN(birthday) FROM t_employee;

#查询最新入职的员工的入职日期
SELECT MAX(hiredate) FROM t_employee;




