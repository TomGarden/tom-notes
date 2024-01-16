

基于 mui 的一些代码 : https://mui-treasury.com/layout/tutorials/dashboard-layout/

## [Mui]()

他们的产品列表
- MUI Core
  - Material UI : 即用型 Material Design UI 组件 . (理解上就是 没画过的 Material UI = Base UI + MUI System)
  - Base UI : 基础组件 , 仅仅是 UI 基础组件 , 没有 CSS 美化 , 可以选择自己中意的 CSS 美化器 . 
  - Mui System : CSS 实用程序的集合 . 用于使用 MUI 组件库快速布局自定义设计。
  - Joy UI : Joy UI 旨在作为 Material UI 的替代方案，用于不遵守 Material Design 规范的设计。
     Joy UI 是一个设计精美的 React UI 组件库，旨在激发开发过程中的乐趣。
- MUI X : 高性能的 Material UI 控件组件 , 比如时间选择器组件 , 文件树 组件 . 
- Templates : Material UI 模板 , 官方维护的预定义的 前端 模板 代码 . 
- Design kits : Material UI 设计稿 , 付费购买可以快速使用
- MUI Toolpad : 用拖拽的方式快速构建 UI 
  - 2023-07-21 08:21:27 这时候还是比较简单的控件 , 可以关注 , 暂时不够用
- **控件列表页面**: https://mui.com/material-ui/all-components/


Mui System 支持的 CSS 配置大多做过重命名了 , 虽然名称近似 , 但是对于没有 CSS 基础的人来说还是需要这个映射表的
- https://mui.com/system/properties/#properties-reference-table




## [mui](https://mui.com/) 使用细节的一点记录


### CSS 设置
  ```html
  <!-- 这行代码给我们造成了困扰所以记录下 -->
  <AdbIcon sx={{ display: { xs: 'none', md: 'flex' }, mr: 1 }} />

  <!-- 
    AdbIcon 其实就是 SvgIcon , 在导入的过程中重命名了
    SvgIcon文档 : https://mui.com/material-ui/api/svg-icon/

    "sx" 属性是定义可以访问主题的自定义样式的快捷方式。 详情 : https://mui.com/system/getting-started/the-sx-prop/

    "sx.display" 使用显示实用程序快速响应地切换显示、溢出、可见性等。 : https://mui.com/system/display/

    "sx.display.xs" 不明确的简介 https://mui.com/system/display/#hiding-elements
                    根据只言片语 : https://blog.csdn.net/Alan8865/article/details/123755236
                    猜测 xs 表示当前屏幕宽度尺寸边界 , firefox 测试这里的 xs 是 900 像素

    "sx.mr" margin right
  -->
  ```

### 图标了解
  mui 中有一种图标 , 可以直接像 Html 节点一样使用 , 他们通过节点名进行区分 . 图标列表 : 
  - icon 使用介绍 : https://mui.com/material-ui/icons/
    - icon 列表 : https://mui.com/material-ui/material-icons/


### [xs / sm / md / lg / xl / xxl](https://getbootstrap.com/docs/5.3/layout/grid/#grid-options)
  - Extra small (xs)
  - Small (sm)
  - Medium (md)
  - Large (lg)
  - Extra large (xl)
  - Extra extra large (xxl)

  以上相关内容只在 bootstrap 文档中找到

### [CSS 单位和值](https://developer.mozilla.org/zh-CN/docs/Learn/CSS/Building_blocks/Values_and_units)




### 主题内容
  - 主题文档查看 : https://mui.com/material-ui/customization/theming/
  - 主题资源 : https://mui.com/material-ui/getting-started/design-resources/
  - 主题创建可视化工具 : https://mui.com/material-ui/customization/theming/#theme-builder




## 继续学习

### Theme 对我们有一些影响 , 需要了解下

 对比布局 APP bar 的时候 , mt:100 这个 100 会导致多少像素距离是未知的 , 在理解这个 100是多少的时候注意到
 1. https://mui.com/system/spacing/#transformation
   - 这里的 m , 值 是要与 theme.spacing 做乘法 , 或者从 theme.spacing 数组中选择的
 2. 当想要打印 theme 中的所有值的时候发现不会
   - 但是我们依然可以了解学下 https://mui.com/material-ui/customization/theming/


### 我们想要在 MUI 的元素上应用 CSS 样式的时候 , 没有生效



{
    app_name: item(
        en:'Group Share',
        zh:'群组分享',
    ),
    app_label: item(
        en:'Group Share 2',
        zh:'群组分享',
    ),
}

转换为 

{
    app_name: 'Group Share',
    app_label: 'Group Share 2',
}