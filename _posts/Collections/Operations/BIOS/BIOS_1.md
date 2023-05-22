# BIOS 翻译

## 一、Main
|key             |value                                   |           说明                     |
|----------------|-----------------------------           |------------                        |
|System Time     |[20:54:17]                              |                                    |
|System Date     |[wed 10/25/2017]                        |                                    |
|BIOS Version    |A08                                     |                                    |
|Produce Name    |Vostro 2421                             | 产品名称                            |
|Asset Tag       |None                                    | ( 资产标签 ),厂家可能会写入编号,方便官方管理和售后。 部分有,部分机型没有,|
|CPU Type        |Intel(R) Core(TM) i5-3337U CPU @ 1.80GHz|                                    |
|CPU Speed       |1800 MHz                                | CPU频率                            |
|CPU ID          |306a9                                   |                                    |
|CPU Cache       |                                        |CPU缓存                             |
|L1 Cache        |64 KB                                   |CPU一级缓存                          |
|L2 Cache        |512 KB                                  |CPU二级缓存                          |
|L3 Cache        |3072 KB                                 |CPU三级缓存                          |
|Fixed HDD       |ST500L T012-1DG142 (500GB)              |                                    |
|SATA ODD        |Samsung SSD 850 EVO (250GB)             |SATA（Serial ATA）口的硬盘又叫串口硬盘 ; 光盘驱动器(ODD)|
|AC Adapter Type |65 W                                    |交流电适配器类型                     |
|System Memory   |8192 MB (DDR3)                          |内存                                |
|Extended Memory | 640 KB (DDR3)                          |扩展内存                             |
|Memory Speed    |1600 KB (DDR3)                          |储存速率                             |




## 二、 Advanced    
|key                      |value               |           说明                     |
|-------------------------|------------------- |------------                        |
|Intel(R)SpeedStep(TM)    |[Enabled/Disabled]  |Intel 自动变频技术：让电脑决定 CPU 频率是否自动调节，可以再轻度负载的时候降低 CPU 频率而达到省电功能，重度负载时处理器频率会增加，相当于自动调频。|
|Virtualization           |[Enabled/Disabled]  |虚拟机技术 ：需要装虚拟机的同学应该开启，否则开不开随意，默认开启。|
|Integrated NIC           |[Enabled/Disabled]  |是否开启集成网卡。默认开启。           |
|USB Emulation            |[Enabled/Disabled]  |在不支持 USB 外设的系统中（如 DOS）提供对 USB 键盘/鼠标的支持，默认开启。|
|USB Wake Support         |[Enabled/Disabled]  |决定是否可以让 USB 设备唤醒电脑，默认关闭，是否开启根据个人需求决定。|
|SATA Operation           |[AHCI/IDE]          |SATA 控制器模式。默认 AHCI ，强烈建议 AHCI。普通 IDE 模式会损失硬盘/固态盘的性能。安装系统后这项不可以随意更改，否则会蓝屏。除非有特殊需求，否则这项不要轻易改动。|
|Adapter Warnings         |[Enabled/Disabled]  |Adapter Warnings: 电源适配器警告。当发现不兼容或低性能的电源适配器时会出现提示。|
|Function Key Behavior    |[Function/]         |选择开机时默认是功能键还是多媒体键。默认 Multimedia Key 多媒体键。 （功能键即为 F1~F12，多媒体键即为控制音量等功能。可以用 Fn + ESC 在两者间切换）|
|Miscellaneous Devices    |  __待续__          |其他设备的设置。|

## 三、 Security


## 四、 Boot

### 4.1、 Boot List Option ： Legacy
|key                      |value               |说明         |
|-------------------------|------------------- |-------------|
|Boot List Option         |[Legacy/UEFI]       |当前 Legacy   |
|Secure Boot              |[Enabled/Disabled]  |不可选状态    |
|Load Legacy Option Rom   |[Enabled/Disabled]  |不可选状态    |
|Set Boot Priority        |                    |             |
|1st Boot Priority        |Hard Diver          |硬盘         |
|2nd Boot Priority        |Diskette Dirver     |软盘         |
|3rd Boot Priority        |USB Storage Device  |USB 存储设备  |
|4th Boot Priority        |CD/DVD/CD-RM Drive  |光驱设备      |
|5th Boot Priority        |Network             |网络          |
### 4.2、 Boot List Option ： UEFI
|key                         |value               |说明      |
|-------------------------   |------------------- |----------|
|Boot List Option            |[Legacy/UEFI]       |当前 UEFI  |
|File Browser Add Boot Option|ST500L T012-1DG142  |添加启动项  |
|File Browser Del Boot Option|UEFI:IP4/IP6        |删除启动项  |
|Secure Boot                 |[Enabled/Disabled]  |Secure BOOT设计之初作用是防止恶意软件侵入。|
|Load Legacy Option Rom      |[Enabled/Disabled]  |恢复legacy rom的默认值|
|Boot Option Priorities      |                    |            |
|Boot Option #1              |UEFI:IP4····        |            |
|Boot Option #1              |UEFI:IP6····        |            |

Secure BOOT作用：
1. Secure BOOT设计之初作用是防止恶意软件侵入。事实上它能够做到的仅仅是，当电脑引导器被病毒修改之后，它会给出提醒并拒绝启动，避免可能带来的进一步损失。
2. 更多的人认为，这是微软为了防止安装Windows操作系统的电脑改装linux。客观的讲，微软设计Secure Boot的原本用意可能是出于保证系统安全，但结果似乎成了PC厂商保护市场垄断、阻碍竞争的一种手段。
3. Secure Boot是UEFI BIOS的一个子规则，位于传统(Legacy)BIOS的BOOT选项下，微软规定，所有预装Win8操作系统的厂商(即OEM厂商)都必须打开Secure Boot(在主板里面内置Win8的公钥)。部分主板该选项是Secure Boot Contrl，位于Security选项下。预装Win8系统电脑，一旦关闭这个功能(将其设置为“Disabled")，将导致无法进入系统。





## 参考 
1. [基本输入输出系统BIOS(Basic Input Output System)](https://baike.baidu.com/item/bios/91424?fr=aladdin)
2. [CPU缓存](https://baike.baidu.com/item/CPU%E7%BC%93%E5%AD%98/3728308?fr=aladdin)
3. [SATA硬盘](https://baike.baidu.com/item/SATA%E7%A1%AC%E7%9B%98/3947233)
4. [ODD，Optical Disk Driver的缩写，即是光盘驱动器的英文名](https://baike.baidu.com/item/odd/7400084?fr=aladdin#3)
5. [Sun Blade X3-2B（以前称为 Sun Blade X6270 M3）管理指南](https://docs.oracle.com/cd/E37440_01/html/E36286/glvnf.html)
6. [Intel(R) speedstep(TM) Technology](https://zhidao.baidu.com/question/576636467.html)
7. [【技术】戴尔游匣7559 隐藏技巧/疑难问题/BIOS设置指南](http://tieba.baidu.com/p/4690919547)
8. [bios设置里面的secure boot是干什么用的？](https://zhidao.baidu.com/question/1112187365007063259.html)
9. [BIOS中的 load legacy option rom什么意思？](https://zhidao.baidu.com/question/917922703470847659.html)