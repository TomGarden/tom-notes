# BroadcastReceiver 拒绝服务

1. __描述：__ 当组件没有全面的处理所接收到的外部调用请求信息时容易因为畸形数据处理不完善导致应用崩溃表现形式为 `"xxxx"已停止运行`。
2. __触发条件:__ 
    1. BroadcastReceiver组件处于导出状态。
        - 在AndroidManifest.xml文件中 `<receiver></receiver>` 节点属性设置了 `android:exported=true`
        - 在AndroidManifest.xml文件中 `<receiver></receiver>` 节点子节点设置了 `<intent-filter></intent-filter>`
        - 在AndroidManifest.xml文件中 `<receiver></receiver>` 节点属性未设置 `android:permission=str`
    2. 对于一个没有权限的导出的 BroadcastReceiver 组件，如果在组件类中没有合理的畸形数据的处理逻辑就会造成应用拒绝服务(`"xxxx"已停止运行`)。
3. __修复建议：__ 
    - 禁止不必要的组件声明为android:exported=true
    - 组件之间的数据交互务必做好异常处理。
4. __风险等级：__ 高


