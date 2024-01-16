
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

## 0x01. nginx 转发请求到其他位置 : 
proxy_pass : http://t.csdn.cn/qW1Qj



## 0x02. [关于 nginx config 的一些用法](https://nginx.org/en/docs/beginners_guide.html#conf_structure)

创建自定义变量 :
0. 官方 : http://nginx.org/en/docs/http/ngx_http_rewrite_module.html#set
1. 网络 : https://www.learnfk.com/nginx/nginx-variables.html


## 0x03. [nginx 命令行]
1. https://blog.redis.com.cn/nginxchscommandline
2. https://nginx.org/en/docs/beginners_guide.html

> root@reactEnv:/# nginx -h
```
nginx version: nginx/1.25.3
Usage: nginx [-?hvVtTq] [-s signal] [-p prefix]
             [-e filename] [-c filename] [-g directives]

Options:
  -?,-h         : this help
  -v            : show version and exit
  -V            : show version and configure options then exit
  -t            : test configuration and exit
  -T            : test configuration, dump it and exit
  -q            : suppress non-error messages during configuration testing
  -s signal     : send signal to a master process: stop, quit, reopen, reload
  -p prefix     : set prefix path (default: /etc/nginx/)
  -e filename   : set error log file (default: /var/log/nginx/error.log)
  -c filename   : set configuration file (default: /etc/nginx/nginx.conf)
  -g directives : set global directives out of configuration file               # 设置全局指令，允许在命令行上设置一些全局配置指令，而不必在配置文件中指定。

```

> root@reactEnv:/# nginx -V
```
nginx version: nginx/1.25.3
built by gcc 12.2.0 (Debian 12.2.0-14) 
built with OpenSSL 3.0.9 30 May 2023 (running with OpenSSL 3.0.11 19 Sep 2023)
TLS SNI support enabled
configure arguments:                                           # 下面是 Nginx 编译时使用的配置参数的详细列表。
--prefix=/etc/nginx                                            # 指定 Nginx 的安装目录为 /etc/nginx。
--sbin-path=/usr/sbin/nginx                                    # 指定 Nginx 可执行文件的路径为 /usr/sbin/nginx。            
--modules-path=/usr/lib/nginx/modules                          # 指定 Nginx 模块的路径为 /usr/lib/nginx/modules。                    
--conf-path=/etc/nginx/nginx.conf                              # 指定 Nginx 配置文件的路径为 /etc/nginx/nginx.conf。                
--error-log-path=/var/log/nginx/error.log                      # 指定 Nginx 错误日志文件的路径为 /var/log/nginx/error.log。                       
--http-log-path=/var/log/nginx/access.log                      # 指定 Nginx HTTP 访问日志文件的路径为 /var/log/nginx/access.log。                        
--pid-path=/var/run/nginx.pid                                  # 指定 Nginx 进程 ID 文件的路径为             
--lock-path=/var/run/nginx.lock                                # 指定 Nginx 锁文件的路径为 /var/run/nginx.lock。                
--http-client-body-temp-path=/var/cache/nginx/client_temp      # 指定用于存储 HTTP 客户端请求体的临时文件路径。                                        
--http-proxy-temp-path=/var/cache/nginx/proxy_temp             # 指定用于存储代理模块临时文件的路径。                                
--http-fastcgi-temp-path=/var/cache/nginx/fastcgi_temp         # 指定用于存储 FastCGI 模块临时文件的路径。                                    
--http-uwsgi-temp-path=/var/cache/nginx/uwsgi_temp             # 指定用于存储 uWSGI 模块临时文件的路径。                               
--http-scgi-temp-path=/var/cache/nginx/scgi_temp               # 指定用于存储 SCGI 模块临时文件的路径。                                
--user=nginx                                                   # 指定 Nginx 进程运行的用户为 nginx。                                                            
--group=nginx                                                  # 指定 Nginx 进程运行的用户组为 nginx。                                                            
--with-compat                                                  # 启用与以前版本的兼容性。                                                            
--with-file-aio                                                # 启用文件异步 I/O。                                                                
--with-threads                                                 # 启用线程支持。                                                            
--with-http_addition_module                                    # 启用 HTTP 添加模块。                                                                            
--with-http_auth_request_module                                # 启用 HTTP 认证请求模块。                                                                                
--with-http_dav_module                                         # 启用 HTTP DAV 模块。                                                                    
--with-http_flv_module                                         # 启用 HTTP FLV 模块。                                                                    
--with-http_gunzip_module                                      # 启用 HTTP Gunzip 模块。                                                                        
--with-http_gzip_static_module                                 # 启用 HTTP Gzip 静态模块，允许 Nginx 对静态文件进行 Gzip 压缩。                                                                            
--with-http_mp4_module                                         # 启用 HTTP MP4 模块，允许 Nginx 提供对 MP4 文件的流式传输。                                                                    
--with-http_random_index_module                                # 启用 HTTP Random Index 模块，允许 Nginx 提供对目录的随机索引。                                                                                
--with-http_realip_module                                      # 启用 HTTP Real IP 模块，允许 Nginx 通过设置 X-Real-IP 或 X-Forwarded-For 头来获取真实的客户端 IP 地址。                                                                        
--with-http_secure_link_module                                 # 启用 HTTP Secure Link 模块，允许 Nginx 创建和验证安全链接。                                                                            
--with-http_slice_module                                       # 启用 HTTP Slice 模块，允许 Nginx 对大文件进行切片传输。                                                                        
--with-http_ssl_module                                         # 启用 HTTP SSL 模块，允许 Nginx 提供 HTTPS 服务。                                                                    
--with-http_stub_status_module                                 # 启用 HTTP Stub Status 模块，允许 Nginx 提供简单的状态信息。                                                                            
--with-http_sub_module                                         # 启用 HTTP Sub 模块，允许 Nginx 对响应内容进行替换。                                                                    
--with-http_v2_module                                          # 启用 HTTP/2 模块，允许 Nginx 提供 HTTP/2 支持。                                                                    
--with-http_v3_module                                          # 启用 HTTP/3 模块，允许 Nginx 提供 HTTP/3 支持。                                                                    
--with-mail                                                    # 启用邮件模块，允许 Nginx 提供邮件服务。                                                            
--with-mail_ssl_module                                         # 启用邮件 SSL 模块，允许 Nginx 提供 SSL 加密的邮件服务。                                                                    
--with-stream                                                  # 启用流模块，允许 Nginx 提供 TCP 和 UDP 代理服务。                                                            
--with-stream_realip_module                                    # 启用流模块，允许 Nginx 提供 TCP 和 UDP 代理服务。                                                                            
--with-stream_ssl_module                                       # 启用流 SSL 模块，允许 Nginx 提供 SSL 加密的流服务。                                                                        
--with-stream_ssl_preread_module                               # 启用流 SSL Preread 模块，允许 Nginx 在 TCP 代理中预读 SSL 协商信息。                                                                                
--with-cc-opt='-g -O2 -ffile-prefix-map=/data/builder/debuild/nginx-1.25.3/debian/debuild-base/nginx-1.25.3=. -fstack-protector-strong -Wformat -Werror=format-security -Wp,-D_FORTIFY_SOURCE=2 -fPIC'                                                                                                              
                                                               # 设置 C 编译器选项，包括调试信息、优化级别、源文件路径映射等。
--with-ld-opt='-Wl,-z,relro -Wl,-z,now -Wl,--as-needed -pie'   # 设置链接器选项，包括启用 RELRO、启用立即绑定、只在需要时链接库。                                                                                        
                                                                                                                                                                                                                

```

> nginx -s signal
```
signal 可选值如下

stop — fast shutdown                        # 快速关闭
quit — graceful shutdown                    # 优雅关闭
reload — reloading the configuration file   # 在将重新加载配置的命令发送到 nginx 或重新启动之前，配置文件中所做的更改将不会应用。要重新加载配置，请执行 nginx -s reload
reopen — reopening the log files
```

> 通过系统 指令 终止 nginx
```
查看运行中的 nginx 进程 ps -ax | grep nginx
终止 指定 nginx 进程   kill -s QUIT 1628
```


## 0x04. 配置文件结构

