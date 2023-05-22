---
layout: post
title:  null
date:   2018-08-07 09:13:03 +0800
categories: jekyll update
author: Tom
---

-----------------------------
__目录__
- jekyll 的 kmarkdown 负责解析
{:toc}

-----------------------------
<br>


## 方法一[License server](https://blog.csdn.net/youxier/article/details/81005805)
intellij idea在下载的时候提供两个版本，ultimate版和commercial版，commercial版是开源的，ultimate版功能更强大，为此开发一般选择ultimate版。但是该版本需要激活，网上的很多激活工具已经失效了，在此，提供一种方法：
1. 在激活界面选择License Server；
2. 在License Server address输入 `“http://active.chinapyg.com/”`（不需要加引号）即可。


## 方法二[Activation code](https://blog.csdn.net/weixin_40132006/article/details/80515247)
> 突然破解失效了，发现之前放置的文件`JetbrainsCrack-2.8-release-enc.jar`不见了，`idea.lanyus.com`也下载不到。
> 于是找到了百度网盘：`链接: https://pan.baidu.com/s/1XDmK44ewLxkdbdb_EKZNfA 密码: 3c45`

1. 下载软件，解压归档后执行安装文件，安装成功；
2. [打开网址http://idea.lanyus.com/](http://idea.lanyus.com/)，下载破解补丁无需使用注册码，用注册码的话不久后可能失效。
3. 下载`JetbrainsCrack-2.8-release-enc.jar`后将他放在idea的bin文件夹下，编辑bin目录下的idea64.vmoptions和idea.vmoptions文件。在最后一行插入`-javaagent:/home/bobo/SoftWare/idea-IU-181.5087.20/bin/JetbrainsCrack-2.8-release-enc.jar`（注意！！！一定是自己下载的jar包的地址哦，jar包的名字也要改，不要照着复制）。
4. 关闭软件并重新启动，在Active code下复制以下内容：
    ```
    ThisCrackLicenseId-{
    "licenseId":"ThisCrackLicenseId",
    "licenseeName":"idea",
    "assigneeName":"",
    "assigneeEmail":"idea@163.com",
    "licenseRestriction":"For This Crack, Only Test! Please support genuine!!!",
    "checkConcurrentUse":false,
    "products":[
    {"code":"II","paidUpTo":"2099-12-31"},
    {"code":"DM","paidUpTo":"2099-12-31"},
    {"code":"AC","paidUpTo":"2099-12-31"},
    {"code":"RS0","paidUpTo":"2099-12-31"},
    {"code":"WS","paidUpTo":"2099-12-31"},
    {"code":"DPN","paidUpTo":"2099-12-31"},
    {"code":"RC","paidUpTo":"2099-12-31"},
    {"code":"PS","paidUpTo":"2099-12-31"},
    {"code":"DC","paidUpTo":"2099-12-31"},
    {"code":"RM","paidUpTo":"2099-12-31"},
    {"code":"CL","paidUpTo":"2099-12-31"},
    {"code":"PC","paidUpTo":"2099-12-31"}
    ],
    "hash":"2911276/0",
    "gracePeriodDays":7,
    "autoProlongated":false}
    ```

## 方法三[修改Host](https://blog.csdn.net/tydyz/article/details/73385615)
1. 参照网址：http://idea.lanyus.com/
2. Host 文件位置：`sudo gedit /etc/hosts`