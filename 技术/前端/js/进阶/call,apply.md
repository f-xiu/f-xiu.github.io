### 装饰器模式

通过一个函数对接收到的函数进行装饰，返回装饰后的函数。

附加的功能 都在返回后的函数（即装饰后的），在返回的函数内部调用接收到的函数。

例如：

```

function cachingDecorator(func) {
  let cache = new Map();

  return function(x) {
    if (cache.has(x)) {    // 如果缓存中有对应的结果
      return cache.get(x); // 从缓存中读取结果
    }

    let result = func(x);  // 否则就调用 func

    cache.set(x, result);  // 然后将结果缓存（记住）下来
    return result;
  };
}

//cachingDecorator(func) 的结果是一个“包装器”：function(x) 将 func(x) 的调用“包装”到缓存逻辑中：
```

但是上述的方法不适用于对象方法。

原因：如果对象方法中存在‘this'那么在包装器内部调用该函数时，包装器将调用被其他变量引用的方法，但是没有上下文this，导致错误。

```
let worker = {
  someMethod() {
    return 1;
  },

  slow(x) {
    // 可怕的 CPU 过载任务
    alert("Called with " + x);
    return x * this.someMethod(); // (*)
  }
};
//这样调用时将会出错。
let func = worker.slow;//赋值给其他引用
func(2);//调用函数

```

### call

`fun.call(context,args1，args2...)`

它运行 `func`，提供的第一个参数作为 `this`，后面的作为参数（arguments）

```
function sayHi() {
  alert(this.name);
}

let user = { name: "John" };
let admin = { name: "Admin" };

// 使用 call 将不同的对象传递为 "this"
sayHi.call( user ); // John
sayHi.call( admin ); // Admin

//也就相当于call中第一个参数指定了this指向的对象。
//如果是this则会根据上下文进行推断。


```

解决上述问题：

```
let worker = {
  someMethod() {
    return 1;
  },

  slow(x) {
    alert("Called with " + x);
    return x * this.someMethod(); // (*)
  }
};

function cachingDecorator(func) {
  let cache = new Map();
  return function(x) {
    if (cache.has(x)) {
      return cache.get(x);
    }
    let result = func.call(this, x); // 现在 "this" 被正确地传递了
    cache.set(x, result);
    return result;
  };
}

worker.slow = cachingDecorator(worker.slow); // 现在对其进行缓存

alert( worker.slow(2) ); // 工作正常
alert( worker.slow(2) ); // 工作正常，没有调用原始函数（使用的缓存）
```

```
//在经过装饰之后，worker.slow 现在是包装器 function (x) { ... }。
//因此，当 worker.slow(2) 执行时，包装器将 2 作为参数，并且 this=worker（它是点符号 . 之前的对象）。
//在包装器内部，假设结果尚未缓存，func.call(this, x) 将当前的 this（=worker）和当前的参数（=2）传递给原始方法。
```

调用函数返回一个函数，返回的函数中的this指向。如果该返回函数赋值给一个对象的属性，那么this为该对象。

如果为一个全局变量，那么this指向就是window或者undefined。



#### 多个参数

`arguments`

```
function cachingDecorator(func, hash) {
  let cache = new Map();
  return function() {
    let key = hash(arguments); // (*)
    if (cache.has(key)) {
      return cache.get(key);
    }

    let result = func.call(this, ...arguments); // (**)

    cache.set(key, result);
    return result;
  };
}
```

直接传入arguments是一个对象(包括每个参数),会被参数接收到。

```
func.call(this, arguments)
call期待一个参数列表，而只传了一个类数组对象

包装逻辑
调用包装的函数
输出参数
[Arguments] { '0': '你好', '1': '我好', '2': '大家好' }
```

通过spread语法则是将对象拆开，按顺序传入,<font color=red>如果只设置一个参数则只接受到第一个的值</font>，arguments仍然是全部参数的对象。

```
如果这样调用func.call(this,...arguments);

包装逻辑
调用包装的函数
输出参数
你好
[Arguments] { '0': '你好', '1': '我好', '2': '大家好' }
```

### apply

我们可以使用 `func.apply(this, arguments)` 代替 `func.call(this, ...arguments)`。

内建方法 [func.apply](https://developer.mozilla.org/zh/docs/Web/JavaScript/Reference/Global_Objects/Function/apply) 的语法是：

```javascript
func.apply(context, args)
```

`call` 和 `apply` 之间唯一的语法区别是，`call` 期望一个参数列表，而 `apply` 期望一个包含这些参数的类数组对象。



只有一个关于 `args` 的细微的差别：

* Spread 语法 `...` 允许将 **可迭代对象** `args` 作为列表传递给 `call`。
* `apply` 只接受 **类数组** `args`。



对于即可迭代又是类数组的对象，例如一个真正的数组，我们使用 `call` 或 `apply` 均可，但是 `apply` 可能会更快，因为大多数 JavaScript 引擎在内部对其进行了优化。



`fun.apply`期待一个类数组对象,运行结果同`func.call(this,...arguments)`





`arguments` 对象既是可迭代对象又是类数组对象，但它并不是真正的数组。所以不能直接调用数组对应的方法.

* call或apply指定函数this为`argumens`来调用。

```

//可以通过call实现调用，指定this为arguments，这可以实现（故意允许）
function hash() {
  alert( [].join.call(arguments) ); // 1,2
}

```

* 通过rest参数接收

  ```
  //或者使用rest参数对下对象，这个对象是一个真正的数组。两种方法结果：
  slow(...args) {
          //得到所有参数
        console.log("输出参数");
        console.log(args); // (*)
        console.log(arguments)
   }
  [ '你好', '我好', '大家好' ]
  [Arguments] { '0': '你好', '1': '我好', '2': '大家好'
  
  
  ```

  