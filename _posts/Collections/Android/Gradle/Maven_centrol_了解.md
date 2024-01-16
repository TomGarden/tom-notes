
## 0x01. 目的 , 将 Android lib 上传到 Maven Central



gradle 代码如下

```groovy
ext {
    moduleVersionCode = 0123
    moduleVersionName = '0.1.23'
    moduleName = 'lib_log'
    mavenGroupId = 'io.github.tomgarden'
}

task androidSourcesJar(type: Jar) {
    /*生成 sources.jar 应对生成的 aar 跳转代码无法阅读的问题*/
    archiveClassifier.set('sources')
    from android.sourceSets.main.java.srcDirs
}

publishing {

    publications {
        gpr(MavenPublication) {
            groupId mavenGroupId
            artifactId moduleName
            version moduleVersionName
            artifact("$buildDir/outputs/aar/$moduleName-release.aar")
            // 将 generateSourcesJar Task 生成的 sources.jar 也一并上传
            artifact(androidSourcesJar)
            // artifact(generateJavadoc)

            /* pom 部分不能省略 , MavenCentral 会校验 */
            pom {
                name = moduleName
                description = "Android log lib"
                url = 'https://github.com/TomGarden/lib_log'

                licenses {
                    license {
                        name = 'The Apache License, Version 2.0'
                        url = 'http://www.apache.org/licenses/LICENSE-2.0.txt'
                    }
                }

                developers {
                    developer {
                        id = 'TomGarden'
                        name = 'Tom'
                        email = '01wukong10@gmail.com'
                    }
                }

                scm {
                    connection = 'https://github.com/TomGarden/lib_log.git'
                    developerConnection = 'https://github.com/TomGarden/lib_log.git'
                    url = 'https://github.com/TomGarden/lib_log'
                }
            }
        }
    }

    repositories {
        //上传到 maven center
        maven {
            name = moduleName
            url = "https://s01.oss.sonatype.org/service/local/staging/deploy/maven2/"
            credentials {

               /* 
               https://s01.oss.sonatype.org/#welcome
               网站的账号密码
                */
                username = System.getenv("MAVEN_USERNAME")
                password = System.getenv("MAVEN_PASSWORD")
            }
        }
    }
}

// 配置 GPG 签名
signing {

   /*
   GPG_FOR_MAVEN_PUBLISH__password 创建密钥对时候的密码


   GPG_FOR_MAVEN_PUBLISH__keyId 你的 keyId 后 8 位 可以通过 gpg --list-keys 取得 keyId


   GPG_FOR_MAVEN_PUBLISH__privateKeyFile 私钥文件路径
   gpg --output /your_path/private-key.gpg --armor --export-secret-keys <your-key-id>

   */


    def securityKeyPath = System.getenv("GPG_FOR_MAVEN_PUBLISH__privateKeyFile")
    def securityKeyFile = new File(securityKeyPath)
    useInMemoryPgpKeys(
            System.getenv("GPG_FOR_MAVEN_PUBLISH__keyId"),
            securityKeyFile.text,
            System.getenv("GPG_FOR_MAVEN_PUBLISH__password")
    )
    sign publishing.publications.gpr /* 与 gpr(MavenPublication) 对应 */
}


//这个代码块是权宜之计 ; 并非所有情况下都需要做这个代码块 , 如果本身可以打出需要的包名的包 , 此处即可注释
android {
    buildTypes {
        archivesBaseName = moduleName
    }
}


//在 project 执行命令, 即可完成上传
//分步执行
//../gradlew clean
//../gradlew build
//../gradlew publish

//../gradlew publishToMavenLocal  // 到这里查看你生成的文件 /Users/tom/.m2/repository
//一次执行所有
//./gradlew clean build publish
//./gradlew clean build publishToMavenLocal
//仅针对 LibLog 执行相关命令
//./gradlew :LibLog:clean :LibLog:build :LibLog:publish
```


## 0x02. 与 Maven Central 相关的地址有
1. https://mvnrepository.com/ : 我们过去常常会从这里查找依赖和下载依赖
2. https://central-stage.sonatype.org/publish/release/  这里的相关文档描述了如何
   - 提交 issues : https://issues.sonatype.org/browse/OSSRH-96388
   - 提交 issues 成功应该到那个网站进行操作 : https://s01.oss.sonatype.org/#welcome
3. 发布之前需要到这里操作 : https://s01.oss.sonatype.org/#welcome
4. 发布结果 : https://central.sonatype.com/artifact/io.github.tomgarden/lib_log/overview

Sonatype 是一个公司，而 Maven Central Repository 是 Maven 项目的中央仓库。它们之间的关系可以通过以下方式理解：

1. **Sonatype：**
   - Sonatype 是一家软件公司，提供与软件开发和构建相关的工具和服务。
   - 该公司维护着 Maven 项目的中央仓库（Maven Central Repository）。
   - Sonatype 的一项主要任务是管理和维护 Maven 中央仓库的内容，确保它包含各种开发人员和项目所需的库和工件。

2. **Maven Central Repository：**
   - Maven Central Repository 是 Maven 构建工具使用的默认仓库，也是广大开发者获取和分享 Java 库的主要渠道之一。
   - 该仓库由 Sonatype 管理和维护。开发者可以将他们的构建产物（如 JAR 文件）上传到 Maven Central Repository，使其能够被其他开发者通过 Maven 构建工具轻松访问和引用。

简而言之，Sonatype 提供了 Maven Central Repository，并负责维护和管理该仓库。开发者使用 Maven Central Repository 来获取和分享 Maven 构建的软件库。这种组织结构使得开发者可以方便地共享和访问各种 Java 库，同时确保了 Maven Central Repository 的可靠性和稳定性。



## 0x03. 关于 GPG 

### 3.0. GPG 是什么

与 GPG 具有相同能力的商业软件是 PGP
- 时间线上是 PGP 首先被创造 , 但是商业软件
- GPG 对标 PGP 被创造 , 是开源软件






GPG（GNU Privacy Guard）是一种用于加密和签名的工具，它采用公钥加密体系，旨在确保数据的机密性和完整性。以下是 GPG 的工作原理，简化以满足初学者的理解：

#### 3.0.1. 密钥对生成：

- **公钥和私钥：** GPG 使用一对密钥：公钥和私钥。公钥是公开的，用于加密和验证签名。私钥是保密的，用于解密和生成签名。

#### 3.0.2. 加密：

- **加密过程：** 当你要发送加密消息给其他人时，你使用接收者的公钥对消息进行加密。只有拥有私钥的接收者才能解密消息。

- **使用公钥加密：** 如果 Alice 想向 Bob 发送加密消息，Alice 将使用 Bob 的公钥来加密消息。只有 Bob 拥有与其公钥对应的私钥，因此只有 Bob 能够解密消息。

#### 3.0.3. 解密：

- **解密过程：** 接收者使用自己的私钥来解密接收到的消息。

- **使用私钥解密：** Bob 使用自己的私钥解密 Alice 发送的加密消息。

#### 3.0.4. 数字签名：

- **签名过程：** 当你想要签署一份文档或一份代码时，你使用私钥对文档进行签名。签名是一个特殊的哈希值，它标识了文档的完整性和签名者的身份。

- **验证签名：** 其他人可以使用签名者的公钥验证签名。如果验证成功，说明文档未被篡改且确实是由签名者签署的。

#### 3.0.5. 使用 GPG 进行代码签名：

- **在 Git 上签名提交：** 开发者可以使用 GPG 对 Git 提交进行签名，以确保提交的真实性和完整性。这通常用于代码库的安全性和可信度。

```bash
git commit -S -m "Your commit message"
```

在上述命令中，`-S` 标志用于对提交进行 GPG 签名。

总的来说，GPG 工作原理基于非对称加密，通过公钥加密和私钥解密来实现机密性，通过私钥签名和公钥验证签名来实现完整性和身份验证。这种加密体系允许安全地进行加密通信和验证文件的真实性。





### 3.1. 密钥生成


```bash
gpg --verbose --full-generate-key
gpg (GnuPG) 2.4.3; Copyright (C) 2023 g10 Code GmbH
This is free software: you are free to change and redistribute it.
There is NO WARRANTY, to the extent permitted by law.

gpg: enabled compatibility flags:
请选择您要使用的密钥类型：  <!-- 直接回车选默认值 (9) ECC（签名和加密） *默认* -->
请选择您想要使用的椭圆曲线：<!-- 直接回车选默认值 (1) Curve 25519 *默认* -->
请设定这个密钥的有效期限。  <!-- 直接回车选默认值 0 = 密钥永不过期 -->
密钥永远不会过期
这些内容正确吗？ (y/N) y   <!-- y 回车  -->

GnuPG 需要构建用户标识以辨认您的密钥。

<!-- 按自己的情况输入 -->
真实姓名： xxx1
电子邮件地址： xxx2
注释： xxx3
您选定了此用户标识：    “xxx1 (xxx3) <xxx2>”

更改姓名（N）、注释（C）、电子邮件地址（E）或确定（O）/退出（Q）？ o

<!-- 输入密码确定后 , 创建完成 
     GPG 生成的密钥对通常被存储在用户的家目录下的 `.gnupg` 文件夹中。具体路径取决于操作系统。
-->
```

### 3.2. 导出公钥：

使用以下命令来导出 GPG 公钥：

```bash
gpg --output public-key.gpg --armor --export <your-key-id>
```

- `--output public-key.gpg`: 指定导出公钥的输出文件名（可以根据需要更改）。
- `--armor`: 将输出转换为 ASCII Armor 格式，使其更容易在文本中传输。
- `<your-key-id>`: 你的 GPG 密钥的 ID。你可以在公钥列表中找到它，或者使用 `gpg --list-keys` 命令查看。

### 3.3. 导出私钥：

使用以下命令来导出 GPG 私钥：

```bash
gpg --output private-key.gpg --armor --export-secret-keys <your-key-id>
```

- `--output private-key.gpg`: 指定导出私钥的输出文件名（可以根据需要更改）。
- `--armor`: 将输出转换为 ASCII Armor 格式。
- `<your-key-id>`: 你的 GPG 密钥的 ID。

请注意，导出私钥通常需要提供解锁密码，以确保安全。如果你的私钥已设置密码，GPG 将提示你输入密码。


### 3.4. 同时导出公钥私钥到单一文件:
```bash
gpg --keyring secring.gpg --export-secret-keys >  /你的路径/secring.gpg 
# 会询问你密码
```


### 3.5. 将自己的公钥上传到公共服务器
```bash
gpg --send-keys --keyserver keyserver.ubuntu.com 秘钥ID
```


### 0.1. 参考内容
1. [阮一峰-GPG入门教程](https://www.ruanyifeng.com/blog/2013/07/gpg.html)
2. https://medium.com/@vivekvashistha/how-to-publish-android-libraries-on-maven-central-in-2023-a96e3c327008
3. https://docs.gradle.org/current/userguide/publishing_maven.html