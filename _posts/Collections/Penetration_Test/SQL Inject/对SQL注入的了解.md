>DVWA 学习

## 一、测试是否容易受到攻击
### 1.1、寻找可能涉及到数据库操作的查询或者类查询功能
1. 观察页面URL
    - 例如：http：//duck/index.asp？id = 10 
2. 寻找Form表单
    - `<FORM></FORM>`    
在关键的数据输入点输入我们特定的数据提交到服务器
#### 1.1.1、特定数据是什么
```SQL
'  or 1=1-- 
"  or 1=1-- 
   or 1=1-- 
'  or 'a'='a
"  or "a"="a
') or ('a'='a
#还有很多
```
- 注：-- 就是的含义是：-- 之后的内容被注释掉
- 注：[-- ]一起读：减 减 __空格__

## 二、SQL注入之：远程命令执行(从此至以后都验证失败)
仅以MySQL为例
### 2.1、MySQL客户端了解
1. 打开MySQLServer
2. 命令行使用MySQLClient 链接MySQLServer：`mysql --host=127.0.0.1 --port=3306 --user=root `
3. show databases; #展示当前所有的表
4. use dvwa; #使用dvwa数据库
5. SELECT first_name, last_name FROM users WHERE user_id = 1; system ls;# 输出如下
    ```bash
    +------------+-----------+
    | first_name | last_name |
    +------------+-----------+
    | admin      | admin     |
    +------------+-----------+
    1 row in set (0.00 sec)

    ~	 Documents  examples.desktop  genymotion-log.zip  Pictures  Templates	     Videos
    Desktop  Downloads  genymotion	      Music		  Public    Untitled Folder  桌面
    ```
6. 在网页尝试不能得到结果(system 之后的shell语句没有执行猜测如果是存储过程的话那么语句会执行的)，在下一节我们讨论如何拿到结果。
    - 当前想到的是
    - `SELECT first_name, last_name FROM users WHERE user_id = 1; system ls > 文件路径/文件名`
    - 这样做新的困难就在于我们一定要知道这个路劲是啥，有的时候这不是那么容易知道的。

### 2.2、远程文件传输(远程命令执行结果打印)
1. 通过访问SSH客户端可以实现直接将命令行中的内容打印到远程计算机的文件上去。
    - 但是这么做的问题在于如果只是用ssh客户端需要单独输入密码，我们的业务场景不能满足这种需求。
    - 并不是没有办法解决，如果客户端上有一个名为`sshpass`就可以不用单独输入密码了。
    - 如果服务器存在目录上传到任意目录任意文件的漏洞我们可以上传ssh公钥从而免密登录(没有仔细思量是否还需要登录)。
2. FTP没有尝试



## 翻译
1. http://www.securiteam.com/securityreviews/5DP0N1P76E.html