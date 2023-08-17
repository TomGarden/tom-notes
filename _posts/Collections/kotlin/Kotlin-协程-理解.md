

## 0x00. 官方文档
1. [最新英文版](https://kotlinlang.org/docs/coroutines-guide.html)
2. [略滞后,中文版](https://www.kotlincn.net/docs/reference/coroutines/composing-suspending-functions.html)


## 0x01. 含义&意义 了解

- [Coroutines basics](https://kotlinlang.org/docs/coroutines-basics.html)

**coroutine : 协程**
- 协程式可挂起的计算实例 . 类似线程 , 当执行一段代码块的同时 , 也有其他代码在同时执行. 
然而协程没有绑定到任何线程 , 它可以在一个线程挂起 , 然后在其他线程恢复执行 . 
  - 挂起就类似线程的暂停 . 
  - 可以暂时将写成理解为轻量的线程 , 但是它与线程有很大的不同 . 
    - 关于轻量的更多描述 : 协程比线程消耗更少的系统资源 . 
      可以耗尽 JVM 资源的 线程逻辑 , 如果改用协程执行 , 可能不会超过资源限制 . 
      ```kotlin
      import kotlinx.coroutines.*

      /** 这段代码如果用线程执行 , 会内存溢出或者执行非常缓慢(取决于计算机资源情况) */
      fun main() = runBlocking {
          repeat(50_000) { // launch a lot of coroutines
              launch {
                  delay(5000L)
                  print(".")
              }
          }
      }
      ```


**coroutine builder: 协程构造器 **
- [CoroutineScope.launch{...}](https://kotlinlang.org/api/kotlinx.coroutines/kotlinx-coroutines-core/kotlinx.coroutines/launch.html) 在不阻塞调用线程的前提下启动一个新的协程 , 并返回一个 Job 对象 . 当 Job 被调用 cancel 的时候, 协程也被取消执行 . 有特例(略) . 
  - 只能在 [CoroutineScope](https://kotlinlang.org/api/kotlinx.coroutines/kotlinx-coroutines-core/kotlinx.coroutines/-coroutine-scope/) 调用
- [runBlocking{...}](https://kotlinlang.org/api/kotlinx.coroutines/kotlinx-coroutines-core/kotlinx.coroutines/run-blocking.html) 在阻塞调用线程的前提下启动一个新协程 , 直到协程执行完毕取消阻塞 . 
  - 它可以将非协程(花括号外的代码)代码与协程(花括号内的代码)代码桥接 . 


**Structured concurrency: 结构化并发** , 协程遵循结构化并发原则
- 新的协程只能在 [CoroutineScope](https://kotlinlang.org/api/kotlinx.coroutines/kotlinx-coroutines-core/kotlinx.coroutines/-coroutine-scope/) 内启动 , CoroutineScope 界定了协程的代码的边界 . 
- 在真实的应用程序中 , 我们会启动许多的写成 . 结构化并发可以我们集中管理协程, 不遗漏不泄露 . 
- 也能保证 CoroutineScope 范围内的异常不丢失. (写下这行时我还不直达这个细节是什么)

**关键字 suspend**
- 修饰函数的时候表示函数是可挂起的 , 可挂起函数可以在 CoroutineScope 内调用 . 
- 同样的在 可挂起函数 内部可以调用其他可挂起函数 例如 `delay`



## 0x02. [常用情景: 网络请求(不阻塞线程或回调)](https://kotlinlang.org/docs/coroutines-and-channels.html)







## 疑问?

- 协程代码块内的先后顺序逻辑是什么规则 . 
- 数据 跨 携程/线程 共享 , 细节 . 