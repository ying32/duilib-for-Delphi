编译duilib步骤：
1、复制整个DuilibExport目录及目录下的文件到  duilib工程下，将DirectUIlib.cpp和DirectUIlib.h加入原duilib工程中。
2、修改原Duilib：
   UIMarkup.h 行72 
   private: // 替换为public
    CMarkupNode();
    CMarkupNode(CMarkup* pOwner, int iPos);
	
3、在StdAfx.h文件中的#include "UIlib.h"上面增加一句#define UILIB_STATIC,这样就不会导出c++的类了。
4、根据需求选择是Unicode还是多字节集工程。


--------------------duilib更新信息,以此来表示当前Duilib for Delphi是使用的哪个版本----------------------

版本: 816d729e25eebb3bf4c20418eaf02c26ee202b1b
作者: wangchyz <wangchyz@gmail.com>
日期: 2015/12/13 11:31:41
信息:
1、修正horizontallayout的计算错误

2、修正paintmanager的一处手误
----
已修改: DuiLib/Core/UIManager.cpp
已修改: DuiLib/Layout/UIHorizontalLayout.cpp
