## Service拒绝服务
1. __描述：__ 当组件没有全面的处理所接收到的外部调用请求信息时容易因为畸形数据处理不完善导致应用崩溃表现形式为 `"xxxx"已停止运行`。
2. __触发条件:__ 
    1. Service组件处于导出状态。
        - 在AndroidManifest.xml文件中 `<service></service>` 节点属性设置了 `android:exported=true`
        - 在AndroidManifest.xml文件中 `<service></service>` 节点子节点设置了 `<intent-filter></intent-filter>`
        - 在AndroidManifest.xml文件中 `<service></service>` 节点属性未设置 `android:permission=str`
    2. 对于一个没有权限的导出的Service组件，如果在组件类中没有合理的畸形数据的处理逻辑就会造成应用拒绝服务(`"xxxx"已停止运行`)。
3. __修复建议：__ 
    - 禁止不必要的组件声明为android:exported=true
    - 组件之间的数据交互务必做好异常处理。
4. __风险等级：__ 高

如果同时设置了 exported 和 intent-filter 遵从 exported

### Question
当前碰到的问题是：
1. 使用 `adb: root@hammerhead:/ # am startservice -n com.testin.cn.TestAPK/.DenialOfService.TestServic` 
    ```
    //activity控制台：
    Unable to start service Intent { cmp=com.testin.cn.TestAPK/.DenialOfService.TestServic } U=0: not found

    //cmd 启动反馈
    root@hammerhead:/ # am startservice -n com.testin.cn.TestAPK/com.testin.cn.TestAPK.DenialOfService.TestServic
    Starting service: Intent { cmp=com.testin.cn.TestAPK/.DenialOfService.TestServic }
    Error: Not found; no service started.
    ```
2. 暂时未了解到 adb 通过 action 的启动命令是什么。

3. 通过 drozer 
    ```
    dz> run app.service.start --component com.testin.cn.TestAPK com.testin.cn.TestAPK.DenialOfService.TestServic

    //AndroidStudio 控制台：
    W/ActivityManager: Unable to start service Intent { cmp=com.testin.cn.TestAPK/.DenialOfService.TestServic (has extras) } U=0: not found
    ```

4. 通过 drozer 没有任何问题，可以成功攻击也可以达到 attacker 的意图。
    ```
    run app.service.start --action HelloTestService --extra string msg Helly_guy
    ``` 
5. 上边的 4 条都不用管了，我已经自己写应用证明可行。