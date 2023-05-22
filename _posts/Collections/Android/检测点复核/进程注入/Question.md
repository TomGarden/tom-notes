## 一、 在查看进程注入的代码逻辑的时候发现了问题：
1. 源码来源：http://blog.csdn.net/weihe6666/article/details/44544477
2. 问题描述
    - 代码中有一行：`get_remote_addr(target_pid, libc_path, (void *)mmap);`
    - 问题出在， `mmap` 这个变量没有声明也没有初始化，就这么硬生生的被做了一次转义然后就使用了。
3. 问题分析
    - 正常情况下 `mmap` 应该是先声明后使用但是在源文件中没有找到声明相关的代码
        - 继续沿着这个思路走，那就应该是在某个头文件中声明了吧
        - 但是通过 VSCode 的 `Ctrl+click` 没有找到线索
    - 当前已经知道了 Linux 系统有一个 `mmap` 方法但是该方法是带参数的，如上述代码般调用我不认识
        - 要么是语法不了解
            - 为此查看了`函数指针`概念，未匹配上

## 二、 中断 `0x80`
都说这是中断，使用了执行系统调用的，上层应用(java)通过 jni 调用 native 层 c 代码，然后 c 通过中断完成上层应用的具体的业务逻辑。

1. 但是这个中断到底是什么
2. 中断这件事到底是怎么一回事
3. 中断这件事发生在一个什么流程里
4. 中断做了什么

## 三、 寄存器变量通过数组赋值
这可能需要了解方法在内存中的存储结构，比如方法地址，参数地址，这些是怎么排列，`作者`怎么确定这个方法按照这个方式填充到内存其中就没有问题呢？
```C++
struct user_regs_struct
{
  long int ebx;
  long int ecx;
  long int edx;
  long int esi;
  long int edi;
  long int ebp;
  long int eax;
  long int xds;
  long int xes;
  long int xfs;
  long int xgs;
  long int orig_eax;
  long int eip;         //eip是指令寄存器
  long int xcs;
  long int eflags;
  long int esp;         
  long int xss;
};
