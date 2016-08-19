###DDuilib
*** 
#### **目录**
* [项目介绍](#项目介绍)
* [其它说明](#其它说明)
* [初次使用](#初次使用)
* [自行编译](#自行编译)
* [目录详情](#目录详情)
* [Demo截图](#截图)
* [作者信息](#作者信息)

***
#### **项目介绍** 

什么是DDuilib(原名“Duilib for Delphi”)？ DDuilib是一个建立在C++开源项目[duilib](https://github.com/duilib/duilib)之上，且最大限度不去修改duilib源代码从而可以应用在Delphi或者FreePascal中构建漂亮的UI的Pascal语言开源项目。**在此也非常感谢duilib作者的辛劳，没有他的库也许就没有现在这DDuilib** 更多关于项目的开发可以访问[我的博客](http://blog.csdn.net/zyjying520/article/details/49976667)。


#### **其它说明** 

考虑到github经常被墙和访问慢的缘故，这里使用了2个地址存放代码以满足不同用户访问：
1、[Github项目地址](https://github.com/ying32/duilib-for-Delphi/) 
2、[OSC项目地址](http://git.oschina.net/ying32/Duilib-for-Delphi)
 
##### **--重要说明--** 
所有的代码都是在DelphiXE6下编写的，后来考虑到低版本的用户无法使用，就对代码做了兼容性调整，目前可以应用在Delphi7或者高于Delphi7版本和FreePascal中。  
`由于Delphi版本过多，可能有些没有照顾到，大家可以向我提出，我会第一时间修改。`  
`这里作者不推荐使用不支持Unicode的Delphi版本。`  
**另有时候可能没有太多时间对非Unicode版本做兼容性测试，希望大家见谅，但一有空就会修复兼容性问题。**


#### **初次使用**  
使用DDuilib需要具备一定的Delphi基础，其次，最好了解下[duilib](https://github.com/duilib/duilib)以及如何建立UI的xml布局文件，这样学习起来会少走很多弯路。

> 简单示例：完整示例可查看[Duilib for Delphi入门](http://blog.csdn.net/zyjying520/article/details/50184759)   

> 另外做了个VCL版本的，在DDulib目录下DDuilibVcl组件工程，注册后只需要在首个窗口添加一个TDDuiApp组件，每个窗口分别添加TDDuiForm组件，并指定相应的布局资源及文件资源。使用此组件可以简化创建窗口部分并可以和VCL相结合。
  
```delphi

// dpr文件
program Apps;

uses
  DuiWindowImplBase;

constructor TAppsWindow.Create;
begin
  inherited Create('MainWindow.xml', 'skin\Apps');
  CreateWindow(0, 'Apps', UI_WNDSTYLE_FRAME, WS_EX_WINDOWEDGE);
end;

destructor TAppsWindow.Destroy;
begin
  inherited;
end;

function TAppsWindow.DoCreateControl(pstrStr: string): CControlUI;
begin
  Result := nil;
end;

procedure TAppsWindow.DoHandleMessage(var Msg: TMessage; var bHandled: BOOL);
begin
  inherited;
end;

procedure TAppsWindow.DoInitWindow;
begin
  inherited;
end;

procedure TAppsWindow.DoNotify(var Msg: TNotifyUI);
var
  LType, LCtlName: string;
begin
  inherited;
  LType := Msg.sType;
  LCtlName := Msg.pSender.Name;
  if LType.Equals(DUI_MSGTYPE_CLICK) then
  begin
    if LCtlName.Equals(kclosebtn) then
      DuiApplication.Terminate
    else if LCtlName.Equals(krestorebtn) then
      Restore
    else if LCtlName.Equals(kmaxbtn) then
      Maximize
    else if LCtlName.Equals(kminbtn) then
      Minimize;
  end;
end;

{$R *.res}

begin
  DuiApplication.Initialize;
  AppsWindow := TAppsWindow.Create;
  AppsWindow.Show;
  DuiApplication.Run;
  AppsWindow.Free;
end.

``` 

#### **自行编译** 
正常情况下本人已经提供了编译好后的各个版本duilib二进制，存放在**Duilib\bin**目录下。
现已提供本人修改过后的duilib源码，工程是用vs2013编译的

#### **目录详情** 
> 
* 1、 DDuilib
   * duilib for Delphi源目录。
>
* 2、Demo
   * 新的Demo工程目录
 >  
* 3、Duilib
   * 存放原[duilib](https://github.com/duilib/duilib)工程目录，这里不提供原[duilib](https://github.com/duilib/duilib)的源码，请自行下载。
   * 3.1、 bin
      * 存放编译后的二进制及图片和xml资源，里面有的包含原duilib的资源文件  
   * 3.2、 Duilib
      * 存放duilib c++工程源码
>	  
* 4、ThirdParty
   * 存放一些第三方的库或者二进制文件


#### **截图**

![截图1](https://raw.githubusercontent.com/ying32/duilib-for-Delphi/master/screenshot3.png) 
![截图1](https://raw.githubusercontent.com/ying32/duilib-for-Delphi/master/screenshot1.png)  
![截图3](https://raw.githubusercontent.com/ying32/duilib-for-Delphi/master/screenshot2.png)  
![截图4](https://github.com/ying32/duilib-for-Delphi/raw/TestDelphi/screenshot4.jpg)  
#### **作者信息** 
##### 多少无所谓，反正想捐助的就随心吧，不捐助也毫无影响。  

![欢迎捐助](https://github.com/ying32/duilib-for-Delphi/raw/TestDelphi/20160816094242.jpg)  
[ying32](mailto:1444386932@qq.com) 

