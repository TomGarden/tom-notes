## 一、 关于 BurpSuite 下载和启动
直接百度可以找到许多破解版的下载地址。下载下来直接用就好了。

使用过程中碰到过一个问题：
1. Ubuntu 16.04 使用 1.7.*
    - 直接通过 `java -jar ****.jar`
    - 但是启动不起来(闪退)，没有任何信息。
2. 查看 `java -version` ,因为某些原因我的是 1.6
    - 切换到 1.8 问题解决。

中文乱码：
- User option -> Display ->Http Message Display
- Windows 很轻松就能解决
- Linux 发现安装 WPS 的时候 `/usr/share/fonts/wps_symbol_fonts` 中的字体可以被读取到，所以干脆直接把需要的字体 copy 到目录下就ok
    - 字体可以从 Windows 中 copy `C:\Windows\Fonts`


## 二、 关于使用
[Very Nice 教程网址 GitBook：](https://www.gitbook.com/book/t0data/burpsuite/details)
- 如果网站不能访问 ☞ jump GFW
- 提供 PDF 下载


## 三、配置：插件
- BurpSuite的插件安装：`Extender -> BApp Store -> selPlugin -> install`
- 安装完成后的插件位置(Windows)：`C:\Users\T\AppData\Roaming\BurpSuite\bapps`

## 四、 Burp Suite 抓 Android 模拟器包
### 4.1、 收集设置代理
找到 WIFI 长按已经连接的 wifi > 修改网络 > 高级 > 手动 > 代理 IP：port

关于此处 IP 和 port 的设置有亮种选择
1. 设置本机 IP ， 端口 自定
2. 设置模拟器 IP ， 端口自定


### 4.2、 安装证书

代理设置完成后访问 http://burp 下载证书
    - Genymotion 自带的 WebView shell 应用不具备下载功能可自行安装 浏览器后再做操作

Android 要安装需要将证书后缀修正为 `.cer`





----

**关闭自动爬虫**
- Spider > Options > Passive Spidering 
    - 取消勾选