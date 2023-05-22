# 获取 Android 网络状态
要获取 Android 网络状态，有多种方式多种 API ，我们可以通过百度快速发现相关的知识点。

但是我想问的是，如果不是通过百度搜索引擎口口相传，我们想找第一手资料是否存在。

当然，如果不存在一个“第一手资料”我们能做的就是遍历相关包，查看类概述了。

## 探测网络状态的变更
功能目标：实时获取当前设备的网络状态。
可行的技术实现包括
1. 通过 `ConnectivityManager connectivityManager = (ConnectivityManager) context.getSystemService(Context.CONNECTIVITY_SERVICE);` connectivityManager 对象来获取设备网络状态。
    - 无限循环判断的实现方式不可取
2. 通过广播来获取设备网络状态。
    - 动态广播
    - 静态广播

### 广播才是合理的本功能技术实现方式
关于广播实现实时网络状态的监听功能的自动化检测方式。

#### 1.首先应用需要申请 "`android.permission.INTERNET`" 权限
#### 2.检测是否注册了广播
静态广播
```xml
<receiver android:name=".NetworkBroadcastReceiver.DynamicBroadcastReceiver">
        <intent-filter>
        <action android:name="android.net.conn.CONNECTIVITY_CHANGE" />
        <category android:name="android.intent.category.DEFAULT" />
        </intent-filter>
</receiver>
```
```java
public class DynamicBroadcastReceiver extends BroadcastReceiver {
    @Override
    public void onReceive(Context context, Intent intent) {
        Toast.makeText(MainActivity.context, "动态网络状态监听触发", Toast.LENGTH_LONG).show();
        LogUtil.e(LogUtil.msg() + "动态网络状态监听触发");
    }
}
```
动态广播
```java
public class StaticBroadcastReceiver extends BroadcastReceiver {
    @Override
    public void onReceive(Context context, Intent intent) {
        Toast.makeText(MainActivity.context, "静态网络状态监听触发", Toast.LENGTH_LONG).show();
        LogUtil.e(LogUtil.msg() + "静态网络状态监听触发");
    }
}

private void registerStaticBroadcastReceiver() {
    IntentFilter intentFilter = new IntentFilter();
    intentFilter.addAction(ConnectivityManager.CONNECTIVITY_ACTION);
    registerReceiver(staticBroadcastReceiver, intentFilter);
}

@Override
protected void onDestroy() {
    unregisterReceiver(staticBroadcastReceiver);
    super.onDestroy();
}
```

