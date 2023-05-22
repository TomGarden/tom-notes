---
layout: post
title:  null
date:   2018-09-27 08:46:38 +0800
categories: jekyll update
author: Tom
---

-----------------------------
__目录__
- jekyll 的 kmarkdown 负责解析
{:toc}

-----------------------------
<br>

# GitHub Developer · REST API v3  >>>  Search

原文：https://developer.github.com/v3/search

## 〇、 Override

1. Search repositories
2. Search commits
3. Search code
4. Search issues
5. Search users
6. Search topics
7. Search labels
8. Text match metadata

>**Note:** GitHub 中 repository 的 `topics` 属性当前可以供开发者预览。
要在响应中展示 `topics` 属性，在请求中必须提供请求头:
>```
>Accept:application/vnd.github.mercy-preview+json
>```

>**Warning:** 预览期间 API 有可能在不提前通知开发者的情况下做出变更。
如果在使用的过程中遇到任何问题请联系 [GitHub support](https://github.com/contact)

### 0.1、 关于 search API

Search API 的目的在于帮助你查找你当前正在搜索的内容(例如，一个指定的用户，一个 repository 中的指定文件等)。
回想一下你在 Google 上执行搜索的方式。
这种设计能帮助你寻找到目标结果(或者减少结果的范围)。
像 Google 搜索一样，有的时候你希望结果的范围较小(搜索结果页面更少)，因为这能让你更好的遇到你的搜索目标。
为了满足这个需求， GitHub API 为每次搜索提供了 1000 个搜索结果。

### 0.2、 搜索结果排序
除非提供另一个排序选项作为参数，否则搜索结果将按照 `score` 属性进行排序。
`score` 是一个计算值，代表一个结果与结果集中其他结果的相关性。
将多个因素结合起来，将最相关的结果放到结果列表顶端。

### 0.3、 查询速率限制
Search API 有自己定义的使用速率限制。
对于通过 Basic Authentication，OAuth 或者 client ID and secret 做为身份认证的请求，限制为 30次/分钟。
对于未进行身份认证的请求，10次/分钟。

查看 [rate limit doc](https://developer.github.com/v3/#rate-limiting) 了解你当前的速率限制状态。

### 0.4、 超时和不完整的结果
为了保证 Search API 对每个人来说都都足够快速，我们限制了任何个人查询动作能够运行的时间。
对于查询的触发 [执行时间限制](https://developer.github.com/changes/2014-04-07-understanding-search-results-and-potential-timeouts/) 的查询, API 返回限制时间内已经查询到的结果，并且 response 设置为 `true` 的参数 `incomplete_results`

到达了执行超时时间，不一定意味着搜索结果不完整。
通常绝大多数的的结果都已经被发现了(只是通常))。

## 四、Search issues

根据状态(state)和关键字查找 issue 。
本 API 的响应按照每页 100 个条目进行分页。

```
GET /search/issues
```

### 4.1、 参数

|Name|Type|Description|
|----|----|-----------|
|q|string|**必需。** 搜索条目|
|sort|string|分类属性。值可以是 `comments`，`created`或`updated`。默认：结果按最佳匹配排序。|
|order|string|排序命令`sort`(如果此参数被提供)。值可以是`asc`或`desc`。默认：`desc`|

搜索条目参数 `q` 中可以包含任何支持的限定词。搜索语法在 [`issue search documentation`](https://help.github.com/articles/searching-issues/) 和 [`search syntax documentation`](https://help.github.com/articles/search-syntax/) 。下述为限定词：

- [`type`](https://help.github.com/articles/searching-issues#search-issues-or-pull-requests) 使用这个限定词，你能将搜索结果限定在 issue(`issue`) 或者 pull request(`rp`) 之间。
- [`in`](https://help.github.com/articles/searching-issues#scope-the-search-fields) 限定搜索领域。通过这个限定词，你能将搜索范围限制在 title(`title`),body(`body`),comments(`comments`)或者其组合。
- [`involves`](https://help.github.com/articles/searching-issues#search-by-a-user-thats-involved-within-an-issue-or-pull-request) 查询下述几者的集合：
    - [`author`](https://help.github.com/articles/searching-issues#search-by-the-author-of-an-issue-or-pull-request) 查询被特定用户创建的 issue 或者 pull request
    - [`assignee`](https://help.github.com/articles/searching-issues#search-by-the-assignee-of-an-issue-or-pull-request) 查询被分配各特定用户的 issue 或 pull request
    - [`mentions`](https://help.github.com/articles/searching-issues#search-by-a-mentioned-user-within-an-issue-or-pull-request) 查询提及制定用户的 issue 或 pull request
    - [`commenter`](https://help.github.com/articles/searching-issues#search-by-a-commenter-within-an-issue-or-pull-request) 查询由特定用户评论的 issue 或 pull request
- [`team`](https://help.github.com/articles/searching-issues/#search-by-a-team-thats-mentioned-within-an-issue-or-pull-request) 对于你作为成员的组织，查找提及(@mention)该组织的 issue 或 pull request
- [`state`](https://help.github.com/articles/searching-issues#search-based-on-whether-an-issue-or-pull-request-is-open) 基于 open 或 close 状态过滤 issue 或 pull request
- [`labels`](https://help.github.com/articles/searching-issues#search-by-the-labels-on-an-issue) 基于 label 过滤 issue 或 pull request
- [`no`](https://help.github.com/articles/searching-issues#search-by-missing-metadata-on-an-issue-or-pull-request) 过滤缺失 `label`,`mileston`或`assignee`的条目
- [`language`](https://help.github.com/articles/searching-issues#search-by-the-main-language-of-a-repository) 查找使用指定开发语言 repository 的 issue 或 pull request
- [`is`](https://help.github.com/articles/searching-issues#search-based-on-the-state-of-an-issue-or-pull-request) 查找与  repository 中特定状态匹配的条目例如：`open`,`close`,或`merged` 
- [`created` 或 `update`](https://help.github.com/articles/searching-issues#search-based-on-when-an-issue-or-pull-request-was-created-or-last-updated) 过滤基于特定日期 create 或者 update 的 issue 或 pull request
- [`merged`](https://help.github.com/articles/searching-issues#search-based-on-when-a-pull-request-was-merged) 基于时间过滤进行 merged 的 pull request
- [`status`](https://help.github.com/articles/searching-issues#search-based-on-commit-status) 基于 commit 状态过滤 pull request
- [`head` 或 `base`](https://help.github.com/articles/searching-issues#search-based-on-branch-names) 基于对分支的创建或者修改过滤 pull request
- [`close`](https://help.github.com/articles/searching-issues#search-based-on-when-an-issue-or-pull-request-was-closed) 基于关闭时间过滤 issue 或 pull request
- [`comments`](https://help.github.com/articles/searching-issues#search-by-the-number-of-comments-an-issue-or-pull-request-has) 基于评论数量过滤 issue 或 pull request
- [`user` 或 `repo`](https://help.github.com/articles/searching-issues#search-within-a-users-or-organizations-repositories) 限定搜索指定用户或者 repository
- [`project`](https://help.github.com/articles/searching-issues/#search-by-project-board) 限制搜索位于 repository 或者 organization 的指定 project
- [`archived`](https://help.github.com/articles/searching-issues/#search-within-archived-repositories) 基于是否归档于 repository 搜索 issue 或 pull request

如果你知道一个 commit 的 SHA hash，你也能[使用它搜索 pull request](https://help.github.com/articles/searching-issues#search-by-the-commit-shas-within-a-pull-request)。注意 SHA 关键字至少 7 个字符。

### 4.2、 例子
假设你希望查找时间最早的尚未解决的 Python 的 bug。
你的查询语句可以是：
```
curl https://api.github.com/search/issues?q=windows+label:bug+language:python+state:open&sort=created&order=asc
```

响应 
```json
Status: 200 OK
Link: <https://api.github.com/resource?page=2>; rel="next",
      <https://api.github.com/resource?page=5>; rel="last"
X-RateLimit-Limit: 20
X-RateLimit-Remaining: 19
{
  "total_count": 280,
  "incomplete_results": false,
  "items": [
    {
      "url": "https://api.github.com/repos/batterseapower/pinyin-toolkit/issues/132",
      "repository_url": "https://api.github.com/repos/batterseapower/pinyin-toolkit",
      "labels_url": "https://api.github.com/repos/batterseapower/pinyin-toolkit/issues/132/labels{/name}",
      "comments_url": "https://api.github.com/repos/batterseapower/pinyin-toolkit/issues/132/comments",
      "events_url": "https://api.github.com/repos/batterseapower/pinyin-toolkit/issues/132/events",
      "html_url": "https://github.com/batterseapower/pinyin-toolkit/issues/132",
      "id": 35802,
      "node_id": "MDU6SXNzdWUzNTgwMg==",
      "number": 132,
      "title": "Line Number Indexes Beyond 20 Not Displayed",
      "user": {
        "login": "Nick3C",
        "id": 90254,
        "node_id": "MDQ6VXNlcjkwMjU0",
        "avatar_url": "https://secure.gravatar.com/avatar/934442aadfe3b2f4630510de416c5718?d=https://a248.e.akamai.net/assets.github.com%2Fimages%2Fgravatars%2Fgravatar-user-420.png",
        "gravatar_id": "",
        "url": "https://api.github.com/users/Nick3C",
        "html_url": "https://github.com/Nick3C",
        "followers_url": "https://api.github.com/users/Nick3C/followers",
        "following_url": "https://api.github.com/users/Nick3C/following{/other_user}",
        "gists_url": "https://api.github.com/users/Nick3C/gists{/gist_id}",
        "starred_url": "https://api.github.com/users/Nick3C/starred{/owner}{/repo}",
        "subscriptions_url": "https://api.github.com/users/Nick3C/subscriptions",
        "organizations_url": "https://api.github.com/users/Nick3C/orgs",
        "repos_url": "https://api.github.com/users/Nick3C/repos",
        "events_url": "https://api.github.com/users/Nick3C/events{/privacy}",
        "received_events_url": "https://api.github.com/users/Nick3C/received_events",
        "type": "User"
      },
      "labels": [
        {
          "id": 4,
          "node_id": "MDU6TGFiZWw0",
          "url": "https://api.github.com/repos/batterseapower/pinyin-toolkit/labels/bug",
          "name": "bug",
          "color": "ff0000"
        }
      ],
      "state": "open",
      "assignee": null,
      "milestone": null,
      "comments": 15,
      "created_at": "2009-07-12T20:10:41Z",
      "updated_at": "2009-07-19T09:23:43Z",
      "closed_at": null,
      "pull_request": {
        "html_url": null,
        "diff_url": null,
        "patch_url": null
      },
      "body": "...",
      "score": 1.3859273
    }
  ]
}
```

### 4.3、 高亮 issue 搜索结果
你或许希望在搜索结果中高亮关键字。
API 提供了额外的 metadata 支持这种做法。
在搜索请求中指定 `Accept: application/vnd.github.v3.text-match+json` 请求头。
例如：
```
curl -H 'Accept: application/vnd.github.v3.text-match+json' \
'https://api.github.com/search/issues?q=windows+label:bug+language:python+state:open&sort=created&order=asc'
```

这种请求和上一个例子返回相同的 JSON 结果，但是会在结果中附加一个 `text_matchs` 数组对象。
这个数组对象提供了搜索关键字在搜索结果中的位置信息，也包含 `property` 属性。

对于 issue 的搜索你能得到其 title，body和 comment body 属性。
关于 `text_matchs` 的更多信息请查阅：[match medadata](https://developer.github.com/v3/search/#text-match-metadata)

响应 
```json
{
  "text_matches": [
    {
      "object_url": "https://api.github.com/repositories/215335/issues/132",
      "object_type": "Issue",
      "property": "body",
      "fragment": "comprehensive windows font I know of).\n\nIf we can find a commonly distributed windows font that supports them then no problem (we can use html font tags) but otherwise the '(21)' style is probably better.\n",
      "matches": [
        {
          "text": "windows",
          "indices": [
            14,
            21
          ]
        },
        {
          "text": "windows",
          "indices": [
            78,
            85
          ]
        }
      ]
    },
    {
      "object_url": "https://api.github.com/repositories/215335/issues/comments/25688",
      "object_type": "IssueComment",
      "property": "body",
      "fragment": " right after that are a bit broken IMHO :). I suppose we could have some hack that maxes out at whatever the font does...\n\nI'll check what the state of play is on Windows.\n",
      "matches": [
        {
          "text": "Windows",
          "indices": [
            163,
            170
          ]
        }
      ]
    }
  ]
}
```