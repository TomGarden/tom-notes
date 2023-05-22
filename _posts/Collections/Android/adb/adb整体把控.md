### 〇、查看命令手册
0. adb
1. adb shell content
2. adb shell am
3. adb shell pm
4. 但是 am | pm 这些字段是在哪里获取的？


### 一、命令行启动程序的方法
- 启动计算器 # am start -n com.android.calculator2/com.android.calculator2.Calculator
- 启动系统自带的日历 # am start -n com.android.calendar/com.android.calendar.LaunchActivity
- 启动闹钟 # am start -n com.android.alarmclock/com.android.alarmclock.AlarmClock
- 启动照相机 # am start -n com.android.camera/com.android.camera.Camera
- 启动音乐播放器 # am start -n com.android.music/com.android.music.MusicBrowserActivity
- 启动视频播放器 # am start -n com.android.music/com.android.music.VideoBrowserActivity
- 启动音频播放器 # am start -n com.android.music/com.android.music.MediaPlaybackActivity
- 启动浏览器 # am start -n com.android.browser/com.android.browser.BrowserActivity url
- 启动浏览器 # am start -a android.intent.action.VIEW -d http://www.google.cn/
- 拨打电话 am start -a android.intent.action.CALL -d tel:10086
- 启动 google map 直接定位到北京 :am start -a android.intent.action.VIEW geo:0,0?q=beijing





## 源
1. [Android adb命令启动系统组件](http://blog.csdn.net/corey_jia/article/details/47783007)
2. [看起来还可以](http://www.cnblogs.com/OrdinaryTravel/p/4548471.html)
