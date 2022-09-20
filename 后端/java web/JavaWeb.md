## XML

### 1.xml文件

* XML全称是Extensible Markup Language，是一种可扩展的标记语言，使用标签来描述数据，并且标签可以自定义

* 作用是存储、传输数据或者用于软件配置文件

* xml标签

  1. 标签由尖括号和合法标识符组成
  2. 标签必须成对出现，有些特殊的标签不成对但是必须有结束标记，如`<student></student>`、`</adderss>`
  3. 标签中可以定义属性，属性和标签名用空格隔开，属性值需要用双引号引起来，如`<student id="1"></student>`
  4. 一个xml文件有且仅有一个根标签，标签需要正确嵌套

* 语法规则

  1. 文件后缀名是**.xml**

  2. 文档声明必须是文件第一行第一列，格式如下

     `<?xml version="1.0" encoding="UTF-8" standalone="yes" ?>`

     version属性：必选的

     encoding属性：可选的，指定打开该文件时使用的字符编码表，一般是UTF-8

     standalone属性：可选的，指定该xml文件是否依赖其他的的xml文件，取值为yes/no

  3. xml文件中的注释语法是

     `<!--注释信息-->`

  4. 五种特殊字符的表示

     | xml中的表示 | 字符 | 说明   |
     | ----------- | ---- | ------ |
     | &amp;lt;    | <    | 小于号 |
     | &amp;gt;    | >    | 大于号 |
     | &amp;amp;   | &    | 与号   |
     | &amp;apos;  | ''   | 单引号 |
     | &amp;quot;  | ""   | 双引号 |

  5. xml文件中的CDATA区，语法是

     `<![CDATA[内容]]>`

     内容部分只会被当作文本看待

  6. DOM解析思想

     * DOM(Document Object Model)是文档对象模型，将文档各个部分看成对应的对象

     * 将xml文件加载到内存中，形成一个树形结构，再获取对应的值

     * 范例

       ```xml
       <?xml version="1.0" encoding="UTF-8" ?>
       <students>
           <student id="1">
               <name>张三</name>
               <age>18</age>
           </student>
           <student id="2">
               <name>李四</name>
               <age>20</age>
           </student>
       </students>
       ```

       该文档的树结构为

       ```mermaid
       graph TB;
       A(Document) --> B(students)
       B --> C(student)
       B --> D(student)
       C --> E(id)
       C --> F(name)
       C --> G(age)
       D --> H(id)
       D --> I(name)
       D --> J(age)
       ```

       Document对象：表示整个文档

       Element对象：表示所有的标签

       Attribute对象：表示所有属性

       Text对象：表示所有文本内容

  7. 常用xml解析工具：DOM4J，需引入jar包

### 2.约束

* 约束用于限定xml文件中可以使用的标签以及属性

* DTD约束

  1. 引入DTD约束的方式

     * 引入本地DTD

       `<!DOCTYPE 根元素名称 SYSTEM 'DTD文件路径'>`

     * 在xml文件内部引入

       `<!DOCTYPE 根元素名称 [DTD文件内容]>`

     * 引入网络中的DTD

       `<!DOCTYPE 根元素名称 PUBLIC "DTD文件名称" "DTD文档的URL">`

  2. DTD文档中语法规则

     * 定义元素

       语法：`<!ELEMENT 元素名 元素类型>`

       元素类型分为**简单元素**，**复杂元素**

       * 简单元素取值可以是：`EMPTY`、`ANY`、`PCDATA`，分别表示**标签体为空**、**可以为空可以不为空**、**元素内容部分为字符串**

       * 复杂元素则需要将该元素中的所有元素列出，规则是：

         多个元素使用`,`或`|`隔开，`,`表示定义子元素的顺序，`|`表示子元素只能出现任意一个

         在子元素后面使用`?`，`+`，`*`分别可以指定子元素出现的次数是**零次或一次**，**一次或多次**，**零次或多次**

         如果不写则表示一次

       范例：

       ```dtd
       <!ELEMENT students (student+)>
       <!ELEMENT student (name,age)>
       <!ELEMENT name (#PCDATA)>
       <!ELEMENT age (#PCDATA)>
       ```

     * 定义属性

       语法：`<!ATTLIST 元素名称 属性名称 属性类型 属性约束>`

       元素名称：指出该属性属于哪个元素

       属性名称：指出属性的名称

       属性类型：`CDATA`表示普通的字符串

       属性约束：有三个常用取值`REQUIRED`、`IMPLIED`、`FIXED value`，分别表示**必需的**、**非必需的**、**固定值的（value是指出的固定值）**

       范例：

       ```dtd
       <!ATTLIST student id CDATA #REQIRED>
       ```

* schema约束

  * 内容仅仅了解，没做总结

## Servlet技术

### 一.Servlet

#### 1.概述

* Servlet是运行在web服务器端的应用程序，使用Java语言编写

* Servlet对象主要封装了对HTTP请求的处理，它的运行需要Servlet容器（如Tomcat）的支持

* Servlet由Servlet容器进行管理，Servlet容器将Servlet动态加载到服务器上，与HTTP协议相关的Servlet使用HTTP请求和HTTP响应与客户端进行交互

* 如下图，Servlet的请求首先会被HTTP服务器（如Apache）接收，HTTP服务器只负责静态HTML界面的解析，而Servlet的请求则转交给Servlet容器，Servlet容器会根据请求路径以及Servlet之间的映射关系，调用相应的Servlet，Servlet将处理的结果返回给Servlet容器，并通过HTTP服务器将响应传输给客户端

  ```mermaid
  graph LR;
  A[客户端] --> |HTTP请求| B[HTTP服务器]
  B --> C[Servlet容器]
  C --> D[Servlet]
  D --> C
  C --> B
  B --> |HTTP响应| A
  ```

#### 2.Servlet接口

* Servlet就是实现了Servlet接口的类，它由Web服务器创建并调用，用于接收和响应用户的请求，在Servlet接口中定义了五个抽象方法

  | 方法声明                                              | 说明                                                         |
  | ----------------------------------------------------- | ------------------------------------------------------------ |
  | void init(ServletConfig config)                       | Servlet实例化后，Servlet容器调用该方法完成Servlet的初始化工作 |
  | ServletConfig getServletConfig()                      | 获取Servlet对象的配置信息                                    |
  | String getServletInfo()                               | 返回包含Servlet信息的字符串，如作者，版权等                  |
  | void service(ServletRequest req,ServletResponse resp) | 负责响应用户的请求，当容器接收到客户端访问Servlet对象的请求时就会调用此方法。容器会构造一个表示客户端请求信息的**ServletRequest**对象和一个用于响应客户端的**ServletResponse**对象作为参数传递给**service()**方法，在service()方法中可以通过ServletRequest对象得到客户端的相关信息和请求信息，在对请求进行处理后，调用ServletResponse对象的方法设置相应信息 |
  | void destroy()                                        | 负责释放Servlet对象占用的资源，当服务器关闭或者Servlet对象被移除时会销毁Servlet对象，此时会调用此方法 |

* 编写的Servlet类必须实现Servlet接口或者继承Servlet接口的实现类，如**GenericServlet**和**HttpServlet**，这两个类都是**抽象类**并且HttpServlet继承了GenericServlet，其中GenericServlet有一个抽象方法**service()**，而HttpServlet没有抽象方法

* 总结三种方式编写Servlet类

  1. 实现**Servlet**接口，需要重写Servlet接口里边的所有方法

  2. 继承**GenericServlet**抽象类，必须重写**service()**方法，其他方法也可以重写

  3. 继承**HttpServlet**抽象类，不需要重写**service()**方法，因为HttpServlet在**service()**方法中调用了另一个重载的**service()**方法，这个重载的方法里边会根据参数选择相应的方法，如**doGet()**方法或**doPost()**方法，所以我们编写时可以重写doGet()方法和doPost()方法来实现我们想要的功能

  4. <font color="red">通常情况下使用继承HttpServlet抽象类的方式编写Servlet</font>

  5. 实例

     ```java
     public class ServletDemo02 extends HttpServlet {
         @Override
         protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
             System.out.println("方法执行了");
         }
     
         @Override
         protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
             doGet(req,resp);
         }
     }
     ```

* Servlet线程安全问题：在实现Servlet的类中如果存在自定义的成员变量，并且在service()方法中操作这个变量时可能会出现线程安全问题，解决的办法是将成员变量改为定义在方法内部的局部变量，或者使用sychronized锁

* HttpServlet常用方法

  | 方法                                                         | 说明                       |
  | ------------------------------------------------------------ | -------------------------- |
  | protected void doGet(HttpServletRequest req,HttpServletResponse resp) | 用户处理GETl类型的HTTP请求 |
  | protected void doPost(HttpServletRequest req,HttpServletResponse resp) | 用于处理POST类型的HTTP请求 |
  | protected void doPut(HttpServletRequest req,HttpServletResponse resp) | 用于处理PUT类型的HTTP请求  |

* 关系视图

  ![ServletDiagram](https://xingqiu-tuchuang-1256524210.cos.ap-shanghai.myqcloud.com/5809/ServletDiagram.png)



#### 3.Servlet生命周期

* 生命周期图示

  ![ServletLive](https://xingqiu-tuchuang-1256524210.cos.ap-shanghai.myqcloud.com/5809/ServletLive.png)

* Servlet生命周期大致分为三个阶段，分别是初始化阶段、运行阶段、销毁阶段

  1. 初始化阶段：

     当客户端向Servlet容器发出HTTP请求访问Servlet时，Servlet容器首先解析请求，检查内存中是否已经有了该Servlet对象，如果有，直接使用该Servlet对象；如果没有，就创建Servlet实例对象，然后通过调用init()方法完成Servlet初始化。需要注意，在Servlet整个生命周期内，它的**init()方法只被调用一次**

  2. 运行阶段：

     Servlet容器会为客户端请求创建代表HTTP请求的ServletRequest对象和代表HTTP响应的ServletResponse对象，然后将它们作为参数传递给Servlet的service()方法。service()方法从ServletRequest对象中获取客户端请求并处理该请求，通过ServletResponse对象生成响应结果。在Servlet整个生命周期内，对于Servlet的每一次访问请求，Servlet容器都会调用一次Servlet的service()方法，并且创建新的ServletRequest和ServletResponse对象。即**service()方法在Servlet整个生命周期中会被调用多次**

  3. 销毁阶段

     当服务器关闭或者Web应用被移除出容器时，Servlet随着Web应用的销毁而销毁。在销毁Servlet之前，Servlet容器会调用Servlet的destroy()方法，以便让Servlet对象释放它所占用的资源。在Servlet的整个生命周期中，**destroy()方法也只被调用一次**。注意，Servlet对象一旦创建就会驻留在内存中等待客户端的访问，直到服务器关闭或Web应用被移除出容器时Servlet对象才会销毁

#### 4.Servlet配置

* 使用web.xml配置Servlet

  1. 在web.xml文件中，通过`<servlet></servlet>`标签进行注册，&lt;servlet&gt;标签下包含若干个子元素，功能如下

     | 元素                                        | 类型   | 描述                                           |
     | ------------------------------------------- | ------ | ---------------------------------------------- |
     | &lt;servlet-name&gt;&lt;/servlet-name&gt;   | String | 指定Servlet名称，一般与Servlet类同名，要求唯一 |
     | &lt;servlet-class&gt;&lt;/servlet-class&gt; | String | 指定Servlet位置，一般是全类名                  |
     | &lt;description&gt;&lt;/description&gt;     | String | 指定Servlet的描述信息                          |
     | &lt;display-name&gt;&lt;/display-name&gt;   | String | 指定Servlet的显示名                            |

  2. 把Servlet映射到URL地址，使用`<servlet-mapping></servlet-mapping>`进行映射，在&lt;servlet-mapping&gt;元素下使用`<servlet-name></servlet-name>`指出Servlet的名称，需要和之前在&lt;servlet&gt;标签下注册的相同；使用`<url-pattern></url-pattern>`映射URL地址，地址前必须添加**/**

  3. 实例

     ```xml
     <servlet>
         <!--指出Servlet名称-->
         <servlet-name>ServletDemo01</servlet-name>
         <!--指出Servlet全类名-->
         <servlet-class>com.demo.ServletDemo01</servlet-class>
     </servlet>
     <servlet-mapping>
         <!--和servlet标签下的名称一致-->
         <servlet-name>ServletDemo01</servlet-name>
         <!--映射地址，必须加斜杠-->
         <url-pattern>/ServletDemo01</url-pattern>
     </servlet-mapping>
     ```
  
* 使用注解配置Servlet

  1. **@WebServlet**注解用于代替web.xml文件中的`<servlet>`、`<servlet-mapping>`等标签，该注解会在项目部署时被容器处理，容器会根据具体的属性配置将相应的类部署为Servlet，@WebServlet注解常用属性如下

  2. 常用属性

     | 属性声明                  | 功能                                                         |
     | ------------------------- | ------------------------------------------------------------ |
     | String name               | 指定Servlet的name属性，等价于&lt;servlet-name&gt;，如果没有显式指定则取值为类的全限定名 |
     | String[] value            | 等价于&lt;url-pattern&gt;                                    |
     | String[] urlPatterns      | 和value功能一样，value和urlPatterns不能同时使用              |
     | int loadOnStartup         | 指定Servlet的加载时机，等价于&lt;load-on-startup&gt;         |
     | WebInitParam[] initParams | 指定一组Servlet初始化参数，等价于&lt;init-param&gt;，其中WebInitParam也是一种注解 |

  3. 实例

     ```java
     @WebServlet(name = "ServletDemo01",urlPatterns = "/ServletDemo01",initParams = {@WebInitParam(name = "encoding",value = "UTF-8"),@WebInitParam(name = "desc",value = "this is ServletDemo01")})
     public class ServletDemo01 extends HttpServlet {
         @Override
         protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
             System.out.println("ServletDemo01运行了");
         }
     
         @Override
         protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
             doGet(req,resp);
         }
     }
     ```

#### 5.Servlet创建时机

* 第一次访问时创建

  优势：减少服务器内存的浪费

  弊端：如果有一些需要在应用加载时就做的初始化操作，无法完成

* 服务器加载时创建

  优势：提前创建好对象，提高首次执行时的效率，可以完成一些应用加载时要做的初始化工作

  弊端：对服务器内存占用较多，影响服务器启动效率

* 修改Servlet创建时机：在web.xml文件的&lt;servlet&gt;标签中添加`<load-on-startup></load-on-startup>`标签，标签中间填写的是整数，<font color="red">正整数表示在服务器加载时创建，值越小优先级越高，负整数或者不填表示第一次访问时创建</font>

#### 6.默认Servlet

* 默认Servlet是服务器提供的一个Servlet，它配置在Tomcat的conf目录中的web.xml文件中
* 它的映射路径是`<url-pattern>/</url-pattern>`，在接收请求时，首先会在项目中的web.xml文件查找映射配置，找到则执行，找不到时再去找默认的Servlet，由默认Servlet处理

### 二.ServletConfig

#### 1.概述

* ServletConfig是一个接口

* 当Tomcat初始化一个Servlet时，会将该Servlet的配置信息封装到一个ServletConfig对象中，通过调用init(ServletConfig config)方法将ServletConfig对象传递给Servlet，ServletConfig的生命周期与Servlet一样

* ServletConfig封装的配置信息是键值对的形式

* 常用方法

  | 方法                                 | 说明                                            |
  | ------------------------------------ | ----------------------------------------------- |
  | String getInitParameter(String name) | 根据参数名返回对应的参数值                      |
  | Enumeration getInitParameterNames()  | 返回一个Enumeration对象，其中包含了所有的参数名 |
  | ServletContext getServletContext()   | 返回代表当前web应用的ServletContext对象         |
  | String getServletName()              | 返回Servlet的名称                               |

#### 2.ServletConfig配置

* 配置ServletConfig也是在web.xml文件中的`<servlet></servlet>`标签下进行的，需要使用`<init-param></init-param>`标签将参数名和参数值包住，表示一个键值对，其中使用`<param-name></para-name>`表示参数名，`<param-value></param-value>`表示参数值

* 一个`<init-param></init-param>`只能表示一个键值对

* 范例

  ```xml
  <servlet>
      <servlet-name>ServletConfigDemo</servlet-name>
      <servlet-class>com.liaoxiangqian.ServletConfigDemo</servlet-class>
      <!--配置encoding参数，使用一个init-param标签-->
      <init-param>
          <param-name>encoding</param-name>
          <param-value>UTF-8</param-value>
      </init-param>
      <!--配置desc参数，使用一个init-param标签-->
      <init-param>
          <param-name>desc</param-name>
          <param-value>this is ServletConfigDemo</param-value>
      </init-param>
  </servlet>
  <servlet-mapping>
          <servlet-name>ServletConfigDemo</servlet-name>
          <url-pattern>/ServletConfigDemo</url-pattern>
  </servlet-mapping>
  ```

### 三.ServletContext

#### 1.概述

* Servlet容器启动时会为每个Web应用创建一个唯一的ServletContext对象代表当前Web应用，ServletContext对象**封装了当前Web应用的所有信息**
* ServletContext可以配置和获得应用的全局初始化参数，可以实现多个Servlet之间的数据共享
* 生命周期：应用加载则创建，应用停止则销毁

#### 2.ServletContext配置

* 在web.xml文件的`<web-app>`标签中，通过`<context-param>`标签来配置，其中他有两个子标签

* 子标签`<param-name>`表示全局初始化参数的key

* 子标签`<param-value>`表示全局初始化参数的value

* 范例

  ```xml
  <context-param>
      <param-name>globalEncoding</param-name>
      <param-value>UTF-8</param-value>
  </context-param>
  <context-param>
      <param-name>globaleDesc</param-name>
      <param-value>This is SevletContext</param-value>
  </context-param>
  ```

#### 3.ServletContext的三个作用

* 获取Web应用程序的初始化参数

  1. `Enumeration getInitParameterName()`方法用于返回包含所有参数名的Enumeration对象

  2. `String getInitParameter(String name)`方法用于根据参数名获取参数值

* 实现多个Servlet之间的数据共享

  | 方法名                                    | 说明                                                         |
  | ----------------------------------------- | ------------------------------------------------------------ |
  | Enumeration getAttributeNames()           | 返回包含所有域属性名的Enumeration对象                        |
  | Object getAttribute(String name)          | 根据域属性名返回域属性值                                     |
  | void removeAttribute(String name)         | 根据域属性名从ServletContext中删除对应的域属性               |
  | void setAttribute(String name,Object obj) | 设置ServletContext的域属性，其中name是域属性名，obj是域属性值 |

  注意：域属性指的就是可以共享的数据，即可以被多个Servlet访问到

* 读取Web应用下的资源文件

  * 实际开发中有时会需要读取Web应用中的一些资源文件，为此ServletContext接口定义了一些读取Web资源的方法，这些方法由依靠Servlet容器实现，可以根据资源文件相对Web应用的路径，返回关联资源文件的IO流、资源文件的绝对路径等

  * 相关方法

    | 方法名                                       | 说明                                                         |
    | -------------------------------------------- | ------------------------------------------------------------ |
    | Set getResourcePaths(String path)            | 返回一个Set集合，集合包含path指定路径下的**子目录名称**和**文件名称**但是不包含子目录下的文件名称，path以斜杠**/**开头表示Web应用的根目录 |
    | String getRealPath(String path)              | 返回资源文件在服务器文件系统上的真实路径，参数path表示资源文件相对Web应用的路径，以斜杠**/**开头表示Web应用的根目录，如果不能将虚拟路径转为真实路径则返回null |
    | URL getResource(String path)                 | 返回映射到某个资源文件的URL对象，参数必须以斜杠**/**开头表示Web应用的根目录 |
    | InputStream getResourceAsStream(String path) | 返回映射到某个资源文件的InputStream输入流对象，参数path的传递规则与getResource()一致 |

    总结：这四个方法中的path其实就是相对于Web应用的路径，以斜杠**/**开头

### 四.HttpServletRequest

#### 1.概述

* HttpServletRequest接口继承自ServletRequest接口
* HttpServletRequest专门用于封装HTTP请求消息
* HttpServletRequest提供了一些用于访问请求消息的方法，如获取请求行、获取请求头等

#### 2.相关方法

* 获取请求行信息

  1. `String getMethod()`，该方法用于获取HTTP请求消息中的请求方式，如**GET**或**Post**
  2. `String getRequestURI()`，该方法用于获取请求行中**资源名称**部分，即URL中主机名端口号之后和参数部分之前的部分
  3. `String getQueryString()`，该方法用于获取请求行中的参数部分，即资源路径**?**号后边的全部内容
  4. `String getProtocol()`，该方法用于获取请求行中的协议名和版本，如**HTTP/1.0**或**HTTP/1.1**
  5. `String getContextPath()`，该方法用于获取URL中Web应用程序的路径，以**/**开头，结尾没有斜杠
  6. `String getServletPath()`，该方法用于获取Servlet映射的路径或者Servlet的名称
  7. `String getRemoteAddr()`，该方法用于获取发送请求的客户端的IP地址
  8. `String getRemoteHost()`，该方法用于获取发送请求的客户端的完整主机名，如果解析不到则返回IP地址
  9. `int getRemotePort()`，该方法用于获取发送请求的客户端的端口号
  10. `String getLocalAddr()`，该方法用于获取Web服务器上接收当前请求的网络的IP地址
  11. `String getLocalName()`，该方法用于获取Web服务器上接收当前请求的网络的IP地址对应的主机名
  12. `int getLocalPort()`，该方法用于获取web服务器上接收当前网络连接的端口号
  13. `String getServerName()`，该方法用于获取当前请求所指向的主机名，即HTTP请求消息中Host字段所对应的主机名部分
  14. `String getServerPort()`，该方法用于获取当前请求所连接的服务器端口号，即HTTP请求消息中Host字段所对应的端口号部分
  15. `String getSchema()`，该方法用于获取请求的协议名，如HTTP或HTTPS
  16. `StringBuffer getRequestURL()`，该方法用于获取客户端发出请求时的完整URL，包括协议、服务器名、端口号、资源路径等，但不包括后面的查询参数部分，StringBuffer类型方便修改

  范例：

  ```java
  @WebServlet("/HttpServletRequestDemo")
  public class HttpServletRequestDemo extends HttpServlet {
      @Override
      protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
          String method = req.getMethod();
          System.out.println(method);
  
          String requestURI = req.getRequestURI();
          System.out.println(requestURI);
  
          String queryString = req.getQueryString();
          System.out.println(queryString);
  
          String protocol = req.getProtocol();
          System.out.println(protocol);
  
          String contextPath = req.getContextPath();
          System.out.println(contextPath);
  
          String servletPath = req.getServletPath();
          System.out.println(servletPath);
  
          String remoteAddr = req.getRemoteAddr();
          System.out.println(remoteAddr);
  
          String remoteHost = req.getRemoteHost();
          System.out.println(remoteHost);
  
          int remotePort = req.getRemotePort();
          System.out.println(remotePort);
  
          String localAddr = req.getLocalAddr();
          System.out.println(localAddr);
  
          String localName = req.getLocalName();
          System.out.println(localName);
  
          int localPort = req.getLocalPort();
          System.out.println(localPort);
  
          String serverName = req.getServerName();
          System.out.println(serverName);
  
          int serverPort = req.getServerPort();
          System.out.println(serverPort);
  
          String scheme = req.getScheme();
          System.out.println(scheme);
  
          StringBuffer requestURL = req.getRequestURL();
          System.out.println(requestURL);
      }
  
      @Override
      protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
          doGet(req,resp);
      }
  }
  ```

  输出结果：

  ![HttpServletRequestDemo](https://xingqiu-tuchuang-1256524210.cos.ap-shanghai.myqcloud.com/5809/HttpServletRequestDemo.png)
  
* 获取请求头信息相关方法

  1. `String getHeader(String name)`，该方法作用是获取请求头中指定名称字段的值，如果没有该字段则返回null，如果有多个该指定名称的字段，则返回第一个字段的值
  2. `Enumeration getHeaders(String name)`，返回一个Enumeration对象，该对象包含所有请求头中指定名称字段的值
  3. `Enumeration getHeaderName()`，返回一个包含所有请求头字段的Enumeration对象
  4. `int getIntHeader(String name)`，该方法获取一个指定请求头字段的值，并将该字段的值转为int类型再返回，如果该字段不存在则返回-1，如果该字段的值不能转为int类型则抛出NumberFormatException异常
  5. `long getDateHeaders(String name)`，该方法获取一个指定请求头字段的值，并将其转为一个代表日期/时间的长整数，这个长整数是1970年1月1日0时0分0秒算起到现在的毫秒值
  6. `String getContentType()`，获取Content-Type字段的值
  7. `int getContentLength()`，获取Content-Length字段的值
  8. `String getCharacterEncoding()`，获取请求消息的实体部分的字符集编码，通常从Content-Type字段中截取

  范例：

  ```java
  @WebServlet("/HttpServletRequestDemo")
  public class HttpServletRequestDemo extends HttpServlet {
      @Override
      protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
          Enumeration<String> headerNames = req.getHeaderNames();
          while(headerNames.hasMoreElements()){
              String s = headerNames.nextElement();
              System.out.println(s+":"+req.getHeader(s));
          }
      }
  
      @Override
      protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
          doGet(req,resp);
      }
  }
  ```

  输出结果:

  ![HttpServletRequestDemo01](https://xingqiu-tuchuang-1256524210.cos.ap-shanghai.myqcloud.com/5809/HttpServletRequestDemo01.png)

* 获取请求参数相关方法

  1. `String getParameter(String name)`，该方法获取指定名称参数的参数值，如果没有该参数则返回null，如果该参数没有设置值则返回空串，如果该参数有多个值则返回第一个
  2. `String getParameterValues(String name)`，该方法用于获取同一个参数名称的所有值
  3. `Enumeration getParameterNames()`，该方法用于返回包含所有参数名的Enumeration对象
  4. `Map getParameterMap()`，将参数名和参数值装入一个Map对象中返回

  范例:

  ```java
  @WebServlet("/HttpServletRequestDemo")
  public class HttpServletRequestDemo extends HttpServlet {
      @Override
      protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
          Enumeration<String> parameterNames = req.getParameterNames();
          while (parameterNames.hasMoreElements()) {
              String s = parameterNames.nextElement();
              String[] parameterValues = req.getParameterValues(s);
              System.out.println(s+":"+Arrays.toString(parameterValues));
          }
      }
  
      @Override
      protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
          doGet(req,resp);
      }
  }
  ```

  输出结果:

  ![HttpServletRequestDemo02](https://xingqiu-tuchuang-1256524210.cos.ap-shanghai.myqcloud.com/5809/HttpServletRequestDemo02.png)

#### 3.HttpServletRequest共享数据

* HttpServletRequest不仅可以获取一些列数据，还能通过属性共享、传递一些数据，比如运用在**请求转发**和**请求包含**中
* 相关方法
  1. `void setAttribute(String name,Object obj)`，用于定义一个属性，其中name是属性的名称，obj是属性值，如果原先已经存在相同名称的属性，则会将原来的属性删除再添加该属性，如果obj为null则会删除删除指定名称的属性
  2. `Object getAttribute(String name)`，根据属性名获取属性值
  3. `void removeAttribute(String name)`，删除指定名称的属性
  4. `Enumeration getAttributeNames()`，返回一个包含所有属性名的Enumeration对象
* 需要注意同一个请求中的数据才能共享、传递

#### 4.请求转发和请求包含

* 请求转发
  * Servlet之间可以相互跳转，如果某个Servlet的功能不能处理客户端的请求则可以使用跳转的方式将请求传递给另一个Servlet，由另一个Servlet完成并响应给客户端
  * 相关方法
    1. `RequestDispatcher getRequestDispatcher(String path)`，该方法由HttpServletRequest提供，用于获取一个封装了某条路径所指定资源的RequestDispatcher对象，路径必须以斜杠**/**开头，即该路径就是需要转发到的某个Servlet的路径
    2. `void forward(ServletRequest req,ServletResponse resp)`，该方法由RequestDispatcher提供，用于将请求转发给另一个Web资源，如某个Servlet
* 请求包含
  * 某个Servlet不能完全处理一个请求时可以将另一个Servlet“包含”进来，实现功能合并然后响应给客户端，这时浏览器的地址栏不会发送改变，被包含的Servlet的响应头会丢失，因为是由第一个Servlet做出响应的
  * 相关方法
    1. `RequestDispatcher getRequestDispatcher(String path)`，该方法根请求转发的相同，路径是需要包含的哪个Servlet的路径
    2. `void include(ServletRequest req,ServletResponse resp)`，该方法由RequestDispatcher提供，用于实现包含另一个Servlet的功能

#### 5.流对象获取数据

* `BufferedReader getReader()`，该方法获取一个字符输入缓冲流
* `ServletInputStream getInputStream()`，该方法获取一个字节输入流
* 注意这两个方法读取的数据来自**请求体**，所以使用GET方式获取不到数据，而POST方法可以

#### 6.中文乱码问题

* 在网页的表单中如果需要提交的数据存在中文时可能会出现乱码的情况
* HttpServletRequest提供了`void setCharacterEncoding(String name)`方法用于设置Request对象的解码方式
* GET方式提交的请求不会出现乱码的问题，但是POST方式存在乱码问题

### 五.HttpServletResponse

#### 1.概述

* HttpServletResponse接口继承自ServletResponse接口
* 用于封装HTTP响应消息
* HTTP响应消息分为响应行，响应头，响应体三部分，所以HttpServletResponse中定义了向客户端发送响应状态码、响应消息头、响应消息体等方法

#### 2.常见状态码

| 状态码 | 说明                         |
| ------ | ---------------------------- |
| 200    | 成功                         |
| 302    | 重定向                       |
| 304    | 请求资源未改变，使用缓存     |
| 400    | 请求错误，常见于请求参数错误 |
| 404    | 请求资源未找到               |
| 405    | 请求方式不支持               |
| 500    | 服务器错误                   |

#### 3.发送状态码的方法

1. `void setStatus(int status)`，设置响应消息的状态码，并生成响应状态行
2. `void sendError(int sc)`，发送表示错误信息的状态码
3. `void sendError(int sc,String message)`，设置表示错误的状态码外还向客户端发送一条错误信息，其中包含message的内容

#### 4.发送响应消息头的方法

1. `void addHeader(String name,String value)`，设置响应头指定名称字段的值，会覆盖掉原来该名称字段的值
2. `void setHeader(String name,String value)`，与addHeader()方法功能相同，但是不会覆盖原来的值而是添加一个值
3. `void setContentLength(int len)`，设置响应头的实体内容的大小，单位是字节
4. `void setContentType(String type)`，设置响应内容的类型，即Content-Type的值，并且响应内容为文本类型时还能指定字符集编码，如**text/html;charset=UTF-8**

#### 5.发送响应消息体的方法

1. `ServletOutputStream getOutputStream()`，用于获取字节输出流对象
2. `PrintWriter getWriter()`，用于获取输出流对象
3. 注意：在使用这些输出流时可能会出现乱码的情况，所以在使用输出流时可以使用`resp.setContentType("text/html;UTF-8");`来设置字符集编码，用来解决乱码问题

#### 6.请求重定向

* 请求重定向是指服务器接收到客户端请求后，可能由于某些条件限制，不能访问请求指定的资源，让客户端去访问另一个指定的资源
* HttpServletResponse定义了一个sendRedirect()方法，用于生成304响应状态码和Location响应头，从而通知客户端重新访问Location响应头中指定的URL
* 方法：`void sendRedirect(String location)`
* location可以使用相对路径重定向到同一个Web服务器的其他Servlet，也可以绝对路径重定向到其他Web服务器
* 注意：重定向时会重新生成另一个HttpServletRequest对象，所以不能实现Servlet的共享数据，如果需要共享数据那么可以使用请求转发

#### 7.设置缓存时间

* 对于不经常变化的数据，可以设置缓存时间减少频繁访问服务器，提高效率
* 使用`void setDateHeader(String name,long time)`方法来设置响应头
* 范例：`resp.setDateHeader("Expires",System.currentTimeMills+1*60*60*1000)`，设置缓存时间为1个小时

#### 8.设置定时刷新

* 定时刷新是指设置经过某个时间后自动跳转到某个页面
* 使用`void setHeader(String name,String value)`方法
* 范例：`resp.setHeader("Refresh","3;URL=/虚拟目录/demo.html");`

#### 8.文件下载

* 实现在浏览器中下载文件的功能，步骤如下：

  1. 创建字节输入流，关联读取的文件
  2. 设置响应消息头支持的类型
  3. 设置响应消息头以下载方式打开资源
  4. 通过响应对象获得字节输出流对象
  5. 循环读写
  6. 释放资源

* 范例

  ```java
  @WebServlet("/ServletDownloadDemo")
  public class ServletDownloadDemo extends HttpServlet {
      @Override
      protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
          //1. 创建字节输入流，关联读取的文件
          String realPath = getServletContext().getRealPath("/img/ServletLive.png");
          BufferedInputStream bis = new BufferedInputStream(new FileInputStream(realPath));
          //2. 设置响应消息头支持的类型
          //Content-Type是消息头名称，表示支持的类型
          //application/octet-stream是消息头参数，表示字节流
          resp.setHeader("Content-Type","application/octet-stream");
  
          //3. 设置响应消息头以下载方式打开资源
          //Content-Disposition是消息头名称，表示处理形式
          //attachment;filename=ServletLive.png是消息头参数，表示附件形式处理，filename表示文件名称
          resp.setHeader("Content-Disposition","attachment;filename=ServletLive.png");
  
          //4. 通过响应对象获得字节输出流对象
          ServletOutputStream outputStream = resp.getOutputStream();
          //5. 循环读写
          byte[] bytes = new byte[1024];
          int len;
          while((len = bis.read(bytes)) != -1){
              outputStream.write(bytes,0,len);
          }
          //6. 释放资源
          bis.close();
      }
  
      @Override
      protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
          doGet(req, resp);
      }
  }
  ```

### 六.会话技术

#### 1. 概述

* **会话**是指客户端和服务器之间的**多次请求和响应**
* 为了实现一些功能，浏览器和服务器可能会产生多次的请求和响应，从浏览器访问服务器开始，到访问服务器结束，这期间产生的多次请求和响应加在一起就称为浏览器和服务器之间的一次会话
* 为了保存会话过程中产生的数据，我们可以通过会话技术（Cookie和Session）来实现

#### 2.Cookie

* Cookie是一种会话技术，可以将会话过程中的数据保存在用户的**浏览器**中，从而使浏览器和服务器之间更好的进行数据交互

* Cookie是一个类，有一些属性和方法，用于设置Cookie

* 发送一个Cookie使用HttpServletResponse的`void addCookie(Cookie cookie)`方法，通过这个方法可以将Cookie添加到**响应头**中然后响应给浏览器

* 浏览器最多接收20个来自同一个网站的Cookie，并且浏览器只允许存放300个Cookie，每个Cookie的大小限制在4k以内

* 浏览器通过将Cookie添加到**请求头**中发送到服务器端，可以通过HttpServletRequest的`Cookie[] getCookie()`方法获取到一个Cookie数组，这些Cookie可能有相同的名称但是路径不同

* 构造方法`public Cookie(String name,String value)`，name属性一旦创建将不能更改，但是value可以更改

* Cookie常用属性

  | 属性    | 作用                     | 是否重要 |
  | ------- | ------------------------ | -------- |
  | name    | Cookie名称               | 必须属性 |
  | value   | Cookie的值（不支持中文） | 必须属性 |
  | path    | Cookie的路径             | 重要     |
  | domain  | Cookie的域               | 重要     |
  | maxAge  | Cookie存活时间           | 重要     |
  | version | Cookie版本号             | 不重要   |
  | comment | Cookie描述               | 不重要   |

* Cookie常用方法

  * Cookie常用方法是对Cookie相关属性的get或者set，但是需要注意name属性没有set方法
  * setMaxAge(int expirt)和getMaxAge()方法解析
    1. 这两个方法用于设置和返回Cookie在浏览器上保持的有效秒数，其中设置的值有如下规则
    2. 正整数表示在没有超过指定秒数之前这个Cookie会一直存在
    3. 负整数表示当浏览器关闭时Cookie信息会被清除
    4. 0表示浏览器会立即删除这个Cookie信息
    5. 默认是-1
  * setPath(String uri)和getPath()方法解析
    1. 这两个方法是针对path属性的设置和获取
    2. 如果创建的Cookie对象没有设置path属性的值，那么默认该Cookie只对**当前请求路径所属的目录以及子目录**有效
    3. 如果想让某个Cookie对象对站点的所有目录下的访问路径的都有效，那么可以设置为**"/"**
    4. 设置path的格式是**contextPath+自定义路径**
  * setDomain(String pattern)和getDomain()
    1. 这两个方法是针对domain属性的设置和获取，domain属性用于指定Cookie所在的域
    2. 默认为服务器主机地址，当浏览器想要访问该服务器的资源时会将该Cookie信息发送给服务器
    3. 如果想让不同的域之间都可以访问到某个Cookie，那么Cookie的domain应该是这些域的相同后缀，而且必须以**.**开头

#### 3.Session

* Session也是会话技术的一种，与Cookie不同的是，在客户端保存的是一个标识，而会话产生的数据保存在服务器端

* 当浏览器第一次请求服务器时，服务器会创建一个Session对象，该对象有唯一的一个标识，然后服务器将这个标识以Cookie的方式发送给浏览器

* 当浏览器再一次请求服务器时会将这个标识发送过来，服务器根据这个标识就可以找到对应的Session对象了

* Session也是域对象之一，可以实现数据共享

* 通过创建一个HttpSession对象来实现Session，HttpSession是一个接口，我们不直接创建这个对象而是服务器负责创建，我们使用的时候获取即可

* 获取方式：通过**HttpServletRequest**对象获取，有两个方法

  * `HttpSession getSession()`，获取HttpSession对象
  * `HttpSession getSession(boolean create)`，获取HttpSession对象，未获取到是否创建

* HttpSession常用方法

  | 方法                                        | 说明                                              |
  | ------------------------------------------- | ------------------------------------------------- |
  | String getID()                              | 返回与当前HttpSession对象关联的会话标识号         |
  | long getCreationTime()                      | 返回Session创建时间                               |
  | long getLastAccessedTime()                  | 返回客户端最后一次发送与Session相关请求的时间     |
  | void setMaxInactiveInterval(int interval)   | 用于设置当前Session对象可空闲的最长时间，单位为秒 |
  | boolean isNew()                             | 判断当前HttpSession对象是否是新建的               |
  | void invalidate()                           | 强制使Session对象无效                             |
  | ServletContext getServletContext()          | 返回当前HttpSession对象所属的ServletContext对象   |
  | void setAttribute(String name,Object value) | 存储一个指定名称的数据对象，可以用于共享          |
  | String getAttribute()                       | 用于从当前HttpSession对象中返回指定名称的属性值   |
  | void removeAttribute(String name)           | 用于从当前HttpSession对象中删除指定名称的属性值   |

* Session生命周期

  * Session生效

    1. Session在用户第一次访问服务器时创建
    2. 只有访问JSP、Servlet等程序时才会创建Sessin
    3. 只访问HTML、IMAGE等静态资源时不会创建Session

  * Session失效

    两种方式：

    1. Web服务器使用“超时限制”判断客户端是否还在继续访问。在一定时间内，如果某个客户端没有请求访问，那么Web服务器认为该客户端已经结束请求，并且与该客户端会话所对应的HttpSession对象会变成垃圾对象，等待垃圾收集器将其从内存中清除。如果超时后再次向服务器发出请求访问，那么Web服务器会创建一个新的HttpSession对象，并分配一个新的标识
    2. 使用`invalidate()`方法，可以强制使得Session失效

    设置失效时间：使用`setInactiveInterval(int interval)`方法可以设置Session最长的空闲时间，当超过这个时间客户端没有请求访问则Session失效

### 七.Filter

#### 1.概述

* Filter称为过滤器，位于客户端与处理程序之间，能够对请求和响应进行检查和修改

* 当客户端对服务器资源发送请求时，服务器根据过滤规则进行检查，如果满足过滤规则，则对客户请求进行拦截，然后对请求头或请求数据进行修改或检查，并依次通过Filter链，最后将请求交给处理程序

* 请求信息可以在过滤器中被修改，也可以根据请求条件不让请求发往处理程序

* 拦截过程

  ![Filter](https://xingqiu-tuchuang-1256524210.cos.ap-shanghai.myqcloud.com/5809/Filter.png)

#### 2.Filter接口

* 编写一个Filter必须实现Filter接口

* 相关方法

  | 方法名                                                       | 说明                                                         |
  | ------------------------------------------------------------ | ------------------------------------------------------------ |
  | default void init(FilterConfig filterConfig)                 | 创建Filter后用于初始化Filter，通过参数FilterConfig对象获取配置参数 |
  | void doFilter(ServletRequest var1, ServletResponse var2, FilterChain var3) | 用于完成过滤的操作，其中Request对象和Response对象是由上一个过滤器或者Web服务器传递过来的请求和响应对象，FilterChain对象代表当前过滤链对象 |
  | default void destroy()                                       | 用于释放过滤器中占用的资源，在对象被销毁之前调用             |

  * Filter接口提供了三个方法，其中init()方法和destroy()方法是默认方法不强制重写，而doFilter()方法是抽象方法，在实现Filter接口时必须重写

#### 3.Filter配置

* 配置Filter有两种方式，一种是通过web.xml文件进行配置，一种是通过@WebFilter注解进行配置

* web.xml配置方式

  ```xml
  <!--在web.xml文件的web-app标签下写入以下内容-->
  <filter>
      <filter-name>FilterDemo</filter-name>
      <filter-class>com.liaoxiangqian.filter.FilterDemo</filter-class>
  </filter>
  <filter-mapping>
      <filter-name>FilterDemo</filter-name>
      <url-pattern>/ServletDemo</url-pattern>
  </filter-mapping>
  ```

* @WebFilter注解配置方式

  ```java
  @WebFilter("/ServletDemo")
  public class FilterDemo implements Filter {
      @Override
      public void doFilter(ServletRequest servletRequest, ServletResponse servletResponse, FilterChain filterChain) throws IOException, ServletException {
          System.out.println("FilterDemo执行了");
      }
  }
  ```

  @WebFilter常用属性

  | 属性名          | 类型           | 说明                                                         |
  | --------------- | -------------- | ------------------------------------------------------------ |
  | filterName      | String         | 指定过滤器名称                                               |
  | urlPattren      | String[]       | 指定需要过滤的资源，如某个Servlet或Jsp                       |
  | value           | String[]       | 等价于urlPattern，不能同时使用                               |
  | servletNames    | String[]       | 指定过滤器将应用于哪些Servlet，取值是@WebServlet中name属性的取值 |
  | dispatcherTypes | DispatcherType | 指定过滤器转发模式，取值有ERROR、FORWARD、INCLUDE、REQUEST   |
  | initParams      | WebInitParam[] | 指定过滤器的一组初始化参数                                   |

  * 注意

    1. DispatcherType是枚举类，取值的作用如下：
    2. DispatcherType.ERROR表示过滤器拦截那些跳转到某个异常处理页面的请求
    3. DispatcherType.FORWARD表示过滤器拦截那些通过forward()方法来请求的转发的请求
    4. DispatcherType.INCLUDE表示过滤器拦截那些通过include()方法来请求包含的请求
    5. DispatcherType.REQUEST表示过滤器只会拦截普通的请求，而请求转发和请求包含类的请求不会拦截

  * 如果需要拦截用户的所有请求，则可以使用*号通配符，如

    ```xml
    <url-pattern>/*</url-pattern>
    ```

    ```java
    @WebFilter("/*")
    ```

#### 4.FilterConfig接口

* FilterConfig接口用于封装Filter的配置信息，在Filter初始化时，服务器将FilterConfig对象作为参数传递给Filter对象的init()方法

* FilterConfig相关方法

  | 方法名                               | 说明                                          |
  | ------------------------------------ | --------------------------------------------- |
  | String getFilterName()               | 获取Filter的名称                              |
  | ServletContent getServletContext()   | 获取ServletContext对象                        |
  | String getInitParameter(String name) | 根据名称获取初始化参数值                      |
  | Enumeration getInitParameterNames()  | 返回一个包含所有初始化参数名的Enumeration对象 |

* 配置初始化参数的方式

  * 在web.xml中配置，注意是在&lt;filter&gt;标签下方进行配置

    ```xml
    <init-param>
         <param-name>username</param-name>
         <param-value>liaoxiangqian</param-value>
    </init-param>
    ```

  * 在@WebFilter中使用initParams属性配置

    ```java
    @WebFilter(initParams = {@WebInitParam(name="username",value="liaoxiangqian")})
    ```

    注意initParams属性类型是注解型数组

* 添加初始化的参数后可以通过FilterConfig来获取这些参数

#### 5.FilterChain接口

* FilterChain对象表示当前过滤器所在的过滤链

* 一个Web应用程序中存在多个Filter，每个Filter都可以对某个请求进行拦截，如果多个Filter都对同一个请求进行拦截，那么这些Filter就组成一个Filter链，使用FilterChain对象表示

* 一个方法

  `void doFilter(ServletRequest var1, ServletResponse var2)`

  FilterChain提供的doFilter()方法，作用是让Filter链上的当前过滤器放行，使请求进入下一个Filter

#### 6.Filter生命周期

* Filter生命周期可以分为创建、执行、销毁三个阶段
* 创建阶段：Web服务器启动的时候会创建Filter对象，并调用init()方法，完成对象的初始化，在一次完整请求中Filter对象只会被创建一次，init()方法只会被调用一次
* 执行阶段：客户端发出请求时，服务器筛选出符合拦截条件的过滤器，按照类名的顺序依次执行doFilter()方法，doFilter()在一次完整请求中会执行多次
* 销毁阶段：服务器关闭时，Web服务器调用destroy()方法销毁对象

### 八.Listener

#### 1.概述

* Web程序开发中，可以对对象的创建和销毁、域对象中属性的变化、会话相关内容进行监听
* Servlet中提供八个监听器，都是以接口的形式提供，具体功能需要自行完善
* 相关概念
  1. 事件：触发的动作
  2. 事件源：产生事件的对象
  3. 事件监听器：监听发生在事件源上的事件
  4. 事件处理器：监听器的成员方法，事件发生时会触发该方法

#### 2.监听对象的创建和销毁的监听器

* ServletContextListener接口

  1. 用于监听ServletContext对象的创建与销毁

  2. 核心方法

     | 方法                                             | 说明                         |
     | ------------------------------------------------ | ---------------------------- |
     | void contextInitialized(ServletContextEvent sce) | ServletContext对象创建时执行 |
     | void contextDestroyed(ServletContextEvent sce)   | ServletContext对象销毁时执行 |

* HttpSessionListener接口

  1. 用于监听HttpSession对象的创建与销毁

  2. 核心方法

     | 方法                                     | 说明                      |
     | ---------------------------------------- | ------------------------- |
     | void sessionCreated(HttpSessionEvent se) | HttpSession对象创建时执行 |
     | void sessionDestroy(HttpSessionEvent se) | HttpSession对象销毁时执行 |

* ServletRequestListener接口

  1. 用于监听ServletRequest对象的创建与销毁

  2. 核心方法

     | 方法                                             | 说明                         |
     | ------------------------------------------------ | ---------------------------- |
     | void requestInitialized(ServletRequestEvent sre) | ServletRequest对象创建时执行 |
     | void requestDestroyed(ServletRequestEvent sre)   | ServletRequest对象销毁时执行 |

#### 3.监听域对象属性变化的监听器

* ServletContextAttributeListener接口

  1. 用于监听ServletContext中属性的变化

  2. 核心方法

     | 方法                                                      | 说明               |
     | --------------------------------------------------------- | ------------------ |
     | void attributeAdded(ServletContextAttributeEvent scae)    | 域中添加属性时执行 |
     | void attributeRemoved(ServletContextAttributeEvent scae)  | 域中移除属性时执行 |
     | void attributeReplaced(ServletContextAttributeEvent scae) | 域中替换属性时执行 |

* HttpSessionAttributeListener接口

  1. 用于监听HttpSession中属性的变化

  2. 核心方法

     | 方法                                               | 说明               |
     | -------------------------------------------------- | ------------------ |
     | void attributeAdded(HttpSessionBindingEvent se)    | 域中添加属性时执行 |
     | void attributeRemoved(HttpSessionBindingEvent se)  | 域中移除属性时执行 |
     | void attributeReplaced(HttpSessionBindingEvent se) | 域中替换属性时执行 |

* ServletRequestAttributeListener接口

  1. 用于监听ServletRequest中属性的变化

  2. 核心方法

     | 方法                                                      | 说明               |
     | --------------------------------------------------------- | ------------------ |
     | void attributeAdded(ServletRequestAttributeEvent srae)    | 域中添加属性时执行 |
     | void attributeRemoved(ServletRequestAttributeEvent srae)  | 域中移除属性时执行 |
     | void attributeReplaced(ServletRequestAttributeEvent srae) | 域中替换属性时执行 |

#### 4.监听会话相关的感知型监听器

* HttpSessionBindingListener接口

  1. 用于监听JavaBean对象绑定到HttpSession对像和从HttpSession对象解绑的事件

  2. 核心方法

     | 方法                                             | 说明                         |
     | ------------------------------------------------ | ---------------------------- |
     | void valueBound(HttpSessionBindingEvent event)   | 数据绑定(添加)到会话域时执行 |
     | void valueUnbound(HttpSessionBindingEvent event) | 数据从会话域解绑(移除)时执行 |

* HttpSessionActivationListener接口

  1. 用于监听HttpSession中对象活化(恢复到内存)和钝化(持久化到硬盘)的过程

  2. 核心方法

     | 方法                                           | 说明                   |
     | ---------------------------------------------- | ---------------------- |
     | void sessionWillPassivate(HttpSessionEvent se) | 会话域中数据钝化时执行 |
     | void sessionDidActivate(HttpSessionEvent se)   | 会话域中数据活化时执行 |

#### 5.监听器的实现

* 步骤

  1. 将监听器绑定到事件源，也就是注册监听器
  2. 监听器监听到事件发生时，将事件对象作为参数传给相关的成员方法
  3. 成员方法可以根据事件对象获取事件源，然后进行处理

* 注册监听器的方式有两种，一种是通过web.xml文件，一种是通过注解的方式

  1. 通过web.xml注册

     ```xml
     <!--<listener-class>标签中写的是监听器的实现类的全限定名类名-->
     <listener>
             <listener-class>com.liaoxiangqian.listener.MyListener</listener-class>
     </listener>
     ```

  2. 通过注解注册

     ```java
     //在监听器实现类上方使用该注解进行注册
     @WebListener
     ```

## JSP技术

### 一.概述

#### 1.JSP

* JSP(Java Server Pages)：是一种动态网页技术，是Servlet更高级别的扩展
* JSP文件中，HTML代码与Java代码共同存在，HTML用于实现静态内容的显示，Java用于动态内容的显示
* JSP文件会被Web服务器编译成一个Servlet，用于处理各种请求，然后将生成的网页响应给客户端

#### 2.运行原理

* 图示

  ![JSP](https://xingqiu-tuchuang-1256524210.cos.ap-shanghai.myqcloud.com/5809/JSP.png)

* 过程

  1. 客户端发送请求，请求访问JSP文件
  2. JSP容器将JSP文件转换成Java源文件（一个Servlet类），转换过程中发现语法错误会中断并向服务器和客户端返回出错信息，JSP容器本身也是一个Servlet
  3. 转换成功后，JSP容器继续将这个Java源文件编译成相应的字节码文件（.class），该字节码文件就是一个Servlet，Servlet容器会像处理其他Servlet一样来处理它
  4. Servlet容器根据这个字节码文件创建出一个Servlet实例，并执行jspInit()方法完成初始化，这个jspInit()在Servlet的整个生命周期中只会执行一次，这个Servlet实例会**常驻在内存中**
  5. JSP容器执行jspService()方法来处理客户端的请求，对于每个请求都会创建一个新的线程来处理它，多个客户端请求就会创建多个线程，每个线程对应每个客户端
  6. 如果JSP文件被修改，服务器根据设置会决定是否对该文件进行重新编译，如果重新编译则编译后的结果会取代内存中常驻的Servlet实例
  7. 由于系统资源不足等原因，JSP容器可能会以某种不确定的方式将Servlet实例从内存中移除，此时会调用jspDestroy()方法，然后Servlet实例被加入“垃圾收集”处理
  8. 请求处理完成后，响应的结果先由JSP容器接收，然后将HTML格式的信息发送回客户端

### 二.JSP语法

#### 1.JSP脚本元素

* JSP脚本元素是指嵌套在`<%`和`%>`中的一条或多条Java代码，通过JSP脚本元素来将Java代码嵌入HTML代码中，所有可以执行的Java代码都可以通过JSP脚本执行

* JSP脚本元素分为3种类型，JSP Scriptlets、声明标识、JSP表达式

* JSP Scriptlets

  1. JSP Scriptlets是一段Java代码，可以定义变量、控制流程语句等

  2. 可以使用JSP内置对象在页面输出内容

  3. JSP Scriptlets中的代码位于JSP文件转换成的Servlet类中的jspService()方法，所以不能在里边定义方法，而在里边定义的变量都是局部变量

  4. 除了定义局部变量还可以处理请求和访问Session会话等

  5. 范例

     ```jsp
     <%@ page contentType="text/html;charset=UTF-8" language="java" %>
     <html>
     <head>
         <title>第一个jsp页面</title>
     </head>
     <body>
         <h1>my first jsp page</h1>
         <%
             int a = 10;
             String s = "abc";
         %>
     </body>
     </html>
     ```

* 声明标识

  1. 在JSP Scriptlets中可以定义属性也可以输出内容，但是不能定义方法，但是使用声明就能实现方法的定义和成员变量的定义

  2. 声明标识中的内容是位于JSP转换成的Servlet类中的**成员位置**，所以可以定义成员方法、成员变量

  3. 在声明标识中定义的方法和变量可以被整个JSP页面访问，所以通常使用该标识定义整个JSP页面需要引用的变量或方法

  4. 语法格式

     ```jsp
     <%!
         定义成员变量或方法
     %>
     ```

  5. 在声明标识中是用于定义变量和方法的，**不能在此处用于输出内容**

* JSP表达式

  1. JSP表达式用于向页面输出信息

  2. 语法格式

     ```jsp
     <%= expression %>
     ```

     expression可以是java语言中任意完成的表达式，最终运算结果会被转化成字符串

  3. 实例

     ```jsp
     <%@ page contentType="text/html;charset=UTF-8" language="java" %>
     <html>
     <head>
         <title>jsp页面</title>
     </head>
     <body>
         <%!
             int a = 50;
             int b = 20;
         %>
         <%= a+b%>
     </body>
     </html>
     ```

#### 2.JSP注释

* JSP文件中如果需要注释Java代码，那么可以在Java代码处直接使用Java的注释语法

* JSP文件中如果需要注释HTML代码，那么可以在HTML代码处使用HTML的注释语法

* 使用HTML的注释后虽然在网页中看不到注释后的内容，但是通过查看源代码还是能看到注释信息的，这是因为Tomcat编译JSP文件时会将HTML注释当成普通文本发送给客户端

* JSP提供了一种**隐藏注释**，使用这种注释的内容不会在网页源代码中显示，语法格式如下

  ```jsp
  <%-- 注释内容 --%>
  ```

#### 3.JSP指令

* 为了设置JSP页面的一些信息，可以使用JSP指令，JSP中定义了page、include、taglib三种指令，每种指令都定义了各自的属性

* page指令

  1. 格式

     ```jsp
     <%@ page 属性名1="属性值1" 属性名2="属性值2" %>
     ```

  2. page常用属性如下

     | 属性名       | 取值范围              | 描述                                                         |
     | ------------ | --------------------- | ------------------------------------------------------------ |
     | language     | java                  | 指定jsp页面的脚本语言，默认为java                            |
     | import       | 任何包名、类名        | 指定jsp转换成Servlet类时需要引入的包或者类                   |
     | session      | true、false           | 指定jsp是否内置Session，如果true则内置Session对象，否则没有内置Session对象，默认为true |
     | isErrorPage  | true、false           | 指定该页面是否为错误处理页面，如果是true则该jsp页面内置一个Exception对象exception，可以直接使用，默认取值为false |
     | errorPage    | 某个jsp页面的相对路径 | 指定一个错误页面，如果该JSP页面抛出一个未捕获的异常，则转到这个属性指定的页面，指定的页面的isErrorPage取值为true并且内置的Exception对象就是这个未捕获的异常 |
     | contentType  | 有效的文档类型        | 指定当前jsp页面的MIME类型和字符编码，例如HTML格式为`text/html`、纯文本格式为`text/plain`、JPG图像为`image/jpeg`、GIF图像为`image/gif`、Word文档为`application/msword` |
     | pageEncoding | 当前页面              | 指定页面的编码格式                                           |

     注意以上属性中，只有**import**属性可以出现多次，一个import也可以引入多个类，中间用英文逗号隔开，而其他属性只能出现一次

  3. 范例

     ```jsp
     <%@ page language="java" contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>
     <%@ page import="java.util.*" %>
     <%@ page import="java.awt.*","java.util.*" %>
     ```

* include指令

  1. 格式

     ```jsp
     <%@ include file="被包含的文件路径" %>
     ```

  2. include指令用于包含另一个jsp页面，只有一个file属性，用于指定被包含的页面，使用的是**相对地址**，不以/开头

  3. 注意在被包含的页面中需要将html、body等标签去掉，因为当前页面已经存在这些标签

* taglib指令

  1. 格式

     ```jsp
     <%@ taglib prefix="tagPrefix" uri="tagURI" %>
     ```

  2. taglib指令用于标识该页面所使用的标签库，同时引用标签库并指定标签的前缀，引入标签库后就可以通过前缀来引用标签库中的标签

  3. 属性说明

     * prefix：用于指定标签前缀，不能命名为jsp、jspx、java、sun、servlet和sunw
     * uri：指定标签库文件的存放位置

  4. 引用JSTL中核心标签库的范例

     ```jsp
     <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
     ```

#### 4.动作元素

* 包含文件元素

  1. 语法

     ```jsp
     <jsp:include page="URL" flush="true|false" />
     ```

     page：需要引入的页面相对路径

     flush：是否将页面内容刷新到客户端，默认为false

  2. 原理

     * 页面1使用该动作元素将页面2包含，当浏览器第一次请求页面1时，Web容器会先编译页面2，然后将编译结果包含在页面1中，之后再编译页面1，最终将两个页面组合的结果回应给浏览器
     * flush属性为flase时，服务器会等页面完全实现后才返回给浏览器显示，而true时当缓存累积到一定数据时会先将部分页面返回给浏览器显示并等待后续内容，即是否自动刷新页面

  3. 与include指令的区别

     * include的file属性不支持jsp表达式，而&lt;jsp:include&gt;的page属性支持jsp表达式
     * include指令是将被包含的页面插入当前页面中再编译然后返回给浏览器，而&lt;jsp:include&gt;是将被包含的文件先编译返回给浏览器后再回到当前页面继续执行当前页面的内容
     * include指令包含页面是将两个页面合并在一起所以两个页面中的变量名和方法还有一些产生冲突的html标签不能产生冲突，而使用&lt;jsp:include&gt;时，因为每个文件是单独编译的，所以没有冲突问题

* 请求转发元素

  1. 语法

     ```jsp
     <jsp:forward page="relativeURL" />
     ```

     page：指定将请求转发到的页面的相对路径

  2. 原理

     * &lt;jsp:forward&gt;元素可以将当前请求转发到其他的Web资源，如HTML页面、JSP页面、Servlet等
     * 执行请求转发后当前页面将不再执行，但是地址栏中的资源路径不会改变

### 三.JSP隐式对象

#### 1.九大隐式对象

| 对象名      | 类型                                  | 说明                              |
| ----------- | ------------------------------------- | --------------------------------- |
| out         | javax.servlet.jsp.JspWriter           | 用于页面输出                      |
| request     | javax.servlet.http.HttpServletRequest | 请求信息                          |
| response    | javax.servlet.http.HttpServletRequest | 响应信息                          |
| config      | javax.servlet.ServletConfig           | 配置信息                          |
| session     | javax.servlet.http.HttpSession        | 会话信息                          |
| application | javax.servlet.ServletContext          | 站点信息                          |
| page        | java.lang.Object                      | 该页面转换成Servlet的实例         |
| pageContext | javax.servlet.jsp.PageContext         | JSP页面容器                       |
| exception   | java.lang.Throwable                   | JSP中页面的异常，在错误页中起作用 |

* JSP提供了上诉九个隐式（内置）对象，是JSP默认创建的，可以直接在JSP页面中使用
* request、response、config、session、application对象的细节在前文已述

#### 2.out对象

* out对象是javax.servlet.jsp.JspWriter类的实例，用于向页面输出内容

* out对象带有缓冲区，向页面中输出的内容会存入缓冲区中

* 只有调用了ServletResponse的getWriter()方法才会将out对象缓冲区的内容写入Servlet引擎(容器)提供的缓冲区中

* 图示如下

  ![out](https://xingqiu-tuchuang-1256524210.cos.ap-shanghai.myqcloud.com/5809/out.png)

* 范例

  代码:

  ```jsp
  <%@ page contentType="text/html;charset=UTF-8" language="java" %>
  <html>
  <head>
      <title>jsp页面</title>
  </head>
  <body>
      <%
          out.println("first line <br/>");
          response.getWriter().write("second line <br/>");
      %>
  </body>
  </html>
  ```

  输出结果:

  ![outdemo](https://xingqiu-tuchuang-1256524210.cos.ap-shanghai.myqcloud.com/5809/outdemo.png)

  分析:

  * out对象使用println()方法写入数据后，直到整个JSP页面结束，out对象中缓冲区的数据才写入Servlet引擎提供的缓冲区中
  * 而response.getWriter().write()方法直接将数据写入Servlet引擎缓冲区中，最后按照顺序输出

#### 3.pageContext对象

* pageContext对象是javax.servlet.jsp.PageContext类的实例对象，代表当前jsp页面的运行环境

* pageContext对象可以获取其他八个隐式对象

  | 方法                               | 说明                |
  | ---------------------------------- | ------------------- |
  | JspWriter getOut()                 | 获取out对象         |
  | Object getPage()                   | 获取page对象        |
  | ServletRequest getRequest()        | 获取request对象     |
  | ServletResponse getResponse()      | 获取response对象    |
  | HttpSession getSession()           | 获取session对象     |
  | Exception getException()           | 获取exception对象   |
  | ServletConfig getServletConfig()   | 获取Config对象      |
  | ServletContext getServletContext() | 获取application对象 |

* pageContext对象可以设置和获取数据从而实现共享数据，但是需要指定范围

  | 方法                                                  | 说明                                        |
  | ----------------------------------------------------- | ------------------------------------------- |
  | void setAttribute(String name,Object value,int scope) | 设置属性和对应的值，scope指定作用的范围     |
  | Object getAttribute(String name,int scope)            | 获取属性和对应的值，scope指定从哪个范围获取 |
  | void removeAttribute(String name,int scope)           | 从指定范围移除指定的属性                    |
  | void removeAttribute(String name)                     | 从所有范围移除指定的属性                    |
  | Object findAttribute(String name)                     | 从四个域中查找属性                          |

  * scpoe有四个取值，分别是

    **pageContext.PAGE_SCOPE**，表示当前页面范围

    **pageContext.REQUEST_SCOPE**，表示请求范围

    **pageContext.SESSION_SCOPE**，表示会话范围

    **pageContext.APPLICATION_SCOPE**，表示Web应用范围

  * findAttribute()方法从四个域中查找属性时顺序是page、request、session、application

* pageContext实现了在当前页面中获取四大域对象进行数据共享的功能

#### 4.四大域对象

| 域对象         | 范围                   |
| -------------- | ---------------------- |
| pageContext    | 最小，表示当前页面     |
| ServletRequest | 在请求转发时使用       |
| HttpSession    | 多次请求时使用         |
| ServletContext | 最大，整个应用都能使用 |

### 四.EL表达式

#### 1.概述

* JSP开发中为了获取域对象中的数据，需要书写很多Java代码，造成了页面混乱
* 使用EL表达式可以简化JSP开发中的对象引用，规范页面代码

#### 2.EL表达式基本语法

* 格式：

  ```jsp
  ${表达式}
  ```

  注意：如果需要再=在页面中显示“&{”，需要在前面加上符号“\”，即“\\${”，或者写成“&{&{}”

* 范例：

  ```jsp
  <%@ page contentType="text/html;charset=UTF-8" language="java" %>
  <html>
  <head>
  	<title>EL表达式</title>
  </head>
  <body>
      <%
        request.setAttribute("name","张三");
      %>
      <%--传统方式--%>
      <%=request.getAttribute("name")%>
      <%--使用EL表达式--%>
      ${name}
  </body>
  </html>
  ```

  注意：使用EL表达式获取域对象中的数据时，如果对象中没有该数据则返回空字符串，而Java代码会返回null从而报空指针异常

#### 3.EL访问数据

* 点运算符`.`

  ```jsp
  ${student.name}
  ```

* 中括号运算符`[]`

  ```jsp
  ${students[0]}
  ```

* 点运算符和中括号运算符主要是用来访问对象、数组、集合中的数据

* 某些属性名含有特殊符号时，只能用中括号运算符，如**${student["My-Name"]}**

* 点运算符和中括号运算符可以互换使用，也可以结合使用，如**${users[0].userName}**

* 范例

  ```jsp
  <%@ page contentType="text/html;charset=UTF-8" language="java" %>
  <html>
    <head>
      <title>EL表达式</title>
    </head>
    <body>
    
    <%--访问基本数据类型--%>
    <%request.setAttribute("age",18);%>
    ${age}
    
    <%--访问自定义类型数据--%>
    <%
      Student student = new Student("liaoxiangqian",21);
      request.setAttribute("student",student);
    %>
    ${student.name}<%--这里实际上是使用了student的getName()方法--%>
    
    <%--访问数组类型数据--%>
    <%
      int[] array = new int[]{1,2,3};
      request.setAttribute("array",array);
    %>
    ${array[0]}
    
    <%--访问List集合数据--%>
    <%
      ArrayList<String> list = new ArrayList<>();
      list.add("hello");
      list.add("JSP");
      request.setAttribute("list",list);
    %>
    ${list}
    ${list[1]}
  
    <%--访问Map集合数据--%>
    <%
      HashMap<String,String> map = new HashMap<>();
      map.put("map01","data01");
      map.put("map02","data02");
      request.setAttribute("map",map);
    %>
    ${map.map01}
    </body>
  </html>
  ```

* 注意：

  * EL表达式没有空指针异常，没有索引越界异常，没有字符串拼接
  * 如果出现空指针和索引越界，只会返回空字符串
  * 用“+”进行字符串拼接，会抛出异常

#### 4.EL运算符

* 算术运算符

  | 运算符   | 说明 | 表达式               |
  | -------- | ---- | -------------------- |
  | +        | 加   | ${10+2}              |
  | -        | 减   | ${10-2}              |
  | *        | 乘   | ${10*2}              |
  | /(或div) | 除   | ${10/2}或${10 div 2} |
  | %(或mod) | 取模 | ${10%2}或${10 mod 2} |

* 比较运算符

  | 运算符    | 说明     | 表达式                 |
  | --------- | -------- | ---------------------- |
  | ==(或 eq) | 等于     | ${10 == 2}或${10 eq 2} |
  | !=(或 ne) | 不等于   | ${10 != 2}或${10 ne 2} |
  | <(或 lt)  | 小于     | ${10 < 2}或${10 lt 2}  |
  | >(或 gt)  | 大于     | ${10 > 2}或${10 gt 2}  |
  | <=(或 le) | 小于等于 | ${10 <= 2}或${10 le 2} |
  | >=(或 ge) | 大于等于 | ${10 >= 2}或${10 ge 2} |

  注意：上述比较运算符输出结果为true或false

* 逻辑运算符

  | 运算符     | 说明   | 表达式                               |
  | ---------- | ------ | ------------------------------------ |
  | &&(或and)  | 逻辑与 | ${true && false}或${true and false}  |
  | \|\|(或or) | 逻辑或 | ${true \|\| false}或${true or false} |
  | !(或not)   | 逻辑非 | ${!true}或${not true}                |

* empty运算符

  * 格式

    ```jsp
    ${empty 变量/对象}
    ```

  * empty运算符用来判断一个对象或变量是否为空，这里的空是指空字符串、空指针null、空数组、空集合

* 三元运算符

  * 格式

    ```jsp
    ${true == false ? "a" : "b"}
    ```

  * 上式中“a”或“b”就是整个表达式的返回值

* 注意：上述的运算符可以通过括号运算符`()`来改变运算优先级

#### 5.EL隐式对象

* EL提供11个内置对象，无需创建可以直接使用

* 11个隐私对象如下

  | 对象名           | 说明                                                         |
  | ---------------- | ------------------------------------------------------------ |
  | pageContext      | 与JSP中的pageContext对象功能相同                             |
  | pageScope        | 保存page域中属性值的Map对象                                  |
  | requestScope     | 保存request域中属性值的Map对象                               |
  | sessionScope     | 保存session域中属性值的Map对象                               |
  | applicationScope | 保存application域中属性值的Map对象                           |
  | param            | 保存了所有请求参数的Map对象                                  |
  | paramValues      | 保存了所有请求参数的Map对象，一个参数对应一个String类型数组  |
  | header           | 保存了所有HTTP请求头字段的Map对象                            |
  | headerValues     | 保持了所有HTTP请求头字段的Map对象，一个字段对应一个String类型数组 |
  | cookie           | 获取cookie的值，类型是Map                                    |
  | initParam        | 保存了所有Web应用初始化参数的Map对象                         |

  注意：不要和JSP中的隐式对象混淆，只有pageContext是相同的，其他的没有关系

* pageContext对象

  * 可以使用pageContext对象来获取JSP页面中的其他8个隐私对象

  * 范例

    ```jsp
    ${pageContext.request.getAttribute("username")}
    <%--相当于--%>
    <%=request.getAttribute("username")%>
    ```

* 域相关对象

  * 域相关对象是指**pageScope、requestScope、sessionScope、applicationScope**这四个对象

  * 这四个对象与JSP隐式对象中的page、request、session、application相似

  * 这四个对象主要用于从它们对应的域中取出相关的属性值，而不采用默认的查找顺序去取值，如

    ```jsp
    <%--username是request域中的属性名--%>
    ${username}<%--这是默认的方式--%>
    ${requestScope.username}<%--这是用隐式对象的方式--%>
    ```

  * 如果不使用隐式对象而使用默认的方式会按照page、request、session、application的顺序查找

* 访问环境信息的隐式对象

  * 访问环境信息的隐式对象有**param、paramValues**
  * 这两个对象用于获取表单信息中提交的成对参数，其中paramValues是用于获取一个参数对应的多个参数值

* 访问HTTP请求头字段的对象

  * 获取HTTP请求头字段的对象有**header、headerValues**
  * 这两个对象用于根据头字段的参数，获取参数对应的值，其中headerValues是用于获取一个头字段的多个值

* cookie对象

  * cookie对象用于获取Cookie中的信息，然后存入一个Map集合中，其中键是Cookie的名称，值为Cookie对象

  * 范例

    ```jsp
    ${cookie.username}<%--返回的是一个Cookie对象，在页面中显示的是这个Cookie对象的地址--%>
    ${cookie.username.name}<%--返回的是Cookie对象的name属性的值--%>
    ${cookie.username.value}<%--返回的是Cookie对象的value属性的值--%>
    ```

* initParam对象

  * initParam对象用于获取Web应用初始化参数的值

  * 范例

    在web.xml文件中存在一个初始化参数：

    ```xml
    <context-param>
        <param-name>author</param-name>
        <param-value>liaoxiangqian</param-value>
    </context-param>
    ```

    jsp文件中使用initParam对象获取author这个参数的值

    ```jsp
    ${initParam.author}<%--在页面中会输出liaoxiangqain--%>
    ```

### 五.JSTL

#### 1.概述

* 使用JSTL可以取代传统JSP开发中嵌入Java代码的做法，提高程序可维护性
* 需要使用taglib指令定义引用标签库和访问前缀
* 包含5类标准标签库，分别是核心标签库、国际化/格式化标签库、SQL标签库、XML标签库、函数标签库
* 使用JSTL需要下载相关Jar包然后导入项目

#### 2.核心标签库

* 使用核心标签库的taglib指令如下

  ```jsp
  <%@ taglib prefix="c" url="http://java.sun.com/jsp/jstl/core" %>
  ```

* &lt;c:out&gt;标签

  ```jsp
  <%--无标签体--%>
  <c:out value="value" [default="defaultValue"] [escapeXml="{true|false}"] />
  <%--有标签体--%>
  <c:out value="value" [escapeXml="{true|faslse}"]>
      defaultValue
  </c:out>
  ```

  * &lt;c:out&gt;标签用于向页面输出信息
  * value指定输出的文本内容，也可以是EL表达式
  * default指定value为null时的输出内容，是可选的属性(方括号属性是可选的)，
  * escapeXml属性用于指定特殊字符是否进行HTML编码后输出，默认为true

* &lt;c:remove&gt;标签

  ```jsp
  <c:remove var="name" [scope="范围"]>
  ```

  * &lt;c:remove&gt;标签用于移除指定JSP范围内的变量
  * var指定要移除的变量名
  * scope指定范围，可选值有page、request、session、application，默认为page

* &lt;c:if&gt;标签

  ```jsp
  <%--没有标签体--%>
  <c:if test="testCondition" var="result" [scope="{page|request|session|application}"] />
  <%--有标签体--%>
  <c:if test="testCondition" var="result" [scope="{page|request|session|application}"]>
      body content
  </c:if>
  ```

  * &lt;c:if&gt;标签用于条件判断
  * test属性是需要判断的逻辑表达式
  * var用于指定逻辑表达式的变量名字
  * scope指定var的作用范围，默认为page

* &lt;c:choose&gt;标签、&lt;c:when&gt;标签、&lt;c:otherwise&gt;标签

  ```jsp
  <c:choose>
      <c:when test="testCondition">
          body content
      </c:when>
      <c:when test="testCondition">
          body content
      </c:when>
      <c:otherwise>
          body content
      </c:otherwise>
  </c:choose>
  ```

  * 这三个标签类似多重if语句
  * 当when中的test属性返回值是true时对应的语句执行，只有所有的when都不匹配时才会执行otherwise中的内容

* &lt;c:forEach&gt;循环标签

  ```jsp
  <c:forEach [var="varName"] items="collection" [varStatus="varStatusName"] [begin="begin"] [end="end"] [step="steo"] >
      body content
  </c:forEach>
  ```

  * &lt;c:forEach&gt;循环标签用于迭代集合的操作
  * var表示当前迭代到的元素保存到page中的名称
  * items指定迭代的集合
  * varStatus用于指定将当前迭代状态信息对象保存到page中的名称
  * begin，end用于指定迭代始末
  * step指定迭代步长

