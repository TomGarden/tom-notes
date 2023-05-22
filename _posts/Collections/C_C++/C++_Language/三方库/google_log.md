[Google Log](https://github.com/google/glog)


## 0x01. 安装

我们希望编译成静态链接库 , 随着代码最终打包成项目可执行文件 , 从而避免将来的兼容问题 . 

先安装 gflags : `sudo apt-get install libgflags-dev`
1. https://gflags.github.io/gflags/
2. https://github.com/gflags/gflags/blob/master/INSTALL.md


使用 cmake 编译 glog : https://github.com/google/glog#building-glog-with-cmake

0. ls -al
    ```
    total 368
    drwxr-xr-x  9 tom  TOM     288  8月 15 08:53 .
    drwxr-xr-x 11 tom  TOM     352  8月 15 07:34 ..
    drwxrwxr-x 23 root root    736  8月 15 07:35 glog-0.6.0
    drwxr-xr-x 34 tom  TOM    1088  8月 15 08:51 glog_0.6.0_build
    drwxr-xr-x  2 tom  TOM      64  8月 15 08:50 glog_0.6.0_install
    -rw-r--r--  1 tom  TOM  257001  8月 15 07:34 glog-0.6.0.zip
    ```
1. `cmake -S ./glog-0.6.0  -B ./glog_0.6.0_build`
    - -T host=x64 用于请求本机 x64 工具链
    --install-prefix 指定安装路径前缀

2. `cmake --build ./glog_0.6.0_build`

3. `cmake --install ./glog_0.6.0_build`
    - 要查看都安装了那些文件 , 可以打开 `./glog_0.6.0_build/install_manifest.txt` 
    - 卸载动作也就是删除这些文件. 

安装完成后 , 如果运行异常并提示找不到库文件 : `while loading shared libraries: libglog.so.1: cannot open shared object file`
-  sudo ldconfig -v
- 手动更新系统动态库信息后再次执行

## 0x02. 初始化
```c++
  /* 如果这个函数 在 main 函数中调用, 这个 progressNmae = argv[0] */
  void initGlog(const char* progressName) {

    /* 将日志信息打印到 stderr , 而不是日志文件 ; 默认值 false */
    //FLAGS_logtostderr = false;

    /* INFO(0), WARNING(1), ERROR(2), FATAL(3) 
       日志信息除了输出到日志文件还拷贝到 stderr , 大于等于这里指定的日志级别就进行拷贝 . 
       默认值 2 */
    // FLAGS_stderrthreshold = ERROR;

    /* 大于等于此日志级别的日志将被输出 , 默认 INFO(0) */
    //FLAGS_minloglevel = INFO;

    /* 如果设置了这个值 , 日志文件就会写入这个文件夹下 , 默认在 `/tmp` 文件夹 ;
        此标志必须在 initGoogleLogging 之前设置才能生效 . 
        其他的标志随时可以设置 , 设置后生效 . */
    FLAGS_log_dir = "/mount_point/data/_document/c_cpp_program/nameless_carpool/run_log";

    /* 剩余两个标志 , 暂不介绍 */
    //FLAGS_v
    //FLAGS_vmodule

    google::InitGoogleLogging(progressName);
  }
```


## 0x03. 功能 : 条件输出

1. 条件输出 : `num_cookies > 10` 成立时 输出 `Got lots of cookies`
```c++
LOG_IF(INFO, num_cookies > 10) << "Got lots of cookies";
```

2. 条件输出 : 输出语在调用一定次数后才生效(每调用 10 次 输出一次) . 
          在执行的第 1、11、21、... 次输出日志消息。 
          `google::COUNTER` 值用于识别正在发生的重复。
```c++
LOG_EVERY_N(INFO, 10) << "Got the " << google::COUNTER << "th cookie";
```

3. 条件输出 : 结合 `1` , `2` .
            `size > 1024` 成立时 , 每 调用 10 次输出一次
```c++
LOG_IF_EVERY_N(INFO, (size > 1024), 10) << "Got the " << google::COUNTER << "th big cookie";
```

4. 条件输出 : 输出前 20 次执行的日志消息。同样， `google::COUNTER` 标识符指示正在发生的重复。
```c++
LOG_FIRST_N(INFO, 20) << "Got the " << google::COUNTER << "th cookie";
```

5. 条件输出(根据时间) : 
```c++
//每 10 ms 执行一次输出 
LOG_EVERY_T(INFO, 0.01) << "Got a cookie";

//每 2.35 s 执行一次输出
LOG_EVERY_T(INFO, 2.35) << "Got a cookie";
```



## 0x04. 功能 : Debug 模式

这些宏只在调试模式下完成呢个输出 , 非调试模式下的输出位空 . 有效避免由于输出过多造成的时耗问题 . 

至于如何判断是否调试模式 , 如何更改此模式 , 暂未可知 . 

```c++
DLOG(INFO) << "Found cookies";
DLOG_IF(INFO, num_cookies > 10) << "Got lots of cookies";
DLOG_EVERY_N(INFO, 10) << "Got the " << google::COUNTER << "th cookie";
```

## 0x05. 功能 : CHECK , 不满足直接终止程序 , 类似断言 

如果条件不成立，CHECK 会中止应用程序。

与 `assert` 不同之处在于它并非由 `NDEBUG` 控制 , 无论编译模式如何都会执行 . 

编译模式是什么, 暂未可知 .

```c++
CHECK(fp->Write(x) == 4) << "Write failed!";
```

有多种用于相等/不等式检查的辅助宏 : CHECK_EQ、CHECK_NE、CHECK_LE、CHECK_LT、CHECK_GE 和 CHECK_GT。
他们比较两个值，并在结果与预期不符时记录包含这两个值的 FATAL 消息。
```c++
//正常使用的例子
CHECK_NE(1, 2) << ": The world must be ending!";
CHECK_EQ(string("abc")[1], ’b’);
```


如果参数之一是指针而另一个是 NULL，编译器会报告错误。 
要解决此问题，只需用 `static_cast` 将 NULL 转换为所需指针的类型。
```c++
CHECK_EQ(some_ptr, static_cast<SomeType*>(NULL));
```


检测是否为空 
```c++
//这个宏 返回给定指针
CHECK_NOTNULL(some_ptr);
some_ptr->DoSomething();

// 这在构造函数初始化过程中比较常用
struct S {
    S(Something* ptr) : ptr_(CHECK_NOTNULL(ptr)) {}
    Something* ptr_;
};
```

比较 C 字符串(char*) : 
```c++
//区分大小写的对比
CHECK_STREQ(Foo().c_str(), Bar().c_str());
CHECK_STRNE(Foo().c_str(), Bar().c_str());
//CASE 版本不区分大小写
CHECK_STRCASEEQ(Foo().c_str(), Bar().c_str());
CHECK_STRCASENE(Foo().c_str(), Bar().c_str());
```


`CHECK_DOUBLE_EQ` 宏检查两个浮点值的相等性，接受一个小的误差范围。 

`CHECK_NEAR` 接受第三个浮点参数，它指定可接受的误差范围。


## 0x06. 详细日志 

当您在寻找困难的错误时，完整的日志消息非常有用。
但是，您可能希望忽略通常开发中过于冗长的消息。

对于这种详细的日志记录，glog 提供了 VLOG 宏，它允许您定义自己的数字日志记录级别。 
`--v` 命令行选项控制记录哪些详细消息

```c++
VLOG(1) << "I’m printed when you run the program with --v=1 or higher";
VLOG(2) << "I’m printed when you run the program with --v=2 or higher";
```

关于详细日志的更多信息暂不表述了 . 


## 0x07. 自定义日志前缀格式

glog 支持通过接收用户提供的用于生成此类字符串的回调来更改附加到日志消息的前缀格式。 

该功能必须在编译时通过 WITH_CUSTOM_PREFIX 标志启用。

对于每个日志条目，将使用包含严重性、文件名、行号、线程 ID 和事件时间的 LogMessageInfo 结构调用回调。 

它还将获得对输出流的引用，其内容将添加到最终日志行中的实际消息之前。

```c++
/* This function writes a prefix that matches glog's default format.
 * (The third parameter can be used to receive user-supplied data, and is
 * NULL by default.)
 */
void CustomPrefix(std::ostream &s, const LogMessageInfo &l, void*) {
   s << l.severity[0]
   << setw(4) << 1900 + l.time.year()
   << setw(2) << 1 + l.time.month()
   << setw(2) << l.time.day()
   << ' '
   << setw(2) << l.time.hour() << ':'
   << setw(2) << l.time.min()  << ':'
   << setw(2) << l.time.sec() << "."
   << setw(6) << l.time.usec()
   << ' '
   << setfill(' ') << setw(5)
   << l.thread_id << setfill('0')
   << ' '
   << l.filename << ':' << l.line_number << "]";
}
```

要启用 CustomPrefix()，只需在初始化期间给 glog 一个指向它的指针：
```C++
InitGoogleLogging(argv[0], &CustomPrefix);
```


## 0x08. 信号处理能力

该库提供了一个方便的信号处理程序，当程序在某些信号（如 SIGSEGV）上崩溃时，它将转储有用的信息。 

可以通过 `google::InstallFailureSignalHandler()` 安装信号处理程序。

要自定义转储信息格式需要使用 InstallFailureWriter()

详情 略 


## 0x09. 用户自定义程序终止函数 

FATAL 严重级别消息或未满足的 CHECK 条件终止您的程序。 
您可以通过 InstallFailureFunction 更改终止的行为。

```c++
void YourFailureFunction() {
  // Reports something...
  exit(EXIT_FAILURE);
}

int main(int argc, char* argv[]) {
  google::InstallFailureFunction(&YourFailureFunction);
}
```

默认情况下，glog 尝试转储堆栈跟踪并使程序以状态 1 退出。

堆栈跟踪仅在您在 glog 支持堆栈跟踪的体系结构上运行程序时生成（截至 2008 年 9 月，glog 支持 x86 和 x86_64 的堆栈跟踪 ）。


## 0x10. 原始记录

头文件 `<glog/raw_logging.h>` 可用于线程安全的日志记录，它不分配任何内存或获取任何锁。 

因此，这个头文件中定义的宏可以被底层内存分配和同步代码使用。 

详情请查看 `src/glog/raw_logging.h.in`  。


## 0x11. Google Style `perror()`

PLOG() 和 PLOG_IF() 和 PCHECK() 的行为与它们的 LOG* 和 CHECK 等效项完全相同，
除了它们将 errno 的当前状态的描述附加到它们的输出行。例如 : 

```c++
PCHECK(write(1, NULL, 2) >= 0) << "Write NULL failed";
```

输出内容为:
```
F0825 185142 test.cc:22] Check failed: write(1, NULL, 2) >= 0 Write NULL failed: Bad address [14]
```

## 0x12. Syslog

SYSLOG、SYSLOG_IF 和 SYSLOG_EVERY_N 宏可用。 
除了普通日志之外，这些日志还记录到 syslog。 
请注意，将日志记录到 syslog 会极大地影响性能，尤其是在将 syslog 配置为远程日志记录的情况下！ 
在使用这些宏之前，请确保您了解输出到 syslog 的含义。 
一般来说，谨慎使用这些宏是明智的。

## 0x13. 删除某些日志

日志消息中使用的字符串会增加二进制文件的大小并存在隐私问题。 
因此，您可以使用 `GOOGLE_STRIP_LOG` 宏指示 glog 删除低于某个严重级别的所有字符串：

如果您的应用程序有这样的代码：
```c++
#define GOOGLE_STRIP_LOG 1 // 这必须在 #include 之前！
#include <glog/logging.h>
```

编译器将删除严重性小于指定整数值的日志消息。 
由于 VLOG 日志的严重性级别为 INFO（数值 0），将 GOOGLE_STRIP_LOG 设置为 1 或更高会删除与 VLOG 关联的所有日志消息以及 INFO 日志语句。

## 0x14. 自动移除日志文件

要启用日志清理器：
```c++
google::EnableLogCleaner(3); // 将日志保存 3 天
```

然后 glog 将在执行刷新时检查是否有过期日志。 
在此示例中，您项目中上次修改时间大于 3 天的任何日志文件都将被 `unlink()ed` . 

可以随时禁用此功能（如果已启用）:  
```c++
google::DisableLogCleaner();
```


## 0x15. 尝试从日志调用进入源码查看下


## 0x16. 其他疑问 , 
1. 返回值被销毁了吗 ?
2. 入参后是拷贝吗 ?
3.  multiple definition of `***'; **.cpp:120: first defined here