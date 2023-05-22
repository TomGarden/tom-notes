

要探索[开源项目](https://github.com/githubuser0xFFFF/Qt-Advanced-Stylesheets) , 他用 qmake 管理的编译动作 , 所以开始了解 qmake 了 . 


https://doc.qt.io/qt-6/index.html qt 文档首页没有找到 qmake 说明的入口 , 找打了 CMake 的入口 , 这说明 qmake 要被弃用了吗 ?
- 是的 , 官方在弃用 qbs 的时候表达了他们有弃用 qmake 的倾向 : https://www.qt.io/blog/2018/10/29/deprecation-of-qbs
- qmake 在 vscode 下完成编译也是完全没有任何问题的 : https://blog.csdn.net/einstein2387/article/details/105885810
   - 运行 qmake 指令的官方教程 https://doc.qt.io/qt-6/qmake-running.html


## 1. 关于 VsCode 组织编译 QMake 项目

先了解手动编译流程
1. ` qmake -makefile -o Makefile proPath `



https://doc.qt.io/qt-6/qmake-manual.html





## 为 vscode 配置 qmake

/opt/homebrew/Cellar/cmake/3.25.0/bin/cmake 
      -S /Volumes/Document/qt_cpp/Hello_Qt 
      -B /Volumes/Document/qt_cpp/build-Hello_Qt-Qt_6_4_0_for_macOS-Debug 
      -DCMAKE_GENERATOR:STRING=Ninja 
      -DCMAKE_BUILD_TYPE:STRING=Debug 
      '-DCMAKE_PROJECT_INCLUDE_BEFORE:FILEPATH=/Volumes/Beyourself/dev_tools/ide/QT/qt/Qt Creator.app/Contents/Resources/package-manager/auto-setup.cmake' 
      -DQT_QMAKE_EXECUTABLE:FILEPATH=/Volumes/Beyourself/dev_tools/ide/QT/qt/6.4.0/macos/bin/qmake 
      -DCMAKE_PREFIX_PATH:PATH=/Volumes/Beyourself/dev_tools/ide/QT/qt/6.4.0/macos 
      -DCMAKE_C_COMPILER:FILEPATH=/usr/bin/clang -DCMAKE_CXX_COMPILER:FILEPATH=/usr/bin/clang++ 
      -DCMAKE_CXX_FLAGS_INIT:STRING=-DQT_QML_DEBUG in /Volumes/Document/qt_cpp/build-Hello_Qt-Qt_6_4_0_for_macOS-Debug.

