## 我们是要验证用户是否使用了系统软键盘(针对静态代码审计)

使用系统软键盘的方式
1. 代码主动调用
    - 可检测
2. 使用系统控件默认调用
    - 暂未发现检测方法

使用自定义软键盘方式
1. 我们考虑使用自定义软键盘的流程
    1. 自定义软键盘控件
    2. 监听文字输入控件的点击或者焦点
    3. 当目标控件处于应该弹出键盘的状态时候(点击或者获取焦点默认弹出系统键盘的时候)
        - 禁止系统键盘弹出
        - 并且调用自定义键盘
2. 所以我们要检测用户是否使用了自定义键盘只要检测工程中是否存在禁止系统键盘调用的代码。
    - 关于隐藏系统键盘的代码有三种
        1. 系统服务
            ```java
            //获取系统关于软键盘的服务(Obj)
            InputMethodManager imm = (InputMethodManager) getSystemService(Context.INPUT_METHOD_SERVICE);
            //调用 API 阻止系统软件盘弹出
            imm.hideSoftInputFromWindow(view.getWindowToken(), 0);
            ```        
        2. Manifest 中 Activity 属性    
            ```xml
            android:windowSoftInputMode="stateAlwaysHidden|stateHidden"
            ```
        3. 控件属性
            ```java
            EditText.setShowSoftInputOnFocus(false)
            ```


## Reference
1. https://segmentfault.com/a/1190000012279204
2. https://zhidao.baidu.com/question/809060758250851932.html
3. http://blog.csdn.net/qq_36327466/article/details/73527772
4. https://www.jianshu.com/p/0ad76e854a8e
5. https://developer.android.com/guide/topics/manifest/activity-element.html