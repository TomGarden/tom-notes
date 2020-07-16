## 一、 使用环境
Ubuntu 16.04

## 二、 操作流程
https://source.android.com/

### 2.1、 下载流程理解
1. 下载 repo 
2. 下载初始化数据(大小不固定，>30G,本次使用过程中发现文件大小为 45G )
    - 这个过程可以通过使用 repo 下载
        - 我的首次操作使用这种方式(下载到60G还没完成，我方了，转而停止下载使用清华镜像站的解决方案)
    - 清华镜像站推荐下载他们的压缩包然后解压使用
3. repo init (在这一步指定要下载的系统代码版本)
4. repo sync 
    - 在这里完成对目标代码的下载
    - 本步骤强烈建议使用脚本完成，因为会出错需要重复执行目标命令，但是长达几个小时的下载过程一直监视很麻烦。

### 2.2、 可复用的内容
1. repo 文件已经下载 `/media/tom/os/bin/repo`
2. repo 已经安装 `/media/tom/os/AOSP/android-****/.repo`
    - 当下载新版本的android源码时，新建一个对应版本的文件夹，将 `.repo` 文件夹整个剪切过去
    - 在新建的文件夹中执行通过 init 设置即将下载的源码版本
    - 执行 sync 命令即可


## 三、 问题解决
### 3.0、 使用国内镜像
1. [ 同步、更新、下载Android Source & SDK from 国内镜像站 ](https://www.cnblogs.com/bluestorm/p/4419051.html)
2. [清华 Android 镜像使用帮助](https://mirrors.tuna.tsinghua.edu.cn/help/AOSP/)

### 3.1、 网络不可达
```
$ repo init
fatal: Cannot get https://gerrit.googlesource.com/git-repo/clone.bundle
fatal: error [Errno 101] Network is unreachable
```
直接翻墙解决 > 恰好我有 VPS 和 Shadowsocks = 失败
- 失败原因应该是配置好系统代理之后没有重启命令行导致的。

解决方案：
1. 先单独克隆repo
    ```
    git clone https://gerrit-googlesource.lug.ustc.edu.cn/git-repo
    ```
2. 然后将git-repo里面的repo文件复制到bin目录，然后chmod a+x ~/bin/repo.
    - 再在同步源码的工作目录新建.repo文件夹，把git-repo重命名为repo复制到.repo目录下：
    - 重新初始化：
    ``` 
    repo init
    ``` 
为了应对重复失败：`error: Exited sync due to fetch errors`。
我们找到一个脚本：
```sh
#!/bin/sh
repo sync -j4
while [ $? -ne 0 ]
do
repo sync -j4
done
```

### 3.2、 疑似错误
听说 Android 源码一共就 4~8G 但是我们都下载了 60+G 还没有完这然我怀疑下错了，所以我想再来一次。
- 并且使用了清华镜像教程



### 转移到 cygwin
0. cd /cygdrive/i/AOSP/android-4.4.4_r1/
1. /cygdrive/i/AOSP/bin/repo init -u https://aosp.tuna.tsinghua.edu.cn/platform/manifest -b android-4.4.4_r1
2. ./sync_tomsh
3. /cygdrive/i/AOSP/bin/repo sync


### cygwin 查看当前编码
在 `repo sync -c` 出现错误 `(UnicodeDecodeError: 'ascii' codec can't decode byte 0xe4 in position 9: ordinal not in range(128))` 我们认为是python 默认编码的原因于是修改 python 默认编码为 utf8 (从默认的 ascii 修改成  utf8)



http://shirley-ren.iteye.com/blog/1018750

### cygwin permission denion
以管理员身份运行


### 转到虚拟机
- cd /home/tom/beyourself/shared_folder/AOSP/AOSP/android-4.4.4_r1
- /home/tom/beyourself/shared_folder/AOSP/AOSP/bin/repo init -u https://aosp.tuna.tsinghua.edu.cn/platform/manifest -b android-4.4.4_r1



有些类文件我们 google 很轻松就找到了源码，但是这和我们下载下来的源码的分类和路径不大相同：这时什么原因我们应该如何根据 google 到的代码在本地找到对应？

例如我们当前在 google 找到了目标代码
- `android / platform / libcore / android-4.3_r3 / . / luni / src / main / java / libcore / io / Libcore.java`
- 针对这个结果我们在本地找到了这样的路径：
-                   `I:\AOSP\android-4.4.4_r1\libcore\ luni \ src \ main \ java \ libcore \ io`
- 如果所有的源码具有如上规律那事情就很清楚了。我们暂且这么认为

### 3.3、 The following untracked working tree files would be overwritten by checkout
```
Syncing work tree:  97% (437/450)error: The following untracked working tree files would be overwritten by checkout:
	10/android.jar
	10/framework.aidl
	……//代表一堆文件
	Android.mk
	CleanSpec.mk
	api/1.xml
	……//代表一堆文件
	current/Android.mk
	……//代表一堆文件
Please move or remove them before you can switch branches.
Aborting
Syncing work tree: 100% (450/450), done.  

error: prebuilts/sdk/: platform/prebuilts/sdk checkout 48df57e9d07887b7621d51cc93ae7600815a842d 
```
解决方案：将上述文件删除重新执行 sync 命令即可

### 3.4、 info: A new version of repo is available
```
info: A new version of repo is available

warning: project 'repo' branch 'master' is not signed
warning: Skipped upgrade to unverified version
```
尚未解决


## 0x04. Google 对自家手机硬件的软件支持计划

https://support.google.com/pixelphone/answer/4457705?hl=zh-Hans

## 0x05. repo 使用细节

在清华镜像站, 下载压缩包 ,解压之后直接执行 `repo sync ` 即可检出所有 AOSP 代码 . 

这里需要搞清楚的是, 
1. 我们并未指定源码版本 , 那么我们如果进行编译的话是在编译那个版本 ? 
2. 再有就是, 如果这时候我们想要编译指定版本我们应该怎么做 ?
3. 暂时猜测 repo 既然是 git 的简化工具, 那么 AOSP 是否采用分支的方式管理不同版本的代码的呢?
    - 有待实践确认这一猜想

### 5.1. 启发命令
- [AOSP之REPO操作](https://www.jianshu.com/p/358ea9c1c644)\

#### 分支管理

__查看所有分支__

```
cd .repo/manifests
git branch -a
# 或
git branch -a | cut -d / -f 3
```

__切换分支__

```
$ repo init -b android-4.2.2_r1 
```

repo切换分支后，cat .repo/manifests.git/config 可见以下内容，在branch "default"的merge那里，没切换前是merge = refs/heads/master,切换后如下：

```
[core]
    repositoryformatversion = 0
    filemode = false
[filter "lfs"]
    smudge = git-lfs smudge --skip -- %f
[remote "origin"]
    url = git://mirrors.ustc.edu.cn/aosp/platform/manifest
    fetch = +refs/heads/*:refs/remotes/origin/*
[branch "default"]
    remote = origin
    merge = refs/heads/android-4.2.2_r1

# 创建自己的新分支
$ repo start gingerbread-release --all 

# 查看当前的分支
$ repo branches
```