
DATE 类型的数据检索结果是 RAW 类型 , 不知道如何完成更进一步的数据转换 . 

在插入和查询动作中却可以 直接使用 string 进行 sql 操作 . 

所以我们需要再 SQL 检索语法中将时间转换为 字符串 , 需要注意 , 时间和戳 和 时区是关联数据 , 一起参与计算才有意义 . 