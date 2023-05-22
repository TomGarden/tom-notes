

cmake 官方网站 : https://cmake.org/
cmake 官方文档总目录 : https://cmake.org/documentation/
  - 参考文档 : https://cmake.org/cmake/help/latest/
    - 命令手册 : https://cmake.org/cmake/help/latest/manual/cmake.1.html
  - 官方教程 : https://cmake.org/cmake/help/latest/guide/tutorial/index.html
    - 个人更建议心中有了疑惑带着问题探索这些内容 , 无目的感的填鸭太过教条 . 
    - 有目的的构建系统性认知才有更多收获 .
    - 教程使用过程中有不懂的语法指令
      - 一个指令列表 : https://cmake.org/cmake/help/latest/manual/cmake-commands.7.html
      - 文档页面有搜索框, 直接搜索
      - vscode 安装 cmake 插件后, 鼠标停留有语法提示 , 提示会有更多指引方便查阅官方文档. 
  - 对照着这两份文档, 实际操作下, 也就能明白个大概了 .


一些网友翻译的书籍
1. [CMake Cookbook](https://www.bookstack.cn/read/CMake-Cookbook/README.md)


无意发现的中文相关 
1. https://www.bookset.io/read/CMake-Cookbook/SUMMARY.md

一下是个人片面的感知

----- 

CMake 宣称 : CMake 是一个开源、跨平台的工具系列，旨在构建、测试和打包软件。
  - 开源 : https://gitlab.kitware.com/cmake/cmake
  - 跨平台 : (个人还没有试过不过)它说: 在不同平台运行 cmake 程序, cmake 程序可以根据平台情况
    生成对应的 makefile 并使用平台响应的工具 构建自己的源代码 . 
    这听起来能解决的问题是 : 当我们编写跨平台代码的时候不用花多份精力在不同的平台编译代码了 . 


就我们使用 makefile 的经验 , 我们需要
1. 源代码文件
2. 构建并管理输出的中间文件, 我是更喜欢把二进制中间文件按照 源代码的目录层次放在一个单独的文件中的.
3. 链接成最终的执行文件 . 
4. 编译过程中我们还会需要 `-g` 生成调试信息 , 供 gdb 使用 . 


CMake 的运行逻辑与上面的 makefile 使用逻辑类似 . 假设下面这个是我们的目录

```
codeTree
├── Step1                     # 源代码目录
│   ├── CMakeLists.txt        # 其中需要有有一个编写一个 CMake 需要的 CMakeLists.txt 文件
│   └── tutorial.cxx
├── Step1_build               # 后续会用到的编译中间文件目录
```

man cmake 写的还是很有条理(按照缩进层次折叠后可以看出逻辑关系)的可以帮助我们理解这个 cmake 的使用逻辑 .
```
CMAKE(1)                                                           CMake                                                          CMAKE(1)     

NAME                                                                [名称]
       cmake - CMake Command-Line Reference                             cmake - CMake 命令行参考

SYNOPSIS                                                            [概述] , 相当于一个目录 , 后面按照目录逐个给出详细使用方法
          Generate a Project Buildsystem                                [生成项目构建系统]
           cmake [<options>] <path-to-source>                           [构建系统需要源代码路径]
           cmake [<options>] <path-to-existing-build>                   [构建系统需要知道构建生成的中间文件放在什么路劲下]
           cmake [<options>] -S <path-to-source> -B <path-to-build>     [这两个路径可以一并给出 , 这一步完成就会生成二进制中间文件(.o 文件), 完成了源代码的编译动作 , 尚未链接]

          Build a Project                                           [构建项目] , 实际上是将上一步生成的 .o 文件们, 链接生成可执行文件
           cmake --build <dir> [<options>] [-- <build-tool-options>]     [要链接二进制文件,需要知道二进制文件的路径 . 链接之后的可执行文件也放在这个路径下了]

          Install a Project
           cmake --install <dir> [<options>]

          Open a Project
           cmake --open <dir>

          Run a Script
           cmake [{-D <var>=<value>}...] -P <cmake-script-file>

          Run a Command-Line Tool
           cmake -E <command> [<options>]

          Run the Find-Package Tool
           cmake --find-package [<options>]

          View Help
           cmake --help[-<topic>]
```


但是 CMakeLists.txt 应该怎么写呢 ? makefile 也是之后一个 make 命令就完事儿了, 麻烦的都在 makefile 的写法呀 . 