# 讨论 Android root 方案

adb的root和apk的root是两件不同的事(https://blog.csdn.net/qq_29924041/article/details/59106635)
- 其相同之处在于 root 这件事是相对进程而言的，获取 root 权限是一个进程的事。
- 置于能否以 root 权限进行安装这件事我们暂不考虑。
    - 因为以 root 权限进行安装和后面 su 获取 root 权限仅是两种手段，结果相同。

> 暂不分析上述二者的差异细节

adb root 需要重新编译 AndroidOS 。

apk root 需要导入 su 执行程序，这个动作又有不同的做法
1. SuperSU 内置
2. Google Default SU 内置

Xposed 是什么？
- 



