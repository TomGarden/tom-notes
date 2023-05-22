预处理：编译之前所做的处理。

参考内容不再抄录，写一下自己的理解

文件 a.h
```
# ifndef _A_H_
# define _A_H_

//c/c++ code

# endif
```
解释：

- 如果 `_A_H_` 已经被定义
  - 预处理器会处理 `# ifndef _A_H_` 和 `# define _A_H_` 之间的内容
  - 预处理器不再处理 `# define _A_H_`  和  `# endif` 之间的一切。

- 如果 `_A_H_` 尚未被定义
  - 预处理器不会会处理 `# ifndef _A_H_` 和 `# define _A_H_` 之间的内容
  - 预处理器会处理 `# define _A_H_`  和  `# endif` 之间的一切。
    - 定义 `_A_H_`

说明： `_A_H_` 和文件名(`a.h`)之间存在习惯的映射关系
  - `.` 用 `_` 替代
  - 小写字母转换为大写
  - 首位各增加 `_`
  - 但是上述三点的约定并非规定，遵守是个好习惯，不遵守也不是不可行的事。

## 参考 & 引用
1. 主、[#ifndef.#define, #endif 的用法](https://www.cnblogs.com/weekend/p/4794007.html)
2. 次、[#ifndef/#define/#endif使用详解](http://blog.csdn.net/abc5382334/article/details/18052757)
3. https://stackoverflow.com/questions/212006/multiple-definition-error-including-c-header-file-with-inline-code-from-multip
