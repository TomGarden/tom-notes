Logging Configuration
=====================

Overview
--------

The logging library is normally configured using configuration strings.

In its most basic format, the configuration string consists of a comma
separated list of `CATEGORY=LEVEL` pairs, e.g.:

```
folly=INFO,folly.io.async=DBG2
```

A log level name can also be specified by itself to affect the root log
category:

```
WARN
```

These are the two forms that users will probably use most often for customizing
log levels via command line arguments.  Additional settings, including log
handler settings, can also be included.  The syntax is documented more
completely in the [Basic Configuration Syntax](#basic-configuration-syntax)
section.

Log configuration can also be specified using JSON as well.  If the log
configuration string starts with a leading `{` character (optionally after
leading whitespace), it is parsed as a JSON object.  The JSON configuration
format is documented in the
[JSON Configuration Syntax](#json-configuration-syntax) section.

In general the basic configuration syntax is convenient for controlling log
levels, and making minor log handler setting changes (such as controlling if
logging goes to stdout or stderr, and whether it is logged asynchronously or
not).  However the JSON format is easier to use to describe more complicated
settings.


概述
---

logging library 通常使用字符串完成配置。

在其最基本的配置格式中，配置志字符串是由逗号分隔的 `CATEGORY=LEVEL` 列表组成，例如：
```
folly=INFO,folly.io.async=DBG2
```

日志级别(log level)可以由其自己指定，并且影响跟日志类别：

```
WARN
```

有两种常用的配置方式可以被使用者用来定制日志级别，其他的设置包括日志处理程序(log handler)也可以被包含其中。详细描述见[Basic Configuration Syntax](#basic-configuration-syntax)

日志配置也可以指定使用 JSON 。如果日志配置字符串使用 `{` 字符开始(其后加一空格之后内容随意)，将被作为 JSON object 解析。关于 JSON 配置格式详见描述[JSON Configuration Syntax](#json-configuration-syntax)

一般而言，基本配置语法(Basic Configuration Syntax)可以方便的配置日志级别，并且需要很小的配置修改(例如：控制写入 stdout 或者 stderr 或者控制 asynchronously 开关)。而 JSON 格式易于用来描述更复杂的设置。

Basic Configuration Syntax
--------------------------

The basic configuration format is parsed using `parseLogConfig()`.

The basic format string is separated with semicolons.  Everything up to the
first semicolon specifies LogCategory configurations.  Each remaining
semicolon-separated section defines a LogHandler configuration.

To keep the basic format simple, it does not support any form of character
escape sequences.  If you need to define a log category whose name includes a
special character like a comma or semicolon use the JSON format instead.

基本配置格式(Basic configuration format)使用 `parseLogConfig()`解析。

基本配置字符串被分号(semicolons)分隔。第一个分好之前指定的是对 LogCategory 的配置。
其余的每一个分号分隔(semicolon-separated)部分都是 LogHandler 的配置。

为了保持简单的基本格式，它不支持所有的字符转义序列。
如果你需要定义一个名称包含特殊字符(例如逗号或者分号)的日志类别，请使用 JSON 格式。

### Grammar Overview

```
<config> ::= <category_configs> <handler_configs>
<category_configs> ::= <category_config>
                     | <category_config> "," <category_configs>
                     | <empty_string>
<handler_configs> ::= ";" <handler_config>
                    | ";" <handler_config> <handler_configs>
                    | <empty_string>

<category_config> ::= <cat_level_config> <handler_list>
<cat_level_config> ::= <level>
                     | <catgory_name> "=" <level>
                     | <catgory_name> ":=" <level>
<handler_list> ::= ":" <handler_name> <handler_list>
                 | <empty_string>

<handler_config> ::= <handler_name> "=" <handler_type> ":" <handler_options>
                   | <handler_name> ":" <handler_options>
<handler_options> ::= "," <option_name> "=" <option_value> <handler_options>
                    | <empty_string>

<catgory_name> ::= <atom>
<handler_name> ::= <atom>
<handler_type> ::= <atom>
<option_name> ::= <atom>
<option_value> ::= <atom>
<atom> ::= any sequence of characters except ";", ",", "=", or ":",
           with leading and trailing whitespace ignored

<level> ::= <log_level_string>
          | <positive_integer>
<log_level_string> ::= any one of the strings accepted by logLevelToString()
```

### Log Category Configuration

The log category configurations are a comma-separated list.  Each element in
this list has the form

```
NAME=LEVEL:HANDLER1:HANDLER2
```

The log category name and '=' sign can be omitted, in which case the setting
applies to the root log category.  The root log category can also be
explicitly named either using the empty string or the name ".".

The NAME and LEVEL can also be separated with ":=" instead of "=",
which disables log level inheritance for this category.  This forces
category's effective log level to be the exact level specified, even if its
parent category has a more verbose level setting.

The log handler settings for a log category can be omitted, in which case
the existing log handlers for this category will be left unchanged when
updating the LoggerDB settings.  Specifying an empty log handler list (a
trailing ':' with no log handlers following) will cause the log handler list
for this category to be cleared instead.

日志配置是一个逗号分隔的列表。每一个元素保持如下的格式：
```
NAME=LEVEL:HANDLER1:HANDLER2
```

日志类别名字和 '=' 符号可以被省略，在这种情况下设置适用于根类别(root log category)。
根日志类别也可以明确指定类别的名字，也可以使用空字符串，或者使用"."。

NAME 和 LEVEL 也可以使用 ":=" 替换 "="，这将禁止这个日志类别(log category)的继承。
强制类别可以指定日志的最终级别，在使用强制类别的时候当前日志类别不会被父日志类别影响。

为日志类别(log category) 设置日志处理程序(log handlers) 可以省略，在这种情况下，当升级 LoggerDB 设置时，当前日志类别(log catgory)现有的日志处理程序(log handlers)将保持不变。指定一个空的日志处理程序(log handler)列表(结尾处使用 ':' 将导致没有日志处理程序)将导致当前日志类别(log category)日志处理程序(log handler)被清空。


### Log Handler Configuration

Each log handler configuration section takes the form

```
NAME=TYPE:OPTION1=VALUE1,OPTION2=VALUE2
```

NAME specifies the log handler name, and TYPE specifies the log handler
type.  A comma separated list of name=value options may follow the log
handler name and type.  The option list will be passed to the
LogHandlerFactory for the specified handler type.

The log handler type may be omitted to update the settings of an existing log
handler object:

```
NAME:OPTION1=VALUE1
```

A log handler with this name must already exist.  Options specified in the
configuration will be updated with their new values, and any option names not
mentioned will be left unchanged.

每一个日志处理程序(log handler)配置部分如下：
```
NAME=TYPE:OPTION1=VALUE1,OPTION2=VALUE2
```

NAME 指定 log handler 名字，TYPE 指定 log handler 类型。
一个逗号(comma)分隔的 `name=value` 列表或许会跟随在 log handler 的类型之后。
这个选项列表(`name=value`)将被传递给指定处理类型的 `LogHandlerFactory`。

在更新已经存在log handler 对象的设置的时候 log handler type 可以省略：
```
NAME:OPTION1=VALUE1
```

NAME 中所指定的 log handler 是已存在的。
配置中指定的选项将更新为新值，所有未提及的保持不变。

### Examples

Example log configuration strings:

* `ERROR`

  Sets the root log category level to ERR.  (Note that `ERROR` is allowed in
  configuration strings as an alias for the `LogLevel::ERR` value.)

* `folly=INFO,folly.io=DBG2`

  Sets the "folly" log category level to INFO, and the "folly.io" log
  category level to DBG2.

* `folly=DBG2,folly.io:=INFO`

  Sets the "folly" log category level to DBG2, and the "folly.io" log
  category level to INFO, and prevent it from inheriting its effective log
  level from its parent category.  DBG2 log messages sent to "folly.io" will
  therefore be discarded, even though they are enabled for one of its parent
  categories.

* `ERROR:stderr, folly=INFO; stderr=stream:stream=stderr`

  Sets the root log category level to ERROR, and sets its handler list to
  use the "stderr" handler.  Sets the folly log level to INFO.  Defines
  a log handler named "stderr" which writes to stderr.

* `ERROR:x,folly=INFO:y;x=stream:stream=stderr;y=file:path=/tmp/y.log`

  Defines two log handlers: "x" which writes to stderr and "y" which
  writes to the file /tmp/y.log
  Sets the root log catgory level to ERROR, and configures it to use the
  "x" handler.  Sets the log level for the "folly" category to INFO and
  configures it to use the "y" handler.

* `ERROR:default:x; default=stream:stream=stderr; x=file:path=/tmp/x.log`

  Defines two log handlers: "default" which writes to stderr and "x" which
  writes to the file /tmp/x.log
  Sets the root log catgory level to ERROR, and configures it to use both
  the "default" and "x" handlers.

* `ERROR:`

  Sets the root log category level to ERR, and removes any log handlers
  configured for it.  Explicitly specifying an empty list of handlers (with
  a ':' followed by no handlers) will update the handlers for this category
  to the empty list.  Not specifying handler information at all (no ':')
  will leave any pre-existing handlers as-is.

* `;default=stream:stream=stdout`

  Does not change any log category settings, and defines a "default" handler
  that writes to stdout.  This format is useful to update log handler settings
  if the "default" handler already exists and is attached to existing log
  categories.

* `ERROR; stderr:async=true`

  Sets the root log category level to ERR, and sets the "async" property to
  true on the "stderr" handler.  A log handler named "stderr" must already
  exist.  Therefore this configuration string is only valid to use with
  `LoggerDB::updateConfig()`, and cannot be used with
  `LoggerDB::resetConfig()`.

配置字符串举例：
- `ERROR`

  设置根日志类型等级为 ERR 。(注意在配置字符串中 `ERROR` 字符串可以使用别名 `LogLevel::ERR`)。

- `folly=INFO,folly.io=DBG2`

  设置 "folly" 日志类型等级为 INFO，并且 "folly.io" 日志类型等级为 DBG2 。

- `folly=DBG2,folly.io:=INFO`

  设置 "folly" 日志类型等级为 DBG2 ,"folly.io" 日志类型等级为 INFO ，防止它从父类别集成有效的日志级别。即使它们的父类别之一启用，DBG2 发送到 "folly.io" 的日志信息也将被启用。

- `ERROR:stderr, folly=INFO; stderr=stream:stream=stderr`

  设置根日志类别为 ERROR ，设置它的处理程序列表使用 "stderr" 处理。
  设置 folly 日志等级为 INFO。定义一个日志处理程序名字为 "stderr" 将日志写入 stderr。

- ……


JSON Configuration Syntax
-------------------------

The `parseLogConfig()` function, which parses the basic configuration string
syntax, will also accept a JSON object string as input.  However, you can also
use `parseLogConfigJson()` to explicitly parse the input as JSON, and not
accept the basic configuration string syntax.

The input string is parsed using relaxed JSON parsing, allowing C and C++ style
comments, as well as trailing commas.

The JSON configuration string must be a JSON object data type, with two
optional members: `categories` and `handlers`.  Any additional members besides
these two are ignored.

`parseLogConfig()`方法解析基本配置语法(base configuration)字符串 ，也处理 JSON 对象字符串。然而你还可以使用 `parseLogConfigJson()` 方法明确的初一 JSON 输入，该方法不能处理基本配置语法(base configuration)字符串。

输入的字符串可以轻松的解析 JSON 字符串，允许使用 C/C++ 风格的注释，也允许末尾尾随逗号。

JSON 配置字符串必须是 JSON 对象类型，包括两个可选成员 `categories` 和 `handlers`。除这两个成员之外的其他成员均会被忽略。

### Log Category Configuration

If present, the `categories` member of the top-level object should be a JSON
object mapping log category names to configuration settings for that log
category.

The value of each element in `categories` should also be a JSON object with the
following fields:

* `level`

  This field is required.  It should be a string or positive integer value
  specifying the log level for this category.

* `inherit`

  This should be a boolean value indicating if this category should inherit its
  effective log level from its parent category if its parent has a more verbose
  log level setting.

  This field is optional, and defaults to true if not present.

Alternatively, the value for a log category may be a plain string or integer
instead of a JSON object, in which case case the string or integer is treated
as the log level for that category, with the inherit setting enabled.

如果存在，顶级对象的类型(categories)成员应该是一个 JSON 对象映射日志类别名称到该日志类别的配置设置。

`categories` 中每一个元素的值也应该是一个 JSON 对象，该 JSON 对象包含下述两个属性：
- `level`

  这个属性是必须的。它应该是一个字符串(string)或者是一个正整数(integer),本属性用来指定特定日志类别的等级。

- `inherit`  

  这个属性应该是一个 `bool` 值，表示如果当前类型(categort)的父类型如果有更详细的日志级别(log level)当前类型(category)是否应该继承其父类型的能力。

  本属性是可选值，如果没有指定，默认为 true。

或者，日志类别(log category)的值可以是纯数字或者纯字符串而不是 JSON 对象，这种情况下字符串/数字会被作为日志分类的级别，按照继承的内容进行设置。

### Log Handler Configuration

If present, the `handlers` member of the top-level object should be a JSON
object mapping log handler names to configuration settings for that log
handler.

The value of each element in `handlers` should also be a JSON object with the
following fields:

* `type`

  This field should be a string containing the name of the log handler type.
  This type name must correspond to `LogHandlerFactory` type registered with
  the `LoggerDB`.

  If this field is not present then this configuration will be used to update
  an existing log handler.  A log handler with this name must already exist.
  The values from the `options` field will be merged into the existing log
  handler options.

* `options`

  This field is optional.  If present, it should be a JSON object containing
  string-to-string mappings to be passed to the `LogHandlerFactory` for
  constructing this log handler.

如果存在，用来配置日志处理程序(log handler) 的 `handler` 成员应该是一个名字和 JSON 对象相对应的顶级日志处理程序(logs handlers)。

`handlers` 元素的值应该是一个包含下述属性的 JSON 对象：

- `type`

  本属性应该是一个包含日志处理程序(log handler)类型的字符串。该类型必须对应一个注册到 `LoggerDB` 的 `LogHandlerFactory` 类型。

  如果这个属性(字段)不存，在那么本配置将会被用来去更新一个已经存在的日志处理程序(log Handler)。一个再此配置了的日志处理程序(log handler)是必然存在的。来自 `options` 的属性(字段)将会被合并成这个已存在的日志处理程序(log handler)选项。

### Example

```javascript
{
  "categories": {
    "foo": { "level": "INFO", "handlers": ["stderr"] },
    "foo.only_fatal": { "level": "FATAL", "inherit": false }
  }
  "handlers": {
    "stderr": {
      "type": "stream",
      "options": {
        "stream": "stderr",
        "async": true,
        "max_buffer_size": 4096000
      }
    }
  }
}
```


Custom Configuration Mechanisms
-------------------------------

Internally the the `LogConfig` class represents configuration settings for the
folly logging library.  Users of the logging library can also programmatically
construct their own `LogConfig` objects and use the `LoggerDB::updateConfig()`
and `LoggerDB::resetConfig()` APIs to apply the configuration changes.

You can also directly manipulate the log level and other settings on
`LogCategory` objects.

While it is possible to also manually create new `LogHandler` objects, it is
generally preferred to do this using the `LoggerDB::updateConfig()` and
`LoggerDB::resetConfig()` APIs.  If you manually create a new `LogHandler` and
directly attach it to some categories the `LoggerDB::getConfig()` call will not
be able to return complete information for your manually created log handler,
since it does not have a name or handler type that can be included in the
configuration.

`LogConfig`类就代表了`folly`的配置设置。开发人员也可以自己编写自己的 `LogConfig` 对象，并且通过 `LoggerDB::updateConfig()` 和 `LoggerDB:resetConfig()` APIs 取变化的配置。

你也可以通过 `LogCategory` 对象直接操作日志级别(log level)和其他设置。

当然了手动创建 `LogHandler` 对象也是可以的，但是通过 `LoggerDB::updateConfig()` 和 `LoggerDB::resetConfig()` APIs 来完成这一动作是更常用的手法。如果你手动创建了一个新的 `LogHandler` 并且立刻将其附加到某个类别(category)上，`LoggerDB::getConfig()`被调用将无法为你手动创建的日志处理程序(log handler)返回完整的信息，因为它(LogHandler)的 name 或者 handler type 信息没有被包含到配置中。
