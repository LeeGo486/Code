<!-- #include file="setup.asp" -->
<%
act=HTMLEncode(request("act"))
baseid=RequestInt("baseid")
sid=RequestInt("sid")
Tname=HTMLEncode(request("tname"))
set Rs=server.createobject("adodb.recordset")
select case act
case "left"    call Flowleft
case "right"   call Flowright

case "leftadd"     call FlowLeftAdd
case "leftedit"    call FlowLeftEdit
case "leftinsert"  call FlowLeftInsert
case "leftupdate"  call FlowLeftUpdate
case "leftdel"     call FlowLeftDel

case "rightedit"    call FlowRightEdit
case "rightupdate"  call FlowRightUpdate
case "rightdel"     call FlowRightDel
case else Flowset
end select
set Rs=Nothing

Sub Flowset%>
<table width="100%" height="25" border="0" cellpadding="1" cellspacing="1" bgcolor="#3399ff" ID="Table1">
<tr valign="middle">
   <td nowrap onMouseMove="this.bgColor='#aaaaff'" onMouseOut="this.bgColor='cornsilk'"
			align="center" bgcolor="cornsilk" style="CURSOR: hand" onClick="location='flowset.asp?tname=<% =escape("流程定义")%>'" vAlign="baseline">
			<img src="../icon/menu/address.gif" width="16" height="16"> 流程定义</td>
   <td nowrap onMouseMove="this.bgColor='#aaaaff'" onMouseOut="this.bgColor='cornsilk'"
			align="center" bgcolor="cornsilk" style="CURSOR: hand" onClick="location='typeset.asp?tname=<% =escape("流程分类设置")%>'">
			<img src="../icon/menu/diary.gif" width="16" height="16"> 流程分类设置</td>
   <td nowrap onMouseMove="this.bgColor='#aaaaff'" onMouseOut="this.bgColor='cornsilk'"
			align="center" bgcolor="cornsilk" style="CURSOR: hand" onClick="location='stateset.asp?tname=<% =escape("紧急程度设置")%>'">
			<img src="../icon/menu/diary.gif" width="16" height="16"> 紧急程度设置</td>
</tr>
</table>
<table width="100%" border="0" cellpadding="1" cellspacing="1">
<tr><td></td></tr>
</table>
<table width="100%" height=430 border="0" cellpadding="1" cellspacing="1">
<tr height=430>
  <td width="50%"><iFrame Name=iFrmRef1 id=iFrmRef1 SRC="?act=left" width=100% height=100% scrolling="yes" frameborder="0"></iFrame></td>
  <td width="50%"><iFrame Name=iFrmRef2 id=iFrmRef2 SRC="?act=right" width=100% height=100% scrolling="yes" frameborder="0"></iFrame></td>
</tr>
</table>
<%End Sub

Sub Flowleft%> 
<script language="javascript">
function reflash(url){
window.parent.document.iFrmRef2.location=url;
}
</script>
<input type="button" name="button1" value=" 新 增 流 程 " class="CommonButton" onclick="ShowWin('?act=leftadd',450,150)">
<table width="400" border="0" cellpadding="1" cellspacing="1" ID=CommonListArea>
<tr align=center><td width=10%>序号</td><td width=20%>分类</td><td width=70%>流 程 名 称</td><td></td><td></td></tr>
<%rs.open "select a.baseid,b.typename,a.basename from o_base a,o_type b where a.typeid*=b.typeid order by a.typeid,a.baseid",conn,1,1
 while not rs.eof
     response.write("<tr bgColor='#E0F3FF' onMouseMove=""this.bgColor='#FFFFCC'"" onMouseOut=""this.bgColor='#E0F3FF'"">")
	 response.write("<td>"&rs("baseid")&"</td><td>"&rs("typename")&"</td><td><a href=""javascript:reflash('?act=right&baseid="&rs("baseid")&"')"">"&rs("basename")&"</a></td>")
	 response.write("<td><input type=button value='编辑' class=CommonButton onclick=""ShowWin('?act=leftedit&baseid="&rs("baseid")&"',450,150)""></td>")
	 response.write("<td><input type=button value='删除' class=CommonButton onclick=""document.location='?act=leftdel&baseid="&rs("baseid")&"'""></td></tr>")
     rs.movenext
 Wend
 rs.close%>
</table>
<%End Sub

Sub Flowright%>
<input type="button" name="button1" value=" 添 加 人 员 " class="CommonButton" 
     onclick="if(<%=baseid%>==0){alert('请先选择流程！')}else{ShowWin('selectuser.asp?baseid=<%=baseid%>',500,350)}">
<%rs.open "select basename from O_base where baseid="&baseid,conn,1,1
if not rs.eof then
   response.write("<div align=center style='background-color:#FFFFCC;height:20px'>"&rs("basename")&"</div>")
end if
rs.close%>
<table width="400" border="0" cellpadding="1" cellspacing="1" ID=CommonListArea>
<tr align=center><td width=30>顺序</td><td width=200>处理人员</td><td width=100>处理时间</td><td width=70>只需查阅</td><td></td><td></td></tr>
<%rs.open "select a.sid,a.baseid,a.orders,a.userid,c.department+'-'+b.username as username,a.cltime,a.ifedit from o_basesub a,j_user b,j_department c  "&_
          "where a.baseid="&baseid&" and ltrim(rtrim(a.userid))=ltrim(rtrim(b.userid)) and b.departid=c.departid order by a.orders",conn,1,1
 while not rs.eof
     response.write("<tr bgColor='#E0F3FF' onMouseMove=""this.bgColor='#FFFFCC'"" onMouseOut=""this.bgColor='#E0F3FF'"">")
	 response.write("<td>"&rs("orders")&"</td><td>"&rs("username")&"</td><td>"&rs("cltime")&" 小时</td>")
	 response.write("<td>")
	      if rs("ifedit")=1 then
		     response.write("√")
		  end if
	 response.write("</td>")
	 response.write("<td><input type=button value='编辑' class=CommonButton onclick=""ShowWin('?act=rightedit&baseid="&baseid&"&sid="&rs("sid")&"',300,300)""></td>")
	 response.write("<td><input type=button value='删除' class=CommonButton onclick=""document.location='?act=rightdel&baseid="&baseid&"&sid="&rs("sid")&"'""></td></tr>")
     rs.movenext
 Wend
 rs.close%>
</table>
<%End Sub

Sub FlowLeftAdd
rs.open "select typeid,typename from o_type",conn,1,1%>
<script language="javascript">
function check(theform){
if(theform.typeid.value==''){alert('请选择分类！');return false;}
if(theform.basename.value==''){alert('流程名称不能为空！');theform.basename.focus();return false;}
}
</script>
<div align=center>
<table>
<form name="form1" method="post" action="?act=leftinsert" onSubmit="return check(this)" target="hf">
<tr><td>分 类：</td><td><select size=1 name="typeid" class="CommonImageTextButton"><option></option>
<%while not rs.eof%>
<option value="<%=rs("typeid")%>"><%=rs("typename")%></option>
<%rs.movenext
wend%>
</select></td></tr>
<tr><td>流 程 名 称 ：</td><td><input type="text" name="basename" class="CommonImageTextButton" size=40></td></tr>
<tr><td colspan=2 align=center><input type="submit" name="submit" value=" 增 加 " class="CommonButton"></td></tr>
</form>
</table>
</div>
<%rs.close
End Sub

Sub FlowLeftEdit
rs.open "select typeid,basename from o_base where baseid="&baseid,conn,1,1
typeid=rs("typeid")
basename=rs("basename")
rs.close
rs.open "select typeid,typename from o_type",conn,1,1%>
<script language="javascript">
function check(theform){
if(theform.typeid.value==''){alert('请选择分类！');return false;}
if(theform.basename.value==''){alert('流程名称不能为空！');theform.basename.focus();return false;}
}
</script>
<div align=center>
<table>
<form name="form1" method="post" action="?act=leftupdate&baseid=<%=baseid%>" onSubmit="return check(this)" target="hf">
<tr><td>分 类：</td><td><select size=1 name="typeid" class="CommonImageTextButton"><option></option>
<%while not rs.eof%>
<option value="<%=rs("typeid")%>" <%if rs("typeid")=typeid then response.write("selected") end if%>><%=rs("typename")%></option>
<%rs.movenext
wend%>
</select></td></tr>
<tr><td>流 程 名 称 ：</td><td><input type="text" name="basename" class="CommonImageTextButton" size=40 value="<%=basename%>"></td></tr>
<tr><td colspan=2 align=center><input type="submit" name="submit" value=" 修 改 " class="CommonButton"></td></tr>
</form>
</table>
</div>
<%rs.close
End Sub

Sub FlowLeftInsert
  basename=HTMLEncode(request("basename"))
  typeid=RequestInt("typeid")
  conn.execute "insert into O_base (typeid,basename) values ("&typeid&",'"&basename&"')"
  call zclose
End Sub

Sub FlowLeftUpdate
  basename=HTMLEncode(request("basename"))
  typeid=RequestInt("typeid")
  conn.execute "update O_base set typeid="&typeid&",basename='"&basename&"' where baseid="&baseid
  call zclose
End Sub

Sub FlowLeftDel
  rs.open "select 1 from O_Threads where baseid="&baseid,conn,1,1
  if not rs.eof then
     call mbox("此流程已经使用，不能删除！")
  else
     conn.execute "delete from O_base where baseid="&baseid
  end if
  response.redirect "flowset.asp?act=left"
End Sub

'====================================================================================
Sub FlowRightEdit
rs.open "select a.sid,a.baseid,a.orders,a.userid,c.department+'-'+b.username as username,a.cltime,a.ifedit "&_
        "from o_basesub a,j_user b,j_department c where a.sid="&sid&" and a.userid=b.userid and b.departid=c.departid",conn,1,1%>
<script language="javascript">
function check(theform){
if(theform.orders.value==''){alert('顺序不能为空！');return false;}
if(theform.cltime.value==''){alert('处理时间不能为空！');theform.cltime.focus();return false;}
}
</script>
<div align=center>
<table height=200>
<form name="form1" method="post" action="?act=rightupdate&sid=<%=sid%>&baseid=<%=baseid%>" onSubmit="return check(this)" target="hf">
<tr><td>顺 序：</td><td><input type="text" name="orders" class="CommonImageTextButton" size=10 value="<%=rs("orders")%>" onKeypress="if (event.keyCode < 45 || event.keyCode > 57) event.returnValue = false;" onBlur="javascript:if(isNaN(this.value)){alert('数据类型错误！');this.focus();}this.value=Math.floor(this.value);"></td></tr>
<tr><td>处理人员：</td><td><%=rs("username")%></td></tr>
<tr><td>处理时间：</td><td><input type="text" name="cltime" class="CommonImageTextButton" size=10 value="<%=rs("cltime")%>" onKeypress="if (event.keyCode < 45 || event.keyCode > 57) event.returnValue = false;" onBlur="javascript:if(isNaN(this.value)){alert('数据类型错误！');this.focus();}"> 小时</td></tr>
<tr><td>只需查阅：</td><td><input type=checkbox name="ifedit" value="1" <%if round(rs("ifedit"))=1 then response.write("checked") end if%>></td></tr>
<tr><td colspan=2 align=center><input type=hidden name="oldorders" value="<%=rs("orders")%>"><input type="submit" name="submit" value=" 修 改 " class="CommonButton"></td></tr>
</form>
</table>
</div>
<%rs.close
End Sub

Sub FlowRightUpdate
  orders=RequestInt("orders")
  oldorders=RequestInt("oldorders")
  cltime=Request("cltime")
  ifedit=RequestInt("ifedit")
  if ifedit<>1 then ifedit=0 end if
  if orders<>oldorders then
     rs.open "select 1 from O_basesub where orders="&orders&" and baseid="&baseid,conn,1,1
	 if not rs.eof then
	    mbox("此顺序号已存在！")
	 end if
	 rs.close
  end if
  conn.execute "update O_basesub set orders="&orders&",cltime="&cltime&",ifedit="&ifedit&" where sid="&sid
  call zclose
End Sub

Sub FlowRightDel
  conn.execute "delete from O_basesub where sid="&sid
  response.redirect "flowset.asp?act=right&baseid="&baseid
End Sub

call CloseConn
call Footer%>