# 辨析 `define & typedef`

`define` 译作 `下定义`

## 一、 define 

- #define 标识符 替换列表(可选)	(1)	
- #define 标识符( 形参 ) 替换列表(可选)	(2)	
- #define 标识符( 形参, ... ) 替换列表(可选)	(3)	(C++11 起)
- #define 标识符( ... ) 替换列表(可选)	(4)	(C++11 起)
- #undef 标识符	(5)	


预处理命令
- define 指令定义 标识符 为宏，即指示编译器以 替换列表 替换 标识符 的所有后继出现，这能可选地额外处理。若标识符已定义为任何类型的宏，则程序为病式，除非定义等同。

### 1.1 更多内容请参考
https://baike.baidu.com/item/define/577777?fr=aladdin


## 二、 typedef
typedef - 创建能在任何位置替代（可能复杂的）类型名的别名。
- typedef 名是既存类型的别名，且不声明新类型。 typedef 不能用于更改既存类型名（包含 typedef 名）的含义。一旦声明，则 typedef 名只可重声明为再次指代同一类型。 typedef 名仅在它为可见的作用域有效：不同函数或类声明可定义有不同含义的同名类型。


### 2.1、 [转]typedef和define的详细区别
typedef是一种在计算机编程语言中用来声明自定义数据类型，配合各种原有数据类型来达到简化编程的目的的类型定义关键字。 #define是预处理指令。下面让我们一起来看。

### typedef是C语言语句，其功能是用户为已有数据类型取“别名”。

例如：
```C++
typedef int INTEGER；  
```
这以后就可用INTEGER来代替int作整型变量的类型说明了，如： 
```C++
INTEGER a,b;   
```
用typedef定义数组、指针、结构等类型将带来很大的方便，不仅使程序书写简单而且使意义更为明确，因而增强了可读性。例如：
```C++
typedef int a[10];//表示a是整型数组类型，数组长度为10。 
```
然后就可用a说明变量，如：
```C++
a s1,s2;//完全等效于：int s1[10],s2[10] ; 
```
同理 typedef void (*p)(void) 表示p是一种指向void型的指针类型！

### `#define`是预处理中的宏定义命令，例如：
```C++
#define int PARA  
```
表示在源程序中的所在int将会被PARA原样代替！

如：程序中有int a,b ;则在编译前将被替换为PAPA a,b;

### `#define`是C中定义的语法，typedef是C++中定义的语法，二者在C++中可以通用，但#define成了预编译指令，typedef当成语句处理。Typedef和define都可以用来给对象取一个别名，但是两者却有着很大不同。

#### 1． 首先，二者执行时间不同

关键字typedef在编译阶段有效，由于是在编译阶段，因此typedef有类型检查的功能。

Define则是宏定义，发生在预处理阶段，也就是编译之前，它只进行简单而机械的字符串替换，而不进行任何检查。

`#define`用法例子：
```C++
#define f(x) x*x  
main( )  
{  
int a=6，b=2，c；  
c=f(a) / f(b)；  
printf("%d \n"，c)；  
} 
```
程序的输出结果是: 36，根本原因就在于#define只是简单的字符串替换，应当加个括号“（X*X）”。

#### 2． 功能不同

Typedef用来定义类型的别名，这些类型不只包含内部类型（int，char等），还包括自定义类型（如struct），可以起到使类型易于记忆的功能。

如：
```C++
typedef int (*PF) (const char *, const char *); 
```
定义一个指向函数的指针的数据类型`PF`，其中函数返回值为`int`，参数为`const char *`。

typedef 有另外一个重要的用途，那就是定义机器无关的类型，例如，你可以定义一个叫 REAL 的浮点类型，在目标机器上它可以i获得最高的精度：
```C++
typedef long double REAL; 
```
在不支持 `long double` 的机器上，该 `typedef` 看起来会是下面这样：
```C++
typedef double REAL; 
``` 
并且，在连 `double` 都不支持的机器上，该 `typedef` 看起来会是这样：
```C++
typedef float REAL; 
```
`#define`不只是可以为类型取别名，还可以定义常量、变量、编译开关等。

#### 3． 作用域不同

`#define`没有作用域的限制，只要是之前预定义过的宏，在以后的程序中都可以使用。而typedef有自己的作用域。
```C++
void fun()   
{   
#define A int   
}  
void gun()   
{   
//在这里也可以使用A，因为宏替换没有作用域，   
//但如果上面用的是typedef，那这里就不能用A ，不过一般不在函数内使用typedef  
} 
```
#### 4． 对指针的操作

二者修饰指针类型时，作用不同。
```C++
Typedef int * pint；  
#define PINT int *  
Const pint p；//p不可更改，p指向的内容可以更改，相当于 int * const p;  
Const PINT p；//p可以更改，p指向的内容不能更改，相当于 const int *p；或 int const *p；  
pint s1, s2; //s1和s2都是int型指针  
PINT s3, s4; //相当于int * s3，s4；只有一个是指针。 
```
其实，typedef和define末尾的标号也是不一样的，希望大家不要忽略这一点。通过本文的分析，相信你已经了解了这两者之间的区别。掌握了区别之后，运用起来会更加的灵活。






## Reference
1. [文本替换宏 define](http://zh.cppreference.com/w/cpp/preprocessor/replace)
2. [typedef 指定符](http://zh.cppreference.com/w/cpp/language/typedef)
3. [**[精]** typedef和define的详细区别](http://developer.51cto.com/art/201104/256060.htm)
4. [typedef和#define的用法与区别](http://www.cnblogs.com/kerwinshaw/archive/2009/02/02/1382428.html)