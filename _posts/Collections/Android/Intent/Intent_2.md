## Intent中的属性
```java
private String mAction;
private Uri mData;
private ComponentName mComponent;
private ArraySet<String> mCategories;
private int mFlags;
private Bundle mExtras;
private String mType;

private String mPackage;
private Rect mSourceBounds;
private Intent mSelector;
private ClipData mClipData;
private int mContentUserHint = UserHandle.USER_CURRENT;
```
## mPackage $ setPackage
|Intent|setPackage (String packageName)|
|------|-------------------------------|
|方法说明|(通常可选)设置一个明确的应用程序包名，用来限制这个Intent所能通知到的组件的范围。默认值 null ， Intent尝试去匹配所有应用中的所有组件。如果使用指定的包名，Intent 所匹配的组件就是我们指定包名中的组件，不在尝试去匹配除我们包名之外的包中的组件。|
|packageName|指定的应用包名，null 所有包|
|return|`return this;`返回值永远不会是空，返回的是当前Intent |
|试验结果|仅适用与隐式Intent，也就是说package限制不住Component。更明确:如果使用了Component(Component指定的组件存在)不论package指定为什么值，都阻止不了Component所指定的组件的调用|







## 参考
1. [android  intent](https://developer.android.google.cn/reference/android/content/Intent.html#setPackage(java.lang.String))
2. [android 限制广播消息的接收者 ](http://blog.csdn.net/mingli198611/article/details/17762149)