当前duilib版本为 2015/10/20 13:37:41由 wangchyz提交


原Duilib几个需要修改的地方
UIMarkup.h 行72
private: // 替换为public
    CMarkupNode();
    CMarkupNode(CMarkup* pOwner, int iPos);