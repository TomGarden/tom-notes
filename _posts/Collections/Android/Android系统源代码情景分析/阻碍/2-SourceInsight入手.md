## 〇、 关于 project
打开和创建项目从 菜单条 中的 project 开始

## 一、 Symbol not found
原因有三
1. 符号未同步
    - `Project -> Synchronize Files ...`
2. 包含目标符号的文件不在工程中。
    - 到别处查找：例如 JDK 中的类可以再 AndroidStudio 中查看
        -  可不可以再 SourceInsight 中查看呢？
            - 在 AndroidStudio 中无法满足需求的时候再考虑这个问题。
    - 在工程目录中加入更多文件
        1. `Projcec -> Add and Remove Projcet Files`
        2. `Project -> Synchronize Files ...`


## 二、 AOSP 中涉及到 JDK 代码我们应该查看那个版本的 JDK 代码
这当然是一个问题，但是在阅读源代码的时候这有算不上阻碍，因为我们及时不能判断 JDK 版本，也能在 AOSP 中找到该代码，不必到 JDK 中查找。

## 三、 看到 `native` 方法,如何探寻到对应的 C/C++ 方法

> [JNI 的使用方式有二：](https://blog.csdn.net/wwj_748/article/details/52347341)

关于目录结构我们暂且存疑，记录一下实践：
1. 包含 `native` 方法的类文件
    - `I:\AOSP\android-4.4.4_r1\libcore\luni\src\main\java\libcore\io\Posix.java`
2. 上述类文件中的 `native` 方法的实现文件：
    - `I:\AOSP\android-4.4.4_r1\libcore\luni\src\main\native\libcore_io_Posix.cpp`

实践2
1. 包含 native 方法的类文件
    - I:\AOSP\android-4.4.4_r1\libcore\dalvik\src\main\java\dalvik\system\DexFile.java
        ```java
        native private static int openDexFileNative(String sourceName, String outputName, int flags) throws IOException;
        ```
2. 找到对应的 CPP 文件的方法
    - 将方法名到 http://androidxref.com 与自己对应的版本下检索
3. 本次碰到的问题是 目标文件已经添加到了 SourceInsight 数据库中，也已经同步了索引，但是就是就检索不到，实在不知道如何处理，暂且如此吧。


## 四、 在native层中有些方法或字段要查看需要依赖 Linux 环境
通过在 Ubuntu 虚拟机中安装 Eclipse for c/c++ 创建试验 project 书写关心的代码 ，`Ctrl+left mouse` 查看细节 

## 五、 native 包中一些头文件不确定到哪里去找
例如 `#include "ScopedUtfChars.h"` 
- 上述代码出现的位置：`I:\AOSP\android-4.4.4_r1\libcore\luni\src\main\native\libcore_io_Posix.cpp`
- 无意间找到：`I:\AOSP\android-4.4.4_r1\libnativehelper\include\nativehelper\ScopedUtfChars.h`
    - 因为一看这驼峰命名基本就确定不是 C/C++ 库方法
    - 搜索了一下也没找到头绪
    - 确实是无意间在上级目录找到的。

## 六、 头文件(.h)和源文件(.c/.cpp)不在同一目录，甚至同名(不含后缀)源文件没有引用头文件
这种情况下如何确定头文件和源文件的对应关系呢？

我是根据源文件头文件同名认为该两个文件具有对应关系，尝试逐个打开 .cpp 文件中 include 的 .h 文件恰好在某个 .h 文件中找到了 .cpp 文件的 .h 文件，但是这个办法很明显的缺点就是当包含关系更深入更复杂的时候，很容易让人丧失信心。

## 七、 关于 jni 方法 doc
在第一次了解源码逻辑的时候我们的目标是整体结构，因此但凡能节省我们精力并且不阻碍我们理解的地方就按节省精力的方法处理。所以我们没必要把 jni 的具体实现都弄个一清二楚 https://docs.oracle.com/javase/7/docs/technotes/guides/jni/spec/functions.html ☜ 有什么需要到这里可以得到不错的解释





