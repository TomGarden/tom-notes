## 一、 什么是析构函数
创建对象时系统会自动调用构造函数进行初始化工作，同样，销毁对象时系统也会自动调用一个函数来进行清理工作，例如释放分配的内存、关闭打开的文件等，这个函数就是析构函数。

析构函数（Destructor）也是一种特殊的成员函数，没有返回值，不需要程序员显式调用（程序员也没法显式调用），而是在销毁对象时自动执行。构造函数的名字和类名相同，而析构函数的名字是在类名前面加一个`~`符号。

注意：析构函数没有参数，不能被重载，因此一个类只能有一个析构函数。如果用户没有定义，编译器会自动生成一个默认的析构函数。

**这个概念很容易理解已然知道了，问题在于如何分辨，什么样的内存需要被销毁？**

## 二、 定位需要释放的内存
这时候会需要一点内存管理和区分的知识

## 三、 如何释放内存
C++ 中的 new 和 delete 分别用来分配和释放内存，它们与C语言中 malloc()、free() 最大的一个不同之处在于：用 new 分配内存时会调用构造函数，用 delete 释放内存时会调用析构函数。构造函数和析构函数对于类来说是不可或缺的，所以在C++中我们非常鼓励使用 new 和 delete。
















## Reference
1. [C语言中文网-析构函数](http://c.biancheng.net/cpp/biancheng/view/196.html)
2. [cppreference.com-析构函数](http://zh.cppreference.com/w/cpp/language/destructor)
3. [C++ 内存管理1](https://www.jianshu.com/p/cdfde318d5ee)
4. [C/C++内存管理详解](https://chenqx.github.io/2014/09/25/Cpp-Memory-Management/)
5. [内存分配详解、指针与数组[C++][内存管理]](http://www.cnblogs.com/JCSU/articles/1051826.html)
