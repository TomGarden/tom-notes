
Nginx 笔记

又是一个事物一段时间远离它, 果然是忘记了, 果然是不熟悉了 . 
我们把常见操作记录于此 . 

[官网](http://nginx.org/)
[文档](http://nginx.org/en/docs/)
[中文文档](https://www.nginx.cn/doc/)

Nginx Modules 是什么 : https://www.nginx.com/resources/datasheets/nginx-modules/ ; 


NGINX Plus 与 NGINX 开源有何不同？
- [官方那个解释](https://www.nginx.com/faq/how-is-nginx-plus-different-from-the-open-source-version-of-nginx/)
- nginx 免费, nginx plus 付费(含技术支持和其他附加功能)


通过 man nginx 学习 nginx 使用比较方便 , 具体配置文件的语法需要到网站翻看文档 .  
0. 网站有命令行参数 : http://nginx.org/en/docs/switches.html
1. docker nginx 直接使用镜像是没有 man nginx 的 ;
2. 可以在其他容器手动安装后查看 . 


允许自定义的 http 请求头
```
    server {
        # http request header 允许下划线 , 默认 off
        underscores_in_headers on;
    }
```

## nginx 转发请求到其他位置 : 
proxy_pass : http://t.csdn.cn/qW1Qj



## [关于 nginx config 的一些用法](https://nginx.org/en/docs/beginners_guide.html#conf_structure)

创建自定义变量 :
0. 官方 : http://nginx.org/en/docs/http/ngx_http_rewrite_module.html#set
1. 网络 : https://www.learnfk.com/nginx/nginx-variables.html



