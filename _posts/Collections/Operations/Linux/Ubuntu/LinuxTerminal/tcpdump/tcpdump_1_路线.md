
## 一、提供的命令
### 1.1、First 自动化测试命令
```terminal
tcpdump -s 0 -i eth0 -w /sdcard/Download/dump.pcap "tcp and (((ip[2:2] - ((ip[0]&0xf)<<2)) - ((tcp[12]&0xf0)>>2)) != 0)"

nohup COMMAND > /dev/null 2>&1 &
```
### 1.2、Second wiki 命令
`tcpdump -X -n -s 0 port 443 -w filename.pcap`

## 二、使用上述命令抓包并分析
### 2.1、使用过程中注意
1. 在android手机设置代理的情况下  -w 命令会导致无法写文件到手机(文件大小为 0 ，当关闭命令的时候文件会有增量不过用 wireshark 打开没有任何内容)。

### 2.2、分析工具
wireshark

### 2.3、tcpdump 工具的使用细节探究




## 参考
1. [OSI七层与TCP/IP五层网络架构详解](https://www.2cto.com/net/201310/252965.html)
    - [OSI七层与TCP/IP五层网络架构详解](http://blog.csdn.net/huangjin0507/article/details/51613561)
2. [[硬件及驱动] tcpdump 工作在协议栈的那一层？](http://bbs.chinaunix.net/thread-4080795-1-1.html)
3. [TCPDUMP](https://baike.baidu.com/item/TCPDUMP/1383003?fr=aladdin)
4. [协议栈](https://baike.baidu.com/item/协议栈/3155224?fr=aladdin)
5. [Linux tcpdump命令详解](http://www.cnblogs.com/ggjucheng/archive/2012/01/14/2322659.html)