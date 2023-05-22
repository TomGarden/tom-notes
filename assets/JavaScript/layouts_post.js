/**滚动到顶部*/
function scroll2Top() {
  window.scrollTo(0, 0);
}

/**点击触发，显示(隐藏)目录*/
function appendCloneToc() {
  var eleTomToc = window.document.getElementById("tom-toc");
  if (!eleTomToc.toCloned) {
    var eleMarkdownToc = window.document.getElementById("markdown-toc").cloneNode(true);
    eleMarkdownToc.id = "markdown-toc-clone";
    eleTomToc.appendChild(eleMarkdownToc);
    eleTomToc.toCloned = true;
    eleTomToc.hidden = false;
  } else {
    var eleMarkdownTocClone = window.document.getElementById("markdown-toc-clone");
    eleMarkdownTocClone.remove();
    eleTomToc.toCloned = false;
    eleTomToc.hidden = true;
  }
}

/**界面滚动触发，控制按钮显示*/
window.onscroll = scroll;
function scroll() {
  // 注意: window.innerWidth 和 window.innerHeight 可以获得页面可见区域的宽和高.

  if (window.pageYOffset > 100) {
    document.getElementById("btn-scroll-2-top").hidden = false;
  } else {
    document.getElementById("btn-scroll-2-top").hidden = true;
  }

  var eleMarkdownToc = document.getElementById("markdown-toc");
  if (eleMarkdownToc != null) {//如果没有目录元素，方法结束
    var rectObject = eleMarkdownToc.getBoundingClientRect();
    if (rectObject.bottom < 0) {//bottom是底边距离窗口上边的距离
      document.getElementById("btn-tom-toc").hidden = false;
      showCloneToc(false);
    } else {
      document.getElementById("btn-tom-toc").hidden = true;
      showCloneToc(true);
    }
  }

  tomBtnShow();
}

/**滚动间接触发，控制包裹按钮的布局是否显示*/
function tomBtnShow() {
  var eleTomBtn = window.document.getElementById("tom-btn");
  var eleBtnTop = window.document.getElementById("btn-scroll-2-top");
  var eleBtnToc = window.document.getElementById("btn-tom-toc");
  if (eleBtnToc.hidden && eleBtnTop.hidden) {
    eleTomBtn.hidden = true;
  } else {
    eleTomBtn.hidden = false;
  }
}

/**显示或隐藏克隆的toc 
 * 有必要记录一下，关于 cloneToc 的隐藏和实现方式有两种
 * 1. 既可以通过页面位置(原始Toc是否显示)来改变 cloneToc 是否显示这件事；也可以通过点击按钮来控制 cloneToc 是否显示这件事。
 *    - 简言之，cloneToc 可以通两种方式来控制其显示或者隐藏。
 * 2. 仅仅通过按钮点击来控制 cloneToc 的显示或者隐藏。
 *
 * 3. 在上述两个观点见徘徊我们选择了 2 
 *    - 因为我们认为 1 有可能是用户产生些许的疑惑。
 *
 * 4. [栗子]假设当前 cloneToc 正在显示，我们通过滚动导致了原始toc的显示
 *    - 这时候我们希望 cloneToc 隐藏(此时按钮也是隐藏的，并且用户没有主动要求隐藏 cloneToc)
 *    - 当再次滑动使 原始Toc 不可见的时候 cloneToc 就会再次显示(因为用户没有主动取消它)。
 *        - 这里正是我们纠结(^_^)的地方
 *        - 还有一种做法是:(我们认为这有可能是用户产生疑惑)
 *            - 当再次滑动使 原始Toc 不可见的时候，不再显示 cloneToc
 */
function showCloneToc(hidden) {
  var eleMarkdownTocClone = window.document.getElementById("markdown-toc-clone");
  var eleTomToc = window.document.getElementById("tom-toc");
  if (eleMarkdownTocClone != null) {
    eleMarkdownTocClone.hidden = hidden;
    eleTomToc.hidden = hidden;
  }
}