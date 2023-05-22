## 0x00、 目标
1. 从 Activity 的启动流程入手
2. 知道明晰了 View 的加载流程并适当的完成截断(用于实现业务需求)为止

## 0x01、 起点
起点：Android 系统源代码情景分析[罗升阳 著]

### 1.1、 Activity 启动起点

Activity 的启动是从 `\android-4.4.4_r1\frameworks\base\core\java\android\app\ActivityThread.java` 文件的 `performLaunchActivity` 开始的
1. 类实例化
2. Activity 中一众重要的成员是紧随初始化动作完成初始化的
3. 生命周期方法 onCreate 执行

关于 theme 在 oncreate 之前就已经设置了

## 0x02、 有关于 View
1. View 的加载流程 `onMeasure onLayout onDraw` 等更多的系统调用实可探究，有机会搞一搞。

## 0x0* 文档输出位置
1. [Activity加载流程(非详细)](https://github.com/TomGarden/Tetris-2018/blob/master/doc/xmind/绘图2.eddx)
    - [由上启发：Activity 生命值周期](https://github.com/TomGarden/Tetris-2018/blob/master/doc/xmind/绘图1.vsdx)