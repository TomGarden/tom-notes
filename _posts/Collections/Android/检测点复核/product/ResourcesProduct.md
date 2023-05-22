# 资源文件保护
## 一、 我们知道
Android 项目中的所有文件：
- assets
- AndroidManifest.xml
- res(anim color drawable layout raw valus)
- *.java

apk 打包流程：
1. 打包资源文件：`assets 、 AndroidManifest.xml 、 res` 
    - 输入 : ApplicationResources
    - 输出 : R.java 和 未知
        - 此处的未知有3中可能
            1. 编译后的二进制 Resources 文件目录
            2. resources.arsc
            3. 上述二者都有
    - 工具 : aapt

2. 处理AIDL文件，生成对应的.java文件（当然，有很多工程没有用到AIDL，那这个过程就可以省了）
    - 输入 : *.aidl
    - 输出 : *.java
    - 工具 : aidl

3. 编译Java文件，生成对应的.class文件
    - 输入 : *.java (包含 R.java 、 aidl.java)
    - 输出 : *.class
    - 工具 : javac

4. .class ☞ .dev
    - 输入 : *.class
    - 输出 : *.dev
    - 工具 : dx

5. 打包生成未签名的.apk文件
    - 输入 : 打包后的资源文件、打包后类文件（.dex文件）、libs文件（包括.so文件，当然很多工程都没有这样的文件，如果你不使用C/C++开发的话）
    - 输出 : 未签名的.apk文件
    - 工具 : apkbuilder工具

6. 对未签名.apk文件进行签名
    - 输入 : 未签名的.apk文件    
    - 输出 : 签名的.apk文件
    - 工具 : jarsigner

已知的资源文件的保护方式是修改 aapt 的源码，在打包过程中对资源文件名字进行替换。
- 至于文件名替换之后如何完成文件调用的映射尚未可知，要了解需要自己做一次该操作。

文件名替换之后再做 apktool 的反编译会得到一个 unknow 文件夹，并且正常用来存放资源文件的目录中不存在资源文件。unknow 文件中的文件名是混淆字段。

在res目录下熟悉的layout、drawable、anim、menu等文件夹不见了，那他们去哪了呢？因为apktool工具把它们放到了unknown文件夹下了

## 二、 自动化检测
1. 因为并非每一个应用都有 `anim、menu` 等文件
    - 我们可以确定的是每一个应用都有 `layout` 文件夹。
2. 又因为混淆不替换文件扩展名。
3. 所以我们的检测手段如下
    - 反编译后的包中不存在 `layout` 文件夹，并且 `unknow` 目录中存在 `.xml` 文件，即认定该 `apk` 做过资源保护。

## 三、 写给自己
上述技术毕竟没有自实现过，还是有许多疑问，和未知。
- aapt 修改细节。
- aapt 工作的输出内容是什么(是否包含 资源文件 二进制目录)

## 参考 & 摘录
1. [[混淆]-美团Android资源混淆保护实践](https://tech.meituan.com/mt-android-resource-obfuscation.html)
2. [Android应用程序（APK）的编译打包过程](https://www.cnblogs.com/sjm19910902/p/6416022.html)
3. [如何在不影响原有aapt源码的情况下编译定制版aapt](http://blog.csdn.net/sbsujjbcy/article/details/51418336)