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
|  18 |SMS             |SEND_SMS                 |android.permission.SEND_SMS                     |
|   19|                |RECEIVE_SMS              |android.permission.RECEIVE_SMS                  |
|20   |                |READ_SMS                 |android.permission.READ_SMS                     |
|  21 |                |RECEIVE_WAP_PUSH         |android.permission.RECEIVE_WAP_PUSH             |
|   22|                |RECEIVE_MMS              |android.permission.RECEIVE_MMS                  |
|23   |__STORAGE__     |READ_EXTERNAL_STORAGE    |android.permission.READ_EXTERNAL_STORAGE        |
|  24 |                |WRITE_EXTERNAL_STORAGE   |android.permission.WRITE_EXTERNAL_STORAGE       |


## 二、涉及 API
1. 获取路径
2. 转换文件
3. 读写
4. 上述过程中存在封装，真正需要权限的是 3

### 2.1、 获取路径
android.os
- Environment.getDataDirectory()
- Environment.getDownloadCacheDirectory()
- Environment.getExternalStorageDirectory()
- Environment.getExternalStoragePublicDirectory(String type)
- Environment.getRootDirectory()

android.content.ContextWrapper 
- getCacheDir() 
- getCodeCacheDir() 
- getDataDir() 
- getDir(String name, int mode) 
- getExternalCacheDir() 
- getExternalCacheDirs() 
- getExternalFilesDir(String type) 
- getExternalFilesDirs(String type) 
- getExternalMediaDirs() 
- getFilesDir() 
- getNoBackupFilesDir() 
- getObbDir() 
- getObbDirs() 
- openFileInput(String name) 
- openFileOutput(String name, int mode) 
- deleteDatabase(String name) 
- deleteFile(String name) 
- deleteSharedPreferences(String name) 
- getDatabasePath(String name) 
- getFileStreamPath(String name) 
- getSharedPreferences(String name, int mode) 




### 2.1、 读写操作
要检测读取我们需要关心的 API
- java.io 包括 48 个 class
    - 我们需要关心发生读写操作的类
    - 要逐个核实路径>操作对象>操作，这个线路太耗时。
- 所以我们从 Android API 中找到获取路径的 API 就认定使用了这两个权限。


