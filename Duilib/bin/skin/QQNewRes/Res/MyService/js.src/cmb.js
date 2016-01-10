// Combobox
var IMG_CMBARROW = "img/cmbarrow.gif";

vs_addModule(vs_registerComboboxModule);

function vs_registerComboboxModule(vs)
{
	vs.createCombobox = vs_createCombobox;
}

function vs_createCombobox(par, width, height, editable)
{
	if(par)
	{
		if(typeof(par) == "string")
		{
			par = document.getElementById(par);
		}
	}
	
	var cmb = document.createElement("<table border=0 cellpadding=0 cellspacing=0 class=vsCMB onresize='cmb_onresize();' onclick='cmb_onclick();'></table>");
	var row;
	var cell;
	var img;
	var dropdown = document.createElement("<div class=vsCMBDD></div>");
	var shade = document.createElement("<div class=vsShade><div>");

	if(par && cmb && dropdown && shade)
	{
		row = cmb.insertRow();
		
		if(row)
		{
			row.cmb = cmb;
			cell = row.insertCell();
			if(cell)
			{
				cell.cmb = cmb;
				cell.innerHTML = "<input style='border:0px;width:1px;height:1px;' readonly/>";
				
				if(cell.children.length == 1)
				{
					cmb.edit = cell.children[0];
					cmb.edit.cmb = cmb;
					cmb.edit.editable = editable;
					if(editable)
					{
						cmb.edit.onchange = cmb_edit_onchange;
						cmb.edit.readOnly = false;
					}
					else
					{
						cmb.edit.style.cursor = VS_CUR_HAND;
					}
				}
			}

			cell = row.insertCell();
			if(cell)
			{
				cell.cmb = cmb;
				img = g_vs.imgFactory.newImage(IMG_CMBARROW, 15, 17);
				
				if(img)
				{
					cell.style.width = "15px";
					cell.appendChild(img);
					
					img.cmb = cmb;
					cmb.img = img;
				}
			}
		}

		shade.innerHTML = ".";
		dropdown.innerHTML = "<table border=0 cellpadding=0 cellspacing=1></table>";
		
		if(dropdown.children.length == 1)
		{
			cmb.table = dropdown.children[0];
		}
		
		cmb.dropdown = dropdown;
		cmb.shade = shade;
	}
	else
	{
		cmb = null;
	}
	
	if(cmb && cmb.edit && cmb.img && cmb.dropdown && cmb.table)
	{
		cmb.onchange = null;
		cmb.oneditchange = null;
		cmb.addOption = cmb_addOption;
		cmb.selectItem = cmb_selectItem;
		cmb.onselectitem = cmb_onselectitem;
		cmb.showDropDown = cmb_showDropDown;
		cmb.innerShowDropDown = cmb_innerShowDropDown;
	
		if(width)
		{
			cmb.style.width = width;
		}
		
		if(height)
		{
			cmb.style.height = height;
		}

		document.body.appendChild(cmb.shade);
		document.body.appendChild(cmb.dropdown);
		par.appendChild(cmb);
	}

	return cmb;
}

function cmb_onresize()
{
	var cmb = event.srcElement;

	if(cmb)
	{
		cmb.edit.style.height = Math.max(cmb.clientHeight - 2, 0) + "px";
		cmb.edit.style.width = Math.max(cmb.clientWidth - cmb.img.offsetWidth - (g_isFF ? 2 : 0), 0) + "px";
	}
}

function cmb_onclick()
{
	var el = event.srcElement;
	
	if(el && el.cmb)
	{
		if(el.tagName == "INPUT" && el.editable)
		{
		}
		else
		{
			el.cmb.showDropDown();
		}
	}
}

function cmb_edit_onchange()
{
	var ret = true;
	var el = event.srcElement;
	
	if(el && el.cmb)
	{
		if(typeof(el.cmb.oneditchange) == "function")
		{
			ret = el.cmb.oneditchange();
		}
	}
	
	return ret;
}

function cmb_dd_onmousemove()
{
	var el = event.srcElement;
	var cmb = g_vs.lastCMB;
	
	if(cmb && el.tagName == "TD" && g_vs.isAnyLevelParent(el, cmb.dropdown))
	{
		if(cmb.lastItem)
		{
			cmb.lastItem.className = "vsCMBItem";
		}
		
		el.className = "vsCMBHi";
		cmb.lastItem = el;
	}
}

function cmb_dd_onmousedown()
{
	var el = event.srcElement;
	var cmb = g_vs.lastCMB;
	var close = true;
	
	if(cmb)
	{
		if(g_vs.isAnyLevelParent(el, cmb.dropdown) && el.tagName == "TD")
		{
			cmb.onselectitem(el);
		}
		else if(g_vs.isPointAboveElement(event.clientX + document.body.scrollLeft, event.clientY + document.body.scrollTop, cmb.dropdown) > 0)
		{
			close = false;
		}

		if(close)
		{
			document.body.onmousemove = cmb.oldonmousemove;
			document.body.onmousedown = cmb.oldonmousedown;
			cmb.shade.style.display = "none";
			cmb.dropdown.style.display = "none";

			g_vs.lastCMB = null;
		}
	}
	
	event.cancelBubble = false;
}

function cmb_showDropDown()
{
	g_vs.lastCMB = this;

	g_vs.moveElement(this.dropdown, -10000, -10000);
	this.table.style.width = "";
	this.table.style.height = "";
	this.dropdown.style.width = "";
	this.dropdown.style.height = "";
	this.dropdown.style.display = "block";
	window.setTimeout("if(g_vs.lastCMB) g_vs.lastCMB.innerShowDropDown();", 10);
}

function cmb_innerShowDropDown()
{
	var offset = g_vs.getElementOffset(this);
	var left = offset.x;
	var top = offset.y + this.offsetHeight;
	var width = this.dropdown.offsetWidth + 50;
	var height = this.dropdown.offsetHeight;

	if(width < this.offsetWidth)
	{
		width = this.offsetWidth;
	}
	
	this.dropdown.style.width = width + "px";
	if(height > 150)
	{
		height = 150;
		this.dropdown.style.height = "150px";
	}

	this.table.style.width = "100%";

	if((left + this.offsetWidth) > document.body.clientWidth)
	{
		left = document.body.clientWidth - this.offsetWidth;
	}

	if((top + height) > document.body.clientHeight)
	{
		top = offset.y - height;
	}

	this.shade.style.width = this.dropdown.offsetWidth + "px";
	this.shade.style.height = this.dropdown.offsetHeight + "px";
	this.shade.style.display = "block";
	
	g_vs.bringElementToFront(this.shade);
	g_vs.bringElementToFront(this.dropdown);
	g_vs.moveElement(this.dropdown, left, top);
	g_vs.moveElement(this.shade, left + 3, top + 3);
	
	if(this.selItem)
	{
		if(this.lastItem)
		{
			this.lastItem.className = "vsCMBItem";
		}
		
		this.lastItem = this.selItem;
		this.lastItem.className = "vsCMBHi";
		
		if(g_isIE)
		{
			this.selItem.focus();
		}
		else
		{
			this.selItem.scrollIntoView(false);
		}
	}
	
	this.oldonmousemove = document.body.onmousemove;
	this.oldonmousedown = document.body.onmousedown;
	document.body.onmousemove = cmb_dd_onmousemove;
	document.body.onmousedown = cmb_dd_onmousedown;
}

function cmb_addOption(value, text)
{
	var row = this.table.insertRow();
	var cell;

	if(row)
	{
		cell = row.insertCell();
		
		if(cell)
		{
			cell.className = "vsCMBItem";
			cell.innerText = text;
			cell.value = value;
		}
	}
}

function cmb_selectItem(value)
{
	var i;
	var row;
	var cell;
	
	for(i = 0; i < this.table.rows.length; i++)
	{
		row = this.table.rows[i];
		cell = row.cells[0];
		
		if(cell && cell.value == value)
		{
			this.onselectitem(cell);
		}
	}
}

function cmb_onselectitem(item)
{
	this.edit.value = item.innerText;
	this.selItem = item;
	if(typeof(this.onchange) == "function")
	{
		this.onchange(item.value);
	}
}
