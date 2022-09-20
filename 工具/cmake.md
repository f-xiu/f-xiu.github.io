**基础语法**

* 最低版本

  * `cmake_minimum_required(VERSION 3.1)` 指定最低版本
  * `cmake_minimum_required(VERSION 3.7...3.18)` CMake 3.12+ 后，可以指定版本范围

* Project

  * VERSION 指定版本，并设置一系列变量，例如MyProject_VERSION 等
  * DESCRIPTION 项目的描述
  * LANGUAGES 支持 C/CXX/Fortran/ASM/CUDA(3.8+)/CSharp(3.8+)/SWIFT(3.15+), C/C++ 为默认值

  ```
  project(MyProject VERSION 1.0
                    DESCRIPTION "Very nice project"
                    LANGUAGES CXX)
  
  ```

* 生成可执行文件

  ```cmake
  add_executable(one two.cpp three.h)
  ```

* 生成库

  * 库类型包括 STATIC、SHARED、MODULE、OBJECT 等。如果没有指定库类型，那么 BUILD_SHARED_LIBS 的值将决定编译 STATIC 或者 SHARED
  * 有些库并不需要编译，例如 header only 库。基于 target 的思想，我们可以将它们打包在一种叫 INTERFACE 的库中。

  ```
  add_library(one STATIC two.cpp three.h)
  ```

* 给 target 添加属性

  * target_include_directories 为 target 添加 include 路径
  * PUBLIC 对于可执行文件而言意义不大，对于库来说，它让 CMake 知道链接这个目标的目标也需要这个 include 目录。也就是 “我自己要用，其他链接我的也要用”，具有传递性
  * PRIVATE 表示 “我自己用，其他人不用”
  * INTERFACE 表示 “我自己不用，其他链接我的要用”
  * target 的属性包括 include 文件夹、需要链接的库、编译选项、宏定义等，这些都可以通过 target_link_libraries 进行传递

  ```
  # PUBLIC 表示外部也需要这个 include 目录
  target_include_directories(one PUBLIC include)
  add_library(another STATIC another.cpp another.h)
  # 由于具有传递性，another 可以连接 one 的 include 目录
  target_link_libraries(another PUBLIC one)
  ```





```
cmake_minimum_required (VERSION 2.8)

project (demo)

include_directories (test_func test_func1)

aux_source_directory (test_func SRC_LIST)
aux_source_directory (test_func1 SRC_LIST1)

add_executable (main main.c ${SRC_LIST} ${SRC_LIST1})
```

```
cmake_minimum_required (VERSION 2.8)
project (demo)
add_subdirectory (src)
```

```
aux_source_directory (. SRC_LIST)
include_directories (../include)
add_executable (main ${SRC_LIST})
set (EXECUTABLE_OUTPUT_PATH ${PROJECT_SOURCE_DIR}/bin)
```

```
/*
** testFunc1.c
*/
#include <stdio.h>
#include "testFunc1.h"
void func1(int data)
{
	printf("data is %d\n", data);
}
/*
** testFunc1.h
*/
#ifndef _TEST_FUNC1_H_
#define _TEST_FUNC1_H_
void func1(int data);
#endif

/*
** main.c
*/
#include <stdio.h>
#include "testFunc.h"
#include "testFunc1.h"

int main(void)
{
	func(100);
	func1(200);

	return 0;
}
```

```
cmake_minimum_required (VERSION 2.8)

project (demo)

set (EXECUTABLE_OUTPUT_PATH ${PROJECT_SOURCE_DIR}/bin)

aux_source_directory (src SRC_LIST)

include_directories (include)

add_executable (main ${SRC_LIST})
```

