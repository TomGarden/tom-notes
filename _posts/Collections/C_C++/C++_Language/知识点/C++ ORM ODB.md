
探索能否更轻便的完成大量的 sql 语句编写工作 . 

C++ ORM 


## 0x01.  ORM - Object Relational Mapping
1. 维基百科 : https://en.wikipedia.org/wiki/Object%E2%80%93relational_mapping
2. 阮一峰   : http://www.ruanyifeng.com/blog/2019/02/orm-tutorial.html

ORM 的思想 , 理论上可以帮助我们省去写 sql 的繁琐 . 

总结起来，ORM 有下面这些优点。
- 数据模型都在一个地方定义，更容易更新和维护，也利于重用代码。
- ORM 有现成的工具，很多功能都可以自动完成，比如数据消毒、预处理、事务等等。
- 它迫使你使用 MVC 架构，ORM 就是天然的 Model，最终使代码更清晰。
- 基于 ORM 的业务代码比较简单，代码量少，语义性好，容易理解。
- 你不必编写性能不佳的 SQL。


但是，ORM 也有很突出的缺点。
- ORM 库不是轻量级工具，需要花很多精力学习和设置。
- 对于复杂的查询，ORM 要么是无法表达，要么是性能不如原生的 SQL。
- ORM 抽象掉了数据库层，开发者无法了解底层的数据库操作，也无法定制一些特殊的 SQL。





## 0x02. C++ 中对于 ORM 的实现


1. ODB : https://codesynthesis.com/products/odb/
   - 它日期时间使用 boost 来处理的 . 我更想用 标准 c++ 那一套
2. 关于 其他实现库的一些讨论 : https://www.reddit.com/r/cpp/comments/698f5j/why_does_the_c_community_dont_have_a_famous_orm/
   - https://github.com/rbock/sqlpp11 : 这个看起来很好 , 不知道是不是会成为最终选项
   - 不支持原生 sql 的执行
3. https://stackoverflow.com/a/454276/7707781
4. https://github.com/edwig/CXHibernate
5. https://otl.sourceforge.net/
6. https://cpp.libhunt.com/libs/orm
8. https://www.codeproject.com/Articles/5246629/Cplusplus-Hibernate

几次三番的看过这些内容了 , 没有总结文字 , 感受上没有足够有说服力的库 , 
我们暂时还是用 宏 模仿 nlohmann_json 完成针对单个表的增删改查 试一下吧 . 
当涉及到多表查询时候再尝试更新 宏 . 



## 0x03. 常见的 ORM 框架有 Hibernate 和 MyBatis

## 0x04. 我也不知道好不好用其实

我先保守些
