## 一、 ContentProvider 概念 & 作用
为存储和获取数据提供统一的接口。可以在不同的应用程序之间共享数据。Android已经为常见的一些数据提供了默认的ContentProvider。
## 二、 ContentProvider 使用
java类
```java
public class MyContentProvider extends ContentProvider {
    @Override
    public boolean onCreate() {
        return false;
    }

    @Nullable
    @Override
    public Cursor query(@NonNull Uri uri, @Nullable String[] projection, @Nullable String selection, @Nullable String[] selectionArgs, @Nullable String sortOrder) {
        return null;
    }

    @Nullable
    @Override
    public String getType(@NonNull Uri uri) {
        return null;
    }

    @Nullable
    @Override
    public Uri insert(@NonNull Uri uri, @Nullable ContentValues values) {
        return null;
    }

    @Override
    public int delete(@NonNull Uri uri, @Nullable String selection, @Nullable String[] selectionArgs) {
        return 0;
    }

    @Override
    public int update(@NonNull Uri uri, @Nullable ContentValues values, @Nullable String selection, @Nullable String[] selectionArgs) {
        return 0;
    }
}
```
AndroidManifest.xml 文件 `<provider>` 节点
```xml
<provider android:authorities="list"
          android:directBootAware=["true" | "false"]
          android:enabled=["true" | "false"]
          android:exported=["true" | "false"]
          android:grantUriPermissions=["true" | "false"]
          android:icon="drawable resource"
          android:initOrder="integer"
          android:label="string resource"
          android:multiprocess=["true" | "false"]
          android:name="string"
          android:permission="string"
          android:process="string"
          android:readPermission="string"
          android:syncable=["true" | "false"]
          android:writePermission="string" >
    . . .
</provider>
```

## 三、 配置风险
__状况一、__ 权限未设置：
- android:permission="string"
- android:readPermission="string"
- android:writePermission="string"     

上述三个权限均未设置的情况下 `grantUriPermissions` 属性的值不在具有意义。因为没有权限壁垒那么无所谓是否临时授予权限。

## 四、编码风险
那么一个没有权限壁垒的应用有没有更深层次的安全问题呢？
1. 首先我们考虑实质性的SQL注入，这会需要一个实验：[Android-本地SQL注入？.md](Android-本地SQL注入？.md)

2. 来考虑和 SQL 注入相关的 API ：SQLiteDatabase。
    1. public void execSQL(String sql)
    2. public void execSQL(String sql, Object[] bindArgs)
    - 说明：上述 API 返回值 void 所以通过上述 API 能做的只有注入非法数据。
        - 关于注入非法数据的动作尚待验证。

    1. public Cursor rawQuery(String sql, String[] selectionArgs)
    2. public Cursor rawQuery(String sql, String[] selectionArgs, CancellationSignal cancellationSignal)
    3. public Cursor rawQueryWithFactory(CursorFactory cursorFactory, String sql, String[] selectionArgs,String editTable)
    4. public Cursor rawQueryWithFactory(CursorFactory cursorFactory, String sql, String[] selectionArgs,String editTable, CancellationSignal cancellationSignal)
    - 关于上述 4 个方法的说明。
        - 运行给定的 SQL 语句，并且把执行结果通过 Cursor 返回。
        - __sql:__ 要执行的 SQL 代码，禁止以 “;” 结束 SQL 代码字符串。
        - __selectionArgs:__ (翻译：选择参数) 参数 __sql__ 中可以包含 “？” ，如果包含的话，其中的 ？ 将会按照顺序被 'String[]' 中的值替换。
        - __cancellationSignal__ (翻译：消除信号) 一个用于取消操执行 SQL 这个动作的信号，可以不设置这个信号(null)。如果一个执行 SQL 语句的动作被取消，那么一个 OperationCanceledException 将被抛出。
        - __cursorFactory:__ SQLiteDatabase.CursorFactory 或者 null。(作用就是创建返回值)
        - __editTable:__ 优先修改的表名。(还不太理解不过不影响当前目标)
        - 关于 rawQuery 和 rawQueryWithFactory 实际上最终调用的都是 rawQueryWithFactory 。

    1. public Cursor query(boolean distinct, String table, String[] columns, String selection, String[] selectionArgs, String groupBy, String having, String orderBy, String limit)
        - query() 有多个重构，实际上到最后无一不是调用本方法。
        1. distinct，boolean: true if you want each row to be unique, false otherwise.（设置为true,每一行的数据必须唯一。反之亦然。）
        2. table，String: The table name to compile the query against.（query函数要操作的表名。）
        3. columns，String[]: A list of which columns to return. Passing null will return all columns, which is discouraged to prevent reading data from storage that isn’t going to be used.（要返回的列的名字的数组。如果设置为null，返回所有列，如果不需要使用所有列，不建议这么做。）
        4. selection，String: A filter declaring which rows to return, formatted as an SQL WHERE clause (excluding the WHERE itself). Passing null will return all rows for the given table.（一个决定返回哪一行的过滤器，相当于SQL语句中的 WHERE 关键字。传递null则会返回给定表的所有行。）
        5. selectionArgs，String: You may include ?s in selection, which will be replaced by the values from selectionArgs, in order that they appear in the selection. The values will be bound as Strings.（用于替换上一个参数中的 ？ ,顺序对应selection中？的顺序。格式限制为String格式。）
        6. groupBy，String: A filter declaring how to group rows, formatted as an SQL GROUP BY clause (excluding the GROUP BY itself). Passing null will cause the rows to not be grouped.（用于设定返回行的分组方式，相当于SQL语句中的GROUP BY 关键字。传递null表示返回的行不会被分组。）
        7. having，String: A filter declare which row groups to include in the cursor, if row grouping is being used, formatted as an SQL HAVING clause (excluding the HAVING itself). Passing null will cause all row groups to be included, and is required when row grouping is not being used.（决定哪一行被放到Cursor中的过滤器。如果使用了行分组，相当于SQL语句中的HAVING关键字。传递null会导致所有的行都包含在内，前提是groupBy属性也设置为null。）
        8. orderBy，String: How to order the rows, formatted as an SQL ORDER BY clause (excluding the ORDER BY itself). Passing null will use the default sort order, which may be unordered.（行的排列方式，相当于SQL语句中的“ORDER BY”关键字，传递null表示使用默认的排序方式，可能是无序排列。）
        9. limit，String: Limits the number of rows returned by the query, formatted as LIMIT clause. Passing null denotes no LIMIT clause.（设置query语句返回行的数量，相当于SQL语句中的“LIMIT”关键字，传递null表示没有设置limit语句。注意格式为String,传递的时候需要传递数字字符串，例如“12”）

## 五、风险总结
根据实验 -1)[Android-本地SQL注入？.md](Android-本地SQL注入？.md)   -2)[Android-本地SQL注入？(一).md](Android-本地SQL注入？(一).md)    -3)上述分析
1. `execSQL` 使用不当可以执行恶意 SQL 代码，危害性暂未量化。
    - execSQL不具备返回数据的能力。
    - 建议使用 Android 提供的参数化方式操作数据库。
2. `rawQuery / rawQueryWithFactory` 可以注入恶意命令：常见的使用方式为获取权限之外的数据。
    - 建议使用 Android 提供的参数化方式操作数据库。
3. `query` 可以注入恶意命令
    1. 这就是 Android 提供的参数化方式操作数据库。
    2. 对于ContentProvider 来讲，如果完全信任外部应用，使用这种方式也不能完全避免 SQLInject
        - SQLInject 会发生在 直接使用 `selection` 参数 (`selectionArgs=null`)
        - 其他注入角度暂未探究。

了解到
- sqlite 在 Linux 不具备执行系统命令的能力。
- sqlite 不具备类似 oracle ";" 分隔执行多语句的能力。

修复建议
- 在通过 `<provider>` 合理限制权限的前提下通过参数化查询方式使用 ContentProvider


## 参考 & 引用：
1. [深入理解Android四大组件之一ContentProvider](http://blog.csdn.net/hehe26/article/details/51784355)
2. [Android API 指南清单文件](https://developer.android.google.cn/guide/topics/manifest/provider-element.html)
    - 2.1、 [Android Provider 属性](http://blog.csdn.net/peng_cao/article/details/50747694)
    - 2.2、 [Android开发-API指南-`<provider>`](http://www.cnblogs.com/popapa/p/android_provider-element.html)
    - 2.3、 [Android Manifest之<provider>元素中文注释](http://blog.csdn.net/jewleo/article/details/8939104)
    - 2.4、 [Android清单文件中相关属性含义（Provider）](http://blog.csdn.net/berber78/article/details/39252727)
3. [ android 7.0 加入 android:directBootAware ](http://blog.csdn.net/sergeycao/article/details/53636509)
4. [利用SQLiteDatabase 对象操作数据库（1）  ](http://zhangguofuwangyi.blog.163.com/blog/static/171759487201010279176503/)
