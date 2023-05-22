代码：gflag release 2.1.2

疑问位置：src/gflags_declare.h.in ： 43

描述：宏定义语句中包含了两个 `@@` 不解


这里的文件用的不是`c/c++`的语法，而是编译工具链（cmake,或者是automake）的语法。看起来这是cmake的语法，这个 `@` 中间的变量是cmake里面的定义，在cmake生成makefile的阶段，扩展成对应的字符串（类似于cpp里面的宏定义）。也就是gflags的namespace可以在cmake阶段自定义。

`.h.in` 中的 `@@` 这种语法最终被 `cmake` 进行解释和处理，这里涉及到的知识就是：
- 最终 `comfigure_file` 会处理 `@@` 区间内的字段。
- 处理语法详见 Refrence。

## Refrence
1. [宏定义语句中包含了两个 `@@` 不解](https://www.zhihu.com/question/54265324?from=profile_question_card)
2. [configure_file - CMake 3.0.2 Documentation]https://cmake.org/cmake/help/v3.0/command/configure_file.html

----
个人的疑问：

我们在使用 gflags 的时候，命名没看到定义这个 namespace ，那么它是为什么可以使用这个 gflags 命名空间名字的？

我们可以正常的使用方法 `gflags::ParseCommandLineFlags()` 我们根据这个方法在源代码中的定义找到了命名空间 `namespace GFLAGS_NAMESPACE{...}`

剩下的就凭猜想吧，CMake 这个构建工具在替换了这个字段进行编译，从而我们可以使用 `namespace gflags`
