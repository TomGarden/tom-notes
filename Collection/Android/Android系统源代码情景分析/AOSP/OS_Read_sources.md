##  0x00. 阅读 Android 源代码(2020-07-16 09:56:38)

### 0.1. 常规操作 无争议
以前用 SourceInsight 做这件事 , 需要安装虚拟机 , 现在用 AndroidStudio 

查看 自己 检出的 Android 源代码版本 > 方式一 : 
- 目录`/build/core/version_defaults.mk` 打开version_defaults.mk 文件，然后找 `PLATFORM_SDK_VERSION` 这个关键字的值，就可以在下表中找出相应的版本。


如何生成AndroidStudio可以打开的项目文件
- 这个文件可以作为参考 , 下文细节和文件内容相关 , 又不完全相同
- AOSP的 `development/tools/idegen/readme` 中有讲如何操作，我们按照其步骤来即可。
- 这个文件已经比较老啦 , 在今天查看这个文件虽然有帮助但是并不能解决所有问题 , 还是需要花时间做些探索



__未提前编译 AOSP 源码同步完成后支架操作 idegen 生成 android.ipr 尝试导入源码 , 点击无法跳转__

1. 先make development/tools/idegen/子目录：
    - `mmm development/tools/idegen/`
        - 实际上我是分两步的 :
        - `cd development/tools/idegen/`
        - `mmm`
    - 这个会得到idegen.jar，这个jar在第二步中要用到，如果没有这一步，第二步会提示找不到这个jar。

2. 生成项目文件：
    - `development/tools/idegen/idegen.sh`
    - 这一步会利用前面的jar，生成android.ipr等项目文件。
    - 本人只得到了两个文件 : `idegen.ipr` 和 `idegen.iml`
	- 这两个文件位于 aosp 根目录

3. 将项目导入到 idea 或者 AndroidStudio
	- 导入的时候选择 `idegen.ipr` 父目录(AOSP 目录)即可
    - 或者导入的时候选择 `idegen.ipr` 文件即可
    

__IDEA 配置修改__

如果 时间太久(2020-07-16 09:56:50) 还是应该参照官方指导做出合适的配置 `aosp/development/tools/idegen/README`


个人配置如下 :
```
//Help -> Edit custom properties

# 支持文件数
idea.max.intellisense.filesize=100000
# 支持大小写
idea.case.sensitive.fs=true
```

```
//Help > Edit Custom VM

-Xms1g
-Xmx5g
```



## 0x01. 用最新的 idea 导入 aosp 项目无法跳转

### 1.1. 思路一 通过旧版本 idea 加载 idegen.sh 生成的 `ipr` 文件
> 省心, 要忍受相对较陈旧的 IDE 工具

查看 idegen.sh 文件的 git 提交时间 , 找到历史 idea(`2016.3.8` 或 `2017.3.7`) 版本进行导入 , 

观察到 : 
1. 虽然有些许红色错误提示 , 但是可以顺利完成 Java 跳转
2. 不支持 Kotlin (思路二 可以知道为啥不支持 kotlin)


1. 要完成 java 跳转需要做的额外事情是:
    - 打开 `File -> Project Structure` 窗口
    - 选择 `Project Settings` 中的 `Modules` 子项
    - 切换到 `Dependencies` 标签
    - 将 `<Module source>` 和 `<No SDK>` 移动到列表顶部
    - apply
    - ok



异常信息(应该可以忽略, 我是忽略了的, 此处仅仅做记录):
```
Could not find class data for nested class kotlinx/coroutines/internal/LockFreeLinkedListNode.AbstractAtomicDesc of class kotlinx/coroutines/internal/LockFreeLinkedListNode
Root file: /Volumes/AOSP/aosp/external/kotlinc/lib/kotlin-main-kts.jar!/kotlinx/coroutines/internal/LockFreeLinkedListNode.class
Dir: /Volumes/AOSP/aosp/external/kotlinc/lib/kotlin-main-kts.jar!/kotlinx/coroutines/internal
Children:
ArrayCopyKt.class (valid: true)
ArrayQueue.class (valid: true)
AtomicKt.class (valid: true)
AtomicOp.class (valid: true)
ConcurrentKt.class (valid: true)
LockFreeLinkedListHead.class (valid: true)
LockFreeLinkedListKt.class (valid: true)
LockFreeLinkedListNode$CondAddOp.class (valid: true)
LockFreeLinkedListNode.class (valid: true)
LockFreeTaskQueue.class (valid: true)
LockFreeTaskQueueCore$Companion.class (valid: true)
LockFreeTaskQueueCore$Placeholder.class (valid: true)
LockFreeTaskQueueCore.class (valid: true)
OpDescriptor.class (valid: true)
Removed.class (valid: true)
Symbol.class (valid: true)
SystemPropsKt.class (valid: true)
ThreadContextKt$countAll$1.class (valid: true)
ThreadContextKt$findOne$1.class (valid: true)
ThreadContextKt$restoreState$1.class (valid: true)
ThreadContextKt$updateState$1.class (valid: true)
ThreadContextKt.class (valid: true)
ThreadLocalWithInitialValue.class (valid: true)
ThreadSafeHeap.class (valid: true)
ThreadSafeHeapNode.class (valid: true)
ThreadState.class (valid: true)
java.lang.Throwable: Could not find class data for nested class kotlinx/coroutines/internal/LockFreeLinkedListNode.AbstractAtomicDesc of class kotlinx/coroutines/internal/LockFreeLinkedListNode
Root file: /Volumes/AOSP/aosp/external/kotlinc/lib/kotlin-main-kts.jar!/kotlinx/coroutines/internal/LockFreeLinkedListNode.class
Dir: /Volumes/AOSP/aosp/external/kotlinc/lib/kotlin-main-kts.jar!/kotlinx/coroutines/internal
Children:
ArrayCopyKt.class (valid: true)
ArrayQueue.class (valid: true)
AtomicKt.class (valid: true)
AtomicOp.class (valid: true)
ConcurrentKt.class (valid: true)
LockFreeLinkedListHead.class (valid: true)
LockFreeLinkedListKt.class (valid: true)
LockFreeLinkedListNode$CondAddOp.class (valid: true)
LockFreeLinkedListNode.class (valid: true)
LockFreeTaskQueue.class (valid: true)
LockFreeTaskQueueCore$Companion.class (valid: true)
LockFreeTaskQueueCore$Placeholder.class (valid: true)
LockFreeTaskQueueCore.class (valid: true)
OpDescriptor.class (valid: true)
Removed.class (valid: true)
Symbol.class (valid: true)
SystemPropsKt.class (valid: true)
ThreadContextKt$countAll$1.class (valid: true)
ThreadContextKt$findOne$1.class (valid: true)
ThreadContextKt$restoreState$1.class (valid: true)
ThreadContextKt$updateState$1.class (valid: true)
ThreadContextKt.class (valid: true)
ThreadLocalWithInitialValue.class (valid: true)
ThreadSafeHeap.class (valid: true)
ThreadSafeHeapNode.class (valid: true)
ThreadState.class (valid: true)
	at com.intellij.openapi.diagnostic.Logger.error(Logger.java:136)
	at org.jetbrains.kotlin.idea.decompiler.stubBuilder.ClassClsStubBuilder.createNestedClassStub(ClassClsStubBuilder.kt:251)
	at org.jetbrains.kotlin.idea.decompiler.stubBuilder.ClassClsStubBuilder.createInnerAndNestedClasses(ClassClsStubBuilder.kt:242)
	at org.jetbrains.kotlin.idea.decompiler.stubBuilder.ClassClsStubBuilder.createClassBodyAndMemberStubs(ClassClsStubBuilder.kt:185)
	at org.jetbrains.kotlin.idea.decompiler.stubBuilder.ClassClsStubBuilder.build(ClassClsStubBuilder.kt:94)
	at org.jetbrains.kotlin.idea.decompiler.stubBuilder.ClassClsStubBuilderKt.createClassStub(ClassClsStubBuilder.kt:53)
	at org.jetbrains.kotlin.idea.decompiler.stubBuilder.ClsStubBuildingKt.createTopLevelClassStub(clsStubBuilding.kt:53)
	at org.jetbrains.kotlin.idea.decompiler.classFile.KotlinClsStubBuilder.doBuildFileStub(KotlinClsStubBuilder.kt:84)
	at org.jetbrains.kotlin.idea.decompiler.classFile.KotlinClsStubBuilder.buildFileStub(KotlinClsStubBuilder.kt:51)
	at com.intellij.psi.impl.compiled.ClassFileStubBuilder.buildStubTree(ClassFileStubBuilder.java:57)
	at com.intellij.psi.impl.compiled.ClassFileStubBuilder.buildStubTree(ClassFileStubBuilder.java:37)
	at com.intellij.psi.stubs.StubTreeBuilder.buildStubTree(StubTreeBuilder.java:61)
	at com.intellij.psi.stubs.StubUpdatingIndex$3.a(StubUpdatingIndex.java:232)
	at com.intellij.openapi.application.impl.ApplicationImpl.runReadAction(ApplicationImpl.java:907)
	at com.intellij.psi.stubs.StubUpdatingIndex$3.map(StubUpdatingIndex.java:214)
	at com.intellij.psi.stubs.StubUpdatingIndex$3.map(StubUpdatingIndex.java:197)
	at com.intellij.util.indexing.impl.MapReduceIndex.mapInput(MapReduceIndex.java:275)
	at com.intellij.util.indexing.VfsAwareMapReduceIndex.calculateUpdateData(VfsAwareMapReduceIndex.java:98)
	at com.intellij.util.indexing.impl.MapReduceIndex.update(MapReduceIndex.java:215)
	at com.intellij.util.indexing.FileBasedIndexImpl.a(FileBasedIndexImpl.java:1665)
	at com.intellij.util.indexing.FileBasedIndexImpl.a(FileBasedIndexImpl.java:1593)
	at com.intellij.openapi.fileTypes.impl.FileTypeManagerImpl.freezeFileTypeTemporarilyIn(FileTypeManagerImpl.java:511)
	at com.intellij.util.indexing.FileBasedIndexImpl.a(FileBasedIndexImpl.java:1552)
	at com.intellij.util.indexing.FileBasedIndexImpl.indexFileContent(FileBasedIndexImpl.java:1540)
	at com.intellij.util.indexing.UnindexedFilesUpdater.a(UnindexedFilesUpdater.java:109)
	at com.intellij.openapi.project.CacheUpdateRunner$MyRunnable.a(CacheUpdateRunner.java:227)
	at com.intellij.openapi.application.impl.ApplicationImpl.tryRunReadAction(ApplicationImpl.java:1127)
	at com.intellij.openapi.project.CacheUpdateRunner$MyRunnable.a(CacheUpdateRunner.java:243)
	at com.intellij.openapi.progress.impl.CoreProgressManager.a(CoreProgressManager.java:157)
	at com.intellij.openapi.progress.impl.CoreProgressManager.a(CoreProgressManager.java:543)
	at com.intellij.openapi.progress.impl.CoreProgressManager.executeProcessUnderProgress(CoreProgressManager.java:488)
	at com.intellij.openapi.progress.impl.ProgressManagerImpl.executeProcessUnderProgress(ProgressManagerImpl.java:94)
	at com.intellij.openapi.progress.impl.CoreProgressManager.runProcess(CoreProgressManager.java:144)
	at com.intellij.openapi.project.CacheUpdateRunner$MyRunnable.run(CacheUpdateRunner.java:240)
	at com.intellij.openapi.application.impl.ApplicationImpl$1.run(ApplicationImpl.java:315)
	at java.util.concurrent.Executors$RunnableAdapter.call(Executors.java:511)
	at java.util.concurrent.FutureTask.run(FutureTask.java:266)
	at java.util.concurrent.ThreadPoolExecutor.runWorker(ThreadPoolExecutor.java:1142)
	at java.util.concurrent.ThreadPoolExecutor$Worker.run(ThreadPoolExecutor.java:617)
	at java.lang.Thread.run(Thread.java:745)


java.lang.Throwable: Could not find class data for nested class kotlinx/coroutines/JobSupport.AwaitContinuation of class kotlinx/coroutines/JobSupport
Root file: /Volumes/AOSP/aosp/external/kotlinc/lib/kotlin-main-kts.jar!/kotlinx/coroutines/JobSupport.class
Dir: /Volumes/AOSP/aosp/external/kotlinc/lib/kotlin-main-kts.jar!/kotlinx/coroutines
Children:
AbstractCoroutine.class (valid: true)
BlockingCoroutine.class (valid: true)
BlockingEventLoop.class (valid: true)
BuildersKt.class (valid: true)
BuildersKt__BuildersKt.class (valid: true)
ChildHandle.class (valid: true)
ChildHandleNode.class (valid: true)
ChildJob.class (valid: true)
CommonPool$createPlainPool$1.class (valid: true)
CommonPool$isGoodCommonPool$1.class (valid: true)
CommonPool.class (valid: true)
CompletedExceptionally.class (valid: true)
CompletedExceptionallyKt.class (valid: true)
CompletionHandlerBase.class (valid: true)
CompletionHandlerException.class (valid: true)
CoroutineContextKt.class (valid: true)
CoroutineDispatcher.class (valid: true)
CoroutineExceptionHandler$Key.class (valid: true)
CoroutineExceptionHandler.class (valid: true)
CoroutineExceptionHandlerImplKt.class (valid: true)
CoroutineExceptionHandlerKt.class (valid: true)
CoroutineId$Key.class (valid: true)
CoroutineId.class (valid: true)
CoroutineName$Key.class (valid: true)
CoroutineName.class (valid: true)
CoroutineScope.class (valid: true)
CoroutineStart$WhenMappings.class (valid: true)
CoroutineStart.class (valid: true)
DebugKt.class (valid: true)
DefaultExecutor.class (valid: true)
DefaultTimeSource.class (valid: true)
DispatchException.class (valid: true)
DispatchedContinuation.class (valid: true)
DispatchedKt.class (valid: true)
DispatchedTask.class (valid: true)
Dispatchers.class (valid: true)
DisposableHandle.class (valid: true)
Empty.class (valid: true)
EventLoop.class (valid: true)
EventLoopBase$DelayedTask.class (valid: true)
EventLoopBase.class (valid: true)
EventLoopKt.class (valid: true)
ExecutorCoroutineDispatcher.class (valid: true)
GlobalScope.class (valid: true)
InactiveNodeList.class (valid: true)
Incomplete.class (valid: true)
InvokeOnCancelling.class (valid: true)
InvokeOnCompletion.class (valid: true)
Job$DefaultImpls.class (valid: true)
Job$Key.class (valid: true)
Job.class (valid: true)
JobCancellationException.class (valid: true)
JobCancellingNode.class (valid: true)
JobNode.class (valid: true)
JobSupport$ChildCompletion.class (valid: true)
JobSupport$Finishing.class (valid: true)
JobSupport$addLastAtomic$$inlined$addLastIf$1.class (valid: true)
JobSupport.class (valid: true)
JobSupportKt.class (valid: true)
NodeList.class (valid: true)
NonDisposableHandle.class (valid: true)
ParentJob.class (valid: true)
ResumeModeKt.class (valid: true)
ThreadContextElement$DefaultImpls.class (valid: true)
ThreadContextElement.class (valid: true)
ThreadEventLoop.class (valid: true)
TimeSource.class (valid: true)
TimeSourceKt.class (valid: true)
Unconfined.class (valid: true)
UndispatchedEventLoop$EventLoop.class (valid: true)
UndispatchedEventLoop$threadLocalEventLoop$1.class (valid: true)
UndispatchedEventLoop.class (valid: true)
internal (valid: true)
intrinsics (valid: true)
scheduling (valid: true)
	at com.intellij.openapi.diagnostic.Logger.error(Logger.java:136)
	at org.jetbrains.kotlin.idea.decompiler.stubBuilder.ClassClsStubBuilder.createNestedClassStub(ClassClsStubBuilder.kt:251)
	at org.jetbrains.kotlin.idea.decompiler.stubBuilder.ClassClsStubBuilder.createInnerAndNestedClasses(ClassClsStubBuilder.kt:242)
	at org.jetbrains.kotlin.idea.decompiler.stubBuilder.ClassClsStubBuilder.createClassBodyAndMemberStubs(ClassClsStubBuilder.kt:185)
	at org.jetbrains.kotlin.idea.decompiler.stubBuilder.ClassClsStubBuilder.build(ClassClsStubBuilder.kt:94)
	at org.jetbrains.kotlin.idea.decompiler.stubBuilder.ClassClsStubBuilderKt.createClassStub(ClassClsStubBuilder.kt:53)
	at org.jetbrains.kotlin.idea.decompiler.stubBuilder.ClsStubBuildingKt.createTopLevelClassStub(clsStubBuilding.kt:53)
	at org.jetbrains.kotlin.idea.decompiler.classFile.KotlinClsStubBuilder.doBuildFileStub(KotlinClsStubBuilder.kt:84)
	at org.jetbrains.kotlin.idea.decompiler.classFile.KotlinClsStubBuilder.buildFileStub(KotlinClsStubBuilder.kt:51)
	at com.intellij.psi.impl.compiled.ClassFileStubBuilder.buildStubTree(ClassFileStubBuilder.java:57)
	at com.intellij.psi.impl.compiled.ClassFileStubBuilder.buildStubTree(ClassFileStubBuilder.java:37)
	at com.intellij.psi.stubs.StubTreeBuilder.buildStubTree(StubTreeBuilder.java:61)
	at com.intellij.psi.stubs.StubUpdatingIndex$3.a(StubUpdatingIndex.java:232)
	at com.intellij.openapi.application.impl.ApplicationImpl.runReadAction(ApplicationImpl.java:907)
	at com.intellij.psi.stubs.StubUpdatingIndex$3.map(StubUpdatingIndex.java:214)
	at com.intellij.psi.stubs.StubUpdatingIndex$3.map(StubUpdatingIndex.java:197)
	at com.intellij.util.indexing.impl.MapReduceIndex.mapInput(MapReduceIndex.java:275)
	at com.intellij.util.indexing.VfsAwareMapReduceIndex.calculateUpdateData(VfsAwareMapReduceIndex.java:98)
	at com.intellij.util.indexing.impl.MapReduceIndex.update(MapReduceIndex.java:215)
	at com.intellij.util.indexing.FileBasedIndexImpl.a(FileBasedIndexImpl.java:1665)
	at com.intellij.util.indexing.FileBasedIndexImpl.a(FileBasedIndexImpl.java:1593)
	at com.intellij.openapi.fileTypes.impl.FileTypeManagerImpl.freezeFileTypeTemporarilyIn(FileTypeManagerImpl.java:511)
	at com.intellij.util.indexing.FileBasedIndexImpl.a(FileBasedIndexImpl.java:1552)
	at com.intellij.util.indexing.FileBasedIndexImpl.indexFileContent(FileBasedIndexImpl.java:1540)
	at com.intellij.util.indexing.UnindexedFilesUpdater.a(UnindexedFilesUpdater.java:109)
	at com.intellij.openapi.project.CacheUpdateRunner$MyRunnable.a(CacheUpdateRunner.java:227)
	at com.intellij.openapi.application.impl.ApplicationImpl.tryRunReadAction(ApplicationImpl.java:1127)
	at com.intellij.openapi.project.CacheUpdateRunner$MyRunnable.a(CacheUpdateRunner.java:243)
	at com.intellij.openapi.progress.impl.CoreProgressManager.a(CoreProgressManager.java:157)
	at com.intellij.openapi.progress.impl.CoreProgressManager.a(CoreProgressManager.java:543)
	at com.intellij.openapi.progress.impl.CoreProgressManager.executeProcessUnderProgress(CoreProgressManager.java:488)
	at com.intellij.openapi.progress.impl.ProgressManagerImpl.executeProcessUnderProgress(ProgressManagerImpl.java:94)
	at com.intellij.openapi.progress.impl.CoreProgressManager.runProcess(CoreProgressManager.java:144)
	at com.intellij.openapi.project.CacheUpdateRunner$MyRunnable.run(CacheUpdateRunner.java:240)
	at com.intellij.openapi.application.impl.ApplicationImpl$1.run(ApplicationImpl.java:315)
	at java.util.concurrent.Executors$RunnableAdapter.call(Executors.java:511)
	at java.util.concurrent.FutureTask.run(FutureTask.java:266)
	at java.util.concurrent.ThreadPoolExecutor.runWorker(ThreadPoolExecutor.java:1142)
	at java.util.concurrent.ThreadPoolExecutor$Worker.run(ThreadPoolExecutor.java:617)
	at java.lang.Thread.run(Thread.java:745)


java.lang.Throwable: Could not find class data for nested class kotlinx/coroutines/EventLoopBase.DelayedResumeTask of class kotlinx/coroutines/EventLoopBase
Root file: /Volumes/AOSP/aosp/external/kotlinc/lib/kotlin-main-kts.jar!/kotlinx/coroutines/EventLoopBase.class
Dir: /Volumes/AOSP/aosp/external/kotlinc/lib/kotlin-main-kts.jar!/kotlinx/coroutines
Children:
AbstractCoroutine.class (valid: true)
BlockingCoroutine.class (valid: true)
BlockingEventLoop.class (valid: true)
BuildersKt.class (valid: true)
BuildersKt__BuildersKt.class (valid: true)
ChildHandle.class (valid: true)
ChildHandleNode.class (valid: true)
ChildJob.class (valid: true)
CommonPool$createPlainPool$1.class (valid: true)
CommonPool$isGoodCommonPool$1.class (valid: true)
CommonPool.class (valid: true)
CompletedExceptionally.class (valid: true)
CompletedExceptionallyKt.class (valid: true)
CompletionHandlerBase.class (valid: true)
CompletionHandlerException.class (valid: true)
CoroutineContextKt.class (valid: true)
CoroutineDispatcher.class (valid: true)
CoroutineExceptionHandler$Key.class (valid: true)
CoroutineExceptionHandler.class (valid: true)
CoroutineExceptionHandlerImplKt.class (valid: true)
CoroutineExceptionHandlerKt.class (valid: true)
CoroutineId$Key.class (valid: true)
CoroutineId.class (valid: true)
CoroutineName$Key.class (valid: true)
CoroutineName.class (valid: true)
CoroutineScope.class (valid: true)
CoroutineStart$WhenMappings.class (valid: true)
CoroutineStart.class (valid: true)
DebugKt.class (valid: true)
DefaultExecutor.class (valid: true)
DefaultTimeSource.class (valid: true)
DispatchException.class (valid: true)
DispatchedContinuation.class (valid: true)
DispatchedKt.class (valid: true)
DispatchedTask.class (valid: true)
Dispatchers.class (valid: true)
DisposableHandle.class (valid: true)
Empty.class (valid: true)
EventLoop.class (valid: true)
EventLoopBase$DelayedTask.class (valid: true)
EventLoopBase.class (valid: true)
EventLoopKt.class (valid: true)
ExecutorCoroutineDispatcher.class (valid: true)
GlobalScope.class (valid: true)
InactiveNodeList.class (valid: true)
Incomplete.class (valid: true)
InvokeOnCancelling.class (valid: true)
InvokeOnCompletion.class (valid: true)
Job$DefaultImpls.class (valid: true)
Job$Key.class (valid: true)
Job.class (valid: true)
JobCancellationException.class (valid: true)
JobCancellingNode.class (valid: true)
JobNode.class (valid: true)
JobSupport$ChildCompletion.class (valid: true)
JobSupport$Finishing.class (valid: true)
JobSupport$addLastAtomic$$inlined$addLastIf$1.class (valid: true)
JobSupport.class (valid: true)
JobSupportKt.class (valid: true)
NodeList.class (valid: true)
NonDisposableHandle.class (valid: true)
ParentJob.class (valid: true)
ResumeModeKt.class (valid: true)
ThreadContextElement$DefaultImpls.class (valid: true)
ThreadContextElement.class (valid: true)
ThreadEventLoop.class (valid: true)
TimeSource.class (valid: true)
TimeSourceKt.class (valid: true)
Unconfined.class (valid: true)
UndispatchedEventLoop$EventLoop.class (valid: true)
UndispatchedEventLoop$threadLocalEventLoop$1.class (valid: true)
UndispatchedEventLoop.class (valid: true)
internal (valid: true)
intrinsics (valid: true)
scheduling (valid: true)
	at com.intellij.openapi.diagnostic.Logger.error(Logger.java:136)
	at org.jetbrains.kotlin.idea.decompiler.stubBuilder.ClassClsStubBuilder.createNestedClassStub(ClassClsStubBuilder.kt:251)
	at org.jetbrains.kotlin.idea.decompiler.stubBuilder.ClassClsStubBuilder.createInnerAndNestedClasses(ClassClsStubBuilder.kt:242)
	at org.jetbrains.kotlin.idea.decompiler.stubBuilder.ClassClsStubBuilder.createClassBodyAndMemberStubs(ClassClsStubBuilder.kt:185)
	at org.jetbrains.kotlin.idea.decompiler.stubBuilder.ClassClsStubBuilder.build(ClassClsStubBuilder.kt:94)
	at org.jetbrains.kotlin.idea.decompiler.stubBuilder.ClassClsStubBuilderKt.createClassStub(ClassClsStubBuilder.kt:53)
	at org.jetbrains.kotlin.idea.decompiler.stubBuilder.ClsStubBuildingKt.createTopLevelClassStub(clsStubBuilding.kt:53)
	at org.jetbrains.kotlin.idea.decompiler.classFile.KotlinClsStubBuilder.doBuildFileStub(KotlinClsStubBuilder.kt:84)
	at org.jetbrains.kotlin.idea.decompiler.classFile.KotlinClsStubBuilder.buildFileStub(KotlinClsStubBuilder.kt:51)
	at com.intellij.psi.impl.compiled.ClassFileStubBuilder.buildStubTree(ClassFileStubBuilder.java:57)
	at com.intellij.psi.impl.compiled.ClassFileStubBuilder.buildStubTree(ClassFileStubBuilder.java:37)
	at com.intellij.psi.stubs.StubTreeBuilder.buildStubTree(StubTreeBuilder.java:61)
	at com.intellij.psi.stubs.StubUpdatingIndex$3.a(StubUpdatingIndex.java:232)
	at com.intellij.openapi.application.impl.ApplicationImpl.runReadAction(ApplicationImpl.java:907)
	at com.intellij.psi.stubs.StubUpdatingIndex$3.map(StubUpdatingIndex.java:214)
	at com.intellij.psi.stubs.StubUpdatingIndex$3.map(StubUpdatingIndex.java:197)
	at com.intellij.util.indexing.impl.MapReduceIndex.mapInput(MapReduceIndex.java:275)
	at com.intellij.util.indexing.VfsAwareMapReduceIndex.calculateUpdateData(VfsAwareMapReduceIndex.java:98)
	at com.intellij.util.indexing.impl.MapReduceIndex.update(MapReduceIndex.java:215)
	at com.intellij.util.indexing.FileBasedIndexImpl.a(FileBasedIndexImpl.java:1665)
	at com.intellij.util.indexing.FileBasedIndexImpl.a(FileBasedIndexImpl.java:1593)
	at com.intellij.openapi.fileTypes.impl.FileTypeManagerImpl.freezeFileTypeTemporarilyIn(FileTypeManagerImpl.java:511)
	at com.intellij.util.indexing.FileBasedIndexImpl.a(FileBasedIndexImpl.java:1552)
	at com.intellij.util.indexing.FileBasedIndexImpl.indexFileContent(FileBasedIndexImpl.java:1540)
	at com.intellij.util.indexing.UnindexedFilesUpdater.a(UnindexedFilesUpdater.java:109)
	at com.intellij.openapi.project.CacheUpdateRunner$MyRunnable.a(CacheUpdateRunner.java:227)
	at com.intellij.openapi.application.impl.ApplicationImpl.tryRunReadAction(ApplicationImpl.java:1127)
	at com.intellij.openapi.project.CacheUpdateRunner$MyRunnable.a(CacheUpdateRunner.java:243)
	at com.intellij.openapi.progress.impl.CoreProgressManager.a(CoreProgressManager.java:157)
	at com.intellij.openapi.progress.impl.CoreProgressManager.a(CoreProgressManager.java:543)
	at com.intellij.openapi.progress.impl.CoreProgressManager.executeProcessUnderProgress(CoreProgressManager.java:488)
	at com.intellij.openapi.progress.impl.ProgressManagerImpl.executeProcessUnderProgress(ProgressManagerImpl.java:94)
	at com.intellij.openapi.progress.impl.CoreProgressManager.runProcess(CoreProgressManager.java:144)
	at com.intellij.openapi.project.CacheUpdateRunner$MyRunnable.run(CacheUpdateRunner.java:240)
	at com.intellij.openapi.application.impl.ApplicationImpl$1.run(ApplicationImpl.java:315)
	at java.util.concurrent.Executors$RunnableAdapter.call(Executors.java:511)
	at java.util.concurrent.FutureTask.run(FutureTask.java:266)
	at java.util.concurrent.ThreadPoolExecutor.runWorker(ThreadPoolExecutor.java:1142)
	at java.util.concurrent.ThreadPoolExecutor$Worker.run(ThreadPoolExecutor.java:617)
	at java.lang.Thread.run(Thread.java:745)



```


### 1.2. 思路二 (键者更喜欢) , 仅仅针对 2020.1.2 版本完成了实际测试

仍然要先安装软件执行导入/打开动作

导入后先完成如下动作 , 在 2017 版本如下操作尝到了甜头在 2020 版本仍然保持这个做法
- 打开 `File -> Project Structure` 窗口
- 选择 `Project Settings` 中的 `Modules` 子项
- 切换到 `Dependencies` 标签
- 将 `<Module source>` 和 `<No SDK>` 移动到列表顶部
- apply
- ok
- 等到扫描和索引完成后会发现依然不能跳转

新思路 : 要使用 idea 2018 、 2019 或者 2020 版本我们或需是需要研究下 idea 的 `.iml` 文件

通过测试我们知道
- __测试手段可忽略__ 测试手段就是通过使用 idea 创建 java 项目然后查看精简版的 `iml` 文件 , 再通过修改查看索引结果
- __测试手段可忽略__ 如此反复就得到了规律结论

将 `.iml` 文件中的 `<sourceFolder` 节点中的属性 `type` 及其对应的值删掉并且重新扫描和建立索引的话就可以完成 java 代码跳转了
- 这里涉及到的 type 共有两种 `type="kotlin-test"` 和 `type="kotlin-source"`
- 这么做 java 是可以跳转了  , kotlin 是否仍被支持呢 ?  __经过测试 , 果然就不支持啦 , kotlin 代码跳转受限__
    - 再次经过测试可以知道不支持 kotlin 内容跳转并不是我们删除 type 造成的 , 
      而是因为 `iml` 文件中 `content` 节点本身就没有 `kotlin` 代码所在的路径的配置
    - 最终经过我们手动配置后就可以在 kotlin 中跳转了
    - 经过我们这一系列操作之后的 `iml` 文件格式如下
        ```xml
        <!--非本次重点的头部信息略-->

        <component name="NewModuleRootManager" inherit-compiler-output="true">
            <exclude-output />
            <content url="file://$MODULE_DIR$">

                <!--自定义节点用于控制 kotlin 跳转 , 可以手动添加 , 觉得手动添加烦人 , 就写个脚本吧 , 找出所有需要添加的路径一次完成-->
                <!--[猜测 , 未测试]也可以通过 `File -> Project Structure` 添加节点-->
                <sourceFolder url="file://$MODULE_DIR$/tools/metalava/src/test/java"  />

                <!--原来的content 内容 删除了 sourceFolder 节点中的 type 属性-->
                <sourceFolder url="file://$MODULE_DIR$/art/test/004-JniTest/src"  />

                <!--content 中的其他节点省略-->
            </content>

            <!--orderEntry 节点们 也省略-->

        </component>
        </module>
        ```

至此我们已经可以通过 idea 正常读取 AOSP 了

猜测通过 Android Studio 也可行 , 但是更喜欢两个 IDE 一个开发, 一个做其他

仍然会有部分错误提示 , 暂时放一放这个细节






## 参考
1. https://juejin.im/post/5bd5c42ce51d457a9b6c8387
2. https://www.geek-share.com/detail/2681729474.html

//=================== 一个失败的分割线 ===================

3. https://www.jianshu.com/p/a19dcb06cd53