Observable 类是 non-backpressured, 基于 reactive 类提供的工厂方法操作多个值， 中间操作员具有使用同步或者异步流的能力。

许多操作者类接收 ObservableSource(s)， 基本反应接口为每一个 non-backpressured 流 ， Observable 自身实现的很好。

Observable 的操作者运行时默认绑定一个 128 元素的缓冲区(查看  Flowable.bufferSize())，它的具体值可以使用系统全局参数 rx2.buffer-size 覆盖。
但是，大多数运算符都具有允许显式设置其内部缓冲区大小的重载。

这个类的设计遵循反应流设计规范。

Observable 遵循如协议： ` onSubscribe onNext* (onError | onComplete)? `

这其中， stream 能被一次性的实例链接最终提供诶 Observer.onSubscribe 进行消耗。

不像 Observable 在版本 1.x 的 `subscribe(Observer)` 不允许外部的处置， 同事 


### `onNext` 、 `onComplete` 、 `onError` 切换线程


## reference
- https://juejin.im/post/5abf6c43518825558a06c03f
- https://blog.csdn.net/carson_ho/article/details/78315696

