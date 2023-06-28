
## [剖析应用性能](https://developer.android.com/studio/profile?utm_source=android-studio)

对 Profiler/trace 有了一定了解 , 它们的标注范围主要集中在视图结构方面的耗时内容

如果想针对线程进行耗时动作划分暂时还不够全面 , 比如主线程中加载布局 和 执行 I/O 操作同时存在的情况下无法分析 I/O 相关操作的细节信息

## 启动 Android Profile 能力进行追踪
1. 直接点击 AndroidStudio 图标 Profile 'AppName'
2. [通过应用插桩生成跟踪日志](https://developer.android.com/studio/profile/generate-trace-logs)
    ```kotlin
    Debug.startMethodTracing("tomyangming.trace")
    //需要仔细分析的代码内容
    Debug.stopMethodTracing()
    ```