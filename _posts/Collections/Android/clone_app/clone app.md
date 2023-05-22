# 应用克隆

## 一、 是什么
通俗的说，把应用App从用户a手机上克隆到用户b手机上，用户b就可以在自己手机上的同款应用的使用过程中获取和使用用户a手机上的该款app相同的效果。

(这个问题曾经存在过，已被修复)例如：
>假设 qq 存在克隆漏洞

>a 手机登陆 qq 号 123456

>将 qq 从 a 手机克隆到 b 手机，打开 b 手机的 qq 直接就是 qq 号 123456 的登陆状态

**从技术的角度来说：**
可以被克隆的应用都存在本地化的数据，应用运行依赖这些数据，并且未验证数据和设备是否匹配。

**一个 app 运行都需要什么数据 & app 安装的过程：**
1. 安装-拷贝：
  - 在Android系统中，apk安装文件是会被保存起来的，默认情况下，用户安装的apk首先会被拷贝到 `/data/app` 目录下。
  - 系统应用 apk 存放位置 `/system`
2. 安装-解压 apk ：
  - apk 在安装的时候，会首先将 app 的可执行文件（dex）拷贝到 `/data/dalvik-cache` 目录。
  - 在`/data/data/`目录下创建应用程序的数据目录（以应用的包名命名），存放应用的相关数据，如数据库、xml文件、cache、二进制的so动态库等等。
3. 安装-解析 apk 配置信息：
  - 根据 `AndroidManifinest.xml` 更新 `/data/system/packages.xml`
4. 安装-显示快捷方式：
  - 上述用程序相当于在PackageManagerService服务注册好了，如果我们想要在Android桌面上看到这些应用程序，还需要有一个Home应用程序，负责从PackageManagerService服务中把这些安装好的应用程序取出来，并以友好的方式在桌面上展现出来，例如以快捷图标的形式。在Android系统中，负责把系统中已经安装的应用程序在桌面中展现出来的Home应用程序就是Launcher了。
5. 运行-可操作数据位置：
  - 应用运行时候根据权限的不同，可操作的数据存放位置外乎两个：内置存储卡，外置存储卡。
6. 运行-数据辨别
  - 系统维护的目录(每个应用都按系统规则存在的文件)，这个可以定位。
    - `/data/data/package_name`
    - `/sdcard/Android/data/package_name`
  - 应用自行维护的目录(例如SDcard)，这些数据除非了解应用的业务逻辑和实现细节，否则无法快速获取应用相关的目录和文件。

**应用克隆所涉及的数据(按优先级)：**
- `/data/data/package_name`
- `/sdcard/Android/data/package_name`
- 应用自行维护的目录

### 1.1、 小结
应用克隆：对应用数据的复制和在新环境重新利用该数据的操作被称作应用克隆。

## 二、 怎么做
1. 直接拿到设备 copy 数据
  - 应用在 manifest 文件中标示为可 clone ，使用 adb 完成 clone。
  - 应用在 manifest 文件中未标示可 clone ，Root 设备。
2. 远程 copy 数据
  - WebView 作为桥梁使用 html 文件中的 javascript 完成 clone 。

## 三、 实施
### 3.1、 注意事项
文件移动到目标位置后，需要修改文件所有者和文件权限之后文件才是可用的。

### 3.2、 思路
1. 读取文件-获取文件信息
2. 遍历文件
3. 上传文件

### 3.3、 涉及 API
> WebView \ WebSettings

this.webView.getSettings().setJavaScriptEnabled(true);//允许执行 JavaScript 代码 [必须]

- `setAllowFileAccess`
  - 在 WebView 中启用/禁用文件访问，默认启用。
  - 这只启用或禁用文件系统访问。资产和资源仍可通过`file：/// android_asset`和`file：/// android_res`访问。

"XMLHttpRequest cannot load file:///data/data/tom.work.foxmail.com.drone_for_six/files/file. Cross origin requests are only supported for protocol schemes: http, data, chrome, https.", source: file:///storage/emulated/0/Download/file.attack.html (32)
- `this.webView.getSettings().setAllowFileAccessFromFileURLs(true);`
  - **一段通过 file 协议加载的文件中的 javaScript ， 是否允许它通过 file 协议访问其他文件内容。** 要启用最严格的安全策略时应禁用本选项。为了防止违反 ICE_CREAM_SANDWICH 和更早期间版本的域同源策略，应显示置为 false 。在 ICE_CREAM_SANDWICH_MR1(15) 以及更早期的版本上本属性默认为 true，从 JELLY_BEAN(16) 以及更晚期的版本默认值为 false
    - 注意-1 ：如果 `setAllowUniversalAccessFromFileURLs(bool)` 设置为 true 本方法所做的设置将被忽略。
    - 注意-2 ：该设置仅影响对于文件系统中文件的访问。对于其他的资源文件如 HTML 中的图片不产生影响。
- `this.webView.getSettings().setAllowUniversalAccessFromFileURLs(true);`
  - **一段通过 file 协议加载的文件中的 javaScript ， 是否允许它通过其他协议访问其他文件内容。** 有关通过此 JavaScript 使用 file 协议访问其他文件内容的情况参见 `setAllowFileAccessFromFileURLs` 。当启用最严格的安全策略时，应禁用此设置。
    - 注意禁用此设置仅仅影响 JavaScript 访问 file 协议资源。其他的资源访问，例如 HTML 中的图片元素不产生影响。
    - 为了防止违反 ICE_CREAM_SANDWICH 和更早期间版本的域同源策略，应显示置为 false 。


### 3.4、 测试
加载远程 html 之后尝试执行 js 查看本地文件报错：
```
"XMLHttpRequest cannot load file:///data/data/tom.work.foxmail.com.drone_for_six/files/file. Cross origin requests are only supported for protocol schemes: http, data, chrome, https.", source:
```

要加载本地 HTML 文件
- 首先需要 `setAllowFileAccess` 不为 false
  - 否则无法加载本地 HTML 文件
- 要使用 JS 做操作 : `setJavaScriptEnabled(true)`
  - 否则无法执行文件拷贝逻辑
- 要访问本地文件至少需要下述方法中的一个置为 true，否则无法读取本地文件
  - `setAllowFileAccessFromFileURLs(true)`
  - `setAllowUniversalAccessFromFileURLs(true)`

#### 3.4.1、 小结
目前要完成攻击需要如下信息和场景
1. 受害应用已经将恶意 html 文件保存到手机
2. 受害应用会加载恶意 html
3. 恶意 html 本身就是针对该受害应用设计的
  - 因为暂时还不能通过 JavaScript 完成目录遍历的动作
4. 在加载恶意 html 的时候设备有可用网络

### 3.5、 通用恶意代码
能否通过通用恶意代码完成对存在漏洞的应用的普遍性攻击。
- 要完成这一点需要 JavaScript 具有遍历文件目录的能力。
  - 然而 JavaScript 不具备这种能力。

ActiveXObject
- Uncaught ReferenceError: ActiveXObject is not defined
- 为什么会产生上述错误，因为 WebView 不支持 ActiveXObject 接口

#### 3.5.1、 小结
通用恶意代码是暂时无法实现。

## Reference
1. http://www.freebuf.com/articles/terminal/159792.html
2. http://blogs.360.cn/360mobile/2014/09/22/webview跨源攻击分析/
3. https://www.zhihu.com/question/265341909
4. https://www.jianshu.com/p/21412a697eb0
5. [万维网联盟-查阅 JavaScript API](https://www.w3.org/standards/webdesign/script.html)
  - https://www.w3.org/standards/techs/js#w3c_all
