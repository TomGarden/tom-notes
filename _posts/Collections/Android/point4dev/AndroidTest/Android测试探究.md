


## 0x00. 关于名词
- 单元测试
- 集成测试
- 端到端



## 0x01. 关于测试工具

### 1.1. [Robolectric](http://robolectric.org/)
宣称自己可以避免在真机或者模拟器上的安装部署的耗时操作(这通常耗时1min+) , 通过测试框架在 JVM 中测试自己的 Android 代码(宣称时间用秒计算)

#### 1.1.1. Robolectric 的设计目标

#### 1.1.2. Robolectric 的边界
1. 尽管许多Android框架在Robolectric测试中可以按预期工作，但某些Android组件的常规行为无法很好地转化为单元测试：需要模拟硬件传感器，需要将测试夹具数据加载到系统服务中。

### 1.2. [Espresso](https://developer.android.com/training/testing/espresso?hl=zh-cn)

- Espresso 可让您以编程方式且以线程安全的方式找到应用中的界面元素并与之互动。
- [UI Automator API](https://developer.android.com/training/testing/ui-testing/uiautomator-testing?hl=zh-cn)
- 通过 UI Automator API，您可以与设备上的可见元素进行互动，而不管获得焦点的是哪个 Activity 或 Fragment。

#### 1.1.1. Espresso 的设计目标
Espresso 面向认为自动化测试是开发生命周期不可或缺的一部分的开发者。虽然 Espresso 可用于黑盒测试，但熟悉被测代码库的人员可以开启它的全部功能。

#### 1.1.2. Espresso 的边界



### 1.3. [Firebase 测试实验室](https://firebase.google.com/docs/test-lab/?hl=zh-cn)




### 1.4. [AndroidX Test](https://developer.android.com/training/testing/fundamentals?hl=zh-cn)

[一个断言库 Truth](https://truth.dev/)





## 关于测试示例项目





## 关于测试实践





## 关于测试心得





## 参考
1. https://developer.android.com/training/testing?hl=zh-cn
    - [测试项目示例](https://github.com/android/testing-samples)
2. [AndroidStudio 测试指南](https://developer.android.com/studio/test)