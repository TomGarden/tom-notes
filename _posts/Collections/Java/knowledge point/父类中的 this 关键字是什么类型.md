## 父类中的 this 关键字是什么类型？

```java
public class Father {
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
}

public class Son extends Father {
    public Son() {
        //默认调用 super();
        System.out.println("Son init");
        System.out.println("Son init Over");
    }

    public static void main(String[] args) {
        new Son();
    }
}
```

输出：
```log
Father init
object instanceof Father
Father init Over
Son init
Son init Over
```