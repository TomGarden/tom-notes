
HTTPS 原理

1. https://cloud.tencent.com/developer/article/1601995
2. https://help.aliyun.com/document_detail/160093.html

单向认证流程 稍微展开 
1. 客户端发起建立HTTPS连接请求，将SSL协议版本的信息发送给服务器端；
2. 服务器端将本机的公钥证书（server.crt）发送给客户端；
3. 客户端读取公钥证书（server.crt），取出了服务端公钥；
4. 客户端生成一个随机数（密钥R），用刚才得到的服务器公钥去加密这个随机数形成密文，发送给服务端；
5. 服务端用自己的私钥（server.key）去解密这个密文，得到了密钥R
6. 服务端和客户端在后续通讯过程中就使用这个密钥R进行通信了。

如果中间人尝试把自己的证书发给客户端 , 能否成功扮演中间人 ? 
由于申请证书需要想证书机构证明自己对域名的实际控制权 , 所以中间人要能获得正规机构的背书的证书 , 说明已经掌握了对我们服务器的控制 . https://letsencrypt.org/zh-cn/getting-started/

证书机构选择
1. 介绍性内容 : https://zhuanlan.zhihu.com/p/174755007
2. 预选项
   - https://letsencrypt.org/zh-cn
   - https://ohttps.com/