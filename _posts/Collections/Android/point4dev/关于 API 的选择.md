
问题: 
1. 两个库
2. 一个库支持 7 个 abi 架构 , 另一个库仅支持 3 个 abi 架构 , 
3. 支持7个 abi 的库已经集成了
    - 'armeabi', 'armeabi-v7a', 'x86' , 'arm64-v8a', 'x86_64', 'mips', 'mips64'
4. 支持3个abi 的计划集成, 如果影响不大再集成
    - 'armeabi', 'armeabi-v7a', 'x86'


> abiFilters 'armeabi', 'armeabi-v7a', 'x86' , 'arm64-v8a', 'x86_64', 'mips', 'mips64'

关于兼容性影响

ARMv7 (从2010年起)- **只在网络上找到这样的说法,没有出处**
- 第7代及以上的 ARM 处理器。2011年15月以后的生产的大部分Android设备都使用它

微信支持的 abi 架构
- AndroidStudio apk分析 可知 只有 armeabi-v7a

综上我们可以降低当前的 abi 支持为 仅支持  'armeabi', 'armeabi-v7a', 'x86'

参考
1. https://www.jianshu.com/p/44650eaceb18
2. https://developer.android.com/ndk/guides/abis#android-%E5%B9%B3%E5%8F%B0-abi-%E6%94%AF%E6%8C%81
