## 一、涉及权限(加粗)
|序号 |    权限组       |权限                     |完整字段                                         |
|:---:|----------------|-------------------------|---------------------------------               |
|1    |CALENDAR        |READ_CALENDAR            |android.permission.READ_CALENDAR                |
| 2   |                |WRITE_CALENDAR           |android.permission.WRITE_CALENDAR               |
|  3  |CAMERA          |CAMERA                   |android.permission.CAMERA                       |
|   4 |CONTACTS        |READ_CONTACTS            |android.permission.READ_CONTACTS                |
|    5|                |WRITE_CONTACTS           |android.permission.WRITE_CONTACTS               |
|6    |                |GET_ACCOUNTS             |android.permission.GET_ACCOUNTS                 |
| 7   |LOCATION        |ACCESS_FINE_LOCATION     |android.permission.ACCESS_FINE_LOCATION         |
|  8  |                |ACCESS_COARSE_LOCATION   |android.permission.ACCESS_COARSE_LOCATION       |
|   9 |MICROPHONE      |RECORD_AUDIO             |android.permission.RECORD_AUDIO                 |
|   10|PHONE           |READ_PHONE_STATE         |android.permission.READ_PHONE_STATE             |
|11   |                |CALL_PHONE               |android.permission.CALL_PHONE                   |
|  12 |                |READ_CALL_LOG            |android.permission.READ_CALL_LOG                |
|   13|                |WRITE_CALL_LOG           |android.permission.WRITE_CALL_LOG               |
|14   |                |ADD_VOICEMAIL            |com.android.voicemail.permission.ADD_VOICEMAIL  |
|  15 |                |USE_SIP                  |android.permission.USE_SIP                      |
|   16|                |PROCESS_OUTGOING_CALLS   |android.permission.PROCESS_OUTGOING_CALLS       |
|17   |SENSORS         |BODY_SENSORS             |android.permission.BODY_SENSORS                 |
|  18 |__SMS__         |SEND_SMS                 |android.permission.SEND_SMS                     |
|   19|                |RECEIVE_SMS              |android.permission.RECEIVE_SMS                  |
|20   |                |READ_SMS                 |android.permission.READ_SMS                     |
|  21 |                |RECEIVE_WAP_PUSH         |android.permission.RECEIVE_WAP_PUSH             |
|   22|                |RECEIVE_MMS              |android.permission.RECEIVE_MMS                  |
|23   |STORAGE         |READ_EXTERNAL_STORAGE    |android.permission.READ_EXTERNAL_STORAGE        |
|  24 |                |WRITE_EXTERNAL_STORAGE   |android.permission.WRITE_EXTERNAL_STORAGE       |


## 二、相关 API
### 2.1、android.permission.SEND_SMS
package：android.telephony
```java
SmsManager.sendTextMessage
SmsManager.sendMultipartTextMessage
SmsManager.sendDataMessage
```
### 2.2、android.permission.RECEIVE_SMS
package:android.provider.Telephony.Sms
```java
public static final String SMS_DELIVER_ACTION = "android.provider.Telephony.SMS_DELIVER";
public static final String SMS_RECEIVED_ACTION = "android.provider.Telephony.SMS_RECEIVED";
public static final String DATA_SMS_RECEIVED_ACTION = "android.intent.action.DATA_SMS_RECEIVED";
public static final String SMS_SERVICE_CATEGORY_PROGRAM_DATA_RECEIVED_ACTION = "android.provider.Telephony.SMS_SERVICE_CATEGORY_PROGRAM_DATA_RECEIVED";
public static final String SIM_FULL_ACTION = "android.provider.Telephony.SIM_FULL";
public static final String SMS_REJECTED_ACTION = "android.provider.Telephony.SMS_REJECTED";
//--------------------
IntentFilter intentFilter = new IntentFilter();
intentFilter.addAction(上述字段);
```

#### 2.3、 android.permission.READ_SMS
android.telephony.TelephonyManager               
- public String getLine1Number()             
- public String getLine1Number(int subId)            

android.content.ContentResolver
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

android.content.ContentResolver 所需要的 UriString
- public final static String SMS_URI_ALL =  "content://sms/"; //0  
- public final static String SMS_URI_INBOX = "content://sms/inbox";//1  
- public final static String SMS_URI_SEND = "content://sms/sent";//2  
- public final static String SMS_URI_DRAFT = "content://sms/draft";//3  
- public final static String SMS_URI_OUTBOX = "content://sms/outbox";//4  
- public final static String SMS_URI_FAILED = "content://sms/failed";//5  
- public final static String SMS_URI_QUEUED = "content://sms/queued";//6  
- 上述字段自己拼装方式：
    - Uri.parse(String uriString);
    - Uri.parse(String uriString).withAppendedPath(Uri uri, String pathString);



#### 2.4、 android.permission.RECEIVE_WAP_PUSH
package:android.provider.Telephony.Sms
```java
public static final String WAP_PUSH_DELIVER_ACTION = "android.provider.Telephony.WAP_PUSH_DELIVER";
public static final String WAP_PUSH_RECEIVED_ACTION = "android.provider.Telephony.WAP_PUSH_RECEIVED";
//--------------------
IntentFilter intentFilter = new IntentFilter();
intentFilter.addAction(上述字段);
```
#### 2.5、 android.permission.RECEIVE_MMS
package:android.provider.Telephony.Sms
```java
public static final String WAP_PUSH_DELIVER_ACTION = "android.provider.Telephony.WAP_PUSH_DELIVER";
public static final String WAP_PUSH_RECEIVED_ACTION = "android.provider.Telephony.WAP_PUSH_RECEIVED";
public static final String SMS_CB_RECEIVED_ACTION = "android.provider.Telephony.SMS_CB_RECEIVED";
//--------------------
IntentFilter intentFilter = new IntentFilter();
intentFilter.addAction(上述字段);
```


