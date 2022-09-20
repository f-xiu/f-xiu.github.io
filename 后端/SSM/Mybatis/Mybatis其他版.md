# 	一.概述

## 1.简介

* MyBatis是一款优秀的持久层框架，它支持**自定义 SQL、存储过程以及高级映射**。MyBatis免除了几乎所有的JDBC代码以及设置参数和获取结果集的工作。MyBatis可以通过简单的**XML或注解**来配置和映射原始类型、接口和Java POJO（Plain Old Java Objects，普通老式Java对象）为数据库中的记录

## 2.maven构建

* 将MyBatis相关依赖导入项目，pom.xml添加如下配置

  ```xml
  <dependency>
    <groupId>org.mybatis</groupId>
    <artifactId>mybatis</artifactId>
    <version>3.5.7</version>
  </dependency>
  ```

* 将Mysql相关依赖导入

  ```xml
  <dependency>
      <groupId>mysql</groupId>
      <artifactId>mysql-connector-java</artifactId>
      <version>5.1.37</version>
  </dependency>
  ```

* 将Junit相关依赖代入

  ```xml
  <dependency>
      <groupId>junit</groupId>
      <artifactId>junit</artifactId>
      <version>4.12</version>
      <scope>test</scope>
  </dependency>
  ```

* 将log4j相关依赖导入

  ```xml
  <dependency>
      <groupId>log4j</groupId>
      <artifactId>log4j</artifactId>
      <version>1.2.17</version>
  </dependency>
  ```

  log4j的配置文件名为log4j.xml，存放的位置是src/main/resources目录下：

  ```xml
  <?xml version="1.0" encoding="UTF-8" ?>
  <!DOCTYPE log4j:configuration SYSTEM "log4j.dtd">
  <log4j:configuration xmlns:log4j="http://jakarta.apache.org/log4j/">
  	<appender name="STDOUT" class="org.apache.log4j.ConsoleAppender">
  		<param name="Encoding" value="UTF-8" />
  		<layout class="org.apache.log4j.PatternLayout">
  			<param name="ConversionPattern" value="%-5p %d{MM-dd HH:mm:ss,SSS}%m (%F:%L) \n" />
  		</layout>
  	</appender>
  	<logger name="java.sql">
  		<level value="debug" />
  	</logger>
  	<logger name="org.apache.ibatis">
      	<level value="info" />
  	</logger>
  	<root>
  		<level value="debug" />
  		<appender-ref ref="STDOUT" />
  	</root>
  </log4j:configuration>
  ```

# 二.相关概念

## 1.Mapper接口

> MyBatis中的mapper接口相当于以前的dao。但是区别在于，mapper仅仅是接口，我们不需要提供实现类。

* Mapper接口的取名应该是和映射文件名保持一致

* 比如，某个实体类User，它的Mapper接口如下：

  ```java
  public interface UserMapper{
      int insert();
  }
  ```

* 在Mapper接口中可以提供一些抽象方法，用于增删改查

## 2.ORM思想

* ORM是指（Object Relationship Mapping）对象关系映射

* 其中

  * 对象：Java的实体类对象
  * 关系：关系型数据库
  * 映射：二者之间的对应关系

* 体现

  | Java概念 | 数据库概念 |
  | -------- | ---------- |
  | 类       | 表         |
  | 属性     | 字段/列    |
  | 对象     | 记录/行    |

# 三.映射配置文件

## 1.文件结构

* 命名规则：数据库表对应的类名+Mapper.xml

* 一个映射文件对应一个实体类，对应一个表中的操作

* 映射文件主要用于编写SQL、访问以及操作表中的数据

* 映射文件存放位置是maven工程下的src/main/resources/mappers目录下

* 映射配置文件要保证两个一致

  * mapper接口的**全类名**和映射文件的命名空间**namespace**保持一致
  * mapper接口中方法的**方法名**和映射文件中编写SQL的标签的**id属性**保持一致

* 映射文件的简易结构如下

  ```xml
  <?xml version="1.0" encoding="UTF-8" ?>
  <!--DTD约束-->
  <!DOCTYPE mapper
          PUBLIC "-//mybatis.org//DTD Mapper 3.0//EN"
          "http://mybatis.org/dtd/mybatis-3-mapper.dtd">
  <mapper namespace="Mapper接口全类名">
      <!--映射语句-->
      <insert id="Mapper接口方法名">
          SQL语句
      </insert>
  
  </mapper>
  ```

## 2.映射配置文件标签详解

* &lt;insert&gt;标签

  * 用于书写插入数据的SQL语句

  * id属性指定对应mapper接口的方法名

  * 范例

    ```xml
    <insert id="insertUser">
        SQL语句
    </insert>
    ```
    
    ```
    session.commit();//执行完sql语句后，提交操作。
    ```

* &lt;delete&gt;标签

  * 用于删除表中的数据

  * id属性指定对应mapper接口的方法名

  * 范例

    ```xml
    <delete id="deleteUser">
        SQL语句
    </delete>
    ```

* &lt;update&gt;标签

  * 用于更新表中数据

  * id属性指定对应mapper接口中的方法名

  * 范例

    ```xml
    <update id="updateUser">
        SQL语句
    </update>
    ```

* &lt;select&gt;标签

  * 用于查询表中的数据

  * id属性指定mapper接口中对应的方法名

  * resultType属性表示自动映射，**用于属性名和表中字段名一致的情况**

    **自动映射需要保证对象中属性的顺序与搜出的结果列一一对应，而且有对应的构造函数。**

    

  * resultMap属性表示自定义映射，**用于一对多或多对一或字段名和属性名不一致的情况**

    
  
  * 范例
  
    查询一条数据：

    ```xml
    <select id="getUserById" resultType="com.lxq.pojo.User">
        SQL语句
    </select>
    ```
  
    查询多条数据到List集合：
  
    ```xml
    <select id="getUserList" resultType="com.lxq.pojo.User">
        SQL语句
    </select>
    ```
    
    

## 3.SQL语句中参数的获取

### (1)获取方式

* MyBatis获取参数值的两种方式：**${}和#{}**

* ${}的本质是字符串拼接，#{}的本质是占位符赋值

* ${}方式会将参数原原本本拼接入SQL语句中，如果参数是字符串类型的需要手动加上引号

  ```xml
  `${参数}`
  ```

* #{}的方式会自动加上引号，如果是字符串类型的参数无需手动加上引号

  ```xml
  #{参数}
  ```

### (2)参数类型

* 单个字面量类型的参数

  * 字面量是指基本数据类型以及包装类还有自定义类等

  * 获取方式

    ```xml
    <select id="getUserByUsername" resultType="User">
        select * from t_user where username=#{username}
    </select>
    ```

  * 此时获取参数时花括号里边的参数名不做要求，可以是随意的名称，如果使用${}的方式记得加引号

* 多个字面量类型的参数

  * 若mapper接口中的方法参数为多个时，MyBatis会自动将这些参数放在一个map集合中，**此时参数名不能是随意的名称**

  * 这个map集合存放参数的形式是`arg0,arg1...`为map中的键，参数值为map中的值；还有`param1,param2...`为map中的键，参数值为map值的值

  * arg和param是同时存在于同一个map中的，在SQL语句获取参数时只需指定这些键的名称即可

  * 获取方式

    ```xml
    <!--arg的方式-->
    <select id="checkLogin" resultType="User">
        select * from t_user where username = #{arg0} and password = #{arg1}
    </select>
    <!--param的方式-->
    <select id="checkLogin" resultType="User">
            select * from t_user where username = #{param1} and password = #{param2}
    </select>
    ```

  * 如果使用${}的方式记得加引号

* map集合类型的参数

  * 为了在SQL语句中指定一些有意义的参数名，我们可以自己提供一个map集合，自定义一些键的名称即可

  * 通过自定义键的名称，我们在SQL语句里就可以使用自定义的参数名了

  * 比如，这个自定义的map集合可以是`{("username","参数值"),("password","参数值")}`

  * 获取方式

    ```xml
    <select id="checkLoginByMap" resultType="User">
        select * from t_user where username = #{username} and password = #{password}
    </select>
    ```

  * 如果使用${}的方式记得加引号

* 使用@Param注解标识的参数

  * 如果每次使用多个参数时都要自定义map集合就太麻烦了，所以可以通过使用@Param注解**在映射方法的形参中指定好参数名**

  * 比如，这个映射方法可以是

    ```java
    User getUserByParam(@Param("username") String username,@Param("password") String password);
    ```

  * 获取方式

    ```xml
    <select id="checkLoginByParam" resultType="User">
        select * from t_user where username = #{username} and password = #{password}
    </select>
    ```

  * 使用这种注解就可以方便获取参数了，如果使用${}的方式记得加引号

* 实体类型的参数

  * 如果映射方法的形参是一个实体类型时，可以**通过访问实体类对象中的属性名获取属性值**

  * 比如，这个实体类可以是

    ```java
    public class User {
        private Integer id;
        private String username;
        private String password;
        private Integer age;
        private String gender;
        private String email;
        //省略有参、无参构造方法以及toString()方法
        public Integer getId() {
            return id;
        }
        public void setId(Integer id) {
            this.id = id;
        }
        public String getUsername() {
            return username;
        }
        public void setUsername(String username) {
            this.username = username;
        }
        public String getPassword() {
            return password;
        }
        public void setPassword(String password) {
            this.password = password;
        }
        public Integer getAge() {
            return age;
        }
        public void setAge(Integer age) {
            this.age = age;
        }
        public String getGender() {
            return gender;
        }
        public void setGender(String gender) {
            this.gender = gender;
        }
        public String getEmail() {
            return email;
        }
        public void setEmail(String email) {
            this.email = email;
        }
    }
    ```

  * 获取方式

    ```xml
    <insert id="insertUser">
        insert into t_user value(null,#{username},#{password},#{age},#{gender},#{email})
    </insert>
    ```

  * 如果使用${}的方式记得加引号
  
* 总结

  * 上面所说的五种参数类型实际上可以分成两种类型，一种是使用**@Param注解**一种是使用**实体类**
  * 就是说不论单个参数或者多个参数，都用注解的方式，如果是实体类那就用实体类属性的方式

## 4.各种SQL操作

* **查询一个实体类对象**

  映射方法：

  ```java
  User getUserById(@Param("id") int id);
  ```

  映射文件：

  ```xml
  <select id="getUserById" resultType="User">
      select * from t_user where id = #{id}
  </select>
  ```

* **查询List集合**

  映射方法：

  ```java
  List<User> getAllUser();
  ```

  映射文件：

  ```xml
  <select id="getAllUser" resultType="User">
      select * from t_user
  </select>
  ```

  <font color="red">注意：当查询的数据为多条时，不能使用实体类作为返回值，否则会抛出异常 TooManyResultsException；但是若查询的数据只有一条，可以使用实体类或集合作为返回值</font>

* **查询单个数据**

  映射方法：

  ```java
  int getCount();
  ```

  映射文件：

  ```xml
  <select id="getCount" resultType="java.lang.Integer">
      select count(id) from t_user
  </select>
  ```

* **查询一条数据到map集合**

  映射方法：

  ```java
  Map<String,Object> getUserToMap(@Param("id") int id);
  ```

  映射文件：

  ```xml
  <select id="getUserToMap" resultType="java.util.Map">
      select * from t_user where id = #{id}
  </select>
  ```

  <font color="red">注意：将一条数据查询到map集合中时，map的键是表中的字段名，map的值是表中数据</font>

* **查询多条数据到map集合**

  * 方式一

    映射方法：

    ```java
    List<Map<String,Object>> getAllUserToMap();
    ```

    映射文件：

    ```xml
    <select id="getAllUserToMap" resultType="java.util.Map">
        select * from t_user
    </select>
    ```

  * 方式二

    映射方法：

    ```java
    @MapKey("id")
    Map<String,Object> getAllUserToMap();
    ```

    映射文件：

    ```xml
    <select id="getAllUserToMap" resultType="java.util.Map">
        select * from t_user
    </select>
    ```

  * <font color="red">注意</font>

    * 方式一中每条查出来的数据都对应一个Map集合，然后再利用List集合将这些Map集合组织起来

    * 方式二中每条查出来的数据都存放在一个Map集合中，但是这个Map集合的键由映射方法上方的@MapKey注解指定，而Map集合的值又是另外一个Map集合，作为值的Map集合中键对应表中字段名，值对应表中数据

    * 方式二范例

      ```xml
      {
      1={password=123456, sex=男, id=1, age=23, username=admin},
      2={password=123456, sex=男, id=2, age=23, username=张三},
      3={password=123456, sex=男, id=3, age=23, username=张三}
      }
      ```
  
* **模糊查询**

  映射方法：

  ```java
  List<User> getUserByLike(@Param("mohu") String mohu);
  ```

  映射文件：

  ```xml
  <select id="getUserByLike" resultType="User">
      <!--方式1-->
      select * from t_user where username like '%${mohu}%'
      <!--方式2-->
      select * from t_user where username like concat("%",#{mohu},"%")
      <!--方式3-->
      select * from t_user where username like "%"#{mohu}"%"
  </select>
  ```

  <font color="red">注意：不能使用`like '%#{mohu}%'`的方式，因为#{}会被解析成?，这个问号会被当成字符串的一部分造成参数获取失败</font>

* **批量删除**

  映射方法：

  ```java
  void deleteSomeUser(@Param("ids") String ids);
  ```

  映射文件：

  ```xml
  <delete id="deleteSomeUser">
      delete from t_user where id in(${ids})
  </delete>
  ```

  <font color="red">注意：这里获取参数的方式是${}，因为#{}会自动添加引号，如果使用#{}的方式会造成SQL语句解析成`delete from t_user where id in('ids')`从而报错</font>

* **动态设置表名**

  映射方法：

  ```java
  List<User> getUserList(@Param("table") String table);
  ```

  映射文件：

  ```xml
  <select id="getUserList" resultType="User">
      select * from ${table}
  </select>
  ```

  <font color="red">注意：这里使用${}是因为使用#{}时会自动添加引号，而表名不允许添加表名</font>

* **执行添加功能时获取自增的主键**

  映射方法：

  ```java
  void insertUser(User user);
  ```

  映射文件：

  ```xml
  <insert id="insertUser" useGeneratedKeys="true" keyProperty="id">
      insert into t_user values(null,#{username},#{password},#{age},#{gender},#{email})
  </insert>
  ```

  测试方法：

  ```java
  @Test
  public void testInsertUser(){
      SqlSession sqlSession = SqlSessionUtil.getSqlSession();
      SpecialSQLMapper mapper = sqlSession.getMapper(SpecialSQLMapper.class);
      User user = new User(null,"李晨","1234567",46,"男","lichen@qq.com");
      mapper.insertUser(user);
      System.out.println(user);//在这一步中打印出的User对象中可以看到自增的id，如果配置文件中不使用useGeneratedKeys和keyProperty，则id仍然是null
  }
  ```

  <font color="red">注意：这里的useGeneratedKeys设置使用自增主键为true，keyProperty是将获取的主键值赋给实体对象中的某个属性。这样，在添加这个实体对象后，自增的主键也能在实体对象中获得，而不需要进行查询</font>

## 5.处理表字段和实体类属性名不一致的情况

* **方式一：给字段名取别名**

  * 如果表中字段名和实体类属性名不一致，可以在SQL语句中给字段名取别名
  * **给字段取得别名必须和实体类属性名一致**

* **方式二：在核心配置文件中配置驼峰映射**

  * 使用前提：表字段符合Mysql命名规范（使用下划线_分割单词），而实体类属性符合驼峰命名规范

  * 使用方式：

    1. 在核心配置文件中使用**&lt;settings&gt;**标签，在该标签下使用**&lt;setting&gt;**子标签来配置
    2. 给子标签**&lt;setting&gt;**设置name属性值为**mapUnderscoreToCamelCase**，value属性值为**true**

  * 范例

    ```xml
    <settings>
        <setting name="mapUnderscoreToCamelCase" value="true" />
    </settings>
    ```

  * 在核心配置文件使用了如上配置后，在SQL语句中可以使用表的字段名而不用考虑表字段名和实体类属性名不一致的情况

* **方式三：在映射配置文件中使用&lt;resultMap&gt;标签自定义映射**

  * &lt;resultMap&gt;标签含有**id**属性和**type**属性，其中id属性是设置当前自定义映射的**标识**，type属性是映射的**实体类**

  * &lt;resultMap&gt;标签下含有的子标签以及功能

    1. &lt;id&gt;标签：设置主键字段的映射关系，使用**column**属性设置映射关系中表的字段名，使用**property**属性设置映射关系中实体类的属性名
    2. &lt;result&gt;标签：设置普通字段的映射关系，使用**column**属性设置映射关系中表的字段名，使用**property**属性设置映射关系中实体类的属性名
    
  * 范例

    ```xml
  <resultMap id="empResultMap" type="Emp">
        <id column="emp_id" property="empId"></id>
        <result column="emp_name" property="empName"></result>
        <result column="age" property="age"></result>
        <result column="gender" property="gender"></result>
    </resultMap>
    
    <select id="getEmpByEmpId" resultType="Emp" resultMap="empResultMap">
        select * from t_emp where emp_id = #{empId}
    </select>
    ```
  
  * <font color="red">注意：SQL语句所在标签中的resultMap属性值必须是自定义映射的id</font>

## 6.多对一映射关系的处理

* **这里多对一是指实体类中某个属性是以表中多个字段为属性构成的实体类**，如员工类的部门属性，部门属性的类型是部门类，这个部门类有部门id，部门名称

* **方式一：使用级联**

  * &lt;resultMap&gt;配置

    ```xml
    <resultMap id="getEmpAndDeptByEmpIdResultMap" type="Emp">
        <id column="emp_id" property="empId"></id>
        <result column="emp_name" property="empName"></result>
        <result column="age" property="age"></result>
        <result column="gender" property="gender"></result>
        <result column="dept_id" property="dept.deptId"></result>
        <result column="dept_name" property="dept.deptName"></result>
    </resultMap>
    
    <select id="getEmpAndDeptByEmpId" resultMap="getEmpAndDeptByEmpIdResultMap">
          select emp_id,emp_name,age,gender,t_dept.dept_id,dept_name
          from t_emp left join t_dept
          on t_emp.dept_id = t_dept.dept_id where emp_id = #{empId}
    </select>
    ```
  
* **方式二：使用&lt;association&gt;标签**

  * &lt;resultMap&gt;配置

    ```xml
    <resultMap id="getEmpAndDeptByEmpIdResultMap" type="Emp">
        <id column="emp_id" property="empId"></id>
        <result column="emp_name" property="empName"></result>
        <result column="age" property="age"></result>
        <result column="gender" property="gender"></result>
        <association property="dept" javaType="Dept">
            <id column="dept_id" property="deptId"></id>
            <result column="dept_name" property="deptName"></result>
        </association>
    </resultMap>
    
    <select id="getEmpAndDeptByEmpId" resultMap="getEmpAndDeptByEmpIdResultMap">
          select emp_id,emp_name,age,gender,t_dept.dept_id,dept_name
        from t_emp left join t_dept
          on t_emp.dept_id = t_dept.dept_id where emp_id = #{empId}
    </select>
    ```
  
  <font color="red">注意：association标签中property属性是指映射实体类中属性的名称，javaType是它的类型，而association标签下的id标签和result标签中的property属性是指javaType指定的类中的属性名称，column属性指表中的字段名</font>
  
* **方式三：使用分步查询**

  * &lt;resultMap&gt;配置

    查询员工信息：

    ```xml
    <resultMap id="getEmpAndDeptByEmpIdResultMap" type="Emp">
        <id column="emp_id" property="empId"></id>
        <result column="emp_name" property="empName"></result>
        <result column="age" property="age"></result>
        <result column="gender" property="gender"></result>
        <association 
                     property="dept"
                     select="com.liaoxiangqian.mapper.DeptMapper.getDeptByDeptId"
                     column="dept_id">
        </association>
    </resultMap>
    
    <select id="getEmpAndDeptByEmpId" resultMap="getEmpAndDeptByEmpIdResultMap">
        select * from t_emp where emp_id = #{empId}
    </select>
    ```

    根据员工的部门id查询部门信息

    ```xml
    <resultMap id="getDeptByDeptIdResultMap" type="Dept">
        <id column="dept_id" property="deptId"></id>
        <result column="dept_name" property="deptName"></result>
    </resultMap>
    
    <select id="getDeptByDeptId" resultMap="getDeptByDeptIdResultMap">
        select * from t_dept where dept_id = #{deptId}
    </select>
    ```

## 7.一对多映射关系的处理

* **这里一对多是指实体类中某个属性是由许多实体类构成的集合**，如部门类中员工属性是一个List集合

* **方式一：使用&lt;collection&gt;标签**

  * &lt;resultMap&gt;配置

    ```xml
    <resultMap id="getDeptAndEmpByDeptIdResultMap" type="Dept">
        <id column="dept_id" property="deptId"></id>
        <result column="dept_name" property="deptName"></result>
        <collection property="emps" ofType="Emp">
            <id column="emp_id" property="empId"></id>
            <result column="emp_name" property="empName"></result>
            <result column="age" property="age"></result>
            <result column="gender" property="gender"></result>
        </collection>
    </resultMap>
    
    <select id="getDeptAndEmpByDeptId" resultMap="getDeptAndEmpByDeptIdResultMap">
        select *
        from t_dept left join t_emp
        on t_dept.dept_id = t_emp.dept_id
        where t_dept.dept_id = #{deptId}
    </select>
    ```

* **方式二：使用分步查询**

  * &lt;resultMap&gt;配置

    查询部门信息

    ```xml
    <resultMap id="getDeptAndEmpByDeptIdResultMap" type="Dept">
        <id column="dept_id" property="deptId"></id>
        <result column="dept_name" property="deptName"></result>
        <collection property="emps" 
                    select="com.liaoxiangqian.mapper.EmpMapper.getEmpByDeptId" 
                    column="dept_id">
        </collection>
    </resultMap>
        
    <select id="getDeptAndEmpByDeptId" resultMap="getDeptAndEmpByDeptIdResultMap">
        select * from t_dept where dept_id = #{deptId}
    </select>
    ```

    根据部门id查询员工信息

    ```xml
    <resultMap id="getEmpByDeptIdResultMap" type="Emp">
        <id column="emp_id" property="empId"></id>
        <result column="emp_name" property="empName"></result>
        <result column="age" property="age"></result>
        <result column="gender" property="gender"></result>
    </resultMap>
    
    <select id="getEmpByDeptId" resultMap="getEmpByDeptIdResultMap">
        select * from t_emp where dept_id = #{deptId}
    </select>
    ```

## 8.分布查询的优点

* 分布查询的优点是可以实现**延迟加载**

* 延迟加载可以避免在分步查询中执行所有的SQL语句，节省资源，实现按需加载

* 需要在核心配置文件中添加如下的配置信息

  ```xml
  <settings>
      <setting name="lazyLoadingEnabled" value="true"/>
      <setting name="aggressiveLazyLoading" value="false"/>
  </settings>
  ```

* lazyLoadingEnabled表示**全局**的延迟加载开关，true表示所有关联对象都会延迟加载，false表示关闭

* aggressiveLazyLoading表示是否加载该对象的所有属性，如果开启则任何方法的调用会加载这个对象的所有属性，如果关闭则是按需加载

* 由于这个配置是在核心配置文件中设定的，所以所有的分步查询都会实现延迟加载，而如果某个查询不需要延迟加载，可以在collection标签或者association标签中的**fetchType**属性设置是否使用延迟加载，属性值**lazy**表示延迟加载，属性值**eager**表示立即加载

## 9.动态SQL

* **if标签**

  * if标签通过**test属性**给出判断的条件，如果条件成立，则将执行标签内的SQL语句

  * 范例

    ```xml
    <select id="getEmpByCondition" resultType="Emp">
        select * from t_emp where
        <if test="empName != null and empName != ''">
            emp_name = #{empName}
        </if>
        <if test="age != null and age != ''">
            and age = #{age}
        </if>
        <if test="gender != null and gender != ''">
            and gender = #{gender}
        </if>
    </select>
    ```

* **where标签**

  * 考虑if标签中的范例出现的一种情况：当第一个if标签条件不成立而第二个条件成立时，拼接成的SQL语句中where后面连着的是and，会造成SQL语句语法错误，而**where标签可以解决这个问题**

  * 范例

    ```xml
    <select id="getEmpByCondition" resultType="Emp">
        select * from t_emp
        <where>
            <if test="empName != null and empName != ''">
                emp_name = #{empName}
            </if>
            <if test="age != null and age != ''">
                and age = #{age}
            </if>
            <if test="gender != null and gender != ''">
                and gender = #{gender}
            </if>
        </where>
    </select>
    ```

  * **where标签**只会在子标签返回任何内容的情况下才插入WHERE子句。而且，若子句的**开头有多余的and或者or，where标签也会将它们去除，但是子句末尾的and或者or不能去除**

* **trim标签**

  * trim标签用于**去掉或添加**标签中的内容

  * trim标签常用属性

    1. prefix：在trim标签中的内容的前面添加某些内容
    2. prefixOverrides：在trim标签中的内容的前面去掉某些内容
    3. suffix：在trim标签中的内容的后面添加某些内容
    4. suffixOverrides：在trim标签中的内容的后面去掉某些内容

  * 用trim实现where标签范例相同的功能

    ```xml
    <select id="getEmpByCondition" resultType="Emp">
        select * from t_emp
        <trim prefix="where" prefixOverrides="and">
            <if test="empName != null and empName != ''">
                emp_name = #{empName}
            </if>
            <if test="age != null and age != ''">
                and age = #{age}
            </if>
            <if test="gender != null and gender != ''">
                and gender = #{gender}
            </if>
        </trim>
    </select>
    ```

* **set标签**

  例如：

  在update语句中使用set更新字段值，不同条件可能更新的参数个数不一样，如果直接通过`<if>`标签连接，可能会出现`,`多余的问题，但是通过**set**标签可以解决该问题

  ```
  像where标签一样，直接将内部判断放在set标签中即可。
  <set>
  	<if test="id!=null">
  		id=#{id},
  	</if>
  	<if test="name!=null">
  		name=#{name}
  	</if>
  </set>
  ```
  
  多余的`,`会去除。

* **choose、when、otherwise标签**

  * 这三个标签是组合使用的，用于在多条件中选择一个条件，类似Java中的if...else if...else...语句

  * 范例

    ```xml
    <select id="getEmpByCondition" resultType="Emp">
        select * from t_emp where gender = #{gender}
        <choose>
            <when test="empName != null and empName != ''">
                and emp_name = #{empName}
            </when>
            <when test="age != null and age != ''">
                and age = #{age}
            </when>
        </choose>
    </select>
    ```

  * 当某个when标签的条件满足时将对应的SQL语句返回，如果都不满足并且有otherwise标签时，才会返回otherwise标签中的SQL语句

* **foreach标签**

  * foreach标签允许指定一个集合或数组，并且对这个集合或数组进行遍历

  * foreach标签可以用的属性有

    1. collection：指定需要遍历的集合或数组
    2. item：当前遍历到的元素
    3. index：当前遍历到的元素的序号
    4. 当遍历的集合是Map类型时，index表示键，item表示值
    5. open：指定遍历开始前添加的字符串
    6. close：指定遍历开始后添加的字符串
    7. separator：指定每次遍历之间的分隔符

  * collection属性值注意事项

    * 如果遍历的是List时，属性值为**list**
    * 如果遍历的是数组时，属性值为**array**
    * 如果遍历的是Map时，属性值可以是**map.keys()**、**map.values()**、**map.entrySet()**
    * 除此之外，还可以在映射方法的参数中使用**@Param()**注解自定义collection属性值

  * 批量添加数据

    ```xml
    <insert id="addMoreEmp">
        insert into t_emp values
        <foreach collection="list" separator="," item="emp">
            (null,#{emp.empName},#{emp.age},#{emp.gender},null)
        </foreach>
    </insert>
    ```

  * 批量删除数据

    ```xml
    <delete id="deleteMoreEmp">
        delete from t_emp where emp_id in
        <foreach collection="array" item="empId" separator="," open="(" close=")">
            #{empId}
        </foreach>
    </delete>
    ```

* **sql标签**

  * 用于记录一段通用的SQL语句片段，在需要用到该SQL语句片段的地方中通过include标签将该SQL语句片段插入

  * sql标签通过**id**属性唯一标识一个SQL语句片段，include标签通过**refid**属性指定使用某个SQL片段

  * 范例

    ```xml
    <sql id="item">
        emp_id,emp_name,age,gender,dept_id
    </sql>
    <select id="getEmpByEmpId" resultType="Emp">
    	select <include refid="item"></include>
        from t_emp
        where emp_id = #{empId}
    </select>
    ```

# 四.核心配置文件

## 1.文件结构

* 核心配置文件命名建议是**mybatis-config.xml**，无强制要求

* 核心配置文件主要用于**配置连接数据库的环境**以及**MyBatis的全局配置信息**

* 核心配置文件存放的位置是maven工程下的src/main/resources目录下

* 简易结构如下，核心配置文件的标签不止这几个

  ```xml
  <?xml version="1.0" encoding="UTF-8" ?>
  <!--DTD约束-->
  <!DOCTYPE configuration
          PUBLIC "-//mybatis.org//DTD Config 3.0//EN"
          "http://mybatis.org/dtd/mybatis-3-config.dtd">
  <configuration>
      <!--
          1.environments配置数据库的环境，环境可以有多个
          2.default属性指定使用的环境
      -->
      <environments default="development">
          <!--
              1.environment配置具体某个数据库的环境
              2.id属性唯一标识这个环境
          -->
          <environment id="development">
              <!--
                  1.transactionManager设置事务管理方式
                  2.type属性取值有“JDBC|MANAGED”
                  3.JDBC指当前环境中使用的是JDBC中原生的事务管理方式，事务的提交或回滚需要手动处理
                  4.MANAGED指被管理，例如Spring中
              -->
              <transactionManager type="JDBC"/>
              <!--
                  1.dataSource配置数据源
                  2.取值有"POOLED|UNPOOLED|JNDI"
                  3.POOLED表示使用数据库连接池缓存数据库连接
                  4.UNPOOLED：表示不使用数据库连接池
                  5.JNDI表示使用上下文中的数据源
              -->
              <dataSource type="POOLED">
                  <!--设置链接数据库的驱动-->
                  <property name="driver" value="com.mysql.jdbc.Driver"/>
                  <!--设置连接数据库的地址-->
                  <property name="url" value="jdbc:mysql://localhost:3306/ssm"/>
                  <!--设置连接数据库的用户名-->
                  <property name="username" value="root"/>
                  <!--设置连接数据库的密码-->
                  <property name="password" value="lxq"/>
              </dataSource>
          </environment>
      </environments>
      <!--mappers用于引入映射的配置文件-->
      <mappers>
          <!--mapper用于指定某个映射文件，resource属性指定文件路径-->
          <mapper resource="mappers/UserMapper.xml"/>
      </mappers>
  </configuration>
  ```

## 2.核心配置文件详解

### (1)标签顺序

* 核心配置文件中configuration标签下的子标签要按照一定的顺序书写
* properties => settings => typeAliases => typeHandlers => objectFactory => objectWrapperFactory => reflectorFactory =>  plugins => environments => databaseIdProvider => mappers

### (2)标签详解

* &lt;properties&gt;标签

  * 用于引入某个properties配置文件，是一个单标签

  * resource属性指定配置文件

  * 范例

    ```xml
    <properties resource="jdbc.properties" />
    ```

* &lt;typeAliases&gt;标签

  * 用于为某个类的全类名设置别名，子标签是&lt;typeAlias&gt;

  * 一个子标签对应设置一个类的别名

  * 子标签下有type和alias两个属性，type指定需要设置别名的类的全类名，alias指定别名

  * 如果只设置了type属性，那么默认的别名就是它的类名（不是全类名）而且不区分大小写

  * 如果想要设置某个包下所有类的别名，可以使用&lt;package&gt;标签，用name属性指定包名

  * 范例

    ```xml
    <typeAliases>
        <typeAlias type="com.lxq.pojo.User" alias="User"></typeAlias>
        <package name="com.lxq.pojo"></package>
    </typeAliases>
    ```
    
  * MyBatis中内建了一些类型的别名，常见的有

    | Java类型 | 别名            |
    | -------- | --------------- |
    | int      | \_int或_integer |
    | Integer  | int或integer    |
    | String   | string          |
    | List     | list            |
    | Map      | map             |

* &lt;property&gt;标签

  * 用于配置连接数据库时用到的各种属性,是一个单标签

  * 该标签有两个属性，一个是name指定属性名，另一个是value指定属性值

  * 如果不使用&lt;properties&gt;标签引入相关配置文件时，使用方式如下

    ```xml
    <property name="driver" value="com.mysql.jdbc.Driver" />
    ```

  * 如果使用&lt;properties&gt;标签引入相关的配置文件时，value属性可以写成如下形式

    ```xml
    <property name="driver" value="${jdbc.driver}" />
    ```

    其中配置文件的内容是

    ```xml
    jdbc.driver=com.mysql.jdbc.Driver
    ```

    <font color="red">注意：这里使用jdbc.driver来给键命名是因为核心配置文件中可能会引入其他的配置文件，如果使用driver来命名键的话有可能会跟其他配置文件中的键同名而产生冲突</font>

* &lt;mappers&gt;标签

  * 该标签用于引入映射文件

  * 每个映射文件使用子标签&lt;mapper&gt;来表示，该子标签是一个单标签

  * 子标签&lt;mapper&gt;使用属性resource来指定需要引入的映射文件

  * 如果想要将某个包下所有的映射文件都引入，可以使用&lt;package&gt;标签，使用name属性来指定需要引入的包

  * 范例

    ```xml
    <mappers>
        <mapper resource="mappers/UserMapper.xml" />
        <package name="com.lxq.mapper" />
    </mappers>
    ```

    <font color="red">注意：使用包的形式引入映射文件需要满足两个条件，1.mapper接口所在的包和映射文件所在的包要一致；2.mapper接口名和映射文件名要相同</font>

# 五.相关API

## 1.Resources

* Resources类由MyBatis提供用于获取来自核心配置文件的输入流
* 相关方法是：`InputStream getResourceAsStream(String filepath)`，注意这是一个静态方法

## 2.SqlSessionFactoryBuilder

* SqlSessionFactoryBuilder类由MyBatis提供用于获取SqlSessionFactory的实例对象
* 相关方法是：`SqlSessionFactory build(InputStream is)`，该方法通过一个输入流返回了SqlSessionFactory对象

## 3.SqlSessionFactory

* SqlSessionFactory类由MyBatis提供用于获取SqlSession对象，每个基于MyBatis的应用都是以一个SqlSessionFactory的实例为核心的
* 相关方法：`SqlSession openSession()`和`SqlSession openSession(boolean autoCommit)`，这两个方法都用于获取SqlSession对象，如果使用有参数的可以指定**是否自动提交事务**，没有指定参数的默认是不自动提交事务

## 4.SqlSession

* SqlSession类由MyBatis提供用于执行SQL、管理事务、接口代理

* 常用方法

  | 方法                               | 说明                     |
  | ---------------------------------- | ------------------------ |
  | void commit()                      | 提交事务                 |
  | void rollback()                    | 回滚事务                 |
  | T getMapper(Class&lt;T&gt; aClass) | 获取指定接口的代理实现类 |
  | void close()                       | 释放资源                 |

* 除了以上常用方法外，SqlSession还有很多有关数据库增删改查的方法，但是这些方法繁琐而且不符合类型安全，所以使用getMapper()方法来获取一个Mapper接口的代理实现类来执行映射语句是个比较方便的做法

## 5.最佳实践

* **SqlSessionFactoryBuilder**

  ​		这个类可以被实例化、使用和丢弃，一旦创建了 SqlSessionFactory，就不再需要它了。因此 SqlSessionFactoryBuilder 实例的最佳范围是**方法范围（**也就是局部方法变量）。你可以重用 SqlSessionFactoryBuilder 来创建多个 SqlSessionFactory 实例，但是最好还是不要让其一直存在以保证所有的 XML 解析资源开放给更重要的事情

* **SqlSessionFactory**

  ​		SqlSessionFactory 一旦被创建就应该在应用的运行期间一直存在，没有任何理由对它进行清除或重建。使用 SqlSessionFactory 的最佳实践是在应用运行期间不要重复创建多次，多次重建 SqlSessionFactory 被视为一种代码“坏味道（bad smell）”。因此 　SqlSessionFactory 的最佳范围是**应用范围**。有很多方法可以做到，最简单的就是使用单例模式或者静态单例模式

* **SqlSession**

   ​		每个线程都应该有它自己的 SqlSession 实例。SqlSession 的实例不是线程安全的，因此是不能被共享的，所以它的最佳的范围是**请求或方法范围**。绝对不能将 SqlSession 实例的引用放在一个类的静态域，甚至一个类的实例变量也不行。也绝不能将 SqlSession 实例的引用放在任何类型的管理范围中，比如 Serlvet 架构中的 HttpSession。如果你现在正在使用一种 Web 框架，要考虑 SqlSession 放在一个和 HTTP 请求对象相似的范围中。换句话说，每次收到的 HTTP 请求，就可以打开一个 SqlSession，返回一个响应，就关闭它。这个关闭操作是很重要的，你应该把这个关闭操作放到 finally 块中以确保每次都能执行关闭
   
* 工具类

   ```java
   public class SqlSessionUtil {
   
       private static SqlSessionFactory sqlSessionFactory;
   
       static{
           try {
               InputStream is = Resources.getResourceAsStream("mybatis-config.xml");
               SqlSessionFactoryBuilder sqlSessionFactoryBuilder = new SqlSessionFactoryBuilder();
               sqlSessionFactory = sqlSessionFactoryBuilder.build(is);
           } catch (IOException e) {
               e.printStackTrace();
           }
       }
   
       public static SqlSession getSqlSession(){
           return sqlSessionFactory.openSession(true);
       }
   }
   
   ```

# 六.缓存

## 1.一级缓存

* 一级缓存是**SqlSession级别**的，通过同一个SqlSession查询的数据会被缓存，下次查询相同的数据，就会从缓存中直接获取，不会从数据库重新访问，一级缓存是默认开启的，不能被关闭，可以清空。
* 一级缓存失效的四种情况：
  * 使用另一个SqlSession
  * 同一个SqlSession但是查询条件不同
  * 同一个SqlSession但是两次查询中间执行了任何一次增删改操作
  * 同一个SqlSession但是两次查询中间手动清空了缓存，手动清空缓存的方法是调用SqlSession的`clearCache()`方法

## 2.二级缓存

* 二级缓存是**SqlSessionFactory级别**，通过同一个SqlSessionFactory创建的SqlSession查询的结果会被缓存，此后若再次执行相同的查询语句，结果就会从缓存中获取
* 二级缓存开启的条件：
  * 在核心配置文件中，设置全局配置属性cacheEnabled="true"，默认为true，不需要设置
  * 在映射文件中设置标签&lt;cache/&gt;
  * 二级缓存必须在SqlSession关闭或提交之后有效
  * 查询的数据所转换的实体类类型必须实现序列化的接口
* 二级缓存失效的情况：**两次查询之间执行了任意的增删改，会使一级和二级缓存同时失效**
* &lt;cache/&gt;可以设置的一些属性：
  * eviction属性：缓存回收策略，默认的是 LRU
    1. LRU（Least Recently Used） – 最近最少使用的：移除最长时间不被使用的对象
    2. FIFO（First in First out） – 先进先出：按对象进入缓存的顺序来移除它们
    3. SOFT – 软引用：移除基于垃圾回收器状态和软引用规则的对象
    4. WEAK – 弱引用：更积极地移除基于垃圾收集器状态和弱引用规则的对象
  * flushInterval属性：刷新间隔，单位是毫秒，默认情况下不设置也就是没有刷新间隔，缓存仅仅调用语句时刷新
  * size属性：引用数目，正整数代表缓存最多可以存储多少个对象，太大容易导致内存溢出
  * readOnly属性：只读， 取值是true/false
    1. true：只读缓存，会给所有调用者返回**缓存对象的相同实例**，因此这些对象不能被修改，这提供了很重要的性能优势
    2. false：读写缓存，会返回**缓存对象的拷贝**（通过序列化），这会慢一些，但是安全，因此**默认是false**

## 3.缓存的查询顺序

* 先查询二级缓存，因为二级缓存中可能会有其他程序已经查出来的数据，可以拿来直接使用
* 如果二级缓存没有命中，再查询一级缓存
* 如果一级缓存也没有命中，则查询数据库
* 注意SqlSession关闭之后，一级缓存中的数据才会写入二级缓存