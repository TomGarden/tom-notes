


## 0x01 [CSS 的值与单位](https://developer.mozilla.org/zh-CN/docs/Learn/CSS/Building_blocks/Values_and_units)

```html
<!-- 代码段① -->
<Divider sx={{marginY: 4}}> divider CENTER</Divider>
<!-- 代码段② -->
<Divider sx={{marginY: '4rem'}}> divider CENTER</Divider>


<!-- marginY 相当于 指定了 CSS 的 margin-top, margin-bottom 为相同值 
     marginY 转 CSS 规则定义 : https://mui.com/system/spacing/
-->
```

但是这里的值是没有单位的 , 在 HTML/CSS 中这个单位相关有什么规则 . 
在 MUI 的规则下 , 涉及到的内容如下
1. `代码段①` , 那么会根据 theme{ space } 值做转换 . 
2. `代码段①` , 值本身不经转换直接传递到 css 去 . 

[我们只列出目前来看比较常用的相关内容](https://developer.mozilla.org/zh-CN/docs/Learn/CSS/Building_blocks/Values_and_units) 
- "在构建可访问的网站时，应避免使用像素来调整字体元素的大小。它们的绝对性意味着它们不可扩展。" https://blog.hubspot.com/website/css-rem
   - 一般来说更多使用 `rem` / `em` / `percentage`
- 绝对长度单位一般不使用 , 多用于我们在日志中查看设备详情 . 
- 相对长度单位 , 多用于我们常规布局与页面绘制
   - `rem`(root element) 相对于 `根元素的字体大小。`
      - 这个根元素字体大小 一般 是 `16px` , mui 不设置的情况下看起来也是 `16px`
   - `em`  ,  `在 font-size 中使用是相对于父元素的字体大小，在其他属性中使用是相对于自身的字体大小，如 width。`


## 0x02 CSS : margin / margin-block / margin-inline
https://developer.mozilla.org/zh-CN/docs/Web/CSS/margin-block


### 2.1 盒子模型 box model
1. https://developer.mozilla.org/zh-CN/docs/Glossary/Block/CSS
2. https://medium.com/@DaphneWatson/css-display-properties-block-inline-and-inline-block-how-to-tell-the-difference-7d3a1e6e3051
3. https://developer.mozilla.org/zh-CN/docs/Learn/CSS/Building_blocks/The_box_model
4. display 属性相关 : https://developer.mozilla.org/zh-CN/docs/Web/CSS/display



### 2.2 页面流(page flow) 是什么
https://developer.mozilla.org/zh-CN/docs/Learn/CSS/CSS_layout/Normal_Flow
