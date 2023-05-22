# ConnectivityManager
```
public class ConnectivityManager
extends Object
java.lang.Object
   ↳ 	android.net.ConnectivityManager 
```   
----
Class that answers queries about the state of network connectivity. It also notifies applications when network connectivity changes.

The primary responsibilities of this class are to:

1. Monitor network connections (Wi-Fi, GPRS, UMTS, etc.)
2. Send broadcast intents when network connectivity changes
3. Attempt to "fail over" to another network when connectivity to a network is lost
4. Provide an API that allows applications to query the coarse-grained or fine-grained state of the available networks
5. Provide an API that allows applications to request and select networks for their data traffic

Instances of this class must be obtained using Context.getSystemService(Class) with the argument ConnectivityManager.class or Context.getSystemService(String) with the argument Context.CONNECTIVITY_SERVICE.