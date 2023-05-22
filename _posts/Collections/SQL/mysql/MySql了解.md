


## 关于 版本 选择
1. 担心 ， 8.0.x 是否稳定 ， 担心 Oracle 是否在社区版投入足够的资源维护和解决问题 。
2. 担心用新版本的开发者基数是否足够大 ， 如果开发者基数小 ， 可能会碰到其他人都没碰到过的问题。
3. 向来想去没有答案 ， 就先尝试通读下文档把 [Supported Platforms: MySQL Database](https://www.mysql.com/support/supportedplatforms/database.html)
    - debian10 支持到了 5.7
    - debian11 只支持 8.0
    - 所以随着时间的推移 2023 年 5.7 停止维护 ， 其他软件产品却不断更新 ， 除非有一个从 5.7 开始维护的与时俱进的分支 ， 否则必然开始跟随 8.0 。

## mysql 安装

操作系统 ： Debian 11
```
➜  ~ cat /etc/os-release
PRETTY_NAME="Debian GNU/Linux 11 (bullseye)"
NAME="Debian GNU/Linux"
VERSION_ID="11"
VERSION="11 (bullseye)"
VERSION_CODENAME=bullseye

➜  ~ uname -a
Linux tencentVPS 5.10.0-12-amd64 #1 SMP Debian 5.10.103-1 (2022-03-07) x86_64 GNU/Linux

```

遵循官方教程 预期要安装 MySql8.0 

‵sudo dpkg -i mysql-apt-config_w.x.y-z_all.deb‵  > 这会导致我们进入一个循环

循环页面1 ：

我 选中第一条 并 通过 tab + enter 选中 `<OK>` ， 进入循环页面 2
```
Package configuration

  ┌───────────────────────┤ Configuring mysql-apt-config ├───────────────────────┐
  │ MySQL APT Repo features MySQL Server along with a variety of MySQL           │ 
  │ components. You may select the appropriate product to choose the version     │ 
  │ that you wish to receive.                                                    │ 
  │                                                                              │ 
  │ Once you are satisfied with the configuration then select last option 'Ok'   │ 
  │ to save the configuration, then run 'apt-get update' to load package list.   │ 
  │ Advanced users can always change the configurations later, depending on      │ 
  │ their own needs.                                                             │ 
  │                                                                              │ 
  │ Which MySQL product do you wish to configure?                                │ 
  │                                                                              │ 
  │      > 1. MySQL Server & Cluster (Currently selected: mysql-8.0)             │ 
  │        2. MySQL Tools & Connectors (Currently selected: Enabled)             │ 
  │        3. MySQL Preview Packages (Currently selected: Disabled)              │ 
  │        4. Ok                                                                 │ 
  │                                                                              │ 
  │                                                                              │ 
  │                                    <Ok>                                      │ 
  │                                                                              │ 
  └──────────────────────────────────────────────────────────────────────────────┘ 
```

循环页面2

我 选中第一条 并 通过 tab + enter 选中 `<OK>` ， 进入循环页面 1
```
Package configuration

 ┌───────────────────────┤ Configuring mysql-apt-config ├────────────────────────┐
 │ This configuration program has determined that no MySQL Server is configured  │ 
 │ on your system, and has highlighted the most appropriate repository package.  │ 
 │ If you are not sure which version to install, do not change the               │ 
 │ auto-selected version. Advanced users can always change the version as        │ 
 │ needed later. Note that MySQL Cluster also contains MySQL Server.             │ 
 │                                                                               │ 
 │ Which server version do you wish to receive?                                  │ 
 │                                                                               │ 
 │                         > 1. mysql-8.0                                        │ 
 │                           2. mysql-cluster-8.0                                │ 
 │                           3. None                                             │ 
 │                                                                               │ 
 │                                                                               │ 
 │                                    <Ok>                                       │ 
 │                                                                               │ 
 └───────────────────────────────────────────────────────────────────────────────┘ 
```


以上循环没有终点 ， 直到我在循环页面一 ， 选中 第`4`条 并执行   ‵<OK>‵ , 才跳出循环 。

这个现象不止我碰到 ： https://askubuntu.com/q/1156209/872912

跳出循环会注意到两条警告信息
```
1. Warning: apt-key should not be used in scripts (called from postinst maintainerscript of the package mysql-apt-config)
    apt-key 不应在脚本中使用（包 mysql-apt-config 的 postinst 调用了）
    不应该在脚本中使用此命令 ， 但是警告不是错误，用就用了
2. Warning: apt-key is deprecated. Manage keyring files in trusted.gpg.d instead (see apt-key(8)).
    警告： apt-key 已弃用。 改为在trusted.gpg.d 中管理密钥环文件（参见apt-key(8)）。
    此命令将被弃用，但是目前还是可用的 ， 用就用了 ： https://techviewleo.com/apt-key-is-deprecated-manage-keyring-files-in-trusted-gpg-dot-d/
```

跳出循环检查下 mysql apt 源的配置情况
```
➜  ~ cat /etc/apt/sources.list.d/mysql.list
### THIS FILE IS AUTOMATICALLY CONFIGURED ###
# You may comment out entries below, but any other modifications may be lost.
# Use command 'dpkg-reconfigure mysql-apt-config' as root for modifications.
deb http://repo.mysql.com/apt/debian/ bullseye mysql-apt-config
deb http://repo.mysql.com/apt/debian/ bullseye mysql-8.0
deb http://repo.mysql.com/apt/debian/ bullseye mysql-tools
#deb http://repo.mysql.com/apt/debian/ bullseye mysql-tools-preview
deb-src http://repo.mysql.com/apt/debian/ bullseye mysql-8.0


➜  ~ apt-key list
Warning: apt-key is deprecated. Manage keyring files in trusted.gpg.d instead (see apt-key(8)).
/etc/apt/trusted.gpg
--------------------
pub   rsa4096 2021-12-14 [SC] [expires: 2023-12-14]
      859B E8D7 C586 F538 430B  19C2 467B 942D 3A79 BD29
uid           [ unknown] MySQL Release Engineering <mysql-build@oss.oracle.com>
sub   rsa4096 2021-12-14 [E] [expires: 2023-12-14]

/etc/apt/trusted.gpg.d/debian-archive-bullseye-automatic.gpg
------------------------------------------------------------

➜  ~ sudo apt update 
➜  ~ apt search mysql-server
➜  ~ sudo apt-get install mysql-server
```

虽然有一点点疑惑但是解决了，可以继续进行


docker container 安装 musql-server 之后，有一个问题暂未解决
```
$ service mysql status 
mysql: unrecognized service
```


## 安装完成·[初始化数据目录](https://dev.mysql.com/doc/refman/8.0/en/data-directory-initialization.html)

MySQL安装完成后，必须初始化数据目录，包括mysql系统schema中的表：
- 对于某些 MySQL 安装方法，数据目录初始化是自动的，如 第 2.10 节，“安装后设置和测试”中所述。
    - 如何判断我们的数据目录是否需要手动初始化？
    - 通过 `man mysqld` 命令可以看到一些配置文件，但是不足以判断是否已经完成了初始化动作。
- 对于其他安装方法，您必须手动初始化数据目录。

我们既然不知道如何判断是否完成了初始化 ， 就先假装初始化已经完成 ， 后续遇到异常与阻力再会看。

当继续往后读的时候倾向于认为数据目录已经配置完成了 ， 主要通过如下信息判断 ：

0. `man mysqld`
    ```
    The mysqld program has many options that can be specified at startup. For a complete list of options, run this command: 
    mysqld --verbose --help
    ```
1. `mysqld --verbose --help` 
    ```
    ....
    Default options are read from the following files in the given order:
    /etc/my.cnf /etc/mysql/my.cnf ~/.my.cnf
    ....
    ```
3. 逐个文件内容查看最终找到 
    ‵‵‵
    cat /etc/mysql/my.cnf

    !includedir /etc/mysql/conf.d/              #要搜索 /etc/mysql/conf.d/ 目录并读取在那里找到的选项文件
    !includedir /etc/mysql/mysql.conf.d/

    cat /etc/mysql/mysql.conf.d/mysqld.cnf

    [mysqld]
    pid-file        = /var/run/mysqld/mysqld.pid
    socket          = /var/run/mysqld/mysqld.sock
    datadir         = /var/lib/mysql
    log-error       = /var/log/mysql/error.log

    ‵‵‵

`datadir` 即为在初始化目录章节提到的关键字


## mysql 文档标记
1. Mysql 和 sql 的差异介绍 ： https://dev.mysql.com/doc/refman/8.0/en/compatibility.html
2. sql 和 mysql 语法的学习资源 ： SQL必知必会（第5版）/MySQL必知必会/mysqsl文档


## 尝试 理解 mysql / mysqld / mysqladmin 命令的异同

有了对比的视角再尝试阅读 https://dev.mysql.com/doc/refman/8.0/en 文档的 4 / 5 / 6 章节或许可以找到答案。

其中 mysql 程序概述 ，中有对于不同程序的分类与功能描述 ： https://dev.mysql.com/doc/refman/8.0/en/programs-overview.html

1. mysql 是可以连接到 本地/远程 mysql server 的客户端程序 。 
2. mysqld 是 mysql server 的守护进程（也就是说它是 mysql server）。
          要想 mysql 客户端可以连接到 mysql 服务器 mysqld 进程必须处于存活状态。
    当然 mysql server 的启动方式不只有通过 mysqld 命令 还可以 [Managing MySQL Server with systemd](https://dev.mysql.com/doc/refman/8.0/en/using-systemd.html) : 
         `service mysql start` /
         `systemctl start mysql.service`
3. mysqladmin 是用于执行管理操作的客户端。您可以使用它来检查服务器的配置和当前状态，创建和删除数据库等等。

当然还有其他许多命令行程序 ， 其作用了， 详细阅读文档均有详细描述 。

## 尝试理解 mysql 的默认配置管理模式
在创建数据库的时候我们需要指定数据库的字符集 ， 又想到 ：   
1. 那默认字符集是什么
2. 默认字符集如何自定义

关于 配置 mysql 的文章 ： https://dev.mysql.com/doc/refman/8.0/en/server-configuration.html

通过 `mysqld --verbose --help` 可以观察到 `mysql` 配置文件都有那些。
```
Default options are read from the following files in the given order:                                 
/etc/my.cnf /etc/mysql/my.cnf ~/.my.cnf      
```

配置文件中又指引我们查看全部系统配置文档 ： https://dev.mysql.com/doc/refman/8.0/en/server-system-variables.html

现在可以回答默认字符集是什么的问题了 ， 在全部系统变量配置文档中可以看到变量的默认值们 检索关键字 `character_set` 即可
```
# zsh + tmux + mysql 
show variables;
ctrl+s 输入 character_set , n 向下搜索 ， shift+n 向上搜索
```


要在某个机器上配置某个字符集变量 ， 需要在配置文件中添加配置即可 。 


## 使用 mysql 命令连接到 mysql server 后， 我们可以 show 各种数据。这个 show 是什么 ？
查看关于 SHOW 的细节 ：
```
mysql> ? SHOW
```

除了命令行展示出来的描述信息 ， 也给了一个文档连接：https://dev.mysql.com/doc/refman/8.0/en/extended-show.html   

每个 mysql 实例都持有一个 `INFORMATION_SCHEMA` 表 ， show 展示的信息这里都有 。


## Mysql 配置选项 sql_model
Mysql 的行为 受 sql_model 配置变量的重大影响 ； 

例如当尝试插入溢出值的 sql 语句是应该记录异常并插入截断后的值，还是应该直接报错拒绝工作。

听起来像是报错好些 ， 但是相对复杂的工况下 ， 可能有不同的选择。

具体细节查看 ： https://dev.mysql.com/doc/refman/8.0/en/sql-mode.html



```
# 我认为我这个默认配置也还可以。
mysql> SHOW VARIABLES LIKE 'sql_mode';
--------------
SHOW VARIABLES LIKE 'sql_mode'
--------------

+---------------+-----------------------------------------------------------------------------------------------------------------------+
| Variable_name | Value                                                                                                                 |
+---------------+-----------------------------------------------------------------------------------------------------------------------+
| sql_mode      | ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION |
+---------------+-----------------------------------------------------------------------------------------------------------------------+
1 row in set (0.00 sec)
```


## mysql 建表 数据类型选择和限制

https://dev.mysql.com/doc/refman/8.0/en/data-types.html


## mysql c++ connector 了解
- 官方说明文档 : https://dev.mysql.com/doc/connector-cpp/8.0/en/
- 源代码 : https://github.com/mysql/mysql-connector-cpp
    - 接口文档 : https://dev.mysql.com/doc/dev/connector-cpp/8.0/

在了解 raw 类型的 date 数据 如何处理的时候找到一下几个链接非常有用
- https://stackoverflow.com/q/68884182/7707781
- https://stackoverflow.com/q/71547301/7707781
- https://dev.mysql.com/doc/dev/mysql-server/latest/
    - https://dev.mysql.com/doc/dev/connector-cpp/8.0/classmysqlx_1_1abi2_1_1r0_1_1_row.html


