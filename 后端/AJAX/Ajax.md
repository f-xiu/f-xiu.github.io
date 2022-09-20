# 一.概述

* Ajax(Asynchronous JavaScript and XML,异步的JavaScript和XML)技术可以实现页面的**局部更新**

* 传统请求方式是在页面跳转或页面刷新时发出请求，每次发出请求都会请求一个新的页面，即使刷新也是重新加载本页面

* Ajax异步请求方式不同于传统的方式，通过Ajax异步请求方式向服务器发出请求，得到数据后再更新页面（通过DOM操作修改页面），整个过程不发生页面跳转或刷新操作

* 传统方式与Ajax异步请求的对比

  | 方式             | 协议 | 请求发出方式                     | 数据展示方式                        |
  | ---------------- | ---- | -------------------------------- | ----------------------------------- |
  | 传统请求方式     | HTTP | 页面链接跳转                     | 重新载入新页面                      |
  | Ajax异步请求方式 | HTTP | 由**XMLHttpRequest**实例发出请求 | JavaScript和DOM技术把数据更新到页面 |

  Ajax优势：

  * 请求数据量少：只需请求必要数据，对不需更新的数据不做请求
  * 请求分散：按需请求，异步的形式，在任意时刻发出，所以请求不会集中爆发
  * 用户体验优化：响应时间短，速度快

* 使用JavaScript可以实现Ajax，但是代码复杂需要考虑到浏览器兼容问题

* jQuery二次封装了JavaScript，同时对Ajax操作进行了整理和封装，简化了Ajax操作

# 二.实现方式

## 1.使用GET方式实现Ajax

* 语法

  ```javascript
  $.get(url,data,function(data,status,xhr),datatype)
  ```

  * 该方法由jQuery提供，其中参数含义如下

    | 参数                      | 说明                                                         |
    | ------------------------- | ------------------------------------------------------------ |
    | url                       | 必选，规定加载资源的路径                                     |
    | data                      | 可选，发送至服务器的数据                                     |
    | function(data,status,xhr) | 可选，请求成功时执行的函数，data表示从服务器返回的数据，status表示请求的状态值，xhr表示当前请求相关的XMLHttpRequest对象 |
    | datatype                  | 可选，预期的服务器响应的数据类型（xml,html,text,script,json,jsonp） |

* 范例

  ```html
  <!DOCTYPE html>
  <html lang="en">
  <head>
      <meta charset="UTF-8">
      <title>Ajax练习</title>
  </head>
  <body>
      <label for="username">姓名</label>
      <input type="text" id="username">
      <label for="password">密码</label>
      <input type="password" id="password">
      <input type="button" id="btn" value="登录">
      <div id="div"></div>
  </body>
  <script src="js/jquery-3.3.1.min.js"></script>
  <script>
      $("#btn").on("click",function(){
          let username = $("#username").val();
          let password = $("#password").val();
          $.get(
              "AjaxServlet",
              {"username":username,"password":password},
              function(data){
                  $("#div").html(data);
              },
              "html"
          );
      });
  </script>
  </html>
  ```

  ```java
  @WebServlet("/AjaxServlet")
  public class AjaxServlet extends HttpServlet {
      @Override
      protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
          String username = req.getParameter("username");
          String password = req.getParameter("password");
          resp.setContentType("text/html;charset=UTF-8");
          resp.getWriter().write("<h1>"+username+"</h1>");
          resp.getWriter().write("<h1>"+password+"</h1>");
      }
  
      @Override
      protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
          doGet(req, resp);
      }
  }
  ```

## 2.使用POST方式实现Ajax

* POST方式实现的Ajax与GET方式类似，只是方法名不同，为`$.post()`

## 3.使用通用方式实现Ajax

* 通用的方式是使用`$.ajax()`方法来实现Ajax

* 上述的GET和POST方式使用到的方法都是通过封装了这个`$.ajax()`方法来实现

* 语法

  ```javascript
  $.ajax({name:value,name:value....})
  ```

  * ajax方法的参数是一对`{}`包起来的键值对

* 该方法的常用参数（键）如下

  | 参数                       | 说明                                                         |
  | -------------------------- | ------------------------------------------------------------ |
  | url                        | 请求的路径                                                   |
  | async                      | 是否异步，true或false，默认为true                            |
  | data                       | 发送到服务器的数据                                           |
  | type                       | 请求的方式，POST或GET，默认是GET                             |
  | dataType                   | 预期的服务器响应的数据类型（xml,html,text,script,json,jsonp） |
  | success(result,status,xhr) | 请求成功是执行的方法                                         |
  | error(xhr,status,error)    | 请求失败时执行的方法                                         |

* 范例

  ```html
  <!DOCTYPE html>
  <html lang="en">
  <head>
      <meta charset="UTF-8">
      <title>Ajax练习</title>
  </head>
  <body>
      <label for="username">姓名</label>
      <input type="text" id="username">
      <label for="password">密码</label>
      <input type="password" id="password">
      <input type="button" id="btn" value="登录">
      <div id="div"></div>
  </body>
  <script src="js/jquery-3.3.1.min.js"></script>
  <script>
      $("#btn").on("click",function(){
          let username = $("#username").val();
          let password = $("#password").val();
          $.ajax({
              url:"AjaxServlet",
              data:{
                  "username":username,
                  "password":password
              },
              dataType:"text",
              success:function(data){
                  $("#div").html(data);
              }
          });
      });
  </script>
  </html>
  ```

  ```java
  @WebServlet("/AjaxServlet")
  public class AjaxServlet extends HttpServlet {
      @Override
      protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
          String username = req.getParameter("username");
          String password = req.getParameter("password");
          resp.setContentType("text/html;charset=UTF-8");
          resp.getWriter().write("<h1>"+username+"</h1>");
          resp.getWriter().write("<h1>"+password+"</h1>");
      }
  
      @Override
      protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
          doGet(req, resp);
      }
  }
  ```

# 三.JSON补充知识

* JavaScript笔记中只基本了解了JSON

## 1.转换工具

* Jackson：开源免费的JSON转换工具，通过Java封装好的一些jar工具包
* 可以将Java对象或集合转换成JSON格式的字符串，也可以将JSON格式的字符串转换成Java对象
* 需要引入相关jar包

## 2.常用类以及方法

* 常用类

  | 类名          | 说明                                                         |
  | ------------- | ------------------------------------------------------------ |
  | ObjectMapper  | jackon工具包的核心类，提供一些方法实现json字符串和对象之间的转换 |
  | TypeReference | 用于指定反序列化的对象类型                                   |

* ObjectMapper常用方法

  | 方法名                                                      | 说明                                                         |
  | ----------------------------------------------------------- | ------------------------------------------------------------ |
  | String writeValueAsString(Object obj)                       | 将Java对象转为json字符串                                     |
  | &lt;T&gt; T readValue(String json,Class&lt;T&gt; valueType) | 将json字符串转为Java对象，用于对象类型为内置类型             |
  | &lt;T&gt; T readValue(String json,TypeReference valueType)  | 将json字符串转为Java对象，用于对象类型为含有自定义类型数据的集合类 |

## 3.范例

User类：

```java
public class User {
    private String name;
    private int age;

    public User(){}

    public User(String name, int age) {
        this.name = name;
        this.age = age;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public int getAge() {
        return age;
    }

    public void setAge(int age) {
        this.age = age;
    }

    @Override
    public String toString() {
        return "User{" +
                "name='" + name + '\'' +
                ", age=" + age +
                '}';
    }
}
```

使用范例1：

```java
@Test
public void test01() throws IOException {
    //将User对象转为json字符串
    User user = new User("张三",23);
    ObjectMapper objectMapper = new ObjectMapper();
    String s = objectMapper.writeValueAsString(user);
    System.out.println(s);
    //将json字符串转为User对象
    User user1 = objectMapper.readValue(s, User.class);
    System.out.println(user1);
}
```

使用范例2：

```java
@Test
public void test02() throws IOException{
    //将Map对象转为json字符串
    HashMap<String,String> map = new HashMap<>();
    map.put("name","张三");
    map.put("gender","男");
    ObjectMapper objectMapper = new ObjectMapper();
    String s = objectMapper.writeValueAsString(map);
    System.out.println(s);
    //将json字符串转为Map对象
    HashMap<String,String> hashMap = objectMapper.readValue(s, HashMap.class);
    System.out.println(hashMap);
}
```

使用范例3：

```java
@Test
public void test03() throws IOException{
    //将包含自定义对象的Map对象转为json字符串
    HashMap<String,User> map = new HashMap<>();
    map.put("1号",new User("张三",23));
    map.put("2号",new User("李四",24));
    ObjectMapper objectMapper = new ObjectMapper();
    String s = objectMapper.writeValueAsString(map);
    System.out.println(s);
    //将json字符串转为包含自定义对象的Map对象
    HashMap<String,User> hashMap = objectMapper.readValue(s,new TypeReference<HashMap<String,User>>(){});
    System.out.println(hashMap);
}
```

使用范例4：

```java
@Test
public void test04() throws IOException{
    //将List对象转为json字符串
    ArrayList<String> list = new ArrayList<>();
    list.add("张三");
    list.add("李四");
    ObjectMapper objectMapper = new ObjectMapper();
    String s = objectMapper.writeValueAsString(list);
    System.out.println(s);
    //将json字符串转为List对象
    ArrayList<String> arrayList = objectMapper.readValue(s, ArrayList.class);
    System.out.println(arrayList);
}
```

使用范例5：

```java
@Test
public void test05() throws IOException{
    //将含有自定义对象的List对象转为json字符串
    ArrayList<User> list = new ArrayList<>();
    list.add(new User("张三",23));
    list.add(new User("李四",24));
    ObjectMapper objectMapper = new ObjectMapper();
    String s = objectMapper.writeValueAsString(list);
    System.out.println(s);
    //将json字符串转为含有自定义对象的List对象
    ArrayList<User> arrayList = objectMapper.readValue(s,new TypeReference<ArrayList<User>>(){});
    System.out.println(arrayList);
}
```

