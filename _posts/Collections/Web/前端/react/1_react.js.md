从 WebStorm 创建的 MUI 工程开始了解 . 

```
<!-- 实际上就是 `npx create-next-app` 指令生成的文件们  -->

git:(master) ✗ tree ./
./
├── README.md
├── node_modules                           
│   └── 这里有许多子文件夹 , 我们暂时忽略他们
├── package-lock.json
├── package.json
├── public
│   ├── favicon.ico
│   ├── index.html
│   ├── logo192.png
│   ├── logo512.png
│   ├── manifest.json
│   └── robots.txt
└── src
    ├── App.css
    ├── App.js
    ├── App.test.js
    ├── index.css
    ├── index.js                            <!-- 代码执行入口 -->
    ├── logo.svg
    ├── reportWebVitals.js
    └── setupTests.js

3 directories, 17 files

```