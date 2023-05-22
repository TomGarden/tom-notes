## 一、需求
碰到两次了
关于Android需要方便的执行Linux命令。
1. sqlite3 命令 command : not found
2. tcpdump 命令 command : not found

## 二、 解决方案
从网络上给定的下载地址下载一个文件放到该作者指定的位置。
暂时我们放到了 /data/local/
Linux 系统

## 三、问题
1. 该问题来自何处。(如何不依赖别人的指定)
2. 他们是如何解决这个问题的(思路怎么来)

## 四、我们把编译过的可执行文件放到什么目录下合适？

### 4.1、结论
我们后期添加的执行文件放到 /mnt/user/bin 目录下。

### 4.2、原因
我们尝试遵循一定的习惯(规范)。
1. 到 Uubntu 下做一点查看
    ```terminal
    //ls 是系统命令
    tom@ubuntu:/$ which ls
    /bin/ls

    //wireshark 是前几天使用 sudo apt-get install wireshark 命令安装的
    tom@ubuntu:/$ which wireshark 
    /usr/bin/wireshark
    ```
2. 到 Android 下做一点查(操)看(作)
    ```terminal
    //ls 是系统命令
    root@hammerhead:/ # which ls
    which ls
    /system/bin/ls

    //尝试在 /system/usr/ 下创建 bin 目录盛放我们后期加入的执行文件 --> 失败
    2|root@hammerhead:/system/usr # mkdir bin
    mkdir bin
    mkdir: 'bin': No space left on device

    //尝试在 /mnt/user 下创建 bin 目录盛放我们后期加入的执行文件 --> 成功
    root@hammerhead:/mnt/user # mkdir bin
    mkdir bin
    root@hammerhead:/mnt/user # ls
    ls
    0
    bin
    ```

## 参考
1. http://blog.csdn.net/u011068702/article/details/52225498
2. [error: only position independent executables (PIE) are supported.](http://vjson.com/wordpress/compile-tcpdump-for-android-lollipop.html)