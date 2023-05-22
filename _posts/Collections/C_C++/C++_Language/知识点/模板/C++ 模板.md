

对模板的理解
```c++
template<typename T>
class OneClass {
  T flagT;
  T& optT(T& t) {
    /* 对 t 做操作并返回t 本身 */
    return t;
  }
}
```

## 限制模板参数的 范围

网络搜索结果 : 
1. https://blog.csdn.net/artorias123/article/details/106867488
2. https://stackoverflow.com/questions/874298/c-templates-that-accept-only-certain-types
3. 