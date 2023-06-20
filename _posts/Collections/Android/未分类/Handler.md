



## 0x01. [Handler](https://developer.android.com/reference/kotlin/android/os/Handler)

一个 Handler 允许你通过 MessageQueue 发送 Message 和 执行 和 Runable 。
每一个 Handler 实例和一个单独的线程以及该线程的消息队列相关。
当你创建 Handler 的时候 , 这个 Handler 会与 一个 Looper 绑定 . 
它会将消息和可运行对象传递到该 Looper 的消息队列，并在该 Looper 的线程上执行它们。

Handler 有两个主要的用途：
1.  将消息放到 message queue，并在想来的某个事件执行该消息；
2.  在另一个线程中执行动作。

通过这些方法将 message 安排到日程中：`post(Runnable)`, `postAtTime(Runnable, long)`, `postDelayed(Runnable, Object, long)`, `sendEmptyMessage(int)`, `sendMessage(Message)`, `sendMessageAtTime(Message, long)`, 和 `sendMessageDelayed(Message, long)`。
post 方法允许你将 Runable 对象排到队列中，当 message queue 接收到之后会调用它；
sendMessage 允许你将 Message 对象排到队列中，Message 对象中包含一个 bundle 数据包，Handler 的 handleMessage(Message) 方法将会处理这些数据(需要你实现 Hamdler 的一个子类)。

当传递一个消息到 Handler 的时候，只要 message queue 已经被准备停当，你能选择立刻执行这个消息，或者指定延时执行。
后者允许你实现超时，计时，以及其他基于时间的行为。

当系统为你的 app 创建一个进程的时候，它的主线程会专门运行一个 message queue 去管理 app 顶级对象(activities,broacase receivers,等)以及它们创建的 windows。
你能创建你自己的线程并且通过一个 Handler 和 app 的主线程交互。
这个交互动作是通过在新线程中调用 `post` 和 `sendMessage` 完成的 . 
给定的 Runable 或者 Message 将会被排到 Handler 的 message queue 并且在适当的时候被执行。

## 0x02. [MessageQueue](https://developer.android.com/reference/kotlin/android/os/MessageQueue)

低级类 , 持有一个可以被 Looper 派发的 Message 列表 . 
Message 是不能直接被放到 MesssageQueue 的 , 需要通过与 Looper 关联的 Handler 完成 .  

您可以使用 Looper.myQueue() 检索当前线程的 MessageQueue . 

## 0x03. [Looper](https://developer.android.com/reference/kotlin/android/os/Looper)

此类用于为线程执行消息循环 . 
线程本身是没有消息循环能力的 ; 要创建一个，请在要运行循环的线程中调用 `Looper.prepare();`, 然后循环以让它处理消息，直到循环停止 . 

大多数与消息循环的交互是通过 Handler 类进行的。

这是一个Looper线程实现的典型例子，利用prepare和loop的分离，创建一个初始的Handler来与Looper通信。

```java
class LooperThread extends Thread {
       public Handler mHandler;
 
       public void run() {
           Looper.prepare();
 
           mHandler = new Handler(Looper.myLooper()) {
               public void handleMessage(Message msg) {
                   // process incoming messages here
               }
           };
 
           Looper.loop();
       }
   }
```

## 0x04. [Message](https://developer.android.com/reference/kotlin/android/os/Message)

定义包含描述和任意数据对象的消息，该消息可以发送到Handler. 该对象包含两个额外的 int 字段和一个额外的 object 字段，允许您在许多情况下不进行分配。

虽然 Message 的构造函数是公共的，但获得其中一个的最佳方法是调用 #obtain 或 android.os.Handler#obtainMessage 方法之一，这将从回收对象池中提取它们。

## 0x05. 最简单的应用 

```kotlin
class ThreadOne: Thread() {

    companion object {
        /* 单例 */
        val instance: ThreadOne by lazy(LazyThreadSafetyMode.SYNCHRONIZED) { ThreadOne().apply { start() } }
    }

    private lateinit var handler :Handler /* 稍候初始化 */

    override fun run() {
        Looper.prepare() /* ① 将当前线程初始化为循环事件处理线程, 
                               在 looper 运行之前便有了机会创建与 Looper 关联的 Handler ; 
                               记得要退出 looper.quiteXxx() 
                               
                               此函数的实现决定了 , 与当前线程绑定到 Looper 只能有一个 ; 
                               线程与 Looper 的绑定是通过 ThreadLocal<Looper> 完成的 ; 

                               prepare 会创建一个 Looper() 对象 , Looper 对象的创建 会在内部持有一个 MessageQueue 

                               */
        super.run()

        /* 用 Looper 初始化 Handler */
        handler = object : Handler(Looper.myLooper()!!) {     /* ② myLooper() 就是从 ThreadLocal 变量中取出 Looper 
                                                                    通过 Looper 初始化 Handler 的时候 , 
                                                                    Handler 会同时持有 Looper 内部的 MessageQueue 
                                                                    方便后续将 Message 交给 Message Queue 
                                                                    */  
            override fun handleMessage(msg: Message) {
                super.handleMessage(msg)

                val msgStr =  "msg.what : ${msg.what} \n" +
                         "msg.what : ${msg.arg1} \n" +
                         "msg.what : ${msg.arg2} \n" +
                         "msg.what : ${msg.obj as String}"
                Logger.d(msgStr)
            }

        }

        Looper.loop() /* ③ 启动 looper , 死循环遍历 MessageQueue 内的 Message 单链表 ; 
                            Message 持有 Handler 实例 , 遍历 MessageQueue, 并派发 Msg 即可消费 Msg */
    }

    fun quite() = Looper.myLooper()?.quitSafely()

    fun getHandler(): Handler? = if (this::handler.isInitialized) handler else null

}

class ThreadTwo(val str:String):Thread(){

    companion object {
        fun sendMsg(str: String) = ThreadTwo(str).start()
    }

    override fun run() {
        super.run()
        ThreadOne.instance.getHandler()?.let { handler->
            Logger.i(str)
            handler.sendMessage(handler.obtainMessage().apply { obj = str }) 
            /* ④ 在 同步锁代码块内 , 将 Message 放到 MessageQueue ; 等待 Looper 遍历 .
                  Message 本身是单链表的节点 */
        }
    }
}

/* ⑤ 向 Message 单链表内插入节点和取出节点的代码都在 同步代码块内; 由此保证了线程安全 */


/* 


    A hold B : A 持有 B

                           ┌─────────────┐
                           │             │
                    ┌─────►│   Thread    │
                    │      │             │
                    │      └─────────────┘
                   hold
     ┌────────────┐ │      ┌─────────────────┐       ┌─────────────┐
     │            ├─┘      │                 │       │             │
     │   Looper   │        │   MessageQueue  ├─hold─►│   Message   │
     │            ├──hold─►│                 │       │             │
     └────────────┘        └─────────────────┘       └─────┬───────┘
        ▲                        ▲                         │
        │                        │                         │hold
        │hold                    │hold                     ▼
     ┌──┴────────────────────────┴─────────────────────────────────┐
     │                                                             │
     │                          Handler                            │
     │                                                             │
     └─────────────────────────────────────────────────────────────┘


                                    获取 msgQueue 持有的 msg 链表 头部的 msg
                                                   ▲
                                                   │
                                                   │
                                                   │
┌────────────────────────────────────────┐         │          ┌─────────────────────┐
│                                        │         │          │                     │
│                Looper                  │  get msg from msg  │     MessageQueue    │
│                                        │  link table start  │                     │    ┌─────────┐
│ ┌────────────────────────────────────┐ │  by msgQueue       │    ┌───────────┐    │    │         │
│ │            mQueue.next()           │◄├====================┼====┤  Message  │    │    │ Handler │
│ └┬───────────────────────────────────┘ │                    │    └──┬────────┘    │    │         │
│  │                                  ▲  │                    │       │next         │    └────┬────┘
│  │      ┌─────────◄─────────┐       │  │                    │    ┌──▼────────┐    │         │
│  │      ▼  Infinite loop    ▲       │  │                    │    │  Message  │    │         │
│  │      └─────────►─────────┘       │  │                    │    └──┬────────┘    │         │
│  │         　　无限循环               │  │                    │       │next         │         │
│  │                                  │  │                    │    ┌──▼────────┐    │         │postMsg
│  │                                  │  │                    │    │  Message  │    │         │
│  │                                  │  │                    │    └───────────┘    │         │sendMsg
│  │ ┌──────────────────────────────┐ │  │                    │                     │         │
│  │ │        msg.callback          │ │  │                    │         .           │         │
│  │ │                              │ │  │                    │         .           │         │
│  │ │             or               │ │  │                    │         .           │         │
│  │ │                              │ │  │                    │    ┌───────────┐    │         │
│  │ │ handler.mCallback.handleMsg  │ │  │                    │    │  Message  │ ◄──┼─────────┘
│  └►│                              ├─┘  │                    │    └───────────┘    │
│    │             or               │    │                    │                     │
│    │                              │    │                    └─────────────────────┘
│    │      handler.handleMsg       │    │
│    │                              │    │
│    └──────────────────────────────┘    │
│                                        │
└────────────────────────────────────────┘

 */



```

### 5.1. [ThreadLocal](https://developer.android.com/reference/kotlin/java/lang/ThreadLocal?hl=en)

该类为线程提供相对于线程的本地变量 . 
这些变量不同于普通变量之处在于 , 每个线程要访问这个本地变量的时候 , 都会有针对该线程的独立初始化的版本 . (非多线程共享 , 每个线程要使用就会在该线程内独立初始化) . 
`ThreadLocal` 通常是类中的 `private static` 变量 , 它希望把某个状态(泛型对象)与线程关联起来 . 

可以参考下 : https://pdai.tech/md/java/thread/java-thread-x-threadlocal.html

### 5.2. [HandlerThread](https://developer.android.com/reference/android/os/HandlerThread)

一个持有 Looper 的 Thread . 
这个 Looper 可以被用于创建 Handler . 
和常规 Thread 一样 , 要启动它需要调用 `Thread.start()`

## 0x06. [IBinder](https://developer.android.com/reference/android/os/IBinder)

远程对象基本接口，为高效进程内或者扩进程通信效用设计的轻量级远程程序调用机制的核心部分。
这个接口描述了与远程对象交互的抽象协议。
不要直接实现本接口，如有需要可以继承 Binder 。

IBinder 中关键的 API 是 transact() 方法(和 Binder.onTransact() 相对应)。
这个方法分别允许你向 IBinder 对象发送一个调用，以及接收一个来自 Binder 对象的调用。
这个发送 API 是同步的，即，当你调用 transact() 方法后，直到目标完成 Binder.onTransact() 方法调用你才会等到 return ；这是调用本地进程时的预期行文，并且底层的进程间通信机制(IPC)确保本 API 在跨进程使用的时候会有相同的语义。

通过 transact() 发送的数据是一个 Parcel 对象(一个通用的数据缓存器)，其中存储了一些元数据。
缓存中的元数据被用于管理 IBinder 对象引用，所以这些引用可以被缓存并且跨进程传递。
这种机制确保了当一个 IBinder 被写入 Parcel 并且发送到另一个进程中的时候，如果后者将接收到的 IBinder 引用发送回原进程，则原进程将接收到相同的 IBinder 对象。
这些语义允许 IBinder/Binder 对象被作为唯一身份标识(存储token或者用作其它目的)被跨进程管理。

系统中每一个进程都持有一个事务线程池。
这些线程被用于调度所有来自其它进程的 IPCs 。
例如，当一个 IPC 从进程 A 发送到进程 B，调用线程被阻塞在方法 transact() ,因为它将事务发送到进程 B 了。
接下来进程 B 中的线程池总可用的线程接收到到来的事务，并且调用 Binder.onTransact() 方法处理目标对象，然后通过 Parcel 将处理结果返回。
进程 A 从 transact() 方法的返回值中接收到结果，进程 A 的阻塞状态被解除，进程 A 继续执行。
事实上，在其他进程中使用了额外的线程做了某些操作，而非在当前进程中。

Binder 体系也支持跨进程递归。
例如，如果进程 A 执行一个 transaction 到进程 B ，然后进程 B 获取到消息后调用了一个在进程 A 中实现的 IBinder， 此时进程 A 正在等待原来的 transaction 结果的状态被终结进而去调用 Binder.onTransact() 处理来自进程 B 的调用。
这确保了调用远程 binder 对象的递归语义与调用本地对象的递归语义相同。

当使用远程对象工作的时候，你经常希望了解它是否还是有效的对象。
这里有三个方法帮助你确定：
1.  如果你尝试在 IBinder 对象中调用一个已经不进程的对象 transact() 方法将会抛出 RemoteException 异常
2.  如果远程对象不存了调用 pingBinder() 将会 return false 。
3.  linkToDeath() 方法能携带一个 IBinder 对象注册与 IBinder.DeathRecipient ，当远程进程不存在的时候，这个这个方法将会被回调。


## 0x07. [Binder](https://developer.android.com/reference/android/os/Binder)

远程对象基类 , IBinder 定义的轻量级远程过程调用机制的核心部分 . 
此类事 IBinder 的实现 , 它提供了此类对象的标准实现 . 

大多数开发者不用直接实现这个类 , 可以通过 [aidl](https://developer.android.com/guide/components/aidl?hl=zh-cn) 描述想要的接口 , 进而生成合适的 Binder 子类 . 
你可以直接继承 Binder 实现自己的 [RPC](https://zh.wikipedia.org/wiki/遠程過程調用) 协议 , 或者可以直接使用 Binder 的实例 作为可以跨进程共享的 令牌 . 

本类只是基本的 IPC 原语 ; 它不影响应用的生命周期 , 只有创建 Binder 的进程在持续运行的时候 Binder 才是有效的 . 
要正确使用它，你必须在顶级应用程序组件（Service、Activity或 ContentProvider）的上下文中让系统知道你的进程应该保持运行 .

你必须考虑你的进程可以回消失的情况 , 因此 , 需要你在进程重启后重新创建新的 Binder 并且重新绑定到进程上 . 
例如 , 如果你正在使用一个 Actiity , 你的 Activity 进程可能在任何时间被杀死 , 如果稍候 Activity 重启了 , 你需要重新创建新的 Binder 并把它放到正确的位置 ;
你的进程可能因为其他的原因被启动(例如 接收到了 Broadcast)这将不会调用 re-create Activity , 因此需要执行创建 Binder 的代码 . 

### 7.1. `public static final long clearCallingIdentity()`

在当前线程上重置传入 IPC 的标志 . 





## 参考
1. 源代码 + 文档