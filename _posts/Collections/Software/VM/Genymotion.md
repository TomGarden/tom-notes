# Genymotion

重要的事情是在做一些操作之前首先做个性化设置是个不错的选择。

## 下载：
1. 官网 https://www.genymotion.com
2. 点击 Download
3. 选择个人版：personal version
4. 下载：https://www.genymotion.com/download/

## 安装 .bin
```
chmod +x app.bin
./app.bin       //只为当前用户安装
sudo ./app.bin  //为所有用户安装

如果系统询问是否安装自己做决定吧。
```

## 选择个人版
选择个人版就不用输入 License 了。


## 首先做个性化设置
设置好虚拟机镜像下载位置

设置好屏幕截图存放位置

## 系统镜像下载慢的处理方式

### 方法一:
设置代理(软件内部可行)，我没试验。

### 方法二：
1. 首先选定镜像点击下载，然后即刻 cancel。
2. 找到应用的日志文件
    - 如果在 Ubuntu 下为所有用户安装该文件，那么日志文件的位置为：/home/tom/.Genymobile/genymotion.log
3. 在日志文件中定位下载链接
    ```
    [debug] Starting download of "https://dl.genymotion.com/dists/6.0.0/ova/genymotion_vbox86p_6.0_180219_000000.ova"
    [debug] Stopping current download
    [warning] Download failed. error: 103 message: "Download canceled"
    ```
4. 使用下载器下载该文件放到 ova 默认的存放位置
    - /home/tom/.Genymobile/Genymotion/ova
5. 然后再次添加上次取消的模拟器(型号要对应)。就可以略去下载过程了。


## AndroidStudio  Genymotion chajian 
在插件管理器中下载会失败。

直接到官网下载：https://www.genymotion.com/plugins/

手动导入即可，导入后插件(.jar)可删除。


## 外部 APK 拖入无法安装

要根据自己的模拟器版本下载对应版本的 [Genymotion-ARM-Translation](https://github.com/m9rco/Genymotion_ARM_Translation) 文件

## 如果 adb device 无法显示设备

[找到设备 ip 执行`adb connect 192.168.****.****:5555`](https://stackoverflow.com/a/55232270/7707781)
