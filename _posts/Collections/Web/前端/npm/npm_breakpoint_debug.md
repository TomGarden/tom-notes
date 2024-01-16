

有必要 了解下 npm 相关内容了 : https://docs.npmjs.com/

1. 依赖安装
2. 断点调试
3. WebStrom 所展示的能力 , 应该相当部分是通过 npm 指令完成的 . 




## 0x01. 我们提到 NPM 需要了解到的侧重点有哪些

1. npm 是一个网站 : https://docs.npmjs.com/
2. npm 是一个可执行文件 : https://docs.npmjs.com/cli/v10
3. npm 是一个包管理平台 : https://docs.npmjs.com/about-npm#getting-started

当前我们先关注下 npm 可执行文件 . 

npm 指令具体如何使用
1. 静下心来 , 使用 `npm --help` , 然后查看输出内容
2. `npm -l` 展示所有子命令
3. `npm install --help` 查看子命令梗概
   - `npm help install` 查看子命令的详细信息
4. 也可以到文档页面查看相关指令信息 : https://docs.npmjs.com/cli/v10


## 0x02. [tsc](https://www.typescriptlang.org/docs/handbook/compiler-options.html)




## 0x03. React 项目 通过 Chrome 断点调试 
在 WebStrom 中点击运行 , 在 Chrome 开发者工具 Sources tab 页下面 查看代码并且打断点即可 . 

## 0x04. React 项目 通过 WebStrom 断点调试 

版本信息
```
WebStorm 2023.2
Build #WS-232.8660.143, built on July 21, 2023
```

- GUI Run : num start 
   - 会打开一个 浏览器 窗口
- GUI Debug : Debug Application
   - 会重新打开一个浏览器窗口(新进程)