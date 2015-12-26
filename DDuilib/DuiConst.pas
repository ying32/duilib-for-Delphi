//***************************************************************************
//
//       名称：DuiConst.pas
//       工具：RAD Studio XE6
//       日期：2015/11/29 0:28:12
//       作者：ying32
//       QQ  ：1444386932
//       E-mail：1444386932@qq.com
//       版权所有 (C) 2015-2015 ying32 All Rights Reserved
//
//
//***************************************************************************
unit DuiConst;

interface

const

  DUI_MSGTYPE_MENU           = 'menu';
  DUI_MSGTYPE_LINK           = 'link';

  DUI_MSGTYPE_TIMER          = 'timer';
  DUI_MSGTYPE_CLICK          = 'click';

  DUI_MSGTYPE_RETURN         = 'return';
  DUI_MSGTYPE_SCROLL         = 'scroll';

  DUI_MSGTYPE_DROPDOWN       = 'dropdown';
  DUI_MSGTYPE_SETFOCUS       = 'setfocus';

  DUI_MSGTYPE_KILLFOCUS      = 'killfocus';
  DUI_MSGTYPE_ITEMCLICK 		 = 'itemclick';
  DUI_MSGTYPE_TABSELECT      = 'tabselect';

  DUI_MSGTYPE_ITEMSELECT 		 = 'itemselect';
  DUI_MSGTYPE_ITEMEXPAND     = 'itemexpand';
  DUI_MSGTYPE_WINDOWINIT     = 'windowinit';
  DUI_MSGTYPE_BUTTONDOWN 		 = 'buttondown';
  DUI_MSGTYPE_MOUSEENTER		 = 'mouseenter';
  DUI_MSGTYPE_MOUSELEAVE		 = 'mouseleave';

  DUI_MSGTYPE_TEXTCHANGED    = 'textchanged';
  DUI_MSGTYPE_HEADERCLICK    = 'headerclick';
  DUI_MSGTYPE_ITEMDBCLICK    = 'itemdbclick';
  DUI_MSGTYPE_SHOWACTIVEX    = 'showactivex';

  DUI_MSGTYPE_ITEMCOLLAPSE   = 'itemcollapse';
  DUI_MSGTYPE_ITEMACTIVATE   = 'itemactivate';
  DUI_MSGTYPE_VALUECHANGED   = 'valuechanged';

  DUI_MSGTYPE_SELECTCHANGED  = 'selectchanged';

  DUI_MSGTYPE_MENUITEMCLICK  = 'menuitemclick';

  DUI_CTR_EDIT                  = 'Edit';
  DUI_CTR_LIST                  = 'List';
  DUI_CTR_TEXT                  = 'Text';

  DUI_CTR_COMBO                 = 'Combo';
  DUI_CTR_LABEL                 = 'Label';
  DUI_CTR_FLASH					= 'Flash';

  DUI_CTR_BUTTON                = 'Button';
  DUI_CTR_OPTION                = 'Option';
  DUI_CTR_SLIDER                = 'Slider';

  DUI_CTR_CONTROL               = 'Control';
  DUI_CTR_ACTIVEX               = 'ActiveX';
  DUI_CTR_GIFANIM               = 'GifAnim';

  DUI_CTR_LISTITEM              = 'ListItem';
  DUI_CTR_PROGRESS              = 'Progress';
  DUI_CTR_RICHEDIT              = 'RichEdit';
  DUI_CTR_CHECKBOX              = 'CheckBox';
  DUI_CTR_COMBOBOX              = 'ComboBox';
  DUI_CTR_DATETIME              = 'DateTime';
  DUI_CTR_TREEVIEW              = 'TreeView';
  DUI_CTR_TREENODE              = 'TreeNode';

  DUI_CTR_CONTAINER             = 'Container';
  DUI_CTR_TABLAYOUT             = 'TabLayout';
  DUI_CTR_SCROLLBAR             = 'ScrollBar';

  DUI_CTR_LISTHEADER            = 'ListHeader';
  DUI_CTR_TILELAYOUT            = 'TileLayout';
  DUI_CTR_WEBBROWSER            = 'WebBrowser';

  DUI_CTR_CHILDLAYOUT           = 'ChildLayout';
  DUI_CTR_LISTELEMENT           = 'ListElement';

  DUI_CTR_DIALOGLAYOUT          = 'DialogLayout';

  DUI_CTR_VERTICALLAYOUT        = 'VerticalLayout';
  DUI_CTR_LISTHEADERITEM        = 'ListHeaderItem';

  DUI_CTR_LISTTEXTELEMENT       = 'ListTextElement';

  DUI_CTR_HORIZONTALLAYOUT      = 'HorizontalLayout';
  DUI_CTR_LISTLABELELEMENT      = 'ListLabelElement';

  DUI_CTR_LISTCONTAINERELEMENT  = 'ListContainerElement';
  DUI_CTR_LISTCONTAINERELEMENT_UI = 'ListContainerElementUI';

  DUI_CTR_MENU_UI = 'MenuUI';
  DUI_CTR_MENU = 'Menu';

  DUI_CTR_MENUELEMENT_UI = 'MenuElementUI';
  DUI_CTR_MENUELEMENT = 'MenuElement';

implementation

end.
