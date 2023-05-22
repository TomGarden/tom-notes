







## 手动实现 Parcelable 遇到的问题

```kotlin
//写入动作
dest?.writeString(title)
dest?.writeString(negativeBtnStr)
dest?.writeString(positiveBtnStr)

//读取动作
title = parcel.readString()
neutralBtnSelectStr = parcel.readString()
neutralBtnCustomStr = parcel.readString()
```


## 参考
1. [Parcelable 和 Bundle](https://developer.android.com/guide/components/activities/parcelables-and-bundles)
2. [Parcelable](https://developer.android.com/reference/android/os/Parcelable)
3. [关于 注解 @Parcelize 的相关内容](https://medium.com/@BladeCoder/a-study-of-the-parcelize-feature-from-kotlin-android-extensions-59a5adcd5909)