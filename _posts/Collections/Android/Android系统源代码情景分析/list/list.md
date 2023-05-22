对应的流程图在 `方法小计/调用栈/`

## 从 DexClassLoader 加载 DEX 来看 DEX 文件的处理过程。
DexClassLoader

## 从 application 的启动过程来看 DEX 的使用过程。
app_run

1. 我们要了解 [DexHunter](https://github.com/zyq8709/DexHunter) 的源码细节
2. 通过阅读其文档我们知道该项目做的事情是修改 Android 系统源码`The modification is mainly in "art/runtime/class_linker.cc" (ART) and "dalvik/vm/native/dalvik_system_DexFile.cpp" (DVM).`
3. 并将系统重新编译，让被加固的应用运行在修改后的系统，就会把加固了的内容取出来。
4. 当然还有很多细节，暂不表。
5. 所以我们需要从 application 的启动过程来了解 DexHunter 所做的事情是什么。

**《Android 源代码情景分析》第十二章:**

Activity 管理服务器 ActivityManagerService 再启动一个应用程序组件时(假设启动的就是我们想要启动的应用的 MAIN Activity)，如果发现所需要的的应用程序进程还没有启动起来，他就会请求 Zygote 进程将这个应用程序进程启动起来。

Zyegote 进程通过复制自身的方式来创建一个新的应用程序进程。

应用程序启动过程中，除了可以获得一个虚拟机实例外，还可以获得一个 Binder 线程池和一个消息循环，这样，运行在它里面的应用程序组件就可以方便的使用 Android 系统的消息处理机制，以及 Binder 进程间通信机制来实现自己的业务逻辑。

**在上述过程中我们关心的内容是：** 创建新进程的过程中，DEX 是如何被操作的，系统正常操作 DEX 的过程和 DexHunter 操作 DEX 过程的异同。

**《Android 源代码情景分析》第七章:**

根 Activity 以快捷图标的形式显示在应用程序启动器中，它的启动过程就代表了一个 Android 应用程序的启动过程。子 Activity 由根 Activity 或其他子 Activiyt 启动。它们有可能与启动它们的 Activiyt 运行在同一个进程中，也有可能运行在不的进程中，这取决于它们的启动参数的配置。

我们从 Launcher.startActivitySafely 开始这一流程：当我们在 应用程序启动器 Launcher 的界面上点击一个应用程序的快捷图标时，Launcher 组件的成员函数 startActivitySafely 就会被调用来启动这个应用程序的根 Activity，其中要启动的根 Activity 信息包含在 intent 中。