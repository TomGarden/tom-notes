---
layout: post
title:  null
date:   2018-08-15 07:24:00 +0800
categories: jekyll update
author: Tom
---

-----------------------------
__目录__
- jekyll 的 kmarkdown 负责解析
{:toc}

-----------------------------
<br>

# GitHub Developer · REST API v3  >>>  Overview
原文：https://developer.github.com/v3/

## 〇、 概述
这个描述组成了 GitHub 对于 REST API v3 的官方描述。
如果你有任何问题请联系 [GitHub support](https://github.com/contact)。

## 一、 当前版本
默认的，所有向 `https://api.github.com` 发送的请求都将接收到 REST API 的 v3 版。
我们鼓励[通过 accept hheader 明确的请求这个版本](https://developer.github.com/v3/media/#request-specific-version)
```
Accept: application/vnd.github.v3+json
```

[关于 GitHub 的 GraphQL API v4 ](https://developer.github.com/v4)
[关于 迁移到 GraphQL，"Migrating from REST"](https://developer.github.com/v4/guides/migrating-from-rest/)

## 二、 模式 (Schema)
所有 API 都通过 Https 从 `https://api.github.com` 访问。
所有的交换数据(发送和接收)都使用 JSON 。

```
curl -i https://api.github.com/users/octocat/orgs
HTTP/1.1 200 OK
Server: nginx
Date: Fri, 12 Oct 2012 23:33:14 GMT
Content-Type: application/json; charset=utf-8
Connection: keep-alive
Status: 200 OK
ETag: "a00049ba79152d03380c34652f2cb612"
X-GitHub-Media-Type: github.v3
X-RateLimit-Limit: 5000
X-RateLimit-Remaining: 4987
X-RateLimit-Reset: 1350085394
Content-Length: 5
Cache-Control: max-age=0, private, must-revalidate
X-Content-Type-Options: nosniff
```

空白字段应该设置值为 null ， 而不是省略。

所有的事件遵从 `ISO 8601` 格式：
```
YYYY-MM-DDTHH:MM:SSZ
```

关于时间戳中的时区请看下文。

### 2.1、 简要描述
当你获取一个资源列表的时候，响应中会包含目标资源的属性子集。这就是资源的“概要/简要”描述。
(API 提供的某些属性在计算上是昂贵的。出于性能考虑，摘要哦描述不包含这部分属性。要获得这部分属性，需要获取 “细节描述”)

**例如：** 当你获取所有仓库的简要描述作为响应列表。这里我们获取 octokit 组织的仓库列表：
```
GET /orgs/octokit/repos
```

### 2.2、 细节描述
当你获取个人资源的时候，相应类型包含目标资源的所有属性。这就是资源的“细节/详细”描述。
(注意，授权有时候会影响相应中所包含详细信息的量)。

**例如：** 当你获取一个私人仓库的细节描述的时候。这里获取 octokit/octokit.rb 仓库：
```
GET /repos/octokit/octokit.rb
```

文档中为每一个 API 方法的 response 提供了一个例子。response 示例说明了对应方法所返回的所有属性。

## 三、 认证 (Authentication)
我们有三种方法通过 GitHub API v3 的认证。在需要认证的某些地方使用 `404 Not Found` 取代 `403 Forbidden` 。这是为了方式私有仓库在未经授权的情况下意外泄露。

**基本认证**
```
curl -u "username" https://api.github.com
```

**OAuth2 token (通过header发送)**
```
curl -H "Authorization: token OAUTH-TOKEN" https://api.github.com
```

**OAuth2 token (通过参数发送)**
```
curl https://api.github.com/?access_token=OAUTH-TOKEN
```

[关于 OAuth2 的更多信息](https://developer.github.com/apps/building-integrations/setting-up-and-registering-oauth-apps/)注意， OAuth2 可以通过编程的方式获取(对于非网站应用程序)。

**OAuth2 key/secret**
```
curl 'https://api.github.com/users/whatever?client_id=xxxx&client_secret=yyyy'
```

这仅应被用于服务端到服务端的通信。请不要将您的 OAuth 泄露个你的客户端用户。
[更多关于未验证的速率限制](https://developer.github.com/v3/#increasing-the-unauthenticated-rate-limit-for-oauth-applications)

### 3.1、 登陆失败限制
使用无效的证书认证将会返回 `401 Unauthorized`：
```
curl -i https://api.github.com -u foo:bar
HTTP/1.1 401 Unauthorized
{
  "message": "Bad credentials",
  "documentation_url": "https://developer.github.com/v3"
}
```

在检测到无效证书之后的一小段时间内，API将会暂时拒绝所有用户的认证请求(包含有效证书用户)并返回 `403 Forbiden`。
```
curl -i https://api.github.com -u valid_username:valid_password
HTTP/1.1 403 Forbidden
{
  "message": "Maximum number of login attempts exceeded. Please try again later.",
  "documentation_url": "https://developer.github.com/v3"
}
```

## 四、 参数
许多 API 方法可以选择参数。对于GET请求，未在路径中指定为段的任何参数都可以作为HTTP查询字符串参数传递：
```
curl -i "https://api.github.com/repos/vmg/redcarpet/issues?state=closed"
```

在上面的例子中 ’vmg‘ 和 ’redcarpet‘ 分别是 `:owner` 和 `:repo` 两个参数的值，url 中 `:state` 是被传送用于插叙的字符串。

对于 POST,PATCH,PUT 和 DELETE 请求，参数不包含在 URL 。应该被编码为 JSON 同时设置 Content-Type 为 ’application/json‘ 进行传送：
```
curl -i -u username -d '{"scopes":["public_repo"]}' https://api.github.com/authorizations
```

## 五、 根端点(GitHub app 可用)
可以向根端点发出GET请求，以获得REST API V3支持的所有端点类别：
```
curl https://api.github.com
```

## 六、 GraphQL 全局节点 ID
查看 [使用全局节点ID](https://developer.github.com/v4/guides/using-global-node-ids) 可以了解到关于如何通过 REST API v3 发现 `node_id` 并且在 GraphQL选项中使用 `node_id` 的更多细节信息。

## 七、 客户端错误
这里有三种类型的客户端请求错误：
1. 发送无效的 JSON 将会得到 `400 Bad Request` 响应
    ```
    HTTP/1.1 400 Bad Request
    Content-Length: 35

    {"message":"Problems parsing JSON"}
    ```

2. 发送类型错误的 JSON 值将会得到 `400 Bad Request` 响应
    ```
    HTTP/1.1 400 Bad Request
    Content-Length: 40

    {"message":"Body should be a JSON object"}
    ```

3. 发送无效的属性将会得到 `422 Unprocessable Entity` 响应
    ```
    HTTP/1.1 422 Unprocessable Entity
    Content-Length: 149

    {
    "message": "Validation Failed",
    "errors": [
        {
        "resource": "Issue",
        "field": "title",
        "code": "missing_field"
        }
    ]
    }
    ```

所有的错误对象都有资源和属性值，所以你的客户端能够知道发生了什么问题。
也有一个错误代码让你知道错误的领域。
这里有一些可能的有效的错误码：
|错误名字|描述|
|-------|---|
|missing|意味着资源不存在|
|missing_field|意思是请求的域在资源中未设置|
|invalid|意思是域的格式是无效的。关于该资源的文档应该能给你更多的特定的信息|
|already_exists|意思是这个域中有值相同的资源。这可能发生在某些资源必须有独一无二的值(例如 Label name)|

资源有可能发送自定义有效的错误(`code`被`自定义`)。自定义错误将总是有一个 `message` 属性来描述该错误，并且多数errors将包含 `document_rul` 属性指出那些可能帮助你解决error的内容。

## 八、 HTTP 重定向
API v3 在适当的地方使用 HTTP 重定向。客户端应该假设任何请求都有可能返回一个重定向。接收一个 HTTP 重定向不是一个 error 并且客户端应该跟随重定向。重定向会有一个 `Location` 响应头，这个属性包含了资源被重定向的目标位置。
|状态码|描述|
|-----|---|
|302|永久重定向。你使用的请求 URL 已经被响应头中 `Location` 的值替代。本次和将来的所有关于它的请求都应该使用这个新的 URL。|
|302,307|暂时重定向。这个请求响应中的 `Location` 所指定的 URL 需要我们重复进行访问，但是在未开客户端还是应该继续使用最初的 URL 进行请求。|

其他重定向状态码和 HTTP 1.1 是一致的。

## 九、 HTTP verbs
在可能的情况下，API v3力求为每个动作使用适当的HTTP verbs。
|Verb|描述|
|----|----|
|HEAD|可以针对任何已经发布的资源获取 HTTP 头信息|
|GET|用于获取资源|
|POST|用于创建资源|
|PATCH|用于通过部分 JSON 数据更新资源。一个实例，一个 Issue 资源有 `title` 和 `body` 两个属性。一个 PATCH 请求在更新资源的时候可以接收一个或者多个属性。PATCH 是一个比较新的和不常见的 verb ，所以资源端点也接受 POST 请求。|
|PUT|用于替换资源或者集合。对于 PUT 请求没有 `body` 属性，确保设置 `Content-Length` 头为 0。|
|DELETE|用于删除资源。|

## 十、 超媒体(Hypermedia)
每一个资源或许都有一个或者多个 `*_url` 属性连接到其他资源。
这意味着要提供明确的 URL ，以便适当的 API 客户端不需要自己重新构造 URL 。
强烈推荐 API 客户端使用这些。
这么做使得开发者在未来升级这些 API 变的容易。
所有的 URL 都被都被期望适合 [RFC 6570](http://tools.ietf.org/html/rfc6570) URL 模板。

你可以使用 [rul-template](https://github.com/hannesg/uri_template) gem 扩展这个模板：
```
>> tmpl = URITemplate.new('/notifications{?since,all,participating}')
>> tmpl.expand
=> "/notifications"

>> tmpl.expand :all => 1
=> "/notifications?all=1"

>> tmpl.expand :all => 1, :participating => 1
=> "/notifications?all=1&participating=1"
```

## 十一、 分页
返回多条目的请求会默认按 30 个条目进行分页。你可以进一步的使用 `？page` 指定页面数。对某些资源，你也可以通过 `？per_page` 设置自定义页面大小为 100 。注意因为技术原因不是所有的端点都支持 `?per_page` 参数。[查看例子](https://developer.github.com/v3/activity/events/)
```
curl 'https://api.github.com/user/repos?page=2&per_page=100'
```

注意页面数量是从 1 开始计数的。可以省略 `？page` 参数，此时将默认返回第一页。

更多关于分析的信息请查看：https://developer.github.com/guides/traversing-with-pagination

### 11.1、 Link header
> **注意：** 用 Link header 进行调用取代自己的 URL 是很重要的。

[Likn Header](http://tools.ietf.org/html/rfc5988)包含分页信息：
```html
Link: <https://api.github.com/user/repos?page=3&per_page=100>; rel="next",
  <https://api.github.com/user/repos?page=50&per_page=100>; rel="last"
```

*The example includes a line break for readability.*

该链接响应头包含一个或多个超媒体链接关系，其中一些可能需要扩展为URI模板。

可能的 `rel` 值：
|名字|描述|
|---|----|
|next|下一页结果的链接|
|last|最后页结果的链接|
|first|第一页结果的链接|
|perv|上一页结果的链接|

## 十二、 速率限制
对于基于身份认证的 API 请求，你每小时可以发送 5000 次(不论是用那种身份认证方式)。
认证是和用户相关的
这意味着所有的 OAuth 应用通过一个 user 分享的相同令牌在不同的 app 上共享这每小时 5000 次的资源。

对于未经认证的请求，速率限制为每小时 60 次数。
未经认证的请求和发起 IP 地址相关而不是和用户相关。

注意：[搜索 API 可以自定义速率限制规则](https://developer.github.com/v3/search/#rate-limit)

任何 API 的 HTTP 请求头都展示了当前请求的速率限制：
```
curl -i https://api.github.com/users/octocat
HTTP/1.1 200 OK
Date: Mon, 01 Jul 2013 17:27:06 GMT
Status: 200 OK
X-RateLimit-Limit: 60           //限制次数(每小时)
X-RateLimit-Remaining: 56       //剩余次数
X-RateLimit-Reset: 1372700873   //UTC计时，重置事件点
```

|Header Name| 描述|
|-----------|-----|
|X-RateLimit-Limit|每小时被允许发送请求的最大数量|
|X-RateLimit-Remaining|在当前速率限制下还可以发送的请求数|
|X-RateLimit-Reset|当前窗口在请求次数的重置时间点[(UTC 纪元)](http://en.wikipedia.org/wiki/Unix_time)|

如果你需要不同格式的事件，任何现代编程语言都可以完成该工作。
例如，如果你打开浏览器控制台，你可以非常容易的获取重置时间(一个 JavaScript Date 对象)
```
new Date(1372700873 * 1000)
// => Mon Jul 01 2013 13:47:53 GMT-0400 (EDT)
```

如果你超过速率限制会得到一个错误：
```
HTTP/1.1 403 Forbidden
Date: Tue, 20 Aug 2013 14:50:41 GMT
Status: 403 Forbidden
X-RateLimit-Limit: 60
X-RateLimit-Remaining: 0
X-RateLimit-Reset: 1377013266
{
   "message": "API rate limit exceeded for xxx.xxx.xxx.xxx. (But here's the good news: Authenticated requests get a higher rate limit. Check out the documentation for more details.)",
   "documentation_url": "https://developer.github.com/v3/#rate-limiting"
}
```

你可以 [检查你的速率状态](https://developer.github.com/v3/rate_limit) 。

### 12.1、 为 OAuth app 增加未认证的请求速率限制
如果你的 OAuth app 需要使用未认证的 API 调用的频率高于当前的限制，你可以将 app 客户端的 ID 和安全字段作为查询字符串发送给服务器。
```
curl -i 'https://api.github.com/users/whatever?client_id=xxxx&client_secret=yyyy'
HTTP/1.1 200 OK
Date: Mon, 01 Jul 2013 17:27:06 GMT
Status: 200 OK
X-RateLimit-Limit: 5000
X-RateLimit-Remaining: 4966
X-RateLimit-Reset: 1372700873
```

> 注意： 切勿与任何人分享您的客户密码或将其包含在客户端浏览器代码中。 此处显示的方法仅用于服务器到服务器的调用。

### 12.2、 保持在速率限制内
如果你使用 基本认证或者OAuth 超过你的速率限制，你可以通过缓存 API 相应和使用[条件请求](https://developer.github.com/v3/#conditional-requests)来解决这个问题。

### 12.3、 滥用速率限制(Abuse rate limits)
为了在GitHub上提供高质量的服务，在使用API时，某些操作可能会适用额外的速率限制。 例如，使用API来快速创建内容，积极地轮询而不是使用webhook，进行多个并发请求，或者重复请求计算成本高的数据可能导致滥用率限制。

滥用速率限制并不是意图干扰 API 的正常使用。
您的正常费率限制应该是您定位的唯一限制。 为确保您作为优秀的API公民，请查看我们的[最佳实践指南](https://developer.github.com/guides/best-practices-for-integrators/)。

如果你的 app 触发了速率限制你将得到这样的响应：
```
HTTP/1.1 403 Forbidden
Content-Type: application/json; charset=utf-8
Connection: close
{
  "message": "You have triggered an abuse detection mechanism and have been temporarily blocked from content creation. Please retry your request again later.",
  "documentation_url": "https://developer.github.com/v3/#abuse-rate-limits"
}
```

## 十三、 使用 agent 请求
所有的 API 请求必须包含 `User-Agent` 请求头。
请求中不包含该请求头请求将会被拒绝。
我们希望你使用 username 或者 appName 作为 `User-Agent` 的值。
这样如果发生问题我们方便联系你。

一个例子：
```
User-Agent: Awesome-Octocat-App
```

cURL 默认发送有效的 `User-Agent` 。
如果你提供一个无效的 `User-Agent` 请求头通过 cURL(或者通过一个客户端)，你将接收到一个 `403 Forbidden` 响应：
```
curl -iH 'User-Agent: ' https://api.github.com/meta
HTTP/1.0 403 Forbidden
Connection: close
Content-Type: text/html
Request forbidden by administrative rules.
Please make sure your request has a User-Agent header.
Check https://developer.github.com for other possible causes.
```

## 十四、 条件请求(Conditional requests)
多数响应 return 一个 `ETag` 响应头。
许多响应也 return 一个 `Last-Modified` 响应头。
你可以使用这些 header 的值，分别使用 `If-None-Match` 和 `If-Modified-Since` 进行后续的资源请求。
如果资源没有改变，服务端将会 return `304 Not Modified`。

> **注意：**　使用一个条件请求接收一个　304 响应不计数到速率限制，所以我们鼓励你当可能的时候使用条件请求。

```
curl -i https://api.github.com/user
HTTP/1.1 200 OK
Cache-Control: private, max-age=60
ETag: "644b5b0155e6404a9cc4bd9d8b1ae730"
Last-Modified: Thu, 05 Jul 2012 15:31:30 GMT
Status: 200 OK
Vary: Accept, Authorization, Cookie
X-RateLimit-Limit: 5000
X-RateLimit-Remaining: 4996
X-RateLimit-Reset: 1372700873
curl -i https://api.github.com/user -H 'If-None-Match: "644b5b0155e6404a9cc4bd9d8b1ae730"'
HTTP/1.1 304 Not Modified
Cache-Control: private, max-age=60
ETag: "644b5b0155e6404a9cc4bd9d8b1ae730"
Last-Modified: Thu, 05 Jul 2012 15:31:30 GMT
Status: 304 Not Modified
Vary: Accept, Authorization, Cookie
X-RateLimit-Limit: 5000
X-RateLimit-Remaining: 4996
X-RateLimit-Reset: 1372700873
curl -i https://api.github.com/user -H "If-Modified-Since: Thu, 05 Jul 2012 15:31:30 GMT"
HTTP/1.1 304 Not Modified
Cache-Control: private, max-age=60
Last-Modified: Thu, 05 Jul 2012 15:31:30 GMT
Status: 304 Not Modified
Vary: Accept, Authorization, Cookie
X-RateLimit-Limit: 5000
X-RateLimit-Remaining: 4996
X-RateLimit-Reset: 1372700873
```

## 十五、 跨源 资源共享
针对 AJAX 来自任何源的请求 API 支持跨源资源共享(CORS)。
你可以从 H5 安全指导中读[ CORS W3C Recommendation](http://www.w3.org/TR/cors/)或者[这个简介](http://code.google.com/p/html5security/wiki/CrossOriginRequestSecurity)。

这是一个从浏览器发出的示例请求：
```
curl -i https://api.github.com -H "Origin: http://example.com"
HTTP/1.1 302 Found
Access-Control-Allow-Origin: *
Access-Control-Expose-Headers: ETag, Link, X-GitHub-OTP, X-RateLimit-Limit, X-RateLimit-Remaining, X-RateLimit-Reset, X-OAuth-Scopes, X-Accepted-OAuth-Scopes, X-Poll-Interval
```

这是 CORS 预检请求的样子：
```
curl -i https://api.github.com -H "Origin: http://example.com" -X OPTIONS
HTTP/1.1 204 No Content
Access-Control-Allow-Origin: *
Access-Control-Allow-Headers: Authorization, Content-Type, If-Match, If-Modified-Since, If-None-Match, If-Unmodified-Since, X-GitHub-OTP, X-Requested-With
Access-Control-Allow-Methods: GET, POST, PATCH, PUT, DELETE
Access-Control-Expose-Headers: ETag, Link, X-GitHub-OTP, X-RateLimit-Limit, X-RateLimit-Remaining, X-RateLimit-Reset, X-OAuth-Scopes, X-Accepted-OAuth-Scopes, X-Poll-Interval
Access-Control-Max-Age: 86400
```

## 十六、 JSON-P callbacks
在任何 GET 调用中你都可以携带一个 `?callback` 参数去获取这 JSON 格式的结果。
这通常在浏览器希望通过解决跨域问题在网页中嵌入GitHub内容时使用。
响应包含和规范 API 一样的数据，附加响应的 HTTP 头信息。
```
curl https://api.github.com?callback=foo
/**/foo({
  "meta": {
    "status": 200,
    "X-RateLimit-Limit": "5000",
    "X-RateLimit-Remaining": "4966",
    "X-RateLimit-Reset": "1372700873",
    "Link": [ // pagination headers and other links
      ["https://api.github.com?page=2", {"rel": "next"}]
    ]
  },
  "data": {
    // the data
  }
})
```

你可以写一个 JavaScript 处理器执行这个回调。
这是一个最小的例子，你可以使用一下：
```html
<html>
<head>
<script type="text/javascript">
function foo(response) {
  var meta = response.meta;
  var data = response.data;
  console.log(meta);
  console.log(data);
}

var script = document.createElement('script');
script.src = 'https://api.github.com?callback=foo';

document.getElementsByTagName('head')[0].appendChild(script);
</script>
</head>

<body>
  <p>Open up your browser's console.</p>
</body>
</html>
```

作为 HTTP 头信息的都是相同是 String 值，一个明显的例子是 Link 。 
Link 头信息预先解析并且作为 [url,options] 元组传送。

Link 看起来像这样：
```
Link: <url1>; rel="next", <url2>; rel="foo"; bar="baz"
```

……将看到这样的回调输出：
```json
{
  "Link": [
    [
      "url1",
      {
        "rel": "next"
      }
    ],
    [
      "url2",
      {
        "rel": "foo",
        "bar": "baz"
      }
    ]
  ]
}
```

## 十七、 时区
一些结果允许指定时间戳或者使用时区生成的时间戳。
我们根据优先级顺序应用以下规则来确定API调用的时区信息。

**明确提供一个携带时区信息的 ISO 8601 时间戳**

对于允许 API 指定时间戳的调用，我们使用指定的时间戳。
一个例子是 [Commits API](https://developer.github.com/v3/git/commits)

这个时间戳看起来像这样：`2014-02-27T15:05:06+01:00`。
通过 [例子](https://developer.github.com/v3/git/commits/#example-input) 查看这个时间戳如何被指定。

**使用 `Time-Zone` 头**

可以提供 `Time-Zone` 头信息，并且[根据 Olson 数据库定义时区信息](https://en.wikipedia.org/wiki/List_of_tz_database_time_zones)。
```
curl -H "Time-Zone: Europe/Amsterdam" -X POST https://api.github.com/repos/github/linguist/contents/new_file.md
```

这意味着我们会在此标头定义的时区中生成API调用的时间戳。
例如，[Contents API](https://developer.github.com/v3/repos/contents/) 使用当前事件作为时间戳为所有被修改过的文件生成了一个 git commit。
这个头信息将明确用于生成当前时区的时间戳。

**使用用户最后已知的时区**

如果 `Time-Zone` 头被指定并且你使用了一个身份认证 API，我们使用身份认证用户最后已知的时区作为时间戳。
最后已知的时区会随着用户访问 GitHub 站点的时候被更新。

**UTC**

如果上述步骤没有任何信息，我们使用 UTC 作为时间戳创建 git commit 。