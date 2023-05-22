1. 之前安装过 2 次数(覆盖安装)，每次都有一小点错误，但是忽略并继续安装，没有产生任何影响。
2. 这次安装是因为，学习 folly 的过程中又一次想要放弃转而使用 gflag ，所以安装了一次 gfalg ，再回过头来使用  folly 发现之前编译通过的命令和代码现在无法编译通过了，而且是链接问题。
  - 因为 folly 本身对 gflag 也有依赖，所以考虑是新安装的 gflag 对 folly 产生了一定的影响。
  - 所以我们再次重新安装 folly 企图通过覆盖的方式解决当前的问题。


make check error
```
collect2: error: ld returned 1 exit status
Makefile:1797: recipe for target 'range_test' failed
make[3]: *** [range_test] Error 1
make[3]: Leaving directory '/media/tom/document/Syn_Clode/Resources/folly-2018.01.08.00/folly/test'
Makefile:2950: recipe for target 'check-am' failed
make[2]: *** [check-am] Error 2
make[2]: Leaving directory '/media/tom/document/Syn_Clode/Resources/folly-2018.01.08.00/folly/test'
Makefile:2163: recipe for target 'check-recursive' failed
make[1]: *** [check-recursive] Error 1
make[1]: Leaving directory '/media/tom/document/Syn_Clode/Resources/folly-2018.01.08.00/folly/test'
Makefile:2315: recipe for target 'check-recursive' failed
make: *** [check-recursive] Error 1

```
