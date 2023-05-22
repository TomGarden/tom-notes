但凡想要进行一些细节操作的时候都会因为对 Android 系统的一些操作不了解而感到困惑 . 

__目的__ : 这次是在完善 lib_pickcolor 的时候 , DialogFragment 的状态保存不知道怎么保存函数参数(kotlin) , 
但是 SDK 提供的 AlertDialog 却是可以保存部分自己的按钮实现代码的 , 所以想模仿它 , 又无从下手 , 
所以就再次来到 AOSP 了 .

__路线__ : 从 App 启动入手 , 这样的话能预见到的重点为:
1. Activity 启动流程 , 生命周期过程
2. 切换横竖屏过程中 Activity 生命周期变化细节
3. 依赖 Activity 生存的 Fragment 的生命周期变化细节
4. 由 Fragment 持有的 Dialog 的随着 宿主 生命周期变化所产生的响应状态存储于重建

嗯 , 日拱一卒


## 0x00. 最自然的我们就从桌面点击启动一个应用开始分析

我们的代码版本(编译虚拟机的版本和源代码的版本是相同的)
```
============================================
PLATFORM_VERSION_CODENAME=REL
PLATFORM_VERSION=10
TARGET_PRODUCT=aosp_x86
TARGET_BUILD_VARIANT=eng
TARGET_BUILD_TYPE=release
TARGET_ARCH=x86
TARGET_ARCH_VARIANT=x86
HOST_ARCH=x86_64
HOST_OS=darwin
HOST_OS_EXTRA=Darwin-19.5.0-x86_64-10.15.5
HOST_BUILD_TYPE=release
BUILD_ID=QQ3A.200605.002.A1
OUT_DIR=out
============================================
```

1. 我们知道桌面也是一个 应用层的 APP , 但是忘记了这个应用叫什么名字 , 查看进程名 猜测是 nexuslauncher 
2. 现在需要查看这个应用程序的源代码做出部分修改来验证这一猜测
3. __失败描述__: (没有使用源代码编译模拟器)尝试在 launcher MAIN Activity 打断点 , 完全无法完成断点 : __断点失败原因未知__
    - 系统应用找了一圈只直到 setting app 断点成功才做此记录
4. __成功描述__: (使用当前源码编译虚拟机)重新编译一次, 查看 Luncher 完全在掌控之中, 看来早晚是需要一个 pixel 的

## 0x01. 感受
当看到 Launcher.java 一个文件 2000+ 行代码 , 我就告诉自己我一定不能傻傻的一行一行读 , 
- 一定要按需跳读 , 保证脉络清晰就好 , 不要在细节上花费过多时间

## 0x02. 门槛
> 这一小节可以先跳过, 后面碰到困难的时候可以回来寻找对应的细节

### 2.1. 关于 Android 通信机制的细节
- Binder 通信机制理解
- AIDL(Android Interface Definition Language)
  - https://developer.android.com/guide/components/aidl
  - [跟随此 aidl 指导写代码体验下, 基本能理解 aidl 通信的过程](https://developer.android.com/guide/components/aidl?hl=zh-cn)
  - [IDL(Interface description language)](https://en.wikipedia.org/wiki/Interface_description_language)
  - 绑定服务概览
    - https://developer.android.com/guide/components/bound-services
    - https://developer.android.com/guide/components/bound-services?hl=zh-cn
- RPC(remote procedure calls/远程过程调用)
  - IPC(interprocess communication/进程间通信)

## 0x02. APP 启动流程 从 Launcher 点击作为起点

### 2.1. Launcher 进程的事件跟进
大致脉络如下 , 看代码的时候参考这个脉络自然是清晰的
1. 点击事件监听
2. Activity.startActivity
3. Activity.startActivityForResult
4. IActivityTaskManager.startActivity
   ```java
   //aosp/frameworks/base/core/java/android/app/Instrumentation.java
   int result = ActivityTaskManager.getService()
       .startActivity(whoThread, who.getBasePackageName(), intent,
               intent.resolveTypeIfNeeded(who.getContentResolver()),
               token, target != null ? target.mEmbeddedID : null,
               requestCode, 0, null, options);
   ```
   至此 `IActivityTaskManager.aidl` 文件在 IPC C/S 架构中的 server 端实现代码就是我们要寻找的目标
   - IPC 服务端会实现 `IActivityTaskManager.Stub` 类
   - 所以可以通过全局检索 `extends IActivityTaskManager.Stub` , 
      来找到 server 端接口实现 , 从而了解 `startActivity` 的调用细节 . 
      事实是恰好只有一个实现类: `aosp/frameworks/base/services/core/java/com/android/server/wm/ActivityTaskManagerService.java` 
   - 需要注意的是, 如果要断点 `ActivityTaskManagerService` 需要针对进程 `system_process` , 而不是应用进程

### 2.2. SystemProcess 进程的事件跟进


#### 2.2.1. startActivity
略


#### 2.2.2. startActivity 如何触发 activityPaused
从图中吸收吧 

在这一部分存疑的问题 , 在真正触发新进程创建之前的判断逻辑跟进暂未完成 , 
因为如果无需新建进程的情况下 , 是不会触发后续流程的 .

#### 2.2.3. 触发新进程启动动作

- ActivityTaskManagerService.activityPaused , 触发后续动作 .
- ActivityStackSupervisor.startSpecificActivityLocked 通过进程间通信 , 做进一步触发
- LocalService.startProcess 是一个较为明确的入口 , 进入后续动作




startSpecificActivityLocked:1008, ActivityStackSupervisor (com.android.server.wm)
resumeTopActivityInnerLocked:3040, ActivityStack (com.android.server.wm)
resumeTopActivityUncheckedLocked:2578, ActivityStack (com.android.server.wm)
resumeFocusedStacksTopActivities:1159, RootActivityContainer (com.android.server.wm)
completePauseLocked:1843, ActivityStack (com.android.server.wm)
activityPausedLocked:1770, ActivityStack (com.android.server.wm)
handleMessage:455, ActivityStack$ActivityStackHandler (com.android.server.wm)
dispatchMessage:107, Handler (android.os)
loop:214, Looper (android.os)
run:67, HandlerThread (android.os)
run:44, ServiceThread (com.android.server)



#### 2.2.*. 进程日志梳理

1. ActivityTaskManagerService.startActivity
2. ActivityTaskManagerService.activityPaused
    - 核心代码由这个流程入口触发, 所以我们有理由相信 当前 Activity 的 startActivity 动作
      会触发 当前 activity 的 activityPaused 动作 , 进而有更多额外操作
3. 现在需要跟进的是 startActivity 如何触发 activityPaused 动作
    - 了解 startActivity 更多细节查看是否有触发 activityPaused 的动作
    - 如果在这里是在找不到还有一个思路 , 更深入的理解 Binder 看看通信更深入的细节或需有帮助
    - 创建新 Task 的时候也做了应用和系统进程间的 binder 通信
      - 已经厘清 , 首次进入这个调用栈 , 没有执行有效的逻辑就返回了
      - 但是发送了 Handler 通信 , 可以监听这个通信点 , 但是不用监听信息发送的整个流程了
    - 找到了 哇哈哈哈哈哈 , 通过 Binder 通信告知 Launcher 暂停自身
      - 猜测后续会触发 ActivityTaskManagerService.activityPaused

    - 进程间通信流程固然重要,  厘清各个进程内部的线程间通信也十分必要 , 
      尤其是 System-process 进程中的线程间通信

    - 感觉上有一个 Handler 在做循环等待 Client 做部分修正
    - 


4. ActivityTaskManagerService.startActivity 在断点的调试的时候会有多次调用 , 需要理解
    - 应该尝试在了解之前内容的情况下将断点延后


5. 至此我们可以继续下一步跟进动作了
  - 第一次完整跟进 , 我们并没有抓住重点 , 直到新的 Activity 启动完成 都没有找到合理的重点代码
    但是这其中到是存在一个 handler 对象 , 或需是突破 , 再看看吧 .
  - 既然如此我们不要急于找到与启动 Activity 启动相关的关键点 , 虽然这是最终目的
    我们暂时把精力转移到理解这一个调用流程上, 看看都做了什么事情, 然后逐个了解这几个事情, 最终定位到 Activity 的启动细节
  - 第二次完整跟进 , 还是没有抓到在重点 , 但是有一点可以关注一下 , 那就是目标应用进程的启动
    - 在 Launcher 应用启动新应用的过程中我们一共有三个进程参与这个动作
      - Launcher 进程 , 负责 UI 交互 , 获取目标 Activity 的初始信息
      - System 进程 , 负责启动目标 Activity 进程
        - 前两次跟丢了就是在这里跟丢的 , System 进程启动目标应用进程的动作我们没有准确锁定 , 启动目标应用进程后的后续动作我们没有跟踪到
        - 掐卡在进程启动入口了, 我们先定位进程启动位置 , 后定位 activity 启动位置
  - 第三次完整跟进还是无功而返
    - 其中有的地方也进行了函数传递 , 可以再留意一下
  - 后来查阅了 Android 系统源代码分析中的相关章节 , 由于不同版本代码已经有了较大变化 .
    - 我们在关键的代码位置 `Process.start(...)` 断点发现调用栈是来自
    - `ServiceThread` -> `HandlrThread` -> `Looper` -> 略
    - 这说明我们对 Handler 通信机制细节还有可以深入理解的地方
    - https://developer.android.com/guide/components/bound-services#Messenger
      - Handler.sendMsg 并非都能引起 handleMessage 回调 , 携带 Runnable 的 sendMsg 就是一个例子
      - Handler.post 也不能引起 handleMessage 回调
      - 这一部分可以先解析一下再继续回到 Application 启动的流程中去
      - 带着问题去看 , 先明确启动新 APP 过程中使用的是什么方法再继续
        - 包含 `sendMessage(message.setCallback(...))` 的调用

  ----
  
  - 注意力来到 ActivityStack 了
  - 能监控的启动调用流程中没有找到 ActivityStack 相关的可以联想的内容 , 暂时还是考虑 Handler 通信吧
  - ActivityStack$ActivityStackHandler 这个类重点观察下相关内容
    - Handler 可能是突破口 , 只是我们丢失了另一个接口 , 暂时无法完成两个接口的对接
    - 可以暂时将启动动作放到流程图避免再次丢失
  - 有了实质性的进展现在需要搞清楚的点如下
    1. 尽可能理解进入创建进程代码之前的逻辑
      - 这有助于理解相同个的函数会有多次调用这个问题 , 正是这个多次调用的问题导致我们一直无法跟踪到重点代码
      - 关于 `RootActivityContainer.resumeFocusedStacksTopActivities` 被调用两次这件事需要继续跟进 , 
        这个是发现被调用两次的首个函数 , 尝试去探寻它的上层调用逻辑 , 明确调用两次的原因
      - 经过探查确认了进入 ActivityTaskManagerService 现在应该关注两个路径
        - `ActivityTaskManagerService$startActivty` > 此调度入口可以探寻
        - `ActivityTaskManagerService$activityPaused` > 此调度入口暂时未知
        - 所以我们大概需要回到 Launcher 进程重新观察一下了 > 做过了没有特殊的收获
      - 虽然我们还不知道 `ActivityTaskManagerService$activityPaused` 的调度入口, 但仍然可以跟进下这个流程
        - 如果只在这个入口打断点 , 会发现在断点阻断之前 , 新应用进程已经启动完成了 , 所以这里不是启动流程的关键点
        - 把这个调用流视作干扰信息 , 是不行的,  应该以这里为起点做断点或者日志调试, 做更多的观察和收集 ,
          从而判断这个调用到底是否重要的调用
        - 也可以对比下两个启动流的参数差异
        - 现在应该考虑一下两个 ActivityStack 的调度流程了
    
    ----

    DONE - 下一步是需要辨析 ClientLifecycleManager 对象中的函数调用差异以及在客户端进程中的细节差异
    下一步重新编译 framework 
        - 循环节点已经完成插桩
        - 记得先解决可能发生的异常再编译 , 预计使用部分编译动作




    2. 搞清楚创建新进程的动作细节是怎样一步一步进行操作的
      - 搞清楚这一点再考虑如何在新进程创建新的 Activity 
      - 单凭断点优点容易误判 , 我们需要日志系统重新编译
        - 日志调用
        - 编译文件输出到指定位置
        - 部分编译



6. AOSP 中如何获取当前进程信息 , 进程名
  - 定制一个精简的日志工具 , 帮助更快更精准的代码定位
  - 进程和 沙盒 / 虚拟机 相关 > 尝试理解这一部分内容



#### 2.2.2. onPause 多次调用验证
```
┌────────────────────────────────────────────────────────────────────────────────────────────────────────────────
│ Thread: Binder:1819_11
├┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄
│ Binder.execTransact  (Binder.java:994)
│    Binder.execTransactInternal  (Binder.java:1021)
│       IActivityTaskManager$Stub.onTransact  (IActivityTaskManager.java:1981)
│          ActivityTaskManagerService.activityPaused  (ActivityTaskManagerService.java:1714)
│             ActivityStack.activityPausedLocked  (ActivityStack.java:1769)
│                ActivityStack.completePauseLocked  (ActivityStack.java:1842)
│                   RootActivityContainer.resumeFocusedStacksTopActivities  (RootActivityContainer.java:1161)
│                      ActivityStack.resumeTopActivityUncheckedLocked  (ActivityStack.java:2577)
│                         ActivityStack.resumeTopActivityInnerLocked  (ActivityStack.java:3039)
│                            ActivityStackSupervisor.startSpecificActivityLocked  (ActivityStackSupervisor.java:1007)
├┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄
│ ActivityStackSupervisor.startSpecificActivityLocked
└────────────────────────────────────────────────────────────────────────────────────────────────────────────────

┌────────────────────────────────────────────────────────────────────────────────────────────────────────────────
│ Thread: Binder:1819_11
├┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄
│ Binder.execTransact  (Binder.java:994)
│    Binder.execTransactInternal  (Binder.java:1021)
│       IActivityTaskManager$Stub.onTransact  (IActivityTaskManager.java:1981)
│          ActivityTaskManagerService.activityPaused  (ActivityTaskManagerService.java:1714)
│             ActivityStack.activityPausedLocked  (ActivityStack.java:1769)
│                ActivityStack.completePauseLocked  (ActivityStack.java:1882)
│                   RootActivityContainer.ensureActivitiesVisible  (RootActivityContainer.java:810)
│                      RootActivityContainer.ensureActivitiesVisible  (RootActivityContainer.java:823)
│                         ActivityDisplay.ensureActivitiesVisible  (ActivityDisplay.java:1315)
│                            ActivityStack.ensureActivitiesVisibleLocked  (ActivityStack.java:2184)
│                               ActivityStack.makeVisibleAndRestartIfNeeded  (ActivityStack.java:2389)
│                                  ActivityStackSupervisor.startSpecificActivityLocked  (ActivityStackSupervisor.java:1007)
├┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄
│ ActivityStackSupervisor.startSpecificActivityLocked
└────────────────────────────────────────────────────────────────────────────────────────────────────────────────
```


### 2.3. 相关类小计

ActivityMetricsLogger
- 侦听活动启动，过渡，可见性更改和窗口绘制的回调，以确定应用程序启动时间和绘制延迟。 活动指标的真实来源，并提供有关Tron，logcat，事件日志和WaitResult的数据。

RootActivityContainer



## 0x03. 疑点问题



## 提醒

* 设计模式应该跟上了 , 不然会有不必要的阻碍
* 如果有必要记得重新编译 一个 模拟器

## 进度存档
1. AOSP 调试已经可用 , 下一步应该进行 Activity 启动流程的探究
  - 卡壳在 aidl 通信的位置了 , 我们搞清楚这个调用流程
2. aidl 通信例程 , 已经完成 , 已经理解 aidl 通信使用流程
  - 存疑, service 在宿主进程未启动的情况下, 无法被其他进程启动
3. `Luncher` 应用作为客户端通过 IPC 机制将新应用的启动信息传送到 `IActivityTaskManager` 服务端
  - 现在卡壳在 `IActivityTaskManager` 服务端代码的出处了
  - 下一步要搞清楚这个 `IActivityTaskManager` 是如何发挥作用的



## 参考 
```terminate
➜  generic_x86 emulator -help  
Android Emulator usage: emulator [options] [-qemu args]
  options:
    -list-avds                     list available AVDs
    -sysdir <dir>                  search for system disk images in <dir>
    -system <file>                 read initial system image from <file>
    -writable-system               make system image writable after 'adb remount'
    -datadir <dir>                 write user data into <dir>
    -kernel <file>                 use specific emulated kernel
    -ramdisk <file>                ramdisk image (default <system>/ramdisk.img
    -image <file>                  obsolete, use -system <file> instead
    -initdata <file>               same as '-init-data <file>'
    -data <file>                   data image (default <datadir>/userdata-qemu.img
    -partition-size <size>         system/data partition size in MBs
    -cache <file>                  cache partition image (default is temporary file)
    -cache-size <size>             cache partition size in MBs
    -no-cache                      disable the cache partition
    -nocache                       same as -no-cache
    -sdcard <file>                 SD card image (default <datadir>/sdcard.img
    -snapstorage <file>            file that contains all state snapshots (default <datadir>/snapshots.img)
    -no-snapstorage                do not mount a snapshot storage file (this disables all snapshot functionality)
    -snapshot <name>               name of snapshot within storage file for auto-start and auto-save (default 'default-boot')
    -no-snapshot                   perform a full boot and do not do not auto-save, but qemu vmload and vmsave operate on snapstorage
    -no-snapshot-save              do not auto-save to snapshot on exit: abandon changed state
    -no-snapshot-load              do not auto-start from snapshot: perform a full boot
    -snapshot-list                 show a list of available snapshots
    -no-snapshot-update-time       do not do try to correct snapshot time on restore
    -wipe-data                     reset the user data image (copy it from initdata)
    -avd <name>                    use a specific android virtual device
    -skindir <dir>                 search skins in <dir> (default <system>/skins)
    -skin <name>                   select a given skin
    -no-skin                       deprecated: create an AVD with no skin instead
    -noskin                        same as -no-skin
    -memory <size>                 physical RAM size in MBs
    -cores <number>                Set number of CPU cores to emulator
    -accel <mode>                  Configure emulation acceleration
    -no-accel                      Same as '-accel off'
    -ranchu                        Use new emulator backend instead of the classic one
    -engine <engine>               Select engine. auto|classic|qemu2
    -netspeed <speed>              maximum network download/upload speeds
    -netdelay <delay>              network latency emulation
    -netfast                       disable network shaping
    -code-profile <name>           enable code profiling
    -show-kernel                   display kernel messages
    -shell                         enable root shell on current terminal
    -no-jni                        disable JNI checks in the Dalvik runtime
    -nojni                         same as -no-jni
    -logcat <tags>                 enable logcat output with given tags
    -no-audio                      disable audio support
    -noaudio                       same as -no-audio
    -audio <backend>               use specific audio backend
    -radio <device>                redirect radio modem interface to character device
    -port <port>                   TCP port that will be used for the console
    -ports <consoleport>,<adbport> TCP ports used for the console and adb bridge
    -onion <image>                 use overlay PNG image over screen
    -onion-alpha <%age>            specify onion-skin translucency
    -onion-rotation 0|1|2|3        specify onion-skin rotation
    -dpi-device <dpi>              specify device's resolution in dpi (default 165)
    -scale <scale>                 scale emulator window (deprecated)
    -http-proxy <proxy>            make TCP connections through a HTTP/HTTPS proxy
    -timezone <timezone>           use this timezone instead of the host's default
    -dns-server <servers>          use this DNS server(s) in the emulated system
    -cpu-delay <cpudelay>          throttle CPU emulation
    -no-boot-anim                  disable animation for faster boot
    -no-window                     disable graphical window display
    -version                       display emulator version number
    -report-console <socket>       report console port to remote socket
    -gps <device>                  redirect NMEA GPS to character device
    -shell-serial <device>         specific character device for root shell
    -tcpdump <file>                capture network packets to file
    -bootchart <timeout>           enable bootcharting
    -charmap <file>                use specific key character map
    -prop <name>=<value>           set system property on boot
    -shared-net-id <number>        join the shared network, using IP address 10.1.2.<number>
    -nand-limits <nlimits>         enforce NAND/Flash read/write thresholds
    -gpu <mode>                    set hardware OpenGLES emulation mode
    -camera-back <mode>            set emulation mode for a camera facing back
    -camera-front <mode>           set emulation mode for a camera facing front
    -webcam-list                   lists web cameras available for emulation
    -screen <mode>                 set emulated screen mode
    -force-32bit                   always use 32-bit emulator
    -selinux <disabled|permissive> Set SELinux to either disabled or permissive mode
    -unix-pipe <path>              Add <path> to the list of allowed Unix pipes
    -fixed-scale                   Use fixed 1:1 scale for the initial emulator window.
    -wait-for-debugger             Pause on launch and wait for a debugger process to attach before resuming
    -skip-adb-auth                 Skip adb authentication dialogue

     -qemu args...                 pass arguments to qemu
     -qemu -h                      display qemu help

     -verbose                      same as '-debug-init'
     -debug <tags>                 enable/disable debug messages
     -debug-<tag>                  enable specific debug messages
     -debug-no-<tag>               disable specific debug messages

     -help                         print this help
     -help-<option>                print option-specific help

     -help-disk-images             about disk images
     -help-debug-tags              debug tags for -debug <tags>
     -help-char-devices            character <device> specification
     -help-environment             environment variables
     -help-virtual-device          virtual device management
     -help-sdk-images              about disk images when using the SDK
     -help-build-images            about disk images when building Android
     -help-all                     prints all help content
```

- [](https://juejin.im/post/6844904145191698439)