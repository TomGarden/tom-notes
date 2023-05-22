## 0x00. 写在开始

1. 之前有想过通过 gitHub issus 来维护自己的博客 , 但是需要在线编辑 , 这一点不能满足需求
2. 也想过通过 gist , 但是不能针对单个文件做出评论 , 这一点不能满足需求
3. 也搞过 jekyll , 这个命名规范什么的太繁琐 , 配置复杂 , 当时搞的时候头头是道 , 后来用的时候不胜其烦
    - 最无法接受的就是文件明明规则 , 竟然不是想怎样命名就怎样命名 
    - 也不排除我没学会怎么用

4. 通过 Action 来完成个人博客的探索开始了 , 我从这里学来的想法 : https://github.com/Sep0lkit/git-issues-blog

5. 说真的自己写完文章无法和同行见面 , 无法与同行交流想法 , 自己的虚荣心得不到满足 , 很惆怅.jpg
    * 关于虚荣心, 如果blog 放在 gitIssues 上是无法统计阅读量与评论量的

### 0.1. 一个有待解答的问题列表
1. GitHub Action 是何时发布的功能?
    * 一九年低还是测试版本说明现在正是新鲜的时候(2020-03-04 22:12:10)


### 0.2. 一个有答案的问题列表


## 0x01. 关于 [Action 的官方文档] (https://help.github.com/cn/actions)

1. GitHub Action 不作用于 provite repository
2. GitHub Action 使用 YAML 语法作为行动指令语言 
3. 必须将工作流程文件存储在仓库的 .github/workflows 目录中。

### 1.0. [关于费用](https://help.github.com/cn/github/setting-up-and-managing-billing-and-payments-on-github/about-billing-for-github-actions)

GitHub Pro 用户 
* 1 GB 存储空间
* 3,000min/月 运行时间 

### 1.1. 一些限制
暂时略过

### 1.2. 功能点(细节略)
1. 设置 Action(workflow) 的名字
2. 通过某些 git 事件触发 Action(workflow)
3. 环境变量(根据作用域的不同可以被覆盖)
4. 工作(job)

### 1.3. 通读文档之后
读的过程中总忍不住会想 , 这些操作和什么比较相似呢 ? 总是从这个角度希望理解这件事情 .

度过语法相关的部分之后 , 有了答案

1. 我们需要写满足我们需要的脚本文件们
2. 这些脚本文件通过被指定意义的 yaml 文件串联起来 , 从而被有序执行
3. 我们可以选择不同的脚本执行环境 CMD / SHELL / PYTHON 
4. 实际上就相当于我们在用一个有序的脚本集合操作一个远程计算机执行我们指定的操作 .
    - 这个有序性就是通过 yaml 来完成的



## 0x02. 可以预见到的问题
1. repository <-> issues 数据同步 , 任一数据修改 , 都应该同步到另一方去
2. repository中一个文件 <-> 一个确定的issues 的一一对应关系从建立开始应该不会变化 , 是否有什么因素会影响到这一对应关系 ?
3. 通过 issus 我们大概会丢失目录的概念吧
4. 文件名变更 和 文件删除