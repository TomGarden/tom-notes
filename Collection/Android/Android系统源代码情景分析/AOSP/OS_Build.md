

## 0x01. 资源情况
- MAC OS 10.15
- i7
- 16G 闪存
- 500G 硬盘(凑活够用) > 1T 更合适

## 0x02. 命令使用情况

### 2.1. 查看可以 lunch 的版本 
```
# 执行 lunch 不加参数即可
lunch
```

### 2.2. 编译失败会需要清除历史编译文件的动作才好开始重新开始编译
`m clean`

### 2.3. 整体编译
0. 设置最大打开的文件描述符的数量(`.tom_shell_profile`) : `ulimit -S -n 2048 `
1. 使用 envsetup.sh 脚本初始化环境：`source build/envsetup.sh`
3. 选择构建目标: `lunch aosp_x86-eng`
4. 开始构建 : `m`

注意事项:
1.  日志输出到指定文件 , 避免命令行应用异常的时候日志无法有效观察
2.  剩余存储空间在 60G 上下的时候是无法完成编译的 , 会因为内存不足而失败 ; 
    整体编译除了源码本身外还需要磁盘空间数为 : 83.73 G 的时候编译成功, 成功后剩余 20 G 空间;
    用时在 4h 以内
3.  如果先做了整体编译 , 然后做了部分代码的细节修改 , 再做整体编译
    我是对 framework 层代码做了小修小改 , 用时基本在 40min 内


### 2.4. 修改 Framework 层的部分代码, 部分编译


### 2.5. [修改 framework 层的文件夹代码](https://medium.com/@budhdisharma/aosp-build-system-767deeb535fa)

#### 2.5.1. 没有导致异常的修改和部分重新编译 : 对已有 api 的简单调用

下文 adb 命令的执行状态和 emulator 的执行状态一样 , 都是先执行过了如下命令:
```
source build/envsetup.sh
lunch
```

修改过的文件的路径 `frameworks/base/services/core/java/com/android/server/wm`
- 主要是在某些文件中添加了 `android.util.Log` 的调用

0. 执行编译 **成功**
    ```
    # 1. 这个路径没有太明确的判断是试出来的逐层试, 并观察
    # 2. 太深的路径会导致修改没有被应用,这个原因暂不深究 . 
    #    失败的测试路径 : cd frameworks/base/services/core/java/com/android/server/wm
    # 3. 随着修改的文件的越来越多 , 这个路径要随之变化
    # 4. 如果有必要使用 `mm java` 会大大提高编译速度
    #     但是携带 java 命令常常导致编译失败 , 失败了删除它再试一次或需能成功
    cd frameworks/base/services
    mm java
    ```

编译完成将新的编译产物应用到模拟器上

1. [将模拟器置于启动状态](https://issuetracker.google.com/issues/144891973#comment4)
    ```terminate
    # -writable-system 如果没有这个命令 adb remount 可能会失败
    $ emulator -writable-system
    ```

2. 执行同步操作动作前, 需要先获取模拟器文件系统的操作权限
    ```terminate
    adb root
    adb disable-verity # https://source.android.com/security/verifiedboot/dm-verity
                       # 启动时验证会尽力确保所有已执行代码均来自可信来源 , 此命令为关闭此验证动作
    adb reboot
    adb root
    adb remount
    ```

3. 执行文件同步动作
    ```
    $ adb sync // Sync the updated module to the device
    $ adb shell stop // Stopping the shell
    $ adb shell start // Starting the shell again
    ```

4. 然后可以验证自己想修改是否生效了 , **我生效了**


#### 2.5.2. 出现异常的代码修改 : 添加类文件

我们希望查看某一个函数相关的调用栈 , `android.util.Log` 需要大量的编码, 而且不是很直观
- 把应用层开发中常用的日志工具 Logger 做一个剪裁 , 放到 `frameworks/base/core/java/android/util/tom_logger`
- [Logger 剪裁版本](https://github.com/TomGarden/lib_log/tree/master/LibLiteLog)

##### 异常一:

对文件的修改情况
1. `framework/base/service` 中的某些文件调用了 `Log` / `TomLogger`
2. `framework/base/core/java` 中添加了 `tom_logger/TomLogger` 相关日志工具类文件

编译情况
1. 只编译了 `framework/base/service` 没有编译 `framework/base/core/java`

异常情况
1. 模拟器已经无法正常启动了(由于异常进入了死循环) .


##### 异常二:

在`异常一`的基础上增加对 `framework/base/core/java` 涉及文件的编译动作
```
$ cd frameworks/base/core
$ mm java # 由于我们只修改了 java 代码, 此命令应该可以降低编译成本
```
1. 这个编译动作始终失败, 并且没有给出异常后的操作建议
2. 还有一个存疑的问题暂不深究: 当模拟器已经处于异常的死循环状态时候 , 
   我们通过某些操作将新的修正成功编译了应该如何将新编译的结果应用到模拟器上?
   下面就是我们围绕这个问题保留的参考内容
    - https://www.google.com/search?q=AOSP+%E6%8F%92%E5%85%A5%E8%87%AA%E5%B7%B1%E7%9A%84%E7%B1%BB+%E7%BC%96%E8%AF%91%E5%AE%8C%E6%88%90%E5%90%8E+NoClassDefFoundError&oq=AOSP+%E6%8F%92%E5%85%A5%E8%87%AA%E5%B7%B1%E7%9A%84%E7%B1%BB+%E7%BC%96%E8%AF%91%E5%AE%8C%E6%88%90%E5%90%8E+NoClassDefFoundError&aqs=chrome..69i57.10064j0j7&sourceid=chrome&ie=UTF-8
        - https://www.cnblogs.com/caoxinyu/p/10568479.html
    - https://www.google.com/search?newwindow=1&sxsrf=ALeKk03cNAxwfSsZbBAJ6N9ChWht08Tnjw%3A1600310653623&ei=fc1iX_vSJYP_wAPXnZrwBQ&q=Android+%E7%B3%BB%E7%BB%9F%E5%BC%80%E5%8F%91&oq=Android+%E7%B3%BB%E7%BB%9F%E5%BC%80%E5%8F%91&gs_lcp=CgZwc3ktYWIQAzIECAAQDDICCAAyBAgAEB46BAgjECc6CgguEMcBEKMCECc6BAgAEEM6BQgAEJECOggIABCxAxCDAToFCAAQsQM6CAguELEDEIMBOgcIABCxAxBDOgcIIxDqAhAnOg0ILhDHARCjAhDqAhAnOgsILhCxAxDHARCjAjoFCAAQywE6BAgAEA06BggAEAQQHlCDG1i1QmDzUGgHcAB4AoAB6QWIAYs6kgEMMi0xNC41LjEuMi4xmAEAoAEBqgEHZ3dzLXdperABCsABAQ&sclient=psy-ab&ved=0ahUKEwi7hajgle_rAhWDP3AKHdeOBl4Q4dUDCA0&uact=5
        - https://my.oschina.net/u/4260482/blog/3626334
   

##### 异常解决 : 异常原因和涉及原理暂不深究

重新全量编译 , 得到有意义的异常帮助信息 , 并解决了问题(新添加的代码运行正常, 调用栈清晰)
```
$ cd aosp
$ m clean
$ m


FAILED: out/soong/.intermediates/frameworks/base/api-stubs-docs/android_common/check_current_api.timestamp

error: Added package android.util.tom_logger [AddedPackage]
Aborting: Found compatibility problems checking the public API against the API in /Volumes/beyourself/AOSP/aosp/frameworks/base/api/current.txt
-e
******************************
You have tried to change the API from what has been previously approved.

To make these errors go away, you have two choices:
   1. You can add '@hide' javadoc comments to the methods, etc. listed in the
      errors above.

   2. You can update current.txt by executing the following command:
         make api-stubs-docs-update-current-api

      To submit the revised current.txt to the main Android repository,
      you will need approval.
******************************

$ make api-stubs-docs-update-current-api
#### build completed successfully (01:55 (mm:ss)) ####

$ m
#### build completed successfully (14:09 (mm:ss)) ####
```

#### 2.5.3. 部分参考和相关疑问
- [关于部分编译一个比较明晰的指引](https://medium.com/@budhdisharma/aosp-build-system-767deeb535fa)
    - **这个文章的作者是从什么地方了解到这些内容的?**
        - **解释了编译部分代码的问题来源**:后来我发现角码文件中自有乾坤 : `cat build/envsetup.sh`
        - [官方指导文章也是希望我们从此文件中获得详细信息](https://source.android.com/setup/build/building)
        - 或者执行命令 : `hmm`
    - 所谓 Module 是如何划分的 , 从而可以知道在那里执行刚学到的命令
        - https://stackoverflow.com/questions/13139394/building-a-particular-module-in-the-android-source-code
        - 
    - 从 adb 命令提醒看 AOSP 模块都有什么
        - [all|data|odm|oem|product_services|product|system|vendor]

- 2.5.2 小节中出现的关于 `aosp/frameworks/base/api/current.txt` 的细节问题暂不深究
    

**进度小计**

当前进度 : 在 `/Volumes/beyourself/AOSP/aosp/frameworks/base/core/java` 
执行 `mm java` 会在 30 min 后编译失败,  跟进这个异常 :
- 我们要解决这个问题是因为 Log 无法满足我们的需要 , 我们希望在 framework 增加自己的日志工具
- 我们希望通过日志工具了解 Activity 的启动流程中多次调用关键函数的细节
- 我们在了解 Activity 启动过程中碰到一点疑问, 希望做进一步探究
- 我们在了解 Activity 的启动过程
- 我们希望了解 Activity 横竖屏切换过程中发生了什么
- Dialog 位于 Fragment , Fragment 位于  Activity . 
  我们希望在 Activity 切换横竖屏的过程中能按照我们的意图保存状态



### 2.*. `m help`
```terminate
# mm help 和下面的内容也一样
➜  aosp m help
The basic Android build process is:

cd /Volumes/beyourself/AOSP/aosp
source build/envsetup.sh    # Add "lunch" (and other utilities and variables)
                            # to the shell environment.
lunch [<product>-<variant>] # Choose the device to target.
m -j [<goals>]              # Execute the configured build.

Usage of "m" imitates usage of the program "make".
See /Volumes/beyourself/AOSP/aosp/build/make/Usage.txt for more info about build usage and concepts.

Common goals are:

    clean                   (aka clobber) equivalent to rm -rf out/
                            清除编译动作所产生的所有文件
    checkbuild              Build every module defined in the source tree
    droid                   Default target
    nothing                 Do not build anything, just parse and validate the build structure

    java                    Build all the java code in the source tree
    native                  Build all the native code in the source tree

    host                    Build all the host code (not to be run on a device) in the source tree
    target                  Build all the target code (to be run on the device) in the source tree

    (java|native)-(host|target)
    (host|target)-(java|native)
                            Build the intersection of the two given arguments

    # 下面几个字段的含义暂不能明晰呢

    snod                    Quickly rebuild the system image from built packages
                            Stands for "System, NO Dependencies"
    vnod                    Quickly rebuild the vendor image from built packages
                            Stands for "Vendor, NO Dependencies"
    pnod                    Quickly rebuild the product image from built packages
                            Stands for "Product, NO Dependencies"
    psnod                   Quickly rebuild the product_services image from built packages
                            Stands for "ProductServices, NO Dependencies"
    onod                    Quickly rebuild the odm image from built packages
                            Stands for "ODM, NO Dependencies"


So, for example, you could run:

cd /Volumes/beyourself/AOSP/aosp
source build/envsetup.sh
lunch aosp_arm-userdebug
m -j java

to build all of the java code for the userdebug variant of the aosp_arm device.


#### build completed successfully (1 seconds) ####
```


## 0x03. 异常状况

### 3.1. 不同格式的硬盘分区读取

**Linxu 读取 mac 分区**
```
#关闭Journal
$ diskutil disableJournal disk0s2
Journaling has been disabled on disk0s2
 
#打开Journal  
$ diskutil enableJournal disk0s2
Journaling has been enabled on disk0s2
```

[**mac 读取 linux 分区**](https://www.paragon-software.com/home/extfs-mac/)

### 3.2. 如果有有需要调整最大打开文件数

- 异常信息  :  `too many open files soong bootstrap failed with: exit status 1`

在 macOS 中，可同时打开的文件描述符的默认数量上限太低，在高度并行的构建流程中，可能会超出此上限。如需提高此上限，请将下列行添加到 ~/.bash_profile 中：

```
//如果按照官方的建议设置了 1024 还是提示这个错误 , 可以尝试 2048
set the number of open files to be 1024
ulimit -S -n 1024 
```

### 3.3. Exception in thread "main" java.lang.OutOfMemoryError: Java heap space

调整 Java 的对大小设置 `export _JAVA_OPTIONS="-Xmx6g"`
 
参考:https://stackoverflow.com/questions/60468693/java-outofmemoryerror-when-building-aosp-10


### 3.4. Linux [编译成功虚拟机失败]
- https://groups.google.com/forum/#!topic/android-building/hEJumMIhkq8


### 3.5. [Catalina 编译android 10报错](https://blog.csdn.net/qq_25333681/article/details/105148190)

```terminate

➜  aosp m
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
FAILED: out/target/product/generic_x86/obj/ETC/treble_sepolicy_tests_28.0_intermediates/treble_sepolicy_tests_28.0
/bin/bash -c "(out/host/darwin-x86/bin/treble_sepolicy_tests -l 		out/host/darwin-x86/lib64/libsepolwrap.dylib  -f out/target/product/generic_x86/obj/ETC/plat_file_contexts_intermediates/plat_file_contexts  -f out/target/product/generic_x86/obj/ETC/vendor_file_contexts_intermediates/vendor_file_contexts 		-b out/target/product/generic_x86/obj/ETC/built_plat_sepolicy_intermediates/built_plat_sepolicy -m out/target/product/generic_x86/obj/ETC/treble_sepolicy_tests_28.0_intermediates/28.0_mapping.combined.cil 		-o out/target/product/generic_x86/obj/ETC/treble_sepolicy_tests_28.0_intermediates/built_28.0_plat_sepolicy -p out/target/product/generic_x86/obj/ETC/sepolicy_intermediates/sepolicy 		-u out/target/product/generic_x86/obj/ETC/built_plat_sepolicy_intermediates/base_plat_pub_policy.cil 		--fake-treble ) && (touch out/target/product/generic_x86/obj/ETC/treble_sepolicy_tests_28.0_intermediates/treble_sepolicy_tests_28.0 )"
/bin/bash: line 1: 21672 Segmentation fault: 11  ( out/host/darwin-x86/bin/treble_sepolicy_tests -l out/host/darwin-x86/lib64/libsepolwrap.dylib -f out/target/product/generic_x86/obj/ETC/plat_file_contexts_intermediates/plat_file_contexts -f out/target/product/generic_x86/obj/ETC/vendor_file_contexts_intermediates/vendor_file_contexts -b out/target/product/generic_x86/obj/ETC/built_plat_sepolicy_intermediates/built_plat_sepolicy -m out/target/product/generic_x86/obj/ETC/treble_sepolicy_tests_28.0_intermediates/28.0_mapping.combined.cil -o out/target/product/generic_x86/obj/ETC/treble_sepolicy_tests_28.0_intermediates/built_28.0_plat_sepolicy -p out/target/product/generic_x86/obj/ETC/sepolicy_intermediates/sepolicy -u out/target/product/generic_x86/obj/ETC/built_plat_sepolicy_intermediates/base_plat_pub_policy.cil --fake-treble )
[ 78% 63452/80802] build out/target/product/generic_x86/obj/ETC/sepolicy_tests_intermediates/sepolicy_tests
FAILED: out/target/product/generic_x86/obj/ETC/sepolicy_tests_intermediates/sepolicy_tests
/bin/bash -c "(out/host/darwin-x86/bin/sepolicy_tests -l out/host/darwin-x86/lib64/libsepolwrap.dylib 		 -f out/target/product/generic_x86/obj/ETC/plat_file_contexts_intermediates/plat_file_contexts  -f out/target/product/generic_x86/obj/ETC/vendor_file_contexts_intermediates/vendor_file_contexts  -p out/target/product/generic_x86/obj/ETC/sepolicy_intermediates/sepolicy ) && (touch out/target/product/generic_x86/obj/ETC/sepolicy_tests_intermediates/sepolicy_tests )"
/bin/bash: line 1: 21667 Segmentation fault: 11  ( out/host/darwin-x86/bin/sepolicy_tests -l out/host/darwin-x86/lib64/libsepolwrap.dylib -f out/target/product/generic_x86/obj/ETC/plat_file_contexts_intermediates/plat_file_contexts -f out/target/product/generic_x86/obj/ETC/vendor_file_contexts_intermediates/vendor_file_contexts -p out/target/product/generic_x86/obj/ETC/sepolicy_intermediates/sepolicy )
[ 78% 63453/80802] build out/target/product/generic_x86/obj/ETC/treble_sepolicy_tests_26.0_intermediates/treble_sepolicy_tests_26.0
FAILED: out/target/product/generic_x86/obj/ETC/treble_sepolicy_tests_26.0_intermediates/treble_sepolicy_tests_26.0
/bin/bash -c "(out/host/darwin-x86/bin/treble_sepolicy_tests -l 		out/host/darwin-x86/lib64/libsepolwrap.dylib  -f out/target/product/generic_x86/obj/ETC/plat_file_contexts_intermediates/plat_file_contexts  -f out/target/product/generic_x86/obj/ETC/vendor_file_contexts_intermediates/vendor_file_contexts 		-b out/target/product/generic_x86/obj/ETC/built_plat_sepolicy_intermediates/built_plat_sepolicy -m out/target/product/generic_x86/obj/ETC/treble_sepolicy_tests_26.0_intermediates/26.0_mapping.combined.cil 		-o out/target/product/generic_x86/obj/ETC/treble_sepolicy_tests_26.0_intermediates/built_26.0_plat_sepolicy -p out/target/product/generic_x86/obj/ETC/sepolicy_intermediates/sepolicy 		-u out/target/product/generic_x86/obj/ETC/built_plat_sepolicy_intermediates/base_plat_pub_policy.cil 		--fake-treble ) && (touch out/target/product/generic_x86/obj/ETC/treble_sepolicy_tests_26.0_intermediates/treble_sepolicy_tests_26.0 )"
/bin/bash: line 1: 21668 Segmentation fault: 11  ( out/host/darwin-x86/bin/treble_sepolicy_tests -l out/host/darwin-x86/lib64/libsepolwrap.dylib -f out/target/product/generic_x86/obj/ETC/plat_file_contexts_intermediates/plat_file_contexts -f out/target/product/generic_x86/obj/ETC/vendor_file_contexts_intermediates/vendor_file_contexts -b out/target/product/generic_x86/obj/ETC/built_plat_sepolicy_intermediates/built_plat_sepolicy -m out/target/product/generic_x86/obj/ETC/treble_sepolicy_tests_26.0_intermediates/26.0_mapping.combined.cil -o out/target/product/generic_x86/obj/ETC/treble_sepolicy_tests_26.0_intermediates/built_26.0_plat_sepolicy -p out/target/product/generic_x86/obj/ETC/sepolicy_intermediates/sepolicy -u out/target/product/generic_x86/obj/ETC/built_plat_sepolicy_intermediates/base_plat_pub_policy.cil --fake-treble )
[ 78% 63454/80802] build out/target/product/generic_x86/obj/ETC/treble_sepolicy_tests_27.0_intermediates/treble_sepolicy_tests_27.0
FAILED: out/target/product/generic_x86/obj/ETC/treble_sepolicy_tests_27.0_intermediates/treble_sepolicy_tests_27.0
/bin/bash -c "(out/host/darwin-x86/bin/treble_sepolicy_tests -l 		out/host/darwin-x86/lib64/libsepolwrap.dylib  -f out/target/product/generic_x86/obj/ETC/plat_file_contexts_intermediates/plat_file_contexts  -f out/target/product/generic_x86/obj/ETC/vendor_file_contexts_intermediates/vendor_file_contexts 		-b out/target/product/generic_x86/obj/ETC/built_plat_sepolicy_intermediates/built_plat_sepolicy -m out/target/product/generic_x86/obj/ETC/treble_sepolicy_tests_27.0_intermediates/27.0_mapping.combined.cil 		-o out/target/product/generic_x86/obj/ETC/treble_sepolicy_tests_27.0_intermediates/built_27.0_plat_sepolicy -p out/target/product/generic_x86/obj/ETC/sepolicy_intermediates/sepolicy 		-u out/target/product/generic_x86/obj/ETC/built_plat_sepolicy_intermediates/base_plat_pub_policy.cil 		--fake-treble ) && (touch out/target/product/generic_x86/obj/ETC/treble_sepolicy_tests_27.0_intermediates/treble_sepolicy_tests_27.0 )"
/bin/bash: line 1: 21670 Segmentation fault: 11  ( out/host/darwin-x86/bin/treble_sepolicy_tests -l out/host/darwin-x86/lib64/libsepolwrap.dylib -f out/target/product/generic_x86/obj/ETC/plat_file_contexts_intermediates/plat_file_contexts -f out/target/product/generic_x86/obj/ETC/vendor_file_contexts_intermediates/vendor_file_contexts -b out/target/product/generic_x86/obj/ETC/built_plat_sepolicy_intermediates/built_plat_sepolicy -m out/target/product/generic_x86/obj/ETC/treble_sepolicy_tests_27.0_intermediates/27.0_mapping.combined.cil -o out/target/product/generic_x86/obj/ETC/treble_sepolicy_tests_27.0_intermediates/built_27.0_plat_sepolicy -p out/target/product/generic_x86/obj/ETC/sepolicy_intermediates/sepolicy -u out/target/product/generic_x86/obj/ETC/built_plat_sepolicy_intermediates/base_plat_pub_policy.cil --fake-treble )
21:05:28 ninja failed with: exit status 1

#### failed to build some targets (02:10:52 (hh:mm:ss)) ####

```

问题的答案 
1. [Catalina编译android 10报错](https://blog.csdn.net/qq_25333681/article/details/105148190)
    - 只有问题解决方法 , 没有问题解决思路
    1. tom 手动补丁 网络引导 : https://android-review.googlesource.com/q/I31744acd018ea4c980c46a9979bbad17ae1c4f68
    2. tom 手动补丁 , 网络引导: https://android-review.googlesource.com/q/I1e2f4095795daead6eb96280d60a122c51ba66ba
2. [Macos catalina上android源码编译不过问题解决措施](https://blog.csdn.net/weixin_43625729/article/details/103749609?utm_medium=distribute.pc_relevant.none-task-blog-BlogCommendFromMachineLearnPai2-1.nonecase&depth_1-utm_source=distribute.pc_relevant.none-task-blog-BlogCommendFromMachineLearnPai2-1.nonecase)
    - 从这里了解到 [AOSP 问题讨论网站](https://android-review.googlesource.com/)
    - 从这里搜索关键字`Fix sepolicy_tests on Mac 10.15`即可找到这个[答案](https://android-review.googlesource.com/c/platform/system/sepolicy/+/1173528)
    - 现在能想到的困难就是 , 如果遇到新问题这个关键字选定和大量结果的阅读和识别也有点困难的
3. [BigSur 11.1 编译 Android10 报错] : 在上述问题的基础上添加 `11.1` 字段即可 , 但是还有其他未能逾越的异常

### 3.6. `adb sync` 执行失败
```terminate
# 执行失败
➜  aosp adb sync 
/Volumes/beyourself/AOSP/aosp/out/target/product/generic_x86/data/: 5 files pushed. 37.9 MB/s (1141778 bytes in 0.029s)
adb: error: failed to copy '/Volumes/beyourself/AOSP/aosp/out/target/product/generic_x86/system/framework/ipmemorystore-aidl-interfaces-V1-java.jar' to '/system/framework/ipmemorystore-aidl-interfaces-V1-java.jar': remote couldn't create file: Read-only file system

# 观察状况
➜  aosp adb root
adbd is already running as root

➜  aosp adb shell

generic_x86:/ # cd system/ 

eneric_x86:/system # ls -l

drwxr-xr-x  2 root root   4096 2020-09-14 02:09 framework

generic_x86:/system # whoami
root

# 说明即使是 root 用户也没有 framework 文件夹的写权限 , 虽然看起来是有的

# 关闭安全验证
adb disable-verity
# 重新启动
adb reboot
adb root

# 重新挂载文件系统失败
adb remount
```

1. [一个解决方案(暂未验证)](https://android.stackexchange.com/questions/162902/adb-push-not-working-on-system-read-only)
    - [还需要理解 `disable-verity` 的含义](https://source.android.com/security/verifiedboot/dm-verity)
2. [重新挂载文件系统失败](https://issuetracker.google.com/issues/144891973)
    - [重新挂载文件系统失败-StackOverFlow](https://stackoverflow.com/questions/60867956/android-emulator-sdk-10-api-29-wont-start-after-remount-and-reboot)
    - 解决方式 : 通过命令 `emulator -writable-system` 启动模拟器即可完成重新挂载点动作