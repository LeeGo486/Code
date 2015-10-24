<!--#include file="inc/function.asp" -->
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<title>选择款式</title>
<base target="_self">
<link rel="stylesheet" type="text/css" href="../../../../Scripts/treeview/jquery.treeview.css">
<style type="text/css">
html, body {background:	ThreeDFace;}
body {
		margin:		10px;
	  width:		auto;
	  height:		auto;
}
body,label,input,div{
	font-family:Verdana, Geneva, sans-serif;
	font-size:12px;
}
i{font-size:10px;}
.frame{
	font-size:12px;
	border-top: solid 1px #BBB;
	border-left: solid 1px #BBB;
	border-bottom: solid 1px #FFF;
	border-right: solid 1px #FFF;
	background: #FFF;
	font-family:Verdana, Geneva, sans-serif;
	height: 320px;
	overflow: scroll;
	padding: 5px;
}

.frame label{
	cursor:pointer;
	padding:0px; margin:0;
	}
.frame ul{
	color:black;
	}
.frame input{
	padding:0;margin:0;
	}
.loading{
	background-image:url(../../../../Scripts/treeview/images/loading.gif);
	background-repeat:no-repeat;
	background-position:left center;
	padding-left:16px;
	}
.text
{
	border-top: solid 1px #BBB;
	border-left: solid 1px #BBB;
	border-bottom: solid 1px #FFF;
	border-right: solid 1px #FFF;
}
</style>
<script src="../../../../Scripts/jquery-1.2.6.min.js"></script>
<script src="../../../../Scripts/treeview/jquery.treeview.js"></script>
<script type="text/javascript">
$(function(){
					 
		//load folder
		loadTree();	//load root
		//加载
		$(".gb").click(loadTree);
		//确定
		$("#add").click(move);
		
		//输入关键字
		$("#key").keydown(function(){
			if(event.keyCode==13){
				$("#add").click();
			}
		});
				
		$("#key").keyup(function(){
			if(event.keyCode!=13)discontrols();
			$(".frame").css('background',$(this).val()?'#eee':'#fff');
	 });
		
});

//load Tree
function loadTree()
{
	if(getgb()){
			ajax_load('#treeview',{gb:getgb(),sel:'0',id:'0',act:'getroot'},true)
	}else{
		return false;
	}
}

//ajax reader
function ajax_load(obj,data,layout)
{
	$(obj)
	.html('<span class="loading">请稍等...</span>')
	.load("ajax_styleTree.asp",data,function(html){
			discontrols();
			if(layout) $(obj).treeview();
			bindTreeEvent(obj);
		});
}

//post data
function ajax_post(data,callback)
{
		$.post("ajax_styleTree.asp?"+(new Date()),data,function(data){
				if(data=="")
				window.close();
				else
				alert(data);
			 //if(callback)	callback();
		});
}

//move for controls
function move()
{
	var s="", i=0;
  $("#treeview").find("input:checkbox:checked").each(function(){
		var id = $(this).attr('id');
		if($(this).parents().find("ul").eq(0).find("input:checkbox").length==0||$(this).parent().find("ul").length==0)
		{
			if(i>0) s+=",";
			s += id
			i ++;
		}
	})
	var cut=$("#key").next().val();
	var key=$("#key").val();
	$(this).val("请稍等...").attr('disabled','disabled');
	
	//post data
	ajax_post({act:'move',gb:getgb(),id:s,key:key,cut:cut,tmptab:'<%=request("tmptab")%>'},loadTree);
}

//check control button's enabled
function discontrols()
{
	//add...
	if($('#treeview').html()==''){
		$("#add").attr('disabled','disabled');
	}else{
		if($('#treeview').find("input:checkbox:checked").length>0){
			$("#add").attr('disabled','');
		}else if($('#key').val()!=""){
			$("#add").attr('disabled','');
		}else{
			$("#add").attr('disabled','disabled');
		}	
	}
}

//bind the tree's events
function bindTreeEvent(obj)
{
	if($(obj).html()!='')
	{
		//expend tree
		$(obj).find(".hitarea").click(function()
		{
			var ul = $(this).parent().find("ul").eq(0);
			var id = $(this).next().attr("id");
			var cb = $(this).parent().find("input:checkbox");

			if(ul.html()==''&&getgb()){
				ajax_load(ul,{act:'getroot',gb:getgb(),id:id,chk:cb.attr('checked')},true);
			}else{
				return false;	
			}
		});
		
		//set sub checkboxs's checked 
		$(obj).find("input:checkbox").click(function(){
			$(this).parents("li").eq(0).find("input:checkbox").attr('checked',$(this).attr('checked'))
			discontrols();
		});
	}
}

//get group by fields
function getgb()
{
	var gb="";
	$(".gb:checked").each(function(i){
			if(i>0)gb+=",";
			gb+=$(this).val();
	});
	return gb;
}
</script>
<script type="text/javascript">
function KeyDown(){
		with (event){ 
				if(keyCode==116){//确定
						document.getElementById('add').click();
						event.keyCode = 0; 
						event.cancelBubble = true; 
						return false;
				}
				if(keyCode==27){//ESC返回输入状态
						document.getElementById('button2').click();
						event.keyCode = 0; 
						event.cancelBubble = true; 
						return false;
				}
		}
}

//加载完成
$(document).ready(function(){
		document.onkeydown = KeyDown;
});
</script>
</head>
<body>
<%
gb=request.cookies("styleTree")("Groupby")
if gb="" then gb="b.drname,a.st_year"
%>
<table cellpadding="0" cellspacing="0" border="0" width="100%">
<form name="form1" method="post" action="">
<tr>
<td colspan="3"> 
<div style="padding:10px 5px;">
<input type="checkbox" name="checkbox" id="a.st_year" class="gb" value="a.st_year" 
	<%if instr(gb,"a.st_year")>0 then%>checked<%end if%>><label for="a.st_year">按年份</label>
<input type="checkbox" name="checkbox" id="a.st_month" class="gb" value="a.st_month" 
	<%if instr(gb,"a.st_month")>0 then%>checked<%end if%>><label for="a.st_month">按季节</label>
<input type="checkbox" name="checkbox" id="b.drname" class="gb" value="b.drname" 
	<%if instr(gb,"b.drname")>0 then%>checked<%end if%>><label for="b.drname">按品牌</label>
<input type="checkbox" name="checkbox" id="a.st_xl" class="gb" value="a.st_xl" 
	<%if instr(gb,"a.st_xl")>0 then%>checked<%end if%>><label for="a.st_xl">按种类</label>
<input type="checkbox" name="checkbox" id="a.st_dl" class="gb" value="a.st_dl" 
	<%if instr(gb,"a.st_dl")>0 then%>checked<%end if%>><label for="a.st_dl">按大类</label>
<input type="checkbox" name="checkbox" id="a.st_xz" class="gb" value="a.st_xz" 
	<%if instr(gb,"a.st_xz")>0 then%>checked<%end if%>><label for="a.st_xz">按小类</label>
</div>
</td>
  </tr>
  <tr>
<td>
<div class="frame" act="left">
    <ul id="treeview" class="treeview"></ul>
</div>
</td>
</tr>
<tr>
<td align="left">
<div>
指定款：<input type="text" id="key" size="40" class="text" />
开始位：<input type="text" id="ciut" size="2" maxlength="2" class="text" value="1" />
</div>
</td>
</tr>
<tr>
<td colspan="3" align="center">
<div style="padding:20px;">
<input type="button" id="add" value="确定(F5)" style="width:80px;"  />
<input type="button" name="button2" id="button2" value="取消(Esc)" style="width:80px;" onClick="window.close();">
</div>
</td>
</tr>
</form>
</table>
</body>
</html>
