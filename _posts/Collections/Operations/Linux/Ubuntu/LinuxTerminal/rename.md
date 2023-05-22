批量重命名：
```
tom32@tom32:/media/tom32/document/doing/steady/test_apk/so$ ls
libantifraud.so.tlf        libcrashlytics.so.tlf  libimagepipeline.so.tlf  libsupervisor.so.tlf   libttEncrypt.so.tlf      libttvideouploader.so.tlf
libbspatch.so.tlf          libdaemon.so.tlf       libsec.so.tlf            libtfcc.so.tlf         libttmplayer_mc.so.tlf   libuserinfo.so.tlf
libBugly.so.tlf            libgifimage.so.tlf     libstatic-webp.so.tlf    libtnet-3.1.11.so.tlf  libttmplayer.so.tlf      libweibosdkcore.so.tlf
libcocklogic-1.1.3.so.tlf  libgif.so.tlf          libstimagetone.so.tlf    libtongdun.so.tlf      libttnativecrash.so.tlf
tom32@tom32:/media/tom32/document/doing/steady/test_apk/so$ rename     's/\.tlf$//'       *.tlf
tom32@tom32:/media/tom32/document/doing/steady/test_apk/so$ ls
libantifraud.so  libcocklogic-1.1.3.so  libgifimage.so       libsec.so          libsupervisor.so   libtongdun.so       libttmplayer.so        libuserinfo.so
libbspatch.so    libcrashlytics.so      libgif.so            libstatic-webp.so  libtfcc.so         libttEncrypt.so     libttnativecrash.so    libweibosdkcore.so
libBugly.so      libdaemon.so           libimagepipeline.so  libstimagetone.so  libtnet-3.1.11.so  libttmplayer_mc.so  libttvideouploader.so

```