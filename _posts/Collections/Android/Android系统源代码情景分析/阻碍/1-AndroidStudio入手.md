## 一、 通过 Ctrl+leftMouse 的方式追踪方法调用卡在：
```java
throw new RuntimeException("Stub!");
```
- 如何从 AndroidStudio 追踪源码切换到 AOSP 继续追踪？
    - 就目前来说在 AndroidStudio 追丢了的类或者方法在 AOSP 中都有同名`类`或者`方法`只要搜索即可。
    - 按照这个思路来说困难就在于如何确定 SDK 和 AOSP 的映射关系(目标方法应该在什么目录下寻找)
        - 一个例子是这样的：
            - google 网页源码中定位到一个文件：
                - `android / platform / libcore / android-4.3_r3 / . / luni / src / main / java / libcore / io / Libcore.java`
            - 同文件在本地化之后的路径为：
                - `I:\AOSP\android-4.4.4_r1\libcore\ luni \ src \ main \ java \ libcore \ io`
            - 上述两个路径的相同点：
                - **`luni \ src \ main \ java \ libcore \ io`**
            - 如果实在 `http://androidxref.com` 查看的源代码，那事情就简单了
                - 只要网页查看的版本和本地的一致，网页上显示的路径即为本地的文件路径，一下就找到了。[^_^]
        - 所以我们的实践应该是：
            1. 定位到 `throw new RuntimeException("Stub!");` 所在类或者所在方法
            2. 根据该方法在 Google 网页源码找到文件，并查看其路径
            3. 根据文件路径确定本地同文件的位置
            4. 最后通过 SourceInsight 加载和查阅即可。


- android.jar 中的文件如何映射到 AOSP 中的源代码？
    - 暂不考虑


直接使用 SourceInsight 搜索那个我们没有看到源代码的类或者方法或许可行。
- 先针对整个源码工程发起检索，找到部分信息的时候针对该子目录发起检索
- 把可能包含目标内容的子目录重新建立工程，发起检索。
- 如果一个 import 的内容找不到不知道在哪里，直接拿去 google 吧，效果很好的。

如果 SourceInsight 不能完成代码跳转那和我们通过网页查看代码或者说通过编辑器(例如 VSCode)查看代码又有什么不同？
- 就是要让它跳转

尝试导入整个项目然后针对整个项目建立 symbole 索引失败(三次)可能是项目太大崩溃。
- 现在有两个方案
    - 导入整个项目只添加自己关注的包的 symbol
    - 只导入自己关注的包，并且设定其 symbol