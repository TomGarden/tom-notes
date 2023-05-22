NDK 研究新方向：https://developer.android.com/ndk/reference/group___storage.html

## 一、 (正常应用级别)控制私有目录的权限
正常应用要控制文件的权限除了只能 API 。

目前已知的相关 API 包括
1. __接口__ Context.openFileOutput
    - 涉及检测点：内部存储文件安全检测
2. __接口__ Context.openOrCreateDatabase
    - 涉及检测点：Database配置模式风险检测
3. SharedPreferences.getSharedPreferences
    - 涉及检测点：SharedPreference风险

证实上述 API 已经收集全面了
- 我们已经不能举出反例了。

## 二、 试验现象
通过 `openFileOutput` 创建文件并查看
```java
//创建
openFileOutput("MODE_PRIVATE", Context.MODE_PRIVATE);
openFileOutput("MODE_WORLD_READABLE", Context.MODE_WORLD_READABLE);
openFileOutput("MODE_WORLD_WRITEABLE", Context.MODE_WORLD_WRITEABLE);
openFileOutput("MODE_APPEND", Context.MODE_APPEND);

//查看
root@hammerhead:/data/data/tom.work.foxmail.com.dronefortwo_three/files # ls -l
-rw-rw---- u0_a127  u0_a127         0 2017-11-20 14:00 MODE_APPEND
-rw-rw---- u0_a127  u0_a127         0 2017-11-20 16:23 MODE_PRIVATE
-rw-rw-r-- u0_a127  u0_a127        11 2017-11-20 16:23 MODE_WORLD_READABLE
-rw-rw--w- u0_a127  u0_a127        11 2017-11-20 16:23 MODE_WORLD_WRITEABLE
```

使用 adb shell 命令尝试读取几个文件，只有 `MODE_WORLD_READABLE` 可读，其余文件因为不可读：`open failed: EACCES (Permission denied)`

使用另外的应用(签名不同)尝试读取,只有 `MODE_WORLD_READABLE` 可读，其余文件因为不可读：`open failed: EACCES (Permission denied)`

读取文件代码
```java
//获取了 ReadExternalStorage 权限
    public String switchLines() throws IOException {
        //File file = new File("/data/data/tom.work.foxmail.com.dronefortwo_three/files/MODE_WORLD_READABLE");//Text文件
        File file = new File("/data/data/tom.work.foxmail.com.dronefortwo_three/files/MODE_WORLD_WRITEABLE");//Text文件
        if (!file.exists()) {
            Log.w(Tag, "文件不存在");
        }
        StringBuffer stringBuffer = new StringBuffer();
        BufferedReader br = new BufferedReader(new FileReader(file));//构造一个BufferedReader类来读取文件
        String s = null;
        while ((s = br.readLine()) != null) {//使用readLine方法，一次读一行
            stringBuffer.append(s);
        }
        return stringBuffer.toString();
    }
```

## 三、 思考
可以认定 `私有目录权限风险监测` 和 `上述相关的三个检测点` 重复。

## 四、 检测手段变更
私有目录权限风险，完全可以复用上述相关的三个检测点的检测手段。