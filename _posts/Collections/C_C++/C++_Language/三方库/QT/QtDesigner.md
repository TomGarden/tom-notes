

在 QT 项目 根视图 Qt Designer 中的根节点设置 styleSheet , 这里的 qss 应用范围是整个软件 . 
```
QWidget             针对此设置的 qss 对于整个项目窗口都有效 , 需要慎重
  └──QFrame         对于此设置的 qss 只对 QFrame 及其子节点有效 . 
        └──QLable
```