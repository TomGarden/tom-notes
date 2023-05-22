# apk 调用 linux 命令
调用 Linux 命令实际上就是运行 Linux 程序。

根据我们平时的使用经历可以知道 Linux 命(程)令(序)在被调用时候的表现形式为 `输入——输出`

这里存在两种情况
1. 有些命令如 `ls` 能很快执行完成并且给出反馈。
2. 另一些如 `ping` 这是一个持续的命令在停止他之前这个应用会不断的输出。

面对第一种情况我们可以查看输出内容通过如下代码
```java
    private void listenTouch() {
        try {
            Process p = Runtime.getRuntime().exec("ls");
            
            String data = null;
            BufferedReader ie = new BufferedReader(new InputStreamReader(p.getErrorStream()));
            BufferedReader in = new BufferedReader(new InputStreamReader(p.getInputStream()));
            String error = null;
            while ((error = ie.readLine()) != null && !error.equals("null")) {
                //data += error + "\n";
                Log.e("getevent", error);
            }
            String line = null;
            while ((line = in.readLine()) != null && !line.equals("null")) {
                //data += line + "\n";
                Log.d("getevent", line);
            }

            Log.v("ls", data);
        } catch (IOException e) {
            e.printStackTrace();
        }
        Log.d("OVER", " ^_^   OVER   ^_^ ");
    }
```

但是面对第二种情况，我们的需求是执行 `getevent` 命令，这个命令在我们手动将其结束前不会自动结束。为了满足我们的需求(判断某个命令是否可执行)使用如下方法得以解决
```java
    private void listenTouch() {
        try {
            Process p = Runtime.getRuntime().exec("su -c getevent -c 10");
            //命令释义 [su -c]以 su 身份执行 -c 之后的命令；[getevent -c 10]打印 10 条数据后退出
            BufferedReader ie = new BufferedReader(new InputStreamReader(p.getErrorStream()));
            BufferedReader in = new BufferedReader(new InputStreamReader(p.getInputStream()));

            String error = null;
            while ((error = ie.readLine()) != null && !error.equals("null")) {

                Log.e("getevent", error);
            }
            String line = null;
            while ((line = in.readLine()) != null && !line.equals("null")) {

                Log.d("getevent", line);
            }
        } catch (IOException e) {
            e.printStackTrace();
        }
        Log.d("OVER", " ^_^   OVER   ^_^ ");
    }
}
```