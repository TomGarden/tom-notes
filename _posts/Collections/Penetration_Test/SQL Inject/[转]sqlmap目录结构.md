>原文地址：http://blog.csdn.net/qq_29277155/article/details/51646932

## 0x00 前言

sqlmap 是一个开源的渗透测试工具，可以用来自动化的检测，利用SQL注入漏洞，获取数据库服务器的权限。它具有功能强大的检测引擎,针对各种不同类型数据库的渗透测试的功能选项，包括获取数据库中存储的数据，访问操作系统文件甚至可以通过外带数据连接的方式执行操作系统命令。本文重点研究sqlmap的软件具体的目录结构，后续的文章也会从源码编写中，阐述sqlmap的种种编码结果。本文从结构中，可以看到sqlmap中的软件工程之美，同时从严谨的软件结构目录分类和构造中，看到sqlmap中的软件开发过程中的庞大但简洁的结构之美。


## 0x01目录结构简要

一般来说，从github下载并且解压sqlmap 后，所有文件或者文件夹的数目加起来总共24个，部分目录和结构属于典型的github 项目结构，但是本文依然会做出简单的介绍，方便读者全面理解。

.git --->>>这个是git的代码管理仓库，基本上每个github项目都会有这个文件夹，记录了文件上传更改等版本信息。

.gitattributes--->>>这个是git的属性文件，例如何种编程语言、具体文件类型等。

.gitignore--->>>这个是git的忽略文件，例如忽略某些文件，不把这些文件上传到git仓库中。

.travis.yml--->>>这个标记了python的版本和设置sqlmap的脚本。

doc/ ---->>>该文件夹包含了sqlmap 的具体使用说明，例如多种语言的简要说明、PDF版的详细说明、FAQ、作者信息等。

extra/  --->>>这里包含了sqlmap的多种额外功能，例如发出声响（beep)、运行cmd、安全执行、shellcode等。

lib/   --->>>这里包含了sqlmap的多种连接库，如五种注入类型请求的参数、提权操作等。

plugins/  --->>>这里包含了各种数据库的信息和数据库通用事项。

procs/    --->>> 这里包含了mssqlserver、 mysql、oracle和postgresql的触发程序

shell/    --->>>这里包含了多种注入成功后的9种shell 远程连接命令执行和管理数据库

tamper/       --->>>这里包含了47种的绕过脚本，例如编码绕过、注释绕过等。

thirdparty/  --->>>这里包含了一些其他第三方的插件，例如优化、保持连接、颜色等。

txt/        --->>>这里包含了一些字典，例如用户浏览器代理、表、列、关键词等。

udf/  --->>>这里包含了用户自己定义的攻击载荷。

waf/ --->>>>这里包含了一些44种常见的防火墙特征。

xml/ --->>>这里包含了多种数据库的注入检测载荷、旗标信息以及其他信息。在这里可以看到进行注入的。

README.md--->>>说明文件，简要地指导我们下载、安装和使用sqlmap，里面有多种语言版本(中文)的安装下载使用介绍说明。

sqlmap.conf  --->>>> sqlmap的配置文件，如各种默认参数（默认是没有设置参数、可设置默认参数进行批量或者自动化检测）。

sqlmap.py*  --->>>> 这是sqlmap 的主程序，可以调用各种参数进行注入任务。

sqlmapapi.py*  --->>>>  这是sqlmap 的api 文件，可以将sqlmap集成到其他平台上。


## 0x02 目录 sqlmap/doc/
这里包含了sqlmap 的具体使用说明。如多种语言的简要说明、PDF版的详细说明、FAQ、作者信息等。以下是文件夹的内容：
- README.pdf  #英文说明文档，它非常详细介绍了如何调用各种参数和设置来使用sqlmap。善于熟练利用sqlmap也是很厉害的
- FAQ.pdf  #英文解疑文档，它罗列了在使用sqlmap经常遇到的问题和解决，无论是安装还是使用过程出现问题，可以查看帮助。
- translations #翻译文件夹，包含了下载、安装和使用sqlmap的简要说明文档，该文件包含多种语言版本，其中也有中文版。
- AUTHORS  #作者信息，它介绍了sqlmap的编者及其邮箱。国外的两个大牛很慷慨地开源了sqlmap注入工具，想想乌云中，有多人靠它四处挖洞，实在应该感谢编者。
- CHANGELOG.md   #更新日志，介绍了sqlmap 的更新功能及特性。很多优秀的功能等待挖掘。但很多人没有注意，毕竟绝大部分同学用的都是基本功能。
- CONTRIBUTING.md #贡献文件，它介绍我们在使用sqlmap的时如果有bug可以提交攻贡献到github.
- COPYING     #版权文件，它介绍了sqlmap的发布权利和重新分发的说明。
- THANKS.md    #感谢文档，它介绍了对sqlmap有所贡献的作者。
- THIRD-PARTY.md #第三方插件，它介绍了集成在sqlmap的第三方插件的概要说明。

## 0x03 目录 sqlmap/extra/

- sqlmap/extra/beep/   #警报声音文件夹。
- sqlmap/extra/beep/ beep.py，它是产生警报声音的文件，参数为--beep，当发现sql注入的时候，发出警报声。
- sqlmap/extra/beep/ beep.wav 警报的声音文件。
- sqlmap/extra/dbgtool/  # 执行转换的文件夹。
- sqlmap/extra/dbgtool/dbgtool.py    #可以 ASCII文本转化到便携式的exe文件，生成的nc.exe可以安装windows上，进行后门监听。
- sqlmap/extra/dbgtool/  README.txt为该文件的说明文件。
- sqlmap/extra/mssqlsig/update.py#它更新了MSSQL版本号，不过好像URL打不开了。莫非是国内的原因。
- sqlmap/extra/safe2bin/   #文件夹，具有转成bin文件功能的文件。例如你可以把一个文本转换成可执行文件。其README.txt有它的简要说明、safe2bin.py是可操作的执行文件。
- sqlmap/extra/shutils/ #python的文件操作工具。它实现了查找第三方插件等功能。
- sqlmap/extra/cloak/  #可以利用cloak.py可以生成后门等操作。
- sqlmap/extra/icmpsh/  #一个win32的反向ICMPshell，是进行注入成功后反弹回来的一种shell.
- sqlmap/extra/runcmd/  #进行注入成功后，反弹回来cmd命令的辅助工具.
- sqlmap/extra/shellcodeexec/  #被安装在受害者机器上的shellcode，这些并非在自己的机器上运行的，里面有windows的32，linux的32,64位
- sqlmap/extra/sqlharvest/  #利用google进行搜索爬取文件。


## 0x04 目录 sqlmap/lib
sqlmap调用多种功能的库，以下是其文件夹里面的内容：

- controller  # 该目录能够进行一系列的检查贮备工作，下面简要介绍几个文件。
- action.py # 利用URL受到影响的参数进行SQL注入，并且在条件许可下抽取系统或者数据库中的数据。
- checks.py #利用载荷对对发现的sql注入点进行注入检测。
- controller.py #对用户传递的参数进行控制。
- handler.py #对用户传递的数据库名称进行处理
- core     # 该核心文件夹有各种参数的调用文件。例如设置目标 会调用 target.py。还有agent.py，dump.py，threads.py等等。
- parse   #  该参数文件夹有banner.py     cmdline.py    sitemap.py    configfile.py payloads.py   handler.py    html.py       headers.py    等一系列配置处理参数调用文件。  
- request  # 该请求文件夹有basic.py             templates.py         basicauthhandler.py  redirecthandler.py   comparison.py        rangehandler.py      connect.py           pkihandler.py        direct.py            methodrequest.py     dns.py               inject.py            httpshandler.py      等一系列网络请求连接文件。
- takeover  # 该接管文件夹有abstraction.py    xp_cmdshell.py    icmpsh.py         web.py            metasploit.py     udf.py            registry.py     注入成功后接管受害者机器的shell.
- techniques  #该注入分类文件夹有blind  brute  dns    error  union  等五类注入类型，其中每个文件夹有相应的注入类型执行文件。
- utils  #小功能文件夹。该文件有  api.py xrange.pycrawler.py         versioncheck.py    deps.py        timeout.py      getch.py       hash.py       sqlalchemy.py      hashdb.py     search.py      htmlentities.py    purge.py      pivotdumptable.py     progress.py 等多种功能的调用文件。


## 0x05 sqlmap\plugins

插件说明 

- dbms #该文件夹包含了各种数据说明。例如access      db2         firebird    hsqldb      maxdb       mssqlserver mysql       oracle      postgresql  sqlite      sybase 等，每个数据库文件都有固定的文件。例如access文件夹里面有connector.py        enumeration.py    takeover.py       filesystem.py     syntax.py         fingerprint.py 等文件。
- generic #通用文件夹。它也是包含了connector.py        enumeration.py    takeover.py       filesystem.py     syntax.py         fingerprint.py 等文件。


## 0x06 sqlmap\procs

对部分数据库的进行注入时访问进程

- mssqlserver #对mssqlserver 进行处理的进程进行访问，方便对数据进行访问。
- mysql  #对mysql   进行处理的进程进行访问，方便对数据进行访问。
- oracle  #对oracle进行处理的进程进行访问，方便对数据进行访问。
- postgresql  #对postgresql 进行处理的进程进行访问，方便对数据进行访问。
- README.txt #对该文件夹的说明。该文件sqlmap在目标系统上使用的SQL片段。


## 0x07 sqlmap\shell

相信大家看着那些名称，也会明白它们是sqlmap成功注入系统的shell,各种语言的shell， 为了躲避查杀，需要进行一定的转换，至于如何转换在README.txt   有详细说明。/extra/cloak/cloak.py 可以把这些后门还原成可阅读的代码。
backdoor.asp_  backdoor.aspx_backdoor.jsp_ backdoor.php_ runcmd.exe_   stager.asp_   stager.aspx_  stager.jsp_   stager.php_   
README.txt    #以上shell均是加密了，直接打开是乱码的，所以可以按照说明文档进行转换。


## 0x08 sqlmap\tamper

这里有多种进行注入时绕过防火墙的脚本，33种，组合多种脚本来用，效果还是不错的。以下是具体的绕过脚本：

apostrophemask.py        apostrophenullencode.py  appendnullbyte.py        base64encode.py          between.py               bluecoat.py         chardoubleencode.py  charencode.py            charunicodeencode.py     commalesslimit.py        commalessmid.py         concat2concatws.py       equaltolike.py           escapequotes.py        greatest.py              halfversionedmorekeywordsifnull2ifisnull.py     informationschemacomment.lowercase.py             modsecurityversioned.py  modsecurityzeroversioned.multiplespaces.py       nonrecursivereplacement.poverlongutf8.py          percentage.py            randomcase.py           randomcomments.py        securesphere.py sp_password.py           space2comment.py         space2dash.py            space2hash.py   space2morehash.py        space2mssqlblank.py space2mssqlhash.py    space2mysqlblank.py      space2mysqldash.py     space2plus.py            space2randomblank.py   symboliclogical.py       unionalltounion.py       unmagicquotes.py         uppercase.py             varnish.py               versionedkeywords.py   versionedmorekeywords.py xforwardedfor.py         

#打开每个脚本，可以看到这些脚本的适用条件和环境，可以参考以下文章：

http://blog.csdn.net/qq_29277155/article/details/51193071


## 0x09 sqlmap\thirdparty

第三方插件，实现各种优化格式的小功能。

- ansistrm         #该文件夹中主要为ansistrm.py，它定义了结果输出终端的颜色显示。
- beautifulsoup    #该文件夹中主要为beautifulsoup.py，它把XML等转化为树状表示法。
- bottle           #bottle是Python的一个快速，简单和轻巧WSGI微Web框架。它分布作为单个文件模块，不依赖其他Python标准库。主要为bottle.py，它是构建静态和动态HTTP请求的关键所在，虽然支持python3，但是由于sqlmap整体是采用python2开发的，所以这里会进行一个兼容性检查。
- chardet          #该文件夹中有众多字符探针和字符定义文件，主要作用是探测web页面的页面编码。
- clientform       #该文件夹主要为clientform.py，它对Web客户端进行HTML表格处理。
- colorama         #该文件夹的主要功能是为了将ansi转化为win32编码。
- fcrypt           #该文件夹主要为标准的linux加密提供端口，或者说是修复缺失加密功能的python版本。
- gprof2dot        #该文件夹提供了从几个解析器的输出中产生一个dot 图形，
- keepalive        #该文件夹主要为keepalive.py，它的urllib2对HTTP处理程序支持HTTP1.1和存活。
- magic            #该文件夹主要为magic.py，magic 是一个libmagic文件识别库的包装器。
- multipart        #该文件夹主要为multipartpost.py，进行多线程发送数据包。
- odict            #该文件夹主要为odict.py，主要为有序字典对象，保存插入顺序的密钥。
- oset             #python ABC类的部分补丁，pyoset.py为主要程序，_abc.py为辅助类的ABC类说明。
- pagerank         #该文件夹主要为pagerank.py，获取谷歌网页排名的页面的脚本。
- prettyprint      #该文件夹主要为prettyprint.py，该脚本优化终端结果输出显示。
- pydes            #python中3DES加密解密算法，其中里面有加密解密算法说明。
- socks            #python中的sock模块。
- termcolor        #该文件夹中主要为termcolor.py，它实现了终端输出的颜色格式化。
- xdot             #dot格式的可视化图形。


## 0x10 sqlmap\txt

该文件夹包含了关键词、公共列表和其他一些字典。具体如下：

- common-columns.txt #数据库中的共同列。
- common-outputs.txt  #数据库中的共同输出。
- common-tables.txt   #数据库中的共同表。
- keywords.txt        #数据库中的共同关键词。

- smalldict.txt      #数据库中的字典。
- user-agents.txt     #进行请求时的浏览器代理头。


## 0x11 sqlmap\udf

以下的文件在受害者机器上运行的数据代码，而不是在我们攻击者的及其上执行的。

- mysql #包括linux和windows的lib_mysqludf_sys.dll_，均有32位和64位。
- postgresql #包括linux和windows的lib_mysqludf_sys.dll_，均有32位和64位。
- README.txt #该文件夹的功能说明。


## 0x12 sqlmap\waf

该文件夹有44个脚本分别对44种WAF进行检测。例如360，绿盟WAF，modsecurity.，百度，fortiweb，cloudflare。由此可见老外对国内的WAF也是有了解的，可见他们也会悄悄对国内的WAF进行绕过。具体WAF探测如下：

360.py 
airlock.py anquanbao.pybaidu.py barracuda.pybigip.py      binarysec.pyblockdos.py        ciscoacexml.py   cloudflare.py  datapower.py        denyall.py          dotdefender.py         edgecast.py        expressionengine.py    fortiweb.py         hyperguard.py       incapsula.py        isaserver.py         jiasule.py        knownsec.py        kona.py          modsecurity.py       netcontinuum.py netscaler.py     newdefend.py          nsfocus.py          paloalto.py       profense.py        proventia.py         radware.py       requestvalidationmode.py         safe3.py     safedog.py      secureiis.py          senginx.py        sucuri.py        teros.py          trafficshield.py     urlscan.py       uspses.py         varnish.py          webappsecure.py        webknight.py             

         
## 0x013 sqlmap\xml

各种信息的xml记录

- banner # 各种数据及其相关数据的标志XML记录。例如：cookie.xml           generic.xml          mssql.xml            mysql.xml           oracle.xml           postgresql.xml    server.xml           servlet.xml          sharepoint.xml       x-aspnet-version.xml x-powered-by.xml     
- payloads #布尔、错误、内联查询、堆查询、延时盲注、联合查询等六种注入类型的攻击注入检测载荷。这点很重要，sqlmap是否能够检测到注入点，就靠这个载荷了。
- boundaries.xml #边界记录文件。
- errors.xml #错误显示的xml文件。
- livetests.xml #测试存活的xml记录文件。
- queries.xml #查询记录的xml文件。
- sqlmap.xsd #sqlmap的 XSD是指XML结构定义 ( XML Schemas Definition ) 。


## 0x14 README.md

这个是一个说明文件，简要地指导我们下载、安装和使用sqlmap，该文件包含多种语言版本的安装下载使用介绍说明，也是很有用的一个帮助文件。在这里，你可以找到简要的中文说明！！！


## 0x15 sqlmap.conf 

这是sqlmap的配置文件，例如各种默认参数（默认是没有设置参数、可以设置默认参数进行批量或者自动化检测）


## 0x16sqlmapapi.py 

接口文件，可以将sqlmap集成到其他平台上。如burp等，到底有没有安全厂商把它集成到他们自己的产品中去昵？_？



## 0x17 sqlmap.py 

sqlmap 的主程序，里面可以进行调用各种参数和在终端显示各种帮助信息。拿个找个注入报个乌云，找个账号啊！^^**__**^^