## 1. ISO C++ forbids converting a string constant to ‘char*’ [-Wwrite-strings]
```C++
char *maps_path;
maps_path = "/proc/self/maps";
```
上述情况
1. `"/proc/self/maps"` 的类型是 `const char *`  
2. `maps_path` 的类型是 `char`
3. `const char` -> `char` 是有风险的，(有风险的，具体风险我还不知道)
4. 可行的做法是 `maps_path = (char*)"/proc/self/maps";`

## 2. const char*, char const*, char*const的不同

Bjarne在他的The C++ Programming Language里面给出过一个助记的方法：**把一个声明从右向左读。** 
- `*` 读成 `pointer to` 
```C++
char * const cp; 
//cp is a const pointer to char 

const char * p; 
//p is a pointer to const char; 

char const * p; 
//同上因为C++里面没有const*的运算符，所以const只能属于前面的类型。 
```

### 2.1、[错误-1](https://www.jianshu.com/p/d88851ac5c34)
>warning: deprecated conversion from string constant to 'char*' [-Wwrite-strings]

```C++
char *dir = "/proc";//风险代码
```
`"/proc"`是一个字符串常量(`const char *`),所以这种做法出现转换错误