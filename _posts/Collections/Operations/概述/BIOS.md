## 一、 BIOS
BIOS是英文"Basic Input Output System"的缩略词，直译过来后中文名称就是"基本输入输出系统"。

#### 1.1、 UEFI BIOS

UEFI全称“统一的可扩展固件接口”(Unified Extensible Firmware Interface)， 是一种详细描述类型接口的标准。这种接口用于操作系统自动从预启动的操作环境，加载到一种操作系统上。通俗的说，UEFI是一种新的主板引导初始化的标注设置，具有启动速度快、安全性高和支持大容量硬盘而闻名。

#### 1.2、 Legacy BIOS
Legacy BIOS顾名思义就是指传统的BIOS，其中UEFI BIOS包括UEFI引导启动和Legacy引导启动。

#### 1.3、 小结
UEFI-BIOS 和 Legacy-BIOS 是 BIOS 在不同发展时期的两种 BIOS。其中 UEFI 新，且正在取代 Legacy BIOS

这二者也表示两种不同的启动模式,现在大多主板都兼容这两种启动模式，可自由选择。

二者启动流程如下：
1. Legacy BIOS
    - 开机 -> BIOS 初始化 -> BIOS 自检 -> 引导操作系统 -> 进入系统
2. UEFI
    - 开机 -> UEFI 初始化 --------------> 引导操作系统 -> 进入系统


## 二、 UEFI 模式安装的操作系统只能在 UEFI 模式下打开
UEFI Bios启动模式

    UEFI Bios支持两种启动模式：Legacy+UEFI启动模式和UEFI启动模式，其中Legacy+UEFI启动模指的是UEFI和传统BIOS共存模式，可以兼容传统BIOS引导模式启动操作系统；UEFI启动模式只是在UEFI引导模式启动操作系统。

提示：

    1、选定启动模式并安装操作系统，安装后只能使用设定的模式，用于启动操作系统；
    2、操作系统安装时使用Legacy+UEFI模式，兼容在传统BIOS引导模式启动操作系统；
    3、操作系统安装时使用UEFI引导模式，只能在UEFI引导模式启动操作系统。

 Legacy+UEFI模式与UEFI模式的区别

    1、Legacy+UEFI启动模式是基于某些电脑硬件设备和操作系统（如WinXP/7）还不支持基于UEFI BIOS的情况，考虑从传统BIOS引导模式启动。传统BIOS引导模式允许Hba，模块设备使用Rom选项。

    2、UEFI启动模式用于操作系统自动从预启动的操作环境，加载到一种操作系统上，从而使开机程序化繁为简，节省时间。并且支持2T以上硬盘，加强对硬件的支持，Win8之所以启动速度快，和Win8原生支持UEFI模式不无关系!


## 三、 UEFI 安装 Ubuntu













1. [UEFI和Legacy及UEFI+Legacy启动的区别](http://www.cnblogs.com/net5x/p/6850801.html)
2. [BIOS Legacy UEFI](http://www.360doc.com/content/17/0324/23/9067954_639893571.shtml)
3. [详解UEFI与Legacy+UEFI启动模式的区别](http://www.xitongcheng.com/jiaocheng/dnrj_article_1248.html)