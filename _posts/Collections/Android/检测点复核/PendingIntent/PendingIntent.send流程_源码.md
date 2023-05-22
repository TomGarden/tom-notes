> 源码 android-19

查看PendingIntent相关源代码明了漏洞造成实质性的原因。

我们尝试从`PendingIntent.send`切入

Send方法汇总:以下方法最终调用的都是参数最多的那个，所以我们详探下该方法。
```java
//0 参数
public void send()
//1 参数
public void send(int code)
//3 参数-1
public void send(Context context, int code, Intent intent)
//3 参数-2
public void send(int code, OnFinished onFinished, Handler handler)
//5 参数
public void send(Context context, int code, Intent intent, OnFinished onFinished, Handler handler)
//6 参数
public void send(Context context, int code, Intent intent, OnFinished onFinished, Handler handler, String requiredPermission)
```
对send方法的解释
- 执行和这个PendingIntent相关的操作。允许send的调用者去指定PendingIntent中所存储的Intent的信息
-参数：
    - Context：调用者的Context，如果Intent是null这里可以为null
    - 
    - Intent：

send方法：

```java
    public void send(Context context, int code, Intent intent,
            OnFinished onFinished, Handler handler, String requiredPermission)
            throws CanceledException {
        try {
            String resolvedType = intent != null ?
                    intent.resolveTypeIfNeeded(context.getContentResolver())
                    : null;
            //我们查看下这个方法调用                    
            int res = mTarget.send(code, intent, resolvedType,
                    onFinished != null
                            ? new FinishedDispatcher(this, onFinished, handler)
                            : null,
                    requiredPermission);
            if (res < 0) {
                throw new CanceledException();
            }
        } catch (RemoteException e) {
            throw new CanceledException(e);
        }
    }
```

查看IIntentSender文件(没什么有意义的内容),这是因为版本不对下文还有正确的

```java
private final IIntentSender mTarget;
//上述类源码：https://github.com/android/platform_frameworks_base/blob/master/core/java/android/content/IIntentSender.aidl
/** @hide */
oneway interface IIntentSender {
    void send(int code, in Intent intent, String resolvedType, in IBinder whitelistToken,
            IIntentReceiver finishedReceiver, String requiredPermission, in Bundle options);
}
```

寻找IIntentSender接口的实现；    
找到了：PendgingIntent中的返回值为PendingIntent的静态方法     
1. getXXX(    
2. PendingIntent的构造函数    
```java
//静态方法还有很多只看一个
    public static PendingIntent getActivity(Context context, int requestCode,
            Intent intent, int flags, Bundle options) {
            //……
            IIntentSender target =
                ActivityManagerNative.getDefault().getIntentSender(
                    ActivityManager.INTENT_SENDER_ACTIVITY, packageName,
                    null, null, requestCode, new Intent[] { intent },
                    resolvedType != null ? new String[] { resolvedType } : null,
                    flags, options, UserHandle.myUserId());
            return target != null ? new PendingIntent(target) : null;
            //……
    }
//构造方法有两个只看相关的这个
    /*package*/ PendingIntent(IIntentSender target) {
        mTarget = target;
    }
```
接下来寻找ActivityManagerNative.getDefault().getIntentSender(
1. ActivityManagerNative：直接在AndroidStudio中Double Shift 搜索到
2. getDefault:有一个不太熟悉的知识点
3. ActivityManagerNative.getDefault()如下
```java
//ActivityManagerNative.java文件
    private static final Singleton<IActivityManager> gDefault = new Singleton<IActivityManager>() {
        protected IActivityManager create() {
            IBinder b = ServiceManager.getService("activity");
            if (false) {
                Log.v("ActivityManager", "default service binder = " + b);
            }
            IActivityManager am = asInterface(b);
            if (false) {
                Log.v("ActivityManager", "default service = " + am);
            }
            return am;
        }
    };

//new下述类返回通过实现create()方法，然后get得到泛型对象。
//Singleton.java文件
public abstract class Singleton<T> {
    private T mInstance;

    protected abstract T create();

    public final T get() {
        synchronized (this) {
            if (mInstance == null) {
                mInstance = create();
            }
            return mInstance;
        }
    }
}

//这个泛型对象来自于
//ActivityManagerNative.java文件
    static public IActivityManager asInterface(IBinder obj) {
        if (obj == null) {
            return null;
        }
        IActivityManager in =
            (IActivityManager)obj.queryLocalInterface(descriptor);
        if (in != null) {
            return in;
        }

        return new ActivityManagerProxy(obj);
    }
//好的
```
4. ActivityManagerNative.getDefault().getIntentSender(
    - 位于ActivityManagerNative.java文件中的内部类ActivityManagerProxy
    - 那接下来我在回溯一下跟上`public static PendingIntent getActivity`中的代码：`IIntentSender target =  ActivityManagerNative.getDefault().getIntentSender(`
    - 在 getIntentSender 中查找 IIntentSender 的蛛丝马迹
```java
public IIntentSender getIntentSender(int type,
            String packageName, IBinder token, String resultWho,
            int requestCode, Intent[] intents, String[] resolvedTypes, int flags,
            Bundle options, int userId) throws RemoteException {
        //……
        IIntentSender res = IIntentSender.Stub.asInterface(reply.readStrongBinder());
        //……
        return res;
    }
```
我们一已经找到了 mTarget 的实现入口，接下来找到代码：IIntentSender.Stub.asInterface(reply.readStrongBinder());具体才行

然后会发现找不到对应版本的IIntentSender.java文件所以我们需要一个地址：http://grepcode.com/file/repository.grepcode.com/java/ext/com.google.android/android/4.4.2_r1/android/content/IIntentSender.java?av=f

现在文件拿到了

```java
        /**
         * Cast an IBinder object into an android.content.IIntentSender interface,
         * generating a proxy if needed.
         */
        public static android.content.IIntentSender asInterface(android.os.IBinder obj) {
            if ((obj == null)) {
                return null;
            }
            android.os.IInterface iin = obj.queryLocalInterface(DESCRIPTOR);
            if (((iin != null) && (iin instanceof android.content.IIntentSender))) {
                return ((android.content.IIntentSender) iin);
            }
            return new android.content.IIntentSender.Stub.Proxy(obj);
        }
```

好了现在已经很清晰了PendingIntent.send方法真正的执行代码是：
IIntentSender.java文件中的 内部类 Stub 中的内部类 Proxy 中的 send方法。
```java
public interface IIntentSender extends android.os.IInterface {
    
    public static abstract class Stub extends android.os.Binder implements android.content.IIntentSender {

        private static class Proxy implements android.content.IIntentSender {
            private android.os.IBinder mRemote;
            //……
            @Override
            public int send(int code, android.content.Intent intent, java.lang.String resolvedType, android.content.IIntentReceiver finishedReceiver, java.lang.String requiredPermission) throws android.os.RemoteException {
                //重点开始
                android.os.Parcel _data = android.os.Parcel.obtain();
                android.os.Parcel _reply = android.os.Parcel.obtain();
                int _result;
                try {
                    if ((intent != null)) {
                        _data.writeInt(1);
                        intent.writeToParcel(_data, 0);
                        //重点结束
                    } else {
                        _data.writeInt(0);
                    }
                    _data.writeString(resolvedType);
                    _data.writeStrongBinder((((finishedReceiver != null)) ? (finishedReceiver.asBinder()) : (null)));
                    _data.writeString(requiredPermission);
                    //以上内容就是网Parcel对象 _data 中一顿写，下方是写完之后的调用了
                    mRemote.transact(Stub.TRANSACTION_send, _data, _reply, 0);//重中之重
                    _reply.readException();
                    _result = _reply.readInt();
                } finally {
                    _reply.recycle();
                    _data.recycle();
                }
                return _result;
            }
        }
    }
}
```
要查看以上方法的执行我们需要明确参数了
- core我们调用send传入   0  这里还是 0；
- intent和send时候相同；
- resolvedType看之前代码可确定:`intent.resolveTypeIfNeeded(context.getContentResolver())`；
- finishedReceiver null；
- requiredPermission null；

好了可以继续分析了

把新的Intent中的内容写入 Parcel 中

然后调用 `IBinder.transact(Stub.TRANSACTION_send, _data, _reply, 0)`;

到现在我们需要返回确定这个IBinder的实例对象时谁，因为IBinder本身是一个接口

把上文再读一遍我们知道了 `IBinder b = ServiceManager.getService("activity");`  

我们去找 android.os.ServiceManager.getService("activity") 的实现
```java
    public static IBinder getService(String name) {
        try {
            IBinder service = sCache.get(name);
            if (service != null) {
                return service;
            } else {
                return getIServiceManager().getService(name);
            }
        } catch (RemoteException e) {
            Log.e(TAG, "error in getService", e);
        }
        return null;
    }
```
到目前我们到了岔路口，必须做选择，当然了如果选错了还必须回来走另一条。    
我选  `return getIServiceManager().getService(name);`       

关于：sServiceManager = ServiceManagerNative.asInterface(BinderInternal.getContextObject());      
只有一处所以实现也只有一处。：：：
sources\android-19\com\android\internal\os\BinderInternal.java
```java
    /**
     * Return the global "context object" of the system.  This is usually
     * an implementation of IServiceManager, which you can use to find
     * other services.
     */
    public static final native IBinder getContextObject();
```



> 做代码阅读和跟踪，我们需要一个图形化工具，因为大脑的内存有点小，加上缓存也搞不清楚，md文件做缓存总是有内存溢出的风险，如果用图形化的工具来做缓存效果会好很多。
