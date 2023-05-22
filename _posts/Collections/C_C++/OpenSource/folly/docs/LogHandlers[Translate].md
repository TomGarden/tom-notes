# Log Handlers

The `LogHandler` class defines the interface for classes that wish to be
notified of log messages.

`LogHandler` objects can be attached to specific log categories to be notified
about log messages sent to that category or any of its children categories.
Attaching a `LogHandler` to the root category will cause it to be notified
about every enabled log message.

`LogHandler` 为希望发出通知消息的类定义了接口。

`LogHandler` 对象可以附加到指定的 log 类别中，用于通知发送到该类(或者该类子类们)的消息。
将 `LogHandler` 附加到根类中，将导致任何启用 log 的类都被通知。

# Built-in Log Handlers
The logging library currently provides a few basic built-in `LogHandler`
implementations.

logging library 当前提供了几个基本 `LogHandler` 的实现。

## `stream` Handler Type
In the [configuration settings](Config.md), you can use the `stream` type to
define a log handler that will write to `stdout` or `stderr`.  The `stream`
property of the log handler specifies which stream to write to.  For example,
the following defines a handler named `myhandler` that writes to stderr

```
myhandler=stream:stream=stderr
```

在 [Configuration settings](Config.md) 中，你可以定义一个 `stream` 类型的 log handler 会将信息写入 `stdout` 或 `stderr` 。
log handler 中的 `stream` 属性指定 stream 写入到什么地方。
例如,下面定义的 `myhandler` 会把内容写入 stderr 。

## `file` Handler Type

A `file` handler type is also provided that appends log messages to a file on
disk.  The `path` option controls which file to write to.  For example:

```
myhandler=file:path=/var/log/my.log
```

However, note that the `file` handler is currently not registered by default by
`folly::initLogging()`.  This log handler allows appending to arbitrary files
based on the configuration settings.  You should only enable this handler type
if you trust the source of your configuration string.  (For instance, this
handler is potentially unsafe if your program runs with elevated privileges but
users with lower privilege levels can write to your configuration file.)

The following code snippet can be used to explicitly enable this log handler
type.  It can be called before `initLogging()` to support the `file` handler
type in the configuration string passed to `initLogging()`.

```
folly::LoggerDB::get()->registerHandlerFactory(
      std::make_unique<folly::FileHandlerFactory>());
```

还提供了 `file` handler 类型，用于将消息写入磁盘文件。`path` 选项控制写入文件的路径。例如：
```
myhandler=file:path=/var/log/my.log
```

然而，值的注意的是 `file` handler 当前没有默认注册到 `folly::initLogging()` 中。基于 configuration settings 这个 log handlers 允许将消息附加到任何文件。如果消息来源是可信的你只需要设置你的参数为允许即可。(例如，一种不安全的情况是，用户所拥有的权限低于软件所具有的权限)

下述代码片段可以被用来明确的启用这种 log handler 类型。它可以在 `initLogging()` 之前被调用去支持传递给 `initLoging()` 的 `file` handler 类型。
```
folly::LoggerDB::get()->registerHandlerFactory(
      std::make_unique<folly::FileHandlerFactory>());
```


## Handler Options

The built-in handler types also accept several options to control their
behavior.  These include:

内建的 handler 类型支持几个选项去控制它们自身行为。包括：

### `async`

The `async` option controls whether log messages should be written
asynchronously in a separate thread (when `async` is true) or immediately in
the thread that generated the log messages (when `async` is false).

This mainly affects the behavior when log messages are being generated faster
than they can be written to the output file or stream:

* Using `async=true` will ensure that your program never blocks waiting to
  write the messages.  Instead, the handler will start dropping log messages
  when this occurs.  When it is able to catch up it will emit a message
  indicating how many messages were dropped.

* Using `async=false` will ensure that no log messages are dropped, at the
  expense of blocking your program's normal processing until the log messages
  can be written.

One additional consideration is that `async=false` will ensure that all log
messages have been flushed if your program crashes.  With `async=true` it is
possible to lose some recent messages on program crash.  For instance, if one
thread logs a message and then dereferences a null pointer, `async=false` will
ensure that the log message has been flushed before the thread can proceed to
dereference the null pointer.  However with `async=true` the logging I/O thread
may not have flushed the log message by the time the thread that generated the
message crashes.

With `async=true`, the `max_buffer_size` option controls how much log data may
buffered in memory before dropping new log messages.  This option specifies the
maximum number of bytes of unflushed log data to keep.  New log messages that
would trigger this limit to be exceeded will be discarded.  (Log messages are
either entirely kept or discarded; partial messages are never kept.)

`async` 如果值为 true ：允许从不同的线程`异步`写入消息。如果值为 false：只允许单线程写入消息。

对于写入 file 或者 stream ，当消息的生产快于消息的输出的时候：
- 使用 `async=true` 将确保程序不持有(阻塞)未输出的 message 。但是，在某些情况下会出现消息被丢弃的情况。(细节暂未可知)
- 使用 `async=false` 可以确保没有 log message 被删除，做到这点的前提是，你程序可以误差错处理阻塞。

进一步： `async=false` 时，如果程序崩溃，可以确保所有的 log message 都被打印输出； `async=true` 时当程序崩溃时可能会丢失一些最近的信息。一个实例：如果一个线程即将打印一条消息的时候引用了一个空指针，`async=false` 将确保在应用指针之前讲消息打印这件事完成；然而 `async=true` 的时候日志 I/O 线程，或许还没来得及打印消息，程序就已经崩溃了。

`async=true` 的时候， `max_buffer_size` 选项控制当删除一条内存中的消息时候内存中所能缓存的消息的大小。这个选项指定了缓存中未刷新的日志内容的大小。一个新的消息如果出发了这个限制将会被丢弃。(log messages 或者完全保留，或者完全抛弃，部分消息永远不会被保留。)

### `formatter`

The `formatter` parameter controls how log messages should be formatted.

Currently the only built-in log formatter is `glog`, which formats log messages
similarly to [glog](https://github.com/google/glog).  Additional formatters may
be added in the future, and it is also possible to implement your own
`LogFormatter` class.

`formatter` 参数控制 log message 应该如何被格式化。

当前 folly 的 formatter 基于 `[glog](https://github.com/google/glog)`,更多的格式或许会在将来增加，你也可以实现自己的 `LogFormatter` 类。

# Default Handler Configuration

By default `initLogging()` creates a single log handler named `default`.
This log handler is installed on the root log category, and logs all messages
to stderr using a message format similar to that used by
[glog](https://github.com/google/glog).

This `default` log handler has the `async` option disabled by default.  This
means that `initLogging()` will not spawn a separate logging I/O thread by
default.  However, log messages may delay normal program processing if they are
being generated faster than they can be written to stderr.

High performance programs that want to avoid performance hiccups caused by
logging may wish to enable the `async` option on the default log handler.
This can easily be changed with the logging configuration string.  For
instance, the following string sets the root category's log level to `WARN` and
enables the `async` option on the default log handler:

```
WARN; default:async=true
```

默认的 `initLogging()` 创建一个唯一的名字为 `default` 的 handler。这个 log handler 被安装在日志分类的根(root)上，所有的 message 使用的日志格式和 [glog](https://github.com/google/glog) 相似。

`default` log handlers 有它自己的 `async` 选项。这意味着 `initLogging()` 默认情况下不会生成单独的 I/O 线程。然而，log message 产生的速度如果快于写入 stderr 的速度，程序将会发生延迟。

高性能的程序或许希望通过启用 `async` 选项，来避免应用程序性能的下降。在 logging 设置中对其进行修改是十分方便的。例如：下面的代码设置 log 的 root 类别为 `WARN` 并且启动 `async` 选项。
```
WARN; default:async=true
```



# Custom Log Handlers

It is possible to define your own custom `LogHandler` class should you choose
to.  The `LogHandlerFactory` API enables you to create your own custom
`LogHandler` types from configuration settings parsed by `parseLogConfig()`.
You can use `LoggerDB::get()->registerHandlerFactory()` to register your own
custom log handler type.

定义自己的 `LogHandler` 或许是你的选择。`LogHandlerFactory` 允许你取创建自定义的 `LogHandler` 类型,关于设置可以通过 `parseLogConfig()` 进行修改。你可以使用 `LoggerDB::get()->registerHandlerFactory()` 注册自己的 log handler 类型。

## `StandardLogHandler`

The `StandardLogHandler` class is an implementation of `LogHandler` that
splits log message processing into two steps: formatting the message to a
string, and then writing that string somewhere.

It uses a `LogFormatter` class to perform the message formatting, and a
`LogWriter` class to write the formatted message.

You can provide only a custom `LogFormatter` or `LogWriter` implementation if
you want to customize one of these two steps without providing a full
`LogHandler` implementation of your own.

The `StandardLogHandlerFactory` class can then be used to implement your own
custom `LogHandlerFactory` that creates a `StandardLogHandler` with your custom
log formatter or writer type.

`StandardLogHandler` 类是 `LogHandler` 的一个实现，该类拆分日志分为两部：把 message 格式化，然后将它们写到某处。

使用 `LogFormatter` 处理 message 的格式，使用 `LogWriter` 类 write 格式化的message。

如果你不想完整的实现自己的 `LogHandler` 你可以利用上面提到的 `LogFormatter` 或 `LogWriter` 添加自己的逻辑实现 `LogHandler` 。

`StandardLogHandlerFactory` 类可以被用来实现自定义的 `LogHandlerFactory` 自定义的  `StandardLogHandler` 实现自己的 formatter 或者 writer 逻辑。
