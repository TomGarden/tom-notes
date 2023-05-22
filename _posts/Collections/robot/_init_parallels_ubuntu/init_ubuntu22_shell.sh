#!/usr/bin/bash


###################################################################################################
# >. 整个操作建议在 科学上网 条件下完成 
# >. 以 root 身份执行
# >. 运行过程讲日志保存的文件方便查看异常信息
###################################################################################################

shared_dir="/media/psf/ubuntu22.04" # 配置文件根目录
shared_global_dir="$shared_dir/beyourself/_global_config_file"
shared_tmp_dir="$shared_global_dir/shell/tmp_file"

os_name="ubuntu22"        # 主机名
root_name="root"
user_name="parallels"
user_group=$user_name
user_home_dir=/home/$user_name
root_home_dir=/$root_name

install_some_apps="apt update                                                                            \
                   && apt upgrade -y                                                                     \
                   && apt install -y apt-transport-https ca-certificates"
ros_tools_apps="python3-argcomplete python3-colcon-common-extensions python3-rosdep python3-catkin-tools python3-pip"
install_apps="apt update                                                                            \
              && apt upgrade -y                                                                     \
              && apt install -y apt-transport-https ca-certificates                                 \
              locales zsh sudo                                                                      \
              git inetutils-ping less man-db  tmux dialog                                           \
              htop cmake tree unzip                                                                 \
              wget curl net-tools openssl openssh-server vim gdb pkg-config build-essential doxygen \
              libcurl4-openssl-dev                                                                  \
              libssl-dev libfcgi-dev libcgicc-dev libgflags-dev                                     \
              spawn-fcgi gnome-tweak-tool $ros_tools_apps"

echo -e "\n\n
>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>安装软件"
su $root_name --command "$install_some_apps"

echo -e "\n\n
>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>换清华源"
source_file="$shared_tmp_dir/override_t_sources.list"
change_source="cp /etc/apt/sources.list /etc/apt/sources.list.tom.bak     \
            && cat $source_file > /etc/apt/sources.list                   \
            && $install_apps "
su $root_name --command "$change_source"

echo -e "\n\n
>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>设置支持中文字符"
support_chinese_charactor="cat $shared_tmp_dir/override_to_def_locale > /etc/default/locale \
                           && cat $shared_tmp_dir/append_to_locale.gen >> /etc/locale.gen  \
                           && locale-gen"
su $root_name --command "$support_chinese_charactor"

echo -e "\n\n
>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>开始安装 oh-my-zsh"
source $shared_global_dir/shell/tom_shell_proxy_profile
omzsh_shell_path="$shared_tmp_dir/omzshInstallSh"
curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh --output $omzsh_shell_path
ohmzsh_install="bash $omzsh_shell_path --unattended"
su $root_name --command "$ohmzsh_install"
su $user_name --command "$ohmzsh_install"

shell_append_rc_file="$shared_tmp_dir/append_to_shell_rc"
config_shell="cat $shell_append_rc_file >> ~/.bashrc \
           && cat $shell_append_rc_file >> ~/.zshrc"
su $root_name --command "$config_shell"
su $user_name --command "$config_shell"

su $root_name --command "usermod --shell /usr/bin/zsh $root_name"
su $root_name --command "usermod --shell /usr/bin/zsh $user_name"

echo -e "\n\n
>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>开始设置 vim 样式"
vim_append_rc_file="$shared_tmp_dir/append_to_vimrc"
su $user_name --command "cat $vim_append_rc_file >> $user_home_dir/.vimrc"

echo -e "\n\n
>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>修改主机名"
su $root_name --command "echo $os_name > /etc/hostname"


echo -e "\n\n\n\n\n
>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>开始安装 ros2 for 22.04 , 需要设备已经是翻墙的状态"
echo -e">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>后续操作参考 : https://docs.ros.org/en/humble/Installation/Ubuntu-Install-Debians.html"
# Ubuntu存储库：Main、Universe、Multiverse、Restricted和Partner
# 1、Main >>  安装Ubuntu时，这是默认启用的存储库，主存储库仅包含FOSS（免费和开源软件），可以自由分发而不受任何限制。
# 2、Universe >> 此存储库还包含免费和开源软件，但Ubuntu不保证此类软件的定期安全更新。
# 3、Multiverse >> Multiverse包含不是FOSS的软件，由于许可和法律问题，Ubuntu默认情况下无法启用此存储库，无法提供修复和更新。
# 4、Restricted >> Ubuntu试图只提供免费和开源软件，但在支持硬件方面并不总是这样。
# 5、Partner >> 该存储库由Ubuntu为其合作伙伴打包的专有软件组成，早些时候，Ubuntu曾经通过这个存储库提供Skype。

# 有多个版本可供选择
ros_humble_desktop="ros-humble-desktop"
ros_foxy_desktop="ros-foxy-desktop"

install_ros2_dep="apt install -y software-properties-common  \
           && add-apt-repository -y universe  \
           && apt update    \
           && apt install -y curl gnupg2 lsb-release  \
           && curl -sSL https://raw.githubusercontent.com/ros/rosdistro/master/ros.key  -o /usr/share/keyrings/ros-archive-keyring.gpg  "

su $root_name --command "$install_ros2_dep"

sudo echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/ros-archive-keyring.gpg] http://packages.ros.org/ros2/ubuntu $(source /etc/os-release && echo $UBUNTU_CODENAME) main" | sudo tee /etc/apt/sources.list.d/ros2.list > /dev/null

install_ros2="apt update && sudo apt upgrade -y && apt install -y $ros_humble_desktop "
su $root_name --command "$install_ros2"



echo -e "\n\n\n
######################################################################################################
#
#  安装信息 : ros_version=$ROS_DISTRO
#  还需要做的操作 : 
#   >. 安装中文 setting -> manage install language -> Install/... -> Chinese(xxx)
#   >. ubuntu 支持中文输入法设置 , setting -> keyboard -> plus -> ... -> other -> chinese(Intelligent Pinyin)
#   >. reboot
#   >. 查看安装的版本  echo \$ROS_DISTRO
#   >. 验证 C++    api 是否正常工作 :  ros2 run demo_nodes_cpp talker
#   >. 验证 Python api 是否正常工作 :  ros2 run demo_nodes_py talker 
#   >. 全部设置完成后记得重启下 
#   
#
######################################################################################################
\n\n\n"




