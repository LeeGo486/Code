<!-- #include file="setup.asp" -->
<%
act=HTMLEncode(request("act"))
typeID=RequestInt("typeid")
Tname=HTMLEncode(request("tname"))
set Rs=server.createobject("adodb.recordset")
select case act
case "add"  TypeAdd
case "edit" TypeEdit
case "del"  TypeDel

case "insert" TypeInsert
case "update" TypeUpdate
case else   TypeSet
end select
set Rs=Nothing

Sub TypeSet%>
<table width="100%" height="25" border="0" cellpadding="1" cellspacing="1" bgcolor="#3399ff" ID="Table1">
<tr valign="middle">
   <td nowrap onMouseMove="this.bgColor='#aaaaff'" onMouseOut="this.bgColor='cornsilk'"
			align="center" bgcolor="cornsilk" style="CURSOR: hand" onClick="location='flowset.asp?tname=<% =escape("���̶���")%>'" vAlign="baseline">
			<img src="../icon/menu/address.gif" width="16" height="16"> ���̶���</td>
   <td nowrap onMouseMove="this.bgColor='#aaaaff'" onMouseOut="this.bgColor='cornsilk'"
			align="center" bgcolor="cornsilk" style="CURSOR: hand" onClick="location='typeset.asp?tname=<% =escape("���̷�������")%>'">
			<img src="../icon/menu/diary.gif" width="16" height="16"> ���̷�������</td>
   <td nowrap onMouseMove="this.bgColor='#aaaaff'" onMouseOut="this.bgColor='cornsilk'"
			align="center" bgcolor="cornsilk" style="CURSOR: hand" onClick="location='stateset.asp?tname=<% =escape("�����̶�����")%>'">
			<img src="../icon/menu/diary.gif" width="16" height="16"> �����̶�����</td>
</tr>
</table>
<table width="100%" border="0" cellpadding="1" cellspacing="1">
<tr><td>���̶��� -> <%=Tname%></td></tr>
</table>
<input type="button" name="button1" value=" �� �� " class="CommonButton" onclick="ShowWin('?act=add',300,100)"><hr size=1>
<table width="500" border="0" cellpadding="1" cellspacing="1" ID=CommonListArea>
<tr><td width=200>�� ��</td><td width=200>��������</td><td width=50></td><td width=50></td></tr>
<%rs.open "select typeid,typename from o_type order by typeid",conn,1,1
  while not rs.eof
     response.write("<tr bgColor='#E0F3FF' onMouseMove=""this.bgColor='#FFFFCC'"" onMouseOut=""this.bgColor='#E0F3FF'"">")
	 response.write("<td>"&rs("typeid")&"</td><td>"&rs("typename")&"</td>")
	 response.write("<td><input type=button value='�༭' class=CommonButton onclick=""ShowWin('?act=edit&typeid="&rs("typeid")&"',300,100)""></td>")
	 response.write("<td><input type=button value='ɾ��' class=CommonButton onclick=""document.location='?act=del&typeid="&rs("typeid")&"'""></td></tr>")
     rs.movenext
  Wend
  rs.close%>
</table>
<%End Sub

Sub TypeAdd%>
<script language="javascript">
function check(theform){
if(theform.typename.value==''){alert('�������Ʋ���Ϊ�գ�');theform.typename.focus();return false;}
}
</script>
<div align=center>
<form name="form1" method="post" action="?act=insert" onSubmit="return check(this)" target="hf">
�������� ��<input type="text" name="typename" class="CommonImageTextButton"><br><br>
<input type="submit" name="submit" value=" �� �� " class="CommonButton">
</form>
</div>
<%End Sub

Sub TypeEdit
rs.open "select typename from O_type where typeid="&typeid,conn,1,1%>
<script language="javascript">
function check(theform){
if(theform.typename.value==''){alert('�������Ʋ���Ϊ�գ�');theform.typename.focus();return false;}
}
</script>
<div align=center>
<form name="form1" method="post" action="?typeid=<%=typeid%>&act=update" onSubmit="return check(this)" target="hf">
�������� ��<input type="text" name="typename" class="CommonImageTextButton" value="<%=rs("typename")%>"><br><br>
<input type="submit" name="submit" value=" ��  �� " class="CommonButton">
</form>
</div>
<%rs.close
End Sub

Sub TypeInsert
  Typenames=HTMLEncode(request("typename"))
  conn.execute "insert into O_type (typename) values ('"&typenames&"')"
  call zclose
End Sub

Sub TypeUpdate
  Typenames=HTMLEncode(request("typename"))
  conn.execute "update O_type set typename='"&typenames&"' where typeid="&typeid
  call zclose
End Sub

Sub TypeDel
  rs.open "select 1 from O_base where typeid="&typeid,conn,1,1
  if not rs.eof then
     call mbox("�˷����Ѿ�ʹ�ã�����ɾ����")
  else
     conn.execute "delete from O_type where typeid="&typeid
  end if
  response.redirect "typeset.asp"
End Sub

call CloseConn
call Footer%>