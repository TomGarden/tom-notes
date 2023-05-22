# /proc目录
Linux 内核提供了一种通过 /proc 文件系统，在运行时访问内核内部数据结构、改变内核设置的机制。proc文件系统是一个伪文件系统，它只存在内存当中，而不占用外存空间。它以文件系统的方式为访问系统内核数据的操作提供接口。

## /proc/net子目录
1. 此目录下的文件描述或修改了联网代码的行为。可以通过使用arp,netstat,route和ipfwadm命令设置或查询这些特殊文件中的许多文件。
2. 网卡设备信息

### /proc/net/tcp 和 /proc/net/tcp6
列名：

|sl | local_address | remote_address | st   | tx_queue | rx_queue | tr | tm->when | retrnsmt | uid | timeout | inode|
|---|---------------|----------------|------|----------|----------|----|----------|----------|-----|---------|------|
|序号| 本地地址       | 远程地址        |连接状态| tx_queue | rx_queue | tr | tm->when | retrnsmt | uid | timeout | inode|

连接状态码：
- 00  "ERROR_STATUS",
- 01  "TCP_ESTABLISHED",
- 02  "TCP_SYN_SENT",
- 03  "TCP_SYN_RECV",
- 04  "TCP_FIN_WAIT1",
- 05  "TCP_FIN_WAIT2",
- 06  "TCP_TIME_WAIT",
- 07  "TCP_CLOSE",
- 08  "TCP_CLOSE_WAIT",
- 09  "TCP_LAST_ACK",
- 0A  "TCP_LISTEN",
- 0B  "TCP_CLOSING",

## 参考 & 引用
1. [Linux下nagios网络监控与/proc/net/tcp文件详解](https://www.cnblogs.com/cfinder010/p/3143263.html)