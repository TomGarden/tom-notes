# /bin/bash^M: bad interpreter: No such file or dire 

在执行shell脚本时提示这样的错误主要是由于shell脚本文件是dos格式，即每一行结尾以\r\n来标识，而unix格式的文件行尾则以\n来标识。

  查看脚本文件是dos格式还是unix格式的几种办法。

1. cat -A filename  从显示结果可以判断，dos格式的文件行尾为^M$，unix格式的文件行尾为$。
2. od -t x1 filename 如果看到输出内容中存在0d 0a的字符，那么文件是dos格式，如果只有0a，则是unix格式。
3. vi filename打开文件，执行 : set ff，如果文件为dos格式在显示为fileformat=dos，如果是unxi则显示为fileformat=unix。

  解决方法：
1. 使用linux命令dos2unix filename，直接把文件转换为unix格式
2. 使用sed命令sed -i "s/\r//" filename  或者 sed -i "s/^M//" filename直接替换结尾符为unix格式
3. vi filename打开文件，执行 : set ff=unix 设置文件为unix，然后执行:wq，保存成unix格式。