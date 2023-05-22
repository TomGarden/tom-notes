## 1. PendgingIntent提权为什么需要两个App才能完成？
关于：[说说PendingIntent的内部机制](https://my.oschina.net/youranhongcha/blog/196933)

pendingIntent是一种特殊的Intent。主要的区别在于Intent的执行立刻的，而pendingIntent的执行不是立刻的。    
pendingIntent执行的操作实质上是参数传进来的Intent的操作。

PendgingIntent通过各种初始化方式都要传入一个Context引用，并且不依赖创建引用的运行而独立存在，归AMS（Activity Manager Service）管理。     
所以PendingIntent携带的Intent有了使用Context权限的可能。   

同时我们要做的是提权测试，所以在同一个应用中做这个测试就完全没有意义了，所以在两个应用进行。

## 2. 为什么有系统版本限制？
比较笼统的说就是源码有变。但是这明显不够。所以我们探究一下这个源码跟踪的过程吧。


PendingIntent.getIntent()为什么通过反射无法修改PendingIntent中的Intent？
PendingIntent.send 从源码层面理解是如何完成新Intent对旧Intent信息修改的？
