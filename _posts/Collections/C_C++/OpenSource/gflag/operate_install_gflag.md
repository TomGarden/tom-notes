# 操作日志
```
tom@tom-Vostro-2421:/media/tom/document/Syn_Clode/Resources/gflags-master$ mkdir build
tom@tom-Vostro-2421:/media/tom/document/Syn_Clode/Resources/gflags-master$ cd build/
tom@tom-Vostro-2421:/media/tom/document/Syn_Clode/Resources/gflags-master/build$ cmake -DGFLAGS_NAMESPACE=google -DCMAKE_CXX_FLAGS=-fPIC ..
-- The CXX compiler identification is GNU 5.4.0
-- Check for working CXX compiler: /usr/bin/c++
-- Check for working CXX compiler: /usr/bin/c++ -- works
-- Detecting CXX compiler ABI info
-- Detecting CXX compiler ABI info - done
-- Detecting CXX compile features
-- Detecting CXX compile features - done
-- Looking for C++ include unistd.h
-- Looking for C++ include unistd.h - found
-- Looking for C++ include stdint.h
-- Looking for C++ include stdint.h - found
-- Looking for C++ include inttypes.h
-- Looking for C++ include inttypes.h - found
-- Looking for C++ include sys/types.h
-- Looking for C++ include sys/types.h - found
-- Looking for C++ include sys/stat.h
-- Looking for C++ include sys/stat.h - found
-- Looking for C++ include fnmatch.h
-- Looking for C++ include fnmatch.h - found
-- Looking for C++ include stddef.h
-- Looking for C++ include stddef.h - found
-- Check size of uint32_t
-- Check size of uint32_t - done
-- Looking for strtoll
-- Looking for strtoll - found
-- Looking for C++ include pthread.h
-- Looking for C++ include pthread.h - found
-- Looking for pthread_create
-- Looking for pthread_create - not found
-- Looking for pthread_create in pthreads
-- Looking for pthread_create in pthreads - not found
-- Looking for pthread_create in pthread
-- Looking for pthread_create in pthread - found
-- Found Threads: TRUE  
-- Check size of pthread_rwlock_t
-- Check size of pthread_rwlock_t - done
-- Configuring done
-- Generating done
-- Build files have been written to: /media/tom/document/Syn_Clode/Resources/gflags-master/build
tom@tom-Vostro-2421:/media/tom/document/Syn_Clode/Resources/gflags-master/build$ make && sudo make install
Scanning dependencies of target gflags_nothreads_static
[ 12%] Building CXX object CMakeFiles/gflags_nothreads_static.dir/src/gflags.cc.o
[ 25%] Building CXX object CMakeFiles/gflags_nothreads_static.dir/src/gflags_reporting.cc.o
[ 37%] Building CXX object CMakeFiles/gflags_nothreads_static.dir/src/gflags_completions.cc.o
[ 50%] Linking CXX static library lib/libgflags_nothreads.a
[ 50%] Built target gflags_nothreads_static
Scanning dependencies of target gflags_static
[ 62%] Building CXX object CMakeFiles/gflags_static.dir/src/gflags.cc.o
[ 75%] Building CXX object CMakeFiles/gflags_static.dir/src/gflags_reporting.cc.o
[ 87%] Building CXX object CMakeFiles/gflags_static.dir/src/gflags_completions.cc.o
[100%] Linking CXX static library lib/libgflags.a
[100%] Built target gflags_static
[sudo] password for tom:
[ 50%] Built target gflags_nothreads_static
[100%] Built target gflags_static
Install the project...
-- Install configuration: ""
-- Installing: /usr/local/lib/libgflags.a
-- Installing: /usr/local/lib/libgflags_nothreads.a
-- Installing: /usr/local/include/gflags/gflags.h
-- Installing: /usr/local/include/gflags/gflags_declare.h
-- Installing: /usr/local/include/gflags/gflags_completions.h
-- Installing: /usr/local/lib/cmake/gflags/gflags-config.cmake
-- Installing: /usr/local/lib/cmake/gflags/gflags-config-version.cmake
-- Installing: /usr/local/lib/cmake/gflags/gflags-targets.cmake
-- Installing: /usr/local/lib/cmake/gflags/gflags-targets-noconfig.cmake
-- Installing: /usr/local/bin/gflags_completions.sh
-- Installing: /usr/local/lib/pkgconfig/gflags.pc
-- Installing: /home/tom/.cmake/packages/gflags/e5f7ce61772240490d3164df06f58ce9
tom@tom-Vostro-2421:/media/tom/document/Syn_Clode/Resources/gflags-master/build$

```
