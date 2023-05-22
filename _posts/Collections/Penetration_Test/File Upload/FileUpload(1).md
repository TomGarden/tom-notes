# 文件上传漏洞
2017年11月27日08:35:59

## 一、 漏洞原理
文件上传漏洞的原发性存在以下几个方面
1. Web 容器(中间件)自身存在一些问题(开发商可能不认为那是漏洞)，关于这一个点不同的中间件各有不同。
2. 开发者逻辑判断和设计架构存在缺陷。

## 二、 常见攻击工具
1. 中国菜刀
    - 关于其官网 http://www.maicaidao.com 亲测不能访问
        - http://www.maicaidao.co/ 可以访问并下载 20141018.zip
    - GitHub 搜索菜刀选了第一个：https://github.com/0xHJK/caidao
        - 可以下载 20160620.zip
2. 一句话木马
    - Edjpgcom(运行失败)
    - 用cmd制作一句话木马图片：http://www.muyierdong.com/wangluoanquanxuexi/3.html
    - 不必使用 cmd 的方法：http://blog.sina.com.cn/s/blog_78a5e3cb0101ckr9.html
    - 这是一句话:https://www.webshell.cc/2265.html
3. BurpSuite
4. FireBug
5. 一句话木马：

## 三、 实战
### 3.1、 查找文件上传点


### 3.2、 信息收集
Web 应用开发语言
1. 根据session的参数名称
2. 看网页源码是否泄露
3. 使用wapplazer这个插件
4. 看网页后缀
5. 社工(打电话，直接问)

中间件 & 操作系统
- znemap

### 3.3、 制作一句话木马
1. Windows 平台：文件右键 -> 属性 -> 详细信息(在其中填写一句话)
2. Windows 平台：使用 copy 命令

### 3.4、 将一句话木马文件上传到目标站点

### 3.5、 获取上传文件的路径
1. [奚望] 抓包工具 获取返回路径
2. BurpSuite 爬虫 理论可行，不过文件会改名字，这就变得复杂了。

### 3.6、使用菜刀链接自己上传的文件
至此攻击过程完结。