## 写在开始
我们使用这些工具，这是面向对象的思维，面向对象总是让人觉得事情很简单，因此人们喜欢用这种思维处理问题。要知道真正可怕的是你发现自己就是那个对象。

作为一个对象，尤其是这种低级对象，我们能做的只能是面向过程。

但是我们还是会尽量使用面向对象的思维来划归自己所面向的过程的实际模块。

学习一个新东西我们需要以下内容：
1. 学习目标的第一手(最官方)的资料在哪里，是什么？
    - 当我们觉得所有的内容都是不可信(不能解决我们的疑惑的时候)的时候可以去这里寻找答案
2. 我们如何认知和掌握上述资料？
    - 我们掌握的是初级技能的运用，以及碰到高级问题如何解决的方法。

废话有点多，正文开始啦。

## 一、sqlmap identified the following injection point(s) with a total of 211 HTTP(s) requests:
---
Parameter: id (GET)
    Type: boolean-based blind
    Title: OR boolean-based blind - WHERE or HAVING clause (MySQL comment) (NOT)
    Payload: id=1' OR NOT 5726=5726#&Submit=Submit
·····
---
- type ： ~/sqlmap/xml/type
- title ： ~/sqlmap/xml/type/title 节点
- payload ：~/sqlmap/xml/type/title 节点/payload 子节点
