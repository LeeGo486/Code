<!-- #include file="setup.asp" -->
<%
act=HTMLEncode(request("act"))
StateID=RequestInt("Stateid")
Tname=HTMLEncode(request("tname"))
set Rs=server.createobject("adodb.recordset")
select case act
case "add"  StateAdd
case "edit" StateEdit
case "del"  StateDel

case "insert" StateInsert
case "update" StateUpdate
case else   StateSet
end select
set Rs=Nothing

Sub StateSet%>
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
<tr><td>流程定义 -> <%=Tname%></td></tr>
</table>
<input type="button" name="button1" value=" 新 增 " class="CommonButton" onclick="ShowWin('?act=add',300,150)"><hr size=1>
<table width="500" border="0" cellpadding="1" cellspacing="1" ID=CommonListArea>
<tr><td width=200>顺 序</td><td width=200>名 称</td><td width=50></td><td width=50></td></tr>
<%rs.open "select stateid,orders,statename,color from o_state order by orders",conn,1,1
  while not rs.eof
     response.write("<tr bgColor='#E0F3FF' onMouseMove=""this.bgColor='#FFFFCC'"" onMouseOut=""this.bgColor='#E0F3FF'"">")
	 response.write("<td>"&rs("orders")&"</td><td><font color='"&rs("color")&"'>"&rs("statename")&"</font></td>")
	 response.write("<td><input type=button value='编辑' class=CommonButton onclick=""ShowWin('?act=edit&stateid="&rs("stateid")&"',300,180)""></td>")
	 response.write("<td><input type=button value='删除' class=CommonButton onclick=""document.location='?act=del&stateid="&rs("stateid")&"'""></td></tr>")
     rs.movenext
  Wend
  rs.close%>
</table>
<%End Sub

Sub StateAdd%>
<script language="javascript">
function check(theform){
if(theform.statename.value==''){alert('名称不能为空！');theform.statename.focus();return false;}
if(theform.color.value==''){alert('颜色不能为空！');theform.color.focus();return false;}
}
</script>
<SCRIPT>
var sInitColor = null;
function callColorDlg(){
if (sInitColor == null) 
	var sColor = dlgHelper.ChooseColorDlg();
else
	var sColor = dlgHelper.ChooseColorDlg(sInitColor);
		sColor = sColor.toString(16);	
if (sColor.length < 6) {
  var sTempString = "000000".substring(0,6-sColor.length);
  sColor = sTempString.concat(sColor);
}
sColor = "#" + sColor
//alert(sColor);	
document.form1.color.value=sColor;
}
</SCRIPT>
<OBJECT id=dlgHelper height=0px width=0px classid=clsid:3050f819-98b5-11cf-bb82-00aa00bdce0b></OBJECT>
<div align=center>
<form name="form1" method="post" action="?act=insert" onSubmit="return check(this)" target="hf">
名 称 ：<input type="text" name="statename" class="CommonImageTextButton"><br>
颜 色 ：<input type="text" name="color" class="CommonImageTextButton"><br><br>
<input type="button" name="button1" value="选择颜色" class="CommonButton" onclick=callColorDlg()>
<input type="submit" name="submit" value=" 增 加 " class="CommonButton">
</form>
</div>
<%End Sub

Sub StateEdit
rs.open "select orders,statename,color from O_state where stateid="&stateid,conn,1,1%>
<script language="javascript">
function check(theform){
if(theform.statename.value==''){alert('名称不能为空！');theform.statename.focus();return false;}
if(theform.color.value==''){alert('颜色不能为空！');theform.color.focus();return false;}
}
</script>
<SCRIPT>
var sInitColor = null;
function callColorDlg(){
if (sInitColor == null) 
	var sColor = dlgHelper.ChooseColorDlg();
else
	var sColor = dlgHelper.ChooseColorDlg(sInitColor);
		sColor = sColor.toString(16);	
if (sColor.length < 6) {
  var sTempString = "000000".substring(0,6-sColor.length);
  sColor = sTempString.concat(sColor);
}
sColor = "#" + sColor
//alert(sColor);	
document.form1.color.value=sColor;
}
</SCRIPT>
<OBJECT id=dlgHelper height=0px width=0px classid=clsid:3050f819-98b5-11cf-bb82-00aa00bdce0b></OBJECT>
<div align=center>
<form name="form1" method="post" action="?stateid=<%=stateid%>&act=update" onSubmit="return check(this)" target="hf">
顺 序 ：<input type="text" name="orders" class="CommonImageTextButton" value="<%=rs("orders")%>" onKeypress="if (event.keyCode < 45 || event.keyCode > 57) event.returnValue = false;" onBlur="javascript:if(isNaN(this.value)){alert('数据类型错误！');this.focus();}this.value=Math.floor(this.value);"><br>
名 称 ：<input type="text" name="statename" class="CommonImageTextButton" value="<%=rs("statename")%>"><br>
颜 色 ：<input type="text" name="color" class="CommonImageTextButton" value="<%=rs("color")%>"><br><br>
<input type="hidden" name="oldorders" value="<%=rs("orders")%>">
<input type="button" name="button1" value="选择颜色" class="CommonButton" onclick=callColorDlg()>
<input type="submit" name="submit" value=" 修  改 " class="CommonButton">
</form>
</div>
<%rs.close
End Sub

Sub StateInsert
  Statename=HTMLEncode(request("statename"))
  Color=HTMLEncode(request("color"))
  rs.open "select isnull(max(orders),0) as maxorders from O_state",conn,1,1
  maxorders=round(rs("maxorders"))+1
  rs.close
  conn.execute "insert into O_state (orders,statename,color) values ("&maxorders&",'"&statename&"','"&Color&"')"
  call zclose
End Sub

Sub StateUpdate
  Statename=HTMLEncode(request("statename"))
  Color=HTMLEncode(request("color"))
  orders=RequestInt("orders")
  oldorders=RequestInt("oldorders")
  if orders<>oldorders then
     rs.open "select 1 from O_state where orders="&orders,conn,1,1
	 if not rs.eof then
	    mbox("此顺序号已存在！")
	 end if
	 rs.close
  end if
  conn.execute "update O_state set orders="&orders&",statename='"&statename&"',color='"&Color&"' where stateid="&stateid
  call zclose
End Sub

Sub StateDel
  rs.open "select 1 from O_Threads where state="&stateid,conn,1,1
  if not rs.eof then
     call mbox("此档案已经使用，不能删除！")
  else
     conn.execute "delete from O_state where stateid="&stateid
  end if
  response.redirect "stateset.asp"
End Sub

call CloseConn
call Footer%>