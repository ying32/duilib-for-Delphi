var g_vs = null;
var g_isIE = false;
var g_isFF = false;
var g_vsKey = "";
var g_vsModules = new Array();
var vs_addModule = vs_addModuleImpl;
var g_vsInitCaller = null;
var g_vsAsyncInit = false;
var vs_reInit = vs_reInitImpl;

var VS_DATE = "yyyy-mm-dd";
var VS_TIME = "HH:MM:SS";
var VS_DATETIME = "yyyy-mm-dd HH:MM:SS";

var VS_TB_BLOCK ="block";
var VS_TR_BLOCK ="block";
var VS_TD_BLOCK ="block";

var VS_CUR_HAND ="hand";

var g_vs_canToggle = false;

function vs_init()
{
	if(!g_vsInitCaller && !g_vsAsyncInit)
	{
		if((g_isIE = vs_isIE(5)) || (g_isFF = vs_isFF(1.5)))
		{
			Date.prototype.format = vs_dt_format;
			String.prototype.trim = vs_str_trim;
			String.prototype.leftTrim = vs_str_leftTrim;
			String.prototype.rightTrim = vs_str_rightTrim;
			String.prototype.UTF8Length = vs_str_UTF8Length;
			String.prototype.BLength = vs_str_BLength;
			String.prototype.UTF8Trunc = vs_str_UTF8Trunc;
			String.prototype.BTrunc = vs_str_BTrunc;
			String.prototype.format = vs_str_format;
			
			if(typeof(Array.prototype.push) == "undefined")
			{
				Array.prototype.push = vs_ar_push;
				Array.prototype.pop = vs_ar_pop;
			}

			if(g_isIE)
			{
				vs_initIE();
			}
			else if(g_isFF)
			{
				vs_initFF();
			}

			document.body.className = "vsBody";

			g_vs = vs_createVideoSystem();
			if(g_vs)
			{
				g_vs.enableCM = false;
				g_vs.onload();
		
				if(g_vs.createLayout)
				{
					g_vs.layout = g_vs.createLayout();
					
					if(!g_vs.layout)
					{
						g_vs = null;
					}
				}

				if(g_vsAsyncInit)
				{
					g_vsInitCaller = arguments.callee.caller;
				}
			}
		}
		else
		{
			if(typeof(VS_BROWSERLOWVER) == "string")
			{
				alert(VS_BROWSERLOWVER);
			}
		}
	}
	else
	{
		g_vsInitCaller = null;
	}
	
	return g_vsInitCaller == null && g_vs != null;
}

function vs_reInitImpl()
{
	if(typeof(g_vsInitCaller) == "function")
	{
		g_vsInitCaller();
	}
}

function vs_addModuleImpl(func)
{
	if(typeof(func) == "function")
	{
		g_vsModules[g_vsModules.length] = func;
	}
}

function vs_registerModules(vs)
{
	var i;
	for(i = 0; i < g_vsModules.length; i++)
	{
		g_vsModules[i](vs);
	}
}

function vs_initIE()
{
	document.body.onbeforeunload = doc_onbeforeunload;
	document.body.oncontextmenu = doc_oncontextmenu;
	document.body.onkeydown = doc_onkeydown;
}

function vs_initFF()
{
	VS_TB_BLOCK ="table";
	VS_TR_BLOCK ="table-row";
	VS_TD_BLOCK ="table-cell";

	VS_CUR_HAND ="pointer";

	document.createElementOld = document.createElement;
	document.createElement = ff_doc_createElement;
	document.pushReSize = ff_doc_pushReSize;
	document.arrReSize = new Array();
	
	Window.prototype.__defineGetter__("event", ff_win_event);
	Event.prototype.__defineSetter__("cancelBubble", ff_ev_set_cancelBubble);
	KeyEvent.prototype.__defineSetter__("cancelBubble", ff_ev_set_cancelBubble);
	MouseEvent.prototype.__defineSetter__("cancelBubble", ff_ev_set_cancelBubble);

	HTMLElement.prototype.__defineGetter__("children", ff_el_children);
	HTMLElement.prototype.__defineGetter__("parentElement", ff_el_parentElement);
	HTMLElement.prototype.__defineGetter__("innerText", ff_el_get_innerText);
	HTMLElement.prototype.__defineSetter__("innerText", ff_el_set_innerText);
	
 	HTMLElement.prototype.removeNode = ff_el_removeNode;
 	HTMLElement.prototype.insertAdjacentHTML = ff_el_insertAdjacentHTML;
	HTMLElement.prototype.insertAdjacentElement = ff_el_insertAdjacentElement;

	HTMLBodyElement.prototype.__defineGetter__("onresize", ff_bd_get_onresize);
	HTMLBodyElement.prototype.__defineSetter__("onresize", ff_bd_set_onresize);
	HTMLBodyElement.prototype.__defineGetter__("onscroll", ff_bd_get_onscroll);
	HTMLBodyElement.prototype.__defineSetter__("onscroll", ff_bd_set_onscroll);
	HTMLBodyElement.prototype.__defineGetter__("onunload", ff_bd_get_onunload);
	HTMLBodyElement.prototype.__defineSetter__("onunload", ff_bd_set_onunload);

	HTMLTableElement.prototype.insertRowOld = HTMLTableElement.prototype.insertRow;
	HTMLTableElement.prototype.insertRow = ff_tb_insertRow;
	HTMLTableRowElement.prototype.insertCellOld = HTMLTableRowElement.prototype.insertCell;
	HTMLTableRowElement.prototype.insertCell = ff_row_insertCell;

	HTMLDivElement.prototype.__defineGetter__("filters", ff_div_get_filters);
 	HTMLDivElement.prototype.setCapture = ff_div_setCapture;
 	HTMLDivElement.prototype.releaseCapture = ff_div_releaseCapture;

 	HTMLAnchorElement.prototype.click = ff_link_click;
	
	window.fireEvent = ff_win_fireEvent;
	
	window.onbeforeunload = doc_onbeforeunload;
	window.oncontextmenu = doc_oncontextmenu;
	window.onkeydown = doc_onkeydown;
	
	window.clipboardData = new Object();
	window.clipboardData.setData = ff_cb_setData;

	window.setTimeout("ff_resizeAll();", 200);
}

function ff_cb_enablePrivilege()
{
	var b = false;
	try
	{
		netscape.security.PrivilegeManager.enablePrivilege("UniversalXPConnect");
		b = true;
	}
	catch(e)
	{
	}
	
	return b;
}

function ff_cb_setData(type, data)
{
	var b = false;
	var clip;
	var trans;
	var strObj;
	var clipID;

	try
	{
		netscape.security.PrivilegeManager.enablePrivilege("UniversalXPConnect");
		b = true;
	}
	catch(e)
	{
	}

	type = type.toLowerCase();
	if(type == "text" && b)
	{
		b = false;
		
		clip = Components.classes["@mozilla.org/widget/clipboard;1"].createInstance(Components.interfaces.nsIClipboard);
		trans = Components.classes["@mozilla.org/widget/transferable;1"].createInstance(Components.interfaces.nsITransferable);
		strObj = Components.classes["@mozilla.org/supports-string;1"].createInstance(Components.interfaces.nsISupportsString);
		clipID = Components.interfaces.nsIClipboard;

		if(clip && trans && strObj && clipID)
		{
			trans.addDataFlavor("text/unicode");
			strObj.data = data;
			trans.setTransferData("text/unicode", strObj, data.length * 2);

			clip.setData(trans, null, clipID.kGlobalClipboard);
			b = true;
		}
	}

	return b;
}

function ff_win_fireEvent(name, el)
{
	var e = document.createEvent("Event");
	var ME_CMD = 'if(e && el && typeof(el.?) == "function"){e.initEvent("?", false, false);e.srcElement = el;el.?(e);}';
	var cmd = ME_CMD.format(name, name, name);
	eval(cmd);
}

function ff_win_event()
{
	var caller = arguments.callee.caller;
	var e;

	while(caller)
	{
		e = caller.arguments[0];
		
		if(e && (e.constructor == MouseEvent || e.constructor == KeyboardEvent || e.constructor == Event))
		{
			if(!e.srcElement)
			{
				e.srcElement = e.target;
			}
			
			break;
		}
		else
		{
			e = new Object();
			caller = caller.caller;
		}
	}

	return e;
}

function ff_ev_set_cancelBubble()
{
	this.stopPropagation = arguments[0];
}

function ff_resizeAll()
{
	var el;
	var els = document.arrReSize;
	var i;
	
	for(i = 0; i < els.length; i++)
	{
		el = els[i];

		if(el.count < 1 || (el.lastOffsetWidth != el.offsetWidth || el.lastOffsetHeight != el.offsetHeight))
		{
			window.fireEvent("onresize", el);

			if(el.count == 1)
			{
				el.lastOffsetWidth = el.offsetWidth;
				el.lastOffsetHeight = el.offsetHeight;
				el.count = 0;
			}
			else
			{
				el.count++;
			}
		}
	}
	
	window.setTimeout("ff_resizeAll();", 200);
}

function ff_bd_get_onscroll()
{
	return window.onscroll;
}

function ff_bd_set_onscroll()
{
	window.onscroll = arguments[0];
}

function ff_bd_get_onunload()
{
	return window.onunload;
}

function ff_bd_set_onunload()
{
	window.onunload = arguments[0];
}

function ff_bd_get_onresize()
{
	return window.onresize;
}

function ff_bd_set_onresize()
{
	window.onresize = arguments[0];
}

function ff_el_get_innerText()
{
	return this.textContent;
}

function ff_el_set_innerText()
{
	this.textContent = arguments[0];
}

function ff_doc_pushReSize(el)
{
	el.count = 0;
	document.arrReSize.push(el);
}

function ff_doc_createElement(s)
{
	var div;
	var el;
	
	if(s.length > 0 && s.charAt(0) == '<')
	{
		div = document.createElementOld("div");
		div.innerHTML = s;
		el = div.childNodes[0];
		div.removeChild(el);
		
		if(typeof(el.onresize) == "function")
		{
			document.pushReSize(el);
		}
	}
	else
	{
		el = document.createElementOld(s);
	}

	return el;
}

function ff_el_removeNode()
{
	var par = this.parentNode;
	
	if(par)
	{
		par.removeChild(this);
	}
	
	return this;
}

function ff_el_insertAdjacentHTML(pos, html)
{
	var div;
	var els;
	
	var s = "";
	var v;
	
	div = document.createElementOld("div");
	div.innerHTML = html;
	els = div.childNodes;

	if(els)
	{
		this.insertAdjacentElement(pos, els);
	}
}

function ff_el_insertAdjacentElement(pos, el)
{
	var pre = null;
	var par = this;
	
	switch(pos)
	{
		case "beforeBegin":
			par = this.parentNode;
			pre = this;
			break;
		case "afterBegin":
			par = this;
			pre = par.firstChild;
			break;
		case "beforeEnd":
			par = this;
			break;
		case "afterEnd":
			par = this.parentNode;
			pre = this.nextSibling;
			break;
		default:;
			break;
	}
	
	if(par)
	{	
		if(pre)
		{
			if(el.length > 0)
			{
				while(el.length > 0)
				{
					par.insertBefore(el[0], pre);
				}
			}
			else
			{
				par.insertBefore(el, pre);
			}
		}
		else
		{
			if(el.length > 0)
			{
				while(el.length > 0)
				{
					par.appendChild(el[0]);
				}
			}
			else
			{
				par.appendChild(el);
			}
		}
	}
}

function ff_div_ft_apply()
{
}

function ff_div_ft_play()
{
}

function ff_div_get_filters()
{
	var arr = new Array();
	var obj = new Object();
	
	if(arr && obj)
	{
		arr[0] = obj;
		obj.Apply = ff_div_ft_apply;
		obj.apply = ff_div_ft_apply;
		obj.Play = ff_div_ft_play;
		obj.play = ff_div_ft_play;
	}
	
	return arr;
}

function ff_div_setCapture()
{
	if(window.curCap != this)
	{
		ff_el_onlosecapture();
		window.curCap = this;
	}
}

function ff_div_releaseCapture()
{
	window.curCap = null;
}

function ff_el_onlosecapture()
{
	var el = window.curCap;
	window.fireEvent("onlosecapture", el);
}

function ff_link_click()
{
	if(typeof(this.onclick) == "function")
	{
		this.onclick();
	}
	else if(this.href != "")
	{
		window.location.href = this.href;
	}
}

function ff_el_children()
{
	var nodes = new Array();
	var i;

	for(i = 0; i < this.childNodes.length; i++)
	{
		if(this.childNodes[i].nodeType == 1)
		{
			nodes.push(this.childNodes[i]);
		}
	}

	return nodes;
}

function ff_el_parentElement()
{
	return this.parentNode;
}

function ff_tb_insertRow(i)
{
	if(typeof(i) == "undefined")
	{
		i = this.rows.length;
	}

	return this.insertRowOld(i);
}

function ff_row_insertCell(i)
{
	if(typeof(i) == "undefined")
	{
		i = this.cells.length;
	}

	return this.insertCellOld(i);
}

function doc_oncontextmenu()
{
	var b = false;
	var el;
	
	if(g_vs)
	{
		b = g_vs.enableCM;
	} 
	
	if(b && g_isFF)
	{
		el = event.srcElement;
		if(el && typeof(el.oncontextmenu) == "function")
		{
			el.oncontextmenu();
		}
	}
	
	return b;
}

function doc_onkeydown()
{
	var ch = String.fromCharCode(event.keyCode);

	if(g_vs && !g_vs.enableCM)
	{
		if(g_vsKey.length < 9)
		{
			if(ch >= 'A' && ch <= 'Z')
			{
				g_vsKey += ch;
				
				if(g_vsKey == "DAKAIMENU")
				{
					g_vs.enableCM = true;
				}
			}
			else
			{
				g_vsKey = "7204857389";
			}
		}
		
		if(event.shiftKey && event.altKey && event.ctrlKey)
		{
			g_vsKey = "";
		}
	}
	
	return true;
}

function doc_onbeforeunload()
{
	if(g_vs)
	{
		g_vs.onunload();
	}
}

function vs_dt_format(fmt)
{
	var s = fmt.replace(/yyyy/g, this.getFullYear());
	s = s.replace(/mm/g, vs_dt_toString(this.getMonth() + 1));
	s = s.replace(/m/g, this.getMonth() + 1);
	s = s.replace(/dd/g, vs_dt_toString(this.getDate()));
	s = s.replace(/d/g, this.getDate());
	s = s.replace(/HH/g, vs_dt_toString(this.getHours()));
	s = s.replace(/MM/g, vs_dt_toString(this.getMinutes()));
	s = s.replace(/SS/g, vs_dt_toString(this.getSeconds()));
	
	return s;
}

function vs_dt_toString(n)
{
	var s;
	
	if(n < 10)
	{
		s = "0" + n;
	}
	else
	{
		s = n;
	}
	
	return s;
}

function vs_str_trim(cs)
{
	return this.leftTrim(cs).rightTrim(cs);
}

function vs_str_leftTrim(cs)
{
	var len = this.length;
	var i = 0;
	
	if(typeof(cs) != "string")
	{
		cs = " ";
	}
	
	while(i < len)
	{
		if(cs.indexOf(this.charAt(i)) < 0)
		{
			break;
		}
		
		i++;
	}

	if(i <= len)
	{
		s = this.substr(i);
	}
	else
	{
		s = this;
	}

	return s;
}

function vs_str_rightTrim(cs)
{
	var s;
	var len = this.length;
	var i = len - 1;
	
	if(typeof(cs) != "string")
	{
		cs = " ";
	}
	
	while(i >= 0)
	{
		if(cs.indexOf(this.charAt(i)) < 0)
		{
			break;
		}
		
		i--;
	}
	
	if(i >= -1)
	{
		s = this.substr(0, i + 1);
	}
	else
	{
		s = this;
	}

	return s;
}

function vs_str_UTF8Length(maxlen)
{
	var i;
	var len = 0;
	var s = this;
	var ch;
	
	for(i = 0; i < s.length; i++)
	{
		ch = s.charAt(i);
		
		if(ch < String.fromCharCode(0x80))
		{
			len++;
		}
		else if(ch < String.fromCharCode(0x800))
		{
			len += 2;
		}
		else
		{
			len += 3;
		}
		
		if(maxlen)
		{
			if(len > maxlen)
			{
				len = i;
				break;
			}
		}
	}
	
	if(maxlen)
	{
		len = Math.min(i, len);
	}

	return len;
}

function vs_str_UTF8Trunc(maxlen)
{
	var s = this;
	var i = s.UTF8Length(maxlen);

	if(i >= 0)
	{
		s = s.substr(0, i);
	}
	
	return s;
}

function vs_str_BLength(maxlen)
{
	var i;
	var len = 0;
	var s = this;
	var ch;
	
	for(i = 0; i < s.length; i++)
	{
		ch = s.charAt(i);
		
		if(ch < String.fromCharCode(0x100))
		{
			len++;
		}
		else
		{
			len += 2;
		}

		if(maxlen)
		{
			if(len > maxlen)
			{
				len = i;
				break;
			}
		}
	}
	
	if(maxlen)
	{
		len = Math.min(i, len);
	}

	return len;
}

function vs_str_BTrunc(maxlen)
{
	var s = this;
	var i = s.BLength(maxlen);

	if(i >= 0)
	{
		s = s.substr(0, i);
	}
	
	return s;
}

function vs_str_format()
{
	var ar = this.split("?");
	var i;
	var s = "";
	var t;
	
	for(i = 0; i < ar.length; i++)
	{
		if(i < arguments.length && i != (ar.length - 1))
		{
			t = arguments[i];
		}
		else
		{
			t = "";
		}

		s += ar[i] + t;
	}
	
	return s;
}

function vs_ar_push(v)
{
	this[this.length] = v;
	
	return this.length;
}

function vs_ar_pop()
{
	var v;

	if(this.length > 0)
	{
		v = this[this.length - 1];
		this.length--;
	}

	return v;
}

// VideoSystem
function vs_createVideoSystem()
{
	var vs = new Object();
	
	if(vs)
	{
		// method
		vs.isIE = vs_isIE;
		vs.isFF = vs_isFF;
		vs.addCSS = vs_addCSS;
		vs.genUID = vs_genUID;
		vs.encode = vs_encode;
		vs.decode = vs_decode;
		vs.crlf2BR = vs_crlf2BR;
		vs.getValue = vs_getValue;
		vs.addScript = vs_addScript;
		vs.encodeURI = vs_encodeURI;
		vs.decodeURI = vs_decodeURI;
		vs.showError = vs_showError;
		vs.fireEvent = vs_fireEvent;
		vs.addGarbage = vs_addGarbage;
		vs.attachEvent = vs_attachEvent;
		vs.detachEvent = vs_detachEvent;
		vs.moveElement = vs_moveElement;
		vs.getSafeHTML = vs_getSafeHTML;
		vs.parseParams = vs_parseParams;
		vs.clearObject = vs_clearObject;
		vs.isPointInRect = vs_isPointInRect;
		vs.getLastzIndex = vs_getLastzIndex;
		vs.addScriptEvent = vs_addScriptEvent;
		vs.encodeURLValue = vs_encodeURLValue;
		vs.decodeURLValue = vs_decodeURLValue;
		vs.getElementOffset = vs_getElementOffset;
		vs.isAnyLevelParent = vs_isAnyLevelParent;
		vs.isPointAboveElement = vs_isPointAboveElement;
		vs.bringElementToFront = vs_bringElementToFront;
		vs.removeElementFromParent = vs_removeElementFromParent;
		
		// attribute
		vs.lastUID = 1;
		vs.lastzIndex = 1000;
		vs.pageName = vs_getPageName();
		vs.parseParams();

		vs.objects = new Array();
		vs.data = new Array();
		vs.events = new Array();
		vs.garbages = new Array();

		// event
		vs.onload = vs_onload;
		vs.onunload = vs_onunload;
		vs.onsavedata = null;
		
		if(vs.params && vs.onload && vs.onunload && vs.objects && vs.data && vs.events)
		{
			vs_clearGarbage();
			vs_registerModules(vs);
		}
		else
		{
			vs = null;
		}
	}
	
	return vs;
}

function vs_clearObject(obj)
{
	var v;

	for(v in obj)
	{
		try
		{
			if(typeof(obj[v]) == "object")
			{
				obj[v] = null;
			}
		}
		catch(e)
		{
		}
	}
}

function vs_addGarbage(obj)
{
	this.garbages.push(obj);
}

function vs_clearGarbage()
{
	var garbages = g_vs ? g_vs.garbages : null;
	var obj;
	var i;
	
	if(garbages)
	{
		for(i = 0; i < garbages.length; i++)
		{
			obj = garbages[i];
			garbages[i] = null;

			delete obj;
		}
		
		if(garbages.length > 0)
		{
			g_vs.garbages = new Array();
		}
	}
	
	window.setTimeout("vs_clearGarbage();", 1000);
}

function vs_attachEvent(eid, func)
{
	var result = false;
	
	if(!this.events[eid])
	{
		this.events[eid] = new Array();
	}
	
	if(this.events[eid])
	{
		this.events[eid].push(func);
	}
	
	return result;
}

function vs_detachEvent(eid, func)
{
	var evts = this.events[eid];
	var i;
	
	if(evts)
	{
		for(i = 0; i < evts.length; i++)
		{
			if(evts[i] == func)
			{
				evts[i] = null;
				break;
			}
		}
	}
}

function vs_fireEvent(eid, e)
{
	var evts = this.events[eid];
	var i;
	
	if(evts)
	{
		for(i = 0; i < evts.length; i++)
		{
			if(typeof(evts[i]) == "function")
			{
				evts[i](e);
			}
		}
	}
}

function vs_getPageName()
{
	var s = window.location.pathname;
	var i = s.lastIndexOf("/");

	if(i >= 0)
	{
		s = s.substr(i + 1);
	}
	else
	{
		s = "";
	}
	
	return s;
}

function vs_parseParams()
{
	var params = new Object();
	var s = window.location.search;
	var vArr;
	var i;
	var nameValue;
	
	if(params && typeof(s) == "string")
	{
		s = s.substr(1);
		vArr = s.split("&");
		
		if(vArr)
		{
			for(i = 0; i < vArr.length; i++)
			{
				if(typeof(vArr[i]) == "string")
				{
					nameValue = vArr[i].split("=");
					if(nameValue.length > 1)
					{
						params[nameValue[0]] = this.decodeURLValue(nameValue[1]);
					}
					else
					{
						params[nameValue[0]] = "";
					}
				}
			}
		}
	}
	
	this.params = params;
	
	return params;
}

function vs_onload()
{
}

function vs_onunload()
{
	if(typeof(this.onsavedata) == "function")
	{
		this.onsavedata();
	}
}

function vs_moveElement(el, left, top)
{
	if(typeof(left) == "number")
	{
		el.style.left = left + "px";
	}
	
	if(typeof(top) == "number")
	{
		el.style.top = top + "px";
	}
}

function vs_bringElementToFront(el)
{
	el.style.zIndex = this.getLastzIndex();
}

function vs_isAnyLevelParent(el, par)
{
	while(el)
	{
		if(el == par)
		{
			break;
		}
		
		el = el.parentElement;
	}
	
	return (el == par);
}

function vs_getElementOffset(el)
{
	var obj = el;
	var offset = new Object();
	var x = 0;
	var y = 0;

	while(obj && obj.tagName != "BODY")
	{
		x += obj.offsetLeft - obj.scrollLeft;
		y += obj.offsetTop - obj.scrollTop;

		obj = obj.offsetParent;
	}

	offset.x = x;
	offset.y = y;

	return offset;
}

function vs_getLastzIndex()
{
	return this.lastzIndex++;
}

function vs_genUID()
{
	return "vsEl" + this.lastUID++;
}

// IE Version
function vs_isIE(ver, exact)
{
	var b = false;
	var v;
	var agt = navigator.userAgent.toLowerCase();
	var i = agt.indexOf("msie ");

	if(!ver)
	{
		ver = 5;
	}
	
	if(i >= 0)
	{
		v = parseFloat(agt.substring(i + 5));

		if(!isNaN(v))
		{
			if(exact)
			{
				b = (v == ver);
			}
			else
			{
				b = (v >= ver);
			}
		}
	}

	return b;
}

function vs_isFF(ver, exact)
{
	var b = false;
	var v;
	var agt = navigator.userAgent.toLowerCase();
	var i = agt.indexOf("firefox/");

	if(!ver)
	{
		ver = 2;
	}
	
	if(i >= 0)
	{
		v = parseFloat(agt.substring(i + 8));

		if(!isNaN(v))
		{
			if(exact)
			{
				b = (v == ver);
			}
			else
			{
				b = (v >= ver);
			}
		}
	}

	return b;
}

function vs_getValue(node, name)
{
	var value = "";
	var n = node.selectSingleNode(name);
	
	if(n)
	{
		value = n.text;
	}
	
	return value;
}

function vs_showError(s)
{
	return alert(s);
}

function vs_encode(s)
{
	return s.replace(/&/g, "&&");
}

function vs_decode(s)
{
	return s;
}

function vs_encodeURLValue(s)
{
	return this.encodeURI(s).replace(/&/g, "%26").replace(/=/g, "%3D");
}

function vs_decodeURLValue(s)
{
	if(typeof(s) != "string")
	{
		s = "";
	}
	
	return this.decodeURI(s.replace(/%3D/g, "=").replace(/%26/g, "&"));
}

function vs_crlf2BR(s)
{
	return s.replace(/\r/g, "").replace(/\n/g, "<BR>");
}

function vs_encodeURI(s)
{
	var v;
	
	if(typeof(encodeURI) != "undefined")
	{
		v = encodeURI(s);
	}
	else
	{
		v = escape(s);
	}
	
	return v;
}

function vs_decodeURI(s)
{
	var v;
	
	if(typeof(encodeURI) != "undefined")
	{
		v = decodeURI(s);
	}
	else
	{
		v = unescape(s);
	}
	
	return v;
}

function vs_getSafeHTML(s)
{
	var html = "";
	var safeNode = g_vs.safeNode;
	
	if(!safeNode)
	{
		safeNode = document.createElement("TEXTAREA");
	}

	if(safeNode)
	{
		safeNode.innerText = s;
		html = safeNode.innerHTML;
		safeNode.innerText = "";
		
		g_vs.safeNode = safeNode;
	}
	
	return html;
}

function vs_addScript(url, script, lang)
{
	var scr = document.createElement("SCRIPT");
	if(scr)
	{
		if(!lang)
		{
			lang = "javascript";
		}
		
		scr.language = lang;
		
		if(url)
		{
			scr.src = url;
		}
		
		if(script)
		{
			scr.text = script;
		}
		
		document.body.appendChild(scr);
	}

	return scr;
}

function vs_addScriptEvent(evnt, htmlFor, script, lang)
{
	var scr = document.createElement("SCRIPT");
	if(scr)
	{
		if(!lang)
		{
			lang = "javascript";
		}
		
		scr.language = lang;
		
		if(evnt)
		{
			scr.event = evnt;
		}
		
		scr.htmlFor = htmlFor;
		scr.text = script;

		document.body.appendChild(scr);
	}
	
	return scr;
}

function vs_addCSS(css)
{
	var o = document.createStyleSheet();
	o.cssText = css;
}

function vs_isPointAboveElement(x, y, el)
{
	var result = 0;
	var offset = this.getElementOffset(el);
	var width = el.offsetWidth;
	var height = el.offsetHeight;

	if(this.isPointInRect(x, y, offset.x + el.scrollLeft, offset.y  + el.scrollTop, width, height))
	{
		if(y <= (offset.y + height / 2))
		{
			result = 1;
		}
		
		else
		{
			result = 2;
		}
	}

	return result;
}

function vs_isPointInRect(x, y, left, top, width, height)
{
	return (x >= left && x < (left + width))
			&& (y >= top && y < (top + height));
}

function vs_removeElementFromParent(el)
{
	var par = el.parentElement;
	
	if(par)
	{
		par.removeChild(el);
	}
}
