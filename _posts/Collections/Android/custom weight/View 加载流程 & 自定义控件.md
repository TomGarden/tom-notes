## 0x00、 有关于自定义控件
1. https://developer.android.com/guide/topics/ui/custom-components


## 0x01、 [Custom View Components](https://developer.android.com/guide/topics/ui/custom-components)

Android 基于基本的布局类 `View` 和 `ViewGroup` 为 UI 构建提供了复杂高效的组件。
首先，平台包含了丰富的 View 和 ViewGroup 的子类 —— 称之为控件和布局，你能分别使用它们来构建自己的 UI 。

一部分可用的控件：`Button`, `TextView`, `EditText`, `ListView`, `CheckBox`, `RadioButton`, `Gallery`, `Spinner`,还有一些专用控件：`AutoCompleteTextView`, `ImageSwitcher`, and `TextSwitcher` 。

可用的布局包括： `LinearLayout`, `FrameLayout`, `RelativeLayout` 等。
要查看更多布局请参阅 [Common Layout Object](https://developer.android.com/guide/topics/ui/layout-objects.html)

如果没有预定义的控件和布局能满足你的需求，你可以创建你自己的 View 子类。
如果你只需要对已存在的 widget 或者 layout 做微调，你可以简单的继承当前已存的类，并且覆写相关的方法。

创建你的 View 子类，你就能更精确的控制屏幕元素的外观和动作。
关于对 view 的控制，这里有几个例子，或许能给你带来灵感：
1.  你能创建一个完全自定义的 View 类型，例如，模仿电子控制设备，通过 2D 绘图完成的音量控制旋钮。
2.  你能结合一系列 View 组件，完成一个组合控件，或许可以制作一个 ComboBox(下拉列表框)(文本输入控件与列表弹窗的组合)，一个二级选择控件(包含左侧和右侧两个面板，每一个面板都展示一个列表，只是一侧展示的是另一侧的子列表)，或者其他什么东西。
3.  你能够重写 EditText 在屏幕上的显示方式([Notepad Tutorial](https://android.googlesource.com/platform/development/+/master/samples/NotePad)使用这种方式创建了效果不错的笔记页)。
4.  你能捕获其他的事件(例如屏幕事件)并按照自己的意图处理这些事件。

