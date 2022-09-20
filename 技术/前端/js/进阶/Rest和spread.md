### Rset参数`...`

无论函数是如何定义的，你都可以在调用它时传入任意数量的参数。

```
function sum(a, b) {
  return a + b;
}

alert( sum(1, 2, 3, 4, 5) );

```

想要接收全部的参数，需要使用rest参数，语法：`...args`,这样会把所有参数都放到`args`数组中。



**Rest 参数必须放到参数列表的末尾**



`arguments` 是一个特殊类数组对象可以在函数中被访问，该对象以参数在参数列表中的索引作为键，存储所有参数。（箭头函数中没有该对象）



### Spread语法

我们可以对一个可迭代对象进行展开，使用`...`，这种被成为Spread 语法。适用于可迭代的，字符串，数组，可迭代的对象。

```
let str = "Hello";

alert( [...str] ); // H,e,l,l,o
```

```
let obj = {
  name: "john",
  age: 18,
};

let students = ["john", "tom", "jack"];

console.log(...students);
console.log({ ...obj });
-------------------------------------
john tom jack
{ name: 'john', age: 18 }
//不能直接...obj，因为obj并非可迭代
```

也可以用来复制对象:`{..obj}`用这种语法可以实现一些浅拷贝



`React`支持了一个解构特性，利用解构操作符（`...`）将一个对象解构作为子组件的 props：

`<GitHubPAT {...props} />`,可以将props对象展开，将每一条属性传递给该组件。
