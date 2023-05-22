1. [个人认为比较权威的学习资料(我没用它因为语言不熟练)](https://www.gnu.org/savannah-checkouts/gnu/bash/manual/bash.html)
2. [看起来还可以的学习资料 - 通读完毕](https://wangdoc.com/bash/)

每个命令执行都会产生一个退出码 . 可以通过 `echo $?` 的方式打印这个退出码 . 
- 在命令结束后 , 立刻 执行 `echo $?` 可以打印退出状态
- 如果输出为 0 , 表示上一个命令的运行结果是 成功
- 如果输出 非 0 , 表示上一个命令的运行结果是 失败 

shell script 中 函数的返回值
- 只能返回数字
- 只能通过 `$?` 获取返回值
- `flag=$(functionName)` 无法获取函数返回值


## 重定向

将标准输出和标准错误重定向到 `word` 文件 ; 

```
# 三种指令含义相同 
&>word
>&word
>word 2>&1
```

## 在一个 shell script 中调用其他的 shell script

`source` Bash 内建命令, 与 Bourne Shell 内建命令 `.` 意义相同
- [Bash Builtin Commands 内建命令 `source`](http://www.gnu.org/software/bash/manual/html_node/Bash-Builtins.html#Bash-Builtins)
- [Bourne Shell Builtins 内建命令 `.`](http://www.gnu.org/software/bash/manual/html_node/Bourne-Shell-Builtins.html)
- 从当前 shell 上下文中的文件名参数读取并执行命令。 如果文件名不包含斜杠，则使用 PATH 变量查找文件名。
  如果提供了任何参数，它们将在执行 filename 时成为位置参数。

## 


### 参考内容
1. https://stackoverflow.com/questions/8352851/shell-how-to-call-one-shell-script-from-another-shell-script



## 获取当前脚本绝对路径
```bash
echo $( dirname -- "${BASH_SOURCE[0]}" )
```

### 有一个错误
[bash_source 0 bad substitution](https://stackoverflow.com/questions/15541876/script-path-bash-source0-bad-substitution)
- 原因是 你在用 `/bin/sh` 吗？在 `Debian` 上，`/bin/sh` 是一个 `/bin/dash` 不支持 `${array[0]}` .

## 获取当前执行 shell 的 shell 名称
- `$$` : 获取当前进程的进程号
- `ps --pid $$`



