#!/bin/bash
#作用：使用 apktool 批量处理 apk 文件
#每次使用需要根据自身的环境状况使用这几个参数
apktool_path="/media/tom/tool/test_tool/apktool/2.3.4/apktool"
apk_dir_path="/media/tom/document/temp/apps"
apk_output_path="/media/tom/document/temp/apps"

ls $apk_dir_path | while read filename
do
   echo ">>>>>>>>>>${apk_output_path}/${filename}.apktool";
   ${apktool_path} decode "${apk_dir_path}/${filename}" --output "${apk_output_path}/${filename}.apktool"
done;


