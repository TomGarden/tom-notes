

## 第二次碰到我们来探探究竟

连接远程主机的时候出现自动断开的现象，复现步骤 ：
1. 客户端连接远程主机 ，ssh user@host -p port
2. 连接成功后，就不再操作了，去吃个20min 的饭 
3. 回到设备身边，文本录入无效，终端处于无响应状态，等一会儿就发现 SSH 已经自动断开了   2022-01-24 17:01:15


参考内容：
1. [StackOverflow 如何保持SSH连接一小会？](https://superuser.com/q/699676)
2. [Linux使用ssh,为什会超时断开](http://bluebiu.com/blog/linux-ssh-session-alive.html)
3. man page online
   - [ssh](https://linux.die.net/man/1/ssh) 
   - [ssh_config](https://linux.die.net/man/5/ssh_config)
4. [SSH 自动断开连接的问题处理及原因说明](https://www.zhb127.com/archives/ssh-automatic-disconnect-problem-processing-and-reasons.html)



我们期望的状况 ： 断开连接可以，应该由用户手动断开连接，或者在30min（或其他时间段）没有操作后自动断开连接。

SSH 目前断开连接的原因是什么 ？
1. 浏览过 ssh 手册文档 ， 没有注意到自动断连的描述
2. 听说的几种可能：客户端/服务端防火墙会自动断开闲置的连接/路由器会自动断开闲置的连接
3. 细节暂时不探究了。保持精力的最优方向先。

最终的处理方式

* 客户端设置`~/.ssh/config`  
```
# ServerAliveInterval : 单位为秒的时间间隔，在这个间隔时间后没有收到服务器的响应将会发送消息请求响应。默认值为 0 表示不会发送消息到服务器。
# ServerAliveCountMax ：在收不到服务器消息的情况下 ，每间隔 ServerAliveInterval 想服务发送一次消息 ，最多要发多少次，默认 3 次 。 如果超过
#                       设置的最大次数仍然收不到服务器响应 ， 则断开连接。
Host 自己远程主机 ip 
  ServerAliveInterval 300
  ServerAliveCountMax 3
```

* 服务端设置 ‵/etc/ssh/sshd_config`
```
# 每间隔 #ClientAliveInterval 秒发送一次保活消息 ， 一共发送 #ClientAliveCountMax 次 ， 如果均没有相应关闭次连接
TCPKeepAlive yes
ClientAliveInterval 300 # 当客户端与自己的信息交互停止 180s 后主动向客户端发送消息 ， 看还有没有保留此连接
ClientAliveCountMax 3	# 向客户端发送保活消息的次数

```

以上操作没有真正解决 ， 后来 以上操作 保持 ， 安装了 tmux 后解决了此问题


## 第二次碰到我们来探探究竟
有人说症结在于防火墙取消端口连接 , 我们了解下 Linux 防火墙相关的内容 
1. 鸟个的Linux私房菜，没有找到相关信息。
2. 自定义搜索关键字 “Linux 防火墙 关闭空闲 socket”
    - [从 Amazon EC2 外部连接防火墙超时问题](https://docs.aws.amazon.com/zh_cn/redshift/latest/mgmt/connecting-firewall-guidance.html)
3. SSH 使用的是 TCP/IP 协议 ， 是否从这里入手可以有答案
    - [大话keepalive](https://www.cnblogs.com/yjf512/p/5354055.html)
    - [如何判断自己IP是内网IP还是外网IP](https://developer.aliyun.com/article/243610)
4. [OpenBSD manual page](http://man.openbsd.org/ssh_config#ServerAliveInterval)


加入我指导到底是 防火墙 还是 nat网络防火墙(路由器防火墙) 的超时设置导致了我ssh 断连 的话 ， 
我应该可以搞清楚到底这个断连时间是多少， 就算我无法更改防火墙 的超时时间 ， 
还是可以更改自己的 ssh 保活设置 ‵ServerAliveInterval‵ 时间 。
但是我不知道 ， 我没有搞清楚到底是谁切断了我的 ssh 连接 .
