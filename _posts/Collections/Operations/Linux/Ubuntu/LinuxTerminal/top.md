查看当前系统资源的使用状况

$ top //显示当前状况

t - 增加 CPU 的形象性

m - 增加 mem 的形象性

Tom 详细描述：[linux命令积累(1)——top/ps/kill命令的使用](http://blog.51cto.com/ypyu1989/1542527)

```
top - 09:10:07 up 49 min,  1 user,  load average: 0.79, 0.80, 0.78
Tasks: 293 total,   2 running, 290 sleeping,   0 stopped,   1 zombie
%Cpu(s):  5.2 us,  3.3 sy,  0.0 ni, 90.4 id,  1.1 wa,  0.0 hi,  0.0 si,  0.0 st
KiB Mem :  8064388 total,  3157484 free,  2522460 used,  2384444 buff/cache
KiB Swap: 10931196 total, 10931196 free,        0 used.  4504636 avail Mem 

  PID USER      PR  NI    VIRT    RES    SHR S  %CPU %MEM     TIME+ COMMAND     
 1192 root      20   0  635088 130348  95416 S  21.2  1.6   5:56.94 Xorg        
 3674 tom       20   0  587236 154692 120600 S  16.9  1.9   4:14.03 chrome     
```
> Tasks: 293 total,   2 running, 290 sleeping,   0 stopped,   1 zombie
第二行	Tasks 任务（进程），系统现在共有183个进程，其中处于运行中的有1个，182个在休眠（sleep），stoped状态的有0个，zombie状态（僵尸）的有1个。

- 查找并杀死僵尸进程
    - `ps -e -o ppid,stat | grep Z` //找到僵尸PID
    - `ps -e | grep PID`//查看进程是谁()
    - `kill PID`//杀死进程