SEP_PADDING = 5
HANDLE_PADDING = 7

var yToolbars =	new Array();
var YInitialized = false;
var bLoad=false
var pureText=true
var bodyTag="<head><style type=\"text/css\">body {font-size:9pt}</style><meta http-equiv=Content-Type content=\"text/html; charset=gb2312\"></head><BODY bgcolor=\"#FFFFFF\" MONOSPACE>"
var bTextMode=false

public_description=new Editor

function document.onreadystatechange(){
  if (YInitialized) return;
  YInitialized = true;

  var i, s, curr;

  for (i=0; i<document.body.all.length;	i++)
  {
    curr=document.body.all[i];
    if (curr.className == "yToolbar")
    {
      InitTB(curr);
      yToolbars[yToolbars.length] = curr;
    }
  }

  DoLayout();
  window.onresize = DoLayout;

  HtmlEdit.document.open();
  HtmlEdit.document.write(bodyTag);
  HtmlEdit.document.close();
  HtmlEdit.document.designMode="On";
}

function InitBtn(btn)
{
  btn.onmouseover = BtnMouseOver;
  btn.onmouseout = BtnMouseOut;
  btn.onmousedown = BtnMouseDown;
  btn.onmouseup	= BtnMouseUp;
  btn.ondragstart = YCancelEvent;
  btn.onselectstart = YCancelEvent;
  btn.onselect = YCancelEvent;
  btn.YUSERONCLICK = btn.onclick;
  btn.onclick =	YCancelEvent;
  btn.YINITIALIZED = true;
  return true;
}

function InitTB(y)
{
  y.TBWidth = 0;

  if (!	PopulateTB(y)) return false;

  y.style.posWidth = y.TBWidth;

  return true;
}


function YCancelEvent()
{
  event.returnValue=false;
  event.cancelBubble=true;
  return false;
}

function PopulateTB(y)
{
  var i, elements, element;

  elements = y.children;
  for (i=0; i<elements.length; i++) {
    element = elements[i];
    if (element.tagName	== "SCRIPT" || element.tagName == "!") continue;

    switch (element.className) {
      case "Btn":
        if (element.YINITIALIZED == null)	{
          if (! InitBtn(element))
          return false;
        }
        element.style.posLeft = y.TBWidth;
        y.TBWidth	+= element.offsetWidth + 1;
        break;

      case "TBGen":
        element.style.posLeft = y.TBWidth;
        y.TBWidth	+= element.offsetWidth + 1;
        break;

      case "TBSep":
        element.style.posLeft = y.TBWidth	+ 2;
        y.TBWidth	+= SEP_PADDING;
        break;

      case "TBHandle":
        element.style.posLeft = 2;
        y.TBWidth	+= element.offsetWidth + HANDLE_PADDING;
        break;

      default:
        return false;
      }
  }

  y.TBWidth += 1;
  return true;
}

function DebugObject(obj)
{
  var msg = "";
  for (var i in	TB) {
    ans=prompt(i+"="+TB[i]+"\n");
    if (! ans) break;
  }
}

function LayoutTBs()
{
  NumTBs = yToolbars.length;

  if (NumTBs ==	0) return;

  var i;
  var ScrWid = (document.body.offsetWidth) - 6;
  var TotalLen = ScrWid;
  for (i = 0 ; i < NumTBs ; i++) {
    TB = yToolbars[i];
    if (TB.TBWidth > TotalLen) TotalLen	= TB.TBWidth;
  }

  var PrevTB;
  var LastStart	= 0;
  var RelTop = 0;
  var LastWid, CurrWid;
  var TB = yToolbars[0];
  TB.style.posTop = 0;
  TB.style.posLeft = 0;

  var Start = TB.TBWidth;
  for (i = 1 ; i < yToolbars.length ; i++) {
    PrevTB = TB;
    TB = yToolbars[i];
    CurrWid = TB.TBWidth;

    if ((Start + CurrWid) > ScrWid) {
      Start = 0;
      LastWid =	TotalLen - LastStart;
    }
    else {
       LastWid =	PrevTB.TBWidth;
       RelTop -=	TB.offsetHeight;
    }

    TB.style.posTop = RelTop;
    TB.style.posLeft = Start;
    PrevTB.style.width = LastWid;

    LastStart =	Start;
    Start += CurrWid;
  }

  TB.style.width = TotalLen - LastStart;

  i--;
  TB = yToolbars[i];
  var TBInd = TB.sourceIndex;
  var A	= TB.document.all;
  var item;
  for (i in A) {
    item = A.item(i);
    if (! item)	continue;
    if (! item.style) continue;
    if (item.sourceIndex <= TBInd) continue;
    if (item.style.position == "absolute") continue;
    item.style.posTop =	RelTop;
  }
}

function DoLayout()
{
  LayoutTBs();
}

function BtnMouseOver()
{
  if (event.srcElement.tagName != "IMG") return	false;
  var image = event.srcElement;
  var element =	image.parentElement;

  if (image.className == "Ico")	element.className = "BtnMouseOverUp";
  else if (image.className == "IcoDown") element.className = "BtnMouseOverDown";

  event.cancelBubble = true;
}

function BtnMouseOut()
{
  if (event.srcElement.tagName != "IMG") {
    event.cancelBubble = true;
    return false;
  }

  var image = event.srcElement;
  var element =	image.parentElement;
  yRaisedElement = null;

  element.className = "Btn";
  image.className = "Ico";

  event.cancelBubble = true;
}

function BtnMouseDown()
{
  if (event.srcElement.tagName != "IMG") {
    event.cancelBubble = true;
    event.returnValue=false;
    return false;
  }

  var image = event.srcElement;
  var element =	image.parentElement;

  element.className = "BtnMouseOverDown";
  image.className = "IcoDown";

  event.cancelBubble = true;
  event.returnValue=false;
  return false;
}

function BtnMouseUp()
{
  if (event.srcElement.tagName != "IMG") {
    event.cancelBubble = true;
    return false;
  }

  var image = event.srcElement;
  var element =	image.parentElement;

  if (element.YUSERONCLICK) eval(element.YUSERONCLICK +	"anonymous()");

  element.className = "BtnMouseOverUp";
  image.className = "Ico";

  event.cancelBubble = true;
  return false;
}

function getEl(sTag,start)
{
  while	((start!=null) && (start.tagName!=sTag)) start = start.parentElement;
  return start;
}

function cleanHtml()
{
  var fonts = HtmlEdit.document.body.all.tags("FONT");
  var curr;
  for (var i = fonts.length - 1; i >= 0; i--) {
    curr = fonts[i];
    if (curr.style.backgroundColor == "#ffffff") curr.outerHTML	= curr.innerHTML;
  }
}

function getPureHtml()
{
  var str = "";
  var paras = HtmlEdit.document.body.all.tags("P");
  if (paras.length > 0)	{
    for	(var i=paras.length-1; i >= 0; i--) str	= paras[i].innerHTML + "\n" + str;
  }
  else {
    str	= HtmlEdit.document.body.innerHTML;
  }
  return str;
}


function Editor()
{
  this.put_HtmlMode=setMode;
  this.put_value=putText;
  this.get_value=getText;
}

function getText()
{
  if (bTextMode)
    return HtmlEdit.document.body.innerText;
  else
  {
    cleanHtml();
    cleanHtml();
    return HtmlEdit.document.body.innerHTML;
  }
}

function putText(v)
{
  if (bTextMode)
    HtmlEdit.document.body.innerText = v;
  else
    HtmlEdit.document.body.innerHTML = v;
}

function UserDialog(what)
{
  if (!validateMode()) return;

  HtmlEdit.document.execCommand(what, true);

  pureText = false;
  HtmlEdit.focus();
}

function validateMode()
{
  if (!	bTextMode) return true;
  alert("请取消“查看HTML源代码”选项，然后再使用系统编辑功能!");
  HtmlEdit.focus();
  return false;
}

function format(what,opt)
{
  if (!validateMode()) return;
  if (opt=="removeFormat")
  {
    what=opt;
    opt=null;
  }

  if (opt==null) HtmlEdit.document.execCommand(what);
  else HtmlEdit.document.execCommand(what,"",opt);

  pureText = false;
  HtmlEdit.focus();
}

function setMode(newMode)
{
  var cont;
  bTextMode = newMode;
  if (bTextMode) {
    cleanHtml();
    cleanHtml();

    cont=HtmlEdit.document.body.innerHTML;
    HtmlEdit.document.body.innerText=cont;
  }
  else {
    cont=HtmlEdit.document.body.innerText;
    HtmlEdit.document.body.innerHTML=cont;
  }
  HtmlEdit.focus();
}

function foreColor()
{
  if (!	validateMode())	return;
  var arr = showModalDialog("selcolor.html", "", "dialogWidth:18.5em; dialogHeight:17.5em; status:0");
  if (arr != null) format('forecolor', arr);
  else HtmlEdit.focus();
}

function InsertTable()
{
  if (!	validateMode())	return;
  HtmlEdit.focus();
  var range = HtmlEdit.document.selection.createRange();
  var arr = showModalDialog("table.html", "", "dialogWidth:300pt;dialogHeight:236pt;help:0;status:0");

  if (arr != null){
	range.pasteHTML(arr);
  }
  HtmlEdit.focus();
}
function forPic()
{
	if(! validateMode()) return;
	var arr=showModalDialog("allPic.aspx","","dialogwidth:20cm;dialogHeight:16cm;status:0");
	if (arr !=null) {
	var string;
	string="<img alt=照片 border=1 bordercolor=black src=pic/" + arr + ">";
	 HtmlEdit.document.execCommand("InsertImage", false, "newspic/" + arr);
	//content=ifrHTML.document.body.innerHTML;
    //content=content+string;
    //ifrHTML.document.body.innerHTML=content;
	}
	else HtmlEdit.focus();
	
}

function pic()
{
  if (!	validateMode())	return;
  HtmlEdit.focus();
  var range = HtmlEdit.document.selection.createRange();
  var arr = showModalDialog("pic.html", "", "dialogWidth:30em; dialogHeight:15em; status:0;help:0");  
  if (arr != null){
  var ss;
  ss=arr.split("*")
  a=ss[0];
  b=ss[1];
  c=ss[2];
  d=ss[3];
  e=ss[4];
  f=ss[5];
  g=ss[6];
  h=ss[7];
  i=ss[8];
  
  var str1;
str1="<img src='"+a+"' alt='"+b+"'"
if(d.value!='')str1=str1+"width='"+d+"'"
if(e.value!='')str1=str1+"height='"+e+"' "
str1=str1+" border='"+i+"' align='"+h+"' vspace='"+f+"' hspace='"+g+"'  style='"+c+"'"
str1=str1+">"
  content=HtmlEdit.document.body.innerHTML;
  content=content+str1;
   HtmlEdit.document.body.innerHTML=content;
  }
  else HtmlEdit.focus();
}

function adv1()
{
  if (!	validateMode())	return;
  HtmlEdit.focus();
  var range = HtmlEdit.document.selection.createRange();
  var arr = showModalDialog("adv.html", "", "dialogWidth:30em; dialogHeight:15em; status:0;help:0");  
  if (arr != null){
  var ss;
  ss=arr.split("*")
  a=ss[0];
  
  var str1;
str1="[画中画]"
str1=str1+"]"+a+"[/画中画]"
  content=HtmlEdit.document.body.innerHTML;
  content=content+str1;
   HtmlEdit.document.body.innerHTML=content;
  }
  else HtmlEdit.focus();
}

function adv()
{
  if (!	validateMode())	return;
  HtmlEdit.focus();
  var range = HtmlEdit.document.selection.createRange();
  var arr = showModalDialog("adv.html", "", "dialogWidth:30em; dialogHeight:10em; status:0;help:0"); 
  if (arr != null){
  var ss;
  ss=arr.split("*")
  a=ss[0];

var str1;
str1="[画中画]"
str1=str1+a+"[/画中画]"

  content=HtmlEdit.document.body.innerHTML;
  content=content+str1;
   HtmlEdit.document.body.innerHTML=content;
  }
  else HtmlEdit.focus();
}

function swf()
{
  if (!	validateMode())	return;
  HtmlEdit.focus();
  var range = HtmlEdit.document.selection.createRange();
  var arr = showModalDialog("flash.htm", "", "dialogWidth:30em; dialogHeight:10em; status:0;help:0"); 
  if (arr != null){
  var ss;
  ss=arr.split("*")
  path=ss[0];
  row=ss[1];
  col=ss[2];
  var string;
string="<object classid='clsid:D27CDB6E-AE6D-11cf-96B8-444553540000'  codebase='http://download.macromedia.com/pub/shockwave/cabs/flash/swflash.cab#version=5,0,0,0' width="+row+" height="+col+"><param name=movie value="+path+"><param name=quality value=high><embed src="+path+" pluginspage='http://www.macromedia.com/shockwave/download/index.cgi?P1_Prod_Version=ShockwaveFlash' type='application/x-shockwave-flash' width="+row+" height="+col+"></embed></object>"
  content=HtmlEdit.document.body.innerHTML;
  content=content+string;
   HtmlEdit.document.body.innerHTML=content;
  }
  else HtmlEdit.focus();
}

function hr()
{
  if (!	validateMode())	return;
  HtmlEdit.focus();
  var range = HtmlEdit.document.selection.createRange();
  var arr = showModalDialog("hr.htm", "", "dialogWidth:30em; dialogHeight:12em; status:0;help:0"); 
  if (arr != null){
  var ss;
  ss=arr.split("*")
  a=ss[0];
  b=ss[1];
  c=ss[2];
  d=ss[3];
  e=ss[4];
  var str1;
str1="<hr"
str1=str1+" color='"+a+"'"
str1=str1+" size="+b+"'"
str1=str1+" "+c+""
str1=str1+" align="+d+""
str1=str1+" width="+e
str1=str1+">"
  content=HtmlEdit.document.body.innerHTML;
  content=content+str1;
   HtmlEdit.document.body.innerHTML=content;
  }
  else HtmlEdit.focus();
}

function FIELDSET()
{
  if (!	validateMode())	return;
  HtmlEdit.focus();
  var range = HtmlEdit.document.selection.createRange();
  var arr = showModalDialog("fieldset.htm", "", "dialogWidth:25em; dialogHeight:10em; status:0;help:0");
  if (arr != null){
  var ss;
  ss=arr.split("*")
  a=ss[0];
  b=ss[1];
  c=ss[2];
  d=ss[3];
  var str1;
str1="<FIELDSET "
str1=str1+"align="+a+""
str1=str1+" style='"
if(c.value!='')str1=str1+"color:"+c+";"
if(d.value!='')str1=str1+"background-color:"+d+";"
str1=str1+"'><Legend"
str1=str1+" align="+b+""
str1=str1+">标题</Legend>内容</FIELDSET>"
  content=HtmlEdit.document.body.innerHTML;
  content=content+str1;
   HtmlEdit.document.body.innerHTML=content;
  }
  else HtmlEdit.focus();
}

function iframe()  //插入网页
{
  if (!	validateMode())	return;
  HtmlEdit.focus();
  var range = HtmlEdit.document.selection.createRange();
  var arr = showModalDialog("iframe.htm", "", "dialogWidth:30em; dialogHeight:13em; status:0;help:0");  
  if (arr != null){
  var ss;
  ss=arr.split("*")
  a=ss[0];
  b=ss[1];
  c=ss[2];
  d=ss[3];
  e=ss[4];
  f=ss[5];
  g=ss[6];
  var str1;
str1="<iframe src='"+a+"'"
str1+=" scrolling="+b+""
str1+=" frameborder="+c+""
if(d!='')str1+=" marginheight="+d
if(e!='')str1+=" marginwidth="+e
if(f!='')str1+=" width="+f
if(g!='')str1+=" height="+g
str1=str1+"></iframe>"
  content=HtmlEdit.document.body.innerHTML;
  content=content+str1;
   HtmlEdit.document.body.innerHTML=content;
  }
  else HtmlEdit.focus();
}

function wmv()
{
  if (!	validateMode())	return;
  HtmlEdit.focus();
  var range = HtmlEdit.document.selection.createRange();
  var arr = showModalDialog("media.htm", "", "dialogWidth:30em; dialogHeight:10em; status:0;help:0");
  if (arr != null){
  var ss;
  ss=arr.split("*")
  path=ss[0];
  row=ss[1];
  col=ss[2];
  var string;
  //<EMBED src=http://WWW.ANNIL.COM/VIDEO/DAZHOU.WMV width=200 height=200 type=audio/x-pn-realaudio-plugin console="Clip1" controls="IMAGEWINDOW,ControlPanel,StatusBar" autostart="true"></EMBED>
  
string="<EMBED type=audio/x-pn-realaudio-plugin console=Clip1 controls=IMAGEWINDOW,ControlPanel,StatusBar id=MediaPlayer src="+ path +" width="+ row +" height="+ col +" autostart=true loop=false></EMBED>";
	
	
	HtmlEdit.document.body.innerHTML+=string;
		


  }
  else HtmlEdit.focus();
}


function rm()
{
  if (!	validateMode())	return;
  HtmlEdit.focus();
  var range = HtmlEdit.document.selection.createRange();
  var arr = showModalDialog("rm.htm", "", "dialogWidth:30em; dialogHeight:10em; status:0;help:0");  
  if (arr != null){
  var ss;
  ss=arr.split("*")
  path=ss[0];
  row=ss[1];
  col=ss[2];
  var string;
string="<object classid='clsid:CFCDAA03-8BE4-11cf-B84B-0020AFBBCCFA' width="+row+" height="+col+"><param name='CONTROLS' value='ImageWindow'><param name='CONSOLE' value='Clip1'><param name='AUTOSTART' value='-1'><param name=src value="+path+"></object><br><object classid='clsid:CFCDAA03-8BE4-11cf-B84B-0020AFBBCCFA'  width="+row+" height=60><param name='CONTROLS' value='ControlPanel,StatusBar'><param name='CONSOLE' value='Clip1'></object>"
  content=HtmlEdit.document.body.innerHTML;
  content=content+string;
   HtmlEdit.document.body.innerHTML=content;
  }
  else HtmlEdit.focus();
}

function specialtype(Mark){
  if (!Error()) return;
  var sel,RangeType
  sel = HtmlEdit.document.selection.createRange();
  RangeType = HtmlEdit.document.selection.type;
  if (RangeType == "Text"){
    sel.pasteHTML("<" + Mark + ">" + sel.text + "</" + Mark + ">");
    sel.select();
  }
  HtmlEdit.focus();
}

function help()
{
  var helpmess;
    helpmess="---------------------------编辑器使用帮助----------------------------\r\n\r\n"+
         "1、如果要对文章进行文字、版面和其他HTML语法编辑，可先用鼠标单击页面上方“内容”文本框内的任何位置，然后点按鼠标右键，按“全选”，再次按右键，然后按“剪切”。\r\n\r\n"+
         "2、用鼠标点按“超文本编辑器”，然后点按“粘贴”图标（或者用鼠标单击文本框内任一位置，按住键盘上的Ctrl和V两个按键），将文本粘贴到编辑器内。\r\n\r\n"+
         "3、单击小方格使之处于未选中状态，即可开始进行“所见即所得”的文本编辑。\r\n\r\n"+
         "----------------------------------------------------------------------";
	alert(helpmess);
}

function save()
{
  if (bTextMode){
//编辑器嵌入其他网页时使用下面这一句（请将form1改成相应表单名）
  //parent.myform.Content.value=HtmlEdit.document.body.innerText;
//单独打开编辑器时使用下面这一句（请将form1改成相应表单名）  
//  self.opener.form1.content.value+=HtmlEdit.document.body.innerText;
  }
  else{
//编辑器嵌入其他网页时使用下面这一句（请将form1改成相应表单名）
  //parent.myform.Content.value=HtmlEdit.document.body.innerHTML;
//单独打开编辑器时使用下面这一句（请将form1改成相应表单名）  
//  self.opener.form1.content.value+=HtmlEdit.document.body.innerHTML;
  }
  HtmlEdit.focus();
  return false;
}