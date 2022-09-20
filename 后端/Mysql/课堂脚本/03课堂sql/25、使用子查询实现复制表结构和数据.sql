#演示通过子查询复制表，
#（1）复制表结构
#（2）复制一条或多条记录
#（3）同时复制表结构和记录
#仅仅是复制表结构，可以用create语句
CREATE TABLE department LIKE t_department;

#使用INSERT语句+子查询，复制数据，此时INSERT不用写values
INSERT INTO department (SELECT * FROM t_department WHERE did<=3);

#同时复制表结构+数据
CREATE TABLE d_department AS (SELECT * FROM t_department);
#如果select后面是部分字段，复制的新表就只有这一部分字段