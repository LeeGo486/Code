<%Response.Expires=-1000%>
<!--#include file="inc/function.asp"-->
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<link href="css/f22.css" rel="stylesheet" type="text/css">
<title>输入数量</title>
<script language="javascript">
function chkinput(t)
{
	/*
  var k=event.keyCode;
  //alert(k);
  if((k>=48 && k <=57)||(k>=96 && k <=105)){
    //alert(event.keyCode);
  }else if(k==8 || k ==46){
    return k;
  }else if(k==13){
    event.keyCode=9;
  }else{
    //alert(event.keyCode);
    return false;
  }*/
}
function KeyDown(){
	with (event){ 
		if(keyCode==27){//ESC返回输入状态
			window.close();
			event.keyCode = 0; 
			event.cancelBubble = true; 
			return false;
		}
	}
}
document.onkeydown = KeyDown;
</script>

<base target="_self">
</head>

<body>
<%
dim ds,sql,id,act
id=trim(request.QueryString("id"))
act=trim(request.QueryString("act"))
'de act
if id="" then
  call close("款式编号不能为空!")
  response.End()
end if
set ds=Server.CreateObject("ADODB.Recordset")
ds.ActiveConnection = cn
%>
<table width="100%"  border="1" cellpadding="0" cellspacing="0" bgcolor="#FFFFFF" class="f12" bordercolorlight="#ACA899" bordercolordark="#FFFFFF">
  <tr>
    <td height="21" align="center"><span class="ts"><%=id%> 输入数量</span></td>
  </tr>
</table>
<form name="form1" method="post" action="pos_control.asp">
<table width="100%"  border="1" cellpadding="0" cellspacing="0" bordercolorlight="#ACA899" bordercolordark="#FFFFFF" class="f12">
  <tr bgcolor="#FFEFEF">
    <td>
      <input name="id" type="hidden" id="id" value="<%=id%>">
      &nbsp;</td>
	<%
	sql="select a.sizeid from j_clothing a,j_size b where a.styleid='"&id&"' and a.sizeid=b.sizeid group by a.sizeid order by max(b.s_order)"
	ds.source =sql
	ds.open
	sc=1
	while not ds.eof%>
    <td width="50"><%=ds(0)%>
      <input name="sizeid" type="hidden" id="sizeid" value="<%=ds(0)%>"></td>
	<%sc=sc+1
	ds.movenext
	wend
	ds.close%>
  </tr>
  <%ds.source="select distinct a.colorid,c_name from j_clothing a,j_color b where styleid="&qts(id) & _
			"and a.colorid=b.colorid group by a.colorid,c_name"
	ds.open
	j=1
	while not ds.eof%>
  <tr>
    <td align="center"><%=ds(0)%>(<%=ds(1)%>)
      <input name="colorid" type="hidden" id="colorid" value="<%=ds(0)%>"></td>
	<%for i=2 to sc%>
    <td><input name="n<%=j%><%=i%>" type="text" size="5" maxlength="5" 
       onkeydown="if(event.keyCode==13)event.keyCode=9"
       onKeypress="if (event.keyCode < 45 || event.keyCode > 57) event.returnValue = false"
       onBlur="javascript:if(isNaN(this.value)){alert('数据类型错误！');this.focus();}this.value=Math.floor(this.value);" /></td>
	<%next%>
  </tr>
	<%j=j+1
	ds.movenext
	wend
	ds.close%>
</table>
<table width="100%" border="0" bordercolor="#C6AEA5" bgcolor="#FFF7F7" class="bk">
  <tr>
    <td align="center"><input type="submit" name="Submit" value="确定(S)" accesskey="s">
        <input type="button" name="Submit" value="取消(Esc)" onClick="window.close();">
      <input name="rows" type="hidden" id="rows" value="<%=j-1%>">
      <input name="cols" type="hidden" id="cols" value="<%=sc-1%>">
      <input name="act" type="hidden" id="act" value="<%=act%>"></td>
  </tr>
</table>
</form>

<%set ds=nothing%>
<script language="javascript">
  var wdh=120+<%=j%>*23;
  window.dialogWidth="400px";
  window.dialogHeight=wdh+"px";
</script>
</body>
</html>
