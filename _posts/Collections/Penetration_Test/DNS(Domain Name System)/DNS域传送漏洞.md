DNS(Domain Name System，域名管理系统)是万维网WWW的重要基础。它建立在一个分布式数据库基础之上，在这个数据库里，保存了IP地址和域名的相互映射关系。

正因为DNS的存在，我们才不需要记住大量无规则的IP地址， 而只需要知道对方计算机的名称，就可以访问对应服务。比如，笔者的博客是www.lijiejie.com，当用户在浏览器地址栏输入上述域名，浏览器就将向DNS服务器发送查询，得到目标主机的IP地址，再与对应的主机建立一个HTTP连接，请求网页。相对于记住106.187.34.156这个IP地址，域名www.lijiejie.com自然更有意义、更加清晰明了。

作为重要的互联网基础设施，难免成为黑客的重点攻击目标，服务的稳定性尤为重要。DNS服务器分为：主服务器、备份服务器和缓存服务器。在主备服务器之间同步数据库，需要使用“DNS域传送”。域传送是指后备服务器从主服务器拷贝数据，并用得到的数据更新自身数据库。

若DNS服务器配置不当，可能导致匿名用户获取某个域的所有记录。造成整个网络的拓扑结构泄露给潜在的攻击者，包括一些安全性较低的内部主机，如测试服务器。凭借这份网络蓝图，攻击者可以节省很少的扫描时间。

大的互联网厂商通常将内部网络与外部互联网隔离开，一个重要的手段是使用Private DNS。如果内部DNS泄露，将造成极大的安全风险。风险控制不当甚至造成整个内部网络沦陷。

DNS服务器可以分为三种，高速缓存服务器(Cache-only server)、主服务器(Primary Name server)、辅助服务器(Second Name Server)。

在DNS设置中，@符号是一个比较特殊的符号，它用来代表ZONE，所以在如z00w00.local这样的ZONE文件中，所以在SOA中有一个“responsible mail addr”配置的地方，你不会找到@符号，但那确实是一个E-MAIL地址

------------------------------------------------------------------------------------------------------
个人理解
------------------------------------------------------------------------------------------------------
DNS 要完成域传送，就需要有 DNS 服务器，而且这个服务器应该是公司自己维护的服务器
> 问题是：公司自己维护服务器这件事是怎么回事呢？

- 暂未知



## 检测
### 一、 应该知道目标 IP 的 DNS 服务器
```
C:\Users\77136>nslookup
默认服务器:  xd-cache-1.bjtelecom.net
Address:  219.141.136.10

> set type=ns
> realneo.testin.cn
服务器:  xd-cache-1.bjtelecom.net
Address:  219.141.136.10

testin.cn
        primary name server = dns27.hichina.com
        responsible mail addr = hostmaster.hichina.com
        serial  = 1
        refresh = 3600 (1 hour)
        retry   = 1200 (20 mins)
        expire  = 3600 (1 hour)
        default TTL = 600 (10 mins)
> ls realneo.testin.cn           
[xd-cache-1.bjtelecom.net]
*** 无法列出域 realneo.testin.cn: BAD ERROR VALUE
DNS 服务器拒绝将区域 realneo.testin.cn 传送到你的计算机。如果这不正确，
请检查 IP 地址 219.141.136.10 的 DNS 服务器上 realneo.testin.cn 的
区域传送安全设置。

> ls testin.cn
[xd-cache-1.bjtelecom.net]
*** 无法列出域 testin.cn: BAD ERROR VALUE
DNS 服务器拒绝将区域 testin.cn 传送到你的计算机。如果这不正确，
请检查 IP 地址 219.141.136.10 的 DNS 服务器上 testin.cn 的
区域传送安全设置。
```

### 二、 尝试发出域传送请求
```
ls realneo.testin.cn  
```

## Reference
1. http://www.lijiejie.com/dns-zone-transfer-1/（还有许多没有转载的细节，如有需要请查看）
2. http://www.lijiejie.com/dns-zone-transfer-2/