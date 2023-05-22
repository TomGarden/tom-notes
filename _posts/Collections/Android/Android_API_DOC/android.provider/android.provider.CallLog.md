# android.provide.CallLog.java
API 25
## 一、属性
两个比较重要的属性是
1. public static final String AUTHORITY = "call_log";
2. public static final String SHADOW_AUTHORITY = "call_log_shadow";
    - @hide 因此我们不再详究

有关 `call_log` 的拼装包括如下：
1. CallLog.CONTENT_URI = Uri.parse("content://" + AUTHORITY);
2. CallLog.Call.CONTENT_URI = Uri.parse("content://call_log/calls");
    - CallLog.Call.CONTENT_URI_WITH_VOICEMAIL = ``