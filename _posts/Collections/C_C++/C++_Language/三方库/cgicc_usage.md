
CGICC 的相关文档 ：
1. https://www.gnu.org/software/cgicc/
2. https://www.gnu.org/software/cgicc/manual/
3. https://www.gnu.org/software/cgicc/doc/index.html


cgicc 提供了一些(HTML)文档编辑的能力 , `fastcgi` 的能力是用的 [`fastcgi`](https://packages.debian.org/zh-cn/stretch/libfcgi-dev)
- 安装 fastcgi : `apt-get install libfcgi-dev`
- 安装 cgicc : `apt-get install libcgicc-dev`


## 0x01. 关于 : libfcgi-dev

相关文件 : https://debian.pkgs.org/11/debian-main-amd64/libfcgi-dev_2.4.2-2_amd64.deb.html
原码路径逐级递增深度 :
    1. 源码 : https://github.com/tehnick/libfcgi-debian
    2. 源码 : https://github.com/FastCGI-Archives/fcgi2
    3. 文档 : http://fastcgi-archives.github.io/fcgi2/doc/overview.html
    4. 文档 : https://fastcgi-archives.github.io/


通过文件目录可以判断 libfcgi-dev 提供两个静态库 : `fcgi++` 和 `fcgi`


### 1.1. 关于 fcgi 都有哪些类那些函数 , 应该如何调用他们的说明 

[文档](https://fastcgi-archives.github.io/FastCGI_Developers_Kit_FastCGI.html) 中提到有三个函数 
1. FCGI_Finish
2. FCGI_SetExitStatus
3. FCGI_StartFilterData

关于类和函数们的使用可以从三个方面了解
1. 源码仓库中的示例程序 https://github.com/FastCGI-Archives/fcgi2/tree/master/examples
    - echo.c
2. 源代码中的注释
3. 头文件中的注释


### 1.2. 关于 fcgi++ 库如何使用 
[文档](https://fastcgi-archives.github.io/FastCGI_Developers_Kit_FastCGI.html) 

fcgiapp库是 FastCGI 的第二个 C 库。
它不提供fcgi_stdio提供的高度源代码兼容性；作为回报，它不会大量使用#define。fcgi_stdio被实现为 fcgiapp 之上的一个薄层。

使用fcgiapp库构建的应用程序不能作为 CGI 程序运行；该功能在fcgi_stdio级别提供。

fcgiapp中定义的函数使用前缀FCGX_而不是FCGI_ 命名。例如，FCGX_Accept是FCGI_Accept的fcgiapp版本。

fcgiapp库的文档采用头文件include/fcgiapp.h中大量注释的形式。
示例程序examples/tiny-fcgi2.c和examples/echo2.c说明了如何使用fcgiapp。


关于类和函数们的使用可以从三个方面了解
1. 源码仓库中的示例程序 https://github.com/FastCGI-Archives/fcgi2/tree/master/examples
    - echo-cpp.cpp 
2. 源代码中的注释
3. 头文件中的注释





## 0x02. 关于 : cgicc

1. gun software 介绍 : https://www.gnu.org/software/cgicc/
2. cigcc 在线文档 : https://www.gnu.org/software/cgicc/doc/index.html

从文档的描述可以感受到 , cgicc 实际发生的作用 , 是解析 fcgi 接收到的信息 . 

也可以通过 cgicc 向 fcgi 发送信息 . 

cgicc 对这个收发过程做了抽象 . 


### 2.1. 关于库 API 如何使用

[文档](https://www.gnu.org/software/cgicc/doc/index.html) 有关于类和函数的简介和示例 

下载源代码后可以在 项目目录种查看示例程序和其他更多代码
1. cgicc_version_name/example
2. cgicc_version_name/demo
3. cgicc_version_name/contrib   -> 包含了和 fcgi 结合使用的示例程序 