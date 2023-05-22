tmux 作用 
1. 避免远程操作主机时意外断开后，操作进度丢失
2. 一个 SSH 连接成功后，可打开多个终端

tmux 使用教程
1. [重点深入阅读,必要时候翻看](https://github.com/tmux/tmux/wiki/Getting-Started)
2. 扫盲,官方信息不满足需求的时候,可以看看其他用户是如何使用 tmux 的
    - https://www.cnblogs.com/zuoruining/p/11074367.html
    - [阮一峰:Tmux 使用教程](https://www.ruanyifeng.com/blog/2019/10/tmux.html)


关于 tmux 的个人诉求
1. 惯用的鼠标操作不可用了, 尤其是当一个 panel 文字多到自动向下滚动的情况下 , 想要翻看隐藏的内容 , 鼠标操作无效 .
   说是 tmux 的按键和 Emacs 类似 , 但是我没用过 Emacs , 在将来也想以 Vim 做主力编辑器 .
2. 希望可以通过 鼠标 对 tmux 的 session/window/panel 进行操作 .
3. 希望 tmux 的按键可以和 vim 类似 .


对于鼠标的支持 , [官方有一个专门的小段落](https://github.com/tmux/tmux/wiki/Getting-Started#using-the-mouse)
1. 按下 control-b  , 这意味着 , 在这之后的快捷键都会被 tmux 接收
2. 输入 `:set -g mouse on` , 在这之后就可以使用 鼠标操作了.
3. 这种设置是临时的 , 当 tmux server 被杀死后 , 再重新启动 , 这个设置便失效了
4. [`-g`的含义是](https://man.openbsd.org/tmux#set-option) : 全局的 session 和 window 都应用此配置
   

[想要持久化某些配置, 当 tmux server 重启后之前的设置仍然生效](https://github.com/tmux/tmux/wiki/Getting-Started#configuring-tmux)
tmux server 启动的时候会自动加载 `~/.tmux.conf` , 所以自己的持久性的配置信息可以写在这里 .
1. 配置完成后生效方式有二 **重启 tmux server** / **:source-file 配置文件路径(这里是 `~/.tmux.conf`)**


由于更希望习惯 vim 相关操作和命令, 所以 `~/.tmux.conf` 设置内容如下
```
# 配置文件引导 : https://github.com/tmux/tmux/wiki/Getting-Started#configuring-tmux
# [`-g`的含义是](https://man.openbsd.org/tmux#set-option) : 全局的 session 和 window 都应用此配置


# 允许鼠标操作 , 设置了鼠标操作 , 还需要额外考虑复制内容如何同步到tmux 外部以及如何同步到 客户机 , 所以不设置了 .
# 拷贝内容同步是有解决办法的,只是不想麻烦了 : https://github.com/tmux/tmux/wiki/Clipboard
#set -g mouse on

# mode-keys [ vi| emacs] : 在复制模式下使用 vi 或 emacs 样式的键绑定。默认为 emacs，除非VISUAL或EDITOR 包含 ' vi'。
set -g mode-keys vi

# status-keys [ vi| emacs] : 在状态行中使用 vi 或 emacs 样式的键绑定，例如在命令提示符下。默认为 emacs，除非设置了 VISUAL 或 EDITOR 环境变量并包含字符串 ' vi'。
set -g status-keys vi
```


## tmux 全局配置

vim /etc/tmux.conf

‵‵‵
# tmux 全局配置文件
# 配置教程
#    1. https://github.com/tmux/tmux/wiki
#    2. http://man.openbsd.org/OpenBSD-current/man1/tmux.1#prompt-history-limit

# 此为 tmux 的全局配置文件 关于这个文件的位置和名称， 可以在 配置教程2 中了解到 。
# 关于如下配置的语法可以查看 ： http://man.openbsd.org/OpenBSD-current/man1/tmux.1#OPTIONS

# 没个 widnow 可以查看的历史记录的行数 ， 查看历史记录的快捷键  ctrl+b [
# 清除 windows 历史 ‵clear; tmux clear-history‵
set -g history-limit 5000

# 开启鼠标模式
set -g mouse on

‵‵‵


## tmux 查看快捷键 
-  ‵C-b ?‵
- 在查看模式下搜索 `Ctrl+s` 输入文本 `enter` , `n` 向下查找，`shift+n` 向上查找货。 