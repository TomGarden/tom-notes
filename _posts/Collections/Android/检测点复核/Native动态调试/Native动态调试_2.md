## 一、 在 IDA 安装目录下获取 android_server 命令文件
1. 文件位置：IDA安装目录`\dbgsrv\android_server`
2. 文件 push 到手机 '本次放在了 /data 目录下'
3. 设置该文件的执行权限

## 二、 确定断点位置
1. 首先我们确定需要调试的点。
    - 调试目标 so 确定
    - 目标 so 中的目标 函数
    - 从而确定函数的相对内存地址
2. 确定在应用中什么操作会调用到目标函数

### 2.1、定位调用的 SO
1. 检索 so 文件名
2. 检索加载 so api
  - System.loadLibrary [Ljava/lang/System;->loadLibrary(Ljava/lang/String;)V]
  - System.load        [Ljava/lang/System;->load(Ljava/lang/String;)V]

### 2.2、定位方法


## 三、开始调试
用 root 身份启动 android_server
```
C:\>adb forward tcp:23946 tcp:23946
C:\>adb shell su
root@hammerhead: # /data/android_server
IDA Android 32-bit remote debug server(ST) v1.19. Hex-Rays (c) 2004-2015
Listening on port #23946...
```    
启动 IDA (Go work on your own)
1. Debugger -> Attach -> Remote ARMLinux/Android debugger
    - Hostname : 127.0.0.1
    - Port : 23946
    - OK
    - 提示：Could not connect to 127.0.0.1: 由于目标计算机积极拒绝，无法连接。
        - 说明没有使用 adb forward
2. Choose process to attach to
    - Ctrl + F 输入 packageName
3. 断点断在了 libc.so  
    - 绿三角放过这个断点，否则应用无响应
4. 查找已经加载到内存的 so 文件
    - Ctrl + S
    - Ctrl + F 寻找到我们关心的 so 文件。
        - 如果没有找到意味着还没有加载进来。
    - xxxx.so B3982000 B39BE000 R . X D . byte 00 public CODE 32 00 00
        - 确定 X 列为 X 的行的 start(so 内存起始地址)
5.
