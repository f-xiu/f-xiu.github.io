#delete语句中也可以嵌套子查询
#（1）从“t_employee”表中删除“测试部”的员工记录。
DELETE FROM t_employee 
WHERE did = (SELECT did FROM t_department WHERE dname = '测试部');


#（2）从“t_employee”表中删除和“李冰冰”同一个部门的员工记录。
#子查询 “李冰冰”的部门编号
#select did from t_employee where ename = '李冰冰';

DELETE FROM t_employee WHERE did = (SELECT did FROM t_employee WHERE ename = '李冰冰');
#You can't specify target table 't_employee' for update in FROM clause'
#删除和子查询是同一张表

DELETE FROM t_employee WHERE did = (SELECT did FROM (SELECT did FROM t_employee WHERE ename = '李冰冰')temp);

