## 0x00. 写在开始

Android 从 5.0 (api 21) 推出了按点击波纹效果 . 


```xml
<!--作为 background 的时候是 直角矩形 : drawable 底色 , color 波色-->
<ripple android:color="#00FF00">
    <item android:drawable="@color/purple_200" />
</ripple>

<!-- 作为 background 的时候是 shape 控制的范围 :shape.color 作为底色 , ripple.color 作为波纹 -->
<ripple android:color="#0F0">

    <item>
        <shape android:shape="rectangle">
            <corners android:radius="25dp" />
            <solid android:color="@color/purple_200" />
        </shape>
    </item>

</ripple>

<!--作为 background 的时候是 外接圆 : 无底 , 绿波-->
<ripple android:color="#0F0" />
```

**对于支持版本为 17~30 的 app:**
1. 在 drawable-21 文件夹中创建    one_ripple_bg.xml 文件其中可以使用 ripple 节点
2. 在 drawable    文件夹创建同名   one_ripple_bg.xml 文件, 其中可以使用 selector 节点
    

用法
```xml
    <TextView
        android:id="@+id/tvLogCat"
        android:text="logcat"
        android:background="@drawable/ripple_src"
        android:layout_width="match_parent"
        android:layout_height="match_parent"/>
```




## 0x01. 尚需详究的小细节

### 1.1. 系统默认的 ripple 颜色值探寻

`android:foreground="?android:selectableItemBackground"` : 如何查看这个系统提供的水波效果的水波颜色值?

### 1.2. `<adaptive-icon/>`
文件路径 : `/src/main/res/mipmap-anydpi-v26`
```xml
<adaptive-icon xmlns:android="http://schemas.android.com/apk/res/android">
    <background android:drawable="@drawable/ic_launcher_background" />
    <foreground android:drawable="@drawable/ic_launcher_foreground" />
</adaptive-icon>
```


## 0x0x. 引用
- [RippleDrawable](https://developer.android.com/reference/android/graphics/drawable/RippleDrawable.html)
- [rippleEffect_2.md](https://gist.github.com/vxhviet/ea52d1809643cb75ecd47dea854cf2d5)