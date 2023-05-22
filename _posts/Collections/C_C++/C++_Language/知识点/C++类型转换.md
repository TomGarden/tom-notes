

# 关于 C++ 类型转换

## 0x01. 参考内容
- 《C++ Primer》 中文 第五版
- 《C++ Primer Plus》 中文 第六版
- https://zh.cppreference.com/w/cpp/language/expressions

## 0x02. 回想过去

说到类型转换我首先能想到 :
```C++
/* ① 类型转换过程中一个比较好的做法是明确自己的类型转换意图增加代码可读性 */
float floatVal  = 123.123;
int   intVal1   = floatVal;       /* 有时候会有歧义 , 程序员可能无心的做了一次类型转换 */
int   intVal2   = (int)floatVal;  /* 程序员可以用这种方式来表达: 我知道发生了什么, 我在做类型转换 */

/* ② 子类向父类的类型转换 */
class Father {};
class Son : public Father {};
Son    sonOne;
Father father = sonOne;    /* 子类可以转换为 父类 */
// Son    sonTwo = Father;    /* 错误: 父类不能转换为子类 */

/* ③ 编译器执行程序员的类型转换语句的时候 , 
      - 总是会"聪明的"执行那些不会发生进一步异常的转换 
      - 那些会可能会发生异常的转换 , 会导致编译器报错
*/
```

换另一种语言来学习 , 能有更深入思考的机会 , 过去的想当然现在会变成一个个小疑问了 . 我从 Java 来 . 

## 0x03. 观察事实

C++ 这门语言中关于`类型转换`有几种表达形式 :

1. 隐式类型转换
   ```C++
   float floatVal  = 123.123;
   int   intVal1   = floatVal;
   ```

2. 显示强制类型转换①
   ```c++
   // type (expr)  /* 函数形式的强制类型转换 */
   //(type) expr   /* C 风格的强制类型转换 */
   ```

3. 显示强制类型转换② , 
   - 网上都说这几种强制类型转换是 C++ 11 引入的 , 但是我看 C++98 标准文档中就已经存在这样的字样了 . 
   - 不论何时引入 , 目前这都是普遍支持的语法了 . 
   ```c++
    dynamic_cast     <type> (expr)
    static_cast      <type> (expr)
    reinterpret_cast <type> (expr)
    const_cast       <type> (expr)
   ```

类型转换普遍造成两种情况(我按照自己的理解造的词)

1. 类型提升(类型所表达的对象的边界相比原来变大了) : 
   ```c++
   uint8_t  smallVal = 255;                 /* uint8_t  所能表示的值的范围是 [0, 255] */
   uint16_t largeVal = 65535;               /* uint16_t 所能表示的值的范围是 [0, 65535] */
   uint16_t convert1 = smallVal;            /* 可以理解为 , 将 convert1 可以表达的数值赋值给 convert1 , 这没问题 */
   uint16_t convert1 = largeVal + smallVal; /* smallVal 的范围会先提升 , 然后才参与运算
   uint16_t convert1 = largeVal + smallVal';   `smallVal'` 是临时变量 , 类型为 uint16_t 值为 255
   */
   ```
2. 类型降低(类型所表达的对象的边界相对原来变小了), 精度损失 :
   ```c++
   uint16_t largeVal  = 65535;              /* uint16_t 所能表示的值的范围是 [0, 65535] */
   uint8_t  smallVal1 = largeVal;           /* uint8_t  所能表示的值的范围是 [0, 255] */
   uint8_t  smallVal2 = largeVal - 1;       
   /* smallVal1 的结果是 255 , smallVal2 的结果是 254 
      uint16_t 类型的最大值 , 赋值给 uint8_t 的值的时候 , 由于 uint8_t 本身无法表示给到的值 , 
      所以会由于截取造成精度损失 . 

      从实际的情况不难猜测 , 将值(1111 1111 1111 1111) 赋给(0000 0000) , 的时候实际上做的是后 8 位的截取
                          将值(1111 1111 1111 1110) 赋给(0000 0000) , 也是后 8 位的截取
   */
   ```
3. 类型变化(类型所表达的对象根本毫无关系 , 只是对内存中同一块数据 作不同类型数据 理解)
   - 类型提升与类型降低本身也造成了类型的变化 
   ```c++
   int* intPtr;
   char* charPtr = reinterpret_cast<char*>(intPtr); /* 真很危险, 如果不熟悉会造成异常 */
   // std::string str(charPtr);                        /* 未定义行为 */
   ```


4. 关于 `1`、`2` 中的赋值动作
   ```c++
    #include  <cstdint>

    int main() {
        uint8_t  smallVal = 255;
        uint16_t largeVal = 65535;
        uint16_t convert1 = smallVal;  /* 这个赋值动作我个人理解应该被分为两个步骤了
        1. 通过 smallVal 创建一个临时变量 smallVal' , smallVal' 的类型为 convert1
        2. 然后进行赋值操作 , convert1 = smallVal'
        3. 当然这些是我瞎猜的 . 看了汇编我猜对了 . 
        */
        return 0 ;
    }

    ------------------------------------------
    main:
        push    rbp
        mov     rbp, rsp
        mov     BYTE PTR [rbp-1], -1
        mov     WORD PTR [rbp-4], -1
        movzx   eax, BYTE PTR [rbp-1]
        mov     WORD PTR [rbp-6], ax
        mov     eax, 0
        pop     rbp
        ret

   ```

## 0x04. 关于隐式类型转换
```c++
typeInput  inputVal = someValue;
typeOutput outVal   = inputVal;   /* 隐式类型转换 */
```

我们称 `typeInput` 为`原类型` , `typeOutput` 为 `结果类型` . 

隐式类型转换的效果就是 , `原类型`的所表示的数据范围被扩大(`提升`)或者缩小(`损失`)为`结果类型`的范围 . 

隐式类型转换是不提倡的表达方式 , 用显示类型转换更加可以降低代码阅读成本 . 


## 0x05. 显示类型转换 ①

与 隐式 类型转换的区别就在于 在语法上更可读了 . 

```c++
// type (expr)  /* 函数形式的强制类型转换 */
//(type) expr   /* C 风格的强制类型转换 */
```

## 0x06. 显示类型转换 ② 

① / ② 显示类型转换实际上是可以互相替代的 , 只是用 ② 可以更加明确的区分和表达含义 . 
① 还保留应该是要兼容旧代码的意思了 . 

### 6.1. const_cast , 用于抹除 底层对象的 const / volatile 属性

#### 6.1.1. 不妨先聊一下 const 关键字

`const` 关键字用于描述 `对象不可修改` 这一属性 . 
```c++
const int flag = 0;
flag           = 1; /* error: cannot assign to variable 'flag' with const-qualified type 'const int'
                       错误  : 无法将值 分配给被 const 限定的 对象 flag .
                     */ 
```

将 const 用于引用
```c++
int       flag      = 0;             /* flag      不被 const 限定 , 可以被修改 */
const int flagConst = 0;             /* flagConst   被 const 限定   , 不可修改 */

int&       rFlag      = flag;        /* 正确 ,  flag, rFlag 都不被 const 限定 */
const int& crFlag     = flag;        /* 正确 ,  flag, 不被 const 限定 , 
                                              crFlag 被 const 限定 , 通过 crFlag 无法修改对象值*/

int&       rFlagConst  = flagConst;  /* error: binding reference of type 'int' to value of type 'const   int' drops 'const' qualifier
                                        错误 : 将 int 类型引用绑定到 const int 类型上 会丢弃 const 限定符  */
const int& crFlagConst = flagConst;  /* 正确 */
```

将 const 用于 指针 : 指针本身是一个对象 , 它可以保存另一个对象的内存地址(它指向另一个对象) . 
- 指针本身是不是常量 ; 指针所指向的对象是不是常量 . 这是两个独立的问题 . 
```c++
int         falg   = 0;             /*       flag   非 const 限定 , 非常量 , 可修改 */
const int   cfalg  = 0;             /*       cfalg  被 const 限定 , 系常量 , 不可修改 */

int*        pFalg  = &falg;         /*       pFlag  非 const 限定 , 非常量 , 可修改 */
int*        pFlag  = &cflag         /*  错误: pFlag 预期指向的是一个 非 const 限定的值  , 但是给到的是一个 const 限定的值       */

int* const cpFlag  = &flag;         /*       预期 cpFlag 指针本身是 const 的 , 它所指向的对象是 非 const 的 */
int* const cpFlag  = &cflag;        /*  错误: 预期 cpFlag 指针本身是 const 的 , 它所指向的对象是 非 const 的 */

const int* pcFlag  = &flag;         /*        pcFlag 预期指向一个 被 const 限定的 int 对象 , flag 本身不被 const 限定 , 赋值后 , 通过 pcFlag 无法修改 flag 值 */
const int* pcFlag  = &cflag;        /*        pcFlag 预期指向一个 被 const 限定的 int 对象*/
/* 多几个关键字个数和位置不会导致错误
   const int *  var       -> 表示 var 是一个 指针 , 指向一个 被 const 修饰的 int 对象 . 
   int const *  var       -> 同上
   const const int *  var -> 同上

   int * const var      -> var 本身被 const 限定它不可变 , var 被 * 修饰 她是指针 , var 是一个自身不可变的指向 int 对象的指针
 */


const int* const cpcFlag  = &flag;  /*        cpcFlag  本身被 const 限定 
                                              cpcFlag 预期指向一个 被 const 限定的 int 对象 , flag 本身不被 const 限定 , 赋值后 , 通过 pcFlag 无法修改 flag 值 */
const int* const cpcFlag  = &cflag; /*        cpcFlag  本身被 const 限定 
                                              cpcFlag 预期指向一个 被 const 限定的 int 对象*/
```

对 `const` 和 `*` 的结合使用 , 可以从按照语法从右到左理解语句含义
```c++
const int *  var       -> var 被 * 修饰 (var 本身是指针) ;  var 指向 int 类型 , int 被 const 修饰 (var 指向 一个 常量 int)
                       -> 表示 var 是一个 指针 , 指向一个 被 const 修饰的 int 对象 . 
                       -> 表示 var 是一个 指向 const int 的指针 . 

int const *  var       -> var 被 * 修饰 (var 本身是指针) ;  var 指向 const 类型的对象 , const 被 int 修饰 (var 指向 一个 常量 int)
                       -> 表示 var 是一个 指针 , 指向一个 被 const 修饰的 int 对象 . 
                       -> 表示 var 是一个 指向 const int 的指针 . 

int * const  var       -> var 被 const 修饰(var 本身是常量) ; 'const var' 被 * 修饰(常量 var 是一个指针变量) ; '* const  var' 被 int 修饰 (常量 var 指针 , 指向 int 类型变量)
                       -> var 是常量 , var 是指针 , var 指向 int 类型
```

我们再讨论 `顶层 const` 和 `底层 const`
- `顶层 const` 作用于指针 , 表示 指针对象本身 是 const 的
- `底层 const` 作用于指针 , 表示 指针所指向的 对象 是 const 的

- 对于指针或引用变量 才可能使用两个 名词 
- 用于声明 引用的 const 都是 底层 const 
- 对于其他变量只是用 `顶层 const` 来描述就够了

```c++
const int a;         /* a 不可以被修改 , 这是顶层 const */

const int* b;        /* 表示 b 指向的对象不能被修改 , 这是一个 底层 const */
int* const c;        /* 表示指针对象 c 不能被修改   , 这是一个顶层 const */

const int& d;        /* 表示 d 所引用的对象不能被修改 , 这是一个底层 const
                        引用只能绑定一次 */
int& const e;        /* 语法错误 : error: 'const' qualifier may not be applied to a reference */
```

#### 6.1.2. 再说 const_cast 关于 const
这是来自 《C++ primer》 的说法

```c++
const_cast<type>(expr)  
```

只能 改变 运算对象的底层 const ; 
- 实际上是将运算对象的 底层 const 标记 抹除 , 从而编译器允许我们对底层对象做修改 .
   - 如果我们不抹除 const 标记 , 编译器会拒绝我们对 const 变量做修改的行为 . 
- 但是并不能实际消除底层 const 的影响 . 如果底层对象本身 是 const 的 
   - 我们通过 `const_cast` 抹除 const 标记后 , 再做对数据做操作 , 则结果未定义 . 
   - 但是如果我们不通过 `const_cast` 抹除 const 标记 , 那么 编译器会拒绝我们对 const 变量做修改的行为 . 

```c++
  int       normalVal = 100;
  const int constVal  = 200;

  const int* pNormalVal = &normalVal;
  const int* pConstVal  = &constVal;

  *const_cast<int*>(pNormalVal) += 1;   /* 合理操作 ,  */
  std::cout << normalVal << std::endl;  /* 输出 101 */

  *const_cast<int*>(pConstVal ) += 1;   /* 未定义行为 */
  std::cout << constVal << std::endl;   /* 输出 200 没有如预期那般 自增 1 , 
                                           但是需要明确是是 , 未定义行为的含义为 : 可能无效/可能非预期效果/可能崩溃 , 
                                           随着运行次数增加可能出现任何的结果 */
```

#### 6.1.3. 有必要先了解下 volatile 关键字
参考 : https://zhuanlan.zhihu.com/p/33074506

volatile含义
- volatile 字面意思 易变的 . 
- 英文释义 : A situation that is volatile is likely to change suddenly and unexpectedly. 
   - 可能突然发生出人意料的变化 就是 volatile
      - 可能变可能不变
      - 不知道什么时候变
      - 不知道发生什么变化
      - 总是切都是不可预期的

当我们程序中的某个变量值除了受到我们自己写的程序控制外 , 还受到其他的影响 , 我们无法对这个变量的值做出某种预期的时候就应该用 volatile 修饰 .
volatile


volatile 的使用 和 const 很像 
```c++
int* const  cpFlag;  /* 指针本身不可修改 */
const int*  pcFlag;  /* 指针指向的变量不可修改 */

int* volatile vpFlag;   /* 指针对象本身不稳定 */
volatile int* vpFlag;   /* 指针指向的对象不稳定 */
```


一个应用场景 , 就是多线程共享的 对象 . 单一线程永远无法对这个共享变量做出任何预期 . 
`volatile` 可以组织编译器对代码做出优化 . 
```c++
int* p = /* ... */;
int a, b;
a = *p;
b = *p;

// CPU 获取 指针 p 所指向对象的时候 , 会先将 p 本身放到寄存器中 . 
// 对 a,b 的赋值动作之前 把 p 放到寄存器即可 . 


--------------------------------------------------
int* volatile p = /* ... */;
int a, b;
a = *p;
b = *p;

// 由于 p 是 volatile 的 , 在为 a 复制前需要读取一次 p 的实际值(从内存读到 寄存器) . 
// 为了防止 为 b 赋值之前 p 被修改 , 为p 赋值前还要再重新 将 p 从内存读到寄存器中 . 

```

#### 6.1.4. 再说 const_cast 关于 volatile
`cppreference.com` 说 : 尤其是只有 const_cast 可以用来移除常量性或易变性。

与 `6.1.2` 类似 , 略...

### 6.2. static_cast 

- 只有在不抹除 `const` / `volatile` 性质的类型转换才能使用 `static_cast`
- 用隐式和用户定义转换的组合在类型间转换。

```c++
float floatVal = 123.123f;
int   intVal1  = (int)floatVal;                 /* 强制类型转换, 编译有警告信息 */
int   intVal2  = floatVal;                      /* 默认隐式转换编译有警告信息 : 
                                                   warning: conversion from ‘float’ to ‘int’ may change value [-Wfloat-conversion] */
int   intVal2  = static_cast<int>(floatVal);    /* 编译无警告信息 */
```

也可以用于找回存在 `void*` 的 指针
```c++
    /* 其他例子 : https://zh.cppreference.com/w/cpp/language/static_cast */
    // 10. void* 到任何类型
    void* voidp = &e;
    std::vector<int>* p = static_cast<std::vector<int>*>(voidp);
```



### 6.3. dynamic_cast 动态类型转换

运行时类型识别(run-time type identification RTTI) , 涉及到两个关键字
- typeid , 用于返回表达式的类型
- dynamic_cast , 用于将基类的指针或引用安全的转换为派生类的指针或引用 ; 沿继承层级向上、向下及侧向，安全地转换到其他类的指针和引用。
- 我们这里主要讨论 dynamic_cast 

#### 6.3.1. 不妨先了解下 静态类型(静态联编) / 动态类型(动态联编) 的概念

```c++
class GrandFather { virtual void seyHi() {} ;};
class Father : public GrandFather { void seyHi() override {}; };
class Mather { void seyHi() override {}; };
class Son    : public Father, public Mather {};


GrandFather grandFather;
Father      father;

GrandFather  one   = father;
GrandFather* two   = &father;
GrandFather& three = father; /* 
在编译阶段 , GrandFather 是 one 的静态类型  ;
在运行阶段 , Father      是 one 的动态类型  ;
   假设 调用了 one.seyHi() 
   只有在运行阶段 , 才知道到底是调用了那个具体的函数 . 
 */

```

#### 6.3.2. 再了解 dynamic_cast
```c++
/* 还是基于 6.3.1 的代码继续讨论 */
Son          son;
GrandFather  grandFather  = son;                                    /*       隐式类型转换 , 赋值语句没问题 */
GrandFather& pGrandFather = son;
Father       fatherOne    = son;                                    /*       隐式类型转换 , 赋值语句没问题 */
//Father       fatherTwo = grandFather;                            /* 错误 : 不能将基类型转换为派生类行  */
Father       fatherThree  = dynamic_cast<Father>(pGrandFather);     /* 错误 : error: invalid target type 'Father' for dynamic_cast; target type must be a reference or pointer type to a defined class  目标类型必须是已定义类型的引用或指针*/
Father&      fatherFore   = dynamic_cast<Father&>(grandFather);      /*      terminating with uncaught exception of type std::bad_cast: std::bad_cast */ 
Father&      fatherFive   = dynamic_cast<Father&>(pGrandFather);     /*        正确 */
Mather       matherOne    = son;                                    /*       隐式类型转换 , 赋值语句没问题 */
// Mather       matherTwo   = fatherThree;                          /* 错误 : 不能将某类型转换为不想管类型 */
Mather*       matherThree = dynamic_cast<Mather*>(&fatherFive);     /*       告诉编译器放手去转换类型吧 , 程序员对此负责 */
```

dynamic_cast 只能处理 引用 或者 指针 类型的数据 , 被转换对象和转换目标 , 只能是 引用 或 指针 类型对象 . 


### 6.4. reinterpret_cast 

```c++
reinterpret_cast < 新类型 > ( 表达式 )		
```


与 const_cast 类似，reinterpret_cast 表达式不会编译成任何 CPU 指令(例外不表) . 
它是一个编译时指令，指示编译器将 `表达式` 视为如同具有 `新类型` 类型一样处理。

对于 `表达式` 指定的内存区域 , 通过此语句 , 可以用 `新类型` 来对内存做出解释 . 
- 不允许在 `函数指针` , `数据指针` 间 互转

https://www.geeksforgeeks.org/reinterpret_cast-in-c-type-casting-operators/
- 它用于将某种数据类型的指针转​​换为另一种数据类型的指针，即使转换前后的数据类型不同。
- 它不检查指针类型和指针指向的数据是否相同。


### 6.5. 对于显示类型转换 ② 的小结

`const_cast` : 抹除 底层 const , volatile 性质

`static_cast` : 将隐式转换显示化 , 这能避免编译器报错 , 就程序员是可以明确的表达 "转换" 这件事

`dynamic_cast` : 主要完成从基类引用或指针 , 向 派生类引用或指针 的转换

`reinterpret_cast` : 对某个指针指定的内存区域做另外的解释

无论如何类型转换 , 是一件应该尽量避免的事情 ; 强制类型转换更要慎重 , 避免引起不必要且难以追踪的异常 . 







