


在 WebStrom 中 JavaScript Language Version 选用 Flow 可以支持如下代码 : 
```JavaScript

```



[JavaScript 学习](https://developer.mozilla.org/zh-CN/docs/Web/JavaScript)
- [JavaScript 内置对象 , 例如 Array](https://developer.mozilla.org/zh-CN/docs/Web/JavaScript/Reference/Global_Objects)




我们在使用 React 框架的时候 , 在 JavaScript 函数中包含标签的编码形式: 
```JavaScript
/* 这是 JSX */
function VideoList({ videos, emptyHeading }) {
  const count = videos.length;
  let heading = emptyHeading;
  if (count > 0) {
    const noun = count > 1 ? 'Videos' : 'Video';
    heading = count + ' ' + noun;
  }
  return (
    <section>
      <h2>{heading}</h2>
      {videos.map(video =>
        <Video key={video.id} video={video} />
      )}
    </section>
  );
}
```
- [官方 React 网站](https://react.dev/)
   - [中文 React 网站](https://zh-hans.react.dev/)
