---
layout: post
title:  null
date:   2018-08-15 16:50:43 +0800
categories: jekyll update
author: Tom
---

-----------------------------
__目录__
- jekyll 的 kmarkdown 负责解析
{:toc}

-----------------------------
<br>

# GitHub Developer · REST API v3  >>>  Issues
原文：
1. https://developer.github.com/v3/issues/
2. https://developer.github.com/v3/issues/comments/

Issues 使用 [自定义媒体类型](https://developer.github.com/v3/issues/#custom-media-types)。
你能在 [API](https://developer.github.com/v3/media/) 中读到关于媒体类型的更多细节。

## 一、 Issues 列表
> **Note:** 现在你可以再 label name 中使用 emoji，为 label 增加描述，并且可以再 repository 中搜索 label 。
[ blog post ](https://developer.github.com/changes/2018-02-22-label-description-search-preview)中有更多细节。
要访问这些特征并且在预览期接收 payloads ，你必须在 `Accept` 头信息中提供自定义 [meida type](https://developer.github.com/v3/media)。
>```
>application/vnd.github.symmetra-preview+json
>```

> **Warning：** 在预览期 API 或许会发生改变，并且不会提前通知开发者。
生产环境中不支持预览功能。
如果你遇到了任何问题请联系 [GitHub support](https://github.com/contact)

列出认证用户可见的所有分配给自己的 issues ，包括其自己的 repositories ，成员的 repositories 和 组织的 repositories 。
你可以使用 `filter` 查询参数获取不一定分配给自己的 issues 。
[Parameters 列表](https://developer.github.com/v3/issues/#parameters)中有更多信息。
```
GET /issues
```

认证用户列出自己的和成员的 repositories 中分配给自己的 issues ：
```
GET /user/issues
```

认证用户列出所有组织中分配给自己的 issues ：
```
GET /orgs/:org/issues
```

> **Note:**  REST API v3 考虑到每一个 pull 请求都是一个 Issues，但是并非每一个 issue 都是一个 pull 请求。
因为这个原因，”issues“ 端点或许在响应中返回包含 issues 和 pull 请求的两种信息。
你可以通过 `pull_request` 关键字确认 pull 请求。

>注意向”Issues“端点的 pull 请求的返回信息中的 `id` 是一个 issue id 。
要查找 pull 请求 id ，使用 ”[List pull requests](https://developer.github.com/v3/pulls/#list-pull-requests)“ 端点。

### 1.1、 参数
|Name|Type|Description|
|----|----|-----------|
|filter|string|指示要返回的 issues 类型。可以是一下几种之一：<br> * `assigned`:分配给你的 issues 。<br>* `created`你创建的 Issues。 <br>* `mentioned`:提及你的 issuts 。<br>* `subscribed`:你订阅更新的 issues 。 <br>* `all`：作为认证用户可见的所有 issues ，无论是参与还是创建。<br>* 默认情况下：`assigned`|
|state|string|指示返回 issues 的状态。可能是 `open` `close` 或者 `all`。默认：`open`。|
|labels|string|逗号分隔的标签列表。例如：`bug,ui,@high`|
|sort|string|返回的 issues 类型。可以是 `created`,`updated`,`comments`。默认是`created`。|
|direction|string|排序的方向。可以是 `asc` 或者 `desc`。默认是 `desc`。|
|since|string|仅代表在这个返回的时间或其后进行的更新。这是一个 ISO 8601 格式的时间戳`YYYY-MM-DDTHH:MM:SSZ`。|

### 1.2、 响应
```json
Status: 200 OK
Link: <https://api.github.com/resource?page=2>; rel="next",
      <https://api.github.com/resource?page=5>; rel="last"
------------------------------------------------------------------------
[
  {
    "id": 1,
    "node_id": "MDU6SXNzdWUx",
    "url": "https://api.github.com/repos/octocat/Hello-World/issues/1347",
    "repository_url": "https://api.github.com/repos/octocat/Hello-World",
    "labels_url": "https://api.github.com/repos/octocat/Hello-World/issues/1347/labels{/name}",
    "comments_url": "https://api.github.com/repos/octocat/Hello-World/issues/1347/comments",
    "events_url": "https://api.github.com/repos/octocat/Hello-World/issues/1347/events",
    "html_url": "https://github.com/octocat/Hello-World/issues/1347",
    "number": 1347,
    "state": "open",
    "title": "Found a bug",
    "body": "I'm having a problem with this.",
    "user": {
      "login": "octocat",
      "id": 1,
      "node_id": "MDQ6VXNlcjE=",
      "avatar_url": "https://github.com/images/error/octocat_happy.gif",
      "gravatar_id": "",
      "url": "https://api.github.com/users/octocat",
      "html_url": "https://github.com/octocat",
      "followers_url": "https://api.github.com/users/octocat/followers",
      "following_url": "https://api.github.com/users/octocat/following{/other_user}",
      "gists_url": "https://api.github.com/users/octocat/gists{/gist_id}",
      "starred_url": "https://api.github.com/users/octocat/starred{/owner}{/repo}",
      "subscriptions_url": "https://api.github.com/users/octocat/subscriptions",
      "organizations_url": "https://api.github.com/users/octocat/orgs",
      "repos_url": "https://api.github.com/users/octocat/repos",
      "events_url": "https://api.github.com/users/octocat/events{/privacy}",
      "received_events_url": "https://api.github.com/users/octocat/received_events",
      "type": "User",
      "site_admin": false
    },
    "labels": [
      {
        "id": 208045946,
        "node_id": "MDU6TGFiZWwyMDgwNDU5NDY=",
        "url": "https://api.github.com/repos/octocat/Hello-World/labels/bug",
        "name": "bug",
        "description": "Houston, we have a problem",
        "color": "f29513",
        "default": true
      }
    ],
    "assignee": {
      "login": "octocat",
      "id": 1,
      "node_id": "MDQ6VXNlcjE=",
      "avatar_url": "https://github.com/images/error/octocat_happy.gif",
      "gravatar_id": "",
      "url": "https://api.github.com/users/octocat",
      "html_url": "https://github.com/octocat",
      "followers_url": "https://api.github.com/users/octocat/followers",
      "following_url": "https://api.github.com/users/octocat/following{/other_user}",
      "gists_url": "https://api.github.com/users/octocat/gists{/gist_id}",
      "starred_url": "https://api.github.com/users/octocat/starred{/owner}{/repo}",
      "subscriptions_url": "https://api.github.com/users/octocat/subscriptions",
      "organizations_url": "https://api.github.com/users/octocat/orgs",
      "repos_url": "https://api.github.com/users/octocat/repos",
      "events_url": "https://api.github.com/users/octocat/events{/privacy}",
      "received_events_url": "https://api.github.com/users/octocat/received_events",
      "type": "User",
      "site_admin": false
    },
    "assignees": [
      {
        "login": "octocat",
        "id": 1,
        "node_id": "MDQ6VXNlcjE=",
        "avatar_url": "https://github.com/images/error/octocat_happy.gif",
        "gravatar_id": "",
        "url": "https://api.github.com/users/octocat",
        "html_url": "https://github.com/octocat",
        "followers_url": "https://api.github.com/users/octocat/followers",
        "following_url": "https://api.github.com/users/octocat/following{/other_user}",
        "gists_url": "https://api.github.com/users/octocat/gists{/gist_id}",
        "starred_url": "https://api.github.com/users/octocat/starred{/owner}{/repo}",
        "subscriptions_url": "https://api.github.com/users/octocat/subscriptions",
        "organizations_url": "https://api.github.com/users/octocat/orgs",
        "repos_url": "https://api.github.com/users/octocat/repos",
        "events_url": "https://api.github.com/users/octocat/events{/privacy}",
        "received_events_url": "https://api.github.com/users/octocat/received_events",
        "type": "User",
        "site_admin": false
      }
    ],
    "milestone": {
      "url": "https://api.github.com/repos/octocat/Hello-World/milestones/1",
      "html_url": "https://github.com/octocat/Hello-World/milestones/v1.0",
      "labels_url": "https://api.github.com/repos/octocat/Hello-World/milestones/1/labels",
      "id": 1002604,
      "node_id": "MDk6TWlsZXN0b25lMTAwMjYwNA==",
      "number": 1,
      "state": "open",
      "title": "v1.0",
      "description": "Tracking milestone for version 1.0",
      "creator": {
        "login": "octocat",
        "id": 1,
        "node_id": "MDQ6VXNlcjE=",
        "avatar_url": "https://github.com/images/error/octocat_happy.gif",
        "gravatar_id": "",
        "url": "https://api.github.com/users/octocat",
        "html_url": "https://github.com/octocat",
        "followers_url": "https://api.github.com/users/octocat/followers",
        "following_url": "https://api.github.com/users/octocat/following{/other_user}",
        "gists_url": "https://api.github.com/users/octocat/gists{/gist_id}",
        "starred_url": "https://api.github.com/users/octocat/starred{/owner}{/repo}",
        "subscriptions_url": "https://api.github.com/users/octocat/subscriptions",
        "organizations_url": "https://api.github.com/users/octocat/orgs",
        "repos_url": "https://api.github.com/users/octocat/repos",
        "events_url": "https://api.github.com/users/octocat/events{/privacy}",
        "received_events_url": "https://api.github.com/users/octocat/received_events",
        "type": "User",
        "site_admin": false
      },
      "open_issues": 4,
      "closed_issues": 8,
      "created_at": "2011-04-10T20:09:31Z",
      "updated_at": "2014-03-03T18:58:10Z",
      "closed_at": "2013-02-12T13:22:01Z",
      "due_on": "2012-10-09T23:39:01Z"
    },
    "locked": true,
    "active_lock_reason": "too heated",
    "comments": 0,
    "pull_request": {
      "url": "https://api.github.com/repos/octocat/Hello-World/pulls/1347",
      "html_url": "https://github.com/octocat/Hello-World/pull/1347",
      "diff_url": "https://github.com/octocat/Hello-World/pull/1347.diff",
      "patch_url": "https://github.com/octocat/Hello-World/pull/1347.patch"
    },
    "closed_at": null,
    "created_at": "2011-04-22T13:33:48Z",
    "updated_at": "2011-04-22T13:33:48Z",
    "repository": {
      "id": 1296269,
      "node_id": "MDEwOlJlcG9zaXRvcnkxMjk2MjY5",
      "name": "Hello-World",
      "full_name": "octocat/Hello-World",
      "owner": {
        "login": "octocat",
        "id": 1,
        "node_id": "MDQ6VXNlcjE=",
        "avatar_url": "https://github.com/images/error/octocat_happy.gif",
        "gravatar_id": "",
        "url": "https://api.github.com/users/octocat",
        "html_url": "https://github.com/octocat",
        "followers_url": "https://api.github.com/users/octocat/followers",
        "following_url": "https://api.github.com/users/octocat/following{/other_user}",
        "gists_url": "https://api.github.com/users/octocat/gists{/gist_id}",
        "starred_url": "https://api.github.com/users/octocat/starred{/owner}{/repo}",
        "subscriptions_url": "https://api.github.com/users/octocat/subscriptions",
        "organizations_url": "https://api.github.com/users/octocat/orgs",
        "repos_url": "https://api.github.com/users/octocat/repos",
        "events_url": "https://api.github.com/users/octocat/events{/privacy}",
        "received_events_url": "https://api.github.com/users/octocat/received_events",
        "type": "User",
        "site_admin": false
      },
      "private": false,
      "html_url": "https://github.com/octocat/Hello-World",
      "description": "This your first repo!",
      "fork": false,
      "url": "https://api.github.com/repos/octocat/Hello-World",
      "archive_url": "http://api.github.com/repos/octocat/Hello-World/{archive_format}{/ref}",
      "assignees_url": "http://api.github.com/repos/octocat/Hello-World/assignees{/user}",
      "blobs_url": "http://api.github.com/repos/octocat/Hello-World/git/blobs{/sha}",
      "branches_url": "http://api.github.com/repos/octocat/Hello-World/branches{/branch}",
      "collaborators_url": "http://api.github.com/repos/octocat/Hello-World/collaborators{/collaborator}",
      "comments_url": "http://api.github.com/repos/octocat/Hello-World/comments{/number}",
      "commits_url": "http://api.github.com/repos/octocat/Hello-World/commits{/sha}",
      "compare_url": "http://api.github.com/repos/octocat/Hello-World/compare/{base}...{head}",
      "contents_url": "http://api.github.com/repos/octocat/Hello-World/contents/{+path}",
      "contributors_url": "http://api.github.com/repos/octocat/Hello-World/contributors",
      "deployments_url": "http://api.github.com/repos/octocat/Hello-World/deployments",
      "downloads_url": "http://api.github.com/repos/octocat/Hello-World/downloads",
      "events_url": "http://api.github.com/repos/octocat/Hello-World/events",
      "forks_url": "http://api.github.com/repos/octocat/Hello-World/forks",
      "git_commits_url": "http://api.github.com/repos/octocat/Hello-World/git/commits{/sha}",
      "git_refs_url": "http://api.github.com/repos/octocat/Hello-World/git/refs{/sha}",
      "git_tags_url": "http://api.github.com/repos/octocat/Hello-World/git/tags{/sha}",
      "git_url": "git:github.com/octocat/Hello-World.git",
      "issue_comment_url": "http://api.github.com/repos/octocat/Hello-World/issues/comments{/number}",
      "issue_events_url": "http://api.github.com/repos/octocat/Hello-World/issues/events{/number}",
      "issues_url": "http://api.github.com/repos/octocat/Hello-World/issues{/number}",
      "keys_url": "http://api.github.com/repos/octocat/Hello-World/keys{/key_id}",
      "labels_url": "http://api.github.com/repos/octocat/Hello-World/labels{/name}",
      "languages_url": "http://api.github.com/repos/octocat/Hello-World/languages",
      "merges_url": "http://api.github.com/repos/octocat/Hello-World/merges",
      "milestones_url": "http://api.github.com/repos/octocat/Hello-World/milestones{/number}",
      "notifications_url": "http://api.github.com/repos/octocat/Hello-World/notifications{?since,all,participating}",
      "pulls_url": "http://api.github.com/repos/octocat/Hello-World/pulls{/number}",
      "releases_url": "http://api.github.com/repos/octocat/Hello-World/releases{/id}",
      "ssh_url": "git@github.com:octocat/Hello-World.git",
      "stargazers_url": "http://api.github.com/repos/octocat/Hello-World/stargazers",
      "statuses_url": "http://api.github.com/repos/octocat/Hello-World/statuses/{sha}",
      "subscribers_url": "http://api.github.com/repos/octocat/Hello-World/subscribers",
      "subscription_url": "http://api.github.com/repos/octocat/Hello-World/subscription",
      "tags_url": "http://api.github.com/repos/octocat/Hello-World/tags",
      "teams_url": "http://api.github.com/repos/octocat/Hello-World/teams",
      "trees_url": "http://api.github.com/repos/octocat/Hello-World/git/trees{/sha}",
      "clone_url": "https://github.com/octocat/Hello-World.git",
      "mirror_url": "git:git.example.com/octocat/Hello-World",
      "hooks_url": "http://api.github.com/repos/octocat/Hello-World/hooks",
      "svn_url": "https://svn.github.com/octocat/Hello-World",
      "homepage": "https://github.com",
      "language": null,
      "forks_count": 9,
      "stargazers_count": 80,
      "watchers_count": 80,
      "size": 108,
      "default_branch": "master",
      "open_issues_count": 0,
      "topics": [
        "octocat",
        "atom",
        "electron",
        "API"
      ],
      "has_issues": true,
      "has_projects": true,
      "has_wiki": true,
      "has_pages": false,
      "has_downloads": true,
      "archived": false,
      "pushed_at": "2011-01-26T19:06:43Z",
      "created_at": "2011-01-26T19:01:12Z",
      "updated_at": "2011-01-26T19:14:43Z",
      "permissions": {
        "admin": false,
        "push": false,
        "pull": true
      },
      "allow_rebase_merge": true,
      "allow_squash_merge": true,
      "allow_merge_commit": true,
      "subscribers_count": 42,
      "network_count": 0
    }
  }
]
```

### 1.3、 Reactions summary (反应概要)
>在 issue payload 中的 `reactions` 对象可以被开发者预览。
在预览期间，API 可能(在未通知开发者的情况下)发生变化。
请在 [blog post](https://developer.github.com/changes/2016-05-12-reactions-api-preview) 了解详细信息。
>
>要访问 API 你必须在 `Accept` 头中提供自定义的 [媒体类型](https://developer.github.com/v3/media) 。
>```
>application/vnd.github.squirrel-girl-preview
>```
>
>`rections`关键字将有如下的 payload，其中的 `url` 可以用于构建 API 位置用于[列出和创建 reactions](https://developer.github.com/v3/reactions)

```json
{
  "total_count": 5,
  "+1": 3,
  "-1": 1,
  "laugh": 0,
  "confused": 0,
  "heart": 1,
  "hooray": 0,
  "url": "https://api.github.com/repos/octocat/Hello-World/issues/1347/reactions"
}
```

### 1.4、 用户使用 integrations 打开 issues 
>**Note:** 在 issue payload 中的 `performed_via_github_app` 对象可以被开发者预览。
更多信息请查看 [相关博客](https://developer.github.com/changes/2016-09-14-Integrations-Early-Access) 。
>
>要访问这个 API 你必须在请求头 `Accept` 中提供自定义[媒体类型](https://developer.github.com/v3/media)：
>```
>application/vnd.github.machine-man-preview
>```

>**Note:** 如果通过一个 GitHub app 打开了一个 issue，则`performed_via_github_app` 关键字包含了该 GitHub app 的信息。

>**Warning:** 在预览期间 API 可能发生改变过并且不做任何通知。
预览功能在生产环境不被支持。
如果你遇到了任何问题，联系[GitHub support](https://github.com/contact)。

## 二、 列出一个 repository 的 issues(GitHub App 可用)
>**Note:** 现在你可以在 label name 中使用 emoji，为 label 增加描述，并且在 repository 中搜索 label。
有关于此[博客](https://developer.github.com/changes/2018-02-22-label-description-search-preview)有更详尽的描述。
在预览器件要访问这些特性并且接收携带数据的 payload ，你必须在 `Accept` 中提供自定义的 [媒体类型](https://developer.github.com/v3/media):
>```
>application/vnd.github.symmetra-preview+json
>```

>**Warning:** 预览期间的 API 可能发生改变并且不作出任何通知。
生产环境不支持预览特性。
如果你遇到任何问题请咨询[GitHub support](https://github.com/contact)。

```
GET /repos/:owner/:repo/issues
```

>**Note:** 后面的内容基本相同懒得写了，用到的时候再说。

## *** 、 略

## 四、 创建一个 Issue
>**Note:** 你可以在 label 中使用 emoji ，为 lobel 增加描述，并且可以在 repository 中检索 lable 。
有关于此，在 [blog](https://developer.github.com/changes/2018-02-22-label-description-search-preview) 中有更多细节。
在预览阶段要访问特征数据和接收 payload ，你必须在头信息中提供： `Accept`
>```
>application/vnd.github.symmetra-preview+json
>```

>**Warning:** 在预览期间 API 可能在不通知的情况下发生改变。
预览特征在生产环境不被支持。
如果你碰到任何问题请咨询 [GitHub support](https://github.com/contact)

任何用户可以访问的 repository 都可以创建一个 Issue：
```
POST /repos/:owner/:repo/issues
```

### 4.1、 参数
|Name|Type|Description|
|----|----|-----------|
|title|string|**必需。** issue 的标题|
|body|string|issue 的内容|
|assignee(代理人)|string|此问题应该被分配给的目标用户。*NOTE：只有具有 push 权限的用户才能为新建的 Issue 设置代理人。 否则这个属性也会被无声的丢弃。**已经弃用***|
|milestone(里程碑)|integer|这个数字(`number`)被关联到它的 Issue。*NOTE：只有具有 push 权限的用户才能为新建的 Issue 设置 milestone。 否则这个属性也会被无声的丢弃。* |
|labels|`array` <br> of <br> `strings`|label 和 issue 相关联。*NOTE:只有具有 push 权限的用户才能为新建的 Issue 设置 lable。 否则这个属性也会被无声的丢弃。*|
|assignees|`array` <br> of <br> `strings`|供用户分配给 issue 的登陆者。*NOTE：只有具有 push 权限的用户才能为新建的 Issue 设置代理人。*|

### 4.2、 例子
```json
curl -H 'Accept:application/vnd.github.symmetra-preview+json' --data '{"title": "The test from cURL.","body": "Operator is tom."}' -i -u TomGarden-2:**************************************** 'https://api.github.com/repos/TomGarden/Tetris/issues'
```

### 4.3、 Response
```json
Status: 201 Created
Location: https://api.github.com/repos/TomGarden/Tetris/issues/2

{
  "url": "https://api.github.com/repos/TomGarden/Tetris/issues/2",
  "repository_url": "https://api.github.com/repos/TomGarden/Tetris",
  "labels_url": "https://api.github.com/repos/TomGarden/Tetris/issues/2/labels{/name}",
  "comments_url": "https://api.github.com/repos/TomGarden/Tetris/issues/2/comments",
  "events_url": "https://api.github.com/repos/TomGarden/Tetris/issues/2/events",
  "html_url": "https://github.com/TomGarden/Tetris/issues/2",
  "id": 351536046,
  "node_id": "MDU6SXNzdWUzNTE1MzYwNDY=",
  "number": 2,
  "title": "The test from cURL.",
  "user": {
    "login": "TomGarden-2",
    "id": 42455493,
    "node_id": "MDQ6VXNlcjQyNDU1NDkz",
    "avatar_url": "https://avatars0.githubusercontent.com/u/42455493?v=4",
    "gravatar_id": "",
    "url": "https://api.github.com/users/TomGarden-2",
    "html_url": "https://github.com/TomGarden-2",
    "followers_url": "https://api.github.com/users/TomGarden-2/followers",
    "following_url": "https://api.github.com/users/TomGarden-2/following{/other_user}",
    "gists_url": "https://api.github.com/users/TomGarden-2/gists{/gist_id}",
    "starred_url": "https://api.github.com/users/TomGarden-2/starred{/owner}{/repo}",
    "subscriptions_url": "https://api.github.com/users/TomGarden-2/subscriptions",
    "organizations_url": "https://api.github.com/users/TomGarden-2/orgs",
    "repos_url": "https://api.github.com/users/TomGarden-2/repos",
    "events_url": "https://api.github.com/users/TomGarden-2/events{/privacy}",
    "received_events_url": "https://api.github.com/users/TomGarden-2/received_events",
    "type": "User",
    "site_admin": false
  },
  "labels": [

  ],
  "state": "open",
  "locked": false,
  "assignee": null,
  "assignees": [

  ],
  "milestone": null,
  "comments": 0,
  "created_at": "2018-08-17T10:09:05Z",
  "updated_at": "2018-08-17T10:09:05Z",
  "closed_at": null,
  "author_association": "NONE",
  "body": "Operator is tom.",
  "closed_by": null
}

```

## 五、 创建 comment
POST 
```
/repos/:owner/:repo/issues/:number/comments
```
Input
|Name|Type|Description|
|----|----|-----------|
|body|string|Required. The contents of the comment.|