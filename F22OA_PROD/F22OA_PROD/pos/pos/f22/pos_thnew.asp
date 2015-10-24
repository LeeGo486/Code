<%Response.Expires=-1000%>
<!--#include file="inc/function.asp"-->
<%dim act,depotid,userid,i
depotid=trim(session("dm").System_depotid)
userid=trim(session("dm").System_Userid)
setdate=trim(request.QueryString("setdate"))
%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<title>退货</title>
<link href="css/f22.css" rel="stylesheet" type="text/css">
<link id="luna-tab-style-sheet" type="text/css" rel="stylesheet" href="css/webfxtab.css" disabled="disabled" />
<style type="text/css">
.dynamic-tab-pane-control .tab-page {height:200px;}
.dynamic-tab-pane-control .tab-page .dynamic-tab-pane-control .tab-page {height:100px;}
html, body {background:	ThreeDFace;}
form {margin:0;
	  padding:0;}
body {margin:		10px;
	  width:		auto;
	  height:		auto;}
.dynamic-tab-pane-control h2 {
	text-align:	center;
	width:		auto;}

.dynamic-tab-pane-control h2 a {
	display:	inline;
	width:		auto;}
.dynamic-tab-pane-control a:hover {	background: transparent;}
</style>
<script type="text/javascript" src="css/tabpane.js"></script>
<base target="abcdefg">
</head>

<body>
<iframe style="display:none; " name="abcdefg" id="abcdefg"></iframe>
<script type="text/javascript">
document.getElementById( "luna-tab-style-sheet" ).disabled = "luna" != "luna";
document.documentElement.style.background =
document.body.style.background = "luna" == "webfx" ? "white" : "ThreeDFace";	
</script>


<div class="tab-pane" id="tabPane1">
<script type="text/javascript">
tp1 = new WebFXTabPane( document.getElementById( "tabPane1" ) );
</script>

<div class="tab-page" id="tabPage1">
<h2 class="tab">整单退货</h2>
<script type="text/javascript">tp1.addTabPage( document.getElementById( "tabPage1" ) );</script>
<form name="form1" method="get" target="abcdefg" action="pos_control.asp">
<table width="100%"  border="1" cellspacing="0" bordercolor="#ECD5CF" bordercolorlight="#FFFFFF" class="f12">
    <tr height=50>
      <td>销售单号：</td>
      <td>
	  <input name="oldid" type="text" id="oldid" size="25" onFocus="this.select()">
      <input name="act" type="hidden" id="act" value="thall">
	  <input name="setdate" type="hidden" id="setdate" value="<%=setdate%>">	
	  </td>
    </tr>
	<tr><td colspan=2>注：整单退货时，会清除原收银界面的所有记录</td></tr>
    <tr height=50>
      <td colspan=2 align=center><input type="submit" name="Submit1" value="  确  定 "></td>
    </tr>
  </table>
</form>
</div>

<div class="tab-page" id="tabPage2">
<h2 class="tab">明细退货</h2>
<script type="text/javascript">tp1.addTabPage( document.getElementById( "tabPage2" ) );</script>
<table width="100%"  border="1" cellspacing="0" bordercolor="#ECD5CF" bordercolorlight="#FFFFFF" class="f12">
<form name="form2" method="get" target="iFrmRef1" action="pos_thnewsub.asp">
    <tr height="20">
      <td>销售单号：</td>
      <td>
	  <input name="oldid" type="text" id="oldid" size="22" onFocus="this.select()">
      <input name="act" type="hidden" id="act" value="thmx">
	  <input name="setdate" type="hidden" id="setdate" value="<%=setdate%>">
	  <input type="submit" name="Submit2" value="查 询">
	  <input type="button" name="Submit3" value="确 定" onClick="frames['iFrmRef1'].document.form1.submit();">
	  </td>
    </tr>
    <tr height=130><td colspan=2><iFrame Name=iFrmRef1 id=iFrmRef1 SRC="pos_thnewsub.asp" width=100% height=100% scrolling="yes" frameborder="0"></iFrame></td></tr>
    <tr><td colspan=2>注：明细退货时，会清除原收银界面的所有记录</td></tr>
</form>
  </table>
</div>

<%if session("dm_th") then%>
<div class="tab-page" id="tabPage3">
<h2 class="tab">无单退货</h2>
<script type="text/javascript">tp1.addTabPage( document.getElementById( "tabPage3" ) );</script>
<form name="form3" method="get" target="abcdefg" action="pos_control.asp">
<table width="100%"  border="1" cellspacing="0" bordercolor="#ECD5CF" bordercolorlight="#FFFFFF" class="f12">
    <tr height=50>
      <td>折扣:</td>
      <td><input name="discount" type="text" id="discount" size="5" maxlength="5" value="1" onFocus="this.select()" onBlur="if(isNaN(this.value)){alert('数据类型错误！');this.focus();};if((this.value<0)||(this.value>1)){alert('折扣只能在0-1之间！');this.focus();}" onKeyDown="if(event.keyCode==13)event.keyCode=9">
	  金额：<input name="thsums" type="text" id="thsums" size="6" maxlength="6" value="0" onFocus="this.select()" onBlur="if(isNaN(this.value)){alert('数据类型错误！');this.focus();}" onKeyDown="if(event.keyCode==13)event.keyCode=9">
	  </td>
    </tr>
    <tr height=50>
      <td>货号:</td>
      <td><input name="clothingid" type="text" id="clothingid" size="15" maxlength="30">
      <input name="act" type="hidden" id="act" value="th">
	  <input name="setdate" type="hidden" id="setdate" value="<%=setdate%>">
	  <input type="hidden" name="vipcode" id="vipcode" value="<%=session("posvipcode")%>">
	  <font size=2>条码截取</font><input type="text" name="tmln" size=3 value="<%=session("postm_ln")%>"></td>
    </tr>
    <tr height=50>
      <td colspan=2 align=center><input type="submit" name="Submit3" value="  确  定 "></td>
    </tr>
  </table>
</form>
</div>
<%end if%>

</div>
<br>
<center><input type="button" name="Submit" value="  关  闭  " onClick="window.close();"></center>
</body>
</html>
