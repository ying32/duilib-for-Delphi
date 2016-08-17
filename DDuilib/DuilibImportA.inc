 //================================CStdStringPtrMap============================

function Delphi_StdStringPtrMap_CppCreate: CStdStringPtrMap; cdecl;
procedure Delphi_StdStringPtrMap_CppDestroy(Handle: CStdStringPtrMap); cdecl;
procedure Delphi_StdStringPtrMap_Resize(Handle: CStdStringPtrMap; nSize: Integer); cdecl;
function Delphi_StdStringPtrMap_Find(Handle: CStdStringPtrMap; key: LPCTSTR; optimize: Boolean): Pointer; cdecl;
function Delphi_StdStringPtrMap_Insert(Handle: CStdStringPtrMap; key: LPCTSTR; pData: Pointer): Boolean; cdecl;
function Delphi_StdStringPtrMap_Set(Handle: CStdStringPtrMap; key: LPCTSTR; pData: Pointer): Pointer; cdecl;
function Delphi_StdStringPtrMap_Remove(Handle: CStdStringPtrMap; key: LPCTSTR): Boolean; cdecl;
procedure Delphi_StdStringPtrMap_RemoveAll(Handle: CStdStringPtrMap); cdecl;
function Delphi_StdStringPtrMap_GetSize(Handle: CStdStringPtrMap): Integer; cdecl;
function Delphi_StdStringPtrMap_GetAt(Handle: CStdStringPtrMap; iIndex: Integer): LPCTSTR; cdecl;

//================================CStdValArray============================

function Delphi_StdValArray_CppCreate(iElementSize: Integer; iPreallocSize: Integer): CStdValArray; cdecl;
procedure Delphi_StdValArray_CppDestroy(Handle: CStdValArray); cdecl;
procedure Delphi_StdValArray_Empty(Handle: CStdValArray); cdecl;
function Delphi_StdValArray_IsEmpty(Handle: CStdValArray): Boolean; cdecl;
function Delphi_StdValArray_Add(Handle: CStdValArray; pData: LPCVOID): Boolean; cdecl;
function Delphi_StdValArray_Remove(Handle: CStdValArray; iIndex: Integer): Boolean; cdecl;
function Delphi_StdValArray_GetSize(Handle: CStdValArray): Integer; cdecl;
function Delphi_StdValArray_GetData(Handle: CStdValArray): Pointer; cdecl;
function Delphi_StdValArray_GetAt(Handle: CStdValArray; iIndex: Integer): Pointer; cdecl;

//================================CStdPtrArray============================

function Delphi_StdPtrArray_CppCreate: CStdPtrArray; cdecl;
procedure Delphi_StdPtrArray_CppDestroy(Handle: CStdPtrArray); cdecl;
procedure Delphi_StdPtrArray_Empty(Handle: CStdPtrArray); cdecl;
procedure Delphi_StdPtrArray_Resize(Handle: CStdPtrArray; iSize: Integer); cdecl;
function Delphi_StdPtrArray_IsEmpty(Handle: CStdPtrArray): Boolean; cdecl;
function Delphi_StdPtrArray_Find(Handle: CStdPtrArray; iIndex: Pointer): Integer; cdecl;
function Delphi_StdPtrArray_Add(Handle: CStdPtrArray; pData: Pointer): Boolean; cdecl;
function Delphi_StdPtrArray_SetAt(Handle: CStdPtrArray; iIndex: Integer; pData: Pointer): Boolean; cdecl;
function Delphi_StdPtrArray_InsertAt(Handle: CStdPtrArray; iIndex: Integer; pData: Pointer): Boolean; cdecl;
function Delphi_StdPtrArray_Remove(Handle: CStdPtrArray; iIndex: Integer): Boolean; cdecl;
function Delphi_StdPtrArray_GetSize(Handle: CStdPtrArray): Integer; cdecl;
function Delphi_StdPtrArray_GetData(Handle: CStdPtrArray): Pointer; cdecl;
function Delphi_StdPtrArray_GetAt(Handle: CStdPtrArray; iIndex: Integer): Pointer; cdecl;

//================================CNotifyPump============================

function Delphi_NotifyPump_CppCreate: CNotifyPump; cdecl;
procedure Delphi_NotifyPump_CppDestroy(Handle: CNotifyPump); cdecl;
function Delphi_NotifyPump_AddVirtualWnd(Handle: CNotifyPump; strName: CDuiString; pObject: CNotifyPump): Boolean; cdecl;
function Delphi_NotifyPump_RemoveVirtualWnd(Handle: CNotifyPump; strName: CDuiString): Boolean; cdecl;
procedure Delphi_NotifyPump_NotifyPump(Handle: CNotifyPump; var msg: TNotifyUI); cdecl;
function Delphi_NotifyPump_LoopDispatch(Handle: CNotifyPump; var msg: TNotifyUI): Boolean; cdecl;

//================================CDialogBuilder============================

function Delphi_DialogBuilder_CppCreate: CDialogBuilder; cdecl;
procedure Delphi_DialogBuilder_CppDestroy(Handle: CDialogBuilder); cdecl;
function Delphi_DialogBuilder_Create_01(Handle: CDialogBuilder; xml: STRINGorID; AType: LPCTSTR; pCallback: IDialogBuilderCallback; pManager: CPaintManagerUI; pParent: CControlUI): CControlUI; cdecl;
function Delphi_DialogBuilder_Create_02(Handle: CDialogBuilder; pCallback: IDialogBuilderCallback; pManager: CPaintManagerUI; pParent: CControlUI): CControlUI; cdecl;
function Delphi_DialogBuilder_GetMarkup(Handle: CDialogBuilder): CMarkup; cdecl;
procedure Delphi_DialogBuilder_GetLastErrorMessage(Handle: CDialogBuilder; pstrMessage: LPTSTR; cchMax: SIZE_T); cdecl;
procedure Delphi_DialogBuilder_GetLastErrorLocation(Handle: CDialogBuilder; pstrSource: LPTSTR; cchMax: SIZE_T); cdecl;

//================================CMarkup============================

function Delphi_Markup_CppCreate(pstrXML: LPCTSTR): CMarkup; cdecl;
procedure Delphi_Markup_CppDestroy(Handle: CMarkup); cdecl;
function Delphi_Markup_Load(Handle: CMarkup; pstrXML: LPCTSTR): Boolean; cdecl;
function Delphi_Markup_LoadFromMem(Handle: CMarkup; pByte: PByte; dwSize: DWORD; encoding: Integer): Boolean; cdecl;
function Delphi_Markup_LoadFromFile(Handle: CMarkup; pstrFilename: LPCTSTR; encoding: Integer): Boolean; cdecl;
procedure Delphi_Markup_Release(Handle: CMarkup); cdecl;
function Delphi_Markup_IsValid(Handle: CMarkup): Boolean; cdecl;
procedure Delphi_Markup_SetPreserveWhitespace(Handle: CMarkup; bPreserve: Boolean); cdecl;
procedure Delphi_Markup_GetLastErrorMessage(Handle: CMarkup; pstrMessage: LPTSTR; cchMax: SIZE_T); cdecl;
procedure Delphi_Markup_GetLastErrorLocation(Handle: CMarkup; pstrSource: LPTSTR; cchMax: SIZE_T); cdecl;
function Delphi_Markup_GetRoot(Handle: CMarkup): CMarkupNode; cdecl;

//================================CMarkupNode============================

function Delphi_MarkupNode_CppCreate: CMarkupNode; cdecl;
procedure Delphi_MarkupNode_CppDestroy(Handle: CMarkupNode); cdecl;
function Delphi_MarkupNode_IsValid(Handle: CMarkupNode): Boolean; cdecl;
function Delphi_MarkupNode_GetParent(Handle: CMarkupNode): CMarkupNode; cdecl;
function Delphi_MarkupNode_GetSibling(Handle: CMarkupNode): CMarkupNode; cdecl;
function Delphi_MarkupNode_GetChild_01(Handle: CMarkupNode): CMarkupNode; cdecl;
function Delphi_MarkupNode_GetChild_02(Handle: CMarkupNode; pstrName: LPCTSTR): CMarkupNode; cdecl;
function Delphi_MarkupNode_HasSiblings(Handle: CMarkupNode): Boolean; cdecl;
function Delphi_MarkupNode_HasChildren(Handle: CMarkupNode): Boolean; cdecl;
function Delphi_MarkupNode_GetName(Handle: CMarkupNode): LPCTSTR; cdecl;
function Delphi_MarkupNode_GetValue(Handle: CMarkupNode): LPCTSTR; cdecl;
function Delphi_MarkupNode_HasAttributes(Handle: CMarkupNode): Boolean; cdecl;
function Delphi_MarkupNode_HasAttribute(Handle: CMarkupNode; pstrName: LPCTSTR): Boolean; cdecl;
function Delphi_MarkupNode_GetAttributeCount(Handle: CMarkupNode): Integer; cdecl;
function Delphi_MarkupNode_GetAttributeName(Handle: CMarkupNode; iIndex: Integer): LPCTSTR; cdecl;
function Delphi_MarkupNode_GetAttributeValue_01(Handle: CMarkupNode; iIndex: Integer): LPCTSTR; cdecl;
function Delphi_MarkupNode_GetAttributeValue_02(Handle: CMarkupNode; pstrName: LPCTSTR): LPCTSTR; cdecl;
function Delphi_MarkupNode_GetAttributeValue_03(Handle: CMarkupNode; iIndex: Integer; pstrValue: LPTSTR; cchMax: SIZE_T): Boolean; cdecl;
function Delphi_MarkupNode_GetAttributeValue_04(Handle: CMarkupNode; pstrName: LPCTSTR; pstrValue: LPTSTR; cchMax: SIZE_T): Boolean; cdecl;

//================================CControlUI============================

function Delphi_ControlUI_CppCreate: CControlUI; cdecl;
procedure Delphi_ControlUI_CppDestroy(Handle: CControlUI); cdecl;
function Delphi_ControlUI_GetName(Handle: CControlUI): CDuiString; cdecl;
procedure Delphi_ControlUI_SetName(Handle: CControlUI; pstrName: LPCTSTR); cdecl;
function Delphi_ControlUI_GetClass(Handle: CControlUI): LPCTSTR; cdecl;
function Delphi_ControlUI_GetInterface(Handle: CControlUI; pstrName: LPCTSTR): Pointer; cdecl;
function Delphi_ControlUI_GetControlFlags(Handle: CControlUI): UINT; cdecl;
function Delphi_ControlUI_GetNativeWindow(Handle: CControlUI): HWND; cdecl;
function Delphi_ControlUI_Activate(Handle: CControlUI): Boolean; cdecl;
function Delphi_ControlUI_GetManager(Handle: CControlUI): CPaintManagerUI; cdecl;
procedure Delphi_ControlUI_SetManager(Handle: CControlUI; pManager: CPaintManagerUI; pParent: CControlUI; bInit: Boolean); cdecl;
function Delphi_ControlUI_GetParent(Handle: CControlUI): CControlUI; cdecl;
function Delphi_ControlUI_GetText(Handle: CControlUI): CDuiString; cdecl;
procedure Delphi_ControlUI_SetText(Handle: CControlUI; pstrText: LPCTSTR); cdecl;
function Delphi_ControlUI_GetBkColor(Handle: CControlUI): DWORD; cdecl;
procedure Delphi_ControlUI_SetBkColor(Handle: CControlUI; dwBackColor: DWORD); cdecl;
function Delphi_ControlUI_GetBkColor2(Handle: CControlUI): DWORD; cdecl;
procedure Delphi_ControlUI_SetBkColor2(Handle: CControlUI; dwBackColor: DWORD); cdecl;
function Delphi_ControlUI_GetBkColor3(Handle: CControlUI): DWORD; cdecl;
procedure Delphi_ControlUI_SetBkColor3(Handle: CControlUI; dwBackColor: DWORD); cdecl;
function Delphi_ControlUI_GetBkImage(Handle: CControlUI): LPCTSTR; cdecl;
procedure Delphi_ControlUI_SetBkImage(Handle: CControlUI; pStrImage: LPCTSTR); cdecl;
function Delphi_ControlUI_GetFocusBorderColor(Handle: CControlUI): DWORD; cdecl;
procedure Delphi_ControlUI_SetFocusBorderColor(Handle: CControlUI; dwBorderColor: DWORD); cdecl;
function Delphi_ControlUI_IsColorHSL(Handle: CControlUI): Boolean; cdecl;
procedure Delphi_ControlUI_SetColorHSL(Handle: CControlUI; bColorHSL: Boolean); cdecl;
procedure Delphi_ControlUI_GetBorderRound(Handle: CControlUI; var Result: TSize); cdecl;
procedure Delphi_ControlUI_SetBorderRound(Handle: CControlUI; cxyRound: TSize); cdecl;
function Delphi_ControlUI_DrawImage(Handle: CControlUI; hDC: HDC; var drawInfo: TDrawInfo): Boolean; cdecl;
function Delphi_ControlUI_GetBorderColor(Handle: CControlUI): DWORD; cdecl;
procedure Delphi_ControlUI_SetBorderColor(Handle: CControlUI; dwBorderColor: DWORD); cdecl;
procedure Delphi_ControlUI_GetBorderSize(Handle: CControlUI; var Result: TRect); cdecl;
procedure Delphi_ControlUI_SetBorderSize_01(Handle: CControlUI; rc: TRect); cdecl;
procedure Delphi_ControlUI_SetBorderSize_02(Handle: CControlUI; iSize: Integer); cdecl;
function Delphi_ControlUI_GetBorderStyle(Handle: CControlUI): Integer; cdecl;
procedure Delphi_ControlUI_SetBorderStyle(Handle: CControlUI; nStyle: Integer); cdecl;
function Delphi_ControlUI_GetPos(Handle: CControlUI): PRect; cdecl;
procedure Delphi_ControlUI_GetRelativePos(Handle: CControlUI; var Result: TRect); cdecl;
procedure Delphi_ControlUI_GetClientPos(Handle: CControlUI; var Result: TRect); cdecl;
procedure Delphi_ControlUI_SetPos(Handle: CControlUI; rc: TRect; bNeedInvalidate: Boolean); cdecl;
procedure Delphi_ControlUI_Move(Handle: CControlUI; szOffset: TSize; bNeedInvalidate: Boolean); cdecl;
function Delphi_ControlUI_GetWidth(Handle: CControlUI): Integer; cdecl;
function Delphi_ControlUI_GetHeight(Handle: CControlUI): Integer; cdecl;
function Delphi_ControlUI_GetX(Handle: CControlUI): Integer; cdecl;
function Delphi_ControlUI_GetY(Handle: CControlUI): Integer; cdecl;
procedure Delphi_ControlUI_GetPadding(Handle: CControlUI; var Result: TRect); cdecl;
procedure Delphi_ControlUI_SetPadding(Handle: CControlUI; rcPadding: TRect); cdecl;
procedure Delphi_ControlUI_GetFixedXY(Handle: CControlUI; var Result: TSize); cdecl;
procedure Delphi_ControlUI_SetFixedXY(Handle: CControlUI; szXY: TSize); cdecl;
function Delphi_ControlUI_GetFixedWidth(Handle: CControlUI): Integer; cdecl;
procedure Delphi_ControlUI_SetFixedWidth(Handle: CControlUI; cx: Integer); cdecl;
function Delphi_ControlUI_GetFixedHeight(Handle: CControlUI): Integer; cdecl;
procedure Delphi_ControlUI_SetFixedHeight(Handle: CControlUI; cy: Integer); cdecl;
function Delphi_ControlUI_GetMinWidth(Handle: CControlUI): Integer; cdecl;
procedure Delphi_ControlUI_SetMinWidth(Handle: CControlUI; cx: Integer); cdecl;
function Delphi_ControlUI_GetMaxWidth(Handle: CControlUI): Integer; cdecl;
procedure Delphi_ControlUI_SetMaxWidth(Handle: CControlUI; cx: Integer); cdecl;
function Delphi_ControlUI_GetMinHeight(Handle: CControlUI): Integer; cdecl;
procedure Delphi_ControlUI_SetMinHeight(Handle: CControlUI; cy: Integer); cdecl;
function Delphi_ControlUI_GetMaxHeight(Handle: CControlUI): Integer; cdecl;
procedure Delphi_ControlUI_SetMaxHeight(Handle: CControlUI; cy: Integer); cdecl;
function Delphi_ControlUI_GetFloatPercent(Handle: CControlUI): TPercentInfo; cdecl;
procedure Delphi_ControlUI_SetFloatPercent(Handle: CControlUI; piFloatPercent: TPercentInfo); cdecl;
function Delphi_ControlUI_GetToolTip(Handle: CControlUI): CDuiString; cdecl;
procedure Delphi_ControlUI_SetToolTip(Handle: CControlUI; pstrText: LPCTSTR); cdecl;
procedure Delphi_ControlUI_SetToolTipWidth(Handle: CControlUI; nWidth: Integer); cdecl;
function Delphi_ControlUI_GetToolTipWidth(Handle: CControlUI): Integer; cdecl;
function Delphi_ControlUI_GetShortcut(Handle: CControlUI): Char; cdecl;
procedure Delphi_ControlUI_SetShortcut(Handle: CControlUI; ch: Char); cdecl;
function Delphi_ControlUI_IsContextMenuUsed(Handle: CControlUI): Boolean; cdecl;
procedure Delphi_ControlUI_SetContextMenuUsed(Handle: CControlUI; bMenuUsed: Boolean); cdecl;
function Delphi_ControlUI_GetUserData(Handle: CControlUI): PCDuiString; cdecl;
procedure Delphi_ControlUI_SetUserData(Handle: CControlUI; pstrText: LPCTSTR); cdecl;
function Delphi_ControlUI_GetTag(Handle: CControlUI): UINT_PTR; cdecl;
procedure Delphi_ControlUI_SetTag(Handle: CControlUI; pTag: UINT_PTR); cdecl;
function Delphi_ControlUI_IsVisible(Handle: CControlUI): Boolean; cdecl;
procedure Delphi_ControlUI_SetVisible(Handle: CControlUI; bVisible: Boolean); cdecl;
procedure Delphi_ControlUI_SetInternVisible(Handle: CControlUI; bVisible: Boolean); cdecl;
function Delphi_ControlUI_IsEnabled(Handle: CControlUI): Boolean; cdecl;
procedure Delphi_ControlUI_SetEnabled(Handle: CControlUI; bEnable: Boolean); cdecl;
function Delphi_ControlUI_IsMouseEnabled(Handle: CControlUI): Boolean; cdecl;
procedure Delphi_ControlUI_SetMouseEnabled(Handle: CControlUI; bEnable: Boolean); cdecl;
function Delphi_ControlUI_IsKeyboardEnabled(Handle: CControlUI): Boolean; cdecl;
procedure Delphi_ControlUI_SetKeyboardEnabled(Handle: CControlUI; bEnable: Boolean); cdecl;
function Delphi_ControlUI_IsFocused(Handle: CControlUI): Boolean; cdecl;
procedure Delphi_ControlUI_SetFocus(Handle: CControlUI); cdecl;
function Delphi_ControlUI_IsFloat(Handle: CControlUI): Boolean; cdecl;
procedure Delphi_ControlUI_SetFloat(Handle: CControlUI; bFloat: Boolean); cdecl;
procedure Delphi_ControlUI_AddCustomAttribute(Handle: CControlUI; pstrName: LPCTSTR; pstrAttr: LPCTSTR); cdecl;
function Delphi_ControlUI_GetCustomAttribute(Handle: CControlUI; pstrName: LPCTSTR): LPCTSTR; cdecl;
function Delphi_ControlUI_RemoveCustomAttribute(Handle: CControlUI; pstrName: LPCTSTR): Boolean; cdecl;
procedure Delphi_ControlUI_RemoveAllCustomAttribute(Handle: CControlUI); cdecl;
function Delphi_ControlUI_FindControl(Handle: CControlUI; Proc: TFindControlProc; pData: Pointer; uFlags: UINT): CControlUI; cdecl;
procedure Delphi_ControlUI_Invalidate(Handle: CControlUI); cdecl;
function Delphi_ControlUI_IsUpdateNeeded(Handle: CControlUI): Boolean; cdecl;
procedure Delphi_ControlUI_NeedUpdate(Handle: CControlUI); cdecl;
procedure Delphi_ControlUI_NeedParentUpdate(Handle: CControlUI); cdecl;
function Delphi_ControlUI_GetAdjustColor(Handle: CControlUI; dwColor: DWORD): DWORD; cdecl;
procedure Delphi_ControlUI_Init(Handle: CControlUI); cdecl;
procedure Delphi_ControlUI_DoInit(Handle: CControlUI); cdecl;
procedure Delphi_ControlUI_Event(Handle: CControlUI; var event: TEventUI); cdecl;
procedure Delphi_ControlUI_DoEvent(Handle: CControlUI; var event: TEventUI); cdecl;
procedure Delphi_ControlUI_SetAttribute(Handle: CControlUI; pstrName: LPCTSTR; pstrValue: LPCTSTR); cdecl;
function Delphi_ControlUI_ApplyAttributeList(Handle: CControlUI; pstrList: LPCTSTR): CControlUI; cdecl;
function Delphi_ControlUI_GetAttributeList(Handle: CControlUI): CDuiString; cdecl;
procedure Delphi_ControlUI_EstimateSize(Handle: CControlUI; szAvailable: TSize; var Result: TSize); cdecl;
procedure Delphi_ControlUI_Paint(Handle: CControlUI; hDC: HDC; var rcPaint: TRect; pStopControl: CControlUI); cdecl;
procedure Delphi_ControlUI_DoPaint(Handle: CControlUI; hDC: HDC; var rcPaint: TRect; pStopControl: CControlUI); cdecl;
procedure Delphi_ControlUI_PaintBkColor(Handle: CControlUI; hDC: HDC); cdecl;
procedure Delphi_ControlUI_PaintBkImage(Handle: CControlUI; hDC: HDC); cdecl;
procedure Delphi_ControlUI_PaintStatusImage(Handle: CControlUI; hDC: HDC); cdecl;
procedure Delphi_ControlUI_PaintText(Handle: CControlUI; hDC: HDC); cdecl;
procedure Delphi_ControlUI_PaintBorder(Handle: CControlUI; hDC: HDC); cdecl;
procedure Delphi_ControlUI_DoPostPaint(Handle: CControlUI; hDC: HDC; var rcPaint: TRect); cdecl;
procedure Delphi_ControlUI_SetVirtualWnd(Handle: CControlUI; pstrValue: LPCTSTR); cdecl;
function Delphi_ControlUI_GetVirtualWnd(Handle: CControlUI): CDuiString; cdecl;


//================================CDelphi_WindowImplBase============================

function Delphi_Delphi_WindowImplBase_CppCreate: CDelphi_WindowImplBase; cdecl;
procedure Delphi_Delphi_WindowImplBase_CppDestroy(Handle: CDelphi_WindowImplBase); cdecl;
function Delphi_Delphi_WindowImplBase_GetHWND(Handle: CDelphi_WindowImplBase): HWND; cdecl;
function Delphi_Delphi_WindowImplBase_RegisterWindowClass(Handle: CDelphi_WindowImplBase): Boolean; cdecl;
function Delphi_Delphi_WindowImplBase_RegisterSuperclass(Handle: CDelphi_WindowImplBase): Boolean; cdecl;
function Delphi_Delphi_WindowImplBase_Create_01(Handle: CDelphi_WindowImplBase; hwndParent: HWND; pstrName: LPCTSTR; dwStyle: DWORD; dwExStyle: DWORD; rc: TRect; hMenu: HMENU): HWND; cdecl;
function Delphi_Delphi_WindowImplBase_Create_02(Handle: CDelphi_WindowImplBase; hwndParent: HWND; pstrName: LPCTSTR; dwStyle: DWORD; dwExStyle: DWORD; x: Integer; y: Integer; cx: Integer; cy: Integer; hMenu: HMENU): HWND; cdecl;
function Delphi_Delphi_WindowImplBase_CreateDuiWindow(Handle: CDelphi_WindowImplBase; hwndParent: HWND; pstrWindowName: LPCTSTR; dwStyle: DWORD; dwExStyle: DWORD): HWND; cdecl;
function Delphi_Delphi_WindowImplBase_CreateDelphiWindow(Handle: CDelphi_WindowImplBase; DelphiHandle: HWND): HWND; cdecl;
function Delphi_Delphi_WindowImplBase_Subclass(Handle: CDelphi_WindowImplBase; hWnd: HWND): HWND; cdecl;
procedure Delphi_Delphi_WindowImplBase_Unsubclass(Handle: CDelphi_WindowImplBase); cdecl;
procedure Delphi_Delphi_WindowImplBase_ShowWindow(Handle: CDelphi_WindowImplBase; bShow: Boolean; bTakeFocus: Boolean); cdecl;
function Delphi_Delphi_WindowImplBase_ShowModal(Handle: CDelphi_WindowImplBase): UINT; cdecl;
procedure Delphi_Delphi_WindowImplBase_Close(Handle: CDelphi_WindowImplBase; nRet: UINT); cdecl;
procedure Delphi_Delphi_WindowImplBase_CenterWindow(Handle: CDelphi_WindowImplBase); cdecl;
procedure Delphi_Delphi_WindowImplBase_SetIcon(Handle: CDelphi_WindowImplBase; nRes: UINT); cdecl;
function Delphi_Delphi_WindowImplBase_SendMessage(Handle: CDelphi_WindowImplBase; uMsg: UINT; wParam: WPARAM; lParam: LPARAM): LRESULT; cdecl;
function Delphi_Delphi_WindowImplBase_PostMessage(Handle: CDelphi_WindowImplBase; uMsg: UINT; wParam: WPARAM; lParam: LPARAM): LRESULT; cdecl;
procedure Delphi_Delphi_WindowImplBase_ResizeClient(Handle: CDelphi_WindowImplBase; cx: Integer; cy: Integer); cdecl;
function Delphi_Delphi_WindowImplBase_AddVirtualWnd(Handle: CDelphi_WindowImplBase; strName: CDuiString; pObject: CNotifyPump): Boolean; cdecl;
function Delphi_Delphi_WindowImplBase_RemoveVirtualWnd(Handle: CDelphi_WindowImplBase; strName: CDuiString): Boolean; cdecl;
procedure Delphi_Delphi_WindowImplBase_NotifyPump(Handle: CDelphi_WindowImplBase; var msg: TNotifyUI); cdecl;
function Delphi_Delphi_WindowImplBase_LoopDispatch(Handle: CDelphi_WindowImplBase; var msg: TNotifyUI): Boolean; cdecl;
function Delphi_Delphi_WindowImplBase_GetPaintManagerUI(Handle: CDelphi_WindowImplBase): CPaintManagerUI; cdecl;
procedure Delphi_Delphi_WindowImplBase_SetDelphiSelf(Handle: CDelphi_WindowImplBase; ASelf: Pointer); cdecl;
procedure Delphi_Delphi_WindowImplBase_SetClassName(Handle: CDelphi_WindowImplBase; ClassName: LPCTSTR); cdecl;
procedure Delphi_Delphi_WindowImplBase_SetSkinFile(Handle: CDelphi_WindowImplBase; SkinFile: LPCTSTR); cdecl;
procedure Delphi_Delphi_WindowImplBase_SetSkinFolder(Handle: CDelphi_WindowImplBase; SkinFolder: LPCTSTR); cdecl;
procedure Delphi_Delphi_WindowImplBase_SetZipFileName(Handle: CDelphi_WindowImplBase; ZipFileName: LPCTSTR); cdecl;
procedure Delphi_Delphi_WindowImplBase_SetResSkin(Handle: CDelphi_WindowImplBase; ResSkin: LPCTSTR); cdecl;
procedure Delphi_Delphi_WindowImplBase_SetResourceType(Handle: CDelphi_WindowImplBase; RType: UILIB_RESOURCETYPE); cdecl;
procedure Delphi_Delphi_WindowImplBase_SetInitWindow(Handle: CDelphi_WindowImplBase; Callback: Pointer); cdecl;
procedure Delphi_Delphi_WindowImplBase_SetFinalMessage(Handle: CDelphi_WindowImplBase; Callback: Pointer); cdecl;
procedure Delphi_Delphi_WindowImplBase_SetHandleMessage(Handle: CDelphi_WindowImplBase; Callback: Pointer); cdecl;
procedure Delphi_Delphi_WindowImplBase_SetNotify(Handle: CDelphi_WindowImplBase; Callback: Pointer); cdecl;
procedure Delphi_Delphi_WindowImplBase_SetClick(Handle: CDelphi_WindowImplBase; Callback: Pointer); cdecl;
procedure Delphi_Delphi_WindowImplBase_SetMessageHandler(Handle: CDelphi_WindowImplBase; Callback: Pointer); cdecl;
procedure Delphi_Delphi_WindowImplBase_SetHandleCustomMessage(Handle: CDelphi_WindowImplBase; Callback: Pointer); cdecl;
procedure Delphi_Delphi_WindowImplBase_SetCreateControl(Handle: CDelphi_WindowImplBase; CallBack: Pointer); cdecl;
procedure Delphi_Delphi_WindowImplBase_SetGetItemText(Handle: CDelphi_WindowImplBase; CallBack: Pointer); cdecl;
procedure Delphi_Delphi_WindowImplBase_SetGetClassStyle(Handle: CDelphi_WindowImplBase; uStyle: UINT); cdecl;
procedure Delphi_Delphi_WindowImplBase_RemoveThisInPaintManager(Handle: CDelphi_WindowImplBase); cdecl;
procedure Delphi_Delphi_WindowImplBase_SetResponseDefaultKeyEvent(Handle: CDelphi_WindowImplBase; ACallBack: LPVOID); cdecl;
function Delphi_Delphi_WindowImplBase_DelphiMessage(Handle: CDelphi_WindowImplBase; uMsg: UINT; wParam: WPARAM; lParam: LPARAM): LRESULT; cdecl;


//================================CPaintManagerUI============================

function Delphi_PaintManagerUI_CppCreate: CPaintManagerUI; cdecl;
procedure Delphi_PaintManagerUI_CppDestroy(Handle: CPaintManagerUI); cdecl;
procedure Delphi_PaintManagerUI_Init(Handle: CPaintManagerUI; hWnd: HWND; pstrName: LPCTSTR); cdecl;
function Delphi_PaintManagerUI_IsUpdateNeeded(Handle: CPaintManagerUI): Boolean; cdecl;
procedure Delphi_PaintManagerUI_NeedUpdate(Handle: CPaintManagerUI); cdecl;
procedure Delphi_PaintManagerUI_Invalidate_01(Handle: CPaintManagerUI); cdecl;
procedure Delphi_PaintManagerUI_Invalidate_02(Handle: CPaintManagerUI; const rcItem: TRect); cdecl;
function Delphi_PaintManagerUI_GetPaintDC(Handle: CPaintManagerUI): HDC; cdecl;
function Delphi_PaintManagerUI_GetPaintOffscreenBitmap(Handle: CPaintManagerUI): HBITMAP; cdecl;
function Delphi_PaintManagerUI_GetPaintWindow(Handle: CPaintManagerUI): HWND; cdecl;
function Delphi_PaintManagerUI_GetTooltipWindow(Handle: CPaintManagerUI): HWND; cdecl;
function Delphi_PaintManagerUI_GetMousePos(Handle: CPaintManagerUI): TPoint; cdecl;
procedure Delphi_PaintManagerUI_GetClientSize(Handle: CPaintManagerUI; var Result: TSize); cdecl;
procedure Delphi_PaintManagerUI_GetInitSize(Handle: CPaintManagerUI; var Result: TSize); cdecl;
procedure Delphi_PaintManagerUI_SetInitSize(Handle: CPaintManagerUI; cx: Integer; cy: Integer); cdecl;
function Delphi_PaintManagerUI_GetSizeBox(Handle: CPaintManagerUI): PRect; cdecl;
procedure Delphi_PaintManagerUI_SetSizeBox(Handle: CPaintManagerUI; const rcSizeBox: TRect); cdecl;
function Delphi_PaintManagerUI_GetCaptionRect(Handle: CPaintManagerUI): PRect; cdecl;
procedure Delphi_PaintManagerUI_SetCaptionRect(Handle: CPaintManagerUI; const rcCaption: TRect); cdecl;
procedure Delphi_PaintManagerUI_GetRoundCorner(Handle: CPaintManagerUI; var Result: TSize); cdecl;
procedure Delphi_PaintManagerUI_SetRoundCorner(Handle: CPaintManagerUI; cx: Integer; cy: Integer); cdecl;
procedure Delphi_PaintManagerUI_GetMinInfo(Handle: CPaintManagerUI; var Result: TSize); cdecl;
procedure Delphi_PaintManagerUI_SetMinInfo(Handle: CPaintManagerUI; cx: Integer; cy: Integer); cdecl;
procedure Delphi_PaintManagerUI_GetMaxInfo(Handle: CPaintManagerUI; var Result: TSize); cdecl;
procedure Delphi_PaintManagerUI_SetMaxInfo(Handle: CPaintManagerUI; cx: Integer; cy: Integer); cdecl;
function Delphi_PaintManagerUI_IsShowUpdateRect(Handle: CPaintManagerUI): Boolean; cdecl;
procedure Delphi_PaintManagerUI_SetShowUpdateRect(Handle: CPaintManagerUI; show: Boolean); cdecl;
function Delphi_PaintManagerUI_GetInstance: HINST; cdecl;
function Delphi_PaintManagerUI_GetInstancePath: CDuiString; cdecl;
function Delphi_PaintManagerUI_GetCurrentPath: CDuiString; cdecl;
function Delphi_PaintManagerUI_GetResourceDll: HINST; cdecl;
function Delphi_PaintManagerUI_GetResourcePath: PCDuiString; cdecl;
function Delphi_PaintManagerUI_GetResourceZip: PCDuiString; cdecl;
function Delphi_PaintManagerUI_IsCachedResourceZip: Boolean; cdecl;
function Delphi_PaintManagerUI_GetResourceZipHandle: THandle; cdecl;
procedure Delphi_PaintManagerUI_SetInstance(hInst: HINST); cdecl;
procedure Delphi_PaintManagerUI_SetCurrentPath(pStrPath: LPCTSTR); cdecl;
procedure Delphi_PaintManagerUI_SetResourceDll(hInst: HINST); cdecl;
procedure Delphi_PaintManagerUI_SetResourcePath(pStrPath: LPCTSTR); cdecl;
procedure Delphi_PaintManagerUI_SetResourceZip_01(pVoid: Pointer; len: LongInt); cdecl;
procedure Delphi_PaintManagerUI_SetResourceZip_02(pstrZip: LPCTSTR; bCachedResourceZip: Boolean); cdecl;
function Delphi_PaintManagerUI_GetHSL(H: PShort; S: PShort; L: PShort): Boolean; cdecl;
procedure Delphi_PaintManagerUI_ReloadSkin; cdecl;
function Delphi_PaintManagerUI_LoadPlugin(pstrModuleName: LPCTSTR): Boolean; cdecl;
function Delphi_PaintManagerUI_GetPlugins: CStdPtrArray; cdecl;
function Delphi_PaintManagerUI_IsForceUseSharedRes(Handle: CPaintManagerUI): Boolean; cdecl;
procedure Delphi_PaintManagerUI_SetForceUseSharedRes(Handle: CPaintManagerUI; bForce: Boolean); cdecl;
function Delphi_PaintManagerUI_IsPainting(Handle: CPaintManagerUI): Boolean; cdecl;
procedure Delphi_PaintManagerUI_SetPainting(Handle: CPaintManagerUI; bIsPainting: Boolean); cdecl;
function Delphi_PaintManagerUI_GetDefaultDisabledColor(Handle: CPaintManagerUI): DWORD; cdecl;
procedure Delphi_PaintManagerUI_SetDefaultDisabledColor(Handle: CPaintManagerUI; dwColor: DWORD; bShared: Boolean); cdecl;
function Delphi_PaintManagerUI_GetDefaultFontColor(Handle: CPaintManagerUI): DWORD; cdecl;
procedure Delphi_PaintManagerUI_SetDefaultFontColor(Handle: CPaintManagerUI; dwColor: DWORD; bShared: Boolean); cdecl;
function Delphi_PaintManagerUI_GetDefaultLinkFontColor(Handle: CPaintManagerUI): DWORD; cdecl;
procedure Delphi_PaintManagerUI_SetDefaultLinkFontColor(Handle: CPaintManagerUI; dwColor: DWORD; bShared: Boolean); cdecl;
function Delphi_PaintManagerUI_GetDefaultLinkHoverFontColor(Handle: CPaintManagerUI): DWORD; cdecl;
procedure Delphi_PaintManagerUI_SetDefaultLinkHoverFontColor(Handle: CPaintManagerUI; dwColor: DWORD; bShared: Boolean); cdecl;
function Delphi_PaintManagerUI_GetDefaultSelectedBkColor(Handle: CPaintManagerUI): DWORD; cdecl;
procedure Delphi_PaintManagerUI_SetDefaultSelectedBkColor(Handle: CPaintManagerUI; dwColor: DWORD; bShared: Boolean); cdecl;
function Delphi_PaintManagerUI_GetDefaultFontInfo(Handle: CPaintManagerUI): PFontInfo; cdecl;
procedure Delphi_PaintManagerUI_SetDefaultFont(Handle: CPaintManagerUI; pStrFontName: LPCTSTR; nSize: Integer; bBold: Boolean; bUnderline: Boolean; bItalic: Boolean; bShared: Boolean); cdecl;
function Delphi_PaintManagerUI_GetCustomFontCount(Handle: CPaintManagerUI; bShared: Boolean): DWORD; cdecl;
function Delphi_PaintManagerUI_AddFont(Handle: CPaintManagerUI; id: Integer; pStrFontName: LPCTSTR; nSize: Integer; bBold: Boolean; bUnderline: Boolean; bItalic: Boolean; bShared: Boolean): HFONT; cdecl;
function Delphi_PaintManagerUI_GetFont_01(Handle: CPaintManagerUI; id: Integer): HFONT; cdecl;
function Delphi_PaintManagerUI_GetFont_02(Handle: CPaintManagerUI; pStrFontName: LPCTSTR; nSize: Integer; bBold: Boolean; bUnderline: Boolean; bItalic: Boolean): HFONT; cdecl;
function Delphi_PaintManagerUI_GetFontIndex_01(Handle: CPaintManagerUI; hFont: HFONT; bShared: Boolean): Integer; cdecl;
function Delphi_PaintManagerUI_GetFontIndex_02(Handle: CPaintManagerUI; pStrFontName: LPCTSTR; nSize: Integer; bBold: Boolean; bUnderline: Boolean; bItalic: Boolean; bShared: Boolean): Integer; cdecl;
procedure Delphi_PaintManagerUI_RemoveFont_01(Handle: CPaintManagerUI; hFont: HFONT; bShared: Boolean); cdecl;
procedure Delphi_PaintManagerUI_RemoveFont_02(Handle: CPaintManagerUI; id: Integer; bShared: Boolean); cdecl;
procedure Delphi_PaintManagerUI_RemoveAllFonts(Handle: CPaintManagerUI; bShared: Boolean); cdecl;
function Delphi_PaintManagerUI_GetFontInfo_01(Handle: CPaintManagerUI; id: Integer): PFontInfo; cdecl;
function Delphi_PaintManagerUI_GetFontInfo_02(Handle: CPaintManagerUI; hFont: HFONT): PFontInfo; cdecl;
function Delphi_PaintManagerUI_GetImage(Handle: CPaintManagerUI; bitmap: LPCTSTR): PImageInfo; cdecl;
function Delphi_PaintManagerUI_GetImageEx(Handle: CPaintManagerUI; bitmap: LPCTSTR; AType: LPCTSTR; mask: DWORD; bUseHSL: Boolean): PImageInfo; cdecl;
function Delphi_PaintManagerUI_AddImage_01(Handle: CPaintManagerUI; bitmap: LPCTSTR; AType: LPCTSTR; mask: DWORD; bUseHSL: Boolean; bShared: Boolean): PImageInfo; cdecl;
function Delphi_PaintManagerUI_AddImage_02(Handle: CPaintManagerUI; bitmap: LPCTSTR; hBitmap: HBITMAP; iWidth: Integer; iHeight: Integer; bAlpha: Boolean; bShared: Boolean): PImageInfo; cdecl;
procedure Delphi_PaintManagerUI_RemoveImage(Handle: CPaintManagerUI; bitmap: LPCTSTR; bShared: Boolean); cdecl;
procedure Delphi_PaintManagerUI_RemoveAllImages(Handle: CPaintManagerUI; bShared: Boolean); cdecl;
procedure Delphi_PaintManagerUI_ReloadSharedImages; cdecl;
procedure Delphi_PaintManagerUI_ReloadImages(Handle: CPaintManagerUI); cdecl;
procedure Delphi_PaintManagerUI_AddDefaultAttributeList(Handle: CPaintManagerUI; pStrControlName: LPCTSTR; pStrControlAttrList: LPCTSTR; bShared: Boolean); cdecl;
function Delphi_PaintManagerUI_GetDefaultAttributeList(Handle: CPaintManagerUI; pStrControlName: LPCTSTR): LPCTSTR; cdecl;
function Delphi_PaintManagerUI_RemoveDefaultAttributeList(Handle: CPaintManagerUI; pStrControlName: LPCTSTR; bShared: Boolean): Boolean; cdecl;
procedure Delphi_PaintManagerUI_RemoveAllDefaultAttributeList(Handle: CPaintManagerUI; bShared: Boolean); cdecl;
procedure Delphi_PaintManagerUI_AddMultiLanguageString(id: Integer; pStrMultiLanguage: LPCTSTR); cdecl;
function Delphi_PaintManagerUI_GetMultiLanguageString(id: Integer): LPCTSTR; cdecl;
function Delphi_PaintManagerUI_RemoveMultiLanguageString(id: Integer): Boolean; cdecl;
procedure Delphi_PaintManagerUI_RemoveAllMultiLanguageString; cdecl;
procedure Delphi_PaintManagerUI_ProcessMultiLanguageTokens(var pStrMultiLanguage: CDuiString); cdecl;
function Delphi_PaintManagerUI_AttachDialog(Handle: CPaintManagerUI; pControl: CControlUI): Boolean; cdecl;
function Delphi_PaintManagerUI_InitControls(Handle: CPaintManagerUI; pControl: CControlUI; pParent: CControlUI): Boolean; cdecl;
function Delphi_PaintManagerUI_RenameControl(Handle: CPaintManagerUI; pControl: CControlUI; pstrName: LPCTSTR): Boolean; cdecl;
procedure Delphi_PaintManagerUI_ReapObjects(Handle: CPaintManagerUI; pControl: CControlUI); cdecl;
function Delphi_PaintManagerUI_AddOptionGroup(Handle: CPaintManagerUI; pStrGroupName: LPCTSTR; pControl: CControlUI): Boolean; cdecl;
function Delphi_PaintManagerUI_GetOptionGroup(Handle: CPaintManagerUI; pStrGroupName: LPCTSTR): CStdPtrArray; cdecl;
procedure Delphi_PaintManagerUI_RemoveOptionGroup(Handle: CPaintManagerUI; pStrGroupName: LPCTSTR; pControl: CControlUI); cdecl;
procedure Delphi_PaintManagerUI_RemoveAllOptionGroups(Handle: CPaintManagerUI); cdecl;
function Delphi_PaintManagerUI_GetFocus(Handle: CPaintManagerUI): CControlUI; cdecl;
procedure Delphi_PaintManagerUI_SetFocus(Handle: CPaintManagerUI; pControl: CControlUI; bFocusWnd: Boolean); cdecl;
procedure Delphi_PaintManagerUI_SetFocusNeeded(Handle: CPaintManagerUI; pControl: CControlUI); cdecl;
function Delphi_PaintManagerUI_SetNextTabControl(Handle: CPaintManagerUI; bForward: Boolean): Boolean; cdecl;
function Delphi_PaintManagerUI_SetTimer(Handle: CPaintManagerUI; pControl: CControlUI; nTimerID: UINT; uElapse: UINT): Boolean; cdecl;
function Delphi_PaintManagerUI_KillTimer_01(Handle: CPaintManagerUI; pControl: CControlUI; nTimerID: UINT): Boolean; cdecl;
procedure Delphi_PaintManagerUI_KillTimer_02(Handle: CPaintManagerUI; pControl: CControlUI); cdecl;
procedure Delphi_PaintManagerUI_RemoveAllTimers(Handle: CPaintManagerUI); cdecl;
procedure Delphi_PaintManagerUI_SetCapture(Handle: CPaintManagerUI); cdecl;
procedure Delphi_PaintManagerUI_ReleaseCapture(Handle: CPaintManagerUI); cdecl;
function Delphi_PaintManagerUI_IsCaptured(Handle: CPaintManagerUI): Boolean; cdecl;
function Delphi_PaintManagerUI_AddNotifier(Handle: CPaintManagerUI; pControl: INotifyUI): Boolean; cdecl;
function Delphi_PaintManagerUI_RemoveNotifier(Handle: CPaintManagerUI; pControl: INotifyUI): Boolean; cdecl;
procedure Delphi_PaintManagerUI_SendNotify_01(Handle: CPaintManagerUI; const Msg: TNotifyUI; bAsync: Boolean; bEnableRepeat: Boolean); cdecl;
procedure Delphi_PaintManagerUI_SendNotify_02(Handle: CPaintManagerUI; pControl: CControlUI; pstrMessage: LPCTSTR; wParam: WPARAM; lParam: LPARAM; bAsync: Boolean; bEnableRepeat: Boolean); cdecl;
function Delphi_PaintManagerUI_AddPreMessageFilter(Handle: CPaintManagerUI; pFilter: IMessageFilterUI): Boolean; cdecl;
function Delphi_PaintManagerUI_RemovePreMessageFilter(Handle: CPaintManagerUI; pFilter: IMessageFilterUI): Boolean; cdecl;
function Delphi_PaintManagerUI_AddMessageFilter(Handle: CPaintManagerUI; pFilter: IMessageFilterUI): Boolean; cdecl;
function Delphi_PaintManagerUI_RemoveMessageFilter(Handle: CPaintManagerUI; pFilter: IMessageFilterUI): Boolean; cdecl;
function Delphi_PaintManagerUI_GetPostPaintCount(Handle: CPaintManagerUI): Integer; cdecl;
function Delphi_PaintManagerUI_AddPostPaint(Handle: CPaintManagerUI; pControl: CControlUI): Boolean; cdecl;
function Delphi_PaintManagerUI_RemovePostPaint(Handle: CPaintManagerUI; pControl: CControlUI): Boolean; cdecl;
function Delphi_PaintManagerUI_SetPostPaintIndex(Handle: CPaintManagerUI; pControl: CControlUI; iIndex: Integer): Boolean; cdecl;
function Delphi_PaintManagerUI_GetNativeWindowCount(Handle: CPaintManagerUI): Integer; cdecl;
procedure Delphi_PaintManagerUI_GetNativeWindowRect(Handle: CPaintManagerUI; hChildWnd: HWND; var Result: TRect); cdecl;
function Delphi_PaintManagerUI_AddNativeWindow(Handle: CPaintManagerUI; pControl: CControlUI; hChildWnd: HWND): Boolean; cdecl;
function Delphi_PaintManagerUI_RemoveNativeWindow(Handle: CPaintManagerUI; hChildWnd: HWND): Boolean; cdecl;
procedure Delphi_PaintManagerUI_AddDelayedCleanup(Handle: CPaintManagerUI; pControl: CControlUI); cdecl;
function Delphi_PaintManagerUI_AddTranslateAccelerator(Handle: CPaintManagerUI; pTranslateAccelerator: ITranslateAccelerator): Boolean; cdecl;
function Delphi_PaintManagerUI_RemoveTranslateAccelerator(Handle: CPaintManagerUI; pTranslateAccelerator: ITranslateAccelerator): Boolean; cdecl;
function Delphi_PaintManagerUI_TranslateAccelerator(Handle: CPaintManagerUI; pMsg: PMsg): Boolean; cdecl;
function Delphi_PaintManagerUI_GetRoot(Handle: CPaintManagerUI): CControlUI; cdecl;
function Delphi_PaintManagerUI_FindControl_01(Handle: CPaintManagerUI; pt: TPoint): CControlUI; cdecl;
function Delphi_PaintManagerUI_FindControl_02(Handle: CPaintManagerUI; pstrName: LPCTSTR): CControlUI; cdecl;
function Delphi_PaintManagerUI_FindSubControlByPoint(Handle: CPaintManagerUI; pParent: CControlUI; pt: TPoint): CControlUI; cdecl;
function Delphi_PaintManagerUI_FindSubControlByName(Handle: CPaintManagerUI; pParent: CControlUI; pstrName: LPCTSTR): CControlUI; cdecl;
function Delphi_PaintManagerUI_FindSubControlByClass(Handle: CPaintManagerUI; pParent: CControlUI; pstrClass: LPCTSTR; iIndex: Integer): CControlUI; cdecl;
function Delphi_PaintManagerUI_FindSubControlsByClass(Handle: CPaintManagerUI; pParent: CControlUI; pstrClass: LPCTSTR): CStdPtrArray; cdecl;
procedure Delphi_PaintManagerUI_MessageLoop; cdecl;
function Delphi_PaintManagerUI_TranslateMessage(pMsg: PMsg): Boolean; cdecl;
procedure Delphi_PaintManagerUI_Term; cdecl;
function Delphi_PaintManagerUI_MessageHandler(Handle: CPaintManagerUI; uMsg: UINT; wParam: WPARAM; lParam: LPARAM; var lRes: LRESULT): Boolean; cdecl;
function Delphi_PaintManagerUI_PreMessageHandler(Handle: CPaintManagerUI; uMsg: UINT; wParam: WPARAM; lParam: LPARAM; var lRes: LRESULT): Boolean; cdecl;
procedure Delphi_PaintManagerUI_UsedVirtualWnd(Handle: CPaintManagerUI; bUsed: Boolean); cdecl;

function Delphi_PaintManagerUI_GetName(Handle: CPaintManagerUI): LPCTSTR; cdecl;
function Delphi_PaintManagerUI_GetTooltipWindowWidth(Handle: CPaintManagerUI): Integer; cdecl;
procedure Delphi_PaintManagerUI_SetTooltipWindowWidth(Handle: CPaintManagerUI; iWidth: Integer); cdecl;
function Delphi_PaintManagerUI_GetHoverTime(Handle: CPaintManagerUI): Integer; cdecl;
procedure Delphi_PaintManagerUI_SetHoverTime(Handle: CPaintManagerUI; iTime: Integer); cdecl;
function Delphi_PaintManagerUI_GetOpacity(Handle: CPaintManagerUI): Byte; cdecl;
procedure Delphi_PaintManagerUI_SetOpacity(Handle: CPaintManagerUI; nOpacity: Byte); cdecl;
function Delphi_PaintManagerUI_IsLayered(Handle: CPaintManagerUI): Boolean; cdecl;
procedure Delphi_PaintManagerUI_SetLayered(Handle: CPaintManagerUI; bLayered: Boolean); cdecl;
function Delphi_PaintManagerUI_GetLayeredInset(Handle: CPaintManagerUI): PRect; cdecl;
procedure Delphi_PaintManagerUI_SetLayeredInset(Handle: CPaintManagerUI; const rcLayeredInset: TRect); cdecl;
function Delphi_PaintManagerUI_GetLayeredOpacity(Handle: CPaintManagerUI): Byte; cdecl;
procedure Delphi_PaintManagerUI_SetLayeredOpacity(Handle: CPaintManagerUI; nOpacity: Byte); cdecl;
function Delphi_PaintManagerUI_GetLayeredImage(Handle: CPaintManagerUI): LPCTSTR; cdecl;
procedure Delphi_PaintManagerUI_SetLayeredImage(Handle: CPaintManagerUI; pstrImage: LPCTSTR); cdecl;
function Delphi_PaintManagerUI_GetPaintManager(pstrName: LPCTSTR): CPaintManagerUI; cdecl;
function Delphi_PaintManagerUI_GetPaintManagers: CStdPtrArray; cdecl;
procedure Delphi_PaintManagerUI_AddWindowCustomAttribute(Handle: CPaintManagerUI; pstrName: LPCTSTR; pstrAttr: LPCTSTR); cdecl;
function Delphi_PaintManagerUI_GetWindowCustomAttribute(Handle: CPaintManagerUI; pstrName: LPCTSTR): LPCTSTR; cdecl;
function Delphi_PaintManagerUI_RemoveWindowCustomAttribute(Handle: CPaintManagerUI; pstrName: LPCTSTR): Boolean; cdecl;
procedure Delphi_PaintManagerUI_RemoveAllWindowCustomAttribute(Handle: CPaintManagerUI); cdecl;
//================================CContainerUI============================

function Delphi_ContainerUI_CppCreate: CContainerUI; cdecl;
procedure Delphi_ContainerUI_CppDestroy(Handle: CContainerUI); cdecl;
function Delphi_ContainerUI_GetClass(Handle: CContainerUI): LPCTSTR; cdecl;
function Delphi_ContainerUI_GetInterface(Handle: CContainerUI; pstrName: LPCTSTR): Pointer; cdecl;
function Delphi_ContainerUI_GetItemAt(Handle: CContainerUI; iIndex: Integer): CControlUI; cdecl;
function Delphi_ContainerUI_GetItemIndex(Handle: CContainerUI; pControl: CControlUI): Integer; cdecl;
function Delphi_ContainerUI_SetItemIndex(Handle: CContainerUI; pControl: CControlUI; iIndex: Integer): Boolean; cdecl;
function Delphi_ContainerUI_GetCount(Handle: CContainerUI): Integer; cdecl;
function Delphi_ContainerUI_Add(Handle: CContainerUI; pControl: CControlUI): Boolean; cdecl;
function Delphi_ContainerUI_AddAt(Handle: CContainerUI; pControl: CControlUI; iIndex: Integer): Boolean; cdecl;
function Delphi_ContainerUI_Remove(Handle: CContainerUI; pControl: CControlUI): Boolean; cdecl;
function Delphi_ContainerUI_RemoveAt(Handle: CContainerUI; iIndex: Integer): Boolean; cdecl;
procedure Delphi_ContainerUI_RemoveAll(Handle: CContainerUI); cdecl;
procedure Delphi_ContainerUI_DoEvent(Handle: CContainerUI; var event: TEventUI); cdecl;
procedure Delphi_ContainerUI_SetVisible(Handle: CContainerUI; bVisible: Boolean); cdecl;
procedure Delphi_ContainerUI_SetInternVisible(Handle: CContainerUI; bVisible: Boolean); cdecl;
procedure Delphi_ContainerUI_SetMouseEnabled(Handle: CContainerUI; bEnable: Boolean); cdecl;
procedure Delphi_ContainerUI_GetInset(Handle: CContainerUI; var Result: TRect); cdecl;
procedure Delphi_ContainerUI_SetInset(Handle: CContainerUI; rcInset: TRect); cdecl;
function Delphi_ContainerUI_GetChildPadding(Handle: CContainerUI): Integer; cdecl;
procedure Delphi_ContainerUI_SetChildPadding(Handle: CContainerUI; iPadding: Integer); cdecl;
function Delphi_ContainerUI_GetChildAlign(Handle: CContainerUI): UINT; cdecl;
procedure Delphi_ContainerUI_SetChildAlign(Handle: CContainerUI; iAlign: UINT); cdecl;
function Delphi_ContainerUI_GetChildVAlign(Handle: CContainerUI): UINT; cdecl;
procedure Delphi_ContainerUI_SetChildVAlign(Handle: CContainerUI; iVAlign: UINT); cdecl;
function Delphi_ContainerUI_IsAutoDestroy(Handle: CContainerUI): Boolean; cdecl;
procedure Delphi_ContainerUI_SetAutoDestroy(Handle: CContainerUI; bAuto: Boolean); cdecl;
function Delphi_ContainerUI_IsDelayedDestroy(Handle: CContainerUI): Boolean; cdecl;
procedure Delphi_ContainerUI_SetDelayedDestroy(Handle: CContainerUI; bDelayed: Boolean); cdecl;
function Delphi_ContainerUI_IsMouseChildEnabled(Handle: CContainerUI): Boolean; cdecl;
procedure Delphi_ContainerUI_SetMouseChildEnabled(Handle: CContainerUI; bEnable: Boolean); cdecl;
function Delphi_ContainerUI_FindSelectable(Handle: CContainerUI; iIndex: Integer; bForward: Boolean): Integer; cdecl;
procedure Delphi_ContainerUI_GetClientPos(Handle: CContainerUI; var Result: TRect); cdecl;
procedure Delphi_ContainerUI_SetPos(Handle: CContainerUI; rc: TRect; bNeedInvalidate: Boolean); cdecl;
procedure Delphi_ContainerUI_Move(Handle: CContainerUI; szOffset: TSize; bNeedInvalidate: Boolean); cdecl;
procedure Delphi_ContainerUI_DoPaint(Handle: CContainerUI; hDC: HDC; var rcPaint: TRect; pStopControl: CControlUI); cdecl;
procedure Delphi_ContainerUI_SetAttribute(Handle: CContainerUI; pstrName: LPCTSTR; pstrValue: LPCTSTR); cdecl;
procedure Delphi_ContainerUI_SetManager(Handle: CContainerUI; pManager: CPaintManagerUI; pParent: CControlUI; bInit: Boolean); cdecl;
function Delphi_ContainerUI_FindControl(Handle: CContainerUI; Proc: TFindControlProc; pData: Pointer; uFlags: UINT): CControlUI; cdecl;
function Delphi_ContainerUI_SetSubControlText(Handle: CContainerUI; pstrSubControlName: LPCTSTR; pstrText: LPCTSTR): Boolean; cdecl;
function Delphi_ContainerUI_SetSubControlFixedHeight(Handle: CContainerUI; pstrSubControlName: LPCTSTR; cy: Integer): Boolean; cdecl;
function Delphi_ContainerUI_SetSubControlFixedWdith(Handle: CContainerUI; pstrSubControlName: LPCTSTR; cx: Integer): Boolean; cdecl;
function Delphi_ContainerUI_SetSubControlUserData(Handle: CContainerUI; pstrSubControlName: LPCTSTR; pstrText: LPCTSTR): Boolean; cdecl;
function Delphi_ContainerUI_GetSubControlText(Handle: CContainerUI; pstrSubControlName: LPCTSTR): CDuiString; cdecl;
function Delphi_ContainerUI_GetSubControlFixedHeight(Handle: CContainerUI; pstrSubControlName: LPCTSTR): Integer; cdecl;
function Delphi_ContainerUI_GetSubControlFixedWdith(Handle: CContainerUI; pstrSubControlName: LPCTSTR): Integer; cdecl;
function Delphi_ContainerUI_GetSubControlUserData(Handle: CContainerUI; pstrSubControlName: LPCTSTR): CDuiString; cdecl;
function Delphi_ContainerUI_FindSubControl(Handle: CContainerUI; pstrSubControlName: LPCTSTR): CControlUI; cdecl;
procedure Delphi_ContainerUI_GetScrollPos(Handle: CContainerUI; var Result: TSize); cdecl;
procedure Delphi_ContainerUI_GetScrollRange(Handle: CContainerUI; var Result: TSize); cdecl;
procedure Delphi_ContainerUI_SetScrollPos(Handle: CContainerUI; szPos: TSize); cdecl;
procedure Delphi_ContainerUI_LineUp(Handle: CContainerUI); cdecl;
procedure Delphi_ContainerUI_LineDown(Handle: CContainerUI); cdecl;
procedure Delphi_ContainerUI_PageUp(Handle: CContainerUI); cdecl;
procedure Delphi_ContainerUI_PageDown(Handle: CContainerUI); cdecl;
procedure Delphi_ContainerUI_HomeUp(Handle: CContainerUI); cdecl;
procedure Delphi_ContainerUI_EndDown(Handle: CContainerUI); cdecl;
procedure Delphi_ContainerUI_LineLeft(Handle: CContainerUI); cdecl;
procedure Delphi_ContainerUI_LineRight(Handle: CContainerUI); cdecl;
procedure Delphi_ContainerUI_PageLeft(Handle: CContainerUI); cdecl;
procedure Delphi_ContainerUI_PageRight(Handle: CContainerUI); cdecl;
procedure Delphi_ContainerUI_HomeLeft(Handle: CContainerUI); cdecl;
procedure Delphi_ContainerUI_EndRight(Handle: CContainerUI); cdecl;
procedure Delphi_ContainerUI_EnableScrollBar(Handle: CContainerUI; bEnableVertical: Boolean; bEnableHorizontal: Boolean); cdecl;
function Delphi_ContainerUI_GetVerticalScrollBar(Handle: CContainerUI): CScrollBarUI; cdecl;
function Delphi_ContainerUI_GetHorizontalScrollBar(Handle: CContainerUI): CScrollBarUI; cdecl;

//================================CVerticalLayoutUI============================

function Delphi_VerticalLayoutUI_CppCreate: CVerticalLayoutUI; cdecl;
procedure Delphi_VerticalLayoutUI_CppDestroy(Handle: CVerticalLayoutUI); cdecl;
function Delphi_VerticalLayoutUI_GetClass(Handle: CVerticalLayoutUI): LPCTSTR; cdecl;
function Delphi_VerticalLayoutUI_GetInterface(Handle: CVerticalLayoutUI; pstrName: LPCTSTR): Pointer; cdecl;
function Delphi_VerticalLayoutUI_GetControlFlags(Handle: CVerticalLayoutUI): UINT; cdecl;
procedure Delphi_VerticalLayoutUI_SetSepHeight(Handle: CVerticalLayoutUI; iHeight: Integer); cdecl;
function Delphi_VerticalLayoutUI_GetSepHeight(Handle: CVerticalLayoutUI): Integer; cdecl;
procedure Delphi_VerticalLayoutUI_SetSepImmMode(Handle: CVerticalLayoutUI; bImmediately: Boolean); cdecl;
function Delphi_VerticalLayoutUI_IsSepImmMode(Handle: CVerticalLayoutUI): Boolean; cdecl;
procedure Delphi_VerticalLayoutUI_SetAttribute(Handle: CVerticalLayoutUI; pstrName: LPCTSTR; pstrValue: LPCTSTR); cdecl;
procedure Delphi_VerticalLayoutUI_DoEvent(Handle: CVerticalLayoutUI; var event: TEventUI); cdecl;
procedure Delphi_VerticalLayoutUI_SetPos(Handle: CVerticalLayoutUI; rc: TRect; bNeedInvalidate: Boolean); cdecl;
procedure Delphi_VerticalLayoutUI_DoPostPaint(Handle: CVerticalLayoutUI; hDC: HDC; var rcPaint: TRect); cdecl;
procedure Delphi_VerticalLayoutUI_GetThumbRect(Handle: CVerticalLayoutUI; bUseNew: Boolean; var Result: TRect); cdecl;

//================================CListUI============================

function Delphi_ListUI_CppCreate: CListUI; cdecl;
procedure Delphi_ListUI_CppDestroy(Handle: CListUI); cdecl;
function Delphi_ListUI_GetClass(Handle: CListUI): LPCTSTR; cdecl;
function Delphi_ListUI_GetControlFlags(Handle: CListUI): UINT; cdecl;
function Delphi_ListUI_GetInterface(Handle: CListUI; pstrName: LPCTSTR): Pointer; cdecl;
function Delphi_ListUI_GetScrollSelect(Handle: CListUI): Boolean; cdecl;
procedure Delphi_ListUI_SetScrollSelect(Handle: CListUI; bScrollSelect: Boolean); cdecl;
function Delphi_ListUI_GetCurSel(Handle: CListUI): Integer; cdecl;
function Delphi_ListUI_SelectItem(Handle: CListUI; iIndex: Integer; bTakeFocus: Boolean; bTriggerEvent: Boolean): Boolean; cdecl;
function Delphi_ListUI_GetHeader(Handle: CListUI): CListHeaderUI; cdecl;
function Delphi_ListUI_GetList(Handle: CListUI): CContainerUI; cdecl;
function Delphi_ListUI_GetListInfo(Handle: CListUI): PListInfoUI; cdecl;
function Delphi_ListUI_GetItemAt(Handle: CListUI; iIndex: Integer): CControlUI; cdecl;
function Delphi_ListUI_GetItemIndex(Handle: CListUI; pControl: CControlUI): Integer; cdecl;
function Delphi_ListUI_SetItemIndex(Handle: CListUI; pControl: CControlUI; iIndex: Integer): Boolean; cdecl;
function Delphi_ListUI_GetCount(Handle: CListUI): Integer; cdecl;
function Delphi_ListUI_Add(Handle: CListUI; pControl: CControlUI): Boolean; cdecl;
function Delphi_ListUI_AddAt(Handle: CListUI; pControl: CControlUI; iIndex: Integer): Boolean; cdecl;
function Delphi_ListUI_Remove(Handle: CListUI; pControl: CControlUI): Boolean; cdecl;
function Delphi_ListUI_RemoveAt(Handle: CListUI; iIndex: Integer): Boolean; cdecl;
procedure Delphi_ListUI_RemoveAll(Handle: CListUI); cdecl;
procedure Delphi_ListUI_EnsureVisible(Handle: CListUI; iIndex: Integer); cdecl;
procedure Delphi_ListUI_Scroll(Handle: CListUI; dx: Integer; dy: Integer); cdecl;
function Delphi_ListUI_GetChildPadding(Handle: CListUI): Integer; cdecl;
procedure Delphi_ListUI_SetChildPadding(Handle: CListUI; iPadding: Integer); cdecl;
procedure Delphi_ListUI_SetItemFont(Handle: CListUI; index: Integer); cdecl;
procedure Delphi_ListUI_SetItemTextStyle(Handle: CListUI; uStyle: UINT); cdecl;
procedure Delphi_ListUI_SetItemTextPadding(Handle: CListUI; rc: TRect); cdecl;
procedure Delphi_ListUI_SetItemTextColor(Handle: CListUI; dwTextColor: DWORD); cdecl;
procedure Delphi_ListUI_SetItemBkColor(Handle: CListUI; dwBkColor: DWORD); cdecl;
procedure Delphi_ListUI_SetItemBkImage(Handle: CListUI; pStrImage: LPCTSTR); cdecl;
function Delphi_ListUI_IsAlternateBk(Handle: CListUI): Boolean; cdecl;
procedure Delphi_ListUI_SetAlternateBk(Handle: CListUI; bAlternateBk: Boolean); cdecl;
procedure Delphi_ListUI_SetSelectedItemTextColor(Handle: CListUI; dwTextColor: DWORD); cdecl;
procedure Delphi_ListUI_SetSelectedItemBkColor(Handle: CListUI; dwBkColor: DWORD); cdecl;
procedure Delphi_ListUI_SetSelectedItemImage(Handle: CListUI; pStrImage: LPCTSTR); cdecl;
procedure Delphi_ListUI_SetHotItemTextColor(Handle: CListUI; dwTextColor: DWORD); cdecl;
procedure Delphi_ListUI_SetHotItemBkColor(Handle: CListUI; dwBkColor: DWORD); cdecl;
procedure Delphi_ListUI_SetHotItemImage(Handle: CListUI; pStrImage: LPCTSTR); cdecl;
procedure Delphi_ListUI_SetDisabledItemTextColor(Handle: CListUI; dwTextColor: DWORD); cdecl;
procedure Delphi_ListUI_SetDisabledItemBkColor(Handle: CListUI; dwBkColor: DWORD); cdecl;
procedure Delphi_ListUI_SetDisabledItemImage(Handle: CListUI; pStrImage: LPCTSTR); cdecl;
procedure Delphi_ListUI_SetItemLineColor(Handle: CListUI; dwLineColor: DWORD); cdecl;
function Delphi_ListUI_IsItemShowHtml(Handle: CListUI): Boolean; cdecl;
procedure Delphi_ListUI_SetItemShowHtml(Handle: CListUI; bShowHtml: Boolean); cdecl;
procedure Delphi_ListUI_GetItemTextPadding(Handle: CListUI; var Result: TRect); cdecl;
function Delphi_ListUI_GetItemTextColor(Handle: CListUI): DWORD; cdecl;
function Delphi_ListUI_GetItemBkColor(Handle: CListUI): DWORD; cdecl;
function Delphi_ListUI_GetItemBkImage(Handle: CListUI): LPCTSTR; cdecl;
function Delphi_ListUI_GetSelectedItemTextColor(Handle: CListUI): DWORD; cdecl;
function Delphi_ListUI_GetSelectedItemBkColor(Handle: CListUI): DWORD; cdecl;
function Delphi_ListUI_GetSelectedItemImage(Handle: CListUI): LPCTSTR; cdecl;
function Delphi_ListUI_GetHotItemTextColor(Handle: CListUI): DWORD; cdecl;
function Delphi_ListUI_GetHotItemBkColor(Handle: CListUI): DWORD; cdecl;
function Delphi_ListUI_GetHotItemImage(Handle: CListUI): LPCTSTR; cdecl;
function Delphi_ListUI_GetDisabledItemTextColor(Handle: CListUI): DWORD; cdecl;
function Delphi_ListUI_GetDisabledItemBkColor(Handle: CListUI): DWORD; cdecl;
function Delphi_ListUI_GetDisabledItemImage(Handle: CListUI): LPCTSTR; cdecl;
function Delphi_ListUI_GetItemLineColor(Handle: CListUI): DWORD; cdecl;
procedure Delphi_ListUI_SetMultiExpanding(Handle: CListUI; bMultiExpandable: Boolean); cdecl;
function Delphi_ListUI_GetExpandedItem(Handle: CListUI): Integer; cdecl;
function Delphi_ListUI_ExpandItem(Handle: CListUI; iIndex: Integer; bExpand: Boolean): Boolean; cdecl;
procedure Delphi_ListUI_SetPos(Handle: CListUI; rc: TRect; bNeedInvalidate: Boolean); cdecl;
procedure Delphi_ListUI_Move(Handle: CListUI; szOffset: TSize; bNeedInvalidate: Boolean); cdecl;
procedure Delphi_ListUI_DoEvent(Handle: CListUI; var event: TEventUI); cdecl;
procedure Delphi_ListUI_SetAttribute(Handle: CListUI; pstrName: LPCTSTR; pstrValue: LPCTSTR); cdecl;
function Delphi_ListUI_GetTextCallback(Handle: CListUI): IListCallbackUI; cdecl;
procedure Delphi_ListUI_SetTextCallback(Handle: CListUI; pCallback: IListCallbackUI); cdecl;
procedure Delphi_ListUI_GetScrollPos(Handle: CListUI; var Result: TSize); cdecl;
procedure Delphi_ListUI_GetScrollRange(Handle: CListUI; var Result: TSize); cdecl;
procedure Delphi_ListUI_SetScrollPos(Handle: CListUI; szPos: TSize); cdecl;
procedure Delphi_ListUI_LineUp(Handle: CListUI); cdecl;
procedure Delphi_ListUI_LineDown(Handle: CListUI); cdecl;
procedure Delphi_ListUI_PageUp(Handle: CListUI); cdecl;
procedure Delphi_ListUI_PageDown(Handle: CListUI); cdecl;
procedure Delphi_ListUI_HomeUp(Handle: CListUI); cdecl;
procedure Delphi_ListUI_EndDown(Handle: CListUI); cdecl;
procedure Delphi_ListUI_LineLeft(Handle: CListUI); cdecl;
procedure Delphi_ListUI_LineRight(Handle: CListUI); cdecl;
procedure Delphi_ListUI_PageLeft(Handle: CListUI); cdecl;
procedure Delphi_ListUI_PageRight(Handle: CListUI); cdecl;
procedure Delphi_ListUI_HomeLeft(Handle: CListUI); cdecl;
procedure Delphi_ListUI_EndRight(Handle: CListUI); cdecl;
procedure Delphi_ListUI_EnableScrollBar(Handle: CListUI; bEnableVertical: Boolean; bEnableHorizontal: Boolean); cdecl;
function Delphi_ListUI_GetVerticalScrollBar(Handle: CListUI): CScrollBarUI; cdecl;
function Delphi_ListUI_GetHorizontalScrollBar(Handle: CListUI): CScrollBarUI; cdecl;
function Delphi_ListUI_SortItems(Handle: CListUI; pfnCompare: PULVCompareFunc; dwData: UINT_PTR): BOOL; cdecl;

//================================CDelphi_ListUI============================

function Delphi_Delphi_ListUI_CppCreate: CDelphi_ListUI; cdecl;
procedure Delphi_Delphi_ListUI_CppDestroy(Handle: CDelphi_ListUI); cdecl;
procedure Delphi_Delphi_ListUI_SetDelphiSelf(Handle: CDelphi_ListUI; ASelf: Pointer); cdecl;
procedure Delphi_Delphi_ListUI_SetDoEvent(Handle: CDelphi_ListUI; ADoEvent: Pointer); cdecl;

//================================CLabelUI============================

function Delphi_LabelUI_CppCreate: CLabelUI; cdecl;
procedure Delphi_LabelUI_CppDestroy(Handle: CLabelUI); cdecl;
function Delphi_LabelUI_GetClass(Handle: CLabelUI): LPCTSTR; cdecl;
procedure Delphi_LabelUI_SetText(Handle: CLabelUI; pstrText: LPCTSTR); cdecl;
function Delphi_LabelUI_GetInterface(Handle: CLabelUI; pstrName: LPCTSTR): Pointer; cdecl;
procedure Delphi_LabelUI_SetTextStyle(Handle: CLabelUI; uStyle: UINT); cdecl;
function Delphi_LabelUI_GetTextStyle(Handle: CLabelUI): UINT; cdecl;
function Delphi_LabelUI_IsMultiLine(Handle: CLabelUI): Boolean; cdecl;
procedure Delphi_LabelUI_SetMultiLine(Handle: CLabelUI; bMultiLine: Boolean); cdecl;
procedure Delphi_LabelUI_SetTextColor(Handle: CLabelUI; dwTextColor: DWORD); cdecl;
function Delphi_LabelUI_GetTextColor(Handle: CLabelUI): DWORD; cdecl;
procedure Delphi_LabelUI_SetDisabledTextColor(Handle: CLabelUI; dwTextColor: DWORD); cdecl;
function Delphi_LabelUI_GetDisabledTextColor(Handle: CLabelUI): DWORD; cdecl;
procedure Delphi_LabelUI_SetFont(Handle: CLabelUI; index: Integer); cdecl;
function Delphi_LabelUI_GetFont(Handle: CLabelUI): Integer; cdecl;
procedure Delphi_LabelUI_GetTextPadding(Handle: CLabelUI; var Result: TRect); cdecl;
procedure Delphi_LabelUI_SetTextPadding(Handle: CLabelUI; rc: TRect); cdecl;
function Delphi_LabelUI_IsShowHtml(Handle: CLabelUI): Boolean; cdecl;
procedure Delphi_LabelUI_SetShowHtml(Handle: CLabelUI; bShowHtml: Boolean); cdecl;
procedure Delphi_LabelUI_EstimateSize(Handle: CLabelUI; szAvailable: TSize; var Result: TSize); cdecl;
procedure Delphi_LabelUI_DoEvent(Handle: CLabelUI; var event: TEventUI); cdecl;
procedure Delphi_LabelUI_SetAttribute(Handle: CLabelUI; pstrName: LPCTSTR; pstrValue: LPCTSTR); cdecl;
procedure Delphi_LabelUI_PaintText(Handle: CLabelUI; hDC: HDC); cdecl;
procedure Delphi_LabelUI_SetEnabledEffect(Handle: CLabelUI; _EnabledEffect: Boolean); cdecl;
function Delphi_LabelUI_GetEnabledEffect(Handle: CLabelUI): Boolean; cdecl;
procedure Delphi_LabelUI_SetEnabledLuminous(Handle: CLabelUI; bEnableLuminous: Boolean); cdecl;
function Delphi_LabelUI_GetEnabledLuminous(Handle: CLabelUI): Boolean; cdecl;
procedure Delphi_LabelUI_SetLuminousFuzzy(Handle: CLabelUI; fFuzzy: Single); cdecl;
function Delphi_LabelUI_GetLuminousFuzzy(Handle: CLabelUI): Single; cdecl;
procedure Delphi_LabelUI_SetGradientLength(Handle: CLabelUI; _GradientLength: Integer); cdecl;
function Delphi_LabelUI_GetGradientLength(Handle: CLabelUI): Integer; cdecl;
procedure Delphi_LabelUI_SetShadowOffset(Handle: CLabelUI; _offset: Integer; _angle: Integer); cdecl;
procedure Delphi_LabelUI_GetShadowOffset(Handle: CLabelUI; var Result: TRectF); cdecl;
procedure Delphi_LabelUI_SetTextColor1(Handle: CLabelUI; _TextColor1: DWORD); cdecl;
function Delphi_LabelUI_GetTextColor1(Handle: CLabelUI): DWORD; cdecl;
procedure Delphi_LabelUI_SetTextShadowColorA(Handle: CLabelUI; _TextShadowColorA: DWORD); cdecl;
function Delphi_LabelUI_GetTextShadowColorA(Handle: CLabelUI): DWORD; cdecl;
procedure Delphi_LabelUI_SetTextShadowColorB(Handle: CLabelUI; _TextShadowColorB: DWORD); cdecl;
function Delphi_LabelUI_GetTextShadowColorB(Handle: CLabelUI): DWORD; cdecl;
procedure Delphi_LabelUI_SetStrokeColor(Handle: CLabelUI; _StrokeColor: DWORD); cdecl;
function Delphi_LabelUI_GetStrokeColor(Handle: CLabelUI): DWORD; cdecl;
procedure Delphi_LabelUI_SetGradientAngle(Handle: CLabelUI; _SetGradientAngle: Integer); cdecl;
function Delphi_LabelUI_GetGradientAngle(Handle: CLabelUI): Integer; cdecl;
procedure Delphi_LabelUI_SetEnabledStroke(Handle: CLabelUI; _EnabledStroke: Boolean); cdecl;
function Delphi_LabelUI_GetEnabledStroke(Handle: CLabelUI): Boolean; cdecl;
procedure Delphi_LabelUI_SetEnabledShadow(Handle: CLabelUI; _EnabledShadowe: Boolean); cdecl;
function Delphi_LabelUI_GetEnabledShadow(Handle: CLabelUI): Boolean; cdecl;

//================================CButtonUI============================

function Delphi_ButtonUI_CppCreate: CButtonUI; cdecl;
procedure Delphi_ButtonUI_CppDestroy(Handle: CButtonUI); cdecl;
function Delphi_ButtonUI_GetClass(Handle: CButtonUI): LPCTSTR; cdecl;
function Delphi_ButtonUI_GetInterface(Handle: CButtonUI; pstrName: LPCTSTR): Pointer; cdecl;
function Delphi_ButtonUI_GetControlFlags(Handle: CButtonUI): UINT; cdecl;
function Delphi_ButtonUI_Activate(Handle: CButtonUI): Boolean; cdecl;
procedure Delphi_ButtonUI_SetEnabled(Handle: CButtonUI; bEnable: Boolean); cdecl;
procedure Delphi_ButtonUI_DoEvent(Handle: CButtonUI; var event: TEventUI); cdecl;
function Delphi_ButtonUI_GetNormalImage(Handle: CButtonUI): LPCTSTR; cdecl;
procedure Delphi_ButtonUI_SetNormalImage(Handle: CButtonUI; pStrImage: LPCTSTR); cdecl;
function Delphi_ButtonUI_GetHotImage(Handle: CButtonUI): LPCTSTR; cdecl;
procedure Delphi_ButtonUI_SetHotImage(Handle: CButtonUI; pStrImage: LPCTSTR); cdecl;
function Delphi_ButtonUI_GetPushedImage(Handle: CButtonUI): LPCTSTR; cdecl;
procedure Delphi_ButtonUI_SetPushedImage(Handle: CButtonUI; pStrImage: LPCTSTR); cdecl;
function Delphi_ButtonUI_GetFocusedImage(Handle: CButtonUI): LPCTSTR; cdecl;
procedure Delphi_ButtonUI_SetFocusedImage(Handle: CButtonUI; pStrImage: LPCTSTR); cdecl;
function Delphi_ButtonUI_GetDisabledImage(Handle: CButtonUI): LPCTSTR; cdecl;
procedure Delphi_ButtonUI_SetDisabledImage(Handle: CButtonUI; pStrImage: LPCTSTR); cdecl;
function Delphi_ButtonUI_GetForeImage(Handle: CButtonUI): LPCTSTR; cdecl;
procedure Delphi_ButtonUI_SetForeImage(Handle: CButtonUI; pStrImage: LPCTSTR); cdecl;
function Delphi_ButtonUI_GetHotForeImage(Handle: CButtonUI): LPCTSTR; cdecl;
procedure Delphi_ButtonUI_SetHotForeImage(Handle: CButtonUI; pStrImage: LPCTSTR); cdecl;
procedure Delphi_ButtonUI_SetHotBkColor(Handle: CButtonUI; dwColor: DWORD); cdecl;
function Delphi_ButtonUI_GetHotBkColor(Handle: CButtonUI): DWORD; cdecl;
procedure Delphi_ButtonUI_SetHotTextColor(Handle: CButtonUI; dwColor: DWORD); cdecl;
function Delphi_ButtonUI_GetHotTextColor(Handle: CButtonUI): DWORD; cdecl;
procedure Delphi_ButtonUI_SetPushedTextColor(Handle: CButtonUI; dwColor: DWORD); cdecl;
function Delphi_ButtonUI_GetPushedTextColor(Handle: CButtonUI): DWORD; cdecl;
procedure Delphi_ButtonUI_SetFocusedTextColor(Handle: CButtonUI; dwColor: DWORD); cdecl;
function Delphi_ButtonUI_GetFocusedTextColor(Handle: CButtonUI): DWORD; cdecl;
procedure Delphi_ButtonUI_EstimateSize(Handle: CButtonUI; szAvailable: TSize; var Result: TSize); cdecl;
procedure Delphi_ButtonUI_SetAttribute(Handle: CButtonUI; pstrName: LPCTSTR; pstrValue: LPCTSTR); cdecl;
procedure Delphi_ButtonUI_PaintText(Handle: CButtonUI; hDC: HDC); cdecl;
procedure Delphi_ButtonUI_PaintStatusImage(Handle: CButtonUI; hDC: HDC); cdecl;

procedure Delphi_ButtonUI_SetFiveStatusImage(Handle: CButtonUI; pStrImage: LPCTSTR); cdecl;
procedure Delphi_ButtonUI_SetFadeAlphaDelta(Handle: CButtonUI; uDelta: Byte); cdecl;
function Delphi_ButtonUI_GetFadeAlphaDelta(Handle: CButtonUI): Byte; cdecl;




//================================COptionUI============================

function Delphi_OptionUI_CppCreate: COptionUI; cdecl;
procedure Delphi_OptionUI_CppDestroy(Handle: COptionUI); cdecl;
function Delphi_OptionUI_GetClass(Handle: COptionUI): LPCTSTR; cdecl;
function Delphi_OptionUI_GetInterface(Handle: COptionUI; pstrName: LPCTSTR): Pointer; cdecl;
procedure Delphi_OptionUI_SetManager(Handle: COptionUI; pManager: CPaintManagerUI; pParent: CControlUI; bInit: Boolean); cdecl;
function Delphi_OptionUI_Activate(Handle: COptionUI): Boolean; cdecl;
procedure Delphi_OptionUI_SetEnabled(Handle: COptionUI; bEnable: Boolean); cdecl;
function Delphi_OptionUI_GetSelectedImage(Handle: COptionUI): LPCTSTR; cdecl;
procedure Delphi_OptionUI_SetSelectedImage(Handle: COptionUI; pStrImage: LPCTSTR); cdecl;
function Delphi_OptionUI_GetSelectedHotImage(Handle: COptionUI): LPCTSTR; cdecl;
procedure Delphi_OptionUI_SetSelectedHotImage(Handle: COptionUI; pStrImage: LPCTSTR); cdecl;
procedure Delphi_OptionUI_SetSelectedTextColor(Handle: COptionUI; dwTextColor: DWORD); cdecl;
function Delphi_OptionUI_GetSelectedTextColor(Handle: COptionUI): DWORD; cdecl;
procedure Delphi_OptionUI_SetSelectedBkColor(Handle: COptionUI; dwBkColor: DWORD); cdecl;
function Delphi_OptionUI_GetSelectBkColor(Handle: COptionUI): DWORD; cdecl;
function Delphi_OptionUI_GetForeImage(Handle: COptionUI): LPCTSTR; cdecl;
procedure Delphi_OptionUI_SetForeImage(Handle: COptionUI; pStrImage: LPCTSTR); cdecl;
function Delphi_OptionUI_GetGroup(Handle: COptionUI): LPCTSTR; cdecl;
procedure Delphi_OptionUI_SetGroup(Handle: COptionUI; pStrGroupName: LPCTSTR); cdecl;
function Delphi_OptionUI_IsSelected(Handle: COptionUI): Boolean; cdecl;
procedure Delphi_OptionUI_Selected(Handle: COptionUI; bSelected: Boolean; bTriggerEvent: Boolean); cdecl;
procedure Delphi_OptionUI_EstimateSize(Handle: COptionUI; szAvailable: TSize; var Result: TSize); cdecl;
procedure Delphi_OptionUI_SetAttribute(Handle: COptionUI; pstrName: LPCTSTR; pstrValue: LPCTSTR); cdecl;
procedure Delphi_OptionUI_PaintStatusImage(Handle: COptionUI; hDC: HDC); cdecl;
procedure Delphi_OptionUI_PaintText(Handle: COptionUI; hDC: HDC); cdecl;

//================================CCheckBoxUI============================

function Delphi_CheckBoxUI_CppCreate: CCheckBoxUI; cdecl;
procedure Delphi_CheckBoxUI_CppDestroy(Handle: CCheckBoxUI); cdecl;
function Delphi_CheckBoxUI_GetClass(Handle: CCheckBoxUI): LPCTSTR; cdecl;
function Delphi_CheckBoxUI_GetInterface(Handle: CCheckBoxUI; pstrName: LPCTSTR): Pointer; cdecl;
procedure Delphi_CheckBoxUI_SetCheck(Handle: CCheckBoxUI; bCheck: Boolean; bTriggerEvent: Boolean); cdecl;
function Delphi_CheckBoxUI_GetCheck(Handle: CCheckBoxUI): Boolean; cdecl;

//================================CListContainerElementUI============================

function Delphi_ListContainerElementUI_CppCreate: CListContainerElementUI; cdecl;
procedure Delphi_ListContainerElementUI_CppDestroy(Handle: CListContainerElementUI); cdecl;
function Delphi_ListContainerElementUI_GetClass(Handle: CListContainerElementUI): LPCTSTR; cdecl;
function Delphi_ListContainerElementUI_GetControlFlags(Handle: CListContainerElementUI): UINT; cdecl;
function Delphi_ListContainerElementUI_GetInterface(Handle: CListContainerElementUI; pstrName: LPCTSTR): Pointer; cdecl;
function Delphi_ListContainerElementUI_GetIndex(Handle: CListContainerElementUI): Integer; cdecl;
procedure Delphi_ListContainerElementUI_SetIndex(Handle: CListContainerElementUI; iIndex: Integer); cdecl;
function Delphi_ListContainerElementUI_GetOwner(Handle: CListContainerElementUI): IListOwnerUI; cdecl;
procedure Delphi_ListContainerElementUI_SetOwner(Handle: CListContainerElementUI; pOwner: CControlUI); cdecl;
procedure Delphi_ListContainerElementUI_SetVisible(Handle: CListContainerElementUI; bVisible: Boolean); cdecl;
procedure Delphi_ListContainerElementUI_SetEnabled(Handle: CListContainerElementUI; bEnable: Boolean); cdecl;
function Delphi_ListContainerElementUI_IsSelected(Handle: CListContainerElementUI): Boolean; cdecl;
function Delphi_ListContainerElementUI_Select(Handle: CListContainerElementUI; bSelect: Boolean): Boolean; cdecl;
function Delphi_ListContainerElementUI_IsExpanded(Handle: CListContainerElementUI): Boolean; cdecl;
function Delphi_ListContainerElementUI_Expand(Handle: CListContainerElementUI; bExpand: Boolean): Boolean; cdecl;
procedure Delphi_ListContainerElementUI_Invalidate(Handle: CListContainerElementUI); cdecl;
function Delphi_ListContainerElementUI_Activate(Handle: CListContainerElementUI): Boolean; cdecl;
procedure Delphi_ListContainerElementUI_DoEvent(Handle: CListContainerElementUI; var event: TEventUI); cdecl;
procedure Delphi_ListContainerElementUI_SetAttribute(Handle: CListContainerElementUI; pstrName: LPCTSTR; pstrValue: LPCTSTR); cdecl;
procedure Delphi_ListContainerElementUI_DoPaint(Handle: CListContainerElementUI; hDC: HDC; var rcPaint: TRect; pStopControl: CControlUI); cdecl;
procedure Delphi_ListContainerElementUI_DrawItemText(Handle: CListContainerElementUI; hDC: HDC; const rcItem: TRect); cdecl;
procedure Delphi_ListContainerElementUI_DrawItemBk(Handle: CListContainerElementUI; hDC: HDC; const rcItem: TRect); cdecl;

//================================CComboUI============================

function Delphi_ComboUI_CppCreate: CComboUI; cdecl;
procedure Delphi_ComboUI_CppDestroy(Handle: CComboUI); cdecl;
function Delphi_ComboUI_GetClass(Handle: CComboUI): LPCTSTR; cdecl;
function Delphi_ComboUI_GetInterface(Handle: CComboUI; pstrName: LPCTSTR): Pointer; cdecl;
procedure Delphi_ComboUI_DoInit(Handle: CComboUI); cdecl;
function Delphi_ComboUI_GetControlFlags(Handle: CComboUI): UINT; cdecl;
function Delphi_ComboUI_GetText(Handle: CComboUI): CDuiString; cdecl;
procedure Delphi_ComboUI_SetEnabled(Handle: CComboUI; bEnable: Boolean); cdecl;
function Delphi_ComboUI_GetDropBoxAttributeList(Handle: CComboUI): CDuiString; cdecl;
procedure Delphi_ComboUI_SetDropBoxAttributeList(Handle: CComboUI; pstrList: LPCTSTR); cdecl;
procedure Delphi_ComboUI_GetDropBoxSize(Handle: CComboUI; var Result: TSize); cdecl;
procedure Delphi_ComboUI_SetDropBoxSize(Handle: CComboUI; szDropBox: TSize); cdecl;
function Delphi_ComboUI_GetCurSel(Handle: CComboUI): Integer; cdecl;
function Delphi_ComboUI_GetSelectCloseFlag(Handle: CComboUI): Boolean; cdecl;
procedure Delphi_ComboUI_SetSelectCloseFlag(Handle: CComboUI; flag: Boolean); cdecl;
function Delphi_ComboUI_SelectItem(Handle: CComboUI; iIndex: Integer; bTakeFocus: Boolean; bTriggerEvent: Boolean): Boolean; cdecl;
function Delphi_ComboUI_SetItemIndex(Handle: CComboUI; pControl: CControlUI; iIndex: Integer): Boolean; cdecl;
function Delphi_ComboUI_Add(Handle: CComboUI; pControl: CControlUI): Boolean; cdecl;
function Delphi_ComboUI_AddAt(Handle: CComboUI; pControl: CControlUI; iIndex: Integer): Boolean; cdecl;
function Delphi_ComboUI_Remove(Handle: CComboUI; pControl: CControlUI): Boolean; cdecl;
function Delphi_ComboUI_RemoveAt(Handle: CComboUI; iIndex: Integer): Boolean; cdecl;
procedure Delphi_ComboUI_RemoveAll(Handle: CComboUI); cdecl;
function Delphi_ComboUI_Activate(Handle: CComboUI): Boolean; cdecl;
function Delphi_ComboUI_GetShowText(Handle: CComboUI): Boolean; cdecl;
procedure Delphi_ComboUI_SetShowText(Handle: CComboUI; flag: Boolean); cdecl;
procedure Delphi_ComboUI_GetTextPadding(Handle: CComboUI; var Result: TRect); cdecl;
procedure Delphi_ComboUI_SetTextPadding(Handle: CComboUI; rc: TRect); cdecl;
function Delphi_ComboUI_GetNormalImage(Handle: CComboUI): LPCTSTR; cdecl;
procedure Delphi_ComboUI_SetNormalImage(Handle: CComboUI; pStrImage: LPCTSTR); cdecl;
function Delphi_ComboUI_GetHotImage(Handle: CComboUI): LPCTSTR; cdecl;
procedure Delphi_ComboUI_SetHotImage(Handle: CComboUI; pStrImage: LPCTSTR); cdecl;
function Delphi_ComboUI_GetPushedImage(Handle: CComboUI): LPCTSTR; cdecl;
procedure Delphi_ComboUI_SetPushedImage(Handle: CComboUI; pStrImage: LPCTSTR); cdecl;
function Delphi_ComboUI_GetFocusedImage(Handle: CComboUI): LPCTSTR; cdecl;
procedure Delphi_ComboUI_SetFocusedImage(Handle: CComboUI; pStrImage: LPCTSTR); cdecl;
function Delphi_ComboUI_GetDisabledImage(Handle: CComboUI): LPCTSTR; cdecl;
procedure Delphi_ComboUI_SetDisabledImage(Handle: CComboUI; pStrImage: LPCTSTR); cdecl;
function Delphi_ComboUI_GetListInfo(Handle: CComboUI): PListInfoUI; cdecl;
procedure Delphi_ComboUI_SetItemFont(Handle: CComboUI; index: Integer); cdecl;
procedure Delphi_ComboUI_SetItemTextStyle(Handle: CComboUI; uStyle: UINT); cdecl;
procedure Delphi_ComboUI_GetItemTextPadding(Handle: CComboUI; var Result: TRect); cdecl;
procedure Delphi_ComboUI_SetItemTextPadding(Handle: CComboUI; rc: TRect); cdecl;
function Delphi_ComboUI_GetItemTextColor(Handle: CComboUI): DWORD; cdecl;
procedure Delphi_ComboUI_SetItemTextColor(Handle: CComboUI; dwTextColor: DWORD); cdecl;
function Delphi_ComboUI_GetItemBkColor(Handle: CComboUI): DWORD; cdecl;
procedure Delphi_ComboUI_SetItemBkColor(Handle: CComboUI; dwBkColor: DWORD); cdecl;
function Delphi_ComboUI_GetItemBkImage(Handle: CComboUI): LPCTSTR; cdecl;
procedure Delphi_ComboUI_SetItemBkImage(Handle: CComboUI; pStrImage: LPCTSTR); cdecl;
function Delphi_ComboUI_IsAlternateBk(Handle: CComboUI): Boolean; cdecl;
procedure Delphi_ComboUI_SetAlternateBk(Handle: CComboUI; bAlternateBk: Boolean); cdecl;
function Delphi_ComboUI_GetSelectedItemTextColor(Handle: CComboUI): DWORD; cdecl;
procedure Delphi_ComboUI_SetSelectedItemTextColor(Handle: CComboUI; dwTextColor: DWORD); cdecl;
function Delphi_ComboUI_GetSelectedItemBkColor(Handle: CComboUI): DWORD; cdecl;
procedure Delphi_ComboUI_SetSelectedItemBkColor(Handle: CComboUI; dwBkColor: DWORD); cdecl;
function Delphi_ComboUI_GetSelectedItemImage(Handle: CComboUI): LPCTSTR; cdecl;
procedure Delphi_ComboUI_SetSelectedItemImage(Handle: CComboUI; pStrImage: LPCTSTR); cdecl;
function Delphi_ComboUI_GetHotItemTextColor(Handle: CComboUI): DWORD; cdecl;
procedure Delphi_ComboUI_SetHotItemTextColor(Handle: CComboUI; dwTextColor: DWORD); cdecl;
function Delphi_ComboUI_GetHotItemBkColor(Handle: CComboUI): DWORD; cdecl;
procedure Delphi_ComboUI_SetHotItemBkColor(Handle: CComboUI; dwBkColor: DWORD); cdecl;
function Delphi_ComboUI_GetHotItemImage(Handle: CComboUI): LPCTSTR; cdecl;
procedure Delphi_ComboUI_SetHotItemImage(Handle: CComboUI; pStrImage: LPCTSTR); cdecl;
function Delphi_ComboUI_GetDisabledItemTextColor(Handle: CComboUI): DWORD; cdecl;
procedure Delphi_ComboUI_SetDisabledItemTextColor(Handle: CComboUI; dwTextColor: DWORD); cdecl;
function Delphi_ComboUI_GetDisabledItemBkColor(Handle: CComboUI): DWORD; cdecl;
procedure Delphi_ComboUI_SetDisabledItemBkColor(Handle: CComboUI; dwBkColor: DWORD); cdecl;
function Delphi_ComboUI_GetDisabledItemImage(Handle: CComboUI): LPCTSTR; cdecl;
procedure Delphi_ComboUI_SetDisabledItemImage(Handle: CComboUI; pStrImage: LPCTSTR); cdecl;
function Delphi_ComboUI_GetItemLineColor(Handle: CComboUI): DWORD; cdecl;
procedure Delphi_ComboUI_SetItemLineColor(Handle: CComboUI; dwLineColor: DWORD); cdecl;
function Delphi_ComboUI_IsItemShowHtml(Handle: CComboUI): Boolean; cdecl;
procedure Delphi_ComboUI_SetItemShowHtml(Handle: CComboUI; bShowHtml: Boolean); cdecl;
procedure Delphi_ComboUI_EstimateSize(Handle: CComboUI; szAvailable: TSize; var Result: TSize); cdecl;
procedure Delphi_ComboUI_SetPos(Handle: CComboUI; rc: TRect; bNeedInvalidate: Boolean); cdecl;
procedure Delphi_ComboUI_Move(Handle: CComboUI; szOffset: TSize; bNeedInvalidate: Boolean); cdecl;
procedure Delphi_ComboUI_DoEvent(Handle: CComboUI; var event: TEventUI); cdecl;
procedure Delphi_ComboUI_SetAttribute(Handle: CComboUI; pstrName: LPCTSTR; pstrValue: LPCTSTR); cdecl;
procedure Delphi_ComboUI_DoPaint(Handle: CComboUI; hDC: HDC; var rcPaint: TRect; pStopControl: CControlUI); cdecl;
procedure Delphi_ComboUI_PaintText(Handle: CComboUI; hDC: HDC); cdecl;
procedure Delphi_ComboUI_PaintStatusImage(Handle: CComboUI; hDC: HDC); cdecl;

//================================CDateTimeUI============================

function Delphi_DateTimeUI_CppCreate: CDateTimeUI; cdecl;
procedure Delphi_DateTimeUI_CppDestroy(Handle: CDateTimeUI); cdecl;
function Delphi_DateTimeUI_GetClass(Handle: CDateTimeUI): LPCTSTR; cdecl;
function Delphi_DateTimeUI_GetInterface(Handle: CDateTimeUI; pstrName: LPCTSTR): Pointer; cdecl;
function Delphi_DateTimeUI_GetControlFlags(Handle: CDateTimeUI): UINT; cdecl;
function Delphi_DateTimeUI_GetNativeWindow(Handle: CDateTimeUI): HWND; cdecl;
function Delphi_DateTimeUI_GetTime(Handle: CDateTimeUI): PSYSTEMTIME; cdecl;
procedure Delphi_DateTimeUI_SetTime(Handle: CDateTimeUI; pst: PSYSTEMTIME); cdecl;
procedure Delphi_DateTimeUI_SetReadOnly(Handle: CDateTimeUI; bReadOnly: Boolean); cdecl;
function Delphi_DateTimeUI_IsReadOnly(Handle: CDateTimeUI): Boolean; cdecl;
procedure Delphi_DateTimeUI_UpdateText(Handle: CDateTimeUI); cdecl;
procedure Delphi_DateTimeUI_DoEvent(Handle: CDateTimeUI; var event: TEventUI); cdecl;

//================================CEditUI============================

function Delphi_EditUI_CppCreate: CEditUI; cdecl;
procedure Delphi_EditUI_CppDestroy(Handle: CEditUI); cdecl;
function Delphi_EditUI_GetClass(Handle: CEditUI): LPCTSTR; cdecl;
function Delphi_EditUI_GetInterface(Handle: CEditUI; pstrName: LPCTSTR): Pointer; cdecl;
function Delphi_EditUI_GetControlFlags(Handle: CEditUI): UINT; cdecl;
function Delphi_EditUI_GetNativeWindow(Handle: CEditUI): HWND; cdecl;
procedure Delphi_EditUI_SetEnabled(Handle: CEditUI; bEnable: Boolean); cdecl;
procedure Delphi_EditUI_SetText(Handle: CEditUI; pstrText: LPCTSTR); cdecl;
procedure Delphi_EditUI_SetMaxChar(Handle: CEditUI; uMax: UINT); cdecl;
function Delphi_EditUI_GetMaxChar(Handle: CEditUI): UINT; cdecl;
procedure Delphi_EditUI_SetReadOnly(Handle: CEditUI; bReadOnly: Boolean); cdecl;
function Delphi_EditUI_IsReadOnly(Handle: CEditUI): Boolean; cdecl;
procedure Delphi_EditUI_SetPasswordMode(Handle: CEditUI; bPasswordMode: Boolean); cdecl;
function Delphi_EditUI_IsPasswordMode(Handle: CEditUI): Boolean; cdecl;
procedure Delphi_EditUI_SetPasswordChar(Handle: CEditUI; cPasswordChar: Char); cdecl;
function Delphi_EditUI_GetPasswordChar(Handle: CEditUI): Char; cdecl;
function Delphi_EditUI_IsAutoSelAll(Handle: CEditUI): Boolean; cdecl;
procedure Delphi_EditUI_SetAutoSelAll(Handle: CEditUI; bAutoSelAll: Boolean); cdecl;
procedure Delphi_EditUI_SetNumberOnly(Handle: CEditUI; bNumberOnly: Boolean); cdecl;
function Delphi_EditUI_IsNumberOnly(Handle: CEditUI): Boolean; cdecl;
function Delphi_EditUI_GetWindowStyls(Handle: CEditUI): Integer; cdecl;
function Delphi_EditUI_GetNativeEditHWND(Handle: CEditUI): HWND; cdecl;
function Delphi_EditUI_GetNormalImage(Handle: CEditUI): LPCTSTR; cdecl;
procedure Delphi_EditUI_SetNormalImage(Handle: CEditUI; pStrImage: LPCTSTR); cdecl;
function Delphi_EditUI_GetHotImage(Handle: CEditUI): LPCTSTR; cdecl;
procedure Delphi_EditUI_SetHotImage(Handle: CEditUI; pStrImage: LPCTSTR); cdecl;
function Delphi_EditUI_GetFocusedImage(Handle: CEditUI): LPCTSTR; cdecl;
procedure Delphi_EditUI_SetFocusedImage(Handle: CEditUI; pStrImage: LPCTSTR); cdecl;
function Delphi_EditUI_GetDisabledImage(Handle: CEditUI): LPCTSTR; cdecl;
procedure Delphi_EditUI_SetDisabledImage(Handle: CEditUI; pStrImage: LPCTSTR); cdecl;
procedure Delphi_EditUI_SetNativeEditBkColor(Handle: CEditUI; dwBkColor: DWORD); cdecl;
function Delphi_EditUI_GetNativeEditBkColor(Handle: CEditUI): DWORD; cdecl;
procedure Delphi_EditUI_SetSel(Handle: CEditUI; nStartChar: LongInt; nEndChar: LongInt); cdecl;
procedure Delphi_EditUI_SetSelAll(Handle: CEditUI); cdecl;
procedure Delphi_EditUI_SetReplaceSel(Handle: CEditUI; lpszReplace: LPCTSTR); cdecl;
procedure Delphi_EditUI_SetPos(Handle: CEditUI; rc: TRect; bNeedInvalidate: Boolean); cdecl;
procedure Delphi_EditUI_Move(Handle: CEditUI; szOffset: TSize; bNeedInvalidate: Boolean); cdecl;
procedure Delphi_EditUI_SetVisible(Handle: CEditUI; bVisible: Boolean); cdecl;
procedure Delphi_EditUI_SetInternVisible(Handle: CEditUI; bVisible: Boolean); cdecl;
procedure Delphi_EditUI_EstimateSize(Handle: CEditUI; szAvailable: TSize; var Result: TSize); cdecl;
procedure Delphi_EditUI_DoEvent(Handle: CEditUI; var event: TEventUI); cdecl;
procedure Delphi_EditUI_SetAttribute(Handle: CEditUI; pstrName: LPCTSTR; pstrValue: LPCTSTR); cdecl;
procedure Delphi_EditUI_PaintStatusImage(Handle: CEditUI; hDC: HDC); cdecl;
procedure Delphi_EditUI_PaintText(Handle: CEditUI; hDC: HDC); cdecl;

//================================CProgressUI============================

function Delphi_ProgressUI_CppCreate: CProgressUI; cdecl;
procedure Delphi_ProgressUI_CppDestroy(Handle: CProgressUI); cdecl;
function Delphi_ProgressUI_GetClass(Handle: CProgressUI): LPCTSTR; cdecl;
function Delphi_ProgressUI_GetInterface(Handle: CProgressUI; pstrName: LPCTSTR): Pointer; cdecl;
function Delphi_ProgressUI_IsHorizontal(Handle: CProgressUI): Boolean; cdecl;
procedure Delphi_ProgressUI_SetHorizontal(Handle: CProgressUI; bHorizontal: Boolean); cdecl;
function Delphi_ProgressUI_GetMinValue(Handle: CProgressUI): Integer; cdecl;
procedure Delphi_ProgressUI_SetMinValue(Handle: CProgressUI; nMin: Integer); cdecl;
function Delphi_ProgressUI_GetMaxValue(Handle: CProgressUI): Integer; cdecl;
procedure Delphi_ProgressUI_SetMaxValue(Handle: CProgressUI; nMax: Integer); cdecl;
function Delphi_ProgressUI_GetValue(Handle: CProgressUI): Integer; cdecl;
procedure Delphi_ProgressUI_SetValue(Handle: CProgressUI; nValue: Integer); cdecl;
function Delphi_ProgressUI_GetForeImage(Handle: CProgressUI): LPCTSTR; cdecl;
procedure Delphi_ProgressUI_SetForeImage(Handle: CProgressUI; pStrImage: LPCTSTR); cdecl;
procedure Delphi_ProgressUI_SetAttribute(Handle: CProgressUI; pstrName: LPCTSTR; pstrValue: LPCTSTR); cdecl;
procedure Delphi_ProgressUI_PaintStatusImage(Handle: CProgressUI; hDC: HDC); cdecl;

//================================CScrollBarUI============================

function Delphi_ScrollBarUI_CppCreate: CScrollBarUI; cdecl;
procedure Delphi_ScrollBarUI_CppDestroy(Handle: CScrollBarUI); cdecl;
function Delphi_ScrollBarUI_GetClass(Handle: CScrollBarUI): LPCTSTR; cdecl;
function Delphi_ScrollBarUI_GetInterface(Handle: CScrollBarUI; pstrName: LPCTSTR): Pointer; cdecl;
function Delphi_ScrollBarUI_GetOwner(Handle: CScrollBarUI): CContainerUI; cdecl;
procedure Delphi_ScrollBarUI_SetOwner(Handle: CScrollBarUI; pOwner: CContainerUI); cdecl;
procedure Delphi_ScrollBarUI_SetVisible(Handle: CScrollBarUI; bVisible: Boolean); cdecl;
procedure Delphi_ScrollBarUI_SetEnabled(Handle: CScrollBarUI; bEnable: Boolean); cdecl;
procedure Delphi_ScrollBarUI_SetFocus(Handle: CScrollBarUI); cdecl;
function Delphi_ScrollBarUI_IsHorizontal(Handle: CScrollBarUI): Boolean; cdecl;
procedure Delphi_ScrollBarUI_SetHorizontal(Handle: CScrollBarUI; bHorizontal: Boolean); cdecl;
function Delphi_ScrollBarUI_GetScrollRange(Handle: CScrollBarUI): Integer; cdecl;
procedure Delphi_ScrollBarUI_SetScrollRange(Handle: CScrollBarUI; nRange: Integer); cdecl;
function Delphi_ScrollBarUI_GetScrollPos(Handle: CScrollBarUI): Integer; cdecl;
procedure Delphi_ScrollBarUI_SetScrollPos(Handle: CScrollBarUI; nPos: Integer; bTriggerEvent: Boolean); cdecl;
function Delphi_ScrollBarUI_GetLineSize(Handle: CScrollBarUI): Integer; cdecl;
procedure Delphi_ScrollBarUI_SetLineSize(Handle: CScrollBarUI; nSize: Integer); cdecl;
function Delphi_ScrollBarUI_GetShowButton1(Handle: CScrollBarUI): Boolean; cdecl;
procedure Delphi_ScrollBarUI_SetShowButton1(Handle: CScrollBarUI; bShow: Boolean); cdecl;
function Delphi_ScrollBarUI_GetButton1Color(Handle: CScrollBarUI): DWORD; cdecl;
procedure Delphi_ScrollBarUI_SetButton1Color(Handle: CScrollBarUI; dwColor: DWORD); cdecl;
function Delphi_ScrollBarUI_GetButton1NormalImage(Handle: CScrollBarUI): LPCTSTR; cdecl;
procedure Delphi_ScrollBarUI_SetButton1NormalImage(Handle: CScrollBarUI; pStrImage: LPCTSTR); cdecl;
function Delphi_ScrollBarUI_GetButton1HotImage(Handle: CScrollBarUI): LPCTSTR; cdecl;
procedure Delphi_ScrollBarUI_SetButton1HotImage(Handle: CScrollBarUI; pStrImage: LPCTSTR); cdecl;
function Delphi_ScrollBarUI_GetButton1PushedImage(Handle: CScrollBarUI): LPCTSTR; cdecl;
procedure Delphi_ScrollBarUI_SetButton1PushedImage(Handle: CScrollBarUI; pStrImage: LPCTSTR); cdecl;
function Delphi_ScrollBarUI_GetButton1DisabledImage(Handle: CScrollBarUI): LPCTSTR; cdecl;
procedure Delphi_ScrollBarUI_SetButton1DisabledImage(Handle: CScrollBarUI; pStrImage: LPCTSTR); cdecl;
function Delphi_ScrollBarUI_GetShowButton2(Handle: CScrollBarUI): Boolean; cdecl;
procedure Delphi_ScrollBarUI_SetShowButton2(Handle: CScrollBarUI; bShow: Boolean); cdecl;
function Delphi_ScrollBarUI_GetButton2Color(Handle: CScrollBarUI): DWORD; cdecl;
procedure Delphi_ScrollBarUI_SetButton2Color(Handle: CScrollBarUI; dwColor: DWORD); cdecl;
function Delphi_ScrollBarUI_GetButton2NormalImage(Handle: CScrollBarUI): LPCTSTR; cdecl;
procedure Delphi_ScrollBarUI_SetButton2NormalImage(Handle: CScrollBarUI; pStrImage: LPCTSTR); cdecl;
function Delphi_ScrollBarUI_GetButton2HotImage(Handle: CScrollBarUI): LPCTSTR; cdecl;
procedure Delphi_ScrollBarUI_SetButton2HotImage(Handle: CScrollBarUI; pStrImage: LPCTSTR); cdecl;
function Delphi_ScrollBarUI_GetButton2PushedImage(Handle: CScrollBarUI): LPCTSTR; cdecl;
procedure Delphi_ScrollBarUI_SetButton2PushedImage(Handle: CScrollBarUI; pStrImage: LPCTSTR); cdecl;
function Delphi_ScrollBarUI_GetButton2DisabledImage(Handle: CScrollBarUI): LPCTSTR; cdecl;
procedure Delphi_ScrollBarUI_SetButton2DisabledImage(Handle: CScrollBarUI; pStrImage: LPCTSTR); cdecl;
function Delphi_ScrollBarUI_GetThumbColor(Handle: CScrollBarUI): DWORD; cdecl;
procedure Delphi_ScrollBarUI_SetThumbColor(Handle: CScrollBarUI; dwColor: DWORD); cdecl;
function Delphi_ScrollBarUI_GetThumbNormalImage(Handle: CScrollBarUI): LPCTSTR; cdecl;
procedure Delphi_ScrollBarUI_SetThumbNormalImage(Handle: CScrollBarUI; pStrImage: LPCTSTR); cdecl;
function Delphi_ScrollBarUI_GetThumbHotImage(Handle: CScrollBarUI): LPCTSTR; cdecl;
procedure Delphi_ScrollBarUI_SetThumbHotImage(Handle: CScrollBarUI; pStrImage: LPCTSTR); cdecl;
function Delphi_ScrollBarUI_GetThumbPushedImage(Handle: CScrollBarUI): LPCTSTR; cdecl;
procedure Delphi_ScrollBarUI_SetThumbPushedImage(Handle: CScrollBarUI; pStrImage: LPCTSTR); cdecl;
function Delphi_ScrollBarUI_GetThumbDisabledImage(Handle: CScrollBarUI): LPCTSTR; cdecl;
procedure Delphi_ScrollBarUI_SetThumbDisabledImage(Handle: CScrollBarUI; pStrImage: LPCTSTR); cdecl;
function Delphi_ScrollBarUI_GetRailNormalImage(Handle: CScrollBarUI): LPCTSTR; cdecl;
procedure Delphi_ScrollBarUI_SetRailNormalImage(Handle: CScrollBarUI; pStrImage: LPCTSTR); cdecl;
function Delphi_ScrollBarUI_GetRailHotImage(Handle: CScrollBarUI): LPCTSTR; cdecl;
procedure Delphi_ScrollBarUI_SetRailHotImage(Handle: CScrollBarUI; pStrImage: LPCTSTR); cdecl;
function Delphi_ScrollBarUI_GetRailPushedImage(Handle: CScrollBarUI): LPCTSTR; cdecl;
procedure Delphi_ScrollBarUI_SetRailPushedImage(Handle: CScrollBarUI; pStrImage: LPCTSTR); cdecl;
function Delphi_ScrollBarUI_GetRailDisabledImage(Handle: CScrollBarUI): LPCTSTR; cdecl;
procedure Delphi_ScrollBarUI_SetRailDisabledImage(Handle: CScrollBarUI; pStrImage: LPCTSTR); cdecl;
function Delphi_ScrollBarUI_GetBkNormalImage(Handle: CScrollBarUI): LPCTSTR; cdecl;
procedure Delphi_ScrollBarUI_SetBkNormalImage(Handle: CScrollBarUI; pStrImage: LPCTSTR); cdecl;
function Delphi_ScrollBarUI_GetBkHotImage(Handle: CScrollBarUI): LPCTSTR; cdecl;
procedure Delphi_ScrollBarUI_SetBkHotImage(Handle: CScrollBarUI; pStrImage: LPCTSTR); cdecl;
function Delphi_ScrollBarUI_GetBkPushedImage(Handle: CScrollBarUI): LPCTSTR; cdecl;
procedure Delphi_ScrollBarUI_SetBkPushedImage(Handle: CScrollBarUI; pStrImage: LPCTSTR); cdecl;
function Delphi_ScrollBarUI_GetBkDisabledImage(Handle: CScrollBarUI): LPCTSTR; cdecl;
procedure Delphi_ScrollBarUI_SetBkDisabledImage(Handle: CScrollBarUI; pStrImage: LPCTSTR); cdecl;
procedure Delphi_ScrollBarUI_SetPos(Handle: CScrollBarUI; rc: TRect; bNeedInvalidate: Boolean); cdecl;
procedure Delphi_ScrollBarUI_DoEvent(Handle: CScrollBarUI; var event: TEventUI); cdecl;
procedure Delphi_ScrollBarUI_SetAttribute(Handle: CScrollBarUI; pstrName: LPCTSTR; pstrValue: LPCTSTR); cdecl;
procedure Delphi_ScrollBarUI_DoPaint(Handle: CScrollBarUI; hDC: HDC; var rcPaint: TRect; pStopControl: CControlUI); cdecl;
procedure Delphi_ScrollBarUI_PaintBk(Handle: CScrollBarUI; hDC: HDC); cdecl;
procedure Delphi_ScrollBarUI_PaintButton1(Handle: CScrollBarUI; hDC: HDC); cdecl;
procedure Delphi_ScrollBarUI_PaintButton2(Handle: CScrollBarUI; hDC: HDC); cdecl;
procedure Delphi_ScrollBarUI_PaintThumb(Handle: CScrollBarUI; hDC: HDC); cdecl;
procedure Delphi_ScrollBarUI_PaintRail(Handle: CScrollBarUI; hDC: HDC); cdecl;

//================================CSliderUI============================

function Delphi_SliderUI_CppCreate: CSliderUI; cdecl;
procedure Delphi_SliderUI_CppDestroy(Handle: CSliderUI); cdecl;
function Delphi_SliderUI_GetClass(Handle: CSliderUI): LPCTSTR; cdecl;
function Delphi_SliderUI_GetControlFlags(Handle: CSliderUI): UINT; cdecl;
function Delphi_SliderUI_GetInterface(Handle: CSliderUI; pstrName: LPCTSTR): Pointer; cdecl;
procedure Delphi_SliderUI_SetEnabled(Handle: CSliderUI; bEnable: Boolean); cdecl;
function Delphi_SliderUI_GetChangeStep(Handle: CSliderUI): Integer; cdecl;
procedure Delphi_SliderUI_SetChangeStep(Handle: CSliderUI; step: Integer); cdecl;
procedure Delphi_SliderUI_SetThumbSize(Handle: CSliderUI; szXY: TSize); cdecl;
procedure Delphi_SliderUI_GetThumbRect(Handle: CSliderUI; var Result: TRect); cdecl;
function Delphi_SliderUI_IsImmMode(Handle: CSliderUI): Boolean; cdecl;
procedure Delphi_SliderUI_SetImmMode(Handle: CSliderUI; bImmMode: Boolean); cdecl;
function Delphi_SliderUI_GetThumbImage(Handle: CSliderUI): LPCTSTR; cdecl;
procedure Delphi_SliderUI_SetThumbImage(Handle: CSliderUI; pStrImage: LPCTSTR); cdecl;
function Delphi_SliderUI_GetThumbHotImage(Handle: CSliderUI): LPCTSTR; cdecl;
procedure Delphi_SliderUI_SetThumbHotImage(Handle: CSliderUI; pStrImage: LPCTSTR); cdecl;
function Delphi_SliderUI_GetThumbPushedImage(Handle: CSliderUI): LPCTSTR; cdecl;
procedure Delphi_SliderUI_SetThumbPushedImage(Handle: CSliderUI; pStrImage: LPCTSTR); cdecl;
procedure Delphi_SliderUI_DoEvent(Handle: CSliderUI; var event: TEventUI); cdecl;
procedure Delphi_SliderUI_SetAttribute(Handle: CSliderUI; pstrName: LPCTSTR; pstrValue: LPCTSTR); cdecl;
procedure Delphi_SliderUI_PaintStatusImage(Handle: CSliderUI; hDC: HDC); cdecl;

//================================CTextUI============================

function Delphi_TextUI_CppCreate: CTextUI; cdecl;
procedure Delphi_TextUI_CppDestroy(Handle: CTextUI); cdecl;
function Delphi_TextUI_GetClass(Handle: CTextUI): LPCTSTR; cdecl;
function Delphi_TextUI_GetControlFlags(Handle: CTextUI): UINT; cdecl;
function Delphi_TextUI_GetInterface(Handle: CTextUI; pstrName: LPCTSTR): Pointer; cdecl;
function Delphi_TextUI_GetLinkContent(Handle: CTextUI; iIndex: Integer): CDuiString; cdecl;
procedure Delphi_TextUI_DoEvent(Handle: CTextUI; var event: TEventUI); cdecl;
procedure Delphi_TextUI_EstimateSize(Handle: CTextUI; szAvailable: TSize; var Result: TSize); cdecl;
procedure Delphi_TextUI_PaintText(Handle: CTextUI; hDC: HDC); cdecl;

//================================CTreeNodeUI============================

function Delphi_TreeNodeUI_CppCreate(_ParentNode: CTreeNodeUI): CTreeNodeUI; cdecl;
procedure Delphi_TreeNodeUI_CppDestroy(Handle: CTreeNodeUI); cdecl;
function Delphi_TreeNodeUI_GetClass(Handle: CTreeNodeUI): LPCTSTR; cdecl;
function Delphi_TreeNodeUI_GetInterface(Handle: CTreeNodeUI; pstrName: LPCTSTR): Pointer; cdecl;
procedure Delphi_TreeNodeUI_DoEvent(Handle: CTreeNodeUI; var event: TEventUI); cdecl;
procedure Delphi_TreeNodeUI_Invalidate(Handle: CTreeNodeUI); cdecl;
function Delphi_TreeNodeUI_Select(Handle: CTreeNodeUI; bSelect: Boolean; bTriggerEvent: Boolean): Boolean; cdecl;
function Delphi_TreeNodeUI_Add(Handle: CTreeNodeUI; _pTreeNodeUI: CControlUI): Boolean; cdecl;
function Delphi_TreeNodeUI_AddAt(Handle: CTreeNodeUI; pControl: CControlUI; iIndex: Integer): Boolean; cdecl;
function Delphi_TreeNodeUI_Remove(Handle: CTreeNodeUI; pControl: CControlUI): Boolean; cdecl;
procedure Delphi_TreeNodeUI_SetVisibleTag(Handle: CTreeNodeUI; _IsVisible: Boolean); cdecl;
function Delphi_TreeNodeUI_GetVisibleTag(Handle: CTreeNodeUI): Boolean; cdecl;
procedure Delphi_TreeNodeUI_SetItemText(Handle: CTreeNodeUI; pstrValue: LPCTSTR); cdecl;
function Delphi_TreeNodeUI_GetItemText(Handle: CTreeNodeUI): CDuiString; cdecl;
procedure Delphi_TreeNodeUI_CheckBoxSelected(Handle: CTreeNodeUI; _Selected: Boolean); cdecl;
function Delphi_TreeNodeUI_IsCheckBoxSelected(Handle: CTreeNodeUI): Boolean; cdecl;
function Delphi_TreeNodeUI_IsHasChild(Handle: CTreeNodeUI): Boolean; cdecl;
function Delphi_TreeNodeUI_AddChildNode(Handle: CTreeNodeUI; _pTreeNodeUI: CTreeNodeUI): Boolean; cdecl;
function Delphi_TreeNodeUI_RemoveAt(Handle: CTreeNodeUI; _pTreeNodeUI: CTreeNodeUI): Boolean; cdecl;
procedure Delphi_TreeNodeUI_SetParentNode(Handle: CTreeNodeUI; _pParentTreeNode: CTreeNodeUI); cdecl;
function Delphi_TreeNodeUI_GetParentNode(Handle: CTreeNodeUI): CTreeNodeUI; cdecl;
function Delphi_TreeNodeUI_GetCountChild(Handle: CTreeNodeUI): LongInt; cdecl;
procedure Delphi_TreeNodeUI_SetTreeView(Handle: CTreeNodeUI; _CTreeViewUI: CTreeViewUI); cdecl;
function Delphi_TreeNodeUI_GetTreeView(Handle: CTreeNodeUI): CTreeViewUI; cdecl;
function Delphi_TreeNodeUI_GetChildNode(Handle: CTreeNodeUI; _nIndex: Integer): CTreeNodeUI; cdecl;
procedure Delphi_TreeNodeUI_SetVisibleFolderBtn(Handle: CTreeNodeUI; _IsVisibled: Boolean); cdecl;
function Delphi_TreeNodeUI_GetVisibleFolderBtn(Handle: CTreeNodeUI): Boolean; cdecl;
procedure Delphi_TreeNodeUI_SetVisibleCheckBtn(Handle: CTreeNodeUI; _IsVisibled: Boolean); cdecl;
function Delphi_TreeNodeUI_GetVisibleCheckBtn(Handle: CTreeNodeUI): Boolean; cdecl;
procedure Delphi_TreeNodeUI_SetItemTextColor(Handle: CTreeNodeUI; _dwItemTextColor: DWORD); cdecl;
function Delphi_TreeNodeUI_GetItemTextColor(Handle: CTreeNodeUI): DWORD; cdecl;
procedure Delphi_TreeNodeUI_SetItemHotTextColor(Handle: CTreeNodeUI; _dwItemHotTextColor: DWORD); cdecl;
function Delphi_TreeNodeUI_GetItemHotTextColor(Handle: CTreeNodeUI): DWORD; cdecl;
procedure Delphi_TreeNodeUI_SetSelItemTextColor(Handle: CTreeNodeUI; _dwSelItemTextColor: DWORD); cdecl;
function Delphi_TreeNodeUI_GetSelItemTextColor(Handle: CTreeNodeUI): DWORD; cdecl;
procedure Delphi_TreeNodeUI_SetSelItemHotTextColor(Handle: CTreeNodeUI; _dwSelHotItemTextColor: DWORD); cdecl;
function Delphi_TreeNodeUI_GetSelItemHotTextColor(Handle: CTreeNodeUI): DWORD; cdecl;
procedure Delphi_TreeNodeUI_SetAttribute(Handle: CTreeNodeUI; pstrName: LPCTSTR; pstrValue: LPCTSTR); cdecl;
function Delphi_TreeNodeUI_GetTreeNodes(Handle: CTreeNodeUI): CStdPtrArray; cdecl;
function Delphi_TreeNodeUI_GetTreeIndex(Handle: CTreeNodeUI): Integer; cdecl;
function Delphi_TreeNodeUI_GetNodeIndex(Handle: CTreeNodeUI): Integer; cdecl;

//================================CTreeViewUI============================

function Delphi_TreeViewUI_CppCreate: CTreeViewUI; cdecl;
procedure Delphi_TreeViewUI_CppDestroy(Handle: CTreeViewUI); cdecl;
function Delphi_TreeViewUI_GetClass(Handle: CTreeViewUI): LPCTSTR; cdecl;
function Delphi_TreeViewUI_GetInterface(Handle: CTreeViewUI; pstrName: LPCTSTR): Pointer; cdecl;
function Delphi_TreeViewUI_Add(Handle: CTreeViewUI; pControl: CTreeNodeUI): Boolean; cdecl;
function Delphi_TreeViewUI_AddAt_01(Handle: CTreeViewUI; pControl: CTreeNodeUI; iIndex: Integer): LongInt; cdecl;
function Delphi_TreeViewUI_AddAt_02(Handle: CTreeViewUI; pControl: CTreeNodeUI; _IndexNode: CTreeNodeUI): Boolean; cdecl;
function Delphi_TreeViewUI_Remove(Handle: CTreeViewUI; pControl: CTreeNodeUI): Boolean; cdecl;
function Delphi_TreeViewUI_RemoveAt(Handle: CTreeViewUI; iIndex: Integer): Boolean; cdecl;
procedure Delphi_TreeViewUI_RemoveAll(Handle: CTreeViewUI); cdecl;
function Delphi_TreeViewUI_OnCheckBoxChanged(Handle: CTreeViewUI; param: PPointer): Boolean; cdecl;
function Delphi_TreeViewUI_OnFolderChanged(Handle: CTreeViewUI; param: PPointer): Boolean; cdecl;
function Delphi_TreeViewUI_OnDBClickItem(Handle: CTreeViewUI; param: PPointer): Boolean; cdecl;
function Delphi_TreeViewUI_SetItemCheckBox(Handle: CTreeViewUI; _Selected: Boolean; _TreeNode: CTreeNodeUI): Boolean; cdecl;
procedure Delphi_TreeViewUI_SetItemExpand(Handle: CTreeViewUI; _Expanded: Boolean; _TreeNode: CTreeNodeUI); cdecl;
procedure Delphi_TreeViewUI_Notify(Handle: CTreeViewUI; var msg: TNotifyUI); cdecl;
procedure Delphi_TreeViewUI_SetVisibleFolderBtn(Handle: CTreeViewUI; _IsVisibled: Boolean); cdecl;
function Delphi_TreeViewUI_GetVisibleFolderBtn(Handle: CTreeViewUI): Boolean; cdecl;
procedure Delphi_TreeViewUI_SetVisibleCheckBtn(Handle: CTreeViewUI; _IsVisibled: Boolean); cdecl;
function Delphi_TreeViewUI_GetVisibleCheckBtn(Handle: CTreeViewUI): Boolean; cdecl;
procedure Delphi_TreeViewUI_SetItemMinWidth(Handle: CTreeViewUI; _ItemMinWidth: UINT); cdecl;
function Delphi_TreeViewUI_GetItemMinWidth(Handle: CTreeViewUI): UINT; cdecl;
procedure Delphi_TreeViewUI_SetItemTextColor(Handle: CTreeViewUI; _dwItemTextColor: DWORD); cdecl;
procedure Delphi_TreeViewUI_SetItemHotTextColor(Handle: CTreeViewUI; _dwItemHotTextColor: DWORD); cdecl;
procedure Delphi_TreeViewUI_SetSelItemTextColor(Handle: CTreeViewUI; _dwSelItemTextColor: DWORD); cdecl;
procedure Delphi_TreeViewUI_SetSelItemHotTextColor(Handle: CTreeViewUI; _dwSelHotItemTextColor: DWORD); cdecl;
procedure Delphi_TreeViewUI_SetAttribute(Handle: CTreeViewUI; pstrName: LPCTSTR; pstrValue: LPCTSTR); cdecl;

//================================CTabLayoutUI============================

function Delphi_TabLayoutUI_CppCreate: CTabLayoutUI; cdecl;
procedure Delphi_TabLayoutUI_CppDestroy(Handle: CTabLayoutUI); cdecl;
function Delphi_TabLayoutUI_GetClass(Handle: CTabLayoutUI): LPCTSTR; cdecl;
function Delphi_TabLayoutUI_GetInterface(Handle: CTabLayoutUI; pstrName: LPCTSTR): Pointer; cdecl;
function Delphi_TabLayoutUI_Add(Handle: CTabLayoutUI; pControl: CControlUI): Boolean; cdecl;
function Delphi_TabLayoutUI_AddAt(Handle: CTabLayoutUI; pControl: CControlUI; iIndex: Integer): Boolean; cdecl;
function Delphi_TabLayoutUI_Remove(Handle: CTabLayoutUI; pControl: CControlUI): Boolean; cdecl;
procedure Delphi_TabLayoutUI_RemoveAll(Handle: CTabLayoutUI); cdecl;
function Delphi_TabLayoutUI_GetCurSel(Handle: CTabLayoutUI): Integer; cdecl;
function Delphi_TabLayoutUI_SelectItem_01(Handle: CTabLayoutUI; iIndex: Integer; bTriggerEvent: Boolean): Boolean; cdecl;
function Delphi_TabLayoutUI_SelectItem_02(Handle: CTabLayoutUI; pControl: CControlUI; bTriggerEvent: Boolean): Boolean; cdecl;
procedure Delphi_TabLayoutUI_SetPos(Handle: CTabLayoutUI; rc: TRect; bNeedInvalidate: Boolean); cdecl;
procedure Delphi_TabLayoutUI_SetAttribute(Handle: CTabLayoutUI; pstrName: LPCTSTR; pstrValue: LPCTSTR); cdecl;

//================================CHorizontalLayoutUI============================

function Delphi_HorizontalLayoutUI_CppCreate: CHorizontalLayoutUI; cdecl;
procedure Delphi_HorizontalLayoutUI_CppDestroy(Handle: CHorizontalLayoutUI); cdecl;
function Delphi_HorizontalLayoutUI_GetClass(Handle: CHorizontalLayoutUI): LPCTSTR; cdecl;
function Delphi_HorizontalLayoutUI_GetInterface(Handle: CHorizontalLayoutUI; pstrName: LPCTSTR): Pointer; cdecl;
function Delphi_HorizontalLayoutUI_GetControlFlags(Handle: CHorizontalLayoutUI): UINT; cdecl;
procedure Delphi_HorizontalLayoutUI_SetSepWidth(Handle: CHorizontalLayoutUI; iWidth: Integer); cdecl;
function Delphi_HorizontalLayoutUI_GetSepWidth(Handle: CHorizontalLayoutUI): Integer; cdecl;
procedure Delphi_HorizontalLayoutUI_SetSepImmMode(Handle: CHorizontalLayoutUI; bImmediately: Boolean); cdecl;
function Delphi_HorizontalLayoutUI_IsSepImmMode(Handle: CHorizontalLayoutUI): Boolean; cdecl;
procedure Delphi_HorizontalLayoutUI_SetAttribute(Handle: CHorizontalLayoutUI; pstrName: LPCTSTR; pstrValue: LPCTSTR); cdecl;
procedure Delphi_HorizontalLayoutUI_DoEvent(Handle: CHorizontalLayoutUI; var event: TEventUI); cdecl;
procedure Delphi_HorizontalLayoutUI_SetPos(Handle: CHorizontalLayoutUI; rc: TRect; bNeedInvalidate: Boolean); cdecl;
procedure Delphi_HorizontalLayoutUI_DoPostPaint(Handle: CHorizontalLayoutUI; hDC: HDC; var rcPaint: TRect); cdecl;
procedure Delphi_HorizontalLayoutUI_GetThumbRect(Handle: CHorizontalLayoutUI; bUseNew: Boolean; var Result: TRect); cdecl;

//================================CListHeaderUI============================

function Delphi_ListHeaderUI_CppCreate: CListHeaderUI; cdecl;
procedure Delphi_ListHeaderUI_CppDestroy(Handle: CListHeaderUI); cdecl;
function Delphi_ListHeaderUI_GetClass(Handle: CListHeaderUI): LPCTSTR; cdecl;
function Delphi_ListHeaderUI_GetInterface(Handle: CListHeaderUI; pstrName: LPCTSTR): Pointer; cdecl;
procedure Delphi_ListHeaderUI_EstimateSize(Handle: CListHeaderUI; szAvailable: TSize; var Result: TSize); cdecl;


 //================================CRenderClip============================

function Delphi_RenderClip_CppCreate: CRenderClip; cdecl;
procedure Delphi_RenderClip_CppDestroy(Handle: CRenderClip); cdecl;
procedure Delphi_RenderClip_GenerateClip(hDC: HDC; rc: TRect; var clip: CRenderClip); cdecl;
procedure Delphi_RenderClip_GenerateRoundClip(hDC: HDC; rc: TRect; rcItem: TRect; width: Integer; height: Integer; var clip: CRenderClip); cdecl;
procedure Delphi_RenderClip_UseOldClipBegin(hDC: HDC; var clip: CRenderClip); cdecl;
procedure Delphi_RenderClip_UseOldClipEnd(hDC: HDC; var clip: CRenderClip); cdecl;

//================================CRenderEngine============================

function Delphi_RenderEngine_CppCreate: CRenderEngine; cdecl;
procedure Delphi_RenderEngine_CppDestroy(Handle: CRenderEngine); cdecl;
function Delphi_RenderEngine_AdjustColor(dwColor: DWORD; H: Short; S: Short; L: Short): DWORD; cdecl;
function Delphi_RenderEngine_CreateARGB32Bitmap(hDC: HDC; cx: Integer; cy: Integer; pBits: COLORREF): HBITMAP; cdecl;
procedure Delphi_RenderEngine_AdjustImage(bUseHSL: Boolean; imageInfo: PImageInfo; H: Short; S: Short; L: Short); cdecl;
function Delphi_RenderEngine_LoadImage(bitmap: STRINGorID; AType: LPCTSTR; mask: DWORD): PImageInfo; cdecl;
procedure Delphi_RenderEngine_FreeImage(bitmap: PImageInfo; bDelete: Boolean); cdecl;
procedure Delphi_RenderEngine_DrawImage_01(hDC: HDC; hBitmap: HBITMAP; var rc: TRect; var rcPaint: TRect; var rcBmpPart: TRect; var rcScale9: TRect; alphaChannel: Boolean; uFade: Byte; hole: Boolean; xtiled: Boolean; ytiled: Boolean); cdecl;
function Delphi_RenderEngine_DrawImage_02(hDC: HDC; pManager: CPaintManagerUI; var rcItem: TRect; var rcPaint: TRect; var drawInfo: TDrawInfo): Boolean; cdecl;
function Delphi_RenderEngine_GenerateBitmap_01(pManager: CPaintManagerUI; rc: TRect; pStopControl: CControlUI; dwFilterColor: DWORD): HBITMAP; cdecl;
function Delphi_RenderEngine_GenerateBitmap_02(pManager: CPaintManagerUI; pControl: CControlUI; rc: TRect; dwFilterColor: DWORD): HBITMAP; cdecl;
procedure Delphi_RenderEngine_DrawColor(hDC: HDC; var rc: TRect; color: DWORD); cdecl;
procedure Delphi_RenderEngine_DrawGradient(hDC: HDC; var rc: TRect; dwFirst: DWORD; dwSecond: DWORD; bVertical: Boolean; nSteps: Integer); cdecl;
procedure Delphi_RenderEngine_DrawLine(hDC: HDC; var rc: TRect; nSize: Integer; dwPenColor: DWORD; nStyle: Integer); cdecl;
procedure Delphi_RenderEngine_DrawRect(hDC: HDC; var rc: TRect; nSize: Integer; dwPenColor: DWORD; nStyle: Integer); cdecl;
procedure Delphi_RenderEngine_DrawRoundRect(hDC: HDC; var rc: TRect; width: Integer; height: Integer; nSize: Integer; dwPenColor: DWORD; nStyle: Integer); cdecl;
procedure Delphi_RenderEngine_DrawText(hDC: HDC; pManager: CPaintManagerUI; var rc: TRect; pstrText: LPCTSTR; dwTextColor: DWORD; iFont: Integer; uStyle: UINT); cdecl;
procedure Delphi_RenderEngine_DrawHtmlText(hDC: HDC; pManager: CPaintManagerUI; var rc: TRect; pstrText: LPCTSTR; dwTextColor: DWORD; pLinks: PRect; sLinks: CDuiString; var nLinkRects: Integer; uStyle: UINT); cdecl;
function Delphi_RenderEngine_GenerateBitmap(pManager: CPaintManagerUI; pControl: CControlUI; rc: TRect): HBITMAP; cdecl;
procedure Delphi_RenderEngine_GetTextSize(hDC: HDC; pManager: CPaintManagerUI; pstrText: LPCTSTR; iFont: Integer; uStyle: UINT; var Result: TSize); cdecl;



//================================CListElementUI============================

//function Delphi_ListElementUI_CppCreate: CListElementUI; cdecl;
//procedure Delphi_ListElementUI_CppDestroy(Handle: CListElementUI); cdecl;
function Delphi_ListElementUI_GetClass(Handle: CListElementUI): LPCTSTR; cdecl;
function Delphi_ListElementUI_GetControlFlags(Handle: CListElementUI): UINT; cdecl;
function Delphi_ListElementUI_GetInterface(Handle: CListElementUI; pstrName: LPCTSTR): Pointer; cdecl;
procedure Delphi_ListElementUI_SetEnabled(Handle: CListElementUI; bEnable: Boolean); cdecl;
function Delphi_ListElementUI_GetIndex(Handle: CListElementUI): Integer; cdecl;
procedure Delphi_ListElementUI_SetIndex(Handle: CListElementUI; iIndex: Integer); cdecl;
function Delphi_ListElementUI_GetOwner(Handle: CListElementUI): IListOwnerUI; cdecl;
procedure Delphi_ListElementUI_SetOwner(Handle: CListElementUI; pOwner: CControlUI); cdecl;
procedure Delphi_ListElementUI_SetVisible(Handle: CListElementUI; bVisible: Boolean); cdecl;
function Delphi_ListElementUI_IsSelected(Handle: CListElementUI): Boolean; cdecl;
function Delphi_ListElementUI_Select(Handle: CListElementUI; bSelect: Boolean): Boolean; cdecl;
function Delphi_ListElementUI_IsExpanded(Handle: CListElementUI): Boolean; cdecl;
function Delphi_ListElementUI_Expand(Handle: CListElementUI; bExpand: Boolean): Boolean; cdecl;
procedure Delphi_ListElementUI_Invalidate(Handle: CListElementUI); cdecl;
function Delphi_ListElementUI_Activate(Handle: CListElementUI): Boolean; cdecl;
procedure Delphi_ListElementUI_DoEvent(Handle: CListElementUI; var event: TEventUI); cdecl;
procedure Delphi_ListElementUI_SetAttribute(Handle: CListElementUI; pstrName: LPCTSTR; pstrValue: LPCTSTR); cdecl;
procedure Delphi_ListElementUI_DrawItemBk(Handle: CListElementUI; hDC: HDC; const rcItem: TRect); cdecl;

//================================CListLabelElementUI============================

function Delphi_ListLabelElementUI_CppCreate: CListLabelElementUI; cdecl;
procedure Delphi_ListLabelElementUI_CppDestroy(Handle: CListLabelElementUI); cdecl;
function Delphi_ListLabelElementUI_GetClass(Handle: CListLabelElementUI): LPCTSTR; cdecl;
function Delphi_ListLabelElementUI_GetInterface(Handle: CListLabelElementUI; pstrName: LPCTSTR): Pointer; cdecl;
procedure Delphi_ListLabelElementUI_DoEvent(Handle: CListLabelElementUI; var event: TEventUI); cdecl;
procedure Delphi_ListLabelElementUI_EstimateSize(Handle: CListLabelElementUI; szAvailable: TSize; var Result: TSize); cdecl;
procedure Delphi_ListLabelElementUI_DoPaint(Handle: CListLabelElementUI; hDC: HDC; var rcPaint: TRect; pStopControl: CControlUI); cdecl;
procedure Delphi_ListLabelElementUI_DrawItemText(Handle: CListLabelElementUI; hDC: HDC; const rcItem: TRect); cdecl;

//================================CListTextElementUI============================

function Delphi_ListTextElementUI_CppCreate: CListTextElementUI; cdecl;
procedure Delphi_ListTextElementUI_CppDestroy(Handle: CListTextElementUI); cdecl;
function Delphi_ListTextElementUI_GetClass(Handle: CListTextElementUI): LPCTSTR; cdecl;
function Delphi_ListTextElementUI_GetInterface(Handle: CListTextElementUI; pstrName: LPCTSTR): Pointer; cdecl;
function Delphi_ListTextElementUI_GetControlFlags(Handle: CListTextElementUI): UINT; cdecl;
function Delphi_ListTextElementUI_GetText(Handle: CListTextElementUI; iIndex: Integer): LPCTSTR; cdecl;
procedure Delphi_ListTextElementUI_SetText(Handle: CListTextElementUI; iIndex: Integer; pstrText: LPCTSTR); cdecl;
procedure Delphi_ListTextElementUI_SetOwner(Handle: CListTextElementUI; pOwner: CControlUI); cdecl;
function Delphi_ListTextElementUI_GetLinkContent(Handle: CListTextElementUI; iIndex: Integer): CDuiString; cdecl;
procedure Delphi_ListTextElementUI_DoEvent(Handle: CListTextElementUI; var event: TEventUI); cdecl;
procedure Delphi_ListTextElementUI_EstimateSize(Handle: CListTextElementUI; szAvailable: TSize; var Result: TSize); cdecl;
procedure Delphi_ListTextElementUI_DrawItemText(Handle: CListTextElementUI; hDC: HDC; const rcItem: TRect); cdecl;


//================================CGifAnimUI============================

function Delphi_GifAnimUI_CppCreate: CGifAnimUI; cdecl;
procedure Delphi_GifAnimUI_CppDestroy(Handle: CGifAnimUI); cdecl;
function Delphi_GifAnimUI_GetClass(Handle: CGifAnimUI): LPCTSTR; cdecl;
function Delphi_GifAnimUI_GetInterface(Handle: CGifAnimUI; pstrName: LPCTSTR): Pointer; cdecl;
procedure Delphi_GifAnimUI_DoInit(Handle: CGifAnimUI); cdecl;
procedure Delphi_GifAnimUI_DoPaint(Handle: CGifAnimUI; hDC: HDC; var rcPaint: TRect; pStopControl: CControlUI); cdecl;
procedure Delphi_GifAnimUI_DoEvent(Handle: CGifAnimUI; var event: TEventUI); cdecl;
procedure Delphi_GifAnimUI_SetVisible(Handle: CGifAnimUI; bVisible: Boolean); cdecl;
procedure Delphi_GifAnimUI_SetAttribute(Handle: CGifAnimUI; pstrName: LPCTSTR; pstrValue: LPCTSTR); cdecl;
procedure Delphi_GifAnimUI_SetBkImage(Handle: CGifAnimUI; pStrImage: LPCTSTR); cdecl;
function Delphi_GifAnimUI_GetBkImage(Handle: CGifAnimUI): LPCTSTR; cdecl;
procedure Delphi_GifAnimUI_SetAutoPlay(Handle: CGifAnimUI; bIsAuto: Boolean); cdecl;
function Delphi_GifAnimUI_IsAutoPlay(Handle: CGifAnimUI): Boolean; cdecl;
procedure Delphi_GifAnimUI_SetAutoSize(Handle: CGifAnimUI; bIsAuto: Boolean); cdecl;
function Delphi_GifAnimUI_IsAutoSize(Handle: CGifAnimUI): Boolean; cdecl;
procedure Delphi_GifAnimUI_PlayGif(Handle: CGifAnimUI); cdecl;
procedure Delphi_GifAnimUI_PauseGif(Handle: CGifAnimUI); cdecl;
procedure Delphi_GifAnimUI_StopGif(Handle: CGifAnimUI); cdecl;


//================================CChildLayoutUI============================

function Delphi_ChildLayoutUI_CppCreate: CChildLayoutUI; cdecl;
procedure Delphi_ChildLayoutUI_CppDestroy(Handle: CChildLayoutUI); cdecl;
procedure Delphi_ChildLayoutUI_Init(Handle: CChildLayoutUI); cdecl;
procedure Delphi_ChildLayoutUI_SetAttribute(Handle: CChildLayoutUI; pstrName: LPCTSTR; pstrValue: LPCTSTR); cdecl;
procedure Delphi_ChildLayoutUI_SetChildLayoutXML(Handle: CChildLayoutUI; pXML: CDuiString); cdecl;
function Delphi_ChildLayoutUI_GetChildLayoutXML(Handle: CChildLayoutUI): CDuiString; cdecl;
function Delphi_ChildLayoutUI_GetInterface(Handle: CChildLayoutUI; pstrName: LPCTSTR): Pointer; cdecl;
function Delphi_ChildLayoutUI_GetClass(Handle: CChildLayoutUI): LPCTSTR; cdecl;

//================================CTileLayoutUI============================

function Delphi_TileLayoutUI_CppCreate: CTileLayoutUI; cdecl;
procedure Delphi_TileLayoutUI_CppDestroy(Handle: CTileLayoutUI); cdecl;
function Delphi_TileLayoutUI_GetClass(Handle: CTileLayoutUI): LPCTSTR; cdecl;
function Delphi_TileLayoutUI_GetInterface(Handle: CTileLayoutUI; pstrName: LPCTSTR): Pointer; cdecl;
procedure Delphi_TileLayoutUI_SetPos(Handle: CTileLayoutUI; rc: TRect; bNeedInvalidate: Boolean); cdecl;
function Delphi_TileLayoutUI_GetFixedColumns(Handle: CTileLayoutUI): Integer; cdecl;
procedure Delphi_TileLayoutUI_SetFixedColumns(Handle: CTileLayoutUI; iColums: Integer); cdecl;
function Delphi_TileLayoutUI_GetChildVPadding(Handle: CTileLayoutUI): Integer; cdecl;
procedure Delphi_TileLayoutUI_SetChildVPadding(Handle: CTileLayoutUI; iPadding: Integer); cdecl;
procedure Delphi_TileLayoutUI_GetItemSize(Handle: CTileLayoutUI; var Result: TSize); cdecl;
procedure Delphi_TileLayoutUI_SetItemSize(Handle: CTileLayoutUI; szSize: TSize); cdecl;
function Delphi_TileLayoutUI_GetColumns(Handle: CTileLayoutUI): Integer; cdecl;
function Delphi_TileLayoutUI_GetRows(Handle: CTileLayoutUI): Integer; cdecl;
//procedure Delphi_TileLayoutUI_SetColumns(Handle: CTileLayoutUI; nCols: Integer); cdecl;
procedure Delphi_TileLayoutUI_SetAttribute(Handle: CTileLayoutUI; pstrName: LPCTSTR; pstrValue: LPCTSTR); cdecl;

//================================CNativeControlUI============================

function Delphi_NativeControlUI_CppCreate(hWnd: HWND): CNativeControlUI; cdecl;
procedure Delphi_NativeControlUI_CppDestroy(Handle: CNativeControlUI); cdecl;
procedure Delphi_NativeControlUI_SetInternVisible(Handle: CNativeControlUI; bVisible: Boolean); cdecl;
procedure Delphi_NativeControlUI_SetVisible(Handle: CNativeControlUI; bVisible: Boolean); cdecl;
procedure Delphi_NativeControlUI_SetPos(Handle: CNativeControlUI; rc: TRect; bNeedInvalidate: Boolean); cdecl;
function Delphi_NativeControlUI_GetClass(Handle: CNativeControlUI): LPCTSTR; cdecl;
function Delphi_NativeControlUI_GetText(Handle: CNativeControlUI): CDuiString; cdecl;
procedure Delphi_NativeControlUI_SetText(Handle: CNativeControlUI; pstrText: LPCTSTR); cdecl;
procedure Delphi_NativeControlUI_SetNativeHandle(Handle: CNativeControlUI; hWd: HWND); cdecl;