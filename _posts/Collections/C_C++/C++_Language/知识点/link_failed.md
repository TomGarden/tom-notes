

## 错误信息方便全文检索到本文件
```
我是索引 : /usr/bin/ld: xxxxxx
我是索引 : undefined reference to xxxxxx
```



## 8.1. 如何获取依赖库名称字段 , 方便编译命令编写 
如果我们手动编译了一个依赖库 , 并且可以正常使用 , 我们可以猜到 `-l` 命令为 `-lfastcgipp` ; 如果我们猜不到 `-lfastcgipp` , 我们应该如何理性判断 , 得到这一命令字段呢 ?

https://www.learncpp.com/cpp-tutorial/a1-static-and-dynamic-libraries/
- Linux 系统上编译后的库通常放置在 `/usr/lib` 根据对库的了解着这里应该可以看到名称类似的 so 文件

## 8.2. 查找静态库
**__如果我们只知道一个文件名 , 如何判断它属于哪个动态或者静态库?**
**__如果我们知道动态库的安装指令如何查看动态库的链接字段呢 ?**


我们已经知道了我们需要引用的一个头文件 `fcgio.h` ; 应该如何判断改文件所属库 . 
只有有了文件所属的库名称才能 在编译的时候指定连接  `-lxxxx`

方法一(根据本地已有的文件做出响应,本地无文件则不响应):
```
$ dpkg --search /usr/include/fcgio.h            <!-- 查看 fcgio.h 属于那个包-->
libfcgi-dev:amd64: /usr/include/fcgio.h
$ dpkg --listfiles  libfcgi-dev                 <!-- 列出包中所有文件 -->
...
/usr/lib/x86_64-linux-gnu/libfcgi++.a
/usr/lib/x86_64-linux-gnu/libfcgi.a
...
/usr/lib/x86_64-linux-gnu/libfcgi++.so          <!-- 截取 .a / .so 文件中的字段 fcgi++ 即可 -->
/usr/lib/x86_64-linux-gnu/libfcgi.so
...
/usr/lib/x86_64-linux-gnu/pkgconfig/fcgi++.pc   <!-- 好像取 .pc 结尾的文件的文件名也行哈 -->
/usr/lib/x86_64-linux-gnu/pkgconfig/fcgi.pc
...
``` 

方法二(根据从网络更新的数据库信息作出相应 , 只要远程仓库有信息即可响应 , 响应结果不代表本地实际情况): 
```
$ sudo apt-get install apt-file                 <!-- 安装 apt-file -->
$ sudo apt-file update                          <!-- 更新 apt-file 数据库 -->
$ apt-file find fcgio.h                         <!-- 查看 fcgio.h 属于那个包 -->
libfcgi-dev: /usr/include/fcgio.h 
apt-file find fcgio.h
libfcgi-dev: /usr/include/fcgio.h
...
$ apt-file show libfcgi-dev                     <!-- 根据输出可以了解 库的动态连接名称字段 -->
...
libfcgi-dev: /usr/include/fcgio.h                        
libfcgi-dev: /usr/include/fcgios.h
libfcgi-dev: /usr/lib/x86_64-linux-gnu/libfcgi++.a
libfcgi-dev: /usr/lib/x86_64-linux-gnu/libfcgi++.so 
libfcgi-dev: /usr/lib/x86_64-linux-gnu/libfcgi.a
libfcgi-dev: /usr/lib/x86_64-linux-gnu/libfcgi.so
libfcgi-dev: /usr/lib/x86_64-linux-gnu/pkgconfig/fcgi++.pc
libfcgi-dev: /usr/lib/x86_64-linux-gnu/pkgconfig/fcgi.pc 
```