#演示特殊的联合查询/关联查询/多表查询：自连接
#物理上，是一张表
#逻辑上，是两张表
/*
分析表结构：t_employee表
mid：是表示存储员工的领导编号。即该员工归谁管。
    领导编号其中就是“领导”作为员工的员工编号
   例如：eid为3的员工邓超远，他的mid是7，表示他的领导是员工编号为7的员工。
   eid为7的员工是贾宝玉，他的eid是7，贾宝玉作为员工来说，他的编号是7，
   作为领导来说，他的编号也是7。

mid的取值范围受到eid字段的限制。mid的值选择必须是eid有的值范围。

可以理解为mid和eid是关联字段，如果要建外键，可以在mid字段上建外键。
foreign key(mid) references t_employee(eid)   

此时t_employee既是子表也是父表。
员工表t_employee建立了外键：
CONSTRAINT `t_employee_ibfk_3` FOREIGN KEY (`mid`) REFERENCES `t_employee` (`eid`) ON DELETE SET NULL ON UPDATE CASCADE
*/
#查询每一个员工自己的编号、名字、薪资和他的领导的编号、姓名、薪资。
SELECT emp.eid,emp.ename,emp.salary,  mgr.eid,mgr.ename,mgr.salary
FROM t_employee AS emp INNER JOIN t_employee AS mgr
ON emp.mid = mgr.eid; 
#把t_employee当成两张表，通过取别名的方式
#t_employee AS emp 把员工表 当成员工表
# t_employee AS mgr 把员工表  当成存储领导信息的领导表
#emp.mid = mgr.eid; 员工表的领导编号就是领导表的员工编号



