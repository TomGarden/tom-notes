# shadowsocks 安装和配置
我们已经配置好了 VPS 服务器。

## 一、 URL
https://github.com/shadowsocks

在 GitHub 作者凭一己之力帮助了太多的人，今天我也要获取 TA 的帮助了。

但是 GitHub 上的项目很多，我没法分辨哪一个是安装到服务端的。

最终通过查看前人的足迹确定 shadowsocks 这个 repositories 中的 WIKI 我们可以得到有关使用的指引。
- https://github.com/shadowsocks/shadowsocks/wiki
- https://github.com/shadowsocks/shadowsocks/wiki/Shadowsocks-使用说明
- https://github.com/gfwlist/gfwlist/blob/master/gfwlist.txt



## 二、安装服务端
```
apt-get install python-pip
pip install shadowsocks  //如果不是 root 用户，加上 sudo
```
1. python-pip 是什么
    - 原来是一个包管理工具，专门管理 Python 应用。就是和 `apt-get` `yum` 同类型的产品咯。
2. 虽然在这之前我们已经了解到了 Shadowsocks 有多种不同语言写的多种不同版本，但是既然这是原汁原味的教材，我们跟随他就是了。

## 三、配置和使用
启动
- `ssserver -p 443 -k password -m rc4-md5`

如果要后台运行：

`sudo ssserver -p 443 -k password -m rc4-md5 --user nobody -d start`

如果要停止：

`sudo ssserver -d stop`

如果要检查日志：

`sudo less /var/log/shadowsocks.log`

用 `-h` 查看所有参数。你也可以使用 配置文件 进行配置。

上述命令的解释安装后可自行查看。本次内容全部为摘抄，下次查看的时候请再次寻找源 URL。

### 3.1、 /etc/shadowsocks.json文件
单人使用：
```json
{
    "server":"你的服务器IP",
    "server_port":你的端口,
    "local_address": "127.0.0.1",
    "local_port":1080,
    "password":"你的密码",
    "timeout":300,
    "method":"aes-256-cfb",
    "fast_open": false
}
```
多人使用
```json
{
    "server":"你的服务器IP",
    "local_address":"127.0.0.1",
    "local_port":1080,
    "timeout":300,
    "method":"aes-256-cfb",
    "fast_open":false,
    "port_password":
    {
        "用户1端口":"用户1密码",
        "用户2端口":"用户2密码"
    },
    "_comment":
    {
        "用户1端口":"备注",
        "用户2端口":"备注"
    }
}

// 一说

{
"server":"my_server_ip",
"local_address": "127.0.0.1",
"local_port":1080,
"port_password":
{     "8381": "foobar1",
      "8382": "foobar2",
      "8383": "foobar3",
      "8384": "foobar4"
},
"timeout":300,
"method":"aes-256-cfb",
"fast_open": false
}
```

## 四、 上述操作,需要做微调 ：
1. [第一次调整](https://blog.bingxuecandong.com/?p=195)
    - 这个操作在官方也是有引导的(也是抄录)：https://github.com/shadowsocks/shadowsocks/wiki/Configuration-via-Config-File
    - 卵用没有
2. 在本次调整的基础上修改客户端 SOCKS5 为 HTTPS 然后就可用了。：在一个问答社区找到的答案(细节我忘了)
```
//以下是服务端控制台的错误：
2017-11-05 13:50:28 WARNING  unsupported addrtype 47, maybe wrong password or encryption method
2017-11-05 13:50:28 ERROR    can not parse header when handling connection from 103.77.56.145:8158
2017-11-05 13:50:49 INFO     connecting clients4.google.com:443 from 60.10.116.178:39050
```
不过确实可用了。

## 五、 关于 Windows 端客户端如何设置
1. Shadowsocks for Windows 需要依赖 Microsoft .NET Framework 4.6.2 or higher.
    - 曾经想为此换更新系统来着，不过失败了。所以发现了下面的内容
2. [shadowsocks-qt5不需要依赖Window的巴拉巴拉]https://github.com/shadowsocks/shadowsocks-qt5

3. 关于 Windows 的设置：SOCKS5 / HTTPS 都试试吧，那个能用用哪个


## 六、 How to install shadowsocks-qt5 for linux
1. [是呗]find github's release : https://github.com/shadowsocks/shadowsocks-qt5/releases
    - download *.tar.gz
        - 这么做的问题在于下载了源码无法编译和安装

2. **好多网友这么说：** 
    - 下述过程中出现命令不要着急可以把出现错误的命令再试一次
    ```
    sudo add-apt-repository ppa:hzwhuang/ss-qt5
    sudo apt-get update
    sudo apt-get install shadowsocks-qt5
    ```
    - 相关信息：https://launchpad.net/~hzwhuang/+archive/ubuntu/ss-qt5



## 六、关于本地代理设置。
1. Linux 设置全局代理驾轻就熟
    - 设置-网络-一路走。
2. Windows 设置全局代理
    - 控制面板 -> Intetnet 选项 -> 连接选项卡 -> 局域网设置
    - 随便搞。
3. 浏览器设置代理不在多说。

# OVER

## 参考 & 抄录
0. https://github.com/shadowsocks
1. [秋水逸冰 ](https://teddysun.com/342.html)
2. [教你用VPS搭建自己的Shadowsock](http://blog.csdn.net/qq_19835843/article/details/52233111)
3. [搬瓦工VPS多用户SS配置](http://blog.csdn.net/allfun/article/details/53350214)
