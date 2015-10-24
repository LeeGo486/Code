<%'on error resume next%>
<!--#include file="inc/function.asp"-->
<%dim id,sid,ds,sql,tablename,pksname,pkname,opt
id=trim(request.QueryString("id"))
pksname=trim(request.QueryString("pksname"))
tablename="d_"&pksname
pkname=pksname&"id"
select case session("formid")
  case 2063
    tablename="d_outindentpro"
  case 2163
    tablename="d_outindentsq"
  case 2065,2165
    tablename="d_outindentset"
end select
'response.End()
%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<title>单据明细</title>
<link href="css/f22.css" rel="stylesheet" type="text/css">
<script language="javascript">
function altx(){
  window.close();
}
function alt12(){
  showModalDialog('djcopy.asp?djid=<%=id%>&oldformid=<%=session("formid")%>','e','dialogWidth:765px;dialogHeight:405px;center: yes;help:no;resizable:yes;status:no');
}
</script>
</head>

<body>
<%sql="select * from "&tablename&" where "&pkname&"='"&id&"'"
set ds=server.createobject("ADODB.Recordset")
ds.ActiveConnection = cn

'得到取单价的参数
call GetPriceType(id,trim(request("opt")))

ds.Source = sql
ds.Open
if not ds.eof then
  id=ds(pkname)
  sid=ds(pksname)
  session("id")=id
  'de tablename
  if tablename<>"d_inventory" then
     if tablename="d_outindentpro"  or tablename="d_outindentset" or tablename="d_outindentsq" then
       session("get_depotid")=ds("depotid")
	 else
	   session("get_depotid")=ds("get_depotid")
	 end if	
	 if tablename="d_indent" then
	   session("set_depotid")=ds("depotid")
	   else
	   session("set_depotid")=ds("set_depotid")
	 end if 
	 if tablename="d_msell" then
	    session("noticeid")=ds("noticeid")
	 end if
	 
	 if tablename="d_move" then
	    session("noticeid")=ds("indentid")
	 end if
	
	 if tablename="d_outindentset" then
	    session("quotaid")=ds("quotaid")
	 end if
  end if	 
  ds.close  
%>
<table width="100%"  border="0" align="center" class="bar">
  <tr>
    <td align="center">单据明细</td>
  </tr>
</table>
<table width="100%"  border="0" align="center" cellspacing="0" class="tcontent">
  <tr>
    <td width="20%" height="23">流水号:<%=id%></td>
    <td width="25%">目前可用余额:</td>
    <td width="12%" align="right">&nbsp;	</td>
    <td width="12%" align="right"><input type="button" name="Submit" value="从其它单据拷贝(C)" accesskey="c" onClick="alt12();"></td>
  </tr>
</table>
<!--
<iframe name="f22m" src="move3_main.asp?<%=request.ServerVariables("QUERY_STRING")%>" width="100%" height="89%" frameborder="1"></iframe>
-->
<iframe name="f22m" src="two_input.asp?<%=request.ServerVariables("QUERY_STRING")%>" width="100%" height="89%" frameborder="1"></iframe>

<%else
  err.Raise 50001,"ADODB.EOF","对不起,先选择单据才能编辑!"
end if  
set ds=nothing
if err.number <> 0 then%>
<script language="javascript">
  alert("<%=err.description%>");
  //window.close();
</script>
<%end if%>
<script language="javascript">
  window.dialogHeight="510px";
</script>
</body>
</html>