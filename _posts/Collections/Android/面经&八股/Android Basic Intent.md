## 0x01. [Intent](https://developer.android.com/guide/components/intents-common?hl=zh_cn)

Intent 是对要执行的动作的抽象描述 . 
它可以和 `startActivity` 一起使用用于启动 Activity ;
BroadcastIntent 可以被发送给任何感兴趣的 BroadcastReceiver 组件 ;
`Context.startService(Intent)` 或者 `Context.bindService(Intent, BindServiceFlags, Executor, ServiceConnection)` 可以与处于后台的 `Service` 交流 . 

An Intent provides a facility for performing late runtime binding between the code in different applications.
它最重要的用途是启动 Activity , 它可以看做是 Activity 之间的胶水 . 
Intent 基本上是一个被动的数据结构 , 它持有一个将要被执行动作的抽象描述. 


## [Intent 携带数据尺寸限制](https://github.com/Moosphan/Android-Daily-Interview/issues/151)

经验之谈 : 是有尺寸限制的 , 当携带的数据量过大的时候会报异常 : `TransactionTooLargeException` . 

道听途说原理 :
- Intent 中的 Bundle 是使用 Binder 机制进行数据传送的, 数据会写到内核空间, Binder 缓冲区域;
- Binder 的缓冲区是有大小限制的, 有些 ROM 是 1M, 有些 ROM 是 2M;
- 这个限制定义在 frameworks/native/libs/binder/processState.cpp 类中, 如果超过这个限制, 系统就会报错;
  - `#define BINDER_VM_SIZE ((1*1024*1024) - (4096 *2)) ;`
- 因为 Binder 本身就是为了进程间频繁-灵活的通信所设计的, 并不是为了拷贝大量数据;
- 如果非 ipc 就很简单了, static 变量, eventBus 之类的都可以;
- 如果是 ipc, 一定要一次性传大文件, 可以用 file 或者 socket;
- 别直接传，比如通过MemoryFile开辟一片共享内存，然后传递FileDescriptor，接收端用这个fd读