var g_vs_dragWindow = null;
var g_disableDrag = false;

vs_addModule(vs_registerWindowModule);

function vs_registerWindowModule(vs)
{
	vs.createWindow = vs_createWindow;
	vs.createLayout = vs_createLayout;
	vs.getWindowFromElement = vs_getWindowFromElement;

    vs.createDefaultPage = vs_createDefaultPage;

	vs.windows = new Array();
}

function vs_createDefaultPage()
{
	var div = document.createElement("<div class=winDiv style='display:block; border:1px solid #92a3ce ;overflow:hidden; word-wrap:break-word;'><div>");
	var icon;
	var caption;
	var table;
	var capBar;
		
	if(div)
	{
		div.innerHTML = "<table border=0 cellSpacing=0 cellPadding=0><col width='1%'><col width='99%'><tr><td vAlign=top noWrap class=defaultPageIcon style='font-size:6pt;'>&nbsp;</td><td align=left class=defaultPageText></td></tr></table>";    
    }
    
    if(div.children.length == 1 && div.children[0].rows.length == 1)
	{
		table = div.children[0];
		row = div.children[0].rows[0];
		capBar = row;

		if(row.cells.length ==2)
		{
			icon = row.cells[0];
 			caption = row.cells[1];
 		}
 		
 		img = g_vs.imgFactory.newImage(IMG_WINDOW_TIP);
		if(img)
		{
		      icon.appendChild(img);
	    }
	    
 	    caption.innerHTML = VS_BLANK_CONTENT; 	
 	}
 	
 	div.style.position = "";
 	document.body.appendChild(div);
 	g_vs.defaultPage = div; 
 }
 
 
// Layout
function vs_createLayout()
{
	var layout = new Object();
	var dragHSpan = document.createElement("<div class=dragHSpan></div>");
	var i;
	
	if(layout && dragHSpan)
	{
		// method
		layout.insert = lo_insert;
		layout.remove = lo_remove;
		layout.insertWindow = lo_insertWindow;
	
		// attribute
		layout.dragHSpan = dragHSpan;
		layout.items = new Array();
		layout.canDrag = g_disableDrag;
		layout.dragCross = true;
		
		if(layout.items)
		{
			if(typeof(vs_createBody) == "function")
			{
				vs_createBody();
			}
			
			if(typeof(vs_layoutCallBack) == "function")
			{
				vs_layoutCallBack(layout);
				
				for(i = 0; i < layout.items.length; i++)
				{
					layout.items[i].innerHTML = "<div style='display:none;'>&nbsp;</div>";
				}
			}
		}
	}
	else
	{
		layout = null;
	}
	
	return layout;
}

function lo_insert(layoutIndex, win, pos, posid)
{
	var item;
	var i;
	
	if(layoutIndex >= 0 && layoutIndex < this.items.length)
	{
		item = this.items[layoutIndex];
		
		if(item)
		{
			if(typeof(pos) == "string")
			{
				if(pos == "first")
				{
					this.insertWindow(layoutIndex, item, "afterBegin", win);
				}
				else if(pos == "last")
				{
					this.insertWindow(layoutIndex, item, "beforeEnd", win);
				}
				else 
				{
					for(i = 0; i < item.children.length; i++)
					{
						if(item.children[i].win && item.children[i].win.id == posid)
						{
							if(pos == "before")
							{
								this.insertWindow(layoutIndex, item.children[i], "beforeBegin", win);
							}
							else if(pos == "after")
							{
								this.insertWindow(layoutIndex, item.children[i], "afterEnd", win);
							}
							
							break;
						}
					}
				}
			}
		}
	}
}

function lo_insertWindow(layoutIndex, el, pos, win)
{
	var vis = win.isVisible();
	
	if(vis)
	{
		win.hide();
	}
	
	win.div.style.position = "";
	el.insertAdjacentElement(pos, win.div);
	win.isLayout = true;
	win.layoutIndex = layoutIndex;

	if(vis)
	{
		win.show();
	}
}

function lo_remove(id)
{
	var item;
	var i;
	var layoutIndex;
	var win;
	
	for(layoutIndex = 0; layoutIndex < this.items.length; layoutIndex++)
	{
		item = this.items[layoutIndex];

		if(item)
		{
			if(typeof(id) == "string")
			{
				for(i = 0; i < item.children.length; i++)
				{
					win = item.children[i].win;
					if(win && win.id == id)
					{
						item.removeChild(win.div);
						win.div.style.position = "absolute";
						win.isLayout = false;
						break;
					}
				}
			}
		}
	}
}

// Window
function vs_createWindow(id, oninit, cap, layoutIndex, left, top, width, height, vis, archive, toggle,hasClose, hasBorder)
{
	var win = new Object();
	var div = null;
	var row;
	var cell;
	var img;
	var shade;
	
	win.iconPath = IMG_DIVLOGO;
	if(win)
	{
		div = document.createElement("<div class=winDiv style='display:none;' onmouseout='win_onmouseout();' onmousemove='win_onmousemove();' onmouseup='win_onmouseup();' onlosecapture='win_onlosecapture();' onresize='win_onresize();'><div>");
		shade = document.createElement("<div class=vsShade><div>");
	}
		
	if(div && shade)
	{
		win.div = div;
		div.win = win;
		win.shade = shade;
		div.innerHTML = "<table border=0 cellSpacing=0 cellPadding=0 class=fill><tr class=winCapBar><td><table border=0 cellSpacing=0 cellPadding=0 class=fill><col width='1%'><col width='98%'><col width='1%'><tr><td noWrap class=winCap style='font-size:6pt;'>&nbsp;</td><td align=left class=winCap></td><td align=right class=winCap></td></tr></table></td></tr><tr valign=top><td align=left onresize='win_onresize();'><div class=winClient  style='display:none width:100%'></div></td></tr></table>";
        
        /* 
        <table border=1 cellSpacing=0 cellPadding=0 class=fill>
            <tr class=winCapBar>
                <td>
                    <table border=3 cellSpacing=0 cellPadding=0 class=fill>
                        <col width='1%'><col width='98%'><col width='1%'>
                        <tr>
                            <td noWrap class=winCap style='font-size:6pt;'>&nbsp;</td>
                            <td align=left class=winCap></td>
                            <td align=right class=winCap></td>
                        </tr>
                    </table>
                </td>
            </tr>
        
            <tr valign=top>
                <td align=left onresize='win_onresize();'>      
                    <div class=winClient style='display:none;'></div>
                </td>
            </tr>
        </table>
        */
        

		if(div.children.length == 1 && div.children[0].rows.length == 2)
		{
			win.table = div.children[0];
			row = div.children[0].rows[0];
			win.capBar = row;
			if(row.cells.length == 1 && row.cells[0].children.length == 1 && row.cells[0].children[0].rows.length == 1)
			{
				win.capBarTB = row.cells[0].children[0];
				row = row.cells[0].children[0].rows[0];
				
				if(row.cells.length == 3)
				{
					win.icon = row.cells[0];
 					win.caption = row.cells[1];
 					
 					if(g_vs.layout.canDrag || layoutIndex < 0)
 					{
 					   if(toggle != null)
 					   {
 					        img = g_vs.imgFactory.newImage(win.iconPath);
 					        if(img)
 					        {
       					        img.param = TYPE_LOGO;
    					        win.icon.appendChild(img);
    					        img.onclick=win_ontoggle;
    					        if(g_vs_canToggle)
    					            img.className="ctrlBtn";
                                else
                                    img.className="IMG"
                                win.dropdown = img;
 					        }
     					    
     					    if(g_vs_canToggle)
						        win.icon.style.cursor = "move";
						    win.caption.onmousedown = win_onmousedown;
						    win.caption.style.cursor = "move";
 					   }
 					    
					}
					
					win.control = row.cells[2];
				
			
			        /*
				     img = g_vs.imgFactory.newImage(IMG_WINDOW_EDIT);
				     if(img)
				    {
				       win.control.appendChild(img);
				       img.onclick = win_onedit;
				       img.onmousemove = win_showtips;
				       img.initvisible = false;
				       img.className = "ctrlBtn";
				       win.edit = img;
				    }
				    */
				
					
				    img = g_vs.imgFactory.newImage(IMG_WINDOW_REFRESH);
					if(img)
					{
						win.control.appendChild(img);
						img.onclick = win_onrefresh;
						img.initvisible = true;
						img.className = "ctrlBtn";
						img.title = VS_TIPS_REFRESH;
						win.refresh = img;
					}
									    		
					if(hasClose)
					{
						img = g_vs.imgFactory.newImage(IMG_CLOSE);
						if(img)
						{
							win.control.appendChild(img);
							img.onclick = win_onclose;
							img.className = "ctrlBtn";
							win.close = img;
						}
					}

					if(toggle == null && !hasClose)
					{
						row.deleteCell(2);
						win.control = new Object();
						win.dropdown = new Object();
					}
					
					if(hasBorder)
					{
						win.div.className = "winBorder";
					}
				}
			}
			
			row = div.children[0].rows[1];
			if(row.cells.length == 1 && row.cells[0].children.length == 1)
			{
				win.client = row.cells[0].children[0];
			}
		}
	}

	if(!(win && win.div && win.table && win.capBar && win.icon && win.caption && win.control && win.dropdown && win.client))
	{
		win = null;
	}
	
	if(win)
	{
		// method
		win.show = win_show;
		win.hide = win_hide;
		win.destroy = win_destroy;
		win.moveto = win_moveto;
		win.dragEnd = win_dragEnd;
		win.hideIcon = win_hideIcon;
		win.setWidth = win_setWidth;
		win.setHeight = win_setHeight;
		win.setBottom = win_setBottom;
		win.isVisible = win_isVisible;
		win.dragStart = win_dragStart;
		win.ondragging = win_ondragging;
		win.showClient = win_showClient;
		win.hideClient = win_hideClient;
		win.setCaption = win_setCaption;
		win.changeIcon = win_changeIcon;
		win.disableDrag = win_disableDrag;
		win.resizeClient = win_resizeClient;
		win.setTargetDiv = win_setTargetDiv;
		win.setClientHTML = win_setClientHTML;
		win.setContextMenu = win_setContextMenu;
		win.cleardragHSpan = win_cleardragHSpan;
		win.isClientVisible = win_isClientVisible;
		win.hideCaptionStyle = win_hideCaptionStyle;
		win.dragLayoutWindow = win_dragLayoutWindow;
		win.dragFloatWindowEnd = win_dragFloatWindowEnd;
		win.dragLayoutWindowEnd = win_dragLayoutWindowEnd;
		win.dragProcessLayoutItem = win_dragProcessLayoutItem;
        win.refreshByMenu = win_onrefreshByMenu;
		// event
		win.onclose = null;
		win.onclientshow = null;

		// init
		win.id = id;
		win.toggle = toggle;
		win.caption.win = win;
		win.archive = archive;
		win.hasBorder = hasBorder;
		win.mouseover = false;
		
		win.hasEdit = true;
		win.hasRefresh = true;
		win.timerID = 0;
        
		win.setWidth(width);
		win.setHeight(height);
		win.setCaption(cap);

		if(hasBorder)
		{
			win.capBar.cells[0].className = "winCapB";
		}
		
		if(oninit)
		{
			win.oninit = oninit;
		}
		
		win.canDrag = g_disableDrag;

		shade.innerHTML = ".";
		document.body.appendChild(shade);

		if(layoutIndex >= 0)
		{
			this.layout.insert(layoutIndex, win, "last");
		}
		else
		{
			win.div.style.position = "absolute";
			document.body.appendChild(win.div);
			win.moveto(left, top);
		}
		
		this.windows[id] = win;
		
		if(typeof(g_vs.oncreatewindow) == "function")
		{
			g_vs.oncreatewindow(win);
		}
		
		window.setTimeout("win_delayShow('" + id + "', " + vis + ");", 10);
	}
	
	return win;
}

function win_showtips()
{
/*
	var el = event.srcElement;
	var tip = el.tipObject;
	
	//var data = el.tiptext;
	var data = el.src0;
	if(!tip)
	{
		tip = g_vs.createTip(data, "25px", "");
	}
	
	if(tip)
	{
		el.tipObject = tip;
		tip.show();
	}
	*/
}

function win_delayShow(id, vis)
{
	var win = g_vs.windows[id];
	if(win)
	{
		if(vis)
		{
			win.show();
		}

		if(win.oninit)
		{
			window.setTimeout(win.oninit, 50);
		}
	}
}

function win_getFFWidthHeight(wh)
{
	var x = wh;

	if(typeof(wh) == "number" || (typeof(wh) == "string" && wh.indexOf("px") > 0))
	{
		x = parseInt(wh, 10);		
		x = (x - 2) + "px";
	}

	return x;
}

function win_setWidth(width, noPaint)
{
	if(!noPaint)
	{
		this.hideClient();
	}
	
	this.width = width;

	if(g_isFF && this.hasBorder)
	{
		width = win_getFFWidthHeight(width);
	}
    
    //为了实现max-width = 400px， 将width的实现放到css里面
    //this.div.style.width = this.width;
    
	if(!noPaint)
	{
		this.showClient();
	}
}

function win_setHeight(height, noPaint)
{
	if(!noPaint)
	{
		this.hideClient();
	}
	
	if(height == "")
	{
		this.client.style.overflow = "visible";
	}
	else
	{
		this.client.style.overflow = "auto";
	}
	
	this.height = height;

	if(g_isFF && this.hasBorder)
	{
		height = win_getFFWidthHeight(height);
	}

	this.div.style.height = height;
	
	if(!noPaint)
	{
		this.showClient();
	}
}

function win_dragStart()
{
	var div = this.div;
	var offset;
	this.isDragging = true;

	offset = g_vs.getElementOffset(div);

    
	this.hideClient();
	document.body.className = "";
	this.client.className = "winClientD";

	if(g_isIE || !this.hasBorder)
	{
		//div.style.width = (div.offsetWidth) + "px";
		div.style.height = (div.offsetHeight) + "px";
	}
	else
	{
		div.style.width = (div.offsetWidth - 2) + "px";
		div.style.height = (div.offsetHeight - 2) + "px";
	}
	
	div.style.position = "absolute";
	this.shade.style.display = "none";
	this.moveto(offset.x, offset.y);
	
	this.showClient();
	
	if(this.isLayout)
	{
		div.insertAdjacentElement("beforeBegin", g_vs.layout.dragHSpan);
		g_vs.layout.dragHSpan.layoutIndex = this.layoutIndex;
	}
}

function win_ondragging()
{
	var div = this.div;
	var offset;
	var left;
	var top;
	
	if(this.isDragging)
	{
		offset = g_vs.getElementOffset(div);
		
		left = document.body.scrollLeft;
		top = document.body.scrollTop;
		this.moveto(offset.x + (event.screenX - div.lastX) + (left - div.lastBodyScrollLeft), offset.y + (event.screenY - div.lastY) + (top - div.lastBodyScrollTop));
		div.lastX = event.screenX;
		div.lastY = event.screenY;
		div.lastBodyScrollLeft = left;
		div.lastBodyScrollTop = top;
		
		if(this.isLayout)
		{
			this.dragLayoutWindow(event.clientX + document.body.scrollLeft, event.clientY + document.body.scrollTop);
		}
	}
}

function win_dragLayoutWindow(x, y)
{
  	var i;
	for(i = 0; i < g_vs.layout.items.length; i++)
	{
		if(g_vs.isPointAboveElement(x, y, g_vs.layout.items[i]) > 0)
		{
			this.dragProcessLayoutItem(g_vs.layout.items[i], x, y);
		}
	}
}

function win_dragProcessLayoutItem(item, x, y)
{
	var i;
	var div;

	if(item.children.length > 2 || (item.children.length == 2 && item.children[1] != this.div))
	{
	    var find = false;
	    var lastObj = null;
		for(i = 0; i < item.children.length; i++)
		{
			div = item.children[i];
						    
			if(div.win && div.win != g_vs_dragWindow)
			{
			    if(this.setTargetDiv(g_vs.isPointAboveElement(x, y, div), div))
			    {
			        find = true;
				    break;
				}
				else
				{
				    if(div.win.isVisible())
				    {
				        if(lastObj == null)
				        {
				            lastObj = div;
				        }
				        else
				        {
				            var offsetObj = g_vs.getElementOffset(lastObj);
    				        
				            var offsetNew = g_vs.getElementOffset(div);
    				        
				            if(offsetObj.y <= offsetNew.y)
				            {
				                lastObj = div;
				            } 
				        }
				    }
				}
			}
		}
		
		if(!find && lastObj)
		{
		    lastObj.insertAdjacentElement("afterEnd", g_vs.layout.dragHSpan);
		}
	}
	else if(g_vs.layout.dragCross || item.layoutIndex == g_vs.layout.dragHSpan.layoutIndex)
	{
		item.insertAdjacentElement("beforeEnd", g_vs.layout.dragHSpan);
		g_vs.layout.dragHSpan.layoutIndex = item.layoutIndex;
	}
}

function win_setTargetDiv(pos, div)
{
	var result = false;

	if(pos == 1 || pos == 2)
	{
		result = true;

		if(!g_vs.layout.dragCross && div.win.layoutIndex != g_vs.layout.dragHSpan.layoutIndex)
		{
			result = false;
		}
		
		if(result)
		{
			div.pos = pos;
			
			if(pos == 1)
			{
				div.insertAdjacentElement("beforeBegin", g_vs.layout.dragHSpan);
			}
			else
			{
				div.insertAdjacentElement("afterEnd", g_vs.layout.dragHSpan);
			}
			
			g_vs.layout.dragHSpan.layoutIndex = div.win.layoutIndex;
		}
	}

	return result; 
}

function win_disableDrag()
{
	this.canDrag = false;
	this.icon.style.cursor = "auto";
	this.caption.style.cursor = "auto";
}

function win_dragEnd()
{
	if(this.isDragging)
	{
		this.isDragging = false;
		document.body.className = "vsBody";
		this.client.className = "winClient";

		if(this.isLayout)
		{
			this.dragLayoutWindowEnd();
		}
		else
		{
			this.dragFloatWindowEnd();
			this.shade.style.display = "block";
		}

	}
	
	g_vs_dragWindow = null;
	this.div.releaseCapture();
	
	if(g_isFF)
	{
		window.setTimeout("win_resizeByID('" + this.id + "');", 10);
	}
}

function win_resizeByID(id)
{
	var win = g_vs.windows[id];
	
	if(win)
	{
		win.resizeClient();
	}
}

function win_cleardragHSpan()
{
	g_vs.removeElementFromParent(g_vs.layout.dragHSpan);
}

function win_dragLayoutWindowEnd()
{
	var div = this.div;
	
	this.hide();
	this.table.style.display = "none";
	this.setWidth(this.width);
	this.setHeight(this.height);
	div.style.position = "";
	g_vs.layout.insertWindow(g_vs.layout.dragHSpan.layoutIndex, g_vs.layout.dragHSpan, "afterEnd", div.win);

	this.cleardragHSpan();

	this.show();
	
	if(g_isFF)
	{
		this.table.style.display = VS_TB_BLOCK;
	}
}

function win_dragFloatWindowEnd()
{
	var offset = g_vs.getElementOffset(this.div);
	
	this.moveto(Math.max(offset.x, 0), Math.max(offset.y, 0));
}

function win_onmousedown()
{
   	var win = g_vs.getWindowFromElement(event.srcElement);
	var mb = g_isFF ? 0 : 1;
	var offset;

   if(event.srcElement.tagName == "A")
   {

   }
   else
   {
        if(win && event.button == mb)
	    {
		    if(!win.isLayout)
		    {
			    g_vs.bringElementToFront(win.shade);
			    g_vs.bringElementToFront(win.div);
		    }

		    if((!win.isLayout && win.canDrag) || (win.isLayout && g_vs.layout.canDrag && win.canDrag))
		    {
			    g_vs_dragWindow = win;
			    win.div.lastX = event.screenX;
			    win.div.lastY = event.screenY;
			    win.div.lastBodyScrollLeft = document.body.scrollLeft;
			    win.div.lastBodyScrollTop = document.body.scrollTop;
			    win.isMouseDown = true;
			    win.div.setCapture();
    			
			    return false;
		    }
	    }
	}	
}

/*
解决onMouseOut违背逻辑的办法:

鼠标移出这个层的时候，就触发onMouseOut事件，将层隐藏掉。 但是，如果你的鼠标接触到文字的时候，由于你接触到了A标记，而A标记在div1上边，所以就认为鼠标已经出了div1的范围了，就执行onMouseOut了，这个实际上并不是我们的本意。
*/
function win_onmouseout()
{
/*
    var win = g_vs.getWindowFromElement(event.srcElement);
    var obj = event.toElement;
        
    var divTemp = null;
    
    if(win && typeof(win) == "object" && typeof(win.div) == "object")
    {
        divTemp = win.div;
    
        while( obj!= null && obj != divTemp )
        { 
            obj = obj.parentElement; 
        } 

        if(obj == null)
        {
            if(win.timerID)
            {
                window.clearTimeout(win.timerID);
                win.timerID = 0;
            }
            
            
            if(g_vs_canToggle)
            {
                var img = win.dropdown;
	            var iconPath = win.iconPath;
            				   
	            if(img.param == TYPE_TOGGLE)
	            {
		            g_vs.imgFactory.changeImg(img, iconPath);
		            img.param = TYPE_LOGO;
	            }
            }
            
        	    
	        if(win.hasEdit && win.edit.style.visibility == "visible")
	        {
                   win.edit.style.visibility = "hidden";
            }
                    
            if(win.hasRefresh && win.refresh.style.visibility == "visible")
            {
 	              win.refresh.style.visibility = "hidden";
            }
       }
    }
    */
}

function win_onmousemove()
{
	var win = g_vs_dragWindow;
	if(win)
	{	 
		if(win.isMouseDown)
		{
			win.isMouseDown = false;
			win.dragStart();
		}
		
		win.ondragging();
	}
	else
	{
	    /*
		var win = g_vs.getWindowFromElement(event.srcElement);
        
	    if(win.timerID == 0)
		    win.timerID = window.setTimeout("win_showTitleControl('" + win.id + "');", 500);
        */	
	}
}

function win_showTitleControl(id)
{
    var win = g_vs.windows[id];
	if(win)
	{
	    if(g_vs_canToggle)
	    {
	        var img = win.dropdown;
		    if(img.param == TYPE_LOGO)
		    {
			    g_vs.imgFactory.changeImg(img, win.toggle ? IMG_COLLAPSE : IMG_EXPAND);
			    img.param = TYPE_TOGGLE;
		    }
	    }
            
        //if(win.hasEdit)
        //    win.edit.style.visibility = "visible";
        
        
        if(win.hasRefresh)
 	       win.refresh.style.visibility = "visible";
	}    
}

function win_onmouseup()
{  
	var win = g_vs_dragWindow;
	
	if(win)
	{
		win.dragEnd();
	}

	win = g_vs.getWindowFromElement(event.srcElement);

	if(win && !win.isLayout)
	{
		g_vs.bringElementToFront(win.shade);
		g_vs.bringElementToFront(win.div);
	}
}

function win_onlosecapture()
{
	var win = g_vs_dragWindow;
	
	if(win)
	{
		win.dragEnd();
	}
}

function win_onresize()
{
	var el = event.srcElement;
	var win = g_vs.getWindowFromElement(el);
   	
	if(win && win.isVisible())
	{  
		    if(el.tagName == "DIV" && el.win)
		    {	   
			    win.table.style.display = VS_TB_BLOCK;
    			    
			    if(g_isIE)
			    {
				    win.client.style.overflow = "auto";
			    }
			    else if(g_isFF && win.capBarTB)
			    {
				    win.capBarTB.style.width = (win.div.clientWidth - 4) + "px";
			    }
    			
			    if(g_isFF && win.isLayout)
			    {
				    win.div.style.overflow = "auto";
			    }
		    }

		    if(!win.isLayout)
		    {
			    win.shade.style.width = win.div.offsetWidth + "px";
			    win.shade.style.height = win.div.offsetHeight + "px";
		    }

		    win.resizeClient();
    		
    		
		    if(typeof(win.onresize) == "function")
		    {
			    win.onresize();
		    }
	}
}

function win_ontoggle()//这个是下拉箭头的响应
{
    if(g_vs_canToggle)
    {
        var win = g_vs.getWindowFromElement(event.srcElement);
	
	    if(win)
	    {
		    win.toggle = !win.toggle;
            
            g_windowHelper.toggleIFrame(win.id, win.toggle);
		    if(win.toggle)
		    {
			    win.hideClient();
		    }
		    else
		    {
			    win.showClient();
		    }

		    g_vs.imgFactory.changeImg(win.dropdown, win.toggle ? IMG_COLLAPSE : IMG_EXPAND);
	    }
    }
}

function win_onrefresh()//这个是刷新按钮的响应
{
    var win = g_vs.getWindowFromElement(event.srcElement);
    if(win)
        g_windowHelper.refreshIFrame(win.id);
}

function win_onrefreshByMenu()//菜单刷新和按钮刷新的event element获取方法不同
{
    g_windowHelper.refreshIFrame(this.id);
}

function win_onedit()
{
    var win = g_vs.getWindowFromElement(event.srcElement);
    if(win)
         g_windowHelper.showIFrameEditZone(win.id);
}   

function win_onclose()
{
	var win = g_vs.getWindowFromElement(event.srcElement);
	var destroy = true;
	
	if(win)
	{
		if(typeof(win.onclose) == "function")
		{
			destroy = win.onclose();
		}

		win.hide();

		if(destroy)
		{
			win.destroy();
		}
	}
}

function win_destroy()
{
	g_vs.windows[this.id] = null;
	g_vs.removeElementFromParent(this.div);
	g_vs.removeElementFromParent(this.shade);

	this.div.innerHTML = "";
	this.shade.innerHTML = "";

	g_vs.addGarbage(this);
	g_vs.addGarbage(this.div);
	g_vs.addGarbage(this.shade);

	g_vs.clearObject(this);
}

function win_setCaption(cap)
{
	if(cap == null)
	{
		this.capBar.style.display = "none";
	}
	else if(typeof(cap) == "string")
	{
		if(cap == "")
		{
			cap = "&nbsp;";
		}

		this.caption.innerHTML = cap;
		this.capBar.style.display = VS_TR_BLOCK;
	}
}

function win_setBottom(bot)
{
	var row;
	
	if(bot == null)
	{
		if(this.table.rows.length == 3)
		{
			this.bottom = null;
			this.table.deleteRow(2);
		}
	}
	else if(typeof(bot) == "string")
	{
		if(bot == "")
		{
			bot = "&nbsp;";
		}

		if(!this.bottom)
		{
			row = this.table.insertRow();
			
			if(row)
			{
				this.bottom = row.insertCell();
			}
		}
		
		if(this.bottom)
		{
			if(this.hasBorder)
			{
				this.bottom.className = "winBottomB";
			}
			else
			{
				this.bottom.className = "winBottom";
			}
			
			this.bottom.innerHTML = bot;
		}
	}
}

function win_setClientHTML(sHTML)
{
	if(typeof(sHTML) == "string")
	{
		this.client.innerHTML = sHTML;
	}
}

function win_setContextMenu(oncontextmenu)
{
	this.div.oncontextmenu = oncontextmenu;
}

function win_resizeClient()
{
	if(this.width == "")
	{
		this.client.style.width = "";
	}
	else
	{
	         //移动page的时候固定client的宽度，否则会出现移动时的page页面没有透明效果的问题
	         if(this.isDragging)
	         {
    	         this.client.style.width = this.client.parentElement.clientWidth + "px";
	         }
	         else
	         {
	            this.client.style.width = "100%";
	         }	    	        
	 }
	 
	if(this.height == "")
	{
		this.client.style.height = "";
	}
	else
	{
		if(g_isFF)
		{
			this.div.style.overflow = "hidden";
		}

		this.client.style.height = this.client.parentElement.clientHeight + "px";
	}
}

function win_isVisible()
{
	return this.div && this.div.style.display == "block";
}

function win_isClientVisible()
{
	return this.client.style.display == "block";
}

function win_changeIcon(icon)
{
	if(typeof(icon) != "string")
	{
	    //Friday
		return;
	}
	
    this.iconPath = icon;
	var img = this.dropdown;			   
	 if(img.param == TYPE_LOGO)
	{
			g_vs.imgFactory.changeImg(img, this.iconPath);
	}
					
	//var img = g_vs.imgFactory.newImage(icon);
	//if(img)
	//{
		//img.className = "winIcon";
		//this.icon.innerHTML = "&nbsp;";
		//this.icon.appendChild(img);
		//this.icon.insertAdjacentHTML("beforeEnd", "&nbsp;");
	//}	
}

function win_show()
{
	var div = this.div;
	
	this.hideClient();

	if(this.isLayout)
	{
		div.style.position = "";
	}
	else
	{
		div.style.position = "absolute";
		this.shade.style.display = "block";
	}

	div.style.display = "block";
	this.showClient();
}

function win_hide()
{
	this.div.style.display = "none";
	this.shade.style.display = "none";
}

function win_showClient()
{
	if(!this.toggle)
	{
		if(typeof(this.height) != "undefined")
		{
			this.setHeight(this.height, true);
		}

		if(!this.isDragging)
		{
			if(typeof(this.width) != "undefined")
			{
				this.setWidth(this.width, true);
			}
		}

		this.resizeClient();
		this.client.style.display = "block";
		
		if(this.bottom)
		{
			this.bottom.style.display = VS_TD_BLOCK;
		}

		if(typeof(this.onclientshow) == "function")
		{
			this.onclientshow(true);
		}
	}
}

function win_hideClient()
{
	this.div.style.height = "";
	this.client.style.display = "none";

	if(this.bottom)
	{
		this.bottom.style.display = "none";
	}

	if(typeof(this.onclientshow) == "function")
	{
		this.onclientshow(false);
	}
}

function win_hideIcon()
{
	this.icon.style.display = "none";
}

function win_hideCaptionStyle()
{
	this.icon.className = "";
	this.caption.className = "";
	this.control.className = "";
}

function win_moveto(left, top)
{
	g_vs.moveElement(this.div, left, top);

	if(!this.isLayout)
	{
		this.shade.style.width = this.div.offsetWidth + "px";
		this.shade.style.height = this.div.offsetHeight + "px";

		g_vs.moveElement(this.shade, left + 3, top + 3);
	}
}

function vs_getWindowFromElement(el)
{
	var win = null;
	
	while(el)
	{
		if(el.win && (el.className == "winDiv" || el.className == "winBorder" || el.className == "winCap"))
		{
			win = el.win;
			break;
		}
		else
		{
			el = el.parentElement;
		}
	}
	
	return win;
}

