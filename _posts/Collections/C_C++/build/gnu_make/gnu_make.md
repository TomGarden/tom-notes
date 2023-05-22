gnu make , 看了忘 ， 忘了看 ， 在这里我们做个简单的记录 。

gnu_make 官方资料 ： https://www.gnu.org/software/make/

gnu_make 手册 中文资料 ： _posts/Collections/C_C++/gnu_make/gnu_make_zh_cn_3.8.pdf

阮一峰关于 makefile 的输出 ： https://www.ruanyifeng.com/blog/2015/02/make.html

陈皓关于 makefile 的输出 ： https://seisman.github.io/how-to-write-makefile/






## 需求 ： 在一个 makeFile 中有些命令无论如何都想要执行。
但是它们没有目标文件,可以使用 : 强制目标（没有命令或依赖的规则） 

文档参考 ：
1. https://www.gnu.org/software/make/manual/html_node/Force-Targets.html
2. _posts/Collections/C_C++/gnu_make/gnu_make_zh_cn_3.8.pdf --> 4.7 节 / 4.6 节
```makefile

all : try_create_all_dependent_dir					\
			$(protram_output_dir)/execute.run
.PHONY : all


$(protram_output_dir)/execute.run : #.run 文件的依赖们

# 我测试了上述命令删除 FORCE 后一样执行顺利
try_create_all_dependent_dir:
  echo "无论如何都会输出字符串"


clean: FORCE 
  rm $(objects) 
FORCE:

# 我测试了上述命令删除 FORCE 后一样执行顺利

try_print_some_str:
  echo "无论如何都会输出字符串"
```


## 需求获取几个目录地址
获取 make 命令执行时候所在的目录 
```makefile
clean: 
  echo $(shell pwd)
```

1. 假设上述 makefile 所在目录为 `/home/userName/makefile`
2. 我们在 `/` 目录执行 `make --file='/home/userName/makefile' clean`
    - 输出结果为 `/`
