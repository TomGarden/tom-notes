## 下载报错
tom@tom-Vostro-2421:~$ apt-get source apt-get
Reading package lists... Done
E: You must put some 'source' URIs in your sources.list
## `/etc/apt/sources.list` 文件中修改
修改 `# deb-src` 为 `deb-src`

```terminal
sudo apt-get update

apt-get source apt-get
E: Unable to find a source package for apt-get
```
