## 一、 JNI 是什么
JNI是Java Native Interface的缩写，它提供了若干的API实现了Java和其他语言的通信（主要是C&C++）。

## 二、 JNI 的使用方式
要晚成 JNI 的使用需要完成对接，以 Java 和 C/C++ 为例，需要做下面的事情：
1. 使用 Java 语法创建 native 方法。
2. 根据使用 Java 语法创建的 native 方法们，逐一使用 C/++ 语法创建其对应的方法。
3. 建立 Java 方法和 C/C++ 方法的一个映射
    - 当建立了这个映射关系就可以达到在调用 native 方法的时候唤起 C/C++ 方法。

上述 3 个步骤有两种做法可以完成(不考虑优劣，只做知晓)：
- 看 Reference 吧，没有自己的理解，都是吸收，已经理解了迫不及待去看理解对我来讲更重要的事情了，当这些理解不够用的时候回来继续写。


## Reference 
1. [JNI两种注册过程实战](https://blog.csdn.net/xsf50717/article/details/54693802)
2. [JNI中C调用Java方法](https://www.cnblogs.com/xitang/p/4174619.html)
3. [初识JNI（二）-静态注册和动态注册](https://blog.csdn.net/u014623470/article/details/49662995)