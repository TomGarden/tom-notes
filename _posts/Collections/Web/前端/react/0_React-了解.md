





JSX : https://legacy.reactjs.org/docs/introducing-jsx.html


[React 发展了](https://zh-hans.react.dev/blog/2023/03/16/introducing-react-dev)(2023-07-26 06:42:00写下文本)
- 新域名 : react.dev ; reactjs.org 会重定向到 react.dev
- 旧网站迁移到域名 : legacy.reactjs.org

React 入门
1. 旧版本文档 : https://legacy.reactjs.org/docs/getting-started.html
2. 新版本文档 : https://react.dev/learn
   - 中文版 : https://zh-hans.react.dev/learn
3. [Create React App 文档 也蛮重要的](https://create-react-app.dev/docs/documentation-intro/)




React 中的 key 是什么
```JSX

/* 目前就只能理解为 React 需要我们这么做 : https://zh-hans.react.dev/learn#rendering-lists */

const pageAry = Array.of('Products', 'Pricing', 'Blog');

{
    pageAry.map(page => (
            <Button
                key={page}
                onClick={handleCloseNavMenu}
                sx={{my: 2, color: 'white', display: 'block'}}
            >
                {page}
            </Button>
        )
    )
}
```


[Reack 中在某个 element 的点击事件触发带有参数的函数怎么写](https://timmousk.com/blog/react-onclick-pass-parameter/)
```javaScript
import React from "react";
import ReactDOM from "react-dom";

const App = () => {

  /* 方式一 , 让函数 返回一个函数 */
  const handleClick = (str) => () => {
    console.log(str);
  };

  return (
    <button onClick={handleClick("apply clicked")}>
      apply
    </button>
  );
};

ReactDOM.render(<App />, document.getElementById("container"));
```

```JavaScript
import React from "react";
import ReactDOM from "react-dom";

const App = () => {
  const handleClick = (str) => {
    console.log(str);
  };

  return (
    /* 方式 二 : 内联函数调用另一个函数并传参 */
    <button onClick={() => handleClick("apply clicked")}>
      apply
    </button>
  );
};

ReactDOM.render(<App />, document.getElementById("container"));
```

```JavaScript
import React from "react";
import ReactDOM from "react-dom";

const App = () => {
  const handleClick = (e) => {
    console.log(e.currentTarget.getAttribute("data-value"));
  };

  return (
    /* 方式三 : 添加自定义数据 , 在 Js 默认参数中获取自定义数据 , 更推荐 一/二 */
    <button data-value="apply clicked" onClick={handleClick}>
      apply
    </button>
  );
};

ReactDOM.render(<App />, document.getElementById("container"));
```




## 0x02. React Hook

可以帮助我们将数据与 UI 绑定 , 当我们更新数据时 , UI 自动同步更新 . 

> Hooks ——以 use 开头的函数——只能在组件或自定义 Hook 的最顶层调用。 
> 你不能在条件语句、循环语句或其他嵌套函数内调用 Hook。Hook 是函数，但将它们视为关于组件需求的无条件声明会很有帮助。
> 在组件顶部 “use” React 特性，类似于在文件顶部“导入”模块。

1. 当你调用 useState 时，你是在告诉 React 你想让这个组件记住一些东
2. [state 如同一张快照](https://zh-hans.react.dev/learn/state-as-a-snapshot)
3. 对象含有子对象的时候由于快照的背景逻辑 , 应该拷贝对象进行复制 , 然后替换元对象 . 
   - 浅拷贝可以一定程度上让事情变的简单 , 非嵌套对象适用
   - [Immer 可以让事情变的简洁些](https://zh-hans.react.dev/learn/updating-objects-in-state#write-concise-update-logic-with-immer)
   - 使用 Immer 更行数组同样会简洁些 , 数组也是一种对象
4. 所有 Hook 函数 列表 : https://zh-hans.react.dev/reference/react
   - useState
     - 当组件需要在渲染之间“记住”某些信息时，请使用状态变量。
     - 状态变量是通过调用useStateHook 来声明的。
     - HookuseState返回一对值：当前状态和更新它的函数。
   - useEffect
     - 与事件不同，效果是由渲染本身而不是特定的交互引起的。
     - 默认情况下，效果在每次渲染（包括初始渲染）后运行。
     - 如果 Effect 的所有依赖项都具有与上次渲染期间相同的值，React 将跳过 Effect。
