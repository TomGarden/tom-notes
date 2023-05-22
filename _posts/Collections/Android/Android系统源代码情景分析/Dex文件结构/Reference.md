## 官方
1. [Dalvik 可执行文件格式](https://source.android.com/devices/tech/dalvik/dex-format)

## 民间
1. [Android Dex文件格式解析 ](https://blog.csdn.net/qq1084283172/article/details/53584495)
2. [Android中的Apk的加固(加壳)原理解析和实现 ](https://blog.csdn.net/jiangwei0910410003/article/details/48415225)
3. [【精】图解Dex文件结构及解析要点](https://blog.csdn.net/beyond702/article/details/52460721)
4. [通过dexdump来学习DEX文件格式](https://blog.csdn.net/doon/article/details/51691627)




## 工具
1-dexdump
- E:\dev_kit\android_sdk\build-tools\xxx\dexdump.exe

```
tom@DESKTOP-P2EBEQB MINGW64 /e/dev_kit/android_sdk/build-tools/27.0.3
$ ./dexdump.exe
dexdump: no file specified
Copyright (C) 2007 The Android Open Source Project

dexdump: [-c] [-d] [-f] [-h] [-i] [-l layout] [-m] [-t tempfile] dexfile...

 -c : verify checksum and exit
 -d : disassemble code sections ---- 
 -f : display summary information from file header
 -h : display file header details
 -i : ignore checksum failures
 -l : output layout, either 'plain' or 'xml'
 -m : dump register maps (and nothing else)
 -t : temp file name (defaults to /sdcard/dex-temp-*)

```


AOSP路径： **I:\AOSP\android-4.4.4_r1\dalvik\vm\DvmDex.h**