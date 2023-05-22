# Zip文件目录遍历检测

## 一、漏洞原理
```java
    /**
     * 解压文件
     *
     * @param filePath 压缩文件路径
     */
    public static void unzip(String filePath) {
        File source = new File(filePath);
        if (source.exists()) {
            ZipInputStream zis = null;
            BufferedOutputStream bos = null;
            try {
                zis = new ZipInputStream(new FileInputStream(source));
                ZipEntry entry;
                while ((entry = zis.getNextEntry()) != null && !entry.isDirectory()) {
                    //开始关注
                    File target = new File(source.getParent(), entry.getName());
                    if (!target.getParentFile().exists()) {
                        target.getParentFile().mkdirs();
                    }
                    //结束关注
                    bos = new BufferedOutputStream(new FileOutputStream(target));
                    int read;
                    byte[] buffer = new byte[1024 * 10];
                    while ((read = zis.read(buffer, 0, buffer.length)) != -1) {
                        bos.write(buffer, 0, read);
                    }
                    bos.flush();
                }
                zis.closeEntry();
            } catch (IOException e) {
                throw new RuntimeException(e);
            } finally {
                IoUtil.closeQuietly(zis, bos);
            }
        }
    }
```
上述是文件解压的一般性操作，核心代码一般差异不大。

我们又知道：在创建文件 `File` 对象的过程中，如果路径中含有 `../` 是可以造成目录回溯的。



## 二、风险描述
Zip 文件目录遍历发生在 java API 的运用过程。涉及到的 package 为 `java.util.zip` 。

如果该 API 使用不当攻击者可以通过目录目录回溯和文件替换来完成它的意图。

具体有可能对开发商和用户造成的伤害需要用户结合自己的业务场景进行判断。

## 三、攻击手法
1. 查看应用业务逻辑，并结合其业务逻辑判断其文件解压路径。
2. 通过构造包含自己意图的压缩包，可以把我们自己构造的压缩包中的任何文件放到依赖于应用权限所能到达的任何位置。
    - 根据不同的应用业务逻辑可以细节有所不同。
3. 攻击完成。

## 四、修复建议
1. 对即将解压的文件件进行数据完整性校验。
2. 对 `ZipEntry.getName()` 字段进行 `../` 筛查。
    ```java
    ZipEntry.getName().contents("../");
    ```

## 五、局限性
我们以上代码审计仅针对 JAVA 原生 API 对使用三方或者开源代码的程序没有校验能力。

但是这个思维是可以复用于软件开发的。