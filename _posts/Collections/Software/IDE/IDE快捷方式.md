IDE快捷键——欢迎路人，补充：说明：报错。

|描述| AndroidStuido| Eclipse|VisualStudio|Notepad++|Idea|Navicat|
|----|:------------:| :-----:|:----------:|:--------:|:--:|
|注释选中|Ctrl+Shift+/|       |Ctrl+K,Ctrl+C|         ||
|取消注释选中|Ctrl+Shift+/|       |Ctrl+K,Ctrl+U|         ||
|注释行|Ctrl+/|       |Ctrl+K,Ctrl+U|         ||
|查看注释|Ctrl+Q/F12|       |Ctrl+K,Ctrl+U|         ||
|删除行|Ctrl+Y|       |Ctrl+L       |         ||
|自由选择文本|Ctrl+Shift+Alt+MouseLeft|       |Ctrl+Alt+MouseLeft|         ||
|自由选择文本|Alt+MouseLeft|       |Ctrl+Alt+MouseLeft|         ||
|格式化|Ctrl+Alt+L|选中 Ctrl+Shift+K|选中 Ctrl+K,Ctrl+F|         |Ctrl+Alt+L|
|折叠所有|            |       |Ctrl+M,Ctrl+O|         ||
|展开所有|            |       |Ctrl+M,Ctrl+L|         ||
|折叠展开当前|            |       |Ctrl+M,Ctrl+M|         ||
|上次光标位置|            |       |Ctrl+-|         ||
|下次光标位置|            |       |Ctrl+Shift+-|         ||
|撤销|            |       |Ctrl+Z|         ||
|反撤销|            |       |Ctrl+Y|         ||
|生成GetSet方法|            |       |Ctrl+R,Ctrl+E|         ||
|删除无效引用|            |       |右击-组织using|         ||
|实现/提取接口|            |       |Shift+Alt+F10|         ||
|大小写转换|            |       |Ctrl+U/Ctrl+Shift+U|         ||
|提示方法参数|Ctrl+P|       ||         ||
|代码提示|Ctrl+Alt+Space|       ||         ||
|清除无效包引用|Ctrl+Alt+O|       ||         ||
|字段改名|Shift+F6|       ||         ||
|移动一行|Ctrl+Shift+↑↓|       ||         ||



----
##关于VisualStudio
### 一、
1. 如果你想复制一整行代码，只需将光标移至该行，再使用组合键“Ctrl+C”来完成复制操作，而无需选择整行。
2. 如果你想剪切一整行代码，只需将光标移至该行，再使用组合键“Ctrl+X”来完成剪切操作，而无需选择整行。
3. 如果你想删除一整行代码，只需将光标移至该行，再使用组合键“Ctrl+L”来完成剪切操作，而无需选择整行。

  - 但是Ctrl+L也会把本行内容复制到剪贴板上，单纯的删除而不复制的快捷键尚未找到。

### 二、
关于注释快捷键
示例代码
```C#
TreeNode treeNodeChild = new TreeNode(KnowledgePoint.Name);
```

- 如果不选中任何内容，或者选中全部内容，之后  Ctrl+K+C 结果：
```C#
//TreeNode treeNodeChild = new TreeNode(KnowledgePoint.Name);
```
- 如果选中部分内容， Ctrl+K+C 结果：
```C#
/*TreeNode treeNodeChild*/ = new TreeNode(KnowledgePoint.Name);
```






# 参考
1. [VS2008（C#）中，跳到上次编辑位置的快捷键是什么？](https://zhidao.baidu.com/question/563053902.html)
2. [VS2013常用快捷键 ](http://blog.csdn.net/lushuner/article/details/23688629)
3. [Atom 编辑器 入门 快捷键](https://www.jianshu.com/p/aa8f8a252ed9)
4. [**[精]**VSCode](http://blog.csdn.net/crper/article/details/54099319)

# 说明
这篇文字沿袭了 [CSDN](http://blog.csdn.net/u014587769/article/details/68067015) ,如有更新，以本文为准，以本文为新。
