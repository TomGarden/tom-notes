## 0x00、Java 时间相关

## 0x01、 [java.util.Date](https://docs.oracle.com/javase/8/docs/api/java/util/Date.html)

**Since: JDK1.0**

Date 代表特定时间的一个实例，精确到毫秒。

在 JDK 1.1 之前，Date 有两个额外功能。
它允许将日期解释为 年、月、日、时、分、秒。
它也允许将日期格式化输出为字符串，或者解析字符串表示的日期。
不幸的是，这些 API 不易于国际化。
从 JDK 1.1 开始， Calendar 类应该用于日期和时间字段的转换，DateFormat 类应该用于格式化和解释日期字符串。
响应的 Date 函数被弃用了。

虽然 Date 类本来计划用于反应 Coordinated Universal Time(UTC 协调世界时)，但是它在这一点上做的不准确(因为它提供的时间依赖于宿主 JVM)。
几乎所有现代操作系统都假设 `1天 = 24 x 60 x 60 = 86400秒` 。
然而在 UTC(协调世界时) 的体系内每年会有大约 1 到 2 个 leap second(闰秒)，闰秒总是作为 12月31日 或 6月30日 的最后一秒被计算进去。
例如，1995 年的最后一分钟的时间长度是 61 秒，因为增加了闰秒。
多数计算机时钟无法精确反应出闰秒的存在。

一些计算机标准是根据 Greenwich Mean Time(GMT 格林威治) 时间定义的，它和 Universal Time(UT 世界时) 是相等的。
GMT 是这个时间标准的民间称呼； UT 是这个标准的官方称呼。
UTC 和 UT 之间的区别是：UTC 是基于一个原子时钟的，UT 是基于天文观测的；这二者间的实质性的差异是微乎其微的。
因为地球的自转不均匀(它以复杂的方式减速和加速)，UT 并不总是均匀的。
引入闰秒可以使 UTC 保持在 UT1 的 0.9 秒内， UT1 是 UT 做了某些更正后的一个版本。
也还存在其他的日期和时间系统；例如基于卫星的全球未定系统(GPS)使用的时间刻度就是和 UTC 同步的，但是它没有对闰秒进行调整。
美国海军天文台和事件理事会是有趣的信息源：
- http://tycho.usno.navy.mil

其他关于系统时间的定义在：
- http://tycho.usno.navy.mil/systime.html

在所有的 Date 函数中接收或者返回的 年，月，日，时，分，秒 的值表示了如下的含义：
1. y 年由整数 y-1900 表示
2. 月由 [0,11] 范围内的整数表示， 0 表示 1 月， 11 表示 12 月。
3. 日期(某月中的一天)由 [1,31] 范围内的整数表示。
4. 小时由 [0,23] 范围内的整数表示。Thus, the hour from midnight to 1 a.m. is hour 0, and the hour from noon to 1 p.m. is hour 12.
5. 分钟由 [0,59] 范围内的整数表示。
6. 秒由 [0,61] 范围内的整数表示；60 和 61 的值是表示闰秒的，只有 Java 实现中正确追踪闰秒的时候才会出现。
   由于目前引入闰秒的方式，两个闰秒不太可能在同一分钟内出现，但本规范遵循ISO C的日期和时间约定。

不论在什么情况下，提供给函数的采纳数不需要在确定的范围内。
例如可以指定一个日期为 1月32日， 这将被解释为 2月1日。


See Also:DateFormat, Calendar, TimeZone, Serialized Form

## 0x02、 [java.time.LocalDate](https://docs.oracle.com/javase/8/docs/api/java/time/LocalDate.html)

- **Since: 1.8**
- This class is immutable and thread-safe.

符合 ISO-8601 日历系统的没有时区信息的日期，例如 2017-12-03。

LocalDate 是一个不可变的日期时间对象，常见格式为 year-month-day。
其他日期字段，例如 day-of-year, day-of-week and week-of-year 也可能给被访问。
例如 "2nd October 2007" 能被存储在 LocalDate 中。

这个类不存储或者说不体现时区的概念。
相反，它是一个对日期的描述。
它不能表示时间显示上的一个瞬间也没有类似时区偏移量的其他额外信息。

ISO-8610 日历系统是在世界上通用的现代民用日历系统。
它等同于 Gregorian calendar system (Gregorian 日历系统)，其中现行的闰年规则一直适用。
对现今的多数应用，ISO-8601 规则是完全适用的。
然而要使用历史日期，并要求他们准确的应用将会发现 ISO-8601 并不适用。

这是一个基于值的类；在 LocalDate 类上使用身份敏感操作(包括 ‘==’ ，哈希码，或者 `synchronization`)可能造成不可预期的结果，应该避免使用。要比较 LocalDate 应该使用 `equals` 函数。

## 0x03、 [java.util.Calendar]()