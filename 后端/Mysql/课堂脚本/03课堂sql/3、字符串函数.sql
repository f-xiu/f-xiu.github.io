#字符串函数
#mysql中不支持 + 拼接字符串，需要调用函数来拼接
#（1）在“t_employee”表中查询员工姓名ename和电话tel，
#并使用CONCAT函数，CONCAT_WS函数。
SELECT CONCAT(ename,tel),CONCAT_WS('-',ename,tel) FROM t_employee;


#（2）在“t_employee”表中查询薪资高于15000的男员工姓名，
#并把姓名处理成“张xx”的样式。
#LEFT（s，n）函数表示取字符串s最左边的n个字符，
#而RPAD（s，len，p）函数表示在字符串s的右边填充p使得字符串长度达到len。
SELECT  RPAD(LEFT(ename,1),3,'x'),salary
FROM t_employee
WHERE salary>15000 AND gender ='男';

#（3）在“t_employee”表中查询薪资高于10000的男员工姓名、
#姓名包含的字符数和占用的字节数。
SELECT ename,CHAR_LENGTH(ename) AS 占用字符数,LENGTH(ename) AS 占用字节数量
FROM t_employee
WHERE salary>10000 AND gender ='男';


#（4）在“t_employee”表中查询薪资高于10000的男员工姓名和邮箱email，
#并把邮箱名“@”字符之前的字符串截取出来。
SELECT ename,email,
SUBSTRING(email,1, POSITION('@' IN email)-1)
FROM t_employee
WHERE salary > 10000 AND gender ='男';

#mysql中 SUBSTRING截取字符串位置，下标从1开始，不是和Java一样从0开始。
#mysql中 position等指定字符串中某个字符，子串的位置也不是从0开始，都是从1开始。

SELECT TRIM('    hello   world   '); #默认是去掉前后空白符
SELECT CONCAT('[',TRIM('    hello   world   '),']'); #默认是去掉前后空白符
SELECT TRIM(BOTH '&' FROM '&&&&hello   world&&&&'); #去掉前后的&符号
SELECT TRIM(LEADING '&' FROM '&&&&hello   world&&&&'); #去掉开头的&符号
SELECT TRIM(TRAILING '&' FROM '&&&&hello   world&&&&'); #去掉结尾的&符号