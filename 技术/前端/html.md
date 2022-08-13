#### `<html>`文档介绍

```html
<!DOCTYPE html>
<html>
  <head>
    <meta charset="utf-8">
    <title>我的测试站点</title>
  </head>
  <body>
    <p>这是我的页面</p>
  </body>
</html>
```

*  `<!DOCTYPE html>` 是最短有效的文档声明。

* `<html></html>`: `<html>`元素。这个元素包裹了整个完整的页面，是一个根元素。

* `<head></head>`: `<head>`元素。这个元素是一个容器，它包含了所有你想包含在 HTML 页面中但不想在 HTML 页面中显示的内容。这些内容包括你想在搜索结果中出现的关键字和页面描述，CSS 样式，字符集声明等等。

* `<body></body>`: `<body>`元素。包含了你访问页面时所有显示在页面上的内容，文本，图片，音频，游戏等等。

* 导入css样式文件`<link rel="stylesheet" href='' >`

* 导入脚本文件`<script src="./script.js"></script>`,常放在body中或html中。

* 可以（而且有必要）为站点设定语言，这个可以通过添加 [`lang` 属性](https://developer.mozilla.org/zh-CN/docs/Web/HTML/Global_attributes/lang)到 HTML 开始的标签中来实现（参考 [meta-example.html](https://github.com/mdn/learning-area/blob/main/html/introduction-to-html/the-html-head/meta-example.html)），如下所示：

  ```
  <html lang="zh-CN">
  .....
  </html>
  ```

#### `<head>`中有什么

* `<title>`:文档标题

`<meta>`:

1. 指定字符编码

   `<meta charset='utf-8' >`

2. 许多 `<meta>` 元素包含了 `name` 和 `content` 属性：

   - `name` 指定了 meta 元素的类型；说明该元素包含了什么类型的信息。
   - `content` 指定了实际的元数据内容。

   这两个 meta 元素对于定义你的页面的作者和提供页面的简要描述是很有用的。让我们看一个例子：

   ```html
   <meta name="author" content="Chris Mills">
   <meta name="description" content="The MDN Web Docs Learning Area aims to provide
   complete beginners to the Web with all they need to know to get
   started with developing web sites and applications.">
   ```

   description 也被使用在搜索引擎显示的**结果页**中

#### 文本基础

* `h1-h6`：六级标题
* `p`：表示段落，会换行
* `span`:行内元素
* 列表：`<ul>无序，<ol>有序，<li>表示每一段`
* `<em>`:斜体。`<strong>`:粗体。
* 如果没有更合适的元素，那么使用 `<b>`、`<i>` 或 `<u>` 来表达传统上的粗体、斜体或下划线表达的意思是合适的。然而，始终拥有[可访问性](https://developer.mozilla.org/zh-CN/docs/learn/Accessibility)的思维模式是至关重要的。斜体的概念对人们使用屏幕阅读器是没有帮助的，对使用其他书写系统而不是拉丁文书写系统的人们也是没有帮助的。
  - `<b>`被用来传达传统上用斜体表达的意义：外国文字，分类名称，技术术语，一种思想……
  - `<i>`被用来传达传统上用粗体表达的意义：关键字，产品名称，引导句……
  - `<u>`被用来传达传统上用下划线表达的意义：专有名词，拼写错误……

*  使用下划线的忠告：因为我们常常会认为网页中的下划线代表着一个超链接**，**所以最好只用下划线来代表超链接。而在语义适合的情况下不得不使用<u>元素时，可以使用 CSS 来改变<u>元素对应的下划线的默认样式，从而和超链接的下划线区分开来。

#### 超链接

* 简介

```
<a  href="https://" title="包含关于链接的补充信息" >这是一个链接</a>
结果如下（当鼠标指针悬停在链接上时，标题将作为提示信息出现）

块级链接:
<a href="https://www.mozilla.org/zh-CN/">
  <img src="mozilla-image.png" alt="链接至 Mozilla 主页的 Mozilla 标志">
</a>
```

* 文档片段

  超链接除了可以链接到文档外，也可以链接到 HTML 文档的特定部分（被称为**文档片段**）。

```html
<h2 id="Mailing_address">邮寄地址</h2>
<p>本页面底部可以找到<a href="#Mailing_address">公司邮寄地址</a>。</p>
```

* 下载链接

  当你链接到要下载的资源而不是在浏览器中打开时，你可以使用 download 属性来提供一个默认的保存文件名。下面是一个 Firefox 的 Windows 最新版本下载链接的示例：

  ```
  <a href="https://download.mozilla.org/?product=firefox-latest-ssl&os=win64&lang=zh-CN"
     download="firefox-latest-64bit-installer.exe">
    下载最新的 Firefox 中文版 - Windows（64位）
  </a>
  ```

#### 高级文本格式

* 描述列表

* `<dl>`定义列表（对比ul）, 每一项都用`<dt>`元素闭合，每个描述都用`<dd>`闭合。

  ```
  <dl>
    <dt>内心独白</dt>
      <dd>戏剧中，某个角色对自己的内心活动或感受进行念白表演，这些台词只面向观众，而其他角色不会听到。</dd>
    <dt>语言独白</dt>
      <dd>戏剧中，某个角色把自己的想法直接进行念白表演，观众和其他角色都可以听到。</dd>
    <dt>旁白</dt>
      <dd>戏剧中，为渲染幽默或戏剧性效果而进行的场景之外的补充注释念白，只面向观众，内容一般都是角色的感受、想法、以及一些背景信息等。</dd>
  </dl>
  ```

* 引用

  https://developer.mozilla.org/zh-CN/docs/Learn/HTML/Introduction_to_HTML/Advanced_text_formatting#%E5%BC%95%E7%94%A8

* 缩略语`<attr title='缩略语的解释'>缩略语</attr>`

* 上标`<sup>`,下标`sub`。

#### 网站基本架构

![image-20220804160545889](C:\Users\28597\AppData\Roaming\Typora\typora-user-images\image-20220804160545889.png)

* 换行<br>
* 水平分割线<hr>

#### 多媒体嵌入

##### 图片

```
<img src="dinosaur.jpg">
如果这张图片存储在和 HTML 页面同路径的 images 文件夹下（这也是 Google 推荐的做法，利于SEO/索引），那么你可以采用如下形式：
<img src="images/dinosaur.jpg">

<img src="https://www.example.com/images/dinosaur.jpg">
这种方式是不被推荐的，这样做只会使浏览器做更多的工作，例如重新通过 DNS 再去寻找 IP 地址。通常我们都会把图片和 HTML 放在同一个服务器上。
```

属性是alt` ，它的值应该是对图片的文字描述，用于在图片无法显示或不能被看到的情况。例如，上面的例子可以做如下改进：

```
<img src="images/dinosaur.jpg"
     alt="The head and torso of a dinosaur skeleton;
          it has a large head with long sharp teeth">
```

##### 音频和视频

<vidio>允许嵌入一段视频

```
<video src="rabbit320.webm" controls>
  <p>你的浏览器不支持 HTML5 视频。可点击<a href="rabbit320.mp4">此链接</a>观看</p>
</video>
```

[`controls`](https://developer.mozilla.org/zh-CN/docs/Web/HTML/Element/video#attr-controls)：用户必须能够控制视频和音频的回放功能。你可以使用 `controls` 来包含浏览器提供的控件界面，同时你也可以使用合适的 [JavaScript API](https://developer.mozilla.org/en-US/docs/Web/API/HTMLMediaElement) 创建自己的界面。界面中至少要包含开始、停止以及调整音量的功能。

多格式的视频播放

```
<video controls>
  <source src="rabbit320.mp4" type="video/mp4">
  <source src="rabbit320.webm" type="video/webm">
  <p>你的浏览器不支持 HTML5 视频。可点击<a href="rabbit320.mp4">此链接</a>观看</p>
</video>
```

将 `src` 属性从 `<video>` 标签中移除，转而将它放在几个单独的标签 <source> 当中。在这个例子当中，浏览器将会检查 `<source>` 标签，并且播放第一个与其自身 codec 相匹配的媒体。

每个 `<source>` 标签页含有一个 `type` 属性，这个属性是可选的，但是建议你添加上这个属性 — 它包含了视频文件的 [MIME types](https://developer.mozilla.org/zh-CN/docs/Glossary/MIME_type) ，同时浏览器也会通过检查这个属性来迅速的跳过那些不支持的格式。如果你没有添加 `type` 属性，浏览器会尝试加载每一个文件，直到找到一个能正确播放的格式，这样会消耗掉大量的时间和资源。

其他属性：

* `muted`:这个属性会导致媒体播放时，默认关闭声音。
* `poster`:这个属性指向了一个图像的 URL，这个图像会在视频播放前显示。通常用于粗略的预览或者广告。

[**音频**](https://developer.mozilla.org/zh-CN/docs/Web/HTML/Element/audio)可见

##### iframe及其他嵌入

`<iframe>`元素旨在允许你将其他 Web 文档嵌入到当前文档中。



##### 矢量图

矢量图形在很多情况下非常有用 — 它们拥有较小的文件尺寸，却高度可缩放，所以它们不会在镜头拉近或者放大图像时像素化

位图和矢量图：

- 位图使用像素网格来定义 — 一个位图文件精确得包含了每个像素的位置和它的色彩信息。流行的位图格式包括 Bitmap (`.bmp`), PNG (`.png`), JPEG (`.jpg`), and GIF (`.gif`.)
- 矢量图使用算法来定义 — 一个矢量图文件包含了图形和路径的定义，电脑可以根据这些定义计算出当它们在屏幕上渲染时应该呈现的样子。 [SVG](https://developer.mozilla.org/zh-CN/docs/Glossary/SVG) 格式可以让我们创造用于 Web 的精彩的矢量图形

SVG 非常容易变得复杂，这意味着文件大小会增加; 复杂的 SVG 也会在浏览器中占用很长的处理时间。

SVG 可能比栅格图像更难创建，具体取决于您尝试创建哪种图像

* 要通过 `img`元素嵌入 SVG，你只需要按照预期的方式在 src 属性中引用它。

##### 响应式图片

一种可以在不同的屏幕尺寸和分辨率的设备上都能良好工作以及其他特性的图片，并且看看 HTML 提供了什么工具来帮助实现它们

[[响应式图片 - 学习 Web 开发 | MDN (mozilla.org)](https://developer.mozilla.org/zh-CN/docs/Learn/HTML/Multimedia_and_embedding/Responsive_images)]

#### 表格

##### 基础

1. 每一个表格的内容都包含在这个标签中：`<table>`
2. 在表格中，最小的内容容器是单元格，是通过 **`<td>`** 元素创建的（其中 'td' 代表 'table data'）。
3. 使用`<tr>` 元素,（其中 'tr' 代表 'table row'）
4. 使用`<th>`元素增加标题（其用法和td相似）
5. 设置单元格的行列长度：表格中的标题和单元格有 `colspan` 和 `rowspan` 属性，这两个属性可以帮助我们实现这些效果。这两个属性接受一个没有单位的数字值，数字决定了它们的宽度或高度是几个单元格。比如，`colspan="2"` 使一个单元格的宽度是两个单元格。
6. 为表格中的列提供共同样式：在真实的项目中，我们或许会设置一个 `class` 包含那三个单元格，然后在一个单独的样式表中定义样式）。为了舍弃这种做法，我们可以只定义一次，在 `<col>` 元素中。`<col>` 元素被规定包含在 `<colgroup>` 容器中，而 `<colgroup>`就在 `<table>` 标签的下方。		

```
<table>
  <colgroup>
    <col>
    <col style="background-color: yellow">
  </colgroup>
  <tr>
    <th>Data 1</th>
。。。。。。。
```

如果你想把这种样式信息应用到每一列，我们可以只使用一个 `<col>` 元素，不过需要包含 span 属性，像这样：

```
<colgroup>
  <col style="background-color: yellow" span="2">
</colgroup>
```

就像 `colspan` 和 `rowspan` 一样，`span` 需要一个无单位的数字值，用来制定你想要让这个样式应用到表格中多少列。

##### 高级

**添加一个标题**

​		将`<caption>`放在`<table>`下,

**结构化**

由于你的表格在结构上有点复杂，如果把它们定义得更加结构化，那会帮助我们更能了解结构。一个明确的方法是使用 <thead>,<tfoot>,<tbody> , 这些元素允许你把表格中的部分标记为表头、页脚、正文部分。

`<thead>` 需要嵌套在 table 元素中，放置在头部的位置，因为它通常代表第一行，第一行中往往都是每列的标题，但是不是每种情况都是这样的。如果你使用了 `<col>/<colgroup>` 元素，那么 `<thead>`元素就需要放在它们的下面

`<tfoot>` 需要嵌套在 table 元素中，放置在底部 (页脚) 的位置，一般是最后一行，往往是对前面所有行的总结，比如，你可以按照预想的方式将`<tfoot>`放在表格的底部，或者就放在 `<thead>` 的下面。(浏览器仍将它呈现在表格的底部)

`<tbody>` 需要嵌套在 table 元素中，放置在 `<thead>`的下面或者是 `<tfoot>` 的下面，这取决于你如何设计你的结构。(`<tfoot>`放在`<thead>`下面也可以生效.)