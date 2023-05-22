## 一、 内联汇编（英语：Inline assembly）
1. 就是在C语言中可以插入汇编语言

> `__asm__ __volatile__("hlt"); "__asm__"`表示后面的代码为内嵌汇编，"asm"是"`__asm__`"的别名。"`__volatile__`"表示编译器不要优化代码，后面的指令 保留原样，"volatile"是它的别名。括号里面是汇编指令。

### Reference
1. [内联汇编](https://baike.baidu.com/item/%E5%86%85%E8%81%94%E6%B1%87%E7%BC%96/3183809?fr=aladdin)
2. [内联汇编](https://zh.wikipedia.org/wiki/%E5%86%85%E8%81%94%E6%B1%87%E7%BC%96)
3. [GCC在C语言中内嵌汇编` asm __volatile__ `](https://blog.csdn.net/pbymw8iwm/article/details/8227839)
4. [`__asm__ __volatile__("": : :"memory")`等系列问题](https://blog.csdn.net/lidaqiang99/article/details/12240611)


## 二、 内存屏障(Memory barrier)
首先需要明确的是，程序在运行起来，内存访问的顺序和程序员编写的顺序不一定一致，基于这个前提下，Memory barrier 就有存在的必要了。看一个例子：
```C
x = r;
y = 1;
```
这里，y = 1 在实际运行中可能先于 x = r 进行。实际上，在单线程环境中，这两句谁先执行谁后执行都没有任何关系，它们之间不存在依赖关系，但是如果在多线程中 x 和 y 的赋值存在隐式依赖时：
```C
// thread 1
while (!x);

// memory barrier
assert(y == r);

// thread 2
y = r;
// memory barrier
x = 1;
```
此代码断言就可能失败。Memory barrier 能够保证其之前的内存访问操作先于其后的完成。

作者：Name5566
链接：https://www.zhihu.com/question/20228202/answer/24959876
来源：知乎
著作权归作者所有。商业转载请联系作者获得授权，非商业转载请注明出处。

## 三、 断言 assert
不说编程语言，单论中文：**断言** 表示在事实没有发生的情况下对即将发生的事情做出预判。

当然了这种预判可能符合即将发生的事实也可能不符合即将发生的事实。

我们将上述逻辑复用在编程语言中。

在使用C语言编写工程代码时，我们总会对某种假设条件进行检查，断言就是用于在代码中捕捉这些假设，可以将断言看作是异常处理的一种高级形式。断言表示为一些布尔表达式，程序员相信在程序中的某个特定点该表达式值为真。可以在任何时候启用和禁用断言验证，因此可以在测试时启用断言，而在部署时禁用断言。同样，程序投入运行后，最终用户在遇到问题时可以重新起用断言。它可以快速发现并定位软件问题，同时对系统错误进行自动报警。断言可以对在系统中隐藏很深，用其它手段极难发现的问题可以用断言来进行定位，从而缩短软件问题定位时间，提高系统的可测性。实际应用时，可根据具体情况灵活地设计断言。

通过上面的讲解我们对于断言算是有了一个大概的了解，那么接下来我们就来看看C语言中assert宏在代码中的使用。

原型定义：

void assert( int expression );

assert宏的原型定义在<assert.h>中，其作用是先计算表达式 expression ，如果expression的值为假（即为0），那么它先向stderr打印一条出错信息，然后通过调用abort 来终止程序运行。

下面来看看一段代码：
```C
#include <stdio.h>
#include <assert.h>

int main( void )
{
      int i;
   i=1;
   assert(i++);


   printf("%d\n",i);

       return 0;
}
```
运行结果为：
> 2

看看运行结果，因为我们给定的i初始值为1，所以使用assert(i++);语句的时候不会出现错误，进而执行了i++，所以其后的打印语句输出值为2。如果我们把i的初始值改为0，那么就回出现如下错误。
> Assertion failed: i++, file E:\fdsa\assert2.cpp, line 8

### Reference
1. https://blog.csdn.net/bigloomy/article/details/6614491
