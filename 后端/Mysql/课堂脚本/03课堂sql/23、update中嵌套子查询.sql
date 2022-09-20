#子查询也可以嵌套在update语句中
#（1）修改“t_employee”表中部门编号（did）和
#“测试部”部门编号（did）相同的员工薪资为原来薪资的1.5倍。
UPDATE t_employee
SET salary = salary * 1.5
WHERE did = (SELECT did FROM t_department WHERE dname = '测试部');

#（2）修改“t_employee”表中did为NULL的员工信息，
#将他们的did值修改为“测试部”的部门编号。
#子查询select did from t_department where dname = '测试部'
#这种子查询必须是单个值，否则无法赋值

UPDATE t_employee 
SET did = (SELECT did FROM t_department WHERE dname = '测试部')
WHERE did IS NULL;

#（3）修改“t_employee”表中“李冰冰”的薪资值等于“孙红梅”的薪资值。
#这里使用子查询先在“t_employee”表中查询出“孙红梅”的薪资。
#select salary from t_employee where ename = '孙红梅';

UPDATE t_employee
SET salary = (SELECT salary FROM t_employee WHERE ename = '孙红梅')
WHERE ename = '李冰冰';
#You can't specify target table 't_employee' for update in FROM clause'

UPDATE t_employee
SET salary = (SELECT salary FROM(SELECT salary FROM t_employee WHERE ename = '孙红梅')temp)
WHERE ename = '李冰冰';
#当update的表和子查询的表是同一个表时，需要将子查询的结果用临时表的方式表示
#即再套一层子查询，使得update和最外层的子查询不是同一张表

#（4）修改“t_employee”表“李冰冰”的薪资与她所在部门的平均薪资一样。
#子查询，查询李冰冰的部门编号 
#select did from t_employee where ename = '李冰冰';

#子查询第二层，查询李冰冰所在部门的平均薪资
#select avg(salary) from t_employee where did = (select did from t_employee where ename = '李冰冰');

#子查询第三层，把第二层的子查询结果当成临时表再查一下结果
#目的使得和外层的update不是同一张表
SELECT pingjun FROM (SELECT AVG(salary) pingjun FROM t_employee WHERE did = (SELECT did FROM t_employee WHERE ename = '李冰冰') temp)

#update更新
UPDATE t_employee
SET salary = 
(SELECT pingjun FROM 
	(SELECT AVG(salary) pingjun FROM t_employee WHERE did = 
		(SELECT did FROM t_employee WHERE ename = '李冰冰') ) temp)
WHERE ename = '李冰冰';
