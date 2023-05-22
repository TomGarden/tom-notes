# [美团Android资源混淆保护实践](https://tech.meituan.com/mt-android-resource-obfuscation.html)
1. 原文作者：jianshuai 
2. 发布时间：2015-09-30 09:00
3. 转载时间：2017-11-27 12:01:47
## 一、 前言

Android应用中的APK安全性一直遭人诟病，市面上充斥着各种被破解或者汉化的应用，破解者可以非常简单的通过破解工具就能对一个APK进行反编译、破解、汉化等等，这样就可以修改原有代码的逻辑、添加新代码、添加或修改资源、或者更有甚者植入病毒等等，从而破坏原有APK的安全和用户体验，最终伤害到用户和原有的开发者。
而事物都是有两方面的，有矛就有盾，针对Android应用安全的各种方案应运而生，大家比较熟悉一般是各类加壳加固的工具，我们可以使用这些工具来保护我们的APK，加壳加固是另外一个话题了，我们这里不对加壳加固进行介绍，后续如果有机会会单独开一个话题讨论，我们在开发过程中可以通过ProGuard或者DexGuard来保护我们的代码，从而实现相对的代码安全，但我们的资源呢？我们往往忽略对资源文件的保护，那这里将要分享的是如果采用常规方式对APK中的资源文件进行保护。

## 二、资源安全

资源安全这个话题目前大家关注度不算太高，相比较而言大家更关注代码安全，目前市面上各类APP基本都使用了ProGuard来保护代码的安全，但对资源文件的保护力度都不大，其实资源文件是存在比较大的安全隐患，那资源会有哪些安全隐患呢？下面我们通过一个比较简单的例子来说明下保护资源文件的重要性。

我们先用最常见的apktool工具来反编译一个应用来看看，通过运行下面命令就能进行反编译；
>apktool d -s xxx.apk

反编译成功后我们来看下反编译得到的文件结构（见下图）:
- ![decompile_folder_struct](Image\decompile_folder_struct.png)

通过上图中的目录结构，我们可以看到这个应用的资源文件大概有：anim、drawable、layout、menu、values等等，我们可以通过修改这些文件夹下的资源文件，并通过apktool进行回编译（apktool b 命令）就能创建一个经过修改过的APK应用，例如我们修改下图中红色横线所标示的layout文件，就能往原有APK的支付信息（根据资源名称猜测这个layout的意图）中添加一些我们自己的东西:
- ![decompile_folder_struct2](Image\decompile_folder_struct2.png)

这个问题主要是因为我们在开发过程中倡导命名的规范性，一般都要求在命名时做到见名知意，这样能够方便我们自己的理解和维护，但同时这也方便了破解者，破解者可以轻松的根据文件名称来猜测这个文件的意图和作用，从而做破坏性的修改。

通过这个例子我们可以看出目前资源安全的重要性，那如何做到资源安全呢？安全都是相对的，没有绝对的安全，我们接下来要讨论的是类似Proguard方式的对我们的资源进行保护。我们主要是通过修改AAPT工具来对资源进行保护，为了方便理解，下面先讲一下Android应用是怎么查找资源的。

## 三、 Android查找资源的流程

在Android系统中，每一个应用程序一般都会配置很多资源，用来适配不同密度、大小和方向的屏幕，以及适配不同的国家、地区和语言等等。这些资源是在应用程序运行时自动根据设备的当前配置信息进行适配的。这也就是说，给定一个相同的资源ID，在不同的设备配置之下，查找到的可能是不同的资源。
这个查找过程对应用程序来说，是完全透明的，这个过程主要是靠Android资源管理框架来完成的，而Android资源管理框架实际是由AssetManager和Resources两个类来实现的。其中，Resources类可以根据ID来查找资源，而AssetManager类根据文件名来查找资源。事实上，如果一个资源ID对应的是一个文件，那么Resources类是先根据ID来找到资源文件名称，然后再将该文件名称交给AssetManager类来打开对应的文件的。基本流程如下图：
- ![android_resource_resolved_flow.png](Image\android_resource_resolved_flow.png)

通过上图我们可以看到Resources是通过resources.arsc把Resource的ID转化成资源文件的名称，然后交由AssetManager来加载的。

而Resources.arsc这个文件是存放在APK包中的，他是由AAPT工具在打包过程中生成的，他本身是一个资源的索引表，里面维护者资源ID、Name、Path或者Value的对应关系，AssetManager通过这个索引表，就可以通过资源的ID找到这个资源对应的文件或者数据。

## 四、 AAPT介绍

AAPT是Android Asset Packaging Tool的缩写，它存放在SDK的tools/目录下，AAPT的功能很强大，可以通过它查看查看、创建、更新压缩文件(如 .zip文件，.jar文件, .apk文件), 它也可以把资源编译为二进制文件，并生成resources.arsc, AAPT这个工具在APK打包过程中起到了非常重要作用，在打包过程中使用AAPT对APK中用到的资源进行打包，这里不对AAPT这个工具做过多的讨论，只看一下AAPT这个工具在打包过程中起到的作用，下图是AAPT打包的流程：
- ![aapt_packaging_flow.png](Image\aapt_packaging_flow.png)

AAPT这个工具在打包过程中主要做了下列工作：

1. 把"assets"和"res/raw"目录下的所有资源进行打包（会根据不同的文件后缀选择压缩或不压缩），而"res/"目录下的其他资源进行编译或者其他处理（具体处理方式视文件后缀不同而不同，例如：".xml"会编译成二进制文件，".png"文件会进行优化等等）后才进行打包；
2. 会对除了assets资源之外所有的资源赋予一个资源ID常量，并且会生成一个资源索引表resources.arsc；
3. 编译AndroidManifest.xml成二进制的XML文件；
4. 把上面3个步骤中生成结果保存在一个*.ap_文件，并把各个资源ID常量定义在一个R.java中；

.ap_这个文件会在生成APK时放入APK包中, .ap_ 这个文件本身是一个ZIP包，他里面包含resources.arsc、AndroidManifest.xml、assets以及所有的资源文件，下图是UNZIP后的截图：
- ![ap_file_unzip.png](Image\ap_file_unzip.png)

可以看出*.ap_这个文件中包含的内容，这个文件存放在build/intermediates/res的目录下，下图是这个文件存放的路径截图：
- ![ap_file_unzip2.png](Image\ap_file_unzip2.png)

## 五、 资源保护

我们这里参考Proguard Obfuscator方式，对APK中资源文件名使用简短无意义名称进行替换，给破解者制造困难，从而做到资源的相对安全；通过上面分析，我们可以看出通过修改AAPT在生成resources.arsc和*.ap_时把资源文件的名称进行替换，从而保护资源。
通过阅读AAPT编译资源的代码，我们发现修改AAPT在处理资源文件相关的源码是能够做到资源文件名的替换，下面是Resource.cpp中makeFileResources()的修改的代码片段：
```C++
    static status_t makeFileResources(Bundle* bundle, const sp<AaptAssets>& assets,
                                      ResourceTable* table,
                                      const sp<ResourceTypeSet>& set,
                                      const char* resType)
    {
        String8 type8(resType);
        String16 type16(resType);

        bool hasErrors = false;

        ResourceDirIterator it(set, String8(resType));
        ssize_t res;
        while ((res=it.next()) == NO_ERROR) {
            if (bundle->getVerbose()) {
                printf("    (new resource id %s from %s)\n",
                       it.getBaseName().string(), it.getFile()->getPrintableSource().string());
            }
            String16 baseName(it.getBaseName());
            const char16_t* str = baseName.string();
            const char16_t* const end = str + baseName.size();
            while (str < end) {
                if (!((*str >= 'a' && *str <= 'z')
                        || (*str >= '0' && *str <= '9')
                        || *str == '_' || *str == '.')) {
                    fprintf(stderr, "%s: Invalid file name: must contain only [a-z0-9_.]\n",
                            it.getPath().string());
                    hasErrors = true;
                }
                str++;
            }
            String8 resPath = it.getPath();
            resPath.convertToResPath();

            String8 obfuscationName;
            String8 obfuscationPath = getObfuscationName(resPath, obfuscationName);

            table->addEntry(SourcePos(it.getPath(), 0), String16(assets->getPackage()),
                            type16,
                            baseName, // String16(obfuscationName),
                            String16(obfuscationPath), // resPath
                            NULL,
                            &it.getParams());
            assets->addResource(it.getLeafName(), obfuscationPath/*resPath*/, it.getFile(), type8);
        }

        return hasErrors ? UNKNOWN_ERROR : NO_ERROR;
    }
```

上述代码是在ResourceTable和Assets中添加资源文件时， 对资源文件名称进行修改，这就能够做到资源文件名称的替换，这样通过使用修改过的AAPT编译资源并进行打包，我们再用上面讲到的apktool这个工具进行反编译，下图是反编译后的截图：
- ![decompile_folder_struct_with_modified_aapt.png](Image\decompile_folder_struct_with_modified_aapt.png)

发现什么变化了吗？在res目录下熟悉的layout、drawable、anim、menu等文件夹不见了，那他们去哪了呢？因为apktool工具把它们放到了unknown文件夹下了，见下图：
- ![decompile_folder_struct_with_modified_aapt2.png](Image\decompile_folder_struct_with_modified_aapt2.png)

让我们来看一下unknown文件夹，你会发现资源文件名已经被简短无意义名称进行替换了，这样会给反编译者制造理解上的困难，反编译者需要消耗一定的时间来搞清楚这些资源文件的作用，资源混淆带来的另外一个好处是能明显减小APK的大小，资源混淆既能保护资源文件的安全又能减小安装包的大小，那我们何乐而不为呢？

这样通过修改AAPT，我们可以在代码零修改的基础下就能做到相对的资源安全，当然安全是相对的，没有绝对的安全。