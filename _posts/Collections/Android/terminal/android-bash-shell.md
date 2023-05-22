# BusyBox android
>__BusyBox 的安装是失败的。__

## 一、root
## 二、下载
从[BUSYBOX官网](https://busybox.net/)下载二进制文件[Download Binaries](https://busybox.net/downloads/binaries/)。

可以看到根据不同的 CPU 架构存在多种二进制文件，所以接下来我们需要确定自己设备的 CPU 架构。
```
root@hammerhead:/sdcard/Download # cat /proc/cpuinfo
cat /proc/cpuinfo
Processor       : ARMv7 Processor rev 0 (v7l)       [Processor:处理器]
processor       : 0
BogoMIPS        : 38.40                             [BogoMIPS:在系统内核启动时粗略测算的CPU速度]

processor       : 1
BogoMIPS        : 38.40

processor       : 2
BogoMIPS        : 38.40

processor       : 3
BogoMIPS        : 38.40

Features        : swp half thumb fastmult vfp edsp neon vfpv3 tls vfpv4 idiva idivt
CPU implementer : 0x51
CPU architecture: 7
CPU variant     : 0x2
CPU part        : 0x06f
CPU revision    : 0

Hardware        : Qualcomm MSM 8974 HAMMERHEAD (Flattened Device Tree)
Revision        : 000b
Serial          : 0000000000000000
```
如上，我们根据 armv7 获取合适的版版本下载。

## 二、文件 copy 到设备上
1. busybox-armv7l 更名为 busybox
2. adb push 
    - 或者别的什么方法

## 三、安装
1. 查看 `/system/xbin` 路基是否存在
    - 如果不存在创建该路径
2. 把 busybox 复制到该目录下 `cp /sdcard/Donwload/busybox /system/xbin`
    - cp: xwrite: No space left on device
        - 可能会出现上述错误，如果出现也没有问题记得到  `/system/bin` 查看下。
    - 如果确上述cpoy 失败了可以尝试下述命令再试
        - `mount -o remount,rw -t yaffs2 /dev/block/mtdblock3 /system`
3. 增加执行权限 `chmod a+x busybox`
    - 尝试执行 `busybox ls`
        - `Segmentation fault`


## 四、Android 好用的命令行工具
[Termux](https://termux.com/)

## 五、夜神模拟器
1. `adb connect 127.0.0.1:62001`
2. 在执行 1 之后 `adb devices ` 即可查看到夜神模拟器了。


## 参考 & 引用
1. [ [Android] 为Android安装BusyBox —— 完整的bash shell](http://www.cnblogs.com/xiaowenji/archive/2011/03/12/1982309.html)
2. [android adb shell 笔记](http://pako.iteye.com/blog/1857786)
3. [BusyBox ](https://baike.baidu.com/item/busybox/427860?fr=aladdin)
