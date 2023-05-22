我们在使用 Content Provider 的时候，外部应用传递给 ContentProvider Uri。Content Provider 解析 Uri 并且并且检索数据。

这里的问题是 Content Provider 可以提供一切 sqlite 查询的能力。但是外部应用如果传入 参数化查询 所需要的参数。

结论无外乎：
1. 外部应用无法参数化查询，只能通过 Uri 中的字段来使用 Content Provider 预设提供的能力。
2. 发现参数化查询的方式。

__结果__:    
- 我们不需要使用 Uri 携带参数。
- 通过 `contentResolver.query(Uri uri, String[] projection, Bundle queryArgs, CancellationSignal cancellationSignal) ` 可以直接传入参数化查询所需要的所有参数。
    - 直接在 ContentProvider 中使用传入的参数即可。


__结论__
- Uri 不能携带过多的查询参数。
- 外部应用调用 ContentProvider 的时候参数化查询所需要的参数通过` contentResolver.query(Uri uri, String[] projection, Bundle queryArgs, CancellationSignal cancellationSignal) `传入并使用。

