# 参考内容
1. [Setting up SSH keys for multiple Bitbucket/Github accounts](https://medium.com/@fredrikanderzon/setting-up-ssh-keys-for-multiple-bitbucket-github-accounts-a5244c28c0ac)
2. [生成新 SSH 密钥并添加到 ssh-agent](https://docs.github.com/cn/authentication/connecting-to-github-with-ssh/generating-a-new-ssh-key-and-adding-it-to-the-ssh-agent)
3. [ssh(Secure shell)工作原理:非对称加密](https://zh.wikipedia.org/wiki/Secure_Shell)

# 正文

同一台设备 , 为多个不同的 Github 账户设置不同的 SSH 秘钥配置 ;
同一台设备 , 为多个不同的 平台 GitHub / Bitbucket 设置不同的 SSH 秘钥配置 ;

## 生成一个 SSH 秘钥

进入 `.ssh` 文件夹 `cd ~/.ssh` , 如果没有可以创建一个 : `cd ~ ; mkdir .ssh ;`

生成一个秘钥(这将以提供的电子邮件地址为标签创建新 SSH 密钥。) : 
```
$ ssh-keygen -t ed25519 -C "your_email@example.com" -f generateFileName

命令的详细释义参考 man 手册
-t 指定秘钥类型支持的值有 :  dsa | ecdsa | ed25519 | rsa
-C comment : 提供一个注释(一般为邮箱地址)           
-f filename : 指定秘钥文件的文件名(个人比较喜欢指定自己的名字 , 可以缺省)
```

## 将 SSH 密钥添加到 ssh-agent : 
```
$ ssh-add generateFileName

# 如果 ssh-agent 尚未启动会报错 : Could not open a connection to your authentication agent.
# 那就先启动 ssh-agent , 再重新执行 ssh-add 动作

$ eval "$(ssh-agent -s)"
$ ssh-add generateFileName
```

## 将自己的秘钥设置到平台相应位置
参见平台说明

## 进行多平台配置
创建或者打开 ssh 配置文件 `vim ~/.ssh/config`

```
Host github.com
  HostName github.com
  IdentityFile ~/.ssh/generateFileName
```


## 完成