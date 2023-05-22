---
layout: post
title:  null
date:   2018-10-19 16:44:04 +0800
categories: jekyll update
author: Tom
---

-----------------------------
__目录__
- jekyll 的 kmarkdown 负责解析
{:toc}

-----------------------------
<br>

## 0x00、 java.lang.ClassNotFoundException
在 Android 中通过 reflect 技术能访问某些文件，而另一些会 throw 标题所示的异常。
这件事我有些疑惑。

```java
Class.forName("com.android.server.pm.PackageManagerService");
//Method threw 'java.lang.ClassNotFoundException' exception.        
```

```java
Class.forName("android.app.ActivityManagerNative");//No problem
```


上述两个文件有相同之处：
- 都包含 `{@hide}` 注释 

不同之处在于：
- 所处包不同

那么是不是因为包不同而被限制住了呢，我们尝试查看下 Class 的源码。
- 如果有这个限制是 OS 的开发者限制住的？
    - 看了下 forName 的实现细节，没有发现对包名的过滤。


这件事情让我十分困惑。

