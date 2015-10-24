//----------------------------------------------弹出DIV仿模态窗口开始----------------------------------------------
var divW;	//DIV宽度
var divH;	//DIV高度
var clientH;	//浏览器高度
var clientW;	//浏览器宽度
var divTitle;	//DIV标题
var divId;	
var div_X;	//DIV横坐标
var div_Y; //DIV纵坐标
var nScrollHight = 0; //滚动距离总长(注意不是滚动条的长度)
var nScrollTop = 0;   //滚动到的当前位置

function DivWindowOpen(divWidth,divHeight,id){
	divW = divWidth;	//DIV宽度
	divH = divHeight; //DIV高度
	divId = id;
	lockScreen();	//锁定背景
	divOpen();
	var parent = $("#" + id).parent();
	$("#divWindow").empty().append($("#" + id).show());
	$("img[name='x']").css("cursor", "pointer");
	$("img[name='x']").unbind("hover");
	$("img[name='x']").unbind("click");
	//交换X图片
	$("img[name='x']").hover(
		function(){
			$(this).attr("src","images/Close-2.gif");
		},
		function(){
			$(this).attr("src","images/Close-1.gif");
		}
	);
	
	//关闭DIV窗口

		$("img[name='x']").click(
		function () {
		    parent.append($("#" + id).hide());
		    $("img[name='x']").attr("src", "images/Close-1.gif");
		    clearDivWindow();
		    clearLockScreen();
		}
	);
    
    
}

//返回弹出的DIV的坐标
function divOpen(){
	var minTop = 80;	//弹出的DIV记顶部的最小距离
	if ($("#divWindow").length == 0) {
		clientH = $(window).height();	//浏览器高度
	    clientW = $(window).width();	//浏览器宽度
		div_X = (clientW - divW)/5;	//DIV横坐标
		div_Y = (clientH - divH)/2;	//DIV纵坐标
		div_X += window.document.documentElement.scrollLeft;	//DIV显示的实际横坐标
		div_Y += window.document.documentElement.scrollTop;	//DIV显示的实际纵坐标
		if(div_Y < minTop){
			div_Y = minTop;
		}

$("body").append("<div id='divWindow'><img src='images/ajaxload2.gif'>加载中...<img src='images/Close-1.gif'  name='x'/></div>"); //增加DIV
		//divWindow的样式
        $("#divWindow").css("position", "absolute");
		$("#divWindow").css("z-index","200");
		$("#divWindow").css("left",(div_X + "px"));	//定位DIV的横坐标
		$("#divWindow").css("top", (div_Y + "px")); //定位DIV的纵坐标
		$("#divWindow").width(divW+"px");
		$("#divWindow").height(divH  + "px");
		//$("#divWindow").css("background-color","#FFFFFF");
		//$("#divWindow").css("border", "solid 1px #333333")
		//$("#divContent").css("margin","8px");
		//x的样式
		$("img[name='x']").css("float", "right");
		$("img[name='x']").css("cursor", "pointer");
	}
	else{
		clientH = $(window).height();	//浏览器高度
		clientW = $(window).width();	//浏览器宽度
		div_X = (clientW - divW)/5;	//DIV横坐标
		div_Y = (clientH - divH)/2;	//DIV纵坐标
		div_X += window.document.documentElement.scrollLeft;	//DIV显示的实际横坐标
		div_Y += window.document.documentElement.scrollTop;	//DIV显示的实际纵坐标
		if(div_Y < minTop){
			div_Y = minTop;
		}
		$("#divWindow").css("left",(div_X + "px"));	//定位DIV的横坐标
		$("#divWindow").css("top",(div_Y + "px"));	//定位DIV的纵坐标
	}
}

//锁定背景屏幕
function lockScreen(){
	if($("#divLock").length == 0){	//判断DIV是否存在
		clientH = $(window).height();	//浏览器高度
		//clientW = $(window).width();	//浏览器宽度
		var docH = $("body").height();	//网页高度
		//var docW = $("body").width();	//网页宽度
		//var bgW = clientW > docW ? clientW : docW;	//取有效宽
	    var bgH = clientH > docH ? clientH : docH;	//取有效高
	   // clientH = $("body").height();
	    clientW = $(window).width();
		$("body").append("<div id='divLock'></div>")	//增加DIV
		$("#divLock").height(bgH);
		$("#divLock").width(clientW);
		$("#divLock").css("display","block");
		$("#divLock").css("background-color","#000000");
		$("#divLock").css("position", "absolute");
		$("#divLock").css("z-index","100");
		$("#divLock").css("top","0px");
		$("#divLock").css("left","0px");
		$("#divLock").css("opacity","0.5");
	}
	else{
		clientH = $(window).height();	//浏览器高度
		clientW = $(window).width();	//浏览器宽度
		$("#divLock").height(clientH);
		$("#divLock").width(clientW);
	}
}

//清除背景锁定
function clearLockScreen(){
	$("#divLock").remove();
}

//清除DIV窗口
function clearDivWindow(){
	$("#divWindow").remove();
}

$(window).resize(
		function () {
		    if ($("#divLock").length != 0) {
		        lockScreen();
		    }
		    if ($("#divWindow").length != 0) {
		        divOpen();
		    }
		}
);
//----------------------------------------------弹出DIV仿模态窗口结束----------------------------------------------

//改变风格
function ChangeStyle(styleName){
	skinName = styleName;
	//SetCookie("Skin", skinName);
	alert(styleName);
	window.location.reload();
}
