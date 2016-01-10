// JavaScript Document
var g_subPageInfoArray = new Object;
var g_windowHelper = new windowHelper();

function vs_layoutCallBack(layout)
{
	var desktop=document.getElementById("vsDesktop");
	var table=document.createElement("<table border=0 cellspacing=0 cellpadding=0 class=fill></table>");
	var row,cell;
	if(desktop&&table)
	{
		desktop.style.paddingTop=VS_PAD;
		row=table.insertRow();
		if(row)
		{
			row.align="center";
			row.vAlign="top";
			
			cell=row.insertCell();
			if(cell)
			{
			     cell.style.width='500px';
				 cell.layoutIndex=0;
				 cell.style.paddingTop="0px";
				 cell.style.paddingLeft="2px";
				 cell.style.paddingRight="2px";
		         layout.items[0]=cell;
			}
		}
		layout.canDrag=true;
		layout.dragCross=false;
		
		desktop.appendChild(table);
	}
}

function win_onload()
{
	if(vs_init())
	{
      g_windowHelper.canAlert(false);
      //alert("loading");
	    createTraceWin();
	    g_vs.onsavedata = SaveConfigInfo;
	    var desktop=document.getElementById("vsDesktop");
	    desktop.oncontextmenu = my_oncontextmenu;
	    
		g_windowHelper.requestIFrames();
    	mytest_CreateWindows();
	
		mytest_loadAsync();	
	} 
}

function mytest_showDefaultPageIfNeed(subPageInfoArray)//需要显示的时候显示
{   
        var bHideAll = true;
        for(var name in subPageInfoArray)
        {
            var subPageInfo = subPageInfoArray[name];
            if(subPageInfo)
            {      
                if(subPageInfo.visible)
                {
                    bHideAll = false;
                    break;
                }    
            }
        }
        
        if(bHideAll)
        {
            var wintop = mytest_help_getTopestWin();
            if(wintop)
            {
                wintop.div.insertAdjacentElement("beforeBegin", g_vs.defaultPage); 
                g_vs.defaultPage.style.display = "block";       
            } 
        }  
}

function mytest_CreateWindows()
{
//第一次加载读取配置文件，之后更新页面内容
    g_subPageInfoArray = mytest_sortPageInfoArray(g_subPageInfoArray, false);
    
    for(var name in g_subPageInfoArray)
    {
        var subPageInfo = g_subPageInfoArray[name];
        
	    if(subPageInfo)
	    {
	        var id = subPageInfo.iframeID;
	        var functionName = "mytest_initWindows('" + id + "');";
	        g_vs.createWindow(id,functionName,VS_PAGE_LOADING,0,0,0,"100%","100px",subPageInfo.visible,"",subPageInfo.toggle,false,true);
	    } 
    }
    
    if(!g_vs.defaultPage)
    {
             g_vs.createDefaultPage();                        
             g_vs.defaultPage.style.display = "none"; 
    }
    mytest_showDefaultPageIfNeed(g_subPageInfoArray);
}


function mytest_createSubPage(iframeID, iframeName, iframeUrl, visible, ypoint, toggle)
{
    if(g_subPageInfoArray == null)
    {
        g_subPageInfoArray = new Object;
    }
    
   if(g_subPageInfoArray[iframeID] == null)
   {
      var subPageInfo = new Object;
      subPageInfo.iframeID = iframeID;
      subPageInfo.iframeName = iframeName;
      subPageInfo.iframeUrl = iframeUrl;
      if(visible == 0)
      {
            subPageInfo.visible = false;
      }
      else
      {
            subPageInfo.visible = true;
      }
      

      subPageInfo.ypoint = parseInt(ypoint);//这里可能转换失败，我们认为ypoint值为非数字的放在最前面；
      
      if(toggle == 0)
      { 
             subPageInfo.toggle = false; 
      }
      else
      {
            if(g_vs_canToggle)
                subPageInfo.toggle = true;
            else
                subPageInfo.toggle = false;
      }
     
      g_subPageInfoArray[iframeID] = subPageInfo;
 }
}


function mytest_initWindows(iframeId)
{
     g_windowHelper.canAlert(false);
      //alert("loading");

  var win = g_vs.windows[iframeId];
	if(win)
	{
		win.changeIcon();
		win.setContextMenu(my_oncontextmenu);
        //var s = "<IFrame width='100%' height='100%' SCROLLING='no' src='" + g_subPageInfoArray[id].iframeUrl + "' id='" + id + "' onreadystatechange='loads(" + id + ");'></IFrame>";
		var s = "<IFrame width='100%' height='100%' style='display:none' SCROLLING='no' src='" + g_subPageInfoArray[iframeId].iframeUrl + "' id='" + iframeId + "Frame' onreadystatechange='loads();'></IFrame>";
		var d = "<div id='" + iframeId +  "LoadDiv' style='display:block' class='loadText'>" + VS_PAGE_LOADING+ "</div>"; 
		
		win.setClientHTML(s + d);
	
	    var iframe = null;;
	    
    	var iframeid = win.id+ "Frame";
		iframe = document.getElementById(iframeid);
		win.iframe = iframe;
		iframe.win = iframe;
		
		g_windowHelper.toggleIFrame(win.id, win.toggle);
	}
}

function loads()
{
   var win = g_vs.getWindowFromElement(event.srcElement);
   var iframeid = win.id+ "Frame";
   var divid = win.id + "LoadDiv";
   var iframe = document.getElementById(iframeid);
   var iframeloadDiv = document.getElementById(divid);
 
   if(iframe.readyState=="complete")
   {
       if(iframeloadDiv.style.display == "block")
       {
            iframeloadDiv.style.display = "none";
            iframe.style.display = "block";
        
        	   var bAllOver = true;
        		 for(var name in g_subPageInfoArray)
        		 {   
        			  var iframeTest = document.getElementById(name + "Frame");
	            	if(iframeTest.readyState != "complete")
	            	{
	            			bAllOver = false;
	            	}
	           }
	           
	           if(bAllOver)
	           {
	           	g_windowHelper.canAlert(true);
	           	//alert("load finish");
	           }
            if(win.caption.innerHTML == VS_PAGE_LOADING)
            {
                win.setCaption("");
            }
       }   
   }
   else if(iframe.readyState == "loading")
   {   
       if(iframe.style.display == "block")
       {
            iframe.style.display = "none";
            g_windowHelper.canAlert(false);
            //alert("loading");
            iframeloadDiv.style.offsetHeight = iframe.currentStyle.offsetHeight;
            iframeloadDiv.style.display = "block";
       }   
   }   
}

function mytest_loadAsync()
{
	
}

function folder_onxmlloaded(xmlObj)
{
	if(xmlObj == null)
	{
		return;
	}
	var win = g_vs.windows['folder'];
	var undefined,nt;
	var s="";
	var i;
	var div;
	var nodes;
	
	//undefined = xmlObj.selectNodes("//root/unfinished");
	//nt = g_vs.getValue(undefined,"nt");
	nodes = xmlObj.selectNodes("//root/unfinished/ca");
	if(nodes.length)
	{
		div=document.createElement("DIV");
		s = "unfinished cases("+ nodes.length +")\n";
		for(i=0; i<nodes.length;i++)
		{
			s+="<BR>&nbsp;&nbsp;&nbsp;"+ i +".&nbsp;" + g_vs.getValue(nodes[i],"n");
		}
		s+="\n";
		div.innerHTML=s;
		win.client.appendChild(div);
	}
	
	var finished_nodes;
	//finished = xmlObj.selectNodes("//root/finished");
	//nt = g_vs.getValue(finished, "nt");
	finished_nodes = xmlObj.selectNodes("//root/finished/ca");
	if(finished_nodes.length)
	{
		div=document.createElement("DIV");
		s = "finished cases("+ finished_nodes.length +")\n";
		for(i=0; i<finished_nodes.length;i++)
		{
			s+="<BR>&nbsp;&nbsp;&nbsp;"+ i +".&nbsp;" + g_vs.getValue(finished_nodes[i],"n");
		}
		s+="\n";
		div.innerHTML=s;
		win.client.appendChild(div);
	}
	
	var postponed_nodes;
	//finished = xmlObj.selectNodes("//root/postponed");
	//nt = g_vs.getValue(finished, "nt");
	postponed_nodes = xmlObj.selectNodes("//root/postponed/ca");
	if(postponed_nodes.length)
	{
		div=document.createElement("DIV");
		s = "postponed cases("+ postponed_nodes.length +")\n";
		for(i=0; i<postponed_nodes.length;i++)
		{
			s+="<BR>&nbsp;&nbsp;&nbsp;"+ i +".&nbsp;" + g_vs.getValue(postponed_nodes[i],"n");
		}
		s+="\n";
		div.innerHTML=s;
		win.client.appendChild(div);
	}
}


function case_onxmlloaded(xmlObj)
{
	if(xmlObj == null)
	{
		return;
	}
	var win = g_vs.windows['case'];
	var nodes=xmlObj.selectNodes("//root/ca");
	var s="";
	var i;
	var row,cell;
	var table = document.createElement('<table border=1 cellspacing=0 cellpadding=0 width="100%"></table>');
	
	win.client.innerHTML="";
	win.client.appendChild(table);
	
	if(table)
	{
		row=table.insertRow();
		
		cell=row.insertCell();
		if(cell)
		{
			cell.style.width="20%";
			cell.align="center";
			cell.innerText="UIN";
		}
		cell=row.insertCell();
		if(cell)
		{
			cell.style.width="60%";
			cell.align="center";
			cell.innerText="CASE";
		}
		
		cell=row.insertCell();
		if(cell)
		{
			cell.style.width="20%";
			cell.align="center";
			cell.innerText="TIME";
		}
	}
	
	var index;
	var node;
	for(index=0; index<nodes.length; index++)
	{
		node = nodes[index];		
		showOneCase(table,node);
	}
}

function showOneCase(table, node)
{
	var row, cell;
	
	if(table&&node)
	{
		row=table.insertRow();
		row.style.height="15px";
		cell=row.insertCell();
		if(cell)
		{
			cell.align="center";
			//var tmp1 = document.createElement("A");
			//tmp1.innerHTML=g_vs.getValue(node,"u");
			//tmp1.href= "onmouseover='showcaseinfo(" + g_vs.getValue(node,"x"); + ")>'";
			//cell.appendChild(tmp1);
			var x=g_vs.getValue(node,"x");
			var u=g_vs.getValue(node,"u");
			cell.innerHTML='<a href="" onmouseover="showcaseinfo(' + x + ');">' + u + '</a>';
		}
		cell=row.insertCell();
		if(cell)
		{
			cell.align="center";
			var tmp = document.createElement("A");
			tmp.innerHTML=g_vs.getValue(node,"c");
			tmp.href="/cgi-bin/getcase?id="+g_vs.getValue(node,"x");
			cell.appendChild(tmp);
		}
		cell=row.insertCell();
		if(cell)
		{
			cell.align="center";
			cell.innerText=g_vs.getValue(node,"t");
		}
	}
}

function showcaseinfo(caseid)
{
	var el = event.srcElement;
	var tip = el.tipObject;
	//var data = "<br><a href='' target='_blank'>" + caseid + "</a><br>";
	var data = "<br>"+caseid+"</br>";
	if(!tip)
	{
		tip = g_vs.createTip(data, "200px", "");
	}
	
	if(tip)
	{
		el.tipObject = tip;
		tip.show();
	}
}

function showChatArea()
{
	var win = g_vs.windows['chat'];
	if(win)
	{
		var vb_bbs = bbs_createBBS();
		win.client.appendChild(vb_bbs.div);
		//cell.appendChild(gi_bbs.div);
		//table.style.position = "relative";
		//table.style.left = "5px";
		vb_bbs.setWidth("99%");	
		//win.setBottom("<a href='/cgi-bin/sendmsg'>Send</a>");
		win.changeIcon();
	}
}

function bbs_createBBS()
{
	var bbs = new Object();
	var div;
	var elem;
	var table;
	var str="";
	var tmp;
	var cdiv;
	var btn;
	var img;
	var imgurl;
	var tb;
	var lk;
	var pt;
	var pr;
	var pc;
	var sp;
	var e;
	var i;
	var upIfram,updiv;
	
	div = document.createElement('<div width="100%" >'); 
	if(bbs&&div)
	{	
		div.bbs = bbs;
		div.className = "bbsDiv";
		//bbs.vbbs=vbbs;

		elem = document.createElement('<div>'); 
		e = document.createElement('<div class=Preview>'); 
		if(elem&&e)
		{
			bbs.previewResult = elem;
			div.appendChild(elem);
			
			bbs.previewTable = e;
			div.appendChild(e);
		}		
		table = document.createElement('<TABLE align="center" vAlign="top" cellSpacing=0 cellPadding=0 width="100%" align=center border=0></table>');
		if(table)
		{
			div.appendChild(table);
			row = table.insertRow();
			if(row)
			{
				cell = row.insertCell();
				if(cell)
				{
					//cell.colSpan=3;
					cell.style.width="100%";
					texta = document.createElement("<TEXTAREA style='border:1px solid #92a3ce;' rows=6 cols=35 onKeyDown='return bbs_onContentKeyDown();' ></TEXTAREA>");
					//texta.onSendReply=onSendReply;
					bbs.conTextarea = texta;
					texta.bbs=bbs;
					cell.appendChild(texta);
				}
			}
			
			row = table.insertRow();
			if(row)
			{
				cell = row.insertCell();
				var tb=document.createElement('<TABLE align="center" vAlign="top" cellSpacing=0 cellPadding=0 width="100%" align=center border=0></table>');
				if(tb)
				{
					cell.appendChild(tb);
					sub_row=tb.insertRow();
					if(sub_row)
					{
						sub_cell = sub_row.insertCell();
						sub_cell.style.width="20px";
						sub_cell.align = "left";
						btn = vs_createBtn("Send", null, bbs_onSendReply);
						
						if(btn)
						{
							//bbs.onSendReply= onSendReply;
							bbs.submitBtn = btn;
							sub_cell.appendChild(btn);
						}
						
						/*
						sub_cell = sub_row.insertCell();
						sub_cell.style.width="10px";
						var tmp=document.createElement("div");
						tmp.innerHTML="";
						sub_cell.appendChild(tmp);
						*/
						sub_cell = sub_row.insertCell();
						sub_cell.align = "left";
						sub_cell.style.width="60px";
						btn = vs_createBtn("Close", null, bbs_onSendReply);
				
						if(btn)
						{
							//bbs.onSendReply= onSendReply;
							bbs.cancelBtn=btn;
							btn.lk.bbs=bbs;
							sub_cell.appendChild(btn);
						}
					}
				}
			}
			
		}
		bbs.div = div;
		bbs.setWidth = bbs_setWidth;
	}
	return bbs;
}

function bbs_onSendReply()
{
	var bbs = bbs_getBbsFromElement(event.srcElement);
	
	//bbs.cancelPreview();
	bbs_sendReply(bbs);
	//g_vs.checkLoginByCookie(bbs_sendReply,bbs);
	return false;
}

function bbs_getBbsFromElement(el)
{
	var bbs = null;
	
	while(el)
	{
		if(el.bbs && (el.className == "bbsDiv" ))
		{
			bbs = el.bbs;
			break;
		}
		else
		{
			el = el.parentElement;
		}
	}
	
	return bbs;
}
/*
function bbs_sendReply(bbs)
{
	var value;
	var titValue;
	var sp;
	var param=new Object();
	if(param&&bbs&&typeof(bbs.onSendReply) == "function")
	{
		sp=bbs.flbtn;
		if(sp&&bbs.faceWin)
		{
			sp.state="0";
			sp.innerText=BBS_S_SEFACE;
			bbs.faceWin.hide();
		}
		texta = bbs.conTextarea;
		value = texta.value;
		if(texta)
		{
			value=bbs_checkText(value);
			if(value=="")
			{
				g_vs.showError(BBS_S_CN);
				texta.focus();
				return false;
			}
			else
			{
				ve=bbs.vecode;
				if(ve)
				{
					if(ve.value == "")
					{
						g_vs.showError(BBS_S_NOVER);
						ve.focus();
						return false;
					}
					if(ve.value.length!=4)
					{
						g_vs.showError(BBS_S_VERERR);
						ve.value="";
						ve.focus();
						return false;
					}
				}				
				
				param.value=value;
				param.veValue=ve.value;
				param.bbs=bbs;
						
				titleText = bbs.titleText;
				if(bbs.hasTitle&&titleText)
				{
					titValue=titleText.value;
					titValue=bbs_checkText(titValue);
					if(titValue=="")
					{
						g_vs.showError(BBS_S_TN);
						titleText.focus();
						return false;
					}
					else
					{
						param.titValue=titValue;
						if(bbs.secCat)
						{
							param.cat=bbs.secCat.value;
						}
						g_vs.checkLoginByCookie(bbs_sendReplyCheck,param);
						//bbs.onSendReply(value,titValue,ve.value,bbs);
					}
				}
				else
				{
					g_vs.checkLoginByCookie(bbs_sendReplyCheck,param);
					//bbs.onSendReply(value,ve.value,bbs);	
				}
			}
		}
	}
}
*/
function bbs_setWidth(width)
{
	if(this.textUrl)
	{
		this.textUrl.style.width=(width-250)+"px";
	}
	if(this.titleText)
	{
		this.titleText.style.width=(width-100)+"px";;
	}
	if(this.conTextarea)
	{
		this.conTextarea.style.width=width;
	}
	if(this.faceDiv)
	{
		this.faceDiv.style.width=width;
	}
	this.div.style.width=width;
}

function vs_createBtn(text, url, funcClick)
{
	var spanObj;
	var linkObj;
	spanObj = document.createElement("span");
	linkObj = document.createElement("a");
	if(spanObj && linkObj)
	{
		spanObj.className = "btn";

		if(g_isFF)
		{
			spanObj.style.padding = "6 3 5 3";
		}

		linkObj.className = "btn";
		linkObj.innerText = text;	
		linkObj.href = url;
		linkObj.onmousemove = bt_onmousemove;
		if(funcClick)
		{
			linkObj.onclick = funcClick;
		}
		spanObj.appendChild(linkObj);	
		spanObj.lk=linkObj;	
		return spanObj;
	}
}

function bt_onmousemove()
{
	window.status = "";
}

function my_oncontextmenu()
{   
	var menu = g_vs.createPopupMenu();	
	if(menu)
	{
   	    var subPageInfoArrayByPinyin = mytest_sortPageInfoArrayByPinyin(g_subPageInfoArray);
	    g_subPageInfoArray = mytest_sortPageInfoArray(g_subPageInfoArray, true);
	    
        for(var name in subPageInfoArrayByPinyin)
        {
            var subPageInfo = g_subPageInfoArray[name];
	        if(subPageInfo)
	        {       
	            var win = g_vs.windows[name]; 
	            var param = new Object;
	            param.name = name;
	            param.action = 1;
	            if(win.isVisible() == true)
	            {
	                menu.appendMenu(VS_MENUITEMICON1, g_subPageInfoArray[name].iframeName, vs_onMenuCommand,param);
	            } 
	            else
	            {
	                menu.appendMenu(VS_MENUITEMICON,  g_subPageInfoArray[name].iframeName, vs_onMenuCommand,param);
	            }   
            } 
        }
	    
	    menu.appendSep();
	    var win = g_vs.getWindowFromElement(event.srcElement);
	    var param1 = new Object;
	    param1.name = 0; 
	    param1.action = 0;
	    if(win)
	    {  
	        param1.name = win.id;
		    menu.appendMenu(VS_MENUITEMICON, VS_STRING_REFRESH, vs_onMenuCommand, param1);	
	    }
	    else
	    {
	        menu.appendMenu(VS_MENUITEMICON, VS_STRING_REFRESH, vs_onMenuCommand, param1);
	  	}
	  			
		menu.track(event.clientX, event.clientY);
	}
	
	event.cancelBubble = true;
	return false;
}

function vs_onMenuCommand(link, param)
{
    if(param.action == 0)
    {  
        if(param.name == 0)
        {
            window.location.reload();
        }
        else
        {
            g_vs.windows[param.name].refreshByMenu();
        }    
    }
    else if(param.action == 1)
    {
        var win =  g_vs.windows[param.name];
        if(win)
        {
            if(win.isVisible()) 
            {
                win.hide();
                g_subPageInfoArray = mytest_sortPageInfoArray(g_subPageInfoArray, true);
                mytest_showDefaultPageIfNeed(g_subPageInfoArray);                
            }
            else
            {   
                var wintop = mytest_help_getTopestWin();
                               
               win.show();
               
               g_vs.layout.insertWindow(wintop.layoutIndex, wintop.div, "beforeBegin", win);
               
               if(g_vs.defaultPage && g_vs.defaultPage.style.display == "block")
               {
                    g_vs.defaultPage.style.display = "none";
               }
 
            }  
        }
    }
}


function mytest_sortPageInfoArray(subPageInfoArray, update)//update为false代表了首次启动
{	   
    if(update)
    {
        for(var pageId in subPageInfoArray)
        {
	        var win = g_vs.windows[pageId];
	        
	        var obj = subPageInfoArray[pageId];
    	        
	        obj.ypoint = g_vs.getElementOffset(win.div).y;
            obj.visible = win.isVisible();
            obj.bToggle = win.toggle;
	    }
	}    
	    
    var iframeArray = new Array();
    var index = 0;
    for(var name in subPageInfoArray)
	{
	    iframeArray[index] = subPageInfoArray[name];
	    index++;
	}

    iframeArray.sort(function compare(a,b){if(isNaN(a.ypoint)) return -1; else if(isNaN(b.ypoint)) return 1; else return a.ypoint-b.ypoint;});  
	
	var pageInfoArrayTemp = new Object;
    for(var i = 0; i < iframeArray.length; i++)
    {
         var subPageInfo;
         var subPageInfo = iframeArray[i];
	     if(subPageInfo)
	     {       
	         var iframeID = subPageInfo.iframeID;
	         pageInfoArrayTemp[iframeID] = subPageInfo;
          } 
	}
	
	return pageInfoArrayTemp;
}

function mytest_sortPageInfoArrayByPinyin(subPageInfoArray)
{	   
    var iframeArray = new Array();
    var index = 0;
    for(var name in subPageInfoArray)
	{
	    iframeArray[index] = subPageInfoArray[name];
	    index++;
	}

    iframeArray.sort(function compare(a,b){return a.iframeName.localeCompare(b.iframeName);});  
	
	var pageInfoArrayTemp = new Object;
    for(var i = 0; i < iframeArray.length; i++)
    {
         var subPageInfo;
         var subPageInfo = iframeArray[i];
	     if(subPageInfo)
	     {       
	         var iframeID = subPageInfo.iframeID;
	         pageInfoArrayTemp[iframeID] = subPageInfo;
          } 
	}
	
	return pageInfoArrayTemp;
}

function ChangeIFrameHeight(iframeID, iframeHeight)
{
	var win = g_vs.windows[iframeID];
	if(win)
	{
	    win.height = parseInt(iframeHeight) + parseInt(win.capBar.offsetHeight);
	    //为了解决折起来状态刷新时会把下面内容区显示出来的问题
	    if(!win.toggle)
		    win.setHeight( win.height);
	}
}

function ChageIFrameTitleText(iframeID, iframeTitleText)
{
    var win = g_vs.windows[iframeID];
	if(win)
	{
	    win.setCaption(iframeTitleText);
	}   
}

function ChangeIFrameTitleIcon(iframeID, iframeTitleIcon)
{
    var win = g_vs.windows[iframeID];
    if(win)
    {
        win.changeIcon(iframeTitleIcon);
    }

}

function Frame_OnResize()
{
	
}

function SaveConfigInfo()
{
    for(var pageid in g_subPageInfoArray)
    {
        var win =  g_vs.windows[pageid];
       
        if(win)
        {
            offset = g_vs.getElementOffset(win.div);
            var bVisible = win.isVisible();
            var bToggle = win.toggle;
        
            g_windowHelper.saveIFrameConfigInfo(pageid, bVisible, offset.y, bToggle);
        }    
    }        
}

function SetIFrameTitleButton(iframeID, hasEdit, hasRefresh, hasVar1, hasVar2)
{
    var bEdit = (hasEdit == 0) ? false : true;
    var bRefresh = (hasRefresh == 0) ? false : true;
    
    var win = g_vs.windows[iframeID];
    win.hasEdit = bEdit;
    
    /*
    if(win.hasEdit)
    {
          win.edit.style.visibility = "visible";
    }
    else
    {
          win.edit.style.visibility = "hidden";
    }
    */
    
	win.hasRefresh = bRefresh;
	
	if(win.hasRefresh)
	{
	    win.refresh.style.visibility = "visible";
	}
	else
	{
	    win.refresh.style.visibility = "hidden";
	}
}


function mytest_tm_addPage(iframeID, iframeName, iframeUrl, visible, ypoint, toggle)
{
    if(g_subPageInfoArray == null)
    {
        g_subPageInfoArray = new Object;
    }
    
   if(g_subPageInfoArray[iframeID] == null)
   {
      var subPageInfo = new Object;
      subPageInfo.iframeID = iframeID;
      subPageInfo.iframeName = iframeName;
      subPageInfo.iframeUrl = iframeUrl;
      if(visible == 0)
      {
            subPageInfo.visible = false;
      }
      else
      {
            subPageInfo.visible = true;
      }
      

      subPageInfo.ypoint = parseInt(ypoint);//这里可能转换失败，我们认为ypoint值为非数字的放在最前面；
      
      if(toggle == 0)
      { 
             subPageInfo.toggle = false; 
      }
      else
      {
            if(g_vs_canToggle)
                subPageInfo.toggle = true;
            else
                subPageInfo.toggle = false;
      }
     
      g_subPageInfoArray[iframeID] = subPageInfo;
      if(g_vs)
      {
           var subPageInfo = g_subPageInfoArray[iframeID];
	       if((subPageInfo != null) && (g_vs.windows[subPageInfo.iframeID] == null))
	       {
	           var id = subPageInfo.iframeID;
	           var functionName = "mytest_initWindows('" + iframeID + "');";
	           g_vs.createWindow(iframeID,functionName,VS_PAGE_LOADING,0,0,0,"100%","100px",subPageInfo.visible,"",subPageInfo.toggle,false,true);
	           
	         var wintop = mytest_help_getTopestWin();
	        
             wintop.div.insertAdjacentElement("beforeBegin", g_vs.windows[iframeID].div); 
	       }  
       }  
   }
}

function mytest_help_getTopestWin()
{
   var wintop = null;
   g_subPageInfoArray = mytest_sortPageInfoArray(g_subPageInfoArray, true);
   for(var name in g_subPageInfoArray)
   {
      if(!isNaN(g_subPageInfoArray[name].ypoint) && g_subPageInfoArray[name].ypoint > 0)
      {
            wintop = g_vs.windows[name];
            break;
      }       
   }
   
   return wintop;
}

function mytest_tm_deletePage(iframeID)
{	   
    var win = g_vs.windows[iframeID];
    win.hide();
	win.destroy();
	
	delete g_vs.windows[iframeID];	
	delete g_subPageInfoArray[iframeID];
}

function mytest_tm_updatePage(iframeID, iframeName, iframeUrl, visible, ypoint, toggle)
{	   
  var obj = g_subPageInfoArray[iframeID];
  if(obj)
  {
      if(obj.iframeName != iframeName )
      {
          obj.iframeName = iframeName;
      }
      
      if(obj.iframeUrl != iframeUrl)
      {
          var win = g_vs.windows[iframeID];
          if(win)
          {
            win.iframe.src = iframeUrl;
          }  
      }
  } 
}

//expression会调用太多次了，慎用 慎用 
function resizeByRule()
{
    if(document.body.clientWidth > 400 )
    {
        return "400px";
    }
    else
    {
        return "100%";
    }
}