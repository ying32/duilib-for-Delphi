当前duilib版本为 2015/12/10 22:33:50由wangchyz提交


原Duilib几个需要修改的地方
UIMarkup.h 行72
private: // 替换为public
    CMarkupNode();
    CMarkupNode(CMarkup* pOwner, int iPos);

注释掉1321行，if( IsCaptured() ) break;， 不知道作者新添加这句是为什么，这样就造成上下文菜单无法弹出了，他右键按下，已经设置了SetCapture，这样是不是逻辑就错了