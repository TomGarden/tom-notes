1. [ELF结构详细分析(1)---elf32_hdr](http://blog.csdn.net/dongdenghui/article/details/42610903)
2. [**[精]**ELF文件结构描述](http://blog.csdn.net/do2jiang/article/details/5805513)
3. [ELF文件分析之0 － 简介和分析工具](http://cedar-renjun.github.io/2015/10/31/elf-format-0/)
4. http://flint.cs.yale.edu/cs422/doc/ELF_Format.pdf
5. [可执行文件（ELF）格式的理解](http://www.cnblogs.com/xmphoenix/archive/2011/10/23/2221879.html)

节区头部表格中与节区名称字符串表相关的表项的索引。如果文件没有节区名称字符串表,此参数可以为 SHN_UNDEF

节区头部表格
节区名称字符串表


当前我认识到的 elf 文件所包含的内容如下[仅此而已]，如果有更多，那么我可能还没有认识到。
1. ELF Helder
2. Program Header Table
3. Secition Headers 
    - Segment Headers
4. Secition Header Table
    - Segment Header Table
