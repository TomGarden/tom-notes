系统介绍：https://developer.android.google.cn/guide/topics/permissions/overview

## 摘要：
1. 即使用户授予了权限也不能太过依赖该权限，应该时刻保持警惕，因为用户随时可以在系统设置中取消对应用的授权。
    -  涉及异常：`SecurityException`
2. 权限申请所涉及的标签(各有各的用处用的时候需要加以区分)
    ```xml
    <uses-permission android:name="android.permission.SEND_SMS"/>
    <uses-feature android:name="android.hardware.camera" android:required="false" />
    ```
3. 各个组件以及其他的功能(Activity、service、Broadcast、Content Provider、URI、Other)也可以设置为依赖权限
    - 如果设置了，在启动对应组件或功能的时候，SDK会检查权限满足状况，不满足会`SecurityException`
    - 所涉及的 Manifest 配置标签:`android:permission`
4. permission group 权限组的细节需要了解**使用下述细节的时候需要重新阅读 google 原文**
    - If the app doesn't currently have any permissions in the permission group, the system shows the permission request dialog to the user describing the permission group that the app wants access to. The dialog doesn't describe the specific permission within that group. For example, if an app requests the READ_CONTACTS permission, the system dialog just says the app needs access to the device's contacts. If the user grants approval, the system gives the app just the permission it requested.
    - If the app has already been granted another dangerous permission in the same permission group, the system immediately grants the permission without any interaction with the user. For example, if an app had previously requested and been granted the READ_CONTACTS permission, and it then requests WRITE_CONTACTS, the system immediately grants that permission without showing the permissions dialog to the user.    
    - 权限组尚不稳定，权限的分组随时可能改变，因此我们的业务逻辑不能依赖当前的权限组。

-------
关于使用
-------

### 权限检查
1. 检查当前程序的权限获取状况。
    ```java
    ContextCompat.checkSelfPermission()
    ```
2. 检查调用者的权限获取状况
    ```java
    //uri permission Intent 一次性权限
    Context.checkUriPermission()
    //被其他进程调用时通过下方法查看调用进程权限获取状况
    Context.checkCallingPermission()
    //如果已知其他进程的 PID 可以用一下方法查看该进程的权限获取状况
    Context.checkPermission()
    //如果已知其他进程的 包名 可以用一下方法查看该进程的权限获取状况
    PackageManager.checkPermission()
    ```

### 请求权限
ActivityCompat.requestPermissions()

### 关于统一管理权限申请事宜模块的不可行性。
经过尝试前面几个步骤没什么大问题，问题在于，权限申请结果


        int permission_result = ContextCompat.checkSelfPermission(Global.applicationContext,
                WRITE_EXTERNAL_STORAGE);
        switch (permission_result) {
            case PERMISSION_GRANTED:
                //保存日志文件
                this.saveCrashInfo2File(ex);
                LogUtil.i(LogUtil.msg() + "本次异常交给ExceptionUtil处理了");
                break;
            case PERMISSION_DENIED:
                LogUtil.i(LogUtil.msg()+"由于无写sdCard 权限，本次异常将无法留下日志");
                break;
        }