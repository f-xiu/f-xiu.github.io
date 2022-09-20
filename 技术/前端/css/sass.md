[(2条消息) Sass详解_RayShyy的博客-CSDN博客_sass详解](https://blog.csdn.net/weixin_45112114/article/details/124437438)

LibSass和基于它构建的软件包，包括Node Sass，[已被弃用](https://sass-lang.com/blog/libsass-is-deprecated)。如果您是 Node Sass 的用户，则可以通过在文件中替换或运行以下命令来迁移到 Dart Sass

```
$ npm uninstall node-sass
$ npm install sass
```



[Less语法的简单使用_Concise200的博客-CSDN博客](https://blog.csdn.net/qq_45890970/article/details/123449268)



### 继承

`@extend 元素选择器`

```
// .scss文件
.box1 {
	width: 200px;
	height: 200px;
}

// box2 继承 box1的样式
.box2 {
	@extend .box1;
}
```

**不过继承要慎用**，被继承相关的元素的样式也会继承过去，您看下面的例子：

被继承的子元素样式也会继承过去

```
// .scss文件
.box1 {
	width: 200px;
	height: 200px;
}
.box1 div {
	width: 100px;
}

// box2 继承 box1的样式
.box2 {
	@extend .box1;
}
--------------------------------------

// 生成的css代码
.box1, .box2 {
  width: 200px;
  height: 200px;
}

.box1 div, .box2 div {
  width: 100px;
}

```



### mixin

```
mixin相当于已经定义好了一类样式，可以在任何地方重复的使用它，就跟js中的函数一样。
```

#### 简单使用

```
@mixin name {
	css样式
}

// .scss文件
// 定义一个mixin
@mixin box-style {
	width: 200px;
	height: 200px;
	background: #000;
}
// 使用
.box {
	@include box-style;
	// 当然也可以继续在这里添加样式
	border-radius: 5px;
}
--------------------------------------

// 生成的css代码
.box {
  width: 200px;
  height: 200px;
  background: #000;
  border-radius: 5px;
}
```

这种复用的方法比继承更好

#### 带参数

```
@mixin name ($param1，$param2， ...) {
	css样式
}
// .scss文件
$box-width: 200px;
$box-height: 200px;

// 定义一个mixin
@mixin box ($width, $height) {
	width: $width;
	height: $height;
}
// 使用
.box {
	// 1. 第一种用法, 直接将css样式写入
	@include box(200px, 200px);

	// 2. 第二种, 将定义好的变量写入
	@include box($box-width, $box-height);
}

--------------------------------------

// 生成的css代码
.box {
  width: 200px;
  height: 200px;
}

```





