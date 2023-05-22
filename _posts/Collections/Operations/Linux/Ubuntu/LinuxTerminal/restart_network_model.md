## 重启无线网卡模块
```
//用法：
tom@lover:~$ sudo /etc/init.d/network-manager -h
Usage: /etc/init.d/network-manager {start|stop|restart|force-reload|status}
tom@lover:~$ sudo /etc/init.d/networking -h
Usage: /etc/init.d/networking {start|stop|reload|restart|force-reload}

//实操
sudo /etc/init.d/network-manager restart
sudo /etc/init.d/networking restart
```