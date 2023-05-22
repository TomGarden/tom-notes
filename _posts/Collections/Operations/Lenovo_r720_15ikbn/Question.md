安装 Ubuntu 后无法链接网络(有线/无线)
- 关闭 Bios 中的 Security Boot ， 之后可以链接有线网络了

无法链接无线网络
```
tom@lover:~$ rfkill list all
0: ideapad_wlan: Wireless LAN
	Soft blocked: no
	Hard blocked: yes
1: ideapad_bluetooth: Bluetooth
	Soft blocked: yes
	Hard blocked: yes
2: hci0: Bluetooth
	Soft blocked: yes
	Hard blocked: no
3: phy0: Wireless LAN
	Soft blocked: no
	Hard blocked: no
tom@lover:~$ sudo modprobe -r ideapad_laptop 
[sudo] password for tom: 
tom@lover:~$ 

```
- 上述做法需要系统每次运行都执行一次，我们希望自动化它。
- 一种方案是设置开机自动执行脚本
- https://askubuntu.com/questions/380586/wireless-is-disabled-by-hardware-switch-wifi-doesnt-work-hard-blocked-yes?utm_medium=organic&utm_source=google_rich_qa&utm_campaign=google_rich_qa
