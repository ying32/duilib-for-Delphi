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

什么是DDuilib(原名“Duilib for Delphi”)？ DDuilib是一个建立在C++开源项目[duilib](https://github.com/duilib/duilib)之上，且最大限度不去修改duilib源代码从而可以应用在Delphi或者FreePascal中构建 DirectUI的开源项目。**在此也非常感谢duilib作者的辛劳，没有他的库也许就没有现在这DDuilib** 更多关于项目的开发可以访问[我的博客](http://blog.csdn.net/zyjying520/article/details/49976667)。


#### **其它说明** 

`用作项目时，同一个Form(Window)能不使用VCL混合就不混合，切记。`

考虑到github经常被墙和访问慢的缘故，这里使用了2个地址存放代码以满足不同用户访问：
1、[Github项目地址](https://github.com/ying32/duilib-for-Delphi/) 
2、[OSC项目地址](http://git.oschina.net/ying32/Duilib-for-Delphi)
 
##### **--重要说明--** 
所有的代码都是在DelphiXE6下编写的，后来考虑到低版本的用户无法使用，就对代码做了兼容性调整，目前可以应用在Delphi7或者高于Delphi7版本和FreePascal中。  
`由于Delphi版本过多，可能有些没有照顾到，大家可以向我提出，我会第一时间修改。`  
`这里作者不推荐使用不支持Unicode的Delphi版本。`  
**另有时候可能没有太多时间对非Unicode版本做兼容性测试，希望大家见谅，但一有空就会修复兼容性问题。**


#### **初次使用**  
使用DDuilib需要具备一定的Delphi基础，其次，最好了解下[duilib](https://github.com/duilib/duilib)以及如何建立UI的xml布局文件，这样学习起来会少走很多弯路。**此外DDuilib分为两个版本，一个是以库形式提供不需要安装，另一个则是以VCL组件形式提供。**

> 简单示例：完整示例可查看[Duilib for Delphi入门](http://blog.csdn.net/zyjying520/article/details/50184759)   

> 另外做了个VCL版本的，在DDulib目录下DDuilibVcl组件工程，每个窗口分别添加TDDuiForm组件，并指定相应的布局资源及文件资源。使用此组件可以简化创建窗口部分并可以和VCL相结合。  

> 安装DDuilib组件：  
> 安装前，需要将DDuilib依赖的Duilib_ud.dll或者Duilib.dll放入与bpl相同目录，或者环境变量路径中。  
> 下般默认是放公共的Bpl目录中，例如：C:\Users\Public\Documents\Embarcadero\Studio\14.0\Bpl\  
  
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
* 2、 CppConvert
   * 原Duilib头文件转换工具代码  
>
* 3、Demo
   * Demo工程目录  
>  
* 4、Duilib
   * 存放原[duilib](https://github.com/duilib/duilib)工程目录。  
   * 4.1、 bin
      * 存放编译后的二进制及图片和xml资源，里面有的包含原duilib的资源文件      
   * 4.2、 Duilib
      * 存放duilib c++工程源码
>	  
* 5、ThirdParty
   * 存放一些第三方的库或者二进制文件  

>	  
* 6、Screenshot
   * 例程截图相关


#### **截图**

[QQDemo截图1](https://raw.githubusercontent.com/ying32/duilib-for-Delphi/master/Screenshot/screenshot1.png)   
[QQDemo截图2](https://raw.githubusercontent.com/ying32/duilib-for-Delphi/master/Screenshot/screenshot2.png)   
[应用程序管理截图](https://raw.githubusercontent.com/ying32/duilib-for-Delphi/master/Screenshot/screenshot3.png)  
[PC管家截图](https://raw.githubusercontent.com/ying32/duilib-for-Delphi/master/Screenshot/screenshot4.png)    
[QQ旋风](https://raw.githubusercontent.com/ying32/duilib-for-Delphi/master/Screenshot/screenshot5_qqxf.png)   
[QQ登录界面](https://raw.githubusercontent.com/ying32/duilib-for-Delphi/master/Screenshot/screenshot6.png)  
[播放器1,只展示不开源](https://raw.githubusercontent.com/ying32/duilib-for-Delphi/master/Screenshot/screenshot7.png)   
[播放器2,只展示不开源](https://raw.githubusercontent.com/ying32/duilib-for-Delphi/master/Screenshot/screenshot8.png)   

#### **作者信息** 

[ying32](mailto:1444386932@qq.com) 

