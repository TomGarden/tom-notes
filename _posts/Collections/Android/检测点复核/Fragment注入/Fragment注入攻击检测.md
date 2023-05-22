## 一、 漏洞原理
请查阅 [[译]Fragment注入](_译_Fragment注入.md)

## 二、 风险
敏感数据被查看和操作。

## 三、 影响范围
[3,+∞]

## 四、检测手段
1. 查看 app 中是否存在 PreferenceActivity 的子类。
2. 如果不存在安全；如果存在查看该 activity 是否导出。
3. 如果未导出安全；如果导出了。
4. 确认当前应用所兼容的 Android 系统版本
5. 如果包含 [11,18] 风险。
6. 只包含了 [19,+∞] 需要进一步确认
7. 确认 PreferenceActivity 是否覆写了 `isValidFragment` 方法
8. 没有覆写安全。
9. 如果覆写了且方法体中只有 `return true` 风险成立。

## 五、 修复建议
1. PreferenceActivity 如果可以的话不要设置为导出。
2. 如果存在导出的需求请确保应用兼容的 Android 版本为 [19,+∞] , 并且合理覆写 `isValidFragment` 方法。