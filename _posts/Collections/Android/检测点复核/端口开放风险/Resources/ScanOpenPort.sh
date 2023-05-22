#!/bin/bash

# 这个脚本终于因为 Android 平台上的命令行应用不够用(或者说我不会用)，而没有最终完成

#run the script you need tools:netstat,grep,echo,cut

#method
function getPortNumber()
{
    echo $1
    OLD_IFS="$IFS"
    IFS=":"
    arr=($1)
    IFS="$OLD_IFS"
    
#    for s in ${arr[@]}
#    do 
#	     echo "$s"
#    done

    length=${#arr[@]}-1
    echo $length
    #echo ${arr[$length]}

    return ${arr[$length]}
}


#get ports which our care
netstatResult=$(netstat -nautw | grep -E "LISTEN|ESTABLISHED|SYN_SENT|SYN_RECV")
echo "$netstatResult"
echo "*************************************************************"

#get "Local Address"
#echo "$netstatResult" | while read i
#do
#    echo $i | cut -f4 -d ' '
#done
#echo "*************************************************************"


#get port only
echo "$netstatResult" | while read i
do
    #get "Local Address"
    LocalAddress=$(echo $i | cut -f4 -d ' ')
       
    #echo  $LocalAddress

    #call method , we get error result , because number is large very march
    #getPortNumber $LocalAddress
    #echo $?

    #gerport only
    OLD_IFS="$IFS"
    IFS=":"
    arr=($LocalAddress)
    IFS="$OLD_IFS"
    length=${#arr[@]}-1
    port=${arr[$length]}
    #echo $port
 
    #port decimal to hexadecimal
    echo "obase=16;$port" | bc	#don't work
    #printf %x $port		#don't work
done 



#get ports

















## reference
#1. [Linux字符串截取和处理命令 cut、printf、awk、sed、sort、wc](https://www.cnblogs.com/zhaolili/p/5299294.html)
