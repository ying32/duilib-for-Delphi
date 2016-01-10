// ImageFactory
var vs_ifIndex = 0;
var vs_ifLoading = false;
var vs_ifPA = new Array();

vs_addModule(vs_registerImageFactoryModule);

function vs_registerImageFactoryModule(vs)
{
	vs.imgFactory = vs_createImageFactory();
}

function vs_createImageFactory()
{
	var fact = new Object();
	if(fact)
	{
		// method
		fact.newImage = if_newImage;
		fact.changeImg = if_changeImg;
		fact.findFirstImage = if_findFirstImage;
		fact.createFirstImage = if_createFirstImage;
		fact.getFirstImage = if_getFirstImage;

		// attributes
		fact.imgCache = new Array();
		
		if(!fact.imgCache)
		{
			fact = null;
		}
	}
	
	return fact;
}

function fact_loadFirst()
{
	var img;
	vs_ifLoading = false;

	for(; vs_ifIndex < vs_ifPA.length; vs_ifIndex++)
	{
		img = vs_ifPA[vs_ifIndex];
		img.src = img.src0;
	}
}

function fact_addFirst(img)
{
	vs_ifPA[vs_ifPA.length] = img;
	
	if(vs_ifIndex < vs_ifPA.length)
	
	if(!vs_ifLoading)
	{
		vs_ifLoading = true;
		window.setTimeout("fact_loadFirst();", 100);
	}
}

function if_newImage(imgUrl, width, height, onload, param)
{
	var img = document.createElement("IMG");
	var imgFirst = null;

	if(typeof(imgUrl) == "string")
	{
		if(img)
		{
			if(width)
			{
				img.style.width = width + "px";
			}
			
			if(height)
			{
				img.style.height = height + "px";
			}

			if(typeof(onload) == "function")
			{
				img.onload = onload;
			}
			
			img.param = param;
			img.initvisible = true;
			img.src0 = imgUrl;

			imgFirst = this.getFirstImage(imgUrl);
			if(imgFirst)
			{
				img.style.visibility = "hidden";
				imgFirst.appendPending(img);
			}
			else
			{
				img.src = imgUrl;
			}
		}
	}
	
	return img;
}

function if_changeImg(el, imgUrl, back)
{
	var imgFirst = null;

	if(typeof(el) == "string")
	{
		el = document.getElementById(el);
	}
	
	if(typeof(imgUrl) == "string")
	{
		if(el)
		{
			el.src0 = imgUrl;
			imgFirst = this.getFirstImage(imgUrl);
			
			if(imgFirst)
			{
				el.back = back;
				imgFirst.appendPending(el);
			}
			else
			{
				if(back)
				{
					el.style.backgroundImage = "url(" + g_vs.encodeURI(imgUrl) + ")";
				}
				else
				{
					el.src = imgUrl;
				}
			}
		}
	}
	
	return el;
}

function if_createFirstImage(imgUrl)
{
	var imgFirst = document.createElement("IMG");
	
	if(imgFirst)
	{
		imgFirst.style.display = "none";
		imgFirst.onerror = if_img_onerror;
		
		if(g_isIE)
		{
			imgFirst.onreadystatechange = if_img_onreadystatechange;
		}
		else if(g_isFF)
		{
			imgFirst.onload = if_img_onload;
		}
		
		imgFirst.appendPending = if_img_appendPending;
		imgFirst.processPendingList = if_img_processPendingList;
		imgFirst.pendingList = new Array();
		imgFirst.isFirst = true;
		imgFirst.retry = 1;
		
		document.body.appendChild(imgFirst);
		
		if(!imgFirst.pendingList)
		{
			imgFirst = null;
		}
		else
		{
			this.imgCache[imgUrl] = imgFirst;
			imgFirst.src0 = imgUrl;
			fact_addFirst(imgFirst);
		}
	}
	
	return imgFirst;
}

function if_findFirstImage(imgUrl)
{
	var imgFirst = this.imgCache[imgUrl];
	
	return imgFirst;
}

function if_getFirstImage(imgUrl)
{
	var imgFirst = this.findFirstImage(imgUrl);
	
	if(!imgFirst)
	{
		imgFirst = this.createFirstImage(imgUrl);
	}
	
	return imgFirst;
}
function if_img_onload()
{
	this.readyState = "complete";
	this.processPendingList();
}

function if_img_onreadystatechange()
{
	this.processPendingList();
}

function if_img_appendPending(el)
{
	this.pendingList.push(el);
	this.processPendingList();
}

function if_img_onerror()
{
//	if(typeof(this.retry) == "number")
//	{
//		this.retry++;

//		if(this.retry <= 3)
//		{
//			this.src = this.src;
//		}
//	}
}

function if_img_processPendingList()
{
	var el = null;
	
	if(this.readyState == "complete")
	{
		while(el = this.pendingList.pop())
		{
			if(el.src0 == this.src0)
			{
				if(el.back)
				{
					el.style.backgroundImage = "url(" + g_vs.encodeURI(this.src) + ")";
				}
				else
				{
				    if(el.initvisible)
					    el.style.visibility = "inherit";
					else
					    el.style.visibility = "hidden";
					    
					el.src = this.src;
				}
			}
		}
	}
}
