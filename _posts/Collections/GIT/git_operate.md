# 学习资源
1. https://www.liaoxuefeng.com/wiki/0013739516305929606dd18361248578c67b8067c8c017b000
2. [官方用例](https://git-scm.com/docs)

## 使用 SSH 操作 GIT
- https://help.github.com/articles/which-remote-url-should-i-use/#cloning-with-ssh-urls
- https://help.github.com/articles/connecting-to-github-with-ssh/




git status --all

git diff --cached   //查看变化

git commit --all    //提交到暂存区

git commit -m "注释语句"

git push -u origin master   //推数据





git pull origin master  //拉数据

git remote add origin https://github.com/hanhailong/CustomRatingBar     //关联远程库

## 一、 提交单个文件
git add filePath
git commit -m "message"
git push

## 二、 add 撤回
git rm
1. git rm --cached "文件路径"，不删除物理文件，仅将该文件从缓存中删除；
2. git rm --f  "文件路径"，不仅将该文件从缓存中删除，还会将物理文件删除（不会回收到垃圾桶）。

[更多信息可参考](https://stackoverflow.com/q/348170/7707781)

## 三、 commit 撤回
- `git reset --hard <commit_id>`
- `commit_id`使用 `git log` 查看

### 3.1 撤销 commite 但是不撤销 commite 之前对文件做的修改
```cmd
//查看自己想要回到哪一个 commite id
git log       

// 回到指定的 commit 并不删除涉及到的相关修改
git reset --soft <想回到的 commite id>  

// 撤销上一次 commit 并不删除 commite 之前的修改
git reset --soft HEAD~1
```

### 3.1、 [`commit` 换行](https://stackoverflow.com/questions/5064563/add-line-break-to-git-commit-m-from-the-command-line)

### 3.2. [commit 完成 没有 push , 想撤销暂存内容](https://stackoverflow.com/a/1505968/7707781)

```git
tom@TomdeMacBook-Pro ➜  nameless_carpool git:(main) ✗ git status 
位于分支 main
您的分支与上游分支 'origin/main' 一致。

尚未暂存以备提交的变更：
  （使用 "git add/rm <文件>..." 更新要提交的内容）
  （使用 "git restore <文件>..." 丢弃工作区的改动）
	修改：     README.MD
	删除：     src/json/json_util.cpp
	删除：     src/json/json_util.h
	删除：     src/json/model/user_json.cpp
	修改：     src/main.cpp
	修改：     src/utils/all_include.h
	修改：     src/utils/fcgi_util.h
	修改：     src/utils/http_util.h
	修改：     src/utils/input_check.cpp
	修改：     src/utils/input_check.h
	修改：     src/utils/log_utils.h

未跟踪的文件:
  （使用 "git add <文件>..." 以包含要提交的内容）
	src/utils/json/

修改尚未加入提交（使用 "git add" 和/或 "git commit -a"）
tom@TomdeMacBook-Pro ➜  nameless_carpool git:(main) ✗ git add --all 
tom@TomdeMacBook-Pro ➜  nameless_carpool git:(main) ✗ git status 
位于分支 main
您的分支与上游分支 'origin/main' 一致。

要提交的变更：
  （使用 "git restore --staged <文件>..." 以取消暂存）
	修改：     README.MD
	修改：     src/main.cpp
	修改：     src/utils/all_include.h
	修改：     src/utils/fcgi_util.h
	修改：     src/utils/http_util.h
	修改：     src/utils/input_check.cpp
	修改：     src/utils/input_check.h
	新文件：   src/utils/json/include_json.h
	重命名：   src/json/json_util.cpp -> src/utils/json/json_util.cpp
	重命名：   src/json/json_util.h -> src/utils/json/json_util.h
	重命名：   src/json/model/user_json.cpp -> src/utils/json/model/user_json.cpp
	修改：     src/utils/log_utils.h

tom@TomdeMacBook-Pro ➜  nameless_carpool git:(main) ✗ git reset HEAD README.MD
重置后取消暂存的变更：
M	README.MD
tom@TomdeMacBook-Pro ➜  nameless_carpool git:(main) ✗ git status 
位于分支 main
您的分支与上游分支 'origin/main' 一致。

要提交的变更：
  （使用 "git restore --staged <文件>..." 以取消暂存）
	修改：     src/main.cpp
	修改：     src/utils/all_include.h
	修改：     src/utils/fcgi_util.h
	修改：     src/utils/http_util.h
	修改：     src/utils/input_check.cpp
	修改：     src/utils/input_check.h
	新文件：   src/utils/json/include_json.h
	重命名：   src/json/json_util.cpp -> src/utils/json/json_util.cpp
	重命名：   src/json/json_util.h -> src/utils/json/json_util.h
	重命名：   src/json/model/user_json.cpp -> src/utils/json/model/user_json.cpp
	修改：     src/utils/log_utils.h

尚未暂存以备提交的变更：
  （使用 "git add <文件>..." 更新要提交的内容）
  （使用 "git restore <文件>..." 丢弃工作区的改动）
	修改：     README.MD

tom@TomdeMacBook-Pro ➜  nameless_carpool git:(main) ✗ git reset HEAD .        
重置后取消暂存的变更：
M	README.MD
D	src/json/json_util.cpp
D	src/json/json_util.h
D	src/json/model/user_json.cpp
M	src/main.cpp
M	src/utils/all_include.h
M	src/utils/fcgi_util.h
M	src/utils/http_util.h
M	src/utils/input_check.cpp
M	src/utils/input_check.h
M	src/utils/log_utils.h
tom@TomdeMacBook-Pro ➜  nameless_carpool git:(main) ✗ git status 
位于分支 main
您的分支与上游分支 'origin/main' 一致。

尚未暂存以备提交的变更：
  （使用 "git add/rm <文件>..." 更新要提交的内容）
  （使用 "git restore <文件>..." 丢弃工作区的改动）
	修改：     README.MD
	删除：     src/json/json_util.cpp
	删除：     src/json/json_util.h
	删除：     src/json/model/user_json.cpp
	修改：     src/main.cpp
	修改：     src/utils/all_include.h
	修改：     src/utils/fcgi_util.h
	修改：     src/utils/http_util.h
	修改：     src/utils/input_check.cpp
	修改：     src/utils/input_check.h
	修改：     src/utils/log_utils.h

未跟踪的文件:
  （使用 "git add <文件>..." 以包含要提交的内容）
	src/utils/json/

修改尚未加入提交（使用 "git add" 和/或 "git commit -a"）
tom@TomdeMacBook-Pro ➜  nameless_carpool git:(main) ✗ 

```


## 四、 clone 指定分支


## 五、 创建分支
```git
查看分支：git branch

创建分支：git branch <name>

切换分支：git checkout <name>

创建+切换分支：git checkout -b <name>

合并某分支到当前分支：git merge <name>

删除分支：git branch -d <name>
```
### 5.1、 示例
1. 本地 git
2. 远程服务器 github
3. 实践之前先将当前本地内容推送到远程服务器 `git push` 确保当前本地和远程文件无异
    - 本例中本次提交的 hash ： **`3e2f85b(后略)`** 

#### 5.1.1、 创建分支
```
git branch dev
```

#### 5.1.2、 选定 dev 分支
```
git branch checkout dev
```

#### 5.1.3、 在 dev 分支进行文件修改并 push 修改

首次在本地通过命令创建分支并且修改文件内容后，尝试在新的分支 git push 会失败
```
$ git push 
warning: push.default is unset; its implicit value has changed in
Git 2.0 from 'matching' to 'simple'. To squelch this message
and maintain the traditional behavior, use:

  git config --global push.default matching

To squelch this message and adopt the new behavior now, use:

  git config --global push.default simple

When push.default is set to 'matching', git will push local branches
to the remote branches that already exist with the same name.

Since Git 2.0, Git defaults to the more conservative 'simple'
behavior, which only pushes the current branch to the corresponding
remote branch that 'git pull' uses to update the current branch.

See 'git help config' and search for 'push.default' for further information.
(the 'simple' mode was introduced in Git 1.7.11. Use the similar mode
'current' instead of 'simple' if you sometimes use older versions of Git)

fatal: The current branch dev has no upstream branch.//未建立上游(远程)分支
To push the current branch and set the remote as upstream, use//设置上游分支并且 push 当前内容使用下述命令：

    git push --set-upstream origin dev
```

这是因为我们在本地创建了 dev 分支而服务器上尚无 dev 分支所以 push 失败。
通过下述命令一步，即完成了服务端分支 dev 的创建，又完成了已修改内容的 push 操作。
```
git push --set-upstream origin dev
```

#### 5.1.3、 进入 master 分支
```
git checkout master
```

#### 5.1.4、 将 dev 分支合并到 master 分支
```
$ git merge dev
Updating 3e2f85b..d6746a2
Fast-forward
 .../src/main/java/com/farbox/androidbyeleven/Utils/HttpUtil_1.java         | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)
```
解释：
1. `3e2f85b` 是 master 最后一次提交的 hash 。 
2. `d6746a2` 是 dev 最后一次提交的 hash 。
3. `3e2f85b..d6746a2` 意味着将 master 最后一次提交的内容，变更为 dev 最后一次提交的内容，由于我们没有在修改 dev 的同时修改 master 所以没有冲突

到现在本地 git 操作已经完成，但是在在 github 依然观察不到文件变化。
那是因为本次操作尚未推动到服务器 

#### 5.1.5、 将 merge 推送到服务器
当前在 master 分支
```
$ git push
To https://********************.git
   3e2f85b..d6746a2  master -> master   //将本地 master 的变化 `3e2f85b..d6746a2` 推送到(->) 服务器的 master 分支
```

#### 5.1.6、 merge 失败，请先解决冲突
当冲突解决完成还有再次 merge 提示：
```
error: Merging is not possible because you have unmerged files.
hint: Fix them up in the work tree, and then use 'git add/rm <file>'
hint: as appropriate to mark resolution and make a commit.
fatal: Exiting because of an unresolved conflict.

===========================================================
Solution:
===========================================================
git add .
git commite --message"OVER"
```


### 5.2、 如果创建了 dev 分支并且做出了修改，最终要舍弃 dev 分支如何操作(不删除)
当前的背景
1. master 分支被全部 push 到服务器了
2. 创建了新 branch ： dev
3. dev 中对大量文件进行了修改，经过测试决定暂不使用这个分支中修改的内容，继续使用 master 中的内容

我们需要做的事情是
1. dev 中的内容全部 push 到服务器
2. 进入 master 分支
3. git pull 将 master 的内容同步到本机
4. 至此即达到目的了


## git log

`git log --oneline --graph --decorate origin/master `

`--oneline` : 日志限制在一行展示
`--graph` : 用图表📈的形式展示 , 设置了这个选项会有分支线
`--decorate origin/master` : 限定打印指定分支的日志


## 六. 新知识点需要补充自己的储备



拆解 git push 动作 : `git push origin HEAD:refs/for/release-3.0.4`
- https://git-scm.com/docs/git-push#Documentation/git-push.txt-codegitpushoriginHEADcode
- [还是要自己操作观察下才了解这个过程的细节](https://segmentfault.com/a/1190000007748862)


`git rebase` 作用 , 以及它和 `git merge` 的区别 ; 
当提交过多次 `commit` 的时候我们或许更希望 `rebase` 动作 而不是直接 `merge` .


**合并多个修改**

分支状态
```
          A---B---C topic
         /
    D---E---F---G master
```

```
# 合并动作不包含 E 提交 , 只和并 ABC 三次修改
(topic)$ git rebase --interactive E提交对应的hash 
# (topic)$ git rebase --interactive HEAD~3
# ABC 三个提交被合并为一个提交并
```

```
          A---B---C 
         /
    D---E---F---G master
         \
          ---------D topic
```

```
(master)$ git merge topic
# 合并分支
```



## [git cherry-pick 教程](http://www.ruanyifeng.com/blog/2020/04/git-cherry-pick.html)


1. 摘取一个提交
2. 摘取一个提交中的某个文件
3. 摘取连续的提价 `git cherry-pick dd2d2414(含)^..dd557299(含)`


## [git remote](https://git-scm.com/book/zh/v2/Git-基础-远程仓库的使用)

参考 : http://www.ruanyifeng.com/blog/2014/06/git_remote.html
  
新创建仓库的时候 , 
1. 远端创建仓库完成
2. 本地 
	 - `git init`
	 - `git remote add <主机名> <网址>`
		```
		➜ git init 
		➜ git remote add origin git@github.com:TomGarden/QtStyleWidget.git            
		➜ git remote show        
		origin
		➜ git remote add otherName http://username@ip:port/QtStyleWidget.git
		➜ git remote show 
		origin
		otherName
		➜ git add .
		➜ git commit --message="init"  
		➜ git push origin master && git push otherName master
		```



### 解决冲突过程中 AndroidStudio 视图含义



## --amend 用法



