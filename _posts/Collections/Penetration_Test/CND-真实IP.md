## 查看服务器 IP 是 CDN 还是真实IP
1. dos命令窗口：nslookup 域名
    ```
    C:\Users\tom>nslookup ***.com
    服务器:  xd-cache-1.bjtelecom.net
    Address:  219.141.136.10

    非权威应答:
    名称:    03my9j7e1148bxz6.aligaofang.com
    Address:  116.211.168.54
    Aliases:  ***.com
    ```

2. 还有一个笨方法：在不同的地区ping网址，如果都是同一个IP则未使用CDN；如果不是同一个IP则使用了CDN。

## 根据 CDN 查找真实 IP