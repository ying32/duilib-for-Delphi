function windowHelper()
{
	
};

windowHelper.prototype.requestIFrames = function()
{
	return external.requestIFrames();
};

windowHelper.prototype.saveIFrameConfigInfo = function(iframeID, bVisible, iframeYPoint,  bToggle)
{
    return external.saveIFrameConfigInfo(iframeID, bVisible, iframeYPoint,  bToggle);
};

windowHelper.prototype.toggleIFrame = function(iframeID, bToggle)
{
    return external.toggleIFrame(iframeID, bToggle);
};

windowHelper.prototype.refreshIFrame = function(iframeID)
{
    if(!external.refreshIFrame(iframeID))
    {
         //g_vs.windows[iframeID].iframe.location.reload();
        g_vs.windows[iframeID].iframe.src = g_subPageInfoArray[iframeID].iframeUrl;
    }
};

windowHelper.prototype.showIFrameEditZone = function(iframeID)
{
    return external.showIFrameEditZone(iframeID);
};

windowHelper.prototype.canAlert = function(canAlert)
{
	return external.canAlert(canAlert);
};

