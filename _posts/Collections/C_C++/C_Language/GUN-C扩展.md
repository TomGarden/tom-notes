https://blog.csdn.net/tigerjibo/article/details/8299557

# GNU C 特性

## 一、 GNU C之表达式中的复合语句
1.前言：

标准C中，表达式指的是运算符和操作数的组合，而复合语句指的是由一个或多个被括在花括号里的语句构成的代码块。在标准C中，不允许将复合语句用于表达式中。

在GNU C中，允许用小括号括起来的复合语句出现在一个表达式中。这个表达式的类型为复合语句中以分号结尾的最后一个子语句表达式的类型，其值也为最后子表达式的值。

实例：
```C++
#include <stdio.h>  
   main()  
   {  
           int  a = ({  
                      int b =4;  
                      int c =3;  
                      b+c;  
                      b+c-2;  
                   });  
          printf("a = %d\n",a);  
          return 0;  
  }  
```
上述代码的输出
```C++
jibo@jibo-VirtualBox:~/cv_work/work/GNUC/brace$ ./main
a = 5
```

## 二、 `__attribute__`
- https://gcc.gnu.org/onlinedocs/gcc-4.0.0/gcc/Function-Attributes.html
- https://blog.csdn.net/fantasy_wxe/article/details/8066551
- [`__attribute__` 总结](https://www.jianshu.com/p/29eb7b5c8b2d)
- [what “inline __attribute__((always_inline))” means in the function?](https://stackoverflow.com/questions/22767523/what-inline-attribute-always-inline-means-in-the-function?utm_medium=organic&utm_source=google_rich_qa&utm_campaign=google_rich_qa)

`__attribute__` 关键字主要是用来在函数或数据声明中设置其属性。给函数赋给属性的主要目的在于让编译器进行优化。