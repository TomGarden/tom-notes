## 一、Intent作用
Activity / Service / BroadCast / ContentProvider组件间通信

## 二、Intent属性
Intent七大属性是指Intent的ComponentName、Action、Category、Data、Type、Extra以及Flag，七个属性，总体上可以分为3类：

第一类：启动，有ComponentName（显式）,Action（隐式），Category（隐式）。

第二类：传值，有Data（隐式），Type（隐式），Extra（隐式、显式）。

第三类：启动模式，有Flag。

## 三、问题
1. 属性优先级：
    - Componentname的优先级高于Action
2. 隐式Intent具有选择性启动组件的能力吗(假设Action和Category都相同)?
    - 不具有。
3. 启动组件需要的最少属性
    1. 仅 ComponentName（显式）
    2. 仅 Action（隐式）
    3. 要使用其他的任何属性如果没有设置ComponentName / Action两个属性是无法完成组件通信作用的。
4. 显示Intent代码枚举(要使用显示Intent必须包含这些代码中的一种情况)
    ```java
    //1
    Intent(Context packageContext, Class<?> cls);
    //2
    Intent(String action, Uri uri, Context packageContext, Class<?> cls);
    //3,4,5,6
    Intent intent = new Intent();
    intent.setClass(Context packageContext, Class<?> cls);
    intent.setComponent(ComponentName component);
    intent.setClassName(Context packageContext, String className);
    intent.setClassName(String packageName, String className);
    ```
5. 隐式Intent代码枚举(要使用隐式Intent一定会包含这些代码)
    ```java
    //1
    Intent(String action);
    //2
    Intent(String action, Uri uri);
    //3
    Intent intent = new Intent();
    intent.setAction(String action);
    ```


## 参考
1. https://developer.android.google.cn/guide/components/intents-filters.html#Receiving
2. https://developer.android.google.cn/reference/android/content/Intent.html
3. http://blog.csdn.net/u012702547/article/details/50178429
4. http://www.bubuko.com/infodetail-1852650.html