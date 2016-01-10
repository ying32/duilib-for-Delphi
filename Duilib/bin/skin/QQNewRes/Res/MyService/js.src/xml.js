// XML
var VS_EVT_REQ = "onsendrequest";

vs_addModule(vs_registerXMLModule);

function vs_registerXMLModule(vs)
{
	vs.xmlObjects = new Array();
	vs.xmlObjectIndex = 1;

	vs.sendRequest = vs_sendRequest;
	vs.createXMLObject = vs_createXMLObject;
	
	if(g_isFF)
	{
		document.getElementByIdOld = document.getElementById;
		document.getElementById = ff_doc_getElementById;
		XMLDocument.prototype.selectNodes = ff_xml_selectNodes;
		XMLDocument.prototype.selectSingleNode = ff_xml_selectSingleNode;
		Element.prototype.selectNodes = ff_xml_el_selectNodes;
		Element.prototype.selectSingleNode = ff_xml_el_selectSingleNode;
		Element.prototype.__defineGetter__("text", ff_xml_el_get_text);
	}
}

function vs_sendRequest(url, method, data, onxmlloaded, param)
{
	var obj = this.createXMLObject();
	var result = null;
	var async = false;
	var key;
	
	if(obj)
	{
		if(onxmlloaded)
		{
			async = true;
			key = this.xmlObjectIndex++;
			this.xmlObjects[key] = obj;

			eval("obj.xmlHTTP.onreadystatechange = function(){if(typeof(xml_onreadystatechange) == 'function'){xml_onreadystatechange(" + key + ");}};");
			obj.onxmlloaded = onxmlloaded;
			obj.param = param;
		}

		if(!method)
		{
			method = "GET";
			data = "";
		}

		if(url.indexOf("?") == -1)
		{
			url += "?";
		}
		
		url += "t=" + Math.random().toString().substr(2);
		obj.xmlHTTP.open(method, url, async);
		
		if(data != "")
		{
			obj.xmlHTTP.setRequestHeader("Content-Type", "text/plain; charset=utf-8");
		}
		else
		{
			obj.xmlHTTP.setRequestHeader("Content-Length", "0");
		}
		
		obj.xmlHTTP.send(data);

		if(async)
		{
			result = true;
		}
		else
		{
			result = obj.innerGetXML();
		}
	}

	this.fireEvent(VS_EVT_REQ, obj);
	
	return result;
}

function vs_createXMLObject()
{
	var obj = new Object();
	
	if(obj)
	{
		obj.innerGetXML = xml_innerGetXML;

		obj.xmlHTTP = vs_getXMLHTTP();
		
		if(!(obj.xmlHTTP))
		{
			obj = null;
		}
	}
	
	return obj;
}

function vs_getXMLHTTP()
{
	var xmlHTTP = null;
	
	try
	{
		if(g_isIE)
		{
			xmlHTTP = new ActiveXObject("Microsoft.XMLHTTP");
		}
		else if(g_isFF)
		{
			xmlHTTP = new XMLHttpRequest(); 
		}
	}
	catch(e)
	{
	}
	
	try
	{
		if(g_isIE && !xmlHTTP)
		{
			xmlHTTP = new ActiveXObject("MSXML2.XMLHTTP");
		}
	}
	catch(e)
	{
	}

	return xmlHTTP;
}

function xml_innerGetXML()
{
	var result = null;

	if(this.xmlHTTP.status == 200 && this.xmlHTTP.getResponseHeader("Content-Type").substr(0, 8) == "text/xml")
	{
		if(g_isIE)
		{
			result = this.xmlHTTP.responseXML.cloneNode(true);
		}
		else if(g_isFF)
		{
			result = ff_xml_fromText(this.xmlHTTP.responseText);
		}

		g_vs.addGarbage(this.xmlHTTP);
		this.xmlHTTP = null;
	}
				
	return result;
}

function xml_onreadystatechange(key)
{
	var xml = null;
	var obj = g_vs.xmlObjects[key];

	if(obj && obj.xmlHTTP && obj.xmlHTTP.readyState == 4 && typeof(obj.onxmlloaded) == "function")
	{
		g_vs.xmlObjects[key] = null;
		
		if(obj.xmlHTTP.status == 200)
		{
			xml = obj.innerGetXML();
		}

		obj.onxmlloaded(xml, obj.param);
	}
}

function ff_getDecodeXML(text)
{
	var s = "";
	var last = 0;
	var i = 0;
	var len = text.length - 1;
	var buf;
	var j;
	var ch;
	var cc;

	while(i < len)
	{
		ch = text[i];
		i++;
		
		if(ch == '!')
		{
			if(text[i] == '!')
			{
				i++;
			}
			else
			{
				j = text.indexOf(";", i);
				if(j > 0)
				{
					buf = text.substring(i, j);
					cc = parseInt(buf, 16);
					
					if(!isNaN(cc))
					{
						s += text.substring(last, i - 1) +  String.fromCharCode(cc);
						i = j + 1;
						last = i;
					}
				}
			}
		}
	}
	
	s += text.substr(last);
	s = s.replace(/!!/g, "!");
	
	return s;
}

function ff_getEncodeXML(text)
{
	text = text.replace(/!/g, "!!");

	var s = "";
	var last = 0;
	var i = 0;
	var len = text.length;
	var cc;

	while(i < len)
	{
		cc = text.charCodeAt(i);
		i++;
		
		if(cc >= 0 && cc < 0x20 && cc != 13 && cc != 10 && cc != 9)
		{
			s += text.substring(last, i - 1) + "!" + cc.toString(16) + ";";
			last = i;
		}
	}
	
	s += text.substr(last);
	return s;
}

function ff_xml_fromText(text)
{
	var dp = new DOMParser();
	var xml = null;

	if(dp)
	{
		xml = dp.parseFromString(ff_getEncodeXML(text), "text/xml");
	}

	return xml;
}

function ff_doc_getElementById(id)
{
	var el = document.getElementByIdOld(id);
	var header = '<?xml version="1.0" encoding="utf-8" ?>';
	
	if(el && el.tagName == "XML")
	{
		el = ff_xml_fromText(header + el.innerHTML);
	}
	
	return el;
}

function ff_xml_selectNodes(xpath, maxNodes)
{
	if(!maxNodes)
	{
		maxNodes = 10000;
	}

	var i;
	var nsr = this.createNSResolver(this.documentElement);
	var items = this.evaluate(xpath, this, nsr, XPathResult.ORDERED_NODE_SNAPSHOT_TYPE, null);
	var nodes = new Array();
	maxNodes = Math.min(items.snapshotLength, maxNodes);
	
	for(i = 0; i < maxNodes; i++)
	{
		nodes[i] =  items.snapshotItem(i);
	}
	
	nodes.i = 0;
	nodes.nextNode = ff_xml_node_nextNode;
	
	return nodes;
}

function ff_xml_selectSingleNode(xpath)
{
	var nodes = this.selectNodes(xpath, 1);
	return nodes.nextNode();
}

function ff_xml_el_selectNodes(xpath, maxNodes)
{
	if(!maxNodes)
	{
		maxNodes = 10000;
	}

	var arrXPath = xpath.split('/');
	var nodes = new Array();
	
	ff_xml_el_findNodes(this.childNodes, arrXPath, 0, nodes, maxNodes);
	
	nodes.i = 0;
	nodes.nextNode = ff_xml_node_nextNode;

	return nodes;
}

function ff_xml_el_findNodes(childNodes, arrXPath, deep, nodes, maxNodes)
{
	var node;
	var i;
	var name = arrXPath[deep];
	for(i = 0; i < childNodes.length; i++)
	{
		if(nodes.length >= maxNodes)
		{
			break;
		}

		node = childNodes[i];
		if(node.nodeName == name)
		{
			if(deep < arrXPath.length - 1)
			{
				ff_xml_el_findNodes(node.childNodes, arrXPath, deep + 1, nodes, maxNodes);
			}
			else
			{
				nodes.push(node);
			}
		}
	}
}

function ff_xml_el_selectSingleNode(xpath)
{
	var nodes = this.selectNodes(xpath, 1);
	return nodes.nextNode();
}

function ff_xml_el_get_text()
{
	return ff_getDecodeXML(this.textContent);
}

function ff_xml_node_nextNode()
{
	var node = null;
	if(this.i < this.length)
	{
		node = this[this.i];
		this.i++;
	}
	
	return node;
}
