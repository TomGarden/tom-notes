# 关于 drozer 的使用
## 一、 写在开始
我们学习“方法”不如学习“学习方法”
- 学习“方法”消耗的记忆力
    - 10 天半月不用依然和没学过一样(过期了)
- 学习“学习方法”消耗的是逻辑分析的时间
    - 一次明白了只要该方法所针对的操作没有根本性的改变，该技能永远不会过期。

## 二、 关于 drozer 的使用
### 2.1、 如何开始第一步
键入 drozer 不认识的命令，它会告诉我们它所接受的命令都包含什么：
```
E:\drozer>drozer --help
unknown command: --help
usage: drozer [COMMAND]

Run `drozer [COMMAND] --help` for more usage information.

Commands:
          console  start the drozer Console
           module  manage drozer modules
           server  start a drozer Server
              ssl  manage drozer SSL key material
          exploit  generate an exploit to deploy drozer
            agent  create custom drozer Agents
          payload  generate payloads to deploy drozer
```
### 2.2、 只说我们常用的：console
>启动 drozer 控制台,和代理进行交互

>drozer console 连接到代理(Agent) 并且使我们可以通过命令行和代理(Agent)进行交互。如果代理(Agent)已经启用 console 可以直接进行连接也可以通过代理服务器进行连接

上述内容在下述命令使用中都以英文描述的形式显示了出来。

```
// drozer console <如果不知道应该继续输入什么就 --help>
E:\drozer>drozer console --help
usage: drozer console [OPTIONS] COMMAND

Starts a new drozer Console to interact with an Agent.

The drozer Console connects to an Agent and allows you to interact with the
system from the context of the agent application on the device. The console
can connect directly to an agent, if its embedded server is enabled, or through
a drozer Server that the agent is connected to.

positional arguments:(下述两个描述还不知道怎么用？以及用在什么地方？不过它们也都出现在 available commands 中了)
  command               the command to execute
  device                the unique identifier of the Agent to connect to

optional arguments:(下述 option 需要在 Agent 中设置相应的设置项，然后对应使用，这里我们没有用过。)
  -h, --help            show this help message and exit
  --server HOST[:PORT]  specify the address and port of the drozer server
  --ssl                 connect with SSL
  --accept-certificate  accept any SSL certificate with a valid trust chain
  --debug               enable debug mode
  --no-color            disable syntax highlighting in drozer output
  --password            the agent requires a password
  -c ONECMD, --command ONECMD
                        specify a single command to run in the session
  -f [FILE [FILE ...]], --file [FILE [FILE ...]]
                        source file

available commands:
  commands    shows a list of all console commands
              本命令就是显示 available commands 这个列表
  connect     starts a new session with a device
              连接到 Agent 这是我们最常用的命令
  devices     lists all devices bound to the drozer server
              列出所有的设备
  disconnect  disconnects a drozer session
              
  version     display the installed drozer version
```
### 2.2、 现在我们连接到一个 Agent
设备情况
1. 一台电脑
2. 一台安装了 Agent 的手机
3. 两台设备通过 USB 连接

连接命令
- drozer console connect
```
E:\drozer>drozer console connect
Selecting 83b3ca5564c1119b (LGE Nexus 5 6.0.1)

            ..                    ..:.
           ..o..                  .r..
            ..a..  . ....... .  ..nd
              ro..idsnemesisand..pr
              .otectorandroidsneme.
           .,sisandprotectorandroids+.
         ..nemesisandprotectorandroidsn:.
        .emesisandprotectorandroidsnemes..
      ..isandp,..,rotectorandro,..,idsnem.
      .isisandp..rotectorandroid..snemisis.
      ,andprotectorandroidsnemisisandprotec.
     .torandroidsnemesisandprotectorandroid.
     .snemisisandprotectorandroidsnemesisan:
     .dprotectorandroidsnemesisandprotector.

drozer Console (v2.3.4)
dz>
```

### 2.3、 针对 Agent 进行操作
现在的问题是：如果抛开我们的记忆，我们又不知道接下来如何使用了。
- 在这种情况下如果我们随意输入反馈会是无法识别。
    - 由此来看此处设置不是一个好的交互设计，除了反馈无法识别外还应该告诉使用者可以识别什么。
- 好在我曾经使用过一些命令行软件所以我按照几乎所有软件都有的功能尝试进行输入
    - 输入：help
    - 输入：?    
    - 上述两个输入效果相同，我们得到了进一步的使用提示

```
dz> ?

drozer: Android Security Assessment Framework
        Android 安全      评估       框架

Type `help COMMAND` for more information on a particular command, or `help MODULE` for a particular module.

Commands:

cd     contributors  env   help  load    permissions  set    unset
clean  echo          exit  list  module  run          shell

Miscellaneous help topics:其他帮助主题

intents
```    

跟随上述反馈的指引我们会面对两种情况
1. 这个软件我们找不到任何人的使用信息，对我们而言当前命令窗口使我们唯一获取信息的途径的时候
    - 我们能做的就是逐个查看 
        - help command
        - help Miscellaneous help topics
    - 然后根据个人理解进行尝试性的使用。
2. 我们知道有人在使用这个工具，我们也知道它使用的一些关键参数是什么，这是我们所碰到的大多数情况。

3. 这里我们遵从结合上述两点进行，查看如下内容：(以下我所列出的并不是我查看过的所有，只是我今后还会重复查看的内容)
    - help intents ： 告诉我们和 Intent 相关的知识点，以及希望通过命令行使用 intent 的时候，需要如何使用。
    - help run
        ```
        dz> help run
        usage: run MODULE [OPTIONS]

        To see the options for a particular module, run `help MODULE`.
        ```
        - 事实上鬼才知道 MODULE 是什么，所以我们的新问题是如何知道 module 都有什么？——就我的情况而言我选择了最笨的，挨个看看，也就是经过九曲十八弯我们又绕会了第一种方法“对我们而言当前命令窗口使我们唯一获取信息的途径的时候”

            |命令         |关键词        |我的认知                      |
            |-------------|-------------|-----------------------------|
            |cd           |namespace    |don't know                   |
            |contributors |contributors |该模块的贡献者，是一些人名和邮箱|
            |env          |environment  |可以打印所有环境变量           |
            |load         |load file    |Loads a file, and executes it as a script.|
            |permissions  |permissions  |Prints out the permissions granted to the agent being used in this session.|
            |set          |variables    |可以用来定义变量和值，定义了值的变量可以用于后续使用|
            |unset        |variables    |取消已经存储了的 set 设置的变量和对应的值|
            |clean        |clean cache  |drozer 可以上传到我们的设备上(暂不明确是 Agent 还是 drozer 所存在的设备)，apk 或 dex，本命令可以清除它们释放存储空间|
            |echo         |回显并执行    |回显并执行，这个可以自己查看一下 help echo 没有一个例子是说不清的|
            |exit         |exit         |Terminate(终止) your drozer session.|
            |lsit         |__找到答案__  |Displays a list of the available modules, optionally filtered by name.|
            |exit         |exit         |Terminate(终止) your drozer session.|
            |module       |类似包管理器  |moudle 管理器，提供检索未安装的 module 和安装/移除它们 等功能  |
            |run          |run module   |执行已安装的 module ，已安装的 module 通过 list 命令来查看|
            |shell        |执行 Linux 命令|确实可以执行许多命令，但是我暂时还不知道具体可执行的有哪些，不可执行的有哪些|

### 2.4、我们已经可以 `run MODULE`
至此我们可以通过 `list` 命令来查询到自己感兴趣的已安装的 MODULE ，如果没有自己感兴趣的 MODULE 还可以通过  `module` 命令搜索感兴趣的，并安装它。

但是这这一切还没有结束
```
dz> run app.package.attacksurface
too few arguments
```

如题，缺少参数。
- 我已经说过一次了这种设计十分的不合理，如果应用发现用户的输入是不规范的，一个合理的设计及实现是：“ 当发现用户不规范的输入时给出该命令所能接收的规范输入 ”
- 那么面对这种情况新的问题是：我们如何获取输入规范。
    - 用户只能靠猜，我们依然尝试性输入：
        - 输入：--help / help
        - 输入：-h     / h
        - 输入：-?     / ?
    ```
    dz> run app.package.attacksurface -h
    usage: run app.package.attacksurface [-h] package

    Examine the attack surface of an installed package.

    Examples:
    Finding the attack surface of the built-in browser

        dz> run app.package.attacksurface com.android.browser

        6 activities exported
        4 broadcast receivers exported
        1 content providers exported
        0 services exported

    Last Modified: 2012-11-06
    Credit: MWR InfoSecurity (@mwrlabs)
    License: BSD (3 clause)

    positional arguments:
    package     the identifier of the package to inspect

    optional arguments:
    -h, --help    
    ```

## 三、OVER
至此我们已经完成了一系列的使用并且可以根据上述使用模式完成更多其他命令的使用了。

所谓“得鱼好.得渔好!”

## 四、 鱼
1. [Drozer模块命令大全（一） ](blog.csdn.net/cch139745/article/details/53519900)
    - [Drozer模块命令大全（二） ](http://blog.csdn.net/cch139745/article/details/53691123)