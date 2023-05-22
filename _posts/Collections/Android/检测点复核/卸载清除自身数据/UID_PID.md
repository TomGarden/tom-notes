# UID 和 PID

## 一、澄清 & 概述

### 1.1、澄清
Android 是基于 Linux 做的操作系统，存在对 Linux 功能和模块的大量 删减|修改 。    
所以 Android 和 Linux 有大量相同之处，也有许多差异。
## 1.2、概述
1. UID： 用户 ID
2. PID： 进程 ID

## 二、UID 于 Linux
Linux 是一个多用户多任务的操作系统，使用 UID 来标识一个用户。
```UbuntuTerminal
//ubuntu
tom@ubuntu:~$ ls -l
total 48
drwxrwxr-x           3         tom      tom      4096      Oct 19 02:48   beyourself
drwxr-xr-x           2         tom      tom      4096      Oct 18 20:32   Desktop
[   1    ]         [ 2 ]      [ 3 ]   [  4   ]    [5]      [     6     ]  [    7    ]
 文件权限     连接(包含文件数)  所有者    用户组   文件容量         修改日期     文件名
----
tom@ubuntu:~$ id tom
uid=1000(tom) gid=1000(tom) groups=1000(tom),4(adm),24(cdrom),27(sudo),30(dip),46(plugdev),113(lpadmin),128(sambashare)
tom@ubuntu:~$ id root
uid=0(root) gid=0(root) groups=0(root)
```


## 三、UID 于 Android
```AndroidTerminal
//android
root@hammerhead:/ # ls -l
ls -l
drwxr-xr-x root     root              1970-03-08 06:17 acct
[   1    ] [2 ]   [  3   ]            [       4      ][  5 ]
 文件权限  所有者    用户组                  修改日期    文件名
----
root@hammerhead:/ # id u0_a88
id u0_a88
uid=10088(u0_a88) gid=10088(u0_a88) groups=10088(u0_a88), context=u:r:init:s0
root@hammerhead:/ # id root
id root
uid=0(root) gid=0(root) groups=0(root), context=u:r:init:s0
```
在Android 4.2之前，Android不支持多用户。Android将Linux的账户管理体系用在了应用管理上。

在 AndroidOS 上每一个应用都被分配一个 UID。可以通过 /data/system/packages.xml 文件查看。

Android为应用准备的uid/gid是可以共享的，其目的当然包括这样可以在不同的应用中共享数据和文件。当然，这还需要应用之间的签名匹配。`<manifest> 节点的 android:sharedUserId="string" 属性`
- android:sharedUserId
  - The name of a Linux user ID that will be shared with other applications. By default, Android assigns each application its own unique user ID. However, if this attribute is set to the same value for two or more applications, they will all share the same ID — provided that their certificate sets are identical. Applications with the same user ID can access each other's data and, if desired, run in the same process.

### 3.1、那么 Android 是如何实现多用户的？
Android4.2开始支持多用户。Linux的uid/gid多用户体系已经被用在App管理上了，所以android重新开发了一套多用户体系，在UserManagerService中管理，PackageManagerService和ActivityManagerService中也有相关逻辑。Android的多用户可以做到不同用户的应用的物理文件级（数据）的区分，以实现不同用户有不同的壁纸、密码，以及不同的应用等。本文不展开多用户的机制，只集中于uid。     
先看一下在多用户下，应用的uid怎么变化。     
在一个有两个用户（用户id分别为0和10）的安卓设备上，在用户10下安装一个应用，此时，在0下是看不到这个应用的。     
从packages.xml查看此应用的uid：userId=”10078”     
Process.myUid()得到uid为”1010078”     
Process.myUserHandle()得到”userHandle{10}”     
在另一个用户0下安装此应用。     
查看packages.xml，看到uid没有变化10078     
Process.myUid()得到uid为”10078”        

```terminal
root@hammerhead:/data/user # ls -l
ls -l
lrwxrwxrwx root     root              1970-02-26 04:27 0 -> /data/data/
```
可以看到 /data/user 实际是指向 /data/data 目录的

关于 /data/user/0/  中的 0 (即 UID)目录实际上是 android 系统抽象出来的服务于多用户的文件目录系统。
- 推测：/storage/emulated/0 这里的 0 实际上也是 UID

关于 Android 多用户到这个程度已经可以了，不必再深究。

## 四、相关命令
```terminal
id
相关命令：w,who,whoami,finger

用法：id [选项]... [用户名]
显示指定用户或当前用户(当未指定用户时)的用户与组信息。

  -a                    忽略，仅为与其他版本相兼容而设计
  -Z, --context         仅显示当前用户的安全环境
  -g, --group           仅显示有效的用户组ID
  -G, --groups          显示所有组的ID
  -n, --name            显示组名称而非数字，可与-ugG 一起使用
  -r, --real            显示真实ID 而非有效ID，与-ugG 一起使用
  -u, --user            仅显示有效用户ID
      --help            显示此帮助信息并退出
      --version         显示版本信息并退出

如果不附带任何选项，程序会显示一些可供识别用户身份的有用信息。
```



## 参考
1. [Android手机中UID、PID作用及区别](http://blog.csdn.net/jiaoli_82/article/details/49802613)
2. [Android权限之三共享UID和签名](http://www.linuxidc.com/Linux/2011-03/33279.htm)
3. [Android下uid与多用户释疑（一） ](http://blog.csdn.net/zhanglianyu00/article/details/50238447)
4. [Android下uid与多用户释疑（二） ](http://blog.csdn.net/zhanglianyu00/article/details/50253187)
5. 鸟哥的私房菜(第三版)第六章
