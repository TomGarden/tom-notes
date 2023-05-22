安装最新版 WineHQ

安装 WeChat \ Lark

# [WeChat 问题解决](https://askubuntu.com/a/1133157/872912)
## 0x01、 My environment
1. Ubuntu 18.04
2. [wine-4.0](https://www.winehq.org/)
3. WeChat2.6.7.57

## 0x02、 My operate 

### 2.1、 First Failed Operate **(About □)**
1. install update wine to 4.0
2. install WeChat direct
3. all text is □ □ □ □ □
4. [fix □ ,By edit WeChat.desktop file](https://github.com/hillwoodroc/winetricks-zh/issues/66)
    ```
    [Desktop Entry]
    ...
    Exec=env WINEPREFIX="/home/tom/.wine" wine C:\\\\windows\\\\command\\\\start.exe /Unix /home/tom/.wine/dosdevices/c:/users/Public/Desktop/WeChat.lnk
    ...
    ```

    to

    ```
    [Desktop Entry]
    ...
    Exec=env LC_ALL=zh_CN.UTF-8 WINEPREFIX="/home/tom/.wine" wine C:\\\\windows\\\\command\\\\start.exe /Unix /home/tom/.wine/dosdevices/c:/users/Public/Desktop/WeChat.lnk
    ...
    ```
5. Now , I can read and send msg,but My write panel don't show my writed text

### 2.2、 Second Failed Operate

I wont to fix the problem that write panel not't show text ,i do that:

1. open my Windows 10
2. copy `C:\Windows\SysWOW64\riched20.dll` to `.wine/drive_c/windows/syswow64\riched20.dll`
3. copy `C:\Windows\System32\riched20.dll` to `.wine/drive_c/windows/system32/riched20.dll`
4. reopen WeChat,but **failed**

### 2.3、 Success Operate

1. after `2.1`、`2.2` , I unInstall WeChat
2. download qq.exe、tim.exe and install them
3. download `wechat.exe` and install it
4. fix `wechat.desktop` to :
    ```
    [Desktop Entry]
    Name=WeChat
    Exec=env LC_ALL=zh_CN.UTF-8 WINEPREFIX="/home/tom/.wine" wine C:\\\\windows\\\\command\\\\start.exe /Unix /home/tom/.wine/dosdevices/c:/users/Public/Desktop/WeChat.lnk
    Type=Application
    StartupNotify=true
    Path=/home/tom/.wine/dosdevices/c:/Program Files (x86)/Tencent/WeChat
    Icon=06F2_WeChat.0
    StartupWMClass=wechat.exe
    Name[en_US]=WeChat_1.desktop
    ```
5. copy `.wine/drive_c/Program Files (x86)/Tencent/TIM/Bin/RICHED20.DLL` to `.wine/drive_c/Program Files (x86)/Tencent/WeChat/RICHED20.DLL`
6. about wine config
   - open winetricks
   - `select the default wineprefix` (click ok)
   - `install a Windows DLL or component` (click ok)
   - check `riched20`、`riched30`、`richtx32` (click ok)
7. open my WeChat

### 2.4、 I don't know why
but my WeChat can work well now 

1. read 、 write msg
2. send and download file
3. *Screenshot and send picture* **filed** ，but i install `deepin Screenshot` fix it

## 0x03、 Reference
1. [about □ □ □ □](https://github.com/hillwoodroc/winetricks-zh/issues/66)
2. [about write panel 1](https://www.cnblogs.com/makefile/p/wine-life.html)
3. [about write panel 2](https://www.crossovercn.com/thread-18.htm)

