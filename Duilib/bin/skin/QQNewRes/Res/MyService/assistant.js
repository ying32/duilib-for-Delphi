//构造函数(前一个参数目前没用)
//iframeID和页面设置的document的title取同样的值，均为url中pageid参数的值
function Assistant(marker, iframeID)
{
	this.marker = marker;
	this.iframeID = iframeID;
	external.registerIFrame(marker, iframeID);
};

/////////////////////////////////////////////////////////////////////////////
//以下为IFrame向hummer请求的数据
Assistant.prototype.getIFrameKey = function()//得到32位增值签名
{
	return external.getIFrameKey(this.iframeID);
};

///////////////////////////////////////////////////////////////////////////
//以下为Frame设置, 在框架起作用的接口
//设置frame的高度；框架会根据设置的高度调整frame的实际高度，防止滚动条的出现
Assistant.prototype.setIFrameHeight = function(iframeHeight){
	return external.setIFrameHeight(this.iframeID, iframeHeight.toString());
};

Assistant.prototype.setIFrameTitleIcon = function(iconPath)//设置iframe的title{
{
	return external.setIFrameTitleIcon(this.iframeID, iconPath);
};

Assistant.prototype.setIFrameTitleText = function(titleText)//可以按照HTML格式写，从而带上链接
{
	return external.setIFrameTitleText(this.iframeID, titleText);
};

Assistant.prototype.setIFrameTitleButton = function(hasEdit, hasRefresh, hasVar1, hasVar2)//由页面自己决定是否在title上显示编辑按钮和刷新按钮
{
    return external.setIFrameTitleButton(this.iframeID, hasEdit, hasRefresh, hasVar1, hasVar2);
};



