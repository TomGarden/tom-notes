## 0x01、Jenkins 安装
1. 新建虚拟机 Ubuntu16
2. 下载 JDK 解压到 beyourself 目录
3. 下载 [jenkins.war](https://jenkins.io/zh/doc/pipeline/tour/getting-started/)
4. 设置 Java/jenkins 环境变量 
    ```
    //修改`/etc/profile`文件 追加如下内容
    export  JAVA_HOME=/dev_kit/jdk/jdkSE1.8.0_131
    export  CLASSPATH=.:$JAVA_HOME/jre/lib/rt.jar:$JAVA_HOME/lib/dt.jar:$JAVA_HOME/lib/tools.jar
    export  PATH=$PATH:$JAVA_HOME/bin:$JAVA_HOME/jre/bin
    export  JENKINS_HOME=/data/jenkins_data/

    //上述代码生效的方式：
    //方式一 执行命令：source /etc/profile   (只能在当前命令行生效关闭本命令行新启动一个还要再次输入本命令才可以。)
    //方式二 注销或重启
    ```
5. 设置软链接 `ln -s /你的路径/java /usr/bin/java`
6. 重启虚拟机

### 1.1. 切换 jenkis 工作目录,上文已经设置了

Jekins 在引导安装插件的过程中直接右上角跳过引导.

查看 `Manage Jenkins    >   Configure System    >   	Home directory  >   最右端的 ? 有指引 :`

By default, Jenkins stores all of its data in this directory on the file system.
默认的,Jenkins 在 "/home/lover/.jenkins" 目录中存储所有数据.

There are a few ways to change the Jenkins home directory:
这里有几种方式改变这个默认文件夹:

- Edit the JENKINS_HOME variable in your Jenkins configuration file (e.g. /etc/sysconfig/jenkins on Red Hat Linux).
    - 在你的修改你的 Jenkins 配置文件中修改 JENKINS_HOME 的值
- Use your web container's admin tool to set the JENKINS_HOME environment variable.
    - 使用 WEB 容器修改 JENKINS_HOME 的值
- Set the environment variable JENKINS_HOME before launching your web container, or before launching Jenkins directly from the WAR file.
    - 启动 Jenkins 的 WEB 容器前设置环境变量 JEKNINS_HOME 值
- Set the JENKINS_HOME Java system property when launching your web container, or when launching Jenkins directly from the WAR file.
    - **启动 Jenkins 的 WEB 容器前设置环境变量 JEKNINS_HOME 值**(可用)
    - 修改配置 /etc/profile ，增加JENKINS_HOME 这个环境变量。`export JENKINS_HOME=/data/jenkins_data/`
    - 修改完不生效重启机器试试
- Modify web.xml in jenkins.war (or its expanded image in your web container). This is not recommended.

This value cannot be changed while Jenkins is running.
It is shown here to help you ensure that your configuration is taking effect.


### 1.2. 机器上的相关软甲
1. Git
2. [Gradle](https://gradle.org/install/)





##  0x02、Jenkins 运行
运行命令 `java -jar /你的目录/jenkins.war`
- 运行后在  `http://localhost:8080` 即可访问。

- **关闭：** jenkins启动后，在网址栏输入http://localhost:8080/exit,点击确认后，即可关闭jenkins
- **重启：** jenkins启动后，在网址栏输入http://localhost:8080/restart,点击确认后，即可完成重启jenkins
- **重新加载配置：** jenkins启动后，在网址栏输入http://localhost:8080/reload,点击确认后，即可完成重新加载jenkins配置信息

**记得切换 Jenkins 工作目录**

## 0x03、VitrualBox 查看虚拟机 IP
1. 在虚拟机关机的情况下设置虚拟机网络增加 仅主机(Host-Only) 网络设置项
2. 在虚拟机 ifconfig 查看 IP 地址
3. 现在在宿主机应该能 ping 通 虚拟机

## 0x04、宿主机访问虚拟机 jenkins 服务
1. 虚拟机启动 Jenkins 服务
2. 宿主机 `http://虚拟机IP:8080` 即可访问

## 0x05、 个人信息参考意义不大
注：如果没有共享粘贴板可以将虚拟机作为 SSH 服务器在宿主机进行操作
- 初始密码位于 `/home/lover/.jenkins/secrets/initialAdminPassword`
- 安装推荐插件(loading············)

关于第一个管理员
1. 账号：tom
2. 密码：tom.work@foxmail.com

Jenkins URL: http://Jenkins.manban.com/


## 0x06. FAQ

### 6.1. Jenkins 安装注意事项
1. 安装 jdk 设置环境变量
    * 建立链接  `ln -s /你的路径/java /usr/bin/java`
2. 安装 jekins

Job for jenkins.service failed because the control process exited with error code. See "systemctl status jenkins.service" and "journalctl -xe" for details.
invoke-rc.d: initscript jenkins, action "start" failed.
dpkg: error processing package jenkins (--configure):
 subprocess installed post-installation script returned error exit status 1
Processing triggers for ureadahead (0.100.0-19) ...
Processing triggers for systemd (229-4ubuntu4) ...
Errors were encountered while processing:
 jenkins
E: Sub-process /usr/bin/dpkg returned an error code (1)


### 6.2. Jekins 忘记密码
略，浏览器记住了，所以这次没有一定要解决它

### 6.3. 设置工具路径报错
`gradle is not a directory on the Jenkins master (but perhaps it exists on some agents)`

[解决方案 设置包含 gradle 的路径,不用指明 gradle 例如:](https://issues.jenkins-ci.org/browse/JENKINS-30489?focusedCommentId=266360&page=com.atlassian.jira.plugin.system.issuetabpanels%3Acomment-tabpanel#comment-266360)
- gradle 路径为 `/home/lover/.sdkman/candidates/gradle/6.0.1/bin/gradle`
- 应该填写 `/home/lover/.sdkman/candidates/gradle/6.0.1/bin/`

### 6.4. SDK location not found
```
> SDK location not found. Define location with an ANDROID_SDK_ROOT environment variable or by setting the sdk.dir path in your project's local properties file at '/beyourself/JenkinsWorkspace/workspace/build_android_apk/local.properties'.
```

**解决方案** 设置 添加 `local.properties` 文件

## 0x07. 构建 Android 项目的基本配置
1. 系统管理 > 系统配置 > 全局属性 > 环境变量
    - `ANDROID_SDK_HOME : /beyourself/AndroidSdk`

2. 系统管理 > 系统配置 > 全局工具配置
    - `jdk1.8.0_231  :  /beyourself/jdk1.8.0_231`
    - `Git  : git(在机器上已经安装了 git )`
    - `Gradle : 自动安装`(也可以手动安装然后填写路径或者命令)

3. 新建任务
    - 输入任务名称
    - 构建自由风格的软件项目
    - 确定

4. 任务配置信息
    1. 源码管理
    2. 构建 > 新增 > Invoke Gradle scripe > 选择 gradle 版本
        - Invoke Gradle 处于选中状态
        - Use Gradle Wrapper 未选中,并且设置 tasks : clean build

5. 构建后操作
    - 归档成品 : `app/build/outputs/apk/release/*.apk`

## 引导
1. [Create a Pipeline in Blue Ocean ](https://jenkins.io/doc/tutorials/create-a-pipeline-in-blue-ocean/)
2. [Creating a Pipeline ](https://jenkins.io/doc/book/blueocean/creating-pipelines/)






