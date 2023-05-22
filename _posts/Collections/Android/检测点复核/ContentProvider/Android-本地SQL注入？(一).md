# Android 本地 SQL 注入？

>给自己：关于 Android 安全 ，读一下 《Android 安全攻防实战》 或许会有不一样的体验。

## 一、写在开始
这仅仅是一个实验记录

在之前我们讨论了 `rawQuery / rawQueryWithFactory` 两个 API 所做的注入动作。     
现在我们观察更多的 API 。

## 二、回答标题的(最开始的)问题

## 三、涉及知识点
1. ContentProvider
2. SQLiteOpenHelper


## 四、代码观察
### 4.1、 选取观察目标
我们选定 `SQLiteDatabase.query` 看看 Google 程序员的代码：

query方法重构很多但是最终调用的都是：
```java
    public Cursor query(boolean distinct, String table, String[] columns,String selection, String[] electionArgs, String groupBy,String having, String orderBy, String limit) {
        // ①
        return queryWithFactory(null, distinct, table, columns, selection, selectionArgs,groupBy, having, orderBy, limit, null);
    }
    //接 ①  return queryWithFactory(
    public Cursor queryWithFactory(CursorFactory cursorFactory,
        boolean distinct, String table, String[] columns,
        String selection, String[] selectionArgs, String groupBy,
        String having, String orderBy, String limit, CancellationSignal cancellationSignal) {
        acquireReference();
        try {
            //仅仅是简单拼装SQL语句带有“？”
            String sql = SQLiteQueryBuilder.buildQueryString(
                    distinct, table, columns, selection, groupBy, having, orderBy, limit);
            //执行SQL语句 ②
            return rawQueryWithFactory(cursorFactory, sql, selectionArgs,
                    findEditTable(table), cancellationSignal);
        } finally {
            releaseReference();
        }
    }

    public static String buildQueryString(
            boolean distinct, String tables, String[] columns, String where,
            String groupBy, String having, String orderBy, String limit) {
        if (TextUtils.isEmpty(groupBy) && !TextUtils.isEmpty(having)) {
            throw new IllegalArgumentException(
                    "HAVING clauses are only permitted when using a groupBy clause");
        }
        if (!TextUtils.isEmpty(limit) && !sLimitPattern.matcher(limit).matches()) {
            throw new IllegalArgumentException("invalid LIMIT clauses:" + limit);
        }

        StringBuilder query = new StringBuilder(120);

        query.append("SELECT ");
        if (distinct) {
            query.append("DISTINCT ");
        }
        if (columns != null && columns.length != 0) {
            appendColumns(query, columns);
        } else {
            query.append("* ");
        }
        query.append("FROM ");
        query.append(tables);
        appendClause(query, " WHERE ", where);
        appendClause(query, " GROUP BY ", groupBy);
        appendClause(query, " HAVING ", having);
        appendClause(query, " ORDER BY ", orderBy);
        appendClause(query, " LIMIT ", limit);

        return query.toString();
    }

    private static void appendClause(StringBuilder s, String name, String clause) {
        if (!TextUtils.isEmpty(clause)) {
            s.append(name);
            s.append(clause);
        }
    }

    //接 ② return rawQueryWithFactory(
    public Cursor rawQueryWithFactory( CursorFactory cursorFactory, String sql, String[] selectionArgs,
        String editTable, CancellationSignal cancellationSignal) {
        acquireReference();
        try {
            SQLiteCursorDriver driver = new SQLiteDirectCursorDriver(this, sql, editTable,
                    cancellationSignal);

            //③
            return driver.query(cursorFactory != null ? cursorFactory : mCursorFactory,
                    selectionArgs);
        } finally {
            releaseReference();
        }
    }
    //接 ③  return driver.query(
    public Cursor query(CursorFactory factory, String[] selectionArgs) {
        final SQLiteQuery query = new SQLiteQuery(mDatabase, mSql, mCancellationSignal);
        final Cursor cursor;
        try {
            //替换 ？
            query.bindAllArgsAsStrings(selectionArgs);

            if (factory == null) {
                cursor = new SQLiteCursor(this, mEditTable, query);
            } else {
                cursor = factory.newCursor(mDatabase, this, mEditTable, query);
            }
        } catch (RuntimeException ex) {
            query.close();
            throw ex;
        }

        mQuery = query;
        return cursor;
    }
```
关于SQL语句的拼装仅仅是用了一行代码:
```java
StringBuilder.append();
//重要的是不存在任何筛查，传来什么参数就 append 什么内容。
return StringBuilder.toString();
```
既然 SQL 语句的拼装没有筛查 对于 SQL 语句的执行也不抱希望了，直接做实验吧。

- 后面的代码看下去有些吃力了。

### 4.2、代码流程查看
```java
//我们试试伪代码的方式能否走完该流程
//我们的问题：为什么使用参数化的查询方式能够避免 SQL 注入的发生？
android.database.sqlite.SQLiteDatabase.query(boolean distinct, String table, String[] columns,String selection, String[] selectionArgs, String groupBy, String having, String orderBy, String limit){
  android.database.sqlite.SQLiteDatabase.queryWithFactory(CursorFactory cursorFactory, boolean distinct, String table,String[] columns, String selection, String[] selectionArgs, String groupBy, String having, String orderBy, String limit, CancellationSignal cancellationSignal){
    //传入的参数经过本方法的处理编程带有 ？ 的 SQL 语句。并 return
    android.database.sqlite.SQLiteQueryBuilder.buildQueryString(boolean distinct, String tables, String[] columns, String where, String groupBy, String having, String orderBy, String limit){
      return //传入的参数经过本方法的处理编程带有 ？ 的 SQL 语句。并 return
    }
    android.database.sqlite.rawQueryWithFactory(CursorFactory cursorFactory, String sql, String[] selectionArgs,String editTable, CancellationSignal cancellationSignal){
      //使用 buildQueryString 返回的 SQL 语句继续处理
      SQLiteCursorDriver driver = new SQLiteDirectCursorDriver(this, sql, editTable, cancellationSignal);
      return driver.query(cursorFactory != null ? cursorFactory : mCursorFactory, selectionArgs);
      //上述两句代码所做的事情是：

      //使用 sql 生成一个对象
      android.database.sqlite.SQLiteDirectCursorDriver.SQLiteDirectCursorDriver(SQLiteDatabase db, String sql, String editTable, CancellationSignal cancellationSignal) {
        mDatabase = db;
        mEditTable = editTable;
        mSql = sql;
        mCancellationSignal = cancellationSignal;
      }
      android.database.sqlite.SQLiteDirectCursorDriver.query(CursorFactory factory, String[] selectionArgs){
        final SQLiteQuery query = new SQLiteQuery(mDatabase, mSql, mCancellationSignal);
        query.bindAllArgsAsStrings(selectionArgs);
        //上述两句代码做的事情是：
        android.database.sqlite.SQLiteQuery.SQLiteQuery(SQLiteDatabase db, String query, CancellationSignal cancellationSignal) {
          android.database.sqlite.SQLiteProgram.SQLiteProgram(SQLiteDatabase db, String sql, Object[] prepare, CancellationSignal cancellationSignalForPrepare){
            //这里是关键，本方法所在类中存在属性：我们猜测是把 SQL 语句中的单词按空格给拆分成数组了，接下来验证这个猜想
            //猜想是错的，这里做的事情只是把 selectionArgs 转储到了一个新的数组中。
            private final String mSql;
            private final Object[] mBindArgs;
            android.database.sqlite.SQLiteStatementInfo info = new ……;
            (android.database.sqlite.SQLiteDatabase)db.getThreadSession().prepare(mSql, db.getThreadDefaultConnectionFlags(assumeReadOnly), cancellationSignalForPrepare, info){
              if (mNumParameters != 0) {//如果 sql 语句中携带参数的数目不为 0 ，
                  mBindArgs = new Object[mNumParameters];
                  if (bindArgs != null) {
                      System.arraycopy(bindArgs, 0, mBindArgs, 0, bindArgs.length);
                  }
              } else {
                  mBindArgs = null;
              }
              //不论上述做了什么都无法改变 prepare = null 的事实
              yinwei
            }
            //后文待续
          }
        }
        //query.bindAllArgsAsStrings(selectionArgs); 通过这一句代码吧 参数数组 selectionArgs 放到了 private final Object[] mBindArgs; 中

        // 本方法上半段说完了，下半段
        cursor = new SQLiteCursor(this, mEditTable, query);//这句话做的是一个转储，没有实质性的操作
        return cursor;
      }
      return cursor;//直接 return 上述方法得到的 cursor 。
    }
    return cursor;//直接 return 上述方法得到的 cursor 。
  }
  return cursor;//直接 return 上述方法得到的 cursor 。
}

//从拿到 Cursor 之后 一路 return ，所以真正的查询操作还没有开始，但现在还只是查询动作之前的准备动作，真正的查询就是在 Cursor 中进行啦。
//关于 Cursor 的使用到后面的调用方式是：
private static native String nativeGetString(long windowPtr, int row, int column);
//关于这一举代码，我们暂时没有查看细节
```



### 4.3、试验代码
```java
//这种带？的使用 String[] selectionArgs 参数的调用没有出现问题。
Cursor cursor = sqLiteDatabase.query(TABLE_NAME, null, "name = ?", new String[]{string}, null, null,null);
//String[] selectionArgs 参数为null的调用方式，可以被注入。
Cursor cursor = sqLiteDatabase.query(TABLE_NAME, null, "name = 1 or 1=1 --", null, null, null,null);
```
