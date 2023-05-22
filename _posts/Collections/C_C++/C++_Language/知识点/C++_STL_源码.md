C++ 标准库 源代码 。

标准 C++ 基金会 : https://isocpp.org/std/the-standard

国际标准化组织 发布 现行标准

不同组织遵循 C++ 标准有不同的 C++ 标注库的实现，输入输出符合 C++ 标准 ， 内部实现可能有差异。

GUN 的 libstdc++ 代码跟 gcc 项目在一起 
- 官方网页 : https://gcc.gnu.org/
- 官方指引代码访问 : `git clone git://gcc.gnu.org/git/gcc.git SomeLocalDir`
- 一个景象仓库 ： https://github.com/gcc-mirror/gcc/tree/master/libstdc%2B%2B-v3



查看 C++ 标准都被那些编译器实现了 : https://zh.cppreference.com/w/cpp/compiler_support
- 有时候较新的 api 无法使用 从 这个对照表中就能看出原因来






## 关于三方库的了解 
- [先来一个开源库列表](https://zh.cppreference.com/w/cpp/links/libs)
- [再来一个库列表](http://fffaraz.github.io/awesome-cpp/)


* Json object 互转库列表 : https://www.json.org/json-en.html 
   * https://json.nlohmann.me/

nlohmann define type non intrusive

如果一个项目要依赖几个三方库 , 几个三方库的 C++ 标准是不同的 , 可行吗 ?
