## 0x01、 设计目标
从功能和性能上覆盖 app-theme-engine 和 Colorful 的优点：
1. 三方库的形式出现
2. 主题的设定方式可选(限制自定义和完全自定义)
    - 如果使用提供若干套主题供选择(于设备能耗无碍)
    - 同时提供自行设置主题的入口

从自身的角度触发，我们需要完成的工作
-   从始至终保留设计思路、技术细节、不同细节设计和选择的优劣评定
    - 对自己来说方便自己后续使用
    - 如果开源的话对别人来说是莫大的方便，尤其是如果有人想学习

从功能细节来看我们当前提供的功能为
1. 主题选择——选择系统豫置的主题模板
2. 自定义模板
    - 选择玩家上传的模板
        - 评价模板
        - 赞
        - 踩
        - 评论
    - 自定义模板
        - 应用
        - 上传

从 Activity 的角度来讲最好可扩展，我们的 View 必须可扩展。

## 0x02、 技术思路
### 2.1、 寻找相同的代码注入点
我们要将自己的框架应用到应用的初始化过程
1. app-theme-engine 是通过设置 LayoutInflater 的 Factory 来实现的
2. Colorful 是通过自定义 Application 来实现的
3. 我们能fount找到同一个代码注入点，注入我们的初始化代码？

尝试思路
1. 将 application 中要进行的初始化动作移动到 LayoutInflater 的设定处

如果失败
- 如果寻找共同注入点这件事失败，并不是一件无法接受的事情，但是这会让这个包的使用难度增加。

## 0x03、 配置信息模板
```xml
<map>
    <string name="theme_type" value="resource|manual" />
    <!--reaource--> 
    <boolean name="translucent" value="true" />
    <string name="primary_theme">GREEN</string>
    <boolean name="dark_theme" value="false" />
    <string name="accent_theme">GREEN</string>
    <!--manual-->

</map>
```

### 3.1、 关于主题的相关系统配置资料
我们要设置主题就要细致的知道通过配置什么字段或者属性可以达到如何的效果，我们需要一个映射表：
- https://developer.android.com/reference/android/R.styleable#Theme

值的注意的是，在这里个人常用的就是如下几个。
但是在我对自己 library 的设计还是希望它有足够的能力来应对“这里的数据可能会发生变化”这件事。

|Attribute|Description|
|-|-|
|...|...|
|android:colorPrimary	  |  The primary branding color for the app.          |   
|android:colorPrimaryDark |	    Dark variant of the primary branding color.   |
|android:colorAccent	  |  Bright complement to the primary branding color. |
|...|...|

#### 3.1.1、 一个事实
```xml
<style name="primary0">
    <item name="android:colorPrimary" tools:targetApi="lollipop">@color/md_red_500</item>
    <item name="android:colorPrimaryDark" tools:targetApi="lollipop">@color/md_red_700</item>
    <item name="colorPrimary">@color/md_red_500</item>
    <item name="colorPrimaryDark">@color/md_red_700</item>
</style>
```

`android:colorPrimary` 和 `colorPrimary` 的区别与差异只能根据现象和这两个字段来理解，并并没能在 Google doc 中找到有关于此的描述。
根据现象我们推测 
1. 在 Android API level ≥ 21 的时候 `android:colorPrimary` 起作用
2. 在 Android API level < 21 的时候 `colorPrimary` 起作用
3. 这二者在对应的版本范围内作用所造成的结果相同(作用相同)

### 3.2、 从资源文件中指定自定义主题相关 API
```java
//https://developer.android.com/reference/android/content/res/Resources.Theme.html#applyStyle(int,boolean)
public void applyStyle (int resId, //我们在资源文件中定义的主题的 ID 
                boolean force)
/*
int resId : 我们在资源文件中定义的主题的 ID 
boolean force : 
    false :  当前 theme object 中未定义的属性在 resId 中有定义，将 resId 中的数据复制到 theme object。
             当前 theme Object 中已经定义的属性 resId 中有定义，原值不变。
             当前 theme Object 中已经定义的属性 resId 中无定义，原值不变。
    true  :  当前 theme object 中未定义的属性在 resId 中有定义，将 resId 中的数据复制到 theme object。
             当前 theme Object 中已经定义的属性 resId 中有定义，用 resId 中的数据覆盖到 theme object。
             当前 theme Object 中已经定义的属性 resId 中无定义，原值不变。
*/
```






## 0x04、 功能细节
1. colorPrimary 
2. colorAccent
3. 文字颜色
    - 文字风格

4. 按钮
    - 按钮图标本身
    - 图标颜色
        - 按下-抬起
5. 俄罗斯方块贴图
6. 俄罗斯方块烧杯背景

要完成上述几个功能，我们首要考虑的是 app 和 library 之间的交互数据

主题设置功能数据提交到 library 
- colorPrimary
- colorAccent
- 文字颜色
    - 文字风格

主题功能选择数据提交到 library 
- 主要提交服务器数据


关于颜色设置 colorPrimary 与 colorPrimaryDark 在 style 文件中是相关的。
有关于此，如果用户选定 style 中的颜色和自己设置颜色这两件事我们分开就好了。






## Reference
1.  https://developer.android.com/guide/topics/ui/look-and-feel/themes
2.  https://developer.android.com/studio/write/tool-attributes

## Way
- 定义一套模板并用代码应用它-OVER
    - 已完成正在填补相关细节知识
- 我们先不做应用的功能细节，先根据功能设定 library 需要具备的能力，完成能力接口(也就是说我们的 library )
    - 颜色的值存储
        - 如果是本地资源可以存储 ID，也可以将 ID 转换为字符串
        - 如果是自定义数据是否也可以存储颜色字符串，是否可以是 int 颜色呢
            - 可行，我们最终决定使用 int 表示颜色值或者 ID 
    - 颜色数据的存储和取回我们都已经做完了
        - 下一步就是应用这些数据
    - 至此我们关于主题的应用框架有把握的都已经搭建完成了
- 下一步搭建 UI
    - 主题定制 UI 
        - 要完成主题定制 UI 首先需要对之前的自定义 view 进行一系列的改装，让我们的自定义 view 更符合作为一个 view 的使用习惯，少一些特殊性。
            - 要完成背景格子的数目计算需要先计算背景格子的边长
            - 我们至少实现三种主题才算完成了对这个自定义控件的绘制
                - 包括当前已经绘制的主题还需要一个有间隔的主题
                - 需要绘制一个无间隔的主题
                - 最好找到两种类型之间的共性
                - 在做另外两个主题之前我们首先应该把不对称这件事解决一下
            - view 改装基本，是时候讨论使用哪一种 UI 来完成主题内容的设定了。
                - 就是用 dialog 吧
                    - 首先来分辨系统提供的 dialog 和 afollestad 所提供内容的差异吧
    - Library UI 已搭建完成
- 现在我们需要先搞清楚自定义资源如何成为主题数据，然后在考虑针对每个 View 的数据的修正。
    - 不论是通过 Android 源码还是通过 app-theme-engine 源码都可以得知自定义主题颜色设置可以通过设置 DecorView 或者通过 PhoneWindow 间接设置 DecorView 来进行设置。
    - 接下来看一下当新的颜色被设置之后如何在不重启应用的情况下为所有的UI应用新变化。
    - 现在可知的方法有三个
        1. 在每个 Activity 中备份 Theme 配置数据，恰当的时机进行赋值或对比从而决定是否重启
        2. 创建容器管理所有 Activity 从而集中重启
        3. 通过时间和标示符来标识是否需要重启(和 1 异曲同工)
    - 下一步完成针对 ImageView 的主题内容定制，并应用之。在这之后继续搭建游戏 UI 细节。