

# 背景 : 要在远程主机上做开发工作 , 少不了要有更换远程机器 , 或者远程机器损坏重新配置操作系统的动作们 .
#        为了避免无谓的重复动作 , 此次配置我们将配置动作整理为 shell 脚本 , 当下次使用的时候 , 能准确运行最好 ;
#        即便无法正确运行 , 我们仍然可以调试以使其正常运行 ; 或者将其中的逻辑流程手动执行 ; 
# 此脚本的目标管理设备是 一台 远程 Debian 11-x86_64 GNU/Linux 
# 此文件的编写环境 : MacOS / vim / zsh

# 一个 新的 远程主机 , 默认是只有 root 用户的 , 我们第一步就是 :
echo "将 root 用户的密码改为我们期望的密码 : 手动完成吧 [passwd root]"

# 没有命令手册
> apt-get install man-db

# 需要一个普通用户进行日常操作
useradd --create-home --home-dir /home/tom --user-group tom

# 编辑文本不支持中文字符
# ssh 命令时 root 用户 , 没有高亮显示能力
在根目录增加配置文件(从tom用户目录拷贝过去".bashrc") , 即可解决

# 使用 sudo 命令报错 tom is not in the sudoers file.  This incident will be reported.
> 修改 sudo 配置文件 : /etc/sudoers


# 安装 zsh 
1. wget install.sh
2. 不同的用户身份执行这个 安装文件 , 为不同用户安装 zsh
3. 配置 zsh 默认显示用户名和密码 : https://github.com/ohmyzsh/ohmyzsh/issues/5686#issuecomment-298226435


# 安装 gcc : https://linuxize.com/post/how-to-install-gcc-compiler-on-ubuntu-18-04/ 
1. sudo apt-get install build-essential manpages-dev

# 配置 git 相关信息 , 方便进一步操作代码

# 配置 vim , 作为主力 程序编辑器(虽然一下诸多动作 , 但是并非按照索引顺序展开实施的「」中的顺序才是实施顺序 ) 
1. (03)显示行号
    * 通过编辑配置文件完成
    * tab 键用四个空格替代(暂未实施)
2. (04) 文件多窗口打开和编辑
    * 通过 vim tab 命令可行 / 通过 tmux 可行
3. (05)滚动翻页方式学习: 直接翻页 , 快速滚动到指定位置
    * 查看滚动相关命令 , 在 vim 编辑状态 输入命令 `:help scroll`
    * 滚动当前页面行数的一半 Control-U(向上滚动) Contorl-D(向下滚动)
4. (06)代码跳转
    * YouCompleteMe 插件解决
5. (06)代码自动补全
    * YouCompleteMe 插件解决(Control+Space)快捷键可以强制弹窗提示
    * 在这之后返现 vim 本身也有代码补全的能力,配置项是 `omnifunc`
6. 自动保存 , 无限撤回和反撤回
    * `u` 撤回
    * `control + r` 反撤回
7. 「01」*在不多次登陆 ssh 的前提下 , 打开多个已经登陆了 ssh 的命令窗 .(tmux/screen) : 首个选定的是 tmux 因为诸多赞誉*
    * tmux 需要解决一个问题 ， 就是在 tmux panel 中文字满屏后无法向上滚动的问题。(拷贝模式,或者支持鼠标操作后这就不是问题了)
    * tmux(运行于ssh服务端) 将拷贝内容同步到系统 , 并同步到 ssh 客户机
    * 上述两个问题 , 最终取消了 对鼠标的支持 , 然后拷贝问题就可以通过鼠标完成了,置于滚动动作可以在拷贝模式下使用 vi 滚动命令完成滚动
    * 后来又用上了 item2 
8. 「02」SSH 自动断开连接，表现为一段时间不在终端与远程主机交互后再次尝试交互会出现无响应现象，稍等一会自动断开 SSH 连接
    * 客户端设置`~/.ssh/config`
     ```
     # vps SSH 一直保活 ， 暂时不知道如何在比如 30 min 没有操作的情况下由客户端主动断开连接
     # ServerAliveInterval : 单位为秒的时间间隔，在这个间隔时间后没有收到服务器的响应将会发送消息请求响应。默认值为 0 表示不会发送消息到服务器。
     #                       要做到保活：由于不同设备不同网络环境的硬件软件配置不同，这个值并非永远适用，如有需要可以自行调节
     # ServerAliveCountMax ：在收不到服务器消息的情况下 ，每间隔 ServerAliveInterval 想服务发送一次消息 ，最多要发多少次，默认 3 次 。 如果超过
     #                       设置的最大次数仍然收不到服务器响应 ， 则断开连接。
     Host 自己远程主机 ip 
       ServerAliveInterval 240
     # ServerAliveCountMax 10   # 关于这一点许多博客都说要设置,我读了 man 手册,没有找到必须设置的理由,自己没有设置,问题也确实解决了.

     ```
9. 显示文件树 -> 需要安装插件 -> 安装插件前需要先了解选择哪个插件管理器
  * 目前插件管理通过 vim 自身的插件管理方式来进行详细介绍在(usr_05.txt),或者`:help package`
  * NERDTree 显示文件数目录
  * YouCompleteMe 代码补全/代码跳转


## 一、 Debian 远程主机中文乱码 
1. 细节描述 ， 实际上是支持中文的 ， 但是输入一大串中文 ， 偶尔有几个可以正常展示 ， 其他的都不能正常展示 。 
2. 在一个单独的行输入一个汉字 ， 有时候可以正常展示， 但是要删除这个汉字 需要三次 退格动作 。 

Debian 是一个国际化的操作系统 ， 它支持为系统指定字符集 。
不同的字符集支持不同的符号 ，不同的符号可以被理解为不同的语言 。
为系统指定字符集也就是指定系统支持的语言。
我们在使用过程中出现乱码的原因也就是我们输入的字符没有被系统当前指定的字符集所包含，所以会出现乱码。

为什么操作系统不会直接内置世界上所有语言的字符集 ？ 
因为， 字符集很多字符更多 ， 全部内置不必要 ， 用户根据需要配置自己的字符集更能节省磁盘资源 。

接下来我们需要回答两个问题了：
1. 我怎么知道自己的系统当前支持什么字符集？
2. 我的 Debian 如何指定系统的语言和字符集？
3. 我希望系统正常支持中文 ， 我应该为系统指定什么字符集？
    - 从 Debian 的文档我们大致可以知道 我们期望系统支持的字符集为
    - `zh_CN.UTF-8`


完整的 locale 描述包括三个部分：xx_YY.ZZZZ。
1. xx: ISO 639 个语言代码(小写)
2. YY: ISO 3166 个国家代码(大写)
3. ZZZZ: 编码集，例如，字符集或编码标志。



软件 `locale` 可以查看当前系统支持的字符集
```
➜  ~ locale -a  
C               # ASCLL 码 字符集
C.UTF-8         # ASCLL 码 utf8 字符集
en_US.utf8      # 美式英语 UTF-8 字符集
POSIX           # ASCLL 码 字符集
```

`locale-gen` 程序可以帮助用户下载指定的字符集资源文件 。
```
# 我们期望系统支持更多的字符集 
# /usr/share/i18n/SUPPORTED 文件中列出了系统支持的字符集
# zh_CN.UTF8   UTF8
# 在操作远程计算机的情况下 ， 只要与本地 的 locale.gen 相同即可 ， 如果要支持其他字符再作额外添加
# 如果 需要安装 sudo apt-get install locales ； 安装前 先看看 /usr/sbin/locale-gen 这里是否存在

# 在 /etc/locale.gen 文件中增减用户期望的字符集 后 
# 执行 locale-gen 相关的字符资源会相应的被增加和删除

➜  ~ sudo /usr/sbin/locale-gen
Generating locales (this might take a while)...
  en_US.UTF-8... done
  zh_CN.UTF-8... done
Generation complete.

```

再看看就有了 
```
➜  ~ locale -a 
C
C.UTF-8
en_US.utf8
POSIX
zh_CN.utf8     # 这里
```

至于 tty terminal 知否支持中文 ， 还是另外通过软件(fbterm) 转发, 那是另外的事情了 . 留待别处讨论 . 


### 1.x、 参考内容
1. [鸟哥私房菜](http://cn.linux.vbird.org/linux_basic/0320bash_2.php#variable_locale)
2. [Linux 服务器设置成支持中文](https://blog.csdn.net/ailongyang/article/details/54835922)
3. [字符集 & 字符编码](https://www.runoob.com/w3cnote/charset-encoding.html)
4. [Debian 官方 本地化介绍](http://qref.sourceforge.net/Debian/reference/ch-tune.zh-cn.html)
5. [locale-gen](https://manpages.debian.org/stretch/locales/locale-gen.8.en.html)
    - https://www.gnu.org/savannah-checkouts/non-gnu/sinhala/doc/howto/sinhala-howto.html
    - https://wiki.archlinux.org/title/Locale_(简体中文)  

### 1.xxx、 有待探究的疑问们
1. 我认为 zh_ch.utf8 是 utf8 的一个子集 ， 那里可以看到 utf8 的其他子集都有哪些 ？
    - `/usr/share/i18n/SUPPORTED` 可以查看系统支持的 字符集们