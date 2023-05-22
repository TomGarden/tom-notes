/**读取 JSON 文件*/
function readTextFile(file, callback) {
  var rawFile = new XMLHttpRequest();
  rawFile.overrideMimeType("application/json");
  rawFile.open("GET", file, true);
  rawFile.onreadystatechange = function () {
    if (rawFile.readyState === 4 && rawFile.status == "200") {
      callback(rawFile.responseText);
    }
  }
  rawFile.send(null);
}




/**处理一个被筛选出来的条目*/
function appendSearchResult(jsonItem, searchValue, regExp) {
  var title = jsonItem.title.replace(regExp, "<strong>" + searchValue + "</strong>");
  var date = jsonItem.date.replace(regExp, "<strong>" + searchValue + "</strong>");
  var path = jsonItem.path.replace(regExp, "<strong>" + searchValue + "</strong>");

  var eleOl = document.getElementById("search-result-ol");

  var eleLi = document.createElement("li");
  eleLi.id = jsonItem.path;
  eleLi.tabIndex = -1;
  eleLi.setAttribute("onfocus", "searchLiFocus(this.id)");
  eleLi.setAttribute("onblur", "searchLiBlur(this.id)");
  eleLi.setAttribute("href", jsonItem.url);
  eleLi.setAttribute("onclick", "searchResultOnClick(this.getAttribute(\"href\"))");
  eleLi.innerHTML = title + " - " + date + "<br/>" + path;

  if (document.getElementById("search-result").hidden == true) {
    document.getElementById("search-result").hidden = false;
  }

  eleOl.appendChild(eleLi);
}

/**响应输入框内文字的变化事件*/
function onInput(event,jsonPath) {

  var reAll = /\s+/g;//匹配所有空字符
  if (event.target.value.replace(reAll, "").length == 0) {
    //删除空字符后如果长度为空就取消搜索
    document.getElementById("search-result-ol").innerHTML = "";
    document.getElementById("search-result").hidden = true;
    console.log("已经设置了 hidden search-result")
    return;
  }

  var reFirstLast = /^\s*|\s*$/g;//匹配首尾部空字符的正则表达式
  var searchValue = event.target.value.replace(reFirstLast, "");
  var regExp = new RegExp(searchValue, "gi");//可用于匹配一个字符串中所有匹配项
  // readTextFile("{{site.baseurl}}/assets/json/search.json", function (text) {
  // 这种设置方式，不解析 basurl
  readTextFile(jsonPath, function (text) {
    var data = JSON.parse(text);

    //先取消当前显示的内容再重新添加
    document.getElementById("search-result-ol").innerHTML = "";
    document.getElementById("search-result").hidden = true;

    for (var i = 0; i < data.length; i++) {
      var aimAttr;
      var findIt = regExp.test(JSON.stringify(data[i]));
      if (findIt) {
        appendSearchResult(data[i], searchValue, regExp)
      }
    }
  });
}

/**
 * 输入框获取到了焦点
 */
function searchInputFocus() {
  console.log("input 搜索框  获取  焦点");
}

/**
 * 输入框失去焦点
 */
function searchInputBlur() {
  console.log("input 搜索框  失去  焦点 + " + document.activeElement.tagName);
}

/**
 * 搜索结果逐条焦点获取
 */
function searchLiFocus(id) {
  console.log("触发 focus id=" + id);
  document.getElementById(id).style = "background-color:#e8e8e8";
}

function searchLiBlur(id) {
  console.log("触发 blur id=" + id);
  document.getElementById(id).style = "";
}

/**
 * 搜索结果点击事件
 */
function searchResultOnClick(href) {
  //alert(href);
  window.location.href=href; 
}

/**
 * 键盘事件监听
 */
document.onkeydown = function (e) {
  e = e || window.event;

  switch (e.keyCode) {
    case 38:  /*上*/   break;
    case 40:  /*下*/   break;
    case 13:  /*回车*/  break;
    case 27:  /*ESC*/  break;
    default: return;
  }

  console.log(0);

  var focus;
  var focusElement = document.activeElement;
  var searchInput = document.getElementById("search-input");
  var focusParentElement = focusElement.parentElement;//假设 focusEle 是 li 本变量才有用
  var searchResultOl = document.getElementById("search-result-ol");
  if (focusElement.isSameNode(searchInput)) {
    focus = "searchInput";
    console.log(1);
    // if (!searchResultOl.hasChildNodes()) {
    //   console.log(2);
    //   return;
    // }
  } else if (focusParentElement.isSameNode(searchResultOl)) {
    focus = "searchResultOl";
    console.log(3);
  } else {
    console.log(4);
    return;
  }

  console.log(5);


  switch (e.keyCode) {
    case 38:  //上


      if (focus == "searchInput") {
        if (!searchResultOl.hasChildNodes()) {
          return;
        } else {
          searchResultOl.lastChild.focus();
        }
        console.log(activename)
      } else if (focus == "searchResultOl") {
        var previousEle = focusElement.previousSibling;
        if (previousEle == null) {
          searchInput.focus();
        } else {
          previousEle.focus();
        }
      }

      break;
    case 40:  //下

      if (focus == "searchInput") {
        if (!searchResultOl.hasChildNodes()) {
          return;
        } else {
          searchResultOl.firstChild.focus();
        }
      } else if (focus == "searchResultOl") {
        var nextEle = focusElement.nextSibling;
        if (nextEle == null) {
          searchInput.focus();
        } else {
          nextEle.focus();
        }
      }

      break;
    case 13:  //回车

      if (focus == "searchInput") {
        //alert("暂不处理");
      } else if (focus == "searchResultOl") {
        searchResultOnClick(focusElement.getAttribute("href"));
      }
      break;
    case 27:  //ESC
      document.getElementById("search-input").value = "";
      document.getElementById("search-result-ol").innerHTML = "";
      document.getElementById("search-result").hidden = true;
      //searchInput.blur();
      break;
    default:
      return;
  }
  return false;
}