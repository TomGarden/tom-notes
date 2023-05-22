0. 三方的 so 文件是否可以调试对用户的核心功能来说影响不大，我们关注用户核心代码区域内是否存在 native 方法，如果存在尝试调试。

1. (第 2 步 更便利)反编译 apk 查询 ` native ` 可以找到声明了 native 方法的类。
2. IDA 可以查看包含包名的方法名，从而可以确定 native 方法声明类。
3. 两边的方法名做一个对照可以确定 java 类对应的 so 文件。
4. 确定其中一个根据 Java 文件生成是 so 文件在哪里被加载了
    - System.loadLibrary
      - Ljava/lang/System;->loadLibrary(Ljava/lang/String;)V
    - System.load
      - Ljava/lang/System;->load(Ljava/lang/String;)V
5. 定位到的加载 so 文件的 java 类在何种操作的时候被调用。(确定一个 java 的调用线。)

__难点__： 定位到 so ；定位到 so 中的方法； 定位到对 native 方法的调用卡壳了。




## 参考
1. http://blog.csdn.net/u012858313/article/details/51065673
2. http://www.cnblogs.com/sevenyuan/p/4202759.html
