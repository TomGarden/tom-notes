# 第一个 VPS
1. 无论如何我购买了一个 Ramnode 的 VPS 。
2. 接下来一切都不同了，我的精力接下来应该放到如何配置我的 VPS 了。
3. 那好我们压抑一下急切的心情来认识一下这个新事物吧。

## 一、 [购买](InitVerticalPrivateRoom.md)
了解并选购一个 VPS 的工作我们已经做完了，在这个过程中：
1. 付款之后我们收到了来自 Ramnode 的邮件，邮件中包含如下内容
    1. VPS 详细信息
        - 主机简略配置信息
        - 主机名
        - 主机 IP
    2. VPS 控制面板相关信息

    3. 系统安装指引

[RamNode 告诉我们如何登录 SolusVM 以及可选的操作系统以及一些常见的问题如何处理](https://clientarea.ramnode.com/knowledgebase.php?action=displayarticle&id=44)

接下来我们着重了解下上述 2 / 3 点相关内容。

## 二、VPS 控制面板 ： [SolusVM](https://solusvm.com/)
- __What is SolusVM?__
Solus Virtual Manager (SolusVM) is a powerful GUI based VPS management system with full OpenVZ, Linux KVM, Xen Paravirtualization and Xen HVM support. SolusVM allows you and your clients to manage a VPS cluster with security & ease.

### 2.1、 SolusVM 如何工作？
- __VPS 是什么:__VPS（Virtual Private Server 虚拟专用服务器）技术，将一台服务器分割成多个虚拟专享服务器的优质服务。
- 在我们的 VPS 上还没有安装系统的时候我们是如何管理它的，SolusVM 是一个什么样的存在？它工作在什么地方？
- __猜测：__服务器中首先安装一个操作系统，作为管理者(父操作系统)，在这个操作系统下又进行了若干(厂商决定具体数量)子操作系统的安装，我们的 SolusVM 就运行在这个“父”操作系统中。
    - 如果是这种情况的话，除了向厂商做出申请，我们是不能切换 VPS 管理工具的，也就是说我是没有权限把 SolusVM 换成另一个同类型的 VPS 管理工具的。

### 2.2、 SolusVM 如何使用之：快捷按钮
1. Home
2. Virtual Servers
3. My Account

上述菜单栏 1|2 没有不同，连 URL 都是相同的，3 是账户管理，管理账户信息，可以用来修改密码。

在 1|2 中选择自己的 VPS 到达 VPS 管理界面。包含：
- VPS 基础状态信息，一眼看明白。
- 快捷操作按钮
    |Button Name           |Button Effect                                                        |
    |----------------------|---------------------------------------------------------------------|
    |Reboot                |                                                                     |
    |Shutdown              |                                                                     |
    |Boot                  |                                                                     |
    |Reinstall             |                                                                     |
    |VNC                   |VNC (Virtual Network Console)是虚拟网络控制台的缩写。就是我们 VPS 的控制台  |
    |Log                   |上不明白具体指什么                                                      |
    |Power Off             |                                                                     |
    |Reconfigure Networking|不理解                                                                |

Reinstall 的作用应该就是安装，只是这个按钮在首次使用 VPS 的时候有歧义(边界值 ^_^)。

### 2.3、 SolusVM 如何使用之：表单选项
1. Settings
    - APIC[On/Off : 默认 On]
        -
    - ACPI[On/Off : 默认 On]
    - VNC[On/Off : 默认 On]
    - PAE[On/Off : 默认 Off]

2. CDRom
3. Drivers
4. Hostname
5. Clock
6. Video
7. Root/Admin Password
8. VNC Password
9. Network
10. API
11. Statistics



## 三、 安装和配置
上面还有没搞懂的，不管了，忍不住啦，先操作能操作的内容吧。

### 3.1、 安装 OS 登录 root 账户

1. Click Reinstall
2. Select System  小于 2G 的内存确实建议 32 位操作系统
3. Click Reinstall
    - Installation has been started. Please allow up to 10 minutes for it to complete
    - Root/Admin Password:XXXXXXXXXX

安装完成不知道怎么登录了
```
Ubuntu 14.04 LTS xxx tty1  
xxx login:
```
这里是要我们输入用户名啊，但是用户名是什么啊？在重装的时候我们只得到了密码啊。
- root 是可以登录的。
- 事实上此时也只有 root 一个用户

### 3.2、 管理 & 操作 -> VPS
1. 通过 VNC
2. 通过 SSH   
    - 对于命令操作体验更佳 ^_^ .


### 3.3、 创建子账户
为了防止误操作，我们需要一个子账户作为常用账户。
1. 首先详细了解下 useradd 命令是很有必要的，不同的操作系统可能有细微的差异。`man useradd`
    - `useradd -d xxx -m /home/xxx` 解释如下：
    -  (-d)通过默认的方式，(xxx)创建用户名为 xxx 的用户,(/home/xxx)用户目录为 /home/xxx,(-m)如果该目录不存在则创建
    - `cat /etc/passwd`  -> 查看自己创建账户是否完成了。
    - `userdel -r xxx` -> 删除账户并且删除与其相关的一切。
2. 为账户设置密码
    - 查看密码 ： `cat /etc/shadow`
    - 密码格式 `登录名:加密口令:最后一次修改时间:最小时间间隔:最大时间间隔:警告时间:不活动时间:失效时间:标志`

        |字段|含义                             |
        |---|---------------------------------|
        |!! |密码已经过期了                     |
        |!  |锁定-表示这个帐号并不会被用来登入的意思|    
        |$6$|SHA-512加密的                     |    
        |$1$|MD5加密的                         |    
        |$2$|Blowfish加密的                    |    
        |$5$|SHA-256加密的                     |    

    - 为新用户设置密码：`passwd xxx`
    - 更改 Root 密码：`passwd root`
3. 这一个过程还没有完
    1. 我们为什么要创建子账户？
        - 为了避免误操作。
    2. 那么我们一些敏感性的操作需要怎么进行呢？
        - 再出现 sudo 之前，人们都是 su 使用 root 账户操作(必须要使用 su 命令的人知道 root 密码)。
        - 有了 sudo 之后 root 用户只需要为其配置足够的权限，便可以以，root 权限进行操作了。并且这些操作都会以日志的形式详细保存下来。
    3. 我们现在碰到的问题就是：尝试使用 `sudo xxx` 进行命令行操作的时候有提示说：`username is not in the sudoers file.  This incident will be reported.`
        - 这是说当前用户没有权限呢。我们需要先去为当前用户配置权限
    4. 开始通过 root 用户为其他用户配置 sudo 权限。
        - 解决方法就是在/etc/sudoers文件里给该用户添加权限
            ```
            youuser            ALL=(ALL)                ALL
            %youuser          ALL=(ALL)                ALL
            youuser            ALL=(ALL)                NOPASSWD: ALL
            %youuser          ALL=(ALL)                NOPASSWD: ALL

            第一行:允许用户youuser执行sudo命令(需要输入密码).
            第二行:允许用户组youuser里面的用户执行sudo命令(需要输入密码).
            第三行:允许用户youuser执行sudo命令,并且在执行的时候不输入密码.
            第四行:允许用户组youuser里面的用户执行sudo命令,并且在执行的时候不输入密码.

            值的注意的是上面说的密码并不是 root 密码而是本用户密码。贼尴尬。
            ```
        - vi 用不习惯可以先安装 vim
        - 然后写入上述命令 `w!` -> 这是只读文件，只能强制写入。
    5. sudo 命令已经可用了。

### 3.4、 sudo apt-get upgrade
感觉有异常的地方
```
perl: warning: Setting locale failed.
perl: warning: Please check that your locale settings:
	LANGUAGE = (unset),
	LC_ALL = (unset),
	LC_TIME = "zh_CN.UTF-8",
	LC_MONETARY = "zh_CN.UTF-8",
	LC_ADDRESS = "zh_CN.UTF-8",
	LC_TELEPHONE = "zh_CN.UTF-8",
	LC_NAME = "zh_CN.UTF-8",
	LC_MEASUREMENT = "zh_CN.UTF-8",
	LC_IDENTIFICATION = "zh_CN.UTF-8",
	LC_NUMERIC = "zh_CN.UTF-8",
	LC_PAPER = "zh_CN.UTF-8",
	LANG = "en_US.UTF-8"
    are supported and installed on your system.
perl: warning: Falling back to the standard locale ("C").
```
解决方案：http://blog.csdn.net/permike/article/details/54576417
- [perl: warning: Setting locale failed.引发的问题](perl_warning_Setting_locale_failed.引发的问题.md)

### 3.4、 查阅 Ramnode 邮件提供的引导页面
__Missing Swap__
>SolusVM KVM templates have a tendency to not set up swap correctly. Please enter the following in SSH to create your swap:
>>      swapoff /dev/vda2
>>      mkswap /dev/vda2
>>      swapon /dev/vda2
>    You should do the above commands particularly if you see "cannot allocate memory" errors when updating.

查看|管理 Swap 相关命令
1. fdisk -l
2. free -m

没有什么异常发现

## 四、 我们可以安装 vpn 客户端了
现在一切都完美了，我们可以安装 VPN 客户端了。


## 观察
上述过程中我一直开着 ping ip 时长查看，当前观察到的时间在 200~600 不等，不同时段会有不同的响应时间。

## 参考 & 抄录
1. 没看到有用的内容：https://documentation.solusvm.com/display/DOCS
2. [VNC](https://baike.baidu.com/item/VNC/2906305?fr=aladdin)
3. [严重依赖：KVM Information / Installation Guide](https://clientarea.ramnode.com/knowledgebase.php?action=displayarticle&id=44)
4. [大地博客：SolusVM(VPS管理面板)使用教程](http://www.dadi666.com/763)
5. [“xxx is not in the sudoers file.This incident will be reported” 错误解决方法](http://www.linuxidc.com/Linux/2016-07/133066.htm)
