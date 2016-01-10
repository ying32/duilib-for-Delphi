var VS_PAD = "5px";
var VS_SB = ".vsBody{scrollbar-3dlight-color:#8EA5CE;scrollbar-arrow-color:#072E8B;sc rollbar-base-color:red;scrollbar-face-color:#E7EEF6;scrollbar-highlight-color:#E7EEF6;scrollbar-darkshadow-color:#E7EEF6;scrollbar-shadow-color:#8EA5CE;scrollbar-track-color:white;}";

// Page Body, Header and Footer
var g_noHeader = true;
var g_noFooter = false;
var g_vsWidth = "100%";
var g_vsHeight = "100%";
var g_loginId;
var g_isLogin;
var g_vsMenuTb = null;

function vs_createBody()
{
	var w = 980;
	
	if(typeof(g_vsWidth) == "string")
	{
		w = g_vsWidth;
		g_vs.width = w;
	}
	else
	{
		if(g_vsWidth >= 0)
		{
			w = g_vsWidth;
		}
		
		g_vs.width = w;
		w += "px";
	}
	
	if(g_isIE)
	{
		g_vs.addCSS(VS_SB);
	}
	
	//vs_refreshMenuIndex(g_vs.pageName);
	
	var html = "";
	
	if(!g_noHeader)
	{
		html += "<div class=topBK></div>";
	}
	
	html += "<center><TABLE border=0 cellSpacing=0 cellPadding=0 width='" + w + "' height='" + g_vsHeight + "'>";
	
	if(!g_noHeader)
	{
		html += "<TR height='120px'><TD id=vsTop width='100%'></TD></TR>";
	}

	html += "<TR><TD width='100%' height='100%' valign=top><center><div id=vsDesktop class=BK></div></center></TD></TR>";
		
	html += "</TABLE></center>";

	document.body.insertAdjacentHTML("afterBegin", html);
}

function vs_changeLang(lang)
{
	if(g_vs)
	{
		g_vs.setCookie("lang", lang, 527040);
		document.location.reload();
	}
	
	return false;
}
