Mac 安装 jdk7u71 找不到免安装的压缩包 . 从 dmg 文件 获取免安装文件们 . 


1. 下载 `Java SE Development Kit 7u71` dmg 文件 : `jdk-7u71-macosx-x64.dmg`
2. 解压软件解压
   ```
    tom@TomdeMacBook-Pro ➜  JDK 7 Update 71 tree ../JDK\ 7\ Update\ 71 
    ../JDK 7 Update 71
    ├── JDK 7 Update 71.pkg
    └── [HFS+ Private Data]
   ```
3. 解压软件解压 `JDK 7 Update 71.pkg`
   ```
    tom@TomdeMacBook-Pro ➜  JDK 7 Update 71 tree ../JDK\ 7\ Update\ 71
    ../JDK 7 Update 71
    ├── JDK 7 Update 71
    │   ├── Distribution
    │   ├── Resources
    │   ├── [TOC].xml
    │   ├── javaappletplugin.pkg
    │   └── jdk17071.pkg
    │       ├── Bom
    │       ├── PackageInfo
    │       ├── Payload             // 针对它做操作
    │       └── Scripts
    ├── JDK 7 Update 71.pkg
    └── [HFS+ Private Data]
   ```
4. 针对 Payload 做操作 : `cat Payload | gunzip -dc | cpio -i`
   ```
    tom@TomdeMacBook-Pro ➜  JDK 7 Update 71 tree ../JDK\ 7\ Update\ 71
    ../JDK 7 Update 71
    ├── JDK 7 Update 71
    │   ├── Distribution
    │   ├── Resources
    │   ├── [TOC].xml
    │   ├── javaappletplugin.pkg
    │   └── jdk17071.pkg
    │       ├── Bom
    │       ├── Contents            // 得到目标文件 , 拷贝到指定位置 cp -r ./Contents /.../jdk7-u71/
    │       ├── PackageInfo
    │       ├── Payload             
    │       └── Scripts
    ├── JDK 7 Update 71.pkg
    └── [HFS+ Private Data]
   ```
5. 将得到的目录拷贝到指定位置 , 即可 . 
