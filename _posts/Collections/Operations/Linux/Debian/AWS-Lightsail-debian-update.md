AWS Lightsail , 没有 Debian 11  , 手动从 Debian 10 升级 . 



[对于debian,查看官方源 url](https://www.debian.org/mirror/list.zh-cn.html)
[清华镜像站操作提示](https://mirrors.tuna.tsinghua.edu.cn/help/debian/)



替换源文件内容 `/etc/apt/sources.list`
```
# 注释掉原来的源连接
# deb http://cdn-aws.deb.debian.org/debian buster main
# deb-src http://cdn-aws.deb.debian.org/debian buster main
# deb http://security.debian.org/debian-security buster/updates main
# deb-src http://security.debian.org/debian-security buster/updates main
# deb http://cdn-aws.deb.debian.org/debian buster-updates main
# deb-src http://cdn-aws.deb.debian.org/debian buster-updates main
# deb http://cdn-aws.deb.debian.org/debian buster-backports main
# deb-src http://cdn-aws.deb.debian.org/debian buster-backports main


# 增加新的的源连接
deb http://deb.debian.org/debian bullseye main
deb-src http://deb.debian.org/debian bullseye main
deb http://security.debian.org/debian-security bullseye-security main
deb-src http://security.debian.org/debian-security bullseye-security main
deb http://deb.debian.org/debian bullseye-updates main
deb-src http://deb.debian.org/debian bullseye-updates main
```

```
sudo apt-get update
sudo apt-get upgrade
sudo reboot now
sudo apt-get autoclean
sudo apt-get aoturemove  
```