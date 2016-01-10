// Tip

vs_addModule(vs_registerTipModule);

function vs_registerTipModule(vs)
{
	vs.createTip = vs_createTip;
}

function vs_createTip(sHTML, width, height)
{
	var tip = new Object();
	var win = g_vs.createWindow(g_vs.genUID(), null, null, -1, -10000, -10000, width, height, false, "", null, false, true);

	if(tip && win)
	{
		tip.show = tip_show;
		tip.hide = tip_hide;
		tip.destroy = tip_destroy;
		tip.innerShow = tip_innerShow;
		
		tip.tid = 0;
		tip.win = win;
		tip.client = win.client;
		win.div.tipObject = tip;
		
		win.setClientHTML(sHTML);
	}
	else
	{
		tip = null;
	}
	
	return tip;
}

function tip_show()
{
	var el = event.srcElement;

	if(this == g_vs.lastTip && this.win.isVisible())
	{
	}
	else
	{
		if(g_vs.lastTip)
		{
			g_vs.lastTip.hide();
		}

		this.src = el;
		this.win.moveto(-10000, -10000);
		this.win.show();
		g_vs.lastTip = this;

        //var y = parseInt(event.clientY) + 3;
		this.tid = window.setTimeout("if(g_vs.lastTip) g_vs.lastTip.innerShow(" + event.clientX + "," + event.clientY + ");", 10);
	}
}

function tip_innerShow(x, y)
{
	var offset = g_vs.getElementOffset(this.src);
	var left = x - 5;
	var top = y - this.win.div.offsetHeight + 5;
	
	if((left + this.win.div.offsetWidth) > document.body.clientWidth)
	{
		left = document.body.clientWidth - this.win.div.offsetWidth - 5;
	}

	if(top < 0)
	{
		top = y - 5;
	}

	left += document.body.scrollLeft;
	top += document.body.scrollTop;

	g_vs.bringElementToFront(this.win.shade);
	g_vs.bringElementToFront(this.win.div);
	this.win.moveto(left, top);

	this.oldonmousemove = document.body.onmousemove;
	document.body.onmousemove = tip_onmousemove;
}

function tip_hide()
{
	if(this.tid != 0)
	{
		window.clearTimeout(this.tid);
		this.tid = 0;
	}
	else
	{
		document.body.onmousemove = this.oldonmousemove;
	}
	
	
	this.win.hide();
	this.win.moveto(-10000, -10000);
	g_vs.lastTip = null;
}

function tip_destroy()
{
	this.win.destroy();
}

function tip_onmousemove()
{
	var el = event.srcElement;
	var tip = g_vs.lastTip;
	
	if(tip && tip.src != el)
	{
		if(!g_vs.isAnyLevelParent(el, tip.win.div))
		{
			tip.hide();
		}
	}
}
