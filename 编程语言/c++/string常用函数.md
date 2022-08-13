- ### string常用成员函数（增删改）

  assign函数：
  str.assign(“ABC”)——清空字符串，并设置为 “ABC”
  str.assign(“ABC”,2)——清空字符串，并设置为"AB"，保留两个字符
  str.assign(“ABC”,1,1)——清空字符串，设置为 “ABC” 中的从 位置1 开始，保留 1个 字符（结果是”B“）
  str.assign(5，‘A’)——清空字符串，然后字符串设置为 5个 ‘A’
  str.length()——求字符串长度
  str.size()——和 length() 一样
  str.capacity()——获取容量，包含了不用增加内存就能使用的字符数
  str.reasize(10)——设置当前 str 的大小为10，若大小大与当前串的长度，\0 来填充
  str.reasize(10,char c)——设置当前 str 的大小为10，若大小大与当前串的长度，字0符c 来填充
  str.reserve(10)——设置str的容量 10，不会填充数据
  str.swap(str1)——交换 str1 和 str 的字符串
  str.push_back(‘A’)——在str末尾添加一个字符 ‘A’ ，参数必须是字符形式
  str.append(“ABC”)——在str末尾添加一个字符串 “ABC”，参数必须是字符串形式
  insert函数方法：

  str.insert(2,3,‘A’)——在str下标为2的位置添加 3个 字符’A’
  str.insert(2,“ABC”)——在str下标为2的位置添加 字符串 “ABC”
  str.insert(2,“ABC”,1)——在str下标为2的位置添加 字符串 “ABC” 中 1个 字符
  str.insert(2,“ABC”,1,1)——在str下标为2的位置添加 字符串 “ABC” 中从位置 1 开始的 1 个字符
  注：上个函数参数中加粗的 1 ，可以是 string::npos，这时候最大值，从 位置1 开始后面的全部字符

  str.insert( iterator pos, size_type count, CharT ch )——在 str 中，迭代器指向的 pos位置 插入 count个 字符 ch
  s4.insert(++str1.begin(),2,‘a’); 结果：s4：ABCD -> AaaBCD

  str.insert( iterator pos, InputIt first, InputIt last )——在 str 中，pos位置 插入 str1 的 开始位置 到 结束为止
  s4.insert(s4.begin(),str1.begin(),str1.end()); 结果：s4：ABCD str1：abc -> abcABCD

  str.erase(2)——删除 下标2 的位置开始，之后的全删除
  str.erase(2,1)——删除 下标2 的位置开始，之后的 1个 删除
  str.clear()——删除 str 所有
  str.replace(2,4,“abcd”)——从 下标2 的位置，替换 4个字节 ，为"abcd"

  //与java中replace略有不同

  str.empty()——判空（空返回1，非空返回0）

  ![](D:\笔记\assets\编程语言\字符串功能演示.png)

- #### 其他

  1. find()找到的子串的首字符位置，或若找不到这种子串则为 [npos](https://zh.cppreference.com/w/cpp/string/basic_string/npos) 。可以指定开始位置。

  
  查找**成功返回位置** ，查找**失败**，**返回-1**

```
void print(std::string::size_type n, std::string const &s)
{
    if (n == std::string::npos) {//npos
        std::cout << "not found\n";
    } 
    else {
        std::cout << "found: " << s.substr(n) << '\n';
    }
}
```

2. 拷贝相关的：

substr(pos,count);//返回含子串 `[pos, pos+count)` 或 `[pos, size())` 的 string 。

str1=str.substr(2)——提取子串，提取出 str 的 下标为2 到末尾，给 str1
str1=str.substr(2,3)——提取子串，提取出 str 的 下标为2 开始，提取三个字节，给 str1
const char* s1=str.data()——将string类转为字符串数组，返回给s1
char* s=new char[10]

copy(dest,count,pos);返回复制的字符数.

| dest  | 指向目标字符串的指针 |
| ----- | -------------------- |
| count | 子串长度             |
| pos   | 包含的首字符位置     |

str.copy(s,count,pos)——将 str 里的 pos 位置开始，拷贝 count个 字符,存到 s 里


3.string类型可以直接使用比较运算符进行比较

规则是：从第一个字符开始比较，较小者为小的，相等则比较下一个，直到一个结束，为小的。