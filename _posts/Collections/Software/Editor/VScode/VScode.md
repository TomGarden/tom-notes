## 0x00、 关于 VSCode 的使用偏好

## 0x01、 Language
[修改 VScode 的默认显示语言。](https://code.visualstudio.com/docs/getstarted/locales)
- 默认是跟随系统的。
- F1 > Configure Language
    - English (US) 	en
    - Simplified Chinese 	zh-CN

## 0x02、 Markdown 绘图支持
### 2.*、 参考
1. https://www.jianshu.com/p/a9bd83b768d5
    - https://shd101wyy.github.io/markdown-preview-enhanced/#/zh-cn/

```mermaid
graph TD;
A-->B;
A-->C;
B-->D;
C-->D;
```
```flow
st=>start: 开始
e=>end: 结束
op=>operation: 我的操作
cond=>condition: 判断确认？
  
st->op->cond
cond(yes)->e
cond(no)->op
```

## 0x03 关于插件
VSCode插件：https://segmentfault.com/a/1190000013260728



## 0x04. 关于主题配置
 
debug console 面板文字颜色
- `file->preference->setting->workbench.colorCustomizations->edit in setting.json`
-   ```json
    "workbench.colorCustomizations": {
        /* debug connsole 颜色手动配置 */
        // "debugConsole.infoForeground":"#ff0000",
        // "debugConsole.warningForeground":"#ff0000",
        "debugConsole.errorForeground":"#b60000",
        // "debugConsole.sourceForeground":"#ff0000"
    }
    ```
- 对应配置说明 ： https://code.visualstudio.com/api/references/theme-color



## 0x05. 常用快捷键名称记录 ， 方便修改
快捷键官方说明 ： https://code.visualstudio.com/docs/getstarted/keybindings
- 快捷键配置文件 ： /home/tom/.config/Code/User/keybindings.json
- 我们使用的快捷键插件是 ： IntelliJ IDEA Keybindings

多个编辑点位跳转 : Go back / Go Forward
- 默认 ctrl+alt+left/rignt


搜索并选中所有匹配向 : Add Selection To Next Find Match
- 默认 : alt+j
- 插件 : ctrl+g

大小写转换
- 默认关键字： `editor.action.transformToUppercase`/`editor.action.transformToLowercase`
- [插件特有]大小写转换**未实现** : Toggle case for word at caret or selected block


对于搜索内容一边搜索一边选中
- 默认 : alt+j
- 插件 : ctrl

C++  代码格式化设置
0. 直接使用 clang-format 文件进行设置
1. `Code > preference > C_Cpp.clang_format_fallbackStyle`
2. ```json
    { 
      BasedOnStyle: Google,                 /* 基于 Google 代码风格进行调整 */
      IndentWidth: 2,                       /* 缩进宽度, 2 字符 */
      ColumnLimit: 0,                       /* 行长度限制 , 不限制 */
      NamespaceIndentation: All,            /* 命名空间缩进 */
      IndentPPDirectives: BeforeHash       /* 预处理指令缩进 , 暂时还不够让人满意 */
    }
    ```
    - 左花括号不换行
    - tab 缩进 2 字符
    - namespace 指定位缩进
    - 预处理指令缩进(效果并不满意)
    - 全部配置字段 : https://clang.llvm.org/docs/ClangFormatStyleOptions.html
        - 参考内容 : https://github.com/microsoft/vscode-cpptools/issues/932

3. 使用格式化配置文件进行格式化 : https://www.cnblogs.com/RioTian/p/13812397.html
```
# 若未安装则执行
brew install clang-format

# 生成主题文件 , 在项目根目录即可
clang-format -style=Google -dump-config > .clang-format
```
4. 对 `clang-format` 格式化的更多需求
   - 函数有括号和第一个花括号之间有一个空格比较好看 . 
