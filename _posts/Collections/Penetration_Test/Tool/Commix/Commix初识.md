>https://github.com/commixproject/commix

一款测试命令注入的自动化工具

Commix 也可以作为下属框架的插件使用:
- TrustedSec's Penetration Testers Framework (PTF)
- OWASP Offensive Web Testing Framework (OWTF)
- CTF-Tools
- PentestBox
- PenBox
- Katoolin
- Aptive's Penetration Testing tools
- Homebrew Tap - Pen Test Tools

支持平台
- Linux
- Mac OS X
- Windows (experimental)

Usage
```
python commix.py -h
```

## 关于安装
1. 安装 Python ，然后配置环境变量 
2. 安装 Pip `python -m pip install -U pip`
3. 安装 pyreadline `pip install pyreadline`
4. 下载 Commix 包运行其中的命令即可。


## 关于错误
```
$ commix.py

····
[x] Critical: It seems that your platform does not have GNU 'readline' module installed. Download the 'pyreadline' module (https://pypi.python.org/pypi/pyreadline).
```
关于上述错误是由于使用命令不当造成的请知晓。
- 正确的姿势： `python commix.py`

