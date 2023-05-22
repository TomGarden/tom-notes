
国际化标准组织发布了 C 语言标准 
- C Language Standard : C 语言标准
- International Organization for Standardization : 国际标准化组织 (ISO)
- 目前的版本(付费) : https://www.iso.org/standard/74528.html 
- 免费 PDF : https://github.com/EbookFoundation/free-programming-books/issues/3189


不同的组织对 C 语言标准有不同的实现代码 : https://en.wikipedia.org/wiki/C_standard_library 这个不同实现是保证了相同输入得到相同输出， 内部逻辑可能有差异。

不同的组织对 C 语言标准的实现又有不同的版本 。


要查看源代码需要确定 标准库 libc 的组织实现和具体版本。


例如 GNU libc 的实现和版本可以在这里查找 : [gnu libc source](https://www.gnu.org/software/libc/sources.html)

本机 GNU libc 代码版本可以从代码中查看 : 

```C
/* 对于 gnu libc 查看源码版本的方式是 查看这两个宏 ， 
   我的这个代码在 /usr/include/features.h 找到
   表达的版本含义是 2.31
*/
/* Major and minor version number of the GNU C library package.  Use
   these macros to test for features in specific releases.  */
#define	__GLIBC__	2
#define	__GLIBC_MINOR__	31
```