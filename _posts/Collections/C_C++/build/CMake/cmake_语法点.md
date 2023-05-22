指令列表 : https://cmake.org/cmake/help/latest/manual/cmake-commands.7.html
内置变量 : https://cmake.org/cmake/help/latest/manual/cmake-variables.7.html
帮助信息 : https://cmake.org/cmake/help/latest/manual/cmake.1.html


## 指令

随着项目越来越大 , 我们需要直接将某个文件夹下的代码全部添加到 `add_executable` 参数中
- `aux_source_directory(<dir> <variable>)` 
- 将 `dir` 目录中的源文件(cpp) 名保存到 变量 `variable` 中
- 局限性 : CMake 无法生成一个知道何时添加新源文件的构建系统 , 当某个文件中仅仅添加文件没有修改文件的时候 , CMake 感知不到新文件的添加



有时候我们希望打印观察 cmake 某些变量的值 
- `message([<mode>] "message text" ...)`
- model 可以理解为消息的程度 
  - FATAL_ERROR , 会导致 CMake 停止执行脚本
  - STATUS ,  一般都用它就好 , 其他关键字查看文档吧 


文件操作
```
file(GLOB <variable>            /*     遍历 cmakefile 所在文件夹下的 匹配正则规则的文件们 放到 variable 中 */

file(GLOB_RECURSE <variable>    /* 递归 , 与 GLOB 相比 增加了递归的能力  */
```
- 边界 : 我们不建议使用 GLOB 从源代码树中收集源文件列表。
        如果添加或删除源时没有 CMakeLists.txt 文件更改，则生成的构建系统无法知道何时要求 CMake 重新生成。



添加依赖库库
- `target_link_libraries`
```cmake
# 动态库 在 g++ 使用 -lLibName 指令
target_link_libraries(${CMAKE_PROJECT_NAME} 
    ${CMAKE_CURRENT_SOURCE_DIR}/libs/mysql_connector_arm_static/lib64/libmysqlcppconn8-static.a  # mysql 数据库 静态库
    glog fcgi fcgi cgicc ssl crypto pthread resolv
    boost_stacktrace_backtrace dl boost_date_time  # boost 相关 动态库
    pthread curl                                   # HowardHinnant_date 相关 动态库 
  )
```

控制 C/C++ 版本
```cmake
# Default to C11
if(NOT CMAKE_C_STANDARD)
  set(CMAKE_C_STANDARD 11)
endif()

# Default to C++20
if(NOT CMAKE_CXX_STANDARD)
  set(CMAKE_CXX_STANDARD 20)
endif()
```

判断编译环境
```cmake
if ("${CMAKE_CXX_COMPILER_ID}" STREQUAL "Clang")
  # using Clang
elseif ("${CMAKE_CXX_COMPILER_ID}" STREQUAL "GNU")
  # using GCC
elseif ("${CMAKE_CXX_COMPILER_ID}" STREQUAL "Intel")
  # using Intel C++
elseif ("${CMAKE_CXX_COMPILER_ID}" STREQUAL "MSVC")
  # using Visual Studio C++
endif()
```

判断操作系统
```cmake 
IF (CMAKE_SYSTEM_NAME MATCHES "Linux")

ELSEIF (CMAKE_SYSTEM_NAME MATCHES "Windows")

ELSEIF (CMAKE_SYSTEM_NAME MATCHES "FreeBSD")

ELSE ()
MESSAGE(STATUS "other platform: ${CMAKE_SYSTEM_NAME}")
ENDIF (CMAKE_SYSTEM_NAME MATCHES "Linux")
```

打印编译命令 
```cmake 
set (CMAKE_EXPORT_COMPILE_COMMANDS ON)
```


添加编译选项
```cmake
# g++ -Wall -ggdb -rdynamic -no-pie -fno-pie    file.cpp
if ("${CMAKE_CXX_COMPILER_ID}" STREQUAL "GNU")
  add_compile_options(-Wall -ggdb -rdynamic -no-pie -fno-pie) 
endif()
```


## 变量

- `CMAKE_CURRENT_SOURCE_DIR` : 当前 cmakefile 文件所在目录地址
- `CMAKE_CURRENT_LIST_FILE`  : 当前 cmakefile 文件绝对路径



## 连贯操作

cmake 执行完毕 后 , 如何自动执行 make 动作

/usr/bin/cmake  \                                                    
--no-warn-unused-cli                                                        \
-DCMAKE_EXPORT_COMPILE_COMMANDS:BOOL=TRUE                                   \
-DCMAKE_BUILD_TYPE:STRING=Debug                                             \
-DCMAKE_C_COMPILER:FILEPATH=/usr/bin/aarch64-linux-gnu-gcc                  \
-DCMAKE_CXX_COMPILER:FILEPATH=/usr/bin/aarch64-linux-gnu-g++                \
-S/mount_point/data/_document/c_cpp_program/nameless_carpool                \
-B/mount_point/data/_document/c_cpp_program/nameless_carpool/build          \
-G "Unix Makefiles"                                                         \

cmake --install ./build