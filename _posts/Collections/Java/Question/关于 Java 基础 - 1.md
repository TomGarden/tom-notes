---
layout: post
title:  null
date:   2018-10-19 16:43:51 +0800
categories: jekyll update
author: Tom
---

-----------------------------
__目录__
- jekyll 的 kmarkdown 负责解析
{:toc}

-----------------------------
<br>

```java

public abstract class GrantF {
    public abstract void hello();
}


public abstract class Father extends GrantF {
    public Father() {
        System.out.println("Father init");

        Object object = this;

        if (object instanceof Father) {
            System.out.println("object instanceof Father");
        } else if (object instanceof Son) {
            System.out.println("object instanceof Son");
        } else {
            System.out.println("************");
        }

        System.out.println("Father init Over");
    }


    public Father getFather() {
        return this;
    }
}


public class Son extends Father {
    public Son() {
        //默认调用 super();
        System.out.println("Son init");
        System.out.println("Son init Over");
    }

    @Override
    public void hello() {
        System.out.println("hello");
    }

    public void get() {
        super.getFather().hello();
    }

    public static void main(String[] args) {
        new Son().get();
    }
}
```

上述代码的输出内容为:
```
Father init
object instanceof Father
Father init Over
Son init
Son init Over
hello
```

我是觉得这个 hello 的打印略有蹊跷。
不知道了解 Java 那块知识能解决这种小疑惑。