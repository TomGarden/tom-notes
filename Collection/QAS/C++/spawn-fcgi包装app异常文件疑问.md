
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


# ======================================================



### 1. Question
I run `"crash_demo.run"` by `spawn-fcgi` .
How to collect `core` file .

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


Does anyone know what happened?




-------------
-------------
### Solution update
My question is flawed .

Thanks @sehe , my step : 
1. I read two webpage
    1. https://man7.org/linux/man-pages/man5/core.5.html
    2. https://zhuanlan.zhihu.com/p/240633280
2. [update my `/proc/sys/kernel/core_pattern`](https://stackoverflow.com/a/12760552/7707781)
    * `core` -> `core_%e_%p_%t` 
3. `ulimit -c unlimited`
4. `spawn-fcgi -a 127.0.0.1 -p 9000 -f /path/crash_demo.run`
5. `sudo find /  core_ | grep core_crash_demo`
    - result `/path/core_crash_demo._5080_1652169152`

So , my guess on my question is failed . 

The fact is , I don't generate `core` file , when my question.

When my generated `core` file successed , the `core` file path is `crash_demo.run` parent directory .


-------------
-------------
### Solution update 2


再次遇到此问题 ， 我们向作两件事 
1.  搞清楚 core dump 文件生成的细节
2.  core dump 文件如何使用

**core dump 文件生成的细节**

主要参考内容 : [core manual](https://man7.org/linux/man-pages/man5/core.5.html)

core manual 中设计的点很多 ， 不同的情况可能遇到不同的问题， 不过基本可以确认，阅读此文件可以解决大多数问题。
这里我只写出自己关注的点。

要生成 core dump 有几个前提条件 :
- 对于 core dump 文件的大小 ，有系统层面的限制 ， 可以通过 命令  ulimit 查看和修改
  - `ulimit -a` 查看   /   `ulimit -c unlimited` 修改
- 关于 修改 `/proc/sys/kernel/core_pattern` , 
  - 默认的内容一般为 `core` ， 除非被修改过
  - 如果文件的首个字符是 `|` 意味通过管道后进一步执行后续命令 ， 细节需要再细读文档，不再展开。
  - 我们修改为 `core_%e_%p_%t` -> `core_可执行文件名_pid_时间戳`
  - 修改命令为 : `sudo bash -c 'echo core_%e_%p_%t > /proc/sys/kernel/core_pattern'`


再次执行异常程序后可以使用 find 命令查找 core 文件位置了
- `sudo find /  core_ | grep core_`
- 我的 core 文件就生成在异常 调用程序语句所执行的文件夹
  - 程序在 `～/a/b/c/d/exe.run`
  - 调用为 `~$ /a/b/c/d/exe.run`
  - core 文件位置为 `~/core`

**core dump 文件如何使用**

1. 使用 vscode 调试 有 ui 更直观些 ， `launch.json` 增加 属性 `coreDumpPath` : https://code.visualstudio.com/docs/cpp/cpp-debug#_memory-dump-debugging
2. 也可以直接使用 gdb ， 略。


### Solution update 2 (English)

we whant to know two point :
1. how generate core dump file
2. how to  fine  exception code by core dump file 

#### **how generate core dump file？**

Reference the file : [core manual](https://man7.org/linux/man-pages/man5/core.5.html)

core manual write many point , I just list the point i care :
1. system limit core dump file size , we need unlimit it:
  - `ulimit -a` check limit   /   `ulimit -c unlimited` cancel limit
2. fix `/proc/sys/kernel/core_pattern`
  - default value is `core`
  - fix it to -> `core_%e_%p_%t` mean `core_your_execute_file_name_pid_timestemp`
  - fix cmd : `sudo bash -c 'echo core_%e_%p_%t > /proc/sys/kernel/core_pattern'`

now run your exception , you can got core file .
- maby you need search it : `sudo find /  core_ | grep core_`

#### **how to  fine  exception code by core dump file ？**

- I use vscode , fix `launch.json` , add `coreDumpPath` , refrence : https://code.visualstudio.com/docs/cpp/cpp-debug#_memory-dump-debugging

# ======================================================


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