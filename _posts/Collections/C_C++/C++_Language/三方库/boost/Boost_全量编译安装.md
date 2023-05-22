
我们在尝试自己编写 日期 类的过程中 , 发现这每一个细节领域的内容都足够繁杂的占用开发者的所有精力 , 
现在我们需要一个更强大的库来让自己把精力更多放在自己的业务逻辑上 . 

安装说明 , 
```
./bootstrap.sh && ./b2 install
```

如果想要删除手动编译安装的 boost  , 这里有可以参考的内容 , https://www.cnblogs.com/tengzijian/p/15057379.html
1. 手动删除安装的头文件和库
```
sudo rm -f /usr/local/lib/libboost*
sudo rm -rf /usr/local/include/boost
```
2. 删除 /usr/local/lib/cmake 中残留文件
```
/* 搜索整个 /usr 目录，结果在 /usr/local/lib/cmake 发现一些 boost 1.76.0 的残留文件。 */
sudo rm -rf /usr/local/lib/cmake/*-1.76.0*
```