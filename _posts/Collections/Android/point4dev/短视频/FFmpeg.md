官网 : https://ffmpeg.org/

已知的使用方式 :

1. https://github.com/microshow/RxFFmpeg
2. https://github.com/mabeijianxi/small-video-record
3. https://github.com/yangjie10930/EpMedia

通过编译 FFmpeg 库到 Android 运行 , 然后使用 FFmpeg 执行指定命令 , 最终得到结果文件 .




相关的命令使用经验 : 

1. https://github.com/microshow/RxFFmpeg/blob/master/preview/docs/cmd.md
2. https://zhuanlan.zhihu.com/p/67878761    
3. [雷霄骅(翻译的命令含义)](https://blog.csdn.net/leixiaohua1020/article/details/12751349)





使用 FFmpeg 的路径 

  * 可以现在自己的 Linux 上装一个 FFmpeg , 然后使用命令行操作它 , 能比较快捷的体验到 FFmpeg 的功能和效果
  * 下面的命令解释都可以通过 `ffmpeg -h` / `man ffmpeg` 看到更原始的解释

视频压缩命令 

``` terminate 
/*
1. 此命令用到的命令分类有
    * Global options (affect whole program instead of just one file:
    * Video options:

*/


ffmpeg 
    -y                                  //覆盖输出文件
    -i /storage/emulated/0/1/input.mp4  //输入文件路径
    -b 2097k                            // 视频比特率(推荐使用 `-b:v`)
    -r 30                               // 帧率
    -vcodec libx264                     // 设置视频编码器( `-vcodec` 是 `-codec:v` 的别名)
    -preset superfast                   // 从 https://github.com/mabeijianxi/small-video-record 理解到, 应该是压缩速度
    /storage/emulated/0/1/result.mp4    // 文件输出路径

```