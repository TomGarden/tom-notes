## 一、 背景
从代码阅读中我们间歇性记录的一点小细节。

## 二、 细节们
关键文件:`android-4.4.4_r1\dalvik\libdex\DexFile.h`


|Dex 文件结构|
|-----------|
|DexHeader  |



















## 三、 代码
### 3.1、 基础数据
```C++
/*
 * These match the definitions in the VM specification.

    unit*_t : * 代表 bit(位) uint8_t 代表无符号整数所占内存为 1字节(8bit)
    u* 或者 s*  : * 代表字节 u1 说明，u1 所表示的数据所占内存为 1字节。
 */
typedef uint8_t             u1;
typedef uint16_t            u2;
typedef uint32_t            u4;
typedef uint64_t            u8;
typedef int8_t              s1;
typedef int16_t             s2;
typedef int32_t             s4;
typedef int64_t             s8;
```

### 3.2、 DexHeader
```C++
/*
 * Direct-mapped "header_item" struct.
 */
struct DexHeader {
    u1  magic[8];           /* includes version number */
    u4  checksum;           /* adler32 checksum */
    u1  signature[kSHA1DigestLen]; /* SHA-1 hash */
    u4  fileSize;           /* length of entire file */
    u4  headerSize;         /* offset to start of next section */
    u4  endianTag;
    u4  linkSize;
    u4  linkOff;
    u4  mapOff;
    u4  stringIdsSize;
    u4  stringIdsOff;
    u4  typeIdsSize;
    u4  typeIdsOff;
    u4  protoIdsSize;
    u4  protoIdsOff;
    u4  fieldIdsSize;
    u4  fieldIdsOff;
    u4  methodIdsSize;
    u4  methodIdsOff;
    u4  classDefsSize;
    u4  classDefsOff;
    u4  dataSize;
    u4  dataOff;
};
```
对于符合规范的 DEX 文件来说：
1. magic 所占内存为 8 字节 64 位。
    - 前四字节代表`#define DEX_MAGIC       "dex\n"`
    - 后四字节有两种可能
        - 新版本 API(13,+∞) ：`#define DEX_MAGIC_VERS  "036\0"`
        - 旧版本 API(-∞,13] ：`#define DEX_MAGIC_VERS_API_13  "035\0"`
    - 用表格表示：

        |API\Byte Index |0|1|2|3 |4|5|6|7 |
        |----------     |-|-|-|--|-|-|-|--|
        |API(13,+∞)     |d|e|x|\n|0|3|6|\0|
        |API(-∞,13]     |d|e|x|\n|0|3|5|\0|