

```sql
# 异常查询语句
mysql> SELECT * FROM 'nameless_carpool.user';
ERROR 1064 (42000): You have an error in your SQL syntax; check the manual that corresponds to your MySQL server version for the right syntax to use near ''nameless_carpool.user'' at line 1

# 正常查询语句
mysql> SELECT * FROM nameless_carpool.user;
mysql> SELECT * FROM `nameless_carpool`.`user`;
```

mysql 引号是什么含义 , 为什么增加了 引号 的语法被认为是错误的 ? 
- 增加了单引号会被理解为一个字符串 , 一般用于值的表示.

反引号的含义和作用
- 如果语句中的字符包含了 mysql 内建的 特殊字符或保留字 , 应该使用反引号 . 
  例如 SELECT 是保留字 , 使用它做表明或者列名的时候就应该用   ```  `SELECT`  ```
- [这里搜索 `backticks` 可以找到官方释义](https://dev.mysql.com/doc/refman/8.0/en/glossary.html)



## Mysql 中 关于字符串类型的理解

摘录自 : https://dev.mysql.com/doc/refman/8.0/en/string-type-syntax.html

- CHAR[(M)] 

  一个固定长度的字符串，在存储时总是用空格右填充到指定的长度。 M表示以字符为单位的列长度。的范围M是 0 到 255。如果M省略，则长度为 1。

- VARCHAR(M)

  一个可变长度的字符串。M 表示以字符为单位的最大列长度。
  这个 M 的取值还需要一点前置信息才好设定 . 
  VARCHAR 最多存储 65535 个字节 :
    - 实际 M 收到最大字节数和字符集两个因素影响
    - utf8mb3 字符集每个字符最多需要三个字节 , 左右 M 最大为 21,844 比较合适
    - utf8mb4 字符集每个字符最多需要四个字节 , 左右 M 最大为 16,383 比较合适
  
  的范围M是 0 到 65,535。的有效最大长度  VARCHAR 取决于最大行大小（65,535 字节，在所有列之间共享）和使用的字符集。例如， utf8mb3 每个字符最多需要三个字节，因此 可以将 VARCHAR 使用该 utf8mb3 字符集的列声明为最多 21,844 个字符。

- 其他类型 略 


## 创建表 给定 默认值 
```sql
CREATE TABLE IF NOT EXISTS `telephone` (
  `id`                  INTEGER             NOT NULL  AUTO_INCREMENT                COMMENT '主键 id 自增',
  `number`              VARCHAR(255)            NULL                                COMMENT '手机号',
  `for_login`           TINYINT             NOT NULL                    DEFAULT 0   COMMENT '用于登录否  , 0 false, 1 true',
  `vertify_code`        VARCHAR(255)            NULL                                COMMENT '验证码',
  `desc`                VARCHAR(255)            NULL                                COMMENT '描述信息',
  
  `vc_update_time`      DATETIME(6)         NOT NULL                                COMMENT '验证码更新时间',
  `vc_update_time_tz`   TINYINT             NOT NULL                                COMMENT '时区',
  `create_time`         DATETIME(6)         NOT NULL                                COMMENT '创建时间',
  `create_time_tz`      TINYINT             NOT NULL                                COMMENT '时区',
  `update_time`         DATETIME(6)         NOT NULL                                COMMENT '更新时间',
  `update_time_tz`      TINYINT             NOT NULL                                COMMENT '时区',
  `del_time`            DATETIME(6)             NULL                                COMMENT '删除时间',
  `del_time_tz`         TINYINT                 NULL                                COMMENT '时区',

  PRIMARY KEY (`id`)
) COMMENT '手机号';
```


## 理解SQL表连接（join）: https://blog.csdn.net/wry2008wry/article/details/108827070


```sql

  # 连接多个表 , 拷贝自 : https://blog.csdn.net/qq_26593881/article/details/52104699

 连接两个数据表的用法：
 FROM Member INNER JOIN MemberSort ON Member.MemberSort=MemberSort.MemberSort
 语法格式可以概括为：
 FROM 表1 INNER JOIN 表2 ON 表1.字段号=表2.字段号

 连接三个数据表的用法：
 FROM (Member INNER JOIN MemberSort ON Member.MemberSort=MemberSort.MemberSort) INNER JOIN MemberLevel ON Member.MemberLevel=MemberLevel.MemberLevel
 语法格式可以概括为：
 FROM (表1 INNER JOIN 表2 ON 表1.字段号=表2.字段号) INNER JOIN 表3 ON 表1.字段号=表3.字段号

 连接四个数据表的用法：
 FROM ((Member INNER JOIN MemberSort ON Member.MemberSort=MemberSort.MemberSort) INNER JOIN MemberLevel ON Member.MemberLevel=MemberLevel.MemberLevel) INNER JOIN MemberIdentity ON Member.MemberIdentity=MemberIdentity.MemberIdentity
 语法格式可以概括为：
 FROM ((表1 INNER JOIN 表2 ON 表1.字段号=表2.字段号) INNER JOIN 表3 ON 表1.字段号=表3.字段号) INNER JOIN 表4 ON Member.字段号=表4.字段号

 连接五个数据表的用法：
 FROM (((Member INNER JOIN MemberSort ON Member.MemberSort=MemberSort.MemberSort) INNER JOIN MemberLevel ON Member.MemberLevel=MemberLevel.MemberLevel) INNER JOIN MemberIdentity ON Member.MemberIdentity=MemberIdentity.MemberIdentity) INNER JOIN Wedlock ON Member.Wedlock=Wedlock.Wedlock
 语法格式可以概括为：
 FROM (((表1 INNER JOIN 表2 ON 表1.字段号=表2.字段号) INNER JOIN 表3 ON 表1.字段号=表3.字段号) INNER JOIN 表4 ON Member.字段号=表4.字段号) INNER JOIN 表5 ON Member.字段号=表5.字段号

```

## mysql 如何存储 时间+时区 

参考内容: 
1. https://stackoverflow.com/a/59004019/7707781
2. https://en.wikipedia.org/wiki/List_of_tz_database_time_zones
3. https://www.vertabelo.com/blog/the-proper-way-to-handle-multiple-time-zones-in-mysql/

不同地区相对于0时区的时间偏移不总是整小时数 , 所以用 int 表示时区是不合理的做法 . 

另外 , 一个 地区/位置 的时间偏移量会由于 夏令时/冬令时 的机制而发生变化 , 所以用整数表示时区也是不合理的做法 . 

合理的做法是用 地区/位置 表示时区 , 然后依据当前时间和地区决定目标 地区/位置 的时间偏移量 , 最后计算出目标的时间 . 


## mysql 数据库文件存储路径





## mysql 插入一条数据随机返回该数据的最佳实践是什么?

使用 [LAST_INSERT_ID()](https://dev.mysql.com/doc/refman/8.0/en/information-functions.html#function_last-insert-id) 函数 
- https://stackoverflow.com/a/17112962/7707781

### 这么做一个自然的问题就是 , 多线程情况下 , 如何保证在我获取 LAST_INSERT_ID 结果前 , 没有另一条记录被插入 ? 

> The ID that was generated is maintained in the server on a per-connection basis. This means that the value returned by the function to a given client is the first AUTO_INCREMENT value generated for most recent statement affecting an AUTO_INCREMENT column by that client. This value cannot be affected by other clients, even if they generate AUTO_INCREMENT values of their own. This behavior ensures that each client can retrieve its own ID without concern for the activity of other clients, and without the need for locks or transactions.

> 生成的 ID 以 每个连接为基础在服务器中维护。这意味着函数返回给给定客户端的值是 为影响该客户端的列AUTO_INCREMENT的最近语句生成的第一个值 。这个值不会受到其他客户端的影响，即使他们生成 自己的值。此行为确保每个客户端都可以检索自己的 ID，而无需担心其他客户端的活动，也不需要锁或事务。

### 接下来需要考虑的问题是 , 以连接为基础是什么意思 ? 

我们通过 C++ connector 执行 `SELECT LAST_INSERT_ID();` 结果总是 0 ; 

对于 insert 语句 通过 `SqlResult.getAutoIncrementValue()` 得到 上个插入语句的首个自增长 列的值 . 
对于单语句 插入 多行的 , 得到首行 首个 子增长列的值 . 


### 如果一条语句插入多条数据会发生什么 ? 



## 对于 具有联合主键的 表 , 更新语句应该如何编写 , 假设希望一条语句更新多条记录

先列出对于单主键的 更新语句 
```sql
 UPDATE `nameless_carpool`.`telephone`
 SET 
        `number`              = CASE `id`
                                WHEN '1' THEN '15111111111'
                                WHEN '2' THEN '15122222222'
                                END,
        `vertify_code`        = CASE `id`
                                WHEN '1' THEN 'vvv11111111'
                                WHEN '2' THEN 'vvv22222222'
                                END 
 WHERE  `id`                  IN ('1', '2') 
```

答案
1. https://stackoverflow.com/a/75627308/7707781
2. https://stackoverflow.com/a/75627419/7707781
```sql
-- -------------------------------------------------------------
-- 复合主键表的更新动作 , 成功
-- -------------------------------------------------------------
 UPDATE `nameless_carpool`.`user_tel`                                                             
 SET                                                                
        `desc`   = CASE                                    
                     WHEN (`user_id`='1' AND `telephone_id`='1') THEN '22222'                                                               
                     END                                                          
 WHERE  (`user_id`, `telephone_id`) IN ( ('1', '1') );

-- -------------------------------------------------------------
-- 复合主键表的更新动作 , 成功 ②
-- -------------------------------------------------------------
 UPDATE `nameless_carpool`.`user_tel`                                                             
 SET                                                                
        `desc`   = CASE    CONCAT(`user_id` , `telephone_id`='1')                                
                     WHEN  CONCAT('1' , '1') THEN '15111111111'                                                               
                     END                                                     
 WHERE  CONCAT(`user_id` , `telephone_id`='1') IN ( CONCAT('1' , '1') );
```

## 存储过程概念

存储过程的内容 , 在 MySql 官方文档中 涉及到以下内容

铺垫
- [复合语句语法](https://dev.mysql.com/doc/refman/8.0/en/sql-compound-statements.html)
  - [BEGIN...END](https://dev.mysql.com/doc/refman/8.0/en/begin-end.html)
  - `BEGIN...END` 是用于实现复合语句的语法 , 之间可以存在 0 条或多条以 `;` 分隔的 sql 语句 . 
  - 在 MySql 命令行工具客户端 使用这个语法的时候 , 需要重定义定界符 , 才能避免混淆 . 例如冲定义定界符为 `//` : https://dev.mysql.com/doc/refman/8.0/en/stored-programs-defining.html
1. [第二十五节 - 存储对象](https://dev.mysql.com/doc/refman/8.0/en/stored-objects.html)



## 从 SQL 函数开始了解
https://dev.mysql.com/doc/refman/8.0/en/create-function.html

## MySql 对时间的处理 , 主要关注时区相关信息

在了解这些信息前 先 尝试描述我们面临的问题
1. 我们拿着一个两个时间点(时间戳)构成的一个时间段 , 与数据库中某表某行的一个时间段进行对比, 看两个时间段有没有重合 . 
2. 对比的时候需要考虑时区问题


[简要说明个人理解](https://dev.mysql.com/doc/refman/8.0/en/time-zone-support.html)

* msyql 从 8.0.19 开始支持时区的 , MySQL 安装过程创建时区表，但不加载它们。


* 我们知道时区的规则随着时间变化是变化的 , 如何 与时区变化保持同步 :
  - 如果您的系统有自己的 zoneinfo 数据库，只要 zoneinfo 数据库更新，就重新加载 MySQL 时区表。
  - linux 是有 zoneinfo 数据信息的 `/usr/share/zoneinfo`
  - 对于大多数操作系统，最新的更新或服务包可以让您的系统为时间变化做好准备。

* 有说明如何检查当前 mysql 是否针对夏令时有正确的设置 . 


[具体到时间的比较 , 有一系列内建函数](https://dev.mysql.com/doc/refman/8.0/en/date-and-time-functions.html)
- TIMESTAMPDIFF() : 根据指定单位返回两个时间戳的差值
  ```sql
  mysql> SELECT TIMESTAMPDIFF(MONTH,'2003-02-01','2003-05-01');
        -> 3
  mysql> SELECT TIMESTAMPDIFF(YEAR,'2002-05-01','2001-01-01');
          -> -1
  mysql> SELECT TIMESTAMPDIFF(MINUTE,'2003-02-01','2003-05-01 12:05:55');
          -> 128885
  mysql> SELECT TIMESTAMPDIFF(SECOND,'2009-05-18 12:30:12','2023-05-18 12:30:11');
  ```
- 对比两个时间点的先后
  ```sql
  SELECT TIMESTAMPDIFF(SECOND,'2009-05-18 12:30:12','2023-05-18 12:30:11') > 0 ;
  ```


## 对于排序的了解

我们有一个列式枚举字符串 , 当我们需要根据该列排序的时候 , 我们希望开发者指定枚举值的先后顺序
- https://stackoverflow.com/questions/14104055/ordering-by-specific-field-value-first
- https://blog.51cto.com/u_15060458/4107473
   - 这里强调将多个条件用某种逻辑合并成某个可排序的数字 , 然后根据合并结果进行排序

