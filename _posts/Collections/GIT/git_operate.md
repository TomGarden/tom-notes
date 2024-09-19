# TomYeo : 避免编译优化 , 同时避免编译失败# 学习资源
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

### 5.3. [How to create a local branch from an existing remote branch](https://stackoverflow.com/a/48840672/7707781)
```sh
git checkout -b branch_name --track origin/branch_name
```

这条指令 `git checkout -b branch_name --track origin/branch_name` 在 Git 中用于创建一个新的本地分支，并将其与远程仓库中的同名分支进行关联。

让我们逐步解释这条指令的各个部分：

- `git checkout`: 这部分指定了要执行的 Git 命令，即切换分支或恢复工作树文件。

- `-b branch_name`: 这个选项告诉 Git 创建一个新的分支，并为该分支指定一个名称。`branch_name` 是你想要创建的新分支的名称。

- `--track origin/branch_name`: 这个部分告诉 Git 要与指定的远程分支进行跟踪关联。`origin/branch_name` 是远程仓库中的分支名称。通过这个选项，Git 将会在本地创建一个新分支，并将其设置为跟踪指定的远程分支。

综合起来，执行这条指令后，Git 会完成以下操作：

1. 创建一个新的本地分支，名称为 `branch_name`。
2. 从远程仓库中跟踪关联指定的分支 `origin/branch_name`。
3. 切换到新创建的分支，以便你可以在这个新分支上进行工作。

这个命令通常用于在开始开发新功能或修复错误时创建新的分支，并在远程仓库中保持相应的分支结构。


## git log

`git log --oneline --graph --decorate origin/master `

`--oneline` : 日志限制在一行展示
`--graph` : 用图表📈的形式展示 , 设置了这个选项会有分支线
`--decorate origin/master` : 限定打印指定分支的日志

```sh
git log --date=iso8601 --author="mail or userName" --graph --all

* commit d07cc8b5a4dd1194ef8a3e591545964ea5842a46 (remote/dev/TomYeo/editing, dev/TomYeo/editing)
| Author: UserName <mail path>
| Date:   2024-05-09 10:56:16 +0800
|
|     comment update

# --date=iso8601 指定日期格式(Date:   2024-05-09 10:56:16 +0800) , 详细内容参看文档吧 
# --author : 限定值展示某个作者相关的 commit 节点
# --graph : 用图表📈的形式展示 , 设置了这个选项会有分支线
# --all : 所有分支
```


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
3. 摘取连续的提交 `git cherry-pick dd2d2414(含)^..dd557299(含)`


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




## 将文件从历史中移除
将历史提交中的某些文件彻底移除 , 就像他们从来没有存在过一样
- `git filter-repo --invert-paths --path .gradle --force`



## 提交 MregeRequest ; 针对 gitlab 

git push -o merge_request.create -o merge_request.target=main \
         -o merge_request.title="写下此次合并的内容概述"
https://guoxudong.io/post/gitlab-push-create-mr/


## git diff

参考 内容
1. https://stackoverflow.com/a/19905870/7707781
2. https://stackoverflow.com/a/7669970/7707781

```sh
git diff				# 单文件 带有加减号 标识
git diff --word-diff	# 单文件 , 效果上会好些 , 只是还不能展示行号
git difftool --no-prompt  --tool=vimdiff
# 左右两个文件对比 , 带行号
# --no-prompt 用于取消对比文件前的手动确认动作 , 不需要可以不用
# --tool      可以不用添加 , 一般默认是 vimdiff , 可以通过 git difftool --tool-help 查看其他可用工具
```


## 十一. 对于占用磁盘空间过大的仓库(未验证/删除仓库使用浅克隆解决了)
当前我们面临的情况是
1. 本地 磁盘 500G 占用完毕 . 
   1. 最简单的方式自然还是 , 把电脑硬盘省纪委 8T . 花点钱就好了
   2. 但是我们没办法完成上述操作 . 
2. 我们在管理的项目中 , 选择一个不常常操作的项目 , 在本 删除 历史节点的跟踪
   1. ```shell
		假设当前远程分支 有这些提交 , 本地分支跟远程分支同步 . 
		A -- B -- C -- D -- E -- F -- G -- H -- I -- J (HEAD)

		我希望本地只保留 最近 3 次提交 , 之前的内容删除,用于 节省本地磁盘空间
		- -- - -- - -- - -- - -- - -- - -- H -- I -- J (HEAD)

		我该怎么操作 , 逐步详细讲解下
   	  ```
3. `git reset --hard HEAD~3`
   1. 这条命令会把你的本地分支重置为最近的 3 次提交，把 HEAD 指针移动到 HEAD~3，即 H 提交。同时，它会丢弃之前的提交记录，包括 A 到 G 提交的所有历史和修改。
4. 虽然你已经删除了旧的提交记录，但这些提交在 Git 数据库中仍然存在。为了释放磁盘空间，你需要通过清理命令删除旧的 Git 对象：
   1. ```shell
		git reflog expire --expire=now --all 
			# Reflog（参考日志）是 Git 中的一个内部机制，它记录了你在仓库中所有 HEAD 指针的移动操作。
			# 即使是提交被回滚、重置或者分支被删除等情况下，reflog 也可以记录这些操作。
			# 它是 Git 恢复丢失提交的重要工具。
			#
			# git reflog expire： 这个子命令用于标记并清除 Git 中的过期 reflog 记录。
			#
			# --expire=now： 这个选项指定了一个时间点，告诉 Git 应该删除哪些 reflog 记录。
			# 			     now 表示立即过期所有记录，无论它们的创建时间是什么时候。
			#
			# --all： 这个选项表示对仓库中的所有分支和引用（例如 HEAD、分支、远程分支等）执行清理。
			# 		  也就是说，--all 会清理所有分支的 reflog，而不仅仅是当前分支的。
			#
			# 这个命令会永久删除 reflog 中的记录，删除后将无法找回这些历史提交。

		git gc --prune=now --aggressive
			# git gc（Garbage Collection，垃圾回收）是 Git 中的一个维护工具，
			# 用于整理和优化存储在 .git 目录中的数据，主要功能包括：
			#	->清理无用的对象（例如被删除的分支或提交）。
			#	->合并多个 "松散对象"（loose objects）为一个 "打包对象"（pack file），提高访问效率。
			#	->压缩数据，以减少磁盘空间的占用。
			#
			# --prune=now：立即删除未引用的对象
			# --aggressive 参数是让 git gc 以更彻底的方式进行打包和压缩。
			#			   相比于默认的 git gc，--aggressive 会花费更多的时间和资源来优化 Git 仓库。
	  ```	
5. 执行上述操作后  如果 希望在此与 远程分支 同步
   1. ```shell
		# 这会将远程分支的最新状态（包括所有提交历史）下载到本地，但是不会影响当前的本地分支。
		git fetch origin

		# 这将使你的本地分支完全同步到远程分支 origin/main 的状态。
		# 无论你本地之前做了哪些修改，都会被覆盖为远程分支的最新状态，包括之前被你删除的提交历史。
		git reset --hard origin/main

		# 这会将远程分支上的最新提交合并到本地。确保本地分支拉取到最新的提交。
		git pull origin main
	  ```

### 11.1. 没有及时识别 浅克隆项目

由于没有识别到仓库是浅克隆仓库 ,  push 动作总是失败 : 

```shell
# tom @ TomPc in /Volumes/Beyourself/AOSP/android-6.0.0_r1/device/lge/repo_name on git:dev/TomYeo/2024-03-19 x [16:38:01] C:1
$ git push remote_name
枚举对象中: 6, 完成.
对象计数中: 100% (6/6), 完成.
使用 12 个线程进行压缩
压缩对象中: 100% (4/4), 完成.
写入对象中: 100% (6/6), 6.98 MiB | 1.34 MiB/s, 完成.
总共 6（差异 0），复用 0（差异 0），包复用 0（来自  0 个包）
remote: fatal: did not receive expected object e32dafe146c6155a817eabcf22de1c2b7fa768f9
错误：远程解包失败：index-pack failed
To github.com:my_org/repo_name.git
 ! [remote rejected] dev/TomYeo/2024-03-19 -> dev/TomYeo/2024-03-19 (failed)
错误：无法推送一些引用到 'github.com:my_org/repo_name.git'
```


判断当前项目是否浅克隆仓库
```shell
# git 1.15+
git rev-parse --is-shallow-repository
```

将浅克隆仓库 切换为常规仓库 : `git fetch --unshallow`