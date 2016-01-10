var tracewin = null;
var tracenum = 1;
var g_traceOpen = false;

function createTraceWin()
{
   if(g_traceOpen)
   {
        if(tracewin == null)
       {
            tracewin = window.open('about:blank', 'tracewin');      
       }
   }
}

 function trace(str){
   if(g_traceOpen)
   {
   	 if(tracewin)
  	 {
       tracewin.document.write(tracenum++ + ": " + str + "<br>");
       tracewin.window.scrollTo(0, tracewin.document.body.scrollHeight);
   	 }
   }
}

function getTime(){
    if(g_traceOpen)
    {
        var now= new Date();
        var strTime= now.toLocaleTimeString()+':'+ (now%1000);
        return strTime;  
    } 
}

function traceTime(info){
    if(g_traceOpen)
    {
        var strInfo = getTime()+':'+ info;
        trace(strInfo);  
    }
}

function traceHTML(){
    if(g_traceOpen)
    {
        var obj = document.body;
        while(obj && obj.tagName != 'HTML')
        {
           obj = obj.parentElement;
        }
        trace(obj.outerHTML);  
    }
  
}

function traceObj(obj){
    if(g_traceOpen)
    {
        var strObj='obj:'+obj+'<br>';
        for(prop in obj)
        {
            if(obj[prop])
                strObj += ('\t'+prop +'='+obj[prop]+';<br>');
        }   
        trace(strObj);
        return strObj;
    }
}

function format()
{
  if(g_traceOpen)
  {
          var i, msg = "", argNum = 0, startPos;
          var args = format.arguments;
          var numArgs = args.length;
          if(numArgs)
          {
            str = args[argNum++];
            startPos = 0; 
            endPos = str.indexOf("%s",startPos);
            if(endPos == -1)
            {
                endPos = str.length;
            }
            
            while(startPos < str.length)
            {
              msg += str.substring(startPos,endPos);
              if (argNum < numArgs)
              {
                 msg += args[argNum++];
              }
              startPos = endPos+2;
              endPos = str.indexOf("%s",startPos);
              if (endPos == -1)
              {
                 endPos = str.length;
              }
            }
            if (!msg) msg = args[0];
          }
          return msg;
  }  
}





