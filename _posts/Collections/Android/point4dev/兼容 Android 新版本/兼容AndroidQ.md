NOTE: appcompat.sh is still under development. It can report
API uses that do not execute at runtime, and reflection uses
that do not exist. It can also miss on reflection uses.
#1: Linking greylist Landroid/graphics/Canvas;->save(I)I use(s):
       Lcom/umeng/social/tool/ComposeTool;->createCompose(Landroid/graphics/Bitmap;Landroid/graphics/Bitmap;ZI)Landroid/graphics/Bitmap;
       Lcom/umeng/social/tool/ComposeTool;->createTextImage(Ljava/lang/String;Landroid/graphics/Bitmap;II)Landroid/graphics/Bitmap;
       Lcom/umeng/social/tool/ComposeTool;->createWaterMask(Landroid/graphics/Bitmap;Landroid/graphics/Bitmap;II)Landroid/graphics/Bitmap;
       Lcom/umeng/social/tool/UMWaterMark;->compound(Landroid/graphics/Bitmap;)Landroid/graphics/Bitmap;

#2: Linking greylist Landroid/net/SSLCertificateSocketFactory;->getHttpSocketFactory(ILandroid/net/SSLSessionCache;)Lorg/apache/http/conn/ssl/SSLSocketFactory; use(s):
       Lcom/alipay/android/phone/mrpc/core/b;->a(Ljava/lang/String;)Lcom/alipay/android/phone/mrpc/core/b;

#3: Linking greylist Lsun/misc/Unsafe;->arrayBaseOffset(Ljava/lang/Class;)I use(s):
       Ljava8/util/concurrent/ForkJoinPool$WorkQueue;-><clinit>()V
       Ljava8/util/concurrent/ForkJoinPool;-><clinit>()V

#4: Linking greylist Lsun/misc/Unsafe;->arrayIndexScale(Ljava/lang/Class;)I use(s):
       Ljava8/util/concurrent/ForkJoinPool$WorkQueue;-><clinit>()V
       Ljava8/util/concurrent/ForkJoinPool;-><clinit>()V

#5: Linking greylist Lsun/misc/Unsafe;->compareAndSwapInt(Ljava/lang/Object;JII)Z use(s):
       Ljava8/util/concurrent/CountedCompleter;->addToPendingCount(I)V
       Ljava8/util/concurrent/CountedCompleter;->compareAndSetPendingCount(II)Z
       Ljava8/util/concurrent/CountedCompleter;->decrementPendingCountUnlessZero()I
       Ljava8/util/concurrent/CountedCompleter;->firstComplete()Ljava8/util/concurrent/CountedCompleter;
       Ljava8/util/concurrent/CountedCompleter;->propagateCompletion()V
       Ljava8/util/concurrent/CountedCompleter;->tryComplete()V
       Ljava8/util/concurrent/ForkJoinPool$WorkQueue;->sharedHelpCC(Ljava8/util/concurrent/CountedCompleter;I)I
       Ljava8/util/concurrent/ForkJoinPool$WorkQueue;->tryLockSharedQueue()Z
       Ljava8/util/concurrent/ForkJoinPool$WorkQueue;->trySharedUnpush(Ljava8/util/concurrent/ForkJoinTask;)Z
       Ljava8/util/concurrent/ForkJoinPool;->tryTerminate(ZZ)Z (3 occurrences)
       Ljava8/util/concurrent/ForkJoinTask;->compareAndSetForkJoinTaskTag(SS)Z
       Ljava8/util/concurrent/ForkJoinTask;->externalAwaitDone()I
       Ljava8/util/concurrent/ForkJoinTask;->externalInterruptibleAwaitDone()I
       Ljava8/util/concurrent/ForkJoinTask;->get(JLjava/util/concurrent/TimeUnit;)Ljava/lang/Object;
       Ljava8/util/concurrent/ForkJoinTask;->internalWait(J)V
       Ljava8/util/concurrent/ForkJoinTask;->setCompletion(I)I
       Ljava8/util/concurrent/ForkJoinTask;->setForkJoinTaskTag(S)S

#6: Linking greylist Lsun/misc/Unsafe;->compareAndSwapLong(Ljava/lang/Object;JJJ)Z use(s):
       Ljava8/util/concurrent/ForkJoinPool;->deregisterWorker(Ljava8/util/concurrent/ForkJoinWorkerThread;Ljava/lang/Throwable;)V
       Ljava8/util/concurrent/ForkJoinPool;->getAndAddLong(Ljava/lang/Object;JJ)J
       Ljava8/util/concurrent/ForkJoinPool;->runWorker(Ljava8/util/concurrent/ForkJoinPool$WorkQueue;)V (2 occurrences)
       Ljava8/util/concurrent/ForkJoinPool;->signalWork()V
       Ljava8/util/concurrent/ForkJoinPool;->tryAddWorker(J)V
       Ljava8/util/concurrent/ForkJoinPool;->tryCompensate(Ljava8/util/concurrent/ForkJoinPool$WorkQueue;)I (3 occurrences)
       Ljava8/util/concurrent/Phaser;->arriveAndAwaitAdvance()I (2 occurrences)
       Ljava8/util/concurrent/Phaser;->doArrive(I)I (3 occurrences)
       Ljava8/util/concurrent/Phaser;->doRegister(I)I (3 occurrences)
       Ljava8/util/concurrent/Phaser;->forceTermination()V
       Ljava8/util/concurrent/Phaser;->reconcileState()J

#7: Linking greylist Lsun/misc/Unsafe;->compareAndSwapObject(Ljava/lang/Object;JLjava/lang/Object;Ljava/lang/Object;)Z use(s):
       Ljava8/util/concurrent/CompletableFuture;->casNext(Ljava8/util/concurrent/CompletableFuture$Completion;Ljava8/util/concurrent/CompletableFuture$Completion;Ljava8/util/concurrent/CompletableFuture$Completion;)Z
       Ljava8/util/concurrent/CompletableFuture;->casStack(Ljava8/util/concurrent/CompletableFuture$Completion;Ljava8/util/concurrent/CompletableFuture$Completion;)Z
       Ljava8/util/concurrent/CompletableFuture;->completeNull()Z
       Ljava8/util/concurrent/CompletableFuture;->completeRelay(Ljava/lang/Object;)Z
       Ljava8/util/concurrent/CompletableFuture;->completeThrowable(Ljava/lang/Throwable;)Z
       Ljava8/util/concurrent/CompletableFuture;->completeThrowable(Ljava/lang/Throwable;Ljava/lang/Object;)Z
       Ljava8/util/concurrent/CompletableFuture;->completeValue(Ljava/lang/Object;)Z
       Ljava8/util/concurrent/CompletableFuture;->internalComplete(Ljava/lang/Object;)Z
       Ljava8/util/concurrent/CompletableFuture;->tryPushStack(Ljava8/util/concurrent/CompletableFuture$Completion;)Z
       Ljava8/util/concurrent/ForkJoinPool$WorkQueue;->getAndSetObject(Ljava/lang/Object;JLjava/lang/Object;)Ljava/lang/Object;
       Ljava8/util/concurrent/ForkJoinPool$WorkQueue;->growArray()[Ljava8/util/concurrent/ForkJoinTask;
       Ljava8/util/concurrent/ForkJoinPool$WorkQueue;->localHelpCC(Ljava8/util/concurrent/CountedCompleter;I)I
       Ljava8/util/concurrent/ForkJoinPool$WorkQueue;->poll()Ljava8/util/concurrent/ForkJoinTask;
       Ljava8/util/concurrent/ForkJoinPool$WorkQueue;->pop()Ljava8/util/concurrent/ForkJoinTask;
       Ljava8/util/concurrent/ForkJoinPool$WorkQueue;->sharedHelpCC(Ljava8/util/concurrent/CountedCompleter;I)I
       Ljava8/util/concurrent/ForkJoinPool$WorkQueue;->tryRemoveAndExec(Ljava8/util/concurrent/ForkJoinTask;)V
       Ljava8/util/concurrent/ForkJoinPool$WorkQueue;->trySharedUnpush(Ljava8/util/concurrent/ForkJoinTask;)Z
       Ljava8/util/concurrent/ForkJoinPool$WorkQueue;->tryUnpush(Ljava8/util/concurrent/ForkJoinTask;)Z
       Ljava8/util/concurrent/ForkJoinPool;->awaitJoin(Ljava8/util/concurrent/ForkJoinPool$WorkQueue;Ljava8/util/concurrent/ForkJoinTask;J)I
       Ljava8/util/concurrent/ForkJoinPool;->helpAsyncBlocker(Ljava/util/concurrent/Executor;Ljava8/util/concurrent/ForkJoinPool$ManagedBlocker;)V
       Ljava8/util/concurrent/ForkJoinPool;->helpQuiescePool(Ljava8/util/concurrent/ForkJoinPool$WorkQueue;)V
       Ljava8/util/concurrent/ForkJoinPool;->pollScan(Z)Ljava8/util/concurrent/ForkJoinTask;
       Ljava8/util/concurrent/ForkJoinPool;->runWorker(Ljava8/util/concurrent/ForkJoinPool$WorkQueue;)V

#8: Linking greylist Lsun/misc/Unsafe;->getInt(Ljava/lang/Object;J)I use(s):
       Ljava8/util/ArrayDequeSpliterator;->getHead(Ljava/util/ArrayDeque;)I
       Ljava8/util/ArrayDequeSpliterator;->getTail(Ljava/util/ArrayDeque;)I
       Ljava8/util/ArrayListSpliterator;->getModCount(Ljava/util/ArrayList;)I
       Ljava8/util/ArrayListSpliterator;->getSize(Ljava/util/ArrayList;)I
       Ljava8/util/HMSpliterators$HashMapSpliterator;->getModCount(Ljava/util/HashMap;)I
       Ljava8/util/LinkedListSpliterator;->getModCount(Ljava/util/LinkedList;)I
       Ljava8/util/LinkedListSpliterator;->getSize(Ljava/util/LinkedList;)I
       Ljava8/util/PQueueSpliterator;->getModCount(Ljava/util/PriorityQueue;)I
       Ljava8/util/PQueueSpliterator;->getSize(Ljava/util/PriorityQueue;)I
       Ljava8/util/RASpliterator;->getModCount(Ljava/util/List;)I
       Ljava8/util/VectorSpliterator;->getModCount(Ljava/util/Vector;)I
       Ljava8/util/VectorSpliterator;->getSize(Ljava/util/Vector;)I

#9: Linking greylist Lsun/misc/Unsafe;->getIntVolatile(Ljava/lang/Object;J)I use(s):
       Ljava8/util/concurrent/ForkJoinPool$MemBar;->loadFence()V

#10: Linking greylist Lsun/misc/Unsafe;->getLongVolatile(Ljava/lang/Object;J)J use(s):
       Ljava8/util/concurrent/ForkJoinPool;->getAndAddLong(Ljava/lang/Object;JJ)J

#11: Linking greylist Lsun/misc/Unsafe;->getObject(Ljava/lang/Object;J)Ljava/lang/Object; use(s):
       Ljava8/util/ArrayDequeSpliterator;->getData(Ljava/util/ArrayDeque;)[Ljava/lang/Object;
       Ljava8/util/ArrayListSpliterator;->getData(Ljava/util/ArrayList;)[Ljava/lang/Object;
       Ljava8/util/ArraysArrayListSpliterator;->getArray(Ljava/util/List;)[Ljava/lang/Object;
       Ljava8/util/COWArrayListSpliterator;->getArray(Ljava/util/concurrent/CopyOnWriteArrayList;)[Ljava/lang/Object;
       Ljava8/util/COWArraySetSpliterator;->getCowArrayList(Ljava/util/concurrent/CopyOnWriteArraySet;)Ljava/util/concurrent/CopyOnWriteArrayList;
       Ljava8/util/HMSpliterators$HashMapSpliterator;->getNextNode(Ljava/lang/Object;)Ljava/lang/Object;
       Ljava8/util/HMSpliterators$HashMapSpliterator;->getNodeKey(Ljava/lang/Object;)Ljava/lang/Object;
       Ljava8/util/HMSpliterators$HashMapSpliterator;->getNodeValue(Ljava/lang/Object;)Ljava/lang/Object;
       Ljava8/util/HMSpliterators$HashMapSpliterator;->getTable(Ljava/util/HashMap;)[Ljava/lang/Object;
       Ljava8/util/HMSpliterators;->getHashMapFromEntrySet(Ljava/util/Set;)Ljava/util/HashMap;
       Ljava8/util/HMSpliterators;->getHashMapFromHashSet(Ljava/util/HashSet;)Ljava/util/HashMap;
       Ljava8/util/HMSpliterators;->getHashMapFromKeySet(Ljava/util/Set;)Ljava/util/HashMap;
       Ljava8/util/HMSpliterators;->getHashMapFromValues(Ljava/util/Collection;)Ljava/util/HashMap;
       Ljava8/util/LBDSpliterator;->getNextNode(Ljava/lang/Object;)Ljava/lang/Object;
       Ljava8/util/LBDSpliterator;->getNodeItem(Ljava/lang/Object;)Ljava/lang/Object;
       Ljava8/util/LBDSpliterator;->getQueueFirst(Ljava/util/concurrent/LinkedBlockingDeque;)Ljava/lang/Object;
       Ljava8/util/LBDSpliterator;->getQueueLock(Ljava/util/concurrent/LinkedBlockingDeque;)Ljava/util/concurrent/locks/ReentrantLock;
       Ljava8/util/LBQSpliterator;->getHeadNext(Ljava/util/concurrent/LinkedBlockingQueue;)Ljava/lang/Object;
       Ljava8/util/LBQSpliterator;->getNextNode(Ljava/lang/Object;)Ljava/lang/Object;
       Ljava8/util/LBQSpliterator;->getNodeItem(Ljava/lang/Object;)Ljava/lang/Object;
       Ljava8/util/LBQSpliterator;->getPutLock(Ljava/util/concurrent/LinkedBlockingQueue;)Ljava/util/concurrent/locks/ReentrantLock;
       Ljava8/util/LBQSpliterator;->getTakeLock(Ljava/util/concurrent/LinkedBlockingQueue;)Ljava/util/concurrent/locks/ReentrantLock;
       Ljava8/util/LinkedListSpliterator;->getFirst(Ljava/util/LinkedList;)Ljava/lang/Object;
       Ljava8/util/LinkedListSpliterator;->getHeader(Ljava/util/LinkedList;)Ljava/lang/Object;
       Ljava8/util/LinkedListSpliterator;->getNextNode(Ljava/lang/Object;)Ljava/lang/Object;
       Ljava8/util/LinkedListSpliterator;->getNodeItem(Ljava/lang/Object;)Ljava/lang/Object;
       Ljava8/util/PQueueSpliterator;->getQueue(Ljava/util/PriorityQueue;)[Ljava/lang/Object;
       Ljava8/util/VectorSpliterator;->getData(Ljava/util/Vector;)[Ljava/lang/Object;
       Ljava8/util/concurrent/ForkJoinPool$WorkQueue;->localHelpCC(Ljava8/util/concurrent/CountedCompleter;I)I
       Ljava8/util/concurrent/ForkJoinPool$WorkQueue;->pop()Ljava8/util/concurrent/ForkJoinTask;
       Ljava8/util/concurrent/ForkJoinPool$WorkQueue;->sharedHelpCC(Ljava8/util/concurrent/CountedCompleter;I)I
       Ljava8/util/concurrent/ForkJoinPool$WorkQueue;->tryRemoveAndExec(Ljava8/util/concurrent/ForkJoinTask;)V (2 occurrences)
       Ljava8/util/concurrent/ForkJoinPool$WorkQueue;->trySharedUnpush(Ljava8/util/concurrent/ForkJoinTask;)Z
       Ljava8/util/concurrent/TLRandom;->createThreadGroup(Ljava/lang/String;)Ljava/lang/ThreadGroup; (2 occurrences)

#12: Linking greylist Lsun/misc/Unsafe;->getObjectVolatile(Ljava/lang/Object;J)Ljava/lang/Object; use(s):
       Ljava8/util/concurrent/ForkJoinPool$WorkQueue;->getAndSetObject(Ljava/lang/Object;JLjava/lang/Object;)Ljava/lang/Object;
       Ljava8/util/concurrent/ForkJoinPool$WorkQueue;->growArray()[Ljava8/util/concurrent/ForkJoinTask;
       Ljava8/util/concurrent/ForkJoinPool$WorkQueue;->poll()Ljava8/util/concurrent/ForkJoinTask;
       Ljava8/util/concurrent/ForkJoinPool;->awaitJoin(Ljava8/util/concurrent/ForkJoinPool$WorkQueue;Ljava8/util/concurrent/ForkJoinTask;J)I
       Ljava8/util/concurrent/ForkJoinPool;->helpAsyncBlocker(Ljava/util/concurrent/Executor;Ljava8/util/concurrent/ForkJoinPool$ManagedBlocker;)V
       Ljava8/util/concurrent/ForkJoinPool;->helpQuiescePool(Ljava8/util/concurrent/ForkJoinPool$WorkQueue;)V
       Ljava8/util/concurrent/ForkJoinPool;->pollScan(Z)Ljava8/util/concurrent/ForkJoinTask;
       Ljava8/util/concurrent/ForkJoinPool;->runWorker(Ljava8/util/concurrent/ForkJoinPool$WorkQueue;)V

#13: Linking greylist Lsun/misc/Unsafe;->objectFieldOffset(Ljava/lang/reflect/Field;)J use(s):
       Ljava8/util/ArrayDequeSpliterator;-><clinit>()V (3 occurrences)
       Ljava8/util/ArrayListSpliterator;-><clinit>()V (3 occurrences)
       Ljava8/util/ArraysArrayListSpliterator;-><clinit>()V
       Ljava8/util/COWArrayListSpliterator;->fieldOffset(Ljava/lang/String;Z)J
       Ljava8/util/COWArraySetSpliterator;-><clinit>()V
       Ljava8/util/HMSpliterators$HashMapSpliterator;-><clinit>()V (5 occurrences)
       Ljava8/util/HMSpliterators;-><clinit>()V (4 occurrences)
       Ljava8/util/LBDSpliterator;-><clinit>()V (4 occurrences)
       Ljava8/util/LBQSpliterator;-><clinit>()V (5 occurrences)
       Ljava8/util/LinkedListSpliterator;-><clinit>()V (5 occurrences)
       Ljava8/util/PQueueSpliterator;-><clinit>()V (3 occurrences)
       Ljava8/util/RASpliterator;-><clinit>()V
       Ljava8/util/VectorSpliterator;-><clinit>()V (3 occurrences)
       Ljava8/util/concurrent/CompletableFuture;-><clinit>()V (3 occurrences)
       Ljava8/util/concurrent/CountedCompleter;-><clinit>()V
       Ljava8/util/concurrent/ForkJoinPool$MemBar;-><clinit>()V
       Ljava8/util/concurrent/ForkJoinPool$WorkQueue;-><clinit>()V
       Ljava8/util/concurrent/ForkJoinPool;-><clinit>()V (2 occurrences)
       Ljava8/util/concurrent/ForkJoinTask;-><clinit>()V
       Ljava8/util/concurrent/Phaser;-><clinit>()V
       Ljava8/util/concurrent/TLRandom;-><clinit>()V (4 occurrences)
       Ljava8/util/concurrent/TLRandom;->createThreadGroup(Ljava/lang/String;)Ljava/lang/ThreadGroup; (2 occurrences)

#14: Linking greylist Lsun/misc/Unsafe;->putInt(Ljava/lang/Object;JI)V use(s):
       Ljava8/util/concurrent/TLRandom;->setUncontendedToTrue(Ljava/lang/Integer;)V

#15: Linking greylist Lsun/misc/Unsafe;->putIntVolatile(Ljava/lang/Object;JI)V use(s):
       Ljava8/util/concurrent/ForkJoinPool$MemBar;->fullFence()V

#16: Linking greylist Lsun/misc/Unsafe;->putObject(Ljava/lang/Object;JLjava/lang/Object;)V use(s):
       Ljava8/util/concurrent/TLRandom;->eraseThreadLocals(Ljava/lang/Thread;)V (2 occurrences)

#17: Linking greylist Lsun/misc/Unsafe;->putObjectVolatile(Ljava/lang/Object;JLjava/lang/Object;)V use(s):
       Ljava8/util/concurrent/ForkJoinPool$WorkQueue;->tryRemoveAndExec(Ljava8/util/concurrent/ForkJoinTask;)V

#18: Linking greylist Lsun/misc/Unsafe;->putOrderedInt(Ljava/lang/Object;JI)V use(s):
       Ljava8/util/concurrent/ForkJoinPool$MemBar;->storeFence()V
       Ljava8/util/concurrent/ForkJoinPool$WorkQueue;->sharedHelpCC(Ljava8/util/concurrent/CountedCompleter;I)I
       Ljava8/util/concurrent/ForkJoinPool$WorkQueue;->trySharedUnpush(Ljava8/util/concurrent/ForkJoinTask;)Z

#19: Linking greylist Lsun/misc/Unsafe;->putOrderedObject(Ljava/lang/Object;JLjava/lang/Object;)V use(s):
       Ljava8/util/concurrent/CompletableFuture;->lazySetNext(Ljava8/util/concurrent/CompletableFuture$Completion;Ljava8/util/concurrent/CompletableFuture$Completion;)V
       Ljava8/util/concurrent/ForkJoinPool$WorkQueue;->push(Ljava8/util/concurrent/ForkJoinTask;)V
       Ljava8/util/concurrent/ForkJoinPool$WorkQueue;->tryRemoveAndExec(Ljava8/util/concurrent/ForkJoinTask;)V
       Ljava8/util/concurrent/TLRandom;->setInheritedAccessControlContext(Ljava/lang/Thread;Ljava/security/AccessControlContext;)V

#20: Reflection greylist-max-p Landroid/animation/LayoutTransition;->cancel use(s):
       Landroidx/transition/ViewGroupUtilsApi14;->cancelLayoutTransition(Landroid/animation/LayoutTransition;)V

#21: Reflection greylist Landroid/app/Activity;->getActivityOptions use(s):
       Lme/imid/swipebacklayout/lib/Utils;->convertActivityToTranslucentAfterL(Landroid/app/Activity;)V

#22: Reflection greylist Landroid/app/Activity;->mMainThread use(s):
       Landroidx/core/app/ActivityRecreator;->getMainThreadField()Ljava/lang/reflect/Field;

#23: Reflection greylist Landroid/app/Activity;->mToken use(s):
       Landroidx/core/app/ActivityRecreator;->getTokenField()Ljava/lang/reflect/Field;

#24: Reflection greylist Landroid/app/ActivityThread;->currentActivityThread use(s):
       Lcom/qiyukf/unicorn/d;->a(Lcom/qiyukf/unicorn/d;Landroid/content/Context;)V

#25: Reflection greylist Landroid/app/ActivityThread;->mInstrumentation use(s):
       Lcom/qiyukf/unicorn/d;->a(Lcom/qiyukf/unicorn/d;Landroid/content/Context;)V

#26: Reflection greylist Landroid/app/Dialog;->mOnKeyListener use(s):
       Landroidx/core/view/KeyEventDispatcher;->getDialogKeyListenerPre28(Landroid/app/Dialog;)Landroid/content/DialogInterface$OnKeyListener;

#27: Reflection greylist Landroid/bluetooth/BluetoothAdapter;->mService use(s):
       Lcom/alipay/security/mobile/module/deviceinfo/b;->a(Landroid/bluetooth/BluetoothAdapter;)Ljava/lang/String;

#28: Reflection greylist Landroid/bluetooth/IBluetooth;->getAddress use(s):
       Lcom/umeng/commonsdk/internal/utils/a;->a(Landroid/bluetooth/BluetoothAdapter;)Ljava/lang/String;

#29: Reflection greylist Landroid/content/res/Resources;->mResourcesImpl use(s):
       Landroidx/appcompat/app/ResourcesFlusher;->flushNougats(Landroid/content/res/Resources;)V

#30: Reflection greylist Landroid/graphics/Typeface;->createFromFamiliesWithDefault use(s):
       Landroidx/core/graphics/TypefaceCompatApi21Impl;->init()V
       Landroidx/core/graphics/TypefaceCompatApi24Impl;-><clinit>()V
       Landroidx/core/graphics/TypefaceCompatApi26Impl;->obtainCreateFromFamiliesWithDefaultMethod(Ljava/lang/Class;)Ljava/lang/reflect/Method;
       Landroidx/core/graphics/TypefaceCompatApi28Impl;->obtainCreateFromFamiliesWithDefaultMethod(Ljava/lang/Class;)Ljava/lang/reflect/Method;

#31: Reflection greylist Landroid/graphics/Typeface;->native_instance use(s):
       Landroidx/core/graphics/TypefaceCompatBaseImpl;->getUniqueKey(Landroid/graphics/Typeface;)J

#32: Reflection greylist Landroid/media/AudioAttributes;->toLegacyStreamType use(s):
       Landroidx/media/AudioAttributesImplApi21;->getAudioAttributesToLegacyStreamTypeMethod()Ljava/lang/reflect/Method;

#33: Reflection greylist Landroid/media/session/MediaSession;->getCallingPackage use(s):
       Landroid/support/v4/media/session/MediaSessionCompatApi24;->getCallingPackage(Ljava/lang/Object;)Ljava/lang/String;

#34: Reflection greylist Landroid/os/Build;->getString use(s):
       Lcom/umeng/commonsdk/internal/utils/a;->g()Ljava/lang/String;

#35: Reflection greylist Landroid/os/Bundle;->getIBinder use(s):
       Landroidx/core/app/BundleCompat$BundleCompatBaseImpl;->getBinder(Landroid/os/Bundle;Ljava/lang/String;)Landroid/os/IBinder;

#36: Reflection greylist Landroid/os/Bundle;->putIBinder use(s):
       Landroidx/core/app/BundleCompat$BundleCompatBaseImpl;->putBinder(Landroid/os/Bundle;Ljava/lang/String;Landroid/os/IBinder;)V

#37: Reflection greylist Landroid/service/media/MediaBrowserService$Result;->mFlags use(s):
       Landroidx/media/MediaBrowserServiceCompatApi26;-><clinit>()V

#38: Reflection greylist Landroid/util/DisplayMetrics;->noncompatHeightPixels use(s):
       Lcom/umeng/commonsdk/statistics/common/DeviceConfig;->getResolutionArray(Landroid/content/Context;)[I

#39: Reflection greylist Landroid/util/DisplayMetrics;->noncompatWidthPixels use(s):
       Lcom/umeng/commonsdk/statistics/common/DeviceConfig;->getResolutionArray(Landroid/content/Context;)[I

#40: Reflection greylist Landroid/view/LayoutInflater;->mFactory2 use(s):
       Landroidx/core/view/LayoutInflaterCompat;->forceSetFactory2(Landroid/view/LayoutInflater;Landroid/view/LayoutInflater$Factory2;)V

#41: Reflection greylist Landroid/view/View;->computeFitSystemWindows use(s):
       Landroidx/appcompat/widget/ViewUtils;-><clinit>()V

#42: Reflection greylist Landroid/view/View;->mAccessibilityDelegate use(s):
       Landroidx/core/view/ViewCompat;->getAccessibilityDelegateThroughReflection(Landroid/view/View;)Landroid/view/View$AccessibilityDelegate;

#43: Reflection greylist-max-p Landroid/view/View;->mViewFlags use(s):
       Landroidx/transition/ViewUtils;->fetchViewFlagsField()V

#44: Reflection greylist-max-p Landroid/view/animation/Animation;->mListener use(s):
       Landroidx/fragment/app/FragmentManagerImpl;->getAnimationListener(Landroid/view/animation/Animation;)Landroid/view/animation/Animation$AnimationListener;

#45: Reflection greylist Landroid/widget/AbsListView;->mIsChildViewEnabled use(s):
       Landroidx/appcompat/widget/DropDownListView;-><init>(Landroid/content/Context;Z)V

#46: Reflection greylist-max-p Landroid/widget/AutoCompleteTextView;->doAfterTextChanged use(s):
       Landroidx/appcompat/widget/SearchView$AutoCompleteTextViewReflector;-><init>()V

#47: Reflection greylist-max-p Landroid/widget/AutoCompleteTextView;->doBeforeTextChanged use(s):
       Landroidx/appcompat/widget/SearchView$AutoCompleteTextViewReflector;-><init>()V

#48: Reflection greylist-max-p Landroid/widget/AutoCompleteTextView;->ensureImeVisible use(s):
       Landroidx/appcompat/widget/SearchView$AutoCompleteTextViewReflector;-><init>()V

#49: Reflection greylist-max-p Landroid/widget/TextView;->getHorizontallyScrolling use(s):
       Landroidx/appcompat/widget/AppCompatTextViewAutoSizeHelper;->autoSizeText()V

#50: Reflection greylist Landroid/widget/TextView;->getLayoutAlignment use(s):
       Landroidx/appcompat/widget/AppCompatTextViewAutoSizeHelper;->suggestedSizeFitsInSpace(ILandroid/graphics/RectF;)Z

#51: Reflection greylist Landroid/widget/TextView;->nullLayouts use(s):
       Landroidx/appcompat/widget/AppCompatTextViewAutoSizeHelper;->setRawTextSize(F)V

#52: Reflection greylist,core-platform-api Lcom/android/org/conscrypt/OpenSSLSocketImpl;->getAlpnSelectedProtocol use(s):
       Lokhttp3/internal/platform/AndroidPlatform;->buildIfSupported()Lokhttp3/internal/platform/Platform;

#53: Reflection greylist,core-platform-api Lcom/android/org/conscrypt/OpenSSLSocketImpl;->setAlpnProtocols use(s):
       Lokhttp3/internal/platform/AndroidPlatform;->buildIfSupported()Lokhttp3/internal/platform/Platform;

#54: Reflection greylist,core-platform-api Lcom/android/org/conscrypt/OpenSSLSocketImpl;->setHostname use(s):
       Lokhttp3/internal/platform/AndroidPlatform;->buildIfSupported()Lokhttp3/internal/platform/Platform;

#55: Reflection greylist,core-platform-api Lcom/android/org/conscrypt/OpenSSLSocketImpl;->setUseSessionTickets use(s):
       Lokhttp3/internal/platform/AndroidPlatform;->buildIfSupported()Lokhttp3/internal/platform/Platform;

#56: Reflection greylist,core-platform-api Ldalvik/system/CloseGuard;->get use(s):
       Lokhttp3/internal/platform/AndroidPlatform$CloseGuard;->get()Lokhttp3/internal/platform/AndroidPlatform$CloseGuard;

#57: Reflection greylist,core-platform-api Ldalvik/system/CloseGuard;->open use(s):
       Lokhttp3/internal/platform/AndroidPlatform$CloseGuard;->get()Lokhttp3/internal/platform/AndroidPlatform$CloseGuard;

#58: Reflection greylist,core-platform-api Ldalvik/system/CloseGuard;->warnIfOpen use(s):
       Lokhttp3/internal/platform/AndroidPlatform$CloseGuard;->get()Lokhttp3/internal/platform/AndroidPlatform$CloseGuard;

#59: Reflection greylist-max-p Ljava/lang/Integer;->value use(s):
       Ljava8/util/concurrent/TLRandom;-><clinit>()V

#60: Reflection greylist Ljava/lang/Thread;->inheritableThreadLocals use(s):
       Ljava8/util/concurrent/TLRandom;-><clinit>()V

#61: Reflection greylist Ljava/lang/Thread;->threadLocals use(s):
       Ljava8/util/concurrent/TLRandom;-><clinit>()V

#62: Reflection greylist Ljava/lang/ThreadGroup;->parent use(s):
       Ljava8/util/concurrent/TLRandom;->createThreadGroup(Ljava/lang/String;)Ljava/lang/ThreadGroup;

#63: Reflection greylist Ljava/util/ArrayDeque;->elements use(s):
       Ljava8/util/ArrayDequeSpliterator;-><clinit>()V

#64: Reflection greylist Ljava/util/ArrayDeque;->head use(s):
       Ljava8/util/ArrayDequeSpliterator;-><clinit>()V

#65: Reflection greylist Ljava/util/ArrayDeque;->tail use(s):
       Ljava8/util/ArrayDequeSpliterator;-><clinit>()V

#66: Reflection greylist Ljava/util/ArrayList;->size use(s):
       Ljava8/util/ArrayListSpliterator;-><clinit>()V

#67: Reflection greylist Ljava/util/Arrays$ArrayList;->a use(s):
       Ljava8/util/ArraysArrayListSpliterator;-><clinit>()V

#68: Reflection blacklist Ljava/util/HashMap$EntrySet;->this$0 use(s):
       Ljava8/util/HMSpliterators;-><clinit>()V

#69: Reflection blacklist Ljava/util/HashMap$KeySet;->this$0 use(s):
       Ljava8/util/HMSpliterators;-><clinit>()V

#70: Reflection blacklist Ljava/util/HashMap$Values;->this$0 use(s):
       Ljava8/util/HMSpliterators;-><clinit>()V

#71: Reflection greylist Ljava/util/HashMap;->modCount use(s):
       Ljava8/util/HMSpliterators$HashMapSpliterator;-><clinit>()V

#72: Reflection greylist Ljava/util/HashMap;->table use(s):
       Ljava8/util/HMSpliterators$HashMapSpliterator;-><clinit>()V

#73: Reflection greylist Ljava/util/HashSet;->map use(s):
       Ljava8/util/HMSpliterators;-><clinit>()V

#74: Reflection greylist Ljava/util/LinkedList;->size use(s):
       Ljava8/util/LinkedListSpliterator;-><clinit>()V

#75: Reflection greylist Ljava/util/PriorityQueue;->modCount use(s):
       Ljava8/util/PQueueSpliterator;-><clinit>()V

#76: Reflection greylist Ljava/util/PriorityQueue;->size use(s):
       Ljava8/util/PQueueSpliterator;-><clinit>()V

#77: Reflection greylist Ljava/util/Vector;->elementData use(s):
       Ljava8/util/VectorSpliterator;-><clinit>()V

#78: Reflection greylist Ljava/util/concurrent/CopyOnWriteArrayList;->elements use(s):
       Ljava8/util/COWArrayListSpliterator;-><clinit>()V

#79: Reflection greylist Ljava/util/concurrent/CopyOnWriteArraySet;->al use(s):
       Ljava8/util/COWArraySetSpliterator;-><clinit>()V

#80: Reflection greylist-max-o Ljava/util/concurrent/LinkedBlockingDeque$Node;->item use(s):
       Ljava8/util/LBDSpliterator;-><clinit>()V

#81: Reflection greylist-max-o Ljava/util/concurrent/LinkedBlockingDeque$Node;->next use(s):
       Ljava8/util/LBDSpliterator;-><clinit>()V

#82: Reflection greylist Ljava/util/concurrent/LinkedBlockingDeque;->first use(s):
       Ljava8/util/LBDSpliterator;-><clinit>()V

#83: Reflection greylist Ljava/util/concurrent/LinkedBlockingDeque;->lock use(s):
       Ljava8/util/LBDSpliterator;-><clinit>()V

#84: Reflection greylist-max-o Ljava/util/concurrent/LinkedBlockingQueue$Node;->item use(s):
       Ljava8/util/LBQSpliterator;-><clinit>()V

#85: Reflection greylist-max-o Ljava/util/concurrent/LinkedBlockingQueue$Node;->next use(s):
       Ljava8/util/LBQSpliterator;-><clinit>()V

#86: Reflection greylist Ljava/util/concurrent/LinkedBlockingQueue;->head use(s):
       Ljava8/util/LBQSpliterator;-><clinit>()V

#87: Reflection greylist Ljava/util/concurrent/LinkedBlockingQueue;->putLock use(s):
       Ljava8/util/LBQSpliterator;-><clinit>()V

#88: Reflection greylist Ljava/util/concurrent/LinkedBlockingQueue;->takeLock use(s):
       Ljava8/util/LBQSpliterator;-><clinit>()V

#89: Reflection greylist Ljava/util/concurrent/atomic/AtomicInteger;->value use(s):
       Ljava8/util/concurrent/ForkJoinPool$MemBar;-><clinit>()V

#90: Reflection greylist Lsun/misc/Unsafe;->allocateInstance use(s):
       Lcom/google/gson/internal/UnsafeAllocator;->create()Lcom/google/gson/internal/UnsafeAllocator;

#91: Reflection greylist Lsun/misc/Unsafe;->theUnsafe use(s):
       Lcom/google/gson/internal/UnsafeAllocator;->create()Lcom/google/gson/internal/UnsafeAllocator;
       Ljava8/util/UnsafeAccess;-><clinit>()V
       Ljava8/util/concurrent/UnsafeAccess;-><clinit>()V

91 hidden API(s) used: 19 linked against, 72 through reflection
       76 in greylist
       3 in blacklist
       4 in greylist-max-o
       8 in greylist-max-p
To run an analysis that can give more reflection accesses, 
but could include false positives, pass the --imprecise flag. 






#20: Linking blacklist Lsun.reflect.Reflection;->isSameClassPackage(Ljava.lang.Class;Ljava.lang.Class;)Z use(s):
#21: Linking blacklist Lsun.reflect.Reflection;->isSameClassPackage(Ljava.lang.ClassLoader;Ljava.lang.String;Ljava.lang.ClassLoader;Ljava.lang.
#23: Linking blacklist Lsun.reflect.Reflection;->verifyMemberAccess(Ljava.lang.Class;Ljava.lang.Class;Ljava.lang.Object;I)Z use(s):
#25: Linking blacklist Lsun.security.action.GetPropertyAction;->run()Ljava.lang.String; use(s):
#35: Linking blacklist Lsun.security.action.GetPropertyAction;->defaultVal:Ljava.lang.String; use(s):
#36: Linking blacklist Lsun.security.action.GetPropertyAction;->theProp:Ljava.lang.String; use(s):
#26: Linking blacklist Lsun.misc.VM;->allowArraySyntax:Z use(s):
#27: Linking blacklist Lsun.misc.VM;->booted:Z use(s):
#28: Linking blacklist Lsun.misc.VM;->defaultAllowArraySyntax:Z use(s):
#29: Linking blacklist Lsun.misc.VM;->directMemory:J use(s):
#30: Linking blacklist Lsun.misc.VM;->finalRefCount:I use(s):
#31: Linking blacklist Lsun.misc.VM;->pageAlignDirectMemory:Z use(s):
#32: Linking blacklist Lsun.misc.VM;->peakFinalRefCount:I use(s):
#33: Linking blacklist Lsun.misc.VM;->savedProps:Ljava.util.Properties; use(s):
#34: Linking blacklist Lsun.misc.VM;->suspended:Z use(s):
#37: Linking blacklist Lsun.security.util.SecurityConstants;->ALL_PERMISSION:Ljava.security.AllPermission; use(s):
#38: Linking blacklist Lsun.security.util.SecurityConstants;->CHECK_MEMBER_ACCESS_PERMISSION:Ljava.lang.RuntimePermission; use(s):
#39: Linking blacklist Lsun.security.util.SecurityConstants;->CREATE_ACC_PERMISSION:Ljava.security.SecurityPermission; use(s):
#42: Linking blacklist Lsun.security.util.SecurityConstants;->GET_COMBINER_PERMISSION:Ljava.security.SecurityPermission; use(s):
#43: Linking blacklist Lsun.security.util.SecurityConstants;->GET_COOKIEHANDLER_PERMISSION:Ljava.net.NetPermission; use(s):
#44: Linking blacklist Lsun.security.util.SecurityConstants;->GET_PD_PERMISSION:Ljava.lang.RuntimePermission; use(s):
#45: Linking blacklist Lsun.security.util.SecurityConstants;->GET_POLICY_PERMISSION:Ljava.security.SecurityPermission; use(s):
#46: Linking blacklist Lsun.security.util.SecurityConstants;->GET_PROXYSELECTOR_PERMISSION:Ljava.net.NetPermission; use(s):
#47: Linking blacklist Lsun.security.util.SecurityConstants;->GET_RESPONSECACHE_PERMISSION:Ljava.net.NetPermission; use(s):
#48: Linking blacklist Lsun.security.util.SecurityConstants;->GET_STACK_TRACE_PERMISSION:Ljava.lang.RuntimePermission; use(s):
#49: Linking blacklist Lsun.security.util.SecurityConstants;->LOCAL_LISTEN_PERMISSION:Ljava.net.SocketPermission; use(s):
#52: Linking blacklist Lsun.security.util.SecurityConstants;->SET_COOKIEHANDLER_PERMISSION:Ljava.net.NetPermission; use(s):
#53: Linking blacklist Lsun.security.util.SecurityConstants;->SET_PROXYSELECTOR_PERMISSION:Ljava.net.NetPermission; use(s):
#54: Linking blacklist Lsun.security.util.SecurityConstants;->SET_RESPONSECACHE_PERMISSION:Ljava.net.NetPermission; use(s):
#55: Linking blacklist Lsun.security.util.SecurityConstants;->SPECIFY_HANDLER_PERMISSION:Ljava.net.NetPermission; use(s):
#56: Linking blacklist Lsun.security.util.SecurityConstants;->STOP_THREAD_PERMISSION:Ljava.lang.RuntimePermission; use(s):
#105: Reflection blacklist Ljava.util.HashMap$EntrySet;->this$0 use(s):
#106: Reflection blacklist Ljava.util.HashMap$KeySet;->this$0 use(s):
#107: Reflection blacklist Ljava.util.HashMap$Values;->this$0 use(s):

## 这里列出的文件可能仍有异常请检查并修正(已经处理过啦)
Map<Integer, Integer> selStuTemp = new HashMap<>(selStu);
/media/tom/document/code/manban/manban-android/app/src/main/java/com/txy/manban/ui/sign/fragment/ThreeDayViewFragment.java
/media/tom/document/code/manban/manban-android/app/src/main/java/com/txy/manban/ui/student/activity/SelectStudentActivity.java



 app/src/main/java/com/txy/manban/app/AuthInterceptor.java app/src/main/java/com/txy/manban/api/bean/MakeUpStudents.java app/src/main/java/com/txy/manban/ext/utils/OsUtils.java app/src/main/java/com/txy/manban/ui/mclass/activity/ClassStudentActivity.java app/src/main/java/com/txy/manban/ui/me/view/StudentSignsFilterPopup.java app/src/main/java/com/txy/manban/api/body/ClassID_StudentIDs.java app/src/main/java/com/txy/manban/ui/student/activity/StudentManageActivity.java app/src/main/java/com/txy/manban/ui/mclass/activity/SelectMakeUpStudentActivity.java app/src/main/java/com/txy/manban/ui/student/activity/SelectStudentActivity.java app/src/main/java/com/txy/manban/ui/mclass/activity/SelectMakeUpClassActivity.java app/src/main/java/com/txy/manban/ui/mclass/activity/SelectMultipleClassActivity.java app/src/main/java/com/txy/manban/ui/me/activity/orgsetting/NotifyRulesTimeActivity.java app/src/main/java/com/txy/manban/ui/me/activity/TradingFlowActivity.java


## 仍需处理的问题
= mutableMapOf()


Linking blacklist Lsun.reflect.Reflection;->isSameClassPackage(Ljava.lang.Class;Ljava.lang.Class;)Z use(s):
Linking blacklist Lsun.reflect.Reflection;->isSameClassPackage(Ljava.lang.ClassLoader;Ljava.lang.String;Ljava.lang.ClassLoader;Ljava.lang.
Linking blacklist Lsun.reflect.Reflection;->verifyMemberAccess(Ljava.lang.Class;Ljava.lang.Class;Ljava.lang.Object;I)Z use(s):
Linking blacklist Lsun.security.action.GetPropertyAction;->run()Ljava.lang.String; use(s):
Linking blacklist Lsun.security.action.GetPropertyAction;->defaultVal:Ljava.lang.String; use(s):
Linking blacklist Lsun.security.action.GetPropertyAction;->theProp:Ljava.lang.String; use(s):
Linking blacklist Lsun.misc.VM;->allowArraySyntax:Z use(s):
Linking blacklist Lsun.misc.VM;->booted:Z use(s):
Linking blacklist Lsun.misc.VM;->defaultAllowArraySyntax:Z use(s):
Linking blacklist Lsun.misc.VM;->directMemory:J use(s):
Linking blacklist Lsun.misc.VM;->finalRefCount:I use(s):
Linking blacklist Lsun.misc.VM;->pageAlignDirectMemory:Z use(s):
Linking blacklist Lsun.misc.VM;->peakFinalRefCount:I use(s):
Linking blacklist Lsun.misc.VM;->savedProps:Ljava.util.Properties; use(s):
Linking blacklist Lsun.misc.VM;->suspended:Z use(s):
Linking blacklist Lsun.security.util.SecurityConstants;->ALL_PERMISSION:Ljava.security.AllPermission; use(s):
Linking blacklist Lsun.security.util.SecurityConstants;->CHECK_MEMBER_ACCESS_PERMISSION:Ljava.lang.RuntimePermission; use(s):
Linking blacklist Lsun.security.util.SecurityConstants;->CREATE_ACC_PERMISSION:Ljava.security.SecurityPermission; use(s):
Linking blacklist Lsun.security.util.SecurityConstants;->GET_COMBINER_PERMISSION:Ljava.security.SecurityPermission; use(s):
Linking blacklist Lsun.security.util.SecurityConstants;->GET_COOKIEHANDLER_PERMISSION:Ljava.net.NetPermission; use(s):
Linking blacklist Lsun.security.util.SecurityConstants;->GET_PD_PERMISSION:Ljava.lang.RuntimePermission; use(s):
Linking blacklist Lsun.security.util.SecurityConstants;->GET_POLICY_PERMISSION:Ljava.security.SecurityPermission; use(s):
Linking blacklist Lsun.security.util.SecurityConstants;->GET_PROXYSELECTOR_PERMISSION:Ljava.net.NetPermission; use(s):
Linking blacklist Lsun.security.util.SecurityConstants;->GET_RESPONSECACHE_PERMISSION:Ljava.net.NetPermission; use(s):
Linking blacklist Lsun.security.util.SecurityConstants;->GET_STACK_TRACE_PERMISSION:Ljava.lang.RuntimePermission; use(s):
Linking blacklist Lsun.security.util.SecurityConstants;->LOCAL_LISTEN_PERMISSION:Ljava.net.SocketPermission; use(s):
Linking blacklist Lsun.security.util.SecurityConstants;->SET_COOKIEHANDLER_PERMISSION:Ljava.net.NetPermission; use(s):
Linking blacklist Lsun.security.util.SecurityConstants;->SET_PROXYSELECTOR_PERMISSION:Ljava.net.NetPermission; use(s):
Linking blacklist Lsun.security.util.SecurityConstants;->SET_RESPONSECACHE_PERMISSION:Ljava.net.NetPermission; use(s):
Linking blacklist Lsun.security.util.SecurityConstants;->SPECIFY_HANDLER_PERMISSION:Ljava.net.NetPermission; use(s):
Linking blacklist Lsun.security.util.SecurityConstants;->STOP_THREAD_PERMISSION:Ljava.lang.RuntimePermission; use(s):

# 我已经解决了的问题：
* blacklist 
* Lsun.misc.VM
* Lsun.security.util.SecurityConstants;
* Lsun.reflect.Reflection;
* Lsun.security.action.GetPropertyAction;

# 在我的项目中的解决方法：
将所有与 HashMap 相关的调用使用别的类替换(android.util包中选)

RxJava 替换  CompletableFuture

[给 Android 开发者的 RxJava 详解 (扔物线)](http://gank.io/post/560e15be2dca930e00da1083)