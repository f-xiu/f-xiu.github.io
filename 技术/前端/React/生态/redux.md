### 快速了解

##### Store

Store 就是保存全局数据的地方，你可以把它看成一个容器（带有推送功能的数据仓库）。整个应用只能有一个 Store。

通过 `redux` 的 `createStore` API 生成 Store，该方法可传三个参数：

* `reducer`：
* `preloadedstate`：State 的初始值
* `enhancer`：

返回值为对象类型，具有以下属性：

* `getState`：获取状态（`state`）
* `dispatch`：触发动作（`action`），更新状态（`state`）
* `subscribe`：订阅数据变更，注册监听器（数据变更时触发）
* `replaceReducer`：
* `[$$observable]`：

```
// const store = createStore(Reducer, initStore);
const store = createStore(todos, ['Coding']);

store.dispatch({
  type: 'ADD_TODO',
  text: 'Drinking coffe',
});

console.log(store.getState());
// [ 'Coding', 'Drinking coffee' ]
```

##### 纯函数reducer

**在 `reducer` 中指定状态数据转换的逻辑。**

**纯函数的特点：**

1. 相同的输入，结果始终相同
2. 不对外部环境进行操作

在 Redux 里，我们通过定义 `reducer` 来确定状态的修改，而每一个 `reducer` 都是纯函数，这意味着它没有副作用，即接受一定的输入，必定会得到一定的输出。

```js
function todos(state = [], action) {
  switch(action.type) {
    case 'ADD_TODO':
      return [
        ...state,
        {
            text: action.text,
            completed: false
        }
      ]
    case 'COMPLTE_TODO':
      return state.map((todo, index) => {
        if (index === action.index) {
          return Object.assign({}, todo, {
            completed: true
          })
        }
        return todo
      })
    default:
      return state
  }
}
```

定义具体的修改state的操作，调用时逻辑判断不写在其中。



##### Action Creator

```js
function addToDo(text) {
  return {
    type: 'ADD_TODO',
    text,
  };
}
```

这样将使 `action` 创建函数更容易被移动和测试。

reducer中根据action的type和参数进行处理得到state.



##### dispatch

store.dispatch(action);



##### subscribe

手动订阅更新，也可以事件绑定到视图层。

```js
store.subscribe(() => {
  console.log(store.getState());
});
```

只要redux的store中的state发生改变，都会调用回调函数。



##### 异步action

如果希望在action creater中统一action,包括异步action，可以使用中间件thunk。

redux的dispathc接收的action必须是object，而异步方法不能直接得到object的action。如果想要使用function的action,需要中间件对其进行增强。

dispatch一个action之后，到达reducer之前，进行一些额外的操作，就需要用到middleware。你可以利用 Redux middleware 来进行日志记录、创建崩溃报告、调用异步接口或者路由等等。

```
import { applyMiddleware, createStore } from 'redux';
import thunk from 'redux-thunk';
 const store = createStore(
  reducers, 
  applyMiddleware(thunk)
);
```

直接将thunk中间件引入，放在applyMiddleware方法之中，传入createStore方法，就完成了store.dispatch()的功能增强。即可以在reducer中进行一些异步的操作。

原理:

```
部分源码如下:
function createThunkMiddleware(extraArgument) {
 return ({ dispatch, getState }) => next => action => {
  if (typeof action === 'function') {
   return action(dispatch, getState, extraArgument);
  }
  return next(action);
 }
} 
const thunk = createThunkMiddleware();
thunk.withExtraArgument = createThunkMiddleware; 
export default thunk
```

如果这个action creator 返回的是一个函数，就执行它，如果不是，就按照原来的next(action)执行。
正因为这个action creator可以返回一个函数，那么就可以在这个函数中执行一些异步的操作。

一般再action creator中定义具体的dispatch需要操作的action对象，或者响应的函数。

在相应的容器组件中直接dispatch对应的action creator.



##### 文件分布

`constant.js` : 保存action type常量，一般用大写来表示常量。

```
export const INCREMENT='increment';
export const INCREMENT='decrement';
```

但凡用到该常量的地方，都用大写常量即可。

这样方便使用，而且可以统一修改。

`xxx_action.js`:保存action create的创建函数。

也可以写一些异步action。

`xxx_reducer.js`:用于管理状态数据的函数

`store.js`:保存统一管理的状态。

在单个组件使用redux的基础上，每个组件的action、reducer单独定义。
多个组件的共同状态都存放在唯一的store里面。
汇总所有的reducer变为一个总的reducer，进行统一的暴露。
多个组件的action共用一个constant，定义action中的type类型。

##### 合并多个reducer

```
const reducer = combineReducers({
     a: doSomethingWithA,
     b: processB,
     c: c
})
```

创建store后state是一个对象，属性根据名称分布：

```
export default combineReducers({
  todos,
  counter
})

console.log(store.getState())
// {
//   counter: 0,
//   todos: [ 'Use Redux' ]
// }
```

合并后总状态发生变化，是一个总状态。

每个reducer接收到的preState仍然是该容器组件对应,而不是一个总的state

> ```
> export default function person(preState, action) {
>     let { data } = action;
>     //重新创建一个数组
>     switch (action.type) {
>         case ADD_PERSON:
>             return [...preState,data];
>         default:
>             return preState;
>     }
> }
> ```
>
> 这里default默认返回传入perState,但是刚开始初始化时，没有传入,perState为undefined,这时默认return返回undefined会报错。
>
> ```
> export default function person(preState=[], action) {
>     let { data } = action;
>     //重新创建一个数组
>     switch (action.type) {
>         case ADD_PERSON:
>             return [...preState,data];
>         default:
>             return preState;
>     }
> }
> ```
>
> 这里仍然可以在createStore中传入initalState。
>
> 





### react-redux

**UI组件**

> 1. 只负责UI的呈现，不带有任何业务逻辑
> 2. 没有状态（即不适用this.state，或定义 state）
> 3. 所有数据都由 props 提供
> 4. 不使用任何 Redux 的API

**容器组件**

> 1. 负责管理数据和业务逻辑，不负责UI的呈现
> 2. 带有内部状态
> 3. 使用 Redux 的API

连接ui组件和容器组件。

#### 视图层绑定

视图层绑定引入了几个概念：

* `<Provider>` 组件：这个组件需要包裹在整个组件树的最外层。这个组件让根组件的所有子孙组件能够轻松的使用 `connect()` 方法绑定 `store`
* `connect()` 高阶组件：这是 `react-redux` 提供的一个方法。如果一个组件想要响应状态的变化，就把自己作为参数传给 `connect()` 的结果，`connect()` 方法会处理与 `store` 绑定的细节，并通过 `selector` 确定该绑定 `store` 中哪一部分的数据
* `selector`：这是你自己编写的一个函数。这个函数声明了你的组件需要整个 `store` 中哪一部分数据作为自己的 `props`
* `dispatch`：每当你想要改变应用中的状态时，你就要 `dispatch` 一个 `action`，这也是唯一改变状态的方法



##### provider

​	接收从 Redux 而来的 `store`，以供子组件使用。

​	使组件层级中的 `connect()` 方法能够获得 Redux 中的 `store`。通常情况下我们需要将根组件嵌套在标签中才能使用 `connect()` 方法。

```jsx
import React from 'react';
import ReactDOM from 'react-dom';
import { Provider } from 'react-redux';
import { App } from './App';import createStore from './createReduxStore';
const store = createStore();
ReactDOM.render(  <Provider store={store}>   
                    <App />  
                </Provider>,
         document.getElementById('root'));
```

##### Connect

> API 原型：`connect([mapStoreToProps], [mapDispatchToProps], [mergeProps], [options])`

* `mapStoreToProps`：相当于一个过滤器函数，将 Store 中的某些或全部状态，以 Props 的形式传入将被包裹的子组件中。
* `mapDispatchToProps`：自定义以 Props 传递到包裹子组件中的函数，可以使用函数传入的 `dispatch` 和 `ownProps` 参数。
* `mergeProps`：用于自定义 `ownProps`、`stateProps` 和 `dispatchprops` 的合并组合顺序及方法等。

```
mapDispatchToProps(dispatch, [ownProps])：

/*mapDispatchToProps
*如果是对象，那么会和store绑定作为props的一部分传入ui组件，并且自动dispatch。
*如果是个函数，它接受两个参数，需要自己使用dispatch(action)

最终都是要返回一个对象，对应props需要使用函数。
如果直接传入actionCreators模块，则会将该对象中每一个方法传入，使用时直接从props中解构对应action函数即可
*/
const mapDispatchToProps={
 todoActions:todActionCreators,
 counterActions:counterActionCreators
}

function mapDispatchToProps(dispatch) {
   return {
      todoActions: bindActionCreators(todoActionCreators, dispatch),
      counterActions: bindActionCreators(counterActionCreators, dispatch)
   };
}
/*mapDispatchToProps返回的对象其属性其实就是一个个actionCreator，因为已经和dispatch绑定，所以当调用actionCreator时会立即发送action，而不用手动dispatch。ownProps的变化也会触发mapDispatchToProps。*/
```



```jsx
import * as actionCreators from './actionCreators';

function mapStateToProps(state) {  
    return {    todos: state.todos,  };
}

function mergeProps(stateProps, dispatchProps, ownProps) { 
    return Object.assign({}, ownProps, {
        todos: stateProps.todos[ownProps.userId],    						
        addTodo: (text) => dispatchProps.addTodo(ownProps.userId, text),  });
	}
export default connect(mapStateToProps, actionCreators, mergeProps)(TodoApp);
```

连接 React 组件与 Redux `store`，连接操作会返回一个新的与 Redux `store` 连接的组件类，并且连接操作不会改变原来的组件类。

`react-redux` 提供了 `connect` 函数，`connect` 是一个高阶函数，首先传入 `mapStateToProps` 和 `mapDispatchToProps`，然后返回一个生产 `Component` 的函数（`wrapWithConnect`），然后再将真正的 `Component` 作为参数传入 `wrapWithComponent`（MyComponent），这样就生产出一个经过包裹的 `Connect` 组件。

例如：

```jsx
export default connect(mapStateToProps)(HomePage);
```



#### 写法上优化

mapStateToProps:可以直接用箭头函数

mapDispatchToProps：可以简写为一个对象

可以整合UI组件和容器组件，将ui组件和connect()(ui)写在一块。统一叫containers或者components



#### 多个组件

在redux文件夹中，actions文件夹，reducers文件夹，store.js和constant.js

可能需要使用store.js的地方:

* index.js，在Provider中全局的共享
* action,在返回非函数的action时，可能需要使用dispatch

### 其他

#### 开发者工具

安装扩展，安装库：redux-devtools-extension

在store中：

`import {composeWithDevTools} from 'redux-devtools-extension';`

```
const store = createStore(
		reducer,
		initState,
		composeWithDevTools(applyMiddleware(thunk))
);

```



#### redux toolkit

##### 快速使用

```
//使用
import React from 'react'
import ReactDOM from 'react-dom'
import './index.css'
import App from './App'
import { store } from './app/store'
import { Provider } from 'react-redux'

ReactDOM.render(
  <Provider store={store}>
    <App />
  </Provider>,
  document.getElementById('root')
)

//具体使用
import React from 'react'
import { useSelector, useDispatch } from 'react-redux'
import { decrement, increment } from './counterSlice'

export function Counter() {
  const count = useSelector((state) => state.counter.value)
  const dispatch = useDispatch()

  return (
    <div>
      <div>
        <button
          aria-label="Increment value"
          onClick={() => dispatch(increment())}
        >
          Increment
        </button>
        <span>{count}</span>
        <button
          aria-label="Decrement value"
          onClick={() => dispatch(decrement())}
        >
          Decrement
        </button>
      </div>
    </div>
  )
}
```

```
//创建store
import { configureStore } from '@reduxjs/toolkit'
import counterReducer from '../features/counter/counterSlice'

export const store = configureStore({
  reducer: {
    counter: counterReducer,
  },
})
```

```
//创建store需要的切片器
import { createSlice } from '@reduxjs/toolkit'

const initialState = {
  value: 0,
}

export const counterSlice = createSlice({
  name: 'counter',
  initialState,
  reducers: {
    increment: (state) => {
      state.value += 1
    },
    decrement: (state) => {
      state.value -= 1
    },
    incrementByAmount: (state, action) => {
      state.value += action.payload
    },
  },
})

// Action creators are generated for each case reducer function
export const { increment, decrement, incrementByAmount } = counterSlice.actions

export default counterSlice.reducer
```





在Redux Toolkit之前，你通常会用语句和手动更新来编写它。您可能还会有手写的操作创建者和操作类型常量以及它：`switch`

这些代码都不是特别依赖于核心库中的任何 API。但是，这需要编写很多代码。

##### Redux Toolkit 是做什么的？

虽然*这些是*Redux文档中最初显示的模式，但不幸的是，它们需要大量非常冗长和重复的代码。大多数这个样板不是使用Redux*所必需的*。最重要的是，样板代码带来了更多犯错的机会。

替代了connect()()的使用，需要使用钩子useDispatch和useSelector

连接ui和容器，只需要容器中向ui暴露mapState,mapAction。

通过安装库

```
npm install @reduxjs/toolkit
```

然后文件分布：

store.js ：包括store创建,多个reducer

​	

features文件夹：每个组件文件夹,每个组件:ui组件，xxxSlice.js

xxxSlice.js：

>  创建slice，需要reducer:一个对象。可选extraReducers:
>
> 得到的slice对象中包括了actions
>
> 将需要使用的actions解构方式导出，还可以直接导出函数（在使用时通过钩子useDispatch来得到dispatch分发）
>
> 将需要使用的state,写成函数导出，通过useSelector来运行得到想要传递到ui组件中的state
>
> 默认导出slice对象的reducer,供store.js导入



##### 化简器具体介绍

后台通过模板同一个了格式，化简了写法，省去了很多重复步骤，并做出了统一。

如：actionCreator不用手动创建，因此传入的参数也格式化了,如果想要多个参数，则用对象包裹为一个参数传入。

###### createReducer()

固定写法:

```
const initialState = { value: 0 }

function counterReducer(state = initialState, action) {
  switch (action.type) {
    case 'increment':
      return { ...state, value: state.value + 1 }
    case 'decrement':
      return { ...state, value: state.value - 1 }
    case 'incrementByAmount':
      return { ...state, value: state.value + action.payload }
    default:
      return state
  }
}
```

```
//化简器调用写法
import { createAction, createReducer } from '@reduxjs/toolkit'

const increment = createAction('counter/increment')
const decrement = createAction('counter/decrement')
const incrementByAmount = createAction('counter/incrementByAmount')

const initialState = { value: 0 }

const counterReducer = createReducer(initialState, (builder) => {
  builder
    .addCase(increment, (state, action) => {
      state.value++
    })
    .addCase(decrement, (state, action) => {
      state.value--
    })
    .addCase(incrementByAmount, (state, action) => {
      state.value += action.payload
    })
})
```

(builder=>{builder.addCase()}一个回调，它接收*生成器*对象以通过调用 来定义事例化简器。

允许您将传入操作与您自己的筛选器函数（而不仅仅是属性）进行匹配。

```
import { createAction, createReducer } from '@reduxjs/toolkit'

const initialState = {}
const resetAction = createAction('reset-tracked-loading-state')

function isPendingAction(action) {
  return action.type.endsWith('/pending')
}

const reducer = createReducer(initialState, (builder) => {
  builder
    .addCase(resetAction, () => initialState)
    // matcher can be defined outside as a type predicate function
    .addMatcher(isPendingAction, (state, action) => {
      state[action.meta.requestId] = 'pending'
    })
    .addMatcher(
      // matcher can be defined inline as a type predicate function
      (action) => action.type.endsWith('/rejected'),
      (state, action) => {
        state[action.meta.requestId] = 'rejected'
      }
    )
    // matcher can just return boolean and the matcher can receive a generic argument
    .addMatcher(
      (action) => action.type.endsWith('/fulfilled'),
      (state, action) => {
        state[action.meta.requestId] = 'fulfilled'
      }
    )
})
```

添加一个“默认事例”化简器，如果没有针对此操作执行任何事例化简器和匹配器化简器，则执行该化简器。

```
builder
    // .addCase(...)
    // .addMatcher(...)
    .addDefaultCase((state, action) => {
      state.otherActions++
    })
```

另一种写法:

```
const initialState = () => 0
const counterReducer = createReducer(initialState, {
  increment: (state, action) => state + action.payload,
  decrement: (state, action) => state - action.payload
})
```



###### createAction()

```
默认的具体代码如下:
const INCREMENT = 'counter/increment'

function increment(amount) {
  return {
    type: INCREMENT,
    payload: amount,
  }
}

const action = increment(3)
// { type: 'counter/increment', payload: 3 }

console.log(increment.toString())
// 'counter/increment'

```



```
使用API
function createAction(type, prepareAction?)

import { createAction } from '@reduxjs/toolkit'

const increment = createAction('counter/increment')

自定义操作内容
prepare函数返回经过包装的参数，默认为payload对应的对象。
const addTodo = createAction('todos/add', function prepare(text) {
  return {
    payload: {
      text,
      id: nanoid(),
      createdAt: new Date().toISOString(),
    },
  }
})

```



###### createSlice()

接受初始状态、化简器函数的对象和“切片名称”，并自动生成与化简器和状态对应的操作创建者和操作类型的函数

在内部，它使用`createAction`和`createReducer`，所以你也可以使用[Immer](https://immerjs.github.io/immer/)来编写“变异”不可变的更新：

所以通过这个方法得到与之对应时以前的`reducer`和`actionCreators`

```
import { createSlice } from '@reduxjs/toolkit'

const initialState = { value: 0 }

const counterSlice = createSlice({
  name: 'counter',
  initialState,
  reducers: {
    increment(state) {
      state.value++
    },
    decrement(state) {
      state.value--
    },
    incrementByAmount(state, action) {
      state.value += action.payload
    },
  },
})

export const { increment, decrement, incrementByAmount } = counterSlice.actions
export default counterSlice.reducer


//导出连接容器的state
一般叫做selectXXX,一般只用来得到指定组件的状态值。
```

参数：

`name`,`initialState`,`reducers`

自定义actionCreator额外操作

如果需要通过 `prepare `对payload自定义创建，则参数对象的相应字段的值应为对象而不是函数。此对象必须包含两个属性:`reducer`和`prepare` 。后者则是准备工作（prepare函数），负责返回包括payload参数的对象。

```
import { createSlice, nanoid } from '@reduxjs/toolkit'

const todosSlice = createSlice({
  name: 'todos',
  initialState: [],
  reducers: {
    addTodo: {
      reducer: (state, action) => {
        { ...data, id: nanoid() }
      },
      //这里一定要注意返回的对象中需要有关键字payload
      prepare: (text) => {
        const id = nanoid()
        return { payload: { id, text } }
      },
    },
  },
})
```

可选参数:` extraReducers`

One of the key concepts of Redux is that each slice reducer "owns" its slice of state, and that many slice reducers can independently respond to the same action type.（大多数依赖的action都是reducer中的）

 allows to respond to other action types besides the types it has generated。（允许响应那些从已有的action集合而成的action类）

可以使用链式调用的方法，增加每一种情况，一个action,对应一个Case

```
 extraReducers: (builder) => {
    builder
      .addCase(incrementBy, (state, action) => {
        // action is inferred correctly here if using TS
      })
      // You can chain calls, or have separate `builder.addCase()` lines each time
      .addCase(decrement, (state, action) => {})
      // You can match a range of action types
      .addMatcher(
        isRejectedAction,
        // `action` will be inferred as a RejectedAction due to isRejectedAction being defined as a type guard
        (state, action) => {}
      )
      // and provide a default case if no other handlers matched
      .addDefaultCase((state, action) => {})
  }
```

或者使用对象映射的方式：

```
const incrementBy = createAction('incrementBy')

createSlice({
  name: 'counter',
  initialState: 0,
  reducers: {},
  extraReducers: {
    [incrementBy]: (state, action) => {
      return state + action.payload
    },
    'some/other/action': (state, action) => {},
  },
})
```

###### createAsyncThunk()

调用异步方法

```
// First, create the thunk
const fetchUserById = createAsyncThunk(
  'users/fetchByIdStatus',
  async (userId, thunkAPI) => {
    const response = await userAPI.fetchById(userId)
    return response.data
  }
)


//具体使用
extraReducers: (builder) => {
    // Add reducers for additional action types here, and handle loading state as needed
    builder.addCase(fetchUserById.fulfilled, (state, action) => {
      // Add user to the state array
      state.entities.push(action.payload)
    })
  }

// Later, dispatch the thunk as needed in the app
dispatch(fetchUserById(123))
```

参数：

1. `type`

   将用于生成其他 Redux 操作类型常量的字符串，表示异步请求的生命周期：

   例如，`type:'users/requestStatus'` 将生成以下action类型：

   * `pending`:`'users/requestStatus/pending'`
   * `fulfilled`:`'users/requestStatus/fulfilled'`
   * `rejected`:`'users/requestStatus/rejected'`

2. ### `payloadCreator`

   一个回调函数,可以是一个异步函数。回调函数返回异步请求数据，对应action:{action.fulfilled，payload}

   回调函数的返回值为参数，例如incrementAsync(参数);payloadCreator得到payload,可以是异步请求
   
   payloadCreator函数，第一个参数为接收data,第二个为api。。。,如果想要传入多个参数，可以传入data对象
   
   ```
   源码如下:
   
   export declare type AsyncThunkPayloadCreator<Returned, ThunkArg = void, ThunkApiConfig extends AsyncThunkConfig = {}>
   =  (arg: ThunkArg, thunkAPI: GetThunkAPI<ThunkApiConfig>) => AsyncThunkPayloadCreatorReturnValue<Returned, ThunkApiConfig>;
   ```
   
   可见第一个参数为接收到的参数，第二个参数API

给额外action对象设置reducer函数



#### configureStore()

使用 `configureStore` 创建 Redux Store

`configureStore`接受函数作为命名参数`reducer`

`configureStore`使用良好的默认设置自动设置商店

```
import { configureStore } from '@reduxjs/toolkit'
import counterReducer from '../features/counter/counterSlice'

export const store = configureStore({
  reducer: {
    counter: counterReducer,
  },
})
```

#### hooks

都来自‘react-redux'中。

##### useSelect()

组件想要使用state中的值，可以调用useSelect（selectXXX()）;//其中selectXXX在对应XXXSlice.js文件中定义

```
//state:{
//	counter:0
//}
export const selectCount = (state) => {
     console.log(state)
     return state.counter;
}

let count=useSelect(selectCount);
```

##### useDispatch()

```
//
let dispatch=useDispatch();
dispatch(actions)
```

使用时需要先import这些动作action,然后调用，由于actionCreator都是切片器自动生成的，所以传入的参数只有一个data,如果想要多个参数，可以传入一个对象

```
源码如下：
export declare type PayloadAction<P = void, T extends string = string, M = never, E = never> = {
    payload: P;
    type: T;
} & ([M] extends [never] ? {} : {
    meta: M;
}) & ([E] extends [never] ? {} : {
    error: E;
});
可见如果：dispatch(increment())}
increment中第一个参数,对应action中的payload,第二个参数时对应的type。
所以如果想要传入多个参数，则需传入一个对象，payload：{}
```



