
> 还不熟悉的时候会面临 application 出现异常却无从了解异常原因 . 比如接口 500 . 
1. 查看有限的日志信息中是否含有 WARN/ERROR
2. 可以打开全局日志开关 `logging.level.root`
3. 可以自定义全局异常捕获
    ```kotlin
    @ControllerAdvice
    class GlobalThrowableHandle {
        @ExceptionHandler(Throwable::class)
        fun handleException(throwable: Throwable): ResponseEntity<String?>? {
            // 打印异常信息
            logger.error("全局异常捕获", throwable)

            // 返回默认的操作，可以根据需要更改返回值
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body("Internal Server Error")
        }
    }
    ```


> 每次修改一个类 , 都需要重启服务 , 才能测试调试 . 模糊记得刚开始用 Spring 好像不用重启 . 
