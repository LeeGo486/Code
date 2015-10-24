<!-- #include file="setup.asp" -->
<!--#include file="ZHXeditor/fckeditor.asp" -->
<%set rs=server.createobject("adodb.recordset")%>
<table width="100%" height="25" border="0" cellpadding="1" cellspacing="1" bgcolor="#3399ff" ID="Table1">
<tr valign="middle">
   <td nowrap onMouseMove="this.bgColor='#aaaaff'" onMouseOut="this.bgColor='cornsilk'"
			align="center" bgcolor="cornsilk" style="CURSOR: hand" onClick="location='flowcheck.asp'" vAlign="baseline">
			<img src="../icon/menu/diary.gif" width="16" height="16"> 流程审批</td>
   <td nowrap onMouseMove="this.bgColor='#aaaaff'" onMouseOut="this.bgColor='cornsilk'"
			align="center" bgcolor="cornsilk" style="CURSOR: hand" onClick="location='flownewadd.asp'" vAlign="baseline">
			<img src="../icon/menu/address.gif" width="16" height="16"> 新建审批</td>
</tr>
</table>
<script>
function ChkForm(_T){
	if(_T.typeid.value=='xxx'){
	alert('请选择流程分类！');
	return false;
	}else if(_T.baseid.value==''){
	alert('请选择流程方案！');
	return false;
	}else if(_T.title.value.length<=0){
	alert('请填写主题！');
	_T.title.focus();
	return false;
	}
}
</script>

<script language=JavaScript>
<%set rs_type=createobject("adodb.recordset")
rs_type.open "select typeid,typename from O_type",conn,1,1%>
var selects=[];
selects['xxx']=new Array(new Option('请选择分类……','xxx'));
<%for i=1 to rs_type.recordcount%>
selects['<%=rs_type("typeid")%>']=new Array(
<%set rs_City=server.createobject("adodb.recordset")
rs_City.open "select baseid,basename from O_base where typeid="&rs_type("typeid"),conn,1,1
if rs_City.recordcount>0 then 
  for j=1 to rs_City.recordcount
      if j=rs_City.recordcount then %>
        new Option('<%=trim(rs_City("basename"))%>','<%=trim(rs_City("baseid"))%>'));
    <%else%>
        new Option('<%=trim(rs_City("basename"))%>','<%=trim(rs_City("baseid"))%>'),
    <%end if
  rs_City.movenext
  next
else%>
  new Option('','0'));
<%
end if
rs_City.close
set rs_City=nothing
rs_type.movenext
next
rs_type.close
set rs_type=nothing%>
 
function chsel(){
  with (document.form1){
           if(typeid.value) {
                baseid.options.length=0;
                for(var i=0;i<selects[typeid.value].length;i++){
                     baseid.add(selects[typeid.value][i]);
    }
   }
  }
 }

</script>


<div id="CommonBody">
<form name="form1" method="post" action="flowsave.asp" onSubmit="return ChkForm(this)">
<input type="hidden" name="typ" value="newadd">
<table cellspacing=1 cellpadding=5 border=0 align=center id=CommonListArea  width=100%>
	<TR id=CommonListTitle>
		<TD vAlign=Left colSpan=4>新建审批文档</TD>
	</TR>
	<TR id=CommonListCell>
        <TD width="70" class="CommonListTi">流程分类</TD>
        <TD><%ShowSelect 1%></TD>
        <TD class="CommonListTi">紧急程度</TD>
        <TD width="200"><%ShowState%></TD>
	</TR>
	<TR id=CommonListCell>
        <TD width="70" class="CommonListTi">流程方案</TD>
        <TD colSpan=3><%ShowSelect 2%></TD>
	</TR>
	<TR id=CommonListCell>
        <TD width="70" class="CommonListTi">主 题</TD>
        <TD colSpan=3><input type="text" name="title" size=70></TD>
	</TR>
	<TR id=CommonListCell>
		<TD vAlign=top class="CommonListTi"><br>文档描述</TD>
		<TD height=250 colspan="3">
			<%
            Dim oFCKeditor
            Set oFCKeditor = New FCKeditor
            oFCKeditor.BasePath = "ZHXeditor/"
            oFCKeditor.ToolbarSet = "Default"
            oFCKeditor.height = 260
            oFCKeditor.Value = ""
            oFCKeditor.Create "content"
            %>
		</TD>
    </TR>
	<TR id=CommonListCell>
		<TD align=center colSpan=4><INPUT type="submit" value=" 提交 " name="EditSubmit">
        　<INPUT onClick="history.back()" type="button" value=" 取消 "></TD>
	</TR>
</TABLE>
</FORM>
</DIV>
<%
Sub ShowSelect(n)
if n=1 then
  rs.open "select typeid,typename from O_type",conn,1,1
  response.write("<select name='typeid' onChange=chsel()>")
  response.write("<option value='xxx' selected>请选择分类……</option>")
  while not rs.eof
     response.write("<option value='"&rs("typeid")&"'>"&rs("typename")&"</option>")
  rs.movenext
  wend
  rs.close
  response.write("</select>")
else
  'rs.open "select baseid,basename from O_base",conn,1,1
  response.write("<select name='baseid'>")
  'while not rs.eof
  '   response.write("<option value='"&rs("baseid")&"'>"&rs("basename")&"</option>")
  'rs.movenext
  'wend
  'rs.close
  response.write("</select>")
end if
End Sub

Sub ShowState
  rs.open "select stateid,statename from O_state",conn,1,1
  response.write("<select name='stateid'>")
  while not rs.eof
     response.write("<option value='"&rs("stateid")&"'>"&rs("statename")&"</option>")
  rs.movenext
  wend
  rs.close
  response.write("</select>")
End Sub

set rs=nothing
call CloseConn
call Footer%>
