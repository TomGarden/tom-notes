## 一、编译异常
### 1.1、关键字
1. collect2: error: ld returned 1 exit status
2. .c:(.text+0x273): undefined reference to `
3. g++ -o

### 1.2、错误修正
- g++ main_2.c -std=c++14 -o testMain_2  -lfollylogging

### 1.3、错误日志
```terminal
$ g++ main_2.c -std=c++14 -o testMain_2
/tmp/ccFfE4mj.o: In function `main':
main_2.c:(.text+0x273): undefined reference to `folly::LogStreamProcessor::~LogStreamProcessor()'
main_2.c:(.text+0x2b6): undefined reference to `folly::LogStreamProcessor::~LogStreamProcessor()'
/tmp/ccFfE4mj.o: In function `folly::LogStreamProcessor::LogStreamProcessor(folly::XlogFileScopeInfo*, folly::LogLevel, folly::Range<char const*>, bool, folly::Range<char const*>, unsigned int, folly::LogStreamProcessor::AppendType)':
main_2.c:(.text._ZN5folly18LogStreamProcessorC2EPNS_17XlogFileScopeInfoENS_8LogLevelENS_5RangeIPKcEEbS7_jNS0_10AppendTypeE[_ZN5folly18LogStreamProcessorC5EPNS_17XlogFileScopeInfoENS_8LogLevelENS_5RangeIPKcEEbS7_jNS0_10AppendTypeE]+0x51): undefined reference to `folly::LogStreamProcessor::LogStreamProcessor(folly::XlogFileScopeInfo*, folly::LogLevel, folly::Range<char const*>, unsigned int, folly::LogStreamProcessor::AppendType)'
/tmp/ccFfE4mj.o: In function `folly::XlogLevelInfo<false>::check(folly::LogLevel, folly::Range<char const*>, bool, folly::XlogFileScopeInfo*)':
main_2.c:(.text._ZN5folly13XlogLevelInfoILb0EE5checkENS_8LogLevelENS_5RangeIPKcEEbPNS_17XlogFileScopeInfoE[_ZN5folly13XlogLevelInfoILb0EE5checkENS_8LogLevelENS_5RangeIPKcEEbPNS_17XlogFileScopeInfoE]+0x67): undefined reference to `folly::XlogLevelInfo<false>::loadLevelFull(folly::Range<char const*>, bool, folly::XlogFileScopeInfo*)'
collect2: error: ld returned 1 exit status
tom@tom-Vostro-2421:/media/tom/document/Syn_Clode/project/SillyMonkey/src$
```

## 二、编译异常
关于 `ld` 异常的常规解决办法如果不掌握，以后我们会被这总问题无休止的折磨。
### 1.1、错误分析
`collect2: error: ld returned 1 exit status`

可以分辨这是在链接(ld)过程中出错的。
- 链接正常情况下会如何运作？
- 这里是什么原因导致了无法正常运作？
- 好，上述问题暂时不管。

提示信息的意思是：`undefined reference to `example::ExampleObject::~ExampleObject()'`
- example 命名空间中的
- ExampleObject 类中的
- 析构函数 ~ExampleObject()
- 没有实现
- 所以我们现在应该做的事情
  1. 实现它(已经确定该方法是被实现了的，实现方式是 .h 声明 同名 .cpp 文件中做出了实现)
  2. 查看为什么会出现这样的问题

至此问题已经解决了，我们的盲点在 `分离式编译`
- 我们的项目结构
  - 一个 `lib.h` 其中定义了方法。
  - 一个 `lib.c` 其中定义了 `lib.h` 文件中方法的实现
  - 一个 `main.c` 其中定义了`main` 方法
  - 我们的编译语句：
    - `g++ main.c -std=c++14 -o testMain  -lfollylogging -lfolly -ldouble-conversion -lglog -lgflags`
    - 报错说 `lib.h` 中的方法未实现，经查勘，我们的方法已经实现了，但是编译器为什么不知道呢？
    - 后来确定我们实现后没有告诉编译器我们已经实现了，所以我们应该怎么告诉他呢？
  - 我们通过新的编译命令解决了上述问题
    - `g++ main.c lib.cpp -std=c++14 -o testMain  -lfollylogging -lfolly -ldouble-conversion -lglog -lgflags`

### 1.2、错误日志
```terminal
$ g++ main.c -std=c++14 -o testMain  -lfollylogging -lfolly -ldouble-conversion -lglog -lgflags
/tmp/ccFQwIkB.o: In function `main':
main.c:(.text+0xf86): undefined reference to `example::ExampleObject::~ExampleObject()'
/tmp/ccFQwIkB.o: In function `__static_initialization_and_destruction_0(int, int)':
main.c:(.text+0x12d3): undefined reference to `example::ExampleObject::~ExampleObject()'
collect2: error: ld returned 1 exit status
```

## 三、编译异常
### 3.1、错误日志
```
lib.cpp:16:17: fatal error: lib.h: No such file or directory
```

### 3.2、错误修正
将 lib.cpp 中的代码
- `#include <lib.h>`
  - `<>` 在系统标准头文件路径查找所声明的头文件。
修改为
- `#include "lib.h"`
  - `""` 为文件路径，若直接是文件名则在项目根目录下查找,如果找不到就到系统头文件目录查找。


## 四、关于 Folly 的一些讨论
https://github.com/facebook/folly/issues/725
