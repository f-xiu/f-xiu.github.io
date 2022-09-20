#条件判断函数
/*
这个函数不是筛选记录的函数，
而是根据条件不同显示不同的结果的函数。
*/
#如果薪资大于20000，显示高薪，否则显示正常
SELECT ename,salary,IF(salary>20000,'高薪','正常')
FROM t_employee;

#计算实发工资
#实发工资 = 薪资 + 薪资 * 奖金比例
SELECT ename,salary,commission_pct,
salary + salary * commission_pct
FROM t_employee;
#如果commission_pct是，计算完结果是NULL

SELECT ename,salary,commission_pct,
salary + salary * IFNULL(commission_pct,0) AS 实发工资
FROM t_employee;


SELECT ename,salary,commission_pct,
ROUND(salary + salary * IFNULL(commission_pct,0),2) AS 实发工资
FROM t_employee;

#查询员工编号，姓名，薪资，等级，等级根据薪资判断，
#如果薪资大于20000，显示“羡慕级别”，
#如果薪资15000-20000，显示“努力级别”，
#如果薪资10000-15000，显示“平均级别”
#如果薪资10000以下，显示“保底级别”
/*mysql中没有if...elseif函数，有case 函数。
等价于if...elseif 
*/
SELECT eid,ename,salary,
CASE WHEN salary>20000 THEN '羡慕级别'
     WHEN salary>15000 THEN '努力级别'
     WHEN salary>10000 THEN '平均级别'
     ELSE '保底级别'
END AS "等级"
FROM t_employee;  

#在“t_employee”表中查询入职7年以上的
#员工姓名、工作地点、轮岗的工作地点数量情况。
/*
计算工作地点的数量，转换为求 work_place中逗号的数量+1。
 work_place中逗号的数量 = work_place的总字符数 -  work_place去掉,的字符数
 work_place去掉, ，使用replace函数
*/

SELECT work_place, 
CHAR_LENGTH(work_place)-CHAR_LENGTH(REPLACE(work_place,',',''))
FROM t_employee;
 
 #类似于Java中switch...case
SELECT ename,work_place,
CASE (CHAR_LENGTH(work_place)-CHAR_LENGTH(REPLACE(work_place,',',''))+1)
WHEN 1 THEN '只在一个地方工作'
WHEN 2 THEN '在两个地方来回奔波'
WHEN 3 THEN '在三个地方流动'
ELSE '频繁出差'
END AS "工作地点数量情况"
FROM t_employee
WHERE DATEDIFF(CURDATE(),hiredate)  > 365*7;

