## 0x01、 获取指定文件夹中的文件名字

```bash
apk_dir_path="/media/tom/document/code/AndroidStudio/Tetris-2018/other_APK"

filenames=$(ls $apk_dir_path)

for filename in $filenames
do
   echo $filename
done
```
名字中带有空格，将带有空格的文件名理解为多个文件名了。
```bash
//这个能很好的工作https://stackoverflow.com/questions/7039130/iterate-over-a-list-of-files-with-spaces
ls $apk_dir_path | while read filename
do
   echo ${filename};
done
```