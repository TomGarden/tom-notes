/**
 * 插入参数给定的节点
 */
function inner(filePath,url){

    //console.log("尚不存在：filePath="+filePath);
    //从路径的开始遍历枝枝丫丫是否存在
    var firstSlash = filePath.indexOf("/");
    while(firstSlash>0){
      var folderPath =  filePath.substr(0,firstSlash);
      var elementFolder = document.getElementById(folderPath);
      if(elementFolder!=null){//该文件夹存在，继续查看下一层是否存在
        var firstSlash = filePath.indexOf("/",firstSlash+1);
        if(firstSlash<0){//路径都存在了，只有文件还不存在
          //console.log("文件夹都存在了，只有文件还不存在："+filePath);
          growLeaf(filePath,url);
          break;
        }
      }else{//该文件夹不存在，完成对不存在部分的生长
        var oldBranch = folderPath;
        var newBranch = filePath;
        growBranch(oldBranch,newBranch,url);
        //console.log("从 【"+oldBranch+"】处长出新的树枝：【"+newBranch+"】");
        break;
      }
  
    }
  }
  
    /**
     * grow 生长，树木生长
     * 
     * 参数：brance(树枝)；从给定的老树枝开始生长出新枝丫。
     * oldBranch 包含了首个不存在的文件夹(最后一个 '/' 之后的字符)；如果不存在 '/' 说明是跟文件夹。
     * newBranch 包含了不存在文件的完整路径，结合 oldBranch 完成生长。
     */
    function growBranch(oldBranch,newBranch,url){
      // console.log("从 【"+oldBranch+"】处长出新的树枝：【"+newBranch+"】");
      
      var lastSlash = oldBranch.lastIndexOf("/");
      var attributeID;
      var noIndex;//尚未建立树结构的路径
      if(lastSlash<0){//这是从根目录开始完全没有建档
        attributeID = "";
        noIndex = newBranch;
      }else{//反斜杠(/)之前的树枝是已经存在的
        attributeID = oldBranch.substr(0,lastSlash);
        noIndex = newBranch.substr(lastSlash+1);//从首个不存在的节点开始被包含在这个字符串中
      }
  
      //获取需要逐个建档的文件名称到数组中
      var arryFiles = noIndex.split("/");
  
      for(var i = 0; arryFiles.length; i++){
        if(i == arryFiles.length-1){//最后一个是文件应该单独设置
          var eleLi = document.createElement("li");
          eleLi.className = "details_child";
          var eleA = document.createElement("a");
          if(attributeID.length>0){
            eleA.id = attributeID + "/" + arryFiles[i];
          }else{
            eleA.id = arryFiles[i];
          }
          eleA.href = url;
          eleA.target = "_blank";
          var elementTextnode = document.createTextNode(arryFiles[i]);
          eleA.appendChild(elementTextnode);
          eleLi.appendChild(eleA);
          document.getElementById(attributeID).appendChild(eleLi);
          break;
        }
  
        //文件夹被逐层创建节点
        var elementDetails = document.createElement("details");
        if(attributeID.length>0){
            elementDetails.id = attributeID + "/" + arryFiles[i];
          }else{
            elementDetails.id = arryFiles[i];
          }
        var elementSummary = document.createElement("summary");
        var elementTextnode = document.createTextNode(arryFiles[i]);
        elementSummary.appendChild(elementTextnode);
        elementDetails.appendChild(elementSummary);
        if(attributeID.length>0){
          document.getElementById(attributeID).appendChild(elementDetails);
        }else{
          document.getElementById("TreeView").appendChild(elementDetails);
        }
  
        if(attributeID.length>0){
          attributeID = attributeID + "/" + arryFiles[i];
        }else{
          attributeID = arryFiles[i];
        }
      }
    }
  
      /**
     * grow 生长，树木生长
     * 
     * 参数：树枝都长好了，直接张叶子。
     */
     function growLeaf(leaf,url){
      var lastSlash = leaf.lastIndexOf("/");
  
      var eleLi = document.createElement("li");
      eleLi.className = "details_child";
      var eleA = document.createElement("a");
      eleA.id = leaf;
      eleA.href = url;
      eleA.target = "_blank";
      var elementTextnode = document.createTextNode(leaf.substr(lastSlash+1));
      eleA.appendChild(elementTextnode);
      eleLi.appendChild(eleA)
      document.getElementById(leaf.substr(0,lastSlash)).appendChild(eleLi);
    }
  
    function openAll(){
      var eleDetails = document.getElementsByTagName("details");
      for(var i = 0; i<eleDetails.length; i++){
        eleDetails[i].open = true;
      }
    }
  
    function closeAll(){
      var eleDetails = document.getElementsByTagName("details");
      for(var i = 0; i<eleDetails.length; i++){
        eleDetails[i].open = false;
      }
    }