1. UI 预览 : `tools -> from editor -> preview...`
2. 添加资源文件
    - https://qtguide.ustclug.org/ch05-06.htm
    - https://doc-snapshots.qt.io/qt6-6.2/qt-add-resources.html



信号&槽 连接 函数 :
```c++

/**
 * @brief 
 * 
 * @param sender 
 * @param signal 
 * @param receiver 
 * @param method 
 * @param type 
 * @return QMetaObject::Connection 
 */
QMetaObject::Connection QObject::connect(const QObject *sender, const char *signal, const QObject *receiver, const char *method, Qt::ConnectionType type = Qt::AutoConnection){}
/**
 * @brief 
 * 
 * @param sender 
 * @param signal 
 * @param receiver 
 * @param method 
 * @param type 
 * @return QMetaObject::Connection 
 */
QMetaObject::Connection QObject::connect(const QObject *sender, const QMetaMethod &signal, const QObject *receiver, const QMetaMethod &method, Qt::ConnectionType type = Qt::AutoConnection){}
/**
 * @brief 
 * 
 * @param sender 
 * @param signal 
 * @param method 
 * @param type 
 * @return QMetaObject::Connection 
 */
QMetaObject::Connection QObject::connect(const QObject *sender, const char *signal, const char *method, Qt::ConnectionType type = Qt::AutoConnection) const{}
/**
 * @brief 
 * 
 * @tparam PointerToMemberFunction 
 * @param sender 
 * @param signal 
 * @param receiver 
 * @param method 
 * @param type 
 * @return QMetaObject::Connection 
 */
template <typename PointerToMemberFunction> QMetaObject::Connection QObject::connect(const QObject *sender, PointerToMemberFunction signal, const QObject *receiver, PointerToMemberFunction method, Qt::ConnectionType type = Qt::AutoConnection){}
/**
 * @brief 
 * 
 * @tparam PointerToMemberFunction 
 * @tparam Functor 
 * @param sender 
 * @param signal 
 * @param functor 
 * @return QMetaObject::Connection 
 */
template <typename PointerToMemberFunction, typename Functor> QMetaObject::Connection QObject::connect(const QObject *sender, PointerToMemberFunction signal, Functor functor){}
/**
 * @brief 
 * 
 * @tparam PointerToMemberFunction 
 * @tparam Functor 
 * @param sender 
 * @param signal 
 * @param context 
 * @param functor 
 * @param type 
 * @return QMetaObject::Connection 
 */
template <typename PointerToMemberFunction, typename Functor> QMetaObject::Connection QObject::connect(const QObject *sender, PointerToMemberFunction signal, const QObject *context, Functor functor, Qt::ConnectionType type = Qt::AutoConnection){}

```

仍然有疑问的点在于 `connect` 和 `disconnect` 必须是成对出现的吗 ?
- 连接资源会自动释放吗


QtDesigner 有时候需要清除编译缓存重新编译才能生效 , 可能和 cmake 代码有关 , 需要跟进

Qt QSS 应用到 styleSheet 针对不同控件 应该有一个完全列表 , 这个列表到哪里可以找到
- [概述](https://doc.qt.io/qt-6/stylesheet.html)
- [所有支持的属性列表](https://doc.qt.io/qt-6/stylesheet-reference.html)
- 背景图片拉伸 : https://qtdebug.com/qtbook-qss-border-image/


QT XML 操作
1. https://www.qt.io/blog/parsing-xml-with-qt-updates-for-qt-6
    - QT6 开始不建议使用 QDOM 操作的 api 建议使用 QXmlStream
    - 但是也可以使用 QDOM , 有一个兼容包 : https://doc.qt.io/qt-6.2/xml-changes-qt6.html
2. https://doc.qt.io/qt-6/qtxml-index.html
3. qt6 引入 qt5xml 兼容包 : https://doc.qt.io/qt-6/qtcore5-index.html



Windows QT 使用 CMake
- 编译器选择 MinGW