#### 简介

HTML DOM 定义了访问和操作 HTML 文档的标准。

HTML DOM 是：

- HTML 的标准**对象模型**
- HTML 的标准**编程接口**

HTML DOM 定义了所有 HTML 元素的*对象*和*属性*，以及访问它们的*方法*。

*换言之，HTML DOM 是关于如何获取、修改、添加或删除 HTML 元素的标准。*

通过这个对象模型，JavaScript 获得创建动态 HTML 的所有力量



#### HTML DOM 节点

**根据 W3C 的 HTML DOM 标准，HTML 文档中的所有内容都是节点：**

- 整个文档是一个文档节点
- 每个 HTML 元素是元素节点
- HTML 元素内的文本是文本节点
- 每个 HTML 属性是属性节点
- 注释是注释节点

![DOM HTML 树](https://www.w3school.com.cn/i/ct_htmltree.gif)

**DOM节点包括什么**

在 DOM 中，所有 HTML 元素都被定义为*对象*。

编程界面是每个对象的属性和方法。

*属性*是您能够获取或设置的值（就比如改变 HTML 元素的内容）。

*方法*是您能够完成的动作（比如添加或删除 HTML 元素）。

##### DOM节点类型

* 元素节点

* 文本节点

​		元素包含的文本是一个文本节点。

* 属性节点

​		每一个元素节点都有对应的属性，所有的属性都被元素包含。

----

#### 常用方法及属性

所有属性:

[Element属性与方法整理_hjb2722404的博客-CSDN博客_aria-readonly](https://blog.csdn.net/hjb2722404/article/details/118720484?ops_request_misc=&request_id=&biz_id=102&utm_term=element的属性&utm_medium=distribute.pc_search_result.none-task-blog-2~all~sobaiduweb~default-2-118720484.142^v46^pc_rank_34_default_3&spm=1018.2226.3001.4187)



##### 查找 HTML 元素

| 方法                                    | 描述                   |
| :-------------------------------------- | :--------------------- |
| document.getElementById(*id*)           | 通过元素 id 来查找元素 |
| document.getElementsByTagName(*name*)   | 通过标签名来查找元素   |
| document.getElementsByClassName(*name*) | 通过类名来查找元素     |
| document.querySelectorAll()             | 通过css选择器查找元素  |

```js
var x = document.querySelectorAll("p.intro");
```



##### 改变 HTML 元素

| 方法                                       | 描述                   |
| :----------------------------------------- | :--------------------- |
| element.innerHTML = *new html content*     | 改变元素的 inner HTML  |
| element.attribute = *new value*            | 改变 HTML 元素的属性值 |
| element.setAttribute(*attribute*, *value*) | 改变 HTML 元素的属性值 |
| element.style.property = *new style*       | 改变 HTML 元素的样式   |

```
innerHTML的内容可以设置为文本，文本中也可以有html语句
但是会覆盖原来的内容。
如果是添加文本，可以 += 或者创建文本节点添加。
```





##### 添加和删除元素

| 方法                               | 描述                               |
| :--------------------------------- | :--------------------------------- |
| document.createElement(*element*)  | 创建 HTML 元素节点                 |
| document.createTextNode(string)    | 创建文本节点                       |
| document.createAttribute(attrName) | 创建属性节点                       |
| document.removeChild(*element*)    | 删除 HTML 元素                     |
| document.appendChild(*element*)    | 在父元素最后添加                   |
| document.insertBefore(element)     | 在父元素最前添加                   |
| document.replaceChild(*element*)   | 替换 HTML 元素                     |
| document.write(*text*)             | 写入 HTML 输出流，会覆盖原来的文档 |



##### 操作class

通过classList当作数组，修改即可

[(1条消息) JS classList 用法简介_文一大大的博客-CSDN博客_js中classlist](https://blog.csdn.net/kayron/article/details/78533035)



##### 添加事件处理程序

| 方法                                             | 描述                            |
| :----------------------------------------------- | :------------------------------ |
| elem.onclick = function(){*code*}                | 向 onclick 事件添加事件处理程序 |
| window.onload=function(){code}                   | 在页面加载时执行                |
| window.onunload=function(){code}                 | 离开页面后                      |
| elem.addEventListener(event,function,usecapture) | 为指定元素添加事件对应处理程序  |
| elem.removeEventListener(event,function)         | 移除事件处理程序                |

第三个参数是布尔值，指定使用事件冒泡还是事件捕获。此参数是可选的。

```js
*常见写法
<body onload="checkCookies()">
elem.onclick会覆盖 
    
*addEventListener附加事件处理程序而不会覆盖已有的事件处理程序。
第三个参数默认值为false,使用事件冒泡
true使用事件捕获

在冒泡中，最内侧元素的事件会首先被处理，然后是更外侧的：首先处理 <p> 元素的点击事件，然后是 <div> 元素的点击事件。
在捕获中，最外侧元素的事件会首先被处理，然后是更内侧的：首先处理 <div> 元素的点击事件，然后是 <p> 元素的点击事件。
```



**节点属性**

| 属性                      | 描述                                |
| ------------------------- | ----------------------------------- |
| elem.childNodes           | 获得任意一个元素的所有子元素        |
| node.nodeType             | 获取节点的nodeType的属性            |
| node.nodeValue            | 文本节点的值                        |
| node.firstChild/lastChild | childNodes的第一个节点/最后一个节点 |
| node.nextSibling          | 下一个兄弟                          |
| node.previousSibling      | 前一个兄弟                          |

元素、属性、文本节点的nodeType属性值分别是1、2、3.



#### HTMLCollection 并非数组！

HTMLCollection 也许看起来像数组，但并非数组。

您能够遍历列表并通过数字引用元素（就像数组那样）。

不过，您无法对 HTMLCollection 使用数组方法，比如 `valueOf()`、`pop()`、`push()` 或 `join()`。

```js
var myCollection = document.getElementsByTagName("p");
var i;
for (i = 0; i < myCollection.length; i++) {
    myCollection[i].style.backgroundColor = "red";
```

也有一些方法返回的类型是NodeList,节点列表也不是数组，看起来像数组，但并不是。

#### DOM实例

[JavaScript HTML DOM 实例 (w3school.com.cn)](https://www.w3school.com.cn/js/js_examples_dom.asp)



#### **文档子节点**

可以使用document.documentElement属性，该属性始终指向HTML页面中<html>元素。另一个就是通过 childNodes 列表访问文档元素，但通过 documentElement 属性则能更快捷、更直接地访问该元素

document.documentElement;
document.childNodes[0];
document.firstChild;

输出结果是获取所有页面所有元素



