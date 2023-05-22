#!/usr/bin/bash


# shared_dir="/media/psf/ubuntu22.04"
# shared_tmp_dir="$shared_dir/beyourself/_global_config_file/shell/tmp_file"

# root_name="root"
# user_name="parallels"
# user_group=$user_name
# user_home_dir=/home/$user_name

# # install_some_apps="apt update                                                                            \
# #                    && apt upgrade -y                                                                     \
# #                    && apt install -y apt-transport-https ca-certificates"

# # chinese_language_app=" language-pack-zh* $(check-language-support)  "
# # install_apps="apt update                                                                            \
# #               && apt upgrade -y                                                                     \
# #               && apt install -y apt-transport-https ca-certificates                                 \
# #               locales zsh sudo                                                                      \
# #               git inetutils-ping less man-db  tmux dialog                                           \
# #               htop cmake tree unzip                                                                 \
# #               wget curl net-tools openssl openssh-server vim gdb pkg-config build-essential doxygen \
# #               libcurl4-openssl-dev                                                                  \
# #               libssl-dev libfcgi-dev libcgicc-dev libgflags-dev                                     \
# #               spawn-fcgi $chinese_language_app"
# # test="apt install -y $(check-language-support)"
# # echo "安装软件 , 需要先输入 $root_name 密码"
# # # su $root_name -c "$install_some_apps"
# # su $root_name -c "$install_apps"



# echo "ubuntu 支持中文输入法设置 , setting -> keyboard -> plus -> ... -> other -> chinese(Intelligent Pinyin)"


# echo "开始安装 ros2 for 22.04 , 需要设备已经是翻墙的状态"
# # Ubuntu存储库：Main、Universe、Multiverse、Restricted和Partner
# # 1、Main >>  安装Ubuntu时，这是默认启用的存储库，主存储库仅包含FOSS（免费和开源软件），可以自由分发而不受任何限制。
# # 2、Universe >> 此存储库还包含免费和开源软件，但Ubuntu不保证此类软件的定期安全更新。
# # 3、Multiverse >> Multiverse包含不是FOSS的软件，由于许可和法律问题，Ubuntu默认情况下无法启用此存储库，无法提供修复和更新。
# # 4、Restricted >> Ubuntu试图只提供免费和开源软件，但在支持硬件方面并不总是这样。
# # 5、Partner >> 该存储库由Ubuntu为其合作伙伴打包的专有软件组成，早些时候，Ubuntu曾经通过这个存储库提供Skype。

# #  apt install software-properties-common
# #  add-apt-repository -y universe
# #  apt update &&  apt install -y curl gnupg lsb-release
# #  curl -sSL https://raw.githubusercontent.com/ros/rosdistro/master/ros.key -o /usr/share/keyrings/ros-archive-keyring.gpg


# # install_ros2_dep="apt install -y software-properties-common  \
# #            && add-apt-repository -y universe  \
# #            && apt update    \
# #            && apt install -y curl gnupg2 lsb-release  \
# #            && curl -sSL https://raw.githubusercontent.com/ros/rosdistro/master/ros.key  -o /usr/share/keyrings/ros-archive-keyring.gpg  "

# # su $root_name -c "$install_ros2_dep"

# # sudo echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/ros-archive-keyring.gpg] http://packages.ros.org/ros2/ubuntu $(source /etc/os-release && echo $UBUNTU_CODENAME) main" | sudo tee /etc/apt/sources.list.d/ros2.list > /dev/null

# # install_ros2="apt update && sudo apt upgrade -y && apt install -y ros-humble-desktop "
# # su $root_name -c "$install_ros2"

# # echo '后续操作(Environment, testApi)参考 : https://docs.ros.org/en/humble/Installation/Ubuntu-Install-Debians.html'

# echo -e "\n\n\n
# ######################################################################################################
# #
# #  安装信息 : ros_version=$ROS_DISTRO
# #  还需要做的操作 : 
# #   >. 验证 C++    api 是否正常工作 :  ros2 run demo_nodes_cpp talker
# #   >. 验证 Python api 是否正常工作 :  ros2 run demo_nodes_py talker 
# #   >. ubuntu 支持中文输入法设置 , setting -> keyboard -> plus -> ... -> other -> chinese(Intelligent Pinyin)
# #   >. 全部设置完成后记得重启下 
# #   
# #
# ######################################################################################################
# \n\n\n"

shell_zsh_flag=$(echo $SHELL | grep --regexp 'zsh$')

if   [ -n $shell_zsh_flag ]; then
  echo "zsh"
elif [ -n $shell_bash_flag ]; then
  echo "bash"
else
  echo "未覆盖的 shell 类型 , 没有初始化 ros 环境变量"
fi