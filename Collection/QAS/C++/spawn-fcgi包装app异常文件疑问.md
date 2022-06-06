
https://stackoverflow.com/q/72180366/7707781

### 1. 问题 : 
直接命令行通过 spawn-fcgi 启动的程序 , 如果发生 crash 如何收集 core 文件 ?

### 2. 背景 & 环境
探索 C++ Web 编程
1. web-server : nginx
2. 网关(FastCGI) : [fastcgipp 3.0](https://github.com/eddic/fastcgipp)
3. CGI Wrapper : `spawn-fcgi` .  
   不是 Nginx 提供的 [FCGI Wrap](https://www.nginx.com/resources/wiki/start/topics/examples/fcgiwrap/) . 
   当然 `FCGI Wrap` 使用的也是 spawn-fcgi , 这是题外话 . 
4. 自己编写的 C++ 程序 (crash_demo)

### 3. 问题复现步骤
1. `crash_demo` 故意 `throw "测试异常, 观察 core 文件"` , 编译生成 `crash_demo.run`
2. `sudo nginx -c my_nginx_custom.config`
3. `ulimit -c unlimited`
4. `spawn-fcgi -a 127.0.0.1 -p 9000 -f /path/crash_demo.run`
5. 测试正常访问路径 , 可以正常完成 HTTP 访问 . 
6. 触发 carsh_demo , 得到 5xx 异常页面 , 但是 `crash_demo.run` 所在目录没有看到 `core` 文件

猜测(`2`是我倾向的答案)
1. `core` 文件没有生成
2. `core` 文件生成了 , 但是我不知道文件位置 ; 


**有人知道问题所在吗 ?**


### 1. Question
I run `"crash_demo.run"` by `spawn-fcgi` .
How to collect `core` file ?

### 2. Background & Environment
I'm exolore C++ Web Programming .
1. web-server : nginx
2. CGI(FastCGI) : [fastcgipp 3.0](https://github.com/eddic/fastcgipp)
3. CGI Wrapper : spawn-fcgi
   - I didn't use [FCGI Wrap](https://www.nginx.com/resources/wiki/start/topics/examples/fcgiwrap/) which ngifix supplied .
   - I understand `FCGI Wrap` be drive by spawn-fcgi , Of course this is off topic .
4. My c++ application . (be called `crash_demo`) .


### 3. Step to reproduce exception
1. `crash_demo` insert code `throw "test exception str, check _core_ file"` , build got `crash_demo.run`
2. run nginx : `sudo nginx -c my_nginx_custom.config`
3. `ulimit -c unlimited`
4. run `crash_demo.run` by `spawn-fcgi` : `spawn-fcgi -a 127.0.0.1 -p 9000 -f /path/crash_demo.run`
5. test the normal http request , and http request can be completed normally .
6. test the `crash_demo` http request , got `5xx` response . 
   - The directory where `crash_demo.run` is located does not see the `core` file

My guess 
1. `core` file not generate  .
2. `core` file is generated  , but i don't the file path .


**Does anyone know what happened?**






#### 1. Question
Ngins server , HTTP post request with header `-H 'Content-Length` , not response . 

But , if not `Content-Length` header, the result is normal . 

#### 2. Background & Environment
I'm exolore C++ Web Programming .

- web-server : nginx
- CGI(FastCGI) : fastcgipp 3.0
- CGI Wrapper : spawn-fcgi
   - I didn't use FCGI Wrap which ngifix supplied .
   - I understand FCGI Wrap be drive by spawn-fcgi , Of course this is off topic .
- My c++ application .


#### 3. Example

**without header `Content-Length`**
```
curl -X POST 'http://104.225.154.215:8080/fcgi_test/' \
     -H 'Content-Length: 135' \
     -v \
'{
  "synthetics_condition": {
    "name": "Check Failure",
    "monitor_id": "XXX",
    "runbook_url": "XXX",
    "enabled": true
  }
}'
*   Trying 104.225.154.215...
* TCP_NODELAY set
* Connected to 104.225.154.215 (104.225.154.215) port 8080 (#0)
> POST /fcgi_test/ HTTP/1.1
> Host: 104.225.154.215:8080
> User-Agent: curl/7.64.1
> Accept: */*
> Content-Length: 135
> 
* Empty reply from server
* Connection #0 to host 104.225.154.215 left intact
curl: (52) Empty reply from server
curl: (3) nested brace in URL position 29:
{
  "synthetics_condition": {
    "name": "Check Failure",
    "monitor_id": "XXX",
    "runbook_url": "XXX",
    "enabled": true
  }
}
                            ^
* Closing connection 0

```