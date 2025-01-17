#!/bin/bash  

# 检查当前用户是否是 tom
function is_user_1000_1000() {
    if [ "$(id -u)" -eq 1000 ] && [ "$(id -g)" -eq 1000 ]; then
        return 0  # 表示 true
    else
        return 1  # 表示 false
    fi
}


# 监听屏幕数量的函数
function monitor_screen_count() {
    local max_attempts=10  # 最大循环次数
    local log_path=/Volumes/Document/synchronization/tom-notes/_posts/Collections/Operations/Linux/Debian/log.log
    local count=0  # 当前循环计数
    local screen_count=0

    echo "开始监听屏幕数量..." > "$log_path"

    while [ $count -lt $max_attempts ]; do
        # 获取屏幕数量
        screen_count=$(xrandr --listmonitors | awk '/Monitors:/ {print $2}')
        local timestamp=$(date +"%Y-%m-%d %H:%M:%S")

        echo "$timestamp 屏幕数量: $screen_count" >> "$log_path"



        # 如果屏幕数量大于 1，立即返回
        if [ "$screen_count" -gt 1 ]; then
            echo $screen_count
            return
        fi

        # 延时 2 秒，避免过于频繁
        sleep 1

        # 计数增加
        count=$((count + 1))
    done

    echo "监听结束，共执行 $count 次。" >> "$log_path"

    echo $screen_count
    return
}



function hdmi_display_event_check() {
    local cutTime=$(date +"%Y-%m-%d_%H-%M-%S")
    local log_path=/Volumes/Document/synchronization/tom-notes/_posts/Collections/Operations/Linux/Debian/log.log
    # 读取HDMI连接状态
    local status=$(cat /sys/class/drm/card1-HDMI-A-1/status)

    # 拔出事件
    if [ "$status" = "disconnected" ]; then 
        # 锁屏动作
        echo "$cutTime 拔出了外置显示器" >> $log_path
        su - tom -c 'cinnamon-screensaver-command -l'
    # 插入事件
    elif [ "$status" = "connected" ]; then 
        # 关闭笔记本自身屏幕
        echo "$cutTime 连接了外置显示器" >> $log_path

        # 调用 monitor_screen_count 函数并捕获返回值
        local screen_count=$(monitor_screen_count)
        if [ "$screen_count" -gt 1 ]; then
            su - tom -c 'DISPLAY=:0 XAUTHORITY=/home/tom/.Xauthority xrandr --verbose --output eDP-1 --off --output HDMI-1 --auto'
        fi
        # su - tom -c 'DISPLAY=:0 XAUTHORITY=/home/tom/.Xauthority xrandr --verbose --output eDP-1 --off --output HDMI-1 --auto'
    else   
        # 关闭笔记本自身屏幕
        echo "$cutTime 未知事件" >> $log_path
    fi
}

hdmi_display_event_check    

