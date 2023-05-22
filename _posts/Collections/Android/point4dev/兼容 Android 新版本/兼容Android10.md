## 0x00. [Android 10](https://developer.android.com/about/versions/10)
Android 10的首个开发者预览版本（即测试版）在2019年3月14日发行并提供下载。[3]正式版于2019年9月3日发行。此版本Android是各Android版本中，首次不用甜品来命名。

## 0x01. Android 10 兼容维护的应用关注的点

#### 1.1. 用户隐私设置

- 阻止设备跟踪
- 保护外部存储设备中的用户数据
- 屏蔽意外中断

#### 1.2. 安全性

- 存储加密 : 针对于此测试并替换了媒体选择库三方依赖

#### 1.3. 限制非 SDK 接口 

使用 veridex 工具进行测试

```
#40: Reflection blacklist Landroid/hardware/camera2/legacy/LegacyCameraDevice;->detectSurfaceType use(s):
       Landroidx/camera/camera2/internal/compat/params/OutputConfigurationCompatBaseImpl$OutputConfigurationParamsApi21;->getSurfaceFormat(Landroid/view/Surface;)I

#41: Reflection blacklist Landroid/hardware/camera2/legacy/LegacyCameraDevice;->getSurfaceSize use(s):
       Landroidx/camera/camera2/internal/compat/params/OutputConfigurationCompatBaseImpl$OutputConfigurationParamsApi21;->getSurfaceSize(Landroid/view/Surface;)Landroid/util/Size;


93 hidden API(s) used: 2 linked against, 91 through reflection
	65 in greylist
	2 in blacklist
	12 in greylist-max-o
	9 in greylist-max-p
	5 in greylist-max-q
To run an analysis that can give more reflection accesses, 
but could include false positives, pass the --imprecise flag. 
```




确定上述三个接口的调用位置 : 系统调用 : 未见异常


次要关注
1. 深色主题
2. Android 基础知识
 - ART 优化
 - 通过公共 API 实现兼容性



## 0x03. 动作

针对 SDK29 编译安装后 Glide 加载图片发生警告
 - 升级 Glide 版本

查看媒体选择库是否符合新系统的需求
 - 替换旧的媒体选择库

查看 black list 可能影响到的功能
 - 调用摄像头和麦克未见异常

查看大图组件保存文件失败系权限问题
 - 使用推荐 API 完成 SD 卡访问动作



## 0x04. TODO
- _在后台运行时访问设备位置信息需要权限_
- _关于分区存储_
	- saveImageToFile
	- createIMGFile
	- FileUtilKt 所有的对外调用均需要做一个排查

- 一些电话 API、蓝牙 API 和 WLAN API 需要精确位置权限
- 黑名单 API(50%) 

## 0x05. 测试关注点

> 应该在 Android10 真机进行测试

1. 关于本地文件的操作
2. 关于蓝牙小票打印的功能
3. 有关于相机调用的功能
