// Popup Menu

vs_addModule(vs_registerPopupMenuModule);

function vs_registerPopupMenuModule(vs)
{
	vs.createPopupMenu = vs_createPopupMenu;
}

function vs_createPopupMenu()
{
	var menu = g_vs.menu;
	var table;
	var shade;
	var tbBar;
	var row;
	var cell;

	if(menu)
	{
		menu.hide();
	}
	else
	{
		menu = document.createElement("<div class=vsMenu><div>");
		table = document.createElement("<table border=0 cellpadding=0 cellspacing=0></table>");
		shade = document.createElement("<div class=vsShade><div>");
		tbBar = document.createElement("<table border=0 cellpadding=0 cellspacing=0></table>");
		
		
		if(menu && table && shade && tbBar)
		{
			row = tbBar.insertRow();
			if(row)
			{
			    /*
				cell = row.insertCell();
				if(cell)
				{
					cell.className = "vsMenuBar";
					cell.innerHTML = "&nbsp;";
					g_vs.imgFactory.changeImg(cell, VS_MN_BAR, true);
				}
                */
                
				cell = row.insertCell();
			}
			
			if(cell)
			{
				menu.oncontextmenu = mn_oncontextmenu;
				
				cell.appendChild(table);
				menu.appendChild(tbBar);
				menu.table = table;
				menu.shade = shade;

				menu.appendMenu = mn_appendMenu;
				menu.appendSep = mn_appendSep;
				menu.track = mn_track;
				menu.popup = mn_popup;
				menu.hide = mn_hide;
				
				shade.innerHTML = ".";

				document.body.appendChild(menu);
				document.body.appendChild(shade);
			}
			else
			{
				menu = null;
			}
		}
		else
		{
			menu = null;
		}
		
		g_vs.menu = menu;
	}

	return menu;
}

function mn_appendSep()
{
	var table = this.table;
	var row = table.insertRow();
	var cell;
	
	if(row)
	{
		cell = row.insertCell();
		if(cell)
		{
			cell.colSpan = 3;
			cell.innerHTML = "<hr color=#C5CDE0 size=1>";
		}
	}
	
	return cell != null;
}

function mn_appendMenu(icon, text, onclick, param)
{
	var table = this.table;
	var row = table.insertRow();
	var cell;
	var img;
	var div1 = document.createElement("<DIV class=vsMI></DIV>");
	var div2 = document.createElement("<DIV class=vsMI></DIV>");
	var div3 = document.createElement("<DIV class=vsMI></DIV>");
	var link1 = document.createElement("A");
	var link2 = document.createElement("A");
	var link3 = document.createElement("A");
	
	if(row && div1 && div2 && div3 && link1 && link2 && link3)
	{
		if(g_isIE)
		{
			div1 = link1;
			div2 = link2;
			div3 = link3;
		}

		link1.style.textDecoration = "none";
		link2.style.textDecoration = "none";
		link3.style.textDecoration = "none";
		
		cell = row.insertCell();
		if(cell)
		{
			cell.style.paddingLeft = "1px";

			if(icon == "")
			{
				div1.innerHTML = "&nbsp;";
			}
			else
			{
				img = g_vs.imgFactory.newImage(icon, 16, 16);
				if(img)
				{
					div1.appendChild(img);
					img.className = "menuImg";
				}
			}

			if(!g_isIE)
			{
				link1.appendChild(div1);
			}
			
			cell.appendChild(link1);
		}

		cell = row.insertCell();
		if(cell)
		{
			div2.innerText = text;
			cell.noWrap = true;
			
			if(!g_isIE)
			{
				link2.appendChild(div2);
			}
			
			cell.appendChild(link2);
		}
		
		cell = row.insertCell();
		if(cell)
		{
			if(g_isFF)
			{
				cell.style.paddingRight = "2px";
			}
			else
			{
				cell.style.paddingRight = "1px";
			}
			
			div3.innerHTML = "&nbsp;&nbsp;";
			
			if(!g_isIE)
			{
				link3.appendChild(div3);
			}
			
			cell.appendChild(link3);
		}

		row.onuserclick = onclick;
		row.param = param;
		row.link1 = link1;
		row.link2 = link2;
		row.link3 = link3;
		row.div1 = div1;
		row.div2 = div2;
		row.div3 = div3;

		link1.onclick = mn_onclick;
		link2.onclick = mn_onclick;
		link3.onclick = mn_onclick;
		
		row.menu = this;
		mn_changeClass(row, "vsMI");
	}
	
	return cell != null;
}

function mn_track(x, y)
{
	g_vs.moveElement(this, -10000, -10000);
	this.style.display = "block";

	window.setTimeout("g_vs.menu.popup(" + x + "," + y + ");", 10);
}

function mn_popup(x, y)
{
	if((x + this.offsetWidth) > document.body.clientWidth)
	{
		x -= this.offsetWidth;
	}

	if((y + this.offsetHeight) > document.body.clientHeight)
	{
		y -= this.offsetHeight;
	}

	x += document.body.scrollLeft;
	y += document.body.scrollTop;
	
	this.shade.style.width = this.offsetWidth + "px";
	this.shade.style.height = this.offsetHeight + "px";
	this.shade.style.display = "block";
	
	g_vs.bringElementToFront(this.shade);
	g_vs.bringElementToFront(this);
	g_vs.moveElement(this, x, y);
	g_vs.moveElement(this.shade, x + 3, y + 3);

	this.oldonmousemove = document.body.onmousemove;
	this.oldonmousedown = document.body.onmousedown;
	document.body.onmousemove = mn_onmousemove;
	document.body.onmousedown = mn_onmousedown;
}

function mn_hide(x, y)
{
	this.shade.style.display = "none";
	this.style.display = "none";

	while(this.table.rows.length > 0)
	{
		this.table.deleteRow(0);
	}

	this.lastItem = null;
}

function mn_onclick()
{
	var el = event.srcElement;
	var link = el;

	while(link && link.tagName != "A")
	{
		link = link.parentElement;
	}
	
	el = link;
	while(el && el.tagName != "TR")
	{
		el = el.parentElement;
	}
	
	if(el && el.tagName == "TR" && el.menu)
	{
		if(typeof(el.onuserclick) == "function")
		{
			el.onuserclick(link, el.param);
		}
	}

	window.setTimeout("mn_hideMenu();", 10);
	
	return link.href != "";
}

function mn_hideMenu()
{
	if(g_vs.menu)
	{
		g_vs.menu.hide();
	}
}

function mn_onmousedown()
{
	var el = event.srcElement;
	var menu = g_vs.menu;
	var close = true;
	
	if(menu)
	{
		if(g_vs.isAnyLevelParent(el, menu) && el.tagName == "TD")
		{
		}
		else if(g_vs.isPointAboveElement(event.clientX + document.body.scrollLeft, event.clientY + document.body.scrollTop, menu) > 0)
		{
			close = false;
		}

		if(close)
		{
			document.body.onmousemove = menu.oldonmousemove;
			document.body.onmousedown = menu.oldonmousedown;
			
			menu.hide();
		}
	}

	event.cancelBubble = false;
}

function mn_onmousemove()
{
	var el = event.srcElement;
	
	while(el && el.tagName != "TR")
	{
		el = el.parentElement;
	}
	
	if(el && el.tagName == "TR" && el.menu)
	{
		if(el.menu.lastItem)
		{
			mn_changeClass(el.menu.lastItem, "vsMI");
		}

		mn_changeClass(el, "vsMIHi");
		el.menu.lastItem = el;
	}
}

function mn_oncontextmenu()
{
	return false;
}

function mn_changeClass(row, className)
{
	var i;
	var cell;
	
	row.div1.className = className + "1";
	row.div2.className = className + "2";
	row.div3.className = className + "3";
}
