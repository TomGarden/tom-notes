C++ I/O


我们简单看过书籍和网站了解到这些内容
1. 由基类 ios_base 扩展出了 诸多 用于抽象的或用于文件的 I/O 类 . 
2. 基类中的 get , getline 操作在子类中广泛可用 


我的问题就在于这些 stream 函数上 
1. 函数的边界行为是什么
2. 流的状态是怎么回事



参考网页 : https://zh.cppreference.com/w/cpp/io/basic_ifstream

针对测试的几个函数留一点笔记

get , 是用于读取单个字符的场景的 : https://zh.cppreference.com/w/cpp/io/basic_istream/get

read 用于读取指定长度的字符 , 如果应用于循环应该准确评估最后一次读取的字数 , 避免乱码
```c++
  /* 从 filePath 读取文本放到 result 中
     @return true, 读取过程中没有错误 
             false,读取过程中有错误*/
  bool readStrFromFile2(string filePath, string& result) {
    ifstream helpTxtFs(filePath) ;

    bool good = true;

    long fileSize ; { /* 通过移动标记位置计算出文本一共是多少字节 */
      helpTxtFs.seekg(0, ios::beg);
      streampos begFlag = helpTxtFs.tellg();
      helpTxtFs.seekg(0, ios::end);    
      streampos endFlag = helpTxtFs.tellg();
      helpTxtFs.seekg(0, ios::beg);
      fileSize = endFlag - begFlag;
    }

    int tempLen = 1024;/* 读取内容缓冲区大小 */
    char charPtr[tempLen];

    while(helpTxtFs.good() && fileSize > 0) {
      
      int length ; {/* 要下次读取的字节数 */
        if(fileSize >= tempLen) {
          length = tempLen;
        } else {
          length = static_cast<int>(fileSize);
        }
      }
      
      helpTxtFs.read(charPtr, length);

      if(helpTxtFs.good()) {
        fileSize -= length;
        result.append(charPtr, length);
      } else {
        good = false;
      }
    }

    helpTxtFs.close();
    return good;
  }
```
 
readline, 我们还可以使用 std::readline 位于  `<string>` 
```c++
  /* 从 filePath 读取文本放到 result 中
     @return true, 读取过程中没有错误 
             false,读取过程中有错误*/
  bool readStrFromFile(string filePath, string& result) {
    ifstream helpTxtFs(filePath) ;
    string line;

    bool good = true;

    while(helpTxtFs.good()) {
      getline(helpTxtFs, line);
      if(helpTxtFs.good()) {
        result.append(line).append("\n");
      } else {
        good = false;
      }
    }

    helpTxtFs.close();
    return good;
  }
```