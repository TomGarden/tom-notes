
## 0x00、 手势

我们假定的运行环境为：

layout.xml
```xml
<ViewGroup ...>
    <ChildView .../>
</ViewGroup>
```

### 0.1、 涉及到的方法
- Activity.dispatchTouchEvent(MotionEvent ev)
- Activity.onTouchEvent(MotionEvent event)

- ViewGroup.dispatchTouchEvent(MotionEvent ev)
- ViewGroup.onInterceptTouchEvent(MotionEvent ev)
- ViewGroup.onTouchEvent(MotionEvent event)

- View.dispatchTouchEvent
- View.onTouchEvent

### 0.2、 触摸事件处理
- GestureDetector
- ScaleGestureDetector

### 0x03、 View 响应触摸事件
view.setX(float x);
-   以像素为单位设置当前视图的可视 X 位置。
    这相当于将 translationX 属性，设置为传入值与 left 属性的差值。

view.setTranslationX(float translationX);
-   设置 view 相对于 left 边界的水平位置。
    后面没读明白。

view.setScrollX(int value);//滚动
-   设置你的 view 的水平滚动位置。
    这将造成对 `onScrollChanged(int, int, int, int)` 方法的调用，我们的 view 将会被 invalidate(作废)。
-   onScrollChanged(int, int, int, int)
    -   通常用于响应 view 内部滚动事件。
        通常是 `scrollBy(int, int)` 或者 `scrollTo(int, int)` 调用的结果。

view.setScaleX(float scaleX);//缩放
-   以 x 为枢轴点对 view 进行缩放，未缩放之前的 view 的 width 为缩放分母。
    如果 scaleX = 1 意味着不进行缩放。

view.setRotationX();//旋转
-   设置 view 以水平枢轴点旋转的角度。
    以从上往下看 x 轴的视角(looking down the x axis)，将视图按顺时针方向旋转。
    当旋转大 view 的时候，推荐调整相机的距离。
    了解更多请参考 `setCameraDistance(float)` 。

view.setPivotX(float pivotX);
-   设置 x 位置，使 view 围绕其进行旋转和缩放。
    默认的，枢轴点是对象的中心。
    设置这个属性将禁止这种行为，并且造成 view 使用指定的 pivotX 和 pivotY 值。

## 0x01、 触摸事件分发






## 0x**、 有关于事件分发尚有探讨的余地
Activity  dispatch 的事件还是很多的：

`dispatchGenericMotionEvent(MotionEvent ev)`
- Called to process generic motion events.

`dispatchKeyEvent(KeyEvent event)`
- Called to process key events.

`dispatchKeyShortcutEvent(KeyEvent event)`
- Called to process a key shortcut event.

`dispatchPopulateAccessibilityEvent(AccessibilityEvent event)`
- Called to process population of AccessibilityEvents.

`dispatchTouchEvent(MotionEvent ev)`
- Called to process touch screen events.

`dispatchTrackballEvent(MotionEvent ev)`
- Called to process trackball events.

## Reference
1. Touch & input —— https://developer.android.com/guide/input/
2. https://blog.csdn.net/carson_ho/article/details/54136311