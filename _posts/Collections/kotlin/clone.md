


kotlin 克隆对象的方法

1. [继承 kotlin.Cloneable](https://kotlinlang.org/docs/java-interop.html#clone)
    - 这种方式的问题在于某些对象属性不是真正的克隆 , 而是引用复制
    ```kotlin
    class TetrisSquareDelegate : SquareDelegate(), Cloneable {
        var calculateWidth: Int = 0        /*控件水平尺寸(宽度) , 在 OnMeasuer 计算得出*/
        var calculateHeight: Int = 0       /*控件垂直尺寸(高度) , 在 OnMeasuer 计算得出*/

        public override fun clone(): TetrisSquareDelegate {
            return super.clone() as TetrisSquareDelegate
        }
    }
    ```

2. Gson 序列化/反序列化
    - 这种方式当需要 clone 的类是子类的时候需要额外代码 , **不推荐这一思路**
        1. 
    - 异常信息:`Unable to invoke no-args constructor for interface kotlin.Lazy. Registering an InstanceCreator with Gson for this type may fix this problem.`
        - 反序列化对象中存在 by lazy 参数也会导致此异常
    ```kotlin
    /** 快速复制对象 , 不只是复制索引
    * 也可以通过对象继承 kotlin.Cloneable 实现这一能力
    * */
    inline fun <reified T> Any.cloneObj(): T {
        return this.toJsonString().toObjFromJsonString<T>()
    }

    inline fun Any.toJsonString(): String = Gson().toJson(this)

    inline fun <reified T> String.toObjFromJsonString(): T = Gson().fromJson(this, T::class.java)
    ```

3. 反序列化子类问题可以参考
    1.  [关键类](https://github.com/google/gson/blob/master/extras/src/main/java/com/google/gson/typeadapters/RuntimeTypeAdapterFactory.java)  : [文档](https://www.javadoc.io/doc/org.danilopianini/gson-extras/0.2.1/com/google/gson/typeadapters/RuntimeTypeAdapterFactory.html)
    2. [Google已经发布了自己的RuntimeTypeAdapterFactory来处理多态性，但不幸的是，它不是gson核心的一部分（您必须将类复制并粘贴到项目中）。](https://stackoverflow.com/a/47307541/7707781)

