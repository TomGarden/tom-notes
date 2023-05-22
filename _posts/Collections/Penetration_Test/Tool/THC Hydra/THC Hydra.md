# 端口爆破工具

同样都是端口爆破工具 Hydra 和 Medusa ，我之前用过后者。这次再用注意到：
1. [Hydra]  Latest release June 16, 2016
2. [Medusa]  Latest release Feb. 9, 2010

同时也注意到，Hydra 虽然号称支持 Windows 但是所谓的支持是在使用 Cygwin 的前提下，所以索性到 Ubuntu 先使用该工具了。

## 一、基础环境
Ubuntu 16.04

## 二、安装
### 2.1、安装依赖
```cmd
sudo apt-get install libssl-dev libssh-dev libidn11-dev libpcre3-dev libgtk2.0-dev libmysqlclient-dev libpq-dev libsvn-dev firebird2.1-dev libncp-dev libncurses5-dev
```
1. E: Unable to locate package libncp-dev
2. Note, selecting 'firebird-dev' instead of 'firebird2.1-dev'

我没有理会第二条(Note, selecting 'firebird-dev' instead of 'firebird2.1-dev')，并且取消未找到的依赖新的依赖安装命令如下
```
sudo apt-get install libssl-dev libssh-dev libidn11-dev libpcre3-dev libgtk2.0-dev libmysqlclient-dev libpq-dev libsvn-dev firebird2.1-dev libncurses5-dev
```

`libncp-dev` [在 Ubuntu 12.04 找到了](https://launchpad.net/ubuntu/precise/+search?text=libncp-dev)只是我不知道怎么安装，所以就没有安装。

## 三、初步使用
GUI
    1. /beyourself/HakerTool/hydra-8.6-src/xhydra
    2. /beyourself/HakerTool/hydra-8.6-src/hydra-gtk/src/hydra

Cmd
    - 随意使用

要爆破我们需要密码表