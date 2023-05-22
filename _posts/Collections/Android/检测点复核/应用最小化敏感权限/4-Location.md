## 一、涉及权限(加粗)
|序号 |    权限组       |权限                     |完整字段                                         |
|:---:|----------------|-------------------------|---------------------------------               |
|1    |CALENDAR        |READ_CALENDAR            |android.permission.READ_CALENDAR                |
| 2   |                |WRITE_CALENDAR           |android.permission.WRITE_CALENDAR               |
|  3  |CAMERA          |CAMERA                   |android.permission.CAMERA                       |
|   4 |CONTACTS        |READ_CONTACTS            |android.permission.READ_CONTACTS                |
|    5|                |WRITE_CONTACTS           |android.permission.WRITE_CONTACTS               |
|6    |                |GET_ACCOUNTS             |android.permission.GET_ACCOUNTS                 |
| 7   |__LOCATION__    |ACCESS_FINE_LOCATION     |android.permission.ACCESS_FINE_LOCATION         |
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


## 二、涉及 API 
1. LocationManager
2. LocationProvider

### 2.1、 LocationManager
我们需要确定是否 LocationManager 中每一个方法被调用都会检测是否已经获取到权限了？当前晒查结果如下：
- 下述方法在“源码”和“开发文档”中均有注释需要权限。
- @RequiresPermission(anyOf = {ACCESS_COARSE_LOCATION, ACCESS_FINE_LOCATION})            
public void requestLocationUpdates(String provider, long minTime, float minDistance,LocationListener listener)       
public void requestLocationUpdates(String provider, long minTime, float minDistance,LocationListener listener, Looper looper)       
public void requestLocationUpdates(long minTime, float minDistance, Criteria criteria,LocationListener listener, Looper looper)       
public void requestLocationUpdates(String provider, long minTime, float minDistance,PendingIntent intent)       
public void requestLocationUpdates(long minTime, float minDistance, Criteria criteria,PendingIntent intent)       
public void requestSingleUpdate(String provider, LocationListener listener, Looper looper)       
public void requestSingleUpdate(Criteria criteria, LocationListener listener, Looper looper)       
public void requestSingleUpdate(String provider, PendingIntent intent)       
public void requestSingleUpdate(Criteria criteria, PendingIntent intent)       
public void addProximityAlert(double latitude, double longitude, float radius, long expiration,PendingIntent intent)       
public void addGeofence(LocationRequest request, Geofence fence, PendingIntent intent)       
public Location getLastKnownLocation(String provider)       
- @RequiresPermission(ACCESS_FINE_LOCATION)            
public boolean addGpsStatusListener(GpsStatus.Listener listener)       
public boolean registerGnssStatusCallback(GnssStatusCallback callback)       
public boolean registerGnssStatusCallback(GnssStatusCallback callback, Handler handler)       
public boolean registerGnssStatusCallback(GnssStatus.Callback callback)       
public boolean registerGnssStatusCallback(GnssStatus.Callback callback, Handler handler)       
public boolean addNmeaListener(GpsStatus.NmeaListener listener)       
public boolean addNmeaListener(GnssNmeaListener listener)       
public boolean addNmeaListener(GnssNmeaListener listener, Handler handler)       
public boolean addNmeaListener(OnNmeaMessageListener listener)       
public boolean addNmeaListener(OnNmeaMessageListener listener, Handler handler)       
public boolean registerGnssMeasurementsCallback(GnssMeasurementsEvent.Callback callback)       
public boolean registerGnssMeasurementsCallback(GnssMeasurementsEvent.Callback callback,Handler handler)       
public boolean registerGnssNavigationMessageCallback(final GnssNavigationMessageEvent.Callback callback, Handler handler)       
public boolean registerGnssNavigationMessageCallback(GnssNavigationMessage.Callback callback, Handler handler)       
public GpsStatus getGpsStatus(GpsStatus status)       


### 2.2、 LocationProvider
经了解，LocationProvider 的作用提供一种规则，这个规则被用于 LocationManager 。比如：
```java
Criteria criteria = new Criteria();//可以使用各种 set 方法设置限制 功耗，精度速度……
String providerName = mgr.getBestProvider(criteria, true /*enabledOnly*/); //criteria不能填null，否则出现异常
LocationProvider provider = mgr.getProvider(providerName); //获取指定规则的 LocationProvider
Location location = mgr.getLastKnownLocation(providerName); //是哟欧诺个LocationProvider 的名字获取位置。
```


## 参考 & 摘录
1. http://www.cnblogs.com/kdkler/p/6196751.html
2. [Using the Location Manager](http://www.cnblogs.com/mengdd/archive/2013/01/12/2857369.html)
3. [Android学习笔记（五六）：位置Location](http://blog.csdn.net/flowingflying/article/details/8995107)


