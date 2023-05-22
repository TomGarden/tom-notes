
当前 Ubuntu 16.04 长期稳定使用的分区及使用状况
```
Filesystem      Size  Used Avail Use% Mounted on
udev            3.9G     0  3.9G   0% /dev
tmpfs           789M   18M  771M   3% /run
/dev/sdb1        33G  8.8G   23G  29% /
tmpfs           3.9G  211M  3.7G   6% /dev/shm
tmpfs           5.0M  4.0K  5.0M   1% /run/lock
tmpfs           3.9G     0  3.9G   0% /sys/fs/cgroup
/dev/sdb7        47G   17G   28G  38% /home
/dev/sdb5       945M  106M  775M  13% /boot
/dev/sdb6        25G  1.3G   22G   6% /var
/dev/sdb9       108G   15G   88G  15% /beyourself
tmpfs           789M  120K  788M   1% /run/user/1000
/dev/sda7       105G   85G   20G  82% /media/tom/document
/dev/sda5       105G   86G   19G  82% /media/tom/software
```


系统盘
- Win 50G
- Lin 50G

Linux 分区预设

|   路径   |    容量  |常剩空间|
|----------|---------|--------|
|/         |15G      |5G    |
|/boot     |500M     |200M   |
|/var      |5G       |3G     |
|/home     |25G      |5G     |
|swap      |4G       |       |
|不占用     |--       |       |
|总计       |50G/总计 |       |

`1000G`机械硬盘划分：
1. 100G 不占用
2. 100G SoftwareLinux 
3. 100G SoftwareWindows
4. 100G Document公用
5. 100G Tool(Windows)
7. 200G VM(4个)
6. 100G SharedFolder(公用)
7. 100G Other
8. 100G 不占用

查看当前硬盘用量：

|路径             |    容量 |占用 |非必要占用               |考虑移除|正经用例空间|      
|----            |---------|----|-----------------------|------|----------|      
|Linux/beyourself|108G     |15G |                       |      |          |      
|~/document      |105G     |85G |[66G]/Virtual Machines |    是 |20G       |      
|~/tool          |105G     |94G |[61G]/android-sdk      |      |35G       |      
|~/software      |105G     |92G |[80G]/AndroidSources   |   是  |15G       |      


|path                          |size                                |
|--|--|
|none                          |100G                                |
D|software                      |50G                                 |
E|tool                          |120G                                |
F|document                      |50G                                 |
G|beyourself                    |100G                                |
H|vm                            |150G                                |
I|os                            |300G                                |
G|other                         |50G                                 |
|none                          |10G                                |

