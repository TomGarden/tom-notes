## 0x01. [Android 手动编译](https://juejin.im/post/5cc82110e51d456e79545d0e)

手动编译需要的 SDK 工具

AndroidSDK_HOME
- build-tools
- platforms

需要 .jks 文件,密码/别名 配置

1. `.jks` 文件放在 project 根目录 
2. `gradle.properties` 增加自己的配置项
    ```
    RELEASE_STORE_FILE=../******.jks
    RELEASE_STORE_PASSWORD=******
    RELEASE_KEY_ALIAS=******
    RELEASE_KEY_PASSWORD=******
    ```
3. module.gradle 配置恰当语句
    ```gradle
    android{
        //....

        signingConfigs {

            release {
                storeFile file(RELEASE_STORE_FILE)
                storePassword RELEASE_STORE_PASSWORD
                keyAlias RELEASE_KEY_ALIAS
                keyPassword RELEASE_KEY_PASSWORD
                v1SigningEnabled true
                v2SigningEnabled true
            }
        }


        buildTypes {
            release {
                minifyEnabled true
                zipAlignEnabled true
                // 移除无用的resource文件
                shrinkResources true
                proguardFiles getDefaultProguardFile('proguard-android-optimize.txt'), 'proguard-rules.pro'
                signingConfig signingConfigs.release
                //android.applicationVariants.all { variant ->
                //    variant.outputs.all {
                        //全都带有debug标记很奇怪
                //      outputFileName = "manban${defaultConfig.versionName}[${defaultConfig.versionCode}]_${variant.productFlavors[0].name}(${releaseTime()}).apk"
                //    }
                //}
            }
        }
    }
    ```