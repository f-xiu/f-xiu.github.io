#### v5-v6对比

[React路由ReactRouter6_确实菜，真的爱的博客-CSDN博客_reactrouter6](https://blog.csdn.net/qq_39307266/article/details/123117513?ops_request_misc=%7B%22request%5Fid%22%3A%22166044598916781432959838%22%2C%22scm%22%3A%2220140713.130102334.pc%5Fall.%22%7D&request_id=166044598916781432959838&biz_id=0&utm_medium=distribute.pc_search_result.none-task-blog-2~all~first_rank_ecpm_v1~pc_rank_v36-10-123117513-null-null.142^v40^pc_rank_v36,185^v2^control&utm_term=react 路由跳转 navigate&spm=1018.2226.3001.4187)



#### 快速开始

1. `<BrowserRouter>`是在 Web 浏览器中运行 React Router 的推荐接口

   （就像一个Context的provider那样，整个全局都可以使用。）

```
import ReactDOM from "react-dom/client";
import { BrowserRouter } from "react-router-dom";
import App from "./App";

const root = ReactDOM.createRoot(
  document.getElementById("root")
);
root.render(
  <BrowserRouter>
    <App />
  </BrowserRouter>
);
```

2. 打开，导入并添加一些全局导航。

```
import { Link } from "react-router-dom";

export default function App() {
  return (
    <div>
      <h1>Bookkeeper</h1>
      <nav
        style={{
          borderBottom: "solid 1px",
          paddingBottom: "1rem",
        }}
      >
        <Link to="/invoices">Invoices</Link> |{" "}
        <Link to="/expenses">Expenses</Link>
      </nav>
    </div>
  );
}
```

​				Link正在更改URL而不会导致整个页面重新加载。



3. 第一个“Route Config”，在 不同的 URL 上呈现我们的应用程序。

```
import ReactDOM from "react-dom/client";
import {
  BrowserRouter,
  Routes,
  Route,
} from "react-router-dom";
import App from "./App";
import Expenses from "./routes/expenses";
import Invoices from "./routes/invoices";

const root = ReactDOM.createRoot(
  document.getElementById("root")
);
root.render(
  <BrowserRouter>
    <Routes>
      <Route path="/" element={<App />} />
      <Route path="expenses" element={<Expenses />} />
      <Route path="invoices" element={<Invoices />} />
    </Routes>
  </BrowserRouter>
);
```

#### `<Routes>`

Routes 是用来包住路由访问路径(Route)的。它决定用户在浏览器中输入的路径到对应加载什么 React 组件，因此绝大多数情况下，Routes 的唯一作用是用来包住一系列的 `Route`，比如如下

在这里，Routes 告诉了 React Router 每当用户访问根地址时，加载 `Home` 这个页面，而当用户访问 `/about` 时，就加载 `<About />` 页面。

```
import { Routes, Route } from "react-router-dom";

function App() {
  return (
    <Routes>
      <Route path="/" element={<Home />} />
      <Route path="/about" element={<About />} />
    </Routes>
  );
}
```

匹配的路由渲染的组件会在`Routes`处。



#### 路由匹配

`<Route>` 组件有如下属性：

| 属性   | 说明                                                         | 类型   |
| ------ | ------------------------------------------------------------ | ------ |
| index  | 路由默认匹配，可以不设置path,或者path=''                     |        |
| path   | 路由匹配路径（没有 `path` 属性的 `<Route>` 总是会匹配）      | string |
| exact  | 为 `true` 时，则要求路径与 `location.pathname` 必须**完全匹配** | bool   |
| strict | 为 `true` 的时候，有**结尾斜线**的路径只能匹配有斜线的       | bool   |

* path='*',当其他的无法匹配时，匹配该route。
* 一个匹配上了就不会再向下匹配。
* 可以不写'/',如果写'/'需要注意路径的完整性（整个路径名）



`<Link>`的to,如果没有'/'开头，则是一个相对值

`<NavLink>`是对`<Link>`的一个封装,在选择该link,可以根据isActive判断是否选中。

```
 <NavLink to="/about" className={({isActive})=>isActive ? "myActive":""}>About</NavLink>
```



#### 嵌套路由

```
 <BrowserRouter>
    <Routes>
      <Route path="/" element={<App />}>
        <Route path="expenses" element={<Expenses />} />
        <Route path="invoices" element={<Invoices />} />
      </Route>
    </Routes>
 </BrowserRouter>
```

##### `<Outlet>`

在父路由中使用，用做一个占位符，子路由如果匹配到则在这里渲染。



#### 参数传递

##### params参数

在path中:加上参数`/:id/:title`（声明接收）

在to中:加上参数`/{id}/{title}`(传递params参数)

useParams();可以直接获得传递过来的参数。



##### search参数

不需要再path中占位(声明)。

在to中:?id=${}&title=${}  (形式与query相似)

useSearchParams();返回的并不是一个对象，需要用数组结构出来（与useState相似）

```
const [search,setSearch]=useSearchParmas()

const id=search.get('id');

const title=search.get('title');

```

setSearch的作用是用来更新search。

```
setSearch('id=008&title='haha');
```

​		更新后



##### state参数

path中仍不需要占位。

想要传递state参数则是直接state={}。

useLocation()获得的对象中，有state对象。

```
<NavLink 
    to={`detail`} 
    state={{
      id:item.id,
      name:item.name,
      content: item.content
    }}
>{item.name}</NavLink>

如果使用navigate


  navigate('detail',{
      replace:false,
      state:{
        id: item.id,
        title: item.title,
        content: item.content
      }
    })

接收：
  const {state:{id,name,content}} = useLocation()
```





#### 编程式路由导航

上述`<Link>`和`<NavLink>`是声明式路由导航。

在router-v5中是通过history,路由组件this有history,

```
const navigate=useNavigate();

navigate('/about');

navigate('detail',{});
//如果是search或者params参数则直接跟在路径后边
//第二个参数为配置对象,想要传递参数只能是state
//也可以设置replace，history总不是压入，而是代替
```

通过navigate(-1)后退,navigate(1)前进。

#### 重定向Navigate

元素在呈现时会更改当前位置。它是围绕 [`useNavigate`](https://reactrouter.com/docs/en/v6/hooks/use-navigate) 的组件包装器，并接受所有与 props 相同的参数。`<Navigate>`

例如：

```
  <Navigate to="/dashboard" replace={true} />
  
  <Route path="/" element={<Navigate to="/about"/>}></Route>
```





#### Hooks

##### useRoutes

路由表:一个数组集中管理路由的关系。

```
import * as React from "react";
import { useRoutes } from "react-router-dom";

function App() {
  let element = useRoutes([
    {
      path: "/",
      element: <Dashboard />,
      children: [
        {
          path: "messages",
          element: <DashboardMessages />,
        },
        { path: "tasks", element: <DashboardTasks /> },
      ],
    },
    { path: "team", element: <AboutPage /> },
  ]);

  return element;
}
```

使用：用一个文件专门写路由规则，之后再引入到具体的地方。



