从 Android 联系人权限的使用角度出发，向这自动检测一个应用是否使用了联系人权限的目的进发。

## 一、涉及权限(加粗)
|序号 |    权限组       |权限                     |完整字段                                         |
|:---:|----------------|-------------------------|---------------------------------               |
|1    |CALENDAR        |READ_CALENDAR            |android.permission.READ_CALENDAR                |
| 2   |                |WRITE_CALENDAR           |android.permission.WRITE_CALENDAR               |
|  3  |CAMERA          |CAMERA                   |android.permission.CAMERA                       |
|   4 |__CONTACTS__    |READ_CONTACTS            |android.permission.READ_CONTACTS                |
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


## 二、 获取 Uri 和 Uri 的使用者 ContentResolver 
- android.provider.ContactsContract

上述文件中存在一个字段 
```java
public static final String AUTHORITY = "com.android.contacts";

/*所有"联系人"相关的数据的访问都需要通过关键字段 AUTHORITY 来拼装 Uri , 当前使用 Uri 需要权限的方法我们已经知道了,接下来需要知道的是：使用那些 Uri 会需要权限*/
```

### 2.1、 Uri 筛查结果
|code                                                      |value                                                      |
|----------------------------------------------------------|-----------------------------------------------------------|
|ContactsContract.Directory.CONTENT_URI                    |content://com.android.contacts/directories                 |
|ContactsContract.Directory.ENTERPRISE_CONTENT_URI         |content://com.android.contacts/directories_enterprise      |
|ContactsContract.SyncState.CONTENT_URI                    |content://com.android.contacts/syncstate                   |
|ContactsContract.Contacts.CONTENT_URI                     |content://com.android.contacts/contacts                    |
|ContactsContract.Contacts.CONTENT_FILTER_URI              |content://com.android.contacts/contacts/filter             |
|ContactsContract.Contacts.CONTENT_LOOKUP_URI              |content://com.android.contacts/contacts/lookup             |
|ContactsContract.Contacts.CONTENT_VCARD_URI               |content://com.android.contacts/contacts/as_vcard           |
|ContactsContract.Contacts.CONTENT_MULTI_VCARD_URI         |content://com.android.contacts/contacts/as_multi_vcard     |
|ContactsContract.Profile.CONTENT_URI                      |content://com.android.contacts/profile                     |
|ContactsContract.Profile.CONTENT_VCARD_URI                |content://com.android.contacts/profile/as_vcard            |
|ContactsContract.Profile.CONTENT_RAW_CONTACTS_URI         |content://com.android.contacts/profile/raw_contacts        |
|ContactsContract.DeletedContacts.CONTENT_URI              |content://com.android.contacts/deleted_contacts            |
|ContactsContract.RawContacts.CONTENT_URI                  |content://com.android.contacts/raw_contacts                |
|ContactsContract.Data.CONTENT_URI                         |content://com.android.contacts/data                        |
|ContactsContract.RawContactsEntity.CONTENT_URI            |content://com.android.contacts/raw_contact_entities        |
|ContactsContract.RawContactsEntity.PROFILE_CONTENT_URI    |content://com.android.contacts/profile/raw_contact_entities|
|ContactsContract.PhoneLookup.CONTENT_FILTER_URI           |content://com.android.contacts/phone_lookup                |
|ContactsContract.PhoneLookup.ENTERPRISE_CONTENT_FILTER_URI|content://com.android.contacts/phone_lookup_enterprise     |
|ContactsContract.StatusUpdates.CONTENT_URI                |content://com.android.contacts/status_updates              |
|ContactsContract.StatusUpdates.PROFILE_CONTENT_URI        |content://com.android.contacts/profile/status_updates      |
|ContactsContract.Groups.CONTENT_URI                       |content://com.android.contacts/groups                      |
|ContactsContract.Groups.CONTENT_SUMMARY_URI               |content://com.android.contacts/groups_summary              |
|ContactsContract.AggregationExceptions.CONTENT_URI        |content://com.android.contacts/aggregation_exceptions      |
|ContactsContract.Settings.CONTENT_URI                     |content://com.android.contacts/settings                    |
|ContactsContract.ProviderStatus.CONTENT_URI               |content://com.android.contacts/provider_status             |
|ContactsContract.DisplayPhoto.CONTENT_URI                 |content://com.android.contacts/display_photo               |
|ContactsContract.DisplayPhoto.CONTENT_MAX_DIMENSIONS_URI  |content://com.android.contacts/photo_dimensions            |


### 2.2、 ContentResolver 筛查结果 
- 下述方法来自:android.content.ContentResolver 
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

## 2.3、 小结
2.2 中函数，使用 2.1 属性或者字段，调用方式：
1. 使用常量字段
2. 自拼装和常量字段相同的 String ,并创建 Uri 对象。
    - Uri.parse(String uriString);
    - Uri.parse(String uriString).withAppendedPath(Uri uri, String pathString);


## 改进:关于 Uri 收录不完善下述需要符合

ContactsContract.CommonDataKinds.Phone.CONTENT_URI