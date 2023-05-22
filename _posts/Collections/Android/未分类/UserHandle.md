>UserHandle

```java
//代码来自 android-24
//当前列出的属性都是被标记为 @hide 的
public final class UserHandle implements Parcelable {
//……
public static final @UserIdInt int USER_ALL = -1;
public static final UserHandle ALL = new UserHandle(USER_ALL);
//UserHandle.ALL  -------------设备上所有用户均可接收到广播
public static final @UserIdInt int USER_CURRENT = -2;
public static final UserHandle CURRENT = new UserHandle(USER_CURRENT);
// UserHandle.CURRENT  ----------------设备上当前用户可接收到广播
public static final @UserIdInt int USER_CURRENT_OR_SELF = -3;
public static final UserHandle CURRENT_OR_SELF = new UserHandle(USER_CURRENT_OR_SELF);
// UserHandle.CURRENT_OR_SELF  ----------设备上当前用户或者该应用所属用户可接收到广播
public static final @UserIdInt int USER_OWNER = 0;
public static final UserHandle OWNER = new UserHandle(USER_OWNER);
//UserHandle.OWNER  ------------------设备所有者可接收到广播
public static final @UserIdInt int USER_SYSTEM = 0;
public static final UserHandle SYSTEM = new UserHandle(USER_SYSTEM);
//UserHandle.SYSTEM  ------------------设备的系统用户可接收到广播
//……
}
```

- 从 android-17 引入这个 final 类开始上述代码中所列出的属性 就是  @hide  的。

## `@hide` 到底代表着什么呢？

>The first one is located in package com.android.internal. The second API type is collection of classes and methods that are marked with @hide javadoc attribute.
The hidden methods can still be accessed via java reflection. The @hide attribute is just part of javadoc(droiddoc also), so the @hide just simply mean the method/class/field is excluded from the API docs. 



## 参阅：
1. [android.os.UserHandle ](https://developer.android.google.cn/reference/android/os/UserHandle.html)
2. https://stackoverflow.com/questions/17035271/what-does-hide-mean-in-the-android-source-code
3. [doclava - JavadocTags.wiki](https://code.google.com/archive/p/doclava/wikis/JavadocTags.wiki#@hide)
