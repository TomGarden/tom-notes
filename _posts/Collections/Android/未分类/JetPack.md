Jetpack  : Jetpack 是一个由多个库组成的套件，可帮助开发者遵循最佳实践、减少样板代码并编写可在各种 Android 版本和设备中一致运行的代码，让开发者可将精力集中于真正重要的编码工作。

Appcompat : 当新版本的 android 发布时，谷歌将不得不支持旧版本的 android。所以 AppCompat 是一组支持库，可用于使使用新版本开发的应用程序与旧版本一起使用。

AndroidX : 命名空间androidx包含Android Jetpack库。与支持库一样，androidx命名空间中的库与 Android 平台分开提供，并提供跨 Android 版本的向后兼容性。



## 0x01、 [Jetpack Compose](https://developer.android.com/jetpack/compose?hl=zh-cn)


[官方文档](https://developer.android.com/jetpack/compose/documentation?hl=zh-cn)

Google 声称 : Jetpack Compose 是用于构建原生 Android 界面的新工具包。它使用更少的代码、强大的工具和直观的 Kotlin API，可以帮助您简化并加快 Android 界面开发。

Jetpack 仅用于构建静态页面 , 还是比较容易理解的 , 方向容器 , UI 控件们 , 罗列就可以完成 . [详情参照文档](https://developer.android.com/jetpack/compose/tutorial?hl=zh-cn)

Jetpack Compose 界面开发涉及到的 UI 状态变化需要理解的一点是 : 可组合函数可以使用 remember API 将对象存储在内存中。系统会在初始**组合**期间将由 remember 计算的值存储在组合中，并在**重组**期间返回存储的值。remember 既可用于存储可变对象，又可用于存储不可变对象。
- 这里相当于默认将 View 和 Model 完成了绑定 , 也就是我们过去所说的 ViewModel . ViewModel 绑定的情况下 , Model 的更新会由 Jetpack Compose 框架触发 View 的更新(也就是重组)
- 这种 Model 更新触发 View 更新的动作如果在 命令式 UI 就需要我们自行调用 `View.setSomeField(...)` . 




[Compose 编程思想](https://developer.android.com/jetpack/compose/mental-model?hl=zh-cn)  






## 0x02、 理解 : 声明式UI / 命令式UI 

- 命令式 UI , 开发者持有一个 View 对象
  - 这个对象一般声明于 XML 中 , 当然也可以直接用 Java 代码声明
  - 对这个对象的成员赋值 `view.setXxx` 进而促进 View 更新的发生
- 声明式 UI , 开发者不再长久持有 View 对象
  - 通过使用 Kotlin 描述视图样式 , 在描述的过程中完成 View 与 Model 的绑定 ; 这里的视图样式是若干 View 的组合 ; 当某个 View 的变化的时候我们称为重组 . 
  - 后续 当 Mode 更新的时候 由 框架完成 View 的更新 , 这里的更新叫做重组

## 0x03、 Jetpack Compose 都有那些组合可用 

[androidx.compose.material](https://developer.android.com/reference/kotlin/androidx/compose/material/package-summary?hl=en)
[androidx.compose.material3](https://developer.android.com/reference/kotlin/androidx/compose/material3/package-summary?hl=en)


## 需要注意

在使用 material3 api 的时候还会提示实验性 api 的告示 . 

```
//This material API is experimental and is likely to change or to be removed in the future.

1. 可以增加 ExperimentalMaterial3Api 注解消除提示
2. 或者可以尝试 : https://stackoverflow.com/a/73697479/7707781
```

## 参考内容
- [Google 官方 Jetpack 文档](https://developer.android.com/jetpack/compose/mental-model?hl=zh-cn)
- [geeksforgeeks Jetpack 讲解](https://www.geeksforgeeks.org/android-tutorial/)


