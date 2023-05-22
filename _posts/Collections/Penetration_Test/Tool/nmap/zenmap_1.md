## 打开Znemap
- help --> about:
    1. Nmap:一款用于网络扫描和安全审计的开源工具。
    2. Znemap：一款多平台适用的Nmap图形界面工具(在Umit的基础发展而来)。
    3. Umit：一个Nmap的GUI程序。

## 使用
1. Target：填写要扫描的主机名或IP地址
    - 填写 `172.16.244.130-135` 表示要扫描 130-135 地址上的所有主机。
    - 填写 `172.16.244.*` =  `172.16.244.1-225`
2. Profile:简介(标签)作用是记录常用的操作(对应command)。我们的操作实际上都是命令行，这里就是对一个常用命令打一个标签放在这个下拉框中，当我们在Target填好了主机名，选择一个自己需要的命令标签GUI工具就会自动为我们拼装好命令放到Command中。当然我们是可以自己写命令的。并且通过顶部的`Profile`按钮来自定义标签。
    1. __Intense scan : __` nmap -T4 -A -v hostName` ：完整全面的扫描
        - `-T4`指定扫描过程使用的时序（Timing），总有6个级别（0-5），级别越高，扫描速度越快，但也容易被防火墙或IDS检测并屏蔽掉，在网络通讯状况良好的情况推荐使用T4。
        - `-A`系统侦查，版本侦查，脚本扫描，路由跟踪。
        - `-v`表示显示冗余（verbosity）信息，在扫描过程中显示扫描的细节，从而让用户了解当前的扫描状态。（-vv显示更详细的过程信息）。
### 端口扫描
1. [端口状态：](https://nmap.org/man/zh/man-port-scanning-basics.html)
2. [端口命令：](https://nmap.org/man/zh/man-port-scanning-techniques.html)

#### 看看DVWA的扫描结果
```bash
PORT     STATE SERVICE VERSION
21/tcp   open  ftp     ProFTPD 1.3.4c
22/tcp   open  ssh     (protocol 2.0)
80/tcp   open  http    Apache httpd 2.4.27 ((Unix) OpenSSL/1.0.2l PHP/7.1.8 mod_perl/2.0.8-dev Perl/v5.16.3)
|_http-title: Requested resource was http://bogon/dashboard/ and no page was returned.
|_http-methods: No Allow or Public header in OPTIONS response (status code 302)
443/tcp  open  ssl     TLSv1
3306/tcp open  mysql?
| mysql-info: MySQL Error detected!
| Error Code was: 1130
|_Host '172.16.244.1' is not allowed to connect to this MariaDB server
```

#### 拿到端口下一步就是爆破
1. 爆破工具有二：Medusa / Hydra  这里用的Medusa
2. 下载`man medusa`写的还算清楚的：man medusa 中可能有错的
    - -h [TEXT]    : Target hostname or IP address
    - -H [FILE]    : File containing target hostnames or IP addresses
    - -u [TEXT]    : Username to test
    - -U [FILE]    : File containing usernames to test
    - -p [TEXT]    : Password to test
    - -P [FILE]    : File containing passwords to test
    - -M ： 要执行的模块的名称
    - -O ： 保存成功的文件
3. 我的一个爆破动作：`medusa -h 172.16.244.130 -u tomvm -P '字典路径'  -M ftp `
4. 成功标志：`ACCOUNT FOUND: [ftp] Host: 172.16.244.130 User: 叉叉 Password: 叉叉叉 [SUCCESS]`
5. 爆破这件事主要是要考验字典(信息收集能力)。

## 参考
1. [ Zenmap gui介绍（WINDOWS下的nmap）](http://powerclark.iteye.com/blog/524508)
2. [Nmap扫描原理与用法](http://www.cnblogs.com/tdcqma/p/5692546.html)
3. [聪明有机智的你总能发现官方的中文教程 ^_^ ](https://nmap.org/man/zh/)