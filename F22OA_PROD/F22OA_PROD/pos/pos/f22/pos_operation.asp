<%Response.Expires=-1000%>
<!--#include file="inc/function.asp"-->
<%dim act,depotid,userid,i
depotid=trim(session("dm").System_depotid)
userid=trim(session("dm").System_Userid)
i=0
act=trim(request.QueryString("act"))
setdate=trim(request.QueryString("setdate"))
select case act
case "zk"
  title="整单打折"
case "zf"
  
case "gd"
  title="挂单"
case "qd"
  title="取单"
case "zs"
  title="赠送"
case "th"
  title="退货"
case else

end select
%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<title><%=title%></title>
<link href="css/f22.css" rel="stylesheet" type="text/css">
<script type="text/javascript" src="../inc/js/setday.js"></script>
<base target="abcdefg">
</head>

<body>
<iframe style="display:none; " name="abcdefg" id="abcdefg"></iframe>
<form name="form1" method="get" target="abcdefg" action="pos_control.asp">
<%
select case act
case "zk"
  call zk
case "zf"

case "gd"
  call gd
case "qd"
  call qd
case "zs"
  call zs
case "th"
  call th
case else

end select
%>

<%sub zk%>
  <table width="300"  border="1" cellspacing="0" bordercolor="#ECD5CF" bordercolorlight="#FFFFFF" class="f12">
    <tr>
      <td width="17%">&nbsp;</td>
      <td width="83%" align="center">整单打折</td>
    </tr>
    <tr>
      <td>折扣:</td>
      <td><input name="discount" type="text" id="discount" size="20" maxlength="20" value=1 onFocus="this.select()" onBlur="if(isNaN(this.value)){alert('数据类型错误！');this.focus();};if((this.value<0.01)||(this.value>1)){alert('折扣只能在0.01-1之间！');this.focus();}">
      <input name="act" type="hidden" id="act" value="<%=act%>">
	  <input type="hidden" name="vipcode" id="vipcode" value="<%=session("posvipcode")%>"></td>
    </tr>
    <tr>
      <td>&nbsp;</td>
      <td><input type="submit" name="Submit" value="确 定">
      <input type="button" name="Submit" value="取 消" onClick="window.close();"></td>
    </tr>
  </table>
  <%end sub%>
  <%sub gd
  dim ds
  set ds=Server.CreateObject("ADODB.Recordset")
ds.ActiveConnection = cn
ds.source = "select 1 from webtmp_retailsub where retailid="&qts(session("retailid"))
ds.open
if ds.eof then
   call close("当前单没有数据，不可以再挂单！")
end if
ds.close
set ds=nothing%>
  <table width="300"  border="1" cellspacing="0" bordercolor="#ECD5CF" bordercolorlight="#FFFFFF" class="f12">
    <tr>
      <td width="17%">&nbsp;</td>
      <td width="83%" align="center">挂单</td>
    </tr>
    <tr>
      <td>说明:</td>
      <td><input name="comment" type="text" id="comment" size="30" maxlength="30">
      <input name="act" type="hidden" id="act" value="<%=act%>"></td>
    </tr>
    <tr>
      <td>&nbsp;</td>
      <td><input type="submit" name="Submit" value="确 定">
          <input type="button" name="Submit" value="取 消" onClick="window.close();"></td>
    </tr>
  </table>
  <%end sub%>
  <%sub zs
  i=1%>
<table width="300"  border="1" cellspacing="0" bordercolor="#ECD5CF" bordercolorlight="#FFFFFF" class="f12">
    <tr>
      <td width="17%">&nbsp;</td>
      <td width="83%" align="center">赠送</td>
    </tr>
    <tr>
      <td>货号:</td>
      <td><input name="clothingid" type="text" id="clothingid" size="15" maxlength="30">
      <input name="act" type="hidden" id="act" value="<%=act%>">
	  <input name="setdate" type="hidden" id="setdate" value="<%=setdate%>">
	  <input type="hidden" name="vipcode" id="vipcode" value="<%=session("posvipcode")%>">
	  <font size=2>条码截取</font><input type="text" name="tmln" size=3 value="<%=session("postm_ln")%>">
	  </td>
    </tr>
    <tr>
      <td>金额:</td>
      <td><input name="sums" type="text" id="sums" value="0" size="6" maxlength="6" onBlur="if(isNaN(this.value)){alert('数据类型错误！');this.focus();}">
        元 (赠送此货品付加金额)</td>
    </tr>
    <tr>
      <td>&nbsp;</td>
      <td><input type="submit" name="Submit" value="确 定">
          <input type="button" name="Submit" value="取 消" onClick="window.close();"></td>
    </tr>
  </table>
  <%end sub%>
  <%sub th
  i=2%>
<table width="300"  border="1" cellspacing="0" bordercolor="#ECD5CF" bordercolorlight="#FFFFFF" class="f12">
    <tr>
      <td width="17%">&nbsp;</td>
      <td width="83%" align="center">退货</td>
    </tr>
    <tr>
      <td>折扣:</td>
      <td><input name="discount" type="text" id="discount" size="5" maxlength="5" value="1" onFocus="this.select()" onBlur="if(isNaN(this.value)){alert('数据类型错误！');this.focus();};if((this.value<0)||(this.value>1)){alert('折扣只能在0-1之间！');this.focus();}" onKeyDown="if(event.keyCode==13)event.keyCode=9">
	  金额：<input name="thsums" type="text" id="thsums" size="5" maxlength="5" value="0" onFocus="this.select()" onBlur="if(isNaN(this.value)){alert('数据类型错误！');this.focus();}" onKeyDown="if(event.keyCode==13)event.keyCode=9">
	  </td>
    </tr>
    <tr>
      <td>货号:</td>
      <td><input name="clothingid" type="text" id="clothingid" size="15" maxlength="30">
      <input name="act" type="hidden" id="act" value="<%=act%>">
	  <input name="setdate" type="hidden" id="setdate" value="<%=setdate%>">
	  <input type="hidden" name="vipcode" id="vipcode" value="<%=session("posvipcode")%>">
	  <font size=2>条码截取</font><input type="text" name="tmln" size=3 value="<%=session("postm_ln")%>"></td>
    </tr>
    <tr>
      <td>&nbsp;</td>
      <td><input type="submit" name="Submit" value="确 定">
          <input type="button" name="Submit" value="取 消" onClick="window.close();"></td>
    </tr>
  </table>
<%end sub%>
<%sub qd%>
<table width="400"  border="1" cellspacing="0" bordercolor="#ECD5CF" bordercolorlight="#FFFFFF" class="f12">
  <tr>
    <td width="10%">&nbsp;</td>
    <td width="34%" align="center">取单
      <input name="act" type="hidden" id="act" value="<%=act%>"></td>
    <td width="39%" align="center">说明</td>
    <td width="17%" align="center">&nbsp;</td>
  </tr>
  <%dim ds
  set ds=Server.CreateObject("ADODB.Recordset")
ds.ActiveConnection = cn
ds.source = "select 1 from webtmp_retailsub where retailid="&qts(session("retailid"))
ds.open
if not ds.eof then
   call close("当前单有数据，不可以再取单！")
end if
ds.close
ds.source = "select retailid,setdate,intra from webtmp_retail where depotid="&qts(depotid) &" and retailid like '"&depotid&"-"&userid&"%' and gd=1"
ds.open
i=0
while not ds.eof
i=i+1%>
  <tr>
    <td>单号:</td>
    <td><%=ds("retailid")%></td>
    <td><%=ds("intra")%> </td>
    <td align="center"><a href="pos_control.asp?act=qd&id=<%=ds("retailid")%>" target="abcdefg">取单</a></td>
  </tr>
  <%ds.movenext
  wend
  set ds=nothing%>
</table>
<center><input type="button" name="Submit" value="关 闭" onClick="window.close();"></center>
<%end sub%>
</form>
<script language="javascript">
var i=<%=i%>;
var dh=140+20*i;
window.dialogHeight=dh+"px";
</script>
</body>
</html>
