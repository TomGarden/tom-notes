## 一、了解一下现有的 json 库
0. http://json.org/json-zh.html
1. [有哪些 C++ 的 JSON 库比较好呢？](https://www.zhihu.com/question/20211077)
2. GitHub 搜索一下会发现 fork 和 star 最多的两个项目是 ：
  - nlohmann/json
  - Tencent/rapidjson

3. 说真的当你看完 Tencent 针对 41 款开源库的对比之后你觉得其他的都没有 reapidjson 优秀。
  - 但是这不够，我们需要先查看自身对于这件事的需求到底有多大。

## 二、我们的需求
1. 读取配置文件：100 + ，每个到时不复杂。
2. 生成 JSON 对象，如果是一个那就很大。
  - 按数量来说百余个最多了，如果放到一个中，就是上述百余个的拼装
3. 我们要做的有解析和生成两件事，Tencent 的对比文章没有给到生成时间对比，暂且认为其生成效率较低。

### 2.1、小结
1. 解析效率  rapidjson > json
2. 生成效率  rapidjson < json
3. 跨平台    rapidjson == json
4. 易用性    rapidjson == json
5. 二者文档的完善程度都相当赞

### 2.2、选择
我们用英文的那个文档吧。
- 我们用 nlohmann/json 吧。
