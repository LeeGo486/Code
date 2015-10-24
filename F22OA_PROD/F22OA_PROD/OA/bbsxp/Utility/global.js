//COOKIE Start
function getCookie(sName){
	var cookie = "" + document.cookie;
	var start = cookie.indexOf(sName);
	if (cookie == "" || start == -1) 
		return "";
	var end = cookie.indexOf(';',start);
	if (end == -1)
		end = cookie.length;
	return unescape(cookie.substring(start+sName.length + 1,end));
}
function setCookie(sName, value) {
	document.cookie = sName + "=" + escape(value) + ";path=/;";
}
function setCookieForever(sName, value) {
	var expdate = new Date();
	expdate.setFullYear(expdate.getFullYear() + 30);
	document.cookie = sName + "=" + escape(value) + ";path=/;expires="+expdate.toGMTString()+";";
}
//COOKIE END

//UrlPost Start
document.write("<form id=UrlPost method=Post></form>")
function UrlPost(Url){
	document.getElementById("UrlPost").action = Url;
	document.forms['UrlPost'].submit()
}
//UrlPost END

//XmlDom Start
function GetXmlDom() {
	if (window.ActiveXObject) {//IE浏览器
		return new ActiveXObject("Microsoft.XMLDOM");
	}
	else if (document.implementation && document.implementation.createDocument) { //其它浏览器
		return document.implementation.createDocument("","",null);
	}
}

function GetNodeValue(objXmlElement)
{
	if(window.ActiveXObject) {	//IE浏览器
		return objXmlElement.text;
	}
	else if(window.XMLHttpRequest) {  //其它浏览器
		try {
			return objXmlElement.firstChild.nodeValue;
		}
		catch(ex) {
			return "";
		}
	}
}

function ShowMenuList(XMLUrl){
	var XmlDom = GetXmlDom();
	var SubMenuStr,MenuNode;
	XmlDom.async = false;
	XmlDom.load(XMLUrl);
	var XmlDomRoot = XmlDom.documentElement;
	var CategoryNode = XmlDomRoot.getElementsByTagName('Category');
	for (var i=0; i<CategoryNode.length; i++) {
		SubMenuStr="";
		MenuNode = CategoryNode[i].getElementsByTagName('Menu');
		for (var j=0; j<MenuNode.length; j++){
			SubMenuStr+="<div class=menuitems><a href="+MenuNode[j].getAttributeNode("Url").nodeValue+">"+GetNodeValue(MenuNode[j])+"</a></div>";
		}
		document.write(" | <a href="+CategoryNode[i].getAttributeNode("Url").nodeValue+" onmouseover=\"showmenu(event,'"+SubMenuStr+"')\">"+CategoryNode[i].getAttributeNode("Name").nodeValue+"</a>");
	}
}
//XmlDom End

//跳转页面显示
function ShowPage(TotalPage,PageIndex,url){
	document.write("<table style='clear: both;'><tr><td valign='baseline' class='PageInation'><a class=MultiPages>"+PageIndex+"/"+TotalPage+"</a>");
	if (PageIndex<6) {
		PageLong=11-PageIndex;
	}
	else
		if (TotalPage-PageIndex<6) {
			PageLong=10-(TotalPage-PageIndex)
		}
		else {
			PageLong=5;
		}
	for (var i=1; i <= TotalPage; i++) {
		if (i < PageIndex+PageLong && i > PageIndex-PageLong || i==1 || i==TotalPage){
			if (PageIndex==i) {
				document.write("<a class=CurrentPage>"+ i +"</a>");
			}
			else {
				document.write("<a class=PageNum href=?PageIndex="+i+"&"+url+">"+ i +"</a>");
			}
		}
	}
	document.write("<input onkeydown=if((event.keyCode==13)&&(this.value!=''))window.location='?PageIndex='+this.value+'&"+url+"'; onkeyup=if(isNaN(this.value))this.value='' class=PageInput></td></tr></table>");
}

//全选复选框
function CheckAll(form){
	for (var i=0;i<form.elements.length;i++){
	var e = form.elements[i];
	if (e.name != 'chkall' && e.type=="checkbox")e.checked = form.chkall.checked;
	}
}


//菜单
var menuOffX=0	//菜单距连接文字最左端距离
var menuOffY=18	//菜单距连接文字顶端距离

var ie4=document.all&&navigator.userAgent.indexOf("Opera")==-1
var ns6=document.getElementById&&!document.all

function showmenu(e,vmenu,mod){
	if (!vmenu){return false;} //如果空则不显示
	var which=vmenu
	menuobj=document.getElementById("popmenu")
	menuobj.thestyle=menuobj.style
	menuobj.innerHTML=which
	menuobj.contentwidth=menuobj.offsetWidth
	eventX=e.clientX
	eventY=e.clientY
	var rightedge=document.body.clientWidth-eventX
	var bottomedge=document.body.clientHeight-eventY
	var getlength
		if (rightedge<menuobj.contentwidth){
			getlength=ie4? document.body.scrollLeft+eventX-menuobj.contentwidth+menuOffX : ns6? window.pageXOffset+eventX-menuobj.contentwidth : eventX-menuobj.contentwidth
		}else{
			getlength=ie4? ie_x(event.srcElement)+menuOffX : ns6? window.pageXOffset+eventX : eventX
		}
		menuobj.thestyle.left=getlength+'px'
		if (bottomedge<menuobj.contentheight&&mod!=0){
			getlength=ie4? document.body.scrollTop+eventY-menuobj.contentheight-event.offsetY+menuOffY-23 : ns6? window.pageYOffset+eventY-menuobj.contentheight-10 : eventY-menuobj.contentheight
		}	else{
			getlength=ie4? ie_y(event.srcElement)+menuOffY : ns6? window.pageYOffset+eventY+10 : eventY
		}
	menuobj.thestyle.top=getlength+'px'
	menuobj.thestyle.visibility="visible"
}

function ie_y(e){  
	var t=e.offsetTop;  
	while(e=e.offsetParent){  
		t+=e.offsetTop;  
	}  
	return t;  
}  
function ie_x(e){  
	var l=e.offsetLeft;  
	while(e=e.offsetParent){  
		l+=e.offsetLeft;  
	}  
	return l;  
}  

function highlightmenu(e,state){
	if (document.all)
		source_el=event.srcElement
	else if (document.getElementById)
		source_el=e.target
	if (source_el.className=="menuitems"){
		source_el.id=(state=="on")? "mouseoverstyle" : ""
	}
	else{
		while(source_el.id!="popmenu"){
			source_el=document.getElementById? source_el.parentNode : source_el.parentElement
			if (source_el.className=="menuitems"){
				source_el.id=(state=="on")? "mouseoverstyle" : ""
			}
		}
	}
}

function hidemenu(){if (window.menuobj)menuobj.thestyle.visibility="hidden"}
function dynamichide(e){if ((ie4||ns6)&&!menuobj.contains(e.toElement))hidemenu()}

document.onclick=hidemenu
document.write("<div class=menuskin id=popmenu onmouseover=highlightmenu(event,'on') onmouseout=highlightmenu(event,'off');dynamichide(event)></div>")
// 菜单END


//add area script
function ValidateTextboxAdd(box, button)
{
 var buttonCtrl = document.getElementById( button );
 if ( buttonCtrl != null )
 {
 if (box.value == "" || box.value == box.Helptext)
 {
 buttonCtrl.disabled = true;
 }
 else
 {
 buttonCtrl.disabled = false;
 }
 }
}
//add area script end

//Ajax Start
function Ajax_GetXMLHttpRequest() {
	if (window.ActiveXObject) {
		return new ActiveXObject("Microsoft.XMLHTTP");
	} 
	else if (window.XMLHttpRequest) {
		return new XMLHttpRequest();
	}
}
function Ajax_CallBack(FormName,ID,URL){
	var x = Ajax_GetXMLHttpRequest();
	var ID = document.getElementById(ID);
	x.open("POST",URL);
	x.setRequestHeader("REFERER", location.href);
	x.setRequestHeader("Content-Type", "application/x-www-form-urlencoded");
	x.onreadystatechange = function(){if(x.readyState == 4 && x.status == 200 && ID){ID.innerHTML=x.responseText;}}
	var encodedData=""
	if (document.forms.length > 0 && FormName) {
		var form = document.forms[FormName];
		for (var i = 0; i < form.length; ++i) {
			var element = form.elements[i];
			if (element.name) {
				var elementValue = null;
				if (element.nodeName == "INPUT") {
					var inputType = element.getAttribute("TYPE").toUpperCase();
					if (inputType == "TEXT" || inputType == "PASSWORD" || inputType == "HIDDEN") {
						elementValue = escape(element.value);
					} else if (inputType == "CHECKBOX" || inputType == "RADIO") {
						if (element.checked) {
							elementValue = escape(element.value);
						}
					}
				} else if (element.nodeName == "SELECT" || element.nodeName == "TEXTAREA") {
					elementValue = escape(element.value);
				}
				if (elementValue) {
					if(encodedData==""){
						encodedData = element.name + "=" + encodeURIComponent(elementValue);
					}
					else{
						encodedData += "&" + element.name + "=" + encodeURIComponent(elementValue);
					}
				}
			}
		}

	}
	x.send(encodedData);
}
//Ajax End



function loadThreadFollow(ForumID){
	var targetImg =document.getElementById("followImg");
	var targetDiv =document.getElementById("follow");
	if (targetDiv.style.display!='block'){
		Ajax_CallBack(false,"followTd","loading.asp?menu=UsersOnline&ForumID="+ForumID+"")
		targetDiv.style.display="block";
		targetImg.src="images/minus.gif";
	}else{
		targetDiv.style.display="none";
		targetImg.src="images/plus.gif";
	}
}

function ToggleMenuOnOff (menuName) {
	var menu = document.getElementById(menuName);
	if (menu.style.display == 'none') {
		menu.style.display = '';
	} else {
		menu.style.display = 'none';
	}	
}

function ForumGroupToggleCollapsed(id) {
	var menu = document.getElementById("ForumGroup"+id);
	var menuImg =document.getElementById("ForumGroupImg"+id);
	if (menu.style.display == 'none') {
		menu.style.display = '';
		menuImg.src="images/group_collapse.gif";
		setCookie("ForumGroupDisplay"+id,"")
	} else {
		menu.style.display = 'none';
		menuImg.src="images/group_expand.gif";
		setCookieForever("ForumGroupDisplay"+id,"none")
	}
}

function OpenWindow (target) { 
  window.open(target, "_Child", "toolbar=no,scrollbars=yes,resizable=yes,width=400,height=400"); 
}


function log_out()
{
	ht = document.getElementsByTagName("html");
	ht[0].style.filter = "progid:DXImageTransform.Microsoft.BasicImage(grayscale=1)";
	if (confirm('你确定要退出？'))
	{
		UrlPost("Login.asp?Menu=OUT");
	}
	else
	{
		ht[0].style.filter = "";
		return false;
	}
}


function ShowPannel(index,Max){
	for(var i=0;i<=Max;i++){
		document.getElementById("Pannel"+i).style.display="none";
		document.getElementById("PannelHeader"+i).className="PannelOff";
	}
	document.getElementById("PannelHeader"+index).className="PannelOn";
	document.getElementById("Pannel"+index).style.display="";
}

function ShowCheckResult(ObjectID, Message, ImageName) {
	obj = document.getElementById(ObjectID);
	obj.style.display = '';
	obj.innerHTML = '<img src="images/check_'+ImageName+'.gif" align=absmiddle>&nbsp;' + Message;
}

function CheckVerifyCode(VerifyCode) {
	var patrn=/^\d+$/;		//纯数字
	if(!patrn.exec(VerifyCode)) {
		ShowCheckResult("CheckVerifyCode", "您没有输入验证码或输入有误。","error");
		return;
	}

	Ajax_CallBack(false,"CheckVerifyCode","Loading.asp?menu=CheckVerifyCode&VerifyCode=" + VerifyCode);

}




//讯息提示
function MsgGet()
{
	document.getElementById(MsgDivID).style.visibility="visible"
	try{
	divTop = parseInt(document.getElementById(MsgDivID).style.top,10)
	divLeft = parseInt(document.getElementById(MsgDivID).style.left,10)
	divHeight = parseInt(document.getElementById(MsgDivID).offsetHeight,10)
	divWidth = parseInt(document.getElementById(MsgDivID).offsetWidth,10)
	docWidth = document.documentElement.clientWidth;
	docHeight = document.documentElement.clientHeight;
	document.getElementById(MsgDivID).style.top = (parseInt(document.documentElement.scrollTop,10) + docHeight + 10) + 'px';//  divHeight
	document.getElementById(MsgDivID).style.left = (parseInt(document.documentElement.scrollLeft,10) + docWidth - divWidth) + 'px';
	objTimer = window.setInterval("MsgMove()",10)
	}
	catch(e){}
}

function MsgResize()
{
	try{
	divHeight = parseInt(document.getElementById(MsgDivID).offsetHeight,10)
	divWidth = parseInt(document.getElementById(MsgDivID).offsetWidth,10)
	docWidth = document.documentElement.clientWidth;
	docHeight = document.documentElement.clientHeight;
	document.getElementById(MsgDivID).style.top = (docHeight - divHeight + parseInt(document.documentElement.scrollTop,10)) + 'px';
	document.getElementById(MsgDivID).style.left = (docWidth - divWidth + parseInt(document.documentElement.scrollLeft,10)) + 'px';
	}
	catch(e){}
}

function MsgMove()
{
	try
	{
	if(parseInt(document.getElementById(MsgDivID).style.top,10) <= (docHeight - divHeight + parseInt(document.documentElement.scrollTop,10)))
	{
	window.clearInterval(objTimer)
	objTimer = window.setInterval("MsgResize()",1)
	}
	divTop = parseInt(document.getElementById(MsgDivID).style.top,10)
	document.getElementById(MsgDivID).style.top = (divTop - 1) + 'px';
	}
	catch(e){}
}
function MsgClose()
{
	document.getElementById(MsgDivID).style.visibility='hidden';
	if(objTimer) window.clearInterval(objTimer)
}
//讯息 END