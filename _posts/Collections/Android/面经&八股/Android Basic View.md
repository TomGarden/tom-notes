
以前我是如此熟悉熟悉这些内容
1. https://github.com/TomGarden/Translate/blob/master/Android_Dev/Creating%20a%20View%20Class.md
2. https://github.com/TomGarden/Translate/blob/master/Android_Dev/Custom%20View%20Components.md
3. https://github.com/TomGarden/Tetris/releases/tag/1.5

现在要再熟悉一次 , 这里有个[翻译过的中文文档](https://developer.android.com/guide/topics/ui/custom-components?hl=zh-cn)

- onMesure()  : 与自定义控件尺寸相关的回调 , 提供控件尺寸
- onLayout()  : 在此视图应为其所有子级分配大小和位置时调用。
- onDraw()    : 在话不上绘制控件样式


[手势相关的内容, 也是曾经熟悉](https://github.com/TomGarden/Translate/tree/master/Android_Dev/GUIDES/Core_topics_%E6%A0%B8%E5%BF%83%E8%AF%9D%E9%A2%98/Touch%20%26%20input/Using%20touch%20gestures)
- [触控事件分发](https://github.com/TomGarden/tom-notes/blob/master/_posts/Collections/Android/point4dev/%E5%85%B3%E4%BA%8E%E6%89%8B%E5%8A%BF(Gesture)/2019-01-14-gesture.1.md)

- Activity.dispatchTouchEvent(MotionEvent ev)
- Activity.onTouchEvent(MotionEvent event)
- ViewGroup.dispatchTouchEvent(MotionEvent ev)
- ViewGroup.onInterceptTouchEvent(MotionEvent ev)
- ViewGroup.onTouchEvent(MotionEvent event)
- View.dispatchTouchEvent
- View.onTouchEvent
