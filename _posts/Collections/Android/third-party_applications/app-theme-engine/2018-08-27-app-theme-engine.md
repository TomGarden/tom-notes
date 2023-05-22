---
layout: post
title:  null
date:   2018-09-07 15:04:51 +0800
categories: jekyll update
author: Tom
---

-----------------------------
__目录__
- jekyll 的 kmarkdown 负责解析
{:toc}

-----------------------------
<br>

## 0x00、 GitHub 源码阅读 & 思路理解/学习
源码：[app-theme-engine](https://github.com/garretyoder/app-theme-engine)
- 本项目涉及作者的其他的项目：
    1. [material-dialogs](https://github.com/afollestad/material-dialogs)
    2. [Colorful](https://github.com/garretyoder/Colorful)


## 0x01、 项目概述和进行思路

之所以要研究这个项目其原因是它对主题设置的扩展更为灵活。如果不做这种扩展我们只能使用配置文件中已经配置好的主题，在应用发布后不具备足够的灵活性。
- 从外部文件保存 UI 界面中的配置信息
    - 这取代了项目中的(XML)配置文件，从而给开发者带来的更高的灵活性。

### 1.1、 2018-08-27 11:15:23
#### 1.1.1、 当前理解
Activity 本身的创建流程中，通过即通过配置信息来选择性完成 UI 的绘制。
在这个绘制过程中完成了对主题的设定。
所以主题设置部分的代码做的事情是：
1. 修改配置信息
2. 重启 Activity

#### 1.1.2、 当前路线
项目作者应该是在了解 Activity 的正向加载流程的前提下结合自己的需求恰到好处的实现对了 Theme 的灵活设定。
- 针对这一点，我们如果完全不管正向流程而单纯模仿作者的代码也有可能能实现自身的需求。但是这种不求甚解的做法从长期来看对一个技术人员是极其不利的。
- 所以我们需要将正向流程捋顺一下，从而将这一需求从自身角度出发来完成(当然这种情况下对此作者的代码部分借鉴可以加快我们的进程)。
- 另外，我们将这一过程详细记录，也能极大满足自己的虚(成)荣(就)心(感)。
- 如果我们在一周内将这件事情昨晚还能获得一个家庭打印机的奖励。

### 1.2、 [2018-08-28 17:36:28]
我们尝试读了 app-theme-engine 源码，仍旧不得要领，下一步我们尝试不在理会这部分源码。
从当前的积淀单纯从 Android 布局加载部分的源码入手尝试进行理解。

1. 在加载 XML 文件的时候存在几个 Factory 如果这几个 Factory 为 null 就是使用默认的加载方式，我们只需要自定义 Factory 即可完成对 View 加载的控制。
2. 关于 View 加载， 通过 LayoutInflater 加载 View 是通过反射调用双参数的构造方法，我们希望替换主题，或许可以更改这个双参数构造方法的第二个参数(在其中加入我们设定的属性)
3. 关于 View 加载，我们暂时还只能加载单纯的布局，但是窗口的主题切换暂时还没涉及。
4. 至此我们回归 app-theme-engine
    - 至此我们了解了 app-theme-engine 设置主题的方式
    - 与我们在第 2 步中的描述相似，只是没有碰第二个参数，而是在初始化 View 的时候直接设置了 View 的各种颜色属性
    - 当然了我们还没有实践不能确定我们臆想的实现方式是否可行。

关于 app-theme-enging 的实现方式到现在我们已经完全可以模仿 9 成了，如果真的要做，我们必然还会碰到这样或者那样的问题。暂时我们的主要任务还不是动手，而是看看这个开源组件的作者关于主题切换功能的最新的项目 [Colorful](https://github.com/garretyoder/Colorful)

Colorful 的使用和应用确实要简洁许多，但是我们一时间还没有能用起来，我们在尝试一次，如果使用成功了就进一步探究其原理，如果尝试失败了我们就回到 app-theme-engine 按我们的理解完成我们自己的 library 。

## 0x02、 读书郎 ☞ package.class.method/field
- android.support.v4.view.LayoutInflaterCompat.setFactory(...)
- android.view.LayoutInflater
- android.support.v4.view.LayoutInflaterFactory
- android.support.v7.app.AppCompatDelegate
- [android.support.v4.view.LayoutInflaterCompat](https://developer.android.com/reference/android/support/v4/view/LayoutInflaterCompat#setfactory)
    - 用于访问 LayoutInflater 中功能的助手。

## 0x03、 再次读取 Kotlin 源码
Colorful 并没有 app-theme-enging 的能力，他们的所谓 custom(自定义) 是有区别的：
- Colorful 的自定义是需要开发者提供足够的颜色资源的
    - 其局限性就在于此，自定义的范围限于所提供的资源的范围和数量
- app-theme-engine 却无需豫置任何资源，甚至可以由终端用户直接提供不同类型的颜色通过我们的程序最终改变 app 的 theme
    - 其局限性正如 doc 所言，[能耗高](https://developer.android.com/reference/android/view/LayoutInflater)

我们的需求需要 app-theme-engine 来满足，但是 Colorful 也非没有可取之处
- 入手的角度 Application
- 编程语言 Kotiln

## 0x04、 小插曲
1. Colorful 已经实现的是切换整个应用的主题，注意这个主题为 resources 中的确定的资源
    - 我们希望的不仅如此，还希望能设置任意的资源，所以我们要做 TomTheme
2. app-theme-engine 已经实现的是针对 view 的截断并修改其配置信息，注意这些配置信息可以是任意的数据
    - 我们需要知道，针对 View 截断和修改配置数据固然可以达到修改 Theme 的作用
    - 但是我们想要的并非如此，我们希望我们指定的控件按照自己的意图展现外观，这一点虽然也可以做到，但是这和切换 Theme 是不同的。
        - 从原理上讲，应该相同，我们查看源代码验证这一点。
3. 不知道单纯修改 Theme style 的配置信息能否达到修改各个控件的外观(要做到这，首先需要 Android 本身就具备这样的条理性才行。)
    - 本来我们要做的是从 ImageView 实现与 app-theme-engine 类似的功能(重造轮子)
        - app-theme-engint 的实现思路已经复习好了
    - 现在我们为了观察普通 View 和 Theme 之间的关联要查看 ImageView 自身的实现和绘制过程
        - 现在详究 ImageView 在一般布局中的绘制过程(假设 layout 文件中的根 view 为 LayoutInflater)
    - 这二者不冲突，我们干脆直接把它俩都做了
    - 现在有结论了，View 的加载可以和 Theme 相关，但是这些细节完全取决于 View 自身。
4. 既然有 3 的事实存在，禁不住问一个问题： **app-theme-engine(或者说我们的 TomTheme) 到底是什么，做什么，怎么做？**
    - app-theme-engine 所做的事情是为 LayoutInflater 设置 `Factory、Factory2` ，并且每个 View 的 tag 属性绑定信息。自己的 Factory 会通过 tag 所绑定的信息按照约定(或者按照编码者的设计)完成对 View 外观的修正。
        - 这是针对一般 View 的动作
        - 我们忽略了针对 Theme 的动作，我们需要探究一下这一点
    - TomTheme 想做的是什么？
        1. 想要扩展 APP 主题设置的灵活性，令其所能设置的外观不限于 resources 的范围。
            - 那么我们通过自定义 Factory 能否实现上述意图呢？
                - 当然修改各个 View 使得结果看起来像改了 Theme 我们是可以做到的。但是这不是我们的首选方案
                    - 翻了下文档没有找到官方提供的数据修正接口
                    - 或许可以反射修改某些数据但好像需要找到这个可以修改的恰当的时机，不确定。

## 0x04、 相关文章
1. https://tomgarden.github.io/2018/09/07/Colorful.html
2. https://tomgarden.github.io/2018/09/04/doc-android.view.View.html
3. https://tomgarden.github.io/2018/08/27/doc.html

## 0x05 参考
1. ![2018-09-07-app_theme_engine_绘图1](/assets/Image/2018-09-07-app_theme_engine_绘图1.png)
    - [此图暂时位于此，修改或不通知](https://github.com/TomGarden/Tetris-2018/blob/master/doc/xmind/绘图1.vsdx)
2.  /TomGarden.github.io/_posts/Collections/Android/third-party_applications/app-theme-engine/activity-启动流程.md

