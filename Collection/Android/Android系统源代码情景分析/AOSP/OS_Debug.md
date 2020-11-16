1. AOSP Download
2. AOSP Build
3. AOSP Read
4. AOSP Debug

## 关于 AOSP Debug Java

在探索某一部分的细节逻辑的时候总是会需要查看源码的细节实现 , 查看当然好 , 但是能断点调试就更加棒了. 

调试 Aosp 的方式有多种 , 这里我们只记录整个 AOSP 下载并调试的一点细节

1. File -> Project Structure -> Project : 将 Android SDK 设置为和源码版本一致
    - apply , OK

2. Run -> Attach Debugger to Android Process -> show all process : system_process 
    - 直接快捷图标按钮也一样哈
    
3. 启动一个和 AOSP 版本相同的 模拟器 (我想编译出来的那个 img 应该是最恰当的吧 , 
   但是我自己用的 AndroidStudio 之前下载的大版本相同的 ,  图个方便 , 后续不满足需求再重编)

*. 测试: 在 `ActivityStarter.java` 类文件中 `startActivityMayWait` 函数多打几个断点 , 
   随便一个启动 新 Activity 的动作都会击中断点

## 参考
1. [:Android AOSP基础（五）Android Studio调试系统源码的三种方式](http://liuwangshu.cn/framework/aosp/5-debug-aosp.html)
    - [__原文打不开了__这是网页快照](http://webcache.googleusercontent.com/search?q=cache:HWlxA7Wa76UJ:liuwangshu.cn/framework/aosp/5-debug-aosp.html+&cd=1&hl=en&ct=clnk&gl=us)