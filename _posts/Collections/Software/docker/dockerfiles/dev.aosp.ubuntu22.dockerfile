

#############################################################################################################
# 目的 ， 定制一个适合于 编译 AOSP 的 虚拟环境 . 
#
# 用户操作 dockerfile 必要指南
# 0. 先选择 FROM 语句取消注释才好后续操作
# 1. 总体目标不在赘述
# 2. 通过 dockerfile 构建 docker image
#     - 本 dockerfile 所在目录下的文件在后续均有用处，需要事先了解
#     - 进入本文件所在目录
#     - 开始构建 : 
#       docker build                                                      \ # docker build 本质上也是在一个容器中运行的
#              --add-host=host.docker.internal:192.168.65.2               \ # 主机设置了代理的情况下好像也不需要这个值 # 192.168.65.2 的值获取方式 ：创建容器阶段 `--add-host=host.docker.internal:host-gateway` 然后到容器中 `/etc/hosts` 查看
#              --build-arg=http_proxy=http://host.docker.internal:8889    \ # 设置本地代理
#              --build-arg=https_proxy=http://host.docker.internal:8889   \ # 设置本地代理
#              --no-cache=true                                            \ # 构建过程不使用缓存
#              --tag=debian:tom_c_cxx_dev_env                             \ # 为 image 设置 tag
#              --file=dev.vps.dockerfile .                                \ # 指定 dockerfile 和上下文目录
# 3. 构建 image 完成后需要准备好自己的 volume
#     - docker volume create tom_c_cxx_volume
#     - tom_c_cxx_volume : 表示 docker volume 的名字
# 4. 通过 创建好的 docker image 创建一个 docker container
#    docker run  \
#       --name=tom_c_cxx_dev_container                                                                          \ # 容器名字
#       --hostname='cxxEnv'                                                                                     \ # 操作系统部署后系统的名字，后期就无法修改了，如果不设置就是人类无法理解的串码
#       --interactive --tty                                                                                     \ # 创建后立刻通过伪终端开始与 容器 交互
#       --add-host=host.docker.internal:host-gateway                                                            \ # 将宿主机 ip 写入 容器 host, 容器中通过 `host.docker.internal` 就可以访问到宿主机 ip ， 方便使用 宿主机 网络
#       --user='tom:TOM'                                                                                        \ # 默认的，以此身份访问容器
#       --workdir=/home/tom                                                                                     \ # 默认的，进入容器的此目录
#       --publish="2222:22"                                                                                     \ # 本地端口 2222 映射到远程 22
#       --publish="1234:1234"                                                                                   \ # 本地端口 1234 映射到远程 1234 , 用于 clion debug
#       --mount='source=tom_c_cxx_volume,target=/mount_point/volume,readonly=false'                             \ # 默认的，将 volume `tom_c_cxx_volume` 挂载到 `/volume` 节点，允许读写。
#       --mount='type=bind,source=/Volumes/VM/docker/host_point/share,target=/mount_point/share,readonly=false' \ # 将本地文件挂载到指定节点，允许读写操作
#       --mount='type=bind,source=/Volumes/VM/docker/host_point/data,target=/mount_point/data,readonly=false'   \ # 将本地文件挂载到指定节点，允许读写操作
#       --security-opt="seccomp=unconfined"                                                                     \ # 从而允许 gdb server 的运行
#       --privileged                                                                                            \ # 完整的容器功能 , 这允许我们修改 /proc/sys/kernel/core_pattern
#       --cap-add=SYS_PTRACE                                                                                    \ # 允许 GDB 调试 : https://github.com/microsoft/vscode-cpptools/issues/7515
#       --detach                                                                                                \ # Run container in background and print container ID
#       debian:tom_c_cxx_dev_env                                                                                \ # 以此 image 为基础 创建 container 



#    docker run  \
#       --name=tom_c_cxx_dev_container                                                                          \ # 容器名字
#       --hostname='cxxEnv'                                                                                     \ # 操作系统部署后系统的名字，后期就无法修改了，如果不设置就是人类无法理解的串码
#       --interactive --tty                                                                                     \ # 创建后立刻通过伪终端开始与 容器 交互
#       --add-host=host.docker.internal:host-gateway                                                            \ # 将宿主机 ip 写入 容器 host, 容器中通过 `host.docker.internal` 就可以访问到宿主机 ip ， 方便使用 宿主机 网络
#       --security-opt="seccomp=unconfined"                                                                     \ # 从而允许 gdb server 的运行
#       --privileged                                                                                            \ # 完整的容器功能 , 这允许我们修改 /proc/sys/kernel/core_pattern
#       --cap-add=SYS_PTRACE                                                                                    \ # 允许 GDB 调试 : https://github.com/microsoft/vscode-cpptools/issues/7515
#       --detach                                                                                                \ # Run container in background and print container ID
#       debian:                                                                                \ # 以此 image 为基础 创建 container 


#    创建完成后使用 [docker exec --interactive --tty --user=tom:TOM --workdir=/home/tom tom_mysql_dev_container /bin/zsh] 打开容器交互窗口 。
# 4.1 在 C++ 环境 基础上增加一个端口暴露的能力即可
#     docker run  \                          
#        --name=tom_nginx_container                                                                              \
#        --hostname='nginxEnv'                                                                                   \
#        --interactive --tty                                                                                     \
#        --add-host=host.docker.internal:host-gateway                                                            \
#        --user='root:root'                                                                                      \ # 必须 默认 root 用户登录, 否则 依赖 image 中的 脚本无权执行
#        --workdir=/root                                                                                         \    
#        --mount='source=tom_c_cxx_volume,target=/mount_point/volume,readonly=false'                             \
#        --mount='type=bind,source=/Volumes/VM/docker/host_point/share,target=/mount_point/share,readonly=false' \
#        --mount='type=bind,source=/Volumes/VM/docker/host_point/data,target=/mount_point/data,readonly=false'   \
#        --security-opt="seccomp=unconfined"                                                                     \
#        --privileged                                                                                            \
#        --cap-add=SYS_PTRACE                                                                                    \
#        --detach                                                                                                \
#        --publish="80:80"                                                                                       \ # 绑定一个端口
#        debian:tom_nginx_env_arm64v8                                                                            \ # 具体名称取决于 build 命令
#     创建完成后可以选定身份登录容器 : [docker exec --interactive --tty --user=tom:TOM --workdir=/home/tom tom_nginx_container zsh]
# 4.2. 针对 mysql 容器的启动命令暂存 (mysql 已知挂在 volume 到 `/var/lib/mysql` 会导致异常, 本地目录整成.)
#      docker run  \
#        --name=tom_mysql_dev_container                                                                           \
#        --hostname='mysqlEnv'                                                                                    \
#        --add-host=host.docker.internal:host-gateway                                                             \
#        --user='tom:TOM' --workdir=/home/tom                                                                     \
#        --mount='source=tom_c_cxx_volume,target=/mount_point/volume,readonly=false'                              \ # 因为 tom_c_cxx_dev_container 挂载了,所以这里也挂载
#        --mount='type=bind,source=/Volumes/VM/docker/host_point/share,target=/mount_point/share,readonly=false'  \
#        --mount='type=bind,source=/Volumes/VM/docker/host_point/data,target=/mount_point/data,readonly=false'    \ # 将本地文件挂载到指定节点，允许读写操作
#                                  /Volumes/VM/docker/host_point/mysql_data--------------------->>>>>>>>>>>>>>>>>>\ # 挂载前需要先清空 文件夹, 有残存文件会导致容器无法正常 运行
#        --mount='type=bind,source=/Volumes/VM/docker/host_point/mysql_data,target=/var/lib/mysql,readonly=false' \ # mysql 挂载一个到 /var/lib/mysql , 用于存储 myssql 数据比较稳妥; 只能挂在文件夹,挂在 volume 会导致异常
#        --security-opt="seccomp=unconfined"                                                                      \
#        --env MYSQL_ROOT_PASSWORD=root                                                                           \ # 跟安全的密码传递方式还需要再了解下才好
#        --publish="3306:3306"                                                                                    \  
#        --publish="33060:33060"                                                                                  \
#        --detach                                                                                                 \
#        debian:tom_mysql_dev_env                                                                                 \
#        --character-set-server=utf8mb4 --collation-server=utf8mb4_unicode_ci                                     \ # 将所有表的默认编码和排序规则更改为使用 UTF-8 ( utf8mb4)
# 5. 容器首次启动后需要继续配置 我 的个性化内容
#     - docker exec --interactive --tty --user=root:root tom_c_cxx_dev_container bash
#        - 修改各个用户的密码,可以登陆任意账户，从而可以修改密码们
#     - 将备份文件 恢复到 volume : tar --extract --verbose --file='/host_mount_point/volume.bak.tar.xz' --directory='/volume'
#     - 用户还需要手动安装 mysql ， 配置 shell 相关文件
# 5. 想要退出 容器交互 直接 exit 即可
# 6. 想要启动刚刚关闭的容器 
#     - docker container start --attach --interactive tom_c_cxx_dev_container
# 7. 手动配置完成后，如有需要，将容器保存为镜像
#     - 这可以避免那些无法自动配置的动作再手动做一次
#     - 新镜像创建容器的时候，可以再初始化阶段，修改诸多参数，比如预期挂载目录
#
#
#
#
# dockerfile 指令作的事情
# 0. dockerfile 需要注意 不要轻易使用 单引号 这会导致 变量没有被解析
# 1. 先换源， 因为可能后操作用到的软件(命令都还没有安装)
# 2. 下载常用软件
#
#
# 参考内容 : 建议各种参考对照看，并以官方为准(因为有出入)
# - [官方文档](https://docs.docker.com/engine/reference/builder/)
# - [Docker从入门到实践 - 杨宝华](https://yeasy.gitbook.io/docker_practice/)
# - 共同需求的配置参考 :
#   0. https://www.cnblogs.com/davidhhuan/p/13227139.html
#   1. https://graueneko.com/archives/64/
#   2. https://imhuwq.com/2018/12/02/Clion%20使用%20Docker%20作为开发环境/
#   3. https://www.google.com/search?q=使用+Docker+作为+C%2B%2B+开发环境&oq=使用+Docker+作为+C%2B%2B+开发环境
#
#
#
# Debian 在 M1 芯片的 mac 电脑上, 需要一个参数 
#   - 虽然 debian 有 arm64 版本的包  --platform='linux/arm64/v8'
#   - 但是由于我们要安装不支持 arm64 cpu 的 mysql(oracle 未发布 arm 包) , 所以我们必须使用 amd 或者 intel 的debian包
#   - 虽然可以兼容运行,但是损失了部分性能
#   - 后来又尝试了 arm64v8/debian:bullseye , mysql 的 c++ 库无论如何都要自行编译, 此架构编译后完全可用
# Mysql base Debian 在 M1 芯片 设备上, 
#   - 已知需要兼容才能运行的 image :
#       - https://hub.docker.com/_/mysql
#       - https://hub.docker.com/r/amd64/mysql
#       - 兼容运行会损失一部分效率, 但是这些 image 是基于 Debian 的 . 我更倾向 .
#   - 已知可以完全适配的 image :
#       - https://hub.docker.com/r/arm64v8/mysql/
#       - 基于 Oracle , 我个人不是很习惯 .
# Nginx 是基于 Debian 11 的 有 arm64v8 版本
#   - arm64v8/nginx : https://hub.docker.com/r/arm64v8/nginx
#############################################################################################################

# FROM arm64v8/debian:jessie-slim
FROM amd64/ubuntu:24.04
# FROM arm64v8/ubuntu:16.04

# 定义几个变量方便后续作出修改
ARG userGroup=TOM
ARG userGroupId=1000
ARG userName=tom
ARG userId=1000
ARG userHomeDir=/home/$userName
# ARG userPwd 安全因素，稍后考量这个因素


## 要验证某些包是否已经安装了可以 `dpkg --listfiles packageName`
## 项目依赖库
ARG dependent="libssl-dev libfcgi-dev libcgicc-dev libgflags-dev"
ARG projectSoft="spawn-fcgi"
ARG clionDependent=""
# # 常用软件列表
ARG commonlyUsedSoftware="apt-transport-https ca-certificates locales zsh sudo \
    git inetutils-ping less man-db  tmux dialog sysv-rc-conf \
    htop cmake tree unzip clang-format \
    wget curl net-tools openssl openssh-server vim gdb pkg-config build-essential "
# ARG commonlyUsedSoftware="curl vim git zsh sudo locales"
## Clion docker 远程开发需要的软件 https://www.jetbrains.com/help/clion/clion-toolchains-in-docker.html
ARG clionRemoteSoft="tzdata \
                     build-essential gcc g++ gdb clang make ninja-build cmake  \
                     autoconf automake libtool valgrind locales-all dos2unix   \
                     rsync tar python python-dev gdb-multiarch gdbserver"


ARG imgContextDir=/_docker_context_dir

## 将上下文文件全部拷贝到镜像中，方便后续操作
COPY ./ $imgContextDir

## 先换源
# RUN cp /etc/apt/sources.list /etc/apt/sources.list.tom.bak
# RUN cat $imgContextDir/override_t_sources_ubuntu_14.04.list > /etc/apt/sources.list
# 安装常用软件
RUN apt update
RUN apt upgrade -y
RUN apt install -y $commonlyUsedSoftware $dependent $projectSoft $clionRemoteSoft

## 中文支持
# 设置支持的字符
RUN cat $imgContextDir/append_to_locale.gen >> /etc/locale.gen
# 加载修改后的字符
RUN locale-gen
# 设置 locale 相关的环境变量从而支持中文
Env LANG=en_US.utf8
Env LANGUAGE=en_US.utf8
Env LC_CTYPE="en_US.utf8"
Env LC_NUMERIC=zh_CN.UTF-8
Env LC_TIME=zh_CN.UTF-8
Env LC_COLLATE="en_US.utf8"
Env LC_MONETARY=zh_CN.UTF-8
Env LC_MESSAGES="en_US.utf8"
Env LC_PAPER=zh_CN.UTF-8
Env LC_NAME=zh_CN.UTF-8
Env LC_ADDRESS=zh_CN.UTF-8
Env LC_TELEPHONE=zh_CN.UTF-8
Env LC_MEASUREMENT=zh_CN.UTF-8
Env LC_IDENTIFICATION=zh_CN.UTF-8

# 开放 22 端口
# EXPOSE 22

## 设置时区为东八区
#   默认值0时区 '/usr/share/zoneinfo/Etc/UTC'
RUN ln -sf /usr/share/zoneinfo/Asia/Shanghai /etc/localtime


## 创建普通用户 & 修改用户配置
ARG zshPath=/bin/zsh
#   修改 root 用户shell
RUN usermod root --shell=$zshPath                                                                             \
    # 创建用户组
    && groupadd $userGroup --gid=$userGroupId                                                                   \
    # 创建用户和目录
    && useradd $userName --uid=$userId --gid=$userGroup --home=$userHomeDir --create-home --shell=$zshPath      \
    # 允许用户调用 sudo 命令
    && sed s/USER_NAME/$userName/ $imgContextDir/append_to_sudoers >> /etc/sudoers


## 为两个用户都安装 ohmyzsh , 同时附加相关的个人配置项
ARG omzshInstallSh=omzsh.install.download.sh
RUN curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh --output $imgContextDir/$omzshInstallSh
ARG ohmzshInstall="bash $imgContextDir/$omzshInstallSh --unattended"
RUN $ohmzshInstall \
    && cat $imgContextDir/append_to_shell_rc >> ~/.bashrc \
    && cat $imgContextDir/append_to_shell_rc >> ~/.zshrc
# 虽然创建了用户，但是仍然无法使用 su userName && other CMD 在指定身份下完成其他命令，所以通过拷贝的方式完成
RUN cp --recursive ~/.oh-my-zsh $userHomeDir \
    && chown --recursive $userName:$userGroup $userHomeDir/.oh-my-zsh \
    && cp ~/.zshrc $userHomeDir \
    && chown --recursive $userName:$userGroup $userHomeDir/.zshrc

# 设置 vim 样式
RUN cat $imgContextDir/append_to_vimrc >> $userHomeDir/.vimrc \
    && chown --recursive $userName:$userGroup $userHomeDir/.vimrc
    



# volume 挂载目录 , 预计用于挂在 volume , 
# 但是经验上看 , docker desktop 不稳定的情况下, container 如果无法启动, 数据有丢失可能 ; 
# 目前更倾向挂载本地文件目录, 这会有性能损失
ARG volumeDir=/mount_point/volume
# 计划用于挂载本地目录容器和宿主机之间共享文件比较方便
ARG hostShareDir=/mount_point/share
# 计划用于挂载本地目录作为数据目录,防止 docker 不稳定导致的数据无法备份的情况发生
ARG hostDataDir=/mount_point/data
ARG hostVmDir=/mount_point/vm
ARG hostSoftwareDir=/mount_point/software

## 定义共享存储 volume 挂载点, 并设置好权限，避免直接挂载后权限有问题
RUN mkdir --parents $volumeDir ; chown --recursive $userName:$userGroup $volumeDir
 # 定义宿主机的文件共享挂载点
RUN mkdir --parents $hostShareDir ; chown --recursive $userName:$userGroup $hostShareDir
 # 定义宿主机的数据文件挂载点
RUN mkdir --parents $hostDataDir ; chown --recursive $userName:$userGroup $hostDataDir
RUN mkdir --parents $hostVmDir ; chown --recursive $userName:$userGroup $hostVmDir
RUN mkdir --parents $hostSoftwareDir ; chown --recursive $userName:$userGroup $hostSoftwareDir
 # 如果有必要这里需要随时添加新的挂载点

## 自动启动 ssh service
# RUN service ssh start