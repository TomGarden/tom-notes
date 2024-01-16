
```
Version 10.18.11
UI Version: 10.18.11-ui-231003-1330
Desktop Platform Version: 10.18.10 (10.18.10)
```


postman 允许使用 Environment 变量 `{{value}}` , 在发起请求的时候我们可以这样
- `{{1007HOST}}/{{PrefixPath}}/statistics/user_income`

但是当 mock 的时候 , 存在两个变量的 url 始终没有被有效解析
```html
<!-- 始终解析失败 , 无法实际上完成 mock 动作 -->
{{1007MOCK_HOST}}/{{PrefixPath}}/statistics/user_income

<!-- 解决是通过多次尝试 , 发现可能和变量名数量有关 
     1. 尝试将 {{1007MOCK_HOST}}/{{PrefixPath}} 合并成一个变量 {{1007mock_host_whtih_prefix_path}} 错误依旧
     2. {{PrefixPath}} 不再使用变量 , 用路径值替换后可行了. 
 -->

{{1007MOCK_HOST}}/Prefix/Path/statistics/user_income
```

不知道是功能没用明白还是有 bug 