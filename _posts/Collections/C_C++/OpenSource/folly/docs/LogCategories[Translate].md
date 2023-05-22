# Log Categories

Each log message is logged to a specific log category.

Log categories have a level setting that controls what log messages should be
enabled for this category, as well as a list of log handlers that control what
should be done with enabled log messages.

每一条日志消息(log message)都会被记录到特定的日志类别(log category)。

日志类别(log category)中的 level setting 控制这可以使用日志类别的日志消息(log message)，其中的日志处理程序(log handler)列表控制着可以处理日志消息(log message)的日志处理程序(log handler)。

# Log Category Hierarchy [日志类型级别]

Log categories are arranged in a hierarchy.  Each log category except for the
root has a parent category, and they may have zero or more children categories.

The log category hierarchy is determined by category names: the `.`
character acts as a separator in category names.  For example, the category
`spacesim` is the parent of the category `spacesim.ships`.  The root category
can be referred to either as `.` or as the empty string.

One recommended option for choosing log category names is to follow the source
code directory structure.  For example, a partial view of the log category
hierarchy for a space simulator project might look something like:

```
. --- spacesim --- ships --- corvette -- cpp
               \         \            \- h
               |          \- cruiser -- cpp
               |                     \- h
               |
                \- actors --- player -- cpp
                          \          \- h
                           \- ai --- enemy -- cpp
                                           \- h
```

The `XLOG()` macro automatically selects the log category to use based on the
source file path.

日志类别按层次排列。除跟类型外的每一个类型都有一个父类型，有零个或多个子类型。

日志类型层次结构(log category hierarchy)由类型名称决定： `.` 字符在类型名中起到分隔符的作用。例如，类型 `spaceim` 是 `spacesim.ships` 类型的父类型。`.` 或者 空字符 可以代表根类型。

指定类型名字的一个推荐的做法是按照源码的文件结构(包结构)来指定。例如，一个空间模拟器的局部日志类别(log category)视图结构如下：
```
. --- spacesim --- ships --- corvette -- cpp
               \         \            \- h
               |          \- cruiser -- cpp
               |                     \- h
               |
                \- actors --- player -- cpp
                          \          \- h
                           \- ai --- enemy -- cpp
                                           \- h
```

宏 `XLOG()` 会自动使用源码文件路径作为日志类型。

# Log Level Propagation [日志级别的传递]

Log level settings automatically propagates downward from a particular log
category to its children.

If the log verbosity is increased on a particular log category (by lowering the
minimum enabled log level) , all of its children also inherit that increased
log verbosity by default.  For instance, setting the log level to `INFO` on
`spacesim.ships` will automatically enable `INFO` and higher log messages on
the `spacesim.ships` category as well as children categories such as
`spacesim.ships.corvette`, `spacesim.ships.fighter`, etc.  This makes it easily
possible to control the log verbosity of entire sections of the code base at
once.

Log level propagation can be disabled on specific categories by turning off the
`inherit` setting for that category.  For instance, disabling the `inherit`
setting on the `spacesim.ships.cruiser` category will prevent it form
inheriting increased log level verbosity from its parent `spacesim.ships`
category (or indirectly inheriting settings from `spacesim` or the root
category).  This makes it possible to turn down the verbosity for specific
categories even if when a larger category they belong to does have a higher
verbosity setting.

对一个特定日志类型(log category)的日志级别(log level)设置会自动向下传递给它的子日志类型(log category)。

如果一个特定的日志类别(log category)日志的详细程度被增大(通过降低最低日志启动级别),所有该日志类型的子日志类型的日志详细程度也会默认增大。例如，设置 `spacesim.ships` 的日志级别(log level)为 `INFO` 将会自动的允许在 `spacesim.ships` 及 `spacesim.ships.corvette`, `spacesim.ships.fighter` 等子类型中允许显示比 `INFO` 更高级别的日志信息。这样可以通过一次编码的方式更方便的控制整个代码库的日志详细程度。

我们可以控制指定的日志类型(log category)日志级别传递的开关，日志类型中的 `inherit` 属性就是这一功能的开关。例如，取消 `spacesim.ships.cruiser` 日志类型中的 `inherit` 设置，其父类型 `spacesim.ships` 对于日志详细程度的设置就对它无效了(或者从根类型`spacesim`中间接继承对于 `inherit` 的设置)。这使得当一个特定的日志类型有较高的日志详细程度的时候，其子类型拥有较低的日志详细程度成为可能。

# Log Message Propagation

Logged messages propagate upwards through the log category hierarchy.

For instance, a message logged to `spacesim.ships.corvette.cpp` will first be
sent to any `LogHandler` objects configured on `spacesim.ship.corvette.cpp`,
then to the handlers for `spacesim.ships.corvette`, then `spacesim.ships`, then
to `spacesim`, and finally to the handlers for the root log category.

Due to this behavior, if you install a `LogHandler` on the root log category it
will automatically receive all messages logged to any category.  Installing
`LogHandler` objects on sub-categories allows you to perform handling only for
specific category messages.  `LogHandler` objects receive the full `LogMessage`
object, and can perform further filtering based on the log level or other
message properties if desired.

The [Log Handler](LogHandlers.md) documentation provides additional details
about log handler behavior.

日志消息通过日志类型等级(log category hierarchy)向上传递。

例如，一个来自 `spacesim.ships.corvette.cpp` 日志消息将首先发送到在 `spacesim.ships.corvette.cpp` 中配置过的 `LogHandler` 对象，然后发动到处理程序(log handler)的 `spacesim.ships.corvette` 然后是 `spacesim.ships` 然后是 `spacesim` 最终值处理程序的根日志类别。

由于这种行为，如果你在根日志类型中设置一个 `LogHandler` ，它将自动接受来自所有日志类别的所有消息。将 `LogHandler` 对象设置到子日志类型中，将允许你只接受指定日志类型的消息。`LogHandler` 接受完整的 `LogMessage` 对象，并且如果需要的话，它可以根据机制级别(log level) 或者其他消息属性进行日志过滤。

[Log Handler](LogHandlers.md)有更过关于 `LogHandler` 的行为描述。
