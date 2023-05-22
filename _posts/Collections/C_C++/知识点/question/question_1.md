## 一、 指令集
针对 C/C++ 变成如何查看处理器架构，或者，如何查看处理器指令集。
不同 CPU 对应不同指令集，这个历史还是要在回顾啊

```C++
struct pt_regs reg; //ptrace.h
long ptrace_result = ptrace(PTRACE_GETREGS,pid,nullptr,&reg);
```

## 二、 共享库
`/system/lib/libc.so` 这个库文件有什么特殊的作用或者用途吗？

## 三、 `/proc/×××/maps`

文件中同一个同一个文件在多行中显示是什么原因？
> 暂时不深究，不过暂时的猜测是一个文件的多个段。
> 老师说读过 Linker 之后就明白这一切了。
```
00400000-004f4000 r-xp 00000000 08:11 130819                             /bin/bash
006f3000-006f4000 r--p 000f3000 08:11 130819                             /bin/bash
006f4000-006fd000 rw-p 000f4000 08:11 130819                             /bin/bash
006fd000-00703000 rw-p 00000000 00:00 0 
011db000-013a7000 rw-p 00000000 00:00 0                                  [heap]
7ff71327a000-7ff713285000 r-xp 00000000 08:11 786268                     /lib/x86_64-linux-gnu/libnss_files-2.23.so
7ff713285000-7ff713484000 ---p 0000b000 08:11 786268                     /lib/x86_64-linux-gnu/libnss_files-2.23.so
7ff713484000-7ff713485000 r--p 0000a000 08:11 786268                     /lib/x86_64-linux-gnu/libnss_files-2.23.so
7ff713485000-7ff713486000 rw-p 0000b000 08:11 786268                     /lib/x86_64-linux-gnu/libnss_files-2.23.so
```

## 四、 中断 `0x80`
都说这是中断，使用了执行系统调用的，上层应用(java)通过 jni 调用 native 层 c 代码，然后 c 通过中断完成上层应用的具体的业务逻辑。

1. 但是这个中断到底是什么
2. 中断这件事到底是怎么一回事
3. 中断这件事发生在一个什么流程里
4. 中断做了什么

### 4.1、 Reference
1. [Linux0.11内核--系统中断处理程序int 0x80实现原理](http://blog.csdn.net/heikefangxian23/article/details/51071825)
2. []()
