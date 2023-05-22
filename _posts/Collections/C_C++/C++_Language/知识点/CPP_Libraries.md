
# 对 `C++ 引入外部依赖` 的认识

## 一. 相关名词

1. 动态库 dynamic libraries
2. 静态库 static  libraries
3. 依赖管理工具，类似 Maven Gradle, C++ 有没有这种行业内接受度较高的工具，C++ 是如何高效管理依赖的？
   - 没有找到的话我们就事实 make 能不能完成这个任务吧 。


## 二. 使用三方库如何管理

[json.nlohmann.me](https://json.nlohmann.me/integration/) 
提到了几种依赖管理方案，我们有倾向性， 目前优先关注学习 "-2-"
1. CMake
2. Make + pkg-config + 自定义文件夹
3. 其他不赘述

>

1. make 是编译命令的集合，我们已经了解并可以使用了
2. pkg-config 是什么，有什么作用
   - 官方说明逐步深入的几个连接 
     [-1-](https://packages.debian.org/zh-cn/sid/pkg-config) > 
     [-2-](https://packages.debian.org/source/sid/pkg-config) > 
     [-3-](https://www.freedesktop.org/wiki/Software/pkg-config/) > 
     [-4-](https://gitlab.freedesktop.org/pkg-config/pkg-config) >
     [-5-](https://linux.die.net/man/1/pkg-config)
   - pkg-config 是编译应用程序和库时使用的辅助工具。它可以帮助您在命令行中插入正确的编译器选项 。




## 阅读和参考
4. [**参考这个吧** : C++ 开发教程 4：静态和动态库](https://domiyanyue.medium.com/c-development-tutorial-4-static-and-dynamic-libraries-7b537656163e)
1. [Static vs Dynamic Libraries](https://www.bogotobogo.com/cplusplus/libraries.php)
2. [When to use dynamic linking and static linking](https://www.ibm.com/docs/zh/aix/7.2?topic=techniques-when-use-dynamic-linking-static-linking)
3. [Static and dynamic libraries](https://www.learncpp.com/cpp-tutorial/a1-static-and-dynamic-libraries/)