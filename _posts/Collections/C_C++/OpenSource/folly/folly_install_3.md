# [当前碰到的问题](https://github.com/facebook/folly/issues/725)
尝试解决未果，暂时放下这个问题，我们先看相关 API 如果这个问题一定绕不过去，再回来解决。

## I have the same question

Folly version ：folly-2018.01.08.00
My environment : Ubuntu 16.04

## My Operate
1. Check my gcc version
    - g++ (Ubuntu 5.4.0-6ubuntu1~16.04.5) 5.4.0 20160609
2. Download googletest
    - unzip
    - rename to gtest
    -  copy to folly/test
3. install
```
sudo apt-get install \
    g++ \
    automake \
    autoconf \
    autoconf-archive \
    libtool \
    libboost-all-dev \
    libevent-dev \
    libdouble-conversion-dev \
    libgoogle-glog-dev \
    libgflags-dev \
    liblz4-dev \
    liblzma-dev \
    libsnappy-dev \
    make \
    zlib1g-dev \
    binutils-dev \
    libjemalloc-dev \
    libssl-dev \
    pkg-config
```
```
sudo apt-get install \
    libunwind8-dev \
    libelf-dev \
    libdwarf-dev
```
```
sudo apt-get install \
    libiberty-dev
```
4. Execute next commands , bash show error
```
autoreconf -ivf
./configure
make
make check
sudo make install
```
## My Error
```
folly-2018.01.08.00/folly$ make check
Making check in .
make[1]: Entering directory '/folly-2018.01.08.00/folly'
make[1]: Leaving directory '/folly-2018.01.08.00/folly'
Making check in test
make[1]: Entering directory '/folly-2018.01.08.00/folly/test'
Making check in .
make[2]: Entering directory '/folly-2018.01.08.00/folly/test'
make  libfollytestmain.la libgtest.la foreach_benchmark benchmark_test concurrent_skiplist_benchmark conv_benchmark sorted_vector_types_test foreach_test hash_test timeout_queue_test conv_test expected_test range_test math_test bits_test bit_iterator_test spin_lock_test array_test constexpr_math_test small_locks_test packed_sync_ptr_test small_vector_test discriminated_ptr_test cpuid_test sorted_vector_types_test container_access_test foreach_test hash_test invoke_test fbstring_test_using_jemalloc thread_cached_int_test thread_id_test thread_cached_int_test thread_local_test fbvector_test dynamic_test json_test scope_guard_test timeout_queue_test cold_class_test conv_test expected_test range_test math_test bits_test bit_iterator_test endian_test rw_spinlock_test synchronized_test synchronized_ptr_test lock_traits_test concurrent_skiplist_test group_varint_test map_util_test string_test producer_consumer_queue_test atomic_hash_array_test atomic_hash_map_test chrono_test format_test fingerprint_test poly_test portability_test spooky_hash_v1_test spooky_hash_v2_test token_bucket_test thread_name_test indestructible_test portability_clock_gettime_wrappers_test portability_time_test portability_constexpr_test portability_openssl_test try_test typelist_test uncaught_exceptions_test unit_test futures_test function_test rvalue_reference_wrapper_test ssl_test mallctl_helper_test apply_tuple_test partial_test singleton_thread_local_test utility_test iterator_test
make[3]: Entering directory '/folly-2018.01.08.00/folly/test'
make[3]: 'libfollytestmain.la' is up to date.
make[3]: 'libgtest.la' is up to date.
make[3]: 'foreach_benchmark' is up to date.
make[3]: 'benchmark_test' is up to date.
make[3]: 'concurrent_skiplist_benchmark' is up to date.
make[3]: 'conv_benchmark' is up to date.
make[3]: 'sorted_vector_types_test' is up to date.
make[3]: 'foreach_test' is up to date.
make[3]: 'hash_test' is up to date.
make[3]: 'timeout_queue_test' is up to date.
make[3]: 'conv_test' is up to date.
make[3]: 'expected_test' is up to date.
/bin/bash ../libtool  --tag=CXX   --mode=link g++  -std=gnu++1y -g -O2 -lboost_context -lboost_program_options -lboost_thread -lboost_filesystem -lboost_system -lboost_regex -lpthread -lboost_chrono  -lssl -lcrypto  -o range_test RangeTest.o libfollytestmain.la -llzma -lz -lsnappy -llz4 -liberty -ldl -levent -ldouble-conversion -lglog -lgflags
libtool: link: g++ -std=gnu++1y -g -O2 -o .libs/range_test RangeTest.o  ./.libs/libfollytestmain.a /folly-2018.01.08.00/folly/init/.libs/libfollyinit.so /folly-2018.01.08.00/folly/.libs/libfolly.so -lunwind -lboost_context -lboost_program_options -lboost_thread -lboost_filesystem -lboost_system -lboost_regex -lpthread -lboost_chrono -lssl -lcrypto -llzma -lz -lsnappy -llz4 -liberty -ldl -levent -ldouble-conversion -lglog -lgflags
RangeTest.o: In function `testing::IsEmptyMatcher::gmock_Impl<folly::Range<int const*> const&>::FormatDescription(bool) const':
/folly-2018.01.08.00/folly/test/gtest/googlemock/include/gmock/gmock-more-matchers.h:48: undefined reference to `testing::internal::FormatMatcherDescription(bool, char const*, std::vector<std::__cxx11::basic_string<char, std::char_traits<char>, std::allocator<char> >, std::allocator<std::__cxx11::basic_string<char, std::char_traits<char>, std::allocator<char> > > > const&)'
/folly-2018.01.08.00/folly/test/gtest/googlemock/include/gmock/gmock-more-matchers.h:48: undefined reference to `testing::internal::FormatMatcherDescription(bool, char const*, std::vector<std::__cxx11::basic_string<char, std::char_traits<char>, std::allocator<char> >, std::allocator<std::__cxx11::basic_string<char, std::char_traits<char>, std::allocator<char> > > > const&)'
collect2: error: ld returned 1 exit status
Makefile:1797: recipe for target 'range_test' failed
make[3]: *** [range_test] Error 1
make[3]: Leaving directory '/folly-2018.01.08.00/folly/test'
Makefile:2950: recipe for target 'check-am' failed
make[2]: *** [check-am] Error 2
make[2]: Leaving directory '/folly-2018.01.08.00/folly/test'
Makefile:2163: recipe for target 'check-recursive' failed
make[1]: *** [check-recursive] Error 1
make[1]: Leaving directory '/folly-2018.01.08.00/folly/test'
Makefile:2315: recipe for target 'check-recursive' failed
make: *** [check-recursive] Error 1
```

1. execute `make check` show top error.
2. I execute `sudo make install` continue.
3. include    

```C++
#include<iostream>
using std::cout;
using std::endl;

#include <folly/experimental/logging/Init.h>
#include <folly/experimental/logging/example/lib.h>

int main(){
  cout << "Hello word !" << endl;
  return 0;
}
```

4. compilate
```
main.c:6:52: fatal error: folly/experimental/logging/example/lib.h: No such file or directory
compilation terminated.
```
5. I find `/usr/local/include/folly/experimental/logging/example` isn't exist.
