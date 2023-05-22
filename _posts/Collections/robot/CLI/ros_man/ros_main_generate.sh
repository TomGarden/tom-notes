#!/usr/bin/bash

################################################################################
#
# 使用 ros2 命令行 , 总是忘记各个命令 , zsh 目前还不能自动补全 , 我们先打印下所有命令内容
# 后续如果有时间我们尝试坐下 zsh 自动补全的能力 , 使用起来会舒服很多 . 
#
################################################################################


ros="ros2"
colcon="colcon"
output_file="/media/psf/ubuntu20.04/document/ros_man/colcon.man.log"
dividing_line="================================================================================"

# 入参 $1 表示 命令字符串 例如 `ros2`  `ros2 action` `ros2 action list`
function print_to_file() {
  echo "print_to_file()"

  local cmd="$1 --help"
  local command_str=$($cmd)
  
  echo ">>>>>>>>>>>>>>>> $1"
  echo ">>>>>>>>>>>>>>>> $cmd"
  echo -e "\n$dividing_line \n\$ $cmd" >> $output_file
  echo "$command_str" >> $output_file
}

function print_cmd_info() {

  echo "print_cmd_info()"
  local command_str=$($1 --help)
  # IFS=$'\0'
  local IFS=$'\n'
  local flag="colcon verbs:"      # 开始标记
  local break_flag="{build,extension-points,extensions,graph,info,list,metadata,test,test-result,version-check}"     # 终止标记
  local recursion=0   # 0, 不递归 , 1 进入递归
  local break_function=0 
  local break_all_for_loop=0 # 1 , 跳出

  for one_line in $command_str ; do 

    # echo "$one_line"
    if   [ $recursion -eq 1  ] ; then
      
      IFS=" "
      local first_word=""
      for one_word in $one_line ; do 
        first_word="$one_word" 
        break
      done
      echo "$one_word"
      echo "$break_flag"
      if [ $one_word = $break_flag ] ; then 
        echo "break---11111111111111"
        break 
      fi
      print_cmd_info "$1 $first_word"

      if [ $break_all_for_loop -eq 1 ] ; then 
        echo "break---2222222222222"
        break  
      fi

      # 开始处理后续字符串中的子命令
      echo "处理后续指令 : $one_line"
    elif [ $one_line = $flag ] ; then
      echo "标识变更 : $one_line"
      recursion=1
    fi

    IFS=$'\n'

  done  # 逐行遍历 for 循环 终止

  # echo "******************:$1"
  # print_to_file "$1"        # 问题在于嵌套到下一个函数里就无法正常执行

  echo ">>>>>>>>>>>>>>>> $1"
  echo ">>>>>>>>>>>>>>>> $result_cmd"
  echo -e "\n$dividing_line \n\$ $1 --help" >> $output_file
  echo "$command_str" >> $output_file

}



# print_cmd_info $ros
print_cmd_info $colcon


# command_str=$($ros --help)
# echo "$command_str"

# cmd="ros2"
# print_to_file "$cmd"
# cmd="ros2 action"
# print_to_file "$cmd"
# cmd="ros2 action list"
# print_to_file "$cmd"



