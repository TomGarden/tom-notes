# TCP/IP - Http - Socket
## 一、TCP/IP
TCP/IP 是什么，如果了解细节需要太多时间我至少需要知道的是：
1. TCP/IP 能做什么？
2. TCP/IP 如何使用？

### 1.1、 TCP/IP 能做什么 / 是什么
Transmission Control Protocol/Internet Protocol的简写，中译名为传输控制协议/因特网互联协议，又名网络通讯协议，是Internet最基本的协议、Internet国际互联网络的基础，由网络层的IP协议和传输层的TCP协议组成。TCP/IP 定义了电子设备如何连入因特网，以及数据如何在它们之间传输的标准。协议采用了4层的层级结构，每一层都呼叫它的下一层所提供的协议来完成自己的需求。通俗而言：TCP负责发现传输的问题，一有问题就发出信号，要求重新传输，直到所有数据安全正确地传输到目的地。而IP是给因特网的每一台联网设备规定一个地址。

### 1.2、如何使用
通常我们不直接使用 TCP/IP 协议,我们间接使用它。

我们的网络通信常用的有 HTTP / Socket 两种方式：
1. HTTP : 尽管TCP/IP协议是互联网上最流行的应用，HTTP协议并没有规定必须使用它和（基于）它支持的层。 事实上，HTTP可以在任何其他互联网协议上，或者在其他网络上实现。HTTP只假定（其下层协议提供）可靠的传输，任何能够提供这种保证的协议都可以被其使用。
    - 但是当前绝大多数的 HTTP 协议的实现和使用还是依赖 TCP/IP 协议的。
    - 我们平时所使用的 HTTP 通信 API 是我们接触 HTTP 最近的地方了。
2. SOCKET : socket本质是编程接口(API)，对TCP/IP的封装，TCP/IP也要提供可供程序员做网络开发所用的接口，这就是Socket编程接口。
    - 使用 Socket API 进行网络通信是我们触碰 TCP/IP 一个相对很近的地方。
3. TCP/IP 也是提供 API 的只是还没有用过，现实中也还没有必要的需求。

## 二、小结
1. TCP/IP : 是两个(或者若干个)协议。
    - 操作系统提供网络开发所需要的编程接口(API)
2. HTTP : 是一个依赖 TCP/IP  的协议。
    - 虽然理论上也可以不依赖 TCP/IP 。
3. Socket : 是一组 API 对系统所提供的 TCP/IP API 的封装。


## 三、存疑
下述三点的详细区分和细节了解：
1. TCP/IP 协议族
2. TCP/IP 协议栈
3. TCP/IP 参考模型




## 参考 & 引用
1. [TCP/IP协议](https://baike.baidu.com/item/TCP%2FIP%E5%8D%8F%E8%AE%AE/212915?fr=aladdin)
2. [socket （计算机专业术语）](https://baike.baidu.com/item/socket/281150?fr=aladdin)
3. [http](https://baike.baidu.com/item/http/243074?fr=aladdin&fromid=1276942&fromtitle=HTTP%E5%8D%8F%E8%AE%AE)
4. [TCP/IP、Http、Socket的区别?](https://www.zhihu.com/question/39541968 )


