break 能跳出 for 循环。
它的边界在什么地方呢？


```java
private void test(){

    int i = 1;
    {
        break;
        i = 2;
    }

    System.out.println(""+i);

}
```

上面程序的输出是什么？


----



使用 break 作为 Goto 的一种形式

Java 没有 goto 语句，因为它提供了一种以任意和非结构化方式进行分支的方法。Java 使用标签。标签用于标识代码块。 
句法： 

```java
label:
{
  statement1;
  statement2;
  statement3;
  .
  .
}
```

现在，可以使用 break 语句跳出目标块。 

注意：您不能中断任何未为封闭块定义的标签。 

语法 
```java
break label;
```


## 参考 
- https://www.geeksforgeeks.org/break-statement-in-java/