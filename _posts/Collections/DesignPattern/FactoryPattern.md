工厂模式： 定义了一个创建对象的接口，但是有子类决定要实例化的类是哪一个。工厂方法让类把实例化推迟到子类。

## 0x00、 假设你有一个披萨店

身为店主人你的代码可能这么写：

```java
Pizza orderPizza(){
    Pizza pizza = new Pizza();

    pizza.prepare();
    pizza.bake();
    pizza.cut();
    pizza.box();
    
    return pizza;
}
```

## 0x01、 但是你需要更多种类的披萨
于是代码可能编程下面的样式：

```java
Pizza orderPizza(String type){//现在需要传入披萨类型
    Pizza pizza = null;

    switch(type){//根据具体的披萨种类实例化不同的对象
        case "cheese":
            pizza = new CheesePizza();
            break;
        case "greek":
            pizza = new GreekPizza();
            break;
        case "pepperoni":
            pizza = new PepperoniPizza();
            break;
    }

    //从上面拿到的披萨对象进行处理
    pizza.prepare();//预处理
    pizza.bake();   //烘烤
    pizza.cut();    //切片
    pizza.box();    //打包
    
    return pizza;
}
```

## 0x02、 压力来自于不断变化的披萨类型
由于竞争和实践因素不可避免的要增加或减少披萨类型：

```java
Pizza orderPizza(String type){//现在需要传入披萨类型
    Pizza pizza = null;

    switch(type){//根据具体的披萨种类实例化不同的对象
        case "cheese":
            pizza = new CheesePizza();
            break;
        // 希腊披萨经过实践北市场淘汰
        // case "greek":
        //     pizza = new GreekPizza();
        //     break;
        case "pepperoni":
            pizza = new PepperoniPizza();
            break;
        //过去其他店面有我们没有的披萨类型下载增加上
        case "clam":
            pizza = new ClamPizza();
            break;
        case "veggie":
            pizza = new VeggiePizza();
            break;
    }

    //从上面拿到的披萨对象进行处理
    pizza.prepare();//预处理
    pizza.bake();   //烘烤
    pizza.cut();    //切片
    pizza.box();    //打包
    
    return pizza;
}
```

这时候我们遵从`开闭原则`分离分离源代码中会发生变化的部分，保证 `orderPizza()` 方法对修改关闭：

```java
/*新建一个类单独用来创建披萨*/
public class SimplePizzaFactory{
    public Pizza createPizza(String type){
        Pizza pizza = null;
        switch(type){//根据具体的披萨种类实例化不同的对象
            case "cheese":
                pizza = new CheesePizza();
                break;
            // 希腊披萨经过实践北市场淘汰
            // case "greek":
            //     pizza = new GreekPizza();
            //     break;
            case "pepperoni":
                pizza = new PepperoniPizza();
                break;
            //过去其他店面有我们没有的披萨类型下载增加上
            case "clam":
                pizza = new ClamPizza();
                break;
            case "veggie":
                pizza = new VeggiePizza();
                break;
        }
        return pizza;
    }
}

/*重写客户端代码*/
public class PizzaStore{
    SimplePizzaFactory factory;

    public PizzaStore(SimplePizzaFactory factory){
        this.factory = factroy;
    }

    Pizza orderPizza(String type){//现在需要传入披萨类型
        Pizza pizza = factory.createPizza(type);

        //从上面拿到的披萨对象进行处理
        pizza.prepare();//预处理
        pizza.bake();   //烘烤
        pizza.cut();    //切片
        pizza.box();    //打包
        
        return pizza;
    }
}
```

上面这段代码就称得上是简单工厂了
>简单工厂更多的被认为是一种编程习惯而不是设计模式。常有人将之误认为是工厂模式。

## 0x03、 现在如果要开分店的话
最直观的做法是将 `PizzaStore` 系统在每个点都部署一次。这时候有可能碰到的问题就是：
1. 各个地区的店面需要根据地区偏好制造他们的独特风味的披萨。
    ```java
    //纽约的店面
    NYPizzaFactory nyFactory = new NYPizzaFactory();
    PizzaStore nyStore = new PizzaStore(nyFactory);
    nyStore.orderPizza("Veggie");
    //芝加哥约的店面
    ChicagoPizzaFactory chicagoFactory = new ChicagoPizzaFactory();
    PizzaStore chicagoStore = new PizzaStore(chicagoFactory);
    chicagoStore.orderPizza("Veggie");
    ```
    - 为各个店面分发不同 Factory 的同时也将其他的制作流程同时分发给他们了。
2. 其他制作流程的分发是不必要的。因为这本是可复用的内容，我们不希望这发生改变。

现在我们知道我们希望子类能控制的是披萨的口味偏好，并且其他的工业流程我们希望各个店面和总部始终保持一致：

```java
public abstract class PizzaStore{//将本类修改为抽象类
    public abstract Pizza createPizza(String type);//将工厂代码段(switch-case)移入这个抽象方法，交由分店处理从而可以实现不同风味

    final Pizza orderPizza(String type){//现在需要传入披萨类型
        Pizza pizza = createPizza(type);

        //从上面拿到的披萨对象进行处理
        pizza.prepare();//预处理
        pizza.bake();   //烘烤
        pizza.cut();    //切片
        pizza.box();    //打包
        
        return pizza;
    }
}
```

至此，不同地区的分店来继承 `PizzaStore` 并且在制作 Pizza 的时候继承由总店维护的 Pizza 类从而定制他们的独特风味并与 自己的 PizzaStore 结合使用就解决了工业流程错乱的问题。