
## 布局和绑定表达式

比较容易理解就是在 布局文件中 设置对象应用节点 , 通过框架可以识别的语法直接将对象中的属性设置到 布局 中对应的元素上

这种绑定方式的局限性在于 , 当绑定到某个元素上的属性值 发生变化的时候 , 不具备同时通知 UI 元素更新的能力

## 使用可观察的数据对象

1. ObservableXxxxx
2. 手动继承 Observable
    ```kotlin   
    class User : BaseObservable() {

        @get:Bindable
        var firstName: String = ""
            set(value) {
                field = value
                notifyPropertyChanged(BR.firstName)
            }

        @get:Bindable
        var lastName: String = ""
            set(value) {
                field = value
                notifyPropertyChanged(BR.lastName)
            }
    }
    ```

在数据变化的时候可以事实通知到 视图 使视图与最新的数据保持一致

## 