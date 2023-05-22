
# C++ 引用 理解 

本文过程过多 , 建议直接了解移动语义的语法提案 : http://www.open-std.org/jtc1/sc22/wg21/docs/papers/2002/n1377.htm

## 〇. 问题来源

- 关于引用 [问题源自代码](https://gist.github.com/Zitrax/a2e0040d301bf4b8ef8101c0b1e3f1d5)
  - [转发引用](https://zh.cppreference.com/w/cpp/language/reference#.E8.BD.AC.E5.8F.91.E5.BC.95.E7.94.A8)
    - 包含 `&`
    - 包含 `&&`
  - 关于引用较为清晰的论述 : C++程序语言设计 -> 7.7 章节
    - 左值引用: 
  - [关于 std::forward](https://zh.cppreference.com/w/cpp/utility/forward)
  - 函数类型 / 函数引用 / 函数变量
    - [尝试模仿此例理解 `std::forward`](https://www.guodong.plus/2020/0314-132811/)
    - 需要预先了解 函数作为参数传递 的相关内容
    - [一个人的个人学习总结](https://www.guodong.plus/2020/0307-190855/)

## 一. 内容 递进 拆分

左值和右值是表达式的属性 . 

### 1.1. C语言 左值 右值 

**标识符** : 由 字母/数字/下划线(首字母必须是 字母/下划线) 构成的序列 . 
            区分大小写 . 
            长度任意 . 

  ```c
  int flag = 123 ; // flag 就是一个标识符
  ```

**标识符的含义** : 标识符也称为名字 , 可以指代多种实体 : 函数 / 结构标记 / 联合标记 / 枚举标记 / 
                 结构成员或联合成员 / 枚举常量 / 类型定义名 / 标号以及对象 / 等...

**表达式** : C语言程序设计 附录A.7 
* 初等表达式  
  - 标识符
  - 常量
  - 字符串
  - (表达式) : `带括号的表达式`
* 后缀表达式
* 等等...

**左值** : lvalue / l-value / locator value / left value : 
          对象是一个命名的存储区域 , 左值是引用某个对象的表达式 .
          引用内存位置的表达式称为左值表达式 . 
          并暗示它可以出现在等号 ( = ) 的左侧。 
          左值通常是标识符。

**右值** : 术语“右值”有时用于描述表达式的值以及将其与左值区分开来。 
          所有左值都是右值，但并不是所有右值都是左值。



#### 1.1.1. 追问
1. 对于 `对象是一个命名的存储区域 , 左值是引用某个对象的表达式 .` , 来说 , 这个左值是如何存储的 ?
   - 那感觉就想上述描述故意忽略了什么一样
   1. 一个数组放在内存里
   2. 数组首个元素的内存地址被一个标示符所引用
   3. 这意味着标示符, 在某处存储 , 标示符所引用的内存地址在某处存储 , 这二者又该如何建立联系呢 ?

### 1.2. C++ 左值 右值

#### 1.2.1. C++ 左值

```C++
/* 标识符 flag_int 现在表示 `123` 本身 ; 比如在参与计算的时候 flag_int + 1 结果是 124 */
int flag_int {123};

/* 标识符 ref_flag_int , 表示一个 int 类型的引用 . 
   类似指针 , ref_flag_int 实际持有的是 所 引用 int 对象的机器地址 .
   但是在某些语法情境上 , ref_flag_int , 可以理解为 123 本身
    - 例如 : ref_flag_int + 1 结果是 124
   在另一些语法情境上 , ref_flag_int , 可以理解为 123 的机器地址
    - 例如 : int_plus(ref_flag_int) , 此处参数传递过程中的拷贝动作拷贝的就是 123 的机器地址 , 而非 123 的值 . 
*/
int& ref_flag_int = flag_int;

int int_plus(int& int_value) {
  return int_value + 1 ;
}
```

我们暂时把引用理解为对象本身 , 即 : 引用就是对象本身/别名 . 
看到引用实际持有所引用对象的机器地址 , 我们比较容易联想到 `指针` .
1. 引用是必须被初始化的 , 不初始化的引用声明被编译器视为异常 , 所以不存在空引用一说(使用指针的时候却要实时考虑指针是否为 nullptr) .
    ```c++
    /*
    main.cpp:215:8: error: ‘ref_test_flag’ declared as reference but not initialized
    215 |   int& ref_test_flag;
        |        ^~~~~~~~~~~~~
    */
    int& ref_test_flag; //错误
    ```
2. 访问引用所引用的对象 , 和访问对象本身的语法形式是相同的 .
    ```c++
    int flag_int {123};
    int& ref_flag_int = flag_int;
    std::cout << "输出值预期为(124) : " << flag_int + 1 << "\n" ;
    std::cout << "输出值预期为(124) : " << ref_flag_int + 1 << "\n" ;
    /* 上述两个打印语句打印结果相同 */
    ```
3. 由于以上两点 , 又由于 , 事实上没有针对引用的操作符 ; 所以 引用所引用的永远是一开始初始化的那个对象 . 
4. 指针和引用都可以达到一个相同的目的 , 在传递参数的时候 , 可以避免昂贵的大对象拷贝动作 . 

为了支持对象的不同用法 , c++ 支持了多种类型的引用
1. 非 `const` 左值引用 , 允许用户修改所引用的对象
2. `const` 左值引用 , 不允许用户修改所引用的对象
3. 右值引用引用一个临时对象 , 一般不用 `const` 做限定 , 可以修改 . 
   并且认定这个对象以后不会用到了 . 
4. **临时对象** : C++程序设计语言 10.3.4 : 
   通常情况下 , 编译器必须引入一个对象用于表示表达式的中间结果 . 
   例如 : `v = x + (y * z)` , `y * z` 的结果在与 `x` 求和之前必须存放到某处 . 

我们用代码来分辨下 左值引用的相关实例  : 
```c++
int int_flag {1};
int& lvalue_falg {int_flag} ; /* C++ 中定义一个左值引用标识符 ; 将左值引用标识符 绑定到 与其类型匹配的`非临时`对象上 */


/*
main.cpp:215:24: error: cannot bind non-const lvalue reference of type ‘int&’ to an rvalue of type ‘int’
  215 |   int& lvalue_falg_2 {2};
      |                        ^
显然编译器认为 `2` 是一个右值 ; `lvalue_falg_2` 是一个非 `const` 左值标识符 . 
我们不妨这样理解或说 , 我们不妨这样认定 : 
  1. 在一个对象(变量) , 有所归宿之前它都是临时的 . 
     例如 , `int int_flag = 1;` 这个赋值动作完成后 , `1` 被 `int_flag` 标识符所持有 , 此时 `1` 就不再是"临时"的了 . 
  2. 左值引用 , 是将左值引用标识符 绑定到 与其类型匹配的`非临时`对象上 .
  3. 右值引用 , 是将右值引用标识符 绑定到 与其匹配的`临时`对象上 . 
  4. 2/3 所谓的绑定 , 就是完成用 引用标识符 表示对象的机器地址的动作 . 
*/
int& lvalue_falg_2 {2}; 


/* 这个语句却可以编译通过 , 这确实让人费解 ; 我们不妨这样理解 , 或者说 , 我们不妨这样认定 : 
   这条到编译器处理的时候实际上是这样处理的: 
      ```c++
      int temp_value {2};
      const int& const_lvalue_falg {temp_value}; 
      ```
*/
const int& const_lvalue_falg {2}; 


int& lvalue_test_fun(int& param_lvalue) {
  /* 除非函数的名字能够表达 引用 参入会发生改变, 否则不应该随便使用 `普通` 引用 */
  param_lvalue += 1; 
  return param_lvalue
}
void normal_value_test_fun(int param) {
  param += 1; 
}
std::cout<< "lvalue_flag : " << lvalue_falg << "\n" ;/* 此时 lvalue_flag 所引用对象的值为 `1` */
lvalue_test_fun(lvalue_falg);
std::cout<< "lvalue_flag : " << lvalue_falg << "\n" ;/* 此时 lvalue_flag 所引用对象的值为 `2` */
normal_value_test_fun(lvalue_falg);
std::cout<< "lvalue_flag : " << lvalue_falg << "\n" ;/* 此时 lvalue_flag 所引用对象的值为 `2` 
   因为 , 调用 `normal_value_test_fun` 函数时的传参动作是一个拷贝动作 : 
   将 lvalue_falg 所引用的内存中的值拷贝给了 参数 param , 所以对 param 的操作不会影响 lvalue_falg
*/
```

#### 1.2.2. C++ 右值

在 `1.2.1` 关于左值我们说了许多 , 右值与左值的差异就是 `这个对象以后不会用到了` ; 但是我们还不知道如何认定这一点 . 
- 关于这一点我们有一个来自 StackOverflow 的解答 : 
  - rvalues denote temporary objects which are destroyed at the next semicolon
  - 右值 表示在下一个分号 `;` 处会被销毁的临时对象 . 
  - 我看了许多关于右值引用的介绍 , 我可以判断什么情况下的变量称为右值变量 , 
    但是仍然不知道它有什么作用解决什么问题 , 目前我没有找到 , 右值引用可以解决左值引用解决不了的问题 . 
- [右值引用的语法提案](http://www.open-std.org/jtc1/sc22/wg21/docs/papers/2002/n1377.htm) 表明 : 
  - 右值引用是给临时变量一个标示符 , 方便对临时变量的后续使用 . 
  - 实际上是大家先讨论关于移动语义 , 可以优化拷贝语义的系统资源占用问题 . 决定在 C++ 引入移动语义 .
  - 但是对于临时对象的移动尚无明确的表示方式 , 所以创造了 `&&` 右值引用 , 用以表达临时变量的引用 . 


C++ 中的 左值 右值 两个名词 , 是从 C 继承来的 , 含义有所不同 . 描述如下 :
  - 左值 和 右值 都是表达式的属性 . 
  - 一些表达式生成或要求左值 , 一些表达式生成或要求右值


#### 1.2.3. 追问
* 引用(reference) , 在 C / C++ 里引用是什么 ? 
  - 暂时理解为 , 引用就是被引用的对象本身 . 我知道这么说不合逻辑 . 但是暂时这么理解是勉强说的过去的 . 
  - 标识符 flag_int , 我们知道它本身不是 123 , 但是在语法上 , 我们认为当完成赋值动作后 , flag_int 就是 123 本身 .
  - 要理解引用 , 或许需要了解些编译器实现和计算机原理相关的知识吧 . 
* 我们可以做一个假设吗 ? 标识符 , 实际也是引用存放的也是对象机器地址 , 只不过语法上它总表示对象本身 . 
  - 至此 , 我们确认不清楚 `标识符和对象地址是如何产生关联的` 这是我们的盲区 .  
    - 猜测有两门课程可以解答这个问题 : 计算机组成 / 编译原理






### 1.x. 参考内容
* [docs.microsoft : 左值和右值表达式](https://docs.microsoft.com/zh-cn/cpp/c-language/l-value-and-r-value-expressions?redirectedfrom=MSDN&view=msvc-170)
* [lvalue and rvalue in C language](https://www.geeksforgeeks.org/lvalue-and-rvalue-in-c-language/)
* [C中的左值和右值](https://www.tutorialspoint.com/lvalue-and-rvalue-in-c)
* C语言程序设计--机械工业出版社  : 附录A 2.3
* [Why doesn't rvalue destroy right after it's used?](https://stackoverflow.com/q/31252615/7707781)
* [What is std::move semantics?](https://stackoverflow.com/q/3106110/7707781)
* [C++ 移动语义的提案论文](https://stackoverflow.com/a/3106309/7707781)
  http://www.open-std.org/jtc1/sc22/wg21/docs/papers/2002/n1377.htm
* [右值引用的使用场景](https://blog.csdn.net/niu91/article/details/109241744)








## 二. 参考内容
* C++ Primer (第五版) : 2.3.1  /  13.6.1
* C++ 程序设计语言 (第四版) : 
   - 7.7 : 对引用的理解
   - 17.1 : 对移动和拷贝的分辨
* C 程序设计语言 (第二版) (机械工业出版社)
* [一个人的个人学习总结](https://www.guodong.plus/2020/0307-190855/)
* C语言程序设计--机械工业出版社 : 附录 , 这里有很多我们熟悉的名词的具体含义的限定和描述 . 



## 三. 收获 
- "C++程序设计语言" / "C++ Primer" 多本书看同一个知识点的不同表述 , 或需对认识一个新的知识点有帮助 . 
- 在阅读相关章节的时候 , 一个最好的做法是真的将这些章节中的代码自己写下来运行一次 , 才能有比较恰当的理解 . 
- 在进行一个知识点的(深入)学习的时候 , 难免会碰到几个前置知识点的盲区 , 这时候 , 可以先尝试认定 , 当前描述即为准确 
  把对盲区知识点的探寻放在此知识点通揽之后 . 
- 在认识一个有疑问的知识点的时候 , 应该把认识的过程写到一个地方 , 这样可以有效防止风暴般的疑问们
  搞得人晕头转向 , 写下所有的疑问方便逐一解答 . 
