## 一、学习教程
[Android逆向之旅---动态方式破解apk进阶篇(IDA调试so源码)](http://blog.csdn.net/jiangwei0910410003/article/details/51500328)

## 二、目录结构
- 一、前言
- 二、知识准备
- 三、构造so案例
- 四、开始破解so文件
- 五、使用IDA来解决反调试问题
- 六、技术总结

## 三、策略
1. 前言看过忘了
2. 只是准备，用到时候回来查
3. 构造案例
4. 破解自构造的案例

## 四、开始
### 4.1、构造SO案例
用JNI实现一个加法运算。
### 4.2、开始破解SO文件
这里我们找到两个可以执行的SO文件所以我决定下两个端点，这样的话万无一失。
1. 确定端点位置，根据SO  start point  和 方法相对地址
    - 相对地址.text:00000554
    - libJniCalculateSO.so B3782000 B3782494 R . X D . byte 00 public CODE 32 00 01
        - B3782554
    - libJniCalculateSO.so B3783AA4 B3784000 R . X D . byte 00 public CODE 32 00 01
        - B3783FF8
2. OK成功运行预期逻辑看到传入的值。
3. 在General registers中右击 modify value修改寄存器的值，
4. Debugger continue process 就看到了我们想要的结果。
