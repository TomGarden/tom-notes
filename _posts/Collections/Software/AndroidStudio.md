> Unable to run mksdcard SDK tool. One common reason for this failure is missing required libraries Please fix the underlying issue and retry.

Ubuntu16.04(32bit)安装 AndroidStudio 过程遇到上述问题没有解决 下载的 adb 也不能用：

> adb: cannot execute binary file: Exec format error

最终的解决方案是从 http://www.androiddevtools.cn/ 下载了一个`platform-tools`并且替换掉了 Studio 自动下载的 包中的 同名文件。


aapt也不能运行，这个想要下载但是 没找到位置，所以就使用 apt 下载了。

> AndroidStudio 4.1 版本的 git 窗口没有本地修改的文件列表
AndroidStuido -> Preference -> Version Control -> Use non-modal commit interface