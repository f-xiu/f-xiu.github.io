### useEffect





#### 错误

##### 传入的函数不能是async

传入的函数应该是一个同步执行的，只是内部可以调用其他的异步方法。

```
 useEffect(async()=>{
    异步操作
 },[question]) ;//XXXXXXXXXXX错误
--------------------------------------------------------------------- 
 //应该为:
 const fetchData=async()=>{异步操作}
 useEffect(()=>{
 	fetchData();
 },[question])
```





### useMemo和useCallback

useMemo和useCallback都会在组件第一次渲染的时候执行，之后会在其依赖的变量发生改变时再次执行；并且这两个hooks都返回缓存的值，useMemo返回缓存的变量，useCallback返回缓存的函数。



#### **使用useMemo的场景**

```
import React from 'react';
 
 
export default function WithoutMemo() {
    const [count, setCount] = useState(1);
    const [val, setValue] = useState('');
 
    function expensive() {
        console.log('compute');
        let sum = 0;
        for (let i = 0; i < count * 100; i++) {
            sum += i;
        }
        return sum;
    }
 
    return <div>
        <h4>{count}-{val}-{expensive()}</h4>
        <div>
            <button onClick={() => setCount(count + 1)}>+c1</button>
            <input value={val} onChange={event => setValue(event.target.value)}/>
        </div>
    </div>;
}
```

每一次渲染都会重新调用一遍expensive()这个昂贵的计算，拿到count对应的值。

无论是修改count还是val，由于组件的重新渲染，都会触发expensive的执行(能够在控制台看到，即使修改val，也会打印)；但是这里的昂贵计算只依赖于count的值，在val修改的时候，是没有必要再次计算的。

(在一些其他的状态改变触发重新渲染时，一些不依赖该状态的昂贵计算应该不重新运行一遍)

```
export default function WithMemo() {
    const [count, setCount] = useState(1);
    const [val, setValue] = useState('');
    const expensive = useMemo(() => {
        console.log('compute');
        let sum = 0;
        for (let i = 0; i < count * 100; i++) {
            sum += i;
        }
        return sum;
    }, [count]);
 
    return <div>
        <h4>{count}-{expensive}</h4>
        {val}
        <div>
            <button onClick={() => setCount(count + 1)}>+c1</button>
            <input value={val} onChange={event => setValue(event.target.value)}/>
        </div>
    </div>;
}
```

#### 使用useCallback的场景

##### 基础知识

**In JavaScript, a `function () {}` or `() => {}` always creates a \*different\* function,** similar to how the `{}` object literal always creates a new object. 

**By default, when a component re-renders, React re-renders all of its children recursively.**

默认父组件更新，子组件都会跟着重新渲染。可以使用memo来包装子组件，当子组件尽在props发生改变时重新渲染。

但是props如果是函数，由于每次运行都会重新的创建函数，所以子组件中props就永远不会相同，没有起到效果，即便函数的内容没有发生变化。`useCallback`的作用就体现就体现在这里。

##### 应用

主要用来解决子组件不必要的重新渲染

有一个父组件，其中包含子组件，子组件接收一个函数作为props；

父组件更新时，传入子组件的函数由于父组件重新创建一个函数实例也相应的跟着重新渲染。实际上这个渲染是不必要的。

这时候就可以用useCallback了，我们用useCallback把函数包起来之后，在父组件中只有当deps变化的时候，才会创建新的实例

```
import React, { useState, useCallback, useEffect } from 'react';
function Parent() {
    const [count, setCount] = useState(1);
    const [val, setVal] = useState('');
 
    const callback = useCallback(() => {
        return count;
    }, [count]);
    return <div>
        <h4>{count}</h4>
        <Child callback={callback}/>
        <div>
            <button onClick={() => setCount(count + 1)}>+</button>
            <input value={val} onChange={event => setVal(event.target.value)}/>
        </div>
    </div>;
}
 
//如果希望Child仅在传入的props改变时重新渲染，那么可以使用memo包装该方法，但是默认的js创建函数时都是新的，所以不可能出现相同，因此可以使用useCallback保证返回的函数是相同的。
function Child({ callback }) {
    const [count, setCount] = useState(() => callback());
    useEffect(() => {
        setCount(callback());
    }, [callback]);
    return <div>
        {count}
    </div>
}
```

所有依赖本地状态或props来创建函数，需要使用到缓存函数的地方，都是useCallback的应用场景。

##### 注意

*使用useCallback时一般都要加上依赖数组[]。*

函数中需要最新的state,可以使用useRef

```
const [text, setText] = useState('Initial value');
const textRef = useRef(text);
const handleClick= useCallback(() => {
     console.log(textRef.current);
 }, []); 

 useEffect(() => {
     console.log('update text')
     textRef.current = text;
 }, [text])
```

使用useReducer

[(1条消息) 一文搞懂useCallback的使用_Kobe_G的博客-CSDN博客_usecallback](https://blog.csdn.net/Kobe_G/article/details/121752526?ops_request_misc=%7B%22request%5Fid%22%3A%22166348932116800180632709%22%2C%22scm%22%3A%2220140713.130102334..%22%7D&request_id=166348932116800180632709&biz_id=0&utm_medium=distribute.pc_search_result.none-task-blog-2~all~top_click~default-2-121752526-null-null.142^v47^pc_rank_34_default_2,201^v3^control_2&utm_term=useCallback&spm=1018.2226.3001.4187)

[useCallback (reactjs.org)](https://beta.reactjs.org/apis/react/useCallback)