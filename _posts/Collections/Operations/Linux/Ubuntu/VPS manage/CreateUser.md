0. 设置 root 账户密码
  - passwd
1. useradd tom
2. mkdir /home/tom
3. vi /etc/passwd 做如下修改，避免使用 tom 账户的时候命令行不好用
  - tom:x:1000:1000::/home/tom:/bin/bash
4. 设置 tom 密码
  - passwd tom
5. 为 tom 添加 sudo 权限
  - 




1. [Linux用户配置sudo权限(visudo)](http://blog.csdn.net/a19881029/article/details/18730671)
