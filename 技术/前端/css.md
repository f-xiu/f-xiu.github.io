参考笔记[网页 (eveningwater.com)](https://www.eveningwater.com/)

![img](https://img-blog.csdnimg.cn/20210603193912150.png?x-oss-process=image/watermark,type_ZmFuZ3poZW5naGVpdGk,shadow_10,text_aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L21hb2ppYW9saW4=,size_16,color_FFFFFF,t_70)

#### 优先级及权重

##### css样式引用优先级

行内样式 > 内嵌样式 > 外链样式（ > 导入样式）



##### css选择器权重

* 标签内选择符> ID选择器 > 类，伪类，属性选择器 >元素和伪元素选择器

>  **行内样式（1000）>ID选择器（100）>类选择器（10）>标签选择器（1）>通用选择器（0）**
>
> 行内样式代表**内联样式**，如style=""，权值为 1000。

* 判断优先级时，首先我们会判断一条属性声明是否有权重，也就是是否在声明后面加上了!important。(它的优先级就是最高的)

* 相同权值的声明，根据样式引入的顺序，后声明的规则优先级高（距离元素出现最近的）	

* 这个叠加只限于对应的等级的叠加，不会产生进位。

#### 超链接

* a:link -正常状态，未访问过的状态。
* a:visited - 已访问过状态。
* a:hover - 当用户鼠标放在超链接上时的状态。
* a:active - 点击状态，超链接被用户点击的那一刻瞬间。

#### 高级选择器

* 更多[一些常见的伪类选择器_](https://blog.csdn.net/weixin_44570988/article/details/88931559?ops_request_misc=%7B%22request%5Fid%22%3A%22166005575516781790736301%22%2C%22scm%22%3A%2220140713.130102334..%22%7D&request_id=166005575516781790736301&biz_id=0&utm_medium=distribute.pc_search_result.none-task-blog-2~all~sobaiduend~default-1-88931559-null-null.142^v40^pc_rank_v36,185^v2^control&utm_term=常用的伪类选择器&spm=1018.2226.3001.4187)

* 更多[常有用的CSS伪选择器](https://blog.csdn.net/qf2019/article/details/115293479?ops_request_misc=&request_id=&biz_id=102&utm_term=常用的伪元素选择器&utm_medium=distribute.pc_search_result.none-task-blog-2~all~sobaiduweb~default-0-115293479.142^v40^pc_rank_v36,185^v2^control&spm=1018.2226.3001.4187)。



* **+:相邻兄弟选择器**, 介于两个选择器之间，`from+target`,当第二个元素*紧跟在*第一个元素之后，并且两个元素都是属于同一个父`元素`的子元素，则第二个元素将被选中
* **~：通用兄弟选择器**，`from~target`，选择from后边所有同级的target选择器。

* :before

  在指定的选择器之前插入一个元素。插入的元素默认为“行内元素”，可以通过“*display*”强制转换显示类型。但是插入了该元素之后，必须要指定“*content*”属性，否则，给它设置*CSS*属性将无效。*:after*选择器同理。

  ```
   p:before {
          content:"";
          color:#2396ef;
          font:28px "微软雅黑";
      }
  ```

* ### :first-of-type

  对该类所有父元素中的首个匹配到类型的子元素进行选择。写法结构如下:

  ```
   p:first-of-type {
          color:#2396ef;
      }
   //该类所在父元素中的子类首个p元素
  ```

* :only-child

  对该类所有父元素中只含有唯一所匹配（不包含同级元素）的子元素进行选择。写法结构如下:

  ```
   p:only-child {
          color:#2396ef;
      }
         
   //p元素的父元素的所有子元素中，仅有以一个该元素的（没有其他同级元素）   
  ```

*  :only-of-type

  对该类所有父元素中只含有唯一所匹配类型的子元素进行选择。写法结构如下:

  ```
    p:only-of-type {
          color:#2396ef;
      }
      //仅有一种该元素进行选择	
  ```

* :nth-child(n)

  对其父元素的第“*n*”个子元素进行选择，通过设置参数“*n*”指定为第几个元素。例如“:nth-child(4)”表示指定第四个元素。

* ### :nth-of-type(n)

  如果对前面所涉及到的选择器，如：“*:nth-child(n)*”等有足够深的理解了的话，应该不难猜到“*:nth-of-type(n)*”的作用，该选择器就是对匹配标签类型的同级元素进行选择。

  **也可以传入odd，even**

* :root

  该选择器选择[HTML](javascript:false;)页面的根节点元素，也就是*<html>*标签。该选择符不能选择任何其它[HTML](javascript:false;)文档内的标签，只能单独使用。

* [UI元素状态伪类选择器](javascript:false;)

#### 继承性

继承也需要在上下文中去理解 —— 一些设置在父元素上的 css 属性是可以被子元素继承的，有些则不能。

>  如果你设置一个元素的 `color` 和 `font-family` ，每个在里面的元素也都会有相同的属性，除非你直接在元素上设置属性。
>
> 一些属性是不能继承的 — 举个例子如果你在一个元素上设置`width`50% ，所有的后代不会是父元素的宽度的 50% 。如果这个也可以继承的话，CSS 就会很难使用了！

##### **祖先样式优先级：**

* 最近的祖先样式比其他祖先样式优先级高。
* "直接样式"比"祖先样式"优先级高。

##### **属性的继承性：**

[CSS的继承](https://blog.csdn.net/weixin_43946236/article/details/118675600?ops_request_misc=%7B%22request%5Fid%22%3A%22166008760716782395356284%22%2C%22scm%22%3A%2220140713.130102334..%22%7D&request_id=166008760716782395356284&biz_id=0&utm_medium=distribute.pc_search_result.none-task-blog-2~all~top_click~default-1-118675600-null-null.142^v40^pc_rank_v36,185^v2^control&utm_term=css继承&spm=1018.2226.3001.4187)

##### **控制继承**

###### 	通用属性值

​	CSS 为控制继承提供了五个特殊的通用属性值。每个 css 属性都接收这些值。

* **inherit:**设置该属性会使子元素属性和父元素相同。实际上，就是 "开启继承".

  ```
  <style>
      .parent{
          background-color: red;
      }
      
      .child{
          background-color: inherit;
      }
      ...
  </style>
  ```

* **initial：**设置属性值和浏览器默认样式相同。如果浏览器默认样式中未设置且该属性是自然继承的，那么会设置为 `inherit` 。（取该属性的默认值。）

* **unset：** 将属性重置为自然值，也就是如果属性是自然继承那么就是 `inherit`，否则和 `initial` 一样。（**可以继承**的属性取父元素的继承值，**不可以继承**的属性取默认值）

	<ul>
	    <li>Default <a href="#">link</a> color</li>
	    <li class="my-class-1">Inherit the <a href="#">link</a> color</li>
	    <li class="my-class-2">Reset the <a href="#">link</a> color</li>
	    <li class="my-class-3">Unset the <a href="#">link</a> color</li>
	</ul>
	
	
	body {
	    color: green;
	}
	          
	.my-class-1 a {
	    color: inherit;
	}
	          
	.my-class-2 a {
	    color: initial;
	}
	          
	.my-class-3 a {
	    color: unset;
	}
![image-20220810073720343](C:\Users\28597\AppData\Roaming\Typora\typora-user-images\image-20220810073720343.png)

###### all属性

CSS 的 shorthand 属性 `all` 可以用于同时将这些继承值中的一个应用于（几乎）所有属性。它的值可以是其中任意一个 (`inherit`, `initial`, `unset`, or `revert`)。这是一种撤销对样式所做更改的简便方法，以便回到之前已知的起点。

#### 盒模型

##### IE和标准盒子

由于一些“客观”的原因，*IE*浏览器和支持*W3C*标准的浏览器（也就是*5*大主流浏览器）的盒子模型有一定的差异。即*IE*浏览器的尺寸（*“width”*和*“height”*）包含了*content*、*padding*和*border*宽和高数值之和，它叫做“*IE6盒子模型*”（简称“*IE盒子模型*”）；而标准的盒子模型只包含*content*的宽和高部分的值，它们叫做“*W3C标准盒子模型*”（简称“*标准盒子模型*”）。

一方面为了兼容*IE*浏览器，另一方面是*IE*的盒子模型在实际的布局中的确更容易控制。所以我们在实际的开发工作中，都是将标准的盒子模型转换为*IE*的盒子模型。转换方式是将*CSS*的样式属性“*box-sizing*”的值设为“*border-box*”。

如果我们要将*IE*的盒子模型转化为标准的盒子模型也是可行的，即将“*box-sizing*”的值设置为“*content-box*”。

![图片加载中](https://www.eveningwater.com/static/image/CSSImages/css-box-model.jpg)

##### 块级盒子和内联盒子

一个被定义成块级的（block）盒子会表现出以下行为：

- 盒子会在内联的方向上扩展并占据父容器在该方向上的所有可用空间，在绝大数情况下意味着盒子会和父容器一样宽
- 每个盒子都会换行
- `width` 和 `height` 属性可以发挥作用
- 内边距（padding）, 外边距（margin）和 边框（border）会将其他元素从当前盒子周围“推开”

 如果一个盒子对外显示为 `inline`，那么他的行为如下：

- 盒子不会产生换行。
- [`width`](https://developer.mozilla.org/zh-CN/docs/Web/CSS/width) 和 [`height`](https://developer.mozilla.org/zh-CN/docs/Web/CSS/height) 属性将不起作用。
- 垂直方向的内边距、外边距以及边框会被应用但是不会把其他处于 `inline` 状态的盒子推开。
- 水平方向的内边距、外边距以及边框会被应用且会把其他处于 `inline` 状态的盒子推开。
- 用做链接的 `<a>` 元素、 `<span>`、 `<em>` 以及 `<strong>` 都是默认`inline` 状态的。

```
<p>
    I am a paragraph and this is a <span>span</span> inside that paragraph. A span is an inline element and so does not respect width and height.
</p>

   span {
  margin: 20px;
  padding: 20px;
  width: 80px;
  height: 50px;
  background-color: lightblue;
  border: 2px solid blue;
}
     
    
```

![image-20220810161913497](C:\Users\28597\AppData\Roaming\Typora\typora-user-images\image-20220810161913497.png)

在下面的示例中，我们在一个段落中使用了`<span>`，并对其应用了宽度、高度、边距、边框和内边距。可以看到，宽度和高度被忽略了。外边距、内边距和边框是生效的，但它们不会改变其他内容与内联盒子的关系，因此内边距和边框会与段落中的其他单词重叠。

**inline-block**

display 有一个特殊的值，它在内联和块之间提供了一个中间状态。这对于以下情况非常有用：您不希望一个项切换到新行，但希望它可以设定宽度和高度，并避免上面看到的重叠。

一个元素使用 `display: inline-block`，实现我们需要的块级的部分效果：

- 设置`width` 和`height` 属性会生效。
- `padding`, `margin`, 以及`border` 会推开其他元素。



##### **正常文档流**

独立元素布局：

> 默认的，一个[块级元素](https://developer.mozilla.org/zh-CN/docs/Web/HTML/Block-level_elements)的内容宽度是其父元素的 100%，其高度与其内容高度一致。[内联元素](https://developer.mozilla.org/zh-CN/docs/Web/HTML/Inline_elements)的 height ，width 与内容一致。你无法设置内联元素的 height， width --- 它们就那样置于块级元素的内容里。如果你想控制内联元素的尺寸，你需要为元素设置`display: block;` （或者，`display: inline-block;` inline-block 混合了 inline 和 block 的特性。)

元素之间相互影响：

> 正常布局流（在布局介绍里提到过）是一套在浏览器视口内放置、组织元素的系统。默认的，块级元素按照基于其父元素的[书写顺序](https://developer.mozilla.org/zh-CN/docs/Web/CSS/writing-mode)(*默认值：* horizontal-tb) 的*块流动方向 (block flow direction)*放置 --- 每个块级元素会在上一个元素下面另起一行，它们会被设置好的 margin 分隔。在英语，或者其他水平书写、自上而下模式里，块级元素是垂直组织的。
>
> 内联元素的表现有所不同 --- 它们不会另起一行；只要在其父级块级元素的宽度内有足够的空间，它们与其他内联元素、相邻的文本内容（或者被包裹的）被安排在同一行。如果空间不够，溢出的文本或元素将移到新的一行。
>
> 如果两个相邻的元素都设置了 margin 并且两个 margin 有重叠，那么更大的设置会被保留，小的则会消失 --- 这被称为外边距叠加。



##### 内部显示和外部显示类型

css 的 box 模型有一个外部显示类型，来决定盒子是块级还是内联。

同样盒模型还有内部显示类型，它决定了盒子内部元素是如何布局的。默认情况下是按照 **[正常文档流](https://developer.mozilla.org/zh-CN/docs/Learn/CSS/CSS_layout/Normal_Flow) **布局，也意味着它们和其他块元素以及内联元素一样 (如上所述).

通过使用类似 `flex` 的 `display` 属性值来更改内部显示类型。如果设置 `display: flex`，在一个元素上，外部显示类型是 `block`，但是内部显示类型修改为 `flex`。该盒子的所有直接子元素都会成为 flex 元素，会根据[弹性盒子（Flexbox）](https://developer.mozilla.org/zh-CN/docs/Learn/CSS/CSS_layout/Flexbox)规则进行布局。



##### **boder** 

只接受三个参数，分别是宽度、风格和颜色

`边界border`和轮廓`outline`很相似。然而轮廓在以下方面与边界不同

- 轮廓不占据空间，他们在元素内容之外绘制
- 根据规范，轮廓不必为矩形，尽管通常是矩形。

##### border-radius

通过使用 [`border-radius`](https://developer.mozilla.org/zh-CN/docs/Web/CSS/border-radius) 属性和与方框的每个角相关的长边来实现方框的圆角。可以使用两个长度或百分比作为值，第一个值定义水平半径，第二个值定义垂直半径。在很多情况下，您将只传递一个值，这两个值都将使用。





##### 可调元素大小resize

该属性是用于定义“块级元素”的大小是否可以调整、以何种方式（水平方向还是垂直方向）调整，该属性需要配合属性值为“*auto*”、“*hidden*”或“*scroll*”的“*overflow*”属性使用，但被调整大小的元素的宽和高不能小于它原始的宽和高。另外，“*resize*”属性有个特别案例，就是能够对表单元素*<textarea>*使用，并且无需显示的去设置“*overflow*”属性。

谈到“*resize*”这个属性，不得不提到两对属性，即“*max-width*”和“*max-height*”，它们分别表示元素允许的“最大宽度”和“最大高度”，与之对应的是“*min-width*”和“*min-height*”，它们分别表示元素允许的“最小宽度”和“最小高度”，它们的属性值等同于*width*与*height*的属性值。这四个属性除了在“*resize*”中运用比较多，在限制*<table>*单元格的宽高时也非常实用。

“*resize*”有四个值，如下:none,both,vertical,horizontal

```
section:first-of-type {
        overflow: auto;
        resize: horizontal;
    }
    
    section:nth-of-type(2) {
        overflow: hidden;
        resize: vertical;
    }
    
    section:nth-of-type(3) {
        overflow: scroll;
        resize: both;
    }
```

##### overflow

“*overflow*”属性和其分支属性可以设置以下值：

- visible:

  默认值。溢出内容不会被处理，溢出内容会超出元素的边界（对于有固定宽或高的元素，或者设置了文本不换行的元素）。

- hidden:

  溢出内容会被隐藏。就和将“*text-overflow*”属性的值设为“*clip*”的情况一样，而这个属性通常也需要配合“*overflow*”的该属性值来一起设置方能达到效果。

- scroll:

  始终滚动条的显示（内容没有溢出时滚动条内没有滑块只有轨道），通过滑动滚动条可以查看溢出元素边界的内容。

- auto:

  当内容没有溢出时不会出现滚动条，而内容超出容器边界时才会出现滚动条。



#### 背景

##### 背景图片

background-image属性允许在元素的背景中显示图像.

```
.a {
  background-image: url(balloons.jpg);
}

```

默认情况下，大图不会缩小以适应方框，因此我们只能看到它的一个小角，而小图则是平铺以填充方框。

##### 控制背景平铺

background-repeat属性用于控制图像的平铺行为。可用的值是：

- `no-repeat` — 不重复。
- `repeat-x` —水平重复。
- `repeat-y` —垂直重复。
- `repeat` — 在两个方向重复。

##### 调整图片大小(background-size)

我们有一个很大的图像，由于它比作为背景的元素大，所以最后被裁剪掉了。在这种情况下，我们可以使用 [`background-size`](https://developer.mozilla.org/zh-CN/docs/Web/CSS/background-size)属性，它可以设置长度或百分比值，来调整图像的大小以适应背景。

- `cover` —浏览器将使图像足够大，使它完全覆盖了盒子区，同时仍然保持其高宽比。在这种情况下，有些图像可能会跳出盒子外
- `contain` — 浏览器将使图像的大小适合盒子内。在这种情况下，如果图像的长宽比与盒子的长宽比不同，则可能在图像的任何一边或顶部和底部出现间隙。

##### bakcgound-attachment属性

背景图片的附着点有三类，分别是浏览器的可视区域、背景容器本身区域和背景容器的内容区域。具体来说，background-attachment的值也就有三种，即：

scroll：背景图片附着在背景容器上，它是相对于背景容器（元素）固定，它会随着背景容器的滚动，而不是随着它的内容滚动（也可以看成是对元素边框固定）。

fixed： 背景图片附着在浏览器的可视区域。因为浏览器的可视区域不具备滚动的性格，所以它是不滚动的。

local：这是CSS3新增的属性值。背景图片附着在背景容器的内容区域。它会随着内容的滚动而滚动。



##### background-position

background-position属性在css中用来设置背景图片的位置，它通过设置水平方向和垂直方向的取值来到达效果

1.关键字取值 

 通过使用关键字来定义图片的位置。其中

水平方向的关键字有left(左) center(中) right(右)

垂直方向的关键字有top(上) center(中) bottom(下)

使用方法，一般情况下先定义水平方向的关键字 然后定义垂直方向的关键字

```
background-position: left bottom/*这个样式设置的是水平方向的左 垂直方向的下 所以图片最终位置会在左下角*/
使用关键字来定义背景图片的位置虽然较为简单，但使用范围小，不能完整的作用到全部地方
```

2.百分比取值

 使用百分比取值来定义位置的时候也是定义水平和垂直两个方向的值。百分比取值也有默认的绝对位置

水平方向 0%(左) 50%(中) 100%(右)

垂直方向 0%(上) 50%(中) 100%(下)/*这六个值是默认的绝对位置的值*/

使用方法和关键字取值的使用大同小异，只不过百分比取值来定义位置会相对更加细致和精准

background-position: 0% 60%;
/*这里的参数表示水平方向靠左 垂直方向中间偏右*/
3.像素值取值

使用像素值的取值来定义图片的位置会使得图片的位置更见精准，同样也是通过设置水平方向和垂直方向来实现

像素值没有绝对的默认数值，它需要结合实际情况去调整数值

当设置的值为正数的时候 水平方向向右偏离 垂直方向向下偏移

当设置的值为负数的时候 水平方向向左偏移 垂直方向向上偏移

background-position: 80px -30px;
/*默认设置的值都是先设置水平方向 然后设置垂直方向
这里的水平方向的值为正数 所以图片在水平方向往右偏移 
垂直方向的值为负数 所以图片往上偏移
*/

##### 绝对长度单位

以下都是**绝对**长度单位——它们与其他任何东西都没有关系，通常被认为总是相同的大小。

| 单位 | 名称 | 等价换算            |
| :--- | :--- | :------------------ |
| `px` | 像素 | 1px = 1/96th of 1in |

##### 相对长度单位

相对于其他一些东西，比如父元素的字体大小，或者视图端口的大小。使用相对单位的好处是，经过一些仔细的规划，您可以使文本或其他元素的大小与页面上的其他内容相对应。下表列出了 web 开发中一些最有用的单位。

| 单位   | 相对于                                                       |
| :----- | :----------------------------------------------------------- |
| `em`   | 在 font-size 中使用是相对于父元素的字体大小，在其他属性中使用是相对于自身的字体大小，如 width |
| `ex`   | 字符“x”的高度                                                |
| `ch`   | 数字“0”的宽度                                                |
| `rem`  | 根元素的字体大小                                             |
| `lh`   | 元素的 line-height                                           |
| `vw`   | 视窗宽度的 1%                                                |
| `vh`   | 视窗高度的 1%                                                |
| `vmin` | 视窗较小尺寸的 1%                                            |
| `vmax` | 视图大尺寸的 1%                                              |



#### CSS显示浮动与定位

> html中元素会按照标准的“文档流”布局方式进行布局，即“从左到右，从上到下”的方式进行布局。
>
> 而通过*CSS*里面的部分定位和显示方式的设置可以使元素脱离“文档流”，采用特殊的布局方式进行布局，或者在页面中进行“隐藏”，而“隐藏”在*CSS*中又有两种定义方式，一种可以脱离“文档流”，一种仍然存在于“文档流”的布局中。

##### 浮动

1、 CSS 浮动属性简介
CSS float 属性是一个定位属性，用于使元素脱离正常的文档流，并浮动在它的父容器的左侧或右侧
float 设置元素在水平方向浮动，意味着元素只能左右浮动而不能上下浮动

2、float 属性的常用值包括:
left 靠左浮动
right 靠右浮动
none 不浮动

![img](https://img-blog.csdnimg.cn/2021060318403757.png?x-oss-process=image/watermark,type_ZmFuZ3poZW5naGVpdGk,shadow_10,text_aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L21hb2ppYW9saW4=,size_16,color_FFFFFF,t_70)

3.清除浮动

当容器的高度为auto,且容器的内容中有浮动（float为left或right）的元素，在这种情况下，容器的高度不能自动伸长以适应内容的高度，使得内容溢出到容器外面而影响布局的现象，为了防止这个现象的出现而进行的CSS处理，就叫CSS清除浮动。

![img](https://img-blog.csdn.net/20161123130714442)

1. 通常是给一个高度“*height*”设置为“*0*”的“块级元素”使用，要保证该“块级元素”内没有内容。(在浮动元素后使用一个空元素,设置该元素的clear属性为：left,right,both)

​			**这个规则只能影响使用清除的元素本身，不能影响其他元素**

```
 <div className='float'>
          <div className='box'>1</div>
          <div className='box'>2</div>
          <div className='box'>3</div>
          <div className='clear'></div>
  </div>
  
    .float{
    width: 300px;
  }
  .box{
    float: left;
  }

  .clear{
    clear: both;
  }
  这样float容器就会有高度。如果没有clear高度就是0，这样后续的元素会忽略该元素的高度。
```

2.父级div定义 overflow: auto（注意：是父级div也就是这里的 div.outer）

```
<div class="outer over-flow"> //这里添加了一个class
    <div class="div1">1</div>
    <div class="div2">2</div>
    <div class="div3">3</div>
    <!--<div class="clear"></div>-->
</div> 

.over-flow{
    overflow: auto; zoom: 1; //zoom: 1; 是在处理兼容性问题
}
```

使用overflow属性来清除浮动有一点需要注意，overflow属性共有三个属性值：hidden,auto,visible。我们可以使用hiddent和auto值来清除浮动，但切记不能使用visible值，如果使用这个值将无法达到清除浮动效果，其他两个值都可以。

3.:after 方法：

它就是利用:after和:before来在元素内部插入两个元素块，从而达到清除浮动的效果。其实现原理类似于clear:both方法，只是区别在于:clear在html插入一个div.clear标签，而outer利用其伪类clear:after在元素内部增加一个类似于div.clear的效果。
.outer:after {clear:both;content:'.';display:block;width: 0;height: 0;visibility:hidden;} 

**其中clear:both;指清除所有浮动；content: ‘.’; display:block;对于FF/chrome/opera/IE8不能缺少，**



##### 定位

* **静态定位**是每个元素获取的默认值——它只是意味着“将元素放入它在文档布局流中的正常位置 ——这里没有什么特别的。

  ```
  .positioned {
    position: static;
    background: yellow;
  }
  ```

* **相对定位**：它与静态定位非常相似，占据在**正常的文档流**中，除了你仍然可以修改它的最终位置，包括让它与页面上的其他元素重叠。

  [`top`](https://developer.mozilla.org/zh-CN/docs/Web/CSS/top), [`bottom`](https://developer.mozilla.org/zh-CN/docs/Web/CSS/bottom), [`left`](https://developer.mozilla.org/zh-CN/docs/Web/CSS/left), 和 [`right`](https://developer.mozilla.org/zh-CN/docs/Web/CSS/right) 来精确指定要将定位元素移动到的位置。

  ```
  position: relative;
  top: 30px;
  left: 30px;
  ```

* **绝对定位**带来了非常不同的结果。绝对定位的元素**不再存在于正常文档布局流**中。

  哪个元素是绝对定位元素的“包含元素“？这取决于绝对定位元素的父元素的 position 属性。

> 父元素都没有显式地定义 position 属性，那么所有的父元素默认情况下 position 属性都是 static。结果，绝对定位元素会被包含在**初始块容器	**	中。
>
> 我们可以改变**定位上下文** —— 绝对定位的元素的相对位置元素.

* **固定定位**，定位覆盖——fixed。这与绝对定位的工作方式完全相同，只有一个主要区别：绝对定位将元素固定在相对于其位置最近的祖先。

  而固定定位固定元素则是相对于浏览器视口本身。

###### zindex

当元素开始重叠，什么决定哪些元素出现在其他元素的顶部？

 “z-index”是对 z 轴的参考。你可以从源代码中的上一点回想一下，我们使用水平（x 轴）和垂直（y 轴）坐标来讨论网页，以确定像背景图像和阴影偏移之类的东西的位置。 （0,0）位于页面（或元素）的左上角，x 和 y 轴跨页面向右和向下（适合从左到右的语言，无论如何）。





#### 布局

##### 弹性盒子

```
  display:flex
  //假如你想设置行内元素为 flexible box，也可以置 display 属性的值为 inline-flex。
```

- **主轴**（main axis）是沿着 flex 元素放置的方向延伸的轴（比如页面上的横向的行、纵向的列）。该轴的开始和结束被称为 **main start** 和 **main end**。
- **交叉轴**（cross axis）是垂直于 flex 元素放置方向的轴。该轴的开始和结束被称为 **cross start** 和 **cross end**。
- 设置了 `display: flex` 的父元素被称之为 **flex 容器（flex container）。**
- 在 flex 容器中表现为柔性的盒子的元素被称之为 **flex 项**（**flex item**）。

###### 属性：

1. 行/列，默认值为row,`flex-direction: column`方向设为列;

2. 控制 从左到右/从右到左,`direction:ltr; direction:rtl;`

3. *justify-content*属性，可以让弹性子元素在水平方向沿着弹性容器的主轴线（*main axis*）对齐。该属性有如下一些值:flex-start,flex-end,center,

   space-between（在每行上均匀分配弹性元素。相邻元素间距离相同。每行第一个元素与行首对齐，每行最后一个元素与行尾对齐。）

   space-around（相邻元素间距离相同。每行第一个元素到行首的距离和每行最后一个元素到行尾的距离将会是相邻元素之间距离的一半）

   space-evenly（均匀分布在指定的对齐容器中。相邻flex项之间的间距。）

​			4.*align-items*属性可以让弹性子元素在纵轴上对齐，即垂直方向的对齐方式。该属性有如下一些值:

​				flex-start，flex-end，center

​				baseline：所有元素向基线对齐。侧轴起点到元素基线距离最大的元素将会于侧轴起点对齐以确定基线。

​				stretch：弹性元素被在侧轴方向被拉伸到与容器相同的高度或宽度。

​			5.子元素换行

​				*flex-wrap*属性可以指定弹性盒子的子元素换行方式。它有如下的属性值:

​					nowrap默认， 弹性容器为单行。该情况下弹性子项可能会溢出容器。(子项会被不断地压缩)

​					wrap弹性容器为多行。该情况下弹性子项溢出的部分会被放置到新行，子项内部会发生断行。

​			6.子元素的行对齐

​				在flex-wrap设置为多行的情况下，*align-content*可以控制每一行的对其方式,需要注意的就是它不是设置子元素的			对齐方式，该属性对单行弹性盒子模型无效，即*flex-wrap: nowrap*（相当于纵轴的justify-content）

​				flex-wrap:nowrap,align-content无论设置什么值都不变

​				flex-wrap:wrap;align-content:baseline;

​				flex-wrap:wrap-reverse;align-content:center;

###### items和content

items是弹性盒子中每一项视作一个（item),

align-items可以在垂直方向上调整每一项的对其方式 (这里是center)

![image-20220811161053396](C:\Users\28597\AppData\Roaming\Typora\typora-user-images\image-20220811161053396.png)

align-content则是垂直方向上内容的排列，类似于justify-content  (这里是space-between)

![image-20220811161255349](C:\Users\28597\AppData\Roaming\Typora\typora-user-images\image-20220811161255349.png)

justify-items: `start` 是将 网格项中的内容 对齐到其网格区域（grid area）行轴线的起始边缘（Justifies content of grid items with the starting edge of the grid area along the row-axis）
![在这里插入图片描述](https://img-blog.csdnimg.cn/20191105170413764.png?x-oss-process=image/watermark,type_ZmFuZ3poZW5naGVpdGk,shadow_10,text_aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L3UwMTM1NjUxMzM=,size_16,color_FFFFFF,t_70)

###### 动态尺寸

如何控制 flex 项占用空间的比例的， flex: 1;

```
article {
  flex: 1 200px;
}
表示 flex 项将首先给出 200px 的可用空间，然后，剩余的可用空间将根据分配的比例共享“
```

#### 字体样式

* font-style:

  > normal:普通字体（默认值）。
  >
  > italic：斜体（对于没有斜体变量的特殊字体，将应用*oblique：*）。
  >
  > oblique：倾斜字体（会让一些没有斜体的特殊字体也拥有倾斜效果）。

* font-weight:

  > ## 字体粗细
  >
  > normal:正常粗细。
  >
  > bold:粗体。
  >
  > bolder:更粗的字体。
  >
  > lighter:更细的字体。
  >
  > 100~900:步长为*100*。其中*400*等同于*normal*，*700*等同于*bold*。

..................

#### 文本格式

##### 对齐

水平对齐：`text-align`  left（默认）:左对齐。center:居中对齐。right:右对齐。justify:两端对齐。

垂直对齐：`vertical-align` 

* top:把文本**元素的顶端与行中最高的文本元素的顶端对齐**（文本元素不一定是字体，以下同理）。
* middle:以文本元素的**中心点**为参照与行内**其它文本元素的中心**进行对齐。
* bottom:把文本元素的**底端**与行中**最低的文本元素的底端**进行对齐。
* sub：以文本元素的下标为参照与其它文本元素进行对齐。
* super:以文本元素的上标为参照其它文本元素进行对齐。
* text-top:把文本元素的顶端与行中最高的字体的顶端进行对齐。
* text-bottom:把文本元素的底端与行中最低的字体的顶端进行对齐。

##### text-indent

首行缩进用于“行内元素”设置每个段落首行缩进数量值的属性，*CSS*字体大小（*font-size*）可以设置的数值和单位在该属性的值中都可以使用（除了百分比）

```
text-indent:2em;
```

##### text-decoration

文本装饰线,该属性是为文本字符添加一根“装饰线”。在[HTML](javascript:false;)中，带有*“href”*属性的*<a>*标签默认带有一根装饰线（表现为下划线），就是因为浏览器会将*<a>*标签的该属性默认设置为*“underline”*才如是呈现的。*“text-decoration”*属性有以下值：

- none（默认）:

  不显示任何装饰线，或消除已有的装饰线（需要更高权重）。

- underline:

  在文本下方显示装饰线（称作“下划线”），效果如同[HTML](javascript:false;)的*<u>*标签。

- overline:

  在文本上方显示装饰线（称作“上划线”）。

- line-through:

  在文本中间显示装饰线（称作“删除线”或“中划线”），效果如同[HTML](javascript:false;)的*<s>*或*<del>*标签。

**text-decoration-style:**设置样式，solid:实线（默认）。double:双实线。dotted:点线。dashed:虚线。wavy:波浪线。



##### text-transform

大小写转化。none（默认）:保持文本中英文单词的默认大小写。capitalize:将每个英文单词首字母转换为大写字母（对于单个单词而言，如果该单词是全大写字母的，则不发生任何转换）。uppercase:将所有英文单词转换为大写字母。lowercase:将所有英文单词转换为小写字母。



##### text-shadow:

四个值

水平方向阴影偏移（hoff-shadow）:*“0”*表示维持原位，正数为向右偏移，负数为向左偏移。单位为像素*“px”*。

垂直方向阴影偏移（voff-shadow）:*“0”*表示维持原位，正数为向下偏移，负数为向上偏移。单位为像素*“px”*。

阴影模糊距离（blur）:用正数表示阴影模糊的单位距离，距离越大模糊程度越高，单位为像素*“px”*。

阴影的颜色（color）:支持*Web*技术中的常用颜色模式：颜色英文单词和*HEX*、*RGB*、*HSL*以及带有*Alpha*通道的以上颜色值。

```
 /* 文本阴影 */
    .textshadow-1 {
        text-shadow: -2px 3px 3px blue;
    }
```

##### 段落文本行高“line-height”

该属性是用于设置“行内元素”中的文本字符在一行中所占据的高度，可以使用的值可以是像素值、百分比，或不带单位的浮点数（*“1”*表示*“100%”*，*“1.5”*表示*“150%”*，以此类推）。

##### 单词的间距“word-spacing”

该属性用于设置英文单词之间的间距，中文则是设置文本中空格的距离，单位为*Web*技术的常用度量单位，如“像素（*px*）”，“字符（*em*）”，“点（*pt*）”等，可以为负数。

##### 字符的间距“letter-spacing”

和*“word-spacing”*有所不同，该属性是用于控制字符间的间距，即无论单词或词语中是否含有空格（该属性对空格字符无效），该属性都会生效



##### 空格换行符处理“white-space”

该属性和*“word-break”*及*“word-wrap”*不同，从字面意思*“white space”*（直译为“空白”）上来讲，它是用于处理元素内出现的空格符和换行符的，而不是针对普通字符的。它主要有以下值：

- normal（默认）:

  由浏览器处理空格符和换行符。

- pre:

  段落里所有的空格符和换行符都会被保留。作用同于*<pre>*标签。

- nowrap:

  段落内的文本不会换行，已经换行的文本也会强制设为不换行的形式。

- pre-wrap:

  段落里所有的空格符序列和换行符序列都会被保留（除了在某些编码格式下和*<pre>*有所差距，大多数时候可以说它和*<pre>*这个值是等价的）。

- pre-line:

  多空格会合并成一个，但换行符会保留

##### 单行文本裁切“text-overflow”

该属性规定当文本溢出包含元素时进行的处理。该属性主要包含两个值：

- ellipsis:

  显示省略符号来代表被裁剪的文本。

- clip:

  裁剪文本。

不过该属性不能单独使用，要想完美实现它的功能要**首先保证元素应该有一个宽度属性*“width”***（像素和百分比单位都可以），然后是必须要配合空格符和换行符处理属性*“white-space”*和内容溢出处理属性*“overflow”*来使用

```
 
 
 .text-overflow-ellipsis{
 		width: 800px;
        font: 20px "微软雅黑";
        text-overflow: ellipsis;
        white-space: nowrap;
        overflow: hidden;
    }
```

##### 多行文本裁切“-webkit-line-clamp”



```
 
    <article>
        <section>
            <p>生也风雨，死也风雨，但有情深生死许。多情诚把心伤透，痴情却得不相守。不怨何如，怨又何如，人间只道情最苦。纵使数言欲先语，未料涕泪似水流。</p>
            <p>平生未会恋芬芳，才恋芬芳，便失芬芳。终日惶惶害相思，回首苦恨，盘如蛛网。天公不敢作月老，断了红线，拆了相逢。缘尽缘始终不知，记得初见，犹似庄梦。</p>
            <p>墨发眼媚一丹唇，曼姿弱影更动神。一见钟情不惊人。愿为芬芳敌风雪，何畏花意未有君。羞言无那隐于心。</p>
            <p>闻说伊言人易散，语罢更怜裙衩难。世间伉俪千千万，岂无一双并蒂莲？</p>
        </section>
    </article>
 
 article {
        width: 960px;
        background-color: #ffffff;
        margin: 20px auto;
        overflow: hidden;
        padding: 20px;
        border-radius: 5px;
        box-shadow: 0 0 2px 3px rgba(123,14,15,.3);
    }
    article p {
        text-indent: 2em;
        -webkit-line-clamp:2;
        overflow: hidden;
        text-overflow: ellipsis;
        display: -webkit-box;
        -webkit-box-orient: vertical;
    }
```

![图片加载中](https://www.eveningwater.com/static/page/CSS/codeImages/css-code-49.png)

#### 过渡特效

设置过渡特效的属性叫做“*transition*”，该属性允许*CSS*的属性值在一定的时间区间内平滑地过渡。

##### transition-property

执行变换的属性,该属性是用来指定当元素其中一个属性改变时执行的过渡动画效果，该属性有三种类型的值：

- none

  将过渡效果设置为“无过渡效果”，或停止当前过渡效果。

- all（默认）

  为所支持的所有*CSS*属性在值变化时执行动画过渡效果。

- [property name]

  指定一个或多个属性名称列表，以逗号“*,*”进行分隔，当指定的属性产生变化时，为其执行指定属性的动画过渡效果。

```
 p {
        /*无过渡效果*/
        transition-property:none;
        /*默认过渡效果，所有*/
        transition-property:all;
        /*CSS属性名*/
        transition-property:background; 
        /*CSS多个属性名*/
        transition-property:background,width;
    }
       
```

##### transition-duration

过渡执行的时间,

```
  p {
        /*0s*/
        transition-duration:0;
        /*1s*/
        transition-duration:1s;
    }
```

该属性是用于设定一个属性的值过渡被触发开始时到结束时所需要经历的时间，单位为秒（*s*），如：“*0.3s*”或“*.3s*”,它的默认值为“*0*”，单位不能省略，否则过渡动画无法执行。



##### transition-timing-function

过渡时间曲线,该属性允许你根据时间的推进去改变属性值的变换速率

ease:默认值，逐渐变慢。

linear:匀速。

ease-in:加速。

ease-out:减速。

ease-in-out:先加速，后减速。

cubic-bezier([参数])

##### transition-delay

过渡延迟,该属性规定在用户进行操作后多久开始执行动画，也就是延迟执行过渡动画的时间，单位同样是秒“*s*”，写法与“*transition-duration*”一致，默认值同样为“*0*”。

##### 综合的“transition”

 [选择器] {        transition: "执行过渡的属性(transition-property)" "执行过渡的时间(transition-duration)" "执行过渡的速度曲线(transition-timing-function)" "过渡延迟时间(transition-delay)";    }

```
  p {
        /*所有属性生效，速度为逐渐变慢，时间为1s，延迟时间为0.1s*/
        transition: all 1s ease .1s;
    }
            
```

#### css变形变换

##### transform之translate

该属性值可以让元素从当前位置根据“*left*（*X*轴）”参数和“*top*（*Y*轴）”参数的设置在水平和垂直方向进行移动。

在进行移动后，自身的位置仍然保留，也不会影响到其它元素的位置，但又存在着区别：

- “*translate*”可以作用于已经执行了“绝对定位（*position：absolute*）”的元素，而要用“*position*”已经设置为了“绝对定位”的元素使用“相对定位（*position：relative*）”需要对布局进行重新计算，或修改*DOM*的标签嵌套方式。
-  使用“*translate*”可以让[GPU](https://baike.baidu.com/item/图形处理器/8694767?fromtitle=gpu&fromid=105524&fr=aladdin)参与运算，动画的[FPS](https://baike.baidu.com/item/FPS/3227416?fr=aladdin)更高。
-  使用“*translate*”可以让动画的像素精确到浮点数，而使用“*position*”属性的值最小执行动画的单位是*1*像素。

“*position*”属性是为布局而生，而“*transform*”的“*translate*”是为动画而生。

```
section:first-child:hover {
        transform: translate(20px, 10px);
    }
```

##### transform之旋转“rotate”

该属性值会让元素以当前元素的中心(*X=width/2，Y=height/2*)进行旋转（若不对“*transform-origin*”进行设置），旋转的角度为参数所设定的值，“正数”是顺时针，“负数”是逆时针，单位为“*deg*”。

该属性值有三种类型：“*rotateX*”、“*rotateY*”和“*rotateX*（也作*rotateZ*）”：“*rotateX*”设置元素在X轴方向的旋转，“*rotateX*”设置元素在Y轴方向的旋转，“*rotate*”设置元素在*Z*轴（垂直于元素平面的线）方向的旋转。

```
 section:first-of-type:hover {
        transform: rotateX(60deg);
    }
```

##### transform之缩放“scale”

该属性值会让元素以当前元素的中心进行缩放，参数的值为一个整数或浮点数，如：“*1*（默认）”不进行缩放，“*0.8*”缩小为原来的*80%*，“1.5”扩大到原来的*150%*，参数不需要单位。

该属性值有三种类型：“*scaleX*”、“*scaleY*”和“*scale*”：“*scaleX*”设置元素在*X*轴方向的缩放，“*scaleY*”设置元素在*Y*轴方向的缩放，“*scaleY*”可以同时设置元素在*X*轴和*Y*轴方向的缩放，参数间用逗号“*,*”进行分隔。

```
section:first-of-type:hover {
        transform: scaleX(.6);
    }
```



##### transform之倾斜“skew”

该属性值会让元素根据水平（*X*轴）和垂直（*Y*轴）线参数设定倾斜角度。该属性值有三种类型：“*skewX*”、“*skewY*”和“skew”。“*skewX*”只有一个参数，用于控制元素在水平轴方向的倾斜，“*skewY*”同样只有一个参数，用于控制元素在垂直轴方向的倾斜，“*skew*”有两个参数（一个参数相当于“*skewX*”），分别控制元素在水平和垂直轴方向的倾斜，参数间用逗号“*,*”进行分隔。 参数的单位设置与*rotate*相同。

```
section:first-of-type:hover {
        transform: skewX(10deg);
    }
```

transform组合使用

*transform*”属性也能采用多值组合的方式来实现一个CSS的复杂效果

若该属性配合过渡*CSS*特效“*transition*”属性来使用的话，值的先后顺序不一样，很多时候效果也是不一样的，需要根据需要去调整值设置的顺序。

```
  section:hover {
        /*执行顺序为先偏移，再旋转，最后缩放*/
        transform: translate(50px,80px) rotate(90deg) scale(0.8,1.2);
	}
```

##### 变换原点“transform-origin”

该属性用于设置旋转元素的原点（基点）位置，默认为元素的中点。可以为*3*种类型的值：“方位英文单词”，“*Web*常用长度单位”，“百分数”。

- 方位英文单词

  有“top”、“right”、“bottom”、“left”和“center”5个值可以使用，如“top left”表示左上角，“right bottom”表示右下角，“center center”表示默认的中点。

- Web常用长度单位

  如最常用的像素“px”，字符“em”，点“pt”等，如：“16px 20px”表示旋转的轴在“X轴”的16像素，“Y轴（向下为正，向上为负）”的20像素的位置。

- 百分数

  第一个百分数表示相对于元素宽度的百分比位置，第二个百分数表示相对于元素高度的百分比位置，如：“0% 0%”相当于左上角，“50% 50%”相当于默认的中点，“100% 100%”相当于元素的右下角。

#### css动画

在*CSS*中执行动画的属性是*CSS3*属性中的“*animation*”，该属性可以让元素随着时间的推移，产生“位置”、“形状”、“颜色”、“大小”、“透明度”等属性变化。

它和“*transform*”的不同之处在于，它可以不需要任何事件的激活（当然也可以通过事件激活），让元素本身就“挂载”一系列的*CSS*属性变化。他和“*transform*”的不同之处在于，它并不需要“*transition*”的过渡特效，让元素可以通过“关键帧”的设置达到想要的动画运行的“速度曲线（贝塞尔曲线）”。

它可以单独地存在，即可以不依赖任何选择器，但可以提供给任何与它动画内容匹配并且“显示类型”支持的选择器调用，除此之外还有一个很显著的区别，就是它能够“无限次”地执行动画效果。

##### 动画名称“animation-name”

```
 @keyframes changeWidth {
        /*执行动画*/
    }
    

在CSS选择器中调用就像如下这样:
    [选择器] {
        /*动画名为changeWidth*/
        animation-name:changeWidth;
    }
    
    
```

##### 关键帧的两种定义方式

* 英文单词，from和to,该模式只包含两个关键帧。

* 百分数模式

  该模式相对“英文单词”定义关键帧的模式更为详细，能够支持理论上从“0%”到“100%”之间的所有帧的定义，“0%”相当于“from”，表示动画开始帧，“100%”相当于“to”，表示动画结束帧。该模式由于控制的精细度高，书写修改容易，甚至可以通过“定义百分比的跳跃”或“CSS属性值的跳跃”来实现动画的“匀速”、“加速”、“减速”，“变速”等动画速率的变化，非常地灵活，所以这种写法也是现今最主流的定义动画关键帧的方式。

动画执行时间“animation-duration”

动画速度“animation-timing-function”

动画时间的延迟“animation-delay”



##### 动画播放的次数“animation-iteration-count”

该属性用于设置动画播放的次数。它可以设置*3*种类型的值：

- 1（默认值）

  表示在执行某事件后只执行1次动画。

- [number]

  任意正整数，表示在执行某事件后只执行[number]次动画。

- infinite

  表示在执行某事件后“无限次”执行动画。

  

##### “animation-direction”

动画周期逆向播放,该属性用于设置元素动画是否能够周期性地逆向播放，逆向动画播放的进行时间和“正向播放”一致，时间速度曲线会按照“*100%（to）*”到“*0%（from）*”的方向进行。

```
 animation-direction: alternate;
```



##### “animation-play-state”

动画的播放和暂停,该属性用于设置动画的播放和暂停状态，它有两个值：

- running

  播放动画。

- paused

  暂停动画。



##### “animation-fill-mode”

设定元素动画形态,经过之前“*animation*”属性的学习应该会发现一个问题，就是若不将动画的“*animation-iteration-count*”属性设置为“*infinite*”值的话，动画在播放完成后会还原到元素没有“挂载”动画播放效果之前的状态，在有的应用场景里这样似乎没有问题，但在有些应用场景下，这样的设定会让人有一种“瞎忙活”或“功败垂成”的感觉。而“*animation-fill-mode*”属性的出现克服了这个问题，它可以预设值动画播放前的“第一帧”和保留动画播放完成后的“最后一帧”，可以通过以下值进行设置：

backwards

让元素保持动画第一帧定义里所设置的CSS属性，直到动画开始执行。

forwards

让元素保持动画播放结束后最后一帧定义里所设置的CSS属性。

both

让元素保持动画第一帧里定义的CSS属性，直到动画开始，动画播放完成后又保持动画最后一帧的属性。



##### CSS动画组合值写法

```

        [选择器] {
            animation:name(动画名称) duration(动画执行时间) timing-function(动画速率) delay(动画延迟时间) iteration-count(动画执行次数) direction(动画执行方向) play-state(动画播放状态) fill-mode(动画播放形态);
        }
                    
```



#### 响应式设计

##### 媒体查询

* 使用@media查询，可以针对不同的媒体类型定义不同的样式

  @media可以针对不同的屏幕尺寸设置不同的样式

  当你重置浏览器大小的过程中，页面也会根据浏览器的宽度和高度重新渲染页面

  目前针对很多苹果手机、Android手机，平板等设备都用得到媒体查询

  ```
  @media mediatype and|not|only (media feature){
        css-code;
  }
  ```

*  媒体类型

  > *媒体类型*（*Media types*）描述设备的一般类别。除非使用 `not` 或 `only` 逻辑操作符，媒体类型是可选的，并且会（隐式地）应用 `all` 类型。
  >
  > `all`,`print`,`screen`,`speech`。
  >
  > ![img](https://img-blog.csdnimg.cn/62e73f971dcd40738f521e5ab64c4efd.png#pic_center)

* 关键字

  关键字将媒体类型或多个特性连接到一起做为媒体查询的条件

  * and：可以将多个媒体特性连接到一起，相当"且"于的意思

  * not：排除某个媒体类型，相当于"非"的意思，可以省略
  * only：指定某个特定的媒体类型，可省略

* 媒体特性

  每种媒体类型都具备各自不同的特性，根据不同媒体类型特性设置不同的展示风格，简单先了解三个

​				![img](https://img-blog.csdnimg.cn/3ea213eb798242c2b3eb8351696ac21e.png#pic_center)



#### 其他

##### 定义变量

CSS中原生的变量定义语法是：--\*，变量使用语法是：var(--\*) ； 其中*表示我们的变量名称;

```

css中定义变量
 
定义变量可分多种情况：
1、定义全局变量
:root {
  --borderColor: #ccc;
}
使用：width:var(--borderColor);
2、定义某元素下的变量
.look{
  --borderColor: #ccc;
}
 
3、定义媒体查询下的变量
@media screen and (min-width: 1025px) { 
    :root { 
        --borderColor: #ccc;
　　 }
}
使用：
.has-border-table > tr > td {
  border-right: 1px solid var(--borderColor);
}

```

```
js操作css变量
在 JS 代码中，我们可能需要读取 CSS 变量的值，其方法如下：
const root = document.querySelector(":root");
// 设置 CSS 变量
root.style.setProperty("--main-bg-color", "red");
// 读取 CSS 变量
const computedStyle = getComputedStyle(root);
const mainBgColor = computedStyle.getPropertyValue("--main-bg-color");
console.log(mainBgColor);
// 删除 CSS 变量
root.style.removeProperty("--main-bg-color");
```

