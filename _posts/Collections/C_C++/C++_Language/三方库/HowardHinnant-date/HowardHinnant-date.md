

记录时间库的常见使用方式和个人的理解 : https://github.com/HowardHinnant/date


在不和 time_zone 产生交集的时候 , `local_time` / `sys_time` , 这些时间戳都是没有时区信息的 , 或者说他们所表示的是 utc0 时区的时间信息 . 

zoned_time 才是和时区相关联的对象 . 

```c++
  const date::time_zone* timeZone = date::current_zone();
  std::chrono::system_clock::time_point timePoint =  std::chrono::system_clock::now();  /* Linux 的 这个调用 , 不随系统时区变化而变化 , 总是表示 utc0 时间 */

  date::zoned_time zonedTime = date::make_zoned(timeZone, timePoint);                   /* 含有时区信息的时间对象 */
  std::chrono::time_point sysTP = zonedTime.get_sys_time();                             /* utc0 时间戳 */
  date::local_time<std::chrono::nanoseconds> localTP = zonedTime.get_local_time();      /* 时区 时间戳 */
  uint64_t sysTimestemp = sysTP.time_since_epoch().count();
  uint64_t localeTimestemp = localTP.time_since_epoch().count();

  std::string dateFormatStr = "%Y-%m-%d %H:%M:%S";
  std::string sysStrFormat = date::format(dateFormatStr, sysTP);
  std::string localStrFormat = date::format(dateFormatStr, localTP);

  std::cout << "-------------------------------" << std::endl;
  std::cout << std::to_string(sysTimestemp)   << "\t"
            << sysStrFormat << "\t" << std::endl;
  std::cout << std::to_string(localeTimestemp) << "\t"
            << localStrFormat << "\t" << std::endl;


/* 
输出信息
-------------------------------
1667271043906963213     2022-11-01 02:50:43.906963213
1667299843906963213     2022-11-01 10:50:43.906963213
 */
```


如果我们有时间字符串 , 可以转换为时间戳
```C++
      /** @description:  将格式化字符串转换为时间戳 , 这个字符串将被转换为不带有时区信息的时间戳 (即 时区 为 0 的时间戳)
       * @param {String&} str     格式化字符串
       * @param {String&} format  预期格式化字符串和 这个 格式相匹配
       * @return {*}
       */
      timespec Date::toTimespec(const String& str, const String& format) {
        using LocaleTimeNano = date::local_time<std::chrono::nanoseconds>;
        std::istringstream inputSs{str};
        LocaleTimeNano     localeTimeNano;
        inputSs >> date::parse(format, localeTimeNano);             /* 这个转换结果就是 将 str , 作为 0 时区的时间计数量, 转换的时间戳 */

        return toTimespec(localeTimeNano.time_since_epoch().count());
      }
```

如果上述 时间字符串 , 本身就是含有时区信息含义的字符串 , 我们该如何获得该时间点对应的 utc 时间呢 ? 
1. https://howardhinnant.github.io/date/tz.html#convert
2. https://github.com/HowardHinnant/date/issues/764

`zoned_time` 对象表示的就是 `{time_zone*, time point}` 这样一个数据结构
`date::zoned_time` , `date::make_zoned` 函数都是将 数据结构中的两个属性 组合管理了 , 
`get_sys` , 获取 utc  时区时间 , `get_local` 获取本地时间 . 


让人疑惑的地方在于 , 这个探究先暂停 . 目前了解的内容够用了 . 有需要再深究 . 
```c++
  const std::chrono::system_clock::time_point& nowTimePoint = std::chrono::system_clock::now();
  std::cout << date::format(defFormatStr, nowTimePoint) << " : " << nowTimePoint.time_since_epoch().count() << std::endl;

  const date::zoned_time zonedTime = date::zoned_time(inputTz, nowTimePoint);
  std::cout << date::format(defFormatStr, zonedTime.get_local_time()) << " : " << zonedTime.get_local_time().time_since_epoch().count() << std::endl;
  std::cout << date::format(defFormatStr, zonedTime.get_sys_time()) << " : " << zonedTime.get_sys_time().time_since_epoch().count() << std::endl;

  date::local_time<std::chrono::nanoseconds> shangHaiLocalTime = zonedTime.get_local_time();
  const date::zoned_time                     shangHaiZonedTime = date::zoned_time(inputTz, shangHaiLocalTime);
  std::cout << date::format(defFormatStr, shangHaiZonedTime.get_local_time()) << " : " << shangHaiZonedTime.get_local_time().time_since_epoch().count() << std::endl;
  std::cout << date::format(defFormatStr, shangHaiZonedTime.get_sys_time()) << " : " << shangHaiZonedTime.get_sys_time().time_since_epoch().count() << std::endl;


/* 

2022-12-13 08:35:06.610321805 : 1670920506610321805   // 符合预期
2022-12-13 16:35:06.610321805 : 1670949306610321805   // 符合预期
2022-12-13 08:35:06.610321805 : 1670920506610321805   // 符合预期
2022-12-13 16:35:06.610321805 : 1670949306610321805   // 没有向后 推迟 8h 感到疑惑
2022-12-13 08:35:06.610321805 : 1670920506610321805   // 没有向后 推迟 8h 感到疑惑

 */

```





## 关于 时间戳 `std::chrono::system_clock::now()` 
```c++
/* 这个 timePoint 的值 不会随着系统时区的变化发生变化 , 一直都是表示 UTC-0 时区的时间 */
std::chrono::system_clock::time_point timePoint =  std::chrono::system_clock::now();
```


## 关于 `zoned_time`

