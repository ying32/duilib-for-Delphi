//*******************************************************************
//
//       作者：ying32
//       QQ  ：1444386932
//       E-mail：1444386932@qq.com
//       本单元由CppConvert工具自动生成于2015-11-28 16:34:01
//       版权所有 (C) 2015-2015 ying32 All Rights Reserved
//
//       注：不要使用文件直接替换了，现后期已经改为手动维护了
//*******************************************************************

#include "stdafx.h"
#include "DirectUIlib.h"

using namespace DuiLib;

#pragma warning(disable:4190)


class CNativeControlUI : public CControlUI
{
private:
	void UpdateWindowParent(HWND hWd) {
		if (hWd != NULL && ::IsWindow(hWd)) {
			HWND hParent = this->GetManager()->GetPaintWindow();
			if (::GetParent(hWd) != hParent){}
				::SetParent(hWd, hParent);
		}
	}
public:
	CNativeControlUI(HWND hWnd) :
		m_hWnd(hWnd){
		UpdateWindowParent(hWnd);
	}
	void SetInternVisible(bool bVisible = true) {
		CControlUI::SetInternVisible(bVisible);
		if (m_hWnd)
			::ShowWindow(m_hWnd, bVisible ? SW_SHOWNOACTIVATE : SW_HIDE);
	}
	void SetVisible(bool bVisible = true) {
		CControlUI::SetVisible(bVisible);
		if (m_hWnd)
			::ShowWindow(m_hWnd, bVisible ? SW_SHOWNOACTIVATE : SW_HIDE);
	}
	void SetPos(RECT rc, bool bNeedInvalidate) {
		CControlUI::SetPos(rc, bNeedInvalidate);
		if (m_hWnd)
			::SetWindowPos(m_hWnd, HWND_TOP, rc.left, rc.top, rc.right - rc.left, rc.bottom - rc.top, SWP_NOZORDER | SWP_NOACTIVATE);
	}
	LPCTSTR GetClass() const {
		return _T("NativeControlUI");
	}
	CDuiString GetText() const {
		if (m_hWnd) {
			CHAR text[MAX_PATH] = { 0 };
#ifdef UNICODE
			::GetWindowText(m_hWnd, (LPWSTR)text, MAX_PATH);
#else
			::GetWindowText(m_hWnd, (LPSTR)text, MAX_PATH);
#endif
			return (LPCTSTR)text;
		}
		return _T("");
	}
	void SetText(LPCTSTR pstrText){
		if (m_hWnd)
			::SetWindowText(m_hWnd, pstrText);
	}
	void SetNativeHandle(HWND hWd) {
		UpdateWindowParent(hWd);
		m_hWnd = hWd;
	};
protected:
	HWND m_hWnd;
};


typedef LRESULT(*HandleMessageCallBack)(LPVOID, UINT, WPARAM, LPARAM, BOOL&);
typedef void(*NotifyCallBack)(LPVOID, TNotifyUI&);
typedef void(*FinalMessageCallBack)(LPVOID, HWND);
typedef LRESULT(*MessageCallBack)(LPVOID, UINT uMsg, WPARAM wParam, LPARAM lParam, BOOL& bHandled);
typedef void(*InitWindowCallBack)(LPVOID);
typedef CControlUI*(*CreateControlCallBack)(LPVOID, LPCTSTR);
typedef LPCTSTR(*GetItemTextCallBack)(LPVOID, CControlUI*, int, int);
typedef LRESULT(*ResponseDefaultKeyEventCallBack)(LPVOID, WPARAM);

 
class CDelphi_WindowImplBase : // 好吧，你赢了,我认输
	                           public IListCallbackUI, //这个貌似只能放第一个，他取的时候就是取第一个的，要不就另行建立一个类
							   public WindowImplBase
{
protected:
	LPVOID m_Self;
	LPCTSTR m_ClassName;
	LPCTSTR m_SkinFile;
	LPCTSTR m_SkinFolder;
	LPCTSTR m_ZipFileName;
	UINT m_GetClassStyle;
	UILIB_RESOURCETYPE m_RType;
	InitWindowCallBack m_InitWindow;
	FinalMessageCallBack m_FinalMessage;
	HandleMessageCallBack m_HandleMessage;
	NotifyCallBack m_Notify;
	NotifyCallBack m_Click;
	MessageCallBack m_MessageHandler;
	MessageCallBack m_HandleCustomMessage;
	CreateControlCallBack m_CreateControl;
	GetItemTextCallBack m_GetItemText;
	ResponseDefaultKeyEventCallBack m_ResponseDefaultKeyEvent;
public:
	CDelphi_WindowImplBase() :
		WindowImplBase(),
		m_Self(NULL),
		m_ClassName(NULL),
		m_SkinFile(NULL),
		m_SkinFolder(NULL),
		m_ZipFileName(NULL),
		m_RType(UILIB_FILE),
		m_InitWindow(NULL),
		m_FinalMessage(NULL),
		m_HandleMessage(NULL),
		m_Notify(NULL),
		m_Click(NULL),
		m_MessageHandler(NULL),
		m_HandleCustomMessage(NULL),
		m_GetItemText(NULL),
		m_ResponseDefaultKeyEvent(NULL){
		m_GetClassStyle = WindowImplBase::GetClassStyle();
	}
	~CDelphi_WindowImplBase(){ };
	void InitWindow()
	{
		if (m_InitWindow)
			m_InitWindow(m_Self);
	}
	void OnFinalMessage(HWND hWnd)
	{
		//WindowImplBase::OnFinalMessage(hWnd); // 另作处理，不然有些窗口不想关的结果资源被释放了
		if (m_FinalMessage)
			m_FinalMessage(m_Self, hWnd);
	}
	void Notify(TNotifyUI& msg)
	{
		if (m_Notify)
			m_Notify(m_Self, msg);	
		return WindowImplBase::Notify(msg);
	}
	void OnClick(TNotifyUI& msg)
	{
		if (m_Click)
			m_Click(m_Self, msg);
		return WindowImplBase::OnClick(msg);
	}
	LRESULT ResponseDefaultKeyEvent(WPARAM wParam) {
		if (m_ResponseDefaultKeyEvent) {
			return m_ResponseDefaultKeyEvent(m_Self, wParam);
		}
		return WindowImplBase::ResponseDefaultKeyEvent(wParam);
	}

	CControlUI* CreateControl(LPCTSTR pstrClass) {
		// 直接创建
		if (_tcsicmp(pstrClass, _T("NativeControl")) == 0)
			return new CNativeControlUI(NULL);

		if (m_CreateControl)
			return	m_CreateControl(m_Self, pstrClass);
		return NULL;
	}
    LPCTSTR GetItemText(CControlUI* pControl, int iIndex, int iSubItem) {
		if (m_GetItemText)
			return m_GetItemText(m_Self, pControl, iIndex, iSubItem);
		return NULL;
	}
public:
	LPCTSTR GetWindowClassName() const { return m_ClassName; }
	CDuiString GetSkinFile() { return m_SkinFile; };
	CDuiString GetSkinFolder() { return m_SkinFolder; };
	CDuiString GetZIPFileName() const {
		if (_tcsicmp(m_ZipFileName, _T("")) == 0)
			return CPaintManagerUI::GetResourceZip();
		return m_ZipFileName; 
	};
	UILIB_RESOURCETYPE GetResourceType() const { return m_RType; };
	UINT GetClassStyle() const { return m_GetClassStyle; };
	LRESULT MessageHandler(UINT uMsg, WPARAM wParam, LPARAM lParam, BOOL& bHandled)
	{
		LRESULT lRes = 0;
		if (m_MessageHandler)
		{
			lRes = m_MessageHandler(m_Self, uMsg, wParam, lParam, bHandled);
			if (lRes) return lRes;
		}
		bool b = (bool)bHandled;
		lRes = WindowImplBase::MessageHandler(uMsg, wParam, lParam, b);
		bHandled = (BOOL)b;
		return lRes;
	}
	LRESULT HandleMessage(UINT uMsg, WPARAM wParam, LPARAM lParam)
	{
		if (m_HandleMessage)
		{
			// 这样是为了规避原来的那个事件问题
			BOOL bHandled = TRUE;
			LRESULT lRes = m_HandleMessage(m_Self, uMsg, wParam, lParam, bHandled);
			if (!bHandled) {
	
				lRes = HandleCustomMessage(uMsg, wParam, lParam, bHandled);
				if (bHandled) return lRes;

				if (m_PaintManager.MessageHandler(uMsg, wParam, lParam, lRes))
					return lRes;
				// 绕过父类的HandleMessage直接调用父类的父类方法
				return CWindowWnd::HandleMessage(uMsg, wParam, lParam);
			}
			if (lRes) return lRes;
		}
		return WindowImplBase::HandleMessage(uMsg, wParam, lParam);
	}
	LRESULT HandleCustomMessage(UINT uMsg, WPARAM wParam, LPARAM lParam, BOOL& bHandled)
	{
		if (m_HandleCustomMessage)
		{
			LRESULT lRes = m_HandleCustomMessage(m_Self, uMsg, wParam, lParam, bHandled);
			if (lRes) return lRes;
		}
		return WindowImplBase::HandleCustomMessage(uMsg, wParam, lParam, bHandled);
	};
public:
	CPaintManagerUI* GetPaintManagerUI() { return &m_PaintManager; };
	void SetDelphiSelf(LPVOID Self) { m_Self = Self; }
	void SetClassName(LPCTSTR ClassName) { m_ClassName = ClassName; }
	void SetSkinFile(LPCTSTR SkinFile) { m_SkinFile = SkinFile; }
	void SetSkinFolder(LPCTSTR SkinFolder) { m_SkinFolder = SkinFolder; }
	void SetZipFileName(LPCTSTR ZipFileName) { m_ZipFileName = ZipFileName; }
	void SetResourceType(UILIB_RESOURCETYPE RType) { m_RType = RType; }
	void SetInitWindow(InitWindowCallBack Callback) { m_InitWindow = Callback; }
	void SetFinalMessage(FinalMessageCallBack Callback) { m_FinalMessage = Callback; }
	void SetHandleMessage(HandleMessageCallBack Callback) { m_HandleMessage = Callback; }
	void SetNotify(NotifyCallBack Callback) { m_Notify = Callback; }
	void SetClick(NotifyCallBack Callback) { m_Click = Callback; }
	void SetMessageHandler(MessageCallBack Callback) { m_MessageHandler = Callback; }
	void SetHandleCustomMessage(MessageCallBack Callback) { m_HandleCustomMessage = Callback; }
	void SetCreateControl(CreateControlCallBack CallBack) { m_CreateControl = CallBack; }
	void SetGetItemText(GetItemTextCallBack ACallBack) {
		m_GetItemText = ACallBack;
	}
	void SetGetClassStyle(UINT uStyle) { m_GetClassStyle = uStyle; };
	void RemoveThisInPaintManager() {
		m_PaintManager.RemovePreMessageFilter(this);
		m_PaintManager.RemoveNotifier(this);
		m_PaintManager.ReapObjects(m_PaintManager.GetRoot());
	}
	void SetResponseDefaultKeyEvent(ResponseDefaultKeyEventCallBack ACallBack) {
		m_ResponseDefaultKeyEvent = ACallBack;
	}
};


typedef void(*DoEventCallBack)(LPVOID, TEventUI&, bool&);
class CDelphi_ListUI : public CListUI {
protected:
	LPVOID m_Self;
	DoEventCallBack m_DoEvent;
public:
	CDelphi_ListUI() :
		m_Self(NULL),
		m_DoEvent(NULL)
	{
	}
	void DoEvent(TEventUI& event) {
		if (m_DoEvent) {
			bool bHandled = true; 
			m_DoEvent(m_Self, event, bHandled);
			if(!bHandled) return;
		}
		CListUI::DoEvent(event);
	}
public:
	void SetDelphiSelf(LPVOID ASelf) { m_Self = ASelf; }
	void SetDoEvent(DoEventCallBack ADoEvent) { m_DoEvent = ADoEvent; }
};




/*
typedef void(*SetInternVisibleCallback)(LPVOID, bool);
typedef void(*SetPosCallback)(LPVOID, RECT, bool);
typedef void(*DoPaintCallback)(LPVOID, HDC, const RECT&, bool&);
class CWkeWebbrowserUI: public CControlUI {
protected:
	LPVOID m_Self;
	DoEventCallBack m_DoEvent;
    SetInternVisibleCallback m_SetInternVisible;
	SetPosCallback m_SetPos;
	DoPaintCallback m_DoPaint;
public:
      CWkeWebbrowserUI():
	    m_Self(NULL),
		m_DoEvent(NULL),
		m_SetInternVisible(NULL),
		m_SetPos(NULL){
	  }

	  void SetInternVisible(bool bVisible = true) {
           CControlUI::SetInternVisible(bVisible);
		   if(m_SetInternVisible) 
			   m_SetInternVisible(m_Self, bVisible);
      }
	  
	  void SetPos(RECT rc, bool bNeedInvalidate) {
           CControlUI::SetPos(rc, bNeedInvalidate);
		   if(m_SetPos)
			   m_SetPos(m_Self, rc, bNeedInvalidate);
      }

	  LPVOID GetInterface(LPCTSTR pstrName) {
		if( _tcscmp(pstrName, _T("WkeWebbrowser")) == 0 ) return static_cast<CWkeWebbrowserUI*>(this);
		return CControlUI::GetInterface(pstrName);
	  }
   
	  LPCTSTR GetClass() const {
	     return _T("WkeWebbrowserUI");
	  }

	  void DoEvent(TEventUI& event) {
		if (m_DoEvent) {
			bool bHandled = true; 
			m_DoEvent(m_Self, event, bHandled);
			if(!bHandled) return;
		}
		CControlUI::DoEvent(event);
	  }

	  void DoPaint(HDC hDC, const RECT& rcPaint) {
		  if(m_DoPaint) {
			  bool bHandled = true;
			  m_DoPaint(m_Self, hDC, rcPaint, bHandled);
			  if(!bHandled) return;
		  }
		  CControlUI::DoPaint(hDC, rcPaint);
	  }
public:
	void SetSetInternVisibleCallback(SetInternVisibleCallback ACallback) { m_SetInternVisible = ACallback; }
	void SetSetPosCallback(SetPosCallback ACallback) { m_SetPos = ACallback; }
	void SetDelphiSelf(LPVOID ASelf) { m_Self = ASelf; }
	void SetDoEventCallback(DoEventCallBack ACallback) { m_DoEvent = ACallback; }
	void SetDoPaintCallback(DoPaintCallback ACallback) { m_DoPaint = ACallback; }
};*/

//================================CStdStringPtrMap============================

DIRECTUILIB_API CStdStringPtrMap* Delphi_StdStringPtrMap_CppCreate() {
    return new CStdStringPtrMap();
}

DIRECTUILIB_API void Delphi_StdStringPtrMap_CppDestroy(CStdStringPtrMap* handle) {
    delete handle;
}

DIRECTUILIB_API void Delphi_StdStringPtrMap_Resize(CStdStringPtrMap* handle ,int nSize) {
    handle->Resize(nSize);
}

DIRECTUILIB_API LPVOID Delphi_StdStringPtrMap_Find(CStdStringPtrMap* handle ,LPCTSTR key, bool optimize) {
    return handle->Find(key, optimize);
}

DIRECTUILIB_API bool Delphi_StdStringPtrMap_Insert(CStdStringPtrMap* handle ,LPCTSTR key, LPVOID pData) {
    return handle->Insert(key, pData);
}

DIRECTUILIB_API LPVOID Delphi_StdStringPtrMap_Set(CStdStringPtrMap* handle ,LPCTSTR key, LPVOID pData) {
    return handle->Set(key, pData);
}

DIRECTUILIB_API bool Delphi_StdStringPtrMap_Remove(CStdStringPtrMap* handle ,LPCTSTR key) {
    return handle->Remove(key);
}

DIRECTUILIB_API void Delphi_StdStringPtrMap_RemoveAll(CStdStringPtrMap* handle) {
    handle->RemoveAll();
}

DIRECTUILIB_API int Delphi_StdStringPtrMap_GetSize(CStdStringPtrMap* handle) {
    return handle->GetSize();
}

DIRECTUILIB_API LPCTSTR Delphi_StdStringPtrMap_GetAt(CStdStringPtrMap* handle ,int iIndex) {
    return handle->GetAt(iIndex);
}

//================================CStdValArray============================

DIRECTUILIB_API CStdValArray* Delphi_StdValArray_CppCreate(int iElementSize, int iPreallocSize) {
    return new CStdValArray(iElementSize, iPreallocSize);
}

DIRECTUILIB_API void Delphi_StdValArray_CppDestroy(CStdValArray* handle) {
    delete handle;
}

DIRECTUILIB_API void Delphi_StdValArray_Empty(CStdValArray* handle) {
    handle->Empty();
}

DIRECTUILIB_API bool Delphi_StdValArray_IsEmpty(CStdValArray* handle) {
    return handle->IsEmpty();
}

DIRECTUILIB_API bool Delphi_StdValArray_Add(CStdValArray* handle ,LPCVOID pData) {
    return handle->Add(pData);
}

DIRECTUILIB_API bool Delphi_StdValArray_Remove(CStdValArray* handle ,int iIndex) {
    return handle->Remove(iIndex);
}

DIRECTUILIB_API int Delphi_StdValArray_GetSize(CStdValArray* handle) {
    return handle->GetSize();
}

DIRECTUILIB_API LPVOID Delphi_StdValArray_GetData(CStdValArray* handle) {
    return handle->GetData();
}

DIRECTUILIB_API LPVOID Delphi_StdValArray_GetAt(CStdValArray* handle ,int iIndex) {
    return handle->GetAt(iIndex);
}

//================================CStdPtrArray============================

DIRECTUILIB_API CStdPtrArray* Delphi_StdPtrArray_CppCreate() {
    return new CStdPtrArray();
}

DIRECTUILIB_API void Delphi_StdPtrArray_CppDestroy(CStdPtrArray* handle) {
    delete handle;
}

DIRECTUILIB_API void Delphi_StdPtrArray_Empty(CStdPtrArray* handle) {
    handle->Empty();
}

DIRECTUILIB_API void Delphi_StdPtrArray_Resize(CStdPtrArray* handle ,int iSize) {
    handle->Resize(iSize);
}

DIRECTUILIB_API bool Delphi_StdPtrArray_IsEmpty(CStdPtrArray* handle) {
    return handle->IsEmpty();
}

DIRECTUILIB_API int Delphi_StdPtrArray_Find(CStdPtrArray* handle ,LPVOID iIndex) {
    return handle->Find(iIndex);
}

DIRECTUILIB_API bool Delphi_StdPtrArray_Add(CStdPtrArray* handle ,LPVOID pData) {
    return handle->Add(pData);
}

DIRECTUILIB_API bool Delphi_StdPtrArray_SetAt(CStdPtrArray* handle ,int iIndex, LPVOID pData) {
    return handle->SetAt(iIndex, pData);
}

DIRECTUILIB_API bool Delphi_StdPtrArray_InsertAt(CStdPtrArray* handle ,int iIndex, LPVOID pData) {
    return handle->InsertAt(iIndex, pData);
}

DIRECTUILIB_API bool Delphi_StdPtrArray_Remove(CStdPtrArray* handle ,int iIndex) {
    return handle->Remove(iIndex);
}

DIRECTUILIB_API int Delphi_StdPtrArray_GetSize(CStdPtrArray* handle) {
    return handle->GetSize();
}

DIRECTUILIB_API LPVOID* Delphi_StdPtrArray_GetData(CStdPtrArray* handle) {
    return handle->GetData();
}

DIRECTUILIB_API LPVOID Delphi_StdPtrArray_GetAt(CStdPtrArray* handle ,int iIndex) {
    return handle->GetAt(iIndex);
}

//================================CNotifyPump============================

DIRECTUILIB_API CNotifyPump* Delphi_NotifyPump_CppCreate() {
    return new CNotifyPump();
}

DIRECTUILIB_API void Delphi_NotifyPump_CppDestroy(CNotifyPump* handle) {
    delete handle;
}

DIRECTUILIB_API bool Delphi_NotifyPump_AddVirtualWnd(CNotifyPump* handle ,CDuiString strName, CNotifyPump* pObject) {
    return handle->AddVirtualWnd(strName, pObject);
}

DIRECTUILIB_API bool Delphi_NotifyPump_RemoveVirtualWnd(CNotifyPump* handle ,CDuiString strName) {
    return handle->RemoveVirtualWnd(strName);
}

DIRECTUILIB_API void Delphi_NotifyPump_NotifyPump(CNotifyPump* handle ,TNotifyUI& msg) {
    handle->NotifyPump(msg);
}

DIRECTUILIB_API bool Delphi_NotifyPump_LoopDispatch(CNotifyPump* handle ,TNotifyUI& msg) {
    return handle->LoopDispatch(msg);
}

//================================CDialogBuilder============================

DIRECTUILIB_API CDialogBuilder* Delphi_DialogBuilder_CppCreate() {
    return new CDialogBuilder();
}

DIRECTUILIB_API void Delphi_DialogBuilder_CppDestroy(CDialogBuilder* handle) {
    delete handle;
}

DIRECTUILIB_API CControlUI* Delphi_DialogBuilder_Create_01(CDialogBuilder* handle ,STRINGorID xml, LPCTSTR type, IDialogBuilderCallback* pCallback, CPaintManagerUI* pManager, CControlUI* pParent) {
    return handle->Create(xml, type, pCallback, pManager, pParent);
}

DIRECTUILIB_API CControlUI* Delphi_DialogBuilder_Create_02(CDialogBuilder* handle ,IDialogBuilderCallback* pCallback, CPaintManagerUI* pManager, CControlUI* pParent) {
    return handle->Create(pCallback, pManager, pParent);
}

DIRECTUILIB_API CMarkup* Delphi_DialogBuilder_GetMarkup(CDialogBuilder* handle) {
    return handle->GetMarkup();
}

DIRECTUILIB_API void Delphi_DialogBuilder_GetLastErrorMessage(CDialogBuilder* handle ,LPTSTR pstrMessage, SIZE_T cchMax) {
    handle->GetLastErrorMessage(pstrMessage, cchMax);
}

DIRECTUILIB_API void Delphi_DialogBuilder_GetLastErrorLocation(CDialogBuilder* handle ,LPTSTR pstrSource, SIZE_T cchMax) {
    handle->GetLastErrorLocation(pstrSource, cchMax);
}

//================================CMarkup============================

DIRECTUILIB_API CMarkup* Delphi_Markup_CppCreate(LPCTSTR pstrXML) {
    return new CMarkup(pstrXML);
}

DIRECTUILIB_API void Delphi_Markup_CppDestroy(CMarkup* handle) {
    delete handle;
}

DIRECTUILIB_API bool Delphi_Markup_Load(CMarkup* handle ,LPCTSTR pstrXML) {
    return handle->Load(pstrXML);
}

DIRECTUILIB_API bool Delphi_Markup_LoadFromMem(CMarkup* handle ,BYTE* pByte, DWORD dwSize, int encoding) {
    return handle->LoadFromMem(pByte, dwSize, encoding);
}

DIRECTUILIB_API bool Delphi_Markup_LoadFromFile(CMarkup* handle ,LPCTSTR pstrFilename, int encoding) {
    return handle->LoadFromFile(pstrFilename, encoding);
}

DIRECTUILIB_API void Delphi_Markup_Release(CMarkup* handle) {
    handle->Release();
}

DIRECTUILIB_API bool Delphi_Markup_IsValid(CMarkup* handle) {
    return handle->IsValid();
}

DIRECTUILIB_API void Delphi_Markup_SetPreserveWhitespace(CMarkup* handle ,bool bPreserve) {
    handle->SetPreserveWhitespace(bPreserve);
}

DIRECTUILIB_API void Delphi_Markup_GetLastErrorMessage(CMarkup* handle ,LPTSTR pstrMessage, SIZE_T cchMax) {
    handle->GetLastErrorMessage(pstrMessage, cchMax);
}

DIRECTUILIB_API void Delphi_Markup_GetLastErrorLocation(CMarkup* handle ,LPTSTR pstrSource, SIZE_T cchMax) {
    handle->GetLastErrorLocation(pstrSource, cchMax);
}

DIRECTUILIB_API CMarkupNode Delphi_Markup_GetRoot(CMarkup* handle) {
    return handle->GetRoot();
}

//================================CMarkupNode============================

DIRECTUILIB_API CMarkupNode* Delphi_MarkupNode_CppCreate() {
    return new CMarkupNode();
}

DIRECTUILIB_API void Delphi_MarkupNode_CppDestroy(CMarkupNode* handle) {
    delete handle;
}

DIRECTUILIB_API bool Delphi_MarkupNode_IsValid(CMarkupNode* handle) {
    return handle->IsValid();
}

DIRECTUILIB_API CMarkupNode Delphi_MarkupNode_GetParent(CMarkupNode* handle) {
    return handle->GetParent();
}

DIRECTUILIB_API CMarkupNode Delphi_MarkupNode_GetSibling(CMarkupNode* handle) {
    return handle->GetSibling();
}

DIRECTUILIB_API CMarkupNode Delphi_MarkupNode_GetChild_01(CMarkupNode* handle) {
    return handle->GetChild();
}

DIRECTUILIB_API CMarkupNode Delphi_MarkupNode_GetChild_02(CMarkupNode* handle ,LPCTSTR pstrName) {
    return handle->GetChild(pstrName);
}

DIRECTUILIB_API bool Delphi_MarkupNode_HasSiblings(CMarkupNode* handle) {
    return handle->HasSiblings();
}

DIRECTUILIB_API bool Delphi_MarkupNode_HasChildren(CMarkupNode* handle) {
    return handle->HasChildren();
}

DIRECTUILIB_API LPCTSTR Delphi_MarkupNode_GetName(CMarkupNode* handle) {
    return handle->GetName();
}

DIRECTUILIB_API LPCTSTR Delphi_MarkupNode_GetValue(CMarkupNode* handle) {
    return handle->GetValue();
}

DIRECTUILIB_API bool Delphi_MarkupNode_HasAttributes(CMarkupNode* handle) {
    return handle->HasAttributes();
}

DIRECTUILIB_API bool Delphi_MarkupNode_HasAttribute(CMarkupNode* handle ,LPCTSTR pstrName) {
    return handle->HasAttribute(pstrName);
}

DIRECTUILIB_API int Delphi_MarkupNode_GetAttributeCount(CMarkupNode* handle) {
    return handle->GetAttributeCount();
}

DIRECTUILIB_API LPCTSTR Delphi_MarkupNode_GetAttributeName(CMarkupNode* handle ,int iIndex) {
    return handle->GetAttributeName(iIndex);
}

DIRECTUILIB_API LPCTSTR Delphi_MarkupNode_GetAttributeValue_01(CMarkupNode* handle ,int iIndex) {
    return handle->GetAttributeValue(iIndex);
}

DIRECTUILIB_API LPCTSTR Delphi_MarkupNode_GetAttributeValue_02(CMarkupNode* handle ,LPCTSTR pstrName) {
    return handle->GetAttributeValue(pstrName);
}

DIRECTUILIB_API bool Delphi_MarkupNode_GetAttributeValue_03(CMarkupNode* handle ,int iIndex, LPTSTR pstrValue, SIZE_T cchMax) {
    return handle->GetAttributeValue(iIndex, pstrValue, cchMax);
}

DIRECTUILIB_API bool Delphi_MarkupNode_GetAttributeValue_04(CMarkupNode* handle ,LPCTSTR pstrName, LPTSTR pstrValue, SIZE_T cchMax) {
    return handle->GetAttributeValue(pstrName, pstrValue, cchMax);
}

//================================CControlUI============================

DIRECTUILIB_API CControlUI* Delphi_ControlUI_CppCreate() {
    return new CControlUI();
}

DIRECTUILIB_API void Delphi_ControlUI_CppDestroy(CControlUI* handle) {
    delete handle;
}

DIRECTUILIB_API CDuiString Delphi_ControlUI_GetName(CControlUI* handle) {
    return handle->GetName();
}

DIRECTUILIB_API void Delphi_ControlUI_SetName(CControlUI* handle ,LPCTSTR pstrName) {
    handle->SetName(pstrName);
}

DIRECTUILIB_API LPCTSTR Delphi_ControlUI_GetClass(CControlUI* handle) {
    return handle->GetClass();
}

DIRECTUILIB_API LPVOID Delphi_ControlUI_GetInterface(CControlUI* handle ,LPCTSTR pstrName) {
    return handle->GetInterface(pstrName);
}

DIRECTUILIB_API UINT Delphi_ControlUI_GetControlFlags(CControlUI* handle) {
    return handle->GetControlFlags();
}

DIRECTUILIB_API HWND Delphi_ControlUI_GetNativeWindow(CControlUI* handle) {
	return handle->GetNativeWindow();
}

DIRECTUILIB_API bool Delphi_ControlUI_Activate(CControlUI* handle) {
    return handle->Activate();
}

DIRECTUILIB_API CPaintManagerUI* Delphi_ControlUI_GetManager(CControlUI* handle) {
    return handle->GetManager();
}

DIRECTUILIB_API void Delphi_ControlUI_SetManager(CControlUI* handle ,CPaintManagerUI* pManager, CControlUI* pParent, bool bInit) {
    handle->SetManager(pManager, pParent, bInit);
}

DIRECTUILIB_API CControlUI* Delphi_ControlUI_GetParent(CControlUI* handle) {
    return handle->GetParent();
}

DIRECTUILIB_API CDuiString Delphi_ControlUI_GetText(CControlUI* handle) {
    return handle->GetText();
}

DIRECTUILIB_API void Delphi_ControlUI_SetText(CControlUI* handle ,LPCTSTR pstrText) {
    handle->SetText(pstrText);
}

DIRECTUILIB_API DWORD Delphi_ControlUI_GetBkColor(CControlUI* handle) {
    return handle->GetBkColor();
}

DIRECTUILIB_API void Delphi_ControlUI_SetBkColor(CControlUI* handle ,DWORD dwBackColor) {
    handle->SetBkColor(dwBackColor);
}

DIRECTUILIB_API DWORD Delphi_ControlUI_GetBkColor2(CControlUI* handle) {
    return handle->GetBkColor2();
}

DIRECTUILIB_API void Delphi_ControlUI_SetBkColor2(CControlUI* handle ,DWORD dwBackColor) {
    handle->SetBkColor2(dwBackColor);
}

DIRECTUILIB_API DWORD Delphi_ControlUI_GetBkColor3(CControlUI* handle) {
    return handle->GetBkColor3();
}

DIRECTUILIB_API void Delphi_ControlUI_SetBkColor3(CControlUI* handle ,DWORD dwBackColor) {
    handle->SetBkColor3(dwBackColor);
}

DIRECTUILIB_API LPCTSTR Delphi_ControlUI_GetBkImage(CControlUI* handle) {
    return handle->GetBkImage();
}

DIRECTUILIB_API void Delphi_ControlUI_SetBkImage(CControlUI* handle ,LPCTSTR pStrImage) {
    handle->SetBkImage(pStrImage);
}

DIRECTUILIB_API DWORD Delphi_ControlUI_GetFocusBorderColor(CControlUI* handle) {
    return handle->GetFocusBorderColor();
}

DIRECTUILIB_API void Delphi_ControlUI_SetFocusBorderColor(CControlUI* handle ,DWORD dwBorderColor) {
    handle->SetFocusBorderColor(dwBorderColor);
}

DIRECTUILIB_API bool Delphi_ControlUI_IsColorHSL(CControlUI* handle) {
    return handle->IsColorHSL();
}

DIRECTUILIB_API void Delphi_ControlUI_SetColorHSL(CControlUI* handle ,bool bColorHSL) {
    handle->SetColorHSL(bColorHSL);
}

DIRECTUILIB_API void Delphi_ControlUI_GetBorderRound(CControlUI* handle, SIZE& Result) {
    Result = handle->GetBorderRound();
}

DIRECTUILIB_API void Delphi_ControlUI_SetBorderRound(CControlUI* handle ,SIZE cxyRound) {
    handle->SetBorderRound(cxyRound);
}

DIRECTUILIB_API bool Delphi_ControlUI_DrawImage(CControlUI* handle ,HDC hDC, TDrawInfo& drawInfo) {
    return handle->DrawImage(hDC, drawInfo);
}

DIRECTUILIB_API DWORD Delphi_ControlUI_GetBorderColor(CControlUI* handle) {
    return handle->GetBorderColor();
}

DIRECTUILIB_API void Delphi_ControlUI_SetBorderColor(CControlUI* handle ,DWORD dwBorderColor) {
    handle->SetBorderColor(dwBorderColor);
}

DIRECTUILIB_API void Delphi_ControlUI_GetBorderSize(CControlUI* handle, RECT& Result) {
	Result = handle->GetBorderSize();
}

DIRECTUILIB_API void Delphi_ControlUI_SetBorderSize_01(CControlUI* handle, RECT rc) {
	handle->SetBorderSize(rc);
}

DIRECTUILIB_API void Delphi_ControlUI_SetBorderSize_02(CControlUI* handle, int iSize) {
	handle->SetBorderSize(iSize);
}

DIRECTUILIB_API int Delphi_ControlUI_GetBorderStyle(CControlUI* handle) {
    return handle->GetBorderStyle();
}

DIRECTUILIB_API void Delphi_ControlUI_SetBorderStyle(CControlUI* handle ,int nStyle) {
    handle->SetBorderStyle(nStyle);
}

DIRECTUILIB_API const RECT& Delphi_ControlUI_GetPos(CControlUI* handle) {
    return handle->GetPos();
}

DIRECTUILIB_API void Delphi_ControlUI_GetRelativePos(CControlUI* handle, RECT& Result) {
    Result = handle->GetRelativePos();
}

DIRECTUILIB_API void Delphi_ControlUI_GetClientPos(CControlUI* handle, RECT& Result) {
	Result = handle->GetClientPos();
}

DIRECTUILIB_API void Delphi_ControlUI_SetPos(CControlUI* handle ,RECT rc, bool bNeedInvalidate) {
    handle->SetPos(rc, bNeedInvalidate);
}

DIRECTUILIB_API void Delphi_ControlUI_Move(CControlUI* handle ,SIZE szOffset, bool bNeedInvalidate) {
    handle->Move(szOffset, bNeedInvalidate);
}

DIRECTUILIB_API int Delphi_ControlUI_GetWidth(CControlUI* handle) {
    return handle->GetWidth();
}

DIRECTUILIB_API int Delphi_ControlUI_GetHeight(CControlUI* handle) {
    return handle->GetHeight();
}

DIRECTUILIB_API int Delphi_ControlUI_GetX(CControlUI* handle) {
    return handle->GetX();
}

DIRECTUILIB_API int Delphi_ControlUI_GetY(CControlUI* handle) {
    return handle->GetY();
}

DIRECTUILIB_API void Delphi_ControlUI_GetPadding(CControlUI* handle, RECT& Result) {
    Result = handle->GetPadding();
}

DIRECTUILIB_API void Delphi_ControlUI_SetPadding(CControlUI* handle ,RECT rcPadding) {
    handle->SetPadding(rcPadding);
}

DIRECTUILIB_API void Delphi_ControlUI_GetFixedXY(CControlUI* handle, SIZE& Result) {
    Result = handle->GetFixedXY();
}

DIRECTUILIB_API void Delphi_ControlUI_SetFixedXY(CControlUI* handle ,SIZE szXY) {
    handle->SetFixedXY(szXY);
}

DIRECTUILIB_API int Delphi_ControlUI_GetFixedWidth(CControlUI* handle) {
    return handle->GetFixedWidth();
}

DIRECTUILIB_API void Delphi_ControlUI_SetFixedWidth(CControlUI* handle ,int cx) {
    handle->SetFixedWidth(cx);
}

DIRECTUILIB_API int Delphi_ControlUI_GetFixedHeight(CControlUI* handle) {
    return handle->GetFixedHeight();
}

DIRECTUILIB_API void Delphi_ControlUI_SetFixedHeight(CControlUI* handle ,int cy) {
    handle->SetFixedHeight(cy);
}

DIRECTUILIB_API int Delphi_ControlUI_GetMinWidth(CControlUI* handle) {
    return handle->GetMinWidth();
}

DIRECTUILIB_API void Delphi_ControlUI_SetMinWidth(CControlUI* handle ,int cx) {
    handle->SetMinWidth(cx);
}

DIRECTUILIB_API int Delphi_ControlUI_GetMaxWidth(CControlUI* handle) {
    return handle->GetMaxWidth();
}

DIRECTUILIB_API void Delphi_ControlUI_SetMaxWidth(CControlUI* handle ,int cx) {
    handle->SetMaxWidth(cx);
}

DIRECTUILIB_API int Delphi_ControlUI_GetMinHeight(CControlUI* handle) {
    return handle->GetMinHeight();
}

DIRECTUILIB_API void Delphi_ControlUI_SetMinHeight(CControlUI* handle ,int cy) {
    handle->SetMinHeight(cy);
}

DIRECTUILIB_API int Delphi_ControlUI_GetMaxHeight(CControlUI* handle) {
    return handle->GetMaxHeight();
}

DIRECTUILIB_API void Delphi_ControlUI_SetMaxHeight(CControlUI* handle ,int cy) {
    handle->SetMaxHeight(cy);
}

DIRECTUILIB_API TPercentInfo Delphi_ControlUI_GetFloatPercent(CControlUI* handle) {
    return handle->GetFloatPercent();
}

DIRECTUILIB_API void Delphi_ControlUI_SetFloatPercent(CControlUI* handle ,TPercentInfo piFloatPercent) {
    handle->SetFloatPercent(piFloatPercent);
}

DIRECTUILIB_API CDuiString Delphi_ControlUI_GetToolTip(CControlUI* handle) {
    return handle->GetToolTip();
}

DIRECTUILIB_API void Delphi_ControlUI_SetToolTip(CControlUI* handle ,LPCTSTR pstrText) {
    handle->SetToolTip(pstrText);
}

DIRECTUILIB_API void Delphi_ControlUI_SetToolTipWidth(CControlUI* handle ,int nWidth) {
    handle->SetToolTipWidth(nWidth);
}

DIRECTUILIB_API int Delphi_ControlUI_GetToolTipWidth(CControlUI* handle) {
    return handle->GetToolTipWidth();
}

DIRECTUILIB_API TCHAR Delphi_ControlUI_GetShortcut(CControlUI* handle) {
    return handle->GetShortcut();
}

DIRECTUILIB_API void Delphi_ControlUI_SetShortcut(CControlUI* handle ,TCHAR ch) {
    handle->SetShortcut(ch);
}

DIRECTUILIB_API bool Delphi_ControlUI_IsContextMenuUsed(CControlUI* handle) {
    return handle->IsContextMenuUsed();
}

DIRECTUILIB_API void Delphi_ControlUI_SetContextMenuUsed(CControlUI* handle ,bool bMenuUsed) {
    handle->SetContextMenuUsed(bMenuUsed);
}

DIRECTUILIB_API const CDuiString& Delphi_ControlUI_GetUserData(CControlUI* handle) {
    return handle->GetUserData();
}

DIRECTUILIB_API void Delphi_ControlUI_SetUserData(CControlUI* handle ,LPCTSTR pstrText) {
    handle->SetUserData(pstrText);
}

DIRECTUILIB_API UINT_PTR Delphi_ControlUI_GetTag(CControlUI* handle) {
    return handle->GetTag();
}

DIRECTUILIB_API void Delphi_ControlUI_SetTag(CControlUI* handle ,UINT_PTR pTag) {
    handle->SetTag(pTag);
}

DIRECTUILIB_API bool Delphi_ControlUI_IsVisible(CControlUI* handle) {
    return handle->IsVisible();
}

DIRECTUILIB_API void Delphi_ControlUI_SetVisible(CControlUI* handle ,bool bVisible) {
    handle->SetVisible(bVisible);
}

DIRECTUILIB_API void Delphi_ControlUI_SetInternVisible(CControlUI* handle ,bool bVisible) {
    handle->SetInternVisible(bVisible);
}

DIRECTUILIB_API bool Delphi_ControlUI_IsEnabled(CControlUI* handle) {
    return handle->IsEnabled();
}

DIRECTUILIB_API void Delphi_ControlUI_SetEnabled(CControlUI* handle ,bool bEnable) {
    handle->SetEnabled(bEnable);
}

DIRECTUILIB_API bool Delphi_ControlUI_IsMouseEnabled(CControlUI* handle) {
    return handle->IsMouseEnabled();
}

DIRECTUILIB_API void Delphi_ControlUI_SetMouseEnabled(CControlUI* handle ,bool bEnable) {
    handle->SetMouseEnabled(bEnable);
}

DIRECTUILIB_API bool Delphi_ControlUI_IsKeyboardEnabled(CControlUI* handle) {
    return handle->IsKeyboardEnabled();
}

DIRECTUILIB_API void Delphi_ControlUI_SetKeyboardEnabled(CControlUI* handle ,bool bEnable) {
    handle->SetKeyboardEnabled(bEnable);
}

DIRECTUILIB_API bool Delphi_ControlUI_IsFocused(CControlUI* handle) {
    return handle->IsFocused();
}

DIRECTUILIB_API void Delphi_ControlUI_SetFocus(CControlUI* handle) {
    handle->SetFocus();
}

DIRECTUILIB_API bool Delphi_ControlUI_IsFloat(CControlUI* handle) {
    return handle->IsFloat();
}

DIRECTUILIB_API void Delphi_ControlUI_SetFloat(CControlUI* handle ,bool bFloat) {
    handle->SetFloat(bFloat);
}

DIRECTUILIB_API void Delphi_ControlUI_AddCustomAttribute(CControlUI* handle, LPCTSTR pstrName, LPCTSTR pstrAttr) {
	handle->AddCustomAttribute(pstrName, pstrAttr);
}

DIRECTUILIB_API LPCTSTR Delphi_ControlUI_GetCustomAttribute(CControlUI* handle, LPCTSTR pstrName) {
	return handle->GetCustomAttribute(pstrName);
}

DIRECTUILIB_API bool Delphi_ControlUI_RemoveCustomAttribute(CControlUI* handle, LPCTSTR pstrName) {
	return handle->RemoveCustomAttribute(pstrName);
}

DIRECTUILIB_API void Delphi_ControlUI_RemoveAllCustomAttribute(CControlUI* handle) {
	handle->RemoveAllCustomAttribute();
}

DIRECTUILIB_API CControlUI* Delphi_ControlUI_FindControl(CControlUI* handle ,FINDCONTROLPROC Proc, LPVOID pData, UINT uFlags) {
    return handle->FindControl(Proc, pData, uFlags);
}

DIRECTUILIB_API void Delphi_ControlUI_Invalidate(CControlUI* handle) {
    handle->Invalidate();
}

DIRECTUILIB_API bool Delphi_ControlUI_IsUpdateNeeded(CControlUI* handle) {
    return handle->IsUpdateNeeded();
}

DIRECTUILIB_API void Delphi_ControlUI_NeedUpdate(CControlUI* handle) {
    handle->NeedUpdate();
}

DIRECTUILIB_API void Delphi_ControlUI_NeedParentUpdate(CControlUI* handle) {
    handle->NeedParentUpdate();
}

DIRECTUILIB_API DWORD Delphi_ControlUI_GetAdjustColor(CControlUI* handle ,DWORD dwColor) {
    return handle->GetAdjustColor(dwColor);
}

DIRECTUILIB_API void Delphi_ControlUI_Init(CControlUI* handle) {
    handle->Init();
}

DIRECTUILIB_API void Delphi_ControlUI_DoInit(CControlUI* handle) {
    handle->DoInit();
}

DIRECTUILIB_API void Delphi_ControlUI_Event(CControlUI* handle ,TEventUI& event) {
    handle->Event(event);
}

DIRECTUILIB_API void Delphi_ControlUI_DoEvent(CControlUI* handle ,TEventUI& event) {
    handle->DoEvent(event);
}

DIRECTUILIB_API void Delphi_ControlUI_SetAttribute(CControlUI* handle ,LPCTSTR pstrName, LPCTSTR pstrValue) {
    handle->SetAttribute(pstrName, pstrValue);
}

DIRECTUILIB_API CControlUI* Delphi_ControlUI_ApplyAttributeList(CControlUI* handle ,LPCTSTR pstrList) {
    return handle->ApplyAttributeList(pstrList);
}

DIRECTUILIB_API void Delphi_ControlUI_EstimateSize(CControlUI* handle ,SIZE szAvailable, SIZE& Result) {
    Result = handle->EstimateSize(szAvailable);
}

DIRECTUILIB_API void Delphi_ControlUI_DoPaint(CControlUI* handle ,HDC hDC, RECT& rcPaint) {
    handle->DoPaint(hDC, rcPaint);
}

DIRECTUILIB_API void Delphi_ControlUI_PaintBkColor(CControlUI* handle ,HDC hDC) {
    handle->PaintBkColor(hDC);
}

DIRECTUILIB_API void Delphi_ControlUI_PaintBkImage(CControlUI* handle ,HDC hDC) {
    handle->PaintBkImage(hDC);
}

DIRECTUILIB_API void Delphi_ControlUI_PaintStatusImage(CControlUI* handle ,HDC hDC) {
    handle->PaintStatusImage(hDC);
}

DIRECTUILIB_API void Delphi_ControlUI_PaintText(CControlUI* handle ,HDC hDC) {
    handle->PaintText(hDC);
}

DIRECTUILIB_API void Delphi_ControlUI_PaintBorder(CControlUI* handle ,HDC hDC) {
    handle->PaintBorder(hDC);
}

DIRECTUILIB_API void Delphi_ControlUI_DoPostPaint(CControlUI* handle ,HDC hDC, RECT& rcPaint) {
    handle->DoPostPaint(hDC, rcPaint);
}

DIRECTUILIB_API void Delphi_ControlUI_SetVirtualWnd(CControlUI* handle ,LPCTSTR pstrValue) {
    handle->SetVirtualWnd(pstrValue);
}

DIRECTUILIB_API CDuiString Delphi_ControlUI_GetVirtualWnd(CControlUI* handle) {
    return handle->GetVirtualWnd();
}

//================================CDelphi_WindowImplBase============================

DIRECTUILIB_API CDelphi_WindowImplBase* Delphi_Delphi_WindowImplBase_CppCreate() {
	return new CDelphi_WindowImplBase();
}

DIRECTUILIB_API void Delphi_Delphi_WindowImplBase_CppDestroy(CDelphi_WindowImplBase* handle) {
	delete handle;
}

DIRECTUILIB_API HWND Delphi_Delphi_WindowImplBase_GetHWND(CDelphi_WindowImplBase* handle) {
	return handle->GetHWND();
}

DIRECTUILIB_API bool Delphi_Delphi_WindowImplBase_RegisterWindowClass(CDelphi_WindowImplBase* handle) {
	return handle->RegisterWindowClass();
}

DIRECTUILIB_API bool Delphi_Delphi_WindowImplBase_RegisterSuperclass(CDelphi_WindowImplBase* handle) {
	return handle->RegisterSuperclass();
}

DIRECTUILIB_API HWND Delphi_Delphi_WindowImplBase_Create_01(CDelphi_WindowImplBase* handle, HWND hwndParent, LPCTSTR pstrName, DWORD dwStyle, DWORD dwExStyle, RECT rc, HMENU hMenu) {
	return handle->Create(hwndParent, pstrName, dwStyle, dwExStyle, rc, hMenu);
}

DIRECTUILIB_API HWND Delphi_Delphi_WindowImplBase_Create_02(CDelphi_WindowImplBase* handle, HWND hwndParent, LPCTSTR pstrName, DWORD dwStyle, DWORD dwExStyle, int x, int y, int cx, int cy, HMENU hMenu) {
	return handle->Create(hwndParent, pstrName, dwStyle, dwExStyle, x, y, cx, cy, hMenu);
}

DIRECTUILIB_API HWND Delphi_Delphi_WindowImplBase_CreateDuiWindow(CDelphi_WindowImplBase* handle, HWND hwndParent, LPCTSTR pstrWindowName, DWORD dwStyle, DWORD dwExStyle) {
	return handle->CreateDuiWindow(hwndParent, pstrWindowName, dwStyle, dwExStyle);
}

DIRECTUILIB_API HWND Delphi_Delphi_WindowImplBase_Subclass(CDelphi_WindowImplBase* handle, HWND hWnd) {
	return handle->Subclass(hWnd);
}

DIRECTUILIB_API void Delphi_Delphi_WindowImplBase_Unsubclass(CDelphi_WindowImplBase* handle) {
	handle->Unsubclass();
}

DIRECTUILIB_API void Delphi_Delphi_WindowImplBase_ShowWindow(CDelphi_WindowImplBase* handle, bool bShow, bool bTakeFocus) {
	handle->ShowWindow(bShow, bTakeFocus);
}

DIRECTUILIB_API UINT Delphi_Delphi_WindowImplBase_ShowModal(CDelphi_WindowImplBase* handle) {
	return handle->ShowModal();
}

DIRECTUILIB_API void Delphi_Delphi_WindowImplBase_Close(CDelphi_WindowImplBase* handle, UINT nRet) {
	handle->Close(nRet);
}

DIRECTUILIB_API void Delphi_Delphi_WindowImplBase_CenterWindow(CDelphi_WindowImplBase* handle) {
	handle->CenterWindow();
}

DIRECTUILIB_API void Delphi_Delphi_WindowImplBase_SetIcon(CDelphi_WindowImplBase* handle, UINT nRes) {
	handle->SetIcon(nRes);
}

DIRECTUILIB_API LRESULT Delphi_Delphi_WindowImplBase_SendMessage(CDelphi_WindowImplBase* handle, UINT uMsg, WPARAM wParam, LPARAM lParam) {
	return handle->SendMessage(uMsg, wParam, lParam);
}

DIRECTUILIB_API LRESULT Delphi_Delphi_WindowImplBase_PostMessage(CDelphi_WindowImplBase* handle, UINT uMsg, WPARAM wParam, LPARAM lParam) {
	return handle->PostMessage(uMsg, wParam, lParam);
}

DIRECTUILIB_API void Delphi_Delphi_WindowImplBase_ResizeClient(CDelphi_WindowImplBase* handle, int cx, int cy) {
	handle->ResizeClient(cx, cy);
}

DIRECTUILIB_API bool Delphi_Delphi_WindowImplBase_AddVirtualWnd(CDelphi_WindowImplBase* handle, CDuiString strName, CNotifyPump* pObject) {
	return handle->AddVirtualWnd(strName, pObject);
}

DIRECTUILIB_API bool Delphi_Delphi_WindowImplBase_RemoveVirtualWnd(CDelphi_WindowImplBase* handle, CDuiString strName) {
	return handle->RemoveVirtualWnd(strName);
}

DIRECTUILIB_API void Delphi_Delphi_WindowImplBase_NotifyPump(CDelphi_WindowImplBase* handle, TNotifyUI& msg) {
	handle->NotifyPump(msg);
}

DIRECTUILIB_API bool Delphi_Delphi_WindowImplBase_LoopDispatch(CDelphi_WindowImplBase* handle, TNotifyUI& msg) {
	return handle->LoopDispatch(msg);
}

DIRECTUILIB_API CPaintManagerUI* Delphi_Delphi_WindowImplBase_GetPaintManagerUI(CDelphi_WindowImplBase* handle) {
	return handle->GetPaintManagerUI();
}

DIRECTUILIB_API void Delphi_Delphi_WindowImplBase_SetDelphiSelf(CDelphi_WindowImplBase* handle, LPVOID Self) {
	handle->SetDelphiSelf(Self);
}

DIRECTUILIB_API void Delphi_Delphi_WindowImplBase_SetClassName(CDelphi_WindowImplBase* handle, LPCTSTR ClassName) {
	handle->SetClassName(ClassName);
}

DIRECTUILIB_API void Delphi_Delphi_WindowImplBase_SetSkinFile(CDelphi_WindowImplBase* handle, LPCTSTR SkinFile) {
	handle->SetSkinFile(SkinFile);
}

DIRECTUILIB_API void Delphi_Delphi_WindowImplBase_SetSkinFolder(CDelphi_WindowImplBase* handle, LPCTSTR SkinFolder) {
	handle->SetSkinFolder(SkinFolder);
}

DIRECTUILIB_API void Delphi_Delphi_WindowImplBase_SetZipFileName(CDelphi_WindowImplBase* handle, LPCTSTR ZipFileName) {
	handle->SetZipFileName(ZipFileName);
}

DIRECTUILIB_API void Delphi_Delphi_WindowImplBase_SetResourceType(CDelphi_WindowImplBase* handle, UILIB_RESOURCETYPE RType) {
	handle->SetResourceType(RType);
}

DIRECTUILIB_API void Delphi_Delphi_WindowImplBase_SetInitWindow(CDelphi_WindowImplBase* handle, InitWindowCallBack Callback) {
	handle->SetInitWindow(Callback);
}

DIRECTUILIB_API void Delphi_Delphi_WindowImplBase_SetFinalMessage(CDelphi_WindowImplBase* handle, FinalMessageCallBack Callback) {
	handle->SetFinalMessage(Callback);
}

DIRECTUILIB_API void Delphi_Delphi_WindowImplBase_SetHandleMessage(CDelphi_WindowImplBase* handle, HandleMessageCallBack Callback) {
	handle->SetHandleMessage(Callback);
}

DIRECTUILIB_API void Delphi_Delphi_WindowImplBase_SetNotify(CDelphi_WindowImplBase* handle, NotifyCallBack Callback) {
	handle->SetNotify(Callback);
}

DIRECTUILIB_API void Delphi_Delphi_WindowImplBase_SetClick(CDelphi_WindowImplBase* handle, NotifyCallBack Callback) {
	handle->SetClick(Callback);
}

DIRECTUILIB_API void Delphi_Delphi_WindowImplBase_SetMessageHandler(CDelphi_WindowImplBase* handle, MessageCallBack Callback) {
	handle->SetMessageHandler(Callback);
}

DIRECTUILIB_API void Delphi_Delphi_WindowImplBase_SetHandleCustomMessage(CDelphi_WindowImplBase* handle, MessageCallBack Callback) {
	handle->SetHandleCustomMessage(Callback);
}

DIRECTUILIB_API void Delphi_Delphi_WindowImplBase_SetCreateControl(CDelphi_WindowImplBase* handle, CreateControlCallBack CallBack) {
	handle->SetCreateControl(CallBack);
}

DIRECTUILIB_API void Delphi_Delphi_WindowImplBase_SetGetItemText(CDelphi_WindowImplBase* handle, GetItemTextCallBack ACallBack) {
	handle->SetGetItemText(ACallBack);
}

DIRECTUILIB_API void Delphi_Delphi_WindowImplBase_SetGetClassStyle(CDelphi_WindowImplBase* handle, UINT uStyle) {
	handle->SetGetClassStyle(uStyle);
}

DIRECTUILIB_API void Delphi_Delphi_WindowImplBase_RemoveThisInPaintManager(CDelphi_WindowImplBase* handle) {
	handle->RemoveThisInPaintManager();
}

DIRECTUILIB_API void Delphi_Delphi_WindowImplBase_SetResponseDefaultKeyEvent(CDelphi_WindowImplBase* handle, ResponseDefaultKeyEventCallBack ACallBack) {
	handle->SetResponseDefaultKeyEvent(ACallBack);
}


//================================CPaintManagerUI============================

DIRECTUILIB_API CPaintManagerUI* Delphi_PaintManagerUI_CppCreate() {
    return new CPaintManagerUI();
}

DIRECTUILIB_API void Delphi_PaintManagerUI_CppDestroy(CPaintManagerUI* handle) {
    delete handle;
}

DIRECTUILIB_API void Delphi_PaintManagerUI_Init(CPaintManagerUI* handle, HWND hWnd, LPCTSTR pstrName) {
	handle->Init(hWnd, pstrName);
}

DIRECTUILIB_API LPCTSTR Delphi_PaintManagerUI_GetName(CPaintManagerUI* handle) {
	return handle->GetName();
}

DIRECTUILIB_API bool Delphi_PaintManagerUI_IsUpdateNeeded(CPaintManagerUI* handle) {
    return handle->IsUpdateNeeded();
}

DIRECTUILIB_API void Delphi_PaintManagerUI_NeedUpdate(CPaintManagerUI* handle) {
    handle->NeedUpdate();
}

DIRECTUILIB_API void Delphi_PaintManagerUI_Invalidate_01(CPaintManagerUI* handle) {
    handle->Invalidate();
}

DIRECTUILIB_API void Delphi_PaintManagerUI_Invalidate_02(CPaintManagerUI* handle ,RECT& rcItem) {
    handle->Invalidate(rcItem);
}

DIRECTUILIB_API HDC Delphi_PaintManagerUI_GetPaintDC(CPaintManagerUI* handle) {
    return handle->GetPaintDC();
}

DIRECTUILIB_API HWND Delphi_PaintManagerUI_GetPaintWindow(CPaintManagerUI* handle) {
    return handle->GetPaintWindow();
}

DIRECTUILIB_API HWND Delphi_PaintManagerUI_GetTooltipWindow(CPaintManagerUI* handle) {
    return handle->GetTooltipWindow();
}

DIRECTUILIB_API POINT Delphi_PaintManagerUI_GetMousePos(CPaintManagerUI* handle) {
    return handle->GetMousePos();
}

DIRECTUILIB_API void Delphi_PaintManagerUI_GetClientSize(CPaintManagerUI* handle, SIZE& Result) {
    Result = handle->GetClientSize();
}

DIRECTUILIB_API void Delphi_PaintManagerUI_GetInitSize(CPaintManagerUI* handle, SIZE& Result) {
    Result = handle->GetInitSize();
}

DIRECTUILIB_API void Delphi_PaintManagerUI_SetInitSize(CPaintManagerUI* handle ,int cx, int cy) {
    handle->SetInitSize(cx, cy);
}

DIRECTUILIB_API RECT& Delphi_PaintManagerUI_GetSizeBox(CPaintManagerUI* handle) {
    return handle->GetSizeBox();
}

DIRECTUILIB_API void Delphi_PaintManagerUI_SetSizeBox(CPaintManagerUI* handle ,RECT& rcSizeBox) {
    handle->SetSizeBox(rcSizeBox);
}

DIRECTUILIB_API RECT& Delphi_PaintManagerUI_GetCaptionRect(CPaintManagerUI* handle) {
    return handle->GetCaptionRect();
}

DIRECTUILIB_API void Delphi_PaintManagerUI_SetCaptionRect(CPaintManagerUI* handle ,RECT& rcCaption) {
    handle->SetCaptionRect(rcCaption);
}

DIRECTUILIB_API void Delphi_PaintManagerUI_GetRoundCorner(CPaintManagerUI* handle, SIZE& Result) {
    Result = handle->GetRoundCorner();
}

DIRECTUILIB_API void Delphi_PaintManagerUI_SetRoundCorner(CPaintManagerUI* handle ,int cx, int cy) {
    handle->SetRoundCorner(cx, cy);
}

DIRECTUILIB_API void Delphi_PaintManagerUI_GetMinInfo(CPaintManagerUI* handle, SIZE& Result) {
    Result = handle->GetMinInfo();
}

DIRECTUILIB_API void Delphi_PaintManagerUI_SetMinInfo(CPaintManagerUI* handle ,int cx, int cy) {
    handle->SetMinInfo(cx, cy);
}

DIRECTUILIB_API void Delphi_PaintManagerUI_GetMaxInfo(CPaintManagerUI* handle, SIZE& Result) {
    Result = handle->GetMaxInfo();
}

DIRECTUILIB_API void Delphi_PaintManagerUI_SetMaxInfo(CPaintManagerUI* handle ,int cx, int cy) {
    handle->SetMaxInfo(cx, cy);
}

DIRECTUILIB_API bool Delphi_PaintManagerUI_IsShowUpdateRect(CPaintManagerUI* handle) {
    return handle->IsShowUpdateRect();
}

DIRECTUILIB_API void Delphi_PaintManagerUI_SetShowUpdateRect(CPaintManagerUI* handle ,bool show) {
    handle->SetShowUpdateRect(show);
}

DIRECTUILIB_API HINSTANCE Delphi_PaintManagerUI_GetInstance() {
    return CPaintManagerUI::GetInstance();
}

DIRECTUILIB_API CDuiString Delphi_PaintManagerUI_GetInstancePath() {
    return CPaintManagerUI::GetInstancePath();
}

DIRECTUILIB_API CDuiString Delphi_PaintManagerUI_GetCurrentPath() {
    return CPaintManagerUI::GetCurrentPath();
}

DIRECTUILIB_API HINSTANCE Delphi_PaintManagerUI_GetResourceDll() {
    return CPaintManagerUI::GetResourceDll();
}

DIRECTUILIB_API const CDuiString& Delphi_PaintManagerUI_GetResourcePath() {
    return CPaintManagerUI::GetResourcePath();
}

DIRECTUILIB_API const CDuiString& Delphi_PaintManagerUI_GetResourceZip() {
    return CPaintManagerUI::GetResourceZip();
}

DIRECTUILIB_API bool Delphi_PaintManagerUI_IsCachedResourceZip() {
    return CPaintManagerUI::IsCachedResourceZip();
}

DIRECTUILIB_API HANDLE Delphi_PaintManagerUI_GetResourceZipHandle() {
    return CPaintManagerUI::GetResourceZipHandle();
}

DIRECTUILIB_API void Delphi_PaintManagerUI_SetInstance(HINSTANCE hInst) {
    CPaintManagerUI::SetInstance(hInst);
}

DIRECTUILIB_API void Delphi_PaintManagerUI_SetCurrentPath(LPCTSTR pStrPath) {
    CPaintManagerUI::SetCurrentPath(pStrPath);
}

DIRECTUILIB_API void Delphi_PaintManagerUI_SetResourceDll(HINSTANCE hInst) {
    CPaintManagerUI::SetResourceDll(hInst);
}

DIRECTUILIB_API void Delphi_PaintManagerUI_SetResourcePath(LPCTSTR pStrPath) {
    CPaintManagerUI::SetResourcePath(pStrPath);
}

DIRECTUILIB_API void Delphi_PaintManagerUI_SetResourceZip_01(LPVOID pVoid, unsigned int len) {
    CPaintManagerUI::SetResourceZip(pVoid, len);
}

DIRECTUILIB_API void Delphi_PaintManagerUI_SetResourceZip_02(LPCTSTR pstrZip, bool bCachedResourceZip) {
    CPaintManagerUI::SetResourceZip(pstrZip, bCachedResourceZip);
}

DIRECTUILIB_API bool Delphi_PaintManagerUI_GetHSL(short* H, short* S, short* L) {
    return CPaintManagerUI::GetHSL(H, S, L);
}

DIRECTUILIB_API void Delphi_PaintManagerUI_ReloadSkin() {
    CPaintManagerUI::ReloadSkin();
}

DIRECTUILIB_API bool Delphi_PaintManagerUI_LoadPlugin(LPCTSTR pstrModuleName) {
    return CPaintManagerUI::LoadPlugin(pstrModuleName);
}

DIRECTUILIB_API CStdPtrArray* Delphi_PaintManagerUI_GetPlugins() {
    return CPaintManagerUI::GetPlugins();
}

DIRECTUILIB_API bool Delphi_PaintManagerUI_IsForceUseSharedRes(CPaintManagerUI* handle) {
	return handle->IsForceUseSharedRes();
}

DIRECTUILIB_API void Delphi_PaintManagerUI_SetForceUseSharedRes(CPaintManagerUI* handle, bool bForce) {
	handle->SetForceUseSharedRes(bForce);
}

DIRECTUILIB_API bool Delphi_PaintManagerUI_IsPainting(CPaintManagerUI* handle) {
	return handle->IsPainting();
}

DIRECTUILIB_API void Delphi_PaintManagerUI_SetPainting(CPaintManagerUI* handle, bool bIsPainting) {
	handle->SetPainting(bIsPainting);
}

DIRECTUILIB_API DWORD Delphi_PaintManagerUI_GetDefaultDisabledColor(CPaintManagerUI* handle) {
    return handle->GetDefaultDisabledColor();
}

DIRECTUILIB_API void Delphi_PaintManagerUI_SetDefaultDisabledColor(CPaintManagerUI* handle ,DWORD dwColor, bool bShared) {
    handle->SetDefaultDisabledColor(dwColor, bShared);
}

DIRECTUILIB_API DWORD Delphi_PaintManagerUI_GetDefaultFontColor(CPaintManagerUI* handle) {
    return handle->GetDefaultFontColor();
}

DIRECTUILIB_API void Delphi_PaintManagerUI_SetDefaultFontColor(CPaintManagerUI* handle ,DWORD dwColor, bool bShared) {
    handle->SetDefaultFontColor(dwColor, bShared);
}

DIRECTUILIB_API DWORD Delphi_PaintManagerUI_GetDefaultLinkFontColor(CPaintManagerUI* handle) {
    return handle->GetDefaultLinkFontColor();
}

DIRECTUILIB_API void Delphi_PaintManagerUI_SetDefaultLinkFontColor(CPaintManagerUI* handle ,DWORD dwColor, bool bShared) {
    handle->SetDefaultLinkFontColor(dwColor, bShared);
}

DIRECTUILIB_API DWORD Delphi_PaintManagerUI_GetDefaultLinkHoverFontColor(CPaintManagerUI* handle) {
    return handle->GetDefaultLinkHoverFontColor();
}

DIRECTUILIB_API void Delphi_PaintManagerUI_SetDefaultLinkHoverFontColor(CPaintManagerUI* handle ,DWORD dwColor, bool bShared) {
    handle->SetDefaultLinkHoverFontColor(dwColor, bShared);
}

DIRECTUILIB_API DWORD Delphi_PaintManagerUI_GetDefaultSelectedBkColor(CPaintManagerUI* handle) {
    return handle->GetDefaultSelectedBkColor();
}

DIRECTUILIB_API void Delphi_PaintManagerUI_SetDefaultSelectedBkColor(CPaintManagerUI* handle ,DWORD dwColor, bool bShared) {
    handle->SetDefaultSelectedBkColor(dwColor, bShared);
}

DIRECTUILIB_API TFontInfo* Delphi_PaintManagerUI_GetDefaultFontInfo(CPaintManagerUI* handle) {
    return handle->GetDefaultFontInfo();
}

DIRECTUILIB_API void Delphi_PaintManagerUI_SetDefaultFont(CPaintManagerUI* handle ,LPCTSTR pStrFontName, int nSize, bool bBold, bool bUnderline, bool bItalic, bool bShared) {
    handle->SetDefaultFont(pStrFontName, nSize, bBold, bUnderline, bItalic, bShared);
}

DIRECTUILIB_API DWORD Delphi_PaintManagerUI_GetCustomFontCount(CPaintManagerUI* handle ,bool bShared) {
    return handle->GetCustomFontCount(bShared);
}

DIRECTUILIB_API HFONT Delphi_PaintManagerUI_AddFont(CPaintManagerUI* handle ,int id, LPCTSTR pStrFontName, int nSize, bool bBold, bool bUnderline, bool bItalic, bool bShared) {
    return handle->AddFont(id, pStrFontName, nSize, bBold, bUnderline, bItalic, bShared);
}

DIRECTUILIB_API HFONT Delphi_PaintManagerUI_GetFont_01(CPaintManagerUI* handle ,int id) {
    return handle->GetFont(id);
}

DIRECTUILIB_API HFONT Delphi_PaintManagerUI_GetFont_02(CPaintManagerUI* handle ,LPCTSTR pStrFontName, int nSize, bool bBold, bool bUnderline, bool bItalic) {
    return handle->GetFont(pStrFontName, nSize, bBold, bUnderline, bItalic);
}

DIRECTUILIB_API int Delphi_PaintManagerUI_GetFontIndex_01(CPaintManagerUI* handle ,HFONT hFont, bool bShared) {
    return handle->GetFontIndex(hFont, bShared);
}

DIRECTUILIB_API int Delphi_PaintManagerUI_GetFontIndex_02(CPaintManagerUI* handle ,LPCTSTR pStrFontName, int nSize, bool bBold, bool bUnderline, bool bItalic, bool bShared) {
    return handle->GetFontIndex(pStrFontName, nSize, bBold, bUnderline, bItalic, bShared);
}

DIRECTUILIB_API void Delphi_PaintManagerUI_RemoveFont_01(CPaintManagerUI* handle ,HFONT hFont, bool bShared) {
    handle->RemoveFont(hFont, bShared);
}

DIRECTUILIB_API void Delphi_PaintManagerUI_RemoveFont_02(CPaintManagerUI* handle ,int id, bool bShared) {
    handle->RemoveFont(id, bShared);
}

DIRECTUILIB_API void Delphi_PaintManagerUI_RemoveAllFonts(CPaintManagerUI* handle ,bool bShared) {
    handle->RemoveAllFonts(bShared);
}

DIRECTUILIB_API TFontInfo* Delphi_PaintManagerUI_GetFontInfo_01(CPaintManagerUI* handle ,int id) {
    return handle->GetFontInfo(id);
}

DIRECTUILIB_API TFontInfo* Delphi_PaintManagerUI_GetFontInfo_02(CPaintManagerUI* handle ,HFONT hFont) {
    return handle->GetFontInfo(hFont);
}

DIRECTUILIB_API const TImageInfo* Delphi_PaintManagerUI_GetImage(CPaintManagerUI* handle ,LPCTSTR bitmap) {
    return handle->GetImage(bitmap);
}

DIRECTUILIB_API const TImageInfo* Delphi_PaintManagerUI_GetImageEx(CPaintManagerUI* handle ,LPCTSTR bitmap, LPCTSTR type, DWORD mask, bool bUseHSL) {
    return handle->GetImageEx(bitmap, type, mask, bUseHSL);
}

DIRECTUILIB_API const TImageInfo* Delphi_PaintManagerUI_AddImage_01(CPaintManagerUI* handle ,LPCTSTR bitmap, LPCTSTR type, DWORD mask, bool bUseHSL, bool bShared) {
    return handle->AddImage(bitmap, type, mask, bUseHSL, bShared);
}

DIRECTUILIB_API const TImageInfo* Delphi_PaintManagerUI_AddImage_02(CPaintManagerUI* handle ,LPCTSTR bitmap, HBITMAP hBitmap, int iWidth, int iHeight, bool bAlpha, bool bShared) {
    return handle->AddImage(bitmap, hBitmap, iWidth, iHeight, bAlpha, bShared);
}

DIRECTUILIB_API void Delphi_PaintManagerUI_RemoveImage(CPaintManagerUI* handle ,LPCTSTR bitmap, bool bShared) {
    handle->RemoveImage(bitmap, bShared);
}

DIRECTUILIB_API void Delphi_PaintManagerUI_RemoveAllImages(CPaintManagerUI* handle ,bool bShared) {
    handle->RemoveAllImages(bShared);
}

DIRECTUILIB_API void Delphi_PaintManagerUI_ReloadSharedImages() {
    CPaintManagerUI::ReloadSharedImages();
}

DIRECTUILIB_API void Delphi_PaintManagerUI_ReloadImages(CPaintManagerUI* handle) {
    handle->ReloadImages();
}

DIRECTUILIB_API void Delphi_PaintManagerUI_AddDefaultAttributeList(CPaintManagerUI* handle ,LPCTSTR pStrControlName, LPCTSTR pStrControlAttrList, bool bShared) {
    handle->AddDefaultAttributeList(pStrControlName, pStrControlAttrList, bShared);
}

DIRECTUILIB_API LPCTSTR Delphi_PaintManagerUI_GetDefaultAttributeList(CPaintManagerUI* handle ,LPCTSTR pStrControlName) {
    return handle->GetDefaultAttributeList(pStrControlName);
}

DIRECTUILIB_API bool Delphi_PaintManagerUI_RemoveDefaultAttributeList(CPaintManagerUI* handle ,LPCTSTR pStrControlName, bool bShared) {
    return handle->RemoveDefaultAttributeList(pStrControlName, bShared);
}

DIRECTUILIB_API void Delphi_PaintManagerUI_RemoveAllDefaultAttributeList(CPaintManagerUI* handle ,bool bShared) {
    handle->RemoveAllDefaultAttributeList(bShared);
}

DIRECTUILIB_API void Delphi_PaintManagerUI_AddMultiLanguageString(int id, LPCTSTR pStrMultiLanguage) {
    CPaintManagerUI::AddMultiLanguageString(id, pStrMultiLanguage);
}

DIRECTUILIB_API LPCTSTR Delphi_PaintManagerUI_GetMultiLanguageString(int id) {
    return CPaintManagerUI::GetMultiLanguageString(id);
}

DIRECTUILIB_API bool Delphi_PaintManagerUI_RemoveMultiLanguageString(int id) {
    return CPaintManagerUI::RemoveMultiLanguageString(id);
}

DIRECTUILIB_API void Delphi_PaintManagerUI_RemoveAllMultiLanguageString() {
    CPaintManagerUI::RemoveAllMultiLanguageString();
}

DIRECTUILIB_API void Delphi_PaintManagerUI_ProcessMultiLanguageTokens(CDuiString& pStrMultiLanguage) {
    CPaintManagerUI::ProcessMultiLanguageTokens(pStrMultiLanguage);
}

DIRECTUILIB_API bool Delphi_PaintManagerUI_AttachDialog(CPaintManagerUI* handle ,CControlUI* pControl) {
    return handle->AttachDialog(pControl);
}

DIRECTUILIB_API bool Delphi_PaintManagerUI_InitControls(CPaintManagerUI* handle ,CControlUI* pControl, CControlUI* pParent) {
    return handle->InitControls(pControl, pParent);
}

DIRECTUILIB_API void Delphi_PaintManagerUI_ReapObjects(CPaintManagerUI* handle ,CControlUI* pControl) {
    handle->ReapObjects(pControl);
}

DIRECTUILIB_API bool Delphi_PaintManagerUI_AddOptionGroup(CPaintManagerUI* handle ,LPCTSTR pStrGroupName, CControlUI* pControl) {
    return handle->AddOptionGroup(pStrGroupName, pControl);
}

DIRECTUILIB_API CStdPtrArray* Delphi_PaintManagerUI_GetOptionGroup(CPaintManagerUI* handle ,LPCTSTR pStrGroupName) {
    return handle->GetOptionGroup(pStrGroupName);
}

DIRECTUILIB_API void Delphi_PaintManagerUI_RemoveOptionGroup(CPaintManagerUI* handle ,LPCTSTR pStrGroupName, CControlUI* pControl) {
    handle->RemoveOptionGroup(pStrGroupName, pControl);
}

DIRECTUILIB_API void Delphi_PaintManagerUI_RemoveAllOptionGroups(CPaintManagerUI* handle) {
    handle->RemoveAllOptionGroups();
}

DIRECTUILIB_API CControlUI* Delphi_PaintManagerUI_GetFocus(CPaintManagerUI* handle) {
    return handle->GetFocus();
}

DIRECTUILIB_API void Delphi_PaintManagerUI_SetFocus(CPaintManagerUI* handle, CControlUI* pControl, bool bFocusWnd) {
	handle->SetFocus(pControl, bFocusWnd);
}

DIRECTUILIB_API void Delphi_PaintManagerUI_SetFocusNeeded(CPaintManagerUI* handle ,CControlUI* pControl) {
    handle->SetFocusNeeded(pControl);
}

DIRECTUILIB_API bool Delphi_PaintManagerUI_SetNextTabControl(CPaintManagerUI* handle ,bool bForward) {
    return handle->SetNextTabControl(bForward);
}

DIRECTUILIB_API bool Delphi_PaintManagerUI_SetTimer(CPaintManagerUI* handle ,CControlUI* pControl, UINT nTimerID, UINT uElapse) {
    return handle->SetTimer(pControl, nTimerID, uElapse);
}

DIRECTUILIB_API bool Delphi_PaintManagerUI_KillTimer_01(CPaintManagerUI* handle ,CControlUI* pControl, UINT nTimerID) {
    return handle->KillTimer(pControl, nTimerID);
}

DIRECTUILIB_API void Delphi_PaintManagerUI_KillTimer_02(CPaintManagerUI* handle ,CControlUI* pControl) {
    handle->KillTimer(pControl);
}

DIRECTUILIB_API void Delphi_PaintManagerUI_RemoveAllTimers(CPaintManagerUI* handle) {
    handle->RemoveAllTimers();
}

DIRECTUILIB_API void Delphi_PaintManagerUI_SetCapture(CPaintManagerUI* handle) {
    handle->SetCapture();
}

DIRECTUILIB_API void Delphi_PaintManagerUI_ReleaseCapture(CPaintManagerUI* handle) {
    handle->ReleaseCapture();
}

DIRECTUILIB_API bool Delphi_PaintManagerUI_IsCaptured(CPaintManagerUI* handle) {
    return handle->IsCaptured();
}

DIRECTUILIB_API bool Delphi_PaintManagerUI_AddNotifier(CPaintManagerUI* handle ,INotifyUI* pControl) {
    return handle->AddNotifier(pControl);
}

DIRECTUILIB_API bool Delphi_PaintManagerUI_RemoveNotifier(CPaintManagerUI* handle ,INotifyUI* pControl) {
    return handle->RemoveNotifier(pControl);
}

DIRECTUILIB_API void Delphi_PaintManagerUI_SendNotify_01(CPaintManagerUI* handle, TNotifyUI& Msg, bool bAsync, bool bEnableRepeat) {
	handle->SendNotify(Msg, bAsync, bEnableRepeat);
}

DIRECTUILIB_API void Delphi_PaintManagerUI_SendNotify_02(CPaintManagerUI* handle, CControlUI* pControl, LPCTSTR pstrMessage, WPARAM wParam, LPARAM lParam, bool bAsync, bool bEnableRepeat) {
	handle->SendNotify(pControl, pstrMessage, wParam, lParam, bAsync, bEnableRepeat);
}

DIRECTUILIB_API bool Delphi_PaintManagerUI_AddPreMessageFilter(CPaintManagerUI* handle ,IMessageFilterUI* pFilter) {
    return handle->AddPreMessageFilter(pFilter);
}

DIRECTUILIB_API bool Delphi_PaintManagerUI_RemovePreMessageFilter(CPaintManagerUI* handle ,IMessageFilterUI* pFilter) {
    return handle->RemovePreMessageFilter(pFilter);
}

DIRECTUILIB_API bool Delphi_PaintManagerUI_AddMessageFilter(CPaintManagerUI* handle ,IMessageFilterUI* pFilter) {
    return handle->AddMessageFilter(pFilter);
}

DIRECTUILIB_API bool Delphi_PaintManagerUI_RemoveMessageFilter(CPaintManagerUI* handle ,IMessageFilterUI* pFilter) {
    return handle->RemoveMessageFilter(pFilter);
}

DIRECTUILIB_API int Delphi_PaintManagerUI_GetPostPaintCount(CPaintManagerUI* handle) {
    return handle->GetPostPaintCount();
}

DIRECTUILIB_API bool Delphi_PaintManagerUI_AddPostPaint(CPaintManagerUI* handle ,CControlUI* pControl) {
    return handle->AddPostPaint(pControl);
}

DIRECTUILIB_API bool Delphi_PaintManagerUI_RemovePostPaint(CPaintManagerUI* handle ,CControlUI* pControl) {
    return handle->RemovePostPaint(pControl);
}

DIRECTUILIB_API bool Delphi_PaintManagerUI_SetPostPaintIndex(CPaintManagerUI* handle ,CControlUI* pControl, int iIndex) {
    return handle->SetPostPaintIndex(pControl, iIndex);
}

DIRECTUILIB_API int Delphi_PaintManagerUI_GetNativeWindowCount(CPaintManagerUI* handle) {
	return handle->GetNativeWindowCount();
}

DIRECTUILIB_API bool Delphi_PaintManagerUI_AddNativeWindow(CPaintManagerUI* handle, CControlUI* pControl, HWND hChildWnd) {
	return handle->AddNativeWindow(pControl, hChildWnd);
}

DIRECTUILIB_API bool Delphi_PaintManagerUI_RemoveNativeWindow(CPaintManagerUI* handle, HWND hChildWnd) {
	return handle->RemoveNativeWindow(hChildWnd);
}

DIRECTUILIB_API void Delphi_PaintManagerUI_AddDelayedCleanup(CPaintManagerUI* handle ,CControlUI* pControl) {
    handle->AddDelayedCleanup(pControl);
}

DIRECTUILIB_API bool Delphi_PaintManagerUI_AddTranslateAccelerator(CPaintManagerUI* handle ,ITranslateAccelerator* pTranslateAccelerator) {
    return handle->AddTranslateAccelerator(pTranslateAccelerator);
}

DIRECTUILIB_API bool Delphi_PaintManagerUI_RemoveTranslateAccelerator(CPaintManagerUI* handle ,ITranslateAccelerator* pTranslateAccelerator) {
    return handle->RemoveTranslateAccelerator(pTranslateAccelerator);
}

DIRECTUILIB_API bool Delphi_PaintManagerUI_TranslateAccelerator(CPaintManagerUI* handle ,LPMSG pMsg) {
    return handle->TranslateAccelerator(pMsg);
}

DIRECTUILIB_API CControlUI* Delphi_PaintManagerUI_GetRoot(CPaintManagerUI* handle) {
    return handle->GetRoot();
}

DIRECTUILIB_API CControlUI* Delphi_PaintManagerUI_FindControl_01(CPaintManagerUI* handle ,POINT pt) {
    return handle->FindControl(pt);
}

DIRECTUILIB_API CControlUI* Delphi_PaintManagerUI_FindControl_02(CPaintManagerUI* handle ,LPCTSTR pstrName) {
    return handle->FindControl(pstrName);
}

DIRECTUILIB_API CControlUI* Delphi_PaintManagerUI_FindSubControlByPoint(CPaintManagerUI* handle ,CControlUI* pParent, POINT pt) {
    return handle->FindSubControlByPoint(pParent, pt);
}

DIRECTUILIB_API CControlUI* Delphi_PaintManagerUI_FindSubControlByName(CPaintManagerUI* handle ,CControlUI* pParent, LPCTSTR pstrName) {
    return handle->FindSubControlByName(pParent, pstrName);
}

DIRECTUILIB_API CControlUI* Delphi_PaintManagerUI_FindSubControlByClass(CPaintManagerUI* handle ,CControlUI* pParent, LPCTSTR pstrClass, int iIndex) {
    return handle->FindSubControlByClass(pParent, pstrClass, iIndex);
}

DIRECTUILIB_API CStdPtrArray* Delphi_PaintManagerUI_FindSubControlsByClass(CPaintManagerUI* handle ,CControlUI* pParent, LPCTSTR pstrClass) {
    return handle->FindSubControlsByClass(pParent, pstrClass);
}

DIRECTUILIB_API void Delphi_PaintManagerUI_MessageLoop() {
    CPaintManagerUI::MessageLoop();
}

DIRECTUILIB_API bool Delphi_PaintManagerUI_TranslateMessage(LPMSG pMsg) {
    return CPaintManagerUI::TranslateMessage(pMsg);
}

DIRECTUILIB_API void Delphi_PaintManagerUI_Term() {
    CPaintManagerUI::Term();
}

DIRECTUILIB_API bool Delphi_PaintManagerUI_MessageHandler(CPaintManagerUI* handle ,UINT uMsg, WPARAM wParam, LPARAM lParam, LRESULT& lRes) {
    return handle->MessageHandler(uMsg, wParam, lParam, lRes);
}

DIRECTUILIB_API bool Delphi_PaintManagerUI_PreMessageHandler(CPaintManagerUI* handle ,UINT uMsg, WPARAM wParam, LPARAM lParam, LRESULT& lRes) {
    return handle->PreMessageHandler(uMsg, wParam, lParam, lRes);
}

DIRECTUILIB_API void Delphi_PaintManagerUI_UsedVirtualWnd(CPaintManagerUI* handle ,bool bUsed) {
    handle->UsedVirtualWnd(bUsed);
}

DIRECTUILIB_API int Delphi_PaintManagerUI_GetTooltipWindowWidth(CPaintManagerUI* handle) {
	return handle->GetTooltipWindowWidth();
}

DIRECTUILIB_API void Delphi_PaintManagerUI_SetTooltipWindowWidth(CPaintManagerUI* handle, int iWidth) {
	handle->SetTooltipWindowWidth(iWidth);
}

DIRECTUILIB_API int Delphi_PaintManagerUI_GetHoverTime(CPaintManagerUI* handle) {
	return handle->GetHoverTime();
}

DIRECTUILIB_API void Delphi_PaintManagerUI_SetHoverTime(CPaintManagerUI* handle, int iTime) {
	handle->SetHoverTime(iTime);
}

DIRECTUILIB_API BYTE Delphi_PaintManagerUI_GetOpacity(CPaintManagerUI* handle) {
	return handle->GetOpacity();
}

DIRECTUILIB_API void Delphi_PaintManagerUI_SetOpacity(CPaintManagerUI* handle, BYTE nOpacity) {
	handle->SetOpacity(nOpacity);
}

DIRECTUILIB_API bool Delphi_PaintManagerUI_IsLayered(CPaintManagerUI* handle) {
	return handle->IsLayered();
}

DIRECTUILIB_API void Delphi_PaintManagerUI_SetLayered(CPaintManagerUI* handle, bool bLayered) {
	handle->SetLayered(bLayered);
}

DIRECTUILIB_API RECT& Delphi_PaintManagerUI_GetLayeredInset(CPaintManagerUI* handle) {
	return handle->GetLayeredInset();
}

DIRECTUILIB_API void Delphi_PaintManagerUI_SetLayeredInset(CPaintManagerUI* handle, RECT& rcLayeredInset) {
	handle->SetLayeredInset(rcLayeredInset);
}

DIRECTUILIB_API BYTE Delphi_PaintManagerUI_GetLayeredOpacity(CPaintManagerUI* handle) {
	return handle->GetLayeredOpacity();
}

DIRECTUILIB_API void Delphi_PaintManagerUI_SetLayeredOpacity(CPaintManagerUI* handle, BYTE nOpacity) {
	handle->SetLayeredOpacity(nOpacity);
}

DIRECTUILIB_API LPCTSTR Delphi_PaintManagerUI_GetLayeredImage(CPaintManagerUI* handle) {
	return handle->GetLayeredImage();
}

DIRECTUILIB_API void Delphi_PaintManagerUI_SetLayeredImage(CPaintManagerUI* handle, LPCTSTR pstrImage) {
	handle->SetLayeredImage(pstrImage);
}

DIRECTUILIB_API CPaintManagerUI* Delphi_PaintManagerUI_GetPaintManager(LPCTSTR pstrName) {
	return CPaintManagerUI::GetPaintManager(pstrName);
}

DIRECTUILIB_API CStdPtrArray* Delphi_PaintManagerUI_GetPaintManagers() {
	return CPaintManagerUI::GetPaintManagers();
}

DIRECTUILIB_API void Delphi_PaintManagerUI_AddWindowCustomAttribute(CPaintManagerUI* handle, LPCTSTR pstrName, LPCTSTR pstrAttr) {
	handle->AddWindowCustomAttribute(pstrName, pstrAttr);
}

DIRECTUILIB_API LPCTSTR Delphi_PaintManagerUI_GetWindowCustomAttribute(CPaintManagerUI* handle, LPCTSTR pstrName) {
	return handle->GetWindowCustomAttribute(pstrName);
}

DIRECTUILIB_API bool Delphi_PaintManagerUI_RemoveWindowCustomAttribute(CPaintManagerUI* handle, LPCTSTR pstrName) {
	return handle->RemoveWindowCustomAttribute(pstrName);
}

DIRECTUILIB_API void Delphi_PaintManagerUI_RemoveAllWindowCustomAttribute(CPaintManagerUI* handle) {
	handle->RemoveAllWindowCustomAttribute();
}


//================================CContainerUI============================

DIRECTUILIB_API CContainerUI* Delphi_ContainerUI_CppCreate() {
    return new CContainerUI();
}

DIRECTUILIB_API void Delphi_ContainerUI_CppDestroy(CContainerUI* handle) {
    delete handle;
}

DIRECTUILIB_API LPCTSTR Delphi_ContainerUI_GetClass(CContainerUI* handle) {
    return handle->GetClass();
}

DIRECTUILIB_API LPVOID Delphi_ContainerUI_GetInterface(CContainerUI* handle ,LPCTSTR pstrName) {
    return handle->GetInterface(pstrName);
}

DIRECTUILIB_API CControlUI* Delphi_ContainerUI_GetItemAt(CContainerUI* handle ,int iIndex) {
    return handle->GetItemAt(iIndex);
}

DIRECTUILIB_API int Delphi_ContainerUI_GetItemIndex(CContainerUI* handle ,CControlUI* pControl) {
    return handle->GetItemIndex(pControl);
}

DIRECTUILIB_API bool Delphi_ContainerUI_SetItemIndex(CContainerUI* handle ,CControlUI* pControl, int iIndex) {
    return handle->SetItemIndex(pControl, iIndex);
}

DIRECTUILIB_API int Delphi_ContainerUI_GetCount(CContainerUI* handle) {
    return handle->GetCount();
}

DIRECTUILIB_API bool Delphi_ContainerUI_Add(CContainerUI* handle ,CControlUI* pControl) {
    return handle->Add(pControl);
}

DIRECTUILIB_API bool Delphi_ContainerUI_AddAt(CContainerUI* handle ,CControlUI* pControl, int iIndex) {
    return handle->AddAt(pControl, iIndex);
}

DIRECTUILIB_API bool Delphi_ContainerUI_Remove(CContainerUI* handle ,CControlUI* pControl) {
    return handle->Remove(pControl);
}

DIRECTUILIB_API bool Delphi_ContainerUI_RemoveAt(CContainerUI* handle ,int iIndex) {
    return handle->RemoveAt(iIndex);
}

DIRECTUILIB_API void Delphi_ContainerUI_RemoveAll(CContainerUI* handle) {
    handle->RemoveAll();
}

DIRECTUILIB_API void Delphi_ContainerUI_DoEvent(CContainerUI* handle ,TEventUI& event) {
    handle->DoEvent(event);
}

DIRECTUILIB_API void Delphi_ContainerUI_SetVisible(CContainerUI* handle ,bool bVisible) {
    handle->SetVisible(bVisible);
}

DIRECTUILIB_API void Delphi_ContainerUI_SetInternVisible(CContainerUI* handle ,bool bVisible) {
    handle->SetInternVisible(bVisible);
}

DIRECTUILIB_API void Delphi_ContainerUI_SetMouseEnabled(CContainerUI* handle ,bool bEnable) {
    handle->SetMouseEnabled(bEnable);
}

DIRECTUILIB_API void Delphi_ContainerUI_GetInset(CContainerUI* handle, RECT& Result) {
    Result = handle->GetInset();
}

DIRECTUILIB_API void Delphi_ContainerUI_SetInset(CContainerUI* handle ,RECT rcInset) {
    handle->SetInset(rcInset);
}

DIRECTUILIB_API int Delphi_ContainerUI_GetChildPadding(CContainerUI* handle) {
    return handle->GetChildPadding();
}

DIRECTUILIB_API void Delphi_ContainerUI_SetChildPadding(CContainerUI* handle ,int iPadding) {
    handle->SetChildPadding(iPadding);
}

DIRECTUILIB_API bool Delphi_ContainerUI_IsAutoDestroy(CContainerUI* handle) {
    return handle->IsAutoDestroy();
}

DIRECTUILIB_API void Delphi_ContainerUI_SetAutoDestroy(CContainerUI* handle ,bool bAuto) {
    handle->SetAutoDestroy(bAuto);
}

DIRECTUILIB_API bool Delphi_ContainerUI_IsDelayedDestroy(CContainerUI* handle) {
    return handle->IsDelayedDestroy();
}

DIRECTUILIB_API void Delphi_ContainerUI_SetDelayedDestroy(CContainerUI* handle ,bool bDelayed) {
    handle->SetDelayedDestroy(bDelayed);
}

DIRECTUILIB_API bool Delphi_ContainerUI_IsMouseChildEnabled(CContainerUI* handle) {
    return handle->IsMouseChildEnabled();
}

DIRECTUILIB_API void Delphi_ContainerUI_SetMouseChildEnabled(CContainerUI* handle ,bool bEnable) {
    handle->SetMouseChildEnabled(bEnable);
}

DIRECTUILIB_API int Delphi_ContainerUI_FindSelectable(CContainerUI* handle ,int iIndex, bool bForward) {
    return handle->FindSelectable(iIndex, bForward);
}

DIRECTUILIB_API void Delphi_ContainerUI_GetClientPos(CContainerUI* handle, RECT& Result) {
	Result = handle->GetClientPos();
}

DIRECTUILIB_API void Delphi_ContainerUI_SetPos(CContainerUI* handle ,RECT rc, bool bNeedInvalidate) {
    handle->SetPos(rc, bNeedInvalidate);
}

DIRECTUILIB_API void Delphi_ContainerUI_Move(CContainerUI* handle ,SIZE szOffset, bool bNeedInvalidate) {
    handle->Move(szOffset, bNeedInvalidate);
}

DIRECTUILIB_API void Delphi_ContainerUI_DoPaint(CContainerUI* handle ,HDC hDC, RECT& rcPaint) {
    handle->DoPaint(hDC, rcPaint);
}

DIRECTUILIB_API void Delphi_ContainerUI_SetAttribute(CContainerUI* handle ,LPCTSTR pstrName, LPCTSTR pstrValue) {
    handle->SetAttribute(pstrName, pstrValue);
}

DIRECTUILIB_API void Delphi_ContainerUI_SetManager(CContainerUI* handle ,CPaintManagerUI* pManager, CControlUI* pParent, bool bInit) {
    handle->SetManager(pManager, pParent, bInit);
}

DIRECTUILIB_API CControlUI* Delphi_ContainerUI_FindControl(CContainerUI* handle ,FINDCONTROLPROC Proc, LPVOID pData, UINT uFlags) {
    return handle->FindControl(Proc, pData, uFlags);
}

DIRECTUILIB_API bool Delphi_ContainerUI_SetSubControlText(CContainerUI* handle ,LPCTSTR pstrSubControlName, LPCTSTR pstrText) {
    return handle->SetSubControlText(pstrSubControlName, pstrText);
}

DIRECTUILIB_API bool Delphi_ContainerUI_SetSubControlFixedHeight(CContainerUI* handle ,LPCTSTR pstrSubControlName, int cy) {
    return handle->SetSubControlFixedHeight(pstrSubControlName, cy);
}

DIRECTUILIB_API bool Delphi_ContainerUI_SetSubControlFixedWdith(CContainerUI* handle ,LPCTSTR pstrSubControlName, int cx) {
    return handle->SetSubControlFixedWdith(pstrSubControlName, cx);
}

DIRECTUILIB_API bool Delphi_ContainerUI_SetSubControlUserData(CContainerUI* handle ,LPCTSTR pstrSubControlName, LPCTSTR pstrText) {
    return handle->SetSubControlUserData(pstrSubControlName, pstrText);
}

DIRECTUILIB_API CDuiString Delphi_ContainerUI_GetSubControlText(CContainerUI* handle ,LPCTSTR pstrSubControlName) {
    return handle->GetSubControlText(pstrSubControlName);
}

DIRECTUILIB_API int Delphi_ContainerUI_GetSubControlFixedHeight(CContainerUI* handle ,LPCTSTR pstrSubControlName) {
    return handle->GetSubControlFixedHeight(pstrSubControlName);
}

DIRECTUILIB_API int Delphi_ContainerUI_GetSubControlFixedWdith(CContainerUI* handle ,LPCTSTR pstrSubControlName) {
    return handle->GetSubControlFixedWdith(pstrSubControlName);
}

DIRECTUILIB_API const CDuiString Delphi_ContainerUI_GetSubControlUserData(CContainerUI* handle ,LPCTSTR pstrSubControlName) {
    return handle->GetSubControlUserData(pstrSubControlName);
}

DIRECTUILIB_API CControlUI* Delphi_ContainerUI_FindSubControl(CContainerUI* handle ,LPCTSTR pstrSubControlName) {
    return handle->FindSubControl(pstrSubControlName);
}

DIRECTUILIB_API void Delphi_ContainerUI_GetScrollPos(CContainerUI* handle, SIZE& Result) {
    Result = handle->GetScrollPos();
}

DIRECTUILIB_API void Delphi_ContainerUI_GetScrollRange(CContainerUI* handle, SIZE& Result) {
    Result = handle->GetScrollRange();
}

DIRECTUILIB_API void Delphi_ContainerUI_SetScrollPos(CContainerUI* handle ,SIZE szPos) {
    handle->SetScrollPos(szPos);
}

DIRECTUILIB_API void Delphi_ContainerUI_LineUp(CContainerUI* handle) {
    handle->LineUp();
}

DIRECTUILIB_API void Delphi_ContainerUI_LineDown(CContainerUI* handle) {
    handle->LineDown();
}

DIRECTUILIB_API void Delphi_ContainerUI_PageUp(CContainerUI* handle) {
    handle->PageUp();
}

DIRECTUILIB_API void Delphi_ContainerUI_PageDown(CContainerUI* handle) {
    handle->PageDown();
}

DIRECTUILIB_API void Delphi_ContainerUI_HomeUp(CContainerUI* handle) {
    handle->HomeUp();
}

DIRECTUILIB_API void Delphi_ContainerUI_EndDown(CContainerUI* handle) {
    handle->EndDown();
}

DIRECTUILIB_API void Delphi_ContainerUI_LineLeft(CContainerUI* handle) {
    handle->LineLeft();
}

DIRECTUILIB_API void Delphi_ContainerUI_LineRight(CContainerUI* handle) {
    handle->LineRight();
}

DIRECTUILIB_API void Delphi_ContainerUI_PageLeft(CContainerUI* handle) {
    handle->PageLeft();
}

DIRECTUILIB_API void Delphi_ContainerUI_PageRight(CContainerUI* handle) {
    handle->PageRight();
}

DIRECTUILIB_API void Delphi_ContainerUI_HomeLeft(CContainerUI* handle) {
    handle->HomeLeft();
}

DIRECTUILIB_API void Delphi_ContainerUI_EndRight(CContainerUI* handle) {
    handle->EndRight();
}

DIRECTUILIB_API void Delphi_ContainerUI_EnableScrollBar(CContainerUI* handle ,bool bEnableVertical, bool bEnableHorizontal) {
    handle->EnableScrollBar(bEnableVertical, bEnableHorizontal);
}

DIRECTUILIB_API CScrollBarUI* Delphi_ContainerUI_GetVerticalScrollBar(CContainerUI* handle) {
    return handle->GetVerticalScrollBar();
}

DIRECTUILIB_API CScrollBarUI* Delphi_ContainerUI_GetHorizontalScrollBar(CContainerUI* handle) {
    return handle->GetHorizontalScrollBar();
}

//================================CVerticalLayoutUI============================

DIRECTUILIB_API CVerticalLayoutUI* Delphi_VerticalLayoutUI_CppCreate() {
    return new CVerticalLayoutUI();
}

DIRECTUILIB_API void Delphi_VerticalLayoutUI_CppDestroy(CVerticalLayoutUI* handle) {
    delete handle;
}

DIRECTUILIB_API LPCTSTR Delphi_VerticalLayoutUI_GetClass(CVerticalLayoutUI* handle) {
    return handle->GetClass();
}

DIRECTUILIB_API LPVOID Delphi_VerticalLayoutUI_GetInterface(CVerticalLayoutUI* handle ,LPCTSTR pstrName) {
    return handle->GetInterface(pstrName);
}

DIRECTUILIB_API UINT Delphi_VerticalLayoutUI_GetControlFlags(CVerticalLayoutUI* handle) {
    return handle->GetControlFlags();
}

DIRECTUILIB_API void Delphi_VerticalLayoutUI_SetSepHeight(CVerticalLayoutUI* handle ,int iHeight) {
    handle->SetSepHeight(iHeight);
}

DIRECTUILIB_API int Delphi_VerticalLayoutUI_GetSepHeight(CVerticalLayoutUI* handle) {
    return handle->GetSepHeight();
}

DIRECTUILIB_API void Delphi_VerticalLayoutUI_SetSepImmMode(CVerticalLayoutUI* handle ,bool bImmediately) {
    handle->SetSepImmMode(bImmediately);
}

DIRECTUILIB_API bool Delphi_VerticalLayoutUI_IsSepImmMode(CVerticalLayoutUI* handle) {
    return handle->IsSepImmMode();
}

DIRECTUILIB_API void Delphi_VerticalLayoutUI_SetAttribute(CVerticalLayoutUI* handle ,LPCTSTR pstrName, LPCTSTR pstrValue) {
    handle->SetAttribute(pstrName, pstrValue);
}

DIRECTUILIB_API void Delphi_VerticalLayoutUI_DoEvent(CVerticalLayoutUI* handle ,TEventUI& event) {
    handle->DoEvent(event);
}

DIRECTUILIB_API void Delphi_VerticalLayoutUI_SetPos(CVerticalLayoutUI* handle ,RECT rc, bool bNeedInvalidate) {
    handle->SetPos(rc, bNeedInvalidate);
}

DIRECTUILIB_API void Delphi_VerticalLayoutUI_DoPostPaint(CVerticalLayoutUI* handle ,HDC hDC, RECT& rcPaint) {
    handle->DoPostPaint(hDC, rcPaint);
}

DIRECTUILIB_API void Delphi_VerticalLayoutUI_GetThumbRect(CVerticalLayoutUI* handle ,bool bUseNew, RECT& Result) {
    Result = handle->GetThumbRect(bUseNew);
}

//================================CListUI============================

DIRECTUILIB_API CListUI* Delphi_ListUI_CppCreate() {
    return new CListUI();
}

DIRECTUILIB_API void Delphi_ListUI_CppDestroy(CListUI* handle) {
    delete handle;
}

DIRECTUILIB_API LPCTSTR Delphi_ListUI_GetClass(CListUI* handle) {
    return handle->GetClass();
}

DIRECTUILIB_API UINT Delphi_ListUI_GetControlFlags(CListUI* handle) {
    return handle->GetControlFlags();
}

DIRECTUILIB_API LPVOID Delphi_ListUI_GetInterface(CListUI* handle ,LPCTSTR pstrName) {
    return handle->GetInterface(pstrName);
}

DIRECTUILIB_API bool Delphi_ListUI_GetScrollSelect(CListUI* handle) {
    return handle->GetScrollSelect();
}

DIRECTUILIB_API void Delphi_ListUI_SetScrollSelect(CListUI* handle ,bool bScrollSelect) {
    handle->SetScrollSelect(bScrollSelect);
}

DIRECTUILIB_API int Delphi_ListUI_GetCurSel(CListUI* handle) {
    return handle->GetCurSel();
}

DIRECTUILIB_API bool Delphi_ListUI_SelectItem(CListUI* handle, int iIndex, bool bTakeFocus, bool bTriggerEvent) {
	return handle->SelectItem(iIndex, bTakeFocus, bTriggerEvent);
}


DIRECTUILIB_API CListHeaderUI* Delphi_ListUI_GetHeader(CListUI* handle) {
    return handle->GetHeader();
}

DIRECTUILIB_API CContainerUI* Delphi_ListUI_GetList(CListUI* handle) {
    return handle->GetList();
}

DIRECTUILIB_API TListInfoUI* Delphi_ListUI_GetListInfo(CListUI* handle) {
    return handle->GetListInfo();
}

DIRECTUILIB_API CControlUI* Delphi_ListUI_GetItemAt(CListUI* handle ,int iIndex) {
    return handle->GetItemAt(iIndex);
}

DIRECTUILIB_API int Delphi_ListUI_GetItemIndex(CListUI* handle ,CControlUI* pControl) {
    return handle->GetItemIndex(pControl);
}

DIRECTUILIB_API bool Delphi_ListUI_SetItemIndex(CListUI* handle ,CControlUI* pControl, int iIndex) {
    return handle->SetItemIndex(pControl, iIndex);
}

DIRECTUILIB_API int Delphi_ListUI_GetCount(CListUI* handle) {
    return handle->GetCount();
}

DIRECTUILIB_API bool Delphi_ListUI_Add(CListUI* handle ,CControlUI* pControl) {
    return handle->Add(pControl);
}

DIRECTUILIB_API bool Delphi_ListUI_AddAt(CListUI* handle ,CControlUI* pControl, int iIndex) {
    return handle->AddAt(pControl, iIndex);
}

DIRECTUILIB_API bool Delphi_ListUI_Remove(CListUI* handle ,CControlUI* pControl) {
    return handle->Remove(pControl);
}

DIRECTUILIB_API bool Delphi_ListUI_RemoveAt(CListUI* handle ,int iIndex) {
    return handle->RemoveAt(iIndex);
}

DIRECTUILIB_API void Delphi_ListUI_RemoveAll(CListUI* handle) {
    handle->RemoveAll();
}

DIRECTUILIB_API void Delphi_ListUI_EnsureVisible(CListUI* handle ,int iIndex) {
    handle->EnsureVisible(iIndex);
}

DIRECTUILIB_API void Delphi_ListUI_Scroll(CListUI* handle ,int dx, int dy) {
    handle->Scroll(dx, dy);
}

DIRECTUILIB_API int Delphi_ListUI_GetChildPadding(CListUI* handle) {
    return handle->GetChildPadding();
}

DIRECTUILIB_API void Delphi_ListUI_SetChildPadding(CListUI* handle ,int iPadding) {
    handle->SetChildPadding(iPadding);
}

DIRECTUILIB_API void Delphi_ListUI_SetItemFont(CListUI* handle ,int index) {
    handle->SetItemFont(index);
}

DIRECTUILIB_API void Delphi_ListUI_SetItemTextStyle(CListUI* handle ,UINT uStyle) {
    handle->SetItemTextStyle(uStyle);
}

DIRECTUILIB_API void Delphi_ListUI_SetItemTextPadding(CListUI* handle ,RECT rc) {
    handle->SetItemTextPadding(rc);
}

DIRECTUILIB_API void Delphi_ListUI_SetItemTextColor(CListUI* handle ,DWORD dwTextColor) {
    handle->SetItemTextColor(dwTextColor);
}

DIRECTUILIB_API void Delphi_ListUI_SetItemBkColor(CListUI* handle ,DWORD dwBkColor) {
    handle->SetItemBkColor(dwBkColor);
}

DIRECTUILIB_API void Delphi_ListUI_SetItemBkImage(CListUI* handle ,LPCTSTR pStrImage) {
    handle->SetItemBkImage(pStrImage);
}

DIRECTUILIB_API bool Delphi_ListUI_IsAlternateBk(CListUI* handle) {
    return handle->IsAlternateBk();
}

DIRECTUILIB_API void Delphi_ListUI_SetAlternateBk(CListUI* handle ,bool bAlternateBk) {
    handle->SetAlternateBk(bAlternateBk);
}

DIRECTUILIB_API void Delphi_ListUI_SetSelectedItemTextColor(CListUI* handle ,DWORD dwTextColor) {
    handle->SetSelectedItemTextColor(dwTextColor);
}

DIRECTUILIB_API void Delphi_ListUI_SetSelectedItemBkColor(CListUI* handle ,DWORD dwBkColor) {
    handle->SetSelectedItemBkColor(dwBkColor);
}

DIRECTUILIB_API void Delphi_ListUI_SetSelectedItemImage(CListUI* handle ,LPCTSTR pStrImage) {
    handle->SetSelectedItemImage(pStrImage);
}

DIRECTUILIB_API void Delphi_ListUI_SetHotItemTextColor(CListUI* handle ,DWORD dwTextColor) {
    handle->SetHotItemTextColor(dwTextColor);
}

DIRECTUILIB_API void Delphi_ListUI_SetHotItemBkColor(CListUI* handle ,DWORD dwBkColor) {
    handle->SetHotItemBkColor(dwBkColor);
}

DIRECTUILIB_API void Delphi_ListUI_SetHotItemImage(CListUI* handle ,LPCTSTR pStrImage) {
    handle->SetHotItemImage(pStrImage);
}

DIRECTUILIB_API void Delphi_ListUI_SetDisabledItemTextColor(CListUI* handle ,DWORD dwTextColor) {
    handle->SetDisabledItemTextColor(dwTextColor);
}

DIRECTUILIB_API void Delphi_ListUI_SetDisabledItemBkColor(CListUI* handle ,DWORD dwBkColor) {
    handle->SetDisabledItemBkColor(dwBkColor);
}

DIRECTUILIB_API void Delphi_ListUI_SetDisabledItemImage(CListUI* handle ,LPCTSTR pStrImage) {
    handle->SetDisabledItemImage(pStrImage);
}

DIRECTUILIB_API void Delphi_ListUI_SetItemLineColor(CListUI* handle ,DWORD dwLineColor) {
    handle->SetItemLineColor(dwLineColor);
}

DIRECTUILIB_API bool Delphi_ListUI_IsItemShowHtml(CListUI* handle) {
    return handle->IsItemShowHtml();
}

DIRECTUILIB_API void Delphi_ListUI_SetItemShowHtml(CListUI* handle ,bool bShowHtml) {
    handle->SetItemShowHtml(bShowHtml);
}

DIRECTUILIB_API void Delphi_ListUI_GetItemTextPadding(CListUI* handle, RECT& Result) {
    Result = handle->GetItemTextPadding();
}

DIRECTUILIB_API DWORD Delphi_ListUI_GetItemTextColor(CListUI* handle) {
    return handle->GetItemTextColor();
}

DIRECTUILIB_API DWORD Delphi_ListUI_GetItemBkColor(CListUI* handle) {
    return handle->GetItemBkColor();
}

DIRECTUILIB_API LPCTSTR Delphi_ListUI_GetItemBkImage(CListUI* handle) {
    return handle->GetItemBkImage();
}

DIRECTUILIB_API DWORD Delphi_ListUI_GetSelectedItemTextColor(CListUI* handle) {
    return handle->GetSelectedItemTextColor();
}

DIRECTUILIB_API DWORD Delphi_ListUI_GetSelectedItemBkColor(CListUI* handle) {
    return handle->GetSelectedItemBkColor();
}

DIRECTUILIB_API LPCTSTR Delphi_ListUI_GetSelectedItemImage(CListUI* handle) {
    return handle->GetSelectedItemImage();
}

DIRECTUILIB_API DWORD Delphi_ListUI_GetHotItemTextColor(CListUI* handle) {
    return handle->GetHotItemTextColor();
}

DIRECTUILIB_API DWORD Delphi_ListUI_GetHotItemBkColor(CListUI* handle) {
    return handle->GetHotItemBkColor();
}

DIRECTUILIB_API LPCTSTR Delphi_ListUI_GetHotItemImage(CListUI* handle) {
    return handle->GetHotItemImage();
}

DIRECTUILIB_API DWORD Delphi_ListUI_GetDisabledItemTextColor(CListUI* handle) {
    return handle->GetDisabledItemTextColor();
}

DIRECTUILIB_API DWORD Delphi_ListUI_GetDisabledItemBkColor(CListUI* handle) {
    return handle->GetDisabledItemBkColor();
}

DIRECTUILIB_API LPCTSTR Delphi_ListUI_GetDisabledItemImage(CListUI* handle) {
    return handle->GetDisabledItemImage();
}

DIRECTUILIB_API DWORD Delphi_ListUI_GetItemLineColor(CListUI* handle) {
    return handle->GetItemLineColor();
}

DIRECTUILIB_API void Delphi_ListUI_SetMultiExpanding(CListUI* handle ,bool bMultiExpandable) {
    handle->SetMultiExpanding(bMultiExpandable);
}

DIRECTUILIB_API int Delphi_ListUI_GetExpandedItem(CListUI* handle) {
    return handle->GetExpandedItem();
}

DIRECTUILIB_API bool Delphi_ListUI_ExpandItem(CListUI* handle ,int iIndex, bool bExpand) {
    return handle->ExpandItem(iIndex, bExpand);
}

DIRECTUILIB_API void Delphi_ListUI_SetPos(CListUI* handle ,RECT rc, bool bNeedInvalidate) {
    handle->SetPos(rc, bNeedInvalidate);
}

DIRECTUILIB_API void Delphi_ListUI_Move(CListUI* handle ,SIZE szOffset, bool bNeedInvalidate) {
    handle->Move(szOffset, bNeedInvalidate);
}

DIRECTUILIB_API void Delphi_ListUI_DoEvent(CListUI* handle ,TEventUI& event) {
    handle->DoEvent(event);
}

DIRECTUILIB_API void Delphi_ListUI_SetAttribute(CListUI* handle ,LPCTSTR pstrName, LPCTSTR pstrValue) {
    handle->SetAttribute(pstrName, pstrValue);
}

DIRECTUILIB_API IListCallbackUI* Delphi_ListUI_GetTextCallback(CListUI* handle) {
    return handle->GetTextCallback();
}

DIRECTUILIB_API void Delphi_ListUI_SetTextCallback(CListUI* handle ,IListCallbackUI* pCallback) {
    handle->SetTextCallback(pCallback);
}

DIRECTUILIB_API void Delphi_ListUI_GetScrollPos(CListUI* handle, SIZE& Result) {
    Result = handle->GetScrollPos();
}

DIRECTUILIB_API void Delphi_ListUI_GetScrollRange(CListUI* handle, SIZE& Result) {
    Result = handle->GetScrollRange();
}

DIRECTUILIB_API void Delphi_ListUI_SetScrollPos(CListUI* handle ,SIZE szPos) {
    handle->SetScrollPos(szPos);
}

DIRECTUILIB_API void Delphi_ListUI_LineUp(CListUI* handle) {
    handle->LineUp();
}

DIRECTUILIB_API void Delphi_ListUI_LineDown(CListUI* handle) {
    handle->LineDown();
}

DIRECTUILIB_API void Delphi_ListUI_PageUp(CListUI* handle) {
    handle->PageUp();
}

DIRECTUILIB_API void Delphi_ListUI_PageDown(CListUI* handle) {
    handle->PageDown();
}

DIRECTUILIB_API void Delphi_ListUI_HomeUp(CListUI* handle) {
    handle->HomeUp();
}

DIRECTUILIB_API void Delphi_ListUI_EndDown(CListUI* handle) {
    handle->EndDown();
}

DIRECTUILIB_API void Delphi_ListUI_LineLeft(CListUI* handle) {
    handle->LineLeft();
}

DIRECTUILIB_API void Delphi_ListUI_LineRight(CListUI* handle) {
    handle->LineRight();
}

DIRECTUILIB_API void Delphi_ListUI_PageLeft(CListUI* handle) {
    handle->PageLeft();
}

DIRECTUILIB_API void Delphi_ListUI_PageRight(CListUI* handle) {
    handle->PageRight();
}

DIRECTUILIB_API void Delphi_ListUI_HomeLeft(CListUI* handle) {
    handle->HomeLeft();
}

DIRECTUILIB_API void Delphi_ListUI_EndRight(CListUI* handle) {
    handle->EndRight();
}

DIRECTUILIB_API void Delphi_ListUI_EnableScrollBar(CListUI* handle ,bool bEnableVertical, bool bEnableHorizontal) {
    handle->EnableScrollBar(bEnableVertical, bEnableHorizontal);
}

DIRECTUILIB_API CScrollBarUI* Delphi_ListUI_GetVerticalScrollBar(CListUI* handle) {
    return handle->GetVerticalScrollBar();
}

DIRECTUILIB_API CScrollBarUI* Delphi_ListUI_GetHorizontalScrollBar(CListUI* handle) {
    return handle->GetHorizontalScrollBar();
}

DIRECTUILIB_API BOOL Delphi_ListUI_SortItems(CListUI* handle ,PULVCompareFunc pfnCompare, UINT_PTR dwData) {
    return handle->SortItems(pfnCompare, dwData);
}

//================================CDelphi_ListUI============================

DIRECTUILIB_API CDelphi_ListUI* Delphi_Delphi_ListUI_CppCreate() {
    return new CDelphi_ListUI();
}

DIRECTUILIB_API void Delphi_Delphi_ListUI_CppDestroy(CDelphi_ListUI* handle) {
    delete handle;
}

DIRECTUILIB_API void Delphi_Delphi_ListUI_SetDelphiSelf(CDelphi_ListUI* handle ,LPVOID ASelf) {
    handle->SetDelphiSelf(ASelf);
}

DIRECTUILIB_API void Delphi_Delphi_ListUI_SetDoEvent(CDelphi_ListUI* handle ,DoEventCallBack ADoEvent) {
    handle->SetDoEvent(ADoEvent);
}

//================================CLabelUI============================

DIRECTUILIB_API CLabelUI* Delphi_LabelUI_CppCreate() {
    return new CLabelUI();
}

DIRECTUILIB_API void Delphi_LabelUI_CppDestroy(CLabelUI* handle) {
    delete handle;
}

DIRECTUILIB_API LPCTSTR Delphi_LabelUI_GetClass(CLabelUI* handle) {
    return handle->GetClass();
}

DIRECTUILIB_API void Delphi_LabelUI_SetText(CLabelUI* handle, LPCTSTR pstrText) {
	handle->SetText(pstrText);
}

DIRECTUILIB_API LPVOID Delphi_LabelUI_GetInterface(CLabelUI* handle ,LPCTSTR pstrName) {
    return handle->GetInterface(pstrName);
}

DIRECTUILIB_API void Delphi_LabelUI_SetTextStyle(CLabelUI* handle ,UINT uStyle) {
    handle->SetTextStyle(uStyle);
}

DIRECTUILIB_API UINT Delphi_LabelUI_GetTextStyle(CLabelUI* handle) {
    return handle->GetTextStyle();
}

DIRECTUILIB_API void Delphi_LabelUI_SetTextColor(CLabelUI* handle ,DWORD dwTextColor) {
    handle->SetTextColor(dwTextColor);
}

DIRECTUILIB_API DWORD Delphi_LabelUI_GetTextColor(CLabelUI* handle) {
    return handle->GetTextColor();
}

DIRECTUILIB_API void Delphi_LabelUI_SetDisabledTextColor(CLabelUI* handle ,DWORD dwTextColor) {
    handle->SetDisabledTextColor(dwTextColor);
}

DIRECTUILIB_API DWORD Delphi_LabelUI_GetDisabledTextColor(CLabelUI* handle) {
    return handle->GetDisabledTextColor();
}

DIRECTUILIB_API void Delphi_LabelUI_SetFont(CLabelUI* handle ,int index) {
    handle->SetFont(index);
}

DIRECTUILIB_API int Delphi_LabelUI_GetFont(CLabelUI* handle) {
    return handle->GetFont();
}

DIRECTUILIB_API void Delphi_LabelUI_GetTextPadding(CLabelUI* handle, RECT& Result) {
    Result = handle->GetTextPadding();
}

DIRECTUILIB_API void Delphi_LabelUI_SetTextPadding(CLabelUI* handle ,RECT rc) {
    handle->SetTextPadding(rc);
}

DIRECTUILIB_API bool Delphi_LabelUI_IsShowHtml(CLabelUI* handle) {
    return handle->IsShowHtml();
}

DIRECTUILIB_API void Delphi_LabelUI_SetShowHtml(CLabelUI* handle ,bool bShowHtml) {
    handle->SetShowHtml(bShowHtml);
}

DIRECTUILIB_API void Delphi_LabelUI_EstimateSize(CLabelUI* handle ,SIZE szAvailable, SIZE& Result) {
    Result = handle->EstimateSize(szAvailable);
}

DIRECTUILIB_API void Delphi_LabelUI_DoEvent(CLabelUI* handle ,TEventUI& event) {
    handle->DoEvent(event);
}

DIRECTUILIB_API void Delphi_LabelUI_SetAttribute(CLabelUI* handle ,LPCTSTR pstrName, LPCTSTR pstrValue) {
    handle->SetAttribute(pstrName, pstrValue);
}

DIRECTUILIB_API void Delphi_LabelUI_PaintText(CLabelUI* handle ,HDC hDC) {
    handle->PaintText(hDC);
}

DIRECTUILIB_API void Delphi_LabelUI_SetEnabledEffect(CLabelUI* handle ,bool _EnabledEffect) {
    handle->SetEnabledEffect(_EnabledEffect);
}

DIRECTUILIB_API bool Delphi_LabelUI_GetEnabledEffect(CLabelUI* handle) {
    return handle->GetEnabledEffect();
}

DIRECTUILIB_API void Delphi_LabelUI_SetEnabledLuminous(CLabelUI* handle, bool bEnableLuminous) {
	handle->SetEnabledLuminous(bEnableLuminous);
}

DIRECTUILIB_API bool Delphi_LabelUI_GetEnabledLuminous(CLabelUI* handle) {
	return handle->GetEnabledLuminous();
}

DIRECTUILIB_API void Delphi_LabelUI_SetLuminousFuzzy(CLabelUI* handle, float fFuzzy) {
	handle->SetLuminousFuzzy(fFuzzy);
}

DIRECTUILIB_API float Delphi_LabelUI_GetLuminousFuzzy(CLabelUI* handle) {
	return handle->GetLuminousFuzzy();
}

DIRECTUILIB_API void Delphi_LabelUI_SetGradientLength(CLabelUI* handle ,int _GradientLength) {
    handle->SetGradientLength(_GradientLength);
}

DIRECTUILIB_API int Delphi_LabelUI_GetGradientLength(CLabelUI* handle) {
    return handle->GetGradientLength();
}

DIRECTUILIB_API void Delphi_LabelUI_SetShadowOffset(CLabelUI* handle ,int _offset, int _angle) {
    handle->SetShadowOffset(_offset, _angle);
}

DIRECTUILIB_API void Delphi_LabelUI_GetShadowOffset(CLabelUI* handle, RectF& Result) {
    Result = handle->GetShadowOffset();
}

DIRECTUILIB_API void Delphi_LabelUI_SetTextColor1(CLabelUI* handle ,DWORD _TextColor1) {
    handle->SetTextColor1(_TextColor1);
}

DIRECTUILIB_API DWORD Delphi_LabelUI_GetTextColor1(CLabelUI* handle) {
    return handle->GetTextColor1();
}

DIRECTUILIB_API void Delphi_LabelUI_SetTextShadowColorA(CLabelUI* handle ,DWORD _TextShadowColorA) {
    handle->SetTextShadowColorA(_TextShadowColorA);
}

DIRECTUILIB_API DWORD Delphi_LabelUI_GetTextShadowColorA(CLabelUI* handle) {
    return handle->GetTextShadowColorA();
}

DIRECTUILIB_API void Delphi_LabelUI_SetTextShadowColorB(CLabelUI* handle ,DWORD _TextShadowColorB) {
    handle->SetTextShadowColorB(_TextShadowColorB);
}

DIRECTUILIB_API DWORD Delphi_LabelUI_GetTextShadowColorB(CLabelUI* handle) {
    return handle->GetTextShadowColorB();
}

DIRECTUILIB_API void Delphi_LabelUI_SetStrokeColor(CLabelUI* handle ,DWORD _StrokeColor) {
    handle->SetStrokeColor(_StrokeColor);
}

DIRECTUILIB_API DWORD Delphi_LabelUI_GetStrokeColor(CLabelUI* handle) {
    return handle->GetStrokeColor();
}

DIRECTUILIB_API void Delphi_LabelUI_SetGradientAngle(CLabelUI* handle ,int _SetGradientAngle) {
    handle->SetGradientAngle(_SetGradientAngle);
}

DIRECTUILIB_API int Delphi_LabelUI_GetGradientAngle(CLabelUI* handle) {
    return handle->GetGradientAngle();
}

DIRECTUILIB_API void Delphi_LabelUI_SetEnabledStroke(CLabelUI* handle ,bool _EnabledStroke) {
    handle->SetEnabledStroke(_EnabledStroke);
}

DIRECTUILIB_API bool Delphi_LabelUI_GetEnabledStroke(CLabelUI* handle) {
    return handle->GetEnabledStroke();
}

DIRECTUILIB_API void Delphi_LabelUI_SetEnabledShadow(CLabelUI* handle ,bool _EnabledShadowe) {
    handle->SetEnabledShadow(_EnabledShadowe);
}

DIRECTUILIB_API bool Delphi_LabelUI_GetEnabledShadow(CLabelUI* handle) {
    return handle->GetEnabledShadow();
}

//================================CButtonUI============================

DIRECTUILIB_API CButtonUI* Delphi_ButtonUI_CppCreate() {
    return new CButtonUI();
}

DIRECTUILIB_API void Delphi_ButtonUI_CppDestroy(CButtonUI* handle) {
    delete handle;
}

DIRECTUILIB_API LPCTSTR Delphi_ButtonUI_GetClass(CButtonUI* handle) {
    return handle->GetClass();
}

DIRECTUILIB_API LPVOID Delphi_ButtonUI_GetInterface(CButtonUI* handle ,LPCTSTR pstrName) {
    return handle->GetInterface(pstrName);
}

DIRECTUILIB_API UINT Delphi_ButtonUI_GetControlFlags(CButtonUI* handle) {
    return handle->GetControlFlags();
}

DIRECTUILIB_API bool Delphi_ButtonUI_Activate(CButtonUI* handle) {
    return handle->Activate();
}

DIRECTUILIB_API void Delphi_ButtonUI_SetEnabled(CButtonUI* handle ,bool bEnable) {
    handle->SetEnabled(bEnable);
}

DIRECTUILIB_API void Delphi_ButtonUI_DoEvent(CButtonUI* handle ,TEventUI& event) {
    handle->DoEvent(event);
}

DIRECTUILIB_API LPCTSTR Delphi_ButtonUI_GetNormalImage(CButtonUI* handle) {
    return handle->GetNormalImage();
}

DIRECTUILIB_API void Delphi_ButtonUI_SetNormalImage(CButtonUI* handle ,LPCTSTR pStrImage) {
    handle->SetNormalImage(pStrImage);
}

DIRECTUILIB_API LPCTSTR Delphi_ButtonUI_GetHotImage(CButtonUI* handle) {
    return handle->GetHotImage();
}

DIRECTUILIB_API void Delphi_ButtonUI_SetHotImage(CButtonUI* handle ,LPCTSTR pStrImage) {
    handle->SetHotImage(pStrImage);
}

DIRECTUILIB_API LPCTSTR Delphi_ButtonUI_GetPushedImage(CButtonUI* handle) {
    return handle->GetPushedImage();
}

DIRECTUILIB_API void Delphi_ButtonUI_SetPushedImage(CButtonUI* handle ,LPCTSTR pStrImage) {
    handle->SetPushedImage(pStrImage);
}

DIRECTUILIB_API LPCTSTR Delphi_ButtonUI_GetFocusedImage(CButtonUI* handle) {
    return handle->GetFocusedImage();
}

DIRECTUILIB_API void Delphi_ButtonUI_SetFocusedImage(CButtonUI* handle ,LPCTSTR pStrImage) {
    handle->SetFocusedImage(pStrImage);
}

DIRECTUILIB_API LPCTSTR Delphi_ButtonUI_GetDisabledImage(CButtonUI* handle) {
    return handle->GetDisabledImage();
}

DIRECTUILIB_API void Delphi_ButtonUI_SetDisabledImage(CButtonUI* handle ,LPCTSTR pStrImage) {
    handle->SetDisabledImage(pStrImage);
}

DIRECTUILIB_API LPCTSTR Delphi_ButtonUI_GetForeImage(CButtonUI* handle) {
    return handle->GetForeImage();
}

DIRECTUILIB_API void Delphi_ButtonUI_SetForeImage(CButtonUI* handle ,LPCTSTR pStrImage) {
    handle->SetForeImage(pStrImage);
}

DIRECTUILIB_API LPCTSTR Delphi_ButtonUI_GetHotForeImage(CButtonUI* handle) {
    return handle->GetHotForeImage();
}

DIRECTUILIB_API void Delphi_ButtonUI_SetHotForeImage(CButtonUI* handle ,LPCTSTR pStrImage) {
    handle->SetHotForeImage(pStrImage);
}

DIRECTUILIB_API void Delphi_ButtonUI_SetHotBkColor(CButtonUI* handle ,DWORD dwColor) {
    handle->SetHotBkColor(dwColor);
}

DIRECTUILIB_API DWORD Delphi_ButtonUI_GetHotBkColor(CButtonUI* handle) {
    return handle->GetHotBkColor();
}

DIRECTUILIB_API void Delphi_ButtonUI_SetHotTextColor(CButtonUI* handle ,DWORD dwColor) {
    handle->SetHotTextColor(dwColor);
}

DIRECTUILIB_API DWORD Delphi_ButtonUI_GetHotTextColor(CButtonUI* handle) {
    return handle->GetHotTextColor();
}

DIRECTUILIB_API void Delphi_ButtonUI_SetPushedTextColor(CButtonUI* handle ,DWORD dwColor) {
    handle->SetPushedTextColor(dwColor);
}

DIRECTUILIB_API DWORD Delphi_ButtonUI_GetPushedTextColor(CButtonUI* handle) {
    return handle->GetPushedTextColor();
}

DIRECTUILIB_API void Delphi_ButtonUI_SetFocusedTextColor(CButtonUI* handle ,DWORD dwColor) {
    handle->SetFocusedTextColor(dwColor);
}

DIRECTUILIB_API DWORD Delphi_ButtonUI_GetFocusedTextColor(CButtonUI* handle) {
    return handle->GetFocusedTextColor();
}

DIRECTUILIB_API void Delphi_ButtonUI_EstimateSize(CButtonUI* handle ,SIZE szAvailable, SIZE& Result) {
    Result = handle->EstimateSize(szAvailable);
}

DIRECTUILIB_API void Delphi_ButtonUI_SetAttribute(CButtonUI* handle ,LPCTSTR pstrName, LPCTSTR pstrValue) {
    handle->SetAttribute(pstrName, pstrValue);
}

DIRECTUILIB_API void Delphi_ButtonUI_PaintText(CButtonUI* handle ,HDC hDC) {
    handle->PaintText(hDC);
}

DIRECTUILIB_API void Delphi_ButtonUI_PaintStatusImage(CButtonUI* handle ,HDC hDC) {
    handle->PaintStatusImage(hDC);
}

DIRECTUILIB_API void Delphi_ButtonUI_SetFiveStatusImage(CButtonUI* handle, LPCTSTR pStrImage) {
	handle->SetFiveStatusImage(pStrImage);
}

DIRECTUILIB_API void Delphi_ButtonUI_SetFadeAlphaDelta(CButtonUI* handle, BYTE uDelta) {
	handle->SetFadeAlphaDelta(uDelta);
}

DIRECTUILIB_API bool Delphi_ButtonUI_GetFadeAlphaDelta(CButtonUI* handle) {
	return handle->GetFadeAlphaDelta();
}

//================================COptionUI============================

DIRECTUILIB_API COptionUI* Delphi_OptionUI_CppCreate() {
    return new COptionUI();
}

DIRECTUILIB_API void Delphi_OptionUI_CppDestroy(COptionUI* handle) {
    delete handle;
}

DIRECTUILIB_API LPCTSTR Delphi_OptionUI_GetClass(COptionUI* handle) {
    return handle->GetClass();
}

DIRECTUILIB_API LPVOID Delphi_OptionUI_GetInterface(COptionUI* handle ,LPCTSTR pstrName) {
    return handle->GetInterface(pstrName);
}

DIRECTUILIB_API void Delphi_OptionUI_SetManager(COptionUI* handle ,CPaintManagerUI* pManager, CControlUI* pParent, bool bInit) {
    handle->SetManager(pManager, pParent, bInit);
}

DIRECTUILIB_API bool Delphi_OptionUI_Activate(COptionUI* handle) {
    return handle->Activate();
}

DIRECTUILIB_API void Delphi_OptionUI_SetEnabled(COptionUI* handle ,bool bEnable) {
    handle->SetEnabled(bEnable);
}

DIRECTUILIB_API LPCTSTR Delphi_OptionUI_GetSelectedImage(COptionUI* handle) {
    return handle->GetSelectedImage();
}

DIRECTUILIB_API void Delphi_OptionUI_SetSelectedImage(COptionUI* handle ,LPCTSTR pStrImage) {
    handle->SetSelectedImage(pStrImage);
}

DIRECTUILIB_API LPCTSTR Delphi_OptionUI_GetSelectedHotImage(COptionUI* handle) {
    return handle->GetSelectedHotImage();
}

DIRECTUILIB_API void Delphi_OptionUI_SetSelectedHotImage(COptionUI* handle ,LPCTSTR pStrImage) {
    handle->SetSelectedHotImage(pStrImage);
}

DIRECTUILIB_API void Delphi_OptionUI_SetSelectedTextColor(COptionUI* handle ,DWORD dwTextColor) {
    handle->SetSelectedTextColor(dwTextColor);
}

DIRECTUILIB_API DWORD Delphi_OptionUI_GetSelectedTextColor(COptionUI* handle) {
    return handle->GetSelectedTextColor();
}

DIRECTUILIB_API void Delphi_OptionUI_SetSelectedBkColor(COptionUI* handle ,DWORD dwBkColor) {
    handle->SetSelectedBkColor(dwBkColor);
}

DIRECTUILIB_API DWORD Delphi_OptionUI_GetSelectBkColor(COptionUI* handle) {
    return handle->GetSelectBkColor();
}

DIRECTUILIB_API LPCTSTR Delphi_OptionUI_GetForeImage(COptionUI* handle) {
    return handle->GetForeImage();
}

DIRECTUILIB_API void Delphi_OptionUI_SetForeImage(COptionUI* handle ,LPCTSTR pStrImage) {
    handle->SetForeImage(pStrImage);
}

DIRECTUILIB_API LPCTSTR Delphi_OptionUI_GetGroup(COptionUI* handle) {
    return handle->GetGroup();
}

DIRECTUILIB_API void Delphi_OptionUI_SetGroup(COptionUI* handle ,LPCTSTR pStrGroupName) {
    handle->SetGroup(pStrGroupName);
}

DIRECTUILIB_API bool Delphi_OptionUI_IsSelected(COptionUI* handle) {
    return handle->IsSelected();
}

DIRECTUILIB_API void Delphi_OptionUI_Selected(COptionUI* handle, bool bSelected, bool bTriggerEvent) {
	handle->Selected(bSelected, bTriggerEvent);
}

DIRECTUILIB_API void Delphi_OptionUI_EstimateSize(COptionUI* handle ,SIZE szAvailable, SIZE& Result) {
    Result = handle->EstimateSize(szAvailable);
}

DIRECTUILIB_API void Delphi_OptionUI_SetAttribute(COptionUI* handle ,LPCTSTR pstrName, LPCTSTR pstrValue) {
    handle->SetAttribute(pstrName, pstrValue);
}

DIRECTUILIB_API void Delphi_OptionUI_PaintStatusImage(COptionUI* handle ,HDC hDC) {
    handle->PaintStatusImage(hDC);
}

DIRECTUILIB_API void Delphi_OptionUI_PaintText(COptionUI* handle ,HDC hDC) {
    handle->PaintText(hDC);
}

//================================CCheckBoxUI============================

DIRECTUILIB_API CCheckBoxUI* Delphi_CheckBoxUI_CppCreate() {
    return new CCheckBoxUI();
}

DIRECTUILIB_API void Delphi_CheckBoxUI_CppDestroy(CCheckBoxUI* handle) {
    delete handle;
}

DIRECTUILIB_API LPCTSTR Delphi_CheckBoxUI_GetClass(CCheckBoxUI* handle) {
    return handle->GetClass();
}

DIRECTUILIB_API LPVOID Delphi_CheckBoxUI_GetInterface(CCheckBoxUI* handle ,LPCTSTR pstrName) {
    return handle->GetInterface(pstrName);
}

DIRECTUILIB_API void Delphi_CheckBoxUI_SetCheck(CCheckBoxUI* handle, bool bCheck, bool bTriggerEvent) {
	handle->SetCheck(bCheck, bTriggerEvent);
}

DIRECTUILIB_API bool Delphi_CheckBoxUI_GetCheck(CCheckBoxUI* handle) {
    return handle->GetCheck();
}

//================================CListContainerElementUI============================

DIRECTUILIB_API CListContainerElementUI* Delphi_ListContainerElementUI_CppCreate() {
    return new CListContainerElementUI();
}

DIRECTUILIB_API void Delphi_ListContainerElementUI_CppDestroy(CListContainerElementUI* handle) {
    delete handle;
}

DIRECTUILIB_API LPCTSTR Delphi_ListContainerElementUI_GetClass(CListContainerElementUI* handle) {
    return handle->GetClass();
}

DIRECTUILIB_API UINT Delphi_ListContainerElementUI_GetControlFlags(CListContainerElementUI* handle) {
    return handle->GetControlFlags();
}

DIRECTUILIB_API LPVOID Delphi_ListContainerElementUI_GetInterface(CListContainerElementUI* handle ,LPCTSTR pstrName) {
    return handle->GetInterface(pstrName);
}

DIRECTUILIB_API int Delphi_ListContainerElementUI_GetIndex(CListContainerElementUI* handle) {
    return handle->GetIndex();
}

DIRECTUILIB_API void Delphi_ListContainerElementUI_SetIndex(CListContainerElementUI* handle ,int iIndex) {
    handle->SetIndex(iIndex);
}

DIRECTUILIB_API IListOwnerUI* Delphi_ListContainerElementUI_GetOwner(CListContainerElementUI* handle) {
    return handle->GetOwner();
}

DIRECTUILIB_API void Delphi_ListContainerElementUI_SetOwner(CListContainerElementUI* handle ,CControlUI* pOwner) {
    handle->SetOwner(pOwner);
}

DIRECTUILIB_API void Delphi_ListContainerElementUI_SetVisible(CListContainerElementUI* handle ,bool bVisible) {
    handle->SetVisible(bVisible);
}

DIRECTUILIB_API void Delphi_ListContainerElementUI_SetEnabled(CListContainerElementUI* handle ,bool bEnable) {
    handle->SetEnabled(bEnable);
}

DIRECTUILIB_API bool Delphi_ListContainerElementUI_IsSelected(CListContainerElementUI* handle) {
    return handle->IsSelected();
}

DIRECTUILIB_API bool Delphi_ListContainerElementUI_Select(CListContainerElementUI* handle ,bool bSelect) {
    return handle->Select(bSelect);
}

DIRECTUILIB_API bool Delphi_ListContainerElementUI_IsExpanded(CListContainerElementUI* handle) {
    return handle->IsExpanded();
}

DIRECTUILIB_API bool Delphi_ListContainerElementUI_Expand(CListContainerElementUI* handle ,bool bExpand) {
    return handle->Expand(bExpand);
}

DIRECTUILIB_API void Delphi_ListContainerElementUI_Invalidate(CListContainerElementUI* handle) {
    handle->Invalidate();
}

DIRECTUILIB_API bool Delphi_ListContainerElementUI_Activate(CListContainerElementUI* handle) {
    return handle->Activate();
}

DIRECTUILIB_API void Delphi_ListContainerElementUI_DoEvent(CListContainerElementUI* handle ,TEventUI& event) {
    handle->DoEvent(event);
}

DIRECTUILIB_API void Delphi_ListContainerElementUI_SetAttribute(CListContainerElementUI* handle ,LPCTSTR pstrName, LPCTSTR pstrValue) {
    handle->SetAttribute(pstrName, pstrValue);
}

DIRECTUILIB_API void Delphi_ListContainerElementUI_DoPaint(CListContainerElementUI* handle ,HDC hDC, RECT& rcPaint) {
    handle->DoPaint(hDC, rcPaint);
}

DIRECTUILIB_API void Delphi_ListContainerElementUI_DrawItemText(CListContainerElementUI* handle ,HDC hDC, RECT& rcItem) {
    handle->DrawItemText(hDC, rcItem);
}

DIRECTUILIB_API void Delphi_ListContainerElementUI_DrawItemBk(CListContainerElementUI* handle ,HDC hDC, RECT& rcItem) {
    handle->DrawItemBk(hDC, rcItem);
}

//================================CComboUI============================

DIRECTUILIB_API CComboUI* Delphi_ComboUI_CppCreate() {
    return new CComboUI();
}

DIRECTUILIB_API void Delphi_ComboUI_CppDestroy(CComboUI* handle) {
    delete handle;
}

DIRECTUILIB_API LPCTSTR Delphi_ComboUI_GetClass(CComboUI* handle) {
    return handle->GetClass();
}

DIRECTUILIB_API LPVOID Delphi_ComboUI_GetInterface(CComboUI* handle ,LPCTSTR pstrName) {
    return handle->GetInterface(pstrName);
}

DIRECTUILIB_API void Delphi_ComboUI_DoInit(CComboUI* handle) {
    handle->DoInit();
}

DIRECTUILIB_API UINT Delphi_ComboUI_GetControlFlags(CComboUI* handle) {
    return handle->GetControlFlags();
}

DIRECTUILIB_API CDuiString Delphi_ComboUI_GetText(CComboUI* handle) {
    return handle->GetText();
}

DIRECTUILIB_API void Delphi_ComboUI_SetEnabled(CComboUI* handle ,bool bEnable) {
    handle->SetEnabled(bEnable);
}

DIRECTUILIB_API CDuiString Delphi_ComboUI_GetDropBoxAttributeList(CComboUI* handle) {
    return handle->GetDropBoxAttributeList();
}

DIRECTUILIB_API void Delphi_ComboUI_SetDropBoxAttributeList(CComboUI* handle ,LPCTSTR pstrList) {
    handle->SetDropBoxAttributeList(pstrList);
}

DIRECTUILIB_API void Delphi_ComboUI_GetDropBoxSize(CComboUI* handle, SIZE& Result) {
    Result = handle->GetDropBoxSize();
}

DIRECTUILIB_API void Delphi_ComboUI_SetDropBoxSize(CComboUI* handle ,SIZE szDropBox) {
    handle->SetDropBoxSize(szDropBox);
}

DIRECTUILIB_API int Delphi_ComboUI_GetCurSel(CComboUI* handle) {
    return handle->GetCurSel();
}

DIRECTUILIB_API bool Delphi_ComboUI_GetSelectCloseFlag(CComboUI* handle) {
    return handle->GetSelectCloseFlag();
}

DIRECTUILIB_API void Delphi_ComboUI_SetSelectCloseFlag(CComboUI* handle ,bool flag) {
    handle->SetSelectCloseFlag(flag);
}

DIRECTUILIB_API bool Delphi_ComboUI_SelectItem(CComboUI* handle, int iIndex, bool bTakeFocus, bool bTriggerEvent) {
	return handle->SelectItem(iIndex, bTakeFocus, bTriggerEvent);
}

DIRECTUILIB_API bool Delphi_ComboUI_SetItemIndex(CComboUI* handle ,CControlUI* pControl, int iIndex) {
    return handle->SetItemIndex(pControl, iIndex);
}

DIRECTUILIB_API bool Delphi_ComboUI_Add(CComboUI* handle ,CControlUI* pControl) {
    return handle->Add(pControl);
}

DIRECTUILIB_API bool Delphi_ComboUI_AddAt(CComboUI* handle ,CControlUI* pControl, int iIndex) {
    return handle->AddAt(pControl, iIndex);
}

DIRECTUILIB_API bool Delphi_ComboUI_Remove(CComboUI* handle ,CControlUI* pControl) {
    return handle->Remove(pControl);
}

DIRECTUILIB_API bool Delphi_ComboUI_RemoveAt(CComboUI* handle ,int iIndex) {
    return handle->RemoveAt(iIndex);
}

DIRECTUILIB_API void Delphi_ComboUI_RemoveAll(CComboUI* handle) {
    handle->RemoveAll();
}

DIRECTUILIB_API bool Delphi_ComboUI_Activate(CComboUI* handle) {
    return handle->Activate();
}

DIRECTUILIB_API bool Delphi_ComboUI_GetShowText(CComboUI* handle) {
    return handle->GetShowText();
}

DIRECTUILIB_API void Delphi_ComboUI_SetShowText(CComboUI* handle ,bool flag) {
    handle->SetShowText(flag);
}

DIRECTUILIB_API void Delphi_ComboUI_GetTextPadding(CComboUI* handle, RECT& Result) {
    Result = handle->GetTextPadding();
}

DIRECTUILIB_API void Delphi_ComboUI_SetTextPadding(CComboUI* handle ,RECT rc) {
    handle->SetTextPadding(rc);
}

DIRECTUILIB_API LPCTSTR Delphi_ComboUI_GetNormalImage(CComboUI* handle) {
    return handle->GetNormalImage();
}

DIRECTUILIB_API void Delphi_ComboUI_SetNormalImage(CComboUI* handle ,LPCTSTR pStrImage) {
    handle->SetNormalImage(pStrImage);
}

DIRECTUILIB_API LPCTSTR Delphi_ComboUI_GetHotImage(CComboUI* handle) {
    return handle->GetHotImage();
}

DIRECTUILIB_API void Delphi_ComboUI_SetHotImage(CComboUI* handle ,LPCTSTR pStrImage) {
    handle->SetHotImage(pStrImage);
}

DIRECTUILIB_API LPCTSTR Delphi_ComboUI_GetPushedImage(CComboUI* handle) {
    return handle->GetPushedImage();
}

DIRECTUILIB_API void Delphi_ComboUI_SetPushedImage(CComboUI* handle ,LPCTSTR pStrImage) {
    handle->SetPushedImage(pStrImage);
}

DIRECTUILIB_API LPCTSTR Delphi_ComboUI_GetFocusedImage(CComboUI* handle) {
    return handle->GetFocusedImage();
}

DIRECTUILIB_API void Delphi_ComboUI_SetFocusedImage(CComboUI* handle ,LPCTSTR pStrImage) {
    handle->SetFocusedImage(pStrImage);
}

DIRECTUILIB_API LPCTSTR Delphi_ComboUI_GetDisabledImage(CComboUI* handle) {
    return handle->GetDisabledImage();
}

DIRECTUILIB_API void Delphi_ComboUI_SetDisabledImage(CComboUI* handle ,LPCTSTR pStrImage) {
    handle->SetDisabledImage(pStrImage);
}

DIRECTUILIB_API TListInfoUI* Delphi_ComboUI_GetListInfo(CComboUI* handle) {
    return handle->GetListInfo();
}

DIRECTUILIB_API void Delphi_ComboUI_SetItemFont(CComboUI* handle ,int index) {
    handle->SetItemFont(index);
}

DIRECTUILIB_API void Delphi_ComboUI_SetItemTextStyle(CComboUI* handle ,UINT uStyle) {
    handle->SetItemTextStyle(uStyle);
}

DIRECTUILIB_API void Delphi_ComboUI_GetItemTextPadding(CComboUI* handle, RECT& Result) {
    Result = handle->GetItemTextPadding();
}

DIRECTUILIB_API void Delphi_ComboUI_SetItemTextPadding(CComboUI* handle ,RECT rc) {
    handle->SetItemTextPadding(rc);
}

DIRECTUILIB_API DWORD Delphi_ComboUI_GetItemTextColor(CComboUI* handle) {
    return handle->GetItemTextColor();
}

DIRECTUILIB_API void Delphi_ComboUI_SetItemTextColor(CComboUI* handle ,DWORD dwTextColor) {
    handle->SetItemTextColor(dwTextColor);
}

DIRECTUILIB_API DWORD Delphi_ComboUI_GetItemBkColor(CComboUI* handle) {
    return handle->GetItemBkColor();
}

DIRECTUILIB_API void Delphi_ComboUI_SetItemBkColor(CComboUI* handle ,DWORD dwBkColor) {
    handle->SetItemBkColor(dwBkColor);
}

DIRECTUILIB_API LPCTSTR Delphi_ComboUI_GetItemBkImage(CComboUI* handle) {
    return handle->GetItemBkImage();
}

DIRECTUILIB_API void Delphi_ComboUI_SetItemBkImage(CComboUI* handle ,LPCTSTR pStrImage) {
    handle->SetItemBkImage(pStrImage);
}

DIRECTUILIB_API bool Delphi_ComboUI_IsAlternateBk(CComboUI* handle) {
    return handle->IsAlternateBk();
}

DIRECTUILIB_API void Delphi_ComboUI_SetAlternateBk(CComboUI* handle ,bool bAlternateBk) {
    handle->SetAlternateBk(bAlternateBk);
}

DIRECTUILIB_API DWORD Delphi_ComboUI_GetSelectedItemTextColor(CComboUI* handle) {
    return handle->GetSelectedItemTextColor();
}

DIRECTUILIB_API void Delphi_ComboUI_SetSelectedItemTextColor(CComboUI* handle ,DWORD dwTextColor) {
    handle->SetSelectedItemTextColor(dwTextColor);
}

DIRECTUILIB_API DWORD Delphi_ComboUI_GetSelectedItemBkColor(CComboUI* handle) {
    return handle->GetSelectedItemBkColor();
}

DIRECTUILIB_API void Delphi_ComboUI_SetSelectedItemBkColor(CComboUI* handle ,DWORD dwBkColor) {
    handle->SetSelectedItemBkColor(dwBkColor);
}

DIRECTUILIB_API LPCTSTR Delphi_ComboUI_GetSelectedItemImage(CComboUI* handle) {
    return handle->GetSelectedItemImage();
}

DIRECTUILIB_API void Delphi_ComboUI_SetSelectedItemImage(CComboUI* handle ,LPCTSTR pStrImage) {
    handle->SetSelectedItemImage(pStrImage);
}

DIRECTUILIB_API DWORD Delphi_ComboUI_GetHotItemTextColor(CComboUI* handle) {
    return handle->GetHotItemTextColor();
}

DIRECTUILIB_API void Delphi_ComboUI_SetHotItemTextColor(CComboUI* handle ,DWORD dwTextColor) {
    handle->SetHotItemTextColor(dwTextColor);
}

DIRECTUILIB_API DWORD Delphi_ComboUI_GetHotItemBkColor(CComboUI* handle) {
    return handle->GetHotItemBkColor();
}

DIRECTUILIB_API void Delphi_ComboUI_SetHotItemBkColor(CComboUI* handle ,DWORD dwBkColor) {
    handle->SetHotItemBkColor(dwBkColor);
}

DIRECTUILIB_API LPCTSTR Delphi_ComboUI_GetHotItemImage(CComboUI* handle) {
    return handle->GetHotItemImage();
}

DIRECTUILIB_API void Delphi_ComboUI_SetHotItemImage(CComboUI* handle ,LPCTSTR pStrImage) {
    handle->SetHotItemImage(pStrImage);
}

DIRECTUILIB_API DWORD Delphi_ComboUI_GetDisabledItemTextColor(CComboUI* handle) {
    return handle->GetDisabledItemTextColor();
}

DIRECTUILIB_API void Delphi_ComboUI_SetDisabledItemTextColor(CComboUI* handle ,DWORD dwTextColor) {
    handle->SetDisabledItemTextColor(dwTextColor);
}

DIRECTUILIB_API DWORD Delphi_ComboUI_GetDisabledItemBkColor(CComboUI* handle) {
    return handle->GetDisabledItemBkColor();
}

DIRECTUILIB_API void Delphi_ComboUI_SetDisabledItemBkColor(CComboUI* handle ,DWORD dwBkColor) {
    handle->SetDisabledItemBkColor(dwBkColor);
}

DIRECTUILIB_API LPCTSTR Delphi_ComboUI_GetDisabledItemImage(CComboUI* handle) {
    return handle->GetDisabledItemImage();
}

DIRECTUILIB_API void Delphi_ComboUI_SetDisabledItemImage(CComboUI* handle ,LPCTSTR pStrImage) {
    handle->SetDisabledItemImage(pStrImage);
}

DIRECTUILIB_API DWORD Delphi_ComboUI_GetItemLineColor(CComboUI* handle) {
    return handle->GetItemLineColor();
}

DIRECTUILIB_API void Delphi_ComboUI_SetItemLineColor(CComboUI* handle ,DWORD dwLineColor) {
    handle->SetItemLineColor(dwLineColor);
}

DIRECTUILIB_API bool Delphi_ComboUI_IsItemShowHtml(CComboUI* handle) {
    return handle->IsItemShowHtml();
}

DIRECTUILIB_API void Delphi_ComboUI_SetItemShowHtml(CComboUI* handle ,bool bShowHtml) {
    handle->SetItemShowHtml(bShowHtml);
}

DIRECTUILIB_API void Delphi_ComboUI_EstimateSize(CComboUI* handle ,SIZE szAvailable, SIZE& Result) {
    Result = handle->EstimateSize(szAvailable);
}

DIRECTUILIB_API void Delphi_ComboUI_SetPos(CComboUI* handle ,RECT rc, bool bNeedInvalidate) {
    handle->SetPos(rc, bNeedInvalidate);
}

DIRECTUILIB_API void Delphi_ComboUI_Move(CComboUI* handle ,SIZE szOffset, bool bNeedInvalidate) {
    handle->Move(szOffset, bNeedInvalidate);
}

DIRECTUILIB_API void Delphi_ComboUI_DoEvent(CComboUI* handle ,TEventUI& event) {
    handle->DoEvent(event);
}

DIRECTUILIB_API void Delphi_ComboUI_SetAttribute(CComboUI* handle ,LPCTSTR pstrName, LPCTSTR pstrValue) {
    handle->SetAttribute(pstrName, pstrValue);
}

DIRECTUILIB_API void Delphi_ComboUI_DoPaint(CComboUI* handle ,HDC hDC, RECT& rcPaint) {
    handle->DoPaint(hDC, rcPaint);
}

DIRECTUILIB_API void Delphi_ComboUI_PaintText(CComboUI* handle ,HDC hDC) {
    handle->PaintText(hDC);
}

DIRECTUILIB_API void Delphi_ComboUI_PaintStatusImage(CComboUI* handle ,HDC hDC) {
    handle->PaintStatusImage(hDC);
}

//================================CDateTimeUI============================

DIRECTUILIB_API CDateTimeUI* Delphi_DateTimeUI_CppCreate() {
    return new CDateTimeUI();
}

DIRECTUILIB_API void Delphi_DateTimeUI_CppDestroy(CDateTimeUI* handle) {
    delete handle;
}

DIRECTUILIB_API LPCTSTR Delphi_DateTimeUI_GetClass(CDateTimeUI* handle) {
    return handle->GetClass();
}

DIRECTUILIB_API LPVOID Delphi_DateTimeUI_GetInterface(CDateTimeUI* handle ,LPCTSTR pstrName) {
    return handle->GetInterface(pstrName);
}

DIRECTUILIB_API UINT Delphi_DateTimeUI_GetControlFlags(CDateTimeUI* handle) {
	return handle->GetControlFlags();
}

DIRECTUILIB_API HWND Delphi_DateTimeUI_GetNativeWindow(CDateTimeUI* handle) {
	return handle->GetNativeWindow();
}

DIRECTUILIB_API SYSTEMTIME& Delphi_DateTimeUI_GetTime(CDateTimeUI* handle) {
    return handle->GetTime();
}

DIRECTUILIB_API void Delphi_DateTimeUI_SetTime(CDateTimeUI* handle ,SYSTEMTIME* pst) {
    handle->SetTime(pst);
}

DIRECTUILIB_API void Delphi_DateTimeUI_SetReadOnly(CDateTimeUI* handle ,bool bReadOnly) {
    handle->SetReadOnly(bReadOnly);
}

DIRECTUILIB_API bool Delphi_DateTimeUI_IsReadOnly(CDateTimeUI* handle) {
    return handle->IsReadOnly();
}

DIRECTUILIB_API void Delphi_DateTimeUI_UpdateText(CDateTimeUI* handle) {
    handle->UpdateText();
}

DIRECTUILIB_API void Delphi_DateTimeUI_DoEvent(CDateTimeUI* handle ,TEventUI& event) {
    handle->DoEvent(event);
}

//================================CEditUI============================

DIRECTUILIB_API CEditUI* Delphi_EditUI_CppCreate() {
    return new CEditUI();
}

DIRECTUILIB_API void Delphi_EditUI_CppDestroy(CEditUI* handle) {
    delete handle;
}

DIRECTUILIB_API LPCTSTR Delphi_EditUI_GetClass(CEditUI* handle) {
    return handle->GetClass();
}

DIRECTUILIB_API LPVOID Delphi_EditUI_GetInterface(CEditUI* handle ,LPCTSTR pstrName) {
    return handle->GetInterface(pstrName);
}

DIRECTUILIB_API UINT Delphi_EditUI_GetControlFlags(CEditUI* handle) {
    return handle->GetControlFlags();
}

DIRECTUILIB_API HWND Delphi_EditUI_GetNativeWindow(CEditUI* handle) {
	return handle->GetNativeWindow();
}

DIRECTUILIB_API void Delphi_EditUI_SetEnabled(CEditUI* handle ,bool bEnable) {
    handle->SetEnabled(bEnable);
}

DIRECTUILIB_API void Delphi_EditUI_SetText(CEditUI* handle ,LPCTSTR pstrText) {
    handle->SetText(pstrText);
}

DIRECTUILIB_API void Delphi_EditUI_SetMaxChar(CEditUI* handle ,UINT uMax) {
    handle->SetMaxChar(uMax);
}

DIRECTUILIB_API UINT Delphi_EditUI_GetMaxChar(CEditUI* handle) {
    return handle->GetMaxChar();
}

DIRECTUILIB_API void Delphi_EditUI_SetReadOnly(CEditUI* handle ,bool bReadOnly) {
    handle->SetReadOnly(bReadOnly);
}

DIRECTUILIB_API bool Delphi_EditUI_IsReadOnly(CEditUI* handle) {
    return handle->IsReadOnly();
}

DIRECTUILIB_API void Delphi_EditUI_SetPasswordMode(CEditUI* handle ,bool bPasswordMode) {
    handle->SetPasswordMode(bPasswordMode);
}

DIRECTUILIB_API bool Delphi_EditUI_IsPasswordMode(CEditUI* handle) {
    return handle->IsPasswordMode();
}

DIRECTUILIB_API void Delphi_EditUI_SetPasswordChar(CEditUI* handle ,TCHAR cPasswordChar) {
    handle->SetPasswordChar(cPasswordChar);
}

DIRECTUILIB_API TCHAR Delphi_EditUI_GetPasswordChar(CEditUI* handle) {
    return handle->GetPasswordChar();
}

DIRECTUILIB_API void Delphi_EditUI_SetNumberOnly(CEditUI* handle ,bool bNumberOnly) {
    handle->SetNumberOnly(bNumberOnly);
}

DIRECTUILIB_API bool Delphi_EditUI_IsNumberOnly(CEditUI* handle) {
    return handle->IsNumberOnly();
}

DIRECTUILIB_API int Delphi_EditUI_GetWindowStyls(CEditUI* handle) {
    return handle->GetWindowStyls();
}

DIRECTUILIB_API HWND Delphi_EditUI_GetNativeEditHWND(CEditUI* handle) {
    return handle->GetNativeEditHWND();
}

DIRECTUILIB_API LPCTSTR Delphi_EditUI_GetNormalImage(CEditUI* handle) {
    return handle->GetNormalImage();
}

DIRECTUILIB_API void Delphi_EditUI_SetNormalImage(CEditUI* handle ,LPCTSTR pStrImage) {
    handle->SetNormalImage(pStrImage);
}

DIRECTUILIB_API LPCTSTR Delphi_EditUI_GetHotImage(CEditUI* handle) {
    return handle->GetHotImage();
}

DIRECTUILIB_API void Delphi_EditUI_SetHotImage(CEditUI* handle ,LPCTSTR pStrImage) {
    handle->SetHotImage(pStrImage);
}

DIRECTUILIB_API LPCTSTR Delphi_EditUI_GetFocusedImage(CEditUI* handle) {
    return handle->GetFocusedImage();
}

DIRECTUILIB_API void Delphi_EditUI_SetFocusedImage(CEditUI* handle ,LPCTSTR pStrImage) {
    handle->SetFocusedImage(pStrImage);
}

DIRECTUILIB_API LPCTSTR Delphi_EditUI_GetDisabledImage(CEditUI* handle) {
    return handle->GetDisabledImage();
}

DIRECTUILIB_API void Delphi_EditUI_SetDisabledImage(CEditUI* handle ,LPCTSTR pStrImage) {
    handle->SetDisabledImage(pStrImage);
}

DIRECTUILIB_API void Delphi_EditUI_SetNativeEditBkColor(CEditUI* handle ,DWORD dwBkColor) {
    handle->SetNativeEditBkColor(dwBkColor);
}

DIRECTUILIB_API DWORD Delphi_EditUI_GetNativeEditBkColor(CEditUI* handle) {
    return handle->GetNativeEditBkColor();
}

DIRECTUILIB_API void Delphi_EditUI_SetSel(CEditUI* handle ,long nStartChar, long nEndChar) {
    handle->SetSel(nStartChar, nEndChar);
}

DIRECTUILIB_API void Delphi_EditUI_SetSelAll(CEditUI* handle) {
    handle->SetSelAll();
}

DIRECTUILIB_API void Delphi_EditUI_SetReplaceSel(CEditUI* handle ,LPCTSTR lpszReplace) {
    handle->SetReplaceSel(lpszReplace);
}

DIRECTUILIB_API void Delphi_EditUI_SetPos(CEditUI* handle ,RECT rc, bool bNeedInvalidate) {
    handle->SetPos(rc, bNeedInvalidate);
}

DIRECTUILIB_API void Delphi_EditUI_Move(CEditUI* handle ,SIZE szOffset, bool bNeedInvalidate) {
    handle->Move(szOffset, bNeedInvalidate);
}

DIRECTUILIB_API void Delphi_EditUI_SetVisible(CEditUI* handle ,bool bVisible) {
    handle->SetVisible(bVisible);
}

DIRECTUILIB_API void Delphi_EditUI_SetInternVisible(CEditUI* handle ,bool bVisible) {
    handle->SetInternVisible(bVisible);
}

DIRECTUILIB_API void Delphi_EditUI_EstimateSize(CEditUI* handle ,SIZE szAvailable, SIZE& Result) {
    Result = handle->EstimateSize(szAvailable);
}

DIRECTUILIB_API void Delphi_EditUI_DoEvent(CEditUI* handle ,TEventUI& event) {
    handle->DoEvent(event);
}

DIRECTUILIB_API void Delphi_EditUI_SetAttribute(CEditUI* handle ,LPCTSTR pstrName, LPCTSTR pstrValue) {
    handle->SetAttribute(pstrName, pstrValue);
}

DIRECTUILIB_API void Delphi_EditUI_PaintStatusImage(CEditUI* handle ,HDC hDC) {
    handle->PaintStatusImage(hDC);
}

DIRECTUILIB_API void Delphi_EditUI_PaintText(CEditUI* handle ,HDC hDC) {
    handle->PaintText(hDC);
}

//================================CProgressUI============================

DIRECTUILIB_API CProgressUI* Delphi_ProgressUI_CppCreate() {
    return new CProgressUI();
}

DIRECTUILIB_API void Delphi_ProgressUI_CppDestroy(CProgressUI* handle) {
    delete handle;
}

DIRECTUILIB_API LPCTSTR Delphi_ProgressUI_GetClass(CProgressUI* handle) {
    return handle->GetClass();
}

DIRECTUILIB_API LPVOID Delphi_ProgressUI_GetInterface(CProgressUI* handle ,LPCTSTR pstrName) {
    return handle->GetInterface(pstrName);
}

DIRECTUILIB_API bool Delphi_ProgressUI_IsHorizontal(CProgressUI* handle) {
    return handle->IsHorizontal();
}

DIRECTUILIB_API void Delphi_ProgressUI_SetHorizontal(CProgressUI* handle ,bool bHorizontal) {
    handle->SetHorizontal(bHorizontal);
}

DIRECTUILIB_API bool Delphi_ProgressUI_IsStretchForeImage(CProgressUI* handle) {
    return handle->IsStretchForeImage();
}

DIRECTUILIB_API void Delphi_ProgressUI_SetStretchForeImage(CProgressUI* handle ,bool bStretchForeImage) {
    handle->SetStretchForeImage(bStretchForeImage);
}

DIRECTUILIB_API int Delphi_ProgressUI_GetMinValue(CProgressUI* handle) {
    return handle->GetMinValue();
}

DIRECTUILIB_API void Delphi_ProgressUI_SetMinValue(CProgressUI* handle ,int nMin) {
    handle->SetMinValue(nMin);
}

DIRECTUILIB_API int Delphi_ProgressUI_GetMaxValue(CProgressUI* handle) {
    return handle->GetMaxValue();
}

DIRECTUILIB_API void Delphi_ProgressUI_SetMaxValue(CProgressUI* handle ,int nMax) {
    handle->SetMaxValue(nMax);
}

DIRECTUILIB_API int Delphi_ProgressUI_GetValue(CProgressUI* handle) {
    return handle->GetValue();
}

DIRECTUILIB_API void Delphi_ProgressUI_SetValue(CProgressUI* handle ,int nValue) {
    handle->SetValue(nValue);
}

DIRECTUILIB_API LPCTSTR Delphi_ProgressUI_GetForeImage(CProgressUI* handle) {
    return handle->GetForeImage();
}

DIRECTUILIB_API void Delphi_ProgressUI_SetForeImage(CProgressUI* handle ,LPCTSTR pStrImage) {
    handle->SetForeImage(pStrImage);
}

DIRECTUILIB_API void Delphi_ProgressUI_SetAttribute(CProgressUI* handle ,LPCTSTR pstrName, LPCTSTR pstrValue) {
    handle->SetAttribute(pstrName, pstrValue);
}

DIRECTUILIB_API void Delphi_ProgressUI_PaintStatusImage(CProgressUI* handle ,HDC hDC) {
    handle->PaintStatusImage(hDC);
}

//================================CRichEditUI============================

DIRECTUILIB_API CRichEditUI* Delphi_RichEditUI_CppCreate() {
    return new CRichEditUI();
}

DIRECTUILIB_API void Delphi_RichEditUI_CppDestroy(CRichEditUI* handle) {
    delete handle;
}

DIRECTUILIB_API LPCTSTR Delphi_RichEditUI_GetClass(CRichEditUI* handle) {
    return handle->GetClass();
}

DIRECTUILIB_API LPVOID Delphi_RichEditUI_GetInterface(CRichEditUI* handle ,LPCTSTR pstrName) {
    return handle->GetInterface(pstrName);
}

DIRECTUILIB_API UINT Delphi_RichEditUI_GetControlFlags(CRichEditUI* handle) {
    return handle->GetControlFlags();
}

DIRECTUILIB_API bool Delphi_RichEditUI_IsWantTab(CRichEditUI* handle) {
    return handle->IsWantTab();
}

DIRECTUILIB_API void Delphi_RichEditUI_SetWantTab(CRichEditUI* handle ,bool bWantTab) {
    handle->SetWantTab(bWantTab);
}

DIRECTUILIB_API bool Delphi_RichEditUI_IsWantReturn(CRichEditUI* handle) {
    return handle->IsWantReturn();
}

DIRECTUILIB_API void Delphi_RichEditUI_SetWantReturn(CRichEditUI* handle ,bool bWantReturn) {
    handle->SetWantReturn(bWantReturn);
}

DIRECTUILIB_API bool Delphi_RichEditUI_IsWantCtrlReturn(CRichEditUI* handle) {
    return handle->IsWantCtrlReturn();
}

DIRECTUILIB_API void Delphi_RichEditUI_SetWantCtrlReturn(CRichEditUI* handle ,bool bWantCtrlReturn) {
    handle->SetWantCtrlReturn(bWantCtrlReturn);
}

DIRECTUILIB_API bool Delphi_RichEditUI_IsTransparent(CRichEditUI* handle) {
	return handle->IsTransparent();
}

DIRECTUILIB_API void Delphi_RichEditUI_SetTransparent(CRichEditUI* handle, bool bTransparent) {
	handle->SetTransparent(bTransparent);
}

DIRECTUILIB_API bool Delphi_RichEditUI_IsRich(CRichEditUI* handle) {
    return handle->IsRich();
}

DIRECTUILIB_API void Delphi_RichEditUI_SetRich(CRichEditUI* handle ,bool bRich) {
    handle->SetRich(bRich);
}

DIRECTUILIB_API bool Delphi_RichEditUI_IsReadOnly(CRichEditUI* handle) {
    return handle->IsReadOnly();
}

DIRECTUILIB_API void Delphi_RichEditUI_SetReadOnly(CRichEditUI* handle ,bool bReadOnly) {
    handle->SetReadOnly(bReadOnly);
}

DIRECTUILIB_API bool Delphi_RichEditUI_GetWordWrap(CRichEditUI* handle) {
    return handle->GetWordWrap();
}

DIRECTUILIB_API void Delphi_RichEditUI_SetWordWrap(CRichEditUI* handle ,bool bWordWrap) {
    handle->SetWordWrap(bWordWrap);
}

DIRECTUILIB_API int Delphi_RichEditUI_GetFont(CRichEditUI* handle) {
    return handle->GetFont();
}

DIRECTUILIB_API void Delphi_RichEditUI_SetFont_01(CRichEditUI* handle ,int index) {
    handle->SetFont(index);
}

DIRECTUILIB_API void Delphi_RichEditUI_SetFont_02(CRichEditUI* handle ,LPCTSTR pStrFontName, int nSize, bool bBold, bool bUnderline, bool bItalic) {
    handle->SetFont(pStrFontName, nSize, bBold, bUnderline, bItalic);
}

DIRECTUILIB_API LONG Delphi_RichEditUI_GetWinStyle(CRichEditUI* handle) {
    return handle->GetWinStyle();
}

DIRECTUILIB_API void Delphi_RichEditUI_SetWinStyle(CRichEditUI* handle ,LONG lStyle) {
    handle->SetWinStyle(lStyle);
}

DIRECTUILIB_API DWORD Delphi_RichEditUI_GetTextColor(CRichEditUI* handle) {
    return handle->GetTextColor();
}

DIRECTUILIB_API void Delphi_RichEditUI_SetTextColor(CRichEditUI* handle ,DWORD dwTextColor) {
    handle->SetTextColor(dwTextColor);
}

DIRECTUILIB_API int Delphi_RichEditUI_GetLimitText(CRichEditUI* handle) {
    return handle->GetLimitText();
}

DIRECTUILIB_API void Delphi_RichEditUI_SetLimitText(CRichEditUI* handle ,int iChars) {
    handle->SetLimitText(iChars);
}

DIRECTUILIB_API long Delphi_RichEditUI_GetTextLength(CRichEditUI* handle ,DWORD dwFlags) {
    return handle->GetTextLength(dwFlags);
}

DIRECTUILIB_API CDuiString Delphi_RichEditUI_GetText(CRichEditUI* handle) {
    return handle->GetText();
}

DIRECTUILIB_API void Delphi_RichEditUI_SetText(CRichEditUI* handle ,LPCTSTR pstrText) {
    handle->SetText(pstrText);
}

DIRECTUILIB_API bool Delphi_RichEditUI_GetModify(CRichEditUI* handle) {
    return handle->GetModify();
}

DIRECTUILIB_API void Delphi_RichEditUI_SetModify(CRichEditUI* handle ,bool bModified) {
    handle->SetModify(bModified);
}

DIRECTUILIB_API void Delphi_RichEditUI_GetSel_01(CRichEditUI* handle ,CHARRANGE& cr) {
    handle->GetSel(cr);
}

DIRECTUILIB_API void Delphi_RichEditUI_GetSel_02(CRichEditUI* handle ,long& nStartChar, long& nEndChar) {
    handle->GetSel(nStartChar, nEndChar);
}

DIRECTUILIB_API int Delphi_RichEditUI_SetSel_01(CRichEditUI* handle ,CHARRANGE& cr) {
    return handle->SetSel(cr);
}

DIRECTUILIB_API int Delphi_RichEditUI_SetSel_02(CRichEditUI* handle ,long nStartChar, long nEndChar) {
    return handle->SetSel(nStartChar, nEndChar);
}

DIRECTUILIB_API void Delphi_RichEditUI_ReplaceSel(CRichEditUI* handle ,LPCTSTR lpszNewText, bool bCanUndo) {
    handle->ReplaceSel(lpszNewText, bCanUndo);
}

DIRECTUILIB_API void Delphi_RichEditUI_ReplaceSelW(CRichEditUI* handle ,LPCWSTR lpszNewText, bool bCanUndo) {
    handle->ReplaceSelW(lpszNewText, bCanUndo);
}

DIRECTUILIB_API CDuiString Delphi_RichEditUI_GetSelText(CRichEditUI* handle) {
    return handle->GetSelText();
}

DIRECTUILIB_API int Delphi_RichEditUI_SetSelAll(CRichEditUI* handle) {
    return handle->SetSelAll();
}

DIRECTUILIB_API int Delphi_RichEditUI_SetSelNone(CRichEditUI* handle) {
    return handle->SetSelNone();
}

DIRECTUILIB_API WORD Delphi_RichEditUI_GetSelectionType(CRichEditUI* handle) {
    return handle->GetSelectionType();
}

DIRECTUILIB_API bool Delphi_RichEditUI_GetZoom(CRichEditUI* handle ,int& nNum, int& nDen) {
    return handle->GetZoom(nNum, nDen);
}

DIRECTUILIB_API bool Delphi_RichEditUI_SetZoom(CRichEditUI* handle ,int nNum, int nDen) {
    return handle->SetZoom(nNum, nDen);
}

DIRECTUILIB_API bool Delphi_RichEditUI_SetZoomOff(CRichEditUI* handle) {
    return handle->SetZoomOff();
}

DIRECTUILIB_API bool Delphi_RichEditUI_GetAutoURLDetect(CRichEditUI* handle) {
    return handle->GetAutoURLDetect();
}

DIRECTUILIB_API bool Delphi_RichEditUI_SetAutoURLDetect(CRichEditUI* handle ,bool bAutoDetect) {
    return handle->SetAutoURLDetect(bAutoDetect);
}

DIRECTUILIB_API DWORD Delphi_RichEditUI_GetEventMask(CRichEditUI* handle) {
    return handle->GetEventMask();
}

DIRECTUILIB_API DWORD Delphi_RichEditUI_SetEventMask(CRichEditUI* handle ,DWORD dwEventMask) {
    return handle->SetEventMask(dwEventMask);
}

DIRECTUILIB_API CDuiString Delphi_RichEditUI_GetTextRange(CRichEditUI* handle ,long nStartChar, long nEndChar) {
    return handle->GetTextRange(nStartChar, nEndChar);
}

DIRECTUILIB_API void Delphi_RichEditUI_HideSelection(CRichEditUI* handle ,bool bHide, bool bChangeStyle) {
    handle->HideSelection(bHide, bChangeStyle);
}

DIRECTUILIB_API void Delphi_RichEditUI_ScrollCaret(CRichEditUI* handle) {
    handle->ScrollCaret();
}

DIRECTUILIB_API int Delphi_RichEditUI_InsertText(CRichEditUI* handle ,long nInsertAfterChar, LPCTSTR lpstrText, bool bCanUndo) {
    return handle->InsertText(nInsertAfterChar, lpstrText, bCanUndo);
}

DIRECTUILIB_API int Delphi_RichEditUI_AppendText(CRichEditUI* handle ,LPCTSTR lpstrText, bool bCanUndo) {
    return handle->AppendText(lpstrText, bCanUndo);
}

DIRECTUILIB_API DWORD Delphi_RichEditUI_GetDefaultCharFormat(CRichEditUI* handle ,CHARFORMAT2& cf) {
    return handle->GetDefaultCharFormat(cf);
}

DIRECTUILIB_API bool Delphi_RichEditUI_SetDefaultCharFormat(CRichEditUI* handle ,CHARFORMAT2& cf) {
    return handle->SetDefaultCharFormat(cf);
}

DIRECTUILIB_API DWORD Delphi_RichEditUI_GetSelectionCharFormat(CRichEditUI* handle ,CHARFORMAT2& cf) {
    return handle->GetSelectionCharFormat(cf);
}

DIRECTUILIB_API bool Delphi_RichEditUI_SetSelectionCharFormat(CRichEditUI* handle ,CHARFORMAT2& cf) {
    return handle->SetSelectionCharFormat(cf);
}

DIRECTUILIB_API bool Delphi_RichEditUI_SetWordCharFormat(CRichEditUI* handle ,CHARFORMAT2& cf) {
    return handle->SetWordCharFormat(cf);
}

DIRECTUILIB_API DWORD Delphi_RichEditUI_GetParaFormat(CRichEditUI* handle ,PARAFORMAT2& pf) {
    return handle->GetParaFormat(pf);
}

DIRECTUILIB_API bool Delphi_RichEditUI_SetParaFormat(CRichEditUI* handle ,PARAFORMAT2& pf) {
    return handle->SetParaFormat(pf);
}

DIRECTUILIB_API bool Delphi_RichEditUI_Redo(CRichEditUI* handle) {
    return handle->Redo();
}

DIRECTUILIB_API bool Delphi_RichEditUI_Undo(CRichEditUI* handle) {
    return handle->Undo();
}

DIRECTUILIB_API void Delphi_RichEditUI_Clear(CRichEditUI* handle) {
    handle->Clear();
}

DIRECTUILIB_API void Delphi_RichEditUI_Copy(CRichEditUI* handle) {
    handle->Copy();
}

DIRECTUILIB_API void Delphi_RichEditUI_Cut(CRichEditUI* handle) {
    handle->Cut();
}

DIRECTUILIB_API void Delphi_RichEditUI_Paste(CRichEditUI* handle) {
    handle->Paste();
}

DIRECTUILIB_API int Delphi_RichEditUI_GetLineCount(CRichEditUI* handle) {
    return handle->GetLineCount();
}

DIRECTUILIB_API CDuiString Delphi_RichEditUI_GetLine(CRichEditUI* handle ,int nIndex, int nMaxLength) {
    return handle->GetLine(nIndex, nMaxLength);
}

DIRECTUILIB_API int Delphi_RichEditUI_LineIndex(CRichEditUI* handle ,int nLine) {
    return handle->LineIndex(nLine);
}

DIRECTUILIB_API int Delphi_RichEditUI_LineLength(CRichEditUI* handle ,int nLine) {
    return handle->LineLength(nLine);
}

DIRECTUILIB_API bool Delphi_RichEditUI_LineScroll(CRichEditUI* handle ,int nLines, int nChars) {
    return handle->LineScroll(nLines, nChars);
}

DIRECTUILIB_API CDuiPoint Delphi_RichEditUI_GetCharPos(CRichEditUI* handle ,long lChar) {
    return handle->GetCharPos(lChar);
}

DIRECTUILIB_API long Delphi_RichEditUI_LineFromChar(CRichEditUI* handle ,long nIndex) {
    return handle->LineFromChar(nIndex);
}

DIRECTUILIB_API CDuiPoint Delphi_RichEditUI_PosFromChar(CRichEditUI* handle ,UINT nChar) {
    return handle->PosFromChar(nChar);
}

DIRECTUILIB_API int Delphi_RichEditUI_CharFromPos(CRichEditUI* handle ,CDuiPoint pt) {
    return handle->CharFromPos(pt);
}

DIRECTUILIB_API void Delphi_RichEditUI_EmptyUndoBuffer(CRichEditUI* handle) {
    handle->EmptyUndoBuffer();
}

DIRECTUILIB_API UINT Delphi_RichEditUI_SetUndoLimit(CRichEditUI* handle ,UINT nLimit) {
    return handle->SetUndoLimit(nLimit);
}

DIRECTUILIB_API long Delphi_RichEditUI_StreamIn(CRichEditUI* handle ,int nFormat, EDITSTREAM& es) {
    return handle->StreamIn(nFormat, es);
}

DIRECTUILIB_API long Delphi_RichEditUI_StreamOut(CRichEditUI* handle ,int nFormat, EDITSTREAM& es) {
    return handle->StreamOut(nFormat, es);
}

DIRECTUILIB_API void Delphi_RichEditUI_DoInit(CRichEditUI* handle) {
    handle->DoInit();
}

DIRECTUILIB_API bool Delphi_RichEditUI_SetDropAcceptFile(CRichEditUI* handle ,bool bAccept) {
    return handle->SetDropAcceptFile(bAccept);
}

DIRECTUILIB_API HRESULT Delphi_RichEditUI_TxSendMessage(CRichEditUI* handle ,UINT msg, WPARAM wparam, LPARAM lparam, LRESULT* plresult) {
    return handle->TxSendMessage(msg, wparam, lparam, plresult);
}

DIRECTUILIB_API IDropTarget* Delphi_RichEditUI_GetTxDropTarget(CRichEditUI* handle) {
    return handle->GetTxDropTarget();
}

DIRECTUILIB_API bool Delphi_RichEditUI_OnTxViewChanged(CRichEditUI* handle) {
    return handle->OnTxViewChanged();
}

DIRECTUILIB_API void Delphi_RichEditUI_OnTxNotify(CRichEditUI* handle ,DWORD iNotify, void* pv) {
    handle->OnTxNotify(iNotify, pv);
}

DIRECTUILIB_API void Delphi_RichEditUI_SetScrollPos(CRichEditUI* handle ,SIZE szPos) {
    handle->SetScrollPos(szPos);
}

DIRECTUILIB_API void Delphi_RichEditUI_LineUp(CRichEditUI* handle) {
    handle->LineUp();
}

DIRECTUILIB_API void Delphi_RichEditUI_LineDown(CRichEditUI* handle) {
    handle->LineDown();
}

DIRECTUILIB_API void Delphi_RichEditUI_PageUp(CRichEditUI* handle) {
    handle->PageUp();
}

DIRECTUILIB_API void Delphi_RichEditUI_PageDown(CRichEditUI* handle) {
    handle->PageDown();
}

DIRECTUILIB_API void Delphi_RichEditUI_HomeUp(CRichEditUI* handle) {
    handle->HomeUp();
}

DIRECTUILIB_API void Delphi_RichEditUI_EndDown(CRichEditUI* handle) {
    handle->EndDown();
}

DIRECTUILIB_API void Delphi_RichEditUI_LineLeft(CRichEditUI* handle) {
    handle->LineLeft();
}

DIRECTUILIB_API void Delphi_RichEditUI_LineRight(CRichEditUI* handle) {
    handle->LineRight();
}

DIRECTUILIB_API void Delphi_RichEditUI_PageLeft(CRichEditUI* handle) {
    handle->PageLeft();
}

DIRECTUILIB_API void Delphi_RichEditUI_PageRight(CRichEditUI* handle) {
    handle->PageRight();
}

DIRECTUILIB_API void Delphi_RichEditUI_HomeLeft(CRichEditUI* handle) {
    handle->HomeLeft();
}

DIRECTUILIB_API void Delphi_RichEditUI_EndRight(CRichEditUI* handle) {
    handle->EndRight();
}

DIRECTUILIB_API void Delphi_RichEditUI_EstimateSize(CRichEditUI* handle ,SIZE szAvailable, SIZE& Result) {
    Result = handle->EstimateSize(szAvailable);
}

DIRECTUILIB_API void Delphi_ControlUI_Paint(CControlUI* handle, HDC hDC, RECT& rcPaint) {
	handle->Paint(hDC, rcPaint);
}

DIRECTUILIB_API void Delphi_RichEditUI_SetPos(CRichEditUI* handle ,RECT rc, bool bNeedInvalidate) {
    handle->SetPos(rc, bNeedInvalidate);
}

DIRECTUILIB_API void Delphi_RichEditUI_Move(CRichEditUI* handle ,SIZE szOffset, bool bNeedInvalidate) {
    handle->Move(szOffset, bNeedInvalidate);
}

DIRECTUILIB_API void Delphi_RichEditUI_DoEvent(CRichEditUI* handle ,TEventUI& event) {
    handle->DoEvent(event);
}

DIRECTUILIB_API void Delphi_RichEditUI_DoPaint(CRichEditUI* handle ,HDC hDC, RECT& rcPaint) {
    handle->DoPaint(hDC, rcPaint);
}

DIRECTUILIB_API void Delphi_RichEditUI_SetAttribute(CRichEditUI* handle ,LPCTSTR pstrName, LPCTSTR pstrValue) {
    handle->SetAttribute(pstrName, pstrValue);
}

//================================CScrollBarUI============================

DIRECTUILIB_API CScrollBarUI* Delphi_ScrollBarUI_CppCreate() {
    return new CScrollBarUI();
}

DIRECTUILIB_API void Delphi_ScrollBarUI_CppDestroy(CScrollBarUI* handle) {
    delete handle;
}

DIRECTUILIB_API LPCTSTR Delphi_ScrollBarUI_GetClass(CScrollBarUI* handle) {
    return handle->GetClass();
}

DIRECTUILIB_API LPVOID Delphi_ScrollBarUI_GetInterface(CScrollBarUI* handle ,LPCTSTR pstrName) {
    return handle->GetInterface(pstrName);
}

DIRECTUILIB_API CContainerUI* Delphi_ScrollBarUI_GetOwner(CScrollBarUI* handle) {
    return handle->GetOwner();
}

DIRECTUILIB_API void Delphi_ScrollBarUI_SetOwner(CScrollBarUI* handle ,CContainerUI* pOwner) {
    handle->SetOwner(pOwner);
}

DIRECTUILIB_API void Delphi_ScrollBarUI_SetVisible(CScrollBarUI* handle ,bool bVisible) {
    handle->SetVisible(bVisible);
}

DIRECTUILIB_API void Delphi_ScrollBarUI_SetEnabled(CScrollBarUI* handle ,bool bEnable) {
    handle->SetEnabled(bEnable);
}

DIRECTUILIB_API void Delphi_ScrollBarUI_SetFocus(CScrollBarUI* handle) {
    handle->SetFocus();
}

DIRECTUILIB_API bool Delphi_ScrollBarUI_IsHorizontal(CScrollBarUI* handle) {
    return handle->IsHorizontal();
}

DIRECTUILIB_API void Delphi_ScrollBarUI_SetHorizontal(CScrollBarUI* handle ,bool bHorizontal) {
    handle->SetHorizontal(bHorizontal);
}

DIRECTUILIB_API int Delphi_ScrollBarUI_GetScrollRange(CScrollBarUI* handle) {
    return handle->GetScrollRange();
}

DIRECTUILIB_API void Delphi_ScrollBarUI_SetScrollRange(CScrollBarUI* handle ,int nRange) {
    handle->SetScrollRange(nRange);
}

DIRECTUILIB_API int Delphi_ScrollBarUI_GetScrollPos(CScrollBarUI* handle) {
    return handle->GetScrollPos();
}

DIRECTUILIB_API void Delphi_ScrollBarUI_SetScrollPos(CScrollBarUI* handle, int nPos, bool bTriggerEvent) {
	handle->SetScrollPos(nPos, bTriggerEvent);
}

DIRECTUILIB_API int Delphi_ScrollBarUI_GetLineSize(CScrollBarUI* handle) {
    return handle->GetLineSize();
}

DIRECTUILIB_API void Delphi_ScrollBarUI_SetLineSize(CScrollBarUI* handle ,int nSize) {
    handle->SetLineSize(nSize);
}

DIRECTUILIB_API bool Delphi_ScrollBarUI_GetShowButton1(CScrollBarUI* handle) {
    return handle->GetShowButton1();
}

DIRECTUILIB_API void Delphi_ScrollBarUI_SetShowButton1(CScrollBarUI* handle ,bool bShow) {
    handle->SetShowButton1(bShow);
}

DIRECTUILIB_API DWORD Delphi_ScrollBarUI_GetButton1Color(CScrollBarUI* handle) {
    return handle->GetButton1Color();
}

DIRECTUILIB_API void Delphi_ScrollBarUI_SetButton1Color(CScrollBarUI* handle ,DWORD dwColor) {
    handle->SetButton1Color(dwColor);
}

DIRECTUILIB_API LPCTSTR Delphi_ScrollBarUI_GetButton1NormalImage(CScrollBarUI* handle) {
    return handle->GetButton1NormalImage();
}

DIRECTUILIB_API void Delphi_ScrollBarUI_SetButton1NormalImage(CScrollBarUI* handle ,LPCTSTR pStrImage) {
    handle->SetButton1NormalImage(pStrImage);
}

DIRECTUILIB_API LPCTSTR Delphi_ScrollBarUI_GetButton1HotImage(CScrollBarUI* handle) {
    return handle->GetButton1HotImage();
}

DIRECTUILIB_API void Delphi_ScrollBarUI_SetButton1HotImage(CScrollBarUI* handle ,LPCTSTR pStrImage) {
    handle->SetButton1HotImage(pStrImage);
}

DIRECTUILIB_API LPCTSTR Delphi_ScrollBarUI_GetButton1PushedImage(CScrollBarUI* handle) {
    return handle->GetButton1PushedImage();
}

DIRECTUILIB_API void Delphi_ScrollBarUI_SetButton1PushedImage(CScrollBarUI* handle ,LPCTSTR pStrImage) {
    handle->SetButton1PushedImage(pStrImage);
}

DIRECTUILIB_API LPCTSTR Delphi_ScrollBarUI_GetButton1DisabledImage(CScrollBarUI* handle) {
    return handle->GetButton1DisabledImage();
}

DIRECTUILIB_API void Delphi_ScrollBarUI_SetButton1DisabledImage(CScrollBarUI* handle ,LPCTSTR pStrImage) {
    handle->SetButton1DisabledImage(pStrImage);
}

DIRECTUILIB_API bool Delphi_ScrollBarUI_GetShowButton2(CScrollBarUI* handle) {
    return handle->GetShowButton2();
}

DIRECTUILIB_API void Delphi_ScrollBarUI_SetShowButton2(CScrollBarUI* handle ,bool bShow) {
    handle->SetShowButton2(bShow);
}

DIRECTUILIB_API DWORD Delphi_ScrollBarUI_GetButton2Color(CScrollBarUI* handle) {
    return handle->GetButton2Color();
}

DIRECTUILIB_API void Delphi_ScrollBarUI_SetButton2Color(CScrollBarUI* handle ,DWORD dwColor) {
    handle->SetButton2Color(dwColor);
}

DIRECTUILIB_API LPCTSTR Delphi_ScrollBarUI_GetButton2NormalImage(CScrollBarUI* handle) {
    return handle->GetButton2NormalImage();
}

DIRECTUILIB_API void Delphi_ScrollBarUI_SetButton2NormalImage(CScrollBarUI* handle ,LPCTSTR pStrImage) {
    handle->SetButton2NormalImage(pStrImage);
}

DIRECTUILIB_API LPCTSTR Delphi_ScrollBarUI_GetButton2HotImage(CScrollBarUI* handle) {
    return handle->GetButton2HotImage();
}

DIRECTUILIB_API void Delphi_ScrollBarUI_SetButton2HotImage(CScrollBarUI* handle ,LPCTSTR pStrImage) {
    handle->SetButton2HotImage(pStrImage);
}

DIRECTUILIB_API LPCTSTR Delphi_ScrollBarUI_GetButton2PushedImage(CScrollBarUI* handle) {
    return handle->GetButton2PushedImage();
}

DIRECTUILIB_API void Delphi_ScrollBarUI_SetButton2PushedImage(CScrollBarUI* handle ,LPCTSTR pStrImage) {
    handle->SetButton2PushedImage(pStrImage);
}

DIRECTUILIB_API LPCTSTR Delphi_ScrollBarUI_GetButton2DisabledImage(CScrollBarUI* handle) {
    return handle->GetButton2DisabledImage();
}

DIRECTUILIB_API void Delphi_ScrollBarUI_SetButton2DisabledImage(CScrollBarUI* handle ,LPCTSTR pStrImage) {
    handle->SetButton2DisabledImage(pStrImage);
}

DIRECTUILIB_API DWORD Delphi_ScrollBarUI_GetThumbColor(CScrollBarUI* handle) {
    return handle->GetThumbColor();
}

DIRECTUILIB_API void Delphi_ScrollBarUI_SetThumbColor(CScrollBarUI* handle ,DWORD dwColor) {
    handle->SetThumbColor(dwColor);
}

DIRECTUILIB_API LPCTSTR Delphi_ScrollBarUI_GetThumbNormalImage(CScrollBarUI* handle) {
    return handle->GetThumbNormalImage();
}

DIRECTUILIB_API void Delphi_ScrollBarUI_SetThumbNormalImage(CScrollBarUI* handle ,LPCTSTR pStrImage) {
    handle->SetThumbNormalImage(pStrImage);
}

DIRECTUILIB_API LPCTSTR Delphi_ScrollBarUI_GetThumbHotImage(CScrollBarUI* handle) {
    return handle->GetThumbHotImage();
}

DIRECTUILIB_API void Delphi_ScrollBarUI_SetThumbHotImage(CScrollBarUI* handle ,LPCTSTR pStrImage) {
    handle->SetThumbHotImage(pStrImage);
}

DIRECTUILIB_API LPCTSTR Delphi_ScrollBarUI_GetThumbPushedImage(CScrollBarUI* handle) {
    return handle->GetThumbPushedImage();
}

DIRECTUILIB_API void Delphi_ScrollBarUI_SetThumbPushedImage(CScrollBarUI* handle ,LPCTSTR pStrImage) {
    handle->SetThumbPushedImage(pStrImage);
}

DIRECTUILIB_API LPCTSTR Delphi_ScrollBarUI_GetThumbDisabledImage(CScrollBarUI* handle) {
    return handle->GetThumbDisabledImage();
}

DIRECTUILIB_API void Delphi_ScrollBarUI_SetThumbDisabledImage(CScrollBarUI* handle ,LPCTSTR pStrImage) {
    handle->SetThumbDisabledImage(pStrImage);
}

DIRECTUILIB_API LPCTSTR Delphi_ScrollBarUI_GetRailNormalImage(CScrollBarUI* handle) {
    return handle->GetRailNormalImage();
}

DIRECTUILIB_API void Delphi_ScrollBarUI_SetRailNormalImage(CScrollBarUI* handle ,LPCTSTR pStrImage) {
    handle->SetRailNormalImage(pStrImage);
}

DIRECTUILIB_API LPCTSTR Delphi_ScrollBarUI_GetRailHotImage(CScrollBarUI* handle) {
    return handle->GetRailHotImage();
}

DIRECTUILIB_API void Delphi_ScrollBarUI_SetRailHotImage(CScrollBarUI* handle ,LPCTSTR pStrImage) {
    handle->SetRailHotImage(pStrImage);
}

DIRECTUILIB_API LPCTSTR Delphi_ScrollBarUI_GetRailPushedImage(CScrollBarUI* handle) {
    return handle->GetRailPushedImage();
}

DIRECTUILIB_API void Delphi_ScrollBarUI_SetRailPushedImage(CScrollBarUI* handle ,LPCTSTR pStrImage) {
    handle->SetRailPushedImage(pStrImage);
}

DIRECTUILIB_API LPCTSTR Delphi_ScrollBarUI_GetRailDisabledImage(CScrollBarUI* handle) {
    return handle->GetRailDisabledImage();
}

DIRECTUILIB_API void Delphi_ScrollBarUI_SetRailDisabledImage(CScrollBarUI* handle ,LPCTSTR pStrImage) {
    handle->SetRailDisabledImage(pStrImage);
}

DIRECTUILIB_API LPCTSTR Delphi_ScrollBarUI_GetBkNormalImage(CScrollBarUI* handle) {
    return handle->GetBkNormalImage();
}

DIRECTUILIB_API void Delphi_ScrollBarUI_SetBkNormalImage(CScrollBarUI* handle ,LPCTSTR pStrImage) {
    handle->SetBkNormalImage(pStrImage);
}

DIRECTUILIB_API LPCTSTR Delphi_ScrollBarUI_GetBkHotImage(CScrollBarUI* handle) {
    return handle->GetBkHotImage();
}

DIRECTUILIB_API void Delphi_ScrollBarUI_SetBkHotImage(CScrollBarUI* handle ,LPCTSTR pStrImage) {
    handle->SetBkHotImage(pStrImage);
}

DIRECTUILIB_API LPCTSTR Delphi_ScrollBarUI_GetBkPushedImage(CScrollBarUI* handle) {
    return handle->GetBkPushedImage();
}

DIRECTUILIB_API void Delphi_ScrollBarUI_SetBkPushedImage(CScrollBarUI* handle ,LPCTSTR pStrImage) {
    handle->SetBkPushedImage(pStrImage);
}

DIRECTUILIB_API LPCTSTR Delphi_ScrollBarUI_GetBkDisabledImage(CScrollBarUI* handle) {
    return handle->GetBkDisabledImage();
}

DIRECTUILIB_API void Delphi_ScrollBarUI_SetBkDisabledImage(CScrollBarUI* handle ,LPCTSTR pStrImage) {
    handle->SetBkDisabledImage(pStrImage);
}

DIRECTUILIB_API void Delphi_ScrollBarUI_SetPos(CScrollBarUI* handle ,RECT rc, bool bNeedInvalidate) {
    handle->SetPos(rc, bNeedInvalidate);
}

DIRECTUILIB_API void Delphi_ScrollBarUI_DoEvent(CScrollBarUI* handle ,TEventUI& event) {
    handle->DoEvent(event);
}

DIRECTUILIB_API void Delphi_ScrollBarUI_SetAttribute(CScrollBarUI* handle ,LPCTSTR pstrName, LPCTSTR pstrValue) {
    handle->SetAttribute(pstrName, pstrValue);
}

DIRECTUILIB_API void Delphi_ScrollBarUI_DoPaint(CScrollBarUI* handle ,HDC hDC, RECT& rcPaint) {
    handle->DoPaint(hDC, rcPaint);
}

DIRECTUILIB_API void Delphi_ScrollBarUI_PaintBk(CScrollBarUI* handle ,HDC hDC) {
    handle->PaintBk(hDC);
}

DIRECTUILIB_API void Delphi_ScrollBarUI_PaintButton1(CScrollBarUI* handle ,HDC hDC) {
    handle->PaintButton1(hDC);
}

DIRECTUILIB_API void Delphi_ScrollBarUI_PaintButton2(CScrollBarUI* handle ,HDC hDC) {
    handle->PaintButton2(hDC);
}

DIRECTUILIB_API void Delphi_ScrollBarUI_PaintThumb(CScrollBarUI* handle ,HDC hDC) {
    handle->PaintThumb(hDC);
}

DIRECTUILIB_API void Delphi_ScrollBarUI_PaintRail(CScrollBarUI* handle ,HDC hDC) {
    handle->PaintRail(hDC);
}

//================================CSliderUI============================

DIRECTUILIB_API CSliderUI* Delphi_SliderUI_CppCreate() {
    return new CSliderUI();
}

DIRECTUILIB_API void Delphi_SliderUI_CppDestroy(CSliderUI* handle) {
    delete handle;
}

DIRECTUILIB_API LPCTSTR Delphi_SliderUI_GetClass(CSliderUI* handle) {
    return handle->GetClass();
}

DIRECTUILIB_API UINT Delphi_SliderUI_GetControlFlags(CSliderUI* handle) {
    return handle->GetControlFlags();
}

DIRECTUILIB_API LPVOID Delphi_SliderUI_GetInterface(CSliderUI* handle ,LPCTSTR pstrName) {
    return handle->GetInterface(pstrName);
}

DIRECTUILIB_API void Delphi_SliderUI_SetEnabled(CSliderUI* handle ,bool bEnable) {
    handle->SetEnabled(bEnable);
}

DIRECTUILIB_API int Delphi_SliderUI_GetChangeStep(CSliderUI* handle) {
    return handle->GetChangeStep();
}

DIRECTUILIB_API void Delphi_SliderUI_SetChangeStep(CSliderUI* handle ,int step) {
    handle->SetChangeStep(step);
}

DIRECTUILIB_API void Delphi_SliderUI_SetThumbSize(CSliderUI* handle ,SIZE szXY) {
    handle->SetThumbSize(szXY);
}

DIRECTUILIB_API void Delphi_SliderUI_GetThumbRect(CSliderUI* handle, RECT& Result) {
    Result = handle->GetThumbRect();
}

DIRECTUILIB_API LPCTSTR Delphi_SliderUI_GetThumbImage(CSliderUI* handle) {
    return handle->GetThumbImage();
}

DIRECTUILIB_API void Delphi_SliderUI_SetThumbImage(CSliderUI* handle ,LPCTSTR pStrImage) {
    handle->SetThumbImage(pStrImage);
}

DIRECTUILIB_API LPCTSTR Delphi_SliderUI_GetThumbHotImage(CSliderUI* handle) {
    return handle->GetThumbHotImage();
}

DIRECTUILIB_API void Delphi_SliderUI_SetThumbHotImage(CSliderUI* handle ,LPCTSTR pStrImage) {
    handle->SetThumbHotImage(pStrImage);
}

DIRECTUILIB_API LPCTSTR Delphi_SliderUI_GetThumbPushedImage(CSliderUI* handle) {
    return handle->GetThumbPushedImage();
}

DIRECTUILIB_API void Delphi_SliderUI_SetThumbPushedImage(CSliderUI* handle ,LPCTSTR pStrImage) {
    handle->SetThumbPushedImage(pStrImage);
}

DIRECTUILIB_API void Delphi_SliderUI_DoEvent(CSliderUI* handle ,TEventUI& event) {
    handle->DoEvent(event);
}

DIRECTUILIB_API void Delphi_SliderUI_SetAttribute(CSliderUI* handle ,LPCTSTR pstrName, LPCTSTR pstrValue) {
    handle->SetAttribute(pstrName, pstrValue);
}

DIRECTUILIB_API void Delphi_SliderUI_PaintStatusImage(CSliderUI* handle ,HDC hDC) {
    handle->PaintStatusImage(hDC);
}

//================================CTextUI============================

DIRECTUILIB_API CTextUI* Delphi_TextUI_CppCreate() {
    return new CTextUI();
}

DIRECTUILIB_API void Delphi_TextUI_CppDestroy(CTextUI* handle) {
    delete handle;
}

DIRECTUILIB_API LPCTSTR Delphi_TextUI_GetClass(CTextUI* handle) {
    return handle->GetClass();
}

DIRECTUILIB_API UINT Delphi_TextUI_GetControlFlags(CTextUI* handle) {
    return handle->GetControlFlags();
}

DIRECTUILIB_API LPVOID Delphi_TextUI_GetInterface(CTextUI* handle ,LPCTSTR pstrName) {
    return handle->GetInterface(pstrName);
}

DIRECTUILIB_API CDuiString* Delphi_TextUI_GetLinkContent(CTextUI* handle ,int iIndex) {
    return handle->GetLinkContent(iIndex);
}

DIRECTUILIB_API void Delphi_TextUI_DoEvent(CTextUI* handle ,TEventUI& event) {
    handle->DoEvent(event);
}

DIRECTUILIB_API void Delphi_TextUI_EstimateSize(CTextUI* handle ,SIZE szAvailable, SIZE& Result) {
    Result = handle->EstimateSize(szAvailable);
}

DIRECTUILIB_API void Delphi_TextUI_PaintText(CTextUI* handle ,HDC hDC) {
    handle->PaintText(hDC);
}

//================================CTreeNodeUI============================

DIRECTUILIB_API CTreeNodeUI* Delphi_TreeNodeUI_CppCreate(CTreeNodeUI* _ParentNode) {
    return new CTreeNodeUI(_ParentNode);
}

DIRECTUILIB_API void Delphi_TreeNodeUI_CppDestroy(CTreeNodeUI* handle) {
    delete handle;
}

DIRECTUILIB_API LPCTSTR Delphi_TreeNodeUI_GetClass(CTreeNodeUI* handle) {
    return handle->GetClass();
}

DIRECTUILIB_API LPVOID Delphi_TreeNodeUI_GetInterface(CTreeNodeUI* handle ,LPCTSTR pstrName) {
    return handle->GetInterface(pstrName);
}

DIRECTUILIB_API void Delphi_TreeNodeUI_DoEvent(CTreeNodeUI* handle ,TEventUI& event) {
    handle->DoEvent(event);
}

DIRECTUILIB_API void Delphi_TreeNodeUI_Invalidate(CTreeNodeUI* handle) {
    handle->Invalidate();
}

DIRECTUILIB_API bool Delphi_TreeNodeUI_Select(CTreeNodeUI* handle, bool bSelect, bool bTriggerEvent) {
	return handle->Select(bSelect, bTriggerEvent);
}

DIRECTUILIB_API bool Delphi_TreeNodeUI_Add(CTreeNodeUI* handle ,CControlUI* _pTreeNodeUI) {
    return handle->Add(_pTreeNodeUI);
}

DIRECTUILIB_API bool Delphi_TreeNodeUI_AddAt(CTreeNodeUI* handle ,CControlUI* pControl, int iIndex) {
    return handle->AddAt(pControl, iIndex);
}

DIRECTUILIB_API bool Delphi_TreeNodeUI_Remove(CTreeNodeUI* handle ,CControlUI* pControl) {
    return handle->Remove(pControl);
}

DIRECTUILIB_API void Delphi_TreeNodeUI_SetVisibleTag(CTreeNodeUI* handle ,bool _IsVisible) {
    handle->SetVisibleTag(_IsVisible);
}

DIRECTUILIB_API bool Delphi_TreeNodeUI_GetVisibleTag(CTreeNodeUI* handle) {
    return handle->GetVisibleTag();
}

DIRECTUILIB_API void Delphi_TreeNodeUI_SetItemText(CTreeNodeUI* handle ,LPCTSTR pstrValue) {
    handle->SetItemText(pstrValue);
}

DIRECTUILIB_API CDuiString Delphi_TreeNodeUI_GetItemText(CTreeNodeUI* handle) {
    return handle->GetItemText();
}

DIRECTUILIB_API void Delphi_TreeNodeUI_CheckBoxSelected(CTreeNodeUI* handle ,bool _Selected) {
    handle->CheckBoxSelected(_Selected);
}

DIRECTUILIB_API bool Delphi_TreeNodeUI_IsCheckBoxSelected(CTreeNodeUI* handle) {
    return handle->IsCheckBoxSelected();
}

DIRECTUILIB_API bool Delphi_TreeNodeUI_IsHasChild(CTreeNodeUI* handle) {
    return handle->IsHasChild();
}

DIRECTUILIB_API bool Delphi_TreeNodeUI_AddChildNode(CTreeNodeUI* handle ,CTreeNodeUI* _pTreeNodeUI) {
    return handle->AddChildNode(_pTreeNodeUI);
}

DIRECTUILIB_API bool Delphi_TreeNodeUI_RemoveAt(CTreeNodeUI* handle ,CTreeNodeUI* _pTreeNodeUI) {
    return handle->RemoveAt(_pTreeNodeUI);
}

DIRECTUILIB_API void Delphi_TreeNodeUI_SetParentNode(CTreeNodeUI* handle ,CTreeNodeUI* _pParentTreeNode) {
    handle->SetParentNode(_pParentTreeNode);
}

DIRECTUILIB_API CTreeNodeUI* Delphi_TreeNodeUI_GetParentNode(CTreeNodeUI* handle) {
    return handle->GetParentNode();
}

DIRECTUILIB_API long Delphi_TreeNodeUI_GetCountChild(CTreeNodeUI* handle) {
    return handle->GetCountChild();
}

DIRECTUILIB_API void Delphi_TreeNodeUI_SetTreeView(CTreeNodeUI* handle ,CTreeViewUI* _CTreeViewUI) {
    handle->SetTreeView(_CTreeViewUI);
}

DIRECTUILIB_API CTreeViewUI* Delphi_TreeNodeUI_GetTreeView(CTreeNodeUI* handle) {
    return handle->GetTreeView();
}

DIRECTUILIB_API CTreeNodeUI* Delphi_TreeNodeUI_GetChildNode(CTreeNodeUI* handle ,int _nIndex) {
    return handle->GetChildNode(_nIndex);
}

DIRECTUILIB_API void Delphi_TreeNodeUI_SetVisibleFolderBtn(CTreeNodeUI* handle ,bool _IsVisibled) {
    handle->SetVisibleFolderBtn(_IsVisibled);
}

DIRECTUILIB_API bool Delphi_TreeNodeUI_GetVisibleFolderBtn(CTreeNodeUI* handle) {
    return handle->GetVisibleFolderBtn();
}

DIRECTUILIB_API void Delphi_TreeNodeUI_SetVisibleCheckBtn(CTreeNodeUI* handle ,bool _IsVisibled) {
    handle->SetVisibleCheckBtn(_IsVisibled);
}

DIRECTUILIB_API bool Delphi_TreeNodeUI_GetVisibleCheckBtn(CTreeNodeUI* handle) {
    return handle->GetVisibleCheckBtn();
}

DIRECTUILIB_API void Delphi_TreeNodeUI_SetItemTextColor(CTreeNodeUI* handle ,DWORD _dwItemTextColor) {
    handle->SetItemTextColor(_dwItemTextColor);
}

DIRECTUILIB_API DWORD Delphi_TreeNodeUI_GetItemTextColor(CTreeNodeUI* handle) {
    return handle->GetItemTextColor();
}

DIRECTUILIB_API void Delphi_TreeNodeUI_SetItemHotTextColor(CTreeNodeUI* handle ,DWORD _dwItemHotTextColor) {
    handle->SetItemHotTextColor(_dwItemHotTextColor);
}

DIRECTUILIB_API DWORD Delphi_TreeNodeUI_GetItemHotTextColor(CTreeNodeUI* handle) {
    return handle->GetItemHotTextColor();
}

DIRECTUILIB_API void Delphi_TreeNodeUI_SetSelItemTextColor(CTreeNodeUI* handle ,DWORD _dwSelItemTextColor) {
    handle->SetSelItemTextColor(_dwSelItemTextColor);
}

DIRECTUILIB_API DWORD Delphi_TreeNodeUI_GetSelItemTextColor(CTreeNodeUI* handle) {
    return handle->GetSelItemTextColor();
}

DIRECTUILIB_API void Delphi_TreeNodeUI_SetSelItemHotTextColor(CTreeNodeUI* handle ,DWORD _dwSelHotItemTextColor) {
    handle->SetSelItemHotTextColor(_dwSelHotItemTextColor);
}

DIRECTUILIB_API DWORD Delphi_TreeNodeUI_GetSelItemHotTextColor(CTreeNodeUI* handle) {
    return handle->GetSelItemHotTextColor();
}

DIRECTUILIB_API void Delphi_TreeNodeUI_SetAttribute(CTreeNodeUI* handle ,LPCTSTR pstrName, LPCTSTR pstrValue) {
    handle->SetAttribute(pstrName, pstrValue);
}

DIRECTUILIB_API CStdPtrArray Delphi_TreeNodeUI_GetTreeNodes(CTreeNodeUI* handle) {
    return handle->GetTreeNodes();
}

DIRECTUILIB_API int Delphi_TreeNodeUI_GetTreeIndex(CTreeNodeUI* handle) {
    return handle->GetTreeIndex();
}

DIRECTUILIB_API int Delphi_TreeNodeUI_GetNodeIndex(CTreeNodeUI* handle) {
    return handle->GetNodeIndex();
}

//================================CTreeViewUI============================

DIRECTUILIB_API CTreeViewUI* Delphi_TreeViewUI_CppCreate() {
    return new CTreeViewUI();
}

DIRECTUILIB_API void Delphi_TreeViewUI_CppDestroy(CTreeViewUI* handle) {
    delete handle;
}

DIRECTUILIB_API LPCTSTR Delphi_TreeViewUI_GetClass(CTreeViewUI* handle) {
    return handle->GetClass();
}

DIRECTUILIB_API LPVOID Delphi_TreeViewUI_GetInterface(CTreeViewUI* handle ,LPCTSTR pstrName) {
    return handle->GetInterface(pstrName);
}

DIRECTUILIB_API bool Delphi_TreeViewUI_Add(CTreeViewUI* handle ,CTreeNodeUI* pControl) {
    return handle->Add(pControl);
}

DIRECTUILIB_API long Delphi_TreeViewUI_AddAt_01(CTreeViewUI* handle ,CTreeNodeUI* pControl, int iIndex) {
    return handle->AddAt(pControl, iIndex);
}

DIRECTUILIB_API bool Delphi_TreeViewUI_AddAt_02(CTreeViewUI* handle ,CTreeNodeUI* pControl, CTreeNodeUI* _IndexNode) {
    return handle->AddAt(pControl, _IndexNode);
}

DIRECTUILIB_API bool Delphi_TreeViewUI_Remove(CTreeViewUI* handle ,CTreeNodeUI* pControl) {
    return handle->Remove(pControl);
}

DIRECTUILIB_API bool Delphi_TreeViewUI_RemoveAt(CTreeViewUI* handle ,int iIndex) {
    return handle->RemoveAt(iIndex);
}

DIRECTUILIB_API void Delphi_TreeViewUI_RemoveAll(CTreeViewUI* handle) {
    handle->RemoveAll();
}

DIRECTUILIB_API bool Delphi_TreeViewUI_OnCheckBoxChanged(CTreeViewUI* handle ,void* param) {
    return handle->OnCheckBoxChanged(param);
}

DIRECTUILIB_API bool Delphi_TreeViewUI_OnFolderChanged(CTreeViewUI* handle ,void* param) {
    return handle->OnFolderChanged(param);
}

DIRECTUILIB_API bool Delphi_TreeViewUI_OnDBClickItem(CTreeViewUI* handle ,void* param) {
    return handle->OnDBClickItem(param);
}

DIRECTUILIB_API bool Delphi_TreeViewUI_SetItemCheckBox(CTreeViewUI* handle ,bool _Selected, CTreeNodeUI* _TreeNode) {
    return handle->SetItemCheckBox(_Selected, _TreeNode);
}

DIRECTUILIB_API void Delphi_TreeViewUI_SetItemExpand(CTreeViewUI* handle ,bool _Expanded, CTreeNodeUI* _TreeNode) {
    handle->SetItemExpand(_Expanded, _TreeNode);
}

DIRECTUILIB_API void Delphi_TreeViewUI_Notify(CTreeViewUI* handle ,TNotifyUI& msg) {
    handle->Notify(msg);
}

DIRECTUILIB_API void Delphi_TreeViewUI_SetVisibleFolderBtn(CTreeViewUI* handle ,bool _IsVisibled) {
    handle->SetVisibleFolderBtn(_IsVisibled);
}

DIRECTUILIB_API bool Delphi_TreeViewUI_GetVisibleFolderBtn(CTreeViewUI* handle) {
    return handle->GetVisibleFolderBtn();
}

DIRECTUILIB_API void Delphi_TreeViewUI_SetVisibleCheckBtn(CTreeViewUI* handle ,bool _IsVisibled) {
    handle->SetVisibleCheckBtn(_IsVisibled);
}

DIRECTUILIB_API bool Delphi_TreeViewUI_GetVisibleCheckBtn(CTreeViewUI* handle) {
    return handle->GetVisibleCheckBtn();
}

DIRECTUILIB_API void Delphi_TreeViewUI_SetItemMinWidth(CTreeViewUI* handle ,UINT _ItemMinWidth) {
    handle->SetItemMinWidth(_ItemMinWidth);
}

DIRECTUILIB_API UINT Delphi_TreeViewUI_GetItemMinWidth(CTreeViewUI* handle) {
    return handle->GetItemMinWidth();
}

DIRECTUILIB_API void Delphi_TreeViewUI_SetItemTextColor(CTreeViewUI* handle ,DWORD _dwItemTextColor) {
    handle->SetItemTextColor(_dwItemTextColor);
}

DIRECTUILIB_API void Delphi_TreeViewUI_SetItemHotTextColor(CTreeViewUI* handle ,DWORD _dwItemHotTextColor) {
    handle->SetItemHotTextColor(_dwItemHotTextColor);
}

DIRECTUILIB_API void Delphi_TreeViewUI_SetSelItemTextColor(CTreeViewUI* handle ,DWORD _dwSelItemTextColor) {
    handle->SetSelItemTextColor(_dwSelItemTextColor);
}

DIRECTUILIB_API void Delphi_TreeViewUI_SetSelItemHotTextColor(CTreeViewUI* handle ,DWORD _dwSelHotItemTextColor) {
    handle->SetSelItemHotTextColor(_dwSelHotItemTextColor);
}

DIRECTUILIB_API void Delphi_TreeViewUI_SetAttribute(CTreeViewUI* handle ,LPCTSTR pstrName, LPCTSTR pstrValue) {
    handle->SetAttribute(pstrName, pstrValue);
}

//================================CTabLayoutUI============================

DIRECTUILIB_API CTabLayoutUI* Delphi_TabLayoutUI_CppCreate() {
    return new CTabLayoutUI();
}

DIRECTUILIB_API void Delphi_TabLayoutUI_CppDestroy(CTabLayoutUI* handle) {
    delete handle;
}

DIRECTUILIB_API LPCTSTR Delphi_TabLayoutUI_GetClass(CTabLayoutUI* handle) {
    return handle->GetClass();
}

DIRECTUILIB_API LPVOID Delphi_TabLayoutUI_GetInterface(CTabLayoutUI* handle ,LPCTSTR pstrName) {
    return handle->GetInterface(pstrName);
}

DIRECTUILIB_API bool Delphi_TabLayoutUI_Add(CTabLayoutUI* handle ,CControlUI* pControl) {
    return handle->Add(pControl);
}

DIRECTUILIB_API bool Delphi_TabLayoutUI_AddAt(CTabLayoutUI* handle ,CControlUI* pControl, int iIndex) {
    return handle->AddAt(pControl, iIndex);
}

DIRECTUILIB_API bool Delphi_TabLayoutUI_Remove(CTabLayoutUI* handle ,CControlUI* pControl) {
    return handle->Remove(pControl);
}

DIRECTUILIB_API void Delphi_TabLayoutUI_RemoveAll(CTabLayoutUI* handle) {
    handle->RemoveAll();
}

DIRECTUILIB_API int Delphi_TabLayoutUI_GetCurSel(CTabLayoutUI* handle) {
    return handle->GetCurSel();
}

DIRECTUILIB_API bool Delphi_TabLayoutUI_SelectItem_01(CTabLayoutUI* handle, int iIndex, bool bTriggerEvent) {
	return handle->SelectItem(iIndex, bTriggerEvent);
}

DIRECTUILIB_API bool Delphi_TabLayoutUI_SelectItem_02(CTabLayoutUI* handle, CControlUI* pControl, bool bTriggerEvent) {
	return handle->SelectItem(pControl, bTriggerEvent);
}

DIRECTUILIB_API void Delphi_TabLayoutUI_SetPos(CTabLayoutUI* handle ,RECT rc, bool bNeedInvalidate) {
    handle->SetPos(rc, bNeedInvalidate);
}

DIRECTUILIB_API void Delphi_TabLayoutUI_SetAttribute(CTabLayoutUI* handle ,LPCTSTR pstrName, LPCTSTR pstrValue) {
    handle->SetAttribute(pstrName, pstrValue);
}

//================================CHorizontalLayoutUI============================

DIRECTUILIB_API CHorizontalLayoutUI* Delphi_HorizontalLayoutUI_CppCreate() {
    return new CHorizontalLayoutUI();
}

DIRECTUILIB_API void Delphi_HorizontalLayoutUI_CppDestroy(CHorizontalLayoutUI* handle) {
    delete handle;
}

DIRECTUILIB_API LPCTSTR Delphi_HorizontalLayoutUI_GetClass(CHorizontalLayoutUI* handle) {
    return handle->GetClass();
}

DIRECTUILIB_API LPVOID Delphi_HorizontalLayoutUI_GetInterface(CHorizontalLayoutUI* handle ,LPCTSTR pstrName) {
    return handle->GetInterface(pstrName);
}

DIRECTUILIB_API UINT Delphi_HorizontalLayoutUI_GetControlFlags(CHorizontalLayoutUI* handle) {
    return handle->GetControlFlags();
}

DIRECTUILIB_API void Delphi_HorizontalLayoutUI_SetSepWidth(CHorizontalLayoutUI* handle ,int iWidth) {
    handle->SetSepWidth(iWidth);
}

DIRECTUILIB_API int Delphi_HorizontalLayoutUI_GetSepWidth(CHorizontalLayoutUI* handle) {
    return handle->GetSepWidth();
}

DIRECTUILIB_API void Delphi_HorizontalLayoutUI_SetSepImmMode(CHorizontalLayoutUI* handle ,bool bImmediately) {
    handle->SetSepImmMode(bImmediately);
}

DIRECTUILIB_API bool Delphi_HorizontalLayoutUI_IsSepImmMode(CHorizontalLayoutUI* handle) {
    return handle->IsSepImmMode();
}

DIRECTUILIB_API void Delphi_HorizontalLayoutUI_SetAttribute(CHorizontalLayoutUI* handle ,LPCTSTR pstrName, LPCTSTR pstrValue) {
    handle->SetAttribute(pstrName, pstrValue);
}

DIRECTUILIB_API void Delphi_HorizontalLayoutUI_DoEvent(CHorizontalLayoutUI* handle ,TEventUI& event) {
    handle->DoEvent(event);
}

DIRECTUILIB_API void Delphi_HorizontalLayoutUI_SetPos(CHorizontalLayoutUI* handle ,RECT rc, bool bNeedInvalidate) {
    handle->SetPos(rc, bNeedInvalidate);
}

DIRECTUILIB_API void Delphi_HorizontalLayoutUI_DoPostPaint(CHorizontalLayoutUI* handle ,HDC hDC, RECT& rcPaint) {
    handle->DoPostPaint(hDC, rcPaint);
}

DIRECTUILIB_API void Delphi_HorizontalLayoutUI_GetThumbRect(CHorizontalLayoutUI* handle ,bool bUseNew, RECT& Result) {
    Result = handle->GetThumbRect(bUseNew);
}

//================================CListHeaderUI============================

DIRECTUILIB_API CListHeaderUI* Delphi_ListHeaderUI_CppCreate() {
    return new CListHeaderUI();
}

DIRECTUILIB_API void Delphi_ListHeaderUI_CppDestroy(CListHeaderUI* handle) {
    delete handle;
}

DIRECTUILIB_API LPCTSTR Delphi_ListHeaderUI_GetClass(CListHeaderUI* handle) {
    return handle->GetClass();
}

DIRECTUILIB_API LPVOID Delphi_ListHeaderUI_GetInterface(CListHeaderUI* handle ,LPCTSTR pstrName) {
    return handle->GetInterface(pstrName);
}

DIRECTUILIB_API void Delphi_ListHeaderUI_EstimateSize(CListHeaderUI* handle ,SIZE szAvailable, SIZE& Result) {
    Result = handle->EstimateSize(szAvailable);
}


//================================CActiveXUI============================

DIRECTUILIB_API CActiveXUI* Delphi_ActiveXUI_CppCreate() {
    return new CActiveXUI();
}

DIRECTUILIB_API void Delphi_ActiveXUI_CppDestroy(CActiveXUI* handle) {
    delete handle;
}

DIRECTUILIB_API LPCTSTR Delphi_ActiveXUI_GetClass(CActiveXUI* handle) {
    return handle->GetClass();
}

DIRECTUILIB_API LPVOID Delphi_ActiveXUI_GetInterface(CActiveXUI* handle ,LPCTSTR pstrName) {
    return handle->GetInterface(pstrName);
}

DIRECTUILIB_API UINT Delphi_ActiveXUI_GetControlFlags(CActiveXUI* handle) {
	return handle->GetControlFlags();
}

DIRECTUILIB_API HWND Delphi_ActiveXUI_GetNativeWindow(CActiveXUI* handle) {
	return handle->GetNativeWindow();
}

DIRECTUILIB_API bool Delphi_ActiveXUI_IsDelayCreate(CActiveXUI* handle) {
    return handle->IsDelayCreate();
}

DIRECTUILIB_API void Delphi_ActiveXUI_SetDelayCreate(CActiveXUI* handle ,bool bDelayCreate) {
    handle->SetDelayCreate(bDelayCreate);
}

DIRECTUILIB_API bool Delphi_ActiveXUI_CreateControl_01(CActiveXUI* handle ,CLSID clsid) {
    return handle->CreateControl(clsid);
}

DIRECTUILIB_API bool Delphi_ActiveXUI_CreateControl_02(CActiveXUI* handle ,LPCTSTR pstrCLSID) {
    return handle->CreateControl(pstrCLSID);
}

DIRECTUILIB_API HRESULT Delphi_ActiveXUI_GetControl(CActiveXUI* handle ,IID iid, LPVOID* ppRet) {
    return handle->GetControl(iid, ppRet);
}

DIRECTUILIB_API void Delphi_ActiveXUI_GetClisd(CActiveXUI* handle, CLSID& Result) {
    Result = handle->GetClisd();
}

DIRECTUILIB_API CDuiString Delphi_ActiveXUI_GetModuleName(CActiveXUI* handle) {
    return handle->GetModuleName();
}

DIRECTUILIB_API void Delphi_ActiveXUI_SetModuleName(CActiveXUI* handle ,LPCTSTR pstrText) {
    handle->SetModuleName(pstrText);
}

DIRECTUILIB_API void Delphi_ActiveXUI_SetVisible(CActiveXUI* handle ,bool bVisible) {
    handle->SetVisible(bVisible);
}

DIRECTUILIB_API void Delphi_ActiveXUI_SetInternVisible(CActiveXUI* handle ,bool bVisible) {
    handle->SetInternVisible(bVisible);
}

DIRECTUILIB_API void Delphi_ActiveXUI_SetPos(CActiveXUI* handle ,RECT rc, bool bNeedInvalidate) {
    handle->SetPos(rc, bNeedInvalidate);
}

DIRECTUILIB_API void Delphi_ActiveXUI_Move(CActiveXUI* handle ,SIZE szOffset, bool bNeedInvalidate) {
    handle->Move(szOffset, bNeedInvalidate);
}

DIRECTUILIB_API void Delphi_ActiveXUI_DoPaint(CActiveXUI* handle ,HDC hDC, RECT& rcPaint) {
    handle->DoPaint(hDC, rcPaint);
}

DIRECTUILIB_API void Delphi_ActiveXUI_SetAttribute(CActiveXUI* handle ,LPCTSTR pstrName, LPCTSTR pstrValue) {
    handle->SetAttribute(pstrName, pstrValue);
}

//================================CWebBrowserUI============================

DIRECTUILIB_API CWebBrowserUI* Delphi_WebBrowserUI_CppCreate() {
    return new CWebBrowserUI();
}

DIRECTUILIB_API void Delphi_WebBrowserUI_CppDestroy(CWebBrowserUI* handle) {
    delete handle;
}

DIRECTUILIB_API LPCTSTR Delphi_WebBrowserUI_GetClass(CWebBrowserUI* handle) {
    return handle->GetClass();
}

DIRECTUILIB_API LPVOID Delphi_WebBrowserUI_GetInterface(CWebBrowserUI* handle ,LPCTSTR pstrName) {
    return handle->GetInterface(pstrName);
}

DIRECTUILIB_API void Delphi_WebBrowserUI_SetHomePage(CWebBrowserUI* handle ,LPCTSTR lpszUrl) {
    handle->SetHomePage(lpszUrl);
}

DIRECTUILIB_API LPCTSTR Delphi_WebBrowserUI_GetHomePage(CWebBrowserUI* handle) {
    return handle->GetHomePage();
}

DIRECTUILIB_API void Delphi_WebBrowserUI_SetAutoNavigation(CWebBrowserUI* handle ,bool bAuto) {
    handle->SetAutoNavigation(bAuto);
}

DIRECTUILIB_API bool Delphi_WebBrowserUI_IsAutoNavigation(CWebBrowserUI* handle) {
    return handle->IsAutoNavigation();
}

DIRECTUILIB_API void Delphi_WebBrowserUI_SetWebBrowserEventHandler(CWebBrowserUI* handle ,CWebBrowserEventHandler* pEventHandler) {
    handle->SetWebBrowserEventHandler(pEventHandler);
}

DIRECTUILIB_API void Delphi_WebBrowserUI_Navigate2(CWebBrowserUI* handle ,LPCTSTR lpszUrl) {
    handle->Navigate2(lpszUrl);
}

DIRECTUILIB_API void Delphi_WebBrowserUI_Refresh(CWebBrowserUI* handle) {
    handle->Refresh();
}

DIRECTUILIB_API void Delphi_WebBrowserUI_Refresh2(CWebBrowserUI* handle ,int Level) {
    handle->Refresh2(Level);
}

DIRECTUILIB_API void Delphi_WebBrowserUI_GoBack(CWebBrowserUI* handle) {
    handle->GoBack();
}

DIRECTUILIB_API void Delphi_WebBrowserUI_GoForward(CWebBrowserUI* handle) {
    handle->GoForward();
}

DIRECTUILIB_API void Delphi_WebBrowserUI_NavigateHomePage(CWebBrowserUI* handle) {
    handle->NavigateHomePage();
}

DIRECTUILIB_API void Delphi_WebBrowserUI_NavigateUrl(CWebBrowserUI* handle ,LPCTSTR lpszUrl) {
    handle->NavigateUrl(lpszUrl);
}

DIRECTUILIB_API bool Delphi_WebBrowserUI_DoCreateControl(CWebBrowserUI* handle) {
    return handle->DoCreateControl();
}

DIRECTUILIB_API IWebBrowser2* Delphi_WebBrowserUI_GetWebBrowser2(CWebBrowserUI* handle) {
    return handle->GetWebBrowser2();
}

DIRECTUILIB_API IDispatch* Delphi_WebBrowserUI_GetHtmlWindow(CWebBrowserUI* handle) {
    return handle->GetHtmlWindow();
}

DIRECTUILIB_API DISPID Delphi_WebBrowserUI_FindId(IDispatch* pObj, LPOLESTR pName) {
    return CWebBrowserUI::FindId(pObj, pName);
}

DIRECTUILIB_API HRESULT Delphi_WebBrowserUI_InvokeMethod(IDispatch* pObj, LPOLESTR pMehtod, VARIANT* pVarResult, VARIANT* ps, int cArgs) {
    return CWebBrowserUI::InvokeMethod(pObj, pMehtod, pVarResult, ps, cArgs);
}

DIRECTUILIB_API HRESULT Delphi_WebBrowserUI_GetProperty(IDispatch* pObj, LPOLESTR pName, VARIANT* pValue) {
    return CWebBrowserUI::GetProperty(pObj, pName, pValue);
}

DIRECTUILIB_API HRESULT Delphi_WebBrowserUI_SetProperty(IDispatch* pObj, LPOLESTR pName, VARIANT* pValue) {
    return CWebBrowserUI::SetProperty(pObj, pName, pValue);
}


//================================CRenderClip============================

DIRECTUILIB_API CRenderClip* Delphi_RenderClip_CppCreate() {
    return new CRenderClip();
}

DIRECTUILIB_API void Delphi_RenderClip_CppDestroy(CRenderClip* handle) {
    delete handle;
}

DIRECTUILIB_API void Delphi_RenderClip_GenerateClip(HDC hDC, RECT rc, CRenderClip& clip) {
    CRenderClip::GenerateClip(hDC, rc, clip);
}

DIRECTUILIB_API void Delphi_RenderClip_GenerateRoundClip(HDC hDC, RECT rc, RECT rcItem, int width, int height, CRenderClip& clip) {
    CRenderClip::GenerateRoundClip(hDC, rc, rcItem, width, height, clip);
}

DIRECTUILIB_API void Delphi_RenderClip_UseOldClipBegin(HDC hDC, CRenderClip& clip) {
    CRenderClip::UseOldClipBegin(hDC, clip);
}

DIRECTUILIB_API void Delphi_RenderClip_UseOldClipEnd(HDC hDC, CRenderClip& clip) {
    CRenderClip::UseOldClipEnd(hDC, clip);
}

//================================CRenderEngine============================

DIRECTUILIB_API CRenderEngine* Delphi_RenderEngine_CppCreate() {
    return new CRenderEngine();
}

DIRECTUILIB_API void Delphi_RenderEngine_CppDestroy(CRenderEngine* handle) {
    delete handle;
}

DIRECTUILIB_API DWORD Delphi_RenderEngine_AdjustColor(DWORD dwColor, short H, short S, short L) {
    return CRenderEngine::AdjustColor(dwColor, H, S, L);
}

DIRECTUILIB_API HBITMAP Delphi_RenderEngine_CreateARGB32Bitmap(HDC hDC, int cx, int cy, COLORREF** pBits) {
	return CRenderEngine::CreateARGB32Bitmap(hDC, cx, cy, pBits);
}

DIRECTUILIB_API void Delphi_RenderEngine_AdjustImage(bool bUseHSL, TImageInfo* imageInfo, short H, short S, short L) {
    CRenderEngine::AdjustImage(bUseHSL, imageInfo, H, S, L);
}

DIRECTUILIB_API TImageInfo* Delphi_RenderEngine_LoadImage(STRINGorID bitmap, LPCTSTR type, DWORD mask) {
    return CRenderEngine::LoadImage(bitmap, type, mask);
}

DIRECTUILIB_API void Delphi_RenderEngine_FreeImage(TImageInfo* bitmap, bool bDelete) {
    CRenderEngine::FreeImage(bitmap, bDelete);
}

DIRECTUILIB_API void Delphi_RenderEngine_DrawImage_01(HDC hDC, HBITMAP hBitmap, RECT& rc, RECT& rcPaint, RECT& rcBmpPart, RECT& rcCorners, bool alphaChannel, BYTE uFade, bool hole, bool xtiled, bool ytiled) {
    CRenderEngine::DrawImage(hDC, hBitmap, rc, rcPaint, rcBmpPart, rcCorners, alphaChannel, uFade, hole, xtiled, ytiled);
}

DIRECTUILIB_API bool Delphi_RenderEngine_DrawImage_02(HDC hDC, CPaintManagerUI* pManager, RECT& rcItem, RECT& rcPaint, TDrawInfo& drawInfo) {
    return CRenderEngine::DrawImage(hDC, pManager, rcItem, rcPaint, drawInfo);
}

DIRECTUILIB_API void Delphi_RenderEngine_DrawColor(HDC hDC, RECT& rc, DWORD color) {
    CRenderEngine::DrawColor(hDC, rc, color);
}

DIRECTUILIB_API void Delphi_RenderEngine_DrawGradient(HDC hDC, RECT& rc, DWORD dwFirst, DWORD dwSecond, bool bVertical, int nSteps) {
    CRenderEngine::DrawGradient(hDC, rc, dwFirst, dwSecond, bVertical, nSteps);
}

DIRECTUILIB_API void Delphi_RenderEngine_DrawLine(HDC hDC, RECT& rc, int nSize, DWORD dwPenColor, int nStyle) {
    CRenderEngine::DrawLine(hDC, rc, nSize, dwPenColor, nStyle);
}

DIRECTUILIB_API void Delphi_RenderEngine_DrawRect(HDC hDC, RECT& rc, int nSize, DWORD dwPenColor, int nStyle) {
	CRenderEngine::DrawRect(hDC, rc, nSize, dwPenColor, nStyle);
}

DIRECTUILIB_API void Delphi_RenderEngine_DrawRoundRect(HDC hDC, RECT& rc, int width, int height, int nSize, DWORD dwPenColor, int nStyle) {
	CRenderEngine::DrawRoundRect(hDC, rc, width, height, nSize, dwPenColor, nStyle);
}

DIRECTUILIB_API void Delphi_RenderEngine_DrawText(HDC hDC, CPaintManagerUI* pManager, RECT& rc, LPCTSTR pstrText, DWORD dwTextColor, int iFont, UINT uStyle) {
    CRenderEngine::DrawText(hDC, pManager, rc, pstrText, dwTextColor, iFont, uStyle);
}

DIRECTUILIB_API void Delphi_RenderEngine_DrawHtmlText(HDC hDC, CPaintManagerUI* pManager, RECT& rc, LPCTSTR pstrText, DWORD dwTextColor, RECT* pLinks, CDuiString* sLinks, int& nLinkRects, UINT uStyle) {
    CRenderEngine::DrawHtmlText(hDC, pManager, rc, pstrText, dwTextColor, pLinks, sLinks, nLinkRects, uStyle);
}

DIRECTUILIB_API HBITMAP Delphi_RenderEngine_GenerateBitmap(CPaintManagerUI* pManager, CControlUI* pControl, RECT rc) {
    return CRenderEngine::GenerateBitmap(pManager, pControl, rc);
}

DIRECTUILIB_API void Delphi_RenderEngine_GetTextSize(HDC hDC, CPaintManagerUI* pManager, LPCTSTR pstrText, int iFont, UINT uStyle, SIZE& Result) {
    Result = CRenderEngine::GetTextSize(hDC, pManager, pstrText, iFont, uStyle);
}


//================================CListElementUI============================

//DIRECTUILIB_API CListElementUI* Delphi_ListElementUI_CppCreate() {
//	return new CListElementUI();
//}

//DIRECTUILIB_API void Delphi_ListElementUI_CppDestroy(CListElementUI* handle) {
//	delete handle;
//}

DIRECTUILIB_API LPCTSTR Delphi_ListElementUI_GetClass(CListElementUI* handle) {
	return handle->GetClass();
}

DIRECTUILIB_API UINT Delphi_ListElementUI_GetControlFlags(CListElementUI* handle) {
	return handle->GetControlFlags();
}

DIRECTUILIB_API LPVOID Delphi_ListElementUI_GetInterface(CListElementUI* handle, LPCTSTR pstrName) {
	return handle->GetInterface(pstrName);
}

DIRECTUILIB_API void Delphi_ListElementUI_SetEnabled(CListElementUI* handle, bool bEnable) {
	handle->SetEnabled(bEnable);
}

DIRECTUILIB_API int Delphi_ListElementUI_GetIndex(CListElementUI* handle) {
	return handle->GetIndex();
}

DIRECTUILIB_API void Delphi_ListElementUI_SetIndex(CListElementUI* handle, int iIndex) {
	handle->SetIndex(iIndex);
}

DIRECTUILIB_API IListOwnerUI* Delphi_ListElementUI_GetOwner(CListElementUI* handle) {
	return handle->GetOwner();
}

DIRECTUILIB_API void Delphi_ListElementUI_SetOwner(CListElementUI* handle, CControlUI* pOwner) {
	handle->SetOwner(pOwner);
}

DIRECTUILIB_API void Delphi_ListElementUI_SetVisible(CListElementUI* handle, bool bVisible) {
	handle->SetVisible(bVisible);
}

DIRECTUILIB_API bool Delphi_ListElementUI_IsSelected(CListElementUI* handle) {
	return handle->IsSelected();
}

DIRECTUILIB_API bool Delphi_ListElementUI_Select(CListElementUI* handle, bool bSelect) {
	return handle->Select(bSelect);
}

DIRECTUILIB_API bool Delphi_ListElementUI_IsExpanded(CListElementUI* handle) {
	return handle->IsExpanded();
}

DIRECTUILIB_API bool Delphi_ListElementUI_Expand(CListElementUI* handle, bool bExpand) {
	return handle->Expand(bExpand);
}

DIRECTUILIB_API void Delphi_ListElementUI_Invalidate(CListElementUI* handle) {
	handle->Invalidate();
}

DIRECTUILIB_API bool Delphi_ListElementUI_Activate(CListElementUI* handle) {
	return handle->Activate();
}

DIRECTUILIB_API void Delphi_ListElementUI_DoEvent(CListElementUI* handle, TEventUI& event) {
	handle->DoEvent(event);
}

DIRECTUILIB_API void Delphi_ListElementUI_SetAttribute(CListElementUI* handle, LPCTSTR pstrName, LPCTSTR pstrValue) {
	handle->SetAttribute(pstrName, pstrValue);
}

DIRECTUILIB_API void Delphi_ListElementUI_DrawItemBk(CListElementUI* handle, HDC hDC, RECT& rcItem) {
	handle->DrawItemBk(hDC, rcItem);
}

//================================CListLabelElementUI============================

DIRECTUILIB_API CListLabelElementUI* Delphi_ListLabelElementUI_CppCreate() {
	return new CListLabelElementUI();
}

DIRECTUILIB_API void Delphi_ListLabelElementUI_CppDestroy(CListLabelElementUI* handle) {
	delete handle;
}

DIRECTUILIB_API LPCTSTR Delphi_ListLabelElementUI_GetClass(CListLabelElementUI* handle) {
	return handle->GetClass();
}

DIRECTUILIB_API LPVOID Delphi_ListLabelElementUI_GetInterface(CListLabelElementUI* handle, LPCTSTR pstrName) {
	return handle->GetInterface(pstrName);
}

DIRECTUILIB_API void Delphi_ListLabelElementUI_DoEvent(CListLabelElementUI* handle, TEventUI& event) {
	handle->DoEvent(event);
}

DIRECTUILIB_API void Delphi_ListLabelElementUI_EstimateSize(CListLabelElementUI* handle, SIZE szAvailable, SIZE& Result) {
	Result = handle->EstimateSize(szAvailable);
}

DIRECTUILIB_API void Delphi_ListLabelElementUI_DoPaint(CListLabelElementUI* handle, HDC hDC, RECT& rcPaint) {
	handle->DoPaint(hDC, rcPaint);
}

DIRECTUILIB_API void Delphi_ListLabelElementUI_DrawItemText(CListLabelElementUI* handle, HDC hDC, RECT& rcItem) {
	handle->DrawItemText(hDC, rcItem);
}

//================================CListTextElementUI============================

DIRECTUILIB_API CListTextElementUI* Delphi_ListTextElementUI_CppCreate() {
	return new CListTextElementUI();
}

DIRECTUILIB_API void Delphi_ListTextElementUI_CppDestroy(CListTextElementUI* handle) {
	delete handle;
}

DIRECTUILIB_API LPCTSTR Delphi_ListTextElementUI_GetClass(CListTextElementUI* handle) {
	return handle->GetClass();
}

DIRECTUILIB_API LPVOID Delphi_ListTextElementUI_GetInterface(CListTextElementUI* handle, LPCTSTR pstrName) {
	return handle->GetInterface(pstrName);
}

DIRECTUILIB_API UINT Delphi_ListTextElementUI_GetControlFlags(CListTextElementUI* handle) {
	return handle->GetControlFlags();
}

DIRECTUILIB_API LPCTSTR Delphi_ListTextElementUI_GetText(CListTextElementUI* handle, int iIndex) {
	return handle->GetText(iIndex);
}

DIRECTUILIB_API void Delphi_ListTextElementUI_SetText(CListTextElementUI* handle, int iIndex, LPCTSTR pstrText) {
	handle->SetText(iIndex, pstrText);
}

DIRECTUILIB_API void Delphi_ListTextElementUI_SetOwner(CListTextElementUI* handle, CControlUI* pOwner) {
	handle->SetOwner(pOwner);
}

DIRECTUILIB_API CDuiString* Delphi_ListTextElementUI_GetLinkContent(CListTextElementUI* handle, int iIndex) {
	return handle->GetLinkContent(iIndex);
}

DIRECTUILIB_API void Delphi_ListTextElementUI_DoEvent(CListTextElementUI* handle, TEventUI& event) {
	handle->DoEvent(event);
}

DIRECTUILIB_API void Delphi_ListTextElementUI_EstimateSize(CListTextElementUI* handle, SIZE szAvailable, SIZE& Result) {
	Result = handle->EstimateSize(szAvailable);
}

DIRECTUILIB_API void Delphi_ListTextElementUI_DrawItemText(CListTextElementUI* handle, HDC hDC, RECT& rcItem) {
	handle->DrawItemText(hDC, rcItem);
}


//================================CGifAnimUI============================

DIRECTUILIB_API CGifAnimUI* Delphi_GifAnimUI_CppCreate() {
	return new CGifAnimUI();
}

DIRECTUILIB_API void Delphi_GifAnimUI_CppDestroy(CGifAnimUI* handle) {
	delete handle;
}

DIRECTUILIB_API LPCTSTR Delphi_GifAnimUI_GetClass(CGifAnimUI* handle) {
	return handle->GetClass();
}

DIRECTUILIB_API LPVOID Delphi_GifAnimUI_GetInterface(CGifAnimUI* handle, LPCTSTR pstrName) {
	return handle->GetInterface(pstrName);
}

DIRECTUILIB_API void Delphi_GifAnimUI_DoInit(CGifAnimUI* handle) {
	handle->DoInit();
}

DIRECTUILIB_API void Delphi_GifAnimUI_DoPaint(CGifAnimUI* handle, HDC hDC, RECT& rcPaint) {
	handle->DoPaint(hDC, rcPaint);
}

DIRECTUILIB_API void Delphi_GifAnimUI_DoEvent(CGifAnimUI* handle, TEventUI& event) {
	handle->DoEvent(event);
}

DIRECTUILIB_API void Delphi_GifAnimUI_SetVisible(CGifAnimUI* handle, bool bVisible) {
	handle->SetVisible(bVisible);
}

DIRECTUILIB_API void Delphi_GifAnimUI_SetAttribute(CGifAnimUI* handle, LPCTSTR pstrName, LPCTSTR pstrValue) {
	handle->SetAttribute(pstrName, pstrValue);
}

DIRECTUILIB_API void Delphi_GifAnimUI_SetBkImage(CGifAnimUI* handle, LPCTSTR pStrImage) {
	handle->SetBkImage(pStrImage);
}

DIRECTUILIB_API LPCTSTR Delphi_GifAnimUI_GetBkImage(CGifAnimUI* handle) {
	return handle->GetBkImage();
}

DIRECTUILIB_API void Delphi_GifAnimUI_SetAutoPlay(CGifAnimUI* handle, bool bIsAuto) {
	handle->SetAutoPlay(bIsAuto);
}

DIRECTUILIB_API bool Delphi_GifAnimUI_IsAutoPlay(CGifAnimUI* handle) {
	return handle->IsAutoPlay();
}

DIRECTUILIB_API void Delphi_GifAnimUI_SetAutoSize(CGifAnimUI* handle, bool bIsAuto) {
	handle->SetAutoSize(bIsAuto);
}

DIRECTUILIB_API bool Delphi_GifAnimUI_IsAutoSize(CGifAnimUI* handle) {
	return handle->IsAutoSize();
}

DIRECTUILIB_API void Delphi_GifAnimUI_PlayGif(CGifAnimUI* handle) {
	handle->PlayGif();
}

DIRECTUILIB_API void Delphi_GifAnimUI_PauseGif(CGifAnimUI* handle) {
	handle->PauseGif();
}

DIRECTUILIB_API void Delphi_GifAnimUI_StopGif(CGifAnimUI* handle) {
	handle->StopGif();
}

//================================CChildLayoutUI============================

DIRECTUILIB_API CChildLayoutUI* Delphi_ChildLayoutUI_CppCreate() {
	return new CChildLayoutUI();
}

DIRECTUILIB_API void Delphi_ChildLayoutUI_CppDestroy(CChildLayoutUI* handle) {
	delete handle;
}

DIRECTUILIB_API void Delphi_ChildLayoutUI_Init(CChildLayoutUI* handle) {
	handle->Init();
}

DIRECTUILIB_API void Delphi_ChildLayoutUI_SetAttribute(CChildLayoutUI* handle, LPCTSTR pstrName, LPCTSTR pstrValue) {
	handle->SetAttribute(pstrName, pstrValue);
}

DIRECTUILIB_API void Delphi_ChildLayoutUI_SetChildLayoutXML(CChildLayoutUI* handle, CDuiString pXML) {
	handle->SetChildLayoutXML(pXML);
}

DIRECTUILIB_API CDuiString Delphi_ChildLayoutUI_GetChildLayoutXML(CChildLayoutUI* handle) {
	return handle->GetChildLayoutXML();
}

DIRECTUILIB_API LPVOID Delphi_ChildLayoutUI_GetInterface(CChildLayoutUI* handle, LPCTSTR pstrName) {
	return handle->GetInterface(pstrName);
}

DIRECTUILIB_API LPCTSTR Delphi_ChildLayoutUI_GetClass(CChildLayoutUI* handle) {
	return handle->GetClass();
}

//================================CTileLayoutUI============================

DIRECTUILIB_API CTileLayoutUI* Delphi_TileLayoutUI_CppCreate() {
	return new CTileLayoutUI();
}

DIRECTUILIB_API void Delphi_TileLayoutUI_CppDestroy(CTileLayoutUI* handle) {
	delete handle;
}

DIRECTUILIB_API LPCTSTR Delphi_TileLayoutUI_GetClass(CTileLayoutUI* handle) {
	return handle->GetClass();
}

DIRECTUILIB_API LPVOID Delphi_TileLayoutUI_GetInterface(CTileLayoutUI* handle, LPCTSTR pstrName) {
	return handle->GetInterface(pstrName);
}

DIRECTUILIB_API void Delphi_TileLayoutUI_SetPos(CTileLayoutUI* handle, RECT rc, bool bNeedInvalidate) {
	handle->SetPos(rc, bNeedInvalidate);
}

DIRECTUILIB_API void Delphi_TileLayoutUI_GetItemSize(CTileLayoutUI* handle, SIZE& Result) {
	Result = handle->GetItemSize();
}

DIRECTUILIB_API void Delphi_TileLayoutUI_SetItemSize(CTileLayoutUI* handle, SIZE szItem) {
	handle->SetItemSize(szItem);
}

DIRECTUILIB_API int Delphi_TileLayoutUI_GetColumns(CTileLayoutUI* handle) {
	return handle->GetColumns();
}

DIRECTUILIB_API void Delphi_TileLayoutUI_SetColumns(CTileLayoutUI* handle, int nCols) {
	handle->SetColumns(nCols);
}

DIRECTUILIB_API void Delphi_TileLayoutUI_SetAttribute(CTileLayoutUI* handle, LPCTSTR pstrName, LPCTSTR pstrValue) {
	handle->SetAttribute(pstrName, pstrValue);
}


//================================CNativeControlUI============================

DIRECTUILIB_API CNativeControlUI* Delphi_NativeControlUI_CppCreate(HWND hWnd) {
    return new CNativeControlUI(hWnd);
}

DIRECTUILIB_API void Delphi_NativeControlUI_CppDestroy(CNativeControlUI* handle) {
    delete handle;
}

DIRECTUILIB_API void Delphi_NativeControlUI_SetInternVisible(CNativeControlUI* handle ,bool bVisible) {
    handle->SetInternVisible(bVisible);
}

DIRECTUILIB_API void Delphi_NativeControlUI_SetVisible(CNativeControlUI* handle, bool bVisible) {
	handle->SetVisible(bVisible);
}

DIRECTUILIB_API void Delphi_NativeControlUI_SetPos(CNativeControlUI* handle ,RECT rc, bool bNeedInvalidate) {
    handle->SetPos(rc, bNeedInvalidate);
}

DIRECTUILIB_API LPCTSTR Delphi_NativeControlUI_GetClass(CNativeControlUI* handle) {
    return handle->GetClass();
}

DIRECTUILIB_API CDuiString Delphi_NativeControlUI_GetText(CNativeControlUI* handle) {
    return handle->GetText();
}

DIRECTUILIB_API void Delphi_NativeControlUI_SetText(CNativeControlUI* handle ,LPCTSTR pstrText) {
    handle->SetText(pstrText);
}

DIRECTUILIB_API void Delphi_NativeControlUI_SetNativeHandle(CNativeControlUI* handle, HWND hWd) {
	handle->SetNativeHandle(hWd);
}



//================================CWkeWebbrowserUI============================
/*
DIRECTUILIB_API CWkeWebbrowserUI* Delphi_WkeWebbrowserUI_CppCreate() {
    return new CWkeWebbrowserUI();
}

DIRECTUILIB_API void Delphi_WkeWebbrowserUI_CppDestroy(CWkeWebbrowserUI* handle) {
    delete handle;
}

DIRECTUILIB_API void Delphi_WkeWebbrowserUI_SetSetInternVisibleCallback(CWkeWebbrowserUI* handle ,SetInternVisibleCallback ACallback) {
    handle->SetSetInternVisibleCallback(ACallback);
}

DIRECTUILIB_API void Delphi_WkeWebbrowserUI_SetSetPosCallback(CWkeWebbrowserUI* handle ,SetPosCallback ACallback) {
    handle->SetSetPosCallback(ACallback);
}

DIRECTUILIB_API void Delphi_WkeWebbrowserUI_SetDelphiSelf(CWkeWebbrowserUI* handle ,LPVOID ASelf) {
    handle->SetDelphiSelf(ASelf);
}

DIRECTUILIB_API void Delphi_WkeWebbrowserUI_SetDoEventCallback(CWkeWebbrowserUI* handle ,DoEventCallBack ACallback) {
    handle->SetDoEventCallback(ACallback);
}

DIRECTUILIB_API void Delphi_WkeWebbrowserUI_SetDoPaintCallback(CWkeWebbrowserUI* handle ,DoPaintCallback ACallback) {
    handle->SetDoPaintCallback(ACallback);
}
*/
//================================CMenuUI============================

DIRECTUILIB_API CMenuUI* Delphi_MenuUI_CppCreate() {
	return new CMenuUI();
}

DIRECTUILIB_API void Delphi_MenuUI_CppDestroy(CMenuUI* handle) {
	delete handle;
}

DIRECTUILIB_API LPCTSTR Delphi_MenuUI_GetClass(CMenuUI* handle) {
	return handle->GetClass();
}

DIRECTUILIB_API LPVOID Delphi_MenuUI_GetInterface(CMenuUI* handle, LPCTSTR pstrName) {
	return handle->GetInterface(pstrName);
}

DIRECTUILIB_API void Delphi_MenuUI_DoEvent(CMenuUI* handle, TEventUI& event) {
	handle->DoEvent(event);
}

DIRECTUILIB_API bool Delphi_MenuUI_Add(CMenuUI* handle, CControlUI* pControl) {
	return handle->Add(pControl);
}

DIRECTUILIB_API bool Delphi_MenuUI_AddAt(CMenuUI* handle, CControlUI* pControl, int iIndex) {
	return handle->AddAt(pControl, iIndex);
}

DIRECTUILIB_API int Delphi_MenuUI_GetItemIndex(CMenuUI* handle, CControlUI* pControl) {
	return handle->GetItemIndex(pControl);
}

DIRECTUILIB_API bool Delphi_MenuUI_SetItemIndex(CMenuUI* handle, CControlUI* pControl, int iIndex) {
	return handle->SetItemIndex(pControl, iIndex);
}

DIRECTUILIB_API bool Delphi_MenuUI_Remove(CMenuUI* handle, CControlUI* pControl) {
	return handle->Remove(pControl);
}

DIRECTUILIB_API void Delphi_MenuUI_EstimateSize(CMenuUI* handle, SIZE szAvailable, SIZE& Result) {
	Result = handle->EstimateSize(szAvailable);
}

DIRECTUILIB_API void Delphi_MenuUI_SetAttribute(CMenuUI* handle, LPCTSTR pstrName, LPCTSTR pstrValue) {
	handle->SetAttribute(pstrName, pstrValue);
}

//================================CMenuWnd============================

DIRECTUILIB_API CMenuWnd* Delphi_MenuWnd_CppCreate(HWND hParent, CPaintManagerUI* pMainPaint) {
	return new CMenuWnd(hParent, pMainPaint);
}

DIRECTUILIB_API void Delphi_MenuWnd_CppDestroy(CMenuWnd* handle) {
	delete handle;
}

DIRECTUILIB_API void Delphi_MenuWnd_Init(CMenuWnd* handle, CMenuElementUI* pOwner, STRINGorID xml, LPCTSTR pSkinType, POINT point) {
	handle->Init(pOwner, xml, pSkinType, point);
}

DIRECTUILIB_API LPCTSTR Delphi_MenuWnd_GetWindowClassName(CMenuWnd* handle) {
	return handle->GetWindowClassName();
}

DIRECTUILIB_API void Delphi_MenuWnd_OnFinalMessage(CMenuWnd* handle, HWND hWnd) {
	handle->OnFinalMessage(hWnd);
}

DIRECTUILIB_API LRESULT Delphi_MenuWnd_HandleMessage(CMenuWnd* handle, UINT uMsg, WPARAM wParam, LPARAM lParam) {
	return handle->HandleMessage(uMsg, wParam, lParam);
}

DIRECTUILIB_API BOOL Delphi_MenuWnd_Receive(CMenuWnd* handle, ContextMenuParam param) {
	return handle->Receive(param);
}

//================================CMenuElementUI============================

DIRECTUILIB_API CMenuElementUI* Delphi_MenuElementUI_CppCreate() {
	return new CMenuElementUI();
}

DIRECTUILIB_API void Delphi_MenuElementUI_CppDestroy(CMenuElementUI* handle) {
	delete handle;
}

DIRECTUILIB_API LPCTSTR Delphi_MenuElementUI_GetClass(CMenuElementUI* handle) {
	return handle->GetClass();
}

DIRECTUILIB_API LPVOID Delphi_MenuElementUI_GetInterface(CMenuElementUI* handle, LPCTSTR pstrName) {
	return handle->GetInterface(pstrName);
}

DIRECTUILIB_API void Delphi_MenuElementUI_DoPaint(CMenuElementUI* handle, HDC hDC, RECT& rcPaint) {
	handle->DoPaint(hDC, rcPaint);
}

DIRECTUILIB_API void Delphi_MenuElementUI_DrawItemText(CMenuElementUI* handle, HDC hDC, RECT& rcItem) {
	handle->DrawItemText(hDC, rcItem);
}

DIRECTUILIB_API void Delphi_MenuElementUI_EstimateSize(CMenuElementUI* handle, SIZE szAvailable, SIZE& Result) {
	Result = handle->EstimateSize(szAvailable);
}

DIRECTUILIB_API bool Delphi_MenuElementUI_Activate(CMenuElementUI* handle) {
	return handle->Activate();
}

DIRECTUILIB_API void Delphi_MenuElementUI_DoEvent(CMenuElementUI* handle, TEventUI& event) {
	handle->DoEvent(event);
}

DIRECTUILIB_API CMenuWnd* Delphi_MenuElementUI_GetMenuWnd(CMenuElementUI* handle) {
	return handle->GetMenuWnd();
}

DIRECTUILIB_API void Delphi_MenuElementUI_CreateMenuWnd(CMenuElementUI* handle) {
	handle->CreateMenuWnd();
}