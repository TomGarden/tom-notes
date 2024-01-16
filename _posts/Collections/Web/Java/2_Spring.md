

[Spring 自定义查询](https://springdoc.cn/spring-data-mongodb/#repositories.query-methods.details) 有两种方式 . 
- 通过直接从方法名派生出查询。(通过特定的函数命名即可自动生成特定的查询逻辑)
   - 格式化函数名 , 派生查询逻辑
- 通过使用手动定义的查询。
   - 通过 Query 注解实现自定义查询逻辑


如果不想使用上述两种方式 , 可以完全实现自定义