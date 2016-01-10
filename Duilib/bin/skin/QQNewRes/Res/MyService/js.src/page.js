// Page

vs_addModule(vs_registerPageModule);

function vs_registerPageModule(vs)
{
	var page = new Object();
	page.pages =  new Array();
	page.refresh = page_refresh;
	page.getHRef = page_getHRef;
	page.register = page_register;
	page.getPageNo = page_getPageNo;
	page.getPageNos = page_getPageNos;
	page.changePage = page_changePage;
	
	vs.page = page;
}

function page_register(pageName)
{
	this.pages.push(pageName);
	
	if(g_isFF && typeof(this.hash) == "undefined")
	{
		this.hash = null;
		page_watchPageChange();
	}
}

function page_watchPageChange()
{
	var nos;
	var page = g_vs.page;
	var hash = window.location.hash;
	
	if(page)
	{
		if(hash == "")
		{
			nos = page.getPageNos();
			hash = page.getHRef(nos);
		}
		
		if(page.hash == null)
		{
			page.hash = hash;
		}
		
		if(page.hash != hash)
		{
			page.hash = hash;
			page.changePage(hash);
		}
		
		window.setTimeout("page_watchPageChange();", 200);
	}
}

function page_changePage(hash)
{
	var links = document.getElementsByTagName("A");
	var i;
	
	if(links)
	{
		for(i = 0; i < links.length; i++)
		{
			if(links[i] && links[i].phash == hash)
			{
				if(typeof(links[i].onclick) == "function")
				{
					links[i].onclick();
					break;
				}
			}
		}
	}
}

function page_refresh()
{
	var nos = this.getPageNos();
	var links = document.getElementsByTagName("A");
	var href;
	var a;
	var i;
	
	if(nos && links)
	{
		for(i = 0; i < links.length; i++)
		{
			a = links[i];

			a.pageName = a.getAttribute("pageName");
			a.pageNo = a.getAttribute("pageNo");
			
			if(a && a.pageName)
			{
				href = this.getHRef(nos, a.pageName, a.pageNo);
				
				if(g_isFF)
				{
					a.id = href;
				}
				
				a.phash = href;
				a.href = href;
			}
		}
	}
}

function page_getHRef(nos, pageName, pageNo)
{
	var s = "#";
	var n;
	pageNo = parseInt(pageNo, 10);
	
	if(isNaN(pageNo))
	{
		pageNo = 1;
	}
	
	for(n in nos)
	{
		if(n == pageName)
		{
			s += pageName + pageNo;
		}
		else
		{
			s += n + nos[n];
		}
	}
	
	return s;
}

function page_getPageNo(pageName)
{
	var nos = this.getPageNos(pageName);
	var pageNo = 1;
	
	if(nos)
	{
		pageNo = parseInt(nos[pageName]);
		
		if(isNaN(pageNo))
		{
			pageNo = 1;
		}
	}
	
	return pageNo;
}

function page_getPageNos()
{
	var nos = new Object();
	
	var hash = window.location.hash;
	var pageName;
	var pageNo;
	var i;
	var n;
	
	
	for(i = 0; i < this.pages.length; i++)
	{
		pageNo = 1;
		pageName = this.pages[i];
		n = hash.indexOf(pageName);
		if(n >= 0)
		{
			pageNo = parseInt(hash.substr(n + pageName.length), 10);
			if(isNaN(pageNo) || pageNo <= 0)
			{
				pageNo = 1;
			}
		}
		
		nos[pageName] = pageNo;
	}

	return nos;
}
