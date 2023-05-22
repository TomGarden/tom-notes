## [别人的情况](http://bbs.chinaunix.net/thread-1942074-1-1.html)
- 问题描述：                 
用adduser命令新增了用户之后，发现在该新建用户下的命令终端，使用方向键无法调出历史命令，同时tab键也无法补全输入命令。

- 问题解决：         
在/etc/passwd中发现，该新建用户使用的shell为/bin/sh，而能正常使用的用户shell为/bin/bash，通过ls -l /bin/sh查看/bin/sh得知，在ubuntu系统中，/bin/sh默认链接为dash。
因此，只需要在/etc/passwd中修改该用户对应的shell为/bin/bash即可解决该问题。

## 我的问题

- 我的情况：             
用adduser命令新增了用户之后，发现在该新建用户下的命令终端，使用方向键无法调出历史命令，同时tab键也无法补全输入命令。

查看 /etc/passwd
```
root:x:0   :0   :root:/root     :/bin/bash
user:x:1000:1000:    :/home/user:
//用户名:口令:用户标识号:组标识号:注释性描述:主目录:登录Shell
```

我们看到 user 是没有 Shell 程序的

只需要在/etc/passwd中修改该用户对应的shell为/bin/bash即可解决该问题。

- 问题解决



## 参考 & 摘录
1. [非常详细的/etc/passwd解释](http://luzl.iteye.com/blog/564404)
2. [Linux 下/etc/passwd文件详解](http://blog.csdn.net/a1154490629/article/details/52190801)
3. [linux 里 /etc/passwd 、/etc/shadow和/etc/group 文件内容解释](http://www.cnblogs.com/suger/p/3831905.html)