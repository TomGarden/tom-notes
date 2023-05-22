```
$ nmap
Nmap 7.60 ( https://nmap.org )
Usage: nmap [Scan Type(s)] [Options] {target specification}
TARGET SPECIFICATION:
  Can pass hostnames, IP addresses, networks, etc.
  Ex: scanme.nmap.org, microsoft.com/24, 192.168.0.1; 10.0.0-255.1-254
  -iL <inputfilename>: Input from list of hosts/networks
  -iR <num hosts>: Choose random targets
  --exclude <host1[,host2][,host3],...>: Exclude hosts/networks
  --excludefile <exclude_file>: Exclude list from file
HOST DISCOVERY:
  -sL: List Scan - simply list targets to scan
  -sn: Ping Scan - disable port scan
  -Pn: Treat all hosts as online -- skip host discovery
  -PS/PA/PU/PY[portlist]: TCP SYN/ACK, UDP or SCTP discovery to given ports
  -PE/PP/PM: ICMP echo, timestamp, and netmask request discovery probes
  -PO[protocol list]: IP Protocol Ping
  -n/-R: Never do DNS resolution/Always resolve [default: sometimes]
  --dns-servers <serv1[,serv2],...>: Specify custom DNS servers
  --system-dns: Use OS's DNS resolver
  --traceroute: Trace hop path to each host

```


结果中很容易看出，例如出现 vulnerable-有漏洞； not vulnerable-无漏洞。  有结果出来-有漏洞；无结果出来-无漏洞，往后在其他测试中，只需要将scanme.nmap.org 替换成带验证的目标IP 或者网站。

http://blog.csdn.net/jiangliuzheng/article/details/51992220

听说脚本可以通过 * 全部使用，而且耗时很少

## [Nmap脚本使用指南](https://zhuanlan.zhihu.com/p/26618074)
1. 脚本存放位置
  - Linux --> /usr/share/nmap/scripts/
  - Windows --> 

## nmap 针对端口扫描漏洞(使用脚本)