
## 0x01. 首次接触

面临的问题
1. 前端代码洗差不多了 ,  要打一个混淆包 . 
2. 将来打包的时候希望可以通过配置轻松打多环境包 
   - 一般来说 , 我们定义一些 build 变量 , 不同环境的包对应的 行为不同 , 比如 后端 baseUrl

## 0x02. 读下文档先 


## 0x03. 关于 build 变量


[React App 自身支持的环境变量设置方式 `.env`](https://create-react-app.dev/docs/adding-custom-environment-variables/)
- 使用环境变量文件
- 使用 env-cmd 指定环境变量文件 
  - `npm install env-cmd --save`
  ```json
  "scripts": {
    "start-development": "env-cmd -f .env.development  react-scripts start",
    "start-production": "env-cmd -f .env.production  react-scripts start",
  },
  ```

读过   create-react-app.dev 的文档后知道 , 它本身包含了 WebPack . 




webpack 中两个于此相关的插件
- DefinePlugin
- EnvironmentPlugin


## 0x04. webpack `Uncaught ReferenceError: process is not defined`
我们需要明白为什么会出现此异常提醒涉及到的点
1. NodeJs 
   - Node.js 是一个开源和跨平台的 JavaScript 运行时环境。 它是几乎任何类型项目的流行工具！
   - https://dev.nodejs.cn/learn/differences-between-nodejs-and-the-browser/
2. React APP
   - 
- webpack 


## 0x05. create-react-app.dev 发包
https://create-react-app.dev/docs/available-scripts

使用 `npm run build` 可以直接打出发布包
- 如果打包后再 浏览器 依然可以解析出源代码 可以试下 [.env 文件 增加一行 GENERATE_SOURCEMAP=false](https://create-react-app.dev/docs/advanced-configuration/)
- 次打包方式没有删除 console 控制台输出 , 这里找到两种方式避免控制台日志
   - [覆盖 console 函数](https://stackoverflow.com/a/68879947/7707781)
   - 以上链接还有其他方法 , 我暂时没有尝试



