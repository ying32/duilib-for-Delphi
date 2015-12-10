##Duilib for Delphi
===============================================================================

**为了让更多人能了解到这个项目，决定迁移一份代码到github上，oschina将只同步github的代码，**   
**不作提交，[github项目地址](https://github.com/ying32/duilib-for-Delphi/),**
**[原oschina项目](http://git.oschina.net/ying32/Duilib-for-Delphi)** 


**关于Duilib for Delphi的详情，可见[我的博客](http://blog.csdn.net/zyjying520/article/details/49976667)**
### 重要说明
***
代码基于DelphiXE6编写，其中有用到了不少新我的新特性，使用最少需要符合以下条件：    

* 1、支持`Unicode`;
* 2、支持class的`helper`语法;
* 3、record的`运算符重载`；
* 3、`泛型`少量。


### 目录祥情
***
* 1、 CppConvert  
   * 一个特定的转换工具，根据MakeList.txt与MakeCppSourceDef.txt的配置生成duilib.pas和DirectUIlib.cpp，DirectUIlib.h三个文件。

* 2、 DDuilib
   * duilib for Delphi源目录。

* 3、 DuilibExport
   * 需要加入到原[duilib](https://github.com/duilib/duilib)工程中编译的c++源文件。

* 4、Demo
   * 新的Demo工程目录
   
* 5、Duilib
   * 存放原[duilib](https://github.com/duilib/duilib)工程目录，这里不提供原[duilib](https://github.com/duilib/duilib)的源码，请自行下载。
   * 5.1、 bin
      * 存放编译后的二进制及图片和xml资源，里面有的包含原duilib的资源文件 

### 说明
***
  **需要将DuilibExport下的DirectUIlib.cpp和DirectUIlib.h加入原[duilib](https://github.com/duilib/duilib)工程中，然后查看ReadMe.txt修改一处duilib的源代码，然后重编译duilib工程, 主意vs中设置为Unicode工程** 


### 截图
***
![截图2](https://raw.githubusercontent.com/ying32/duilib-for-Delphi/master/screenshot3.png) 
![截图1](https://raw.githubusercontent.com/ying32/duilib-for-Delphi/master/screenshot1.png)  
![截图2](https://raw.githubusercontent.com/ying32/duilib-for-Delphi/master/screenshot2.png)  


### 作者信息
***
[ying32](mailto:1444386932@qq.com) 
[QQ群429151353](http://shang.qq.com/wpa/qunwpa?idkey=de0faba813de168a104d9160c9271d9873a8c91f30b416c11ff89cb2bdf6564b) 
