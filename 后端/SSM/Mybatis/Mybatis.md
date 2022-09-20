### 第一章 初识Mybatis

#### 1.1 框架概述

- #### 生活中“框架”

  - 买房子
  - 笔记本电脑

- 程序中框架【代码半成品】

  - Mybatis框架：持久化层框架【dao层】
  - SpringMVC框架：控制层框架【Servlet层】
  - Spring框架：全能...

#### 1.2 Mybatis简介

- Mybatis是一个**半自动化**持久化层**ORM**框架
- ORM：Object Relational Mapping【对象  关系  映射】
  - 将Java中的**对象**与数据库中**表**建议**映射关系**，优势：操作Java中的对象，就可以影响数据库中表的数据

- Mybatis与Hibernate对比
  - Mybatis是一个半自动化【需要手写SQL】
  - Hibernate是全自动化【无需手写SQL】

- Mybatis与JDBC对比
  - JDBC中的SQL与Java代码耦合度高
  - Mybatis将SQL与Java代码解耦
- Java POJO（Plain Old Java Objects，普通老式 Java 对象）
  - JavaBean  等同于  POJO

#### 1.3 官网地址

- 文档地址：https://mybatis.org/mybatis-3/
- 源码地址：https://github.com/mybatis/mybatis-3

### 第二章 搭建Mybatis框架

> 导入jar包
>
> 编写配置文件
>
> 使用核心类库

#### 2.1 准备

- 建库建表建约束
- 准备maven工程

#### 2.2 搭建Mybatis框架步骤

1. 导入jar包

   ```xml
   <!--导入MySQL的驱动包-->
   <dependency>
       <groupId>mysql</groupId>
       <artifactId>mysql-connector-java</artifactId>
       <version>5.1.37</version>
   </dependency>
   <!-- https://mvnrepository.com/artifact/mysql/mysql-connector-java -->
   <dependency>
       <groupId>mysql</groupId>
       <artifactId>mysql-connector-java</artifactId>
       <version>8.0.26</version>
   </dependency>
   
   <!--导入MyBatis的jar包-->
   <dependency>
       <groupId>org.mybatis</groupId>
       <artifactId>mybatis</artifactId>
       <version>3.5.6</version>
   </dependency>
   <!--junit-->
   <dependency>
       <groupId>junit</groupId>
       <artifactId>junit</artifactId>
       <version>4.12</version>
       <scope>test</scope>
   </dependency>
   ```

2. 编写**核心配置文件**【mybatis-config.xml】

   - 位置：resources目标下

   - 名称：推荐使用mybatis-config.xml

   - 示例代码

     ```xml
     <?xml version="1.0" encoding="UTF-8" ?>
     <!DOCTYPE configuration
             PUBLIC "-//mybatis.org//DTD Config 3.0//EN"
             "http://mybatis.org/dtd/mybatis-3-config.dtd">
     
     <configuration>
         <environments default="development">
             <environment id="development">
                 <transactionManager type="JDBC"/>
                 <dataSource type="POOLED">
     <!--                mysql8版本-->
     <!--                <property name="driver" value="com.mysql.cj.jdbc.Driver"/>-->
     <!--                <property name="url" value="jdbc:mysql://localhost:3306/db220106?serverTimezone=UTC"/>-->
     <!--                mysql5版本-->
                     <property name="driver" value="com.mysql.jdbc.Driver"/>
                     <property name="url" value="jdbc:mysql://localhost:3306/db220106"/>
                     <property name="username" value="root"/>
                     <property name="password" value="root"/>
                 </dataSource>
             </environment>
         </environments>
         <!--    设置映射文件路径-->
         <mappers>
             <mapper resource="mapper/EmployeeMapper.xml"/>
         </mappers>
     </configuration>
     ```

3. 书写相关接口及**映射文件**

   - 映射文件位置：resources/mapper

   - 映射文件名称：XXXMapper.xml

   - **映射文件作用：主要作用为Mapper接口书写Sql语句**

     - 映射文件名与接口名一致
     - 映射文件namespace与接口全类名一致
     - 映射文件SQL的Id与接口的方法名一致

   - 示例代码

     ```xml
     <?xml version="1.0" encoding="UTF-8" ?>
     <!DOCTYPE mapper
             PUBLIC "-//mybatis.org//DTD Mapper 3.0//EN"
             "http://mybatis.org/dtd/mybatis-3-mapper.dtd">
     <mapper namespace="com.atguigu.mybatis.mapper.EmployeeMapper">
         <select id="selectEmpById" resultType="com.atguigu.mybatis.pojo.Employee">
             SELECT
                 id,
                 last_name,
                 email,
                 salary
             FROM
                 tbl_employee
             WHERE
                 id=#{empId}
         </select>
     </mapper>
     ```

4. 测试【SqlSession】

   - 先获取SqlSessionFactory对象
   - 再获取SqlSession对象
   - 通过SqlSession对象获取XXXMapper代理对象
   - 测试

#### 2.3 添加Log4j日志框架

- 导入jar包

  ```xml
  <!-- log4j -->
  <dependency>
      <groupId>log4j</groupId>
      <artifactId>log4j</artifactId>
      <version>1.2.17</version>
  </dependency>
  ```

- 编写配置文件

  - 配置文件名称：log4j.xml

  - 配置文件位置：resources

  - 示例代码

    ```xml
    <?xml version="1.0" encoding="UTF-8" ?>
    <!DOCTYPE log4j:configuration SYSTEM "log4j.dtd">
    
    <log4j:configuration xmlns:log4j="http://jakarta.apache.org/log4j/">
    
        <appender name="STDOUT" class="org.apache.log4j.ConsoleAppender">
            <param name="Encoding" value="UTF-8" />
            <layout class="org.apache.log4j.PatternLayout">
                <param name="ConversionPattern" value="%-5p %d{MM-dd HH:mm:ss,SSS} %m  (%F:%L) \n" />
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



### 第三章 Mybatis核心配置详解【mybatis-config.xml】

#### 3.1 核心配置文件概述

- MyBatis 的配置文件包含了会深深影响 MyBatis 行为的设置和属性信息。

#### 3.2 核心配置文件根标签

- 没有实际语义，主要作用：所有子标签均需要设置在跟标签内部

#### 3.3 核心配置文件常用子标签

- properties子标签

  - 作用：定义或引入外部属性文件

  - 示例代码

    ```properties
    #key=value
    db.driver=com.mysql.jdbc.Driver
    db.url=jdbc:mysql://localhost:3306/db220106
    db.username=root
    db.password=root
    ```

    ```xml
    <properties resource="db.properties"></properties>
    
    <environments default="development">
            <environment id="development">
                <transactionManager type="JDBC"/>
                <dataSource type="POOLED">
    <!--                mysql8版本-->
    <!--                <property name="driver" value="com.mysql.cj.jdbc.Driver"/>-->
    <!--                <property name="url" value="jdbc:mysql://localhost:3306/db220106?serverTimezone=UTC"/>-->
    <!--                mysql5版本-->
                    <property name="driver" value="${db.driver}"/>
                    <property name="url" value="${db.url}"/>
                    <property name="username" value="${db.username}"/>
                    <property name="password" value="${db.password}"/>
                </dataSource>
            </environment>
        </environments>
    ```

- settings子标签

  - 作用：这是 MyBatis 中极为重要的调整设置，它们会改变 MyBatis 的运行时行为。 

  - **mapUnderscoreToCamelCase**属性：是否开启驼峰命名自动映射，默认值false，如设置true会自动将

    字段a_col与aCol属性自动映射

    - **注意：只能将字母相同的字段与属性自动映射**

- 类型别名（typeAliases）

  - 作用：类型别名可为 Java 类型设置一个缩写名字。

  - 语法及特点

    ```xml
    <typeAliases>
    <!--        为指定类型定义别名-->
    <!--        <typeAlias type="com.atguigu.mybatis.pojo.Employee" alias="employee"></typeAlias>-->
    <!--        为指定包下所有的类定义别名
                    默认将类名作为别名，不区分大小写【推荐使用小写字母】
    -->
            <package name="com.atguigu.mybatis.pojo"/>
        </typeAliases>
    ```

  - Mybatis自定义别名

    | 别名            | 类型      |
    | --------------- | --------- |
    | _int            | int       |
    | integer或int    | Integer   |
    | string          | String    |
    | list或arraylist | ArrayList |
    | map或hashmap    | HashMap   |

    

- 环境配置（environments）

  - 作用：设置数据库连接环境

  - 示例代码

    ```xml
    <!--    设置数据库连接环境-->
        <environments default="development">
            <environment id="development">
                <transactionManager type="JDBC"/>
                <dataSource type="POOLED">
    <!--                mysql8版本-->
    <!--                <property name="driver" value="com.mysql.cj.jdbc.Driver"/>-->
    <!--                <property name="url" value="jdbc:mysql://localhost:3306/db220106?serverTimezone=UTC"/>-->
    <!--                mysql5版本-->
                    <property name="driver" value="${db.driver}"/>
                    <property name="url" value="${db.url}"/>
                    <property name="username" value="${db.username}"/>
                    <property name="password" value="${db.password}"/>
                </dataSource>
            </environment>
        </environments>
    ```

- mappers子标签

  - 作用：设置映射文件路径

  - 示例代码

    ```xml
    <!--    设置映射文件路径-->
        <mappers>
            <mapper resource="mapper/EmployeeMapper.xml"/>
            <!-- 要求：接口的包名与映射文件的包名需要一致-->
    <!--        <package name="com.atguigu.mybatis.mapper"/>-->
        </mappers>
    ```

- 注意：核心配置中的子标签，是有顺序要求的。

  ![image-20220321153852708](02_Mybatis.assets\image-20220321153852708.png)

### 第四章 Mybatis映射文件详解

#### 4.1 映射文件概述

- MyBatis 的真正强大在于它的语句映射，这是它的魔力所在。
- 如果拿它跟具有相同功能的 JDBC 代码进行对比，你会立即发现省掉了将近 **95%** 的代码。

#### 4.2 映射文件根标签

- mapper标签
- mapper中的namespace要求与接口的全类名一致

#### 4.3 映射文件子标签

> 子标签共有9个，注意学习其中8大子标签

- insert标签：定义添加SQL
- delete标签：定义删除SQL
- update标签：定义修改SQL
- select标签：定义查询SQL
- sql标签：定义可重用的SQL语句块
- cache标签：设置当前命名空间的缓存配置
- cache-ref标签：设置其他命名空间的缓存配置
- **resultMap标签：**描述如何从数据库结果集中加载对象
  - resultType解决不了的问题，交个resultMap。

#### 4.4 映射文件中常用属性

- resultType：设置期望结果集返回类型【全类名或别名】
  - 注意：如果返回的是集合，那应该设置为**集合包含的类型**，而不是集合本身的类型。 
  - resultType 和 resultMap 之间只能同时使用一个。

### day03

#### 4.5 获取主键自增数据

- useGeneratedKeys：启用主键生成策略
- keyProperty：设置存储属性值

#### 4.6 获取数据库受影响行数

- 直接将接口中方法的返回值设置为int或boolean即可
  - int：代表受影响行数
  - boolean
    - true：表示对数据库有影响
    - false：表示对数据库无影响

### 第五章 Mybatis中参数传递问题

#### 5.1 单个普通参数

- 可以任意使用：参数数据类型、参数名称不用考虑

#### 5.2 多个普通参数

- Mybatis底层封装Map结构，封装key为param1、param2....【支持：arg0、arg1、...】

  但是封装的的名字param1...

#### 5.3 命名参数

- 语法：

  - @Param(value="参数名")
  - @Param("参数名")

- 位置：参数前面

- 注意：

  - 底层封装Map结构
  - 命名参数，依然支持参数【param1,param2,...】

- 示例代码

  ```java
  /**
   * 通过员工姓名及薪资查询员工信息【命名参数】
   * @return
   */
  public List<Employee> selectEmpByNamed(@Param("lName")String lastName,
                                         @Param("salary") double salary);
  ```

  ```xml
  <select id="selectEmpByNamed" resultType="employee">
      SELECT
          id,
          last_name,
          email,
          salary
      FROM
          tbl_employee
      WHERE
          last_name=#{param1}
      AND
          salary=#{param2}
  </select>
  ```

- 源码分析

  - MapperMethod对象：142行代码【命名参数底层代码入口】

  - **命名参数底层封装map为ParamMap，ParamMap继承HashMap**

  - ParamNameResolver对象：130行代码，命名参数底层实现逻辑

    ```java
    //130行
    final Map<String, Object> param = new ParamMap<>();
    int i = 0;
    for (Map.Entry<Integer, String> entry : names.entrySet()) {
      param.put(entry.getValue(), args[entry.getKey()]);
      // add generic param names (param1, param2, ...)
      final String genericParamName = GENERIC_NAME_PREFIX + (i + 1);
      // ensure not to overwrite parameter named with @Param
      if (!names.containsValue(genericParamName)) {
        param.put(genericParamName, args[entry.getKey()]);
      }
      i++;
    }
    return param;
    ```

#### 5.4 POJO参数

- Mybatis支持POJO【JavaBean】入参，参数key是POJO中属性

  将该java对象作为参数传入。在xml文件中直接使用属性。

#### 5.5 Map参数

- Mybatis支持直接Map入参，map的key=参数key

参数为Map类型，Map<String,Object>,使用时sql语句中可以直接调用。

#### 5.6 Collection|List|Array等参数

- 参数名：collection、list、array

### 第六章 Mybatis参数传递【#与$区别】

#### 6.1 回顾JDBC

- DriverManager
- Connection
- **Statement**：执行SQL语句，入参使用SQL【String】拼接方式
- **PreparedStatement**执行SQL语句【预编译SQL】，入参使用占位符方式
- ResultSet

#### 6.2 #与$区别

- 【#】底层执行SQL语句的对象，使用**PreparedStatementd**，预编译SQL，防止SQL注入安全隐患，相对比较安全。
- 【$】底层执行SQL语句的对象使用**Statement**对象，未解决SQL注入安全隐患，相对不安全。

#### 6.3 #与$使用场景

> 查询SQL：select col,col2 from table1 where col=? and col2=?  group by ?, order by ?  limit ?,?

- #使用场景，sql占位符位置均可以使用#

- $使用场景，#解决不了的参数传递问题，均可以交给$处理【如：form 动态化表名】

  ```java
  /**
   * 测试$使用场景
   */
  public List<Employee> selectEmpByDynamitTable(@Param("tblName") String tblName);
  ```

  ```xml
  <select id="selectEmpByDynamitTable" resultType="employee">
      SELECT
          id,
          last_name,
          email,
          salary
      FROM
          ${tblName}
  </select>
  ```

### 第七章 Mybatis查询中返回值四种情况

#### 7.1 查询单行数据返回单个对象

```java
/**
 * 通过id获取员工信息
 */
public Employee selectEmpById(int empId);
```

```xml
<select id="selectEmpById" resultType="employee">
    SELECT
        id,
        last_name,
        email,
        salary
    FROM
        tbl_employee
    WHERE
        id=#{empId}
</select>

//要保证类名和类的属性相对应，且顺序相对应。类的属性名称可以不一样(不妨碍构造函数)

```

#### 7.2 查询多行数据返回对象的集合

```java
/**
 * 查询所有员工信息
 */
public List<Employee> selectAllEmps();
```

```xml
<select id="selectAllEmps" resultType="employee">
    SELECT
        id,
        last_name,
        email,
        salary
    FROM
        tbl_employee
</select>
```

- 注意：如果返回的是集合，那应该设置为**集合包含的类型**，而不是集合本身的类型。 

#### 7.3 查询单行数据返回Map集合

- Map<String key,Object value>

  - 字段作为Map的key，查询结果作为Map的Value

  > key是指对应的列的名称，value指对应的值。（最终结果存放在一个Map中，有点类似js的对象）
  >
  > 将单行数据存放在一个Map中。
  >
  > 相比之下，这种方法不用注意列名与属性的对应关系，更简便。(如果数据没有封装到Pojo中)

- 示例代码

  ```java
  /**
   * 查询单行数据返回Map集合
   * @return
   */
  public Map<String,Object> selectEmpReturnMap(int empId);
  ```

  ```xml
  <!--    查询单行数据返回Map集合-->
  <select id="selectEmpReturnMap" resultType="map">
      SELECT
          id,
          last_name,
          email,
          salary
      FROM
      	tbl_employee
      WHERE
      	id=#{empId}
  </select>
  ```

#### 7.4 查询多行数据返回Map集合

- Map<Integer key,Employee value>

  - 对象的id作为key

  - 对象作为value

    > 需要通过注解指定每一个结果对象的key
    >
    > @MapKey("指定属性")
    >
    > 方便JSON转换的Map更适用。
    >
    > 返回的每一行数据封装为一个对象。
    >
    > 

- 示例代码

  ```java
  /**
   * 查询多行数据返回Map
   * Map<Integer,Object>
   * Map<Integer,Employee>
   *      对象Id作为：key
   *      对象作为：value
   * @return
   */
  @MapKey("id")
  public Map<Integer,Employee> selectEmpsReturnMap();
  ```

  ```xml
  <select id="selectEmpsReturnMap" resultType="map">
      SELECT
          id,
          last_name,
          email,
          salary
      FROM
          tbl_employee
  </select>
  ```

### 第八章 Mybatis中自动映射与自定义映射

> 自动映射【resultType】
>
> 自定义映射【resultMap】

#### 8.1 自动映射与自定义映射

- 自动映射【resultType】：指的是自动将表中的字段与类中的属性进行关联映射
  - 一般使用自动映射，可以是全类名（别名或者带包名）或者map(别名或全类名)；
  - 自动映射解决不了两类问题	
    - **多表连接查询时，需要返回多张表的结果集**
    - 单表查询时，不支持驼峰式自动映射【不想为字段定义别名】

- 自定义映射【resultMap】：自动映射解决不了问题，交给自定义映射
- 注意：resultType与resultMap只能同时使用一个

#### 8.2 自定义映射-级联映射

```xml
<!--    自定义映射 【员工与部门关系】-->
<resultMap id="empAndDeptResultMap" type="employee">
    <!--  定义主键字段与属性关联关系 -->
    <id column="id" property="id"></id>
    <!--  定义非主键字段与属性关联关系-->
    <result column="last_name" property="lastName"></result>
    <result column="email" property="email"></result>
    <result column="salary" property="salary"></result>
    <!--        为员工中所属部门，自定义关联关系-->
    <result column="dept_id" property="dept.deptId"></result>
    <result column="dept_name" property="dept.deptName"></result>
</resultMap>
<select id="selectEmpAndDeptByEmpId" resultMap="empAndDeptResultMap">
   SELECT
        e.`id`,
        e.`email`,
        e.`last_name`,
        e.`salary`,
        d.`dept_id`,
        d.`dept_name`
    FROM
        tbl_employee e,
        tbl_dept d
    WHERE
        e.`dept_id` = d.`dept_id`
    AND
        e.`id` = #{empId}
</select>
```

#### 8.3 自定义映射-association映射

- 特点：解决一对一映射关系【多对一】

- 示例代码

  - ```xml
    <!--    自定义映射 【员工与部门关系】-->
    <resultMap id="empAndDeptResultMapAssociation" type="employee">
        <!--  定义主键字段与属性关联关系 -->
        <id column="id" property="id"></id>
        <!--  定义非主键字段与属性关联关系-->
        <result column="last_name" property="lastName"></result>
        <result column="email" property="email"></result>
        <result column="salary" property="salary"></result>
        <!--        为员工中所属部门，自定义关联关系-->
        <association property="dept"
                    javaType="com.atguigu.mybatis.pojo.Dept">
            <id column="dept_id" property="deptId"></id>
            <result column="dept_name" property="deptName"></result>
        </association>
    </resultMap>
    ```

#### 8.4 自定义映射-collection映射

- 示例代码

  ```java
  /**
   * 通过部门id获取部门信息，及部门所属员工信息
   */
  public Dept selectDeptAndEmpByDeptId(int deptId);
  ```

  ```xml
  <resultMap id="deptAndempResultMap" type="dept">
      <id property="deptId" column="dept_id"></id>
      <result property="deptName" column="dept_name"></result>
      <collection property="empList"
                  ofType="com.atguigu.mybatis.pojo.Employee">
          <id column="id" property="id"></id>
          <result column="last_name" property="lastName"></result>
          <result column="email" property="email"></result>
          <result column="salary" property="salary"></result>
      </collection>
  </resultMap>
  <select id="selectDeptAndEmpByDeptId" resultMap="deptAndempResultMap">
      SELECT
          e.`id`,
          e.`email`,
          e.`last_name`,
          e.`salary`,
          d.`dept_id`,
          d.`dept_name`
      FROM
          tbl_employee e,
          tbl_dept d
      WHERE
          e.`dept_id` = d.`dept_id`
      AND
          d.dept_id = #{deptId}
  </select>
  ```

#### 8.5 ResultMap相关标签及属性

- resultMap标签：自定义映射标签
  - id属性：定义唯一标识
  - type属性：设置映射类型

- resultMap子标签
  - id标签：定义主键字段与属性关联关系
  - result标签：定义非主键字段与属性关联关系
    - column属性：定义表中字段名称
    - property属性：定义类中属性名称
  - **association标签**：定义一对一的关联关系
    - property：定义关联关系属性
    - javaType：定义关联关系属性的类型
    - select：设置分步查询SQL全路径
    - colunm：设置分步查询SQL中需要参数
    - fetchType：设置局部延迟加载【懒加载】是否开启
  - **collection标签**：定义一对多的关联关系
    - property：定义一对一关联关系属性
    - ofType：定义一对一关联关系属性类型
    - fetchType：设置局部延迟加载【懒加载】是否开启

#### 8.6 Mybatis中分步查询

- 为什么使用分步查询【分步查询优势】？
  - 将多表连接查询，改为【分步单表查询】，从而提高程序运行效率

    > 关联另一个mapper中的方法，映射结果
    >
    > ```
    >  <resultMap>
    >  <id property=""></id>
    >  <result property="",column=""></result>
    >  
    >  //将column为“dept_id"的值作为参数执行第二条sql
    >  <association property="dept"
    >  				select="第二条sql的接口"
    >  				column="dept_id"
    >  ></association>
    >  
    >  </resultMap> 
    > ```
    >
    > 
  
- 示例代码

  - 一对一

    ```java
    /**
     * 通过员工id获取员工信息及员工所属的部门信息【分步查询】
            1. 先通过员工id获取员工信息【id、last_name、email、salary、dept_id】
            2. 再通过部门id获取部门信息【dept_id、dept_name】
     */
    public Employee selectEmpAndDeptByEmpIdAssociationStep(int empId);
    ```

    ```xml
    <select id="selectEmpAndDeptByEmpIdAssociationStep" resultMap="empAndDeptResultMapAssocationStep">
        select
            id,
            last_name,
            email,
            salary,
            dept_id
        from
            tbl_employee
        where
            id=#{empId}
    </select>
    ```

    ```java
    /**
     * 通过部门id获取部门信息
     */
    public Dept selectDeptByDeptId(int deptId);
    ```

    ```xml
    <select id="selectDeptByDeptId" resultType="dept">
        select
            dept_id,
            dept_name
        from
            tbl_dept
        where
            dept_id=#{deptId}
    </select>
    ```

- 一对多

  当有多条结果时，使用list。
  
  > ```
  > 当映射结果是一个集合时，用collection
  > <collection ofType="对应的实体类" property="属性名" >
  > 	内部为一对一的一映射关系。
  > </collection>
  > ```

  ```java
  /**
   * 通过部门id获取部门信息，及部门所属员工信息【分步查询】
          1. 通过部门id获取部门信息
          2. 通过部门id获取员工信息
   */
  public Dept selectDeptAndEmpByDeptIdStep(int deptId);
  ```
  
  ```xml
  <!--    通过部门id获取部门信息，及部门所属员工信息【分步查询】-->
  <!--    1. 通过部门id获取部门信息-->
  <!--    2. 通过部门id获取员工信息-->
      <select id="selectDeptAndEmpByDeptIdStep" resultMap="deptAndEmpResultMapStep">
          select
              dept_id,
              dept_name
          from
              tbl_dept
          where
              dept_id=#{deptId}
      </select>
  ```

  ```java
  /**
   * 通过部门Id获取员工信息
   * @param deptId
   * @return
   */
  public List<Employee> selectEmpByDeptId(int deptId);
  ```
  
  ```xml
  <select id="selectEmpByDeptId" resultType="employee">
      select
          id,
          last_name,
          email,
          salary,
          dept_id
      from
          tbl_employee
      where
          dept_id=#{deptId}
  </select>
  ```

#### 8.7 Mybatis延迟加载【懒加载】

- 需要时加载，不需要暂时不加载
  
- 优势：提升程序运行效率
  
- 语法

  - 全局设置

    ```xml
    <!-- 开启延迟加载 -->
    <setting name="lazyLoadingEnabled" value="true"/>
    <!-- 设置加载的数据是按需加载3.4.2及以后的版本该步骤可省略-->
    <setting name="aggressiveLazyLoading" value="false"/>
    ```

  - 局部设置

    - fetchType
      - eager：关闭局部延迟加载
      - lazy：开启局部延迟加载

    - 示例代码

      ```xml
      <association property="dept"
                  select="com.atguigu.mybatis.mapper.DeptMapper.selectDeptByDeptId"
                  column="dept_id"
                  fetchType="eager">
      </association>
      ```

#### 8.8 扩展

- 如果分步查询时，需要传递给调用的查询中多个参数，则需要将多个参数封装成

  Map来进行传递，语法如下**: {k1=v1, k2=v2....}**
  
  ```
  <association property="dept"
              select="com.atguigu.mybatis.mapper.DeptMapper.selectDeptByDeptId"
              column="{did=dept_id,}"
              fetchType="eager">
  </association>
  
  //用的是等号
  ```
  
  

### 第九章 Mybatis动态SQL【重点】

> SQL中注释
>
> ```xml
> //方式一
> -- 1=1
> //方式二【推荐使用】
>  <!-- 1=1 -->
> ```

#### 9.1 动态SQL概述

- 动态SQL指的是：SQL语句可动态化
- Mybatis的动态SQL中支持OGNL表达式语言，OGNL（ Object Graph Navigation Language ）对象图导航语言

#### 9.2 常用标签

- **if标签**：用于完成简单的判断

- **where标签**：用于解决where关键字及where后第一个and或or的问题

- **trim标签**： 可以在条件判断完的SQL语句前后添加或者去掉指定的字符

  - prefix: 添加前缀

  - prefixOverrides: 去掉前缀

  - suffix: 添加后缀

  - suffixOverrides: 去掉后缀

- **set标签**：主要用于解决set关键字及多出一个【，】问题

- **choose标签**：类似java中if-else【switch-case】结构

- **foreach标签**：类似java中for循环

  - collection: 要迭代的集合
  - item: 当前从集合中迭代出的元素
  - separator: 元素与元素之间的分隔符
  - open: 开始字符
  - close:结束字符

- **sql标签**：提取可重用SQL片段

#### 9.3 示例代码

```xml
<?xml version="1.0" encoding="UTF-8" ?>
<!DOCTYPE mapper
        PUBLIC "-//mybatis.org//DTD Mapper 3.0//EN"
        "http://mybatis.org/dtd/mybatis-3-mapper.dtd">

<mapper namespace="com.atguigu.mybatis.mapper.EmployeeMapper">
    <sql id="emp_col">
        id,
        last_name,
        email,
        salary
    </sql>
    <sql id="select_employee">
        select
            id,
            last_name,
            email,
            salary
        from
            tbl_employee
    </sql>
<!-- 按条件查询员工信息【条件不确定】-->
    <select id="selectEmpByOpr" resultType="employee">
        <include refid="select_employee"></include>
        <where>
            <if test="id != null">
               and id = #{id}
            </if>
            <if test="lastName != null">
                and last_name = #{lastName}
            </if>
            <if test="email != null">
                and email = #{email}
            </if>
            <if test="salary != null">
                and salary = #{salary}
            </if>
        </where>
    </select>

    <select id="selectEmpByOprTrim" resultType="employee">
        <include refid="select_employee"></include>
        <trim prefix="where" suffixOverrides="and">
            <if test="id != null">
                id = #{id} and
            </if>
            <if test="lastName != null">
                last_name = #{lastName} and
            </if>
            <if test="email != null">
                email = #{email} and
            </if>
            <if test="salary != null">
                salary = #{salary}
            </if>
        </trim>
    </select>

    <update id="updateEmpByOpr">
        update
            tbl_employee
        <set>
            <if test="lastName != null">
                last_name=#{lastName},
            </if>
            <if test="email != null">
                email=#{email},
            </if>
            <if test="salary != null">
                salary=#{salary}
            </if>
        </set>
        where
            id = #{id}
    </update>


    <select id="selectEmpByOneOpr" resultType="employee">
        select
            <include refid="emp_col"></include>
        from
            tbl_employee
        <where>
            <choose>
                <when test="id != null">
                    id = #{id}
                </when>
                <when test="lastName != null">
                    last_name = #{lastName}
                </when>
                <when test="email != null">
                    email = #{email}
                </when>
                <when test="salary != null">
                    salary = #{salary}
                </when>
                <otherwise>
                    1=1
                </otherwise>
            </choose>
        </where>
    </select>

    <select id="selectEmpByIds" resultType="employee">
        select
            id,
            last_name,
            email,
            salary
        from
            tbl_employee
        <where>
            id in(
            <foreach collection="ids" item="id" separator=",">
                #{id}
            </foreach>
            )
        </where>

    </select>

    <insert id="batchInsertEmp">
        INSERT INTO
            tbl_employee(last_name,email,salary)
        VALUES
            <foreach collection="employees" item="emp" separator=",">
                (#{emp.lastName},#{emp.email},#{emp.salary})
            </foreach>
    </insert>
</mapper>
```



### 第十章 Mybatis中缓存机制

#### 10.1 缓存概述

- 生活中缓存
  - 缓存一些音频、视频优势
    - 节约数据流量
    - 提高播放性能
- 程序中缓存【Mybatis缓存】
  - 使用缓存优势
    - 提高查询效率
    - 降低服务器压力

#### 10.2 Mybatis中的缓存概述

- 一级缓存

- 二级缓存

- 第三方缓存

  ![image-20220324141538764](02_Mybatis.assets\image-20220324141538764.png)

#### 10.3 Mybatis缓存机制之一级缓存

- 概述：一级缓存【本地缓存（Local Cache）或SqlSession级别缓存】
- 特点
  - 一级缓存默认开启
  - 不能关闭
  - 可以清空

- 缓存原理
  - 第一次获取数据时，先从数据库中加载数据，将数据缓存至Mybatis一级缓存中【缓存底层实现原理Map，key：hashCode+查询的SqlId+编写的sql查询语句+参数】
  - 以后再次获取数据时，先从一级缓存中获取，**如未获取到数据**，再从数据库中获取数据。

- **一级缓存五种失效情况**

  1) 不同的SqlSession对应不同的一级缓存

  2) 同一个SqlSession但是查询条件不同

  3) **同一个SqlSession两次查询期间执行了任何一次增删改操作**	

  - 清空一级缓存

  4) 同一个SqlSession两次查询期间手动清空了缓存

  - **sqlSession.clearCache()**

  5) 同一个SqlSession两次查询期间提交了事务

  - sqlSession.commit()

#### 10.4 Mybatis缓存机制之二级缓存

- 二级缓存【second level cache】概述

  - 二级缓存【全局作用域缓存】
  - SqlSessionFactory级别缓存

- 二级缓存特点

  - 二级缓存默认关闭，需要开启才能使用
  - 二级缓存需要提交sqlSession或关闭sqlSession时，才会缓存。

- 二级缓存使用的步骤:

  ① 全局配置文件中开启二级缓存<setting name="cacheEnabled" value="true"/>

  ② 需要使用二级缓存的**映射文件处**使用cache配置缓存<cache />

  ③ 注意：POJO需要实现Serializable接口

  ![image-20220324151903793](02_Mybatis.assets\image-20220324151903793.png)

  ④ **关闭sqlSession或提交sqlSession时，将数据缓存到二级缓存**

- 二级缓存底层原理
  - 第一次获取数据时，先从数据库中获取数据，将数据缓存至一级缓存；当提交或关闭SqlSession时，将数据缓存至二级缓存
  - 以后再次获取数据时，先从一级缓存中获取数据，如一级缓存没有指定数据，再去二级缓存中获取数据。如二级缓存也没有指定数据时，需要去数据库中获取数据，......

- 二级缓存相关属性
  - eviction=“FIFO”：缓存清除【回收】策略。
    - LRU – 最近最少使用的：移除最长时间不被使用的对象。
    - FIFO – 先进先出：按对象进入缓存的顺序来移除它们。
  - flushInterval：刷新间隔，单位毫秒
  - size：引用数目，正整数
  - readOnly：只读，true/false

- 二级缓存的失效情况
  - 在两次查询之间，执行增删改操作，会同时清空一级缓存和二级缓存
  - sqlSession.clearCache()：只是用来清除一级缓存。

#### 10.5 Mybatis中缓存机制之第三方缓存

- 第三方缓存：EhCache

- EhCache 是一个纯Java的进程内缓存框架

- 使用步骤

  - 导入jar包

    ```xml
    <!-- mybatis-ehcache -->
    <dependency>
        <groupId>org.mybatis.caches</groupId>
        <artifactId>mybatis-ehcache</artifactId>
        <version>1.0.3</version>
    </dependency>
    
    <!-- slf4j-log4j12 -->
    <dependency>
        <groupId>org.slf4j</groupId>
        <artifactId>slf4j-log4j12</artifactId>
        <version>1.6.2</version>
        <scope>test</scope>
    </dependency>
    ```

  - 编写配置文件【ehcache.xml】

    ```xml
    <?xml version="1.0" encoding="UTF-8"?>
    <ehcache xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
             xsi:noNamespaceSchemaLocation="../config/ehcache.xsd">
        <!-- 磁盘保存路径 -->
        <diskStore path="E:\mybatis\ehcache" />
    
        <defaultCache
                maxElementsInMemory="512"
                maxElementsOnDisk="10000000"
                eternal="false"
                overflowToDisk="true"
                timeToIdleSeconds="120"
                timeToLiveSeconds="120"
                diskExpiryThreadIntervalSeconds="120"
                memoryStoreEvictionPolicy="LRU">
        </defaultCache>
    </ehcache>
    ```

  - 加载第三方缓存【映射文件】

  - 开始使用

- 注意事项

  - 第三方缓存，需要建立在二级缓存基础上【需要开启二级缓存，第三方缓存才能生效】
  - 如何让第三方缓存失效【将二级缓存设置失效即可】











### 其他

[mybatis看这一篇就够了，简单全面一发入魂_抠脚的大灰狼的博客-CSDN博客_mybatis看这一篇](https://blog.csdn.net/vcj1009784814/article/details/106391982)



[Mybatis-generator逆向工程_ak12313546的博客-CSDN博客](https://blog.csdn.net/ak12313546/article/details/102272425)



[PageHelper详解_32码奴的博客-CSDN博客_pagehelper](https://blog.csdn.net/qq_45578181/article/details/119987379?ops_request_misc=%7B%22request%5Fid%22%3A%22166338479716782417034272%22%2C%22scm%22%3A%2220140713.130102334..%22%7D&request_id=166338479716782417034272&biz_id=0&utm_medium=distribute.pc_search_result.none-task-blog-2~all~top_click~default-2-119987379-null-null.142^v47^pc_rank_34_default_2,201^v3^control_2&utm_term=pageHelper&spm=1018.2226.3001.4187)









































