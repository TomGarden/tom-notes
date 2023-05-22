

Reactive 

中文可以说是响应式编程 , 反应式编程 . 

把事件(产生的信息/信号们)像 流 一样管理 . 

Reactive 这种编程模式 , 实际上是 观察者模式的 一种实例化 . 

其中最核心的接口是 `IObservable<T>` 和 `IObserver<T>` , 

很大程度上 `ISubject` 可以视为 `IObserver` , 但是为什么不直接用 `IObserver` 我还没有完全意会 . 

每一个 `数据流` 都有特征 , 实例化为具体的类 . 

但是一个总体的特征是 , 每一个步骤会体现在 onNext 回调 , 每一个结果会体现在 onError 或 onComplete 回调

subscribeOn : 决定任务的执行线程
observeOn   : 决定观察者回调的执行线程 onNext, onError, onComplete


rxcpp 想要 subscribeOn(其他线程) observeOn(当前线程) ; 
```c++
#include "rxcpp/rx.hpp"
// create alias' to simplify code
// these are owned by the user so that
// conflicts can be managed by the user.
namespace rx=rxcpp;

int main()
{
    std::cout << std::setw(16) << std::this_thread::get_id() << " <- main thread id" << std::endl;

    using namespace std::chrono;

    rx::schedulers::run_loop rl;

    auto mainthread = rx::observe_on_run_loop(rl);
    auto workthread = rx::synchronize_new_thread();

    rx::composite_subscription lifetime;

    rx::observable<>::interval(workthread.now() + milliseconds(100), milliseconds(400)).
        map([](int i){
            std::cout << std::setw(16) << std::this_thread::get_id() << ": " << i << std::endl;
            return i;
        }).
        take_until(rx::observable<>::timer(seconds(1))).
        subscribe_on(workthread).
        observe_on(mainthread).
        subscribe(lifetime, [&](int i){
            std::cout << std::setw(16) << std::this_thread::get_id() << ": " << i << std::endl;
        });

    while (lifetime.is_subscribed() || !rl.empty()) {
        while (!rl.empty() && rl.peek().when < rl.now()) {
            rl.dispatch();    /* 手动事件分发 */
        }
    }
    return 0;
}
```
