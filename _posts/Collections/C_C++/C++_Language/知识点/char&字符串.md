

## 0x01. char 指针可以逐个字符处理 , 并判断那里是末尾字符吗

我们是想通过入参一个 char 指针 , 遍历这个指针所指向的字符串中的每个字符 . 

对于字符串常量(实际上是一个字符数组) , 我们可以通过 `\0` 来判断是否到达了末尾字符 . 

但是 char 指针我们可以吗 ?  
- 答案是做不到 . 指针只是指向了一个内存地址 , 再无其他任何信息 , 所以什么也没办法保证 . 

```c++
//我们可以定义字符串常量 , 对于英文
char charAryEN[] = "four";
cout << charAryEN << ":" << strlen(charAryEN) << endl;  //输出长度为 4
cout << charAryEN << ":" << sizeof(charAryEN) << endl;  //输出内存为 5 // 字符数组以空字符 '\0' 结尾 , 所以内存占用诶 5

//对于中文
char charAryZH[] = "三个字";
cout << charAryZH << ":" << strlen(charAryZH) << endl;  //输出长度为 9
cout << charAryZH << ":" << sizeof(charAryZH) << endl;  //输出内存为 10

char charAry[] = {"一\0共五个字"};
cout << "charAry --> \t  " << charAry << ":" << strlen(charAry) << endl;  //3
cout << "charAry --> \t  " << charAry << ":" << sizeof(charAry) << endl;  //17 (含两个 '\0')

//即使我们使用 `std::string` 得到的也不是预期值
std::string strZH = "三个字";
cout << strZH << ":" << strZH.length(strZH) << endl;  //输出长度为 9
```

做过测试我们可以知道 `strlen(const char *input)` 函数实际做的事情是 , 
从 input 指向的第一个字节开始计数, 直到一个 '\0' 字符为止(不包含) . 
- 如果 input 指向的字符串没有以 `\0` 结尾 ; 触发未定义行为 . 
- 如果 input 指向的字符串中含有 `\0` ; `\0` 以及其之后的字符不计入内 . 


### 1.1. 总结一下 
上一节有两个问题
1. 我们无法 100% 可靠的遍历一个 char 指针指向的字符串 . 
2. 当我们的 char 指针指向多字节字符(比如中文) , 的时候我们甚至不知道应该如何遍历才好 . 
    - 统一回答 1/2 两个问题 . 
    - 就目前所知而言 , 世界上有许多种类的字符编码 .
    - 在直接操作字节上的数字的情况下 , 我们需要分辨各种字符编码的特性从而可以分辨是那种编码从而知道选取几个字节对应那个字符 . 
    - 这个工作量有些大 . 
3. 我们终究是想要一种表示字符串的方法 , 这个表示方法 , 可以将其中的 英文字母做大小写转换 . 
    - 这种表示方法可以从 `char*` 转换而来 .  

* 如果我终究无法妥善解决上述问题 , 我也想搞清楚 , 为什么解决不了 . 


## 0x02. 查找 char 类型定义
1. https://en.cppreference.com/w/cpp/language/types
2. https://stackoverflow.com/questions/19532785/difference-between-char-and-wchar-t
3. [字符串字面值](https://zh.cppreference.com/w/cpp/language/string_literal)

- `signed char` : 表示有符号字符

- `unsigned char` : 表示无符号字符

- `char` : 具有有符号(`signed char`)和无符号(`unsigned char`)两种表现形式 , 但始终是两种类型 . 
    - `C++11` : `unsigned char` 的范围是 `[0,255]` ; 转换为 `char` 再转换为 `unsigned char` 可以得到原始值 . 
    - 是否有符号依赖于平台编译器 . ARM 、PowerPC 通常无符号 ; x86 、x64 通常有符号

- `wchar_t` : 表示宽字符 . 
    - `C++23` : 足够大 , 以表示任何支持的字符 . 
    - 它与某种整数类型具有相同的 大小 、 符号、 对齐方式 ; 但他是一种独立的类型 . 
    - Linux 平台上 , 它是 32 位 , 保存 UTF-32 字符 ; Windows 平台 , 它是 16 位 , 保存 UTF-16 . 

- `char16_t` : 表示 UTF-16 字符 . 请求足够的空间保存 UTF-16 码 . 
    - 与 `std::uint_least16_t` 具有相同的 大小 、符号、对齐方式 . 
    - 但是是一种独立类型 . 

- `char32_t` : 表示 UTF-32 字符 . 请求足够的空间保存 UTF-32 码 . 
    - 与 `std::uint_least32_t` 具有相同的 大小 、符号、对齐方式 . 
    - 但是是一种独立类型 . 

- `C++20` : `char8_t` :  表示 UTF-8 字符 . 请求足够的空间保存 UTF-8 码 . 
    - 与 `unsigned char` 具有相同的 大小 、符号、对齐方式 (因此也与 `char` 、 `signed char` 有相同的 尺寸、对齐方式 ). 
    - 但是是一种独立类型 . 


### 2.1. 字符串赋值

Debian 11   &  Arm 64

``` c++
  cout << "loclae:" << std::setlocale(LC_ALL, NULL) << endl;   // 输出 'loclae:C'

  // 无法正常计数字符数
  char cp[] = "你好啊";             //sizeof(cp)/sizeof(char) : 10/1=10
  cout << cp << endl;         // 打印正常 , 可以正常展示中文字符

  /* 计数正确却因为 末尾的 '\0' 导致比实际字符数大一
     无法正常打印
  */
  char32_t cp32[] = U"你好啊";      // sizeof(cp32)/sizeof(char32_t) : 16/4=4
  char16_t cp16[] = u"你好啊";      // sizeof(cp16)/sizeof(char16_t) : 8/2=4
  wchar_t cpw[] = L"你好啊";        // sizeof(cpW)/sizeof(wchar_t) : 16/4=4

  // 未测试
  char8_t cp8t[] = u8"你好啊";       // (C++20 起)
```

### 2.2. 字符打印
```c++
char cp[] = "你好啊"; 
cout << cp << endl;           // 输出为  你好啊

wchar_t cpw[] = L"你好啊";
wout << cpw << endl;          // 输出为  `}J
```

**还没有搞清楚 , 为什么 char 指针指向的中文字符串可以正常输出 , wchar_t 指针指向的中文字符就无法输出了 .**
- 已验证 默认的 `cout.getloc().name()` 为 `C` . 
  这种情况 , cout 可以在控制台打印中文 , 或许可以理解为 , 我们的操作系统已经设置了支持中文 . 
- 已验证 默认的 `wcout.getloc().name()` 为 `C` . 
  为什么相同的系统这时候 , 就输出乱码了 ?

## 0x03. 关于 gcc 对字符集处理的一点理解
- https://gcc.gnu.org/onlinedocs/gcc-10.2.0/cpp/Character-sets.html
- https://gcc.gnu.org/onlinedocs/gcc-4.1.2/cpp/Character-sets.html
- https://stackoverflow.com/q/27871124/7707781

- 源字符集(source character set)  : 我们源代码文件使用的字符集
- 基本源字符集(basic source character set) : 含96个字符 , 都是ASCII字符 .
- 执行字符集(execution character set) : 编译器将源字符集转换为执行字符集 . UTF-8
   - 如果我们的文件编码是编译器 不认识(不支持) 的 , 在转换过程中可能有偏差或者错误 . 
   - gcc 默认的执行字符集(-fexec-charset=charset)是 UTF-8
   - gcc 默认的输入字符集(-finput-charset=charset)是 UTF-8

### 3.1. [C 语言国际化](https://en.wikipedia.org/wiki/C_localization_functions)
```c
#include <clocale>

std::setlocale(LC_ALL, "zh_CN.UTF-8");  // setlocale 为 C 语言设置全局的语言配置信息
printf("locale:%s\n", std::setlocale(LC_ALL, NULL));
const wchar_t cpW[] = L"你好啊";
printf("printf2:%ls\n", cpW);           // 款字符 'ls'
```

C 标准本地化函数受到批评，因为本地化状态是全局存储的。这意味着在给定程序中，所有涉及语言环境的操作一次只能使用一个语言环境。因此，很难实现使用多个语言环境的程序。

### 3.2. C++ 语言国际化

```c++
std::ios_base::sync_with_stdio(false);
wcout.imbue(locale("zh_CN.UTF-8"));
cout << "\nloclae:" << std::setlocale(LC_ALL, NULL) << endl;
wcout << "****************************" << /* cp32 << */ cpW << endl;
```

`wcout.imbue` : https://m.cplusplus.com/reference/ios/ios_base/sync_with_stdio/
- 默认 ， iostream 对象和 cstdio 流是同步的（就好像这个函数是true作为参数调用的）
- 如果在程序执行其第一个输入或输出操作之前调用它，则打开或关闭所有 iostream 标准流与其对应的标准 C 流的同步。

1. https://stackoverflow.com/a/26520333/7707781
2. https://stackoverflow.com/a/31577195/7707781

我理解到这个同步指的是输出的先后顺序 , 同步会调用顺序输出 , 不同步无法保证打印语句的先后打印顺序 . 

但是这个顺序和字符编码的解析有什么关系是我不知道的 . 


### 3.3. 猜测
有没有可能 , 实际上 c++ 在处理中文过程中 , 虽然内存中存储的是 , utf-8 中文 编码 .
但是在打印的时候 , 受到国际化设置的影响 , 到时对内存中的编码做了不同的解读 . 
从而正常设置国际化字符可以正常打印 , 错误设置国际化字符造成异常打印 . 

这不免产生一个新的问题 : 既然已经有了世界通用的编码 , 为什么不直接支持它呢. 如果没有直接支持 , 可以通过某些配置函数完成这种支持吗 . 
就是说 , 所有涉及编码的的地方全部使用 utf-8 编码, 这样所有语言编码都可以正常支持了 . 

## 0x04. 理解编码细节 , 做不同编码之间的转换

ASCII 码占用 8位(一字节) 的内存空间 . 最多有 256 个字符 . 

想要从 char 指针 转换得到 wchar_t 指针 , 就需要查看每个字节码的特征 , 看看是一个 ascii 码还是一个 Unicode 码 . 
这才不至于转换成乱码 . 

## 0x05. `char*` to `wchar_t*`

- https://zh.wikipedia.org/wiki/字符编码      
- https://zh.wikipedia.org/wiki/Unicode





## 0x06. 问题串联

### 6.1. 计算指针变量所指向对象所占用内存 (失败) (无遗留)

最初 , 我们是想遍历中英结合的 `char` 字符串 , 好将其中的英文字符完成大小写的转换 . 

在计数的时候我们发现 , `sizeof` 计算的是 `char*` 指针变量所占用的内存 
- 一个 64 位机器上 , `sizeof(指针)` 是 `8 字节` . 
- `sizeof(数组)` ,  计算的是整个数组占用的内存

从而对于计算数组长度的需要
- `sizeof(char指针)/sizeof(char)` 无意义
- `sizeof(char数组)/sizeof(char)` 只有 ascii 码情况下成立 . (为什么是只有 ascii 后面说)
- 要计算字符串中的字符个数 , 我们还尝试了 `strlen`
    - 如果 input 指向的字符串没有以 `\0` 结尾 ; 触发未定义行为 . 
    - 如果 input 指向的字符串中含有 `\0` ; `\0` 以及其之后的字符不计入内 . 
    - 所以如果输入中含有 '\0' 则计算结果是错误的 . 
    - 当然了也只有在 ascii 码的情况下计算结果才有意义

```c++
const char str[] = "中文";
std::cout << "预期计算字符数: " << std::strlen(str) << '\n'
          << "预期计算占用字节数: " << sizeof str << '\n';


/**
预期计算字符数: 6
预期计算占用字节数: 7 (含有末尾的 '\0' ; 所以每个中文字符实际占用了 3 个字节) 
*/
```

### 6.2. 宽字符 与 打印异常 (有遗留)

了解了中文并非单字节可以表达的 , 我们想 , 那改用多字节表达就可以简单的计算字符数了 . 

`char16_t` 、`char32_t`、`wchar_t` 都是多字节 char 
- `char16_t` 、`char32_t` 没有单独对应的 输出函数 , 暂不深入
- 使用了 `wchar_t` 确实可以满足 `sizeof(char数组)/sizeof(char)` , 可以准确计算字符数了 .

我们发现 `wchar_t` 对应的打印能力需要 `wcout` 
- 尝试了一下发现打印乱码 `代码块①`
  ```C++
  //计算机已经支持了 zh_CN.UTF-8 ("/etc/locale.gen" 文件有 "zh_CN.UTF-8" 行)
  //std::ios_base::sync_with_stdio(false);
  //wcout.imbue(locale("zh_CN.UTF-8"));
  cout << "wcout.getloc().name()-->" << wcout.getloc().name() << endl;  //wcout.getloc().name()-->C
  const wchar_t cpW[] = L"你好啊";                                       
  wcout << cpW << endl;                                                 //乱码
  ```
- 随机我们测试了 char 相关代码
  ```C++
  cout << "wcout.getloc().name()-->" << wcout.getloc().name() << endl;  //wcout.getloc().name()-->C
  const char cp[] = "你好啊";                                       
  cout << cp << endl;                                                  // 你好啊 (正常输出)
  ```

我也知道对于 `wcout` 如何便可以正常打印中文字符了
  ```C++
  //计算机已经支持了 zh_CN.UTF-8 ("/etc/locale.gen" 文件有 "zh_CN.UTF-8" 行)
  std::ios_base::sync_with_stdio(false);
  wcout.imbue(locale("zh_CN.UTF-8"));
  cout << "wcout.getloc().name()-->" << wcout.getloc().name() << endl;  //wcout.getloc().name()-->C
  const wchar_t cpW[] = L"你好啊";                                       
  wcout << cpW << endl;                                                 //乱码
  ```

我对 `cout` 可以直接打印 `中文 char*` , `wcout` 却需要 配置后才可以打印  `中文 wchar_t*` 的表现 , 感到奇怪 . 

### 6.3. `char*` to `wchar_t*` (未解决)

由于 main 函数只能接收 `char *argv[]` 指向字符串的指针的数组 . 

我们需要逐个字符判断和处理 , 就需要将 `char*` 转换为 `wchar_t*` . 

```c
//我想使用三方库是比较方便的选择吧 . 
```

### 6.4. 尝试原生转换 -- C 语言

使用三方库前 , 我们还是像看看 C 或 C++ 本身到底是否提供了转换能力 . 

C 函数库有专门针对字符宽窄转换的能力 `<wchar.h>` 或者是 `<cwchar>` . 
其中两个函数确实可行 .
```C++
/** 
  单字符转换 
  运行后:
    1. 完成单字符转换 , 只转换了一个 '我' 字
    2. length 值为三  
*/
void convertSignelChar() {
  //我系统已经安装好了 zh_CN.UTF-8
  //setlocale(LC_CTYPE, "zh_CN.UTF-8");
  // 实际上 , zh_CN.UTF-8 传达的信息为 , 中文 , 中国 , 使用 UTF-8 字符集 , 中文中国 , 对时间或者货币表达有影响 , 对排序规则有影响.
  // 我们的需求仅仅是要扩展字符集 , C.UTF-8 就够了 . 
  setlocale(LC_CTYPE, "C.UTF-8");
  const char str[] = {"我是中文字符串"};
  wchar_t dest;
  size_t length = mbrtowc(&dest, str, sizeof(str), NULL);
}

/** 
  字符串转换转换 
  运行后:
    1. 完成单字符转换 , 整个字符串都转换了
    2. length 值为七 , 含末尾的 '\0'  
*/
void vonvertChars() {
  //我系统已经安装好了 zh_CN.UTF-8
  //setlocale(LC_CTYPE, "zh_CN.UTF-8");
  setlocale(LC_CTYPE, "C.UTF-8");
  const char str[] = {"我是中文字符串"};
  const char *charAryP[] = {str};
  wchar_t dest[10];
  size_t length = mbsrtowcs(dest, charAryP, sizeof(str), NULL);
}
```

在线测试这段代码 : http://coliru.stacked-crooked.com/a/1d34e2b6ad598ca0

C语言的 宽窄字符转换我们主要参考了两个地方
1. [提供了思路](https://forums.raspberrypi.com/viewtopic.php?t=331068)
2. [C18语言标准 ISO/IEC 9899:2018 INFORMATION TECHNOLOGY — PROGRAMMING LANGUAGES — C](https://www.iso.org/standard/74528.html)
    - 查看标准文当前 , 也看了 [cplusplus](https://m.cplusplus.com/reference/cwchar/mbrtowc/) 、 [cppreference](https://en.cppreference.com/w/c/string/multibyte/mbrtowc) 、 [腾讯社区](https://cloud.tencent.com/developer/section/1009599) .
        无一例外 , 每个字都认识 , 放在一起就让人怀疑人生了 . 
        这些文档可能写的人比较熟悉 , 或者就是直接机器搬运的 , 标准上的介绍更清晰些 , 铺垫更多些 , 更适合人类阅读些 . 


### 6.5. 尝试原生转换 -- C++ 语言

C++ 有一个 codecvt  可以了解跟进下 . 
- 虽然未的尝试并没有成功 , 但是我注意到这个能力因为安全性的原因在 C++17 已经被弃用了 . 
- https://stackoverflow.com/a/18597384/7707781
- https://www.open-std.org/jtc1/sc22/wg21/docs/papers/2017/p0618r0.html
- 所以可以认定为 C++ 暂时没有比较好的方式进行宽窄字符转换了 . 
- 具体使用的是 localization library 中的 wstring_convert 函数
    - 具体细节在 C++11 标准文档中 有示例 : `22.3.3.2.2 string conversions`


## 参考
1. https://stackoverflow.com/q/21022644/7707781
2. https://en.cppreference.com/w/cpp/string/byte/strlen
3. https://www.zhihu.com/question/28887335
4. https://stackoverflow.com/q/31571430/7707781

C / C++ 是如何支持字符集的? 
1. [一个说法是 , 编码与操作系统和编译器](https://blog.csdn.net/weixin_39678525/article/details/111161645)
2. [gcc 使用 unicode , 在读取源码文件的时候进行转换](https://gcc.gnu.org/onlinedocs/gcc-10.2.0/cpp/Character-sets.html)
    - https://gcc.gnu.org/onlinedocs/gcc-4.1.2/cpp/Character-sets.html
3. [C 没有默认字符集的概念](https://stackoverflow.com/a/12204533/7707781)
4. c++ 标准中提到多个不同的字符集 , 在实际编译器的实现中 , 都是如何的
    - https://stackoverflow.com/q/27872517/7707781
    - https://stackoverflow.com/q/27871124/7707781
5. https://blog.csdn.net/yedawei_1/category_7772300.html
    - [十八](https://blog.csdn.net/yedawei_1/article/details/113757363)
    - [十七](https://blog.csdn.net/yedawei_1/article/details/113769765)
    - [十六](https://blog.csdn.net/yedawei_1/article/details/113771321)
6. [`cout` 和 `wcout` 不应该混合使用](https://stackoverflow.com/q/8947949/7707781)
    - http://www.cunningplanning.com/post/unicode-on-linux/


