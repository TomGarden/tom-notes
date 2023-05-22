## 一、 关于大概的使用方式我们已经明晰了
> 后来发现这只是两种使用方式中的一种
1. 编写包含 native 方法的 .java 文件
2. 将该 .java 文件编译为 .calss 文件
3. 使用 javah 命令生成 .h 文件
4. 编写和 .h 对应的 .cpp 文件
5. 调用 native 方法
6. 完成

参考：http://www.cnblogs.com/mandroid/archive/2011/06/15/2081093.html

## 二、 细节
上述几个步骤应该是可以变通的，所以展现形式上可能略有不同，比如一个 project 中可能没有 .h 文件，只有 .cpp 文件。

## 三、 观察到的
1. 包含 native 方法的类生成的对应的 .h 或者 .cpp 文件的文件名：
    - .java 文件路径：`I:\AOSP\android-4.4.4_r1\libcore\luni\src\main\java\libcore\io\Posix.java`
    - .cpp  文件路径：`I:\AOSP\android-4.4.4_r1\libcore\luni\src\main\native\libcore_io_Posix.cpp`
2. .java 文件中的 native 方法名对应的 .h 或者 .cpp 文件中的方法名：
    - .java -> `public native StructStat stat(String path) throws ErrnoException;`
    - .h/.cpp -> `static jobject Posix_stat(JNIEnv* env, jobject, jstring javaPath)`

## 四、 疑问
1. 参数多了两个，返回值有点看不懂
    - 这一点了解过 JAVA 和 C 相对应的数据类型之后可以理解
3. 当前有一个不大理解的事情发生在：
    - I:\AOSP\android-4.4.4_r1\libcore\dalvik\src\main\java\dalvik\system\DexFile.java
        - native private static int openDexFileNative(String sourceName, String outputName, int flags) throws IOException;
    - I:\AOSP\android-4.4.4_r1\dalvik\vm\native\dalvik_system_DexFile.cpp
        - static void Dalvik_dalvik_system_DexFile_openDexFileNative(const u4* args, JValue* pResult)
    * 这一个对应关系就根本看不懂了

## Reference
1. [JNI完全指南(一)——数据类型](https://www.zybuluo.com/cxm-2016/note/563686)