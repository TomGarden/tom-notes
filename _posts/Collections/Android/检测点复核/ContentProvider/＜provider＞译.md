>原址：https://developer.android.google.cn/guide/topics/manifest/provider-element.html

AndroidManifest.xml 文件 `<provider>` 节点
```xml
<provider android:authorities="list"
          android:directBootAware=["true" | "false"]
          android:enabled=["true" | "false"]
          android:exported=["true" | "false"]
          android:grantUriPermissions=["true" | "false"]
          android:icon="drawable resource"
          android:initOrder="integer"
          android:label="string resource"
          android:multiprocess=["true" | "false"]
          android:name="string"
          android:permission="string"
          android:process="string"
          android:readPermission="string"
          android:syncable=["true" | "false"]
          android:writePermission="string" >
    . . .
</provider>
```
### 1、 定位
- 父节点：`<application>`
- 子节点：`<meta-data>    <grant-uri-permission>    <path-permission>`

### 2、 概述
略
### 3、 属性
1. android:authorities    
指定一个或多个 authoritie ， authority 表示数据提供者(content provider)。当有多个 authority 的时候应该用 分号 ";"(semicolon)分隔。通常情况下 authority 值使用 java (反向域)风格 (例如：com.example.provider.cartoonprovider)。一般的，这是一个实现了 ContentProvider 的子类名，无默认值，必须指定。
  - 开发文档中建议我们使用反向域风格的命名方式。这意味着使用反向域风格实现我们的需求，几乎不成任何问题。值的注意的是，如果我们不听从其建议坚持用驼峰命名法的话，是有可能产生不可预知的问题的，这些不可预知问题的直接结果就是导致我们的应用无法按我们的预期运行。

2. android:enabled   
标记我们的 content provider 能否被系统实例化 —`true`可以 —`false`不可以。默认值是 true 。
`<application>` 元素也有 `enabled` 属性， `application` 的 `enable` 属性作用于其所有的子节点(这其中就包含`<provider>`)。要想 content provider 可以使用 `<application>、<provider>` 节点中的 `enable` 属性都必须设置为 `true` (即默认值)。如果任何一个为 `false` 那么 provider 不可用，因为该类无法实例化。

3. android:directBootAware    
标示 content provider 的 _direct-boot aware_ 状态。也就是说在用户未解锁设备的时候是否运行 我们的 provider 。  

    >注意：在 [Direct Boot](https://developer.android.google.cn/training/articles/direct-boot.html) 状态下您的应用只能访问 _device protected_ 存储空间的数据。(也就是说 android 出于安全考虑做了两个存储空间还有另一个，参见官方文档)。

    默认值是 `false`。

4. android:exported    
标示 content provider 是否可以被其他应用使用：
    - true：provider 可以被其他应用访问，任何 拥有指定 permission 的应用可以使用 provider 的 content URL 去访问它。
    - false：provider不允许其他应用访问法。 设置了 `android:exported="false` ，只有和本应用具有相同 user ID (UID)的应用可以访问它。

    本属性从 API level 17 开始引入，在所有 `API level <= 16` 的设备上 表现为 `android:exported=true` 。在 `API level >= 17` 的设备上 本属性的默认值为 false。

    你可以通过 设置 `android:exported=false` 以及使用  permission 属性来限制 其余应用对你 provider 的访问。

5. android:grantUriPermissions=["true" | "false"]  ：  授予 Uri 权限     
不具有权限的应用是否允许临时超越 ` readPermission, writePermission, permission ` 属性的权限限制，做被 xxPermission 限制的动作。 —"true" 权限允许临时授予。 —"false" 不允许。
如果 ture ，provider 的任何数据都可以被临时授权访问；如果 false ，只有在 ` <grant-uri-permission> ` 节点被声明的元素才可以被临时授权访问。
默认值是 false 。      
临时权限授予是一种方法，这种方法可以允许不具有权限的应用一次性的访问受权限保护的数据。例如，当一个 e-mail 消息包含了一个附件，邮件程序会选择合适的内容查看器来查看 该附件(该查看器没有访问provider中数据的权限，需要临时授予)。           
临时权限授予的操作，一般通过 Intent 对象中的 flage 标签来实现，例如：` FLAG_GRANT_READ_URI_PERMISSION 和 FLAG_GRANT_WRITE_URI_PERMISSION `。  在上述例子中：邮件程序 在 Intent 中设置 `FLAG_GRANT_READ_URI_PERMISSION` 然后调用 Context.startActivity()。该包含特定 URI 的 Intent 就具有了权限。       
如果启用了该特性，不论是通过 设置属性值为 true  还是定义 ` <grant-uri-permission> ` 子节点，当所涉及的 URI 要删除时 必须调用 Context.revokeUriPermission() 。      
[更多关于`<grant-uri-permission>`的内容](https://developer.android.google.cn/guide/topics/manifest/grant-uri-permission-element.html)

6. android:icon="drawable resource"     
这个content provider呈现的图标。这个属性必须设置为包含图片的drawable资源的引用。如果没有设置，由application指定的图标就会代替它（参见<application>元素的icon属性）。

7. android:initOrder="integer"       
用于协调provider被实例化的次序，本属性是相对于同一进程中的其他 content provider 而言。当多个 content provider 相互依赖的时候，为他们设置这个属性，可以确保它们按照各自的依赖次序有序的实例化。这个值是一个 integer 数据，这个值越高，其 provider 越早被实例化。

8. android:label="string resource"       
供用户阅读的 Content Provider 的文本标签。 如果未设置本属性，则用全局性的应用程序文本标签代替（参阅 <application> 元素的 label 属性）。    
本文本标签应该设为对字符串资源的引用，这样就能像用户界面中的其他字符串一样对其进行本地化。 不过为了应用程序开发时的便利，也可以直接设置为字符串。

9. android:multiprocess=["true" | "false"]       
如果应用运行于多个进程中，本属性用于标识本 content provider 是否可以被创建多个实例。如果 true 每一个进程中的 app 都会拥有一个 content provider 实例。如果 false 这些进程共享一个 provider 对象。默认值是 `false`。     
本属性设置为 true 可以节省 进程间通信 对系统资源的开销，但是也会增大每一个进程的内存占用。(一个权衡)

10. android:name="string"       
实现了 ContentProvider 的子类的类名。这里应该是一个充分限定的类名(例如："com.example.project.TransportationProvider")。实际上可以简写，第一个字符可以是 "." ,这个 "." 就代表` <manifest>` 节点中设置的 package name。

11. android:permission="string"         
指定权限名称。任何应用如果需要读/写 content provider 中的数据，都需要具有这里声明的权限。这个属性提供了一个便利，那就是可以一次指定 read 和 write 的权限。  值的注意的是 ` readPermission 和 writePermission ` 属性比本属性具有更高的优先级。如果 readPermission 也同时设置了，那么 readPermission 将控制 provider 的读取。如果 writePermission 也同时设置了，那么 writePermission 将控制 provider 的写入。      

12. android:process="string"      
指定 content provider 所运行的进程名。通常，一个应用的所有内容都运行在应用创建的默认进程中。默认进程具有和应用包名相同的名字。`<application>` 节点的属性 `process` 为所有内容设置一个其他的默认进程名。同时每一个组件也可以设置该组件自身所存在的进程名，android系统允许你的应用同时存在于多个进程(跨进程)。     
如果本属性的值以":"(colon)开头,进程是私有的属于应用程序，当需要的时候该进程会被创建。并且 content provider 运行于进程中。如果本属性的值以小写字母开头，以本值命名的进程是一个全局进程所有应用共享，本 content provider 将运行于改进程中。全局进程有助于减少对系统资源的占用。

13. android:readPermission="string"     
查询 Content Provider 的客户端所必需的权限

14. android:writePermission="string"     
修改 Content Provider 数据的客户端所必需的权限

15. android:syncable=["true" | "false"]          
这个属性用于设定内容提供器控制下的数据是否要与服务器上的数据进行同步，如果设置为true，则要同步，否则不需要同步。


## 参考：
1. [深入理解Android四大组件之一ContentProvider](http://blog.csdn.net/hehe26/article/details/51784355)
2. [Android API 指南清单文件](https://developer.android.google.cn/guide/topics/manifest/provider-element.html)
    - 2.1、 [Android Provider 属性](http://blog.csdn.net/peng_cao/article/details/50747694)
    - 2.2、 [Android开发-API指南-`<provider>`](http://www.cnblogs.com/popapa/p/android_provider-element.html)
    - 2.3、 [Android Manifest之<provider>元素中文注释](http://blog.csdn.net/jewleo/article/details/8939104)
    - 2.4、 [Android清单文件中相关属性含义（Provider）](http://blog.csdn.net/berber78/article/details/39252727)
3. [ android 7.0 加入 android:directBootAware ](http://blog.csdn.net/sergeycao/article/details/53636509)
