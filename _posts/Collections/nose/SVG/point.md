在构建 Blog 的过程中，第一次照猫画虎可用了，但是细节不太了解。今天第二次碰到了，就详细的记录一下。

## `"<SVG>"` 子标签 `"<glyph>"`
一个 `glyph` 元素定义了SVG字体中的一个独立的字形。

### `glyph` 的属性

#### `glyph-name = "<name> [, <name> ]* "`
一个glyph(字形)的名字。glyph 的名字在一个 fount 推荐设置为唯一值。glyph-name 可以用于 Unicode 字符串无法准确访问目标字形的情况：例如当一个 Unicode 对应多个字符的情况。 在调整字符间距的时候 glyph-name 能被用到。

#### `unicode = "<string>"`
一个或多个 Unicode 字符，指示与此字形相对应的字符序列。如果提供一个 Unicode 字符，则此 glyph(字形) 对应于给定的 Unicode 字符。 如果提供了一个字符序列，则此 glyph(字形) 对应于给定的 Unicode 字符序列。One use of a sequence of characters is ligatures。 例如，如果 unicode="ffl'，那么给定的(glyph)字形将用于渲染字符序列 “f”，“f”和“l”。

使用十六进制或者十进制表示法表示的 XML 字符引用来引用字符通常很有用。例如，unicode="ffl"通过十六进制字符引用可表示为 `unicode="&#x66;&#x66;&#x6c;"`;或者使用十进制字符引用可表示为 `unicode="&#102;&#102;&#108;"`。

`unicode`属性有助于确定那个 glyph(字形) 表示那个字符的过程。[参阅：字形选择规则](https://www.w3.org/TR/SVG/fonts.html#GlyphSelectionRules)。如果`unicode`属性未设置，唯一使用 glyph 的方式是通过 `altGlyph` 引用。

#### `d = "path data"`
glyph(字形)轮廓定义,使用与 `<path>` 元素相同的语法。

#### `horiz-adv-x = "<number>"`
在水平方向上渲染 glyph(字形) 后的水平推进。如果没有制定本属性，呈现的效果和设置了`font` 的 `horiz-adv-x` 相近。

字形宽度必须是非负的，即使字形通常从右到左呈现，如希伯来语和阿拉伯语脚本。

### 依然不明了的
```xml
<svg>
          
  <glyph glyph-name="home" unicode="&#58883;" d="……"  horiz-adv-x="1026" />
      
  <glyph glyph-name="github" unicode="&#59553;" d="……"  horiz-adv-x="1024" />
      
  <glyph glyph-name="mail" unicode="&#58914;" d="……"  horiz-adv-x="1024" />

</svg>
```

```css
.icon-mail:before { content: "\e622"; color: black;}
// .icon-github:before { content: "\e7ab"; color: black;}
.icon-github:before { content: "\e8a1"; color: black;}
.icon-home:before { content: "\e603"; color: black;}
```

```HTML
  <li class="horizontal_li">
    <a class="iconfont icon-github" href="……"></a> 
  </li>
```

属性 unicode 的值和属性 d 的值有关联，在只改变 unicode 而不改变 d 的情况下，图形发生变化。

属性 content 的值和 glyph 之间不知道存在何种关联，改变 content 而不改变 glyph 图形变乱码。



### 参考：
1. https://developer.mozilla.org/zh-CN/docs/Web/SVG/Element/glyph
2. https://www.w3.org/TR/SVG/fonts.html#GlyphElement