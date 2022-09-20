具有 render prop 的组件接受一个返回 React 元素的函数，并在组件内部通过调用此函数来实现自己的渲染逻辑。

```
通过在组件内部调用此函数，就可以得到组件内部的state等等
<DataProvider render={data => (
  <h1>Hello {data.target}</h1>
)}/>
```

类似于Route:`<Route path='' element={< />} />`,但是通过传参的方式，使得ui可以改变。

**render prop 是一个用于告知组件需要渲染什么内容的函数 prop。**

一个有趣的事情是你可以使用带有 render prop 的常规组件来实现大多数[高阶组件](https://zh-hans.reactjs.org/docs/higher-order-components.html) (HOC)

你不一定要用名为 `render` 的 prop 来使用这种模式



当然默认的props有children prop,而且其写法可以是在<>{children prop}</>,这样嵌套关系更明显，而且也可已通过函数的形式给子组件传递props,可传递的参数当然包括父组件的state。



尽管之前的例子使用了 `render`，我们也可以简单地使用 `children` prop！

```
<Mouse children={mouse => (
  <p>鼠标的位置是 {mouse.x}，{mouse.y}</p>
)}/>
```

记住，`children` prop 并不真正需要添加到 JSX 元素的 “attributes” 列表中。相反，你可以直接放置到元素的*内部*！

```
<Mouse>
  {mouse => (
    <p>鼠标的位置是 {mouse.x}，{mouse.y}</p>
  )}
</Mouse>
```



因为浅比较 props 的时候总会得到 false，并且在这种情况下每一个 `render` 对于 render prop 将会生成一个新的值。

