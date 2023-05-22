> 无差别抄录：http://blog.csdn.net/mingli198611/article/details/17762149

在android系统中sendBroadcast和BroadcastReceiver。只要BroadcastReceiver指定的action和sendBroadcast action一致就可以就行消息接收。但是我们有这样的需求即我发送的广播不允许所有应用都可以接收广播消息，而是要经过发送者允许的才可以。比如某一个产品簇，每一个产品发送的广播消息只允许本簇内的产品才允许接收消息。其它应用即使action一样，也无法接收消息。这样就大大的提供了产品的安全性。那么如何实现呢？本文主要目的就是于此。


## 一、只允许本应用内允许接收。

### 解决方案一：LocalBroadcastManager （局部广播）

优点：

1. 因广播数据在本应用范围内传播，你不用担心隐私数据泄露的问题。
2. 不用担心别的应用伪造广播，造成安全隐患。
3. 相比在系统内发送全局广播，它更高效。

缺点：

1. 它只能够在同一个进程使用，如果本应用是多进程的。必须保证发送者和接收者是在同一个进程内。
2. 它只能够动态注册和取消。

使用实例：

先通过LocalBroadcastManager lbm = LocalBroadcastManager.getInstance(this);获取实例

然后通过函数 registerReceiver来注册监听器
```java
registerReceiver(newBroadcastReceiver() { 

       @Override 
       public void onReceive(Context context, Intent intent) { 
       // TODO Handle the received local broadcast 
       } 

}, newIntentFilter(XXXX)); 
```
 

通过 sendBroadcast 函数来发送广播
lbm.sendBroadcast(newIntent(XXXX));  


### 解决方案二：intent 指定包名Intent.setPackage设置广播仅对本程序有效【见二】

 

## 二、指定某一个应用允许接收。

### 解决方案：intent 指定包名Intent.setPackage设置广播仅对相同包名的有效

优点：

1. 支持跨进程
2. receiver可以是静态注册也可以是动态注册。
3. 只有指定的包名的应用程序才能够接收到数据，所以安全性较高。

缺点：

1. 如果一旦反编译，很容易伪造广播，造成安全隐患
2. 在系统内发生全局广播，它效率较低
3. 它只能够满足一个应用的需求，不能够同时指定多个 

使用实例：
```java
Intent intent = new Intent();             
intent.setPackage("应用包名");
intent.setAction("消息action");            
sendBroadcast(intent);
```

## 三、指定某一个receiver允许接收。

### 解决方案：intent 指定包名Intent.setComponent设置广播仅对相同包名的有效

优点：

1. 可以指定到具体某一个receiver，安全性更高
2. receiver可以是静态注册也可以是动态注册。

缺点：

1. 它只能指定一个receiver，局限性较大

使用实例：
```java
Intent intent = new Intent();             
intent. setComponent(newComponentName("包名", "Receiver类名"));
intent.setAction("消息action");            
sendBroadcast(intent);
``` 

## 四、指定多个应用有权接收。

解决方案：sendBroadcast(Intent, String)的接口在发送广播时指定接收者必须具备的permission。如果担心反编译后，权限被窃取，限制失效。可以在声明权限时，提高权限的

leverl为签名验证，即只有相同签名的应用且有该权限才能够接收，这样就能够满足产品簇的问题。

使用实例：

AndroidManifest.xml
```xml
<permission android:description="@string/XXX" 
    android:label="XXXX" 
    android:name=" com.test.permission" 
    android:protectionLevel=" signature">
<receiver
   android:name="XXXX"
   android:permission="com.test.permission" >
   <intent-filter >
        <actionandroid:name="XXXXX" />
   </intent-filter>
 </receiver>
```
```java
Intent intent = new Intent();             
intent.setAction("消息action");            
sendBroadcast(intent, "com.test.permission");
```

注意：如果要求安全级别较高，使用签名验证机制即使优点又是缺点。目前还没有找到更好的方法，能够满足多个指定应用都能够接收消息，且安全级别不会受到伪造或窃取的风险。