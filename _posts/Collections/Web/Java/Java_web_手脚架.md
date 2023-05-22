

## 零. 参考内容
1. https://www.liaoxuefeng.com/wiki/1252599548343744/1304265903570978
   - [Spring Framework](https://www.liaoxuefeng.com/wiki/1252599548343744/1266263217140032)
2. https://docs.oracle.com/javaee/6/tutorial/doc/bnadu.html
3. https://developer.mozilla.org/zh-CN/docs/Web/HTTP/Overview
4. https://zh.wikipedia.org/wiki/超文本传输协议
5. http://c.biancheng.net/springcloud/
6. https://docs.spring.io/spring-boot/docs/1.1.0.M1/reference/html/
7. [Spring 手册](https://docs.spring.io/spring-framework/docs/current/reference/html/)
   - 中文手册 : https://jaylinh-com.github.io/spring-framework-chinese/
8. https://docs.oracle.com/javase/8/docs/technotes/guides/jdbc/


## 一. 服务端/客户端
```java
/* TCP/IP（Transmission Control Protocol / Internet Protocol） 协议的基础上我们尝试让两个设备建立连接 */

1. Server 开放并监听特定端口 , 假设端口为 80 ; 同时假设 Server ip 地址是被客户端知晓的 ;
    - 略去 Domain Name System(DNS) 概念
2. Client 通过 ip:port 就可以 和 Server 连接并通信(交换信息)了 . 
3. HTTP 协议是基于 TPC/IP 协议的更上层的协议 ; 
   它可以规范化 Socket 通信的过程 , 让 Socket 通信按照固定的格式进行信息交流 . 
   有了规范就可以有更多的合作和兼容 . 
4. 朴素的考虑当前的情况
   - 我们通过 Socket 建立 C/S 之间的链接 , 在他们之间传输的字符遵循 HTTP 标准 . 
   - Server 监听本地开放端口是否有连接请求的需求是常规重复操作 ; 
      - cgi 是一种解决方案 . 它把这种常规操作封装成了轮子 . 
      - Tomcat 也是一种解决方案 . 
   - Server 在接收 Client 信息的时候 , 将文本解析为特定的对象是一个常规的重复操作 ; 
     Server 在向 Client 反馈信息的时候 , 将特定对象序列化为符合 HTTP 标准的 字符串 也是常规重复操作 ; 
      - Servlet 是一种解决方案
   - 就 Java EE 而言 , 用于 WEB 开发还有两个常用概念  Filter, Listener
      - 实际上也是对常用操作的封装 , 不详细深入了

```

## 二. Spring Framework

> 控制反转 Inversion of Control(IoC) 又称为依赖注入（DI：Dependency Injection）

多个对象在需要初始化时候依赖其他对象的初始化使得初始化动作变得复杂 , 依赖项的释放也变的复杂 . 

IoC 让对象初始化只关注自身 , 依赖项的初始化和销毁细节交给框架管理 . 

> 有关于此 , 我想到的是单例 . 

听说 Spring 也是通过注解创建了单例 , 不过针对各种不同情况都有考虑和处理 ; 这样的话使用起来应该也是会方便许多的 . 


### 2.1. Spring 加载 配置文件 `application.properties`/`application.yml`

在配置数据库密码这样的私密字段的时候 , 想要完成加密动作 : 
1. jasypt : 按照它的规则做
2. BeanFactoryPostProcessor : 将密文保存在本地文件内 , 生成 environment 时候用本地值替换占位符
3. 使用 yml `spring.config.import` 导入本地 yml 使用本地变量
   ```yml

   # 文件名 : application.local.yml , 本文件在 .gitignore 列表中 , 系本地文件
   local:
      spring:
         datasource:
            url: jdbc:mysql://host:port/db_name
            username: name
            password: pwd
      server:
         port: 8082

   # 文件名 application.yml
   server:
     port: ${local.server.port}

   spring:
      config:
         import: optional:application.local.yml
      datasource:
         url: ${local.spring.datasource.url}
         username: ${local.spring.datasource.username}
         password: ${local.spring.datasource.password}
         driver-class-name: com.mysql.cj.jdbc.Driver

   ```
- 参考 : https://blog.csdn.net/yucaifu1989/article/details/124199659
   - https://juejin.cn/post/7208722414598258746


BeanFactoryPostProcessor 理解 : postProcessBeanFactory 执行的时候 , bean 们的定义已经被加载了
但是 Bean 们尚未完成实例化 . 

BeanFactoryPostProcessor 的使用细节

```kotlin
class CustomBeanFactoryPostProcessor : BeanFactoryPostProcessor {
    override fun postProcessBeanFactory(beanFactory: ConfigurableListableBeanFactory) {
        println("CustomBeanFactoryPostProcessor  : ${beanFactory.tempClassLoader?.name?.let { "unknow class loader" }}")

        /* 即使到达这里暂时也不知道如何对 Environment 进行修改 */
    }
}

// 自定义了 `BeanFactoryPostProcessor` 需要作为 bean 才能被框架调用

@Configuration /* 替代 配置文件 */
class AppConfiguration {
    companion object { /* 伴生对象 ; kotlin 类内静态函数 */
        @Bean
        fun customBeanFactoryPostProcessor(): BeanFactoryPostProcessor {
            return CustomBeanFactoryPostProcessor()
        }
    }
}
```









