## 〇、 写在开始
随着计算机产业以及计算机网络技术的迅猛发展，越来越多嵌入式设备的出现和家庭网络的发展，实现各种设备的互联互通已经成为人们的迫切需求，而实现家庭网络互联互通的关键是家庭网络的中间件技术。业界各大厂商都提出了自己的解决方案，其中以微软提出的UPnP最具有发展前途，也获得了最广泛的支持，目前UPnP基本是家庭网络设备必须支持的特性之一。

UPnP是通用即插即用（Universal Plug and Play）的缩写，主要用于设备的智能互联互通，使用UPnP协议不需要设备驱动程序，它可以运行在目前几乎所有的操作系统平台上，使得在办公室、家庭和其他公共场所方便地构建设备互联互通成为可能。

### 0.1、 UPNP 的愿景
UPnP最大的愿景是希望任何设备一旦连接上网络，所有在网络上的设备马上就能知道有新设备加入，这些设备彼此之间能互相通信，更能直接使用或者控制它，一切都不需要人工设置，完全的即插即用。

## 一、 名词解释

### 1.1、 UPND
通用即插即用（英语：Universal Plug and Play，简称UPnP）是由“通用即插即用论坛”（UPnP™ Forum）推广的一套网络协议。该协议的目标是使家庭网络（数据共享、通信和娱乐）和公司网络中的各种设备能够相互无缝连接，并简化相关网络的实现。UPnP通过定义和发布基于开放、因特网通讯网协议标准的UPnP设备控制协议来实现这一目标。

UPnP体系允许PC间的点对点连接、网际互连和无线设备。它是一种基于TCP/IP、UDP和HTTP的分布式、开放体系。

UPnP使得任意两个设备能在LAN(局域网)控制设备的管理下相互通信。其特性包括：
- 传输介质和设备独立。UPnP技术可以应用在许多媒体上，包括电话线、电线（电力线通信PLC）、以太网、红外通信技术（IrDA）、无线电（Wi-Fi，蓝牙）和Firewire（1394）。无需任务设备驱动；而是采用共同的协议。
- 用户界面（UI）控制。UPnP技术使得设备厂商可以通过网页浏览器来控制设备并进行交互。
- **操作系统和程序语言独立。任何操作系统和程序语言均可以用于构建UPnP产品。UPnP并没有设定或限制运行于控制设备上的应用程序API；OS厂商可以创建满足他们客户需求的API。UPnP使得厂商可以像开发常规应用程序一样来控制设备UI和交互。**
- 基于因特网技术。UPnP构建于IP、TCP、UDP、HTTP，和XML等许多协议之上。
- 编程控制。UPnP体系同时支持常规应用程序编程控制。
- 扩展性。每个UPnP设备都可以有构建于基本体系之上、与具体设备相关的服务。

### 1.2、 小结
UPNP 是一套协议，用于遵从这一套协议的物联网设备相互连接。

关于 UPNP 的实现包括：



### 1.2、 libupnp
libupnp

libupnp是UPNP协议的一个实现库。它最早由英特尔开发并开源，是目前Linux平台最流行的实现库，其官网为：

http://pupnp.sourceforge.net/



## 二、 初步审计思路
1. 确认应用是否使用了 libupnp
2. 确认 libupnp 版本
3. 确认使用了该版本中的风险 API










## Reference
1. https://zh.wikipedia.org/wiki/UPnP
2. http://download.csdn.net/download/caochanghui/9685658
3. http://pupnp.sourceforge.net/
  - https://github.com/mrjimenez/pupnp
4. http://www.h3c.com.cn/MiniSite/Technology_Circle/Net_Reptile/The_Five/Home/Catalog/201206/747039_97665_0.htm
5. https://support.google.com/faqs/answer/6346109?hl=zh-Hans
6. https://blog.trendmicro.com/trendlabs-security-intelligence/high-profile-mobile-apps-at-risk-due-to-three-year-old-vulnerability/
  - http://www.freebuf.com/news/88266.html
