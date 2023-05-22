## 一、弯路
我们从 https://github.com/facebook/folly 直接下载源码 zip 包按照 README.md 文档的指引进行安装，结果测试的时候存在一些头文件无法找到的情况。

这时候进行百度安装方式发现另一种源码下载姿势：https://github.com/facebook/folly/releases

## 二、再探
本次下载版本：
- folly-2018.01.08.00
- 步骤仿照 Readme.md

执行日志如下：

```
tom@tom-Vostro-2421:/media/tom/document/Syn_Clode/project/folly-2018.01.08.00/folly$ sudo apt-get install \
>     g++ \
>     automake \
>     autoconf \
>     autoconf-archive \
>     libtool \
>     libboost-all-dev \
>     libevent-dev \
>     libdouble-conversion-dev \
>     libgoogle-glog-dev \
>     libgflags-dev \
>     liblz4-dev \
>     liblzma-dev \
>     libsnappy-dev \
>     make \
>     zlib1g-dev \
>     binutils-dev \
>     libjemalloc-dev \
>     libssl-dev \
>     pkg-config
[sudo] password for tom:
Reading package lists... Done
Building dependency tree       
Reading state information... Done
autoconf is already the newest version (2.69-9).
automake is already the newest version (1:1.15-4ubuntu1).
g++ is already the newest version (4:5.3.1-1ubuntu1).
libdouble-conversion-dev is already the newest version (2.0.1-3ubuntu2).
liblz4-dev is already the newest version (0.0~r131-2ubuntu2).
liblzma-dev is already the newest version (5.1.1alpha+20120614-2ubuntu2).
libsnappy-dev is already the newest version (1.1.3-2).
libtool is already the newest version (2.4.6-0.1).
make is already the newest version (4.1-6).
pkg-config is already the newest version (0.29.1-0ubuntu1).
autoconf-archive is already the newest version (20150925-1).
libboost-all-dev is already the newest version (1.58.0.1ubuntu1).
libgflags-dev is already the newest version (2.1.2-3).
libgoogle-glog-dev is already the newest version (0.3.4-0.1).
libjemalloc-dev is already the newest version (3.6.0-9ubuntu1).
binutils-dev is already the newest version (2.26.1-1ubuntu1~16.04.5).
libevent-dev is already the newest version (2.0.21-stable-2ubuntu0.16.04.1).
libssl-dev is already the newest version (1.0.2g-1ubuntu4.10).
zlib1g-dev is already the newest version (1:1.2.8.dfsg-2ubuntu4.1).
0 upgraded, 0 newly installed, 0 to remove and 12 not upgraded.


tom@tom-Vostro-2421:/media/tom/document/Syn_Clode/project/folly-2018.01.08.00/folly$ sudo apt-get install \
>     libunwind8-dev \
>     libelf-dev \
>     libdwarf-dev
Reading package lists... Done
Building dependency tree       
Reading state information... Done
libelf-dev is already the newest version (0.165-3ubuntu1).
libunwind8-dev is already the newest version (1.1-4.1).
libdwarf-dev is already the newest version (20120410-2+deb7u2build0.16.04.1).
0 upgraded, 0 newly installed, 0 to remove and 12 not upgraded.


tom@tom-Vostro-2421:/media/tom/document/Syn_Clode/project/folly-2018.01.08.00/folly$ sudo apt-get install \
>     libunwind8-dev \
>     libelf-dev \
>     libdwarf-dev
Reading package lists... Done
Building dependency tree       
Reading state information... Done
libelf-dev is already the newest version (0.165-3ubuntu1).
libunwind8-dev is already the newest version (1.1-4.1).
libdwarf-dev is already the newest version (20120410-2+deb7u2build0.16.04.1).
0 upgraded, 0 newly installed, 0 to remove and 12 not upgraded.


tom@tom-Vostro-2421:/media/tom/document/Syn_Clode/project/folly-2018.01.08.00/folly$ autoreconf -ivf
autoreconf: Entering directory `.'
autoreconf: configure.ac: not using Gettext
autoreconf: running: aclocal --force -I m4
autoreconf: configure.ac: tracing
autoreconf: configure.ac: creating directory build-aux
autoreconf: running: libtoolize --copy --force
libtoolize: putting auxiliary files in AC_CONFIG_AUX_DIR, 'build-aux'.
libtoolize: copying file 'build-aux/ltmain.sh'
libtoolize: putting macros in AC_CONFIG_MACRO_DIRS, 'm4'.
libtoolize: copying file 'm4/libtool.m4'
libtoolize: copying file 'm4/ltoptions.m4'
libtoolize: copying file 'm4/ltsugar.m4'
libtoolize: copying file 'm4/ltversion.m4'
libtoolize: copying file 'm4/lt~obsolete.m4'
autoreconf: running: /usr/bin/autoconf --force
autoreconf: running: /usr/bin/autoheader --force
autoreconf: running: automake --add-missing --copy --force-missing
configure.ac:32: installing 'build-aux/compile'
configure.ac:32: installing 'build-aux/config.guess'
configure.ac:32: installing 'build-aux/config.sub'
configure.ac:27: installing 'build-aux/install-sh'
configure.ac:27: installing 'build-aux/missing'
Makefile.am: installing 'build-aux/depcomp'
parallel-tests: installing 'build-aux/test-driver'
autoreconf: Leaving directory `.'


tom@tom-Vostro-2421:/media/tom/document/Syn_Clode/project/folly-2018.01.08.00/folly$ ./configure
checking for a BSD-compatible install... /usr/bin/install -c
checking whether build environment is sane... yes
checking for a thread-safe mkdir -p... /bin/mkdir -p
checking for gawk... no
checking for mawk... mawk
checking whether make sets $(MAKE)... yes
checking whether make supports nested variables... yes
checking build system type... x86_64-pc-linux-gnu
checking host system type... x86_64-pc-linux-gnu
checking how to print strings... printf
checking for style of include used by make... GNU
checking for gcc... gcc
checking whether the C compiler works... yes
checking for C compiler default output file name... a.out
checking for suffix of executables...
checking whether we are cross compiling... no
checking for suffix of object files... o
checking whether we are using the GNU C compiler... yes
checking whether gcc accepts -g... yes
checking for gcc option to accept ISO C89... none needed
checking whether gcc understands -c and -o together... yes
checking dependency style of gcc... gcc3
checking for a sed that does not truncate output... /bin/sed
checking for grep that handles long lines and -e... /bin/grep
checking for egrep... /bin/grep -E
checking for fgrep... /bin/grep -F
checking for ld used by gcc... /usr/bin/ld
checking if the linker (/usr/bin/ld) is GNU ld... yes
checking for BSD- or MS-compatible name lister (nm)... /usr/bin/nm -B
checking the name lister (/usr/bin/nm -B) interface... BSD nm
checking whether ln -s works... yes
checking the maximum length of command line arguments... 1572864
checking how to convert x86_64-pc-linux-gnu file names to x86_64-pc-linux-gnu format... func_convert_file_noop
checking how to convert x86_64-pc-linux-gnu file names to toolchain format... func_convert_file_noop
checking for /usr/bin/ld option to reload object files... -r
checking for objdump... objdump
checking how to recognize dependent libraries... pass_all
checking for dlltool... no
checking how to associate runtime and link libraries... printf %s\n
checking for ar... ar
checking for archiver @FILE support... @
checking for strip... strip
checking for ranlib... ranlib
checking command to parse /usr/bin/nm -B output from gcc object... ok
checking for sysroot... no
checking for a working dd... /bin/dd
checking how to truncate binary pipes... /bin/dd bs=4096 count=1
checking for mt... mt
checking if mt is a manifest tool... no
checking how to run the C preprocessor... gcc -E
checking for ANSI C header files... yes
checking for sys/types.h... yes
checking for sys/stat.h... yes
checking for stdlib.h... yes
checking for string.h... yes
checking for memory.h... yes
checking for strings.h... yes
checking for inttypes.h... yes
checking for stdint.h... yes
checking for unistd.h... yes
checking for dlfcn.h... yes
checking for objdir... .libs
checking if gcc supports -fno-rtti -fno-exceptions... no
checking for gcc option to produce PIC... -fPIC -DPIC
checking if gcc PIC flag -fPIC -DPIC works... yes
checking if gcc static flag -static works... yes
checking if gcc supports -c -o file.o... yes
checking if gcc supports -c -o file.o... (cached) yes
checking whether the gcc linker (/usr/bin/ld -m elf_x86_64) supports shared libraries... yes
checking whether -lc should be explicitly linked in... no
checking dynamic linker characteristics... GNU/Linux ld.so
checking how to hardcode library paths into programs... immediate
checking whether stripping libraries is possible... yes
checking if libtool supports shared libraries... yes
checking whether to build shared libraries... yes
checking whether to build static libraries... yes
checking for g++... g++
checking whether we are using the GNU C++ compiler... yes
checking whether g++ accepts -g... yes
checking dependency style of g++... gcc3
checking how to run the C++ preprocessor... g++ -E
checking for ld used by g++... /usr/bin/ld -m elf_x86_64
checking if the linker (/usr/bin/ld -m elf_x86_64) is GNU ld... yes
checking whether the g++ linker (/usr/bin/ld -m elf_x86_64) supports shared libraries... yes
checking for g++ option to produce PIC... -fPIC -DPIC
checking if g++ PIC flag -fPIC -DPIC works... yes
checking if g++ static flag -static works... yes
checking if g++ supports -c -o file.o... yes
checking if g++ supports -c -o file.o... (cached) yes
checking whether the g++ linker (/usr/bin/ld -m elf_x86_64) supports shared libraries... yes
checking dynamic linker characteristics... (cached) GNU/Linux ld.so
checking how to hardcode library paths into programs... immediate
checking for gcc... (cached) gcc
checking whether we are using the GNU C compiler... (cached) yes
checking whether gcc accepts -g... (cached) yes
checking for gcc option to accept ISO C89... (cached) none needed
checking whether gcc understands -c and -o together... (cached) yes
checking dependency style of gcc... (cached) gcc3
checking if g++ supports C++1y features without additional flags... no
checking if g++ supports C++1y features with -std=c++1y... yes
checking if g++ supports C++1y features with -std=gnu++1y... yes
checking whether -Wunknown-warning-option is supported... no
checking whether -Wshadow-local and -Wshadow-compatible-local are supported... no
checking for main in -lgflags... yes
checking for gflags viability... yes
checking for pkg-config... /usr/bin/pkg-config
checking pkg-config is at least version 0.9.0... yes
checking for GFLAGS... no
configure: gflags.pc not found, treating as legacy dependency
checking for main in -lglog... yes
checking for glog viability... yes
checking for GLOG... yes
checking for pkg-config... /usr/bin/pkg-config
checking whether compiling and linking against OpenSSL works... yes
checking for OPENSSL... yes
checking for boostlib >= 1.51.0... yes
checking whether the Boost::Context library is available... yes
checking for exit in -lboost_context... yes
checking whether the Boost::Program_Options library is available... yes
checking for exit in -lboost_program_options... yes
checking whether the Boost::Thread library is available... yes
checking for exit in -lboost_thread... yes
checking whether the Boost::Regex library is available... yes
checking for exit in -lboost_regex... yes
checking whether the Boost::System library is available... yes
checking for exit in -lboost_system... yes
checking whether the Boost::Filesystem library is available... yes
checking for exit in -lboost_filesystem... yes
checking whether the Boost::Chrono library is available... yes
checking for exit in -lboost_chrono... yes
checking for python... /usr/bin/python
checking for python version... 2.7
checking for python platform... linux2
checking for python script directory... ${prefix}/lib/python2.7/dist-packages
checking for python extension module directory... ${exec_prefix}/lib/python2.7/dist-packages
checking for ANSI C header files... (cached) yes
checking features.h usability... yes
checking features.h presence... yes
checking for features.h... yes
checking malloc.h usability... yes
checking malloc.h presence... yes
checking for malloc.h... yes
checking bits/functexcept.h usability... yes
checking bits/functexcept.h presence... yes
checking for bits/functexcept.h... yes
checking bits/c++config.h usability... yes
checking bits/c++config.h presence... yes
checking for bits/c++config.h... yes
checking double-conversion/double-conversion.h usability... yes
checking double-conversion/double-conversion.h presence... yes
checking for double-conversion/double-conversion.h... yes
checking for ceil in -ldouble-conversion... yes
checking for event_set in -levent... yes
checking for EVENT... yes
checking for an ANSI C-conforming const... yes
checking for inline... inline
checking for size_t... yes
checking whether time.h and sys/time.h may both be included... yes
checking for working volatile... yes
checking for __int128... yes
checking for __int128 type traits... yes
checking for pthread_spinlock_t... yes
checking for ifunc support... yes
checking for final and override support... yes
checking for libc++... no
checking for c++11 atomic support without GNU Atomic library... yes
checking for main in -ldl... yes
checking for liblinux-vdso support... yes
checking for usable std::is_trivially_copyable... yes
checking gflags namespace... gflags
checking for weak symbol support... yes
checking for wchar support... yes
checking for unaligned access support... yes
checking for vsnprintf reporting bad format strings... no
checking for library containing cplus_demangle_v3_callback... -liberty
checking for library containing clock_gettime... none required
checking for pthread_atfork support... yes
checking for XSI style strerror_r support... no
checking for ext/random and __gnu_cxx::sfmt19937... yes
checking for VLA (variable-length array) support... yes
checking for variable template support... yes
checking for malloc_size... no
checking for malloc_usable_size... yes
checking for memrchr... yes
checking for pipe2... yes
checking for preadv... yes
checking for pwritev... yes
checking lz4.h usability... yes
checking lz4.h presence... yes
checking for lz4.h... yes
checking for LZ4_decompress_safe in -llz4... yes
checking snappy.h usability... yes
checking snappy.h presence... yes
checking for snappy.h... yes
checking for main in -lsnappy... yes
checking zlib.h usability... yes
checking zlib.h presence... yes
checking for zlib.h... yes
checking for main in -lz... yes
checking lzma.h usability... yes
checking lzma.h presence... yes
checking for lzma.h... yes
checking for main in -llzma... yes
checking zstd.h usability... no
checking zstd.h presence... no
checking for zstd.h... no
checking bzlib.h usability... no
checking bzlib.h presence... no
checking for bzlib.h... no
checking linux/membarrier.h usability... yes
checking linux/membarrier.h presence... yes
checking for linux/membarrier.h... yes
checking libdwarf/dwarf.h usability... no
checking libdwarf/dwarf.h presence... no
checking for libdwarf/dwarf.h... no
checking dwarf.h usability... yes
checking dwarf.h presence... yes
checking for dwarf.h... yes
checking elf.h usability... yes
checking elf.h presence... yes
checking for elf.h... yes
checking for backtrace in -lunwind... yes
checking that generated files are newer than configure... done
configure: creating ./config.status
config.status: creating Makefile
config.status: creating chrono/test/Makefile
config.status: creating io/test/Makefile
config.status: creating libfolly.pc
config.status: creating test/Makefile
config.status: creating test/function_benchmark/Makefile
config.status: creating experimental/Makefile
config.status: creating experimental/io/test/Makefile
config.status: creating experimental/logging/Makefile
config.status: creating experimental/logging/example/Makefile
config.status: creating experimental/symbolizer/Makefile
config.status: creating init/Makefile
config.status: creating stats/test/Makefile
config.status: creating config.h
config.status: executing folly-config.h commands
config.status: creating folly-config.h - prefix FOLLY for config.h defines
config.status: executing depfiles commands
config.status: executing libtool commands


tom@tom-Vostro-2421:/media/tom/document/Syn_Clode/project/folly-2018.01.08.00/folly$ make
make  all-recursive
make[1]: Entering directory '/media/tom/document/Syn_Clode/project/folly-2018.01.08.00/folly'
Making all in .
make[2]: Entering directory '/media/tom/document/Syn_Clode/project/folly-2018.01.08.00/folly'
depbase=`echo ClockGettimeWrappers.lo | sed 's|[^/]*$|.deps/&|;s|\.lo$||'`;\
/bin/bash ./libtool  --tag=CXX   --mode=compile g++ -DHAVE_CONFIG_H   -I./.. -pthread -I/usr/include    -std=gnu++1y -g -O2 -MT ClockGettimeWrappers.lo -MD -MP -MF $depbase.Tpo -c -o ClockGettimeWrappers.lo ClockGettimeWrappers.cpp &&\
mv -f $depbase.Tpo $depbase.Plo
libtool: compile:  g++ -DHAVE_CONFIG_H -I./.. -pthread -I/usr/include -std=gnu++1y -g -O2 -MT ClockGettimeWrappers.lo -MD -MP -MF .deps/ClockGettimeWrappers.Tpo -c ClockGettimeWrappers.cpp  -fPIC -DPIC -o .libs/ClockGettimeWrappers.o
libtool: compile:  g++ -DHAVE_CONFIG_H -I./.. -pthread -I/usr/include -std=gnu++1y -g -O2 -MT ClockGettimeWrappers.lo -MD -MP -MF .deps/ClockGettimeWrappers.Tpo -c ClockGettimeWrappers.cpp -o ClockGettimeWrappers.o >/dev/null 2>&1
depbase=`echo compression/Compression.lo | sed 's|[^/]*$|.deps/&|;s|\.lo$||'`;\
/bin/bash ./libtool  --tag=CXX   --mode=compile g++ -DHAVE_CONFIG_H   -I./.. -pthread -I/usr/include    -std=gnu++1y -g -O2 -MT compression/Compression.lo -MD -MP -MF $depbase.Tpo -c -o compression/Compression.lo compression/Compression.cpp &&\
mv -f $depbase.Tpo $depbase.Plo
libtool: compile:  g++ -DHAVE_CONFIG_H -I./.. -pthread -I/usr/include -std=gnu++1y -g -O2 -MT compression/Compression.lo -MD -MP -MF compression/.deps/Compression.Tpo -c compression/Compression.cpp  -fPIC -DPIC -o compression/.libs/Compression.o
libtool: compile:  g++ -DHAVE_CONFIG_H -I./.. -pthread -I/usr/include -std=gnu++1y -g -O2 -MT compression/Compression.lo -MD -MP -MF compression/.deps/Compression.Tpo -c compression/Compression.cpp -o compression/Compression.o >/dev/null 2>&1
depbase=`echo compression/Zlib.lo | sed 's|[^/]*$|.deps/&|;s|\.lo$||'`;\
/bin/bash ./libtool  --tag=CXX   --mode=compile g++ -DHAVE_CONFIG_H   -I./.. -pthread -I/usr/include    -std=gnu++1y -g -O2 -MT compression/Zlib.lo -MD -MP -MF $depbase.Tpo -c -o compression/Zlib.lo compression/Zlib.cpp &&\
mv -f $depbase.Tpo $depbase.Plo
libtool: compile:  g++ -DHAVE_CONFIG_H -I./.. -pthread -I/usr/include -std=gnu++1y -g -O2 -MT compression/Zlib.lo -MD -MP -MF compression/.deps/Zlib.Tpo -c compression/Zlib.cpp  -fPIC -DPIC -o compression/.libs/Zlib.o
libtool: compile:  g++ -DHAVE_CONFIG_H -I./.. -pthread -I/usr/include -std=gnu++1y -g -O2 -MT compression/Zlib.lo -MD -MP -MF compression/.deps/Zlib.Tpo -c compression/Zlib.cpp -o compression/Zlib.o >/dev/null 2>&1
depbase=`echo concurrency/CacheLocality.lo | sed 's|[^/]*$|.deps/&|;s|\.lo$||'`;\
/bin/bash ./libtool  --tag=CXX   --mode=compile g++ -DHAVE_CONFIG_H   -I./.. -pthread -I/usr/include    -std=gnu++1y -g -O2 -MT concurrency/CacheLocality.lo -MD -MP -MF $depbase.Tpo -c -o concurrency/CacheLocality.lo concurrency/CacheLocality.cpp &&\
mv -f $depbase.Tpo $depbase.Plo
libtool: compile:  g++ -DHAVE_CONFIG_H -I./.. -pthread -I/usr/include -std=gnu++1y -g -O2 -MT concurrency/CacheLocality.lo -MD -MP -MF concurrency/.deps/CacheLocality.Tpo -c concurrency/CacheLocality.cpp  -fPIC -DPIC -o concurrency/.libs/CacheLocality.o
libtool: compile:  g++ -DHAVE_CONFIG_H -I./.. -pthread -I/usr/include -std=gnu++1y -g -O2 -MT concurrency/CacheLocality.lo -MD -MP -MF concurrency/.deps/CacheLocality.Tpo -c concurrency/CacheLocality.cpp -o concurrency/CacheLocality.o >/dev/null 2>&1
depbase=`echo detail/AtFork.lo | sed 's|[^/]*$|.deps/&|;s|\.lo$||'`;\
/bin/bash ./libtool  --tag=CXX   --mode=compile g++ -DHAVE_CONFIG_H   -I./.. -pthread -I/usr/include    -std=gnu++1y -g -O2 -MT detail/AtFork.lo -MD -MP -MF $depbase.Tpo -c -o detail/AtFork.lo detail/AtFork.cpp &&\
mv -f $depbase.Tpo $depbase.Plo
libtool: compile:  g++ -DHAVE_CONFIG_H -I./.. -pthread -I/usr/include -std=gnu++1y -g -O2 -MT detail/AtFork.lo -MD -MP -MF detail/.deps/AtFork.Tpo -c detail/AtFork.cpp  -fPIC -DPIC -o detail/.libs/AtFork.o
libtool: compile:  g++ -DHAVE_CONFIG_H -I./.. -pthread -I/usr/include -std=gnu++1y -g -O2 -MT detail/AtFork.lo -MD -MP -MF detail/.deps/AtFork.Tpo -c detail/AtFork.cpp -o detail/AtFork.o >/dev/null 2>&1
depbase=`echo detail/Futex.lo | sed 's|[^/]*$|.deps/&|;s|\.lo$||'`;\
/bin/bash ./libtool  --tag=CXX   --mode=compile g++ -DHAVE_CONFIG_H   -I./.. -pthread -I/usr/include    -std=gnu++1y -g -O2 -MT detail/Futex.lo -MD -MP -MF $depbase.Tpo -c -o detail/Futex.lo detail/Futex.cpp &&\
mv -f $depbase.Tpo $depbase.Plo
libtool: compile:  g++ -DHAVE_CONFIG_H -I./.. -pthread -I/usr/include -std=gnu++1y -g -O2 -MT detail/Futex.lo -MD -MP -MF detail/.deps/Futex.Tpo -c detail/Futex.cpp  -fPIC -DPIC -o detail/.libs/Futex.o
libtool: compile:  g++ -DHAVE_CONFIG_H -I./.. -pthread -I/usr/include -std=gnu++1y -g -O2 -MT detail/Futex.lo -MD -MP -MF detail/.deps/Futex.Tpo -c detail/Futex.cpp -o detail/Futex.o >/dev/null 2>&1
depbase=`echo detail/IPAddress.lo | sed 's|[^/]*$|.deps/&|;s|\.lo$||'`;\
/bin/bash ./libtool  --tag=CXX   --mode=compile g++ -DHAVE_CONFIG_H   -I./.. -pthread -I/usr/include    -std=gnu++1y -g -O2 -MT detail/IPAddress.lo -MD -MP -MF $depbase.Tpo -c -o detail/IPAddress.lo detail/IPAddress.cpp &&\
mv -f $depbase.Tpo $depbase.Plo
libtool: compile:  g++ -DHAVE_CONFIG_H -I./.. -pthread -I/usr/include -std=gnu++1y -g -O2 -MT detail/IPAddress.lo -MD -MP -MF detail/.deps/IPAddress.Tpo -c detail/IPAddress.cpp  -fPIC -DPIC -o detail/.libs/IPAddress.o
libtool: compile:  g++ -DHAVE_CONFIG_H -I./.. -pthread -I/usr/include -std=gnu++1y -g -O2 -MT detail/IPAddress.lo -MD -MP -MF detail/.deps/IPAddress.Tpo -c detail/IPAddress.cpp -o detail/IPAddress.o >/dev/null 2>&1
depbase=`echo detail/StaticSingletonManager.lo | sed 's|[^/]*$|.deps/&|;s|\.lo$||'`;\
/bin/bash ./libtool  --tag=CXX   --mode=compile g++ -DHAVE_CONFIG_H   -I./.. -pthread -I/usr/include    -std=gnu++1y -g -O2 -MT detail/StaticSingletonManager.lo -MD -MP -MF $depbase.Tpo -c -o detail/StaticSingletonManager.lo detail/StaticSingletonManager.cpp &&\
mv -f $depbase.Tpo $depbase.Plo
libtool: compile:  g++ -DHAVE_CONFIG_H -I./.. -pthread -I/usr/include -std=gnu++1y -g -O2 -MT detail/StaticSingletonManager.lo -MD -MP -MF detail/.deps/StaticSingletonManager.Tpo -c detail/StaticSingletonManager.cpp  -fPIC -DPIC -o detail/.libs/StaticSingletonManager.o
libtool: compile:  g++ -DHAVE_CONFIG_H -I./.. -pthread -I/usr/include -std=gnu++1y -g -O2 -MT detail/StaticSingletonManager.lo -MD -MP -MF detail/.deps/StaticSingletonManager.Tpo -c detail/StaticSingletonManager.cpp -o detail/StaticSingletonManager.o >/dev/null 2>&1
depbase=`echo detail/ThreadLocalDetail.lo | sed 's|[^/]*$|.deps/&|;s|\.lo$||'`;\
/bin/bash ./libtool  --tag=CXX   --mode=compile g++ -DHAVE_CONFIG_H   -I./.. -pthread -I/usr/include    -std=gnu++1y -g -O2 -MT detail/ThreadLocalDetail.lo -MD -MP -MF $depbase.Tpo -c -o detail/ThreadLocalDetail.lo detail/ThreadLocalDetail.cpp &&\
mv -f $depbase.Tpo $depbase.Plo
libtool: compile:  g++ -DHAVE_CONFIG_H -I./.. -pthread -I/usr/include -std=gnu++1y -g -O2 -MT detail/ThreadLocalDetail.lo -MD -MP -MF detail/.deps/ThreadLocalDetail.Tpo -c detail/ThreadLocalDetail.cpp  -fPIC -DPIC -o detail/.libs/ThreadLocalDetail.o
libtool: compile:  g++ -DHAVE_CONFIG_H -I./.. -pthread -I/usr/include -std=gnu++1y -g -O2 -MT detail/ThreadLocalDetail.lo -MD -MP -MF detail/.deps/ThreadLocalDetail.Tpo -c detail/ThreadLocalDetail.cpp -o detail/ThreadLocalDetail.o >/dev/null 2>&1
depbase=`echo dynamic.lo | sed 's|[^/]*$|.deps/&|;s|\.lo$||'`;\
/bin/bash ./libtool  --tag=CXX   --mode=compile g++ -DHAVE_CONFIG_H   -I./.. -pthread -I/usr/include    -std=gnu++1y -g -O2 -MT dynamic.lo -MD -MP -MF $depbase.Tpo -c -o dynamic.lo dynamic.cpp &&\
mv -f $depbase.Tpo $depbase.Plo
libtool: compile:  g++ -DHAVE_CONFIG_H -I./.. -pthread -I/usr/include -std=gnu++1y -g -O2 -MT dynamic.lo -MD -MP -MF .deps/dynamic.Tpo -c dynamic.cpp  -fPIC -DPIC -o .libs/dynamic.o
libtool: compile:  g++ -DHAVE_CONFIG_H -I./.. -pthread -I/usr/include -std=gnu++1y -g -O2 -MT dynamic.lo -MD -MP -MF .deps/dynamic.Tpo -c dynamic.cpp -o dynamic.o >/dev/null 2>&1
depbase=`echo ExceptionWrapper.lo | sed 's|[^/]*$|.deps/&|;s|\.lo$||'`;\
/bin/bash ./libtool  --tag=CXX   --mode=compile g++ -DHAVE_CONFIG_H   -I./.. -pthread -I/usr/include    -std=gnu++1y -g -O2 -MT ExceptionWrapper.lo -MD -MP -MF $depbase.Tpo -c -o ExceptionWrapper.lo ExceptionWrapper.cpp &&\
mv -f $depbase.Tpo $depbase.Plo
libtool: compile:  g++ -DHAVE_CONFIG_H -I./.. -pthread -I/usr/include -std=gnu++1y -g -O2 -MT ExceptionWrapper.lo -MD -MP -MF .deps/ExceptionWrapper.Tpo -c ExceptionWrapper.cpp  -fPIC -DPIC -o .libs/ExceptionWrapper.o
libtool: compile:  g++ -DHAVE_CONFIG_H -I./.. -pthread -I/usr/include -std=gnu++1y -g -O2 -MT ExceptionWrapper.lo -MD -MP -MF .deps/ExceptionWrapper.Tpo -c ExceptionWrapper.cpp -o ExceptionWrapper.o >/dev/null 2>&1
depbase=`echo Executor.lo | sed 's|[^/]*$|.deps/&|;s|\.lo$||'`;\
/bin/bash ./libtool  --tag=CXX   --mode=compile g++ -DHAVE_CONFIG_H   -I./.. -pthread -I/usr/include    -std=gnu++1y -g -O2 -MT Executor.lo -MD -MP -MF $depbase.Tpo -c -o Executor.lo Executor.cpp &&\
mv -f $depbase.Tpo $depbase.Plo
libtool: compile:  g++ -DHAVE_CONFIG_H -I./.. -pthread -I/usr/include -std=gnu++1y -g -O2 -MT Executor.lo -MD -MP -MF .deps/Executor.Tpo -c Executor.cpp  -fPIC -DPIC -o .libs/Executor.o
libtool: compile:  g++ -DHAVE_CONFIG_H -I./.. -pthread -I/usr/include -std=gnu++1y -g -O2 -MT Executor.lo -MD -MP -MF .deps/Executor.Tpo -c Executor.cpp -o Executor.o >/dev/null 2>&1
depbase=`echo Expected.lo | sed 's|[^/]*$|.deps/&|;s|\.lo$||'`;\
/bin/bash ./libtool  --tag=CXX   --mode=compile g++ -DHAVE_CONFIG_H   -I./.. -pthread -I/usr/include    -std=gnu++1y -g -O2 -MT Expected.lo -MD -MP -MF $depbase.Tpo -c -o Expected.lo Expected.cpp &&\
mv -f $depbase.Tpo $depbase.Plo
libtool: compile:  g++ -DHAVE_CONFIG_H -I./.. -pthread -I/usr/include -std=gnu++1y -g -O2 -MT Expected.lo -MD -MP -MF .deps/Expected.Tpo -c Expected.cpp  -fPIC -DPIC -o .libs/Expected.o
libtool: compile:  g++ -DHAVE_CONFIG_H -I./.. -pthread -I/usr/include -std=gnu++1y -g -O2 -MT Expected.lo -MD -MP -MF .deps/Expected.Tpo -c Expected.cpp -o Expected.o >/dev/null 2>&1
depbase=`echo File.lo | sed 's|[^/]*$|.deps/&|;s|\.lo$||'`;\
/bin/bash ./libtool  --tag=CXX   --mode=compile g++ -DHAVE_CONFIG_H   -I./.. -pthread -I/usr/include    -std=gnu++1y -g -O2 -MT File.lo -MD -MP -MF $depbase.Tpo -c -o File.lo File.cpp &&\
mv -f $depbase.Tpo $depbase.Plo
libtool: compile:  g++ -DHAVE_CONFIG_H -I./.. -pthread -I/usr/include -std=gnu++1y -g -O2 -MT File.lo -MD -MP -MF .deps/File.Tpo -c File.cpp  -fPIC -DPIC -o .libs/File.o
libtool: compile:  g++ -DHAVE_CONFIG_H -I./.. -pthread -I/usr/include -std=gnu++1y -g -O2 -MT File.lo -MD -MP -MF .deps/File.Tpo -c File.cpp -o File.o >/dev/null 2>&1
depbase=`echo FileUtil.lo | sed 's|[^/]*$|.deps/&|;s|\.lo$||'`;\
/bin/bash ./libtool  --tag=CXX   --mode=compile g++ -DHAVE_CONFIG_H   -I./.. -pthread -I/usr/include    -std=gnu++1y -g -O2 -MT FileUtil.lo -MD -MP -MF $depbase.Tpo -c -o FileUtil.lo FileUtil.cpp &&\
mv -f $depbase.Tpo $depbase.Plo
libtool: compile:  g++ -DHAVE_CONFIG_H -I./.. -pthread -I/usr/include -std=gnu++1y -g -O2 -MT FileUtil.lo -MD -MP -MF .deps/FileUtil.Tpo -c FileUtil.cpp  -fPIC -DPIC -o .libs/FileUtil.o
libtool: compile:  g++ -DHAVE_CONFIG_H -I./.. -pthread -I/usr/include -std=gnu++1y -g -O2 -MT FileUtil.lo -MD -MP -MF .deps/FileUtil.Tpo -c FileUtil.cpp -o FileUtil.o >/dev/null 2>&1
depbase=`echo build/GenerateFingerprintTables.o | sed 's|[^/]*$|.deps/&|;s|\.o$||'`;\
g++ -DHAVE_CONFIG_H   -I./.. -pthread -I/usr/include    -std=gnu++1y -g -O2 -MT build/GenerateFingerprintTables.o -MD -MP -MF $depbase.Tpo -c -o build/GenerateFingerprintTables.o build/GenerateFingerprintTables.cpp &&\
mv -f $depbase.Tpo $depbase.Po
depbase=`echo Conv.lo | sed 's|[^/]*$|.deps/&|;s|\.lo$||'`;\
/bin/bash ./libtool  --tag=CXX   --mode=compile g++ -DHAVE_CONFIG_H   -I./.. -pthread -I/usr/include    -std=gnu++1y -g -O2 -MT Conv.lo -MD -MP -MF $depbase.Tpo -c -o Conv.lo Conv.cpp &&\
mv -f $depbase.Tpo $depbase.Plo
libtool: compile:  g++ -DHAVE_CONFIG_H -I./.. -pthread -I/usr/include -std=gnu++1y -g -O2 -MT Conv.lo -MD -MP -MF .deps/Conv.Tpo -c Conv.cpp  -fPIC -DPIC -o .libs/Conv.o
libtool: compile:  g++ -DHAVE_CONFIG_H -I./.. -pthread -I/usr/include -std=gnu++1y -g -O2 -MT Conv.lo -MD -MP -MF .deps/Conv.Tpo -c Conv.cpp -o Conv.o >/dev/null 2>&1
depbase=`echo Demangle.lo | sed 's|[^/]*$|.deps/&|;s|\.lo$||'`;\
/bin/bash ./libtool  --tag=CXX   --mode=compile g++ -DHAVE_CONFIG_H   -I./.. -pthread -I/usr/include    -std=gnu++1y -g -O2 -MT Demangle.lo -MD -MP -MF $depbase.Tpo -c -o Demangle.lo Demangle.cpp &&\
mv -f $depbase.Tpo $depbase.Plo
libtool: compile:  g++ -DHAVE_CONFIG_H -I./.. -pthread -I/usr/include -std=gnu++1y -g -O2 -MT Demangle.lo -MD -MP -MF .deps/Demangle.Tpo -c Demangle.cpp  -fPIC -DPIC -o .libs/Demangle.o
libtool: compile:  g++ -DHAVE_CONFIG_H -I./.. -pthread -I/usr/include -std=gnu++1y -g -O2 -MT Demangle.lo -MD -MP -MF .deps/Demangle.Tpo -c Demangle.cpp -o Demangle.o >/dev/null 2>&1
depbase=`echo detail/RangeCommon.lo | sed 's|[^/]*$|.deps/&|;s|\.lo$||'`;\
/bin/bash ./libtool  --tag=CXX   --mode=compile g++ -DHAVE_CONFIG_H   -I./.. -pthread -I/usr/include    -std=gnu++1y -g -O2 -MT detail/RangeCommon.lo -MD -MP -MF $depbase.Tpo -c -o detail/RangeCommon.lo detail/RangeCommon.cpp &&\
mv -f $depbase.Tpo $depbase.Plo
libtool: compile:  g++ -DHAVE_CONFIG_H -I./.. -pthread -I/usr/include -std=gnu++1y -g -O2 -MT detail/RangeCommon.lo -MD -MP -MF detail/.deps/RangeCommon.Tpo -c detail/RangeCommon.cpp  -fPIC -DPIC -o detail/.libs/RangeCommon.o
libtool: compile:  g++ -DHAVE_CONFIG_H -I./.. -pthread -I/usr/include -std=gnu++1y -g -O2 -MT detail/RangeCommon.lo -MD -MP -MF detail/.deps/RangeCommon.Tpo -c detail/RangeCommon.cpp -o detail/RangeCommon.o >/dev/null 2>&1
/usr/bin/python build/generate_escape_tables.py
depbase=`echo EscapeTables.lo | sed 's|[^/]*$|.deps/&|;s|\.lo$||'`;\
/bin/bash ./libtool  --tag=CXX   --mode=compile g++ -DHAVE_CONFIG_H   -I./.. -pthread -I/usr/include    -std=gnu++1y -g -O2 -MT EscapeTables.lo -MD -MP -MF $depbase.Tpo -c -o EscapeTables.lo EscapeTables.cpp &&\
mv -f $depbase.Tpo $depbase.Plo
libtool: compile:  g++ -DHAVE_CONFIG_H -I./.. -pthread -I/usr/include -std=gnu++1y -g -O2 -MT EscapeTables.lo -MD -MP -MF .deps/EscapeTables.Tpo -c EscapeTables.cpp  -fPIC -DPIC -o .libs/EscapeTables.o
libtool: compile:  g++ -DHAVE_CONFIG_H -I./.. -pthread -I/usr/include -std=gnu++1y -g -O2 -MT EscapeTables.lo -MD -MP -MF .deps/EscapeTables.Tpo -c EscapeTables.cpp -o EscapeTables.o >/dev/null 2>&1
depbase=`echo Format.lo | sed 's|[^/]*$|.deps/&|;s|\.lo$||'`;\
/bin/bash ./libtool  --tag=CXX   --mode=compile g++ -DHAVE_CONFIG_H   -I./.. -pthread -I/usr/include    -std=gnu++1y -g -O2 -MT Format.lo -MD -MP -MF $depbase.Tpo -c -o Format.lo Format.cpp &&\
mv -f $depbase.Tpo $depbase.Plo
libtool: compile:  g++ -DHAVE_CONFIG_H -I./.. -pthread -I/usr/include -std=gnu++1y -g -O2 -MT Format.lo -MD -MP -MF .deps/Format.Tpo -c Format.cpp  -fPIC -DPIC -o .libs/Format.o
libtool: compile:  g++ -DHAVE_CONFIG_H -I./.. -pthread -I/usr/include -std=gnu++1y -g -O2 -MT Format.lo -MD -MP -MF .deps/Format.Tpo -c Format.cpp -o Format.o >/dev/null 2>&1
depbase=`echo FormatArg.lo | sed 's|[^/]*$|.deps/&|;s|\.lo$||'`;\
/bin/bash ./libtool  --tag=CXX   --mode=compile g++ -DHAVE_CONFIG_H   -I./.. -pthread -I/usr/include    -std=gnu++1y -g -O2 -MT FormatArg.lo -MD -MP -MF $depbase.Tpo -c -o FormatArg.lo FormatArg.cpp &&\
mv -f $depbase.Tpo $depbase.Plo
libtool: compile:  g++ -DHAVE_CONFIG_H -I./.. -pthread -I/usr/include -std=gnu++1y -g -O2 -MT FormatArg.lo -MD -MP -MF .deps/FormatArg.Tpo -c FormatArg.cpp  -fPIC -DPIC -o .libs/FormatArg.o
libtool: compile:  g++ -DHAVE_CONFIG_H -I./.. -pthread -I/usr/include -std=gnu++1y -g -O2 -MT FormatArg.lo -MD -MP -MF .deps/FormatArg.Tpo -c FormatArg.cpp -o FormatArg.o >/dev/null 2>&1
/usr/bin/python build/generate_format_tables.py
depbase=`echo FormatTables.lo | sed 's|[^/]*$|.deps/&|;s|\.lo$||'`;\
/bin/bash ./libtool  --tag=CXX   --mode=compile g++ -DHAVE_CONFIG_H   -I./.. -pthread -I/usr/include    -std=gnu++1y -g -O2 -MT FormatTables.lo -MD -MP -MF $depbase.Tpo -c -o FormatTables.lo FormatTables.cpp &&\
mv -f $depbase.Tpo $depbase.Plo
libtool: compile:  g++ -DHAVE_CONFIG_H -I./.. -pthread -I/usr/include -std=gnu++1y -g -O2 -MT FormatTables.lo -MD -MP -MF .deps/FormatTables.Tpo -c FormatTables.cpp  -fPIC -DPIC -o .libs/FormatTables.o
libtool: compile:  g++ -DHAVE_CONFIG_H -I./.. -pthread -I/usr/include -std=gnu++1y -g -O2 -MT FormatTables.lo -MD -MP -MF .deps/FormatTables.Tpo -c FormatTables.cpp -o FormatTables.o >/dev/null 2>&1
depbase=`echo memory/MallctlHelper.lo | sed 's|[^/]*$|.deps/&|;s|\.lo$||'`;\
/bin/bash ./libtool  --tag=CXX   --mode=compile g++ -DHAVE_CONFIG_H   -I./.. -pthread -I/usr/include    -std=gnu++1y -g -O2 -MT memory/MallctlHelper.lo -MD -MP -MF $depbase.Tpo -c -o memory/MallctlHelper.lo memory/MallctlHelper.cpp &&\
mv -f $depbase.Tpo $depbase.Plo
libtool: compile:  g++ -DHAVE_CONFIG_H -I./.. -pthread -I/usr/include -std=gnu++1y -g -O2 -MT memory/MallctlHelper.lo -MD -MP -MF memory/.deps/MallctlHelper.Tpo -c memory/MallctlHelper.cpp  -fPIC -DPIC -o memory/.libs/MallctlHelper.o
libtool: compile:  g++ -DHAVE_CONFIG_H -I./.. -pthread -I/usr/include -std=gnu++1y -g -O2 -MT memory/MallctlHelper.lo -MD -MP -MF memory/.deps/MallctlHelper.Tpo -c memory/MallctlHelper.cpp -o memory/MallctlHelper.o >/dev/null 2>&1
depbase=`echo portability/BitsFunctexcept.lo | sed 's|[^/]*$|.deps/&|;s|\.lo$||'`;\
/bin/bash ./libtool  --tag=CXX   --mode=compile g++ -DHAVE_CONFIG_H   -I./.. -pthread -I/usr/include    -std=gnu++1y -g -O2 -MT portability/BitsFunctexcept.lo -MD -MP -MF $depbase.Tpo -c -o portability/BitsFunctexcept.lo portability/BitsFunctexcept.cpp &&\
mv -f $depbase.Tpo $depbase.Plo
libtool: compile:  g++ -DHAVE_CONFIG_H -I./.. -pthread -I/usr/include -std=gnu++1y -g -O2 -MT portability/BitsFunctexcept.lo -MD -MP -MF portability/.deps/BitsFunctexcept.Tpo -c portability/BitsFunctexcept.cpp  -fPIC -DPIC -o portability/.libs/BitsFunctexcept.o
libtool: compile:  g++ -DHAVE_CONFIG_H -I./.. -pthread -I/usr/include -std=gnu++1y -g -O2 -MT portability/BitsFunctexcept.lo -MD -MP -MF portability/.deps/BitsFunctexcept.Tpo -c portability/BitsFunctexcept.cpp -o portability/BitsFunctexcept.o >/dev/null 2>&1
depbase=`echo String.lo | sed 's|[^/]*$|.deps/&|;s|\.lo$||'`;\
/bin/bash ./libtool  --tag=CXX   --mode=compile g++ -DHAVE_CONFIG_H   -I./.. -pthread -I/usr/include    -std=gnu++1y -g -O2 -MT String.lo -MD -MP -MF $depbase.Tpo -c -o String.lo String.cpp &&\
mv -f $depbase.Tpo $depbase.Plo
libtool: compile:  g++ -DHAVE_CONFIG_H -I./.. -pthread -I/usr/include -std=gnu++1y -g -O2 -MT String.lo -MD -MP -MF .deps/String.Tpo -c String.cpp  -fPIC -DPIC -o .libs/String.o
libtool: compile:  g++ -DHAVE_CONFIG_H -I./.. -pthread -I/usr/include -std=gnu++1y -g -O2 -MT String.lo -MD -MP -MF .deps/String.Tpo -c String.cpp -o String.o >/dev/null 2>&1
depbase=`echo Unicode.lo | sed 's|[^/]*$|.deps/&|;s|\.lo$||'`;\
/bin/bash ./libtool  --tag=CXX   --mode=compile g++ -DHAVE_CONFIG_H   -I./.. -pthread -I/usr/include    -std=gnu++1y -g -O2 -MT Unicode.lo -MD -MP -MF $depbase.Tpo -c -o Unicode.lo Unicode.cpp &&\
mv -f $depbase.Tpo $depbase.Plo
libtool: compile:  g++ -DHAVE_CONFIG_H -I./.. -pthread -I/usr/include -std=gnu++1y -g -O2 -MT Unicode.lo -MD -MP -MF .deps/Unicode.Tpo -c Unicode.cpp  -fPIC -DPIC -o .libs/Unicode.o
libtool: compile:  g++ -DHAVE_CONFIG_H -I./.. -pthread -I/usr/include -std=gnu++1y -g -O2 -MT Unicode.lo -MD -MP -MF .deps/Unicode.Tpo -c Unicode.cpp -o Unicode.o >/dev/null 2>&1
/bin/bash ./libtool  --tag=CXX   --mode=compile g++ -DHAVE_CONFIG_H   -I./.. -pthread -I/usr/include   -msse4.2 -mpclmul -std=gnu++1y -g -O2 -MT detail/libfollybasesse42_la-RangeSse42.lo -MD -MP -MF detail/.deps/libfollybasesse42_la-RangeSse42.Tpo -c -o detail/libfollybasesse42_la-RangeSse42.lo `test -f 'detail/RangeSse42.cpp' || echo './'`detail/RangeSse42.cpp
libtool: compile:  g++ -DHAVE_CONFIG_H -I./.. -pthread -I/usr/include -msse4.2 -mpclmul -std=gnu++1y -g -O2 -MT detail/libfollybasesse42_la-RangeSse42.lo -MD -MP -MF detail/.deps/libfollybasesse42_la-RangeSse42.Tpo -c detail/RangeSse42.cpp  -fPIC -DPIC -o detail/.libs/libfollybasesse42_la-RangeSse42.o
libtool: compile:  g++ -DHAVE_CONFIG_H -I./.. -pthread -I/usr/include -msse4.2 -mpclmul -std=gnu++1y -g -O2 -MT detail/libfollybasesse42_la-RangeSse42.lo -MD -MP -MF detail/.deps/libfollybasesse42_la-RangeSse42.Tpo -c detail/RangeSse42.cpp -o detail/libfollybasesse42_la-RangeSse42.o >/dev/null 2>&1
mv -f detail/.deps/libfollybasesse42_la-RangeSse42.Tpo detail/.deps/libfollybasesse42_la-RangeSse42.Plo
/bin/bash ./libtool  --tag=CXX   --mode=compile g++ -DHAVE_CONFIG_H   -I./.. -pthread -I/usr/include   -msse4.2 -mpclmul -std=gnu++1y -g -O2 -MT hash/detail/libfollybasesse42_la-ChecksumDetail.lo -MD -MP -MF hash/detail/.deps/libfollybasesse42_la-ChecksumDetail.Tpo -c -o hash/detail/libfollybasesse42_la-ChecksumDetail.lo `test -f 'hash/detail/ChecksumDetail.cpp' || echo './'`hash/detail/ChecksumDetail.cpp
libtool: compile:  g++ -DHAVE_CONFIG_H -I./.. -pthread -I/usr/include -msse4.2 -mpclmul -std=gnu++1y -g -O2 -MT hash/detail/libfollybasesse42_la-ChecksumDetail.lo -MD -MP -MF hash/detail/.deps/libfollybasesse42_la-ChecksumDetail.Tpo -c hash/detail/ChecksumDetail.cpp  -fPIC -DPIC -o hash/detail/.libs/libfollybasesse42_la-ChecksumDetail.o
libtool: compile:  g++ -DHAVE_CONFIG_H -I./.. -pthread -I/usr/include -msse4.2 -mpclmul -std=gnu++1y -g -O2 -MT hash/detail/libfollybasesse42_la-ChecksumDetail.lo -MD -MP -MF hash/detail/.deps/libfollybasesse42_la-ChecksumDetail.Tpo -c hash/detail/ChecksumDetail.cpp -o hash/detail/libfollybasesse42_la-ChecksumDetail.o >/dev/null 2>&1
mv -f hash/detail/.deps/libfollybasesse42_la-ChecksumDetail.Tpo hash/detail/.deps/libfollybasesse42_la-ChecksumDetail.Plo
/bin/bash ./libtool  --tag=CXX   --mode=compile g++ -DHAVE_CONFIG_H   -I./.. -pthread -I/usr/include   -msse4.2 -mpclmul -std=gnu++1y -g -O2 -MT hash/detail/libfollybasesse42_la-Crc32cDetail.lo -MD -MP -MF hash/detail/.deps/libfollybasesse42_la-Crc32cDetail.Tpo -c -o hash/detail/libfollybasesse42_la-Crc32cDetail.lo `test -f 'hash/detail/Crc32cDetail.cpp' || echo './'`hash/detail/Crc32cDetail.cpp
libtool: compile:  g++ -DHAVE_CONFIG_H -I./.. -pthread -I/usr/include -msse4.2 -mpclmul -std=gnu++1y -g -O2 -MT hash/detail/libfollybasesse42_la-Crc32cDetail.lo -MD -MP -MF hash/detail/.deps/libfollybasesse42_la-Crc32cDetail.Tpo -c hash/detail/Crc32cDetail.cpp  -fPIC -DPIC -o hash/detail/.libs/libfollybasesse42_la-Crc32cDetail.o
libtool: compile:  g++ -DHAVE_CONFIG_H -I./.. -pthread -I/usr/include -msse4.2 -mpclmul -std=gnu++1y -g -O2 -MT hash/detail/libfollybasesse42_la-Crc32cDetail.lo -MD -MP -MF hash/detail/.deps/libfollybasesse42_la-Crc32cDetail.Tpo -c hash/detail/Crc32cDetail.cpp -o hash/detail/libfollybasesse42_la-Crc32cDetail.o >/dev/null 2>&1
mv -f hash/detail/.deps/libfollybasesse42_la-Crc32cDetail.Tpo hash/detail/.deps/libfollybasesse42_la-Crc32cDetail.Plo
/bin/bash ./libtool  --tag=CXX   --mode=link g++ -msse4.2 -mpclmul -std=gnu++1y -g -O2 -lboost_context -lboost_program_options -lboost_thread -lboost_filesystem -lboost_system -lboost_regex -lpthread -lboost_chrono  -lssl -lcrypto -version-info 57:0:0  -o libfollybasesse42.la  detail/libfollybasesse42_la-RangeSse42.lo hash/detail/libfollybasesse42_la-ChecksumDetail.lo hash/detail/libfollybasesse42_la-Crc32cDetail.lo  -llzma -lz -lsnappy -llz4 -liberty -ldl -levent -ldouble-conversion -lglog -lgflags
libtool: warning: '-version-info/-version-number' is ignored for convenience libraries
libtool: link: ar cru .libs/libfollybasesse42.a detail/.libs/libfollybasesse42_la-RangeSse42.o hash/detail/.libs/libfollybasesse42_la-ChecksumDetail.o hash/detail/.libs/libfollybasesse42_la-Crc32cDetail.o
ar: `u' modifier ignored since `D' is the default (see `U')
libtool: link: ranlib .libs/libfollybasesse42.a
libtool: link: ( cd ".libs" && rm -f "libfollybasesse42.la" && ln -s "../libfollybasesse42.la" "libfollybasesse42.la" )
/bin/bash ./libtool  --tag=CXX   --mode=link g++  -std=gnu++1y -g -O2 -lboost_context -lboost_program_options -lboost_thread -lboost_filesystem -lboost_system -lboost_regex -lpthread -lboost_chrono  -lssl -lcrypto -version-info 57:0:0  -o libfollybase.la  Conv.lo Demangle.lo detail/RangeCommon.lo EscapeTables.lo Format.lo FormatArg.lo FormatTables.lo memory/MallctlHelper.lo portability/BitsFunctexcept.lo String.lo Unicode.lo  libfollybasesse42.la -llzma -lz -lsnappy -llz4 -liberty -ldl -levent -ldouble-conversion -lglog -lgflags
libtool: warning: '-version-info/-version-number' is ignored for convenience libraries
libtool: link: (cd .libs/libfollybase.lax/libfollybasesse42.a && ar x "/media/tom/document/Syn_Clode/project/folly-2018.01.08.00/folly/./.libs/libfollybasesse42.a")
libtool: link: ar cru .libs/libfollybase.a .libs/Conv.o .libs/Demangle.o detail/.libs/RangeCommon.o .libs/EscapeTables.o .libs/Format.o .libs/FormatArg.o .libs/FormatTables.o memory/.libs/MallctlHelper.o portability/.libs/BitsFunctexcept.o .libs/String.o .libs/Unicode.o   .libs/libfollybase.lax/libfollybasesse42.a/libfollybasesse42_la-ChecksumDetail.o .libs/libfollybase.lax/libfollybasesse42.a/libfollybasesse42_la-Crc32cDetail.o .libs/libfollybase.lax/libfollybasesse42.a/libfollybasesse42_la-RangeSse42.o
ar: `u' modifier ignored since `D' is the default (see `U')
libtool: link: ranlib .libs/libfollybase.a
libtool: link: rm -fr .libs/libfollybase.lax
libtool: link: ( cd ".libs" && rm -f "libfollybase.la" && ln -s "../libfollybase.la" "libfollybase.la" )
/bin/bash ./libtool  --tag=CXX   --mode=link g++  -std=gnu++1y -g -O2 -lboost_context -lboost_program_options -lboost_thread -lboost_filesystem -lboost_system -lboost_regex -lpthread -lboost_chrono  -lssl -lcrypto  -o generate_fingerprint_tables build/GenerateFingerprintTables.o libfollybase.la -llzma -lz -lsnappy -llz4 -liberty -ldl -levent -ldouble-conversion -lglog -lgflags
libtool: link: g++ -std=gnu++1y -g -O2 -o generate_fingerprint_tables build/GenerateFingerprintTables.o  ./.libs/libfollybase.a -lboost_context -lboost_program_options -lboost_thread -lboost_filesystem -lboost_system -lboost_regex -lpthread -lboost_chrono -lssl -lcrypto -llzma -lz -lsnappy -llz4 -liberty -ldl -levent -ldouble-conversion -lglog -lgflags
./generate_fingerprint_tables
depbase=`echo FingerprintTables.lo | sed 's|[^/]*$|.deps/&|;s|\.lo$||'`;\
/bin/bash ./libtool  --tag=CXX   --mode=compile g++ -DHAVE_CONFIG_H   -I./.. -pthread -I/usr/include    -std=gnu++1y -g -O2 -MT FingerprintTables.lo -MD -MP -MF $depbase.Tpo -c -o FingerprintTables.lo FingerprintTables.cpp &&\
mv -f $depbase.Tpo $depbase.Plo
libtool: compile:  g++ -DHAVE_CONFIG_H -I./.. -pthread -I/usr/include -std=gnu++1y -g -O2 -MT FingerprintTables.lo -MD -MP -MF .deps/FingerprintTables.Tpo -c FingerprintTables.cpp  -fPIC -DPIC -o .libs/FingerprintTables.o
libtool: compile:  g++ -DHAVE_CONFIG_H -I./.. -pthread -I/usr/include -std=gnu++1y -g -O2 -MT FingerprintTables.lo -MD -MP -MF .deps/FingerprintTables.Tpo -c FingerprintTables.cpp -o FingerprintTables.o >/dev/null 2>&1
depbase=`echo futures/Barrier.lo | sed 's|[^/]*$|.deps/&|;s|\.lo$||'`;\
/bin/bash ./libtool  --tag=CXX   --mode=compile g++ -DHAVE_CONFIG_H   -I./.. -pthread -I/usr/include    -std=gnu++1y -g -O2 -MT futures/Barrier.lo -MD -MP -MF $depbase.Tpo -c -o futures/Barrier.lo futures/Barrier.cpp &&\
mv -f $depbase.Tpo $depbase.Plo
libtool: compile:  g++ -DHAVE_CONFIG_H -I./.. -pthread -I/usr/include -std=gnu++1y -g -O2 -MT futures/Barrier.lo -MD -MP -MF futures/.deps/Barrier.Tpo -c futures/Barrier.cpp  -fPIC -DPIC -o futures/.libs/Barrier.o
libtool: compile:  g++ -DHAVE_CONFIG_H -I./.. -pthread -I/usr/include -std=gnu++1y -g -O2 -MT futures/Barrier.lo -MD -MP -MF futures/.deps/Barrier.Tpo -c futures/Barrier.cpp -o futures/Barrier.o >/dev/null 2>&1
depbase=`echo futures/Future.lo | sed 's|[^/]*$|.deps/&|;s|\.lo$||'`;\
/bin/bash ./libtool  --tag=CXX   --mode=compile g++ -DHAVE_CONFIG_H   -I./.. -pthread -I/usr/include    -std=gnu++1y -g -O2 -MT futures/Future.lo -MD -MP -MF $depbase.Tpo -c -o futures/Future.lo futures/Future.cpp &&\
mv -f $depbase.Tpo $depbase.Plo
libtool: compile:  g++ -DHAVE_CONFIG_H -I./.. -pthread -I/usr/include -std=gnu++1y -g -O2 -MT futures/Future.lo -MD -MP -MF futures/.deps/Future.Tpo -c futures/Future.cpp  -fPIC -DPIC -o futures/.libs/Future.o
libtool: compile:  g++ -DHAVE_CONFIG_H -I./.. -pthread -I/usr/include -std=gnu++1y -g -O2 -MT futures/Future.lo -MD -MP -MF futures/.deps/Future.Tpo -c futures/Future.cpp -o futures/Future.o >/dev/null 2>&1
depbase=`echo futures/FutureException.lo | sed 's|[^/]*$|.deps/&|;s|\.lo$||'`;\
/bin/bash ./libtool  --tag=CXX   --mode=compile g++ -DHAVE_CONFIG_H   -I./.. -pthread -I/usr/include    -std=gnu++1y -g -O2 -MT futures/FutureException.lo -MD -MP -MF $depbase.Tpo -c -o futures/FutureException.lo futures/FutureException.cpp &&\
mv -f $depbase.Tpo $depbase.Plo
libtool: compile:  g++ -DHAVE_CONFIG_H -I./.. -pthread -I/usr/include -std=gnu++1y -g -O2 -MT futures/FutureException.lo -MD -MP -MF futures/.deps/FutureException.Tpo -c futures/FutureException.cpp  -fPIC -DPIC -o futures/.libs/FutureException.o
libtool: compile:  g++ -DHAVE_CONFIG_H -I./.. -pthread -I/usr/include -std=gnu++1y -g -O2 -MT futures/FutureException.lo -MD -MP -MF futures/.deps/FutureException.Tpo -c futures/FutureException.cpp -o futures/FutureException.o >/dev/null 2>&1
depbase=`echo futures/ThreadWheelTimekeeper.lo | sed 's|[^/]*$|.deps/&|;s|\.lo$||'`;\
/bin/bash ./libtool  --tag=CXX   --mode=compile g++ -DHAVE_CONFIG_H   -I./.. -pthread -I/usr/include    -std=gnu++1y -g -O2 -MT futures/ThreadWheelTimekeeper.lo -MD -MP -MF $depbase.Tpo -c -o futures/ThreadWheelTimekeeper.lo futures/ThreadWheelTimekeeper.cpp &&\
mv -f $depbase.Tpo $depbase.Plo
libtool: compile:  g++ -DHAVE_CONFIG_H -I./.. -pthread -I/usr/include -std=gnu++1y -g -O2 -MT futures/ThreadWheelTimekeeper.lo -MD -MP -MF futures/.deps/ThreadWheelTimekeeper.Tpo -c futures/ThreadWheelTimekeeper.cpp  -fPIC -DPIC -o futures/.libs/ThreadWheelTimekeeper.o
libtool: compile:  g++ -DHAVE_CONFIG_H -I./.. -pthread -I/usr/include -std=gnu++1y -g -O2 -MT futures/ThreadWheelTimekeeper.lo -MD -MP -MF futures/.deps/ThreadWheelTimekeeper.Tpo -c futures/ThreadWheelTimekeeper.cpp -o futures/ThreadWheelTimekeeper.o >/dev/null 2>&1
depbase=`echo futures/test/TestExecutor.lo | sed 's|[^/]*$|.deps/&|;s|\.lo$||'`;\
/bin/bash ./libtool  --tag=CXX   --mode=compile g++ -DHAVE_CONFIG_H   -I./.. -pthread -I/usr/include    -std=gnu++1y -g -O2 -MT futures/test/TestExecutor.lo -MD -MP -MF $depbase.Tpo -c -o futures/test/TestExecutor.lo futures/test/TestExecutor.cpp &&\
mv -f $depbase.Tpo $depbase.Plo
libtool: compile:  g++ -DHAVE_CONFIG_H -I./.. -pthread -I/usr/include -std=gnu++1y -g -O2 -MT futures/test/TestExecutor.lo -MD -MP -MF futures/test/.deps/TestExecutor.Tpo -c futures/test/TestExecutor.cpp  -fPIC -DPIC -o futures/test/.libs/TestExecutor.o
libtool: compile:  g++ -DHAVE_CONFIG_H -I./.. -pthread -I/usr/include -std=gnu++1y -g -O2 -MT futures/test/TestExecutor.lo -MD -MP -MF futures/test/.deps/TestExecutor.Tpo -c futures/test/TestExecutor.cpp -o futures/test/TestExecutor.o >/dev/null 2>&1
depbase=`echo executors/CPUThreadPoolExecutor.lo | sed 's|[^/]*$|.deps/&|;s|\.lo$||'`;\
/bin/bash ./libtool  --tag=CXX   --mode=compile g++ -DHAVE_CONFIG_H   -I./.. -pthread -I/usr/include    -std=gnu++1y -g -O2 -MT executors/CPUThreadPoolExecutor.lo -MD -MP -MF $depbase.Tpo -c -o executors/CPUThreadPoolExecutor.lo executors/CPUThreadPoolExecutor.cpp &&\
mv -f $depbase.Tpo $depbase.Plo
libtool: compile:  g++ -DHAVE_CONFIG_H -I./.. -pthread -I/usr/include -std=gnu++1y -g -O2 -MT executors/CPUThreadPoolExecutor.lo -MD -MP -MF executors/.deps/CPUThreadPoolExecutor.Tpo -c executors/CPUThreadPoolExecutor.cpp  -fPIC -DPIC -o executors/.libs/CPUThreadPoolExecutor.o
libtool: compile:  g++ -DHAVE_CONFIG_H -I./.. -pthread -I/usr/include -std=gnu++1y -g -O2 -MT executors/CPUThreadPoolExecutor.lo -MD -MP -MF executors/.deps/CPUThreadPoolExecutor.Tpo -c executors/CPUThreadPoolExecutor.cpp -o executors/CPUThreadPoolExecutor.o >/dev/null 2>&1
depbase=`echo executors/Codel.lo | sed 's|[^/]*$|.deps/&|;s|\.lo$||'`;\
/bin/bash ./libtool  --tag=CXX   --mode=compile g++ -DHAVE_CONFIG_H   -I./.. -pthread -I/usr/include    -std=gnu++1y -g -O2 -MT executors/Codel.lo -MD -MP -MF $depbase.Tpo -c -o executors/Codel.lo executors/Codel.cpp &&\
mv -f $depbase.Tpo $depbase.Plo
libtool: compile:  g++ -DHAVE_CONFIG_H -I./.. -pthread -I/usr/include -std=gnu++1y -g -O2 -MT executors/Codel.lo -MD -MP -MF executors/.deps/Codel.Tpo -c executors/Codel.cpp  -fPIC -DPIC -o executors/.libs/Codel.o
libtool: compile:  g++ -DHAVE_CONFIG_H -I./.. -pthread -I/usr/include -std=gnu++1y -g -O2 -MT executors/Codel.lo -MD -MP -MF executors/.deps/Codel.Tpo -c executors/Codel.cpp -o executors/Codel.o >/dev/null 2>&1
depbase=`echo executors/GlobalExecutor.lo | sed 's|[^/]*$|.deps/&|;s|\.lo$||'`;\
/bin/bash ./libtool  --tag=CXX   --mode=compile g++ -DHAVE_CONFIG_H   -I./.. -pthread -I/usr/include    -std=gnu++1y -g -O2 -MT executors/GlobalExecutor.lo -MD -MP -MF $depbase.Tpo -c -o executors/GlobalExecutor.lo executors/GlobalExecutor.cpp &&\
mv -f $depbase.Tpo $depbase.Plo
libtool: compile:  g++ -DHAVE_CONFIG_H -I./.. -pthread -I/usr/include -std=gnu++1y -g -O2 -MT executors/GlobalExecutor.lo -MD -MP -MF executors/.deps/GlobalExecutor.Tpo -c executors/GlobalExecutor.cpp  -fPIC -DPIC -o executors/.libs/GlobalExecutor.o
libtool: compile:  g++ -DHAVE_CONFIG_H -I./.. -pthread -I/usr/include -std=gnu++1y -g -O2 -MT executors/GlobalExecutor.lo -MD -MP -MF executors/.deps/GlobalExecutor.Tpo -c executors/GlobalExecutor.cpp -o executors/GlobalExecutor.o >/dev/null 2>&1
depbase=`echo executors/GlobalThreadPoolList.lo | sed 's|[^/]*$|.deps/&|;s|\.lo$||'`;\
/bin/bash ./libtool  --tag=CXX   --mode=compile g++ -DHAVE_CONFIG_H   -I./.. -pthread -I/usr/include    -std=gnu++1y -g -O2 -MT executors/GlobalThreadPoolList.lo -MD -MP -MF $depbase.Tpo -c -o executors/GlobalThreadPoolList.lo executors/GlobalThreadPoolList.cpp &&\
mv -f $depbase.Tpo $depbase.Plo
libtool: compile:  g++ -DHAVE_CONFIG_H -I./.. -pthread -I/usr/include -std=gnu++1y -g -O2 -MT executors/GlobalThreadPoolList.lo -MD -MP -MF executors/.deps/GlobalThreadPoolList.Tpo -c executors/GlobalThreadPoolList.cpp  -fPIC -DPIC -o executors/.libs/GlobalThreadPoolList.o
libtool: compile:  g++ -DHAVE_CONFIG_H -I./.. -pthread -I/usr/include -std=gnu++1y -g -O2 -MT executors/GlobalThreadPoolList.lo -MD -MP -MF executors/.deps/GlobalThreadPoolList.Tpo -c executors/GlobalThreadPoolList.cpp -o executors/GlobalThreadPoolList.o >/dev/null 2>&1
depbase=`echo executors/IOThreadPoolExecutor.lo | sed 's|[^/]*$|.deps/&|;s|\.lo$||'`;\
/bin/bash ./libtool  --tag=CXX   --mode=compile g++ -DHAVE_CONFIG_H   -I./.. -pthread -I/usr/include    -std=gnu++1y -g -O2 -MT executors/IOThreadPoolExecutor.lo -MD -MP -MF $depbase.Tpo -c -o executors/IOThreadPoolExecutor.lo executors/IOThreadPoolExecutor.cpp &&\
mv -f $depbase.Tpo $depbase.Plo
libtool: compile:  g++ -DHAVE_CONFIG_H -I./.. -pthread -I/usr/include -std=gnu++1y -g -O2 -MT executors/IOThreadPoolExecutor.lo -MD -MP -MF executors/.deps/IOThreadPoolExecutor.Tpo -c executors/IOThreadPoolExecutor.cpp  -fPIC -DPIC -o executors/.libs/IOThreadPoolExecutor.o
libtool: compile:  g++ -DHAVE_CONFIG_H -I./.. -pthread -I/usr/include -std=gnu++1y -g -O2 -MT executors/IOThreadPoolExecutor.lo -MD -MP -MF executors/.deps/IOThreadPoolExecutor.Tpo -c executors/IOThreadPoolExecutor.cpp -o executors/IOThreadPoolExecutor.o >/dev/null 2>&1
depbase=`echo executors/InlineExecutor.lo | sed 's|[^/]*$|.deps/&|;s|\.lo$||'`;\
/bin/bash ./libtool  --tag=CXX   --mode=compile g++ -DHAVE_CONFIG_H   -I./.. -pthread -I/usr/include    -std=gnu++1y -g -O2 -MT executors/InlineExecutor.lo -MD -MP -MF $depbase.Tpo -c -o executors/InlineExecutor.lo executors/InlineExecutor.cpp &&\
mv -f $depbase.Tpo $depbase.Plo
libtool: compile:  g++ -DHAVE_CONFIG_H -I./.. -pthread -I/usr/include -std=gnu++1y -g -O2 -MT executors/InlineExecutor.lo -MD -MP -MF executors/.deps/InlineExecutor.Tpo -c executors/InlineExecutor.cpp  -fPIC -DPIC -o executors/.libs/InlineExecutor.o
libtool: compile:  g++ -DHAVE_CONFIG_H -I./.. -pthread -I/usr/include -std=gnu++1y -g -O2 -MT executors/InlineExecutor.lo -MD -MP -MF executors/.deps/InlineExecutor.Tpo -c executors/InlineExecutor.cpp -o executors/InlineExecutor.o >/dev/null 2>&1
depbase=`echo executors/ManualExecutor.lo | sed 's|[^/]*$|.deps/&|;s|\.lo$||'`;\
/bin/bash ./libtool  --tag=CXX   --mode=compile g++ -DHAVE_CONFIG_H   -I./.. -pthread -I/usr/include    -std=gnu++1y -g -O2 -MT executors/ManualExecutor.lo -MD -MP -MF $depbase.Tpo -c -o executors/ManualExecutor.lo executors/ManualExecutor.cpp &&\
mv -f $depbase.Tpo $depbase.Plo
libtool: compile:  g++ -DHAVE_CONFIG_H -I./.. -pthread -I/usr/include -std=gnu++1y -g -O2 -MT executors/ManualExecutor.lo -MD -MP -MF executors/.deps/ManualExecutor.Tpo -c executors/ManualExecutor.cpp  -fPIC -DPIC -o executors/.libs/ManualExecutor.o
libtool: compile:  g++ -DHAVE_CONFIG_H -I./.. -pthread -I/usr/include -std=gnu++1y -g -O2 -MT executors/ManualExecutor.lo -MD -MP -MF executors/.deps/ManualExecutor.Tpo -c executors/ManualExecutor.cpp -o executors/ManualExecutor.o >/dev/null 2>&1
depbase=`echo executors/SerialExecutor.lo | sed 's|[^/]*$|.deps/&|;s|\.lo$||'`;\
/bin/bash ./libtool  --tag=CXX   --mode=compile g++ -DHAVE_CONFIG_H   -I./.. -pthread -I/usr/include    -std=gnu++1y -g -O2 -MT executors/SerialExecutor.lo -MD -MP -MF $depbase.Tpo -c -o executors/SerialExecutor.lo executors/SerialExecutor.cpp &&\
mv -f $depbase.Tpo $depbase.Plo
libtool: compile:  g++ -DHAVE_CONFIG_H -I./.. -pthread -I/usr/include -std=gnu++1y -g -O2 -MT executors/SerialExecutor.lo -MD -MP -MF executors/.deps/SerialExecutor.Tpo -c executors/SerialExecutor.cpp  -fPIC -DPIC -o executors/.libs/SerialExecutor.o
libtool: compile:  g++ -DHAVE_CONFIG_H -I./.. -pthread -I/usr/include -std=gnu++1y -g -O2 -MT executors/SerialExecutor.lo -MD -MP -MF executors/.deps/SerialExecutor.Tpo -c executors/SerialExecutor.cpp -o executors/SerialExecutor.o >/dev/null 2>&1
depbase=`echo executors/ThreadPoolExecutor.lo | sed 's|[^/]*$|.deps/&|;s|\.lo$||'`;\
/bin/bash ./libtool  --tag=CXX   --mode=compile g++ -DHAVE_CONFIG_H   -I./.. -pthread -I/usr/include    -std=gnu++1y -g -O2 -MT executors/ThreadPoolExecutor.lo -MD -MP -MF $depbase.Tpo -c -o executors/ThreadPoolExecutor.lo executors/ThreadPoolExecutor.cpp &&\
mv -f $depbase.Tpo $depbase.Plo
libtool: compile:  g++ -DHAVE_CONFIG_H -I./.. -pthread -I/usr/include -std=gnu++1y -g -O2 -MT executors/ThreadPoolExecutor.lo -MD -MP -MF executors/.deps/ThreadPoolExecutor.Tpo -c executors/ThreadPoolExecutor.cpp  -fPIC -DPIC -o executors/.libs/ThreadPoolExecutor.o
libtool: compile:  g++ -DHAVE_CONFIG_H -I./.. -pthread -I/usr/include -std=gnu++1y -g -O2 -MT executors/ThreadPoolExecutor.lo -MD -MP -MF executors/.deps/ThreadPoolExecutor.Tpo -c executors/ThreadPoolExecutor.cpp -o executors/ThreadPoolExecutor.o >/dev/null 2>&1
depbase=`echo executors/ThreadedExecutor.lo | sed 's|[^/]*$|.deps/&|;s|\.lo$||'`;\
/bin/bash ./libtool  --tag=CXX   --mode=compile g++ -DHAVE_CONFIG_H   -I./.. -pthread -I/usr/include    -std=gnu++1y -g -O2 -MT executors/ThreadedExecutor.lo -MD -MP -MF $depbase.Tpo -c -o executors/ThreadedExecutor.lo executors/ThreadedExecutor.cpp &&\
mv -f $depbase.Tpo $depbase.Plo
libtool: compile:  g++ -DHAVE_CONFIG_H -I./.. -pthread -I/usr/include -std=gnu++1y -g -O2 -MT executors/ThreadedExecutor.lo -MD -MP -MF executors/.deps/ThreadedExecutor.Tpo -c executors/ThreadedExecutor.cpp  -fPIC -DPIC -o executors/.libs/ThreadedExecutor.o
libtool: compile:  g++ -DHAVE_CONFIG_H -I./.. -pthread -I/usr/include -std=gnu++1y -g -O2 -MT executors/ThreadedExecutor.lo -MD -MP -MF executors/.deps/ThreadedExecutor.Tpo -c executors/ThreadedExecutor.cpp -o executors/ThreadedExecutor.o >/dev/null 2>&1
depbase=`echo executors/QueuedImmediateExecutor.lo | sed 's|[^/]*$|.deps/&|;s|\.lo$||'`;\
/bin/bash ./libtool  --tag=CXX   --mode=compile g++ -DHAVE_CONFIG_H   -I./.. -pthread -I/usr/include    -std=gnu++1y -g -O2 -MT executors/QueuedImmediateExecutor.lo -MD -MP -MF $depbase.Tpo -c -o executors/QueuedImmediateExecutor.lo executors/QueuedImmediateExecutor.cpp &&\
mv -f $depbase.Tpo $depbase.Plo
libtool: compile:  g++ -DHAVE_CONFIG_H -I./.. -pthread -I/usr/include -std=gnu++1y -g -O2 -MT executors/QueuedImmediateExecutor.lo -MD -MP -MF executors/.deps/QueuedImmediateExecutor.Tpo -c executors/QueuedImmediateExecutor.cpp  -fPIC -DPIC -o executors/.libs/QueuedImmediateExecutor.o
libtool: compile:  g++ -DHAVE_CONFIG_H -I./.. -pthread -I/usr/include -std=gnu++1y -g -O2 -MT executors/QueuedImmediateExecutor.lo -MD -MP -MF executors/.deps/QueuedImmediateExecutor.Tpo -c executors/QueuedImmediateExecutor.cpp -o executors/QueuedImmediateExecutor.o >/dev/null 2>&1
depbase=`echo experimental/hazptr/hazptr.lo | sed 's|[^/]*$|.deps/&|;s|\.lo$||'`;\
/bin/bash ./libtool  --tag=CXX   --mode=compile g++ -DHAVE_CONFIG_H   -I./.. -pthread -I/usr/include    -std=gnu++1y -g -O2 -MT experimental/hazptr/hazptr.lo -MD -MP -MF $depbase.Tpo -c -o experimental/hazptr/hazptr.lo experimental/hazptr/hazptr.cpp &&\
mv -f $depbase.Tpo $depbase.Plo
libtool: compile:  g++ -DHAVE_CONFIG_H -I./.. -pthread -I/usr/include -std=gnu++1y -g -O2 -MT experimental/hazptr/hazptr.lo -MD -MP -MF experimental/hazptr/.deps/hazptr.Tpo -c experimental/hazptr/hazptr.cpp  -fPIC -DPIC -o experimental/hazptr/.libs/hazptr.o
libtool: compile:  g++ -DHAVE_CONFIG_H -I./.. -pthread -I/usr/include -std=gnu++1y -g -O2 -MT experimental/hazptr/hazptr.lo -MD -MP -MF experimental/hazptr/.deps/hazptr.Tpo -c experimental/hazptr/hazptr.cpp -o experimental/hazptr/hazptr.o >/dev/null 2>&1
depbase=`echo experimental/hazptr/memory_resource.lo | sed 's|[^/]*$|.deps/&|;s|\.lo$||'`;\
/bin/bash ./libtool  --tag=CXX   --mode=compile g++ -DHAVE_CONFIG_H   -I./.. -pthread -I/usr/include    -std=gnu++1y -g -O2 -MT experimental/hazptr/memory_resource.lo -MD -MP -MF $depbase.Tpo -c -o experimental/hazptr/memory_resource.lo experimental/hazptr/memory_resource.cpp &&\
mv -f $depbase.Tpo $depbase.Plo
libtool: compile:  g++ -DHAVE_CONFIG_H -I./.. -pthread -I/usr/include -std=gnu++1y -g -O2 -MT experimental/hazptr/memory_resource.lo -MD -MP -MF experimental/hazptr/.deps/memory_resource.Tpo -c experimental/hazptr/memory_resource.cpp  -fPIC -DPIC -o experimental/hazptr/.libs/memory_resource.o
libtool: compile:  g++ -DHAVE_CONFIG_H -I./.. -pthread -I/usr/include -std=gnu++1y -g -O2 -MT experimental/hazptr/memory_resource.lo -MD -MP -MF experimental/hazptr/.deps/memory_resource.Tpo -c experimental/hazptr/memory_resource.cpp -o experimental/hazptr/memory_resource.o >/dev/null 2>&1
depbase=`echo GroupVarint.lo | sed 's|[^/]*$|.deps/&|;s|\.lo$||'`;\
/bin/bash ./libtool  --tag=CXX   --mode=compile g++ -DHAVE_CONFIG_H   -I./.. -pthread -I/usr/include    -std=gnu++1y -g -O2 -MT GroupVarint.lo -MD -MP -MF $depbase.Tpo -c -o GroupVarint.lo GroupVarint.cpp &&\
mv -f $depbase.Tpo $depbase.Plo
libtool: compile:  g++ -DHAVE_CONFIG_H -I./.. -pthread -I/usr/include -std=gnu++1y -g -O2 -MT GroupVarint.lo -MD -MP -MF .deps/GroupVarint.Tpo -c GroupVarint.cpp  -fPIC -DPIC -o .libs/GroupVarint.o
libtool: compile:  g++ -DHAVE_CONFIG_H -I./.. -pthread -I/usr/include -std=gnu++1y -g -O2 -MT GroupVarint.lo -MD -MP -MF .deps/GroupVarint.Tpo -c GroupVarint.cpp -o GroupVarint.o >/dev/null 2>&1
/usr/bin/python build/generate_varint_tables.py
depbase=`echo GroupVarintTables.lo | sed 's|[^/]*$|.deps/&|;s|\.lo$||'`;\
/bin/bash ./libtool  --tag=CXX   --mode=compile g++ -DHAVE_CONFIG_H   -I./.. -pthread -I/usr/include    -std=gnu++1y -g -O2 -MT GroupVarintTables.lo -MD -MP -MF $depbase.Tpo -c -o GroupVarintTables.lo GroupVarintTables.cpp &&\
mv -f $depbase.Tpo $depbase.Plo
libtool: compile:  g++ -DHAVE_CONFIG_H -I./.. -pthread -I/usr/include -std=gnu++1y -g -O2 -MT GroupVarintTables.lo -MD -MP -MF .deps/GroupVarintTables.Tpo -c GroupVarintTables.cpp  -fPIC -DPIC -o .libs/GroupVarintTables.o
libtool: compile:  g++ -DHAVE_CONFIG_H -I./.. -pthread -I/usr/include -std=gnu++1y -g -O2 -MT GroupVarintTables.lo -MD -MP -MF .deps/GroupVarintTables.Tpo -c GroupVarintTables.cpp -o GroupVarintTables.o >/dev/null 2>&1
depbase=`echo hash/Checksum.lo | sed 's|[^/]*$|.deps/&|;s|\.lo$||'`;\
/bin/bash ./libtool  --tag=CXX   --mode=compile g++ -DHAVE_CONFIG_H   -I./.. -pthread -I/usr/include    -std=gnu++1y -g -O2 -MT hash/Checksum.lo -MD -MP -MF $depbase.Tpo -c -o hash/Checksum.lo hash/Checksum.cpp &&\
mv -f $depbase.Tpo $depbase.Plo
libtool: compile:  g++ -DHAVE_CONFIG_H -I./.. -pthread -I/usr/include -std=gnu++1y -g -O2 -MT hash/Checksum.lo -MD -MP -MF hash/.deps/Checksum.Tpo -c hash/Checksum.cpp  -fPIC -DPIC -o hash/.libs/Checksum.o
libtool: compile:  g++ -DHAVE_CONFIG_H -I./.. -pthread -I/usr/include -std=gnu++1y -g -O2 -MT hash/Checksum.lo -MD -MP -MF hash/.deps/Checksum.Tpo -c hash/Checksum.cpp -o hash/Checksum.o >/dev/null 2>&1
depbase=`echo hash/SpookyHashV1.lo | sed 's|[^/]*$|.deps/&|;s|\.lo$||'`;\
/bin/bash ./libtool  --tag=CXX   --mode=compile g++ -DHAVE_CONFIG_H   -I./.. -pthread -I/usr/include    -std=gnu++1y -g -O2 -MT hash/SpookyHashV1.lo -MD -MP -MF $depbase.Tpo -c -o hash/SpookyHashV1.lo hash/SpookyHashV1.cpp &&\
mv -f $depbase.Tpo $depbase.Plo
libtool: compile:  g++ -DHAVE_CONFIG_H -I./.. -pthread -I/usr/include -std=gnu++1y -g -O2 -MT hash/SpookyHashV1.lo -MD -MP -MF hash/.deps/SpookyHashV1.Tpo -c hash/SpookyHashV1.cpp  -fPIC -DPIC -o hash/.libs/SpookyHashV1.o
libtool: compile:  g++ -DHAVE_CONFIG_H -I./.. -pthread -I/usr/include -std=gnu++1y -g -O2 -MT hash/SpookyHashV1.lo -MD -MP -MF hash/.deps/SpookyHashV1.Tpo -c hash/SpookyHashV1.cpp -o hash/SpookyHashV1.o >/dev/null 2>&1
depbase=`echo hash/SpookyHashV2.lo | sed 's|[^/]*$|.deps/&|;s|\.lo$||'`;\
/bin/bash ./libtool  --tag=CXX   --mode=compile g++ -DHAVE_CONFIG_H   -I./.. -pthread -I/usr/include    -std=gnu++1y -g -O2 -MT hash/SpookyHashV2.lo -MD -MP -MF $depbase.Tpo -c -o hash/SpookyHashV2.lo hash/SpookyHashV2.cpp &&\
mv -f $depbase.Tpo $depbase.Plo
libtool: compile:  g++ -DHAVE_CONFIG_H -I./.. -pthread -I/usr/include -std=gnu++1y -g -O2 -MT hash/SpookyHashV2.lo -MD -MP -MF hash/.deps/SpookyHashV2.Tpo -c hash/SpookyHashV2.cpp  -fPIC -DPIC -o hash/.libs/SpookyHashV2.o
libtool: compile:  g++ -DHAVE_CONFIG_H -I./.. -pthread -I/usr/include -std=gnu++1y -g -O2 -MT hash/SpookyHashV2.lo -MD -MP -MF hash/.deps/SpookyHashV2.Tpo -c hash/SpookyHashV2.cpp -o hash/SpookyHashV2.o >/dev/null 2>&1
depbase=`echo IPAddress.lo | sed 's|[^/]*$|.deps/&|;s|\.lo$||'`;\
/bin/bash ./libtool  --tag=CXX   --mode=compile g++ -DHAVE_CONFIG_H   -I./.. -pthread -I/usr/include    -std=gnu++1y -g -O2 -MT IPAddress.lo -MD -MP -MF $depbase.Tpo -c -o IPAddress.lo IPAddress.cpp &&\
mv -f $depbase.Tpo $depbase.Plo
libtool: compile:  g++ -DHAVE_CONFIG_H -I./.. -pthread -I/usr/include -std=gnu++1y -g -O2 -MT IPAddress.lo -MD -MP -MF .deps/IPAddress.Tpo -c IPAddress.cpp  -fPIC -DPIC -o .libs/IPAddress.o
libtool: compile:  g++ -DHAVE_CONFIG_H -I./.. -pthread -I/usr/include -std=gnu++1y -g -O2 -MT IPAddress.lo -MD -MP -MF .deps/IPAddress.Tpo -c IPAddress.cpp -o IPAddress.o >/dev/null 2>&1
depbase=`echo IPAddressV4.lo | sed 's|[^/]*$|.deps/&|;s|\.lo$||'`;\
/bin/bash ./libtool  --tag=CXX   --mode=compile g++ -DHAVE_CONFIG_H   -I./.. -pthread -I/usr/include    -std=gnu++1y -g -O2 -MT IPAddressV4.lo -MD -MP -MF $depbase.Tpo -c -o IPAddressV4.lo IPAddressV4.cpp &&\
mv -f $depbase.Tpo $depbase.Plo
libtool: compile:  g++ -DHAVE_CONFIG_H -I./.. -pthread -I/usr/include -std=gnu++1y -g -O2 -MT IPAddressV4.lo -MD -MP -MF .deps/IPAddressV4.Tpo -c IPAddressV4.cpp  -fPIC -DPIC -o .libs/IPAddressV4.o
libtool: compile:  g++ -DHAVE_CONFIG_H -I./.. -pthread -I/usr/include -std=gnu++1y -g -O2 -MT IPAddressV4.lo -MD -MP -MF .deps/IPAddressV4.Tpo -c IPAddressV4.cpp -o IPAddressV4.o >/dev/null 2>&1
depbase=`echo IPAddressV6.lo | sed 's|[^/]*$|.deps/&|;s|\.lo$||'`;\
/bin/bash ./libtool  --tag=CXX   --mode=compile g++ -DHAVE_CONFIG_H   -I./.. -pthread -I/usr/include    -std=gnu++1y -g -O2 -MT IPAddressV6.lo -MD -MP -MF $depbase.Tpo -c -o IPAddressV6.lo IPAddressV6.cpp &&\
mv -f $depbase.Tpo $depbase.Plo
libtool: compile:  g++ -DHAVE_CONFIG_H -I./.. -pthread -I/usr/include -std=gnu++1y -g -O2 -MT IPAddressV6.lo -MD -MP -MF .deps/IPAddressV6.Tpo -c IPAddressV6.cpp  -fPIC -DPIC -o .libs/IPAddressV6.o
libtool: compile:  g++ -DHAVE_CONFIG_H -I./.. -pthread -I/usr/include -std=gnu++1y -g -O2 -MT IPAddressV6.lo -MD -MP -MF .deps/IPAddressV6.Tpo -c IPAddressV6.cpp -o IPAddressV6.o >/dev/null 2>&1
depbase=`echo init/Init.lo | sed 's|[^/]*$|.deps/&|;s|\.lo$||'`;\
/bin/bash ./libtool  --tag=CXX   --mode=compile g++ -DHAVE_CONFIG_H   -I./.. -pthread -I/usr/include    -std=gnu++1y -g -O2 -MT init/Init.lo -MD -MP -MF $depbase.Tpo -c -o init/Init.lo init/Init.cpp &&\
mv -f $depbase.Tpo $depbase.Plo
libtool: compile:  g++ -DHAVE_CONFIG_H -I./.. -pthread -I/usr/include -std=gnu++1y -g -O2 -MT init/Init.lo -MD -MP -MF init/.deps/Init.Tpo -c init/Init.cpp  -fPIC -DPIC -o init/.libs/Init.o
libtool: compile:  g++ -DHAVE_CONFIG_H -I./.. -pthread -I/usr/include -std=gnu++1y -g -O2 -MT init/Init.lo -MD -MP -MF init/.deps/Init.Tpo -c init/Init.cpp -o init/Init.o >/dev/null 2>&1
depbase=`echo io/Cursor.lo | sed 's|[^/]*$|.deps/&|;s|\.lo$||'`;\
/bin/bash ./libtool  --tag=CXX   --mode=compile g++ -DHAVE_CONFIG_H   -I./.. -pthread -I/usr/include    -std=gnu++1y -g -O2 -MT io/Cursor.lo -MD -MP -MF $depbase.Tpo -c -o io/Cursor.lo io/Cursor.cpp &&\
mv -f $depbase.Tpo $depbase.Plo
libtool: compile:  g++ -DHAVE_CONFIG_H -I./.. -pthread -I/usr/include -std=gnu++1y -g -O2 -MT io/Cursor.lo -MD -MP -MF io/.deps/Cursor.Tpo -c io/Cursor.cpp  -fPIC -DPIC -o io/.libs/Cursor.o
libtool: compile:  g++ -DHAVE_CONFIG_H -I./.. -pthread -I/usr/include -std=gnu++1y -g -O2 -MT io/Cursor.lo -MD -MP -MF io/.deps/Cursor.Tpo -c io/Cursor.cpp -o io/Cursor.o >/dev/null 2>&1
depbase=`echo io/IOBuf.lo | sed 's|[^/]*$|.deps/&|;s|\.lo$||'`;\
/bin/bash ./libtool  --tag=CXX   --mode=compile g++ -DHAVE_CONFIG_H   -I./.. -pthread -I/usr/include    -std=gnu++1y -g -O2 -MT io/IOBuf.lo -MD -MP -MF $depbase.Tpo -c -o io/IOBuf.lo io/IOBuf.cpp &&\
mv -f $depbase.Tpo $depbase.Plo
libtool: compile:  g++ -DHAVE_CONFIG_H -I./.. -pthread -I/usr/include -std=gnu++1y -g -O2 -MT io/IOBuf.lo -MD -MP -MF io/.deps/IOBuf.Tpo -c io/IOBuf.cpp  -fPIC -DPIC -o io/.libs/IOBuf.o
libtool: compile:  g++ -DHAVE_CONFIG_H -I./.. -pthread -I/usr/include -std=gnu++1y -g -O2 -MT io/IOBuf.lo -MD -MP -MF io/.deps/IOBuf.Tpo -c io/IOBuf.cpp -o io/IOBuf.o >/dev/null 2>&1
depbase=`echo io/IOBufQueue.lo | sed 's|[^/]*$|.deps/&|;s|\.lo$||'`;\
/bin/bash ./libtool  --tag=CXX   --mode=compile g++ -DHAVE_CONFIG_H   -I./.. -pthread -I/usr/include    -std=gnu++1y -g -O2 -MT io/IOBufQueue.lo -MD -MP -MF $depbase.Tpo -c -o io/IOBufQueue.lo io/IOBufQueue.cpp &&\
mv -f $depbase.Tpo $depbase.Plo
libtool: compile:  g++ -DHAVE_CONFIG_H -I./.. -pthread -I/usr/include -std=gnu++1y -g -O2 -MT io/IOBufQueue.lo -MD -MP -MF io/.deps/IOBufQueue.Tpo -c io/IOBufQueue.cpp  -fPIC -DPIC -o io/.libs/IOBufQueue.o
libtool: compile:  g++ -DHAVE_CONFIG_H -I./.. -pthread -I/usr/include -std=gnu++1y -g -O2 -MT io/IOBufQueue.lo -MD -MP -MF io/.deps/IOBufQueue.Tpo -c io/IOBufQueue.cpp -o io/IOBufQueue.o >/dev/null 2>&1
depbase=`echo io/RecordIO.lo | sed 's|[^/]*$|.deps/&|;s|\.lo$||'`;\
/bin/bash ./libtool  --tag=CXX   --mode=compile g++ -DHAVE_CONFIG_H   -I./.. -pthread -I/usr/include    -std=gnu++1y -g -O2 -MT io/RecordIO.lo -MD -MP -MF $depbase.Tpo -c -o io/RecordIO.lo io/RecordIO.cpp &&\
mv -f $depbase.Tpo $depbase.Plo
libtool: compile:  g++ -DHAVE_CONFIG_H -I./.. -pthread -I/usr/include -std=gnu++1y -g -O2 -MT io/RecordIO.lo -MD -MP -MF io/.deps/RecordIO.Tpo -c io/RecordIO.cpp  -fPIC -DPIC -o io/.libs/RecordIO.o
libtool: compile:  g++ -DHAVE_CONFIG_H -I./.. -pthread -I/usr/include -std=gnu++1y -g -O2 -MT io/RecordIO.lo -MD -MP -MF io/.deps/RecordIO.Tpo -c io/RecordIO.cpp -o io/RecordIO.o >/dev/null 2>&1
depbase=`echo io/ShutdownSocketSet.lo | sed 's|[^/]*$|.deps/&|;s|\.lo$||'`;\
/bin/bash ./libtool  --tag=CXX   --mode=compile g++ -DHAVE_CONFIG_H   -I./.. -pthread -I/usr/include    -std=gnu++1y -g -O2 -MT io/ShutdownSocketSet.lo -MD -MP -MF $depbase.Tpo -c -o io/ShutdownSocketSet.lo io/ShutdownSocketSet.cpp &&\
mv -f $depbase.Tpo $depbase.Plo
libtool: compile:  g++ -DHAVE_CONFIG_H -I./.. -pthread -I/usr/include -std=gnu++1y -g -O2 -MT io/ShutdownSocketSet.lo -MD -MP -MF io/.deps/ShutdownSocketSet.Tpo -c io/ShutdownSocketSet.cpp  -fPIC -DPIC -o io/.libs/ShutdownSocketSet.o
libtool: compile:  g++ -DHAVE_CONFIG_H -I./.. -pthread -I/usr/include -std=gnu++1y -g -O2 -MT io/ShutdownSocketSet.lo -MD -MP -MF io/.deps/ShutdownSocketSet.Tpo -c io/ShutdownSocketSet.cpp -o io/ShutdownSocketSet.o >/dev/null 2>&1
depbase=`echo io/async/AsyncPipe.lo | sed 's|[^/]*$|.deps/&|;s|\.lo$||'`;\
/bin/bash ./libtool  --tag=CXX   --mode=compile g++ -DHAVE_CONFIG_H   -I./.. -pthread -I/usr/include    -std=gnu++1y -g -O2 -MT io/async/AsyncPipe.lo -MD -MP -MF $depbase.Tpo -c -o io/async/AsyncPipe.lo io/async/AsyncPipe.cpp &&\
mv -f $depbase.Tpo $depbase.Plo
libtool: compile:  g++ -DHAVE_CONFIG_H -I./.. -pthread -I/usr/include -std=gnu++1y -g -O2 -MT io/async/AsyncPipe.lo -MD -MP -MF io/async/.deps/AsyncPipe.Tpo -c io/async/AsyncPipe.cpp  -fPIC -DPIC -o io/async/.libs/AsyncPipe.o
libtool: compile:  g++ -DHAVE_CONFIG_H -I./.. -pthread -I/usr/include -std=gnu++1y -g -O2 -MT io/async/AsyncPipe.lo -MD -MP -MF io/async/.deps/AsyncPipe.Tpo -c io/async/AsyncPipe.cpp -o io/async/AsyncPipe.o >/dev/null 2>&1
depbase=`echo io/async/AsyncTimeout.lo | sed 's|[^/]*$|.deps/&|;s|\.lo$||'`;\
/bin/bash ./libtool  --tag=CXX   --mode=compile g++ -DHAVE_CONFIG_H   -I./.. -pthread -I/usr/include    -std=gnu++1y -g -O2 -MT io/async/AsyncTimeout.lo -MD -MP -MF $depbase.Tpo -c -o io/async/AsyncTimeout.lo io/async/AsyncTimeout.cpp &&\
mv -f $depbase.Tpo $depbase.Plo
libtool: compile:  g++ -DHAVE_CONFIG_H -I./.. -pthread -I/usr/include -std=gnu++1y -g -O2 -MT io/async/AsyncTimeout.lo -MD -MP -MF io/async/.deps/AsyncTimeout.Tpo -c io/async/AsyncTimeout.cpp  -fPIC -DPIC -o io/async/.libs/AsyncTimeout.o
libtool: compile:  g++ -DHAVE_CONFIG_H -I./.. -pthread -I/usr/include -std=gnu++1y -g -O2 -MT io/async/AsyncTimeout.lo -MD -MP -MF io/async/.deps/AsyncTimeout.Tpo -c io/async/AsyncTimeout.cpp -o io/async/AsyncTimeout.o >/dev/null 2>&1
depbase=`echo io/async/AsyncUDPSocket.lo | sed 's|[^/]*$|.deps/&|;s|\.lo$||'`;\
/bin/bash ./libtool  --tag=CXX   --mode=compile g++ -DHAVE_CONFIG_H   -I./.. -pthread -I/usr/include    -std=gnu++1y -g -O2 -MT io/async/AsyncUDPSocket.lo -MD -MP -MF $depbase.Tpo -c -o io/async/AsyncUDPSocket.lo io/async/AsyncUDPSocket.cpp &&\
mv -f $depbase.Tpo $depbase.Plo
libtool: compile:  g++ -DHAVE_CONFIG_H -I./.. -pthread -I/usr/include -std=gnu++1y -g -O2 -MT io/async/AsyncUDPSocket.lo -MD -MP -MF io/async/.deps/AsyncUDPSocket.Tpo -c io/async/AsyncUDPSocket.cpp  -fPIC -DPIC -o io/async/.libs/AsyncUDPSocket.o
libtool: compile:  g++ -DHAVE_CONFIG_H -I./.. -pthread -I/usr/include -std=gnu++1y -g -O2 -MT io/async/AsyncUDPSocket.lo -MD -MP -MF io/async/.deps/AsyncUDPSocket.Tpo -c io/async/AsyncUDPSocket.cpp -o io/async/AsyncUDPSocket.o >/dev/null 2>&1
depbase=`echo io/async/AsyncServerSocket.lo | sed 's|[^/]*$|.deps/&|;s|\.lo$||'`;\
/bin/bash ./libtool  --tag=CXX   --mode=compile g++ -DHAVE_CONFIG_H   -I./.. -pthread -I/usr/include    -std=gnu++1y -g -O2 -MT io/async/AsyncServerSocket.lo -MD -MP -MF $depbase.Tpo -c -o io/async/AsyncServerSocket.lo io/async/AsyncServerSocket.cpp &&\
mv -f $depbase.Tpo $depbase.Plo
libtool: compile:  g++ -DHAVE_CONFIG_H -I./.. -pthread -I/usr/include -std=gnu++1y -g -O2 -MT io/async/AsyncServerSocket.lo -MD -MP -MF io/async/.deps/AsyncServerSocket.Tpo -c io/async/AsyncServerSocket.cpp  -fPIC -DPIC -o io/async/.libs/AsyncServerSocket.o
libtool: compile:  g++ -DHAVE_CONFIG_H -I./.. -pthread -I/usr/include -std=gnu++1y -g -O2 -MT io/async/AsyncServerSocket.lo -MD -MP -MF io/async/.deps/AsyncServerSocket.Tpo -c io/async/AsyncServerSocket.cpp -o io/async/AsyncServerSocket.o >/dev/null 2>&1
depbase=`echo io/async/AsyncSignalHandler.lo | sed 's|[^/]*$|.deps/&|;s|\.lo$||'`;\
/bin/bash ./libtool  --tag=CXX   --mode=compile g++ -DHAVE_CONFIG_H   -I./.. -pthread -I/usr/include    -std=gnu++1y -g -O2 -MT io/async/AsyncSignalHandler.lo -MD -MP -MF $depbase.Tpo -c -o io/async/AsyncSignalHandler.lo io/async/AsyncSignalHandler.cpp &&\
mv -f $depbase.Tpo $depbase.Plo
libtool: compile:  g++ -DHAVE_CONFIG_H -I./.. -pthread -I/usr/include -std=gnu++1y -g -O2 -MT io/async/AsyncSignalHandler.lo -MD -MP -MF io/async/.deps/AsyncSignalHandler.Tpo -c io/async/AsyncSignalHandler.cpp  -fPIC -DPIC -o io/async/.libs/AsyncSignalHandler.o
libtool: compile:  g++ -DHAVE_CONFIG_H -I./.. -pthread -I/usr/include -std=gnu++1y -g -O2 -MT io/async/AsyncSignalHandler.lo -MD -MP -MF io/async/.deps/AsyncSignalHandler.Tpo -c io/async/AsyncSignalHandler.cpp -o io/async/AsyncSignalHandler.o >/dev/null 2>&1
depbase=`echo io/async/AsyncSocket.lo | sed 's|[^/]*$|.deps/&|;s|\.lo$||'`;\
/bin/bash ./libtool  --tag=CXX   --mode=compile g++ -DHAVE_CONFIG_H   -I./.. -pthread -I/usr/include    -std=gnu++1y -g -O2 -MT io/async/AsyncSocket.lo -MD -MP -MF $depbase.Tpo -c -o io/async/AsyncSocket.lo io/async/AsyncSocket.cpp &&\
mv -f $depbase.Tpo $depbase.Plo
libtool: compile:  g++ -DHAVE_CONFIG_H -I./.. -pthread -I/usr/include -std=gnu++1y -g -O2 -MT io/async/AsyncSocket.lo -MD -MP -MF io/async/.deps/AsyncSocket.Tpo -c io/async/AsyncSocket.cpp  -fPIC -DPIC -o io/async/.libs/AsyncSocket.o
libtool: compile:  g++ -DHAVE_CONFIG_H -I./.. -pthread -I/usr/include -std=gnu++1y -g -O2 -MT io/async/AsyncSocket.lo -MD -MP -MF io/async/.deps/AsyncSocket.Tpo -c io/async/AsyncSocket.cpp -o io/async/AsyncSocket.o >/dev/null 2>&1
depbase=`echo io/async/AsyncSocketException.lo | sed 's|[^/]*$|.deps/&|;s|\.lo$||'`;\
/bin/bash ./libtool  --tag=CXX   --mode=compile g++ -DHAVE_CONFIG_H   -I./.. -pthread -I/usr/include    -std=gnu++1y -g -O2 -MT io/async/AsyncSocketException.lo -MD -MP -MF $depbase.Tpo -c -o io/async/AsyncSocketException.lo io/async/AsyncSocketException.cpp &&\
mv -f $depbase.Tpo $depbase.Plo
libtool: compile:  g++ -DHAVE_CONFIG_H -I./.. -pthread -I/usr/include -std=gnu++1y -g -O2 -MT io/async/AsyncSocketException.lo -MD -MP -MF io/async/.deps/AsyncSocketException.Tpo -c io/async/AsyncSocketException.cpp  -fPIC -DPIC -o io/async/.libs/AsyncSocketException.o
libtool: compile:  g++ -DHAVE_CONFIG_H -I./.. -pthread -I/usr/include -std=gnu++1y -g -O2 -MT io/async/AsyncSocketException.lo -MD -MP -MF io/async/.deps/AsyncSocketException.Tpo -c io/async/AsyncSocketException.cpp -o io/async/AsyncSocketException.o >/dev/null 2>&1
depbase=`echo io/async/AsyncSSLSocket.lo | sed 's|[^/]*$|.deps/&|;s|\.lo$||'`;\
/bin/bash ./libtool  --tag=CXX   --mode=compile g++ -DHAVE_CONFIG_H   -I./.. -pthread -I/usr/include    -std=gnu++1y -g -O2 -MT io/async/AsyncSSLSocket.lo -MD -MP -MF $depbase.Tpo -c -o io/async/AsyncSSLSocket.lo io/async/AsyncSSLSocket.cpp &&\
mv -f $depbase.Tpo $depbase.Plo
libtool: compile:  g++ -DHAVE_CONFIG_H -I./.. -pthread -I/usr/include -std=gnu++1y -g -O2 -MT io/async/AsyncSSLSocket.lo -MD -MP -MF io/async/.deps/AsyncSSLSocket.Tpo -c io/async/AsyncSSLSocket.cpp  -fPIC -DPIC -o io/async/.libs/AsyncSSLSocket.o
libtool: compile:  g++ -DHAVE_CONFIG_H -I./.. -pthread -I/usr/include -std=gnu++1y -g -O2 -MT io/async/AsyncSSLSocket.lo -MD -MP -MF io/async/.deps/AsyncSSLSocket.Tpo -c io/async/AsyncSSLSocket.cpp -o io/async/AsyncSSLSocket.o >/dev/null 2>&1
depbase=`echo io/async/EventBase.lo | sed 's|[^/]*$|.deps/&|;s|\.lo$||'`;\
/bin/bash ./libtool  --tag=CXX   --mode=compile g++ -DHAVE_CONFIG_H   -I./.. -pthread -I/usr/include    -std=gnu++1y -g -O2 -MT io/async/EventBase.lo -MD -MP -MF $depbase.Tpo -c -o io/async/EventBase.lo io/async/EventBase.cpp &&\
mv -f $depbase.Tpo $depbase.Plo
libtool: compile:  g++ -DHAVE_CONFIG_H -I./.. -pthread -I/usr/include -std=gnu++1y -g -O2 -MT io/async/EventBase.lo -MD -MP -MF io/async/.deps/EventBase.Tpo -c io/async/EventBase.cpp  -fPIC -DPIC -o io/async/.libs/EventBase.o
libtool: compile:  g++ -DHAVE_CONFIG_H -I./.. -pthread -I/usr/include -std=gnu++1y -g -O2 -MT io/async/EventBase.lo -MD -MP -MF io/async/.deps/EventBase.Tpo -c io/async/EventBase.cpp -o io/async/EventBase.o >/dev/null 2>&1
depbase=`echo io/async/EventBaseLocal.lo | sed 's|[^/]*$|.deps/&|;s|\.lo$||'`;\
/bin/bash ./libtool  --tag=CXX   --mode=compile g++ -DHAVE_CONFIG_H   -I./.. -pthread -I/usr/include    -std=gnu++1y -g -O2 -MT io/async/EventBaseLocal.lo -MD -MP -MF $depbase.Tpo -c -o io/async/EventBaseLocal.lo io/async/EventBaseLocal.cpp &&\
mv -f $depbase.Tpo $depbase.Plo
libtool: compile:  g++ -DHAVE_CONFIG_H -I./.. -pthread -I/usr/include -std=gnu++1y -g -O2 -MT io/async/EventBaseLocal.lo -MD -MP -MF io/async/.deps/EventBaseLocal.Tpo -c io/async/EventBaseLocal.cpp  -fPIC -DPIC -o io/async/.libs/EventBaseLocal.o
libtool: compile:  g++ -DHAVE_CONFIG_H -I./.. -pthread -I/usr/include -std=gnu++1y -g -O2 -MT io/async/EventBaseLocal.lo -MD -MP -MF io/async/.deps/EventBaseLocal.Tpo -c io/async/EventBaseLocal.cpp -o io/async/EventBaseLocal.o >/dev/null 2>&1
depbase=`echo io/async/EventBaseManager.lo | sed 's|[^/]*$|.deps/&|;s|\.lo$||'`;\
/bin/bash ./libtool  --tag=CXX   --mode=compile g++ -DHAVE_CONFIG_H   -I./.. -pthread -I/usr/include    -std=gnu++1y -g -O2 -MT io/async/EventBaseManager.lo -MD -MP -MF $depbase.Tpo -c -o io/async/EventBaseManager.lo io/async/EventBaseManager.cpp &&\
mv -f $depbase.Tpo $depbase.Plo
libtool: compile:  g++ -DHAVE_CONFIG_H -I./.. -pthread -I/usr/include -std=gnu++1y -g -O2 -MT io/async/EventBaseManager.lo -MD -MP -MF io/async/.deps/EventBaseManager.Tpo -c io/async/EventBaseManager.cpp  -fPIC -DPIC -o io/async/.libs/EventBaseManager.o
libtool: compile:  g++ -DHAVE_CONFIG_H -I./.. -pthread -I/usr/include -std=gnu++1y -g -O2 -MT io/async/EventBaseManager.lo -MD -MP -MF io/async/.deps/EventBaseManager.Tpo -c io/async/EventBaseManager.cpp -o io/async/EventBaseManager.o >/dev/null 2>&1
depbase=`echo io/async/EventBaseThread.lo | sed 's|[^/]*$|.deps/&|;s|\.lo$||'`;\
/bin/bash ./libtool  --tag=CXX   --mode=compile g++ -DHAVE_CONFIG_H   -I./.. -pthread -I/usr/include    -std=gnu++1y -g -O2 -MT io/async/EventBaseThread.lo -MD -MP -MF $depbase.Tpo -c -o io/async/EventBaseThread.lo io/async/EventBaseThread.cpp &&\
mv -f $depbase.Tpo $depbase.Plo
libtool: compile:  g++ -DHAVE_CONFIG_H -I./.. -pthread -I/usr/include -std=gnu++1y -g -O2 -MT io/async/EventBaseThread.lo -MD -MP -MF io/async/.deps/EventBaseThread.Tpo -c io/async/EventBaseThread.cpp  -fPIC -DPIC -o io/async/.libs/EventBaseThread.o
libtool: compile:  g++ -DHAVE_CONFIG_H -I./.. -pthread -I/usr/include -std=gnu++1y -g -O2 -MT io/async/EventBaseThread.lo -MD -MP -MF io/async/.deps/EventBaseThread.Tpo -c io/async/EventBaseThread.cpp -o io/async/EventBaseThread.o >/dev/null 2>&1
depbase=`echo io/async/EventHandler.lo | sed 's|[^/]*$|.deps/&|;s|\.lo$||'`;\
/bin/bash ./libtool  --tag=CXX   --mode=compile g++ -DHAVE_CONFIG_H   -I./.. -pthread -I/usr/include    -std=gnu++1y -g -O2 -MT io/async/EventHandler.lo -MD -MP -MF $depbase.Tpo -c -o io/async/EventHandler.lo io/async/EventHandler.cpp &&\
mv -f $depbase.Tpo $depbase.Plo
libtool: compile:  g++ -DHAVE_CONFIG_H -I./.. -pthread -I/usr/include -std=gnu++1y -g -O2 -MT io/async/EventHandler.lo -MD -MP -MF io/async/.deps/EventHandler.Tpo -c io/async/EventHandler.cpp  -fPIC -DPIC -o io/async/.libs/EventHandler.o
libtool: compile:  g++ -DHAVE_CONFIG_H -I./.. -pthread -I/usr/include -std=gnu++1y -g -O2 -MT io/async/EventHandler.lo -MD -MP -MF io/async/.deps/EventHandler.Tpo -c io/async/EventHandler.cpp -o io/async/EventHandler.o >/dev/null 2>&1
depbase=`echo io/async/Request.lo | sed 's|[^/]*$|.deps/&|;s|\.lo$||'`;\
/bin/bash ./libtool  --tag=CXX   --mode=compile g++ -DHAVE_CONFIG_H   -I./.. -pthread -I/usr/include    -std=gnu++1y -g -O2 -MT io/async/Request.lo -MD -MP -MF $depbase.Tpo -c -o io/async/Request.lo io/async/Request.cpp &&\
mv -f $depbase.Tpo $depbase.Plo
libtool: compile:  g++ -DHAVE_CONFIG_H -I./.. -pthread -I/usr/include -std=gnu++1y -g -O2 -MT io/async/Request.lo -MD -MP -MF io/async/.deps/Request.Tpo -c io/async/Request.cpp  -fPIC -DPIC -o io/async/.libs/Request.o
libtool: compile:  g++ -DHAVE_CONFIG_H -I./.. -pthread -I/usr/include -std=gnu++1y -g -O2 -MT io/async/Request.lo -MD -MP -MF io/async/.deps/Request.Tpo -c io/async/Request.cpp -o io/async/Request.o >/dev/null 2>&1
depbase=`echo io/async/SSLContext.lo | sed 's|[^/]*$|.deps/&|;s|\.lo$||'`;\
/bin/bash ./libtool  --tag=CXX   --mode=compile g++ -DHAVE_CONFIG_H   -I./.. -pthread -I/usr/include    -std=gnu++1y -g -O2 -MT io/async/SSLContext.lo -MD -MP -MF $depbase.Tpo -c -o io/async/SSLContext.lo io/async/SSLContext.cpp &&\
mv -f $depbase.Tpo $depbase.Plo
libtool: compile:  g++ -DHAVE_CONFIG_H -I./.. -pthread -I/usr/include -std=gnu++1y -g -O2 -MT io/async/SSLContext.lo -MD -MP -MF io/async/.deps/SSLContext.Tpo -c io/async/SSLContext.cpp  -fPIC -DPIC -o io/async/.libs/SSLContext.o
libtool: compile:  g++ -DHAVE_CONFIG_H -I./.. -pthread -I/usr/include -std=gnu++1y -g -O2 -MT io/async/SSLContext.lo -MD -MP -MF io/async/.deps/SSLContext.Tpo -c io/async/SSLContext.cpp -o io/async/SSLContext.o >/dev/null 2>&1
depbase=`echo io/async/SSLOptions.lo | sed 's|[^/]*$|.deps/&|;s|\.lo$||'`;\
/bin/bash ./libtool  --tag=CXX   --mode=compile g++ -DHAVE_CONFIG_H   -I./.. -pthread -I/usr/include    -std=gnu++1y -g -O2 -MT io/async/SSLOptions.lo -MD -MP -MF $depbase.Tpo -c -o io/async/SSLOptions.lo io/async/SSLOptions.cpp &&\
mv -f $depbase.Tpo $depbase.Plo
libtool: compile:  g++ -DHAVE_CONFIG_H -I./.. -pthread -I/usr/include -std=gnu++1y -g -O2 -MT io/async/SSLOptions.lo -MD -MP -MF io/async/.deps/SSLOptions.Tpo -c io/async/SSLOptions.cpp  -fPIC -DPIC -o io/async/.libs/SSLOptions.o
libtool: compile:  g++ -DHAVE_CONFIG_H -I./.. -pthread -I/usr/include -std=gnu++1y -g -O2 -MT io/async/SSLOptions.lo -MD -MP -MF io/async/.deps/SSLOptions.Tpo -c io/async/SSLOptions.cpp -o io/async/SSLOptions.o >/dev/null 2>&1
depbase=`echo io/async/ScopedEventBaseThread.lo | sed 's|[^/]*$|.deps/&|;s|\.lo$||'`;\
/bin/bash ./libtool  --tag=CXX   --mode=compile g++ -DHAVE_CONFIG_H   -I./.. -pthread -I/usr/include    -std=gnu++1y -g -O2 -MT io/async/ScopedEventBaseThread.lo -MD -MP -MF $depbase.Tpo -c -o io/async/ScopedEventBaseThread.lo io/async/ScopedEventBaseThread.cpp &&\
mv -f $depbase.Tpo $depbase.Plo
libtool: compile:  g++ -DHAVE_CONFIG_H -I./.. -pthread -I/usr/include -std=gnu++1y -g -O2 -MT io/async/ScopedEventBaseThread.lo -MD -MP -MF io/async/.deps/ScopedEventBaseThread.Tpo -c io/async/ScopedEventBaseThread.cpp  -fPIC -DPIC -o io/async/.libs/ScopedEventBaseThread.o
libtool: compile:  g++ -DHAVE_CONFIG_H -I./.. -pthread -I/usr/include -std=gnu++1y -g -O2 -MT io/async/ScopedEventBaseThread.lo -MD -MP -MF io/async/.deps/ScopedEventBaseThread.Tpo -c io/async/ScopedEventBaseThread.cpp -o io/async/ScopedEventBaseThread.o >/dev/null 2>&1
depbase=`echo io/async/VirtualEventBase.lo | sed 's|[^/]*$|.deps/&|;s|\.lo$||'`;\
/bin/bash ./libtool  --tag=CXX   --mode=compile g++ -DHAVE_CONFIG_H   -I./.. -pthread -I/usr/include    -std=gnu++1y -g -O2 -MT io/async/VirtualEventBase.lo -MD -MP -MF $depbase.Tpo -c -o io/async/VirtualEventBase.lo io/async/VirtualEventBase.cpp &&\
mv -f $depbase.Tpo $depbase.Plo
libtool: compile:  g++ -DHAVE_CONFIG_H -I./.. -pthread -I/usr/include -std=gnu++1y -g -O2 -MT io/async/VirtualEventBase.lo -MD -MP -MF io/async/.deps/VirtualEventBase.Tpo -c io/async/VirtualEventBase.cpp  -fPIC -DPIC -o io/async/.libs/VirtualEventBase.o
libtool: compile:  g++ -DHAVE_CONFIG_H -I./.. -pthread -I/usr/include -std=gnu++1y -g -O2 -MT io/async/VirtualEventBase.lo -MD -MP -MF io/async/.deps/VirtualEventBase.Tpo -c io/async/VirtualEventBase.cpp -o io/async/VirtualEventBase.o >/dev/null 2>&1
depbase=`echo io/async/HHWheelTimer.lo | sed 's|[^/]*$|.deps/&|;s|\.lo$||'`;\
/bin/bash ./libtool  --tag=CXX   --mode=compile g++ -DHAVE_CONFIG_H   -I./.. -pthread -I/usr/include    -std=gnu++1y -g -O2 -MT io/async/HHWheelTimer.lo -MD -MP -MF $depbase.Tpo -c -o io/async/HHWheelTimer.lo io/async/HHWheelTimer.cpp &&\
mv -f $depbase.Tpo $depbase.Plo
libtool: compile:  g++ -DHAVE_CONFIG_H -I./.. -pthread -I/usr/include -std=gnu++1y -g -O2 -MT io/async/HHWheelTimer.lo -MD -MP -MF io/async/.deps/HHWheelTimer.Tpo -c io/async/HHWheelTimer.cpp  -fPIC -DPIC -o io/async/.libs/HHWheelTimer.o
libtool: compile:  g++ -DHAVE_CONFIG_H -I./.. -pthread -I/usr/include -std=gnu++1y -g -O2 -MT io/async/HHWheelTimer.lo -MD -MP -MF io/async/.deps/HHWheelTimer.Tpo -c io/async/HHWheelTimer.cpp -o io/async/HHWheelTimer.o >/dev/null 2>&1
depbase=`echo io/async/TimeoutManager.lo | sed 's|[^/]*$|.deps/&|;s|\.lo$||'`;\
/bin/bash ./libtool  --tag=CXX   --mode=compile g++ -DHAVE_CONFIG_H   -I./.. -pthread -I/usr/include    -std=gnu++1y -g -O2 -MT io/async/TimeoutManager.lo -MD -MP -MF $depbase.Tpo -c -o io/async/TimeoutManager.lo io/async/TimeoutManager.cpp &&\
mv -f $depbase.Tpo $depbase.Plo
libtool: compile:  g++ -DHAVE_CONFIG_H -I./.. -pthread -I/usr/include -std=gnu++1y -g -O2 -MT io/async/TimeoutManager.lo -MD -MP -MF io/async/.deps/TimeoutManager.Tpo -c io/async/TimeoutManager.cpp  -fPIC -DPIC -o io/async/.libs/TimeoutManager.o
libtool: compile:  g++ -DHAVE_CONFIG_H -I./.. -pthread -I/usr/include -std=gnu++1y -g -O2 -MT io/async/TimeoutManager.lo -MD -MP -MF io/async/.deps/TimeoutManager.Tpo -c io/async/TimeoutManager.cpp -o io/async/TimeoutManager.o >/dev/null 2>&1
depbase=`echo io/async/test/ScopedBoundPort.lo | sed 's|[^/]*$|.deps/&|;s|\.lo$||'`;\
/bin/bash ./libtool  --tag=CXX   --mode=compile g++ -DHAVE_CONFIG_H   -I./.. -pthread -I/usr/include    -std=gnu++1y -g -O2 -MT io/async/test/ScopedBoundPort.lo -MD -MP -MF $depbase.Tpo -c -o io/async/test/ScopedBoundPort.lo io/async/test/ScopedBoundPort.cpp &&\
mv -f $depbase.Tpo $depbase.Plo
libtool: compile:  g++ -DHAVE_CONFIG_H -I./.. -pthread -I/usr/include -std=gnu++1y -g -O2 -MT io/async/test/ScopedBoundPort.lo -MD -MP -MF io/async/test/.deps/ScopedBoundPort.Tpo -c io/async/test/ScopedBoundPort.cpp  -fPIC -DPIC -o io/async/test/.libs/ScopedBoundPort.o
libtool: compile:  g++ -DHAVE_CONFIG_H -I./.. -pthread -I/usr/include -std=gnu++1y -g -O2 -MT io/async/test/ScopedBoundPort.lo -MD -MP -MF io/async/test/.deps/ScopedBoundPort.Tpo -c io/async/test/ScopedBoundPort.cpp -o io/async/test/ScopedBoundPort.o >/dev/null 2>&1
depbase=`echo io/async/test/SocketPair.lo | sed 's|[^/]*$|.deps/&|;s|\.lo$||'`;\
/bin/bash ./libtool  --tag=CXX   --mode=compile g++ -DHAVE_CONFIG_H   -I./.. -pthread -I/usr/include    -std=gnu++1y -g -O2 -MT io/async/test/SocketPair.lo -MD -MP -MF $depbase.Tpo -c -o io/async/test/SocketPair.lo io/async/test/SocketPair.cpp &&\
mv -f $depbase.Tpo $depbase.Plo
libtool: compile:  g++ -DHAVE_CONFIG_H -I./.. -pthread -I/usr/include -std=gnu++1y -g -O2 -MT io/async/test/SocketPair.lo -MD -MP -MF io/async/test/.deps/SocketPair.Tpo -c io/async/test/SocketPair.cpp  -fPIC -DPIC -o io/async/test/.libs/SocketPair.o
libtool: compile:  g++ -DHAVE_CONFIG_H -I./.. -pthread -I/usr/include -std=gnu++1y -g -O2 -MT io/async/test/SocketPair.lo -MD -MP -MF io/async/test/.deps/SocketPair.Tpo -c io/async/test/SocketPair.cpp -o io/async/test/SocketPair.o >/dev/null 2>&1
depbase=`echo io/async/test/TimeUtil.lo | sed 's|[^/]*$|.deps/&|;s|\.lo$||'`;\
/bin/bash ./libtool  --tag=CXX   --mode=compile g++ -DHAVE_CONFIG_H   -I./.. -pthread -I/usr/include    -std=gnu++1y -g -O2 -MT io/async/test/TimeUtil.lo -MD -MP -MF $depbase.Tpo -c -o io/async/test/TimeUtil.lo io/async/test/TimeUtil.cpp &&\
mv -f $depbase.Tpo $depbase.Plo
libtool: compile:  g++ -DHAVE_CONFIG_H -I./.. -pthread -I/usr/include -std=gnu++1y -g -O2 -MT io/async/test/TimeUtil.lo -MD -MP -MF io/async/test/.deps/TimeUtil.Tpo -c io/async/test/TimeUtil.cpp  -fPIC -DPIC -o io/async/test/.libs/TimeUtil.o
libtool: compile:  g++ -DHAVE_CONFIG_H -I./.. -pthread -I/usr/include -std=gnu++1y -g -O2 -MT io/async/test/TimeUtil.lo -MD -MP -MF io/async/test/.deps/TimeUtil.Tpo -c io/async/test/TimeUtil.cpp -o io/async/test/TimeUtil.o >/dev/null 2>&1
depbase=`echo io/async/ssl/OpenSSLUtils.lo | sed 's|[^/]*$|.deps/&|;s|\.lo$||'`;\
/bin/bash ./libtool  --tag=CXX   --mode=compile g++ -DHAVE_CONFIG_H   -I./.. -pthread -I/usr/include    -std=gnu++1y -g -O2 -MT io/async/ssl/OpenSSLUtils.lo -MD -MP -MF $depbase.Tpo -c -o io/async/ssl/OpenSSLUtils.lo io/async/ssl/OpenSSLUtils.cpp &&\
mv -f $depbase.Tpo $depbase.Plo
libtool: compile:  g++ -DHAVE_CONFIG_H -I./.. -pthread -I/usr/include -std=gnu++1y -g -O2 -MT io/async/ssl/OpenSSLUtils.lo -MD -MP -MF io/async/ssl/.deps/OpenSSLUtils.Tpo -c io/async/ssl/OpenSSLUtils.cpp  -fPIC -DPIC -o io/async/ssl/.libs/OpenSSLUtils.o
libtool: compile:  g++ -DHAVE_CONFIG_H -I./.. -pthread -I/usr/include -std=gnu++1y -g -O2 -MT io/async/ssl/OpenSSLUtils.lo -MD -MP -MF io/async/ssl/.deps/OpenSSLUtils.Tpo -c io/async/ssl/OpenSSLUtils.cpp -o io/async/ssl/OpenSSLUtils.o >/dev/null 2>&1
depbase=`echo io/async/ssl/SSLErrors.lo | sed 's|[^/]*$|.deps/&|;s|\.lo$||'`;\
/bin/bash ./libtool  --tag=CXX   --mode=compile g++ -DHAVE_CONFIG_H   -I./.. -pthread -I/usr/include    -std=gnu++1y -g -O2 -MT io/async/ssl/SSLErrors.lo -MD -MP -MF $depbase.Tpo -c -o io/async/ssl/SSLErrors.lo io/async/ssl/SSLErrors.cpp &&\
mv -f $depbase.Tpo $depbase.Plo
libtool: compile:  g++ -DHAVE_CONFIG_H -I./.. -pthread -I/usr/include -std=gnu++1y -g -O2 -MT io/async/ssl/SSLErrors.lo -MD -MP -MF io/async/ssl/.deps/SSLErrors.Tpo -c io/async/ssl/SSLErrors.cpp  -fPIC -DPIC -o io/async/ssl/.libs/SSLErrors.o
libtool: compile:  g++ -DHAVE_CONFIG_H -I./.. -pthread -I/usr/include -std=gnu++1y -g -O2 -MT io/async/ssl/SSLErrors.lo -MD -MP -MF io/async/ssl/.deps/SSLErrors.Tpo -c io/async/ssl/SSLErrors.cpp -o io/async/ssl/SSLErrors.o >/dev/null 2>&1
depbase=`echo json.lo | sed 's|[^/]*$|.deps/&|;s|\.lo$||'`;\
/bin/bash ./libtool  --tag=CXX   --mode=compile g++ -DHAVE_CONFIG_H   -I./.. -pthread -I/usr/include    -std=gnu++1y -g -O2 -MT json.lo -MD -MP -MF $depbase.Tpo -c -o json.lo json.cpp &&\
mv -f $depbase.Tpo $depbase.Plo
libtool: compile:  g++ -DHAVE_CONFIG_H -I./.. -pthread -I/usr/include -std=gnu++1y -g -O2 -MT json.lo -MD -MP -MF .deps/json.Tpo -c json.cpp  -fPIC -DPIC -o .libs/json.o
libtool: compile:  g++ -DHAVE_CONFIG_H -I./.. -pthread -I/usr/include -std=gnu++1y -g -O2 -MT json.lo -MD -MP -MF .deps/json.Tpo -c json.cpp -o json.o >/dev/null 2>&1
depbase=`echo lang/Assume.lo | sed 's|[^/]*$|.deps/&|;s|\.lo$||'`;\
/bin/bash ./libtool  --tag=CXX   --mode=compile g++ -DHAVE_CONFIG_H   -I./.. -pthread -I/usr/include    -std=gnu++1y -g -O2 -MT lang/Assume.lo -MD -MP -MF $depbase.Tpo -c -o lang/Assume.lo lang/Assume.cpp &&\
mv -f $depbase.Tpo $depbase.Plo
libtool: compile:  g++ -DHAVE_CONFIG_H -I./.. -pthread -I/usr/include -std=gnu++1y -g -O2 -MT lang/Assume.lo -MD -MP -MF lang/.deps/Assume.Tpo -c lang/Assume.cpp  -fPIC -DPIC -o lang/.libs/Assume.o
libtool: compile:  g++ -DHAVE_CONFIG_H -I./.. -pthread -I/usr/include -std=gnu++1y -g -O2 -MT lang/Assume.lo -MD -MP -MF lang/.deps/Assume.Tpo -c lang/Assume.cpp -o lang/Assume.o >/dev/null 2>&1
depbase=`echo lang/ColdClass.lo | sed 's|[^/]*$|.deps/&|;s|\.lo$||'`;\
/bin/bash ./libtool  --tag=CXX   --mode=compile g++ -DHAVE_CONFIG_H   -I./.. -pthread -I/usr/include    -std=gnu++1y -g -O2 -MT lang/ColdClass.lo -MD -MP -MF $depbase.Tpo -c -o lang/ColdClass.lo lang/ColdClass.cpp &&\
mv -f $depbase.Tpo $depbase.Plo
libtool: compile:  g++ -DHAVE_CONFIG_H -I./.. -pthread -I/usr/include -std=gnu++1y -g -O2 -MT lang/ColdClass.lo -MD -MP -MF lang/.deps/ColdClass.Tpo -c lang/ColdClass.cpp  -fPIC -DPIC -o lang/.libs/ColdClass.o
libtool: compile:  g++ -DHAVE_CONFIG_H -I./.. -pthread -I/usr/include -std=gnu++1y -g -O2 -MT lang/ColdClass.lo -MD -MP -MF lang/.deps/ColdClass.Tpo -c lang/ColdClass.cpp -o lang/ColdClass.o >/dev/null 2>&1
depbase=`echo lang/SafeAssert.lo | sed 's|[^/]*$|.deps/&|;s|\.lo$||'`;\
/bin/bash ./libtool  --tag=CXX   --mode=compile g++ -DHAVE_CONFIG_H   -I./.. -pthread -I/usr/include    -std=gnu++1y -g -O2 -MT lang/SafeAssert.lo -MD -MP -MF $depbase.Tpo -c -o lang/SafeAssert.lo lang/SafeAssert.cpp &&\
mv -f $depbase.Tpo $depbase.Plo
libtool: compile:  g++ -DHAVE_CONFIG_H -I./.. -pthread -I/usr/include -std=gnu++1y -g -O2 -MT lang/SafeAssert.lo -MD -MP -MF lang/.deps/SafeAssert.Tpo -c lang/SafeAssert.cpp  -fPIC -DPIC -o lang/.libs/SafeAssert.o
libtool: compile:  g++ -DHAVE_CONFIG_H -I./.. -pthread -I/usr/include -std=gnu++1y -g -O2 -MT lang/SafeAssert.lo -MD -MP -MF lang/.deps/SafeAssert.Tpo -c lang/SafeAssert.cpp -o lang/SafeAssert.o >/dev/null 2>&1
depbase=`echo detail/MemoryIdler.lo | sed 's|[^/]*$|.deps/&|;s|\.lo$||'`;\
/bin/bash ./libtool  --tag=CXX   --mode=compile g++ -DHAVE_CONFIG_H   -I./.. -pthread -I/usr/include    -std=gnu++1y -g -O2 -MT detail/MemoryIdler.lo -MD -MP -MF $depbase.Tpo -c -o detail/MemoryIdler.lo detail/MemoryIdler.cpp &&\
mv -f $depbase.Tpo $depbase.Plo
libtool: compile:  g++ -DHAVE_CONFIG_H -I./.. -pthread -I/usr/include -std=gnu++1y -g -O2 -MT detail/MemoryIdler.lo -MD -MP -MF detail/.deps/MemoryIdler.Tpo -c detail/MemoryIdler.cpp  -fPIC -DPIC -o detail/.libs/MemoryIdler.o
libtool: compile:  g++ -DHAVE_CONFIG_H -I./.. -pthread -I/usr/include -std=gnu++1y -g -O2 -MT detail/MemoryIdler.lo -MD -MP -MF detail/.deps/MemoryIdler.Tpo -c detail/MemoryIdler.cpp -o detail/MemoryIdler.o >/dev/null 2>&1
depbase=`echo detail/SocketFastOpen.lo | sed 's|[^/]*$|.deps/&|;s|\.lo$||'`;\
/bin/bash ./libtool  --tag=CXX   --mode=compile g++ -DHAVE_CONFIG_H   -I./.. -pthread -I/usr/include    -std=gnu++1y -g -O2 -MT detail/SocketFastOpen.lo -MD -MP -MF $depbase.Tpo -c -o detail/SocketFastOpen.lo detail/SocketFastOpen.cpp &&\
mv -f $depbase.Tpo $depbase.Plo
libtool: compile:  g++ -DHAVE_CONFIG_H -I./.. -pthread -I/usr/include -std=gnu++1y -g -O2 -MT detail/SocketFastOpen.lo -MD -MP -MF detail/.deps/SocketFastOpen.Tpo -c detail/SocketFastOpen.cpp  -fPIC -DPIC -o detail/.libs/SocketFastOpen.o
libtool: compile:  g++ -DHAVE_CONFIG_H -I./.. -pthread -I/usr/include -std=gnu++1y -g -O2 -MT detail/SocketFastOpen.lo -MD -MP -MF detail/.deps/SocketFastOpen.Tpo -c detail/SocketFastOpen.cpp -o detail/SocketFastOpen.o >/dev/null 2>&1
depbase=`echo MacAddress.lo | sed 's|[^/]*$|.deps/&|;s|\.lo$||'`;\
/bin/bash ./libtool  --tag=CXX   --mode=compile g++ -DHAVE_CONFIG_H   -I./.. -pthread -I/usr/include    -std=gnu++1y -g -O2 -MT MacAddress.lo -MD -MP -MF $depbase.Tpo -c -o MacAddress.lo MacAddress.cpp &&\
mv -f $depbase.Tpo $depbase.Plo
libtool: compile:  g++ -DHAVE_CONFIG_H -I./.. -pthread -I/usr/include -std=gnu++1y -g -O2 -MT MacAddress.lo -MD -MP -MF .deps/MacAddress.Tpo -c MacAddress.cpp  -fPIC -DPIC -o .libs/MacAddress.o
libtool: compile:  g++ -DHAVE_CONFIG_H -I./.. -pthread -I/usr/include -std=gnu++1y -g -O2 -MT MacAddress.lo -MD -MP -MF .deps/MacAddress.Tpo -c MacAddress.cpp -o MacAddress.o >/dev/null 2>&1
depbase=`echo memory/ThreadCachedArena.lo | sed 's|[^/]*$|.deps/&|;s|\.lo$||'`;\
/bin/bash ./libtool  --tag=CXX   --mode=compile g++ -DHAVE_CONFIG_H   -I./.. -pthread -I/usr/include    -std=gnu++1y -g -O2 -MT memory/ThreadCachedArena.lo -MD -MP -MF $depbase.Tpo -c -o memory/ThreadCachedArena.lo memory/ThreadCachedArena.cpp &&\
mv -f $depbase.Tpo $depbase.Plo
libtool: compile:  g++ -DHAVE_CONFIG_H -I./.. -pthread -I/usr/include -std=gnu++1y -g -O2 -MT memory/ThreadCachedArena.lo -MD -MP -MF memory/.deps/ThreadCachedArena.Tpo -c memory/ThreadCachedArena.cpp  -fPIC -DPIC -o memory/.libs/ThreadCachedArena.o
libtool: compile:  g++ -DHAVE_CONFIG_H -I./.. -pthread -I/usr/include -std=gnu++1y -g -O2 -MT memory/ThreadCachedArena.lo -MD -MP -MF memory/.deps/ThreadCachedArena.Tpo -c memory/ThreadCachedArena.cpp -o memory/ThreadCachedArena.o >/dev/null 2>&1
depbase=`echo portability/Dirent.lo | sed 's|[^/]*$|.deps/&|;s|\.lo$||'`;\
/bin/bash ./libtool  --tag=CXX   --mode=compile g++ -DHAVE_CONFIG_H   -I./.. -pthread -I/usr/include    -std=gnu++1y -g -O2 -MT portability/Dirent.lo -MD -MP -MF $depbase.Tpo -c -o portability/Dirent.lo portability/Dirent.cpp &&\
mv -f $depbase.Tpo $depbase.Plo
libtool: compile:  g++ -DHAVE_CONFIG_H -I./.. -pthread -I/usr/include -std=gnu++1y -g -O2 -MT portability/Dirent.lo -MD -MP -MF portability/.deps/Dirent.Tpo -c portability/Dirent.cpp  -fPIC -DPIC -o portability/.libs/Dirent.o
libtool: compile:  g++ -DHAVE_CONFIG_H -I./.. -pthread -I/usr/include -std=gnu++1y -g -O2 -MT portability/Dirent.lo -MD -MP -MF portability/.deps/Dirent.Tpo -c portability/Dirent.cpp -o portability/Dirent.o >/dev/null 2>&1
depbase=`echo portability/Fcntl.lo | sed 's|[^/]*$|.deps/&|;s|\.lo$||'`;\
/bin/bash ./libtool  --tag=CXX   --mode=compile g++ -DHAVE_CONFIG_H   -I./.. -pthread -I/usr/include    -std=gnu++1y -g -O2 -MT portability/Fcntl.lo -MD -MP -MF $depbase.Tpo -c -o portability/Fcntl.lo portability/Fcntl.cpp &&\
mv -f $depbase.Tpo $depbase.Plo
libtool: compile:  g++ -DHAVE_CONFIG_H -I./.. -pthread -I/usr/include -std=gnu++1y -g -O2 -MT portability/Fcntl.lo -MD -MP -MF portability/.deps/Fcntl.Tpo -c portability/Fcntl.cpp  -fPIC -DPIC -o portability/.libs/Fcntl.o
libtool: compile:  g++ -DHAVE_CONFIG_H -I./.. -pthread -I/usr/include -std=gnu++1y -g -O2 -MT portability/Fcntl.lo -MD -MP -MF portability/.deps/Fcntl.Tpo -c portability/Fcntl.cpp -o portability/Fcntl.o >/dev/null 2>&1
depbase=`echo portability/Libgen.lo | sed 's|[^/]*$|.deps/&|;s|\.lo$||'`;\
/bin/bash ./libtool  --tag=CXX   --mode=compile g++ -DHAVE_CONFIG_H   -I./.. -pthread -I/usr/include    -std=gnu++1y -g -O2 -MT portability/Libgen.lo -MD -MP -MF $depbase.Tpo -c -o portability/Libgen.lo portability/Libgen.cpp &&\
mv -f $depbase.Tpo $depbase.Plo
libtool: compile:  g++ -DHAVE_CONFIG_H -I./.. -pthread -I/usr/include -std=gnu++1y -g -O2 -MT portability/Libgen.lo -MD -MP -MF portability/.deps/Libgen.Tpo -c portability/Libgen.cpp  -fPIC -DPIC -o portability/.libs/Libgen.o
libtool: compile:  g++ -DHAVE_CONFIG_H -I./.. -pthread -I/usr/include -std=gnu++1y -g -O2 -MT portability/Libgen.lo -MD -MP -MF portability/.deps/Libgen.Tpo -c portability/Libgen.cpp -o portability/Libgen.o >/dev/null 2>&1
depbase=`echo portability/Malloc.lo | sed 's|[^/]*$|.deps/&|;s|\.lo$||'`;\
/bin/bash ./libtool  --tag=CXX   --mode=compile g++ -DHAVE_CONFIG_H   -I./.. -pthread -I/usr/include    -std=gnu++1y -g -O2 -MT portability/Malloc.lo -MD -MP -MF $depbase.Tpo -c -o portability/Malloc.lo portability/Malloc.cpp &&\
mv -f $depbase.Tpo $depbase.Plo
libtool: compile:  g++ -DHAVE_CONFIG_H -I./.. -pthread -I/usr/include -std=gnu++1y -g -O2 -MT portability/Malloc.lo -MD -MP -MF portability/.deps/Malloc.Tpo -c portability/Malloc.cpp  -fPIC -DPIC -o portability/.libs/Malloc.o
libtool: compile:  g++ -DHAVE_CONFIG_H -I./.. -pthread -I/usr/include -std=gnu++1y -g -O2 -MT portability/Malloc.lo -MD -MP -MF portability/.deps/Malloc.Tpo -c portability/Malloc.cpp -o portability/Malloc.o >/dev/null 2>&1
depbase=`echo portability/Memory.lo | sed 's|[^/]*$|.deps/&|;s|\.lo$||'`;\
/bin/bash ./libtool  --tag=CXX   --mode=compile g++ -DHAVE_CONFIG_H   -I./.. -pthread -I/usr/include    -std=gnu++1y -g -O2 -MT portability/Memory.lo -MD -MP -MF $depbase.Tpo -c -o portability/Memory.lo portability/Memory.cpp &&\
mv -f $depbase.Tpo $depbase.Plo
libtool: compile:  g++ -DHAVE_CONFIG_H -I./.. -pthread -I/usr/include -std=gnu++1y -g -O2 -MT portability/Memory.lo -MD -MP -MF portability/.deps/Memory.Tpo -c portability/Memory.cpp  -fPIC -DPIC -o portability/.libs/Memory.o
libtool: compile:  g++ -DHAVE_CONFIG_H -I./.. -pthread -I/usr/include -std=gnu++1y -g -O2 -MT portability/Memory.lo -MD -MP -MF portability/.deps/Memory.Tpo -c portability/Memory.cpp -o portability/Memory.o >/dev/null 2>&1
depbase=`echo portability/OpenSSL.lo | sed 's|[^/]*$|.deps/&|;s|\.lo$||'`;\
/bin/bash ./libtool  --tag=CXX   --mode=compile g++ -DHAVE_CONFIG_H   -I./.. -pthread -I/usr/include    -std=gnu++1y -g -O2 -MT portability/OpenSSL.lo -MD -MP -MF $depbase.Tpo -c -o portability/OpenSSL.lo portability/OpenSSL.cpp &&\
mv -f $depbase.Tpo $depbase.Plo
libtool: compile:  g++ -DHAVE_CONFIG_H -I./.. -pthread -I/usr/include -std=gnu++1y -g -O2 -MT portability/OpenSSL.lo -MD -MP -MF portability/.deps/OpenSSL.Tpo -c portability/OpenSSL.cpp  -fPIC -DPIC -o portability/.libs/OpenSSL.o
libtool: compile:  g++ -DHAVE_CONFIG_H -I./.. -pthread -I/usr/include -std=gnu++1y -g -O2 -MT portability/OpenSSL.lo -MD -MP -MF portability/.deps/OpenSSL.Tpo -c portability/OpenSSL.cpp -o portability/OpenSSL.o >/dev/null 2>&1
depbase=`echo portability/PThread.lo | sed 's|[^/]*$|.deps/&|;s|\.lo$||'`;\
/bin/bash ./libtool  --tag=CXX   --mode=compile g++ -DHAVE_CONFIG_H   -I./.. -pthread -I/usr/include    -std=gnu++1y -g -O2 -MT portability/PThread.lo -MD -MP -MF $depbase.Tpo -c -o portability/PThread.lo portability/PThread.cpp &&\
mv -f $depbase.Tpo $depbase.Plo
libtool: compile:  g++ -DHAVE_CONFIG_H -I./.. -pthread -I/usr/include -std=gnu++1y -g -O2 -MT portability/PThread.lo -MD -MP -MF portability/.deps/PThread.Tpo -c portability/PThread.cpp  -fPIC -DPIC -o portability/.libs/PThread.o
libtool: compile:  g++ -DHAVE_CONFIG_H -I./.. -pthread -I/usr/include -std=gnu++1y -g -O2 -MT portability/PThread.lo -MD -MP -MF portability/.deps/PThread.Tpo -c portability/PThread.cpp -o portability/PThread.o >/dev/null 2>&1
depbase=`echo portability/Sockets.lo | sed 's|[^/]*$|.deps/&|;s|\.lo$||'`;\
/bin/bash ./libtool  --tag=CXX   --mode=compile g++ -DHAVE_CONFIG_H   -I./.. -pthread -I/usr/include    -std=gnu++1y -g -O2 -MT portability/Sockets.lo -MD -MP -MF $depbase.Tpo -c -o portability/Sockets.lo portability/Sockets.cpp &&\
mv -f $depbase.Tpo $depbase.Plo
libtool: compile:  g++ -DHAVE_CONFIG_H -I./.. -pthread -I/usr/include -std=gnu++1y -g -O2 -MT portability/Sockets.lo -MD -MP -MF portability/.deps/Sockets.Tpo -c portability/Sockets.cpp  -fPIC -DPIC -o portability/.libs/Sockets.o
libtool: compile:  g++ -DHAVE_CONFIG_H -I./.. -pthread -I/usr/include -std=gnu++1y -g -O2 -MT portability/Sockets.lo -MD -MP -MF portability/.deps/Sockets.Tpo -c portability/Sockets.cpp -o portability/Sockets.o >/dev/null 2>&1
depbase=`echo portability/Stdio.lo | sed 's|[^/]*$|.deps/&|;s|\.lo$||'`;\
/bin/bash ./libtool  --tag=CXX   --mode=compile g++ -DHAVE_CONFIG_H   -I./.. -pthread -I/usr/include    -std=gnu++1y -g -O2 -MT portability/Stdio.lo -MD -MP -MF $depbase.Tpo -c -o portability/Stdio.lo portability/Stdio.cpp &&\
mv -f $depbase.Tpo $depbase.Plo
libtool: compile:  g++ -DHAVE_CONFIG_H -I./.. -pthread -I/usr/include -std=gnu++1y -g -O2 -MT portability/Stdio.lo -MD -MP -MF portability/.deps/Stdio.Tpo -c portability/Stdio.cpp  -fPIC -DPIC -o portability/.libs/Stdio.o
libtool: compile:  g++ -DHAVE_CONFIG_H -I./.. -pthread -I/usr/include -std=gnu++1y -g -O2 -MT portability/Stdio.lo -MD -MP -MF portability/.deps/Stdio.Tpo -c portability/Stdio.cpp -o portability/Stdio.o >/dev/null 2>&1
depbase=`echo portability/Stdlib.lo | sed 's|[^/]*$|.deps/&|;s|\.lo$||'`;\
/bin/bash ./libtool  --tag=CXX   --mode=compile g++ -DHAVE_CONFIG_H   -I./.. -pthread -I/usr/include    -std=gnu++1y -g -O2 -MT portability/Stdlib.lo -MD -MP -MF $depbase.Tpo -c -o portability/Stdlib.lo portability/Stdlib.cpp &&\
mv -f $depbase.Tpo $depbase.Plo
libtool: compile:  g++ -DHAVE_CONFIG_H -I./.. -pthread -I/usr/include -std=gnu++1y -g -O2 -MT portability/Stdlib.lo -MD -MP -MF portability/.deps/Stdlib.Tpo -c portability/Stdlib.cpp  -fPIC -DPIC -o portability/.libs/Stdlib.o
libtool: compile:  g++ -DHAVE_CONFIG_H -I./.. -pthread -I/usr/include -std=gnu++1y -g -O2 -MT portability/Stdlib.lo -MD -MP -MF portability/.deps/Stdlib.Tpo -c portability/Stdlib.cpp -o portability/Stdlib.o >/dev/null 2>&1
depbase=`echo portability/String.lo | sed 's|[^/]*$|.deps/&|;s|\.lo$||'`;\
/bin/bash ./libtool  --tag=CXX   --mode=compile g++ -DHAVE_CONFIG_H   -I./.. -pthread -I/usr/include    -std=gnu++1y -g -O2 -MT portability/String.lo -MD -MP -MF $depbase.Tpo -c -o portability/String.lo portability/String.cpp &&\
mv -f $depbase.Tpo $depbase.Plo
libtool: compile:  g++ -DHAVE_CONFIG_H -I./.. -pthread -I/usr/include -std=gnu++1y -g -O2 -MT portability/String.lo -MD -MP -MF portability/.deps/String.Tpo -c portability/String.cpp  -fPIC -DPIC -o portability/.libs/String.o
libtool: compile:  g++ -DHAVE_CONFIG_H -I./.. -pthread -I/usr/include -std=gnu++1y -g -O2 -MT portability/String.lo -MD -MP -MF portability/.deps/String.Tpo -c portability/String.cpp -o portability/String.o >/dev/null 2>&1
depbase=`echo portability/SysFile.lo | sed 's|[^/]*$|.deps/&|;s|\.lo$||'`;\
/bin/bash ./libtool  --tag=CXX   --mode=compile g++ -DHAVE_CONFIG_H   -I./.. -pthread -I/usr/include    -std=gnu++1y -g -O2 -MT portability/SysFile.lo -MD -MP -MF $depbase.Tpo -c -o portability/SysFile.lo portability/SysFile.cpp &&\
mv -f $depbase.Tpo $depbase.Plo
libtool: compile:  g++ -DHAVE_CONFIG_H -I./.. -pthread -I/usr/include -std=gnu++1y -g -O2 -MT portability/SysFile.lo -MD -MP -MF portability/.deps/SysFile.Tpo -c portability/SysFile.cpp  -fPIC -DPIC -o portability/.libs/SysFile.o
libtool: compile:  g++ -DHAVE_CONFIG_H -I./.. -pthread -I/usr/include -std=gnu++1y -g -O2 -MT portability/SysFile.lo -MD -MP -MF portability/.deps/SysFile.Tpo -c portability/SysFile.cpp -o portability/SysFile.o >/dev/null 2>&1
depbase=`echo portability/SysMembarrier.lo | sed 's|[^/]*$|.deps/&|;s|\.lo$||'`;\
/bin/bash ./libtool  --tag=CXX   --mode=compile g++ -DHAVE_CONFIG_H   -I./.. -pthread -I/usr/include    -std=gnu++1y -g -O2 -MT portability/SysMembarrier.lo -MD -MP -MF $depbase.Tpo -c -o portability/SysMembarrier.lo portability/SysMembarrier.cpp &&\
mv -f $depbase.Tpo $depbase.Plo
libtool: compile:  g++ -DHAVE_CONFIG_H -I./.. -pthread -I/usr/include -std=gnu++1y -g -O2 -MT portability/SysMembarrier.lo -MD -MP -MF portability/.deps/SysMembarrier.Tpo -c portability/SysMembarrier.cpp  -fPIC -DPIC -o portability/.libs/SysMembarrier.o
libtool: compile:  g++ -DHAVE_CONFIG_H -I./.. -pthread -I/usr/include -std=gnu++1y -g -O2 -MT portability/SysMembarrier.lo -MD -MP -MF portability/.deps/SysMembarrier.Tpo -c portability/SysMembarrier.cpp -o portability/SysMembarrier.o >/dev/null 2>&1
depbase=`echo portability/SysMman.lo | sed 's|[^/]*$|.deps/&|;s|\.lo$||'`;\
/bin/bash ./libtool  --tag=CXX   --mode=compile g++ -DHAVE_CONFIG_H   -I./.. -pthread -I/usr/include    -std=gnu++1y -g -O2 -MT portability/SysMman.lo -MD -MP -MF $depbase.Tpo -c -o portability/SysMman.lo portability/SysMman.cpp &&\
mv -f $depbase.Tpo $depbase.Plo
libtool: compile:  g++ -DHAVE_CONFIG_H -I./.. -pthread -I/usr/include -std=gnu++1y -g -O2 -MT portability/SysMman.lo -MD -MP -MF portability/.deps/SysMman.Tpo -c portability/SysMman.cpp  -fPIC -DPIC -o portability/.libs/SysMman.o
libtool: compile:  g++ -DHAVE_CONFIG_H -I./.. -pthread -I/usr/include -std=gnu++1y -g -O2 -MT portability/SysMman.lo -MD -MP -MF portability/.deps/SysMman.Tpo -c portability/SysMman.cpp -o portability/SysMman.o >/dev/null 2>&1
depbase=`echo portability/SysResource.lo | sed 's|[^/]*$|.deps/&|;s|\.lo$||'`;\
/bin/bash ./libtool  --tag=CXX   --mode=compile g++ -DHAVE_CONFIG_H   -I./.. -pthread -I/usr/include    -std=gnu++1y -g -O2 -MT portability/SysResource.lo -MD -MP -MF $depbase.Tpo -c -o portability/SysResource.lo portability/SysResource.cpp &&\
mv -f $depbase.Tpo $depbase.Plo
libtool: compile:  g++ -DHAVE_CONFIG_H -I./.. -pthread -I/usr/include -std=gnu++1y -g -O2 -MT portability/SysResource.lo -MD -MP -MF portability/.deps/SysResource.Tpo -c portability/SysResource.cpp  -fPIC -DPIC -o portability/.libs/SysResource.o
libtool: compile:  g++ -DHAVE_CONFIG_H -I./.. -pthread -I/usr/include -std=gnu++1y -g -O2 -MT portability/SysResource.lo -MD -MP -MF portability/.deps/SysResource.Tpo -c portability/SysResource.cpp -o portability/SysResource.o >/dev/null 2>&1
depbase=`echo portability/SysStat.lo | sed 's|[^/]*$|.deps/&|;s|\.lo$||'`;\
/bin/bash ./libtool  --tag=CXX   --mode=compile g++ -DHAVE_CONFIG_H   -I./.. -pthread -I/usr/include    -std=gnu++1y -g -O2 -MT portability/SysStat.lo -MD -MP -MF $depbase.Tpo -c -o portability/SysStat.lo portability/SysStat.cpp &&\
mv -f $depbase.Tpo $depbase.Plo
libtool: compile:  g++ -DHAVE_CONFIG_H -I./.. -pthread -I/usr/include -std=gnu++1y -g -O2 -MT portability/SysStat.lo -MD -MP -MF portability/.deps/SysStat.Tpo -c portability/SysStat.cpp  -fPIC -DPIC -o portability/.libs/SysStat.o
libtool: compile:  g++ -DHAVE_CONFIG_H -I./.. -pthread -I/usr/include -std=gnu++1y -g -O2 -MT portability/SysStat.lo -MD -MP -MF portability/.deps/SysStat.Tpo -c portability/SysStat.cpp -o portability/SysStat.o >/dev/null 2>&1
depbase=`echo portability/SysTime.lo | sed 's|[^/]*$|.deps/&|;s|\.lo$||'`;\
/bin/bash ./libtool  --tag=CXX   --mode=compile g++ -DHAVE_CONFIG_H   -I./.. -pthread -I/usr/include    -std=gnu++1y -g -O2 -MT portability/SysTime.lo -MD -MP -MF $depbase.Tpo -c -o portability/SysTime.lo portability/SysTime.cpp &&\
mv -f $depbase.Tpo $depbase.Plo
libtool: compile:  g++ -DHAVE_CONFIG_H -I./.. -pthread -I/usr/include -std=gnu++1y -g -O2 -MT portability/SysTime.lo -MD -MP -MF portability/.deps/SysTime.Tpo -c portability/SysTime.cpp  -fPIC -DPIC -o portability/.libs/SysTime.o
libtool: compile:  g++ -DHAVE_CONFIG_H -I./.. -pthread -I/usr/include -std=gnu++1y -g -O2 -MT portability/SysTime.lo -MD -MP -MF portability/.deps/SysTime.Tpo -c portability/SysTime.cpp -o portability/SysTime.o >/dev/null 2>&1
depbase=`echo portability/SysUio.lo | sed 's|[^/]*$|.deps/&|;s|\.lo$||'`;\
/bin/bash ./libtool  --tag=CXX   --mode=compile g++ -DHAVE_CONFIG_H   -I./.. -pthread -I/usr/include    -std=gnu++1y -g -O2 -MT portability/SysUio.lo -MD -MP -MF $depbase.Tpo -c -o portability/SysUio.lo portability/SysUio.cpp &&\
mv -f $depbase.Tpo $depbase.Plo
libtool: compile:  g++ -DHAVE_CONFIG_H -I./.. -pthread -I/usr/include -std=gnu++1y -g -O2 -MT portability/SysUio.lo -MD -MP -MF portability/.deps/SysUio.Tpo -c portability/SysUio.cpp  -fPIC -DPIC -o portability/.libs/SysUio.o
libtool: compile:  g++ -DHAVE_CONFIG_H -I./.. -pthread -I/usr/include -std=gnu++1y -g -O2 -MT portability/SysUio.lo -MD -MP -MF portability/.deps/SysUio.Tpo -c portability/SysUio.cpp -o portability/SysUio.o >/dev/null 2>&1
depbase=`echo portability/Time.lo | sed 's|[^/]*$|.deps/&|;s|\.lo$||'`;\
/bin/bash ./libtool  --tag=CXX   --mode=compile g++ -DHAVE_CONFIG_H   -I./.. -pthread -I/usr/include    -std=gnu++1y -g -O2 -MT portability/Time.lo -MD -MP -MF $depbase.Tpo -c -o portability/Time.lo portability/Time.cpp &&\
mv -f $depbase.Tpo $depbase.Plo
libtool: compile:  g++ -DHAVE_CONFIG_H -I./.. -pthread -I/usr/include -std=gnu++1y -g -O2 -MT portability/Time.lo -MD -MP -MF portability/.deps/Time.Tpo -c portability/Time.cpp  -fPIC -DPIC -o portability/.libs/Time.o
libtool: compile:  g++ -DHAVE_CONFIG_H -I./.. -pthread -I/usr/include -std=gnu++1y -g -O2 -MT portability/Time.lo -MD -MP -MF portability/.deps/Time.Tpo -c portability/Time.cpp -o portability/Time.o >/dev/null 2>&1
depbase=`echo portability/Unistd.lo | sed 's|[^/]*$|.deps/&|;s|\.lo$||'`;\
/bin/bash ./libtool  --tag=CXX   --mode=compile g++ -DHAVE_CONFIG_H   -I./.. -pthread -I/usr/include    -std=gnu++1y -g -O2 -MT portability/Unistd.lo -MD -MP -MF $depbase.Tpo -c -o portability/Unistd.lo portability/Unistd.cpp &&\
mv -f $depbase.Tpo $depbase.Plo
libtool: compile:  g++ -DHAVE_CONFIG_H -I./.. -pthread -I/usr/include -std=gnu++1y -g -O2 -MT portability/Unistd.lo -MD -MP -MF portability/.deps/Unistd.Tpo -c portability/Unistd.cpp  -fPIC -DPIC -o portability/.libs/Unistd.o
libtool: compile:  g++ -DHAVE_CONFIG_H -I./.. -pthread -I/usr/include -std=gnu++1y -g -O2 -MT portability/Unistd.lo -MD -MP -MF portability/.deps/Unistd.Tpo -c portability/Unistd.cpp -o portability/Unistd.o >/dev/null 2>&1
depbase=`echo Random.lo | sed 's|[^/]*$|.deps/&|;s|\.lo$||'`;\
/bin/bash ./libtool  --tag=CXX   --mode=compile g++ -DHAVE_CONFIG_H   -I./.. -pthread -I/usr/include    -std=gnu++1y -g -O2 -MT Random.lo -MD -MP -MF $depbase.Tpo -c -o Random.lo Random.cpp &&\
mv -f $depbase.Tpo $depbase.Plo
libtool: compile:  g++ -DHAVE_CONFIG_H -I./.. -pthread -I/usr/include -std=gnu++1y -g -O2 -MT Random.lo -MD -MP -MF .deps/Random.Tpo -c Random.cpp  -fPIC -DPIC -o .libs/Random.o
libtool: compile:  g++ -DHAVE_CONFIG_H -I./.. -pthread -I/usr/include -std=gnu++1y -g -O2 -MT Random.lo -MD -MP -MF .deps/Random.Tpo -c Random.cpp -o Random.o >/dev/null 2>&1
depbase=`echo ScopeGuard.lo | sed 's|[^/]*$|.deps/&|;s|\.lo$||'`;\
/bin/bash ./libtool  --tag=CXX   --mode=compile g++ -DHAVE_CONFIG_H   -I./.. -pthread -I/usr/include    -std=gnu++1y -g -O2 -MT ScopeGuard.lo -MD -MP -MF $depbase.Tpo -c -o ScopeGuard.lo ScopeGuard.cpp &&\
mv -f $depbase.Tpo $depbase.Plo
libtool: compile:  g++ -DHAVE_CONFIG_H -I./.. -pthread -I/usr/include -std=gnu++1y -g -O2 -MT ScopeGuard.lo -MD -MP -MF .deps/ScopeGuard.Tpo -c ScopeGuard.cpp  -fPIC -DPIC -o .libs/ScopeGuard.o
libtool: compile:  g++ -DHAVE_CONFIG_H -I./.. -pthread -I/usr/include -std=gnu++1y -g -O2 -MT ScopeGuard.lo -MD -MP -MF .deps/ScopeGuard.Tpo -c ScopeGuard.cpp -o ScopeGuard.o >/dev/null 2>&1
depbase=`echo SharedMutex.lo | sed 's|[^/]*$|.deps/&|;s|\.lo$||'`;\
/bin/bash ./libtool  --tag=CXX   --mode=compile g++ -DHAVE_CONFIG_H   -I./.. -pthread -I/usr/include    -std=gnu++1y -g -O2 -MT SharedMutex.lo -MD -MP -MF $depbase.Tpo -c -o SharedMutex.lo SharedMutex.cpp &&\
mv -f $depbase.Tpo $depbase.Plo
libtool: compile:  g++ -DHAVE_CONFIG_H -I./.. -pthread -I/usr/include -std=gnu++1y -g -O2 -MT SharedMutex.lo -MD -MP -MF .deps/SharedMutex.Tpo -c SharedMutex.cpp  -fPIC -DPIC -o .libs/SharedMutex.o
libtool: compile:  g++ -DHAVE_CONFIG_H -I./.. -pthread -I/usr/include -std=gnu++1y -g -O2 -MT SharedMutex.lo -MD -MP -MF .deps/SharedMutex.Tpo -c SharedMutex.cpp -o SharedMutex.o >/dev/null 2>&1
depbase=`echo MicroLock.lo | sed 's|[^/]*$|.deps/&|;s|\.lo$||'`;\
/bin/bash ./libtool  --tag=CXX   --mode=compile g++ -DHAVE_CONFIG_H   -I./.. -pthread -I/usr/include    -std=gnu++1y -g -O2 -MT MicroLock.lo -MD -MP -MF $depbase.Tpo -c -o MicroLock.lo MicroLock.cpp &&\
mv -f $depbase.Tpo $depbase.Plo
libtool: compile:  g++ -DHAVE_CONFIG_H -I./.. -pthread -I/usr/include -std=gnu++1y -g -O2 -MT MicroLock.lo -MD -MP -MF .deps/MicroLock.Tpo -c MicroLock.cpp  -fPIC -DPIC -o .libs/MicroLock.o
libtool: compile:  g++ -DHAVE_CONFIG_H -I./.. -pthread -I/usr/include -std=gnu++1y -g -O2 -MT MicroLock.lo -MD -MP -MF .deps/MicroLock.Tpo -c MicroLock.cpp -o MicroLock.o >/dev/null 2>&1
depbase=`echo Optional.lo | sed 's|[^/]*$|.deps/&|;s|\.lo$||'`;\
/bin/bash ./libtool  --tag=CXX   --mode=compile g++ -DHAVE_CONFIG_H   -I./.. -pthread -I/usr/include    -std=gnu++1y -g -O2 -MT Optional.lo -MD -MP -MF $depbase.Tpo -c -o Optional.lo Optional.cpp &&\
mv -f $depbase.Tpo $depbase.Plo
libtool: compile:  g++ -DHAVE_CONFIG_H -I./.. -pthread -I/usr/include -std=gnu++1y -g -O2 -MT Optional.lo -MD -MP -MF .deps/Optional.Tpo -c Optional.cpp  -fPIC -DPIC -o .libs/Optional.o
libtool: compile:  g++ -DHAVE_CONFIG_H -I./.. -pthread -I/usr/include -std=gnu++1y -g -O2 -MT Optional.lo -MD -MP -MF .deps/Optional.Tpo -c Optional.cpp -o Optional.o >/dev/null 2>&1
depbase=`echo Singleton.lo | sed 's|[^/]*$|.deps/&|;s|\.lo$||'`;\
/bin/bash ./libtool  --tag=CXX   --mode=compile g++ -DHAVE_CONFIG_H   -I./.. -pthread -I/usr/include    -std=gnu++1y -g -O2 -MT Singleton.lo -MD -MP -MF $depbase.Tpo -c -o Singleton.lo Singleton.cpp &&\
mv -f $depbase.Tpo $depbase.Plo
libtool: compile:  g++ -DHAVE_CONFIG_H -I./.. -pthread -I/usr/include -std=gnu++1y -g -O2 -MT Singleton.lo -MD -MP -MF .deps/Singleton.Tpo -c Singleton.cpp  -fPIC -DPIC -o .libs/Singleton.o
libtool: compile:  g++ -DHAVE_CONFIG_H -I./.. -pthread -I/usr/include -std=gnu++1y -g -O2 -MT Singleton.lo -MD -MP -MF .deps/Singleton.Tpo -c Singleton.cpp -o Singleton.o >/dev/null 2>&1
depbase=`echo SocketAddress.lo | sed 's|[^/]*$|.deps/&|;s|\.lo$||'`;\
/bin/bash ./libtool  --tag=CXX   --mode=compile g++ -DHAVE_CONFIG_H   -I./.. -pthread -I/usr/include    -std=gnu++1y -g -O2 -MT SocketAddress.lo -MD -MP -MF $depbase.Tpo -c -o SocketAddress.lo SocketAddress.cpp &&\
mv -f $depbase.Tpo $depbase.Plo
libtool: compile:  g++ -DHAVE_CONFIG_H -I./.. -pthread -I/usr/include -std=gnu++1y -g -O2 -MT SocketAddress.lo -MD -MP -MF .deps/SocketAddress.Tpo -c SocketAddress.cpp  -fPIC -DPIC -o .libs/SocketAddress.o
libtool: compile:  g++ -DHAVE_CONFIG_H -I./.. -pthread -I/usr/include -std=gnu++1y -g -O2 -MT SocketAddress.lo -MD -MP -MF .deps/SocketAddress.Tpo -c SocketAddress.cpp -o SocketAddress.o >/dev/null 2>&1
depbase=`echo ssl/Init.lo | sed 's|[^/]*$|.deps/&|;s|\.lo$||'`;\
/bin/bash ./libtool  --tag=CXX   --mode=compile g++ -DHAVE_CONFIG_H   -I./.. -pthread -I/usr/include    -std=gnu++1y -g -O2 -MT ssl/Init.lo -MD -MP -MF $depbase.Tpo -c -o ssl/Init.lo ssl/Init.cpp &&\
mv -f $depbase.Tpo $depbase.Plo
libtool: compile:  g++ -DHAVE_CONFIG_H -I./.. -pthread -I/usr/include -std=gnu++1y -g -O2 -MT ssl/Init.lo -MD -MP -MF ssl/.deps/Init.Tpo -c ssl/Init.cpp  -fPIC -DPIC -o ssl/.libs/Init.o
libtool: compile:  g++ -DHAVE_CONFIG_H -I./.. -pthread -I/usr/include -std=gnu++1y -g -O2 -MT ssl/Init.lo -MD -MP -MF ssl/.deps/Init.Tpo -c ssl/Init.cpp -o ssl/Init.o >/dev/null 2>&1
depbase=`echo ssl/OpenSSLCertUtils.lo | sed 's|[^/]*$|.deps/&|;s|\.lo$||'`;\
/bin/bash ./libtool  --tag=CXX   --mode=compile g++ -DHAVE_CONFIG_H   -I./.. -pthread -I/usr/include    -std=gnu++1y -g -O2 -MT ssl/OpenSSLCertUtils.lo -MD -MP -MF $depbase.Tpo -c -o ssl/OpenSSLCertUtils.lo ssl/OpenSSLCertUtils.cpp &&\
mv -f $depbase.Tpo $depbase.Plo
libtool: compile:  g++ -DHAVE_CONFIG_H -I./.. -pthread -I/usr/include -std=gnu++1y -g -O2 -MT ssl/OpenSSLCertUtils.lo -MD -MP -MF ssl/.deps/OpenSSLCertUtils.Tpo -c ssl/OpenSSLCertUtils.cpp  -fPIC -DPIC -o ssl/.libs/OpenSSLCertUtils.o
libtool: compile:  g++ -DHAVE_CONFIG_H -I./.. -pthread -I/usr/include -std=gnu++1y -g -O2 -MT ssl/OpenSSLCertUtils.lo -MD -MP -MF ssl/.deps/OpenSSLCertUtils.Tpo -c ssl/OpenSSLCertUtils.cpp -o ssl/OpenSSLCertUtils.o >/dev/null 2>&1
depbase=`echo ssl/OpenSSLHash.lo | sed 's|[^/]*$|.deps/&|;s|\.lo$||'`;\
/bin/bash ./libtool  --tag=CXX   --mode=compile g++ -DHAVE_CONFIG_H   -I./.. -pthread -I/usr/include    -std=gnu++1y -g -O2 -MT ssl/OpenSSLHash.lo -MD -MP -MF $depbase.Tpo -c -o ssl/OpenSSLHash.lo ssl/OpenSSLHash.cpp &&\
mv -f $depbase.Tpo $depbase.Plo
libtool: compile:  g++ -DHAVE_CONFIG_H -I./.. -pthread -I/usr/include -std=gnu++1y -g -O2 -MT ssl/OpenSSLHash.lo -MD -MP -MF ssl/.deps/OpenSSLHash.Tpo -c ssl/OpenSSLHash.cpp  -fPIC -DPIC -o ssl/.libs/OpenSSLHash.o
libtool: compile:  g++ -DHAVE_CONFIG_H -I./.. -pthread -I/usr/include -std=gnu++1y -g -O2 -MT ssl/OpenSSLHash.lo -MD -MP -MF ssl/.deps/OpenSSLHash.Tpo -c ssl/OpenSSLHash.cpp -o ssl/OpenSSLHash.o >/dev/null 2>&1
depbase=`echo ssl/detail/OpenSSLThreading.lo | sed 's|[^/]*$|.deps/&|;s|\.lo$||'`;\
/bin/bash ./libtool  --tag=CXX   --mode=compile g++ -DHAVE_CONFIG_H   -I./.. -pthread -I/usr/include    -std=gnu++1y -g -O2 -MT ssl/detail/OpenSSLThreading.lo -MD -MP -MF $depbase.Tpo -c -o ssl/detail/OpenSSLThreading.lo ssl/detail/OpenSSLThreading.cpp &&\
mv -f $depbase.Tpo $depbase.Plo
libtool: compile:  g++ -DHAVE_CONFIG_H -I./.. -pthread -I/usr/include -std=gnu++1y -g -O2 -MT ssl/detail/OpenSSLThreading.lo -MD -MP -MF ssl/detail/.deps/OpenSSLThreading.Tpo -c ssl/detail/OpenSSLThreading.cpp  -fPIC -DPIC -o ssl/detail/.libs/OpenSSLThreading.o
libtool: compile:  g++ -DHAVE_CONFIG_H -I./.. -pthread -I/usr/include -std=gnu++1y -g -O2 -MT ssl/detail/OpenSSLThreading.lo -MD -MP -MF ssl/detail/.deps/OpenSSLThreading.Tpo -c ssl/detail/OpenSSLThreading.cpp -o ssl/detail/OpenSSLThreading.o >/dev/null 2>&1
depbase=`echo ssl/detail/SSLSessionImpl.lo | sed 's|[^/]*$|.deps/&|;s|\.lo$||'`;\
/bin/bash ./libtool  --tag=CXX   --mode=compile g++ -DHAVE_CONFIG_H   -I./.. -pthread -I/usr/include    -std=gnu++1y -g -O2 -MT ssl/detail/SSLSessionImpl.lo -MD -MP -MF $depbase.Tpo -c -o ssl/detail/SSLSessionImpl.lo ssl/detail/SSLSessionImpl.cpp &&\
mv -f $depbase.Tpo $depbase.Plo
libtool: compile:  g++ -DHAVE_CONFIG_H -I./.. -pthread -I/usr/include -std=gnu++1y -g -O2 -MT ssl/detail/SSLSessionImpl.lo -MD -MP -MF ssl/detail/.deps/SSLSessionImpl.Tpo -c ssl/detail/SSLSessionImpl.cpp  -fPIC -DPIC -o ssl/detail/.libs/SSLSessionImpl.o
libtool: compile:  g++ -DHAVE_CONFIG_H -I./.. -pthread -I/usr/include -std=gnu++1y -g -O2 -MT ssl/detail/SSLSessionImpl.lo -MD -MP -MF ssl/detail/.deps/SSLSessionImpl.Tpo -c ssl/detail/SSLSessionImpl.cpp -o ssl/detail/SSLSessionImpl.o >/dev/null 2>&1
depbase=`echo stats/BucketedTimeSeries.lo | sed 's|[^/]*$|.deps/&|;s|\.lo$||'`;\
/bin/bash ./libtool  --tag=CXX   --mode=compile g++ -DHAVE_CONFIG_H   -I./.. -pthread -I/usr/include    -std=gnu++1y -g -O2 -MT stats/BucketedTimeSeries.lo -MD -MP -MF $depbase.Tpo -c -o stats/BucketedTimeSeries.lo stats/BucketedTimeSeries.cpp &&\
mv -f $depbase.Tpo $depbase.Plo
libtool: compile:  g++ -DHAVE_CONFIG_H -I./.. -pthread -I/usr/include -std=gnu++1y -g -O2 -MT stats/BucketedTimeSeries.lo -MD -MP -MF stats/.deps/BucketedTimeSeries.Tpo -c stats/BucketedTimeSeries.cpp  -fPIC -DPIC -o stats/.libs/BucketedTimeSeries.o
libtool: compile:  g++ -DHAVE_CONFIG_H -I./.. -pthread -I/usr/include -std=gnu++1y -g -O2 -MT stats/BucketedTimeSeries.lo -MD -MP -MF stats/.deps/BucketedTimeSeries.Tpo -c stats/BucketedTimeSeries.cpp -o stats/BucketedTimeSeries.o >/dev/null 2>&1
depbase=`echo stats/Histogram.lo | sed 's|[^/]*$|.deps/&|;s|\.lo$||'`;\
/bin/bash ./libtool  --tag=CXX   --mode=compile g++ -DHAVE_CONFIG_H   -I./.. -pthread -I/usr/include    -std=gnu++1y -g -O2 -MT stats/Histogram.lo -MD -MP -MF $depbase.Tpo -c -o stats/Histogram.lo stats/Histogram.cpp &&\
mv -f $depbase.Tpo $depbase.Plo
libtool: compile:  g++ -DHAVE_CONFIG_H -I./.. -pthread -I/usr/include -std=gnu++1y -g -O2 -MT stats/Histogram.lo -MD -MP -MF stats/.deps/Histogram.Tpo -c stats/Histogram.cpp  -fPIC -DPIC -o stats/.libs/Histogram.o
libtool: compile:  g++ -DHAVE_CONFIG_H -I./.. -pthread -I/usr/include -std=gnu++1y -g -O2 -MT stats/Histogram.lo -MD -MP -MF stats/.deps/Histogram.Tpo -c stats/Histogram.cpp -o stats/Histogram.o >/dev/null 2>&1
depbase=`echo stats/MultiLevelTimeSeries.lo | sed 's|[^/]*$|.deps/&|;s|\.lo$||'`;\
/bin/bash ./libtool  --tag=CXX   --mode=compile g++ -DHAVE_CONFIG_H   -I./.. -pthread -I/usr/include    -std=gnu++1y -g -O2 -MT stats/MultiLevelTimeSeries.lo -MD -MP -MF $depbase.Tpo -c -o stats/MultiLevelTimeSeries.lo stats/MultiLevelTimeSeries.cpp &&\
mv -f $depbase.Tpo $depbase.Plo
libtool: compile:  g++ -DHAVE_CONFIG_H -I./.. -pthread -I/usr/include -std=gnu++1y -g -O2 -MT stats/MultiLevelTimeSeries.lo -MD -MP -MF stats/.deps/MultiLevelTimeSeries.Tpo -c stats/MultiLevelTimeSeries.cpp  -fPIC -DPIC -o stats/.libs/MultiLevelTimeSeries.o
libtool: compile:  g++ -DHAVE_CONFIG_H -I./.. -pthread -I/usr/include -std=gnu++1y -g -O2 -MT stats/MultiLevelTimeSeries.lo -MD -MP -MF stats/.deps/MultiLevelTimeSeries.Tpo -c stats/MultiLevelTimeSeries.cpp -o stats/MultiLevelTimeSeries.o >/dev/null 2>&1
depbase=`echo stats/TimeseriesHistogram.lo | sed 's|[^/]*$|.deps/&|;s|\.lo$||'`;\
/bin/bash ./libtool  --tag=CXX   --mode=compile g++ -DHAVE_CONFIG_H   -I./.. -pthread -I/usr/include    -std=gnu++1y -g -O2 -MT stats/TimeseriesHistogram.lo -MD -MP -MF $depbase.Tpo -c -o stats/TimeseriesHistogram.lo stats/TimeseriesHistogram.cpp &&\
mv -f $depbase.Tpo $depbase.Plo
libtool: compile:  g++ -DHAVE_CONFIG_H -I./.. -pthread -I/usr/include -std=gnu++1y -g -O2 -MT stats/TimeseriesHistogram.lo -MD -MP -MF stats/.deps/TimeseriesHistogram.Tpo -c stats/TimeseriesHistogram.cpp  -fPIC -DPIC -o stats/.libs/TimeseriesHistogram.o
libtool: compile:  g++ -DHAVE_CONFIG_H -I./.. -pthread -I/usr/include -std=gnu++1y -g -O2 -MT stats/TimeseriesHistogram.lo -MD -MP -MF stats/.deps/TimeseriesHistogram.Tpo -c stats/TimeseriesHistogram.cpp -o stats/TimeseriesHistogram.o >/dev/null 2>&1
depbase=`echo synchronization/AsymmetricMemoryBarrier.lo | sed 's|[^/]*$|.deps/&|;s|\.lo$||'`;\
/bin/bash ./libtool  --tag=CXX   --mode=compile g++ -DHAVE_CONFIG_H   -I./.. -pthread -I/usr/include    -std=gnu++1y -g -O2 -MT synchronization/AsymmetricMemoryBarrier.lo -MD -MP -MF $depbase.Tpo -c -o synchronization/AsymmetricMemoryBarrier.lo synchronization/AsymmetricMemoryBarrier.cpp &&\
mv -f $depbase.Tpo $depbase.Plo
libtool: compile:  g++ -DHAVE_CONFIG_H -I./.. -pthread -I/usr/include -std=gnu++1y -g -O2 -MT synchronization/AsymmetricMemoryBarrier.lo -MD -MP -MF synchronization/.deps/AsymmetricMemoryBarrier.Tpo -c synchronization/AsymmetricMemoryBarrier.cpp  -fPIC -DPIC -o synchronization/.libs/AsymmetricMemoryBarrier.o
libtool: compile:  g++ -DHAVE_CONFIG_H -I./.. -pthread -I/usr/include -std=gnu++1y -g -O2 -MT synchronization/AsymmetricMemoryBarrier.lo -MD -MP -MF synchronization/.deps/AsymmetricMemoryBarrier.Tpo -c synchronization/AsymmetricMemoryBarrier.cpp -o synchronization/AsymmetricMemoryBarrier.o >/dev/null 2>&1
depbase=`echo synchronization/LifoSem.lo | sed 's|[^/]*$|.deps/&|;s|\.lo$||'`;\
/bin/bash ./libtool  --tag=CXX   --mode=compile g++ -DHAVE_CONFIG_H   -I./.. -pthread -I/usr/include    -std=gnu++1y -g -O2 -MT synchronization/LifoSem.lo -MD -MP -MF $depbase.Tpo -c -o synchronization/LifoSem.lo synchronization/LifoSem.cpp &&\
mv -f $depbase.Tpo $depbase.Plo
libtool: compile:  g++ -DHAVE_CONFIG_H -I./.. -pthread -I/usr/include -std=gnu++1y -g -O2 -MT synchronization/LifoSem.lo -MD -MP -MF synchronization/.deps/LifoSem.Tpo -c synchronization/LifoSem.cpp  -fPIC -DPIC -o synchronization/.libs/LifoSem.o
libtool: compile:  g++ -DHAVE_CONFIG_H -I./.. -pthread -I/usr/include -std=gnu++1y -g -O2 -MT synchronization/LifoSem.lo -MD -MP -MF synchronization/.deps/LifoSem.Tpo -c synchronization/LifoSem.cpp -o synchronization/LifoSem.o >/dev/null 2>&1
depbase=`echo synchronization/ParkingLot.lo | sed 's|[^/]*$|.deps/&|;s|\.lo$||'`;\
/bin/bash ./libtool  --tag=CXX   --mode=compile g++ -DHAVE_CONFIG_H   -I./.. -pthread -I/usr/include    -std=gnu++1y -g -O2 -MT synchronization/ParkingLot.lo -MD -MP -MF $depbase.Tpo -c -o synchronization/ParkingLot.lo synchronization/ParkingLot.cpp &&\
mv -f $depbase.Tpo $depbase.Plo
libtool: compile:  g++ -DHAVE_CONFIG_H -I./.. -pthread -I/usr/include -std=gnu++1y -g -O2 -MT synchronization/ParkingLot.lo -MD -MP -MF synchronization/.deps/ParkingLot.Tpo -c synchronization/ParkingLot.cpp  -fPIC -DPIC -o synchronization/.libs/ParkingLot.o
libtool: compile:  g++ -DHAVE_CONFIG_H -I./.. -pthread -I/usr/include -std=gnu++1y -g -O2 -MT synchronization/ParkingLot.lo -MD -MP -MF synchronization/.deps/ParkingLot.Tpo -c synchronization/ParkingLot.cpp -o synchronization/ParkingLot.o >/dev/null 2>&1
depbase=`echo system/MemoryMapping.lo | sed 's|[^/]*$|.deps/&|;s|\.lo$||'`;\
/bin/bash ./libtool  --tag=CXX   --mode=compile g++ -DHAVE_CONFIG_H   -I./.. -pthread -I/usr/include    -std=gnu++1y -g -O2 -MT system/MemoryMapping.lo -MD -MP -MF $depbase.Tpo -c -o system/MemoryMapping.lo system/MemoryMapping.cpp &&\
mv -f $depbase.Tpo $depbase.Plo
libtool: compile:  g++ -DHAVE_CONFIG_H -I./.. -pthread -I/usr/include -std=gnu++1y -g -O2 -MT system/MemoryMapping.lo -MD -MP -MF system/.deps/MemoryMapping.Tpo -c system/MemoryMapping.cpp  -fPIC -DPIC -o system/.libs/MemoryMapping.o
libtool: compile:  g++ -DHAVE_CONFIG_H -I./.. -pthread -I/usr/include -std=gnu++1y -g -O2 -MT system/MemoryMapping.lo -MD -MP -MF system/.deps/MemoryMapping.Tpo -c system/MemoryMapping.cpp -o system/MemoryMapping.o >/dev/null 2>&1
depbase=`echo system/Shell.lo | sed 's|[^/]*$|.deps/&|;s|\.lo$||'`;\
/bin/bash ./libtool  --tag=CXX   --mode=compile g++ -DHAVE_CONFIG_H   -I./.. -pthread -I/usr/include    -std=gnu++1y -g -O2 -MT system/Shell.lo -MD -MP -MF $depbase.Tpo -c -o system/Shell.lo system/Shell.cpp &&\
mv -f $depbase.Tpo $depbase.Plo
libtool: compile:  g++ -DHAVE_CONFIG_H -I./.. -pthread -I/usr/include -std=gnu++1y -g -O2 -MT system/Shell.lo -MD -MP -MF system/.deps/Shell.Tpo -c system/Shell.cpp  -fPIC -DPIC -o system/.libs/Shell.o
libtool: compile:  g++ -DHAVE_CONFIG_H -I./.. -pthread -I/usr/include -std=gnu++1y -g -O2 -MT system/Shell.lo -MD -MP -MF system/.deps/Shell.Tpo -c system/Shell.cpp -o system/Shell.o >/dev/null 2>&1
depbase=`echo system/ThreadName.lo | sed 's|[^/]*$|.deps/&|;s|\.lo$||'`;\
/bin/bash ./libtool  --tag=CXX   --mode=compile g++ -DHAVE_CONFIG_H   -I./.. -pthread -I/usr/include    -std=gnu++1y -g -O2 -MT system/ThreadName.lo -MD -MP -MF $depbase.Tpo -c -o system/ThreadName.lo system/ThreadName.cpp &&\
mv -f $depbase.Tpo $depbase.Plo
libtool: compile:  g++ -DHAVE_CONFIG_H -I./.. -pthread -I/usr/include -std=gnu++1y -g -O2 -MT system/ThreadName.lo -MD -MP -MF system/.deps/ThreadName.Tpo -c system/ThreadName.cpp  -fPIC -DPIC -o system/.libs/ThreadName.o
libtool: compile:  g++ -DHAVE_CONFIG_H -I./.. -pthread -I/usr/include -std=gnu++1y -g -O2 -MT system/ThreadName.lo -MD -MP -MF system/.deps/ThreadName.Tpo -c system/ThreadName.cpp -o system/ThreadName.o >/dev/null 2>&1
depbase=`echo system/VersionCheck.lo | sed 's|[^/]*$|.deps/&|;s|\.lo$||'`;\
/bin/bash ./libtool  --tag=CXX   --mode=compile g++ -DHAVE_CONFIG_H   -I./.. -pthread -I/usr/include    -std=gnu++1y -g -O2 -MT system/VersionCheck.lo -MD -MP -MF $depbase.Tpo -c -o system/VersionCheck.lo system/VersionCheck.cpp &&\
mv -f $depbase.Tpo $depbase.Plo
libtool: compile:  g++ -DHAVE_CONFIG_H -I./.. -pthread -I/usr/include -std=gnu++1y -g -O2 -MT system/VersionCheck.lo -MD -MP -MF system/.deps/VersionCheck.Tpo -c system/VersionCheck.cpp  -fPIC -DPIC -o system/.libs/VersionCheck.o
libtool: compile:  g++ -DHAVE_CONFIG_H -I./.. -pthread -I/usr/include -std=gnu++1y -g -O2 -MT system/VersionCheck.lo -MD -MP -MF system/.deps/VersionCheck.Tpo -c system/VersionCheck.cpp -o system/VersionCheck.o >/dev/null 2>&1
depbase=`echo Subprocess.lo | sed 's|[^/]*$|.deps/&|;s|\.lo$||'`;\
/bin/bash ./libtool  --tag=CXX   --mode=compile g++ -DHAVE_CONFIG_H   -I./.. -pthread -I/usr/include    -std=gnu++1y -g -O2 -MT Subprocess.lo -MD -MP -MF $depbase.Tpo -c -o Subprocess.lo Subprocess.cpp &&\
mv -f $depbase.Tpo $depbase.Plo
libtool: compile:  g++ -DHAVE_CONFIG_H -I./.. -pthread -I/usr/include -std=gnu++1y -g -O2 -MT Subprocess.lo -MD -MP -MF .deps/Subprocess.Tpo -c Subprocess.cpp  -fPIC -DPIC -o .libs/Subprocess.o
libtool: compile:  g++ -DHAVE_CONFIG_H -I./.. -pthread -I/usr/include -std=gnu++1y -g -O2 -MT Subprocess.lo -MD -MP -MF .deps/Subprocess.Tpo -c Subprocess.cpp -o Subprocess.o >/dev/null 2>&1
depbase=`echo TimeoutQueue.lo | sed 's|[^/]*$|.deps/&|;s|\.lo$||'`;\
/bin/bash ./libtool  --tag=CXX   --mode=compile g++ -DHAVE_CONFIG_H   -I./.. -pthread -I/usr/include    -std=gnu++1y -g -O2 -MT TimeoutQueue.lo -MD -MP -MF $depbase.Tpo -c -o TimeoutQueue.lo TimeoutQueue.cpp &&\
mv -f $depbase.Tpo $depbase.Plo
libtool: compile:  g++ -DHAVE_CONFIG_H -I./.. -pthread -I/usr/include -std=gnu++1y -g -O2 -MT TimeoutQueue.lo -MD -MP -MF .deps/TimeoutQueue.Tpo -c TimeoutQueue.cpp  -fPIC -DPIC -o .libs/TimeoutQueue.o
libtool: compile:  g++ -DHAVE_CONFIG_H -I./.. -pthread -I/usr/include -std=gnu++1y -g -O2 -MT TimeoutQueue.lo -MD -MP -MF .deps/TimeoutQueue.Tpo -c TimeoutQueue.cpp -o TimeoutQueue.o >/dev/null 2>&1
depbase=`echo Try.lo | sed 's|[^/]*$|.deps/&|;s|\.lo$||'`;\
/bin/bash ./libtool  --tag=CXX   --mode=compile g++ -DHAVE_CONFIG_H   -I./.. -pthread -I/usr/include    -std=gnu++1y -g -O2 -MT Try.lo -MD -MP -MF $depbase.Tpo -c -o Try.lo Try.cpp &&\
mv -f $depbase.Tpo $depbase.Plo
libtool: compile:  g++ -DHAVE_CONFIG_H -I./.. -pthread -I/usr/include -std=gnu++1y -g -O2 -MT Try.lo -MD -MP -MF .deps/Try.Tpo -c Try.cpp  -fPIC -DPIC -o .libs/Try.o
libtool: compile:  g++ -DHAVE_CONFIG_H -I./.. -pthread -I/usr/include -std=gnu++1y -g -O2 -MT Try.lo -MD -MP -MF .deps/Try.Tpo -c Try.cpp -o Try.o >/dev/null 2>&1
depbase=`echo Uri.lo | sed 's|[^/]*$|.deps/&|;s|\.lo$||'`;\
/bin/bash ./libtool  --tag=CXX   --mode=compile g++ -DHAVE_CONFIG_H   -I./.. -pthread -I/usr/include    -std=gnu++1y -g -O2 -MT Uri.lo -MD -MP -MF $depbase.Tpo -c -o Uri.lo Uri.cpp &&\
mv -f $depbase.Tpo $depbase.Plo
libtool: compile:  g++ -DHAVE_CONFIG_H -I./.. -pthread -I/usr/include -std=gnu++1y -g -O2 -MT Uri.lo -MD -MP -MF .deps/Uri.Tpo -c Uri.cpp  -fPIC -DPIC -o .libs/Uri.o
libtool: compile:  g++ -DHAVE_CONFIG_H -I./.. -pthread -I/usr/include -std=gnu++1y -g -O2 -MT Uri.lo -MD -MP -MF .deps/Uri.Tpo -c Uri.cpp -o Uri.o >/dev/null 2>&1
depbase=`echo experimental/ThreadedRepeatingFunctionRunner.lo | sed 's|[^/]*$|.deps/&|;s|\.lo$||'`;\
/bin/bash ./libtool  --tag=CXX   --mode=compile g++ -DHAVE_CONFIG_H   -I./.. -pthread -I/usr/include    -std=gnu++1y -g -O2 -MT experimental/ThreadedRepeatingFunctionRunner.lo -MD -MP -MF $depbase.Tpo -c -o experimental/ThreadedRepeatingFunctionRunner.lo experimental/ThreadedRepeatingFunctionRunner.cpp &&\
mv -f $depbase.Tpo $depbase.Plo
libtool: compile:  g++ -DHAVE_CONFIG_H -I./.. -pthread -I/usr/include -std=gnu++1y -g -O2 -MT experimental/ThreadedRepeatingFunctionRunner.lo -MD -MP -MF experimental/.deps/ThreadedRepeatingFunctionRunner.Tpo -c experimental/ThreadedRepeatingFunctionRunner.cpp  -fPIC -DPIC -o experimental/.libs/ThreadedRepeatingFunctionRunner.o
libtool: compile:  g++ -DHAVE_CONFIG_H -I./.. -pthread -I/usr/include -std=gnu++1y -g -O2 -MT experimental/ThreadedRepeatingFunctionRunner.lo -MD -MP -MF experimental/.deps/ThreadedRepeatingFunctionRunner.Tpo -c experimental/ThreadedRepeatingFunctionRunner.cpp -o experimental/ThreadedRepeatingFunctionRunner.o >/dev/null 2>&1
depbase=`echo experimental/bser/Dump.lo | sed 's|[^/]*$|.deps/&|;s|\.lo$||'`;\
/bin/bash ./libtool  --tag=CXX   --mode=compile g++ -DHAVE_CONFIG_H   -I./.. -pthread -I/usr/include    -std=gnu++1y -g -O2 -MT experimental/bser/Dump.lo -MD -MP -MF $depbase.Tpo -c -o experimental/bser/Dump.lo experimental/bser/Dump.cpp &&\
mv -f $depbase.Tpo $depbase.Plo
libtool: compile:  g++ -DHAVE_CONFIG_H -I./.. -pthread -I/usr/include -std=gnu++1y -g -O2 -MT experimental/bser/Dump.lo -MD -MP -MF experimental/bser/.deps/Dump.Tpo -c experimental/bser/Dump.cpp  -fPIC -DPIC -o experimental/bser/.libs/Dump.o
libtool: compile:  g++ -DHAVE_CONFIG_H -I./.. -pthread -I/usr/include -std=gnu++1y -g -O2 -MT experimental/bser/Dump.lo -MD -MP -MF experimental/bser/.deps/Dump.Tpo -c experimental/bser/Dump.cpp -o experimental/bser/Dump.o >/dev/null 2>&1
depbase=`echo experimental/bser/Load.lo | sed 's|[^/]*$|.deps/&|;s|\.lo$||'`;\
/bin/bash ./libtool  --tag=CXX   --mode=compile g++ -DHAVE_CONFIG_H   -I./.. -pthread -I/usr/include    -std=gnu++1y -g -O2 -MT experimental/bser/Load.lo -MD -MP -MF $depbase.Tpo -c -o experimental/bser/Load.lo experimental/bser/Load.cpp &&\
mv -f $depbase.Tpo $depbase.Plo
libtool: compile:  g++ -DHAVE_CONFIG_H -I./.. -pthread -I/usr/include -std=gnu++1y -g -O2 -MT experimental/bser/Load.lo -MD -MP -MF experimental/bser/.deps/Load.Tpo -c experimental/bser/Load.cpp  -fPIC -DPIC -o experimental/bser/.libs/Load.o
libtool: compile:  g++ -DHAVE_CONFIG_H -I./.. -pthread -I/usr/include -std=gnu++1y -g -O2 -MT experimental/bser/Load.lo -MD -MP -MF experimental/bser/.deps/Load.Tpo -c experimental/bser/Load.cpp -o experimental/bser/Load.o >/dev/null 2>&1
depbase=`echo experimental/DynamicParser.lo | sed 's|[^/]*$|.deps/&|;s|\.lo$||'`;\
/bin/bash ./libtool  --tag=CXX   --mode=compile g++ -DHAVE_CONFIG_H   -I./.. -pthread -I/usr/include    -std=gnu++1y -g -O2 -MT experimental/DynamicParser.lo -MD -MP -MF $depbase.Tpo -c -o experimental/DynamicParser.lo experimental/DynamicParser.cpp &&\
mv -f $depbase.Tpo $depbase.Plo
libtool: compile:  g++ -DHAVE_CONFIG_H -I./.. -pthread -I/usr/include -std=gnu++1y -g -O2 -MT experimental/DynamicParser.lo -MD -MP -MF experimental/.deps/DynamicParser.Tpo -c experimental/DynamicParser.cpp  -fPIC -DPIC -o experimental/.libs/DynamicParser.o
libtool: compile:  g++ -DHAVE_CONFIG_H -I./.. -pthread -I/usr/include -std=gnu++1y -g -O2 -MT experimental/DynamicParser.lo -MD -MP -MF experimental/.deps/DynamicParser.Tpo -c experimental/DynamicParser.cpp -o experimental/DynamicParser.o >/dev/null 2>&1
depbase=`echo experimental/EnvUtil.lo | sed 's|[^/]*$|.deps/&|;s|\.lo$||'`;\
/bin/bash ./libtool  --tag=CXX   --mode=compile g++ -DHAVE_CONFIG_H   -I./.. -pthread -I/usr/include    -std=gnu++1y -g -O2 -MT experimental/EnvUtil.lo -MD -MP -MF $depbase.Tpo -c -o experimental/EnvUtil.lo experimental/EnvUtil.cpp &&\
mv -f $depbase.Tpo $depbase.Plo
libtool: compile:  g++ -DHAVE_CONFIG_H -I./.. -pthread -I/usr/include -std=gnu++1y -g -O2 -MT experimental/EnvUtil.lo -MD -MP -MF experimental/.deps/EnvUtil.Tpo -c experimental/EnvUtil.cpp  -fPIC -DPIC -o experimental/.libs/EnvUtil.o
libtool: compile:  g++ -DHAVE_CONFIG_H -I./.. -pthread -I/usr/include -std=gnu++1y -g -O2 -MT experimental/EnvUtil.lo -MD -MP -MF experimental/.deps/EnvUtil.Tpo -c experimental/EnvUtil.cpp -o experimental/EnvUtil.o >/dev/null 2>&1
depbase=`echo experimental/FunctionScheduler.lo | sed 's|[^/]*$|.deps/&|;s|\.lo$||'`;\
/bin/bash ./libtool  --tag=CXX   --mode=compile g++ -DHAVE_CONFIG_H   -I./.. -pthread -I/usr/include    -std=gnu++1y -g -O2 -MT experimental/FunctionScheduler.lo -MD -MP -MF $depbase.Tpo -c -o experimental/FunctionScheduler.lo experimental/FunctionScheduler.cpp &&\
mv -f $depbase.Tpo $depbase.Plo
libtool: compile:  g++ -DHAVE_CONFIG_H -I./.. -pthread -I/usr/include -std=gnu++1y -g -O2 -MT experimental/FunctionScheduler.lo -MD -MP -MF experimental/.deps/FunctionScheduler.Tpo -c experimental/FunctionScheduler.cpp  -fPIC -DPIC -o experimental/.libs/FunctionScheduler.o
libtool: compile:  g++ -DHAVE_CONFIG_H -I./.. -pthread -I/usr/include -std=gnu++1y -g -O2 -MT experimental/FunctionScheduler.lo -MD -MP -MF experimental/.deps/FunctionScheduler.Tpo -c experimental/FunctionScheduler.cpp -o experimental/FunctionScheduler.o >/dev/null 2>&1
depbase=`echo experimental/io/FsUtil.lo | sed 's|[^/]*$|.deps/&|;s|\.lo$||'`;\
/bin/bash ./libtool  --tag=CXX   --mode=compile g++ -DHAVE_CONFIG_H   -I./.. -pthread -I/usr/include    -std=gnu++1y -g -O2 -MT experimental/io/FsUtil.lo -MD -MP -MF $depbase.Tpo -c -o experimental/io/FsUtil.lo experimental/io/FsUtil.cpp &&\
mv -f $depbase.Tpo $depbase.Plo
libtool: compile:  g++ -DHAVE_CONFIG_H -I./.. -pthread -I/usr/include -std=gnu++1y -g -O2 -MT experimental/io/FsUtil.lo -MD -MP -MF experimental/io/.deps/FsUtil.Tpo -c experimental/io/FsUtil.cpp  -fPIC -DPIC -o experimental/io/.libs/FsUtil.o
libtool: compile:  g++ -DHAVE_CONFIG_H -I./.. -pthread -I/usr/include -std=gnu++1y -g -O2 -MT experimental/io/FsUtil.lo -MD -MP -MF experimental/io/.deps/FsUtil.Tpo -c experimental/io/FsUtil.cpp -o experimental/io/FsUtil.o >/dev/null 2>&1
depbase=`echo experimental/JemallocNodumpAllocator.lo | sed 's|[^/]*$|.deps/&|;s|\.lo$||'`;\
/bin/bash ./libtool  --tag=CXX   --mode=compile g++ -DHAVE_CONFIG_H   -I./.. -pthread -I/usr/include    -std=gnu++1y -g -O2 -MT experimental/JemallocNodumpAllocator.lo -MD -MP -MF $depbase.Tpo -c -o experimental/JemallocNodumpAllocator.lo experimental/JemallocNodumpAllocator.cpp &&\
mv -f $depbase.Tpo $depbase.Plo
libtool: compile:  g++ -DHAVE_CONFIG_H -I./.. -pthread -I/usr/include -std=gnu++1y -g -O2 -MT experimental/JemallocNodumpAllocator.lo -MD -MP -MF experimental/.deps/JemallocNodumpAllocator.Tpo -c experimental/JemallocNodumpAllocator.cpp  -fPIC -DPIC -o experimental/.libs/JemallocNodumpAllocator.o
libtool: compile:  g++ -DHAVE_CONFIG_H -I./.. -pthread -I/usr/include -std=gnu++1y -g -O2 -MT experimental/JemallocNodumpAllocator.lo -MD -MP -MF experimental/.deps/JemallocNodumpAllocator.Tpo -c experimental/JemallocNodumpAllocator.cpp -o experimental/JemallocNodumpAllocator.o >/dev/null 2>&1
depbase=`echo experimental/JSONSchema.lo | sed 's|[^/]*$|.deps/&|;s|\.lo$||'`;\
/bin/bash ./libtool  --tag=CXX   --mode=compile g++ -DHAVE_CONFIG_H   -I./.. -pthread -I/usr/include    -std=gnu++1y -g -O2 -MT experimental/JSONSchema.lo -MD -MP -MF $depbase.Tpo -c -o experimental/JSONSchema.lo experimental/JSONSchema.cpp &&\
mv -f $depbase.Tpo $depbase.Plo
libtool: compile:  g++ -DHAVE_CONFIG_H -I./.. -pthread -I/usr/include -std=gnu++1y -g -O2 -MT experimental/JSONSchema.lo -MD -MP -MF experimental/.deps/JSONSchema.Tpo -c experimental/JSONSchema.cpp  -fPIC -DPIC -o experimental/.libs/JSONSchema.o
libtool: compile:  g++ -DHAVE_CONFIG_H -I./.. -pthread -I/usr/include -std=gnu++1y -g -O2 -MT experimental/JSONSchema.lo -MD -MP -MF experimental/.deps/JSONSchema.Tpo -c experimental/JSONSchema.cpp -o experimental/JSONSchema.o >/dev/null 2>&1
depbase=`echo experimental/NestedCommandLineApp.lo | sed 's|[^/]*$|.deps/&|;s|\.lo$||'`;\
/bin/bash ./libtool  --tag=CXX   --mode=compile g++ -DHAVE_CONFIG_H   -I./.. -pthread -I/usr/include    -std=gnu++1y -g -O2 -MT experimental/NestedCommandLineApp.lo -MD -MP -MF $depbase.Tpo -c -o experimental/NestedCommandLineApp.lo experimental/NestedCommandLineApp.cpp &&\
mv -f $depbase.Tpo $depbase.Plo
libtool: compile:  g++ -DHAVE_CONFIG_H -I./.. -pthread -I/usr/include -std=gnu++1y -g -O2 -MT experimental/NestedCommandLineApp.lo -MD -MP -MF experimental/.deps/NestedCommandLineApp.Tpo -c experimental/NestedCommandLineApp.cpp  -fPIC -DPIC -o experimental/.libs/NestedCommandLineApp.o
libtool: compile:  g++ -DHAVE_CONFIG_H -I./.. -pthread -I/usr/include -std=gnu++1y -g -O2 -MT experimental/NestedCommandLineApp.lo -MD -MP -MF experimental/.deps/NestedCommandLineApp.Tpo -c experimental/NestedCommandLineApp.cpp -o experimental/NestedCommandLineApp.o >/dev/null 2>&1
depbase=`echo experimental/observer/detail/Core.lo | sed 's|[^/]*$|.deps/&|;s|\.lo$||'`;\
/bin/bash ./libtool  --tag=CXX   --mode=compile g++ -DHAVE_CONFIG_H   -I./.. -pthread -I/usr/include    -std=gnu++1y -g -O2 -MT experimental/observer/detail/Core.lo -MD -MP -MF $depbase.Tpo -c -o experimental/observer/detail/Core.lo experimental/observer/detail/Core.cpp &&\
mv -f $depbase.Tpo $depbase.Plo
libtool: compile:  g++ -DHAVE_CONFIG_H -I./.. -pthread -I/usr/include -std=gnu++1y -g -O2 -MT experimental/observer/detail/Core.lo -MD -MP -MF experimental/observer/detail/.deps/Core.Tpo -c experimental/observer/detail/Core.cpp  -fPIC -DPIC -o experimental/observer/detail/.libs/Core.o
libtool: compile:  g++ -DHAVE_CONFIG_H -I./.. -pthread -I/usr/include -std=gnu++1y -g -O2 -MT experimental/observer/detail/Core.lo -MD -MP -MF experimental/observer/detail/.deps/Core.Tpo -c experimental/observer/detail/Core.cpp -o experimental/observer/detail/Core.o >/dev/null 2>&1
depbase=`echo experimental/observer/detail/ObserverManager.lo | sed 's|[^/]*$|.deps/&|;s|\.lo$||'`;\
/bin/bash ./libtool  --tag=CXX   --mode=compile g++ -DHAVE_CONFIG_H   -I./.. -pthread -I/usr/include    -std=gnu++1y -g -O2 -MT experimental/observer/detail/ObserverManager.lo -MD -MP -MF $depbase.Tpo -c -o experimental/observer/detail/ObserverManager.lo experimental/observer/detail/ObserverManager.cpp &&\
mv -f $depbase.Tpo $depbase.Plo
libtool: compile:  g++ -DHAVE_CONFIG_H -I./.. -pthread -I/usr/include -std=gnu++1y -g -O2 -MT experimental/observer/detail/ObserverManager.lo -MD -MP -MF experimental/observer/detail/.deps/ObserverManager.Tpo -c experimental/observer/detail/ObserverManager.cpp  -fPIC -DPIC -o experimental/observer/detail/.libs/ObserverManager.o
libtool: compile:  g++ -DHAVE_CONFIG_H -I./.. -pthread -I/usr/include -std=gnu++1y -g -O2 -MT experimental/observer/detail/ObserverManager.lo -MD -MP -MF experimental/observer/detail/.deps/ObserverManager.Tpo -c experimental/observer/detail/ObserverManager.cpp -o experimental/observer/detail/ObserverManager.o >/dev/null 2>&1
depbase=`echo experimental/ProgramOptions.lo | sed 's|[^/]*$|.deps/&|;s|\.lo$||'`;\
/bin/bash ./libtool  --tag=CXX   --mode=compile g++ -DHAVE_CONFIG_H   -I./.. -pthread -I/usr/include    -std=gnu++1y -g -O2 -MT experimental/ProgramOptions.lo -MD -MP -MF $depbase.Tpo -c -o experimental/ProgramOptions.lo experimental/ProgramOptions.cpp &&\
mv -f $depbase.Tpo $depbase.Plo
libtool: compile:  g++ -DHAVE_CONFIG_H -I./.. -pthread -I/usr/include -std=gnu++1y -g -O2 -MT experimental/ProgramOptions.lo -MD -MP -MF experimental/.deps/ProgramOptions.Tpo -c experimental/ProgramOptions.cpp  -fPIC -DPIC -o experimental/.libs/ProgramOptions.o
libtool: compile:  g++ -DHAVE_CONFIG_H -I./.. -pthread -I/usr/include -std=gnu++1y -g -O2 -MT experimental/ProgramOptions.lo -MD -MP -MF experimental/.deps/ProgramOptions.Tpo -c experimental/ProgramOptions.cpp -o experimental/ProgramOptions.o >/dev/null 2>&1
depbase=`echo experimental/Select64.lo | sed 's|[^/]*$|.deps/&|;s|\.lo$||'`;\
/bin/bash ./libtool  --tag=CXX   --mode=compile g++ -DHAVE_CONFIG_H   -I./.. -pthread -I/usr/include    -std=gnu++1y -g -O2 -MT experimental/Select64.lo -MD -MP -MF $depbase.Tpo -c -o experimental/Select64.lo experimental/Select64.cpp &&\
mv -f $depbase.Tpo $depbase.Plo
libtool: compile:  g++ -DHAVE_CONFIG_H -I./.. -pthread -I/usr/include -std=gnu++1y -g -O2 -MT experimental/Select64.lo -MD -MP -MF experimental/.deps/Select64.Tpo -c experimental/Select64.cpp  -fPIC -DPIC -o experimental/.libs/Select64.o
libtool: compile:  g++ -DHAVE_CONFIG_H -I./.. -pthread -I/usr/include -std=gnu++1y -g -O2 -MT experimental/Select64.lo -MD -MP -MF experimental/.deps/Select64.Tpo -c experimental/Select64.cpp -o experimental/Select64.o >/dev/null 2>&1
depbase=`echo experimental/TestUtil.lo | sed 's|[^/]*$|.deps/&|;s|\.lo$||'`;\
/bin/bash ./libtool  --tag=CXX   --mode=compile g++ -DHAVE_CONFIG_H   -I./.. -pthread -I/usr/include    -std=gnu++1y -g -O2 -MT experimental/TestUtil.lo -MD -MP -MF $depbase.Tpo -c -o experimental/TestUtil.lo experimental/TestUtil.cpp &&\
mv -f $depbase.Tpo $depbase.Plo
libtool: compile:  g++ -DHAVE_CONFIG_H -I./.. -pthread -I/usr/include -std=gnu++1y -g -O2 -MT experimental/TestUtil.lo -MD -MP -MF experimental/.deps/TestUtil.Tpo -c experimental/TestUtil.cpp  -fPIC -DPIC -o experimental/.libs/TestUtil.o
libtool: compile:  g++ -DHAVE_CONFIG_H -I./.. -pthread -I/usr/include -std=gnu++1y -g -O2 -MT experimental/TestUtil.lo -MD -MP -MF experimental/.deps/TestUtil.Tpo -c experimental/TestUtil.cpp -o experimental/TestUtil.o >/dev/null 2>&1
depbase=`echo experimental/io/HugePages.lo | sed 's|[^/]*$|.deps/&|;s|\.lo$||'`;\
/bin/bash ./libtool  --tag=CXX   --mode=compile g++ -DHAVE_CONFIG_H   -I./.. -pthread -I/usr/include    -std=gnu++1y -g -O2 -MT experimental/io/HugePages.lo -MD -MP -MF $depbase.Tpo -c -o experimental/io/HugePages.lo experimental/io/HugePages.cpp &&\
mv -f $depbase.Tpo $depbase.Plo
libtool: compile:  g++ -DHAVE_CONFIG_H -I./.. -pthread -I/usr/include -std=gnu++1y -g -O2 -MT experimental/io/HugePages.lo -MD -MP -MF experimental/io/.deps/HugePages.Tpo -c experimental/io/HugePages.cpp  -fPIC -DPIC -o experimental/io/.libs/HugePages.o
libtool: compile:  g++ -DHAVE_CONFIG_H -I./.. -pthread -I/usr/include -std=gnu++1y -g -O2 -MT experimental/io/HugePages.lo -MD -MP -MF experimental/io/.deps/HugePages.Tpo -c experimental/io/HugePages.cpp -o experimental/io/HugePages.o >/dev/null 2>&1
depbase=`echo fibers/Baton.lo | sed 's|[^/]*$|.deps/&|;s|\.lo$||'`;\
/bin/bash ./libtool  --tag=CXX   --mode=compile g++ -DHAVE_CONFIG_H   -I./.. -pthread -I/usr/include    -std=gnu++1y -g -O2 -MT fibers/Baton.lo -MD -MP -MF $depbase.Tpo -c -o fibers/Baton.lo fibers/Baton.cpp &&\
mv -f $depbase.Tpo $depbase.Plo
libtool: compile:  g++ -DHAVE_CONFIG_H -I./.. -pthread -I/usr/include -std=gnu++1y -g -O2 -MT fibers/Baton.lo -MD -MP -MF fibers/.deps/Baton.Tpo -c fibers/Baton.cpp  -fPIC -DPIC -o fibers/.libs/Baton.o
libtool: compile:  g++ -DHAVE_CONFIG_H -I./.. -pthread -I/usr/include -std=gnu++1y -g -O2 -MT fibers/Baton.lo -MD -MP -MF fibers/.deps/Baton.Tpo -c fibers/Baton.cpp -o fibers/Baton.o >/dev/null 2>&1
depbase=`echo fibers/detail/AtomicBatchDispatcher.lo | sed 's|[^/]*$|.deps/&|;s|\.lo$||'`;\
/bin/bash ./libtool  --tag=CXX   --mode=compile g++ -DHAVE_CONFIG_H   -I./.. -pthread -I/usr/include    -std=gnu++1y -g -O2 -MT fibers/detail/AtomicBatchDispatcher.lo -MD -MP -MF $depbase.Tpo -c -o fibers/detail/AtomicBatchDispatcher.lo fibers/detail/AtomicBatchDispatcher.cpp &&\
mv -f $depbase.Tpo $depbase.Plo
libtool: compile:  g++ -DHAVE_CONFIG_H -I./.. -pthread -I/usr/include -std=gnu++1y -g -O2 -MT fibers/detail/AtomicBatchDispatcher.lo -MD -MP -MF fibers/detail/.deps/AtomicBatchDispatcher.Tpo -c fibers/detail/AtomicBatchDispatcher.cpp  -fPIC -DPIC -o fibers/detail/.libs/AtomicBatchDispatcher.o
libtool: compile:  g++ -DHAVE_CONFIG_H -I./.. -pthread -I/usr/include -std=gnu++1y -g -O2 -MT fibers/detail/AtomicBatchDispatcher.lo -MD -MP -MF fibers/detail/.deps/AtomicBatchDispatcher.Tpo -c fibers/detail/AtomicBatchDispatcher.cpp -o fibers/detail/AtomicBatchDispatcher.o >/dev/null 2>&1
depbase=`echo fibers/Fiber.lo | sed 's|[^/]*$|.deps/&|;s|\.lo$||'`;\
/bin/bash ./libtool  --tag=CXX   --mode=compile g++ -DHAVE_CONFIG_H   -I./.. -pthread -I/usr/include    -std=gnu++1y -g -O2 -MT fibers/Fiber.lo -MD -MP -MF $depbase.Tpo -c -o fibers/Fiber.lo fibers/Fiber.cpp &&\
mv -f $depbase.Tpo $depbase.Plo
libtool: compile:  g++ -DHAVE_CONFIG_H -I./.. -pthread -I/usr/include -std=gnu++1y -g -O2 -MT fibers/Fiber.lo -MD -MP -MF fibers/.deps/Fiber.Tpo -c fibers/Fiber.cpp  -fPIC -DPIC -o fibers/.libs/Fiber.o
libtool: compile:  g++ -DHAVE_CONFIG_H -I./.. -pthread -I/usr/include -std=gnu++1y -g -O2 -MT fibers/Fiber.lo -MD -MP -MF fibers/.deps/Fiber.Tpo -c fibers/Fiber.cpp -o fibers/Fiber.o >/dev/null 2>&1
depbase=`echo fibers/FiberManager.lo | sed 's|[^/]*$|.deps/&|;s|\.lo$||'`;\
/bin/bash ./libtool  --tag=CXX   --mode=compile g++ -DHAVE_CONFIG_H   -I./.. -pthread -I/usr/include    -std=gnu++1y -g -O2 -MT fibers/FiberManager.lo -MD -MP -MF $depbase.Tpo -c -o fibers/FiberManager.lo fibers/FiberManager.cpp &&\
mv -f $depbase.Tpo $depbase.Plo
libtool: compile:  g++ -DHAVE_CONFIG_H -I./.. -pthread -I/usr/include -std=gnu++1y -g -O2 -MT fibers/FiberManager.lo -MD -MP -MF fibers/.deps/FiberManager.Tpo -c fibers/FiberManager.cpp  -fPIC -DPIC -o fibers/.libs/FiberManager.o
libtool: compile:  g++ -DHAVE_CONFIG_H -I./.. -pthread -I/usr/include -std=gnu++1y -g -O2 -MT fibers/FiberManager.lo -MD -MP -MF fibers/.deps/FiberManager.Tpo -c fibers/FiberManager.cpp -o fibers/FiberManager.o >/dev/null 2>&1
depbase=`echo fibers/FiberManagerMap.lo | sed 's|[^/]*$|.deps/&|;s|\.lo$||'`;\
/bin/bash ./libtool  --tag=CXX   --mode=compile g++ -DHAVE_CONFIG_H   -I./.. -pthread -I/usr/include    -std=gnu++1y -g -O2 -MT fibers/FiberManagerMap.lo -MD -MP -MF $depbase.Tpo -c -o fibers/FiberManagerMap.lo fibers/FiberManagerMap.cpp &&\
mv -f $depbase.Tpo $depbase.Plo
libtool: compile:  g++ -DHAVE_CONFIG_H -I./.. -pthread -I/usr/include -std=gnu++1y -g -O2 -MT fibers/FiberManagerMap.lo -MD -MP -MF fibers/.deps/FiberManagerMap.Tpo -c fibers/FiberManagerMap.cpp  -fPIC -DPIC -o fibers/.libs/FiberManagerMap.o
libtool: compile:  g++ -DHAVE_CONFIG_H -I./.. -pthread -I/usr/include -std=gnu++1y -g -O2 -MT fibers/FiberManagerMap.lo -MD -MP -MF fibers/.deps/FiberManagerMap.Tpo -c fibers/FiberManagerMap.cpp -o fibers/FiberManagerMap.o >/dev/null 2>&1
depbase=`echo fibers/GuardPageAllocator.lo | sed 's|[^/]*$|.deps/&|;s|\.lo$||'`;\
/bin/bash ./libtool  --tag=CXX   --mode=compile g++ -DHAVE_CONFIG_H   -I./.. -pthread -I/usr/include    -std=gnu++1y -g -O2 -MT fibers/GuardPageAllocator.lo -MD -MP -MF $depbase.Tpo -c -o fibers/GuardPageAllocator.lo fibers/GuardPageAllocator.cpp &&\
mv -f $depbase.Tpo $depbase.Plo
libtool: compile:  g++ -DHAVE_CONFIG_H -I./.. -pthread -I/usr/include -std=gnu++1y -g -O2 -MT fibers/GuardPageAllocator.lo -MD -MP -MF fibers/.deps/GuardPageAllocator.Tpo -c fibers/GuardPageAllocator.cpp  -fPIC -DPIC -o fibers/.libs/GuardPageAllocator.o
libtool: compile:  g++ -DHAVE_CONFIG_H -I./.. -pthread -I/usr/include -std=gnu++1y -g -O2 -MT fibers/GuardPageAllocator.lo -MD -MP -MF fibers/.deps/GuardPageAllocator.Tpo -c fibers/GuardPageAllocator.cpp -o fibers/GuardPageAllocator.o >/dev/null 2>&1
depbase=`echo fibers/Semaphore.lo | sed 's|[^/]*$|.deps/&|;s|\.lo$||'`;\
/bin/bash ./libtool  --tag=CXX   --mode=compile g++ -DHAVE_CONFIG_H   -I./.. -pthread -I/usr/include    -std=gnu++1y -g -O2 -MT fibers/Semaphore.lo -MD -MP -MF $depbase.Tpo -c -o fibers/Semaphore.lo fibers/Semaphore.cpp &&\
mv -f $depbase.Tpo $depbase.Plo
libtool: compile:  g++ -DHAVE_CONFIG_H -I./.. -pthread -I/usr/include -std=gnu++1y -g -O2 -MT fibers/Semaphore.lo -MD -MP -MF fibers/.deps/Semaphore.Tpo -c fibers/Semaphore.cpp  -fPIC -DPIC -o fibers/.libs/Semaphore.o
libtool: compile:  g++ -DHAVE_CONFIG_H -I./.. -pthread -I/usr/include -std=gnu++1y -g -O2 -MT fibers/Semaphore.lo -MD -MP -MF fibers/.deps/Semaphore.Tpo -c fibers/Semaphore.cpp -o fibers/Semaphore.o >/dev/null 2>&1
depbase=`echo fibers/TimeoutController.lo | sed 's|[^/]*$|.deps/&|;s|\.lo$||'`;\
/bin/bash ./libtool  --tag=CXX   --mode=compile g++ -DHAVE_CONFIG_H   -I./.. -pthread -I/usr/include    -std=gnu++1y -g -O2 -MT fibers/TimeoutController.lo -MD -MP -MF $depbase.Tpo -c -o fibers/TimeoutController.lo fibers/TimeoutController.cpp &&\
mv -f $depbase.Tpo $depbase.Plo
libtool: compile:  g++ -DHAVE_CONFIG_H -I./.. -pthread -I/usr/include -std=gnu++1y -g -O2 -MT fibers/TimeoutController.lo -MD -MP -MF fibers/.deps/TimeoutController.Tpo -c fibers/TimeoutController.cpp  -fPIC -DPIC -o fibers/.libs/TimeoutController.o
libtool: compile:  g++ -DHAVE_CONFIG_H -I./.. -pthread -I/usr/include -std=gnu++1y -g -O2 -MT fibers/TimeoutController.lo -MD -MP -MF fibers/.deps/TimeoutController.Tpo -c fibers/TimeoutController.cpp -o fibers/TimeoutController.o >/dev/null 2>&1
depbase=`echo experimental/symbolizer/Elf.lo | sed 's|[^/]*$|.deps/&|;s|\.lo$||'`;\
/bin/bash ./libtool  --tag=CXX   --mode=compile g++ -DHAVE_CONFIG_H   -I./.. -pthread -I/usr/include    -std=gnu++1y -g -O2 -MT experimental/symbolizer/Elf.lo -MD -MP -MF $depbase.Tpo -c -o experimental/symbolizer/Elf.lo experimental/symbolizer/Elf.cpp &&\
mv -f $depbase.Tpo $depbase.Plo
libtool: compile:  g++ -DHAVE_CONFIG_H -I./.. -pthread -I/usr/include -std=gnu++1y -g -O2 -MT experimental/symbolizer/Elf.lo -MD -MP -MF experimental/symbolizer/.deps/Elf.Tpo -c experimental/symbolizer/Elf.cpp  -fPIC -DPIC -o experimental/symbolizer/.libs/Elf.o
libtool: compile:  g++ -DHAVE_CONFIG_H -I./.. -pthread -I/usr/include -std=gnu++1y -g -O2 -MT experimental/symbolizer/Elf.lo -MD -MP -MF experimental/symbolizer/.deps/Elf.Tpo -c experimental/symbolizer/Elf.cpp -o experimental/symbolizer/Elf.o >/dev/null 2>&1
depbase=`echo experimental/symbolizer/ElfCache.lo | sed 's|[^/]*$|.deps/&|;s|\.lo$||'`;\
/bin/bash ./libtool  --tag=CXX   --mode=compile g++ -DHAVE_CONFIG_H   -I./.. -pthread -I/usr/include    -std=gnu++1y -g -O2 -MT experimental/symbolizer/ElfCache.lo -MD -MP -MF $depbase.Tpo -c -o experimental/symbolizer/ElfCache.lo experimental/symbolizer/ElfCache.cpp &&\
mv -f $depbase.Tpo $depbase.Plo
libtool: compile:  g++ -DHAVE_CONFIG_H -I./.. -pthread -I/usr/include -std=gnu++1y -g -O2 -MT experimental/symbolizer/ElfCache.lo -MD -MP -MF experimental/symbolizer/.deps/ElfCache.Tpo -c experimental/symbolizer/ElfCache.cpp  -fPIC -DPIC -o experimental/symbolizer/.libs/ElfCache.o
libtool: compile:  g++ -DHAVE_CONFIG_H -I./.. -pthread -I/usr/include -std=gnu++1y -g -O2 -MT experimental/symbolizer/ElfCache.lo -MD -MP -MF experimental/symbolizer/.deps/ElfCache.Tpo -c experimental/symbolizer/ElfCache.cpp -o experimental/symbolizer/ElfCache.o >/dev/null 2>&1
depbase=`echo experimental/symbolizer/Dwarf.lo | sed 's|[^/]*$|.deps/&|;s|\.lo$||'`;\
/bin/bash ./libtool  --tag=CXX   --mode=compile g++ -DHAVE_CONFIG_H   -I./.. -pthread -I/usr/include    -std=gnu++1y -g -O2 -MT experimental/symbolizer/Dwarf.lo -MD -MP -MF $depbase.Tpo -c -o experimental/symbolizer/Dwarf.lo experimental/symbolizer/Dwarf.cpp &&\
mv -f $depbase.Tpo $depbase.Plo
libtool: compile:  g++ -DHAVE_CONFIG_H -I./.. -pthread -I/usr/include -std=gnu++1y -g -O2 -MT experimental/symbolizer/Dwarf.lo -MD -MP -MF experimental/symbolizer/.deps/Dwarf.Tpo -c experimental/symbolizer/Dwarf.cpp  -fPIC -DPIC -o experimental/symbolizer/.libs/Dwarf.o
libtool: compile:  g++ -DHAVE_CONFIG_H -I./.. -pthread -I/usr/include -std=gnu++1y -g -O2 -MT experimental/symbolizer/Dwarf.lo -MD -MP -MF experimental/symbolizer/.deps/Dwarf.Tpo -c experimental/symbolizer/Dwarf.cpp -o experimental/symbolizer/Dwarf.o >/dev/null 2>&1
depbase=`echo experimental/symbolizer/LineReader.lo | sed 's|[^/]*$|.deps/&|;s|\.lo$||'`;\
/bin/bash ./libtool  --tag=CXX   --mode=compile g++ -DHAVE_CONFIG_H   -I./.. -pthread -I/usr/include    -std=gnu++1y -g -O2 -MT experimental/symbolizer/LineReader.lo -MD -MP -MF $depbase.Tpo -c -o experimental/symbolizer/LineReader.lo experimental/symbolizer/LineReader.cpp &&\
mv -f $depbase.Tpo $depbase.Plo
libtool: compile:  g++ -DHAVE_CONFIG_H -I./.. -pthread -I/usr/include -std=gnu++1y -g -O2 -MT experimental/symbolizer/LineReader.lo -MD -MP -MF experimental/symbolizer/.deps/LineReader.Tpo -c experimental/symbolizer/LineReader.cpp  -fPIC -DPIC -o experimental/symbolizer/.libs/LineReader.o
libtool: compile:  g++ -DHAVE_CONFIG_H -I./.. -pthread -I/usr/include -std=gnu++1y -g -O2 -MT experimental/symbolizer/LineReader.lo -MD -MP -MF experimental/symbolizer/.deps/LineReader.Tpo -c experimental/symbolizer/LineReader.cpp -o experimental/symbolizer/LineReader.o >/dev/null 2>&1
depbase=`echo experimental/symbolizer/SignalHandler.lo | sed 's|[^/]*$|.deps/&|;s|\.lo$||'`;\
/bin/bash ./libtool  --tag=CXX   --mode=compile g++ -DHAVE_CONFIG_H   -I./.. -pthread -I/usr/include    -std=gnu++1y -g -O2 -MT experimental/symbolizer/SignalHandler.lo -MD -MP -MF $depbase.Tpo -c -o experimental/symbolizer/SignalHandler.lo experimental/symbolizer/SignalHandler.cpp &&\
mv -f $depbase.Tpo $depbase.Plo
libtool: compile:  g++ -DHAVE_CONFIG_H -I./.. -pthread -I/usr/include -std=gnu++1y -g -O2 -MT experimental/symbolizer/SignalHandler.lo -MD -MP -MF experimental/symbolizer/.deps/SignalHandler.Tpo -c experimental/symbolizer/SignalHandler.cpp  -fPIC -DPIC -o experimental/symbolizer/.libs/SignalHandler.o
libtool: compile:  g++ -DHAVE_CONFIG_H -I./.. -pthread -I/usr/include -std=gnu++1y -g -O2 -MT experimental/symbolizer/SignalHandler.lo -MD -MP -MF experimental/symbolizer/.deps/SignalHandler.Tpo -c experimental/symbolizer/SignalHandler.cpp -o experimental/symbolizer/SignalHandler.o >/dev/null 2>&1
depbase=`echo experimental/symbolizer/StackTrace.lo | sed 's|[^/]*$|.deps/&|;s|\.lo$||'`;\
/bin/bash ./libtool  --tag=CXX   --mode=compile g++ -DHAVE_CONFIG_H   -I./.. -pthread -I/usr/include    -std=gnu++1y -g -O2 -MT experimental/symbolizer/StackTrace.lo -MD -MP -MF $depbase.Tpo -c -o experimental/symbolizer/StackTrace.lo experimental/symbolizer/StackTrace.cpp &&\
mv -f $depbase.Tpo $depbase.Plo
libtool: compile:  g++ -DHAVE_CONFIG_H -I./.. -pthread -I/usr/include -std=gnu++1y -g -O2 -MT experimental/symbolizer/StackTrace.lo -MD -MP -MF experimental/symbolizer/.deps/StackTrace.Tpo -c experimental/symbolizer/StackTrace.cpp  -fPIC -DPIC -o experimental/symbolizer/.libs/StackTrace.o
libtool: compile:  g++ -DHAVE_CONFIG_H -I./.. -pthread -I/usr/include -std=gnu++1y -g -O2 -MT experimental/symbolizer/StackTrace.lo -MD -MP -MF experimental/symbolizer/.deps/StackTrace.Tpo -c experimental/symbolizer/StackTrace.cpp -o experimental/symbolizer/StackTrace.o >/dev/null 2>&1
depbase=`echo experimental/symbolizer/Symbolizer.lo | sed 's|[^/]*$|.deps/&|;s|\.lo$||'`;\
/bin/bash ./libtool  --tag=CXX   --mode=compile g++ -DHAVE_CONFIG_H   -I./.. -pthread -I/usr/include    -std=gnu++1y -g -O2 -MT experimental/symbolizer/Symbolizer.lo -MD -MP -MF $depbase.Tpo -c -o experimental/symbolizer/Symbolizer.lo experimental/symbolizer/Symbolizer.cpp &&\
mv -f $depbase.Tpo $depbase.Plo
libtool: compile:  g++ -DHAVE_CONFIG_H -I./.. -pthread -I/usr/include -std=gnu++1y -g -O2 -MT experimental/symbolizer/Symbolizer.lo -MD -MP -MF experimental/symbolizer/.deps/Symbolizer.Tpo -c experimental/symbolizer/Symbolizer.cpp  -fPIC -DPIC -o experimental/symbolizer/.libs/Symbolizer.o
libtool: compile:  g++ -DHAVE_CONFIG_H -I./.. -pthread -I/usr/include -std=gnu++1y -g -O2 -MT experimental/symbolizer/Symbolizer.lo -MD -MP -MF experimental/symbolizer/.deps/Symbolizer.Tpo -c experimental/symbolizer/Symbolizer.cpp -o experimental/symbolizer/Symbolizer.o >/dev/null 2>&1
depbase=`echo Poly.lo | sed 's|[^/]*$|.deps/&|;s|\.lo$||'`;\
/bin/bash ./libtool  --tag=CXX   --mode=compile g++ -DHAVE_CONFIG_H   -I./.. -pthread -I/usr/include    -std=gnu++1y -g -O2 -MT Poly.lo -MD -MP -MF $depbase.Tpo -c -o Poly.lo Poly.cpp &&\
mv -f $depbase.Tpo $depbase.Plo
libtool: compile:  g++ -DHAVE_CONFIG_H -I./.. -pthread -I/usr/include -std=gnu++1y -g -O2 -MT Poly.lo -MD -MP -MF .deps/Poly.Tpo -c Poly.cpp  -fPIC -DPIC -o .libs/Poly.o
libtool: compile:  g++ -DHAVE_CONFIG_H -I./.. -pthread -I/usr/include -std=gnu++1y -g -O2 -MT Poly.lo -MD -MP -MF .deps/Poly.Tpo -c Poly.cpp -o Poly.o >/dev/null 2>&1
/bin/bash ./libtool  --tag=CXX   --mode=link g++  -std=gnu++1y -g -O2 -lboost_context -lboost_program_options -lboost_thread -lboost_filesystem -lboost_system -lboost_regex -lpthread -lboost_chrono  -lssl -lcrypto -version-info 57:0:0 -lssl -lunwind  -o libfolly.la -rpath /usr/local/lib ClockGettimeWrappers.lo compression/Compression.lo compression/Zlib.lo concurrency/CacheLocality.lo detail/AtFork.lo detail/Futex.lo detail/IPAddress.lo detail/StaticSingletonManager.lo detail/ThreadLocalDetail.lo dynamic.lo ExceptionWrapper.lo Executor.lo Expected.lo File.lo FileUtil.lo FingerprintTables.lo futures/Barrier.lo futures/Future.lo futures/FutureException.lo futures/ThreadWheelTimekeeper.lo futures/test/TestExecutor.lo executors/CPUThreadPoolExecutor.lo executors/Codel.lo executors/GlobalExecutor.lo executors/GlobalThreadPoolList.lo executors/IOThreadPoolExecutor.lo executors/InlineExecutor.lo executors/ManualExecutor.lo executors/SerialExecutor.lo executors/ThreadPoolExecutor.lo executors/ThreadedExecutor.lo executors/QueuedImmediateExecutor.lo experimental/hazptr/hazptr.lo experimental/hazptr/memory_resource.lo GroupVarint.lo GroupVarintTables.lo hash/Checksum.lo hash/SpookyHashV1.lo hash/SpookyHashV2.lo IPAddress.lo IPAddressV4.lo IPAddressV6.lo init/Init.lo io/Cursor.lo io/IOBuf.lo io/IOBufQueue.lo io/RecordIO.lo io/ShutdownSocketSet.lo io/async/AsyncPipe.lo io/async/AsyncTimeout.lo io/async/AsyncUDPSocket.lo io/async/AsyncServerSocket.lo io/async/AsyncSignalHandler.lo io/async/AsyncSocket.lo io/async/AsyncSocketException.lo io/async/AsyncSSLSocket.lo io/async/EventBase.lo io/async/EventBaseLocal.lo io/async/EventBaseManager.lo io/async/EventBaseThread.lo io/async/EventHandler.lo io/async/Request.lo io/async/SSLContext.lo io/async/SSLOptions.lo io/async/ScopedEventBaseThread.lo io/async/VirtualEventBase.lo io/async/HHWheelTimer.lo io/async/TimeoutManager.lo io/async/test/ScopedBoundPort.lo io/async/test/SocketPair.lo io/async/test/TimeUtil.lo io/async/ssl/OpenSSLUtils.lo io/async/ssl/SSLErrors.lo json.lo lang/Assume.lo lang/ColdClass.lo lang/SafeAssert.lo detail/MemoryIdler.lo detail/SocketFastOpen.lo MacAddress.lo memory/ThreadCachedArena.lo portability/Dirent.lo portability/Fcntl.lo portability/Libgen.lo portability/Malloc.lo portability/Memory.lo portability/OpenSSL.lo portability/PThread.lo portability/Sockets.lo portability/Stdio.lo portability/Stdlib.lo portability/String.lo portability/SysFile.lo portability/SysMembarrier.lo portability/SysMman.lo portability/SysResource.lo portability/SysStat.lo portability/SysTime.lo portability/SysUio.lo portability/Time.lo portability/Unistd.lo Random.lo ScopeGuard.lo SharedMutex.lo MicroLock.lo Optional.lo Singleton.lo SocketAddress.lo ssl/Init.lo ssl/OpenSSLCertUtils.lo ssl/OpenSSLHash.lo ssl/detail/OpenSSLThreading.lo ssl/detail/SSLSessionImpl.lo stats/BucketedTimeSeries.lo stats/Histogram.lo stats/MultiLevelTimeSeries.lo stats/TimeseriesHistogram.lo synchronization/AsymmetricMemoryBarrier.lo synchronization/LifoSem.lo synchronization/ParkingLot.lo system/MemoryMapping.lo system/Shell.lo system/ThreadName.lo system/VersionCheck.lo Subprocess.lo TimeoutQueue.lo Try.lo Uri.lo experimental/ThreadedRepeatingFunctionRunner.lo experimental/bser/Dump.lo experimental/bser/Load.lo experimental/DynamicParser.lo experimental/EnvUtil.lo experimental/FunctionScheduler.lo experimental/io/FsUtil.lo experimental/JemallocNodumpAllocator.lo experimental/JSONSchema.lo experimental/NestedCommandLineApp.lo experimental/observer/detail/Core.lo experimental/observer/detail/ObserverManager.lo experimental/ProgramOptions.lo experimental/Select64.lo experimental/TestUtil.lo experimental/io/HugePages.lo fibers/Baton.lo fibers/detail/AtomicBatchDispatcher.lo fibers/Fiber.lo fibers/FiberManager.lo fibers/FiberManagerMap.lo fibers/GuardPageAllocator.lo fibers/Semaphore.lo fibers/TimeoutController.lo experimental/symbolizer/Elf.lo experimental/symbolizer/ElfCache.lo experimental/symbolizer/Dwarf.lo experimental/symbolizer/LineReader.lo experimental/symbolizer/SignalHandler.lo experimental/symbolizer/StackTrace.lo experimental/symbolizer/Symbolizer.lo Poly.lo libfollybase.la -llzma -lz -lsnappy -llz4 -liberty -ldl -levent -ldouble-conversion -lglog -lgflags
libtool: link: g++  -fPIC -DPIC -shared -nostdlib /usr/lib/gcc/x86_64-linux-gnu/5/../../../x86_64-linux-gnu/crti.o /usr/lib/gcc/x86_64-linux-gnu/5/crtbeginS.o  .libs/ClockGettimeWrappers.o compression/.libs/Compression.o compression/.libs/Zlib.o concurrency/.libs/CacheLocality.o detail/.libs/AtFork.o detail/.libs/Futex.o detail/.libs/IPAddress.o detail/.libs/StaticSingletonManager.o detail/.libs/ThreadLocalDetail.o .libs/dynamic.o .libs/ExceptionWrapper.o .libs/Executor.o .libs/Expected.o .libs/File.o .libs/FileUtil.o .libs/FingerprintTables.o futures/.libs/Barrier.o futures/.libs/Future.o futures/.libs/FutureException.o futures/.libs/ThreadWheelTimekeeper.o futures/test/.libs/TestExecutor.o executors/.libs/CPUThreadPoolExecutor.o executors/.libs/Codel.o executors/.libs/GlobalExecutor.o executors/.libs/GlobalThreadPoolList.o executors/.libs/IOThreadPoolExecutor.o executors/.libs/InlineExecutor.o executors/.libs/ManualExecutor.o executors/.libs/SerialExecutor.o executors/.libs/ThreadPoolExecutor.o executors/.libs/ThreadedExecutor.o executors/.libs/QueuedImmediateExecutor.o experimental/hazptr/.libs/hazptr.o experimental/hazptr/.libs/memory_resource.o .libs/GroupVarint.o .libs/GroupVarintTables.o hash/.libs/Checksum.o hash/.libs/SpookyHashV1.o hash/.libs/SpookyHashV2.o .libs/IPAddress.o .libs/IPAddressV4.o .libs/IPAddressV6.o init/.libs/Init.o io/.libs/Cursor.o io/.libs/IOBuf.o io/.libs/IOBufQueue.o io/.libs/RecordIO.o io/.libs/ShutdownSocketSet.o io/async/.libs/AsyncPipe.o io/async/.libs/AsyncTimeout.o io/async/.libs/AsyncUDPSocket.o io/async/.libs/AsyncServerSocket.o io/async/.libs/AsyncSignalHandler.o io/async/.libs/AsyncSocket.o io/async/.libs/AsyncSocketException.o io/async/.libs/AsyncSSLSocket.o io/async/.libs/EventBase.o io/async/.libs/EventBaseLocal.o io/async/.libs/EventBaseManager.o io/async/.libs/EventBaseThread.o io/async/.libs/EventHandler.o io/async/.libs/Request.o io/async/.libs/SSLContext.o io/async/.libs/SSLOptions.o io/async/.libs/ScopedEventBaseThread.o io/async/.libs/VirtualEventBase.o io/async/.libs/HHWheelTimer.o io/async/.libs/TimeoutManager.o io/async/test/.libs/ScopedBoundPort.o io/async/test/.libs/SocketPair.o io/async/test/.libs/TimeUtil.o io/async/ssl/.libs/OpenSSLUtils.o io/async/ssl/.libs/SSLErrors.o .libs/json.o lang/.libs/Assume.o lang/.libs/ColdClass.o lang/.libs/SafeAssert.o detail/.libs/MemoryIdler.o detail/.libs/SocketFastOpen.o .libs/MacAddress.o memory/.libs/ThreadCachedArena.o portability/.libs/Dirent.o portability/.libs/Fcntl.o portability/.libs/Libgen.o portability/.libs/Malloc.o portability/.libs/Memory.o portability/.libs/OpenSSL.o portability/.libs/PThread.o portability/.libs/Sockets.o portability/.libs/Stdio.o portability/.libs/Stdlib.o portability/.libs/String.o portability/.libs/SysFile.o portability/.libs/SysMembarrier.o portability/.libs/SysMman.o portability/.libs/SysResource.o portability/.libs/SysStat.o portability/.libs/SysTime.o portability/.libs/SysUio.o portability/.libs/Time.o portability/.libs/Unistd.o .libs/Random.o .libs/ScopeGuard.o .libs/SharedMutex.o .libs/MicroLock.o .libs/Optional.o .libs/Singleton.o .libs/SocketAddress.o ssl/.libs/Init.o ssl/.libs/OpenSSLCertUtils.o ssl/.libs/OpenSSLHash.o ssl/detail/.libs/OpenSSLThreading.o ssl/detail/.libs/SSLSessionImpl.o stats/.libs/BucketedTimeSeries.o stats/.libs/Histogram.o stats/.libs/MultiLevelTimeSeries.o stats/.libs/TimeseriesHistogram.o synchronization/.libs/AsymmetricMemoryBarrier.o synchronization/.libs/LifoSem.o synchronization/.libs/ParkingLot.o system/.libs/MemoryMapping.o system/.libs/Shell.o system/.libs/ThreadName.o system/.libs/VersionCheck.o .libs/Subprocess.o .libs/TimeoutQueue.o .libs/Try.o .libs/Uri.o experimental/.libs/ThreadedRepeatingFunctionRunner.o experimental/bser/.libs/Dump.o experimental/bser/.libs/Load.o experimental/.libs/DynamicParser.o experimental/.libs/EnvUtil.o experimental/.libs/FunctionScheduler.o experimental/io/.libs/FsUtil.o experimental/.libs/JemallocNodumpAllocator.o experimental/.libs/JSONSchema.o experimental/.libs/NestedCommandLineApp.o experimental/observer/detail/.libs/Core.o experimental/observer/detail/.libs/ObserverManager.o experimental/.libs/ProgramOptions.o experimental/.libs/Select64.o experimental/.libs/TestUtil.o experimental/io/.libs/HugePages.o fibers/.libs/Baton.o fibers/detail/.libs/AtomicBatchDispatcher.o fibers/.libs/Fiber.o fibers/.libs/FiberManager.o fibers/.libs/FiberManagerMap.o fibers/.libs/GuardPageAllocator.o fibers/.libs/Semaphore.o fibers/.libs/TimeoutController.o experimental/symbolizer/.libs/Elf.o experimental/symbolizer/.libs/ElfCache.o experimental/symbolizer/.libs/Dwarf.o experimental/symbolizer/.libs/LineReader.o experimental/symbolizer/.libs/SignalHandler.o experimental/symbolizer/.libs/StackTrace.o experimental/symbolizer/.libs/Symbolizer.o .libs/Poly.o  -Wl,--whole-archive ./.libs/libfollybase.a -Wl,--no-whole-archive  -lunwind -lboost_context -lboost_program_options -lboost_thread -lboost_filesystem -lboost_system -lboost_regex -lpthread -lboost_chrono -lssl -lcrypto -llzma -lz -lsnappy -llz4 -liberty -ldl -levent -ldouble-conversion -lglog -lgflags -L/usr/lib/gcc/x86_64-linux-gnu/5 -L/usr/lib/gcc/x86_64-linux-gnu/5/../../../x86_64-linux-gnu -L/usr/lib/gcc/x86_64-linux-gnu/5/../../../../lib -L/lib/x86_64-linux-gnu -L/lib/../lib -L/usr/lib/x86_64-linux-gnu -L/usr/lib/../lib -L/usr/lib/gcc/x86_64-linux-gnu/5/../../.. -lstdc++ -lm -lc -lgcc_s /usr/lib/gcc/x86_64-linux-gnu/5/crtendS.o /usr/lib/gcc/x86_64-linux-gnu/5/../../../x86_64-linux-gnu/crtn.o  -g -O2   -Wl,-soname -Wl,libfolly.so.57 -o .libs/libfolly.so.57.0.0
libtool: link: (cd ".libs" && rm -f "libfolly.so.57" && ln -s "libfolly.so.57.0.0" "libfolly.so.57")
libtool: link: (cd ".libs" && rm -f "libfolly.so" && ln -s "libfolly.so.57.0.0" "libfolly.so")
libtool: link: (cd .libs/libfolly.lax/libfollybase.a && ar x "/media/tom/document/Syn_Clode/project/folly-2018.01.08.00/folly/./.libs/libfollybase.a")
copying selected object files to avoid basename conflicts...
libtool: link: ln IPAddress.o .libs/libfolly.lax/lt1-IPAddress.o || cp IPAddress.o .libs/libfolly.lax/lt1-IPAddress.o
libtool: link: ln ssl/Init.o .libs/libfolly.lax/lt2-Init.o || cp ssl/Init.o .libs/libfolly.lax/lt2-Init.o
libtool: link: ln .libs/libfolly.lax/libfollybase.a/String.o .libs/libfolly.lax/lt3-String.o || cp .libs/libfolly.lax/libfollybase.a/String.o .libs/libfolly.lax/lt3-String.o
libtool: link: ar cru .libs/libfolly.a ClockGettimeWrappers.o compression/Compression.o compression/Zlib.o concurrency/CacheLocality.o detail/AtFork.o detail/Futex.o detail/IPAddress.o detail/StaticSingletonManager.o detail/ThreadLocalDetail.o dynamic.o ExceptionWrapper.o Executor.o Expected.o File.o FileUtil.o FingerprintTables.o futures/Barrier.o futures/Future.o futures/FutureException.o futures/ThreadWheelTimekeeper.o futures/test/TestExecutor.o executors/CPUThreadPoolExecutor.o executors/Codel.o executors/GlobalExecutor.o executors/GlobalThreadPoolList.o executors/IOThreadPoolExecutor.o executors/InlineExecutor.o executors/ManualExecutor.o executors/SerialExecutor.o executors/ThreadPoolExecutor.o executors/ThreadedExecutor.o executors/QueuedImmediateExecutor.o experimental/hazptr/hazptr.o experimental/hazptr/memory_resource.o GroupVarint.o GroupVarintTables.o hash/Checksum.o hash/SpookyHashV1.o hash/SpookyHashV2.o .libs/libfolly.lax/lt1-IPAddress.o IPAddressV4.o IPAddressV6.o init/Init.o io/Cursor.o io/IOBuf.o io/IOBufQueue.o io/RecordIO.o io/ShutdownSocketSet.o io/async/AsyncPipe.o io/async/AsyncTimeout.o io/async/AsyncUDPSocket.o io/async/AsyncServerSocket.o io/async/AsyncSignalHandler.o io/async/AsyncSocket.o io/async/AsyncSocketException.o io/async/AsyncSSLSocket.o io/async/EventBase.o io/async/EventBaseLocal.o io/async/EventBaseManager.o io/async/EventBaseThread.o io/async/EventHandler.o io/async/Request.o io/async/SSLContext.o io/async/SSLOptions.o io/async/ScopedEventBaseThread.o io/async/VirtualEventBase.o io/async/HHWheelTimer.o io/async/TimeoutManager.o io/async/test/ScopedBoundPort.o io/async/test/SocketPair.o io/async/test/TimeUtil.o io/async/ssl/OpenSSLUtils.o io/async/ssl/SSLErrors.o json.o lang/Assume.o lang/ColdClass.o lang/SafeAssert.o detail/MemoryIdler.o detail/SocketFastOpen.o MacAddress.o memory/ThreadCachedArena.o portability/Dirent.o portability/Fcntl.o portability/Libgen.o portability/Malloc.o portability/Memory.o portability/OpenSSL.o portability/PThread.o portability/Sockets.o portability/Stdio.o portability/Stdlib.o portability/String.o portability/SysFile.o portability/SysMembarrier.o portability/SysMman.o portability/SysResource.o portability/SysStat.o portability/SysTime.o portability/SysUio.o portability/Time.o portability/Unistd.o Random.o ScopeGuard.o SharedMutex.o MicroLock.o Optional.o Singleton.o SocketAddress.o .libs/libfolly.lax/lt2-Init.o ssl/OpenSSLCertUtils.o ssl/OpenSSLHash.o ssl/detail/OpenSSLThreading.o ssl/detail/SSLSessionImpl.o stats/BucketedTimeSeries.o stats/Histogram.o stats/MultiLevelTimeSeries.o stats/TimeseriesHistogram.o synchronization/AsymmetricMemoryBarrier.o synchronization/LifoSem.o synchronization/ParkingLot.o system/MemoryMapping.o system/Shell.o system/ThreadName.o system/VersionCheck.o Subprocess.o TimeoutQueue.o Try.o Uri.o experimental/ThreadedRepeatingFunctionRunner.o experimental/bser/Dump.o experimental/bser/Load.o experimental/DynamicParser.o experimental/EnvUtil.o experimental/FunctionScheduler.o experimental/io/FsUtil.o experimental/JemallocNodumpAllocator.o experimental/JSONSchema.o experimental/NestedCommandLineApp.o experimental/observer/detail/Core.o experimental/observer/detail/ObserverManager.o experimental/ProgramOptions.o experimental/Select64.o experimental/TestUtil.o experimental/io/HugePages.o fibers/Baton.o fibers/detail/AtomicBatchDispatcher.o fibers/Fiber.o fibers/FiberManager.o fibers/FiberManagerMap.o fibers/GuardPageAllocator.o fibers/Semaphore.o fibers/TimeoutController.o experimental/symbolizer/Elf.o experimental/symbolizer/ElfCache.o experimental/symbolizer/Dwarf.o experimental/symbolizer/LineReader.o experimental/symbolizer/SignalHandler.o experimental/symbolizer/StackTrace.o experimental/symbolizer/Symbolizer.o Poly.o .libs/libfolly.lax/libfollybase.a/BitsFunctexcept.o .libs/libfolly.lax/libfollybase.a/Conv.o .libs/libfolly.lax/libfollybase.a/Demangle.o .libs/libfolly.lax/libfollybase.a/EscapeTables.o .libs/libfolly.lax/libfollybase.a/Format.o .libs/libfolly.lax/libfollybase.a/FormatArg.o .libs/libfolly.lax/libfollybase.a/FormatTables.o .libs/libfolly.lax/libfollybase.a/MallctlHelper.o .libs/libfolly.lax/libfollybase.a/RangeCommon.o .libs/libfolly.lax/lt3-String.o .libs/libfolly.lax/libfollybase.a/Unicode.o .libs/libfolly.lax/libfollybase.a/libfollybasesse42_la-ChecksumDetail.o .libs/libfolly.lax/libfollybase.a/libfollybasesse42_la-Crc32cDetail.o .libs/libfolly.lax/libfollybase.a/libfollybasesse42_la-RangeSse42.o
ar: `u' modifier ignored since `D' is the default (see `U')
libtool: link: ranlib .libs/libfolly.a
libtool: link: rm -fr .libs/libfolly.lax .libs/libfolly.lax
libtool: link: ( cd ".libs" && rm -f "libfolly.la" && ln -s "../libfolly.la" "libfolly.la" )
depbase=`echo Benchmark.lo | sed 's|[^/]*$|.deps/&|;s|\.lo$||'`;\
/bin/bash ./libtool  --tag=CXX   --mode=compile g++ -DHAVE_CONFIG_H   -I./.. -pthread -I/usr/include    -std=gnu++1y -g -O2 -MT Benchmark.lo -MD -MP -MF $depbase.Tpo -c -o Benchmark.lo Benchmark.cpp &&\
mv -f $depbase.Tpo $depbase.Plo
libtool: compile:  g++ -DHAVE_CONFIG_H -I./.. -pthread -I/usr/include -std=gnu++1y -g -O2 -MT Benchmark.lo -MD -MP -MF .deps/Benchmark.Tpo -c Benchmark.cpp  -fPIC -DPIC -o .libs/Benchmark.o
libtool: compile:  g++ -DHAVE_CONFIG_H -I./.. -pthread -I/usr/include -std=gnu++1y -g -O2 -MT Benchmark.lo -MD -MP -MF .deps/Benchmark.Tpo -c Benchmark.cpp -o Benchmark.o >/dev/null 2>&1
/bin/bash ./libtool  --tag=CXX   --mode=link g++  -std=gnu++1y -g -O2 -lboost_context -lboost_program_options -lboost_thread -lboost_filesystem -lboost_system -lboost_regex -lpthread -lboost_chrono  -lssl -lcrypto -version-info 57:0:0  -o libfollybenchmark.la -rpath /usr/local/lib Benchmark.lo libfolly.la -llzma -lz -lsnappy -llz4 -liberty -ldl -levent -ldouble-conversion -lglog -lgflags
libtool: link: g++  -fPIC -DPIC -shared -nostdlib /usr/lib/gcc/x86_64-linux-gnu/5/../../../x86_64-linux-gnu/crti.o /usr/lib/gcc/x86_64-linux-gnu/5/crtbeginS.o  .libs/Benchmark.o   -Wl,-rpath -Wl,/media/tom/document/Syn_Clode/project/folly-2018.01.08.00/folly/.libs -lboost_context -lboost_program_options -lboost_thread -lboost_filesystem -lboost_system -lboost_regex -lpthread -lboost_chrono -lssl -lcrypto ./.libs/libfolly.so -llzma -lz -lsnappy -llz4 -liberty -ldl -levent -ldouble-conversion -lglog -lgflags -L/usr/lib/gcc/x86_64-linux-gnu/5 -L/usr/lib/gcc/x86_64-linux-gnu/5/../../../x86_64-linux-gnu -L/usr/lib/gcc/x86_64-linux-gnu/5/../../../../lib -L/lib/x86_64-linux-gnu -L/lib/../lib -L/usr/lib/x86_64-linux-gnu -L/usr/lib/../lib -L/usr/lib/gcc/x86_64-linux-gnu/5/../../.. -lstdc++ -lm -lc -lgcc_s /usr/lib/gcc/x86_64-linux-gnu/5/crtendS.o /usr/lib/gcc/x86_64-linux-gnu/5/../../../x86_64-linux-gnu/crtn.o  -g -O2   -Wl,-soname -Wl,libfollybenchmark.so.57 -o .libs/libfollybenchmark.so.57.0.0
libtool: link: (cd ".libs" && rm -f "libfollybenchmark.so.57" && ln -s "libfollybenchmark.so.57.0.0" "libfollybenchmark.so.57")
libtool: link: (cd ".libs" && rm -f "libfollybenchmark.so" && ln -s "libfollybenchmark.so.57.0.0" "libfollybenchmark.so")
libtool: link: ar cru .libs/libfollybenchmark.a  Benchmark.o
ar: `u' modifier ignored since `D' is the default (see `U')
libtool: link: ranlib .libs/libfollybenchmark.a
libtool: link: ( cd ".libs" && rm -f "libfollybenchmark.la" && ln -s "../libfollybenchmark.la" "libfollybenchmark.la" )
make[2]: Leaving directory '/media/tom/document/Syn_Clode/project/folly-2018.01.08.00/folly'
Making all in test
make[2]: Entering directory '/media/tom/document/Syn_Clode/project/folly-2018.01.08.00/folly/test'
Making all in .
make[3]: Entering directory '/media/tom/document/Syn_Clode/project/folly-2018.01.08.00/folly/test'
/bin/bash ../libtool  --tag=CXX   --mode=compile g++ -DHAVE_CONFIG_H   -I../.. -pthread -I/usr/include  -isystem gtest/googletest/include -isystem gtest/googlemock/include  -std=gnu++1y -g -O2 -MT thread_local_test_lib_la-ThreadLocalTestLib.lo -MD -MP -MF .deps/thread_local_test_lib_la-ThreadLocalTestLib.Tpo -c -o thread_local_test_lib_la-ThreadLocalTestLib.lo `test -f 'ThreadLocalTestLib.cpp' || echo './'`ThreadLocalTestLib.cpp
libtool: compile:  g++ -DHAVE_CONFIG_H -I../.. -pthread -I/usr/include -isystem gtest/googletest/include -isystem gtest/googlemock/include -std=gnu++1y -g -O2 -MT thread_local_test_lib_la-ThreadLocalTestLib.lo -MD -MP -MF .deps/thread_local_test_lib_la-ThreadLocalTestLib.Tpo -c ThreadLocalTestLib.cpp  -fPIC -DPIC -o .libs/thread_local_test_lib_la-ThreadLocalTestLib.o
libtool: compile:  g++ -DHAVE_CONFIG_H -I../.. -pthread -I/usr/include -isystem gtest/googletest/include -isystem gtest/googlemock/include -std=gnu++1y -g -O2 -MT thread_local_test_lib_la-ThreadLocalTestLib.lo -MD -MP -MF .deps/thread_local_test_lib_la-ThreadLocalTestLib.Tpo -c ThreadLocalTestLib.cpp -o thread_local_test_lib_la-ThreadLocalTestLib.o >/dev/null 2>&1
mv -f .deps/thread_local_test_lib_la-ThreadLocalTestLib.Tpo .deps/thread_local_test_lib_la-ThreadLocalTestLib.Plo
/bin/bash ../libtool  --tag=CXX   --mode=link g++  -std=gnu++1y -g -O2 -module -rpath /force_shared  -o thread_local_test_lib.la  thread_local_test_lib_la-ThreadLocalTestLib.lo ../libfolly.la -llzma -lz -lsnappy -llz4 -liberty -ldl -levent -ldouble-conversion -lglog -lgflags
libtool: link: g++  -fPIC -DPIC -shared -nostdlib /usr/lib/gcc/x86_64-linux-gnu/5/../../../x86_64-linux-gnu/crti.o /usr/lib/gcc/x86_64-linux-gnu/5/crtbeginS.o  .libs/thread_local_test_lib_la-ThreadLocalTestLib.o   -Wl,-rpath -Wl,/media/tom/document/Syn_Clode/project/folly-2018.01.08.00/folly/.libs ../.libs/libfolly.so -llzma -lz -lsnappy -llz4 -liberty -ldl -levent -ldouble-conversion -lglog -lgflags -L/usr/lib/gcc/x86_64-linux-gnu/5 -L/usr/lib/gcc/x86_64-linux-gnu/5/../../../x86_64-linux-gnu -L/usr/lib/gcc/x86_64-linux-gnu/5/../../../../lib -L/lib/x86_64-linux-gnu -L/lib/../lib -L/usr/lib/x86_64-linux-gnu -L/usr/lib/../lib -L/usr/lib/gcc/x86_64-linux-gnu/5/../../.. -lstdc++ -lm -lc -lgcc_s /usr/lib/gcc/x86_64-linux-gnu/5/crtendS.o /usr/lib/gcc/x86_64-linux-gnu/5/../../../x86_64-linux-gnu/crtn.o  -g -O2   -Wl,-soname -Wl,thread_local_test_lib.so.0 -o .libs/thread_local_test_lib.so.0.0.0
libtool: link: (cd ".libs" && rm -f "thread_local_test_lib.so.0" && ln -s "thread_local_test_lib.so.0.0.0" "thread_local_test_lib.so.0")
libtool: link: (cd ".libs" && rm -f "thread_local_test_lib.so" && ln -s "thread_local_test_lib.so.0.0.0" "thread_local_test_lib.so")
libtool: link: ar cru .libs/thread_local_test_lib.a  thread_local_test_lib_la-ThreadLocalTestLib.o
ar: `u' modifier ignored since `D' is the default (see `U')
libtool: link: ranlib .libs/thread_local_test_lib.a
libtool: link: ( cd ".libs" && rm -f "thread_local_test_lib.la" && ln -s "../thread_local_test_lib.la" "thread_local_test_lib.la" )
make[3]: Leaving directory '/media/tom/document/Syn_Clode/project/folly-2018.01.08.00/folly/test'
Making all in function_benchmark
make[3]: Entering directory '/media/tom/document/Syn_Clode/project/folly-2018.01.08.00/folly/test/function_benchmark'
make[3]: Nothing to be done for 'all'.
make[3]: Leaving directory '/media/tom/document/Syn_Clode/project/folly-2018.01.08.00/folly/test/function_benchmark'
make[2]: Leaving directory '/media/tom/document/Syn_Clode/project/folly-2018.01.08.00/folly/test'
Making all in experimental
make[2]: Entering directory '/media/tom/document/Syn_Clode/project/folly-2018.01.08.00/folly/experimental'
Making all in io/test
make[3]: Entering directory '/media/tom/document/Syn_Clode/project/folly-2018.01.08.00/folly/experimental/io/test'
make[3]: Nothing to be done for 'all'.
make[3]: Leaving directory '/media/tom/document/Syn_Clode/project/folly-2018.01.08.00/folly/experimental/io/test'
Making all in logging
make[3]: Entering directory '/media/tom/document/Syn_Clode/project/folly-2018.01.08.00/folly/experimental/logging'
Making all in .
make[4]: Entering directory '/media/tom/document/Syn_Clode/project/folly-2018.01.08.00/folly/experimental/logging'
depbase=`echo AsyncFileWriter.lo | sed 's|[^/]*$|.deps/&|;s|\.lo$||'`;\
/bin/bash ../../libtool  --tag=CXX   --mode=compile g++ -DHAVE_CONFIG_H   -I../../.. -pthread -I/usr/include    -std=gnu++1y -g -O2 -MT AsyncFileWriter.lo -MD -MP -MF $depbase.Tpo -c -o AsyncFileWriter.lo AsyncFileWriter.cpp &&\
mv -f $depbase.Tpo $depbase.Plo
libtool: compile:  g++ -DHAVE_CONFIG_H -I../../.. -pthread -I/usr/include -std=gnu++1y -g -O2 -MT AsyncFileWriter.lo -MD -MP -MF .deps/AsyncFileWriter.Tpo -c AsyncFileWriter.cpp  -fPIC -DPIC -o .libs/AsyncFileWriter.o
libtool: compile:  g++ -DHAVE_CONFIG_H -I../../.. -pthread -I/usr/include -std=gnu++1y -g -O2 -MT AsyncFileWriter.lo -MD -MP -MF .deps/AsyncFileWriter.Tpo -c AsyncFileWriter.cpp -o AsyncFileWriter.o >/dev/null 2>&1
depbase=`echo FileHandlerFactory.lo | sed 's|[^/]*$|.deps/&|;s|\.lo$||'`;\
/bin/bash ../../libtool  --tag=CXX   --mode=compile g++ -DHAVE_CONFIG_H   -I../../.. -pthread -I/usr/include    -std=gnu++1y -g -O2 -MT FileHandlerFactory.lo -MD -MP -MF $depbase.Tpo -c -o FileHandlerFactory.lo FileHandlerFactory.cpp &&\
mv -f $depbase.Tpo $depbase.Plo
libtool: compile:  g++ -DHAVE_CONFIG_H -I../../.. -pthread -I/usr/include -std=gnu++1y -g -O2 -MT FileHandlerFactory.lo -MD -MP -MF .deps/FileHandlerFactory.Tpo -c FileHandlerFactory.cpp  -fPIC -DPIC -o .libs/FileHandlerFactory.o
libtool: compile:  g++ -DHAVE_CONFIG_H -I../../.. -pthread -I/usr/include -std=gnu++1y -g -O2 -MT FileHandlerFactory.lo -MD -MP -MF .deps/FileHandlerFactory.Tpo -c FileHandlerFactory.cpp -o FileHandlerFactory.o >/dev/null 2>&1
depbase=`echo FileWriterFactory.lo | sed 's|[^/]*$|.deps/&|;s|\.lo$||'`;\
/bin/bash ../../libtool  --tag=CXX   --mode=compile g++ -DHAVE_CONFIG_H   -I../../.. -pthread -I/usr/include    -std=gnu++1y -g -O2 -MT FileWriterFactory.lo -MD -MP -MF $depbase.Tpo -c -o FileWriterFactory.lo FileWriterFactory.cpp &&\
mv -f $depbase.Tpo $depbase.Plo
libtool: compile:  g++ -DHAVE_CONFIG_H -I../../.. -pthread -I/usr/include -std=gnu++1y -g -O2 -MT FileWriterFactory.lo -MD -MP -MF .deps/FileWriterFactory.Tpo -c FileWriterFactory.cpp  -fPIC -DPIC -o .libs/FileWriterFactory.o
libtool: compile:  g++ -DHAVE_CONFIG_H -I../../.. -pthread -I/usr/include -std=gnu++1y -g -O2 -MT FileWriterFactory.lo -MD -MP -MF .deps/FileWriterFactory.Tpo -c FileWriterFactory.cpp -o FileWriterFactory.o >/dev/null 2>&1
depbase=`echo GlogStyleFormatter.lo | sed 's|[^/]*$|.deps/&|;s|\.lo$||'`;\
/bin/bash ../../libtool  --tag=CXX   --mode=compile g++ -DHAVE_CONFIG_H   -I../../.. -pthread -I/usr/include    -std=gnu++1y -g -O2 -MT GlogStyleFormatter.lo -MD -MP -MF $depbase.Tpo -c -o GlogStyleFormatter.lo GlogStyleFormatter.cpp &&\
mv -f $depbase.Tpo $depbase.Plo
libtool: compile:  g++ -DHAVE_CONFIG_H -I../../.. -pthread -I/usr/include -std=gnu++1y -g -O2 -MT GlogStyleFormatter.lo -MD -MP -MF .deps/GlogStyleFormatter.Tpo -c GlogStyleFormatter.cpp  -fPIC -DPIC -o .libs/GlogStyleFormatter.o
libtool: compile:  g++ -DHAVE_CONFIG_H -I../../.. -pthread -I/usr/include -std=gnu++1y -g -O2 -MT GlogStyleFormatter.lo -MD -MP -MF .deps/GlogStyleFormatter.Tpo -c GlogStyleFormatter.cpp -o GlogStyleFormatter.o >/dev/null 2>&1
depbase=`echo ImmediateFileWriter.lo | sed 's|[^/]*$|.deps/&|;s|\.lo$||'`;\
/bin/bash ../../libtool  --tag=CXX   --mode=compile g++ -DHAVE_CONFIG_H   -I../../.. -pthread -I/usr/include    -std=gnu++1y -g -O2 -MT ImmediateFileWriter.lo -MD -MP -MF $depbase.Tpo -c -o ImmediateFileWriter.lo ImmediateFileWriter.cpp &&\
mv -f $depbase.Tpo $depbase.Plo
libtool: compile:  g++ -DHAVE_CONFIG_H -I../../.. -pthread -I/usr/include -std=gnu++1y -g -O2 -MT ImmediateFileWriter.lo -MD -MP -MF .deps/ImmediateFileWriter.Tpo -c ImmediateFileWriter.cpp  -fPIC -DPIC -o .libs/ImmediateFileWriter.o
libtool: compile:  g++ -DHAVE_CONFIG_H -I../../.. -pthread -I/usr/include -std=gnu++1y -g -O2 -MT ImmediateFileWriter.lo -MD -MP -MF .deps/ImmediateFileWriter.Tpo -c ImmediateFileWriter.cpp -o ImmediateFileWriter.o >/dev/null 2>&1
depbase=`echo Init.lo | sed 's|[^/]*$|.deps/&|;s|\.lo$||'`;\
/bin/bash ../../libtool  --tag=CXX   --mode=compile g++ -DHAVE_CONFIG_H   -I../../.. -pthread -I/usr/include    -std=gnu++1y -g -O2 -MT Init.lo -MD -MP -MF $depbase.Tpo -c -o Init.lo Init.cpp &&\
mv -f $depbase.Tpo $depbase.Plo
libtool: compile:  g++ -DHAVE_CONFIG_H -I../../.. -pthread -I/usr/include -std=gnu++1y -g -O2 -MT Init.lo -MD -MP -MF .deps/Init.Tpo -c Init.cpp  -fPIC -DPIC -o .libs/Init.o
libtool: compile:  g++ -DHAVE_CONFIG_H -I../../.. -pthread -I/usr/include -std=gnu++1y -g -O2 -MT Init.lo -MD -MP -MF .deps/Init.Tpo -c Init.cpp -o Init.o >/dev/null 2>&1
depbase=`echo LogCategory.lo | sed 's|[^/]*$|.deps/&|;s|\.lo$||'`;\
/bin/bash ../../libtool  --tag=CXX   --mode=compile g++ -DHAVE_CONFIG_H   -I../../.. -pthread -I/usr/include    -std=gnu++1y -g -O2 -MT LogCategory.lo -MD -MP -MF $depbase.Tpo -c -o LogCategory.lo LogCategory.cpp &&\
mv -f $depbase.Tpo $depbase.Plo
libtool: compile:  g++ -DHAVE_CONFIG_H -I../../.. -pthread -I/usr/include -std=gnu++1y -g -O2 -MT LogCategory.lo -MD -MP -MF .deps/LogCategory.Tpo -c LogCategory.cpp  -fPIC -DPIC -o .libs/LogCategory.o
libtool: compile:  g++ -DHAVE_CONFIG_H -I../../.. -pthread -I/usr/include -std=gnu++1y -g -O2 -MT LogCategory.lo -MD -MP -MF .deps/LogCategory.Tpo -c LogCategory.cpp -o LogCategory.o >/dev/null 2>&1
depbase=`echo LogCategoryConfig.lo | sed 's|[^/]*$|.deps/&|;s|\.lo$||'`;\
/bin/bash ../../libtool  --tag=CXX   --mode=compile g++ -DHAVE_CONFIG_H   -I../../.. -pthread -I/usr/include    -std=gnu++1y -g -O2 -MT LogCategoryConfig.lo -MD -MP -MF $depbase.Tpo -c -o LogCategoryConfig.lo LogCategoryConfig.cpp &&\
mv -f $depbase.Tpo $depbase.Plo
libtool: compile:  g++ -DHAVE_CONFIG_H -I../../.. -pthread -I/usr/include -std=gnu++1y -g -O2 -MT LogCategoryConfig.lo -MD -MP -MF .deps/LogCategoryConfig.Tpo -c LogCategoryConfig.cpp  -fPIC -DPIC -o .libs/LogCategoryConfig.o
libtool: compile:  g++ -DHAVE_CONFIG_H -I../../.. -pthread -I/usr/include -std=gnu++1y -g -O2 -MT LogCategoryConfig.lo -MD -MP -MF .deps/LogCategoryConfig.Tpo -c LogCategoryConfig.cpp -o LogCategoryConfig.o >/dev/null 2>&1
depbase=`echo LogConfig.lo | sed 's|[^/]*$|.deps/&|;s|\.lo$||'`;\
/bin/bash ../../libtool  --tag=CXX   --mode=compile g++ -DHAVE_CONFIG_H   -I../../.. -pthread -I/usr/include    -std=gnu++1y -g -O2 -MT LogConfig.lo -MD -MP -MF $depbase.Tpo -c -o LogConfig.lo LogConfig.cpp &&\
mv -f $depbase.Tpo $depbase.Plo
libtool: compile:  g++ -DHAVE_CONFIG_H -I../../.. -pthread -I/usr/include -std=gnu++1y -g -O2 -MT LogConfig.lo -MD -MP -MF .deps/LogConfig.Tpo -c LogConfig.cpp  -fPIC -DPIC -o .libs/LogConfig.o
libtool: compile:  g++ -DHAVE_CONFIG_H -I../../.. -pthread -I/usr/include -std=gnu++1y -g -O2 -MT LogConfig.lo -MD -MP -MF .deps/LogConfig.Tpo -c LogConfig.cpp -o LogConfig.o >/dev/null 2>&1
depbase=`echo LogConfigParser.lo | sed 's|[^/]*$|.deps/&|;s|\.lo$||'`;\
/bin/bash ../../libtool  --tag=CXX   --mode=compile g++ -DHAVE_CONFIG_H   -I../../.. -pthread -I/usr/include    -std=gnu++1y -g -O2 -MT LogConfigParser.lo -MD -MP -MF $depbase.Tpo -c -o LogConfigParser.lo LogConfigParser.cpp &&\
mv -f $depbase.Tpo $depbase.Plo
libtool: compile:  g++ -DHAVE_CONFIG_H -I../../.. -pthread -I/usr/include -std=gnu++1y -g -O2 -MT LogConfigParser.lo -MD -MP -MF .deps/LogConfigParser.Tpo -c LogConfigParser.cpp  -fPIC -DPIC -o .libs/LogConfigParser.o
libtool: compile:  g++ -DHAVE_CONFIG_H -I../../.. -pthread -I/usr/include -std=gnu++1y -g -O2 -MT LogConfigParser.lo -MD -MP -MF .deps/LogConfigParser.Tpo -c LogConfigParser.cpp -o LogConfigParser.o >/dev/null 2>&1
depbase=`echo Logger.lo | sed 's|[^/]*$|.deps/&|;s|\.lo$||'`;\
/bin/bash ../../libtool  --tag=CXX   --mode=compile g++ -DHAVE_CONFIG_H   -I../../.. -pthread -I/usr/include    -std=gnu++1y -g -O2 -MT Logger.lo -MD -MP -MF $depbase.Tpo -c -o Logger.lo Logger.cpp &&\
mv -f $depbase.Tpo $depbase.Plo
libtool: compile:  g++ -DHAVE_CONFIG_H -I../../.. -pthread -I/usr/include -std=gnu++1y -g -O2 -MT Logger.lo -MD -MP -MF .deps/Logger.Tpo -c Logger.cpp  -fPIC -DPIC -o .libs/Logger.o
libtool: compile:  g++ -DHAVE_CONFIG_H -I../../.. -pthread -I/usr/include -std=gnu++1y -g -O2 -MT Logger.lo -MD -MP -MF .deps/Logger.Tpo -c Logger.cpp -o Logger.o >/dev/null 2>&1
depbase=`echo LoggerDB.lo | sed 's|[^/]*$|.deps/&|;s|\.lo$||'`;\
/bin/bash ../../libtool  --tag=CXX   --mode=compile g++ -DHAVE_CONFIG_H   -I../../.. -pthread -I/usr/include    -std=gnu++1y -g -O2 -MT LoggerDB.lo -MD -MP -MF $depbase.Tpo -c -o LoggerDB.lo LoggerDB.cpp &&\
mv -f $depbase.Tpo $depbase.Plo
libtool: compile:  g++ -DHAVE_CONFIG_H -I../../.. -pthread -I/usr/include -std=gnu++1y -g -O2 -MT LoggerDB.lo -MD -MP -MF .deps/LoggerDB.Tpo -c LoggerDB.cpp  -fPIC -DPIC -o .libs/LoggerDB.o
libtool: compile:  g++ -DHAVE_CONFIG_H -I../../.. -pthread -I/usr/include -std=gnu++1y -g -O2 -MT LoggerDB.lo -MD -MP -MF .deps/LoggerDB.Tpo -c LoggerDB.cpp -o LoggerDB.o >/dev/null 2>&1
depbase=`echo LogHandlerConfig.lo | sed 's|[^/]*$|.deps/&|;s|\.lo$||'`;\
/bin/bash ../../libtool  --tag=CXX   --mode=compile g++ -DHAVE_CONFIG_H   -I../../.. -pthread -I/usr/include    -std=gnu++1y -g -O2 -MT LogHandlerConfig.lo -MD -MP -MF $depbase.Tpo -c -o LogHandlerConfig.lo LogHandlerConfig.cpp &&\
mv -f $depbase.Tpo $depbase.Plo
libtool: compile:  g++ -DHAVE_CONFIG_H -I../../.. -pthread -I/usr/include -std=gnu++1y -g -O2 -MT LogHandlerConfig.lo -MD -MP -MF .deps/LogHandlerConfig.Tpo -c LogHandlerConfig.cpp  -fPIC -DPIC -o .libs/LogHandlerConfig.o
libtool: compile:  g++ -DHAVE_CONFIG_H -I../../.. -pthread -I/usr/include -std=gnu++1y -g -O2 -MT LogHandlerConfig.lo -MD -MP -MF .deps/LogHandlerConfig.Tpo -c LogHandlerConfig.cpp -o LogHandlerConfig.o >/dev/null 2>&1
depbase=`echo LogLevel.lo | sed 's|[^/]*$|.deps/&|;s|\.lo$||'`;\
/bin/bash ../../libtool  --tag=CXX   --mode=compile g++ -DHAVE_CONFIG_H   -I../../.. -pthread -I/usr/include    -std=gnu++1y -g -O2 -MT LogLevel.lo -MD -MP -MF $depbase.Tpo -c -o LogLevel.lo LogLevel.cpp &&\
mv -f $depbase.Tpo $depbase.Plo
libtool: compile:  g++ -DHAVE_CONFIG_H -I../../.. -pthread -I/usr/include -std=gnu++1y -g -O2 -MT LogLevel.lo -MD -MP -MF .deps/LogLevel.Tpo -c LogLevel.cpp  -fPIC -DPIC -o .libs/LogLevel.o
libtool: compile:  g++ -DHAVE_CONFIG_H -I../../.. -pthread -I/usr/include -std=gnu++1y -g -O2 -MT LogLevel.lo -MD -MP -MF .deps/LogLevel.Tpo -c LogLevel.cpp -o LogLevel.o >/dev/null 2>&1
depbase=`echo LogMessage.lo | sed 's|[^/]*$|.deps/&|;s|\.lo$||'`;\
/bin/bash ../../libtool  --tag=CXX   --mode=compile g++ -DHAVE_CONFIG_H   -I../../.. -pthread -I/usr/include    -std=gnu++1y -g -O2 -MT LogMessage.lo -MD -MP -MF $depbase.Tpo -c -o LogMessage.lo LogMessage.cpp &&\
mv -f $depbase.Tpo $depbase.Plo
libtool: compile:  g++ -DHAVE_CONFIG_H -I../../.. -pthread -I/usr/include -std=gnu++1y -g -O2 -MT LogMessage.lo -MD -MP -MF .deps/LogMessage.Tpo -c LogMessage.cpp  -fPIC -DPIC -o .libs/LogMessage.o
libtool: compile:  g++ -DHAVE_CONFIG_H -I../../.. -pthread -I/usr/include -std=gnu++1y -g -O2 -MT LogMessage.lo -MD -MP -MF .deps/LogMessage.Tpo -c LogMessage.cpp -o LogMessage.o >/dev/null 2>&1
depbase=`echo LogName.lo | sed 's|[^/]*$|.deps/&|;s|\.lo$||'`;\
/bin/bash ../../libtool  --tag=CXX   --mode=compile g++ -DHAVE_CONFIG_H   -I../../.. -pthread -I/usr/include    -std=gnu++1y -g -O2 -MT LogName.lo -MD -MP -MF $depbase.Tpo -c -o LogName.lo LogName.cpp &&\
mv -f $depbase.Tpo $depbase.Plo
libtool: compile:  g++ -DHAVE_CONFIG_H -I../../.. -pthread -I/usr/include -std=gnu++1y -g -O2 -MT LogName.lo -MD -MP -MF .deps/LogName.Tpo -c LogName.cpp  -fPIC -DPIC -o .libs/LogName.o
libtool: compile:  g++ -DHAVE_CONFIG_H -I../../.. -pthread -I/usr/include -std=gnu++1y -g -O2 -MT LogName.lo -MD -MP -MF .deps/LogName.Tpo -c LogName.cpp -o LogName.o >/dev/null 2>&1
depbase=`echo LogStream.lo | sed 's|[^/]*$|.deps/&|;s|\.lo$||'`;\
/bin/bash ../../libtool  --tag=CXX   --mode=compile g++ -DHAVE_CONFIG_H   -I../../.. -pthread -I/usr/include    -std=gnu++1y -g -O2 -MT LogStream.lo -MD -MP -MF $depbase.Tpo -c -o LogStream.lo LogStream.cpp &&\
mv -f $depbase.Tpo $depbase.Plo
libtool: compile:  g++ -DHAVE_CONFIG_H -I../../.. -pthread -I/usr/include -std=gnu++1y -g -O2 -MT LogStream.lo -MD -MP -MF .deps/LogStream.Tpo -c LogStream.cpp  -fPIC -DPIC -o .libs/LogStream.o
libtool: compile:  g++ -DHAVE_CONFIG_H -I../../.. -pthread -I/usr/include -std=gnu++1y -g -O2 -MT LogStream.lo -MD -MP -MF .deps/LogStream.Tpo -c LogStream.cpp -o LogStream.o >/dev/null 2>&1
depbase=`echo LogStreamProcessor.lo | sed 's|[^/]*$|.deps/&|;s|\.lo$||'`;\
/bin/bash ../../libtool  --tag=CXX   --mode=compile g++ -DHAVE_CONFIG_H   -I../../.. -pthread -I/usr/include    -std=gnu++1y -g -O2 -MT LogStreamProcessor.lo -MD -MP -MF $depbase.Tpo -c -o LogStreamProcessor.lo LogStreamProcessor.cpp &&\
mv -f $depbase.Tpo $depbase.Plo
libtool: compile:  g++ -DHAVE_CONFIG_H -I../../.. -pthread -I/usr/include -std=gnu++1y -g -O2 -MT LogStreamProcessor.lo -MD -MP -MF .deps/LogStreamProcessor.Tpo -c LogStreamProcessor.cpp  -fPIC -DPIC -o .libs/LogStreamProcessor.o
libtool: compile:  g++ -DHAVE_CONFIG_H -I../../.. -pthread -I/usr/include -std=gnu++1y -g -O2 -MT LogStreamProcessor.lo -MD -MP -MF .deps/LogStreamProcessor.Tpo -c LogStreamProcessor.cpp -o LogStreamProcessor.o >/dev/null 2>&1
depbase=`echo printf.lo | sed 's|[^/]*$|.deps/&|;s|\.lo$||'`;\
/bin/bash ../../libtool  --tag=CXX   --mode=compile g++ -DHAVE_CONFIG_H   -I../../.. -pthread -I/usr/include    -std=gnu++1y -g -O2 -MT printf.lo -MD -MP -MF $depbase.Tpo -c -o printf.lo printf.cpp &&\
mv -f $depbase.Tpo $depbase.Plo
libtool: compile:  g++ -DHAVE_CONFIG_H -I../../.. -pthread -I/usr/include -std=gnu++1y -g -O2 -MT printf.lo -MD -MP -MF .deps/printf.Tpo -c printf.cpp  -fPIC -DPIC -o .libs/printf.o
libtool: compile:  g++ -DHAVE_CONFIG_H -I../../.. -pthread -I/usr/include -std=gnu++1y -g -O2 -MT printf.lo -MD -MP -MF .deps/printf.Tpo -c printf.cpp -o printf.o >/dev/null 2>&1
depbase=`echo RateLimiter.lo | sed 's|[^/]*$|.deps/&|;s|\.lo$||'`;\
/bin/bash ../../libtool  --tag=CXX   --mode=compile g++ -DHAVE_CONFIG_H   -I../../.. -pthread -I/usr/include    -std=gnu++1y -g -O2 -MT RateLimiter.lo -MD -MP -MF $depbase.Tpo -c -o RateLimiter.lo RateLimiter.cpp &&\
mv -f $depbase.Tpo $depbase.Plo
libtool: compile:  g++ -DHAVE_CONFIG_H -I../../.. -pthread -I/usr/include -std=gnu++1y -g -O2 -MT RateLimiter.lo -MD -MP -MF .deps/RateLimiter.Tpo -c RateLimiter.cpp  -fPIC -DPIC -o .libs/RateLimiter.o
libtool: compile:  g++ -DHAVE_CONFIG_H -I../../.. -pthread -I/usr/include -std=gnu++1y -g -O2 -MT RateLimiter.lo -MD -MP -MF .deps/RateLimiter.Tpo -c RateLimiter.cpp -o RateLimiter.o >/dev/null 2>&1
depbase=`echo StandardLogHandler.lo | sed 's|[^/]*$|.deps/&|;s|\.lo$||'`;\
/bin/bash ../../libtool  --tag=CXX   --mode=compile g++ -DHAVE_CONFIG_H   -I../../.. -pthread -I/usr/include    -std=gnu++1y -g -O2 -MT StandardLogHandler.lo -MD -MP -MF $depbase.Tpo -c -o StandardLogHandler.lo StandardLogHandler.cpp &&\
mv -f $depbase.Tpo $depbase.Plo
libtool: compile:  g++ -DHAVE_CONFIG_H -I../../.. -pthread -I/usr/include -std=gnu++1y -g -O2 -MT StandardLogHandler.lo -MD -MP -MF .deps/StandardLogHandler.Tpo -c StandardLogHandler.cpp  -fPIC -DPIC -o .libs/StandardLogHandler.o
libtool: compile:  g++ -DHAVE_CONFIG_H -I../../.. -pthread -I/usr/include -std=gnu++1y -g -O2 -MT StandardLogHandler.lo -MD -MP -MF .deps/StandardLogHandler.Tpo -c StandardLogHandler.cpp -o StandardLogHandler.o >/dev/null 2>&1
depbase=`echo StandardLogHandlerFactory.lo | sed 's|[^/]*$|.deps/&|;s|\.lo$||'`;\
/bin/bash ../../libtool  --tag=CXX   --mode=compile g++ -DHAVE_CONFIG_H   -I../../.. -pthread -I/usr/include    -std=gnu++1y -g -O2 -MT StandardLogHandlerFactory.lo -MD -MP -MF $depbase.Tpo -c -o StandardLogHandlerFactory.lo StandardLogHandlerFactory.cpp &&\
mv -f $depbase.Tpo $depbase.Plo
libtool: compile:  g++ -DHAVE_CONFIG_H -I../../.. -pthread -I/usr/include -std=gnu++1y -g -O2 -MT StandardLogHandlerFactory.lo -MD -MP -MF .deps/StandardLogHandlerFactory.Tpo -c StandardLogHandlerFactory.cpp  -fPIC -DPIC -o .libs/StandardLogHandlerFactory.o
libtool: compile:  g++ -DHAVE_CONFIG_H -I../../.. -pthread -I/usr/include -std=gnu++1y -g -O2 -MT StandardLogHandlerFactory.lo -MD -MP -MF .deps/StandardLogHandlerFactory.Tpo -c StandardLogHandlerFactory.cpp -o StandardLogHandlerFactory.o >/dev/null 2>&1
depbase=`echo StreamHandlerFactory.lo | sed 's|[^/]*$|.deps/&|;s|\.lo$||'`;\
/bin/bash ../../libtool  --tag=CXX   --mode=compile g++ -DHAVE_CONFIG_H   -I../../.. -pthread -I/usr/include    -std=gnu++1y -g -O2 -MT StreamHandlerFactory.lo -MD -MP -MF $depbase.Tpo -c -o StreamHandlerFactory.lo StreamHandlerFactory.cpp &&\
mv -f $depbase.Tpo $depbase.Plo
libtool: compile:  g++ -DHAVE_CONFIG_H -I../../.. -pthread -I/usr/include -std=gnu++1y -g -O2 -MT StreamHandlerFactory.lo -MD -MP -MF .deps/StreamHandlerFactory.Tpo -c StreamHandlerFactory.cpp  -fPIC -DPIC -o .libs/StreamHandlerFactory.o
libtool: compile:  g++ -DHAVE_CONFIG_H -I../../.. -pthread -I/usr/include -std=gnu++1y -g -O2 -MT StreamHandlerFactory.lo -MD -MP -MF .deps/StreamHandlerFactory.Tpo -c StreamHandlerFactory.cpp -o StreamHandlerFactory.o >/dev/null 2>&1
depbase=`echo xlog.lo | sed 's|[^/]*$|.deps/&|;s|\.lo$||'`;\
/bin/bash ../../libtool  --tag=CXX   --mode=compile g++ -DHAVE_CONFIG_H   -I../../.. -pthread -I/usr/include    -std=gnu++1y -g -O2 -MT xlog.lo -MD -MP -MF $depbase.Tpo -c -o xlog.lo xlog.cpp &&\
mv -f $depbase.Tpo $depbase.Plo
libtool: compile:  g++ -DHAVE_CONFIG_H -I../../.. -pthread -I/usr/include -std=gnu++1y -g -O2 -MT xlog.lo -MD -MP -MF .deps/xlog.Tpo -c xlog.cpp  -fPIC -DPIC -o .libs/xlog.o
libtool: compile:  g++ -DHAVE_CONFIG_H -I../../.. -pthread -I/usr/include -std=gnu++1y -g -O2 -MT xlog.lo -MD -MP -MF .deps/xlog.Tpo -c xlog.cpp -o xlog.o >/dev/null 2>&1
/bin/bash ../../libtool  --tag=CXX   --mode=link g++  -std=gnu++1y -g -O2 -lboost_context -lboost_program_options -lboost_thread -lboost_filesystem -lboost_system -lboost_regex -lpthread -lboost_chrono  -lssl -lcrypto -version-info 57:0:0  -o libfollylogging.la -rpath /usr/local/lib AsyncFileWriter.lo FileHandlerFactory.lo FileWriterFactory.lo GlogStyleFormatter.lo ImmediateFileWriter.lo Init.lo LogCategory.lo LogCategoryConfig.lo LogConfig.lo LogConfigParser.lo Logger.lo LoggerDB.lo LogHandlerConfig.lo LogLevel.lo LogMessage.lo LogName.lo LogStream.lo LogStreamProcessor.lo printf.lo RateLimiter.lo StandardLogHandler.lo StandardLogHandlerFactory.lo StreamHandlerFactory.lo xlog.lo ../../libfolly.la -llzma -lz -lsnappy -llz4 -liberty -ldl -levent -ldouble-conversion -lglog -lgflags
libtool: link: g++  -fPIC -DPIC -shared -nostdlib /usr/lib/gcc/x86_64-linux-gnu/5/../../../x86_64-linux-gnu/crti.o /usr/lib/gcc/x86_64-linux-gnu/5/crtbeginS.o  .libs/AsyncFileWriter.o .libs/FileHandlerFactory.o .libs/FileWriterFactory.o .libs/GlogStyleFormatter.o .libs/ImmediateFileWriter.o .libs/Init.o .libs/LogCategory.o .libs/LogCategoryConfig.o .libs/LogConfig.o .libs/LogConfigParser.o .libs/Logger.o .libs/LoggerDB.o .libs/LogHandlerConfig.o .libs/LogLevel.o .libs/LogMessage.o .libs/LogName.o .libs/LogStream.o .libs/LogStreamProcessor.o .libs/printf.o .libs/RateLimiter.o .libs/StandardLogHandler.o .libs/StandardLogHandlerFactory.o .libs/StreamHandlerFactory.o .libs/xlog.o   -Wl,-rpath -Wl,/media/tom/document/Syn_Clode/project/folly-2018.01.08.00/folly/.libs -lboost_context -lboost_program_options -lboost_thread -lboost_filesystem -lboost_system -lboost_regex -lpthread -lboost_chrono -lssl -lcrypto ../../.libs/libfolly.so -llzma -lz -lsnappy -llz4 -liberty -ldl -levent -ldouble-conversion -lglog -lgflags -L/usr/lib/gcc/x86_64-linux-gnu/5 -L/usr/lib/gcc/x86_64-linux-gnu/5/../../../x86_64-linux-gnu -L/usr/lib/gcc/x86_64-linux-gnu/5/../../../../lib -L/lib/x86_64-linux-gnu -L/lib/../lib -L/usr/lib/x86_64-linux-gnu -L/usr/lib/../lib -L/usr/lib/gcc/x86_64-linux-gnu/5/../../.. -lstdc++ -lm -lc -lgcc_s /usr/lib/gcc/x86_64-linux-gnu/5/crtendS.o /usr/lib/gcc/x86_64-linux-gnu/5/../../../x86_64-linux-gnu/crtn.o  -g -O2   -Wl,-soname -Wl,libfollylogging.so.57 -o .libs/libfollylogging.so.57.0.0
libtool: link: (cd ".libs" && rm -f "libfollylogging.so.57" && ln -s "libfollylogging.so.57.0.0" "libfollylogging.so.57")
libtool: link: (cd ".libs" && rm -f "libfollylogging.so" && ln -s "libfollylogging.so.57.0.0" "libfollylogging.so")
libtool: link: ar cru .libs/libfollylogging.a  AsyncFileWriter.o FileHandlerFactory.o FileWriterFactory.o GlogStyleFormatter.o ImmediateFileWriter.o Init.o LogCategory.o LogCategoryConfig.o LogConfig.o LogConfigParser.o Logger.o LoggerDB.o LogHandlerConfig.o LogLevel.o LogMessage.o LogName.o LogStream.o LogStreamProcessor.o printf.o RateLimiter.o StandardLogHandler.o StandardLogHandlerFactory.o StreamHandlerFactory.o xlog.o
ar: `u' modifier ignored since `D' is the default (see `U')
libtool: link: ranlib .libs/libfollylogging.a
libtool: link: ( cd ".libs" && rm -f "libfollylogging.la" && ln -s "../libfollylogging.la" "libfollylogging.la" )
make[4]: Leaving directory '/media/tom/document/Syn_Clode/project/folly-2018.01.08.00/folly/experimental/logging'
Making all in example
make[4]: Entering directory '/media/tom/document/Syn_Clode/project/folly-2018.01.08.00/folly/experimental/logging/example'
depbase=`echo lib.lo | sed 's|[^/]*$|.deps/&|;s|\.lo$||'`;\
/bin/bash ../../../libtool  --tag=CXX   --mode=compile g++ -DHAVE_CONFIG_H   -I../../../.. -pthread -I/usr/include    -std=gnu++1y -g -O2 -MT lib.lo -MD -MP -MF $depbase.Tpo -c -o lib.lo lib.cpp &&\
mv -f $depbase.Tpo $depbase.Plo
libtool: compile:  g++ -DHAVE_CONFIG_H -I../../../.. -pthread -I/usr/include -std=gnu++1y -g -O2 -MT lib.lo -MD -MP -MF .deps/lib.Tpo -c lib.cpp  -fPIC -DPIC -o .libs/lib.o
libtool: compile:  g++ -DHAVE_CONFIG_H -I../../../.. -pthread -I/usr/include -std=gnu++1y -g -O2 -MT lib.lo -MD -MP -MF .deps/lib.Tpo -c lib.cpp -o lib.o >/dev/null 2>&1
/bin/bash ../../../libtool  --tag=CXX   --mode=link g++  -std=gnu++1y -g -O2 -lboost_context -lboost_program_options -lboost_thread -lboost_filesystem -lboost_system -lboost_regex -lpthread -lboost_chrono  -lssl -lcrypto  -o libfollylogging_example.la  lib.lo ../../../experimental/logging/libfollylogging.la -llzma -lz -lsnappy -llz4 -liberty -ldl -levent -ldouble-conversion -lglog -lgflags
libtool: link: ar cru .libs/libfollylogging_example.a .libs/lib.o
ar: `u' modifier ignored since `D' is the default (see `U')
libtool: link: ranlib .libs/libfollylogging_example.a
libtool: link: ( cd ".libs" && rm -f "libfollylogging_example.la" && ln -s "../libfollylogging_example.la" "libfollylogging_example.la" )
depbase=`echo main.o | sed 's|[^/]*$|.deps/&|;s|\.o$||'`;\
g++ -DHAVE_CONFIG_H   -I../../../.. -pthread -I/usr/include    -std=gnu++1y -g -O2 -MT main.o -MD -MP -MF $depbase.Tpo -c -o main.o main.cpp &&\
mv -f $depbase.Tpo $depbase.Po
/bin/bash ../../../libtool  --tag=CXX   --mode=link g++  -std=gnu++1y -g -O2 -lboost_context -lboost_program_options -lboost_thread -lboost_filesystem -lboost_system -lboost_regex -lpthread -lboost_chrono  -lssl -lcrypto  -o logging_example main.o libfollylogging_example.la -llzma -lz -lsnappy -llz4 -liberty -ldl -levent -ldouble-conversion -lglog -lgflags
libtool: link: g++ -std=gnu++1y -g -O2 -o .libs/logging_example main.o  ./.libs/libfollylogging_example.a /media/tom/document/Syn_Clode/project/folly-2018.01.08.00/folly/experimental/logging/.libs/libfollylogging.so /media/tom/document/Syn_Clode/project/folly-2018.01.08.00/folly/.libs/libfolly.so -lunwind -lboost_context -lboost_program_options -lboost_thread -lboost_filesystem -lboost_system -lboost_regex -lpthread -lboost_chrono -lssl -lcrypto -llzma -lz -lsnappy -llz4 -liberty -ldl -levent -ldouble-conversion -lglog -lgflags
make[4]: Leaving directory '/media/tom/document/Syn_Clode/project/folly-2018.01.08.00/folly/experimental/logging/example'
make[3]: Leaving directory '/media/tom/document/Syn_Clode/project/folly-2018.01.08.00/folly/experimental/logging'
Making all in symbolizer
make[3]: Entering directory '/media/tom/document/Syn_Clode/project/folly-2018.01.08.00/folly/experimental/symbolizer'
Making all in .
make[4]: Entering directory '/media/tom/document/Syn_Clode/project/folly-2018.01.08.00/folly/experimental/symbolizer'
/bin/bash ../../libtool  --tag=CXX   --mode=link g++  -std=gnu++1y -g -O2 -lboost_context -lboost_program_options -lboost_thread -lboost_filesystem -lboost_system -lboost_regex -lpthread -lboost_chrono  -lssl -lcrypto -version-info 57:0:0  -o libfollysymbolizer.la -rpath /usr/local/lib Elf.lo ElfCache.lo Dwarf.lo LineReader.lo SignalHandler.lo StackTrace.lo Symbolizer.lo ../../libfolly.la -llzma -lz -lsnappy -llz4 -liberty -ldl -levent -ldouble-conversion -lglog -lgflags
libtool: link: g++  -fPIC -DPIC -shared -nostdlib /usr/lib/gcc/x86_64-linux-gnu/5/../../../x86_64-linux-gnu/crti.o /usr/lib/gcc/x86_64-linux-gnu/5/crtbeginS.o  .libs/Elf.o .libs/ElfCache.o .libs/Dwarf.o .libs/LineReader.o .libs/SignalHandler.o .libs/StackTrace.o .libs/Symbolizer.o   -Wl,-rpath -Wl,/media/tom/document/Syn_Clode/project/folly-2018.01.08.00/folly/.libs -lboost_context -lboost_program_options -lboost_thread -lboost_filesystem -lboost_system -lboost_regex -lpthread -lboost_chrono -lssl -lcrypto ../../.libs/libfolly.so -llzma -lz -lsnappy -llz4 -liberty -ldl -levent -ldouble-conversion -lglog -lgflags -L/usr/lib/gcc/x86_64-linux-gnu/5 -L/usr/lib/gcc/x86_64-linux-gnu/5/../../../x86_64-linux-gnu -L/usr/lib/gcc/x86_64-linux-gnu/5/../../../../lib -L/lib/x86_64-linux-gnu -L/lib/../lib -L/usr/lib/x86_64-linux-gnu -L/usr/lib/../lib -L/usr/lib/gcc/x86_64-linux-gnu/5/../../.. -lstdc++ -lm -lc -lgcc_s /usr/lib/gcc/x86_64-linux-gnu/5/crtendS.o /usr/lib/gcc/x86_64-linux-gnu/5/../../../x86_64-linux-gnu/crtn.o  -g -O2   -Wl,-soname -Wl,libfollysymbolizer.so.57 -o .libs/libfollysymbolizer.so.57.0.0
libtool: link: (cd ".libs" && rm -f "libfollysymbolizer.so.57" && ln -s "libfollysymbolizer.so.57.0.0" "libfollysymbolizer.so.57")
libtool: link: (cd ".libs" && rm -f "libfollysymbolizer.so" && ln -s "libfollysymbolizer.so.57.0.0" "libfollysymbolizer.so")
libtool: link: ar cru .libs/libfollysymbolizer.a  Elf.o ElfCache.o Dwarf.o LineReader.o SignalHandler.o StackTrace.o Symbolizer.o
ar: `u' modifier ignored since `D' is the default (see `U')
libtool: link: ranlib .libs/libfollysymbolizer.a
libtool: link: ( cd ".libs" && rm -f "libfollysymbolizer.la" && ln -s "../libfollysymbolizer.la" "libfollysymbolizer.la" )
make[4]: Leaving directory '/media/tom/document/Syn_Clode/project/folly-2018.01.08.00/folly/experimental/symbolizer'
make[3]: Leaving directory '/media/tom/document/Syn_Clode/project/folly-2018.01.08.00/folly/experimental/symbolizer'
make[3]: Entering directory '/media/tom/document/Syn_Clode/project/folly-2018.01.08.00/folly/experimental'
make[3]: Nothing to be done for 'all-am'.
make[3]: Leaving directory '/media/tom/document/Syn_Clode/project/folly-2018.01.08.00/folly/experimental'
make[2]: Leaving directory '/media/tom/document/Syn_Clode/project/folly-2018.01.08.00/folly/experimental'
Making all in init
make[2]: Entering directory '/media/tom/document/Syn_Clode/project/folly-2018.01.08.00/folly/init'
Making all in .
make[3]: Entering directory '/media/tom/document/Syn_Clode/project/folly-2018.01.08.00/folly/init'
/bin/bash ../libtool  --tag=CXX   --mode=link g++  -std=gnu++1y -g -O2 -lboost_context -lboost_program_options -lboost_thread -lboost_filesystem -lboost_system -lboost_regex -lpthread -lboost_chrono  -lssl -lcrypto -version-info 57:0:0  -o libfollyinit.la -rpath /usr/local/lib Init.lo ../libfolly.la -llzma -lz -lsnappy -llz4 -liberty -ldl -levent -ldouble-conversion -lglog -lgflags
libtool: link: g++  -fPIC -DPIC -shared -nostdlib /usr/lib/gcc/x86_64-linux-gnu/5/../../../x86_64-linux-gnu/crti.o /usr/lib/gcc/x86_64-linux-gnu/5/crtbeginS.o  .libs/Init.o   -Wl,-rpath -Wl,/media/tom/document/Syn_Clode/project/folly-2018.01.08.00/folly/.libs -lboost_context -lboost_program_options -lboost_thread -lboost_filesystem -lboost_system -lboost_regex -lpthread -lboost_chrono -lssl -lcrypto ../.libs/libfolly.so -llzma -lz -lsnappy -llz4 -liberty -ldl -levent -ldouble-conversion -lglog -lgflags -L/usr/lib/gcc/x86_64-linux-gnu/5 -L/usr/lib/gcc/x86_64-linux-gnu/5/../../../x86_64-linux-gnu -L/usr/lib/gcc/x86_64-linux-gnu/5/../../../../lib -L/lib/x86_64-linux-gnu -L/lib/../lib -L/usr/lib/x86_64-linux-gnu -L/usr/lib/../lib -L/usr/lib/gcc/x86_64-linux-gnu/5/../../.. -lstdc++ -lm -lc -lgcc_s /usr/lib/gcc/x86_64-linux-gnu/5/crtendS.o /usr/lib/gcc/x86_64-linux-gnu/5/../../../x86_64-linux-gnu/crtn.o  -g -O2   -Wl,-soname -Wl,libfollyinit.so.57 -o .libs/libfollyinit.so.57.0.0
libtool: link: (cd ".libs" && rm -f "libfollyinit.so.57" && ln -s "libfollyinit.so.57.0.0" "libfollyinit.so.57")
libtool: link: (cd ".libs" && rm -f "libfollyinit.so" && ln -s "libfollyinit.so.57.0.0" "libfollyinit.so")
libtool: link: ar cru .libs/libfollyinit.a  Init.o
ar: `u' modifier ignored since `D' is the default (see `U')
libtool: link: ranlib .libs/libfollyinit.a
libtool: link: ( cd ".libs" && rm -f "libfollyinit.la" && ln -s "../libfollyinit.la" "libfollyinit.la" )
make[3]: Leaving directory '/media/tom/document/Syn_Clode/project/folly-2018.01.08.00/folly/init'
make[2]: Leaving directory '/media/tom/document/Syn_Clode/project/folly-2018.01.08.00/folly/init'
Making all in chrono/test
make[2]: Entering directory '/media/tom/document/Syn_Clode/project/folly-2018.01.08.00/folly/chrono/test'
make[2]: Nothing to be done for 'all'.
make[2]: Leaving directory '/media/tom/document/Syn_Clode/project/folly-2018.01.08.00/folly/chrono/test'
Making all in io/test
make[2]: Entering directory '/media/tom/document/Syn_Clode/project/folly-2018.01.08.00/folly/io/test'
make[2]: Nothing to be done for 'all'.
make[2]: Leaving directory '/media/tom/document/Syn_Clode/project/folly-2018.01.08.00/folly/io/test'
Making all in stats/test
make[2]: Entering directory '/media/tom/document/Syn_Clode/project/folly-2018.01.08.00/folly/stats/test'
make[2]: Nothing to be done for 'all'.
make[2]: Leaving directory '/media/tom/document/Syn_Clode/project/folly-2018.01.08.00/folly/stats/test'
make[1]: Leaving directory '/media/tom/document/Syn_Clode/project/folly-2018.01.08.00/folly'


tom@tom-Vostro-2421:/media/tom/document/Syn_Clode/project/folly-2018.01.08.00/folly$ make check
Making check in .
make[1]: Entering directory '/media/tom/document/Syn_Clode/project/folly-2018.01.08.00/folly'
make[1]: Leaving directory '/media/tom/document/Syn_Clode/project/folly-2018.01.08.00/folly'
Making check in test
make[1]: Entering directory '/media/tom/document/Syn_Clode/project/folly-2018.01.08.00/folly/test'
Making check in .
make[2]: Entering directory '/media/tom/document/Syn_Clode/project/folly-2018.01.08.00/folly/test'
make  libfollytestmain.la libgtest.la foreach_benchmark benchmark_test concurrent_skiplist_benchmark conv_benchmark sorted_vector_types_test foreach_test hash_test timeout_queue_test conv_test expected_test range_test math_test bits_test bit_iterator_test spin_lock_test array_test constexpr_math_test small_locks_test packed_sync_ptr_test small_vector_test discriminated_ptr_test cpuid_test sorted_vector_types_test container_access_test foreach_test hash_test invoke_test fbstring_test_using_jemalloc thread_cached_int_test thread_id_test thread_cached_int_test thread_local_test fbvector_test dynamic_test json_test scope_guard_test timeout_queue_test cold_class_test conv_test expected_test range_test math_test bits_test bit_iterator_test endian_test rw_spinlock_test synchronized_test synchronized_ptr_test lock_traits_test concurrent_skiplist_test group_varint_test map_util_test string_test producer_consumer_queue_test atomic_hash_array_test atomic_hash_map_test chrono_test format_test fingerprint_test poly_test portability_test spooky_hash_v1_test spooky_hash_v2_test token_bucket_test thread_name_test indestructible_test portability_clock_gettime_wrappers_test portability_time_test portability_constexpr_test portability_openssl_test try_test typelist_test uncaught_exceptions_test unit_test futures_test function_test rvalue_reference_wrapper_test ssl_test mallctl_helper_test apply_tuple_test partial_test singleton_thread_local_test utility_test iterator_test
make[3]: Entering directory '/media/tom/document/Syn_Clode/project/folly-2018.01.08.00/folly/test'
/bin/bash ../libtool  --tag=CXX   --mode=compile g++ -DHAVE_CONFIG_H   -I../.. -pthread -I/usr/include  -isystem gtest/googletest -isystem gtest/googletest/include -isystem gtest/googlemock/include  -std=gnu++1y -g -O2 -MT gtest/googletest/src/libfollytestmain_la-gtest-all.lo -MD -MP -MF gtest/googletest/src/.deps/libfollytestmain_la-gtest-all.Tpo -c -o gtest/googletest/src/libfollytestmain_la-gtest-all.lo `test -f 'gtest/googletest/src/gtest-all.cc' || echo './'`gtest/googletest/src/gtest-all.cc
libtool: compile:  g++ -DHAVE_CONFIG_H -I../.. -pthread -I/usr/include -isystem gtest/googletest -isystem gtest/googletest/include -isystem gtest/googlemock/include -std=gnu++1y -g -O2 -MT gtest/googletest/src/libfollytestmain_la-gtest-all.lo -MD -MP -MF gtest/googletest/src/.deps/libfollytestmain_la-gtest-all.Tpo -c gtest/googletest/src/gtest-all.cc  -fPIC -DPIC -o gtest/googletest/src/.libs/libfollytestmain_la-gtest-all.o
libtool: compile:  g++ -DHAVE_CONFIG_H -I../.. -pthread -I/usr/include -isystem gtest/googletest -isystem gtest/googletest/include -isystem gtest/googlemock/include -std=gnu++1y -g -O2 -MT gtest/googletest/src/libfollytestmain_la-gtest-all.lo -MD -MP -MF gtest/googletest/src/.deps/libfollytestmain_la-gtest-all.Tpo -c gtest/googletest/src/gtest-all.cc -o gtest/googletest/src/libfollytestmain_la-gtest-all.o >/dev/null 2>&1
mv -f gtest/googletest/src/.deps/libfollytestmain_la-gtest-all.Tpo gtest/googletest/src/.deps/libfollytestmain_la-gtest-all.Plo
/bin/bash ../libtool  --tag=CXX   --mode=compile g++ -DHAVE_CONFIG_H   -I../.. -pthread -I/usr/include  -isystem gtest/googletest -isystem gtest/googletest/include -isystem gtest/googlemock/include  -std=gnu++1y -g -O2 -MT common/libfollytestmain_la-TestMain.lo -MD -MP -MF common/.deps/libfollytestmain_la-TestMain.Tpo -c -o common/libfollytestmain_la-TestMain.lo `test -f 'common/TestMain.cpp' || echo './'`common/TestMain.cpp
libtool: compile:  g++ -DHAVE_CONFIG_H -I../.. -pthread -I/usr/include -isystem gtest/googletest -isystem gtest/googletest/include -isystem gtest/googlemock/include -std=gnu++1y -g -O2 -MT common/libfollytestmain_la-TestMain.lo -MD -MP -MF common/.deps/libfollytestmain_la-TestMain.Tpo -c common/TestMain.cpp  -fPIC -DPIC -o common/.libs/libfollytestmain_la-TestMain.o
libtool: compile:  g++ -DHAVE_CONFIG_H -I../.. -pthread -I/usr/include -isystem gtest/googletest -isystem gtest/googletest/include -isystem gtest/googlemock/include -std=gnu++1y -g -O2 -MT common/libfollytestmain_la-TestMain.lo -MD -MP -MF common/.deps/libfollytestmain_la-TestMain.Tpo -c common/TestMain.cpp -o common/libfollytestmain_la-TestMain.o >/dev/null 2>&1
mv -f common/.deps/libfollytestmain_la-TestMain.Tpo common/.deps/libfollytestmain_la-TestMain.Plo
/bin/bash ../libtool  --tag=CXX   --mode=link g++  -std=gnu++1y -g -O2 -lboost_context -lboost_program_options -lboost_thread -lboost_filesystem -lboost_system -lboost_regex -lpthread -lboost_chrono  -lssl -lcrypto  -o libfollytestmain.la  gtest/googletest/src/libfollytestmain_la-gtest-all.lo common/libfollytestmain_la-TestMain.lo ../init/libfollyinit.la ../libfolly.la -llzma -lz -lsnappy -llz4 -liberty -ldl -levent -ldouble-conversion -lglog -lgflags
libtool: link: ar cru .libs/libfollytestmain.a gtest/googletest/src/.libs/libfollytestmain_la-gtest-all.o common/.libs/libfollytestmain_la-TestMain.o
ar: `u' modifier ignored since `D' is the default (see `U')
libtool: link: ranlib .libs/libfollytestmain.a
libtool: link: ( cd ".libs" && rm -f "libfollytestmain.la" && ln -s "../libfollytestmain.la" "libfollytestmain.la" )
/bin/bash ../libtool  --tag=CXX   --mode=compile g++ -DHAVE_CONFIG_H   -isystem gtest/googletest -isystem gtest/googletest/include -isystem gtest/googlemock/include  -std=gnu++1y -g -O2 -MT gtest/googletest/src/libgtest_la-gtest-all.lo -MD -MP -MF gtest/googletest/src/.deps/libgtest_la-gtest-all.Tpo -c -o gtest/googletest/src/libgtest_la-gtest-all.lo `test -f 'gtest/googletest/src/gtest-all.cc' || echo './'`gtest/googletest/src/gtest-all.cc
libtool: compile:  g++ -DHAVE_CONFIG_H -isystem gtest/googletest -isystem gtest/googletest/include -isystem gtest/googlemock/include -std=gnu++1y -g -O2 -MT gtest/googletest/src/libgtest_la-gtest-all.lo -MD -MP -MF gtest/googletest/src/.deps/libgtest_la-gtest-all.Tpo -c gtest/googletest/src/gtest-all.cc  -fPIC -DPIC -o gtest/googletest/src/.libs/libgtest_la-gtest-all.o
libtool: compile:  g++ -DHAVE_CONFIG_H -isystem gtest/googletest -isystem gtest/googletest/include -isystem gtest/googlemock/include -std=gnu++1y -g -O2 -MT gtest/googletest/src/libgtest_la-gtest-all.lo -MD -MP -MF gtest/googletest/src/.deps/libgtest_la-gtest-all.Tpo -c gtest/googletest/src/gtest-all.cc -o gtest/googletest/src/libgtest_la-gtest-all.o >/dev/null 2>&1
mv -f gtest/googletest/src/.deps/libgtest_la-gtest-all.Tpo gtest/googletest/src/.deps/libgtest_la-gtest-all.Plo
/bin/bash ../libtool  --tag=CXX   --mode=link g++  -std=gnu++1y -g -O2 -lboost_context -lboost_program_options -lboost_thread -lboost_filesystem -lboost_system -lboost_regex -lpthread -lboost_chrono  -lssl -lcrypto  -o libgtest.la  gtest/googletest/src/libgtest_la-gtest-all.lo  -llzma -lz -lsnappy -llz4 -liberty -ldl -levent -ldouble-conversion -lglog -lgflags
libtool: link: ar cru .libs/libgtest.a gtest/googletest/src/.libs/libgtest_la-gtest-all.o
ar: `u' modifier ignored since `D' is the default (see `U')
libtool: link: ranlib .libs/libgtest.a
libtool: link: ( cd ".libs" && rm -f "libgtest.la" && ln -s "../libgtest.la" "libgtest.la" )
depbase=`echo ../container/test/ForeachBenchmark.o | sed 's|[^/]*$|.deps/&|;s|\.o$||'`;\
g++ -DHAVE_CONFIG_H   -I../.. -pthread -I/usr/include  -isystem gtest/googletest/include -isystem gtest/googlemock/include  -std=gnu++1y -g -O2 -MT ../container/test/ForeachBenchmark.o -MD -MP -MF $depbase.Tpo -c -o ../container/test/ForeachBenchmark.o ../container/test/ForeachBenchmark.cpp &&\
mv -f $depbase.Tpo $depbase.Po
/bin/bash ../libtool  --tag=CXX   --mode=link g++  -std=gnu++1y -g -O2 -lboost_context -lboost_program_options -lboost_thread -lboost_filesystem -lboost_system -lboost_regex -lpthread -lboost_chrono  -lssl -lcrypto  -o foreach_benchmark ../container/test/ForeachBenchmark.o libfollytestmain.la ../libfollybenchmark.la -llzma -lz -lsnappy -llz4 -liberty -ldl -levent -ldouble-conversion -lglog -lgflags
libtool: link: g++ -std=gnu++1y -g -O2 -o .libs/foreach_benchmark ../container/test/ForeachBenchmark.o  ./.libs/libfollytestmain.a /media/tom/document/Syn_Clode/project/folly-2018.01.08.00/folly/init/.libs/libfollyinit.so /media/tom/document/Syn_Clode/project/folly-2018.01.08.00/folly/.libs/libfolly.so -lunwind -lboost_context -lboost_program_options -lboost_thread -lboost_filesystem -lboost_system -lboost_regex -lpthread -lboost_chrono -lssl -lcrypto ../.libs/libfollybenchmark.so -llzma -lz -lsnappy -llz4 -liberty -ldl -levent -ldouble-conversion -lglog -lgflags
depbase=`echo BenchmarkTest.o | sed 's|[^/]*$|.deps/&|;s|\.o$||'`;\
g++ -DHAVE_CONFIG_H   -I../.. -pthread -I/usr/include  -isystem gtest/googletest/include -isystem gtest/googlemock/include  -std=gnu++1y -g -O2 -MT BenchmarkTest.o -MD -MP -MF $depbase.Tpo -c -o BenchmarkTest.o BenchmarkTest.cpp &&\
mv -f $depbase.Tpo $depbase.Po
/bin/bash ../libtool  --tag=CXX   --mode=link g++  -std=gnu++1y -g -O2 -lboost_context -lboost_program_options -lboost_thread -lboost_filesystem -lboost_system -lboost_regex -lpthread -lboost_chrono  -lssl -lcrypto  -o benchmark_test BenchmarkTest.o libfollytestmain.la ../libfollybenchmark.la -llzma -lz -lsnappy -llz4 -liberty -ldl -levent -ldouble-conversion -lglog -lgflags
libtool: link: g++ -std=gnu++1y -g -O2 -o .libs/benchmark_test BenchmarkTest.o  ./.libs/libfollytestmain.a /media/tom/document/Syn_Clode/project/folly-2018.01.08.00/folly/init/.libs/libfollyinit.so /media/tom/document/Syn_Clode/project/folly-2018.01.08.00/folly/.libs/libfolly.so -lunwind -lboost_context -lboost_program_options -lboost_thread -lboost_filesystem -lboost_system -lboost_regex -lpthread -lboost_chrono -lssl -lcrypto ../.libs/libfollybenchmark.so -llzma -lz -lsnappy -llz4 -liberty -ldl -levent -ldouble-conversion -lglog -lgflags
depbase=`echo ConcurrentSkipListBenchmark.o | sed 's|[^/]*$|.deps/&|;s|\.o$||'`;\
g++ -DHAVE_CONFIG_H   -I../.. -pthread -I/usr/include  -isystem gtest/googletest/include -isystem gtest/googlemock/include  -std=gnu++1y -g -O2 -MT ConcurrentSkipListBenchmark.o -MD -MP -MF $depbase.Tpo -c -o ConcurrentSkipListBenchmark.o ConcurrentSkipListBenchmark.cpp &&\
mv -f $depbase.Tpo $depbase.Po
/bin/bash ../libtool  --tag=CXX   --mode=link g++  -std=gnu++1y -g -O2 -lboost_context -lboost_program_options -lboost_thread -lboost_filesystem -lboost_system -lboost_regex -lpthread -lboost_chrono  -lssl -lcrypto  -o concurrent_skiplist_benchmark ConcurrentSkipListBenchmark.o libfollytestmain.la ../libfollybenchmark.la -llzma -lz -lsnappy -llz4 -liberty -ldl -levent -ldouble-conversion -lglog -lgflags
libtool: link: g++ -std=gnu++1y -g -O2 -o .libs/concurrent_skiplist_benchmark ConcurrentSkipListBenchmark.o  ./.libs/libfollytestmain.a /media/tom/document/Syn_Clode/project/folly-2018.01.08.00/folly/init/.libs/libfollyinit.so /media/tom/document/Syn_Clode/project/folly-2018.01.08.00/folly/.libs/libfolly.so -lunwind -lboost_context -lboost_program_options -lboost_thread -lboost_filesystem -lboost_system -lboost_regex -lpthread -lboost_chrono -lssl -lcrypto ../.libs/libfollybenchmark.so -llzma -lz -lsnappy -llz4 -liberty -ldl -levent -ldouble-conversion -lglog -lgflags
depbase=`echo ConvBenchmark.o | sed 's|[^/]*$|.deps/&|;s|\.o$||'`;\
g++ -DHAVE_CONFIG_H   -I../.. -pthread -I/usr/include  -isystem gtest/googletest/include -isystem gtest/googlemock/include  -std=gnu++1y -g -O2 -MT ConvBenchmark.o -MD -MP -MF $depbase.Tpo -c -o ConvBenchmark.o ConvBenchmark.cpp &&\
mv -f $depbase.Tpo $depbase.Po
/bin/bash ../libtool  --tag=CXX   --mode=link g++  -std=gnu++1y -g -O2 -lboost_context -lboost_program_options -lboost_thread -lboost_filesystem -lboost_system -lboost_regex -lpthread -lboost_chrono  -lssl -lcrypto  -o conv_benchmark ConvBenchmark.o libfollytestmain.la ../libfollybenchmark.la -llzma -lz -lsnappy -llz4 -liberty -ldl -levent -ldouble-conversion -lglog -lgflags
libtool: link: g++ -std=gnu++1y -g -O2 -o .libs/conv_benchmark ConvBenchmark.o  ./.libs/libfollytestmain.a /media/tom/document/Syn_Clode/project/folly-2018.01.08.00/folly/init/.libs/libfollyinit.so /media/tom/document/Syn_Clode/project/folly-2018.01.08.00/folly/.libs/libfolly.so -lunwind -lboost_context -lboost_program_options -lboost_thread -lboost_filesystem -lboost_system -lboost_regex -lpthread -lboost_chrono -lssl -lcrypto ../.libs/libfollybenchmark.so -llzma -lz -lsnappy -llz4 -liberty -ldl -levent -ldouble-conversion -lglog -lgflags
depbase=`echo sorted_vector_test.o | sed 's|[^/]*$|.deps/&|;s|\.o$||'`;\
g++ -DHAVE_CONFIG_H   -I../.. -pthread -I/usr/include  -isystem gtest/googletest/include -isystem gtest/googlemock/include  -std=gnu++1y -g -O2 -MT sorted_vector_test.o -MD -MP -MF $depbase.Tpo -c -o sorted_vector_test.o sorted_vector_test.cpp &&\
mv -f $depbase.Tpo $depbase.Po
/bin/bash ../libtool  --tag=CXX   --mode=link g++  -std=gnu++1y -g -O2 -lboost_context -lboost_program_options -lboost_thread -lboost_filesystem -lboost_system -lboost_regex -lpthread -lboost_chrono  -lssl -lcrypto  -o sorted_vector_types_test sorted_vector_test.o libfollytestmain.la -llzma -lz -lsnappy -llz4 -liberty -ldl -levent -ldouble-conversion -lglog -lgflags
libtool: link: g++ -std=gnu++1y -g -O2 -o .libs/sorted_vector_types_test sorted_vector_test.o  ./.libs/libfollytestmain.a /media/tom/document/Syn_Clode/project/folly-2018.01.08.00/folly/init/.libs/libfollyinit.so /media/tom/document/Syn_Clode/project/folly-2018.01.08.00/folly/.libs/libfolly.so -lunwind -lboost_context -lboost_program_options -lboost_thread -lboost_filesystem -lboost_system -lboost_regex -lpthread -lboost_chrono -lssl -lcrypto -llzma -lz -lsnappy -llz4 -liberty -ldl -levent -ldouble-conversion -lglog -lgflags
depbase=`echo ../container/test/ForeachTest.o | sed 's|[^/]*$|.deps/&|;s|\.o$||'`;\
g++ -DHAVE_CONFIG_H   -I../.. -pthread -I/usr/include  -isystem gtest/googletest/include -isystem gtest/googlemock/include  -std=gnu++1y -g -O2 -MT ../container/test/ForeachTest.o -MD -MP -MF $depbase.Tpo -c -o ../container/test/ForeachTest.o ../container/test/ForeachTest.cpp &&\
mv -f $depbase.Tpo $depbase.Po
/bin/bash ../libtool  --tag=CXX   --mode=link g++  -std=gnu++1y -g -O2 -lboost_context -lboost_program_options -lboost_thread -lboost_filesystem -lboost_system -lboost_regex -lpthread -lboost_chrono  -lssl -lcrypto  -o foreach_test ../container/test/ForeachTest.o libfollytestmain.la -llzma -lz -lsnappy -llz4 -liberty -ldl -levent -ldouble-conversion -lglog -lgflags
libtool: link: g++ -std=gnu++1y -g -O2 -o .libs/foreach_test ../container/test/ForeachTest.o  ./.libs/libfollytestmain.a /media/tom/document/Syn_Clode/project/folly-2018.01.08.00/folly/init/.libs/libfollyinit.so /media/tom/document/Syn_Clode/project/folly-2018.01.08.00/folly/.libs/libfolly.so -lunwind -lboost_context -lboost_program_options -lboost_thread -lboost_filesystem -lboost_system -lboost_regex -lpthread -lboost_chrono -lssl -lcrypto -llzma -lz -lsnappy -llz4 -liberty -ldl -levent -ldouble-conversion -lglog -lgflags
depbase=`echo ../hash/test/HashTest.o | sed 's|[^/]*$|.deps/&|;s|\.o$||'`;\
g++ -DHAVE_CONFIG_H   -I../.. -pthread -I/usr/include  -isystem gtest/googletest/include -isystem gtest/googlemock/include  -std=gnu++1y -g -O2 -MT ../hash/test/HashTest.o -MD -MP -MF $depbase.Tpo -c -o ../hash/test/HashTest.o ../hash/test/HashTest.cpp &&\
mv -f $depbase.Tpo $depbase.Po
/bin/bash ../libtool  --tag=CXX   --mode=link g++  -std=gnu++1y -g -O2 -lboost_context -lboost_program_options -lboost_thread -lboost_filesystem -lboost_system -lboost_regex -lpthread -lboost_chrono  -lssl -lcrypto  -o hash_test ../hash/test/HashTest.o libfollytestmain.la -llzma -lz -lsnappy -llz4 -liberty -ldl -levent -ldouble-conversion -lglog -lgflags
libtool: link: g++ -std=gnu++1y -g -O2 -o .libs/hash_test ../hash/test/HashTest.o  ./.libs/libfollytestmain.a /media/tom/document/Syn_Clode/project/folly-2018.01.08.00/folly/init/.libs/libfollyinit.so /media/tom/document/Syn_Clode/project/folly-2018.01.08.00/folly/.libs/libfolly.so -lunwind -lboost_context -lboost_program_options -lboost_thread -lboost_filesystem -lboost_system -lboost_regex -lpthread -lboost_chrono -lssl -lcrypto -llzma -lz -lsnappy -llz4 -liberty -ldl -levent -ldouble-conversion -lglog -lgflags
depbase=`echo TimeoutQueueTest.o | sed 's|[^/]*$|.deps/&|;s|\.o$||'`;\
g++ -DHAVE_CONFIG_H   -I../.. -pthread -I/usr/include  -isystem gtest/googletest/include -isystem gtest/googlemock/include  -std=gnu++1y -g -O2 -MT TimeoutQueueTest.o -MD -MP -MF $depbase.Tpo -c -o TimeoutQueueTest.o TimeoutQueueTest.cpp &&\
mv -f $depbase.Tpo $depbase.Po
/bin/bash ../libtool  --tag=CXX   --mode=link g++  -std=gnu++1y -g -O2 -lboost_context -lboost_program_options -lboost_thread -lboost_filesystem -lboost_system -lboost_regex -lpthread -lboost_chrono  -lssl -lcrypto  -o timeout_queue_test TimeoutQueueTest.o libfollytestmain.la -llzma -lz -lsnappy -llz4 -liberty -ldl -levent -ldouble-conversion -lglog -lgflags
libtool: link: g++ -std=gnu++1y -g -O2 -o .libs/timeout_queue_test TimeoutQueueTest.o  ./.libs/libfollytestmain.a /media/tom/document/Syn_Clode/project/folly-2018.01.08.00/folly/init/.libs/libfollyinit.so /media/tom/document/Syn_Clode/project/folly-2018.01.08.00/folly/.libs/libfolly.so -lunwind -lboost_context -lboost_program_options -lboost_thread -lboost_filesystem -lboost_system -lboost_regex -lpthread -lboost_chrono -lssl -lcrypto -llzma -lz -lsnappy -llz4 -liberty -ldl -levent -ldouble-conversion -lglog -lgflags
depbase=`echo ConvTest.o | sed 's|[^/]*$|.deps/&|;s|\.o$||'`;\
g++ -DHAVE_CONFIG_H   -I../.. -pthread -I/usr/include  -isystem gtest/googletest/include -isystem gtest/googlemock/include  -std=gnu++1y -g -O2 -MT ConvTest.o -MD -MP -MF $depbase.Tpo -c -o ConvTest.o ConvTest.cpp &&\
mv -f $depbase.Tpo $depbase.Po
/bin/bash ../libtool  --tag=CXX   --mode=link g++  -std=gnu++1y -g -O2 -lboost_context -lboost_program_options -lboost_thread -lboost_filesystem -lboost_system -lboost_regex -lpthread -lboost_chrono  -lssl -lcrypto  -o conv_test ConvTest.o libfollytestmain.la ../libfollybenchmark.la -llzma -lz -lsnappy -llz4 -liberty -ldl -levent -ldouble-conversion -lglog -lgflags
libtool: link: g++ -std=gnu++1y -g -O2 -o .libs/conv_test ConvTest.o  ./.libs/libfollytestmain.a /media/tom/document/Syn_Clode/project/folly-2018.01.08.00/folly/init/.libs/libfollyinit.so /media/tom/document/Syn_Clode/project/folly-2018.01.08.00/folly/.libs/libfolly.so -lunwind -lboost_context -lboost_program_options -lboost_thread -lboost_filesystem -lboost_system -lboost_regex -lpthread -lboost_chrono -lssl -lcrypto ../.libs/libfollybenchmark.so -llzma -lz -lsnappy -llz4 -liberty -ldl -levent -ldouble-conversion -lglog -lgflags
depbase=`echo ExpectedTest.o | sed 's|[^/]*$|.deps/&|;s|\.o$||'`;\
g++ -DHAVE_CONFIG_H   -I../.. -pthread -I/usr/include  -isystem gtest/googletest/include -isystem gtest/googlemock/include  -std=gnu++1y -g -O2 -MT ExpectedTest.o -MD -MP -MF $depbase.Tpo -c -o ExpectedTest.o ExpectedTest.cpp &&\
mv -f $depbase.Tpo $depbase.Po
/bin/bash ../libtool  --tag=CXX   --mode=link g++  -std=gnu++1y -g -O2 -lboost_context -lboost_program_options -lboost_thread -lboost_filesystem -lboost_system -lboost_regex -lpthread -lboost_chrono  -lssl -lcrypto  -o expected_test ExpectedTest.o libfollytestmain.la ../libfollybenchmark.la -llzma -lz -lsnappy -llz4 -liberty -ldl -levent -ldouble-conversion -lglog -lgflags
libtool: link: g++ -std=gnu++1y -g -O2 -o .libs/expected_test ExpectedTest.o  ./.libs/libfollytestmain.a /media/tom/document/Syn_Clode/project/folly-2018.01.08.00/folly/init/.libs/libfollyinit.so /media/tom/document/Syn_Clode/project/folly-2018.01.08.00/folly/.libs/libfolly.so -lunwind -lboost_context -lboost_program_options -lboost_thread -lboost_filesystem -lboost_system -lboost_regex -lpthread -lboost_chrono -lssl -lcrypto ../.libs/libfollybenchmark.so -llzma -lz -lsnappy -llz4 -liberty -ldl -levent -ldouble-conversion -lglog -lgflags
depbase=`echo RangeTest.o | sed 's|[^/]*$|.deps/&|;s|\.o$||'`;\
g++ -DHAVE_CONFIG_H   -I../.. -pthread -I/usr/include  -isystem gtest/googletest/include -isystem gtest/googlemock/include  -std=gnu++1y -g -O2 -MT RangeTest.o -MD -MP -MF $depbase.Tpo -c -o RangeTest.o RangeTest.cpp &&\
mv -f $depbase.Tpo $depbase.Po
/bin/bash ../libtool  --tag=CXX   --mode=link g++  -std=gnu++1y -g -O2 -lboost_context -lboost_program_options -lboost_thread -lboost_filesystem -lboost_system -lboost_regex -lpthread -lboost_chrono  -lssl -lcrypto  -o range_test RangeTest.o libfollytestmain.la -llzma -lz -lsnappy -llz4 -liberty -ldl -levent -ldouble-conversion -lglog -lgflags
libtool: link: g++ -std=gnu++1y -g -O2 -o .libs/range_test RangeTest.o  ./.libs/libfollytestmain.a /media/tom/document/Syn_Clode/project/folly-2018.01.08.00/folly/init/.libs/libfollyinit.so /media/tom/document/Syn_Clode/project/folly-2018.01.08.00/folly/.libs/libfolly.so -lunwind -lboost_context -lboost_program_options -lboost_thread -lboost_filesystem -lboost_system -lboost_regex -lpthread -lboost_chrono -lssl -lcrypto -llzma -lz -lsnappy -llz4 -liberty -ldl -levent -ldouble-conversion -lglog -lgflags
RangeTest.o: In function `testing::IsEmptyMatcher::gmock_Impl<folly::Range<int const*> const&>::FormatDescription(bool) const':
/media/tom/document/Syn_Clode/project/folly-2018.01.08.00/folly/test/gtest/googlemock/include/gmock/gmock-more-matchers.h:48: undefined reference to `testing::internal::FormatMatcherDescription(bool, char const*, std::vector<std::__cxx11::basic_string<char, std::char_traits<char>, std::allocator<char> >, std::allocator<std::__cxx11::basic_string<char, std::char_traits<char>, std::allocator<char> > > > const&)'
/media/tom/document/Syn_Clode/project/folly-2018.01.08.00/folly/test/gtest/googlemock/include/gmock/gmock-more-matchers.h:48: undefined reference to `testing::internal::FormatMatcherDescription(bool, char const*, std::vector<std::__cxx11::basic_string<char, std::char_traits<char>, std::allocator<char> >, std::allocator<std::__cxx11::basic_string<char, std::char_traits<char>, std::allocator<char> > > > const&)'
collect2: error: ld returned 1 exit status
Makefile:1797: recipe for target 'range_test' failed
make[3]: *** [range_test] Error 1
make[3]: Leaving directory '/media/tom/document/Syn_Clode/project/folly-2018.01.08.00/folly/test'
Makefile:2950: recipe for target 'check-am' failed
make[2]: *** [check-am] Error 2
make[2]: Leaving directory '/media/tom/document/Syn_Clode/project/folly-2018.01.08.00/folly/test'
Makefile:2163: recipe for target 'check-recursive' failed
make[1]: *** [check-recursive] Error 1
make[1]: Leaving directory '/media/tom/document/Syn_Clode/project/folly-2018.01.08.00/folly/test'
Makefile:2315: recipe for target 'check-recursive' failed
make: *** [check-recursive] Error 1


tom@tom-Vostro-2421:/media/tom/document/Syn_Clode/project/folly-2018.01.08.00/folly$ sudo make install
[sudo] password for tom:
Making install in .
make[1]: Entering directory '/media/tom/document/Syn_Clode/project/folly-2018.01.08.00/folly'
make[2]: Entering directory '/media/tom/document/Syn_Clode/project/folly-2018.01.08.00/folly'
 /bin/mkdir -p '/usr/local/lib'
 /bin/bash ./libtool   --mode=install /usr/bin/install -c   libfolly.la libfollybenchmark.la '/usr/local/lib'
libtool: install: /usr/bin/install -c .libs/libfolly.so.57.0.0 /usr/local/lib/libfolly.so.57.0.0
libtool: install: (cd /usr/local/lib && { ln -s -f libfolly.so.57.0.0 libfolly.so.57 || { rm -f libfolly.so.57 && ln -s libfolly.so.57.0.0 libfolly.so.57; }; })
libtool: install: (cd /usr/local/lib && { ln -s -f libfolly.so.57.0.0 libfolly.so || { rm -f libfolly.so && ln -s libfolly.so.57.0.0 libfolly.so; }; })
libtool: install: /usr/bin/install -c .libs/libfolly.lai /usr/local/lib/libfolly.la
libtool: warning: relinking 'libfollybenchmark.la'
libtool: install: (cd /media/tom/document/Syn_Clode/project/folly-2018.01.08.00/folly; /bin/bash "/media/tom/document/Syn_Clode/project/folly-2018.01.08.00/folly/libtool"  --tag CXX --mode=relink g++ -std=gnu++1y -g -O2 -lboost_context -lboost_program_options -lboost_thread -lboost_filesystem -lboost_system -lboost_regex -lpthread -lboost_chrono -lssl -lcrypto -version-info 57:0:0 -o libfollybenchmark.la -rpath /usr/local/lib Benchmark.lo libfolly.la -llzma -lz -lsnappy -llz4 -liberty -ldl -levent -ldouble-conversion -lglog -lgflags )
libtool: relink: g++  -fPIC -DPIC -shared -nostdlib /usr/lib/gcc/x86_64-linux-gnu/5/../../../x86_64-linux-gnu/crti.o /usr/lib/gcc/x86_64-linux-gnu/5/crtbeginS.o  .libs/Benchmark.o   -lboost_context -lboost_program_options -lboost_thread -lboost_filesystem -lboost_system -lboost_regex -lpthread -lboost_chrono -lssl -lcrypto -L/usr/local/lib -lfolly -llzma -lz -lsnappy -llz4 -liberty -ldl -levent -ldouble-conversion -lglog -lgflags -L/usr/lib/gcc/x86_64-linux-gnu/5 -L/usr/lib/gcc/x86_64-linux-gnu/5/../../../x86_64-linux-gnu -L/usr/lib/gcc/x86_64-linux-gnu/5/../../../../lib -L/lib/x86_64-linux-gnu -L/lib/../lib -L/usr/lib/x86_64-linux-gnu -L/usr/lib/../lib -L/usr/lib/gcc/x86_64-linux-gnu/5/../../.. -lstdc++ -lm -lc -lgcc_s /usr/lib/gcc/x86_64-linux-gnu/5/crtendS.o /usr/lib/gcc/x86_64-linux-gnu/5/../../../x86_64-linux-gnu/crtn.o  -g -O2   -Wl,-soname -Wl,libfollybenchmark.so.57 -o .libs/libfollybenchmark.so.57.0.0
libtool: install: /usr/bin/install -c .libs/libfollybenchmark.so.57.0.0T /usr/local/lib/libfollybenchmark.so.57.0.0
libtool: install: (cd /usr/local/lib && { ln -s -f libfollybenchmark.so.57.0.0 libfollybenchmark.so.57 || { rm -f libfollybenchmark.so.57 && ln -s libfollybenchmark.so.57.0.0 libfollybenchmark.so.57; }; })
libtool: install: (cd /usr/local/lib && { ln -s -f libfollybenchmark.so.57.0.0 libfollybenchmark.so || { rm -f libfollybenchmark.so && ln -s libfollybenchmark.so.57.0.0 libfollybenchmark.so; }; })
libtool: install: /usr/bin/install -c .libs/libfollybenchmark.lai /usr/local/lib/libfollybenchmark.la
libtool: install: /usr/bin/install -c .libs/libfolly.a /usr/local/lib/libfolly.a
libtool: install: chmod 644 /usr/local/lib/libfolly.a
libtool: install: ranlib /usr/local/lib/libfolly.a
libtool: install: /usr/bin/install -c .libs/libfollybenchmark.a /usr/local/lib/libfollybenchmark.a
libtool: install: chmod 644 /usr/local/lib/libfollybenchmark.a
libtool: install: ranlib /usr/local/lib/libfollybenchmark.a
libtool: finish: PATH="/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/snap/bin:/sbin" ldconfig -n /usr/local/lib
----------------------------------------------------------------------
Libraries have been installed in:
   /usr/local/lib

If you ever happen to want to link against installed libraries
in a given directory, LIBDIR, you must either use libtool, and
specify the full pathname of the library, or use the '-LLIBDIR'
flag during linking and do at least one of the following:
   - add LIBDIR to the 'LD_LIBRARY_PATH' environment variable
     during execution
   - add LIBDIR to the 'LD_RUN_PATH' environment variable
     during linking
   - use the '-Wl,-rpath -Wl,LIBDIR' linker flag
   - have your system administrator add LIBDIR to '/etc/ld.so.conf'

See any operating system documentation about shared libraries for
more information, such as the ld(1) and ld.so(8) manual pages.
----------------------------------------------------------------------
 /bin/mkdir -p '/usr/local/include/folly'
 /usr/bin/install -c -m 644  AtomicBitSet.h AtomicHashArray.h AtomicHashArray-inl.h AtomicHashMap.h AtomicHashMap-inl.h AtomicIntrusiveLinkedList.h AtomicLinkedList.h AtomicUnorderedMap.h Benchmark.h Bits.h CachelinePadded.h Chrono.h ClockGettimeWrappers.h ConcurrentSkipList.h ConcurrentSkipList-inl.h Conv.h CppAttributes.h CpuId.h CPortability.h ConstexprMath.h Demangle.h DiscriminatedPtr.h DynamicConverter.h dynamic.h dynamic-inl.h Exception.h ExceptionString.h ExceptionWrapper.h ExceptionWrapper-inl.h Executor.h Expected.h FBString.h FBVector.h File.h FileUtil.h Fingerprint.h FixedString.h folly-config.h FormatArg.h FormatTraits.h '/usr/local/include/folly/.'
 /usr/bin/install -c -m 644  Format.h Format-inl.h GroupVarint.h Hash.h IPAddress.h IPAddressV4.h IPAddressV6.h IPAddressException.h Indestructible.h IndexedMemPool.h IntrusiveList.h json.h Lazy.h Likely.h LockTraits.h LockTraitsBoost.h Logging.h MacAddress.h MapUtil.h Math.h Memory.h MicroSpinLock.h MicroLock.h MoveWrapper.h MPMCPipeline.h MPMCQueue.h Optional.h Overload.h PackedSyncPtr.h Padded.h PicoSpinLock.h Poly.h Poly-inl.h Portability.h Preprocessor.h PriorityMPMCQueue.h ProducerConsumerQueue.h Random.h Random-inl.h Range.h '/usr/local/include/folly/.'
 /bin/mkdir -p '/usr/local/include/folly/experimental/hazptr'
 /usr/bin/install -c -m 644  experimental/hazptr/debug.h experimental/hazptr/hazptr.h experimental/hazptr/hazptr-impl.h experimental/hazptr/memory_resource.h '/usr/local/include/folly/experimental/hazptr'
 /bin/mkdir -p '/usr/local/include/folly/synchronization'
 /usr/bin/install -c -m 644  synchronization/AsymmetricMemoryBarrier.h synchronization/AtomicStruct.h synchronization/Baton.h synchronization/CallOnce.h synchronization/LifoSem.h synchronization/ParkingLot.h synchronization/RWSpinLock.h synchronization/SaturatingSemaphore.h '/usr/local/include/folly/synchronization'
 /bin/mkdir -p '/usr/local/include/folly/memory'
 /usr/bin/install -c -m 644  memory/Arena.h memory/Arena-inl.h memory/MallctlHelper.h memory/Malloc.h memory/ThreadCachedArena.h memory/UninitializedMemoryHacks.h '/usr/local/include/folly/memory'
 /bin/mkdir -p '/usr/local/include/folly/futures/test'
 /usr/bin/install -c -m 644  futures/test/TestExecutor.h '/usr/local/include/folly/futures/test'
 /bin/mkdir -p '/usr/local/include/folly/futures'
 /usr/bin/install -c -m 644  futures/Barrier.h futures/Future-pre.h futures/helpers.h futures/Future.h futures/Future-inl.h futures/FutureException.h futures/FutureSplitter.h futures/Promise-inl.h futures/Promise.h futures/SharedPromise.h futures/SharedPromise-inl.h futures/ThreadWheelTimekeeper.h futures/Timekeeper.h '/usr/local/include/folly/futures'
 /bin/mkdir -p '/usr/local/include/folly/memory/detail'
 /usr/bin/install -c -m 644  memory/detail/MallocImpl.h '/usr/local/include/folly/memory/detail'
 /bin/mkdir -p '/usr/local/include/folly/stats/detail'
 /usr/bin/install -c -m 644  stats/detail/Bucket.h '/usr/local/include/folly/stats/detail'
 /bin/mkdir -p '/usr/local/include/folly/concurrency'
 /usr/bin/install -c -m 644  concurrency/CacheLocality.h concurrency/ConcurrentHashMap.h concurrency/CoreCachedSharedPtr.h concurrency/UnboundedQueue.h concurrency/AtomicSharedPtr.h '/usr/local/include/folly/concurrency'
 /bin/mkdir -p '/usr/local/include/folly/container'
 /usr/bin/install -c -m 644  container/Access.h container/Array.h container/Iterator.h container/Enumerate.h container/EvictingCacheMap.h container/Foreach.h container/Foreach-inl.h container/SparseByteSet.h '/usr/local/include/folly/container'
 /bin/mkdir -p '/usr/local/include/folly/experimental'
 /usr/bin/install -c -m 644  experimental/AutoTimer.h experimental/ThreadedRepeatingFunctionRunner.h experimental/Bits.h experimental/BitVectorCoding.h experimental/CodingDetail.h experimental/DynamicParser.h experimental/DynamicParser-inl.h experimental/ExecutionObserver.h experimental/EliasFanoCoding.h experimental/EnvUtil.h experimental/EventCount.h experimental/Instructions.h experimental/FunctionScheduler.h experimental/FutureDAG.h experimental/JemallocNodumpAllocator.h experimental/JSONSchema.h experimental/LockFreeRingBuffer.h experimental/NestedCommandLineApp.h experimental/ProgramOptions.h experimental/ReadMostlySharedPtr.h experimental/Select64.h experimental/StampedPtr.h experimental/StringKeyedCommon.h experimental/StringKeyedMap.h experimental/StringKeyedSet.h experimental/StringKeyedUnorderedMap.h experimental/StringKeyedUnorderedSet.h experimental/TestUtil.h experimental/TLRefCount.h experimental/TupleOps.h '/usr/local/include/folly/experimental'
 /bin/mkdir -p '/usr/local/include/folly/compression'
 /usr/bin/install -c -m 644  compression/Compression.h compression/Utils.h compression/Zlib.h '/usr/local/include/folly/compression'
 /bin/mkdir -p '/usr/local/include/folly/futures/detail'
 /usr/bin/install -c -m 644  futures/detail/Core.h futures/detail/FSM.h futures/detail/Types.h '/usr/local/include/folly/futures/detail'
 /bin/mkdir -p '/usr/local/include/folly/synchronization/detail'
 /usr/bin/install -c -m 644  synchronization/detail/AtomicUtils.h synchronization/detail/Sleeper.h '/usr/local/include/folly/synchronization/detail'
 /bin/mkdir -p '/usr/local/include/folly/poly'
 /usr/bin/install -c -m 644  poly/Nullable.h poly/Regular.h '/usr/local/include/folly/poly'
 /bin/mkdir -p '/usr/local/include/folly/experimental/io'
 /usr/bin/install -c -m 644  experimental/io/FsUtil.h experimental/io/HugePages.h '/usr/local/include/folly/experimental/io'
 /bin/mkdir -p '/usr/local/include/folly/experimental/observer/detail'
 /usr/bin/install -c -m 644  experimental/observer/detail/Core.h experimental/observer/detail/GraphCycleDetector.h experimental/observer/detail/ObserverManager.h experimental/observer/detail/Observer-pre.h '/usr/local/include/folly/experimental/observer/detail'
 /bin/mkdir -p '/usr/local/include/folly/init'
 /usr/bin/install -c -m 644  init/Init.h '/usr/local/include/folly/init'
 /bin/mkdir -p '/usr/local/include/folly/fibers'
 /usr/bin/install -c -m 644  fibers/AddTasks.h fibers/AddTasks-inl.h fibers/AtomicBatchDispatcher.h fibers/AtomicBatchDispatcher-inl.h fibers/Baton.h fibers/Baton-inl.h fibers/BatchDispatcher.h fibers/BoostContextCompatibility.h fibers/EventBaseLoopController.h fibers/EventBaseLoopController-inl.h fibers/Fiber.h fibers/Fiber-inl.h fibers/FiberManager.h fibers/FiberManager-inl.h fibers/FiberManagerInternal.h fibers/FiberManagerInternal-inl.h fibers/FiberManagerMap.h fibers/ForEach.h fibers/ForEach-inl.h fibers/GenericBaton.h fibers/GuardPageAllocator.h fibers/LoopController.h fibers/Promise.h fibers/Promise-inl.h fibers/Semaphore.h fibers/SimpleLoopController.h fibers/TimedMutex.h fibers/TimedMutex-inl.h fibers/TimeoutController.h fibers/traits.h fibers/WhenN.h fibers/WhenN-inl.h '/usr/local/include/folly/fibers'
 /bin/mkdir -p '/usr/local/include/folly/experimental/observer'
 /usr/bin/install -c -m 644  experimental/observer/Observable.h experimental/observer/Observable-inl.h experimental/observer/Observer.h experimental/observer/Observer-inl.h experimental/observer/SimpleObservable.h experimental/observer/SimpleObservable-inl.h '/usr/local/include/folly/experimental/observer'
 /bin/mkdir -p '/usr/local/include/folly/concurrency/detail'
 /usr/bin/install -c -m 644  concurrency/detail/ConcurrentHashMap-detail.h concurrency/detail/AtomicSharedPtr-detail.h '/usr/local/include/folly/concurrency/detail'
 /bin/mkdir -p '/usr/local/include/folly/experimental/exception_tracer'
 /usr/bin/install -c -m 644  experimental/exception_tracer/ExceptionAbi.h experimental/exception_tracer/ExceptionCounterLib.h experimental/exception_tracer/ExceptionTracer.h experimental/exception_tracer/ExceptionTracerLib.h experimental/exception_tracer/StackTrace.h '/usr/local/include/folly/experimental/exception_tracer'
 /bin/mkdir -p '/usr/local/include/folly/experimental/bser'
 /usr/bin/install -c -m 644  experimental/bser/Bser.h '/usr/local/include/folly/experimental/bser'
 /bin/mkdir -p '/usr/local/include/folly/experimental/symbolizer'
 /usr/bin/install -c -m 644  experimental/symbolizer/Elf.h experimental/symbolizer/Elf-inl.h experimental/symbolizer/ElfCache.h experimental/symbolizer/Dwarf.h experimental/symbolizer/LineReader.h experimental/symbolizer/SignalHandler.h experimental/symbolizer/StackTrace.h experimental/symbolizer/Symbolizer.h '/usr/local/include/folly/experimental/symbolizer'
 /bin/mkdir -p '/usr/local/include/folly/ssl'
 /usr/bin/install -c -m 644  ssl/Init.h ssl/OpenSSLCertUtils.h ssl/OpenSSLHash.h ssl/OpenSSLPtrTypes.h ssl/OpenSSLVersionFinder.h ssl/SSLSession.h ssl/OpenSSLLockTypes.h '/usr/local/include/folly/ssl'
 /bin/mkdir -p '/usr/local/include/folly/test'
 /usr/bin/install -c -m 644  test/FBStringTestBenchmarks.cpp.h test/FBVectorTestBenchmarks.cpp.h test/SynchronizedTestLib.h test/SynchronizedTestLib-inl.h test/TestUtils.h '/usr/local/include/folly/test'
 /bin/mkdir -p '/usr/local/include/folly/hash/detail'
 /usr/bin/install -c -m 644  hash/detail/ChecksumDetail.h '/usr/local/include/folly/hash/detail'
 /bin/mkdir -p '/usr/local/include/folly/container/detail'
 /usr/bin/install -c -m 644  container/detail/BitIteratorDetail.h '/usr/local/include/folly/container/detail'
 /bin/mkdir -p '/usr/local/include/folly/gen'
 /usr/bin/install -c -m 644  gen/Base.h gen/Base-inl.h gen/Combine.h gen/Combine-inl.h gen/Core.h gen/Core-inl.h gen/File.h gen/File-inl.h gen/Parallel.h gen/Parallel-inl.h gen/ParallelMap.h gen/ParallelMap-inl.h gen/String.h gen/String-inl.h '/usr/local/include/folly/gen'
 /bin/mkdir -p '/usr/local/include/folly/executors/task_queue'
 /usr/bin/install -c -m 644  executors/task_queue/BlockingQueue.h executors/task_queue/LifoSemMPMCQueue.h executors/task_queue/PriorityLifoSemMPMCQueue.h executors/task_queue/UnboundedBlockingQueue.h '/usr/local/include/folly/executors/task_queue'
 /bin/mkdir -p '/usr/local/include/folly/executors'
 /usr/bin/install -c -m 644  executors/Async.h executors/CPUThreadPoolExecutor.h executors/Codel.h executors/DrivableExecutor.h executors/FiberIOExecutor.h executors/FutureExecutor.h executors/GlobalExecutor.h executors/GlobalThreadPoolList.h executors/InlineExecutor.h executors/IOExecutor.h executors/IOObjectCache.h executors/IOThreadPoolExecutor.h executors/NotificationQueueExecutor.h executors/ScheduledExecutor.h executors/SerialExecutor.h executors/ThreadPoolExecutor.h executors/ThreadedExecutor.h '/usr/local/include/folly/executors'
 /bin/mkdir -p '/usr/local/include/folly/functional'
 /usr/bin/install -c -m 644  functional/ApplyTuple.h functional/Invoke.h functional/Partial.h '/usr/local/include/folly/functional'
 /bin/mkdir -p '/usr/local/include/folly/chrono'
 /usr/bin/install -c -m 644  chrono/Conv.h '/usr/local/include/folly/chrono'
 /bin/mkdir -p '/usr/local/include/folly/io/async/test'
 /usr/bin/install -c -m 644  io/async/test/AsyncSSLSocketTest.h io/async/test/AsyncSocketTest2.h io/async/test/BlockingSocket.h io/async/test/MockAsyncSocket.h io/async/test/MockAsyncServerSocket.h io/async/test/MockAsyncSSLSocket.h io/async/test/MockAsyncTransport.h io/async/test/MockAsyncUDPSocket.h io/async/test/MockTimeoutManager.h io/async/test/ScopedBoundPort.h io/async/test/SocketPair.h io/async/test/TestSSLServer.h io/async/test/TimeUtil.h io/async/test/UndelayedDestruction.h io/async/test/Util.h '/usr/local/include/folly/io/async/test'
 /bin/mkdir -p '/usr/local/include/folly/ssl/detail'
 /usr/bin/install -c -m 644  ssl/detail/OpenSSLThreading.h ssl/detail/SSLSessionImpl.h '/usr/local/include/folly/ssl/detail'
 /bin/mkdir -p '/usr/local/include/folly/executors/thread_factory'
 /usr/bin/install -c -m 644  executors/thread_factory/NamedThreadFactory.h executors/thread_factory/PriorityThreadFactory.h executors/thread_factory/ThreadFactory.h '/usr/local/include/folly/executors/thread_factory'
 /bin/mkdir -p '/usr/local/include/folly/lang'
 /usr/bin/install -c -m 644  lang/Align.h lang/Assume.h lang/Bits.h lang/ColdClass.h lang/Launder.h lang/RValueReferenceWrapper.h lang/SafeAssert.h '/usr/local/include/folly/lang'
 /bin/mkdir -p '/usr/local/include/folly/io/async'
 /usr/bin/install -c -m 644  io/async/AsyncPipe.h io/async/AsyncTimeout.h io/async/AsyncTransport.h io/async/AsyncUDPServerSocket.h io/async/AsyncUDPSocket.h io/async/AsyncServerSocket.h io/async/AsyncSignalHandler.h io/async/AsyncSocket.h io/async/AsyncSocketBase.h io/async/AsyncSSLSocket.h io/async/AsyncSocketException.h io/async/DecoratedAsyncTransportWrapper.h io/async/DelayedDestructionBase.h io/async/DelayedDestruction.h io/async/DestructorCheck.h io/async/EventBase.h io/async/EventBaseLocal.h io/async/EventBaseManager.h io/async/EventBaseThread.h io/async/EventFDWrapper.h io/async/EventHandler.h io/async/EventUtil.h io/async/NotificationQueue.h io/async/HHWheelTimer.h io/async/Request.h io/async/SSLContext.h io/async/SSLOptions.h io/async/ScopedEventBaseThread.h io/async/TimeoutManager.h io/async/VirtualEventBase.h io/async/WriteChainAsyncTransportWrapper.h '/usr/local/include/folly/io/async'
 /bin/mkdir -p '/usr/local/include/folly/stats'
 /usr/bin/install -c -m 644  stats/BucketedTimeSeries-defs.h stats/BucketedTimeSeries.h stats/Histogram-defs.h stats/Histogram.h stats/MultiLevelTimeSeries-defs.h stats/MultiLevelTimeSeries.h stats/TimeseriesHistogram-defs.h stats/TimeseriesHistogram.h '/usr/local/include/folly/stats'
 /bin/mkdir -p '/usr/local/include/folly/detail'
 /usr/bin/install -c -m 644  detail/AtFork.h detail/AtomicHashUtils.h detail/AtomicUnorderedMapUtils.h detail/DiscriminatedPtrDetail.h detail/FileUtilDetail.h detail/FingerprintPolynomial.h detail/Futex.h detail/GroupVarintDetail.h detail/IPAddress.h detail/IPAddressSource.h detail/MemoryIdler.h detail/MPMCPipelineDetail.h detail/PolyDetail.h detail/RangeCommon.h detail/RangeSse42.h detail/SlowFingerprint.h detail/SocketFastOpen.h detail/StaticSingletonManager.h detail/ThreadLocalDetail.h detail/TypeList.h detail/TurnSequencer.h '/usr/local/include/folly/detail'
 /bin/mkdir -p '/usr/local/include/folly/tracing'
 /usr/bin/install -c -m 644  tracing/StaticTracepoint.h tracing/ScopedTraceSection.h '/usr/local/include/folly/tracing'
 /bin/mkdir -p '/usr/local/include/folly/io/async/ssl'
 /usr/bin/install -c -m 644  io/async/ssl/OpenSSLUtils.h io/async/ssl/SSLErrors.h io/async/ssl/TLSDefinitions.h '/usr/local/include/folly/io/async/ssl'
 /usr/bin/install -c -m 644  Replaceable.h ScopeGuard.h SharedMutex.h Singleton.h Singleton-inl.h SingletonThreadLocal.h SmallLocks.h small_vector.h SocketAddress.h sorted_vector_types.h SpinLock.h stop_watch.h String.h String-inl.h Subprocess.h Synchronized.h SynchronizedPtr.h ThreadCachedInt.h ThreadLocal.h TimeoutQueue.h TokenBucket.h Traits.h Try-inl.h Try.h Unicode.h Function.h UncaughtExceptions.h Unit.h Uri.h Uri-inl.h Utility.h Varint.h '/usr/local/include/folly/.'
 /bin/mkdir -p '/usr/local/include/folly/system'
 /usr/bin/install -c -m 644  system/MemoryMapping.h system/Shell.h system/ThreadId.h system/ThreadName.h system/VersionCheck.h '/usr/local/include/folly/system'
 /bin/mkdir -p '/usr/local/include/folly/io'
 /usr/bin/install -c -m 644  io/Cursor.h io/Cursor-inl.h io/IOBuf.h io/IOBufQueue.h io/RecordIO.h io/RecordIO-inl.h io/TypedIOBuf.h io/ShutdownSocketSet.h '/usr/local/include/folly/io'
 /bin/mkdir -p '/usr/local/include/folly/portability'
 /usr/bin/install -c -m 644  portability/Asm.h portability/Atomic.h portability/BitsFunctexcept.h portability/Builtins.h portability/Config.h portability/Constexpr.h portability/Dirent.h portability/Event.h portability/Fcntl.h portability/GFlags.h portability/GMock.h portability/GTest.h portability/IOVec.h portability/Libgen.h portability/Malloc.h portability/Math.h portability/Memory.h portability/OpenSSL.h portability/PThread.h portability/Semaphore.h portability/Sockets.h portability/Stdio.h portability/Stdlib.h portability/String.h portability/Syslog.h portability/SysFile.h portability/SysMembarrier.h portability/SysMman.h portability/SysResource.h portability/SysStat.h portability/SysSyscall.h portability/SysTime.h portability/SysTypes.h portability/SysUio.h portability/Time.h portability/TypeTraits.h portability/Unistd.h portability/Windows.h '/usr/local/include/folly/portability'
 /bin/mkdir -p '/usr/local/include/folly/experimental/logging'
 /usr/bin/install -c -m 644  experimental/logging/AsyncFileWriter.h experimental/logging/FileHandlerFactory.h experimental/logging/FileWriterFactory.h experimental/logging/GlogStyleFormatter.h experimental/logging/ImmediateFileWriter.h experimental/logging/Init.h experimental/logging/LogCategory.h experimental/logging/LogCategoryConfig.h experimental/logging/LogConfig.h experimental/logging/LogConfigParser.h experimental/logging/LogFormatter.h experimental/logging/Logger.h experimental/logging/LoggerDB.h experimental/logging/LogHandler.h experimental/logging/LogHandlerFactory.h experimental/logging/LogHandlerConfig.h experimental/logging/LogLevel.h experimental/logging/LogMessage.h experimental/logging/LogName.h experimental/logging/LogStream.h experimental/logging/LogStreamProcessor.h experimental/logging/LogWriter.h experimental/logging/printf.h experimental/logging/RateLimiter.h experimental/logging/StandardLogHandler.h experimental/logging/StandardLogHandlerFactory.h experimental/logging/StreamHandlerFactory.h experimental/logging/xlog.h '/usr/local/include/folly/experimental/logging'
 /bin/mkdir -p '/usr/local/include/folly/test/function_benchmark'
 /usr/bin/install -c -m 644  test/function_benchmark/benchmark_impl.h test/function_benchmark/test_functions.h '/usr/local/include/folly/test/function_benchmark'
 /bin/mkdir -p '/usr/local/include/folly/hash'
 /usr/bin/install -c -m 644  hash/Checksum.h hash/Hash.h hash/SpookyHashV1.h hash/SpookyHashV2.h '/usr/local/include/folly/hash'
 /bin/mkdir -p '/usr/local/include/folly/fibers/detail'
 /usr/bin/install -c -m 644  fibers/detail/AtomicBatchDispatcher.h '/usr/local/include/folly/fibers/detail'
 /bin/mkdir -p '/usr/local/lib/pkgconfig'
 /usr/bin/install -c -m 644 libfolly.pc '/usr/local/lib/pkgconfig'
make[2]: Leaving directory '/media/tom/document/Syn_Clode/project/folly-2018.01.08.00/folly'
make[1]: Leaving directory '/media/tom/document/Syn_Clode/project/folly-2018.01.08.00/folly'
Making install in test
make[1]: Entering directory '/media/tom/document/Syn_Clode/project/folly-2018.01.08.00/folly/test'
Making install in .
make[2]: Entering directory '/media/tom/document/Syn_Clode/project/folly-2018.01.08.00/folly/test'
make[3]: Entering directory '/media/tom/document/Syn_Clode/project/folly-2018.01.08.00/folly/test'
make[3]: Nothing to be done for 'install-exec-am'.
make[3]: Nothing to be done for 'install-data-am'.
make[3]: Leaving directory '/media/tom/document/Syn_Clode/project/folly-2018.01.08.00/folly/test'
make[2]: Leaving directory '/media/tom/document/Syn_Clode/project/folly-2018.01.08.00/folly/test'
Making install in function_benchmark
make[2]: Entering directory '/media/tom/document/Syn_Clode/project/folly-2018.01.08.00/folly/test/function_benchmark'
make[3]: Entering directory '/media/tom/document/Syn_Clode/project/folly-2018.01.08.00/folly/test/function_benchmark'
make[3]: Nothing to be done for 'install-exec-am'.
make[3]: Nothing to be done for 'install-data-am'.
make[3]: Leaving directory '/media/tom/document/Syn_Clode/project/folly-2018.01.08.00/folly/test/function_benchmark'
make[2]: Leaving directory '/media/tom/document/Syn_Clode/project/folly-2018.01.08.00/folly/test/function_benchmark'
make[1]: Leaving directory '/media/tom/document/Syn_Clode/project/folly-2018.01.08.00/folly/test'
Making install in experimental
make[1]: Entering directory '/media/tom/document/Syn_Clode/project/folly-2018.01.08.00/folly/experimental'
Making install in io/test
make[2]: Entering directory '/media/tom/document/Syn_Clode/project/folly-2018.01.08.00/folly/experimental/io/test'
make[3]: Entering directory '/media/tom/document/Syn_Clode/project/folly-2018.01.08.00/folly/experimental/io/test'
make[3]: Nothing to be done for 'install-exec-am'.
make[3]: Nothing to be done for 'install-data-am'.
make[3]: Leaving directory '/media/tom/document/Syn_Clode/project/folly-2018.01.08.00/folly/experimental/io/test'
make[2]: Leaving directory '/media/tom/document/Syn_Clode/project/folly-2018.01.08.00/folly/experimental/io/test'
Making install in logging
make[2]: Entering directory '/media/tom/document/Syn_Clode/project/folly-2018.01.08.00/folly/experimental/logging'
Making install in .
make[3]: Entering directory '/media/tom/document/Syn_Clode/project/folly-2018.01.08.00/folly/experimental/logging'
make[4]: Entering directory '/media/tom/document/Syn_Clode/project/folly-2018.01.08.00/folly/experimental/logging'
 /bin/mkdir -p '/usr/local/lib'
 /bin/bash ../../libtool   --mode=install /usr/bin/install -c   libfollylogging.la '/usr/local/lib'
libtool: warning: relinking 'libfollylogging.la'
libtool: install: (cd /media/tom/document/Syn_Clode/project/folly-2018.01.08.00/folly/experimental/logging; /bin/bash "/media/tom/document/Syn_Clode/project/folly-2018.01.08.00/folly/libtool"  --tag CXX --mode=relink g++ -std=gnu++1y -g -O2 -lboost_context -lboost_program_options -lboost_thread -lboost_filesystem -lboost_system -lboost_regex -lpthread -lboost_chrono -lssl -lcrypto -version-info 57:0:0 -o libfollylogging.la -rpath /usr/local/lib AsyncFileWriter.lo FileHandlerFactory.lo FileWriterFactory.lo GlogStyleFormatter.lo ImmediateFileWriter.lo Init.lo LogCategory.lo LogCategoryConfig.lo LogConfig.lo LogConfigParser.lo Logger.lo LoggerDB.lo LogHandlerConfig.lo LogLevel.lo LogMessage.lo LogName.lo LogStream.lo LogStreamProcessor.lo printf.lo RateLimiter.lo StandardLogHandler.lo StandardLogHandlerFactory.lo StreamHandlerFactory.lo xlog.lo ../../libfolly.la -llzma -lz -lsnappy -llz4 -liberty -ldl -levent -ldouble-conversion -lglog -lgflags )
libtool: relink: g++  -fPIC -DPIC -shared -nostdlib /usr/lib/gcc/x86_64-linux-gnu/5/../../../x86_64-linux-gnu/crti.o /usr/lib/gcc/x86_64-linux-gnu/5/crtbeginS.o  .libs/AsyncFileWriter.o .libs/FileHandlerFactory.o .libs/FileWriterFactory.o .libs/GlogStyleFormatter.o .libs/ImmediateFileWriter.o .libs/Init.o .libs/LogCategory.o .libs/LogCategoryConfig.o .libs/LogConfig.o .libs/LogConfigParser.o .libs/Logger.o .libs/LoggerDB.o .libs/LogHandlerConfig.o .libs/LogLevel.o .libs/LogMessage.o .libs/LogName.o .libs/LogStream.o .libs/LogStreamProcessor.o .libs/printf.o .libs/RateLimiter.o .libs/StandardLogHandler.o .libs/StandardLogHandlerFactory.o .libs/StreamHandlerFactory.o .libs/xlog.o   -lboost_context -lboost_program_options -lboost_thread -lboost_filesystem -lboost_system -lboost_regex -lpthread -lboost_chrono -lssl -lcrypto -L/usr/local/lib -lfolly -llzma -lz -lsnappy -llz4 -liberty -ldl -levent -ldouble-conversion -lglog -lgflags -L/usr/lib/gcc/x86_64-linux-gnu/5 -L/usr/lib/gcc/x86_64-linux-gnu/5/../../../x86_64-linux-gnu -L/usr/lib/gcc/x86_64-linux-gnu/5/../../../../lib -L/lib/x86_64-linux-gnu -L/lib/../lib -L/usr/lib/x86_64-linux-gnu -L/usr/lib/../lib -L/usr/lib/gcc/x86_64-linux-gnu/5/../../.. -lstdc++ -lm -lc -lgcc_s /usr/lib/gcc/x86_64-linux-gnu/5/crtendS.o /usr/lib/gcc/x86_64-linux-gnu/5/../../../x86_64-linux-gnu/crtn.o  -g -O2   -Wl,-soname -Wl,libfollylogging.so.57 -o .libs/libfollylogging.so.57.0.0
libtool: install: /usr/bin/install -c .libs/libfollylogging.so.57.0.0T /usr/local/lib/libfollylogging.so.57.0.0
libtool: install: (cd /usr/local/lib && { ln -s -f libfollylogging.so.57.0.0 libfollylogging.so.57 || { rm -f libfollylogging.so.57 && ln -s libfollylogging.so.57.0.0 libfollylogging.so.57; }; })
libtool: install: (cd /usr/local/lib && { ln -s -f libfollylogging.so.57.0.0 libfollylogging.so || { rm -f libfollylogging.so && ln -s libfollylogging.so.57.0.0 libfollylogging.so; }; })
libtool: install: /usr/bin/install -c .libs/libfollylogging.lai /usr/local/lib/libfollylogging.la
libtool: install: /usr/bin/install -c .libs/libfollylogging.a /usr/local/lib/libfollylogging.a
libtool: install: chmod 644 /usr/local/lib/libfollylogging.a
libtool: install: ranlib /usr/local/lib/libfollylogging.a
libtool: finish: PATH="/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/snap/bin:/sbin" ldconfig -n /usr/local/lib
----------------------------------------------------------------------
Libraries have been installed in:
   /usr/local/lib

If you ever happen to want to link against installed libraries
in a given directory, LIBDIR, you must either use libtool, and
specify the full pathname of the library, or use the '-LLIBDIR'
flag during linking and do at least one of the following:
   - add LIBDIR to the 'LD_LIBRARY_PATH' environment variable
     during execution
   - add LIBDIR to the 'LD_RUN_PATH' environment variable
     during linking
   - use the '-Wl,-rpath -Wl,LIBDIR' linker flag
   - have your system administrator add LIBDIR to '/etc/ld.so.conf'

See any operating system documentation about shared libraries for
more information, such as the ld(1) and ld.so(8) manual pages.
----------------------------------------------------------------------
make[4]: Nothing to be done for 'install-data-am'.
make[4]: Leaving directory '/media/tom/document/Syn_Clode/project/folly-2018.01.08.00/folly/experimental/logging'
make[3]: Leaving directory '/media/tom/document/Syn_Clode/project/folly-2018.01.08.00/folly/experimental/logging'
Making install in example
make[3]: Entering directory '/media/tom/document/Syn_Clode/project/folly-2018.01.08.00/folly/experimental/logging/example'
make[4]: Entering directory '/media/tom/document/Syn_Clode/project/folly-2018.01.08.00/folly/experimental/logging/example'
make[4]: Nothing to be done for 'install-exec-am'.
make[4]: Nothing to be done for 'install-data-am'.
make[4]: Leaving directory '/media/tom/document/Syn_Clode/project/folly-2018.01.08.00/folly/experimental/logging/example'
make[3]: Leaving directory '/media/tom/document/Syn_Clode/project/folly-2018.01.08.00/folly/experimental/logging/example'
make[2]: Leaving directory '/media/tom/document/Syn_Clode/project/folly-2018.01.08.00/folly/experimental/logging'
Making install in symbolizer
make[2]: Entering directory '/media/tom/document/Syn_Clode/project/folly-2018.01.08.00/folly/experimental/symbolizer'
Making install in .
make[3]: Entering directory '/media/tom/document/Syn_Clode/project/folly-2018.01.08.00/folly/experimental/symbolizer'
make[4]: Entering directory '/media/tom/document/Syn_Clode/project/folly-2018.01.08.00/folly/experimental/symbolizer'
 /bin/mkdir -p '/usr/local/lib'
 /bin/bash ../../libtool   --mode=install /usr/bin/install -c   libfollysymbolizer.la '/usr/local/lib'
libtool: warning: relinking 'libfollysymbolizer.la'
libtool: install: (cd /media/tom/document/Syn_Clode/project/folly-2018.01.08.00/folly/experimental/symbolizer; /bin/bash "/media/tom/document/Syn_Clode/project/folly-2018.01.08.00/folly/libtool"  --tag CXX --mode=relink g++ -std=gnu++1y -g -O2 -lboost_context -lboost_program_options -lboost_thread -lboost_filesystem -lboost_system -lboost_regex -lpthread -lboost_chrono -lssl -lcrypto -version-info 57:0:0 -o libfollysymbolizer.la -rpath /usr/local/lib Elf.lo ElfCache.lo Dwarf.lo LineReader.lo SignalHandler.lo StackTrace.lo Symbolizer.lo ../../libfolly.la -llzma -lz -lsnappy -llz4 -liberty -ldl -levent -ldouble-conversion -lglog -lgflags )
libtool: relink: g++  -fPIC -DPIC -shared -nostdlib /usr/lib/gcc/x86_64-linux-gnu/5/../../../x86_64-linux-gnu/crti.o /usr/lib/gcc/x86_64-linux-gnu/5/crtbeginS.o  .libs/Elf.o .libs/ElfCache.o .libs/Dwarf.o .libs/LineReader.o .libs/SignalHandler.o .libs/StackTrace.o .libs/Symbolizer.o   -lboost_context -lboost_program_options -lboost_thread -lboost_filesystem -lboost_system -lboost_regex -lpthread -lboost_chrono -lssl -lcrypto -L/usr/local/lib -lfolly -llzma -lz -lsnappy -llz4 -liberty -ldl -levent -ldouble-conversion -lglog -lgflags -L/usr/lib/gcc/x86_64-linux-gnu/5 -L/usr/lib/gcc/x86_64-linux-gnu/5/../../../x86_64-linux-gnu -L/usr/lib/gcc/x86_64-linux-gnu/5/../../../../lib -L/lib/x86_64-linux-gnu -L/lib/../lib -L/usr/lib/x86_64-linux-gnu -L/usr/lib/../lib -L/usr/lib/gcc/x86_64-linux-gnu/5/../../.. -lstdc++ -lm -lc -lgcc_s /usr/lib/gcc/x86_64-linux-gnu/5/crtendS.o /usr/lib/gcc/x86_64-linux-gnu/5/../../../x86_64-linux-gnu/crtn.o  -g -O2   -Wl,-soname -Wl,libfollysymbolizer.so.57 -o .libs/libfollysymbolizer.so.57.0.0
libtool: install: /usr/bin/install -c .libs/libfollysymbolizer.so.57.0.0T /usr/local/lib/libfollysymbolizer.so.57.0.0
libtool: install: (cd /usr/local/lib && { ln -s -f libfollysymbolizer.so.57.0.0 libfollysymbolizer.so.57 || { rm -f libfollysymbolizer.so.57 && ln -s libfollysymbolizer.so.57.0.0 libfollysymbolizer.so.57; }; })
libtool: install: (cd /usr/local/lib && { ln -s -f libfollysymbolizer.so.57.0.0 libfollysymbolizer.so || { rm -f libfollysymbolizer.so && ln -s libfollysymbolizer.so.57.0.0 libfollysymbolizer.so; }; })
libtool: install: /usr/bin/install -c .libs/libfollysymbolizer.lai /usr/local/lib/libfollysymbolizer.la
libtool: install: /usr/bin/install -c .libs/libfollysymbolizer.a /usr/local/lib/libfollysymbolizer.a
libtool: install: chmod 644 /usr/local/lib/libfollysymbolizer.a
libtool: install: ranlib /usr/local/lib/libfollysymbolizer.a
libtool: finish: PATH="/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/snap/bin:/sbin" ldconfig -n /usr/local/lib
----------------------------------------------------------------------
Libraries have been installed in:
   /usr/local/lib

If you ever happen to want to link against installed libraries
in a given directory, LIBDIR, you must either use libtool, and
specify the full pathname of the library, or use the '-LLIBDIR'
flag during linking and do at least one of the following:
   - add LIBDIR to the 'LD_LIBRARY_PATH' environment variable
     during execution
   - add LIBDIR to the 'LD_RUN_PATH' environment variable
     during linking
   - use the '-Wl,-rpath -Wl,LIBDIR' linker flag
   - have your system administrator add LIBDIR to '/etc/ld.so.conf'

See any operating system documentation about shared libraries for
more information, such as the ld(1) and ld.so(8) manual pages.
----------------------------------------------------------------------
make[4]: Nothing to be done for 'install-data-am'.
make[4]: Leaving directory '/media/tom/document/Syn_Clode/project/folly-2018.01.08.00/folly/experimental/symbolizer'
make[3]: Leaving directory '/media/tom/document/Syn_Clode/project/folly-2018.01.08.00/folly/experimental/symbolizer'
make[2]: Leaving directory '/media/tom/document/Syn_Clode/project/folly-2018.01.08.00/folly/experimental/symbolizer'
make[2]: Entering directory '/media/tom/document/Syn_Clode/project/folly-2018.01.08.00/folly/experimental'
make[3]: Entering directory '/media/tom/document/Syn_Clode/project/folly-2018.01.08.00/folly/experimental'
make[3]: Nothing to be done for 'install-exec-am'.
make[3]: Nothing to be done for 'install-data-am'.
make[3]: Leaving directory '/media/tom/document/Syn_Clode/project/folly-2018.01.08.00/folly/experimental'
make[2]: Leaving directory '/media/tom/document/Syn_Clode/project/folly-2018.01.08.00/folly/experimental'
make[1]: Leaving directory '/media/tom/document/Syn_Clode/project/folly-2018.01.08.00/folly/experimental'
Making install in init
make[1]: Entering directory '/media/tom/document/Syn_Clode/project/folly-2018.01.08.00/folly/init'
Making install in .
make[2]: Entering directory '/media/tom/document/Syn_Clode/project/folly-2018.01.08.00/folly/init'
make[3]: Entering directory '/media/tom/document/Syn_Clode/project/folly-2018.01.08.00/folly/init'
 /bin/mkdir -p '/usr/local/lib'
 /bin/bash ../libtool   --mode=install /usr/bin/install -c   libfollyinit.la '/usr/local/lib'
libtool: warning: relinking 'libfollyinit.la'
libtool: install: (cd /media/tom/document/Syn_Clode/project/folly-2018.01.08.00/folly/init; /bin/bash "/media/tom/document/Syn_Clode/project/folly-2018.01.08.00/folly/libtool"  --tag CXX --mode=relink g++ -std=gnu++1y -g -O2 -lboost_context -lboost_program_options -lboost_thread -lboost_filesystem -lboost_system -lboost_regex -lpthread -lboost_chrono -lssl -lcrypto -version-info 57:0:0 -o libfollyinit.la -rpath /usr/local/lib Init.lo ../libfolly.la -llzma -lz -lsnappy -llz4 -liberty -ldl -levent -ldouble-conversion -lglog -lgflags )
libtool: relink: g++  -fPIC -DPIC -shared -nostdlib /usr/lib/gcc/x86_64-linux-gnu/5/../../../x86_64-linux-gnu/crti.o /usr/lib/gcc/x86_64-linux-gnu/5/crtbeginS.o  .libs/Init.o   -lboost_context -lboost_program_options -lboost_thread -lboost_filesystem -lboost_system -lboost_regex -lpthread -lboost_chrono -lssl -lcrypto -L/usr/local/lib -lfolly -llzma -lz -lsnappy -llz4 -liberty -ldl -levent -ldouble-conversion -lglog -lgflags -L/usr/lib/gcc/x86_64-linux-gnu/5 -L/usr/lib/gcc/x86_64-linux-gnu/5/../../../x86_64-linux-gnu -L/usr/lib/gcc/x86_64-linux-gnu/5/../../../../lib -L/lib/x86_64-linux-gnu -L/lib/../lib -L/usr/lib/x86_64-linux-gnu -L/usr/lib/../lib -L/usr/lib/gcc/x86_64-linux-gnu/5/../../.. -lstdc++ -lm -lc -lgcc_s /usr/lib/gcc/x86_64-linux-gnu/5/crtendS.o /usr/lib/gcc/x86_64-linux-gnu/5/../../../x86_64-linux-gnu/crtn.o  -g -O2   -Wl,-soname -Wl,libfollyinit.so.57 -o .libs/libfollyinit.so.57.0.0
libtool: install: /usr/bin/install -c .libs/libfollyinit.so.57.0.0T /usr/local/lib/libfollyinit.so.57.0.0
libtool: install: (cd /usr/local/lib && { ln -s -f libfollyinit.so.57.0.0 libfollyinit.so.57 || { rm -f libfollyinit.so.57 && ln -s libfollyinit.so.57.0.0 libfollyinit.so.57; }; })
libtool: install: (cd /usr/local/lib && { ln -s -f libfollyinit.so.57.0.0 libfollyinit.so || { rm -f libfollyinit.so && ln -s libfollyinit.so.57.0.0 libfollyinit.so; }; })
libtool: install: /usr/bin/install -c .libs/libfollyinit.lai /usr/local/lib/libfollyinit.la
libtool: install: /usr/bin/install -c .libs/libfollyinit.a /usr/local/lib/libfollyinit.a
libtool: install: chmod 644 /usr/local/lib/libfollyinit.a
libtool: install: ranlib /usr/local/lib/libfollyinit.a
libtool: finish: PATH="/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/snap/bin:/sbin" ldconfig -n /usr/local/lib
----------------------------------------------------------------------
Libraries have been installed in:
   /usr/local/lib

If you ever happen to want to link against installed libraries
in a given directory, LIBDIR, you must either use libtool, and
specify the full pathname of the library, or use the '-LLIBDIR'
flag during linking and do at least one of the following:
   - add LIBDIR to the 'LD_LIBRARY_PATH' environment variable
     during execution
   - add LIBDIR to the 'LD_RUN_PATH' environment variable
     during linking
   - use the '-Wl,-rpath -Wl,LIBDIR' linker flag
   - have your system administrator add LIBDIR to '/etc/ld.so.conf'

See any operating system documentation about shared libraries for
more information, such as the ld(1) and ld.so(8) manual pages.
----------------------------------------------------------------------
make[3]: Nothing to be done for 'install-data-am'.
make[3]: Leaving directory '/media/tom/document/Syn_Clode/project/folly-2018.01.08.00/folly/init'
make[2]: Leaving directory '/media/tom/document/Syn_Clode/project/folly-2018.01.08.00/folly/init'
make[1]: Leaving directory '/media/tom/document/Syn_Clode/project/folly-2018.01.08.00/folly/init'
Making install in chrono/test
make[1]: Entering directory '/media/tom/document/Syn_Clode/project/folly-2018.01.08.00/folly/chrono/test'
make[2]: Entering directory '/media/tom/document/Syn_Clode/project/folly-2018.01.08.00/folly/chrono/test'
make[2]: Nothing to be done for 'install-exec-am'.
make[2]: Nothing to be done for 'install-data-am'.
make[2]: Leaving directory '/media/tom/document/Syn_Clode/project/folly-2018.01.08.00/folly/chrono/test'
make[1]: Leaving directory '/media/tom/document/Syn_Clode/project/folly-2018.01.08.00/folly/chrono/test'
Making install in io/test
make[1]: Entering directory '/media/tom/document/Syn_Clode/project/folly-2018.01.08.00/folly/io/test'
make[2]: Entering directory '/media/tom/document/Syn_Clode/project/folly-2018.01.08.00/folly/io/test'
make[2]: Nothing to be done for 'install-exec-am'.
make[2]: Nothing to be done for 'install-data-am'.
make[2]: Leaving directory '/media/tom/document/Syn_Clode/project/folly-2018.01.08.00/folly/io/test'
make[1]: Leaving directory '/media/tom/document/Syn_Clode/project/folly-2018.01.08.00/folly/io/test'
Making install in stats/test
make[1]: Entering directory '/media/tom/document/Syn_Clode/project/folly-2018.01.08.00/folly/stats/test'
make[2]: Entering directory '/media/tom/document/Syn_Clode/project/folly-2018.01.08.00/folly/stats/test'
make[2]: Nothing to be done for 'install-exec-am'.
make[2]: Nothing to be done for 'install-data-am'.
make[2]: Leaving directory '/media/tom/document/Syn_Clode/project/folly-2018.01.08.00/folly/stats/test'
make[1]: Leaving directory '/media/tom/document/Syn_Clode/project/folly-2018.01.08.00/folly/stats/test'
```
