

- https://zh.cppreference.com/w/cpp/io/basic_stringstream
- https://stackoverflow.com/a/50594005/7707781

当我们在一个循环里对 stringstream 做过一些拼装后 

```c++

/* 线上编译器 : https://godbolt.org/z/3x17xreaa */


void testStringStream() {
    std::stringstream strStream;
    strStream << "[";
    for(int index = 0; index < 3; index++) {
    strStream << index << ",";
    }
    strStream << "]";  

    std::cout << strStream.str() << std::endl;  /* [0,1,2,] */
}

void testStringStream2() {
    std::stringstream strStream;
    strStream << "[";
    for(int index = 0; index < 3; index++) {
    strStream << index << ",";
    }
    strStream.seekp(-1, strStream.end);
    strStream << "]"; 

    std::cout << strStream.str() << std::endl;  /* [0,1,2] */
}

void testStringStream3() {
    std::stringstream strStream;
    strStream << "[";
    for(int index = 0; index < 3; index++) {
    strStream << index << ",";
    }

    strStream << "]"; 

    strStream.seekp(-2, strStream.end);
    strStream << "]";

    std::string result;
    strStream.seekg(1, strStream.beg);
    strStream >> result;
    // strStream.seekg()
    std::cout << strStream.str() << "|" << result << std::endl; /* [0,1,2]]|0,1,2]] */
}

int main() {
    testStringStream();
    testStringStream2();
    testStringStream3();
    return 0;
}
```


- seekg 设置当前关联 streambuf 对象的输 **入** 位置指示器。
  - 用于将 stringstream 内容写入到其他位置的时候使用 
- seekp 设置当前关联 streambuf 对象的输 **出** 位置指示器。
  - 用于将内容写入 stringstream 的时候使用

