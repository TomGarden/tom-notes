# ContentProvider目录遍历(二)

## 〇、总结
漏洞成立静态检测理论上可行(需要开发权衡)。
总结尚不全面
- 从不同的角度验证风险需要大量精力。
    - 写权限尚未验证。
- Drozer 获取风险 URI 的做法细节尚未研究。
```terminal
Path Permissions:
Path: /Keys
Type: PATTERN_LITERAL
Read Permission: com.mwr.example.sieve.READ_KEYS
Write Permission: com.mwr.example.sieve.WRITE_KEYS
```    

在[ContentProvider目录遍历(一).md](ContentProvider目录遍历(一).md)中我们探讨了关于 ContentProvider 的目录遍历风险。其中问题的焦点有两个。
1. ContentProvider 配置风险：`<provider>` 节点设置存在风险。
2. 真正发生目录遍历的相关方法：`public ParcelFileDescriptor openFile(@NonNull Uri uri, @NonNull String mode)`

在上篇文字中我们从一个点(一个方法)入手证明了风险的存在。这篇文字我们从面(所有可能的方法)入手了解风险状况。

## 一、android.content.ContentProvider 中的疑似风险的方法方法
ParcelFileDescriptor openFile (Uri uri, String mode);    
ParcelFileDescriptor openFile (Uri uri, String mode, CancellationSignal signal)
- __方法描述：__       
    　重写此方法用于处理打开文件的请求。默认的实现总是会抛出 FileNotFoundException 异常。本方法可以在多线程中调用，就像在[Processes and Threads](https://developer.android.google.cn/guide/components/processes-and-threads.html#Threads)描述的那样。     
    　本方法 return 一个 ParcelFileDescriptor 对象，该对象直接返回给调用者。这样就可以在不复制内容的情况下返回大数据(例如图片和文档)。     
    　返回值 ParcelFileDescriptor 对象被本方法的调用者所拥有，所以使用 ParcelFileDescriptor 对象完成后关闭它是本方法调用者的责任。本方法的实现应该是为每一个调用者创建一个 ParcelFileDescriptor 对象。     
    　如果用“r”/“w”专属模式打开文件， 返回的 ParcelFileDescriptor 数据流可以使用 pipe 或者 socket pipe 传输数据流。Opening with the "rw" or "rwt" modes implies a file on disk that supports seeking.           
    　如果你想探明已经 return 的 ParcelFileDescriptor  是否已经被 close ，或者远程进程是否已经崩溃或者发生错误，可以使用 `open(File, int, android.os.Handler, android.os.ParcelFileDescriptor.OnCloseListener), createReliablePipe(), 或者 createReliableSocketPair(). `    
    　如果你要返回的是一个不是真实存在于磁盘上的大文件(例如网络上的共享文件或者云存储服务)，可以考虑使用`openProxyFileDescriptor(int, android.os.ProxyFileDescriptorCallback, android.os.Handler)`这会使您使用流传输内容。   
    　_在 Intent 中使用的时候，你或许需要 实现 `getType(Uri)` 方法去为相同的 RUI return 一个适当的 MIME 类型。这将允许意图自动确定 MIME 类型，有助于其匹配合适的目标处理该 Intent。_    
    　_为了和其他应用更好的交互，建议"对于任何可以打开的 Uri 你也应该支持一个用 OpenableColumns 表示的查询列表"。如果你还有其他要提供的元数据( `MediaStore.MediaColumns 中的 DATE_ADDED `)，你还需要支持其他公共列。_
- __参数：__       
    - __uri__ Uri：(禁止 null )指定所要打开的 file 的所有者。
    - __mode__ String：(禁止 null )指定文件的访问模式。
        - `r` ： 只读
        - `rw` ： 读写
        - `rwt` ： 
            - Sticky Bit:这个 Sticky Bit, SBIT 目前只针对目录有效作用是：
                - 当使用者对於此目录具有 w, x 权限，亦即具有写入的权限时；
                - 当使用者在该目录下创建文件或目录时，仅有自己与 root 才有权力删除该文件
                - 换句话说：当甲这个使用者於 A 目录是具有群组或其他人的身份，并且拥有该目录 w 的权限， 这表示『甲使用者对该目录内任何人创建的目录或文件均可进行 "删除/更名/搬移" 等动作。』 不过，如果将 A 目录加上了 SBIT 的权限项目时， 则甲只能够针对自己创建的文件或目录进行删除/更名/移动等动作，而无法删除他人的文件。
                ```terminal
                [root@www tmp]# chmod 7666 test; ls -l test <==具有空的 SUID/SGID 权限
                -rwSrwSrwT 1 root root 0 Sep 29 03:06 test
                ```
    - __signal__ CancellationSignal ： 一个标记，用于取消正在进行的进程，或者 null 如果不设置。例如：如果你正在从网络下载一个文件用于满足一个具有 "rw" 模式的请求的服务，你需要定期调用 ` throwIfCanceled() ` 来确定请求者是否已经取消了这个下载。

AssetFileDescriptor openAssetFile (Uri uri, String mode)    
AssetFileDescriptor openAssetFile (Uri uri, String mode, CancellationSignal signal)
- __方法描述：__       
    　和 `openFile(Uri, String)` 很像，可以由 Provider 实现，需要能够返回文件的之内容，经常是存在于 .apk 文件中的 asserts 。本方法可以在多线程中调用，就像在[Processes and Threads](https://developer.android.google.cn/guide/components/processes-and-threads.html#Threads)描述的那样。     
    　如果您实现此方法，您的客户端必须能够直接使用`openAssetFileDescriptor（Uri，String）`或使用更高级别的`ContentResolver.openInputStream或ContentResolver.openOutputStream`方法处理这样的文件片段。
    　返回的`AssetFileDescriptor`可以是一个处理数据流的 pipe 或者 socket 。    
    　_如果在你的实现中 return 了一个完整的文件，你需要创建一个 UNKNOWN_LENGTH 的 AssetFileDescriptor 对象，确保兼容那些不能处理 .apk 内部文件的应用。_
    　_在 Intent 中使用的时候，你或许需要 实现 `getType(Uri)` 方法去为相同的 RUI return 一个适当的 MIME 类型。这将允许意图自动确定 MIME 类型，有助于其匹配合适的目标处理该 Intent。_    
    　_为了和其他应用更好的交互，建议"对于任何可以打开的 Uri 你也应该支持一个用 OpenableColumns 表示的查询列表"。如果你还有其他要提供的元数据( `MediaStore.MediaColumns 中的 DATE_ADDED `)，你还需要支持其他公共列。_
- __参数：__       
    - __uri__ 同上
    - __mode__ 同上
    - __signal__ 同上

AssetFileDescriptor openTypedAssetFile (Uri uri, String mimeTypeFilter, Bundle opts)    
AssetFileDescriptor openTypedAssetFile (Uri uri, String mimeTypeFilter, Bundle opts, CancellationSignal signal)
- __方法描述：__       
    　被三方应用调用并为其提供一个指定 MIME 文件类型的数据流。除了提供的文件只读外，和 `openAssetFile(Uri, String) ` 没有什么不同，content provider 可以执行数据转换以生成所需类型的数据。    
    　默认的实现将给定的 MIME type 和 `getType(Uri)` 进行比较如果匹配，就调用 ` openAssetFile(Uri, String) `。    
    　[实现本方法的一个例子:ClipData](https://developer.android.google.cn/reference/android/content/ClipData.html)    
    　返回的 AssetFileDescriptor 可以是一个包含数据的 pipe 或者 socket pair 。    
    　_为了和其他应用更好的交互，建议"对于任何可以打开的 Uri 你也应该支持一个用 OpenableColumns 表示的查询列表"。如果你还有其他要提供的元数据( `MediaStore.MediaColumns 中的 DATE_ADDED `)，你还需要支持其他公共列。_
- __参数：__       
    - __uri__ 同上
    - __mimeTypeFilter__ String : (禁止 null ) 客户端所需的数据类型。 可能是一个模式，如`*/*`，如果调用者没有具体的类型要求; 在这种情况下，内容提供商将选择与模式匹配的最佳类型。
    - __opts___	Bundle:  (禁止 null ) 来自客户端的其他选项。这些定义和 Content Provider 相对应(也就是按照开发者所规定的约定进行指定。)
    - __signal__ 同上

不难注意到所有的方法都建议提供一个叫做候选列表 `OpenableColumns` 的东西。
### 1.1、[OpenableColumns](https://developer.android.google.cn/reference/android/provider/OpenableColumns.html)

这些是可打开的 Uri 对应的标准列表。Provider 至少支持这其中声明的 Uri 所对应的文件。

本类只有两个属性
- String 	DISPLAY_NAME ： The human-friendly name of file.
- String 	SIZE ： The number of bytes in the file identified by the openable URI. 

### 1.2、分析小结
实际风险如何最终还是要根据风险方法中对于文件路径是否做了合理的过滤

### 1.3、查看以上方法的具体默认实现
```java
    public @Nullable ParcelFileDescriptor openFile(@NonNull Uri uri, @NonNull String mode)
            throws FileNotFoundException {
        throw new FileNotFoundException("No files supported by provider at "
                + uri);
    }
    public @Nullable ParcelFileDescriptor openFile(@NonNull Uri uri, @NonNull String mode,
            @Nullable CancellationSignal signal) throws FileNotFoundException {
        return openFile(uri, mode);
    }
    //=====================================================================
    public @Nullable AssetFileDescriptor openAssetFile(@NonNull Uri uri, @NonNull String mode)
            throws FileNotFoundException {
        ParcelFileDescriptor fd = openFile(uri, mode);
        return fd != null ? new AssetFileDescriptor(fd, 0, -1) : null;
    }
    public @Nullable AssetFileDescriptor openAssetFile(@NonNull Uri uri, @NonNull String mode,
            @Nullable CancellationSignal signal) throws FileNotFoundException {
        return openAssetFile(uri, mode);
    }
    //=========================================================================
    public @Nullable AssetFileDescriptor openTypedAssetFile(@NonNull Uri uri,
            @NonNull String mimeTypeFilter, @Nullable Bundle opts) throws FileNotFoundException {
        if ("*/*".equals(mimeTypeFilter)) {
            // If they can take anything, the untyped open call is good enough.
            return openAssetFile(uri, "r");
        }
        String baseType = getType(uri);
        if (baseType != null && ClipDescription.compareMimeTypes(baseType, mimeTypeFilter)) {
            // Use old untyped open call if this provider has a type for this
            // URI and it matches the request.
            return openAssetFile(uri, "r");
        }
        throw new FileNotFoundException("Can't open " + uri + " as type " + mimeTypeFilter);
    }
    public @Nullable AssetFileDescriptor openTypedAssetFile(@NonNull Uri uri,
            @NonNull String mimeTypeFilter, @Nullable Bundle opts,
            @Nullable CancellationSignal signal) throws FileNotFoundException {
        return openTypedAssetFile(uri, mimeTypeFilter, opts);
    }
```
### 1.3、分析小结
实际风险如何最终还是要根据风险方法中对于文件路径是否做了合理的过滤

并且实际情况是，除非自己覆写了上述方法中任何一个自己来实现文件共享逻辑。否则都是必然要调用 `openAssetFile(@NonNull Uri uri, @NonNull String mode)`的。

## 二、android.content.ContentProvider 中确认风险的方法
上述方法都是风险方法

## 三、风险的分类与检测。
事实上开发者覆写了上述任何的方法都需要根据逻辑确认是否存在风险的。

本风险的产生需要如下条件
1. 覆写了 `openFile(@NonNull Uri uri, @NonNull String mode)` 方法。
2. 覆写上述任意方法。
3. 以上两点并非互为条件但却有着事实的区分(看完上述代码即明了)。

Linux系统中所支持的目录切换相关命令和字符
```terminal
.         代表此層目錄
..        代表上一層目錄
-         代表前一個工作目錄
~         代表『目前使用者身份』所在的家目錄
~account  代表 account 這個使用者的家目錄(account是個帳號名稱)
```
- 通过 `new File(path) ` 的方式访问包含上述字符的木目录识别成功的只有 `. 和 ..`

检测：
1. 存在配置风险的 Content Provider 是否覆写了上述方法中的任意方法。
2. 在实现的逻辑中是否存在目录筛选(达到访问目录受控的效果)
3. 如果有实现，判断是否对 `../` 进行了过滤。或者是否对路径进行了匹配
    - 这种检测方式成本太高。

### 3.1、 检测方式： drozer
存在 `openFile(@NonNull Uri uri, @NonNull String mode)` 方法覆写的时候
```terminal
dz> run scanner.provider.traversal -a com.example.tom.forbroadcast
Scanning com.example.tom.forbroadcast...
Not Vulnerable:
  content://com.example.tom.forbroadcast.com.android.tools.fd.runtime.InstantRun
ContentProvider
  content://com.example.tom.forbroadcast.com.android.tools.fd.runtime.InstantRun
ContentProvider/

Vulnerable Providers:
  content://testin.cn/
  content://authorities
  content://testin.cn
  content://authorities/
```
把 `openFile(@NonNull Uri uri, @NonNull String mode)` 方法覆写注释掉
```terminal
dz> run scanner.provider.traversal -a com.example.tom.forbroadcast
Scanning com.example.tom.forbroadcast...
Not Vulnerable:
  content://com.example.tom.forbroadcast.com.android.tools.fd.runtime.InstantRun
ContentProvider
  content://com.example.tom.forbroadcast.com.android.tools.fd.runtime.InstantRun
ContentProvider/

Vulnerable Providers:
  No vulnerable providers found.
```
### 3.2、不依赖 drozer 完成上述检测
#### 3.2.1、静态检测
1. 查看 AndroidManifest.xml 文件中的所有 `<provider>` 节点。
2. 如果该节点 `android:enabled="true"` 检查 `<application>` 的 `android:enabled="true"`
    - 以下说法适用于上述两个节点
    - `android:enabled="true"`意味着 本组件可以被 Android 系统实例化，从而被三方应用调用。
    - 此属性默认值为 `android:enabled="true"` —— 即：对应节点如果没有设置改属性那么意味着 `android:enabled="true"`
3. 在 enable = true 的前提下查看权限属性    
    ```xml
    android:permission="string"         //无该属性即为不需要权限
    android:writePermission="string"    //无该属性即为不需要权限
    android:readPermission="string"     //无该属性即为不需要权限
    ```
    -  值的注意的是 ` readPermission 和 writePermission ` 属性比 `permission` 具有更高的优先级。如果 readPermission 也同时设置了，那么 readPermission 将控制 provider 的读取。如果 writePermission 也同时设置了，那么 writePermission 将控制 provider 的写入。  
    - 如果上述权限均设置均为null(“”)
        - 如果用声明了 `<uses-permission android:name="android.permission.READ_EXTERNAL_STORAGE" />` 节点那么造成任意文件读取风险(在4 5 均造成风险的前提下)。
        - 如果声明了 `<uses-permission android:name="android.permission.WRITE_EXTERNAL_STORAGE" />` 节点那么造成任意文件写入风险(在4 5 均造成风险的前提下)。
4. 根据 `<provider>` 节点的属性 `android:name` 所指定的路径找到 ContentProvider。
5. 确认代码中是否存在对于下述方法的覆写如果检查到任一方法继续 5
    1. openFile (Uri uri, String mode);    
    2. openFile (Uri uri, String mode, CancellationSignal signal)
    3. openAssetFile (Uri uri, String mode)    
    4. openAssetFile (Uri uri, String mode, CancellationSignal signal)
    5. openTypedAssetFile (Uri uri, String mimeTypeFilter, Bundle opts)    
    6. openTypedAssetFile (Uri uri, String mimeTypeFilter, Bundle opts, CancellationSignal signal)
6. 确认方法中是否规避了` ../ `如果未规避那么风险成立
    - 通过查看方法中的逻辑，并且跟踪非基本数据类型的.方法调用。

#### 3.2.2、动态检测
```terminal
dz> run scanner.provider.traversal -a  com.example.tom.forbroadcast
Scanning com.example.tom.forbroadcast...
Not Vulnerable:
  content://com.example.tom.forbroadcast.com.android.tools.fd.runtime.InstantRunContentProvider
  content://com.example.tom.forbroadcast.com.android.tools.fd.runtime.InstantRunContentProvider/

Vulnerable Providers: /**脆弱的providers*/
  content://testin.cn/
  content://authorities
  content://testin.cn
  content://authorities/
```

drozer读取效果(成功)
```terminal
dz> run app.provider.read content://testin.cn/../../../../../storage/emulated/0/Download/qqqq.txt
testin.cn  ^_^
```

drozer读取效果(失败)
```terminal
dz> run app.provider.read content://testin.cn/../../../../../storage/emulated/0/Download/qqqq.txt
No files supported by provider at content://testin.cn/../../../../../storage/emulated/0/Download/qqqq.txt
```

#### 3.2.3、adb 文件读取效果
adb shell content    

```terminal
usage: adb shell content read --uri <URI> [--user <USER_ID>]
Example:
# cat default ringtone to a file, then pull to host
adb shell 'content read --uri content://settings/system/ringtone > /mnt/sdcard/tmp.ogg' && adb pull /mnt/sdcard/tmp.ogg
```

读取成功    

```terminal
C:\Users\Tom>adb shell content read --uri content://testin.cn/../../../../../system/etc/hosts
127.0.0.1       localhost
::1             ip6-localhost
```

读取失败

```terminal
C:\Users\Tom>adb shell content read --uri content://testin.cn/../../../../../system/etc/hostsa
Error while accessing provider:testin.cn
java.io.FileNotFoundException: /../../../../../system/etc/hostsa
        at android.database.DatabaseUtils.readExceptionWithFileNotFoundExceptionFromParcel(DatabaseUtils.java:144)
        at android.content.ContentProviderProxy.openFile(ContentProviderNative.java:594)
        at com.android.commands.content.Content$ReadCommand.onExecute(Content.java:521)
        at com.android.commands.content.Content$Command.execute(Content.java:418)
        at com.android.commands.content.Content.main(Content.java:623)
        at com.android.internal.os.RuntimeInit.nativeFinishInit(Native Method)
        at com.android.internal.os.RuntimeInit.main(RuntimeInit.java:251)
```

#### 3.2.4、文件读取效果对应代码
```java
 @Nullable
 @Override
 public ParcelFileDescriptor openFile(@NonNull Uri uri, @NonNull String mode) throws FileNotFoundException {
     Log.i("haha", uri.toString());
     Log.i("haha：uri.getPath", uri.getPath());
     File file = new File(getContext().getFilesDir(), uri.getPath());
     if (file.exists()) {
         Log.i("haha", "读取文件成功了：" + file.getPath());
         //Log.i("haha", "读取文件成功了getAbsolutePath：" + file.getAbsolutePath());
         //return ParcelFileDescriptor.open(file, ParcelFileDescriptor.MODE_READ_WRITE);
         return ParcelFileDescriptor.open(file, ParcelFileDescriptor.MODE_READ_ONLY);
     } else {
         Log.i("haha", "本应用认为文件不存在：" + file.getPath());
     }
     throw new FileNotFoundException(uri.getPath());
 }
```
----

## 参考
1. [linux 文件属性与权限](http://www.cnblogs.com/kzloser/articles/2673790.html)


## 行动指南(请忽略)
1. 查看各个方法的具体实现，看能否避免逐个试验。
2. 手机并确认目录遍历的逻辑。
3. 探索检测方式： 1)drozer 2)adb