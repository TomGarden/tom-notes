## SSH 常用操作

> 写在正文之前 : 以下文字的底稿在 [Setting up SSH keys for multiple Bitbucket/Github accounts](https://medium.com/@fredrikanderzon/setting-up-ssh-keys-for-multiple-bitbucket-github-accounts-a5244c28c0ac) 有重大出入。

每次我换电脑都要为自己的代码仓库们重新设置 SSH key 。
但是每次我又都会忘记如何为自己的不同账号设置 SSH key，这导致我必须要去 Google 和查看我的旧机器的 `.ssh` 文件。

所以写下这些文字给将来的自己看，如果你有需要的话也可以拿走。

### 0x01、 生成 keys

> 如果在后续密码提示的时候输入密码 每次 push 都需要输入密码。如果不输入密码两次回车即可 。

```
//在 ～/.ssh/ 目录下执行此命令
ssh-keygen -t rsa -b 4096 -C "your_email@example.com" -f "file_name"
```
- `-t type`     指定要创建的密钥类型。可以使用："rsa1"(SSH-1) "rsa"(SSH-2) "dsa"(SSH-2)
- `-b bits`     指定密钥长度。对于RSA密钥，最小要求768位，默认是2048位。DSA密钥必须恰好是1024位(FIPS 186-2 标准的要求)。
- `-C comment`  提供一个新注释
- `-f filename` 指定密钥文件名。

执行上述命令后会在 `～/.ssh/` 生成两个文件 : `file_name` 和 `file_name.pub`
- file_name 是私钥，不可示人
- file_name.pub 是公钥，用于示人 , `cat file_name.pub`

将 `.pub` 文件中的内容复制到三方网站就可以使用一般的功能了。

### 0x02、 生成多个 keys

考虑这种情况共有三个远程仓库 gitHub1 ， gitHub2 , bitbucket3 。
如果我们需要不同的仓库使用不同的 SSH key 应该怎么办？

**可以通过编辑 `~/.ssh/config` 实现此需求**

其细节可以用命令查看 `man ssh_config` ，当前只用到加粗的两个

- **Host   别名**
- **HostName   主机名**
- Port   端口
- User   用户名
- IdentityFile   密钥文件的路径
- IdentitiesOnly     只接受SSH key 登录
- PreferredAuthentications   强制使用Public Key验证

```
#~/.ssh/gitHub1 秘钥对应的仓库 
Host gitHub1.github.com
  HostName github.com
  IdentityFile ~/.ssh/gitHub1

#~/.ssh/gitHub2 秘钥对应的仓库 
Host gitHub2.github.com
  HostName github.com
  IdentityFile ~/.ssh/gitHub2

#~/.ssh/bitbucket3 秘钥对应的仓库 
Host bitbucket3.bitbucket.org
  HostName bitbucket.org
  IdentityFile ~/.ssh/bitbucket3
```

如果还是不太清楚 Host 的含义可以看本文第三节

### 0x03、 如果过去都是通过 HTTP 提交 push 请求如何切换为 SSH

找到对应仓库的本地目录中的 `local_path/.git/config`
```
[remote "origin"]
	url = https://github.com/TomGarden/reporsitory.git

    //注意: 替换为(注意 gitHub1 字段):  
    //注意: reporsitory 代表项目名
    url = git@gitHub1.github.com:TomGarden/reporsitory.git
```




## Reference
1. [Setting up SSH keys for multiple Bitbucket/Github accounts](https://medium.com/@fredrikanderzon/setting-up-ssh-keys-for-multiple-bitbucket-github-accounts-a5244c28c0ac)
2. [廖雪峰](https://www.liaoxuefeng.com/wiki/896043488029600/896954117292416)
3. [使用 SSH 连接到 GitHub](https://help.github.com/cn/articles/connecting-to-github-with-ssh)
4. [Bitbucket Support](https://confluence.atlassian.com/bitbucket/set-up-an-ssh-key-728138079.html)
5. [ssh-keygen](http://linux.51yip.com/search/ssh-keygen)
6. man ssh-keygen