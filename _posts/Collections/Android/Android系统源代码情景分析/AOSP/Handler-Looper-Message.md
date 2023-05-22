从代码实现角度尝试理解 Handler 通信细节疑惑点

当前主要探究的方向有二:
1. `handler.post(Runnable{})` 是如何实现的(没有触发 `Handler.handMessage` 回调)
2. `handler.sendMessage(msg)` 当 `msg = Message(handler,Runnable())` 是如何实现的

## 0x01. Looper
