>目标:http://10.10.1.162:8090/confluence/pages/viewpage.action?pageId=9634044

## 一、涉及权限(加粗)
|序号 |    权限组       |权限                     |完整字段                                         |
|:---:|----------------|-------------------------|---------------------------------               |
|1    |__CALENDAR__    |READ_CALENDAR            |android.permission.READ_CALENDAR                |
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
|23   |STORAGE         |READ_EXTERNAL_STORAGE    |android.permission.READ_EXTERNAL_STORAGE        |
|  24 |                |WRITE_EXTERNAL_STORAGE   |android.permission.WRITE_EXTERNAL_STORAGE       |

## 二、 当前了解到的权限使用方式
### 2.1、 方式一
[CALENDAR:calendra]日历相关权限的使用方式和 Android 手机的基础功能“日历”相关。

1. 数据操作通过 Android 数据共享机制 ContentProvider | ContentResolver 完成。
2. 外部应用要使用日历权限除了上述 API 还需要准确的 Uri 和表结构信息。
3. Android 平台为此提供的的 API 为 [CalendarProvider](https://developer.android.google.cn/reference/android/provider/CalendarContract.html) 在这里提供了操作日历数据相关的所有 Uri ，包括：


下表代码所在包：android.provider
|code                                                   |value                                                         |
|-------------------------------------------------------|----------------------------------------------------------|
|CalendarContract.CalendarEntity.CONTENT_URI            |content://com.android.calendar/calendar_entities          |
|CalendarContract.Calendars.CONTENT_URI                 |content://com.android.calendar/calendars                  |
|CalendarContract.Attendees.CONTENT_URI                 |content://com.android.calendar/attendees                  |
|CalendarContract.EventsEntity.CONTENT_URI              |content://com.android.calendar/event_entities             |
|CalendarContract.Events.CONTENT_URI                    |content://com.android.calendar/events                     |
|CalendarContract.Events.CONTENT_EXCEPTION_URI          |content://com.android.calendar/exception                  |
|CalendarContract.Instances.CONTENT_URI                 |content://com.android.calendar/instances/when             |
|CalendarContract.Instances.CONTENT_BY_DAY_URI          |content://com.android.calendar/instances/whenbyday        |
|CalendarContract.Instances.CONTENT_SEARCH_URI          |content://com.android.calendar/instances/search           |
|CalendarContract.Instances.CONTENT_SEARCH_BY_DAY_URI   |content://com.android.calendar/instances/searchbyday      |
|CalendarContract.CalendarCache.URI                     |content://com.android.calendar/properties                 |
|CalendarContract.EventDays.CONTENT_URI                 |content://com.android.calendar/instances/groupbyday       |
|CalendarContract.Reminders.CONTENT_URI                 |content://com.android.calendar/reminders                  |
|CalendarContract.CalendarAlerts.CONTENT_URI            |content://com.android.calendar/calendar_alerts            |
|CalendarContract.CalendarAlerts.CONTENT_URI_BY_INSTANCE|content://com.android.calendar/calendar_alerts/by_instance|
|CalendarContract.Colors.CONTENT_URI                    |content://com.android.calendar/colors                     |
|CalendarContract.ExtendedProperties.CONTENT_URI        |content://com.android.calendar/extendedproperties         |
|CalendarContract.CONTENT_URI                           |content://com.android.calendar                            |

上述代码在 ContentResolver 实例中被使用即可判定为权限被使用了，所以我们需要判断 ContentResolver 中使用 Uri 的方法所做的事情，从而更进一步判断该方法所使用的权限。

### 2.2、 统计到的使用该权限的 API 
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

### 2.3、 小结
2.2 中的 API 在使用过程中调用到了 2.1 中的 Uri 即触发检测点。

Uri 的使用方式：
1. 使用常量字段
2. 自拼装和常量字段相同的 String ,并创建 Uri 对象。
    - Uri.parse(String uriString);
    - Uri.parse(String uriString).withAppendedPath(Uri uri, String pathString);



## 参考 & 摘录
1. [Android 日历CalendarProvider](http://blog.csdn.net/super_spy/article/details/51276618)
2. [Android 日历CalendarProvider](http://www.jcodecraeer.com/a/anzhuokaifa/developer/2013/0311/1004.html)
    - 上述文章是一篇来自 Google 的翻译，因为天国的 Great Firewall 暂时不能获取到原文。
