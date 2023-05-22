## 一、 C++ 执行 shell 命令
popen 执行 java -version 命令无法获取输出，而输出会直接打印到命令行。

开始以为是 popen 运用有问题，但是其他的命令都是可以获取到输出的。

通过直接使用命令行尝试讲 java -version 的输出重定向到文件 `java -version > 文件路径` 失败，这里的结果和程序中的运行结果相同，该命令输出为 “” 会清空文件内容。

_**这是一个错误 ： **猜测 `java -version` 的输出结果并非标准输出，那就只剩下标准错误了，尝试讲标准错误重定向到标准输出 `java -version 2>&1 > 文件路径` 无效_
  - 通过 `java -version 2> 文件路径` 成功获取到命令的输出，由此推断上述用法是错误的
  - 并且 `java -version` 的输出内容是标准错误

猜想 `java -version` 的输出结果非标准输出亦非标准错误，就是一个简单的打印。

**我们之所以要执行用 popen 执行该命令就是为了使用程序获取 jdk 版本，那么面对这种情况我们如何达成目的呢：**
思路有二：
1. 查看 java 是如何查看 jdk 版本的，根据其源代码通过 C++ 实现
2. 使用 C++ 调用 java 代码实现本目的

## 二、 关于标准输出和标准错误的重定向
几个基本符号及其含义
- /dev/null 表示空设备文件
- 0 表示stdin标准输入
- 1 表示stdout标准输出
- 2 表示stderr标准错误

几个用法：
- command > filename 把把标准输出重定向到一个新文件中
- command >> filename 把把标准输出重定向到一个文件中(追加)
- command 1 > fielname 把把标准输出重定向到一个文件中
- command > filename 2>&1 把把标准输出和标准错误一起重定向到一个文件中
- command 2 > filename 把把标准错误重定向到一个文件中
- command 2 >> filename 把把标准输出重定向到一个文件中(追加)
- command >> filename 2>&1 把把标准输出和标准错误一起重定向到一个文件中(追加)
- command < filename > filename2把command命令以filename文件作为标准输入，以filename2文件作为标准输出
- command < filename 把command命令以filename文件作为标准输入
- command << delimiter 把从标准输入中读入，直至遇到delimiter分界符
- command <&m 把把文件描述符m作为标准输入
- command >&m 把把标准输出重定向到文件描述符m中
- command <&- 把关闭标准输入



## Reference
1. [linux重定向命令的使用方法](https://jingyan.baidu.com/article/f54ae2fc1176f11e92b84912.html)
2. [Linux里的2>&1究竟是什么](http://blog.csdn.net/ggxiaobai/article/details/53507530)
3. [如何重定向标准输出和标准错误到一个文件中](https://zhidao.baidu.com/question/2204623308494962668.html)
