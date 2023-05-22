
## 0x00、 Zygote 和 System 进程的启动过程

init 进程 > Zygote > System
- init 进程为 Linux 系统所启动的第一个进程

## 0x01、 Zygote进程的启动脚本
```cmd
service zygote /system/bin/app_process -Xzygote /system/bin --zygote --start-system-server
    class main
    socket zygote stream 660 root system
    onrestart write /sys/android_power/request_state wake
    onrestart write /sys/power/state on
    onrestart restart media
    onrestart restart netd
```
### 在 init 进程中

init 进程通过阅读 .rc 脚本文件的方式完成动作
- Zygote 进程就是它按照 .rc 脚本文件的意图启动的。

1. 找到 `system/core/init.rc` 这个脚本文件。
    - 并参阅 `AOSP/system/core/init/readme.txt` 文件中的 android init language 说明能大致了解脚本文件的意义。
2. init 进程在启动时会调用 service_start 函数来启动 zygote 进程。

在 init 进程中 fork 了一个新进程，即为 zygote 进程。

### 在 zygote 进程中 执行 `/system/bin/app_process`
在 zygote 程中创建了 /dev/socket/zygote 文件，将这个文件路劲和 ANDROID_SOCKET_zyogte 作为 key:value (路径为 value) 加入环境变量中。

### 在 System 进程的启动过程中




![2018-10-16_Android_源代码阅读_流程图_Zygote进程启动流程及细节_Viso_.png](/assets/Image/2018-10-16_Android_源代码阅读_流程图_Zygote进程启动流程及细节_Viso_.png)


## Reference
- Android系统源代码情景分析(罗升阳)