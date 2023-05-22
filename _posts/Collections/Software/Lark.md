https://bytedance.feishu.cn/space/doc/2jn50C2nPN5z3oPOvYjtCd

### Lark APT Repository

- Lark linux version is only a personally maintained version
- Any bugfix will publish later than other OS
- If you meet a bug, please contact us

**mailto:chenfuchun@bytedance.com**

## 飞书 Linux 版本安装指引
本文档适用于 Ubuntu Linux (其他发行版请看文档结尾)
- 基于 Ubuntu 的 debian 软件安装体系，飞书在 Ubuntu 下使用 APT 仓库的方式提供更新，本文档会随着飞书的升级及时更新
安装步骤
- 安装 deb 软件包需要添加 APT 软件仓库，官方提供两种方式添加仓库：GUI 与直接编辑软件仓库清单，本文档建议使用直接编辑软件清单的方式实现，具体步骤如下：

1. 打开系统的终端，输入如下指令：
  1.   sudo gedit /etc/apt/sources.list
2. 滑动到最底部，添加一行并输入如下内容：
  1.   deb [trusted=yes] https://download.zjurl.cn/ubuntu/binary-amd64 /
  2. 请注意，内容包含空格等字符，建议直接复制粘贴，不要遗漏结尾的斜线
3. 打开自带的软件商店，搜索 lark ，并安装
4. 当且仅当步骤 3 不生效的时候，可以采用如下方式
  1. 打开系统的终端应用，输入如下内容：  sudo apt update
  2. 等待指令运行结束，输入如下内容：  sudo apt -y install lark

- 之后的更新会发布在这个软件仓库内，Lark 的设置页面会有红色的新版本提示，Ubuntu 的系统也会自动检查飞书的更新并提醒

疑问解答
- Linux 版本属于测试版本，所以相对于 macOS / Windows ，更新与修复相对会慢一些
- 如果遇到 Ubuntu 18.04 以上版本没有状态栏图标的情况，请参考以下解决方案：
  - https://extensions.gnome.org/extension/495/topicons/
- Linux 版本截图使用 gnome-screenshot 截图工具，如果没有请自行安装；测试发现并不是每个用户都能使用，如有需要可换其他截图工具
- 其它 Linux 发行版，可以联系我们，我们会提供通用绿色安装包，绿色安装包不具备自动功能
- 如有其它疑问，也请联系我们
绿色安装版(tgz 包)
请访问 https://download.zjurl.cn/ubuntu/ 获取


### 评论
编写了针对 Arch Linux 系发行版的打包脚本（https://code.byted.org/erinacio.liu/lark-archlinux），请问是否可以将其上传至 Arch User Repository 中？