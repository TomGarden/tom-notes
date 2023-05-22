## 0x00、 说明
在制作 Tom Theme 的过程中遇到诸多小问题。
这里是关于小问题的记录及其解决。

## 0x01、 style.xml 文件中的代码相关问题

**关于 style.xml 文件中 `<item>` 的 `name` 属性值是否带有 `android:` 字段的原因和细节是什么？**
- 未找到官方解释
- 民间的说法“colorPrimary，colorPrimaryDark都是5.0的md开始有的。因此直接android:colorPrimary是错误的，当然这个可以放到values-v21/style.xml下”
- 个人总觉的还差点什么


**`tools:targetApi` 是什么意思**
- [官方解释](https://developer.android.com/studio/write/tool-attributes)
- 其工作原理和注解 `@TargetApi` 相同
- This tells the tools that you believe this element (and any children) will be used only on the specified API level or higher. This stops lint from warning you if that element or its attributes are not available on the API level you specify as your minSdkVersion.

## 0x02、 小插曲
