## 〇、发送相关的方法
android.content.Context
```java
//包含尚未过时和已经过时两个部分
abstract void 	sendBroadcast(Intent intent, String receiverPermission) 
abstract void 	sendBroadcast(Intent intent) 
abstract void 	sendBroadcastAsUser(Intent intent, UserHandle user) 
abstract void 	sendBroadcastAsUser(Intent intent, UserHandle user, String receiverPermission) 
abstract void 	sendOrderedBroadcast(Intent intent, String receiverPermission, BroadcastReceiver resultReceiver, Handler scheduler, int initialCode, String initialData, Bundle initialExtras) 
abstract void 	sendOrderedBroadcast(Intent intent, String receiverPermission) 
abstract void 	sendOrderedBroadcastAsUser(Intent intent, UserHandle user, String receiverPermission, BroadcastReceiver resultReceiver, Handler scheduler, int initialCode, String initialData, Bundle initialExtras) 

//已经过时的——不在本次讨论之列
abstract void 	sendStickyBroadcast(Intent intent) 
abstract void 	sendStickyBroadcastAsUser(Intent intent, UserHandle user) 
abstract void 	sendStickyOrderedBroadcast(Intent intent, BroadcastReceiver resultReceiver, Handler scheduler, int initialCode, String initialData, Bundle initialExtras) 
abstract void 	sendStickyOrderedBroadcastAsUser(Intent intent, UserHandle user, BroadcastReceiver resultReceiver, Handler scheduler, int initialCode, String initialData, Bundle initialExtras) 
```
1. sendBroadcast(Intent intent, String receiverPermission) 
    - intent 即将被广播的 Intent ；所有和本 Intent 相匹配的 BroadcastReceiver 都将接收并按各自的逻辑处理这个 Intent 。
    - receiverPermission (可选)一个表示权限的字段，用来限制对 BroadcastReceiver 做出限制，只有具有 receiverPermission 权限的 BroadcastReceiver 才能接收本 Intent 。如果为 null 没有权限限制。
2. sendBroadcast(Intent intent) 
    - intent 即将被广播的 Intent ；所有和本 Intent 相匹配的 BroadcastReceiver 都将接收并按各自的逻辑处理这个 Intent 。
3. sendBroadcastAsUser(Intent intent, UserHandle user) 
    > 和 `sendBroadcast(Intent intent)` 最像，区别在于本方法会将广播发送到 user 所指定的用户。这个方法只支持系统预装应用。
    
    - intent 即将被广播的 Intent ；所有和本 Intent 相匹配的 BroadcastReceiver 都将接收并按各自的逻辑处理这个 Intent 。
    - user 事实上对于 Android 系统的多用户我们都没与体验过，这个点有点鸡肋，结论是暂不考虑。
        - UserHandle.ALL  -------------设备上所有用户均可接收到广播
        - UserHandle.CURRENT  ----------------设备上当前用户可接收到广播
        - UserHandle.CURRENT_OR_SELF  ----------设备上当前用户或者该应用所属用户可接收到广播
        - UserHandle.OWNER  ------------------设备所有者可接收到广播
        - UserHandle.SYSTEM  ------------------设备的系统用户可接收到广播
4. sendOrderedBroadcast




