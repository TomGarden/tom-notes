也想过 clion , 但是远程开发 clion 操作还是更麻烦些的 

VSCode 最开始使用 makefile + C/C++ , 存在的问题是
1. 代码自动提示很艰难
2. 代码异常提醒不及时无法及时刷新

听说有一种更舒适的做法 : https://backendhouse.github.io/post/c++开发环境最佳实践/  
0. CMake + clang + c/c++
1. clang 安装指引(我目前安装的 13 ) : - https://clangd.llvm.org/ : 按照官方指引完成配置
   - sudo apt-get install clangd-版本号
   - sudo update-alternatives --install /usr/bin/clangd clangd /usr/bin/clangd-版本号 100
   - 确实比 c/c++ 在代码分析跳转要快得多 , 但是对 c++20 特性的支持还有待提升
   - 总的来说还是比较不错的
3. CMake 插件安装 
   - https://marketplace.visualstudio.com/items?itemName=twxs.cmake
   - https://marketplace.visualstudio.com/items?itemName=ms-vscode.cmake-tools
4. c/c++
   - https://marketplace.visualstudio.com/items?itemName=ms-vscode.cpptools
   - 这个工具主要是用于 断点调试 
   - 需要配置它的智能感知引擎为关闭状态 , 不然和 clangd  功能重复 
     ```
     "C_Cpp.intelliSenseEngine": "Disabled"
     ```
5. 注释生成工具 : https://marketplace.visualstudio.com/items?itemName=cschlosser.doxdocgen

