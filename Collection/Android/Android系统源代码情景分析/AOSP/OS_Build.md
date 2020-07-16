
个人步骤
0. 设置最大打开的文件描述符的数量(`.tom_shell_profile`) : `ulimit -S -n 2048 `
1. 使用 envsetup.sh 脚本初始化环境：`source build/envsetup.sh`
2. 设置 Java 堆大小 : `export _JAVA_OPTIONS="-Xmx6g"`
3. 选择构建目标: `lunch aosp_arm-eng`
4. 开始构建 : `m`

注意事项:
日志输出到指定文件 , 避免命令行应用异常的时候日志无法有效观察





# 0x01. 低配 硬件 遇到的问题们:

## 1.1. Mac OS 编译从失败升级
- 放弃了这款 硬件设备
    - MacBook Pro (13-inch, 2017, Two Thunderbolt 3 ports)
    - i5 8G
    - 多次失败 
        - 内存不足 (Exception in thread "main" java.lang.OutOfMemoryError: Java heap space) 尝试增加内存无果

- 新设备
    - Catalina 10.15.5 (19F101)
    - MacBook Pro (15-inch, 2017) 


## 1.2. Ubuntu 16.04 下载同步编译 一气呵成


## 1.3. 查看可以 lunch 的版本 
```
# 执行 lunch 不加参数即可
lunch
```


## 1.4. 编译失败会需要清除历史编译文件的动作才好开始重新开始编译
`m clean`

## 1.5. Linxu 读取 mac 分区
```
#关闭Journal
$ diskutil disableJournal disk0s2
Journaling has been disabled on disk0s2
 
#打开Journal  
$ diskutil enableJournal disk0s2
Journaling has been enabled on disk0s2
```

## 1.6. 再次确认 mac 是否无法编译 AOSP
先指定 Android 版本 再编译

## 1.7. too many open files soong bootstrap failed with: exit status 1

在 macOS 中，可同时打开的文件描述符的默认数量上限太低，在高度并行的构建流程中，可能会超出此上限。如需提高此上限，请将下列行添加到 ~/.bash_profile 中：

```
//如果按照官方的建议设置了 1024 还是提示这个错误 , 可以尝试 2048
set the number of open files to be 1024
ulimit -S -n 1024 
```

## 1.8. Exception in thread "main" java.lang.OutOfMemoryError: Java heap space

调整 Java 的对大小设置 `export _JAVA_OPTIONS="-Xmx6g"`
 
参考:https://stackoverflow.com/questions/60468693/java-outofmemoryerror-when-building-aosp-10


## 1.9. Linux [编译成功虚拟机失败](https://groups.google.com/forum/#!topic/android-building/hEJumMIhkq8)








# 0x02. 标配 硬件 列表
- MacBook Pro (15-inch, 2017) 
- Catalina 10.15.5 (19F101)
- 2.9 GHz 四核Intel Core i7
- 16 GB 2133 MHz LPDDR3
- 移动硬盘

```
//换硬件果然好使
#### build completed successfully (04:18:51 (hh:mm:ss)) ####
```

## 2.1. [Catalina 编译android 10报错](https://blog.csdn.net/qq_25333681/article/details/105148190)

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