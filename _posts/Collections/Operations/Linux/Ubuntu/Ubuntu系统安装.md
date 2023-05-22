## 一、理解

### 1.0、存在诸多和Windows的对比
我是小学3年级开始学习计算机技术的那一拨人。  
1. Windows2000
2. WindowsXP
3. Windows7
4. Windows8(半年，因其兼容性和稳定系未能满足需求而放弃)
5. Windwos7(使用至今)
6. Windows10(因Windows8的原因，至今没有尝试的兴趣)
> 计算机从娃娃抓起！

### 1.1、什么是所谓的分区？
#### 1.1.1、对于Windows而言--多个树
硬盘分区个数 >=1 ,一般为 3~8 根据个人需求和硬盘大小而不同。    
Windows的文件结构是多个并列的树状结构，最顶部的是不同的磁盘（分区），如：C，D，E，F等。  
#### 1.1.2、对于Ubuntu--一个树
Linux的文件结构是单个的树状结构.可以用tree进行展示。在Ubuntu下安装tree（sudo apt-get install tree）,并可通过命令来查看。  

在分区这件事情上逻辑是这样的：把硬盘分为不同的数据存储区间。  
在Ubuntu的文件系统是把它所管理的物理介质(不论数量)全都放到一个树(一颗逻辑上的树)中。  
### 1.2、分区的作用
__方便管理__  
例如Ubuntu中的日志目录：/var/log/#    
如果我们没有为/var/log单独分一个区，那么日志文件就只能在该固定大小的分区中，一旦空间不够用了系统会提醒我们(/xx位置空间不足)。

### 1.3、分区的定制性
分区方案选定以后，并不就是固定死了。还是可以使用分区编辑工具调整分区大小的(subject to sufficient free space in each partition)，然而，这是一个相当高级的主题并且通常不能在正在使用时系统处理。

### 1.4、一定要分区吗？
对于新用户、家庭用户和其它单用户，一个单独的根(/)分区外加一个交换分区可能是最简单最方便的创建和使用方案。然而，对于多用户系统或者有大量磁盘空间的计算机，最好将 /home，/tmp，和/var 目录作为与根(/)分区分离的单独分区。

### 1.5 分区储备

#### 1.5.1、一说：    

|	目录     |	描述	|
|	----	|	----	|
|	/bin	|	做为基础系统所需要的最基础的命令就是放在这里。比如 ls、cp、mkdir等命令；功能和/usr/bin类似，这个目录中的文件都是可执行的，普通用户都可以使用的命令。	|
|	/boot	|	Linux的内核及引导系统程序所需要的文件，比如 vmlinuz initrd.img 文件都位于这个目录中。在一般情况下，GRUB或LILO系统引导管理器也位于这个目录；启动装载文件存放位置，如kernels,initrd,grub。一般是一个独立的分区。	|
|	/dev	|	一些必要的设备,声卡、磁盘等。还有如 /dev/null. /dev/console /dev/zero /dev/full 等。	|
|	/etc	|	系统的配置文件存放地. 一些服务器的配置文件也在这里；比如用户帐号及密码配置文件；	|
|		    |	/etc/opt:/opt对应的配置文件	|
|	    	|	/etc/X11:Xwindows系统配置文件	|
|	    	|	/etc/xml:XML配置文件	|
|	    	|	……	|
|	/home	|	用户工作目录，和个人配置文件，如个人环境变量等，所有的账号分配一个工作目录。一般是一个独立的分区。	|
|	/lib	|	库文件存放地。bin和sbin需要的库文件。类似windows的DLL。	|
|	/media	|	可拆卸的媒介挂载点，如CD-ROMs、移动硬盘、U盘，系统默认会挂载到这里来。	|
|	/mnt	|	临时挂载文件系统。这个目录一般是用于存放挂载储存设备的挂载目录的，比如有cdrom 等目录。可以参看/etc/fstab的定义。	|
|	/opt	|	可选的应用程序包。	|
|	/proc	|	操作系统运行时，进程（正在运行中的程序）信息及内核信息（比如cpu、硬盘分区、内存信息等）存放在这里。/proc目录伪装的文件系统proc的挂载目录，proc并不是真正的文件系统，它的定义可以参见 /etc/fstab 。	|
|	/root	|	Root用户的工作目录	|
|	/sbin	|	和bin类似，是一些可执行文件，不过不是所有用户都需要的，一般是系统管理所需要使用得到的。	|
|	/tmp	|	系统的临时文件，一般系统重启不会被保存。	|
|	/usr	|	包含了系统用户工具和程序。	|
|	    	|	/usr/bin：非必须的普通用户可执行命令	|
|	    	|	/usr/include：标准头文件	|
|	    	|	 /usr/lib:/usr/bin/ 和 /usr/sbin/的库文件	|
|	    	|	 /usr/sbin:非必须的可执行文件	|
|	    	|	/usr/src:内核源码	|
|	    	|	/usr/X11R6:X Window System, Version 11, Release 6.	|
|	/srv	|	该目录存放一些服务启动之后需要提取的数据	|



#### 1.5.2、二说：  

1. 根(root)：也叫做斜线(/)目录，它是目录树的最高层目录。创建根分区时，需要确认根应该包含 /etc， /bin，/sbin，/lib 和 /dev 目录，否则系统将不能引导。也需要确保根分区至少分配了 150-250MB 的磁盘空间。
2. /home：此目录包含所有用户特定的文件和数据。在多用户系统上，每个用户都将个人数据存放到到此目录的一个子目录中。此目录的大小依赖于系统的用户数以及他们在目录中存放的文件。理想地，您应该根据计划使用量计划好此分区的磁盘空间。通常，可以为每位用户分配大约 100-MB 磁盘空间。然而，如果计划在的 /home 目录存放很多多媒体文件，可能需要预备更大量的空间。
    - 将 /home 放到单独的分区是个好做法，因为这使从一个发行版平滑地过渡到另外一个成为可能。
3. /var：此目录包含可变数据，例如新闻文章、电子邮件、网站、数据库和包管理系统缓存。此目录的大小也依赖于系统使用情况。最有可能的情况是，此目录的大小由 Ubuntu 包管理工具的使用情况决定。如果打算安装 Ubuntu 提供的所有软件包，需要为 /var 目录分配 2 到 3 GB 的磁盘空间。但是如果想要节省硬盘空间并且不打算进行任何大的软件更新，可以为 /var 目录分配最少至 30- 或 40- MB 的磁盘空间。
4. /tmp：此目录包含程序创建的临时文件。一些应用程序，包括压缩包包处理程序、光盘创作工具和多媒体软件也使用此目录来临时纯放图像文件。需要根据使用这些程序的情况计划好此目录的空间分配。
5. /usr：此目录包含所有的用户(二进制)程序，这些程序的文档和支持库。此目录趋向使用硬盘上的最大空间。因此，应该为此分区提供至少 500-MB 磁盘空间。但是，需要根据打算安装的软件包的数量和类型增大此空间。根据计划的使用量和可用的磁盘空间，可能需要为此目录分配 1.5 到 6 GB 的磁盘空间。
    - /usr 分区有时被称为用户系统资源，而此时的用户并不是原来所说的那个。

#### 1.5.3、三说：

- __/var文件系统__  
　　/var 包括系统一般运行时要改变的数据.每个系统是特定的，即不通过网络与其他计算机共享.  

1. /var/catman  
　　当要求格式化时的man页的cache.man页的源文件一般存在/usr/man/man* 中；有些man页可能有预格式化的版本，存在/usr/man/cat* 中.而其他的man页在第一次看时需要格式化，格式化完的版本存在/var/man 中，这样其他人再看相同的页时就无须等待格式化了. (/var/catman 经常被清除，就象清除临时目录一样.)
2. /var/lib  
　　系统正常运行时要改变的文件.  
3. /var/local  
　　/usr/local 中安装的程序的可变数据(即系统管理员安装的程序).注意，如果必要，即使本地安装的程序也会使用其他/var 目录，例如/var/lock .  
4. /var/lock  
　　锁定文件.许多程序遵循在/var/lock 中产生一个锁定文件的约定，以支持他们正在使用某个特定的设备或文件.其他程序注意到这个锁定文件，将不试图使用这个设备或文件.  
5. /var/log  
　　各种程序的Log文件，特别是login  (/var/log/wtmp log所有到系统的登录和注销) 和syslog (/var/log/messages 里存储所有核心和系统程序信息. /var/log 里的文件经常不确定地增长，应该定期清除.  
6. /var/run  
　　保存到下次引导前有效的关于系统的信息文件.例如， /var/run/utmp 包含当前登录的用户的信息.
7. /var/spool  
　　mail, news, 打印队列和其他队列工作的目录.每个不同的spool在/var/spool 下有自己的子目录，例如，用户的邮箱在/var/spool/mail 中.  
8. /var/tmp  
　　比/tmp 允许的大或需要存在较长时间的临时文件. (虽然系统管理员可能不允许/var/tmp 有很旧的文件.)  

- __/usr文件系统__  
　　/usr 文件系统经常很大，因为所有程序安装在这里. /usr 里的所有文件一般来自Linux distribution；本地安装的程序和其他东西在/usr/local 下.这样可能在升级新版系统或新distribution时无须重新安装全部程序.
1. /usr/X11R6  
　　X Window系统的所有文件.为简化X的开发和安装，X的文件没有集成到系统中. X自己在/usr/X11R6 下类似/usr .  
2. /usr/X386  
　　类似/usr/X11R6 ，但是给X11 Release 5的.  
3. /usr/bin  
　　几乎所有用户命令.有些命令在/bin 或/usr/local/bin 中.
4. /usr/sbin  
　　根文件系统不必要的系统管理命令，例如多数服务程序.  
5. /usr/man , /usr/info , /usr/doc  
　　手册页、GNU信息文档和各种其他文档文件.  
6. /usr/include  
　　C编程语言的头文件.为了一致性这实际上应该在/usr/lib 下，但传统上支持这个名字.
7. /usr/lib  
　　程序或子系统的不变的数据文件，包括一些site-wide配置文件.名字lib来源于库(library); 编程的原始库存在/usr/lib 里.  
8. /usr/local  
　　本地安装的软件和其他文件放在这里.  

## 二、使用记录
### 2.1、记录查看
>/$ ls -l

    bin
    boot
    cd..
    cdrom
    dev
    etc
    home
    lib
    lib32
    lib64
    libx32
    lost+found
    media
    mnt
    opt
    proc
    root
    run
    sbin
    snap
    srv
    sys
    tmp
    usr
    var
    initrd.img ->       boot/initrd.img-4.4.0-92-generic
    initrd.img.old ->   boot/initrd.img-4.4.0-89-generic
    vmlinuz ->          boot/vmlinuz-4.4.0-92-generic
    vmlinuz.old ->      boot/vmlinuz-4.4.0-89-generic

>/$ cat /etc/fstab

|# file system                                 |mount point    | type   | options             |dump   | pass  |
|---                                           |---            |---     |---                  |---    |---    |
|# / was on /dev/sda9 during installation      |               |        |                     |       |       |
|UUID=77d625b1-df98-4f5a-a7ca-58d92daa3aed     |    /          |   ext4 |   errors=remount-ro |0      |    1  |
|# /boot was on /dev/sda10 during installation |               |        |                     |       |       |
|UUID=c133bf6e-275c-4246-9f18-c9731741481f     |  /boot        |   ext4 |   defaults          |0      |    2  |
|# /home was on /dev/sda11 during installation |               |        |                     |       |       |
|UUID=7daeef65-acf1-4883-804d-cc26156a69e4     |  /home        |   ext4 |   defaults          |0      |    2  |
|# swap was on /dev/sda8 during installation   |               |        |                     |       |       |
|UUID=49f468e7-6bf8-43e7-b1b5-964630967ed0     |  none         |   swap |   sw                |0      |    0  |

> /$ df -h

|	Filesystem    	|	Size  	|	Used	|	Avail	|Use%	|	Mounted on	            |
|	----------	    |----------	|	--------|	-------	|-----	|	----------	            |
|	udev          	|	3.9G  	|	0	    |	 3.9G	|	0%	|	/dev    	            |
|	tmpfs         	|	789M  	|	 18M	|	 771M	|	3%	|	/run    	            |
|	/dev/sda9     	|	 29G  	|	 26G	|	 1.1G	|	96%	|	/	                    |
|	tmpfs         	|	3.9G  	|	8.8M	|	 3.9G	|	1%	|	/dev/shm	            |
|	tmpfs         	|	5.0M  	|	4.0K	|	 5.0M	|	1%	|	/run/lock	            |
|	tmpfs         	|	3.9G  	|	0	    |	 3.9G	|	0%	|	/sys/fs/cgroup	        |
|	/dev/sda10    	|	180M  	|	106M	|	  62M	|	64%	|	/boot	                |
|	/dev/sda11    	|	 58G  	|	 46G	|	 9.0G	|	84%	|	/home	                |
|	cgmfs         	|	100K  	|	0	    |	 100K	|	0%	|	/run/cgmanager/fs	    |
|	tmpfs         	|	789M  	|	 76K	|	 789M	|	1%	|	/run/user/1000  	    |
|	/dev/sda7     	|	 95G  	|	 64G	|	  31G	|	68%	|	/media/tom/other	    |
|	/dev/sda6     	|	 97G  	|	 36G	|	  61G	|	37%	|	/media/tom/VideosBooks	|

>/$ sudo fdisk -l

|	Device    	|Boot|	    Start	|	      End	|	  Sectors	|	  Size	|	Id	|	Type	                |
|	----------	|----|	----------	|	----------	|	----------	|----------	|-------|	----------          	|
|	/dev/sda1 	|*   |	2048	    |	125833215	|	125831168	|	   60G	|	7	|	HPFS/NTFS/exFAT	        |
|	/dev/sda2 	|    |	125835262	|	976773119	|	850937858	|	405.8G	|	 f	|	W95 Ext'd (LBA)	        |
|	/dev/sda5 	|    |	125835264	|	377495551	|	251660288	|	  120G	|	7	|	HPFS/NTFS/exFAT	        |
|	/dev/sda6 	|    |	377497600	|	578826239	|	201328640	|	   96G	|	7	|	HPFS/NTFS/exFAT	        |
|	/dev/sda7 	|    |	778061824	|	976773119	|	198711296	|	 94.8G	|	7	|	HPFS/NTFS/exFAT	        |
|	/dev/sda8 	|    |	578828288	|	594827263	|	15998976	|	  7.6G	|	82	|	Linux swap / Solaris	|
|	/dev/sda9 	|    |	594829312	|	654827519	|	59998208	|	 28.6G	|	83	|	Linux	                |
|	/dev/sda10	|    |	654829568	|	655218687	|	389120  	|	  190M	|	83	|	Linux	                |
|	/dev/sda11	|    |	655220736	|	778059775	|	122839040	|	 58.6G	|	83	|	Linux	                |

>/# du --max-depth=1 --human-readable

    15G     ./var   //在‘/’分区--此目录包含可变数据，例如新闻文章、电子邮件、网站、数据库和包管理系统缓存。此目录的大小也依赖于系统使用情况。最有可能的情况是，此目录的大小由 Ubuntu 包管理工具的使用情况决定。如果打算安装 Ubuntu 提供的所有软件包，需要为 /var 目录分配 2 到 3 GB 的磁盘空间。但是如果想要节省硬盘空间并且不打算进行任何大的软件更新，可以为 /var 目录分配最少至 30- 或 40- MB 的磁盘空间。
    6.6G	./usr   //在‘/’分区--/usr 文件系统经常很大，因为所有程序安装在这里. /usr 里的所有文件一般来自Linux distribution；本地安装的程序和其他东西在/usr/local 下.这样可能在升级新版系统或新distribution时无须重新安装全部程序.
    2.5G	./opt   //在‘/’分区--三方应用(可选的应用程序包)
    1.9G	./lib   //在‘/’分区--库文件(类似与Windows的.dll)
    99G     ./media //这里是挂载了内容可以不做考虑
    170G	.       //总用量不参考
    46G     ./home  //独立分区
    16K	./lost+found
    100K	./tmp
    23M	./root
    17M	./etc
    du: 无法访问'./proc/11298/task/11298/fd/4': 没有那个文件或目录
    du: 无法访问'./proc/11298/task/11298/fdinfo/4': 没有那个文件或目录
    du: 无法访问'./proc/11298/fd/3': 没有那个文件或目录
    du: 无法访问'./proc/11298/fdinfo/3': 没有那个文件或目录
    0	./proc
    du: 无法访问'./run/user/1000/gvfs': 权限不够
    18M	./run
    4.0K	./snap
    104M	./boot
    4.0K	./cdrom
    4.0K	./mnt
    4.0K	./srv
    1.9M	./dev
    13M	./bin
    3.9M	./lib32
    4.0K	./lib64
    4.6M	./libx32
    13M	./sbin
    0	./sys

>/media/tom/
# du --max-depth=1 --human-readable

    18G	./AndroidOS
    4.5G	./KnowledgePoint
    24K	./TomNote
    548K	./收藏
    14G	./视频&书籍
    35G	.


### 2.2、理解
>1. 当前使用状况  

|曾经的分区路径|曾经的分区大小  |当前的使用情况|
|:-----      |:-----:      |:-----:     |
|/           |30G          |96%         |
|/boot       |200M         |64%         |
|/home       |60G          |84%         |
|swap        | 8G          |            |

>2. 几个内存使用大户

1. 15G  ./var   
    - 在‘/’分区--此目录包含可变数据，例如新闻文章、电子邮件、网站、数据库和包管理系统缓存。此目录的大小也依赖于系统使用情况。
        1. 有可能的情况是，此目录的大小由 Ubuntu 包管理工具的使用情况决定。如果打算安装 Ubuntu 提供的所有软件包，需要为 /var 目录分配 2 到 3 GB 的磁1. 空间。
    - /var# du --max-depth=1 --human-readable
        ```
        14G	./tmp
        4.0K	./metrics
        40K	./spool
        864M	./lib
        18M	./backups
        105M	./crash
        4.0K	./snap
        4.0K	./mail
        4.0K	./local
        33M	./log
        407M	./cache
        4.0K	./opt
        15G	.
        ```
        - 可见大部分的内容都在缓存文件中
        - 保留最近30天的文件
            ```
            /var# du --max-depth=1 --human-readable
            3.7G	./tmp
            4.0K	./metrics
            40K	./spool
            864M	./lib
            18M	./backups
            105M	./crash
            4.0K	./snap
            4.0K	./mail
            4.0K	./local
            35M	./log
            407M	./cache
            4.0K	./opt
            5.1G	.
            ```
2. 6.6G	./usr   
    - 在‘/’分区。此目录包含所有的用户(二进制)程序，这些程序的文档和支持库。此目录趋向使用硬盘上的最大空间。
3. 2.5G	./opt   
    - 在‘/’分区--三方应用(可选的应用成宿包)
4. 1.9G	./lib   
    - 在‘/’分区--库文件(类似与Windows的.dll)

5. 46G  /home   独立分区
    ```
    /home/tom# du --max-depth=1 --human-readable

    4.7G	./.android
    21G	./DevSoftware
    3.9G	./SoftwareForTest
    1.3G	./下载
    2.4G	./.local
    2.1G	./.cache
    6.5G	./.Genymobile
    1.5G	./.gradle
    46G	.

    ```

>3. 缓存应该如何无痛的清除

1. /var/tmp
2. /var/log
3. /tmp
3. 策略：删除指定日期之前的所有内容。
    - `find /var/tmp  -mtime +31 -type f | xargs rm -f`
    - `find /var/tmp  -mtime +31 -type d | xargs rm -r`



>4. 总结

1. '/'根目录分区应该至少包含： /etc， /bin，/sbin，/lib 和 /dev 几个目录，否则系统无法正常启动。
2. 增长态目录：
    1. 一般不会清除(估计最大值)
        - /opt  三方应用
        - /lib  库文件
        - /usr  此目录包含所有的用户(二进制)程序，这些程序的文档和支持库。此目录趋向使用硬盘上的最大空间。
    2. 定期清除(分区定值)
        - /tmp  缓存
        - /var  也包含一个tmp文件夹也是缓存
3. 我们可以把能规格化的内容都规划下，然后把"增长态一般不会清除的文件放到“/”目录下"


## 三、理解+使用记录=决定
### 3.1、背景
1. 硬盘 500G
2. Ubuntu/Windows双系统
### 3.2 策略
- Windows操作系统60G
    - 60G系统盘
    - Ubuntu可以读取Window文件系统
- Ubuntu操作系统440G
    - 190G 系统
        - 20G   swap    扩展内存
            - _之前给了8G现在有足够的空间了多给点_
        - 30G   /var    各种系统应用的缓存——需要批处理文件定期清除内容，主要清/var/tmp
            - _之前放在根目录下-根目录30G,几乎他就占了半，好只保留30天内容之后大约5G_
        -  *G   /tmp    系统的临时文件，一般系统重启不会被保存。
            - (好多人说2G都有不够用的时候)，之前没有出现过，用了几个月的Ubuntu这个目录还是100K，听运维的朋友建议放到根目录下。
            - _在保证‘/’根目录有富余大于20G的情况下把他放在根目录不做单独分区了，如果将来可能会对这个目录有更深刻的理解现在确保它不变成麻烦就好了。_
        -  1G   /boot   Linux的内核及引导系统程序所需要的文件
            - _之前给了200M完全够用，现在给1G可以减少必要的清理次数，系统一旦出问题也好回退处理_
        - 80G   /home   用户工作目录，和个人配置文件，如个人环境变量等，所有的账号分配一个工作目录。一般是一个独立的分区。
            - _之前给了60G连带各种软件和开发工具集合(25G,新的分区中会独立出来)也才用来50G当然了安装软件会在这了放大量的配置文件也就是说一个大的应用在这里占个4G的情况是存在的(假设有10个超大应用至少需要65G),所以干脆给80G_
        - 59G    /      系统根目录
            - _根目录之前给了30G到重装的时候已经完全不够用了。旧分区中即将移除的内容(/var)约15G,所以常规占用大约也就20G左右，考了到增量给60G_
    - 250G 个人
        ```tree
         100G  /development_kit
                    ├--sdk
                    ├--jdk
                    ├--androidOS
                    ├--apache
                    ├--maven
                    └--and so on
          80G  /software
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


## 四、操作
1. 备份
2. 安装
3. [个性化](Ubuntu个性化.md)
4. 还原


## 参考：
1. http://forum.ubuntu.org.cn/viewtopic.php?t=39777
2. [锁定老帖子 主题：Linux文件系统简介](http://www.iteye.com/topic/816268)
3. [help:什么是分区](http://people.ubuntu.com/~happyaron/udc-cn/karmic-html/ch10s01.html)
4. [Linux--/var;/usr目录详解](http://www.blogjava.net/jasmine214--love/archive/2010/06/25/324502.html)
