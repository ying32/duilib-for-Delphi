编译duilib步骤：
1、复制整个DuilibExport目录及目录下的文件到  duilib工程下，将DirectUIlib.cpp和DirectUIlib.h加入原duilib工程中。
2、修改原Duilib：
   UIMarkup.h 行72 
   private: // 替换为public
    CMarkupNode();
    CMarkupNode(CMarkup* pOwner, int iPos);
	
3、根据需求选择是Unicode还是多字节集工程。


--------------------duilib更新信息,以此来表示当前Duilib for Delphi是使用的哪个版本----------------------

版本: 3407f2391225c4798f473c4fb2ac89d4453ecd18
作者: wangchyz <wangchyz@gmail.com>
日期: 2015/12/21 15:43:35
信息:
修正qqdemo的资源
----
已修改: QQDemo/res/QQRes.zip





