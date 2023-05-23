## java.io.File

一个代表文件和文件夹的抽象的路径名。

用户界面和操作系统使用系统相关的路径名字符串来命名文件和目录(文件夹)。本类提供了一个抽象的系统无关的层次路径视图。一个抽象的路径名包含两个部分：
1. 一个可选的系统相关的前缀字符串，例如磁盘驱动器符号，在 UNIX 系统中根目录 `/` ，或者在 Windows 系统中 UNC 路径名 `\\\\` 
    - [What is UNC Pathing](https://support.microsoft.com/en-us/help/967030/what-is-unc-pathing)
2. 一个包含 0 或多个字符串名字的队列。

抽象路径名中的首个名字或许是一个文件夹的名字，在 Windows UNC 路径名中是一个主机名。抽象路径名中每一个后续的名字都代表一个文件夹；最后一个名字可能是文件夹也可能是文件。空的抽象路径名没有前缀，是一个空的名称队列。

路径名字符串和系统相关的层级路径名可以相互转换。当一个抽象的路径名倍转换为路径名字符串，每一个名字都被该系统默认的分隔符(separator character)分割。默认的分隔符由系统定义 `file.separator` 在此类中由 `separator` 和 `separatorChar` 表示。当路径名字符串转换成抽象路径名的时候，路径中的名字会被默认的名字分隔符(name-separator)或者其他系统底层定义的名称分隔符分开。

路径名无论是抽象的还是字符串形式的，都可以是相对的或者绝对的路径。绝对路径名是完整的，因为其不需要其他信息来表示文件。相反，相对路径必须从其他路径获取的信息来解释。默认的， `java.io` 包中的类总是针对当前用户目录解析相对路径名。该文件夹由系统属性 `user.dir` 命名，该文件夹通常是调用java 虚拟机的目录。

抽象路径名的父节点可以通过调用 `getParent()` 方法来获得，因为路径名的前缀和路径名中的每一个名称都在名称队列中，除了最后一个。关于祖先(ancestor)的概念：
- “/usr” 称为 “/usr/local/bin” 的祖先(ancestor)。

前缀的概念在 UNIX 平台表示根文件夹和驱动器的选择，在 Windows 的 UNC 路径命中代表跟目录：
- 对于 UNIX 平台，绝对路径的前缀总是 “/” 。相对路径名没有前缀。表示根目录的抽象路径名具有前缀 “/” 和空名称队列。
- 对于 Windows 平台，如果是绝对路径，路径名的前缀包含启动器指定符在驱动指定符后紧跟“:”然后紧跟“`\\`”。在 UNC 时路径名的前缀是 “`\\\\`” 。主机名和 share 那么是名称队列中的前两个名字。相对路径不指定驱动器没有前缀。

本类的实例或许不表示一个真实的文件系统对象，可能是一个文件或者一个文件夹。如果它确实表示一个对象，那么该对象驻留在一个分区中。分区是文件系统特定于操作系统的存储部分。单个存储设备(例如物理磁盘驱动器，山村，CD-ROM)或许包含多个分区。该对象(如果有的话)，将驻留在由该路径名的绝对形式的某个祖先命名的分区上。

一个文件系统可以对实际文件系统对象上的某些操作实施实现限制，例如，读取，写入和执行。这些限制称为访问权限。文件系统可能对单个对象具有多组访问权限。例如，一套可能适用于对象的所有者，另一套可能适用于所有其他用户。对象的访问权限可能会导致此类中的某些方法失败。

File 类的实例是不可变的，也就是说，一旦创建，该 File 对象表示的抽象路径名将永不会该边。