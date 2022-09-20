#日期时间函数
/*
获取系统日期时间值
获取某个日期或时间中的具体的年、月等值
获取星期、月份值，可以是当天的星期、当月的月份
获取一年中的第几个星期，一年的第几天
计算两个日期时间的间隔
获取一个日期或时间间隔一定时间后的另个日期或时间
和字符串之间的转换
*/
#（1）获取系统日期。CURDATE（）和CURRENT_DATE（）函数都可以获取当前系统日期。将日期值“+0”会怎么样？
SELECT CURDATE(),CURRENT_DATE();

#（2）获取系统时间。CURTIME（）和CURRENT_TIME（）函数都可以获取当前系统时间。将时间值“+0”会怎么样？
SELECT CURTIME(),CURRENT_TIME();

#（3）获取系统日期时间值。CURRENT_TIMESTAMP（）、LOCALTIME（）、SYSDATE（）和NOW（）
SELECT CURRENT_TIMESTAMP(),LOCALTIME(),SYSDATE(),NOW();

#（4）获取当前UTC（世界标准时间）日期或时间值。
#本地时间是根据地球上不同时区所处的位置调整 UTC 得来的，
#例如，北京时间比UTC时间晚8个小时。
#UTC_DATE(),CURDATE(),UTC_TIME(), CURTIME()
SELECT UTC_DATE(),CURDATE(),UTC_TIME(), CURTIME();


#（5）获取UNIX时间戳。
SELECT UNIX_TIMESTAMP(),UNIX_TIMESTAMP('2022-1-1');

#（6）获取具体的时间值，比如年、月、日、时、分、秒。
#分别是YEAR（date）、MONTH（date）、DAY（date）、HOUR（time）、MINUTE（time）、SECOND（time）。
SELECT YEAR(CURDATE()),MONTH(CURDATE()),DAY(CURDATE());
SELECT HOUR(CURTIME()),MINUTE(CURTIME()),SECOND(CURTIME());


#（7）获取日期时间的指定值。EXTRACT（type FROM date/time）函数
SELECT EXTRACT(YEAR_MONTH FROM CURDATE());

#（8）获取两个日期或时间之间的间隔。
#DATEDIFF（date1，date2）函数表示返回两个日期之间间隔的天数。
#TIMEDIFF（time1，time2）函数表示返回两个时间之间间隔的时分秒。

#查询今天距离员工入职的日期间隔天数
SELECT ename,DATEDIFF(CURDATE(),hiredate) FROM t_employee;

#查询现在距离中午放学还有多少时间
SELECT TIMEDIFF(CURTIME(),'12:0:0');

#（9）在“t_employee”表中查询本月生日的员工姓名、生日。
SELECT ename,birthday
FROM t_employee
WHERE MONTH(CURDATE()) = MONTH(birthday);


#(10)#查询入职时间超过5年的
SELECT ename,hiredate,DATEDIFF(CURDATE(),hiredate) 
FROM t_employee
WHERE DATEDIFF(CURDATE(),hiredate)  > 365*5;

