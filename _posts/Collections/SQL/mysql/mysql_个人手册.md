前两天学习使用 mysql , 花了听多精力的，几天不看了，已经完全忘记了 。

这里我们做一点笔记。

文档链接 : https://dev.mysql.com/doc/refman/8.0/en/
mysql document : https://dev.mysql.com/doc/
- 页面下拉可以得到 connector 更详细的信息
- Connector/C++ 8.0 Developer Guide : https://dev.mysql.com/doc/connector-cpp/8.0/en/
- Connector/C++ API : https://dev.mysql.com/doc/dev/connector-cpp/8.0/







## [连接/断开 数据库](https://dev.mysql.com/doc/refman/8.0/en/connecting-disconnecting.html)

```
## 连接数据库
mysql --host=172.17.0.3 \ # 指定主机名，本机上的 mysql 服务可以省略； docker mysql container, 可以进入 container 通过 ifconfig 查看 ip
      --user=root       \ # 指定登陆用户
      --password        \ # 指定通过密码登陆， 回车后会索要密码 `Enter password:`

## 断开数据库
$ exit
$ QUIT
```

## 数据操作 [-1-](https://dev.mysql.com/doc/refman/8.0/en/entering-queries.html) [-2-](https://dev.mysql.com/doc/refman/8.0/en/database-use.html) [-3-](https://dev.mysql.com/doc/refman/8.0/en/batch-mode.html)

在连接数据库成功后， 数据操作动作通过以 分号 `;` 结尾的 sql 完成

```sql
mysql> SELECT VERSION(), CURRENT_DATE;
+-----------+--------------+
| VERSION() | CURRENT_DATE |
+-----------+--------------+
| 5.8.0-m17 | 2015-12-21   |
+-----------+--------------+
1 row in set (0.02 sec)
mysql>
```


除了一条语句一条语句的数据库操作，还可以通过 mysql 语句的集合(脚本)进行数据操作。

```
# 当没有连接到数据库的情况下执行 mysql 脚本
$> mysql --host=172.17.0.3 --user=root  --password  <  script.mysql
Enter password: ********

# 当处于 mysql 交互模式下，执行 mysql 脚本, 注意分号结尾。
mysql> source script.mysql;

# 查询数据库中的所有表
mysql> SHOW DATABASES;
+--------------------+
| Database           |
+--------------------+
| information_schema |
| mysql              |
| nameless_carpool   |
| performance_schema |
| sys                |
+--------------------+
5 rows in set (0.01 sec)

mysql> USE nameless_carpool 
Database changed

mysql> SHOW TABLES;
+----------------------------+
| Tables_in_nameless_carpool |
+----------------------------+
| area                       |
| car                        |
| car_bind_customers         |
| find_car                   |
| find_customers             |
| goods_info                 |
| telephone                  |
| user                       |
| user_area                  |
| user_tel                   |
| wc_user                    |
+----------------------------+
11 rows in set (0.01 sec)


# show 语法细节 : https://dev.mysql.com/doc/refman/8.0/en/show.html
# 查看表结构-表格形式，带注释
show full columns from tableName;
# 查看表结构-建表语句，带注释
show create table tableName;
# 简单查看表结构
desc tableName;


# 删除数据库

mysql> DROP DATABASE IF EXISTS `nameless_carpool`;

# 删除一直无法完成可以尝试先杀死对 mysql 的使用进程
# https://dba.stackexchange.com/a/37646
$ mysqladmin processlist -u root -p
$ mysqladmin kill 174 -u root -p
```

### mysql 交互模式

mysql 命令自动补全方案
1. 官方自带自动补全能力
2. 三方工具 mycli

官方能力 [--auto-rehash](https://dev.mysql.com/doc/refman/8.0/en/mysql-command-options.html)


用户管理

基本配置项




## mysql C++ [编程接口](https://dev.mysql.com/doc/refman/8.0/en/connectors-apis.html)

下载 linux 连接器 安装包 : https://dev.mysql.com/downloads/connector/cpp/

但是有许多包 , 看不懂差异 , 不了解应该下载哪个

(libmysqlcppconn9_8.0.29-1debian11_amd64.deb)
(libmysqlcppconn8-2_8.0.29-1debian11_amd64.deb)
(libmysqlcppconn-dev_8.0.29-1debian11_amd64.deb)
(libmysqlcppconn9-dbgsym_8.0.29-1debian11_amd64.deb)
(libmysqlcppconn8-2-dbgsym_8.0.29-1debian11_amd64.deb)
(libmysqlcppconn8-2-dbgsym_8.0.29-1debian11_amd64.deb)

还有 tar 的发行形式, 我们选择二进制压缩包吧 . 这个只有一个不会选择困难 . 


### [使用编程接口有一些注意事项](https://dev.mysql.com/doc/connector-cpp/8.0/en/connector-cpp-apps-general-considerations.html)
1. 重要的是，您用于构建连接器/C++ 应用程序的工具与用于构建连接器/C++ 本身的工具兼容。
   - 编译器版本 - 可以再发行包中 `INFO_BIN / INFO_SRC` 查看
   - 运行时库
   - 运行时链接器配置设置
2. 一般来说，C++ 库二进制文件的可移植性不如 C 库二进制文件。问题可能是由于名称修改、不同的标准模板库 (STL) 版本以及使用不同的编译器和链接器来链接库而不是用于构建库本身。
3. 即使是编译器版本的微小变化也可能导致问题。如果您收到怀疑与二进制不兼容有关的错误消息，请使用与构建和链接应用程序相同的编译器和链接器从源代码构建连接器/C++。
4. 为避免潜在的崩溃，Connector/C++ 的构建配置应与使用它的应用程序的构建配置相匹配。例如，不要将 Connector/C++ 的发布版本与客户端应用程序的调试版本一起使用。
5. 看来我们大概率还是要为自己的开发环境编译 mysql 连接器 库了.
6. 至于 api 文档 , 直接放到了源码仓库说明里 : https://github.com/mysql/mysql-connector-cpp -> https://dev.mysql.com/doc/dev/connector-cpp/8.0/


### mysql C++ 编程接口

涉及到几个概念
1. Session , 会话 , 理解为与 mysqlDB 建立的连接, 一个链接可以称之为一个会话.
2. Scheme , 在 mysql 中, 与 Database 含义相同 , 就是 `CREATE SCHEME` / `CREATE DATABASE` 含义相同 
            可以理解为, 数据库中的实际数据库对象.
3. Table , 略 .
4. Client , 理解为连接服务器的客户端 .


### connector C++ 自行编译失败
在 docker 容器里编译 , 对内存的需求峰值是 12 G , 给定这个内存前大概率编译到 80% 事后抛异常 :
```
c++: fatal error: Killed signal terminated program cc1plus
```

尝试控制编译器的线程无效 , 直到最后增加了容器内存才编译通过
1. `cmake --parallel 1`
2. 修改 CMakeLists.txt 增加文本 `set(CMAKE_MAKE_PROGRAM make --job=1)` 无效

### connector C++ 编译动态库

安装到指定文件夹后 , 直接编译自己的程序 会提示找不到 so , 因为我们把 so 放到了自定义路径下 . 

```
tom@cxxEnv ➜  sources pwd
/mount_point/data/_document/sources
tom@cxxEnv ➜  sources ls -al
total 34384
drwxr-xr-x 12 tom TOM      384  7月 25 12:50 .
drwxr-xr-x  9 tom TOM      288  7月 21 09:57 ..
drwxr-xr-x 31 tom TOM      992  7月 25 13:00 mysql-connector-cpp                 # 源码文件夹
drwxr-xr-x 24 tom TOM      768  7月 25 13:54 mysql-connector-cpp-build           #  编译结果文件夹
drwxr-xr-x 22 tom TOM      704  7月 25 10:11 mysql-connector-cpp-build-static    #
drwxr-xr-x  6 tom TOM      192  7月 25 13:54 mysql-connector-cpp-install         #  安装文件夹
tom@cxxEnv ➜  sources 

----------------

tom@cxxEnv ➜ cd /mount_point/data/_document/sources
tom@cxxEnv ➜ cmake -S ./mysql-connector-cpp  -B ./mysql-connector-cpp-build 
      -DCMAKE_INSTALL_PREFIX=/mount_point/data/_document/sources/mysql-connector-cpp-install
      -DCMAKE_BUILD_TYPE=RelWithDebInfo
tom@cxxEnv ➜  sources cmake --build ./mysql-connector-cpp-build 
tom@cxxEnv ➜  sources cmake --install ./mysql-connector-cpp-install
```

### connector C++ 编译静态库

编辑静态库成功

```
tom@cxxEnv ➜  sources pwd
/mount_point/data/_document/sources

tom@cxxEnv ➜  sources cmake 
                  -S ./mysql-connector-cpp  
                  -B ./mysql-connector-cpp-build-static 
                  -DCMAKE_INSTALL_PREFIX=/mount_point/data/_document/sources/mysql-connector-cpp-build-static-install 
                  -DCMAKE_BUILD_TYPE=RelWithDebInfo  
                  -DBUILD_STATIC=ON


tom@cxxEnv ➜  sources cmake --build ./mysql-connector-cpp-build-static
tom@cxxEnv ➜  sources cmake --install ./mysql-connector-cpp-build-static  
```

静态链接库是 `.a` 文件

使用静态库有两种方式
1. 直接把调用者源代码和静态库文件名一起编译 
    `g++ -o book265 book265.cpp libpublic.a`
2. 采用L参数指定静态库文件的目录，-l参数指定静态库名
    `g++ -o book265 book265.cpp -L/home/wucz/demo -lpublic`

实际上这个静态库有依赖了一些已经安装到系统的库文件 , 所以不适用这个动态库, 就要在编译阶段指定它所需要的其他动态库
`-lssl -lcrypto -lpthread -lresolv`

**参考 :**
1. https://www.freecplus.net/05944de09a3942a89a571d523712b548.html
2. [动态库没写全编译不过](https://forums.mysql.com/read.php?167,686070,686070)


### C++ 操作 mysql 的便捷库

我们的需求
1. 关系型数据库简单的对象化, 针对单个表完成对象化
2. 针对多个表 , 没有也行


## [事务](https://dev.mysql.com/doc/refman/8.0/en/commit.html)
有多条先关的 sql 语句 . 我们希望 : 要么都成功 , 要么都失败 . 这时候会使用 事务
```SQL
START TRANSACTION;

# other sql statement

COMMIT;
```

mysql 事务有个默认设置 `autocommit` : 
```
SET autocommit = 0;     # 禁止自动提交 , 持续生效到标示符被修改
SET autocommit = 1;     
# 标志为连接专用    autocommit标志是针对每个连接而不是服务器的。
```

使用 `START TRANSACTION;` 默认禁用自动提交

存储过程对也可以达到相同的目的
1. https://stackoverflow.com/a/32955274/7707781
2. https://dev.mysql.com/doc/refman/8.0/en/stored-routines.html





