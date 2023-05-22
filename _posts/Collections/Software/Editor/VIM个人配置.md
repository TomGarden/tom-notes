## Vim 配置



## 参考内容
1. [官网](https://www.vim.org/) -- [翻译文档](https://www.vim.org/translations.php) -- 下载即可
2. [阮一峰的笔记](https://www.ruanyifeng.com/blog/2018/09/vimrc.html)

## 配置预备
跳读文档 , 可以知道 , vim 在用户目录有一个配置文件 `~/.vimrc` , 如果没有可以自己创建 . 
这里不同的设备可能最优选项不同 , 对我而言选择自己创建空白文件 ; 不知道怎么选 , 可以阅读原文选择适合自己的操作.

关于配置文件的设置引导在 : usr_05.txt(设置选项)



我的配置文件为 :
```vimrc
"这是 tom 手动配置的:/Volumes/Document/synchronization/TomGarden.github.io/_posts/Collections/Software/Editor/VIM个人配置.md
"
" vim 配置文件使用双引号作为注释声明
source $VIMRUNTIME/defaults.vim "线引入默认配置
set number                      " 用于使 vim 显示行号
set autoindent                  "按下回车键后，下一行的缩进会自动跟上一行的缩进保持一致
set tabstop=2                   "按下 Tab 键时，Vim 显示的空格数(应该始终和 softtabstop 保持一致)
set expandtab                   "由于 Tab 键在不同的编辑器缩进不一致，该设置自动将 Tab 转为空格
set softtabstop=2               "Tab 转为多少个空格(应该始终和 tabstop 保持一致)
set shiftwidth=2                "在文本上按下>>（增加一级缩进）、<<（取消一级缩进）或者==（取消全部缩进）时，每一级的字符数
set cursorline                  "光标所在的当前行高亮
set scrolloff=5                 "垂直滚动时，光标距离顶部/底部的位置（单位：行）
set sidescrolloff=15            "水平滚动时，光标距离行首或行尾的位置（单位：字符）。该配置在不折行时比较有用
set laststatus=2                "是否显示状态栏。0 表示不显示，1 表示只在多窗口时显示，2 表示显示
set showtabline=2               "指定何时显示顶部标签栏 0:永远不显示; 1:至少有两个标签页时显示; 2:永远会显示
colorscheme desert              "设置 vim 主题配色 ; 查看全部可用配色 : ls -al /usr/share/vim/vim82根据情况/colors
set encoding=utf-8              "设置 vim 内部使用的字符编码
syntax on                       "语法高亮    


"NESDTree 相关设置
let NERDTreeShowHidden=1      "默认显示隐藏文件



"YouCompleteMe doc uri (README.MD) : https://github.com/ycm-core/YouCompleteMe
let g:ycm_always_populate_location_list = 1   "Diagnostic Display section(诊断显示小结)增加此配置后可以使用`:lopen`/`lclose`打开带有当前文件所有诊断信息的文件
```

如果想要在 vim 界面添加文件树视图 , 需要了解 vim 插件管理软件, 然后添加相关插件

插件管理的一点理解:
1. https://gist.github.com/manasthakur/ab4cf8d32a28ea38271ac0d07373bb53

vim对于对于自己插件管理的介绍(usr_05.txt/repeat.txt) 
1. 插件本身其实就是vim 启动时一个可以自动执行的脚本
2. 可以通过把这些脚本文件放到指定文件夹 `~/.vim/pack/` 下,可以自己创建新文件夹 并 自己命名,这方便于按自己的逻辑管理
3. 不足之处在于,这些脚本文件的更新需要手动完成,当脚本变得越来越多,就越来越显得不方便了
  * [vim-plug](https://github.com/junegunn/vim-plug) 听说管理插件比较方便
  * 但是我已经想要先试用下 vim 提供的插件管理方式了,主要因为刚开始用,应该插数量还比较可控,后面多到难以维护再考虑变更
  * **安装文件树插件:nerdtree**
    * ```
      #将插件包克隆到指定目录 , 这个目录符合 user_05.txt/repeat.txt 说明文件中所提到的目录路径
      git clone https://github.com/preservim/nerdtree.git ~/.vim/pack/vendor/start/nerdtree
      #为 nerdtree 生成帮助标签,方便查看使用说明,这里的命令有不了解的可以参考 starting.txt 相关章节
      vim -u NONE -c "helptags ~/.vim/pack/vendor/start/nerdtree/doc" -c q
      ```
  * **安装代码自动补全插件 YouCompleteMe**
    * 不使用三方插件管理工具 , 直接下载到 `.vim/pack/code_complete/start/YouCompleteMe/` 
    * 编译(解决内存不足增加交换空间的问题)
    * python3 install.py --all(这包含了对所有语言的支持,包括C系列语言)


## NERDTree 的使用
相对简单,安装后,直接 `?` ; 以及 vim `help` ; 可以快速了解和使用, 不再赘述




## YouCompleteMe(全部摘自:https://github.com/ycm-core/YouCompleteMe)
关于安装,我不想使用三方插件管理工具,动作
1. clone 到 官方插件指定目录
2. 编译 `python3 install.py --all`
3. 按照官方说明说认识和了解这个工具,并作出必要的设置.

关于使用的一点细节略作记录
1. Ctrl+Space 可以在任何地方弹出代码建议(会自动弹出,主要用于没有自动弹出的情景)
2. Compile flags(编译标志)着一小节我还没有读明白,聊做记录
3. Diagnostic Display(诊断展示) 
  * 背景: YCM 会在用户录入后不断编译用户文件,所以可以实时知道哪里有异常需要提示
  * 由于 Vim 运行机制的原因,一个需要展示的异常无法立刻展示,需要用户与 vim 有一个交互动作后才可以展示; 真到了较真的时候回导致看起来异常没有及时展示(文案飘红). 
  * 对于已经展示了的异常可以通过`ESC`退出编辑模式, 然后将光标移动到提示异常的代码处, 在 vim 命令输入框会展示简要的异常信息; 想要查看完成的异常信息, 需要打开YCM自带的另一个小插件, 在 vim 配置文件中 `let g:ycm_always_populate_location_list = 1` , 这个小插件叫做 `locationlist` . 打开 `locationlist` 后可以用 `:lopen`/`:lclose` 打开和关闭异常详细信息视图 . 
  * nmap 是 vim 的配置语法,YouCompleteMe 的其他用法细节可以在需要的时候读取文档
  * GoToXxxx 命令提供了引用跳转能力
  * grep/vimgrep 提供了文本搜索能力

有待探索的能力
* 鼠标在某个关键字上停留的时候 , 应该可以恰当高亮本关键字在其他被使用的位置 . 
* 关键字文档展示希望可以手动触发 , 有的时候不想触发却触发了 , 有的时候想触发还需要等待 .


至此我的我的 vim 准备好完成编码任务了 . 


238 struct sockaddr_in
239   {
240     __SOCKADDR_COMMON (sin_);
241     in_port_t sin_port;     /* Port number.  */
242     struct in_addr sin_addr;    /* Internet address.  */
243
244     /* Pad to size of `struct sockaddr'.  */
245     unsigned char sin_zero[sizeof (struct sockaddr)
246          - __SOCKADDR_COMMON_SIZE
247          - sizeof (in_port_t)
248          - sizeof (struct in_addr)];
249   };



## 复制选中文本到操作系统
`vim 复制`/`vim复制`

按住ctrl + shift, 然后移动鼠标选取, 之后普通的复制粘贴即可.

当然, 说是普通的复制, 也得看你用的啥终端, 直接ctrl +c 一般都会关闭你的vim, 大部分终端下的复制都是 ctrl + shift + C, 这样就更顺手了.














