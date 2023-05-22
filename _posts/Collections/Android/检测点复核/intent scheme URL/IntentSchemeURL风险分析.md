# Intent Scheme URL 风险分析

## 一、 漏洞原理
在查看过下文之后我们结合实际的业务场景思考这个漏洞所造成的风险。
- [[译文]Intent Scheme URL]([译]Intent-Scheme-URL.md)
    - [[原文]IntentScheme](Resource\IntentScheme.pdf)

### 1.1、 核心触发流程
1. Intent Scheme URL 传送到 WebViewClient.shouldOverrideUrlLoading 
2. WebViewClient.shouldOverrideUrlLoading 没有合理校验直接构造 Intent 并且调用执行 Intent 。

### 1.2、 产生风险的必要条件

1. 所处理的 URI 来源不可控。
    - 实际上即使可控在代理环境下也没有任何安全性可言的。
2. 直接使用 uri 来产生 Intent 对象。包含的方式如下
    ```java
    //One
    Intent intent = Intent.parseUri(String uri, int flags);
    //Two
    Intent intent = Intent.	getIntent(String uri);
    //Three  Intent(String action, Uri uri)
    Intent intent = new Intent(String action, Uri.parse(url));
    //Four
    Intent intent = Intent.getIntentOld(String uri);
    ```
3. 对生成的 Intent ，在使用之前未做进一步的限制逻辑。我们认可的限制逻辑如下：
    ```java
    // forbid explicit call
    intent.setComponent(null);
    // forbid intent with selector intent
    intent.setSelector(null);
    ```

## 二、风险监测
我们只需针对风险产生的必要条件进行检测即可，因为那些不可控的因素都是功能造成的。

在 WebViewClient 的实现类中的 `shouldOverrideUrlLoading(WebView view, String url) 或者 shouldOverrideUrlLoading(WebView view, WebResourceRequest request)` 方法中
出现 1.1 中的第 2 部分任意一句 Intent 构造代码，并且没有 1.1 中第 3 部分的代码我们就认定是风险。

关于 `shouldOverrideUrlLoading` 方法的返回值： True if the host application wants to leave the current WebView and handle the url itself, otherwise return false.

## 三、修复建议
```java
// forbid explicit call
intent.setComponent(null);
// forbid intent with selector intent
intent.setSelector(null);
```
### 3.1、 上述参数中 null
也可根据业务逻辑确定是否有必要为 null 。

## 最终的问题
又回到了最初的问题：“有交互就有可能产生风险，但是具体是否会产生风险我们尚不能断定”

## 如果不覆写 `shouldOverrideUrlLoading` 方法
该方法的默认写法为
```java
    /**
     * Give the host application a chance to take over the control when a new
     * url is about to be loaded in the current WebView. If WebViewClient is not
     * provided, by default WebView will ask Activity Manager to choose the
     * proper handler for the url. If WebViewClient is provided, return true
     * means the host application handles the url, while return false means the
     * current WebView handles the url.
     * This method is not called for requests using the POST "method".
     *
     * @param view The WebView that is initiating the callback.
     * @param url The url to be loaded.
     * @return True if the host application wants to leave the current WebView
     *         and handle the url itself, otherwise return false.
     * @deprecated Use {@link #shouldOverrideUrlLoading(WebView, WebResourceRequest)
     *             shouldOverrideUrlLoading(WebView, WebResourceRequest)} instead.
     */
    @Deprecated
    public boolean shouldOverrideUrlLoading(WebView view, String url) {
        return false;
    }
```
为什么会引发是否覆写 `shouldOverrideUrlLoading` 的问题？
- 这取决于开发者是否为 `WebView` 设置了 `WebViewClient` ：`webView.setWebViewClient();`。
    - 如果设置了就会出现是否需要覆写该方法的疑问

至于为什么需要为 WebView 设置 WebViewClient
- 开发文档中描述太过简便，大致作用是可以取代系统的一些默认动作，例如本例中，加载一个 URL 之前可以通过 WebViewClient 对象截断并决定是否加载该 URL。
- 系统的默认操作一点时间是无法获知的(需要了解 WebView 的设计原理和机制)，并且这个问题应超出了当前检测点的范畴。