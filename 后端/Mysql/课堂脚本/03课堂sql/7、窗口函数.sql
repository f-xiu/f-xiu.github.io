#演示一下窗口函数
##在“t_employee”表中查询薪资高于12000的
#员工姓名，部门编号，职位编号，查询结果按照部门编号分组后按照职位编号升序排列，
#并给每一行记录编序号。
SELECT ename,did,job_id,
ROW_NUMBER() over()
FROM t_employee
WHERE salary>12000;

SELECT ename,did,job_id,
ROW_NUMBER() over(),
ROW_NUMBER() over(PARTITION BY did)
FROM t_employee
WHERE salary>12000;

SELECT ename,did,job_id,
ROW_NUMBER() over() AS r1,
ROW_NUMBER() over(PARTITION BY did) AS r2,
RANK() over(PARTITION BY did ORDER BY job_id) AS r3,
dense_RANK() over(PARTITION BY did ORDER BY job_id) AS r4
FROM t_employee
WHERE salary>12000;


#查询每一个部门，薪资第一名的员工姓名
#如果薪资一样，名次就一样
SELECT ename,did,salary
RANK() over(PARTITION BY did ORDER BY job_id) AS r
FROM t_employee
WHERE r = 1; #错误，因为r不是t_employee中的记录，
#是对select筛选结果统计出来的。

SELECT * FROM(
SELECT ename,did,salary,
RANK() over(PARTITION BY did ORDER BY salary DESC) AS r
FROM t_employee) temp
WHERE r=1;

/*把用窗口函数统计的结果 当成一张临时表，用别名的方式来表示这个临时表，
在统计结果基础上进行筛选。*/

+----------+------+--------+----+
| ename    | did  | salary | r  |
+----------+------+--------+----+
| 周洲     | NULL |   8100 |  1 |
| 李红     | NULL |   5000 |  2 |
| 孙洪亮   |    1 |  28000 |  1 |
| 王冰     |    1 |  18760 |  2 |
| 贾宝玉   |    1 |  15700 |  3 |
| 黄冰茹   |    1 |  15678 |  4 |
| 陈纲     |    1 |  13090 |  5 |
| 韩庚年   |    1 |  12000 |  6 |
| 额日古那 |    1 |   9087 |  7 |
| 李晨熙   |    1 |   9000 |  8 |
| 孙红梅   |    1 |   9000 |  8 |
| 陆风     |    1 |   8789 | 10 |
| 陈浩     |    1 |   8567 | 11 |
| 邓超远   |    1 |   8000 | 12 |
| 李易峰   |    1 |   7897 | 13 |
| 何进     |    1 |   7001 | 14 |
| 谢吉娜   |    2 |  18978 |  1 |
| 董吉祥   |    2 |   8978 |  2 |
| 刘烨     |    3 |  13099 |  1 |
| 彭超越   |    3 |   9878 |  2 |
| 黄熙萌   |    3 |   9456 |  3 |
| 李诗雨   |    3 |   9000 |  4 |
| 舒淇格   |    4 |  16788 |  1 |
| 周旭飞   |    4 |   7876 |  2 |
| 章嘉怡   |    5 |  15099 |  1 |
| 吉日格勒 |    5 |  10289 |  2 |
| 白露     |    5 |   9787 |  3 |
+----------+------+--------+----+
27 ROWS IN SET (0.00 sec)
