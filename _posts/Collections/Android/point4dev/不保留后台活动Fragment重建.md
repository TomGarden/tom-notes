## 0x00. 不保留后台活动的情况下 Fragment 重建

在不保留后台活动的情况下啊, 由 Fragment 组成的 Activity 页面的杀死和重建过程有 UI 异常. 具体体现为:
1. 在初次启动 Activity 的时候是可以正常填充的, UI 逻辑也没有任何问题.
2. 具体体现为, Fragment 子页面为空(没有被预期逻辑填充)

## 0x01. 问题跟进

首次启动 Activity
1. MyFragmentPageAdapter : @8342
2. runOutFrag : @8447
3. expireFrag : @8469