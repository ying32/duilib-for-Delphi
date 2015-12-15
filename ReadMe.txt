编译duilib步骤：
1、复制整个DuilibExport目录及目录下的文件到  duilib工程下，将DirectUIlib.cpp和DirectUIlib.h加入原duilib工程中。
2、修改原Duilib：
   UIMarkup.h 行72 
   private: // 替换为public
    CMarkupNode();
    CMarkupNode(CMarkup* pOwner, int iPos);
	
3、根据需求选择是Unicode还是多字节集工程。


--------------------duilib更新信息,以此来表示当前Duilib for Delphi是使用的哪个版本----------------------

版本: d24db5144fa1ed308b30d1b20bb0843baf0597e7
作者: wangchyz <wangchyz@gmail.com>
日期: 2015/12/15 9:44:34
信息:
1、修正datetime窗口超出父窗口客户区范围的问题

2、增加ActiveX控件内部调用CoInitialize初始化com环境
3、TestApp窗口添加WS_CLIPCHILDREN属性
----
已修改: DuiLib/Control/UIActiveX.cpp
已修改: DuiLib/Control/UIDateTime.cpp
已修改: TestApp1/App.cpp



