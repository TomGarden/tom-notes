对 gdb 有了大概的感知和理解之后进入使用阶段发现许多细节还是无法满足需求。

这个时候可以帮助我们的有
1. man gdb
2. gdb
  - help
  - help class


1. **[gdb 调试带参数的程序](https://www.cnblogs.com/rosesmall/archive/2012/04/10/2440514.html)**
  - `gdb <program>` //进入调试模式
    - `set args`  //后面加上程序所要用的参数，注意，不再带有程序名，直接加参数，如：`set args -l a -C abc`

2. gdb 设置断点
  



1. gdb --exec=elf2tlf --directory='/media/tom32/document/code/steady/elf2tlf'
  - 可以 run 一下
2. (gdb)set atgs -e lib*.so
  - 可以 run 一下
3. (gdb)break