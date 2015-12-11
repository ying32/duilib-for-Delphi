当前duilib版本为 2015/12/10 22:33:50由wangchyz提交


原Duilib几个需要修改的地方
UIMarkup.h 行72
private: // 替换为public
    CMarkupNode();
    CMarkupNode(CMarkup* pOwner, int iPos);