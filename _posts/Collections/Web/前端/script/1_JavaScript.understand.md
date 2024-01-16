参考内容
1. [JavaScript MDN 教程](https://developer.mozilla.org/zh-CN/docs/Learn/Getting_started_with_the_web/JavaScript_basics)
2. [TypeScript 教程](https://www.typescriptlang.org/docs/handbook/intro.html)
3. 这个 也是不错的 : https://zh.javascript.info


https://developer.mozilla.org/zh-CN/docs/Learn/Getting_started_with_the_web/JavaScript_basics

## 0x01. [创建变量 var / let 理解](https://developer.mozilla.org/zh-CN/docs/Learn/JavaScript/First_steps/Variables#var_与_let_的区别)

- 在 JavaScript 的历史上只有 `var` 这一个创建变量的方式 . 
- 由于 `var` 存在已知的缺点 `let` 被引入了 . 

- 对于 `var` 来说 JavaScript 变量可以先定义后声明 : 
  ```JavaScript
  myName = "Chris";

  function logName() {
    console.log(myName);
  }

  logName();

  var myName;
  ``` 
  这种现象叫做 `提升` , 如果上述代码中的 var 换成 let 代码将不再生效 . 
  
  这是一件好事——因为初始化后再声明一个变量会使代码变得混乱和难以理解。


- 对于 `var` 来说 , 同名变量可以多次声明
  ```JavaScript
  var myName = "Chris";
  var myName = "Bob";
  ```
  对于 `let` 上述不成立 , 你必须这样做 :
  ```JavaScript
  let myName = "Chris";
  myName = "Bob";
  ```
  同样，这是一个明智的语言决定。没有理由重新声明变量——这只会让事情变得更加混乱。

### 1.1 const
const : 常量是块级范围的，非常类似用 let 语句定义的变量。但常量的值是无法（通过重新赋值）改变的，也不能被重新声明。




## 0x02. 变量类型

- 与其他语言不通 , JavaScript 中你不需要声明变量的类型 . 
  - JavaScript 是 动态类型语言 ; 
  - C / Java 是静态类型语言 ; 
  - 还没有得到一个足够简明的答案 , 所以先不说两种类型语言的差别了 . 
  - 作为动态类型语言可以为变量赋予不同类型的值 , 这是 静态类型语言 通常做不到的
    ```JavaScript
    let flag = 500;
    let flagType = typeof flag;
    console.log(flagType)     /* number */
    flag = "500";
    flagType = typeof flag;
    console.log(flagType)     /* string */
    ```

- JavaScript 具有以下几种类型的变量 
  - Number : `123` / `123.123`
  - Boolean : `true` / `false`
  - String : `"string value one"` / `'string value two'`
  - Array : `[1,2,3]` / ["one","two","three"]
  - Object : `{ name: "Spot", breed: "Dalmatian" }`  _我们常用的 json_


## 0x03. 异步操作

### Promise 理解 : 
- https://developer.mozilla.org/zh-CN/docs/Web/JavaScript/Reference/Global_Objects/Promise
- https://developer.mozilla.org/zh-CN/docs/Web/JavaScript/Guide/Using_promises
- https://zh.javascript.info/promise-api

```TypeScript
// Promise 对象表示异步操作最终的完成（或失败）以及其结果值。
// Promise 的几种状态
// Promise 只是整合了事件的触发流程 , 执行代码所在的线程和 调用者处于相同线程 , 耗时任务还是应该配合 Worker 共同完成



                   ┌─────────────┐
                   │             │
          ┌────────►   pending   │ 待定（pending）：初始状态，既没有被兑现，也没有被拒绝。
          │        │             │
          │        └─────────────┘
   ┌──────┴────┐
   │           │
   │  Promise  │                             ┌───────────┐
   │           │           ┌────────────────►│ fulfilled │已兑现（fulfilled）：意味着操作成功完成。
   └──────┬────┘           │                 └───────────┘
          │         ┌──────┴──────┐
          │         │             │ 已敲定（settled）& 已解决（resolved） 含义相同
          └────────►│   settled   │ 已经被兑现或拒绝，即不再处于待定状态，那么则称之为已敲定（settled）。
                    │             │ 已解决（resolved）这个术语来描述 Promise——这意味着该 Promise 已经敲定
                    └──────┬──────┘
                           │                 ┌──────────┐
                           └────────────────►│ rejected │已拒绝（rejected）：意味着操作失败。
                                             └──────────┘
```




### await 理解 : 
- https://developer.mozilla.org/zh-CN/docs/Web/JavaScript/Reference/Operators/await
- https://developer.mozilla.org/zh-CN/docs/Web/JavaScript/Reference/Statements/async_function
- https://developer.mozilla.org/zh-CN/docs/Web/JavaScript/Reference/Statements/async_function*
- https://zh.javascript.info/async-await
  - async 确保了函数返回一个 promise，也会将非 promise 的值包装进去。
  - 关键字 await 让 JavaScript 引擎等待直到 promise 完成（settle）并返回结果。
     - 只能在 async 函数中 使用 await
  - 如果一个 promise 正常 resolve，await promise 返回的就是其结果。
    但是如果 promise 被 reject，它将 throw 这个 error，就像在这一行有一个 throw 语句那样。 





### WebWorker 
1. https://zh.javascript.info/event-loop
2. https://developer.mozilla.org/zh-CN/docs/Web/API/Web_Workers_API
   - Web Worker 使得在一个独立于 Web 应用程序主执行线程的后台线程中运行脚本操作成为可能。
     这样做的好处是可以在独立线程中执行费时的处理任务，使主线程（通常是 UI 线程）的运行不会被阻塞/放慢。


## 0x04. 事件冒泡




45
15

80

30
20
1.5
































## 动态类型语言 VS 静态类型语言
