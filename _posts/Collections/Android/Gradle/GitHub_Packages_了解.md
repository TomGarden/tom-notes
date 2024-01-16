使用 GitHub Packages 发布 Android lib


## 0x00. 远程仓库了解

之前我们使用 JCenter 作为远程仓库主要存在两个问题
1. 下载较慢, 有一定概率下载失败
2. 后来我上传也不行了 , 懒得排查上传异常原因了

所以我尝试探索其他的远程仓库
1. maven
2. github packages

再次研究这部分内容可以考虑下 : https://jitpack.io/


## 0x02. GitHub Packages 了解

GitHub Packages , 经过测试 , 上传比较快 , 同等环境下(翻墙代理) ,
从 JCenter 下载依赖 , 失败多次 ,
从 GitHub Packages 下载没有失败过

配置过程不复杂
1. [使用 Gradle 发布 Java 包](https://docs.github.com/cn/actions/language-and-framework-guides/publishing-java-packages-with-gradle)
2. [配置 Gradle 用于 GitHub 包](https://docs.github.com/cn/packages/using-github-packages-with-your-projects-ecosystem/configuring-gradle-for-use-with-github-packages)
3. [Publishing Android libraries to GitHub Packages](https://proandroiddev.com/publishing-android-libraries-to-the-github-package-registry-part-1-7997be54ea5a)
4. [__无效__ 为 aar 关联源代码](https://kaywu.xyz/2016/05/01/Maven-aar-source/)
5. [__有效__ 为 aar 关联源代码](https://stackoverflow.com/questions/26874498/publish-an-android-library-to-maven-with-aar-and-source-jar)

存在的问题就是 , 使用上传到 GitHub Packages 的 Lib 还需要 提供自己的 GitHub 身份认证 , 
虽然这也不是什么复杂的操作 , 但是比起直接一行代码完成依赖 , 还是会多那么几行烦人的代码 .

碰到的问题 : aar 上传后无法查看源码 , 已经解决了 , 这个小细节等下一阶段输出文档的时候再详细描述

恩 上传到 MavenCenter 更烦人 , 所以我回来啦



## 0x03. GitHub Packages 使用详情

配置文件 , 可以直接拷贝也可以参照上文官方指导 , 阅读后再使用

- 这个示例项目位置 : https://maven.pkg.github.com/TomGarden/lib_log
- 依赖多个 GitHub Packages 的示例项目 : https://github.com/TomGarden/lib_pickcolor
- 关于 token 生成指导 : https://docs.github.com/cn/github/authenticating-to-github/creating-a-personal-access-token
    - 上传的配置有必要勾选 `write:packages`
    - 下载的配置有必要勾选 `read:packages`


### 3.1. Android gradle 配置代码

```Groovy
ext {
    moduleVersionCode = 2
    moduleVersionName = '0.1.6'
    moduleName = 'LibLog'

    mavenGroupId = 'io.github.tomgarden'
}

//这个节点和官方文档不同
task androidSourcesJar(type: Jar) {
    /*生成 sources.jar 应对生成的 aar 跳转代码无法阅读的问题*/
    archiveClassifier.set('sources')
    from android.sourceSets.main.java.srcDirs
}

publishing {

    //这个节点和官方文档不同
    publications {
        gpr(MavenPublication) {
            groupId mavenGroupId
            artifactId moduleName
            version moduleVersionName
            artifact("$buildDir/outputs/aar/$moduleName-release.aar")
            // 将 generateSourcesJar Task 生成的 sources.jar 也一并上传
            artifact(androidSourcesJar)
        }
    }

    repositories {
        maven {
            name = moduleName
            //仓库地址
            url = uri("https://maven.pkg.github.com/TomGarden/lib_log")
            credentials {
                username = project.findProperty("gpr.user") ?: System.getenv("TOMGARADEN_USERNAME")
                password = project.findProperty("gpr.key") ?: System.getenv("PUBLISH_LIB_TO_GITHUB_PACKAGES_TOKEN")
            }
        }
    }
}
```

### 3.2. __环境变量设置实践__

```sh
#
# /Volumes/tom_disk/Users/tom/.tom_shell_profile
#
################################################################
# 以前我们用 bash 作为命令语言解释器 , 这时候如果我们需要配置环境变量
# 修改啊 ~/.bash_profile 即可
#
# 后来我们使用 zsh 作为命令语言解释器 , 这时候如果我们要配置环境变量就需要
# 设置文件 ~/.zshrc
#
# 干脆我们自己写一个文件 , 然后到上述两个文件中各添加一条指令:
# source ~/.tom_shell_profile
################################################################

# 发布 Android lib 到 github 需要的 github 做身份认证的 token
# 在 Android project 中通过 `System.getenv("ANDROID_SDK_HOME")` 获取此值

# 专一用于管理 GitHub Packages [write:packages/read:packages] 
export TOMGARADEN_USERNAME=TomGarden
export TOMGARADEN_WRITE_PACKAGES_TOKEN=略
export TOMGARADEN_READ_PACKAGES_TOKEN=略
```

```sh
#
# /Volumes/tom_disk/Users/tom/.zshrc
# /Volumes/tom_disk/Users/tom/.bash_profile
#
# 自定义环境变量设置(也可以将原文内容复制过来, 这么做是为了不同的命令解释器可复用)
source ~/.tom_shell_profile
```


### 3.3. 编译上传动作

```terminate
$gradlew clean 
$gradlew build
# 替换 ModuleName
$gradlew :<ModuleName>:publish
```

__至此依赖包已经上传到 GitHub Packages 了__

### 3.4. 下载已上传的依赖包到自己的项目中使用:

在要使用远程库的 Module 中添加代码
```Groovy
//此节点位于 ModuleName/build.gradle
dependencies {
    //implementation project(path: ':LibLog')
    implementation 'io.github.tomgarden:LibLog:0.1.6'
}

//此节点位于 ModuleName/build.gradle , 或者 ProjectName/build.gradle
repositories {
    maven {
        url = uri("https://maven.pkg.github.com/TomGarden/lib_log")
        url = uri("https://maven.pkg.github.com/TomGarden/lib_pickcolor")
        credentials {
            //不限的 github 账户名
            username = System.getenv("TOMGARADEN_USERNAME")
            //与 github 账户名成对的 具有 read:packages 权限的 token
            password = System.getenv("TOMGARADEN_READ_PACKAGES_TOKEN")
        }
    }
}
```

编译运行即可使用了





## 0x04. 如果一个人开发了一系列的工具组件 , 如何较简单的完成分发
1. 创建一个公共组件 repository : TomAndroidLibs
2. 所有分发组件上传到这个公共组价库
3. 使用组件的开发者需要配置自己的 GitHub 账户信息
4. 失败了 , 所以细节略
5. 可能是因为与仓库地址相关 , 所以上传的过程中报 402

### 4.1 记录一个异常
```
> Task :LibPickColor:publishGprPublicationToLibPickColorRepository FAILED

FAILURE: Build failed with an exception.

* What went wrong:
Execution failed for task ':LibPickColor:publishGprPublicationToLibPickColorRepository'.
> Failed to publish publication 'gpr' to repository 'LibPickColor'
   > Could not PUT 'https://maven.pkg.github.com/TomGarden/lib_pickcolor/io/github/tomgarden/LibPickColor/0.1.3/LibPickColor-0.1.3.aar'. Received status code 422 from server: Unprocessable Entity
```

[解决方法是将 artifactId 使用小写字母](https://github.community/t/keep-getting-received-status-code-422-from-server-unprocessable-entity/138576)

如果修改名称后找不到文件 `Could not read 'path/lib_pick_color-release.aar' as it does not exist.`
可以[参照链接 :  🔗 `archivesBaseName = moduleName`](https://github.com/TomGarden/lib_log/blob/master/LibLog/publish_github_packages.gradle)


### 4.2. `github package` 重复上传冲突异常
```
# 出现这种情况是因为上传包完成后 , 项目首页没有及时刷新包信息 UI 认为上传失败重新发起上传报的异常
# 上传完成后可以稍等 2 分钟再刷新页面

> Task :lib_system_bar:publishGprPublicationToLib_system_barRepository FAILED

FAILURE: Build failed with an exception.

* What went wrong:
Execution failed for task ':lib_system_bar:publishGprPublicationToLib_system_barRepository'.
> Failed to publish publication 'gpr' to repository 'lib_system_bar'
   > Could not PUT 'https://maven.pkg.github.com/TomGarden/lib_system_bar/io/github/tomgarden/lib_system_bar/0.0.1/lib_system_bar-0.0.1.aar'. Received status code 409 from server: Conflict
```

