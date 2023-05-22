## android os 的环境变量位置

> 原文：https://blog.csdn.net/ls4034/article/details/77774330

最近做的工作中，需要在Android操作系统中设置永久环境变量，是在手机中设置永久变量，而不是PC上。

网上搜了下，大部分都是在PC上设置ADB环境变量什么的，然并卵

在源代码中找了下，发现手机虽然是linux，但并不跟我们平常再服务器上见到的linux那样，没有.profile文件用于设置环境变量。

在手机中查了下，查到了/init.environ.rc这个文件，这个文件中设置的环境变量是可以永久生效的
```
root :/ # cat init.environ.rc
# set up the global environment
on init
    export ANDROID_BOOTLOGO 1
    export ANDROID_ROOT /system
    export ANDROID_ASSETS /system/app
    export ANDROID_DATA /data
    export ANDROID_STORAGE /storage
```

接下来的问题修改了，但是问题来了

即使我手机是root过的版本，在根目录“/”下面依然是没有写权限的，所以已经制作好了手机版本，环境变量就不能追加永久设置了，只能在制作手机版本前做修改


在源码中找了下，发现system/core/rootdir下的init.environ.rc.in是手机中init.environ.rc的模板，编译过程中会在这个文件中配置各种变量，因此，我们在这个文件中追加设置自己想要的变量后再编译版本即可

