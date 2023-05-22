## 1. TEMP_FAILURE_RETRY(表达式)
涉及的知识点为 [GNU-C 扩展](https://blog.csdn.net/tigerjibo/article/details/8299557)


* 位置：unsited.h
```C++
/* Evaluate EXPRESSION, and repeat as long as it returns -1 with `errno'
   set to EINTR.  */

# define TEMP_FAILURE_RETRY(expression) \
  (__extension__							      \
    ({ long int __result;						      \
       do __result = (long int) (expression);				      \
       while (__result == -1L && errno == EINTR);			      \
       __result; }))
```

作用：当表达式的值为为 -1 并且 errno 为 EINTR 的时候进入死循环，直到不满足循环条件。

**__extension__** 关键字
- gun/c 的常用扩展语法
- 该关键字gnu对c语言的扩展，我们都加上了__extension__关键字,如果不加__extension__关键字，当我们编译的是加上-pedantic选项时，会产生警告信息，__extension__关键字就是说使用gun对c语言的扩展，编译时加上-pedantic选项不要产生警告信息

**复合语句**
- 标准C中，表达式指的是运算符和操作数的组合，而复合语句指的是由一个或多个被括在花括号里的语句构成的代码块。在标准C中，不允许将复合语句用于表达式中。
- 在GNU C中，允许用小括号括起来的复合语句出现在一个表达式中。这个表达式的类型为复合语句中以分号结尾的最后一个子语句表达式的类型，其值也为最后子表达式的值。


