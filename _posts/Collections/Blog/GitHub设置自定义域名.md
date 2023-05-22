
> - 译者：Tom
> - mail:tom.work@foxmail.com

## 一、 设置自定义域名(行动大纲)
> 原文：https://help.github.com/articles/quick-start-setting-up-a-custom-domain/

为你的 GitHub Page 设置自定义域名，你需要：
1. 选择一个自定义域名并且注册它(包含DNS解析服务)
2. 配置你的域名和 DNS 解析服务
3. 将你的自定义域名添加到 GitHub Page

>关于域名选择的一些提示信息
> - [关于支持的域名](https://help.github.com/articles/about-supported-custom-domains)
> - [自定义域名重定向到 GitHub Page](https://help.github.com/articles/custom-domain-redirects-for-github-pages-sites)


**1.** 选定一个自定义域名然后注册该域名，之后为域名选定一个 DNS 服务商为你的域名提供 DNS 解析服务(一般二者可以为同一厂商)。DNS provider 一个允许你购买和注册域名的公司，他们会将你注册的域名与你指定的 IP 或者你指定的另一个域名关联起来。DNS provider 也可以称之为一个域名注册商或者 DNS 主机。

**2.** 在配置你的 DNS provider 和域名之前，先将自定义域名添加到 GitHub page 站点。用 DNS provider 配置自定义域而不在 GitHub 设置自定义域名在技术上可导致别人能够在你的域名下绑定一个站点。更多细节：[为你的 GitHub page 添加或删除自定义域名](https://help.github.com/articles/adding-or-removing-a-custom-domain-for-your-github-pages-site)

**3.** 在你的 DNS provider 设置你的自定义域名。我们的引导说明了如何根据你所拥有的不同类型的的自定义域为 DNS provider 进行设置。
- 设置类似 `example.com` 的顶级域名
- 设置类似 `www.example.com` 的 `www` 子域名
- 设置顶级域名和 `www` 子域名
- 设置类似 `blog.example.com` 自定义子域名

**4.** 删除并重新添加自定义域名到你的 GitHub 账号从而触发启用 HTTPS 的过程。更多信息：[为你的 GitHub page 添加或删除自定义域名](https://help.github.com/articles/adding-or-removing-a-custom-domain-for-your-github-pages-site)

## 二、 为 GitHub Page 绑定域(预)
> 原文：https://help.github.com/articles/custom-domain-redirects-for-github-pages-sites/

你当前正式用的页面类型决定了你的自定义域名类型。

**Wraning：** 如果你的 GitHub Page 站点的 URL 中包含以 '-(端线)/——(连续破折号)' 开始或结尾的 username/organization name ，当 Linux 用户浏览你的站点会遭遇错误。要修正这样的问题[请点击](https://help.github.com/articles/changing-your-github-username/)

|	GitHub Page 类型	|	默认域名	|	GitHub Page 如何重定向域名	|	自定义域名示例	|
|----------------------|----------------------|----------------------|----------------------|
|	普通用户 Page 站点	|	username.github.io	|	自动重定向到为其设置的自定义域	|	user.example.com	|
|	组织 Page 站点	|	orgname.github.io	|	自动重定向到为其设置的自定义域	|	org.example.com	|
|	普通用户的项目 Page 站点	|	username.github.io/projectname	|	"自动重定向到用户 Page 站点自定义域名的一个子文件夹(user.example.com/projectname)"	|	project.example.com	|
|	组织用户的项目 Page 站点	|	orgname.github.io/projectname	|	"自动重定向到组织 Page 站点自定义域名的一个子文件夹(org.example.com/projectname)"	|	project.example.com	|

## 三、 关于自定义域名的支持情况
> 原文：https://help.github.com/articles/about-supported-custom-domains/

如果你正在为你的 GitHub Page 站点设置自定义域名，选择一个被支持的自定义域名可以通过最简单的设置获得最多的支持。GitHub page 在设计上支持两种类型的域名：顶级域名和子域名。

我们推荐选择一个受到支持的自定义域名，因为不受支持的自定义域名虽然可以工作但是需要更多相关域名服务和 DSN provider 的更多配置。

这些支持的自定义域名被 GitHub Page 优化过。推荐使用的自定义域名已经加粗了：
|支持的自定义域名类型|例子|
|-----------------|---|
|**`www` 子域名**  |`www.example.com`|
|**一个顶级域名 & 一个 `www` 子域名**  | `example.com`&`www.example.com`|
|顶级域名          |`example.com`|
|自定义子域名       |`blog.example.com`|

**Tip:** 我们推荐使用 `www`子域名作为你的自定义域名。如果你选择使用顶级域名作为你的自定义域名，我们希望你将 `www`子域名也设置上。[如此推荐的原因:见下文(此链接指向原文EN)](https://help.github.com/articles/about-supported-custom-domains/#www-subdomains)

### 3.1、 子域名
`子域名`这个术语有两种常见的含义：
1. 位于根或顶点域之前的域名的可自定义和可选部分，看起来像域前缀。 
2. 一种包含子域部分的域。

为避免混淆，具有不同子域部分的自定义域名被分配不同的标签。一个没有子域名的域名(例如：`example.com`)被称为[顶级域名](https://help.github.com/articles/about-supported-custom-domains/#apex-domains)。

|子域名            	|子域部分           	|子域类型        |
|-----------------  |-----------------  |-----------------| 
|`www.example.com` 	|www 	            |www 子域    |
|`blog.example.com`	|blog 	            |custom 子域 |   

#### 3.1.1、 `www` 子域
`www`子域名是子域中最常用的一种，其中 `www` 代表 [World Wide Web](https://en.wikipedia.org/wiki/World_Wide_Web)。例如 `www.example.com` 是一个 `www` 子域名，因为它包含了子域 `www`

为什么我们强烈推荐使用 `www` 子域名：
1. 它使 GitHub page 具有了 [内容交换网络](https://en.wikipedia.org/wiki/Content_delivery_network) 的优点。
2. 它更稳定，因为它不受 GitHub 服务器 IP 变化的影响。
3. 页面加载将更快，因为可以更有效的实现[拒绝服务攻击](https://en.wikipedia.org/wiki/Denial-of-service_attack)保护。

#### 3.1.2、 `custom` 子域
自定义子域名是子域名的一种，它没有使用 `www` 作为子域。它通常用于管理不同的主机机制或者计算机服务。例如： `blog` 在 `blog.example.io` 这或许与 `www.example.io` 是两个不同的服务器。GitHub Page 为每一个 page site 支持一个自定义域名。

#### 3.1.3、 设置子域名
子域通过 DNS provider 被设置为一个 `CNAME` 记录。

学习更多关于子域名设置的内容：
- [设置 `www` 子域名](https://help.github.com/articles/setting-up-a-www-subdomain)
- [设置一个顶级域名和一个 `www` 子域名](https://help.github.com/articles/setting-up-an-apex-domain-and-www-subdomain)
- [设置一个自定义子域名](https://help.github.com/articles/setting-up-a-custom-subdomain)

### 3.2、 顶级(Apex)域名
顶级域名(apex domain)是不包含子域的根域名，顶级域名也叫做 base/bare/naked/root apex 或者 zone apex domain。在 DNS provider 设置中顶级域名有时候被 `@` 符号所表示：
- `example.com` 是一个顶级域名，因为它没有任何子域部分。
- `www.example.com` 不是一个顶级域名，因为它包含子域 `www`。

#### 3.2.1、 设置顶级域名
[顶级域名通常通过 DNS provider 被设置为一个 `A`/`ALIAS`/`ANAME` 记录](https://help.github.com/articles/setting-up-an-apex-domain)

学习更多顶级域名的设置：
- [设置一个顶级域名](https://help.github.com/articles/setting-up-an-apex-domain)
- [设置一个顶级域名和 `www` 子域名](https://help.github.com/articles/setting-up-an-apex-domain-and-www-subdomain)

**Tip:** 如果你设置了一个顶级域名，我们推荐你也设置一个 `www` 域名。操作细节：[设置一个顶级域名和 `www` 子域名](https://help.github.com/articles/setting-up-an-apex-domain-and-www-subdomain)


## 四、 设置顶级域名 和 `www`子域名
你可以通过 DNS provider 设置顶级域名和`www`子域名，然后 GitHub Page 服务将会自动创建他们之间的重定向。例如：你的站点将在 www.example.com 或者 example.com 被浏览。

**warning：** 如果你的域名启用了强制 HTTPS ，GitHub page 服务将不会自动重定向。你必须按照域名记录配置 `www`子域名和根域名重定向。

如果你你希望顶级域名携带子域`www`，例如：`example.com`和`www.example.com`，你必须通过 DNS provider 配置每一个域名，然后 GitHub Page 服务会自动重定向到你。例如：
- 如果你添加到 GitHubPage 的是 `example.com` ，那么 `www.example.com` 将会重定向到 `example.com`。
- 如果你添加到 GitHubPage 的是 `www.example.com` ，那么 `example.com` 将会重定向到 `www.example.com`。

### 4.1、 设置顶级域名子域名
https://help.github.com/articles/setting-up-an-apex-domain

### 4.2、 设置 `www` 子域名
https://help.github.com/articles/setting-up-a-www-subdomain