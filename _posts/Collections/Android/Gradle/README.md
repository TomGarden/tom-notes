官方文档列表:

1. [Android 插件 DSL 参考文档](https://google.github.io/android-gradle-dsl/current/)
2. [Gradle DSL 参考文档](https://docs.gradle.org/current/dsl/)





网络文章:

1. 关于 Gradle 的使用的不错的文章: http://wuxiaolong.me/2016/03/31/gradle4android2/


关于通过 gradle 查看依赖树
0. [领域特定语言（英语：Domain-specific language，缩写：DSL）](https://zh.wikipedia.org/wiki/领域特定语言)
1. [Android 查看项目依赖树的四种方式](https://blog.csdn.net/songjianzaina/article/details/98175098)
    - `./gradlew :moduleName自行替换:build --scan`
    - Publishing a build scan to scans.gradle.com requires accepting the Terms of Service defined at https://scans.gradle.com/terms-of-service. Do you accept these terms? [yes, no]


[什么是`元编程`](https://zh.wikipedia.org/wiki/元编程)
- 一个不错的解释 : https://stackoverflow.com/a/42220709/7707781
- 我们的理解 : 我们将 `通过代码编写代码` 这件事称为 `元编程`
    - 通过 Java 代码 编写 Java 代码 我们称为 反射 . 
    - C++ 泛型是元编程
    - Java 代码输出 C++ 代码文本 , 也符合元编程的定义 . 


[什么是闭包](https://developer.mozilla.org/zh-CN/docs/Web/JavaScript/Closures)
- 闭包（closure）是一个函数以及其捆绑的周边环境状态（lexical environment，词法环境）



---- 


Gradle 是一种开源构建自动化工具 , Android 程序可以用它构建 . 
Gradle 脚本 使用 Groovy 或者 Kotlin DSL 书写 . 

gradle 脚本示例
```gradle
plugins {
    id 'com.android.application' version '8.0.1' apply false
    id 'com.android.library' version '8.0.1' apply false
    id 'org.jetbrains.kotlin.android' version '1.8.0' apply false
}
```

