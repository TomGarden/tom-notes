## git branch --help

来源： Linux > Terminal > git branch --help ↲

## NAME
```
git-branch - List, create, or delete branches
```

## SYNOPSIS
```
git branch [--color[=<when>] | --no-color] [-r | -a]
       [--list] [-v [--abbrev=<length> | --no-abbrev]]
       [--column[=<options>] | --no-column]
       [(--merged | --no-merged | --contains) [<commit>]] [--sort=<key>]
       [--points-at <object>] [<pattern>...]
git branch [--set-upstream | --track | --no-track] [-l] [-f] <branchname> [<start-point>]
git branch (--set-upstream-to=<upstream> | -u <upstream>) [<branchname>]
git branch --unset-upstream [<branchname>]
git branch (-m | -M) [<oldbranch>] <newbranch>
git branch (-d | -D) [-r] <branchname>...
git branch --edit-description [<branchname>]
```

## DESCRIPTION

如果使用了 --list 选项，或者没有使用任何选项，将会列出所有的 branch；当前 branch 将会以 `*` 开头并高亮显示。
选项 -r 用于列出远程(remote-tracking) branch，选项 -a 列出所有的(包括本地和远程) branch 。
如果给定了 `<pattern>` ，它将被作为 shell 通配符去显示匹配的 branch 。
如果给定了多个 `<pattern>` ，只有同时匹配多个 `<pattern>` 的 branch 才会被显示。
注意，如果使用了 `<pattern>` ，你必须使用 --list ；其他情况命令将被理解为创建 branch 。

使用 --contains ，仅显示包含 commit 字段的 branch(换句话说，)