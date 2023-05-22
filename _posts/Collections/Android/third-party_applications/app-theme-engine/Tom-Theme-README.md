## 设置默认 Theme
1. 设置 Manifest，[原因](https://developer.android.com/training/appbar/setting-up)
    ```xml
    <application
    android:theme="@style/Theme.AppCompat.Light.NoActionBar"
    />
    ```
2. 默认 Theme 可以使用 style 继承上述 theme 进行设置。
3. 默认 Theme 也可是在 java 代码中进行设置。
    ```java
            TomTheme.init(this)
                .pushAccent(R.color.md_red_500)
                .pushPrimary(R.color.md_blue_500)
                .pushPrimaryDark(R.color.md_blue_800);
                //.pushDone() ，如果调用本方法会将上述设置持久化。
    ```