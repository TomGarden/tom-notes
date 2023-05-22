多重锁具体含义
- 涉及到的函数为 [std::lock](https://zh.cppreference.com/w/cpp/thread/lock)

我理解 :
```c++
std::mutex mutex1;
std::mutex mutex2;

/* 只有当 两个 mutex 都可以获取锁的时候 , 才真正获取他们的锁 , 否则 , 会稍候再尝试获取 . 
   因此避免了死锁 */
std::lock(mutex1, mutex2);
```

## 0x00. 并发编程 , 从单例函数开始了解

1. 加锁动作的锁变量 , 可以保证单例只初始化一次吗?
    - 锁变量的初始化如何保证只有一次 ? 
2. 编译时初始化时什么意思
    - 链接时初始化时什么意思

## 0x01. 单线程的单例

参考内容 1 : https://stackoverflow.com/a/1008289/7707781
参考内容 2 : https://stackoverflow.com/a/335746/7707781

```c++
class S
{
    public:
        static S& getInstance()
        {
            /* 这个静态变量的初始化动作是线程安全的 , 可以参考 C++20标准文档  [stmt.dcl] 第4段 
               静态变量只在控制器经过代码时初始化一次
            */
            static S    instance; // Guaranteed to be destroyed.
                                  // Instantiated on first use.
            return instance;
        }
    private:
        S() {}                    // Constructor? (the {} brackets) are needed here.

        // C++ 03
        // ========
        // Don't forget to declare these two. You want to make sure they
        // are inaccessible(especially from outside), otherwise, you may accidentally get copies of
        // your singleton appearing.
        S(S const&);              // Don't Implement
        void operator=(S const&); // Don't implement

        // C++ 11
        // =======
        // We can use the better technique of deleting the methods
        // we don't want.
    public:
        S(S const&)               = delete;
        void operator=(S const&)  = delete;

        // Note: Scott Meyers mentions in his Effective Modern
        //       C++ book, that deleted functions should generally
        //       be public as it results in better error messages
        //       due to the compilers behavior to check accessibility
        //       before deleted status
};
```
