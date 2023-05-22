# getevent
> 2017年11月28日11:22:08

关于 getevent 我们的直接需求是通过其获取屏幕事件，然后将获取到的数据转换为人可以理解的形式。

过去的使用，我们仅仅关注了我们关心的数据，对于一些其他的内容我们置若罔闻。

- 关键字：
    - toolbox
    - getevent

## 一、 是什么
表示 Android 中的输入信息获取程序。
## 二、 做什么
用来获取和查看各个设备的输入信息/数据。
## 三、 怎么做

## 四、 一些细节
帮(故)助(意)信(输)息(错)
```terminal
$ getevent -?
getevent: invalid option -?
Usage: getevent [-t] [-n] [-s switchmask] [-S] [-v [mask]] [-d] [-p] [-i] [-l] [-q] [-c count] [-r] [device]
    -t: show time stamps
    -n: don't print newlines
    -s: print switch states for given bits
    -S: print all switch states
    -v: verbosity mask (errs=1, dev=2, name=4, info=8, vers=16, pos. events=32, props=64)
    -d: show HID descriptor, if available
        显示HID描述符（如果可用）
    -p: show possible events (errs, dev, name, pos. events)
        显示可能发生的事件
    -i: show all device info and possible events
        显示所有设备信息和可能发生的事件
    -l: label event types and names in plain text
        用纯文本标记事件的类型和名称
    -q: quiet (clear verbosity mask)
    -c: print given number of events then exit
    -r: print rate events are received
```
以下尝试翻译一下
```terminal
$ getevent -i
add device 1: /dev/input/event5
  bus:      0000
  vendor    0000 [供应商]
  product   0000 [产品]
  version   0000 [版本]
  name:     "msm8974-taiko-mtp-snd-card Headset Jack" [名称：“msm8974-taiko-mtp-snd-card耳机插孔”]
  location: "ALSA" [位置：高级 Linux 声音架构(Advanced Linux Sound Architecture)]
  id:       ""
  version:  1.0.1
  events:[事件]
    SW  (0005): 0002  0004  0006  000e  000f  0010
  input props:[输入道具]
    <none>
add device 2: /dev/input/event4
  bus:      0000
  vendor    0000
  product   0000
  version   0000
  name:     "msm8974-taiko-mtp-snd-card Button Jack"[名称：按键插孔(猜测是耳机按钮)]
  location: "ALSA"
  id:       ""
  version:  1.0.1
  events:
    KEY (0001): 0100  0101  0102  0103  0104  0105  0106  0107
  input props:
    <none>
add device 3: /dev/input/event3
  bus:      0000
  vendor    0001
  product   0001
  version   0001
  name:     "hs_detect"
  location: ""
  id:       ""
  version:  1.0.1
  events:
    KEY (0001): 0072  0073  00e2
    SW  (0005): 0002  0004
  input props:
    <none>
add device 4: /dev/input/event1
  bus:      0000
  vendor    0000
  product   0000
  version   0000
  name:     "touch_dev" [名称：触摸设备]
  location: ""
  id:       ""
  version:  1.0.1
  events:
    ABS (0003): 002f  : value 0, min 0, max 9, fuzz 0, flat 0, resolution 0
                0030  : value 0, min 0, max 15, fuzz 0, flat 0, resolution 0
                0035  : value 0, min 0, max 1079, fuzz 0, flat 0, resolution 0
                0036  : value 0, min 0, max 1919, fuzz 0, flat 0, resolution 0
                0039  : value 0, min 0, max 65535, fuzz 0, flat 0, resolution 0
                003a  : value 0, min 0, max 255, fuzz 0, flat 0, resolution 0
  input props:
    INPUT_PROP_DIRECT
add device 5: /dev/input/event0
  bus:      0000
  vendor    0000
  product   0000
  version   0000
  name:     "qpnp_pon"
  location: "qpnp_pon/input0"
  id:       ""
  version:  1.0.1
  events:
    KEY (0001): 0074
  input props:
    <none>
add device 6: /dev/input/event2
  bus:      0019
  vendor    0001
  product   0001
  version   0100
  name:     "gpio-keys"
  location: "gpio-keys/input0"
  id:       ""
  version:  1.0.1
  events:
    KEY (0001): 0072  0073
    SW  (0005): 0000
  input props:
    <none>
```
关于各个 devices event 有了一个好办法，那就是试试就知道啦
```terminal
//测试设备 Google Nexus 5 : 需要知道的是各个设备(手机硬件)的下述内容不尽相同。
add device 1: /dev/input/event5
  name:     "msm8974-taiko-mtp-snd-card Headset Jack"
    翻译：耳机插孔
    测试：全程未触发
add device 2: /dev/input/event4
  name:     "msm8974-taiko-mtp-snd-card Button Jack"
    测试：本事件全程未触发我也没看明白
add device 3: /dev/input/event3
  name:     "hs_detect"
    根据耳机插孔的拼写和 detect(检测) 推知：耳机检测
    测试：耳机插拔会触发本事件，耳机上按钮的使用也全都触发本事件
add device 4: /dev/input/event1
  name:     "touch_dev" 
    测试很容易知道这是触屏事件，没有实体键的设备(向华为)，底部按键也是这个事件。
add device 5: /dev/input/event0
  name:     "qpnp_pon"
    测试发现这是电源按钮
    QPNP (Qualcomm Plug N Play：Qualcomm即插即用) 设备，此处所指是电池。
add device 6: /dev/input/event2
  name:     "gpio-keys"
    测试发现这是音量键
    gpio[General Purpose Input Output] （通用输入/输出）简称为GPIO，或总线扩展器。
```

## 五、 转换屏幕触摸事件为人类可理解的事件模型
针对所收集到的数据提供下表
```
|events:ABS (0003)                                              | getevent -l                               | getevent           |
|---------------------------------------------------------------|-------------------------------------------|--------------------|
|002f  : value 0, min 0, max 9, fuzz 0, flat 0, resolution 0    |EV_ABS       ABS_MT_TRACKING_ID   000007c4 |  0003 0039 000007c4|
|0030  : value 0, min 0, max 15, fuzz 0, flat 0, resolution 0   |EV_ABS       ABS_MT_POSITION_X    0000010c |  0003 0035 0000010c|
|0035  : value 0, min 0, max 1079, fuzz 0, flat 0, resolution 0 |EV_ABS       ABS_MT_POSITION_Y    0000073b |  0003 0036 0000073b|
|0036  : value 0, min 0, max 1919, fuzz 0, flat 0, resolution 0 |EV_ABS       ABS_MT_PRESSURE      0000002f |  0003 003a 0000002f|
|0039  : value 0, min 0, max 65535, fuzz 0, flat 0, resolution 0|EV_ABS       ABS_MT_TOUCH_MAJOR   00000005 |  0003 0030 00000005|
|003a  : value 0, min 0, max 255, fuzz 0, flat 0, resolution 0  |EV_SYN       SYN_REPORT           00000000 |  0000 0000 00000000|
|                                                               |EV_ABS       ABS_MT_TRACKING_ID   ffffffff |  0003 0039 ffffffff|
|                                                               |EV_SYN       SYN_REPORT           00000000 |  0000 0000 00000000|
```

上述，我们关注的值是：
- ABS_MT_POSITION_X
- ABS_MT_POSITION_Y

个人测试结果
```java
    //获取屏幕大小
    private void getScreenSize() {
        DisplayMetrics dm = new DisplayMetrics();
        getWindowManager().getDefaultDisplay().getMetrics(dm);
        Log.d("size", "heigth : " + dm.heightPixels);
        Log.d("size", "width : " + dm.widthPixels);
    }

    //获取点击位置
    @Override
    public boolean onTouchEvent(MotionEvent event) {
        Log.i("touch--XXX", "" + event.getX());
        Log.i("touch--YYY", "" + event.getY());
        return super.onTouchEvent(event);
    }
//------------------------------------------------------------
//                        日志输出：
//------------------------------------------------------------
I/touch--XXX: 711.0
I/touch--YYY: 778.0
I/touch--XXX: 711.0
I/touch--YYY: 778.0
D/size: heigth : 1776  //这个值没有计算底部的三个虚拟按钮，通过截图查看图片大小和网络查看设备屏幕大小得到的都是 1920 X 1080
D/size: width : 1080

//------------------------------------------------------------
//                        命令行输出：
//------------------------------------------------------------
EV_ABS       ABS_MT_TRACKING_ID   000007ec
EV_ABS       ABS_MT_POSITION_X    000002c7  [十进制：711]
EV_ABS       ABS_MT_POSITION_Y    0000030a  [十进制：778]
EV_ABS       ABS_MT_PRESSURE      00000031
EV_ABS       ABS_MT_TOUCH_MAJOR   00000005
EV_SYN       SYN_REPORT           00000000
EV_ABS       ABS_MT_TRACKING_ID   ffffffff
EV_SYN       SYN_REPORT           00000000
```

[有人说](http://www.360doc.com/content/14/0628/14/426085_390487096.shtml),上述两个值转换为坐标值需要计算计算同时如下(该公式是通过查看androidvncserver源码，然后反向推出的公式)：
- y=(y-ymin)*800/(ymax-ymin);
- x=(x-xmin)*480/(xmax-xmin);

上述数据我们使用这个公式计算一下查看 
- y = (778-0)*1920/(1919-0)
- x = (711-0)*1080/(1080-0)

我不用换算，这个原因是和 DPI 相关。

## 参考 & 摘录
如果在百度不能了解到自己满意的信息和数据，别忘了这个世界上还有一个搜索引擎叫做 Google 。
1. [[精]--getevent 工具 和 Android 中input event的分析](http://www.360doc.com/content/14/0126/11/14797374_348056760.shtml)
2. [adb shell getevent中获取到的屏幕事件的坐标转换 . | Micro Blog](http://www.360doc.com/content/14/0628/14/426085_390487096.shtml)
2. [关于 getevent google 的一些描述](https://source.android.com/devices/input/getevent?hl=zh-cn)
    - [该工具的源代码](https://android.googlesource.com/platform/system/core.git/+/android-4.2.2_r1/toolbox/getevent.c)
3. [emulate touch event from adb](http://blog.csdn.net/flxuelee/article/details/52815649)
4. [android测试之getevent/sendevent](http://blog.51cto.com/sunzeduo/1294839)

