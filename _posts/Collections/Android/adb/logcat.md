在命令行查看应用日志很多时候比打开 IDE 更便捷。

```
adb shell
adb shell su

//search com.ryd 并查看对应 PID 号

//清空日志缓存
adb logcat -c   //如果没有进入  adb shell
logcat -c       //如果进入了 adb shell


logcat -v thread | grep --color=auto PID号
```


关于打印单个应用的日志
0. **已验证** : 查看进程 id(pid) `adb shell ps | grep packageName`
1. **已验证** : `logcat -v thread | grep --color=auto PID号`
  - PID 可以使用 top 命令根据包名查看
2. **待验证** : `adb logcat ‑d | grep com.xxxx.xxx`

3. **已验证** : `adb logcat --pid=7319 --format color --dividers --file=`
4. **已验证 , 控制台和文件都会记录** : `adb logcat --pid=32548  --format color --dividers | tee /Users/tom/Desktop/log.log`
5. 根据包名查找 ID 然后展示日志 : https://stackoverflow.com/a/48004086/7707781
    ```
    adb logcat --pid=`adb shell pidof -s com.example.app`
    adb logcat --pid=$(adb shell pidof -s io.metamask)
    ```
