编译duilib步骤：
1、复制整个DuilibExport目录及目录下的文件到  duilib工程下，将DirectUIlib.cpp和DirectUIlib.h加入原duilib工程中。
2、修改原Duilib：
   UIMarkup.h 行72 
   private: // 替换为public
    CMarkupNode();
    CMarkupNode(CMarkup* pOwner, int iPos);
3、修改UIControl.cpp和UIControl.h
UIControl.h
添加 struct TDelphiMethod {
       LPVOID Code;
       LPVOID Data;
     }

  在CEventSource OnPostPaint;语句下添加
private:
	TDelphiMethod m_DoEventCallback;
	TDelphiMethod m_DoPaintCallback;
构造下面添加初始化代码
 
	m_DoEventCallback = { NULL, NULL };
	m_DoPaintCallback = { NULL, NULL };

UIControl.cpp
  在void CControlUI::Event(TEventUI& event)下添加

  if (m_DoEventCallback.Code != NULL && m_DoEventCallback.Data != NULL)
	((void(*)(LPVOID, CControlUI*, TEventUI&))m_DoEventCallback.Code)(m_DoEventCallback.Data, this, event);

  在void CControlUI::Paint(HDC hDC, const RECT& rcPaint)后面添加
	if (m_DoPaintCallback.Data != NULL && m_DoPaintCallback.Code != NULL)
		((void(*)(LPVOID, CControlUI*, HDC, const RECT&))m_DoPaintCallback.Code)(m_DoPaintCallback.Data, this, hDC, rcPaint);

4、在UIlib.h中加入#include "DuilibExport/UIMenu.h"
	
5、根据需求选择是Unicode还是多字节集工程。


--------------------duilib更新信息,以此来表示当前Duilib for Delphi是使用的哪个版本----------------------
版本: 04377abca3858e65def0d094d3476879cfef2123
作者: wangchyz <wangchyz@gmail.com>
日期: 2016/2/19 10:07:45
信息:
Merge pull request #65 from wgy0323/master

Update UIGifAnim.cpp 修改控件支持显示普通图片
----
已修改: DuiLib/Control/UIGifAnim.cpp







