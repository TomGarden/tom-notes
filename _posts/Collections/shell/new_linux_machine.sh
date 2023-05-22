#!/usr/bin/bash

# 脚本意图 : 
#   每次迁移机器的是偶都需要做几件事
#   1. 创建自己喜欢的用户名称 , 删除旧的用户相关信息
#   2. 创建自己常用的文件夹 , 拷贝自己常用文件
#   3. 安装自己常用的软件



# 参考内容 :
# 1. [个人认为比较权威的学习资料(我没用它因为语言不熟练)](https://www.gnu.org/savannah-checkouts/gnu/bash/manual/bash.html)
# 2. [看起来还可以的学习资料 - 通读完毕](https://wangdoc.com/bash/)
# 3. [内建命令在命令行不明原因没有 man 手册](https://linuxcommand.org/lc3_man_page_index.php#builtins)
#    - [The Linux Command Line 的中文版 - 没细看,好不好不知道](http://billie66.github.io/TLCL/index.html)


function errExitOn() { 
  set -e 
}
function errExitOff() { 
  set +e 
}



set -u # 默认的 `Bash` 碰到一个不存在的变量 , 会跳过他 . 
       # 此设置后 , `Bash` 遇到不存在的变量后将向 标准错误 输出此异常 , 并退出脚本 . 

set -x # 默认的 , 命令执行后如果有输出就会到 到标准输出 , 如果有错误就会到 标准错误
       # 这个设置 , 导致命令执行前 , 会先将命令打印一次 , 再执行它
       # 脚本执行完毕记得关闭

errExitOn # 如果命令执行后退出码($?)非零 , 立刻退出 shell , 这会导致脚本所在 subshell 终止 , 阻止后续命令的继续执行 . 
          # 一个命令执行出错后退出码($?)非零 , 没有出错则为零 . 
set -o pipefail # 默认的 , 管道 `|` 组合多个子命令 , 组合命令的退出码 , 是最后执行那个命令的退出码 . 
                # 此设置的作用:
                #  管道命令的返回值是所有子命令中最后的那个非零的值 , 
                #  如果所有的管道子命令返回值都是 0 , 管道命令总的返回值为 0
                #  补足 `set -e` 在管道命令中的不足




# 是否需要创建新用户用户
function isNeedUser() {
  # 调用方式
  # errExitOff
  # isNeedUser
  # isNeedUserResult=$?
  # errExitOn


  read -p "即将为你创建你创建用户 , 请输入你的用户名 > " userInputUserName 
  local currentUserName=$(whoami)
  
  if [ "$userInputUserName" == "$currentUserName" ] ; then
    # echo "当前用户名和用户录入相同"
    return 1
  else 
    # echo "当前用户名和用户录入不同呀 啊"
    return 0
  fi
}


function toCreateNewUser() {
  
}



if [ $isNeedUserResult -eq 0 ] ; then 
  echo "需要创建新用户"
elif [ $isNeedUserResult -eq 1 ] ; then
  echo "不需要创建新用户" 
else 
  echo "逻辑异常"
  exit 1
fi










errExitOff
exit 0