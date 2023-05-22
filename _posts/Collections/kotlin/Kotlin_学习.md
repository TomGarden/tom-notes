

## 目的
搞清楚 作为函数引用 的 变量 如何 配合 Parcel 完成 缓存操作 的 写入和读取



- java / kotlin / C / C++ / ··· 编译器 
- 对于有些追根究底的问题的答案可以简单的认为说这是编译器的规范 , 某种写法之所以这么写 , 因为人认识具有恰当的可读性 , 
  也因为编译器可以编译通过 , 允许这种写法的存在 , 所以就这么写了 . 


lambda 表达式 作为成员引用的时候某些概念好像被换了


Kotlin 实战 第五章 输入完毕, 暂未解决问题



## 着手实施并获取结果
1. 针对集合内容的库函数操作的完整列表应该到哪里获取
    - 就集合内容而言 , 这些库函数可以在 [文档](https://kotlinlang.org/docs/reference/collections-overview.html) 中找到


## 后延内容

"扩展" : 成员扩展

最近在学些 Parcelable 相关的内容 , 恰好自己关注的公众号就推送了相关文章 , 虽然对自己的学习没有帮助 , 但是真的不能详细是巧合 , [做个记录-郭霖](https://mp.weixin.qq.com/s/NNClO9YmkPQMumzqsgnOgg)
- [推送的原文](https://juejin.im/post/6854573218334769166)

## 参考
1. [Kotlin 实战](https://gitee.com/lxqxsyu/ShareFile/tree/master)
2. [Google 检索结果](https://www.google.com/search?newwindow=1&sxsrf=ALeKk02DnAV6CSWWGCWkyOqqQd30TcL-Fg%3A1596605766715&ei=RkUqX8-XK9LY-gSX-K7AAQ&q=kotlin+lambda+parcelable&oq=lambda+Parcelable&gs_lcp=CgZwc3ktYWIQAxgAMgYIABAWEB46BQgAEJECOggILhCxAxCDAToECAAQAzoLCC4QsQMQxwEQowI6AgguOgUIABCxAzoICC4QxwEQowI6BAgAEEM6BAguEEM6CAgAELEDEIMBOgcILhANEJMCOgQILhANOgQIABANOgcIIxDqAhAnOgcIABCxAxBDOgcILhCxAxBDOgUILhCxAzoICAAQsQMQkQI6AggAOggIABAWEAoQHlD0jaUCWJj6pQJguJOmAmgEcAB4AIAB1QaIAdA5kgEKMi03LjExLjYtMpgBAKABAaoBB2d3cy13aXqwAQrAAQE&sclient=psy-ab)
    - https://stackoverflow.com/questions/53363745/is-it-possible-to-pass-lambda-to-intent
    - https://stackoverflow.com/questions/48862416/notserializableexception-when-pass-kotlin-function-in-bundle-on-saving-instance/48870902#48870902