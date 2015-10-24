<!-- #include file="inc/const.asp" -->
<%editpass="admin" '修改密码

select case request("act")
case "update" upda()
case "test" te()
case else main()
end select

sub upda()
  dim v
  
  if request("conn_pass1")<>editpass then
     response.write("<script>alert('修改密码不正确，您无权修改数据库连接！');window.close();</script>")
	 response.end
  end if
    
  conn_server=screnc(request("conn_server"))
  conn_name=screnc(request("conn_name"))
  conn_pass=screnc(request("conn_pass"))
  
  set connfile=server.CreateObject("scripting.filesystemobject")
  filename=server.MapPath("zhxoaconn.txt")
  set fso=connfile.createtextfile(filename)
  if err then
    response.write("数据库连接文件不存在！")
    response.end
  end if
  fso.writeline conn_server
  fso.writeline conn_name
  fso.writeline conn_pass
  fso.close
  set fso=nothing
  response.write("<script>alert('保存成功！')</script>")
  main()
end sub

sub te1()
  on error resume next
  cn_STRING ="Driver={SQL Server};Server="&request("a")&";Uid="&request("b")&";Pwd="&request("c")&";dataBase=master"
  set cn=server.CreateObject("adodb.connection")
  'cn.open cn_STRING
  if err then
     response.write("<script>alert('连接失败！');</script>")
  else
     response.write("<script>alert('连接成功！');</script>")
  end if
  cn.close
  set cn=nothing
  response.write("<script>window.close();</script>")
end sub

sub te()
  dim v
  v=testconn()
  if v then
     response.write("<script>alert('测试连接成功！');</script>")
  else
     response.write("<script>alert('测试连接失败！此连接不可用!');</script>")
  end if
  response.write("<script>window.close();</script>")
end sub

function testconn()
  on error resume next
  cn_STRING ="Driver={SQL Server};Server="&request("a")&";Uid="&request("b")&";Pwd="&request("c")&";dataBase=master"
  set cn=server.CreateObject("adodb.connection")
  cn.ConnectionString=cn_STRING
  cn.open 
  response.Write("正在测试连接，请稍等...")
  if err then
     testconn=false
  else
     testconn=true
  end if
  cn.close
  set cn=nothing
end function

sub main()%>
<html>
<head>
<title>ZHX_OA数据库连接设置</title>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<link href="skin/default/default.css" rel="stylesheet" type="text/css">
<script language="Javascript" src="copyright.js"></script>
<script language="JavaScript">
function check(theform,types)
{if (theform.conn_server.value=="")
     {alert("服务器不能为空！");theform.conn_server.focus();return false;}
if (theform.conn_name.value=="")
     {alert("用户名不能为空！");theform.conn_name.focus();return false;}
if (theform.conn_pass.value=="")
     {alert("密码不能为空！");theform.conn_pass.focus();return false;}
if(types=1)
  {if(theform.conn_pass1.value==""){alert("修改密码不能为空！");theform.conn_pass1.focus();return false;}}
if (confirm("需要要测试连接，可能会花几十秒钟，您在几十秒内将不能动弹！"))
   {return true;}
else
   {return false;}
}
function testConn(){
  if(check(document.form1,2)){
    showModalDialog('setconn.asp?act=test&a='+document.form1.conn_server.value+'&b='+document.form1.conn_name.value+'&c='+document.form1.conn_pass.value,'test','width=1,height=1')
  }
}
</script>
<base target="_self">
<style type="text/css">
<!--
body {
	background-color: #D2C0B9;
}
-->
</style></head>
<body onload="document.form1.conn_server.focus()">
<form name="form1" method="post" action="setconn.asp?act=update" onsubmit="return check(this,1)">
              <table width="200" border="0" align="center"><tr><td></td></tr></table>
  <table width="500" border="0" align="center" cellpadding="0" cellspacing="0">
    <tr>
      <td width="8"><img src="skin/default/image/bigbg_l.gif" width="8" height="61"></td>
      <td width="484" align="center" background="skin/default/image/bigbg_b.gif"><font size="5">数 据 库 连 接 设 置</font></td>
      <td width="10"><img src="skin/default/image/bigbg_r.gif" width="8" height="61"></td>
    </tr>
  </table>
              <table width="200" border="0" align="center"><tr><td></td></tr></table>
              <table width="500" height="200" border="0" align="center" class="tbgbklight">
                <tr> 
                  <td width="22%"><div align="right">服务器：</div></td>
                  <td width="78%"> <input name="conn_server" type="text" id="server" onKeyDown="if(event.keyCode==13)event.keyCode=9" size="18" maxlength="20"> 
                    <font color="#FF0000" size="2"> ( 系统数据库所在服务器，机器名或IP )</font> 
                  </td>
                </tr>
                <tr> 
                  <td><div align="right">用户名：</div></td>
                  <td> <input name="conn_name" type="text" id="conn_name2" onKeyDown="if(event.keyCode==13)event.keyCode=9" size="18" maxlength="20"> 
                    <font color="#FF0000" size="2">( 服务器SQL登录用户 )</font></td>
                </tr>
                <tr> 
                  <td><div align="right">密码：</div></td>
                  <td><input name="conn_pass" type="password" id="conn_pass2" onKeyDown="if(event.keyCode==13)event.keyCode=9" size="18" maxlength="20"> 
                    <font color="#FF0000" size="2">( 服务器SQL登录用户密码 )</font></td>
                </tr>
                <tr> 
                  <td><div align="right">修改密码：</div></td>
                  <td><input name="conn_pass1" type="password" id="conn_pass12" onKeyDown="if(event.keyCode==13)event.keyCode=9" size="18" maxlength="20"> 
                    <font color="#FF0000" size="2">( 修改连接所需密码 )</font></td>
                </tr>
  </table>
        <table width="283" height="43" border="0" align="center" cellspacing="0">
          <tr> 
			<td width="97" align="center">
                <input type="submit" name="Submit2" value=": 保 存 :" class=button1>
            </td>
            <td width="99" align="center"> 
                <input type="button" name="Submit" class=button1 onClick="javascript:window.close();" value=": 退 出 :">
            </td>
            <td width="97" align="center">
                <input type="button" name="button" value=": 测试连接 :" class=button1 onclick="testConn();">
            </td>
          </tr>
        </table>
</form>
</body>
</html>
<%end sub%>
