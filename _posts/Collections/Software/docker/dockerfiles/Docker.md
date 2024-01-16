远程 VPS 我们能承受的价钱 200RMB 没有发现比较稳定，可以安心开发的。

现在我们来尝试下 用本地 docker 来搭建开发环境 ， 本来也是打算后续了解 docker 的，
现在是被迫提前了这一动作。

关于docker 的一点介绍 ：
0. 官方文档 : https://docs.docker.com/
1. 阮一峰老师的一点介绍 : https://www.ruanyifeng.com/blog/2018/02/docker-tutorial.html
2. 杨宝华的一点介绍 : https://yeasy.gitbook.io/docker_practice/


Docker for mac 安装完成后, zsh 没有 docker 命令的自动补全能力 . 官方指导 : https://docs.docker.com/desktop/mac/#zsh
```
etc=/Applications/Docker.app/Contents/Resources/etc
ln -s $etc/docker.zsh-completion /usr/local/share/zsh/site-functions/_docker                 # 现存的文件路径 : /usr/local/share/
ln -s $etc/docker-compose.zsh-completion /usr/local/share/zsh/site-functions/_docker-compose # 现存的文件路径 : /usr/local/share/

# 结果发现文件夹  `/usr/local/share/zsh/site-functions` 还不存在
# 先创建文件夹 , 在创建软连接 即可 
```
- 尽管增加了命令不全能力,但还是有些命令或者属性是没有的,要以文档为准 .


我们先搞清楚几个 docker 相关的概念哈 

- image       相当于系统镜像
- container   相当于安装好的操作系统，可以启动和停止
- volume      一般我们安装好操作系统后会挂载几个磁盘作为数据盘，系统坏了数据也坏不了



我们已经通过 image 创建好了望 container 但是启动总也无法交互

`docker container start --attach DevEnv`


官网有一个示例可以启动实例 并与之进一步交互 
- `$ docker run [OPTIONS] IMAGE [COMMAND] [ARG...]`
- `docker run --interactive --tty ubuntu:tagname /bin/bash` 
   - [OPTIONS] : `--interactive` 交互式运行 
   - [OPTIONS] : `--tty` 分配一个伪 TTY
   - IMAGE : ubuntu:tagname
   - [COMMAND] : /bin/bash

- 读更多内容的好地方是快速入门文档中的运行交互式 shell部分。:https://docs.docker.com/get-started/overview/
- 我理解这里的 /bin/bash 是 ubuntu 实例中的 bash






其他人把 Docker 作为 C/C++ 开发环境的操作记录
0. https://www.cnblogs.com/davidhhuan/p/13227139.html
1. https://graueneko.com/archives/64/
2. https://imhuwq.com/2018/12/02/Clion%20使用%20Docker%20作为开发环境/
3. https://www.google.com/search?q=使用+Docker+作为+C%2B%2B+开发环境&oq=使用+Docker+作为+C%2B%2B+开发环境

其他人的操作主要涉及了两个方面 
1. DockerFile 定义 实例 Image
   - 不支持中文字符
   - 设置代理
   - 设置合适的源，
   - 在系统上创建用户，设置用户目录
      - 用安全的方式设置密码 : 创建容器后再手动修改密码
   - 修改主机名
      - docker 容器一旦创建无法修改主机名， 只能在创建时候使用 `docker run --hostname` 设置
   - 配置用户常用软件，
      - zsh - 预计可以完成
      - bash   - 预计可以完成
      - mysql  
         - 直接再开发容器安装 db 失败， 我们尝试使用官方镜像单独创建一个数据库容器来达到这一目的
         - 使用 mysql image 需要注意文档 上的使用细节指导 : https://hub.docker.com/_/mysql/
         - 他们都是使用了 docker-compose , 这迫使我们就不得不学习下 docker-compose 了。
           但是这一周了吧学烦了代码练习推进不了，卡壳在这里，学不下去了，不学了，就用命令行。

2. docker-compose 
   - Compose 是一个用于定义和运行多容器 Docker 应用程序的工具。使用 Compose，您可以使用 YAML 文件来配置应用程序的服务。
      然后，使用一个命令，您可以从您的配置中创建并启动所有服务。


docker 安装必要的软件们
man-db wget curl net-tools vim openssh-server git zsh(tmux)

在 container 中使用 `man username` 无法使用 vim 命令翻页


### 在进行 docker 系列操作之前

[vscode 和 docker 相关的文档](https://code.visualstudio.com/docs/remote/containers-tutorial)

我是先安装并操作容器弄明白后才看到的 vscode 文档。
不用关心 容器 ssh 配置，端口如何开放和映射的事情，只要容器能运行就可以通过 vscode 插件进行访问了。

### 设置中文字符支持

默认的 Image 是没有任何语言配置和文件的。
- 默认的，文件 `/etc/locale.gen` 不存在
- `apt install locales` 会为设备配置好大多数语言的语言文件。
   安装这个文件后，只需要作一些命令的配置就可以使用已安装的语言文件了。
- 此时文件 `/etc/locale.gen` 是存在的了
- 暂时考虑通过 sed 将文件中的 `en_US.UTF-8 UTF-8` / `zh_CN.UTF-8 UTF-8` 
   - 取消注释 : https://gist.github.com/pi-aej/43b0a9882780807e01881be3567c4ded
   - https://askubuntu.com/questions/683406/how-to-automate-dpkg-reconfigure-locales-with-one-command
   - https://www.thomas-krenn.com/en/wiki/Configure_Locales_in_Ubuntu
   - https://help.ubuntu.com/community/Locale
   - https://wiki.debian.org/Locale#Manually
- `locale-gen` 下载取消注释了的语言的全部信息




参考内容 : 
1. https://wiki.debian.org/ChangeLanguage
2. https://www.cnblogs.com/pengdonglin137/p/3280663.html
3. https://pkgs.org/download/locales
   - https://debian.pkgs.org/11/debian-main-amd64/locales_2.31-13+deb11u3_all.deb.html
4. https://www.v2ex.com/t/808156
5. https://blog.csdn.net/ailongyang/article/details/54835922


### docker 容器设置代理[成功]: 
1. https://kebingzao.com/2019/02/22/docker-container-proxy/
2. https://www.google.com/search?q=docker+container+access+host+network
3. **主要参照** : https://www.howtogeek.com/devops/how-to-connect-to-localhost-within-a-docker-container/

对于 Windows 和 Mac 
- `localhost` 和 `127.0.0.1` 这些解析到容器。
- `host.docker.internal`  这解析到外部主机。

对于 Linux 需要运行的时候添加参数做到上述效果 
- `docker run -d --add-host host.docker.internal:host-gateway my-container:latest`
- 该`--add-host`标志将一个条目添加到容器的 `/etc/hosts` 文件中。
   上面显示的值映射`host.docker.internal`到容器的主机网关。
   `host.docker.internal`如果您愿意，可以用自己的字符串替换。

然后可以在 容器内使用 宿主机的网络代理一些请求了

要使用宿主机的网络还有另一种方式就是 `--network=host` 参考 : https://docs.docker.com/engine/reference/run/

#### --add-host=host.docker.internal:host-gateway 
这个参数最终再我的容器 /etc/hosts 生成的行是 `192.168.65.2	host.docker.internal`

`host-gateway` 直接翻译 : 主机网关

我们在主机上 `ifconfig -a` 得到的地址， 于此不同为 : `192.168.31.236`

我没有弄清原因，我理解这两个值应该是相同的




### 设置合适的源

这一点可以创建容器后再修改 `/etc/apt/sources.list` , 也可以 dockerfile 中直接配置好，效果相同

原来的文件在同目录下备份 :/etc/apt/sources.list.tom.bak
配置信息参考两个链接 
- : https://www.debian.org/mirror/list.zh-cn.html
- : https://mirrors.tuna.tsinghua.edu.cn/help/debian —— 如果证书有问题可以先用 http 




### 常用软件
 
查看当前系统上都安装过那些软件:https://www.jianshu.com/p/0476292e3e4a

        locales zsh sudo
        git inetutils-ping less man-db wget curl net-tools vim openssh-server 
        gdb 

#### mysql 应用和配置
使用 mysql 有两个路径
1. 自己运行一个容器，然后再里面安装 mysql 。 我跑了一个 Debian 安装 mysql 后始终无法运行 mysql ， 我没找到问题的根源。
   ```
   ➜  ~ service mysqld status
   mysqld: unrecognized service
   ```
2. 通过一个官方配置好的容器，来将 mysql 作为与开发环境相隔离的环境来运行。
   - 除了 mysql 的安装文档的相关介绍 ： https://dev.mysql.com/doc/refman/8.0/en/docker-mysql-getting-started.html#docker-starting-mysql-server
   - 还要注意容器页面的详细介绍 : https://hub.docker.com/_/mysql/
   - 具体操作方式， 可以 docker 命令行，可以 docker-compose ， 我没意愿和足够的动力继续了解 docker-compose 细节了，我用 命令行 。

我们使用的[镜像](https://hub.docker.com/_/mysql/), 我们在这里编辑和保存我们的一些命令用来将来作参考

```
docker run --name=tom_c_cxx_dev_db                                                                                \
           --env MYSQL_ROOT_PASSWORD=root                                                                         \   # Set environment variables , 当有多个环境变量，可以使用多个此属性多行设置即可
           --mount='type=bind,source=/media/tom/win_vm/_shared_folder,target=/host_mount_point,readonly=false'    \ # 挂载本地目录，用于数据交换比较方便
           --detach                                                                                               \ # Run container in background and print container ID
           mysql:8.0.29-debian                                                                                    \ # 使用的是那个镜像
           --character-set-server=utf8mb4 --collation-server=utf8mb4_unicode_ci                                   \ # 将所有表的默认编码和排序规则更改为使用 UTF-8 ( utf8mb4)
```

进到 mysql container 一看也是很多工具都没有，用起来很不称手。
我们可以尝试基于这个 mysql 容器将我们的开发环境配置结合做一个 dockerfile 重新编译下保存镜像方便后续使用。

#### 通过开发容器连接到 mysql 容器中的 mysql

```
mysql --host=172.17.0.3 --user=root --password
```
hostIp 查看方式
1. 打开 mysqlContainer : `ifconfig`
2. 宿主机 `docker container inspect mysql_container_name` | grep IPAddress



#### 安装和配置 ohmyzsh 
ohmyzsh 的 安装是交互式的 ， 这个交互动作如何用命令完成

- [最终解决办法](https://github.com/ohmyzsh/ohmyzsh#unattended-install)
- [相同需求人们的探讨](https://github.com/ohmyzsh/ohmyzsh/issues/5873)

这些动作需要额外的用户配置 ， 用户配置文件需要出现在 用户磁盘空间 ， 所以我们需要先探索 docker volume

首先要配置好代理，才能访问 github 

### 设置 ssh 服务状态

需要开端口, 当 一个容器已经运行起来了，还有机会修改开方的端口吗？ :https://github.com/docker/docker.github.io/issues/4942
- 或许可以通过 `docker container run --publish ` 试一下

### 创建用户和用户目录
```
# 修改 root shell
usermod root --shell='/bin/zsh'
# 创建 group
groupadd TOM --gid=1000
# 创建 user
useradd tom --uid=1000 --gid='TOM' --home='/home/tom' --create-home --shell='/bin/zsh'
# 为 user 设置根目录
mkdir /home/tom
chown --recursive tom:TOM /home/tom
# 允许 user 执行 sudo
$USER    ALL=(ALL:ALL) ALL
```

### volume 的相关信息

如果使用 volume 预计可以比较方便的分享数据内容，并且不区分平台和容器的无差别共享这部分数据。

但是我们仍然有几个疑问:
1. volume 是存储在那里
   - 文这个问题的根本原因是想借此信息来完成数据的拷贝和共享动作。现在这个问题不一定要解答了。
   - 我不知道 volume 在宿主机的什么位置
   - 只是通过 Docker Desktop 设置的 `Disk image location` 选项中有一个 大文件(`Docker.raw`)。
      不知道这个大文件和 volume / image 有多少关联
2. 如何才能完成 volume 的共享动作
   - 简单的说就是通过挂载容器和本地文件夹完成，并完成数据的拷贝动作。
   - https://docs.docker.com/storage/volumes/#backup-restore-or-migrate-data-volumes
   - https://bingohuang.gitbooks.io/docker_practice/content/data_management/management.html
3. 创建了一个 volume 如何为不同的 container 都挂载上
   - 使用选项 : `--volumes-from containerName` 在container 创建阶段可以挂载
4. 挂载的时候如何指定 volume 对于 container 某个用户的权限
   - 创建 volume 挂载点，并设置为指定用户所有权，避免挂载 volume 后 某些用户没有权限操作数据


参考内容 :
1. https://docs.docker.com/storage/volumes/
2. https://juejin.cn/post/7003246366671503367















### 我们了解下 dockerfile 

> 摘录我读到的，我接下来可能用到的点们

`ENV` 设置的变量不仅在 dockerfile 文件中作为变量 ，在生成的 image 中也还持有这里设置的变量。
   - 如果这不是被期望的可以考虑使用 `ARG` 。

`ARG` 在文件中定义变量名，可以不设置变量值。也可以这只默认值。
   - 没有默认值，就被认定为空字符串
   - 如果 `EVN`/ `ARG` 定义了同名的变量名 ，  `ENV` 会覆盖 `ARG` 的值。
   - `ARG` 设置的变量可以在命令调用阶段，设置值
      - dockerfile
         ```
         FROM busybox
         ARG user
         ```
      - 命令调用
         ```
         $ docker build --build-arg user=what_user .
         ```
   - `ARG` 仅在所在的语法段中有效，离开语法段，就是未定义的了。
      - `FROM` 定义了一个语法段的开始 ， 直到下个 `FROM` 定义，可以被认为是语法段。
   - 关于缓存失效(`cache miss`)的点，没有读懂。


假设我们希望定义安全变量，比如新建用户密码，不想保留痕迹怎么处理合适些？
- [还没看懂，用时详究](https://docs.docker.com/develop/develop-images/build_enhancements/#new-docker-build-secret-information)


`RUN` 指令有两种格式
   - `RUN <command>` shell 格式的 command ， Linux 默认执行 `/bin/sh -c` ; Windows 平台默认执行 `cmd /S /C`
      - 这个执行 shell 使用那个 shell 可以通过 命令 `SHELL` 来指定
   - `RUN ["executable", "param1", "param2"]`
   - 可以通过 `\(反斜杠)` 将长命令换行
   - 要使用“/bin/sh”以外的其他 shell，请使用传入所需 shell 的 _exec_ 形式。
      - 例如 : `RUN ["/bin/bash", "-c", "echo hello"]`
      - _exec_ 形式被解析为 JSON 数组，这意味着您必须在单词周围使用双引号 (") 而不是单引号 (')。
   - RUN 在下一次构建期间，指令缓存不会自动失效。
      - 在构建 Image 的时候， docker 检查每条命令， 看是否存在可以复用的 image ， 如果不希望使用缓存，记得指定 `--no-cache=true` 。
   - 有些 `echo '#带有多行注释的内容写入文件，会又失败的现象，考虑使用 COPY 命令完成吧。' `

`COPY` 文件拷贝，将 `docker build` 文件拷贝到 镜像中指定位置
   - `COPY [--chown=<user>:<group>] <src>... <dest>`
   - `COPY [--chown=<user>:<group>] ["<src>",... "<dest>"]`
   - COPY 可以将上下文文件拷贝到 镜像中，方便后续操作


### docker build 
```
# 进入 dockerfile 所在目录，构建 docker image
docker build --tag=debian:tom_c_cxx_dev_env --file=dev.vps.dockerfile .

含义，构建一个 image

--tag : 为 image 设置 tag
--file : 指定 dockerfile
 .    : 指定上下文目录为当前文件夹(执行命令处)
```

### docker run
```
docker run --name=FromDF --hostname=osName --interactive --tty --add-host=host.docker.internal:host-gateway 156c6f97a58a /bin/bash
```
- 含义:从 imageid:156c6f97a58a 构建一个 container 。

- `--name` 指定 container 名字
- `--hostname` 容器只能在创建的时候设置主机名，一旦设置无法更改了
- `--interactive` 交互式运行
- `--tty` 分配一个伪 TTY
- `--add-host` `host-gateway` 代表宿主机 ip ，  `host.docker.internal` 代表宿主机ip 别名，方便将容器中的网络代理到宿主机
- `/bin/bash` 跟容器的交互默认通过 bash 进行





```
docker run --name=FromDF --interactive --tty --add-host=host.docker.internal:host-gateway --user='tom:TOM' --workdir=/home/tom --mount='source=tom_c_cxx_volume,target=/testVolume'  debian:tom_c_cxx_dev_env /bin/bash
```

- `--user='tom:TOM'` 指定登陆用户
- `--workdir=/home/tom`  指定默认登陆目录
- `--mount='source=tom_c_cxx_volume,target=/testVolume'` 将名为 `tom_c_cxx_volume` 挂载到容器的 `/testVolume` 目录下
   - 如果 volume 已经被某一个 container 挂载了， 新创建的 container 也想挂载这个 volume 应该使用 `--volumes-from` 并删除`--mount`
      - `--volumes-from containerName`

### docker exec

```terminal
# 在正在运行的容器中运行一个新命令。
docker exec --interactive --tty --user=root:root tom_c_cxx_dev_container bash
```
- `--interactive --tty` 通过 伪终端 交互式运行
- `--user=root:root` 指定交互人身份
- `tom_c_cxx_dev_container` 指定容器
- `bash` 指定 shell 
- `--workdir` 指定工作目录

### 容器重命名 docker rename

```
# docker rename CONTAINER NEW_NAME

docker rename my_container my_new_container
```

### docker tag 镜像重命名 : https://docs.docker.com/engine/reference/commandline/tag/

```
# docker tag SOURCE_IMAGE[:TAG] TARGET_IMAGE[:TAG]
# 实际作用是修改 image 的 REPOSITORY 和  TAG , 感觉这时新增加了一个引用的样子 , 原来的 image 内容也还在
docker tag debian:tom_c_cxx_dev_env debian:tom_c_cxx_dev_env_bak
```

### docker commit  基于现有容器 生成镜像(image) : https://docs.docker.com/engine/reference/commandline/commit/

```
$ docker commit [OPTIONS] CONTAINER [REPOSITORY[:TAG]]

docker commit --author='tom.work@foxmail.com'                           \ # 作者信息
              --message='基于 debian11 的 mysql8 个人开发环境 2022.7.19'   \ # 提交附言
              tom_mysql_dev_container                                   \ # 容器名
              0tom0/tom_dev_env:tom_mysql8_env                          \ # 仓库：TAG

docker commit \
   --author='tom.work@foxmail.com'            \
   --message='c/c++ 个人开发环境 2022.7.19'     \
   tom_c_cxx_dev_container                    \
   0tom0/tom_dev_env:tom_c_cxx_env            \

docker container commit \
   --author='tom.work@foxmail.com' \
   --message='add user which uid gid is same as mac tom' \
   tom_c_cxx_dev_container  0tom0/tom_dev_env:c_cxx_clion_image
```
 
### docker push 将自己的镜像 push 到 dockerHub

需要先完成 https://hub.docker.com/ 的注册动作，并再 docker-desktop 登陆 dockerHub

```
$ docker push [OPTIONS] NAME[:TAG]

docker push  \
       --all-tags        \ # 推送存储库中的所有标记图像
       0tom0/tom_dev_env \ # 存储库

```


### Docker 异常处理

**mysql docker ， 由于修改文件(`/etc/mysql/my.cnf`)发生异常，无法正常启动了 .**
在 container 未启动的状态下修改 内部 文件 ： https://stackoverflow.com/a/50166314/7707781
```
# copy file out
docker container cp mysqlContainer:/etc/mysql/my.cnf ./mysql.my.cnf
# 即使 tab 不能自动补全到 `/etc/mysql/my.cnf` 也不代表"文件不存在无法完成拷贝"
# 猜测补全动作这个目录补全的是本地目录，不是容器内的目录

# edit file
# copy file in
docker container cp ./mysql.my.cnf mysqlContainer:/etc/mysql/my.cnf
```

### Docker 异常 : 有的 container 可以查看日志,有的 container 没有日志

1. 不知道原因是什么 .
2. 不知道日志文件保存在什么地方 . 


### Docker 在 mac 挂在的主机目录即使已经拥有了合理权限,依然无法访问

Operation not permitted
与系统无关,也不是 doker bug , 是以前担心误操作库文件, 我们手动 取消 了文件夹的写权限.
临时赋权即可

看来今后我们通过修改文件夹的所属用户更来的稳妥, 这样就要操作数据 用上 sudo 就方便多了, 也不担心忘记了瞎猜了


### vscode gdb 调试失败 

```ERROR: Unable to start debugging. Unexpected GDB output from command "-exec-run". During startup program exited with code 127.```

https://github.com/Microsoft/MIEngine/wiki/Troubleshoot-attaching-to-processes-using-GDB
1. 对于 Docker Linux 容器，需要在创建容器时添加该功能，以便允许使用gdb.
   --cap-add=SYS_PTRACE使用 启动容器时需要添加的标志docker run。
   更多信息可以在 [Docker 文档](https://docs.docker.com/engine/reference/run/#runtime-privilege-and-linux-capabilities) 页面上找到。
2. 以超级用户身份运行以下命令：echo 0| sudo tee /proc/sys/kernel/yama/ptrace_scope
   这会将 ptrace 级别设置为 0，之后只需使用用户权限，您就可以附加到调试器未启动的进程。


上述操作完成后仍然不可调试 , 将 docker image 更新为 与 m1 兼容的 arm64v8 架构后即可正常使用了