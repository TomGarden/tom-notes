



电脑 访问远程 SSH 主机 , 正数登录 , 避免密码输入流程

# 生成一个 SSH 秘钥

进入那个目录下 , 秘钥文件就生成在那个目录下 , 一般是 `.ssh` 中的某个子目录

进入 `.ssh` 文件夹 `cd ~/.ssh` , 如果没有可以创建一个 : `cd ~ ; mkdir .ssh ;`

生成一个秘钥(这将以提供的电子邮件地址为标签创建新 SSH 密钥。) : 
```
$ ssh-keygen -t ed25519 -C "your_email@example.com" -f generateFileName

命令的详细释义参考 man 手册
-t 指定秘钥类型支持的值有 :  dsa | ecdsa | ed25519 | rsa
-C comment : 提供一个注释(一般为邮箱地址)           
-f filename : 指定秘钥文件的文件名(个人比较喜欢指定自己的名字 , 可以缺省)
```


# 将 公钥 写入服务端
```
[root@host ~]$ cd .ssh
[root@host .ssh]$ cat id_rsa.pub >> authorized_keys

[root@host .ssh]$ chmod 600 authorized_keys
[root@host .ssh]$ chmod 700 ~/.ssh
```

# 设置 SSH，打开密钥登录功能
编辑 `/etc/ssh/sshd_config` 文件，进行如下设置：
```
RSAAuthentication yes
PubkeyAuthentication yes
PermitRootLogin yes          # 允许 root 登录
# PasswordAuthentication no  # 禁止密码登录
```

# 重启 SSH server
```
$ sudo service sshd restart
```