react的官网 Portal 提供了一种将子节点渲染到存在于父组件以外的 DOM 节点的优秀的方案

[Portals - React Guidebook (tsejx.github.io)](https://tsejx.github.io/react-guidebook/foundation/advanced-guides/portals#模态窗)

```
Modal模态框的渲染
我们需要将一个模态框渲染到body下的某个dom元素中用于更方便的控制样式渲染，这时候 react-dom 中提供的 createPortal api
就能有效的帮助我们实现这样一个目的。
```

基本语法

```
ReactDOM.createPortal(child, container)
```



```
import React, { PureComponent } from 'react'
import ReactDOM from 'react-dom'


function CompB() {
  return (
    <div>
      我是子组件B
    </div>
  )
}

function CompA() {
  return ReactDOM.createPortal(
    (<div>
      我是子组件A
      <CompB></CompB>
    </div>),
    document.querySelector('#modal') as Element
  )
}


export default class TestComPortals extends PureComponent {
  render() {
    return (
      <div>
        我是挂载在跟组件的
        <CompA></CompA>
      </div>
    )
  }
}

--------------------------------------------------------------------
可见，虚拟dom中CompB为CompA的子组件
但是组件CompA中将CompB的真实dom挂载到了id为‘#modal’的下边了。

```

1. 使用 Portals 改变的是真实dom结构，虚拟的dom 树是不会有变化的
2. 注意改变的`事件冒泡`, 由于react 中的事件是由react 包装过后的，所以他的真实事件冒泡是通过虚拟的`dom 树`里面来进行冒泡的



**更好的案例**

```

//MyPortal负责将虚拟dom中的子节点挂载到指定选择器dom下。
//要确定slector的dom是否挂载上，判断ref是否为空，之后再进行挂载。

import React, { useEffect, useState } from 'react';
import { createPortal } from 'react-dom';
interface MyPortalProps {
    selector: string
}
let ref:HTMLElement|null;
const MyPortal:React.FC<MyPortalProps> = ({ children, selector }) => {
    const [mounted, setMounted] = useState(false);

    useEffect(() => {
        ref = document.querySelector(selector);
        setMounted(true);
    }, [selector]);
    if (!ref) {
        return null;
    }
    return mounted ? createPortal((<div>{children}</div>), ref) : null;
};

export default MyPortal;


```

使用

```
//任意一个组件用该容器包裹，这个组件将渲染到我们事先连接的dom节点 id为react-portal的dom元素中

const Modal:React.FC<LikeListProps> = ({ likeList }) => {
  const classes = useStyle();

  return (
    <div className={classes.root}>
      <div>传送门</div>
      <MyPortal selector="#react-portal"><div>我被渲染到body中了</div></MyPortal>
    </div>
  );
};
export default Modal;

MyPortal中的子元素最终会被挂载到指定的元素下。
```

