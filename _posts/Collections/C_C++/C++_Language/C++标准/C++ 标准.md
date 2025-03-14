# C++ 标准
在正式运用 C++ 之前我们有必要了解一些 C++ 标准以及和 C++ 相关的一些历史。

## 一、标准制定组织(预备内容 _跳读_ )
### 1.1、ANSI(AMERICAN NATIONAL STANDARDS INSTITUTE)
美国国家标准学会（AMERICAN NATIONAL STANDARDS INSTITUTE: ANSI）成立于1918年。当时，美国的许多企业和专业技术团体，已开始了标准化工作，但因彼此间没有协调，存在不少矛盾和问题。为了进一步提高效率，数百个科技学会、协会组织和团体，均认为有必要成立一个专门的标准化机构，并制订统一的通用标准。

### 1.2、ISO(International Organization for Standardization)
国际标准化组织（International Organization for Standardization，ISO）简称ISO，是一个全球性的非政府组织，是国际标准化领域中一个十分重要的组织。。ISO一来源于希腊语“ISOS”，即“EQUAL”——平等之意。ISO国际标准组织成立于1946年，中国是ISO的正式成员，代表中国参加ISO的国家机构是中国国家技术监督局(CSBTS）

ISO负责目前绝大部分领域（包括军工、石油、船舶等垄断行业）的标准化活动。ISO现有117个成员，包括117个国家和地区。ISO的最高权利机构是每年一次的“全体大会”，其日常办事机构是中央秘书处，设在瑞士日内瓦。中央秘书处现有170名职员，由秘书长领导。ISO的宗旨是“在世界上促进标准化及其相关活动的发展，以便于商品和服务的国际交换，在智力、科学、技术和经济领域开展合作。”ISO通过它的2856个技术结构开展技术活动，其中技术委员会（简称SC）共611个，工作组（WG）2022个，特别工作组38个。中国于1978年加入ISO，在2008年10月的第31届国际化标准组织大会上，中国正式成为ISO的常任理事国。

国际标准化组织总部设于瑞士日内瓦，成员包括162个会员国。该组织自我定义为非政府组织，官方语言是英语、法语和俄语。参加者包括各会员国的国家标准机构和主要公司。它是世界上最大的非政府性标准化专门机构，是国际标准化领域中一个十分重要的组织。

### 1.3、IEC(International Electrotechnical Commission)
国际电工委员会（IEC）成立于1906年，至2017年已有111年的历史。它是世界上成立最早的国际性电工标准化机构，负责有关电气工程和电子工程领域中的国际标准化工作。国际电工委员会的总部最初位于伦敦，1948年搬到了位于日内瓦的现总部处。1887-1900年召开的6次国际电工会议上，与会专家一致认为有必要建立一个永久性的国际电工标准化机构，以解决用电安全和电工产品标准化问题。1904年在美国圣路易召开的国际电工会议上通过了关于建立永久性机构的决议。1906年6月，13个国家的代表集会伦敦，起草了IEC章程和议事规则，正式成立了国际电工委员会。1947年作为一个电工部门并入国际标准化组织（ISO），1976年又从ISO中分立出来。宗旨是促进电工、电子和相关技术领域有关电工标准化等所有问题上（如标准的合格评定）的国际合作。该委员会的目标是：有效满足全球市场的需求；保证在全球范围内优先并最大程度地使用其标准和合格评定计划；评定并提高其标准所涉及的产品质量和服务质量；为共同使用复杂系统创造条件；提高工业化进程的有效性；提高人类健康和安全；保护环境。

### 二、C++11

C++11标准是 ISO/IEC 14882:2011 - Information technology -- Programming languages -- C++ 的简称[1]  。

C++11标准由国际标准化组织（ISO）和国际电工委员会（IEC）旗下的 __C++标准委员会（ISO/IEC JTC1/SC22/WG21）__ 于2011年8月12日公布  ，并于2011年9月出版。2012年2月28日的国际标准草案(N3376)是最接近于C++11标准的草案（仅编辑上的修正）。此次标准为C++98发布后13年来第一次重大修正。

|标准版本|C++标准第三版  |标准文件号  |ISO/IEC 14882:2011 |
|-------|-------------|----------|---------------------|
|中文名  |C++11        |发布时间   |2011年8月12日         |
|外文名  |C++11        |出版时间   |2011年9月            |

C++11标准为C++编程语言的第三个官方标准，正式名叫ISO/IEC 14882:2011 - Information technology -- Programming languages -- C++ 。[1]  在正式标准发布前，原名C++0x。它将取代C++标准第二版ISO/IEC 14882:2003 - Programming languages -- C++ 成为C++语言新标准。

C++11包含了核心语言的新机能，并且拓展C++标准程序库，并且加入了大部分的C++ Technical Report 1程序库(数学上的特殊函数除外)。C++ 标准委员会计划在2010年8月之前完成对最终委员会草案的投票，以及于2011年3月3召开的标准会议完成国际标准的最终草案。最终于2011年8月12日公布，并于2011年9月出版。2012年2月28日的国际标准草案(N3376)是最接近于现行标准的草案(编辑上的修正)。此次标准为13年第一次重大修正。

ISO将在2014年和2017年发布C++的后续版本


## 常见问题

问：为什么标准很难阅读？我无法通过阅读它来学习 C++。

该标准并非旨在教授如何使用 C++。相反，它是一份国际条约——一份正式的、合法的、有时甚至令人费解的详细技术文档，主要面向编写 C++ 编译器和标准库实现的人。

幸运的是，有很多好书可以教如何使用 C++！ 将这些建议 视为有关如何学习和使用 C++ 的高质量教程和参考信息的起点。



## 参考 & 引用

0. [现在 C++ 标准都是从这里发布的](https://isocpp.org/std/the-standard)

1. [C 标准和 C++ 标准](http://www.360doc.com/content/16/1030/10/7510008_602493549.shtml)
2. [ANSI标准](https://baike.baidu.com/item/ANSI标准/3127116)
3. [国际标准化组织](https://baike.baidu.com/item/国际标准化组织/779832?fr=aladdin&fromid=10400&fromtitle=iso)
4. [国际电工委员会](https://baike.baidu.com/item/国际电工委员会/2876390?fr=aladdin&fromid=4790515&fromtitle=IEC)
5. [c++11](https://baike.baidu.com/item/c++11/2522975?fr=aladdin)


