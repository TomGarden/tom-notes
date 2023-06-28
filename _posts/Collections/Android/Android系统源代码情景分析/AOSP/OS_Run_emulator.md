## 0x01. 运行编译 AOSP 之后生成 模拟器

下载 AOSP 编译完成后直接执行 emulator 即可运行刚刚编译好的镜像

在 aost/out 目录中可以找到启动模拟器所需要的镜像文件 , 要启动这个模拟器 , 在编译完成后直接执行
 `emulator` 即可

但是当设备重启后再想运行这个模拟器 :
0. `cd aosp_path`
1. `source build/envsetup.sh`
3. `lunch 当时编译的那个版本号其他的没有测试`
    - 我暂时用的这个 : `aosp_x86-eng` 第 23 个选项
4. `emulator`
    - 可以通过 `which emulator` 来查看可执行文件位置


## 0x02. 运行环境
另外的说明, 我的移动硬盘有完整的代码和编译产物 , 内存不足的 PC 包含
1. 未执行编译动作的源码(实际上在编译过程中由于内存不足失败, 执行了 `m clean`)
2. 硬盘编译产物文件夹 `aosp/out/target` 拷贝到 PC

如果这种使用方式无法满足后续的需求再想办法清理 PC 硬盘或者换设备
- 拷贝到 PC 就不用带太多零碎了 , 也不担心接触不良什么的硬件问题

## 0x03. 修改 emulator 参数
修改屏幕尺寸 , 参照 `~/.android/avd` 文件中的配置文件 confit.ini 进行修改和验证即可


## 0x04. 使用编译结果启动虚拟机
```
10:51:14 tom@tom-pc android-6.0.0_r1 → which emulator
/media/tom/vm/AOSP/android-6.0.0_r1/prebuilts/android-emulator/linux-x86_64/emulator
10:51:14 tom@tom-pc android-6.0.0_r1 → pwd
/media/tom/vm/AOSP/android-6.0.0_r1

emulator    \
                    -system      ./out/target/product/hammerhead/system.img  \
                    -ramdisk  ./out/target/product/hammerhead/ramdisk.img  \
                    -data         ./out/target/product/hammerhead/userdata.img
```




关于购买硬件运行编译版本镜像问题: 

关键词: BL / CID / V版 / 美版 / 港版



## 参考 > 解决问题
1. [直接运行编译时候的相关命令即可运行模拟器了](https://source.android.com/setup/create/avd)

## 参考 > 没有解决问题但是扩大了了解面
0. [emulator 由两个执行文件](https://stackoverflow.com/a/51627009/7707781)
1. [emulator 用 sdk/emulator/emulator 执行黑屏](http://www.360doc.com/content/14/0626/19/6828497_390069562.shtml)
    - 我看应该是这个 emulator 版本过低 ,  通过这个调整方式也没有解决问题
2. [可能需要控制模拟器内核](https://blog.csdn.net/dl6655/article/details/78869501?utm_medium=distribute.pc_aggpage_search_result.none-task-blog-2~all~first_rank_v2~rank_v25-2-78869501.nonecase&utm_term=android8.0%E6%BA%90%E7%A0%81%E7%BC%96%E8%AF%91%20%E6%A8%A1%E6%8B%9F%E5%99%A8%E9%BB%91%E5%B1%8F)
3. [购买硬件设备的经验](http://bbs.gfan.com/android-9269979-1-1.html)
4. [使用本地编译成功的镜像文件启动Android模拟器](https://blog.csdn.net/Decisiveness/article/details/51901441)
5. [直接运行编译时候的相关命令即可运行模拟器了](https://source.android.com/setup/create/avd)