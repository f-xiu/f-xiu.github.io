#演示左连接
/*
观察数据：
t_employee  看成A表
t_department 看成B表
此时t_employee （A表）中有 李红和周洲的did是NULL，没有对应部门，
    t_department（B表）中有 测试部，在员工表中找不到对应记录的。
*/
#查询所有员工，包括没有指定部门的员工，他们的姓名、薪资、部门编号、部门名称
SELECT ename,salary,t_department.did,dname
FROM t_employee LEFT JOIN t_department
ON t_employee.did = t_department.did;
#查询的是A结果  A left join B

#查询没有部门的员工信息
SELECT ename,salary,t_department.did,dname
FROM t_employee LEFT JOIN t_department
ON t_employee.did = t_department.did
WHERE t_employee.did IS NULL;
#查询的结果是A - A∩B
#此时的where条件，建议写子表的关联字段is null，这样更准确一点。
#如果要建外键，它们肯定有子表和父表的角色，写子表的关联字段is null
#因为父表中这个字段一般是主键，不会为null。
