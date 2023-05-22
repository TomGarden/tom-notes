# How to Design Using RxJava

使用 RxJava 你创建 Observable(它发出数据项)， 通过各种方式转换 Observable 从而获取精确数据项(通过观察者模式)， 然后观察并对感兴趣的 item (项目)做出相应(通过实现 Observers 或者 Subscribers 然后将它们订阅到生成的转换的观察结果中)

## Observable 的若干种创建方式

略

## 通过 Operator 转换 Observable
RxJava 允许你将 Operator 链接在一起转换为 Observable 。
