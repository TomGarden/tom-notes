
参考内容
1. https://www.runoob.com/cplusplus/cpp-preprocessor.html



预处理指令 `#define` 也成为 `宏` .

0. 开始
  - 宏定义没有先后顺序 , 编译器先收集所有的宏定义 . 然后处理代码 , 每发现一个宏的应用就替换为对应内容 . 


1. 符号替换符号
```c++
/* 代码中出现 PI 的地方在预处理阶段用 `3.14159` 替换 PI */
#define PI 3.14159
```

2. 带参的宏
```C++
#define MIN(a,b) (a<b ? a : b)
```

3. 字符串替换符号 `#`


4. [Variadic 宏](https://learn.microsoft.com/zh-cn/cpp/preprocessor/variadic-macros?view=msvc-170)
```c++
若要使用 variadic 宏，可以在宏定义中将省略号指定为最终形参，并且可以在定义中使用替换标识符 __VA_ARGS__ 来插入额外参数。 __VA_ARGS__ 将由与省略号匹配的所有参数（包括它们之间的逗号）替换。
```



5. [宏的展开顺序](https://www.cnblogs.com/JFHS/p/14689678.html)
```
宏展开顺序
宏展开顺序大致可以归结为：
第一步：首先用实参代替形参，将实参代入宏文本中
第二步：第一步代入实参后，分两种情况：
1、实参之前遇到#或或之后遇到##，不管实参是不是宏，实参都将不再展开
2、如果实参前后没有#或##，那就继续展开实参，展开发现还是宏则继续展开，直到展开到不能展开为止
第三步：最后继续处理宏替换后的宏文本，如果仍包含宏，则继续展开
参考：https://blog.csdn.net/FJDJFKDJFKDJFKD/article/details/83385708

宏展开的几个注意事项：
1、每次宏展开的结果会被重复扫描，直到没有任何可展开的宏为止。
2、每展开一个宏，都会记住这次展开，在这个宏展开的结果及其后续展开中，不再对相同的宏做展开。宏不能自引用：https://gcc.gnu.org/onlinedocs/cpp/Self-Referential-Macros.html
3、带参数的宏，先对参数做展开，除非宏定义体中包含#或##
a) #表示将后续标识符转换为字符串
b) ##表示将两个标识符连接成一个标识符
c) 注意参数展开的结果中即使有逗号（,），也不视为参数的分隔符
如果宏定义中带有参数，而代码中出现同样标识符时没有参数，不视为宏。
参考：https://www.cnblogs.com/aquastone/p/c-macro-expansion.html
https://blog.csdn.net/KeLiaoo/article/details/109329661
```


6. 预处理指令的顺序重要吗 ? https://stackoverflow.com/questions/22575319/does-order-matter-when-defines-are-using-other-defines

```c++
/* 写法 ① */
#define three 3
#define nine three*3

int main()
{
    std::cout << nine;
    return 0;
}

/* ==================== */

/* 写法 ② */
#define nine three*3
#define three 3

int main()
{
    std::cout << nine;
    return 0;
}
```

两种写法都可以正常运行 , 差别在于 , 
- 写法 ① 遍历一次预处理指令就可以完成 
- 写法 ② 需要遍历预处理指令 两次 

处理这种问题的时候需要注意避免预处理器死循环 . 