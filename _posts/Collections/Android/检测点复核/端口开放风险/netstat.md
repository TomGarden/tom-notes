# 关于 netstat 命令的一些了解
>2017-12-6 17:00:32

在使用 netstat 的时候发现了存在几种不同的 Protocol(协议) 针对我们正在使用的功能，更进一步的了解一些边缘信息是有必要的。

netstat 命令的作用 ：Netstat 程序显示Linux网络子系统的信息。

## 一、关于几个协议的了解
当前了解到的 netstat 命令有可能显示出来的几种协议包括：tcp / udp / unix / raw

1. unix 是用于同一台机器中不同进程间的通信协议。
2. raw 可以拦截并处理传输层以下的数据包并进行处理，但是具体工作的层次尚不清晰。
3. tcp / udp 工作在传输层的协议

## 二、 关于参数细节辨析
```
-a, --all
   Show both listening and non-listening sockets.  With the --interfaces option, show interfaces that are not up
   显示所有 socket 包括处于 LISTEN 状态的和不处于 LISTEN 状态的端口。
-l, --listening
   Show only listening sockets.  (These are omitted by default.)
   显示展示 LISTEN 状态的socket。(默认不显示)
```
关于 socket 状态：
```
State

套接字的状态。因为在RAW协议中没有状态，而且UDP也不用状态信息，所以此行留空。通常它为以下几个值之一：

ESTABLISHED
    套接字有一个有效连接。
SYN_SENT
    套接字尝试建立一个连接。
SYN_RECV
    从网络上收到一个连接请求。
FIN_WAIT1
    套接字已关闭，连接正在断开。
FIN_WAIT2
    连接已关闭，套接字等待远程方中止。
TIME_WAIT
    在关闭之后，套接字等待处理仍然在网络中的分组
CLOSED
    套接字未用。
CLOSE_WAIT
    远程方已关闭，等待套接字关闭。
LAST_ACK
    远程方中止，套接字已关闭。等待确认。
LISTEN
    套接字监听进来的连接。如果不设置 --listening (-l) 或者 --all (-a) 选项，将不显示出来这些连接。
CLOSING
    套接字都已关闭，而还未把所有数据发出。
UNKNOWN
    套接字状态未知。
```








## 参考 & 引用
1. [UNIX域套接字及TCP、UDP示例](http://blog.csdn.net/bytxl/article/details/47861469)
2. [Linux IPC udp/tcp/UNIX域 socket编程](http://www.linuxidc.com/Linux/2016-11/136759.htm)
3. [netstat](http://linux.51yip.com/search/netstat)
4. [TCP/IP模型及OSI七层参考模型各层的功能和主要协议](https://www.cnblogs.com/z-sm/p/7501549.html)
    - http://blog.csdn.net/world_hope/article/details/48377723
    - http://blog.csdn.net/htyurencaotang/article/details/11473015
5. ![OSI 七层架构.gif](Image/OSI七层架构.gif)