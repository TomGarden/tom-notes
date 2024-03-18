开机自启动软件 Startup Applications

[Linux 读写 Max HFS/HFS+ 硬盘](https://superuser.com/questions/84446/how-to-mount-a-hfs-partition-in-ubuntu-as-read-write)
```
在 Ubuntu 读写 Apple HFS/HFS+ 硬盘指令

sudo mount --types=hfsplus,hfs  --options=remount,rw,force /dev/sdb2
- remount 是因为 ubuntu 会默认挂载 硬盘
- force 是必须的字段
```