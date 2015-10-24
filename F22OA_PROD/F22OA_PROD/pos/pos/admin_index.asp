<!-- #include file="inc/const.asp" -->
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<title>ZHX_OA</title>
<link href="skin/default/default.css" rel="stylesheet" type="text/css">
<style type="text/css">
<!--
body {
	background-image: url(skin/default/image/login_bg.jpg);
}
-->
</style>
<script language="Javascript" src="copyright.js"></script>
<script language="Javascript">
function check(theform){
  if (theform.name.value==""){
    alert("用户名不能为空！");
	theform.name.focus();
	return false;
  }
  if (theform.pass.value==""){
    alert("密码不能为空！");
    theform.pass.focus();
	return false;
  }
  return true;
}
</script>
</head>
<body onLoad="document.form1.name.focus()">
<%On Error Resume Next
set connfile=server.CreateObject("scripting.filesystemobject")
filename=server.MapPath("zhxoaconn.txt")
set fso=connfile.opentextfile(filename)
if err then
   response.write("数据库连接文件不存在！")
   response.end
end if
conn_server=unscrenc(fso.readline)
conn_name=unscrenc(fso.readline)
conn_pass=unscrenc(fso.readline)
fso.close
set fso=nothing

set conn=server.CreateObject("adodb.connection") 
conn.open  "Driver={SQL Server};Description=sqldemo;SERVER="&conn_server&";UID="&conn_name&";Password="&conn_pass&";DATABASE=f18master" 
if err then
   response.write("数据库连接失败！<a href='javascript:void(null)' onFocus=this.blur()  onClick=""window.open('setconn.asp','set','width=550,height=350,top=200,left=200')"">请重新建立连接</a>")
   response.end
end if
set rs=server.createobject("adodb.recordset")
rs.open "select f18name,dbalia,f18pass from f18books",conn,1,1%>
<br>
<br>
<br><form name="form1" method="post" action="admin_index_login.asp" onsubmit="return check(this)">
  <center>
<div class="login"><B class=rtop><B class=r1></B><B class=r2></B><B class=r3></B><B class=r4></B></B>
<table width="500" border="0" align="center" class="tbg">
  <tr>
    <td align="center"><img src="skin/default/image/login1.gif" width="460" height="241"></td>
  </tr>
</table>
<table width="500" border="0" align="center" cellpadding="0" cellspacing="0" class="tbg">
      <tr>
        <td width="350" align="center"><table width="350" height="120" border="0" cellpadding="0" cellspacing="0">
            <tr>
              <td width="82" rowspan="2" align="center"><img src="skin/default/image/login.gif"></td>
              <td width="83" align="right"><font size="2">帐套名称：</font></td>
              <td width="185"><select name="books" onChange="document.form1.passzt.focus();" style="width:150px">
                  <%while not rs.eof%>
                  <option value="<%=trim(rs("dbalia"))%>"><%=trim(rs("f18name"))%></option>
                  <%rs.movenext
			                 wend
			                 rs.close
			                 set rs=nothing
							 conn.close
							 set conn=nothing%>
              </select></td>
            </tr>
            <tr>
              <td align="right"><font size="2">帐套密码：</font></td>
              <td><input type="password" name="passzt" onKeyDown="if(event.keyCode==13)event.keyCode=9" style="width:150px"></td>
            </tr>
            <tr>
              <td height="7" align="right"></td>
              <td align="right"></td>
              <td></td>
            </tr>
            <tr>
              <td rowspan="2" align="center"><img src="skin/default/image/pass.gif" width="40" height="43" border="0"> </td>
              <td align="right"><font size="2">操作员代码：</font></td>
              <td><input type="text" name="name" onKeyDown="if(event.keyCode==13)event.keyCode=9" style="width:150px"></td>
            </tr>
            <tr>
              <td align="right"><font size="2">操作员口令：</font></td>
              <td><input type="password" name="pass" style="width:150px"></td>
            </tr>
        </table></td>
        <td width="150" align="center"><table width="150" border="0" cellpadding="0" cellspacing="0">
            <tr>
              <td height="37" align="center">                <input name="Submit" type="submit" class="button" value="登 录">
              </td>
            </tr>
            <tr>
              <td height="37" align="center"> <input name="Submit" type="button" class="button" value="高 级"  onClick="showModalDialog('setconn.asp','set','dialogWidth:520px;dialogHeight:360px;center: yes;help:no;resizable:no;status:no;scroll:no')"></td>
            </tr>
            <tr>
              <td height="37" align="center"><input name="Submit" type="button" class="button" value="退 出" onClick="if(confirm('确定要退出吗？')){window.opener=null;window.close();}"></td>
            </tr>
        </table></td>
      </tr>
    </table>	
        <B class=rbottom><B class=r4></B><B class=r3></B><B class=r2></B><B class=r1></B></B></div>
</center></form>
</body>
</html>
