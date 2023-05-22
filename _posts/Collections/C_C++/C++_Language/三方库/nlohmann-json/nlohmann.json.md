
记录 关于 json 库 https://json.nlohmann.me/ 的一点使用方法。

不需要下载安装
1. 拷贝 json.hpp
2. 编译时候增加 `-I '/volume/_document/c_cpp_program/nameless_carpool/libs/nlohmann_json_3.10.5'` 即可 


具体的使用细节: [readme 文件还挺好的](https://github.com/nlohmann/json )

关于细节三使用方式 ， 我们还是 : 记录星星点点自己用到的点。


## 0x01. 已知不可用的需求

### 1.1. json 未知类型兼容转换

```json
{
    "headerOne":11111,
    "headerTwo":"two"
}
```

以上 json 无法自动转 `map<string, any>` , 也无法自动转 `map<string, string>` 





## 0x02. 已知可用


### 更详细的异常信息

https://json.nlohmann.me/home/exceptions/#serialization-issues

通过 定义 `# define JSON_DIAGNOSTICS 1` 在损失性能的情况下提供更详细的解析异常信息 . 

关于宏 , 
1. 由两个 : 入侵与否         
2. 有两个 : 支持默认值与否

### 自定义转换异常




