# Fiddler 抓包

## 一、抓 Http 包 Fiddler 设置
Tools -> Options… -> Connections
1. Allow remote computers to connect —— 是允许远程发送请求，需要勾上
2. Fiddler listens on port —— 是手机连接fiddler时的代理端口号，默认8888即可

## 二、抓 Https 包 Fiddler 设置
在设置好抓 Http 包的基础上
Tools -> Options… -> HTTPS
1. Capture Https Connects —— 捕获 Https 连接
2. Decrypt HTTPS traffic —— 解密 HTTPS 流量
    - 可选：
        - From all processes -- 抓取来自所有程序的
        - From remote clients only -- 仅抓取来自远程设备的
3. OK
4. 重启生效


## 三、抓包 Android 手机设置
手机设置wifi的代理
- 连接与电脑相同的wifi，修改wifi的网络，手动设置代理，代理服务器主机名为电脑的IP地址，代理端口为在fiddler里设置的端口号，保存后，fiddler将能够收到手机上的请求信息

手机安装 CA 证书
1. 浏览器访问 http://电脑 IP :代理端口
    - IP:prot 就是我们在手机上填写的代理 IP:prot
    - 证书下载
2. OK


## 四、请求过滤
在fiddler里进行一下请求的过滤，只看某个服务器下的请求，配置后要点一下 __Actions__ 来保存过滤

## 五、重新发送拦截到的请求



## 注意
1. 手机配置了代理，fiddler必须启动，手机才可以上网，如果fiddler关闭后手机是不可以联网了，需要将代理去掉才可以进行联网。
2. fiddler启东时，会默认将Internet的代理更改为127.0.0.1，在正常退出fiddler时代理会恢复为原来的代理。但是如果遇到fiddler不正常退出（比如进程直接杀掉），会导致代理没有恢复的情况，这是需要手动修改Internet的代理（恢复为原来的代理或者取消代理）
    - 控制面板\网络和 Internet\网络和共享中心\连接选项卡\局域网设置按钮
3. 请求包中存在一些大文件的时候如果强行打开和查看该 URL 的请求细节，会导致卡顿(未响应)。






## 参考 & 引用
0. [权威学习指南](http://docs.telerik.com/fiddler/knowledgebase)
1. [使用fiddler对手机上的程序进行抓包](https://www.cnblogs.com/meitian/p/4997310.html)
2. [fiddler filters 使用（fiddler只显示指定请求，fiddler不显示指定请求，即filter请求过滤）](http://blog.csdn.net/notejs/article/details/49681479)
