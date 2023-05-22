```java
public Cursor query(@NonNull Uri uri, @Nullable String[] projection, @Nullable String selection, @Nullable String[] selectionArgs, @Nullable String sortOrder) 
```
```terminel
//“--projection” 指的是 ContentProvider 子类的 query() 方法中的第二个参数
dz> run app.provider.query content://com.mwr.example.sieve.DBContentProvider/Passwords/ --projection "'"
//“--projection” 指的是 ContentProvider 子类的 query() 方法中的第三个参数
dz> run app.provider.query content://com.mwr.example.sieve.DBContentProvider/Passwords/ --selection "'"
```

```terminal
dz> help app.provider.read
usage: run app.provider.read [-h] uri

Read from the specified content uri using openInputStream

Examples:
Attempt directory traversal on a content provider:

    dz> run app.provider.read
content://settings/secure/../../../system/etc/hosts
    java.io.FileNotFoundException: No files supported by provider at
content://settings/secure/../../../system/etc/hosts

Last Modified: 2012-11-06
Credit: MWR InfoSecurity (@mwrlabs)
License: BSD (3 clause)

positional arguments:
  uri         the content provider URI to read a file through

optional arguments:
  -h, --help
```