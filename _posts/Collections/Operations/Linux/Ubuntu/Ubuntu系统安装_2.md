上次安装完成系统引导设置失败，这次先安装Win后安装Ubuntu
```bash
Filesystem      Size  Used Avail Use% Mounted on
udev            3.9G     0  3.9G   0% /dev
tmpfs           789M   18M  771M   3% /run
/dev/sda6        56G   11G   43G  20% /
tmpfs           3.9G  244K  3.9G   1% /dev/shm
tmpfs           5.0M  4.0K  5.0M   1% /run/lock
tmpfs           3.9G     0  3.9G   0% /sys/fs/cgroup
/dev/sda7        75G  6.7G   65G  10% /home
/dev/sda8        29G  2.3G   25G   9% /var
/dev/sda9        94G   65G   25G  73% /dev_kit
/dev/sda10       75G   22G   50G  31% /software
/dev/sda11       66G   19G   44G  31% /document
tmpfs           789M   96K  788M   1% /run/user/1000
/dev/sda1       945M  110M  770M  13% /boot
/dev/sdb1       699G  445G  254G  64% /media/tom/A20CFC3B0CFC0C53
/dev/sda3        46G   14G   30G  32% /media/tom/win

```

上次home给了80 这次只给30
上次交换空间给了20 这次给10


- Windows操作系统60G
    - 60G系统盘
    - Ubuntu可以读取Window文件系统
- Ubuntu操作系统440G
    - 130G 系统
        - 10G   swap    扩展内存
            - _之前给了8G现在有足够的空间了多给点_
        - 30G   /var    各种系统应用的缓存——需要批处理文件定期清除内容，主要清/var/tmp
            - _之前放在根目录下-根目录30G,几乎他就占了半，好只保留30天内容之后大约5G_
        -  *G   /tmp    系统的临时文件，一般系统重启不会被保存。
            - (好多人说2G都有不够用的时候)，之前没有出现过，用了几个月的Ubuntu这个目录还是100K，听运维的哥哥建议放到根目录下。
            - _在保证‘/’根目录有富余大于20G的情况下把他放在根目录不做单独分区了，如果将来可能会对这个目录有更深刻的理解现在确保它不变成麻烦就好了。_
        -  1G   /boot   Linux的内核及引导系统程序所需要的文件
            - _之前给了200M完全够用，现在给1G可以减少必要的清理次数，系统一旦出问题也好回退处理_
        - 30G   /home   用户工作目录，和个人配置文件，如个人环境变量等，所有的账号分配一个工作目录。一般是一个独立的分区。
            - _之前给了60G连带各种软件和开发工具集合(25G,新的分区中会独立出来)也才用来50G当然了安装软件会在这了放大量的配置文件也就是说一个大的应用在这里占个4G的情况是存在的(假设有10个超大应用至少需要65G),所以干脆给80G_
        - 59G    /      系统根目录
            - _根目录之前给了30G到重装的时候已经完全不够用了。旧分区中即将移除的内容(/var)约15G,所以常规占用大约也就20G左右，考了到增量给60G_
    - 310G 个人
        ```tree
         100G  /development_kit
                    ├--sdk
                    ├--jdk
                    ├--androidOS 
                    ├--apache
                    ├--maven
                    └--and so on
          140G  /software
                    ├--/core_software
                    |         ├--IDE
                    |         ├--editor
                    |         ├--vertual machine
                    |         └--and so on
                    └--/other_software
                                ├--tool
                                ├--media
                                ├--play
                                └--and so on
          70G  /document
                    ├--work
                    ├--knowledgepoint
                    └--and so on
        ```