## 一、 VSCode C/C++ 代码格式化工具

安装插件：Clang-Format

安装之后不能用提示：`The ‘clang-format’ command is not available. Please check your clang.formatTool user setting and ensure it is installed.
`
- [安装插件之后别忘了在操作系统安装 该插件要求的 clang-format](http://www.codepool.biz/vscode-format-c-code-windows-linux.html)

[上述两个安装之后还是无法解决该错误，原因在于未将 VSCode 中的 clang-format 和系统中的 clang-formate 联系起来。：](https://github.com/xaverh/vscode-clang-format-provider/issues/48)
- `settings.json -->   "clang-format.executable": "/usr/bin/clang-format-5.0"`

## 二、 Atom C/C++ 代码格式化工具
安装插件：atom-beautify

之后使用 
1. `Ctrl+Shift+P`
2. 输入 `atom beautify`(选择带有快捷键的 Ctrl+Alt+B)
3. 回车会报错：`Could not find 'uncrustify'. The program may not be installed`

在操作系统上安装 uncrustify ：`sudo apt-get install uncrustify`
- 重启再次使用->成功
