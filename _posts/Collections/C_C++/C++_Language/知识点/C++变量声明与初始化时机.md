

成员变量的在 `声明的同时 即初始化` vs `在构造函数中初始化` 


0. C++ 11 之前确实不允许 , 对类中的 成员变量直接赋予初始值 . 

1. 对于 int 类型变量 , 声明的时候如果没有赋初值 , 那么默认值为 0 . 
   - 对于这个 int 我们到构造函数去初始化 , 在构造函数无需入参的时候 , 这并不是最易于阅读的方式 . 

2. 声明的同时初始化 , 这是个好习惯 , 但是声明与否都无伤大雅 .  

3. [参考 stackOverFlow 中相关问题的探讨](https://stackoverflow.com/questions/24149924/has-the-new-c11-member-initialization-feature-at-declaration-made-initializati)


```c++
class Test {

  public:
    Test():i_defInit(10) {}         /* i_defInit 的初始化显然没有 i_customInit 初始化来的直观 */

    Test(int _i_defInit, int i_customInit) :i_defInit(_i_defInit), i_customInit(_i_customInit) {}
                                    /* 即使已经在声明的同时初始化了 , 构造函数或其他函数如果有需要仍然可以覆盖 */

  private:
    int i_defInit ;
    int i_customInit = 99;
}
```


如果成员变量用 `m_` 打头 , 指针变量用 `p_` 打头 , 那么成员指针变量 怎么办 ? 