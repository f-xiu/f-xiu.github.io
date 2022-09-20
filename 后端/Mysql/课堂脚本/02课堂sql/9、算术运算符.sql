#演示运算符
/*
运算符：
（1）算术运算符
（2）比较运算符
（3）逻辑运算符
（4）位运算符（不讲）
*/
/*
算术运算符：
（1）加：+
在MySQL +就是求和，没有字符串拼接

（2）减：-
（3）乘：*
（4）除：/   div
div：两个数相除只保留整数部分
/：数学中的除

（5）模：%   mod

*/

#select 表达式
select 1+1;
update t_employee set salary = salary+100 where eid=27;

select 9/2, 9 div 2;

mysql> select 9/2, 9 div 2;
+--------+---------+
| 9/2    | 9 div 2 |
+--------+---------+
| 4.5000 |       4 |
+--------+---------+
1 row in set (0.00 sec)

select 9.5 / 1.5 , 9.5 div 1.5;

mysql> select 9.5 / 1.5 , 9.5 div 1.5;
+-----------+-------------+
| 9.5 / 1.5 | 9.5 div 1.5 |
+-----------+-------------+
|   6.33333 |           6 |
+-----------+-------------+
1 row in set (0.00 sec)

select 9 % 2, 9 mod 2;
select 9.5 % 1.5 , 9.5 mod 1.5;

select 'hello' + 'world';
mysql> select 'hello' + 'world';
+-------------------+
| 'hello' + 'world' |
+-------------------+
|                 0 |
+-------------------+
1 row in set, 2 warnings (0.00 sec)
