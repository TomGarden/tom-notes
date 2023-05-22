仓库相关的配置也是在这个文件夹才生效
1. [多个远程仓库, 如何自动设置不同邮箱或用户名](https://www.ofcss.com/2020/02/17/auto-config-user-name-email-for-different-remote-repository.html)
2. [以上方法使用到的其实是 git 本身的 "Conditional Includes" 功能](https://git-scm.com/docs/git-config#_conditional_includes)




```.gitconfig
# 总的配置文件信息
# 文件路径 ~/.gitconfig

# space_ssd/_document
[includeIf "gitdir:/media/tom/space_ssd/_document/"]
   path = /media/tom/space_ssd/_document/.gitconfig_for_tom
```


```
# 特定目录下的配置信息
# 文件路径 ： /media/tom/space_ssd/_document/.gitconfig_for_tom
[user]
    email = tom.work@foxmail.com
    name = Tom
```