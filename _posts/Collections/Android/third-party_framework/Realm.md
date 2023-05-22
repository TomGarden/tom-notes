## 认识 Reaml
1. 一个 数据库 框架
2. 可以监听数据变化并事实更新 UI
3. 可以隔离网络操作和 UI 交互 : 网络操作和数据库交互 , UI 通过监听 数据库变化完成更新

azure
username: db_user
userpwd : db_user

如果不能访问应该是需要设置一下访问 ip : https://cloud.mongodb.com/v2/60e2afce191f4d1423b8ba32#security/network/accessList

## [操作 Realm](https://docs.mongodb.com/realm-sdks/java/latest/)

打开一个 Realm
```kotlin

```



## 结合 ViewModel
@Bindable
notifyPropertyChanged


## Realm 的已知不足
[不支持 group by ](https://stackoverflow.com/questions/30431201/realm-io-query-with-groupby)
[支持 Triggers](https://docs.mongodb.com/realm/triggers/#std-label-triggers)
