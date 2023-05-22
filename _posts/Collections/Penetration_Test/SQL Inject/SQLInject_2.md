## POST 注入

```
  Request:
    These options can be used to specify how to connect to the target URL

    --data=DATA         Data string to be sent through POST
    --cookie=COOKIE     HTTP Cookie header value
    --random-agent      Use randomly selected HTTP User-Agent header value
    --proxy=PROXY       Use a proxy to connect to the target URL
    --tor               Use Tor anonymity network
    --check-tor         Check to see if Tor is used properly

```

## 针对指定字段注入
```
http://entities.caixin.com/api/person/search/?param={"keyword":"123","page":1}&callback=_jsonpbkh6xwrg81bawcdi
```
例如上文 123 替换成 *** 从而完成注入。