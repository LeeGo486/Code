<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%dim id,stype,url
id=trim(request.QueryString("id"))
%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<title>无标题文档</title>
<link href="css/f22.css" rel="stylesheet" type="text/css">
<script language="javascript">
var id="<%=id%>";
function opennew(url){
  window.open(url);
}
function chkform(){
  var t=document.form1;
  var i,s;
  var stype=t.stype;
  for(i=0;i<stype.length;i++)
    if(stype[i].checked){
	  s=stype[i].value;
	  break;
	}
  s=parseInt(s);
  switch(s){
  case 1:
    opennew("create_inventory_all.asp?id="+id);
    break;
  case 2:
    alert(s);
    break;
  case 3:
    var url="f22_main.asp?opt=inventory&id="+id+"&pksname=<%=session("pksname")%>"+"&numName=nums";
	//alert(url);
    showModalDialog(url,window,'dialogWidth:700px;dialogHeight:500px;center: yes;help:no;resizable:yes;status:no');
    break;
  case 4:
    var url="f22_main.asp?opt=inventory&id="+id+"&pksname=<%=session("pksname")%>"+"&numName=d_nums";
	//alert(url);
    showModalDialog(url,window,'dialogWidth:700px;dialogHeight:500px;center: yes;help:no;resizable:yes;status:no');
	break;
  }
  return false;
}
</script>
</head>

<body>

<%
stype=trim(request.QueryString("stype"))
if stype<>"" then
  stype=cint(stype)
  select case stype
  case 1
    url="create_inventory_all.asp?id="&id
    'response.Redirect url
	call opennew(url)
  case 2
    url="create_inventory_loc.asp?id="&id
    'response.Redirect url
	call opennew(url)
  case 3
	response.Write("<script language='javascript'>")
	response.Write("showModalDialog('f22_main.asp?opt=inventory&id="&id&"&pksname="&session("pksname")&"','es','dialogWidth:700px;dialogHeight:500px;center: yes;help:no;resizable:yes;status:no');")
	response.Write("window.returnValue='r';window.close();</script>")
  case 4
    response.Redirect "create_inventory_loc.asp?id="&id
  end select
end if
%>

<table width="100%"  border="0" class="bar">
  <tr>
    <td align="center">请选择盘点方式[<span class="ts"><%=id%></span>]</td>
  </tr>
</table>
<form name="form1" method="get" action="" onSubmit="return chkform(this);">
  <table width="100%" border="1" bordercolor="#EBD4CF" class="f14">
    <tr>
      <td width="92%"><input type="radio" name="stype" value="1">
        <span class="notice">方式一（全局盘点）</span><br>
      &nbsp;&nbsp;&nbsp;&nbsp;库存里全部款式加入盘点单，按大类进行分类打印出款式列表，盘点时把数量记录在纸上，盘点后输入盘点数量即可。</td>
    </tr>
    <tr>
      <td><input type="radio" name="stype" value="2">
        <span class="notice">方式二（局部盘点）</span><br>
      &nbsp;&nbsp;&nbsp;&nbsp;选择一部份款式加入盘点单，打印出来款式列表，盘点时把数量记录在纸上，盘点后输入盘点数量即可。</td>
    </tr>
    <tr>
      <td><input type="radio" name="stype" value="3">
        <span class="notice">方式三（局部盘点）</span><br>
      &nbsp;&nbsp;&nbsp;&nbsp;直接录入款式和数量。</td>
    </tr>
    <tr>
      <td><input type="radio" name="stype" value="4">
        <span class="notice">方式四</span><br>
      &nbsp;&nbsp;&nbsp;&nbsp;直接录入款式和盘点差异。</td>
    </tr>
    <tr>
      <td align="center"><input type="button" name="Submit" value="确定(S)" accesskey="s" onClick="chkform();">
      <input name="id" type="hidden" id="id" value="<%=id%>"></td>
    </tr>
  </table>
</form>

<%sub opennew(t)%>
<script language="javascript">
  opennew("<%=t%>");
</script>
<%end sub%>
</body>
</html>
