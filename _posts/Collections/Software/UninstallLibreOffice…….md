# 卸载 Ubuntu 预装的 LibreOffice 系列软件

拟使用 dpkg 完成这一卸载动作

## 一、使用 dpkg 卸载软件
已知两种方式：
1. -r|--remove        <package> ... | -a|--pending
    - 删除软件包；
2. -P|--purge         <package> ... | -a|--pending
    - 删除软件包的同时删除其配置文件；

暂时还不明白 `| -a|--pending` 这几个字段的含义。

### 1.1、小目标：卸载 LibreOffice impress
仅仅删除该软件包，不删除其依赖。
1. 首先我们需要知道这个软件包的名字
    - 知道软件名，如何确定包名，从而卸载该软件？

获取软件包名的：解决方案
```terminal
tom@tom-Vostro-2421:~$ dpkg --list
期望状态=未知(u)/安装(i)/删除(r)/清除(p)/保持(h)
| 状态=未安装(n)/已安装(i)/仅存配置(c)/仅解压缩(U)/配置失败(F)/不完全安装(H)/触发器等待(W)/触发器未决(T)
|/ 错误?=(无)/须重装(R) (状态，错误：大写=故障)
||/ 名称                          版本                体系结构：          描述
+++-=============================-===================-===================-================================================================
略   略                            略                  略                  略
tom@tom-Vostro-2421:~$ dpkg --list | grep libreoffice
ii  libreoffice-avmedia-backend-gstreamer      1:5.1.6~rc2-0ubuntu1~xenial2       amd64        GStreamer backend for LibreOffice
ii  libreoffice-base-core                      1:5.1.6~rc2-0ubuntu1~xenial2       amd64        office productivity suite -- shared library
ii  libreoffice-calc                           1:5.1.6~rc2-0ubuntu1~xenial2       amd64        office productivity suite -- spreadsheet
ii  libreoffice-common                         1:5.1.6~rc2-0ubuntu1~xenial2       all          office productivity suite -- arch-independent files
ii  libreoffice-core                           1:5.1.6~rc2-0ubuntu1~xenial2       amd64        office productivity suite -- arch-dependent files
ii  libreoffice-draw                           1:5.1.6~rc2-0ubuntu1~xenial2       amd64        office productivity suite -- drawing
ii  libreoffice-gnome                          1:5.1.6~rc2-0ubuntu1~xenial2       amd64        office productivity suite -- GNOME integration
ii  libreoffice-gtk                            1:5.1.6~rc2-0ubuntu1~xenial2       amd64        office productivity suite -- GTK+ integration
ii  libreoffice-help-en-us                     1:5.1.4-0ubuntu1                   all          office productivity suite -- English_american help
ii  libreoffice-help-zh-cn                     1:5.1.4-0ubuntu1                   all          office productivity suite -- Chinese_simplified help
ii  libreoffice-impress                        1:5.1.6~rc2-0ubuntu1~xenial2       amd64        office productivity suite -- presentation
ii  libreoffice-l10n-zh-cn                     1:5.1.4-0ubuntu1                   all          office productivity suite -- Chinese_simplified language package
ii  libreoffice-math                           1:5.1.6~rc2-0ubuntu1~xenial2       amd64        office productivity suite -- equation editor
ii  libreoffice-ogltrans                       1:5.1.6~rc2-0ubuntu1~xenial2       amd64        LibreOffice Impress extension for slide transitions using OpenGL
ii  libreoffice-pdfimport                      1:5.1.6~rc2-0ubuntu1~xenial2       amd64        PDF Import component for LibreOffice
ii  libreoffice-style-breeze                   1:5.1.6~rc2-0ubuntu1~xenial2       all          office productivity suite -- Breeze symbol style
ii  libreoffice-style-galaxy                   1:5.1.6~rc2-0ubuntu1~xenial2       all          office productivity suite -- Galaxy (Default) symbol style
ii  libreoffice-writer                         1:5.1.6~rc2-0ubuntu1~xenial2       amd64        office productivity suite -- word processor
```
卸载当然可以通过 dpkg 来完成。但是我当前又不希望卸载 liberOffice 了。



## 二、官方推荐
```terminal
$ sudo apt-get remove --purge libreoffice4.x-*  /* 移除所有类似libreoffice4.x-*的包。--purge表示卸载的同时移除所有相关的配置文件 */
```
