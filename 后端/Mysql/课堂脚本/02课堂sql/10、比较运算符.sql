/*
比较运算符：
1、大于	>
2、小于	<
3、大于等于 >=
4、小于等于 <=
5、等于  =
在MySQL中比较是否相等也是用单等号，没有双等号。

6、不等于 !=  或  <>

7、安全等于<=>

8、is null和is not null

MySQL中NULL的判断和计算问题：
判断用<=> null 或is null 为空判断
判断用is not null 非空判断

9、集合范围的范围
in (值列表)  或 not in(值列表)
每一个值用逗号分隔

10、区间范围的判断
between xx and yy  或 not between xx and yy
between xx and yy：[xx,yy]
not between xx and yy： <xx || >yy

11、like 模糊查询
like配合通配符_或%使用
_：一个下划线代表一位字符
%：一个%代表任意个（0个或n个）字符


*/

#查询薪资高于15000的员工姓名和薪资
select ename,salary from t_employee where salary>15000;

mysql> select ename,salary from t_employee where salary>15000;
+--------+--------+
| ename  | salary |
+--------+--------+
| 孙洪亮 |  28000 |
| 贾宝玉 |  15700 |
| 黄冰茹 |  15678 |
| 李冰冰 |  18760 |
| 谢吉娜 |  18978 |
| 舒淇格 |  16788 |
| 章嘉怡 |  15099 |
+--------+--------+
7 rows in set (0.00 sec)

#查询薪资正好是9000的员工姓名和薪资
select ename,salary from t_employee where salary = 9000;
select ename,salary from t_employee where salary == 9000;#错误，不支持==

mysql> select ename,salary from t_employee where salary == 9000;
ERROR 1064 (42000): You have an error in your SQL syntax;
 check the manual that corresponds to your MySQL server version for the right syntax to use near '== 9000' at line 1


#查询员工表中部门编号不是1
select * from t_employee where did != 1;
select * from t_employee where did <> 1;

#查询奖金比例是NULL
select * from t_employee where commission_pct = null; 

mysql> select * from t_employee where commission_pct = null; #无法用=null判断
Empty set (0.00 sec)
#mysql中只要有null值参与运算和比较，结果就是null，底层就是0，表示条件不成立。

#查询奖金比例是NULL
select * from t_employee where commission_pct <=> null; 
select * from t_employee where commission_pct is null; 


#查询“李冰冰”、“周旭飞”、“李易峰”这几个员工的信息
select * from t_employee where ename in ('李冰冰','周旭飞','李易峰');

#查询部门编号为2、3的员工信息
select * from t_employee where did in(2,3);

#查询部门编号不是2、3的员工信息
select * from t_employee where did not in(2,3);

#查询薪资在[10000,15000]之间
select * from t_employee where salary between 10000 and 15000;


#查询姓名中第二个字是'冰'的员工
select * from t_employee where ename like '冰'; #这么写等价于 ename='冰'
select * from t_employee where ename like '_冰%'; 
#这么写匹配的是第二个字是冰，后面可能没有第三个字，或者有好几个字

update t_employee set ename = '王冰' where ename = '李冰冰';

select * from t_employee where ename like '_冰_'; 
#这么写匹配的是第二个字是冰，后面有第三个字，且只有三个字


#查询员工的姓名、薪资、奖金比例、实发工资
#实发工资 = 薪资 + 薪资 * 奖金比例
select ename as 姓名,
salary as 薪资,
commission_pct as 奖金比例,
salary + salary * commission_pct as 实发工资
from t_employee;

#NULL在mysql中比较和计算都有特殊性，所有的计算遇到的null都是null。
#实发工资 = 薪资 + 薪资 * 奖金比例
select ename as 姓名,
salary as 薪资,
commission_pct as 奖金比例,
salary + salary * ifnull(commission_pct,0) as 实发工资
from t_employee;


