文本拷贝(转载)自 : 
1. https://github.com/mirsking/swe/blob/master/source/NetworkProgramming/ReactorAndProactor.md
2. https://swe.mirsking.com/networkprogramming/reactorandproactor

boost_asio 库文档描述了 Proactor 的优缺点 . 
https://www.boost.org/doc/libs/1_81_0/doc/html/boost_asio/overview/core/async.html#boost_asio.overview.core.async.proactor_and_boost_asio

需要辩证的看待优缺点 , 应为如果在意的点不同 , 情景 A 下的缺点有可能是情景 B 下的优点 . 

# 两种高性能IO设计模式Reactor和Proactor

## 综述

这篇文章探讨并比较两种用于TCP服务器的高性能设计模式。 除了介绍现有的解决方案，还提出了一种更具伸缩性，只需要维护一份代码并且跨平台的解决方案(含代码示例)，以及其在不同平台上的微调。 此文还比较了java、c#、c++对各自现有以及提到的解决方案的实现性能。

系统I/O可分为**阻塞型，非阻塞同步型以及非阻塞异步型**[1、2]。

* 阻塞型I/O意味着控制权只到调用操作结束了才会回到调用者手里。 结果调用者被阻塞了，这段时间了做不了任何其它事情。 更郁闷的是，在等待IO结果的时间里，调用者所在线程此时无法腾出手来去响应其它的请求，这真是太浪费资源了。拿read()操作来说吧，调用此函数的代码会一直僵在此处直至它所读的socket缓存中有数据到来。

* 非阻塞同步是会立即返回控制权给调用者的。调用者不需要等等，它从调用的函数获取两种结果：要么此次调用成功进行了;要么系统返回错误标识告诉调用者当前资源不可用，你再等等或者再试度看吧。比如read()操作， 如果当前socket无数据可读，则立即返回EWOULBLOCK/EAGAIN，告诉调用read()者”数据还没准备好，你稍后再试”。

* 在非阻塞异步调用中，稍有不同。调用函数在立即返回时，还告诉调用者，这次请求已经开始了。系统会使用另外的资源或者线程来完成这次调用操作，并在完成的时候知会调用者（比如通过回调函数）。拿Windows的ReadFile()或者POSIX的aio_read()来说，调用它之后，函数立即返回，操作系统在后台同时开始读操作。

在以上三种IO形式中，非阻塞异步是性能最高、伸缩性最好的。

这篇文章探讨不同的I/O利用机制并提供一种跨平台的设计模式(解决方案)。希望此文可以给于TCP高性能服务器开发者一些帮助，选择最佳的设计方案。下面我们会比较Java、C#、C++各自对探讨方案的实现以及性能。我们在文章的后面就不再提及阻塞式的方案了，因为阻塞式I/O实在是缺少可伸缩性，性能也达不到高性能服务器的要求。

## 两种IO多路复用方案:Reactor and Proactor

一般情况下，I/O复用机制需要**事件分享器(event demultiplexor [1、3])**。 事件分享器的作用，即将那些读写事件源分发给各读写事件的处理者，就像送快递的在楼下喊:谁的什么东西送了，快来拿吧。开发人员在开始的时候需要在分享器那里注册感兴趣的事件，并提供相应的处理者(event handlers)，或者是回调函数; 事件分享器在适当的时候会将请求的事件分发给这些handler或者回调函数。

涉及到事件分享器的两种模式称为：Reactor and Proactor[1]。

* **Reactor模式**是基于**同步I/O**的，而Proactor模式是和异步I/O相关的。 在Reactor模式中，事件分离者等待某个事件或者可应用或个操作的状态**发生**（比如文件描述符可读写，或者是socket可读写），事件分离者就把这个事件传给事先注册的事件处理函数或者回调函数，由后者来做实际的读写操作。

* **Proactor模式**中，事件处理者(或者代由事件分离者发起)直接发起一个异步读写操作(相当于请求)，而实际的工作是由操作系统来完成的。发起时，需要提供的参数包括用于存放读到数据的缓存区，读的数据大小，或者用于存放外发数据的缓存区，以及这个请求完后的回调函数等信息。事件分离者得知了这个请求，它默默等待这个请求的**完成**，然后转发完成事件给相应的事件处理者或者回调。举例来说，在Windows上事件处理者投递了一个**异步IO**操作(称有overlapped的技术)，事件分离者等IOCompletion事件完成[1]。 这种异步模式的典型实现是基于操作系统底层异步API的，所以我们可称之为“系统级别”的或者“真正意义上”的异步，因为具体的读写是由操作系统代劳的。

举另外个例子来更好地理解Reactor与Proactor两种模式的区别。这里我们只关注read操作，因为write操作也是差不多的。

### Reactor的做法：
1. 某个事件处理者宣称它对某个socket上的读事件很感兴趣;
2. 事件分离者等着这个事件的**发生**;
3. 当事件发生了，事件分离器被唤醒，这负责通知先前那个事件处理者;
4. 事件处理者收到消息，于是**去那个socket上读数据**了。 如果需要，它再次宣称对这个socket上的读事件感兴趣，一直重复上面的步骤;

### 异步模式Proactor的做法：
1. 事件处理者直接投递发一个写操作(当然，操作系统必须支持这个异步操作)。 这个时候，事件处理者根本不关心读事件，它只管发这么个请求，它魂牵梦萦的是这个写操作的完成事件。这个处理者很拽，发个命令就不管具体的事情了，只等着别人（系统）帮他搞定的时候给他回个话。
2. 事件分离者等着这个读事件的**完成**(比较下与Reactor的不同);
3. 当事件分离者默默等待完成事情到来的同时，操作系统已经在一边开始干活了，它从目标读取数据，放入用户提供的缓存区中，最后通知事件分离者，这个事情我搞完了;
4. 事件分享者通知之前的事件处理者: 你吩咐的事情搞定了;
5. 事件处理者这时会发现想要读的数据已经乖乖地放在他提供的缓存区中，想怎么处理都行了。如果有需要，事件处理者还像之前一样发起另外一个写操作，和上面的几个步骤一样。

## 现行做法

开源C++开发框架ACE[1、3](Douglas Schmidt, et al.开发) 提供了大量平台独立的底层并发支持类(线程、互斥量等)。同时在更高一层它也提供了独立的几组C++类，用于实现Reactor及Proactor模式。 尽管它们都是平台独立的单元，但他们都提供了不同的接口。

ACE Proactor在MS-Windows上无论是性能还在健壮性都更胜一筹，这主要是由于Windows提供了一系列高效的底层异步API。[4、5]。

(这段可能过时了点吧)不幸的是，并不是所有操作系统都为底层异步提供健壮的支持。举例来说，许多Unix系统就有麻烦。因此，ACE Reactor可能是Unix系统上更合适的解决方案。正因为系统底层的支持力度不一，为了在各系统上有更好的性能，开发者不得不维护独立的好几份代码:为Windows准备的ACE Proactor以及为Unix系列提供的ACE Reactor。

就像我们提到过的，真正的异步模式需要操作系统级别的支持。由于事件处理者及操作系统交互的差异，为Reactor和Proactor设计一种通用统一的外部接口是非常困难的。这也是设计通行开发框架的难点所在。

## 更好的解决方案

在文章这一段时，我们将尝试提供一种融合了Proactor和Reactor两种模式的解决方案。 为了演示这个方案，我们将Reactor稍做调整，模拟成异步的Proactor模型(主要是在事件分离器里完成本该事件处理者做的实际读写工作，我们称这种方法为”模拟异步“)。 下面的示例可以看看read操作是如何完成的:

1. 事件处理者宣称对读事件感兴趣，并提供了用于存储结果的缓存区、读数据长度等参数;
2. 调试者等待(比如通过select());
3. 当有事件到来(即可读)，调试者被唤醒， 调试者去执行非阻塞的读操作(前面事件处理者已经给了足够的信息了)。读完后，它去通知事件处理者。
4. 事件处理者这时被知会读操作已完成，它拥有完整的原先想要获取的数据了。
5. 我们看到，通过为分离者(也就上面的调试者)添加一些功能，可以让Reactor模式转换为Proactor模式。所有这些被执行的操作，其实是和Reactor模型应用时完全一致的。我们只是把工作打散分配给不同的角色去完成而已。这样并不会有额外的开销，也不会有性能上的的损失，我们可以再仔细看看下面的两个过程，他们实际上完成了一样的事情：

### 标准的经典的 Reactor模式:

* 步骤 1) 等待事件 (Reactor 的工作)
* 步骤 2) 发”已经可读”事件发给事先注册的事件处理者或者回调 ( Reactor 要做的)
* 步骤 3) 读数据 (用户代码要做的)
* 步骤 4) 处理数据 (用户代码要做的)

### 模拟的Proactor模式:

* 步骤 1) 等待事件 (Proactor 的工作)
* 步骤 2) 读数据(看，这里变成成了让 Proactor 做这个事情)
* 步骤 3) 把数据已经准备好的消息给用户处理函数，即事件处理者(Proactor 要做的)
* 步骤 4) 处理数据 (用户代码要做的)

在没有底层异步I/O API支持的操作系统，这种方法可以帮我们隐藏掉socket接口的差异(无论是性能还是其它)， 提供一个完全可用的统一“异步接口”。这样我们就可以开发真正平台独立的通用接口了。

## TProactor

我们提出的TProactor方案已经由TerabitP/L[6]公司实现了。它有两种实现:C++的和Java的。C++版本使用了ACE平台独立的底层元件，最终在所有操作系统上提供了统一的异步接口。

TProactor中最重要的组件要数Engine和WaitStrategy了。Engine用于维护异步操作的生命周期；而WaitStrategy用于管理并发策略。 WaitStrategy和Engine一般是成对出现的，两者间提供了良好的匹配接口。

Engines和等待策略被设计成高度可组合的(完整的实现列表请参照附录1)。TProactor是高度可配置的方案，通过使用异步内核API和同步Unix API(select(), poll(), /dev/poll (Solaris 5.8+), port_get (Solaris 5.10),RealTime (RT) signals (Linux 2.4+), epoll (Linux 2.6), k-queue (FreeBSD) )，它内部实现了三种引擎(POSIX AIO, SUN AIO and Emulated AIO)并隐藏了六类等待策略。TProactor实现了和标准的 ACE Proactor一样的接口。这样一来，为不同平台提供通用统一的只有一份代码的跨平台解决方案成为可能。

Engines和WaitStrategies可以像乐高积木一样自由地组合，开发者可以在运行时通过配置参数来选择合适的内部机制（引擎和等待策略）。可以根据需求设定配置，比如连接数，系统伸缩性，以及运行的操作系统等。如果系统支持相应的异步底层API，开发人员可以选择真正的异步策略，否则用户也可以选择使用模拟出来的异步模式。所有这一切策略上的实现细节都不太需要关注，我们看到的是一个可用的异步模型。

举例来说，对于运行在Sun Solaris上的HTTP服务器，如果需要支持大量的连接数，/dev/poll或者port_get()之类的引擎是比较合适的选择；如果需要高吞吐量，那使用基本select()的引擎会更好。由于不同选择策略内在算法的问题，像这样的弹性选择是标准ACE Reactor/Proactor模式所无法提供的（见附录2）。

在性能方面，我们的测试显示，模拟异步模式并未造成任何开销，没有变慢，反倒是性能有所提升。根据我们的测试结果，TProactor相较标签的ACE Reactor在Unix/Linux系统上有大约10-35%性能提升，而在Windows上差不多(测试了吞吐量及响应时间)。

性能比较 (JAVA / C++ / C#).

除了C++，我们也在Java中实现了TProactor。 JDK1.4中，Java仅提供了同步方法，像C中的select() [7、8]。 Java TProactor基于Java的非阻塞功能(java.nio包),类似于C++的TProactor使用了select()引擎。

图1、2显示了以 bits/sec为单位的传输速度以及相应的连接数。这些图比较了以下三种方式实现的echo服务器：标准ACE Reactor实现(基于RedHat Linux9.0)、TProactor C++/Java实现(Microsoft Windows平台及RedHat v9.0)， 以及C#实现。测试的时候，三种服务器使用相同的客户端疯狂地连接，不间断地发送固定大小的数据包。

这几组测试是在相同的硬件上做的，在不同硬件上做的相对结果对比也是类似。

![io_dp_fig_1](http://7xnluw.com1.z0.glb.clouddn.com/Coding/Network/winxp_actor_benchmark.gif)
图 1. Windows XP/P4 2.6GHz HyperThreading/512 MB RAM.
![io_dp_fig_2](http://7xnluw.com1.z0.glb.clouddn.com/Coding/Network/linux_actor_benchmark.gif)
图 2. Linux RedHat 2.4.20-smp/P4 2.6GHz HyperThreading/512 MB RAM.
用户代码示例

下面是TProactor Java实现的echo服务器代码框架。总的来说，开发者只需要实现两个接口：一是OpRead，提供存放读结果的缓存；二是OpWrite，提供存储待写数据的缓存区。同时，开发者需要通过回调onReadComplated()和onWriteCompleted()实现协议相关的业务代码。这些回调会在合适的时候被调用。

```Java
class EchoServerProtocol implements AsynchHandler
{
  AsynchChannel achannel = null;

  EchoServerProtocol( Demultiplexor m,  SelectableChannel channel )
  throws Exception
  {
    this.achannel = new AsynchChannel( m, this, channel );
  }

  public void start() throws Exception
  {
    // called after construction
    System.out.println( Thread.currentThread().getName() +
    ": EchoServer protocol started" );
    achannel.read( buffer);
  }

  public void onReadCompleted( OpRead opRead ) throws Exception
  {
    if ( opRead.getError() != null )
    {
      // handle error, do clean-up if needed
      System.out.println( "EchoServer::readCompleted: " +
      opRead.getError().toString());
      achannel.close();
      return;
    }

    if ( opRead.getBytesCompleted () <= 0)
    {
      System.out.println("EchoServer::readCompleted: Peer closed "
       + opRead.getBytesCompleted();
      achannel.close();
      return;
    }

    ByteBuffer buffer = opRead.getBuffer();

    achannel.write(buffer);
  }

  public void onWriteCompleted(OpWrite opWrite)
  throws Exception
  {
    // logically similar to onReadCompleted
    ...
  }
}
```

## 结束语

TProactor为多个平台提供了一个通用、弹性、可配置的高性能通讯组件，所有那些在附录2中提到的问题都被很好地隐藏在内部实现中了。

从上面的图中我们可以看出C++仍旧是编写高性能服务器最佳选择，虽然Java已紧随其后。然而因为Java本身实现上的问题，其在Windows上表现不佳(这已经应该成为历史了吧)。

需要注意的是，以上针对Java的测试，都是以裸数据的形式测试的，未涉及到数据的处理(影响性能)。

纵观AIO在Linux上的快速发展[9]， 我们可以预计Linux内核API将会提供大量更加强健的异步API， 如此一来以后基于此而实现的新的Engine/等待策略将能轻松地解决能用性方面的问题，并且这也能让标准ACE Proactor接口受益。

## 附录 I

TProactor中实现的Engines和等待策略

| 引擎类型                                     | 等待策略                                            | 操作系统                                                                         |
|----------------------------------------------|-----------------------------------------------------|----------------------------------------------------------------------------------|
| POSIX_AIO (true async)aio_read()/aio_write() | aio_suspend()Waiting for RT signalCallback function | POSIX complained UNIX (not robust)POSIX (not robust)SGI IRIX, LINUX (not robust) |
| SUN_AIO (true async)aio_read()/aio_write()   | aio_wait()                                          | SUN (not robust)                                                                 |
| Emulated AsyncNon-blocking read()/write()    | select()poll()/dev/pollLinux RT signalsKqueue       | generic POSIXMostly all POSIX implementationsSUNLinuxFreeBSD                     |

## 附录 II

所有同步等待策略可划分为两组:

* edge-triggered (e.g. Linux实时信号) – signal readiness only when socket became ready (changes state);

* level-triggered (e.g. select(), poll(), /dev/poll) – readiness at any time.

让我们看看这两组的一些普遍的逻辑问题:

* edge-triggered group: after executing I/O operation, the demultiplexing loop can lose the state of socket readiness. Example: the “read” handler did not read whole chunk of data, so the socket remains still ready for read. But the demultiplexor loop will not receive next notification.

* level-triggered group: when demultiplexor loop detects readiness, it starts the write/read user defined handler. But before the start, it should remove socket descriptior from theset of monitored descriptors. Otherwise, the same event can be dispatched twice.

Obviously, solving these problems adds extra complexities to development. All these problems were resolved internally within TProactor and the developer should not worry about those details, while in the synch approach one needs to apply extra effort to resolve them.

## 资源

[1] Douglas C. Schmidt, Stephen D. Huston “C++ Network Programming.” 2002, Addison-Wesley ISBN 0-201-60464-7

[2] W. Richard Stevens “UNIX Network Programming” vol. 1 and 2, 1999, Prentice Hill, ISBN 0-13- 490012-X

[3] Douglas C. Schmidt, Michael Stal, Hans Rohnert, Frank Buschmann “Pattern-Oriented Software Architecture: Patterns for Concurrent and Networked Objects, Volume 2” Wiley & Sons, NY 2000

[4] INFO: Socket Overlapped I/O Versus Blocking/Non-blocking Mode. Q181611. Microsoft Knowledge Base Articles.

[5] Microsoft MSDN. I/O Completion Ports.
http://msdn.microsoft.com/library/default.asp?url=/library/en- us/fileio/fs/i_o_completion_ports.asp

[6] TProactor (ACE compatible Proactor).
www.terabit.com.au

[7] JavaDoc java.nio.channels
http://java.sun.com/j2se/1.4.2/docs/api/java/nio/channels/package-summary.html

[8] JavaDoc Java.nio.channels.spi Class SelectorProvider
http://java.sun.com/j2se/1.4.2/docs/api/java/nio/channels/spi/SelectorProvider.html

[9] Linux AIO development
http://lse.sourceforge.net/io/aio.html, and
http://archive.linuxsymposium.org/ols2003/Proceedings/All-Reprints/Reprint-Pulavarty-OLS2003.pdf

## 更多

Ian Barile “I/O Multiplexing & Scalable Socket Servers”, 2004 February, DDJ

Further reading on event handling
– http://www.cs.wustl.edu/~schmidt/ACE-papers.html

The Adaptive Communication Environment
http://www.cs.wustl.edu/~schmidt/ACE.html

Terabit Solutions
http://terabit.com.au/solutions.php

## 关于作者

Alex Libman has been programming for 15 years. During the past 5 years his main area of interest is pattern-oriented multiplatform networked programming using C++ and Java. He is big fan and contributor of ACE.

Vlad Gilbourd works as a computer consultant, but wishes to spend more time listening jazz :) As a hobby,he started and runs www.corporatenews.com.au website.


原文出处： [Alex Libman](http://www.artima.com/articles/io_design_patterns.html)   译文出处：[潘孙友](http://www.cppblog.com/pansunyou/archive/2013/11/19/139343.html)
