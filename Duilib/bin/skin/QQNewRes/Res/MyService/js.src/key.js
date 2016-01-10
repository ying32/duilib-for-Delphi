// Key Filter Processing
var VS_KEY_BACKSPACE = 8;
var VS_KEY_TAB = 9;
var VS_KEY_ENTER = 13;
var VS_KEY_PAGEUP = 33;
var VS_KEY_PAGEDOWN = 34;
var VS_KEY_END = 35;
var VS_KEY_HOME = 36;
var VS_KEY_LEFT = 37;
var VS_KEY_UP = 38;
var VS_KEY_RIGHT = 39;
var VS_KEY_DOWN = 40;
var VS_KEY_INSERT = 45;
var VS_KEY_DEL = 46;
var VS_KEY_0 = 48;
var VS_KEY_9 = 57;
var VS_KEY_NUM0 = 96;
var VS_KEY_NUM9 = 105;
var VS_KEY_NUMSUB = 109;
var VS_KEY_NUMDOT = 110;
var VS_KEY_SUB = 189;
var VS_KEY_DOT = 190;
var VS_KEY_A = 65;
var VS_KEY_Z = 90;
var VS_KEY_SPACE = 32;
var VS_KEY_IME = 229;

var VS_FT_LONG = "long";
var VS_FT_ULONG = "ulong";
var VS_FT_FLOAT= "float";
var VS_FT_UFLOAT = "ufloat";
var VS_FT_TAG = "tag";

vs_addModule(vs_registerKeyBoardModule);

function vs_registerKeyBoardModule(vs)
{
	vs.onkeyfilter = vs_onkeyfilter;
}

function vs_key_valid(s0)
{
	var i;
	var s = "";
	var ch;
	
	for(i = 0; i < s0.length; i++)
	{
		ch = s0.charAt(i);
		if((ch >= 'a' && ch <= 'z') || (ch >= 'A' && ch <= 'Z') || (ch >= '0' && ch <= '9') || (ch == ' ') || (ch >= String.fromCharCode(0x3041) && ch < String.fromCharCode(0xFE30)))
		{
			s += ch;
		}
	}
	
	return s;
}

function vs_txt_onpaste()
{
	var b = true;
	var el = event.srcElement;
	var s = el.value;

	if(el.maxlen >= 0)
	{
		if(el.ansi)
		{
			b = s.BLength() < el.maxlen;
		}
		else
		{
			b = s.UTF8Length() < el.maxlen;
		}
	}

	if(typeof(el.oldonpaste) == "function")
	{
		b = el.oldonpaste() && b;
	}

	return b;
}

function vs_txt_onchange()
{
	var b;
	var el = event.srcElement;
	var s = el.value;
	var x;

	switch(el.filterType)
	{
		case VS_FT_LONG:
		case VS_FT_ULONG:
			x = parseInt(s, 10);
			break;
		case VS_FT_FLOAT:
		case VS_FT_UFLOAT:
			x = parseFloat(s);
			break;
		default:
			x = 0;
			break;
	}

	if(isNaN(x))
	{
		if(typeof(el.defValue) == "undefined")
		{
			el.defValue = 0;
		}

		s = el.defValue.toString();
	}
	else
	{
		switch(el.filterType)
		{
			case VS_FT_LONG:
			case VS_FT_FLOAT:
				s = x.toString();
				break;
			case VS_FT_ULONG:
			case VS_FT_UFLOAT:
				s = Math.abs(x).toString();
				break;
			case VS_FT_TAG:
				s = vs_key_valid(s);
				break;
			default:
				break;
		}
	}
	
	if(el.maxlen >= 0)
	{
		if(el.ansi)
		{
			s = s.BTrunc(el.maxlen);
		}
		else
		{
			s = s.UTF8Trunc(el.maxlen);
		}
	}

	if(s != el.value)
	{
		el.value = s;
		b = false;
	}
	else
	{
		b = true;
	}
	
	if(typeof(el.oldonchange) == "function")
	{
		b = el.oldonchange() && b;
	}

	return b;
}

function vs_onkeyfilter(type, maxlen, ansi)
{
	var el = event.srcElement;
	var b = false;
	var s = el.value;
	var key = event.keyCode;
	var shift = event.shiftKey;
	var alt = event.altKey;
	var ctrl = event.ctrlKey;
	maxlen = parseInt(maxlen, 10);

	if(isNaN(maxlen))
	{
		maxlen = -1;
	}

	el.filterType = type;
	el.maxlen = maxlen;
	el.ansi = ansi;
	
	if(el.onchange != vs_txt_onchange)
	{
		el.oldonchange = el.onchange;
		el.onchange = vs_txt_onchange;
	}
	
	if(el.onpaste != vs_txt_onpaste)
	{
		el.oldonpaste = el.onpaste;
		el.onpaste = vs_txt_onpaste;
	}
	
	if(alt || ctrl || key == VS_KEY_BACKSPACE || key == VS_KEY_TAB || key == VS_KEY_LEFT || key == VS_KEY_UP || key == VS_KEY_RIGHT || key == VS_KEY_DOWN || key == VS_KEY_PAGEUP || key == VS_KEY_PAGEDOWN || key == VS_KEY_HOME || key == VS_KEY_END || key == VS_KEY_DEL || key == VS_KEY_ENTER)
	{
		b = true;
	}
	else
	{
		switch(type)
		{
			case VS_FT_LONG:
				b = (key == VS_KEY_SUB || key == VS_KEY_NUMSUB) || (key >= VS_KEY_0 && key <= VS_KEY_9 && !shift) || (key >= VS_KEY_NUM0 && key <= VS_KEY_NUM9) || (key == VS_KEY_IME);
				break;
			case VS_FT_ULONG:
				b = (key >= VS_KEY_0 && key <= VS_KEY_9 && !shift) || (key >= VS_KEY_NUM0 && key <= VS_KEY_NUM9) || (key == VS_KEY_IME);
				break;
			case VS_FT_FLOAT:
				b = (key >= VS_KEY_0 && key <= VS_KEY_9 && !shift) || (key >= VS_KEY_NUM0 && key <= VS_KEY_NUM9) || key == VS_KEY_SUB || key == VS_KEY_DOT || key == VS_KEY_NUMSUB || key == VS_KEY_NUMDOT || (key == VS_KEY_IME);
				break;
			case VS_FT_UFLOAT:
				b = (key >= VS_KEY_0 && key <= VS_KEY_9 && !shift) || (key >= VS_KEY_NUM0 && key <= VS_KEY_NUM9) || key == VS_KEY_DOT || key == VS_KEY_NUMDOT || (key == VS_KEY_IME);
				break;
			case VS_FT_TAG:
				b = (key >= VS_KEY_0 && key <= VS_KEY_9 && !shift) || (key >= VS_KEY_NUM0 && key <= VS_KEY_NUM9) || (key >= VS_KEY_A && key <= VS_KEY_Z) || (key == VS_KEY_SPACE) || (key == VS_KEY_IME);
				break;
			default:
				b = true;
				break;
		}

		if(b && maxlen >= 0)
		{
			if(ansi)
			{
				maxlen -= s.BLength();
			}
			else
			{
				maxlen -= s.UTF8Length();
			}
			
			if(key < 0x20)
			{
			}
			else if(key < 0x80 || key == VS_KEY_IME)
			{
				maxlen--;
			}
			else
			{
				if(ansi)
				{
					maxlen -= 2;
				}
				else
				{
					maxlen -= 3;
				}
			}

			if(maxlen < 0)
			{
				b = false;
			}
		}
	}

	event.cancelBubble = true;

	return b;
}
