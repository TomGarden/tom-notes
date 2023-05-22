# ContentResolver 以 Uri 为参数的方法预研
预研的目的是筛选出所有需要权限支持的方法

## 〇、 一眼可以辨认需要权限的
1. bulkInsert(Uri url, ContentValues[] values) 
2. delete(Uri url, String where, String[] selectionArgs) 
3. insert(Uri url, ContentValues values) 
4. query(Uri uri, String[] projection, Bundle queryArgs, CancellationSignal cancellationSignal) 
5. query(Uri uri, String[] projection, String selection, String[] selectionArgs, String sortOrder, CancellationSignal cancellationSignal) 
6. query(Uri uri, String[] projection, String selection, String[] selectionArgs, String sortOrder) 
7. update(Uri uri, ContentValues values, String where, String[] selectionArgs) 


## 一、 acquireContentProviderClient(Uri uri) 
- Permission Denial
1. 方法声明： ContentProviderClient acquireContentProviderClient (Uri uri)
2. 调用所需权限： 根据 Uri 的不同所需的权限有差异。
3. 返回值： 返回一个和 Uri 相关的 ContentProviderClient ，该对象一样可以用来操作相关的数据。
4. 已忽略风险： acquireContentProviderClient(String name) 
    - 暂不能确定 name 参数的取值
5. 在无权限的情况下本方法崩溃位置为： `android.content.ContentResolver.acquireProvider(Uri uri)`
    - 该参数就来自于 `acquireContentProviderClient (Uri uri)` 就是我们传入的 Uri。
    - 所以别的方法如果有同样的调用逻辑也会报同样的错误。

## 二、 acquireUnstableContentProviderClient（Uri）
- Permission Denial
1. 方法声明： ContentProviderClient acquireUnstableContentProviderClient（Uri）
2. 调用所需权限： 根据 Uri 的不同所需的权限有差异。
3. 返回值： 返回一个和 Uri 相关的 ContentProviderClient ，该对象一样可以用来操作相关的数据。
4. 已忽略风险： acquireUnstableContentProviderClient(String name) 
    - 暂不能确定 name 参数的取值
5. 在无权限的情况下本方法崩溃位置为： `android.content.ContentResolver.acquireUnstableProvider(Uri uri)`
    - 该参数就来自于 `acquireUnstableContentProviderClient (Uri uri)` 就是我们传入的 Uri。
    - 所以别的方法如果有同样的调用逻辑也会报同样的错误。

## 三、 call(Uri uri, String method, String arg, Bundle extras) 
1. 方法声明： Bundle call (Uri uri, String method, String arg, Bundle extras)
2. 调用所需权限： 根据 Uri 的不同所需的权限有差异。
3. 返回值： 返回一个和 Uri 相关的 Bundle ，该对象一样可以用来操作相关的数据。
4. 已忽略风险： 本方法调用成功的关键是 Uri 对应的 ContentProvider 覆写了同名方法。
    - 然而我们挨个去判断是否覆写了该方法需要的精力太多。
5. 查看逻辑可以知道本方法如果参数都合法的情况下会崩溃崩溃原理同 ： __一、 acquireContentProviderClient(Uri uri)__ 。

## 四、 canonicalize(Uri url) | uncanonicalize(Uri url) 
- Permission Denial
1. 方法声明： Uri canonicalize (Uri url)
2. 调用所需权限： 根据 Uri 的不同所需的权限有差异。

## 五、 String[] getStreamTypes (Uri url, String mimeTypeFilter)
- Permission Denial

调用所需权限： 根据 Uri 的不同所需的权限有差异。

## 六、 openStream
- Permission Denial
1. openInputStream(Uri uri) 
2. openOutputStream(Uri uri) 
3. openOutputStream(Uri uri, String mode) 

## 七、 openFile
- Permission Denial
1. openAssetFileDescriptor(Uri uri, String mode, CancellationSignal cancellationSignal) 
2. openAssetFileDescriptor(Uri uri, String mode) 
3. openFileDescriptor(Uri uri, String mode, CancellationSignal cancellationSignal) 
4. openFileDescriptor(Uri uri, String mode) 
5. openTypedAssetFileDescriptor(Uri uri, String mimeType, Bundle opts, CancellationSignal cancellationSignal) 
6. openTypedAssetFileDescriptor(Uri uri, String mimeType, Bundle opts) 










## 因为成本的原因忽略的部分方法
1. acquireContentProviderClient(String name) 
2. acquireUnstableContentProviderClient(String name) 
3. cancelSync(Uri uri) 
    - cancelSync(android.accounts.Account, String)
    - startSync(Uri uri, Bundle extras) 
4. notifyChange
    - 尝试了初步测试未受权限影响。
5. registerContentObserver(Uri uri, boolean notifyForDescendants, ContentObserver observer) 
6. refresh(Uri url, Bundle args, CancellationSignal cancellationSignal) 
7. releasePersistableUriPermission (Uri uri, int modeFlags)
8. takePersistableUriPermission (Uri uri, int modeFlags)
    - 如果回头探究的话 7 8 请排高优先级，疑似需要权限