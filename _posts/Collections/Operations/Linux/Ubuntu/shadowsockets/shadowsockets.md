## shadowsocks.usage

    GitHub : https://github.com/shadowsocks/shadowsocks/wiki/Shadowsocks-使用说明

检查日志：sudo less /var/log/shadowsocks.log

1. To run in the foreground: ssserver -c /etc/shadowsocks.json  

2. To run in the background:
      - ssserver -c vpn_folder/shadowsocket.one.json -d start
      - ssserver -c /etc/shadowsocks.json -d stop
3. 上述几个命令路径根据自己的配置设置


## shadowsockets-libev
- /etc/init.d/shadowsocks-libev  start
- /etc/init.d/shadowsocks-libev  stop
 
* config file: `sudo vim /etc/shadowsocks-libev/config.json`

- 查看日志 ： journalctl -u shadowsocks-libev

## shadowsocks.more.person.json
```json
{
    "server":"2001:19f0:5401:1dbf:5400:02ff:fe18:7034",
    "server_port":443,
	"local_address": "127.0.0.1",
	"local_port":1083,
	"port_password":
	{
            "2048": "2019-06-08 09:42:24",
            "3072": "F00E6D753C7AC049124C9424A30F9228",
            "4096": "f00e6d753c7ac049124c9424a30f9228",
            "80": "771365380@qq.com",
            "443": "771365380@qq.com",
            "3306": "771365380@qq.com",
            "8381": "771365380@qq.com",
            "8382": "771365380@qq.com",
            "8383": "17611261931_*",
            "8384": "771365380@qq.com",
            "8385": "ybw_2018_12_10_*",
            "8386": "yqx_2018_12_10",
            "8387": "hy_2018_12_10_*",
            "8378": "yl_2018_12_10",
            "8389": "null_2018_12_10",
            "9090": "yh_2019_5_15"
	},
	"timeout":300,
	"method":"chacha20-ietf-poly1305",
	"fast_open": false
}
```

## shadowsocks.json

```json
{
    "server":"104.225.154.124",
    "server_port":8887,
    "local_address": "127.0.0.1",
    "local_port":1087,
    "password":"771365380@qq.com",
    "timeout":300,
    "method":"aes-256-cfb",
    "fast_open": false
}
```

```json
{
    "server":"2001:19f0:5:991:5400:02ff:fe1d:12e1",
    "server_port":9999,
    "local_address": "127.0.0.1",
    "local_port":1083,
    "password":"46A636CEF6ADCEB74DC8A09463DE45F4",
    "timeout":300,
    "method":"chacha20-ietf-poly1305",
    "fast_open": false,
    "plugin":"/usr/local/bin/obfs-server",
    "plugin_opts": "obfs=http"
}

/*当前正在使用的配置*/
{   
    "server":"2001:19f0:7001:4abc:5400:02ff:fe1f:9452",
    "server_port":9999,
    "password":"46A636CEF6ADCEB74DC8A09463DE45F4",
    "timeout":600,
    "method":"chacha20-ietf-poly1305",
    "fast_open": false,
    "plugin":"/usr/local/bin/obfs-server",
    "plugin_opts": "obfs=http"
}

```

## method chacha20-ietf-poly1305 not supported
```sh
#!/bin/bash
# If you suppose your server supports chacha and salsa,
# this script must be run.
wget https://download.libsodium.org/libsodium/releases/libsodium-1.0.15.tar.gz
tar xvzf libsodium-1.0.15.tar.gz
cd libsodium-1.0.15
./configure
make
make install
cd ..
echo /usr/local/lib > /etc/ld.so.conf.d/usr_local_lib.conf
ldconfig
```