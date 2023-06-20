
## 我们常说的 Android 基础都有哪些内容呀?

四大组件
1. Activity 最常见的用户交互组件 , 软件界面借由此展示 , 用户交互由此承接 . 
2. Service 不可见的组件 , 通常完成一些后台耗时任务 . 
3. Braodcast 广播 , 一个用于全局发送消息的组件 . 
                   关心这个消息的其他组件会侦听这些消息 . 
                   是否对于某个消息做出响应式是侦听者的问题 . 
4. ContentProvider 内容提供者 , Android 系统维护的 SQLite 数据库 . 
                              用于存放应用间的共享数据 . 

通信
- 组件间通信 Intent 
- 线程间通信 Handler
- 进程间通信 Binder


其他
- View 绘制流程 / 自定义 View 


设计模式
- mvc / mvp / mvvm
- 单例
- 观察者模式
- 工厂模式
- 装饰者模式


