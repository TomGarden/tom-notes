# Error:Unable to load class
```
Error:Unable to load class 'sync_local_repo1_dxnfsd3in5eeut4370m9n9fil$_run_closure1$_closure2$_closure4'.
Possible causes for this unexpected error include:
- Gradle's dependency cache may be corrupt (this sometimes occurs after a network connection timeout.)
    - Re-download dependencies and sync project (requires network)
- The state of a Gradle build process (daemon) may be corrupt. Stopping all Gradle daemons may solve this problem.
    - Stop Gradle build processes (requires restart)

Your project may be using a third-party plugin which is not compatible with the other plugins in the project or the version of Gradle requested by the project.

In the case of corrupt Gradle processes, you can also try closing the IDE and then killing all Java processes.
```

1. 删除 Build 文件夹
2. Build  ->  Rebuild Project

报错：
```
Error:Execution failed for task ':app:transformDexArchiveWithExternalLibsDexMergerForDebug'.
> java.lang.RuntimeException: java.lang.RuntimeException: com.android.builder.dexing.DexArchiveMergerException: Unable to merge dex
```

3. Build  ->  Clean Project


但是我什么都没做，这实在是莫名其妙

## 做过无效的
1. 查看插件，不能确定是那个插件出了问题，所以什么都没做
2. 创建新项目对比 build.gradle 发现相同，没有什么问题，什么都没做