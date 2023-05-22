`MutableList.indexOf(obj)` 获得的对象索引与实际值不同

原因是 mutableList 中的对象多数都具有相同的 hashCode , 默认的 indexOf 调用的是 equale 函数
equale 函数对比的就是 hashCode 用于判断二者是否相等