## 一、.js 文件中的 Liquid 语法不被解析
解决方式：
- 尝试将带有 Liquid 语法的参数先放到 HTML 中(可作为某个相关节点的属性)
- 然后通过方法调用过程中的形参传递到 js 。

## 二、 统计
- Google统计
    - Jekyll 默认携带的就是此代码：https://developers.google.com/analytics/devguides/collection/analyticsjs/?hl=zh-cn
    - 是否付费的服务区分：https://support.google.com/analytics/answer/4553001?hl=zh-Hans
    - 默认的导航中 Google 给我们推荐的是 `gtag.js`
        - 暂时不区分 `gtag.js | analytics.js` 二者的差异了。
            - https://support.google.com/analytics/answer/7538414
        - 用 `gtag.js` 。
- 百度统计
- 友盟统计


### 2.1、 Google Analysis
1. 注册账号
2. 配置 config.yml
3. 编写特定事件代码(如果有需要的话)

#### 2.1.1、 关于报告
1. 报告查看：analytics.google.com/analytics/web/?hl=zh-CN
2. **非实时更新：** 您可以使用“行为 > 网站内容”报告来查看未显示在实时报告中的网页，但需要注意的是，对于非实时报告，处理数据需要 24-48 小时。

#### 2.1.2、 关于数据展示
暂时还没有处理 GoogleAnalysis 所统计数据在网页的展示。(浏览量等必要数据展示)

## 三、 消息\留言
1. disqus
    - 听说被墙了
    - https://blog.fooleap.org/use-disqus-correctly.html
    - 亲测国内不可用
