## for & while 异同
本题来源于 《C++ primer》 中文(第五版)

1. 从两者的含义来说，完全相同。
2. 从执行效率来说，完全相同。
    - 因为在编译之后都是通过 `"goto X"` 来完成跳转的。
3. 使用场景略有不同
    - for 多用于已知循环次数的场景。
    - while 多用于未知循环次数的场景

4. for 可以更方便的做到缩小变量范围。
    - 这一点 wihle 恐怕不行，我们在 while 开始之前声明 `index` 变量，在 while 结束之后，该变量还存在与内存中。


## 参考 & 摘录
1. [程序语言中for循环和while循环的深层区别是什么？](https://www.zhihu.com/question/20417091?from=profile_question_card)