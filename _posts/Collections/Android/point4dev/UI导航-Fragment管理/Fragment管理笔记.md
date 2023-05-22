

## 0x00. 我们面临的问题
1. Fragment 生命周期管理问题不明确 , 或者说使用的不够熟练 ; 
    直接通过 FragmentManager 和 FrameLayout 对象进行的生命周期管理动作 , 
    让我们不能完整地把我 Fragment 的生命周期流转细节 
    - 这里需要输出一个过去的管理方式 , 因为理论上过去的管理方式只要理解的足够清晰也是不会出现上述问题的


## 0x01. 了解对于 Fragment 的生命周期管理的细节
在学习过程中发现 Jetpack 有提供导航相关的组件 , 从描述看就是我们没有处理好的 关于 FragmentManager 的使用问题 的封装
1. https://developer.android.com/guide/navigation
2. https://developer.android.com/jetpack/androidx/releases/navigation
3. `AndroidStudio4.1.2` -> `file` -> `new module` -> `Phone & Tablet Module` -> `next` -> `next` -> `Navigation Drawer Activity` -> 然后一路完成创建就有了一个例程


## 0x02. 关于 Navigation 相关的学习和测试描述
0. 主要和 Activity 生命周期做对比
1. 生命周期流转是否完整
    - 含状态保存和恢复动作
2. 进出栈动作管理细节是否可用 , 启动结果回调获取能力是否完善



## XxXX. 滞后动作
1. 关于 FragmentManager 对于 Fragment 生命周期的管理细节深入了解