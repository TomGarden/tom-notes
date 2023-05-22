
## 0x01、 Android 支持

在使用 Android SVG 的过程中发现当前 Android 对于 SVG 语法的支持并不广泛。
```
//https://developer.android.com/reference/android/support/graphics/drawable/VectorDrawableCompat
<path/>
<group/>
<clip-path/>
```

## 0x02、 SVG Editor
在线编辑器无法完成我对 SVG 图形细节的要求。
我也曾想过学习下 SVG 语法自己绘制。但是在我真正学会单纯使用 path 命令绘制一个图形之前我发现了 **全平台** 离线 SVG Editor [inkscape](inkscape.org)。这一工具也恰好完成了我的需求。

使用 Inkscape 绘制的图形直接保存为 svg.xml 格式，我们可以直接导入 Android Studio 

### 2.1、 相关的几个功能

1. 画布剪裁
    - 选中图形 -> Edit -> Resize Page to Selection
2.  默认绘制的图形可能使用了许多高级的 SVG 语法，这些语法可能不被 Android 支持。
    我们需要将所绘制的内容完全使用 Path 语法完成。
    - 选中目标图形 -> Path -> *** to path
3. 看看 Android 平台提供的 SVG 图形数据：
    ```xml
    <vector xmlns:android="http://schemas.android.com/apk/res/android"
        xmlns:aapt="http://schemas.android.com/aapt"
        android:width="24dp"
        android:height="24dp"
        android:viewportWidth="24"
        android:viewportHeight="24">
    </cector>
    ```
    于是我将自己绘制的图形的尺寸调整为了 24mm 正方形

### 2.2、 不足
没有模板，绘图皆续从头绘制，略显耗时。
- 针对这一点，从他出导入 SVG 进而调整能省力些。