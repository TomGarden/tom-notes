# DexHunter

##### NOTICE： The feature string is very important. It may be changed along with the evolution of hardening services. If it is incorrect, the unpacking process cannot be triggered. DexHunter leverages "fwrite" and other libc functions to manipulate files. But these functions are hooked by hardening services resulting in the crash of the process. As a result, you cannot utilize the provided image to unpack the latest hardedning services. You had better replace these functions with the direct system calls to avoid crash.

##### 注意：特征字符串非常重要。他可能随着加固服务的发展而发生变化。如果不匹配则无法触发解包过程。DexHunter 利用 libc 中的 "fwrite" 等方法操作问价。但是这些方法被加固服务 hooked 的话 DexHunter 进程将会崩溃。因此不能使用官方系统镜像来解加固果的包。你最好重写这个系统调用方法来避免崩溃。

DexHunter aims at unpacking hardened dex file automatically.

DexHunter 的目标是自动化的解包加固过的 dex 文件。

DexHunter is based on the source code of Android runtime. It is composed of modified ART and DVM runtime. You can use the modified runtime to replace the original content in Android source codes (Android 4.4.3). The modification is mainly in "art/runtime/class_linker.cc" (ART) and "dalvik/vm/native/dalvik_system_DexFile.cpp" (DVM).

DexHunter 基于 art 。你可以使用修改后的内容替代 Android 源代码(4.4.3)中对应的内容。修改的内容主要集中于 "art/runtime/class_linker.cc" (ART)  和  "dalvik/vm/native/dalvik_system_DexFile.cpp" (DVM).

###Usage:

If you want to unpack an app, you need to push the "dexname" file to "/data/" in the mobile before starting the app. The first line in "dexname" is the feature string (referring to "slide.pptx"). The second line is the data path of the target app (e.g. "/data/data/com.test.test/"). Its line ending should be in the style of Unix/Linux. You can observe the log using "logcat" to determine whether the unpacking procedure is finished. Once done, the generated "whole.dex" file is the wanted result which is located in the app's data directory.

如果你希望解包一个 app ，你需要在启动 app 之前在 `/data/` 目录中放置一个 `dexname` 文件。`dexname` 文件中第一行是特征字符串(参考 “slide.pptx”)。第二行是目标 apk 路劲(例如“/data/data/com.test.test/”)。行末应该按 Unix/Linux 风格。你可以看到日志使用 “logcat” 去确定解包过程是否结束了。一旦结束，构造的 “whole.dex” 就会被放到对应 app 的 data 目录中。

###Tips:

1) DexHunter simply reuses the content before "class_def" section instead of parsing them for the efficiency. If there are some problems, you can parse and reassemble them again or amend them statically.
    - DexHunter 在 “class_def” 小节之前简单重用内容而不是为了效率而解析它们。如果这么做的过程中存在某些问题，您可以解析并重新装配它们或者静态修改它们。

2) It is worth noting that some "annotation_off" or "debug_info_off" fields may be invalid in the result. These fileds have nothing to do with execution just to hinder decompiling. We do not deal with this situation specifically for the moment. You can just program some scripts to set the invalid fileds with 0x00000000. 
    - 值得注意的是结果中一些 “annotation_off” 或者 “debug_info_off” 字段可能是无效的。这些字段与执行无关，只是为了阻止反编译。你可以使用一些脚本将无效字段的值设置为 0x00000000。

3) As is known, some hardening services can protect several methods in the dex file by restoring the instructions just before being executed and wiping them just after finished. So you also need to modify the "DoInvoke" (ART) or "dvmMterp_invokeMethod" (DVM) function to extract the protected instruction while being executed.
    - 我们知道一些加固服务保护 dex 中 method 的手段是，在执行前恢复指令，并在执行后擦除已恢复的指令。所以你需要修改 “DoInvoke”(ART) 或者 “dvmMterp_invokeMethod”(DVM) 方法当执行的时候导出受保护内容。

4) The feature string may be changed along with the evolution of hardening services.
    - 随着加固服务的发展，在未来特征字符串可能发生变化。

5) If the "fwrite" and other libc functions fail, maybe these functions are hooked by hardening sevices. As a result, you cannot dump the memory via them. You can bypass this limitation by calling relevant system calls directly.
    - 如果 “fwrite” 和其他的 libc 方法失败了，或需是这个被加固服务 hook 了。这种情况下你将无法通过这些方法 dump 内存。你可以通过使用系统调用来绕过这种限制。

DexHunter has its own limitation. As the hardening services develop, DexHunter may be not effective in the future. If you are interested, you can amend DexHunter to keep pace with hardening services continuously.
- DexHunter 有他自己的局限性。随着硬件服务的发展，DexHunter 或需在一段时间之后就失去了效力。如果你对此感兴趣，你可以不断修改 DexHunter 以便紧跟加固服务的发展趋势。


###File description:

"slide.pptx" is the presentation material of HITCON 2015 (http://hitcon.org/2015/ENT/Activities-Enterprise-Agenda.html#zyq) depicting the design and implementation of DexHunter.
- “slide.pptx”是 [HITCON 2015](http://hitcon.org/2015/ENT/Activities-Enterprise-Agenda.html#zyq) 的演示资料，描述了 DexHunter 的设计和实现。

"demo.mp4" is the demonstration video of unpacking a hardened app by Ali.
- “demo.mp4” 是演示视频，内容是解包一个被 Ali 加固的app

"test.apk" is the sample used in the video.
- tesk.apk 是视频中使用的 apk

"dexname" is the configuration file used in the video.
- dexname 是视频中使用的配置文件

"art" directory is the modified runtime for ART.
- “art” 文件夹是修改后的 ART 程序包

"dalvik" directory is the modified runtime for DVM.
- “dalvik” 文件夹是修改后的 DVM 程序包

"image" 7z files contain the system image files used in the video.
- “image” 文件包含视频中使用的系统镜像。

If you have any question, please contact me via emails to zyq8709@gmail.com.
- 有任何问题可以通过 zyq8709@gmail.com 找到我。

If you use this code, please cite the following paper. Thanks!
- 如果你要始终本项目的代码请引用下述文字。谢谢！

Yueqian Zhang, Xiapu Luo, and Haoyang Yin, DexHunter: Toward Extracting Hidden Code from Packed Android Applications, Proceedings of the 20th European Symposium on Research in Computer Security (ESORICS), Vienna, Austria, September 2015.

@inproceedings{DexHunter15,
Title = {DexHunter: Toward Extracting Hidden Code from Packed Android Applications},
Author = {Yueqian Zhang and Xiapu Luo and Haoyang Yin},
Booktitle = {Proc. ESORICS},
Year = {2015}}

#####Comment: 

I have tested the samples from 360 in July under DVM. The feature string is changed to "/data/app/XXX.apk" (referring to "silde.pptx"). This string is very important. If it is incorrect, the unpacking process will fail.
- 我已经在七月在 DVM 下对 360加固输出做了测试。特征字符串已经修改为 “/data/data/XXX.apk”(参考 “silde.pptx”)。这个字符串非常重要，如果他是错误的，解包将会失败。
