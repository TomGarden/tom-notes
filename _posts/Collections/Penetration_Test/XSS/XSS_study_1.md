## 一、种类
- 反射型
- 存储型
- DOM型(这个还没理解透彻)

## 二、工具
### 2.1、大型扫描工具
1. APPSCAN
2. AWVS
3. BurpSuite

### 2.2、针对性的工具
1. XSSER
2. XSSF

----
上述最熟悉的就是 BurpSuite 我们就用它吧。

## 三、 BurpSuite 自动扫描 XSS 漏洞
### 3.1 xssValidator 插件安装
使用 BurpSuite 安装：`Extender -> BApp Store -> xssValidator -> install`
- 这种做法碰到的问题是 “黑盒” 自己容易许多不明白，如果在不明白的时候恰好出错了也觉察不到。

手动下载和安装：https://github.com/nVisium/xssValidator
- 直接在 GitHub 主页检索 xssValidator 关键字自然找到，关于安装细节，可以查看 ReadMe 文件，这里有一切有助于我们的信息。

仅仅安装了上述插件到计算机，我们无法达到自动化测试 XSS 的目的。
- 我们还需要一个小工具：https://nvisium.com/blog/2014/01/31/accurate-xss-detection-with-burpsuite/
    - 事实上，是先有了 `PhantomJS应用程序` 通过改程序可以用一个较低的误报率来反馈 XSS
    - 然后为了 `PhantomJS应用程序` 使用起来更方便，进而开发了 BurpSuite 插件 xssValidator。
    - 更多的细节暂不详究。

### 3.2、 自动化测试
#### 3.2.1、 启动 `PhantomJS应用程序`
插件安装，如果按照上述的插件安装之后发现没有 `xss.js` 文件可以到上述 github 地址下载位于`xssValidator/xss-detector/`目录下。
    ```terminal
    //执行，如果需要的话自己补齐路径就好。
    $ phantomjs xss.js
    ```
#### 3.2.2、 使用 BurpSuite 结合 xssValidator 开始注入 payload
1. 拦截到请求回话
2. RightClick -> Send to Intruder
3. Positions选项卡
    - Clear ; 选中自己中意的选项 Add
4. Payloads选项卡
    1. Payload type = Externsion-generated
    2. Select generator -> XSS Validator Payloads -> OK
    3. Payload Processing --> add -> Invoke Burp extension -> XSS Validator ok。
5. Options 选项卡
    - Grep-Match -> Add value(xss Validator->Grep Phrase)
6. phantomjs应用程序
    - `$ phantomjs xss.js`
7. BurpSuite -> Start attack

- 值的说明的是，如果 xssValidator 无法使用，可以尝试更换 JDK 版本再试。

#### 3.2.3、 就 DVWA 来看
反射/存储/Dom,三种类型的 XSS 都成功检测出来了。








## 参考 & 摘录
1. 《WEB 安全深度剖析》
2. [burp suite 使用 xssvalidate 进行自动化xss安全扫描](https://www.mmfei.com/?p=444)
2. [Burpsuite-Intruder-xssValidator（XSS检测）基础学习](http://www.bubuko.com/infodetail-2320488.html)
3. [burpSuite 中xssValidator 的用法 ](http://makaidong.com/MiWhite/237324_7929836.html)
4. [__[精]-使用BurpSuite和PhantomJS进行准确的XSS检测__](https://nvisium.com/blog/2014/01/31/accurate-xss-detection-with-burpsuite/)
