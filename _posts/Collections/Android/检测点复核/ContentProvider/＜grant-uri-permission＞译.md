# `<grant-uri-permission>`
## 语法
```xml
    <grant-uri-permission android:path="string"
                          android:pathPattern="string"
                          android:pathPrefix="string" />
```
 ## 定位
 父节点：`<provider>`

 ## 概述：
 这个元素用于给内容提供器的数据子集授权。数据子集是由content:URI的路径部分来标识的。授权是提供器给客户端提供的一种能力，这样客户就可以访问通常没有权限访问的数据，从而克服基于单次访问的限制。

如果内容提供器的grantUriPermissions属性被设置为true，那么权限能够被授予内容提供器范围内的任何数据。但是，如果grantUriPermission属性被设置为false，那么权限就只能授予这个元素所指定的数据子集。一个内容提供器能够包含任意多个个<grant-uri-permission>元素。每个都只能指定一个路径（三个可能属性中的一个）。

有关如何授权的更多信息，请看<intet-filter>元素的grantUriPermissions属性。

## 属性：
- android:path
- android:pathPrefix
- android:pathPattern

一个路径标识了能够被授权的一个或多个数据子集。path属性指定了一个完整的路径，权限只能被授予这个路径所标识的具体的数据子集。pathPrefix属性指定了路径的初始部分，权限能够被授予共享这个初始路径的所有数据子集。pathPattern属性指定了一个完整的路径，但是这个路径中包含了通配符：

1. 星号（`*`）通配符，路径中的`*`星号代表任意多个星号之前的那个字符，如a`*`，可跟a、aa、aaa、aaaa、······字符串匹配。

2. 点跟星号的组合(`.*`)通配符，它可以跟任意字符串进行匹配，如.`*`html，可以跟abchhtml、chtml、html、dssf.html、······等字符串匹配。

因为系统读取XML中的字符串时，会把’\’符号作为强制转义字符，因此就需要两次转义。例如，符号”`*`”要被写成”`\\*`”，符号“`\`”要被写成”`\\\\`”。这与Java代码中的写法基本相同。

有关这三种模式的更多信息，请看PatternMatcher类中的PATTERN_LITERAL、PATTERN_PREFIX、PATTERN_SIMPLE_GLOB的说明。
