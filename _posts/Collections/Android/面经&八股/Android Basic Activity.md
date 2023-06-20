
## 0x01. Activity 生命周期

```

┌──────────────┐
│   onCreate   │                        被创建
└──────┬───────┘
       │
       │
       │
┌──────▼───────┐
│   onStart    ◄─────────┐               可见
└──────┬───────┘         │
       │                 │
       │                 │           ┌────────────────────────┐
       │                 │           │ onRestoreInstanceState │
       │                 │           └────────────────────────┘
       │                 │
┌──────▼───────┐         │
│   onResume   │         │            可见 , 获得焦点 , 可交互
└──────┬───────┘         │
       │                 │
       │                 │
       │                 │
┌──────▼───────┐         │
│   onPause    │         │            可见 , 失去焦点
└──────┬───────┘         │
       │          ┌──────┴───────┐
       │          │  onRestart   │
       │          └──────▲───────┘
┌──────▼───────┐         │
│   onStop     ├─────────┘               不可见
└──────┬───────┘
       │
       │                             ┌─────────────────────┐
       │                             │ onSaveInstanceState │
       │                             └─────────────────────┘
       │
┌──────▼───────┐
│   onDestory  │                     被销毁 , 资源被释放
└──────────────┘

```

### 1.1. Activity 切换时候的生命周期

Activity  A  启动 Activity B
1. Activity A 的 onPause() 方法执行。
2. Activity B 的 onCreate()、onStart() 和 onResume() 方法依次执行（Activity B 现在具有用户焦点）。
3. 然后，如果 Activity A 在屏幕上不再显示，其 onStop() 方法执行。
4. 在不保留后台进程的情况下 , 或者系统资源不足的情况下 Activity A onDestory() 方法执行 . 
   - 此种情况会引入保存 Activity 界面状态这个事件
   - `onSaveInstanceState(outState: Bundle)` 在此种情况下会被回调
   - 保存的数据可以选择在 `onCreate(Bundle)` 或 `onRestoreInstanceState(Bundle)` 进行恢复 
      - 这二者的差别在于 , 逻辑上将事件做了区分 , 参数(Bundle)没有差异 .
      - onRestoreInstanceState 只有在 Activity 确实被销毁后的重启阶段被调用
   - 用户手动返回按钮 , 不触发 onSaveInstanceState . 正常销毁 . 

#### 1.1.1. 保存界面状态

可以考虑的方式有

1. ViewModel 对象。
2. 以下情境中的已存实例状态：
   - Jetpack Compose：rememberSaveable。
   - 视图：onSaveInstanceState() API。
   - ViewModels：SavedStateHandle。
3. 本地存储空间，以便在应用和 activity 过渡期间保持界面状态。

## 0x02. 测试 Activity

1. Activity 内相关逻辑的测试
2. Activity 状态测试 :
    - 被其他手段唤醒 , Intent / Broadcast
    - 被销毁 : 资源不足被系统销毁 / 用户主动动作销毁

## 0x03. Activity 栈

存放 Activity 实例的逻辑容器是 栈 , 后进先出 , 出栈即表示实例被销毁资源被释放 . 

当从主屏幕切换应用的时候 , 不同的应用中的 Activity 被不同的 栈 维护 . 单个 应用 也可以占有多个栈 . 栈也称为任务 . 

栈中的 Activity 顺序永远不会变化 , 只会发生进栈和出栈 . 

Activity 启动模式设定可以干涉 Activity 栈 . 

启动模式可以通过 `AndroidManifest.xml` 配置 , 也可以通过 Intent 配置 ; 

```xml
<activity android:name="packageName.XxxActivity" 
          android:launchMode="standard"/>
```

```kotlin
intent.addFlags(Intent.FLAG_ACTIVITY_SINGLE_TOP);
```

可能用到的指令 : 
- `adb shell dumpsys activity containers` 转储 activity 容器们 , 展示在命令行

### 3.1. 默认的启动模式 `standard`

系统为每个有 Activity 组件的应用维护一个 默认的 栈 . 

```

          每次启动一个 Activity 都会入栈一个 Activity 实例


  ┌────────────────────┐
  │   Activity Stack   │
  │                    │
  │                    │
  │  ┌──────────────┐  │
  │  │ ActivityOne  │  │
  │  └──────────────┘  │◄───────┐
  │                    │        │ ActivityOne.startActivity( Intent(this, ActivityOne::class.java) )
  │  ┌──────────────┐  ├────────┘ One -> One
  │  │ ActivityOne  │  │
  │  └──────────────┘  │◄───────┐
  │                    │        │ MainActivity.startActivity( Intent(this, ActivityOne::class.java) )
  │  ┌──────────────┐  ├────────┘ Main -> One
  │  │ MainActivity │  │
  │  └──────────────┘  │◄───────┐
  │                    │        │ ActivityOne.startActivity( Intent(this, MainActivity::class.java) )
  │  ┌──────────────┐  ├────────┘ One -> Main
  │  │ ActivityOne  │  │
  │  └──────────────┘  │◄───────┐
  │                    │        │ MainActivity.startActivity( Intent(this, ActivityOne::class.java) )
  │  ┌──────────────┐  │        │ Main -> One
  │  │ MainActivity │  ├────────┘
  │  └──────────────┘  │
  │                    │
  └────────────────────┘

✗ adb shell dumpsys activity containers
#9 Task=3824 type=standard mode=fullscreen override-mode=undefined requested-bounds=[0,0][0,0] bounds=[0,0][1080,2400]
   #0 595bb47 packageName/packageName.ActivityOne type=standard
   #0 595bb47 packageName/packageName.ActivityOne type=standard
   #0 e326575 packageName/packageName.MainActivity type=standard
   #0 edb8ce4 packageName/packageName.ActivityOne type=standard
   #0 3d567f5 packageName/packageName.MainActivity type=standard

```

### 3.2. 栈顶唯一 `singleTop`

有时候我们希望如果某个 Activity 已经存在就不再创建新的实例了 . 

针对这个已经存在于栈顶的 Activity 我们可以使用 SingleTop 作为 launchMode

- 当 SingleTopActivity 位于栈顶的时候 再次启动 该 Activity , 只会触发该 Activity 的 onNewIntent(Intent) 回调接受 Intent 实例
- 栈中存在 SingleTopActivity  , 且该 Activity 不再栈顶 , 仍然可以通过启动 SingleTopActivity 在栈顶插入新实例 . 

```java

  standard  : MainActivity / ActivityOne
  singleTop : ActivityTwo

  ┌────────────────────┐
  │                    │
  │   Activity Stack   │
  │                    │
  │                    │
  │                    │
  │                    │          ActivityTwo.startActivity( (Intent(this, ActivityTwo::class.java) )
  │  ┌──────────────┐  ├────────► Two -> Two  Just call back ActivityTwo.onNewIntent(Intent)
  │  │ ActivityTwo  │  │          当 SingleTopActivity 位于栈顶的时候 再次启动 该 Activity , 只会触发该 Activity 的 onNewIntent(Intent) 回调接受 Intent 实例
  │  └──────────────┘  │◄───────┐
  │                    │        │ ActivityOne.startActivity( Intent(this, ActivityTwo::class.java) )
  │  ┌──────────────┐  ├────────┘ One -> Two
  │  │ ActivityOne  │  │
  │  └──────────────┘  │◄───────┐
  │                    │        │ ActivityTwo.startActivity( (Intent(this, ActivityOne::class.java) )
  │  ┌──────────────┐  ├────────┘ Two -> One
  │  │ ActivityTwo  │  │
  │  └──────────────┘  │◄───────┐
  │                    │        │ ActivityOne.startActivity( Intent(this,  ActivityTwo::class.java) )
  │  ┌──────────────┐  ├────────┘ One -> Two
  │  │ ActivityOne  │  │
  │  └──────────────┘  │◄───────┐
  │                    │        │ MainActivity.startActivity( Intent(this, ActivityOne::class.java) )
  │  ┌──────────────┐  │        │ Main -> One
  │  │ MainActivity │  ├────────┘
  │  └──────────────┘  │
  │                    │
  └────────────────────┘



✗ adb shell dumpsys activity containers
ACTIVITY MANAGER CONTAINERS (dumpsys activity containers)
#9 Task=3829 type=standard mode=fullscreen override-mode=undefined requested-bounds=[0,0][0,0] bounds=[0,0][1080,2400]
  #0 94a67da packageName/packageName.ActivityTwo type=standard
  #0 429c8a0 packageName/packageName.ActivityOne type=standard
  #0 9cd0158 packageName/packageName.ActivityTwo type=standard
  #0 907c329 packageName/packageName.ActivityOne type=standard
  #0 c8c46ed packageName/packageName.MainActivity type=standard
```

### 3.3. 独立唯一栈 `singleTask`

> 在当前 栈 中只会有一个 SingleTaskActivity

有时候我们希望如果某个 Activity 已经存在就不再创建新的实例了 . 

准确的说我们期望 , 整个 Activity 栈 中某个确定的 Activity 只有一个实例 ; 

有关于此的实现方式为 : `singleTask`

- 在某一个 栈中 , 如果没有 启动 SingleTaskActivity , 
   尝试启动它 , 会在栈顶创建 SingleTaskActivity 实例 . 
   - 此时如果 SingleTaskActivity 再启动其他的 standstardActivity , 栈顶将是 standstardActivity ; 
     当位于栈顶的 standstardActivity 再次尝试启动 SingleTaskActivity , 
     栈中 SingleTaskActivity 上方的所有 Activity 都会出栈 , SingleTaskActivity 会位于栈顶(用户可见) , 
     并且触发 SingleTaskActivity.onNewInstance(Intent)
   - 此时如果尝试 SingleTaskActivity 启动自己的新实例 , 不会入栈新的实例 , 只会触发 SingleTaskActivity.onNewInstance(Intent)


```java

  standard   : MainActivity / ActivityOne
  singleTask : ActivityTwo

 ┌────────────────────┐
 │                    │               ActivityTwo 之上的 所有 Activity 都会出栈 , ActivityTwo 位于栈顶 , 
 │   Activity Stack   │                   ActivityTwo.onNewInstance(Intent) 被触发
 │                    │               Pop all activities which on the top of ActivityTwo .
 │                    │ One -> Two        and callback ActivityTwo.onNewInstance(Intent)
 │  ┌──────────────┐  │-----------------------------------------------------------------------------------┐
 │  │ ActivityOne  │  │                                                                                   :
 │  └──────────────┘  │◄───────┐ ActivityTwo.startActivity( (Intent(this, ActivityOne::class.java) )      :
 │                    │        │ Two -> One                                                               :
 │  ┌──────────────┐  ├────────┘                                                                          :
 │  │              │  │◄----------------------------------------------------------------------------------┘
 │  │              │  │
 │  │              │  │◄─------┐                                          ActivityTwo.onPause
 │  │ ActivityTwo  │  │        : Two -> Two  start itself , just callback ActivityTwo.onNewInstance(Intent)
 │  │              │  │--------┘                                          ActivityTwo.onResume
 │  │              │  │
 │  └──────────────┘  │◄───────┐
 │                    │        │ ActivityOne.startActivity( Intent(this,  ActivityTwo::class.java) )
 │  ┌──────────────┐  ├────────┘ One -> Two
 │  │ ActivityOne  │  │
 │  └──────────────┘  │◄───────┐
 │                    │        │ MainActivity.startActivity( Intent(this, ActivityOne::class.java) )
 │  ┌──────────────┐  │        │ Main -> One
 │  │ MainActivity │  ├────────┘
 │  └──────────────┘  │
 │                    │
 └────────────────────┘

✗ adb shell dumpsys activity containers
 #8 Task=3847 type=standard mode=fullscreen override-mode=undefined requested-bounds=[0,0][0,0] bounds=[0,0][1080,2400]
   #0 5ff8ad0 packageName/packageName.ActivityTwo type=standard
   #0 74b4721 packageName/packageName.ActivityOne type=standard
   #0 f607a25 packageName/packageName.MainActivity type=standard


```

### 3.4. 独立唯一栈 `singleInstance`

> 独立栈中只有一个 SingleInstanceActivity ; SingleInstanceActivity 在一个应用进程中不会有多个实例 . 

SingleInstanceActivity 独占一个栈 , SingleInstanceActivity 启动的其他 Activity 也不会与其共享栈 . 


```

  standard       : MainActivity / ActivityOne
  singleInstance : ActivityTwo


   ┌────────────────────┐                         ┌────────────────────┐
   │                    │                         │                    │
   │   Activity Stack 1 │                         │  Activity Stack 2  │
   │                    │                         │                    │
   │  ┌──────────────┐  │                         │                    │
   │  │(1)           │  │  Two -> One             │  ┌──────────────┐  │
   │  │  ActivityOne │  │◄────────────────────────┤  │(5)           │  │
   │  │              │  │                         │  │              │  │
   │  └──────────────┘  │ Other : Xxx -> Two      │  │              │  │
   │                    │ Not create new Instance │  │              │  │
   │  ┌──────────────┐  │ just restart ActivityTwo│  │              │  │
   │  │(2)           │  ├────────────────────────►│  │              │  │
   │  │  ActivityOne │  │   Two -> One            │  │              │  │
   │  │              │  │◄────────────────────────┤  │              │  │
   │  └──────────────┘  │                         │  │ ActivityTwo  │  │◄─---┐ Two -> Two
   │                    │                         │  │              │  │     :                                        ActivityTwo.onPause
   │  ┌──────────────┐  │                         │  │              │  │-----┘ Not creat new instance , Just callback ActivityTwo.onNewInstance(Intent)
   │  │(3)           │  │ first  :   One -> Two   │  │              │  │                                              ActivityTwo.onResume
   │  │  ActivityOne │  ├───────────────────────► │  │              │  │
   │  │              │  │                         │  └──────────────┘  │
   │  └──────────────┘  │◄───────┐                │                    │
   │                    │        │                └────────────────────┘
   │  ┌──────────────┐  │        │
   │  │(4)           │  ├────────┘ MainActivity.startActivity( Intent(this, ActivityOne::class.java) )
   │  │ MainActivity │  │          Main -> One
   │  └──────────────┘  │
   │                    │
   └────────────────────┘

    At last , click back button five times , the sort of activitys destory is : 1 -> 2 -> 3 -> 4 -> 5
    最后连续点击 返回按钮 5 次 , Activity 的销毁顺序为 : 1 -> 2 -> 3 -> 4 -> 5

    If we first start ActivityTwo on Activity One ; ActivityTwo is visible ; 
    click back button five times , the sort of activitys destory is : 5 -> 1 -> 2 -> 3 -> 4
    如果先在 ActivityOne 再次启动 ActivityTwo ; 使 ActivityTwo 可见 ;
    连续点击 返回按钮 5 次 , Activity 的销毁顺序为 : 5 -> 1 -> 2 -> 3 -> 4
    



✗ adb shell dumpsys activity containers
 #9 Task=3851 type=standard mode=fullscreen override-mode=undefined requested-bounds=[0,0][0,0] bounds=[0,0][1080,2400]
   #0 3dd16b1 packageName/packageName.ActivityOne type=standard
   #0 3a7cb31 packageName/packageName.ActivityOne type=standard
   #0 61b8c93 packageName/packageName.MainActivity type=standard
 #8 Task=3853 type=standard mode=fullscreen override-mode=undefined requested-bounds=[0,0][0,0] bounds=[0,0][1080,2400]
   #0 1babaf8 packageName/packageName.ActivityTwo type=standard

```

### 0x04. 使用 `Intent.FLAG_ACTIVITY_XXXX` 干涉启动模式

详情查看 代码注释 或者 api 文档 . 

### 0x05. taskAffinity

会影响 启动的 Activity 实例 会放到那个 栈(Task) 中 . 

### 0x06. 启动任务

```
    <activity ... >
        <intent-filter ... >
            <action android:name="android.intent.action.MAIN" />
            <category android:name="android.intent.category.LAUNCHER" />
        </intent-filter>
        ...
    </activity>
```

设置此过滤器的 Activity 会在 系统主界面 创建启动图标 . 点击图标即可启动这个 Activity . 

## 参考内容
1. [了解 Activity 生命周期](https://developer.android.com/guide/components/activities/intro-activities?hl=zh_cn)
2. [保存界面状态](https://developer.android.com/topic/libraries/architecture/saving-states?hl=zh-cn)
3. [任务和返回堆栈](https://developer.android.com/guide/components/activities/tasks-and-back-stack?hl=zh-cn)
   - [清单文件 activity 节点](https://developer.android.com/guide/topics/manifest/activity-element?hl=zh-cn)