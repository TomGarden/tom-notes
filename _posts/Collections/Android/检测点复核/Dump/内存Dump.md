## dump 是什么
- 翻译：卸货;转嫁;
- 说明:Dump文件是进程的内存镜像。可以把程序的执行状态通过调试器保存到dump文件中。

## 内存 Dump 可以做什么

使用 IDA 的话只要没有反调 也就是 附加进程成功后没有任何防御动作。
那么可以 Dump 到任何内容，so dex 都可以。

## 如何 dump android 内存

1. ida运行脚本:两个脚本含义相同
    ```C
    auto i,fp,begin,end;
    fp=fopen("D:\\xx.so","wb");
    begin=0xAC338000;
    end=0xAC393000;
    for(i=begin ; i<end ; i++)
    {
        fputs(Byte(i),fp);
    }
    ```
    ```C
    auto fp, SoAddress; 
    fp = fopen("D:\\1.so", "wb"); 
    for ( SoAddress=0x753DA000; SoAddress< 0x75452000; SoAddress++ ) 
        fputc(Byte(SoAddress), fp);
    ```

    - __关于脚本使用__：我们需要根据自己的需求修改上述的地址。
    - __关于地址定位__

    - __脚本释义:__
    - fopen 函数原型： FILE * fopen(const char * path, const char * mode);
        - 文件指针名=fopen（文件名,使用文件方式）;
        - 参数 __`D:\\xx.so`__ 表示文件名
        - 参数 __`wb`__ 新建一个二进制文件，已存在的文件将被删除，只允许写
        - _在本例中，是用来创建一个文件的_
    - fputc 函数原型： int fputc (int c, FILE *fp)
        - 参数解释：fp为文件指针，它的值是执行fopen()打开文件时获得的。
        - c 为输出的字符量。
        - 虽然函数被定义为整形数，但仅用其低八位。
        - 返回值：在正常调用情况下，函数返回写入文件的字符的ASCII码值，出错时，返回EOF（-1）。当正确写入一个字符或一个字节的数据后，文件内部写指针会自动后移一个字节的位置。EOF是在头文件 stdio.h中定义的宏。
        - _本例中是用来把内存中的内容写入到刚创建的文件的_
    

2. gdb dump    
    dump binary memoryC:\Users\DW\Desktop\baidu_jiagu\so\baidu 0xa8878000 0xA8B9C000

3. dd命令     
 dd  if=/proc/1214/mem of=mmm skip=a8878000 ibs=1 count=324000 这个不行，网上误传

4. 修改内核     
dalvik/vm/oo/Class.cpp此文件的

 

initclass在加载cinit类的时候加入下面的代码

我们将so dump 

5. 自己写工具dump内存
    ```C
    #include<unistd.h> 
    #include<stdio.h> 
    #include<stdlib.h> 
    #include<android/log.h> 
    #include<elf.h> 
    #include<fcntl.h> 
    #include<android/log.h>

    //#define LOG_TAG"snow"
    //#defineLOGE(...)    __android_log_print(ANDROID_LOG_ERROR, LOG_TAG,__VA_ARGS__)
    //使用办法
    //xx pid beginaddrendaddr
    int  main(intargc,char *argv[]) {
    char filename[256] = {0};
    if(4!=argc)
    {
        printf("please input xx pid beginaddr endaddr\n");
        exit(1);
    }
    printf("argv[2]=%s-->argv[3]=%s-\n",argv[2],argv[3]);
    long long beginaddr = strtoll(argv[2],NULL,16);
    long long endaddr=strtoll(argv[3],NULL,16);
    long long length=endaddr-beginaddr;
    //printf("-fuck-length=%x---\n",length);
    //printf("beginaddr=%x,endaddr=%x-\n",beginaddr,endaddr);
    sprintf(filename,"/proc/%s/mem",argv[1]);
    printf("will open filepath=%s\n",filename);
    FILE* fpsrc=fopen(filename,"r");
    FILE* fpdest=fopen("dumpMemory","wb");
    if(NULL==fpsrc||NULL==fpdest)
    {
        printf("open file error!!!\n");
        exit(1);
    }
    int c;
    fseek(fpsrc,beginaddr,SEEK_SET)
    while((c=fgetc(fpsrc))!=EOF&&length-->0)
    {
        fputc(c, fpdest);
    }
    fclose(fpsrc);
    fclose(fpdest);
    return 0; 
    }

    LOCAL_PATH :=$(call my-dir)  
    include $(CLEAR_VARS)  
    LOCAL_LDLIBS += -L$(SYSROOT)/usr/lib -llog   
    #LOCAL_ARM_MODE := arm  
    LOCAL_MODULE    := dump  
    LOCAL_SRC_FILES := dump.c  
    include $(BUILD_EXECUTABLE)
    ```  

 

注意以上五种办法，目前的加壳都有反调试模块，会对mem文件进行检测，比如360会检测/proc/pid/mem文件，和监控maps文件故此上面读mem文件会导致闪退，，总的来说第四种办法最管用！！！！！


## 抄录
1. [Dump文件](https://baike.baidu.com/item/Dump%E6%96%87%E4%BB%B6/8897187?fr=aladdin)
2. [android dump内存办法大全 ](http://blog.csdn.net/kingdiggrave/article/details/53993315)
3. [c语言fopen函数](https://baike.baidu.com/item/c%E8%AF%AD%E8%A8%80fopen%E5%87%BD%E6%95%B0/1775995?fr=aladdin)
4. [fputc](https://baike.baidu.com/item/fputc/10942337?fr=aladdin)