## Ubuntu在运行软件的时候缺少依赖 .so  

一种方式是在本地查找然后设置并使用
- 运行软件的时候查看软件运行需要依赖的 .so 
    ```
    $ ldd  software
    ```
- 查找 so
    ```
    $ sudo find / -name xxxx.so
    ```
- 将.so文件路径的目录添加到/etc/ld.so.conf
    ```
    $ sudo vim /etc/ld.so.conf //文件末尾新添加一行，/home/liu/xxx.so
    ```

- 使得修改生效
    ```
    $ sudo /sbin/ldconfig
    ```


另一种方式是下载工具通过工具查找并使用 so。

- 首先安装apt-file管理器
    ```
    sudo apt-get install apt-file
    ```
- 接着更新apt-file的缓存
    ```
    apt-file update
    ```
- apt-file搜索文件依赖
    ```
    apt-file search libgthread-2.0.so.0
    ```
- 然后使用apt-get install可安装缺失的软件包
    ```
    apt-get install libglib2.0-0
    ```
- 列出包中的文件
    ```
    apt-file list 包名称
    ```





## Reference
1. [linux找不到动态链接库 .so文件的解决方法](https://www.cnblogs.com/xudong-bupt/p/3698294.html)
2. [Ubuntu使用apt-file解决库或者文件缺失依赖](https://blog.csdn.net/gatieme/article/details/52137359)
3. https://blog.csdn.net/gx19862005/article/details/48528235