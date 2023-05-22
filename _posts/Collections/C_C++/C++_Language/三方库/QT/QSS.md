
## 0. 预备信息
qss 支持 CSS2 中定义的所有选择器 , QSS 介绍 中明确说了 Qt Style Sheets 遵循CSS2 规范 . 
- 为了确定规则的特殊性，Qt Style Sheets 遵循CSS2 规范
- 样式表级联是一个复杂的话题。有关详细信息，请参阅CSS2 规范。请注意，Qt 目前没有实现!important.


- QSS 介绍 : https://doc.qt.io/qt-6/stylesheet-syntax.html ; 每一个小节都有更详细的内容介绍链接可以探寻
- QSS Box Model : https://doc.qt.io/qt-6/stylesheet-customizing.html
- qss 规格 : https://doc.qt.io/qt-6/stylesheet-syntax.html#sub-controls
- qss 语法 : https://doc.qt.io/qt-6/stylesheet-reference.html#list-of-sub-controls


QT 皮肤库 , 相关检索
1. https://github.com/satchelwu/QSS-Skin-Builder
2. https://github.com/hustlei/QssStylesheetEditor
3. 软件支持加载 qss 文件 , 启动后 通过 qss 文件指定 ui 样式 : https://github.com/gg314/texstudio-dark-theme
4. https://www.cnblogs.com/feiyangqingyun/p/15958057.html
5. https://blog.csdn.net/weixin_40774605/article/details/106242671
    - https://github.com/GTRONICK/QSS
6. https://blog.51cto.com/u_15127566/4684258
7. [**需要重点关注下**](https://bcgsoft.com/products.htm)
8. https://blog.csdn.net/danshiming/article/details/125018265?spm=1001.2014.3001.5501
9. QT官方文档关于风格的描述 , 注意深入段落链接探究  https://doc.qt.io/qt-6/qtwidgets-index.html#styles



Qt Widget 子集 : https://github.com/Qt-Widgets 
1. qss 的一个还不错的方向 : https://github.com/GTRONICK/QSS
2. qstyle 的定制库 : https://github.com/FedoraQt/adwaita-qt
3. 这个好像是 qss 的需要跟进 : https://github.com/githubuser0xFFFF/Qt-Advanced-Stylesheets
4. GNU 风格的样式 : https://github.com/Qt-Widgets/adwaita-qt-style-qstyle
5. 如果有自己实现一套 qss 样式表的需求 , 这个工具可能有用 : https://github.com/Qt-Widgets/Qss-Stylesheet-Editor



## 1. 对于 皮肤库 的思考
创建一个库 , 这个库支持对于 不同 控件的 qss 属性的 访问/定义/应用 ; 从而达到控制 qt 控件样式的效果 .

如果不创建这个库, 我们通常要如何控制 qt 控件样式呢?
1. 在每个控件上写 qss 代码
2. 在根控件上写 qss 代码
3. 单独写 qss 代码文件 , 在逻辑需要的地方加载并应用


## 2. Android 开发平台 与 Qt 开发平台 在 页面开发情景下的对比
我了解的 Android 的开发过程中 , UI 文件的编写也是通过 xml 文件编写的(手动写) . 
- Android 提供的开发套件支持根据 xml 文件实时展示 ui 效果 . 
- Qt Ui 开发套件 没有 Android 开发套件效率高 , 比如调整控件风格需要单独开窗口 , 并且没有足够细致的代码提示和错误提示 . 
  - 但是 qt design 可以相对实时的预览自己的 qss 是否正确设置了是否正常生效了 . 

## 3. 现在我们做一个小结
1. 如果实现一个 qss 库 , 预计可以做到 , 使用代码设置 qss 风格 , qss 支持的属性尽可能多的用 代码抽象出来 , 从而做到可以用代码设置控件风格 . 
2. 做到 `-3.1-` 有什么缺点呢 ?
   - 放弃了 qt 套件提供的实时预览的能力 ; 无疑 , 这降低了开发效率 , 要达到预期的 ui 效果需要反复的编译查看 . 
3. 做到 `-3.1-` 有什么伪优点呢 ? 
   - 看起来是 `widget.` c++ 语法提示有哪些可以设置的属性 , 比较方便 ; 实际上就这个便利性而言 , 了解这些属性的开发者也可以通过 qss 快捷的实现这个效果 , 不了解这些属性的开发者 , 又没有得到实时预览的能力 , 本身而言应该会降低初学者的效率 , 提高他们的学习成本 . 
4. 没有找到合适的角度观察到有说服力的优点 . 


## 4. 再说回关于软件皮肤库的目标 
1. 我们不太可能所有的软件都用同一套皮肤
2. 如果我们对于同一套软件使用多套皮肤 , 写多个 qss 文件即可
3. 如果多个软件都是用同一套皮肤 , 多个软件都使用同一个 qss 即可


## 5. 在我们了解上述内容的基础上

以 PushButton 为例做假设 . 两步走
1. 使 PushButton 支持 c++ 代码 设置 qss 种种属性的能力
2. 对于惯用的风格做一个封装 , 多个风格就做多个封装 . 
3. 编写代码的时候直接使用这种封装好的 button 代码 . 在一定程度上可以提高效率 . 
    这个效率提高的前提是 , 我们对整套 UI 都有固定风格的定义 .  
    对于这种固定风格的 UI 的使用 , 也几乎不能避免要结合 qss 一起使用 , 因为在不同的页面控件间的间距往往不同 . 
    也或者字体大小等等的细节估计也会有不同 . 


## 6. 再确认下目的和目前理解

我们做的目的有几个 ?
1. 相对较快速的实现对控件的风格定义 , 起码要比直接写 qss 快才算快速 

目前可以想到的快捷的方式就是实时编辑 , 实时查看效果的 ui 开发方式 . 

我能理解这种提高效率的诉求 , 但是就目前来看 , 我比较悲观 ; 
如果 qt 团队的开发环境能支持 实时编辑 ui 的 qss 文件实时预览控件效果 , 这是最好的解决方案 . 

在 qt 支持这些之前 , 我认为 qt 开发者花些时间学习 qss 语法是很有必要的 . 


## 7. 今天试读了 QStyle 相关内容
1. https://doc.qt.io/qt-6/qtwidgets-index.html#styles 段落内容以及段落内的链接内容
   - 有人读了上面的链接结合个人理解 , 大面积翻译写的博客 : https://blog.csdn.net/danshiming/article/details/125018265?spm=1001.2014.3001.5501 

看起来这是自定义控件的道路 , 我们按照自己对控件外观的需求定制一套自己喜欢的外观 . 

我想聊一下我对于好看(炫酷)这件事的认识 ; 
1. 我们在打游戏的时候都知道有皮肤这么个东西 , 它一般需要用货币购买 ; 
   人们常说 , 你看我的新皮肤多好看 ; 其实这里说的好看并不一定是真正意义上的美 , 更有可能是新鲜 . 
   这个语境下的好看是说 : 你那个默认皮肤满大街都是 , 天天看 , 审美疲劳了 , 看我买了个新的换了个口味 , 咋样不错吧 . 
2. 走上自定义控件这条路 , 我理解这是一个相似的事情 . 
   我们说 qt 默认的风格丑 , 可能说的也不是丑 , 而是天天见审美疲劳了 . 
   如果上述是成立的 , 那么我们的需求定义一套自成风格自成体系的 qt 控件 . 
   当然了这套控件应该也是符合大众审美的 , 这才能有达到效果 : 别人一看 , 感觉新鲜 , 感觉眼前一亮 . 
3. 所以 如果能在一个 平台使用其他平台 的风格 , 看起来也就没有那么单调了 . 
    ```c++
    QApplication::setStyle("macos"); /* 该字符串必须是QStyleFactory::keys () 之一，通常是“windows”、“windowsvista”、 “fusion”或“macos”之一。样式名称不区分大小写。 */
    ```
   - windows 使用平台 可以切换的平台效果有三个 “windows”、“windowsvista”、 “fusion” ; 说不上有多大差异 , fusion 给表格表头默认设置了背景
   - mac 平台所有的参数都可以观察到变化 . 

## 8. 再考虑目的

我们的目的是要快速换肤 , 并不是说要开发者在开发过程中有多高效的开发 . 虽然它确实提高了效率 . 

如果开发者可以不用关心 UI 效果 , 只做最原始的 UI , 然后快速应用 定制好的 UI 样式 , 可能是一个比较好的解法 . 
可能有局限性 , 某些不可预料的细节估计还是要开发者去关心和调整 , 这个 Ui 样式也需要持续打磨 . 

看到如下项目后我有了上面的想法
1. https://github.com/githubuser0xFFFF/Qt-Advanced-Stylesheets
2. https://github.com/GTRONICK/QSS
3. 这个工具可能用得着(不过好像没那么好用) : https://github.com/Qt-Widgets/Qss-Stylesheet-Editor

## 9. 重新考虑目的

针对某一个控件的使用 , 希望能效率比直接使用 qss 要高些 . 







