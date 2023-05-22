---
layout: post
title:  null
date:   2018-10-15 09:58:47 +0800
categories: jekyll update
author: Tom
---

-----------------------------
__目录__
- jekyll 的 kmarkdown 负责解析
{:toc}

-----------------------------
<br>

摘录：https://zh.wikipedia.org/wiki/Fork_(系统调用)

下列Hello World程序的变种以C语言展示了fork系统调用的机理。该程序fork为两个进程，每个都基于fork系统调用的返回值决定它们执行什么功能。样板代码中的头文件等已被省略。

```C
int main(void)
{
   pid_t pid = fork();/*#0x01*/

   if (pid == -1) {
      perror("fork failed");
      exit(EXIT_FAILURE);
   }
   else if (pid == 0) {/*#0x02*/
      printf("Hello from the child process!\n");
      _exit(EXIT_SUCCESS);
   }
   else {/*#0x03*/
      int status;
      (void)waitpid(pid, &status, 0);
   }
   return EXIT_SUCCESS;
}
```

通过执行 `man fork` 可以了解到：
-   fork() 以当前进程为模板创建一个新的进程。(我们成当前进程为 curProcess ,新进程为 newProcess)。
    curProcess 为 newProcess 的父进程；newProcess 为 curProcess 的子进程。



newProcess 与 newProcess 具有绝大部分精确相同内存数据。
-   curProcess 调用 fork() 方法前，(假设)当先系统中只有一个进程在运行(就是 curProcess)。
    当 fork() return 的时候当前系统中有两个正在运行的进程：curProcess 和 newProcess。
    并且他们的运行逻辑相同(都具有上述代码块的运行指令)，并且都运行到了 `#0x01` 处。
    -   在这种情况下，两个进程都会继续向下执行。不同之处在于：
        -    在不同的进程中 fork() 的 return 值有所不同(如果 newProcess 创建成功)
            -   curProcess 进程中 pid 的值为 newProcesss 的 pid
            -   newProcess 进程中 pid 的值为 0 。
        -   如果新进程创建失败会 return -1。此时系统中还是只有 curProcess 一个进程。
    -   也就是说在不同的进程中进入的 if 语句块会有所不同
        -   curProcess 将会执行 `#0x03` 块中代码，并继续执行后续逻辑。
        -   newProcess 将会执行 `#0x02` 块中代码，并继续执行后续逻辑