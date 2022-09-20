#演示内连接
/*
观察数据：
t_employee  看成A表
t_department 看成B表
此时t_employee （A表）中有 李红和周洲的did是NULL，没有对应部门，
    t_department（B表）中有 测试部，在员工表中找不到对应记录的。
*/

#查询所有员工的姓名，部门编号，部门名称
#如果员工没有部门的，不要
#如果部门没有员工的，不要
/*
员工的姓名在t_employee （A表）中
部门的编号，在t_employee （A表）和t_department（B表）都有
部门名称在t_department（B表）中
所以需要联合两个表一起查询。
*/
SELECT ename,did,dname
FROM t_employee INNER JOIN t_department;
#错误Column 'did' in field list is ambiguous
#因为did在两个表中都有，名字相同，它不知道取哪个表中字段了
#有同学说，它俩都是部门编号，随便取一个不就可以吗？
#mysql不这么认为，有可能存在两个表都有did，但是did的意义不同的情况。
#为了避免这种情况，需要在编写sql的时候，明确指出是用哪个表的did

SELECT ename,t_department.did,dname
FROM t_employee INNER JOIN t_department;
#语法对，结果不太对
#结果出现“笛卡尔积”现象， A表记录 * B表记录
/*
（1）凡是联合查询的两个表，必须有“关联字段”，
关联字段是逻辑意义一样，数据类型一样，名字可以一样也可以不一样的两个字段。
比如：t_employee （A表）中did和t_department（B表）中的did。

发现关联字段其实就是可以建外键的字段。当然联合查询不要求一定建外键。

（2）联合查询必须写关联条件，关联条件的个数 = n - 1.
n是联合查询的表的数量。
如果2个表一起联合查询，关联条件数量是1，
如果3个表一起联合查询，关联条件数量是2，
如果4个表一起联合查询，关联条件数量是3，
。。。。
否则就会出现笛卡尔积现象，这是应该避免的。

（3）关联条件可以用on子句编写，也可以写到where中。
但是建议用on单独编写，这样呢，可读性更好。

每一个join后面都要加on子句
A inner|left|right join  B on 条件
A inner|left|right join  B on 条件 inner|left|right jon C on 条件
*/


SELECT ename,t_department.did,dname
FROM t_employee INNER JOIN t_department 
ON t_employee.did = t_department.did;

SELECT *
FROM t_employee INNER JOIN t_department 
ON t_employee.did = t_department.did;


#查询部门编号为1的女员工的姓名、部门编号、部门名称、薪资等情况
SELECT ename,gender,t_department.did,dname,salary
FROM t_employee INNER JOIN t_department 
ON t_employee.did = t_department.did
WHERE t_department.did = 1 AND gender = '女';

#查询部门编号为1的员工姓名、部门编号、部门名称、薪资、职位编号、职位名称等情况
SELECT ename,gender,t_department.did,dname,salary,job_id,jname
FROM t_employee INNER JOIN t_department ON t_employee.did = t_department.did
 INNER JOIN t_job ON t_employee.`job_id` = t_job.`jid`
WHERE t_department.did = 1;



