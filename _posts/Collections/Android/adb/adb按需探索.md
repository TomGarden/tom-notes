## 一、adb 调用 ContentProvider
查看命令手册
- adb shell content
    ```terminal
    usage: adb shell content read --uri <URI> [--user <USER_ID>]
    Example:
    # cat default ringtone to a file, then pull to host
    adb shell 'content read --uri content://settings/system/ringtone > /mnt/sdcard/tmp.ogg' && adb pull /mnt/sdcard/tmp.ogg
    ```

## 二、 adb pm