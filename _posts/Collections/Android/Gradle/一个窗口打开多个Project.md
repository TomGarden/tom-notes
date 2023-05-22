
## 0x00. 要解决的问题

1. 一个窗口打开多个 Project
2. 跨 Project 引用 model


## 0x01. 参考
1. [Android Studio在同一个窗口中打开多个Project【附效果图附源码】](https://blog.csdn.net/lucherr/article/details/71773878)
2. [在一个 android studio中怎么导入多个project？](https://www.zhihu.com/question/27823277/answer/129468242)
3. [Gradle Build Language Reference](https://docs.gradle.org/current/dsl/)


## 0x02. 仍需探究
1. `apply from: 'https//:server/path/xxxXxxxXxx.gradle'`
2. 本文的书写是以模仿为前提 , 尚未熟悉系统了解 gradle 相关语法



## 0x03. 临时解决方案 gradle 文件全文如下

```gradle
// dependent.local.gradle

/**
 * 描述 : 设计用于加载本地组件的函数
 *
 * 可以解决相对简单的项目依赖的相关情况 , 对于依赖的层级较深的情况 , 有的要依赖远程包 , 有的依赖本地代码的情况 就无法满足需求了 .
 * 有这样复杂的需求可以考虑自动化完成这个依赖配置 , 已知的一个工具 : https://github.com/pqixing/aex
 *
 * 使用方法:
 * 1. 创建一个空的 Android Project , 删除其中所有的 module , 称其为 manageProject
 * 2. 将本文件拷贝到 manageProject 根目录
 * 3. 对本文件的代码块 ② ③ 酌情做出修改
 * 4. 在 `manageProject/setting.gradle` 操作 :
 *      ```
 *      apply from: 'dependent.local.gradle'
 *      include_local_lib_pick_color()
 *      include_local_tetris_2018()
 *      ```
 * 5. 在 `manageProject/build.gradle` 操作 :
 *      ```
 *      apply from: 'dependent.local.gradle'
 *      ```
 */
buildscript {

    /** ① 此 闭包 定义的函数无需改动, 直接在本文件下文调用即可*/
    ext {
        loadLocalConfigFile = { String localFileName = "local.properties" ->
            Properties properties = new Properties()
            def localPropertiesFile = new File(rootDir, localFileName)

            if (localPropertiesFile.exists()) {
                properties.load(localPropertiesFile.newDataInputStream())
            } else {
                throw RuntimeException("$localFileName 不存在 , 需要手动查看此异常")
            }
            return properties
        }

        /** 依赖本地 module , 可以在 module 中调用
         * module.gradle 调用示例
         *  不推荐 : rootProject.ext.dependentModule(flag, project_name, localModuleName, remoteModuleName, "com.example.module_name", versionCodeStr, project)
         *  推荐   : rootProject.ext.dependentModuleName(project)
         *
         * localModuleName , remoteModuleName 有可能是不同的 , 视具体情况而定
         *
         * @param useLocalFlagKey : local.properties 配置的字段 , 用于标识是否使用本地 module
         * @param moduleName : 本地 module 在引入当前项目下管理的时候叫做什么名字
         * */
        dependentModule = { Boolean useLocalFlag,
                            String projectName,
                            String localModuleName,
                            String remoteModuleName,
                            String remotePackageId,
                            String remoteModuleVersion,
                            Project project ->
            project.dependencies {
                if (useLocalFlag) {
                    println("${project.projectDir} 本地 $localModuleName")
                    api project.project(":$projectName:$localModuleName")
                } else {
                    println("${project.projectDir} 远程 $remoteModuleName")
                    implementation "$remotePackageId:$remoteModuleName:$remoteModuleVersion"
                }
            }
        }

        dependentModuleForce = { Boolean useLocalFlag,
                                 String moduleName,
                                 String remotePackageId,
                                 String remoteModuleVersion,
                                 Project project ->
            configurations.all {
                resolutionStrategy {
                    if (useLocalFlag) {
                        println("${project.projectDir} 本地 $moduleName")
                        force project.project(":$moduleName")
                    } else {
                        println("${project.projectDir} 远程 $moduleName")
                        force "$remotePackageId:$moduleName:$remoteModuleVersion"
                    }
                }
            }
        }

        /**
         * @param moduleNames : 需要留意顺序 , 如果 project 中的 module 有依赖管理 , 顺序靠后的依赖顺序靠前的
         */
        includeLocalProjectAndModules = { Boolean useLocalFlagKey,
                                          String localProjectPath,
                                          String projectName,
                                          ArrayList<String> moduleNames ->
            if (useLocalFlagKey && localProjectPath) {
                include(":$projectName")
                project(":$projectName").projectDir = new File(localProjectPath)
                for (String oneModuleName : moduleNames) {
                    include(":$projectName:$oneModuleName")
                }
            }
        }
    }


    /** ② 此 闭包 定义函数应该在 setting.gradle 中调用 */
    ext {
        /*****************************************************************************/
        /* 需要注意的 xxxx_xx_xxx_project_name 这个命名在原 project 中需要一个同名字段    */
        /*****************************************************************************/

        /****************************************/
        /*            lib_pickolor              */
        /****************************************/
        use_local_lib_pick_color = true
        lib_pick_color_project_dir = '/Volumes/document/AndroidStudioCode/lib_pickcolor'
        lib_pick_color_project_name = 'lib_pickcolor'
        lib_pick_color_module_lib_pick_color = 'lib_pick_color'
        lib_pick_color_module_example_pick_color = 'ExamplePickcolor'
        lib_pick_color_project_content_modules = [
                lib_pick_color_module_lib_pick_color,
                lib_pick_color_module_example_pick_color,
        ]


        /****************************************/
        /*            Tetris-2018               */
        /****************************************/
        use_local_tetris_2018 = true
        tetris_2018_project_dir = '/Volumes/document/AndroidStudioCode/Tetris-2018'
        tetris_2018_project_name = 'Tetris-2018'
        tetris_2018_project_content_modules = [
                'test_code',
                'tom_log',
                'GenerateRevenue',
                'android-crop',
                'tom_theme',
                'lib_beaker',
                'tetris_container',
                'example_beaker',
                'tetris',
        ]

        include_local_lib_pick_color = {
            includeLocalProjectAndModules(
                    use_local_lib_pick_color,
                    lib_pick_color_project_dir,
                    lib_pick_color_project_name,
                    lib_pick_color_project_content_modules)
        }
        include_local_tetris_2018 = {
            includeLocalProjectAndModules(
                    use_local_tetris_2018,
                    tetris_2018_project_dir,
                    tetris_2018_project_name,
                    tetris_2018_project_content_modules)
        }
    }


    /* ③ 此 闭包 定义的函数多预期出现于 module.build.gradle.dependence 代码块*/
    ext {
        dependentLibPickColor = { Project project, String versionCodeStr = "+" ->
            dependentModule(
                    use_local_lib_pick_color,
                    lib_pick_color_project_name,
                    lib_pick_color_module_lib_pick_color,
                    lib_pick_color_module_lib_pick_color,
                    "io.github.tomgarden",
                    versionCodeStr,
                    project)
        }
    }

}
```
