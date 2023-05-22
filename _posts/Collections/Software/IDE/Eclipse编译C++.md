1. [使用eclipse编译含有C++11特性的代码](http://blog.csdn.net/li396858359/article/details/7830354)
    - http://stackoverflow.com/questions/9131763/eclipse-cdt-c11-c0x-support
    

2. 调试 core : Can't find a source file at "/build/glibc-Cl5G7W/glibc-2.23/stdio-common/vfprintf.c" 
Locate the file or edit the source lookup path to include its location.
    - 可以不用解决观察 debug 视图的方法调用栈可以观察到风险

3. [Eclipse 调试 C++ core](https://stackoverflow.com/questions/16413123/eclipse-cdt-gdb-open-core-dump)
    - Run -> Debug Configurations... (scroll down if you don't see it) -> C/C++ Postmortem Debugger. Then fill in the C/C++ Application and Core file fields with your executable and coredump and hit the Debug button.

4. 一个运行时错误【不明白是为什么】
    ```C++
    char *file_cmdline_path = nullptr;
    sprintf(file_cmdline_path,"%s/%s/cmdline", "123", "456");
    ```