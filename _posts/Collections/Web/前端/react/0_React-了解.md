





JSX : https://legacy.reactjs.org/docs/introducing-jsx.html


[React 发展了](https://zh-hans.react.dev/blog/2023/03/16/introducing-react-dev)(2023-07-26 06:42:00写下文本)
- 新域名 : react.dev ; reactjs.org 会重定向到 react.dev
- 旧网站迁移到域名 : legacy.reactjs.org

React 入门
1. 旧版本文档 : https://legacy.reactjs.org/docs/getting-started.html
2. 新版本文档 : https://react.dev/learn
   - 中文版 : https://zh-hans.react.dev/learn




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