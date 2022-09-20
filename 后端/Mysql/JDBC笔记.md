### 一.获取数据库连接

#### 1.方式一

```java
public class ConnectionTest {
    @Test
    public void testConnection1() throws SQLException {
        //获取Driver实现类对象
        Driver driver = new com.mysql.jdbc.Driver();
        //jdbc:mysql: 协议
        //localhost ip地址
        //3306 MySQL数据库默认端口号
        //test 需要连接的数据库名称
        String url = "jdbc:mysql://localhost:3306/test";
        Properties info = new Properties();
        //设置连接的用户名和名称，user和password是固定的写法
        info.setProperty("user","root");
        info.setProperty("password","lxq");

        Connection connect = driver.connect(url, info);

        System.out.println(connect);
    }
}
```

#### 2.方式二

```java
public class ConnectionTest {
    @Test
    public void testConnection2() throws Exception {
        //1.使用反射获取Driver实现类对象
        Class<?> clazz = Class.forName("com.mysql.jdbc.Driver");
        Driver driver = (Driver) clazz.newInstance();
        //2.提供需要连接的数据库
        String url = "jdbc:mysql://localhost:3306/test";
        //3.提供连接需要的用户和密码
        Properties info = new Properties();
        info.setProperty("user","root");
        info.setProperty("password","lxq");
        //获取链接
        Connection connect = driver.connect(url, info);

        System.out.println(connect);

    }
}
```

* 方式二是方式一的迭代，与方式一相比没有出现第三方的API，有较好移植性

#### 3.方式三

```java
public class ConnectionTest {
    @Test
    public void testConnection3() throws Exception {
        //1.使用反射获取Driver实现类对象
        Class<?> clazz = Class.forName("com.mysql.jdbc.Driver");
        Driver driver = (Driver) clazz.newInstance();

        //2.提供需要连接的数据库
        String url = "jdbc:mysql://localhost:3306/test";
        //3.提供连接需要的用户和密码
        String user = "root";
        String password = "lxq";
        //4.注册驱动
        DriverManager.registerDriver(driver);
        //5.获取连接
        Connection connection = DriverManager.getConnection(url, user, password);

        System.out.println(connection);
    }
}
```

* 使用DriverManager(驱动管理器)替换Driver，DriverManager是jdk提供的一个类，用来完成获取连接的操作

#### 4.方式四

```java
public class ConnectionTest {
    @Test
    public void testConnection4() throws Exception {
        //1.提供连接所需信息
        String url = "jdbc:mysql://localhost:3306/test";
        String user = "root";
        String password = "lxq";
        //2.使用反射加载驱动
        Class.forName("com.mysql.jdbc.Driver");
        //3.获取连接
        Connection connection = DriverManager.getConnection(url, user, password);

        System.out.println(connection);
    }
}

```

* 与方式三相比，方式四省略了如下代码

```java
Driver driver = (Driver) clazz.newInstance();
DriverManager.registerDriver(driver);
```

* 理由是，在com.mysql.jdbc.Driver类中有如下所示的**静态代码块**，使用Class.forName()加载这个驱动时就会执行这个静态代码块，实现了注册驱动

```java
static {
    try {
        DriverManager.registerDriver(new Driver());
    } catch (SQLException var1) {
            throw new RuntimeException("Can't register driver!");
    }
}
```

#### 5.方式五

```java
public class ConnectionTest {
    @Test
    public void testConnection5() throws Exception {
        //1.获取连接所需信息
        InputStream is = ConnectionTest.class.getClassLoader().getResourceAsStream("jdbc.properties");
        Properties info = new Properties();
        info.load(is);
        String url = info.getProperty("url");
        String user = info.getProperty("user");
        String password = info.getProperty("password");
        String driverClass = info.getProperty("driverClass");
        //2.使用反射加载驱动
        Class.forName(driverClass);
        //5.获取连接
        Connection connection = DriverManager.getConnection(url, user, password);

        System.out.println(connection);
    }
}
```

* 其中配置文件jdbc.properties在src目录下

```properties
url=jdbc:mysql://localhost:3306/test
user=root
password=lxq;
driverClass=com.mysql.jdbc.Driver
```

* 使用配置文件的好处
  1. 实现代码和数据的分离，如果需要修改配置信息，直接在配置文件中进行修改，不需要深入代码
  2. 如果修改了配置信息，省去了重新编译的过程

### 二.使用PreparedStatement对数据库进行CRUD

#### 1.数据库连接和关闭的工具类

```java
public class JDBCUtils {
    public static Connection getConnection() throws Exception{
        InputStream is = ClassLoader.getSystemClassLoader().getResourceAsStream("jdbc.properties");
        Properties info = new Properties();
        info.load(is);
        String url = info.getProperty("url");
        String user = info.getProperty("user");
        String password = info.getProperty("password");
        String driverClass = info.getProperty("driverClass");
        Class.forName(driverClass);
        Connection connection = DriverManager.getConnection(url, user, password);
        return connection;
    }

    public static void closeConnection(Connection conn, Statement ps){
        try {
            if (ps != null) {
                ps.close();
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        try {
            if (conn != null) {
                conn.close();
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
}
```

#### 2.Statement介绍及其弊端

* 通过调用Connection对象的createStatement()方法创建该对象。该对象用于执行**静态的**SQL语句，并且返回执行结果

* Statement接口中定义了下列方法用于执行SQL语句

  ```java
  int excuteUpdate(String sql) //执行更新操作INSERT、UPDATE、DELETE
  ResultSet executeQuery(String sql) //执行查询操作SELECT
  ```

* 使用Statement操作数据表存在弊端

  * **问题一：存在拼串操作，繁琐**
  * **问题二：存在SQL注入问题**

* SQL注入是利用某些系统没有对用户输入的数据进行充分的检查，而在用户输入数据中注入非法的SQL语句段或命令(如：SELECT user, password FROM user_table WHERE user='a' OR 1 = ' AND password = ' OR '1' = '1') ，从而利用系统的 SQL 引擎完成恶意行为的做法

* 对于Java而言，要防范SQL注入，只要用PreparedStatement(从Statement扩展而来)取代Statement就可 以了

#### 3.PreparedStatement介绍

* PreparedStatement接口是Statement的子接口，它表示一条预编译过的 SQL 语句
* 可以通过调用**Connection**对象的**preparedStatement(String sql)**方法获取PreparedStatement对象
* PreparedStatement对象所代表的 SQL 语句中的参数用问号**(?)**来表示，调用PreparedStatement对象的**setXxx()**方法来设置这些参数，setXxx()方法有两个参数，第一个参数是要设置的 SQL 语句中的参数的索引**(从 1 开始)**，第二个是设置的 SQL 语句中的参数的值

#### 4.PreparedStatement与Statement的比较

* 代码的可读性和可维护性高
* PreparedStatement能最大可能提高性能
  * DBServer会对预编译语句提供性能优化。因为预编译语句有可能被重复调用，所以语句在被DBServer的编译器编译后的执行代码被缓存下来，那么下次调用时只要是相同的预编译语句就不需要编译，只要将参数直接传入编译过的语句执行代码中就会得到执行
  * 在statement语句中，即使是相同操作但因为数据内容不一样，所以整个语句本身不能匹配,没有缓存语句的意义，事实是没有数据库会对普通语句编译后的执行代码缓存，这样每执行一次都要对传入的语句编译一次
* PreparedStatement可以防止SQL注入

#### 5.使用PreparedStatement实现插入数据的操作

```java
public class PreparedStatementUpdateTest {
    @Test
    public void testInsert() {
        Connection connection = null;
        PreparedStatement ps = null;

        try {
            //1.获取链接
            connection = JDBCUtils.getConnection();
            //2.预编译sql语句，返回PreparedStatement实例
            String sql = "insert into customers(name,email,birth) value(?,?,?)";
            ps = connection.prepareStatement(sql);
            //3.填充占位符
            ps.setString(1,"哪吒");
            ps.setString(2,"nezha@gmail.com");
            SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
            java.util.Date parse = sdf.parse("2001-03-21");
            long time = parse.getTime();
            //这个Date是sql中的Date
            ps.setDate(3,new Date(time));
            //4.执行操作
            ps.execute();
        } catch (Exception e) {
            e.printStackTrace();
        }
        //5.资源释放
        JDBCUtils.closeConnection(connection,ps);
    }
}
```

#### 6.通用的增删改操作方式

```java
public class PreparedStatementUpdateTest {
    public void update(String sql,Object ...obj){
        Connection conn = null;
        PreparedStatement ps = null;
        try {
            //1.获取链接
            conn = JDBCUtils.getConnection();
            //2.预编译sql语句，返回PreparedStatement实例
            ps = conn.prepareStatement(sql);
            //3.填充占位符
            for(int i=0;i<obj.length;i++){
                ps.setObject(i+1,obj[i]);
            }
            //4.执行操作
            ps.execute();//如果需要得到更新后影响的行数，可以改为executeUpdate方法，然后修改返回值类型和增加异常时的输出即可
        } catch (Exception e) {
            e.printStackTrace();
        }finally {
            //5.释放资源
            JDBCUtils.closeConnection(conn,ps);
        }
    }
}
```

#### 7.使用PrepareStatement实现查询数据的操作

* 查询的代码

```java
public class CustomerForQuery {
    public Customer commonQueryForCustomer(String sql,Object ...obj){
        Connection conn = null;
        PreparedStatement ps = null;
        ResultSet resultSet = null;
        try {
            //1.获取连接
            conn = JDBCUtils.getConnection();
            //2.预编译sql语句，返回PreparedStatement实例
            ps = conn.prepareStatement(sql);
            //3.填充占位符
            for (int i = 0; i < obj.length; i++) {
                ps.setObject(i+1,obj[i]);
            }
            //4.执行查询操作
            resultSet = ps.executeQuery();
            //5.获取描述结果集的对象
            ResultSetMetaData metaData = resultSet.getMetaData();
            int columnCount = metaData.getColumnCount();
            //6.处理结果集
            if(resultSet.next()){
                Customer customer = new Customer();
                for (int i = 0; i < columnCount; i++) {
                    Object object = resultSet.getObject(i + 1);
                    String columnName = metaData.getColumnName(i + 1);
                    Field declaredField = Customer.class.getDeclaredField(columnName);
                    declaredField.setAccessible(true);
                    declaredField.set(customer,object);
                }
                return customer;
            }
        } catch (Exception e) {
            e.printStackTrace();
        }finally {
            //7.关闭资源
            JDBCUtils.closeConnection(conn,ps,resultSet);
        }
        return null;
    }

    @Test
    public void test(){
        String sql = "select name,email from customers where id=?";
        Customer customer = commonQueryForCustomer(sql, 2);
        System.out.println(customer);
    }
}
```

* 用到的bean类

```java
public class Customer {
    private int id;
    private String name;
    private String email;
    private Date birth;

    public Customer() {}

    public Customer(int id, String name, String email, Date birth) {
        this.id = id;
        this.name = name;
        this.email = email;
        this.birth = birth;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public Date getBirth() {
        return birth;
    }

    public void setBirth(Date birth) {
        this.birth = birth;
    }

    @Override
    public String toString() {
        return "Customer{" +
                "id=" + id +
                ", name='" + name + '\'' +
                ", email='" + email + '\'' +
                ", birth=" + birth +
                '}';
    }
}
```

#### 8.通用的查询操作方式

* 查询结果是一条记录的情况

```java
public class CommonQuery {
    public <T> T getInstance(Class<T> clazz,String sql,Object...obj){
        Connection conn = null;
        PreparedStatement ps = null;
        ResultSet resultSet = null;
        try {
            //1.获取数据库连接
            conn = JDBCUtils.getConnection();
            //2.预编译sql语句，返回PreparedStatement实例
            ps = conn.prepareStatement(sql);
            //3.填充占位符
            for (int i = 0; i < obj.length; i++) {
                ps.setObject(i+1,obj[i]);
            }
            //4.执行查询操作
            resultSet = ps.executeQuery();
            //5.获取结果集描述对象，从而获得结果集列数
            ResultSetMetaData metaData = ps.getMetaData();
            int columnCount = metaData.getColumnCount();
            //6.处理结果集
            if (resultSet.next()){
                T t = clazz.newInstance();
                for (int i = 0; i < columnCount; i++) {
                    Object object = resultSet.getObject(i + 1);
                    String columnName = metaData.getColumnName(i + 1);//获取当前列名
                    Field declaredField = clazz.getDeclaredField(columnName);//由列名反射获取对应属性
                    declaredField.setAccessible(true);
                    declaredField.set(t,object);
                }
                return t;
            }
        } catch (Exception e) {
            e.printStackTrace();
        }finally {
            //7.关闭资源
            JDBCUtils.closeConnection(conn,ps,resultSet);
        }
        return null;
    }
	//测试
    @Test
    public void test(){
        String sql = "select name,email,birth from customers where id=?";
        Customer instance = getInstance(Customer.class, sql, 5);
        System.out.println(instance);
    }
}
```

* 查询结果是多条记录的情况

```java
public class CommonQuery {
    public <T> List<T> getInstances(Class<T> clazz,String sql,Object...obj){
        Connection conn = null;
        PreparedStatement ps = null;
        ResultSet resultSet = null;
        try {
            //1.获取数据库连接
            conn = JDBCUtils.getConnection();
            //2.预编译sql语句，返回PreparedStatement实例
            ps = conn.prepareStatement(sql);
            //3.填充占位符
            for (int i = 0; i < obj.length; i++) {
                ps.setObject(i+1,obj[i]);
            }
            //4.执行查询操作
            resultSet = ps.executeQuery();
            //5.获取结果集描述对象，从而获得结果集列数
            ResultSetMetaData metaData = ps.getMetaData();
            int columnCount = metaData.getColumnCount();
            //6.创建用于返回的集合
            ArrayList<T> list = new ArrayList<>();
            //7.处理结果集
            while (resultSet.next()){
                T t = clazz.newInstance();
                for (int i = 0; i < columnCount; i++) {
                    Object object = resultSet.getObject(i + 1);
                    String columnName = metaData.getColumnLabel(i + 1);//注意此处getColumnLabel与getColumnName的区别
                    Field declaredField = clazz.getDeclaredField(columnName);
                    declaredField.setAccessible(true);
                    declaredField.set(t,object);
                }
                list.add(t);
            }
            return list;
        } catch (Exception e) {
            e.printStackTrace();
        }finally {
            //8.关闭资源
            JDBCUtils.closeConnection(conn,ps,resultSet);
        }
        return null;
    }

    @Test
    public void test(){
        String sql="select name,email,birth from customers where id>?";
        List<Customer> instances = getInstances(Customer.class, sql, 10);
        System.out.println(instances);

        String sql1 = "select order_id id,order_name name,order_date date from `order` where order_id>?";
        List<Order> instances1 = getInstances(Order.class, sql1,0);
        System.out.println(instances1);
    }
}
```

#### 9.ResultSet和ResultSetMetaData

* ResultSet
  * 查询需要调用PreparedStatement 的 executeQuery() 方法，查询结果是一个ResultSet 对象
  * ResultSet 对象以逻辑表格的形式封装了执行数据库操作的结果集，ResultSet 接口由数据库厂商提供实现
  * ResultSet 返回的实际上就是一张数据表。有一个指针指向数据表的第一条记录的前面
  * ResultSet 对象维护了一个指向当前数据行的游标，初始的时候，游标在第一行之前，可以通过 ResultSet 对象 的 next() 方法移动到下一行。调用 next()方法检测下一行是否有效。若有效，该方法返回 true，且指针下移。 相当于Iterator对象的 hasNext() 和 next() 方法的结合体。 当指针指向一行时, 可以通过调用 getXxx(int index) 或 getXxx(int columnName) 获取每一列的值。 例如: getInt(1), getString("name") 
  * **注意**：Java与数据库交互涉及到的相关Java API中的索引都从1开始
* ResultSetMetaData
  * 可用于获取关于ResultSet对象中**列的类型和属性信息**的对象
  * 通过ResultSet的getMetaData()方法获取
  * 常用方法
    * getColumnName(int column)方法，获取指定列的**名称**
    * getColumnLabel(int column)方法，获取指定列的**别名**，如果不指定别名则返回名称
    * getColumnCount()方法，返回当前 ResultSet 对象中的列数

#### 10.资源释放

* 释放ResultSet, Statement,Connection。
* 数据库连接（Connection）是非常稀有的资源，用完后必须马上释放，如果Connection不能及时正确的关闭将导致系统宕机
* Connection的使用原则是尽量晚创建，尽量早的释放。 可以在finally中关闭，保证及时其他代码出现异常，资源也一定能被关闭。

#### 11.小结

* 两种思想
  * 面向接口编程
  * ORM(Object Relational Mapping)
    * 一个数据表对应一个java类
    * 表中一条记录对应java类一个对象
    * 表中一个字段对应java类一个属性
* 两种技术
  * JDBC结构集的元数据：ResultSetMetaData
    * 获取列数
    * 获取列别名
  * 通过反射，创建指定类对象，获取指定属性并赋值

### 三.操作BLOB类型字段

#### 1.MYSQL中的BLOB类型字段

* MySQL中，BLOB是一个**二进制**大型对象，是一个可以存储大量数据的容器，它能容纳不同大小的数据
* 插入BLOB类型的数据必须使用PreparedStatement，因为BLOB类型的数据无法使用字符串拼接写的
* MySQL的四种BLOB类型
  1. TinyBlob，最大存放255B
  2. Blob，最大存放65KB
  3. MediumBlob，最大存放16MB
  4. LongBlob，最大存放4GB
* 实际使用中根据需要存入的数据大小定义不同的BLOB类型
* 需要注意的是：如果存储的文件过大，数据库的性能会下降
* 如果在指定了相关的Blob类型以后，还报错：xxx too large，那么在mysql的安装目录下，找my.ini文件加上如 下的配置参数： max_allowed_packet=16M。同时注意：修改了my.ini文件之后，需要重新启动mysql服务

#### 2.插入Blob类型数据

```java
//获取连接
Connection conn = JDBCUtils.getConnection();
String sql = "insert into customers(name,email,birth,photo)values(?,?,?,?)";
PreparedStatement ps = conn.prepareStatement(sql);
//填充占位符
ps.setString(1, "徐海强");
ps.setString(2, "xhq@126.com");
ps.setDate(3, new Date(new java.util.Date().getTime()));
//操作Blob类型的变量
FileInputStream fis = new FileInputStream("xhq.png");
ps.setBlob(4, fis);
//执行
ps.execute();
fis.close();
JDBCUtils.closeResource(conn, ps)
```

#### 3.查询Blob类型数据

```java
String sql = "SELECT id, name, email, birth, photo FROM customer WHERE id = ?";
conn = getConnection();
ps = conn.prepareStatement(sql);
ps.setInt(1, 8);
rs = ps.executeQuery();
if(rs.next()){
	Integer id = rs.getInt(1);
	String name = rs.getString(2);
	String email = rs.getString(3);
	Date birth = rs.getDate(4);
	Customer cust = new Customer(id, name, email, birth);
	System.out.println(cust);
	//读取Blob类型的字段
	Blob photo = rs.getBlob(5);
	InputStream is = photo.getBinaryStream();//从查询出来的Blob对象中获取二进制流
	OutputStream os = new FileOutputStream("c.jpg");
	byte [] buffer = new byte[1024];
	int len = 0;
	while((len = is.read(buffer)) != -1){
	os.write(buffer, 0, len);
}
JDBCUtils.closeResource(conn, ps, rs);
if(is != null){
	is.close();
}
if(os != null){
	os.close();
}
```

### 四.批量插入

#### 1.批量执行SQL语句

* 当需要成批插入或者更新记录时，可以采用Java的批量更新机制，这一机制允许多条语句一次性提交给数据库批量处理。通常情况下比单独提交处理更有效率
* JDBC的批量处理语句包括下面三个方法
  1. `addBatch(String)`，添加需要批量处理的SQL语句或是参数
  2. `executeBatch()`，执行批量处理语句
  3. `clearBatch()`，清空缓存的数据
* 两种批量执行SQL语句的情况
  * 多条SQL语句的批量处理
  * 一个SQL语句的批量传参

#### 2.高效的批量插入

* 方式一：使用Statement

```java
Connection conn = JDBCUtils.getConnection();
Statement st = conn.createStatement();
for(int i = 1;i <= 20000;i++){
	String sql = "insert into goods(name) values('name_' + "+ i +")";
	st.executeUpdate(sql);
}
```

* 方式二：使用PreparedStatement(比Statement高效)

```java
long start = System.currentTimeMillis();
Connection conn = JDBCUtils.getConnection();
String sql = "insert into goods(name)values(?)";
PreparedStatement ps = conn.prepareStatement(sql);
for(int i = 1;i <= 20000;i++){
	ps.setString(1, "name_" + i);
	ps.executeUpdate();
}
long end = System.currentTimeMillis();
System.out.println("花费的时间为：" + (end - start));//82340
JDBCUtils.closeResource(conn, ps);
```

* 方式三：使用批量处理语句对方式二优化

```java
public void testInsert1() throws Exception{
	long start = System.currentTimeMillis();
	Connection conn = JDBCUtils.getConnection();
	String sql = "insert into goods(name)values(?)";
	PreparedStatement ps = conn.prepareStatement(sql);
	for(int i = 1;i <= 1000000;i++){
		ps.setString(1, "name_" + i);
		//1.“攒”sql
		ps.addBatch();
		if(i % 500 == 0){
			//2.执行
			ps.executeBatch();
			//3.清空
			ps.clearBatch();
		}
	}
	long end = System.currentTimeMillis();
	System.out.println("花费的时间为：" + (end - start));//20000条：625
	//1000000条:14733
	JDBCUtils.closeResource(conn, ps);
}
```

* 方式四：使用Connection的setAutoCommit()方法对方式三优化

```java
public void testInsert2() throws Exception{
	long start = System.currentTimeMillis();
	Connection conn = JDBCUtils.getConnection();
	//1.设置为不自动提交数据
	conn.setAutoCommit(false);
	String sql = "insert into goods(name)values(?)";
	PreparedStatement ps = conn.prepareStatement(sql);
	for(int i = 1;i <= 1000000;i++){
		ps.setString(1, "name_" + i);
		//1.“攒”sql
		ps.addBatch();
		if(i % 500 == 0){
			//2.执行
			ps.executeBatch();
			//3.清空
			ps.clearBatch();
		}
	}
	//2.手动提交数据
	conn.commit();
	long end = System.currentTimeMillis();
	System.out.println("花费的时间为：" + (end - start));//1000000条:4978
	JDBCUtils.closeResource(conn, ps);
}
```

### 五.数据库事务

#### 1.事务介绍

* 事务：一组逻辑操作单元，使数据从一种状态变换到另一种状态
* 事务处理（事务操作）：保证所有事务都作为一个工作单元来执行，即使出现了故障，都不能改变这种执行方 式。当在一个事务中执行多个操作时，要么所有的事务都被提交(commit)，那么这些修改就永久地保存下来；要么数据库管理系统将放弃所作的所有修改，整个事务回滚(rollback)到最初状态
* 为确保数据库中数据的一致性，数据的操纵应当是离散的成组的逻辑单元：当它全部完成时，数据的一致性可 以保持，而当这个单元中的一部分操作失败，整个事务应全部视为错误，所有从起始点以后的操作应全部回退到开始状态

#### 2.JDBC中对事务的处理

* 数据一旦提交，就不可回滚

* 数据什么时候意味着提交？

  * 当一个**连接对象被创建时**，默认情况下是自动提交事务：每次执行一个 SQL 语句时，如果执行成功，就会向数据库自动提交，而不能回滚
  * **关闭数据库连接**，数据就会自动的提交。如果多个操作，每个操作使用的是自己单独的连接，则无法保证 事务。即同一个事务的多个操作必须在同一个连接下

* JDBC程序中为了让多个 SQL 语句作为一个事务执行

  * 调用Connection对象的`setAutoCommit(false);`以取消自动提交事务
  * 在所有的SQL语句都成功执行后，调用`commit();`方法提交事务
  * 在出现异常时，调用`rollback();`方法回滚事务
  * 在使用数据库连接池技术时，执行close()方法前，建议使用`setAutoCommit(true);`恢复自动提交状态

* 使用事务后的通用增删改查操作

  ```java
  public void update(Connection conn,String sql,Object ...obj){
      PreparedStatement ps = null;
      try {
          //1.预编译sql语句，返回PreparedStatement实例
          ps = conn.prepareStatement(sql);
          //2.填充占位符
          for(int i=0;i<obj.length;i++){
              ps.setObject(i+1,obj[i]);
          }
          //3.执行操作
          ps.execute();
      } catch (Exception e) {
          e.printStackTrace();
      }finally {
          //5.释放资源
          JDBCUtils.closeConnection(null,ps);
      }
  }
  ```

* 事务使用实例

  ```java
  public void testJDBCTransaction() {
  	Connection conn = null;
  	try {
  		// 1.获取数据库连接
  		conn = JDBCUtils.getConnection();
  		// 2.开启事务
  		conn.setAutoCommit(false);
  		// 3.进行数据库操作
  		String sql1 = "update user_table set balance = balance - 100 where user = ?";
  		update(conn, sql1, "AA");
  		// 模拟网络异常
  		//System.out.println(10 / 0);
  		String sql2 = "update user_table set balance = balance + 100 where user = ?";
  		update(conn, sql2, "BB");
  		// 4.若没有异常，则提交事务
  		conn.commit();
  	} catch (Exception e) {
  		e.printStackTrace();
  		// 5.若有异常，则回滚事务
  		try {
              conn.rollback();
  		} catch (SQLException e1) {
  			e1.printStackTrace();
  		}
  	} finally {
          try {
              //6.恢复每次DML操作的自动提交功能
  			conn.setAutoCommit(true);
          } catch (SQLException e) {
              e.printStackTrace();
          }
          //7.关闭连接
          JDBCUtils.closeResource(conn, null, null);
      }
  }
  ```

#### 3.事务的ACID属性

* 原子性（Atomicity）原子性是指事务是一个不可分割的工作单位，事务中的操作要么都发生，要么都不发生
* 一致性（Consistency）事务必须使数据库从一个一致性状态变换到另外一个一致性状态
* 隔离性（Isolation）事务的隔离性是指一个事务的执行不能被其他事务干扰，即一个事务内部的操作及使用的 数据对并发的其他事务是隔离的，并发执行的各个事务之间不能互相干扰
* 持久性（Durability）持久性是指一个事务一旦被提交，它对数据库中数据的改变就是永久性的，接下来的其 他操作和数据库故障不应该对其有任何影响

#### 4.数据库并发问题

* 对于同时运行的多个事务, 当这些事务访问数据库中相同的数据时, 如果没有采取必要的**隔离机制**, 就会导致各种并发问题
  * **脏读**: 对于两个事务T1,T2,T1读取了已经被T2更新但还没有被提交的字段。之后, 若 T2 回滚, T1读取的内容就是临时且无效的
  * **不可重复读**: 对于两个事务T1,T2,T1读取了一个字段, 然后 T2 更新了该字段。之后, T1再次读取同一个字 段, 值就不同了
  * **幻读**: 对于两个事务T1,T2,T1从一个表中读取了一个字段, 然后T2在该表中插入了一些新的行。之后,如果T1再次读取同一个表,就会多出几行
* 数据库事务的隔离性: 数据库系统必须具有隔离并发运行各个事务的能力, 使它们不会相互影响, 避免各种并发问题
* 一个事务与其他事务隔离的程度称为隔离级别。数据库规定了多种事务隔离级别, 不同隔离级别对应不同的干扰程度,隔离级别越高,数据一致性就越好,但并发性越弱

#### 5.四种隔离级别

| 隔离级别                    | 说明                                                         |
| --------------------------- | ------------------------------------------------------------ |
| READ UNCOMMITED（读未提交） | 允许事务读取其他事务未提交的变更，会出现脏读、不可重复读、幻读的问题 |
| READ COMMITTED（读已提交）  | 只允许事务读取已经被其他事务提交的变更，可以避免脏读，但存在不可重复读、幻读的问题 |
| REPETABLE READ（可重复读）  | 确保事务可以多次从一个字段中读取相同的值，在这个事务持续期间，禁止其他事务对这个字段进行更新，避免了脏读和不可重复读，但存在幻读问题 |
| SERIALIZABLE（串行化）      | 确保事务可以从一个表中读取相同的行，在这个事务持续期间，禁止其他事务对该表执行插入、更新、删除的操作，解决所有的并发问题，但是性能低下 |

* Oracle支持的2种事务隔离级别：READ COMMITED, SERIALIZABLE。Oracle 默认的事务隔离级别为: READ COMMITED
* Mysql 支持4种事务隔离级别。Mysql默认的事务隔离级别为: REPEATABLE READ

### 六.数据库连接池

#### 1.JDBC数据库连接池的必要性

* 在使用开发基于数据库的web程序时，传统的模式基本是按以下步骤
  1. 在主程序（如servlet、beans）中建立数据库连接
  2. 进行sql操作
  3. 断开数据库连接
* 这种模式开发，存在的问题
  1. 普通的JDBC数据库连接使用 DriverManager 来获取，每次向数据库建立连接的时候都要将 Connection 加载到内存中，再验证用户名和密码(得花费0.05s～1s的时间)。需要数据库连接的时候，就向数据库要求 一个，执行完成后再断开连接。这样的方式将会消耗大量的资源和时间。数据库的连接资源并没有得到很 好的重复利用。若同时有几百人甚至几千人在线，频繁的进行数据库连接操作将占用很多的系统资源，严 重的甚至会造成服务器的崩溃
  2. 对于每一次数据库连接，使用完后都得断开。否则，如果程序出现异常而未能关闭，将会导致数据库系统中的内存泄漏，最终将导致重启数据库
  3. 这种开发不能控制被创建的连接对象数，系统资源会被毫无顾及的分配出去，如连接过多，也可能导致内存泄漏，服务器崩溃

#### 2.数据库连接池技术

* 为解决传统开发中的数据库连接问题，可以采用数据库连接池技术

* 数据库连接池的基本思想：就是为数据库连接建立一个“缓冲池”。预先在缓冲池中放入一定数量的连接，当需要 建立数据库连接时，只需从“缓冲池”中取出一个，使用完毕之后再放回去

* 数据库连接池负责分配、管理和释放数据库连接，它允许应用程序重复使用一个现有的数据库连接，而不是重 新建立一个

* 数据库连接池在初始化时将创建一定数量的数据库连接放到连接池中，这些数据库连接的数量是由最小数据库 连接数来设定的。无论这些数据库连接是否被使用，连接池都将一直保证至少拥有这么多的连接数量。连接池 的最大数据库连接数量限定了这个连接池能占有的最大连接数，当应用程序向连接池请求的连接数超过最大连 接数量时，这些请求将被加入到等待队列中

* 技术特点

  * 资源重用

    由于数据库连接得以重用，避免了频繁创建，释放连接引起的大量性能开销。在减少系统消耗的基础上，另一 方面也增加了系统运行环境的平稳性

  *  更快的系统反应速度

    数据库连接池在初始化过程中，往往已经创建了若干数据库连接置于连接池中备用。此时连接的初始化工作均 已完成。对于业务请求处理而言，直接利用现有可用连接，避免了数据库连接初始化和释放过程的时间开销， 从而减少了系统的响应时间

  * 新的资源分配手段

    对于多应用共享同一数据库的系统而言，可在应用层通过数据库连接池的配置，实现某一应用最大可用数据库 连接数的限制，避免某一应用独占所有的数据库资源

  * 统一的连接管理，避免数据库连接泄漏

    在较为完善的数据库连接池实现中，可根据预先的占用超时设定，强制回收被占用连接，从而避免了常规数据 库连接操作中可能出现的资源泄露

#### 3.几种开源数据库连接池

* JDBC 的数据库连接池使用**javax.sql.DataSource**来表示，DataSource 只是一个接口，该接口通常由服务器 (Weblogic, WebSphere, Tomcat)提供实现，也有一些开源组织提供实现
  * C3P0 是一个开源组织提供的一个数据库连接池，速度相对较慢，稳定性还可以
  * Druid 是阿里提供的数据库连接池，据说是集DBCP 、C3P0 、Proxool 优点于一身的数据库连接池，但是 速度不确定是否有BoneCP快
* DataSource 通常被称为数据源，它包含连接池和连接池管理两个部分，习惯上也经常把DataSource称为连接池
* DataSource用来取代DriverManager来获取Connection，获取速度快，同时可以大幅度提高数据库访问速度
* 特别注意
  * 数据源和数据库连接不同，数据源无需创建多个，它是产生数据库连接的工厂，因此整个应用只需要一个 数据源即可
  * 当数据库访问结束后，程序还是像以前一样关闭数据库连接：conn.close(); 但conn.close()并没有关闭数 据库的物理连接，它仅仅把数据库连接释放，归还给了数据库连接池

#### 4.C3P0数据库连接池

* 配置以及连接方式一

  ```java
  //使用C3P0数据库连接池的方式，获取数据库的连接：不推荐
  public static Connection getConnection1() throws Exception{
  	ComboPooledDataSource cpds = new ComboPooledDataSource();
  	cpds.setDriverClass("com.mysql.jdbc.Driver");
  	cpds.setJdbcUrl("jdbc:mysql://localhost:3306/test");
  	cpds.setUser("root");
  	cpds.setPassword("abc123");
  	
  	Connection conn = cpds.getConnection();
  	return conn;
  }
  ```

* 配置以及连接方式二

  ```java
  //使用C3P0数据库连接池的配置文件方式，获取数据库的连接：推荐
  private static DataSource cpds = new ComboPooledDataSource("helloc3p0");
  public static Connection getConnection2() throws SQLException{
  	Connection conn = cpds.getConnection();
  	return conn;
  }
  ```

  其中src下的配置文件c3p0-config.xml如下

  ```xml
  <?xml version="1.0" encoding="UTF-8"?>
  	<c3p0-config>
  		<named-config name="helloc3p0">
  		<!-- 获取连接的4个基本信息 -->
  		<property name="user">root</property>
  		<property name="password">abc123</property>
  		<property name="jdbcUrl">jdbc:mysql:///test</property>
  		<property name="driverClass">com.mysql.jdbc.Driver</property>
              
  		<!-- 涉及到数据库连接池的管理的相关属性的设置 -->
  		<!-- 若数据库中连接数不足时, 一次向数据库服务器申请多少个连接 -->
  		<property name="acquireIncrement">5</property>
  		<!-- 初始化数据库连接池时连接的数量 -->
  		<property name="initialPoolSize">5</property>
  		<!-- 数据库连接池中的最小的数据库连接数 -->
  		<property name="minPoolSize">5</property>
  		<!-- 数据库连接池中的最大的数据库连接数 -->
  		<property name="maxPoolSize">10</property>
  		<!-- C3P0 数据库连接池可以维护的 Statement 的个数 -->
  		<property name="maxStatements">20</property>
  		<!-- 每个连接同时可以使用的 Statement 对象的个数 -->
  		<property name="maxStatementsPerConnection">5</property>
  	</named-config>
  </c3p0-config>
  ```

#### 5.Druid（德鲁伊）数据库连接池

Druid是阿里巴巴开源平台上一个数据库连接池实现，它结合了C3P0、DBCP、Proxool等DB池的优点，同时加入了 日志监控，可以很好的监控DB池连接和SQL的执行情况，可以说是针对监控而生的DB连接池，可以说是目前最好的 连接池之一

* 配置方式

  ```java
  public class TestDruid {
  	public static void main(String[] args) throws Exception {
      	Properties pro = new Properties();
  		pro.load(TestDruid.class.getClassLoader().getResourceAsStream("druid.properties"));
  		DataSource ds = DruidDataSourceFactory.createDataSource(pro);
  		Connection conn = ds.getConnection();
  		System.out.println(conn);
  	}
  }
  ```

  其中，src下的配置文件为：【druid.properties】

  ```properties
  url=jdbc:mysql://localhost:3306/test?rewriteBatchedStatements=true
  username=root
  password=123456
  driverClassName=com.mysql.jdbc.Driver
  
  initialSize=10
  maxActive=20
  maxWait=1000
  filters=wall
  ```

  详细配置参数

  | 配置                      | 缺省  | 说明                                                         |
  | ------------------------- | ----- | ------------------------------------------------------------ |
  | name                      |       | 配置这个属性的意义在于，如果存在多个数据源，监控的时候可以通过 名字来区分开来。 如果没有配置，将会生成一个名字，格式 是：”DataSource-” + System.identityHashCode(this) |
  | url                       |       | 连接数据库的url，不同数据库不一样。例如：mysql : jdbc:mysql://10.20.153.104:3306/druid2 oracle : jdbc:oracle:thin:@10.20.149.85:1521:ocnauto |
  | username                  |       | 连接数据库的用户名                                           |
  | password                  |       | 连接数据库的密码。如果你不希望密码直接写在配置文件中，可以使用 ConfigFilter。详细看这里：https://github.com/alibaba/druid/wiki/%E4%BD%BF%E7%94%A8ConfigFilter |
  | driverClassName           |       | 根据url自动识别 这一项可配可不配，如果不配置druid会根据url自动 识别dbType，然后选择相应的driverClassName(建议配置下) |
  | initialSize               | 0     | 初始化时建立物理连接的个数。初始化发生在显示调用init方法，或者 第一次getConnection时 |
  | maxActive                 | 8     | 最大连接池数量                                               |
  | maxIdle                   | 8     | 已经不再使用，配置了也没效果                                 |
  | minIdle                   |       | 最小连接池数量                                               |
  | maxWait                   |       | 获取连接时最大等待时间，单位毫秒。配置了maxWait之后，缺省启 用公平锁，并发效率会有所下降，如果需要可以通过配置 useUnfairLock属性为true使用非公平锁 |
  | poolPreparedStatements    | false | 是否缓存preparedStatement，也就是PSCache。PSCache对支持游 标的数据库性能提升巨大，比如说oracle。在mysql下建议关闭 |
  | maxOpenPreparedStatements | -1    | 要启用PSCache，必须配置大于0，当大于0时， poolPreparedStatements自动触发修改为true。在Druid中，不会存 在Oracle下PSCache占用内存过多的问题，可以把这个数值配置大一 些，比如说100 |
  | validationQuery           |       | 用来检测连接是否有效的sql，要求是一个查询语句。如果 validationQuery为null，testOnBorrow、testOnReturn、 testWhileIdle都不会其作用 |
  | testOnBorrow              | true  | 申请连接时执行validationQuery检测连接是否有效，做了这个配置会 降低性能 |
  | testOnReturn              | false | 归还连接时执行validationQuery检测连接是否有效，做了这个配置会 降低性能 |
  | testWhileIdle             | false | 建议配置为true，不影响性能，并且保证安全性。申请连接的时候检 测，如果空闲时间大于timeBetweenEvictionRunsMillis，执行 validationQuery检测连接是否有效 |
  | filters                   |       | 属性类型是字符串，通过别名的方式配置扩展插件，常用的插件有： 监控统计用的filter:stat日志用的filter:log4j防御sql注入的filter:wall |

  