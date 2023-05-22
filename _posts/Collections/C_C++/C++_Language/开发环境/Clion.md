刚开始探索 IDE 的时候到现在 , 有将近半年时间

0. 最开始我们就是计划远程开发, 直接在将要部署的环境上开发 . 
   - 我们经历了最早的 vps Linux 开发环境 ; 由于网络环境好 , 设备配置高的话费用过高 , 舍弃 . 
   - 我们在本地运行 Linux 虚拟机(virtualbox) , 不够轻便 , 基于 虚拟机开发 , 切换不方便 , 不适用虚拟机的图形界面 , docker 更合适 ; 
   - 也考虑到 docker 将来部署也会更方便些 , 我们来到了 docker .
1. 最开始我们使用 vim , 好多基于图形界面的操作习惯要切换为命令 , 很难改变了 , 舍弃
2. VsCode 和 clion 的远程开发套件都试了下 , VsCode 使用起来坡度更小 . 将近半年的时间内 , 就使用 VsCode 做了 . 
   - 使用 VsCode 开发我们需要改变一些习惯
   - jetbrains 快捷键 : IntelliJ IDEA Keybindings
   - 代码美化/提示 : clangd
      - 可用 , 但是对于 高版本的 C++ 标准支持还不很好
   - git : Git Graph / GitLens — Git supercharged(只有public 仓库 可用)
   - 其他许多插件组合 , 也花了些精力 , 但是使用无法完全在细节上像 jetbrains 般舒适
3. 不够舒适 , 就一直去尝试其他的 , 2023年03月 又想看看 clion + docker 是怎么搞的
   - 配置好了 . 


jetbrains clion remote development 的理解

0. docker 根据我们的 image 自行构建 container , 然后将本地代码拷贝过去编译/调试/执行
   - 过去我们的开发方式也是将本地目录作为 volume 挂在到 container , 故 , 完全复用
   - 卷挂载动作需要到 Toolchains 设置
1. 配置好 docker file : https://www.jetbrains.com/help/clion/clion-toolchains-in-docker.html#build-and-run
   - 实际上就是装了几个软件 , 我们过去使用 debian 容器完全可以复用 , 安装几个软件即可
2. 创建 Docker 工具链
   - Container setting 部分 , 挂载动作 ; 
      - 如果 图形界面 有 bug 可以直接 在 Run option 自己填写命令完成
        ```
        //回车换行需要删除 , 最终是一行
        --entrypoint=  
        --volume tom_c_cxx_volume:/mount_point/volume  
        --volume /Volumes/VM/docker/host_point/share:/mount_point/share  
        --volume /Volumes/VM/docker/host_point/data:/mount_point/data  
        --publish 8080:80
        --publish 4444:443
        --rm
        ```
3. 我们对于 docker 没有在 dockerfile 中进行配置 , 最终在 clion 创建的 container 中是没有 . 
   - 对于这一点 , 将来或需需要我们重新编辑 dockerfile 
4. 远程调试暂时还没有搞清楚 , 暂时也没有需要 , 可以后续再考虑 . 
5. 以后每次我们需要再 容器中安装什么东西 , 就需要我们安装好后打包成 image 才可以了 . 

## 可执行文件所拥有的权限

这里有问题是因为我们没有忠实的执行官方教程 : https://www.jetbrains.com/help/clion/clion-toolchains-in-docker.html#sample-dockerfile
- 关键点没有在于创建 UID GID 与本机相同的用户

但是我们的 container 已经运行很久了 , 我们过去的常用用户一直运行正常 , 现在我们尝试直接创建于 mac 同 uid gid 的用户
``


