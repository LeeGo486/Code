<%Response.Expires=-1000%>
<!--#include file="inc/function.asp"-->
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<link href="css/main.css" rel="stylesheet" type="text/css">
<meta http-equiv="refresh" content="100">
<title></title>
</head>
<style type="text/css">
.tbhide{display:none;}
.tbshow{display:block;font-size:10pt;}

</style>
<script language="javascript">
function tb(tname,mname){
  var t=document.all.item(tname);
  var m=document.all.item(mname);
  if(t.className=="tbhide")
    {m.innerHTML="<img src=\'../skin/<%=session("skindir")%>/image/tree_minus.gif\' height=18>";
	 t.className="tbshow";}
  else
    {m.innerHTML="<img src=\'../skin/<%=session("skindir")%>/image/tree_plus.gif\' height=18>";
    t.className="tbhide";}
}
function com(str){
  var s=str.split("-");
  var h="index.asp?stype=2&com="+s[1]+"&action=search&ext="+s[0];
  //alert(h);
  window.parent.location.href="index.asp?stype=2&com="+s[1]+"&action=search&ext="+s[0];
}
</script>

<body topmargin=0 leftmargin="0">
<%
'de session("dm").System_parentid
set cd =server.CreateObject("ADODB.Command")
cd.Activeconnection=cn
cd.Commandtype=4
cd.CommandText="f22qry_jmautouser"
cd.Parameters.Append cd.CreateParameter("@userid",adVarchar,adParamInput,10,session("dm").System_userid)
cd.Parameters.Append cd.CreateParameter("@parentid",adVarchar,adParamInput,10,session("dm").System_parentid)
cd.Parameters.Append cd.CreateParameter("@lx",adInteger,adParamInput,10,0)
set rs=cd.execute

'set rs=server.createobject("adodb.recordset")
'rs.open "f22qry_autouser '"&session("dm").System_userid&"',0",cn
i=0
dim node,pnode,pb,ppb,title,ptitle

if not rs.eof then
 node=rs("worktype")
while not rs.eof
   pnode=rs("worktype")
   ppb=rs("powerbillid")
   ptitle=rs("title")%>
<%if i=0 then
   i=i+1%>
  <table border="0" cellspacing="0" cellpadding="0" id="tb<%=i%>" class="f12">
  <tr>
    <td id="head<%=i%>"><img src="../skin/<%=session("skindir")%>/image/tree_minus.gif" height="18"></td>
    <td height="18"><a href="javascript:tb('tbs<%=i%>','head<%=i%>');" onFocus="this.blur();"><%=pnode%></a></td>
  </tr>
  </table>
  <table border="0" cellspacing="0" cellpadding="0" id="tbs<%=i%>" class="f12">
<%end if%>
 <%if node<>pnode then
   i=i+1%>
  </table>
  <table border="0" cellspacing="0" cellpadding="0" id="tb<%=i%>" class="f12">
  <tr>
    <td id="head<%=i%>"><img src="../skin/<%=session("skindir")%>/image/tree_minus.gif" height="18"></td>
    <td height="18"><a href="javascript:tb('tbs<%=i%>','head<%=i%>');" onFocus="this.blur();"><%=pnode%></a></td>
  </tr>
  </table>
  <table border="0" cellspacing="0" cellpadding="0" id="tbs<%=i%>" class="f12">
  <tr>
    <td><img src="../skin/<%=session("skindir")%>/image/tree_line.gif" height="18"></td>
	<td><img src="../skin/<%=session("skindir")%>/image/tree_blank.gif" height="18"></td>
    <td height="18"><a href="javascript:com('<%=pnode&"-"&ppb%>')" onFocus="this.blur();"><%=ppb&" "&ptitle%></a></td>
  </tr>
 <%else%>
 <tr>
    <td><img src="../skin/<%=session("skindir")%>/image/tree_line.gif" height="18"></td>
	<td><img src="../skin/<%=session("skindir")%>/image/tree_blank.gif" height="18"></td>
    <td height="18"><a href="javascript:com('<%=pnode&"-"&ppb%>')" onFocus="this.blur();"><%=ppb&" "&ptitle%></a></td>
  </tr>
 <%end if%>
<%node=pnode
rs.movenext
wend
end if
rs.close
set rs=nothing
cn.close
set cn=nothing
sub showimg(t,m)
if t<m then response.Write("tree_blank.gif") else response.Write("tree_blankl.gif") end if
end sub%>

</body>
</html>
