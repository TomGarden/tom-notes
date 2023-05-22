# 驱动管理

## 针对 Windows 下载
[联想驱动自动安装工具](http://support.lenovo.com.cn/lenovo/wsi/Modules/autocd.aspx)


## 针对 Ubuntu
当前出现的状况是系统安装后
1. 接入有线网络，系统一直尝试连接到该网络但是也一直不成功。
2. 在设置页面手段选择两个专有驱动后(独显/忘了)，Ubuntu 再次启动无法登录

针对网卡的解决方案
1. 本设备原装两块网卡
    - 有线网卡： Realtek PCIe GBE Family Controller driver for linux
        - 驱动下载：https://realtek-download.com/realtek-pcie-gbe-family-controller/
    - 无线网卡：realtek 8821ae wireless lan 802.11ac pci-e nic
        - 驱动下载：https://medium.com/@elmaxx/rtl8821ae-wifi-drivers-in-ubuntu-16-04-4c1286524afa

针对显卡，暂无解决方案