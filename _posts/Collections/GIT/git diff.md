### git 命令确定某次 commit 所做的对文件的：增、删、改

- [关于 git 操作](https://git-scm.com/docs):本项目着重用到的内容为
    - [git diff --raw](https://git-scm.com/docs/git-diff#Documentation/git-diff.txt---raw)
        - [（git diff --raw）Raw output format](https://git-scm.com/docs/git-diff#_raw_output_format)
    

最终要校验的 命令

```terminate
git diff --raw -z dcc69f47 a423e179

:100644 000000 79aae52 0000000 D^@.github/document/work_flow_chat.gliffy^@
:100644 000000 e69de29 0000000 D^@.github/document/关于 python 语法.md^@
:100755 100755 3026a7e 3026a7e R100^@.github/github_actions/install_dependence_macos.sh^@.github/github_actions/dependence.sh^@
:000000 100644 0000000 8dbea11 A^@.github/github_actions/test_shell.sh^@
:100644 100644 2b06819 74fc145 M^@.github/workflows/github_generate.yml^@
:000000 100644 0000000 a5a86b9 A^@.github/workflows/github_generate_copy.yml^@
:100644 100644 f10eb4a 3caceb7 M^@.github/workflows/self_host.yml^@
:100644 100644 c641ec6 8a08550 M^@README.md^@
```

关于 [git diff 文档中提到的多个 src 和多个 dst 的情况是这样的](https://git-scm.com/docs/git-diff#_diff_format_for_merges) :
(理论上还可以更多更长...) 
```terminate
git diff --raw a423e179 1c64755a 4432e49c 9a24fc6a

:::100644 100644 100644 000000 7e2ec23 7e2ec23 7e2ec23 0000000 DDD      .github/document/work_flow_chat.gliffy
:::100644 100644 100644 000000 e69de29 e69de29 e69de29 0000000 DDD      ".github/document/\345\205\263\344\272\216 python \350\257\255\346\263\225.md"
:::100755 100755 100755 100755 3026a7e 3026a7e 3026a7e 3026a7e RRR      .github/github_actions/dependence.sh
:::000000 000000 000000 100644 0000000 0000000 0000000 8dbea11 AAA      .github/github_actions/test_shell.sh
:::100644 100644 100644 100644 2b06819 2b06819 2b06819 74fc145 MMM      .github/workflows/github_generate.yml
:::000000 000000 000000 100644 0000000 0000000 0000000 a5a86b9 AAA      .github/workflows/github_generate_copy.yml
:::100644 100644 100644 100644 f10eb4a f10eb4a f10eb4a 3caceb7 MMM      .github/workflows/self_host.yml
:::100644 100644 100644 100644 79e54e9 79e54e9 79e54e9 8a08550 MMM      README.md
:::100644 100644 100644 000000 7b3b62b 9179b62 d650303 0000000 DDD      posts/add one file.md
```





文件 sha1 值命名是 40 位，为什么这里只有 6 位


