>1. 译：[How To Use gflags (formerly Google Commandline Flags)](https://gflags.github.io/gflags/)
>2. 2018-01-16
>3. 一些专有名词，直译过来不知道对不对，干脆不翻了 ^_^。
# 如何使用 gflags ( Google 以前的 Commandline Flags)

(as of Fri Jan 06 2017)
  - __Table of contents__
    - [Introduction ](#)
    - [Download and Installation](#)
    - [Declare dependency on gflags with CMake](#)
    - [Declare dependency on gflags with Bazel](#)
    - [DEFINE: Defining Flags In Program](#)
    - [Accessing the Flag](#)
    - [DECLARE: Using the Flag in a Different File](#)
    - [RegisterFlagValidator: Sanity-checking Flag Values](#)
    - [Putting It Together: How to Set Up Flags](#)
    - [Setting Flags on the Command Line](#)
    - [Changing the Default Flag Value](#)
    - [Special Flags](#)
    - [The API](#)
    - [Miscellaneous Notes](#)
    - [Issues and Feature Requests](#)

## 简介，和其他 Commandline Flags Libraries 作对比
用户在使用命令行运行一个应用程序的时候，所指定的一个个标签就称作 __Commandline flag__。在如下的命令中：
```
fgrep -l -f /var/tmp/foo johannes brahms
```
`-l` 和 `-f /var/tmp/foo` 是两个 commandline flag。(`johannes` 和 `brahms` 没有以 `-` 开头，是 __Commandline arguments__)。

通常，一个应用程序会设置它所能接收的 flag 以及该 falg 所对应的 argument —— 在这个例子中， `-l` 这个 flag 没有 argument ，`-f` 这个 flag 以一个字符串(此处是一个文件名)作为 argument 。用户可以使用 library 帮忙解析 commandline 并且将 flag 存储到特定的数据结构中。

Gflags,Google 使用的 Commandline flag library，不同于其他的 library (例如`getopt()`)。Gflags library 中 flag 可以在源码中分散定义。其他的 library 中 flag 只能定义在类似 `main()` 方法这样的入口代码处。这意味着可以在单一源码文件中定义仅对该文件有意义的 flag 。任何连接到该文件的程序都可以获取到文件中的 flag，并且 gflag 会对该 flag 做适当的处理。

gflag 上述能力的优势在于可以提高程序编码的灵活性和源码的复用性。相对的，这种能力面对的风险就是如果在不同的文件中定义了相同的 falg 并且连接到同一个程序中会发生错误。

本文档其余的部分将会介绍如何使用 gflag commandline flag library。这是一个 C++
 library ，所以示例都是用的 C++ 。但是这些内容对应 python 有同样的方法和接口，使用 python 可以直接使用它们。

 ## 下载和安装
gflags library 可以从 [GitHub](https://github.com/gflags/gflags) 下载。也可以使用下面的 git 命令 clone：
```
git clone https://github.com/gflags/gflags.git
```
Build 和 installation 的说明在 [INSTALL](https://github.com/gflags/gflags/blob/master/INSTALL.md) 文件中。
安装 gflag 的配置文件支持当前流行的集中构建工具： [pkg-config](https://www.freedesktop.org/wiki/Software/pkg-config/), [CMake](https://gflags.github.io/gflags/#cmake), and [Bazel](https://gflags.github.io/gflags/#bazel)。

## Declare dependency on gflags with CMake 用 CMake 声明对 gflag 的依赖
在 build 系统为 CMake 的项目中使用 gflag 是容易的。你可以


## Declare dependency on gflags with Bazel
略

## DEFINE: 在程序中定义 flag
定义一个 flag 很简单： 使用你预期的 flag 数据类型所对应的宏(macro),就像定义在 `gflags/gflags.h`底部的那样。这里有一个例子，`foo.cc`:
```C++
#include <gflags/gflags.h>

DEFINE_bool(big_menu, true, "Include 'advanced' options in the menu listing");
DEFINE_string(languages, "english,french,german",
              "comma-separated list of languages to offer in the 'lang' menu");
```
`DEFINE_bool` 定义了一个 argument 为 boolean 类型的 falg。一下是所有支持的类型
- `DEFINE_bool`: boolean
- `DEFINE_int32`: 32-bit integer
- `DEFINE_int64`: 64-bit integer
- `DEFINE_uint64`: unsigned 64-bit integer
- `DEFINE_double`: double
- `DEFINE_string`: C++ string

注意，所支持的类型中没有复杂类型，例如我们例子中的 "languages" flag ，我们为其定义的类型是 "string" ，不是 "list_of_string" 或者其他类似发复杂类型。这是有意为之的。我们更愿意 flag 使用简单类型，而在解析的过程中使用复杂类型，而不愿意在标志库中使用复杂内容。

所有的 `DEFINE` 宏(macro) 都有三个属性(argument) : falg 的名字； flag 的默认值； 以及一个 'help' 描述信息。 'help' 字符串的使用： `--help flag` ,这会展示我们设置的 ‘help’ 描述信息。

你能在你程序中的任何一个源码文件中定义 flag 。强力建议仅定义一次！你想在多个文件中使用该 flag ，可以在一个文件中定义在别的文件中声明。更好的做法是，在一个文件中定义 `foo.cc`,在另一个文件中声明 `foo.h` ; 在别的文件中要使用的时候 `#include foo.h`。

在 library 中定义一个 flag 比在 main() 方法中定义强大，但是这也需要付出代价。一种情况是，该 flag 在 library 中设置的默认值(default value)不总是适用，例如如果默认值是一个文件路径，而且并非在所有的环境下该路径都存在。要避免这种问题，可以使用 Flag Validator 确保在 flag 的默认值无效时得到及时的通知(已崩溃的形式)。

请注意，尽管这个库中的大部分函数都是在google命名空间中定义的，但是DEFINE_foo（和DECLARE_foo，下面）应该始终位于全局命名空间中。

## 访问 flag
所有定义的 flag 对于程序而言都是不同的可访问的变量，可以通过附加前缀(`FLAGS_`)的方式访问该变量 。在上面的例子中，宏(macro) 定义了两个变量 ，`FLAGS_big_menu`(a bool),和 `FLAGS_languages`(a C++ string)。

你可以像读写其他变量一样读写 flag
```C++
if (FLAGS_consider_made_up_languages)
  FLAGS_languages += ",klingon";   // implied by --consider_made_up_languages
if (FLAGS_languages.find("finnish") != string::npos)
  HandleFinnish();
```
你也可以使用 `gflags.h` 中的特定方法 get set flag 的值。虽然这是一个不常见的操作。

## DECLARE : 在不同的文件中使用 flag

# 后文全略











-
