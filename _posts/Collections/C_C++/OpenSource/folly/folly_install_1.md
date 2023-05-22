## 一、环境
Ubuntu 16.04

## 二、动作思路(细节还是查看《参考 & 引用》)
1. 查看 GCC 版本是否满足需求。命令：`gcc --version`
2. 下载 googletest 并拷贝到 `folly/test`
3. 如果没有安装 bootst ：
  `sudo apt-get install libboost-all-dev`
  - 如果安装过，存在路径：`/usr/include/boost` ；这个路径通常称之为 boost 根目录
  - 上述是默认安装路径，如果没有使用默认安装，请参见原文：https://github.com/facebook/folly#linking-non-default-boost-libraries
4. 安装依赖
```terminal
sudo apt-get install \
    g++ \
    automake \
    autoconf \
    autoconf-archive \
    libtool \
    libboost-all-dev \
    libevent-dev \
    libdouble-conversion-dev \
    libgoogle-glog-dev \
    libgflags-dev \
    liblz4-dev \
    liblzma-dev \
    libsnappy-dev \
    make \
    zlib1g-dev \
    binutils-dev \
    libjemalloc-dev \
    libssl-dev \
    pkg-config
```
如果需要高级调试功能需要安装下述依赖(不知所云直接安装)
```terminal
sudo apt-get install \
    libunwind8-dev \
    libelf-dev \
    libdwarf-dev
```
因为系统版本的原因还需要依赖
```Terminal
sudo apt-get install \
    libiberty-dev
```
5. 与 folly 目录中依次执行如下命令
```terminal
autoreconf -ivf
./configure
make
make check
sudo make install
```


1. /bin/mkdir -p '/xxx/xxx/xxx'
  - 创建目标文件夹
  - -p, --parents         需要时创建目标目录的上层目录，但即使这些目录已存在也不当作错误处理
2. /usr/bin/install -c -m 644  xxx.h '/usr/local/include/folly/.'
  - 本命令在此处做的事情仅仅是将 xxx.h 按照 -m 指定的权限 copy 到指定目录(/usr/local/include/folly/.)。
  - -c 命令手册中：(ignore)
    - 手动尝试，如果上述命令删去 -c 依然正常执行
  - -m -m, --mode=模式       自行设置权限模式(像chmod)，而不是rwxr-xr-x

有了对上述命令的认知我们知道 make install 命令做事的部分细节：
1. 把 library 放到了 `/usr/local/bin`
2. 把头文件(.h)放到了 `/usr/local/include/folly`







## 参考 & 引用
1. https://github.com/facebook/folly




## 在 make check 阶段有 error
我们尝试按照网上的信息安装一个：https://github.com/google/double-conversion/releases
- http://blog.csdn.net/ice_actor/article/details/52795118
- http://blog.csdn.net/chenhaifeng2016/article/details/70756382

上述内容安装失败
