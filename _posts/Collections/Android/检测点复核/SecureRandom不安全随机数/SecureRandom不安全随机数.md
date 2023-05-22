## 一、 漏洞原理

## 二、 风险
随机数可预测

## 三、 影响范围
[1,16]

## 四、检测手段
1. SecureRandom.SecureRandom(byte[] seed)，使用该构造函数初始化 风险
2. 使用下述代码风险
    ```java
    //方式一：
    SecureRandom.SecureRandom()
    SecureRandom.setSeed(long seed)
    //方式二
    SecureRandom.SecureRandom()
    SecureRandom.setSeed(byte[] seed)
    ```

## 五、 修复建议
1. 如果一定要兼容 Android[1,16] 为了确保随机数的随机性请不要使用下述代码
    ```java
    SecureRandom.setSeed(long seed)
    //或
    SecureRandom.setSeed(byte[] seed)
    ```
    如果一定要使用上述代码在调用之前请先调用下述方法
    ```java
    SecureRandom.nextXXX
    ```
2. 在api16及之前版本禁止直接调用带参数的构造方法产生SecureRandom实例