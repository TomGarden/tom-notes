

cmake 使用 C++ 项目的时候 , 或许可以避免 `include  ../xxx`
1. `set(CMAKE_INCLUDE_CURRENT_DIR ON)`
2. `include_directories(.....)`