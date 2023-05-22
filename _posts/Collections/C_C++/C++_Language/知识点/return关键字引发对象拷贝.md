

现在我们还不知道标题应该叫什么名字 . 

提出问题比解决问题来的更重要些 . 
但是由于很多时候提出问题并不困难 , 让人以为这是屁话 . 
从而忽略了这个逻辑链的后续 . 
只有明确了问题 , 才有合理发力解决问题的可能性 . 


## 0x01. 观察现象

我们碰到的一个小问题 : https://stackoverflow.com/q/73456694/7707781

I don't know how to change wstring value in struct . 
I don't know where is my error. do you help me ?

I can't understand why string value change success, wstring value change failed .
```c++
struct TestStruct{
  string falg1;
  wstring falg2;

  TestStruct setFlag1(string str ) {
    falg1 = str;
    return *this;
  }

  TestStruct setFlag2(wstring str ) {
    falg2 = str;
    return *this;
  }
};



int main(int argc,
         char ** argv) { 

      TestStruct testStruct;
      testStruct.setFlag1("string")
                .setFlag2(L"Wstring");
                
      wcout << "string length:" << testStruct.falg1.size() << endl;
      wcout << "Wstring content:" << '[' << testStruct.falg2 << ']' << endl;
      wcout << "Wstring length:" << '[' << testStruct.falg2.size() << ']' << endl;
}
```
The output content is :
```
string length:6
Wstring content:[]
Wstring length:[0]
```

### 1.1. 先说答案

`setFlag1` , `setFlag2` 两个函数中的 `return` 语句会导致返回 `testStruct` 的拷贝副本 . 

所以 对 `testStruct 拷贝副本`  的 `setFlag2` 操作无法通过 `testStruct` 对象保存下来 . 

要满足这个链式调用的形式可以 
```c++
/* 改写方式① */
TestStruct& setFlag1(string str ){...}
TestStruct& setFlag2(wstring str ){...}

/* 改写方式② */
TestStruct* setFlag1(string str ){...}
TestStruct* setFlag2(wstring str ){...}
```



### 1.2. 再提问题

1. 关于 return 这个操作涉及到的知识点是什么 . 
   或者说涉及到的 C++ 语言特性是什么 . 
   - [Does return statement copy values](https://stackoverflow.com/q/1529447/7707781)

2. 结合内存管理来理解 , 仅在函数内部声明的对象的返回操作应该作何理解 ? 
   - 这个放到 `2.x` 来考虑 . 

### 1.3. `return` 拷贝 涉及到的 C++ 知识

这个 `return` 的拷贝动作是发生在 `C / C++` 语言中的 . 

首先注意到 C++20 标准文档中的 :  `8.7.4 The return statement` : 

> the return statement initializes the glvalue result or prvalue result object of the (explicit or implicit) function call by copy-initialization from the operand.

> return 语句通过 对操作数的拷贝初始化 完成对函数调用者的回馈 . 

C 语言代码做测试也可以发现变量地址变化 :
```c
int testReturn() {
  int a = 100;
  printf("\t oldPath : %x  \n", &a);
  return a;
}

int main(int argc,
         char ** argv) {

  int result = testReturn();
  printf("\t newPath : %x  \n", &result);
  return 0;
}
```


我们的问题是 : 
1. 这个 `return` 的拷贝动作 , 是语言标准定义的呢 ; 
2. 还是说由于最初的 C 语言和编译器就写成了这个样子 , 所以后来一直沿用呢 ?

这两个问题我不直达是否有答案 , 不过目前三方面资料
1. C++ 标准有此拷贝描述
2. 实际测试有拷贝现象
3. 网友都说是拷贝了

我们可以相信 `return` 确实是发生了拷贝的 . 



## 0x02. 关于 内存管理

1. https://www.jianshu.com/p/d2a675726076
2. https://www.geeksforgeeks.org/memory-layout-of-c-program/

在C语言中，定义了4个内存区间：代码区；全局变量与静态变量区；局部变量区即栈区；动态存储区，即堆区。

下面分别对这4个区进行介绍。

① 代码区。代码区中主要存放程序中的代码，属性是只读的。

② 全局变量与静态变量区。也称为静态存储区域。内存在程序编译的时候就已经分配好，这块内存在程序的整个运行期间都存在。例如：全局变量、静态变量和字符串常量。分配在这个区域中的变量，当程序结束时，才释放内存。因此，经常利用这样的变量，在函数间传递信息。

③ 栈区。在栈上创建。在执行函数时，函数内局部变量的存储单元都可以在栈上创建，函数执行结束时这些存储单元自动被释放。
栈内存分配运算内置于处理器的指令集中，效率很高，但是分配的内存容量有限。在linux系统中，通过命令“ulimit –s”，可以看到，栈的容量为8192kbytes，即8M。
这种内存方式，变量内存的分配和释放都自动进行，程序员不需要考虑内存管理的问题，很方便使用。但缺点是，栈的容量有限制，且当相应的范围结束时，局部变量就不能在使用。

④ 堆区。有些操作对象只有在程序运行时才能确定，这样编译器在编译时就无法为他们预先分配空间，只能在程序运行时分配，所以称为动态分配。

⑤ 类中成员变量凡在哪个区域 , 需要看成员变量在什么山下文声明定义 . 

对这些说法我们还是存在疑问(类似的说法在中文网络比较普遍) , 写这些文字的人是怎么学到这些的 , 我们需要探究一下 .
- 我们想找到这个知识的源头 
- 在 C++ Primer (第五版) 第 12 章 开头有类似描述 . 
- 我没有找到源头 , 暂时接受这些观点吧 . 

### 2.1. 小结

需要了解 :  由于函数内的局部变量都放在 栈 上 , 所以当函数结束返回局部变量的引用或者指针 , 的操作会产生未知结果 . 


## 0x03. 在 C++20 标准文档中 , 我们注意到 "移动语义" 这件事

移动语义是相对于拷贝而言的 , 有了移动就可以避免不必要的复制动作了 . 



## 0x04. `return` 引发一个复制动作 , `=` 会引起复制动作吗?

默认的 , 是这样的 . 对于类类型的 `拷贝赋值运算` 的实际语义可以在类中定义 . 

### 4.1 参考

C++ Primer (第五版) 13章