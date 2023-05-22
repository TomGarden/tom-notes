## nslookup usage
```
C:\Users\77136>nslookup
默认服务器:  xd-cache-1.bjtelecom.net
Address:  219.141.136.10

> help
命令:   (标识符以大写表示，[] 表示可选)
NAME            - 打印有关使用默认服务器的主机/域 NAME 的信息
NAME1 NAME2     - 同上，但将 NAME2 用作服务器
help or ?       - 打印有关常用命令的信息
set OPTION      - 设置选项
    all                 - 打印选项、当前服务器和主机
    [no]debug           - 打印调试信息
    [no]d2              - 打印详细的调试信息
    [no]defname         - 将域名附加到每个查询
    [no]recurse         - 询问查询的递归应答
    [no]search          - 使用域搜索列表
    [no]vc              - 始终使用虚拟电路
    domain=NAME         - 将默认域名设置为 NAME
    srchlist=N1[/N2/.../N6] - 将域设置为 N1，并将搜索列表设置为 N1、N2 等
    root=NAME           - 将根服务器设置为 NAME
    retry=X             - 将重试次数设置为 X
    timeout=X           - 将初始超时间隔设置为 X 秒
    type=X              - 设置查询类型(如 A、AAAA、A+AAAA、ANY、CNAME、MX、NS、PTR、SOA 和 SRV)
    querytype=X         - 与类型相同
    class=X             - 设置查询类(如 IN (Internet)和 ANY)
    [no]msxfr           - 使用 MS 快速区域传送
    ixfrver=X           - 用于 IXFR 传送请求的当前版本
server NAME     - 将默认服务器设置为 NAME，使用当前默认服务器
lserver NAME    - 将默认服务器设置为 NAME，使用初始服务器
root            - 将当前默认服务器设置为根服务器
ls [opt] DOMAIN [> FILE] - 列出 DOMAIN 中的地址(可选: 输出到文件 FILE)
    -a          -  列出规范名称和别名
    -d          -  列出所有记录
    -t TYPE     -  列出给定 RFC 记录类型(例如 A、CNAME、MX、NS 和 PTR 等)
                   的记录
view FILE           - 对 'ls' 输出文件排序，并使用 pg 查看
exit            - 退出程序
```

域名解析记录主要分为A记录、MX记录、CNAME记录、NS记录和TXT记录：

1、A记录

A代表Address，用来指定域名对应的IP地址，如将item.taobao.com指定到115.238.23.xxx，将switch.taobao.com指定到121.14.24.xxx。A记录可以将多个域名解析到一个IP地址，但是不能将一个域名解析到多个IP地址

2、MX记录

Mail Exchange，就是可以将某个域名下的邮件服务器指向自己的Mail Server，如taobao.com域名的A记录IP地址是115.238.25.xxx，如果将MX记录设置为115.238.25.xxx，即xxx@taobao.com的邮件路由，DNS会将邮件发送到115.238.25.xxx所在的服务器，而正常通过Web请求的话仍然解析到A记录的IP地址

3、CNAME记录

Canonical Name，即别名解析。所谓别名解析就是可以为一个域名设置一个或者多个别名，如将aaa.com解析到bbb.net、将ccc.com也解析到bbb.net，其中bbb.net分别是aaa.com和ccc.com的别名

4、NS记录

为某个域名指定DNS解析服务器，也就是这个域名由指定的IP地址的DNS服务器取解析

5、TXT记录

为某个主机名或域名设置说明，如可以为ddd.net设置TXT记录为"这是XXX的博客"这样的说明