Common Toolkit : https://github.com/commontk/CTK
网络经验 : 
1. https://github.com/myhhub/CTK-project
    - 代码写不动的时候可以参考这里的文章和测试代码

单纯关于编译的 网络 经验
- 官方编译指南 : https://commontk.org/index.php/Build_Instructions
- https://www.google.com/search?q=ctk++arm+qt6编译
0. https://www.ljjyy.com/archives/2021/03/100645.html
1. https://blog.csdn.net/LebronBear/article/details/113932991
2. https://blog.csdn.net/guoruijun_2012_4/article/details/104328842
5. https://blog.csdn.net/blackwoodcliff/article/details/107624047



自己的编辑过程 

逐渐拼装得到的 遍历 命令

```treminal

遵照官方编译指引不一定成功 
C:\_tom_dir\software\cmake-3.25.0-windows-arm64\bin\cmake.exe                                         `
      ../CTK                                                                                          `
      -DCTK_QT_VERSION=5                                                                              `
      -DCMAKE_C_COMPILER='C:\_tom_dir\software\Qt_offline\Qt5.12.9\Tools\mingw730_64\bin\gcc.exe'       `
      -DCMAKE_CXX_COMPILER='C:\_tom_dir\software\Qt_offline\Qt5.12.9\Tools\mingw730_64\bin\g++.exe'     `
      -DQT5_DIR='C:\_tom_dir\software\Qt_offline\Qt5.12.9\5.12.9\mingw73_64\bin\qmake.exe'              `
      -DVTK_MODULE_ENABLE_VTK_GUISupportQt=YES                                                        `
      -DVTK_MODULE_ENABLE_VTK_ViewsQt=YES



git clone https://github.com/commontk/CTK.git
git clone https://github.com/commontk/CTKData.git
git clone https://github.com/DCMTK/dcmtk.git
git clone https://github.com/commontk/QtSOAP.git

/* 使用 qt creator minGW 编译 ,
Projects -> Addtional CMake options , 添加如下指令

这些指令需要空空格间隔写成一行 , 我有换行是为了看起来方便
 */
 
 "-DCTK_QT_VERSION=5" 
 "-DCTKData_DIR=Y:\document\ctk\CTKData" 
 "-DDCMTK_DIR=Y:\document\ctk\dcmtk"
 "-DQtSOAP_DIR=Y:\document\ctk\QtSOAP"
 "-DVTK_MODULE_ENABLE_VTK_GUISupportQt=YES" 
 "-DVTK_MODULE_ENABLE_VTK_ViewsQt=YES" 
 "-DCTK_BUILD_ALL_PLUGINS:BOOL=ON"
 "-DCTK_ENABLE_PluginFramework:BOOL=ON"
 "-DCTK_ENABLE_Widgets:BOOL=ON"
 "-DCMAKE_INSTALL_PREFIX:PATH=Y:\document\ckt_2\ctk_install_dir"

# "-DCTK_BUILD_ALL_LIBRARIES=ON"   # 构建所有 ctk 库 , 等能区分的时候再有选择的构建 , 添加后失败
# "-DDCMTK_DIR=Y:/document/ctk/dcmtk" # 不知道作用详情
# "-DDCMTK_DIR=C:/ProgramData/chocolatey/lib/dcmtk/tools/dcmtk-3.6.7-win64-chocolatey/bin"


# 完成以上内容 , 进入 编译生成文件目录 执行 
C:\_tom_dir\software\Qt_offline\Qt5.12.9\Tools\mingw730_64\bin\mingw32-make.exe
C:/_tom_dir/software/Qt_offline/Qt5.12.9/Tools/mingw730_64/bin/mingw32-make.exe
"-DCMAKE_INSTALL_PREFIX:PATH=Y:/document/ckt_2/ctk_install_dir"

Set-ExecutionPolicy Bypass -Scope Process -Force; [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072; iex ((New-Object System.Net.WebClient).DownloadString('https://community.chocolatey.org/install.ps1'))

```


```
错误
---- 

C:\_tom_dir\software\cmake-3.25.0-windows-arm64\share\cmake-3.25\Modules\ExternalProject.cmake:2790: error: error: could not find git for clone of CTKData C:/_tom_dir/software/cmake-3.25.0-windows-arm64/share/cmake-3.25/Modules/ExternalProject.cmake:4185 (_ep_add_download_command) CMakeExternals/CTKData.cmake:43 (ExternalProject_Add) CMake/ctkMacroCheckExternalProjectDependency.cmake:886 (include) CMake/ctkMacroCheckExternalProjectDependency.cmake:960 (ExternalProject_Include_Dependencies) CMake/ctkBlockCheckDependencies.cmake:134 (ExternalProject_Include_Dependencies) CMakeLists.txt:980 (include)

解决
----
git clone https://github.com/commontk/CTKData.git
"-DCTKData_DIR=Y:\document\ctk\CTKData" 




错误
----
C:\_tom_dir\software\Qt_offline\Qt5.12.9\5.12.9\mingw73_64\lib\cmake\Qt5\Qt5Config.cmake:28: error: Could not find a package configuration file provided by "Qt5WebEngineWidgets" with any of the following names: Qt5WebEngineWidgetsConfig.cmake qt5webenginewidgets-config.cmake Add the installation prefix of "Qt5WebEngineWidgets" to CMAKE_PREFIX_PATH or set "Qt5WebEngineWidgets_DIR" to a directory containing one of the above files.  If "Qt5WebEngineWidgets" provides a separate development package or SDK, be sure it has been installed. CMake/ctkMacroSetupQt.cmake:50 (find_package) CMakeLists.txt:423 (ctkMacroSetupQt)


C:\_tom_dir\software\Qt_offline\Qt5.12.9\5.12.9\mingw73_64\lib\cmake\Qt5\Qt5Config.cmake:28: error: Could not find a package configuration file provided by "Qt5WebEngineWidgets" with any of the following names: Qt5WebEngineWidgetsConfig.cmake qt5webenginewidgets-config.cmake Add the installation prefix of "Qt5WebEngineWidgets" to CMAKE_PREFIX_PATH or set "Qt5WebEngineWidgets_DIR" to a directory containing one of the above files.  If "Qt5WebEngineWidgets" provides a separate development package or SDK, be sure it has been installed. CMake/ctkMacroSetupQt.cmake:50 (find_package) CMakeLists.txt:423 (ctkMacroSetupQt)

C:\_tom_dir\software\cmake-3.25.0-windows-arm64\share\cmake-3.25\Modules\FindPackageHandleStandardArgs.cmake:230: error: Please set DCMTK_DIR and re-run configure (missing: DCMTK_config_INCLUDE_DIR) C:/_tom_dir/software/cmake-3.25.0-windows-arm64/share/cmake-3.25/Modules/FindPackageHandleStandardArgs.cmake:600 (_FPHSA_FAILURE_MESSAGE) Utilities/CMake/FindDCMTK.cmake:327 (find_package_handle_standard_args) CMakeLists.txt:1004 (find_package)

```




----




编译一个插件 生成 dll 动态库

ctk 在处理 插件名应该禁止定义带有 下划线 "`_`" 的名称 , ctk 内部操作 , 无法处理这个字符 . 

避免使用 下划线 , 作为插件名称 , 可以给自己的 ctk 使用过程避免麻烦 . 
``` c++
// 使用 下划线 在加载插件时候 容易出错 , 这里就是使用了 `Hello_CTK`
 QIODevice::read (QFile, ":\Hello.CTK\META­INF\MANIFEST.MF"): device not open
```



编译多个插件的时候