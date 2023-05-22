官方网站 : https://www.boost.org/

文档 : https://www.boost.org/doc/libs/
- boost 是一个全称 , 在这个项目下包含了中了繁多的子库
- 有些库可能只需要引用头文件即可运行 , 不需要编译安装这些操作


我们首次使用 boost 是想使用用它的 stacktrace 子库 . 
- [官方介绍](https://www.boost.org/doc/libs/1_80_0/more/getting_started/unix-variants.html) 
  没有将其作为需要编译的子库介绍 , 但是我们只拷贝这两个文件夹 显然是不够的
    ```
    ├── boost_1_80_0_
    │   ├── boost
    │   │   └── stacktrace
    │   ├── libs
            └── stacktrace
    ```
- 调用代码
  ```c++
  #include "boost/stacktrace/stacktrace.hpp"
  ```
- 错误信息
  ```
  10: fatal error: boost/config.hpp: No such file or directory
   10 | #include <boost/config.hpp>
      |          ^~~~~~~~~~~~~~~~~~
  ```

超级简单的方式 : 
RedHat、Debian 和其他分发包提供 Boost 库包，但是如果您使用第三方包，您可能需要调整这些说明，因为它们的创建者通常选择将 Boost 分解为多个包，重新组织 Boost 分发的目录结构, 和/或重命名库二进制文件。如果您有任何问题，我们建议您使用SourceForge的官方 Boost 发行版。
```
sudo apt-get install libboost-all-dev
```


所以我们走一遍编译安装的流程吧 : 
```
// 进入 boost 文件夹下
cd boost


//设置安装路径 这是模式设置 , 可以跳过 , 除非要更改默认路径
//./bootstrap.sh --prefix=/usr/locale

// 查看那些库是必须要编译安装才能正常使用的 
./bootstrap.sh --show-libraries

// 更多操作可以查看 help 和 boost 文档
./bootstrap.sh --help 

// 不区分 安装所有库 , 会出现可预期的异常  , 具体查看文档 
sudo ./b2 install

// 区分 , 只安装本次需要的 stacktrace
sudo ./b2 --with-stacktrace install

// 更多操作可以查看 help 和 boost 文档
./b2 --help 
```


安装日志
```
tom@cxxEnv ➜  boost_1_80_0 sudo ./b2 --with-stacktrace install 
[sudo] password for tom: 
warning: No toolsets are configured.
warning: Configuring default toolset "gcc".
warning: If the default is wrong, your build may not work correctly.
warning: Use the "toolset=xxxxx" option to override our guess.
warning: For more configuration options, please consult
warning: https://www.bfgroup.xyz/b2/manual/release/index.html#bbv2.overview.configuration
Performing configuration checks

    - default address-model    : 64-bit (cached) [1]
    - default architecture     : arm (cached) [1]
    - libbacktrace builds      : yes (cached) [2]
    - addr2line builds         : yes (cached) [2]
    - WinDbg builds            : no  (cached) [2]
    - WinDbg builds            : no  (cached) [3]
    - WinDbgCached builds      : no  (cached) [2]
    - WinDbgCached builds      : no  (cached) [3]
    - libbacktrace builds      : yes (cached) [4]
    - addr2line builds         : yes (cached) [4]
    - WinDbg builds            : no  (cached) [4]
    - WinDbg builds            : no  (cached) [5]
    - WinDbgCached builds      : no  (cached) [4]
    - WinDbgCached builds      : no  (cached) [5]

[1] gcc-10
[2] gcc-10/release/threadapi-pthread/threading-multi/visibility-hidden
[3] gcc-10/release/build-no/threadapi-pthread/threading-multi/visibility-hidden
[4] gcc-10/release/link-static/threadapi-pthread/threading-multi/visibility-hidden
[5] gcc-10/release/build-no/link-static/threadapi-pthread/threading-multi/visibility-hidden

Component configuration:

    - atomic                   : not building
    - chrono                   : not building
    - container                : not building
    - context                  : not building
    - contract                 : not building
    - coroutine                : not building
    - date_time                : not building
    - exception                : not building
    - fiber                    : not building
    - filesystem               : not building
    - graph                    : not building
    - graph_parallel           : not building
    - headers                  : not building
    - iostreams                : not building
    - json                     : not building
    - locale                   : not building
    - log                      : not building
    - math                     : not building
    - mpi                      : not building
    - nowide                   : not building
    - program_options          : not building
    - python                   : not building
    - random                   : not building
    - regex                    : not building
    - serialization            : not building
    - stacktrace               : building
    - system                   : not building
    - test                     : not building
    - thread                   : not building
    - timer                    : not building
    - type_erasure             : not building
    - wave                     : not building

...patience...
...found 497 targets...
...updating 36 targets...
common.copy /usr/local/lib/libboost_stacktrace_noop.so.1.80.0
common.copy /usr/local/lib/libboost_stacktrace_backtrace.so.1.80.0
common.copy /usr/local/lib/libboost_stacktrace_addr2line.so.1.80.0
ln-UNIX /usr/local/lib/libboost_stacktrace_noop.so
ln-UNIX /usr/local/lib/libboost_stacktrace_backtrace.so
ln-UNIX /usr/local/lib/libboost_stacktrace_addr2line.so
common.copy /usr/local/lib/cmake/boost_stacktrace_noop-1.80.0/boost_stacktrace_noop-config.cmake
common.copy /usr/local/lib/libboost_stacktrace_basic.so.1.80.0
common.copy /usr/local/lib/cmake/boost_stacktrace_noop-1.80.0/libboost_stacktrace_noop-variant-shared.cmake
ln-UNIX /usr/local/lib/libboost_stacktrace_basic.so
common.copy /usr/local/lib/cmake/boost_stacktrace_noop-1.80.0/boost_stacktrace_noop-config-version.cmake
common.copy /usr/local/lib/cmake/boost_stacktrace_backtrace-1.80.0/boost_stacktrace_backtrace-config.cmake
common.copy /usr/local/lib/cmake/boost_stacktrace_backtrace-1.80.0/libboost_stacktrace_backtrace-variant-shared.cmake
common.copy /usr/local/lib/cmake/boost_stacktrace_addr2line-1.80.0/boost_stacktrace_addr2line-config.cmake
common.copy /usr/local/lib/cmake/boost_stacktrace_addr2line-1.80.0/boost_stacktrace_addr2line-config-version.cmake
common.copy /usr/local/lib/cmake/boost_stacktrace_backtrace-1.80.0/boost_stacktrace_backtrace-config-version.cmake
common.copy /usr/local/lib/cmake/boost_stacktrace_addr2line-1.80.0/libboost_stacktrace_addr2line-variant-shared.cmake
common.copy /usr/local/lib/cmake/boost_stacktrace_basic-1.80.0/boost_stacktrace_basic-config.cmake
common.copy /usr/local/lib/cmake/BoostDetectToolset-1.80.0.cmake
common.copy /usr/local/lib/cmake/boost_stacktrace_basic-1.80.0/boost_stacktrace_basic-config-version.cmake
common.copy /usr/local/lib/cmake/boost_stacktrace_basic-1.80.0/libboost_stacktrace_basic-variant-shared.cmake
common.copy /usr/local/lib/cmake/Boost-1.80.0/BoostConfig.cmake
common.copy /usr/local/lib/cmake/Boost-1.80.0/BoostConfigVersion.cmake
common.copy /usr/local/lib/libboost_stacktrace_noop.a
common.copy /usr/local/lib/libboost_stacktrace_addr2line.a
common.copy /usr/local/lib/cmake/boost_stacktrace_noop-1.80.0/libboost_stacktrace_noop-variant-static.cmake
common.copy /usr/local/lib/cmake/boost_stacktrace_backtrace-1.80.0/libboost_stacktrace_backtrace-variant-static.cmake
common.copy /usr/local/lib/libboost_stacktrace_basic.a
common.copy /usr/local/lib/libboost_stacktrace_backtrace.a
common.copy /usr/local/lib/cmake/boost_stacktrace_addr2line-1.80.0/libboost_stacktrace_addr2line-variant-static.cmake
common.copy /usr/local/lib/cmake/boost_stacktrace_basic-1.80.0/libboost_stacktrace_basic-variant-static.cmake
...updated 36 targets...
tom@cxxEnv ➜  boost_1_80_0 
```

库文件是安装完成了(`usr/locale/lib`) , 但是头文件没有拷贝到 `/usr/` 下面的某个文件夹下 . 

我们手动将拷贝了头文件 `tom@cxxEnv ➜  boost_1_80_0 sudo cp --recursive  boost  /usr/local/include/`

连接库不足导致失败 `-lboost_stacktrace_backtrace  -lboost_stacktrace_addr2line -lboost_stacktrace_basic -lboost_stacktrace_noop`
[增加 `-ldl` 后解决了](https://stackoverflow.com/q/60039866/7707781)

为什么 需要 `libdl.so / libdl.a` , 文档里写了 : https://www.boost.org/doc/libs/master/doc/html/stacktrace/configuration_and_build.html



## [关于 boost format ](https://www.boost.org/doc/libs/1_81_0/libs/format/)

指令 `➜  boost_1_80_0 ./bootstrap.sh --show-libraries` 列表中没有 format
```
The following Boost libraries have portions that require a separate build
and installation step. Any library not listed here can be used by including
the headers only.

The Boost libraries requiring separate building and installation are:
    - atomic
    - chrono
    - container
    - context
    - contract
    - coroutine
    - date_time
    - exception
    - fiber
    - filesystem
    - graph
    - graph_parallel
    - headers
    - iostreams
    - json
    - locale
    - log
    - math
    - mpi
    - nowide
    - program_options
    - python
    - random
    - regex
    - serialization
    - stacktrace
    - system
    - test
    - thread
    - timer
    - type_erasure
    - wave
```

据此 , format 直接拷贝到 /usr/local/include/ 即可正常使用