## 用于收集记录一些自己会用到的选项(option)

手册页 https://linux.die.net/man/1/g++ 

`-I dir`

Add the directory _dir_ to the list of directories to be searched for header files. Directories named by -I are searched before the standard system include directories. If the directory dir is a standard system include directory, the option is ignored to ensure that the default search order for system directories and the special treatment of system headers are not defeated . If dir begins with "=", then the "=" will be replaced by the sysroot prefix; see --sysroot and -isysroot.

`-llibrary`

例如 : `g++ tidy_test.cpp -ltidy`

`-l` 的位置影响命令结果 , `g++ -ltidy tidy_test.cpp` 就会编译失败 ; 
目前理解为 : 链接动作在编译动作之后 , `g++ tidy_test.cpp -ltidy` 是一个先编译后链接的动作 .

