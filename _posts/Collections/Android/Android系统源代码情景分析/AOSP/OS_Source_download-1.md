# 娱乐线路
1. 安装并维护 Ubuntu 。
    - JDK 安装
    - 依赖安装：
        - `sudo apt-get install flex bison gperf libsdl-dev libesd0-dev libwxgtk2.6-dev build-essential zip curl valgrind`
            - 提示无法找到 libwxgtk2.6-dev 所以我们先拿出它来。
            - [libwxgtk2.6-dev](https://launchpad.net/ubuntu/precise/amd64/libwxgtk2.6-dev/2.6.3.2.2-5ubuntu4)
                - 下载安装提示缺少更多的依赖，于是查看了下在 Ubuntu 16.04 中的 libwxgtk2.6-dev 已经升级到 libwxgtk3.0-dev
                    - 查询命令：`apt-cache search libwxgtk`
                - 所以我们暂时安装 3.0 版本吧(有问题再折回)。
        - 所以上述命令可以更改为
            - `sudo apt-get install flex bison gperf libsdl-dev libesd0-dev libwxgtk3.0-dev build-essential zip curl valgrind`
2. [下载 Android 源代码](https://source.android.com/)
    - 下载指定版本的 Android 源码
    - 我们下载的版本为 android-2.3.1-r1
3. 编译异常&修复
    - JDK 版本不对，应该使用 JDK 6
    - Checking build tools versions...
        ```
        ============================================
        PLATFORM_VERSION_CODENAME=REL
        PLATFORM_VERSION=2.3.1
        TARGET_PRODUCT=generic
        TARGET_BUILD_VARIANT=eng
        TARGET_SIMULATOR=
        TARGET_BUILD_TYPE=release
        TARGET_BUILD_APPS=
        TARGET_ARCH=arm
        HOST_ARCH=x86
        HOST_OS=linux
        HOST_BUILD_TYPE=release
        BUILD_ID=GRH78
        ============================================
        Checking build tools versions...
        build/core/prebuilt.mk:91: *** recipe commences before first target.  Stop.
        ```





## 参考 & 摘录
1. https://source.android.com/

## 已经下载过 AOSP 之后希望切换编译版本应该怎么做

__repo 命令__

切换某个版本的命令:
- `repo init -u https://mirrors.tuna.tsinghua.edu.cn/git/AOSP/platform/manifest -b android-10.0.0_r39`

其中 `android-4.0.1_r1` 即为我们即将切换的编译版本 , 这实际上是一个 AOSP 分支 , 那么如何查看我们可选分支有哪些呢?
1. 通过 [Google AOSP](https://source.android.com/setup/start/build-numbers#source-code-tags-and-builds) 查看
