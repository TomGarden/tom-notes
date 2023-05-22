## VirtualBox
网上人们都说 VirtualBox 的体验好过 VMWare

问题出现在共享文件夹的过程中当使用的是 VirtualBox(5.0.x) 尝试使用共享文件夹的时候出现了一系列的问题。花了许多精力都没有解决
- 这个版本的软件是直接在 Ubuntu 自带的应用管理软件中下载的图个方便。

最终通过从官网下载最新版本的软件并安装解决了共享文件的问题。



## VMWare
在Ubuntu创建了虚拟机当切换到 Window 系统的时候虚拟机无法使用了。


## VirtualBox 内 Ubuntu 卡顿
https://www.geek-share.com/detail/2798812860.html
1. 显存调高
2. 安装VirtualBox增强功能 (虚拟机启动之后 , 在设备菜单可以操作)

## VirtualBox 内 Ubuntu 卡顿 调整尺寸为屏幕尺寸
1. Mac宿主机 , 在设置内调整最大
    - [Higher screen resolution for VirtualBox?](https://askubuntu.com/questions/73589/higher-screen-resolution-for-virtualbox)
    - `sudo apt-get install virtualbox-guest-utils virtualbox-guest-x11 virtualbox-guest-dkms`