1. 64位操作系统
2. 不确定系统重新分区后下述操作是否依然适用。


操作
====================================================================================================

1. UEFI 启动的时候回找到 ESP 分区中 `ESP/EFI/Boot/bootx64.efi`
2. 我们的目的是让 UEFI 启动的时候找到 GRUB 启动程序(grubx64.efi)
3. 找到 grub 启动文件并放到 `ESP/EFI/ubuntu/` 目录下(没有该目录就创建)，如果在这之后启动程序无法识别到可以通过 BOOTICE 工具进行操作
    - UEFI -> 修改启动序列 -> 添加 -> 启动文件(我现在是'\EFI\ubuntu\shimx64.efi')
4. 到哪里找到 grub 启动文件
    - 已经安装的 Ubuntu 目录 `/boot/grub/x86_64-efi`,将文件夹中所有文件(因为不知道那个有效不过听说是 efi 文件)都拷贝到`ESP/EFI/ubuntu/`
    - 再或者到 Ubuntu 预览版中拷贝文件
    - 我就不用了，我用现在留下的文件做的备份



可能碰到的情况
====================================================================================================
ESP分区操作后uefi不能认识了无法识别
- 不会的，有人操作过还留了博客

在 ESP 中配置好了 GRUB ，GRUB 没有两个系统的配置信息如何添加
```
//当前`ESP/EFI/ubuntu/grub.cfg`中的代码

search.fs_uuid 63bfd18c-ad0c-4e7a-9553-73da19ed4de1 root 
set prefix=($root)'/boot/grub'
configfile $prefix/grub.cfg
```
- 上述代码很明显是告诉 grub 配置信息在 ubuntu系统boot分区/grub/grub.cfg
    - 这个信息应该可以拷贝过来(猜测)


小结
====================================================================================================
1. 备份当前 ESP 分区中的所有内容 ESP.BAK
    - 重装操作系统 ESP 目录被重置
2. 恢复 ESP.BAK 到 ESP
    - 如果有必要就修正 ESP 中引导程序的启动顺序通过 BOOTICE

我们现在要做的：
1. 重装 Windows 
    - 做到正常引导 Windows 和 Linux 启动
2. 重装 Linux
    - 做到正常引导 Windows 和 Linux 启动

如果成功了从今以后双系统再也不会浪费我的时间了。
如果不成功就重点维护 Windows 保证可完成日常工作。



[Win10+Ubuntu双系统UEFI启动方式下GRUB消失直接进入Windows以及重装时grub-install致命错误解决方法](https://blog.csdn.net/zrf2112/article/details/71042782)