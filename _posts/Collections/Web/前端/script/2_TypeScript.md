


参考内容
- https://www.typescriptlang.org/docs/handbook/typescript-from-scratch.html
- https://www.typescriptlang.org/docs/handbook/intro.html
- 发现一本电子书 还没看 : https://github.com/jkchao/typescript-book-chinese



要理解 TypeScript , 必须先了解 JavaScript . 
TypeScript 是依赖于 JavaScript 存在的 . 
失去了 JavaScript , TypeScript 是无意义的存在 . 


## 0x01 JavaScript 由来/现状

- JavaScript 最开始出现是用于嵌入 HTML 网页里的简短代码(脚本) . 编写几十行以上的代码有点不寻常。
- 那时候 浏览器执行此类代码的效率 与现在比也是很低的 . 
- 后来在 web 网页的交互中使用越来越多的 JS 代码 , JavaScript 流行度逐渐提高 . 
- 这促使 浏览器 优化自身执行 JS 的效率的提高 . 
   - Web 浏览器开发人员通过优化执行引擎（动态编译）并扩展其功能（添加 API）来应对 JS 使用量的增加
- 这两件事互为因果循环促进
- 现在已经有人仅用 JS 编写整个前后端 . 


每种语言都有自己的特点/怪癖(优点/缺点,见仁见智)

web 浏览器 允许这种可以正常运行的 JS 代码
```TypeScript
if ("" == 0) {
  // It is! But why??
  console.log("one");                           // one   
}
if (1 < 'x' < 3) {
  // True for *any* value of x!
  console.log("two");                           // two   

  if (1 < 0 < 3) console.log("number");         // number                     
  if (1 < true < 3) console.log("boolean");     // boolean                         
  if (1 < "string" < 3) console.log("string");  // string                            
}

/* ------------------ */

const obj = { width: 10, height: 15 };  /* hight */
// Why is this NaN? Spelling is hard!
const area = obj.width * obj.heigth;    /* heigth JavaScript 还允许访问不存在的属性 */
console.log(area)                       // NaN
```

当发生此类错误时，大多数编程语言都会抛出错误，有些语言会在编译期间（在任何代码运行之前）抛出错误。
- 在编写小程序(代码量少)时，这种怪癖很烦人，但可以管理；
- 当编写具有数百或数千行代码的应用程序时，这些不断出现的意外是一个严重的问题。




## 0x02 TypeScript：静态类型检查器

回到上述两个简短的程序示例 , JS 代码被 TS 进行静态检查的情况下(注意 err tip) : 
```TypeScript
if ("" == 0) { 
  /* err tip : 
  TS2367: This comparison appears to be unintentional because the types  string  and  number  have no overlap. */
  // It is! But why??
  console.log("one");                           // one   
}
if (1 < 'x' < 3) {
  /* err tip
    TS2365: Operator  <  cannot be applied to types  number  and  string 
    TS2365: Operator  <  cannot be applied to types  boolean  and  number 
  */
  // True for *any* value of x!
  console.log("two");                           // two                       
}

/* ------------------ */

const obj = { width: 10, height: 15 };  /* hight */
// Why is this NaN? Spelling is hard!
const area = obj.width * obj.heigth;    /* heigth JavaScript 还允许访问不存在的属性 */
/* err tip
TS2551: Property  heigth  does not exist on type  { width: number; height: number; } . Did you mean  height ?
1_Test.tsx(26, 26):  height  is declared here.
*/
console.log(area)                       // NaN
```

- TS 做了什么 : 它尝试在 JS 运行前对 JS 进行某些符合主流观点的"规范" , 从而达到尽可能避免意外的目的 . 
- TS 在什么情况下工作 : 
   - 在 JS 真正执行前工作 , 检查 JS 中可能有意外的代码 . 
   - TS 是 JS 的超集 , 那些符合 TS 语法不符合 JS 语法的代码 , 在预处理阶段被 TS 预处理器整理为 JS 代码 . 
   - 最终交给浏览器解释执行的只有 JS 代码
- TS 的工作内容
   - TS 不会改变任何 JS 代码 . 只是尝试做出 TS自以为是的 异常提示 . 
      - TS 预处理器 , 可以被设置为 , 
          - 容忍任何异常(仅提醒不做其他干预) , 无论存在任何它认定的异常 , 都不会视为预处理通过 . 
          - 不容忍异常 , TS 认定存在异常的代码 , 拒绝转换为 JS , 并返回预处理失败 . 
            - `tsc --noEmitOnError hello.ts`

- TypeScript永远不会改变 JavaScript 代码的运行时行为。
   - 如果将代码从 JavaScript 移动到 TypeScript，即使 TypeScript 认为代码存在类型错误，也保证以相同的方式运行。


## 0x03 显式 类型

请记住，我们并不总是需要编写显式类型注释。在许多情况下，TypeScript 甚至可以为我们推断（或“找出”）类型，即使我们忽略它们。
- 当类型系统最终推断出相同的类型时，最好不要添加注释。
- **请记住：类型注释永远不会改变程序的运行时行为。**

## 0x04 TS 在项目中的 工作细节配置
`tsconfig.json` 定义这些配置细节
- https://www.typescriptlang.org/docs/handbook/tsconfig-json.html
- https://www.typescriptlang.org/docs/handbook/2/basic-types.html#strictness


## 0x05 常见类型

JS 中三种常见的类型为 `string` , `number` , `boolean` . 在 TS 中 , 这三个也是相应的类型名
- 类型名称String、Number和Boolean（以大写字母开头）是合法的，但指的是一些很少出现在代码中的特殊内置类型。
  始终使用string, number, 或boolean来表示类型。

数组
- `number[]`  数字数组
- `string[]`  字符串数组
- 也可以用 `Array<number>` , 暂不展开

any , 当你早某些情况下 , 不希望 TS 对相关语句进行类型检查的时候使用它 
```TypeScript
let obj: any = { x: 0 };
// None of the following lines of code will throw compiler errors.
// Using `any` disables all further type checking, and it is assumed 
// you know the environment better than TypeScript.
obj.foo();
obj();
obj.bar = 100;
obj = "hello";
const n: number = obj;
```

当您不指定类型，并且 TypeScript 无法从上下文推断它时，编译器通常会默认为any.

不过，您通常希望避免这种情况，因为any没有进行类型检查。使用编译器标志noImplicitAny将任何隐式标记any为错误。


## 0x06 关于基本类型变量 [缩小范围](https://www.typescriptlang.org/docs/handbook/2/narrowing.html)

JS 语言 , 弱类型语言 , 者在许多情况下 , 需要了解程序的上下文才能准确判断 对象/变量 类型 . 

当对象类型范围缩小时 , 我们就可以即时了解对象类型 . 

TS 还会在类型缩小的时候 , 了解到我们的类型是否符合当前语境 , 不符合的会给出提醒 . 


## 0x07 关于[函数](https://www.typescriptlang.org/docs/handbook/2/functions.html)
暂停点 : https://www.typescriptlang.org/docs/handbook/2/functions.html#constraints

- 规则：如果类型参数仅出现在一个位置，请强烈重新考虑是否确实需要它
- 规则：为回调编写函数类型时，切勿编写可选​​参数，除非您打算在不传递该参数的情况下调用该函数
- 如果可能的话，总是更喜欢带有联合类型的参数而不是重载
- 要在函数中使用 this  , 应该使用 function 而不是箭头函数
- void 不等同于 undefined.
- object 不是 Object。 一直用 object ！


## 0x07 关于 [对象](https://www.typescriptlang.org/docs/handbook/2/objects.html)

- 使用映射修饰符，您可以删除readonly属性。
- 扩展类型 : `interface` 允许我们通过扩展(`extends`)其他类型来构建新类型。
- 交叉类型
   ```TypeScript
    interface Colorful {
      color: string;
    }
    interface Circle {
      radius: number;
    }
    
    type ColorfulCircle = Colorful & Circle;
   ```

## 0x08 类型操作

### 8.1 [泛型](https://www.typescriptlang.org/docs/handbook/2/generics.html)

几种合法的泛型写法 , 包含泛型函数 与 泛型对象
```TypeScript
function identity<Type>(arg: Type): Type {
  return arg;
}
 
let myIdentity: <Type>(arg: Type) => Type = identity;

/* ****************************************************** */

function identity<Type>(arg: Type): Type {
  return arg;
}
 
let myIdentity: { <Type>(arg: Type): Type } = identity;

/* ****************************************************** */

interface GenericIdentityFn {
  <Type>(arg: Type): Type;
}
 
function identity<Type>(arg: Type): Type {
  return arg;
}
 
let myIdentity: GenericIdentityFn = identity;

/* ****************************************************** */

interface GenericIdentityFn<Type> {
  (arg: Type): Type;
}
 
function identity<Type>(arg: Type): Type {
  return arg;
}
 
let myIdentity: GenericIdentityFn<number> = identity;
```


类的类型有两个方面：静态方面和实例方面。泛型类仅在其实例端而不是其静态端是通用的，因此在使用类时，静态成员不能使用类的类型参数。

暂停点 `索引访问类型` : https://www.typescriptlang.org/docs/handbook/2/indexed-access-types.html

## 0x09. async/await/Promise/Web Workers
概念理解


## 关于 kotlin 的题外话 

在写 TypeScript 的时候 , 总是会怀念 Kotlin 语法糖 , 真甜呀 . 
1. Kotlin 也可以用于 前端 开发 , 只是流行度不高 : https://kotlinlang.org/docs/js-overview.html
   - 基于此 , 我们的项目要采用这种方式吗 ? 暂时不要 , 后续有精力的时候可以尝试 . 