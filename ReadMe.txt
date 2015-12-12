当前duilib版本为 2015/12/12 18:27:20由wangchyz提交


原Duilib几个需要修改的地方
UIMarkup.h 行72
private: // 替换为public
    CMarkupNode();
    CMarkupNode(CMarkup* pOwner, int iPos);

在StdAfx.h文件中的#include "UIlib.h"上面增加一句#define UILIB_STATIC,这样就不会导出c++的类了
