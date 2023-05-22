## 一、涉及权限(加粗)
|序号 |    权限组       |权限                     |完整字段                                         |
|:---:|----------------|-------------------------|------------------------------------------------|
|1    |CALENDAR        |READ_CALENDAR            |android.permission.READ_CALENDAR                |
| 2   |                |WRITE_CALENDAR           |android.permission.WRITE_CALENDAR               |
|  3  |CAMERA          |CAMERA                   |android.permission.CAMERA                       |
|   4 |CONTACTS        |READ_CONTACTS            |android.permission.READ_CONTACTS                |
|    5|                |WRITE_CONTACTS           |android.permission.WRITE_CONTACTS               |
|6    |                |GET_ACCOUNTS             |android.permission.GET_ACCOUNTS                 |
| 7   |LOCATION        |ACCESS_FINE_LOCATION     |android.permission.ACCESS_FINE_LOCATION         |
|  8  |                |ACCESS_COARSE_LOCATION   |android.permission.ACCESS_COARSE_LOCATION       |
|   9 |MICROPHONE      |RECORD_AUDIO             |android.permission.RECORD_AUDIO                 |
|   10|__PHONE__       |READ_PHONE_STATE         |android.permission.READ_PHONE_STATE             |
|11   |                |CALL_PHONE               |android.permission.CALL_PHONE                   |
|  12 |                |READ_CALL_LOG            |android.permission.READ_CALL_LOG                |
|   13|                |WRITE_CALL_LOG           |android.permission.WRITE_CALL_LOG               |
|14   |                |ADD_VOICEMAIL            |com.android.voicemail.permission.ADD_VOICEMAIL  |
|  15 |                |USE_SIP                  |android.permission.USE_SIP                      |
|   16|                |PROCESS_OUTGOING_CALLS   |android.permission.PROCESS_OUTGOING_CALLS       |
|17   |SENSORS         |BODY_SENSORS             |android.permission.BODY_SENSORS                 |
|  18 |SMS             |SEND_SMS                 |android.permission.SEND_SMS                     |
|   19|                |RECEIVE_SMS              |android.permission.RECEIVE_SMS                  |
|20   |                |READ_SMS                 |android.permission.READ_SMS                     |
|  21 |                |RECEIVE_WAP_PUSH         |android.permission.RECEIVE_WAP_PUSH             |
|   22|                |RECEIVE_MMS              |android.permission.RECEIVE_MMS                  |
|23   |STORAGE         |READ_EXTERNAL_STORAGE    |android.permission.READ_EXTERNAL_STORAGE        |
|  24 |                |WRITE_EXTERNAL_STORAGE   |android.permission.WRITE_EXTERNAL_STORAGE       |

## 二、涉及权限对应的 API 

### 2.1、 android.Manifest.permission.READ_PHONE_STATE 
android.telephony.TelephonyManager
- public String getDeviceSoftwareVersion()          
- public String getDeviceSoftwareVersion(int slotId)          
- public String getDeviceId()          
- public String getDeviceId(int slotId)          
- public String getImei()          
- public String getImei(int slotId)          
- public int getNetworkType(int subId)          
- public int getDataNetworkType()          
- public int getDataNetworkType(int subId)          
- public int getVoiceNetworkType()          
- public int getVoiceNetworkType(int subId)          
- public String getSimSerialNumber()          
- public String getSimSerialNumber(int subId)          
- public int getLteOnCdmaMode()          
- public int getLteOnCdmaMode(int subId)          
- public String getSubscriberId()          
- public String getSubscriberId(int subId)          
- public String getGroupIdLevel1()          
- public String getGroupIdLevel1(int subId)          
- public String getLine1AlphaTag()          
- public String getLine1AlphaTag(int subId)          
- public String getMsisdn()          
- public String getMsisdn(int subId)          
- public String getVoiceMailNumber()          
- public String getVoiceMailNumber(int subId)          
- public boolean isVisualVoicemailEnabled(PhoneAccountHandle phoneAccountHandle)          
- public int getVoiceMessageCount()          
- public int getVoiceMessageCount(int subId)          
- public String getVoiceMailAlphaTag()          
- public String getVoiceMailAlphaTag(int subId)          
- public int getCdmaEriIconIndex()          
- public int getCdmaEriIconIndex(int subId)          
- public int getCdmaEriIconMode()          
- public int getCdmaEriIconMode(int subId)          
- public String getCdmaEriText()          
- public String getCdmaEriText(int subId)          

android.Manifest.permission.READ_SMS or android.Manifest.permission.READ_PHONE_STATE          
- public String getLine1Number()          
- public String getLine1Number(int subId)          

### 2.2、 android.permission.CALL_PHONE     
- 本权限被调用的一种情形是：
    ```java
    //public static final String ACTION_CALL = "android.intent.action.CALL";本字符串也可以直接被使用。
    Intent intent = new Intent(Intent.ACTION_CALL);
    android.app.Activity.startActivity(intent,……);
    android.app.Activity.startActivityForResult(intent,……);
    android.app.Activity.startActivityFromChild(……,intent,……);
    android.app.Activity.startActivityFromFragment(……,intent,……);
    android.app.Activity.startActivityIfNeeded(intent,……);
    android.app.Activity.startNextMatchingActivity(intent,……);
    ```

### 2.3、 android.permission.READ_CALL_LOG/WRITE_CALL_LOG
- 相关 URI 的 String
    |code                                    |value                    |
    |----------------------------------------|-------------------------|
    |CallLog.CONTENT_URI                     |content://call_log       |
    |CallLog.Calls.CONTENT_URI_WITH_VOICEMAIL|content://call_log/calls |
使用上述 Url 的方法包括下述方法来自:android.content.ContentResolver      
1. bulkInsert(Uri url, ContentValues[] values) 
2. delete(Uri url, String where, String[] selectionArgs) 
3. insert(Uri url, ContentValues values) 
4. query(Uri uri, String[] projection, Bundle queryArgs, CancellationSignal cancellationSignal) 
5. query(Uri uri, String[] projection, String selection, String[] selectionArgs, String sortOrder, CancellationSignal cancellationSignal) 
6. query(Uri uri, String[] projection, String selection, String[] selectionArgs, String sortOrder) 
7. update(Uri uri, ContentValues values, String where, String[] selectionArgs) 
8. acquireContentProviderClient(Uri uri) 
9. acquireUnstableContentProviderClient（Uri）
10. call(Uri uri, String method, String arg, Bundle extras) 
11. canonicalize(Uri url) 
12. uncanonicalize(Uri url) 
13. getStreamTypes (Uri url, String mimeTypeFilter)
14. openInputStream(Uri uri) 
15. openOutputStream(Uri uri) 
16. openOutputStream(Uri uri, String mode) 
17. openAssetFileDescriptor(Uri uri, String mode, CancellationSignal cancellationSignal) 
18. openAssetFileDescriptor(Uri uri, String mode) 
19. openFileDescriptor(Uri uri, String mode, CancellationSignal cancellationSignal) 
20. openFileDescriptor(Uri uri, String mode) 
21. openTypedAssetFileDescriptor(Uri uri, String mimeType, Bundle opts, CancellationSignal cancellationSignal) 
22. openTypedAssetFileDescriptor(Uri uri, String mimeType, Bundle opts) 

上述方法调用方式：
1. 使用常量字段
2. 自拼装和常量字段相同的 String ,并创建 Uri 对象。
    - Uri.parse(String uriString);
    - Uri.parse(String uriString).withAppendedPath(Uri uri, String pathString);

### 2.4、 com.android.voicemail.permission.ADD_VOICEMAIL
未发现调用相关 API
### 2.5、 android.permission.USE_SIP    (看别人代码和初步的实践，有风险)
#### 2.5.1、 SIP
SIP（Session Initiation Protocol，会话初始协议）是由IETF（Internet Engineering Task Force，因特网工程任务组）制定的多媒体通信协议。它是一个基于文本的应用层控制协议，用于创建、修改和释放一个或多个参与者的会话。广泛应用于CS（Circuit Switched，电路交换）、NGN（Next Generation Network，下一代网络）以及IMS（IP Multimedia Subsystem，IP多媒体子系统）的网络中，可以支持并应用于语音、视频、数据等多媒体业务，同时也可以应用于Presence（呈现）、Instant Message（即时消息）等特色业务。可以说，有IP网络的地方就有SIP协议的存在。

SIP是类似于HTTP。SIP可以减少应用特别是高级应用的开发时间。由于基于IP协议的SIP利用了IP网络，固定网运营商也会逐渐认识到SIP技术对于他们的远意义。

SIP 的作用是通信，分为发起端和接收端二者。
1. 首先我们需要写一下通讯发起方的代码逻辑。
    ```
    //设计权限代码：
    SipManager.makeAudioCall();//两个重载
    ```
2. 然后我们写一下通讯接收方的代码逻辑。
    ```
    SipManager.takeAudioCall
    ```
### 2.6、 android.permission.PROCESS_OUTGOING_CALLS
```java
IntentFilter intentFilter = new IntentFilter();
intentFilter.addAction(Intent.ACTION_NEW_OUTGOING_CALL);
//Intent.ACTION_NEW_OUTGOING_CALL="android.intent.action.NEW_OUTGOING_CALL"
```
上述代码用于广播监听中，要监听此 Action 的广播需要本权限，如果没有权限会导致监听不到，但是没有任何的异常。



## 参考 & 引用
1. http://www.shuyangyang.com.cn/jishuliangongfang/qitajishu/2013-08-14/106.html
2. https://developer.android.google.cn/reference/android/net/sip/package-summary.html


