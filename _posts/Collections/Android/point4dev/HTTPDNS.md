HTTPDNS 宣称自己可以比 LocalDNS 解析服务器更快的解析域名对应的 IP 地址

但问题在于 , HTTPDNS 是如何下发这个 IP 的 ? 如果也是通过 HTTP 的方式 , HTTPDNS 域名服务器的解析动作由谁来完成 ? 

固定 IP

部署有问题

 module 沟通细节



## HTTP 异常
```

登陆的时候出现这个异常 , 目前判断是网络问题导致的异常触发

2020-10-27 10:13:11.798 22562-22562/? W/System.err: java.net.ConnectException: Failed to connect to /10.115.3.8:8080
2020-10-27 10:13:11.798 22562-22562/? W/System.err:     at okhttp3.a.g.e.k(RealConnection.kt:14)
2020-10-27 10:13:11.798 22562-22562/? W/System.err:     at okhttp3.a.g.e.m(RealConnection.kt:3)
2020-10-27 10:13:11.798 22562-22562/? W/System.err:     at okhttp3.a.g.e.j(RealConnection.kt:14)
2020-10-27 10:13:11.798 22562-22562/? W/System.err:     at okhttp3.a.g.d.c(ExchangeFinder.kt:44)
2020-10-27 10:13:11.798 22562-22562/? W/System.err:     at okhttp3.a.g.d.d(ExchangeFinder.kt:1)
2020-10-27 10:13:11.798 22562-22562/? W/System.err:     at okhttp3.a.g.d.b(ExchangeFinder.kt:6)
2020-10-27 10:13:11.798 22562-22562/? W/System.err:     at okhttp3.a.g.k.l(Transmitter.kt:6)
2020-10-27 10:13:11.798 22562-22562/? W/System.err:     at okhttp3.a.g.a.intercept(ConnectInterceptor.kt:5)
2020-10-27 10:13:11.798 22562-22562/? W/System.err:     at okhttp3.a.h.g.j(RealInterceptorChain.kt:9)
2020-10-27 10:13:11.798 22562-22562/? W/System.err:     at okhttp3.a.h.g.f(RealInterceptorChain.kt:1)
2020-10-27 10:13:11.798 22562-22562/? W/System.err:     at okhttp3.a.e.a.intercept(CacheInterceptor.kt:20)
2020-10-27 10:13:11.798 22562-22562/? W/System.err:     at okhttp3.a.h.g.j(RealInterceptorChain.kt:9)
2020-10-27 10:13:11.798 22562-22562/? W/System.err:     at okhttp3.a.h.g.f(RealInterceptorChain.kt:1)
2020-10-27 10:13:11.798 22562-22562/? W/System.err:     at okhttp3.a.h.a.intercept(BridgeInterceptor.kt:22)
2020-10-27 10:13:11.798 22562-22562/? W/System.err:     at okhttp3.a.h.g.j(RealInterceptorChain.kt:9)
2020-10-27 10:13:11.798 22562-22562/? W/System.err:     at okhttp3.a.h.j.intercept(RetryAndFollowUpInterceptor.kt:6)
2020-10-27 10:13:11.798 22562-22562/? W/System.err:     at okhttp3.a.h.g.j(RealInterceptorChain.kt:9)
2020-10-27 10:13:11.798 22562-22562/? W/System.err:     at okhttp3.a.h.g.f(RealInterceptorChain.kt:1)
2020-10-27 10:13:11.798 22562-22562/? W/System.err:     at com.txy.manban.app.okhttp_interceptor.a.intercept(HostSelectionInterceptor.java:11)
2020-10-27 10:13:11.798 22562-22562/? W/System.err:     at okhttp3.a.h.g.j(RealInterceptorChain.kt:9)
2020-10-27 10:13:11.798 22562-22562/? W/System.err:     at okhttp3.a.h.g.f(RealInterceptorChain.kt:1)
2020-10-27 10:13:11.799 22562-22562/? W/System.err:     at com.txy.manban.app.okhttp_interceptor.b.intercept(TimeoutInterceptor.kt:15)
2020-10-27 10:13:11.799 22562-22562/? W/System.err:     at okhttp3.a.h.g.j(RealInterceptorChain.kt:9)
2020-10-27 10:13:11.799 22562-22562/? W/System.err:     at okhttp3.a.h.g.f(RealInterceptorChain.kt:1)
2020-10-27 10:13:11.799 22562-22562/? W/System.err:     at com.txy.manban.app.okhttp_interceptor.AuthInterceptor2.intercept(AuthInterceptor2.kt:21)
2020-10-27 10:13:11.799 22562-22562/? W/System.err:     at okhttp3.a.h.g.j(RealInterceptorChain.kt:9)
2020-10-27 10:13:11.799 22562-22562/? W/System.err:     at okhttp3.a.h.g.f(RealInterceptorChain.kt:1)
2020-10-27 10:13:11.799 22562-22562/? W/System.err:     at okhttp3.b.a.intercept(HttpLoggingInterceptor.kt:39)
2020-10-27 10:13:11.799 22562-22562/? W/System.err:     at okhttp3.a.h.g.j(RealInterceptorChain.kt:9)
2020-10-27 10:13:11.799 22562-22562/? W/System.err:     at okhttp3.a.h.g.f(RealInterceptorChain.kt:1)
2020-10-27 10:13:11.799 22562-22562/? W/System.err:     at okhttp3.RealCall.h(RealCall.kt:13)
2020-10-27 10:13:11.799 22562-22562/? W/System.err:     at okhttp3.RealCall.execute(RealCall.kt:9)
2020-10-27 10:13:11.799 22562-22562/? W/System.err:     at m.l.execute(OkHttpCall.java:18)
2020-10-27 10:13:11.799 22562-22562/? W/System.err:     at m.x.a.c.I5(CallExecuteObservable.java:4)
2020-10-27 10:13:11.799 22562-22562/? W/System.err:     at h.b.b0.c(Observable.java:4)
2020-10-27 10:13:11.799 22562-22562/? W/System.err:     at m.x.a.a.I5(BodyObservable.java:1)
2020-10-27 10:13:11.799 22562-22562/? W/System.err:     at h.b.b0.c(Observable.java:4)
2020-10-27 10:13:11.799 22562-22562/? W/System.err:     at h.b.y0.e.e.k3$b.run(ObservableSubscribeOn.java:1)
2020-10-27 10:13:11.799 22562-22562/? W/System.err:     at h.b.j0$a.run(Scheduler.java:2)
2020-10-27 10:13:11.799 22562-22562/? W/System.err:     at h.b.y0.g.n.run(ScheduledRunnable.java:2)
2020-10-27 10:13:11.799 22562-22562/? W/System.err:     at h.b.y0.g.n.call(ScheduledRunnable.java:1)
2020-10-27 10:13:11.799 22562-22562/? W/System.err:     at java.util.concurrent.FutureTask.run(FutureTask.java:237)
2020-10-27 10:13:11.799 22562-22562/? W/System.err:     at java.util.concurrent.ScheduledThreadPoolExecutor$ScheduledFutureTask.run(ScheduledThreadPoolExecutor.java:272)
2020-10-27 10:13:11.799 22562-22562/? W/System.err:     at java.util.concurrent.ThreadPoolExecutor.runWorker(ThreadPoolExecutor.java:1133)
2020-10-27 10:13:11.799 22562-22562/? W/System.err:     at java.util.concurrent.ThreadPoolExecutor$Worker.run(ThreadPoolExecutor.java:607)
2020-10-27 10:13:11.799 22562-22562/? W/System.err:     at java.lang.Thread.run(Thread.java:761)
2020-10-27 10:13:11.799 22562-22562/? W/System.err: Caused by: java.net.ConnectException: Connection refused
2020-10-27 10:13:11.799 22562-22562/? W/System.err:     at java.net.PlainSocketImpl.socketConnect(Native Method)
2020-10-27 10:13:11.799 22562-22562/? W/System.err:     at java.net.AbstractPlainSocketImpl.doConnect(AbstractPlainSocketImpl.java:334)
2020-10-27 10:13:11.799 22562-22562/? W/System.err:     at java.net.AbstractPlainSocketImpl.connectToAddress(AbstractPlainSocketImpl.java:196)
2020-10-27 10:13:11.799 22562-22562/? W/System.err:     at java.net.AbstractPlainSocketImpl.connect(AbstractPlainSocketImpl.java:178)
2020-10-27 10:13:11.799 22562-22562/? W/System.err:     at java.net.SocksSocketImpl.connect(SocksSocketImpl.java:356)
2020-10-27 10:13:11.799 22562-22562/? W/System.err:     at java.net.Socket.connect(Socket.java:605)
2020-10-27 10:13:11.799 22562-22562/? W/System.err:     at okhttp3.a.l.a.j(AndroidPlatform.kt:1)
2020-10-27 10:13:11.799 22562-22562/? W/System.err:     at okhttp3.a.g.e.k(RealConnection.kt:9)
2020-10-27 10:13:11.799 22562-22562/? W/System.err: 	... 45 more
```