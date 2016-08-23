//*******************************************************************
//
//       作者：ying32
//       QQ  ：1444386932
//       E-mail：1444386932@qq.com
//       本单元由CppConvert工具自动生成于2015-11-28 16:29:02
//       版权所有 (C) 2015-2015 ying32 All Rights Reserved
//
//*******************************************************************
#ifndef _DIRECTUILIB_H
#define _DIRECTUILIB_H

#include "../UIlib.h"

#define DIRECTUILIB_API extern "C" __declspec(dllexport)

namespace DuiLib
{


	class CNativeControlUI : public CControlUI
	{
	private:
		void UpdateWindowParent(HWND hWd);
	public:
		CNativeControlUI(HWND hWnd = NULL);
		void SetInternVisible(bool bVisible = true);
		void SetVisible(bool bVisible = true);
		void SetPos(RECT rc, bool bNeedInvalidate);
		LPCTSTR GetClass() const;
		CDuiString GetText() const;
		void SetText(LPCTSTR pstrText);
		void SetNativeHandle(HWND hWd);
	protected:
		HWND m_hWnd;
	};

}

#endif

