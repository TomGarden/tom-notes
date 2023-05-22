Parallels Desktop 安装 Debian

## 0x00 . 有些软件安装后不可用 , 可以考虑重启系统试试 .

### 0.1 . 插入文字模糊相关问题
- Mac 全屏模式展示感觉十分模糊 , 看的眼镜痛 , 可以试试 `查看 -> retina 分辨率 -> 更多空间` : 文字变得非常非常小
- 在到 优化 程序中设置字体缩放为 指定倍数即可 : 试过 2  还可以
- 调整鼠标图标尺寸 `设置 -> 辅助功能`

## 0x01 . Parallels Desktop 共享宿主机和虚拟机文件(安装完成即可使用了 , 而且很好用 , 文件复制粘贴没有问题的)

- 要安装 Parallels Tools，请打开一个终端，进入 CD/DVD 驱动器目录并以 root 身份运行以下命令: "sudo ./install"。
- 注意：在某些 Linux 系统中，您可能需要先取消安装光盘的挂载然后再使用如下命令重新挂载: "mount -o exec"，完成该步骤后才能继续安装 Parallels Tools。
- 但是发现 已经具备权限的用户执行文件提示权限不足
    - 经过尝试在 [StackOverFlow](https://stackoverflow.com/a/15215411/7707781) 找到答案 : 文件系统不同
    - 到底是什么文件系统 ? 
        ``` log
        tom_debian@TomDebian:/media/cdrom0$ df
        文件系统           1K-块      已用     可用 已用% 挂载点
        udev              988100         0   988100    0% /dev
        tmpfs             202220      1272   200948    1% /run
        /dev/sda1       64753252   6436116 54995384   11% /
        tmpfs            1011084         0  1011084    0% /dev/shm
        tmpfs               5120         4     5116    1% /run/lock
        AllFiles       488245288 468886172 19359116   97% /media/psf/AllFiles   //<- 设置的宿主机的文件挂载点
        Home           488245288 468886172 19359116   97% /media/psf/Home       //<- 设置的宿主机的文件挂载点
        tmpfs             202216       128   202088    1% /run/user/1000
        /dev/sr0           73016     73016        0  100% /media/cdrom0      // <- Parallels Tools 工具挂载点和文件系统
        ```
    - 为什么在不同文件系统 , 可读却无法执行某些操作? 暂时存疑

## 0x02 . 虚拟机共享宿主机网络代理
两个动作 , 不知道到底是那个起作用 , 暂时不细究了 : 
1. mac 桥接默认适配器
2. 通过在虚拟机安装代理工具

### 2.1 对于 macos 作为宿主机  windows 作为虚拟机
0. https://newsn.net/say/parallels-connect.html
1. 宿主机安装好了 vpn 软件并调试可用
2. windows ipconfig 查看 ip : `10.211.55.7`
3. mac 查找 ifconfig | grep 10.211.55 : `10.211.55.2`
4. windows 修改 C:\WINDOWS\system32\drivers\etc\host , 添加行 `10.211.55.2 macHost`
5. windows 设置代理

## 0x03 . 修改字体 
- 字体文件拷贝到 `/usr/share/fonts` 重启后即可应用 , 可以新建一个文件夹 `mac_fonts`
- mac 终端默认字体 :  Monaco

## 0x04 . 文件管理器


## 0x05 . zsh 使用
安装后 , 如果没有默认切换成功 , 可以通过 `chsh --shell 目标 shell` 完成 
- 目标 shell 可以在 `cat /etc/shells` 查看
- 设置完成后可以通过 `cat /etc/passwd` 查看确认
- 如果不生效可以重启下再看

## 0x06 . clion 无法输入中文

Help -> Edit Custom VM Options ···
```
-Drecreate.x11.input.method=true
```